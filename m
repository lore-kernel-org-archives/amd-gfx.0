Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FBDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 15:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3BE10E06B;
	Fri, 11 Mar 2022 15:15:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692F710E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 15:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIH7a3HzjM/5QqW5LJ/Ks9iitdCjIWwibhcqKXoOtyPyCyhsJChanbNwpMbZh5dQ1E+KZmrY+fsAeZaA2LiFwzf7Ku1wBjtoYp7nuZejEEu9Wf8MJ/a+8G/0Dp2vULj8jdxCpdSLx0PFTFq6/A7dZBA7TFwNFkXrP7UyT7/ssaezhabYwDImC0cUUncbVZihL79rMWcoQqTlEAw6d6QPK/y9f3yxYuT7ej2vvB/mNTbH9F3P4BL0DKDYmLkt6mpX6GmHifxZj5sghrEhXqnshVqFk13FELcLk/ErsBMDdGJpCs9w1wMIGQs8FH38TO7GT1LhfE/wekgZmtZbFBn4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYnqzS/TZZkFOyh5RgONx1MRsDudM2mZtz2AsNpFwiw=;
 b=GFgSHj6kNGd72b54loTxHwjt7VEWo+SB+E2VMTCsgFuO16FjeFTBYOsRqo/fCyeyPc84x4ktQat+D5dDfgANN7B3tq/uD+QA9mwYeLcZErs52gWQZbAud1IfKaL6JKtXJLNDxQ6SiJGbKquRncgwuGF1TFMyj7IR6h2uY8/rauBZo/5NrMFGZXT9tal2rV30Bgsmhmyl6aTfEYHCXhaHLy1gD6r5vX10x3qe+GJwM6Hf6VjFKbBk5mqasAOivP7RBFfPPoP+mW3ybFldYcQ2X0VJV158dn6lDn13ra+KBdIA2DYZBJ5yGcLQOkZajO9oIjfKetAeoLRCTL9pp/LXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYnqzS/TZZkFOyh5RgONx1MRsDudM2mZtz2AsNpFwiw=;
 b=izZ8HEG+LHdmimcTAj3vgNr3t7Sw53ZlqKuNWw1JZaV9mvx4rfBvYuiamfXsm8XdXDLYxay6ln8+G6ea0RRRZRRu8roo6UmucvULWLRBasQ+Jfp0jcZRy4QaigAcR4YFkSXpb4qgs4stQH+F/GttmpsvUcfo+534APBWwT0zbSQ=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by DM6PR12MB3977.namprd12.prod.outlook.com (2603:10b6:5:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 15:15:34 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::56) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Fri, 11 Mar 2022 15:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 15:15:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 09:15:32 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Move reset domain init before calling RREG32
Date: Fri, 11 Mar 2022 10:15:09 -0500
Message-ID: <20220311151509.4760-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90254b34-9fef-4617-ef24-08da0371fd03
X-MS-TrafficTypeDiagnostic: DM6PR12MB3977:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39774DF3D3A9D0FC47CE8E36E60C9@DM6PR12MB3977.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evua83lH31bIiD4O/xyABrrDOjghvs75OlKDOgIQTR/zX/nN7IVaQyqJW+h2FKL8lYPEX7CKlR/vupaJZ4TZfxQbbQwtQ10/Qdn/Lv3lT37bZ9074AZjp/a+x4rjlZilJcViI65REqEyLRrdn74EuilDJf+o1eXj4cptY5CYykJdbEMAo5P3cGrx8o2qG71UUPe/fERgjk8NFpMWJIt7IZhMc5VNUygNEJdJE1KWpiCfaK5XAFvFY44GFMxHOmPAOnxu4t7orVY5vrlYrdBSMbjTC1bcUt/Vntxnp5DD4mEOthaTHiQbaOu5wlgILKIuJU/pUVtVelHSwTQdsQt/eYWUGrAJFNLDZRhpjWwwdUNJuxTSBhoJ8syt4Ej7qMPuawLQsm25gNQiSC88/YdYigvnQO2w2HfjYPKVyAcHRKMhJqIfsDhYPqFqFoSgEdiQmOv5aK8H6kjtguy42JXcAuEfyEqn6hYCShkNFtP9hi2qIpK3NHvReM7AgWfOd9EfuRK5PCU+dWjjnpwf4phZI3EPB33/2rlI0BsbNHot7jp5sVGkoY9J/pzguO9x8U3cM+ymIPs7xHfDKj/jjEMBtxVpo+LXNTR7gfEFRsvydW02u885xFn9MJy/5QbgemoJtLra1/sTZwN5tCasd7HDXJkIUtZKk37JApvKCxux5EHnHJzLCcDl9PToF1Mbwv7X1roC90MfoztgpH1FE/op8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(36860700001)(2906002)(86362001)(83380400001)(8936002)(356005)(4326008)(8676002)(36756003)(70586007)(81166007)(336012)(16526019)(1076003)(2616005)(426003)(26005)(70206006)(186003)(82310400004)(6666004)(54906003)(7696005)(40460700003)(508600001)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 15:15:33.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90254b34-9fef-4617-ef24-08da0371fd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3977
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
Cc: andrey.grodzovsky@amd.com, Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_detect_virtualization reads register, amdgpu_device_rreg access
adev->reset_domain->sem if kernel defined CONFIG_LOCKDEP, below is the
random boot hang backtrace on Vega10. It may get random NULL pointer
access backtrace if amdgpu_sriov_runtime is true too.

Move amdgpu_reset_create_reset_domain before calling to RREG32.

 BUG: kernel NULL pointer dereference, address:
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 Workqueue: events work_for_cpu_fn
 RIP: 0010:down_read_trylock+0x13/0xf0
 Call Trace:
  <TASK>
  amdgpu_device_skip_hw_access+0x38/0x80 [amdgpu]
  amdgpu_device_rreg+0x1b/0x170 [amdgpu]
  amdgpu_detect_virtualization+0x73/0x100 [amdgpu]
  amdgpu_device_init.cold.60+0xbe/0x16b1 [amdgpu]
  ? pci_bus_read_config_word+0x43/0x70
  amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
  amdgpu_pci_probe+0x1a1/0x3a0 [amdgpu]

Fixes: 1228996f0 ("drm/amdgpu: Move reset sem into reset_domain")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71876ff466df..a35c6acfe2ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3665,6 +3665,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
 		adev->enable_mes = true;
 
+	/*
+	 * Reset domain needs to be present early, before XGMI hive discovered
+	 * (if any) and intitialized to use reset sem and in_gpu reset flag
+	 * early on during init and before calling to RREG32.
+	 */
+	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
+	if (!adev->reset_domain)
+		return -ENOMEM;
+
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
 
@@ -3674,15 +3683,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 	}
 
-	/*
-	 * Reset domain needs to be present early, before XGMI hive discovered
-	 * (if any) and intitialized to use reset sem and in_gpu reset flag
-	 * early on during init.
-	 */
-	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain)
-		return -ENOMEM;
-
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-- 
2.35.1

