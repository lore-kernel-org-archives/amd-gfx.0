Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AA060F9B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 14:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2AA060F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C6E6E0E3;
	Mon, 13 Sep 2021 14:41:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D416E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 14:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLyOeb1mVilHImnr82r0ptKVfcUEthxMHvciuhin//H4DLJ7s/ItJq8EtXj+SFXLnse17TAdV3+8XZjnZ+S3R4EYRt3d+tVSPOp/A9DKvamnYdZwmPPvwTjc77KCpQLnQWIDxOCvXFUvAgajakvxGzNhM8agQvUnVFMTY38kzumVdrBrPH9eMWbRbHpMttrFZuRyJRLNb1+H6N9/mamgDikui41BNdMjbRBRO4NuZfr0hTG1pfKgfcSNzG/bdW8gvCsBHXnkI0rgb2ugayc1L2DjtLiGog5Xkd/+8FwKvOg+GG8sFrSjliRSKY3c60KFAitC3yoSIrSGzUONxg1cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0E0T01HKmKxDUUh6mK8Gjwh7+gsxMVs+s9I7cPbov2E=;
 b=OqtDsT3U86PjarLvvG6/2SnUsFaC8mmMBPHKfIhmdBK07q9lJw+A8P6rpqNHO0MSe6f5M8SMKuyrywGFwEtlKNruvIzlmg7SL14+//XC/joGdZyNszUbDl8Jh6hZMIWMoX3kUZ0twB9KKXV4RGYgmGUuUY2QSZNa8U2PaugB0HpnJ7aCXmUyOrErq7jHR7W+yYK21J6QYXG/fLIHGjn8HT81aHeR37cCoWAUBZrT1I1lTDe1SOR2uUK/MaAAYmT99ApALLmKsLoZ5GYt5co85vRrmcQ8fjoMygauSdVR0e6uvKlRw8a4TOFwUjeZVzTdzNaHozjcNKeDjoB5aetZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E0T01HKmKxDUUh6mK8Gjwh7+gsxMVs+s9I7cPbov2E=;
 b=XuMOpcwEHgu22l2oELBYzjxvKs5SSZYDstgMpy/kC8muzqqqh6tfqv6QyTKT+yyDs1Tzp2N2jvbyUYcL0FGA0Lnlw6nv5FmBI3aCPDJwNC60160rQfhTnzYPd3U06k207FB8TBWCL6tIiA1WLti7U3Cast0xf5qsRTdQFJM8yLM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BYAPR12MB2934.namprd12.prod.outlook.com (2603:10b6:a03:13b::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 14:41:05 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 14:41:04 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20210912234817.13051-1-xinhui.pan@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f8d10120-ae1b-7f4a-2bd0-3cdde53e8d24@amd.com>
Date: Mon, 13 Sep 2021 10:41:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210912234817.13051-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:c7a3:25f1:2e00:cb51]
 (2607:fea8:3edf:49b0:c7a3:25f1:2e00:cb51) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 14:41:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678f46eb-d106-4471-b697-08d976c483a4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2934EE370BFCD586C066D6B7EAD99@BYAPR12MB2934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcOx+z5l2MIExUoJu3JG0lZKA1EFKylQqc97oqFl9gPRpagFvzXJgepH/iB33cmL26NsxdYz0qhd2oqE0opDr4ApX2YQIJtbKcORNkhE8rDs+uj+XT8KGbMKlY3m6hKkHJXscLrLi764hqckchT4HNgTA9Pbx/IK7GNoxnlTrIGzOSjrLumvubMN7fNTPr0tlw3/4sPHnWVBDITpB+qXTimWk0iZDNKQgGbJww4+Du0B8D6ptOLSu7ZC2BaWa/TPlvzf+wEQefm78f94w/IssYyJfmdELShe1fdCkmDI1yAQFyip+B0Lo7MU1oyLCgZfo5PkxM9dVRhdAb6kGG1+o8+DK8/JNu2R12mVhKrH4qtLOz3/YhE/yDwNGI28S5OWoUzC7cSJ2Tc8y1uOXGC7XAo5vcETGKZG3tIFAgSjsPIN9GNvCtsVnJPlTiN+61hEHiU1CYeEG8pm+/pRgkoFp/688D8VblCI35gIIO4C4f1W/DYusxp9tz07aHUfFF1jb2ydxpVon+TPGdH8E8fXIv8o88As5vFsZRCIxXNU7q05oWXsN0b9CEstroAfQhTP3p3UB+30lzDqRfzeiv0GVMmbdytk0vDdeblxRrfl8Yctw4v1LSVPigcBO9/sfYr9MJXEWoa8cIRACRneHReuGeecnXMmwONqJ0meYjMxfp/n7ytcLN4BRcdJLn2g9Ko/oSWLx+XJVxLRKbY5+EL/9QBt0WxP+18qWz4nbnKBVmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(4326008)(86362001)(2616005)(5660300002)(2906002)(66946007)(66556008)(8936002)(478600001)(66476007)(31696002)(8676002)(36756003)(44832011)(316002)(6486002)(53546011)(38100700002)(83380400001)(31686004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWp5cEc4ZUFqWFQyUUxOc3JXeUcxRjNkNkxpRGRxYVR0MDZJaGdYU0JsWk9P?=
 =?utf-8?B?T1FwYmVpSjkzbXR3VXBWcjNsQ0MvK21iZXg4clhMVUhwalM2ck1iYjJHamhh?=
 =?utf-8?B?NUcwbjBWTi90MGlubDZ1YVhLWGlobFJUUTE4UG5MZXpYejJmTmxoWFE2Tml5?=
 =?utf-8?B?OWtoOGZnOWpJbXlUZ1JFKzZEaVpmSkVrc2pmM08vcEVpdHdtUlR2c1BuSlor?=
 =?utf-8?B?U1dVaHFsVHkwRS9wZVF3azkxYnhGRzI2UkdyUURuakY4MyswYzdjMTNyN1Q3?=
 =?utf-8?B?TGg4NXhiVEJsM0Q0V3RwdUNWMlpXdXM5N0V5cDliZzFiZ3dxZWp1cS9YSHFV?=
 =?utf-8?B?SHpyb2gwVWZQcnZnV3Axd3FZRTl4UjM1dU91Z1U3MC95RXBDLzVzS3RDTUpl?=
 =?utf-8?B?NlhjK0RHRXA3bSsrKytzb0I1VnhwR09CSVU4Z2p2V3E5NlIyTHhqa3dQNE9k?=
 =?utf-8?B?OHRMbmQ2V0dLMjVxUmF0bThzU3JhbnkwaFlENVhjZ0ZCbFBYcFJxeDNJMFRM?=
 =?utf-8?B?dHVyalYvMWJpLzladnM3QnFWSVBZWVp6MWQ5RnFsWTRmaVd1dWFKSTh5ZVhU?=
 =?utf-8?B?cGI5N3p4ZnlLWEhlenNPaXBJZGdFTkZNaFRqNmpOSkRtLzlnU3FSdlZGVFpZ?=
 =?utf-8?B?N3RDaEk3OTRVRENySkUyNlhFNW5SdmF1aTFjWUdFYXZTWFNnckMvSXpVT1ZP?=
 =?utf-8?B?ZHIwNitCQUZ2TmQ3Vmprbm1qQmJoZkIraGt5UWd4Lyt3QkpqOXAzTitRQmpS?=
 =?utf-8?B?WUdIclpWekxKakdLakJmTGlDMmM3VmxNc3N3WXY4UEduVWV5WUJjT0ZwbE1l?=
 =?utf-8?B?ZHFwVFBPUnM1TDNNTnA1QkRuVEVCY3FpOUdYUFlVNzJoQyswUkxjNXhaSGtS?=
 =?utf-8?B?VkJBTjhHN1hIRFVlMVprckY2L2VFUWZQbStkMWZOdnVUbWt0bVlJSCtiL1dn?=
 =?utf-8?B?WTFOZEQyUlArQ0p0TEhTMWpqeVlsYU9NT3FTZVJmdklHYXBjTVVQd0llRW44?=
 =?utf-8?B?TGxQd0hMU0dzeEpjZFl2Njd2S1JyNTl2cVk3WUNZQlhSTWFqak93ZURLNFdj?=
 =?utf-8?B?dnV1VHo5OThFUWtQWDdRT2FiVkFMbkFyRWwwaWhoMlVWT0RVLzlFUDZJVFJO?=
 =?utf-8?B?bDZ3OWk1aHpWSzBiUmU0NXNqWThLWDRpcnA0T0hOc2JYVEFJUjI5dEtrVzNK?=
 =?utf-8?B?WDZPY3RjUTZhYU10SjJSRExFTHViR0hMeEdMWGJ0SGJ4SE5MRnlHT3ZjbFlC?=
 =?utf-8?B?L3lhVkhPM0lURVU2Nm8vMXFnY3BsTkVDdGZGd0ZZWlVnRDgxMmFQa29za2Ey?=
 =?utf-8?B?NEV6SDdyUmdQNm14a2JRTHFTOEFGdnBUTFBIRjk3OFZFVHcrUTVHbVREaGhB?=
 =?utf-8?B?d2FhOVU1Wnc4UUNWNjlYZ1hvZkNmakt3TXFqYWFvYnVYWmdLdnpqbzQrVGxX?=
 =?utf-8?B?UTlCT2t4MUJ5QThhYzdJejNwa29KTzQ2M042eGlhU0puOGxtdSsvWUR6VjQ2?=
 =?utf-8?B?K0tFSDdUcGIyR2tiU0d6ZUNtUWZ5QjRmclZkY3p3cmQ2VFlzM3hQQUZ4OWZp?=
 =?utf-8?B?bFg3bW5LbzVRcmI2ZlNaejhQY0R6Zjc4RmlpQTVONlR6U2gxS2ppQlRMYWZq?=
 =?utf-8?B?YkFVRWFvcTFPUjNSbE1yUFA2SFFLMGR2OG5GOVQ2bGo1U2ViYzlsWW9kS1l3?=
 =?utf-8?B?UTNKVCtQcXlrWXJSYWNJVlFlYzIrZkJ1bXV2RHhKWnZlQ1VKMjZBdUJPNWpR?=
 =?utf-8?B?SkNnZjFrcld3TlQ3b3B0dmhXc3gzV09FdXBDa0RPK0xFcUFKRXVncU5kSENy?=
 =?utf-8?B?d2NTTk9vaHZySUFzMTdQc0trOUh4VUpNMUo4M3dWdTFqdGppaWRRYlhVeEVo?=
 =?utf-8?Q?wc8KYrlA5RkTd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678f46eb-d106-4471-b697-08d976c483a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 14:41:04.6861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbeXUwsKilbNaCLbcsUUNmyu78+kEftaQtMJix72vY5TvufFKCaHWiN5lL7hFJeWKCsvC1DEGNpAG+HbY6IlBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2934
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please add a tag V2 in description explaining what was the delta from V1.
Other then that looks good to me.

Andrey

On 2021-09-12 7:48 p.m., xinhui pan wrote:
> Direct IB submission should be exclusive. So use write lock.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 19323b4cce7b..be5d12ed3db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   	}
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	r = down_read_killable(&adev->reset_sem);
> +	r = down_write_killable(&adev->reset_sem);
>   	if (r)
>   		return r;
>   
> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   		kthread_unpark(ring->sched.thread);
>   	}
>   
> -	up_read(&adev->reset_sem);
> +	up_write(&adev->reset_sem);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
