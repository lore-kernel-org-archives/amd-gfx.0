Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF67C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 03:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B33510E42C;
	Mon,  7 Sep 2026 03:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OkrKRSjQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B6010E42C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 03:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQBpmQaM14Uc52qAErhjobFUw8OLE9fdpSXsJRAZTtQyUt5GBQw0YEkqIK14H0hSE+Jlv775Sd6MicVuZron/7cha8C6L66Oxd93scoaB1VIMTlnrYIpopwzgZPlhUx/WsgHUJd0t+JAFbOrV/lmD9pa+AUeL21xfVrwzgaE3OgMN371pnS3fcsAHeenwcr/yhgGtqMZdHDZrp41xmmChYwdHHiTd7Hv5s7ZJsawibyGbFKGhlRZzumd0uIDvzse+C0cHlzbl4847tBg+nWJX8L0gD2Y2/CqKQnf5vsGBwredaKLBJLwa4Jc+GKD3Kzi/NqGClIQ+U1I/QSWqt8Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4ANI2cNa1Rp8Eh6VuzfABA8tkPNgqLw04iODB8k3tw=;
 b=F7IlR8yYwbgvDnLedkMCaw2QVBtPzUNp4lM9CxdDyQyB8Nn7yAmxruuxJuTl83+JG4faNLxYBefdE93D1rW3+i9NIEl6Sk/xh9ReW/nBDwUr+YqqZbiF9MSemFTLK9fgATyH9AmAJ5RA7GzU8hj3zX//ymPuOf0/57acKzTUSLJxRGSQtoA//7KNzbSK8yIzEpVpcLanq0Ct7NS2WrLcSg900GPSsKTpIY1D7IU6OIV4gKjGd3S6VbFfZ8KIGiq1/4UKk5y31Fh3FKB2OmcpKpB5zjZ/wYRdrsVyD6CJ9hYSdcdty1TcYIDFtLGUfPbL94DJ8iSrHYzRkWTkJRQFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4ANI2cNa1Rp8Eh6VuzfABA8tkPNgqLw04iODB8k3tw=;
 b=OkrKRSjQWEY+nX8ddyudj0pd9qcSSRMdQ+ygqz1TqZZ3gkyAhz72mHUtLCkyP2jODzz4uKwc3Nos6iiGqTxEexIuyp5OzJS4AdfldNVRRJT546lr6r1t5aNlCUYXPnrC31exWUFIry8AA/Vy4bKW0+VR5Bq/ec2oWD9Z1L1Wpv8=
Received: from MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 7 Sep
 2026 03:56:54 +0000
Received: from MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::5875:b3ab:e23d:e146]) by MN6PR12MB8567.namprd12.prod.outlook.com
 ([fe80::5875:b3ab:e23d:e146%6]) with mapi id 15.21.0360.008; Mon, 7 Sep 2026
 03:56:54 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/13] drm/amdgpu: Use common doorbell helpers in nbif
 v6_3_1
Thread-Topic: [PATCH 13/13] drm/amdgpu: Use common doorbell helpers in nbif
 v6_3_1
Thread-Index: AQHdPR5BX95O0mt4sEqxvP3Pxniw5bbCf3ag
Date: Mon, 7 Sep 2026 03:56:54 +0000
Message-ID: <MN6PR12MB8567C17577D0F4D0FE342C98EFB22@MN6PR12MB8567.namprd12.prod.outlook.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
 <20260905100538.12877-14-Hawking.Zhang@amd.com>
In-Reply-To: <20260905100538.12877-14-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T03:56:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8567:EE_|LV8PR12MB9230:EE_
x-ms-office365-filtering-correlation-id: 729a0b82-269a-4fb8-3fbf-08df0c940e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|56012099006|4143699003|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info: e6j0Lq2O+YuaKDIrfoIV+sVIHzi6WBYqasKdQoXn6UYKRyJ8KVpiFl/MEiIkw8DIjIadmZ6U/TyTtkpMb7VWDLjFnBXGZWrirDoEK7zIgmacwQxwpP8+Svts6aI+05aAKmn85Rk6wLyAZoGCDiXneDQa2gLoaQISmuZwXATNgtRBdbbAC1hnWeyi2DujhtFJemLOutyOtqSy77FvdehFP2Jpt+aje1VRfNqdcTMo6bWQPM6iRdYnQpxvrNuoeNyhc2wtmrNSLNcaYYM1R/bsxaULnhZyCKBEzxDDKrd/dTp8tWEbGn8YEXBSy4k0Iu03TYH7r5yxGjb5AfceGU8Nmgjdz8TpV5FnhZR1u56Owk4MpBlpSQDZqEgCEpZMtyYHZ/jY2QucrHtc6YYwW6HsJ8K5hUDgqreED58SONMai51/lkThVl2J7fxug6sUYOVvwWbvuD2a4HrdLlxG7ZRp8dEI1WMWPn9ibIV9UiZbAF3o0Gn3p/wfRJqNcLWf+ytO1KA4Pp6eI5tKz0g4FW2uFnxpGM9oLMfNI5bGiViDlvvRJ0Wt979x1Q+gNcg6DWrH0GcuuCcH0pznMvLiPYxzEy4pwRcnaRFBiJWLVK+qkKX+hYIBxZQ+EjCu/zEjJvhgdVEOqQ1oHKKW5OW7i9C3+oR3LQ7WtrAz1OZxAZ+gXaz5ojchheVTMnpoWAguZPZ4KIdlB3YYVHOFeJsr1PGSmNCMBRWGb6F01m2+YTD/u3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tfHY8XwF5Gl+ExUFQxISSkhuiF028CkxfGyzm0imOmMxQ1ToOuOxuyAOc5Y+?=
 =?us-ascii?Q?HPHwb2c1jh5ZxMkCxzEpksywDC1dSwQXQM0P3sd/2CzKt0uTXsmRt590XCyM?=
 =?us-ascii?Q?CKCpWlq+vGegOEzaVKnuCUybOgOa7BPMECoqDc4ghgxILvWPrJktbAp52aW3?=
 =?us-ascii?Q?+g6WkGkNBpymYqM/2WdzrtH3uRumdWURiRKpmmBDplIyMUAO/qE5M64+BfX6?=
 =?us-ascii?Q?YmYnISIE6uyx16aTybuSOCEFHWn+/QipRu5fgo4mgFs6T6MSVvyW94/7EA9/?=
 =?us-ascii?Q?wzfX4ANZYNXKC3BbQr1EFE6g5d/TN+qVz/A9frXhDtQU3PbwKD1fQImzxBFa?=
 =?us-ascii?Q?xwxCHxumz3cysNGtK3cULSbIJUeplQcQJZzEq6h5ehEDq3oMRKcrVQRxDjED?=
 =?us-ascii?Q?UowkYR7EUTMch54w/iHJljhmb2vkmdBCyP4RiSjU3WU+jdRw38JpIPEm+u26?=
 =?us-ascii?Q?TnCvj04mZ+4B/W8aMVgmfpmcZ9ElW+RX5EezuuJu7eChTrH8vHTGtwJYMPKZ?=
 =?us-ascii?Q?CIKVeUoESdlb0w+zqz4rOflvo5Y+ho5O355h4Nc21z5N0no2SZGmPyIB+2bN?=
 =?us-ascii?Q?AWYCZBxhPyWWLtr951XXfgEAvz+GBRUtxg+W5PDW1CQYsyW0h1xE1lTOi3UV?=
 =?us-ascii?Q?eU+O31VJ0xnEMhmjMJ8Ylf7uKmO9RwOXryibxRqRyc9cpMjRdBHM2GeWxqfx?=
 =?us-ascii?Q?6mdSOyQT6zjBL9pVWcaBBRDijpu3oKz7lA6pBTRVpVwqnORHD4ksIFsfys5E?=
 =?us-ascii?Q?zdJJ4sFBApLPVXhoAa8wTbiz+8KJzDFxvW2GrsU8drNa9rypWEvScCQt8Ms1?=
 =?us-ascii?Q?msswSL+qm3e4qwh711H5CEQTzDh/3aJb3JVC1/2vNqA801cdBqQm4PWn1JLL?=
 =?us-ascii?Q?Nkw/B3beaF0fVRR9qR68JiIWQNmiM/dNt8sBGbeVcClCCdIcgFlqNx5r4gVR?=
 =?us-ascii?Q?DQriN7zSL8vVt3d8Gz6kjNIZ+vHoe1PmRuhwBOI/yhLqvCcyR/V3OkdAVsD2?=
 =?us-ascii?Q?UVxwiCefKcMkPfednu2uoReShlIbI64t2mlEI+Tu51zthP7nTK8f5DnDL4aV?=
 =?us-ascii?Q?Dj/as92foQD5dJL+P/LJbe3EyIeJyJtPoyD0K6TGE7XnqOXHVEbRRCKsGw/L?=
 =?us-ascii?Q?ajG/4dKXJha/RfYqC+4SjA20gEGqd2rh/bnJivnass1IxO807f7MifTTBbmp?=
 =?us-ascii?Q?RX9vinzf2RT6DDKn+RjfEGreRPP072Nw8m497yESqwPl4/6O0Ub+NvDi8GbL?=
 =?us-ascii?Q?q6g0bGQ2MYHOwT7/4aZE8WnchXR5HZhQSnj02m5J8DbVVtPf0WDhMGbPE9wx?=
 =?us-ascii?Q?Mw/8QjAzisxoPzLx1OvOm4bqDpTEhb2LALenI86sL9da8a/24IpsWKCa/+DH?=
 =?us-ascii?Q?AGMdrTR/1ynfSs1GA3vErZ+PXsEBmzTUYdAXSZpuw/Ns0cupq8m6J+RUCFgt?=
 =?us-ascii?Q?uFN0pZIddRKkKJ7WJlcR4aamzPiUO8/4FLxrk9pXcpt9F1btgpC5CpEP2W4T?=
 =?us-ascii?Q?A8hMZsaL4y1Hnf9IchOqCLkS+Ce8UiOLHigYJw15Wb4l572pTjHkGxGWRlTj?=
 =?us-ascii?Q?MSYq++uAke71Jl+bN3xEi1Bv9WwxS0axeq0QGYWN5duedWGUM1IY81AvBLFa?=
 =?us-ascii?Q?kpMcQhkzPcOB7GQWf3znkcQuGTbqZCCJIcGgd0+lhJ/2Y5cJ2eKm/QbVABBi?=
 =?us-ascii?Q?vAFq3TK7hlXi1QS8UxnPYnZdMTH7t7HZwrq8SSTBhKPPqWaN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729a0b82-269a-4fb8-3fbf-08df0c940e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 03:56:54.7582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUyTqPXpxYcXJKE+3oYA9hzdgW3ZS2aCaG62Qiy4Ec+sA5wBrVPqTO1eGiZ/yLqe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

AMD General

Series is Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Saturday, September 5, 2026 6:06 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: Use common doorbell helpers in nbif v6_3=
_1

Build and program doorbell entry control values through the common NBIO hel=
pers while preserving the existing nbif v6_3_1 client routing and field val=
ues.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 317 +++++++++++++----------
 1 file changed, 187 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index 766cfbde55aa..ce05f40f548a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -30,6 +30,91 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>

+static const struct amdgpu_nbio_doorbell_layout
+nbif_v6_3_1_doorbell_layout =3D {
+       .ctrl =3D {
+               .enable =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_ENABLE),
+               .awid =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_AWID),
+               .fence_enable =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_FENCE_ENABLE),
+               .range_offset =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_RANGE_OFFSET),
+               .range_size =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_RANGE_SIZE),
+               .disable_64bit =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS),
+               .deduct_range_offset =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET),
+               .drop =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_DROP_EN),
+               .awaddr_31_28 =3D REG_FIELD_MASK(
+                       GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+                       S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE),
+       },
+};
+
+static void nbif_v6_3_1_init_doorbell_entry_registers(
+       struct amdgpu_device *adev)
+{
+       struct amdgpu_nbio_doorbell_entries *entries;
+       u32 ctrl_base;
+
+       memset(adev->nbio.doorbell_entries, 0,
+              sizeof(adev->nbio.doorbell_entries));
+       adev->nbio.doorbell_layout =3D &nbif_v6_3_1_doorbell_layout;
+
+       ctrl_base =3D SOC15_REG_OFFSET(
+               NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL);
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_CP];
+       entries->num_entries =3D 1;
+       entries->entry[0].port =3D 0;
+       entries->entry[0].ctrl_reg =3D ctrl_base;
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+       entries->num_entries =3D 1;
+       entries->entry[0].port =3D 1;
+       entries->entry[0].ctrl_reg =3D ctrl_base + 1;
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+       entries->num_entries =3D 1;
+       entries->entry[0].port =3D 2;
+       entries->entry[0].ctrl_reg =3D ctrl_base + 2;
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_RLC];
+       entries->num_entries =3D 1;
+       entries->entry[0].port =3D 3;
+       entries->entry[0].ctrl_reg =3D ctrl_base + 3;
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+       entries->num_entries =3D 2;
+       entries->entry[0].port =3D 4;
+       entries->entry[0].ctrl_reg =3D ctrl_base + 4;
+       entries->entry[1].port =3D 5;
+       entries->entry[1].ctrl_reg =3D ctrl_base + 5;
+
+       entries =3D &adev->nbio.doorbell_entries[
+               AMDGPU_NBIO_DOORBELL_CLIENT_VPE];
+       entries->num_entries =3D 1;
+       entries->entry[0].port =3D 5;
+       entries->entry[0].ctrl_reg =3D ctrl_base + 5; }
+
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)  {
        WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -70,84 +155,59 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amd=
gpu_device *adev,
                                            int doorbell_index,
                                            int doorbell_size)
 {
-       if (instance =3D=3D 0) {
-               u32 doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2=
A_DOORBELL_ENTRY_2_CTRL);
-
-               if (use_doorbell) {
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_E=
NABLE,
-                                                      0x1);
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_A=
WID,
-                                                      0xe);
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_R=
ANGE_OFFSET,
-                                                      doorbell_index);
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_R=
ANGE_SIZE,
-                                                      doorbell_size);
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_A=
WADDR_31_28_VALUE,
-                                                      0x3);
-               } else
-                       doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                                      GDC_S2A0_S2A_DOORBEL=
L_ENTRY_2_CTRL,
-                                                      S2A_DOORBELL_PORT2_R=
ANGE_SIZE,
-                                                      0);
-
-               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL=
,
-                            doorbell_range);
+       const struct amdgpu_nbio_doorbell_fields fields =3D {
+               .enable =3D true,
+               .awid =3D 0xe,
+               .range_offset =3D doorbell_index,
+               .range_size =3D doorbell_size,
+               .awaddr_31_28 =3D 0x3,
+       };
+       u32 ctrl;
+
+       if (instance !=3D 0)
+               return;
+
+       if (!use_doorbell) {
+               amdgpu_nbio_program_doorbell_entry(adev,
+                       AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+                       NULL, NULL);
+               return;
        }
+
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;
+
+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }

 static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
                                           bool use_doorbell, int doorbell_=
index,
                                           int instance)
 {
-       u32 doorbell_range;
-
-       if (instance) {
-               doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DO=
ORBELL_ENTRY_5_CTRL);
-       } else {
-               doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DO=
ORBELL_ENTRY_4_CTRL);
+       struct amdgpu_nbio_doorbell_fields fields =3D {
+               .enable =3D true,
+               .range_offset =3D doorbell_index,
+               .range_size =3D 8,
+       };
+       u32 ctrl, entry =3D !!instance;
+
+       if (!use_doorbell) {
+               amdgpu_nbio_program_doorbell_entry(adev,
+                       AMDGPU_NBIO_DOORBELL_CLIENT_VCN, entry,
+                       NULL, NULL);
+               return;
        }

-       if (use_doorbell) {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_ENABLE,
-                                              0x1);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_AWID,
-                                              instance ? 0x7 : 0x4);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_RANGE_OFF=
SET,
-                                              doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_RANGE_SIZ=
E,
-                                              8);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_AWADDR_31=
_28_VALUE,
-                                              instance ? 0x7 : 0x4);
-       } else
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
4_CTRL,
-                                              S2A_DOORBELL_PORT4_RANGE_SIZ=
E,
-                                              0);
+       fields.awid =3D instance ? 0x7 : 0x4;
+       fields.awaddr_31_28 =3D fields.awid;
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;

-       if (instance)
-               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL=
, doorbell_range);
-       else
-               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL=
, doorbell_range);
+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_VCN, entry, &ctrl, NULL);
 }

 static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev, @@ =
-155,47 +215,54 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu=
_device *adev,
                                                        int doorbell_index,
                                                        int doorbell_size)
 {
+       const struct amdgpu_nbio_doorbell_fields fields =3D {
+               .enable =3D true,
+               .awid =3D 0xf,
+               .range_offset =3D doorbell_index,
+               .range_size =3D doorbell_size,
+               .awaddr_31_28 =3D 0xf,
+       };
+       u32 ctrl;
+
        if (instance)
                return;

-       u32 doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBE=
LL_ENTRY_5_CTRL);
-
-       if (use_doorbell) {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_ENABLE,
-                                              0x1);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_AWID,
-                                              0xf);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_RANGE_OFF=
SET,
-                                              doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_RANGE_SIZ=
E,
-                                              doorbell_size);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_AWADDR_31=
_28_VALUE,
-                                              0xf);
-       } else {
-               doorbell_range =3D REG_SET_FIELD(doorbell_range,
-                                              GDC_S2A0_S2A_DOORBELL_ENTRY_=
5_CTRL,
-                                              S2A_DOORBELL_PORT5_RANGE_SIZ=
E,
-                                              0);
+       if (!use_doorbell) {
+               amdgpu_nbio_program_doorbell_entry(adev,
+                       AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance,
+                       NULL, NULL);
+               return;
        }

-       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbe=
ll_range);
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;

+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance, &ctrl, NULL);
 }

 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)  {
-       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x3000=
0007);
-       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000=
000d);
+       struct amdgpu_nbio_doorbell_fields fields =3D {
+               .enable =3D true,
+               .awaddr_31_28 =3D 0x3,
+       };
+       u32 ctrl;
+
+       fields.awid =3D 0x3;
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;
+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, NULL);
+
+       fields.awid =3D 0x6;
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;
+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_RLC, 0, &ctrl, NULL);
 }

 static void nbif_v6_3_1_enable_doorbell_aperture(struct amdgpu_device *ade=
v, @@ -231,37 +298,25 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(stru=
ct amdgpu_device *adev,  static void nbif_v6_3_1_ih_doorbell_range(struct a=
mdgpu_device *adev,
                                          bool use_doorbell, int doorbell_i=
ndex)  {
-       u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOO=
RBELL_ENTRY_1_CTRL);
-
-       if (use_doorbell) {
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_ENABLE=
,
-                                                 0x1);
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_AWID,
-                                                 0x0);
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_RANGE_=
OFFSET,
-                                                 doorbell_index);
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_RANGE_=
SIZE,
-                                                 8);
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_AWADDR=
_31_28_VALUE,
-                                                 0x0);
-       } else
-               ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
-                                                 GDC_S2A0_S2A_DOORBELL_ENT=
RY_1_CTRL,
-                                                 S2A_DOORBELL_PORT1_RANGE_=
SIZE,
-                                                 0);
-
-       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-                    ih_doorbell_range);
+       const struct amdgpu_nbio_doorbell_fields fields =3D {
+               .enable =3D true,
+               .range_offset =3D doorbell_index,
+               .range_size =3D 8,
+       };
+       u32 ctrl;
+
+       if (!use_doorbell) {
+               amdgpu_nbio_program_doorbell_entry(adev,
+                       AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+               return;
+       }
+
+       if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+                               adev, &fields, &ctrl, NULL)))
+               return;
+
+       amdgpu_nbio_program_doorbell_entry(adev,
+               AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }

 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev) @@ -343,6 +=
398,8 @@ static void nbif_v6_3_1_init_registers(struct amdgpu_device *adev)=
  {
        uint32_t data;

+       nbif_v6_3_1_init_doorbell_entry_registers(adev);
+
        data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
        data &=3D ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
        WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
--
2.17.1

