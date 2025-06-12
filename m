Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF416C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 15:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6F610E8BE;
	Thu, 12 Jun 2025 15:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4sTDokg";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB6A10E8B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 15:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lohEe0IC9x6czcwm1E5DXmdnZ4eDWJVW7p8/LsQ3cFRhyJ5W/hIKgQ9OHg4DTFKgZrmo2M8FMlxq7IKXqflyoRCgTmjG0sdVzzbo6tO3sLi3SYY/nLC+fnXLpcV62sESrp9NY/tKUbD0vP1n7pbtVsfjtHOHvKKdo/0Xwn0CyZgQWP0TAF27vESbnR7VquOOsOJNKLw8IUfWNAb8YSiQgDcDfACdfbRX0z2BelYb5v/8+Lj/j9BUr38lHmq+Oewx1z65GwqbKmGDZ2zGasc2h3O3vj7D+op82YaEGuv5WgO3fhLRPXNVZPXy2e1p17AjUL1Fim1LNoljNU7cdMdg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JdsNUMm4taC0i0ULEKUWHizZdni6YFaTx9Z765FwSU=;
 b=ID+rmsnvnmSyGp211nQ0KSxc83w3xzEynYX7h28s3ZszgPYqrVsZUQvYfbimlxLT2NqG7AwxOvs6wJrSGkEzylVR1j0a+dnQwuwH5KRAFhvqzSlnPLoaxoD5W5Bbi9jBiPO3m/FjKKGZIq9457T2OLME1xDlO9L5LL+/RWb43kqDm/zfNgUrc+9jPKKAMFcMH/2TAOF7WeOqnPOR80okZh4k9v8PLpzfHjxGk52XHdKN58nEI5BA1dmHTl3sMHUDHeISy/ovrZU05F/FjIUh/eG6jBvdjolPPDIuLrSJHjTQIqxDx2DGnR1XX5qf1GS38YSf26HUWrCNuyZA+qcO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JdsNUMm4taC0i0ULEKUWHizZdni6YFaTx9Z765FwSU=;
 b=N4sTDokgLcEbAxBpZwlFFsoGI7PqGjPzQDS3zQK9Wn0Swh63D8kvZaHblXHqHi/aFQErZRjQGUGJEvWCMAVs47zk2veKmjMd1AoTrpngZvdBXML/MCHFgexGLkzyi6IkLwAAjF2sULKWFWAbIz+Y9W3vCbwuJjV8fd7mUhM36B0=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:38:10 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:38:09 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix annotations for dc state functions
Thread-Topic: [PATCH] drm/amd/display: Fix annotations for dc state functions
Thread-Index: AQHb26wm36lotHazQ02rfu+32tMlvrP/qG4t
Date: Thu, 12 Jun 2025 15:38:09 +0000
Message-ID: <CH0PR12MB52848AFC4C6A7146502953188B74A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250612151019.106734-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250612151019.106734-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-12T15:38:09.0070000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|BL4PR12MB9507:EE_
x-ms-office365-filtering-correlation-id: b5c254ce-cd79-410e-f41c-08dda9c72246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rU7s+ZT4VHjba35epsxneKpIHDe3SZYee+eie5W/S+pJHpwnV6UqNEu80lRu?=
 =?us-ascii?Q?646vr3ATker+I2fbZUIPcneoJ+8vv5/peg/fTgOpAmmcODxvluuyJOPc1eBA?=
 =?us-ascii?Q?jiNS2jUiLewZm7y+BRKutzfzWTOI2KsY99+v3rVk1br61uajItnAusjL92gw?=
 =?us-ascii?Q?6GCFnLHJdi/eDyovg5Zq2OAjNvwDwZYopiRekJxK8dC7jGyZFrkqUI0lJS05?=
 =?us-ascii?Q?D6HeTWwOwflRmRLfu5m/Ul1R256cG+xhcxAgBxi6XIxDQBHbxpRZchJQGUX0?=
 =?us-ascii?Q?KpuQIROLxHMArqFMvMbRIX0ifyZVsfAm+GkBul5pZCQQyIi7hnUudeYRO3oX?=
 =?us-ascii?Q?2ZPZeHySO/Dca4J/atOrl9+JIbxGR/YT78/+yvT+2uLFqa+aWoGtAXh0c5gV?=
 =?us-ascii?Q?B0vaD9kjASJQgcK0BXwU7lmmVyoHVzL5qq3Y3WaSbfu0m5nJRBOYT/y07q+a?=
 =?us-ascii?Q?mu0AEg0sUxgDmlpyhCm5oQVTlxLYxf7RThvsbRA3TCrCHOTDn/ko7mzNDwaB?=
 =?us-ascii?Q?DpWX86l9hVaOENvumhZ5Jn/sRfO2Fv3BTgVN3uK0YuT5Xne4cuOFbXJSKR8u?=
 =?us-ascii?Q?8pIaITnxVpvosPdo/xvHTbAAOJWxU3165w0+xh8EmNGhzNJLGi8XWqsLPZXN?=
 =?us-ascii?Q?BUzuC/R7trV6pFpfesdIMrd09XXZB8qWmh+sKwVz1nuFLKNA7LzrLXqc2sza?=
 =?us-ascii?Q?xRvH+MyJOYOmIZI7BCdiwKk5D03Kufo/AmX5XfpjWIKkftmsOj+QeNhhwyst?=
 =?us-ascii?Q?BtD/OZ5xrBVi3bE31UjYPeSon1z/1BevwGbeEApR296u1A5sxOpdhkNQ/nx8?=
 =?us-ascii?Q?IpbnLBvCXlRygq/0eSiRiPcRAvP2wTd/xq0RWrQyLFon3Z35Y07siDmmdQ2D?=
 =?us-ascii?Q?OiYQsvzaiUK/eBLWUcMkQ94H/t0eWIMZeWDwAJHHQlbFadufLsYsrpyvHN9l?=
 =?us-ascii?Q?B6uL5Ko3a2HedCPsJtI+rTiexrduqrZ58DmJU+LdGN6cQkQhf8ImqRl8FGS9?=
 =?us-ascii?Q?tQlOCrqh82nMG2r2tQMqk9V9YAitrPNbJt8Lr7/q6uGwO57WL0xqa24m2RTg?=
 =?us-ascii?Q?dpJ5QlIz4eWeugmKHLGz+jQwHj530bMVSw0nyQjPpzGZKuEObpwJhiuVwgfe?=
 =?us-ascii?Q?n4F4T5OIMFJeXkiEAq4psV8HGHXrl+yoynUSmM8Jezv6ADltUlLTjjQ5h2CP?=
 =?us-ascii?Q?BCSr3gk7RBByhxt8eMNL/he0ZoRGeXgdsz+mwrjCRG1uDKRl/uB6GOpktUE/?=
 =?us-ascii?Q?6eTG4uYoh+nhJfB1fj8NC1kJL7INlsYOQSlC5YmhwkgcLRcU6/q6QTfwOSdi?=
 =?us-ascii?Q?An7QvLWJxchAQhjJj9p80hJsOoy8v04gzneG8R2CBd9hyfOTxrrfc5a2y+MD?=
 =?us-ascii?Q?0ctRF9LMu+9Bw3yBIgCd7feN4mITfooLSywxQDtl5ymhYFcHdoV+l+vI9rLO?=
 =?us-ascii?Q?cNMVQHbv10F67NI0Pp96XJvN8nInlhtpngbbSut/StfRH2/z6kdrdA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cZKur3pvZY9WUw4ACruGYhVPyHyYFfVpZVjZZ17PimLWOO+EFLkHyJxjaNh4?=
 =?us-ascii?Q?/XJH8crP3L0OJXClanPL70x6/xtsJEoLYkOSjVK/bWiiNzWffTtbm3OIlBYP?=
 =?us-ascii?Q?aRRUjN3JOFNNVWMs57LdNwaHfSfYdphJLqQkae9Ycpxac6pr/aBaTb4whm0/?=
 =?us-ascii?Q?alkozNT3vPGQgnRKJfGQoObnP3xlTfQUTjsFp4GDX8fn4uxkiwYbqZzVjXzw?=
 =?us-ascii?Q?rrqvg8x/DeTueRbGp0b7Mf+xXMRr9PNjVSgO7XN7CDYHMVC/XTHK8KbaVHaS?=
 =?us-ascii?Q?OOzndGO8VAAW9M0vlbTPqkqmWilQDIZFOkfFKVU5B6VcqzyX1J3+DbLcOBHc?=
 =?us-ascii?Q?Ms4NTHCVgiN8Rdmx0I0wgPmEdrScWitutxhvnrMaMRQcYVQvSLHCCXBljALG?=
 =?us-ascii?Q?zwqS+bY3F6ppsrONtSFH3mkMawgJUYdMJ+sd8Wy7NmmTklOqlzB36fyTsX8G?=
 =?us-ascii?Q?tRBgJdclMFEb4gkPmufPHyYrBOHVvjACWd0IMiPKw1EkJ3wdNbKoDBVnCA2N?=
 =?us-ascii?Q?4h/xwvDSlmQnShSdwBbFNO14Z/yPWEK33qObBK2LSM8N6kzJcX4/hUgPHFf9?=
 =?us-ascii?Q?BkW6tLkNpnxva/27c239ckRQtN8xH8oru1fWSAg8Xtlxhd0XA0v2p+yRTu4w?=
 =?us-ascii?Q?1GAMmSC1XoEtPMDWNfYHkJGtroEORDvZje+rcw/nk6qsJHJ5pUkhEWbf/sHE?=
 =?us-ascii?Q?33zDvV0X86T7PQS07mqkDGCr94/lN86kY06GF/VX+wqDrEv6OagzdpYRRyf3?=
 =?us-ascii?Q?dlQAFTXsBEgc1cjjeTJVdj772K1Dd4wAKDTsm7kzxhUyS+cEooK6PRkTnfqB?=
 =?us-ascii?Q?9zuuxDlJUTBaOMGhavBzMiUlASvBvB4q/1mGwI7exmfQ6hmGhGJD7Hz8CgsV?=
 =?us-ascii?Q?wFh70Wvt3Ck2/7lIzch0VgG4nSPOdtfETAGQbbzgCVI19cV6UdbpoLbDhhKu?=
 =?us-ascii?Q?E4Q9Sqc2hvQoLwKr12Srfi1fd7A7gjPIwXnS5j6gwgAOoTW3hlgiicvgAupD?=
 =?us-ascii?Q?op1z5rwuKer4c7Bswc5W2wAcNsT2dJPHFzmzbyofSgrzG4ybTcRXtnIvFk2W?=
 =?us-ascii?Q?VEfTxK+Apyta9arC7fcbkBfYu9UbTNJ6kFZj0JiBnGsNLdEkDZj11Aduq5ya?=
 =?us-ascii?Q?m2fG6hxKsA4tb9K4ntqCV+/Sz3njkC/r0fbjxjz+8x7vUoNeCsJHxqmoHRrn?=
 =?us-ascii?Q?hIq4fpYHneONCWXpLgyk46IgrOmvMcXJG/uLBM/YHGgirmNNqT53MI7hQicj?=
 =?us-ascii?Q?1NYSu4pzYVBmZxW32e/Zzv0AE1ueEEYjJqSV9i7o7R5fOlEHwZIIUNObkrkQ?=
 =?us-ascii?Q?0Axn2LEOIUm0q0r3zJnJR/9CUrq0fo7qB29wrM9fHTz5FWfNxFW5byJJnT0p?=
 =?us-ascii?Q?cPJ1EyCmcL/Wk/8c6wGWg5+MiwGcqePJR/U30DC+BfpFrqQvS12+6Fm9RJex?=
 =?us-ascii?Q?tdVl3297kXJXRNVEko3R/8R85jM11IMwQiCY0BKZz/Dq41+W6J+qoGwVjI+B?=
 =?us-ascii?Q?vkKP+TIAoJTm4jm/yu6oeLVPwOUH2zbGETtMfB7tryn0aiDfeb1ak/gyH8wN?=
 =?us-ascii?Q?W6kV1paZhFW2LAZVkAE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52848AFC4C6A7146502953188B74ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c254ce-cd79-410e-f41c-08dda9c72246
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 15:38:09.4688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqCk6XDGlx8tr7hNSK6W6ICFFO9Gb+DExbhdt1cICFZZdyAt74IrkDEag1/xhVREQl4KaQYOOYYooBpXvI5Gng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507
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

--_000_CH0PR12MB52848AFC4C6A7146502953188B74ACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, June 12, 2025 11:10 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Chung, ChiaHsuan (Tom) <ChiaH=
suan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex <Alex.Hung@am=
d.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix annotations for dc state functions

This patch addresses inconsistencies in the annotations for the
following functions:

- **dc_get_power_profile_for_dc_state**: Standardized parameter and
  return value annotations.
- **dc_get_det_buffer_size_from_state**: Clarified parameter
  documentation for better understanding.
- **dc_get_host_router_index**: Corrected parameter descriptions to
  follow documentation conventions.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:6386: warning: Cannot un=
derstand  ***************

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index eaf44e6046b5..0146ad4e23c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6343,13 +6343,14 @@ void dc_set_edp_power(const struct dc *dc, struct d=
c_link *edp_link,
         edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
 }

-/*
- *************************************************************************=
****
+/**
  * dc_get_power_profile_for_dc_state() - extracts power profile from dc st=
ate
  *
  * Called when DM wants to make power policy decisions based on dc_state
  *
- *************************************************************************=
****
+ * @context: Pointer to the dc_state from which the power profile is extra=
cted.
+ *
+ * Return: The power profile structure containing the power level informat=
ion.
  */
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_=
state *context)
 {
@@ -6365,13 +6366,14 @@ struct dc_power_profile dc_get_power_profile_for_dc=
_state(const struct dc_state
         return profile;
 }

-/*
- *************************************************************************=
*********
+/**
  * dc_get_det_buffer_size_from_state() - extracts detile buffer size from =
dc state
  *
- * Called when DM wants to log detile buffer size from dc_state
+ * This function is called to log the detile buffer size from the dc_state=
.
+ *
+ * @context: a pointer to the dc_state from which the detile buffer size i=
s extracted.
  *
- *************************************************************************=
*********
+ * Return: the size of the detile buffer, or 0 if not available.
  */
 unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *cont=
ext)
 {
@@ -6382,18 +6384,17 @@ unsigned int dc_get_det_buffer_size_from_state(cons=
t struct dc_state *context)
         else
                 return 0;
 }
+
 /**
- *************************************************************************=
**********************
  * dc_get_host_router_index: Get index of host router from a dpia link
  *
  * This function return a host router index of the target link. If the tar=
get link is dpia link.
  *
- * @param [in] link: target link
- * @param [out] host_router_index: host router index of the target link
+ * @link: Pointer to the target link (input)
+ * @host_router_index: Pointer to store the host router index of the targe=
t link (output).
  *
- * @return: true if the host router index is found and valid.
+ * Return: true if the host router index is found and valid.
  *
- *************************************************************************=
**********************
  */
 bool dc_get_host_router_index(const struct dc_link *link, unsigned int *ho=
st_router_index)
 {
--
2.34.1


--_000_CH0PR12MB52848AFC4C6A7146502953188B74ACH0PR12MB5284namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 12, 2025 11:10 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Chung, Chi=
aHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.co=
m&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;; Wentland, Harry &lt;Harry.Went=
land@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix annotations for dc state funct=
ions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch addresses inconsistencies in the annota=
tions for the<br>
following functions:<br>
<br>
- **dc_get_power_profile_for_dc_state**: Standardized parameter and<br>
&nbsp; return value annotations.<br>
- **dc_get_det_buffer_size_from_state**: Clarified parameter<br>
&nbsp; documentation for better understanding.<br>
- **dc_get_host_router_index**: Corrected parameter descriptions to<br>
&nbsp; follow documentation conventions.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:6386: warning: Cannot un=
derstand&nbsp; ***************<br>
<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c | 25 ++++++++++++-----------=
-<br>
&nbsp;1 file changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index eaf44e6046b5..0146ad4e23c8 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -6343,13 +6343,14 @@ void dc_set_edp_power(const struct dc *dc, struct d=
c_link *edp_link,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edp_link-&gt;dc-&gt;link_s=
rv-&gt;edp_set_panel_power(edp_link, powerOn);<br>
&nbsp;}<br>
&nbsp;<br>
-/*<br>
- *************************************************************************=
****<br>
+/**<br>
&nbsp; * dc_get_power_profile_for_dc_state() - extracts power profile from =
dc state<br>
&nbsp; *<br>
&nbsp; * Called when DM wants to make power policy decisions based on dc_st=
ate<br>
&nbsp; *<br>
- *************************************************************************=
****<br>
+ * @context: Pointer to the dc_state from which the power profile is extra=
cted.<br>
+ *<br>
+ * Return: The power profile structure containing the power level informat=
ion.<br>
&nbsp; */<br>
&nbsp;struct dc_power_profile dc_get_power_profile_for_dc_state(const struc=
t dc_state *context)<br>
&nbsp;{<br>
@@ -6365,13 +6366,14 @@ struct dc_power_profile dc_get_power_profile_for_dc=
_state(const struct dc_state<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return profile;<br>
&nbsp;}<br>
&nbsp;<br>
-/*<br>
- *************************************************************************=
*********<br>
+/**<br>
&nbsp; * dc_get_det_buffer_size_from_state() - extracts detile buffer size =
from dc state<br>
&nbsp; *<br>
- * Called when DM wants to log detile buffer size from dc_state<br>
+ * This function is called to log the detile buffer size from the dc_state=
.<br>
+ *<br>
+ * @context: a pointer to the dc_state from which the detile buffer size i=
s extracted.<br>
&nbsp; *<br>
- *************************************************************************=
*********<br>
+ * Return: the size of the detile buffer, or 0 if not available.<br>
&nbsp; */<br>
&nbsp;unsigned int dc_get_det_buffer_size_from_state(const struct dc_state =
*context)<br>
&nbsp;{<br>
@@ -6382,18 +6384,17 @@ unsigned int dc_get_det_buffer_size_from_state(cons=
t struct dc_state *context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
+<br>
&nbsp;/**<br>
- *************************************************************************=
**********************<br>
&nbsp; * dc_get_host_router_index: Get index of host router from a dpia lin=
k<br>
&nbsp; *<br>
&nbsp; * This function return a host router index of the target link. If th=
e target link is dpia link.<br>
&nbsp; *<br>
- * @param [in] link: target link<br>
- * @param [out] host_router_index: host router index of the target link<br=
>
+ * @link: Pointer to the target link (input)<br>
+ * @host_router_index: Pointer to store the host router index of the targe=
t link (output).<br>
&nbsp; *<br>
- * @return: true if the host router index is found and valid.<br>
+ * Return: true if the host router index is found and valid.<br>
&nbsp; *<br>
- *************************************************************************=
**********************<br>
&nbsp; */<br>
&nbsp;bool dc_get_host_router_index(const struct dc_link *link, unsigned in=
t *host_router_index)<br>
&nbsp;{<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52848AFC4C6A7146502953188B74ACH0PR12MB5284namp_--
