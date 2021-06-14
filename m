Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB9C49EA3
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F62E60E09
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F62E60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF24A6E10D;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDEE6E0FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiGAY80FhsEycnsd+v3v75pTi1qP0cZ4idapIdSFlUJntLYghJGa1KkcpadQTDQCIEevvVpIEtzxrTjSN63WmeMrNp82gZWD4BjDQn1IcgKrdZ1m4rkfcKVgcKDeE6zT1SBu1f1aFOBQWweSJAai3pOfWByPRyqQZ058RHaMOOSM5h6G5cln+zz7Z8FunMwQjRenxdVbk7FgZfPkcUbgyPYr1SPOVLv1XcF68DVZLteDRo/y1bs41CJAGKhafS4OXgrfkTJH0RiKlmnX4xv1Bt/vgSEOVCsfiR+JzVIKKiQHJSWFJAJeQPZu+ZLY30tFdCtA7/mQFUg1zYTxwmC6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=KcGK3gW7ubItOvyPfjZ0pNfTynLRe2IqYyBD99ak3kHcUjuYI0U/2GkBtKAWYgsLj/SYvozDpiRwm154tpZEtG/ipu/fTauk3oXDBdA/hQOkGJpCaIJ7mIqzYiPhQNZZG8hdSc/bkkZDsF+3FNZ7AuzVRy84tV37JhgPTCHn6HQV+VlnbiEt4O1xwGSK1TRAcydDLbWH1ooYBsMt55OoRkz/KHy8fzggS/o+WjZ0/ZvT7w04F/+k39F6QfIssroq8Tv+DnUA6MxmVZMcvwtd+FDyZQa9s58udurs5WxV1Qu09E/asSoGJqBI3mqcjCeHlb7BYa3rqlGLwUxvqGY4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=RDfNJDaBQHCGau50qDMaHpfX75CPFsahubA9UQkKP7Y3sO/d9aF3IXHxXcI52eY3ZYGVozlWGtXAD82/3qLm8V1NmTBHwbJQyvBK1PS7r0aqudykS/wZjW6/BEvWeuInF3IEVkgjUPdZrCrlhGV87T99FvUOHasoV5kBLFP5t5Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:51 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amdgpu: add new helper for handling EEPROM i2c
 transfers
Date: Mon, 14 Jun 2021 13:45:57 -0400
Message-Id: <20210614174632.20818-6-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3248dbc-3e35-4cdc-3963-08d92f5c63e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47482B6F618E63088E844B8899319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02KsxhJWrgxI5oiRENflfwkdkuzBLR6FNVMavKZkTWjbwS3zFz5rJF9sZZG5aLLpeSQmmUCUt55JSLSnq5dNHoC6Q5xhm6ZNEMNHpjFdJ8kYwvVMnKTOolCYw6Ki5zW4sUC0njNbn4BPujlfyKld93dsjC0QigfTCI2gR2V1izXT7e90ivvln1W0CR6szpd2VHeTcKQ9o1gVKViTAR2wQK5EyntnG6arI6ujA/hAXvt1/673TFTwkzS5c9RO4PoFAc2sWv+C3PYhqnk+jtHCb+Q6ZWmh0xS0NiF0xwLL0b3Tihiqx5PbJLHqts1Ovt5mFPC3cwBLhi/BNU+J9uQ01UWiifMj0lSNM72j/vKo3o5gIntF8Yykea8V725HymlFTxxqBhW7RcyYUh3nBjEWqcOygpCbhv6wAFaLYEm9MAcjD4tXv8oM/eouVLvzTV1sBnn/tUI67D9BqO/qNT+NEgGxmqWfxTrm1qrkpKWRyR+SdskYiTy9WuiU5C+s6nvvCuXcrMTGeYXXlbTD+A9fLbCE6OBXxLzXJ7PkJOWwAY/Mc9talwju5AVHn6KdiEMaZ+cJ0li0R9dRXE9dhj0BBUoDzbHmlrs98ABVhUupIB6OIzboXmbMcr8pwYAtp/4j7UnBhSnZ2W16w9nLoawT9vHlEuuAdyCtdN1Lt2D/GReEaWKYnMceOghrW415sqqc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dR5dyxQhMno1CqTQyYEMG3z6mMJhwwmynF8OIGDKQZ+WmF/G+z2Sx49X+Mdf?=
 =?us-ascii?Q?ARMdzRuSK5TZpfKZLmHsk+OKNwAgXBrtGnL5KgjaAuNkbMFj0/oYCaaxXdVq?=
 =?us-ascii?Q?PpJlrOvPLY4LEsBH48gFmbNM9S7PgUz7BHR/mPwDg7JbI2Swh5d1qNK4HT7c?=
 =?us-ascii?Q?trJfq0zR5fm1NKY2IjdRtEsFw0VjrnR2rrRy5r4TzeGO7UfDm4KLj5C/XWgO?=
 =?us-ascii?Q?tDOjQC7qT+W70Vz4IYQl9F7TyfSCzU9te64bbUPxXvAebwyW1cMKsjKUs68f?=
 =?us-ascii?Q?lab7Q/TxZrPss0CqrPp+ym+25zT8VqkYaEtvmE2wxrmFbSr9gWsX7Fnkhfq9?=
 =?us-ascii?Q?xqEbp9vDwO9XZvj+JmAEON/XCyzMaUmciciexlLTLCT9vagjNXbC/4Kz0gve?=
 =?us-ascii?Q?voq2JZRfxBie2wc3LMpBegZ8xgbFx4PIKIMKbUswYY31btsLpZz+cEpBL7SQ?=
 =?us-ascii?Q?fumIigVyvd5f6Jy1iFdFtmaC6USRgl4jnt1tWey/82zAn1cyHpo8QCeXsa7F?=
 =?us-ascii?Q?VXhLZn+hwX6xefNmpBBnivWR9SwNx6hTyKyTuywL01iu5taocIKkLf9JEa8v?=
 =?us-ascii?Q?xbzyWzHjbYG9po2xu7MB32GROPskjDdKNCiVqdWgOn1H57UUgvlBSGzbUSpq?=
 =?us-ascii?Q?zwVx6cuzSKPKpKaM1JegcGDE+LEDZyRhgYwgfzzY1eT67CDMrP/fQAsYJph7?=
 =?us-ascii?Q?U5JdZ4p1f16yHwZjg3DYyLvsdKqM6QPi1k8f5P0KBzz4/q/mlUh5eb+2OLB5?=
 =?us-ascii?Q?AQSxmjBTpoXW2OfyxUPhoRUOkUe+1hmWkY03ayoUfcoxJLOuAP4QZeVPxhQK?=
 =?us-ascii?Q?sqETu/rfAp7ZxjsfrTADiVQ8eIghIePuKeyhxlIP2TQ6BMkUxeWzGEtx92M/?=
 =?us-ascii?Q?lNnYQaFMilX91vLlZX8itEakevGPgjaRtknUQ0msg4g1xcrlfiypo9JAwI8b?=
 =?us-ascii?Q?k5WJY4j/pFACzLPfCl/qUsv+UnZ0ylkXzyk8xL9gVrUgDCyBT85GTKD3JR7r?=
 =?us-ascii?Q?7qcxGqTL91lJgyjsSqnNHFIn9DpInLt671KKq557kkMh/s2VE5NzCr5RwfyW?=
 =?us-ascii?Q?q+pZHnS3lAlIXIDFInHSnrq04eiI55mWk2emyRk20oj2UmD/IBBguix0fNSr?=
 =?us-ascii?Q?hSEeDdML/lTY7uKvi0lOO5ZUdgDprERXePPGJzQh9O8etBNrsDOq2g1P82x5?=
 =?us-ascii?Q?MKa9fvtlQG69h9/yupRdpTBla797LRWz2tq6+t0KXTKRXfMWUi9jS+l2H0+m?=
 =?us-ascii?Q?ypx/GVgtDG4ENPZELbZ5sXPjab1kSOMz/OH6DbK8KOpy/W9NBQwVSGYU0YHi?=
 =?us-ascii?Q?l57JIoYv8AqusR3iccBT2DAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3248dbc-3e35-4cdc-3963-08d92f5c63e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:51.0635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuFgWpDNad6Ejx5gNqnnL1V1Hvuum3xCu1GlhuiaONpFA6qUjUDf8Zlo9teSMtD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Encapsulates the i2c protocol handling so other parts of the
driver can just tell it the offset and size of data to write.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 67 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h | 34 +++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c56320e78c0e1f..7d292485ca7cf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -57,7 +57,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
+	amdgpu_eeprom.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
new file mode 100644
index 00000000000000..10551660343278
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_eeprom.h"
+#include "amdgpu.h"
+
+#define EEPROM_OFFSET_LENGTH 2
+
+int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
+		       u16 slave_addr, u16 eeprom_addr,
+		       u8 *eeprom_buf, u16 bytes, bool read)
+{
+	u8 eeprom_offset_buf[2];
+	u16 bytes_transferred;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = slave_addr,
+			.flags = 0,
+			.len = EEPROM_OFFSET_LENGTH,
+			.buf = eeprom_offset_buf,
+		},
+		{
+			.addr = slave_addr,
+			.flags = read ? I2C_M_RD: 0,
+			.len = bytes,
+			.buf = eeprom_buf,
+		}
+	};
+	int r;
+
+	msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
+	msgs[0].buf[1] = (eeprom_addr & 0xff);
+
+	while (msgs[1].len) {
+		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
+		if (r <= 0)
+			return r;
+		bytes_transferred = r - EEPROM_OFFSET_LENGTH;
+		eeprom_addr += bytes_transferred;
+		msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
+		msgs[0].buf[1] = (eeprom_addr & 0xff);
+		msgs[1].buf += bytes_transferred;
+		msgs[1].len -= bytes_transferred;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
new file mode 100644
index 00000000000000..9301e5678910ad
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef _AMDGPU_EEPROM_H
+#define _AMDGPU_EEPROM_H
+
+#include <linux/i2c.h>
+
+int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
+		       u16 slave_addr, u16 eeprom_addr,
+		       u8 *eeprom_buf, u16 bytes, bool read);
+
+
+#endif
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
