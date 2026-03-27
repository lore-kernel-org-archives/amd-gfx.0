Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3915A10BA435
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 08:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACA110ECDC;
	Fri, 27 Mar 2026 08:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0S10q4f2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8832B10ECDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 08:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZd2daoy//WixUE1kzq57O4gpkmw735hDPcQsHCf+9VqBAbATf8GCORWmncqGObwIcutwHLMBacc4lDWT0MIrTjNZhNDJtS1ptTbxKG2DWJuVUR+/GiF0KB9foTq1S96o6wB8E9/+2HUNJVRknLwYFNLEV7p2AmaEjjq3W3m5raH9lUDnOsZrs6C/UvgNeVIRKwjk0Qj+XmUPcjLGYL2GdIL02Nmg7A2RObOndq61c1XadpuuiuBnFrI4yoESLjq22mkx8vQVpfE731NIMMJSYOtH5V1ki5IjNfqtu1pky+ue26JYE+pjnuJ5lKI5FovEzFAOQLRvhodQdMEbpmbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gx7eA7S3DZ+oGLWL+vAU2eSVJnHJpLB9ou70qn5B1g=;
 b=dNqHtftkiwGSPYGrnuIOqVFfM6bqUCbphsZzPR1JTOnlt7W1qnuDw9xEM8eDcjufvDLUpViuH9JhpckxTeHwXrnOZbQuYD4h5Q4Ux5X2M365oIvGxT7c3+6JV6V3y5rDSniSmY/CvIf1qmJyuqIJO1jf118jvfEAUg70BBhixrj54t00wtmWIq6vocGREfk9w3Q9oXglbt8tmB5k5r8GB3UeUr+uVGCPgiJZquRYi+DAbAu/17Wq/IctqAbetanho4rNmrIMvRSI4Xedzhk6VOekxVSkgY5OvdAcUQrd+WLd0kfVBR8tv54x4cezwj9BCP12JGQkmCH1wCk7YxFLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gx7eA7S3DZ+oGLWL+vAU2eSVJnHJpLB9ou70qn5B1g=;
 b=0S10q4f2UAOeNXSBz0Y+ZIeqGXcyvo16NorQ3ZUCpFL77bdE/kWpUCC9gNEccPXKsEV8ntrPHSgGyYIGpy38yo/u2rg007pT0oABAAjNC+KpxK5zHc7BnrNpA0zB3alSceLy5HC3Rxej3rSaCEa1jxYz2cJEGfHc5yb4R0uGMFY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH1PPFDB1826343.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::628) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 08:06:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 08:06:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Switch to dev_* printk stuff in
 kfd_int_process_v12_1.c
Thread-Topic: [PATCH] drm/amdkfd: Switch to dev_* printk stuff in
 kfd_int_process_v12_1.c
Thread-Index: AQHcvYWeINYhp+9ZJkKGUJl4fV8csLXCBiMQ
Date: Fri, 27 Mar 2026 08:06:36 +0000
Message-ID: <BN9PR12MB5257B2B31F039D13F3758677FC57A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260327010348.38134-1-lang.yu@amd.com>
In-Reply-To: <20260327010348.38134-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-27T08:06:18.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH1PPFDB1826343:EE_
x-ms-office365-filtering-correlation-id: e768fc77-673b-47d5-4360-08de8bd7c490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: va4YKLY3LkiLkz5nCeFJ3M6IYb5HGGCaBwM9L5vFPXgT9Grs9DOhz0GX5C8shY5pQlNnl3bOi9C7K1uTC4POgMmn4LkpL8ygaRLDUTgBX9vVmPlpRU6EFDSruWZKxdw5VL0xXL0ZLq/xxkWRRbJlYn2ZtnikcAZ2G3UEJYyBL93WZ91wQZ0arGSi6X4Bm/LrRlXKX7UvnZdpvKVUHKJ4lhzHi4+qzWR4zPYZdfEale1ns23qr7H7UpfbQU0OGHU13tFFM2MiBnBhab8VvC/Tscn910OL1YmC5JmkOCW/4TfF8Qcvr75CHT828lO5D0bOCOJZron4GoNBAJ+qVObdUB41DGdoq4tAXnMCzmM0fkdiXB1JAsm+976zS2+QLbbdJCcl/Yjgk5KgKY9lek7hQn37Q4q8PmtZqh8JbIQcJCNFfkavBYGpVrxW9+6O7cqlH7MAjn5SHfS8pPPnsWwWf6Vz7vhCGXSWBIGnSxNrkfYRVuaDFNl63wwD2pLJN0EaerTdXa564BKaLSF83rnB9EtWtTaSwoJ8x3RJMcsGMbhX24rREaw0POTh4zB9bLw0+in6c1oGSSj3DQVHoRWQ48RFNNTDW04CSelAVF4fwRn7ib3+Gfq0LDmeTlIl3m1TpzhI3o8PknF8nPFR1MYJKFM3DX1e+Q8cByPCV/VT4E90tazfjN7hPtEfYVds+1A/YloxtD803LyM7aVQI/9SEJIYPJOGvF+SkpcyLX8zhU7hheSDvNPJ+OvwvHid2ThY/DLuu0PgLH6TCcgisAGw+Sy7FmIlvvTwajUbVjhpN30=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2s6kVrsSQ8CQRSGIy1LnPv6El+1Rxdvy2DYhnhYsMpgPcU8wm2kTJlwxfkCh?=
 =?us-ascii?Q?WqvAsnTkAaqOzCpIPWyctLf9GLcVuAS12yV9+P8Eh/XulNOu8zwwjf37S29y?=
 =?us-ascii?Q?6xpfI//GC1/4VWUS6a3Jx10J1qSOqhw/T9MCpT3pmBkwPz87mMNJ5CGMmnnm?=
 =?us-ascii?Q?NwjbXlh9X8hWS/0j9kapmnbJwg60aXqV63QIWSFoDLuBk7TJy+iMldLKbUPy?=
 =?us-ascii?Q?HIouMFECGiXsRvZGp8QKF0IL0juKDlSaSOyBEHpss4gu2MOAFwZD0vXxcxqm?=
 =?us-ascii?Q?hR0M7l7aG6GWEuWadckH/UBw5Hf0GGHWmjH9YiLZOR1v+5N5XgsxfkiqfJmV?=
 =?us-ascii?Q?+egT5EELKjJ7HwjzAa1bUV2bjynnkQO3OwIfYtxmyYVYbK1l7cPFyhrWL8LK?=
 =?us-ascii?Q?HJi61Glk0K4j7vs/MTDebbxLUDxJeR/QGHgFCmNNBlYWAAVpajoZoQSRcD+p?=
 =?us-ascii?Q?sax+AXhqCtAHwuFkI3x7RAXYrV9pFrOJLPGVWkXpeATh7LU73w4cI7jWAEoQ?=
 =?us-ascii?Q?rzXRUa8FcdPg9ah2jx2TKghUBk5rUblWEXd/3JiTjzmDhqcB7A74ybFfpeqU?=
 =?us-ascii?Q?+S/5y6gI6FVt4uoUscBOoUslqpQn2IUlG03NEQckRPRy2eu6G5LDFdD/t9vj?=
 =?us-ascii?Q?gf5OVjZzYZoLQ6Gi9I0tYWGradyQ6mOhi/ClX7We9u9jcy9fq9B0X37msAPZ?=
 =?us-ascii?Q?LTv4uDBq4Zu3n/vOqeM6gab9VDgl73NLwq8+Gr1ir6DJeftOsUsl45lHd0WL?=
 =?us-ascii?Q?ASbNgOj0RtcXcTURJxjwB9X7wr8XW5AUpVG1kFvH66Ev925+l4+R3pABchGB?=
 =?us-ascii?Q?k4WsTjDba/84nmst+umLAbwTzVILcp0Ndm+qp9syqEhVKQhoQEfW4QWAMvai?=
 =?us-ascii?Q?B8sKbd4HfWpTEaDtBA4HbWt0qT+CKmk18TVmgsozd/cuNToSWdcwPWwp7C/G?=
 =?us-ascii?Q?w2GhVPn/nWLme28B7A4jZy9g0L1xcFirjufBjspFaeODlQSTDHEqfAQwsu2U?=
 =?us-ascii?Q?8MyMpD0IsTpfqZU3cYvvN+AnQQkE6MWOOIIIAUQ7V/t5agP7GBRwTeoMYeKj?=
 =?us-ascii?Q?j2Wf9aRpSDA6lcFlrMXN0C2ZPVZUXE8YGkZfOzwLMU2+T1adBGf/ndK5i7Sf?=
 =?us-ascii?Q?wK6oEjZ6zM8cS55cll3Nw6ElCBEQYbhB9ctHx+IEnwLbETY7rlfoEQakliWF?=
 =?us-ascii?Q?FmX7493dEUptEcnwNWo9/7aO8NI7O1kq9oIpSnDNxkdLGisESRkAboYqZDH+?=
 =?us-ascii?Q?I7SDRVY4w1ivM/AfWxZggt8LdDmThXFu24dC21UIwRggi1SE1qGM9STsqNdr?=
 =?us-ascii?Q?Ao17q3g3Jy9/U8p1+YUaST1cstzKKxRXsJJZhOE4y0/Yo36vHprRlm2Pfhn4?=
 =?us-ascii?Q?n0qVhiKIUY/TRNN3Pw08lNfFdsyH10ReYCKOB7cAKZnsV5oj1f6QLI4HG5dW?=
 =?us-ascii?Q?Ncigs6sVGZEQoUV4hCEESDgLDDCV5glyXGYuZGJYU/SjJyNuBfaLSlVVnWmV?=
 =?us-ascii?Q?gAqfwX8ciZoqKp1/8fSVLsTPmsUELOyOlZ3lUDCpbnA6Idb6gM5rAcZwj4H4?=
 =?us-ascii?Q?mf5q17gDFO2fifj7SlUQdFUUAt7GL+owAw989c8KL9VTWbY7x1e937HdCIfX?=
 =?us-ascii?Q?xV1+/TJqDBZcRr3BLfV5gl0tVLZDdBR1dwGvsk5B8XRDgckj/kCvxfvt0hXz?=
 =?us-ascii?Q?usZ46MizXM3FC7884awsFMxxFmCAnr7Tu0kkYE0/MalGnsMx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e768fc77-673b-47d5-4360-08de8bd7c490
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 08:06:36.5048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjEdCXcPGsVWsssUVuSUNW203p2qfLapEM6cxAU6zZAX5K9sDCbO4oigcyW2Q0jkcuMqKFFeandeUPEuE+drHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Friday, March 27, 2026 9:04 AM
To: amd-gfx@lists.freedesktop.org; Joshi, Mukul <Mukul.Joshi@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdkfd: Switch to dev_* printk stuff in kfd_int_proces=
s_v12_1.c

dev_* printk stuff is multi-GPU friendly.

Use dev_warn_ratelimited() for print_sq_intr_info_error() which is consiste=
nt with previous IPs.

Use dev_dbg_ratelimited() for irrelevant node interrupt print to avoid too =
much noise.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../drm/amd/amdkfd/kfd_int_process_v12_1.c    | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v12_1.c
index 47947b94926b..0da7e1db55c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -144,9 +144,10 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_CTXID0_DOORBELL_ID(ctxid0)         ((ctxid0) & \
                                KFD_CTXID0_DOORBELL_ID_MASK)

-static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context=
_id1)
+static void print_sq_intr_info_auto(struct kfd_node *dev, uint32_t
+context_id0, uint32_t context_id1)
 {
-       pr_debug_ratelimited(
+       dev_dbg_ratelimited(
+               dev->adev->dev,
                "sq_intr: auto, ttrace %d, wlt %d, ttrace_buf0_full %d, ttr=
ace_buf1_full %d ttrace_utc_err %d\n",
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, T=
HREAD_TRACE),
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, W=
LT), @@ -155,9 +156,10 @@ static void print_sq_intr_info_auto(uint32_t cont=
ext_id0, uint32_t context_id1)
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, T=
HREAD_TRACE_UTC_ERROR));  }

-static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context=
_id1)
+static void print_sq_intr_info_inst(struct kfd_node *dev, uint32_t
+context_id0, uint32_t context_id1)
 {
-       pr_debug_ratelimited(
+       dev_dbg_ratelimited(
+               dev->adev->dev,
                "sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, si=
md_id %d, wgp_id %d\n",
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, D=
ATA),
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, S=
A_ID), @@ -167,9 +169,10 @@ static void print_sq_intr_info_inst(uint32_t co=
ntext_id0, uint32_t context_id1)
                REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, W=
GP_ID));  }

-static void print_sq_intr_info_error(uint32_t context_id0, uint32_t contex=
t_id1)
+static void print_sq_intr_info_error(struct kfd_node *dev, uint32_t
+context_id0, uint32_t context_id1)
 {
-       pr_debug_ratelimited(
+       dev_warn_ratelimited(
+               dev->adev->dev,
                "sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wa=
ve_id %d, simd_id %d, wgp_id %d\n",
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
DETAIL),
                REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, =
TYPE), @@ -246,7 +249,8 @@ static bool event_interrupt_isr_v12_1(struct kfd=
_node *node,
        vmid =3D SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);

        if (!kfd_irq_is_from_node(node, node_id, vmid)) {
-               pr_debug("Interrupt not for Node, node_id: %d, vmid: %d\n",=
 node_id, vmid);
+               dev_dbg_ratelimited(node->adev->dev,
+                       "Interrupt not for Node, node_id: %d, vmid: %d\n", =
node_id, vmid);
                return false;
        }

@@ -266,9 +270,9 @@ static bool event_interrupt_isr_v12_1(struct kfd_node *=
node,
            (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
                return false;

-       pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw da=
ta:\n",
+       dev_dbg(node->adev->dev, "client id 0x%x, source id %d, vmid %d, pa=
sid
+0x%x. raw data:\n",
                 client_id, source_id, vmid, pasid);
-       pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+       dev_dbg(node->adev->dev, "%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n=
",
                 data[0], data[1], data[2], data[3],
                 data[4], data[5], data[6], data[7]);

@@ -361,10 +365,10 @@ static void event_interrupt_wq_v12_1(struct kfd_node =
*node,
                                        SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCO=
DING);
                        switch (sq_int_enc) {
                        case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-                               print_sq_intr_info_auto(context_id0, contex=
t_id1);
+                               print_sq_intr_info_auto(node, context_id0, =
context_id1);
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_INST:
-                               print_sq_intr_info_inst(context_id0, contex=
t_id1);
+                               print_sq_intr_info_inst(node, context_id0, =
context_id1);
                                sq_int_priv =3D REG_GET_FIELD(context_id0,
                                                SQ_INTERRUPT_WORD_WAVE_CTXI=
D0, PRIV);
                                if (sq_int_priv && (kfd_set_dbg_ev_from_int=
errupt(node, pasid, @@ -374,7 +378,7 @@ static void event_interrupt_wq_v12_=
1(struct kfd_node *node,
                                        return;
                                break;
                        case SQ_INTERRUPT_WORD_ENCODING_ERROR:
-                               print_sq_intr_info_error(context_id0, conte=
xt_id1);
+                               print_sq_intr_info_error(node, context_id0,=
 context_id1);
                                sq_int_errtype =3D REG_GET_FIELD(context_id=
0,
                                                SQ_INTERRUPT_WORD_ERROR_CTX=
ID0, TYPE);
                                if (sq_int_errtype !=3D SQ_INTERRUPT_ERROR_=
TYPE_ILLEGAL_INST &&
--
2.34.1

