Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DCC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9BF61042
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C9BF61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956D06E9FB;
	Fri, 20 Aug 2021 05:33:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E906E9FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 05:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK7SXj05SDaEx3A0s8CtLVEuqxfPDvo7vTz36esCLDeG08jLiMlfaShqCrs1Ujezvr+uoO2TVUn7QrdA43ypjyHoFaLUu6FPNstReuGyXVkESWTHbubMI3F4z2mqTCOGFRyUpDNauVSimGUguF1TB0NCwHrho8h4Qu1FLu/WaEN045x/6uzC1/Yecv4LbvUsI1J4RuFF5Ygb2uk0o2/fA5xRWuwI4CNx0eM/ew8Y8hBGk0VPaGpmM+G7n6vZPCPWja+CMF2rAMjrpEpE+WZ/Go1kCnHAdS4dbwCw1HVKgbiJk6FMC3VIBq/pmito7yKwQ1+Sl1hliXZF9EopVXoycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QRuHXirLv3E0/UAytSIEpMmuCHsT3KgoANv+55zncE=;
 b=iLgchaiNbk17KCflM49ypK3lEdSOGcn+VzDPSCGSbi1NfYba4BsTjfN2P5m3ct2TUhdWSfqXhFM2hc8h5JMcaCfa2f5xobHMxR2HzuB5RqXz6Usc1d5ZZqz4h8GIUbBhNxqgQvRgupOyzdJnnP+0azAEKpUgoAtnrqXbCn6pg7G/7ZU1ZPAopPSjqhjsmyhyWbgxr9dB6OfHdaQgRq4vOGptUthDCcL5F5aNjSW7SY/PNiJDNiEP6nC9e43frjSLje9jzPUsVETXhM2sSBXCh7mNE+9OAsYgu8PvhXJ3wZQSw5L19w7WyGGW4TGNQZwehYLdR87R27oJPYEktPaVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QRuHXirLv3E0/UAytSIEpMmuCHsT3KgoANv+55zncE=;
 b=BPXBICMGfYshj+O3g9aPobqvHiDNyLmT5RaSSHrsTUOn6XrAco+bu9ObErK7ewNj0cc6wapvGF+aWfV5gZqLRRg1JN1/ndR8PFMEIzbIPdd96pmr/ueyutOMCfJ01qVz76Eofb2c5+sdrlxfB2ZbcQy6Yg0A18O2E1tfq+vgEuY=
Received: from MWHPR21CA0033.namprd21.prod.outlook.com (2603:10b6:300:129::19)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 05:33:08 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::bf) by MWHPR21CA0033.outlook.office365.com
 (2603:10b6:300:129::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.0 via Frontend
 Transport; Fri, 20 Aug 2021 05:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 05:33:07 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 00:33:06 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Joseph Greathouse <Joseph.Greathouse@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Spread out XGMI SDMA allocations
Date: Fri, 20 Aug 2021 00:32:45 -0500
Message-ID: <20210820053245.340945-3-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be10cdca-4624-403b-c96c-08d9639bfdd4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408CD2D1AED9E74AD6F2791F9C19@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPFKmyGGYekWY6Qzo2v5Fff2KRIFYbD5vcxB38imUbLFqrIthPEi6+mXopIrjavTGUrupD3oRzXoERzqzqrdpEJDzfkH+TBRUYF5XZuz/Nlna8PwhgZ8JS3lAAKQK2p34Bu9MzNYC07FfLzbSp4qp06+M3O9VYg6gWa/+Bf3DDfEAryZzbwo1E8RyTUxvI/XWSsgB3iDVNVLvrYfKzjGB1vH430ORtPmbvuAFMmftdIe0eJnRPpMK39nWu2Hn7uOMMSDbiQ2LaGJSTIPQUo1ZCCaTQWMdZob2tZjDSMLdNUKFkg00OHE4gA8mRXR33bB0rAi03cja7UqlI2d9yUhMFHPkA52kWVI/8dc3ehtxmofHOGSBSsxPnZs9Oavxy8Ju28Y6XkLRkdOF0zpPRpuAIKC4NkK4itiUNRkZtWC1lluV5gsPvv/NB7Cy2bPD6DhqqDUpDv2KOt2xZVMAXRCTco+ejgHbEJ3PcUum3bBgr/IOrsWJByts155V8vqLQkJ8+3oOjzHlfkLRZObzJYunvjDOEvkTh0SEeGRZjNHZZFxZqiaeE6LAXII6dtfuBD6sYiuLAG8/2MczAzwflE6OXRLpfocM3WSNx+HsQiFN0ZeZtCZfw2xsrWN7OfcMx+UsMtdNyCJ9j9WuimRnfWAX3ZgjVXBOuIpLTLmvmTS2EO1IHtnrygJ4RkwW1Lgp5MWVfsu0XBihrLhbmjioNV+8jDRuCciLUyea1OKAEjd4FOnCXi4ucK58is3uNb1X7ZgUe585XGluzSW7wETFzJsuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(36860700001)(36756003)(83380400001)(426003)(2906002)(6916009)(70206006)(82740400003)(5660300002)(34020700004)(26005)(86362001)(478600001)(2616005)(7696005)(8936002)(70586007)(16526019)(47076005)(81166007)(336012)(4326008)(356005)(8676002)(186003)(82310400003)(1076003)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 05:33:07.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be10cdca-4624-403b-c96c-08d9639bfdd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Avoid hotspotting of allocations of SDMA engines from the
XGMI pool by making each process attempt to allocate engines
starting from the engine after the last one that was allocated.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86bdb765f350..7f06ad6bdcd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1096,9 +1096,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			return -ENOMEM;
 		}
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+		if (qpd->initial_xgmi_engine == -1)
+			qpd->initial_xgmi_engine = dqm->next_xgmi_engine;
 		num_engines = get_num_xgmi_sdma_engines(dqm);
 		for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap), num_engines) {
-			available_queue_bitmap = sdma_engine_mask(engine, num_engines);
+			available_queue_bitmap = sdma_engine_mask(
+					qpd->initial_xgmi_engine + engine, num_engines);
 			available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
 
 			if (!available_queue_bitmap)
@@ -1109,6 +1112,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
 			found_sdma = true;
 
+			dqm->next_xgmi_engine = qpd->initial_xgmi_engine + engine + 1;
+			dqm->next_xgmi_engine %= num_engines;
+
 			bit = __ffs64(available_queue_bitmap);
 			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
 			q->sdma_id = bit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c8719682c4da..b5955e7401e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -183,6 +183,8 @@ struct device_queue_manager {
 	unsigned int		*allocated_queues;
 	uint64_t		sdma_bitmap;
 	uint64_t		xgmi_sdma_bitmap;
+	/* which XGMI engine the next process should attempt to start on */
+	unsigned int		next_xgmi_engine;
 	/* the pasid mapping for each kfd vmid */
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c38eebc9db4d..bcf56280c7ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -578,6 +578,7 @@ struct qcm_process_device {
 	unsigned int queue_count;
 	unsigned long sdma_engine_bitmap;
 	unsigned long xgmi_sdma_engine_bitmap;
+	int initial_xgmi_engine;
 	unsigned int vmid;
 	bool is_debug;
 	unsigned int evicted; /* eviction counter, 0=active */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 13c85624bf7d..24ce1b52a1d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1449,6 +1449,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->qpd.mapped_gws_queue = false;
 	pdd->qpd.sdma_engine_bitmap = BIT_ULL(dev_info->num_sdma_engines) - 1;
 	pdd->qpd.xgmi_sdma_engine_bitmap = BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
+	pdd->qpd.initial_xgmi_engine = -1;
 	pdd->process = p;
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
-- 
2.20.1

