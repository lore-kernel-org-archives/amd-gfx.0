Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043CCD379D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 19:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFEA410E089;
	Fri, 15 Sep 2023 19:34:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D11410E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 19:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6UY5bwotMV17HqqHAhfbLsJDLxBn43o/BKY83hYrMDnPpHnLVUHggvbqzfVYyEzKRoOrbbYMk51koumHaGdEeOvrGGqkGeNwvPGTqASUWCHi20U/ANfmsocsY7iMeduBz6xKD2xNpD5dnMCAY54dhJ4HFKW2bQCzqVbH0MwkjeEGhfhdfXpp1z+Wp/IYrmX1qQ38WSQnaW18jBEAoxFEYxwV398hGvqdGZ6yKfTSAu18HAkgGWIvEZZvSzGA56oTtGzbxl9MlDxZdBJkPJWFEC4sQAcmuFKTnIqU+Qsw2/PjygJtF+PqHjA2+L00B5iWwLRQU2sv3oqw92V6F/BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtQiwC0tNjWMl6hTivBaM1Fs2YMcVRD+aOq+bJoG4FU=;
 b=SyLQ/rlq2ZJjdkD/u7udXMzeg/lrCcm9Z2JBjqNl5++MkRSYGMWAkj4Zohe1AQnTM1j0+9oOidpJocLCqCl35Q2tYW6a3acyNtaui8mCguO/3iBofEeC/CzxJnAwfKQSoLaMJkb8Wn+jhZkx1+mtbiAgltHMDxW4gFfwl8h46gBgcRqXeswngr/2ZuDjnCXljk5Mq17gClFtKpmEX34LO4J6m9+JE0pvmAirf543DrT0d6Onib7m2XeuLlNLOCYskjpY86rUP+QNfWXitBlIyBaCA+WdWMnJvCXMsHzBhQTzDWJ4XLPe/FOHgxMd5mAjgw9NQG+DOV6TTDYYmGMoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtQiwC0tNjWMl6hTivBaM1Fs2YMcVRD+aOq+bJoG4FU=;
 b=NzrAmGx7Hio80Mg+tIsR0UbChwDGhWMp32lsBVgUwDEneuQhG0dBrNL08UPCaSdlkX8/s74nuu4SsQ+JL+a9KyMdoEAVJtjMgEb77seCG3MvQqmQCph/QY1aMxiAw9u9ucTaBvnN9NVl+Cjiy7I+QFDugJ5WcT27ehu0DQPL1pg=
Received: from BY5PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:180::29)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 19:34:43 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::a0) by BY5PR13CA0016.outlook.office365.com
 (2603:10b6:a03:180::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 19:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 19:34:42 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 14:34:42 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3
Date: Fri, 15 Sep 2023 15:34:09 -0400
Message-ID: <20230915193409.18822-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b0d9cd-e3d9-401f-85c9-08dbb622cf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMpKdyXNqdUQZnz31+uAhzu7NJzw9m/VwHThho1NEa4nuJic0e/67+8BGrRx94OXwTGbo0o5dGKJ/UfjpRHZaznhKtevtVuJcYF7tARmDq4qn1j+/G+R2y9CS4b38byuRZoDrZ/tW6mMwHFSdspSc2BHbE6hL6/XmMqDThePj5284VZH7k3fzWZZHDcHaGxDEYXeQ05KSEg4PYuVGZPXcsRQoIem16UJZaVYCUr6vpG2Oncjdy5S+VGmgXNd++AjF5kSxC1sjY41O2o0sjyuhdLq8mm3X3IGyIw7ajB0IDppfKSTnMJoAc3uGqtlRUPa5xkBuYYUSkCLXsIVMCt8d5im+SbIB02x+0ZbC6hD/ny2F3Ze9MDFltXysU9KOWPZsUSM3dcb17ikVfswqNfp9vGw/P8w7LAloq0eo4kKJhutHoAap5NvU7+4zIIFDuQb4TRCGycApvPvYGOP3qxxKIR2LOlVq+Ki5H62itQeRWuOhfdoELHq8U2zBWZE8vGzOz2QNA8AH/1t7Zz03yk8EFoObyX1BZRNtMOQ5EjjQkPyxpsfD/wEEl7kIuP/J9d1qfisfIRNkpFsV2Jz8V8KHqvXv9dPcAJutYq3mVG1YOmuqJYR1g60zmuQo4oa8oUeS/yt8mWlGClftmN/ci4jc+XZHpdUGwaemIIRtHgn4cbbNaf3CK7ic4gEwGvHFeVvFHrbpxWYpHE3TtHMtweJJF/k9iRJ0RPwpuV+ORRV3RZQVImUCRCCNfvOmcSiJHduzzh7n6ggUkqO6DjPPBAwZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(47076005)(36860700001)(4744005)(36756003)(86362001)(82740400003)(1076003)(41300700001)(81166007)(356005)(40480700001)(4326008)(316002)(2616005)(6916009)(426003)(54906003)(7696005)(478600001)(8676002)(70586007)(6666004)(70206006)(83380400001)(8936002)(26005)(5660300002)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:34:42.8382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b0d9cd-e3d9-401f-85c9-08dbb622cf76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX v9.4.3, application have random timeout failure when XNACK on,
with dmesg log "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
means retry CAM has more than 256 entries. After increasing IH soft ring
to 512 entries, the test passed repeatly, no IH soft ring overflow
message.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index ddfc6941f9d5..f9cde0d083fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -566,7 +566,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE * 2, use_bus_addr);
 	if (r)
 		return r;
 
-- 
2.35.1

