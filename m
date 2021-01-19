Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3357F20DD4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3357F20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A594E6E3D3;
	Tue, 19 Jan 2021 14:56:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172946E879
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 14:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyg4eDhnzDQtUcyWc1XbhUKWlok+a3fOse5jhzwXVoKxdqHKiGtoCT1LOp07uJ2smgXD5lOaNMM583D77tRMAWoVaE5/Bu6HKYSEJAassVsL3o+SGOp7O4HYWGcoZz0r4qtU5Y2dus0c+Q9fgq3Xg2Js6PKMmVq6fFhZpU5kW1uTbaCA1y2Tci0bYSuxVyma9TBT1Q2KwHXuGVYZtldcSi0xfQ4Uexvf4/pxXJREcDkxd7iDmqCWOta3bXUaY1hYsyLVGP7dg44Fn36F61Zan1ZJx8XJhtfatZ/SzMXjloumTzx7b1ZflGavUECsqnnuaNfnbsO/dXAqNzoMhz4ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds0xO3KKfKuUzh+/ZWJKn0XEoFasCgVKJaYyJaybh8U=;
 b=C0gnDUN7DLIs59k8Sx8uvmK+BE5SXAWSr3MJSngV6w6QjWN+nwh/8yWBNonDhQvnjNhSSjtXSvZYxVQOMq7Wry+KZsgh14PyHEHXUh+tfKrf2pkLMBwNCOnf0HmWHnHCNFJLJDWs2bqHqXxk+E+1BPQH5I10pmz2ijK0Zu6KPAxoCJrFeIfYbnk8jgTEzhXgtzhz0QF/okFwkgTXvFfJHkFyc3bh0ZMBalaCHhn/Xmn//0/g8QMV/keamUOW7xUpPQrveInLwJGmqn5iGJX6/CoumdmynF8GSLXwFPpNTin3YaUu3i+vtB1o4CLDXf7hVuDSfvjbT1aJteSWnK5Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds0xO3KKfKuUzh+/ZWJKn0XEoFasCgVKJaYyJaybh8U=;
 b=4R1rr5ZWgyUNDL4z3FRue5ZeW5uMrb5bAaYVk9pFvZhkeUpItnXvt1ddzFfJ2qw2MN8K7dDCvwNtG2ZC4+LeNlBQk+oN8LUar6OTH3ZcFYMBaINuK40JZbF8cm/amHJ78eeSMBnmLNyOpER+uPtSWi0itK7i1IaCBCK72A4Mc3g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 14:55:57 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 14:55:57 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: set job guilty if reset skipped
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210119122236.8039-1-horace.chen@amd.com>
 <20210119122236.8039-2-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8be24946-72bb-2d7c-2e16-7d904602f3e2@amd.com>
Date: Tue, 19 Jan 2021 09:55:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210119122236.8039-2-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
X-ClientProxiedBy: YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::42) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
 (2607:fea8:3edf:49b0:c1b5:6dec:d289:5430) by
 YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Tue, 19 Jan 2021 14:55:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee23b368-04a1-4972-ad0e-08d8bc8a539d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26547C7CFE51BD26A7C27872EAA39@SN6PR12MB2654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUyPar5b4P5H9CZDmD2Z4vKLDXTSztMUCQQjKWIV/TfhCuTMFB+cr3ervMr5J0r5u2uIgzVn91TYFIV2V4Jb0z3tQL/B/2EFCMi8+U1GXoe453ocNFJd1p+rEw1fSUIsLuzPjqzYylM+RxDSLd/3b62/mF+I/uP9sJgedIJZPRpqzLKD22kf7jMpEZzn5dt2x/KyKeHXSr+KUhaJV3YOBOQsV4s5Piqy+ScpGtIIsKRsWZkdRz7969tXRh0x2fBR26G7PDvVt0JjBZOfCWnqWOFyo8UARmm+xhkfKh/g2lol8WJt5gDW/518LkObsHUi2Eoz+oWKThOZGjh3TkWROrCTlyIJHzQQRJ7NFi0O7lmcXaoQu8cUwxd0lyMZCvP+6dqLhdWuhew/kw0wexevUdRL+XIcuQY1uklibBMc5sgaXfgmw9ozsGgAlkL83EH7xhNp6U3dTP9qW7jQg15epJWWS+wlv9ZwANP96iHkgao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66556008)(66946007)(86362001)(4326008)(36756003)(8676002)(6486002)(66476007)(2616005)(316002)(31686004)(2906002)(83380400001)(53546011)(8936002)(54906003)(5660300002)(52116002)(478600001)(186003)(16526019)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aGJ0N2U5NFZmdE9IRUc4N1czN0k5RVlIOG8yaUxRdngwR01pVGVKT0sxNTF1?=
 =?utf-8?B?eE5kdU8rbVp5cWFuWWQ1dTFqZC9SaVZXT1Y4aE5iMW9EeHhkSGlaSUhpU2JR?=
 =?utf-8?B?dWtsb1VJdVZ2MERmcUd0ZEoybjBGN3ZrWFJ5anZCLzRMTUVyaGdweXFCeHph?=
 =?utf-8?B?ZzZBdi9mQXl4WXlwa0hZU3hzZG5EVlhwVWZXV3lZd3pVWTJ4UnM2aXpDeUZ6?=
 =?utf-8?B?WnFqc3FqWGVoMXN6OUFiYVhJa1B3aHN1a2grK1ZKWkhBQmszc1RaaGlPc0Jx?=
 =?utf-8?B?aTJidEEyV2dUMW1ialVlVE1STDhjVG5tWG1VbmF3Z2RWNy9kbmxtdlNDeFF5?=
 =?utf-8?B?dVp0UCtUYUMxZGgwRGRYR1JpK3ppbW5nSCtyYlFCdHh5aThWdWFyMXdzRUk0?=
 =?utf-8?B?OUhDajB5QXkvL0Mvd2huNkFCUWpJelN0UWFhRnZrODlQM3RobVBvMW9BdzdU?=
 =?utf-8?B?T2J5ZmRKUVcwMndIYU5XdkthY2thNWtvUUdnR3NveURxYng4Q3hYUnhCMmJt?=
 =?utf-8?B?VHUrQ21VQzhiU0wwUlJKUm9PeldHV1dxQXNOcjFuSWdLNlVyZ083RC9SRExJ?=
 =?utf-8?B?NFRYejRZeDV1WkpJTEhkQk1HMnVBMVFXSlB4bGtKZThyU0hIN3UrdExBbkxM?=
 =?utf-8?B?TEVDNDBLZlRaakZPdUF6QlZwV2F0UnJraDVXMDNCeEZrZ0lEaHdlb2UxdUR4?=
 =?utf-8?B?QUMwZ3NNZXBEajVyY3Fha0NGUlpITFhKZmU3b2hyS2NBdzNHSDYvODBLc2w3?=
 =?utf-8?B?Zm5TcEc2VzVyd0pmcWw1MDFMOXNubytlSFRPU2N6MGM1VGJVeVlDa0dMMG9U?=
 =?utf-8?B?ekdkS0pvZVpCMTB1VExtUm5qYXBVMFpNc1lPSkZpU2tRd2hXbmxoRTZWUEhZ?=
 =?utf-8?B?V1dHcUJkMVlJSkxqTGxBUGwycG91NTNoN285amV5R2xTZzVCWnZnTUcrdTZI?=
 =?utf-8?B?MklCOFFhOEYzcVRJTlNoT01VbDl3Tnhsb1VrZW4yMlBuK0tvWUl3Q3BPWktJ?=
 =?utf-8?B?OFpvallWa2ZJbFk2bUlxK1BUN2pnV0J2dGc3eS9TdFl5S2FHVHAxanVLUTlu?=
 =?utf-8?B?TjZKSFU2ZVdNdXM2cWxuQW4xSEJ5UzBoTjl4eVYyOXFVWHhKVXZhWW1EYlRj?=
 =?utf-8?B?Zk41UWxUb2ttTVdMa202akg4aW51cjJKSXIzYmdkV0U1V3orKy9oQ0pQMFhT?=
 =?utf-8?B?Q090bncyTWxkMWR6N3BKckFyb3Y4WHpNU3pTTE9BMFFNOVNDVk9EUW0vdXRE?=
 =?utf-8?B?Y09CRTlGOFRHamRqa3JXWWFEd1Ntci9sVnhZYVRCbHY4VmxRQXd5TE9SVWll?=
 =?utf-8?B?bEVKSTdYK05WQjJId1VVKzBOUkhraHRyVDN1WHI5SHNoSXhiQUw4QkJ1UWp5?=
 =?utf-8?B?YjBZc3JXNERiMEhpcjBBaUYwd2NuY3FQcDUraG8raGdkZ0FOWWQ4Vk9JZVJH?=
 =?utf-8?B?dStCWVNZdnJZNUllN0dJbE8rVmFITkM2LzRoOTM0dlpiV2FKRW5tekt0Wlpn?=
 =?utf-8?B?NEpuOGVhUlN0SldsRVg2WTBHa1dMS29EcjlZcGRyZU9YVEVlR0I0OTdGUlgr?=
 =?utf-8?B?bmtKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23b368-04a1-4972-ad0e-08d8bc8a539d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 14:55:57.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVnK6QnRdRStYzcM9/E916ZU+5PaqZ+Gb9VYLhxa+rGDro/TgXlayYUNQZVAcjVs77FnzbStSF3mV3H5t/rkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2654
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 1/19/21 7:22 AM, Horace Chen wrote:
> If 2 jobs on 2 different ring timed out the at a very short
> period, the reset for second job will be skipped because the
> reset is already in progress.
>
> But it doesn't mean the second job is not guilty since it
> also timed out and can be a bad job. So before skipped out
> from the reset, we need to increase karma for this job too.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9574da3abc32..1d6ff9fe37de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4574,6 +4574,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
>   				job ? job->base.id : -1, hive->hive_id);
>   			amdgpu_put_xgmi_hive(hive);
> +			if (job)
> +				drm_sched_increase_karma(&job->base);
>   			return 0;
>   		}
>   		mutex_lock(&hive->hive_lock);
> @@ -4617,6 +4619,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   					job ? job->base.id : -1);
>   		r = 0;
>   		/* even we skipped this reset, still need to set the job to guilty */
> +		if (job)
> +			drm_sched_increase_karma(&job->base);
>   		goto skip_recovery;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
