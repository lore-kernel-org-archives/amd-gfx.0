Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377A8C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 03:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AED10E0F3;
	Mon, 13 Nov 2023 03:36:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B9610E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 03:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnBMgWYf6vyObYnJFALq9C1X8tWQggh8rUEMSilXv7EY80eItCQ4FC5IoLI85lxgVEuJZvLMm54c7QxNksz3GvQgoXp4hgLGhaHwmtJFqOwvzc6AbqPEMKKYvMYLavLL2wgApott4BlOibvnO34pNiUtdJnaGfF/gBwaikyrLXG/2OyKT4UgawkeA3yCaOkNglOsmBnNwVa9lCo/TPWQ3I3wflAFwX86SXylwDuPJh8n6WkNFd5z793fZMyZD5ZQHTseDtAXafrzBv+mX2T6B6zxN54IqaLB4R6VPOGIuVYaGSsti/42ptNOBJz1avod3+g8JCsiNcacVPpxFJoMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qk3A7jYH027lEisVAEqjRa0RM4LTIOJK7GwsT7pGns=;
 b=aXQ6Atah18CQjkL1T/BERdWaeocvRz6BB7dC1zp3ztjaLGdOzE7EpWPR1+fXAI9u1CxCXvMTMso3IRXlqE2NEZYh5no4XPOkMyimv3g6/a3thB1hFIGO3vGDW2ct7kkl2L1OYqbvzq1XsfRKFK6iSHtdR1vMnOzy4InYXmlqiUNuieWAYVbag4AsaOupvXefvHVrD1EK3xvUxSD1G2g5PpRq+XMgHlTC34zqEdD1Pe3mEQqV/8e3+p1vmgrSIoIppn0Un8rLCq45PlHPbMnkwq0EVSOWQQphVEi88ZfL6bpYEHlFKSuAu+UffTLD+agvu0O0hdj1bZQY3oxl9lxUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qk3A7jYH027lEisVAEqjRa0RM4LTIOJK7GwsT7pGns=;
 b=k2QW5/ELjTqWZMDUufUWw1NlRgvaPB2zoWZnzBcRvLNFsji+PQQ271txTqyf47UAGgwjZvoD/blCQGlfhSFvCJmyQLBVXeeznSuLoDzF+ErmDBA1MvmN05GVwehVJ7D5X/A6eQhtJoXcyAn37JNYjkAYOKm3TyEVJrw2+yGp+YY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:36:20 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 03:36:19 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence()
 static
Thread-Topic: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence()
 static
Thread-Index: AQHaErI3eH/2I4uitE2/UbYsQOg/v7B3nusg
Date: Mon, 13 Nov 2023 03:36:19 +0000
Message-ID: <PH7PR12MB5997C8BF2E2B3B079E037D4882B3A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231109021221.4055378-1-Jun.Ma2@amd.com>
In-Reply-To: <20231109021221.4055378-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=23f9d2a0-60ff-4723-9ce8-593aaab0ee25;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-13T03:33:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4042:EE_
x-ms-office365-filtering-correlation-id: a48c127d-e3eb-43ca-e185-08dbe3f9b33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZm5N3uWNry4jvrCwh35bYNZnTre3O8/Hs2Ln6uto48RSlW73cVDBwuvIySzFoptNSugTreQRJw8oHo4YcHsjcdmvVVlRAOdKNtuJeb22P6l8wVevRIhFLJ1vBUCnDfCSFlzYQ2lPkKerXFKiAMSV1suQlo9FvVRqQe7iZIqXcrA6uvb+cSi0UC3OKs+0+Fvya9dkh5hhR55muzFVu0JlhhAa3h0Bt0dPKLcug62OKUnRR4Mc7zszpgErnZDsub4BqUYh1LidGbuNNCm91UuM5tPhb9h85O2LCVzEE0mxh7r4JAyIhcc2qDsB5/hj2oBPiQ8ycJLRAB/2/7cQAP45axA/5UHdf4ySlCaSV/v5IBRoqOhtv4wly5VOBr9IzyhVbX4GRHMw+YKNVDJ1C8zGszQp8Mrdsy+D4gVfNBAJ45r9XVtZVNQ0C+2Y1l+wtn+1HnM9X/x7SrEpQjPzs8VsS82Bikoox58rowRNjq2Mg5N4B+R8sIINFF77/EGWiRwRyJnbUeGutyUVa+zA6g2LELhwLN6l6JqopNwxomwOiYEzAco96lxi3PGyayZV+tfWvafWsBOCH62hLAApH0+ATajB/3pta+65CxWZiQnSM4ToyIRzRm8WXA1a3Jv8OJz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8936002)(8676002)(122000001)(52536014)(38100700002)(66946007)(71200400001)(76116006)(6506007)(7696005)(66556008)(66476007)(66446008)(64756008)(110136005)(53546011)(478600001)(26005)(83380400001)(9686003)(6636002)(316002)(33656002)(41300700001)(5660300002)(86362001)(2906002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WC20v/BypoaMPohHx7W85zzycEPCOljQ7MVRKwVmX4f35VBcaVDfmarMFs98?=
 =?us-ascii?Q?nJ/clWM/SgOMRzoujVRkwDgKnbfYyYDeGhiA3ezLz2fr+yBqWyHwrQK7Wmrh?=
 =?us-ascii?Q?EPFReGWPaiIECmHZ5TarKcpmMimJPiG4qZT/cL0LZD+a0keCtsiHBkpdTmUG?=
 =?us-ascii?Q?rZcmbgfF+ZEnPnKvMMZUVsxkgWw0DuSAptxEvvyyVwO7LdYuF/XN83PoWFVI?=
 =?us-ascii?Q?+IN08aHSl/OBqlO75Nl93cst0r9zdDNf45eqp6M7ZkSlxPgGbVt6QuRWk9vM?=
 =?us-ascii?Q?BY8u+Kp/QD0ajBt+/dkWdJPZtLzBsR7fiatAX5t5DlBMXo2NGTFOAQyog5wm?=
 =?us-ascii?Q?pUt8LOBdFcx2WEjQsUmnYO7Qx7QYZt99TJrHLxHdJ9vnW1ihJ9QU6BISh76k?=
 =?us-ascii?Q?392O0g4A5C7XWlg+QtD/dthAUM21L1YKyU6ImGFV7GO97YWHQ7/FtZ6P1y9v?=
 =?us-ascii?Q?tDo4zFKWPE2XModxCdn2/iITriWYt9HRiBbVeZinhrpnsk/X0npOSXEyaHds?=
 =?us-ascii?Q?TNEF0lk4k8yrQgWkCv85zjr5/dmJu54r5AwHATzQhoj8h7hVzLdco4nV/KBN?=
 =?us-ascii?Q?eERQT16f6n5EyGHDTOfDtvZVRG3ky/60BS2dpbP1r+tN+ubLWyL/oXXUJuHu?=
 =?us-ascii?Q?+Vt4sSeE2HBLEX9fMLZMcwBqfeR0cAUTgWe41BIB7bACo+1eVjSeBIPpGYdm?=
 =?us-ascii?Q?S0VJSXmeNFAiDT6vyXvDRfwzjmKVWC3T+0HNtwVxmGAZFXb6IxQeenf0b54a?=
 =?us-ascii?Q?LGWLrvT+T858v0j76SOU+L7GzPUXyGrF/uILJ15rn4SMFQVuQQUbgHrgOFc7?=
 =?us-ascii?Q?Qpcn7yg0wrTfNUmUZOCN8AQ12zeX0R3Any9AoPnqFIiDG3yf67WtwTeuJ3sy?=
 =?us-ascii?Q?mBG34XjuyW2BZaqskOckd+de6DqeqjV9wqRT2fu2IIb/nSwiLarzGXAFTUmP?=
 =?us-ascii?Q?FxBCMINjGGV0oU3eVOlUQc2pIggLXgP/venlzvq07f/b+NLrUhk0aKVjROdv?=
 =?us-ascii?Q?Ld+NvuZjQg8aUEnMh60R97ljZsGPeCbwe+UqowJFNSgUG31cXDn8XrBN+pha?=
 =?us-ascii?Q?GbhccpKR5b48/g2mJHuDu42ksw1Kjj4tPzqpig61x1Z2TZ+pfX73lrlez/sJ?=
 =?us-ascii?Q?Pz9rQ8vtFax2xb/Z44H9gaVRN5wkqFsjssg+QUeY2sXqcDOvFdSnE1/z92fz?=
 =?us-ascii?Q?PuSruUS/a3afiGriXLrmiQqmO+jwcfpTIIOs3Lqs3W3h2R9J+46POxqozLr0?=
 =?us-ascii?Q?0KIiyhG4kYooCi2ZyEzdpYe7I+OJow+oe/dIWyHQG87kobbXu+6YwkziYymM?=
 =?us-ascii?Q?XVcgMOi/riir19xxPMkceRZrjjRz9iIBmwbFOgKM22c4k3xYs/hs8g4pxOVW?=
 =?us-ascii?Q?PaVWGqk93StpGJQk482FeMdJtK4IPKNS9anx/iE6lReOt+BF9znHNnZ7pvB2?=
 =?us-ascii?Q?gRa7xsNrV58JubJV1UeiOP39VAROpe0KgJGXBO8xbKFWnhFqi1n35Q27/kWF?=
 =?us-ascii?Q?9MeQ/sQBwRvLHJImfAR0THbPkUImhud2rOAa3dcq6E4boPb+sUDL5CwhnOg1?=
 =?us-ascii?Q?LNsG5SFZUvF3MJO68d0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c127d-e3eb-43ca-e185-08dbe3f9b33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 03:36:19.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUg6d2E2y3MdOUOrNr7BGSOotlS+OoiOjJIBVKnvvCMXfNGOKreyN6DmKJaw61kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

Series is.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, November 9, 2023 10:12 AM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence() stati=
c

smu_v13_0_baco_set_armd3_sequence is not used by other files, so make it as=
 static type.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index f307a7965941..5e7b8f29fecc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -210,9 +210,6 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu=
);  int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
                                               struct pp_smu_nv_clock_table=
 *max_clocks);

-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
-                                     enum smu_baco_seq baco_seq);
-
 bool smu_v13_0_baco_is_support(struct smu_context *smu);

 int smu_v13_0_baco_enter(struct smu_context *smu); diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/s=
mu_v13_0.c
index 891c3fddd7b9..5e86d874cb89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2198,7 +2198,7 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu=
,
        return ret;
 }

-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
+static int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
                                      enum smu_baco_seq baco_seq)
 {
        struct smu_baco_context *smu_baco =3D &smu->smu_baco;
--
2.34.1

