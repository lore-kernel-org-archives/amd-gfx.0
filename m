Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F9DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 06:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D675E10EACF;
	Mon, 13 Dec 2021 06:02:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19110EACF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 06:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku94XhVfewEmeTz/PO/XHdrXP2oL9gP/cytXeZfUbBiRX438pAD5lnf7ScUP8jEVA+2ZPkEKeHAQ2QyruT04RIL6f3yc7SewZum3qyyUOOgnpS8E4Grh4VNSOrvM4PEWmh+u6NHTfXSAfgrki+2qp2SqCIalNZqZRLNMGg+g9uxvwkjeVjRf0YOCkUi+ViUMZroQFqxptQnLNb8jrsGOEP4h9hYDx9x8sqjWQ3Tzc/TxFPfWgRFuonSRk8cSs1+J1oN+3+iz/awyQOXTXL7/vPzSVAktisA+4fSORTqwBObzAO9oOLDO5DRQ7svPtRhpSFATHvkM4JF9dEYO8TPcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbHXbSOri9Fu8IZ2o/1D/X1WMCPcNe/NE3Cm37ObdfI=;
 b=n+E3jtw5VLJYIDI089G/eYN6H3Ggi13IzEy4dxDFTtbeY0ZgDPvKr2XCp/AwkxflCjJbZdMEUh/pAR61c8qmmTVwGc32oahhF7BILVoxpHFHJPIF0rTM9i6ShUrA46PBfmXaDQf/1KPEAW08p10NcgIu3Ca0iBKqz5ezrqes7jY4tpTJwn4Yp/dLhwewqe0HzDkyk0BX4aLUdWsjCmTqXozVCE+ceKvxs+rZBaSuc3O4Snh+9oy+GNzchTRi1pNEoI9TiMqt+vGbRNbYpSb77LidVhhMJK0B7ITHdLujOXqBawvlYezWr9SlApwJQdp7//Xgco3xIuxxWYnm+AfGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbHXbSOri9Fu8IZ2o/1D/X1WMCPcNe/NE3Cm37ObdfI=;
 b=djYit0oCzl8bCRUg7oPVhqVpgGWFvLBFEU1d/vCusrSfnj1fcWpGQIumQRV9whbQrDtyRfveK3przLxgrs4MEPg1MNwWY5qu9pQ9elQAuSFhZBV9oN63YMvrmiUwSj1oSMFDzl0mFXDrG0bfEPvnZPwn2OA+KuRf37hOKrB9IqE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Mon, 13 Dec 2021 06:02:28 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 06:02:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Topic: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Thread-Index: AQHX7+RM5kVyULNtwU+eVVM5hOP5d6wv7SoQ
Date: Mon, 13 Dec 2021 06:02:27 +0000
Message-ID: <DM5PR12MB246976396E09AB78B215FEC0F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213054241.773719-1-evan.quan@amd.com>
In-Reply-To: <20211213054241.773719-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T05:58:42Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=65b7bfc3-d2be-48dc-9ed9-d9cdfffc7448;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T06:02:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4da622f5-316f-4750-8729-dcf75fde8d2d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f04379d-3eed-40b6-48b2-08d9bdfe247e
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4516D25D7F12BE593830A18AF1749@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FYzGkdgGbDPIh5U+x1dFKxXzCjeXMkogbIAmC4eMbG8mENJZB2prFWGPX3TNJxELGyJ10Ly5vsq6CBqTZlvQO+GnALSUA8UtQgGOU1/QQOFF48uo1z/cutgs+ob78J4F2+0gXhTXPXyb6Lp9ef9GyL0MhC2WRCCtRsdgJsZZN7xStZ3p4aQx4yqfuRcp8s+pEFHeluIs5B6bWu5J8qz1W7WQSr8+fXaQvX+bQKXArykbk+m1D1nOtIZbxrV9B1rRpY9gtktv6CXpyeRT2CBt/p5+Cjw2HA2T9iIeeuSJWunXQ4rNGYJ36QZJBO/I25vgrhNDLsFVV2+0uZvhK//WlhGAIKRgx6HZLIagCmnWKovoNgUodODTWdrb59hu/NNLjExWf0zoQbeLTtYbWds0TT0Ul/ti+qFXnDTa2HGA4FwBkIYemr0MOtUAxckmdeJsuekxPxO4Ejs14Me2jBheflsnK+Y3VSNmA+r4AH1NivYhjtjMZaYL7+1KdkrcPf+mT9WPUEq/g9Wm0AcXUuxLYr9ds589hDQ/vxudDWPnAM3tWQjqhFfKMHbnzBVtLiqVt2tcn7RwN3p0bZimGeSAhBWXE5Rd1vyERsKY1hDrtZGzhRGJ0bOuEBrHzhY3RJjQEAIMNb2nW34Od1/c83hgtkk/sT0bICrEaYfoX4qfmO8NsErgs9bca7vg8VDgeFsrCsDTWxOw4scNLUgv1fRXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(9686003)(4326008)(71200400001)(66556008)(66476007)(38070700005)(66446008)(7696005)(64756008)(54906003)(186003)(26005)(5660300002)(110136005)(316002)(76116006)(508600001)(8936002)(33656002)(2906002)(53546011)(8676002)(52536014)(6506007)(122000001)(83380400001)(86362001)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MsdZv+lw+aNfj9G1bt1Shui4eqRjMR/77ZyhGWxR0F6JSc51OuabP4ADDPwF?=
 =?us-ascii?Q?HkUfbxaBEc9tZMspCbxZodHHF0wDaUP1eRNl+L9sSitLyIrdr/9lPOlMfIwD?=
 =?us-ascii?Q?XydLgmAUizTqdItzeA73whRZOuIGYOJ2fzmBYBQ0OVo5yzSl47C8FyAbw4x3?=
 =?us-ascii?Q?k+0plXhrETkDj8H8mMCZsVVLUsUxTbHiRVj/8xxkxA8lZezN+H+qTgQoCrML?=
 =?us-ascii?Q?xlxRzpxwVLg0342H7K5cvGoeyTPffH+/7Sf+UCPmoYIjfPfxqhymdNeFUmYb?=
 =?us-ascii?Q?Xn9/a6mmyXSSrk6hayYAIrA2Wo009muyDZzFY4v+b1hNGmParPJhTaOJIWM3?=
 =?us-ascii?Q?z1NSvvu2FfstcpCTlDxHV9wbv+MZI/5OWAZk/WocYo0fdyjclnOlDXSHl5Gf?=
 =?us-ascii?Q?oEqupJcge41V17rrEWUKdUTswKqubh5azYeWAzQJXoSEeff04XyfaD97QbUe?=
 =?us-ascii?Q?1c2TtuNFG0SpyqTys25VrOR3IznhQm1wo17YAslK55Ma5WiuyIfoJ2vrAkDu?=
 =?us-ascii?Q?78ec86twHgjaG4c1k23Dyje9zopCl3b76vto3JHNiTQ4wck/lQbwuvFsbI0l?=
 =?us-ascii?Q?v4PadrAZsbkMSz59UFLWrsYLfkNsKmMd/q7qUOH/xAYvK1U9uXKoZgO7K8xh?=
 =?us-ascii?Q?/b7SU6oV6xxm2zlgUcDM1oypgXeO0cUsSyyGZhWn/tmUIPuoWuyPwQo2OhgH?=
 =?us-ascii?Q?kGYRDf9zKY9X8tyt5Jj0UraYcqNQX1NfC3R8g34qbuSY1/kYGoYzHkIgTX/G?=
 =?us-ascii?Q?nrCHsnyjVQaxZVpL8nsMt7LN3jk1vNxrhL8RavxzCkEfZ01g5kimjoiGgCgu?=
 =?us-ascii?Q?7nwbG3NcOrt4NIAcEB4bKuPwSAT+ZwSPxuyeACgkQiN1gBO3Rp1vZyUOo4CA?=
 =?us-ascii?Q?Gmx39GIMV5WTTQYOHS2K71L23kEakb577MfB3i5+HR2wxPUCcgSnnzfULiOi?=
 =?us-ascii?Q?KbvouLiK/2JaEKS1svigd1+5J7qtxEnCrHoCBFJaHK7Z/ksNj7c3jUbi+a26?=
 =?us-ascii?Q?hn1nbqlu3ZdTol/DihOoaBP8FQy7WxaUj4ZbZd4XMg3sTIKUNBpj+xnH9DFz?=
 =?us-ascii?Q?lsMnU1ZLxxm/5p4G+HvVihfuGCznsBLNhqwGY6jzixEjOxCC79NIrFwlrbaa?=
 =?us-ascii?Q?Qa2odbXT1XRsk//KHZ8xM9oAxeBjVicgKMUJqGMDAWuZKi0Yk/bQ3H13Uzwm?=
 =?us-ascii?Q?SrF+hOiXm3tvzX4DBtKw7x9Pv/RHVPFaWD2FWm/+PCRv6+ljfYfX3V8Mr3EJ?=
 =?us-ascii?Q?DcIt7gM90+TtTQmz4ODCmiXBtV+QKYV8lRdcrJKcwKblh++PmiW8cN9WCgOg?=
 =?us-ascii?Q?5R/5YEakOwb8S/vVPoLSFD+0YvY+67MUb2KM4lm38Ognhn7r4nhh7i1h9mW7?=
 =?us-ascii?Q?bJdo7XPKuSat7UewmsU5u3U3pNuOZRhJ+p+JYpveBztndgO5CTRRJtJ4HLQ7?=
 =?us-ascii?Q?BywiY+3EAylK+IEJsGkXBD6nYQpIEBP14L8QgOUr/mX13VNuZhyGik9YEQlW?=
 =?us-ascii?Q?AP8RLVtrB6iNh9TTwW4dtiprNG6Q+HVxGRMVo3yWYhDPYT4MUIX7fjHPQj1D?=
 =?us-ascii?Q?ahviTkCKM0yt4a6myCMz/vJYtmXHhUmyP0kIYfYiXe/uxIj0IIi7NyaiWB/b?=
 =?us-ascii?Q?f8ywxV69HDJWosEAfGYyN98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f04379d-3eed-40b6-48b2-08d9bdfe247e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 06:02:27.9828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfmU36muS9weMg4MyBJuAIwvtFygT1xklMpm54HuzzhiFWo7kecKaZ3LSxRrthLPpmh8QIBdmyZcBh+f8nK9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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

-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res !=3D -ETIME)) {
 		amdgpu_device_halt(smu->adev);

[Guchun] As we have set an 'adev' variable, we can replace 'smu->adev' with=
 'adev' in each function directly.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Monday, December 13, 2021 1:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place

As the smu_context will be invisible from outside(of power). Also, the smu_=
debug_mask can be shared around all power code instead of some specific fra=
mework(swSMU) only.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 8 --------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 9 ++++++---
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index e701dedce344..9ceb8f3e73de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -811,6 +811,9 @@ struct amd_powerplay {
 					  (rid =3D=3D 0x01) || \
 					  (rid =3D=3D 0x10))))
=20
+/* Used to mask smu debug modes */
+#define SMU_DEBUG_HALT_ON_ERROR		0x1
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -959,6 +962,10 @@ struct amdgpu_device {
 	struct amdgpu_pm		pm;
 	u32				cg_flags;
 	u32				pg_flags;
+	/*
+	 * 0 =3D disabled (default), otherwise enable corresponding debug mode
+	 */
+	uint32_t			smu_debug_mask;
=20
 	/* nbio */
 	struct amdgpu_nbio		nbio;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 9dfccb20fedd..ee1cc15c6f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return 0;
=20
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
-			   &adev->smu.smu_debug_mask);
+			   &adev->smu_debug_mask);
=20
 	ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
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
index 43637d55fe29..b233d9d766f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -257,6 +257,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,
 				     uint16_t msg_index,
 				     uint32_t param)
 {
+	struct amdgpu_device *adev =3D smu->adev;
 	u32 reg;
 	int res;
=20
@@ -272,7 +273,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res =3D 0;
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res !=3D -ETIME)) {
 		amdgpu_device_halt(smu->adev);
[Guchun] As we have set a adev variable, we can replace smu->adev with adev=
 directly.

 		WARN_ON(1);
@@ -293,13 +294,14 @@ int smu_cmn_send_msg_without_waiting(struct smu_conte=
xt *smu,
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)  {
+	struct amdgpu_device *adev =3D smu->adev;
 	u32 reg;
 	int res;
=20
 	reg =3D __smu_cmn_poll_stat(smu);
 	res =3D __smu_cmn_reg2errno(smu, reg);
=20
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res !=3D -ETIME)) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
@@ -343,6 +345,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
+	struct amdgpu_device *adev =3D smu->adev;
 	int res, index;
 	u32 reg;
=20
@@ -372,7 +375,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
 	}
--
2.29.0
