Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18048C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A7810EB26;
	Wed, 16 Sep 2026 15:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JCVQEH2c";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1C610EB26
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxZ5P8UsV2ChddcGCBCXlHo6dpYY44cKSuBa9g8ByDFGHjuz0wURlDF+7rdS8gSkM4BxYwzltJqhxXLrEqUiRv32FswU9qaNFkA39d6YrWZlakPMlhFh/IMM634oU4j5+g93TgFk1XhAtB6R7gNcP9jMXczE7zJ+NO5NA+7b9D/pfrdOhVwSp+Siy1/xsE0n4EyfP76XFv+VNAkBwqs7OYxap6mcxp9E82LSiW/yyjbMr/x5TZ091bFtAd2Qxh97VlcrIlOFOa2OlgO7kH8qZH7SMEwi/UlAA+Hr5xXfvbUz6YpELbOgtTtdHZnGUarV43Om0td6sC3iZR4rPgk7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJnKsBzQcBZfKDfmRlGnfXI7gew+mwJjIYmwesm7qv0=;
 b=qCiBiz2BQkUQRP676Iivci3bpW9J6++IIRNft+4wspJtTI+Z0tbWzylSkhh91/uiiPTE5TJkf1mw+gFv2HHvb0hQJymUjwhI2/MSd3ldSFcFYizpl9Z71LjOzUjcSRgJVL5uPpcJ+ejzSerLj+ndiiOtiKtPaUBW4nxwNORqUJVgXJnzErGD6U8mN3gQwqQxVYfnvMtcq9qsIkPQWOpVvhMi2WkaJcTnueMg/Dz4F//wrj8IQQsBzrW0t8KE9OI63yQhMayN3IMMAzMTL1OVofG6Jee1X0Rffv3WP0FukXdFZSsDn6g6hAxfSUHf51cEh9AxHaqwtdziEvZUHMQTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJnKsBzQcBZfKDfmRlGnfXI7gew+mwJjIYmwesm7qv0=;
 b=JCVQEH2c9HHk0O6R7u6QBvB3TObxmul2gewnB0CjAvppJ0uQbRGoL6luT6l/dE6xqmnzpPl3QZt/XI4o2OwlgD01hyvpSfdWJ5ScvUW9gH2/DVC+bxyM6l7fXT8YFIfyoI7T/VQ5SU9+fBIz6ZbDF6wdT6GDRkslllTfs3PoqqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS2PR12MB159464.namprd12.prod.outlook.com (2603:10b6:8:40d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 15:44:33 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 15:44:33 +0000
Message-ID: <671ca418-f478-4c43-aabb-41e64f63167c@amd.com>
Date: Wed, 16 Sep 2026 21:14:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_ualink_info_set_accel_state
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20260915064113.454895-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20260915064113.454895-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::13) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS2PR12MB159464:EE_
X-MS-Office365-Filtering-Correlation-Id: 757013ff-7b4d-4a5d-eb86-08df14096721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2pomVK/rF7Spp+4yDzEviahAhPWF7skf1Kg0eyjT+ruRoO+78oTm+bTD6+Bk2Q5s6jUBBZb3+CiocKgLxGw6oYGulz6leGApxve61LBONUlDTfY/3OrK3thM6sAkwz/pc5S3DivFa31/BtyJq5AslwVbTj3qn5d/zWdoZUOBhIKi0lwidZz54va9J+uHKYzmmCm3GDYK9PyWsCHPxJN9X96aQ8ss5kHpZbjqOYXtO1juUSEJLISHvV6Z7b2B1Ikaahh6cmGXdFLuqDaLb02o0PabAC8sGDqEhPYeTdmmxU0dz3p+x5yL68WUpPMaHHaSBadOKuMtPeeP8dZFHjFvCuIVQ9Nn4loSQ+xfUL/6n4yb+LCH6ArIBRUXmRskE4KGCGpuv2VINek4sLSvwsu+ugxI9DiLjRCLDQ3xo+7QTmeNrfzG2eohVd+MxZCUXVoacroUeDueKE40eFYkpIUMRcxLnSOzHB0Id51CuaVFlHfcN3kikIHzSN52dFcsp4Qbosq9mRQcoagndqubmsMlGfGYPGpl5aLNGjxGG/I9IcZGW3iq6X92EdFABYyIoN1XpouJKxQeIRy4+PwII4Vbl+I5rYii0sCo1kc+T7EbOQWfAUsDWo7qlgkxO3IrhwyRuZqevIqO2rEglVtuF+SXbfLLxgRG7ADLlcpM7jZ7tzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFobWl4V0V2amZXNkpjenNTcTFha0pMeGx0Y2tOUWZhWE45M3JNU2hFZkt1?=
 =?utf-8?B?eVhma2hiY0N2N01JNTc3bmRhSjliamg5SzVXOUs0YVA2NUZ5bzJzUlpXM1Jr?=
 =?utf-8?B?SmJqVlJuMDVSWXJvZ1Znd2gvOUxYRCtxM1FxRzd4U2ViSXJkVGw4UkF3Lzg0?=
 =?utf-8?B?a1VNVitVR3FPQWFLWWNUSlRnR24yYjRCRC91SHd0Q0pTb1JTMGVQY0x6WGpC?=
 =?utf-8?B?ejFUbXFjaWpyTEZNN2hDL1V3K2t3TXlvQ2pnWEdDUWQ2U2JVWlF0em1qNzdz?=
 =?utf-8?B?MTNmMnFyZTBnc3R2QzBYSlhQQ3B4NVYzTTBFNW81V29OSWRXY2VaV1VSaUVn?=
 =?utf-8?B?Uk1mVmJQRjVLTVdOcUcxKzJPZEVsdkI2WGZ3WXM5QUZwREZJTGtjSSsxamNR?=
 =?utf-8?B?YnA1MVgwWnRnZnE5UHpzd1IvL0puaDZQbGtNL1N3bUxNUXdmV2NHR0xkc1Jp?=
 =?utf-8?B?U0xqQkF2b0djUmxnTTkzK0hkYW91UDFOdW1wNHpYdE9CYnVWaHdNeEkvdW1G?=
 =?utf-8?B?WnRodTdWRUcyZzNlYmFiaEN2Ry9LdzRjUG4wNUk2MjBXV0oyZFNRYUlXeURP?=
 =?utf-8?B?ZXMwcFFvU0IxUCtxaFkycmNpQ2tpTU5acGkyVjNEZXJiUlpMMjF5YnFsOXpR?=
 =?utf-8?B?UWRPREZXWWcrd3ViN0VjeXZBanIzKys3QktqQzNsSS9aWjErczhmUGhZYkhm?=
 =?utf-8?B?NzVGUnBCa2JRM0h5MXZ0K0dFQzMrc0w2RVh2T2xEdUVGYVF6MWUvMm9tUllo?=
 =?utf-8?B?TklYWkFFQ2NKSzBCbVdCYi8vdEd1anhnelpPSUNseFhKdXFnVzZIT2YwYk5K?=
 =?utf-8?B?bWlnYkJlYUlzY0ZBT3FhYU0ybzdsb2JEMHJ5aHorSTZrdEIzRGxhSzJkWkk4?=
 =?utf-8?B?bmJMaHJhSG1WejRwZ2RBcHJKTFRuUlVGVTFGRDg3NmVmbUVZdlN1WUU0NzVQ?=
 =?utf-8?B?UzBZRkRaMWJKUWlNdDdtRmxwbnZWQVNkY1FwcHdncDNzMzZMSjlrTFU3bmdx?=
 =?utf-8?B?K2ZvZzN5c1hWWHN1cy9UcXpoNEorZnpHUjNUaTZ5SC9raVE2ZlJPOEd1c3ZO?=
 =?utf-8?B?ekVab2ZLVFpRaWRzaWVnUDlPbjMvckxNK29PMDBwaWR4QzVDOHVPVk5qQWxK?=
 =?utf-8?B?cU9RQ1ZJdllrVEtUenB6RFVXRGFJY1cwSDhDK1JBMkV4TlBpOGY4TjVvLzB6?=
 =?utf-8?B?SGFncHFWYmM0dEtSZzRiUllGckhPY3Y1QTluaGJENXh1c3B3RDE0MUd3U1Bz?=
 =?utf-8?B?a2pDZVhIcmc2aVpwMmVuc2M2WlBrRFpLbWtKdko2OWVXenVGa0l0RGpQanhN?=
 =?utf-8?B?Zjh5Tk55MmRCUEk4TmFTZTJUZitGcGs0OGVVdGRnM1B1NS9uMzg0Nmw2QnFE?=
 =?utf-8?B?THllaWdqNzVJTVA1enMxc2RRYTlJaFdPdlNPdjVQbDVjcWY3SWxNbiswL1k5?=
 =?utf-8?B?UndwWlRGMG4yZW9NQ05vWmJVWlZnMXh5NTVQaDEzT0VPN0R6L1QvencvMHJa?=
 =?utf-8?B?Q2FiQk5wNVc1MXdvWkduUDQzdHVkUVpHWlUxVm1Gd2FVMUZPTW53ZVlrS29L?=
 =?utf-8?B?blZyNFRob294aStoSUpTODJ6TExOQTNqa1pucTArOHhxTThRYmtGanRtT0pw?=
 =?utf-8?B?ZW5WYkdqY0gzYTRUZ0ZwVlgwTzZvdGNEbS83cUY0VnhWU3dmYlhGV3dTZnNN?=
 =?utf-8?B?bGpUWGc2ZEZ5dUZVNlhPV29TdVFYY3pZT3JtM1dhUjhBSmNMaEJVUjluRnEr?=
 =?utf-8?B?d25yeWtDL05yOVZYT1JPTW90UytYdzhRYTlFeHUya3hYbU1peEdLNjhzdUE0?=
 =?utf-8?B?b3h0RFpaVERIMXJTb2dVOGk0Q2RqMHZ2UHlZZUdkc1NjUzdwR2NOMGJQOGZC?=
 =?utf-8?B?QmFWeGFyR2lsVFZsSjJxcndkZFNramRaVzVXSWpnckJoS09sYk93Qzg3ZEZI?=
 =?utf-8?B?cTltQ09yTDNKMjdyMUlwd3dlcHoxcGNkdDNDN29QdWRXWVN6QmNRRnVpbnN0?=
 =?utf-8?B?QzJZc0htSkJlTkh2R2VuN1hkcGgzaEdRRVlvNUVpR1hzNlRKcUxGc2ZGbmpo?=
 =?utf-8?B?K1hWTnZ5RjdKQXlQb01RR0dxVmRrN0k0bE1WeXkySm5hVWpRWGxKMGhIbFd1?=
 =?utf-8?B?NzI3NlFQbmNkS0hiUTMzMW1PdXlGWWRYWGE4WXJWVDB2cHduN1BIVFd3azRa?=
 =?utf-8?B?UVlKbkVVK3ZMdldhaDMvREJQVy92NVB5andBVmtEa0daN3pvdGZsRlFvRXVt?=
 =?utf-8?B?SU9QdXgvKzlzTWUxWlIxL3hmVFlTVmR5bUttZm9MakNNaDZrK2svelNzVnhF?=
 =?utf-8?Q?sxmx/LAMvXsgkOxTUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757013ff-7b4d-4a5d-eb86-08df14096721
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:44:33.1380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of+E0jj01h83NHRiFX98292LQ2pWfTrJKejQ7jouoJYweQBUumWG/Co2Mf8iqmIskyDxSzEZV302x667sMNKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB159464
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

Gentle ping!?

On 9/15/2026 12:11 PM, Srinivasan Shanmugam wrote:
> Commit bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
> introduced an access to info->accel_state before checking whether info
> is NULL.
>
> Move the access after the NULL check to avoid a potential NULL pointer
> dereference.
>
> Fixes: bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index f4a4432c2c5d..3b0d5138a349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -161,7 +161,7 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
>   				   struct amdgpu_ualink_info *info,
>   				   enum psp_gfx_ual_config_state cfg_state)
>   {
> -	enum amdgpu_ualink_accel_state cur = info->accel_state;
> +	enum amdgpu_ualink_accel_state cur;
>   	enum amdgpu_ualink_accel_state target;
>   	bool ppod_validated;
>   	bool vpod_validated;
> @@ -169,6 +169,8 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
>   	if (!info)
>   		return;
>   
> +	cur = info->accel_state;
> +
>   	ppod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED &&
>   			 cur <= AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
>   	vpod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED &&
