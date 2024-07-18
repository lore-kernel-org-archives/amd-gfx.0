Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F6AC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 03:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730E210E14B;
	Thu, 18 Jul 2024 03:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2h1lfEV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7856D10E14B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 03:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buOg6CL20hSmzYx+aItmdGhyuKWgByqhLMUjz4Fts5IerL4kzklqmIWMBVvf5iusAi5vOFkoKbHw5smrpBBBSdbq4uOBUdSxE0poZnszgklb7nQdcpEeesKIX1I3lLBXURte6RvvMWEdwMb1TZnYUy/84lXqoIb6PzqBOrs2U8wq/lCOVbi7mDnIebW0V7A42+DS2BIBsjuS7l4tunT/hMp/Lpm4qCDosZyynlWwQzlTwlE+L5IXykoJkLLhLUo7bI7cVeULOKFXBeFgw0R6OSEcEmA8AnPPpt6fUa+lbZY8HY+QWWcrDC5AF1WmyqKDNhQMdePs5yCeW5DgdEJuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE/jaRFYGGI7ZXAdcY98KNiBUKOEyf5T4BeJ01FvkFU=;
 b=oz0kqYtIX0tChOy1RjzS1WTSw6mJEQFMnDMxIDUYwtmqcQM7K7KxnHiTaJSsD7L51gvTIS5tVQhOBbJQSUNG+KRmdjg5FxnPSBUXIC8akjoTxB0BQYtHRe1mVkcJiKVbR3lMDEnldE0YjboFaFlqKUkScN0Rgm5ZQSSyqqYf12monjTn5kw+urmgPyqryNgwCwAMCMzkMwhhm6jhSD0mDOIqW0eCu91yM2tn2UqIRx6kp2VeglISp7js97Z7bGBKT6GcvPQTj3PizdfbcHS7hFU+6SnQYOX34JnPsfFQzLUdeWtVO9/t2cqBWsNtHvAy28xQ38+mB6jCQQx4TboqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE/jaRFYGGI7ZXAdcY98KNiBUKOEyf5T4BeJ01FvkFU=;
 b=P2h1lfEVQv8xU/v8IUyfmt1yErNBfzAM/qRjm/Oa77W1CoCbEA6Ddx90XzbkSsoh7e1efUbF9FqA99FrMlIoyzP2PCl2ZIcM3Ri1JKWEBDzCQLhM1ltyKrMs9KSbTud1Iva3xM5NhEbHmpJAIQbN4XsilYHc7/Fh2g2nEZEAeqM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 03:52:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 03:52:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Index: AQHa2MFonsg9X/o4Ck+3ZnaoWDju3bH72XuQ
Date: Thu, 18 Jul 2024 03:52:13 +0000
Message-ID: <BN9PR12MB5257199C05DE3DA98B4853BAFCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240718031932.1353653-1-Stanley.Yang@amd.com>
In-Reply-To: <20240718031932.1353653-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9879bbd3-390d-43fd-a2a2-f97369c1c448;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T03:49:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8595:EE_
x-ms-office365-filtering-correlation-id: 529da0c2-ea16-4d77-8fa1-08dca6dd01fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BA5eYRu2rLTFKe1Q+9kuUNKJs9Ta3P+K+cZ9l6WGe46rL4bLPBo4cci7//ld?=
 =?us-ascii?Q?6kCp8PK/bJwLxVFmfhUyVbusAXkDpkSF0htIugzUOLV0xNAHze6iu9xJivs2?=
 =?us-ascii?Q?AHLpRphEVpDtovEJqWeP7NtTSSD4ZeAZ3mEe6lqc0EO8COvMxa5XXpBralLj?=
 =?us-ascii?Q?1XSu1ze/cnGHJwZcebgOmAohMz2UHL1lDkhJx3ajXwWqmTUl8MYURr8R2LQ1?=
 =?us-ascii?Q?1LdzKh0F2D1mi/OTMvPNt1iDuES88H6h7bgymvjwQnHxmNyILkXSwnwtp7X+?=
 =?us-ascii?Q?PZ8to4U+hDNbyTpa4zOJAQ8kuUrqo5sSllBJuwaI9kcw/d+APwtVO9Ch7+JB?=
 =?us-ascii?Q?wYUjEfQLPROTqsgSdJAlnuC0KQPjVirOnXAvwpqv3QMoeQbaGHNq5AJy3gPh?=
 =?us-ascii?Q?+D8Hl4DNoINc82VFmBtMqSx0bSrvcD7UQOKhrgVWi28fL2WDdq0hDZk6k00/?=
 =?us-ascii?Q?LFlFNSRqcR2L4ni0SMOLBt4ymktj11xLzDnbVXI+ri9zVqeJQYQPu8ilDQVw?=
 =?us-ascii?Q?WWLrD8u4b4hCO3KsibtL0exsYkifYtP7LeUGLLHlmskgDWkEWpVcqn67Go2e?=
 =?us-ascii?Q?EyJdVJr4FasBWUAHo5oQMuvyLasAKOhG9TKuXMP9D40Hrn0FL5PdrXruP9ti?=
 =?us-ascii?Q?BAW+Yd226zd8k5VB7+MOoUAInhRyeyuTdsPLdB9IzyhrzkYhTot83bNOK18p?=
 =?us-ascii?Q?p++Dyd0yqrHn0bElTj+CnORHr5kfCoZsXVHblMRev/dQ/ap+aQ1AQPAwR0R7?=
 =?us-ascii?Q?2UTUJeyPfLw9a57+Zw+cDlqstovyWZhDGUfxaunvV6TOiHnuRBrvuKxpsB/U?=
 =?us-ascii?Q?VpQ4/KtiZfCowl7No0oV4NmrNmtbqR3B58qXo7f4ers6Wi0i2z0CVCoHs+M+?=
 =?us-ascii?Q?8UICky8y8uXnaRw6Ys4V5oe20b54FGDljiCWLBPwq4rVQMwndjmssuDopL3O?=
 =?us-ascii?Q?oUpT7rLX5yCfgdRt0j2c+m8blcvib/EQZUFqCxyxcWdm8+U0ml/iFP8WSfZR?=
 =?us-ascii?Q?iVLHhYUfNuiRtMNzm+HuVuJNfW6m1unZZrfiCcsNTvh95GZIq7h9bxbcergW?=
 =?us-ascii?Q?qGERSRMeC8s6icudoaSxhQEIhtc3iotYxU155QK0ZnTQDq/C0I0LJogw0ITv?=
 =?us-ascii?Q?oN+xN4mSPsH1X8+XuTpm0NPXAgmWsDjSC3d8oXRQ2k92+2eCVKm5RpguKibv?=
 =?us-ascii?Q?EgvnteyIgvrQSpyM9O8S74EMLYhTyLnejhnBmsvE6VLb273yWAVyWjUnxpfz?=
 =?us-ascii?Q?dXgbNkdvkEfvrM0Atb2Aww02UYWW9MYP8DwTpe474sx6AJfNXB1UJ3rlaPRO?=
 =?us-ascii?Q?A1Foo6bys39/G0/otyk5E99BfFToPFfF6WdZu9tKRVT1Z8vomZ/y2pBCtFAb?=
 =?us-ascii?Q?B9oWc7pzL03GOB2WvV+GzrUpj/8VRrmOvktsS2vEFltAruIoYw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n+NmEjhaEFIBf51EqxWhFy/eFjHgs9ukWd6kMrX0wU2WP+LXVjt44UeuPlEb?=
 =?us-ascii?Q?dwtHLqvHOF9bvTZsAhcAzfHn54CDsz6ztdk62t/yoM0NV4uSLe9szsVPzWTv?=
 =?us-ascii?Q?GkRy9M+3Zjf20CIE1P/Ziu0AziHdJMzhCBrqzf6wzgT+4wF0FNp6YcWOMwhw?=
 =?us-ascii?Q?OERfb1jM/hUWNFXUkx/NUoqHcxAoFUdjyp49NQ5aY1qk/sQULXeuGaPnpLWy?=
 =?us-ascii?Q?Sk1C0Xn/k7fWMrcjlA9NE9+HswxbvlZS/FaLekGRJ4i2F2ST81QYPzw1iTZQ?=
 =?us-ascii?Q?rrb+mTuVyt6qRcaZkAPJL/Fmy4kHgF0WzpC+/grFuEriRpQGBc27CBEJc/bd?=
 =?us-ascii?Q?+ApTPQ8sodET05fm4gplv0wqAsolCIPKPoiV+GyMLdgr/USAX6/on3Gdb/A2?=
 =?us-ascii?Q?/3MOtqvOgyQSh3P0ueQduor2Nk8KHPnd0THlMMfINpcjDFLIv8mPQ3Ut9yrS?=
 =?us-ascii?Q?yizZro/29zw8umU+QFHENFY4wYTQ3HjE59TKCRhaYppM7uwXgU3ceCx35RQe?=
 =?us-ascii?Q?jgK8uTnRFGzPZQeAww55os+WwbDpPop8zFgoeSdxubGZeIb+7SVgBFf/hsVZ?=
 =?us-ascii?Q?bzxCaEEVjvDzhLsFC2DNVC7LcVMc0yrig7mwz5MgQkYi3rWlMcdTZoTLjHpQ?=
 =?us-ascii?Q?6VDnkm8wDpmjVJ4Zp+eG6N1g43nUDKf7Yhmt1wSsRi00dk8xDQfpD4MSigfs?=
 =?us-ascii?Q?oge0mmdbB9PsgjEsRGX/4pPsgWmWZQDY5KK0KUv2pLosm6GuxLQQ0YJDNvYJ?=
 =?us-ascii?Q?0C+dyxUTPx68Iz7Mse4XTZWZeCUmwXUj9F1V8nsvNKTe1Yb7C+w5jfuZBS8J?=
 =?us-ascii?Q?gyaO2D2MMXTn8LP5KEEKLHCoN+LofoPZz5HAf2NMde08gQtJNY4sbjphBwGE?=
 =?us-ascii?Q?kxdk34DXEI/UteHMy0zgnoqxnri1yRLZUypZFl5REng4UunKS0wiXI4iaFqn?=
 =?us-ascii?Q?B/ErN6FH2YKCusx0YOsy8zCL8Md1YNXM8MxIMHAnr/t9fFweKI9RS+tuuLAs?=
 =?us-ascii?Q?E3uMHwoc3VWWd2Lyk6dtcuvJ47eWEVyQxRYuCytFEObJATJuxegupiSBaryQ?=
 =?us-ascii?Q?uPVzN+TuWkZFdfpHMPI/GxzBuAXNp9YtwiWh/RGupa/ZpcknzpoQytf3CEp0?=
 =?us-ascii?Q?/bxpc0ogRZaOMfC46oMuffcWIKVtTZ9kZRnhRDcU0qYcfRMpFyNrUPRAOi9t?=
 =?us-ascii?Q?Kjv5MX29kZ6dsb6xwebY6qD6G8LGPDkL27DJu+fbVbhI/OURdS/iRcxujOxS?=
 =?us-ascii?Q?4D0VcDzFbSfNrILHglsAAl8rmC06jYPjzb96eaJk00DzCMcq5natYFhaaoMG?=
 =?us-ascii?Q?jyMHOuhGFeZBrCyBcYZWYePYb9GImGXURkxgbtw8pL8ErLaUHUI499t9HUx9?=
 =?us-ascii?Q?ND59xn24SCkeW9hjC+KOlEt2BdmUeirqgl5vveuWb0lX1On0GdVN0MIYE97R?=
 =?us-ascii?Q?Qjhh/FXpEQ3Y8a9KWYZcqI2a91LgEl31PifI9dWFfxLzPpHrPGghyIuDKMJj?=
 =?us-ascii?Q?3jeBE+QmpHf7QzYZmyQ242JWyHGUgLU7/8fjIyvyhjfrhp3NtKLdgFe/eR0M?=
 =?us-ascii?Q?xljgvlmNT6yXf1An3tY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529da0c2-ea16-4d77-8fa1-08dca6dd01fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 03:52:13.0781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWkTeh7LRQJKuSKT65x5+isvI6ikm6Yk8tFSl2yt4zt/poG/bWETlW2G8iD6xzazTR7tYoRQapqZr1nXx/Bz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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

Can you please try moving amdgpu_ras_set_eeprom_table_version to the beginn=
ing of amdgpu_ras_recovery_init?

In such way, we don't need to invoke this function from both amdgpu_ras_eep=
rom_max_record_count and amdgpu_ras_eeprom_init

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, July 18, 2024 11:20
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count

The eeprom table is empty before initializing, set eeprom table version fir=
st before initializing.

Changed from V1:
        Reuse amdgpu_ras_set_eeprom_table_version function

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index eae0a555df3c..aab8077e5098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1011,6 +1011,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_c=
ontrol *control,

 uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_contr=
ol *control)  {
+       /* get available eeprom table version first before eeprom table ini=
t */
+       amdgpu_ras_set_eeprom_table_version(control);
+
        if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
                return RAS_MAX_RECORD_COUNT_V2_1;
        else
--
2.25.1

