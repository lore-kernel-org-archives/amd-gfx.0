Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A353FC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 18:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E827010E09D;
	Mon, 14 Nov 2022 18:46:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D29C10E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 18:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK2KYWO8xHRNa2Jjo097StTwdtTqPG1+tziENij9MavkvSAPPTSbcUGsxkH9HWLhTwv2L3UKDGWz0BTBLIbsb/gRJTagC5xIkvRWXuZPVW/9lqVDroQYJzqcJIl1n4t4LhPkSvXkqwGMaya2m9uQmpNz2uMiaqmEnPZ3xfxxUUGtuAc+SMr0QZMshzsfOwHOt7vhrRz7d283BSOHI3NUHni0ghb8ji6zwuHqpEK1paYIvRnasxNQi/cQmDMdR56txaavC+PZrT98q3+Zy1OTeLtePfeMXt//iuSN9XWXZe7fvXdT49p2CaBsg9YkIjPYM2K/qs0oEmg9xp61EgQluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEYdz7HQM71blxMDL11bf0WfF/rO9WTkY+5S//enPRw=;
 b=REm8dhSAjoJiz4Q5cegnBaqDCIDkBEAgYlJc4fhHU9fs0nSRz+kHwwEDhsnGX9H44hnErM5jquZStD9qun+qoxrDSFKJtTqWY5//xLrn4ve7ch07J20NYA9mVu1KaGst7tmG7H/qg4UG/rNJ/bPOZMBsq65Q1IQw5gPxZ2FYR0yoPW5QJ/wnhpRqePOkrR0xHZPTmlmIBF3SZPx+EQpOTjnnur0XUs6LLN6DH9uTeObjnRoO6iw+H6d0YGt/pwAxUHJR/abh9F1h9kgKUzQkTWW1CWaK6yTLhFwfFWfZYiaTvbEVR3PZEJK2qcISfkn6OPSZJjb5REUitDJ5KeFK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEYdz7HQM71blxMDL11bf0WfF/rO9WTkY+5S//enPRw=;
 b=YxfwdDCLr+nVFTAaN9IiHERiWZ4gbtr02qwj/NYGuNEDEOsYmdT9lhmi9m2zc8WU2rrdfZ6gFdNPzY9oAfmxtPZyPcZGJJBFRgBWuTDyBDr8AsbPv0DdbkEPlthFiaiL/w9qhhkzuKwjiuYRpSXpYAbgfKa/mNFB8vQchF27+C4=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:46:04 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e7) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 18:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 18:46:04 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 14 Nov 2022 12:46:03 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdkfd: Fix a memory limit issue
Date: Mon, 14 Nov 2022 13:45:38 -0500
Message-ID: <20221114184538.111848-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c745b9-2d17-43f6-e4ae-08dac6707c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lryTx3wu4LXKQlG3qLh5p6L+sgwc+Ho/5qI8l6PrsXv6Bh17B4g8O5y5pVZWTQ7fyQv35w8ggIJ0fhc/mBxQ09FRPDgGOj0BiWPOGbR4SHZTloWxiWr4wkwe4jl0kkyD9B76vDkxOqwGnivdRp8ijMvWKyGeJaboi1i1oailTX1S4lB/wscnr4+wkroybZ8BOu1RbfCFQTXE9/1la/DvOld4a71rdk7NCopklq0WLTupsxYMUiI5X62efetiJPT1yaVvkOcfeKQR/xn79SkuZy2TnTXZyC2JhaICE0p4Kuq5IbzztGA5krQuaAWJ82TRR2GmTQBD9DgiIMxeY5DqnhLtkzs1kxKP4sIzwEtciyQ/MUEnTi0lD4lSyrnXos0Ymc01sUgRKpU2VgJo8k4QgXmBd1G0YtNI88Chp1wSKVdYtkw4SL1S5lcK7TpmNNIVJKCDJW6v3+3GPuQDJHQudcFQ6TPeoY/A4kNgZQKQ2MwzZySfgfj7ZehT/yiHMnG2oU/ZhyzwxIL2fROXMqLQQu6FOl5bfZyRFM0XAF/nyaXn31Se+YHZLPxz65gA7yEy/F4pr2UHgcP7B7qyWhsEhaJpg4c42sroimBzPRglfg9FWEKarvhdjW7W8a6bR6QpJSdIG+E57Bl+Cf3Nrzq2TCdIDk9MCpuVhlkGP28V6qlVzhEUYIn0IsrDdNuUnDpWCt/Gvv6QVFNP5zrcgiH/H78EWLpmznS8BTsDS8VG1PceNe1kwuwk8jGgCAruVTbiqzdX2NVhglFJOZf3pEFnV/d6Eq8VpmvjeGhsoFN6kHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(1076003)(4326008)(8676002)(70206006)(26005)(7696005)(70586007)(316002)(47076005)(336012)(186003)(8936002)(426003)(41300700001)(2616005)(36756003)(82740400003)(86362001)(82310400005)(356005)(81166007)(83380400001)(40460700003)(5660300002)(36860700001)(6666004)(478600001)(40480700001)(16526019)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 18:46:04.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c745b9-2d17-43f6-e4ae-08dac6707c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to resolve a regression, which fails to allocate
VRAM due to no free memory in application, the reason
is we add check of vram_pin_size for memory limit, and
application is pinning the memory for Peerdirect, KFD
should not count it in memory limit. So removing
vram_pin_size will resolve it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index db772942f7a6..fb1bb593312e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -172,9 +172,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && adev->kfd.vram_used + vram_needed >
-	     adev->gmc.real_vram_size -
-	     atomic64_read(&adev->vram_pin_size) -
-	     reserved_for_pt)) {
+	     adev->gmc.real_vram_size - reserved_for_pt)) {
 		ret = -ENOMEM;
 		goto release;
 	}
-- 
2.34.1

