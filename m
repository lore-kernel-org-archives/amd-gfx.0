Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F05FC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2861522A83
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2861522A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7666EA9B;
	Thu, 10 Dec 2020 15:47:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9CD6EA9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 15:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfhs7vDv+iDBt9VzCA9o6gLTolh1MjlShWrl/TRRumXKMS1JLZh6buXgS39+2931xNL3Tt9A2BtcgLKSuOhbXazXcsIkTN8p6gUs/ID7MnW4eMsF3nb1C4D/tM7JBh9/tb09fsWRhU7og6USq2ggaDtil3olQoAn8nVNnpQrLNO272FrS3/1087BRYH53vIaXWP7rXvhnQXp2Nwipkid5JQ4cFzrnOHJXd6yF0uDmQN0K08GLRwUeA7rq81K8WEFxMXWsHtwxdsh7MNl51HlLoKDIbBPojhEb93Fb6Y1XJY5iADct8HbMIVfRbH/tJlfK25wMV6fIN2us93iIKTE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG0RJwpckywlvJ+3d2OUe2kGoXfLVHrf4Fnm62ZgDGA=;
 b=VgJLfB8wAbXsw9mDqELk+6dof5F6nAXZ8yPEP5vIHZzk+hzP3R4QDfFCZAm1cYAJl3HkXvbVZ8yHnThGZGzEJeqnncZYz314W5u6JIsNBCMu9r3zGVR7IwP0f75XrR908vEgjc7QPYKF+l6753D/uKrsfQVSoEdC1lw97W/NH2Hz18Q/paansBhXQ7zqA04RwS9ruj79nNrh0sQJHB2NFbitZBw9LXNK+dv2mpJAJVhc24qvfUDUtK0Pdyp3GuuEpseiWGSwyyvMFl7J7w5Gq5NifCtBOfp8Z+yZoDCUwXo4LHyugwQUEpKpqqlMLDRaTmh+4/XjxdkMKTTUF0RZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG0RJwpckywlvJ+3d2OUe2kGoXfLVHrf4Fnm62ZgDGA=;
 b=sFkHvTfl/zCEGI6qUQXsRCUczs8QYxh0soit/aCIiY2xX3Dc91k0yRu3x7t5CJhfQXvRjSMn4YTO3ghPDst75MkXzWE9uXN7i9RfC8cRkz1YRjb4cueF2FfgrLWY1zmV5IXt8SuHShlfGRwPKEMogIbbd+NeE3IQFlbZ4V0212U=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 15:47:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Thu, 10 Dec 2020
 15:47:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup
 and start sdma
Thread-Topic: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup
 and start sdma
Thread-Index: AQHWzvSJUfSvfqsTgk6ERe6VoiWCU6nweX6m
Date: Thu, 10 Dec 2020 15:47:16 +0000
Message-ID: <MN2PR12MB448848B30C4C75B1451FF26CF7CB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201210125952.10245-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20201210125952.10245-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-10T15:47:15.213Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daac8a88-83c9-47b6-1a88-08d89d22dec2
x-ms-traffictypediagnostic: MN2PR12MB3807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38070495A0D1A0A594A63E50F7CB0@MN2PR12MB3807.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VT9GGa/8kVVx9pJEFU+h+oF5jEMoXYjG6b5WiIjn8QA7iCk66toOkej9NgiGIwcZDiKCb3EezlomEe4/j5p9wu5rHQGIV5qmJTICtgkE7BwcTYH7Tpjp9fRjtSO28i/AYQ3uvpYPyRtuZ7xmakkQjaXbUeFBsxLyGpc4WuBdICe6jlu5ZNHkT9lsFwrNp7ST7tl+crErOSdq+6iLzHVAmgnu/S0dRkr4tSBFYTE1Fhu47ukXPgFiQjJDRj6ydMk2UahqPKZaoezOE7R13h/vYI++MJNiY3LFOhfJOwFO7eHmqH4s/qDpa3pd2PPlF583nSyskvEPbgenATry9PsiPP7dHsT2/YCKs46jSoauuKE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(55016002)(8676002)(9686003)(8936002)(186003)(26005)(7696005)(45080400002)(966005)(86362001)(6506007)(53546011)(66556008)(19627405001)(64756008)(66476007)(66946007)(71200400001)(66446008)(76116006)(4326008)(166002)(2906002)(508600001)(52536014)(83380400001)(33656002)(5660300002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yaSwoXLjaEuOcQl8ockQtOrcnIHhqZP+0StVcnPibZGW/RIsZLVWkO31LUVR?=
 =?us-ascii?Q?Dik+3YDbJ997mZ21aNqSclaAJXGuR+BXetN7zAKRUgnJCmS/D+WZZjnGCpfh?=
 =?us-ascii?Q?CbXW/bMy4bakPcET4I1l496bhGe9M4BXbRZDP329iHcO/0fFVAs7K+Od3Bxg?=
 =?us-ascii?Q?A1lMYcbrCNgnoj+st5iYCNsYWm6uFEk8S4oUeN0qE1rbue3sVjYfmol91A6b?=
 =?us-ascii?Q?I6wxEkI4GQZnkARGH7gIzfHGt1Awzx9lrp6GAVBg1l1rgBPqkeWHKKKSskBa?=
 =?us-ascii?Q?hTsxgGOAvTSwilBT26lm9w+9uMN7dZ+p/zLDumBsfvveuSUXz/8U0s8Fjr2T?=
 =?us-ascii?Q?L9rSPjWDO9NmkCfaCrlHQjH/hNdRakRHmJHqyfL4n9nH9Ln/K1v9O2mbKOgB?=
 =?us-ascii?Q?8Mocqj62ucy32vOne60sa7cGlfzOCuuVgS89JYKKrTmavZjPqOzt5Kylc581?=
 =?us-ascii?Q?GCA9In62UKcE0/V1AlPJN3T324K6KRcaKjWAoZ84kFeYnkZukPXwDgbQOguQ?=
 =?us-ascii?Q?Gpr4kuVLjg4NiDb2F00kgrEXMdo06N89MrnOOSYm9FStxtxnZmKaohnOWSSx?=
 =?us-ascii?Q?FFQrFdcByJvWlLchSLhQ7FhfzITGELmhqGPJS21cNdPAzcOvBG/ozuKar6XX?=
 =?us-ascii?Q?uDF5dGcPcz8zNsVZBCH3T4Zpen8CLOIYU5NmqwdDCn1qdr7AUxWgusgHqUtS?=
 =?us-ascii?Q?LzIhAxci7swUUIbP5njpOkBEfNkNK0mNvx+zzcef5szG5klVbe8skuPU9LrL?=
 =?us-ascii?Q?G4V/E07yzKYMIB9P6JPlqiroNJCC4Ziyp6BCNqdiEZ9p0XI1zsXsNwJ+/UiJ?=
 =?us-ascii?Q?WxpGtq3f6P8TAe6DpfqVsJ222Qvn6dp+fGPvyhrZ+haaO+NavG+hvck2kuzt?=
 =?us-ascii?Q?fRnxnWSFcQMiDC+q667i8tGDugKDYYCkRf9LXfCw+ghy8b5/EJ067awUlaff?=
 =?us-ascii?Q?L5Y6hVzIf2fD7/4pa6LLEOdnq/F0sqiRQ+DqUlW9nXE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daac8a88-83c9-47b6-1a88-08d89d22dec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 15:47:16.3372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRVCMdvaa6uvh9nKek+ldme9PyKbfDYQLqKk/FtBwG40TouYEVIPttK+RfTKD33MI7LQlt35WFSez4pBnqcXVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============0214839931=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0214839931==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448848B30C4C75B1451FF26CF7CB0MN2PR12MB4488namp_"

--_000_MN2PR12MB448848B30C4C75B1451FF26CF7CB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaomeng=
 Hou <Xiaomeng.Hou@amd.com>
Sent: Thursday, December 10, 2020 7:59 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Hou, Xi=
aomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup an=
d start sdma

Without doing the soft reset, register mmSDMA0_GFX_RB_WPTR's value could no=
t be
reset to 0 when sdma block resumes. That would cause the ring buffer's read=
 and
write pointers not equal and ring test fail. So add the soft reset step.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 39e17aae655f..5acc1e589672 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -807,6 +807,37 @@ static int sdma_v5_2_load_microcode(struct amdgpu_devi=
ce *adev)
         return 0;
 }

+static int sdma_v5_2_soft_reset(void *handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       u32 grbm_soft_reset =3D 0;
+       u32 tmp;
+       int i;
+
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               grbm_soft_reset =3D REG_SET_FIELD(grbm_soft_reset,
+                                               GRBM_SOFT_RESET, SOFT_RESET=
_SDMA0,
+                                               1);
+               grbm_soft_reset <<=3D i;
+
+               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+               tmp |=3D grbm_soft_reset;
+               DRM_DEBUG("GRBM_SOFT_RESET=3D0x%08X\n", tmp);
+               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+               udelay(50);
+
+               tmp &=3D ~grbm_soft_reset;
+               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+               udelay(50);
+       }
+
+       return 0;
+}
+
 /**
  * sdma_v5_2_start - setup and start the async dma engines
  *
@@ -838,6 +869,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
                         msleep(1000);
         }

+       sdma_v5_2_soft_reset(adev);
         /* unhalt the MEs */
         sdma_v5_2_enable(adev, true);
         /* enable sdma ring preemption */
@@ -1366,13 +1398,6 @@ static int sdma_v5_2_wait_for_idle(void *handle)
         return -ETIMEDOUT;
 }

-static int sdma_v5_2_soft_reset(void *handle)
-{
-       /* todo */
-
-       return 0;
-}
-
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
         int i, r =3D 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cc7ed271775544123bb2208d89d0b9af3%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637432020727843101%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DJueaOw9nYtG2XJj1se7uYlKZomuBTa8NnGeVVZzC9Tw%3D&amp;reserved=3D0

--_000_MN2PR12MB448848B30C4C75B1451FF26CF7CB0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaomeng Hou &lt;Xiaomeng.Hou=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 10, 2020 7:59 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Huang, Ray &lt;Ray.Huang@a=
md.com&gt;; Hou, Xiaomeng (Matthew) &lt;Xiaomeng.Hou@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before s=
etup and start sdma</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Without doing the soft reset, register mmSDMA0_GFX=
_RB_WPTR's value could not be<br>
reset to 0 when sdma block resumes. That would cause the ring buffer's read=
 and<br>
write pointers not equal and ring test fail. So add the soft reset step.<br=
>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 39 +++++++++++++++++++++----=
-<br>
&nbsp;1 file changed, 32 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 39e17aae655f..5acc1e589672 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -807,6 +807,37 @@ static int sdma_v5_2_load_microcode(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int sdma_v5_2_soft_reset(void *handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 grbm_soft_reset =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; grbm_soft_reset =3D REG_SET_FIELD(grbm_soft_reset,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GRBM_SOFT_RESET, SOFT_=
RESET_SDMA0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; grbm_soft_reset &lt;&lt;=3D i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D grbm_soft_reset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG(&quot;GRBM_SOFT_RESET=3D0x%08X\n&quot;, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; udelay(50);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp &amp;=3D ~grbm_soft_reset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; udelay(50);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * sdma_v5_2_start - setup and start the async dma engines<br>
&nbsp; *<br>
@@ -838,6 +869,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mslee=
p(1000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_soft_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unhalt the MEs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_enable(adev, tru=
e);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable sdma ring preemp=
tion */<br>
@@ -1366,13 +1398,6 @@ static int sdma_v5_2_wait_for_idle(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&nbsp;}<br>
&nbsp;<br>
-static int sdma_v5_2_soft_reset(void *handle)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cc7ed271775544123bb2208d89d0b9af3%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432020727843101%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DJueaOw9nYtG2XJj1se7uYlKZomuBTa8NnGeVVZzC9Tw%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Cc7ed271775544123bb2208d89d0b9af3=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432020727843101%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DJueaOw9nYtG2XJj1se7uYlKZomuBTa8NnGeVVZzC9Tw%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448848B30C4C75B1451FF26CF7CB0MN2PR12MB4488namp_--

--===============0214839931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0214839931==--
