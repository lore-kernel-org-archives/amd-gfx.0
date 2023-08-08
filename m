Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE8C001DF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 09:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C697210E107;
	Tue,  8 Aug 2023 09:34:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC2110E107
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 09:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP9YGn2/Iw/8bbGifg/b87eJqTajB1A/QyyqOuuizn5lxYDjHU4eKVhlNjdD6DB18HeCwBODpE39kYwUo+TEs4o9siOl9n2hNG7v0n042xXgGbwi1OvzvwZ69kIszj8K3tOmwSyi8l1OYaozWQablNDEuk/7Z/bbK0p+sLyx5FxodxDIYrHfd1SguJiBYGLP51aLvt4Y3yXP4K/PqZ7x2Mhb1Pdlo8PqGhdrWlqaPKpg3rPWCI3g959FPGKUV6Mwze3bcJ6eNM+TvjmzN5mhQKnfKiUZM/D/fFIEf5E3hGHOpLo5HkiC/v52sMFhEJf7CWP8F1nHY+zMGx8kKE6Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbcawd72LsbiSGiNx8o0By5KltZeuQZejuTYAWCb+ok=;
 b=OwcVep9KEfhhrmEbfjOmlT8WfC3KzO4g/AAVwMYN7wT7AogboKYmJvr7cWejPURjB97zKf91cmm7fEmffguVvZlSlQXO1fufQGIamrZmt8vKZXw+qRc4a4CeIBxJLoJuiMlRbOqqjkZ0xvB36ioKYeU90v+4wgf5FFZydd9xL+Z7AaVuj+JD7JpvO+6Vy9dZHfK5/fFl8VBnZ/Cf67+t361brsh/H0dNn9Afvqjmdb1d+eu/peVfSs/sNvEgdJyq4punHnYMIamZF3O5hoz11rDV7/S2wxBDND2lNCnsu9W3i1iZFDjKHVYbOCkVYVu2YDQDOg1e9rSP5H8vs3DDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbcawd72LsbiSGiNx8o0By5KltZeuQZejuTYAWCb+ok=;
 b=Evmq6AiqBK4W3s8vQrdI8Z5GdwHJvNh/Yg2igJq9jPXiqckwHGvMS7mRX0IWDroVyBBLPE7Dhflq89sCeA8sTvPeHXz0qAEc3XfzPD8K2XLdHVpbpordvcg/fz+EP0L/yPj1qEeG4CJTJrkDx6ulLThKp9jPyS/eDkQUVfZ8kOI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:34:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 09:34:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Extend poison mode check to SDMA/VCN/JPEG
Thread-Topic: [PATCH] drm/amdgpu: Extend poison mode check to SDMA/VCN/JPEG
Thread-Index: AQHZydeC/DoNwkOub0mz7tL9TFZ2ga/gI0aA
Date: Tue, 8 Aug 2023 09:34:22 +0000
Message-ID: <BN9PR12MB52575FF73F3B521A809CD4F6FC0DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230808090421.1998382-1-candice.li@amd.com>
In-Reply-To: <20230808090421.1998382-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=198e382f-3efd-4aec-a77c-d9947ad7c570;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T09:34:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5040:EE_
x-ms-office365-filtering-correlation-id: 4e1dabb6-dda9-4951-0dda-08db97f2a5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpPgiX+Dpn+bWiuUXxsB8/BWChgAP3pouTWbUBE1/D5vwwmMRALapRy8vTDnTq7aBjRr+GbjvBuLDt0FoaeO8lA7aQ+LgD8d5xjjTl4K4Y1cpTvjqQnURQThY2XXom6XOAqpY6YZfiKyA/eHRHsYfEQMwWEv7I8nQnjTEi5KHQcHj7YyY7Iv0cAmgU9si+b68SW1jiyOyBRcNxKl+xNSMNSL4jV084crLMZVfjQRFc9wn5nmzlsxjkqNNKez4FS9Az6XBO7rhTbDamEADKASQ6NureACcBB6bLamHtLmmgxH6LRHzBQEjfxwLMFlRQOWw4owuyeG4omVUxauBKIikS2IM5M9ztKxxfJBF0IouXNw9PeCpANMh5vNtSq0quqwNbhS3wVciL7Y9hJfalzdMHFyO4Sax5GsyW7gkxL36XwHy/XX1GG0FE+Y/rDjAKi/5hABPB86+Qk0nupI9UukMKHxn8xfy4BmMjje021sHbPB02MiSlhpyYD7ZEVLQ9JsBVCfyy4FF4y5MRtwi0UgpfpTpwPY41cDa+8aTSLE7jfdkNhTb+9kBO5yApu+uuQ4Ia8FRTOHoB4DVgPbhqzC/lgxtvK07dBiBrkTl2Hs6Qc9uZnoext2saXbtLOhrk2S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(186006)(1800799003)(38070700005)(8676002)(8936002)(52536014)(5660300002)(4326008)(64756008)(66446008)(41300700001)(316002)(86362001)(83380400001)(55016003)(2906002)(9686003)(71200400001)(7696005)(53546011)(6506007)(76116006)(66556008)(66946007)(66476007)(478600001)(122000001)(110136005)(38100700002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iltyi5ir0hlG3sAWDjkO3xrtj7c/6o3uKeINmVtrzyxziczauLBBeISfOj2z?=
 =?us-ascii?Q?AqhEEWHqb9NwgqVsaMWxd7gYybi0oGUr1Dmw/lTHkBlLJH1ziun1tOv2ZhAt?=
 =?us-ascii?Q?QKFIXv/jTWyxW506hq0gdrPAt/f64NONt4xM+eV7Zw3fQcpHnSPYLbM3Hgzs?=
 =?us-ascii?Q?FTmWIvCFoWyx6PzTiugdWM7zOCsEmsMH07Ssp0XDdjJ31Hm/zPq89ZoKyrFf?=
 =?us-ascii?Q?InreKZqZ0xPWbDE87i55qMYFixjjcTWD2a8oyn+hT72o5jJgIMgTzWJ2kc53?=
 =?us-ascii?Q?dJLTax9tNw9ouWRhv2XmcQGUhUCDTqtUi3xVuabAvaWr30Ezm1yEPWvqsgiG?=
 =?us-ascii?Q?PAd7XDvzFuKJzh8t/iqcUkn2uZ6luYegFxRpuvy5lEQEH8wrPDZx5kg9Srcn?=
 =?us-ascii?Q?qsWQasV4H56dzPterczwDNhJYrJmN2Q3VWZarjleCG9Hc7hhwREJs1o4uomz?=
 =?us-ascii?Q?p5Q4bOHL/9s3RUTXbjDirknFiCHYWEggZaAChfBuxO9DAUL46Jjf9HBgx+uA?=
 =?us-ascii?Q?nlA7n3EEARrh310svRz056RfbnlGoQGeSDuFp/4V8ObGJGYbxPFnpJ3bGzPa?=
 =?us-ascii?Q?DNaftvrpaD7uYPv/MrPPwpnw/fLmwAwEKSLIpVDRwYoJL0QaSMO04EklZPoZ?=
 =?us-ascii?Q?gBGmbQfk0xHyUgmf+kCfWcCWyDDhAXq+tj7Ilr90tA4jbIGAoSAHn5IDiBsN?=
 =?us-ascii?Q?cGBb1UrlOsMSiOridS2bxmVQxpXmyezI62C8d7jajqsoLxyjtHWJVREQTdlk?=
 =?us-ascii?Q?hL9NiwwDaqoSaayAgxSWgi6TM3s7lj++I73VZvwwoZHWoNqvb9trLBBpmRiU?=
 =?us-ascii?Q?vchc0p9eauo3XNXKOhSFHUYhRTE4RcsngdYm3aeyIV1K/lX9wGAcXpaJPGdK?=
 =?us-ascii?Q?Jv8Z5TQBqr/VNIWn6YwqMSEqFVSvRNoiubLYb/oyfsHIFcK/kulnEL07O8G0?=
 =?us-ascii?Q?DCJ8/3tyIb1hyjib1ceGhUZoS9GcUtV10vM8iG/NJ57APEcpHVdusJYpkqzF?=
 =?us-ascii?Q?rkW4chnz2eKaPH+W3mmriSdloe4IQuA+5mfL0aTz8zxzoelkTw4rbcX7LBTe?=
 =?us-ascii?Q?h0XbpqZ0zcUFhYVWZ0EhlbbH61G5iIUw5wJDZiqZTupS3xBVKJzpFLmlIvlc?=
 =?us-ascii?Q?4bRWDFK2FO4IHxF14O6x70DwXJz2RHjSk4GNP4viCtg3Hf6FULsoCZp0GCR9?=
 =?us-ascii?Q?1BGuV1+hXo9lCvQkdyDs0J4RkXX2cxnygI6PO9g7BQVnyd+dkXYbAfUb1cHh?=
 =?us-ascii?Q?VJf2wFCyK5WiDveA8E+JLb/TYsUte3+W2ezcL+jLaMsmhwjnrgAob9kgSnSu?=
 =?us-ascii?Q?uXW6fRBhti9sA/uUXUyHpgJjaZ/W+HhBRe3EFeqZxdOxljVYxIbLDX61npw6?=
 =?us-ascii?Q?uvr6ViXGS9o4DTshYTHKjDUgxiQ7Opj+pyjW6rBCKiDgTb6yJpPAzS5K+pV3?=
 =?us-ascii?Q?WhwY6JSW6H/hx3kRvbND75VaCDf+Vcsmzh7f9yBEB6xhl9v1T76+3sVigxVd?=
 =?us-ascii?Q?uoF/2qVKMH2n/DuTk2klbEf6qbK/2SNgyepsgD5BXODFcMG+8yYFoHKV2g?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1dabb6-dda9-4951-0dda-08db97f2a5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:34:22.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZofyNH4gl5z+9PpiP9Gzs75DeoGjWVOo2orC8dxyNbL27ynwksBSCJshXTWZRwkFsTgtLwWcUADjPxyvMXkNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Tuesday, August 8, 2023 17:04
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Extend poison mode check to SDMA/VCN/JPEG

Treat SDMA/VCN/JPEG as RAS capable IP blocks in poison mode.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index bb29cb57add5a0..8e9cd05dee245a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3143,7 +3143,10 @@ int amdgpu_ras_is_supported(struct amdgpu_device *ad=
ev,
         * that the ras block supports ras function.
         */
        if (!ret &&
-           block =3D=3D AMDGPU_RAS_BLOCK__GFX &&
+           (block =3D=3D AMDGPU_RAS_BLOCK__GFX ||
+            block =3D=3D AMDGPU_RAS_BLOCK__SDMA ||
+            block =3D=3D AMDGPU_RAS_BLOCK__VCN ||
+            block =3D=3D AMDGPU_RAS_BLOCK__JPEG) &&
            amdgpu_ras_is_poison_mode_supported(adev) &&
            amdgpu_ras_get_ras_block(adev, block, 0))
                ret =3D 1;
--
2.25.1

