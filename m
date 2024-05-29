Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54D8C25B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F041132A8;
	Wed, 29 May 2024 06:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZE/Kzt4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FC31132A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWntWfzc3zADIMsS03DBTAyXRJkzLC52QwhpIVMvaIFW1VIdbN3+iRF1XozWjsX5MqcTSIKP2rd+Fo3t2i9Zq0e4dssN/5Ufo3om/YZ+65nyd7ghRUQuIBaNFrGTW4X7pQQwotGml1tMI9lMVXnAsoWtp2W7c8VAYeq5c6kI8a+Rvec5cCsErKThlf2SjS3xngb2snXPdI7TfyRd6GOEiLxs4QE9aofThxpLRoH5sQkzx3/Sj/ZZ63dbPxfaulBY1Ua14LN/G4zbqE4axKuqe9u2LKbVxruC6CGUEm6Xj5JMg2zd8R746yiK06F6O98cdIGx+ljATQWl5V9wlTKhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8UqW732rNttJkR5l5MOicozl5rIpgXknAXbqY5/F4k=;
 b=eYonJgw2tadmr2ib8YOyVTbt5N7y5l2qDCp6ZmJf7XxrgGBWzoRUVsclDz69mn1Mg6ELsWtJXrXKLcUpZXfpd2vk+k4Vgsynn+cLW6TTxh4QlkO9S/5uNxGgi60dgRx80f3tOPO1ABnb4f+8Ut6QC7mqee0nnXs1mSyjpMpGyOyVtSKoVrrlgDACFHA/1Ys6NvG8sUOSwlLkb9RQhY/T/WCQr+RohWmGHNyLsaL5EtFhK28V/BKyTXnEWP3IlM11crRFz4KWrF+k9o+xkVDVleCLYaCzAFD3K/p+AK0y7N5EjHiQS+Q53K5xAFHKGtk6e4IVL1NrvP1HRSqVv7iZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8UqW732rNttJkR5l5MOicozl5rIpgXknAXbqY5/F4k=;
 b=BZE/Kzt4UY02xyReWEx4EL9rZnKWDgrLsoIe8/z82KOIdQd8ukAkoJHKrz9B5dRu2v4ZvrswNnEKVMmoQXSvs2ktJIRhT418vlw68Ajz/6Z5FWEc8mf22rdbp3PCxaQELLsdYh8C1MXvSUKdb1b/gxWEgICN8KUTK/VvtS+QPNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:41:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:41:07 +0000
Message-ID: <010fc2f2-f616-4ed8-ae8e-6dca6bba8890@amd.com>
Date: Wed, 29 May 2024 08:41:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] drm/amdgpu: fix sriov host flr handler
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-3-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-3-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1565b2ec-4732-4194-3298-08dc7faa51ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1BqckNyclpyNlN4T0JVcWpVczNpdW9iN2tmcXF0bGlTUTBEYit5R3BvUXd6?=
 =?utf-8?B?ZkNjNHB6a3BrMnJpZ1Exd25ZaXl2YnlpZk1ySkp2S1dZZzJHdzRWcWV6c3lw?=
 =?utf-8?B?OGZoK2toWU5ZdTNxTjA5d0FnQ1ZXNWxHMmR3enpOMGJVdkFteWtkaWlDQ1pm?=
 =?utf-8?B?aGp2STluOExwVytlaTNyeUI0K01TazgrOW8yekxuWWZpWW1jajdzVXc1Q2lu?=
 =?utf-8?B?N04ySHhhUEp3WDNqZXhXSXFmVXRxYlhpRFZuVHlrV2xLSURhdk5kQVVxeExp?=
 =?utf-8?B?S0xOczQxenl1R0hCNldQMkVWSFN3ODNQSTc0Z1QrYXg2UFFleGlCOWY5Yk40?=
 =?utf-8?B?d1BmRmJzT0l0M3FLZEQ5VmZjL004R2t6emQyN0pGNis2cC9PMkxpSUxXMVJh?=
 =?utf-8?B?ZC9VSGRzeTI2eHZkQ3dPZEpHUjhKa1hOSnV6T3FxT3htYWx1ZU42RE1sbDZX?=
 =?utf-8?B?Y0ZwaUorS3Z3QzdTT3E4WnhzdUt1ZmZsVysyS3VqL2JhTUYzNG9icGVaa2hh?=
 =?utf-8?B?RTJiOUFLak5JR0ovTHNBVXMyUjVmRFc4WU9BcllqYUhrOVJQVy9GM0dHUDNL?=
 =?utf-8?B?aG9hcnVtRE50Ly9wUXdENmE5eGdXdmVIUzJUL2xhQm9NMGlvVUNTd0tWdG5M?=
 =?utf-8?B?U3BMbjEwQlV1c3FoMk9mcFFiZ0RWSUIrbmlESXhNb1RlbzZYbm1mbmVyWk1v?=
 =?utf-8?B?aEhMVEVSMjBEUEoydlJOQ3JSTmFFWFNVSkpaYStvTUhsa0hPNWpHYmpBWm9L?=
 =?utf-8?B?bmNIanRFN0NxM1BnWTE1azJlaEJ2d3N2dGcxZFZZYXZXVmp5QnhUYkk3b3BS?=
 =?utf-8?B?WVFGMS93WlpMbzF0VFJTazIxVkhwd0IwYWRlWmJWTTBXZkpzRmhUdlA0N3lP?=
 =?utf-8?B?MFpiek1qOGt4dndxRGtQMjYwOU01ZWVGc2dTc0tCcWNWbndSU2IyaGNITlF5?=
 =?utf-8?B?MmorUzFIVlZYTXJPZG9ZS1c1TnBFcFhnYjRmT3BYdUJsZ3RWbXZpRSsybVg4?=
 =?utf-8?B?RnpmMndaNGorTjFhajFUSlNjSjIzdHQrZmJoaDM0QmxPZkd2R091RXF5dUFK?=
 =?utf-8?B?d1pSYlVJbmRSVC9ISzVTeTkzL1lKdFlLMFVudmNHV0F3S0pocmJtYXJSaE9n?=
 =?utf-8?B?SlliS050YVBsZnRhN0tvL0tONzZhN3NnYzU5djhPR00xZk9nWHFEQWlFQmNY?=
 =?utf-8?B?Y3c5enRBck9kNVJMQzB0SXF5NWZwU0J6WlVBd0l0bTVya1BzUzBXQU54eVND?=
 =?utf-8?B?ZjZDY0hoU0d3VDBCcWF6cmRmcGFzK1pMb3ExZ09GZ0h6cU9ENy9YcnZHS0Vw?=
 =?utf-8?B?SEdFYVVIMVo0N2dFU253N3ROdUVwbXEwbFlTbmtrRnRpOUxWSHZmc29oOEhs?=
 =?utf-8?B?N2lJd2NCMWJRRXZxQjNnNUlWajdFTWpHU2xRSGluRjFUS3ZPK2ZoV2t2c2Nv?=
 =?utf-8?B?SEFYZTFhQmx3VUlOTXUyL0tzVEc5aUYxendlSzNYR2xpZWhFNmFWODBwNnZK?=
 =?utf-8?B?NXZsVnNiZ2dwa2VqbjVOdVA5K0QyNHJ2cTBGdDh6bEJiVlBPVDFmNHgrYkla?=
 =?utf-8?B?RUVrcnQydHpEL3ZNYi9ZMHlzVzl5VVpWQXlmZGVNR29Fd3FkRlJNaW5oZ3ps?=
 =?utf-8?B?T3dmZ3dzOTduOXVOOVJDcWpFRlBIT204RVlpNFhwS1o4UmNUdFNaekFTRUlp?=
 =?utf-8?B?djZ6WUtjdzdGM0ZLZmlNMEN1VnVlRng3U2VySEE5SWRualJtTmhKS1NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNCMzVwL3ZXWjdZbUp3aGxoNTZ6VVVaQndHRkd3QVZPajdTQUhKbWgzMGQy?=
 =?utf-8?B?NXZpNUd3QW5jNWprcjVaN2dtdFVLb2JSRFVkV3BHeTJ0akMxMlg0WkF5WmZa?=
 =?utf-8?B?N3FuNnpQWlcyVnRzN1hjaWE2TURpWUgzVlluM2U0Ujg3QWhzUlhQY2d5NVU2?=
 =?utf-8?B?TGl6dVhrU2duS0RnbU8wbzVyVE5QeVZyUnJUd1MyVkxySEFXTzVyd1JGT25T?=
 =?utf-8?B?dXpxMWl6czdaUnpCZVI5ZjBVUjliSi9yeWdVNU0xNlhpN3ZHYzJyaW1wMzhx?=
 =?utf-8?B?QU1GY3RtZGgxYXVvVUxMa3FEbWNLOG8wNzFzcmpBYWZTd3FIbW9tb2RnYlh3?=
 =?utf-8?B?NXZyRm1pZXN2S1oyNmJqY0ZMYksvUWhhSXlFeDM5U3JEbkNxMithUTN1WTdD?=
 =?utf-8?B?YXR5VnRnMmdaN2RDRHdjRWRDSHZuZ3ZCOWxHaUxFb2RibEIvM0NHV1dsSTVp?=
 =?utf-8?B?SjRzR2dZNDduZzNFRHR5RUtzOVFaSm5JclVUa1ZyTW5xaWpQMC9mSGF2QXFM?=
 =?utf-8?B?SGJpVjJ3ZGxUQm0zT0t6WjlHc0FaR3I3eGFBV3kzZWV1RDQ4TDZDS21MS0dN?=
 =?utf-8?B?anR1STJBRENLSlNCRkVPVGFkMCtWVy8zUWZTODdmOFVac2Y1SkR3K0FvZTJj?=
 =?utf-8?B?Q2dJOGpvalpzK1hvYzh5blVPeExPNDdXVUNCSkpWeG9WZTl0UWQ5ZGlBSlVs?=
 =?utf-8?B?UjhPczNCZ1hadERlMC9pU2lWekpRSG9yajI1akcwOU5ranhXZUtZc3o1WjI3?=
 =?utf-8?B?eDdEQ0RQZ3Nna0JYRUNVNFBhSkJqcUZZeFBpWEw5MC9xUElmdUQwWWR2KzVt?=
 =?utf-8?B?VkVRSThQWGRxbWluUk1BcHlMNFN5Snl0Z1htTzNSa3dCblVNNXBNeGttbWt2?=
 =?utf-8?B?UFcrQzZxbFpoYTh5elNMSjFIYTJWUmc5M0Fma1pOdFJTY2FqR0NScm9mZW1K?=
 =?utf-8?B?QkF6SUNneE5LK2tFRjJMV3J2K0paQkJmQU0veDFYa21ueklhVStXaWVsU2lE?=
 =?utf-8?B?cUFXUm52UHVkelRSdnFZZWNQNEIraW4yUU9TaEszeUJaTGI4dWg1UzZuVUVo?=
 =?utf-8?B?RFNSQSsxVURmQ0xHeGpYd1N6dVNEaklGWlVuUG10MjBDQkk3ZUlQRGR2eTZC?=
 =?utf-8?B?MDZWMmhHNGl4cmZyeUdIRGhWbWV1VlZZMFRYZGkvb2s0cWh6RFZydXBjRGVh?=
 =?utf-8?B?ZVM0WEttNFB4ellBMFI0N3RBWjd0dzZnbk00MEp1b3R3ekQ3TWdCZjM0b1pN?=
 =?utf-8?B?TWVaY2U1T1kreWp1bWRsSUNJMGViQjVOWi9KbUI0WXV3TW1kTEpFaXZ4aHlB?=
 =?utf-8?B?L1QydXUrdFA3bzBlVFIvY0wvY1NCSVpGVzRHOEphRnI0anEvclEwWjZ4dVhY?=
 =?utf-8?B?T2VSeVBmYWpJQUU3ZGhVbjdLRzR3Sm5zcWF0UkNEQlZLcGhuYXFHbVlDdk56?=
 =?utf-8?B?Nng3QlpNRVl0ZGFoYjYzVmZlSWdLV05Wb2t6SllRVVMyOEJXaDVkWTluVFVN?=
 =?utf-8?B?akJITUx4WjYvcVZuYUNkK0N2M3d4bHZjV2VPczA1NVB3QXYzT0RIdUI4TWpE?=
 =?utf-8?B?M2Nkb3p4cDg5RnlPKzJuUmFqWDRmM0pjaGpjVVVCL3hCWFVHSTAwaUN2STZG?=
 =?utf-8?B?RGhSUjJXQ3dSZnRSSGVBVkNHWkY2TVl5L25wSDdRTWtNaVdyY2hBbTNlTU5w?=
 =?utf-8?B?c3V6aEdKeFhSM1JkcFdxTlBYU0hUTHNFQmlMZXVETWpieW5CaUFpQmJ1QU1U?=
 =?utf-8?B?WmJ3dUgvQk9kTnpNRWxVVFBGR2tVeG1nSUoyVVVGdjZ5WHFoSHdCWnkvNVlm?=
 =?utf-8?B?MXdSM3dkSmo1cWozeFJDMXIySnpaOXQ4TENZU3czSGNzWXl5ODVuaFh0dFpn?=
 =?utf-8?B?UTFOSENpRXpRdEp6eHFjT2p6OEdkTkhjV3kwNVhqUVZEQnFxdlY2MUdXUzJZ?=
 =?utf-8?B?WGJiYk12dHVGOUo2aE9scHFQYU40bEpVZExwYVo5WlBnVGp1ZjlSUmNFS2pK?=
 =?utf-8?B?ZE5iaW1uclVYMlJFOEx4b0dJRFBSRVd4L2pxOThHSlVQSk1lZ0habkZsY2Fk?=
 =?utf-8?B?UGhaSnlqY1VjMVZPVjNRYWxVdkpSWGROaVU4QTE5NXRhZUdIRnZka1FMbFRC?=
 =?utf-8?Q?Gh9PYwFY2rmCEWkd6om8moZvq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1565b2ec-4732-4194-3298-08dc7faa51ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:41:07.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwJqMrAUgLVOZNGbWaXuH8Ljna5cKxv/PhBCOfyahx2qeuSnFN9mOc6hB4ZQbtjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> We send back the ready to reset message before we stop anything. This is
> wrong. Move it to when we are actually ready for the FLR to happen.
>
> In the current state since we take tens of seconds to stop everything,
> it is very likely that host would give up waiting and reset the GPU
> before we send ready, so it would be the same as before. But this gets
> rid of the hack with reset_domain locking and also let us know how slow
> the reset actually is on the host. The pre-reset speed can thus be
> improved later.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

It looks like a nice cleanup to me, but that is absolutely not my field 
of expertise.

But feel free to add an Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 14 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 37 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 37 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 ----
>   6 files changed, 46 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bf1a6593dc5e..eb77b4ec3cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5069,6 +5069,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	struct amdgpu_hive_info *hive = NULL;
>   
>   	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
> +		amdgpu_virt_ready_to_reset(adev);
> +		amdgpu_virt_wait_reset(adev);
>   		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3cf8416f8cb0..44450507c140 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -152,6 +152,20 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
>   		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
>   }
>   
> +/**
> + * amdgpu_virt_ready_to_reset() - send ready to reset to host
> + * @adev:	amdgpu device.
> + * Send ready to reset message to GPU hypervisor to signal we have stopped GPU
> + * activity and is ready for host FLR
> + */
> +void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_virt *virt = &adev->virt;
> +
> +	if (virt->ops && virt->ops->reset_gpu)
> +		virt->ops->ready_to_reset(adev);
> +}
> +
>   /**
>    * amdgpu_virt_wait_reset() - wait for reset gpu completed
>    * @adev:	amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 642f1fd287d8..66de5380d9a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
>   	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
>   	int (*req_init_data)(struct amdgpu_device *adev);
>   	int (*reset_gpu)(struct amdgpu_device *adev);
> +	void (*ready_to_reset)(struct amdgpu_device *adev);
>   	int (*wait_reset)(struct amdgpu_device *adev);
>   	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
>   			  u32 data1, u32 data2, u32 data3);
> @@ -345,6 +346,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
> +void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
>   int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
>   int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
>   void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index f4c47492e0cd..3fdd1fc84723 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -249,38 +249,28 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
> +static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> -	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
> -	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
> -
> -	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
> -	 * otherwise the mailbox msg will be ruined/reseted by
> -	 * the VF FLR.
> -	 */
> -	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
> -		return;
> -
> -	down_write(&adev->reset_domain->sem);
> -
> -	amdgpu_virt_fini_data_exchange(adev);
> -
>   	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> +}
>   
> +static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
> +{
> +	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>   	do {
>   		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
> -			goto flr_done;
> -
> +			return 0;
>   		msleep(10);
>   		timeout -= 10;
>   	} while (timeout > 1);
> -
>   	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
> +	return -ETIME;
> +}
>   
> -flr_done:
> -	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
> -	up_write(&adev->reset_domain->sem);
> +static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
> +{
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> +	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> @@ -417,7 +407,8 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
>   	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
>   	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
>   	.reset_gpu = xgpu_ai_request_reset,
> -	.wait_reset = NULL,
> +	.ready_to_reset = xgpu_ai_ready_to_reset,
> +	.wait_reset = xgpu_ai_wait_reset,
>   	.trans_msg = xgpu_ai_mailbox_trans_msg,
>   	.req_init_data  = xgpu_ai_request_init_data,
>   	.ras_poison_handler = xgpu_ai_ras_poison_handler,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 37b49a5ed2a1..cd6ec1afff2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -282,38 +282,28 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
> +static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> -	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
> -	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
> -
> -	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
> -	 * otherwise the mailbox msg will be ruined/reseted by
> -	 * the VF FLR.
> -	 */
> -	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
> -		return;
> -
> -	down_write(&adev->reset_domain->sem);
> -
> -	amdgpu_virt_fini_data_exchange(adev);
> -
>   	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> +}
>   
> +static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
> +{
> +	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>   	do {
>   		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
> -			goto flr_done;
> -
> +			return 0;
>   		msleep(10);
>   		timeout -= 10;
>   	} while (timeout > 1);
> -
>   	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
> +	return -ETIME;
> +}
>   
> -flr_done:
> -	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
> -	up_write(&adev->reset_domain->sem);
> +static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
> +{
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> +	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> @@ -455,7 +445,8 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>   	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
>   	.req_init_data  = xgpu_nv_request_init_data,
>   	.reset_gpu = xgpu_nv_request_reset,
> -	.wait_reset = NULL,
> +	.ready_to_reset = xgpu_nv_ready_to_reset,
> +	.wait_reset = xgpu_nv_wait_reset,
>   	.trans_msg = xgpu_nv_mailbox_trans_msg,
>   	.ras_poison_handler = xgpu_nv_ras_poison_handler,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 78cd07744ebe..e1d63bed84bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -515,12 +515,6 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   
> -	/* wait until RCV_MSG become 3 */
> -	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
> -		pr_err("failed to receive FLR_CMPL\n");
> -		return;
> -	}
> -
>   	/* Trigger recovery due to world switch failure */
>   	if (amdgpu_device_should_recover_gpu(adev)) {
>   		struct amdgpu_reset_context reset_context;

