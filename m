Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16B5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 19:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB6610E216;
	Wed,  6 Apr 2022 19:09:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2417F10E216
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 19:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZlY+xgwzwdVhN0ojbQ+Vhl0p3VXQXgpJYHu1r8P+Vs6936riq9U9WucgBMooE0qYpCk+HKjpDI7PUYFAgLF+04dtSLt4SUSBe7p9wLI526qJlykCh4lD5mtWDDkn8i1n5T+PpAAnTZK9ZTiRZGY5a83qkSCTvBKRikAEpMshiIcS7cKjbwPGp4ufUglr4Ef0I11Al0EfCORUxygJ4vmEopNX6YlwJY8YYg2VDTenFAj06gopckkVbQUTIyQchmabsvCewyALKaaKnxudMmGYYzKNDyrqifzA5qLU0X1k4UXurrIzV7Dyfly/iKe7MDEi+EP09yqWBhZ4s5ewYK1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yAo29qnHIvLogcEz9ZXXcPgjJZb9yrEDZnlmmVdJcE=;
 b=H8eJ93b59U8dMJBgK8Db1pRXCNflUzviQk4LRAdJl9N2dulhSD7ZBM3gmdEZ5yfnyH+PvrFJ4QaIniuL82RJdXUHE1bVXkWKZZLJORw1gIznHHFyGEYNg78wUIO7daGP9vPRqkr7cCulrKGnHVJeq0dg0TGR+y0NTawrC+AyYiw0KOXD7wRg5MV6Hn7x7iDi5AzcCdiXjtW15n8r/ksoCrKQ2IBa7H0d2VuNufhofbkqNiC/ELOZZbAlD9h8UeIc4FTJ9LP4Qjmb/lJ5+/pxGZ8YdIQ4ULyAlb0AAuxb/VfovDi4u2jzycEpjSSCqs1NXUcOKYw7wcQP5MH4cw71ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yAo29qnHIvLogcEz9ZXXcPgjJZb9yrEDZnlmmVdJcE=;
 b=knxrt4lgAY7pNzswyd1KCDBdVY7mP4r0DCDD5meyY1lZsfpamlhEupWukheZjc+GSfAFMisf2cSuXkVjQX0NcT5hI0XJQSfFg4DchWzA+ht9xtHnRJb5BgL5JnzWkbJh2PAl4RlMsEo0vQOtHq+TS7nQZH05jQxW1koLNzNnH7M=
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by MWHPR12MB1215.namprd12.prod.outlook.com (2603:10b6:300:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 19:09:52 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 19:09:52 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix VCN 3.1.2 firmware name
Thread-Topic: [PATCH] drm/amdgpu: fix VCN 3.1.2 firmware name
Thread-Index: AQHYSeX1MDHA7+7XPk6XgrtOjy8BqqzjP9tV
Date: Wed, 6 Apr 2022 19:09:52 +0000
Message-ID: <DM5PR12MB175370AD03D55147A94A2568E4E79@DM5PR12MB1753.namprd12.prod.outlook.com>
References: <20220406184120.540874-1-alexander.deucher@amd.com>
In-Reply-To: <20220406184120.540874-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-06T19:09:52.137Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc14383-59d2-42a1-f2c5-08da1801079a
x-ms-traffictypediagnostic: MWHPR12MB1215:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1215EF0459B79B8AA1089A60E4E79@MWHPR12MB1215.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsPfjTirDp/+YbBgfAAN0SWX+Zh5G54wh/X2vQAm19S1WSk2gKcmRcfl22QkDuxSSrojKJwQVkzJhUTOU6Feo7tISBvs8UnWLpa80y3BjdsG5lExTWl429w7dyj4ZxTS1TavODbNDO90lJ9jIorrV52oz3IA1UY/er/LFv0af4B8O4U6hvQ8KHS00tM+xn39rrM3Nn33Z/bbInbSMvBOSIdWGCpbLnig1tYTB4RZo6k9wmiLsWL40qt/YggpZaFEhWBsFE4OHWRqqxZXDoQPz42GbrNgS2xwVZyb0s4Ll4MoGAH2PqlTWnOR2L9s6iJk4GtAqji9lJFWaBD/qxzwcWr2+KgkSBjcn663dQksy3XHBlvNvYWESdGx/Dvt4/mSwgMVcMI+cDNm7c8K+Z3vVDlUzZilrea/nHFF6xFJpFkm/3ibmcn83rWi/H9PfW5GJKn3md7ConAjTs9Sxj5wl8cL4BjMkGO8wjiOWfKFoTkHwlu8VrxmYekUklnmLhoe9GdCC1iBZfm9A4vZL3pcpB1ThXwYmFSordaz791JP/tCeXesN6qwYiDVeEp8TU+HUNCMinNDzyW4fRX8CtOW8QT+3eJOSU8tquMg1uTDABqtgXshPmwqLtAEw8VLAB5h2u/bD8oMGaINdHwLsE536+MUYJzFAFdSAGb9UCCtsvjuYKYRgXI9XJEOFGsKu4Xo48O6vfL6wST7ZN2oYu20kA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(5660300002)(186003)(8936002)(52536014)(9686003)(7696005)(53546011)(6506007)(2906002)(38070700005)(122000001)(83380400001)(33656002)(86362001)(55016003)(8676002)(71200400001)(66556008)(19627405001)(76116006)(66446008)(64756008)(38100700002)(91956017)(66476007)(508600001)(316002)(66946007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VxqUYEf4j29zpGGqRlqNLpEEbNK/rEpng/HlX3+Fl8Ny/iVQJyz6ALSIuFMk?=
 =?us-ascii?Q?OwI+M5dzXkZEGlSulH8oE2m8vqrcvv33jrGstv2ymJyOFwt0TU39sdotDmCG?=
 =?us-ascii?Q?o+OLLpG66rPQiyBDqO6/rqAt1yn0CpaJX1xKflYmjzuqbU6vJQhU9aJyYRvL?=
 =?us-ascii?Q?QmljTjslbvDuZvK3rMLQEtDp0CWDAxzrT7cwnpJqQej/OLF4vVmrE+pCQErH?=
 =?us-ascii?Q?50pCG2kTVB6Z/dVS8Kuz6f1skrrVvNO2mn2UmN+BSFQ+cMiiCBCuxLTuD+wy?=
 =?us-ascii?Q?Rq9wpSzXoNItPeU4n+OUv0TA5936efU43HK4IBfQVmugPdcgooGWS+a/esLP?=
 =?us-ascii?Q?ROSs+F8DVLdq2HkWrrWlVht4UOvgvUmi4Svd51WHtzJ+SxoAf3AycXkGpqof?=
 =?us-ascii?Q?8zsjueUlEL+KyYauGm9+5ZtMUxK0s9/Qe6VdhUYRWhc8/zcg4skgsLWC2fug?=
 =?us-ascii?Q?JuP+vYi52fNLZ0zbGJ1yL9aO/l0j2osLnt0WrP1UKC3LceX9u6gXuVPE7Nv3?=
 =?us-ascii?Q?57YHuhrT1Q0qKuiZdgJu5d2h2d5/ZLy4jmU95IMK8Q096wSWVtI71gtZNYc9?=
 =?us-ascii?Q?El5M04OvQuVAckpZQsQ0YiXPEdVmrKFavVAoNKGvci0sJGvIv3gkraa4woEd?=
 =?us-ascii?Q?FHBXyw7Bhs9PAJW1oZVsAIbsqJRW16zT+d+3Y277OsYglf3/sVg/0AfhZZa3?=
 =?us-ascii?Q?0q6J5K+J4byZav/vjvjYbyQ/Pr8gWaz2t5M+183fUSp3/MVGQyNw0FO7cDWj?=
 =?us-ascii?Q?iafzYMqT8eoqbR5W8B9PZFCeDh7bNkMR5NJMXpH4F+6U6h4c6tG7JZH2YxqF?=
 =?us-ascii?Q?1qAuvCLdhmwtaeCT/apq1EB3L4t7WZrmnderAtMmrpDMVDD9BxfN5vaLa6AB?=
 =?us-ascii?Q?KcSGVJHDphrf1s89+mC4jbgwpBEGdNaolX+24xA+teFnucW/V2rPQJbtjv3d?=
 =?us-ascii?Q?dQyfWqZwhbTuN5u8Y/ccdi7h7/X7dYcnvyHJP1K7f8EHaKv5Y6toux7HPjo+?=
 =?us-ascii?Q?9HrXz9Ls25SGEkKdtTRaG97UI3GqSyQvMDvyBT71nzRhJlMR1QTn7VjHJY1Q?=
 =?us-ascii?Q?eKfPmWynzFppb6+cMslhLQkU5HqnG0G08dLWZkwFeBq2fOM8iMDn3YXHJQMi?=
 =?us-ascii?Q?6Rpbb3yAvXMxV+H2K6pXeN68brezslbrxLPrYzO15Vg3g6QpjWGt00HrkNNc?=
 =?us-ascii?Q?UopADTyuLARwIXA5lemRJdMHGOPJ1hi32gsfGQ8KCX5MRQCx8jFm6FSo5dYf?=
 =?us-ascii?Q?UVpAFYoXfLVSpcAN7CQV7on65WDeNza5TVE8WPwfsgnp+k2WPgk/0Jy2vxQT?=
 =?us-ascii?Q?kjBq6/TDDfd/9jpTgzLU+WON8xyoXgNF/F5CDRBfSWm6JlHFHPQIOWI/XAih?=
 =?us-ascii?Q?1Qp19HVDtZ+gyniexv8iFPsc+0gVkeq+kFmW6YP+LqfXW0H3ddtHih/7aTJc?=
 =?us-ascii?Q?rysvbdAhGeRYwJ8h0JLdPilCDsOLfK0ypZ1Qcq7HCzyOBWw2D+vJXlQDNLwq?=
 =?us-ascii?Q?zRvSLhGJP+7TxK7CoXjURuTva3j6p+QoWlVpYF4J2rwBmBX7KY3qlchyt8pW?=
 =?us-ascii?Q?cd1BCuV6YS0zAHdzkPk/I0/wLO57RYxOXpP2RHrk7VYnOl161aX07mEf/Xrs?=
 =?us-ascii?Q?X3HEi881QH1T0wwnsVZiVKM5fNKeWYxm50aaAbeZyFGbSrqrityE/5PkaKHU?=
 =?us-ascii?Q?Jn1Ck2RS5pPy2TleeJzdTjY6H5KrbyqVviV2N6dXLf95zqOq?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB175370AD03D55147A94A2568E4E79DM5PR12MB1753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc14383-59d2-42a1-f2c5-08da1801079a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 19:09:52.7194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUUGLQ+29qAt31IpuBovmZeJGSmzn8m+1m56SysXkzWC75VpAmRA79NeNEnnIdbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1215
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

--_000_DM5PR12MB175370AD03D55147A94A2568E4E79DM5PR12MB1753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Wednesday, April 6, 2022 2:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix VCN 3.1.2 firmware name

Drop the trailing vcn.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index f99093f2ebc7..a0ee828a4a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -52,7 +52,7 @@
 #define FIRMWARE_ALDEBARAN      "amdgpu/aldebaran_vcn.bin"
 #define FIRMWARE_BEIGE_GOBY     "amdgpu/beige_goby_vcn.bin"
 #define FIRMWARE_YELLOW_CARP    "amdgpu/yellow_carp_vcn.bin"
-#define FIRMWARE_VCN_3_1_2     "amdgpu/vcn_3_1_2_vcn.bin"
+#define FIRMWARE_VCN_3_1_2     "amdgpu/vcn_3_1_2.bin"

 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
--
2.35.1


--_000_DM5PR12MB175370AD03D55147A94A2568E4E79DM5PR12MB1753namp_
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
</div>
This<span style=3D"color:#c0c0c0"> </span>patch<span style=3D"color:#c0c0c0=
"> </span>
is<span style=3D"color:#c0c0c0"> </span>Reviewed-by:<span style=3D"color:#c=
0c0c0"> </span>
James<span style=3D"color:#c0c0c0"> </span>Zhu<span style=3D"color:#c0c0c0"=
> </span>&lt;James.Zhu@amd.com&gt;
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 6, 2022 2:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix VCN 3.1.2 firmware name</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Drop the trailing vcn.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index f99093f2ebc7..a0ee828a4a97 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -52,7 +52,7 @@<br>
&nbsp;#define FIRMWARE_ALDEBARAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu=
/aldebaran_vcn.bin&quot;<br>
&nbsp;#define FIRMWARE_BEIGE_GOBY&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu/beig=
e_goby_vcn.bin&quot;<br>
&nbsp;#define FIRMWARE_YELLOW_CARP&nbsp;&nbsp;&nbsp; &quot;amdgpu/yellow_ca=
rp_vcn.bin&quot;<br>
-#define FIRMWARE_VCN_3_1_2&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu/vcn_3_1_2_=
vcn.bin&quot;<br>
+#define FIRMWARE_VCN_3_1_2&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu/vcn_3_1_2.=
bin&quot;<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(FIRMWARE_RAVEN);<br>
&nbsp;MODULE_FIRMWARE(FIRMWARE_PICASSO);<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB175370AD03D55147A94A2568E4E79DM5PR12MB1753namp_--
