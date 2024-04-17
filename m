Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D87C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 09:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F13110F20B;
	Wed, 17 Apr 2024 09:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/pKXr3q";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00DB10F20B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 09:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdODc2L0Amz4TFhgjoFaW4b7kY/7yct4b0cR5tBdjbMQ/KKr9NGZ06a5EpaX2JXCpvzIGqUkblFJ4w8gFvnb5w0VlDGfhPMq7vF/HftIwevBahB9eL2Mq45Fs/i3cElf5kWoEtRVwB/PVHdBnLwaRC4CVKNmFerQ2Yq9ApZPurteAma/VfUQKgOm/2ujS2PfAMaeZrxVGvDdHKWXsNjCTCNw9rY3K1DUzIfHTKtk1Ak+mkWk0jjY2R+uPV9JWEasUStkZCu0mtYyU4tAGFBS1J4Pv5CypNVIb7Z1ct1RspnwXarTw+4EbWe4OceNLc5f0yHN/A23sBQXAcmSEyd1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuROYC4QJOi9xZ1LFuGE4PHjPHvo0rR9h8Hmpr8eWeA=;
 b=d7MqUFMWz1J4fVQPVP3MEmSZnhTGQ6E7dW0wzk6D9dXRZpK8FkoetHZV6dXHT4BiACbVkHjDXAqzQtJFAou7DHHzKl3acpZhCq3KnNNrMHu7gbPciwOvkLc7ez7Pg8aCPQYj7+iw6h3K4HKEdD+8E1mLaf8BcKe/4czVTkI8vpSe8cAtlbXHSovKplOs2Nk+C8EbV2zg6nss9M5oqu8ncBKSjlXmeNfcjqs62zhRhqmlp9Oq63rox8GIM9XuRnQ/bpz9E9FJImomqpj35ErphzrBaBFMK6TiiucDCrz1bifUyMS5a5NJzXdp3lI3wrDIDzEmHYuPtUx882RmLQ11MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuROYC4QJOi9xZ1LFuGE4PHjPHvo0rR9h8Hmpr8eWeA=;
 b=F/pKXr3qk9k7yAwzUBhbhVslU8dSybnUUMao6bLqPkJB8HfQEMGkoT96/AhyYmQEqNnJ/8lyg6bjCl+99aGBIcrSJR6sx2Zjjhe2GhhkHXgLmdJ3JThOTpG1LqO2vpvhp20bJkBD6OEg3WNzMEoiOxnWVepp2g7l1QbVoJHUiNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 09:58:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:58:44 +0000
Message-ID: <f19fbbab-392c-4f1f-84d2-5dc8573db2d9@amd.com>
Date: Wed, 17 Apr 2024 15:28:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Print od status info
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240417094046.135294-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240417094046.135294-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 62feb72a-620b-41f8-6e1e-08dc5ec4f7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+GBj9j9CtXy7sWFtv24vEhxorh2L/ncXhEuAoUtu4FyVfi0MdpXxxTNtmXlDjJtmow9XmwK+CUsAYkBuKTFI6HUU0AydbJr7JFRkY6o9038l4GDTPvl4gg1YcAqRKS6aD9MysrNCnT1KlWCjSGNqGTe+RL+F0K24v0LbuNqaGoLvOvuTLsu1shPxjJOcVIhr7RqxiBaoYXEO+93iXdYpTUSImn6naFk6VZZRc1DxfzzSuKmQ0rn39Uh6pMulZAuj0QRhczGscW165kxEwQf1+0nb/VpH0m/fHLudP+hphB1I6rlOvuinTyH0l83sGjYFyR3iFUjQQoaqlBjrZ5TC8X2UNfIT2YoQUu3W+kLyOiw9YJtMLJb/2v81rcr+THLXZRiQ41MdkTn9hMgG57cK31uAlQX2SA+OccJ4nUG/2JKDShekC75etht88oDGDPjK9dKP8aFyAlkL1CebUtPFxRlI/3+mmc4lugeoldI1VOXVURmaKG/+RNFbNu732E5xD4/ns4SgiRaMfZoom9NWpymy467t2VKJwhZwic4aM7NNZOqhDBfRxhGrqKRFa53yLkAH1g10K4cQ/ujyaky6x2m0Rg0ospsqi3K0I9PK5gvz7yj/QsJ7PA8zWMPVZdQ6dCSlkAy0SOvB5o+wfMAod8L9LLVC+JUb0Er6sMtznw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJEVlV5K2VnV1hOZ3NSbm91RGNXaHVZT1F0WkdsSDZaWXpPeExtSzk5QXZE?=
 =?utf-8?B?RDZ1QlA4TFpYNWNBNW80ZW93anJNcG1iWjNRVjlUWHJlS0YvMUZVZnFFRW9r?=
 =?utf-8?B?U1dYeUtRN0NES2xGQWNzOHA1TldyR3RCWVhGMU1GOUlQOHZEakhLd2ovSHBF?=
 =?utf-8?B?WCtqaGZUdXJObkJVdEZranpRMTU2bHJ3L0VMZTRHdU5KTW9vc1Btb0EvTEQ1?=
 =?utf-8?B?SlBSYWpmS1k0Z0VQYWZ0bUlFRUNvWXhUQkc0SVRoTG9wRG4rdll0TmFlQlhU?=
 =?utf-8?B?aElXWHdJZWRvenh6RU1RUGd2L21XNnlKZW5zTUplSmFiRWNxdlRBMEdPM0pR?=
 =?utf-8?B?S2JkR25BRjBwZ2Y4Mk5adHpESXdsVGY1SlAxSjM4K3phb1BuUkYybmtYU3VE?=
 =?utf-8?B?dUpDQS9zWUlsbDJOaFE4QWNMbk40ZXplaVRwc21xL0dsSlM5OXIxait1WXVD?=
 =?utf-8?B?Rm9pNlNvL0xsR0ttRVRoWlI5c29TZVVEVWprUFpPVnBYZ0JLNXptWmE3akRQ?=
 =?utf-8?B?TkthdnJhcDFFUS9JVWZYQWxFOUdRZ0FLNWQ4MlUzZGJ4dUVyamRUV1BwYmVz?=
 =?utf-8?B?dGU0Nm4yV1hDbm5FQTlEbW1tcmdncmpBeFJUR1Z5MGwzNG94Mng4Y1JhODJv?=
 =?utf-8?B?VDBodlJmczVJSmVZYStKSWJWMURDZStiMit0MWovdy9USjFhck5tQ0NlOHNz?=
 =?utf-8?B?NjZBNktEVGoyRXZsWXJFVDJubG1iYXMxU0FybCtLaDE0cUY3WUtlN3NHUGVL?=
 =?utf-8?B?a0hGbElpY0ZnUjNxd24zWndQU3laTTdRMzNqTW4xZzFmQkRLSmtwMXpjSGxh?=
 =?utf-8?B?NEZYdTJ2MTVnejY2blN1dlkwd1BzVkpiZFVCUFBKM1h2OFN0RGdhYW8rNytH?=
 =?utf-8?B?cEZBRU1Fa2F2OE1GSVN6K3lCd0lpVWVKUm1BclZxU1JzUExyalhLSWdFMXlI?=
 =?utf-8?B?OXdxMHp0VGlTSTMrOUlXLzdUTEJyRUVHZVh1UytsSnY4U3M4SWdtejUxRHBV?=
 =?utf-8?B?dm90WXMrYitTYUZ4ajhyODRaaXdiQ1ZVWmZESER1YnkwekVyTDBQM3d6bFlR?=
 =?utf-8?B?WGkwaWorSGNzdm1jWmVRNEdmVThoZ2doZWg5bE1EZ2Zta2tGd3NzdlIvRzRS?=
 =?utf-8?B?U1AzajJmY3N2cG5mbkdRcWJnUkhDS0ZrdHN4cWFMR0plYW9yR0pXaForK0Jj?=
 =?utf-8?B?U2crclZQdG9TRG5va0xndE45WGJ6SmgzZExaZWpQL0tNc3VxbXlZTWhCS05u?=
 =?utf-8?B?MXhhZ2wwMWEwdjZGd2JXMVFnTWZYM0pJWHlOdTdpc0VxTXhxVkg2dDI0LzIv?=
 =?utf-8?B?UWhkZ1NRblZBVWFrOThLVXBiUWttNGRQQ3RXUXhSNjZHUnhqTXQxa3I3bTBI?=
 =?utf-8?B?WnIvRzlFS0JFaGgrL3Ira2tzNHNJU29IUitkZ0lndVFtKzZod2pJTkFIU0M1?=
 =?utf-8?B?SmZlTWNoTUhEZlFNVlhnWm9XVlJiMGxVWE00UUxKMnUySFBVNlgySWxnSzcv?=
 =?utf-8?B?MFhoSnlzV010TEVnMkJnNUV4b3NuUDF5Wm1wMU9lbXpmV2xPUXBiMFZDWDdr?=
 =?utf-8?B?WlFXRnJwdWxkbEM2UHBtQUp1bW1FWTN0U1liL3d5clFFdTcvTHhWRE13ZUZ5?=
 =?utf-8?B?OUhBZndJVENrZysyRFFWSDNNekh0ZXFNcnpQQUFFVlFTRCtab3FJeWZyVzcw?=
 =?utf-8?B?MDQzWTh3TTczREpqNTg4SHp3TE9vNStOcU13QlhySGNOVlBFU1llQlRaYW1Y?=
 =?utf-8?B?T0tSMnE5ZlYxLzBXYUE2ZUxGZzU0RGwzc3BmS3VuMk5qS0I4R0FIU1AyVHFv?=
 =?utf-8?B?QUFrUHhscHhjOE9SSGc4NXlJWG5PU2hJRnRGNkJhaHlDTXdMQ01VMkxoZnZK?=
 =?utf-8?B?NUNTSnZxUGZyMDVBdlkvRHovV1FKUGk5QSt5U1dKNFk5c1kweExGM2NmMXRU?=
 =?utf-8?B?cHFxbWxRYzVURWVlRzZPcHBaSUV6ZHZneVRvR2g1WVV3Z0thcHJZOWhMTnd3?=
 =?utf-8?B?K2cyUUFXS01kTnY4QVdpZm1OSy9ZWkV0OUVVRUg5RkJ3b3BHU0o2a01sWktP?=
 =?utf-8?B?cTVsY1RCOVpVUzJ5QWZENENjdTJyTzhzYytJZ2I0ZkppV2VvUytiK0liR0VG?=
 =?utf-8?Q?1LSLKsyAAOpv5IYyZNI0Kwbqy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62feb72a-620b-41f8-6e1e-08dc5ec4f7ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:58:44.3349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihkQczaPVyeoEpPpfBea+w/WIfyN97avKnB1xnIkLvRc8wN+mdO2VrcaDdlHZNVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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



On 4/17/2024 3:10 PM, Ma Jun wrote:
> Print the od status info if it's not supported.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5bc1cd4993e8..a20e03e69d38 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -4399,6 +4399,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  		ret = amdgpu_od_set_init(adev);
>  		if (ret)
>  			goto err_out1;
> +	} else if (adev->pm.pp_feature & PP_OVERDRIVE_MASK) {
> +		DRM_INFO("overdrive feature is not supported\n");

Use dev_info. With that change,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>  	}
>  
>  	adev->pm.sysfs_initialized = true;
