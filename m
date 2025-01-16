Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4482CC02180
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 13:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB3610E01F;
	Thu, 16 Jan 2025 13:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXu0jcq8";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B77D10E01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 13:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyxmhMLq1n5NI/WZv04yTZmEQqmx8TgO2jUXn/w7ameafZqvcSjyfDPQH8rBspjsvsvFGsk0WQMSSmeytyGp1smETUnQc3McB/S8EJfz+FPSHbi5fer38D0N0eC0mTX8SCNUaMlbSV56GjF0YMh6DUeHVnVZyQcMHE6ZlCLqn0H+JUw2/mR2Us00m23gjGhtx1onsSHFm6zDiQnE9WoTV/ltUBjwI1Pmccoz0tobe0aZHRFckealEOsoo0M5KguFNA4Ilhxsv+TE9yb7CU5QTsuwaavYeni/NRUhmD0faDK6XHMv7Od16qYQl11VkFKFXtjAG6ybulguQhHDXuUECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlkL6eX1UcWC3G7X+eK8SmQbCSM763v5S1U2NqpkvnQ=;
 b=hb2TgTrRqczWoEuosfDzV4eN4YwCqA3N0Vbie9QqpDB7Nl4EKrvS9Pcp142zBY5vQSB0tRvBiHerSdEKTDSF6b+q0/vxTkO0345246eUwF4ULsBeUO4ECTmgsUbhwdKePuugpZymhgDykyMQ5J7gch3NiWZ0ood04QIe+EbtezzfteVH7vtuyGcObGiIttE1f3E4G403Q9tpjooj76mNXVqmG6YnZo1zl8JisJmSvDDzFAQmJyyrJCO3bu2i1De9fRNG5Em0mBYZDUg6BTIVpIonpTS/F00TWOXvkjBCHWE1gq3tIOIhagQkuOojjukxmvahU9oAex6OkLfx3P3o/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlkL6eX1UcWC3G7X+eK8SmQbCSM763v5S1U2NqpkvnQ=;
 b=hXu0jcq8cE09fbkkKHOF6HE/h7tqmRjlq19thDLxoeJQhqx5bDPrw2iOYdWNgI3YtfmaRG+X3IZADPEj9ZIu/amjKVVhtv9UTAlZd9VD79+mdfaUB+hgQ+AUBrHBXSITQukRVDmjmtODAnLzoZk/+s30Vp9PDhnLH0Bc55oZ8/8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 13:02:11 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 13:02:10 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers
Thread-Index: AQHbZ2qenrGEcPLcoEmW/VrRxe9f/LMZXmOg
Date: Thu, 16 Jan 2025 13:02:10 +0000
Message-ID: <DS7PR12MB6071331E7301973B4F53604D8E1A2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250115162820.637642-1-alexander.deucher@amd.com>
In-Reply-To: <20250115162820.637642-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5184eb63-fe58-4898-86bc-f32bfd4d242c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-16T13:00:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CH3PR12MB8935:EE_
x-ms-office365-filtering-correlation-id: 2d467331-4af3-47b6-eb8c-08dd362dfd63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WFEBq1Rultj4lgvEL6QV7VhuLglWLwX9yRXe4ukZZg35XQ5AswijNpkyBtnq?=
 =?us-ascii?Q?szwsv4hDm9W8NBFt1dsTq1Y9czFsSI1N++OGZJMTyfEbEijQPd2Yc5VK9Ksw?=
 =?us-ascii?Q?0/T/xvGjLIs4EkdmCbRZSdXKMtR6ReCVrKHKu6Jg1n0y2xIG0WwrQ9edGlll?=
 =?us-ascii?Q?15/xuw3i40o/gOwimHaObJIVixRrBbWPe3yNndPMyg27ksyHezKJvnp+vjR9?=
 =?us-ascii?Q?Gij1ZYA8I2XeHMBEnnMC7/csymN4zKUoshKrX7eUMqZg0RV41WcmcnuUMwNn?=
 =?us-ascii?Q?e4VjEfpKTDOS/8lr9VZB64X+vrya5WL+nsdMEve0hMzyJihp6nNUC878Drbh?=
 =?us-ascii?Q?8o6wB0/sg4xG3xLv4d31THFo/hXTiLYF+5hwfAgxOZ3DjGt963dj0sziPIrR?=
 =?us-ascii?Q?+vfxcrCWxW4AFNZpCa74ftk/7lQamGtRIH7xT4jjqdd3bON9zz06U8JS6b4q?=
 =?us-ascii?Q?0IRwZgkioaGbsS8gkAx6/bvVeT7/5nacP7ZJCRwtJ8b+39zYdRMFsBet8JUY?=
 =?us-ascii?Q?onpfSxGv0fsTQMvjZ8gyKM+OYTOk8lB3Cyk+jyb9whibAKq8CGo6IDH9TSZB?=
 =?us-ascii?Q?wNDyw4Rbc7QgnXz49hGQfVuaemVX4fn8ksL9DAHnLmCYXB2VGoWgFiJUKqRN?=
 =?us-ascii?Q?6+jO4ySsrD60fP0C1HWXuyxM39cTtGAucOBLQJ08Eg0afiJf1DeEuk4l6Ga9?=
 =?us-ascii?Q?rvLM/VqTJWDqV0IKS+dBZNWHN448rDXMztoOl557CJ6PoQqmA4gf3Y5r4YNt?=
 =?us-ascii?Q?hBR5KGCo/TTgTzgdfDvKYX8u3GOqfRoAEYEXhXKJbURG3Gc6A6xN8VK5aUwQ?=
 =?us-ascii?Q?Kzxp7/oUWiNb954yb9yLu1Q8egoqK7j9m/EyXsjFM9FySG45QNChWUeo9pRM?=
 =?us-ascii?Q?q0pWOQVgM1UBBYADdheTpfbosyqVZOXEXDGVe+ODNM9jH8zA/570/wYlxsA2?=
 =?us-ascii?Q?3Zhp94ksZJXVTlhPua8UwajfVGaJBqDYWcY5uPRsbQDyuwZMDtq7VrK233wf?=
 =?us-ascii?Q?a3+XAPs0kcWvfj0NY6sRAjsBa6JbA6JFhI/Ngyn/pEgfs+JYUvw21sRLxeKu?=
 =?us-ascii?Q?VSLUU+Z957ABKqPukMZbNS9tbvww2rinx0Z/dmCZYYDKZQHkhSWTgJ2WeOHb?=
 =?us-ascii?Q?YdJ+sjp9gPJyuKe3VhgBrIkmZ+w/86gDimLAbh7xu0GsPZrQ6inlq1o8kJsF?=
 =?us-ascii?Q?lP45re3+SkbeHzLbiX0OFYoFezxhVz2AH7QMNZikxgVubNEyUyuXGdQd3ouD?=
 =?us-ascii?Q?Q8/a9NAmwcmNSim61BlEfv9gDWJTByLPqwH7+0JCM2VXBiyZ8s2z2zOEV63b?=
 =?us-ascii?Q?fVZab3f04jySdX/Bz80tYY+1fROB0yuUPm4Gk+w6JVeYbiDwEWwsVI//2E7m?=
 =?us-ascii?Q?nMrPRtXVzgMBJ0Hhjd91x+FIMBF3EKn/tD54t/jkiOWEBF1mKuv3oYmlBRUP?=
 =?us-ascii?Q?qYH0CYM1Qs2VPl5PUt6pp/BV8SMqRlEp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4rYV1dvDa7gltbS+QPM+90h2xgSsLC6gC05LC/72okqAmtkrQS+/fsvsjyTd?=
 =?us-ascii?Q?T4NFP9jhq32mdQ1CSuDv/8gaLrnRiXgNp9nlRL89t3eP+WBrd+gPKci/KCVs?=
 =?us-ascii?Q?+xARBuRngbq14+rU14JFO0Ai+bCgq2Uki/3JhiJySAdWK00AvIYbKypUoZmf?=
 =?us-ascii?Q?2x0repYg5W5lBE+qIX5hmEq0Xx962TbA9x7HKi7CzCkKnNbyhAxKL6FLYFU3?=
 =?us-ascii?Q?W1ZUZH/5AHcj5jgKA/nodiUhmdwJ0EF+AQH968yX9EdEiXB6sWbylLgayaVQ?=
 =?us-ascii?Q?NjwIys/QXINWtiAWp0QmaZ9WfLcb6/Ny9hBoQ/FWo48tGyIJebgmChtjyX0V?=
 =?us-ascii?Q?vh/N2I1S/eSv3J8ahxH4JtOebTfUxM1JkdVA2tRIX1v3JYz23Io5H/6ttjgh?=
 =?us-ascii?Q?ThvERH9nOZGlAYuhLnBOasCHjweRKvZwAK3BYDpKfrVoVBYBnrmQdOcFtL5u?=
 =?us-ascii?Q?W0Y/EKWlxvMAiaIc6E+dsEEHyP/oiDSOl6I4xX3zY1TVVupSbRLkGMFNpD0D?=
 =?us-ascii?Q?wMg1DWi1qsYypP5CLQY4vb9o0MUGdQzB87jgj06OA8GP1pSDEpgms1LQpkQF?=
 =?us-ascii?Q?tz1tMYqscM730Ub8imrFlrV9Qa2A6KzGfSZyM5+Zb44Y4CPBgnsfBao3L5YD?=
 =?us-ascii?Q?TYYUtxy1G0B4wnKJWcwAFcV4OvI5N5k8vcJKMWEUe/wKjbv3tpKs1P9Kj0mf?=
 =?us-ascii?Q?1Plh54QhNadZyyhAW8dURer52Ax+bWRk6o6RplWzmhWLc9ZcZhuAIfI8UftQ?=
 =?us-ascii?Q?rSov6Wj44VWYyAMVHCI/m01Yx2meamwbHmEbGBX+B0mvXQjHVy2/gvEvQGlU?=
 =?us-ascii?Q?FDGqha76sJov8JsQhZpjPjfEp6sGgE6cSkltN+Jsxo7wA/NrIfT3JW/6dN9X?=
 =?us-ascii?Q?o507XRFQDj/+uVGAC2DlY2QRQtXBNT4RYwOd+Fkwl1z/eyvRYdDFnBvKUAGA?=
 =?us-ascii?Q?V+4d6Swn4ADMAh7ThdeR/HiXBvpV9TGoENzajAAr5QqXXPOlJrkJmP/Pn0V7?=
 =?us-ascii?Q?wUbfbqkFX3cUsh9mQwbZ6vP7/GQasgA8lbY7ir0p5tVfB2btUj6nwtLuNdti?=
 =?us-ascii?Q?eK7lDdVh4qnR1hvrV/SXaWQFtHhrvsWWqLqvrTrcjUIrS1w6m30Ur84827LS?=
 =?us-ascii?Q?8jIgSJdME2cPXP6T4P+H0/KNZi6RXi07+Uw6M0WsbVs/QjIGukj9pzdUISV8?=
 =?us-ascii?Q?pGTz/MwNZGX/DbYSUpTPiFwbC8XxAdLjIiIfTyVOiZm6QKUJxCPeI4uGU48H?=
 =?us-ascii?Q?Q8Sxmc8rhHs6+iz/5HZQkPvrWs23x9V0z9w4ZgPRljBZv7BXq+x0+UMv8yup?=
 =?us-ascii?Q?+6LIarOPAMdFoNpZdlAivq3xY6VA7KaozcslOG3YL8gXTRIH1fjvSyZFZoMG?=
 =?us-ascii?Q?pj5e7/92V8dpDPFwjBWrCOvPLNBtSXt7FC5ZgkVc0kfHWotdbNkSV349eYHJ?=
 =?us-ascii?Q?37hR4sRXjAGTcgIMfXBNnkymaQmfw6mT1Ozhdd14b4QfoBHOKQhtlu5Byls1?=
 =?us-ascii?Q?WKrPiro/um393QIl93nQ6QBeYpMoj1NMC2rL+5DKU2+oHP/T7kv5HIvb+Gli?=
 =?us-ascii?Q?D8LnKpz5EOGd9rySBzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d467331-4af3-47b6-eb8c-08dd362dfd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 13:02:10.8562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AZnK9nc7j+K32o+/iwyLmPhtzYAWODgj2mvfjW6zS9inrjJ1EI42JrE8RrnvasAgofb1piEkQAZZWC01NVNnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Deucher, Alexander,

Please hold on to this series, we are currently working on a refined versio=
n, this current series will be dropped.

Thanks & Regards
Asad

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, January 15, 2025 9:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kamal, Asad <Asad.Kamal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers

From: Asad Kamal <asad.kamal@amd.com>

Add pmfw headers for smuv13.0.12 to pmfw version 86.24.0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 248 ++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_p=
mfw.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
new file mode 100644
index 0000000000000..859e7a3813bb5
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -0,0 +1,248 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef SMU_13_0_12_PMFW_H
+#define SMU_13_0_12_PMFW_H
+
+#define NUM_VCLK_DPM_LEVELS   4
+#define NUM_DCLK_DPM_LEVELS   4
+#define NUM_SOCCLK_DPM_LEVELS 4
+#define NUM_LCLK_DPM_LEVELS   4
+#define NUM_UCLK_DPM_LEVELS   4
+#define NUM_FCLK_DPM_LEVELS   4
+#define NUM_XGMI_DPM_LEVELS   2
+#define NUM_CXL_BITRATES      4
+#define NUM_PCIE_BITRATES     4
+#define NUM_XGMI_BITRATES     4
+#define NUM_XGMI_WIDTHS       3
+#define NUM_TDP_GROUPS        4
+#define NUM_SOC_P2S_TABLES    6
+#define NUM_GFX_P2S_TABLES    8
+#define NUM_PSM_DIDT_THRESHOLDS 3
+
+typedef enum {
+/*0*/   FEATURE_DATA_CALCULATION            =3D 0,
+/*1*/   FEATURE_DPM_FCLK                    =3D 1,
+/*2*/   FEATURE_DPM_GFXCLK                  =3D 2,
+/*3*/   FEATURE_DPM_LCLK                    =3D 3,
+/*4*/   FEATURE_DPM_SOCCLK                  =3D 4,
+/*5*/   FEATURE_DPM_UCLK                    =3D 5,
+/*6*/   FEATURE_DPM_VCN                     =3D 6,
+/*7*/   FEATURE_DPM_XGMI                    =3D 7,
+/*8*/   FEATURE_DS_FCLK                     =3D 8,
+/*9*/   FEATURE_DS_GFXCLK                   =3D 9,
+/*10*/  FEATURE_DS_LCLK                     =3D 10,
+/*11*/  FEATURE_DS_MP0CLK                   =3D 11,
+/*12*/  FEATURE_DS_MP1CLK                   =3D 12,
+/*13*/  FEATURE_DS_MPIOCLK                  =3D 13,
+/*14*/  FEATURE_DS_SOCCLK                   =3D 14,
+/*15*/  FEATURE_DS_VCN                      =3D 15,
+/*16*/  FEATURE_APCC_DFLL                   =3D 16,
+/*17*/  FEATURE_APCC_PLUS                   =3D 17,
+/*18*/  FEATURE_PPT                         =3D 18,
+/*19*/  FEATURE_TDC                         =3D 19,
+/*20*/  FEATURE_THERMAL                     =3D 20,
+/*21*/  FEATURE_SOC_PCC                     =3D 21,
+/*22*/  FEATURE_PROCHOT                     =3D 22,
+/*23*/  FEATURE_FDD_AID_HBM                 =3D 23,
+/*24*/  FEATURE_FDD_AID_SOC                 =3D 24,
+/*25*/  FEATURE_FDD_XCD_EDC                 =3D 25,
+/*26*/  FEATURE_FDD_XCD_XVMIN               =3D 26,
+/*27*/  FEATURE_FW_CTF                      =3D 27,
+/*28*/  FEATURE_SMU_CG                      =3D 28,
+/*29*/  FEATURE_PSI7                        =3D 29,
+/*30*/  FEATURE_XGMI_PER_LINK_PWR_DOWN      =3D 30,
+/*31*/  FEATURE_SOC_DC_RTC                  =3D 31,
+/*32*/  FEATURE_GFX_DC_RTC                  =3D 32,
+/*33*/  FEATURE_DVM_MIN_PSM                 =3D 33,
+/*34*/  FEATURE_PRC                         =3D 34,
+/*35*/  FEATURE_PSM_SQ_THROTTLER            =3D 35,
+/*36*/  FEATURE_PIT                         =3D 36,
+/*37*/  FEATURE_DVO                         =3D 37,
+/*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       =3D 38,
+
+/*39*/  NUM_FEATURES                        =3D 39
+} FEATURE_LIST_e;
+
+//enum for MPIO PCIe gen speed msgs
+typedef enum {
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN1,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN2,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN3,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4_ESM,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN5,
+  PCIE_LINK_SPEED_INDEX_TABLE_COUNT
+} PCIE_LINK_SPEED_INDEX_TABLE_e;
+
+typedef enum {
+  GFX_GUARDBAND_OFFSET_0,
+  GFX_GUARDBAND_OFFSET_1,
+  GFX_GUARDBAND_OFFSET_2,
+  GFX_GUARDBAND_OFFSET_3,
+  GFX_GUARDBAND_OFFSET_4,
+  GFX_GUARDBAND_OFFSET_5,
+  GFX_GUARDBAND_OFFSET_6,
+  GFX_GUARDBAND_OFFSET_7,
+  GFX_GUARDBAND_OFFSET_COUNT
+} GFX_GUARDBAND_OFFSET_e;
+
+typedef enum {
+  GFX_DVM_MARGINHI_0,
+  GFX_DVM_MARGINHI_1,
+  GFX_DVM_MARGINHI_2,
+  GFX_DVM_MARGINHI_3,
+  GFX_DVM_MARGINHI_4,
+  GFX_DVM_MARGINHI_5,
+  GFX_DVM_MARGINHI_6,
+  GFX_DVM_MARGINHI_7,
+  GFX_DVM_MARGINLO_0,
+  GFX_DVM_MARGINLO_1,
+  GFX_DVM_MARGINLO_2,
+  GFX_DVM_MARGINLO_3,
+  GFX_DVM_MARGINLO_4,
+  GFX_DVM_MARGINLO_5,
+  GFX_DVM_MARGINLO_6,
+  GFX_DVM_MARGINLO_7,
+  GFX_DVM_MARGIN_COUNT
+} GFX_DVM_MARGIN_e;
+
+#define SMU_METRICS_TABLE_VERSION 0xF
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint64_t AccumulationCounter;
+
+  //TEMPERATURE
+  uint32_t MaxSocketTemperature;
+  uint32_t MaxVrTemperature;
+  uint32_t MaxHbmTemperature;
+  uint64_t MaxSocketTemperatureAcc;
+  uint64_t MaxVrTemperatureAcc;
+  uint64_t MaxHbmTemperatureAcc;
+
+  //POWER
+  uint32_t SocketPowerLimit;
+  uint32_t MaxSocketPowerLimit;
+  uint32_t SocketPower;
+
+  //ENERGY
+  uint64_t Timestamp;
+  uint64_t SocketEnergyAcc;
+  uint64_t CcdEnergyAcc;
+  uint64_t XcdEnergyAcc;
+  uint64_t AidEnergyAcc;
+  uint64_t HbmEnergyAcc;
+
+  //FREQUENCY
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+
+  //FREQUENCY RANGE
+  uint32_t MaxGfxclkFrequency;
+  uint32_t MinGfxclkFrequency;
+  uint32_t FclkFrequencyTable[4];
+  uint32_t UclkFrequencyTable[4];
+  uint32_t SocclkFrequencyTable[4];
+  uint32_t VclkFrequencyTable[4];
+  uint32_t DclkFrequencyTable[4];
+  uint32_t LclkFrequencyTable[4];
+  uint32_t MaxLclkDpmRange;
+  uint32_t MinLclkDpmRange;
+
+  //XGMI
+  uint32_t XgmiWidth;
+  uint32_t XgmiBitrate;
+  uint64_t XgmiReadBandwidthAcc[8];
+  uint64_t XgmiWriteBandwidthAcc[8];
+
+  //ACTIVITY
+  uint32_t SocketGfxBusy;
+  uint32_t DramBandwidthUtilization;
+  uint64_t SocketC0ResidencyAcc;
+  uint64_t SocketGfxBusyAcc;
+  uint64_t DramBandwidthAcc;
+  uint32_t MaxDramBandwidth;
+  uint64_t DramBandwidthUtilizationAcc;  uint64_t PcieBandwidthAcc[4];
+
+  //THROTTLERS
+  uint32_t ProchotResidencyAcc;
+  uint32_t PptResidencyAcc;
+  uint32_t SocketThmResidencyAcc;
+  uint32_t VrThmResidencyAcc;
+  uint32_t HbmThmResidencyAcc;
+  uint32_t GfxLockXCDMak;
+
+  // New Items at end to maintain driver compatibility  uint32_t
+ GfxclkFrequency[8];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte  uint64_t
+ XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data and error count
+  uint32_t PcieBandwidth[4];
+  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is ac=
cumulated
+  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is ac=
cumulated
+  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is ac=
cumulated
+  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is ac=
cumulated
+  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is ac=
cumulated
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[32];
+
+  // PCIE LINK Speed and width
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
+
+  // PER XCD ACTIVITY
+  uint32_t GfxBusy[8];
+  uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is ac=
cumulated
+
+  //Total App Clock Counter
+  uint64_t GfxclkBelowHostLimitAcc[8];
+} MetricsTable_t;
+
+#define SMU_VF_METRICS_TABLE_VERSION 0x3
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint32_t AccumulationCounter;
+  uint32_t InstGfxclk_TargFreq;
+  uint64_t AccGfxclk_TargFreq;
+  uint64_t AccGfxRsmuDpm_Busy;
+} VfMetricsTable_t;
+
+#endif
--
2.47.1

