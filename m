Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F9C6FD19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 17:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C1010ED8F;
	Thu, 16 Mar 2023 17:00:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139FC10ED8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 16:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBuWhJbsh4SS68WsE05lKmat31yUBSq/8FR3uk3gWPitsfhEAJgYWNoTUYvofUE0FQK2gfmPFFxYmdq5YFMlhWd9+PIgPHTtkBvQA7e3FTLzXLzxeg3wDEFCn0W120Wzf2jdxWCTr/P4T8zdmTnhw4ZB76+bBuV63yueJH/aPMcwqrCt2EdOW61JaXTxCWhrDq8LKrMln60P+73DhLlIuL66B2RmlAV9IrbCgThjz4xb0rNQFVLL2A4b0gqw3kol7F7Vd5iwaB2bLGqrqty3NOMslfu+ANLZFT/TBUuoyihxm1LYJsvIMdWyFsKDhA9DQSlnYzYi2UgpKme5fAidGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SzDH70sYPNb525UL3zLV4OqkI6S/b4mdC3J4LfrC8Q=;
 b=W46VGh6xbZCgd/jOs1Ac2SErHm4iSLvq9J1BxKL2FhsIZ+BOf57MKn+AJkBCbBBzhAQnBkv9oRhJiqo+skUWKiYpo/oKVfbdm2hd7jsPQpJCdy/b+wgQv5Ul4AtcL4Xel4+JzZ37AVjjqK/OS9S+u1o2xvq9yWww0fotHUAsYfxmDqm0nqQ0Mu8dFDHUn7tIqly1BzOpqRmY1KSwRnUKpQS7n/0ddyfNtoX/TXiL0/2sch96oR61A6W/dkptfykQRp2ajIOUqDFCBYvSolznIYZ52qowO/1mRNpOtkwgFwFVk3U41iTUZOEyc5E8DfcRPiWTrr4BfGDhE00MDfmzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SzDH70sYPNb525UL3zLV4OqkI6S/b4mdC3J4LfrC8Q=;
 b=FM3a74agn72J+S3HlrH/Mu/RWZjT2T1g0ejb/K0LTslBbeOaKRzdM0eKewzuIiyD/B1zfeAvy4M3ivdmloPRJha9bfmN4Lzu+w7wkTJ4ydSmY3faiWGP2MqTONlYhs9oTonUKwTF+7vCPdMwSC+k1fM4qOG5e3Zec/nIFF3ikZQ=
Received: from DM6PR02CA0079.namprd02.prod.outlook.com (2603:10b6:5:1f4::20)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 16:59:57 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8f) by DM6PR02CA0079.outlook.office365.com
 (2603:10b6:5:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33 via Frontend
 Transport; Thu, 16 Mar 2023 16:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.19 via Frontend Transport; Thu, 16 Mar 2023 16:59:57 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 11:59:56 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] umr: Add umrgui to bash command line completion
Date: Thu, 16 Mar 2023 12:59:30 -0400
Message-ID: <20230316165930.35762-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf86105-c477-4b6c-4442-08db263fdf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frg7cekPDGyQd1Ktl5VcIjSFsOniYLOWJVOi0L+84UrDwplqO64D4V6PfnQVOcj7teouvc+ytiyh4gvtCun6rAOiUgOdsAufMVbx2bD4scaHgjKPRyLp2NoCysBdnZmVG2sSMZmG/8MNqqZcPujaICD6IGmbYCSR6jCdPtM5yURorTUESIZHaSeKkpkrnRGQUbZhJkoYa8tB0+1VJuklvMIvVuPMogVuxlkFgtKi7A8KY0GJBvgXr1ud4Rx1BkHr2MzU25aaUHE1DM2ZUXhY/GXoasDAhGGwqqr3Ul7kN+bfshnrOD4uLR4thEiI1rQL2hqvBM5+M8TKCu9ls4TDIJVLhWjiSmDPc6eEZqR2dftjsn5jpbu2bZV4wAeQmw/1g7HKO06cvKchBKFDnmYrxB6ZnZ5BdtNs8nRnPK2qRat19OSDJoJ5RGySqXaRizphEbwTipF4NX2aNN11Uz3NhW0MNf3n0ww58PN6L51lPMXKQJpPkjlrPfEpVOGFUrWAWMVxiDWU/3cP3W4X55GgV9hKpV85s1j4x0exX2Yv7mKa4JLZR21Sd8MiFWy1DU1n+W9hQ5HIqm1YPyhVs5Ic173kLMJDPw4T02QMBhdWs3grupD/BHXHuSufp7cj8mvt7VuUcH7DdRwAk7uVAznMD0L6z1MmW7mdUM6+W0q0bvzbmy/nl/yv5z3CZ+yNmc7jNEolX8piG5Z5p5nw0fAt20jm+DOSCKBQH+Hnjc6H3fY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(2616005)(316002)(26005)(5660300002)(336012)(4326008)(8936002)(6916009)(41300700001)(16526019)(1076003)(40460700003)(186003)(86362001)(70206006)(478600001)(54906003)(40480700001)(70586007)(82740400003)(6666004)(7696005)(81166007)(2906002)(426003)(36860700001)(47076005)(4744005)(356005)(44832011)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:59:57.3454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf86105-c477-4b6c-4442-08db263fdf4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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
Cc: Tom StDenis <tom.stdenis@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umrgui to bash command line completion as well.

Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 344095b5d0633d..8bb2e7abb1fe97 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -400,3 +400,4 @@ _umr_completion()
 }
 
 complete -F _umr_completion umr
+complete -F _umr_completion umrgui

base-commit: e90f402de7d132a8faad94a8c093db5fe187f6d5
-- 
2.40.0

