Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53516CAC59F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0B310E615;
	Thu, 18 Sep 2025 01:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8a9gS3q";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6705B10E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJV4D+TpxhPolyiKvNhtE9v6UqItdv2tcFGIvH23rPU+NSmMMnnXgBP87GBMfjsdxsWB8p19rpF1AFjjLoT91JLa/34quSxCAZZhW8mpg/CihgEu9hDlk/kBEagwzZtV+g26fe6F2CFNVG8piMVKWqa60j1hflTXm8VYxopf38xFF8eFuczkXlKAviF6W9eK+HZN7Q1oeS3eu3XW6GZTebnVsFzD6bG0hGVSrf6xuE7Evedk+HCrjVGOPpFuTr30bzizjglInfoOPh3bpkP+NojKgiG7qyIdGqBiZ2+9gMYlmIWGXzmciim54Z9hbicZNAjELS5MGQtD8iBnl2g4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNDWMFXYLbfgIs2mkkp5YcCV0YMtfeLM9AtyMim5Ci4=;
 b=Yzu3260vUwdYBRK808dzOImc9yoYLpo95zd0/hanHbjWTfxrXq1JXU+yVwYUpE2yhdHunkDmr0pVG2KAQn9kguosvz3pgNXqVsjlTcj64q7weDipvJ8crsiuCEbeFcPs99wSEJDtFNTAD62CPjYztpbuSV2FqZKqYZEZeBkpTdZaU81jghutp890Y5q8DEpCpGa5feJGEbHN99TkF3T/7fUMw3MPh4SW7CDEHGbBvIeEEG6aSu50+wnId9Q5+Yo0jmeb2Yo2mrsDXk8JUfRGpz0fkDwcalyetbFGdVXvAD6brF6DuV2j9uU4BoeVa/jB51bWUfNWMNMvgHCA6jRN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNDWMFXYLbfgIs2mkkp5YcCV0YMtfeLM9AtyMim5Ci4=;
 b=j8a9gS3qANaEqqRd+31hpsduRnBPRxe8A3Eno0K08wr7URr04B93mi5KVLivaE94gOKn4+Nrq/s5XQ0Ec9kw9654SoxK6pmFeqs9ruCkbhUYX7OAnQPW+hJJND3WM9vBGsBFvDuFjPwnTOOa+3xRJtPWwlObWS3JT0a3QoLc66o=
Received: from SA1PR02CA0012.namprd02.prod.outlook.com (2603:10b6:806:2cf::17)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 18 Sep
 2025 01:36:50 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::8a) by SA1PR02CA0012.outlook.office365.com
 (2603:10b6:806:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:36:49 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:36:47 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 04/10] drm/amd/ras: Add amdgpu eeprom i2c configuration
 function
Date: Thu, 18 Sep 2025 09:35:01 +0800
Message-ID: <20250918013507.2629620-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 011d6e25-f060-4a0e-0e4b-08ddf653d6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3vWP+TNq2qrHS1BthPdm+3SybewKct33acjS9nggFU9UZJ1tvepaQCfr1XY3?=
 =?us-ascii?Q?nXKEv+RF7UlUUQ8g22EWk081gdV8kk/VDCUKYHZcxD5x43/0P93REk4vtTuU?=
 =?us-ascii?Q?ap7+H1TCoFr9IFnShHrEvnxSizw3/PW8TPWz0Ekucb/7iMJW2RMCDQT62433?=
 =?us-ascii?Q?l4Y8M+ah4Mb8RaxuUNODHWCm2e2Vq0SBHWUu2//ozt3WvOfzRUJ+gDMHHnkq?=
 =?us-ascii?Q?VKz1VJSawrBzK6LKrlYvC+NcmZW8DkegSbc4co0FMH0PE2XjpNPb9d4GGfV9?=
 =?us-ascii?Q?ihU9XxqsNEicdZa0NYsAtjvhlY0VpZOOGdb/MPHqLBm5O6W9a3EM8u6VpcOi?=
 =?us-ascii?Q?i/AWnTFscsAGSUbVjU0OobVRZ+kqEcMydT1NrxnCj71Sm8q/Oe8nLhZq8iEC?=
 =?us-ascii?Q?ZKBPPXS6b/Q5p6IEuMZXdWVZa9rKBGSDMqaxaTxZZ2Gpc5F0GSmPFPu+Qwkc?=
 =?us-ascii?Q?IqhwZ1gpw/FX5+EYx0KHirldDd4cR/scXgIoE1pNerHQvHZdy5x60q7Kb0HI?=
 =?us-ascii?Q?1b9qcQMRJwDRn5Se3jjO+hucgmRAtHThmc00OtLLPtK9/4OqIx6XDvctz2XD?=
 =?us-ascii?Q?+mYqLnB2vRg6b4t7dnyXyYhXPtHq2YzSF+R6sdq6lL2KNEAx5Nn9+vmXqdhn?=
 =?us-ascii?Q?LVYPcGTbVExBBDbGhbwvpR+8rHHSSXp2M7URI1poIItmrca/eIQZF6iCbmlt?=
 =?us-ascii?Q?P4r9h1L8+oShKWcpo3Fm3+hsY5Q/hsAsqGN18qmd75wuvuwk5l6Af5YNC3uP?=
 =?us-ascii?Q?oyaYyY4KignicBkXGksFxhqJSjewPOCpCZJ1jP4oBUmKC0rqyzxEbtPFq/05?=
 =?us-ascii?Q?x2N5nj5wQfR9TwtS9I1mgsz/gNaiJ0KN1e9EA4n3FKDkOp4R53tbfftIKDrj?=
 =?us-ascii?Q?pMDCpXQBVsPGU1hnS5LWhLpEJHBCJ4gcysnGcRPsTAegDy1srJ9TgBitDYgE?=
 =?us-ascii?Q?WW7vMYkgiDUJ/anRk4nA1Qf2cbsGVOKLuUUgfNtqiHUeEgTs6vcgzfri8DeY?=
 =?us-ascii?Q?HOKC9xwHbbzi8Olkqfw06OZasZgl5eQWSt2DNOQGagTjJ5faFmbT0JyudJ5D?=
 =?us-ascii?Q?3ZvfLqsIzTtnEtKCxmaP+GlY1zJHW0NQ4AHp+NSaE5l1QXgI21HoDYEYrh5u?=
 =?us-ascii?Q?E2O33b7K8KKwlaP7d2WYvsft0IkoBWYqE3rAArHJF7vCIqDHb8cJJwCyZgHS?=
 =?us-ascii?Q?TWotKGiAXkNCJcWAo8ZGGkTQ2ZAp+aSJVfBmekCC+1lvrfGsjjJem35sO37C?=
 =?us-ascii?Q?MDpiwKZkhHu4czj2t1cUFj10ihJbCrtN+E5tnsF40p9nMXL8ZtSHs1/ugt3/?=
 =?us-ascii?Q?WVwt5nF+5M+dGOzXAfzDc7N5Ta3Twmpw/w0H8uLhfTmkBjUPnvfOlFo8bD9s?=
 =?us-ascii?Q?WS91PHq5EQjNB1/olY40MKBf26VQpMPREz67Edlzv67qmWvMSKNLe3KD0I+l?=
 =?us-ascii?Q?PrEzoi0anLpKh4KBy/UNLIrr0Eoj8J+tslB+rS6uBde0PdezCqGzDVHMkLv1?=
 =?us-ascii?Q?tclOxn0uGAyv72kOv8w8TZl5nVq1c8ev+aKK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:36:49.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011d6e25-f060-4a0e-0e4b-08ddf653d6a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

Add amdgpu eeprom i2c configuration function.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c   | 181 ++++++++++++++++++
 .../amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.h   |  27 +++
 2 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
new file mode 100644
index 000000000000..1bb7b7001ec7
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (c) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_atomfirmware.h"
+#include "amdgpu_ras_eeprom.h"
+#include "amdgpu_ras_mgr.h"
+#include "amdgpu_ras_eeprom_i2c.h"
+#include "ras_eeprom.h"
+
+/* These are memory addresses as would be seen by one or more EEPROM
+ * chips strung on the I2C bus, usually by manipulating pins 1-3 of a
+ * set of EEPROM devices. They form a continuous memory space.
+ *
+ * The I2C device address includes the device type identifier, 1010b,
+ * which is a reserved value and indicates that this is an I2C EEPROM
+ * device. It also includes the top 3 bits of the 19 bit EEPROM memory
+ * address, namely bits 18, 17, and 16. This makes up the 7 bit
+ * address sent on the I2C bus with bit 0 being the direction bit,
+ * which is not represented here, and sent by the hardware directly.
+ *
+ * For instance,
+ *   50h = 1010000b => device type identifier 1010b, bits 18:16 = 000b, address 0.
+ *   54h = 1010100b => --"--, bits 18:16 = 100b, address 40000h.
+ *   56h = 1010110b => --"--, bits 18:16 = 110b, address 60000h.
+ * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
+ * address memory in a device or a device on the I2C bus, depending on
+ * the status of pins 1-3. See top of amdgpu_eeprom.c.
+ *
+ * The RAS table lives either at address 0 or address 40000h of EEPROM.
+ */
+#define EEPROM_I2C_MADDR_0      0x0
+#define EEPROM_I2C_MADDR_4      0x40000
+
+#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))
+#define to_amdgpu_ras(x) (container_of(x, struct amdgpu_ras, eeprom_control))
+
+#define EEPROM_PAGE_BITS   8
+#define EEPROM_PAGE_SIZE   (1U << EEPROM_PAGE_BITS)
+#define EEPROM_PAGE_MASK   (EEPROM_PAGE_SIZE - 1)
+
+#define EEPROM_OFFSET_SIZE 2
+
+static int ras_eeprom_i2c_config(struct ras_core_context *ras_core)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	u8 i2c_addr;
+
+	if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
+		/* The address given by VBIOS is an 8-bit, wire-format
+		 * address, i.e. the most significant byte.
+		 *
+		 * Normalize it to a 19-bit EEPROM address. Remove the
+		 * device type identifier and make it a 7-bit address;
+		 * then make it a 19-bit EEPROM address. See top of
+		 * amdgpu_eeprom.c.
+		 */
+		i2c_addr = (i2c_addr & 0x0F) >> 1;
+		control->i2c_address = ((u32) i2c_addr) << 16;
+		return 0;
+	}
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 14):
+		control->i2c_address = EEPROM_I2C_MADDR_4;
+		return 0;
+	default:
+		return -ENODATA;
+	}
+	return -ENODATA;
+}
+
+static int ras_eeprom_i2c_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
+				u8 *eeprom_buf, u32 buf_size, bool read)
+{
+	struct i2c_adapter *i2c_adap = ras_core->ras_eeprom.i2c_adapter;
+	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
+	struct i2c_msg msgs[] = {
+		{
+			.flags = 0,
+			.len = EEPROM_OFFSET_SIZE,
+			.buf = eeprom_offset_buf,
+		},
+		{
+			.flags = read ? I2C_M_RD : 0,
+		},
+	};
+	const u8 *p = eeprom_buf;
+	int r;
+	u16 len;
+
+	for (r = 0; buf_size > 0;
+	      buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
+		/* Set the EEPROM address we want to write to/read from.
+		 */
+		msgs[0].addr = MAKE_I2C_ADDR(eeprom_addr);
+		msgs[1].addr = msgs[0].addr;
+		msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
+		msgs[0].buf[1] = eeprom_addr & 0xff;
+
+		if (!read) {
+			/* Write the maximum amount of data, without
+			 * crossing the device's page boundary, as per
+			 * its spec. Partial page writes are allowed,
+			 * starting at any location within the page,
+			 * so long as the page boundary isn't crossed
+			 * over (actually the page pointer rolls
+			 * over).
+			 *
+			 * As per the AT24CM02 EEPROM spec, after
+			 * writing into a page, the I2C driver should
+			 * terminate the transfer, i.e. in
+			 * "i2c_transfer()" below, with a STOP
+			 * condition, so that the self-timed write
+			 * cycle begins. This is implied for the
+			 * "i2c_transfer()" abstraction.
+			 */
+			len = min(EEPROM_PAGE_SIZE - (eeprom_addr & EEPROM_PAGE_MASK),
+					buf_size);
+		} else {
+			/* Reading from the EEPROM has no limitation
+			 * on the number of bytes read from the EEPROM
+			 * device--they are simply sequenced out.
+			 * Keep in mind that i2c_msg.len is u16 type.
+			 */
+			len = min(U16_MAX, buf_size);
+		}
+		msgs[1].len = len;
+		msgs[1].buf = eeprom_buf;
+
+
+		/* This constitutes a START-STOP transaction.
+		 */
+		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
+		if (r != ARRAY_SIZE(msgs))
+			break;
+
+		if (!read) {
+			/* According to EEPROM specs the length of the
+			 * self-writing cycle, tWR (tW), is 10 ms.
+			 *
+			 * TODO: Use polling on ACK, aka Acknowledge
+			 * Polling, to minimize waiting for the
+			 * internal write cycle to complete, as it is
+			 * usually smaller than tWR (tW).
+			 */
+			msleep(10);
+		}
+	}
+
+	return r < 0 ? r : eeprom_buf - p;
+}
+
+const struct ras_eeprom_sys_func amdgpu_ras_eeprom_i2c_sys_func = {
+	.eeprom_i2c_xfer = ras_eeprom_i2c_xfer,
+	.update_eeprom_i2c_config = ras_eeprom_i2c_config,
+};
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.h
new file mode 100644
index 000000000000..3b5878605411
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2025  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __AMDGPU_RAS_EEPROM_I2C_H__
+#define __AMDGPU_RAS_EEPROM_I2C_H__
+#include "ras.h"
+
+extern const struct ras_eeprom_sys_func amdgpu_ras_eeprom_i2c_sys_func;
+#endif
-- 
2.34.1

