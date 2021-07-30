Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 01:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E4060E09
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 01:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7E4060E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA3E6ECF6;
	Fri, 30 Jul 2021 01:23:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC986ECF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 01:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC+5Fkn11AVlPPqe7auajMxXJyuqK5LZ2tJv2oV5f75UoONuYOQ9oVy80os47E9YZ0+TAicOtgL8LCgHK62qCmsVELuKQ11hLN02+WsjkUOTk3laLBiSDIJOLYP4fT3AH0pZs/z/6LaIiLK/EAjLwsrNVgBtQXHnP6kCuoujarKDYR7HM1uRaCUJxx+OBNTHC5mLJJrqomWDa5APjs2oEOh2Grq/m0fJZJUlh+LUdeMp123EGxm5F/9IB+prVnK74oDXNaGueiz236ulo+L0hQf6LLRiRtt5GWl5NxUdQs1ni0OliYV8Iv594/RoXfx0LMWqlO6g4lGVm1j4PEa/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhAoo1o0SpxisJGwAD+aKMIx+t2lgyX1wpX8MmVTm60=;
 b=Shkvd9so6lzxHAhGy4p0t/BCAm54btBNvepyknhzrtERI3Fp+ggvge9w/wzSKv+XYMRzM2fG0T5pV1j39pMHvhcI5Y6pvBzW1JWkOerRe/1FzslOzEb/bh8c6JKBB1TdK3D6CmK7Z1qr/NxAeE7UbVLFZYdb4yKBWwfS25MQ/r8ERoLjElS5ic0tDRiwA3ZfGqUlrCNCojz+WkQFZSWjs3JmAFQWyL8H2UlYiXFljDzDUY0mxHeMs+qbQPW5ODZfmeymxGnQPBkLV7x3PxXERDpwdifzOmYA1iBYrvd5uhchdna3Ly4vV955NNwgAIm0Vpo8itRn1iSlMLWE0dFQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhAoo1o0SpxisJGwAD+aKMIx+t2lgyX1wpX8MmVTm60=;
 b=3v6LB4O1NnLWeJEDYJLe6xnrU7XnEBiVPFb+2o5XfFmw4FR/Znu0wYEEGQvd4Gg8ugZ69LsNN/YfRcqXay4SllL3ItSHiVtPCV3pMSw8U4pNpQUh0OKyuK9SUyVgbCAsH5W2iU2vvQ4YKjCynNsDe8+HfFqkZi9WemjzXy1AsJA=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by BN6PR1201MB2547.namprd12.prod.outlook.com (2603:10b6:404:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 01:23:10 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8b) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Fri, 30 Jul 2021 01:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 01:23:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 20:23:08 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix fdinfo race with process exit
Date: Thu, 29 Jul 2021 21:22:54 -0400
Message-ID: <20210730012254.15662-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9f73f29-b050-47df-d2c5-08d952f89764
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2547:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB25472F5FE49F4CF44A796250E6EC9@BN6PR1201MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaiWc8d/saB44bfcfg/uhQH8UCIs/QpRM7IaHaCnEokQiBqALLLz+YU+yCqnJ9aMNoc85EPKJwoxTsmaqpukIvUn9hsqBtjY8sjtbJXtmcmwM16An+aZN+Dd6ilYcv+ckjaIlTlj638Nxnu0+YxWE5tjY0zhgeJtZzNvXmD0+jBbUzjIvRuMlhKPtQqKDpoOFd/CQNGhOHIO35d/8ahwCFy697qyhYoth4RkjRznwDjw4uKH4RRvHPry88o3SV919cMmn6rykxJLBVryWzQxe0qMJ38gJTtXO8riiKMIAoo9ViXZJaEiTQ109uQrw5Xya+xvboOlYKTGDWtr5hKiZSx/TvXVkznBJiKEiJd+HTHTupX5UZSErFicjRPiWGhelIurup9Hf7kBDxJmOHCWLimJBIvvtepIfMiZGm/O00ALCZ0KlZaQ/Ra8c8uvFqNkUHTkOACJkbmLf5GEIbz1FcVXLTy0KiU19Kgn7U0JrB0VeF2YyNsNNOsFYg9gOXPAltSD2AjA58zUQhJMgzXO5fxnAdWtRjRHuDZvO8nKJ1gksCOlIM54iJMwgPChGym82zvuRouioF3M/9uU91Ctnk/2ibsxUb4Y3F/plJR0A3wnA2L1xswReZWzI66zmBIV5kLjDvpzeLTokjQil9CwV/ILsS1i13Svu3tLbYtpOk+OEVpY7fq5J+F/BsPBlbICyaM2hfddI1FFTlUexlK/ikbbjboeZE1U0DC5jajat3I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8676002)(2906002)(478600001)(356005)(81166007)(36860700001)(70206006)(70586007)(7696005)(8936002)(82740400003)(82310400003)(36756003)(2616005)(316002)(26005)(186003)(4326008)(1076003)(6666004)(86362001)(16526019)(47076005)(5660300002)(336012)(83380400001)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 01:23:09.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f73f29-b050-47df-d2c5-08d952f89764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2547
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get process vm root BO ref in case process is exiting and root BO is
freed, to avoid NULL pointer dereference backtrace:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
Call Trace:
amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
seq_show+0x12c/0x180
seq_read+0x153/0x410
vfs_read+0x91/0x140[ 3427.206183]  ksys_read+0x4f/0xb0
do_syscall_64+0x5b/0x1a0
entry_SYSCALL_64_after_hwframe+0x65/0xca

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index d94c5419ec25..fba0084bbcbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+	struct amdgpu_bo *root;
 	int ret;
 
 	ret = amdgpu_file_to_fpriv(f, &fpriv);
@@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	dev = PCI_SLOT(adev->pdev->devfn);
 	fn = PCI_FUNC(adev->pdev->devfn);
 
-	ret = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
+	root = amdgpu_bo_ref(fpriv->vm.root.base.bo);
+	if (!root)
+		return;
+
+	ret = amdgpu_bo_reserve(root, false);
 	if (ret) {
 		DRM_ERROR("Fail to reserve bo\n");
 		return;
 	}
 	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
-	amdgpu_bo_unreserve(fpriv->vm.root.bo);
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+
 	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
 			dev, fn, fpriv->vm.pasid);
 	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
