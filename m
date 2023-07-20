Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBBEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D69110E557;
	Thu, 20 Jul 2023 05:56:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B7910E557
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvbt40lrJlRjzFuuNaV8kzeJqZBBATFqBVUDpovNEWQ58l0/IFjjDlTbv77NFGTAQSxT7mbbl3eaTWLP/i28cHBR1SLaXJP/uwnroigdT+/BDIJ0kcB0aZ9OqgqeS3JldZLadDgK/588ms0tvy6q+4SMOfDfFvF4q8cgjcpfaT/mD5yJB80IoupvXnAXUwyd0cDp5PEAkyV7eveBl5ZK1Vgw7hVdenO5o3QzSUSgNnMiCJa7jvi/slymVfDPVDwvg3xV1fDuYkO8eNpivAyQFQU2pVTBP3YSVOl37kKOozvt0O3FsoyjKwYscEADS+aute5M0n6tqrm8Ks3VBclCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AoF9nqXxgz1apvJwFJxRg0JaxabQHZ4fFUyrppsX54=;
 b=PnouW2Blaj7vxvgP+td4DaGiNW7q3tg8xVbRaIjlscuyiggmHsT6j+Ko43toa7+g98HTCq6LFTyMOERU/uiKD8gCPHYKV/VDkJ8Y5cZdPB699ia+L23vO9/pZdG2GDRZKo6gOko0C9RR/6YiktkDAtnzQFgLNvn6ViEpVsKHHnCJO3iE82Zw9M8EgRQ94l6e8PpcT/RdbTe18cJyBsug4nbxiD27Wf3TQMOfUbsJ2DB4dd7B9zYD/6wTJXWTqF0WnAmy8NBUUfNaMDwDNIpACnpBE61gmLu7vMLiaSUATeLKQareSd9yTOjnbuJqSDOijRM2Us3TyqoOGjPEU0VbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AoF9nqXxgz1apvJwFJxRg0JaxabQHZ4fFUyrppsX54=;
 b=0Z1oQU9/HHUJT81yINf840/sdBX27/dgdv0V0n5HOGyWDHpIk6psYfVkCJci2Sk/lCnYTN/3yUM8qqzvZ7CWujAZklT+UmxTl0ukKv5W1V+VfR2XdtLPrnQ7b4LMcTV8Muss4DhSSOgAC4WZu0RDJeG0i91HR80hwA2tdF9rE6Q=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 05:56:42 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::96) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Thu, 20 Jul 2023 05:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 05:56:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 00:56:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Program xcp_ctl registers as needed
Date: Thu, 20 Jul 2023 11:26:24 +0530
Message-ID: <20230720055624.3063280-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 50436872-8bcb-436a-0277-08db88e6174f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: romoKYbXRAvfP95XmzFCZJbwsmitIyHE8/7rpl+RfK5jHaqzMyx3CFdOkfFBwqNbBbaNABWEfn2RLaepfPvQff9EwTkttPNwZKImQkbPDRYJhfp5UftmaDm6GMdMehLpb0GV5b6QYuqZabqL82cpOspZI/RpWHHk2wp6UnOmMyKFVIjHjMeK5juNpkZpWe9wCJVljPjj6VDkwNwjuNZlLyKG36G6SzF1+FPwRlMWBnMwMYS3nF0gQu2OLB9qEcd0KUxRB/TDCe6XDG7GX4iGFvSwk6FzlAQTMQqrPOPjoswfzobOSEjPb6zVRrZzgD0C46jyudwZwNvjA2e8j/HXD9xu9XeThkNTsAL3LoSz6s9izTeVoLThv6rRMsirQ8qDOlZvu4rAteP6wxOo65CZLLmvM4WpzTwUgXGxaj7ecT1Fb2GGbnM+IwERHCGjCRnOiXmJvBmmiGtFuG8T0WvCqnc74dshsTDunp9IYmsH5wq5FTht/d6BmRM22RYP3AwKITxwGefF37GCxNGC5+j3OuEjNWNE4ibDr6c/z4D/QekZ7AFpCRYm+quXNqGyRAVI1oMh33L0TAKl0/JQ9FuL+KdGfkA6On3CC8QBQGtDh3ThCH8Esg5S8ajHlBEMfRmpKr6ed6JUtJvRjQBEIsGRM9dhieDKXnsPFEmU0XvnPPOdUuZNs1ICS74AfP+tbpmxey+bFQL+SBVF1KHSPCwGiH9c9msIpuYaChXzBv7uQOub3Rurircx3J7E6LMhJOXpchHo2kdZfx2FHX+lwfjLZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(54906003)(16526019)(186003)(336012)(1076003)(36756003)(86362001)(40480700001)(81166007)(82740400003)(356005)(2906002)(47076005)(40460700003)(26005)(44832011)(426003)(36860700001)(478600001)(2616005)(4326008)(8936002)(8676002)(83380400001)(6916009)(316002)(70586007)(70206006)(41300700001)(6666004)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:56:41.7185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50436872-8bcb-436a-0277-08db88e6174f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
Cc: Alexander.Deucher@amd.com, shiwu.zhang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XCP_CTL register is expected to be programmed by firmware. Under certain
conditions FW may not have programmed it correctly. As a workaround,
program it when FW has not programmed the right values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 738226ed6e50..c567be88c47d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -621,7 +621,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
 {
 	int ret, i, num_xcc;
-	u32 tmp = 0;
+	u32 tmp = 0, regval;
 
 	if (adev->psp.funcs) {
 		ret = psp_spatial_partition(&adev->psp,
@@ -629,23 +629,24 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						    num_xccs_per_xcp);
 		if (ret)
 			return ret;
-	} else {
-		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	}
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-		for (i = 0; i < num_xcc; i++) {
-			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-					    num_xccs_per_xcp);
-			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-					    i % num_xccs_per_xcp);
+	for (i = 0; i < num_xcc; i++) {
+		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+				    num_xccs_per_xcp);
+		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+				    i % num_xccs_per_xcp);
+		regval = RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL);
+		if (regval != tmp)
 			WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL,
 				     tmp);
-		}
-		ret = 0;
 	}
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
-	return ret;
+	return 0;
 }
 
 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-- 
2.25.1

