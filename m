Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15797E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9847F10E2E3;
	Tue,  3 Oct 2023 16:51:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FB610E2F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut2e3eZxIgScEEcKp9aFsjDn03P4WL11x7GNNNAf1bSqOYt9CkVrqLA2HXw58M5hwDTPjt4dDXOZUtrENW1SrQm7h7TLHYbfXKFboN3rYSc1FQVvJFuwdbFU3o+IWJNq0MoqndGOca+uEm7mrqb2vMw5+JEzPEnSXX37a3Qxws3lUI1XrNufV/ishbk983ya9HD3Qykr18trzdWBk/6NF9tAck8cNtqYeJzYFHwsw24RUBgZ0ZMukKHdHpNg9mZadIHqlQPxzQJF/y61aI+gZqXzBiobG7kL47PP9Avsvpf7kD6oHvE1HQmvxC4IE6S6HAoj1QgTFr6QfyCB2Htang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udSaHMuYnhgwWE5DjCLLROb3HlSXKrYqIJHsgql/0Lk=;
 b=BZEg/DwisrixmXV9Hp4z2e+IWlsYkKoW48TAmmFc1gv6SwJxyOYGqb9jnRMlrIsqISGGifYpKN84C2Idt8209KKENCQNZKYLCIkyZcmseoPoquNrjhfIpAwDC3bFJWKPd6EVAeRP1GgxgmzVaDjhUskcn6vKzQ/gFAN87K05z2UkBo83O7oLCTM+DOLincpg/vwjhQ8aoEVPdBCJzMM//l03CICjZskUR8hAHoDkjiSF5oRe/b4mI6i5xNs3hoCRGtbp+b4W2q9vRGS8a6XH7jH5RQrXybNva9/MSoGn8iJAXNwHwHo+Mk+ZVj/lm2ZGX0DTZCjPf6fB/PPmGGyL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udSaHMuYnhgwWE5DjCLLROb3HlSXKrYqIJHsgql/0Lk=;
 b=PtK0k596qnuOPwdFD3w1e14lA07huji6ELs2kusG3jsAuYe07wtzxJoACWiZiPl+DY+cOIx2en1YG+iIYaG0VQfmBNeo6Z3x2lailpQ0nAHD4i4DwEktHlPYGHbk3pjUXxuGRu1e3whnND7HLU/G0pIRPqNH0ymg9eaDJapu6wY=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 16:51:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 16:50:59 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Thread-Topic: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Thread-Index: AQHZ8riYX2ubxQn1WU6MMVs9gTL9N7A4TRYA
Date: Tue, 3 Oct 2023 16:50:59 +0000
Message-ID: <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=17c31194-aa49-4f65-a967-ab4ef9282718;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T16:47:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: 6f3270c1-116d-4600-ee85-08dbc430ebf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSbhGRGkrQ8Pfu7Erjg6WyxV1Fy4hcQ/FcJ6rom5pwsoZIib1HCgG31z1uiunMX3tfxZVnfLhHHv7hl8lAf25HqPJgaxWFx5/AegDeUmj010NkaLB09CJUYcKbtpT8qz4aA8RfAggkpYKHSFen+g4pS46Q1VWez1Fy1ShsuPZSKYZA9x+yap6HG4A9cqnglkCZHPapfuUJ1Uyq231ROVuRZn+9gayQ4oMDyF7YmB1LZ6dx5K+R+NBvk/8fs5jUFxEBi+vABxF3Nu6asnxKgH0aPmX7mgNlGPWQwn7wb7p2kcd4iYSbCIHKxj02db5uqp1YDGR4USzn7Kn6wdCZSjSpb4fRIXQ28dQC6aEFFThX9gDEp1eT2bgvSAzVZ4dNUssckqnI6oAXWeiggaToqvciR2YpUOnksVev3P0YiLtMWOxFhoHQag4rRf/CNQL4RupCNJKxclRebe65d432MeL+BWs+6glv4I3lC7uIt0FTuZdJGxVPtAJoxtmGxe99JvZVrmmn0Y9wDM3bLHEjZ3+hPWD/mEMyDjvNLAOUQo1PYaQChi+hsfdRiSoM6g5rboyPBKrAdWNoFykhmr74zSjhkKAzcGRl6ARscmFwkNfUFtPgFiPaznll5e/mO9XcAb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(33656002)(8676002)(8936002)(7696005)(6506007)(4326008)(55016003)(86362001)(41300700001)(38070700005)(53546011)(52536014)(54906003)(38100700002)(71200400001)(122000001)(5660300002)(9686003)(478600001)(26005)(66476007)(66446008)(66556008)(2906002)(64756008)(316002)(110136005)(83380400001)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tW9a3QhTNJAHmnLxc4jlogd4ojP4sbVqqN7SOaaUgb2QHrDNnRQDiBgxK28u?=
 =?us-ascii?Q?IVXcHANBb+7O8Bq7svRiQzUnzu1cmsdmbMdBDvBdYR37NjDYz6zjUnib1d/G?=
 =?us-ascii?Q?uN48HK07/MbYQ+UG4uPBnv5q2jCdxWhkLVVz1Y128cOmSC04za/rrhZgXynF?=
 =?us-ascii?Q?6yJiLb/oq1YbrxScRbFgnoQBT6+H3kDMKlbrpkvh4Hby7JLgi2lFoDcsq2N7?=
 =?us-ascii?Q?unknLNvekLac5yo5Fibyx2Sj+aNslD475TivMOnhhswL1PsakKa00TbP5ztQ?=
 =?us-ascii?Q?JEt0AZVmsyrZ3NbA2+hbFZu61ckd+139nXd76SQiJwmNSGQ/z3/ceZo3abJl?=
 =?us-ascii?Q?tUesxROO5+gHBuwkIfuKiX+4Ux+HQqsDW6NpzDW5u6IOEbD7LXYX8VwENK8p?=
 =?us-ascii?Q?ST3EhE6l/kEgag55IFUN0w2p5AFr5JkGAjxEhWYNAa7+rwHc8P+rTSJyyVdD?=
 =?us-ascii?Q?w9vky1Jy+ykCbXIp/QtKipEY1TnDpDv0MYZqg1gsjDcQffH02j7UFZEjrnWq?=
 =?us-ascii?Q?JaJUk5OqJXatZcel8rKJreUXwtYT/8uvAWeK/eoqGw8jUKdHe6MJwe1Bs5BI?=
 =?us-ascii?Q?E70uvxG2mYsvroZq9+abg2xca9QToD9vcr05hgM+HN0Gx3K4o3PrBSXzLmrf?=
 =?us-ascii?Q?gWrtl2kA64cry83tPCTtt7QbJ/vmxRc/660jfavmb19yETkWMPwaN2bDOG9J?=
 =?us-ascii?Q?B0XVnL0wdyl7C/aIpGux/XqOkfmqy3fDhuDiy/ua1dQRahzdVHbg4gPXVG6t?=
 =?us-ascii?Q?/2eptc3YAmIskbqzVD6DMMrS9X3DBGIDk91Q3WtfAuVrUizlCG8zu4YVWlPw?=
 =?us-ascii?Q?m34J2tUHc/8yqKeLlePuRp6FSuYKI/yrmksEQ7CLmQ2mTK6XGBQe8GSybbfW?=
 =?us-ascii?Q?OanuT0GSVqfM+1bK98/Y5XRfaK0f0dQ2O/TJw4V6D286lyypwUqRTmP/K6cb?=
 =?us-ascii?Q?b9MUFWEhd+zOgFBEe8Tpo2y0dheIlOq5biIiEqk4wF7r52Xa7+KUbxu2/eRI?=
 =?us-ascii?Q?0jm4AdVneewdwSQhDx0fVlVIXEHPKMXEghMSDA8X0qHQ1dbve1aevBsxYtzQ?=
 =?us-ascii?Q?muJsyYsvxjNsAclR+8C1RmDH6Fz0dKlyIgn/cNwSmBj6iK8n4k/zdHSQU+YM?=
 =?us-ascii?Q?zVlIhWtio8h9vuAd0WB/SIzOgNhT5z/+ut1S6q9rAxdp1lBeMVWLOb+I8eQU?=
 =?us-ascii?Q?9gIyOvoWCcWTDiXGcxhCY50uOCW/RU1V1HS2kjn/WI6RIsDVErb5LHG1QA3f?=
 =?us-ascii?Q?e84N3ZsDO9/s8OQ09dknO8Yy7Slc184mOOfjOq85FO6TX9gKL/Vp8nSoNgC8?=
 =?us-ascii?Q?xOcZrKfmmih9N1glmwwm4SZvPZ8uVPhS4NluU5GaO700Liv8H01aqZdnJ7SO?=
 =?us-ascii?Q?dMRj1+BpNlx1sCMlJ6xKF9htlddik6SvOJ8U2RqYTcJMWYCEdJC8JHfX9o36?=
 =?us-ascii?Q?sb+/muVJLXRPPYk7/E7VN5TX8yrnaTFrGtS7p/+p6rC0UteKxvMLfDVoWFHi?=
 =?us-ascii?Q?9CIQGKLIRGZ7iNdKwcsmo1l2Y+VpmXvTc20o48Fw4Wn/WuJJUc0l6SBd8dpt?=
 =?us-ascii?Q?+MPTjzgnycLA0cuog8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3270c1-116d-4600-ee85-08dbc430ebf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 16:50:59.9166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cn75K4Fps9g5Tt6RuHFJr8oRPjMQNu+6FMkJ+bQ/sCTlHTsFZM1sp3++67pDvUrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping on this series.

Since there is no alternate header to put device property other than amdgpu=
.h, this can be moved also when appropriate split of header files are decid=
ed. Other than that any comments on this?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, September 29, 2023 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h

Move definition of package type to amdgpu header and add new package types =
for CEM and OAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 73e825d20259..ac048a77e97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -302,6 +302,13 @@ struct amdgpu_hive_info;  struct amdgpu_reset_context;=
  struct amdgpu_reset_control;

+enum amdgpu_pkg_type {
+       AMDGPU_PKG_TYPE_APU =3D 2,
+       AMDGPU_PKG_TYPE_CEM =3D 3,
+       AMDGPU_PKG_TYPE_OAM =3D 4,
+       AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 enum amdgpu_cp_irq {
        AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
        AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..7088c5015675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {

 #define NUM_XCC(x) hweight16(x)

-enum amdgpu_pkg_type {
-       AMDGPU_PKG_TYPE_APU =3D 2,
-       AMDGPU_PKG_TYPE_UNKNOWN,
-};
-
 enum amdgpu_gfx_ras_mem_id_type {
        AMDGPU_GFX_CP_MEM =3D 0,
        AMDGPU_GFX_GCEA_MEM,
--
2.25.1

