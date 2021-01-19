Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF61CC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E45207FB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E45207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B886E3D2;
	Tue, 19 Jan 2021 14:33:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324946E3D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 14:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvMye/aGDehNeEeYiXPu5JEySRzIykv5SlZbpEMCwX/FGQPWzd0JdMsTQuvBPVAWOn5j8IF0RSV4vut9RUNIfQO+xL/2xm/iDwm0J2HF1l3uFhVJlqANIwTJCSF0ClNfgN/nWWFUJKriSisYlnELyHSHFJfq1+UUeKxvn2yO68PuJZs+443834ojBIqTYsiqa6FPEQ2WJmoqh7Uoj/2ZWgmaO+U3bQBY9JYuuFzPbfME35NMaSyUGzSS59WDkLGmNL4nv4qBFN5zbmLWggbcPzvoWjvebi9pcsUAmslbNBGpGdKwLUHJ4ZAAQP5yEAEUBxAuwKiJNCoS0OTcqINtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OKhIdvOJ2rE/dZR6UQMz8mAyv3IOCKI52aiLDT1zzE=;
 b=idtgggmE7k3cYIzksG4IjMzTObO/RwVQjFa6SRgwW9KUYouI1nehHclsdfsIuT7s/bw5Z9CgH+ViwMnUSx50D+v+utdvghizYadJoZgx6TcCgoGIec/o4HkhbtdmxCP4gpvW8ys68XFAPtjLeWqObcTnXxcxIr7rocdK3TkTy0bLNLvLzzIirgDLYss3AZ2yabcN+Yslhpt+2PZ7J/2Xt0MgUzH5UhTk76OqJjdDNs22yWoyPN/vEju6eP/P/GWTpLVIbbDrQp74LGedB3pPYjpO8wSS5QWMSn8JJaLBOfMM8tz47+aDi9AlzLeKjzMPQ+pF+ngJ44ZcO7uvUmDYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OKhIdvOJ2rE/dZR6UQMz8mAyv3IOCKI52aiLDT1zzE=;
 b=KTsRWO7ZVanT0h/0CWDNDOwc7LpEYD+Mxmm2cPpJbRj/EIMgytwe7KvrJyV/nRoyetDp6+K2Mqbxy4gfsRJC77kIOxcv7Nfsk9b0rc1c0jpb96rAH9IKM5+LwRf+rL1brsoiOpbGrtLwzKfZqB/CpAvt8n5iBLU+ldwGQmBs8M8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 14:33:39 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 14:33:39 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210119122236.8039-1-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
Date: Tue, 19 Jan 2021 09:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210119122236.8039-1-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
 (2607:fea8:3edf:49b0:c1b5:6dec:d289:5430) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 14:33:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f508f07d-b318-4a66-bfa6-08d8bc87364d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24802BA72C08E18542C76B0AEAA39@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ny1MTdjYxaRKjcuj61sRh30JrFzWIV8As0raP8Me+oYKNG4yZnM7a7hmsXHW68fdsA4DaFDzYAWlu0j33BxwHKyDYCoIfNBagXe+J6uN5L5jelDd+vPHjHgTEBpsjLnW7uGlt8MPSrV+ko/8Zlnlk9KnaYx/+GyTBXpbXsZUveqYs+1ICjW88xhj59hfS44ar8DU0h2CyUl0lBVC5FQ16Q7PXPCU/1gczAcNVgJkgDmY5dO8GRLmSIT+vXP6CB9m8dg8yfCPnPBzpuKaU5uh/ZAYrV+Pqnrj5Fnk/agdlRrXflBlf/kCVJQwWHnsHQOAdkWTS4bi6hPLPGVr81nihsNSYleQzFRDqxA0Zh/3sbrS2xYtxBucD5DwZyH6Y7ElD/cI0SCYfEztmIz1sy9afwDjuBuy6Pebq2Zjv/WVbwSMu4mPUVySkI970gybIK8k8PJxkCcuBM61taufQWoCqh5Qzo1ukqsbfW4lOAXgcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(8676002)(83380400001)(2906002)(6486002)(52116002)(86362001)(5660300002)(54906003)(2616005)(66556008)(66476007)(66946007)(31686004)(498600001)(186003)(16526019)(36756003)(8936002)(31696002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?em41OGh6eVk2bHkreUwyeC9Ya3RDT1gzaEZTNS9FYml2eGM5RjhheVNpMkRY?=
 =?utf-8?B?dHdOK1llblc1cjVyaiswMWR3dVNhcFY4WWRVM1E3T00xdnRNbCtTNlNidHVK?=
 =?utf-8?B?c05UeUZyM09HN1FjSGp0clVxQW5yaUdmN0FWeVl0ZXI3RzJXZE5EZCtsNEJH?=
 =?utf-8?B?NjQySkRMUjRYdVNITnB3UVRYdW1ic2VpSGE4Ynh3RzE1aFExTlNyQUU5Q20x?=
 =?utf-8?B?TlVXWEMwZnBBMEkrL1JQcXB2MThsTTRpeXlUd2F0Q3QyV0t2UzVHN2NxMTFw?=
 =?utf-8?B?RXVEU2lKb09OSnFxVkswOEh6TkZ5dkZVV3Q3NkYzK2FGQlFFQWRKSTQ2RGUy?=
 =?utf-8?B?UkxaUDJiV3liRnFVK2RRTzRRTlZBYmMvQkN0cnRMREFBUEtYMHI1RUR2QVJj?=
 =?utf-8?B?Q0FDc08vdVJCYkJZY0Mwc0RodVVmTEsybElGRW1nT3pKalRDWnhINncvdTFX?=
 =?utf-8?B?YVM1aTdXanBIdUFtekFqSGZBUW8vVnpXS2RCVVIxRDRrZHRuQ2hnVUFLeGVs?=
 =?utf-8?B?NWJrZWk2M3BsQlRKTWgraml4Y0R6dUFhL2lRSFloeGM3VGM5QWd3RlZSb1c3?=
 =?utf-8?B?UFJENWJnS3cyTUU2QVBNeVdmM25pNEVSUklmTjVNRDNSZkNhVUg4U0RmeG9s?=
 =?utf-8?B?YWNIQTZwQlVERG9oWnQ3aFRSUzJ4WEJRd3FNVmcvME1FSFREbkZIZU10eGVV?=
 =?utf-8?B?UFYrSTFzSTMwSCtycjlqV21kVk45RUFzUGlyYXJmcWlFRGZYMENZTmdzdHJ3?=
 =?utf-8?B?ZjBxbDNMbEtXQ0RQMnE2WUNFc0pnN0lEKzdSdVEvTWFUU3hacmsxVEF5TlRT?=
 =?utf-8?B?Z2xZMzAwbENGTWRPeTB1UklqMXJzY3FNVlFqbTlmYUorSnBCcW8zRC9FNGVV?=
 =?utf-8?B?MnpjSTMyRVBhZlpQTVRac3N5MDNDMEVGcFU2Z0IxR2NCRmhvemdTWW0ydC8y?=
 =?utf-8?B?eG8wZWNTWS9LS2d3UlVUdHBOWjhzRXlJdENpU3VCcFJ2NE1DVEZRMi9FOEw1?=
 =?utf-8?B?MG1ucXRnSWdSSkU2Ym1uWFBxektqK0FsSmZmTTM1QXF5QVR1dThUb1FZeXRp?=
 =?utf-8?B?ZlZVZjg4YU14blhSNTFZWUYrVCtERUtmbWdDUEVVYWVJcnE0OUFxUGlhVHpQ?=
 =?utf-8?B?bmNpU2Z1elJKcjM3Kzdwd3VxbUI2MkhTNDNhMnVRZkdQUnorZmlSKzZFNU5J?=
 =?utf-8?B?MEZKT0IxT2RQS0J5ZWFRamRPQk11djlEUFgxSHVxNTUwRDNHcUtTalY1eDha?=
 =?utf-8?B?OEc3dDRDM3hEWDhPTWxMamxOQUloWVlWOTA1RlZDV3d6ZU0vUXgxM2RuZEVW?=
 =?utf-8?B?KzZqV3h1QVRpZ2V0dUxLelNnM2EvZk5QN2IwSjM5L3k1dmw0SWI5WGVGTmFq?=
 =?utf-8?B?bW1uQTlEZ0xpOER5UEh2c05LbitZK3JJb2FRZXBKVk8xdDA5THRZdzNBS0dF?=
 =?utf-8?B?Zy95ejRZRlBGNytzOE5RSTdhQXAwTW9SbkJTRXdGOVQ5TGgvSFNqcEp5eHVH?=
 =?utf-8?B?blJnZXlnR2JwRVFMRWRUVXlsUVllTEF2QVRIUVFhK2hHUEpGanduallacGV3?=
 =?utf-8?B?QjZvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f508f07d-b318-4a66-bfa6-08d8bc87364d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 14:33:39.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cczNjHiqIBH0OA4w6ryCQK3+X0MUTEMutAD3OvvaRuhwdOVmDaYGEbXJDGj14QQrbvO5Tn2eqZqL14gCP0OAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
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


On 1/19/21 7:22 AM, Horace Chen wrote:
> Fix a racing issue when jobs on 2 rings timeout simultaneously.
>
> If 2 rings timed out at the same time, the amdgpu_device_gpu_recover
> will be reentered. Then the adev->gmc.xgmi.head will be grabbed
> by 2 local linked list, which may cause wild pointer issue in
> iterating.
>
> lock the device earily to prevent the node be added to 2 different
> lists.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++-------
>   1 file changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d434803fb49..9574da3abc32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4540,6 +4540,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> +	bool get_dev_lock = false;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -4582,28 +4583,45 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 * Build list of devices to reset.
>   	 * In case we are in XGMI hive mode, resort the device list
>   	 * to put adev in the 1st position.
> +	 *
> +	 * lock the device before we try to operate the linked list
> +	 * if didn't get the device lock, don't touch the linked list since
> +	 * others may iterating it.
>   	 */
>   	INIT_LIST_HEAD(&device_list);
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>   		if (!hive)
>   			return -ENODEV;
> -		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
> -			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
> -		device_list_handle = &hive->device_list;
> +
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			get_dev_lock = amdgpu_device_lock_adev(tmp_adev, hive);
> +			if (!get_dev_lock)
> +				break;


What about unlocking back all the devices you already locked if the break
happens in the middle of the iteration ?
Note that at skip_recovery: we don't do it. BTW, i see this issue is already in 
the current code.

Also, maybe now it's better to separate the actual locking in 
amdgpu_device_lock_adev
from the other stuff going on there since I don't think you would wont to toggle 
stuff
like adev->mp1_state back and forth and also the function name is not 
descriptive of
the other stuff going on there anyway.

Andrey


> +		}
> +		if (get_dev_lock) {
> +			if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
> +				list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
> +			device_list_handle = &hive->device_list;
> +		}
>   	} else {
> -		list_add_tail(&adev->gmc.xgmi.head, &device_list);
> -		device_list_handle = &device_list;
> +		get_dev_lock = amdgpu_device_lock_adev(adev, hive);
> +		tmp_adev = adev;
> +		if (get_dev_lock) {
> +			list_add_tail(&adev->gmc.xgmi.head, &device_list);
> +			device_list_handle = &device_list;
> +		}
> +	}
> +
> +	if (!get_dev_lock) {
> +		dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +					job ? job->base.id : -1);
> +		r = 0;
> +		/* even we skipped this reset, still need to set the job to guilty */
> +		goto skip_recovery;
>   	}
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> -			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> -				  job ? job->base.id : -1);
> -			r = 0;
> -			goto skip_recovery;
> -		}
> -
>   		/*
>   		 * Try to put the audio codec into suspend state
>   		 * before gpu reset started.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
