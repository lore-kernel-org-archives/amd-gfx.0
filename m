Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D4C64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 06:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B3510E15A;
	Mon, 27 Feb 2023 06:45:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B37910E35F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 06:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mONOsBYfSkp2eA5hUDTNnSEx6ftsCbaRIaqAFuTmyosTku3e0o6pPzxaMAeoYMDktsM2xiZE7625z3XQYcozINVYWqCKm7C9H5onGsQZ4893dhpyAKb7qJLL2PxMOHScVys51HRRDQ0Iv5S8x0bQTRm0jQBDp9Y8Pm/qGfTnB1vCWHdde7rjAszSZFn+oNr5ls5pi2uUJVaOt/O/rP7Z0HOXFP32N4sqs9eJBgvOUN/tfMAYmOQRhtQYkXDdDEdAtrVF3M879NIRnEhpkcGSApAQYw7p8efujkHVAFrzR5HuPXm9/aiOsTZqzy7O4Jh27cs0iPsTuq8TktQO8ZwSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ1OxLm8RiVVuq7eYcvus0H8SqAZU6ZsOKBtG54oYZA=;
 b=OYczSd7DK84OXXVZKFGLFyKfkQpO28+1JwP1nNX3pauZKUXG0s4026iONvT65o5feOfbWKp7LYl2JvtGjOa8rvDAyENlj4Cf3saDrGw9srGX9hXjoUfITqAp5gxYY2f95fNxzMmZb0PlzMALTPZhbQKT80snHWjWAqllR6M0F1MEF7CSE23qczyTEcA33vxc0unnllM1IWds3ARr8oxPjk8Frmzm8CwYB57A5wkMj/GOvPyt+dhO9jNFh6hxT3AunhsvYOsu3cBdOX3eWy8GMkmm2PtYe64JeqGo6VMRQEM096akeWNJrO0O+oYG7YR7XIv+6yn0al++sGO6DT5Bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ1OxLm8RiVVuq7eYcvus0H8SqAZU6ZsOKBtG54oYZA=;
 b=HK96E4qmqQMbNcFKnKE8dWBD12GAULHK57wHv9o0WAzylJj8s48Tzsm2S21tUdUOZdnTDMfOPEFSqh7eHRsVvYMSHtg2yy8Bm8MmWbyYIDutsEM1WlwRP0WMm60Z4eP0XQlah36rbo6mY5rsZP4szJC999ZU0fR5kK3VGA6ucLs=
Received: from BN9PR03CA0439.namprd03.prod.outlook.com (2603:10b6:408:113::24)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 06:45:47 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::a4) by BN9PR03CA0439.outlook.office365.com
 (2603:10b6:408:113::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 06:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 06:45:47 +0000
Received: from leiyaoyao-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 27 Feb 2023 00:45:46 -0600
From: Yaoyao Lei <yaoyao.lei@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Stop clearing kiq position during fini
Date: Mon, 27 Feb 2023 14:45:30 +0800
Message-ID: <20230227064530.2699469-1-yaoyao.lei@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ec8685-c54c-49da-989e-08db188e4202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJZsjGB17SjsEb0o61ggJYckIXZG8EbOuUJ8e3DJ645ekKqSyuYZjdSOWBM3dFXnYXRjyFt27mV/062IAphlpsYsW3oY+bYVCD229D4rHPMY2jn148E4Dyi+/iLyJ2smZpk6XKgp4z8Q50TGMTlJDcjr3rPLCgmKzpcESz5fR+UPsMbgd4jAMxM9sYS4/kmCLg4QNpx0ZIvnetzPzWY9HWKXKUjId/a1E8zTrOserL2UAnluwUJgero/wQAi5IDNzumYwURDs9AcYD0AOFIEjBR9DR73ScIgW1w5OD+zwxlWckvvpjwiQze9gcMdbX05QsmBP+NlHTBlfbPlIaXJjC6gMA7tvvC8wrz7Li6HpvBRTYBC7f865K8z5yU+IZgfZogak/MqsUnEElej75Cv4n9ERyZzp9dV/kaUtNZ5hZMcgs5ugfPmHTBwjMWzTI+dkx4k+WrXozwOHjSiFV8F7hhLss0a9+YvSVSQHQ6ON7etx7zRvjbIFU6f2ecl660Ia9ldBmAjnHYmxLCJkUmdd78KuKuWZoljL8Kgrm/zkjHy3UZ2rmIZW1YWVqqCKKyqG3gIU+JLKj3z+657/pGf9HRU7c9lq/7LQHfsftH2zUpNBjrnSTFXAfSNsnKFPOh3KcXfJKOVPPGeeIgc8OamLrHtNj0QlPzVGjyp+0pN1Q67ygr6P+M+/owbClo/mK2PcknbTGvtBX7CJww4n/FxcCVIcnRVRpDpZjf154ugosQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(8676002)(6666004)(36756003)(40460700003)(36860700001)(86362001)(8936002)(82740400003)(81166007)(426003)(47076005)(356005)(5660300002)(40480700001)(478600001)(82310400005)(2616005)(186003)(26005)(336012)(1076003)(6916009)(70206006)(4326008)(7696005)(2906002)(44832011)(41300700001)(70586007)(316002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:45:47.4477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ec8685-c54c-49da-989e-08db188e4202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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
Cc: yaoyao.lei@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not clear kiq position in RLC_CP_SCHEDULER so that CP could perform
IDLE-SAVE after VF fini.
Otherwise it could cause GFX hang if another Win guest is rendering.

Signed-off-by: Yaoyao Lei <yaoyao.lei@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6983acc456b2..073f5f23bc3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7285,17 +7285,9 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
-		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
-		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0)) {
-			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
-			tmp &= 0xffffff00;
-			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
-		} else {
-			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-			tmp &= 0xffffff00;
-			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-		}
-
+		/* Remove the steps of clearing KIQ position.
+		 * It causes GFX hang when another Win guest is rendering.
+		 */
 		return 0;
 	}
 	gfx_v10_0_cp_enable(adev, false);
-- 
2.25.1

