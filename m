Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B3BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 07:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E251910F078;
	Tue, 29 Mar 2022 07:39:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C6A10F078
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 07:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXbKmVSGTo98g3dM0JYNLLJ6Uk+jiABqvR4yS8ii81GpVrUTbfma7BqzOwt1wamvwD0bMLhva5zGjdO1+3pxDPyOwwK4SFrZ2XIAsq4AHMIz9aFc0kzORYjEdn/lLO4fWfyseqf11EdITO/yiWoXBPnYFE/F4XxfB08wNiGksUahWYnhM0t5lwPJqFo/KE9D5wnAGfRDGxWwlQiu5uxuf0ngY730N5jcn0rTQOBjFbMSMsxGM+xEyyulJaCSQ8AMgwFqSt4e47c161303NUOzsAcXY+49W68Ljw625TScLweobW3+yQofYJB5tQGueF3Orx7SfyxRTDGmefYux+8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjnypqf17gKmeFXFKe0hSQE7BqTOylfZLVyi6EVhu/s=;
 b=M1LFN243dQHrZ7musR6q0hDkEejEnI/j7J6vWygqvotYcHW6/a/o24BFlZrPP4XYY1OkpDnPhfyecA1kmS9MLUok5+FYokZX9+tICCCcORyBuJjPBb1Mnc903BozvWoVx/rKIUaK87azTZ/3PULQUs49CPcoKky+ke8PrSN9b8OZ52ghzAx0JIWuB+3IFltDazsHq98S/fxm1jMvfJhbrR9af9ng8k8AYrEmfv9xKNYN2CtLm6V1Xklm3v0kUYj1m+u/QJLRFpwcGsw+TKaVQfWyRXo+hVLonADNIvWbOI2Mo7E5i4zNuUw3RqiJSYGPoJ7vlykm7FyjvkrDFggsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjnypqf17gKmeFXFKe0hSQE7BqTOylfZLVyi6EVhu/s=;
 b=N0yRIfr4yf4fYYB5QL94gUV5u1u31Z1vrvLyBpLGPNAvu36He3df/MqT0GBusaf9TDCD3YW1/tvXxvjOlmExikY+BntXqZobif0lQoSrYvjy6FPuCUqQaL/k9f3v35Vk9NwBVCIUr4NSy3dZhINTomcD10ZnSkl0io3VikaziZE=
Received: from BN9PR03CA0861.namprd03.prod.outlook.com (2603:10b6:408:13d::26)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 07:39:13 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::fe) by BN9PR03CA0861.outlook.office365.com
 (2603:10b6:408:13d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Tue, 29 Mar 2022 07:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 07:39:13 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 02:39:09 -0500
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Date: Tue, 29 Mar 2022 15:38:43 +0800
Message-ID: <20220329073843.772795-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91170575-5cc2-42a4-5e48-08da11573881
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB446951E4ACC5E9CA6C4F9767FC1E9@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqZZapCCF8/i3kgeIWaHzPb4VQmU0g9l0GjXeokuBGkxQE+T7wcuwoVk+gjhbEqXjn46H0+053IMk4i3At3Z0ywZS9oWCaB6AG6ULeO1tMBiUaqUCh8niZvzDhoWjeU5fxYM0iM7T9mS72kbcdqecLhp5BIxeDk6lI6Zuii8yNSO3lTqgBDIpgQPSp61kCjSWSSNiYDiphn/UjLCmoh5LaMMYL2FkIbGFbf7p8pllZA7+YCS6B5Yh6KPO330c/dKuiL7FHDVlMWoVL3Zoc4kMhxVoF4IwqPGe6Ih2dqNbD/qquzPGV16UbCK8HAFKaPTEa02upcUc2WLLtGhv/sJLvUYCEYCTj3n4QCouH1u4gR/ZSyzNoUfzOy8zckUB5NE23ci1wfkhmkSROv8gl32VUSlrx+4J1QEk/qTkZjdgbs05Oigfl5bZzJZDOfei2LakzqYuD3aLmMHbL+S1Ji4hoDivZcpZVm4UdHCln2DP+MJJd8KRQtdIgX9fLN35t4z67xlQn+bpSA8AHqJy4Bip400VsCwCla5tC5M3Isa8HWOj+QEip57CfglX3r3zmf/iUdxbPks4Ty2yFjAhqGUFagDCfg3uOQaGBQBG/Pxz0xpoPsAZN5K3ZkYJTB44TiDJBS4OiJZkyKQvqZIOqd0W//Phair+P+jrvuEqWQlL9p0WUqzTpmlJgszJxx/GONPcN4QbNS0rtouLyyL4qJLBO5uBB5eslCmeVvq3JJUszs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(86362001)(36860700001)(316002)(426003)(6916009)(36756003)(54906003)(186003)(1076003)(16526019)(2906002)(336012)(2616005)(26005)(40460700003)(81166007)(356005)(5660300002)(4326008)(7696005)(8936002)(83380400001)(6666004)(8676002)(47076005)(70206006)(82310400004)(70586007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:39:13.3394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91170575-5cc2-42a4-5e48-08da11573881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some AMDGPU RAS debugfs operations like UE injection
can cause gpu reset. Before doing the next debugfs
operation, the application should call poll to check
if the gpu has finished recovering.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4bbed76b79c8..337e3e247a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -452,6 +452,12 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 
 		/* data.inject.address is offset instead of absolute gpu address */
 		ret = amdgpu_ras_error_inject(adev, &data.inject);
+
+		if (!ret && (data.head.type == AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE)) {
+			struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+			con->ras_ue_injected = 1;
+		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -464,6 +470,30 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 	return size;
 }
 
+/**
+ * DOC: Support AMDGPU RAS debugfs poll interface
+ *
+ * Some AMDGPU RAS debugfs operations like UE injection
+ * can cause gpu reset. Before doing the next debugfs
+ * operation, the application should call poll to check
+ * if gpu is in recovering status.
+ */
+static __poll_t amdgpu_ras_debugfs_ctrl_poll(struct file *f, struct poll_table_struct *wait)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	__poll_t mask = 0;
+
+	/* For UE injection, wait for gpu to finish recovery */
+	if (con->ras_ue_injected)
+		poll_wait(f, &con->gpu_ready_wait_wq, wait);
+
+	if (!atomic_read(&con->in_recovery))
+		mask = EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
 /**
  * DOC: AMDGPU RAS debugfs EEPROM table reset interface
  *
@@ -503,6 +533,7 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
 
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
 	.owner = THIS_MODULE,
+	.poll = amdgpu_ras_debugfs_ctrl_poll,
 	.read = NULL,
 	.write = amdgpu_ras_debugfs_ctrl_write,
 	.llseek = default_llseek
@@ -1837,6 +1868,11 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	if (amdgpu_device_should_recover_gpu(ras->adev))
 		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
+
+	if (ras->ras_ue_injected) {
+		ras->ras_ue_injected = 0;
+		wake_up_all(&ras->gpu_ready_wait_wq);
+	}
 }
 
 /* alloc/realloc bps array */
@@ -2279,7 +2315,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
 	atomic_set(&con->ras_ce_count, 0);
 	atomic_set(&con->ras_ue_count, 0);
-
+	init_waitqueue_head(&con->gpu_ready_wait_wq);
 	con->objs = (struct ras_manager *)(con + 1);
 
 	amdgpu_ras_set_context(adev, con);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 606df8869b89..aea6bbb71501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -379,6 +379,12 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* UE injection flag */
+	uint32_t  ras_ue_injected;
+
+	/* Waiting for gpu ready work queue */
+	wait_queue_head_t gpu_ready_wait_wq;
 };
 
 struct ras_fs_data {
-- 
2.25.1

