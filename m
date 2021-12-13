Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA30C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 13:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E8010E8B2;
	Mon, 13 Dec 2021 13:15:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B536110E8B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 13:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMVwND9WyS904OX58NcUspyAGFaPteWQ8/0vzmRWfknZOGkOwD6x39sybbBAroqHS+BolLpP/9kIQilc40wawsyRF5BEC1ivBdXsMrZtuMVQHZYG50xpaYi7U9LnirF2OWzMdtcjmAH2wRf8l+16ixlZPLyPSo4JdKHIWLos0a7Kp7mFI+cdIVnJgN1L1ZMhD098dEfcfo4hzmkn4VK/j/Izs8EbdCK3pqgOCRtHtDOoA1C31gjeH3GlEnUmI8l6cQvFbYvTL8yh3gp4yoHJceHOjdbsSvBWQ0BxcrOz7DBycOjDSRFiwe0KODmz3E1XtGaV6hPzP9aLe+/zIi4RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slWTal0tUrYB+ztuHm5ObbSGKi7Wvtob+ktHKNam010=;
 b=JaSbUuEII2DrcJ7y30KrmUGZJCVzMX+JRC2BJ0SEWi/NQXmwkouQPOuFcd9wRlOlTQJi0Ks8/RbBPFQcFKle70EesEZXWwAAo1UI5eH1HqQfbTCKpHLZSu9mtbYzxDZDv+hOBZ0KZXyz48psYMBBQQpA49+7XRVx/amdb8kC/4oQf10uG8TT+xgHkkcaTLdG1q6hzyuhlwlylxyem2LwVyEc4TLy5SBiet9n0YQ8cvGB8smLajpFDzJSby0aH63+QRdmdhiyOd9z6iGNHj6atLNAOjy9H81Ty9fLG/10SlAi/aP5VSu6N4ZbiMclizx4CGRMPuvxYNJXP+mf678WGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slWTal0tUrYB+ztuHm5ObbSGKi7Wvtob+ktHKNam010=;
 b=3LBXFf8ghtCZwkLLKEnbZwUDW4GJyL2fGtDCT6ezc+lucoPR8wORmPJh6gLNuEMSIVyP3zUDfmKL2+dGHSsC8EcGx4LHmf20RnRHerumdAM6lPglSo/ULUxiwfYkSwxHhBFSD8cdtieGkw0ckIzGYYHjDL6EfIsyRexiJmQh1Lc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Mon, 13 Dec 2021 13:15:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 13:15:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Topic: [PATCH V2] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Index: AQHX7/HnrhFgAqSXq0SoCHvnkUMtf6wwZwIw
Date: Mon, 13 Dec 2021 13:15:37 +0000
Message-ID: <DM5PR12MB246905DCA6405CC919B5A47EF1749@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213071959.793698-1-evan.quan@amd.com>
In-Reply-To: <20211213071959.793698-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T13:15:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0727058d-1115-4df9-84ef-b228125a8c07;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T13:15:33Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 627b17f8-d48a-4326-91d6-f009b869878e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48ba2523-fe75-460a-6523-08d9be3aa78b
x-ms-traffictypediagnostic: DM6PR12MB4530:EE_
x-microsoft-antispam-prvs: <DM6PR12MB45304EE0AFEDA1DABC338CCAF1749@DM6PR12MB4530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9c3xSgjXv987S1YC0AIdMiTY3Cvk6lmh6XbccSUJBIPeRpTpUktL4okDvXieJDvXRlTovt4Mb3BAWqSWqiq3e9j/SPK6JOMyigZ50MGtW5HCsFwgun8pigC+a9RC2UQMDTv7mvPVWzFynJko2c8Hiu1U+y/z+VmaV3Jy7LM+foOaI+qAQGEK+1VMQBrqhmasHQuPm63qPR8IQB0e0FnNk258Z5XqL2xIuFMdqEfzx2bw/4VpPH5pwuRpsOBEv7ExG73w5oKJqLSl6Vd2UDmpdg4MAdaxnMsduznZBBybPAACIesjH1N8d0f4OD7sFOu02G7eyqHSEWfTDmvwg2ItXdeDbFcH8+m+JqtE/a9uWtvR0fuHP6/ywpLAzQbEEZZ4RmqbaYTz/RilOHPP34HaLmm9Y51RbrYk8dvUQchNGOMCJerV2TLWxERJMuEongnHgugwElgnrdDYe9rZFJYFgE95OLZ3h8YuFVGHDXIMrt7bzyrx86XkhJTUpQBwvGZtXgLsrhLCzT9ttkL6MqoxYO/E+4z7O/47h97ad9v4yXysFEomRe7SqW1S4dfB3bR/uVneIxEmbkri76C9FSj4yuPjTrDQaTOQQRhCzTiZKgdbd99eKUDwJQ+fE9EfeQXdl9lXmigZ7hj8RHCJ+8NzKYiMnt285U1Jl2OLyp9mfVME0eDNA0c9kQejqrs6alfRllVP9I4CL+icnqAZTNiOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(86362001)(55016003)(54906003)(110136005)(8676002)(8936002)(71200400001)(2906002)(186003)(316002)(52536014)(7696005)(122000001)(33656002)(66946007)(76116006)(66446008)(66556008)(38070700005)(64756008)(66476007)(9686003)(508600001)(26005)(83380400001)(4326008)(6506007)(38100700002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2of109j62kV+LJvwrJzO9xyCFhkMl0+bfFeBWhkmSV/WNWjTV1FhtAyO/IdX?=
 =?us-ascii?Q?cVVs5JHgErclYBP9WAvINvGFiWgSQrGvW0rKCHgyWZHRQQitvtsrctqn9Hr/?=
 =?us-ascii?Q?KBSnPcG4Wb46BWQLlRD1tyD9YsJd+FiH1beFp2Vyy+itqYu1x96QkEUNHKBp?=
 =?us-ascii?Q?Kb3MLhtbJqa4+7oA6Asz7TPWmsvTgViwvVGx31NdnYcsgqgq0ohflIVi5hjI?=
 =?us-ascii?Q?Ke5i8CavckOuEmlSV0cZEt7I/2GR9eHCw+fkjaAJ8loOkVDJgr9WCCPcUqfb?=
 =?us-ascii?Q?qdbctKY2JOXIHm7hZuZIDcAsOPRug1rKvPdypD3lkjcUDO9DnihfNdmuz/L7?=
 =?us-ascii?Q?L4CQrpYr8KDq3g13a4wH1GjMR1XRjRc4bTeaUX9n1N5fYxKw9G5oiIkva6pg?=
 =?us-ascii?Q?NRNVNJjYu0bX136Bau2V95cZEbP/PA4oP+Opj/kZ0Wt1UtWgGimckjtFyRRc?=
 =?us-ascii?Q?mgPCUl70chpRhy+G0GdnGcFnwKXOXRDs/ZXgr1WIsXYl3MIcOdxFeaH0K64J?=
 =?us-ascii?Q?6SqTA8siyGD1VqbflsSEyDGbHBkjAj2Tx1+jr+2xqImDluvqeVUr8NR+78jP?=
 =?us-ascii?Q?V20SuNjyGnHGbcwrS7EcRo6/dPML+8I8he4g/uVl8tld4cc/gDOfW4vLsI6g?=
 =?us-ascii?Q?jc1ifKfr/43HtIfvLbBHQzf4oNkAVHh/UPOgJ4kelCgFKCo9/CgbvMtQ2soR?=
 =?us-ascii?Q?0Y24CGTmUt/lycJiMney+jlSP8KHudYMuK5kzQ+68JwxbiLtJtj7EZd2SvBN?=
 =?us-ascii?Q?7QaKJc+PKCXZrtsslg/SlIUemxeB/+xmhhI52OITCkMFiGAOjCODZlzih8xw?=
 =?us-ascii?Q?nzGDIZFXTIt2jASGaoRwDwQh1wWEXuA/phXUmmNGJRVXsNwb7AA/B6YgzCZs?=
 =?us-ascii?Q?Cp5Hir9S4FmFiV/oCL4Xo/E+adi6UYHB+PrYTLUfZ4U8QQ7Kao+bGvV870bw?=
 =?us-ascii?Q?Z44GsvfLvXEXQCD8kirfl0WlZo1BMStlMt3avbFuG9it3sS4Nh1Ji3N6ZNci?=
 =?us-ascii?Q?Ayp8Gzxc02TT3zUZP+ylSJdk2c0vP5cMFj07xcfLDLGryG5Nfu2g/gpg4dG/?=
 =?us-ascii?Q?HQfkmVhcUmA0OF4cCvM2RT/DMv1cjKeBvOEooNKmDatGAS596KfqQLWiCAY3?=
 =?us-ascii?Q?xsbRLsoizmsFzhrGe4D+8Ld27hK6+8aSkEyKRApWd5wWruoWusbSZzPRBSIn?=
 =?us-ascii?Q?goXNWPrLGTiSwao9Vp7Qc0IHls5yvOF6KDNnZEz90hxFexaeeYJhERHchEI0?=
 =?us-ascii?Q?G4KVqkmwsgpv7VpxoSIRy8HA+u13WV5zjaEX7pAl41qu0jB10IberV/YHrr4?=
 =?us-ascii?Q?iw2KIXIke7qPGw2pGnn3u1kaYwQlVSG8m9+2hRzqFWHOB7drSD8BvThzyYiS?=
 =?us-ascii?Q?RPa/zzBrF0oplNKEg5fP6Tn7Lo6ndOo7JbuKR0cACeQU3xVPgrlTLLICgOjM?=
 =?us-ascii?Q?r4ol9UqO3Az9hwG4w3ZKYIVRvSD3y0X4S1zmplWZkQsAa4qcvDT0jCrg5dnq?=
 =?us-ascii?Q?64/tZ6I71Dyc2zwG/IZBYBl1lW1XZALX06z/RV42fSsbs9sw7PAhlkd/15/6?=
 =?us-ascii?Q?KSCIJopagr6PMZUAk0q5PyGdi0RCG4ha8Tg+q8zRkJiBOBST3Wt5P5R5oQAT?=
 =?us-ascii?Q?UpZPvEY1yErxloEvKwCqnPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ba2523-fe75-460a-6523-08d9be3aa78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 13:15:37.7009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T51FkCT4XY0o78SCYSq9vpvySrnpkuDE6wRA74/hF+sIhoRmQQAbfJ5yc2Wm8w8aSgi53HgsvMsxJmA/UWPbWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Monday, December 13, 2021 3:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.co=
m>
Subject: [PATCH V2] drm/amdgpu: move smu_debug_mask to a more proper place

As the smu_context will be invisible from outside(of power). Also, the smu_=
debug_mask can be shared around all power code instead of some specific fra=
mework(swSMU) only.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
--
v1->v2:
  - drop non-necessary intermediate adev(Guchun)
  - move smu_debug_mask inside struct amdgpu_pm(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h     |  8 ++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  8 --------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 16 +++++++++-------
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 9dfccb20fedd..25e2e5bf90eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return 0;
=20
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
-			   &adev->smu.smu_debug_mask);
+			   &adev->pm.smu_debug_mask);
=20
 	ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 16e3f72d31b9..c464a045000d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -423,6 +423,9 @@ enum ip_power_state {
 	POWER_STATE_OFF,
 };
=20
+/* Used to mask smu debug modes */
+#define SMU_DEBUG_HALT_ON_ERROR		0x1
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -460,6 +463,11 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
=20
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	/*
+	 * 0 =3D disabled (default), otherwise enable corresponding debug mode
+	 */
+	uint32_t		smu_debug_mask;
 };
=20
 #define R600_SSTU_DFLT                               0
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 12e67ad9a3b2..2b9b9a7ba97a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -482,9 +482,6 @@ struct stb_context {
=20
 #define WORKLOAD_POLICY_MAX 7
=20
-/* Used to mask smu debug modes */
-#define SMU_DEBUG_HALT_ON_ERROR		0x1
-
 struct smu_context
 {
 	struct amdgpu_device            *adev;
@@ -573,11 +570,6 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
=20
 	struct stb_context stb_context;
-
-	/*
-	 * 0 =3D disabled (default), otherwise enable corresponding debug mode
-	 */
-	uint32_t smu_debug_mask;
 };
=20
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 43637d55fe29..735e1a1e365d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -257,10 +257,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_conte=
xt *smu,
 				     uint16_t msg_index,
 				     uint32_t param)
 {
+	struct amdgpu_device *adev =3D smu->adev;
 	u32 reg;
 	int res;
=20
-	if (smu->adev->no_hw_access)
+	if (adev->no_hw_access)
 		return 0;
=20
 	reg =3D __smu_cmn_poll_stat(smu);
@@ -272,9 +273,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res =3D 0;
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res !=3D -ETIME)) {
-		amdgpu_device_halt(smu->adev);
+		amdgpu_device_halt(adev);
 		WARN_ON(1);
 	}
=20
@@ -299,7 +300,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	reg =3D __smu_cmn_poll_stat(smu);
 	res =3D __smu_cmn_reg2errno(smu, reg);
=20
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR)=20
+&&
 	    res && (res !=3D -ETIME)) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
@@ -343,10 +344,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_contex=
t *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
+	struct amdgpu_device *adev =3D smu->adev;
 	int res, index;
 	u32 reg;
=20
-	if (smu->adev->no_hw_access)
+	if (adev->no_hw_access)
 		return 0;
=20
 	index =3D smu_cmn_to_asic_specific_index(smu,
@@ -372,8 +374,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
-		amdgpu_device_halt(smu->adev);
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
+		amdgpu_device_halt(adev);
 		WARN_ON(1);
 	}
=20
--
2.29.0
