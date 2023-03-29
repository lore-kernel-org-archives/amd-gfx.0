Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FBAC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D0010EB72;
	Wed, 29 Mar 2023 15:48:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB0010EB6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL28GR3vhvIeUxjaNTlVGDxraj1nLldZCjHn3l+Pluu3AMYCCa6r769TFI+aqUjNpGtvsSJyhEELbAcFzGOUNSq6kuqHrIkGAzMrJ4Hs9iuCttuWo2u9PngydvW1j3+nFLUeSAyoLBo/0y4CyKeAEB2Qnv6qEZqCKey25hU3TBXOTzAQqLqGEEyectuH+WtnQHZCKimhfD8ImngIuYt8yuOq0JgFnv5jJtV12ndviybX+JqGaVrfg23YN87CbpR1hAxHNQ0l/SCdy04QfS1AoFKA2DHDQ0RJdD5S+9LIulACb7n0lodD/huhpDQW1t7DkPnTaqHQCsRRvCpbly+cAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09b/QsZAnGBQCc4+UAawAKCFev9vro5Kvz/Tgr4jprs=;
 b=FZ2UtDnGep0dtOElE0bcR7EW+DW3W5JVfGhIz9YPvv9g9ljslMxnf52GEo++Yxin2LHJRWfHVwH+XqeSoGXIzzeXf34Yok8y4QzEPYwFP4HpwOFEwbK/SSt2xZg/WSZvGDQmC7jA4o9qRCp+4RYtRiTx99gecWHksWV16ecKw5wyOJeleHf52fDov2+HPiN8pARzI5m/aIoUdT0o9WeyfJjaB9gnO/22SlkLMLHV4u2F+K39ceLKJm//qixsF/wZoUQahYTG1tJGTryM5fpAHg/yhHdU/pJdLZckqn4RtRjzzriPVwcGrcxNDmypyz6cORKVYdWqfe4ZDXCnzv8YLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09b/QsZAnGBQCc4+UAawAKCFev9vro5Kvz/Tgr4jprs=;
 b=BLJhuoPF9V8/L0L/uYEAnSzgT+JHC0BEfe+OZWCTxov7FE77+0EXcdi5fvIYkdbL2VuJHQ+iZwZ+bfMxaLYB49idlUtlXA9+tT+OAvbpECYex4dB8IfYnufsOK7A4yyAfyJWJZ6qHnlSpABk7S599XqvzVpy6weMkBGODc8Eokg=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:23 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::5d) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 15:48:23 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:21 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amdgpu: add UAPI for allocating doorbell memory
Date: Wed, 29 Mar 2023 17:47:42 +0200
Message-ID: <20230329154753.1261-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: ab695333-559a-4810-5ec7-08db306d071e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrZ9cNKmVFEj0SisJ/dq2P+o4LeifA/oMp3KxjvNfxMlQkAnvoZg3eMlIZg4/61XWLzM9QPPiOpwtBkdFbCsJ+Bsvee8pbn1lLlNgFdmCvP348PlvaogtxGi/YulQTckmHxlt84DpDYs9wl9BTQac8UP7K2EvOEtC0e//csPcKdWc9mosArNm/9XTB69HXO94+LuIGK5Tdm34LenEBtQ0Tu+FUfibA4JStxKoU71XquEnKNwXUlg8IjGnDaHj3z3IGg17JM76YU/DLsfnj9kE/L5Ww1y+AYBxghJvwIc6SaVJKSyxHmcz9tAoGdlZaq8RSxzXCh2f/AudsqdSk6IkxtGhzX89sCtuV9gT2MjMw65jUFlqLgXCcnby+Rz90mg22qicbjgyoC53j2u1t+Gm/FUgkixG2l9L5px3nWaxGI7xwWvWhlMurSLdlO3b4osT553bALtYthKa2DBUyIu+BNnthUN3hkrX866mRPQUsfHx+JNlP+EpEqJhCJSOPMGGWU/jpTchjSSG4hDYW93SjbtvoEWikYXkEmghb06HUpvMm18++NJ6DKhqxWxukPwvINEm1ayIw+X61RDpryLsh+Hmr4jNEJs4i0t2+sb9iF5CfxWyxhlEdgTqK5+ORLzETFwyz9twb5hlWfeLGJISik9hG3Yct9OeK0n5cM6PEIc5RWddHv4iFUnXHp+YjQZ4I4Qd3Of6q634Ig6gahcvUoGMAdnye2yLo2tzxVZeTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(336012)(54906003)(478600001)(316002)(4326008)(6916009)(8676002)(36860700001)(41300700001)(8936002)(356005)(81166007)(44832011)(5660300002)(70586007)(2616005)(83380400001)(2906002)(47076005)(426003)(6666004)(86362001)(82740400003)(36756003)(70206006)(82310400005)(26005)(1076003)(40460700003)(40480700001)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:23.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab695333-559a-4810-5ec7-08db306d071e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
in the UAPI layer.

V2: Drop 'memory' from description (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..cc5d551abda5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -94,6 +94,9 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
  * for appending data.
+ *
+ * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
+ * signalling user mode queues.
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -101,12 +104,14 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GDS		0x8
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
+#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA)
+					 AMDGPU_GEM_DOMAIN_OA | \
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.40.0

