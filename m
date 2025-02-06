Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD363C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5522110E887;
	Thu,  6 Feb 2025 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HUGkpLT7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEB010E23A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V90dUQ+GTF8u4tNgN+pogqCejlDS//2qzuwE1Qcxqwj7+lqdEB8FpDeXRUeB/zDX0igzEPzm8P9EArveBk8qgQnigmNZz7eNuMkjcqSlnV+o60t0oMY4cKdM0kOU6YLQ38BjK1GmtKbr1BZp4MtmgcLtYnj9T8zb0MNZPE8bCC5exDysXN72hlCxLkMHeNEJ+FOAVmc3Yktb/R811/33lmBTODd7W5xQo1Dc0wOVBGYkKFkK7OLsF1ejdlJJYhJuqUqarpJQvAW+CrXDoupQXfwsQh9YWko0ffTZeKVDemj0mxdghJ8JVHZjknLf+7ZUX+C3WgbeR6RNKIYDBew3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF8tLkweKH+Dfp9oH7k1aAP1y/tMP/wReraYqaTr2ys=;
 b=Uq0X2rW847DKTYnB+ha8bgcbSkmVYEbhPGjCj+aD4zXBT/NCPecjVatDmoPkkgsxbGARdc2LIr74nysDs03xVGWJMFHtFwozT8zNmBVvrODYcbNWbNFPbyEzm/4tlu18Dqa1E+YVxipvzE43+oL4Xqj8OwxtRfViHIu6uR11KB/2K4wJmw7v8mE06Q6/itZOk1V7HOgyGZf8JhadS97yEgcFPqNeSFPSTEXCZrppwp6/Zs05MPW8DBAmygh9SHHSOIPnnB31vKvL6jJsYNEAzVrNlGjmJa+A8YWeNEAXGB8IKZOQ/ANg0ZJII0jiD//QfSAbwA2Wo0Ek0KHw0R06eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF8tLkweKH+Dfp9oH7k1aAP1y/tMP/wReraYqaTr2ys=;
 b=HUGkpLT78WtJO5G2PC8S2QpUiaB8rqhbr5fTigoC60A4uf6hGQmeTxXU+v1ngLskii0BvSejBRrzV88XqnxPs8FRPinqFD9zM07QCxOG13sRV4d8aSYv/4O8CbawPQtpFpAFS9Vm/Z9KjyWlpHcLES5w+R/6VXK9bhBC8jebXqw=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 15:00:10 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 15:00:08 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/include : Update MES v12 API for fence update
Thread-Topic: [PATCH] drm/amd/include : Update MES v12 API for fence update
Thread-Index: AQHbd/2If7rMZNk2dkSWXybZ6IuxnbM6X4pA
Date: Thu, 6 Feb 2025 15:00:07 +0000
Message-ID: <CH0PR12MB5372604F7A63685585D3619FF4F62@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250205184055.104040-1-shaoyun.liu@amd.com>
In-Reply-To: <20250205184055.104040-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89282ea0-d88c-45fb-acdb-44370316ec07;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-06T14:59:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB8503:EE_
x-ms-office365-filtering-correlation-id: 54075623-2a74-4dcc-b77c-08dd46bef24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TFnS7sNXdSmvylIfIwQlpBUVVwp2yZizIND5MOYn/GtvEn82YN5bz6QHMspF?=
 =?us-ascii?Q?jrk8smYrIXgeOyCCCeS1ndWljYr99YG7U/XZfsjSEB1BCOHVTgL5wtc9BFyL?=
 =?us-ascii?Q?371/11O/6oFaUMRwPHkCV94uaROjP+0s04zvQGDm+0XRkwPuMyAFTsYHoTiX?=
 =?us-ascii?Q?Q+gRitjiKmBg0urpPazLfjQEmMYl/54bKdmTieXPV5FxU117O5kwcZkv+1B/?=
 =?us-ascii?Q?1c3i31YdGLT3ojsH2OHSZC2TWUN6tYwHPlcH/4M6/aOWO1yDR74U/8BZeAzc?=
 =?us-ascii?Q?PGgrV5A9aEzqp2SgsXs/7QGw1EnUbLryIjuy6a67MHwb82DP9MoS+ycqIlmq?=
 =?us-ascii?Q?yPN3hnXFE6UP42GR7G/8hwHhc/EJNdQeASHADLuVYRUMFbRaG5Ea+mk1gu+a?=
 =?us-ascii?Q?X9OcAsnBF0U2cWKSfslfceJ+ibNCiCLZ4uYGLIbZJGXM+ZVQJ/ZnUXSDaC4+?=
 =?us-ascii?Q?W2a0y3RseL+g7iRSQZ9mmX2DIqKOKtSVdRjl2oQizZsPDbRrH1z7J6VbB1Gp?=
 =?us-ascii?Q?lyEhD0TsQSoP5Y+2z4uTJCer23u+ySkwSG15mLrnpdKXFRFgFohtgk/NOlSa?=
 =?us-ascii?Q?km1nx93/Jrpl8yJ/MuYaaATPcnVA31t08YLFdEoMWHv6KHMyp/pmnqPvpMH4?=
 =?us-ascii?Q?2b0+qiS8GwHnxECr6zusPR5Cm/uW6O32V6D7XP9gAN1LIxOYf20eWhQO7z9X?=
 =?us-ascii?Q?8K+Nbqn/d6rVFR32ikPxKUQbpF5607z8pOm7mHw7jp85hoFyW8Wqch6+0Nda?=
 =?us-ascii?Q?69GyI5D2y6OcqFgCz1S3uLP18uK9zg+hZ2cZ9J32+NwegOJ89p98XjGkrHVs?=
 =?us-ascii?Q?qpkLehXFkgRxs5YlzF0vUb+xa48w2avOptN8OvoJ/hK14Cq8H800QMMWghGX?=
 =?us-ascii?Q?tGUcmFz8Ct3oTPapaHAoweFqJAIZJgQUDXWOtKjt0U6UiN2Zx3bRv7972YlW?=
 =?us-ascii?Q?Niik3F05TUuI/aFN7dT8EFKhV8bIrfPdre+m1zo/urJo1sN0pDPPF/gl2HRa?=
 =?us-ascii?Q?/p0ClMEXriHU7B0o87utUeCH86L6iLp3XvFYuvh76ui8QXZEWn8+wB8f68sz?=
 =?us-ascii?Q?b0xSMM9oGP/gHZ0iA0U4s9Silp23w1+cBaRaz/A21+MBJMBNbyHANkFARKle?=
 =?us-ascii?Q?NEiIbY/EAziQ+oXWLfEo3205hgRH/T9llQGGEGH9+mtd34tH5MhDD/B5KQ2U?=
 =?us-ascii?Q?lmUAd+/tfOWW3QQ+zqAhfQjTFFJbtG5YimTeBs2kWglCVXle5bEwVy/3PeZu?=
 =?us-ascii?Q?2Sh2WloRY0Go6a3t48HqS5gjmgyrzAW9YmtWzH+8XnTZH0enbuJp8XoX5250?=
 =?us-ascii?Q?BtG+FicgD+6nxEgsALMqql9befwwFD/VgFRhgASKDnqrluqIhZrEvG7c5mKL?=
 =?us-ascii?Q?0wZ7EdZhzJyFaltDeHZ2PDDHewyJjyTpg/N4HOMk2sz+B0v7Q5fgku3qWB1T?=
 =?us-ascii?Q?ti6IrBoYCR4gZWr2c6jwOs45dy0PMGNG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lMTZZmL1Qxez/72ms3+dsWGE7rC0dThWzjw0XIKk/OfH5lgxBLBSxlTUE4S5?=
 =?us-ascii?Q?Mb5Wp5DR4n4MZmRsX29mMDtf/VXbqsanKtrLGUrzh0qdbwsbwLqEm5vPPGDE?=
 =?us-ascii?Q?VndiLJV6L42FjSfw5+30oS4Ex0uxnYI2gpvRZuE3LflpUnknxCWB5DM7jT4i?=
 =?us-ascii?Q?B2jz+OrGEafbX1SHkSC5va8PVTHzRzWaPN4STBBQ/yGW5zvwhGZP95wINhmG?=
 =?us-ascii?Q?pjHyFhwK1zVsy9BFThCxHnkYUNd4knyL46lrDWRoP5090q7X/jh1/cjv5hzA?=
 =?us-ascii?Q?uTh5OCMQG8D5fZWI0qozLvIkLE8CJHYjtBFiu90RJzD2vWb5eCigK6f4fVPf?=
 =?us-ascii?Q?rww8acQBF9UVTCQU/AgrWX8xsN+FvJ4oEg03y4PdHJCldsxYz76wSKk6iRgS?=
 =?us-ascii?Q?OeatVjMAp1NQEaPUI/bobQDcEDlbIc2VlKN2TXxhHfoVTRPA1rR2smj3Oy6n?=
 =?us-ascii?Q?3P3XgvkVVUrr6AWDnJsXXEv4GbIWt7fa9breQMaPbug8ZpwwPX4tVsij00c/?=
 =?us-ascii?Q?IPyGrdhoR5O4bLkE7BoEDb1yRAw2FyImiQziXbiFrI1f/bsH2vuR51Lfnd/m?=
 =?us-ascii?Q?tbz3LKcYwpIJnXGwkJPQgZCw/si+sRMUq/o+tRcMhrIvknypwmK1DZRQXV9W?=
 =?us-ascii?Q?KvlnuBwk1+xIEv8n/YQ9yoAGwa/UpU0Wf5DGqnxuHAkokJ/fHRJQ6q/mc8fq?=
 =?us-ascii?Q?LkSPqrts8G8qhF8uhkZCxtYAkj9swfwIelRFjnl0nHLRYyYSjddcMDv2+Zhg?=
 =?us-ascii?Q?ide29a2BM78ZblJgFFHx+kzc6cZz7KtRwgCJGAu5BSUIpgBwTzND1k2M2eba?=
 =?us-ascii?Q?34QsRVO9dv/kVk4ZVhbC6qkwOnzbouxbVJGNyAYM3oRcyAO7ZbNbr2jKozi4?=
 =?us-ascii?Q?KalOMuQEOA4hc/z5bBuHSPC48LI5ORfhl3WsOQeKO20H9xsgNXLxM/mtUKPs?=
 =?us-ascii?Q?V219qsFd1OAYASridYs29+4M5DYKP/5pUr7FLJUYKAwuGUL0lf0s4/4ebQlL?=
 =?us-ascii?Q?khgm7TsIf0dCDmwvwq37srYuDbJDKOSQBiCb2vRG4FMUn+F8NMEmtIdEzbjp?=
 =?us-ascii?Q?GNJFsSIooEiTURyP4NyJsAGomQ9rle7nCjxPCXSN+piww2G7Ipp0iH5qSGQB?=
 =?us-ascii?Q?GblNhUFP9V9F7pVkN1VriK0Cguk2HFJTBy9WoSVQOXnAWhvbgrcnYHdsgGq6?=
 =?us-ascii?Q?h6v4y6JxiJ77FjqmaQSZNV6qgNC+u+D/NHNswTIFNOHsGaajby9Hmof1bFp0?=
 =?us-ascii?Q?CmKk4Ea7p/j+bRp/tKYOXb6B/UgYHexemOU5Ztjz5O0x3YazjllEiGm4q0jr?=
 =?us-ascii?Q?xAWZtvY9COxij+ljvIoKS9X8E1Dn9+NJ2wpcknO71k9J8SB8/nP34QfPvAIL?=
 =?us-ascii?Q?8jKb43UHiF+dahXXn1edu6lyXkpn3BrIsodQexZ8ZJt1Cknpj/2V8UDYz2Fo?=
 =?us-ascii?Q?1LU1NA4sdevIOau8rwqxrrcn7HmP0hEjski079Y2h99mCM7ZlPm//boRr3F9?=
 =?us-ascii?Q?vwLzOJWcBxaYWk3VR0GhrNigYGdzcKgHB/JYJMaThwNa3+Kxemgh2iRzUa4M?=
 =?us-ascii?Q?AdiCnvO2wYaKhPa9fn8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54075623-2a74-4dcc-b77c-08dd46bef24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 15:00:07.8873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRgTe8J+fppxNV1AFBWbqV9iTSjrCOyAct1BwSGYqLbNG6hO90n/dPnhhTpNCHleETbvsc//EocaLKjRiS5W4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, February 5, 2025 1:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API for fence update

MES fence_value will be updated in fence_addr if API success, otherwise upp=
er 32 bit will be used to indicate error code.
In any case, MES will trigger an EOP interrupt with 0xb1 as context id in t=
he interrupt cookie

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v12_api_def.h
index 1938150a1943..fb918668ddae 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -105,6 +105,43 @@ struct MES_API_STATUS {
        uint64_t api_completion_fence_value;
 };

+/*
+ * MES will set api_completion_fence_value in api_completion_fence_addr
+ * when it can successflly process the API. MES will also trigger
+ * following interrupt when it finish process the API no matter success
+ * or failed.
+ *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int
+ *     cookie) set to 0xb1 and context type set to 8. Driver side need
+ *     to enable TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to
+ *     catch this interrupt.
+ *     Driver side also need to set enable_mes_fence_int =3D 1 in
+ *     set_HW_resource package to enable this fence interrupt.
+ * when the API process failed.
+ *     lowre 32 bits set to 0.
+ *     higher 32 bits set as follows (bit shift within high 32)
+ *         bit 0  -  7    API specific error code.
+ *         bit 8  - 15    API OPCODE.
+ *         bit 16 - 23    MISC OPCODE if any
+ *         bit 24 - 30    ERROR category (API_ERROR_XXX)
+ *         bit 31         Set to 1 to indicate error status
+ *
+ */
+enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 =3D 8 }; enum {
+MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 =3D 16 }; enum {
+MES_ERROR_CATEGORY_SHIFT_12 =3D 24 }; enum {
+MES_API_STATUS_ERROR_SHIFT_12 =3D 31 };
+
+enum MES_ERROR_CATEGORY_CODE_12 {
+       MES_ERROR_API                =3D 1,
+       MES_ERROR_SCHEDULING         =3D 2,
+       MES_ERROR_UNKNOWN            =3D 3,
+};
+
+#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
+                       ((uint64) (api_err | opcode << MES_SCH_ERROR_CODE_H=
EADER_SHIFT_12 | \
+                       misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | \
+                       category << MES_ERROR_CATEGORY_SHIFT_12 | \
+                       1 << MES_API_STATUS_ERROR_SHIFT_12) << 32)

 enum { MAX_COMPUTE_PIPES =3D 8 };
 enum { MAX_GFX_PIPES    =3D 2 };
@@ -248,7 +285,8 @@ union MESAPI_SET_HW_RESOURCES {
                                uint32_t enable_mes_sch_stb_log : 1;
                                uint32_t limit_single_process : 1;
                                uint32_t unmapped_doorbell_handling: 2;
-                               uint32_t reserved : 11;
+                               uint32_t enable_mes_fence_int: 1;
+                               uint32_t reserved : 10;
                        };
                        uint32_t uint32_all;
                };
--
2.34.1

