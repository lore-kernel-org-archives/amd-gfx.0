Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9240C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 06:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5EE10E882;
	Thu, 24 Jul 2025 06:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDIx6m7m";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD7B10E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 06:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz0swC8Xm4oticUEYpmFe2fz963OJvjFo+E9pxdD8pWSV68uAOge8p7YAyOnms4lC86C3AvnsTV0uSSf7o/NTz3T4weD8KaDj4vHEAjodXvciZTp6Z46DFHk+rvw3HRT2z6C2KPfpPL2RMNaOumH8WZtQw1F/ebyPi7gc7LWkumCQ/P2s+ltuYM2VsgfSL40ueDv/RcI3rmeZU8kG6vLibp13yCKng4T/0iLdz96IcePLIlW6a5n1HFfVj/PK35WfjE63PJeeMQRuFOJt42HuqcUT9w2iWDluTjQfL3uYBdh4vMNOlV7Ew5/H93QfQkGo+WmOgu9BbnmSVoHb634Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPLgJ1k52gMzRPtk/2MAKWDM0oD1ZciD88FyxOhcRUw=;
 b=qpMoLJZSuS+Z6fefoU/rbKEftfCZz64bCDH8Snx6Yf59LBPkSrUFmpPAa/MVYSzFYHz8WcJWxhLxlH8fIwt+tCYAbeBoItymf5Wj/zIzU1jjLKaVv7it31vcy7Agf2LRJOE99TbMysgjjDemVxAGPtfcYqZlWEjQpRe4kQqavXPbUqnox3EOJ+5jznIJCE0PqbeifytOLZkhxzqjeMK88vbYTxG9STb1xmxtp468E/rxe0D1+mGWtfcmZhEK3E5a3GZBopY9o6WGHfmGzxksc0/oz7ykbSrxpWuMBqhx1VhU8faDqb2C2GOlupRGteZ4JXVmxqR9EP6v5wiJHfMN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPLgJ1k52gMzRPtk/2MAKWDM0oD1ZciD88FyxOhcRUw=;
 b=yDIx6m7mYf1emHJTJx8o85JyRT3hf2oKQEdCFR+WU8ulhAn0edF1y9xoPAqsmmf244Q7ScGlEmb+iQbQJ+ygNLa7xrZZKAFim4chc3kUngxqASwsK0Xvmrty4yhIef9FbwC+OUCajUg3c0jwEDTGvmvmozytpmKgsobJIPtxVyI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 24 Jul
 2025 06:00:45 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 06:00:44 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Log reset source during recovery
Thread-Topic: [PATCH] drm/amdgpu: Log reset source during recovery
Thread-Index: AQHb+5DeedtCH/PjRE+Q82dPRziIsrRAyWvw
Date: Thu, 24 Jul 2025 06:00:44 +0000
Message-ID: <DS7PR12MB607199B57F65F4F06E318A0A8E5EA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250723051526.1596437-1-lijo.lazar@amd.com>
In-Reply-To: <20250723051526.1596437-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T06:00:36.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ0PR12MB6832:EE_
x-ms-office365-filtering-correlation-id: a80a7e5b-d4b5-4a89-fbb0-08ddca776dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SO3CXf363QPOIVBz3jnaURZ3XHZTrpDTois91I+L1qhU9b/6awKCJ+Y4j2G1?=
 =?us-ascii?Q?I33+gYY+Gahk3rkLE8iPWuCLOTn6xUfn/EfmMhLLIfBVOrJZGpc6yrFKk7Pp?=
 =?us-ascii?Q?dqAPawK8Jbw74beID/+Drs+Y14TZgj/oye86Uqrn7QpQqckVxcOhoYxQrtDk?=
 =?us-ascii?Q?63YpI18l8Nk+2L31F0jzbtUkk6/LVaEu8vUacNQQZGNPYhwulChsQ1Xvw2M5?=
 =?us-ascii?Q?chKBJvNd0Lqz7pM+SS34FIWQ3HSb193WSL2/c083iBu2XAeo69A5ewexk6uw?=
 =?us-ascii?Q?5Bm12um0369jlfn2YHcyI8Z4Y8NZ2cPVcCll8sHFMpZ6C6SlLxFqQu1r1YMs?=
 =?us-ascii?Q?01JEqB5/BWXiXG2sjNBwpvsDLJLwpJsfN5Joy39Ap9/T3xna10eo09/Pq7wG?=
 =?us-ascii?Q?/1yILlgPX02rEQph0dbKxlQaAwwKoNli/5iaksoF3iqXcUka2oKki6InMgju?=
 =?us-ascii?Q?8YO5I1nlLdIdISAdXH2EZ2Mb8hldAYXLgDbUzjIz6/OxJ88Z2vq+Zq1sFyM7?=
 =?us-ascii?Q?9BnyH2l6zqMhOK6vh5gPSSMVOT2VdPublpncGQ89IcwEkzrOYms3MtYLeNMR?=
 =?us-ascii?Q?PVNVtwuCiZX44u7XuSz1370zFznjglEjeCQEDCtYJHhMjwBlu3fLzZva1m3t?=
 =?us-ascii?Q?nCKMWAdePR/wxABuS9nUVpBWNr0R08pzF/0yLf6Nv74Uy/0VluXaKxD/pegk?=
 =?us-ascii?Q?WFm9Q+MI9fNHvTb3KzAKzbdGkK3UwE8Lr8vK3C/ZtC1PsbUyFjtGqx/aSqfJ?=
 =?us-ascii?Q?vF3F2L0ctyqwFcpdOC2LyKEqcCMq1RUjzcHI0oTV5FOBzw24qyHuy1/aUiTg?=
 =?us-ascii?Q?5llfif7lk+92KOkFWlAJcqzI6rgVOdMVVmJ+oqge5H013FjCsb2D02bcV7E8?=
 =?us-ascii?Q?qJoqEptVbMXz/UXuhmJfE1K7N+FqpKp5OvIZpjTRsqi9LFUVdxusoYZRK6RJ?=
 =?us-ascii?Q?W8OEMnasa/GE/S23Krb8bH9scC6LctRkKVqMnsHVCdTBsv464ZocVrBLIe1h?=
 =?us-ascii?Q?F2ckqLNdeK63SjLAPc+PK9+25JXHgZrDyWQSmi7dhCs3qm2j+wwEZpcxco0U?=
 =?us-ascii?Q?aXBh91UMUJ/3sptnuTNKVqxBYbd/cAzRmRFuPFAG7GtRGx2q6pLqQTHURVHm?=
 =?us-ascii?Q?JLP0kocwzUtVrpblhCn8yX/aN/faMnT8N9QZ5/YMAeaa77nOTsjgwj1AU+kp?=
 =?us-ascii?Q?o1V2DrhET53cxbpliKWhbrk0eYkdnqrP8rk3ow6xBGfFNpTbmRfTpQU37Kxf?=
 =?us-ascii?Q?9kQUty53gRCRPDfDnlFPPgoWuZ+E6JKx0EJcacC3g5No8vz0C1+qCMsmSjo9?=
 =?us-ascii?Q?R4rhl503ke/+k7lgbYQaUy8aBtX5UrI7ako2Bjfurl+MN+OkamOuOmmwEZwH?=
 =?us-ascii?Q?iZKL41bG8XJ56yDPfR4CoN12kKtOA68/TCxecHMO9kZhsUhWFQpC0CEtfOB6?=
 =?us-ascii?Q?zd21PNyXrXR1Ivmb/svr9G885rp9XCR+D5iRm48RTD/dPB4bWPXPwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7rvEC1CRf+YCW35/TMpjZRmkoFOEbpZy01ORojzMM0nmRIYKRqqzIggsjZ7b?=
 =?us-ascii?Q?37UmL1Q0UUkQMOA2ZFcDySyQJv6oRV4bFvFzemsVlKzMEwkVRDTDpal8IzUq?=
 =?us-ascii?Q?mi1XpKRfWgt6IUbU2FyziuOD+kwZzZubijNy4LkdFOUGj+fSdge2gHvt4G0F?=
 =?us-ascii?Q?a7A29kpMzDkg8uSkxGbWFS6CvjLgA5JnGALBTPiH3F5YGwaGSPfPixzH7NAM?=
 =?us-ascii?Q?1Y4sBF52inxSMs88pSAExUEvghhatl/+FUpboaM9ASy6r1UuelPx9lcoJD7a?=
 =?us-ascii?Q?JUJJdYqByaI0DvrMT8feR8UxDqf0/+cWvviLYOamNrGr8b/V2S/L4i170axQ?=
 =?us-ascii?Q?KTEw2NQsNyFfk2duqrfts4tV52wdN5n+Ev7c9Z2AaPpULEWJ85G8h84yJTWX?=
 =?us-ascii?Q?UbVcKa5xczJZ46flxfr7o3Z+ZRFRiq8iIxvp5g+me9kpcd2OgM4ntU4iNVPi?=
 =?us-ascii?Q?ie7X/Q24x8+SsN2wgarsLRMLjuMrBDdA/MCbP5qISMLMYZnbXDdLiiicG4iX?=
 =?us-ascii?Q?KeAcnwNk9soSFIAPmt9SRJk3ecgK/pnnjhBoLx1X/FOOKx6WQW4tiNE76FHw?=
 =?us-ascii?Q?UAI2pqh4wHUgX690kcua4hDMzLtHP4yFCExo9S7iKhN4MGe77Bjx5fMsOGOl?=
 =?us-ascii?Q?MeSOejYTrMsvUtcegssVHkQ3bTiUWGB4vS7eQP4rSx1j2msIo6uV7Ixuv6iJ?=
 =?us-ascii?Q?p6If+QjdD/K4CiK+J6Tjcyhf5ancv0Q9uRHqIFHHLAtyCeJrEPh7414hb/hn?=
 =?us-ascii?Q?QTAmfeJEbkUJNjRWHAjmqoAvG7yp0TeBZsUhlwPcqgdV7v1BvKRZvdMK96le?=
 =?us-ascii?Q?d2dA1tN25BlZsQxl1e7umCOcNYFP4nUagHY1n7jB196IgA4tpu+jouVlq4OI?=
 =?us-ascii?Q?ZA7H3Wnso2v6uIzD6SuG3FUvbpIzOiGkt6jegnyhhBH9Y+0tEmoLCHy/m5ZF?=
 =?us-ascii?Q?RtHbTP/Hx6YRDBHEgONjQVGprZExE/oM7MIFglqofPJiaUTY4jQodp5mr4Q1?=
 =?us-ascii?Q?a6begXJc/rUQzetxpGtX2MKoQ9xpco9LFE1oNlCWIurMVGes8EdCGVJgmc81?=
 =?us-ascii?Q?lLH3VHYfmI+z1Y+JMsCrM4i5LYH4wrqE/PXJergzkRn3IA6sLIktwc3/YXcW?=
 =?us-ascii?Q?1F7CF+gVx4seKs7djVIJcFgxJ8P3hXSXYl/EmhR4p+G+Kpnr5RvfGqA+eXyj?=
 =?us-ascii?Q?eQ8mVj28wlEKdkJ/Hze/UIpio4kB4wKoIMHP0GPcqox1riEf5J0jXs3ZX/1f?=
 =?us-ascii?Q?yLAZ5syBpHdRkq79SKXxT9wCj8XJh9HmdtYaSM9ToPCyZLKmU8pKLlpKGuSa?=
 =?us-ascii?Q?NQ5ghnh7fX0zlF59ReG/Th4JUO1tkf1RL4wHdP7U51sbxEgHo6WzPWTcXyY5?=
 =?us-ascii?Q?HJM088aATeROmEj9oy7oKn59+xuzTJ7ahznbo7HsPYl52YvAtl4h2xAUA2Ij?=
 =?us-ascii?Q?KRknviCaLcA+p497X9OvSZzx54+EKn7rkPcp23/rSf84lddR0JuDL2bRKu6K?=
 =?us-ascii?Q?8L/SLoMa6iaoBWJvgGHOVGrrAHWbH3xnvomHISY/KwJ/7I3dw5s+nqkrmDTq?=
 =?us-ascii?Q?cd2T8hmpBvqKeY4nRWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a7e5b-d4b5-4a89-fbb0-08ddca776dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 06:00:44.8042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XP0GjEFr89A/4e1lVJWD772UjbL7a+IkBx7KxT9Z7sLmp3mPsd7f4gElXxQUWQC+RNphtENHCUtLqpqWxDx97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, July 23, 2025 10:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Log reset source during recovery

To get more context, add reset source to identify the source of gpu recover=
y - job timeout, RAS, HWS hang etc.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 685cc602357e..4fe74341aa13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6442,8 +6442,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                emergency_restart();
        }

-       dev_info(adev->dev, "GPU %s begin!\n",
-               need_emergency_restart ? "jobs stop":"reset");
+       dev_info(adev->dev, "GPU %s begin!. Source:  %d\n",
+                need_emergency_restart ? "jobs stop" : "reset",
+                reset_context->src);

        if (!amdgpu_sriov_vf(adev))
                hive =3D amdgpu_get_xgmi_hive(adev);
--
2.49.0

