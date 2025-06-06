Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E397AC5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF91B10EAD5;
	Fri,  6 Jun 2025 14:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37xrIUoh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD38E10EAAE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 13:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYOungtNGPOOvsRODsXc5sMzNTK+hTatnj6kLV1oLQAHIFxvCC7ej03ziV1vIjhbDaNlPgqXsXnhiyQSdB0TOvMjIT25u/YCdfGYDYD3t6EPM/Himt4eSDPx4uXHFlVwOZis5lqd6vjqyii9TbU8HvXIOyvVskmRpCbj4ntUVS9E9jA1gQgVCIKzbN8u4WoWEmWzN89CD5J6q5CM3xf/bgM0KXYA52Nf+Lv1o8sy/o+fTtzWr7Zbwinx8X+xZcQWYSt+wE9DKnu545r7y2OxvwrOabvPJF1CL0qnZ1LqwZDgRfLuGq+ij0Er0hk3zOQ/osOEEXHuou5qO+3hqP61tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUR1BwtdT2/ezeykbTsN5u/ggD+zZsGL/MSSCLd+eOY=;
 b=ZFAOofuF089l5lAJ+5XXB+j0r5/1m20vMThKm2VP9oz7N/vSM/WucZkXC39WO5ue6JAmmbWfEfGp88LFxCUTzPqlA3PBCHvbeZnOrpWhsvmlUi/clngUkI3t+2BjeUD/fMWjFEnQJ1CbbwqqEdAmuCPB1nYZRBpr96V8c1pX+B1dnSQVCd/3qrt6iQp+gIFZVaWViEN17n2yC4H0UqZSvve1la+ycgjZ5ccJ1rlaAKS6df/84EFacT1owsqThr4hE/9Fu3uve2b7Jzh1BnGPyBBtnBRLQrFpbkJHALXjFwJZsRFoN4R2suoeCRaV/Krjz/FXTqYD+sxAGG/19vX0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUR1BwtdT2/ezeykbTsN5u/ggD+zZsGL/MSSCLd+eOY=;
 b=37xrIUohFeSWolQdOErUJX3+FwCsRzxrExP7kIv86Mc1yxtQ1t2zq3/CTweCzdii1ZrqHBmRmmipbgUgd6XHSeHEusysdQaPbNVWb/X9NNk/W9aUtW6EEeYaoQKe21Uenkv0LTK8ZGF2DJv0nAlisqTNUoNAvGS7HPTCB8plT8k=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 6 Jun
 2025 13:46:42 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 13:46:42 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack"
 <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
Subject: R[PATCH 1/2] drm/amdgpu: Add kicker device detection
Thread-Topic: R[PATCH 1/2] drm/amdgpu: Add kicker device detection
Thread-Index: AQHb1ulvnjcYv6eDoEKZAohDK/aXaQ==
Date: Fri, 6 Jun 2025 13:46:42 +0000
Message-ID: <SN7PR12MB6932CADBC608DE65588E6AD0E96EA@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20250606133229.411322-1-Frank.Min@amd.com>
In-Reply-To: <20250606133229.411322-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1b679d5b-3df3-4bd7-92ce-0e6a457b4a79;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-06T13:38:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 90efc04f-35d3-43c2-7c85-08dda50091e2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eHr3wH/Ixhxj4UCaPL15VpAm07I7+06pwPPtlSI6HC46UMf6RA4AuVpM/mGb?=
 =?us-ascii?Q?Z61QUAG5XeRjt1/XxwODHsyNG72G2DDk5lUrPuiBEStXvrPdoR5wT4oGoja3?=
 =?us-ascii?Q?GTSTQ/X565cymOZohYqs/HSIkxMg7K22j5+MnJN7c1jTj8wKc3pjT8K28xtE?=
 =?us-ascii?Q?dpxcglr2N8ElvaZM4Ele/L1DA+J1EIyIVLhrBZqJFI/X9bBbG9pYIX85VeFg?=
 =?us-ascii?Q?25drHPpvzK53wi7Dg/Iuv6nG8FUFmygow15SF8Zb+3umUyEL5R8lMDVckGQW?=
 =?us-ascii?Q?v4GlwGlzlKK9CoeGMyqvQiCHbT97m9+yRUMSHwHT/d3ssHPmCz5CetpRDSc8?=
 =?us-ascii?Q?tIu9UKVShSKQbuK7ebw8eN9xJs0dsgPDB/D+vbIZE3c4bDeRZOV3BiLvzpDW?=
 =?us-ascii?Q?UcTBdoXOEkfsaMC00d+yiRVlfWZQIa6wTxyPYawMHQTvdteJ18cOMQD5UfJc?=
 =?us-ascii?Q?7GcCmgTlgjsCQqwSliLNPUf8xgClq0zkMvEt6l028GFMH3sXu5U53TKhGW8R?=
 =?us-ascii?Q?S/7j89//iRT0NORzB7B7sfdy2VddwlyAtWa9XHvHMojOtuIrOqQ6xCXuUNx0?=
 =?us-ascii?Q?QFJm8d++RfRlvMGXAnau4LqN6L0SNpuRYS9DlVNUMBqHxwXa3/vnG1Eg8nHw?=
 =?us-ascii?Q?7NRmxB8APmrxbbCTQvjs+mZFuHpRffTLW7+ddq0wHC2Ye901FivLCLA6/+Th?=
 =?us-ascii?Q?kzDQnGBqIz53cw8mWH1mAqd5K3ApHYTETI+gg2U4iSIWVnylVFCScypT5fex?=
 =?us-ascii?Q?BipbkDknddN/Ipu7QF7AO24u8Ewqvf6F03+BDV8gMn7QmmjhV9Cp4UeWceGw?=
 =?us-ascii?Q?tkUEdkFHcAEOwLU8Fsfh/SXKDBJ7dg8V5sH/S6VNGvt0HgTyn0MsjwwRZwvq?=
 =?us-ascii?Q?Tft2ddSIuRi0zJJUVneDM4jSpVvs3UZHuDe6G8GOXRrR3MizNig1ypV1jpYS?=
 =?us-ascii?Q?xZ4g2hBlWCA2/boO6TnSwPrrPNYHEnwAT+R8eu4/4FE5w9kaSTDe18iWsI5O?=
 =?us-ascii?Q?WCFzd+gQ5WKZa5QI6d9nHLEVHHkgQ9UhVZNSMLxAlEr0BoDsazOHtXXNklUj?=
 =?us-ascii?Q?xN1TX3Z8EV1aPADd3jdXxSxx4GB7T8bv44LiAEX8q4MPaRLREW84dsViAYWm?=
 =?us-ascii?Q?Ch6iJRaPFl5sARNDAVdAQda9eRid15FR8SqLS7M+MF0KIrdl80mPAsMxcw8e?=
 =?us-ascii?Q?kt1pLdbNJE6VXmAxu9S4QvprALpAnX3uPKqsQd46PihHsMQgjrmSxSOZn4SR?=
 =?us-ascii?Q?Cb6Y4TTkhY4Tm+Miy4ZXcl3dEaQgjryVJwMH10UfPjGyRxOZfL4iluTI4LxL?=
 =?us-ascii?Q?fp/16AjfWDBorwv0O7oRcHNxXkmAFWHKOhKMbLRxYWJgtm4hYrdKU3E6JZOQ?=
 =?us-ascii?Q?BF+xRvYjzxbPUKlXhWOEoHrZItJbc4YXHtENoZZWi/Gbv38PejUZoEo2yzxc?=
 =?us-ascii?Q?H0GUFeLw+oRsmlxhcEa6CSgIVyXd6bGTfzk/RQubq6Wor519GQNro8edV406?=
 =?us-ascii?Q?Xau9GHW+EOByLzhrZY3Nf43lWZrGbvewP/SR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6vbdEYfB4Ihyjtuu3os1YyijTQ8Hfmz/xu8fQmLcMQFqEvq1xmvpLuWZnrh?=
 =?us-ascii?Q?tDNMuiw3kLQG2GT7N8zsEJPwTy3TwxkKHpVnm25ET7pHCB2nbkZ0tZY7ORKB?=
 =?us-ascii?Q?dB8eGWbfUdmHPDk8cChLczfHyJXWj969IFLTg5/KvbXXdRA7KK2ECEo78RYV?=
 =?us-ascii?Q?UkpKEXcP0M3VUmFFW4IsPCT6KsdpgILUtcLF8GlOfASdZ1+yyQDMfJI8Foe6?=
 =?us-ascii?Q?w6aIbO8viwJtSxv0W/q5IFXeft6D/6mBwFPlDdW4zNSLMTd9+bBycmBcD5yv?=
 =?us-ascii?Q?LJcSz0UBhdYvzxeee0XVOxBbXkL468YK1wrey168AR8WBcwdMD/GGSEnn5gS?=
 =?us-ascii?Q?xa54rhOPtHWSDCp+ODiGML3ZpcYuUpzHr0oqXHz+QVuMi+Ey10GHg1c2iSCM?=
 =?us-ascii?Q?IY7uef8Rh+LtDLbtNaBP7cN2bXKk9RDhJDbiq3FQRxBfbZNwR1eI+HB/7JxC?=
 =?us-ascii?Q?mdTe/hzJHM5/b1UVdNKpR6Sp4GN/XxxAQq2O2H95x0t+Wv0Le5TCcP2moM0V?=
 =?us-ascii?Q?/quzBtPsq7j+wW9RpRv94RykN/lEMFjjjf2jej6rzAllc3N6Tqd3NyX0JgKl?=
 =?us-ascii?Q?12JN4cC5kXY8upmiKVkIrYYqV7vxtC0X92w+z4M+iDWtBB4ZusVavIGUn64k?=
 =?us-ascii?Q?O7bE86fW6dTzCn/jPohIYYxAZiOW0IfxDWR+l3Ad+uapEatxOqg4IVmPAmrW?=
 =?us-ascii?Q?9g7RbP+/aJknu4N/44604cbAh45FNwc+oqPcvtJEUxgLb42IJvrTjIc+Z828?=
 =?us-ascii?Q?oG9yYcPsyl4yFtQYUhLLD6DjmhS8tAgY54Gnk6DQQs7Tfi1B5HhZkXfetHw+?=
 =?us-ascii?Q?moeHtApt7/IPKXgJnKC0sM85YXw40SKD/2TXJHOZP3BLyX30xphT60+QA91i?=
 =?us-ascii?Q?drn6hIH3YKE3fzUHVZgGWQBRaAPr8jGKA/P9mlGxIZI31f4L7Uc1zkSupaCr?=
 =?us-ascii?Q?sxzQNVEn1YdpZWSRi8AMPiVpBVI6zjbQtCJFGyQCKKVS3P/4v+7xiqEzuJEg?=
 =?us-ascii?Q?UYCVNwVUFTjrPB9uexk/7V462av6FtldmsxzXgw0MD3wUQwz5AqpC+NAFoAg?=
 =?us-ascii?Q?YNnF8XBxuwI92ugW54SOU9hbWJsvJaZTonjMUKjTtm9Vi/QzyFDZr4m3WQFG?=
 =?us-ascii?Q?9WhjLL3TxlEXUWAphnb3W//CGCXjcL8OC6oUjHgqUpUNRInvkW6ivhII1XW/?=
 =?us-ascii?Q?/TLxxniYh/vXXhQfHvfZbxHLpJYRO4Bh79lOyy7UNC1tIuypliElQRaS8EFk?=
 =?us-ascii?Q?MAmXXsuNEFU9PJPyPXQ1CcF3TL6NHQPYpHNFAUW8dYl9xbUN7eo5jGpQc9Lj?=
 =?us-ascii?Q?a745o3oOFsfeJV3od3v1Xl1qfJIawcWuk1ps7exQ2I0oOPMdOy5YRJinNX2D?=
 =?us-ascii?Q?Qi6x0WxoTHtQZqmvJnAvDzuS02FYWhkZDB7uZj4hnS/m31dPUUEeesIaUH+M?=
 =?us-ascii?Q?/kCXhUX9h388/kzu8a/KHZg5rUCX6St04KmBqCufO9iEJ6dAvun9wfhMytyh?=
 =?us-ascii?Q?kQ3KvYmIqoJe7dKG82nSTMLIyQJPpvCZpztDRfVwtq1ncLk5dwl/UKR8xJzZ?=
 =?us-ascii?Q?8rDMUiq3321yUpdpko8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90efc04f-35d3-43c2-7c85-08dda50091e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 13:46:42.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UQTCsx5lId+FoL82JRhdgiqPlw7D4ry2OgNv0R1d7y2rXdryLSxbTw8JiqWxmb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Mailman-Approved-At: Fri, 06 Jun 2025 14:59:13 +0000
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

From: Frank Min <Frank.Min@amd.com>

1. add kicker device list
2. add kicker device checking helper function

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 17 +++++++++++++++++  drivers/=
gpu/drm/amd/amdgpu/amdgpu_ucode.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 2505c46a9c3d..eaddc441c51a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -30,6 +30,10 @@

 #define AMDGPU_UCODE_NAME_MAX          (128)

+static const struct kicker_device kicker_device_list[] =3D {
+       {0x744B, 0x00},
+};
+
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_hea=
der *hdr)  {
        DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes)); @@ -13=
87,6 +1391,19 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgp=
u_device *adev, int bl
        return NULL;
 }

+bool amdgpu_is_kicker_fw(struct amdgpu_device *adev) {
+       int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(kicker_device_list); i++) {
+               if (adev->pdev->device =3D=3D kicker_device_list[i].device =
&&
+                       adev->pdev->revision =3D=3D kicker_device_list[i].r=
evision)
+               return true;
+       }
+
+       return false;
+}
+
 void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_=
type, char *ucode_prefix, int len)  {
        int maj, min, rev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 9e89c3487be5..6349aad6da35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -605,6 +605,11 @@ struct amdgpu_firmware {
        uint32_t pldm_version;
 };

+struct kicker_device{
+       unsigned short device;
+       u8 revision;
+};
+
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr); =
 void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);=
  void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)=
; @@ -632,5 +637,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev=
, int load_type);  const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode=
_id);

 void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_=
type, char *ucode_prefix, int len);
+bool amdgpu_is_kicker_fw(struct amdgpu_device *adev);

 #endif
--
2.43.0

