Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FF1C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 05:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2499B10E2C5;
	Mon, 20 Jan 2025 05:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFUyVVuQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9367D10E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 05:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjbgSqVqhXJGxtwISLrAvpfeBOETW4/A9dnpmQPIdUEP5VFiT/iGuJ8yFtTN+9PERGU4zH9XS78neLrjP7KgA4huUMXIUtElOjTb+xy8kQMK4B055nyKHXE/P6cnBITnSDaDRu7sYyZI1J8vKscp51SmMe75bpAnsTZ9vcoTZq3A2wx7UxdmuhUGy6UL5Or80LeBhpcikzK8Kbgoji92XIF40UhmQNaIwNp3oLPSJauyZXzBI32LumelBbB/c4qR/LkVQRyY8v3xdfnARUub9jh+fr/Xy3jxAbgqb9QRbKraSW93NKRgGvNaRyOlYWK9gQcHpRXEeT8ao8gENqMoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfa6TsQgUBRpwD4u4NKnTCMo6ikk1G9zJRF6trmy7i4=;
 b=BLvRoScWK1DVc5tKRa/+66ETNCY5bua3BtIIqhSG+03N3C4cVuG7ONrHnRqLOip6ZbvQlP4EHhKY+XM/mvevVes++9sOi1k5XSZOAZDq28N+RfKM0pGqo/HmuXpKZ5a3Gky05JQ8D3xV0I2NY95vo70nrCyTfIIhcdySbibm3Nww95gWNTclXRfXUyPFMwhWSjBl3f7M4FwDkE3ecVQA0KiDqTOr/Q58vmUWGUW+YW+fXdIwf84bVAvp7UrrNiKK5u2XSiPAKforJZ2s7EWNvp6n5drVMHniTefQKk0mLVTY+Xi0cqdVqJjkPUXuQ/mK+mLnngXEAbletsOcBByeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfa6TsQgUBRpwD4u4NKnTCMo6ikk1G9zJRF6trmy7i4=;
 b=RFUyVVuQ9cxSZZtlOuPQxL+H4IMJI6dPvwDeeeg4ZSj1h6jiOZ0T7pTN/mnVPCHvuLKQzDPED1AMjhlkkD2rs1DiFpypOUQwKB+qU4MQ5XNB/nJYhxbHrT78YGEPO/RQgzvJN2hytxVgjQiON78WvJhk0UK0bapfJhp6K79x6Yo=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Mon, 20 Jan 2025 05:57:02 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%2]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 05:57:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Use correct macros for smu caps
Thread-Topic: [PATCH] drm/amd/pm: Use correct macros for smu caps
Thread-Index: AQHbaPJ6niADOzLUcUObGVABXdjVwrMfLc2Q
Date: Mon, 20 Jan 2025 05:57:01 +0000
Message-ID: <DM4PR12MB601228F7451D6EFFD4B50E7B82E72@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20250117151357.1480352-1-lijo.lazar@amd.com>
In-Reply-To: <20250117151357.1480352-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=734ad61a-ad70-43de-a668-8e4bdfc964a8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-20T05:55:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|DM4PR12MB6136:EE_
x-ms-office365-filtering-correlation-id: 0dc6a93d-8996-4d1f-829e-08dd39174272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MTgYVw2uJShA9vIOox+w83MPrDqeYNJO4kIz8iTGreAJiZ8qAPgfsgPJb2Pj?=
 =?us-ascii?Q?mi/IA0GBUdxqYfH8y/pPcjlwA0eIdr1d32kCAZ3qUOUDVevKEeZfMbHzfkTL?=
 =?us-ascii?Q?LsvVzQiRLfXcv4MHeFnIoV8/8tnVZP8mcjneM5uuu8gcb95SFZAb1i1Pmq9/?=
 =?us-ascii?Q?WAGPwd61MwDB9qIeP9IvOjbXrvH+55IGLlLzkoyXHXwBzx/hJpimAUHpQD4s?=
 =?us-ascii?Q?wHRYnDxIGyysh81Rh7LEYPQVWyOyzQa0cm6b644AE7EPsiXtB//4CUjcHgx/?=
 =?us-ascii?Q?id+TPLnFGLwq/8ekxAzXNLtcDiICft+cHQgU57Aui206Pahc2Ekde2xZlzl5?=
 =?us-ascii?Q?SEYgda0DUjDYVsQmifAREIgc0jFNvMqU8kCZsJ8u4mAOugIrYH7LaZqhDIsd?=
 =?us-ascii?Q?V7+GNQWEPmTkXle+xcXuARwi06aPCK2wWZWlK+80/zMmiikRiUjyoIbxH7il?=
 =?us-ascii?Q?A/d1KaSB9sO0ut9TjtQBfPWxDdT57Sw4CmQVEcW5UfgVJyQ0SYZGEB9GhqwI?=
 =?us-ascii?Q?Y0MpwBTDXKkslC++zTalKzM2xquMNe3AQSwxOfcI9Y3s76BPa7Vp8jTqVzTL?=
 =?us-ascii?Q?St3IAx5myqSC5IMjnWhvEHPkydmhB8nsx9d2CZKPMI3uGRQKCtjuPpQx1uTN?=
 =?us-ascii?Q?2JB14MHLt6dDGMpkL2QvNk1/C87UtKmKPTNuEWbHyhZZgfNTIKcY2o56XoMR?=
 =?us-ascii?Q?T2rA4H1W2IztjO0/JngE/KiZvFhmm5SYqulbItX3iKwzXKzjIsx2fxbfBLEs?=
 =?us-ascii?Q?TsLsXgfeLveQUdX1A/gkVJd3GJEzIKv8Q90Ny52LTp3wV4X3B4OUfRew890A?=
 =?us-ascii?Q?2AKpWouylIANahxPZbB4uSlmcXqE9M95ZB0kpXLIkCcAUkkxn01t8ZFRChud?=
 =?us-ascii?Q?XJY/PM6XcXrUejTQvIQlbmsKgdYwEEBRO5F54gAdez+QEIozwdnYhJDlh0W/?=
 =?us-ascii?Q?JzU8gu9kV5wO4kk0XfNfFtXPptg2zlcwEUlPtVUnUZAo4h1mfN5KMR3TscUr?=
 =?us-ascii?Q?E4rX8Zj5KRGnc2dR0otnglXVIUwaztD6VJnvgNp+ukDKHn+09Hdl8pU9Ay7q?=
 =?us-ascii?Q?1llD3s0MlpRKxzIZCfe1yDNYh5WmBfEwGZcdakFZRkhtLL9sO7dF5+XTq6SL?=
 =?us-ascii?Q?0NMT4qFswy41gj+Lkk9Ics9Zb4nk8gS24IONdeAH5JzIyi+bWFquSlNn6cxC?=
 =?us-ascii?Q?jFS5LyFUaQudhtIvRLF2eTIIT0AC8h8n2tf9lbvAs67iwXQ6RQnZfkVsUO9/?=
 =?us-ascii?Q?g1+kkA+KxFe0GRWtSJJseiHiqkSNWoJKa6dnuUpPoAaeZhQryhP5YpOojgjy?=
 =?us-ascii?Q?VLIEUlCYutCxAZqMz9lHPR6FcpHkg2pn4WEkGjiq0QNVH1+qrZaM6yY/XnzQ?=
 =?us-ascii?Q?coW9fWQ8F8wKOPgrXVtgMhUHXTKi0f1kJAXkSLRt/d2nxdK0v1fRzJf9P6vW?=
 =?us-ascii?Q?6m2UhjFAa1TR8EKxyjD20RhAsTXzao8E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oQiseu4toFnWd2q+ivMTgXhfynsISEHsJMOx2oAuTLr/tYx01wGgwlGmBK++?=
 =?us-ascii?Q?pTH/eCnYPpPYBp19Kz9Vty87aNocChL+admCmlbK8+63GNsg63CVp0+s6BNV?=
 =?us-ascii?Q?dST7QO6VdgXhdAWCxzEF1mts9u9cn9bsbQw9W+POxS0q9fh1iMJAagVRwbzF?=
 =?us-ascii?Q?/gCReRiNatp7bMU1G5S30CPZ3R3VStvKh6mEjKkN+cHQpSfL7qn4netbEYGP?=
 =?us-ascii?Q?ACyNPT/MU236+FDFAY1YCHu+nNnAeL21pUd5X5OSQSyDVKTZx8g8vnib0Rmv?=
 =?us-ascii?Q?vDHNIxpNUBbmWBrvFq9t/NlJUh+sDGJWVe0jIlqMV1uuV32M9jFml8zK5GrT?=
 =?us-ascii?Q?PbCqizsyZQEp5/XriuGD4p+GopAHiwo/boSgLM7B/7ix9500WAvjYDv9crZg?=
 =?us-ascii?Q?Xg2XfhsniQwAwFyvyTLjt4AS/rbeO1MLJax/rFgrw2Zocckn97hyoeE80yYy?=
 =?us-ascii?Q?7/YwY/m5XQvt29pkf73o9Wrfp8HshPIGLWedCqTIpoHx9MzDxpA9A+PhQ/gq?=
 =?us-ascii?Q?qBhQPCTBsSnmmUb68gfNQFbEC9aUL9CZEPUI8sPzBiDZjLQyHzdyTeYxpH84?=
 =?us-ascii?Q?Ra+KyQoaK0d8PpayHt/a5Q+pvtWM9bTR6UuGDDIfNJKeGRwonIz5orgLUmqO?=
 =?us-ascii?Q?lyJXzfUcLkZk/x066BByctKgiDWJI/eWKskwodyaRCMtQ60zJrGc7CICW86w?=
 =?us-ascii?Q?nulWjMggib2AKGDy/S77xbTpK2oSg2LRdH3B00roEpua5s4ALxqjrWI2E264?=
 =?us-ascii?Q?9OI+CGoNKf/t9aKVtPq0W8KgotmJtY/QFQHBrKcAtOB8PNcNHOLnEpiYbnZm?=
 =?us-ascii?Q?3RyBFSmlsZFY8c5ngjn+ORDmwqF2f+Q8bEELTOtDCs+ReHjgWbWMumBaZ/PO?=
 =?us-ascii?Q?7GYhzagHPnsuqZ5PUwUleTKInHkfDLwK8BU9LYjuL+I6AvfkFSwoi4m8CBxn?=
 =?us-ascii?Q?TFtyoPw9R/A4weswFoDxe22ogtDGsz45B12eSkJx/rNQ1cSUB0K+Ee8U074N?=
 =?us-ascii?Q?tKYk+tPUkH4RRIMHt8gMAAmKuWNk+pe/Zpb/e+lYnvDw7IXgoEoli9SrPSkD?=
 =?us-ascii?Q?OkmOHZ1nKthNdmdNgjWFzS4eyFXlFwXHogJ+c9szAjU52vrEPoj6D6SnNFcr?=
 =?us-ascii?Q?pTPGFLeNmxwKuLKAF2tQ0VUPxkOUw63EuU7nZUYrVJ4mG6h/IVriX9OLhiCm?=
 =?us-ascii?Q?SqmjUcsVF5kkdoPn/MbNK3C5c4PY56QvLoM+VwUiisElSMUaWSGwFEF/C2bP?=
 =?us-ascii?Q?gnkQqXnrh4IbU1KD9Gtav6jYL2DjzWTOR9tyKkMiYI4lc2MNVRCzZb5X4Oqi?=
 =?us-ascii?Q?lzRM6FvlXo1V7m32sS54cgwGOTRn8nZRyPLiVrUBbJdxRK+krFpF68NdY/Vj?=
 =?us-ascii?Q?nxQZjpZ5SNImdrBWQNit2xUpWTS43sg18LYBTswAqMaYLxrucV+BadC3ty7D?=
 =?us-ascii?Q?YusyX44ZTP4dqQtvTDB5mry6VOtZjh7b14JRLvbQkmnvkbX7E8e7ssPzJjWo?=
 =?us-ascii?Q?eduEWZYk1lA9oZ5w6sfpu3AFVBhWfcdfiY+ct1fmiMvtxy2aW41P6yBQi6eW?=
 =?us-ascii?Q?t0p/Zmc6UFMBdzLJTd4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc6a93d-8996-4d1f-829e-08dd39174272
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 05:57:01.7974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIDzCXr1nr7auxJzoS6YC7Srsu29KQzHyZct3bvrc68gS7IhPRrOI9DtVcwiGWtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, January 17, 2025 23:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use correct macros for smu caps

Fix the initialization and usage of capability values and mask.
SMU_CAPS_MASK indicates mask value, and SMU_CAPS represent the capability v=
alue.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 80 ++++++++++---------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 56e26fcd3066..52fd8355eee1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -118,8 +118,9 @@ enum smu_v13_0_6_caps {
        SMU_13_0_6_CAPS_ALL,
 };

-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
+#define SMU_CAPS_TO_MASK(x) (ULL(1) << x) #define SMU_CAPS(x)
+SMU_13_0_6_CAPS_##x #define SMU_CAPS_MASK(x)
+SMU_CAPS_TO_MASK(SMU_CAPS(x))
[kevin]:

There is helper macro here BIT_ULL(x).

Best regards,
Kevin

 struct mca_bank_ipid {
        enum amdgpu_mca_ip ip;
@@ -287,82 +288,84 @@ struct smu_v13_0_6_dpm_map {  static void smu_v13_0_1=
4_init_caps(struct smu_context *smu)  {
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
+       uint64_t caps =3D SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS) |
+                       SMU_CAPS_MASK(SET_UCLK_MAX) |
+                       SMU_CAPS_MASK(DPM_POLICY) |
+                       SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(CTF_LIM=
IT) |
+                       SMU_CAPS_MASK(MCA_DEBUG_MODE) | SMU_CAPS_MASK(RMA_M=
SG) |
+                       SMU_CAPS_MASK(ACA_SYND);
        uint32_t fw_ver =3D smu->smc_fw_version;

        if (fw_ver >=3D 0x05550E00)
-               caps |=3D SMU_CAPS(OTHER_END_METRICS);
+               caps |=3D SMU_CAPS_MASK(OTHER_END_METRICS);
        if (fw_ver >=3D 0x05551000)
-               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+               caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
        if (fw_ver >=3D 0x05550B00)
-               caps |=3D SMU_CAPS(PER_INST_METRICS);
+               caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
        if (fw_ver > 0x05550f00)
-               caps |=3D SMU_CAPS(SDMA_RESET);
+               caps |=3D SMU_CAPS_MASK(SDMA_RESET);

        dpm_context->caps =3D caps;
 }

 static void smu_v13_0_6_init_caps(struct smu_context *smu)  {
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
+       uint64_t caps =3D
+               SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS) |
+               SMU_CAPS_MASK(SET_UCLK_MAX) | SMU_CAPS_MASK(DPM_POLICY) |
+               SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(MCA_DEBUG_MODE)=
 |
+               SMU_CAPS_MASK(CTF_LIMIT) | SMU_CAPS_MASK(RMA_MSG) |
+               SMU_CAPS_MASK(ACA_SYND);
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t fw_ver =3D smu->smc_fw_version;
        uint32_t pgm =3D (fw_ver >> 24) & 0xFF;

        if (fw_ver < 0x552F00)
-               caps &=3D ~SMU_CAPS(DPM);
+               caps &=3D ~SMU_CAPS_MASK(DPM);

        if (adev->flags & AMD_IS_APU) {
-               caps &=3D ~SMU_CAPS(PCIE_METRICS);
-               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
-               caps &=3D ~SMU_CAPS(DPM_POLICY);
-               caps &=3D ~SMU_CAPS(RMA_MSG);
-               caps &=3D ~SMU_CAPS(ACA_SYND);
+               caps &=3D ~SMU_CAPS_MASK(PCIE_METRICS);
+               caps &=3D ~SMU_CAPS_MASK(SET_UCLK_MAX);
+               caps &=3D ~SMU_CAPS_MASK(DPM_POLICY);
+               caps &=3D ~SMU_CAPS_MASK(RMA_MSG);
+               caps &=3D ~SMU_CAPS_MASK(ACA_SYND);

                if (fw_ver <=3D 0x4556900)
-                       caps &=3D ~SMU_CAPS(UNI_METRICS);
+                       caps &=3D ~SMU_CAPS_MASK(UNI_METRICS);

                if (fw_ver >=3D 0x04556F00)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
                if (fw_ver >=3D 0x04556A00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+                       caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
                if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       caps &=3D ~SMU_CAPS_MASK(CTF_LIMIT);
        } else {
                if (fw_ver >=3D 0x557600)
-                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
+                       caps |=3D SMU_CAPS_MASK(OTHER_END_METRICS);
                if (fw_ver < 0x00556000)
-                       caps &=3D ~SMU_CAPS(DPM_POLICY);
+                       caps &=3D ~SMU_CAPS_MASK(DPM_POLICY);
                if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
+                       caps &=3D ~SMU_CAPS_MASK(SET_UCLK_MAX);
                if (fw_ver < 0x556300)
-                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
+                       caps &=3D ~SMU_CAPS_MASK(PCIE_METRICS);
                if (fw_ver < 0x554800)
-                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
+                       caps &=3D ~SMU_CAPS_MASK(MCA_DEBUG_MODE);
                if (fw_ver >=3D 0x556F00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+                       caps |=3D SMU_CAPS_MASK(PER_INST_METRICS);
                if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       caps &=3D ~SMU_CAPS_MASK(CTF_LIMIT);
                if (fw_ver < 0x00555a00)
-                       caps &=3D ~SMU_CAPS(RMA_MSG);
+                       caps &=3D ~SMU_CAPS_MASK(RMA_MSG);
                if (fw_ver < 0x00555600)
-                       caps &=3D ~SMU_CAPS(ACA_SYND);
+                       caps &=3D ~SMU_CAPS_MASK(ACA_SYND);
                if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       caps |=3D SMU_CAPS_MASK(HST_LIMIT_METRICS);
        }
        if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
            ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
            ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
-               caps |=3D SMU_CAPS(SDMA_RESET);
+               caps |=3D SMU_CAPS_MASK(SDMA_RESET);

        dpm_context->caps =3D caps;
 }
@@ -372,7 +375,8 @@ static inline bool smu_v13_0_6_caps_supported(struct sm=
u_context *smu,  {
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;

-       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_MA=
SK(caps);
+       return (dpm_context->caps & SMU_CAPS_TO_MASK(caps)) =3D=3D
+              SMU_CAPS_TO_MASK(caps);
 }

 static void smu_v13_0_x_init_caps(struct smu_context *smu)
--
2.25.1

