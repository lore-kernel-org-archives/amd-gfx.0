Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12768C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA57610FA
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDA57610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3496E998;
	Thu, 19 Aug 2021 14:19:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500FA6E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 14:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivtci9+xyV0aFhFybkvo0sIOENBCXvczjuvv2MMNd8IFythfC7nWtlz9RSlN4tCjT65AoYKv44laGiTsqUG1wQx7wzDaprj3FN0ySyOLpAJdA+GAlUvveAa3xSvOS6wU9cMCx+6YNIvTpL51wlYwk+bPuHYG0QJty/WsOn5IzbDw1bJiTvLWkyGgDmf2X8NXlebB8aoCoTuxDn3guwWqo+qmxGVCY3d3K40uwuTP6H6UgpJw5CLF3bMMF2VomGdgL9I9atGdIBcPCJfl3bHpPRr7+WoaYoS75I1jSiE/zzEcp6Go6kvebcmRzC75j+sz01wZOon/xv3N04OhDiMi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgVDcIPNLj/FcgHqN3MvxU2w77q+pKBYyGsz0qZ1PlU=;
 b=iwLoDvyDJshQ7s61hkglC+cfu4rc4UkWsZ4ZRYh1NzzBzH/carfyRDlOKnaWjI9vlU3n5MxTq/9S+zt53d6zxdrBS5VsEzr/qQJqUFFpYQdV5Skaavn6AROE9VxS+frvQUifsUkPiVOQ5vD9b76Woy2bTDxB+ee0fvWyVQz92s+4jp1mBHS+wENVpwFK4f45CwkqFXFNTMT0MzmNKl/haBBr+pZBfrhHEN81YW49q/c0DvZluLePMmPjQi8c3L1rRmMyQdx4hataRZTjDmW8o2FSaw6Ycd/609ub6qPz/mqtFxUOsy+VoeTXxmoxc0eAahRlNDEaEl+0dqtwqA/OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgVDcIPNLj/FcgHqN3MvxU2w77q+pKBYyGsz0qZ1PlU=;
 b=wzfYGtPtq6QnDyE9ES/SGZvWiRfyBP+ZBwY9tB3te+3a1n71p0kPCXemnQWcX1g3BHUmZENcVQow9+xcrGIZGI1YA5dCD/RApNGjt3nglAmPNYpTZsGHjrhxrItfyi/b2uWL95mF1SnktVF6urNa/BKh2jbQiKi14Wj4tcUjrPc=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 14:19:21 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::2560:34ab:f08a:3248]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::2560:34ab:f08a:3248%3]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 14:19:21 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Thread-Index: AQHXlKefUC8QlBJDw0CZ6Sbi/RXNxKt6360e
Date: Thu, 19 Aug 2021 14:19:21 +0000
Message-ID: <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20210819030859.1470753-1-evan.quan@amd.com>
In-Reply-To: <20210819030859.1470753-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-19T14:19:20.226Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86a771e3-825a-49cf-53a5-08d9631c56d0
x-ms-traffictypediagnostic: DM6PR12MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB420195C6CA80CA1A3E70244DE4C09@DM6PR12MB4201.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ofxy1zjpwBRKwuaXdZ7DOw6bTDYZO0OIP2/9hqvjf/6sfMQLLhwSa+YngWZawi/smv1RveEjlnoC12DtKh+ZmLzEN+arJfsq+H+44r4/35eiaPObP5NppZowFaP/Ewtlz1ic3D7n8Q+2sxYZa549FBCx2MXU7Shdk6zWCC0C4P8HC1PWG9O4mMm2Wkr8HhbkEv75UzOdWTGVL6nS5xL7MEYgvkDtJs5RWxi7UbkIn6b3qfeCz3+CPbYhcuGfVFPaHPISy4/D9xbQJo9k6/LNtaflIQhAvlkMbURTbFkp1YN9XWPhhX6QReUFV4s0iOzF9Iaz9Ir/DW6fpfrIuPlR86lo7/z+SdlwGRPZY+G5BiZAdwht2fWG/wcYo3c8wat2aoXsI6cw+WkBmp1wdZ0JJp8gG734Bp1IZemLk6EWdVWkM/wMLpT2C/uwh8gqmMR31AA6kmE3UmjSNtb/2bsUbvDDkx1Jm4NA0JEXinIdO8MsLrcIZQtiXYCtaZPPowT3+NCGnJjgamO4TcNhh4sp8L/RoDpQztgLDcTOQTWfrSHcGGcpgSj2nqCnY8Y2VN9XF8/12cP89sUqXu0Ox0xLJjCrJZQHeym1E2X4MbX0+4Oic8LnJb2b5+pFlJVJfzIwHmBpkpNsBPIgrIox9eEE4Xw+CrM0Pcxy61O4JC2GeqHPdaEP13NsjlgDl0OoNZj6Mqf8BJ89T50AEze32gtqrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(7696005)(66476007)(71200400001)(66946007)(5660300002)(2906002)(91956017)(83380400001)(8936002)(33656002)(316002)(76116006)(186003)(9686003)(64756008)(86362001)(54906003)(26005)(38100700002)(478600001)(122000001)(4326008)(55016002)(8676002)(38070700005)(53546011)(15650500001)(6506007)(110136005)(52536014)(19627405001)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SsNliRAUQd/Nfh0Q6+4oHOW7QtE4Xi675WsW4Mf6+Lmr+rZzEkLtPfQ6H/qT?=
 =?us-ascii?Q?qIvorxDcs7QAMWJMj+8H7cR6SU2zKetisWC5GazN0eeqCqpjEmxJbrXJ7NDf?=
 =?us-ascii?Q?u3ZPmon/DSEkSaf0ba67s4Tpd0yyYyVTgdI4YHjkFv5GL+/CiZoR17AVIL6r?=
 =?us-ascii?Q?XhsKvToSckORD7ICjdTuFi0Rf1uX1qobhDaKqGqdiBkNNO1B2jk3BX1latB9?=
 =?us-ascii?Q?y36Q6NW+WWP/jz7DzrG1aBIQIijnLi/k92S8SEzcBrt2fuGnNOSLMGlljYCJ?=
 =?us-ascii?Q?THhyhARFoxgiG2H604GYC7jtYeXi2M/33unr2wA6hWmOjhYQJrkqwDY8jfxW?=
 =?us-ascii?Q?ksmk+HUaS8zlk0awKtFmMtfjIm/u3pZ+GP1VwxLU4BBb3hcs1ND+4iWSK1AI?=
 =?us-ascii?Q?XmrqW8UP47VRGOcmaMdcEpxcgd7DUuqvzk9kw/2YveLyWt8S2qiL2oCdlLqw?=
 =?us-ascii?Q?QvgOm3MfJEzXu3ywGSdnfykSIFLKYuKnhfMF34ee7PyToIeapaiuAF7z0cWu?=
 =?us-ascii?Q?/K3KDJrsTkWDTbVjC4Ja4cMyjWSIHJ4UFWKuTVirTxg/tI7tgVrVxbM8F86K?=
 =?us-ascii?Q?3PcUQS3Tn2dI6Ne0WkkyOr0wYXelygqe/QFqffsbu6aeQinO98DgQOaXUWk0?=
 =?us-ascii?Q?jxETJRKzde2a777nWiGGnMgcN24iSEyaN/x9nNx5qac7HadA4aPLdloamIlq?=
 =?us-ascii?Q?AJ6wEoOdhj+vvKd0rUWeU/9++I9XxJpKc6y4v1T1TFogNFuQi4pJBKNyHQW0?=
 =?us-ascii?Q?h5mXU4LfEPVNzPrQBBD09JnLzhzjmDp02TGjnguVSLdq00IE8L2JQWGo6D2n?=
 =?us-ascii?Q?cbNoOtbmJaIP/wX3cAkG+8tYIDqPJ/vho6uu15B+3iSaOnZwIxUTlAzDJZLD?=
 =?us-ascii?Q?TJy80sUSmhd8mBOX+zAUgfwVBH2k89yi8NJYcbWBBSiCJD+G4/7TZrr6L7qH?=
 =?us-ascii?Q?DLD7zN3zsVfNsoePR+ovMwtEvBa6UWqi3Nev/aR1Hm/5FOdjsh2kOh8L1WOg?=
 =?us-ascii?Q?GmKij9Xmx7ujRvC2toko9Wi9yCXDCMJxtbEWZk9IScL05GD+dJgQhUwo6/qi?=
 =?us-ascii?Q?4gVDnyyIeHAUoEuXWBgHujeo+YyZFNkVzVMmvW5HUV2ux2/PtY8RNgjANNQN?=
 =?us-ascii?Q?gvjpaxk9x1YMcQINBJIz0JIh+0NIIcO9wRuJLKVTDl4ZQuTTJY04Gd/9mtca?=
 =?us-ascii?Q?L7F8iTl3jIgSCt91UjmYOJ3QPorwuIKTf5D+FnxM4BKGEV+QSLedrsdIFYkk?=
 =?us-ascii?Q?lng2DhE+1TpWEJzbdD3opITprQNpUMBhTKbkhvJtF5St0xIsKl66JJpI88pJ?=
 =?us-ascii?Q?nd8wClFfaB9f52uZ31JphEiG?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB2517FA1095D8D016C2E784D5E4C09DM5PR12MB2517namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a771e3-825a-49cf-53a5-08d9631c56d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 14:19:21.4674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kicc9Dc02bMEJP8UdZ05V+/x9g6PVoSatYbWNe50XAwi4qFvgfYBKkAH+gpVJmZC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

--_000_DM5PR12MB2517FA1095D8D016C2E784D5E4C09DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


Why not move changes into hw_fini?


Best Regards!


James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Wednesday, August 18, 2021 11:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.co=
m>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on =
suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_uvd(adev, false);
+       } else {
+               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+               /* shutdown the UVD block */
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D uvd_v6_0_hw_fini(adev);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->vce.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_vce(adev, false);
+       } else {
+               amdgpu_asic_set_vce_clocks(adev, 0, 0);
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D vce_v3_0_hw_fini(adev);
         if (r)
                 return r;
--
2.29.0


--_000_DM5PR12MB2517FA1095D8D016C2E784D5E4C09DM5PR12MB2517namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Why not move changes into<font size=3D"2"><span style=3D"font-size:11pt"> h=
w_fini?</span></font><br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Best Regards!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, August 18, 2021 11:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Qua=
n, Evan &lt;Evan.Quan@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/=
VCE on suspend</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Perform proper cleanups on UVD/VCE suspend: powerg=
ate enablement,<br>
clockgating enablement and dpm disablement. This can fix some hangs<br>
observed on suspending when UVD/VCE still using(e.g. issue<br>
&quot;pm-suspend&quot; when video is still playing).<br>
<br>
Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++<br=
>
&nbsp;2 files changed, 47 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index 4eebf973a065..d0fc6ec18c29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* shutdown the UVD block */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v6_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 6d9108fa22e0..a594ade5d30a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_vce(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB2517FA1095D8D016C2E784D5E4C09DM5PR12MB2517namp_--
