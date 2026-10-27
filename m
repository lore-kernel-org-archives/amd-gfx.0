Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13474606A324
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lnen3W//
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B4410F5EE;
	Tue, 27 Oct 2026 14:42:37 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050710F5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbMEAD7BuJebX4z2cS6fFGHsBotdWWWPvMGnCd8LyPIkSqYD3LRAWQMND1yGRatUhVYPljB4QGDe1VUj/9BDbl49Spx/pDo0SJpxyYKH0GtVtDjvMRl0vyGwbU7d4R3kwz7sjGRQszOZMg10qIASvVmRIMWD9gES8O4jPaU93ME7FfUk+vSXu9/Hz3CmjbNWVdCDgfQjcbK0SeE37iuaoFmOOj7/9kf1Bt3RYqummyrhcYPS6yGhe3QJdX5COcPxyWWKEk7QPjbMCHTHGPMWKQMYCxD8ar0edNFKg6rF9SmOGwrQ1XaoEXjQtoURc5khXb3nmAwZaqTfYXNfy4ohkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xkcNwh8MyfhOm00vw1xqDKfwLWW4fPDqWbzj1betEw=;
 b=SPJKnPye3xvETAcj112VN396pM4jY90NG65zhzYHpjAOJKOkGKX37TdsX5rtriIXF/fbfy1ssBGY8eimzQZY/qS1zBV5dlWaHnd7YwI8IHOHeoG2F7gGGNMYC7htEzSkAgxLXg+Eu6X2P26rHO3xSnNzFhGR/XQ4nK0SEDFA+rG6C8DZuyobuWkkv/ejEgsHct/0MyM0rFvssxKStI4MM3IibkLmsTT7ZWF4dviAFfhdFf8arNvM/9Vf5+q9pqFFqv0uZwWBy2MGg7MMFvo1fD7bLEvIwcb1kv+u45tV4zuhrN5/3VSH/QJq9ly6fQ3g/iY+zDrCXAF3ZsG6dKPjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xkcNwh8MyfhOm00vw1xqDKfwLWW4fPDqWbzj1betEw=;
 b=lnen3W//1JzbIVcg0qGFSLO1T5dTpR6gaB8gnfn0sJQpXt8z4P2JEdOt20el0Z4kYcCKB9ZvqPJ8ymb9pEFVWFU0/aXMfI7EwBgxRZt3ZIrtUAkA6oKSfe9WJlRXWvvroXGUjzB3QcJigaBwWOcziis0Qni+YBwa9Qwi8t99Jx8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:42:28 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:42:27 +0000
Message-ID: <8cf04fd4-e539-45bb-b17d-ef8f2f1125e6@amd.com>
Date: Tue, 27 Oct 2026 10:42:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Bump version for allowing jpeg type 4
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 David Rosca <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
 <20261023132447.1036020-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261023132447.1036020-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::18) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: ae86fc29-7328-479e-8140-08df343885ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: m6JsfppRMYUU5otWMHusIuc4xJHdlQBSO3OnH46p76eeVXw5Bp3i2UTI7TJj22yoHwpS5QkEooP50BbK+G7S6m+HkrT6pyzgPloejfYPikh4vxyRN8rJw7ZisZNWGcxVzYeOQoUBI4ege0eUv0vVjD9k+7cEQgmerhNnXBl/CzKh0s6vscH0t9NMh+/8h0d1Av1i3DwEekMcFDMLnoPDdDuVxTkrXv71MrLAMYGtugiJRxpAST3tmfW9hysNyQGRKtsmM/tjf7nbrjJOdrHpS8oqJBsIIW6xPh9HMCagZtQsjarp2EaGE+uoAWewG0PkEJlE1FNc/kMFPQLKXs1Fl6tqv8Lgd+snNmkilB5Yxariy9dv6qxXtmnn4Mkbt/hqbwW6eqLFQpHNhoeWU0DiRWJhf+p4GssUuEeM0SGhND2EQiNr3Z/cT7RNQZIlJtopu4P00ZKvP2q0zQAe9ykXThNQ01Ym7moV/tDXRXQKeY+B9lMFbhahZub/PtJ6lxnYb2l4QhiiU629knCUNruZ4DKs/D04EZ9OzjXp2lnDq/7mHLHmUmnR9H87CwtV4aU+laC6/OaRYJDWKTJX5Q1s+X2Si5mSfwowupxUruNMeX/LaS9v5G/DnCnu4XK4Wk1tGxH5TcU/8ZIOqJW3PBAU6LEbpayx/dUqgA8cobWjxkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9EQmQrdE5SV2FBZ01NZkZvU2hNK0EwdHZBUTRCaWdQQ09RUWFaVFd2eGpL?=
 =?utf-8?B?R0NZUHJjTVlnOHRGZmh4UExsVXJ3dk81N0FOUGR5ck54ODFHUWRKeVkxbjAr?=
 =?utf-8?B?SVJFVXF1OExyNDhsK0RGdUdGbHFmSlJMd1hTZTgvRGlQTGRVVjNOVWtldmZB?=
 =?utf-8?B?Q2FpQ1JHT0hsVEhLUGR3SjhqQlFvaHJ6cEtjOTZVbVVKSVN4elpPZDZaZE1q?=
 =?utf-8?B?SXhMZ3dWVWl0VWRDL0VPZVJmdkZIMit4bk5OdUpOK0VQbTArWFhhWWVra0Mx?=
 =?utf-8?B?bXlDbG5PcjNLNkZxU0xUZ3VaK29NY2xLbGY0U2lnUmw3Sm1aWEVOY3phN0Rq?=
 =?utf-8?B?Q1ZQNG1ra1YyUkN4ZG45c0tDWmt0ek9mamJtM05VMkkyK2JZbnBlTHIzeng3?=
 =?utf-8?B?aXNaL1NUbXBWNU5Gbzh3UVlDSGNnblJPVTQ1ZkxNcXdOUldWU3ZVVnhvb1ov?=
 =?utf-8?B?d3c5Mk1xWmNHZU5ZaklvTFpudWJEYnp6QzlMaTN4QXJtQ1JIRFlzMkd1ZElK?=
 =?utf-8?B?WlVqMDRrNUt4U0lBM0hDUUlHUmxvQnJBN0RWM3ppOVBLajFQdzRUazlRNVY4?=
 =?utf-8?B?eXV0YUdTWWV6cHU5Qlg4cUxXMlVoMVpPQ1R0Tll1bG52V2tRZGN5Z3JvVHhl?=
 =?utf-8?B?ZmRMUXRFSXZBRGFzdnJUN1h6VlFqNmxOTmUwaHpXeGY5ZW5RQlJMWm5jQThX?=
 =?utf-8?B?d3VPdWJIOEhCbnlBaVM1UjIyekszOUVkek5pSTJ2bFBOMXBTRHpxWG5aNldS?=
 =?utf-8?B?RFF5d2ovaEtILytON21VNmJkblRIK01jbVdoRC8reGppR21OaEluR3Y4U2o5?=
 =?utf-8?B?MHJReG5DTmhKM2ZoNDlSYUVtdHN1bnlTcTJWb1dZclJEQ29CWmpSeC94MlFp?=
 =?utf-8?B?VHhYU0dpbTdmcUo4dE1oSVZSY3BrK1VGa213OE95LzIyYXJvbG5zTThxSENO?=
 =?utf-8?B?bTQzSFNTeE50ZXZPcnlsc3hNS0JJak9HTEtmMnlWdmNIU1F6MzA2d3RieWVS?=
 =?utf-8?B?bUYxMHBNVlcwODU5OHVoVG85WHBWcXJCUG01aVUyQzFzbEtFYnVjZHJZbTVl?=
 =?utf-8?B?QVBod3VzRCtBcXZjRVdSTGw4T2VIN09IaDZhekJna2llWGxrVW5FcFJRcVV0?=
 =?utf-8?B?ZDR6cXE5QU8yUFB3TmhvSkJ5NWpKS1V1cmhWZncwUklFajVacUg2ZEppNU1t?=
 =?utf-8?B?MmZHc0oxdWN4WnVzWFZsQkF3UnBVKzdLT3lCdzdpZW8vYng0bzZPNnNFczM3?=
 =?utf-8?B?amRLay90WXVMdWVScEJJYVM1Mm9IcTZubkR4THdZcDRyVHhKbzBjWE5laXh6?=
 =?utf-8?B?UDNUK0JKSHZ2REI5THk1bmFwL3hiek92akg0bTBnMThvQjQzN0VRdVZDSGk5?=
 =?utf-8?B?RUF6UlBwQnI4WVdrK1NKTy9qMmR6eTVnbWJrcENGOElFNG1zN3VQVW9qdENY?=
 =?utf-8?B?d2dDM08xWDlTU3FRamdad3duQjNpNitocEY4RVNhRlRjenBmTUdUZStvc0gz?=
 =?utf-8?B?aWl3WW81NWtVd0NCbEFFa3BkaVhGL2MzL2lncEdxTU1iVnM1SHlzZ0JEeUxx?=
 =?utf-8?B?dURHUWN3TWFBYUptY1BpclZHYXlBYjdDZlBsSWx1Z0JXWXZlTDFIeWlYbCto?=
 =?utf-8?B?ZlVFVUNKcGFzeXgySWxkSXJzMXg5Yi9DWkQ5SzVBc2FrcXo3Q3RqU2ZLL1N0?=
 =?utf-8?B?Y1kzYWJHejRwSFpJK3I2aHdKZC9GUFpQZVp4N2FsZ3ltL0VaWWlRYzhYT0Rl?=
 =?utf-8?B?QVY2NlNoT09WZU5URldqUDlsN1dGd05DeWxyT1Foc1dtUWdqTUpOcmpCOXdM?=
 =?utf-8?B?MnE3bHVBVWNEemRLbXNwaStpVXJSK2U4eHAxMXhBMUhGVGFmYk1xQytxRVdC?=
 =?utf-8?B?MkcvQUZVUWo5RGJjY3piZENtOFR3N2JTZUEzVkhwYmdscXphSXlTQ2hrT2tH?=
 =?utf-8?B?OEpneVlxVXJxMjdFamZGK09oR25rOGtjd0E1eEZqWTBLZklYMmxLK1J1VWcy?=
 =?utf-8?B?OHc4SWttd05yQ003SnU3dWprUEVwcGdPcVJuaCthUS9kWDBkbVZhZldpcjJX?=
 =?utf-8?B?aGRwY1M1TXhMRVlZSkVmRVlGQXI0YVRVS3ZXYkJJRkFJbGhLVWJpcHdMMHhH?=
 =?utf-8?B?cE9hUW5XU09yUTc3bW42djcvY2J1SGpQLyt0UUVPd2VxYXZ2MEp1aVc1ZHpt?=
 =?utf-8?B?cFBLdWtubThNd3dUL0RYajVQY0ZVWmpBZld6MFFMakFaVjhoRnd6Q1RZQUN3?=
 =?utf-8?B?VzB0MnRHeDR1MlZnVUZuVXl2c2lmMHhieGpNVFJZMitDOS8xV1hVd2NDdnlZ?=
 =?utf-8?B?WXZTeHA1RWttM3lQL3VPdkQ5ckNZNEF4amFVNVBJa2xNMndYTnYxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae86fc29-7328-479e-8140-08df343885ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:42:27.7801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl9SP063XVKF8Xt3CozZ+MmZ/48SEvgv8SSEgwUfP9KT2Ln0nuXuqfX4KwEjJindVUJm/RDFAPOaXnl8yCt9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex/Christian,

Ping on this patch that would be submitted last with the previous 4 patches in this series?

Userspace needs a way to know that the type 4 packets won't be rejected.

Thanks,

Ben

On 2026-10-23 09:24, Benjamin Cheng wrote:
> Allow userspace to know that kernel will not reject type 4 packets.
>
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3e5634de077f..1325f9b2b096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,9 +128,10 @@
>   * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
>   * - 3.64.0 - Userq IP support query
>   * - 3.65.0 - Add userq syncobj timeline signaling support
> + * - 3.66.0 - Allow jpeg type 4 packets
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	65
> +#define KMS_DRIVER_MINOR	66
>  #define KMS_DRIVER_PATCHLEVEL	0
>  
>  /*
