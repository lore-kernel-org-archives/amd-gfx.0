Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ACCFED2F6
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4694510E9C6;
	Thu, 12 Mar 2026 09:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ETEUnGr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10ED10E9C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBhaUGw6XVIu9lDWfsa+l3tV0CbVgltSfmrBTFenRnB3MJR8os0nPiVg2lRRQBpAv4G+66Yhe1MdfR2UemezJ2H7YrhEAWfMEpnxHgJCqJTrzHZ2hK7q6jSXp8GC1i3YNd96xXenZAfeOaWCd6eWP7fbXuNnGMEsFZTyTUuZXO5qVv9uOii966UwAXEkbxTYR5Hf9rdRGaYnnu5wGp+9EfoI4mhjQyYbJR3c4MoA6mJLvWgCWgNYxeD0a3/u09gUg4AYsAkDATtVQv1mVKoxew5qQoUrAC2J1H4EDXj9RIEfaCMyBJcPanIDQVRH5z1NLCGeBGp7gKN+j0HrsY/fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pIVTKLLaiNYhVTA/c8ROLtpL+11bNMq1Hw/oaa0TQQ=;
 b=KlKVJJ+WWLJjuB9PLY+XT5MdZjZr0bfP4dVL4mlHsZHrinCC0mEE+d//iNrnHUzqjrzYoTQtJFMxj8oY8Yo6LcQfHgFYTNpJLUOEXXZkks02ggAgb+Zj7VRJzHx/RGkgl8ntCPJmuAVM+uhDWNd5zq52ikdRB/CTNx2YCcA+ED3TPGNCzpQqt7WqJNhRXgAe+NAxw7Robst/irpqTU1ZOeTRW027iM0zEBhnFskvkSok5THTdFLi4AvfoyP/6dC8XwGABxB0dgtQ+C2Ef8OzdtGIrfScs4qImXAI4lLPCh1k98oFOhBmrKZXrELMxKFh3cWLlYCkHVqmUSz+ktTIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pIVTKLLaiNYhVTA/c8ROLtpL+11bNMq1Hw/oaa0TQQ=;
 b=1ETEUnGrcBPk8bwVKPGsyARqHr6864v7a9JHMoGqeQMV7tONW9la+itS77vO7H1KtdGJAlFWBaOWUuCXuf16ACSwDXeqEcZASGutXHEjDCJ7Iw8uTzdc7DiuUxLkJ16lxQKUftEDNNWDC/6jPZZOt1OIYLIWlVslxG5YVRYZ3o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 09:20:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:20:53 +0000
Message-ID: <a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com>
Date: Thu, 12 Mar 2026 10:20:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: unlock cancel_delayed_work_sync for
 hang_detect_work
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260312091655.1948356-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260312091655.1948356-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: c598cb3b-354b-452f-81e8-08de8018a8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Ihqjq4NhoRywToQXWwfJU42DgIq5Z3n+lkeQK11j7JM6Goqv+OG3bea7GghrfbzSZMYFN8CdCsTUbQYC3phQ27RQxY5YKS43m9H9jh8DQLj+6k8dc/8DLEfTirI/fWuGWLIjTydJ/XrsCKN2I6zcz6dgXbGs08/Qd3mniZzIcdtDwnSJs7wY0c8B8E22hCR8Z/g6Msr4pJdg8NwjHqKEugpuha8HuIfcjSYxn4yWeBI2GjsFrFC+49WtbHIWp/B0K62GstiB+O5HgMCXoj3+k9heLRrFxBjy2hL/LD++NO9N4toj30g5THw+MTk1rfwvFXCLgAV7BFAcw3zJ+gVv8bzOMws+5j6lrI1Re4Mwc4kAS4UVNv68YToSrCL+XQp+z9XCiIegvvJCx5Vxsb+wiXl05BkbMrnN8vXLWTS4zMdukvxxpR+hE2bUVrWCim90n0dVacex29mEz2nbBiA+Fupg1UnnDxz/wSFw7E3uZhnwBNpy9h2TokImDcnaBjuYQdk12XGFSibpHU67JS9zj9Wpp5GZNMZZJwvucBGLoMMZWyWjLlHCCRFgsT9MunGTTtmOLvYGZVUKIpE17KALcmnMyjsyqDDnCwEQxtub7FAxvpYtHMkB+CUOWQezPwGy5/KxzTMnTjyj4SxJms5QQZDFRPlnCoZ2c5erVhcZ7FPezO5Y+OT5FrEsNF3MEcaxLESrYaozJTW8dijDeIXrm9L6vl10Yfm9qdstnpsMT0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3JDRlBKNzJwUTBmdUdmbWJ3dDFkQ1owSTRKVEJ2WjFwSVFGRXkzS2NYMGlo?=
 =?utf-8?B?SlNIS3pKOXdOQ2FsNE9KRmw2QWEycnNpdTB1UktESkltdWs0UEM1SVNVQkE2?=
 =?utf-8?B?bWJGWS9YNmxFNW1aRjNyUW1HK2VUZGloQWhYeDhQaE4wejZqOVkwRVRwNlhY?=
 =?utf-8?B?ZHJvOWpFVS9oMzZLa1dvd1lyNWJvdUlaUW9kVXBlYWNmMnBVcThjRHlGeGFz?=
 =?utf-8?B?UnlPaUZyWEc0MmF1ZnhxQWd2Uk5HQ2tjQWJBeFB3R3pYQ2lnUUlFWkoyTldH?=
 =?utf-8?B?RldNWkpnVjk1Sm5GNjVSNWwzSW83cDFRVDZnV1NvNC8ybTd5NEFMYVB4WFBI?=
 =?utf-8?B?RmFPMHE0SlBoOGwraFJpZnBuODJ2NThUczlBclh3eUs0T3p3eFhXRDdvVEhB?=
 =?utf-8?B?bXdSSUJhREVUeW10RHI3TmUzS21NTXZqZ3c2ZXR2YW83Tm11QW5JUjJsaGd5?=
 =?utf-8?B?U1owcDJyc1ZESmlrR0hYeVg5L2JPeUp5VFlJOEo5c2FDM3ZnNm93QkpicTNG?=
 =?utf-8?B?a01Ka21xSkFyN0JEMFk4RTZjTXhyZTVzZk9aUVZ3aEpvWjQ3ZkgxQllodFM1?=
 =?utf-8?B?UWIzOTRYZDU5SXVuR2J0eXVIZXA4YmdzOEdLWHN6QmVrdlJjTml4a3BaMFh3?=
 =?utf-8?B?VEMxY2xDaDJMc3FFSklCVE94aXQzcnJVVmpjNWNhWFdvWlNPY0Rwci9QOU9z?=
 =?utf-8?B?dkd6NnZpVitCblB2WksrS3ZnVnNtVU9KOGVsMCtQQ05NN2xWbGdSc0NDK2d3?=
 =?utf-8?B?WEIzb2gzK2E1bzVBYkZ1SnM4MEUyMTJwM2crbDgyckphSVgrY01PUkticVl3?=
 =?utf-8?B?Umh1Mjd1VXVvYkhsVUtYMkR3RkV2OFp4T0lnWW41Nk55b2g5NVVrTmw5WWZ2?=
 =?utf-8?B?aUFScS9BRXg0b2VyZ3hjZFBnaVhVSDV5aGNHY2tYQkpER1ZKNmpsUk5hc1hx?=
 =?utf-8?B?M0JsVmVDMk56Szc5cU5YVGZOVkMyRHViSXBwQ3VZaFFjNzNCd2t4YzRCRS9j?=
 =?utf-8?B?ak40Y010dGNZVEJwbWhmRk1MRkZxNWk0eXllUTVPY0J4eGt6U2R0MWdoUnhv?=
 =?utf-8?B?TmlJdWtGQ2FQSWV1L0ZTeU1TdVRQWHh2SjhXc1BlVngwSzJHbDNZL1h0UUhn?=
 =?utf-8?B?RHdySzU2azNZQTZreWdsNnpBSzRrTm02cjhJdWN1c0VCLzlQK080V3lyU3Bm?=
 =?utf-8?B?dVp1eXZKZU1CWUxIVkJkVjhXd0R2MkphbkNibDN5V28vMzJjRTQ0dklzTEpE?=
 =?utf-8?B?VmRiQlB4Sjdkd01HZFJkbkFYeWVwZktDOHE3U0pYSC8vcnIyQi9KOHhsdVdp?=
 =?utf-8?B?SHZKM2VCdU1YbW9rbzVSR1YzdXBGSVh2aGxtRm83SzNkbTlnTnBqQkZLTWxk?=
 =?utf-8?B?Q2oweVY5MXZJcThCK2ZsNWZWYk1qaFVNazFoTUVva3dsdTJPRzR2enZNOGNi?=
 =?utf-8?B?aGwyRFQ2aVVEY3U3OEswUS9FSTY5eTBSSytRWStDM1RYUEdIQTFzWFEydFJI?=
 =?utf-8?B?ZkhpYVlrbnN0bi81c2xhMHVydWgwNlVWbitYY0lPWCtDQ2dVVGY0R0w1L1Ny?=
 =?utf-8?B?UWF1NFZJUW04eW5ORHRxSENSQkdLL2Y1VHpaMHg0MWdBODJXQzRqdklRVkVI?=
 =?utf-8?B?ZWpmdWhwemhDc1JYWThlL1VGYUxkcG5xMkcyMm1LMzY0dXJiaXk1NDFGSVFN?=
 =?utf-8?B?TURSdk5vSHAvN1EyOGROdW1HWnNaWGYrd0FETlFPTmJqL1gxN3VCQkJuVkg3?=
 =?utf-8?B?Zkd2M1p2MWU2c1Z3TXVRRW42MFF0V3R5L2xCSUU1b01lSDY4NTVYTHBSN0Rj?=
 =?utf-8?B?d3JjcjMwN1VTcnlnSjlYNjJKaHIzSjdheVp1Mk5RWURiYkFqNFNmb2c1bWlU?=
 =?utf-8?B?Y1FnRGswMHF3dEpQZ1dLU28xRXZKK1ZaaUMyTGFZckJoMm9sZkRtVGtOYXBm?=
 =?utf-8?B?R3JUL3NmMHVIS0dYbXpYaUJGMTlYa21kUVdTUkN0cWllMFlGS1dUYzBqTy9W?=
 =?utf-8?B?U2wxdUN6T2MxMHFaSnlKaWI1L3dFSVd2R2Y3RkFnNGhRQ1ZPeWZaOUVFdnYx?=
 =?utf-8?B?YmUvUkVQOWdMWHpQbmNXd2cvR2Y5UDVYUG5yQzhJbVBlS0xpZUVhczl4MXNH?=
 =?utf-8?B?Z1BQTnc2aHFVNG53VVFzekxOVmlIdmx4QTZqSjNydk9lcGpHUmdiUml2aFF5?=
 =?utf-8?B?TXBmZS9xUUJGSEk5WGR0OU9CY1pNZ3B2dFhEVHRIb0RnKzFucEdrVDNSS3Bu?=
 =?utf-8?B?a0dzWnNRNC9jTWpQNXcxWXJzMm4wU2VlTU8yU3IvRXlnRTVPSHZqMzc3emM2?=
 =?utf-8?Q?22BGHxG1uOuWcbidmu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c598cb3b-354b-452f-81e8-08de8018a8b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:20:53.4602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv/CEoN4p8Bdgws8+ilhNlv8KT18JHg1qRAHAumO6O4WZpxGOv5B0rwasGS3PbRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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

On 3/12/26 10:16, Sunil Khatri wrote:
> cancel_delayed_work_sync for work hand_detect_work should not be
> locked since the amdgpu_userq_hang_detect_work also need the same
> mutex and when they run together it could be a deadlock.
> 
> we do not need to hold the mutex for
> cancel_delayed_work_sync(&queue->hang_detect_work). With this in place
> if cancel and worker thread run at same time they will not deadlock.
> 
> Due to any failures if there is a hand detect and reset that there a
> deadlock scenarios between cancel and running the main thread.
> 
> [ 243.118276] task:kworker/9:0 state:D stack:0 pid:73 tgid:73 ppid:2 task_flags:0x4208060 flags:0x00080000
> [ 243.118283] Workqueue: events amdgpu_userq_hang_detect_work [amdgpu]
> [ 243.118636] Call Trace:
> [ 243.118639] <TASK>
> [ 243.118644] __schedule+0x581/0x1810
> [ 243.118649] ? srso_return_thunk+0x5/0x5f
> [ 243.118656] ? srso_return_thunk+0x5/0x5f
> [ 243.118659] ? wake_up_process+0x15/0x20
> [ 243.118665] schedule+0x64/0xe0
> [ 243.118668] schedule_preempt_disabled+0x15/0x30
> [ 243.118671] __mutex_lock+0x346/0x950
> [ 243.118677] __mutex_lock_slowpath+0x13/0x20
> [ 243.118681] mutex_lock+0x2c/0x40
> [ 243.118684] amdgpu_userq_hang_detect_work+0x63/0x90 [amdgpu]
> [ 243.118888] process_scheduled_works+0x1f0/0x450
> [ 243.118894] worker_thread+0x27f/0x370
> [ 243.118899] kthread+0x1ed/0x210
> [ 243.118903] ? __pfx_worker_thread+0x10/0x10
> [ 243.118906] ? srso_return_thunk+0x5/0x5f
> [ 243.118909] ? __pfx_kthread+0x10/0x10
> [ 243.118913] ret_from_fork+0x10f/0x1b0
> [ 243.118916] ? __pfx_kthread+0x10/0x10
> [ 243.118920] ret_from_fork_asm+0x1a/0x30

Good catch, but userq destruction is completely broken in quite a number of ways.

Have you taken a look at my patch "drm/amdgpu: fix eviction fence and userq manager shutdown"? How does this here interacts with that?

Thanks,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 32541f1bde6d..c5875e175918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -621,15 +621,22 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	int r = 0;
> +	bool hang_detect_fence = false;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	amdgpu_userq_wait_for_last_fence(queue);
>  	/* Cancel any pending hang detection work and cleanup */
>  	if (queue->hang_detect_fence) {
> -		cancel_delayed_work_sync(&queue->hang_detect_work);
> +		hang_detect_fence = true;
>  		queue->hang_detect_fence = NULL;
>  	}
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	if (hang_detect_fence)
> +		cancel_delayed_work_sync(&queue->hang_detect_work);
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
>  	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	if (!r) {
>  		amdgpu_bo_unpin(queue->db_obj.obj);

