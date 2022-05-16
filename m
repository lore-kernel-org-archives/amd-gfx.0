Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 18:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED5D112D9D;
	Mon, 16 May 2022 18:17:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4DE112D9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 18:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLra85OyBwNqiBL9gBQLqpjf0cQeI7tcF4u332GeCv7boZVNDl6HIYVWx4AAk1VFyiCZxgd3a2ospf21UGfytKmXLtAG9HBI4cI3hbtRHLLN8q3NG43HnlMC72tidh8zo8p1e+JcxTVYtF6rfKPGRu3RSwjMar0c0xDtTNd0X6PXHZb+veUZCGIHYsrGAc64vq8ygsWMRtMPoqmsoFyUSdRTpWyWB8cuZE9dv3smsaVlKevyWQwNYpWLe3rEcHOA+WMuwaP3TUFnUKvSZdsBjBmqk5VR90OEIn080Agfqxl0BwMiSK7CAcnQL+XngnuJbZRqj+g85/Yq/ljxaaJ+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuolod4FGJP3ve1mUsCcOyy0h3twPP4Y0OUx6kfImJU=;
 b=LU1a+vWCmNd/GObIpgDfEi9CvSliCi0bCOg33YDRVG9Wi/pHeAb/4zZL+TjmjzhOSHgxyLOVj17c6AKcqI+cTZU6wg5ZhIb4eJ8K28juDX8REM7QufeY6obuz4ihdY179VnzFARkzfDTTSkFPftxB6f0XtpuybkEwiXRAs3Xd2k8kRr6iSQ28gQLGEKknscybyzBSkhtbKXPQycPDk8+NCMsE11gZEv6nPwxzxVlEJFQpvAMbb9SWKCgZg+H/5TgId9pzjhWlh8PrxrMXV7lJC7pwzmaiNUwivXnw1hjnlF4G9NP3tYYMoVhS4pEIhQySrV25P21d7mNpuT9Lw1XFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuolod4FGJP3ve1mUsCcOyy0h3twPP4Y0OUx6kfImJU=;
 b=EstJmMl8wRsyM/OCWbdsX107vT8Sro+CDqCv0Msub5fz/tGgLiNxC5cwqslB0oVrRMAW/i9G/v9tfUB9GK6UV0hXEaAvHMtuitG1KwmeXguOx0vXc4OCyHBC4L/497QYnFCVI1VXb0uKyaQ9rDF/rxlku2FhsvesxZoXAN+ST1I=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by MN2PR12MB3533.namprd12.prod.outlook.com (2603:10b6:208:107::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 18:17:40 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::5) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Mon, 16 May 2022 18:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 18:17:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 13:17:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: validate VCN and SDMA instances
Date: Mon, 16 May 2022 14:17:19 -0400
Message-ID: <20220516181719.1935896-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e06df0-c69c-4514-7d4a-08da37685cdb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3533:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3533C2A31659BCC6325CB559F7CF9@MN2PR12MB3533.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXlEx8PxhO2IBoiZjX5vUBz+TOR3TFWteP3rZKTEu2kRx2SsnvMUkEC1vxTQIvhJBxdhPH8001AiYPXesZFco3VeRQvSkgbgnx8PEy1OP9+gjykMbGkmgL4irARwzh1ArdVCjacGICKZdWuHDD+lagwyljZwrPy32wwj8OshgiPqkB6Th+YAHvPcpCW03in3GY6Pdgf7hTpa80nAZM692pJ8HikxLY/LEKXPmQR7ZjYcNfdtRTuchy39ZtbEkJj3r/wHs+F58mPg2igQoJze1mVikqCyDIX4LnpC1EZAFfKSzBgPbPKDCEkXcu2U1TWVjxB5ST3Y8+RKuFqnGSjWo36qoIuzkXBN3nMBEgJEd/uNMEFzntVaRivIjC1MNhGXA1wExwGFIAUomYfIkNsw2Qd3adYPCyBqEFhSQUytiiO44RO0Wn52dYiEUWrFmGPrIkEYsk4SwlluCYI/y/8S9R6WFeO4W1NZUHd8gKKwW6NtWlUPbxiopZOmn/mjY3JM/id80DgSkbpVsHnT3LD1oUXXYyP10ChkIdtHpZbdukGSEH/gAGmLREZJSsuNggI3lzvFs9QneBpcnEAIwustU7CIAQ0L5La7ux3UlNM8ce7Io3QS6XWK707awTPwhFSfpgUgfteLPsfSeZyj3uLhZMPwT5cE7TgTnpsz5rLCz8IQBn6zXRu6v2d16OzngzkCHr75+BRcCTs699qDMymm1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(82310400005)(186003)(316002)(16526019)(508600001)(356005)(6916009)(81166007)(26005)(336012)(2906002)(7696005)(6666004)(15650500001)(70586007)(70206006)(8676002)(4326008)(36860700001)(2616005)(8936002)(5660300002)(40460700003)(83380400001)(426003)(86362001)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:17:39.9423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e06df0-c69c-4514-7d4a-08da37685cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3533
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

Validate the VCN and SDMA instances against the driver
structure sizes to make sure we don't get into a
situation where the firmware reports more instances than
the driver supports.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 1f4e07a32445..2c4f1adb5343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1137,13 +1137,24 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
 					ip->revision & 0xc0;
 				ip->revision &= ~0xc0;
-				adev->vcn.num_vcn_inst++;
+				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
+					adev->vcn.num_vcn_inst++;
+				else
+					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
+						adev->vcn.num_vcn_inst + 1,
+						AMDGPU_MAX_VCN_INSTANCES);
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
-			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
-				adev->sdma.num_instances++;
+			    le16_to_cpu(ip->hw_id) == SDMA3_HWID) {
+				if (adev->sdma.num_instances < AMDGPU_MAX_SDMA_INSTANCES)
+					adev->sdma.num_instances++;
+				else
+					dev_err(adev->dev, "Too many SDMA instances: %d vs %d\n",
+						adev->sdma.num_instances + 1,
+						AMDGPU_MAX_SDMA_INSTANCES);
+			}
 
 			if (le16_to_cpu(ip->hw_id) == UMC_HWID)
 				adev->gmc.num_umc++;
-- 
2.35.3

