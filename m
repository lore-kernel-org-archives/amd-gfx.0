Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E488DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D14610F130;
	Fri, 29 Apr 2022 02:45:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B8D10F130
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRCVgmRG07SPvNFxI+Lw5YOYE7sutoiDWAQRToClQ5DMNGzKLh+tqg3Cki4SChBvCPs0fBrjIaGCDD7RCPqmU+W3GIEZyRhMOmKumxdSMzFu+B0AwyliUm1UBDQ4Sw1vG/cSBjAuir5k00qCPsEi4mhUMS2peDYqWbTia/HZINRQfGcGqkYxOqHXe09KlrTcP8myrB3nsLQoP3uEAKWHEvm2pgmDCz4bJ0ngLYVSvdds2gqTwqMe4KyJ4hnQBY7bFg2ClWUGlU72TQ0UA8SjZbh3wcSP00ZOgw/Xlj97iTx/FiXyJ2hrHiBBfA0OOIx48HGbCglfyzjnoalG7Cot5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/3OPlVLVPAeNSLewdEsUgM6HMEtCDp2Zs2NgHPcrxo=;
 b=lx3xPsVZXoqkeqJhaX/1tbWe7yrhD6Qsi4Ho/l7PDC7HGNev/v02X9RM9rrsVhPvualNpoZW6k9a6Y0uzNR95r/l8qKLIxMWnbL18hFbDHF41YbRJhWDJWwhKrgkr51lHz6EOy5h4wwvCm+O9ZGgyJdp6MlLGdZ75SId2bwdJUFRLncSpj1RvrQHeZrzggwrsvkMzmuhtG7pfxmfnpsSW0JbDgFoQWEPRgALvbgqpezLj4mrCCFYZtZbmbn9cQvFsQr5T1TR9B0acA3f7ePmtriBjnJ+jLPBG07aovYnA/iIjTE1ClzYOtHzEehEJK7IUBkTVFK+fCzQayUgmUvs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/3OPlVLVPAeNSLewdEsUgM6HMEtCDp2Zs2NgHPcrxo=;
 b=i2HDpyacEGm2f3v+wLbyf/9IaIVuKYEj45xHr/l5VF2LnpD3FYoRaG3YXl5xau7ummdlCt6HFck8HkrlAwir9C5yfQPGaHBb7FgqCnyQ0nMzLCQKHs/P7UeBWWHJ3Pka1XJqJDgLJuFF213peqabnkgdz+xUcfRlZnNc0yU9xfI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 02:45:47 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:45:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
Thread-Topic: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
Thread-Index: AQHYW00x+XGLa5J1Pkq3k90Oc3b6UK0GL8Aw
Date: Fri, 29 Apr 2022 02:45:47 +0000
Message-ID: <BN9PR12MB5257B44F0894CCF171E71783FCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428221311.1030146-1-alexander.deucher@amd.com>
In-Reply-To: <20220428221311.1030146-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c9447ec-5d05-44ad-8d42-32f4975e5e94;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:45:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b587c8-5607-4ed8-fe3c-08da298a5d87
x-ms-traffictypediagnostic: MN2PR12MB4504:EE_
x-microsoft-antispam-prvs: <MN2PR12MB45041A0DEC5287C00470F3F8FCFC9@MN2PR12MB4504.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QqCoZ541Y887gusof8s8ajRf3wAEskVClqA/vDecWV1Gcil87g3dMd8ziC6dROY8M6KBgR+Q/ojmmhFrt3OLya4LylJn5cTh7Aq14V7pFAX+z1w61ulBnLhRpoX8PbpaZ+KFZ3MGB3T2jHV1Zlz1x6bxA0ZZgIQDIv6i+ObuEJyETJlhGznjVDenlFYNaZ+JWA330vSvfBqte2cRaFMeo2OVGMO9EZN1FfV5Hb2lrhJyFmJifE2WCupy2onpq7dVAiwPz9nMqhiDpgCgaOP3JdFDgJSVhX35JmwCgU/S9Z69b4SohhE36vwqHbsz+eN04uBmn5PWSqXYNc4d9gusMve7RWkNb1twgXvT1ircORxFFHV+kZMO75/G4QI1czTd9KbyNUX7xuRJ9mhbpfW6JjmGwUoiGsfUYVilonu4ipc+kT5Mb4MaaafKaWWXZgtENFcdn4osmL9bUYc5khUb1alNxKjiczj4jJ23nP8GevlYfnzBOeUX8cVcml6T8zqtuFkn0wT4/qRdj34iZDaa6tjpP1gWkdsa0voYs4N0GGtHE2yaGbesGwyFSh/2mfIbMxTY4XiblcRVvYlu1NdN6yKWYDfh9jyutkKA+kLkxpHaZ2PjCj+Up34we0LbXqqAA8ZW+7czy4j/8Kq9eOwvUD8Wokgwp/xXaDAzFwasp8/w3f5Z1Iyqeo0qUTzxewQo4dQ93s3Yl6pnonZGLc7vFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(66946007)(8676002)(76116006)(66476007)(4326008)(66556008)(64756008)(66446008)(5660300002)(508600001)(52536014)(8936002)(2906002)(55016003)(83380400001)(33656002)(38070700005)(38100700002)(86362001)(316002)(9686003)(7696005)(26005)(71200400001)(110136005)(122000001)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lKJF7768K/xMD6yWD8qfuWxKuIetEcWFcP2fbZGvGwNdJXc5jDKXx0F7QN1+?=
 =?us-ascii?Q?6b8Dkt/CPLmEUfYTUFZfKZr1XSYz3k+OsijrEC4aZrF86TFUizej6GZVqpQ4?=
 =?us-ascii?Q?d8RSxx1BXLQz6UiV1zAnJfO7vVtpEtrz+N+au+ET4rgJTnMU3F0Srx9bwv35?=
 =?us-ascii?Q?NvLLg2Ie1Xd0rAttVQkQ82jOWX8JlzmbJKdrT010XMXXeN1f1wOWWpJj4CZI?=
 =?us-ascii?Q?kbuIeDDnsBYt5J6mDpiyl5LN+gaKaBROT6fdKPza1atzF/7vvnOne/zs9q2l?=
 =?us-ascii?Q?cRks0yi4Bhla+RoTmMedi9yW0KOgfon4MzHmYvl8vidx5VmUgPTrcKd0i4CJ?=
 =?us-ascii?Q?NOpoMjOicRIC6PcXW2IiAZFWyiH9NJPKB6N7cBLZ+tTNbFYs/kxgNc49l0Xv?=
 =?us-ascii?Q?AcYhSWfYAILZKWNO8x8cLw4BSQ4KsVcqSLSFoSvT9k4AfnY/XPAjCz/QnRL6?=
 =?us-ascii?Q?FeJSR8A75ATzikAnzRpFOHvg/CgZxvqFSssqISNRBdKfL+WwWGINPbKJZW21?=
 =?us-ascii?Q?wRVNRohiIl6Cyb4IME+j5WHcdJh0jOrp0/ZGICI5Tqn3sCZr1rzK3D7lRHNB?=
 =?us-ascii?Q?e0D7DcCprdkjgkDxy8J15CPZEBHcdJwo4g57vBYoC0EJtNiTzMZeeTM6yURY?=
 =?us-ascii?Q?wClBEg3iz9RidNeaKR25fphQr0IAAiso5bPiSsPQfBewmrdJ1N+mARLnkJ8U?=
 =?us-ascii?Q?0Aea4j3naPvZahRs8YaY/KtIUE0POk8cMej6xewnnfiRcubpF92QZyrUaNoR?=
 =?us-ascii?Q?f1frjKhZLLdz/MiAudkTaX6AR+LbToxXZ5TLc4N4QyuN5fiTyn0hLfuW86nK?=
 =?us-ascii?Q?3h/sUejIKCF7MPXUk2fbcgBJ1WJ4GWoDldtvn+MZX4jq9AF3yVNojxqheiKF?=
 =?us-ascii?Q?Ulvl2IjwtdMQ3+URO4H1mtA+qgX3U6HX6f59JXSJxKaLUyKIQ46sXOsG9DW8?=
 =?us-ascii?Q?I6yZ0fS2o+3++4NBUZpRE8LvtVZPVYoZtBICcbq36vj8e333QdxlVr/yosWy?=
 =?us-ascii?Q?AT6zPeE7C9pEOhbGR1tbCZxwrpSvHHetstWPE9rfzq5BLlhW/gHqRsidq7+M?=
 =?us-ascii?Q?gtK8w7UdWQBKaQ9Q5W1RUSdtIqQHjaw5aO8+HPiHcpATHnJ5xtO+RfdlbwCn?=
 =?us-ascii?Q?5O0iVZQtF9q9l/CCiys+NEMqoNfx4faEjQ7W9Gz0IIlLdSFY9BaINXGOnRZ2?=
 =?us-ascii?Q?tuur0I2sHcSP2p6bfmpeFC6yUZeKEaJaAz0Bc4PFsq+kBLR1DhxGX6BZslhE?=
 =?us-ascii?Q?nbRkAHizer/S6BoradaK/9hU1hUJWSWDf4JJcTDn/0chA2gpqPIhOVkssnUL?=
 =?us-ascii?Q?O0NA1VTg1IhU6lgu9Zal336o35xmBiki1W28QWFJvKf3wrfIawhukuY3Hgj7?=
 =?us-ascii?Q?fyseAPSarTyTbw78+6PCGmYcnjXEU8pG84S4NXtk0jK5A0icDjFz8gKUCtbp?=
 =?us-ascii?Q?qoXwQVlabyx2Tc3fISJnTJIYsWoqlPAT3k4QfNoM5tPdDIMTx/3TlaRvKbrc?=
 =?us-ascii?Q?st2P5dnZC7IdUmd1MvZYiktwiySAVBW+q5YP4tmTeK4oOgo0/mKClM+dO71H?=
 =?us-ascii?Q?3UlI8EW6eO0N/9TbIkbEnx003aEOUk0yzmBj9xA3+w12hDKQBFCXaIua3qy3?=
 =?us-ascii?Q?g5//N2OZllUwqWR1wLCzZyefU/gf7UaqyMWuH/HbLJo1xljlJuTqu9j1clIO?=
 =?us-ascii?Q?E/fHKJ3DxOgfyGkPiwglYwwHduQMrEIuJdG4OgCVOWyiXtxLSmSDkWYIHmQZ?=
 =?us-ascii?Q?MLh5luVKZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b587c8-5607-4ed8-fe3c-08da298a5d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:45:47.7141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ep0z2af/ZX0AffQMXwt5gf2LRhlPZIN5NwbN96wVRg2z4sDdk4pUm3LrlCFc8qFVQ3ks9ilUZpfo8xdGX9WZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, April 29, 2022 06:13
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB fi=
rmware

When data is written to VRAM via the PCI BAR, the data goes through a block=
 called HDP which has a write queue and a read cache.  When the driver writ=
es to VRAM, it needs to flush the HDP write queue to make sure all the data=
 written has actually hit VRAM.

When we write the DMCUB firmware to vram, we never flushed the HDP.  In the=
ory this could cause DMCUB errors if we try and start the DMCUB firmware wi=
thout making sure the data has hit memory.

This doesn't fix any known issues, but is the right thing to do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a6c3e1d74124..5c1fd3a91cd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1133,6 +1133,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *ade=
v)
                break;
        }

+       /* flush HDP */
+       mb();
+       amdgpu_device_flush_hdp(adev, NULL);
+
        status =3D dmub_srv_hw_init(dmub_srv, &hw_params);
        if (status !=3D DMUB_STATUS_OK) {
                DRM_ERROR("Error initializing DMUB HW: %d\n", status);
--
2.35.1

