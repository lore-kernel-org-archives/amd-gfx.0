Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3A1C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 23:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B900210FF32;
	Wed, 27 Mar 2024 23:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oHbFDpxI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2300710FF32
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 23:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn4Nj9tjh/kgVuq3Pe20yg8GHqcPhZEiChTRUltQuJxXla/Nemt6uwB5jwufRMFZB5p2qscd8vLtqMYepueHxTJLCZ2FOiR22qX6aZ81Cpgx0dzjfPZv9xmquEDAPudN+E6/Eoh2K5nplUfdOh7xfqyvkUK8n9PdFO53PLbX4WBUTOfAEa8NqFP4pxICp5kwpjhTkRJM+wkTR7LaslgpT1XtZ5nd577wGgjxlbg3KwH+RHvXUOGW1VH2tlo/azW7DyLYkkRn7klBBQHD+fpikic9uMnZo48t531gfRA2/8ob8QJnN6rrKBBpx8vsKFilklt5OFzh0qFmpQNiunyjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOu/7Llp75qamSWcTeBLsoUTCbstC8QnVamEPrHMNz4=;
 b=a3L0qDK7XgdxJpG4a77Msu8E+0LRqOxPLPR8KqUqxAvwsikfcZe+dBVjoJ9hyMDFOBbOsbVjlu2K+747oYBMNdz1IDnFjGn9WqqKckENOOllljORcajRF7hvi5rdkmhg5iUcc7IYBGAwPtVoiCWoZO5zETtxq376pL9I6q0zTmxsUsM1elv+D07bU9nqT3g/VcxhUA8jKTU1jrSUNq0ZJ4ej21PH4PA3av7BWtZvWwHOZWJ6d+KoqefrA0gPQsAFjY8Spmp+pT0dSTvDSovPrc0Ntufc37RTbIYQzJgK0GRzs+t5oAy8XN+Jk7vGvsCM0LIqV+P3qh9boBKS+B02mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOu/7Llp75qamSWcTeBLsoUTCbstC8QnVamEPrHMNz4=;
 b=oHbFDpxIw00uoXqBXbe4I7cIbV31g5vnrAPYrY4YNM75oLsJ5HgmTF+l00gumitVoWOCSo237chM1tZvjDYoRZX8W7OaZWwM4x3gzdT/bSA3WqYJOgdAMwoxDubRr7i7yUzPQWNjtVDraxnglCPDdBl1WqwQ5AcJGQrrnKBErOs=
Received: from SN7PR04CA0065.namprd04.prod.outlook.com (2603:10b6:806:121::10)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:24:47 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::f3) by SN7PR04CA0065.outlook.office365.com
 (2603:10b6:806:121::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 23:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 23:24:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 18:24:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 18:24:45 -0500
Received: from sriov-SERVER4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 27 Mar 2024 18:24:45 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amdgpu: set vm_update_mode=0 as default for NV32 in SRIOV
 case
Date: Thu, 28 Mar 2024 00:34:52 +0100
Message-ID: <20240327233452.811939-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 197060d6-9deb-4055-0010-08dc4eb5174c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1iLvgOcBIKC8PBB9Ar0XglBnNaeSt+ShVfKNoy8dk9AMAR4fPu9ntZtKLmcElsCEK4lBF/S1AVnfO1bN7v3OAMofrlG1ooIFJsT/aTnS1JzOlWL7gnPwPgh9veBvIgxTaHdvtrnHrn5U6JWUN/RZlamQsHLoAtYWCgiyi8mA6XBaJf5bWLAzUPFO2fYcpLg+fOOodbD72xE7jP9hrQQKWN46YeBReO41DfgcW8ggbXQSYOQWW7W4Fl/ecSbVWAHLrLQYREY0kVYR10lpygsLksbzB6g/CqfJNinNibsccMVkK28zB0R4o/z4wMiXxOY2jrpWEZNAFNiHqVyUa55lgYaL5/jxpjJ+BQUNvRkddXRkU0wRXPzyqvDq7wnweZZDcajx6F/9rnyBLRGgwdTt1nneSWKNeV2Wc4DVHWlLH/VBGQyFF5IE1uwpVhLBjvqUW9I9OsYNhP8d+bajm3GUkp+/7U2j1l+EEH8SRqbCT5VZzYSes/kE04sZsBpkG2+XeuQrTpnNRReA19EbiADBGTM87SFMKphD3ChO31HCtIW4kUDfiP1Szz4Spm/pbuzzmt2l1wGcocLVqKFLYHp+3XFNrC10uaT5SkgoakcTJP2ZWVZhbM5xMuU1YFj7LHBXzhNGNf9w0CEZvn2xVPWxMFBrHj4DIoKAJII4vliyrFFJOf61XzBioH3Mwv1KaT0/6GX7Uhg7tzgyXJexpu5N+XjSwJae23Yx7Ejk9k235qjYjcUT1Xt24U2UBKEJJ/g
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:24:46.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197060d6-9deb-4055-0010-08dc4eb5174c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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

For asic with VF MMIO access protection avoid using CPU for VM table updates.
CPU pagetable updates have issues with HDP flush as VF MMIO access protection
blocks write to BIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
during sriov runtime.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..a3012c9aa92b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -724,7 +724,8 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 
-	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
+	if ((amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID) ||
+		adev->pdev->device == 0x7461)
 		/* VF MMIO access (except mailbox range) from CPU
 		 * will be blocked during sriov runtime
 		 */
-- 
2.25.1

