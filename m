Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AABC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC4B6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AC4B6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76026E8D4;
	Tue, 28 Sep 2021 16:45:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84366E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTf8zcysfgulhaUvGHMxZRtI8hCgRVM6ePvW1fHkWK3EY1B0bpAOMMZCrfXEDtv6RVBqLsG4TUxBeUW/pHESudCOwyFuVCgwIqfN5ebWErzUUDPLhLG8bpO3SbmoUbpFQGIxKfizxFg8sE2WzPrlVG7yrWTM6ZtXLFmmfjgdwNuKShXSlkkOsqLX1Ptrolp/p5WcJqj9hCaRWUQFpKTyhtlTSoJhZjEezbO41vyzrBj+95rjCL6meFuIUGRnAHrmPSe+fWgHqEnOIVVHw7rD1GS1i3RaXuFyURKiXyid48EM7RU4eI84GEdUV28AFawbz9Vgun/dzA2HalY0oAO5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aP82xcScbgeNKazMME2PjTog4z0/LCQvWsynUj0La30=;
 b=CfaBpExg+w1wLWT+jm0qhY74/EM7JAANm3cEG8fdiRCemfYgRgqZSo79YIj5Y+zSXHGcNK8CJrN4sPwuM0fY0G4eYdd8Z2BD9vKnnJ3zIR+BEXNS9iC0EeuZnJpqovefgmYur7PBhlhNCXKQZ0KfnfDYVofn6RKfx9pMxNU3aVnz99+Q9LZe2cQ32fKMxsDCO5k6+GIaiIXbiVn4HrGDp44OffDvSAT6gKjDi6MxYzZRBhqLCL2uMHEB//hPAOspOp5UU+kZjtIyFNAp1INIaGHtHUiqGkgN/zr8ZavXcs+KpsxkMD9u4dNjq4WTtFqUoGa3Wq/ep9pa91rapnzSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP82xcScbgeNKazMME2PjTog4z0/LCQvWsynUj0La30=;
 b=0Fu0UFOqUc01jr8RgfO5G/1qhRqdBye9NY8WOUPSHdxRGzbzyP/+D1lx268oxVjhZUGfEnjf3EkJLle3OAbeWO3ab759HN8TcRNvQG6fGKyjklklyC3R58cp7xl7gajfNxKr5KBQwz7e56LHJO3IUJwnh3U2hWIlAQ/lsMNqfgA=
Received: from DM5PR13CA0037.namprd13.prod.outlook.com (2603:10b6:3:7b::23) by
 CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Tue, 28 Sep 2021 16:45:00 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::1a) by DM5PR13CA0037.outlook.office365.com
 (2603:10b6:3:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 33/64] drm/amdgpu/soc15: get rev_id in soc15_common_early_init
Date: Tue, 28 Sep 2021 12:42:06 -0400
Message-ID: <20210928164237.833132-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c03617e-83d7-4fde-0ee0-08d9829f4f79
X-MS-TrafficTypeDiagnostic: CH0PR12MB5041:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5041A53124D45F2F2B90A6C1F7A89@CH0PR12MB5041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGpl/BT73n15mItqOyNprbuajcw3aAfrlXUhgXXgA2jM1XsGbmLcyOv1uVjTYBZzk3w92fZaPupHKTIItV3HBgKOOct9VXsjGLS1RW/EK/r2V1eZ/frHbm5Bf4JjTLi1+7TneSCKx5h32NErfxBTL9fleTQpq7iQavrLfvDuaXOaNpaEpwjAW2Y9IZ6pXMJ/JbUilNmRNhUwJ8KZ39P+i/BxtDmzbqVGetFMlCH4NFs6pKZEVlSD+0av8G+UJIEOsiHYu2qgcekBNzaxi58UBBxyyZamRKfB4N6uFVMhywnTnRiqRpRQ99WRRyg2EWIJsLN/xaVpMdIs6dTLWLFDgKYJhMRGuAj9y2kM2BYRi+nCVOBoGRCbbb7zAaTseO6QmmcVbuaP4lr0M9KiM9nBwK/4c7e+bY1aGnlT/W6HiHfUwz4rMHo+nEdAuCfcAfBIZr5UTTfNUei0bMQ08IrZc1vaNQVCowhs5gs0ulhwy9T5AUV9LwKTAiou/ujWsF69EGNMOohnyAdW8b6mbFM01jfb27SCYFAC9irlMiX2It4C37wRJINmPLktUHCG97zkiOcKT4Bw51AyjkGt2HdHYeIRt5jc00qIjjR1lUsMk3xKO5s2jqANh3dCMWlXaCVkiovhN8xblAB7lc+nKlQnXEwC0ow7kGqIsHXC0E7uAxp2JNf/RTEetjclC8TysPiYdeqibfXSM1pQ3T00VhvcHTBGhxQqfddV7WYpP1zF5JU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(6916009)(316002)(508600001)(186003)(16526019)(66574015)(4326008)(1076003)(82310400003)(26005)(36756003)(2906002)(86362001)(8936002)(5660300002)(4744005)(356005)(81166007)(83380400001)(70586007)(426003)(2616005)(47076005)(36860700001)(54906003)(7696005)(336012)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:59.3520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c03617e-83d7-4fde-0ee0-08d9829f4f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for consistency with other SoCs.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dffe7d7ff9e2..f26d33faa0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1155,7 +1155,7 @@ static int soc15_common_early_init(void *handle)
 	adev->se_cac_rreg = &soc15_se_cac_rreg;
 	adev->se_cac_wreg = &soc15_se_cac_wreg;
 
-
+	adev->rev_id = soc15_get_rev_id(adev);
 	adev->external_rev_id = 0xFF;
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
-- 
2.31.1

