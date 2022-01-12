Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52F8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 02:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227FB10E52D;
	Wed, 12 Jan 2022 02:39:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3078C10E52D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 02:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnNfjCO6ibdkNKyLlWfYH+b9jbNrGDR8llGzfnWRvPvnPetjiWPh3t6+GbZLMxj72HYrG8UEUTy36Y0W7NybELa/mvXyUzAakSbOZk/hRUQdkKZNunIuMShshOJe12Q4XZgKj4AbP6fnCKLjJm7OdB7Hz1LqNkeThydk2fEr8702WrymK+u4VfTeyCEkE2xhAAC9Qwlr3jsGQC0LJyOKXuqaeZjOsBYRw2HGe8odMXnomZkNSg2PULrPRF/07cNiD0NgWcH8XLnLRp4TZsdKJ4a1MAoJwhFpNNCiZG9lDoiruCwVge7oU7Hi8gfbsECzBbOx1nVbucZtazwrnQKf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0bHu2ADYmJ7s1eImGkavuq76wSwxP17o3OPcLHndg0=;
 b=QtDPmnu3HpIvtaOIqt1Auh8uM2X7Igd/32c3ED5o2B4z1E4PtDgpvJS80jFVcCV8pIsB/G0dlRL6JQV5z9z+7yDaPh+HJMMgQaNs8XIEO1v3P+H6shBzxZ/R4ngSAV3cM6fm84eHz9cYbonJ2XDmjd3R0U98b50dd2x0og0obO7xzcvD44zjCQ6ywDK+BILCod0YWvgqb9fpkusFrdcu+XvfFjCF15xj4LBG2X0Nl5lqyKo0w+5NZvgce3HBvcdpD812EmFMvHZRCJHh7S+GDM9Z7/chFed494nfBJaLaT7pqE+T4xcZGQxzKqeNJPvVu382yof+3q36b0h2fqqKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0bHu2ADYmJ7s1eImGkavuq76wSwxP17o3OPcLHndg0=;
 b=Mp+Y8vOtoDp8qXonUuQ0uegJVdJ3hJu0nG5yXy7MD/kXjycXnnDj8sQapdU3PTq7OuvogJSgLkgUcv31oBicxDXWv46G69FrqWOO2LU+tPY4SDq9nEVpOmSidKTp+WoN1k+BXYcREWJEgYyUmlStgtnfHnKo+UdkJKisCO/objI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Wed, 12 Jan 2022 02:39:30 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 02:39:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
Thread-Topic: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
Thread-Index: AQHYBzz7J4H39Bwph0CJOPqbR1iXEqxerJGQ
Date: Wed, 12 Jan 2022 02:39:29 +0000
Message-ID: <DM5PR12MB246904590688B034E681BBBBF1529@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220111224525.3090269-1-alexander.deucher@amd.com>
In-Reply-To: <20220111224525.3090269-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-12T02:38:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e0ad7ca8-ff41-49a7-94eb-7e6c583f4cba;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-12T02:39:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 00c158c6-7aec-476f-8241-cd77c492850d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1fb90bb-cba3-4c5c-0bf3-08d9d574c23b
x-ms-traffictypediagnostic: CH0PR12MB5386:EE_
x-microsoft-antispam-prvs: <CH0PR12MB53865A7F09F762BA4FC6183AF1529@CH0PR12MB5386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxq+g1nkE0G3RH/h4x8H05GfEMN7lFQvY8HL5FYJGmdgCWy8RGbjYRFITCDsFMbv44AgFMl+pYDom4XgfgLIZGsJIMY7urLF8PRYSjqVX1SkyRm0DzFBiOyaIjIIrIrniI7mlkbxGqTYQjHsxaxfcctdNjbJkcqv61qnoBr/vdOYhEYKkKXS7GhPEO9/S5pZkfcV1iOvjz1Mn1LE3ySqK9P6ANOpu0xecw3JjvfWGSfQcIdqBtwhylmydtlNlUp4Oc3gx6L7t0aZxUn3PBEB2vHjChF8/Sfpw1TMPXaBKAU/y4XLafGhwS6hKKz84pe617w4RNbr1UYjmrfsWNlGFDujhvoFqlXpJAfdO2q82DSlqFVRI9QBAF/rfxLQpb+c+wCnYlEF4Yv/VcLX0880nJRsBVTi3vPs+gj4pHITbAwTWgs5auZtv1EqZ90ftiQkt0S2Lbbx3KhIrCMJxaaA+7I5u1oWDIp9qdr5Pu1VvxbPleRVocurb/TMo+OUl2qgPMs3VWbtxRtCD8hwyYL9lA6D3FyiwiSnpwiy6HGxd9n/gxS0lAA2v97FY20JR6sc390DZ1pfqKVbetzvOLnv8gNB2iQL1HvpdXQD/ZfWYt3qRP5gcA8c6MiP8zraJMdIOL1eOygBOPb295/mjr/XmuLbjxdBmNd33/VwBOMhNAL6xP3B1l0i/8+8hQqbboLJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(8936002)(55016003)(8676002)(7696005)(316002)(53546011)(86362001)(26005)(9686003)(110136005)(71200400001)(186003)(4326008)(66476007)(83380400001)(5660300002)(38100700002)(6506007)(33656002)(52536014)(122000001)(2906002)(38070700005)(66446008)(64756008)(66556008)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H9wSIKmE4Fd2qNkueWUugbHklsJtSKm/pbWXZ2dILyN9q7yXM6cdztQtjUzR?=
 =?us-ascii?Q?ZtGh10Ayi1YkaWUDxMJKhWShN7Rvu5YQSbFkFj6qk+01MRbyLEUH1oFBvHUp?=
 =?us-ascii?Q?on9sxpJDbP0QbqXjXvaG3pSUxmsX0Gc/kOloWOb/8PYkBpfIbEJPrex6WHn+?=
 =?us-ascii?Q?+RGLBfjVTJvSrt1HBYirD5WmpLxHi4Md9w6c+xq8wzXmnV8+s0ALkvI+MwXU?=
 =?us-ascii?Q?gpVo/TIqSlqh+mVjV1gVMTkRmjd+R4Liv4QrF+9PnQ3SCeypdQPtciaF+zfq?=
 =?us-ascii?Q?uGnRn8SqafHOycqIW6xEkw57+ZgO0+2gUFsMSRxMMCZDn7bCcGlCPT9DLvER?=
 =?us-ascii?Q?VDAXUiXqYv20JqRlGOHc36RgDx9pS/01oV0rbuKqLvaZF0WJFXB0ww8drtUz?=
 =?us-ascii?Q?cPnOFGe6U7rTK1LCFiCE6Jch2+TijkrkqRXyoTuXcfnrFzj4Hr0zg5yxS0Qr?=
 =?us-ascii?Q?HZMBx+A8t7YRh5MYCeu1afKC+lXIdC8SUfVz/cywBstLEzwddhjdOaAh8rwd?=
 =?us-ascii?Q?lhA9msIsWLxpIstpHNWRMnAnaV+E4/vAo7W7ml/80lQuh+5Cwy5NuikyzYKC?=
 =?us-ascii?Q?FUpPC/DIJE826y1uk8TVXEeWNXoU+4iWal9r0kd+lqUcR5DBJoZQBv7T8/J3?=
 =?us-ascii?Q?eEHbT9DrQ62RyDlbMY5PDiMuPAI8eeJ1r1I0608siwwRG5SEi6vZd3qAnCID?=
 =?us-ascii?Q?LmmmcjPdy/T9Sibkp+/MbuRas2Cfl1L1gDTAnpEDpzVTD4Wv5kTLD7ftf1hu?=
 =?us-ascii?Q?bfz+EGlbnPqY7W1Z7qhK5+i7Yh2uCtrY+fGk8/kDz/hHdTLmLE3unVyJrDHH?=
 =?us-ascii?Q?dyj7dRQ+oc3scY1zysvP/3rwCooBqIIQzlknb3rHFOMjZ4oVLLAZSoo5Kpza?=
 =?us-ascii?Q?cKKtUuebWw964HGZKk21m3u6cGPFGi/wUzGAUolVuv58ixU69QTRrk7oh1vz?=
 =?us-ascii?Q?TZFkxkPWSxGCs6OPo+XKsqM2FNDrAPw1cO3TEKjrxDamcp2UE/AEOhKv4UUS?=
 =?us-ascii?Q?B9CeNw/vHFNErq3DTJNhF3FoS1L1Sp1pcnfS4ZRSpMK9fc1+kQmO5V73nnDe?=
 =?us-ascii?Q?FPQiVSbAu1iea4PDJaKTlRmetPkNuzeuXg4jeJIv0RxjBssrJQwGa4XtbntF?=
 =?us-ascii?Q?woisTsozPwZ/q/pg1aAzMyt18YqPDpgYZphX1JxkscxZhrgfOVr4qRMUm5pT?=
 =?us-ascii?Q?4K8Z6NtRZl3DNJrGzfK505efqXun62vOPZsdkuJNbM/F0DjLWG59B9c2mfrO?=
 =?us-ascii?Q?ZCH5+G+dDAalZ62xblqMuiD4Rcw56vJxlGFTvvXwJbXF/vYmPW9b7P3qBTNJ?=
 =?us-ascii?Q?+kvtffwEA5LUeRgLXP/AOgVLRtY/PkR49G12x9Uo5gVzfJQ5Aww9FibgOzCe?=
 =?us-ascii?Q?KtsfCEo8heTXC71gMDsh1vW/Neg+AWWoZtyXUbacrGNNMI6HpbyhDUnmaf5t?=
 =?us-ascii?Q?34mjbY2rMmmZ1TfU99lfLwaxEqTnfzV6s+llAobDHtSME0CZPZ7jNzjSMI99?=
 =?us-ascii?Q?6lPeyRUXGgtPUnX3nolTVlrPbgto3oJ3yIr5uey0+ee+DxlPhY6fmGcyKg+n?=
 =?us-ascii?Q?OjW8B98eGQVUajN5zCL9Xgp+bmGGuI6Z5rw4ApZC2h329KJboIz+f1se6Mbc?=
 =?us-ascii?Q?+FukiBwT8A6M1H0Nc3CMz70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fb90bb-cba3-4c5c-0bf3-08d9d574c23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 02:39:30.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaLOYmheExWT5B3vd56qz4dUuvo9BkPEVd8sKLgco1I2hcUWYD652oF8kRKSO49E669AgR7abfsUlL4uGFHPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, January 12, 2022 6:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: invert the logic in amdgpu_device_should_recov=
er_gpu()

Rather than opting into GPU recovery support, default to on, and opt out if=
 it's not working on a particular GPU.  This avoids the need to add new asi=
cs to this list since this is a core feature.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++-------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f33e43018616..32ad50b86248 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4453,34 +4453,24 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu=
_device *adev)
=20
 	if (amdgpu_gpu_recovery =3D=3D -1) {
 		switch (adev->asic_type) {
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_TOPAZ:
-		case CHIP_TONGA:
-		case CHIP_FIJI:
-		case CHIP_POLARIS10:
-		case CHIP_POLARIS11:
-		case CHIP_POLARIS12:
-		case CHIP_VEGAM:
-		case CHIP_VEGA20:
-		case CHIP_VEGA10:
-		case CHIP_VEGA12:
-		case CHIP_RAVEN:
-		case CHIP_ARCTURUS:
-		case CHIP_RENOIR:
-		case CHIP_NAVI10:
-		case CHIP_NAVI14:
-		case CHIP_NAVI12:
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
-		case CHIP_VANGOGH:
-		case CHIP_ALDEBARAN:
-		case CHIP_YELLOW_CARP:
-			break;
-		default:
+#ifdef CONFIG_DRM_AMDGPU_SI
+		case CHIP_VERDE:
+		case CHIP_TAHITI:
+		case CHIP_PITCAIRN:
+		case CHIP_OLAND:
+		case CHIP_HAINAN:
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+		case CHIP_KAVERI:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+#endif
+		case CHIP_CARRIZO:
+		case CHIP_STONEY:
+		case CHIP_CYAN_SKILLFISH:
 			goto disabled;
+		default:
+			break;
 		}
 	}
=20
--
2.33.1
