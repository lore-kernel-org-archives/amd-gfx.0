Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B62BC63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6272560FEE
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6272560FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAC76EE7E;
	Thu, 22 Jul 2021 14:43:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F249B6EE7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 14:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv4OUYABFNv8b0WWXNfiiN3nw0OJ2HzzRhoubQdglvyckGwVra1zMl78qoNmO4Sxleni6bcBrbogyOIIcWimkUbO8ZKLKoxlcjNyGmzlfujrr/g5nqOXompre4J0XFZieJo070CKcGdLTx7M4CZLlDP08QFQq0xX1j5DbHelnLSKjyBk/LWUOja1LM/iiuOJq84cykHoJjPw0Z+jhHImkl9usSMtg1XbF1v/c6l3mb6k4HjtO8OxcJcPy8o/9rDtTh3pTfR2EPlYoKZaMdR1oB3GEW0msTehaT8mlsLmdQ7l+BQ8Ktc9WUv03PDpEccHFh8FvZpI3H6tkwaAsyZIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT8dY5qxogbsNssqA67j/v4X7quIwidF5TNPt82BurA=;
 b=UEjpsG53wSzI9Zff5sY9kQ3W9caRZnwSs5oxlQzM4mVbdbeQBcDFAclbkjFXK0RgKEzTKqMH6zTGE2qIfj5tKT7VQOW4fjy0+v9AVtlQGJps/IVK4VoSm9YNV4FghRN/RVUYLUZTfCD+V2BiiUw//IjnrepG1YZgSvr8FeUkUxpFwZGDMzJqUlioEyqixHBXrfIDOZRMRZR//54JiLRbsP2J8GNERIJLH+qkPJI5sBiN8IHmYG766EjdeRwQHKpWmCrqYDupfG/nxa2DkG66UiNEBCQMuaHMXb+wqu4r21rvxspoaQz0WEnvY+FCbHzQpu1+aym4NbglwS2HWIgIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT8dY5qxogbsNssqA67j/v4X7quIwidF5TNPt82BurA=;
 b=cEaE/aLv+Zg/JzBDglUwY1qN/rS1jUd8fiEO0SGiU5okSIaRuubR2pZArS1qKObRneBLvtIjngmV+Thmj8S1TWp5i3FrOtkChbUilwDC7rq//qstzK4XuyZma2sOMu5D0vr9Qf9zwInZxXYywp8LVU8CHTNDtHYujGOg/sHNdQI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 14:43:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 14:43:34 +0000
Subject: Re: [PATCH] drm/amdgpu: fix build error
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210722092537.27624-1-guchun.chen@amd.com>
 <31ab5df1-3692-f9af-2467-4c8dca0b5c0e@amd.com>
 <DM5PR12MB2469A4D01053A7F5F5D04263F1E49@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <f49dfd40-2463-3c9d-fb32-cb1d8fde4221@amd.com>
Date: Thu, 22 Jul 2021 10:43:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM5PR12MB2469A4D01053A7F5F5D04263F1E49@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 14:43:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40b34b29-acae-4c22-7750-08d94d1f1525
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB495965BF8E6C97C1D1D9BA7499E49@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKOdyoI+LzdlJUZuDGep3aT4dj0ZmRTJBOu4t+8rN+aH+ffnE/D5eHKamCq2/6o/EcFCg4sxvioDKWCbkbDnkcZrxZeL9Z4hr4jwjY2aauaQ4LCNIJx8GWbNwIkAjOS76pRICMGFe448btQ+/icMsEFPPX4szNbdDT/tj0I3mz4B9ahilUkhLiLy5uHb+maWU23DNYalRYpHlegwqUT1v1UAeFOccrr+7P2lCNSj0jFf2lrRrEgJ6gsALMOBHmZjPAvtmgfVZMPevYTkIQfCQNMJG4glJizno9tFXOl4lnsG1XXloToA962DF8WzItrTszXHPXxVAGsaBjMxBElfu5MDf8i/T9ry1zbGnIwYzd5ALdEf6yx150Y49/q0YjkMQ/2VuqrtSZzKu6HzMYdC1RtE9MGyjFZj5TjaLs/hs7fcES1tkxOLqW0+aR9Vl9Rxtui53tQs+fVXZlO/sG+cIhoGcte6C5HbW+YRbuzRUk+YXqoIsq2g/wG/8Or0/ry3p4rI+8ZYCbY4d5DY2C3130wKGWggk0KRIZVHjfNnEXuXVHbTFhkgbfJZdxsAyUIGVGGH2BRI1izmYLrOFpgA1T9XC2jLRLVEhLX4874ZKhtkzAaaWzwwACOyYzK45Uz6NVNZTxHTHoHPQzXak1TuUcPQ3nXDAW7ppIQAAhuW9IrTLVZSxGTm8TNftI6yacI65nmpfVIPxp4S7DEA+ZBkC6hhFE7hRw/B8tiuKpzbjFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(110136005)(186003)(83380400001)(26005)(31686004)(31696002)(6512007)(6506007)(38100700002)(86362001)(53546011)(2906002)(8676002)(8936002)(6636002)(44832011)(316002)(5660300002)(956004)(6486002)(478600001)(66946007)(66556008)(36756003)(2616005)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0V2U2pXT25ISHRoYzJZNVFQTytrWnVqdVFqU1pPK1pZUzViRWsrbVdjREdR?=
 =?utf-8?B?a05UUEJXR0U4elBTaXpMZkZvODhxUXVzMTd4RWxKZHRFeFNDMHlCYkxDUjly?=
 =?utf-8?B?S3RQU2xBaUwvcEliZEtOditzY2NTc3l3bFJxMXVCbmkySDNleUlUeFBNRzRS?=
 =?utf-8?B?YUlXTVhQK3VTQXMycFN1aXQ4YWRlaUNweURLNHJQWUZmTXYwUWo3dG5tYXNG?=
 =?utf-8?B?ckdCb1oyV1FFYlc4MUdDUUpVVGZFQlg1NXY2SE9RLzh1MjV5cS90d1JBcFNZ?=
 =?utf-8?B?bW5JdTdNdjdlQzZwdGp3cmllSmFZMGl6VjlDMkJDOEpiQS9uamczalpHSEYw?=
 =?utf-8?B?SmZuRUYxQWorZkovRWdzL1dxT0UyVGdNM2w3dGNDbEhudExnWUNGR0k3Q2tT?=
 =?utf-8?B?dTJ6WVhWQ05CZktvcjlRWDY2ZSsvSlRTWDhhR3Rudm9Da3RQbXFHc3ErQmtW?=
 =?utf-8?B?MXRJdjZWSTNTVHRFc1E1TzNReVdJa25oREJWcjRNcG0wU3kvNGEwdThGT3R3?=
 =?utf-8?B?SjRra2JKTEtraDJRNk13MHdqNGJOUFovMTI5WG1vdVpHd1gwZTZPZ25TMWxp?=
 =?utf-8?B?bnNoaWFSSUZucTBwYnc4YVZqYmFpRCtCRE9nMTV0Wk01V0RJNHFvbkFmdkdl?=
 =?utf-8?B?TnpZaHdkT2tTNjdBazIzeU91TENaenFIdjR1V01paS81NFlWYTkxdXJsUTg2?=
 =?utf-8?B?RVVqZzRIRUpyeGdXVE5oRzRrVlRnUTdJZFd4bzBVTlZUV3IwVFBWWkpZeVB5?=
 =?utf-8?B?VFJsYlp5c1E5bDIzaGJka2lNSWQrTERBckk0WXdCaVBBb2txY0toaE9XR202?=
 =?utf-8?B?OUJSS2ZsdktjUWVwUSszMzJQUjMybjd1VHpTZCsrOHBUdFVrWXRXWDF4RVpP?=
 =?utf-8?B?YXp5ZjBpdzNjNGc0U2ZlUFNuTzZ5VmxDRnFUUDNNQ3IvZkMwVkV2SGxIM2JX?=
 =?utf-8?B?cHNTZmxyK1kvZ1ZzTFJlUFgzZnRUd2RiN2dlNFNyZ2dlMnVzcWhGZWtVVFpq?=
 =?utf-8?B?N0xRejJNQzU2VnlLVjNZREhaclAvS0pxWml0MVdVZEMzb3duZ3RaaHB5VzBT?=
 =?utf-8?B?b3BmTGUxMDNqZ09XVGEzQldjNHFKb0MzTVREMWw4V2I3dnJYdGZTWlBWTk0r?=
 =?utf-8?B?UUlsL1A0KzRIMSs4RWR6RFVSanJ0RFRDNzFxZnA0cHNlK0F0M2pwSTVzcUpN?=
 =?utf-8?B?V1Z6M1lGQ0Z3bGV6TXM2OW1nQ1M2d0xhUTZmOE1GMENHc2E3UTdtVmVLM2Vz?=
 =?utf-8?B?Y0FWbjVtdjEwSEZDKzk4ZWRtby9QRUtYdDR3UDJ2RFNIVkFtSzB6dUcyM3d3?=
 =?utf-8?B?TmYvV3duQ3YxRGhnY2dwMTFWRWFWTTZXWEdtOTd3VU5LaC81NXRQZTJ6Z3l5?=
 =?utf-8?B?K3A3TGZWWGxqTE5ZaUY5OU1sczVoNEZsdlFpVG9tUnZDM2Z5Q2lmUGUrNWcv?=
 =?utf-8?B?dUNjT2xzQWtFWEdUSU9RYVprV2o2elRPVzNpaC9UZEZLQ2RBOFJNdUt2TDY3?=
 =?utf-8?B?MDNldUxPZkFlZEF3VUhrQk1ZZ1BDb2FORGc4eUc0Tk0xTENYZ29tbitldm5D?=
 =?utf-8?B?L05XQklEcVNieFAzdnlVVXlyU3V5bm14dFI2VXUzSVdyY2t3SG1SSFc0WWNk?=
 =?utf-8?B?c200ZU5pQjB4QThPS094RFA1YURLb0p6VjJUZldnUEl0dEVXb3k0VWx2WkFV?=
 =?utf-8?B?ME14SEJKNk1xR1FsZkNrQUpxclJpWnphWUdDSUVIYzlFbmpFVS9ITjdBem1C?=
 =?utf-8?Q?P+QNau10pPD6pQjVknb3+ys54Mi4UGT7Ll9L4Fg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b34b29-acae-4c22-7750-08d94d1f1525
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:43:34.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n63XgsyEYvwJPoxxN0s5h4qsiq3BSbJs81SdT/KoXHb65dwlPA8WmqKXptdvcVgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please push your patch now that it's been reviewed.

Regards,
Luben

On 2021-07-22 10:22 a.m., Chen, Guchun wrote:
> [Public]
>
> I guess your branch does not have below patch:
>
> 7afefb81b72c drm/amdgpu: Rename flag which prevents HW access
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com> 
> Sent: Thursday, July 22, 2021 10:14 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix build error
>
> On 2021-07-22 5:25 a.m., Guchun Chen wrote:
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: In function 'smu_cmn_send_msg_without_waiting':
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:259:15: error: 'struct amdgpu_device' has no member named 'in_pci_err_recovery'
>>    if (smu->adev->in_pci_err_recovery)
>>                ^~
>>   CC [M]  drivers/staging/rtl8192u/ieee80211/ieee80211_tx.o
>> scripts/Makefile.build:272: recipe for target 'drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o' failed
>> make[7]: *** [drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o] Error 1
>> scripts/Makefile.build:515: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
>> make[6]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
>> make[6]: *** Waiting for unfinished jobs....
>>
>> Fixes: e070ba49f3a7 drm/amd/pm: Fix a bug communicating with the SMU (v5)
>>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Generally, there is no empty lines between tags.
>
> Not sure what happened here? Rename? This compiled and worked fine on my machine.
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index a48f18932357..a0e2111eb783 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -256,7 +256,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>  	u32 reg;
>>  	int res;
>>  
>> -	if (smu->adev->in_pci_err_recovery)
>> +	if (smu->adev->no_hw_access)
>>  		return 0;
>>  
>>  	mutex_lock(&smu->message_lock);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
