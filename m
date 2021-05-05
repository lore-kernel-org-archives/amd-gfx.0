Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A58C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C587613BE
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C587613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46526E4EA;
	Wed,  5 May 2021 18:38:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6640A6E4EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 18:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nokSKnp18OmWo5tEIOauUiY2Bj2ivCd9uq6/PJo4QbtWNIVu2+TnPVszYmB22ekm5B1/b5tQOYog19FPa6Adm6HAG86SbNd/Vh5Y+aZqy/mpk//MjbJxCAwTf06roZHq6gb/bNbEXAF40iezdT7XKp7lQ1TD6dhQecVM22JMXrlgTkoEVlffEam3dqa5H21O7Zv2pIH/GZUjH2tybF5ltf/BGQ2DG44tYKVr3sXuWiPKNEGHwvh661TIXXRMNLgKR2LSCWZw/sbnPZkujIRDeYrDOJ+sQ/cRwRVxoqif3gNSr4aD+0gxt5jm/lw9xJQ0TdnushOb8KTmjGN1Ip6y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giboOoks4AdKeHjKoTucxtCx0gElX5fVjITIMv71etQ=;
 b=MHLJ6X2Ju8SulKplQO2SPNfczxSHQmFwGu8AsBWyN2rIX6D6bfmREQEKR4T6KKGKol5Y+Qo4pXl6zMDbkbDXSLQZHACky4mp3Kk1mew8ZQIsCJMT66TgbCvvHO8yOAm2AR3Fm/XnDq/QHR5QIlVERZ52wKZg5XhKScIyzYk/F/tnOO/t9mC7GRoIG6ZWZRX/KsreV+LDxjYoikaVc9wyu/9syN5mxJKEH8o8ZZ7m/2992aOzDM3ry2w6nKAHtE8K8pA9O5JhVsfUpXB6w/nWUIvWbvCuG+YMGo+Tp3zPdxjG6ezV4XKXYUv32pRfLGw74nccBwssPKxX6Jp1vbaK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giboOoks4AdKeHjKoTucxtCx0gElX5fVjITIMv71etQ=;
 b=lAkaWRa3Sr91sbSmDRjOcnSBp7Tf6qwQTvhh5lKI3O/s4Kn2QXqPz/Zrhcap3jvy9gnySkfpIo723mp90KOMD9Oer1VEMwzSgO8iWw9+cMmbzY1eGZAvj2d/8VhNDxBJY/wBs0YqXYZKiVk2+lgd8MqE6srAB34qNwVSNvZVaDE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4985.namprd12.prod.outlook.com (2603:10b6:5:16d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 18:38:56 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab%3]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:38:56 +0000
Subject: Re: [PATCH] drm/amdgpu: Init GFX10_ADDR_CONFIG for VCN v3 in DPG mode.
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210505012749.1803406-1-bas@basnieuwenhuizen.nl>
 <f9ef6f14-8f59-9b41-2b65-6191ddb3097c@amd.com>
 <CADnq5_PmR6e-0Q=3nx-9O8EtHoHKdBdvjpWWssHs64LLyyjZ0g@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <de28ad28-03b0-165c-7afe-658d93f5310e@amd.com>
Date: Wed, 5 May 2021 14:38:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_PmR6e-0Q=3nx-9O8EtHoHKdBdvjpWWssHs64LLyyjZ0g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:e9a3:7447:e8de:9f4]
X-ClientProxiedBy: YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:e9a3:7447:e8de:9f4]
 (2607:9880:2088:19:e9a3:7447:e8de:9f4) by
 YTBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Wed, 5 May 2021 18:38:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82bdbd3-efe4-4e82-d76a-08d90ff50a6c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4985C4A4329F5D70AAD004FAE5599@DM6PR12MB4985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHOShgG0jp4Sona+lsXaeK92fymn6pRIpN6vbA1DeqasqeGKodnrBAZ6/P8lYTsJZ6ALsossEUpTZqU0liTIykyxhYeyXN97+uz7Gb3LlZSozACrSHWkfRYtidw009PdGOdHqGG1x9QdoPtrkNKzgPEAYTb8Xji+c/tK9/nwFGiCYJpR/Gw1hxJrm4dOBUFIPD1Zh+NTgsIBKbHRUgh4HfZHPUAfrZG10LYa2u/L/y7nObpnY0Zvh3S3RW0nKiJo816dRJsGxH5VxeJSo5XvnrD+XG/azDLrKSFdUbB6JWc6h+XhJE4+F6DIE/YAscCE5A10jQjjqo5+GgfJRtEFbUK5cbEVtrvIrJqHpK0X7eKpB+OO4Ym+mCLzJTC8WJY2PxuhhnPOQsCfSXFZOfwh42npMh2ADWG6CFp/O7AFb9mOwrXzJyO6Q45cRpCu0gvq9H8clPzheP+gJs+ToJolfAhY13J5J5i40rdcRzKqJIrLvZKXxdbXIEsFw6YwcpNsr/rm0mbNuPINmqJG0VxJtvGbLUmkY6SjNqZtnoRt7ixg9bvQEOeXC0kGrvDRf2peFDhaLftzjPxn/by1DPB9Zg+1N2ffjrh/NI26vBw5LJXHDdNvRS51eGeMK+rNeuWJRoQcsqJ+oiyuq3kzyQKOhl/dAP7aGJN9m4XtkJmSWt9xj/irj1XPehY29VcCLc+B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(54906003)(44832011)(5660300002)(316002)(8936002)(8676002)(38100700002)(36756003)(6486002)(478600001)(2906002)(52116002)(2616005)(66476007)(31686004)(4326008)(6916009)(66946007)(16526019)(53546011)(66556008)(31696002)(86362001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amo5YkZtcVZwUXUrRFNNK1VzY2pYNW5Wc0MvdnYwTndHeGxJa3pRQ3B2ekRa?=
 =?utf-8?B?Ym1NcEhYbkw0aTIrK01FQk94Qk5rYm5qWnVaYWU2KzJXc3BTTndjVm03K09Q?=
 =?utf-8?B?WHNrc25Cd1VLV0hPSUdENUx0VVlsKy9INDdoanNiUHFWVStzdGZMVFp6T0Mv?=
 =?utf-8?B?T1k5ODdKU1g1WjdyTWhrU3JZSGM1dFNiY1Y1dHB6dElsekNTTmVWQWUwYnZO?=
 =?utf-8?B?eHFodVoybjNpZ05TSjJNY2tPc0RCam1yWE85TlI1dThFZFUxdHJ1cVI1RkZV?=
 =?utf-8?B?a1g5L28zTmhLWXFuYlk5ZjFYd1BzZlJjKzZHL2VDSEN3UUJzM3gvRWlPTHI3?=
 =?utf-8?B?L21YN25JeW8vSkVNNk1WNzJtVEh3ay9rVnBVWTBhakhzby9iR0swd0o1Vjgz?=
 =?utf-8?B?SUVIQzYvMkdscm9PR3VKSnVHVzYrZndOWlZlZXZCVmkwbjJoQnVnWFlOTnNX?=
 =?utf-8?B?VisvOTJhaFVSVHlZTzE4SnhsUEg5c3pIODZ1SEw0N0tVbm05aUJML1IwZ2lh?=
 =?utf-8?B?ZkkvQ0psU2VQVFNFckpndTlBaEoxUXRlbFowUEtneGVESXlTczBXSVhrL3kz?=
 =?utf-8?B?MmpiY2pnb3JrTDNkZ2FkU3paaVRqVXdWK2tnY1VPTW9OeC94Y1lwMlV0cGFs?=
 =?utf-8?B?RjM4MlZ3TVN6NnJJQlcxM0doU0Y1blZDRHZvelVBK3hNeDJsdWJYYURhTTVJ?=
 =?utf-8?B?a25pdnMwbjVEQXM5clpoT0hqUms1cXBTSzJ5d0dzRFRkZFd2YW8zcUcrY3Fk?=
 =?utf-8?B?eGs1dlBwRXE2djZITWlxUjdzdk9BR3NKV2tJMVdueTNFTVlrazhENFV1dXJu?=
 =?utf-8?B?UURNb2kyUWVzVWt2S2pWSCtSYk9uWWtxdTlPWjZIQTA3bUNhWU5LSDNoM0JT?=
 =?utf-8?B?dGpEajRwSkU4azVidFgrODVlMVdBYzhFNFkvS3kyMDdqemNvWCtjdkVrbWtB?=
 =?utf-8?B?Y3dqeUI2am4rU211UkNYSVRsREpLdzlkYzZEaFNWZlViZkdJSjIrd1Nsb0l4?=
 =?utf-8?B?QTJzR2ZxMmpzbG54RE1NK0wrTmwvK3FlUjMrenlPNE42R0p1TklmTGMxQUMz?=
 =?utf-8?B?Q0pESHo1Q3A5RmFYeExvYlVqbHc3MWpWUTNBUS8vK3BUbWlTdXhTZ2VuQ2Fk?=
 =?utf-8?B?aGtwSVN1bTJxSVllVWxJWFZOQVRtdmZ3cjk4WkhGek1leExhL3YrRzBYTFpt?=
 =?utf-8?B?REtkUTlTZ1VmNlNZY0gxbVpzY0ZZU2Y1a2h4c3llSDFPbUdialVhT0dybmZQ?=
 =?utf-8?B?NlJhT0NJZ1YzY0YvT2YzSGd4eDU1cjFjY25FTFJ5WVkrZnpUOHRrRlRFNXVu?=
 =?utf-8?B?aFRJaDYvY0VGcHp0ZE9tZEdNSGlneGtsZ1Fac0NTMVFvYzJ3ZFFHeVZEdUEy?=
 =?utf-8?B?ZklJYmlORmo0RnNDOXRoM2NoVXlYSm9SOFIrbFlwN09YTmlNZm9WZlpOOW4r?=
 =?utf-8?B?KzJjT1EwdmtrTkFrRWd1UnZ6Y3BtWHIzcmV1R3lHNldCQXBjYUhFblNJZ0Ji?=
 =?utf-8?B?aWdoVEFVTVhEWnlkQ2pZa3g1M0ZnODhGOExDVGZmWFJJZURLVFJNc2xPdldK?=
 =?utf-8?B?WmUvQW1TYXlNcUU5RnVQTzZmb29qTXI3NEdKM3FYbHFkMm9Ra29oa2JtcWZk?=
 =?utf-8?B?cWM3U3F5VHcxWVhDNDlHYmMvSDhZUXZvSzFHd0dhL2djZHNBZG5QcXpNa011?=
 =?utf-8?B?L015ZnJrdTVtRkp0ZS8yOTdjZGUwUDhZTDcxelJXV2ZmVDZDdDBtRFQ1a21t?=
 =?utf-8?B?WDN4SHJVck01TnhMb2tBS3hhTUIzRTd0bkFQSGk2SUNpRlFDbG9IbWorV3Ru?=
 =?utf-8?B?d2ZBemdNMk03Y2IxOXZMM3J3cjlaV0t6d1ZXRjJra0pOc1c2cEczTXRac1Rj?=
 =?utf-8?Q?WTM9lADwBgzV6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82bdbd3-efe4-4e82-d76a-08d90ff50a6c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:38:56.8014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r9mm5yFlUPHT3QS3BES8kT+7HEjrWSgeEd53eCPYX/OcrQqPTUD+CSgRozxlMpu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4985
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-05-05 2:17 p.m., Alex Deucher wrote:
> Applied.  Thanks!  Do we need a similar fix for other VCN variants?

VCN3 is the only one missing that.

Regards,

Leo


>
> Alex
>
> On Tue, May 4, 2021 at 10:14 PM Leo Liu <leo.liu@amd.com> wrote:
>> Reviewed-and-Tested by: Leo Liu <leo.liu@amd.com>
>>
>> On 2021-05-04 9:27 p.m., Bas Nieuwenhuizen wrote:
>>> Otherwise tiling modes that require the values form this field
>>> (In particular _*_X) would be corrupted upon video decode.
>>>
>>> Copied from the VCN v2 code.
>>>
>>> Fixes: 99541f392b4d ("drm/amdgpu: add mc resume DPG mode for VCN3.0")
>>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index 3f15bf34123a..cf165ab5dd26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -589,6 +589,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>>>        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>>>                        VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0),
>>>                        AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
>>> +
>>> +     /* VCN global tiling registers */
>>> +     WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
>>> +             UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>>>    }
>>>
>>>    static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
