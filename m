Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB41CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D7910E0F6;
	Mon, 11 May 2026 07:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUBMtCzM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E74F10E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 07:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lhfp/6cs+AFgvH5dw1a0YxtgloQ50Q9sAIiYX16CfoHw9LUIX7J9ziu6VKwAP+hUGQYf6x7ferQGmdGeqKwjcZB4X8dKIGDFn2szFb5fDbRx6Td9llUZHmbP0WWdlgH4BPG7Ur2qqe59Acqy+a/V8WPVEFpWMe9LptuWWRv7cejLniq7j3uTGCbhg9fjr7X2lnETbUNc+lHOlILb/btpYvlu4H9TrPmHkxMvAxYepZ5lKNjnukYo3tu/KpUVBEhlGjeVNVtLixlIksrJJyo9I8w/3iwFNSkMlCEbTneoTGgTEfx09MTm3yR7h5CfOzarhLTvh7+vWte/SblqtzOrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C7iQ7pdRFxSN2UY30vqd5lAotji6jRsI5TrtJaSSBA=;
 b=YLhdZS/OrnQrafzD61+0gqPoTjj127oPV8MLW5SUI51/zmoUb36rkCnNQZuTjLVZ/WCkdmtqAf7VvdeJkvBOyk+VRXL+VN5DWc3H7WakEbaCj3Su4WLT3l25MtDzbVmiJL1uReanhK9vqmoHaMx84VZDacB7zDhW7/Duy3fgWVDw3sE1PdnaUEHjsWXSN7zysybt/obfwzzZ7ORotx0nAzIH3oBA63v9llQ74qWHXibsGvQhOPgbTaGZCSRDaSeyyErNI1FLZ15+eXtl9Igd+qUw7iNqzTlFjzOAhvE4zyTbSuzqPbHuCC5ZaphAhqkPXxAWk6IWafOKuG0B/7D2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C7iQ7pdRFxSN2UY30vqd5lAotji6jRsI5TrtJaSSBA=;
 b=vUBMtCzMj7x6zn56lF4yTL//5JSwblos5C+Eekysw3qXndUh0gm5fUxX8s8iyOBXX3lpsZ6RKwtQFSYzI6v7lwKmlYJYvkhLFV4t2BYiexipIFo0eXk+nBRp/EreEhDTgrZtq143y8MEm8OKmTmml01z4ljXFi8ZPHbCCXQNmWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:52:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 07:52:56 +0000
Message-ID: <441f8164-7f74-4740-b2f2-77b2e4c600e0@amd.com>
Date: Mon, 11 May 2026 09:52:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add rcu_barrier() in module exit to prevent
 use-after-free
To: Chengjun Yao <Chengjun.Yao@amd.com>, alexander.deucher@amd.com
Cc: sunil.khatri@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260509102025.1259927-1-Chengjun.Yao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260509102025.1259927-1-Chengjun.Yao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9425e0c1-f627-467c-c2d9-08deaf324fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Tm4KTQD0KHOglvXtah8lyKtyEv8QZuXldfm+ypMm+D0Ye7F4eL/5XgO0nmrGAjoMZSgi4ws12UYQi2IU5dcoRkKbUYYfKl45lBTe/Sd8TWJ6d4HYi3LNZ/90WmZCqCtNJ2Umi9kSMqrS78P8GKMl5EzDH8TTWhXvx7jz2Ny6fi0V+VSzA6QmRzyHF8ZGcxXzvY7PTpYkot0YMdt8LC3XaSr51tPGPapOQZKK65jG9rP17ijA3Soq0pfBhXDG1dfLM04VAxzV+jJ4jSsO+9/w7vd61MoQq7K1MGMGbLH32GTZH1dqXjd5+WYnhVoo7xfM4FkahRi4Mus4+olUlfb5JTJ8chUgaSoi7o63IrTOf4o6yN0udlVy1CMakoVRrPFHdoTANFFc+rQ+Tmn2yVjyA41h+hduSZUUquBRDWqaYd0k+MA03sYx+mx/5+Gi2yEmAigh8tWuSw5Abxh2UQATmdNuvanoTkVsi5SYd1X/sJ2DmSOtayCDDLGBfVDo9TwNtzdAUi4UP+0GVCmjhLcVsee3qmVnAZJ6eXCxkcq2F1+ad9yfZUM9LKbJ1wvLRWhA0aHmxqACnOZVm4U918ef1iup1ePgIWpDBDVLvDS7awMoOfJtUwNgvRhN3UPHZWwI/foj1MZyKFyEjZM2oo5yIMWyLxnqIPHGlppWIoTbn+5Xsg6BRUjzpXGQkcT5+N5E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2QyaFhLUXdZOUhITElETGdWWElzVlYrR2NiV25LSGJCYXduMzFtSi9HRkx0?=
 =?utf-8?B?dWMzRFY5N0ZqdUdTaENQNHEvaUxJN2JDUXJvbGhzZEk5Uzg2Y2lSZzBpYWpp?=
 =?utf-8?B?M1NpcnVJSXBOUElEMmk5MHdLbTFxSURJV2J1QkNKcy8vN2Y0RnZqUDhQSjky?=
 =?utf-8?B?UE96bmt4aWxabWVSRkhqN285VFZuTkE0SkVBWVpnalhiMnpWQmF0TVpZU2hr?=
 =?utf-8?B?MDRzTWh3VnUxNkhPN2lteGZjVlhYWDY2ZjhIb0Q4TXR1OEw1TzFtRnNFRXZx?=
 =?utf-8?B?ODNDalMyOW41OEhhdXpZZm1jS3B3S3hYOXZUSXk2UzBpVDJkUGh0eDJER3Js?=
 =?utf-8?B?aGtjYmRvMGdQQTdyU1I4dlZDTFpkTm1vcmE0VldraHQ2UmkzVkZhb3hVUERG?=
 =?utf-8?B?aUk2M1dqK2xBWjZ2cE03eHMyOXVoZVl3b0ZmYkV4V2JyM1M3MDdEaGI2ck5n?=
 =?utf-8?B?M2Rkd3l5SFRZdVVGdS9Cei94M3k4M0dwdEJoMDVJYUM5NWFTbGpZTE5vY1cx?=
 =?utf-8?B?d1FUUnlZb05XMm5vbjJFRG8zVzdjU1VVZmdQTTJLRDZLNlJiRERBa2dVRTlE?=
 =?utf-8?B?R2RnZmZ1OE5xUlFNaUtKQlA3bUlvZzE1ejVVWitHd0QvajBIakUwQU9halpC?=
 =?utf-8?B?K3BHZ1UzTnlGalRhOElLNFNkYUJ4ckEwcnBqSlBEOFIrblcwbGFDOHk0NkpB?=
 =?utf-8?B?SytRc1BZZWs0dWRJVUtqQ2F2YjRuM0taUWU1cVlVeW85YTVTSmthaFUrQytz?=
 =?utf-8?B?b1FHWkN6NHdBSmxtc3BhRE92dW44cHVFcmF0WGxCMU1HUHE1WEMxRmpiMCt1?=
 =?utf-8?B?QmhrcGZON0hKeld2VTA2c3BXb2pwYkRlSVJJT2phNVRhb2o3VThBMnFRNEJu?=
 =?utf-8?B?ZGFxU25nSVJxcG9YMThPWEhtcWQ3bWlXblJEWElMWFRERjBBUHZHNCtGam9B?=
 =?utf-8?B?T0lST280RE9sZ295L08zb3RuaUFhVE0zVEN2Y3dSU0RES1lSNVo5OEpsSDBI?=
 =?utf-8?B?UXhnbjVabUdjc3IrV2c4b01TYncwMzZpZ0x0TXdPUlhFZHVUNmc3ZW44RUlN?=
 =?utf-8?B?UkNIOGIyajRhMDhHSEZSVFd0UTJpbk84aWUyYThqeGJpYzllbGxRZkRYaUxO?=
 =?utf-8?B?SWJLODNJK3ZaNzhFUGg0bkVBcVRsZUpNbHRTbENIQnFMeSt6UFY5WXB0Wnpy?=
 =?utf-8?B?bzVhd3pDc05YRUdyK0hqTFZVY0o0a0xiU044Y2pmd0s4V1hmQnJob1hkRzFD?=
 =?utf-8?B?WUVzMnpZY1ZFdkoxaVlnSjRQdWhhTEZkaDhCclV2czJvMmdWZitaUU92TDNG?=
 =?utf-8?B?bUhwb1VaR1VkS25OeXRpNkFZS01qY3p2QzJQR0RaY1RqeXNCS1Rmb0JqSnY2?=
 =?utf-8?B?MXcxaW95M3JwZm4wTnF6MFJBSUpnNldOZzBXVjlXVEhCeDRPMG1PL2h0cWF5?=
 =?utf-8?B?RmtXSnlhY0MzV09KR0duelNSSFJPR0FZakQ2WC9QYkUwODdKYUc5NzJUSUpB?=
 =?utf-8?B?VkFwMmdYdURKZ2FlaW1yQ3hpUTFyNVBBanhZTDkxMTJzUFV5N3R3TExaU2hW?=
 =?utf-8?B?aTBrckRBMVhHUno3QlI1UzV5ZTdGUkVBY3d0N3ZlQm9CeU5nd1Z1bkR1bE8w?=
 =?utf-8?B?bG9hLzh4WmgyWENYZ21tWVJYdXY0Q2lNdm9FSy9TeVpXSXFlS1NNYlo2bnBG?=
 =?utf-8?B?My9VcHdSbVJkUEFnK1FWYjVjNkFZblRKa0ExS0QyeEltM2tLM09NU1dXQzc3?=
 =?utf-8?B?VHRJeFhLWGlMN2d5cE9rSzhqVFRYQnZRWmxKWHI0YkhRYVErV1JzMzlUaTJD?=
 =?utf-8?B?bk1ZVVBpaEtPRXo3VmhmdnZ5SkJLMDNCZ3pxcmhZc3crWlhHYmM2UUxyOFZC?=
 =?utf-8?B?Wk10TG1oWEwwSUVxRHVuSDdOZmcrV01kbG15M3RzdzdQMytmSk9Va0FTeWdj?=
 =?utf-8?B?VFpRYjdpSzFzU3BCSmlTYkM5WHJ0WEhOeURpVGpRRzVUUWt1bm9ycUg2Umwr?=
 =?utf-8?B?N0kxbHBjNzhSbkhMVk5XeG1oZmN2L2FxM2dQZDhta2ZMOFNldzJxOUJDTWhS?=
 =?utf-8?B?WEFOdmZHWjNRWEJFbWFVcDlDdG1hc3pXT3Zyczc3R05WWXBQcnJmV1kremlU?=
 =?utf-8?B?YVpObFFUT3dLd0lZaHZsU2JqRTY2aTRKZGlxM2FaNkNxRVh0VEgrazYvT3pP?=
 =?utf-8?B?czVxR3k4ejMweE1qWjFxUUNzQUMvRW5pVng4RmQ1RGFrQWlEMFlkRnpKTmt2?=
 =?utf-8?B?R1lrRXNzRkl2ejhNY0xpaTRpVDJzdDd5dFBVU3hPS2pPZlFzblJMQXhYWC9E?=
 =?utf-8?Q?sq0d+TnjP2tlkr/VAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9425e0c1-f627-467c-c2d9-08deaf324fe1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:52:56.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewb3zVinTIs2qoUSfpC+YBCorKSV1nMEfGTwaM2oQF5RK36+Am6LB4bbncDHVAx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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

On 5/9/26 12:20, Chengjun Yao wrote:
> commit 9c85025c7ac2 ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2") removed
> the dedicated slab for userq fences along with the rcu_barrier() call that
> was in amdgpu_userq_fence_slab_fini(). However, the amdgpu module still
> registers RCU callbacks via call_rcu() in amdgpu_userq_fence_release() and
> amdgpu_fence_release(). Without rcu_barrier(), pending RCU callbacks can
> reference freed module text after the module is unloaded, causing a page
> fault in rcu_do_batch():
> 
>   BUG: unable to handle page fault for address: ffffffffc115e910
>   RIP: 0010:0xffffffffc115e910
>   Call Trace:
>    <IRQ>
>    rcu_do_batch+0x1c4/0x7f0
>    rcu_core+0x14d/0x330
>    handle_softirqs+0xd0/0x2b0
> 
> Add rcu_barrier() to amdgpu_exit() to ensure all pending RCU callbacks
> have completed before the module code pages are freed.

That is just papering over the fact that we don't support module unload with our amd-staging-drm-next tree in the first place.

The fence code can crash even with that RCU barrier at the moment.

The patches to allow this are still not back merged from upstream since they went into the Linux kernel through a different path.

Regards,
Christian.

> 
> Fixes: 9c85025c7ac2 ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2")
> Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 99688391e70b..e9681eea122c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3193,6 +3193,7 @@ static void __exit amdgpu_exit(void)
>  	amdgpu_unregister_atpx_handler();
>  	amdgpu_acpi_release();
>  	amdgpu_sync_fini();
> +	rcu_barrier();
>  	mmu_notifier_synchronize();
>  	amdgpu_xcp_drv_release();
>  }

