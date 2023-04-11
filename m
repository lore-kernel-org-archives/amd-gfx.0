Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5F2C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 10:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFDC890BB;
	Tue, 11 Apr 2023 10:08:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59950890BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 10:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrac9TdvTwAtJtoe3Bcxv3JqeSisuuAXOhj9bia2QSgGu3xxUbnnzIC3wg3KJ3KdAXGzJWC/7cOer1nlVV2VED6qgVtxPRWx7zo8SVszafA3k82Yu6bqnvLSBAa3HICESEWZ8cnI57nQOHQYqwnlpDl58PEPOsgzqxYZZQovbQUsiDx4hRZbDtc3Qr2CidimE0fXxNB7a21wT/5cDmAP/E2jX8nd3qMDyifJcAFDHgN2/Ipro2p58dnKLMt5sKOUjaeTb4br+DAe9Li9tek19X+7eqGy+4x/aQPdi/HDiZAw8zPFg8wTST/laHKVXHuXf8iAg/SkCwbUgMJI70t3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv1sFYLiYLXhNo3qV7eNAFcAx9BTijcPip1f4ynRoeQ=;
 b=NjPt0BWoRNMR1gm9Ps9vrVNybMHT/qbIwy2cCuQZwellljCDhvECIWohzxaTZcUQNd47H1yGUMG+nyE2//DsVfZ5/yUYCnnWfdF7eTUxCF1f2WazJQIejZ+0ggk58wVMGHmwv14kcx0G2R95Suyy29YqSJy4YZrEvIkfDoerwL5wWMZ7BLy2ijkDVRz8WbxZl3QeeBIRN5SSNhkaRdgHr0ZKfp+LhNliWQQa98Pv3Yk320+qTe8PgJbsGB5aRBc/NkQ1HaVv/r0WsUTORnJ2e7tC3uucOJPdhSqNIV5fz7pDjbbNtt23XeL3mvwKYGu7hFXkKzJxxysMEQVJBTk0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv1sFYLiYLXhNo3qV7eNAFcAx9BTijcPip1f4ynRoeQ=;
 b=2z2F9lALkhCrjwpmf79X6JXNHBQN5U8gj4yZ07zG5T/GaDAu6r+67w2lP+FWg1nVueRkgt3Y46hFLVuu0Ji3rGatutbqAmk+REGMPVZzVvZ/coSW6iUgaxgr7xxkg3tpNUQoB6HkZxFt5n93ndMK1XCQXalza3rMlE3AYR+pRw0=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 10:08:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::7dbe:aa65:96f1:836f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::7dbe:aa65:96f1:836f%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 10:08:23 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZbFiezhbZ2lqIT0ugfmXoB5Pmma8l4hKw
Date: Tue, 11 Apr 2023 10:08:23 +0000
Message-ID: <BYAPR12MB461415F709E73AC11316262B979A9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230411093241.4644-1-Stanley.Yang@amd.com>
 <20230411093241.4644-2-Stanley.Yang@amd.com>
In-Reply-To: <20230411093241.4644-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T10:08:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=920c4e7b-a3f1-4c10-b7fe-fe3b91e14bf1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T10:08:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4f44ee87-1789-4330-9faf-64c4395f232b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|PH0PR12MB5404:EE_
x-ms-office365-filtering-correlation-id: 658f41c6-2893-4bc2-7e29-08db3a74af2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80ibM/PhzMpste4xuIZxZ/tTcqYiPSipW4xCIZevV1UUA6lkCxrWBOjdrwDt5t2Hn9UsW/NbWWvQw3gy90iuGTcaEScXPyJiR6chcIM0H4yWXrduOgrsUtfOgRgWyIVdzczXmDhg/28msaQ+GgEPyrvlhRg4d66sT77aaYwKUQrT0XEmCKLbal9vVVy0D/dYG72r9kunwoEw0+lwzBgsmUOh4ECkcn0wM0wnZbIaJw/rsKSeAaWjMeU4yJKMZTzMa2jNWn/OjA/jwziWJRfz5WjPeGpTD0kVYYRFOklNLsMqsbQ2bijtMmFMVlkxmdXnpUxTA8kr+4O0Dst0sLMTRL1Sx1PEkJFj/bpAkePzB24BVaRjOVsG4q8KlcpVBjvDFnYH9HpSfNNvskVgOpu20abUvxlqqQfl35tC63BY09O5lwhQY56td9sogtOoYHngqQNQRLcCVYKp6R1YnwWmUK7n+0PPiUJScbKlygISu5Ip3Uq4N9s9d1FMO38vP5uJwZG+e7tBTCGTRU1vosYj75ayVNVqN/f38mb2cGeUEKBD1XRsjf+GWpFcGa9HDG31eiYgnjDMq5fh6I+I35EJmXr+ztdECZtKGYQWAUGi1b/x4gLwVHqwwiR7sL54M/Yi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(53546011)(66946007)(4326008)(76116006)(26005)(86362001)(316002)(6506007)(110136005)(66476007)(66556008)(66446008)(64756008)(9686003)(186003)(7696005)(71200400001)(6636002)(55016003)(478600001)(8676002)(33656002)(8936002)(52536014)(38100700002)(41300700001)(122000001)(5660300002)(38070700005)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wPftgN45VT8eL87pVEQ9sFW/0SeFaH5tEK1Vxhw26GvvkxHyZcdZp1K8nQie?=
 =?us-ascii?Q?FqhE4MLdzNdZPX0dgxfgkw9j2ASW7p3SHrdFDj3DRSeMKhHhXHrGD4w6zMU7?=
 =?us-ascii?Q?JL1pRp+1QzGUkekXL1NyQZcME1+ubERfMiuKhePYG4wdxzeR4sj2n2K6mHv0?=
 =?us-ascii?Q?DmAk0dVOluYpnK38cqUXIPw4w1hpvrHvT04Bigfjaih+kMnUFaRgKefv8NMI?=
 =?us-ascii?Q?SxwBFBfth1FZn8eocQ8xoKFn9eH17lhR2EPrHJeVIF+MduQGkm/sVHVW7eCY?=
 =?us-ascii?Q?6yzqca5RrZ0oGfyCGT/6jlYO8G598wHOpVnwbzLjTjPMmPp2A1CpBC8f41sX?=
 =?us-ascii?Q?eA6hQl2cc0yR+X+NgtBg92QqvjRf+yGctfdzP/3tXRyzo6wPWSmUElkjPFvx?=
 =?us-ascii?Q?nzca8dYZ9G6zvwTLxS+c4o5HtPm2wgOVJT/i4u8xtwYEPbaVwhP4hFJ9mtlf?=
 =?us-ascii?Q?U30LpLovDcmgubOcW1wdDw1LOftgOus/gmurauYfBA/ooiDpKWhsNAtsXgFw?=
 =?us-ascii?Q?ZAU6vM0RxTKwqcJneh5alqJid8nvxcA3544Vxr29wtH4TPzjlNo3jjtIe13n?=
 =?us-ascii?Q?CkBKSnQm6VYzaJVWPUagUw2kFWh4nVCxuifM2IYVYmWsMKWAHH0Yx/9vpUff?=
 =?us-ascii?Q?9fFPqvEnUOGLDbh8nueiQUgSJg0SbrQGdThQz57SN/b34tYJJl6ChP+VflNU?=
 =?us-ascii?Q?CSYGHmaKOu+OGpVAww5GFY1cvrhmcsh986++zkYrPMxIoaNqPqAH/RrvMG+J?=
 =?us-ascii?Q?jVgUzmpzGXA0EG+IYaUb5uPKeKCbrAbr+iv4G0eLiSEYFOZLETM64ZvIpUFg?=
 =?us-ascii?Q?0JV98JdBeEHwny9SGIOoGURiuD/YO/hx5h4lH6Fz4rjEbKlu6yESi8Hr12jv?=
 =?us-ascii?Q?7jvxD1Bv1U8VsMlRKpzUsvJ9Tz0ebleDOLnSKyp12aT9CyBwdExii+KyFaN+?=
 =?us-ascii?Q?9W0+KEECT1YbYxEiMtqHoHUoqqUolRMCprmwFXjQLOxoOEvZ18ywe4xHkXCp?=
 =?us-ascii?Q?HIDycjnEAXyZAwU82hquUkZYOihVfBKj95DN669hlEUiqxU61iBFeNmGkdxB?=
 =?us-ascii?Q?zl7ArAb6qx5bPXCF9kvieQkZ6qJd1D4MalKl/MHQ9AB9H/bdAgsl8SvxQC3Z?=
 =?us-ascii?Q?cydWcW8RaYXpj+g0jMogwkflElBHpKsZLR6FFm4dcVr08v6wYgEGt9HpO0EM?=
 =?us-ascii?Q?40Ero6ilfru5Mij7M/dkBexztE2Bvomn+CVFVU6ZbG6z8jkz/SUzdoxrXuk1?=
 =?us-ascii?Q?9QcHISjyKzjU+0cqacayvlHCW5KPgC6bqUljsDSDDeCJwaUtEG02lUIyzcrP?=
 =?us-ascii?Q?ys87wc9+O61Za9Bn/gdaqtw1j7J88zlcuHcztPsknsuRf0IL7xyELWoLG1PS?=
 =?us-ascii?Q?mLiE72HjLD77T9cIIeVI2zZrzRTPp5pHDKwKQJhpuRujulJqCQvaC/H6k/bd?=
 =?us-ascii?Q?I1IiziRthJlWjl4EDVsqq30eza0IUWLzj5Wdjtf5Zaf0QeWGoFy1XMJU9/64?=
 =?us-ascii?Q?E/pzwipFowbks/frbJnwSUe2QYKy0XvaD+6UDs8BzMdiYSUzs0pV2GdcrTOc?=
 =?us-ascii?Q?m1ZjHTpMkTqjU9GJ1vk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658f41c6-2893-4bc2-7e29-08db3a74af2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 10:08:23.2064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gSMwhG9HqqmSEToHWnLxQWZuc5EWKnv0bpSqMy9LOEz7AV+RsLR692/6xMnT9oY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

>  if (adev->gmc.xmgi.

This looks like a typo. Should be gmc.xgmi=20

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Tuesday, April 11, 2023 3:03 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag

XGMI RAS should be according to the gmc xgmi physical nodes number, XGMI RA=
S should not be enabled if xgmi num_physical_nodes is zero.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4069bce9479f..c2c4d978896c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,13 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
 			else
 				adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK__VCN |
 							1 << AMDGPU_RAS_BLOCK__JPEG);
+
+			/*
+			 * XGMI RAS is not supported if xgmi num physical nodes
+			 * is zero
+			 */
+			if (adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
+				adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
--
2.17.1
