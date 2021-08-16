Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F1C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 08:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0585561B22
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 08:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0585561B22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DCB89BBE;
	Mon, 16 Aug 2021 08:33:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E79089BD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 08:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhTVbpG1dUTNdUrnNAN2PJrmzkkCeWLUE+nftZhuaSuoQ4sKod4pCNIQWT/hd23eHnHrkugGyVxHw/uoTvR5ZDPaRB4dwJHNcxLCtnMKpbaRBSYuRW5kdws4ONyp62dMCwZW1zIV5T0KntDz3TaO9ButxG3MDim+hDQBiefCDqYt2A83L14LQl5LXLSU/7jjdlkF5ncA1GNU6r2LnHXYK6XnWcd3ru32g9Vydwc1NIC3AVkGxj3LHtG07fDPgo/16qlj0lGhy+ie5lgR8DiUnd7/lVwv5kvNR2P19kv8mcI/O+jobM7cK+5d6oGV3Ql8kQf52t2uNL9qAEFpTgRlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTan+E3mYKd7QHie0FYioS5CHPheJN5x/f8roqbqXdY=;
 b=bq/FQJjG3BX/BYMY7gLQVapzNw5n6Oscci5eRK6gZc6YwfJKLLCiZAIlAWRR9b4musaANTgzzEbDLjTp1k4NG9ktASsN7W+QwALEmI3NaJkirRvGzchg0O/ItUH8LVTanWq6RUubLfYY930sd3rIOm8b6bDvipw4Fb75vUDK5+4GjIbq1eQ8ocUFvqdZQbEoZ3yNNY/cYtmCraKWYbq07Bahidc7DGEqX5I67jXMlwN9XAQC9jNEtsVGlGHV0PfGSN5wWDUpk0PWhHmYynYI8QMocDrqNkeIk3eq0NYuUEok18bruK7Yz8anO/62QKKpjGV9GAEhWTCHFjc5W/iQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTan+E3mYKd7QHie0FYioS5CHPheJN5x/f8roqbqXdY=;
 b=JULdu1Ru9ZHRZVQAnr/W2hifZrLNB3ky67cum0MRVrSuiwZCOytpgo54zll/SPNx0Q/4IU7WfR6mwa2NU4SoonjddkJicG2qXdmTjzl6+U3g8q/D8h+eU4IevUFFe7B6+c5JZfcd7pjqpzd0eM4eAmi/jfhOxv3s7Ou05pzFvvc=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by MN2PR12MB3373.namprd12.prod.outlook.com (2603:10b6:208:c8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Mon, 16 Aug
 2021 08:32:46 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f4) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend
 Transport; Mon, 16 Aug 2021 08:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 08:32:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 03:32:44 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH V2] drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU
 temporarily
Date: Mon, 16 Aug 2021 16:32:29 +0800
Message-ID: <20210816083229.1419180-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538ea9cf-198c-45fe-a9fb-08d960906cca
X-MS-TrafficTypeDiagnostic: MN2PR12MB3373:
X-Microsoft-Antispam-PRVS: <MN2PR12MB337306824107F18870E7C55BE4FD9@MN2PR12MB3373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLJJPNXAKYNtRNyy1O2hnkBJXQHnDinBGW8yJLB6zRtmWUboAb/HGrZakRmNQbV0yGRMPheRQlfG5UVsCrm2Wtuca9rYXMdvP0xgGZYaF6CqIHUR/6WR+l+4Ew2eCAWgF9ChX8ZK2z5WyluRMFJisXz9EKnAzv4SPeOGog4vHN9esEK7Gk2TtJ9dYBTjYceYleERnzBuX88bI+4OErt5Wdn5BMlMDZNUrNlVqsulmVvf8mxQ40B/YmKCRgv1YWI5cojpQQxgKCjmFMBOpnRG0D+mtBiDvaTUDYfn6SU4B7VByh2zsM3IFjpedmTqSa1KR3TsiGMX+WPUlxn6I0ItAloizhmzJLpMcM/r/6P35FQVlLoLKzhwn77e2dVlAZzdxfKYtEOEgODtMt8ReVi4ESnMx+YIxWKXuvK7kUQhqucN/ugaHr+ynMou1KahB5eQ+f5o6/iygJJ0044hzJhJ/pxtt8n24ispgo8WHAQOwr2UHTDVjXBIjE0gHMi/g7omU0614iQIKVumTb3cOBvXGivDVt7v5yCYb+fgKAecuGWVjAH72v9zo4/iTwsUC7eF4Lo4fqtUyF21dMitVmzV1TtAMUcDsgqkIMnz7W6BTNiYpkdWhBf/d3kc0JjxYP8qCVXzEvm20tPc7NZVTffaouhAPVGeNt8XEKcVEevSgkE9Xb3yQIxuYypU7xcPgR3bMSxu+th9a4SM8NGrwHCCjCOVKbb/BoWvikwWs1g+WhES2mhAOEZgjtORliM/+gfkjD+zVmg0iz4JT9kXEjWEsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(2616005)(6666004)(36756003)(47076005)(36860700001)(82310400003)(34020700004)(6916009)(426003)(16526019)(186003)(336012)(478600001)(316002)(5660300002)(81166007)(54906003)(7696005)(86362001)(8676002)(83380400001)(44832011)(2906002)(70206006)(70586007)(356005)(1076003)(4326008)(26005)(8936002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 08:32:46.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538ea9cf-198c-45fe-a9fb-08d960906cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3373
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

We have a S3 issue on that SKU with BACO enabled. Will bring back this
when that root caused.

Change-Id: I56d4830e6275e20a415808896eecbadfe944070b
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
--
v1->v2:
  - limit the SKU further by subsystem IDs (Alex)
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index fe9a7cc8d9eb..42a35d9520f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,7 +904,14 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		return amdgpu_dpm_is_baco_supported(adev);
+		/* Disable BACO support for the specific polaris12 SKU temporarily */
+		if ((adev->pdev->device == 0x699F) &&
+		     (adev->pdev->revision == 0xC7) &&
+		     (adev->pdev->subsystem_vendor == 0x1028) &&
+		     (adev->pdev->subsystem_device == 0x0039))
+			return false;
+		else
+			return amdgpu_dpm_is_baco_supported(adev);
 	default:
 		return false;
 	}
-- 
2.29.0

