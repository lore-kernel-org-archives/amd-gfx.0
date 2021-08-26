Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D420C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDD460E99
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BDD460E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D056E7EF;
	Thu, 26 Aug 2021 11:44:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FC76E7EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4Q5U5uEaKoe/mo4zQggjYgIZi9Ex/rLNy3FZtfmgkIl9AgPQ84EY3NzD/63kQDc3gq+xnNV82cy3PBlKf7EHbl0dVpOnFrJpLBzqhcDpS3y9+s42dMOCv+srrFtBlfbzLO2m8qDx2DOm46G4p5XExhLXl67GTz5YZuatjaJHAIr61AflI220Vy50+5KY5X9Hd6q2JFYPgvcUVNCUT6d41od8/AphgeGfqMlrBBH7QXD3yDektG6zp2fBI+Rw2VPOZBYiqawXeiz+RjasJYu6YbIrskmDtMdRoxIFW429LEtGzgD1KgDRVfzj0/7DxSObvJGXuOfgQkVuztIC5VqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5rwTdxqZvMDhDUwHe/b6l292xabYNwI4PV7Bt9BlKA=;
 b=A36TQ1FZCO4TgpoqyWpwDyeDo1zqKXScU5Z9N5IrMsWIkm4dP+KfjGvJPewEVuGAClhgDVliumvGUgXknu1wuN8YEfAslj4RTuTOGa7TlYs1upvR7Y2hBO3vaHDibxuVKI5AkvRz0Ip7xNMfUY5BUXaOX/qN9VbQTwYKhq99Yb/oSo7IeVGHm6upWaOHgG9axeQyojhVpSoT+V7i1XZkSKIIbT4v6uEK0V64yt9U4G9jHNKuykKL+RmCC8hcdzOoFfjtLvZmgc3hTyUtfneP4YeRTv1g7bIEDBodrgLKkg02i28m4+5Kh7a4NSy6pT390ap6mW8o70J90hgm8+qIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5rwTdxqZvMDhDUwHe/b6l292xabYNwI4PV7Bt9BlKA=;
 b=p1nhe0Xf0cwvl0DqC5BR0NDxfOyxAqTW09s/4RiDafcAWgkfv+WRuwl4T1saXx7WtAc0xCFLivCjoJrKGGyUhoZ1HYLcs5MKNYW1/0nYIgep4XJShdoSBU2fPejE0W1HozSZYIM0w2ZmxSk3B9FCwPasg3bSoi6nBWvu/ftq4GM=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 11:29:14 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::37) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 11:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 11:29:14 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 06:29:07 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>, <satyajit.sahu@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v3 1/1] drm/amdgpu: detach ring priority from gfx priority
Date: Thu, 26 Aug 2021 13:28:53 +0200
Message-ID: <20210826112853.6617-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658ea2b3-5a76-4545-e82d-08d96884bbba
X-MS-TrafficTypeDiagnostic: BYAPR12MB3269:
X-Microsoft-Antispam-PRVS: <BYAPR12MB32692B9A5462CB44A6BFE90C8BC79@BYAPR12MB3269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yT4XZQmF9w5iw1mZaAMiTu+kCGKBwwTmJ7zbXWVJvA739LdBNgLrELYtk99Gzj5Qg+RzHR4/Z2Hegyxt4sIKWTLxyO9xyESH4bgDPnEB/BwAaqrrGGpcrG8uia8AGMBc1ZokoLNt4KcN58VrV2AW4rJaaRkulEv4iz+XxfszwIfgfgYcNgyPz4Sh0gGyMrWNELvwmosc01QKCM/QjBUfe+Gg0COa6wAreNnCYRUbRKCM1MsrIs5MIU04hAO4Ac3lN9dOKEyWKaYdip6T80V2tKKAe+8JGyUW3g3AjAzenm85krENV+PNZYAiBJaX2gz+hE6OQl9kYDAfQscDVjZ+WE5DNvLv/uxnGPSKLJQnFd2ptS9LupJ949kv29f4QRi/Gzy21LdKYox5IInu69ViFf5rWPFsvhW30+qu6yPQM9g8Q+9T3cSQXA8THSbWtATegfDD+gZ2SSKzcLBXvCQeXoQ8clSMTFYEc0xeS+SHUJbusVIDozF8QRe6T3bPEs2HUkvcBvTTa18LGGbBrjnsqj+ew8kiMiFZJMjxHPj8w4aZmyrLetAqUuan5+YqIROfZLA+2qV73E2lQfW+rOroJZkgohlPBSzf7Vyzkn3TJ4L0XKV+c9fuTR821XNik0j/ACYRFNhgMZYdLNJGQp0RPxX912/Q3QEGIN5C9LZb3fQ1cppKTRACCTUJznXjYolzjJ1jK+cD3XTSha7I58Aum4Ip2HD7Q5C7CMKb/+BCXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(8936002)(186003)(70586007)(81166007)(426003)(16526019)(4326008)(70206006)(6916009)(82740400003)(7696005)(316002)(54906003)(8676002)(6666004)(5660300002)(26005)(356005)(1076003)(47076005)(36860700001)(36756003)(2906002)(86362001)(478600001)(44832011)(83380400001)(82310400003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:29:14.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658ea2b3-5a76-4545-e82d-08d96884bbba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
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

Currently AMDGPU_RING_PRIO_MAX is redefinition of a
max gfx hwip priority, this won't work well when we will
have a hwip with different set of priorities than gfx.
Also, HW ring priorities are different from ring priorities.

Create a global enum for ring priority levels which each
HWIP can use to define its own priority levels.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c88c5c6c54a2..0d1928260650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -109,7 +109,7 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }

-static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
+static enum amdgpu_gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
 {
 	switch (prio) {
 	case AMDGPU_CTX_PRIORITY_HIGH:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43fe2ed8116..f851196c83a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -42,10 +42,9 @@
 #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES

-enum gfx_pipe_priority {
-	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
-	AMDGPU_GFX_PIPE_PRIO_HIGH,
-	AMDGPU_GFX_PIPE_PRIO_MAX
+enum amdgpu_gfx_pipe_priority {
+	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
+	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
 };

 /* Argument for PPSMC_MSG_GpuChangeState */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e713d31619fe..88d80eb3fea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,8 +36,13 @@
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2

-#define AMDGPU_RING_PRIO_DEFAULT	1
-#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
+enum amdgpu_ring_priority_level {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_DEFAULT = 1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_MAX
+};

 /* some special values for the owner field */
 #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
--
2.32.0

