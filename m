Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B3C4451C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 14:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC69510E479;
	Fri, 17 Jul 2026 14:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ihIYxEGL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4F10E479
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 14:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDmcdDlPIN3Hq0Scc/2fMiFvc+uZ6neSiVcDt7Fg/DoMONGCG4NXfg95TxCFUDXQb9jV3lY5wAC5qIlkNj5GaN++BzNfJ8S9md7TnFiMpQyhpomxqa7CPbK4gPnTGfJ+yEa4e1RvFohm2Ku9VvcsRQPxNsb9LTWD9tafe5ajcBsBmjOuwtjMcXNPgIaTAf0Op0MP3OjA5ujDRSP7oeF0ucEAQOK/Ck16kvXORlOKqFZwYCYzlilxaqK2U4i4WhFH0IqBF8fDk+XaKd2sAzQdQncTsSmjthmxTczRuM96i1/p/Ap8BmgmrxLj6MAbcVGUIBnefr3UFt1qJyMwJ7V0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE4XqD2N7MYjkAKa092gDcJGEWBxQ/KEhC4iwUSazCQ=;
 b=qbo14ajQ/+rv1Gzz7URj0j/aLJ3TwHM86BFUN8ohsCDATT6pn9tvqTOui5U3wsQzuQRivO8PY/6st9j0G/Aijimwwa7iIg3sc5Q5PbQekCLKH4nqvzntToWnFzTFZXOoXO0kdsFOaMKXVzKW6XhTCf43K+xLDoBbSLF4H8QGOLZ5JArUk1jQtQ9mhHcaYuHxXSNKPSSuqp1TtwbvajrGJxtWs58L0kG/AVTq5gmi8twC1iELBlFw3s6qFJVlR+ec36ZtsiZ728K/dX/3aDTqJEN9KrfYUltpfzkjAiGRJmhiu45dI5de4UZm0HWyJUf2gC0ogf1hOzEmWLmk1MzsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE4XqD2N7MYjkAKa092gDcJGEWBxQ/KEhC4iwUSazCQ=;
 b=ihIYxEGLnmZw2TEyI9/CYvj5JpHen+NWn4Ag4szOBJPLDO9hAugYDaIMOlV7/yRfzDsl/xqMJFEsyshrEhbBWcgJORqRuisU0SzUzyqDkP7O5Rb2X6lvofMncyEdesqFXM2jatg+vfefCnn4xGUcxqjcQdAoF8Mdks+J7o9wbL0=
Received: from DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) by
 CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 14:48:06 +0000
Received: from DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02]) by DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 14:48:06 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: document for the MES rs64mem funcs
Thread-Topic: [PATCH] drm/amdgpu/mes: document for the MES rs64mem funcs
Thread-Index: AQHdFNLqZ2jsi7ueU0uBEQXaOklL2LZxzLHV
Date: Fri, 17 Jul 2026 14:48:06 +0000
Message-ID: <DM4PR12MB6279230B06CBA54837DFD58B94C62@DM4PR12MB6279.namprd12.prod.outlook.com>
References: <20260716032623.585521-1-Prike.Liang@amd.com>
In-Reply-To: <20260716032623.585521-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-17T14:48:06.100Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6279:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 2ef1116d-4fb5-432c-6f27-08dee41269a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|11063799006|18002099003|22082099003|8096899003|38070700021|13003099007;
x-microsoft-antispam-message-info: agF3dN+qv+38VOaqTBhZCx85nrCwFJtoX8zhGLa+2M6VCbiQXhdJOCK3XlQRkTyxsRD94pePoJWWvs14mjEby9GnyKn7t/SwyIyzOrDvX9jKj+H8QYHM9sjfzB12IOhxmm0JKjfylGAxuirIq3BZ70vAs7wl+aDqkFttVD92d7SjZjT7zJ6G9czqPjEEcIFN3eVpo2YKjVEuaRKbHs3cfcLoJUrFqeXN7nV1myAks2YpFSw995oRAMS6NQWyKndPN6w6BABnktlFRwfD7h39M1lCHLbg3bMPnDqu6ErxjkocNeRIy6nP/0pxeNJbc4fHJFVTGavXOTkB8mouaCtB6A9KjipNQl4yh2mA2Z1uTEF2J6B1Q0pLVIy5Qxgb+RwMcQk5CLCd30o6PSh271vD25sGmIcFKzNdrQt9+scFZLolFWbn1zQ5B+JOOy4Xu8fxZWq0nlz5LeADPLGfiofDNUgUmhYBlWANswUe5GpHQwzR5k5vJ50iqpgIlzkaaHoa3Zvjgm2d4E2MfBEq11bkAIV4r9RSXyuXrNRFvxWII+5Ww0F2SBGnVBfZezMFGp7sbr/tTnXsnkNKKL5MLq7ckRYbv7g9uItwVDp8hn3k38QBWow8JrJnmpVepYozBa1JvPqIrA0At2Wj/4987cQnpRSz6KjNypYAyorGx09uqCWFgtE9LUyicG8+Olbdw1QtEDxRCvzktRzRxATzSNZKD9JjNyq95UZGGytr1wZNCYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(8096899003)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8C1fblU20T4hKRY9Fxq/XAoVTmqWvVQVXTQNeu3ZoqwqyNyUiPtHqiK4DkvH?=
 =?us-ascii?Q?En3ut4uhdEOLOes7qzbn9ZWy+sv3VGRJFM4AQ/Z3WRdNyy5yaL/Xj2XmNuS7?=
 =?us-ascii?Q?MrfHCGGzlppvR1qbiDuaUyHdPtVKJ8veZeJKpru2QCmqlWEPIVnnWOkplo4+?=
 =?us-ascii?Q?00IcPmkewvXquC4/C6zY5l1JgRf3f5Znde4oa/NOsWNBJKJ508ioQjiYL4VN?=
 =?us-ascii?Q?0985AORqqqO3OWtaME7YdOiQoLmOgRufZchuknSoyNNFCd23x1xjVNi3NMcN?=
 =?us-ascii?Q?GkZLHUAFUHcdfGD0A7MLaABuhfu4J7xgU315gCDjNB9BK//2sq2pPdzj26wA?=
 =?us-ascii?Q?IqAk8RA6u4rNZR+zgjNhhoWnjzRL4jO9lKXxuANelEdsxvYLxHwZxCux6hOB?=
 =?us-ascii?Q?XQDl0DGpKGEGiXdk7OcvfWU25GSbi3fZ85ZWswf0T9J++2KDADazdo4m14/h?=
 =?us-ascii?Q?TqpWDgKX+Ja4hGiIal60XLiZl19jX+h9xWESL74RulWnj4LL2KAdIdWXAhA4?=
 =?us-ascii?Q?jHgRernykE/G64239QfWQVULEcVGSj1MDGRV/eFR5A63WSsIgy0quEhEmuvu?=
 =?us-ascii?Q?A1pGWxZ4+uE9uz64rqlu4PsgXxs62y119vlpCWVqeXDidIzkSHD7AH847zuM?=
 =?us-ascii?Q?ICCzlkMK4f/OrVGSg+Uf8aCYAP25Ly1fLF+htix3aVaxdhO8MD7Ww3lESBkR?=
 =?us-ascii?Q?4yYBJ8MYa0LESH93oCl3HcqcSuFI2KBk0TWwg46Shnse+XpgPXKCuLdr6aho?=
 =?us-ascii?Q?3VZyc2W3a3gRMMQKiSgAUJNpuZQHMEZocGuO/8t08jK6Yui7GAWeGeM8njzc?=
 =?us-ascii?Q?n7Y0mkQG4Rla2cD48aGx//U/3oV8kNeObiPPeeYj6aWfCHf7+7VhXNT47cWU?=
 =?us-ascii?Q?WapS4r5MEUBfzSqzOAy5qiHbUQV4WdpmTl7FeHl7EB4GSa8SxWmGioXH0B1z?=
 =?us-ascii?Q?YDkCEwnvIZY19hkr4A+Ge5jlD7T2WTe/JDmxOVeb3MeppaE63uuXLkQ2Jr8u?=
 =?us-ascii?Q?NmPuz+MXNMn1K/oe8wVe3AYnUyMqESsdnknXs3GvtxUfHdtr0SCJY9FxvA+g?=
 =?us-ascii?Q?2IJFZeJ0MumK8fRUN53hg7vJPR2OmvbZn02LObC/4vVtKyhNZrFZuahJU1Sx?=
 =?us-ascii?Q?I9KXyDfHIAlywCq8iQhes4dgW0CNtiLmL0M0gONQT4F2NubS1IeIPtvI97q+?=
 =?us-ascii?Q?0IIdmNHb9P9bYmSpikMCxRgv4Q1gb7CfNvp6+h3ZwIGO5vk/8Q8cP/RYrJuM?=
 =?us-ascii?Q?0TB/cUH1JoAOFHTgEUtnfGoBLxr94hoE4+cpTQytTQvKHvy9u5huig0LFG4a?=
 =?us-ascii?Q?xJRI3vXCqmNxcfeNA6s6VUDZNt2N57J3tQk5TG9undWid2FQC+bwFjugEKat?=
 =?us-ascii?Q?8RNYXfIHu1xRjfglUThQJj7Lyro0Giw2v+T468pt19FG2fmleOvvgsMdFHUP?=
 =?us-ascii?Q?CvQtbEwHgejVhI2BjklbZFsPdlEsvyP/PQLIyu5y55HhHOpBEUH/G1yOuhvV?=
 =?us-ascii?Q?qxeP7PQIiSi0/BUztc8tAN8jwsFX9FCrczefDYqHYoTZKTFHwcIcyGihXquI?=
 =?us-ascii?Q?7+71Xx9QFN33uA988J7Iz9v+RvC1/p5Lr87xVBVKjTCakqLxy/XG8M19nr/y?=
 =?us-ascii?Q?NaY+cMR3/fg8iiuXnpjICBHKOy3X1VWsKqH8H528ujODs92SK8KJETTUoSRH?=
 =?us-ascii?Q?vAg+5Huz5KIYp++FxPUGoEP0RDkItyQ7Fogtbg9cSCRSFNUQ?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB6279230B06CBA54837DFD58B94C62DM4PR12MB6279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef1116d-4fb5-432c-6f27-08dee41269a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 14:48:06.5753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfuvzOtODwYgNvTedw8UWKAhaBZPkAaGYm2m/LaMDIMv1KiIGS4h9j4q+6NcJx+CCV0okdd1hy3/3aeFWCugqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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

--_000_DM4PR12MB6279230B06CBA54837DFD58B94C62DM4PR12MB6279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, July 15, 2026 11:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liang, Prike <=
Prike.Liang@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu/mes: document for the MES rs64mem funcs

Fix the compile warning on the document style.

Fixes: dded4c22699e ("drm/amdgpu: add mes process context alloc/free")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607151416.vo4dHmX1-lkp@int=
el.com/
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 1e3a23c81552..33fd1f3da078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -954,6 +954,8 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)

 /**
  * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
+ *
+ * @mes: MES instance
  */
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
 {
@@ -1038,6 +1040,7 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_me=
s *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
+ * @queue: user mode queue structure pointer
  *
  * Returns 0 on success, -ENOSPC if all slots are used (caller should
  * fall back to system memory path).
@@ -1066,7 +1069,10 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_me=
s *mes,

 /**
  * amdgpu_mes_free_proc_ctx_index - free a process context slot
- */
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
+*/
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
 {
@@ -1082,6 +1088,9 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes=
 *mes,

 /**
  * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
  */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
@@ -1107,6 +1116,9 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,

 /**
  * amdgpu_mes_free_gang_ctx_index - free a gang context slot
+ *
+ * @mes: MES instance
+ * @queue: user mode queue structure pointer
  */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
                                     struct amdgpu_usermode_queue *queue)
--
2.34.1


--_000_DM4PR12MB6279230B06CBA54837DFD58B94C62DM4PR12MB6279namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: black;">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2026 11:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;; kernel test robot &lt;=
lkp@intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: document for the MES rs64mem funcs<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the compile warning on the document style.<br>
<br>
Fixes: dded4c22699e (&quot;drm/amdgpu: add mes process context alloc/free&q=
uot;)<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Closes: <a href=3D"https://lore.kernel.org/oe-kbuild-all/202607151416.vo4dH=
mX1-lkp@intel.com/">
https://lore.kernel.org/oe-kbuild-all/202607151416.vo4dHmX1-lkp@intel.com/<=
/a><br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 14 +++++++++++++-<br>
&nbsp;1 file changed, 13 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 1e3a23c81552..33fd1f3da078 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -954,6 +954,8 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management<b=
r>
+ *<br>
+ * @mes: MES instance<br>
&nbsp; */<br>
&nbsp;void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)<br>
&nbsp;{<br>
@@ -1038,6 +1040,7 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_me=
s *mes)<br>
&nbsp; * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot<=
br>
&nbsp; *<br>
&nbsp; * @mes: MES instance<br>
+ * @queue: user mode queue structure pointer<br>
&nbsp; *<br>
&nbsp; * Returns 0 on success, -ENOSPC if all slots are used (caller should=
<br>
&nbsp; * fall back to system memory path).<br>
@@ -1066,7 +1069,10 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_me=
s *mes,<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_mes_free_proc_ctx_index - free a process context slot<br>
- */<br>
+ *<br>
+ * @mes: MES instance<br>
+ * @queue: user mode queue structure pointer<br>
+*/<br>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
&nbsp;{<br>
@@ -1082,6 +1088,9 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot<br>
+ *<br>
+ * @mes: MES instance<br>
+ * @queue: user mode queue structure pointer<br>
&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
@@ -1107,6 +1116,9 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_mes_free_gang_ctx_index - free a gang context slot<br>
+ *<br>
+ * @mes: MES instance<br>
+ * @queue: user mode queue structure pointer<br>
&nbsp; */<br>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_usermode_queue *queue)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM4PR12MB6279230B06CBA54837DFD58B94C62DM4PR12MB6279namp_--
