Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C6C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 20:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3943810E752;
	Thu, 25 May 2023 20:12:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B1910E752
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 20:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwgJNDend43dra63MFTluO3hjmLh0R5s7VBeYmrC1n2DaCvyct3Lzxt9z8oFv+5m7IfSBBt909jtUajkUNmXTLgQSk4M50YJ9yrWgBZoG1e3uW77WMFuVucnien0Tvn44s2dqpcMkXVc09x3+7JZTF2fFI5UgbegMefkCWvQi0eZPZAZ6AZNXG79CPyF8eGe7BezlLbT4V541sbsBICfvTN38k7SdjblWmcKM/HBjGNCguDDMd0WRh0lkzb7hs54fEIBnXL/rQK45QxV0IXEvNok+UtSnXOfLhkdgDmyfEWDkuhTX6QVDEGK3Tnk8axiX4nKQ1mnCD+A59bXhaTRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yZ9q/jyJXabHUTJsT9uQmIqWrARwkSWzhCdtugx2O8=;
 b=R8Sq+kNinv3+GvJz1YhBcS6tCBFRWnNhPGhh9Bod9KNCWPk09wqjQhB0gCgLjCBg8pGPEcZjbaio1gxFpEfeEzfWNS4rm/XZ05YR4fB2y/2JMlhOXtZEHIbo0j1Ra1ouMxVT8mNsCDGgRoXUV4/Pz2KaTzUssHe3pUaBCGjeDJsItrvRvJxt6WcLWVt6lKr5szj69RHzlEtk8dCRx0uI04OoQ/r39hVGuHJoI/alE4x1QCe53nUq229szbpfSieUaxjrtlNKz23ZYAd0JWfoF7mTMkWMbvGzTc94TjwIRgpmN66uTYXNBGbvm6LtYzbhTQDVNxpJLfJdbom19uBrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yZ9q/jyJXabHUTJsT9uQmIqWrARwkSWzhCdtugx2O8=;
 b=Tt3KzNtrQKnOmBShkymT0weFGF0QXvzSIIo3Lx/m+ZR899Y5hIKxvbvcrT4VrGCp/7DoL4gX6brb6gel1y9AhaKv2KZvMsayxMHcwbwbZ9iP7CpE3QAtsgX/apAgBEo7fUs2rkeaSy42Eglp77JxS5AU8dHdJ7ps3ETBodhrJe4=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 20:12:52 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::f3) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 20:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 20:12:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 15:12:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices
Date: Thu, 25 May 2023 16:12:34 -0400
Message-ID: <20230525201234.1138937-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 83904dd6-f682-47a5-be99-08db5d5c6b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkFjbUZuDxKr9yosn6TeBg+0bXO8QW7iH1F/affvIzHCwy5meONc1eHBVgYSVY8I32NI/yDP5mH1DnkNwCvnkbJyJPQ0tGXpwMfTxukPUgP70Wc0fjbm6RSHqKE/ecw1bNNclcF2IIGmleF58ERfia1lCfAybUmuf6ijpX1bg+WO63YlhkZyRNgmfjFs2Tt/xUbojZXLVYrglhVG6asHHF5UAhN3K7Np3A32xEwDlnEIFhBDs7fL6PIMgdPaKvbey2h8gEVLlPBs11aq433HTHVzfaZz7IGSw72E8jT90+6lTcmsjnmNX2ZuH8QtPLKcXhgI/6MQj2aF61AxcGtl7OoGz/WvTUXmCLZH8bQ3H6gEWTdJWkkeh3JrlioTPJ6aXI+2opUHZle4gSU5c84tzunnRssr1O4fWWEwYnLjth8TMp4AKBLZ1eW7hmgbSD6Ar+baSX8QPq9/K/ziTTH1SriBr7aA5Lus0PKVAiiShvL7frjGDzZYHVR/o+gGJ2AcZ5yW+crqWSumNgvjxJRFNyvit4HVvN9+Scy8HAc6T9KvIQ/fcZuMxxqxvcBr9s7NmYFkXEZ7TM547vw2S6MU6qrRU+GSJfJvsDY6VZDb0hiI+EoFu4fezwHjmPPq/2m3pLKbeY+qTdj8ZUoDAF2freAFfNvv3mw4p2JPWYHe6PeRnknSylJTjlnKUsD+9c1CRNjXZrYVwEtOanXdpb5P6XoxAuDr7wCqvuAxlC3JJPenrk08OugZHffo27BYljqJnGlqFTXfhtWkxcHUTDTHNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(4326008)(1076003)(26005)(70206006)(6916009)(316002)(70586007)(41300700001)(478600001)(7696005)(8676002)(5660300002)(40460700003)(8936002)(356005)(2616005)(86362001)(83380400001)(2906002)(36756003)(336012)(426003)(40480700001)(82740400003)(81166007)(82310400005)(186003)(16526019)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 20:12:51.6254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83904dd6-f682-47a5-be99-08db5d5c6b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

Certain boards with GC IP 11.0.3 need slightly different handling
in the shader compiler due to board specific bounding box
optimizations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 862a50f7b490..ebc3c3f965f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -411,8 +411,15 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 3):
-			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
-			gfx_target_version = 110001;
+			if ((adev->pdev->device == 0x7460 &&
+			     adev->pdev->revision == 0x00) ||
+			    (adev->pdev->device == 0x7461 &&
+			     adev->pdev->revision == 0x00))
+				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
+				gfx_target_version = 110005;
+			else
+				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+				gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		default:
-- 
2.40.1

