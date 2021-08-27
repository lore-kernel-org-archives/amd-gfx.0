Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D17C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 02:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0AB60551
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 02:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C0AB60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA8A6E8D2;
	Fri, 27 Aug 2021 02:05:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A16E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 02:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNqi4xL6uWJLPzut7T9j3oz5GKqlhyeJE3EfSrNPQ6NVyb0Yl3WVzGUQenI+ZEWupvpotavxDMpoHXwTnvmdS/Iq7BLfPvXP6yW4T+lkoF04RIUQPp7V6i/gXIxCn+6GBPmkedZlcQraGUSovfn6sC0XuCBOSTeoOZ3D+2Fg7uvCPNHTxNxSmhp7eFY//gCKlgs77uvnm2oExUTMTXk3UqZORjO1AoFNPsOMb3gtAy74G4Rnavmj3FIcwoGZ4rdZIZfq+7Cw8nRi1bRCOErT/a6AnC6kVqa2Y+GLRwbs/0RB9Svf824TvprPrC4sAkPuGuqWou/PVKv1FQmORE+GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHB+G/vsG6bJq9y2TtI/JB16EiiCGPF8bL8M0itcvuk=;
 b=Jc6GDkY8hCTpxfff8Js4rBL1XVFXpiRAkatS3np5W2iERMab+aguLmL62nc6/Zl7wFlg5MSHANG9+WbpqfcHVr6y9fbUCkc2Qh9nMb0V+sGYhxm5hw2guYKDhmzRmbbobgk7bshejBKY0KCjeF61wnDcmZ8roWN2YPaKRgqEsThzjAkGHoY8cuA8zwiEXBAcmztKWZi1a+j+5fqWe1t4zYu8rtgez4Nc1SmB1rwqnZG95TvxC2tiWzip3Lswz38eTmj/eUkgbrp+Igb8qtdG4P2TOZTOkupnvjBtUoEag45ZWUnxx+Pt6bhfgKGISANy/4EJNZhvcaulgRZ5OOOLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHB+G/vsG6bJq9y2TtI/JB16EiiCGPF8bL8M0itcvuk=;
 b=AG/5rnCNt+xTLas/r2EXzFRq0Efdw0vjYIHoziVxLTUd2CCSLCstybF8yEK0DxrU+i7JAMepEZcl66plACRu2/Dxipjlpa5BXypHJciVBiTBG4iDH61AY2UQ0ICv8cT3+k2l5kTvCIggGtIsWiD9yjvUNYtFrf59Tr/ikc2+Hcg=
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 01:32:29 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::64b3:54c8:3a3b:5d09]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::64b3:54c8:3a3b:5d09%5]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 01:32:28 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: setup system context for APUs
Thread-Topic: [PATCH 2/2] drm/amd/display: setup system context for APUs
Thread-Index: AQHXmuL6DwAxTBW3KEaXvsJUS+/Y26uGkLnw
Date: Fri, 27 Aug 2021 01:32:28 +0000
Message-ID: <CO6PR12MB541291738FE4CD0AF7829142ECC89@CO6PR12MB5412.namprd12.prod.outlook.com>
References: <20210827012907.2348995-1-aaron.liu@amd.com>
 <20210827012907.2348995-2-aaron.liu@amd.com>
In-Reply-To: <20210827012907.2348995-2-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-27T01:32:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e34c8a2e-5349-4538-b65d-cc851f17b31e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b70f097-6273-4f2b-d893-08d968fa8864
x-ms-traffictypediagnostic: CO6PR12MB5476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB547683ABE785A2903FB27708ECC89@CO6PR12MB5476.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YjNu5zlozJiwKWrNVf/mVhJBmV+J35koYdaxcj3VRe+l8IVQB9W7Vj6oQI1VWfzTUQ07bJwOFa0VDtdU2QWNZRCcbJcrZXufNZuxC0Icu4MIgHj2srIGow4Afjeo8gvke1O9bFOAoWZhvp3N0HZxNnutuLafzSrorur8q+uvOSou2Mi6d2zLogWQKuvYBAy4NOMo5A3MS55o3ktyYpYGQUv3hZARFTfBXocBCrwrv9cpnQ7FYtftT04nXfHGR5mgVxchYyUbV+M/ttQobr1U/0m2BCNx25vSa0DDwQkY9wq2fLnBHockgZ4/1GAMHCi9WZgiuZhmmeV2gI9jGjtW3LahcTZwEI7iCMifYoZ2OGKuX2XZ50dBRLDatXuv/EzL3Yi1M1pWBkocA2JMgc+crroqA3PxrswaBtAshxpX1aRfxO1DVgietjtkwZW6DSGZzbV2QBwIBQfNb8eV9YQ1X5/nUHMcA1PTEbgEdr7jSdXN9ctnjy+mdn8LwxGPUEBolD+oSTj3amui2ef5MuCUMmK5F6GQV0VOeAabpcYLriCWjuVvbW6+HNd7Rz6OehxiA/mU9kPKb0EUqNxxXUJ1rgKQC9g56Dz0jATs8xy81FeIa4MErf9flXeDw4se0/gdG90GTCzHXwgtbnoNh7ufC+VNFfJaV7O0BMlzz0OHNLRnJ7RfFIpIQ+EOYC3XjEFOE/toVXedYDvyJlkzMMQFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(7696005)(66446008)(38100700002)(122000001)(64756008)(66556008)(4326008)(66476007)(38070700005)(66946007)(76116006)(33656002)(71200400001)(2906002)(26005)(316002)(83380400001)(9686003)(55016002)(478600001)(54906003)(110136005)(86362001)(52536014)(8676002)(53546011)(6506007)(8936002)(186003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrznIDA/cts/l06wCBh+m86aZm8/U2B5PPL52H9OeC7zSdnoxD0ik7LroGKY?=
 =?us-ascii?Q?LCHWA4tqZrjypBYwid6A+c9aR9yMtoo/LS6TOjo/gsP5rK2wJvYu2uERSfgP?=
 =?us-ascii?Q?u1axBtFbqkDQdo20RX0gfapHy0Y+BtuE6Ne67qnsCQ+Nn8IZjkaWLzn+k5z9?=
 =?us-ascii?Q?5cyayPjREkF28cOiIgk48k/zXdcfW8qlwjjfw4en46bjdB7O1fiOcS2Zwh1V?=
 =?us-ascii?Q?qpQKlEbhFlYK7My5bYzUmjGHrOrrpTyGwTumHHvQKf025QCKSB6673TubHpU?=
 =?us-ascii?Q?dSWirpE8jfkzv7uGWnF4IW28fyrTfEsBh3gm/vO4jE1nxZx86UBNFkaTiK3+?=
 =?us-ascii?Q?RNmIUDlhNnyF3xYrB/4n17rSPnZP6gwFk9ILTIu1JyVWgAyHDYwdxc1MiHre?=
 =?us-ascii?Q?dwr9UE8Z9It2v+pBUWOe6maUtZ1HFporcFTloJuTGY4jhHyaLsdqibkL3SmR?=
 =?us-ascii?Q?GR4WisEvs3J8TABMioMD6G/Yarpsmo3LV0sz0I3VkJK47g0odEYK9KlkE6zN?=
 =?us-ascii?Q?XZiJvIQzuupczLQs3D+RQ1VliiTYuO27O7oHtCXW+xSiRAfvD10zBD7zaFOQ?=
 =?us-ascii?Q?cwUUvT4Y7/wadc4ejhkfa/bnJ9cWUi1DEcWg+Z7an6tBq0XmyTmpBqNL5I+t?=
 =?us-ascii?Q?U/O50VJ5Cr7VTb9Fxeut6rvzwWhB6Yrqbrnmf+YU/v/F733P6+/Hb8dP0n3t?=
 =?us-ascii?Q?khS/CNauGd4GxIcUZpstjYNHytfdEMF4STE9g2Z1jqKu3wUoqXa0+LmR0gmL?=
 =?us-ascii?Q?2nUJ6z3hVPrdTjbxk3kKJej/51kJ3TUpytK4xtGQ1grz6SwrXVxx+lK5wgpx?=
 =?us-ascii?Q?9DrfdK8YcEsP5EWCUMS+SURXPctBeE8nF5ojBi5KO7PyFLUVw2QcmH8QMt5g?=
 =?us-ascii?Q?e4AcAFMBVzIGvAz/QtiO38GKTDfr8Z4O7Tc8HZWLxDzLANS9KTg2/js3TA8c?=
 =?us-ascii?Q?Y8TkgqUgdNsy2ONsSR28BH9MyJ3aUCV1NKSZ2ZTO3khRWFB1F+fnmGQe0QI4?=
 =?us-ascii?Q?2OCoVp2PwMDQV3GQlkGJDJEB45+HYvmROucuRtXoSpBHGw7wMPQFj7iuxGlt?=
 =?us-ascii?Q?EEbAfmkLjAk+rdd7GF+/T1ZeZaCP0YMA70HW6noZVqt7kGsPJq5XdS1NzIMJ?=
 =?us-ascii?Q?pM2Z0Cj5sb1kQ26bA9frx8dj8Q4qb62L5UOhKUB0KyVOuogVR7LUFIMzpcPW?=
 =?us-ascii?Q?7PsrJ3aR6fQ4BPImPsROOKr0VcC4BGbpncOGCADJ7fZtMeez4tt/lQ+FIi40?=
 =?us-ascii?Q?js9A1gufS62qllpPwoZCFO76xJf3TtTGEGLGlbJQ7jpcJP1Aj7LELhioszg6?=
 =?us-ascii?Q?WKVTj4vJajkUZ/SezWr+YG9A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b70f097-6273-4f2b-d893-08d968fa8864
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 01:32:28.7037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3idwkUEfmVTA90hrPttHeqD0GW0ITCUFJ6M8zX2odAkDnSOq8InPVUqWWFQwmNgLnb/vLYWA3huGYdhLVdwmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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

[AMD Official Use Only]

Nice catch!

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

Thanks,
Ray

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>=20
Sent: Friday, August 27, 2021 9:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Liu, Aaron <Aa=
ron.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/display: setup system context for APUs

Scatter/gather is APU feature starting from carrizo.
adev->apu_flags is not used for all APUs.
adev->flags & AMD_IS_APU can be used for all APUs.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1e57e7465a7..7f311bba9735 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1327,7 +1327,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	dc_hardware_init(adev->dm.dc);
=20
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (adev->apu_flags) {
+	if ((adev->flags & AMD_IS_APU) && (adev->asic_type >=3D CHIP_CARRIZO)) {
 		struct dc_phy_addr_space_config pa_config;
=20
 		mmhub_read_system_context(adev, &pa_config);
--=20
2.25.1
