Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2647ECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BE710E125;
	Fri, 26 Aug 2022 18:43:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9094D10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqNUhzA6Ci05+TcZG31Aw3a7aQm4umO5c8Rc06YFGEflAP/EJm6Ud/SBqOL6yY4Hd4ZtrAUJUpHJSYWKE4qANN77XPCE4P3q6jvSzBr0k/vbKtAwtvWlnE7DZwIvCBt+NPACk4VkOcanDupQBHnwOZ37qKzxZChgbxlOFSv8bMSKieF6c7BLmm5/jFLOlxUExMt9s/K16AcefP39njNbrrVw1fJTNvuI9ytbHV7eLy5TWccbc9V7FwapLzWwJd9PFPtE18nNmWxds6xaxTc865P7UK0kPw05XsAufN6bWnvpYJzQwk9vNartEUDlS0ooLPiHsvSuTOEWlqjw6CVkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea4aw5mibCzf3iG5+4slw08q8rOl1RKKXRv1ffYLvAg=;
 b=mCQW1kErKjh0s5H6XCDedIABHdlKNbAcMLGp7ICJisestXj+3jU4beGawKi1RhcHMwMYiXfL/YY5GHwilwzd/9XWSpq4Yac4Yh9ymiyktJ2hON1K2yLmbBSAfPRAxi5oWcnStCVx8KJDt+A03l53LQ3AhE0rMruKUnLtwDMwxMEmeH0pBrgEgd5YP58l6HTHlJBGRs66VUnCYfO/Gp0O2VtAPbl56dgjxwKWssTyEnhglVAJeByhjL8+sdiJ9MDl/102ToOzZawSt+oDbs6jpss/YZWcDhE1mn8rUEzgo3vuLul+HqCnrmQhwk5NQfntb2RB8aPn+e5/i1lrNOXorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea4aw5mibCzf3iG5+4slw08q8rOl1RKKXRv1ffYLvAg=;
 b=MOMKKDVajSbE2N7vDGghgNoG/LmxRMu9NCJFvi6wfeFeW2xTysUfo0DoJ26ZYOVwzQKfaMwS85itm+smL5BJyPngMdI9j3JByaGChoIr++m9GsRgRpj0tAZJF6XbnjSdRMGzPOcNR2eCzbH+fPIfo2+HcLbhQw0iPFdlOtsAsa8=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:43:03 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::aa) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:42:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Enable pg/cg flags on GC11_0_3 for VCN
Date: Fri, 26 Aug 2022 14:42:44 -0400
Message-ID: <20220826184245.855216-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184245.855216-1-alexander.deucher@amd.com>
References: <20220826184245.855216-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49b63d3-8112-425d-18a7-08da8792cdd9
X-MS-TrafficTypeDiagnostic: PH7PR12MB6393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQknyfAUGIsr3JLuRpx2DJJgCx7nVbgiq4Hp9IcOZAzDWNUrC4LCrVq2lCLZf3pfKRjyNrSBf2MiRTmjUdH8paCVOnp8OjA35hKr/w9/txuFzw3HAyP3na2xiOEzmiTsS5IPeKEjMUV+Dpf/wRABcc4BxfRWjweI3ite4blDIM6iZ1LD70F5mnjmGulIqNZjjbFnQ+9WwDArD7aouN9cw4mz6QmH3ZYqKqLq9URP8IdIjG55peBs51gQO8opN9ah4puqnXVXsTD3PFAZ57j0zOiB/bScQK1gywXqKvAvxKiq7tnTr4bY/jFRZRkThfq69J++uttws5XyjiILd4OIoYQlDKoNrpK6g+02ihJAjAYFzLyqL1bILm379uotznLGnBzZSHe0ZUUtL2AIP64Y3XjTsARBSyyVETO9P+WgxNbnRB4wycA0t4gXU5MdBLf7nRWZTsVtpo5VSkHUbCt2Eutcw6JioR2sx8VeOrWo20qrKYGsnjd/mvGHVNup7yaOeHvlSkXoZfoRskML89taIs5dW4it/Md2zSh+tKu7KVEL2yENQcU7WKPku9Rafnm6S9atYmYxCXIy3ddAXHQ+heN78axQxc8PwkBUFuK7k4Q5gMUlsXzPk544Z/o5rgwvYvcwCrf1ONppNKv+pJsCiokFIGe+VHrcf3MggvaEsqZeJ3M0YU2iHXP1EgbFwnPWZlujzVAJIFIWxo7pT0476oL2qpWgRVOQURvWeP4wcttAa5qe0R+oev3WlYb/ubsDia5D+9MWCplsCvD164SGIQeWXnVH1koiNFsPVbvVYpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(83380400001)(5660300002)(40480700001)(70586007)(70206006)(186003)(2906002)(336012)(2616005)(16526019)(426003)(47076005)(40460700003)(36756003)(1076003)(316002)(4326008)(8676002)(54906003)(478600001)(41300700001)(6666004)(26005)(82310400005)(82740400003)(7696005)(6916009)(8936002)(81166007)(356005)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:01.4253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b63d3-8112-425d-18a7-08da8792cdd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, John
 Clements <john.clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

This enable VCN PG, CG, DPG and JPEG PG, CG

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index f87dfae4efda..54bce19a52ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -628,8 +628,11 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	case IP_VERSION(11, 0, 3):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
 	default:
-- 
2.37.1

