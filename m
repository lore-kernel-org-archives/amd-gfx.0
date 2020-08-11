Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC0C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159602076C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1dmwGH2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159602076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61636E505;
	Tue, 11 Aug 2020 13:19:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930A66E516
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK5CAYMNtvu0LxDt7u3A55nHl8WF9EL1+eEtECIX4cPmK3OrZylduxn7Ut7iGEEu7NIW1ac7tw+hsWpS8GVmgvEVd36sQubLF0SQfTqCjDVTl6V3/uIipn4w0eGojtgUGXpO/SeWNhN8gdrlXdzQ1FYE3ghJvfFzlkQ8cnBrhoOY9G4OFL9rgxmvH66rRBUPmJ6FIVYc5SQZTvWJd4uXYtCLb8fJMVi3uYJxXMLf63kS4I8gJVifUT7fB3WFzjY4KvCIRysTNu6X9EiaITL7i/+1DVJOiFKYkxIEcwIg9zsmGXx41hzeMH6ZgaYSFrKUIYCYwXC+DkQwbAPZ25XrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOhjUehYEF9oOy1VCvVr/R0p7mwOJBuYaCNNorMfA98=;
 b=RMlqOv4skciefwdVYW4O/MsI4xO97DWqZpnV+ud6ZxqTEM9yvo6Y8Z9QvBOdtxMSPZbB+eFYD2mwszIhzXsq0ChJfCpwZF8nAa4Jg92i8xJPQh5BtBeKYcW0dR4EpUuRKwd9gtFzFDYLibNDWN7Q7MFso7inqwViJfj7TDcb5ONCbb88MC/0whlrbC0sBnMS4m7Fo59dlhJ6l1Z7aGFJ6VMt46UUNv8JXNizzh8E8MwL+YZlvgIyhVKyhXGKl1crgPfVXhJGq/5JFXq2r4VbQrvA3Y82NV+eGFORDfOfJu0O5iaZRYjle6m7DBMbsuWdvI29LoRiHfUeGJmjzVD/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOhjUehYEF9oOy1VCvVr/R0p7mwOJBuYaCNNorMfA98=;
 b=1dmwGH2HrxgJq/uhk912EFEd/texwzbzk7shbP0bEYVL+p1lniQnZ8G9nn2BqiyQ+daUhzfc9o+L6cBpr5xtrj8saZTn2P6g7/WA1V5OeQBMaUGWEgHjup2Fzdi/7kqTTMYlWRadnaATRBOTp5nZlGSmKqGCHMrz9D7LlmNRfV8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 13:19:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 13:19:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: bump NAVI12 driver if version
Thread-Topic: [PATCH] drm/amd/powerplay: bump NAVI12 driver if version
Thread-Index: AQHWb5DAYnx3QlkOd0+meH//AZkeNKky5NrW
Date: Tue, 11 Aug 2020 13:19:25 +0000
Message-ID: <MN2PR12MB4488FF353B7E4037EBEA514AF7450@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200811033716.1114-1-evan.quan@amd.com>
In-Reply-To: <20200811033716.1114-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T13:19:25.317Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7927a70d-533a-41ec-5a23-08d83df92b80
x-ms-traffictypediagnostic: MN2PR12MB4287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42879EA7DB761B5C323A88ADF7450@MN2PR12MB4287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYL6gTrhA4wtA31fFruCp71KAWEpafdLlca+qfiVjywAfpW02WXe/EUs2avnmW+naKehOrr98YZ9rsNq9xbz15GcuuT2DBWpjLITTyYfqiJvuzZvSc+up01uR9wi16LJo0dNei0czx/cbx1M9a1hfa9/qpWFjS/4G/pyCQSQMEBB2wYazOjWhbply+evOD+446XcBDGkC7yjrmx8lTtUwXhR0pdXKFeiMQEWAp/1unfhdk5W49XhRJ770vSoV9Y+UuzMXWDL36+VjYPuy4vqxD0NvP6xZz8sJ6vCkrOm+UkRaBeM04Lw1H0v+O1H2Dl0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(186003)(26005)(53546011)(5660300002)(6506007)(478600001)(8676002)(33656002)(8936002)(7696005)(2906002)(52536014)(86362001)(66556008)(64756008)(66476007)(316002)(110136005)(9686003)(83380400001)(19627405001)(55016002)(76116006)(71200400001)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 277inSN9+/CRZQnARMYsvZjacz8Yt3xQ8neIimPGBCEeqFKprGepRiU7FPPq5Ima1c8f2G6Fu/ef8hVzaj+rDP7Il1vR07h49Jb8/noHDGLYNXNy79IsqS7eLVYuPExqHAfIu4UYPydYYXMH+OxSWaLKvs4n1Kwty1RW89FOk1IUFhI9NZYdlrgFcwdJ8f9XE9pEA5PmjS4xIbZTP0hJ4WMcKobpsZOKYimQ5qj71rN8fiI14lhCNd9Y9N0hAB2niE9OfTXbP42Q19NH3E5f7IE4bBoq93sl2t1i7j4mC6Oi90dSnWLjJB4p/kSQX7ekq55c9byRBEFIL9uwN9JHn6dOUJoSH+Lk+olpbpKPKryvmNKl9ibYjNoRJdUIdiRCHqSxkTKYR8d4ZjiAmUrwqC8c2A6iuBm4y80kDxQeq2iVcqkUIxgYgWbdiKhtwUK3Y4rAr4+d2g8/5GC8ZOrT2ZzRzJV/XrGZytsrLUXwXG2FECSbTO5CBhL69heYKYYRDkiAYhjoPofDihetRAuRQbFhlIF9uFw1OgW46TvFx2deH/Qfm69cf2POU/RgJi0FnsKY7Ew/dZuvL3rZDdbRQlKhFX1SJNXCZCbVq7gz1TzYQIVSOOpUBhH2ebXYSsop+AHev7VAy4zJTeMI6e7qHg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7927a70d-533a-41ec-5a23-08d83df92b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 13:19:25.7803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHXdzp7JvAfg0IaORw/Hrt+nw7tuRG/KmKKlGeU07HVPVN4mZgbOO1SxYehEtWtUNwPa//PweF4ZnE3L1RmZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Content-Type: multipart/mixed; boundary="===============0542449491=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0542449491==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FF353B7E4037EBEA514AF7450MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FF353B7E4037EBEA514AF7450MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, August 10, 2020 11:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/powerplay: bump NAVI12 driver if version

To fit the latest SMU firmware.

Change-Id: Ic9d02de54d20b6b90d18bac8b3fbb356d8fdf3ad
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index ee1506beb0ea..65363d56e3cc 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,7 +28,7 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x17
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
-#define SMU11_DRIVER_IF_VERSION_NV12 0x33
+#define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
--
2.28.0


--_000_MN2PR12MB4488FF353B7E4037EBEA514AF7450MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, August 10, 2020 11:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: bump NAVI12 driver if version</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">To fit the latest SMU firmware.<br>
<br>
Change-Id: Ic9d02de54d20b6b90d18bac8b3fbb356d8fdf3ad<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index ee1506beb0ea..65363d56e3cc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -28,7 +28,7 @@<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_ARCT 0x17<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV10 0x36<br>
-#define SMU11_DRIVER_IF_VERSION_NV12 0x33<br>
+#define SMU11_DRIVER_IF_VERSION_NV12 0x36<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV14 0x36<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FF353B7E4037EBEA514AF7450MN2PR12MB4488namp_--

--===============0542449491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0542449491==--
