Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F9C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CFC60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CFC60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70D56E219;
	Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A84589BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQqvyMozApkay8bk0ilPrJMvh9f+pF+UntRcVENJrcT7Ofmrn6xrMENP/1jSEmJlyBNhsRLSkdkjDqCNvE4wT2UE2Wlvwl6kUb8kV4A8L7A0zzITvdHxDyxTKrmqK/icpPW/xrr1XMpnxFSf7pIrQ5G+iqs1ALZjxSocbqC+IMToxnAAMUTn+4S6ZSSbs1GfEWRJZsRemdBYnAHEVjVbXZRIo/1NHToibcY4/uGRmVuMjvie9C9joUwe3tY9ec1D70AVst/xSfYpdqTU84DIwxmH/jVyAY3mLtE4sqwFQi9l5ANzZy/5oOCx2LiKOlgQTFXydi14GU01yjjr3x0eNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=BIfbxrQQOLmGidjfvuvDbHSrxRmQcZjwTWWLPBd4zQuuIanj8FtN5UO2HYyDRrBxv6ZhtP8aGTUOjhdTrzBR5/ftcBgW3WpQ9GtP7WfNlh6iV2y6QkXCb3CfOsfavXxPUuCuyscbT7MTdAv+AluRR8e8Z1aaLEY7fkPqtZJajBv8RlFm5bL6tUktzab6rMH5gl091PrG6fJR6yNtNt78lJw+MLPFL5D7CJIPCZIxcGlm2TFCN8vSSTXXuMjYRU5gveb7NnXGvBhh1L610t6FMm+se78FYXkEhLZnmFjDij2E0GlQ+tY1YoRLstba1+KrQz9gEgVjTb7SSBFCz8v3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1maoMhmHNrV/idgsmZu9RGm7aGeoRT9KQGiNyG68+o=;
 b=ZoTmwd/EwjkpezawXyQPP7xVGi9SkYXB9NGBMnKI3AtN+nJeUa12S1g0nn441cXCS/sryjGttrMYsAO3wk1yWhkjSBM+R/SljEekbBrDU4KyK7GknnGS/2GoeqPDqG4WIcRjppFVkPPc0oYnqsSH0TvKSJUtdbyWvqlwTpYO6qY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:38 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:38 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/43] drm/amdgpu: add new helper for handling EEPROM i2c
 transfers
Date: Mon, 21 Jun 2021 13:11:43 -0400
Message-Id: <20210621171221.5720-6-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427ad3b8-0a0b-4d64-0569-08d934d7c53f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258CE4D81FE2AA411399341990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DruYgOSg4JO/4fjKWJcEP2rl8QBClFyx6YHE+8om4yK1lGRX0l4dxcSQKY7LPJOpJAOQIAUTodWs9K48Zmd9B92idQ715aPq9h0ruaZY1EkITCcgUeXyUaJnrHVPcugp8XYYVXvFwS6UNxImr92egYPhjNy8/eIfXr+pXX0sFpa8QcxjUtZh/a4gb/VK6AdE+6RnzlIQsgkUYT+wWUX9vYXIIFN/dq78uKyqshMOEZYNk1sUzFUkC+cNkImbY0w5fgL17lOAjTfJavgvcv7IYQYhSx653qEW8ocfPJUdZyYUOBcGFrZ9IjilZ2g4UeCZJj5HBA/oLwwH5AvYBU540KAua5NeK6VS6bDbh/K/kBn+UVW6pGfity8I9D7r6xwrobGStIxkLKgi5LosSBKzGYVnTRvaG3FVgg6egYqXvwAG5FIK76+baj4q+dTu/u8/tQaQE45X2eXsibKIEe/3BwG1IU9a/wFnO2DwmdLGmnyY20Syb7oIgw/nfM2hzoJDCwQcum/M9303FCqxIXT3OKCK5fH6c22eaYb4XnKOFOf0nN7r9PVnz7HZFin7OxbSp3Vkg3Xf5NVMUMHDYddN5fNiUNYOOjcz+3PuWPzzNuLnEwHHDiZJxPBkDMS5wMus8DFTFZR3ICiy99yjMmzaDHzVCuKKzDmwqna8sfERd7n039cqEJMbqhnIMuqStOPG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIU2AskINxYY9KcqOg2hKYv/wTpeZTcvYU/DP8VnV6FqQoRdOjLbNxdErvt/?=
 =?us-ascii?Q?6brKpvOttU4a5fkFaguKY+MNKFSXEV0PhdvvWqjke6H6+CWkSh6olojoX1cJ?=
 =?us-ascii?Q?0FAMliPS0quIqBuhf4yyRHoAavfp6thtbcG4PxuB4qP7O3toY/kATaJXjmRA?=
 =?us-ascii?Q?nfKZ134yQtyV9ME4V8vgv09vghvZ4320eiKpCfZtLCTxJtl8SJDxUpLCTJb2?=
 =?us-ascii?Q?v7gPi8QuXQCN8m5UdOH9ZtusgyLVF+JcreDo7+hXKm/aFdewQPTcovSmTFLP?=
 =?us-ascii?Q?dXEd5AWYUCAoglYXD4dM6d8W0EThFPR/6uAZGDgKAUNh/VmQ3Gzj2asBpph7?=
 =?us-ascii?Q?uzItk4hDOSeFxAjlm957wXeMzinBxbsniWJGtMNnmLbMMbdvzXppq5+igk/J?=
 =?us-ascii?Q?8Ii+BeNMXzIsWfz4fBSKaRuuiD8URJMwwLYLwP8NoNGveYtWVTIAQSpeTtwn?=
 =?us-ascii?Q?UbyX3B0g0RYCE6Ao0idpLXZPbix5ba0r/3fcHvL5Iz0QGZXIqm7G93BqbyPs?=
 =?us-ascii?Q?0ZAmlLfKv4QcwuwVxVY2NsM8q5JWLfRgPz1ldRSuD12BLVdIM/HG7MuVrYqQ?=
 =?us-ascii?Q?1zsiwxSTd5l6INfehuggMs2JS00ezH/MECZUohX8GFFjrrakA5aPLE+IyVDY?=
 =?us-ascii?Q?aR+1QhAthmknarPFna9JgHCBMDh9fo+t4C/UIWoiA4yxNXdxiXovX8nx2hmz?=
 =?us-ascii?Q?C7jvym+SdNZvRNpaP2ZQfsnZT71Iplu5Ftz1cCFgntlWtZSOWKe2jJgsTGYh?=
 =?us-ascii?Q?nIUAmivxlDu070JnGzJnqElmq6cKxJHrpAxOs4pD+R6sr/ZVHswBOLnWGBO/?=
 =?us-ascii?Q?HQYrInYFRv3CVy+vi1X33exqI6OekWWVXKzORIXid1y68kRylPvXnKoZyPmh?=
 =?us-ascii?Q?HnJcFQ/67iDGl+jqdBuuCIVNnbdSNDZhbZO29gvvOvE5ux8NswY74DFyj/cQ?=
 =?us-ascii?Q?1+gMCoXrvjoB098dAOpXhk1gpkgjlHJ/bJKN+Kmm1aLaelIJODg4bi3CF81o?=
 =?us-ascii?Q?8REMTqXChDkaFhPWlEWjZorY+tA+9Yfnymdii+vdU6lQDYAJojPtSaDarkQ9?=
 =?us-ascii?Q?SAgQAPGH280OSFJ439365ktiBY6eexHDsQA//WTamwTwGU5dnZ6nox7NGmCM?=
 =?us-ascii?Q?ZIxhdU+vSTJZMpcsf32xebB2iN+SnTzveTwqjGwcmlYY9C+F5gHaPZkDRIIv?=
 =?us-ascii?Q?m/bSxl6uReWg9FO43j+jDV9EdsE8ktSDM5+N/57BEU4SPAiusLnJbkG/BuoG?=
 =?us-ascii?Q?8PFHa7ujf6XEClnWFUEtka0PXeQVRd6p5eascefiPpYlqenv/8+v/wcZjDO9?=
 =?us-ascii?Q?ZJQ3q88uHMe1pFaDzGyapHB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ad3b8-0a0b-4d64-0569-08d934d7c53f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:38.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yvKcdoPw2i2H827101Ysh+hzn1Qe7oOe22faGd8ALGPF7AHZYfcrcaEemB4zFGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
