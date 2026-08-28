Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B75C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 13:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE4F10E02E;
	Fri, 28 Aug 2026 13:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXEo6FOg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6128710E0AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 13:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jgb/GiLLCKvIYJF1ITvZFBPJsmyQQfwjn9lrbWJbVmBTKt+uhDO9mvnPNnxfGGTd5zC+YKQMZ7ApZ+7Z2j8YmLB4joh7UIMPtEGAesz6o6fSoA0wYqhWef02ng5JIQy+BhTz2zqeAQDv9VRNz1Dfx11lx+rQG7SsU1spkgjgKE8Zmq6n+jq1otbvK5Jb09QTPUI0GdQrR/oxtId0iktWsfpEpCYB2VQNy2skmL7duP1NXWSGiidvcd9/Vb6PcQ6f7Nd96KamT5gaXSxrz16GOzEoXViBuuBo5r9m9da/x6cqoNwPOghcF2a+W88KWFTCVVngmu9/AcgkAPo3A8TI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylflp8ojiWlJP3qnOQRcRP/ZolB6ORvGvQ80WFDCfZo=;
 b=kBhdDQIk2nd3lNNw0idkRk/j5/1avd2JsnmAVAmsVl7ojK52o8t8j9cfNFEcNJIoLzGE7feIyJN06o8KxyeKFtyKxdyJOXzxiwYLX8isdyf1iM54eJhMvwZQykbemb5lCpaERX6Bnyh1O0NbUkue7iTB7Vt8RRLJ6fuw/YpYkKxt8Iy8TuxPQdeaH+jUI2PnAA8Xxbe2m8Zt7TK3hub/NibMAw/RwrSOJzTDQrDVZe1wai8PkvArgJR3z+paMizmeN5feGdnnN9uMBqJKupeWkLR+ku9xF+1VVK/Kfi1o7yrajACJr4+BvPLbR1Jk+oMzz10zeCG6sL11Oh78vg7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylflp8ojiWlJP3qnOQRcRP/ZolB6ORvGvQ80WFDCfZo=;
 b=RXEo6FOgujlpnOw89fYMFh18UHKJaByso8DifjK3AOMze6Av7CFc+r425HhNRpWKTakTAD5ECwZQYdmycH9kjzsYEmZa74oazN//C138CLxL9g15PukxjtXuOA7cBV0TbDJiu/UOxUglEx/JYMaiN8flImFWnelyc6Q1BaOK1OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 13:11:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 13:11:33 +0000
Message-ID: <7d6223cc-4071-4ade-99c2-3a1acff50663@amd.com>
Date: Fri, 28 Aug 2026 15:11:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/amdgpu/gfx11: hold userq refs in private fault
 worker
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-4-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260828095349.9797-4-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2d24a7-1fe2-4685-3a6c-08df0505e18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ttrdqEX+auUxPcrw4mK9pxHS+BfVWzolVYMnIT8rcCCFITZWjFQYmdgWOT7wGSoBWdpQz81wCFPm6PmTDqbpNeZX/D17o2JC/KzKR/3szoYPMabNqJ+jN2la09qICxOeOic588gua5Pj+hQPvrjzLRDI61ubdOu8eONFurcrZwdzBbhHYSFjZtgHDBBSrHfcLRTYki/vbRaJ20yobjRr50KGDezwSW6zZvsOk0pGmPAUG7rbBHZDTOWTa3Zy4WD+gXQIrwLEiOpWu1tnPwsqnaFmgAqwK+6D2iDWQ3GIEq3ZXE9umVpOMnGRPdZuz8+yB/wysSTAhn91JKN5WPKf2828scfp60LI1WF5Ii+1l3P9Vo8skV8M/VQ9o3C6nmGwe7ZMn+RVFl2jlFZm0BQgaXxbvLbyAxN30POI35s6tNf6gXM/Ytj4j3/aYc0i6hAd91Tteuj2MkXY/gA7BkMZjrzD9jkQuQ9dCWMscir/geA066DVreLurfvSMs8aGTiZXi4RdF6EcpIwVXGQIOLgDU53xBwA2zT71XwCc66asw3I4RTDQ6Y+Dz9Zrf/VEYKhMtDHKZlA5/rqbxo9CYkSYMlkGIvb5hfjLit/IGXQaGCbZNwXQ6fCVu+uYGTWfie/odjyrWob9mIm+TXqCMk9z2JCzDv4FqOclBQbGNJcS/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdFZkltQ3F5WE5vdDNMMUJ1dlJaaDV0eVdCMUdnSlc2Umo0TDgrODJDL3dG?=
 =?utf-8?B?WVdycVBCNWhFLzZ3bllXaFl6cEtJODlSL1d1NW9oUFc2MEREU2oxYklLSTh3?=
 =?utf-8?B?c01NWGpMaXN4cUFNSVpLaW5wOUwzN3hqV1lKUm5UaHlFWTJIb0JRSWlIMjJx?=
 =?utf-8?B?NG1iYzhsTisxTnhkYzRKU3dEVlZrNExNQ1NOVWd4ejZSK3hHSlNaaHcyTGkr?=
 =?utf-8?B?K0cweDV1d3o0Z1RCZWZYSCtSNVpwcElCWkIyS0JUTE5vNUQzalJRN05ldnVp?=
 =?utf-8?B?ZnppOHRvNWRkalEwRnh0OUpwTUQ3NTNMalFpRHM0c2ExVkJjQmdYaHhEL1Zl?=
 =?utf-8?B?alYrVXhnczhkMDlFNWhKcGE4TmpyNkg3aEtOQWlXU0ZTVjlLSkYrcnBMelVI?=
 =?utf-8?B?WDhUM21XdlVhelByWFZad3p6WHFtYkIvUkpNYjM5WVpvb1RVcHdSZ3IvUUZN?=
 =?utf-8?B?enM4YlFGRlZvMlhnWUljRXVNVHNLQ0hsMzFxSG5tKy9McnRmZUNWUzc3SVdN?=
 =?utf-8?B?WFA3NDJQS2pBWVRXVEk1T3ZZMjlvWndCMFJnejJPSlVFS09XRVdCdmdKa0tr?=
 =?utf-8?B?bEhleFBzeUNWczRKekp3VEhwSHRSSlF6T0hQdjNuWm5sV1hhTXZSMXNkVkJL?=
 =?utf-8?B?ZjRrbGl6UVIxWlgzbEt6ZFBlR0dqWUZhOEJBVHlYUmxZWm1OVkFJc1I5a1Ey?=
 =?utf-8?B?VHRSRTkxbFBvVUgzUlc0b25iQWI3aU9keGpmVnpnRmxXTXJFQzI2NU9ZeEZi?=
 =?utf-8?B?SCtlQkxib0JMcC9ockkwRjhieVBaVVBEdDVPQWtFbDVtYnVoem9reHFFQUZE?=
 =?utf-8?B?VFJDcm5IaWN2SkxGdENkd3RLMmx1UG5TQVh1NG82V2xJTGd5K1J6eXVCQmVq?=
 =?utf-8?B?Y2s5cU8ySGg1TVE0TnFoS2syTDQ0ZGg3TnR2dFNweGs4VTJhL01BWkptcnBV?=
 =?utf-8?B?UGw4ZlgxRUVxV1U3R1NtM2FadDdZV2VnM3ZOSXg5SE92Z3M4WWt4LzBUSVNI?=
 =?utf-8?B?aUJNUTR2U0FkSkNQVHdlRGtNS3JLRGpoSk4yNlA1RE1wV3RYWE10bXpQcE56?=
 =?utf-8?B?T2NKWG9meWhhV3k0TEpBSDFzd1Qybk81NnVlMVB5bHVtSUlZUVpSVGdxcStH?=
 =?utf-8?B?OUxRbXArN0xnQmtmNk10UjB5WUNBbGRYOFBqTWFUWTM1VHlpNE9RSzhIVmFF?=
 =?utf-8?B?Z2R0UjI2MVNFd0RTZVg5cnIvMnJSd3ZqSjBzVEF6NlFYdm9COG5PQkxmZGNu?=
 =?utf-8?B?aXhrQU5lYjJubnUxL0pNRkN4NldJSzZqYjh2Z2JJYkZBS1ppNU9VMlVCcU5m?=
 =?utf-8?B?S09RQzJyYzZqbUxwWkdpOWQxNTliaGo4cjFKbVdsbmVGVnJmN1Y4V0hoVFlF?=
 =?utf-8?B?SGFPZ2hPWE1rU1ZsaE40SmxSWUdQU0prb1RTaWtKcGhwNHA1U21Wd2d1b2JY?=
 =?utf-8?B?T1RJQjdKbEJjbk5xdnp6elNvclRuTEdUQlNIYXRCb0REcENUUkdPeWVqYnhh?=
 =?utf-8?B?S1JPMXQ0R0diQ3kwVXBvQkpIcTNWWHB0MWxKTTZ6VXFJR3Z0RFAwQllBZlB3?=
 =?utf-8?B?MVpQUUhVcFJqQWpYQVBQWndTT29ESi81VW1QdVlEaEJoaGR3bWRMVTg1WGps?=
 =?utf-8?B?eDljT0JCQnBObVVSYmxqY0Zha2hnV2Y5OEZNYnRMb3o4cG8wMkFRQ3pLck9Y?=
 =?utf-8?B?QUpWbjE2VFN3TGZ1cTZ0S2ZCSm5SUDNrcVJJQXZ1cVpBRGp6bE1XelAwcW90?=
 =?utf-8?B?dXBzUmdPbklwclc0emFFWjdnUk82Y1ptMVJIQkFLSm1YUzZGYjliazdGU0RS?=
 =?utf-8?B?cjhiVlEvbks4aG01T1FhZGpDU1FBa1Y5c3BwaE9GWVgzZm96Y1RSOGd4eWlB?=
 =?utf-8?B?ak01N2JFQ2JjMDl1MFRkT2VXeldCc0w2NjVUS2F2YjJpMkJKU0R1bEdqWGto?=
 =?utf-8?B?OFVzb2JrTHllSDQzMGtUZ0RveUQxU3pFSWFESUdtWDZBUHlSUHpYUUlyeVlV?=
 =?utf-8?B?a3Z1dXRkcTlHWTF6aFNwOGFhK0FuRXJ4REhMb3FGa3hpZmtHQkgrNnVaZC8v?=
 =?utf-8?B?SDRJWUxXZEhuVXVDQXIrdmFFckIzdlVMZlQ3VUUvV2RVNDNIbTRvRExubkxs?=
 =?utf-8?B?VFVrU0RqbUtVQWE3dlRiSldzbDBXWTZRVnIrUTBjUkhpL1NPeTVMZWl0ck40?=
 =?utf-8?B?WVRidU8xSG9yNUMyK0Z0dWlkNnB4UHlTLzBXbHYycU5DcGZDck5RaVNoWHAw?=
 =?utf-8?B?V05lMkMzZDgzTlE4MGNlTHJ1WGNkQzZ4bzA3YmhaSHlEbEtqa0tySHAweGh1?=
 =?utf-8?Q?3WIaH/R0Ma9y/cpiSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2d24a7-1fe2-4685-3a6c-08df0505e18f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 13:11:32.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srNOmJKCaknlnO4YBvbEVLtMNJG8TvFGXn2e/ycMBY6S06vuhSAOEU4pka4Z4y7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

On 8/28/26 11:53, Zhu Lingshan wrote:
> The GFX11 user queue private fault woker loads
> the relevnt user queue from the userq doorbell xarray.
> However it does not hold the spin_lock of the xarray
> when walking the xarray, and does not increase the
> kref of the user queue, so it races with queue
> destruction path and may run into an use-after-free
> userq problem.
> 
> This commit fixes this UAF problem by utilizing
> amdgpu_lookup_queue_by_doorbell helper, which
> properly hoding the xarray spin lock and the kref
> of the user queue.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a447562977ab..a063f86a8847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6733,9 +6733,12 @@ static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
>  
>  		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
>  			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
> -		q = xa_load(&adev->userq_doorbell_xa, doorbell);
> -		if (q)
> +		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
> +						    doorbell);
> +		if (q) {
>  			amdgpu_userq_start_hang_detect_work(q);
> +			amdgpu_userq_put(q);
> +		}

This must just lock the XA irqsave, this code has been suggested like that before and been removed because it doesn't work correctly.

Please check the git history before suggesting bringing back a buggy approach.

Christian.

>  	}
>  }
>  

