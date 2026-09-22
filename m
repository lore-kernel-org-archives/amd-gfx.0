Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D56C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAA210E408;
	Tue, 22 Sep 2026 05:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GIkO9ip";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE11610E2E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn+tRA/gVxsK8b2DD+uAKXc3dvdFkvBPLHu9ZTabI7fGFb3ru9kvV1n0f8tsTwwis1SXNDRjvuPBlmOorlFWiBOrhKA2sJxKiQHlADqV0Akj32IxrP2tx12Fg0G/QRVzP9tjDRVcColPaNN8slxS+/+Urt1IDx1hZG07E8aEqxVmi/Pa0wKElRlXHjuR5qA/QH3zN6CIcIiJY1zUD2VnZc8v/p6GLMBIdHA4DIiAIqwPVYBmxT08tbkiZHuEaZYJIZERyy/7pI3tQkZ0hbwd+SifsaKvnZUqUh/ER2mHqgj+pz0NbPHI06d63X8xCYcL775qdHXNkVTGhFQd5AbE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM4VGGTcCpWfXSBAe2nXO9Ea7MHlXNR9GxoSvOebkfk=;
 b=dadrH172XWkmA2FpXsHp41l6tSNPm03qezplITdCPGTD2j+n2Yy2LpY85o7uBh/09vWHYKl2d8BY1taBYurOrCsYzqf24rpAv7cei07AgmTHaDy7v4Ci8RAB4X2f13ahP/7a1YCirYpeZHG7cs5pc7ZOszUh6AgO3CQfb/BUTn2wkHmXhza0PiEjIEWfR+u/WoU/DIzsiAHOS74nV20AF7zLk2KFndzoFPrkTKvj5EW1jA8RJD2M29XOlMa/Q99L3Hqi/4Q00fvkl6WvEQeRXc4v+YOYmmlwIVhEbOtr6vUnWbY9dE7e0Q0lJU/fKVtbv26oyj7YR/K00GYWcSkGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM4VGGTcCpWfXSBAe2nXO9Ea7MHlXNR9GxoSvOebkfk=;
 b=1GIkO9ipJa2p96Ksfud+5FVRmxukGtPSIoze/z8cXCCcTqRZqcy74W365AWEMUmKkCfEsEHW2Cke2iZAyqSVkU7nAmsdSPyRn9ujxgNYWTu6ixAbY7J+DEYXemYkpIy+N2kAWX/3+t85kY2CMiggec+niaeMALIxt00rfv+JRXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:22:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:22:07 +0000
Message-ID: <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
Date: Tue, 22 Sep 2026 10:52:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com
Cc: jamesz@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260921200313.865829-4-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: c622bbc7-833e-42ff-1d75-08df186971ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Gym5rHUV1pZGrLdYgbMeHeKB/ScmbSgo6Kj0XTtcbjwRSSn8PjDlbbQSQzhsudHZIyt196+HhcIaNhOhxXUI5cnOdh378uWeYSHjWj6E5YrBEJodGeNn3JNNf3NAhg4kDQ+VoDhDaQz0VR5OtQZotPb7I8QU1sYC7x+EIfVdCogPiFszwHbKzo+CsO3y7pfAr13RxThRfY0M05LUC/O1VnovFTcrvnLV3eNNjnlHgNtWCGbIQ8kDLRaNXTJWNY7NNwL8bb2z5dbhExUjSoJQK6m+yIupR2RWykvWMTNbCbfJnMCk1xRa89Ys2szwGaNTMUPn6CdsINJvLWn4BTD/4/oTKjsPhtqvXHaMHoEZt5BFK1YF9Z7eMjzsBdN4Wn2JMiVx7oJ4GV0qfd1EtSNVj+u3dqE3ve9zk09NR/KcfkbF0tEZftzfkOqT0nzW8TF3Ca1Kg3fdM0JDyhKAM0AZCdPv7CgEPt7ou83yI3ch9oMRcJwZqHrSXjF+RTNtOm24/wbInjd9THVG1lD92HScXDfxlor+SGS+kpeOfkF+55U+EJYdU7l67EG1/hs1QOmFgDZRL7V81bQq5cTkYn6caivIXdZ1hAGwqa67NW8R8OGWVQtzXPNNWHrXK+5ti3c6LnvBAYxsgbVVOel8FNxljMxTY58TpsO+69fRUtehQwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlV5bmtTWXlSWlE1ZkdNWGkzTXhtalFIQ1NydUt6aG94Wm93eDd0akdyc215?=
 =?utf-8?B?Um1RdGh6dE1Wb0dzVnRpeEVaS3dKMHVFWTU0Mkk2ekhScHJxZ0k1QU54VXMy?=
 =?utf-8?B?aHArMHgxZlVIMjE2N0NYQlVpWVc1aEZBMTlhOGNMd1NsdFgvM24rdUFCSDNs?=
 =?utf-8?B?Wkc1clVGMGVhVlNCdjRYMG5JZTdKU1pTdXNrY0dBYU5RdU9zdFI5MU9KYWFK?=
 =?utf-8?B?VHRKR3N6akRoY0tTMlE4dXBWcE93azBZdWx4alI2S0JwbmVMYVZ2VDRVTW5o?=
 =?utf-8?B?b3dqem1iTzEvWHd4MWpFWXNvbzdsQ0dtNDBsZkhPY0pBenR0R1NUR3pQRHlJ?=
 =?utf-8?B?WmZXWHVHYWJQUVNjMGJMZlBQL0VpZ2g4OFVjTkpzZFg4cHpOUEgxUSs0Qnov?=
 =?utf-8?B?NnNkSzRhcEpvVDIxNUpxeDVhR3UrWUVSNE5yNHZzWVJRb241MnU3SEVlMEZi?=
 =?utf-8?B?cVFQRXhYQlRDTmpSckN4KytYRC9pZ3d3eEdKdnNLREE3M0ZwK25LaFZjbDd6?=
 =?utf-8?B?dzRVWW03RW9QNUNpVlZCa1RlUFZzcUh4NEIzTnlHN3dxUlFvNzIzR2xOQXl5?=
 =?utf-8?B?d2E2dUJ6YzhObS9lL1ozOGcxeEFVbklCVCtmbEJHME9wQXA5c0dWSSsvYzB6?=
 =?utf-8?B?ZEI0SGcxM1VWVkJwdld0NHl5ekJYcHBRTFRaNy9zd2ZwckZpMCsrdHBEb015?=
 =?utf-8?B?RERnU0RORDh1cDVKZWs2QzRid012TlpNZGdjMzArSjVaNlVLQ2FST0FWZ2V6?=
 =?utf-8?B?eldXWDlSZDhmajUvUDNienlpN3ZLY0pHaGVrRHlHYTFrQWFRMm5Pc2RQZ1k3?=
 =?utf-8?B?czI1cTF2eHJ6NkdqeFNFRXBLczVZTHQwK0lha2VKbFVBRGFvTWlGOGtkMmxo?=
 =?utf-8?B?NVpsTGhuMEpFYTFmbTB0cG1CN0lSeFRNSis2NW5JVjBVM1JoMXUxVVplMy9B?=
 =?utf-8?B?SHd1ODJad0Fnd05vdTNEb2JMdENJWUZzK0czdWNYcXVzaWZpY01FOVFlR2d3?=
 =?utf-8?B?alNJMUVmYmNYV1Uyd3RSd2ZDbXh6VGh5b1k4WktFc2lWZkhmZU1lUExxREJY?=
 =?utf-8?B?RE0rSkc3ZmJSR0h4WkR4ZlNkMFdmM0xlYVQyamwzNTBOMFlvV0dscHFULzQw?=
 =?utf-8?B?ak9ldU5qRVZMR215dU5Ea2phYlhRc3BYMWVnU2JSUlpIUE0yZFFvRytUR09K?=
 =?utf-8?B?NCtkcC8rUFZSQ0U5U0hMWEZxZFl2WjcvdjZObkVDZWxYYmdkU1g5MFBxOTRv?=
 =?utf-8?B?dVQyQStsaTZYRjYvTjQyZThMVElRQ09ZNk5teDJndGFqUUYxaWZBeXo0Y25D?=
 =?utf-8?B?bmJKRGpVenRFelFudlJ6R3ZtRzY3L2hLcllWdkt4ZlhFNWp6KzRidWcwUnRF?=
 =?utf-8?B?eURzUkZWamkxOWdGREEvRE5zR0Z1b1VlbUE3amE2Wm5mK09BVDdZMFVOdzVa?=
 =?utf-8?B?Q294WER2WU84cmQreUpRTm5Idnl1ek5pQithSm1oK0xjQWdraHNwUDhUSHJL?=
 =?utf-8?B?dUdFNXdjK3hFSTFuTkZXdWZpZE1IZE9vSEhvM3pLcGQ5eEdnV2VDMTA1RUNz?=
 =?utf-8?B?Ulc4U2RvcExwNlhmOEkwV0ltYkJtN2dLMUJDN2s4ajZ1cWhsNWtOT0VzM3Vv?=
 =?utf-8?B?L1IrT0dkQWRDS1AvK0pURUdVVE05QWpLWHJkNVNObWVGM1FyYkNSNjRRM0gv?=
 =?utf-8?B?b0ppdkFqL1Rmb2NoTlViUFRpTlA1Ymw5dS95WU9hZTBieThkZnpzVGZEM2N0?=
 =?utf-8?B?dWk5bDRmeXQ4cGNUc1h3NGFTUTNaU0tGRk9zMXBodTR1bUpDeTBFeXFPTVhJ?=
 =?utf-8?B?b1FBeWZkenN3aXhDOGlTem5aelZSVEFQUnhIemxmeVJwMHo2TkdKUG5vVFEw?=
 =?utf-8?B?QlFId0ZjMHdEdHpFK2djVjJLZzViRVl2ZmxyYkhvUHloOHBwbVlxQmg1aGNO?=
 =?utf-8?B?d1piSEpYb0JaL0xCZ3lsdnFYcFZ6OFUyZXkwWm03SjREckJBV0lJaG0yeXRp?=
 =?utf-8?B?cmc5VG1TK0dmYUdqVjExVXZiZmRUdFV6MVAycldnM1JtcHp5QVlwMWN3eHYv?=
 =?utf-8?B?b0lPOHNkUDR6SFVidDFycXU3SUovTjVqYWFuTWJaZHByUmpxTStLanJ4NElw?=
 =?utf-8?B?eHhXRS8rR3VITUR4UTVhY2ZaUDJ0TVJjOFVZaFh1NFEwYW1vVk1JN1hISU8v?=
 =?utf-8?B?VC9SMEluN0ZtdkxNK1dudHZPQytoRS84OEJFWlFUQ0gvejYwZ2taaXo2QWQy?=
 =?utf-8?B?dnk2Vk0zN3pQUlNMZURTTU5lR0RxUENSZmlETEhzQUZ0elhwUVlCM0VIWlFz?=
 =?utf-8?Q?o4UbhwzFB1ZSg/WYZj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c622bbc7-833e-42ff-1d75-08df186971ae
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:22:06.9313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgGu4/3po1nhPjpQw3FN0OUL4gBb7iJ6uzD6SLGNJmzXZT4r2z56zloeaJViAW+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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



On 22-Sep-26 1:33 AM, James Zhu wrote:
> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a given
> XCP partition. This is needed by upcoming SPM (Stream Performance Monitor)
> support, which programs hardware per partition and must operate only on
> the XCCs that belong to a given XCP.
> 
> For partitioned systems the helper returns only the XCCs belonging to the
> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is
> not partitioned) it returns the device's full XCC mask (e.g. 0xFF for an
> 8-XCC device). Note that the full device mask is returned even on a
> partitioned device; callers that require partition isolation (e.g. SPM)
> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.
> 

Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION usage 
on 8-XCC device?

The default state on a multi-XCC device after driver load is all XCCs in 
a single partition called SPX. It should have at least one partition valid.

Thanks,
Lioj

> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and derive the
> count from this helper via hweight32(). The helper is defined out of line
> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
> dereference the (incomplete) struct amdgpu_device; it only passes the
> pointer through.
> 
> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
> returned 1 for non-partitioned systems (and for AMDGPU_XCP_NO_PARTITION),
> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). CWSR
> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the per-XCC
> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
> ctl_stack_size and dbg_mem_size values grow accordingly to match the
> actual hardware resource requirements, which were previously undersized.
> 
> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc count")
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Bing Ma <bing.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>   5 files changed, 66 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 57fa69c0382d..7782ccd4d28f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>   		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>   			return -EOPNOTSUPP;
> -		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +		num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>   		cwsr_info.ctl_stack_size =
>   			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>   		cwsr_info.dbg_mem_size =
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index db09e879b85e..d19af9cb6ee1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -258,7 +258,7 @@ int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
>   	int num_xcc;
>   	int r;
>   
> -	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +	num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>   	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
>   					num_xcc);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 2a56f5ec9c76..90846d55292b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
> + * @adev: amdgpu device pointer
> + * @xcp_id: XCP partition ID
> + * @xcc_mask: output parameter for XCC instance mask
> + *
> + * Returns the XCC instance mask for the specified XCP partition.
> + * For partitioned systems, returns only the XCCs belonging to this XCP.
> + *
> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF for an
> + * 8-XCC device). Note that the full device mask is returned even on a
> + * partitioned device: callers that require partition isolation (e.g. SPM)
> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.
> + *
> + * Note: On error, xcc_mask is undefined. Callers must check return code
> + * and only read xcc_mask when return == 0.
> + *
> + * Return: 0 on success (non-partitioned systems or valid XCP found),
> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is found, or the
> + *         partition's GFX IP details are unavailable
> + */
> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
> +			    uint32_t *xcc_mask)
> +{
> +	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> +	struct amdgpu_xcp *xcp;
> +	int i;
> +
> +	if (!xcc_mask)
> +		return -EINVAL;
> +
> +	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
> +		/* Non-partitioned: return the device's full XCC mask. */
> +		*xcc_mask = adev->gfx.xcc_mask;
> +		return 0;
> +	}
> +
> +	/* Partitioned system: get this XCP's XCCs */
> +	for_each_xcp(xcp_mgr, xcp, i) {
> +		if (xcp->id == xcp_id)
> +			return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
> +							   xcc_mask);
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>   			const struct pci_device_id *ent)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 692508be23fb..6eed82ad49b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -44,6 +44,7 @@
>   #define XCP_INST_MASK(num_inst, xcp_id)		\
>   	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>   
> +struct amdgpu_device;
>   struct amdgpu_fpriv;
>   
>   enum AMDGPU_XCP_IP_BLOCK {
> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
>   	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>   	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>   
> -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
> -					 int xcp_id)
> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
> +			    uint32_t *xcc_mask);
> +
> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device *adev, int xcp_id)
>   {
> -	struct amdgpu_xcp *xcp;
>   	uint32_t xcc_mask;
> -	int i, r;
> -
> -	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
> +	int r, count;
> +
> +	/* Derive the XCC count from the partition's XCC mask (or the full
> +	 * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
> +	 * handles both partitioned and non-partitioned cases.
> +	 */
> +	r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
> +	if (unlikely(r))
>   		return 1;
> -	for_each_xcp(xcp_mgr, xcp, i) {
> -		if (xcp->id == xcp_id) {
> -			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
> -							&xcc_mask);
> -			if (unlikely(r))
> -				return 1;
> -			else
> -				return hweight32(xcc_mask);
> -		}
> -	}
>   
> -	return 1;
> +	count = hweight32(xcc_mask);
> +	return count ? count : 1;
>   }
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 16aa22b25098..1c7b2f3227e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   				uq_mgr_to_fpriv(queue->userq_mgr);
>   			int num_xcc;
>   
> -			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
> -							 fpriv->xcp_id);
> +			num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>   			trap_params.ctx_save_area_address =
>   				compute_mqd->ctx_save_area_va;
>   			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;

