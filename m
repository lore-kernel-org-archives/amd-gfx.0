Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31BCCCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBFD10E2A0;
	Fri, 31 Oct 2025 08:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UGW1V+8y";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388A110E2A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2EO3M+jcSGHCWGyYt5uXD1RWup+uzzLxviaqE/5kxOPMExWSqqx1HMqSNZ2KbllwdPklZJwPVkpAE15fRolpW47TB6ko9nWJ17gchpAcMOTLj/sMwB2x/rqfeTDfNmTrXIBI88qWauh/3rdiuP84rBuX/bDpINYNlhd0wgJxYxO/9nV1WeNpyh1Oc4HFswx1o+aYG1QaAMcsDvcZy/BI3A85sqNhF4qZOiL2m3NDjnlOPzMCSk024ITvKt26YEyg9+REJX3yU7S94KTqoylEYijqGFLly10WnuMD83yd7vGaB5tlib+BsZqZ/wwLdzhoCQM/EwAlI6nhnHPQXLpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeCMWYKOSXTukTzE3gbrAl+TGhACBj4pRVGKzcKhZtI=;
 b=aRWwyVvAkzKaMxeafPS8kVsb8WW/hojAhQbuuCgKu0K1ICaCala6iEeh7KhE7gPYLzH31Q+TsW/zI6hq6TxtLVmKt22X/KRTY7sUHyAb41dL8T/JhJeBryD5y+HA8mdtn/lFrRHrhNauY0qDnJuHftCij53wLK+SeZD7e8QPz4dNrbeMVG4sLASC5eFpEl4Fyf848LUBVG693kz13/JjyeLfSx4KWK1tQcR8sL0JN66cq9hUwc0DqHCgJiYeTGCn1ta2tivnwERIAbadMzhrf7tUr7hDHVbTekqizYpoOIgakEUqbYUseccqlLBXUrgdJVP4Z7of32oVoLpbNhAvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeCMWYKOSXTukTzE3gbrAl+TGhACBj4pRVGKzcKhZtI=;
 b=UGW1V+8yQke8V6XCH+gza/DXAddLr8kLi5CFq7dSXA++HSdJG8SJrmeuUgiUuc1x0abgKZWszTiiLE+bGuDk+4IwAL9rnq+wfsiXwMwnkJjC4rbaaRTGPM4N+Z7mqnHcaj8BoC59kuapKy6q8RmP50bq/oL6H+Bg3S4GX7CwnY8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:55:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:55:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add ras ip block name
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add ras ip block name
Thread-Index: AQHcSjTRKLhw5hMaKEmGhahFbv0P+7Tb86cA
Date: Fri, 31 Oct 2025 08:55:19 +0000
Message-ID: <BN9PR12MB5257CD60BBC56D2F8AEA4C1CFCF8A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
 <20251031070435.2612918-2-YiPeng.Chai@amd.com>
In-Reply-To: <20251031070435.2612918-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-31T08:54:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6383:EE_
x-ms-office365-filtering-correlation-id: 9dbb669b-cc34-41a1-e0a3-08de185b3860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f3vwkoSJDuiggGHhE4DsmdIqRBe0EOS+EsvfcuOWh+UcMaaTDQqjkfEdJq01?=
 =?us-ascii?Q?NlrwTRGDDsh4JXwFMBe1MMz4upGbqCRC/mEuJRmGF9Gl9eyWDsteGxHxGj+s?=
 =?us-ascii?Q?e9/NKnNgxSgduTu8bLMRFzxkoSZv/jPHT5z60WPfIACe+SICyNNsZlYiqH2d?=
 =?us-ascii?Q?JlMy7CBPdHxJxYd9MoSKLcMayld12HOVY5SuJ0B2PFgxXHEEKuV5iuo6lmtd?=
 =?us-ascii?Q?BubzH8K5SVc7ajOYtgot6IukRf9ECdNoIcU2WPSjuxNFGCMciI1DenWG0K2W?=
 =?us-ascii?Q?1hepLii1nnTZZ1MefGhvFZ1Q/eGdpvdsrsN49y7kRm3nx3vn3oj9VYxO0nPB?=
 =?us-ascii?Q?70IGv8f3U2F6WEMUqfYeo14CnWODWFZrcHOyAPD0w8TqTOw4BnxpmIo+DgxS?=
 =?us-ascii?Q?+XBxOD2Zv3j0oDs+Uaw+bi9VR7GnnmC+VTMgMkhPDpM59fNcxB4qOS19fET7?=
 =?us-ascii?Q?8B+QykBGSICq31xpG8Uvolh/7ofmOGLABZ5x9q18lfPHPndS91wdMM1ZJXDh?=
 =?us-ascii?Q?ok1FAA+nHeWOwzKWYd2qPBP5AIffLfpe1FTFnD3nidEFtO/Sv020baS3uNYc?=
 =?us-ascii?Q?OsOB0zJ9Or4orLo4Zo3iF1H2w2g2yq81NY/VzorskbECwhoXSwfk1jshFHAB?=
 =?us-ascii?Q?i/OyYt421ft4pr5en7Ruf3ryhQMSHuld2R2acwDvVghtjn4LuEJrRBdZ7g1V?=
 =?us-ascii?Q?2U7lcBei1BORWmX01zTJ0sS7s/PfDnWOsJzfqlcqD/5pikHl7Y/YUflKcxn1?=
 =?us-ascii?Q?SqM7QJFgSCx3XMuPFI/RFTnBdBt1TLKMVLb5fBHMS2BdB5Zw6qeDYfewbRMv?=
 =?us-ascii?Q?A55kBOek08e6d3N6KH0M/g6tQdaaBgLz2gBtdfhr0qjOZ6V4D/N7PHClo7wc?=
 =?us-ascii?Q?dbnajRkeQknNTCvw6MJEDDpsr1MEX2/2sp1fBOSAAPSOeRKaTvxbXDGUdjnE?=
 =?us-ascii?Q?lAoGdIixfY3X6Nz3agfM/Ye7hQO/Sgo4QqzGqCr9TojcDwY75EHoVsZER5bU?=
 =?us-ascii?Q?PbHxbGoserWTif/3LVhoOZEEndAjgMMw2jekrfSMEG9bHsepwvLlNZoq3twy?=
 =?us-ascii?Q?ktY93c6aeh3UmGS7G0qBztN0ICuIZjVvF2FMkf1Tlaa5myoraDYm/hif8jbk?=
 =?us-ascii?Q?qwjWGTQvryoA4AgOo8mBIFKOZhZJyOS8o4EgjEkt9peqolpvuWUk1XSslp61?=
 =?us-ascii?Q?AdRREa5PyMQiO1OrALdABb5eBb/EE083m6LZ5l4KoQ05PlyY5B6uCBQ96Mjk?=
 =?us-ascii?Q?wYk5FHnTk8M1GT0z+9QDf2qwf6iwJmCIVnxYYAmVgbDl1o7viIdfdLHNWHEW?=
 =?us-ascii?Q?ldIwKGR9VhTFScwS5EOwzE91T6k8gfX/GF/uzaoNZ4RASn4OzBSRZecetAr/?=
 =?us-ascii?Q?+i/0SgbAUlSdWJal0SOC5VIDxQRU1Mdhrwsk2RqMRLA6+G+iAAzJ0jrIwE4D?=
 =?us-ascii?Q?nVaqfUd66Ln8PouQePQZ+2XiCgaMVGpMYhnJtND9C+jgGEL23H7N8I+N5cSA?=
 =?us-ascii?Q?3mj0rA0YNVe2R84ilyqZXNgi4lAWomxPFm29?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KvjdNTrsGi26OspincIKH+wFmt68k/xt51RIpj5Se7cCvynBrAb056HmbH8i?=
 =?us-ascii?Q?lUY1OXxbM8reEtO+nToyElcaiZTZ4zJBJ7aYN68w0IWp87fYvE73xPBk1C7p?=
 =?us-ascii?Q?RYdv8VxCoVtKXP6ZWV8l0m91M8hu8pcXqAeyjhBbguo6rton2TtLzU94nrJ0?=
 =?us-ascii?Q?hoJ/I4OV8mwWihkzP0Kx4irDBhj/8tU471WqWHXP4G1BZWMEZtdk6lVkbqmO?=
 =?us-ascii?Q?mS6fCcn/Gf3s0N+U1z4oAIyN7Lg5Xtsn7ltmSGvk/PGII3HBgpXBv2Dbvk22?=
 =?us-ascii?Q?bey85bciMlBHD2KjFy1i06AmPt7oAVsatn/viycJqs8M6WwpsCnOjeMRPDC9?=
 =?us-ascii?Q?6ePOBkQb13cWeqeLp8xGRXrwfAj1W9/CT4XJzRU0fBMrQ1lWByyZGv5aZbuG?=
 =?us-ascii?Q?9nPDyNVk+mpfotCm8xHZQQ7ONUeZFTtoqeFRdqhypmm04HjXzGDxie12TXRG?=
 =?us-ascii?Q?taFAhQNlPHaB6k6CJFUaiIP/KFllWEacB7pok5B0AGXqsEOixrcVhfWnT405?=
 =?us-ascii?Q?XkAdJKWrdi6sNetYldiUnNf4eTljIo1A5HhM3XwfiXezp6c580HAFz/PTqcx?=
 =?us-ascii?Q?254vVPz+4oK/B7WmLD2dTMGGaJmkrp8bB4I6E0U/r36/QrhKhMo5Umqqh9Ni?=
 =?us-ascii?Q?QDNOWvjyqyRsltehGUUyMGlUF9zKVJyOXpTLzlNkBCm82tepL33KjaKFCHCh?=
 =?us-ascii?Q?U1MQxAvVNbbCWFcq9MhAuZIBBGjx2ousJkb9kf4D5zcdlciLurQ1DFpwvptV?=
 =?us-ascii?Q?Rf9q+xiFGkpBVWCsPE70WQm1MCu2EgyFpf6pTjLaSeqwoR6z0H+l6Jwin12H?=
 =?us-ascii?Q?zkbwF3OmXoTvCMU8+Sn2CrwwXCN7IwTnwAfyBjc8j/p+hhmY7qr8mQLOmm9C?=
 =?us-ascii?Q?comdLqSid+kV8SqSb7c4DpB/mkxOyXZ6UH3mzDjoSYfzpgNcrlsjDXU9zHPC?=
 =?us-ascii?Q?dXgc8ZCjC7FJhY/HhdG3CyXBJLvx18eXi7+U9PGhq1/qrtvYmaIrTaxbbl0A?=
 =?us-ascii?Q?uBLkWLjbj2S+BB/Iu4+x1TZZ6GhfFyjW18ZNTQBmmHA5rYpHbcfzm1KbEVK5?=
 =?us-ascii?Q?IDTEyqYeSdsaaHcUbrkwBf49A/UzkKgZMg6y2MZAo5vsWKKaenpE41+56sxo?=
 =?us-ascii?Q?65Jdj6a2YK+7VZL3NSTCRV076cBupB9565nt/6zPiKqAtI6J5KJ/2yV96gPM?=
 =?us-ascii?Q?TdzrLeLXKIUcDk5UJHTxW0yDhfDZEo8sEcNgUBsAaP4AtwH6+ble+vYfOgbd?=
 =?us-ascii?Q?B+LZ23WG9WqpGMZiuT6vKLFPOUnGXg3ejQoD1FG/VE1smK4URckB0iAD3FHR?=
 =?us-ascii?Q?T9PM/KmVohG6U+FySP/YvcWVxotuKRxkGtC/6CRA0BplvREuHiXzn7K/LgSh?=
 =?us-ascii?Q?OklsunZkS0uDAGoRX5TEGoEQalYQZZn9yFaqgMIU5QOWO35R8yUknldbpJD5?=
 =?us-ascii?Q?858VFUwmXa80KCoGNufmaWQggonf/GQeQZ/9/c6uFS0nsXlSMXuvQWJdji05?=
 =?us-ascii?Q?ChoUJc88d/nm/pIBCTaI6GHiHaIcJhdVFgc2cHiUDBvHy1Gk8Q/LWoJGRHw+?=
 =?us-ascii?Q?G+80IAgzxyPzC4i5y4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbb669b-cc34-41a1-e0a3-08de185b3860
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 08:55:19.9940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqdltBBj0WGBkqn3yCmfuLtHOzDajPIhOcbv/hnD8HshkY4VAwapn+J/ycitqWoxtprtS+mug0hoTbIKehtFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, October 31, 2025 15:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add ras ip block name

Add ras ip block name.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3dced3db91db..eee4b79a9a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2519,6 +2519,7 @@ static const char *ip_block_names[] =3D {
        [AMD_IP_BLOCK_TYPE_VPE] =3D "vpe",
        [AMD_IP_BLOCK_TYPE_UMSCH_MM] =3D "umsch_mm",
        [AMD_IP_BLOCK_TYPE_ISP] =3D "isp",
+       [AMD_IP_BLOCK_TYPE_RAS] =3D "ras",
 };

 static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_b=
lock_type type)
--
2.34.1

