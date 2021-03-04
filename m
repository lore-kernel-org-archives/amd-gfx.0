Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B064EF9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B064EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656EF6E9FA;
	Thu,  4 Mar 2021 07:40:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47BB6E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXjsWQCtoeeEJgWhdg44QTC9dwqhQcT38w1UiVy3yAFkP1WO5moYdrDqBcSp0eq0axeKjvrxlEAB30qOWHnxN6LNBaGzbLoExeZ6N87JVm5orpGe23UYTb0gjmxWvQCYNnLMJYhvM5aAjkTYjZIj/kZ52Fldhjuky1KRDLWBraXbeRhHz/ARWFswIEWoQovyqyVBo8zsq45ZDgfdG+cgFBJLC3KzQ+CR/RyHlMMNikxiKx8XTEzG3aJIlwkwjw5G5ITsDYlY0bRb+6lik7S9HUuGd+my/EQAlV0k3ctHSxBbxmbM5XyKWaDDyLfW7tVzBOKfy6PbUvqQjYFlZ2xYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r47qNPd468Ip/RH5j9KunvP6TmnD73ya8ZaFP7wCSHU=;
 b=Ldjbx+tyzf8hO/AA1zeAFi4zYvTLDOU/fuuer46W2FXy22vgAP6wlxo02jpH8seJMx2QO6auEhbNn3ix1pg0xAYF46semY2VWxBk/sjIgwmB0HxxxmszGKkVxIzpMlCdWYBy1yDN9ObIkWdvkR1x0Dc6ILfH1TxGeBzw/eQSxJBaQy/AuFzUYnb7ReGoUWCrse/v2mhW1VAwGTTrUYUIYKS+Q+M8owN1C8DoAcJaWvbjFTFULFhe06RGLmCvY6TM0d0thbRwTkLGVV0wOKHYAcGVwErjr13ldhpfplTGWi8wR2WmuCdvf2W4Myetqls6ackaGItGZL0EhVgh/JJ68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r47qNPd468Ip/RH5j9KunvP6TmnD73ya8ZaFP7wCSHU=;
 b=3uyTFH7TyRTaOXzUtlhrLfcLWDAHo8XdHyzE142jgHs7Aj6G5HwN3Lrjb/7e8tgAIRN8Kf3tlshhOIykomzR9rcp+FrhM2B883qP5xBpWHOOgwp0jvMCPRFvNOAgEeXdA0k+lYNIU1wvHH+Pp3IGA9G6//TnKEwYHR3/pyK5ntk=
Received: from BN6PR22CA0050.namprd22.prod.outlook.com (2603:10b6:404:ca::12)
 by BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 07:39:58 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::33) by BN6PR22CA0050.outlook.office365.com
 (2603:10b6:404:ca::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 07:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 07:39:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 01:39:56 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 01:39:56 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 4 Mar 2021 01:39:55 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sdma 4_x interrupts printing
Date: Thu, 4 Mar 2021 15:39:53 +0800
Message-ID: <20210304073953.51400-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52487dff-1c68-4262-86b3-08d8dee0b586
X-MS-TrafficTypeDiagnostic: BN8PR12MB3330:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33305CFDBC3654F6BBD1D163FE979@BN8PR12MB3330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bgckC4OI+oXkPhnzvmM1HYQPZalFp9uJYD394vkGbPBVl+1RQfurQtUNMaTKUmwxj+jUSf9M5ZPrCYxSn9REbz0rvtIX5CA2M0xXLtfK9Kkxy4kUZsuEP7UkNUkgwPTiMpNkIAuCjtkwwfdzvs7Ldj7Oo/APdCoVmP7axm/3bNr75Vf898o1fr4BJNpz4Q+Arrx+xORRkbY3jLatc59lHD7LFvVBK7nPmKfZVjCWIWCNYYKyZv9xvHxwNHtjJhuTmYx0TzGjh/1e7Lx9WjjPykQqmjLWmPxrdwkTZu3Vuzugd5rhappqU/NYVWrvbdOqQFL4gRhpo8Sncz/CVQ7RzEolrbCxbTbNhfUGSFl5AJZN3JZZUwT0VpN4XMwUl2pvxoz/DKNN7blDHLkaiQjOg924Z9NHBihs1TWOhHFC1TVWWMUdI22BjKzjvBRtD5JLh/yOhkm54dqwAElHbwF7tvVrIjuLqQC3j5wWtn8rtzOG8nT4F2wx7qEsCqhvzch/u5DXVQMbC5tiLNYpf5BaZPzx2wqLQoS2U9NIVpRFgYowiERD1JPzlTnaHorT3lKTFmFpm9UGR5B5ZpWWN4DTsGDI9ZnSUGL8Ml/RsRWSFGBeTXRNrDCM/V+7pjV+leBODx8hdxGgiJWoWMGUrPbILnottlZwfqHNqNOu+E5Ek7VjRoso+1vm6hZsnIgfuY9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(356005)(316002)(2906002)(82310400003)(86362001)(26005)(8676002)(7696005)(8936002)(36860700001)(47076005)(70586007)(54906003)(70206006)(36756003)(2616005)(6916009)(1076003)(4326008)(336012)(478600001)(5660300002)(83380400001)(82740400003)(81166007)(186003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:39:57.2008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52487dff-1c68-4262-86b3-08d8dee0b586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3330
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add VM_HOLE/DOORBELL_INVALID_BE/POLL_TIMEOUT/SRBMWRITE
interrupt info printing.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   5 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 119 +++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e5b8fb8e75c5..f8fb755e3aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -64,6 +64,11 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	trap_irq;
 	struct amdgpu_irq_src	illegal_inst_irq;
 	struct amdgpu_irq_src	ecc_irq;
+	struct amdgpu_irq_src	vm_hole_irq;
+	struct amdgpu_irq_src	doorbell_invalid_irq;
+	struct amdgpu_irq_src	pool_timeout_irq;
+	struct amdgpu_irq_src	srbm_write_irq;
+
 	int			num_instances;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 70d247841d14..bcf3d62e3cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1944,6 +1944,33 @@ static int sdma_v4_0_sw_init(void *handle)
 			return r;
 	}
 
+	/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
+				      &adev->sdma.vm_hole_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_DOORBELL_INVALID,
+				      &adev->sdma.doorbell_invalid_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_POLL_TIMEOUT,
+				      &adev->sdma.pool_timeout_irq);
+		if (r)
+			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_0_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_SRBMWRITE,
+				      &adev->sdma.srbm_write_irq);
+		if (r)
+			return r;
+	}
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
@@ -2198,6 +2225,72 @@ static int sdma_v4_0_set_ecc_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
+					      struct amdgpu_iv_entry *entry)
+{
+	int instance;
+	struct amdgpu_task_info task_info;
+	u64 addr;
+
+	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0 || instance >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		return -EINVAL;
+	}
+
+	addr = (u64)entry->src_data[0] << 12;
+	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
+	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+
+	dev_info(adev->dev,
+		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
+		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+		   entry->pasid, task_info.process_name, task_info.tgid,
+		   task_info.task_name, task_info.pid);
+	return 0;
+}
+
+static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev, "MC or SEM address in VM hole\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,
+		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
+static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	dev_err(adev->dev,
+		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
+	sdma_v4_0_print_iv_entry(adev, entry);
+	return 0;
+}
+
 static void sdma_v4_0_update_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
 		bool enable)
@@ -2503,7 +2596,21 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_ecc_irq_funcs = {
 	.process = amdgpu_sdma_process_ecc_irq,
 };
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_vm_hole_irq_funcs = {
+	.process = sdma_v4_0_process_vm_hole_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_doorbell_invalid_irq_funcs = {
+	.process = sdma_v4_0_process_doorbell_invalid_irq,
+};
 
+static const struct amdgpu_irq_src_funcs sdma_v4_0_pool_timeout_irq_funcs = {
+	.process = sdma_v4_0_process_pool_timeout_irq,
+};
+
+static const struct amdgpu_irq_src_funcs sdma_v4_0_srbm_write_irq_funcs = {
+	.process = sdma_v4_0_process_srbm_write_irq,
+};
 
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 {
@@ -2515,10 +2622,18 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	case 5:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
 		break;
 	case 8:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
+		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		break;
 	case 2:
 	default:
@@ -2529,6 +2644,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->sdma.trap_irq.funcs = &sdma_v4_0_trap_irq_funcs;
 	adev->sdma.illegal_inst_irq.funcs = &sdma_v4_0_illegal_inst_irq_funcs;
 	adev->sdma.ecc_irq.funcs = &sdma_v4_0_ecc_irq_funcs;
+	adev->sdma.vm_hole_irq.funcs = &sdma_v4_0_vm_hole_irq_funcs;
+	adev->sdma.doorbell_invalid_irq.funcs = &sdma_v4_0_doorbell_invalid_irq_funcs;
+	adev->sdma.pool_timeout_irq.funcs = &sdma_v4_0_pool_timeout_irq_funcs;
+	adev->sdma.srbm_write_irq.funcs = &sdma_v4_0_srbm_write_irq_funcs;
 }
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
