Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1962ECD4F21
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 21:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59B710E0BF;
	Tue, 12 May 2026 21:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7Pv3GM+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DD210E0BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 21:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdqpV+ZJnjzyLJod7bfGHcVrp8hXVf66khsP/pdt3GtehKWtZIJ92FMALZdM0Xh4sAWMWKL6y/7/rSfHCTPCUD/QrVwhb35jxtSz38svf2row8Ol+R3du8BeZv5RaJ5g5OSpdHxwl0QHAQQtKR8rQWvonKUjHBs9swfQWBNBGQs/X2W92hKwvQkEsrpDgk2lo1ZBOupewqMyf+qAsvqUhOxDH/BPgaXUcZLEgkgZ2xX+hiPedKA/u2o6BOTmrNkyIDcZjoj9och6h85aWjegZvli0eNXrDcGp3Ld7oU86E9gqAbXcEFG9+Nl7co9snbs7E1o2NMnVL2sF/qg48/DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI5QbcZqmOLacur9hfxxNgiIIfZ0RtrQ4eiE08rnq7A=;
 b=h4tnJkLDU4XUET8cTFvOqoeDXNQ1ydwFUCL/THomJaG1mTIuSfMo1VamV0bzjoZTP+rkSwMV90MvifV2najd6rmcCXx6rgLORaDu/FmxGUX6MQMFYCSXDE3N6Xc5fpxngf3/Tz0IV7jdnVB+Mi5CL6P5ckdbCn34WKJFQZzAxC3ZhPA8Epq+dui2DWhhro4rU+CLISBESou19Ps5CMwzjLypawg0Pzqb2twmXSrL5u+G+QwiLTkBkpkZ53DeJwu+2LU/+kHYQchGB+yOj+E4YkF2N69nXvEplwckooOxqyUthQ9Hqv0JT1y97hEFZ09DI9h2278MlaalOhmVs7OrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI5QbcZqmOLacur9hfxxNgiIIfZ0RtrQ4eiE08rnq7A=;
 b=k7Pv3GM+Gthz7TEpFbVynSk8V3fW14ukAIM5Ey4xUpsgIGr3ACesrb3MD3DdhgNl2JT1eviEzoBZMvgPnQ56/sJaRL5ofma8xAiHznk6XD2HMAoeRKvrkDvKMBY31uxbZAgPrkUokgKbXIgqx4ifbWjXRH1XWAsM6vU7uM1vsfg=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 21:25:24 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9891.019; Tue, 12 May 2026
 21:25:24 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue
 restore_sdma_id
Thread-Topic: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue
 restore_sdma_id
Thread-Index: AQHc4kWYBOb6m5lsQUGpMur9ACUuAbYK5wuR
Date: Tue, 12 May 2026 21:25:24 +0000
Message-ID: <SJ2PR12MB8650498A9E36854C050567428C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260512192824.3682569-1-David.Francis@amd.com>
 <20260512192824.3682569-2-David.Francis@amd.com>
In-Reply-To: <20260512192824.3682569-2-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T21:25:24.751Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|PH7PR12MB8053:EE_
x-ms-office365-filtering-correlation-id: 1ba1dfb9-a2f8-4853-2de8-08deb06cfb04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|11063799003|8096899003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: VbEzEWpc6wz6FYHnhAaHkewxhCQ2PbyPKwyrq0jZYm+TpYmUxpIWtGHIZZ38LMaxbsN0Xs8iku8cCdzMmdW9JcNwPpsueG8VeRbLIBsZD5tqbXlEXs/mIW5Vp9g7DCfQlLTxbCgT6aqs51xyiPzSxTNTy44dbMJfggPxJs8xAhb/SzrkoHzCFHjFJNJKMEPrIdijVufa6O9mRDoNSiyKL8JNvN7zX4WCYTiagFb6GmfjLnHJ6ZZzHcCw5xwqTw4Fg7vtL5LOGGESdayiwOiYna0DeAKN2NJ+CnOmWrXRJcfu8rocu1SPl9km3i4lLBjNSRd2ap6zqVsBpJ0f+s4gRWqRJo9t4NmBoyhPtTQzo/eOkNUOTIr7TcwQhml4s38b0OJhacSxiK0U/Ru7c29fgr58ARJl1X3X+cNJH4tSCgpWMNETQGdWrxDvg95uH4NWWh6Th3AyJDEnsIt8LfZm5ugrcn2EeHGyrKeyOA6+zYUf60CH8OJyiMDWJjuCU22xReu2raULQh1NbHtpVB/7basuimUSSIweQdr/llJWT0v3b6sa2sK/2b8I4SJTl7MTCiCCVYM+MicdZzIb21crgytICYKZSP39Gbejkv/BXouQR4IFxD869ICbaxhVgUrQXxLnNgHDLvC6Yc+iidYemA1QOyo2VPm4TQNhbnXlubD/YXi9MJM1DUmF7/VO0X3XNRIJ4nGBFedInYsbZOprLfeppP2d93tYyHE7hjvWR7DZXxifVRfWcJtTfHdbKo/K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799003)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CLoTqLDLdZMxG5MAN2ota0LmXqOjP3/9sx9y/Yne5Q0+sqUIrubGbf+FAD5s?=
 =?us-ascii?Q?vx+4T8kKXptEnhKd0fBjXlgA2GUHfSt2Y1iMlXlKlZq7uwLU/twiWGSlNPlO?=
 =?us-ascii?Q?9bMX4PkGFe72Y1q/iOvcW6W+laRKaqhwIFtv8rryx6feF3Lwr6tnnBJ4iYIX?=
 =?us-ascii?Q?lHV/bMMRqlA67tLJChOHkXOkePKpq3CRFhLKkz/GZ4slwAg68xxPfrSn9Aqz?=
 =?us-ascii?Q?qslMmaper4YDKGyslYz70m1mP5MpWd4udMGXKBSpMiZW/oILSCAVJ68Nz3pt?=
 =?us-ascii?Q?3e9QbsFkMQhjkp2iRk3GbzJ7IjSygW/0J/OxPahp30+sXqI2ngR0VZNdmSeo?=
 =?us-ascii?Q?ahJM7juvysJd/gpcuApkRsfLAZi/LUTAm5SrEseKuezCo2Ssu/tpG5OPE1aH?=
 =?us-ascii?Q?pqZ8J+IoFVcqZ+eRG/1972+QCr55tOxfus0g0srgpDB1tBxJvzxrsJTVgKsv?=
 =?us-ascii?Q?1NHDt0fKIWhdXTGXY/57GFqkCkJUdraZLz+iQ/qNXgyhAOEt6pTPLec+mxa/?=
 =?us-ascii?Q?xc4QoBB86fa4kj9LLjf/F2DZShrFmV/fL22z/GIid5rJTc41lhBq5rUScNnM?=
 =?us-ascii?Q?gYF3Hx+0/TdN/LsrTSCEw5g/YklL2gwjqbPcaYgaK7l4JSQcBG4ILoIFDhGf?=
 =?us-ascii?Q?jHstvFW7uWPP7+AeeMHgsVPOxyxs+WbCdWmrvli6ha8M7tw1KYVTCb9ZC6gq?=
 =?us-ascii?Q?AxeVL8XueEOApO9LJi/OvIrsmi4b/Oa1LiQdayoWwociaZLh4M9w4WB6v0Ez?=
 =?us-ascii?Q?OlvEPLrfOwCqynnR5Ke4iYtlRUYXoubo9lHmHM5ljewJG9/grhCHSS93JJoU?=
 =?us-ascii?Q?TkfYEAFDSZjjBwXYa9gCXAtBVtljpTWFmh4VOqGLEwkNJvlJqZRGaJqWrBFN?=
 =?us-ascii?Q?VsGH9C3BzFB5aakkcVsV/bmNJjg1lbhWXPUZx9eUCK81hQEaW0qObPrxKzfZ?=
 =?us-ascii?Q?zhHRNcFJ5m/MYwygYdz3eGKdmF22uO5ZGbYC4p1nJ1hjMNOrf1Qth5Yjw8Jo?=
 =?us-ascii?Q?6TTAIrPPQTgX4CDz49mHA4X6GwXBhNRvgaVr/hvDgEfI8gnBPL2qPq7Kc5Se?=
 =?us-ascii?Q?HNwrHNfe31kOomAVJaKJqFSno4iFidPQYTrjwqN864l0icm7hTNo5uvin4/Y?=
 =?us-ascii?Q?kjb0nTg7FMcltHYxkwkYE3/UjT8f2lkLjFxNrw3EWLLiorou2drkIYzDBBUV?=
 =?us-ascii?Q?TwNSCTBiIMJ8KQ7NJ2Ui8Iz6dAJnutGKrzE5MsbGhBkZtDTez7O59ti5ecXg?=
 =?us-ascii?Q?DEjOO9+RWg5zofeksSL5T2r5GUGQEzLGySyD84UBEZlZLptbd/LKD4g1fM4M?=
 =?us-ascii?Q?DxuQlG/obTr8Kn074ZPy6B7kTCExEQH794heZUlmiiUDGFqJn2BrEY2I7Zz5?=
 =?us-ascii?Q?i7VPVBSapIv9/u32DhRE3YxlHoA09ltD6OKqTtQ7awmRr67CydQ45PtOnfwU?=
 =?us-ascii?Q?SwMd3gIr2mcuxKSfCFYTsM3BxMYPIRdtXtDP8f2beQ/S+1ZaBj7gkzs4SqjB?=
 =?us-ascii?Q?eZ8e+s9fq5DjGqX30CIRFl4T/40ikurUlHz65RgIml49G1Y9GnrtxWBj8+5E?=
 =?us-ascii?Q?3nmwEBgZPUzy/c4pMwlZYBg8aKIxP741jsg4b7lDQz6t5wrXx+oiEWy60fjM?=
 =?us-ascii?Q?vmxC6A98JmZuhs+MabaFDZJm2CrDdP0IIUTCIqPDM+i/OhP+q8PbnBOKXfHm?=
 =?us-ascii?Q?jQaQXFoj4Vqp7A9rb1l1mD3xErHrT7CU6bJ9fWESEpS9t2NC?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650498A9E36854C050567428C392SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba1dfb9-a2f8-4853-2de8-08deb06cfb04
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 21:25:24.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GVFpD/izQuNAdIw0TRhgoHQJt66kcDsjt2fQuQtJLDhUWP9w3sfMb45X7fXaNQpY8Vxq9sgU3gaGctXo6z17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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

--_000_SJ2PR12MB8650498A9E36854C050567428C392SJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

This series Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of David Fr=
ancis <David.Francis@amd.com>
Sent: Tuesday, May 12, 2026 3:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Francis, David <David.Francis@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue resto=
re_sdma_id

allocate_sdma_queue has an option where the sdma queue id can be
specified (used by CRIU). We weren't bounds-checking that
value.

Confirm it's less than the maximum number of queues.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b4cc74138f1e..ddbc4bd8ab10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1727,6 +1727,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                 }

                 if (restore_sdma_id) {
+                       if (restore_sdma_id >=3D get_num_sdma_queues(dqm))
+                               return -EINVAL;
+
                         /* Re-use existing sdma_id */
                         if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap))=
 {
                                 dev_err(dev, "SDMA queue already in use\n"=
);
@@ -1753,6 +1756,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                         return -ENOMEM;
                 }
                 if (restore_sdma_id) {
+                       if (restore_sdma_id >=3D get_num_xgmi_sdma_queues(d=
qm))
+                               return -EINVAL;
+
                         /* Re-use existing sdma_id */
                         if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bit=
map)) {
                                 dev_err(dev, "SDMA queue already in use\n"=
);
--
2.34.1


--_000_SJ2PR12MB8650498A9E36854C050567428C392SJ2PR12MB8650namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This series Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@=
amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of David Francis &lt;David.Franc=
is@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2026 3:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Francis, David &lt;David.Francis@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queu=
e restore_sdma_id</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">allocate_sdma_queue has an option where the sdma q=
ueue id can be<br>
specified (used by CRIU). We weren't bounds-checking that<br>
value.<br>
<br>
Confirm it's less than the maximum number of queues.<br>
<br>
Signed-off-by: David Francis &lt;David.Francis@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index b4cc74138f1e..ddbc4bd8ab10 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -1727,6 +1727,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (restore_sdma_id) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (restore_sdma=
_id &gt;=3D get_num_sdma_queues(dqm))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Re=
-use existing sdma_id */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
test_bit(*restore_sdma_id, dqm-&gt;sdma_bitmap)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;SDMA queue al=
ready in use\n&quot;);<br>
@@ -1753,6 +1756,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (restore_sdma_id) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (restore_sdma=
_id &gt;=3D get_num_xgmi_sdma_queues(dqm))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Re=
-use existing sdma_id */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
test_bit(*restore_sdma_id, dqm-&gt;xgmi_sdma_bitmap)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;SDMA queue al=
ready in use\n&quot;);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB8650498A9E36854C050567428C392SJ2PR12MB8650namp_--
