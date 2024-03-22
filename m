Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC3CD11BF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 08:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC3710F053;
	Fri, 22 Mar 2024 08:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1Cq4tRa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087EA10F067
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 08:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncjNqyh5I+MkdPTC0ieGVz5o3lFbO7qUqW+dz4MDZVbmzblllqRfZsz2CBdSq5bAMq641aRoZvis38QdfmIeVdHqrY2E4Dr7+56yejxw1+4LCpSDnonPRRKFVA8YV1ChoFuNB/KuNiYRDoUURCasSUnu9bZWmGCP7xPhvhBmKB+l5cxG8UjqHp5Uw7wsa6JI7mg955LS+fkHR8a++MmGal52TuELvxr5JFz6TAafMUfM71K6q3/S7CPyWXufT/C6zNGpqvorJ6sr18lHR/fbxyw8Xh39b7UKRvOHd04apslaxuh0O4wvcUNfgWrSh5WnDU9xImnHaYAzAOzqNX038A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axoh1kAU7zCvuVt0yx7Zrtcp24lINqSUOaWoSHtC18s=;
 b=ObRXPCY0+mPUfUgZ2NtHYGVsh6vOxmz6wkp3Vt+1B+AtFzbzOk09zYlsZiGifKnMdUdbYiS77YtTMypYUw0TlfaWK8RsX0ymv25M/6mWk3JCnRUh0xJ2a9Zhn5g6hi8nriHynTNFrw6IoRioIWpQAGBaZiiAV/mPBSOKI/uC6c1sgunVPJLiC1WMqPaVUF8szYLUs//z0mNXFZmY5IwAE3azhdxtYQKkKhHUuYpu+v7ktBfLuUJvOvudgrns8sQjj+1QY/FZL6k4xmeDxwV3Nd7kiNtmyhCrg0rbc75E8MGy+AUtCFTvX/3yNGA/f3UUBRR45LWC3elKpcwuYV7Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axoh1kAU7zCvuVt0yx7Zrtcp24lINqSUOaWoSHtC18s=;
 b=D1Cq4tRawWkkP1WOYAHI3aM2xTXV9SklSduLDEcwH6ab1MMfWV0g/Pg4D3YHnh4V5JFht9TZzZPwIFNlEujdbyNmDWOJD4iCsG9C8k1kspZImZbni/tP/ND0VnWsQ7eDq4G+MPQODS7YL4qUP9nwP/syoRWJDIDGeGuAngsnaI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 08:04:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 08:04:18 +0000
Message-ID: <17b9783e-c0d6-46c0-8af1-68ff462e07ce@amd.com>
Date: Fri, 22 Mar 2024 13:34:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix truncations in gfx_v11_0_init_microcode()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240322063217.4121194-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240322063217.4121194-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: c91034f3-cf2f-4607-e95d-08dc4a46ac92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKm0z2UIZAIWyeazniGtJDK/S9Go6oe2bA3hvrlCBE0RpP6avlOLGIAcb8eRRChyeIUG6pVDqNdQh1dRWuxwSvlODFVwPP3abuCQRbs4YUm2V9saIqzyQdrwQuMIg0C93QbG2UxlmiiORL/2tdyBOQGWTFFOLc2ijs4jbXzkkq5kmT6Lx9TMVktsccnAT/q45qCcd6Wl/edIxEtgMVeDXOwFd5FYyZgzFW5DkYbsxA2ARZLSQanhQqd8kuxw4hAF88Uqr+C8SojnBqMUtJ/8cxAPLnhn7XHXvgSVk1LU7y7u4RyxFc/Jkhr2eqVzGhTkXdBphXX/5UJd9ihYYNvJBg3V70fkFS09r8JS7G4uAoTEG8gBzUw2QCTuAnjegB8pgfo/Qz2lg9xIVKnmWIcdlCkwhEuSv6f3wxgb58160rzgMXcb8y9OR4qFkF6ZXJHSghP4x4lamPE+BnqqXi/gnVketmmDcYPVmRLRG99wHbXGA3Ma88yxCBIEb07kXABuARwv/VUzizfebkkd8b7SYFOF+bVWgjK4pmsfyPk8bw/EwO39DjMFttRGUfscEMLXxBSo9mlR0nUG8BpIAyOSnbRMMJadaqcQpCkb+nEMRrS3gPRgfJPiI2ZLAiyP1ypL7uV0zCgfHOBAayHcE858mwCcjXy/DXiKtrjg7UPzVaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNoUTA2V3BFdmFQSWxtYkJmcUNlUmpDWnplTUJMQkdHZGxrMit4UUZ2bkVz?=
 =?utf-8?B?WmhuaWNMWTdQQi82QlE0WXUrL2pNSEFzL3V3RldMUXZzeTZEUk5TQ013bmlX?=
 =?utf-8?B?Zkt4UTVyNXBYNkNqbnZ5MWR5RkJaL1p6K1F3RzdtQVV1anY5WUFqZHAxVDk3?=
 =?utf-8?B?M0VnTXkzOGZwbEU3cURoSGpiYW9FRDlpWG5yV1dsMS9qSzRyUFpLVDBhTDM5?=
 =?utf-8?B?ZWFHaUpzYjdXUkNpYkE3d0FacVlvZVRURnJhREtjOENQRkJrSFhSdk01SERZ?=
 =?utf-8?B?VWdMWndkdkNIY0ZxQWJOaEFuWDIxRWhaNTN5ZE9FL2VEcGcrK3p5YmNWUWJs?=
 =?utf-8?B?eXRjWnJuMFlSeFBzVEFNK2xsQnl5UEJrT21QdkkrYWVqamFHUk9McFg5bU8v?=
 =?utf-8?B?WnlySkZaRzQwQXM0UzU0a1pUemgvSXVHQXFPc2kzbml2SGdhRld1VUFTSW5v?=
 =?utf-8?B?cEkwSnZ1WnJtcmxvcE5aZTFSTk4wSW0ybEpvcVVJRWtyUjY3NDhQY21UVHJG?=
 =?utf-8?B?bEhlNkoydG5BT09tVWN1ZjZ1cG8vMDlPSkk5OTRPYmo0QWZsZk4yL0trYk42?=
 =?utf-8?B?WGFNcWg3SCt6cUVaSDZjZmFGVHRVV2pCeHVPemFvWEFnR29wUEs4WFQ0aVA1?=
 =?utf-8?B?eXJTVk5iUlNyMGNOb1dVUjd4VmtLRUJLTGxMS2ZnbW5BR0puWGQyYUhHdDVD?=
 =?utf-8?B?RTVsYkJaeHErVlNOU1pjZ3kremhUcWNza0F1a0w3QWdiTmVMZU0wZDU2TUc1?=
 =?utf-8?B?ODh2WGs0VlBVNGIrK3lCZ2NONUxSQ2h4S1R5TCs1SmVXNDBWV2RaVXlFWmdK?=
 =?utf-8?B?QTh0c2pjMkJrUG16aWF1L2wyYllGQlNPeURwZFdEMnlYdXVPV2dld2p5V21E?=
 =?utf-8?B?dHJxbW1qYW1lYlpZU0hGZ1grWU9uU0ZHL0laaU1TV3JBa3VKREpWZXdYa055?=
 =?utf-8?B?ZEZRN1p4ODZBb3pjVFlPdWtFejF5Z1RSZnhXRTZFdTRXanpHU2hKT0NlUFli?=
 =?utf-8?B?bDFGUVltQXlwUjh6eTFBbzlzd3ZGZWJyaWtKTDJRZ3E1cFIyYittVDh6eUwr?=
 =?utf-8?B?cnRXTG4vRHZNNGFvMVliTkgxRTFDQjh5NVNVUXdSWlo0djMrTDIzckJHaTg1?=
 =?utf-8?B?a1JxQ0I4UHpldk5idGlBMEI2UmxVVHBkL0tIZTNjZ216VWRJVHZKOEtQQzNY?=
 =?utf-8?B?SEtlRHIxd0dxRW5VV3VmRXZMdHJ0aDFoSFFCNVVkRjE1YlF5Wi8raDZoSTIv?=
 =?utf-8?B?QjRma0ZkN1lkZzVIUWIzSFdDdXIwekVqK1JyVjdjR3ZSL2NYUHZEdEpRZ014?=
 =?utf-8?B?SWVaMTNqdUE2dllCV1NHN0ZicWMzQUpIR1o1Zk9SbUdzVVRyMWMrT1NPZm5n?=
 =?utf-8?B?SE4ycGJmOStaOHpjOTArNmxkSE5DRHRORGhSdUNBMTdKdUdPQXRqOUZrVDRE?=
 =?utf-8?B?TTROa0lQQnFvNWhzMWNGWkp3a1hKWWx5eW9OTVZsWm9kNk9VSlZVd0xsRzhC?=
 =?utf-8?B?S3QyMUltZmdZRkJYNm5zMXlEbWZuYXo3enZnWXR2azVJVk94UnBwQ0Y2ZCs5?=
 =?utf-8?B?bUQyL0lDeHhMdW05UnoxTjFIZ0ovT2tnVjBRcGV6T0xjOHZjTXNUMGUzMjFr?=
 =?utf-8?B?Mk84QXN1V3hKWk5iMUE1KzBWc0dWQ0VOWjVCajlmQXIvNk9XTnZXSTVlckhz?=
 =?utf-8?B?UW5KUkRsN0IxKytzeVNmNDY2UXd1clYvblE5V0orK2UwZkcrL0J6Q3lpSmdw?=
 =?utf-8?B?NlEyNkx6YTEybTE2S3grTlFFMGVNOWU5TndQUUFHM1FNZEowZDNBZG1zQlRa?=
 =?utf-8?B?QllKZDhDWlRNVDFsT25ob0szMDk4cjAyZFV5VkdWWEJkbjRjUU0yMGJmcFVy?=
 =?utf-8?B?V1JwR1AwRS9sMDNROXhTS3RUaW9Oc2RrTkR2QnBjZ096N3A4OVBvTVlSZm5i?=
 =?utf-8?B?dnU3N2R5a2FyU1Yxcmh0NHp5MFNQZThxNzBDeUNZUnMrMlpKR3NSQlFXcG8v?=
 =?utf-8?B?U3UrYWlLQ0ZYaEJBT296NXZubXp1bCtTZjEvRDBUK242aEY4QTdrNFA5N1dH?=
 =?utf-8?B?cUUvdGxaOTZER3FJQnZ5M3hzUEYvUitveUk5aHhJenpIVmJPdGdIVlA2YXJE?=
 =?utf-8?Q?JEcHqHuBNpyFbjLNMt1K2U5f3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91034f3-cf2f-4607-e95d-08dc4a46ac92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:04:18.6873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H73nbf/3g8d02K/iH9o2N1ZLISOlPAvQWXapRcvsNgRK/FI/Kr8k6awSRHCMY0p7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
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



On 3/22/2024 12:02 PM, Srinivasan Shanmugam wrote:
> Reducing the size of ucode_prefix to 25 in the gfx_v11_0_init_microcode
> function. This would ensure that the total number of characters being
> written into fw_name does not exceed its size of 40.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function ‘gfx_v11_0_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   523 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
>       |                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   523 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   540 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
>       |                                                      ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 40
>   540 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:70: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   557 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:25: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   557 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   569 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
>       |                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   569 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_clockpowergating.o
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1770e496c1b7..7a906318e451 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -510,7 +510,7 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
>  static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  {
>  	char fw_name[40];
> -	char ucode_prefix[30];
> +	char ucode_prefix[25];
>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
>  	uint16_t version_major;
