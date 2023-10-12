Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DC7CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29C710E43A;
	Thu, 12 Oct 2023 07:32:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6460E10E42C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPui7J2ecIUp8vWnv6g5h97svH1Vty6UlmfXZqL3DwOWrcQZXWkV6H31NbR/fPQWphzQuZZSTj10dQ4Yg+CsKgCS3FihOG+SIhH6AZ9DjjgycmS71iHUegnKlGEMun8UQXe4hF54UVae/hR3Z7MhsnkKf8TxYwqBMbsnd7iJYEAn+XydKM2J8IbBcLjD1rbTnTwwNLSRMfqSpLDNdgzxw8cbPD1Sd00DbyZpw0OBwKZT3ZsJzib+yHNH2hi5Z9/Nt3ew4vuh7xP1WMMg02sfSARwmzn7BiXz7CQgKwwCieF7tfWZNYztEZkWUzEOcPt8Tx0yYa1Q50dno6JLL7UhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TT6AqopJyCHt2pv08Ro8b7mgetDrHqLV2EUbGMKbHY=;
 b=ALzGcMFsJDzv1B9hQqzXu4tC9nK3PCuyPv0tRiRY+xVQMmMmkFLj53mkhBzJG+ocFxP5STNQNvVyPltm+nG9+8siofbAoLUQjfq6oXScqi3sxHr1vf6CONiSnezMrDfpOtQt2cf+NJxlrwVQn9vqnr/IQfVNKEiItSzDDtrYWsqL6zc/vCT8TRk7svlGjrUIF6N81Ry4+TmN3NyL8TZuvlM8nUwp047D3lYQDDptHe5AClUvfogdNAkyQRyMlzxlxf9LVP4TtVnrYOtLJYRO+PCCVLZf8H77LPDuv+TCo9hAWpF8F687i6/U54g46JTERm5MdnQp7Sgcfm2ylVxW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TT6AqopJyCHt2pv08Ro8b7mgetDrHqLV2EUbGMKbHY=;
 b=PShiqolrHP5aHICvotwlp46i6chCkXQFRO72MMOpwxQ/hCqLIMpUgYBYV8B5VSfcGW8DoWMpVlzHr/OFIuVxDvjEzV6pR4rmJD7QDpXnplEXvRy4bA5SQPNrvZRDeCjSE5f33qFML3TUP7UR3oqBUSnf73wS514+XHIupBwkHqI=
Received: from DM6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:5:15b::34)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 07:32:26 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::5e) by DM6PR18CA0021.outlook.office365.com
 (2603:10b6:5:15b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 07:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 07:32:25 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 02:32:23 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: don't use legacy invalidation on MMHUB v3.3
Date: Thu, 12 Oct 2023 15:31:45 +0800
Message-ID: <20231012073145.1076131-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012073145.1076131-1-Lang.Yu@amd.com>
References: <20231012073145.1076131-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: ed742e53-cfd1-4ce8-d27f-08dbcaf56186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nB8bIQX3eqQSzryp3DMnND5rIAbiJ4CH+2RoCdLr1Vd1yqS4hox1S/RSlGOM7RnQLowG6lVaD9SzDxZUAcbMdJCge/g8HA5ZPnKRJZJaDgKTLREEYf3CSJ5NEYEHnwMn1FpJa5rqz59ASWEl35a5i4s8LEKyztgZU9KP3/dyNOuihRYVYcOk45WgSm4KvcmOeCELTEpVo4ncYFdxxcPzmlEDrVvH9kjp6j6iE7fhhvCJtwuyokoms7wCkyYNlxxA92+KD4hualP4kcwh5WlejB2TqHUw+so2d3P4WSbdZA2m7dUQxGjvJQztKsZh88nqTwA+cLWq8tzz27zct0e/+Kc3AoQPcSg/iYGkmBIMraTbqVSRh+dUntP3Ctq6SGLNoXvrhZUm8lbOqX+r6HrFQ0uDxh71GJDlC5cI4T99aauYdm6+VSbtOHPJ4FRCPXt7Szvd2tmX0zB5fGVPNXIobSpAqwyg0WUxQ4IbSUV+zPmkIKIWPJipdcYsQVTmFyMHWojViuv5RRCbUyxONbBaUOvD90+3urs0NlOxOwO14/BaMmMyFbc944hdH93pVTYG+AGUXXBBR7m+eIRfgmiR83Cce2lfJl7oX4hnR5PyU3Tq3mUDzCGYfvQhj7bUifX7/oi5aYgxXRGUYyT/dgmyLrmsOyQYxh37XOjGbOQZLYNJNxTjqdRCzAy/hMajxnuj9pMqfkclY930lgS9WZ6d2tadexsO6VW9vHbaiAQUOJ7myfU+NwhiGXVpn3M83fXLSoN+S39Tyo5XN6DzrOU3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(2616005)(1076003)(6666004)(82740400003)(36756003)(81166007)(40480700001)(86362001)(356005)(36860700001)(316002)(47076005)(2906002)(336012)(41300700001)(426003)(478600001)(40460700003)(26005)(16526019)(8936002)(83380400001)(4326008)(70586007)(8676002)(5660300002)(70206006)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:32:25.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed742e53-cfd1-4ce8-d27f-08dbcaf56186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Legacy invalidation is not supported.
This is missed during rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index 76b12f015d1d..dc4812ecc98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -68,7 +68,7 @@ static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
 	/* invalidate using legacy mode on vmid*/
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
 			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
-	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type ? : 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
-- 
2.25.1

