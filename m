Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA71C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 16:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA220656
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 16:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A5vGdaXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D662D89362;
	Mon, 27 Jul 2020 16:15:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8077E89362
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 16:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNMwiUKXmq1xAWhOkVIAMoAnE4k5qLoswrbdeEv0qkW37+2ZT8ipnGtFju+q6uIeMIQ8Sn8e38rFtnifYcbqn0QJ3I/pZepyHFxB7ONpW1p1MUDv49WOG2zKnLhLsMHn+Qbs0a60oJRwa23r3EaJ6ccIjniqm5corQczSvOXe6Myo242F7OosgkIYp0/73XdGwnh+I2HM8NW8huVmXufYjXtDGT6j2zueQWR3SAgzYRpv8kz/yywBdzUc5/OPZG7wlnDX8Fnh+1g1PFExuggix0dcKcIrO3+jInHWPIN0MWiWZUVDkHxGuFWHLBtIp69mxqaxcs8WBP9BbwIs4fz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8NAEzU2BBVr1jAGBWPPZmLxnrTtt1CZ4Qh+1b5R83E=;
 b=CaVaNH6ZYzIidl4xSVrF0DIcYd+016AkugD81sb6dk/ifrZ/qzrXI4WYom/Otsi44iz7Z8f8gt59qjWLJaqsE/4VkX1Xe+g5+6xEoeb+a5KgufQArccYTZJ1uB23cu5RObTN2Ovpj2zMFl8eTMufS8Rmm5hXrJw0NQSPPjRq/aRwVZAHCkCWdLtRMcM36d34bkFTuPPauS8bebtFzWEpUtacdpPOcHCPBwXYRFFu5FczYv9BuGM9ut93x+QOPFNhZEpPWpBuXVEEuicaj0ovekeygtN1ccbSRCPptFsv2LoMQRNmHvtFA94l6iwLA2fHHtyX40yToZCPwWAUPnlEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8NAEzU2BBVr1jAGBWPPZmLxnrTtt1CZ4Qh+1b5R83E=;
 b=A5vGdaXU1TIkLto4YO9T/nXpuVK8Aqomf4P2NnjeB5E3tkWnGyzKx4wif0aivE/epcxBcEfeM0npOIggkQCugqTNraUPHjiBeiSR8j/FLctboV+RSgpO4F6vuJlWl0vWV3Nyvgm9YXMoJfRzVSetc6XyCmurE+nR1PeDH3sOJTc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 16:15:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4%8]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 16:15:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Thread-Topic: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Thread-Index: AQHWZAS9QZPgt/1n9ESyHThaZzgbBKkbmiSn
Date: Mon, 27 Jul 2020 16:15:32 +0000
Message-ID: <MN2PR12MB44885D61B34CBB6EA544B942F7720@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200727105720.401290-1-ChengZhe.Liu@amd.com>
In-Reply-To: <20200727105720.401290-1-ChengZhe.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-27T16:15:32.078Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.190.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8263b79-e3e5-4ec9-adc3-08d83248499b
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4063BFDE3C014126C1BA0718F7720@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7Scb08UY0vf8UYYP3ihCrANtZwAjGhBefCbbVTM9IzcSb3CWbO374hO2Kmm3OVObyLAj2zRP70pZEq0z/M9IjeMvSkh8OOuI/UVc2N/WQAjFSZztPvEsS9kaVqx6Ao0puDAi0SgtR47MWoiaq4UyUCszA2K6BB4cJ0sYiOEDckUBUr47ggt5mYWeo/Wp5scWAxiC/wrMTAx+aChoPB/Mp8UqQC+gOjkgVN8164R2JZafLlLUyGFaoTeSwP/wB2SnpI3e8GP5SDRPC9wYj7smv1hREjnmZZnP8wUYdip/rjNgUICix7n/NDc05szDr7B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(6506007)(9686003)(52536014)(19627405001)(53546011)(8936002)(478600001)(110136005)(4326008)(186003)(316002)(33656002)(26005)(54906003)(8676002)(5660300002)(76116006)(66556008)(66446008)(64756008)(2906002)(86362001)(66476007)(83380400001)(7696005)(55016002)(66946007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: x4GXV8aPbJieFEeX2ziExc3UG6VZyy+dhw11BqcgoECn2d7XLOf+DJr3bR2XSyoDvN3IPrDnGQUqx9Gzxc+kQHQ7mjud6lcVnUEeyCEuG4j8J01eaWU7jCXxZmGetCxqPrzlIeHF+DPpmMe3QCpWu6xRzam8YNN5OXua7iGvCR5JgjBgwD5/JcmxRJpkB6HxPI5tRuaolTAz6cdiMsJHwMNTnuutqUysFMDfKqS4X1cqtb51AB6d43/Bdc6VHKGP8KtOntNqfmceoxgx6X6qJXtrq0Ilsmd6wzgrIgtaOGaBsNyorvCOs95tlokXFoj/e7hcnknaAVv5P0kz65/4qM1JaRxm/cDg6QHhiMdR6peBxAlCClyYIXd+H/whqdrDdcHMBcdbcdZCwbHQhiv0Xw0bBv168lNNnLziaNwLrtkwmsIZHwxQFxGEEL07hdSBvrftmH1izW+UqjPVAKZsvKVHc6l/3grV1v11w+rlnBBMZ/wjPVzTBdyTPmB0perD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8263b79-e3e5-4ec9-adc3-08d83248499b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 16:15:32.5415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzdKHg5cciqjXzwE4mR2ZsCDvkhCWF/H2M6BsIogYB0x8YkXFtKQS1z2tCm8FgagO7Ypm4aqCjc6M7Bese6W6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1417325050=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1417325050==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44885D61B34CBB6EA544B942F7720MN2PR12MB4488namp_"

--_000_MN2PR12MB44885D61B34CBB6EA544B942F7720MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please fix your git setup to use your name rather than "root" as the author=
.

Alex

________________________________
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
Sent: Monday, July 27, 2020 6:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Ja=
ck.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feife=
i.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiao=
jie.Yuan@amd.com>; Liu, Cheng Zhe <ChengZhe.Liu@amd.com>
Subject: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV

From: root <ChengZhe.Liu@amd.com>

    1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
    2. Check pointer before release firmware.

Signed-off-by: root <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a053b7af0680..a9481e112cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         psp_memory_training_fini(&adev->psp);
-       release_firmware(adev->psp.sos_fw);
-       adev->psp.sos_fw =3D NULL;
-       release_firmware(adev->psp.asd_fw);
-       adev->psp.asd_fw =3D NULL;
-       release_firmware(adev->psp.ta_fw);
-       adev->psp.ta_fw =3D NULL;
+       if (adev->psp.sos_fw) {
+               release_firmware(adev->psp.sos_fw);
+               adev->psp.sos_fw =3D NULL;
+       }
+       if (adev->psp.asd_fw) {
+               release_firmware(adev->psp.asd_fw);
+               adev->psp.asd_fw =3D NULL;
+       }
+       if (adev->psp.ta_fw) {
+               release_firmware(adev->psp.ta_fw);
+               adev->psp.ta_fw =3D NULL;
+       }

         if (adev->asic_type =3D=3D CHIP_NAVI10)
                 psp_sysfs_fini(adev);
@@ -409,11 +415,33 @@ static int psp_clear_vf_fw(struct psp_context *psp)
         return ret;
 }

+static bool psp_skip_tmr(struct psp_context *psp)
+{
+       bool ret =3D false;
+
+       switch (psp->adev->asic_type) {
+       case CHIP_NAVI12:
+       case CHIP_SIENNA_CICHLID:
+               ret =3D true;
+               break;
+       default:
+               return false;
+       }
+
+       return ret;
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
         int ret;
         struct psp_gfx_cmd_resp *cmd;

+       /* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not setup TMR
+        * (already setup by host driver)
+        */
+       if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+               return 0;
+
         cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
         if (!cmd)
                 return -ENOMEM;
--
2.25.1


--_000_MN2PR12MB44885D61B34CBB6EA544B942F7720MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please fix your git setup to use your name rather than &quot;root&quot; as =
the author.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu ChengZhe &lt;Chen=
gZhe.Liu@amd.com&gt;<br>
<b>Sent:</b> Monday, July 27, 2020 6:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; L=
iu, Cheng Zhe &lt;ChengZhe.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: root &lt;ChengZhe.Liu@amd.com&gt;<br>
<br>
&nbsp;&nbsp;&nbsp; 1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operat=
ion;<br>
&nbsp;&nbsp;&nbsp; 2. Check pointer before release firmware.<br>
<br>
Signed-off-by: root &lt;ChengZhe.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 +++++++++++++++++++++---=
-<br>
&nbsp;1 file changed, 34 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index a053b7af0680..a9481e112cb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_memory_training_fini(&=
amp;adev-&gt;psp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.sos_fw)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.sos_fw =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.asd_fw)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.asd_fw =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.sos_fw) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;psp.sos_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.sos_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.asd_fw) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;psp.asd_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.asd_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;psp.ta_fw) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_NAVI10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_sysfs_fini(adev);<br>
@@ -409,11 +415,33 @@ static int psp_clear_vf_fw(struct psp_context *psp)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static bool psp_skip_tmr(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (psp-&gt;adev-&gt;asic_type) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;static int psp_tmr_load(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *c=
md;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for Navi12 and CHIP_SIENNA_CICHLID=
 SRIOV, do not setup TMR<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (already setup by host driver=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev) &am=
p;&amp; psp_skip_tmr(psp))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(str=
uct psp_gfx_cmd_resp), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44885D61B34CBB6EA544B942F7720MN2PR12MB4488namp_--

--===============1417325050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1417325050==--
