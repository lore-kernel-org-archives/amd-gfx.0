Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF44C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9E810EDFC;
	Fri, 18 Feb 2022 22:26:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422F410EDDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njIhVhWkAznCXy7OrSplZHgFvWf6vPQtqFfqOnavqxNaMVIksWGvXkRiWoXkK65vvde4vSHBbgUX4msFyOR4djwoHIMVTGYH+fIPVlj453NZO3SoIcwEvFDt0TpOsZ2XK8ZzrUAx//kYXyQdKy9hMVQnr/lR1o92ZNwKOSgOBvqfp6EYoy5GIDFFJMzkOTmHgsdaEOG5GazQf1oSHIOqrR7yGAF58FlUZw+ElDIQnhfYv9A6QjBUPa3XbXHxjYtJyYI07SeERqqNWUFxg1s2uYi6003yLfQoZRX9J/scT8zB5uW9JSJmi0cKXrtEDdZ7tyscoZ8RXOCE7W91BUk6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7Ybq42DX02ufvyhtUuhfn76C5nMBISmfno9egNnPxQ=;
 b=kJELa5+M8WzHZKF8Cdu8r+IKiPybA0vRuF4cffYbhAPujm7eW8Hc3xgeb1Qr15iwP052WK9OguSTl1u/yv1HtKtF5Ksqn67St6LsEBu130XWm7MUE3WltpPur0/fFZDaxzatIhMgHm63Hx3E7/aCw5R4lolgXdy/Q+VFLaiL6QMLPQm3bBsvBAI2YQBF9CXAZ4QaRbEdeLlClR+fiaSwowg/omTX1hDiPzEmr6Lsd2b/zR1QRduiY3KdsJ5QD4HnMA4qg5Zu/G9FsK3zbuWwFkUHo/N3JsfOwdAAcfC/7dXB9YzkM0w9wZ2MfgquQOasxcRFwYSx1PcvCcW+ez/Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7Ybq42DX02ufvyhtUuhfn76C5nMBISmfno9egNnPxQ=;
 b=VB6RlNscLbIEs/KEefuKh4p65R/eE88J9Ob+7GD/ht+WuB0c/TlydYCLU5+oJwkwmn5jo8KkIDc2tcPECXGaRPepfuTzQNtUY33TkDpemhxdj0429kz+ie+2Ep1kHtPiFFg/kB7fCbFpqhqykVLo/59TTk8ZtJhDKnHHGIkkUcE=
Received: from MWHPR20CA0006.namprd20.prod.outlook.com (2603:10b6:300:13d::16)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 18 Feb
 2022 22:26:19 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::14) by MWHPR20CA0006.outlook.office365.com
 (2603:10b6:300:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: expose benchmarks via debugfs
Date: Fri, 18 Feb 2022 17:26:01 -0500
Message-ID: <20220218222603.25470-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85572da6-5123-482f-03a2-08d9f32daf21
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB554643F907111398D535F89EF7379@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTEolNlcC5zZDb8S0GydHe504tbZFwudVmCkZHv4o1WkdGm6iTCQamwSC9etiKsOqit4f9enQxvna6ZRbZfum7OG4vDBAYafTR+VSCtNMFNaOh5LATlqnSi4U/CvDuWfGSl3mflyuW328CSx+xG1ouQFal2dtym0oxIgGaWYujKFGc8xHYsIXXXXNjpBqdYZevCmEWzpRNKsJoU/yPqZmvCkiVmMft9gunbBgCBDROudIRexZnebnfniAnb2b/BHj56K/MSw2rwhNvsFlDHTFSierupuEiM7iaKegGUrbXkufFePGiCgi3NnqlVDITnBY6aH+Q576Bq3KRgR3zGxdfEixioCOURaePFt7A8zBBNgsuw6dpj1J45YuxEpNR2n9+/zTvsSeEafvewpHjYMaEgGb8FZpFPR5SQY/vZIi4LeBtSe4XAyKGU5bK31OFgTqdRMNwt00HzjVoaFJjX5yBBy/VGw+BmT9ghi7ppBcL9/ZdYvS7YwbRyN3UNxAS92DObt8YMEFG4FTS41h25DEOVQZLplRbExrbxcMMMzMzOi/JUiswGULGCSUP33ygzpcadQAuv3GXrwnNbvzOSs0thh9LDyG00K//xJ5Svsb2u/1qXMncJF0DVWuaNkTabfh/z6bXrD9+JlCsuGcwI53U/ObqkK75ppjPdx/Uz2sxwJg94lGGybl8x3Fhi8bPII95aoGeHXx8bL5UboUrVv+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(316002)(8676002)(4326008)(82310400004)(47076005)(508600001)(86362001)(7696005)(5660300002)(40460700003)(6666004)(426003)(336012)(83380400001)(8936002)(36860700001)(2616005)(2906002)(186003)(26005)(356005)(81166007)(1076003)(16526019)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:18.5015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85572da6-5123-482f-03a2-08d9f32daf21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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

They provide a nice smoke test of transfer performance
using SDMA.  Allow the user to run these at runtime
rather than only at init time.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index db8a8710333e..c7190d02897e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1362,6 +1362,25 @@ static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
 	return 0;
 }
 
+static int amdgpu_debugfs_benchmark(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
+	int r;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return r;
+	}
+
+	r = amdgpu_benchmark(adev, val);
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return r;
+}
 
 static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 {
@@ -1398,6 +1417,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_vram_fops, amdgpu_debugfs_evict_vram,
 			 NULL, "%lld\n");
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_gtt_fops, amdgpu_debugfs_evict_gtt,
 			 NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_benchmark_fops, NULL, amdgpu_debugfs_benchmark,
+			 "%lld\n");
 
 static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
 					  struct dma_fence **fences)
@@ -1683,6 +1704,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_benchmark", 0222, root, adev,
+			    &amdgpu_benchmark_fops);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.35.1

