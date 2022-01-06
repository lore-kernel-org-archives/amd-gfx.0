Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 13:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEF810F17F;
	Thu,  6 Jan 2022 13:21:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395BA10F176
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 13:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFTcyoKKiza7Rrax3EXtRsHpyibg0d0hke/5W9EVxp9Baqwq4Czh8q/Ax66NMYLay8SR2UQzH4JP1tLSf1IBXadrKjAkUquQ/IU0Ou6/Wysu4hsom0gsoA3EOqSMXWKTG+ZM4IlyXQqu1VpeSdSrmhnGFIJop9/WkVEE3Oev1db/zgKaLJbGY5Bfn0tjyM1N+fEG4aRDwrqdW9CNRHL6LOGDh6JB1zGRewInExSR4zECaPt+zL3zY2igUAzqgsr4DRb0ajA2Wypxdu5Gm3TrifXEwHPk/Noj9SCRm23UeVx6SSrZ3BQd8s0sfM54H2he5/OO7QBOzOVs2p7GInad9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeaGJILHH16guvAZAjvrSYYSE2prgOcy5qigXZ3q3Go=;
 b=ZGn6qiMK7oCZSTCFB3Q4kLZn+gvmCyzr+ccenytHyf9DBIka5Ik87If7feQsAIF/pnp8CFmPD4AWtIyIAz83CB9MTYHuNDUiFE/zSUKjDEb3SDAcWeowMJ+jny7wdyisX2KeQEKuFXpuUXguRliCH/ZXkQKbZ38biWJ1lmoU2Db2D6idX5lTx10t/UI6g4VjClDyUpxUxUU/XeFO9O7IunV0xTaoKoUUruokgmJ7WISqYBbFzD6GZ8BIpyvhHgV0fD7V91bxB3L7GIx2S1BAt2YVD/KUKKnRq3Z4Yo1lYpwjc5hwi63ldYb9cUzHlGHWD4ZsmqNmHQmR+f3OnWXWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeaGJILHH16guvAZAjvrSYYSE2prgOcy5qigXZ3q3Go=;
 b=4SqnoVukBRTXZLloWkevbdRwV5SEBvdx+1QXD7ppLM8TD1XKn+BytgDoLC46P5Q/ilzVgeEWrs2DbEEjEKivUN2yH4BOPzx4R6jY83WLzTtcOU7TQ4FtWnpRqD7tX5vmk5IZjL0LNRAD7JauHKN+Di8BVkYNNmmyCwbixNdjiyA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Thu, 6 Jan 2022 13:21:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 13:21:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Thread-Topic: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Thread-Index: AQHYAsJen2MVSplY5kylnSJgXTCYsqxV+tRg
Date: Thu, 6 Jan 2022 13:21:52 +0000
Message-ID: <DM5PR12MB2469674BF581F4ECDC475CBDF14C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-3-evan.quan@amd.com>
In-Reply-To: <20220106055732.3073780-3-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-06T13:21:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d01985dc-768c-49c1-a390-3aece051ccc1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-06T13:21:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c3acdc46-e1cc-4d12-b641-8057cb876bd2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 936788aa-75a7-42c3-68b1-08d9d1178117
x-ms-traffictypediagnostic: DM6PR12MB2618:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2618D1EBA53B6BC563D14E57F14C9@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrIfRacwZi2rd+D1ImZQyqmxwVrsFQlPCqVtduYsY3FC9+87s/srjn1hJpiZ0vKRcO/5l5RiHZIwpI2CRU61KSqf127Oa5WhH5JZ6bGdaB7nK8UaYeKZX3vmRP4AUIDH+TQ1KRbGzjaiXEKHmfc3VfUuOgON9UmU5acWq5DibVUx7Z1Kqz9zDMgEcnv00LDKaRrmcv0vM390vXjO0qxX/X2WFbwIeAr+AaE/F8vK+/rfQYkL8jNRTg+t16aTexd1c33v+mZOb4E9vH2kZ8u5e+XkuTYGfKdyxWgcT7G3sqOLI1Mz7RxXn+CezE5AGD7urAtUgHoyTW86UksSo7lV6/VjmYTGrfQsWoTuVS9atdvA9gTBadhBMC0LDUpTVvyK2RS9zj5fro+CagHBf/p6l8gfc8xTTl8ESArLj2Dw/A8iLGti0/TfPAf0lnNu7srpjLZjte6PXK91TCeRy62KQ8hsoRNt6gSubgFnM3tTUGjBoV0fLMDFcfBbZiflAyHFnZZUGs0D3g603nguPlbZxPnVlQLUr3uzmLXs2j5Q/jiXaJRpoSZc42Rzf9I/KDOjfivaZnhLpUrFI+x5AOLx1QKes8e+YmMZ2rF8tc9RmsFenGmZ/cnma94153w1I2QLPLC2XYN6YB6kT+code4//oZiMCBzP4MEvvKPlm/8lmBgAEvodI0SXVtVwXdQnRy9pSLEOmjbLd+di+Q60D4ELA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(33656002)(110136005)(66556008)(64756008)(66446008)(186003)(54906003)(71200400001)(9686003)(52536014)(4326008)(76116006)(8676002)(8936002)(5660300002)(316002)(7696005)(2906002)(6506007)(66476007)(26005)(53546011)(38100700002)(122000001)(55016003)(83380400001)(86362001)(38070700005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?toiolzARnsTK0OvNKmLVIOibTsD+IZ/igu1rRyxlr3bH44ouS79cqBqpUknN?=
 =?us-ascii?Q?mBiYx1VeSvw2I8RSugjVBXADHdZI9DDGys3G6B1qbZ++dMjz3K9akbWYygF2?=
 =?us-ascii?Q?QzYm19cpqVS7kqNeCj2nz5TZYOo1yBSK85CR7olWXgKfIAHNIJLQh6EqleMB?=
 =?us-ascii?Q?1KqWo6PkNYQZWypILFRMOdgcP04ba6aauOxyBY2kuSozgQWfEo8P3urmLWnX?=
 =?us-ascii?Q?DRGnhWsT0/lbERxWT3bg8rL2ScQTin9+Kr6hmdXM9z0Kd0YyHFOqGiBXQ2IC?=
 =?us-ascii?Q?n4MGfWX5KaxfXnm25rppl6POke0sweIrYy4TmAnSGPcAummBAR0QvA9TJcEm?=
 =?us-ascii?Q?5WJ8Wm8NpaZrZWxYrnHGcmZfL7L6V6rMA+kHmJkT6SmFTq0mrt9yGcqDf2BS?=
 =?us-ascii?Q?j2Xu7jGwG/6NQqQF4N8ZQQuX3meJErrqOjQnfoRrIqIqdcF8mccUWSK+aDrm?=
 =?us-ascii?Q?GLrJJ9Xy+rlVkdI0luLFG0zLexnhdFqfeHjLuqfX3+G8zgQXu2iNN6GSwpMT?=
 =?us-ascii?Q?oT9sQLCiGn8iRo+ATYb1EyPdu8TG9cTPKUrWFmRTCafSMD9cF/F+4tPoWRY1?=
 =?us-ascii?Q?1p1yY03KKWq3OYxk1HOUu/Bab54JwDrkORVOlh7w+4GdsR/doZaaxvT/Br5N?=
 =?us-ascii?Q?KYT5C2SEHGM7uR2B5heztzmPnzNNfYOdQrJoFQYgvgCRGJnbnAn3a1MBHZEi?=
 =?us-ascii?Q?1Oc08YRdmS/A0LCrRdXIjxpTC7tmYa/BiLHRHY8uo+2B4w0CQiGg8ZPKHhHF?=
 =?us-ascii?Q?qaElWPpYcpIg0W+rR2U5Epas8AWe/70udjjbgoKzWfruN2lXDhva2jU6q/iR?=
 =?us-ascii?Q?aCaGIaHg6oVV/MIQLiQAeWMD6RYmvvv072pkozjjRsuQM+AuxNGqvKQ4YvKn?=
 =?us-ascii?Q?VWM2QpyYtaMfwV/pbRvnLAPx9AI8cmWnzJIpKNAermUEG+Il4XRdbU61j/wl?=
 =?us-ascii?Q?Q3Srpv2dPoZBVS7mw5AEMgHMsmJKSGmnRp9NH1Jft06qEk8Dw5zzV/kMD/fA?=
 =?us-ascii?Q?7vurN/z+PLSbvFc21kI3hAxZh99AUJ65MSCNwYKoBUxLcam3r/Kwz7/X+qur?=
 =?us-ascii?Q?LDa4t68DPxzh3Nk9SK4/fi8BGibqYLZujbMTBKQ/4f/UlQEgdz4ZVWxb+5bi?=
 =?us-ascii?Q?3PDunkx3lbbzrYd1WgDEthE7b0RSU7RYq8GIGQLyU/jpmjoGBjVuJkEGJj7u?=
 =?us-ascii?Q?5uhQpaDZ9dS+YiMnR38/vuscdGc3aodR9dXUUEM5PionU4Hc5Ty171MKgsH9?=
 =?us-ascii?Q?UeLrndd6rLh3iqqbnadBeyKE9xCuCPL8VnmDwhNWxOafc/G+QJPXhCznH5+e?=
 =?us-ascii?Q?WtceaRr2LTvb8u2RbiBY+4sJczpC3S+hsXeVAaKnEd2lFCm2hTaAc1IhbUw/?=
 =?us-ascii?Q?hQ/pGHbqZApxyhQlvhlNJI+Ayz+vqPpAEFEFNaVomOl6epQJ6pvQaJUGaWRn?=
 =?us-ascii?Q?Nd7EBPmhQB+GIAlLWTOR8IcqslwqGH9r8pC31mqc/dmw76zlcZBvlCOTWx5V?=
 =?us-ascii?Q?ZjsbeLB+FFt5h3jmQo8oB+zQtDtrR/Y5d59RUTU9PAkJTH2XM/hhsIxcMN2h?=
 =?us-ascii?Q?SZImHehYXdfr7lfBaA31VA8yH/fq9tLAmA0AuO39IPkVAVT6gYjGO6TqAKDw?=
 =?us-ascii?Q?7aGHrvKUOfCe5Mkl8Wn11l4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936788aa-75a7-42c3-68b1-08d9d1178117
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 13:21:52.9102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcAZJqhhi1MyGs58EX3q3+POE6E4QilfJ2ePxsNH2S2VsGhuoQiifJELOZ0kk8sjlM/JNm/P84fCadqHId4q/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

err0_out:
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
 	return ret;

Is it better to refactor the code to drop error path of "err0_out"?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Thursday, January 6, 2022 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock

As those related APIs are already protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I762fab96bb1c034c153b029f939ec6e498460007
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 56 +++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ae91ef2078bf..ecbc768dfe2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -158,8 +158,8 @@ static u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
=20
-static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
-					 bool enable)
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
 {
 	struct smu_power_context *smu_power =3D &smu->smu_power;
 	struct smu_power_gate *power_gate =3D &smu_power->power_gate; @@ -178,24 =
+178,8 @@ static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 	return ret;
 }
=20
-static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
-{
-	struct smu_power_context *smu_power =3D &smu->smu_power;
-	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
-	int ret =3D 0;
-
-	mutex_lock(&power_gate->vcn_gate_lock);
-
-	ret =3D smu_dpm_set_vcn_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
-	return ret;
-}
-
-static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
-					  bool enable)
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
 {
 	struct smu_power_context *smu_power =3D &smu->smu_power;
 	struct smu_power_gate *power_gate =3D &smu_power->power_gate; @@ -214,22 =
+198,6 @@ static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu=
,
 	return ret;
 }
=20
-static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
-				   bool enable)
-{
-	struct smu_power_context *smu_power =3D &smu->smu_power;
-	struct smu_power_gate *power_gate =3D &smu_power->power_gate;
-	int ret =3D 0;
-
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
-	ret =3D smu_dpm_set_jpeg_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-
-	return ret;
-}
-
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -619,17 +587,14 @@ static int smu_set_default_dpm_table(struct smu_conte=
xt *smu)
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
=20
-	mutex_lock(&power_gate->vcn_gate_lock);
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
 	vcn_gate =3D atomic_read(&power_gate->vcn_gated);
 	jpeg_gate =3D atomic_read(&power_gate->jpeg_gated);
=20
-	ret =3D smu_dpm_set_vcn_enable_locked(smu, true);
+	ret =3D smu_dpm_set_vcn_enable(smu, true);
 	if (ret)
 		goto err0_out;
=20
-	ret =3D smu_dpm_set_jpeg_enable_locked(smu, true);
+	ret =3D smu_dpm_set_jpeg_enable(smu, true);
 	if (ret)
 		goto err1_out;
=20
@@ -638,13 +603,10 @@ static int smu_set_default_dpm_table(struct smu_conte=
xt *smu)
 		dev_err(smu->adev->dev,
 			"Failed to setup default dpm clock tables!\n");
=20
-	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
+	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err1_out:
-	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
+	smu_dpm_set_vcn_enable(smu, !vcn_gate);
 err0_out:
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
 	return ret;
 }
=20
@@ -1006,8 +968,6 @@ static int smu_sw_init(void *handle)
=20
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
-	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
-	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
=20
 	smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0; diff --=
git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/p=
m/swsmu/inc/amdgpu_smu.h
index 00760f3c6da5..c3efe4fea5e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -376,8 +376,6 @@ struct smu_power_gate {
 	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
-	struct mutex vcn_gate_lock;
-	struct mutex jpeg_gate_lock;
 };
=20
 struct smu_power_context {
--
2.29.0
