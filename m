Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA2FC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB8A10E900;
	Tue, 28 Mar 2023 15:06:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86CC10E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEDWtO+46Hzyhrv+dSLDRdqjrf8j77YJ0HZf1JAjNasG3dEIQQ+8jf7Qzy4M4Oem/pWdrWzhwtpspdrrSHuPwStbRisQ57XpQy1Ccp6U0a2jiB/PUfkFqKIjujCEn1leb0EWAqEAsK6LsJ3Kvf0ufqIt7s17Yh3YSMJETUicvK/hNBq5xt5161rbR9yjvTGEs0QFWTIVrFSFkzX8hT8BCYdh1I/koGr6B/6h4NrcfgW7Zp6+FUs8cL0b/c0mteisMrlhYsCSQrFmHQttPa8GDjiV2zyiDfZ7AOi3g+J7VYjqXh72oPPKK4vGJwFgmPzS3k2FFA7HYYxj2dVNi+u1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUDt5zRIE0GVYQrs3cYs7NyPqlqaRpEHWVOHxhVMyxs=;
 b=NNg+5Epd0ruVGtw73XI8FePR8r6RRogk6KP+QP/JXDopkiV5QaC67YLWqSShLwcWulUnKOwTJVIjKsaOJrBbPu3o1qV+JKVM4g7nHGSD0i/CWHQiaFTnLw31GNNwbZ7P4yB5RRDroTRGTqMT3z0fGLB3BRKdycXBFExN0RUcXmJxGDDb3A1aJhq8bjLHPSl32O3VEdHhnUhz5nJGOQu1A6Gxex5A8+Xx//zI2HJ2v4IQkEyPZKEQpb6QQmgrSfxDuRTxEiiRCzzUQ5xc8s0vhdKEAL0Mtm/GP6XSR5t4OXG8EnlSqwiQiq4fAaUmWMjOPoq6PiEUHIyNsxJF0Ca4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUDt5zRIE0GVYQrs3cYs7NyPqlqaRpEHWVOHxhVMyxs=;
 b=T98iQwzLmSyejVLRDoy9aqFSHZBVOFyS0n9LAKWurBPABld61xEc/uXaJ2X6MkSAQOqn0ikKFYD8Ifhv5Ls6gUBTj1ua+zU+vcBB9FLDHlLgf2hCpsY4U8FztYMjtKChJ+qgXWBNed6+9YnO3K0riKCec4BO6sVeSMfJOwChj/U=
Received: from CY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:930:1e::29)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:06:06 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::81) by CY5PR04CA0022.outlook.office365.com
 (2603:10b6:930:1e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:06:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:06:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/vcn: enable vcn doorbell for vcn4.0.3
Date: Tue, 28 Mar 2023 11:05:48 -0400
Message-ID: <20230328150550.1933519-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328150550.1933519-1-alexander.deucher@amd.com>
References: <20230328150550.1933519-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5602277c-8b53-4015-62f4-08db2f9df437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDevcws0Xm3H/9a/1J8Q0kVlV8uWN4Sp2FX1O1RO1TlYQrG8aDWhLTQRPn34PyepeQGpTtCRE6ff4yBpXEqfkka8NbPM/JkMQQJasl7LtJ3w59igvw6I7UTp4t8Y+dsLB8AqHv42X25IJnEPGplmO1nV4VWN36SoZxKI2Maj2F9r03sd5zo7JYdZV9bseGR84WJWYXk5XbGy+7WssDfJxJSlYoMDqTIjto4MXpj3vsV8wvln4jRewraBT4X3DZa7AIG9ihxzEIv5HCb0jdmSYzxyi/bJJHcClZw03IEzaludy9LIWlHReW8ecZ1b763u3AS0LRTN8xV3N1sCGKRcaFbnbD9Zc0BgBfRsYjzyUxGorONa27c+rKOOryexm2vxI/My7n/oXHq878k1am9aQM01ZEoIFx9phTtnOk03GrgvIjVzZ216pN/AJL+NO20CRSpHKDQJmfhEg8fkorwtsHja3n7P4rDDndRvlkpWw+mOjmrjGYyC+da87P0qXmfowtQ4Mnvmt+zGOnxK/G1D8aLig4uuyTNNRrBRQv2Q00Z9ZD/qhPZQdooYW/6jjsalBN7gGJLVUD816nZR6wcNsrcB6Y2r9s3uL/sqwapFGvu4qCLET4oXU7D5NcPXpqtOuu6Hggtlg/rGni0akkB8Z0FwINkIZ0RxaCNB9blEfDzMO5xVrcVBZwQxGML5ozX7ua8Xv0WDeQj4GqT8BGecyobdMkXb4sHaV5lvmREB8iM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(2616005)(426003)(83380400001)(336012)(2906002)(8676002)(6916009)(70586007)(4326008)(70206006)(478600001)(7696005)(54906003)(40480700001)(316002)(1076003)(26005)(16526019)(82310400005)(186003)(6666004)(36860700001)(36756003)(86362001)(41300700001)(40460700003)(81166007)(356005)(82740400003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:06:05.5604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5602277c-8b53-4015-62f4-08db2f9df437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn doorbell for vcn4.0.3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 98bff162f453..4418c9f05ec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -109,7 +109,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		return r;
 
 	ring = &adev->vcn.inst->ring_dec;
-	ring->use_doorbell = false;
+	ring->use_doorbell = true;
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 5;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
@@ -174,6 +175,13 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	int r;
 
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				ring->doorbell_index, ring->me);
+	if (ring->use_doorbell)
+		WREG32_SOC15(VCN, ring->me, regVCN_RB4_DB_CTRL,
+			ring->doorbell_index << VCN_RB4_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB4_DB_CTRL__EN_MASK);
+
 	r = amdgpu_ring_test_helper(ring);
 
 	if (!r)
-- 
2.39.2

