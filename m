Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68711CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5B110E086;
	Fri, 19 Jun 2026 13:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqUTso0M";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D0C10E086
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUN9VLxw1kxUMLlU603arGAePBhITe/i3mMejB9VCWBdbFoFuT2kHR9GMwGr8zOm7N5VT+oGKREWic0ch7ZqjzWCGK5xyojCznNh7JtccmvJ9UIXzpOenfeZoVKxc4Rs+SKtGS8c0sH21c5nZXzq/X2HgLHIgsrBvRuBWqEvx5aQ9DWJAfIGiAG+6iMsVYIkj0lPRKO9lPKQrQgRIUILgPk3o7JTfwujybZwaSMIdUcTbUZi5XXZmmCQOXVr0sFH5klwlaqmr/BgJeU6qMv28aMKUzUUZCwxlvlmjX50ebRdWJMfVij6H9PoNo7bjGoSiiMf8t6Uq8UPyyr3EayQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHWNDt8WGwD1e2T+5Lg97K67eOKJBk/oYcb/dIPOKHY=;
 b=ifOSaqVXIrXT/k8iGCag6Y2F+pgHRg0L/wXV6+DsWlPRh35UElGufwLR1k5nlB2dnWP0cDPnDmIHEuPyiWiyRh5JerigchuDAAWliBlNE6s5UmKJ5vd4beGYB2pvYM0ydiYkwafBcSJwPXGMI2HYLMap6ucAiqdmgoQIFgjLzs8aUtLlNhPLviIVADQ/Woqr5SqwZbzAX29P8+s1y+gdwJzTSVsOZln8RZEpye5GIRnldG5P7kjIb+5t06LRACOI01fWSpVIJhrPmY8JQd7CT/SBG2+Y5ivvGoucSOWJh7fIoBZdtNPM4gdThc/fbIp1khaXVpqHBn28UdwV2yYt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHWNDt8WGwD1e2T+5Lg97K67eOKJBk/oYcb/dIPOKHY=;
 b=eqUTso0MDag/ko5V2yqZv5SGjzcelfAoEq0ISYk4179jA+yc9KJdsBQt60iIz0RP/598wJnsQXSAMWBho3smHg20l1wgPxVlzEPmG1kQ9cuOhvQZSAAqF4nMoCgSPVSbCZXgLyxreHmurUyPaG4LXo0rAq0wn+uLKGYAoInpCPU=
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:18:42 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::86) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 13:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:18:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:18:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>, <Harish.Kasiviswanathan@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: bounds check ATOM IIO table parsing
Date: Fri, 19 Jun 2026 18:47:17 +0530
Message-ID: <20260619131821.1173080-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8e11e1-e2dc-4f97-8b18-08dece054824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: HEBZin4QjFf5JW1YZYu1cuwF/Ce+KxzhTYXAANuRV/RTIyurElMhrCoVnSU8ynNIA6eMhlnVsEN3uEzMA5bYAafhoiHhnbr3U3NE9x8U5S+H/DwtQsvZWBZbRpt7rVQQbRQyobmSSCUptaE2lVPefA/g81acimkrhwHpgXm+PnUl2okQd1EUR2kh65+1+2s7Jm709O++heY1mL39rmtGmFnMTdq2V8KB5hlIebsereNXNc0s/yKn3GZSOO18UO9S/aD1bkWTxZ6DGYc3+AHJbAoqbGNKn6fPq/zL/ZsYavjyv+Rcwp3aLHcw6T99bVrat4Xcptz/yYFRYemTv6LdYX8Nygp1O5hZz++kSRa5s3F6vqwvjrMzo7sViaj7WYZnXwFSg903M01lpgbh+rD9qWQKoBBBamoZc4V3nQWeNSln87HTkWo/Eft1NN7VBpPvS/F+A20vP7Btll2CwfnN9GfcyRUVDkWWJA/Ni47V8wd/CKdNo/1XmSvM7GkIvdwOzZftT67SfH0klP98/5xeXh287hXUqzud5pY/d0HdzoWJJExJMkwLq7GHALEcRqkCGTmRFYZgJ0RaGtcvLcDcZptVZ0J727I1+svGLV4062c2qwfei+tmVolFAMJ2GrlkUSyyBXzgTuSRFzvYikNB+wwbKxfsw6EZ1I63/Ey129E/9z1hG+5n3prVJfxyar68NSLZICHVoCQN1oqwORFaRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aT+7918WnlLZbh6ECdwFuJYduJLNfhL7IYvAKNGDk4y9qm9OXot25B6A5YXmLGkKvz7oQKFrSS5R3U3MEpWmzI9dn1F4nVk7Zu6KpeOYslOTVE04oTSZRb+ppI6iaDLpPer8SyY3YVZ1VuElcjm5BWUjN7p7oOEVtXq01YVSdeR0M4SLupPdj8oNI+WeoCI5qIVBQKo3FWvcgreG10FqY6iMYqwb6/d/g51X3x+OB69vR4ttssMGjMyMatiTXCS8rA2H6fS4EoA8ZCxguy4ISUN+GibNGqmmfUX2HJDKniyZSoyyURBDjdIC4K3Mh1i1Hib0pY0ziWr5wlWxjwhklkCuGBovo0qCIUf6IEtaOfcaai1j8CqCrmkiGV4aHIAjYrJTLDoKDucTKs3Px3OY9wfwFDTG8MUYLzwPFqdipMmUw1S2+tPghhEysxBye/yp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:18:41.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8e11e1-e2dc-4f97-8b18-08dece054824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

atom_index_iio() parsed the IIO bytecode without bounds checks, allowing
out-of-bounds reads on a malformed VBIOS. Pass the BIOS size into
amdgpu_atom_parse() and bound the parse loops by it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2: check bios size also before indexing offset (Asad)

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c            | 25 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/atom.h            |  3 ++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index ca65e6ebdb25..a0c740bce310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1923,7 +1923,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	atom_card_info->pll_read = cail_pll_read;
 	atom_card_info->pll_write = cail_pll_write;
 
-	adev->mode_info.atom_context = amdgpu_atom_parse(atom_card_info, adev->bios);
+	adev->mode_info.atom_context = amdgpu_atom_parse(atom_card_info, adev->bios, adev->bios_size);
 	if (!adev->mode_info.atom_context) {
 		amdgpu_atombios_fini(adev);
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index a40ce7555f28..0d5be1795972 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1327,11 +1327,25 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 	ctx->iio = kzalloc(2 * 256, GFP_KERNEL);
 	if (!ctx->iio)
 		return;
-	while (CU8(base) == ATOM_IIO_START) {
-		ctx->iio[CU8(base + 1)] = base + 2;
+	while (base + 1 < ctx->bios_size && CU8(base) == ATOM_IIO_START) {
+		uint8_t index = CU8(base + 1);
+		int start = base + 2;
 		base += 2;
-		while (CU8(base) != ATOM_IIO_END)
-			base += atom_iio_len[CU8(base)];
+		while (base < ctx->bios_size && CU8(base) != ATOM_IIO_END) {
+			uint8_t op = CU8(base);
+
+			/*
+			 * Unknown opcode: its length is unknown so the byte
+			 * stream cannot be resynced reliably.
+			 */
+			if (op >= ARRAY_SIZE(atom_iio_len))
+				return;
+			base += atom_iio_len[op];
+		}
+		if (base >= ctx->bios_size)
+			return;
+		/* Only index well-formed methods, others stay 0 */
+		ctx->iio[index] = start;
 		base += 3;
 	}
 }
@@ -1553,7 +1567,7 @@ static inline void atom_print_vbios_info(struct atom_context *ctx)
 		drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);
 }
 
-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios, uint32_t bios_size)
 {
 	int base;
 	struct atom_context *ctx =
@@ -1567,6 +1581,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 
 	ctx->card = card;
 	ctx->bios = bios;
+	ctx->bios_size = bios_size;
 
 	if (CU16(0) != ATOM_BIOS_MAGIC) {
 		pr_info("Invalid BIOS magic\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index bb3d9eb7eb6b..4687c019cbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -133,6 +133,7 @@ struct atom_context {
 	struct card_info *card;
 	struct mutex mutex;
 	void *bios;
+	uint32_t bios_size;
 	uint32_t cmd_table, data_table;
 	uint16_t *iio;
 
@@ -160,7 +161,7 @@ struct atom_context {
 
 extern int amdgpu_atom_debug;
 
-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios);
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios, uint32_t bios_size);
 int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size);
 int amdgpu_atom_asic_init(struct atom_context *ctx);
 void amdgpu_atom_destroy(struct atom_context *ctx);
-- 
2.49.0

