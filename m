Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA58C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 03:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090D8DAF2E;
	Tue, 16 Aug 2022 03:50:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEDDDAEFD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 03:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZolHGWDyrJqyr5lro2pGO/xJARelEDJ8KKoMcd2XE+yi+RezhbKMAOTi7a0eIQkSXh14KPY9OyUWvaYt3GKZQ8MJTFfAMEqrBa27vM8bPa9sPqU/EZU2jr0zBkdy71tD+qcSvRIzhiLfyvBU8sHpaBk0AhZ5FE47+rjfIqFh39TAv17a62Kmi+yOPb5RGyaADlEdqTMNbJJLYErcglc1yabs87pBCVrFJdE7m3PKgcJe/iIPLcbwzfZG+P/tlzy6OwijCi7LS9pTpuxuhpOC2xOnYGD/uN1jvRO2hs1LnGLgCOIKF9/6Z1Oq7d7RCscD01oCahf5WWFHg+8dBG3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhblb1wH1wLzmDzwwe+0ScIcPAKq/m4pMipEto4/BHU=;
 b=WrDqvsJvIwHMKDKvIdB0FR2q34ivv1BbV7votG9+CHixkuOLZY8433oItgS+KwBQPtAoN1tYLwvrsnZHMvZ+rHA6pB5NR7mfm9qspgtAnB9FjCEh8UtYvaZYpAbFY3EJrTaVOTla5HPSCTqe2f31jYAV46JUKa5SWC/foTp2wNLG051pX3ndwNVnL5Y3Epq9KBYf0L5mfEv1SoQvLBFrblHa9/Wp/DFTTHPTVjkK9/gpbC6DvNKtamWhsqZ/qqxaOKU7G5Xbq0zpGJcqTEr0jnnuBIbY0XPx+O1wSVaeTW6gvz+m1v3QyF0z2ioOhaHrseHqyZfFBVR29QbPoVMMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhblb1wH1wLzmDzwwe+0ScIcPAKq/m4pMipEto4/BHU=;
 b=S1m5PxhtbGFFzo/fHhd5RJJvSNz/qStGTdTotH5KO2sK+2RR8lQeiWbAdS4iihYQ+HGT7bYE1xPAlPgz9QhtE8jVZa/XRWJVPMp/qlFs/ViY0xOzsnQij32qplfHIybSW4xElew8oOu8id9Lur9H1focfsdjByXC1HU61pDFICM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Tue, 16 Aug
 2022 03:49:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 03:49:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Index: AQHYrivZQ1ZxQc5EMEu67MeMVCuf/a2vjbKAgAFb3jA=
Date: Tue, 16 Aug 2022 03:49:51 +0000
Message-ID: <BN9PR12MB52573C7C4242760F14E0AC2DFC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
 <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-16T03:49:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dbb0d066-7abf-48de-b639-38df0a7ba938;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ea2c3c6-d259-430b-d455-08da7f3a5f68
x-ms-traffictypediagnostic: CY5PR12MB6107:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvOh3Dr78gqZPfXOTCybHardXlcTXfCGh1YUsfiJV4u9/ABCPT6yb6W+aRWylaX11fTS8NqA8Uy4xeclAsTJOjHEkt0jnVVbl6B09PnAICVXydkJuo60r6FQhGGzkOAM6DQs38bwNPohC10TTXL1eleea7nidCs5rzB8COhldfzfgKu4qzUP9Zcz5+5Z260mdnDFt0iC+9wQvJe+rV27H/vkhWAyQyCPFUmWYMA+SwZZgPn4DKfwt3Vurm1PvJIA/8db1fN5nRbtJqPnjcc9hVj2gATkZA7md8GyGgSIK1BjH7RtsSX4IdSww6QI7FnhddQqrnfVpELYRQDbCLuQ74+5/wJPmqwJhNcVhcsO9dRLHUYU+KQRwmoi17HukstKH9atcLV9V1O4dLiJwQb2ErzGQirGAWm4SCzSIndSXqHbuVOfZmRRNp3bEHsLruvDUYSqSUPmSimsoG1kiWSNkb3aLNhuXAQP7ZAsXoDFTlaVnifOWMFTTRAR3Ywlo21EbDSRYKMXThriBC76TiBbBdSFCu/MrCSIG2yMInJdDqyDVagqNQ8OpJfNOQ3NqXCpOM7MrrAthHskvN/+LDzWIt+iA+trS5iYwBj/WqWBjcYi47efQ5JDi42d3N1Uj1yNQV9od5H5/IrrlIo3XLvAp1InhiryQaq3YFL1m4xKT+FLQKXAUTs0eGTRulg5ebi/que4VzfZ3GOJFK9qA6dQAE71uHCoLERjuYE7A4Hy7mX6mVYLXSwtOumIlsPbx9ubJGbNRhn04YoDvyQzJhZItJJoAs97wqxcPp6S7CeYvyCJz4SCSamHR7uxajI6s3XL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(64756008)(8676002)(4326008)(26005)(5660300002)(53546011)(2906002)(41300700001)(52536014)(110136005)(186003)(7696005)(6506007)(9686003)(8936002)(33656002)(55016003)(66476007)(76116006)(71200400001)(478600001)(316002)(38100700002)(66556008)(66946007)(122000001)(86362001)(83380400001)(38070700005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/0mJXhdWh8V0or+AhJ1h2V7XZeswIrkzWDBr9L14al5tHRb/tGmtfiQqlxRa?=
 =?us-ascii?Q?Ja+e7r6eHTUBOGwIouuQjSB1Q59d4y5qytvAu/LXTT0Ssqd07rUneEjkl1ee?=
 =?us-ascii?Q?rXz8fHSbzJdQmn4HrJ61mA02GeLmX8AmjMs0F2U+PDybvSnpDE2n6ehlCJnb?=
 =?us-ascii?Q?EgyLk/LCGfXd0iH2ua/zK/IOmL0m17INhRvO59hhOgaZrsyYueIWsansjlDB?=
 =?us-ascii?Q?yp16dcTsoaJ8LQL2UCGpkQAJvfDbiDjT/w0ZKJI6j+UIQfEGrPyFemN7Rohg?=
 =?us-ascii?Q?HtowXLPIVcOBVCIftvXGmKNG4nt4GxYsndHWsPZvr365gdv3TV/KZXAAJAT7?=
 =?us-ascii?Q?7IzBdFSiVx35CIe7qLvA6/998pGY+6204lozGUb4A31uobxGzx6K5CFIZodh?=
 =?us-ascii?Q?bOFFEAwQMu6VlbjB0ze16+2CiNRcZj63KTdfXNKvyPm99s9AEwc1fuWMxOwX?=
 =?us-ascii?Q?z1wpkp27a1XCdu1FSqGfoqtafCkb1QOpIWu1JqO6SOl9gp8T/bg575JbYlyE?=
 =?us-ascii?Q?aG/H5ZE4KfcEWfXxk36PEwq6rP93aWjzEamkwCrgoEraDZ7MSAO2UxkQmQIQ?=
 =?us-ascii?Q?vN1m5osgjjXVwpVhVJ3Y/3tWXKlUfK30SVlkbCUuuJ8MlWkdGDeH6g2RcqEl?=
 =?us-ascii?Q?E3TnFAl+0JdN3L3QuYGRTLSfTJ+5s/k6HrVsFj6zty8IxMbjjDmwLx/ckxra?=
 =?us-ascii?Q?7YQSkecTufXY/oe2GlbYdGKjpmMyBbCHKsRpV9o3UFWIjoo5C8iWP4yghj7e?=
 =?us-ascii?Q?9GqffEbKrSaZrIsC+1UjzdTWSotMSko8aLugSn+GXVHIlPwW7tOvUAYDkZvB?=
 =?us-ascii?Q?Iy+/R5+7cGuZUCZs4GtHk9WkNrfNTRdyMKCaIZ33ukrZKfE963ePQLszDP5m?=
 =?us-ascii?Q?4fWbiz7dUpJPd09uTG7hpLZhEkTy3B6rcMvLLh0+4qzdquusC2rSJc8+5T4d?=
 =?us-ascii?Q?sXk7uIlXmFC60X1XeTWujUcovkURan6urHXfpZI3/mqyKBTSbobq+Jf0hCVL?=
 =?us-ascii?Q?sF/ipAsGd1PDhBieCtBezA9A1GXsdqJaunowkJDHHUoMxMrMtvsHwQRuQE3f?=
 =?us-ascii?Q?YQAjMfDVkSqV0NqB0cA00+Xw70Oj34RjDLCXeqV+Z7xHII+kPZdmzSOrH1uh?=
 =?us-ascii?Q?qXyRn8+5bCwh+PhytBGa4ehAsIuNMLSDpLNy7/XXwEBZljKwVjwZiTsvqSPM?=
 =?us-ascii?Q?yGIR2pfyJf8PRRGeW340YdBnUx3WBoNDUXa4JAlD/38jsMKh+IPjWb0YKlDn?=
 =?us-ascii?Q?pdUuRQifHA2yVsuYTx0pN2oaBV/rGavvajsYbPgMROSjymjdNJXtC/jk8JNE?=
 =?us-ascii?Q?9mWXyO9RSbFl6I/qV+uRntHEIo8ax5sN8tsisTdzf/RGXszEHnx3wvve5lyG?=
 =?us-ascii?Q?lpldyunWSCFpoFPY4AqMSpLGzO3mQAB7X68LlhsnuXK0TA6wlnlK3+3PeN7u?=
 =?us-ascii?Q?9iqFoy7W9DsyEdtGmPVgTHEwMCy/jh8VPpuJ/+zEG1DZ+tmsGCywe1JsO48s?=
 =?us-ascii?Q?epdi8w4wkeXT5EF4YgL4WfnC7YAAf9ylr+d7gF7NdtqIB1Iur8JYP5r/QH5J?=
 =?us-ascii?Q?YO8xdLiiYU3jjzXgY7zNuYKl1hhaJtP7nAWT0PzX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea2c3c6-d259-430b-d455-08da7f3a5f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 03:49:51.1569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Toge0Hb0yG0zoaGcfRRd6WijVDrqZrfsr7W484k+w5+lm02IGsU2WMqZOTzIGkuBYykF6PA8+yQ62ebA0yWR0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Alternatively, we might be better split xgmi ta terminate from xgmi_remove_=
device. In psp_hw_fini, check ta->fw and num_of_physical_mode to terminate =
xgmi ta. and make amdgpu_xgmi_remove_device only deal with software fini, l=
ike add_device.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Monday, August 15, 2022 15:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini

[AMD Official Use Only - General]

Ping on this series.

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Friday, August 12, 2022 5:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@=
amd.com>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini

The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c84fdef0ac45..2445255bbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)
=20
 	amdgpu_amdkfd_suspend(adev, false);
=20
+	if (adev->gmc.xgmi.num_physical_nodes > 1)
+		amdgpu_xgmi_remove_device(adev);
+
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
=20
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
=20
-	if (adev->gmc.xgmi.num_physical_nodes > 1)
-		amdgpu_xgmi_remove_device(adev);
-
 	amdgpu_amdkfd_device_fini_sw(adev);
=20
 	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
--
2.25.1
