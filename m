Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272AEC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE2810E1F9;
	Wed,  5 Aug 2026 13:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fyB7K0Cu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA20310E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xuos2XQQdUqfFzdCcOhS7QwNRe52vs5oVUG0YIviyHPhGqE6mb/vG6LecnIs6B0/SbeUIqCj4nGPz5WboGyzr4uF/8W0/LhMtgoMnquzoJB+67nP3JeX9NUftiSq8oZ+USaKCxpJUh8Ju6fuWKRkMxREj6+I2phCylyH2Yrpx4aF2P0jQva/Ctb2YA1y9mtN8iPM+tFEIngN23MPCxbgatc3vwx1+Dqo+oRY3KyMI4zFta/yVI9ad668S3+4oB6wzyBaZ9b783Zv7MozwB3yIrMxvzPc2iRB8aDnQ9GSHEg6sE9FdRY2oaTizILzqfQJNG5Gg4aw6jWFKDc1JgRb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWR6K6Vo+Y4wMmhEpRWBLD6OE54/P3wDWOhB3+hVJUo=;
 b=fdsZaba5gdWnfY3O1EMQobAOoz1fXA3Ej5e2DOyeCyeU9VOXoOu6wZAHJ0/zPYHJ3E0od3cTTn0enwqmOLekQCbgyWRInf5sv1ilOioMcCuzUVvMmFEASnGQDqrnG5dQnS1RISmKEmgavoBTczYgayTEvlYnmGS16M8Fn9+iid5baQ8zIdyPBHfpLKMtDW9UCttDUG9zmWevSrNYAmqhAaXUV9hSbdFTcqX3SlGVIV/ogcyROn6c8owho+tMNYI1FrvzaycXmYIX9fucLGIh2GW1wr71XTbWFOWJrf6ZVeHu3hXh0dkXsZf7U9da20ckEuDoxjoCTyLVTpkM8nFsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWR6K6Vo+Y4wMmhEpRWBLD6OE54/P3wDWOhB3+hVJUo=;
 b=fyB7K0CuOQOWimehDu5ToI6eCcybaZ39TTrawVc6/96tKPwsZN1gjhUR9LR3wFz3BnxL3soeMVeMG99UNOskieFZU4+kq7T0J9shRYxXxBlUGxCzjN1sSu4zxCDAI7o0SUL+74ov7jbryt1uMbWn0r2MPut1aAePqLzIb7GJfog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:05:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 13:05:19 +0000
Message-ID: <d7b1cee6-a98a-4f01-91b2-dc52691bf1bc@amd.com>
Date: Wed, 5 Aug 2026 15:05:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 93edc64a-26a3-4f9e-08fb-08def2f23386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6TA0Xl4G8hAEKAFz/WEQyhpThfii9PtuT+lgto0JdyUA7wrrW/74EHWp8gKIwh7vQtmln6a6F+/AeC00veFH79YS677ECgIIH/LR49bGPruUY/EyJsG0tlQB/ulKuvghYRs50ekECz96U1H6VtYkCH/eaozSX0lZPM9DqkKQmrDQJ5N/uZgGHbsHMvzBYFzY5Iqty1pPtYO3063FGCV6aRSCWetjE6xCurTJk3NtCBUpiq8dx2NzHFyib9XKPug7ozWXQs0gj/gs+1D3cMLiolWrIHhBd4x4vUOdchmaY0XUghkAAs6kK322XhO1I36KNnUMru+UP0yjFoDp/hho3S7h6i0R2wz6GGzAR0KagIvnfG08sMXXHvWVTu067CrjR8CNoiTyw6FSOrTVmiQxVq8DG3OZe6pzTt5apOL4ur7ejGMMVVaF1zan68AnlyPLqQmr9HOQTid3YKWThFVEfRVuAmItJtRcaPpEQrto2cxQFZJobwpO0RwNBksypduWdH/QVXVVwC05uiYxP7ZCRYyeCxIG1sCAN13S5urBwL8W8TPkgp8ntHcL+CEgzWjcrXLvKvtMZqya/jJbensKlNWDDVLxu6xiYcM47sPYl6EC2Ysl/etFLC268NkxZk0knxbw3WakWIn+A1LoiABoazV9jJSmTFlyIw/TU2uIqgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWR3SlNkNWp3aVpXaHZmRHpERnNUNmhaeWl1bndYZ0RSSytNN2l2azAzQW5l?=
 =?utf-8?B?NzlLZXVjdllaWUZzUyszZ1hDVUVmcDFkcFYvZDRUREw4QTVxUFY2cjFTYVdU?=
 =?utf-8?B?RjdzR1lTS2xiQko3dUorb2REeUgyc1QzaVVsaVkrQkdRdjBabEY3MzU5cjc4?=
 =?utf-8?B?NVBUWk50S0ZUdXJaMFYrTjNvWW5sWXpkWFZ0Z3BRMTVRcE9USmZGdzZDcExq?=
 =?utf-8?B?bUdHLzBiUHdCUEtxNDdrRzQwZHUrWU9HTTRVWWVCTzVnTzBGY0VocDRGVnUr?=
 =?utf-8?B?ZlBWdzhsNy9JZi9iOUEzaHRPSHo1aHBISkpCYk9tVmNWOHcvUUZvRDZCdmlR?=
 =?utf-8?B?b3ZrOWtldHFLRDlwSVhPd1pTemdmK2dYRzBFUEkxRXIzT3c0eHBtSzdkSWRC?=
 =?utf-8?B?ZE9CZEFhc1BFVnJGQVVJclRQNjd3YWxWbmgxajNXSHlzdXFQRTBzbnNqSXRu?=
 =?utf-8?B?TlVaS3R4b29JSnRBUkVlWlBDS3AyT2VrbWg2WlJ1R2kzeHRRcUdZbmdvY3ha?=
 =?utf-8?B?YjBCdnVlaTkvNVVSRUxZN2lFNXhBMDkxSjdRKzYvOENCQUdwc053Mys1QXl4?=
 =?utf-8?B?eFhQa043NWhxMnJQS28wZ2Rxc1FNdFBSOCtQRGxFOUZwM2YxWEJiS3IxTlA1?=
 =?utf-8?B?NFNGMlNKQ2JZQUtQY0RjRXU0T0hXSWkzNmFHbWhKZHY2WWUyK0xldHBwRmYz?=
 =?utf-8?B?NG1qYkFWT0FRZzVOeUtsbWkyM3ZBd1FlakZpZVBUL21NZzdsUk1ZSmh4K0sr?=
 =?utf-8?B?ZlRnV00wRmVWZEo2ZTRwU1FpS3YzS1h1MlBsd1dTL2w3OFRvWnhzRDhjSlNJ?=
 =?utf-8?B?WkZTcnlkcVBXaytjTzgzS3djbjZhS2RxR1o2SEpHNzJtNlJaUEN5akd1Z0tM?=
 =?utf-8?B?bk5pTk5ueWFUc2JXbzRkRSthd0xCZTU3TlN2aS95RkN0RTN1V0RhZSt2QkxU?=
 =?utf-8?B?ZDBnd1dwSUtuRHU5cjZCMzQ2T2gyTkg3TmtBMlVqZ3lGUUVVckVBSldTYUlr?=
 =?utf-8?B?SUU0YjdqQ1hJUXBPZ0QyenpkVmZObVIxMjdTTWYzMVRZQlBZbnNYRTUvMFY1?=
 =?utf-8?B?Y0ZwVkFNUVB1Z0ZYVHptclcyaFRCUDZBMGNFWmU1MVpka3J4UmhZVkplWjYy?=
 =?utf-8?B?NHVCN0V1NHZiWDhoOUNpVXdyUGxHeXB1YlBSRWtpZGZYcTJqbW1yZ3BjMW43?=
 =?utf-8?B?Z0QxZ1JqSFQ3d05jS1c1QUs5UnlWZGJJMHc0bTgva2tqQzUyOVZibVIwVUxk?=
 =?utf-8?B?RFhDWkNOcW5pWWhHYzlPcXI1aGplSFROVFlJMGtiWjJGdFdOaTJxRGYxYzJi?=
 =?utf-8?B?UVZJNlorczBIQ3BiVFVKdWtPR01QWGtBL3RaN0hVV2xabVo0NERGc2hFTG1U?=
 =?utf-8?B?STJDY2xSMGY4RElqTDVlSHRhVEY0a2hXUHNRYzQxa2NpandvT3VqcXhhZjBG?=
 =?utf-8?B?UUpEbWRuM3Jua3hGMWJFemdXSlRJcXN3dnpmY1RrRkZ0QWt2M0hhY09QNmhF?=
 =?utf-8?B?bWIxZ1RGZ2ZiNllOQzU2UGJRTG1QUXNYMFRZd05lWHZkTzZhaTdlWmJjSTYv?=
 =?utf-8?B?L3ozclNnRXBPeERkcWp3SUsrZkx1b1JiWVc3bW1abTcyK0tDRDlWeENiUEdx?=
 =?utf-8?B?T0dYdFMveFNWZ0FOR2I2aHYvajdxaDhNaGxpZlNuQVhTQ3lneU1mMUtXZTRG?=
 =?utf-8?B?d2N4STlycXJBTndPQnBIK2d2NXVDYXpEeUlCQzR3VEdHdTZmcmpyL3FOU0tB?=
 =?utf-8?B?b1RUU09rd0hjOVFRY1k1OW16S0JmU3h3VElJRGhsN1N5d3FGYkQvOVBoa0Fs?=
 =?utf-8?B?NXkxVjlZNGdEM1pzUVZ4NUNzRzBnS0FsVkdiZzZWdFQ0NnJyUTdyeXQzM2JZ?=
 =?utf-8?B?ekRsNWhLQThvWFhVWUZ3VHhrZW1kSGh4WkNiRlJaR0xlL2VnK2FqYzZiM0VF?=
 =?utf-8?B?SlVrTGpOM3dxTjZvSW9DUWNwSEJZUzNGR1d0VXpwdWd3b3RFVEtHWVZBSlFh?=
 =?utf-8?B?Ty9uMHI2RWRYRFJVM0E1WXBFS1Nya1ZMeDBjdUliYTRBd1AwQ1N1SDZxaC81?=
 =?utf-8?B?bHYxYW85WTIxWG40N0dvSitIY3hTNllCZFlnVXpZNDc4Y09YQ2VUeVBtSlRo?=
 =?utf-8?B?OENaMWJtQTArazUzTlFCZjhOUHVIMEFHRDNTVXlmR0lpeU4vRTRpZmdIdTE1?=
 =?utf-8?B?Q01qMGZJdVc4c2dVSkprQVoxdDIxWlh1SldoRlVLWlpJaDBCdldiZWZkSklO?=
 =?utf-8?B?ek9XbzRXN3hPczFVOC9CYXpoaWZTZTIzalVTN2t2QS9uNGo1Y0dvTTd2VDRl?=
 =?utf-8?Q?6aBc4jdyq+5Cb0Gj5j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93edc64a-26a3-4f9e-08fb-08def2f23386
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:05:19.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRhCNU8l4U7qMDLjCBQL1HM0Gqp5SbyUD26z5ehBNREEcF4z65cIBMjZWOYM9d1f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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



On 8/3/26 11:35, Jesse Zhang wrote:
> Creating a user queue can race with a GPU reset. While recovery holds
> reset_domain->sem for write, MES is unresponsive, so the ADD_QUEUE from
> amdgpu_userq_map_helper() times out (-110) and an otherwise valid queue
> create fails:
> 
>   amdgpu: MES(0) failed to respond to msg=ADD_QUEUE
>   [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-110)
>   amdgpu: [drm] *ERROR* ... Failed to map Queue
>   amdgpu: [drm] *ERROR* ... Failed to create usermode queue
> 
> Take reset_domain->sem for read around the map so it runs only once MES
> is back up. This mirrors amdgpu_userq_cleanup() and honors the
> userq_mutex -> reset_domain->sem order; the reset path never takes
> userq_mutex, so there is no deadlock.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

Please also loop in Sunil on such patches.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 652599f08990..770635ab5298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -745,7 +745,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (!adev->userq_halt_for_enforce_isolation ||
>  	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>  	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
> +		/* Serialize the map against an in-progress GPU reset (MES is
> +		 * unresponsive during recovery), matching amdgpu_userq_cleanup().
> +		 */
> +		down_read(&adev->reset_domain->sem);
>  		r = amdgpu_userq_map_helper(queue);
> +		up_read(&adev->reset_domain->sem);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>  			trace_amdgpu_userq_create_end(queue, r);

