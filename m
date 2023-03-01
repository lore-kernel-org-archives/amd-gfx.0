Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9232CC678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AD410E26F;
	Wed,  1 Mar 2023 21:11:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B16910E26F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTskzKOuSMi+3E4L21RfRDhNQy8t2HSZOJIPJN3V5XEj5gR2RFDIVeyLEBDslRAjsjLJugF9eXNby1bOXRvjVtABN1W4HhLL8TpWvtBgPrQAhAc1+r4imE98fmcabuzCXK7HhzdyqWWvw11vH7qgaFje0guDVeHyxLjjZ84Z2pM5y+6iwKmqTvPAm4xspJ6c1EhAQ4o80Yz/B6Q9pTdzJsyriruZaorRnQLwtbAO7+rOlsfNAF9Qu/FLmmd7tZvyaSJ547jaisFCVLKL6KaSDZAa7GGHvxa2cwIrA02hoPF/ncPz3PeRK1LdUGIpCT2DeEY9ha3b8I6EIWQALJrCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3HdULg40SWfdKBHue5M1XRzjmbkliMRRpXsMLy2cFo=;
 b=NBdmZBaB+MmUKhManTweczDgGelENtKZfjTmPjzloQpwlpZFbqojkGjeGLKHq/tvU91qpiTc8B6u83JH0GMCdgxUb0GapOKT+tWWPt11SPES4DC02l7aXQT7s3lhipON2Aw2CT4+BYVaxKVtV7pgoRi0tKIJCd7U5MMhAuWNfoOL7NVeGjGU1NSzcjym4ZzfK9YB5V0+vB9cUy5o4+eYpPb0y8RJED2DZZJ1mlEpQNEnf+oC+iVkMrl/hMWhtQD/3nZ9nQfSuWX0YxEQgwCKTX1tMLWTZImoHiA24hwASYPSELIdMLGR32hHieAY6KZa1T8LBKoJFZHixAs7gOV26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3HdULg40SWfdKBHue5M1XRzjmbkliMRRpXsMLy2cFo=;
 b=wvlY/Mk0Ifs26GATdGUIuvVRwXxKe3EAMK52ivMvQWzsIeMJrP6eV9+fiPFpk94tRcF+SDuTu+OkWVx74Sk/o0urLqARCqPga93Hr0HgEqwnjgLDusXQcankGlh+kqIVdcIHEgtTfms/CTR/ipkF+qZmOoZDTzyNPsjLL+Uby1E=
Received: from MW4PR04CA0236.namprd04.prod.outlook.com (2603:10b6:303:87::31)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 21:11:23 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::72) by MW4PR04CA0236.outlook.office365.com
 (2603:10b6:303:87::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 21:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 21:11:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:11:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add HDP ip block for HDP 4.4.2
Date: Wed, 1 Mar 2023 16:10:47 -0500
Message-ID: <20230301211047.2098597-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301211047.2098597-1-alexander.deucher@amd.com>
References: <20230301211047.2098597-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3504a3-2c21-4906-7be0-08db1a998288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wIhP8Ol4m1bVEhgmlXZS4aCZTOA/SjyMCQdIBfICzbwBUDp4TLRA4/R1l3QBIChTjocOwmNeomErZmqLXIJRXrNprxLAVFio0gyDg+V/P3k9c0nV//y6zlAtqFuaZ1DUEldZuxA3hkpqSrCfetMa7lKYmKuoi3AduUGKs8i/0hiFKTlIRPVGcNhgPksytmRUj5MB2z0sfPXJn830LraCQU79dq3FIs2yj+bRg+2vXS/439knUiFBFd/KFGzD4Q2kfOCfDaK8ajSUZXIl7YB6y1mcySk8vhWYhWxeKWtBV0Zp++yQYw2kSASJXFAINKAnWsONZBqTdxWs2hJy6l2U3q3GVONzp6N+X49TxybIwEp4dQEAaBJDy7Ggltb7zTPaZvyo5Nnvr4c673Fy6zPr4ZsNdeH4agdg+x86PEIHaCIwKycGuXUwmnYXnB/5VN2M4ZN6HYs6P0fzRuCBJkUqDDT5J/LUo5cpCRoIiLmliMNmjqTWsVev/E++nGhKegzvlla01/myrbcF2Drh3+GwOY/ztgd1SF8n8TWrBlbdZNBbw3ugHAXK+03dhrVLQwGWyzpiG0BUgpL8ns7LOgpoCcM7YlvNuPA/xynT1wBF7X5WW6BCZXfhM69VQvPizxyMn47smATLjbNg+ec2lattlXu1MG+MSWrhYEuwiuQ1R6QWoxPdSsaKWkayM8TwfKDSFpTrg5lAgC3eHMrpYprqwvhTaXXKMHxXP8Xpu5GGmA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(4744005)(5660300002)(82310400005)(478600001)(83380400001)(47076005)(41300700001)(426003)(1076003)(7696005)(6666004)(16526019)(2616005)(26005)(336012)(186003)(4326008)(6916009)(70586007)(8676002)(356005)(70206006)(40480700001)(8936002)(36860700001)(86362001)(81166007)(54906003)(82740400003)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:11:22.3795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3504a3-2c21-4906-7be0-08db1a998288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add HDP IP handling for HDP 4.4.2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a610fc922df1..8b3ebb7d482b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2297,6 +2297,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 0):
 	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
+	case IP_VERSION(4, 4, 2):
 		adev->hdp.funcs = &hdp_v4_0_funcs;
 		break;
 	case IP_VERSION(5, 0, 0):
-- 
2.39.2

