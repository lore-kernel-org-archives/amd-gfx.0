Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE22ECAAD1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 13:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401EE10E0E0;
	Tue, 30 Aug 2022 13:33:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A95310E0D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 13:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXR1v3itFp9wl0WJWoMzmU+SY3DgRbzyix8p0Oq90sCkb2RGeJGqWl906zqS/kA3wPK2pqAARxFhELhzIwn7nb2nL7JpDXKlU/ZxeqGaGJTXqiQ9NZOUAlwDCFy12uE4VPUVmf4o/fq7p3ZkYXmrIRBJb9P8i+66R6ylRWfXr8OtUXeiq4wFkC1PYj9lSKb1Fw9dgjO9x+jDNeYMVa3awe21vsO3nkyzxrmS/dwENjm5Ru0rvkU0wqLWP6EXMdvvL/zaDo1hsocRcY4rXMYmJKshzFKbDj4AqYVdzjmxK9HPwSL5W0nnarkVmm7hZcj73Fh0pUOeGwHY33dUlcEJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRmGF1gjDwbgCSTUOmD+NAzs47bJEkLdyMWOy5Wd7F0=;
 b=kzk6X1zOG4uSx9PlvWbVrpWDMvDv1gMvssN46orBDE5nc4QoCkA3ps4//UYdhXs+wwyQEM89wJPU1g76nr9GMDW7ZjsoaKcx0hun7GC77pcfjKQDHjQy0LuGkKYvc+QbhS17g3NbPXVme3JSZdCyUzqkYWKXczqWQAHVgbfFMERmJbXY5sudFHCyv89s0G98sGcsY0AHE+h8XFBdHpPecRpN3vKoDk8kM0aIg+z8PphaK9NTv91v6To4XrSRGX2PcfkgkuUl70l+OV3k6BQe1b2/1BhpKZj5ZACfGFNvgQftMkIm+uGX6Ky5J/AirQuHCddFIOYaI4FcPhkCF0mEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRmGF1gjDwbgCSTUOmD+NAzs47bJEkLdyMWOy5Wd7F0=;
 b=jU6FZKakcNV8k81cvvlw/Y1FvrpYS15oS4L3isWHZR/j/900AtPacymiYKPpC/L2ucvjO3E5NOQDGeXoSybFwfDFuD+kTlLsi4FOPAAVzOQwuzQa7Dz6piKE7R3gXR6e1OOEeeeaU45F80CqkPadaaraQt7vxZpif/jBvRxrckw=
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by CY4PR12MB1479.namprd12.prod.outlook.com (2603:10b6:910:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 13:32:59 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::67) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 13:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Tue, 30 Aug 2022 13:32:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 08:32:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: fix documentation for
 amdgpu_dm_update_freesync_caps()
Date: Tue, 30 Aug 2022 09:32:17 -0400
Message-ID: <20220830133217.1770055-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830133217.1770055-1-alexander.deucher@amd.com>
References: <20220830133217.1770055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8c1935-6bba-46eb-fcdb-08da8a8c2777
X-MS-TrafficTypeDiagnostic: CY4PR12MB1479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9iq3YVx1zZgGMwmFPga2Dv5ZYk16W7rpWWt4B2bjRGrwbdFdKTckkZMNuX4+R7MKpBBZXfkMYaAVIjkyPTXyvcgogeVxHjYeNmjFyE8sy8maGd/8lKWTdyjWiK0guyNbZcI6twc7ocXZRTMYvDcIUunkkeyFfUMMnL3Jggn40IoANLDMq9uwRe2HirtRc70cDAA3rKJrjXWBcWEKr4wuRwIp/ZpyZHWuUi8r7ym2sNKLUzjg6uKco2b7vCMFJhtut8BZWAXrMMDFAbc9mcaFXLfU2hJ0Dgjo5T3Cv/zjbEbnDorDNB89y3hmDM0tPoUqNHGAIKHHynH8doiEPrjtUMKXQTrKFGHsWchDQcWCX0/veBa4t4gR56JKGBK7IkQvDTsZbjVTMeUlXvk2dhKTGdwYrS2k2iYWB0dxIZssjw0dYXZkHeYjSHzsVkzXXwM70H/D8chVDxkkiHdU1MTpDCNpPxaScDASa0cXwwDSaa14n0KaRnAh8B+rHVNYiaJyKqC1cu55rLewAMKI7ZXZnUrYpCfefDjv5xeulatnIj/p/g7z/Wd3InmNrNbdnDHnRBIdok+R4iRlUzrXaKFieO2u17zKVsPFoczPfdH5HOjb2Pf8dC2zIzlnzFUCexboL8ITWNu07cmldYYu5SvY99/QNa3YISxiCnW7E6eT++J/Oz5VD709gNGbKaJ1NwLU6ewaWlvRPiSRxGW0BkFX11lM0iWYpDD+e8TIGXfaZMQQ2uLik5NQVzmH3a2XFi1cdL6Jo3PD5Q1O90R8ryybXOShygxEc2TQGrIfhgwn3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(7696005)(86362001)(6666004)(36756003)(26005)(336012)(1076003)(186003)(47076005)(426003)(478600001)(2616005)(41300700001)(83380400001)(16526019)(40460700003)(40480700001)(82310400005)(316002)(8676002)(70206006)(70586007)(54906003)(6916009)(4326008)(81166007)(356005)(8936002)(82740400003)(5660300002)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 13:32:58.7794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8c1935-6bba-46eb-fcdb-08da8a8c2777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1479
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Harry
 Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Document missing parameter.

Fixes: 8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgpu_dm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 15d51d300b34..4e24b75efcfe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9938,6 +9938,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
  * @aconnector: Connector to query.
+ * @edid: EDID from monitor
  *
  * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
  * track of some of the display information in the internal data struct used by
-- 
2.37.1

