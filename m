Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC0CA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B9610E4B6;
	Wed, 13 Aug 2025 05:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ofeag0Du";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D46D10E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik0/iXDl1kU9XimcXIQ4ryn0g1WNm121+dh1emws9YpQBauMyTHnW211GGaNeaqVSuCop/nuoECaKzDyM+FeoOzLbJpO8cpCAcUFBHlIbGdvlBNUQI89KCG+Xuv1UELXSivngT0uWu7AksuQxlti4QMCVe7FeorRFMl0Cvo2mde9oHNqJP3FbHY6hvkATK1UmohN9ilMjzx5tqdrkT6F6sDdRZupZCdBM1ZGhDFEtneJSjzk9koBUZ6+v5v3079Myx8m1690ROMc3r2U2CFwCKDd+yDhbBgdidV3tzvz6ZYXBfmnT4GDFUTH93XgzvO44x/UWNHOvFk7r64zvcZDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ryONnzssX7oV3WUqrALugyTtoxIctt10q2Ib+Oa+90=;
 b=EihM3Iq725aJpDPCsoc1EGE6IIuLEWFLW2gbgwEN7tq8psLPfuhodypw09spJWbt3/GdR1xTwEKYI7zyBzof8IJEH0makFaGpbkXcokqwg9HYQMFyIP3Mtxu8HzwDeDWLNGNp1vqCqiel9v5YDzw+pW+CeLx7qCAufyAh/I+91TeJPgyf2zLr1PV1B2tvFIgHJrsVnDBMafuhXVPIEV3oVe5tG5zmJnPs5z3Adm6K4HDrwMUE3RhqfHUo5GWFqioq+VGW43dda+eUw13WBWrOf9BKqJymq0Ld1/5mZxMJDXjg37+XSy6CxMvO9B4OzlVB3ao5v4VpxaTA+kvFc889Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ryONnzssX7oV3WUqrALugyTtoxIctt10q2Ib+Oa+90=;
 b=Ofeag0DunA+4Q0qnBQqlbXUoEtFAehWowWNB2gtUa5dRE2Z+CAHEbYEcczVi6GCogEkC3t0HDcRQI5ptCTOPjylo1HxkkZnmTyM6igIrG+N4TYc+FSh+Ov9uNbqEE0inew3O2aLodQ6Icrcc94AtQ1VtZp5ut7hYR4Yz+LNCLuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 05:06:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:06:56 +0000
Message-ID: <d04d29fb-c017-4a7f-bf46-6f9361413347@amd.com>
Date: Wed, 13 Aug 2025 10:36:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 3/3] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
 <20250813040851.3435890-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250813040851.3435890-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dad676c-9da8-48cd-e3a0-08ddda27399e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVlEUnQyK05WdmV0cXB6QTNCeEJEYkh4VlFub2FOQWxIWmxuY1dZWlFKQjJs?=
 =?utf-8?B?S1JHckNnbkw4SlArNGt6dGV4OFpHVXFtV1ZuRkdZVzBjUDVya3NrRE84M2JT?=
 =?utf-8?B?NWhSdmxVRmYxbXFRaCtoakg3WnB2a0N5ZjExaFpORnlLbHdoaWVsd1R0M3J0?=
 =?utf-8?B?b2c2amh0cFgxTm9oU3B2cnlwNCt1K2Q4dUwrNW9FU0tGV0VpdkRiWWNUY0pK?=
 =?utf-8?B?ZlYyZkIzL0NVU210bjl4ZU1aN0lTV0tlZ2psV1pDQzJ0d2dWTEZhR0xoamRV?=
 =?utf-8?B?TXZnb3piWHFPRzduWkh2a2hXSStKUEpINjhOY25xNmZ5SFdiZmtyanpFdVJW?=
 =?utf-8?B?YVlQdmtBWTdqcDdSV0l3eXdTVXNLM0xIZWNBaDBtMUs4ZmE3NUwzdFRvTU8x?=
 =?utf-8?B?Wk1NcitCa0dIMUxlbGJsdUJEcVkwQk5UeXRaZGQ5VExMdkxCMUdtWGgxYTFi?=
 =?utf-8?B?Q09Fd28vR0c0SUVZdGxrWGRnTVBMcXZzSnZwNDdPRFAyenhVQU1TWklpTkNJ?=
 =?utf-8?B?MDAxL2JKOFlGMDVXU2szSG1DTm1QZnJrN3pjVlNUMUZ3VWN4bktjdkx1OElm?=
 =?utf-8?B?UGNKb0xNTEw4dU5zd1RxN1RVaXFqVXBlRU5QbVFYMklHL3hVekJ1VkJ6SEpn?=
 =?utf-8?B?T0wrVjZEczVJWUo2TUxudzFUbHBIUWNhSlpNMk5RSFNkMUZUOHI5VTdPdERV?=
 =?utf-8?B?Vlc0T3Z2Z0luRVZKWmVXRWZtSVN3bmR4cFZHMm40eEprYzhXYU53T2tGQnps?=
 =?utf-8?B?bCtid1pwZHFIb1FBMVBJY2dxRXUvS3RNV2FVRks5alU3TzBpdStxVVZkNkJH?=
 =?utf-8?B?VjlwaCtxKzBtaE45bExmTlIvTWdmdUVCZGUxd2Y3MFRHQVQrRCtSOGdBT3BZ?=
 =?utf-8?B?RnNIRU5FRWNpQ2ovdE4zQUtaakVPWk4wMHNUcWFERFJjaHY4b2tBOHAzbDdz?=
 =?utf-8?B?OW1sK3NyYXBicGl4SzdLVzc1MnJ3aXFCaWdFZUdGbk5iQ3dhZmNBM3gxQ3gv?=
 =?utf-8?B?YTk0eVNSUkNsRGFUN2EwUm5wTlhPK0xXS25lRWlEWWFJVVRsVURWai9Ldjd4?=
 =?utf-8?B?M25PZUprMmRwM2ZhREQrc3J1ZUt0K3dZM3o3andCa2R0a0ZENmovTmFhOFVW?=
 =?utf-8?B?VmxUWGgxOGNQZUZVU2xaY0paUU03ZnNjR0pJRGQ5Z1ZjREJEQU9lUFRZK2I3?=
 =?utf-8?B?SGF5dVRmeEZnNVJFRTFDQmxGenhhWHBUWWpzVDJZa2U4Z3NRdiswamI2S3Ix?=
 =?utf-8?B?RXBwb2VJSjN3SjVrMlkyT3lIYmNyL2tFbXVpTWd6UlR0K09lcFUyZnRqT1JN?=
 =?utf-8?B?M3hWcDNHcU9Xd2xsQ3ZHekdWUjUwNGRIcDc1MWJ4N0o4ejc1ZlRVMlFJR3k4?=
 =?utf-8?B?eDdCcDBYTnNwYnoyT1RnVlNKcDdKd2JCMnVXVXNMTkYyeVBNOTFucXZFT0NC?=
 =?utf-8?B?bzNwREM3VEZGVFdRVGs1Z3Y0K0ppWGFJQU82RUJlc0tiZHBqaUVmNWU4QkVP?=
 =?utf-8?B?aDR3aStieXhkd0ZlNWY2OHY5bzJma2dDVlN5M011YVZ5UHpDVDF3NlBYbElr?=
 =?utf-8?B?Z0tMaEFaQlY0bGRKZFVXaEs5NENoRWVLYlpTWjgvNDBWYjFiY0ppdDQvYi9u?=
 =?utf-8?B?NHZoeDFBL21rZzkwaXdBd2JrSG44MXJYTnFIbEZzQ1gxZU9IK2VPcElaQkpm?=
 =?utf-8?B?WlJLNkdEMTNvMWMrYTNGVXlKdEExb1ZwQ1dDL1dnRVNKdTgvMHJhdm0zMTMy?=
 =?utf-8?B?a2hnUjRQT0o5L05iTmFXRVh0YzF2T0V4R2hUR0pwbHJXUUxqUGRqMFlOZ3NN?=
 =?utf-8?B?Zy9BejBLYTd1MWoxamRDayt4ejZDZUZaVnBINXFxSFNqOEZmaGc5QWpGWkJL?=
 =?utf-8?B?YkRwNDY3Y213V3RhWlh6Qk15dk1NbGd6b0pmQXBqS2N1V29tSnFnQjFqNlR2?=
 =?utf-8?Q?zPUmnRgV1Rg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm55QzlkbjRBNkhlbHFFU1ZZcmdnQk5KTGplT0tEdUxPRmhUdWxlYi9ENU5O?=
 =?utf-8?B?WTF5YmQvMGZSbWdmYU5kaEFWdm9kSXRtSndkUVhxdFlxMWxwT1d4OEgxcDRE?=
 =?utf-8?B?K1VNdWZBTDYrM0xPVUlXNytCWHRlbjNuOGRHZFNaMGEwWXJwSXFSMkMvZnoz?=
 =?utf-8?B?cm5NRUNBTnc3OFJZT3lRaXNYQnE5cmU1ekJIa1E1WXc4b0VHS3ZRQTNlK3Ba?=
 =?utf-8?B?WmdvZmtyL3M5b0NYZHZNZ2xUMU1uV1BxRVBtZitkTFh0VDluWU5QYk5Wc3hQ?=
 =?utf-8?B?dHEzNzhHZEVVUDB5SXdZcUVqN1dYOFlDNXZKRFZRbHl4YWRUakozWCtsUlBx?=
 =?utf-8?B?MUF6Rk9rRHhZVVV6ZTVKMzkxZGlNQnlhQXE1SHh0VGhEcnJBczlqUUlmT2hG?=
 =?utf-8?B?OTdIY1l6T0VEZDhyZmZOaTQySVJjWUt3RUFKSE5iTmNXYmwxcWJMT1BLMkVw?=
 =?utf-8?B?RW9WUFV3Sm0rWERVdGV4UkZHWktabDdhNEJmbHB6U0dUWUIrS0dGYjF3ZWRV?=
 =?utf-8?B?SUl5MjFWUlVHaE1KSk90M2NMUHNsT3AwZWxVWFFxRGZ6RmlDbFgwMk9zVmVH?=
 =?utf-8?B?cFJZU0hTSnFNTEx5Wk8xcUFYOTd0UlJOdWZ6amFCb0NBKzk5OHdjNXN6ZThw?=
 =?utf-8?B?M1FHWUVjZkp2VFFYenFBbGtESXdGeExqbGZmTDBZMTRYcE1lWWVpQUc5a2Y3?=
 =?utf-8?B?dG9HZm9BQUxwbHB2T2lRV3NoZmtyQkU3cVh4bVBEczB2cHJCSnNkSUMrRkZv?=
 =?utf-8?B?dGdNWlI1ZVNudDBJZlF0U2oyWUdNUFg5dVF3cWJKcGYzVEM4RkJ1TmtZSDlk?=
 =?utf-8?B?c1NPYmpWTkhwdkthWlZoclFvTTFJVmR6ajgrLzBLc1U0NGRoOENBa2U2eEJk?=
 =?utf-8?B?S1V1L0lwUHRlY2M5VXBwaUd0T0NvN2ZrWDNsNmgwYVRxTWlUWnFjczNIZEda?=
 =?utf-8?B?TTY4b3pXS21acnFKOTFrc01ySzgwdS9tZk54SXpIeS9uUUJNMXVIWjVsSVFm?=
 =?utf-8?B?Q01OTXk3cGNvNlBXc21nUjB0cHFyNlI1dkE1bTk2QmpjcWJ6Vk5YWlNYTDRy?=
 =?utf-8?B?c2t6dGVFYnMzUWxSODYrSkROWHM0TTk3WFNpY0Y4b1lMeGVNcW5NbXF3ZG1S?=
 =?utf-8?B?L3RqeVVEb3dSY1pIUlQwcS9OL3hqQWdOdjBTeXg0cEdWdFlUZURBWnFGLzhH?=
 =?utf-8?B?WlBkdlFZLzlOeWVReGpPVTRQYmhIamJOMC83T2c0Sk9mbzZaZ0VydE0rV1V1?=
 =?utf-8?B?ZWZTTTliTjg2UWw3TUdxUFpDUm5mUUVYelg0ZmRkR0NOT205c1hKc3k4cTlB?=
 =?utf-8?B?NVJmWVVmYjZRV3RaaktmWExPSmtEOHAvWnNJdFRKVlRvK25FZW42SXhxYXo5?=
 =?utf-8?B?Z2doM25yMjY1SFB3V3B6bXF0VTE3d0I4Nm92WkdqRGxUMGFBQ21MVGxJS3h2?=
 =?utf-8?B?OWpkajRjYkhxM2I0aEZQdjVON05BVi90VnhFQlJnYStka3czRnNmbXlnaHAx?=
 =?utf-8?B?UzJMSUhtME1wSVlxUE5LSjNKdVBqSzVUZ3Y5NWRkRVJvZEhKek4xT1l6bVow?=
 =?utf-8?B?clRkUFQveVoxbmd0b1dJYmNPRGtEam1EUkhKOTVJdEhIemMyM29DczFrZWJG?=
 =?utf-8?B?OUQrQzdsSDQxRmMzTHVhUHkwZlhCSmptVUlQY1FEZ2YyTVZXc1VoemlVZ211?=
 =?utf-8?B?cEdSOEQ0Tzl4NkR2dmFCUGN2ME9mN1YrQlpUSmp4dWYyb216ZzVnVWxSdVB2?=
 =?utf-8?B?NzNYZks0ejRiU3NYazhSVndZMW1CSFVTc3VpNlE5ZGtSWUN3YXNzUVpwT0pQ?=
 =?utf-8?B?b0FYUlErMGNLYzZGN1lhOVc1Q29ldVc1UWdpaGdLZkJZTlJLTjFpVGNtZ0pq?=
 =?utf-8?B?emRqSzVBUkZnOHdNMFhtbTFMeVBZMUlybFhzR2txV0pCUCs4TjBWbmpXbGJB?=
 =?utf-8?B?cmFlcjBKa1o0S3FLcU5vcjM5WHZMU3ZTYnlZTTVHM0xVQThHUzlFd0NPdFZr?=
 =?utf-8?B?dWRzVXdPNnpvOTdybFFra1JtVjkxL2JsR1FteXdOcnpkUXk1UWU0bGJRbU51?=
 =?utf-8?B?bHhBc0tyYWV4Ry9DRElMaWJyY2k1VG9WUnNIbW5obDZyckJRZmtzT044bXcv?=
 =?utf-8?Q?dGiCm8+9dA68zUBPay3OAOuz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad676c-9da8-48cd-e3a0-08ddda27399e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:06:56.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vUM71/aQRwzoyUDYm1jvOF7bqFLip7/TVJZ+Y9XsS7JiFM3SQvejFQS0uBOeGCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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



On 8/13/2025 9:38 AM, Jesse.Zhang wrote:
> This change reorganizes VCN reset capability detection by:
> 
> 1. Moving reset mask configuration from sw_init to new late_init phase
> 2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
> 3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
> 4. Removing TODO comment now that queue reset support is implemented
> 
> V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
>     and remove TODO comment. (Alex)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 019bd362edb2..03fcd6833c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +

Looks like you missed my earlier comment. It's simpler to maintain if we
set the flags at one place (all in late_init).

adev->vcn.supported_reset =
  		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
	if (amdgpu_dpm_reset_vcn_is_supported(adev))
		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;

Thanks,
Lijo

> +	return 0;
> +}
> +
>  static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>  {
>  	struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->vcn.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>  
> @@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>  	.name = "vcn_v4_0_3",
>  	.early_init = vcn_v4_0_3_early_init,
> +	.late_init = vcn_v4_0_3_late_init,
>  	.sw_init = vcn_v4_0_3_sw_init,
>  	.sw_fini = vcn_v4_0_3_sw_fini,
>  	.hw_init = vcn_v4_0_3_hw_init,

