Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2CECA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 14:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C991C1121A2;
	Fri,  9 Oct 2026 14:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZuPV2AB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02E11121A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 14:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olrpc6ddBqE9j5Mwsk3XgEjFmSjg5CRSDNRsRpmU65ZwJH5uYK4WwazTHuMe+2tg0WqvvmPmqnFEK2tNRQmIVHkkWv7dGV5Z8+jiC605fEBfdONCio3gOk9Vb9s9mtM82Q+8GXuSAy1JrLARqi98d3FGdybKWG4s94YzTnAqsCCzS3zq/kduMrqtRTCDsy8K5mBxSMVw3hoMfAM2/eF77r05USu09geRtwMo2xajqR+fuHwWwSmuSFKKuKI4Y3TU+ta47HH22bxyPAwKTNCqa3zkwBvx+iufwQbZgAD6u75JvgxliKBe3eoHGKRRyAUPp1InHlX+eGSGtoo0alH/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZn6hPS3LEg7dFGRDief9kIS/rae9Q5hy9uaaN2VN48=;
 b=EajTewcepuDNzFsubLSt2wlcOpUCp3g4gQ6vcZ5TWRqqgwc3eAzrH2SzYLsrYbeKnHU+rNusRjq3V9OjLmSuqp6YsD/zNVVUY4uO3jXLeb2onouhl68d53yvmOqQP90ZzR8LE4rivCdVr1cY5DX0XbQjsi1IrcCEMMLkRORKRc31oW4B3QP6lCnTB6XtQnC5Xh4t3MckLr3GmkduMhojt+pXQLFFJsFCh1J1K4OG+eXvzzJFbcflq1TK0PinRrS/S0B5po/8DjT4mThN3tFhE3OlS4de5v6p8Q8H+8t7BlvypgySDWdcGOkQn3Hg2yWHT/r/ubj2O783hSj97k+Lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZn6hPS3LEg7dFGRDief9kIS/rae9Q5hy9uaaN2VN48=;
 b=nZuPV2ABxO4ZiDICASA9NFNlywmCqB/3vVRC49qs9UEdd/dapJpZlPlfj8AWQHRWU58mx2WIxm5AB6AO4I+YusKFOO3xi8LwuDkL4KxTgR5bmMZACRRw0ShPh2fdbU/K6TfdRvOjvJ9VjTMPYE6HKs95CfSwMB+1hJpG4L+qgMI=
Received: from BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 14:42:12 +0000
Received: from BN5PR12MB9464.namprd12.prod.outlook.com
 ([fe80::75c8:22c3:b9fe:2f78]) by BN5PR12MB9464.namprd12.prod.outlook.com
 ([fe80::75c8:22c3:b9fe:2f78%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:42:12 +0000
From: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: wake the GPU before toggling mes_dbgext
 from debugfs
Thread-Topic: [PATCH] drm/amdgpu/mes: wake the GPU before toggling mes_dbgext
 from debugfs
Thread-Index: AQHdVvGtDV1XzMXfqk+Ylq/uIxkVIrb1SrMj
Date: Fri, 9 Oct 2026 14:42:12 +0000
Message-ID: <BN5PR12MB946425AF98949B55BE582BBFF4922@BN5PR12MB9464.namprd12.prod.outlook.com>
References: <20261008065244.3608002-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261008065244.3608002-1-Jesse.Zhang@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T14:42:07.760Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN5PR12MB9464:EE_|PH7PR12MB6468:EE_
x-ms-office365-filtering-correlation-id: a8230fd5-0daf-4318-b4fd-08df26138162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|10067099003|11063799006|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: XzFglQV83mrzfaasr0rJg/aO7/xKm2D1dsMO47dszYGuSkWyCS8WRYQOzMV1i2ZZU0hEmGAoNOVHvI814qJWpXT2P2pIAueyl4kX7/FpB8z17U/nD9r4eCm0h7Q0ZNQ2YxQIZwtwLQUHWOO+LXl8mk9SW9czGdh86kWRWGJdv2eJcYpsYXQ3ZTsvWLhcUzpVzrUk6Wc3swwGL84/wUR96TQxr69ZMIJT3nqUXuqP3mAyBVEsLX9+DPEXo+h1rS1cGITQmJk75y2hWPCLjOqpn9w4HuAgvaAgB6qyf2tIPawsz1nwNzRRg7PQJaxKeQA+2L8bUViXdxQUmITvM4umdhEOY8ro9AZS4XK5bDhxgOm/X+v0Xpc+YuAXtkOEdgF7VteGyZlrUC8LyKr09wt+cPndAmelG1HUq1u6NpYsSmu9Oj6VSMXtASebG8j5kiwptVLeVd2OkpQuyVUxdgZrJd4oBbayQpvzxBw3cUO+Q3gFSLNINwmUFncI9xYPGgFtxqTHWIwF1alxCWiSHC7jS583olmZ9annSjjiammIx1NUnqOsQmMP0/S7eqpSSJuX4dYKeFogkkxyDGmIFqqEwkTcMtpyGFAhPS67UMguqQZfrSoBRof6TsPrgjBeEv+KhrXIFXu4U7VOwHXuQCc8s59aEy93+vkjydZ4NJhHYhSldwxJjHMEDEjdhzzw4u8YywgdcOYeiKlk7jLGz/LXU4OV6CTUEaMRzenVTfqTojk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN5PR12MB9464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nATVB6awgEOHw88f+hQs2792GuAiSX/2AF9LDh9UYRQ91ehuH3wE1DE1fK?=
 =?iso-8859-1?Q?xHMVIXkdte5/Ms4JlRvkeMBZbUf3LVJ1PGYQJkUpDOSJ6ru+OS1thy8OOj?=
 =?iso-8859-1?Q?ADtNx5n6e5E5PhBN5YqPilkl/IkkIMd8VcWUN7+4BXkFNUr9e376DO2rnC?=
 =?iso-8859-1?Q?gKu1qu5EVZDTMW65Vioo7Np2BTdDedj+sMMONTWmQbkh0ITu3AR/1RqXPk?=
 =?iso-8859-1?Q?p3kUjWFjhrSTK7tLTm3CqMB2eO5ouNLMraak1o+FSWPM85LoavmQEY9QM6?=
 =?iso-8859-1?Q?78oCrIlwldf+ATljbrlVmZ10llDpqwfw3FEmEaoq2c+oUH3o2pr9VZyeDZ?=
 =?iso-8859-1?Q?t4H0wlkL1GvPRStpaL3pebxXYfLaMqy5dZplYGhfWwiabCNucDb0gxyPrl?=
 =?iso-8859-1?Q?rmw/SAN4sW5UldCwxRUl0RHHMY33MjmHTgRjIigrevSC0tpGoDOCO1deGc?=
 =?iso-8859-1?Q?P+aco3t5i3V9YrbKkvEfinQhjASnwtLBz9PuOTutGq8V0e6nbzjOAvhSPu?=
 =?iso-8859-1?Q?ljrraKKhQInGtkbwkacN1XcIvhSdWcVAFZX1diQJN9irn4RKSO6KKFt4tV?=
 =?iso-8859-1?Q?CjWg90eFEE93UkVziMbr5FPFhCtcPa8TEajiWiJxvwhH9qhS/oln4L95kU?=
 =?iso-8859-1?Q?yDne3BSagkMWMYc51ZYk8lEvIMIoJQk54DoBbLy7GzwgIjSdzfBBaXtjxm?=
 =?iso-8859-1?Q?WfASlijjW4dPUb1NWWVqHBesjrIXlrRO7aDe1tammQ4N2ObLwyxbLjXkf0?=
 =?iso-8859-1?Q?u6po4NnqRcAwlZ0Ra0y/wyG9aEZicF53XpxuzuR1k91LEOVqIvm/Dww1Vk?=
 =?iso-8859-1?Q?QVwS2aI/ypmcDqsWIFnR0+gIl5jwulAtoYVD5RLPxQcIy1OtD3hyDr3v3s?=
 =?iso-8859-1?Q?t4sxz394rwEnkvW19lUiKUw6xA0xxc/YwcBSeJpJAMZubsReJGzpVevzct?=
 =?iso-8859-1?Q?kLn2l4GDhVVi8HshsWwyVlSgjQtDJMWmXRw8AWUZHk4PI13nqu1NwmWxqK?=
 =?iso-8859-1?Q?iA6eUqwYR6lrAW8BFZv2P3e8+kptlzb7vmAHovqwpHvXJEJxRIOcppoeKE?=
 =?iso-8859-1?Q?ssWVmn0BGIC+bjCa1emLSMtZ80gVBejY3yTyD5NF9V/SFHd/HHaNKiN9dW?=
 =?iso-8859-1?Q?CMeLfIgZmNRZ2oCYXUcxrIiRhvS746BmtUyFV2RrEvFMQMxllA7+IlK4jr?=
 =?iso-8859-1?Q?5zgJNPBT7eWTF8PXyuexO64peqrMUKAcwfTZ6SCW+fHrH0VNkNGO0MMtMy?=
 =?iso-8859-1?Q?uP915bjySYMC4O8/PZGZkEsS2rcNf7zM6zne3B07DYmRyiozaSGvKWcaP8?=
 =?iso-8859-1?Q?U4uSOCRu6fEUkI3SKLXYnBEbtKPoTUOhgIAVE6cZR/T5DCli1tG3CnsNb2?=
 =?iso-8859-1?Q?aMQDecf0JLM2019vFNhnhQ7htmMh6mra3qISRk3nCLo1ob7r2UzAPij8xm?=
 =?iso-8859-1?Q?9lwR9eC9FIBaRhL9nrTSexRbbpV0Y7JqpFPbOA7ZvAPNxb9uysoC/A8+P1?=
 =?iso-8859-1?Q?6Feg2E8MnRwEQ1IEwxcwyicng7jBHTnAZj1UjZMv/PSYPzJrQxgcPinUG+?=
 =?iso-8859-1?Q?bPRgvWi7uO7Ou+3TjWXdo2KUBBCm05/20rA5PYVpY6rD8H6aZXJXuHp1Cd?=
 =?iso-8859-1?Q?eqvpQe7aZBHLrD97O6eyk8l/6SHJ/H6zqFAGt+Oy2i1X3SCVg2YbRAQctM?=
 =?iso-8859-1?Q?wf3X+rAEH8DNhpk/dU9daI+1GGUCLKLCHi+NGswn/y/l5b77O1i+YQyENS?=
 =?iso-8859-1?Q?laZp8+WneRMhzrSTNflj+4GmWb6F6atFc+bgZjYym7L6xV?=
Content-Type: multipart/alternative;
 boundary="_000_BN5PR12MB946425AF98949B55BE582BBFF4922BN5PR12MB9464namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8230fd5-0daf-4318-b4fd-08df26138162
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:42:12.6568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lC+Cp1REEqLgFbWyAsxpjO39xGSqUQHenYBIhT7UzyH1SppfDKinl2y67xn0rgdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

--_000_BN5PR12MB946425AF98949B55BE582BBFF4922BN5PR12MB9464namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

________________________________
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Thursday, October 08, 2026 2:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: wake the GPU before toggling mes_dbgext fr=
om debugfs

The amdgpu_mes_dbgext debugfs write handler programs CPC_INT_CNTL and
sends MISC packets to the MES without holding a runtime PM reference.
If the GPU is runtime suspended the MES never answers, so enabling the
log fails:

  amdgpu 0000:03:00.0: MES failed to respond to msg=3DMISC fence_wait_ret=
=3D0 status=3D0x0
  amdgpu 0000:03:00.0: failed to setup mes_dbgext in FW on xcc0 (-110)

and the write returns -ETIMEDOUT.

Resume the GPU before starting or stopping the log.

Fixes: 21593a22a09a ("drm/amdgpu: add mes_dbgext core support")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 8d813c68450b..b93b4be05178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -23,6 +23,7 @@

 #include <linux/firmware.h>
 #include <linux/kthread.h>
+#include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -1955,6 +1956,13 @@ static ssize_t amdgpu_debugfs_mes_dbgext_write(struc=
t file *file,
         if (!mes->funcs || !mes->funcs->misc_op)
                 return -EOPNOTSUPP;

+       /* Arming and detaching the firmware talks to the MES. */
+       PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(adev->dev, pm);
+
+       r =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
+       if (r)
+               return r;
+
         mutex_lock(&mes->dbgext_lock);
         if (enable) {
                 mes->dbgext_runtime_kb =3D amdgpu_mes_dbgext_buffer_size ?
--
2.50.1


--_000_BN5PR12MB946425AF98949B55BE582BBFF4922BN5PR12MB9464namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Yongqiang Sun &lt;Yongqiang.Sun@amd.com&gt;</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);"></span><span style=3D"font-family: Cali=
bri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><=
br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 08, 2026 2:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Sun, Yongqiang &lt;Yongqiang.Sun@=
amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: wake the GPU before toggling mes_db=
gext from debugfs
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The amdgpu_mes_dbgext debugfs write handler=
 programs CPC_INT_CNTL and<br>
sends MISC packets to the MES without holding a runtime PM reference.<br>
If the GPU is runtime suspended the MES never answers, so enabling the<br>
log fails:<br>
<br>
&nbsp; amdgpu 0000:03:00.0: MES failed to respond to msg=3DMISC fence_wait_=
ret=3D0 status=3D0x0<br>
&nbsp; amdgpu 0000:03:00.0: failed to setup mes_dbgext in FW on xcc0 (-110)=
<br>
<br>
and the write returns -ETIMEDOUT.<br>
<br>
Resume the GPU before starting or stopping the log.<br>
<br>
Fixes: 21593a22a09a (&quot;drm/amdgpu: add mes_dbgext core support&quot;)<b=
r>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++++++<br>
&nbsp;1 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 8d813c68450b..b93b4be05178 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -23,6 +23,7 @@<br>
&nbsp;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&nbsp;#include &lt;linux/kthread.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
&nbsp;#include &lt;linux/delay.h&gt;<br>
&nbsp;#include &lt;linux/sizes.h&gt;<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
@@ -1955,6 +1956,13 @@ static ssize_t amdgpu_debugfs_mes_dbgext_write(struc=
t file *file,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mes-&gt;funcs || !mes=
-&gt;funcs-&gt;misc_op)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Arming and detaching the firmware =
talks to the MES. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUS=
PEND(adev-&gt;dev, pm);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D PM_RUNTIME_ACQUIRE_ERR(&amp;pm)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mes-&gt;db=
gext_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes-&gt;dbgext_runtime_kb =3D amdgpu_mes_dbgext_buffe=
r_size ?<br>
--<br>
2.50.1<br>
<br>
</div>
</body>
</html>

--_000_BN5PR12MB946425AF98949B55BE582BBFF4922BN5PR12MB9464namp_--
