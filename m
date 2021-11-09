Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53451C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1848660524
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1848660524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEC16EC74;
	Tue,  9 Nov 2021 22:43:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99CD6EC74
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 22:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J06XwqXh9O0yAi8btDvXGInk5PgD5jyqNjTtJnhWBlACJynLcBDKpRv4vPWxUjmWK144d8VsHS91dMAgRrFMQOIGkol0+79hWnXGnDr3SEV05Is2ImEjKFx61u6//u0t+YPF35hBVUCa+EbA/A7/O27kJdlhSutgaZof3wF2awR23rbmpo4PIOa4iVSISEhXW+YxuQFi8slwNd3+/6QhuETkGcirZq1wspR0YTK0Kh1nSzYqo3tT4S/pSPBJJikwghQ9UufCWWTXmWoMYsllT6VYdbNeeGNddKVa4ePAywD3C/A1u7PGPpqA+7R2TtLdmrmfxDZFquOg+oI/GFc+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDIYR06rkTPR+XIb4elKaIWBN6UY+PtiXyZA5jN0z+U=;
 b=FcIDTZW+AwE5jvdJWYNWPHm01mR7t+iIk2Q18znw410blS2vPSeoNFwGzzHfZPYfUsEIone2BziKKsIBCC7Q47xC4gp6YPBd2ytw0s3+5GCyJGz4WUwgiHMDGYKlK2sewcyLrCaE7ocKoaif37bzWtJNwj3LXzrOIakaKobJEdvZE69WW67bixJRe+osbzxethe60nevSoAY+V4jx0kSx3p2Wf3eTHrtEQWgNzL9nTNF9i3mRqfHs6SzGrNkX2YxqANl1REh7LPyc0kdnbulC/zeiBL1iOAnTdHY97T9IgyzCu3yPyqoZiJfG4x09yfmcTk6HWoZcYbSodRkizSJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDIYR06rkTPR+XIb4elKaIWBN6UY+PtiXyZA5jN0z+U=;
 b=VEo+2zuf0R2RBt+v+bCNGQhnPUvQAGFU/D0WGmPx1pmC38O9EvKI/lELFRPmmvQo1r6DJsxMv20jenOhYS4Sz33CLJVC8eeZyOjdF4oqZy892cjLLYgbYVh0EofjHkkJO6MXB26ZIHOtf74sODITDaSmN/CwW78WW5mfIUFBHmY=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 22:43:36 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::fb) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15 via Frontend
 Transport; Tue, 9 Nov 2021 22:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 22:43:35 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 16:43:33 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdkfd: convert KFD_IS_SOC to IP version checking
Date: Tue, 9 Nov 2021 17:42:49 -0500
Message-ID: <20211109224251.3484398-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ac046bc-f73c-417b-2100-08d9a3d25db8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5224795AB49D73D831F190F28A929@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqW5tgxCa/UlommjzXPyKv2FEs1JWWdSNzd8bufCGHnblzjdEpCiqpsbKvtaM+Chrxx960vxgpAoYOaHRcoEG/uMJ+ZqWc6hpnz7jaDxYPIW4evgQZDkQmmpPaKdWnuTLrgQXwL9zdgBEYLd2wJGQCVfRdUByI8deamhnhDBTnXpnhld5Fx0cqtsr+64CJk7RpmwrY5Lvaj7NEJ2V4KPvKIjALpkW/w/BBCYolWlwJ7QJzfP8AE5oluwl+i358H3i26ugu4EACs3bENpu4XYpLXHc6vxzk749cIwLBKDV8SaST28anJ2DUUnME6G2b8ANZqkAs7pGO1mrEMLVPvCxpYaQX0BR0xOn+K7ycG1W3jn/70LpsbaeXTPWzs+Derb2MDC/9U/yKmoCb3kR75A1ALt9EFZA/UzFKa1AQOqey5mCfDXXdx0hknt8OgzJr5nLX+j8M4H0t7rll3HiMc9W9hahLNYKqqlOjGzoa0R7F/9UAjjscsgoxvSfPHK11teErXD6NK9MTuLyPZWAGS2tUPBe/Kj5AZeCNpy25T+wAGev9DwO1x+DXgsSHUVvSSfxx8CNpzGs5ZVyNh85mKYbRUFDEptBQ851gCnhaW55LSqOXq6Vq8IWMHdv6WevmKEO7JN0083eLifeZTjiErDwSaoBNspehuCVT/6IupX6fSZhdf5twOYwgMY3e3R1q4F/dgbMLgJXYjDJhS1tARVCll6jYxhecQO7XNozxcPqM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(54906003)(6666004)(70586007)(81166007)(426003)(70206006)(1076003)(4326008)(2906002)(82310400003)(36756003)(36860700001)(5660300002)(186003)(508600001)(86362001)(16526019)(47076005)(83380400001)(7696005)(356005)(26005)(8936002)(6916009)(8676002)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 22:43:35.8724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac046bc-f73c-417b-2100-08d9a3d25db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Defined as GC HWIP >= IP_VERSION(9, 0, 1).

Also defines KFD_GC_VERSION to return GC HWIP version.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 2e3d74f7fbfb..2466a73b8c7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -321,7 +321,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	/* Return gpu_id as doorbell offset for mmap usage */
 	args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
 	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
-	if (KFD_IS_SOC15(dev->device_info->asic_family))
+	if (KFD_IS_SOC15(dev))
 		/* On SOC15 ASICs, include the doorbell offset within the
 		 * process doorbell frame, which is 2 pages.
 		 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0a60317509c8..4f7aec6a481b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -157,7 +157,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family)) {
+	if (!KFD_IS_SOC15(dev)) {
 		/* On pre-SOC15 chips we need to use the queue ID to
 		 * preserve the user mode ABI.
 		 */
@@ -202,7 +202,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	unsigned int old;
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family) ||
+	if (!KFD_IS_SOC15(dev) ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 78ae96fc8a6a..352709034acf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -183,7 +183,8 @@ enum cache_policy {
 	cache_policy_noncoherent
 };
 
-#define KFD_IS_SOC15(chip) ((chip) >= CHIP_VEGA10)
+#define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
+#define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f29b3932e3dc..fafc7b187fad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1431,7 +1431,7 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	int range_start = dev->shared_resources.non_cp_doorbells_start;
 	int range_end = dev->shared_resources.non_cp_doorbells_end;
 
-	if (!KFD_IS_SOC15(dev->device_info->asic_family))
+	if (!KFD_IS_SOC15(dev))
 		return 0;
 
 	qpd->doorbell_bitmap =
-- 
2.25.1

