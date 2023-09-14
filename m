Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84782EDE983
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 06:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFB110E507;
	Thu, 14 Sep 2023 06:39:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E7710E507
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 06:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKUl3g0qF5nMFiXY4O/6uTR94QcSMsi7qo8tQ162x9hjOimkLTA6OUpSXqSXEkLGQTn87t7IXkICa0V9A2TEnbzdU7kr1xr3FRez8GsjwhLVqEkcFpWFKpPGer+EpKCZfPL7NbCMwX9pN+pjghkv5eEJHZtlsuUTTN3atwnyxWNaqYrsVLMwcH94R5rOhH2ysbfrkSHdbZArX2ZNb/1aNDtVYJIPyyZyFBIdteVMSk0fGgoGqEEd8uIQUjhKM+fsOHqz58iqSHCxfpoyiL/VPa9TumrX9VNYLNDZanuY/26YGWdsmug4VVS7jBSiHCSCfRW5qh5bsD4gAuPu//eAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYmwF4T8zWw0rVNmqb/9v7bC+7CJoBkBcJsg94ET9R0=;
 b=TvxcyBvWaqnHLfL/BRR3njVkLj9AZj6McfVy0nspF3uKWmcbPGE8xkASx6GuqT5mXATiij/PjY2oM6G/LQMViFxE5rbPC41KOm+W6P6JY6BcLPgNUNAJeITKvCliPPBrS3gr61NDXrpNE+g0rZdrE+GUi8u3PTLcDaW+GVIOSyN3ILvzp+hNgnlKtE8ISEDNtm5NFAvgcAe1RGtF8EWMGmXs559nRw15lpHqLOYJOHhXVpvLQYXoWPFPt0FPHC05RhR7o3CF9ryUBzVQKOFpQEZYv66sbTzkI0su56VS9R8TeWXTk10x+D+Ru5Qk+UQKqjQqCHU47AgCyzJSx25TzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYmwF4T8zWw0rVNmqb/9v7bC+7CJoBkBcJsg94ET9R0=;
 b=PTxID3GGuzHcutCfsfIbwbfIvm9EcL/w4nsIhxWZFWuowh6zscmuTw4kmx7enCPudyBYkiTDXe1I2wPnI3ZobaLTXQMNWMU+A7Au/+gnG8haZROQHgFq2vfKx7Rctzm4Qi/93vTpKfQIHWCQtUQtRLeiz9P4vY/8A0DnZZxZn6c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 06:39:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:39:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: Report vbios version instead of PN"
Thread-Topic: [PATCH] Revert "drm/amdgpu: Report vbios version instead of PN"
Thread-Index: AQHZ5tNEBCKAmyoBUUyIfj01xGjc2LAZ3qRA
Date: Thu, 14 Sep 2023 06:39:37 +0000
Message-ID: <BN9PR12MB525703947F0EF9F42C2CA64CFCF7A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230914061803.1231775-1-lijo.lazar@amd.com>
In-Reply-To: <20230914061803.1231775-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d2edddba-f51a-42b4-b8b3-7a3508ffec70;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-14T06:39:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5227:EE_
x-ms-office365-filtering-correlation-id: 2a55bf95-f149-4fae-2f9e-08dbb4ed5db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXuHiCOH4rgYiVfkiQLpwZU1yacgfwoGnk/fpaEqGw6rLYXZdnvtwXQMhngMReJTXJ8Q0izalvSlmQ4Tpn1h/mycbB4njbOnBRS3EARIbNbGPcz3ujclg/uyBAH4sODPWBb/JZ4CDi2IahVclQ3SlEyjATNF/rScPNgruIL6QiROovJtHgwt9pdiMnCaWdEu42RqFKw0wzeyDmn0rx/mX8PfJHUeuB7IZyr6gPSJBPF/5Z/RQMixDyMAGoFWDShoTIYEZK9Fc9JP7GqEUO2dM2OuAt5fbfFc5B+gDRyTGiLGTK9+uXkdFBN5SAkcf7fFK+tq8odTuvtTHkbqJq/DU8m5sEgQCGDjSdGZB6eT/L0OQpmo5CeJgftuRRlob+P9VwG7D8SVz3/C6AksXrvq5IrP37Zt3rjMKQyo+qkxqbB/ZkanUGMozml4MDPS42tTUhepXuT+FgLSvp0f8yq6jkyRZTnDtkKNxIpIoPnIdhd2Az4dY25l40TDQeCo6A6VB7LBwxnLR3ugT+cvTXLEgKPipFmmH88DetusNB/fOet2zpfJMS8o2g9WknuGBmOKsu4Vh1SMiQGumoUTSx/hjR6/hjfiaAiJoLsIXs+1kwFf8kM0nbfCPZOIROf8YvfZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(71200400001)(76116006)(66946007)(64756008)(52536014)(5660300002)(4326008)(41300700001)(38070700005)(66556008)(38100700002)(66446008)(66476007)(316002)(110136005)(478600001)(26005)(7696005)(6506007)(2906002)(8676002)(8936002)(83380400001)(53546011)(9686003)(122000001)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CiYE2a/iOKQOduRBcQscbdlt21d85IY6dH0m46hf/TuRq04DnRktMJOTgklT?=
 =?us-ascii?Q?pCXwAO71szFNKVN3N5sc/B/RD9ZssSOr04bHjMulo6s9EdoPgccj65KncffE?=
 =?us-ascii?Q?md+XK1Mxjs+m8zXNisv0uKod80y1vBjBWKtOvZ7CmLhcYkdextrGJD8b3QBZ?=
 =?us-ascii?Q?CIFCyhuH/BTbBrVDke0NkQY+fBaJUGGWiJle5Ov6vTa00IV80Mn1EM9Z2TM0?=
 =?us-ascii?Q?SgTXFgZL9orMWApMrkrCu2M8rwu2e70qFE8wqWGluviZIkCjpbgkWtXkXDPt?=
 =?us-ascii?Q?oUre85f0aYUMAJxDqmO1gzzY6XV3ufzylrQgAc5N6I5/t19iYvidSGJr1Ulh?=
 =?us-ascii?Q?wArYmTcKp1tdfU7THeCk+pnJjt/XLpP4ywFfxAg0ETtO+/aQDV/Y9r49QYvE?=
 =?us-ascii?Q?dXfgJXiwj42Ybl3tNii8S1LLC2fKe2Zf98xHpY7CA9Wr1lagQTt0H493jnUY?=
 =?us-ascii?Q?QMznO988KSjjaB8oyMevqYv1oguMtN9EBXkLDGSGf9bmDPvFrJAjKSBhGSP3?=
 =?us-ascii?Q?/lhi1IrG+Yf64Pa01iwJZJzY/Hk/tHz9LGpEDPzXnKfNcPRUcc5yNCX9AEqV?=
 =?us-ascii?Q?QHGNP5KQASWlouyMts92tAlXidji3pBUe/xYbqWAWMI/Kw+8oIAMkQQicrD6?=
 =?us-ascii?Q?UIWNT/JBkD9palTElHydJyCM+pf1uYhdpMo2VUPO4yCK1OQzGymAwqS19ARq?=
 =?us-ascii?Q?DeOfj/JblDhJDCoFvQ+RKZox3z/n7vpxkHSKgu14nAmt3wr6xyuprRvL6SfV?=
 =?us-ascii?Q?gCw1ADttt6ntwO1zCZGnaCcYc4P8pNuwAwZkswashB2+G2hVDewbqXoQnT8O?=
 =?us-ascii?Q?l8iRZ3sCIaw4oFdA8DlPwcixvAw6A8EYSLELOcxc142vEoh7ig3yXFT+Hjgg?=
 =?us-ascii?Q?FHY6RQW3Zxp+Jwey3fHCaxthWkXmCjy7Xs8/QI2MMZqTas3O1Rxe8/HO6N4b?=
 =?us-ascii?Q?3K7MjiU/SnWQ0FhOIsj+/Z/Si1enNREdQwaslW1dZ8WLDIFUVwwjGpOxWlSt?=
 =?us-ascii?Q?Dqd94YG32CN+C/Zg8Jse3yXRNKI3qL4vlYZi6DBi3yY14eO2BFXJJrANE1dQ?=
 =?us-ascii?Q?J9EuxnXvg12411lWUlvCxMRIBs2jgE/AQey7kUOdw1CTQRxvLcmSWiXuQ/pf?=
 =?us-ascii?Q?65UbIMnWdtSY8UhLH01zhf1vt5grlBDQ+B40uAA8cyShNFwXZJyKJX1iYRle?=
 =?us-ascii?Q?akgIcwoYxAnnrSvHAsN8S3tSEY9ZwlMywM7nbeGkplOZwOdNgtKvmeYOdKS9?=
 =?us-ascii?Q?G7s6CN+8u7KgHbtEXKDE7Vj+MNfIeluWWVyuN3bdgWyzCptXidXawpijEssu?=
 =?us-ascii?Q?trnjKaipl/DGkrnLJEe5Zntx+L2nC++2LfrrotA/jhdaX5jGjOCVsOaoMAog?=
 =?us-ascii?Q?Y8Hc3d3EUFOLFe30Nq9u7t6KIkNJW0ozW0HClJWWpPnoUfWb5I3JIYS5m887?=
 =?us-ascii?Q?/FAAI/bSDvtDTfrSIMSEprq+dQoychXYMO14TfpAkgzn2olbH+bOyVkVVyTB?=
 =?us-ascii?Q?JvZ2gIovdeREAyeF6/FfNkVG8mjN0wSjApkJ8ucXQIoHjVdHzYEnHXeEDHoq?=
 =?us-ascii?Q?7Q++NP4NlM6f8HeEkgAGXMXTN/+qXk/rUC33Sy9a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a55bf95-f149-4fae-2f9e-08dbb4ed5db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:39:37.4794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSi8i6FKaU6BKPU8GOgM5SmikY83lR5UKI6ZobAJIUn0Di+Qt38mfTElL2Oowi8vIl64M71B2mf7hlVY5T2LNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 14, 2023 14:18
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Report vbios version instead of PN"

This reverts commit c187a67725b47f9c1603359a51b79cc19e27442a.

vbios_version sysfs node is used to identify Part Number also. Revert to th=
e same so that it doesn't break scripts/software which parse this.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c
index 73ee14f7a9a4..dce9e7d5e4ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(stru=
ct device *dev,
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
        struct atom_context *ctx =3D adev->mode_info.atom_context;

-       return sysfs_emit(buf, "%s\n", ctx->vbios_ver_str);
+       return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
 }

 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
--
2.25.1

