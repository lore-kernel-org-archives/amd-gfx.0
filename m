Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF05C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 14:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890F22073B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CWBugy7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890F22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337F589BF4;
	Wed, 27 May 2020 14:10:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220E189BF4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 14:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7eP8M2xjhmRFzRMCIGLB6sWaj2UDmLT3Cv7q9MRtDpJBQkvN0wqk9S4sDsrHEUhIy6Cj7uc6UhtdF7yD5Ppxyf3CtzDWwe3bwD5cXCNuLlfyxnB3UhtRBzPqbsxSdINbrmBYAb4u0ykfMs1423ltMX4y3frZvZocRkJZkykvss3/koFSkynUVNGRPscWU+R2XdiX+mI+DHM8VN3r3csVJkhSkeDSa9ebxXL5Pj3wwIZlu6pqPdwjU+tNZ4zfv8E7rE/Qequ7OzHP2IA7ukorLlhqQl4exSGz+KwknHAc8nqlcl1o5lM1lDhqTprnwVorEIlhzzskbTf8trKXXgIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I2XnEMk4KECdzf3d5AEH9WxMnMy3icLw2ItSiLxBsY=;
 b=lwttkUvrnneq0AClotf6c45P60Mw09Ceq6B2JGFlYj5huhLje1vY6ZFOX/g9zMemH/A7SNKOu4e7AiYxYDRHsKm0PkbGn+cnyZI+IsYOjbXfY4mD03bJpRPso8Rxwht+BIRF3Olu7EEogu3ty6lKHT5/rk5U8eWmp02G/O8sgg80jtDwmEQjsOyShwj3aJ1Y4BkBHywWyCGY0G+b3Y1MHUyf2jnruRA9MBBRxnegHhU0UHwzfRbWJSjsA0bW9Gpd1qosiHRbf7Oos8lXJZrhS2WpoCXCPeTNpa68azjXT2myexXfioUGGbhcPvJuNaZdludD+4L3s8r6ncX4f8m/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I2XnEMk4KECdzf3d5AEH9WxMnMy3icLw2ItSiLxBsY=;
 b=CWBugy7e7CxEjGdS6NquJNEeiI+X1g1TQLKyW16dYADfh/z15u42oRbo7vTp1S925enkRGdEUx7mh5yZ+3C7n74J/zSPqeKyooo6NFQvAv21JhoBIBQPZM6kMzMj82jQg8sCtUZlat/6Rp5NuPbWLx5ABLaRbYrQowy53tPGkSs=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB2862.namprd12.prod.outlook.com (2603:10b6:208:a9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 14:10:49 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 14:10:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Improve the MTYPE comments
Thread-Topic: [PATCH] drm/amdgpu: Improve the MTYPE comments
Thread-Index: AQHWM8Hd9R/3o4DP2kKbnS8e45AYTKi7+aDg
Date: Wed, 27 May 2020 14:10:49 +0000
Message-ID: <MN2PR12MB448882DFB3CBB1822B19B995F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200527005736.29308-1-Yong.Zhao@amd.com>
In-Reply-To: <20200527005736.29308-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-27T14:10:48.727Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.51.180.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2aee89e2-1350-4142-29bc-08d80247c20e
x-ms-traffictypediagnostic: MN2PR12MB2862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2862A7CC49A4B1A11567DD0CF7B10@MN2PR12MB2862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdlnXftVewvYdxb1lU1cxUKTOf5m8yDsLGrAGbRip/AT9PBg0ckhKV/E8rBxcyFOqBdXy7EkMhbuXChYG8yGtPbS8bs6B5/K/rnXQh5eerNcmERAHO1MVgYwkh0UESkwr9OaYy51xi6iJNnVwVa71SAwWdK2o2PGaOf0IgGYpdEqVxzw3VKtZLCVUe4qm3A2RSiKUf6FQZwm2dYWDfgAyJjr3X+H8HR65PVxq6JchMa4pPeO8xL8yXgoOao/L5M0yPnwbhFgz9WF2TREyQKRWiLhFEioZodNk9HwifY9aGTkzRJ+Sa8SeB7m2a3J5EvTRQISlCFfC5BolO7IIaOUXUG0JA+ym9WkIXaaSSWojSY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(8676002)(66556008)(64756008)(478600001)(6506007)(53546011)(19627405001)(76116006)(5660300002)(9686003)(45080400002)(2906002)(186003)(86362001)(966005)(55016002)(316002)(8936002)(66476007)(66446008)(52536014)(66946007)(33656002)(26005)(110136005)(71200400001)(83380400001)(7696005)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dFwWLhsPa67+BbzkshgH4FaUYzp/GaxiPmvmMc7bbJfBSn49RTjcy4UzI+YuRGVtfTgUEN54FwBZXpFXUDD1Fdiz8O8+HbJcb+qiZdtBEyHNRiEt/Rfhj1RtlrAE+XLIm3Nt7X1NxPcb9wveGYdIxaM0UUL2znu97Xoyf0JNQpDCrwXmt34Buf+OWDbYgLU7HNtRQus0648Q9Ru2VoWVWZRH2glXytWk8oulO1G77KqfB2q5w/lIhhWCV4VIOOOs6VXyZU6/k9ssaeusMtoTEf9EhDxbWqil6GmEHsUFQYmpXAqmtxtrzdV3gxJ5ZiyffNcw7W3YUixbSsV0bVttq1IRonpinuxKxQBqbCIuxkH6sdG3psXRLTwy5+sHlKB0caI7CVS1UpRHi1AJu76pfkQMVNXuyTaPKK0bm0nKKVB+F3zWai7vC2W9Ltc/RKk4G2BttwBiRrlHSqAh5IVef7LyNOYqteCGmuuDmKCmmqMOMSryaHwkN/8ht8nD04Gs
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee89e2-1350-4142-29bc-08d80247c20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 14:10:49.3053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6OP01svBAK2XKczohSsdQTlo0gii8zEYQTmyyKIwzK56Qu99Z7q5e/tKsjYP90qv8FAAXK/LDLbbIpl32wbAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2862
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
Content-Type: multipart/mixed; boundary="===============1659308040=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1659308040==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448882DFB3CBB1822B19B995F7B10MN2PR12MB4488namp_"

--_000_MN2PR12MB448882DFB3CBB1822B19B995F7B10MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Tuesday, May 26, 2020 8:57 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: Improve the MTYPE comments

Use words insteads of acronym for better understanding.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d65f9b4ba05c..0072ddb59747 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -564,15 +564,15 @@ struct drm_amdgpu_gem_op {
 #define AMDGPU_VM_MTYPE_MASK            (0xf << 5)
 /* Default MTYPE. Pre-AI must use this.  Recommended for newer ASICs. */
 #define AMDGPU_VM_MTYPE_DEFAULT         (0 << 5)
-/* Use NC MTYPE instead of default MTYPE */
+/* Use Non Coherent MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_NC              (1 << 5)
-/* Use WC MTYPE instead of default MTYPE */
+/* Use Write Combine MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_WC              (2 << 5)
-/* Use CC MTYPE instead of default MTYPE */
+/* Use Cache Coherent MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_CC              (3 << 5)
-/* Use UC MTYPE instead of default MTYPE */
+/* Use UnCached MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_UC              (4 << 5)
-/* Use RW MTYPE instead of default MTYPE */
+/* Use Read Write MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_RW              (5 << 5)

 struct drm_amdgpu_gem_va {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C03cfa3ceeaba4d63650c08d801d8fd40%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637261378796371099&amp;sdata=3Dkxt8S5LusNmcfRDbv9v=
gxYlMjPoaA6C3AJIHkXTOq5A%3D&amp;reserved=3D0

--_000_MN2PR12MB448882DFB3CBB1822B19B995F7B10MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, May 26, 2020 8:57 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Improve the MTYPE comments</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use words insteads of acronym for better understan=
ding.<br>
<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;include/uapi/drm/amdgpu_drm.h | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 5 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index d65f9b4ba05c..0072ddb59747 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
&#43;&#43;&#43; b/include/uapi/drm/amdgpu_drm.h<br>
@@ -564,15 &#43;564,15 @@ struct drm_amdgpu_gem_op {<br>
&nbsp;#define AMDGPU_VM_MTYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (0xf &lt;&lt; 5)<br>
&nbsp;/* Default MTYPE. Pre-AI must use this.&nbsp; Recommended for newer A=
SICs. */<br>
&nbsp;#define AMDGPU_VM_MTYPE_DEFAULT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (0 &lt;&lt; 5)<br>
-/* Use NC MTYPE instead of default MTYPE */<br>
&#43;/* Use Non Coherent MTYPE instead of default MTYPE */<br>
&nbsp;#define AMDGPU_VM_MTYPE_NC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 5)<br>
-/* Use WC MTYPE instead of default MTYPE */<br>
&#43;/* Use Write Combine MTYPE instead of default MTYPE */<br>
&nbsp;#define AMDGPU_VM_MTYPE_WC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2 &lt;&lt; 5)<br>
-/* Use CC MTYPE instead of default MTYPE */<br>
&#43;/* Use Cache Coherent MTYPE instead of default MTYPE */<br>
&nbsp;#define AMDGPU_VM_MTYPE_CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3 &lt;&lt; 5)<br>
-/* Use UC MTYPE instead of default MTYPE */<br>
&#43;/* Use UnCached MTYPE instead of default MTYPE */<br>
&nbsp;#define AMDGPU_VM_MTYPE_UC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (4 &lt;&lt; 5)<br>
-/* Use RW MTYPE instead of default MTYPE */<br>
&#43;/* Use Read Write MTYPE instead of default MTYPE */<br>
&nbsp;#define AMDGPU_VM_MTYPE_RW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (5 &lt;&lt; 5)<br>
&nbsp;<br>
&nbsp;struct drm_amdgpu_gem_va {<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C03cfa3ceeaba4d63650c08d801d8fd40%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637261378796371099&amp;amp;sdata=3D=
kxt8S5LusNmcfRDbv9vgxYlMjPoaA6C3AJIHkXTOq5A%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C03cfa3ceeaba4d63650c08d801d8fd40%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637261378796371099&amp;amp;sdata=3Dkxt8S5LusNmcfRDbv=
9vgxYlMjPoaA6C3AJIHkXTOq5A%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448882DFB3CBB1822B19B995F7B10MN2PR12MB4488namp_--

--===============1659308040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1659308040==--
