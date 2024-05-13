Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D53C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 12:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8557F10E0D2;
	Mon, 13 May 2024 12:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZh2vdIr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87BC10E0D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 12:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEZlTjMck1XKj0XPHTVucEEmwoDf9VmYCEDw1YmHlKbBAAJePOYF+UwKJaFldOmvrmH8RHWOApHRl/Wz1BCBlzbC18hAVTYO11H6QryQm+XwcxYs+opvwY3u0isrf2/9YpkRh1ETYJknVbmWqIvgys5ultTIQI97vPtF2zl5Mx7IXqqlQ8M4082DlJf8tW24nCx+cIphhHcHzW1Vv2H5ueR3P1GDHsPDAh5TlD2qRv1BVDXsiDBvjHlXnyku6fI7z/J22avuR9Um2IS6azr6VzPf8OPN3DPR41A16qNGWCS27Ypt8TfclsO2RP0wsG+4KW85kKRjM014SM1xQWk+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1MOzg4JNKB/xWkAx11LoZZhdh0gkh06b/SVQTDBdg=;
 b=HUcTRamVgKPY7yxscynIkKWyYeBs3Jiva2ZdsYbJ6U9Led4Xvm48NxpW44OpxgvDyJ28kXNe0nACeYlPQr47Mqk6i2+BijqZPKjVJ3+O98qUCGOFL+N4LbpuIkdhp2lwmnqm0wVsA/3PMRLyvWxXVxkvO+86+kOGr+3xlGz9WAGySwspm+3xXWzMEcqUOJQ3yE0nm+l5DmDUHt4VLB41bx17wCv1MiA0oUKwKySl9goiDI6q2JzyGYalIaae8eoM6TTrtFUqzf4tT5mLGCX0JcF1YO1fKvSA7PPPzfabbZXo3hJ6LeAq3syh6xWSQ2wMh8JSCPRxeY5QnBn2kH6iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1MOzg4JNKB/xWkAx11LoZZhdh0gkh06b/SVQTDBdg=;
 b=YZh2vdIrC9/1oTRDLInE3OrNEqQW7mGheBLi6MXFflWiGf7/VAVXMWYJ/6aj5QiBCNfB16VXNCwZ/MjvrGJKv3vqjrJPOpuDkSiKTBbcWRpKIJMvhWHr2VoSg7ERKe7ppHaFEGOy7kehFUBTuSf3c9p3NlaX9bcq2p67qVBzMFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:40:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:40:31 +0000
Message-ID: <a3ba507b-ec23-44d2-9000-eed3c8955c6a@amd.com>
Date: Mon, 13 May 2024 14:40:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Fix null pointer dereference to bo
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-4-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240513085616.584249-4-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b9c828-4039-410a-276b-08dc7349e025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bExGWjRFaCsyZTU2aE4yNFUrK0NZdjRMZFBES0E2c0xKS3VwdnUvbjZDS2ZJ?=
 =?utf-8?B?YmFkQ3lpdHdLWkFyajZIN2pMd2RUcU83SzZ4K2RXYndCZGsyWGNkYnpZSzF5?=
 =?utf-8?B?RExlMHZtaTdnZExZVTNKb1REeld1aCtPYUtqeElHZkFLNEN0SFJGK21WRFV4?=
 =?utf-8?B?blBndkFrM01yUXhPeXp5bG1zS3R4cmdkcEw4UFhzMjViZ1lqdFVyTVRoVVBM?=
 =?utf-8?B?YkQ3VDFNLy9GNEVQUU9Gc2ZxcEpHbUM4VzI0NFlmU2htTDR4OEJNRTBSV20y?=
 =?utf-8?B?U0lZZ2RNbzJwZ0hEVFBLQXVReHhWMUdUSmdQYlR6SVdaK3RNQ1JwUGhEcTU4?=
 =?utf-8?B?azI1bG1kZTQvWmlzYm5sYnJLSWVvNmQ3cHJqRm9hZTJyb2UweG0rbDAyNVF1?=
 =?utf-8?B?MExEK2NRZlgrdkxSOFRaanRGbVozaktRTmMzMWprYTJVZVYyRHJrdTArbW5F?=
 =?utf-8?B?TkFNeTk1MURkSk50NDBDTEg4UGNNRmtvSjlZeEVSSC9PVWxqbWNnTmhpVnN0?=
 =?utf-8?B?ZThjcG9QdkJNSVhJNDFWNDlSMll1YkdqU1NCTHdpSFVETWVnQ0F5Ym9QcmFT?=
 =?utf-8?B?d1c4QzZzQitoVGtHUlA5S2JrZEpRYkNQbWVlSm16aENYQUhCR3hlR1ZIdTR3?=
 =?utf-8?B?ZmppM0dwVmwvTGdGcjJjbUJIMk5iVmNzY1AzL003NG9UOEZJK21UYkdTSlhT?=
 =?utf-8?B?TCtNdXpmY3hvVmpEbkhmelM5VWEyeDVHTjZTb2x1RVBkMXJLYnRtR1o5ZmNs?=
 =?utf-8?B?aWVpNjhZekxsNWYyTVVQRWJHZFpyV2VSdDdXbW5kTE9lL3FMUlBLTEhqQUQ1?=
 =?utf-8?B?Unc5eExvdDh0S2ZpNTFKMFlCRVNIUDFXdTN2TjRnd1ZtOHRNdE5wU043Mjk2?=
 =?utf-8?B?ZHJzRWU5Ylc5UUZFTURKa2tQZWl2eXVlNzNyU3V5UW03TG5mM0JMTFFqRDcv?=
 =?utf-8?B?akI3UmJ4ZGg0VXFTUmR0bzVXSlhianVjbzM2Yzdrb0JRTDh3ZWY2MHFvUDMw?=
 =?utf-8?B?bkIyREMreVJubjFmbk9DTnJROFhIcGVLOGtzYjJHWUFyemNZZks5SFJycXlQ?=
 =?utf-8?B?aW5SZUZWTDFZVFlreVRqd1pXSVRnMHRKZ2FPaXh3QURVbkVBSFlsSGUxb2FN?=
 =?utf-8?B?azJGL3Q2S1JFcWlyOGZGSTNXRlF3OExXY2psWGErcVlhb3QxZkpQYW9qMFVr?=
 =?utf-8?B?cVl4c3gwTW8zWDdWOTJlL3BZNmp2Yk9GV3NQQlZRSHZObXpocy82V2IyQVlh?=
 =?utf-8?B?ZWtoVGs5SHIxRWlHUkE0cDhNdXNMeGZGbENkZENCQ0ZOQVdsbVl5bUpETnpu?=
 =?utf-8?B?Y2VlRmxReWdSUmFOajgvQS9HYTdIeitsTHVVS2hFSkRxdmdkeXNiMFVxQzg2?=
 =?utf-8?B?UnRHWU5wb01XcHRSWTlhNkxmMXJyVUtVZWFBU0ozWndhQ1B6V0c1TG83NE85?=
 =?utf-8?B?ck1FV1ZjM1VZYWN2SjJsY0NBY1NVTVNlaTN0M0JIN2ozRUg3clJaK2ZEVi9Q?=
 =?utf-8?B?N2F6djh4eFVnZzB3YS9MU2Uzc1VEYWVmTFJib3JiTU1rWUJzcldVRU9CQUNj?=
 =?utf-8?B?TjVYWnJMUktpZ2N0eTh6NTZtZW5teitHVTRwWEhaMHFLZHAyaUxGRGg4SGs0?=
 =?utf-8?B?Z1Y4Nlo2WEhhNU1yaGtZMmhKRGdBa1cyeCt4c045ZE5Zdk9RblZwemRuYjB6?=
 =?utf-8?B?L0o2Z0VmS3NMTWdsV1MzMWo1bG5nTEVSTEJOWFFJSVM3emZEN1MyVldRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdLSUw4aWpJM09ReUlPMU9VeE5SNWxqVGpmU3NmOEpNU1pCNzljUzR1K2p4?=
 =?utf-8?B?cFhIRFRkRGRseFJFVVI2T2dmSGVHZUtaa0M2YTJwbmQ4d2tNcjI2ZWNvUERv?=
 =?utf-8?B?TVJvUys2dmp0SjV5eGd1bXpUaWF0YTdCalRLbDI4V0VvVEVXRlQ5UHBQK2JF?=
 =?utf-8?B?MG0vR0poQTZHR0ttVTRIeTR0VFl5UlY4RllLVHJiZlhtdzljM1YrU3RUampH?=
 =?utf-8?B?UXZ4MG43ekpqdno0SERoNnBEWXN2aWtEUVhYb0taY295dEszS0NLRjBvYnYz?=
 =?utf-8?B?ZkMwbFRmSE5RdUVXSWZlc0FtSmtRaEVSM21VTklPaGF0V2g2WmpTVnNxZXBE?=
 =?utf-8?B?LzNHK1k2OGxHRTJ2VTZISExwc2RDVUd2d0F3RkZVeVlONWdqTmtKbkVkSlpq?=
 =?utf-8?B?VDJ4K0hKbk1mOGg3bTBHQkR0eDhZUlZEbThlNnVUbUZteERMczdYZFNnWkN3?=
 =?utf-8?B?V3JQdTNyWlp5SzhnazkxM0FWMERnQmhRRk14V0NwVnQwQ3pnMkFxZ3pENW5X?=
 =?utf-8?B?eWJtbzJkWUlkWmVJYmRjS0M1eVp0WVVLRzQ1OGVNQWU0b3dZK2huaUJrQVNT?=
 =?utf-8?B?RlpseUFEeTFNYy90NXZJcmd0VUxHUUxnWUdKY2F6YzZaRGJVNmFJSkppV3g0?=
 =?utf-8?B?S1RYaFZVcHJXdUZqK0dPUUZFWmdvUytIa3lqTHdkUCtHdzhrYnB0bTgzNHVF?=
 =?utf-8?B?YTIvNkdwNStjdXVBQVUya1hFSW41TytNRVpVY0pDdVMraXB4dXUxQk1MQmEz?=
 =?utf-8?B?N1ZWWERRL1VvRHdQbit5LzRMKzBXM1NUdmlUY3BJQjRpRU5jQkJFZjBTZDIz?=
 =?utf-8?B?WGxGbm9BME4rZmhVdGREVDBRY0xOSzhoZUhzeVVCMWVxYytrS2xyaEpBREVz?=
 =?utf-8?B?MFdiYlFpNnR3Uk9Zay9JR3EzMGQxakRqS0NPa2FOdW1RZUZTay9XNW1KMHZZ?=
 =?utf-8?B?Nm5Cb3BkaUR3V3FpV2Z1QmJhT0V3VG9Bd2hXYnd5UGpZSmw3Y0ptYkswVUQv?=
 =?utf-8?B?enMwV3h4SEQwVlB5cU1KS1RQOHVLSzNwa1lFTTlJSUhGTnIwV05Id3Y3NHJT?=
 =?utf-8?B?bjZ4a1krSTlpU3k3Zm1xSUI3a3V6eWlPRERMc2Z0ZHJrWnpoeFRVM2Jtdm14?=
 =?utf-8?B?dmhOSmNoL1htaThmd3RRdkVjK0NyUzRsQ3d4dXo0M2J5L3dDUTFrcm82ekY1?=
 =?utf-8?B?ZlNNQ1hVOCswd0REZmorQnZOQWZHMlRjZVNRM3doUUM1a2NQUzFKZ1RXZnFC?=
 =?utf-8?B?SnVuZTQyKzY3cVNMcmdIL0JuQlViRXhmU2h1NFNrZVUxTnJDalozYWxCT2ZV?=
 =?utf-8?B?YjQ3Wmp2NjJiVkIxTDM2eWJtNC9XN0hGdmt1eDNwVU5rTDdXdEpLdGJPT2dG?=
 =?utf-8?B?MUt3RzM0TUtVM29xNG9DWUNrSVNQcyt4SkVlYXVkZTVlcEtYUi9FSUNxbm1x?=
 =?utf-8?B?QU5EYlFXT2hFSzJTMDU3YXhUTnpMdkFQejZxQkZEQWh1cGxmMTJBWWNCRnEy?=
 =?utf-8?B?cmlMaFp1WWVhZ0ZJR3hxY0VPaFZVa0YrbFBHeWdvZjhUU3AvamhObWZHY280?=
 =?utf-8?B?dzZmSmV5VjlrdmFoNVA3VVYxZkNQRDdha21mR2p2b1g0YlpUczJXeDRYb1RH?=
 =?utf-8?B?bk4zcDlQdHNRaUYrM0owK2RMM1JadHBXaU1zeE1XL1d5ak5BdDdCTzh6QzVw?=
 =?utf-8?B?YzNqWDFDeVFBYmVTWStDZDNGQmdidnBZMHQ3WHBKSjFvcVNLTzRWNWpuVjNY?=
 =?utf-8?B?ODhkY0RKbkN5MFVOZnlLQXg4REVCWEFWM09YUXNWcWY4a3FOaTdKL1NCSWdx?=
 =?utf-8?B?NnM4STdpVWw3ODdZVEhpR0lhdVlNdzlhSGI0MGkzQUhvSk9vdGpJSFBESHZp?=
 =?utf-8?B?bzNtMkU0YnVyQmZJVjFVV3VFTld0alJXeUVZN1czR3BrakgzQitORFZ6SGFj?=
 =?utf-8?B?N1NWVWhIbWxhMDRuV28zNkRRM3FUMURpRjByWWlBM1pZenBtWGdIa2Iva2k0?=
 =?utf-8?B?YTNSWlh3TW1menY3V0hRS3BtTUxuWjdJQndWeVFiVk90SjFBemFpY0lsYVF0?=
 =?utf-8?B?RmpqWmRxQUZuMVhDN3UxS1A3UGNERHpvUFFrUGJQMjdNOUhISnpGK3RURGt1?=
 =?utf-8?Q?aqgo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9c828-4039-410a-276b-08dc7349e025
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 12:40:31.2629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L33df1GrdjWrihrSN05RJ0yXCYMZGZbPolu77bpU8egAZ0RaFsYSaLZsVXyvFX8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

Am 13.05.24 um 10:56 schrieb Ma Jun:
> Check bo before using it
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 2b7b67916c1d..8269fd6828bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -497,9 +497,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>   				 uint64_t *flags)
>   {
>   	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
> +	struct amdgpu_device *bo_adev;
> +	bool coherent, is_system;
>   
>   
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> @@ -515,13 +514,20 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
> -	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +	if (!bo)
> +		return;
> +
> +	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
>   			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
>   
> +	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +	is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
> +
>   	/* WA for HW bug */
> -	if ((bo && is_system) || ((bo_adev != adev) && coherent))
> +	if (is_system || ((bo_adev != adev) && coherent))
>   		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
>   
>   }

