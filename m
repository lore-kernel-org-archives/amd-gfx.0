Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FE7C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3117210E51C;
	Tue,  7 Feb 2023 14:31:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA6C10E51C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POy20w4Svba8zzAVBq7leCrkn+XOZQrLcLsbuImi7qaw847FdooUnuqylN/y36oK9C0ylbSafHfyR66peDyUB3CVW214TmPanCigbBvHzVl8P+98B1eEhDT6IjF7iKFvCbpVQjZkSlgzvuMNhdygopGiHL10xjFHka1kUhAiS/hpF3M/3bFUJJureVkCSADfjtGjDfu6CaIS3Op7hKYerCeQKu0QFjEeJ3siqp0M1/I+1QzHaJ4GY5W8BvEXEecQFR4S/vrB6VT339tGFY488eYMvU8mwfY01y7NNKRoQzdzia4aj6WyFyMNW6n8RdIlFkhGzn0cQCIkqH0lzK+hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX2rpxnaEv6PHq9zJGP+BaBwlndfDX7IT6KGTLwUdDE=;
 b=OWA3u9OKCvg5ZkvX4LCmwifWiyot9FUubHtEs+YbdZxO6aQ/T4ltbhSotemXdY6gmgHUy2xinVuyIM2OYCsmh0x1Ghm4l097P46hoEch69epKxMQkEb2uVZ9/gljNBTdzWJL6J6ctBTUWMXQAXeqpPF11nkNzeQkvBvqjftGdbwYwIo5aMpbfeD1acUo9DwVCUsuJS11PhswuZC7RBaxu2i56G3z0e3CY914hMiHogX9t2MQdPdJN2RbpmwQVCxahM781ermxZgX2t3Ooar51t2wVgrptqHp33A40q7KCcexM4jC1A7tg+pgH72RO0zowNqU4L+twK4rQPIOZk+KVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX2rpxnaEv6PHq9zJGP+BaBwlndfDX7IT6KGTLwUdDE=;
 b=duTAQBwqd0ckzGuuDP4Q5TC2qqzyyXlwpq1P33lULBdZx9Yap04UlabqtAd+nN66sJPKVATKm8MKCyU6qAJ7B+wDzuUejT0XriEZ4/tduAOUVsbcPsSltkLIRKoNNw8TqIcC+82YNYBxG0F2KHWleOfxFZBSiIMaewAlWEgTh4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Tue, 7 Feb
 2023 14:31:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 14:31:18 +0000
Message-ID: <25a2f7fb-f701-fd32-a37d-4222b6242a11@amd.com>
Date: Tue, 7 Feb 2023 09:31:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230207040524.4020763-1-tianci.yin@amd.com>
 <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::49) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8372f0a7-1ee9-4113-cf6f-08db0917f995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpaahUvhXSbhlH2KxcikMcQvy2usT8xTBLQEuo6adMvR1dGqLnxw8/2wst/dHPwOemM+9Dw6GV6HX1XtOP3a3XiVBxYjs3Yy6vOZCRQ95rGJPZemNMiPFmW/WE3Md3pr8sjVVlJSUJs2vHVRwAEeuA8GkZ9k3U5YhlhF46c3XY+Cl6nATRzRchGgVIMSAFNiNzK54rAquRRLYSY/3uDOVCD0dvetLaytSc4DEBldFBBrHx/3WVrApM2w9hgRraBj2KvE6Ac6LNasRQjKVrHxaRBQoHFVTY1v1DBAqAQ2eW7z6ImsGBqr5QsDBN+JrveoNtAnXOt4su14O/eaaIYn5QV2tvrawjmxzCjLbakZKlOTalLYzG5iBkg0BNiH/wblI3LCcwDhL2Zwsd7MgBdOE9fqEl50UocTGhbsoHos8mQm+adwxAMpLMTVYUzIKCATT2Sqm9I+UHPLriJ5ht3tMBKpZRcUHbRPsH4p8koNSX6cqrRv07kYLqfZ6u1i67V+FY9y1x+hAppboD86aJ99R7EPLlDBTXTUwap356W+yckLDm56WB34XIhhdYXltR+/NHzx4Kj0Nka+2VkkcVlnyhfnwoZLds/ShJ79X2lFEyENA1YfrROy4NVwuYUK48lMlyRDVV5UxUOAhvndL1DgvAWk30xzky+1p5OPRK3eIUp3ij9xs/rBtm8x++TG0ZtleXx+7awr4rCcvOYtpa/2hFhuj/lFTNeHRJWI+9IkeQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(31686004)(110136005)(5660300002)(316002)(54906003)(86362001)(31696002)(83380400001)(2616005)(26005)(2906002)(186003)(6486002)(38100700002)(6512007)(36756003)(478600001)(4326008)(66556008)(66946007)(66476007)(6666004)(44832011)(53546011)(8676002)(8936002)(41300700001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnllb015OTVUcW10c1crRUlNME4zeEtiUXNnTGxhODM4V1hFNUorb0J2Rldi?=
 =?utf-8?B?UWo3NitSWU12QUt1anFMNDJUcGxMcitYQWJ6SDdkSnlOcEJZeWJCWUVTS3N1?=
 =?utf-8?B?cnZPbnRrZ2tMQ3pYejkrU01wRmg5MG5tODhOelR0MU1ZUWdIVmpCVFBMcHl0?=
 =?utf-8?B?VFRoTUc4T3JGZXVma3k3UzY0Qk90VytzK1V4KzVsdElmZHRodEJUc3RITGVC?=
 =?utf-8?B?VlBtQjlHZjBMWm13eGVIWHJFRktUbW9PVk53a0N0WUNaMWdhNGdocXMwamNp?=
 =?utf-8?B?SHpIbDNJSDVaeXJWbHFwMWgrZUU3VVhTa09pWnNnaE4vc2lqUGMxcWt1TmRh?=
 =?utf-8?B?U2pIYllNbG1QZm9xM2hKeGM1ZnF0SDQ1czJEZGZyUlZQdHU0MEdPL0l4QytT?=
 =?utf-8?B?aGZBV3dicFY2REZtaGZLRHdnZVFnbStFQ0Z6NnRpTnRGS1FqU28xN3JLWmt6?=
 =?utf-8?B?ZVVUQlpNekJuWUxkTlgyOXBPNDQ1Rk1qYkRyYURGUDM3SUNyWjZJaTF4dk9B?=
 =?utf-8?B?VkwyQ25qRFZMNmxQT3ljVi9LelNrRVpLN2thZEF3V05IaERTeS9yNUc3dVY1?=
 =?utf-8?B?dndDVndmT0tyeHpNdUtUQzlFZWJEbEZzUWx4VnhmWjF4Y0pXbE4zK25QaHZp?=
 =?utf-8?B?YWJQTC9HV21LR2xTRG5UTVpWL2Q5S09hSGR6ZXU4Ly9rYW5id1c0Mmo0REhi?=
 =?utf-8?B?NW9BY0FxVGkrVkltaXRnb1BycUhpSXBDWlIrL1dFQ0ZqSXgzcXBDUHJiZDVM?=
 =?utf-8?B?bzJ0U2hla1g2OHExSXRCR0tLaDN3NmcrcGlmQ3dNZzRtbXpzZlFpenB2U2RQ?=
 =?utf-8?B?SU9iYldSdnQxbzBVQjV2TDlsa0VQd1g4bStXUW05QjJZejJrQWR2d0NMVUtm?=
 =?utf-8?B?aFBFRDhYelZKRnlNQXdCMktrREdNa3RxUW96bTd4dkU5dmNHYnZ3MmRENktU?=
 =?utf-8?B?VkZza3FKRjc2MHZ4NTJzV3lJTWQ0L25PWE5RMVI3TXhYT1d4UDd5bldpSGxR?=
 =?utf-8?B?WlZBVENrdDQ1aTRJMGF6V3ZmZTlyZTlPMFlYOTdueU1ycUdYZTlTakd3dFJh?=
 =?utf-8?B?cEdha2hnZktsSFdmMG1UNUJHeWJsTTV1MEd0RldWYlhEdlNTNzRSWk1waUtl?=
 =?utf-8?B?eU5UcHJ4Yi9xUEp1RkRsL21PSWRPUFJZWDZaemRjNU5oK05XWXdtaktsWkJN?=
 =?utf-8?B?cDl5RVlKSHRoNFZuLzk5VUtIZUJ1emJKRlF1Z0tFZ3NETUVPdGhTNS9yb2pt?=
 =?utf-8?B?bVNJcTB1cUEwSTFJTmRvLzVQWGVlTURvVzRFTGJha2JRZ29XaGhvNDRFQUxM?=
 =?utf-8?B?NXNLNlNMeWJnTUxjMlJQOHFKWXJyUU9UaW9OSExSSjhwUVB6d0V2Q1pvLzl1?=
 =?utf-8?B?TmE4SThNZ0QwY3NUallHUzA2RnZoRm5pdkxYR2RIVDFocFdET3E0SzFLUFR5?=
 =?utf-8?B?U3JzaFVURUhHOEozZlI1RWZ2bnNPVWcrR1lZWXA0V05JQWpwdWFaMUh6SGRG?=
 =?utf-8?B?SzZ1VkVvQlkvVlV2T2h3YlpoVUR0MmZiVkRxOVh1TS9qSER5TE9hODMzRXMv?=
 =?utf-8?B?VnJCdjB6VDk3M0s3Vkh0QWVOVEV5UFhuR1JKZmlaZW1OZGo3c3lPNmZvdWJK?=
 =?utf-8?B?dWVvWXgvL1VXa2ZlNDRwaFpyaGl6cXo1ZmNXY0tmc1J5SzBuUSswRG1YWm1K?=
 =?utf-8?B?SVZGOXlUVkI2SWltSWltNElwdmZtK2gvQUR4MWM4b09NK2xiTm56UTJ2MXdG?=
 =?utf-8?B?WUQ5RTR2Y3FHWE4ySUQ0ZVJLc1lvQzZxY3NEOGsxWk0vc0xCSzJMTEJ1aEl0?=
 =?utf-8?B?d0lOQ1lsMGhiTW9yT1JkUEx6bTFGNi8zSXhGcGlKT1VoNlBvWHVuTmpURVlY?=
 =?utf-8?B?S3FoM2txd25peWRiRks4ZU9BdTBRMUFSU1k4aWtuWVBiaU44OXdFaG1wYmFu?=
 =?utf-8?B?RGlxUytITndYNWlGckdWZVVpbHBmczJidThiVldhaFYvNjdlaW11eUNwWGlC?=
 =?utf-8?B?ZmZRRWtaOVdSS00yZG1vT3BvTmxoTEdKaG9tcXRDeUErd1Q1bzBSb1JSenBx?=
 =?utf-8?B?OFVQWnQyZHZSVFBMd2VNYlJTU2VFcE45Vi9DajVST0d3eVliUFdnbUdldHM2?=
 =?utf-8?Q?p4wZyoioatzowcWenT5NYIzIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8372f0a7-1ee9-4113-cf6f-08db0917f995
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:31:18.3374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73Cwx9qkSUQrMOtBAcBOYFptXut2gpIp475ZEfXVaeC6EnJjrhgSMq2+vO6zRC2cY2J0S8KBKSzGykIosxl3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/7/23 08:00, Hamza Mahfooz wrote:
> 
> On 2/6/23 23:05, Tianci Yin wrote:
>> From: tiancyin <tianci.yin@amd.com>
>>
>> [Why]
>> Display pipe might be harvested on some SKUs, that cause the
>> adev->mode_info.num_crtc mismatch with the usable crtc number,
>> then below error dmesgs observed after GPU recover.
>>
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>
>> [How]
>> The max_streams is limited number after pipe fuse, align num_crtc
>> to max_streams to eliminate the error logs.
>>
>> Signed-off-by: tiancyin <tianci.yin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b31cfda30ff9..87ec2574cc09 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>           break;
>>       }
>>   +    /* Adjust the crtc number according to the DCN pipe fuse. */
>> +    adev->mode_info.num_crtc = dm->dc->caps.max_streams;
> 
> This would introduce array-out-bounds issues, since there are arrays of
> size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.

From what I can tell max_streams is always <= AMDGPU_MAX_CRTCS (6),
though we're not checking. Maybe it'd be good to check and print a
DRM_ERROR here if that's ever not the case (e.g., if we ever add
any new ASIC that has more streams).

Harry

> 
>> +
>>       for (i = 0; i < dm->dc->caps.max_streams; i++)
>>           if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
>>               DRM_ERROR("KMS: Failed to initialize crtc\n");
> 

