Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECB8CE79A3
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC5410E323;
	Mon, 25 Sep 2023 19:52:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CFB10E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjY3IJHBDKCMbHq+MaWA+4fkrvrGNHd+2pKY1wEGSRECsSlErX4Dka5jCE09JRz7HuwCh+IfPLfeYQvVQRSV+QpA8wGhNu+mWSTKeQJSf/m3+Rn0wy+wsYt2q03vuk6he5168dG3etJudA85FzzIIK3YQowtRPevP3RJCQan8JihZSno6nhb/XxbcKPu3O01AYiwFsq1fsmnspaXnGitUBNDDjYMEVjkX7qLGjqBpRcV2eCXAHeyQXOO9r0OIvi/jxk2hKNYcBiBi+/zkiOA0eHWdyym7kGZH2/3VMiyu5SdIn1HTB/JiRZ3m5oh+veppzkSjkkzmLHTlBvFpAUFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNek4yZF4QCiMRTrVb9p5lziHnY8IW0t+03gPh8Fqo0=;
 b=houvAA9c9eZ+Uoan20nEoMBqmQ3uzuUWjMAOII8ZL6udfD3Ee7qKyG64qzA4HjYwhKlzjpwITKj6f0w9bWKruKflb8T7nQDKyD40eqkQ2oOThdjBXSi6cnDP6gTL2aG2LOQTIGk3X4QD7KKeffgaxawZPCrR/H84UjtVwOHcWNSznvK4REd6YRcp8mIL7s5nBR1BR34DNPJCPbvhI+n19EiF0FN5AgbGZHIefdiLARlIZiaIF6klfpUwDhmaSNL+s++oBxLAXP4Q7KQMCkSyZHNmipDALJ3MWS5G5Nc1BG7THOowgNQEM+2GaHMFiJwAnZIde0K3380LW24WT0bQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNek4yZF4QCiMRTrVb9p5lziHnY8IW0t+03gPh8Fqo0=;
 b=n2OcYOfspZw26QqxfrD0ppdQf8SDu5Cunh5qTztB9mGFULCiyUUmfuzCP58HWO8F/X3nklQsJeYGrDKZQoT4rIK1sZ+CcSWGczHi/TnJ6YAr5v4okKjEK+HcLUdKbHxbEu1k4b/AxnGsPl8twZi8TWI6qQU8FvmgbthH63k2cxg=
Received: from SJ0PR13CA0142.namprd13.prod.outlook.com (2603:10b6:a03:2c6::27)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 25 Sep
 2023 19:52:49 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::7) by SJ0PR13CA0142.outlook.office365.com
 (2603:10b6:a03:2c6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 19:52:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd: Move microcode init from sw_init to early_init
 for SDMA v6.0
Date: Mon, 25 Sep 2023 14:52:03 -0500
Message-ID: <20230925195207.124850-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c8e6ed-0c35-4bfe-e6ea-08dbbe00ff32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bti7v0LlZu+qCfZxrMXkGxuowLs36fPY/34THcnt17eBqojjxglw4T/5qJROumpw7IyfnwkYnfYYtC9zRjv5CwA9hoAkW9BaqIKVJ0J3wo+bcKf6fnF9o9jLT+oVeAVMxnjLLMaKajTOl7y1Pvl9dyYMM3MShiq4a8lyPHtkjWmgYd4rYp5SO0iJEBHiWZBVB+YFoOHpowgREvXbsV1Qm87VDBlJaKS2q+67eXs0e2km2uwFlhE82E8d07gJ2e3eHcDg+RZ6T9pI4V/2YHiEUTtXIl0Tz5B4XNgvjiWwEo4tgHEa13TNMiytwkUByHC0mFCSMgmNnHMv0tciuHVJ02jsBhDCyiqJff2UG4W9anwUQDqoXQ9ZEB99TDc32Q2p184kQ7BgqHtH6m09sZcwSgNxX23ijA/o7aJjt2jztE96Xg7EOz+LkOoUr5Kv+J0Q2n3AcRpfUJHkVjJE8xI+DcdPcahPwbhMjNga9qwc4VgY4JbUEcR75/T5ylBxHwGETd7eYxwhbyx4ZoC0A4W22NzYHNvOj6/JqeGRMh5ihIF5OhC0Vf+nS6yaB+CukgeJT3XUv9fWxq8uGHHj3AsZTxLmA8YMFbg4/ZkV3cBE02/+h1eHSIP91+aiO+xq5+aLvtIuBvPQXebp+c49Xt/qJC+KcUTtsDYXuECRhedevCy6Rmo/f+5Nqtu9DZDNksMJiQoUEbNGIIVaB2KmPOornlYWUH8mnOvCwh+EWCGUoXMZU1KYZdoKC8TIokwdz7AyC/rPqdnbOFgOoGOz+wOsJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(356005)(26005)(81166007)(82740400003)(8936002)(2616005)(16526019)(83380400001)(2906002)(1076003)(8676002)(4326008)(40460700003)(36860700001)(36756003)(47076005)(426003)(336012)(44832011)(5660300002)(86362001)(7696005)(6666004)(6916009)(40480700001)(478600001)(41300700001)(70206006)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:49.2298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c8e6ed-0c35-4bfe-e6ea-08dbbe00ff32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2c0c2e9f2783..1f8122fd1ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1258,6 +1258,11 @@ static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)
 static int sdma_v6_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_sdma_init_microcode(adev, 0, true);
+	if (r)
+		return r;
 
 	sdma_v6_0_set_ring_funcs(adev);
 	sdma_v6_0_set_buffer_funcs(adev);
@@ -1282,10 +1287,6 @@ static int sdma_v6_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_sdma_init_microcode(adev, 0, true);
-	if (r)
-		return r;
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.34.1

