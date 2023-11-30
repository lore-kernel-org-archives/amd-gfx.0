Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D2C07CA9
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 10:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D653610E045;
	Thu, 30 Nov 2023 10:46:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B0010E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 10:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhZ1pFxwSAJQtfXnSW8LBN3tqHqxKKhU3HnoazvGNqhM4ACYJ+iRlpFrhYEALhAiyT4cKLk7PPF9n1kYAKDbsB62aG4NMrpIfoz/6IXTcEPMXuc8cAxLqwE7K22YtXKTMY4l+6shTpeztJZwUYTDuduT/smKXwdyDa0n08LTRKVmOpbwvD/j5ODR1dhIIdkFhbNWCY9Ks8iIZnhK+a89naPfqaP7LjDvMXM+tz5qQes2D2pIQ9Ox6Hpu6pPW3yBJFUxI5puIL8ZAjI3RBIlmagJ4LW0G/1B1vRBRbOMDWyiUSM1c3j0iUterjZjb6hD/S2L+n9PfZT0Wnm0xHHIikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUB2bXaGst4RHr4vBCBVprYqGNuV4nbDT6v1ksRLZrY=;
 b=IRtlEs1XR5Fyz5vf2KLg9bdClHUqY9CWfTqPXLIqSpvVufrcun2rtfqhXcSJdgzHQLzg5eMV5SSoTcqI2Fgow+joeRToNmOGdRuo6vpzuG1Gu2DbSUkwsMuBn4GaQQl+IKfTtJpEzZJtU4ITaaQeX8qPcdhYuT9TZbDwxkcLkWFKZRKNd7L8ahIK8nlYGFiT37aCWU+bJyD/a+Lt2KDICHHgdbaFNKS8UYClFBpU2KurgJw+9sM4mJ3WtnRUMcJoxTgStepCNUTltv9DqqKBAeT9IKZu3XTReimX8lF6lwzjk91Qopo9YHvx3GwjCWk0T2N1exzkRetmEfg3w29/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUB2bXaGst4RHr4vBCBVprYqGNuV4nbDT6v1ksRLZrY=;
 b=k/naIMBSV4E3KlaZ7+E+iWKp+iBuo2hM08mTm2cG73cVfWA9lWKrIRO1ptojk1/roj8OuKDRq2nEY6v6l8iLeKU9aZpf7LLRDUUdRCwqgzq4zfvlHym/GZnUEPWIQQ4aw7+AsaGSxPpbmsPLb1iul/lok6Fr/EW2z691Tkt+P24=
Received: from DM6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:5:80::34) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Thu, 30 Nov 2023 10:46:38 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0021.outlook.office365.com
 (2603:10b6:5:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 10:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 10:46:38 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 04:46:36 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable mca debug mode on APU by default
Date: Thu, 30 Nov 2023 18:46:23 +0800
Message-ID: <20231130104623.2005351-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb3a1e2-8632-400d-bc8f-08dbf191a161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M305IK7s67aUhWTN8khXrDCKiKTpdc3hnnc6Lutw1cD5TYV5bWnXhJRsuphB+qrmiwhJka9DsMA+UaN5vjj2e8RFWI8lzddnL5aJDGtCCrSRfXKLTySTr5QBm0sOXksimBK1EhXj2/w7tzVlUKA1uWGwnTuM+NGjgCeWpc0by4jRkynpzFPfv51jHPYGkGQpIL90jpP4kA5Ce9+36aYq5R01r2tuMwonbedXaZp9rpV0u2QN6ady70PW+gkHJ6FnJDOBqpHZCziF466iwzqovfkSfFb/4jJHhDETX9ul9h3W7OSFrP7YNxTkIYJVYudekKv+iDnfqMPww8rJTzP1It7//lYWQw61gig0G6hAMHmgkqXgav652LX5Jlo5cn1Nbe/0y7wN27gYUk2r7XAKlW5+/lmamROFDAHNJAEXFeJr1TyKF1226RuDc9A2a5Ic0YdXQHccKCmIdCnxj2kp8E09YiuMQk4mHY/wvSHmaNF5mouWNb1ZFJaP8BNApDpaRAqcztVFsaFLYCJg8gKi8GLRkwlejm6Zu+qcwdFs7fjuBxe8S8pmXOFDqDqymsSBxaYpL2Bb2+HQWPwCgTk3w9WpZzqFUTRTVTHHQgj6jKndEGgwUNFiLf4JWc9v2RjOUhIUa6oju/+sW/uJxmO+nT59r7MpnbzHd/T0MiqHPF6+uHICZaRGcWBtz3xjlZD0FUqit6m9FBLNdKwWGnZaLC7nePt7WZ55l9geOxPF14Hqop03njoYsuwdOouvEf0IB/Pvs8phl2W19508bjDSdf85QJnYyAOucvCKP+5CiHmkB8BcsKsW0sv6MDYyQbez
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(2616005)(336012)(47076005)(1076003)(26005)(7696005)(6666004)(426003)(2906002)(16526019)(4744005)(83380400001)(5660300002)(54906003)(70586007)(6916009)(41300700001)(70206006)(8676002)(8936002)(316002)(4326008)(356005)(36860700001)(81166007)(82740400003)(36756003)(86362001)(202311291699003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:46:38.2052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb3a1e2-8632-400d-bc8f-08dbf191a161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable MCA debug mode on APU device by default.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f6b47ebce9d6..72634d675e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3132,7 +3132,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	amdgpu_ras_set_mca_debug_mode(adev, false);
+	/* enable MCA debug on APU device */
+	amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
-- 
2.34.1

