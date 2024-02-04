Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79B0C48286
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Feb 2024 06:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B232C11207A;
	Sun,  4 Feb 2024 06:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UQdObIkj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B3E11207A
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Feb 2024 06:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW6OtBoH5iubZaTuIYuIwUAfpJ6HHkcbW/VlQy9Y8/FhfSHICWPESG5Idd8ar1EDx5eTQb5lZZOCFNRIk4aAeWC3I0VH3MHC994rfNCEO/w92S3d5B/V481GZ5Z1hBfH7jD4g7sB5j6fqGALjg1SfVHYUD05q11G26qmgTOz1KMVDzwB3haquhiAglNr6HyFhaCkxCw5x1NOuAoUs4OrSCoDMoYnqnu/V0Vi3khl4PEqYqU476vc6XtCwl6ECxUwuH8FnAcIXuRLn5J2MKe9C0rYjz6dqVM0YrKpLe59kiTBU5zLls1BJT7RfQ0YzGv1Eu0Dyp1TYffdJwAm+uzlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2HWJncVq1N91PmpDIsRxOsKlR2GnyZOEPVKcGzTOq8=;
 b=Clw+EsbF1hjVjhmxQgrpY4nPjF3et2/Ue8BTTwCSjOJDxFNN/HneAT8iodcT+qYAoeoHgMksqekQ99+I6JRFufP0/MgIg6qmcQygJ4gTclks/dwymrDJorFQQWhd25aI6ayj92oFH9P6yBfXxc9L3ESDrn6rmSTLM6kNnPhe85RT/nZ2HogdMNI28dlJq8sCp6p1+pNRpUneloSC+1QepSB3BQDYzxNVaDqJqq7dV6tw1wO/RZEiBsyXA30kz6GBKn2x5mv2roAAKPfx1z5+bAFkBQIMTV9TvwXoKy863THZkXffIGk2QrDrYeSwu+6JsvgGK0sL82iKWK4T1wP86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2HWJncVq1N91PmpDIsRxOsKlR2GnyZOEPVKcGzTOq8=;
 b=UQdObIkjDyFZ1TuDyhSvfKkuI/zUUlYU5RTPwXXv63LwBBEVhjOPB6KsQcwAttztuVQzeZWdOLmF0vQj6u1j+CAUvwQYLjdHCRfsJvyNN4ajk7qDIfUViwI9LK5vPohlNTYdJcL2z/UozJuW4ZnZOMYwZ9kIrKL9IJgHMwJ68MA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 06:12:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.015; Sun, 4 Feb 2024
 06:12:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Avoid fetching VRAM vendor info
Thread-Topic: [PATCH] drm/amdgpu: Avoid fetching VRAM vendor info
Thread-Index: AQHaVe2K2BzUDv+0h0+kLjbMxoNwRLD5tk0Q
Date: Sun, 4 Feb 2024 06:12:31 +0000
Message-ID: <BN9PR12MB525751356AD8F7D6280CF26DFC402@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240202153547.274367-1-lijo.lazar@amd.com>
In-Reply-To: <20240202153547.274367-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=48525e1a-fb8a-4a5b-91a1-fdefc375d140;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-04T06:12:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6931:EE_
x-ms-office365-filtering-correlation-id: 12b384dd-9f8e-4e26-56bb-08dc25484599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hU1JbIDuDTeSHqPTwVPK0dSi3zFW3kEB/hZYndbb4o+zkikni5K6XHW251xg/BN+qrizlgJP9oQRXYaGfJ5R0afij8uBqiY/GxvB4XAd3HzsDJYvrA58XwdrxGL9an1W5z23wg3LRYM88syY3+4IOZiyikOz117bc/GRyuBKjCV7VMQV9LBDLO/A+9NcKR/Px9ZnW2fBc7e9NTISHx8gN04N98p91v3DM5TJBdOrIdWE3Ic1R22tijAFFSd0m1n6K5QY9Gc5Df3tiXabDjgI+MdaNw8zp/39mkpuNlQis7i1aM+5dBPo7yIiVbB48wyFiJyW5fFPh6sIJ6zjN/GpeTqbrz2N6T8ETuCWUmNS/bDDnxaMD4E7fbeVxgZ24taaWzyGLoRw0LWYj61HUDY3nrAbv6NK7PT2Q34ixHnRWA1lsqQY5ryfP7tDDihLJH9YvlU3gj4Sm2NRtl2qAfX6chnfgnyzwArY2fhMfhTo4ZP7hy2RShQQyRytKlj3VrAKe134y/PxvNpb0/yrXGd4Fo7tI5nsCAdU8/8uGsMwpUipqcAmv0RoeMlBg9DOQmlPw7Ld+ZjyesvEn/g8xzbpDjQcYSqzF+IvPchyOg9oBgtOKUrHX065hT8F+AuBhtw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(41300700001)(83380400001)(52536014)(38100700002)(110136005)(66446008)(71200400001)(8936002)(8676002)(122000001)(316002)(2906002)(76116006)(64756008)(66556008)(54906003)(5660300002)(4326008)(66476007)(66946007)(6506007)(7696005)(478600001)(9686003)(86362001)(53546011)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1xjF/kVgJZJEoruSe9bukKSLf8CT/qkGrG+GvHJhXmnMBELRPUXzlG0EYsB?=
 =?us-ascii?Q?Z/WabV9DRqx2EGzMG12VsPq8Q/xOTZ4SHORi1PsQiXpPbGD6dcfEz1/YJCUs?=
 =?us-ascii?Q?fj8JW8zJL4rFt3Rb3/Bm41Or+G/UcW+rm+CT+QN3BszbfDXNBqVjqUOHn6Bv?=
 =?us-ascii?Q?i1dNgh4Z3AfkBR333Bo7XbqtZ5Nm8KJdblC4866NlPlw3RMTOu+yq5WCeQXB?=
 =?us-ascii?Q?RnIAtpM5MEDlj9SH5svzh9JaWUFYmCtTuZTdpT3YA80n2MbduM9E+fKs1gal?=
 =?us-ascii?Q?KAZbuFJdM6fcRiIsy6uoil5J/GBsbWNY6BTnzZkkNNglqbpCs/KVnrzoDVFZ?=
 =?us-ascii?Q?wYUJJryJrkuwOxd5512SyraqxEH+Up/oLMYo1bAqyMGx5wD4ZYOEMxR8ASmY?=
 =?us-ascii?Q?khet60YxboD78jcDJfzk1h+5MtQiCwVeu8J9W4kNFaxFUVN/AApxFInqezf8?=
 =?us-ascii?Q?uFetpUu98UDAQmUrlSd0y9d3DMooyR1YBe6cF36VZG34p3kMDnPVyFtz+Kyq?=
 =?us-ascii?Q?tc6RbZBUaVZIePz7o1qG5mfCNR5EjonLS+oVaJhD3nQhZ79y/6B4Utkj2WXU?=
 =?us-ascii?Q?6wRaVSTxDTW/eXlGkRqyo1umVFl1uE9tmmlO2XXWfAv/3grw7Wy1FeAwaItv?=
 =?us-ascii?Q?+2jvTReiRo8AGnNEeDdS8wuRG0EeS1RyncJq/jvafHPontpmTwgza2MtmgPy?=
 =?us-ascii?Q?S409SnjZC7KexcZuCbsmQbE1I27FLRxIKtlkl7wN87WxbNR5VW10xshsclUY?=
 =?us-ascii?Q?oARmF64P8KVxcdYfTsDnPH3DnFdZTJgLhcrjwznrg6TP2Lpfctr7473MJ2Bs?=
 =?us-ascii?Q?6c7BRkzwBQ/4gay/CkvUcsjthBNMe4YQHLylDSzJ+9fIfXMbxsqH46prJPro?=
 =?us-ascii?Q?t5PWWUFyxOsh3OMHImwsAjpYlHYdjsNhVBqUzmHVNcTHizPBSjRGInR/p/55?=
 =?us-ascii?Q?d6l5c8QJc6HYEE4qRiIy9N40tI4B/pe9qFtUik4Q7/P5SvmcBm2pT8pZ9d8e?=
 =?us-ascii?Q?DX6tZmxxN23z3Zq7wa3qB1tjNk5lxu+6NHwwBMJDpmaqsmBBZcA1hMwWfwZ4?=
 =?us-ascii?Q?89pIiJHynfgSeJqwTaFnj5WxvwfFPmHnljTIJNCKy+BAUvdr5ZInvmXVUqUT?=
 =?us-ascii?Q?rLGl3kTEbPLRuVqoLZLRMXdlpAhAoUi9PmxGJ2CIPzxeatj6PVld5EuUwPR8?=
 =?us-ascii?Q?rENoHu/W6ElsXF2U/9YgH6jL4vzfH/0r7RXRMiDTchXuJOFnusjuqiGaaLUg?=
 =?us-ascii?Q?YwGP53lCpXkAuRODlYMpOIhMFxaIf5OCzdJDFgdCpKh+7vuvovuw0iWfoXP0?=
 =?us-ascii?Q?4C23pBN+/3FWLPveDMK+mt4zwVRO/Ma8HaEDCMk/PoZnGeGybC0Ow4OIawdA?=
 =?us-ascii?Q?PRaTGaErf6eMwIUm3KKUQJg0Uc5Y8qh1GvlBYQgjPDxTOYsm3DRyDOoquD7Q?=
 =?us-ascii?Q?RY/xXQ1ihL9u3LgpowPU7K8gR/wZQutf7rjYX0aiAYaVOtEU3c5arY1NTZR5?=
 =?us-ascii?Q?vpOFLnZjMM/ZjDaHhI6QnBKrWUoO61cIL1KolDy6bgPjfW/227YAQH7kLGOv?=
 =?us-ascii?Q?bhvxJAb9mNTGy4ROg3c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b384dd-9f8e-4e26-56bb-08dc25484599
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 06:12:31.5064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EV7+0x63rmnQcMFJnACVgZhYxCHfiaO3zPy4b68Zcxgnf05CVipihd1abWQ7koaWc+mgSrfJDnnHExI1N3GmRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 2, 2024 23:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid fetching VRAM vendor info

The present way to fetch VRAM vendor information turns out to be not reliab=
le on GFX 9.4.3 dGPUs as well. Avoid using the data.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index a3a11538207b..c1161f465b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1949,14 +1949,6 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_de=
vice *adev)

 static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)  {
-       static const u32 regBIF_BIOS_SCRATCH_4 =3D 0x50;
-       u32 vram_info;
-
-       /* Only for dGPU, vendor informaton is reliable */
-       if (!amdgpu_sriov_vf(adev) && !(adev->flags & AMD_IS_APU)) {
-               vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
-               adev->gmc.vram_vendor =3D vram_info & 0xF;
-       }
        adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
        adev->gmc.vram_width =3D 128 * 64;
 }
--
2.25.1

