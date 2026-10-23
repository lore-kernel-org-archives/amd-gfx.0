Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE2606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T66GljHM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7107210E2DE;
	Fri, 23 Oct 2026 20:35:25 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456E410E2DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 20:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDYFrpd7ayElNj6TMYfYI8W/8lCH5Nc9oF9uW/ebWi11mZAU+YNu7oi83E9s8aUUoqD9ZO2/FgPWr5ESBrcw2lzFOqRVHLP3V/1sp4RSZ5RVsmKS6CIn7Qu5fOX4+cGYv7qMnj31l38N3xDmn9snL/t+Tu9zFkXt3NQVRQn/zkRJ203msiEoMLghKhH2DA37K/QywEbpjmEc47oBhr3VLZ0yEuZ+poeE0zBTuq4dAeUVnk8CAqUBkVjoqgjXCSPfWQAY9sAFjsRvYq7nDvaB9e80GYf7gaUKDy3uZox19T3kC9NC3UdBOKHlRpVlH9izoI2CU4DUS63pdcmGNCxttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB47nuqyBafAf6vk3uImEfv6hEc+Z/LctShPdfYKXfo=;
 b=IsNm/k0yir/SuXouM/TOlaMvLT/XTii3SM5ALRAVNA7gZAw8aJCEyyvQ+7d9U9QWgg76mPJYJgeB7N3RR2SM7IIGSAkYXtwmFDo/Xh7goan4tsWt4hcCydj7ZqKE+qPSBLsMdWROpPGw0zKBkdtaRenl8ruD5f/3naBq0OCOUsdH9M2Z32zWsESHuts4MqBBJtaX+URiKOhXHq8ziCFxIUGwkxUih2Ov0giOj887ACaqEpT6z2qejfOnFDtUuP+tNlxRn6gd/UfYqTR95nMlHmyL1bMP7cUgdZUm3fgjN746EW+wVE1azcDk5BcIikxnEW5ZXDZWLGX9qvEXdheWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB47nuqyBafAf6vk3uImEfv6hEc+Z/LctShPdfYKXfo=;
 b=T66GljHMd/nf7YaHgaCswBiaLNl6UbfUwoILPF/biHD7rs/7fq+UnlJk4GldYvZfCF3SxxHsuvhVdzuSFiD5nwewxs16ZrD7w66eD63vOsIMC+6WzREdbPpctGYXD6SOcXxSpAinvhaOltXbA5nOjKW1LbJ02AXSJVWvhNY1xqc=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 20:35:11 +0000
Received: from CO1PEPF0001886A.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::71) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 20:35:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001886A.mail.protection.outlook.com (10.167.249.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 20:35:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 15:35:06 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
Date: Fri, 23 Oct 2026 16:34:47 -0400
Message-ID: <20261023203447.2075707-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001886A:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d57bbc-b316-4bf8-fd69-08df31452133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261021133027099003|261021123027099003|261021130227099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|261021135927099003|10067099003|56012099006|3023799007|6133799003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: QXt1F2DUSJKs6/n2FYxkB1SrAWj26uOxVK7mGfxdol2CVJU6oXCXmVO2vSZ/O0fj00hMksixOd0aDPLWQTpFMlEXdlr/wHLTCsSxGH/paIyNT0FuQCVQ/XK6g9/3P1CPxjhIXLTdgqFcOIGMgCFW/wsLQIySqll7oZIBFRtb4tPXumZFbRh2V5HvZbSOoPSSpGbSBNLcS36aZoxVL2IxZi2pUZ5+j/AFl8B/9qiEtL4Dh/oiJej9s89cZ8NpQvmCqZeKvD2Nem6VsfIvj/KnAPIbpb2+X8LKvuf/43CRTLcfIBrKOXc1jgkeI3SSaTcz8vIdoeX8N/PjP8BypcTKeG0ELYiWZubvXR/aeCPuuVI23VVPfue45F0vK3g+9QsHo8XE/e2eJ1T6qUrajkada/erAkMDD07MWabeLVn3LqVKVAy3mKmwQFdpztXXefSbsfaVMSGr8111yR2k29NlgbPvzKR9+cG1XSsouEekXn3h3M/VKFt8KFFokVcXjqvCWnRA4IFAqaRcpOXW/QKU+H/vs9otnbWXV27R1ptc96ERP4s7KoXuh0pPLbheocns324MXA4n1Y+SThU1MgPi+djn+puVX3Ns81CFfaMGG59q1eKZhiPlyq4Z9TOkx1qiaEZSWTRqdp74FBI+WRCj+tZPloqfIfLG5Rapeen8q/crGos/5d0pFtZPin2eXaqm6FYnoxC7n8utsXNVQrpdng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261021133027099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(261021135927099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oWpqA5dEownNwQ79k9uNLFh1Wn0bizbb9YkSMcuQuWFrIYL3UG+PZ9d9sUgklw3Q47bgPIvuJDFSlvJI1IBRJW29TCaiYfV7H27JQ8itpNP5uPsK9TKUyrSV0jYhbxGPQr/NO4m1ZJrkVj1d195oAdvUdoOrfpj7Yje44hXnPhjL9C2NpZLLFx9hs5r+jcgJnROVWyZRZ2UnNj7K2TFmijPXtzYK4tfQhuTKG8jWAJipMJUSFMJFVivcjD6slMqy4Kj9+NAQFJro50zKj17dFD7OcsMIdvZobs8sN5LEjX01vqfoKJywkFa208znA2YJnPeKolHdZSw62tUomJzPLtS8JaosFB83RrJqURsrGV9TuXBXFbcJ6hq+o9cSYIwb0CPfLDCVnCUWjHB+LvF2LK37NwulboOjUXYRwLyFy++qOehd8egV8Ml3NNUrWvha
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:35:08.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d57bbc-b316-4bf8-fd69-08df31452133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001886A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Driver-side selftests for UALink bring-up: exercise the nHT firmware,
remote interrupts, remote TLB shootdown and remote VRAM access without
any userspace application.

Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
with these read/write entries:

  command          write the test name to run it, read to list the
                   valid test names
  remote_accel_id  accel_id of the remote GPU used by the tests
  test_size        test buffer size in bytes, from 4 to 4096
  local_test_data  the local ring buffer the remote GPU accesses
  remote_sdma      the remote GPU ring buffer, using sdma
  remote_lsdma     the remote GPU ring buffer, using lsdma

The data entries take and return binary data, a write shorter than
test_size is repeated to fill it, so formatting is left to userspace
tools like printf, xxd, od and cmp.

Add helper functions: ualink_test_local_data() and
ualink_test_remote_rw() for local and remote ring buffer R/W,
ualink_test_remote_shootdown() for TLB shootdown,
ualink_test_send_hello() for handshake,
ualink_test_update_interrupt_wb() and
ualink_test_update_shootdown_wb() to read writeback results.

v6: ring buffer wptr for itself is used for wptr, don't init to 0xdeadbeef
v5: Replace the four remote access commands with local_test_data,
    remote_sdma and remote_lsdma entries, to get the test data without
    looking at debug logs or using xxd with physical addresses (Felix).
    Dump and accept binary data, no parser in the driver (Felix).
    Stage the DMA in the local ring buffer instead of the IB, which is
    freed before the data is read back.
v4: Use a single "command" entry taking the test name, instead of one
    entry per test (Felix).
    Resync the remote wptr before sending a command, the peer may have
    rebooted.
v3: Replace the single entry taking a test number with a debugfs
    directory and a named entry per command.
    Take peer->lock to update the writeback address and selftest_mutex
    to read the test parameters.
v2: Fix typos and issues from copilot code review.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
 5 files changed, 628 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3dc95d9accf2..2d786639d081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+enum amdgpu_ualink_test_cmd {
+	UALINK_TEST_SW_INIT,
+	UALINK_TEST_SEND_HELLO,
+	UALINK_TEST_REMOTE_SHOOTDOWN,
+	UALINK_TEST_FLUSH_TLB,
+	UALINK_TEST_UPDATE_INTERRUPT_WB,
+	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
+	UALINK_TEST_LSDMA_SELFTEST,
+};
+
+/* commands talking to a remote accelerator, remote_accel_id must be set */
+#define UALINK_TEST_NEEDS_ACCEL_ID					\
+	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
+	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
+	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
+
+static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
+					  enum amdgpu_ualink_test_cmd cmd)
+{
+	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
+	int r = 0;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
+	    remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev, "set remote_accel_id first\n");
+		return -EINVAL;
+	}
+
+	adev->ualink.selftesting = true;
+
+	switch (cmd) {
+	case UALINK_TEST_SW_INIT:
+		if (adev->ualink.remote)
+			amdgpu_ualink_sw_fini(adev);
+
+		dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
+		r = amdgpu_ualink_sw_init(adev);
+		break;
+	case UALINK_TEST_SEND_HELLO:
+		r = ualink_test_send_hello(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_REMOTE_SHOOTDOWN:
+		r = ualink_test_remote_shootdown(adev, remote_accel_id, 1UL << 30,
+						 1, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_FLUSH_TLB:
+		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_UPDATE_INTERRUPT_WB:
+		r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
+		r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_LSDMA_SELFTEST:
+		r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
+		break;
+	}
+
+	adev->ualink.selftesting = false;
+
+	dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret %d\n",
+		cmd, remote_accel_id, r);
+
+	return r;
+}
+
+#define UALINK_TEST_CMD_NAME_MAX	32
+
+static const char * const amdgpu_ualink_test_cmd_name[] = {
+	[UALINK_TEST_SW_INIT]			= "sw_init",
+	[UALINK_TEST_SEND_HELLO]		= "send_hello",
+	[UALINK_TEST_REMOTE_SHOOTDOWN]		= "remote_shootdown",
+	[UALINK_TEST_FLUSH_TLB]			= "flush_tlb",
+	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= "update_interrupt_wb",
+	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= "update_shootdown_wb",
+	[UALINK_TEST_LSDMA_SELFTEST]		= "lsdma_selftest",
+};
+
+static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
+						  char __user *ubuf,
+						  size_t len, loff_t *offp)
+{
+	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
+		n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
+			       amdgpu_ualink_test_cmd_name[i]);
+
+	return simple_read_from_buffer(ubuf, len, offp, buf, n);
+}
+
+static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
+						   const char __user *ubuf,
+						   size_t len, loff_t *offp)
+{
+	struct amdgpu_device *adev = file->private_data;
+	char buf[UALINK_TEST_CMD_NAME_MAX];
+	int cmd, r;
+
+	if (len >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
+	if (cmd < 0) {
+		dev_err(adev->dev, "unknown ualink test command\n");
+		return cmd;
+	}
+
+	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
+	if (r)
+		return r;
+
+	return len;
+}
+
+static const struct file_operations amdgpu_ualink_command_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = simple_open,
+	.read	 = amdgpu_debugfs_ualink_command_read,
+	.write	 = amdgpu_debugfs_ualink_command_write,
+	.llseek	 = default_llseek,
+};
+
+/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
+enum amdgpu_ualink_test_buf {
+	UALINK_BUF_LOCAL,
+	UALINK_BUF_REMOTE_SDMA,
+	UALINK_BUF_REMOTE_LSDMA,
+};
+
+static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device *adev,
+					   enum amdgpu_ualink_test_buf buf,
+					   u32 *data, u32 size, bool read)
+{
+	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
+	int r;
+
+	if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev, "set remote_accel_id first\n");
+		return -EINVAL;
+	}
+
+	adev->ualink.selftesting = true;
+
+	if (buf == UALINK_BUF_LOCAL)
+		r = ualink_test_local_data(adev, remote_accel_id, data, size, read);
+	else
+		r = ualink_test_remote_rw(adev, remote_accel_id, data, size, read,
+					  buf == UALINK_BUF_REMOTE_LSDMA);
+
+	adev->ualink.selftesting = false;
+
+	return r;
+}
+
+static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
+					       char __user *ubuf, size_t len,
+					       loff_t *offp,
+					       enum amdgpu_ualink_test_buf buf)
+{
+	struct amdgpu_device *adev = file->private_data;
+	ssize_t ret;
+	u32 size;
+	void *data;
+	int r;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	size = adev->ualink.test_size_dwords * 4;
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
+	ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, size);
+
+	kfree(data);
+
+	return ret;
+}
+
+static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
+						const char __user *ubuf,
+						size_t len, loff_t *offp,
+						enum amdgpu_ualink_test_buf buf)
+{
+	struct amdgpu_device *adev = file->private_data;
+	u32 i, size;
+	void *data;
+	int r;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	size = adev->ualink.test_size_dwords * 4;
+
+	if (!len)
+		return -EINVAL;
+
+	len = min_t(size_t, len, size);
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (copy_from_user(data, ubuf, len)) {
+		kfree(data);
+		return -EFAULT;
+	}
+
+	/* repeat a short pattern to fill the test size */
+	for (i = len; i < size; i += len)
+		memcpy(data + i, data, min_t(u32, len, size - i));
+
+	r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, false);
+
+	kfree(data);
+
+	return r ? r : len;
+}
+
+#define UALINK_TEST_DATA_ATTR(name, buf)				\
+static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file *file,	\
+		char __user *ubuf, size_t len, loff_t *offp)		\
+{									\
+	return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, buf); \
+}									\
+static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file *file,	\
+		const char __user *ubuf, size_t len, loff_t *offp)	\
+{									\
+	return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, buf); \
+}									\
+static const struct file_operations amdgpu_ualink_##name##_fops = {	\
+	.owner	 = THIS_MODULE,						\
+	.open	 = simple_open,						\
+	.read	 = amdgpu_debugfs_ualink_##name##_read,			\
+	.write	 = amdgpu_debugfs_ualink_##name##_write,		\
+	.llseek	 = default_llseek,					\
+}
+
+UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
+UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
+UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
+
+static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	*val = adev->ualink.test_remote_accel_id;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (!adev->ualink.info)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	if (val >= AMDGPU_UALINK_ACCEL_MAX ||
+	    !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
+		dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
+		return -EINVAL;
+	}
+
+	if (val == adev->ualink.info->ppod.accel_id) {
+		dev_err(adev->dev, "remote accel_id equals to local accel_id\n");
+		return -EINVAL;
+	}
+
+	adev->ualink.test_remote_accel_id = val;
+	dev_info(adev->dev, "set remote accel_id to %llu, local accel_id %u\n",
+		 val, adev->ualink.info->ppod.accel_id);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
+			 amdgpu_debugfs_ualink_accel_id_get,
+			 amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
+
+static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	*val = adev->ualink.test_size_dwords * 4;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	adev->ualink.test_size_dwords = val / 4;
+	dev_dbg(adev->dev, "test buffer size %u bytes\n",
+		adev->ualink.test_size_dwords * 4);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
+			 amdgpu_debugfs_ualink_test_size_get,
+			 amdgpu_debugfs_ualink_test_size_set, "%llu\n");
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
+	struct dentry *ualink_test;
 	struct dentry *ent;
 	int r, i;
 
@@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
 			     &adev->ualink.drop_msg_bitmap);
 
+	mutex_init(&adev->ualink.selftest_mutex);
+	/* 64 bytes test size by default */
+	adev->ualink.test_size_dwords = 16;
+	adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
+
+	ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
+	debugfs_create_file("command", 0600, ualink_test, adev,
+			    &amdgpu_ualink_command_fops);
+	debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
+			    &amdgpu_ualink_accel_id_fops);
+	debugfs_create_file("test_size", 0600, ualink_test, adev,
+			    &amdgpu_ualink_test_size_fops);
+	debugfs_create_file("local_test_data", 0600, ualink_test, adev,
+			    &amdgpu_ualink_local_test_data_fops);
+	debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
+			    &amdgpu_ualink_remote_sdma_fops);
+	debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
+			    &amdgpu_ualink_remote_lsdma_fops);
+
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 05bc281216bf..1f83d9b69135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 	mutex_unlock(&adev->lsdma.lock);
 	return ret;
 }
+
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
+{
+	struct amdgpu_ib ib;
+	int i, r;
+	u64 gpu_addr;
+	char *p;
+	u32 size = 128;
+
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r)
+		return r;
+
+	gpu_addr = ib.gpu_addr;
+	p = (char *)ib.ptr;
+	memset(p, 0, 2 * size);
+
+	for (i = 0; i < size; i++)
+		*(p + i) = i;
+
+	dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
+		gpu_addr, gpu_addr + size, size);
+
+	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
+	if (r)
+		goto out;
+
+	p += size;
+	for (i = 0; i < size; i++) {
+		if (*(p + i) != i) {
+			dev_dbg(adev->dev, "data mismatch expecting 0x%x but read 0x%x\n",
+				i, *(p + i));
+			break;
+		}
+	}
+	if (i != size)
+		r = -EIO;
+
+out:
+	amdgpu_ib_free(&ib, NULL);
+
+	if (r)
+		dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
+	else
+		dev_dbg(adev->dev, "lsdma selftest passed\n");
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 34e92aaa4617..f0a5eeb3529f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 			  uint32_t data, uint64_t mem_size);
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 339f639a450e..86e0dc8d728e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -39,8 +39,6 @@ static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
-static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
-				    u32 flush_type);
 static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
 						struct amdgpu_bo *bos[], u32 n_bos,
 						struct drm_exec *exec,
@@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
  * UALink remote interrupt and shootdown
  */
 
-/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
-#define AMDGPU_UALINK_RB_SIZE	4096
-
 #define AMDGPU_UALINK_METADATA_HEADER	0x4E485446
 
 /* 2MB NPA start address for 2MB page mapping */
@@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
 }
 
-static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
+void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 {
 	u32 bit;
 
@@ -5281,7 +5276,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
-		return -ENODEV;
+		if (!adev->ualink.selftesting)
+			return -ENODEV;
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
@@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	r = adev->ualink.msg_ctl->send_metadata(adev,
 						    remote->metadata_gpu_addr,
 						    AMDGPU_UALINK_ACCEL_MAX << 8);
+	if (r && adev->ualink.selftesting)
+		r = 0;
 
 out:
 	if (r)
@@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
-int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+/* byte offset of the local interrupt ring a remote GPU writes to */
+static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
+{
+	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
+
+	/* remote shootdown ring is first, remote interrupt ring follows it */
+	return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
+}
+
+/*
+ * ualink_test_local_data - read or write the local ring buffer of a remote GPU
+ *
+ * The local ring buffer is partitioned per remote GPU, @remote_accel_id selects
+ * the interrupt ring that remote GPU writes to through its NPA mapping. Read it
+ * to see what the remote GPU wrote, write it to provide the data it reads.
+ */
+int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
+			   void *data, u32 size, bool read)
 {
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	void *rb;
+
+	if (!remote || !remote->rb_cpu_addr)
+		return -EINVAL;
+
+	if (size > AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	rb = remote->rb_cpu_addr + ualink_test_local_rb_offset(remote_accel_id);
+
+	dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 0x%x\n",
+		read ? "read" : "write", remote_accel_id, rb, size);
+
+	if (read)
+		memcpy(data, rb, size);
+	else
+		memcpy(rb, data, size);
+
+	return 0;
+}
+
+/*
+ * ualink_test_remote_rw - read or write the remote GPU ring buffer
+ *
+ * Copy @size bytes between @data and the remote GPU ring buffer NPA address
+ * using lsdma or sdma. The DMA engines cannot access @data, the local ring
+ * buffer of the same remote GPU is used to stage it, so local_test_data shows
+ * what was sent or received.
+ *
+ * Works with or without MPNHT FW running, the copy does not update wptr and
+ * does not ring the doorbell.
+ */
+int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
+			  void *data, u32 size, bool read, bool use_lsdma)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u64 npa, local;
+	u32 offset, ndw;
+	int r;
+
+	if (!remote)
+		return -EINVAL;
+
+	if (size > AMDGPU_UALINK_RB_SIZE)
+		return -EINVAL;
+
+	peer = &remote->peer[remote_accel_id];
+	ring = &peer->interrupt;
+
+	guard(mutex)(&peer->lock);
+
+	offset = ualink_test_local_rb_offset(remote_accel_id);
+	local = remote->rb_gpu_addr + offset;
+	npa = ring->rb_npa_gart;
+
+	if (!read)
+		memcpy(remote->rb_cpu_addr + offset, data, size);
+
+	remote->use_lsdma = use_lsdma;
+
+	dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 0x%x use %s\n",
+		read ? "read" : "write", remote_accel_id, npa, local, size,
+		use_lsdma ? "lsdma" : "sdma");
+
+	if (use_lsdma) {
+		r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
+					  read ? local : npa, size);
+		if (r)
+			return r;
+
+		goto done;
+	}
+
+	/* sdma linear copy command, align to 8 dwords boundary */
+	ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+
+	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
+	if (r)
+		return r;
+
+	ib = job->ibs;
+	ib->length_dw = 0;
+
+	amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
+				read ? local : npa, size, 0);
+	amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
+	WARN_ON(ib->length_dw > ndw);
+
+	fence = amdgpu_job_submit(job);
+
+	r = dma_fence_wait_timeout(fence, false, HZ * 10);
+	dma_fence_put(fence);
+	if (r <= 0) {
+		dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
+		dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
+		remote->use_lsdma = true;
+		return -ETIME;
+	}
+
+done:
+	if (read)
+		memcpy(data, remote->rb_cpu_addr + offset, size);
+
+	return 0;
+}
+
+/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
+ * wptr before sending a command, same as the handshake does.
+ */
+static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev->ualink.remote)
+		return -EINVAL;
+
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
+	if (r < 0)
+		return r;
+
+	/* Peer moved, drop ready so the next command updates the wb address */
+	if (r)
+		amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
+
+	return 0;
+}
+
+int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
 	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
 }
 
+int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
+				 u64 addr, u32 size_in_pages, u32 flush_type)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
+					      size_in_pages, flush_type);
+}
+
+int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
+
+	/* Update interrupt completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_REMOTE_INTERRUPT);
+	return r;
+}
+
+int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_test_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
+
+	/* Update shootdown completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_TLB_INV);
+	return r;
+}
+
 /*
  * The low bits of handle_lo carry the message-header field on the wire.
  * Strip those bits and splice in @acc_id to recover the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..90e90cd8b495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
 	enum amdgpu_ualink_conn_state state;
 };
 
+/* UALINK ring buffer size, same for both remote shootdown and interrupt ring */
+#define AMDGPU_UALINK_RB_SIZE	4096
+
 struct amdgpu_ualink_remote;
 
 struct amdgpu_ualink_msg_ctl {
@@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* true for selftest driver path, ignore FW error */
+	bool selftesting;
+	/* serialize the selftest debugfs entries */
+	struct mutex selftest_mutex;
+	u32 test_size_dwords;
+	u32 test_remote_accel_id;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
@@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
 	unsigned long drop_msg_bitmap;
 };
 
+int ualink_test_local_data(struct amdgpu_device *adev, u32 remote_accel_id,
+			   void *data, u32 size, bool read);
+int ualink_test_remote_rw(struct amdgpu_device *adev, u32 remote_accel_id,
+			  void *data, u32 size, bool read, bool use_lsdma);
+int ualink_test_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id,
+				 u64 addr, u32 size_in_pages, u32 flush_type);
+int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
 				 unsigned int client_id, unsigned int src_id);
-
+void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type);
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
-int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
-
 int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
 int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
 int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
-- 
2.50.1

