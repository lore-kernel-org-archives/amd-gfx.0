Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F5C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2253610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2253610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1ECA6EC2F;
	Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B166E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWT9gt5lP+qhb24sHeoji5xu9JbIU7jBZa0eQMngPXqZ3va0FvjZitCftCDCDZ4GI715+nfT+8tyqJXaNez/MGgJBjsin5Y9IGttMO92RfQTnRku1hBSkhCpXjJsJPDVDL0LS08AyYpvypM3ZUTw7Xs9SGiP+E7ku1RLbfEXk+B8Y0zVz0reU6xt3HGOjnmmjVvrW1LZWwO760TbLC9t0B8r5IJ4x1Vm1RBoSi0vdbcp+tIXfwL53ZkjzddhWqqt91G4H7uEZX3crlaXxvRmr9jAwPX8+0FtS7y9AyT07vFUo1R45MD9cn4NSw3E5wH0zz1vMKW+g71tlva7HkSCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=BqfUyNVAdZ5vls5mhvFLwMZ6qnLTKTRB8z+gApAfNL0pEZBn+FR1CUS2EhcJP7wmYVSMOM8jzMnV2y9MtfOTuEsuf/j7psGeA3Eg/HXPnFhYCuU/2TpoKnxRUzjnj4A6yl0u+QtvQA9NlrtNPcORFnEz7+sKQPOvzCZ0c9WL5UC6QycHp+sqUo4EK88HockURWGB1Sf8UNB0IxACJ/4pdYQ6Ad+uzrQPp5b+DxuB4rL7JV5I7NuOaCV6uCiJ1QfRTvw/cwUwEbChtIQh8GL5wh0RsUb9/qCPiszsGQR+gLD94ZdLF/xJ9TaqGKTqI4vuDHi/2bATGk9jyUO2cE9MXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=RqaMziIX1MB9q9+UYKpFfoJYIFhAXEZypBJ45q/+ROwBuilXCyKDqZFegqmdVvPhu7PWnSJxAxGS3tYKwhyxk1ron2ql1Za0wuaxSSeClHQHxwUrBzJa0/FaweHPMBC5jFf+HNNSMRKtq6novvjUtslcFXht1MUjiIBdA+rqrQQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:16 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:16 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amdgpu: add new helper for handling EEPROM i2c
 transfers
Date: Tue,  8 Jun 2021 17:39:19 -0400
Message-Id: <20210608213954.5517-6-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7acc210f-bee3-49ba-140b-08d92ac6017a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396498F5593EDB06AE1A97C199379@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xv+BIBeB6FOxw+ObWPoZ9uWptvj3Gzm17zJ4WB+kFhX5fSJql0fdYdwCEfaOj1WsqZ8z/kqzG+4h8TBp1Y3EqCSnQKI/Xxe6GpmR9QfSbcjh+5LDajPAUd9U9M/LDFphMGTcxMMvcmGxBwUFBFHjaCjCL3vs8MEx0ljhwGWrMkftZ9itU7mVX/sI7JLoz7nRoGVFJyj5S6Js5tU2JQgU7YPILeoFxl1N0dxedeB/6wXd7w/5n8m1PnMlReiJhXl3cbKJPrGLLw2lKiNdw0ZOPbSunq5aVkqvU9Hn/zbiXPS5vFGcARYuBLXhT2da0gi72Idsnb9FefXbh7AXtgZCfGd9fH//ZIEIS+rpO4qesLbLuecGKcfi8ASqidadpzmwJ3Z3/vrwA6o7+fbiGz5n3eXukfT+GES+Nv+phWEOvTFgO2+8IHtgzwU+0WtREyvmPdXWN4/js0Zp1NmynO005wYUqEe6RX9UUAs+YTva7ehRvBIj45q/TUMQzSm4jrjU9URqXshLQ4JOrCZrsWDWI+Y26GH55jc+nLbvSz333Psy3UL7/K4esdcYu3JOui7EqbCDKDY/+WHUJSK7NhUFkbLTUPCYmGEnteQEdF+asP0KIteFuJvV2DMGspWGMQ7Xt8VQdu4+qKDIw+mjzrH8aaBjGWCTr0KvEVifRUoRsxLwHT2JgkdNacONlRTJONpM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(52116002)(4326008)(38100700002)(6916009)(16526019)(5660300002)(316002)(54906003)(55236004)(6506007)(6486002)(83380400001)(186003)(6512007)(2906002)(44832011)(26005)(1076003)(8676002)(2616005)(66946007)(8936002)(38350700002)(956004)(478600001)(66556008)(66476007)(36756003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xDyoFx7qeO/CYNgARSPWkWxSdyv+lFJJFT4IpsQ2QsUjEsxqN3kVq5AyNe/?=
 =?us-ascii?Q?iF4vQ+JIVQ5v7mgvL3G15Mw+LS83KGAYl522zX8qYTvPLA/HRT/U5tJBkUxs?=
 =?us-ascii?Q?1/XdIsA6oOpcFJ81xe6mK/Udh6Rg8LkGGHk99SH5Du3XvVmhPeMyI7zPLmTx?=
 =?us-ascii?Q?/NVcu5Jn8jkqIjgNf16CRmOh1r5mVf7SN5CHuKuWzhzD7XyEgmoOLbyQ4Dz1?=
 =?us-ascii?Q?KmrPB/gqsnUzNWcyvcQWWp8kkhRRHz/BxBoItKsvP6b+ZCaXprV8TER40btt?=
 =?us-ascii?Q?ps2/m2f+LNNvI/XiS2U0fjWvfF82r2jMt6+u/X85DGZZoYHIkQ07Mb5Tivlt?=
 =?us-ascii?Q?klq5oazNA2zggXicstEhCkA+ntkUMcmjwEUryBhRsF+lmFKrTBTCN2Tw6gTE?=
 =?us-ascii?Q?ASQi7OEpdpU4OMLu+jykCt7xPDmbrk90qhZxBUrTgxQIH57ykDYEMFYv3z3K?=
 =?us-ascii?Q?QNgw8r7aPrISzAy7iqzjnnVt+tJ0G4Ocz2wJYcqd00UCm0ZQLp9WTHSJs5az?=
 =?us-ascii?Q?5YgbJrRrTefUiqAbz8HIqhQ4j0ZxxFIWung4dSGu8gIaiCoa/w2h5DgeY8X1?=
 =?us-ascii?Q?Z9dNVLJuA+irgrC5fBAG0Q6h+IKoCw77hsklWD+xdvt0JOCpxsjEcP190JAF?=
 =?us-ascii?Q?KuxE7e1KDEuCS44036UZmxQimfTnvwhijpJak55dCPi2c+jM3dcHa0Dmnm+O?=
 =?us-ascii?Q?2/PM1ptZGqg6QtJLUieGvoPJqU9vAIB3Yq9SO86PR3l1aCzhwTgsUyhCBds+?=
 =?us-ascii?Q?KFmdK0t2HWkphJS8akxYdCVtGyWaIo1IPkmeCDU1WbkJBApzvufhFhakuQ13?=
 =?us-ascii?Q?HAYwetIB8naqAgV2YpJS6ojV5a9xXbcSX/6YKGMPIeGI1bcEWnL1BrgJdxuH?=
 =?us-ascii?Q?tGmXInnseP/k+Zd97lcKAPJ2yq5bqoMVkSgTqiCM2/mb/83W+cu3m/+Qr1/0?=
 =?us-ascii?Q?JHZ4azeCkcysHC3h7+BttX7R939DnfxXK8i4Y174sCSShDcu5xJkCdZyt/hV?=
 =?us-ascii?Q?hIZtuz5q4aw7b2hUY9qIrpxhA5lefsiSggxFH9fOeooKHfDQhEyG9r49C7YI?=
 =?us-ascii?Q?32lT9yQJivbtAqESmErtFsfhye6X9MszyMV5fpssn189pqAWcuXkJnnCAdQz?=
 =?us-ascii?Q?DrvP3GD4+Vi+90XDPLkZQ1tgaQUorYrT/eH8uzCPBX8K+KgXizGOZtPwMTNb?=
 =?us-ascii?Q?pXyXjLZ4IT8ZEl2YnwqxkswiNrMsFtNxQ75htsAjCfIQ53VERTmhuDJEPSIC?=
 =?us-ascii?Q?M6lCI6xSPM8TmOnlQsBzqI3XrsE8jf2xtdVxnlUaetSkevTvEOC3z+dnJQ7m?=
 =?us-ascii?Q?IlZjNTST0JMI1x2tkyRuR1cs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acc210f-bee3-49ba-140b-08d92ac6017a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:16.7463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QJpu96kKUAEKUhh2HyH0cBwh0/WzA0hKflSCqHWACFHciswJ6m5DDvJPctG1Au2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
