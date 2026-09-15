Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE07C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 20:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D0A10E2DE;
	Tue, 15 Sep 2026 20:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ljcwTGbz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C8B10E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 20:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjLFpFD/cMEYkKiY4CysvS7B29q7lmj8RWe4VapE431JVZajzIRbOSk3C8TxbwhelNb6L0CnoUFWUgY37/33B4MVG5M5hOMJat6YF06AW7eoXPOOQjW2m5Z1Xj3eDI7lwLzf22i1f4Ire7yJCvWrsIq6D9xX0MTI9TzI+iBZGcg5/ZPFhpY8dCp2fTDDbDLU/rTyFRzzBawOQmBs6flTJGLkr6CEWwVjv7eR0n4V+vC08oz62QlUV5fF7uP+3L2CPPAyiUUs4HQhIB/xNai7ikQXS04GgthzJpF47sJ08ZhUWGxJisD3QzpllWZuOCPTz/02RBMoSc6eESURpMZXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh20NPf+k22YuKfxxw1OUUEmULjwHSES5jmzhQ4rldc=;
 b=j0yIgRebI7/yNHYbkouV68uTd0NfwETWoPsXiEWyU4ayZVlzvtqUqdUKOvKdmx37T2VYELdxsfBYmkM1sFaaO5jrQvryfN/2OBHk+O6tTNA9D4fdt9/rJZjhClcJaef0XtL9EqY6BN8Ran7uA5trmsJ0UYgUPycNaxm8z3ZxJzKuGsDpX87UBVBMJgSZY6jjoCaUbr3PGvk+igNAodNUvjkjO9L+iT7AsbP3K0qDdgyXnJZcEq9l8yXSiMSQw7d6/ZIkPC/O1sP7EumIdXG0qM51ZuDVGezoC7uk5PGJj105zjMVoTvSkdGWcxMJDbjtksio/UrKmeeJUWplBFC9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh20NPf+k22YuKfxxw1OUUEmULjwHSES5jmzhQ4rldc=;
 b=ljcwTGbzlwCk5SmCZv0TVQyinRTCWDuLks517jz1CtQycCDCanR+Z46JGIDs2xPtXmOJTtvX3ukqX5aEm02adFqGv15vYiyCfvUC+HOK0yiPm/eTAE74yvPnjLgySJoPVVqlTwQh4XG9Re3/I5AsI9sGwmhLpvAEbkarBxHBqxM=
Received: from CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:59:26 +0000
Received: from CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::3f44:10a:9dd2:74d4]) by CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::3f44:10a:9dd2:74d4%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:59:26 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 queues
 too on GFX 12.1
Thread-Topic: [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 queues
 too on GFX 12.1
Thread-Index: AQHdRULuHj7Mb51fckaotgpn0mMqirbQH5Nb
Date: Tue, 15 Sep 2026 20:59:26 +0000
Message-ID: <CY5PR12MB603614F60BEAA8295A83A6D78CBA2@CY5PR12MB6036.namprd12.prod.outlook.com>
References: <20260915184800.395995-1-mukul.joshi@amd.com>
In-Reply-To: <20260915184800.395995-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T20:59:26.350Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6036:EE_|LV8PR12MB9452:EE_
x-ms-office365-filtering-correlation-id: 445fec11-63b9-4ea1-4c27-08df136c3a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: rv4d9wt4xbfK6xzbJEdDSiRihSy6ZXKBPNC6/gdrrRsk4oY58kewQiDLZR356mxLZfPmrBaYlxF10kNvSZi0SQmpZM+U+RYA5eMyuxJAqNO2ado3aVlZd1H07NzwzP2FGqS6/SblwbVo/TJMUt9X8/vYNYITnayG+PpaXpXmwGwEUFJeqhORmCiz848KUpKe9tkF+qteBVs/xJhQTKAJufhsdTYhETMi3TJgBtgjzUp0gOzHxTmPiVcN8MdBqK5Bw5mmO09+/75QIIsdWkNHx4fLOTWLfjWs+hziTpQ9VsCAbDWyiZWGVvbMGOxrPtDpOeHqxBHWWfap+tIFmLoRR24vXFJohNAfUw6av9e+SK7mWfmvEF9nVQ7F08/MIF1RvPj6JUAvcbGIpBW2R5TJSpCrqazf18xI5xV6U7MSyT2KScjUhefC0tZDKZXEWaE6yFj3QNJGhy1D8I/gloTXFDkAC+cJCP7+8qUQlMal+M7S77X/pIKB6XB9tKZh4TfmrDfW5OhNdFEkvn0JWn+xeHJnblo1be6ajnUSZbsxQeGFdPbQyMoh73krHT0YnneeYiJ/ELtnGgZs3voXPYAipgDXscUAddMOH1iF6y65NU4yzpBz2SoXj3MQScKDIH6eqlHg1zGOIG8rwjmPj73r4AAETBaPYqD+hlLb4lrMscDJToVsjCl4HQ8ZL2rJiqnksJ7g550LbSgAqpcjsA2pNaB5AC/Y71SQX8+Wust3JU0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6036.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGjaajrAjHeFicN0osK5WjEt3O0LT+UvzXBvA2EzD28nzgDFHtvvJgt/KMV9?=
 =?us-ascii?Q?COqhX/Yf1QL93/R7K8KMl9OKFpPcybJ0Hz4hGY3VMJ12XBPUCaHJvy/kmzeU?=
 =?us-ascii?Q?Aprsnd9pSnX6sf74CrYlIz98V9Ung8sVVJxRlo/de5YpXkCoqcR2qeONmMp1?=
 =?us-ascii?Q?IT2mFgeA/aYsVqYCCd38Tyie5om1VMGTvRkyzz4z5fNUfWSQ7tPHcNctykLz?=
 =?us-ascii?Q?2n5loU5N/mF81lBZg8Nd6WKdo4wuiZvEuVrm9cgqjIVHrfaDpKdXifei23HS?=
 =?us-ascii?Q?AuJGA1mk8VCfd/dEkLnCqqwlnDeslczRvOnSpDWohNl1QH44hIx57LpQr1bg?=
 =?us-ascii?Q?Gv1fyq87y6c7g2bsKe9zWp+RJP504CJ0tpOnuW5Z/EPVsN1n6Yw3NpX58qvH?=
 =?us-ascii?Q?OpQ/sbIFtMsCSJ7mWbv03tljUY/fV90MWLRj5M4jt3UsbaSpEFg9YEVljvWF?=
 =?us-ascii?Q?l1Z4mHYv4bFFcltJyTKJNVXid89GWQ2dOhKnckBZvgF3x/3kY1Y4RyfucHF4?=
 =?us-ascii?Q?k5Bssvm2pTM5LN5XDv7r6BYCVKLHCuFIyGOE4kAV7Cfk+uWZ4mUUAlUmAczy?=
 =?us-ascii?Q?Dt44fajy+bH8ozJP9nYOeS4u80oYTrn+tgCi0DufyPYaBfGOX6XbEeCHrRBs?=
 =?us-ascii?Q?iJX2HAhAMa1eDRd0AwwGJh4DJhN05T4x41iBuqqxeypLgWoLus5U+OmjM3EH?=
 =?us-ascii?Q?33liJOixTEWJvtRCzOB6jMtvLk1g6ZRuwwkQkizyiKaVTpzQrzA4Rzt04C/j?=
 =?us-ascii?Q?tdCQBvMDtQIkbFLwZM/HJfbxSKvIadwST/6ndBFkqXqcZEgLkga6hHGGWJW+?=
 =?us-ascii?Q?U1hyhCdbsbEnbuUCuh0RpZlLD00tOncRw6hLa4P5CUIPKUCUYk5oSNg/zrdl?=
 =?us-ascii?Q?bDsccJICZ2NgFEubPkUYeduZOVgcMbX8ryTq1vd0b2PlqtK+9IWVHWQpoFS+?=
 =?us-ascii?Q?sz21Ao7wj+XuRJfA6Ue6AtGShZ5kJcyHTs86C/9CWnGQsdw+KIc97DpaluBi?=
 =?us-ascii?Q?kDkMqaeeN15mydsgc5KHlVoTlfN351Bva7N41whxRizx7hG3D0NsgXukpqel?=
 =?us-ascii?Q?W3VtTYTqYBTs0syowdbNBBY0Lzku1yOB43p5DfUihEeF9kB+EavdzV1ApIVe?=
 =?us-ascii?Q?VpsjjOFkHKH+wkEYwPd6rn0FUubgmk1+dBgqY83KRhvg2Rpz/tAtFugDRwqj?=
 =?us-ascii?Q?+PD+ccjaSkvOXL1DrVDLiiFTG1avxQIOmMl2Lj//iYjB8M6RsWYnI+Pv9PUE?=
 =?us-ascii?Q?xyG+2R5fxbCSHj6MXMWrq5hA66rTB7kdAr2eJp66L9PcOBWiJpw6v/jXFdpo?=
 =?us-ascii?Q?oPURnN/xGn0yHUP3venkU0rZVz0UAM5w5SeLbLlQ/LhDUVQWw2qHMLa6dEjU?=
 =?us-ascii?Q?nIQ16kaRWokrHcbUxemOMENWG1Ok/uVXWnJ3KpJY+ZB3TkBXRVFJ+XaMotH+?=
 =?us-ascii?Q?365yRqJYXnpWgU5/43tPz4OuxId/cyTyjGSJyPegxf3pzTJGdpr7iM+CRApN?=
 =?us-ascii?Q?yIrjKzu5JU9JOTghgkCJtiP55Qkrv+mh4y60H/O68iAgPaJhItAe7yPczRon?=
 =?us-ascii?Q?ev9UvKA/k+cgunIXea3RoWoWc6/J3FM/Culbj9JpTO5k8kSmxGKH2YnPE5Ov?=
 =?us-ascii?Q?A10EtNmVU4zAsfoe76YRSA0QHZCXB09BqySmsH7Fl8Vtgru6g0qgJg8Wbiaf?=
 =?us-ascii?Q?ELu4qXhWxpy3rXyVbNlCPuj0lqtxzR+TtWyzAgcUlL25J1jQ?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB603614F60BEAA8295A83A6D78CBA2CY5PR12MB6036namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6036.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445fec11-63b9-4ea1-4c27-08df136c3a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 20:59:26.4415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8DGtsFN+qc5GA34fxT0+hIr3S4gI3pO8tK+/0pC55XyVQrJJXvKctTCHpOI3naFQXHEnGwoPoW/yxCZqN0C+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

--_000_CY5PR12MB603614F60BEAA8295A83A6D78CBA2CY5PR12MB6036namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Tuesday, September 15, 2026 2:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul =
<Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 queues too=
 on GFX 12.1

The previous change set CP_HQD_PQ_CONTROL.SCOPE=3D3 (SYSTEM) only for AQL
queues, but PM4 queues can also use non-coherently cached ring buffers
and hit the same stale-packet problem.

Move the SCOPE=3D3 assignment into the common path so it applies to both
AQL and PM4 queues.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 29c20398c60b..61e9282f3fb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -274,6 +274,7 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
         m->cp_hqd_pq_control |=3D
                         ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
         m->cp_hqd_pq_control |=3D CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+       m->cp_hqd_pq_control |=3D 3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT;
         pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);

         m->cp_hqd_pq_base_lo =3D lower_32_bits((uint64_t)q->queue_address =
>> 8);
@@ -335,7 +336,6 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
                 /* GC 10 removed WPP_CLAMP from PQ Control */
                 m->cp_hqd_pq_control |=3D CP_HQD_PQ_CONTROL__NO_UPDATE_RPT=
R_MASK |
                                 2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__S=
HIFT |
-                               3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT |
                                 1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHI=
FT;
                 m->cp_hqd_pq_doorbell_control |=3D
                         1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP=
__SHIFT;
--
2.55.0


--_000_CY5PR12MB603614F60BEAA8295A83A6D78CBA2CY5PR12MB6036namp_
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
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com&gt;<=
/div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joshi, Mukul &lt;Muku=
l.Joshi@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 15, 2026 2:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 que=
ues too on GFX 12.1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The previous change set CP_HQD_PQ_CONTROL.SCOPE=3D=
3 (SYSTEM) only for AQL<br>
queues, but PM4 queues can also use non-coherently cached ring buffers<br>
and hit the same stale-packet problem.<br>
<br>
Move the SCOPE=3D3 assignment into the common path so it applies to both<br=
>
AQL and PM4 queues.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
index 29c20398c60b..61e9282f3fb6 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
@@ -274,6 +274,7 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_control |=
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffs(q=
-&gt;queue_size / sizeof(unsigned int)) - 1 - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_control |=
=3D CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_control |=3D 3 &lt;&l=
t; CP_HQD_PQ_CONTROL__SCOPE__SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;cp_hqd_pq_c=
ontrol 0x%x\n&quot;, m-&gt;cp_hqd_pq_control);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_base_lo =
=3D lower_32_bits((uint64_t)q-&gt;queue_address &gt;&gt; 8);<br>
@@ -335,7 +336,6 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* GC 10 removed WPP_CLAMP from PQ Control */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_control |=3D CP_HQD_PQ_CONTROL__NO_UP=
DATE_RPTR_MASK |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 &lt;&lt; CP_HQD_PQ_CONTROL__SL=
OT_BASED_WPTR__SHIFT |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 &lt;&lt; CP_HQD_PQ_CONTROL__SCOPE__SHIFT =
|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; CP_HQD_PQ_CONTROL__QU=
EUE_FULL_EN__SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_pq_doorbell_control |=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt=
;&lt; CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;<br>
-- <br>
2.55.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB603614F60BEAA8295A83A6D78CBA2CY5PR12MB6036namp_--
