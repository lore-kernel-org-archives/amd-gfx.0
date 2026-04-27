Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B8CFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 11:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BCC10E284;
	Mon, 27 Apr 2026 11:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5zPTZwn";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E419D10E284
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWm/LN1N48wYL4gTE30UBLBtZuGoCtIcUrO1ZurD4cptI3Of5AJIjQ7+T7twTtRdkQb0CWCm1uWCRSjTKzOIB4G6RR8o/04zaU+O4VddB8XUkKyaFM+F8/dA0GkDPQat7Mu89OvrpvpcdJwg9CtKZ7oL5JeSJjLWzSL10sF6DsbLQglYRr6U8jFDtZYjQEnWmob9vaidrpFQeqmIQ5e3skcmj1mtHOWPAp3PTnElghRRmrIPzt+EK7eEoDwGPrgZ66uj41OPCGQuY2aPX+irsbWLJynB0pUw12CU0vpCdX1jkOjK6d40pJe8LwSrJBYoh0mG/NqOktZEwHnYLWfrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSW8gnAF6KJV00AO7FkEwT2cjdmLPmxzeYeKpf/VpC8=;
 b=nNwK5Sy2HHpf6NbpX+p99cVU0x4DTgQ1tRxAoVona2MEqQE+ZwXfB1c7hQRappQoq7nxo1Q2iG4Vk16NkKxlEw2BSMEG9yWm5zHFSxqSAkKgs7b8sVqSGdBJh9eYIIVa6EdkPWpiwA/VfnRiJPNkbU1F1iJTZjDZH0aLIQSWvEYMaDxXQfM6bNV8IKQPFvwFxf+R5R4o0ZitythDVrUDuCn24MZ9xDSYuIjO/dGN7sAlfF6z2iHUQAmNUt0Gg4eZq/k2fb/5nSQem/DP8EBQqdJhUTRTZ3j0D2XLV1yLcaldTcdgSbuw3y8tJuJo5TrbP6nuCyQmxqdop0x0J+zkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSW8gnAF6KJV00AO7FkEwT2cjdmLPmxzeYeKpf/VpC8=;
 b=l5zPTZwnUgDFEUi3KkFaJAmvEFTrdX+4R1/Y++Btg0pWR/lVK9nVGHcTby0fr+khOGfFzSCfCwgeHhwdqdofh20hsn2iG0PCA9ETMuxZnY1mshFmwc4o3V9xv9sRb1B5bm3wKgaLfhUBldbaN+hsSFw3AIamW05Kb2LjcYYgrd4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Mon, 27 Apr 2026 11:59:46 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 11:59:45 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Index: AQHc1hfNf8BAUPJkyES7d1hlT8ixXrXyh8uAgAACm4CAAAOyAIAAEmcAgAAtmkA=
Date: Mon, 27 Apr 2026 11:59:45 +0000
Message-ID: <DS7PR12MB60717B0AC6C53245966A41868E362@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
 <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <fe6ed465-47bb-41fa-9d3d-5e6c79b83bd7@amd.com>
In-Reply-To: <fe6ed465-47bb-41fa-9d3d-5e6c79b83bd7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T11:58:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB7928:EE_
x-ms-office365-filtering-correlation-id: e0a38284-e912-460e-e408-08dea4547968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: +6knRtxV+z584YQQeyVOfDvVgYhtyhp5apwlexapnHnhUOOBTOk58Y3Hkvn7mRZn4GAZDr7J5Gz18l91ntnrFH2913ZYVcSMjKbaIwHOT4G5p5Cs8qJ/I34ZYli1QYPJRU/osNOZLWZgtMYF/GWJedxwyR76Jp6kPCI/9TpIE1YWzoPfrZSD2O1aF120aN7HUAzda1UaEpVtScLMpoJ3P4zUWzrsyg+pHfz1uAsvTUrAV6btj4rTxUW2/yRDJ0r1mFtLYU5DOz7Uwkl/9cXr6+i06Cig4QoPyxDsRq0vlxM8phkxXlOHyfrU23+xnesK0DDV6ts6xH4JvZr2odS5ZRZe3yc7HaW6qzMgG2A/LZInyiD4hbcLS2Mptpxqs+R1qhHs7kXTSIurVWbbw2zFf/a1sX/a2Bx2V0THb8XtVINZUgjS1Wpwj6Ft7vJBwtFrHcijN9h9d2mpuULQFtHghs+CDCXVZIhej1pjjRNLYasq7+IkWs/oSz6l+0/j3GlVWs8HxiJ+L4mB0RvXVxNCMBfMX7QzV7qdGid1vkoAw0It9dqX5IpnmXK03UzDZ2Y7vg1vSB5cbD/9GIa5ZSiBNQSCIpntwvdgCEtKseoAHejkmzqS5dlOk7hdkqlZB9ttfN3EW/2V1cbskmIuUAJIe9Au0RKUy0RGxhjXF6siaootiXKsUvA6riDeo2btChBawOKxOAt2ZzFW8QreteanP0YQG1O2MlF3JXHpsW0gZfOxq1E95Xg3M8wU7TCgPF+K+Iz1GqQ1Ei1vcBWYRHn+zw+AbCRro9YYfL1vPdZTIo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TauvFAQwAmVjUNcnIIvgs3B+UJsX7r7i41HyeYeJSIi4N3a94psn7RaC4DDr?=
 =?us-ascii?Q?zZYZRZAlHtrzRih53nNPSxh3X57ty4Yc0IEyKNP7sLe30b1cx+Wg89c7BOAE?=
 =?us-ascii?Q?yN3hP0sXO4uY3xr0LSHrmMEr3r8mAs35cCb965SfHbLaZXtJOH00Ec2CUPIv?=
 =?us-ascii?Q?1X03wIj/5E1cG7mQqlFO6+hB871z87exdS+8bNzBUKlxjpQqhz8/3awer5cc?=
 =?us-ascii?Q?ERpTkSat7YX2UrKg6IdUx2Foc7cVnmhWMi5ezrJK5Me5Rjx6UWLDqpJMF3lQ?=
 =?us-ascii?Q?q0Wk6YBEafu+ffXAi62xWbqkY55lOOZy9Lhp9QO8+1CLMMs6YFEcJK7bh38F?=
 =?us-ascii?Q?QTTRh7XaMo5IBeJ+Vnv/4DYLUfWWito1+nICjHApIENQWVLz/oteyy1i8ex/?=
 =?us-ascii?Q?rmQCm96kquRHCUau9fmTS1L1N1PeVatxqy9MIA3pXfpU4YiD3qnYl8u/14Jy?=
 =?us-ascii?Q?zCAr2pZAcKGPKamjrf7Ya5YxNbRnDgdh/hmZvNPzf9cDHpoHUMULP/jBOf/F?=
 =?us-ascii?Q?PJ40JQSdEujFrNJisNpFdXOxA/tRGhBxsASX/qsYBT/ErszMIsYAGDjhpGa0?=
 =?us-ascii?Q?fXjxrwn+j6GH7SmFZen9B6Thu2BCtl5kjLAOp3sonh/aZQl+UKSErTsQrms0?=
 =?us-ascii?Q?T8Nk5ULRuznitXDyi3jGrjiU/QSUjElZBV6z2ySaSwqkAYQnEOulsCrqeI4n?=
 =?us-ascii?Q?MQrU/LKkvIhAFhL2wLSKGT+vOO6IOYrqDtifuuRWvYt6TZVYkXaoH/JHspv4?=
 =?us-ascii?Q?MBzqjfC8q7WQTDDAd5QExD4mBbKbBnPSsnot88biQuMjIte2FQCIZFFRddCc?=
 =?us-ascii?Q?k9e+C27N5CeVxhX9swZOlb32qixc+GBl0xwCYJGg9gyIzXMhxocym4Ixihly?=
 =?us-ascii?Q?vM3m5+1SXSyLh7dqCfP+Iv2nFFvmCGxra8b1Ln7ujXTafIBuPHfvn8uuTKIN?=
 =?us-ascii?Q?9u4KRMZuzTuBkf5+jYC5+InyJL5CnRRjyWVGDBR93kHp4PUOWiWZK3jhw76h?=
 =?us-ascii?Q?3UKZQQ2g/A6MLYyViTfr6PzQfUCLJN4EV5Do+5Cz2mUCqlL34N1ZhdZrfWjK?=
 =?us-ascii?Q?tJH7KhZS9ocLap9B2XTCG6+2qTQigxr6elHvG1UQG5ys/TaHOkP2aiGQF3Hj?=
 =?us-ascii?Q?8kpZPwV3d4jlsWdXnWfDfWobNvImN7H8aCdfujGpoHemwyHXlHenhd2DHuVF?=
 =?us-ascii?Q?UyS9IM8DZU0n8HkjxO9qshFn6MFVCLEKf8OeG9MjJobME91CD/B3PLLrA1v2?=
 =?us-ascii?Q?eKlDAQDZFtQ95LhbGggvGX/SJHTPEWt5Phm2FsOvuNlrCAwHelG72Y4d0gql?=
 =?us-ascii?Q?/yKLR7hTsGRCdA4QmnLOqwNuHEqm/XdOaT8baJE9+6ilUrF6cFMIyucvnGwJ?=
 =?us-ascii?Q?uMXZw6aMsH1Um6OcMKk7+bxHyLJZuGsmsftIaS5y7ti1oxwa+4Df+htRAR9w?=
 =?us-ascii?Q?wpmqpSuzcjK/as/7UCYL5IzQyMG5RreWfO9Kn2P96PHp8bYOlO1J85Ych2vI?=
 =?us-ascii?Q?ZjxIaQKQKeCD3+WmiV1460QT94ksWjh+49lzr+noWwgixfTCXayDygOYcXY6?=
 =?us-ascii?Q?k3hytBj9UFgfbZ4GDJ+UddbrapV0bKMMoHdl5QNW51YKXUY1J0LS0vf8m9zP?=
 =?us-ascii?Q?J1P5XUWmZDVP0FflyNGtavOSlQZ0FJwtmF4AZ8+KWJDvdjRNcNdga2hO31vw?=
 =?us-ascii?Q?hYdaIa+xanwG+AX9Nv/GBEEibD6ZshSbJWvZjfRBaVM2MnJx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a38284-e912-460e-e408-08dea4547968
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 11:59:45.3932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dng+PPd1ur9e/yz61J3/JWq0bF4kn/2jjVUFnil0wpcFHckvpPJAUvg1Ybh/bK4yK+nNLmFdDZQ0ZOLjq0wjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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

AMD General

With follow up patch already sent to update smu_cmn_print_dpm_clk_levels lo=
gic, there is no more update needed here

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 27, 2026 2:45 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6



On 27-Apr-26 1:39 PM, Wang, Yang(Kevin) wrote:
> AMD General
>
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, April 27, 2026 15:56
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>
>
>
> On 27-Apr-26 1:16 PM, Wang, Yang(Kevin) wrote:
>> AMD General
>>
>> +       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;
>>
>> You need to move this line of code under smu_feature_is_enabled() to pre=
vent subsequent smu_cmn_print_dpm_clk_levels() errors.
>
> I think it's better to fix the smu_cmn_print_dpm_clk_levels() logic for t=
hat - to keep a separate path for dpm_table->count =3D=3D 1.
>
> [kevin]:
> No, this should be an independent issue, and you need to maintain consist=
ent code logic with other SMU functions.
> e.g: all locations where the smu_v13_0_set_single_dpm_table() function is=
 invoked.
>

The issue is because smu_cmn_print_dpm_clk_levels is hardcoding number of l=
evels to 2 for fine grained regardless of dpm enablement status. I think th=
e fix should be there rather than at other places. If the count is only 1, =
it shouldn't keep the hardcoded value as 2.

Thanks,
Lijo

> Best Regards,
> Kevin
>
> Thanks,
> Lijo
>
>>
>> With that fixed, the patch is
>>
>> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>>
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lijo Lazar
>> Sent: Monday, April 27, 2026 15:31
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>>
>> Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report=
 clock frequencies correctly.
>>
>> Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13
>> SOCs")
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 40f0d8a685bf..8d04f6e73fd7 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struc=
t smu_context *smu)
>>           /* gfxclk dpm table setup */
>>           dpm_table =3D &dpm_context->dpm_tables.gfx_table;
>>           dpm_table->clk_type =3D SMU_GFXCLK;
>> +       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;
>>           if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT=
)) {
>>                   /* In the case of gfxclk, only fine-grained dpm is hon=
ored.
>>                    * Get min/max values from FW.
>> --
>> 2.49.0
>>
>

