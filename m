Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5A3C25B6B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 01:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B565B10E099;
	Fri, 27 Oct 2023 01:57:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D2F10E099
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 01:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnSBp5A3/3mXgcdDhdsleUCxeszeP3QV+mlYGutrgzkAYnN5ff5ezP0L73GxsAaRah8hTURaIGS9pWs7893EyyPhP/vqGSpaItptlSfIg/blWZN9ESCS8JdYH1LcEJFARbxrHDmAoe4UhpUfsYLRBLHdoNyKiTl+d3zoIxXgw/HeRZSfX2+PJ32MRoiI5ZExeDJKzdhq8kcpsTdjCG1ANUxffs9oIiqI699rex4eERIF5xKaczr2maY3eJAVEpaL+e/tW3XZmpMhB1LP3Kwd8ksAq8BtkzGWQE6Xb1qrLmZZt+6ceKPHUmd9Hcs/WSjo0T9kHfkEbIOyc1ilYcCNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kZXMBA7eyzEH6DvS6d4weAF0R+FuF/kdLChVn2DW3E=;
 b=OARAeUJOoEZUV6jB0Atj+ynYkJTRh00zC4pwaaUVBDn17xor76CnV+DNataL+fdlbv/Ng+RN2HwHIwXDzojJo6Q6BrD7SaT0VB+9KWfjW8s8Ls5P6sbm+LOzjukm0SvFQ3KGnLfNZ3LXU7I7KtT5lV1flq05vuRvCtEVvDTrmNYjY2cUYjxsSi07ADkVeAfa5jMfzizHLHQGHo/hVjuO3ssF4fUeW5EaaNd8V/KzPGs450hrgNGWi115aDWs26lxkAOzTauW9T7++p8WsOOlpBG8Z5FB0L7KfwBMzMStrSu/drzBs+4qUErRNW8vXLQYK/I4CK5mVBnXrV5PSSmGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kZXMBA7eyzEH6DvS6d4weAF0R+FuF/kdLChVn2DW3E=;
 b=QxsmdCuyhkOHiG5izkveyBSWFhfP16cDpwZ2xAC/Rj1UB7b9zGeX8OnC629VaYTm9VvtsTDDvjepKvISXZfBsYDjqAg7nJe3rvi8LeieHskzixcrAVAPAKVMjEs+LhG7Ge1vVDxe67aGGO5T7+DMh5BQS1qkE4ToHN3lvX9RewY=
Received: from CY5PR15CA0218.namprd15.prod.outlook.com (2603:10b6:930:88::21)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 01:57:31 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::c3) by CY5PR15CA0218.outlook.office365.com
 (2603:10b6:930:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 01:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 01:57:30 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 20:57:10 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Return 0 as default min power limit for legacy
 asics
Date: Fri, 27 Oct 2023 09:56:55 +0800
Message-ID: <20231027015655.1499111-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e29d3e-31ca-4916-e51f-08dbd6901477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRLpfak5q4PMtcA0vEctbudmSWGoHc/jS1tl6OVW7lHszwpQ+59/v6YAkfgJa29ukGs98Vtx3iecj5E/DooXHD68Gp7O7TLjuEfgBv2j1pJYSBniBWqZWAFQh7IJ7NmwYzo6OYJhlS7eJpNZxO4gMYDtswXfVed+QGJwaMLGyh9txnaLL5hvjZrH9ZD2qfDOnXZ8dLpN6Ar1tsYEcmJHKEaB9C5ZBM3/V9vW7RBass6Ane4XQJyZVzcdOpNPzVHDM5RbfKvr8Fm3q63vu9LkXy6ZSo+xeFBud28mKFxJeP4A1YePuhdlc3EZYRKZJMat8V9KyY/GfdNZDT9hFIcNECclHCuY7Qd9cgDP08KBryPGTPDn1r7lIthNEsXR9Xyu1Sa2gRhRJsyyS1QOirzNl4TsFC60NE9yKVL4KG82RF9crZapnU+ngy2JoCN5YSqT63E1ecmWr3uDz8OOD2oTNxcZyiC/BALwugCTJlJSvQGj6czZLFfOx5frtHmToL7/yeJg39F/z6b5zOXy5xLA7y/R4wy9auCAOdbynirKwwulebTinIgp8WIXjMPAv0wmDAugOdNBoRkU4eDeZeSnNuQUpbPIQn4gP57RRnwiKjcjVt+KF8qm0eZRDpPVLk+8ZU+1yV1lcEsI4Oe2F5x3qa1k91jPnx3WnLV1XotPtH1ISVXrm8u1QWrVJZyyKmnzjd03b0DFCnHRwuJHni1CBG2DfsbPDaZaUjB4/1wFAOWozPNkZhqLxMpuZvairI8r9OaMBDU/FlvjVCGdNFwrOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(1076003)(36756003)(426003)(26005)(356005)(336012)(81166007)(7696005)(2616005)(16526019)(36860700001)(6666004)(82740400003)(83380400001)(6636002)(70586007)(316002)(86362001)(70206006)(110136005)(478600001)(47076005)(40460700003)(4326008)(41300700001)(8676002)(8936002)(2906002)(4744005)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 01:57:30.8999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e29d3e-31ca-4916-e51f-08dbd6901477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return 0 as the default min power limit for the asics using
powerplay.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 9e4f8a4104a3..914c15387157 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1022,6 +1022,9 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 				*limit /= 100;
 			}
 			break;
+		case PP_PWR_LIMIT_MIN:
+			*limit = 0;
+			break;
 		default:
 			ret = -EOPNOTSUPP;
 			break;
-- 
2.34.1

