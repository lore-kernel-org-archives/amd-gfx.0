Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3BC32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 01:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDDA10EA24;
	Thu, 22 Sep 2022 01:39:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C453010EA24
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 01:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCZbeIV1H0lD/nuuAVLSMDEcZMA3GHlHnkJBCa1HMpMXSwfL8Xo+QKow1xY0rvq9ABzdYF1olFj7/IkCqflElDr0dyGOJawgdTbKjeCKujS2TYzQCIp/6glaCYb69tuj6X+tjv1ZQfTOYUyJYpfJn1JjLzI4yDRwZ0rKe0MDGtlgkSHTfTjN+oKNvx0eZSahUU+vmQIORNK2km3zofv1FqTS+tWyd/IQbf7LrusOvpZyF6CYseaCeVFvQb4pq0yEbc5AvneTcO9jaUEPrPENrl6dphlArkAvlhhL6Vs9fyW1Q05RnvPropZ4bsBTyqqNOsQYwPOz/4lVR/GPrkasNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8Sl4eyltX4/mX23fO7kQTOpslhT5EoOH0T6E18xYIM=;
 b=gdyu+TMtkAJFkN35fjPN/wg72RkOkXWGlOBsY6Ec1p/51xRo2e+ZnSkyhNXHyYWe+HChS4OSaey59ZjxrvtJHEyG/gkQc9VlDZFMLmVgxsaaudjaho3I1OcTxsq6BMGeaTDrjHjCAcXaPfyM7gfY256PazJoWPxBk9/o6vn6/RYwNfrA6bvXu9uVsdkFQVLfcSLkw3baxz3+OVLQgKpllajsDfvaIibxo039PMyOVQ+1R/ksKQmtz9ddeuNjyuI7HSy/iIVMDVqyjJGGUceWgG3TPi2A3lY6IVGsRRMy5avexpyVcjECITQr7B9nhbGWBbz2eTpfgduQg/fp6U08xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8Sl4eyltX4/mX23fO7kQTOpslhT5EoOH0T6E18xYIM=;
 b=C+F06GFwsvVUtYeRpGCpA9Jfs0olKC7kP+iutzCwZoQ9/7kV/fX5fQsDWChc1JP2uCTx3uyyqOmsGbrM+Br+m/Mzjf9zs5Pr2b0oDLue658BiCn1Si9Y4SCj+837uLi0u4BGxd0AjnPqCrTfOy+Y6byt348cLmOBzfUH3HS+2Z4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 01:39:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%4]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 01:39:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu
Thread-Topic: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu
Thread-Index: AQHYzJXMskpSsypFQ0CSa36iS3f0Vq3qrmEAgAAAbmA=
Date: Thu, 22 Sep 2022 01:39:32 +0000
Message-ID: <BN9PR12MB525730549D160AF5A058174DFC4E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220920020701.692610-1-YiPeng.Chai@amd.com>
 <CH2PR12MB42150879BB1AB00A757CFB3CFC4E9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42150879BB1AB00A757CFB3CFC4E9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T01:39:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=67060bbc-c269-424e-af3c-7725e3c12396;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW3PR12MB4362:EE_
x-ms-office365-filtering-correlation-id: c12d6f69-5fd2-4bea-38a4-08da9c3b4ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7FJpfm9CKsn4CIFdufloqI4qDfSAvYbCb17l9WrGou5++5q0qOcK60TaQKfB/BNqlfvdnRSDf2WE6z4MNrMymC54VGe/j17nA7BlGPvI4l4crD6ur0oH7I8FM3NqogKdBS70r6ZZ/s0D9rnvn54daqt+bmBgn0P1vtXVLj/O6/eUTriv8nNTMubgWxEuxzzqeOwx7/srLa8VMwRniHKkFNJ/VLEhy2fmNzjsbbfGLXzF6gc2/jvQLxvapXXKIth9MRcjD9+bOfyR4FqkusuvjaaiZrNYzxskTULkYmmDpBk0JYATUHD00q7TI5bjd9FxZpUpBOFhOFszV/k8EGJcFx/tt/12iiR6w/rERZmP0oSdTwJ3w68q7mEbNCuQ23y5ZMiYCKiK4CN9aoSeYbYDURpb+pqwxuprDCTX7iNG4DQJQxReiScInMJqmfe1pRrRSSk1Zc+AMKNOPbEcg73aUgGMLQQOhrJQb4aA7iiI+kEbiwSlkOxdTeNl0aUL1RaIEas2LW+8dGmU2dC/oCSdJfq0ValvXo/daoQ/RtBMTAjNVRGFdOjizk9UzO7o1JN/T/Qv4D3kffYcdU6qO21fwdec8KStGqft8fdA4GICKTwlKSfEqW6G7jqZdu5ZecsHqEiNSly56KAljv4N47AvdmYzAm+y12Aq5rNgqxgwuH9KL6mIpo93pNbCQpc73Ok4tkL3u6mkG4MnjU8Br2YexebS3CaJW4pGR7C3SFqwFCdCiLxZ5cLfw3RWTlCTFt9sf4RZGzVKuSuCMNyUK1kwtjSP8jT6bfLRqzgmwkqwMc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(6506007)(9686003)(53546011)(478600001)(7696005)(26005)(41300700001)(186003)(83380400001)(2906002)(5660300002)(55016003)(316002)(71200400001)(110136005)(54906003)(8936002)(52536014)(66946007)(76116006)(4326008)(66446008)(66556008)(64756008)(66476007)(8676002)(38100700002)(122000001)(86362001)(38070700005)(33656002)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXud+5NK4qxhLUiw8UZeZFh4LIQDpJT9zulbitP4nx/qMapxBm7lISCIEc2z?=
 =?us-ascii?Q?61P9RRBxfzThlvV7kC3/jB3yXQGN+sDzTmEUZO5fxBwnXmE01v/PyfE5mnwb?=
 =?us-ascii?Q?LqQQ/RRVjCnh3tDKN8Wjj2XQ9I3on2XcIp8EG0oOeQWmO3ebFnEJTlO35Vuf?=
 =?us-ascii?Q?ysm9idqxHkJyfQLhzU+/xVmXEdesRv8SK2nT4WOxDB41vaUBDvcualdjG+3z?=
 =?us-ascii?Q?YcidJXgMx99ZMb77zONYrKSZo5/sR0sFMAfbNQ7tJuHn/M5St0DubyCpzTZB?=
 =?us-ascii?Q?fdmEk/AkXymayN/ZAQDQHYLGuLCiDpGAT1z/rd9OltmKwMbRAn5o/qx5Wdyp?=
 =?us-ascii?Q?5h6u3yS1rWRXzR9LtV+lA8yKW8TXvkZCLW5Gr5ZGvapQDxAaeRvavO6ZIq9F?=
 =?us-ascii?Q?nWobl9rss8ECeqiHT3z8aPz/7/cmcTXcxryO1BZJIOJFA8gDqkaDN2RaBd6b?=
 =?us-ascii?Q?OYpp40pE4QDMuOJa+zmjHTFmwGGGSd2V5MLoY7Ujv3unrE81tv6hYGL/ZpIc?=
 =?us-ascii?Q?AC27H4Mr7lU5lAw4Qr7M5+2rRaM8zO+e3Q3nIwz5wqQSd2MJz1RYRqHTgXgg?=
 =?us-ascii?Q?XKQXDarDylvSUz6aOFkuJ+B2qsv/lQPSvaUecoHyAN2SpAavh4dgFt84SvRI?=
 =?us-ascii?Q?GElMNZB7FN1C7hISYL57cUtM7C/r6jZEdBPeyR4Gfaqto6D7a5YtiA8cqmgB?=
 =?us-ascii?Q?M4qjfyjq7DffOb3Sqh7NeIYG1HFdgDFtmE6+BMB7uTj7Rwmph8rqzo2pfgEw?=
 =?us-ascii?Q?X2XoEJE1oXFydXT2kKGD2W2bQGtORGQDlzMvJQc3cjZN5lmg80vhmwmZmdSA?=
 =?us-ascii?Q?vB4t9BUHMnN7YD7dJaksbViZ+6rFyLR5cvIMowzVN/QZWWQcoT36l2qF3kM3?=
 =?us-ascii?Q?guIabUwsP/PoCV+ZYL2gD/BvnYKWMLHJ762GTRYAHPVs+E161rHAGK1J4x2p?=
 =?us-ascii?Q?wPFOMyuHgvPTY21+PJtE1PGnTZ3WTB62rFgAbs8anztSkD7EqJ6zzJ0DI1rS?=
 =?us-ascii?Q?z7OptzyhDvNGUSTEH1/E1FlebErQfaIYXU3k7hyf+lKmxhGtc36Y6LPZ2KwZ?=
 =?us-ascii?Q?iq5E+YAL1Fwt2jQT504LSZcWJ34/qufePrdbkQ7AWTgeA5ByZPrSRaty6eKa?=
 =?us-ascii?Q?LC6qR639DxLXhJpfXIdDACe7VXJ++/1nUpSpbcaN+ULdlVe2gvHM2yUteR+Y?=
 =?us-ascii?Q?WeDOXTbci0nViRtUoXlxYYP+3brgmOzvhNQ9nIFGRcTU8g6AgvsGp5+isQRE?=
 =?us-ascii?Q?rPC0O0S/czR39OtL6J1Qo63/NOIuvEm2O6JTirg4L/jUNulBb41C7+NjYeMf?=
 =?us-ascii?Q?/dMFNy/Ih6gW7R7eQzmGN6ycdHevY4XT7ukgJWSBr3gKFxKOOZtSJFt9Fo2+?=
 =?us-ascii?Q?YCU6mdhvX8mYDYQB1wrzHHuinzYs95rL8hNlroU7kwc+bBwnUYI5WoKwU7f6?=
 =?us-ascii?Q?csfu+uSxtFJYZSQVAP1Z4EB+qPEiUG5ycUuhA2BnFYKK1HxylnAoj7Bo7uqG?=
 =?us-ascii?Q?CJXDAv0cFCxGGAPsTBj1+GUWMw4xivtpDRODzpyxsxkW33s5wp+zFbMVJbZu?=
 =?us-ascii?Q?fvLVKG0jzwX+EQs4SF2ZgAdjDOFzH1U+3fcTRK/P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12d6f69-5fd2-4bea-38a4-08da9c3b4ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 01:39:32.8515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRwWgj/MsA+vAO9P5nl971YeSPjXY+MnZ381MEKuGdXgN0ItEue9uPYh08ZOd4WXUOBXL6Z/YZmQsljKSnUdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Thursday, September 22, 2022 09:37
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu

[AMD Official Use Only - General]

Ping ...


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Tuesday, September 20, 2022 10:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu

  For the asic using smu v13_0_2, there is the following warning when unins=
talling amdgpu:
  amdgpu: ras disable gfx failed poison:1 ret:-22.

[Why]:
  For the asic using smu v13_0_2, the psp .suspend and
  mode1reset is called before amdgpu_ras_pre_fini during
  amdgpu uninstall, it has disabled all ras features and
  reset the psp. Since the psp is reset, calling
  amdgpu_ras_disable_all_features in amdgpu_ras_pre_fini
  to disable ras features will fail.

[How]:
  If all ras features are disabled, amdgpu_ras_disable_all_features
  will not be called to disable all ras features again.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e55f106621ef..3deb716710e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2720,7 +2720,8 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
=20
=20
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
-	amdgpu_ras_disable_all_features(adev, 0);
+	if (con->features)
+		amdgpu_ras_disable_all_features(adev, 0);
 	amdgpu_ras_recovery_fini(adev);
 	return 0;
 }
--
2.25.1
