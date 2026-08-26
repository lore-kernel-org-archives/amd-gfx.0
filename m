Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C37C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 19:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0C910EDB9;
	Wed, 26 Aug 2026 19:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gx5DEwyv";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6F110EDB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 19:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/zF46lnwaNl2vx4m1vKBms+ADrjQzqGSNZzoxtm7BpUuFu+3S1bGxIon4IEpXag5+jo9nyAo3peX21GAdvPOhOD6JoUYuQdufLCVN8rndT8wU1aPfWBVEIIRtzBx2yPLKc+/Zgri/AFBXcLjh4AXkuEMUkizxQN//n6rAS5Fli50AvnN0r/BKHlaP6vLw3p0exvo9eFFBV8eACc98Y3nUs4YDchJ8fSfX/uTL0b3ow6d2p4+PjM8V0Smtw4VUTKpmLqJ8p9YLDzBS6PRCxtrBIGmImsVvOAUpHBuVcuVOdVE9cHZf9GYLbkh8nB4BMYcAt7H/18ZCQBymNxPv6kGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btHiMQunFzVOMM+38XAgRnL9gCgKH3GBy7maHb0EZI4=;
 b=COAYsTzn0TN4cVLIqH3+c54A14/oqIR94Juhfp0P8aJgRBuqVyXdGHwwWZ0uAq10EoW2Ajw8rw4JcuX/cFCU7YCtFqnitymKW2drmCwfz06M5oQO0ojNfJ7lRUpKJO4FlVNgMEVc7NxsziG9WlK2t/BA9SzvSBDQ7E03VNkzHPu7dLZ5FRBqu3Uj4wdeZXomQ/R1aOAQrlDEVbGtYiRd7/f8jOV+Yql+uXFnfiafsxcvOLd0VY8zx3i7J+hL97ZZHAQv9zz6dZA4AS2AYcueL8rIkqzi2FMXjN3CJHEIatWeAxHh/86jbuzfJoYjx03WtjetRwOobJxiv8ADVE36fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btHiMQunFzVOMM+38XAgRnL9gCgKH3GBy7maHb0EZI4=;
 b=gx5DEwyve8mDafq5wrcCpr0KHSm2vdDWLjUpSwGnDCZO/CLrQWOBInEpK5x0F9ysPBHtM3pB4lq111b9qSLlgkTTzNQCJ9q5f9J1L5k/PGnXnHwzRBEoIbiSGaRtTWkmBo1hfC6DuN/MgohqK5MhnWmeOuu1VFk39dHyQbtiBOo=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 19:32:48 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::59) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 19:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 19:32:47 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 14:32:45 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add gfx12 (navi4x) mes_dbgext support
Date: Wed, 26 Aug 2026 15:32:29 -0400
Message-ID: <20260826193229.916571-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1908b90c-855a-4e9c-dd39-08df03a8cf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|5023799004|11063799006|6133799003|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: RZVqyHXuESLGmziacD+p6q8DFwWcmlCQ7ijMiZkkQERWLYxWTvN2nBc2DOskxWEXw53U/UVaLX6gQl1DFFmsp7H7tDEt89hbLn1JyME0CiQv44nrga/4LvzUSEM+X8RXaludUn9jo6eeCDr0dcnI13M0CFCpKf54XCGAnk0VIxSVha+0+8qpSZH5zwuVDkd9D5fRaQXf0D1JkgZhdJ+h4lxg/VblcjICfnWHpwJO+qUxGEQ1fK0yqDZx8NII0OCMtiiM+dhKmgMX+OtuSfVF6oj4GE7tDhrpsNu1jbD/8s1FzMAJb3mOaylOYtHgjPa6rknXnpPMoKiN1glN4nqoWUnS8RrI0mTSFM2KFfzBVo/KWv5DMxBD56mMMFT1EAvKsOJ8pz+vHMPh68TzhFQENIYi4TVGZ5UyHgxOGcorIqkneiwd1YdSjWhn6VGWCbRw5Tv3q2jCt40kluFmdjUI5PvKwVubCp2nvSXqbObjGfT2pgRCLihLZl+PJ0h78V6WtToSkPvcPQd3zPJNao3w26y4v/9BbgSpRd8sBfcASfuvv4YP/1ZkZWxzK3mfN65uF+MCHckzCGrDzWYzm5+6ZMy9us+ilWZWHzL4qdIETiKTZHC7wvl/b1ynwl89YUJXMoqVvu9XooI7PBTPv721TKJmqNTuGPZa4haHkSH8qr8Xj7WQiHUXifitgYYn+ZBXTHDQ7GWI3UxfaMAmaef8EA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(5023799004)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cr9Gr+J7FH7EQL5a9S9z3+iWflv7blK1I62WcDOVSuI9gQzMpx0nY5XHs5G/eNTIFFaRWZ6Xwd/f/TTbtwPDxUk0GSEBLd7OlS7Upit/pdg+H2SFgbQqjXLMNcs8KuSMD3sK1/SbJtiyg9Ic1PZ1gNedPlqxHIepTElI5GxHN1dTv/6Prn1Ub02Mpb3mTB8J+OoPPPZSsfijxRb3xhBUKBRz/ENefRyLEr/2d2ztyeox4iDztRdmc12FGu/m/A0XI35ezTAPrPgmnIuPo2pVj/CJ72ErRGGuYl7AOQAfs01cqn7MLIEQnUTT/9I5kN0BTAyiMq1J/1eE6Vz5PEw5O95GZ474/3Ws6EGmks7Tobvd5WcFlWh+fjOQ+DQ1Kn9dlaFnf1oM5vZl6Bu0nNpqhC51T+QB1D6YDVyCZzUcY7vb9lWh6on4fHe7qr/pbdY/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 19:32:47.6227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1908b90c-855a-4e9c-dd39-08df03a8cf48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

Enable the MES debug-extension log for gfx12. gfx12 routes mes_dbgext
through the mes_aux component, which uses a zone-partitioned buffer
layout (8-byte item headers, 24-bit length, per-zone rptr/wptr) instead
of the gfx11 flat circular buffer, so add a zoned parser selected via
mes->dbgext_zoned and translate the setup options to the mes_aux format.

Wire up mes_v12_0 (misc-op setup, dbgext IRQ enable, hw_init/hw_fini
start/stop) and the gfx_v12_0 EOP interrupt path, and add the required
mes_v12 API definitions.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 219 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  18 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  54 +++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  17 ++
 5 files changed, 305 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 01544c4f10e2..e05fade51e98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1302,6 +1302,55 @@ struct mes_dbgext_buf_header {
 	u32 header_size;
 };
 
+/*
+ * gfx12 (Navi4x) MES firmware routes mes_dbgext through the shared "mes_aux"
+ * component, which uses a different, zone-partitioned buffer layout:
+ *
+ *   offset 0: struct { u32 zone_count; struct {u32 offset, length}[zone_count]; }
+ *
+ * Each zone starts (at its byte offset from the buffer base) with a 16-byte
+ * LOG_ZONE_HEADER {rptr, wptr, buffer_size, header_size} whose rptr/wptr are
+ * relative to the zone start and wrap from buffer_size back to header_size.
+ * Every log item begins with an 8-byte header: type, xor-signature, a 24-bit
+ * big-endian length (total item size including the header, in bytes[2..4]),
+ * then level, seq and a reserved byte.  Zone 0 carries human-readable text
+ * (printed to dmesg); other zones carry binary event/interrupt/api records
+ * (types 0x93..0x95) that are not text and are skipped.
+ *
+ * Unlike gfx11, the driver seeds only the total buffer size in the first dword;
+ * the firmware (mes_aux InitializeLogBuffer) reads it and writes the zone header
+ * in place.
+ */
+#define MES_DBGEXT_Z_ITEM_HDR_SIZE	8
+#define MES_DBGEXT_Z_MAX_ZONES		8
+
+/* Zoned (mes_aux) text log item types. */
+#define MES_DBGEXT_Z_MSG		0x80
+#define MES_DBGEXT_Z_ASSERT		0x81
+#define MES_DBGEXT_Z_HALT		0x82
+
+/*
+ * mes_aux option word (struct MesExtConfig) layout, which differs from the
+ * gfx11 MES_DBGEXT_INIT_DATA: bit0 is host_poll_msg (INVERTED sense - when set,
+ * the firmware does not raise the per-message interrupt), bit1 enables logging,
+ * and bit3 enables an internal write-back cache (left off for prompt delivery).
+ */
+#define MES_DBGEXT_AUX_OPT_HOST_POLL		(1ULL << 0)
+#define MES_DBGEXT_AUX_OPT_ENABLE_MES_LOG	(1ULL << 1)
+#define MES_DBGEXT_AUX_OPT_ENABLE_LOG_CACHE	(1ULL << 3)
+
+struct mes_dbgext_zone_info {
+	u32 offset;
+	u32 length;
+};
+
+struct mes_dbgext_zone_header {
+	u32 rptr;
+	u32 wptr;
+	u32 buffer_size;
+	u32 header_size;
+};
+
 /*
  * Copy @n bytes out of the circular data region starting at byte offset @off,
  * wrapping back to @hdr_size when @buffer_size is reached.
@@ -1445,6 +1494,137 @@ static void mes_dbgext_process_flat(struct amdgpu_device *adev)
 	kfree(item);
 }
 
+/*
+ * Drain a single zone of a zoned (gfx12/mes_aux) buffer.  @zbase points at the
+ * zone start (its LOG_ZONE_HEADER); rptr/wptr are relative to @zbase.  @item is
+ * caller-provided scratch of at least MES_DBGEXT_MAX_ITEM_SIZE + 1 bytes.
+ */
+static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
+				    u8 *item)
+{
+	struct mes_dbgext_zone_header *zh =
+		(struct mes_dbgext_zone_header *)zbase;
+	u32 rptr, wptr, buffer_size, hdr_size;
+
+	buffer_size = READ_ONCE(zh->buffer_size);
+	hdr_size = READ_ONCE(zh->header_size);
+	rptr = READ_ONCE(zh->rptr);
+	wptr = READ_ONCE(zh->wptr);
+
+	/* Nothing to do until the firmware has written a new message. */
+	if (rptr == wptr)
+		return;
+
+	/* See the ordering note in mes_dbgext_process_flat(). */
+	dma_rmb();
+
+	if (hdr_size < sizeof(*zh) || buffer_size <= hdr_size ||
+	    rptr < hdr_size || rptr >= buffer_size ||
+	    wptr < hdr_size || wptr >= buffer_size)
+		return;
+
+	while (rptr != wptr) {
+		u8 hb[MES_DBGEXT_Z_ITEM_HDR_SIZE];
+		enum mes_dbgext_kind kind;
+		bool text = true;
+		u32 type, len;
+
+		mes_dbgext_buf_read(zbase, buffer_size, hdr_size, rptr,
+				    hb, sizeof(hb));
+		type = hb[0];
+		len = ((u32)hb[2] << 16) | ((u32)hb[3] << 8) | hb[4];
+
+		/* sign = xor of all header bytes except the sign byte itself. */
+		if ((u8)(hb[0] ^ hb[2] ^ hb[3] ^ hb[4] ^ hb[5] ^ hb[6]) != hb[1] ||
+		    len <= MES_DBGEXT_Z_ITEM_HDR_SIZE ||
+		    len > MES_DBGEXT_MAX_ITEM_SIZE ||
+		    len > buffer_size - hdr_size) {
+			dev_dbg(adev->dev,
+				"mes_dbgext: bad zoned item @%u (type 0x%x len %u), skipping to %u\n",
+				rptr, type, len, wptr);
+			rptr = wptr;
+			break;
+		}
+
+		switch (type) {
+		case MES_DBGEXT_Z_MSG:
+			kind = MES_DBGEXT_KIND_MSG;
+			break;
+		case MES_DBGEXT_Z_ASSERT:
+			kind = MES_DBGEXT_KIND_ASSERT;
+			break;
+		case MES_DBGEXT_Z_HALT:
+			kind = MES_DBGEXT_KIND_HALT;
+			break;
+		default:
+			/* binary event/interrupt/api record - not for dmesg */
+			text = false;
+			break;
+		}
+
+		if (text) {
+			mes_dbgext_buf_read(zbase, buffer_size, hdr_size, rptr,
+					    item, len);
+			item[len] = '\0';
+			mes_dbgext_print_item(adev, kind,
+					(char *)item + MES_DBGEXT_Z_ITEM_HDR_SIZE);
+		}
+
+		rptr += len;
+		if (rptr >= buffer_size)
+			rptr -= (buffer_size - hdr_size);
+		if (rptr < hdr_size || rptr >= buffer_size) {
+			rptr = wptr;
+			break;
+		}
+	}
+
+	/* See the ordering note in mes_dbgext_process_flat(). */
+	dma_wmb();
+	WRITE_ONCE(zh->rptr, rptr);
+}
+
+static void mes_dbgext_process_zoned(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	u8 *base = mes->dbgext_log_cpu_addr;
+	u32 zone_count, hdr_len, z;
+	u8 *item;
+
+	if (!base)
+		return;
+
+	zone_count = READ_ONCE(*(u32 *)base);
+	if (zone_count == 0 || zone_count > MES_DBGEXT_Z_MAX_ZONES)
+		return;
+
+	hdr_len = sizeof(u32) + zone_count * sizeof(struct mes_dbgext_zone_info);
+	if (hdr_len >= mes->dbgext_log_size)
+		return;
+
+	/* Scratch to linearize a (possibly wrapped) item; +1 for NUL. */
+	item = kmalloc(MES_DBGEXT_MAX_ITEM_SIZE + 1, GFP_KERNEL);
+	if (!item)
+		return;
+
+	for (z = 0; z < zone_count; z++) {
+		struct mes_dbgext_zone_info *zi =
+			(struct mes_dbgext_zone_info *)(base + sizeof(u32)) + z;
+		u32 zoff = READ_ONCE(zi->offset);
+		u32 zlen = READ_ONCE(zi->length);
+
+		/* Skip a bogus zone descriptor rather than the whole buffer. */
+		if (zoff < hdr_len || zoff > mes->dbgext_log_size ||
+		    zlen < sizeof(struct mes_dbgext_zone_header) ||
+		    zlen > mes->dbgext_log_size - zoff)
+			continue;
+
+		mes_dbgext_process_zone(adev, base + zoff, item);
+	}
+
+	kfree(item);
+}
+
 static void mes_dbgext_process_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_mes *mes = &adev->mes;
@@ -1452,7 +1632,10 @@ static void mes_dbgext_process_all(struct amdgpu_device *adev)
 	if (!mes->dbgext_log_cpu_addr)
 		return;
 
-	mes_dbgext_process_flat(adev);
+	if (mes->dbgext_zoned)
+		mes_dbgext_process_zoned(adev);
+	else
+		mes_dbgext_process_flat(adev);
 }
 
 static int amdgpu_mes_dbgext_reader(void *param)
@@ -1568,6 +1751,13 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 		/* Clamp to a sane range (4 KB .. 1 MB). */
 		size = clamp(req_kb, 4U, 1024U);
 		size = ALIGN((u32)size * SZ_1K, PAGE_SIZE);
+		/*
+		 * The gfx12/mes_aux firmware splits the buffer into per-thread
+		 * zones and rejects buffers that are not larger than its 4 KB
+		 * minimum, so give the zoned format at least 8 KB.
+		 */
+		if (mes->dbgext_zoned && size < SZ_8K)
+			size = SZ_8K;
 
 		r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_GTT,
@@ -1595,7 +1785,14 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	 * re-lays its header, and the driver's rptr/wptr must restart clean.
 	 */
 	memset(mes->dbgext_log_cpu_addr, 0, size);
-	{
+	if (mes->dbgext_zoned) {
+		/*
+		 * gfx12/mes_aux: seed only the total buffer size in the first
+		 * dword.  The firmware (InitializeLogBuffer) reads it during
+		 * setup and lays out its own zone-partitioned header in place.
+		 */
+		*(u32 *)mes->dbgext_log_cpu_addr = size;
+	} else {
 		/*
 		 * gfx11: initialize the LOG_BUFF_HEADER the firmware expects: a
 		 * single circular byte stream following the 16-byte header.  The
@@ -1631,10 +1828,19 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	mes->dbgext_use_irq = use_irq;
 
 	/*
-	 * The options word (bit0 = trigger_interrupt_per_new_msg) is passed to
-	 * the firmware verbatim.
+	 * The word passed to the firmware differs by format.  gfx11 takes the
+	 * options verbatim (bit0 = trigger_interrupt_per_new_msg).  The gfx12/
+	 * mes_aux firmware uses a different layout, so translate: enable logging
+	 * (bit1), select interrupt vs polling via host_poll_msg (bit0, inverted
+	 * sense), and leave the write-back cache off for prompt delivery.
 	 */
-	fw_options = mes->dbgext_log_options;
+	if (mes->dbgext_zoned) {
+		fw_options = MES_DBGEXT_AUX_OPT_ENABLE_MES_LOG;
+		if (!use_irq)
+			fw_options |= MES_DBGEXT_AUX_OPT_HOST_POLL;
+	} else {
+		fw_options = mes->dbgext_log_options;
+	}
 
 	/* Enable delivery of the MES host interrupt at the CP (process ctx). */
 	if (use_irq)
@@ -1672,8 +1878,9 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	mes->dbgext_active = true;
 
 	dev_info(adev->dev,
-		 "mes_dbgext enabled: %u KB @ 0x%llx (%s, fw options 0x%llx)\n",
+		 "mes_dbgext enabled: %u KB @ 0x%llx (%s, %s, fw options 0x%llx)\n",
 		 size / SZ_1K, mes->dbgext_log_gpu_addr,
+		 mes->dbgext_zoned ? "zoned" : "flat",
 		 use_irq ? "interrupt" : "polling", fw_options);
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 1cd02101f54e..945d72f0ec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -166,6 +166,9 @@ struct amdgpu_mes {
 	/* armed: FW attached + reader/irq running */
 	bool					dbgext_active;
 
+	/* gfx12 mes_aux zone-partitioned buffer format */
+	bool					dbgext_zoned;
+
 	struct work_struct		dbgext_work;
 	struct task_struct		*dbgext_reader;		/* polling fallback */
 	struct mutex			dbgext_lock;		/* serializes runtime start/stop */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fdfee88e41e3..553c47a99e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4867,6 +4867,24 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	/*
+	 * MES firmware host interrupts - including the mes_dbgext debug-message
+	 * notification - are raised via the RS64 host-interrupt path (the
+	 * firmware triggers the CPC TIME_STAMP assertion).  Although the firmware
+	 * tags the cookie with src_id CP_GENERIC_INT (177), the CP actually
+	 * delivers this to the host IH as a CP EOP (src_id 181) on the MES
+	 * scheduler pipe (me 3) - so it arrives through the normal CP_EOP
+	 * registration, not a CP_GENERIC_INT one.  The gfx12 IH cookie does not
+	 * preserve the MES interrupt type, so when dbgext is active, drain on any
+	 * me3 EOP; draining is a no-op when the log buffer has no new data, and
+	 * returning early keeps it out of the (gfx/compute/userq) fence paths.
+	 */
+	if (adev->mes.dbgext_active &&
+	    ((entry->ring_id & 0x0c) >> 2) == 3) {
+		amdgpu_mes_dbgext_notify(adev, entry->src_data[0]);
+		return 0;
+	}
+
 	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d..ae5dc909e575 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -904,6 +904,13 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
+		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
+				input->setup_mes_dbgext.log_buffer_mc_addr;
+		misc_pkt.dbgext_init_data.u64_all =
+				input->setup_mes_dbgext.log_options;
+		break;
 
 	default:
 		DRM_ERROR("unsupported misc op (%d)\n", input->op);
@@ -1207,6 +1214,45 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 
 }
 
+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the CP.  The
+ * MES firmware debug-message ("mes_dbgext") interrupt is delivered to the IH
+ * as a CP EOP (src_id 181) on the MES scheduler pipe (me 3) and handled in
+ * gfx_v12_0_eop_irq(); it is gated by CPC_INT_CNTL in the me3/MES pipe context,
+ * selected via GRBM_GFX_CNTL.  Must run in process context (takes srbm_mutex).
+ *
+ * Although the firmware C code passes Rs64HostIntrGeneric1IntEnable, the RS64
+ * library routine that actually raises the interrupt (AsmRs64SetHostIntr)
+ * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).  So
+ * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the CPC_INT_CNTL bit
+ * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1), matching
+ * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe is not
+ * sufficient.
+ */
+static int mes_v12_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	u32 cp_int_cntl;
+	int pipe;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (pipe = 0; pipe < 2; pipe++) {
+		soc24_grbm_select(adev, 3, pipe, 0, 0);
+
+		cp_int_cntl = RREG32_SOC15(GC, 0, regCPC_INT_CNTL);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+					    TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+		WREG32_SOC15(GC, 0, regCPC_INT_CNTL, cp_int_cntl);
+	}
+
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -1218,6 +1264,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
+	.enable_dbgext_irq = mes_v12_0_enable_dbgext_irq,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1825,6 +1872,8 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_init = &mes_v12_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_0_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
+	/* gfx12 MES routes mes_dbgext through mes_aux (zone-partitioned buffer). */
+	adev->mes.dbgext_zoned = true;
 
 	adev->mes.event_log_size = adev->enable_uni_mes ?
 		(AMDGPU_MAX_MES_PIPES * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE)) :
@@ -2097,6 +2146,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	amdgpu_mes_dbgext_start(adev);
+
 	return 0;
 
 failure:
@@ -2106,6 +2157,9 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_mes_dbgext_stop(adev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index cb7ebdfffeeb..3e214cb4f6e1 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -839,6 +839,22 @@ struct CHANGE_CONFIG {
 	} tdr_config;
 };
 
+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+	uint64_t dbg_ext_mc_addr;
+	union {
+		struct {
+			uint64_t trigger_interrupt_per_new_msg : 1;
+			uint64_t reserved : 63;
+		};
+		uint64_t u64_all;
+	};
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -853,6 +869,7 @@ union MESAPI__MISC {
 			struct SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
 			struct CHANGE_CONFIG change_config;
+			struct MES_DBGEXT_INIT_DATA dbgext_init_data;
 			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 		uint64_t		timestamp;
-- 
2.43.0

