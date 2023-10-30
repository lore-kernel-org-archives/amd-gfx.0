Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA32C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 08:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825BB10E242;
	Mon, 30 Oct 2023 08:40:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08A710E242
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 08:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFr/Detbez9lSRnQ/MiQzZ2Qm3e0956/ZnLsRAZvFEcF5s9/sVML9jzMY512BkcJjTMF4z8kCGOa4IfHvTgfT4c0J9jSAnCyf/caEDCf9+p97keHkpDprsx6WNZ1nVYqHfjlwgUD/mqmMNWYdeKWZ3owSzdbBC+eV+yJryjn+ZX+K3dr/0oNV/94AvrA6BoXRM7GSQfImTgPMTlsunsXFMIXN9SjVTllT+6NWW84E8X9+MsLg3hVPAksaKd9vG9aoQLcd+hif9B/HgXddL/pP96QAoy1oXUyN+HIVLHJ/wUdkpxBpaSvxSOEFL69JAgRCCJcWJx+hO9ixmsGlXxAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i+XOuxiOocBaOeMGQDCMjn91WUsWKyvt2KJN2DKXQM=;
 b=L+EgFVSWU/Gi1x/OPbcdRBwgRr3tjIaFbocaKc5j9IAksTrRbMLeKJ2MbAKcmNjXsHSjYq4HfsejTmjayJMQo+hqS7yQ1LCtjCx9CWD5IU2XZTXHQbTszK19cEVf+d9Gd5bD9trcXOJtjitsLy5UNE9IvVYOB2yzDkK95Tf/VXMOEW17dpgAYgP999aPk/vcVSq3CzO3tBk8Vromzbjnh5Ww9ygK8a/17bm4TthLkx3ZO19u4DpXnaykYoDtEuCV9uRWudYLggpVy3GzK/rkJW8k9vzZOl2QB4e/q8WtK05LmUGJGucU/OqB+U3KQYXGo1Peu8VoAFMZtu/GTV6w+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i+XOuxiOocBaOeMGQDCMjn91WUsWKyvt2KJN2DKXQM=;
 b=TzT2/ACRbjZr3g39mmIrvQcZIrpPEi+6jVmggZmfY4IzqL86+tfNxio3KZoBIV/OwgAMom6om6dV18/gvnJSJZdDWv2mCEwygnI7MsxqZDX8ZGlMiKs02YEDIcXQPLPPgVKx3MfyFWJHann106qESdo5PRcJoNLmke4Z3I+pGqc=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 30 Oct
 2023 08:39:59 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::15) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 08:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Mon, 30 Oct 2023 08:39:59 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 03:39:57 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: not stop rlc for IMU enabled APUs when suspend
Date: Mon, 30 Oct 2023 16:36:57 +0800
Message-ID: <20231030083658.537469-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbe2210-7fb2-4bbb-1915-08dbd923cd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkJmP63r2qnxJ6QvWrFrKmd4E+ZvZoBaQYQAZiVOqrJAXpttfN7RZoPEf5DmmQQ/8NYnY9Pf4UaCAZ0Bgc4csBzobDP0wnf/raMlg/gbp65BY9mcm4YDU6q+6Zatw2qg4/kSfQJVW9nQwIYYGuweNAa/PtXtznsL1fLKNjqoytzk7UFk6D/1dGXP9d8eVO/os3NHdeH/C3OeLfj52RbrU9OmJ6K00H+TXnwjV3UXj5PXpl1U9IJNA1rFfp2LYqgU/sGOzcKYOxqU0m8Fzz1KNI+EKe7xvRauc6UFkSkEyxjOfBPq/oXJuWExiJ5CHfO4UA0W3sfwYUX3vGhR7oBCa8xHkK/ogPzFu6DNd5Jm463UJVykRKQKi6aw+OwaUg5VSs/GMLIG54vLXzzCkStiiOEIn0Wn4YO5GX/O5aId/KhtTEr203NXjrG5x9P4AjTsrWQRE5iTuGKmrYgJQvw97bPKkom/i7cF6YVf1HP0t1rV8PcAM2g/++Ly28+UqZhyhecxYbYrshcIAfYcB1Mm7fHSo/RFkrPog8OQgnQuBXu725/4oREqqU7v+p3Wc5YTfY479XenY6Rm1qYo1xOXoh4HF/54kOxYD6i+7n5EECKUNm/WYzXs104eOwTjV5ttaj39LvpvbSSQydBwgA53qSSwfbyrV966tJVVUkOzM/KJetK1tqO3rX7IoE+yhRABzD/vQU75/q5w0Po4BGFlAQ4m7qgLM1iJkz2FdXmxK6bfDmdJp8Q7yiSz+sU8ZJawDfK218yJpDZu0YSLwMCCuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(4744005)(2906002)(36860700001)(40460700003)(5660300002)(316002)(82740400003)(70586007)(356005)(70206006)(54906003)(19627235002)(478600001)(6916009)(7696005)(47076005)(2616005)(40480700001)(426003)(83380400001)(336012)(4326008)(41300700001)(36756003)(86362001)(8676002)(15650500001)(8936002)(81166007)(1076003)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:39:59.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbe2210-7fb2-4bbb-1915-08dbd923cd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For IMU enabled APUs, after sending the PrepareMp1ForUnload message
to SMU in system_features_control, the RLC registers can't be touched.
The driver to stop the rlc in suspending is no longer required.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 23b00eddc1af..5fb1c49e7e2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1711,6 +1711,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	}
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
+	    !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
 	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
-- 
2.39.2

