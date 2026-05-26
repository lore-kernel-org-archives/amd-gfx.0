Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8CCD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A266D10E06B;
	Tue, 26 May 2026 10:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUY5Wj3C";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D0710E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k75MSvRj5ZQGXVokERBHPv7SHGwTrXWDgfyolmTmI2XBKX8ARwTpfVuOANOQN9Arv+cewNJuRn7n0Ogd4nB3iUiLXGAPqRzfRSTDGximTjQkwQYn1Om+W8MzJ7vpcZ7mTpkwbrizNGIAfxXYfdoCCIcrNDabngoI9722jJjuqWBIB2IA2Fz0wh3k+S0bSm0tMFOfbafY48QsgBYRrsBxD0zFekQYx2AzatjbbrQlh1hWPDNu2vJ1cBpks4Gu1fOovNpyRdyJ8xTZGv/90z0VStYDIWIn7uiCHTdMvSOqUDM9jUvlpL/IIr5NGDSlDJEbuX6vSKgN7ajdKKq7C18zUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtVudt/ERDee+MpEEyY5KKa1M6CL+khD9R5DP8FIon8=;
 b=eZB9YZCN4VAYZOG4BNYHkGJZVDHWTiDG2XKywOSPLccXc6iybXEne0hKO/xT/tyj+8z2njkf+PKJna8+A/gLX0UKeAoN2WJdHxtNE8S2TcdiVps4UI9Q7SjWIsarIGgU/Qq7lId5qviqomyTKwSZZ6csSB8tS9qxEV6GWzOOjiBj40fVXYFZe7ALlCZY6me17K2W6Z5pa8JafJID9fEXkVDzPLwVqD+KKIqLmsPB+c/FNd1ozV9iDyZoxd64AVx76xzvo2sEzMD93HfzgPYqfTf2fzV7Vvg9KJlCigwqArpxaGuKsn0MQNg8awS04PslmN4kJNawiJpjnTvaB8tvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtVudt/ERDee+MpEEyY5KKa1M6CL+khD9R5DP8FIon8=;
 b=DUY5Wj3Cxa1LuPD8J1Xmz4pm67iN+SMbI98yocFRWizIbzfn6Iy8qvQAcVa2UXO9HREAF6tBw803oPKcVcXwGiDdzJcdR9nJGn/qVclCeksysMlQeB4GXWoLWWxStFR1jqsnX1qZkYNI9L+C0M7kEeLA7VOHybJIaSqPvLhe8n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 10:49:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 10:49:42 +0000
Message-ID: <899021c4-085a-45b9-8584-e015f0d0b034@amd.com>
Date: Tue, 26 May 2026 12:49:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: only flush restore work for rearming the
 eviction fence
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <20260526093210.55565-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526093210.55565-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cf93d7-5b4a-48b3-3ff4-08debb147de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|6133799003|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: P/DxGyQCu96V6fsYqdrljjfs6YiCMrlNDURzwGzGPjIavh9nCulIMAw0OmbxJ8MfmsmiQ+UJ/gMiF3jyj03R6D32H5S2OGA5M0ndea7uNQFWRsCiSIbNHUY7GN3GcsXxWyU6xYWCwVxOzxl4Q4SjqHUEgtf6VzuHEau3C5+XKqxBu8huNlPod+pnuvRchXNRYQ6jzIGdFhcLaw9hXZJwfjQIfXyNA30KzbyVGG4SC8L/ozUVS3Wq4rOMRC5Q6V6sJOO99Yv6JvyoBAo58OTbKMkIxjRHlvR8sXm8sDaXxLxbK1Vj7b+hVMw7zSaaSCfIVqyRQQOaXfHYbtV+kHDxnZpZq5YIkEyNx7E9/pbIiCVZ0Je3vaQu/nHkbLgAy164pI1YITyY/VwD6x+exgUjaeEmNJ7Junh1v3Zyk9+M1DIAtSFcOE2gth2vdQu7fCqLovOIx6TN2ZE2ASdbxNcGjO8WF+tJi4O4kAZOwdKmyorjMjClGxB/q0keHPNurIKD6e7eIW2ujrvMrD1ZOrx1AcfWc3dm78ofv2O3TwNOuIpBgxGMX1vX8V4vu16Ee+UfyI5HCd1Pd+vDrgu+QxkbSj2COq6QXGE6k8yOGXFIvNWqGrG2aK4wnbTBqpNwjFkxr91NApEQ0porEj6dXPzjDSOftpdj4z/y6fOs/eEuE3gMz8rFCH9c1kEiXWzsL7bs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2c5MjhvR3hGK3lVdFFVOFV5NXZWWHpJeU9HUjBKeW5oTjE2NFJnR0ZTcFVR?=
 =?utf-8?B?RVk4ejlwWE5RR3QybjMySGR0a1kvNzZsQjFoRFJKanVDRzg1K1R4T0c2dzUx?=
 =?utf-8?B?S1czdG9FaCszTW1DcDU2V0F2YTdYQVN0NmFWc0dkc29mT3hDVDl4Sm04VGw3?=
 =?utf-8?B?eEpmdmxyejBjWmtFWUJrTTUxL3RKaFJOa2duNUdMbFUxd1liaG5vZjNFYTVN?=
 =?utf-8?B?UnhZRVhBbTRmd1JySWxpSEJiTFRSa2tyckl5dWtDSEEwMXpmMXFYZU1iWUwz?=
 =?utf-8?B?QlNlYmdyalZJdElsM3ZFNS85UFhjbjhiRWNjYnptMHo5Q1RqVE5tZTBzVTM0?=
 =?utf-8?B?eHlIQmk4QXVHSkIrTm5aQzBSTmtpK0FQbDRjbVByWUxyNnNpeHpEWnJhRGJv?=
 =?utf-8?B?VkpGLzZGUHBTUTFKYmtCWStVZE40Mk5icHdPcFdITEtmSitSeUhWdkpJNnRn?=
 =?utf-8?B?WitZVDI5b0E4T2hBNFBNWXZSYWFxOXRSSjlPMktUcU5sNEZicEkxSStTQy9L?=
 =?utf-8?B?VTBiUGNWRnk2Wng1QVlmVGJLR3dIVG5iQkxZT1RuZzNOSC83RWR1K2NsMHY2?=
 =?utf-8?B?U1IxZjRqbk1QbkRwclp5VG4rbWhsZWVYZm1zcldmOVd4UFhxK2xZU3c3VDNz?=
 =?utf-8?B?ZUdHNWZ3M1hKbHBqeDJrajFTbmdYeE1VcXBBY2pwOGVCNGhvT0wvUzdnVnF4?=
 =?utf-8?B?Ti9XTGdQTVJKZWF0OVZUaVIyeFhPZkc3WVdIVFFqZ1FkdS9JM1pzQ2ZiemZz?=
 =?utf-8?B?d1VRZTVCVnBtV2lhUlQvS0dXdmJIU2w0T0g1TWdWa0hzd2YyUmJEWUtGNlBl?=
 =?utf-8?B?emZlazBtdTc5Ykd1NnpoVFdNZSt1UnIyUWN4ZUlYRUFJVnZxTHREdVRWSGtl?=
 =?utf-8?B?amN2OXFhZHhiSmZ6ZzZmV1pocnZJdWx2UmpDV2t4ck5FaTFZKzlIU1FqcE54?=
 =?utf-8?B?cDZVM2Z3VHBoWlhhVE41UllzOTd4UGxFRlZJb0ppY2g1blB3U3pIUkpPWk50?=
 =?utf-8?B?bWF6RW1JUXg3WmJscVVKU3BFV3ZjanBtN3RQeG50Q3lCNnJOSkVXSVRlcnJk?=
 =?utf-8?B?aldIdTRFVkxCZU9IakhaZ3RMSjZnZlhlZjhoSnk2TXFOOWsxL051QmJ1eXpW?=
 =?utf-8?B?U25BTnFuK1NleWtuMTQ0TjY1K2o1dzJVRWNXb3VEWFU2RHJDVTg3REZieWll?=
 =?utf-8?B?d29iamt2cEdwLzJ1VjBWdVhlaFBta2dFSVVGdlVENzJzSXpBWnZ4SUxSbHJS?=
 =?utf-8?B?bkUzOC90VDdNS2xQd3JXSGx1ZmdWcXNQOFFDbnZLOFVHdjNnNnFXN2pmVk44?=
 =?utf-8?B?N3hZdUY1YW02UzQ2RUtsRmtBckJtSDlyK0ZIemtnRThQQUN3TXprNy9acml3?=
 =?utf-8?B?VHhkUG9qSnloUU9Fdk5mYndYY2hRT3pjbko2cElsdUo3VWtmZ3NMNXpTRnYr?=
 =?utf-8?B?TmRrZmZ1M3dic2ZJTEo1aWNzalV1V0pZenlKOVBFaWJ0SVI0ZjJzaFhNM3pn?=
 =?utf-8?B?L3B6MHVmcklEdFBhVWk0ZTBkS002SHRROEV5aFIxbnBRY3UxbzdkZ0paTTdO?=
 =?utf-8?B?eTBwZkpIaDVTS0t3RUZEUEVsZSt6ZnlKQ21OVlNwVnZTTGFhTDkwUHdUQU9H?=
 =?utf-8?B?dktFS0tSRDlHNDV1bzZIaUp4WHM1RXZTeUtqeEk1WDNDSDF1djRiZzNLcHls?=
 =?utf-8?B?OVdsdFFENnBtcmwwclFsQXpXTUtQSitlSGphOSsyNndtalBscjdhTEJQakxs?=
 =?utf-8?B?UEdTOEpoWVMrWGZFUFNJeUYwT2tZcWpvcURXaC9CWFZ0YjFmTU9abll4b1Ez?=
 =?utf-8?B?eDUvTTV5Tk5Sc0tCRmt4YVNLVlVMbXAzWXFWTExjV09yNjZtL3BodHgvUlln?=
 =?utf-8?B?NXB6YUhjUkxTbmEyODZ2QmhOTms5TWJqcEVjUDRnZnVhZDVBQ0ZQb3M3TFlp?=
 =?utf-8?B?MzJwRHg3TGdURlQxVG1qV2ZFUU5tcHBlZ3lTZDFTd3R3QkR1M0JBaGVjWExP?=
 =?utf-8?B?REhPU050K29kR2VIQko4ZzJKZzdKWFRjZUIzd25sTU5Od0VvS2NRcTRFQUtx?=
 =?utf-8?B?S2RkT3RqY2tCYUxKKzIrbG43MzNhWDgvVWtQMUZrOWIxVzVab0pGUWpCeThl?=
 =?utf-8?B?SDBuTUsvcHdDRzNYbWYwK3J3akh3WmY1WlJ6RjJaR2VucFNPcnVOd2djLzh5?=
 =?utf-8?B?VUJrODBRcnpIdzFvR2QvTTlMcGlpbFQ2SzYwL2k3S0F2cWJhSkhZcmwwV3F4?=
 =?utf-8?B?OGl3bkJoNG1FK0xoVlFCclVsYzhHQjNOMURzYlI4QWlZVDBURk13YTI4ckNR?=
 =?utf-8?Q?uTgLHpaeQ4RwQrwaji?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cf93d7-5b4a-48b3-3ff4-08debb147de7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:49:42.0802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPwm34VAQ8KcqpGyln7ySyUhwSqnM+Pzb5Fd5PW2QXVoaNRaqSdi69K8QvpDYXCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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

On 5/26/26 11:32, Prike Liang wrote:
> The userq signal path calls amdgpu_userq_ensure_ev_fence() for every
> emitted userq fence. That helper unconditionally flushed resume_work even
> when the current eviction fence was already valid and unsignaled. This
> adds expensive workqueue synchronization to the normal submit path.

Clear NAK. That handling is completely intentional like that and doesn't add any additional overhead.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 38e310a8694d..f650d8d0ef53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -412,8 +412,6 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  	struct dma_fence *ev_fence;
>  
>  retry:
> -	/* Flush any pending resume work to create ev_fence */
> -	flush_delayed_work(&uq_mgr->resume_work);
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> @@ -422,9 +420,12 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  		mutex_unlock(&uq_mgr->userq_mutex);
>  		/*
>  		 * Looks like there was no pending resume work,
> -		 * add one now to create a valid eviction fence
> +		 * add one now to create a valid eviction fence.
> +		 * Only flush the restore worker when the current eviction
> +		 * fence has already signaled and a new one needs to be rearmed.
>  		 */
>  		schedule_delayed_work(&uq_mgr->resume_work, 0);
> +		flush_delayed_work(&uq_mgr->resume_work);
>  		goto retry;
>  	}
>  	dma_fence_put(ev_fence);

