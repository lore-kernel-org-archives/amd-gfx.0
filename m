Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA769CCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8982210E121;
	Thu,  9 Oct 2025 12:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cw/JHVW7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19C710E121
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1RjstR1ycsxAlbAgrw8zei/vQO6RqdFTE6In1uWDlfRFXutLCEwQwemCk1nGU32FgAQ+WmdivS9BUNTnklJma+nzVBA9/lxPmAY1IoAdljA9Fa+TTXtHLdVH0BIhzHo7gDdp+Hxdtu0edq4KzE5AJnldTjeVvk71MHE56H7F+DgWzrBZmg9xjiduuRs5rbTfazaR8ykwY7/yqnkRBoVRVblf4h8Sz+EFMDKdzbR/OAYRQs94JQQl2bh27/ATwmSg8e9QxoWWHhBg0vq/lq/flrWzGsWTDyKwmb8vTa7pD7nzceuYsJZYfEWWrBYuuXZK01N+Fm5ZnY0Du8KyNlYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AssCLRD4T330OGSv5KAwoq0rk0frASlclG/hCJtbecI=;
 b=gCQ/7kGwCBIlMG/jEW/h1NZyJbmMia4xO0Ds0HiOdO05+jQySukpHQy5Z3Zq5unMfEiDX0TBc+gnfv1t+7us/nU1J+b535X3b83qys59rvMGT2nP5wxYp/zf1B2mFWA696QS6Zj8AX+4rJqehcX402zu+r/m4G9/BYjipaTSkrlqa9z/FBCB20Mxp54YKrfc0ngqyb3ArdBvru/Jz0/shsaMWhoKN5ufV0Vmt1T91/qMertibidiw/IQxt/4Bbfo8Q4aB+dPwlJ9h+huDw/ynaljQQNl9PYKcgvkjC6shhmAX/C9BfpbYV7V0bfTaYofaaHqiKqfdLHPR83ULFrHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AssCLRD4T330OGSv5KAwoq0rk0frASlclG/hCJtbecI=;
 b=Cw/JHVW7Bb7lc+e6Q7m2Bln/a9AWZqDuIBV0QCigpvjepBKkovCTDnyJje8ugkxTccnRBKYrjjq+DCMkCzmq/wthni10y6nEseR+0z/cuwIbgtZAUhSIf7UI0/A7dAeBk3w1t0pN16b07ysinis7kiyNnzsBpd5RqJQU0ePhuxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 9 Oct
 2025 12:15:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 12:15:59 +0000
Message-ID: <ef441f26-43fc-42fa-bda6-80152ff8816f@amd.com>
Date: Thu, 9 Oct 2025 14:15:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Shravankumar.Gande@amd.com
References: <20251009032931.24950-1-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009032931.24950-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:408:f8::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0ff0ad-95e8-44cb-1500-08de072d9afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vld0aXV5RWRsOTF4LzB5ZHFjdkQ1eGtCOHkxUysraEhkK3NOc3pMZEFqL0Vk?=
 =?utf-8?B?YWpmR3JRSW9IZmMwUllqTDlFaG1ObVRHRTdwUXdJSU5haEMxdUZhUldlcUR1?=
 =?utf-8?B?OW9VdU04ajE0M1M5bzVYZDJmc29UTnN2UnZqUFVnWDhUQ0kyMURYOEpLVndM?=
 =?utf-8?B?MU9jdU9iZlV3TXZDVHFWMktRS0dhWmpvc2NQSUtQZG9hNld3ZWhHYVJLY3E3?=
 =?utf-8?B?SWpKZUF4aElCRVpBVHVDR1dyaWlZYTRYaklNUnFHb3Bhck12ZlA0Sm53QjVt?=
 =?utf-8?B?WWNNeDZQRk5SWVRyZTdpU2lrSFZyNk5xRDVaclpjeEQ0N1VaVGRKYTdBM1Nt?=
 =?utf-8?B?VCt6QmhtQ0VYMHpkTU1JbUlRTndjNjVUSWhmaHBpZGRpejY5YW4rZ2NWdytF?=
 =?utf-8?B?eEZHc1ovWjNiNTdQZXdLTEloRmg4QUdOOVVrSVNTYzhJa0E2TlFxekJac3By?=
 =?utf-8?B?dVh0Rm5BZEZnMTZvU0ZkT2poZU5UejdBSkJhTXJXcVRFbFU2UWFlSGhCU1d5?=
 =?utf-8?B?QlFwWmV3L3IwMTM2eEkybmRhSXEvMzJOUzIwS0t1MmNuT0dxMHZqWSs4SGhB?=
 =?utf-8?B?Y2JTbFdqK2YzckE0K1VrRGQ5MDlrZWNjMUtrQjkwdmxZMmcvaU9mZjZaVVVL?=
 =?utf-8?B?c1hITktSb3B1RWk3dWEzNUExZzJoNTlNbmhVcDYzQnV1bE1VbVJydDlwZ21V?=
 =?utf-8?B?bGdvb1c1L0pseXBkUHRSOEVOY0J2RitXMy85R1VJQ2wveEgxUTh1QWRrRFdp?=
 =?utf-8?B?V1hpcGI4dkdVUFJoZ096R21CdlErblZZcXJqcUxUVTFNQ3U0MjhZU3gwYjFB?=
 =?utf-8?B?US9FcU5iK1E4VnpvWUdCcG8wRHdwenVNaGdBOGxjY00rZFpreTE3Y3RaQ3FY?=
 =?utf-8?B?eHBvMlNsRjljMERBQ21pdzhFWlV5eFpwOUdLOHRZaHJaME45L1libVBKTFRH?=
 =?utf-8?B?R2VhNDRJdVFYcm51TGJDS0Q4VnF0ZEpqTjhXK000R29NRyt2MFJwQTRGS2xY?=
 =?utf-8?B?TUIzTmhnZmFUZzBEdmp3alNka3Ztbk9YUHIydCsrRkM1WWEzSkd0WkxWWExG?=
 =?utf-8?B?eFpQdzFQcFJaOXREeHF2TFMreXhBd2RFUHJzTDcrUHA4YWdudWZhY29LSVZ0?=
 =?utf-8?B?QmZpZVVTQjF4cU5XSHZPL0hNOVRCWTA2SFphd25kNWx3Nkc0T1pxcDdOb0Jl?=
 =?utf-8?B?cVIxVE15NldqbVNaTS9TOGRLSjdodE5LN0IwbVlwd25xV3IzNkZwcEJLTVBy?=
 =?utf-8?B?WkExTHlkUFUwdnZOTVJWMnVPd2lPelFBVDJiYlhIdW5aK0wxbjFETW00NWI5?=
 =?utf-8?B?TUgvekFQcHBIQTY0UFloYkdmWjUwSSsyS0tzTU1UeDY0OTQxVUtSNWc3SHJs?=
 =?utf-8?B?Q016MGVRR2lUQllXVEgvcFlIZTZKdkNwTXpjQmRHYXd3REFJRGR4Vi9JM3Fn?=
 =?utf-8?B?dmJRMVhOZHBrc29IK1RxWERTL2ZKMlhpbzh4Zlptc1AzejI3RkRCR2hyOUVr?=
 =?utf-8?B?Rkp5OXlLV0dZY2xuWkFkOTlPdHkvOTU5QzFabDk2d3V1aEx2cGlpbVJGVi9C?=
 =?utf-8?B?c3R1UEF1QWtNbkFkemNXWHplNXZHMzQ2bjNYL3pmempnTyt2RlhNRFlod0Fx?=
 =?utf-8?B?TG9SMDY1KysralBnVjNEUE1XSkVsMzc5RjUzbFp4bDNHOFZMUi9maWxlK1la?=
 =?utf-8?B?Z1JMUkJ4Qy9pcHlnakZGc3AvMUFVODlpN3lOSHBMMGlXVFNIZVNXd3I2a0hI?=
 =?utf-8?B?TUYzM3hHeE0rMjFEZHZsS3BBejlSRzExN05xM1RZRDFBdUNPM2lJVDVhUFF0?=
 =?utf-8?B?b3VhT3YwYXk4ZlN2MmYyTHNiaFJ5MGQ1VEkwMkNrZHFZS3V0dU9iVFl5cHZx?=
 =?utf-8?B?cEFaTnhsdGwzSTJDRUhYeWMvaGhzS3Z1d1M4N2ZiUWJ6N2Z0ZW01TXROYlE0?=
 =?utf-8?Q?N3a3iIY3zIPGxhmZpLWZAAQJtpIsBbia?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXAveHVMekEvZlNuQ3Jyai8zdDFXbmJzL3Rzc21CR1dKN0NyVGtsTjJHUHQy?=
 =?utf-8?B?bDlpN0Erd2lZNXBmRHNTdDBsNkxscEZ1elFBOGwxQXZRVkoyRWNEQVdsdE9B?=
 =?utf-8?B?U01MTkNMUDhIMFdnN2g1SWFhczg0TFNwV0dKbFBXL0tjc3JORURRaUdzMmpM?=
 =?utf-8?B?NmhBOTgzR21Ja3BJRGgzYWtPL2xhY3BSdDFQb0JOaFJKT294TkJpRHc0RTZm?=
 =?utf-8?B?eWdITTFLcUZvVHBSS3A5cUQ3SUF5WWx2TFZhTHFqdWJNdnExbEZjT3g3VjE5?=
 =?utf-8?B?TTB6OStkZFB2dXdCcXQxd3Y3NXd5QXJGbXZMSDk5VVc0RGJxMldrTklxR0NK?=
 =?utf-8?B?YitoL2hQOHk0anFBejBYSXJQVUEyNkZ1TEhqYUlzMVN6WVp2N1ZuL1dvcVZj?=
 =?utf-8?B?SFBiYVBKRmMwOEg1cVluRXdGcVlxdFZmRmo2SGJlTHV1ZXpJaUtSTTZJSUlB?=
 =?utf-8?B?NDBZNUdUaVdJNm9OczhwZHgrVXcxOXlSNVJKSGVyUmRpUURITlZSVWdRL2o3?=
 =?utf-8?B?UEcrd2F6M0VOU2Q5WEFSUWFWdDNUaU5UYnh5dHNUdW40Z0NuanUrVnBzcDd4?=
 =?utf-8?B?QmNUSmtFbUdYdDVIcERQN3JvNitwK09FNUs3eE5EK0RUb2xoNzhiL0tMblNv?=
 =?utf-8?B?QnJleU1scDN3SFJOYUc1VG8wMUlobEpTMnJwdFBXa3RDaUFyd1RBWHZoakc5?=
 =?utf-8?B?VTI3cjB1Rks1NEdvQ0tPUTJyNEtOZVV6M1dDWGp0MFBtVTBSZjg5bks2SkpP?=
 =?utf-8?B?T25FQUoxWHhwTVBDK1VtV3RNbFdwcVZsOW1HUFJsMUNoNmVXblBkTmZ6dWtP?=
 =?utf-8?B?SmRvNVcrejBmeCtybmpndHBGWHd3T0ZIbVpqQk8wQWhpNUhQSFJMQjNBTWht?=
 =?utf-8?B?TXdpaWJNY1h4UE4zYkZiMTN4bVJsczEwS3gxdzNKR1BrRXRVK0JyUDNWOTJ5?=
 =?utf-8?B?WDY3dnF4TjdLeWE5K3loR3NEdld3aEEzRFJ2L0hGenp5YWNxOEZ1bmppQTNI?=
 =?utf-8?B?dlhRUnVrekp5bHFONFN3MHdRWVd6TTQ1OHdWWnJmN2JvR213c2VXNmZ6L0Ry?=
 =?utf-8?B?SUhEWWd6WENxT2VvbHlrUVJGVnhYUmNrYlFZRmlSY2pOakhmaXVFNk5QMHJo?=
 =?utf-8?B?QmxlbG41MTdVNjRLdUlJcmFDUFo0K0xOY1AvK2xDSUltazNxdWhoR2VWQ1NL?=
 =?utf-8?B?SWJVZkVLMlNxSHZwMFBHZ2k5UlZSallPUHRORDUwVkFQeHNHTEZsN2hQcTZL?=
 =?utf-8?B?T3lVUzIzOFdvUWtKekdiUVcyYVdMWWdVTGF4N09lMlFpT3BaVmVsbFRiVGFh?=
 =?utf-8?B?WWlLMDlIQ000akZaVnVzWEJOOHJJUGZ2RWJBa1VydklySkhTYVdpMWRoeERR?=
 =?utf-8?B?eDkwekx6Z2xFL0czU2ZGRGtlOHVva3dFcFEwR1RiSEg3UitBc3BuUE9YcCsx?=
 =?utf-8?B?RW0rU0VBdWZ6dENzemZKcCtVbEQzT0EzTFhhK2ZRcUpHR09yMkVoWS9IbHQ0?=
 =?utf-8?B?NEp6Q1dFRWh5eTNrUWhUQ3VjOXh5K1pERGIzU0E1cU5sK1FLdGNuSkIyei9M?=
 =?utf-8?B?YXF6ZW14WndlQzNTTzNGbU1HclA0WWE1RXhmNlppeWQ3bGs0dWFuV2VpZEU1?=
 =?utf-8?B?NklsZlpoTHJTNjlIbFRpZHlTdU9QYnpkdWttaTEvQ2lsTjBhbVcwamtFV29X?=
 =?utf-8?B?U0pUT0FSbnFnOVRSeUFRb0ZiMVB3aW4xdnpSRmtsL1pVcFZiY2taOHdlZ25F?=
 =?utf-8?B?cklURFJHdzB4MXRNOWZKWTBsMkZvV01ZbnNCT2NrN3dSMzhLR1daL2FzaVlj?=
 =?utf-8?B?WjZGNG80YWxLT1hUWmxpSyt1aHA4TDU2S2hXbVpmN0lraTBHWXoyUVZOMVlX?=
 =?utf-8?B?TFphNzhwb1FmM20rdWpMTFR6RFlmc09XQkFWd0pOazdFc3VaSWQ4UE9mUDlH?=
 =?utf-8?B?bkp4bEJnMkhodjFSRGFQdFFPbjdYZGZKdTgzNDc3UWhmaWpyMElXZzJuaVRj?=
 =?utf-8?B?emIvWno1V2F4cjJqVDZFVDkvK2lmY25uTUNtbGRPeStTYTBIejN5bDY2MEFw?=
 =?utf-8?B?OVZabEZiTXNSakxwS3BKU0QrdUxWc2V3VXNXUWhiQUx1cVR1RHVBMy9rVEM4?=
 =?utf-8?Q?eyNOgPZfEM88Mo6lMILqwI9QN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ff0ad-95e8-44cb-1500-08de072d9afb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:15:59.0722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jcEyr7f7a7P7EYi8PK/kn2RhzBioNQNxgRpRZtQyyzgMXAcFRQZy1qKharg+3cV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

That starts to look better, just a few notes:

Please use "git send-email" to send out the patches. I can review them, but they don't seem to be send as consecutive patch set which makes it a bit tricky to track it in patchwork.

On 09.10.25 05:29, Ellen Pan wrote:
>  - This change updated existing SRIOV critical offsets with suffix _V1.
>  - Therefore to prepare for the later patches to intro SRIOV critical region v2.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this patch and patch #2 in the series.

When a patch only touches amdgpu_virt.c and/or amdgv_sriovmsg.h it is fine with me that you review that inside your team.

So feel free to add my rb together with the one of teammate and push the patches to amd-staging-drm-next.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 57 ++++++++++++++-------
>  2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3328ab63376b..e95adf0407a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -686,7 +686,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
>  		adev->virt.fw_reserve.p_pf2vf =
>  			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
>  
>  		amdgpu_virt_read_pf2vf_data(adev);
>  	}
> @@ -703,21 +703,21 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  		if (adev->mman.fw_vram_usage_va) {
>  			adev->virt.fw_reserve.p_pf2vf =
>  				(struct amd_sriov_msg_pf2vf_info_header *)
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
>  			adev->virt.fw_reserve.p_vf2pf =
>  				(struct amd_sriov_msg_vf2pf_info_header *)
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
>  			adev->virt.fw_reserve.ras_telemetry =
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
>  		} else if (adev->mman.drv_vram_usage_va) {
>  			adev->virt.fw_reserve.p_pf2vf =
>  				(struct amd_sriov_msg_pf2vf_info_header *)
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
>  			adev->virt.fw_reserve.p_vf2pf =
>  				(struct amd_sriov_msg_vf2pf_info_header *)
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
>  			adev->virt.fw_reserve.ras_telemetry =
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
>  		}
>  
>  		amdgpu_virt_read_pf2vf_data(adev);
> @@ -1304,7 +1304,7 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
>  	checksum = host_telemetry->header.checksum;
>  	used_size = host_telemetry->header.used_size;
>  
> -	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>  		return 0;
>  
>  	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
> @@ -1383,7 +1383,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
>  	checksum = host_telemetry->header.checksum;
>  	used_size = host_telemetry->header.used_size;
>  
> -	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>  		return -EINVAL;
>  
>  	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
> @@ -1515,7 +1515,7 @@ static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
>  	checksum = host_telemetry->header.checksum;
>  	used_size = host_telemetry->header.used_size;
>  
> -	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>  		return 0;
>  
>  	tmp = kmemdup(&host_telemetry->body.chk_criti, used_size, GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 3a79ed7d8031..3b35154e2df6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -23,26 +23,47 @@
>  #ifndef AMDGV_SRIOV_MSG__H_
>  #define AMDGV_SRIOV_MSG__H_
>  
> -/* unit in kilobytes */
> -#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
> -#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
> -#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
> -#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
> -#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
>  /*
> - * layout
> + * layout v1
>   * 0           64KB        65KB        66KB           68KB                   132KB
>   * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
>   * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
>   */
>  
> -#define AMD_SRIOV_MSG_SIZE_KB                   1
> -#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
> -#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
> +/*
> + * layout v2 (offsets are dynamically allocated and the offsets below are examples)
> + * 0           1KB         64KB        65KB        66KB           68KB                   132KB
> + * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
> + * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
> + *
> + * Note: PF2VF + VF2PF + Bad Page = DataExchange region (allocated contiguously)
> + */
> +
> +/* v1 layout sizes */
> +#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1			64
> +#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1		2
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1		64
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1		\
> +	(AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + \
> +	 AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +
> +/* v1 offsets */
> +#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1			0
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1
> +#define AMD_SRIOV_MSG_TMR_OFFSET_KB			2048
> +#define AMD_SRIOV_MSG_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
> +#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
> +	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
> +	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
> +	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
> +	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
> +	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
>  
>  /*
>   * PF2VF history log:
> @@ -436,12 +457,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned
>  #define _stringification(s) #s
>  
>  _Static_assert(
> -	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
> -	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
> +	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
> +	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
>  
>  _Static_assert(
> -	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
> -	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
> +	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
> +	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
>  
>  _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
>  	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");

