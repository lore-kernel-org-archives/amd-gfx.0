Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 08:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216C661B39
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 08:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 216C661B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8F56EAA6;
	Thu, 18 Nov 2021 08:01:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E306EAA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 08:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc7i5oVQ6I99Y+0u/dhEWczaHcY83AldHZZV19VBqBNfy9e15ZJQJaSB/vWbXyK5NbLWjVZOmEYAN0GYgGoV7f9t3fPww3S+Muk9/uRlsdW10fIms7E4zotTLOh1+qx6GA85trY/WToN+YZ/lzmOFQiSBHaCVnVMSadLXNc5u4F0KNv6nKB0jhTYVQWg/WBUWSiCn+lsPkHs4/LVRYlaw5vxwKwKzcvdkBVI58zgkiizeIPfSAraxa4RbA78m+05UTZ2kbkXyWNkTJgZfRsQUVuN8Dq7xDu3JS8RN1Ffq/PIuP7rTt03wc/nxPaJ9d+WfazFemRV37OC9nfigQ8uHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOknuuwH4JT96rqlkRy53HLC55Qu6BADDW3mFzqppSY=;
 b=gMsZjt1hRwSwUuLIIm4XD6D2er21WTTDpJ9g1MWl/hnGnHonsIvnt1C4Xe6dystQyJNTIb6XklPl5dcYA9kYxPC5TzT4nVdhGuJzn0ime3mgDUcbIu8HeicnuzJSISWE2sU24l8Lpjd2Sx5pnxwF0xGJu4JJo14nRdPyIogYobFMJA+wgdL8e635Yj9zJCJ8PfZwWf9ToHFQGvUL9VR+9/dnQ+ZTHwIPCh6ZPlj6n5k4QqCf2QQIZA9E6Bu9LrecN65PhKl/PFg/JOr4Z1HJFiBBZyq/b2NgU3Qqig+4slruO762pNMgRqZoa0sXmizfKBdaaNHiIacQRdT+FBMjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOknuuwH4JT96rqlkRy53HLC55Qu6BADDW3mFzqppSY=;
 b=0qFEIZNpRJlf/LOxPqqcKdeIV9qaJ61fRWKizhKmGg11mHxyOmuDj8T8PJS0ghC78SWMTpCFyN8jc4CDK6oq9Mwom9+3eQG8dguWHKKAR0gCMi9346Y3oj/sYBpTxm6hjo/iwjRhuBsCmOeG2h7fwwDiy4cYvDlp6Vjz6YdL5dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 08:01:13 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 08:01:13 +0000
Message-ID: <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
Date: Thu, 18 Nov 2021 13:30:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::29) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Thu, 18 Nov 2021 08:01:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6e26ce-670f-4af2-0436-08d9aa6996ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404E610E1448848C2EE058B979B9@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UI1nbG/HOHnm0QMllHbXqGAmxnHxc5x3BDdF+kNYj0OhPzMnMVVj7Z1yayq2j7qBPV5EJB4Fz3IWswqP1mgN5LI58mE19ZqRob8RlAVoNm/qQ57rGu1o5iifwgZJzXZ8f7/XVA1ttTWSUDxh/tEhMVr3R5nqGUBBct9ramfATdf26pYaOmS0AfxODrTa9xacHRoNtYJhGSpY3dX8Td+GF4ffjbTlDwHuJaZXpdVEDX9zU6EP1P1C4urxRVfb03dHWFCGpsnhPdLgj+LSL6yk2DXT1MjRiTWubcIX6vAPcCVhxmTFEiOgpqgemakZirgy2ZBIf0MlyveaGVdce6ONTGOcshSvPLaRsvCT0oqfn+tGZ2887owiH9qoARWJCzadDgTpwJgFTjdqbym08B0YuG+H8NEolO6gxrIR0fxptJDiu+rDXonGAlkDnXoRxpCANwnB6SuwI8VqNln2DafJjfrP9f90ciXU0XlCqk5blwzUV5etJrSeGxZ2xi5HM4l91BTVdnHcm3trazkqRYjLB0Ad5GWpo5UcDnFUr2Bl6f7qIqcC6eGYQYMb1K8SR6tqkOX4L9Wcb71c3bVFjiySBb42OSx85/geH1AdMWqNNL/jVr8D2JcxrL3RxzY5QyTFfNJdGpX0CVSWJO4km2AyhcULN4XawxMCJx5ZpSuZvX1v30kl/VMjBN0G5YVkX+xp5+FveLVfbNqJW1J/FpT7vUec78mT1eKrgY340tTUloqx7ZNeTKttyX5w37kLj/h9syPHg2+m6xWfiFsFv6gpZw+RaeHBE9LnCfv/ScWmsIx79VWIvk5W3oymXcPA3v+IJBIXQrtCK74fep0RFM265g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(31686004)(5660300002)(956004)(186003)(2906002)(966005)(6666004)(38100700002)(2616005)(83380400001)(6486002)(66946007)(66556008)(53546011)(4326008)(31696002)(8936002)(8676002)(508600001)(36756003)(45080400002)(86362001)(16576012)(26005)(15650500001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHYzQkh4RVVhQ1o3WUlWMVBCc3NUOHlqTXhzM25zaktjZGt3STRlYnZ2Mm93?=
 =?utf-8?B?R2FDK2N0OTFRc08yeVNmY3l1blVVd041c1IySEVnNlBQKzluMlgvallSS0Fr?=
 =?utf-8?B?VWZTN3drbFZHbVhZeWlTSm5zWThBTjdKUERHZXpxQW9za2hDdXZSSnRvYUx5?=
 =?utf-8?B?K3ZOcVhSS1lpaHYrdllIc1l3WXE3SHRBRVQ2WGxqcFBWUzNVbzVtNUhGUVRv?=
 =?utf-8?B?ZmNHRVZSd1lvbkx1RXM3TElTT3JwMFlGMm15Yml3eUNrei8vWFZoSjg1MTQy?=
 =?utf-8?B?MlZSeHFENkNlSDZHdDdMZ2llTzliWHN5bFFJQUVlbGFkbFcwVXVyT1lKbllt?=
 =?utf-8?B?NHVCcWxvWGNqRmZrWDB5L1h3bkU1czk3cmxDam12V00yNkUzWE5vVW80VWdV?=
 =?utf-8?B?NnNhSS9yTWVyT2k2Yys0NlErRTFOYzRKQWJwa1dUYnY4eGlBall5Q3lKS2J3?=
 =?utf-8?B?WHMxS2huSk82VVhuSW1SR2svZEljT2JROWY4cGY4MWV6dUo0TEEyQzE2YkVp?=
 =?utf-8?B?MS9JeXZuNUxxTVhrbXBMamQwcXBBRi9yUE9LQXQ3M05JS05hSkxneTNpREdu?=
 =?utf-8?B?WmdySWFiOXZNZUxBbENIdmMraXNnY1lFUkM0M1NoQmROcVFlUDUwaGg1KzJ0?=
 =?utf-8?B?QWNYYVBwT1diRzIweUZZb01oVnNYamJaK2t0bXNnNElXN2xDTmpsQ3FQdjVn?=
 =?utf-8?B?RGZYVFdOYk01aVpmNzdVTm56VWlsVk9BaUZZY1hSSGRuTWF0WmNEaGl2bUQy?=
 =?utf-8?B?eU9pWXZGNy9FZEtISDBUTmJ6L3ZvREo1UW9WdmtxSmsrTDRZOUZPdHIwU1Nq?=
 =?utf-8?B?QlhxcCs5QVd1WFQ0UkVUcHc3a1RreG1FS3g0SXZiaDVEbU0xeGpEYlBSYktB?=
 =?utf-8?B?bjRjN0phNjNoZUZIYWluNUNtM0ZWS1Z2Nk1sRlJrMW1WS2ZaUW9aeGVDeHZD?=
 =?utf-8?B?VExUcjBKdnhIQzVmbEhpSkpZdDhBV2Nqbmc5ckpLYWNUSC8rWFVNclE3dTlL?=
 =?utf-8?B?M1ZBbVBMd2FueFhjUHlJam1tbVQzbWJGVmZlYXFiQnFYUytMcW5JUGJiNElG?=
 =?utf-8?B?TEROejdhcGx0eURRMkZUcU91cUh2ZktTbGNoOEF1SjR4MlVPdHRHems1c05C?=
 =?utf-8?B?WkJId0hNalNITlRQSEhYSTdXSEE5cTQ5d3ZMNG5qN3pOeFB5NlRJREYyNSs4?=
 =?utf-8?B?c2lyY2R1RnpGSnVvRFA2VnNIMHk1ekdFdnhaUGJJQ25YWG9OcTZZcGVNZUd0?=
 =?utf-8?B?ZXdCMDBDak1UOGVFbHlPc0hIejdKV2RlMmlTdzMrR0NDUFBhSkNtazY4MVox?=
 =?utf-8?B?cFo0QitJWC80bkhDQUM0MnZrZDkxNUlDQ2NJZDFSSlRMbytKTVpzdTRSeHdr?=
 =?utf-8?B?Y1VoekFCc1Q3TkNsOGo1TWVFQitGTCtJYTZuQXU4eXZzN2JKSGxJV2hJR3pO?=
 =?utf-8?B?YjhBMDlCL3A3ZWVnYVZGNzVBN1FMU0dUMVdpRlBrQ3RZUnRkNVErY1NiSmNF?=
 =?utf-8?B?RlpNNTRsVEdvNHFOUTRrQTMydkpnUmppQW9ZNzFKZ1FkeHdGSEZjQ0xDM3di?=
 =?utf-8?B?REpSRGxzRmtVY2JXeVZzY2svMEFTZjNxNnFETDhOekY5ZW5JdXlMbmxtcXhk?=
 =?utf-8?B?SWtHYlprWko3bVV4NC95SDA3Tm9BcTZONXN1RUVYNlBFaE1SS0hiVk8zTlRj?=
 =?utf-8?B?YVNjdFNrcWFFeXRwUmZ0YkxQMUJudkZWc2s2SXpkeGdVbllVNFk0dWZUZWQ3?=
 =?utf-8?B?SjErdThaa1JDSjdGTW15eFpzcEd6NFhoV0pFd3o2YnZvazZmWEdxR0tSU2xD?=
 =?utf-8?B?LzVuc1dpK2Exc0s1TUM1YUMyYm04YUJNbnNYZW1sUTUwaFNMOWoreTJLbkdN?=
 =?utf-8?B?dHA0NWduSGZFeXJHemd0bGN5bUREUDhTTFU3dG9xem55WjFKQk5xMy9FUEw4?=
 =?utf-8?B?Unk4bUw1U0l0K1hvaFBBcjZhMkxMOUxMQXFabUxKMnViQ3FSWVBEQWtETFQx?=
 =?utf-8?B?V2ZBaFZIUUllNGIxTnl5QWgyNnlrdElqeTBETUtIdlYwNFNXSURnQmZKdVhi?=
 =?utf-8?B?K1ZVa1ZxSkhoNWE4RmxpQlVEdzBoRUZPT0VaeFd2a0ZwQ2ZEd1Y4QjJxaFNX?=
 =?utf-8?Q?kiQs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6e26ce-670f-4af2-0436-08d9aa6996ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:01:13.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvWKjyfQn4qTwjl4htyusMtdnoPL6/e5Y7FaQMTRmBez/O4W22UC59g+OLlSOr4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/18/2021 12:32 PM, Prike Liang wrote:
> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
> to keep AMDGPU in a clean reset state and that can avoid re-initialize
> device improperly error.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19 +++++++++++++++++++
>   3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a..8bd9833 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
>   	bool				in_s3;
>   	bool				in_s4;
>   	bool				in_s0ix;
> +	bool				pm_completed;

PM framework maintains separate flags, why not use the same?

         dev->power.is_suspended = false;
         dev->power.is_noirq_suspended = false;
         dev->power.is_late_suspended = false;

BTW, Alex posted a patch which does similar thing, though it tries reset 
if suspend fails.

https://lore.kernel.org/all/DM6PR12MB26195F8E099407B4B6966FEBE4999@DM6PR12MB2619.namprd12.prod.outlook.com/

If that reset also failed, then no point in another reset, or keep it as 
part of resume.

Thanks,
Lijo

>   
>   	atomic_t 			in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ec42a6f..a12ed54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
>   
> +	if (!adev->pm_completed) {
> +		dev_warn(adev->dev, "suspend aborted will do asic reset\n");
> +		amdgpu_asic_reset(adev);
> +	}
>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
>   		r = amdgpu_device_asic_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index eee3cf8..9f90017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	return r;
>   }
>   
> +/*
> + * Actually the PM suspend whether is completed should be confirmed
> + * by checking the sysfs sys/power/suspend_stats/failed_suspend.However,
> + * in this function only check the AMDGPU device whether is suspended
> + * completely in the system-wide suspend process.
> + */
> +static int amdgpu_pmops_noirq_suspend(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +	dev_dbg(dev, "amdgpu suspend completely.\n");
> +	adev->pm_completed = true;
> +
> +	return 0;
> +}
> +
>   static int amdgpu_pmops_resume(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> @@ -2181,6 +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>   	r = amdgpu_device_resume(drm_dev, true);
>   	if (amdgpu_acpi_is_s0ix_active(adev))
>   		adev->in_s0ix = false;
> +	adev->pm_completed = false;
>   	return r;
>   }
>   
> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>   	.runtime_suspend = amdgpu_pmops_runtime_suspend,
>   	.runtime_resume = amdgpu_pmops_runtime_resume,
>   	.runtime_idle = amdgpu_pmops_runtime_idle,
> +	.suspend_noirq = amdgpu_pmops_noirq_suspend,
>   };
>   
>   static int amdgpu_flush(struct file *f, fl_owner_t id)
> 
