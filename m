Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF74C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 13:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB1614ADEE;
	Mon, 18 Jul 2022 13:48:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E532811BFC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 13:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQr63s77IJkjqcXvXCANzZa/8Dwg7lrpjO6AKGIxNBftl6GiNEhZerOJGbcVAigj33fZq08FqYCbMXQKL/s9qNsYW2MnGQ+cimEX4fwuIcf/rgDrNTcpLDUNSTFnRLkAKHXZHCiqy00AJnoMKsL2ecSo9vEI953O48JHqaSweYLxqgyKn64cfAYD5ccc/4wmr8SSRWsE2Jekz79VlO+l1QkJmI8lSNUt6HBLjGzV6l4tvTUBB2ewpNy2l+9w1Fx1ysguWe0FCJW6jztODJbhJLGlYppnEEinGW7JW7nOZ9cnFW3X/t+R0sU36v9hGezRbAzAz6fHV/jHrB5vAT+nMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4OvrLKnCPcYvSugiDs81XTwsoY3/2Cp3Bk5JqtIIBo=;
 b=Ufw6byYRQ6FCP7LNdd9sWbtrGy9pIXmqp35JKtYoWVx7uiTyHAPRdrRVwRb8znLjSK+Y6+JkmLDcX2li442tpbrR4VZJAyPyks5KwVc6ZLZuPXFABAwgY70P97W1+LsnA73zCAt3w4MhImBZpS4Up7Dll8Enl+BrCfBwI938NDSFPkxF2zuU7JmaOe1w9o9ebXAfjAsxE4t/t+6WbPdhennd7ou1LzHuffRNGo5zULw6NGBo3TRltDUGSihjNiQeQuSu5uWlByiv2kjtGSc3O5tY2iinEnOJbAMnf2dFGOj3i8NNzFXm481egYw9auLzt6tiP1St+jQfknnjOQNFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4OvrLKnCPcYvSugiDs81XTwsoY3/2Cp3Bk5JqtIIBo=;
 b=wdLph4k2kqAwLvRK1sCZGYGWHvNE3koec3l+MnrBIrOfqqjXMHjbxM5FFljim4WjzOb5fdyXtPjT2l7ZnPGedv0RMbzfmI4WwqxIne0XxR+ETQIT4sPGYI+iFaWtkXQWnBxFWER2K0Sk0sEx0c4ENHOEQ62VFWQuRyRUov4L904=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.17; Mon, 18 Jul 2022 13:48:32 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:48:32 +0000
Message-ID: <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
Date: Mon, 18 Jul 2022 09:48:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220715200410.301438-1-ruijing.dong@amd.com>
 <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88be0461-ac32-41c6-7aa1-08da68c433fd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhXiNHa6TflI40qrYH0ukxxHP6IxgFA4t8sTeoz3TMpv4SGBFLLuSV9Ov52FgmMOKA7KjCcQK9ghSfaCbHN84DUKnjAud+v3GqvqeBQ269EMH1YgNxnP8UadI3TxlggXYxyQ5chzZgzW059yWUhrmrTNJomLU7dIOFxi4q0cG9PafPoETghLYZGCs2cSnBgVkqm3o5vIBy/tKc9v4b6mqJLc2qKxWjBEFWH/q/xScgUR2K4zQMOebH0h8v0ep2GcBnbc3BtLDGW3EHf4G9fBc5urpfCM1uqYalzYccYBCT/BDW07/izKw7WqUbbsdKU31hXNFsNYZA0DMCZUzI7OgPHaaOHp7tYwcjD4b76o8sJiiKr+SnjFtQJwAgYY4CE5wGK5QNF5btzLNC0iftg20YpcIrOO3biP+nbuoIzp+Xvrwhnkk+Y2TLvI97+mVL8sW5tkwUAgxDiwZQqQ98Mt13rb/ZJXDFoxZdqz+ypchIESPxba9KR2jjWAFLasH5cNoTg2yF9ibUSsDv8iK/pb2ltIDU7g2nDV+h6Gu/TW1J+6Sw5DBRcCUxIKoMdqIFWSu8w40izkcEd3JHiTm2BK4Kftx+MFVqJsAA/lOALW7aenNe6koqDBOA5A1PVKNLFYtTGENN6OftJ1SpStJcC4Xv0vicBG1gUF9dhOEh74K4WFdU7ttNagkoHhV1blKlm26ezexYo33tcRUMnROmZ4eY8iPmPaGg1+VbFlj6RnNyYYA+OkQX9jRJ9kPyHRHqtirn2iU+FhQP5jzmZ7qUhf17mdcKNgvg/LqP+EA5ShFVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(4326008)(66476007)(8676002)(38100700002)(66946007)(86362001)(5660300002)(31696002)(44832011)(8936002)(186003)(2616005)(478600001)(83380400001)(53546011)(66556008)(6506007)(966005)(110136005)(316002)(41300700001)(6512007)(6486002)(26005)(2906002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpmV2t6azZXOS9OM0tRNTFlbkwrak9VWlBmYk9CV1BpMDlWNUhmZU9wbmU0?=
 =?utf-8?B?aTBCZ1BYQzRnNXVabVd2T0RhK3I2OE5nZlorSjQ0UzBLa0pFY3ZibDhybGdo?=
 =?utf-8?B?OFkzTHhBbWNPTFFhTzhEREZyYTFub3F5K1BYbEUyMmxRZTk2bDBJV3k2WVdm?=
 =?utf-8?B?WVJYd04xR0M4clhjRERnNUZNZXc4Z0JvengzY1RHTWRrYnB3U3dSNFJkSHR2?=
 =?utf-8?B?TFY4ZCsvWGFzRVpoQ1ZjSXZEK1doNzV5ZU5IMDNQalJZcXFLRE5oMFRnZFhM?=
 =?utf-8?B?dnNKbzFia0hBbzFoNFFRMlExdDlSK002Q0I2UzAvNDV5d3dEbS93UXRSWFdB?=
 =?utf-8?B?clh4alU2dzBDQXRRY284cjcrQkVoZmlUbml0Q1FXNy9JUHBmWEhMS2JmV0Ro?=
 =?utf-8?B?eEwrczNyZGNjUWNVck9SOXBLVXFGTFhGVTdnbEZ0MUdwa2FyTHRZSUNKZmRZ?=
 =?utf-8?B?OUdwbjBxb3FVUDF6TkJJTlQ0RVVkc3A2aVZ6UktyMzJFclBXMHUrQlJiSi9L?=
 =?utf-8?B?S2JLU08ybEFNWkdDZGg4K1FUTUtSNmJzWUJpUU0yYVRYbWZKMXN3ZmhOTGVU?=
 =?utf-8?B?MlJpcFVjMDR0SjJ0Wm1jSE1rbWhQUitFdWUwUjFJQmRhRDFUYWZXZFhaYTRM?=
 =?utf-8?B?WHQ1TXB0Q29vMDN6amQyMy9sVEFBbm5RTit6M2VHd1dwanpzN25tZGJXQVRC?=
 =?utf-8?B?aU5Sd2hLS293Z0dJeGFONkdYSlEvbUlmTWdRUTZITnZVaDZ0dEplMlhlKzgr?=
 =?utf-8?B?Y004R3A5L0VNdk1sOXJldGZSdVg2VkF2ejA1SXIwckN6bjFQUTFINmhzUFZJ?=
 =?utf-8?B?Y1I0Y2Y3K3Z5b1BoTUdwY0VQLzZPVmgwc2haanQzRW16SUdjdXJsYmlLMU51?=
 =?utf-8?B?UkduR3VRazZtRE15WFJRRCt3VjU0Tkx5ZVA1ZmFYTlBTRlE0akxCaWZXeHBT?=
 =?utf-8?B?SW9qaHYvQzdwWFU5Q3F0ZktlL2RtNjhKYWFxOUQ1NEVnbGltSFovcGdsQW11?=
 =?utf-8?B?amUwbnJhS09pU3JEaURVR0ZMV3RGNVpWY0tYcktGM2pEMk9MZHdGeThUWElD?=
 =?utf-8?B?VjVlN2crSE5USlVwVEd3QkdHWmRUajZjVk11TWVqaWhkYjRoN09OYWFqd2d4?=
 =?utf-8?B?MGZEeHIyOTdRUkhFUExWbFplTUFaQmhEOWYxb1A4b2t1RXVRRE85NXZjL2pu?=
 =?utf-8?B?RUFjdUlOZTVSbzg4ZHZNNENEclFqM2JVY3NFMmJXeXd0YTVFODlsdGV2YXVK?=
 =?utf-8?B?WWJKUnc5MHlQRkZjZVBHRUVoSEVOZWo4MnJRbkY1cDF6VXZhR1BsOGk4dlpQ?=
 =?utf-8?B?KzVDSFBSZjFSNjhobDVzVEkzS3JvNlNDVXJMTGFzTlJqcVVrYjZ1WnVnRHJF?=
 =?utf-8?B?MlB3dmczVkJubEEvM0JJR3d0L3ZSalFOWHByNG9LTHRRcjg0dkxGdkxnOVJx?=
 =?utf-8?B?emdGN3pmQ2NMa1pDZGVKUk5NTGYrQUJKU1IyOWNqQS9DT0VGR2ZrOC9TaW9D?=
 =?utf-8?B?UXdsYlhFT0RYVU9uV0VqSVZFdzR2TjY1Z1pJS2xISmlWMUlwSzhLbHZjZkg2?=
 =?utf-8?B?RFdTelVKdFU5bDNyVnpSU0JMRmV5dXNLT3pCMFZ5VDRYalpEbFZwRklzRm16?=
 =?utf-8?B?dCsxQTBUM3dXdXFLR3R6R2pMeGs2VWIrSFhrUHc5Y25tdElnd0ZYQWE5aTN3?=
 =?utf-8?B?bTNUZEhVazdpdHV5cE1MUktQQUlIcFc2U05BQ1hQU0xsMlc0aTFickwxTHR0?=
 =?utf-8?B?cFErM3ZWSG83bXh0c3gxc1R1VXUyckNZanloR0tsbDZNMEFWVzF6L3ZMbmNS?=
 =?utf-8?B?N2Y5TUFRZ3Jpbm9UMGttQjUyeHZ2bTVlUVZvUkN6dERNUWJHWU5QVzg3VW54?=
 =?utf-8?B?QXBVS3RXZ2NhcDY4TFVlUW5QT0Q0WDZKZHVPMG9vTTFna3p6d0xmK3ZKRGlt?=
 =?utf-8?B?NFJYbk8rTCthZUJDbDFDb3NSbU1rRFRHNEFXa3Z5NEVYa08vQmM2ZDVDNUh3?=
 =?utf-8?B?VWpzUXh2UGd0U3ZuM0lmVHp1Z2krMzQrR1hUeGltbVBrUEZycktXMk4xd1B5?=
 =?utf-8?B?S0RZczlhV1Y5VDN4ZVJhdVVJWHpKbDk5RDRNSjNnRFZBcDd0ekFaZkVTSkND?=
 =?utf-8?Q?HpdChvIbYmsFqDZsK5noB3HyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88be0461-ac32-41c6-7aa1-08da68c433fd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:48:32.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKpRPZMsdSDaDSy6v+6iXG7B5pixFRTabuqVlITh6DMJtDtwG1wPYa2TwaoGUdjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-18 02:57, Christian König wrote:
> Am 15.07.22 um 22:04 schrieb Ruijing Dong:
>>  From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
>> both encoding and decoding jobs, it re-uses the same
>> queue number of AMDGPU_HW_IP_VCN_ENC.
>>
>> link: 
>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>>
>> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index 18d3246d636e..e268cd3cdb12 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
>>   #define AMDGPU_HW_IP_UVD_ENC      5
>>   #define AMDGPU_HW_IP_VCN_DEC      6
>>   #define AMDGPU_HW_IP_VCN_ENC      7
>> +/**
>
> Please don't use "/**" here, that is badly formated for a kerneldoc 
> comment.
>
>> + * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
>> + * both encoding and decoding jobs, it re-uses the same
>> + * queue number of AMDGPU_HW_IP_VCN_ENC.
>> + */
>> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
>
> I'm still in doubt that adding another define with the same value as 
> AMDGPU_HW_IP_VCN_ENC is a good idea.

Hi Christian,

 From VCN4, there is no VCN dec and enc ring type any more, the 
decode/encode will go through the unified queue, so using 
AMDGPU_HW_IP_VCN_ENC is no longer accurate . Keeping 
AMDGPU_HW_IP_VCN_ENC type is for legacy HW, and the new 
AMDGPU_HW_IP_VCN_UNIFIED just happen to use the same HW ring as legacy 
encode ring, so reuse the value, and that is the whole idea.

Thanks,

Leo


>
>
> Instead we should just add the comment to AMDGPU_HW_IP_VCN_ENC.
>
> Regards,
> Christian.
>
>>   #define AMDGPU_HW_IP_VCN_JPEG     8
>>   #define AMDGPU_HW_IP_NUM          9
>
