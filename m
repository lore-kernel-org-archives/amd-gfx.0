Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC0C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28FB60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B28FB60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5496EA91;
	Tue, 21 Sep 2021 18:08:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CD06EA8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/cOkQbpMhEPtnfAsBXejabiocbM61KVKQHxz+z9WgUHlMG8Jl+jRIie+xFY72VdMJXmkL1EDwgGeLHck5aeZIc2zpadezFBrcLL5BEzHnUxJ05yZeJ3X27SdkgIWcsqh9FVTPtSfvfOzMJHTMDuEA1AbUK3ZgZFuv1w1ex3Rn5fBDZaIPMZY63dqUePVM/KMqHUTK7X/v1krKd89GeVhT0LqYpvm+0/eo4vZq6W3WIosGmsSgX9BTSIMjhLjFGgGAgqVY3ZslTm8AhgOWm2c8tO2DBrc1XKYBXALiGsfKZAIi6Pn0wJ9F4oQvpCAPSM8xgSGUdTwc3N/8h2ZwhHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pV35LLja/wbx4nVM2UFmhiyrWY/ffVcUNcVfS4jtBfQ=;
 b=Xo0+qXhDd1PIcpO9VMnoOd3tiyjVZyRvz0gvqsYExA/NMNXc8Q9eo0nYhWOPXlpX91b2BOb9nkiUmeAERrI6gwODm6+DjI0rf4OWhZAjnoD7rc/n7ufD7ARUuHcQaKoElQTqlcO39HLzYuTKjG00a65zYLqzhn1IzuFZ1d/59Q0WFnFI4PUNEqbvcipeSnh05jUz+WRm6shBS8Wjs266KwOtt/0pj36/Ixmyrkz2sJL3FjFDxoE4HkXsd2+D/t7a5tBi6+JaluV4Hha0yahjZepSbl2wG0a8PnL1YrCwgf17ObpCAtdhsMT/wVdho9Jxs5oKocFwJOPrILB8oTSebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV35LLja/wbx4nVM2UFmhiyrWY/ffVcUNcVfS4jtBfQ=;
 b=tNyyUNNrD/79wNBC1kYI04zOemIWmAHG9axnv71wbUdpA3t/cQSM8JqiU7d7OrccDmGlckBNNTe/0Uwad/URqyxL8DJkzHK+zf/ChHquG1TJxu6Gq4f54hcqenN4mJfPCB0YX+rl9/41KVeATkDZNziUDd457I1x6IDt6FRjJiI=
Received: from DM3PR12CA0063.namprd12.prod.outlook.com (2603:10b6:0:56::31) by
 MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 18:08:07 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::a2) by DM3PR12CA0063.outlook.office365.com
 (2603:10b6:0:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 52/66] drm/amdgpu: store all instances of IPs in the IP
 version table
Date: Tue, 21 Sep 2021 14:07:11 -0400
Message-ID: <20210921180725.1985552-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7371764c-3e89-4d27-e1fb-08d97d2ac33b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25262DA060084B2217DC9058F7A19@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4no1sYz6TKklx29nmD/iQ6Hr88jkytDfYNVTsxfzarFUYSw6Z9G1oUy9FLhWkbGYXA7Tk4lqi7jU/mzfAK4X/L9nFw9v1buntJbYFUbAt25uIYoj5+3BfvM164cvtL4sYMERgNShRLEz8VW2dFva+9SLBQVRgKrUx/ufozHqliyLFhr+TZHr+81d8xAlqWfzNMBSTiGz53mzVpE6qj94Ktublw36Fmpvx74Zs2JBN1EQWQOeaCmwKi9Up0qybcSOsYNSFzol9PiFc5wE93xmSp5QCTqxw9XT3fbq/3YF+QXJc4c+k0LkyGHuip1rtQvo2G5QXzBTtOrCm6mlFiW5r13jHiXLM5NqSlPjWAZZC6xDUMCnvv/qnTZwY9soxGu0QB9jnIvFAw8XTQEhWL6Jq9esxxKugSv+IuycPJfgCJ1GIK0JCX/WK+S2UAkP5xAexiHFafSTW53KE5cgspS4mMiOVe+Ry+q0olYsUzi8YqAoBq+TwJmjIMBzjPJDbgwRNJ6UAxM0iVBawwHfyGS2fMeNMNdj2sdXMJWwy4WKS4iZ3mKbi5QzxvlWLUWV/qBvEc26FZGKUmI69W2S4ipt/JPJqBkM9hsqDZsOlQvdQjYbkCLrXfT70vWJ3RzG3Y95CMeYYbYHvB7QAtxEBuRMQLh2yWwuTpzN9OFaHCXZl1TIDAXpLVS1kMGFALENQHTNCJNUgipmO+6LCDBdXG7RPd6ty5jfDUpKC2XT/stn58=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4744005)(1076003)(426003)(508600001)(316002)(336012)(36860700001)(26005)(186003)(83380400001)(356005)(70206006)(2906002)(4326008)(8936002)(5660300002)(36756003)(8676002)(2616005)(47076005)(86362001)(6666004)(7696005)(16526019)(70586007)(6916009)(82310400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:06.6356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7371764c-3e89-4d27-e1fb-08d97d2ac33b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
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

Use the instance to increment the entry in the table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e3b4578872f1..572a634f7a1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -364,8 +364,10 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 							hw_id_names[le16_to_cpu(ip->hw_id)]);
 					adev->reg_offset[hw_ip][ip->number_instance] =
 						ip->base_address;
-					adev->ip_versions[hw_ip] =
-						amdgpu_discovery_convert_version(ip->major, ip->minor, ip->revision);
+					adev->ip_versions[hw_ip + ip->number_instance] =
+						amdgpu_discovery_convert_version(ip->major,
+										 ip->minor,
+										 ip->revision);
 				}
 			}
 
-- 
2.31.1

