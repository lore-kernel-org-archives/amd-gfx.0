Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71387C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E94F60F26
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E94F60F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8DE6E047;
	Fri, 12 Nov 2021 16:18:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA776E047
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 16:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exQP+VpSVAw28CYl52K7UtHDsb6kL6k+NTsxndnxFe2fuVl+oJBaXohAeWOKSq57K+K+hlEZ7odvCy+uR8MGIUNGE5Lr5wqkvOPqxMdE8IBHOhvLLgJ7F5o4sWUTWgHuSu9Uiqtoqnu/3i3mj/HzMUhT9fBd4SebMAWdaicEx9i0ddsafzQorbS2c6GJ4MKiRfJpSCeM4XnPsLNcjPMew9ZRdMwikZ8eUq0W8x5mbLrlGVelwkDG+hpJy+6AaZxjNrUp1Vr++c/6RIOWbNsP8u7MuRq4/gZ79fkt0j2bnEZhzW1hJT0dQK5rWUX4QObizHsX4Qp63saYgxrw7o782g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtswZlmSDzUbUcVPE6zLjLvBJsbNhgfiAGLq3PPOb+k=;
 b=E35RXE4FZIwxxU7kGJnJgIQhswnYr4w6PnHW4OR646bJH2vdiDTAwn89zLcPBy2FOHAlxnQZP6tbUObYLJReiyg23xdF7ngTiB/h9s7GjOWFuz5TGhgCx5h/Qhcq8swE+vvn3v36WQpBKx4x7+Q4J18KOQmpc7U6UaSNtIsbiLq+W0vbtz4/hffIzVMHPp28TQRMpXvhhNV7XTibzpa9xzZqyjOhwYNTNHAxmN4bMh42InIgC7NTY9FclzZApPEJ/FjmoEtNXgeXKDzdIcK6qzcLPBFMCsis460/glsA2OXUKD9FlDb5ekWtb1XJ9SS1BA169r4W8VIjpicCyLTvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtswZlmSDzUbUcVPE6zLjLvBJsbNhgfiAGLq3PPOb+k=;
 b=Q8XnW+BMlI+0QGsqLgVeRsgaRgFEDtZUmmKEmwJycuxhGidMFbpzz5aZOuGMQMdPud5ZKAg6neLLR3OE6HiR++m9vj5ETT7/8z2TqZL1g9GkUD6jirnO3K1MecBl7pfN+TMx3LRet5WtlI09PhtHWRTidLgU5FqtLLug7eavDAI=
Received: from DM6PR01CA0019.prod.exchangelabs.com (2603:10b6:5:296::24) by
 DM6PR12MB2762.namprd12.prod.outlook.com (2603:10b6:5:45::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Fri, 12 Nov 2021 16:17:57 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3c) by DM6PR01CA0019.outlook.office365.com
 (2603:10b6:5:296::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Fri, 12 Nov 2021 16:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 16:17:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 10:17:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: always reset the asic in suspend
Date: Fri, 12 Nov 2021 11:17:37 -0500
Message-ID: <20211112161737.135848-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4668dead-fd5f-4539-0df8-08d9a5f7fd67
X-MS-TrafficTypeDiagnostic: DM6PR12MB2762:
X-Microsoft-Antispam-PRVS: <DM6PR12MB276232855D7D26444F328479F7959@DM6PR12MB2762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58N6OsMEP9YhLjY5IgxN1aaXcUDX+T9LrTcsAL2GODlmOwex9MHrQBHpwfiddEqojSZftVmBr1aMg57SmOfHf8ry/s74wmk7S+aXEQlDfm7g0nspVXf1cRtEary2AYFoaAFVLoBq/5yx6oAXUowzdrpd1Y1D25vWepGLjCsY5X453n+FPe5i5E4o3k579iG/R3XuLmCSvPr4hSymKQIq52HkqXCAZkO0nx87b7ouueSWoH88MSID/t4vpgktQtLSPfmn2V8GrUmTFdwCKqtBpk+N0WWGFM7UtVgKNcyTnI7jgVfxntwsI6rWubiKQOzQLPYUeIL+NE3r0P4BjWFgGjNa/bwpaMfuyqtZe9duYdpi/PN2szRNPjilFDwW/jmVJ38g+YIqikXOX8sIb3mnkCrxIsYwgtETWMisbl0xtcXjJsrY3yAGsKYLA/SH2eOgLdnvD6IQBqJMg75OFQzfodHQuCSAbZuU2juTZ7YJb7I04voAsZARWx/AfBnqEr6zuTEhrxm9ZX9AsuBRWrJw6Gttel6efYZAivVnCpJe+yq9rFM2SfxKXlMEsk6/WB4CUOFDlhTMdGKwRDAZqaHo8t3iYQ+05VqcLeXSVYKpZ/6gsPQyakGblK9Uh3AITcDzITRgn5Ad857hefpXFIvYsV/84iYX7tMdI3YT87Sg3ctBTqzbdMlyfEcKd+5TW8WvGihgZlN5dQ1XJcAWfKM6gE/VuYuKT09W4zXxwYvjIcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(83380400001)(4326008)(508600001)(36860700001)(47076005)(6916009)(36756003)(356005)(70206006)(86362001)(81166007)(70586007)(426003)(316002)(8676002)(1076003)(8936002)(186003)(16526019)(26005)(336012)(2906002)(15650500001)(4744005)(7696005)(6666004)(5660300002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 16:17:57.5461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668dead-fd5f-4539-0df8-08d9a5f7fd67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2762
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the platform suspend happens to fail and the power rail
is not turned off, the GPU will be in an unknown state on
resume, so reset the asic so that it will be in a known
good state on resume even if the platform suspend failed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1db76429a673..42af3d88e0ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2165,8 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	adev->in_s3 = false;
-
-	return r;
+	if (r)
+		return r;
+	return amdgpu_asic_reset(adev);
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
-- 
2.31.1

