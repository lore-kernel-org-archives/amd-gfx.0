Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE900C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A5A10F4C9;
	Tue,  2 Apr 2024 10:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/Ko8OoQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290F210F4C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkKLVepE2iW7fX6ok431WNQQlf/jkCIDLO06B9gTsCkJ/psx0A1zCWFSK/K20TvFop2rVXszresdBM/twIU60E2RpC0Cr4BH6fiUWcEz3jSxH5Pt6mkiuiZCxlhfcv0AFPYNh0aPuvbQgXUIVP6UuYGV7jGxJmCmYrbaQd/i94IoqTt11/jbk6wPmrd5F7BagkBagybv12ZlyjcUQEJq2GrrVn5Ex6I/NfUYOu/baQAjDdeGspEYSBSpAaI52XwRKFeeOuieRpt4r/ied8CYk2Ef8kmhvhPH0oLuNn18VrNoXX2q7pFJlV5TaSAnifjkpbOvzvDEwLeX5abdllGz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwiyz/ZHm4B0wBE/jfuCBdFBZIyJvaDo0EBET5ud9ZQ=;
 b=EiR3UuwClSO2wfBrGB9CztSdIBiykpv4r7i+vMOszkF6fU6QBRRVdaDQAXjUXdeRwFxMsTbwe2X5jwH7KxKfdLtKrbT3W4juCpJ1kLRhZ4GqZ0yJrJHszVLJVymjkYMKD1tTazKUbkReBuZ1mSAT+/WfcBqZ6wyCOezg8DnBmimmCxjA3jv2AMS9MQAH8M6qxMt9/LE1l3/2ttKzXFSosThFOlGSOnTqhO1nVjV/hdO3Slk1Ych2J6CYHmH4IlTqb8wf1iMBK8a0hXYl/BwwCXYyYj4KRRGi8CNEjD6YLJL+zh36vTHZ2ZeUt5omryEXONe43eHSW6UYhaigXGhkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kwiyz/ZHm4B0wBE/jfuCBdFBZIyJvaDo0EBET5ud9ZQ=;
 b=4/Ko8OoQZPPAlCQ7nrwoxnqC0am5yxQ6m5FCg472cEVQRd5vlUEWsny/0xuCMgWcoul1BAukxly3b6vfG3lT0xyYgASOZSNkZ0FPnfUJ+DQHrmaF13Rq0sBT0aJvnRLCqO3wBiQFAJxgvlC+oF74KviAV9Yw48My8gqkSfcK2xo=
Received: from MN2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:208:a8::41)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:06:09 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::75) by MN2PR12CA0028.outlook.office365.com
 (2603:10b6:208:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 10:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 10:06:08 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 05:06:06 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix discovery initialization failure during
 pci rescan
Date: Tue, 2 Apr 2024 18:05:52 +0800
Message-ID: <20240402100552.3164095-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd1f97b-3c68-45cb-a505-08dc52fc8468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWVV2/L3scw7L8tH2eoQ83q5G5yHae6v1ftmOVqNRWd0d4Wq+c+UIpU6NlZ/Yalz1EjGinsGc1so/ly2RF2Ae4lNyRocDA+8RWQYIOmy09VXCFZQ0cA6U+EOdzC+mIkZ+7zN4e0O5LOrpKVk1tMfvQgibMRmJMk78M18A70bSef4yoMLFh67E3OxhBIb75kON3XdFZ0ZVKZ3myi6ftXslkyHbWAx+qmLwuGfB8HXdaHyEFxAg/J1jJc4H0KDNr3lfjQreL8TvuvCGttbJjhbCyTvr/3Nizkh9H55KWOOaxk6/G5Rx/FyhSCYWue9RyBPGr/3+u2zgNmqOgYJqlwYgfoOiU/f+TClXzA3jpVlI/ME4m9CS7McwxwFGj0gIruqNq/km6Op9a+a3MdGTgtEta8A0ILOnp4Tyd+ftepv2iU5nCWSHUPLTzCT1uEbrsCcHVua6hSaRfRY/82Ayvc3ZcwlRJ1JOqFzkH6vUKCd7Jzvtp8y4/9uDitsVnyB1eW7l3frwgMZGfxjnHag924bqsHGo0rG+TmFakvn+5BBnIQ8JKHbvZmEuQRB2mz0qTeDgvK1evonENlyY+LjJteiTLuPnONgBziVBaCkCU3CtRtbma73kj3iQCQlS27CPg8vdEWk5oi4H6XhGkAYTTislgkZC5Nq4kw6qbf/bhpN3zr35Q6Si/pQeLFTMhHa0CbpnNoMapRn7N7PyicjAkkPlAx3jS6v8zfBD15NAg7iovW2pRoGo1O4W8EIfWkcxSmU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:06:08.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd1f97b-3c68-45cb-a505-08dc52fc8468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

Waiting for system ready to fix the discovery initialization
failure issue. This failure usually occurs when dGPU is removed
and then rescanned via command line.
It's caused by following two errors:
[1] vram size is 0
[2] wrong binary signature

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07c5fca06178..90735e966318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -255,7 +255,6 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	uint64_t vram_size;
 	u32 msg;
 	int i, ret = 0;
-	int ip_discovery_ver = 0;
 
 	/* It can take up to a second for IFWI init to complete on some dGPUs,
 	 * but generally it should be in the 60-100ms range.  Normally this starts
@@ -265,17 +264,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	 * continue.
 	 */
 
-	ip_discovery_ver = RREG32(mmIP_DISCOVERY_VERSION);
-	if ((dev_is_removable(&adev->pdev->dev)) ||
-	    (ip_discovery_ver == IP_DISCOVERY_V2) ||
-	    (ip_discovery_ver == IP_DISCOVERY_V4)) {
-		for (i = 0; i < 1000; i++) {
-			msg = RREG32(mmMP0_SMN_C2PMSG_33);
-			if (msg & 0x80000000)
-				break;
-			msleep(1);
-		}
+	for (i = 0; i < 1000; i++) {
+		msg = RREG32(mmMP0_SMN_C2PMSG_33);
+		if (msg & 0x80000000)
+			break;
+		usleep_range(1000, 1100);
 	}
+
 	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
 
 	if (vram_size) {
-- 
2.34.1

