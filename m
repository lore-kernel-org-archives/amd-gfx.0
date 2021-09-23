Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED288C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A8560F6B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 05:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3A8560F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BB36ECCD;
	Thu, 23 Sep 2021 05:42:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097366ECCD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 05:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1R4+28aAsv24S5C9wO/47eF3IYux46rpj5Vz9RXsc7CTXpZAHbK8Ek/LNry5QOvPS6iMbE62GjqR2hN0eWd/0BAAVAwh9UIOgOXEaZgEQWyWoslb4Le6FKmMuJEuSJwJYW97qKVoewrlTBNEhtbbgsfNvYwxUKwmpDfJ5LcLdy9yc607YI5g45/2AEop+ZYNRQUjQbZznAZeDJvo/XksyTdCvL827FEOZU9mg+yh50CzkMLC9jycqTtkPXUUlDnlhLqhjry/pAxngu8xWo7kaPDwcpMzjgOlxqsF6d6sqOLRD1hm2qc+q/BAYLMTOIWmspv5FyZIwisWO1a6x0ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cHqnF3284uSW2PxPCrs+JoiVeBowNrEFwu0fDSj4BzQ=;
 b=ObASdKu2SdE42HrGBmpFl3lbOOWeljpsKMiFWlywlsjrWkApnimhKPKTW3Zx+w0BX2uRGbYGe9Aatuv8QmyuuWoa+7gRkMrK6EFGJ1JPyRE8RrikjzKrVIdUMfJqsbpefiQLMbiDZLAto3X06vqmpDTjA26uV8Q3V8tpVjLiPMcsvNCl/I9thTdthuasc9nDPDW0Qn8n6lHKAkfOjA4XB5GdoL1th4S6BzuNkCG9Xoukzt7vNdQaPd6+qLT78i3+4Rs+x+NSFbky07dZQDzLMPkyi7u7fYCtHk9Xkox2v+hEBzxRpaAVquFTJfjm/ZUAEhwpu/JMF7Z4EGVVfgPZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHqnF3284uSW2PxPCrs+JoiVeBowNrEFwu0fDSj4BzQ=;
 b=g7/DSUJqX3P36xec3fcWya4CArx7iqSkf2LHUGI9jGzIHDMCzKv9MN6hipTOoqHsjgWstmBqttjjt7ipr7meY25hiBdOdiBJK5rRFzRLMGfm/QUv2G0+q7RygvP7r+x4MhQzEW+wa0oZSccFO4kdcjOlHr1M0v6KMLowuaCnSQY=
Received: from BN9PR03CA0787.namprd03.prod.outlook.com (2603:10b6:408:13f::12)
 by MN2PR12MB4608.namprd12.prod.outlook.com (2603:10b6:208:fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 05:42:44 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::d5) by BN9PR03CA0787.outlook.office365.com
 (2603:10b6:408:13f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 05:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 05:42:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 00:42:41 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Sean Keely <Sean.Keely@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>, "Chen
 Gong" <Curry.Gong@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix to use real compute unit number for
 shader array mask
Date: Thu, 23 Sep 2021 13:42:00 +0800
Message-ID: <20210923054201.1433036-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689f27a9-1a05-44cf-9584-08d97e54f731
X-MS-TrafficTypeDiagnostic: MN2PR12MB4608:
X-Microsoft-Antispam-PRVS: <MN2PR12MB46088C2DB6C869A410DCB455ECA39@MN2PR12MB4608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgHhC85Vc0GADO57HgoOveVh2sP5Kt7TtQ1IXo9ls57yuvHWsZbynDR3mi+TIxA0LYeYw1yWur/Qw0CRU+uQ+2g611lfk1AuEUydUg/Bb0JaKQNPPbfmWoLHtUuLTAx8c/pWcCd4nud0Mr4YbeG/g0SdEAqFbC1+IL35zCvw9Ej06AXOROqZJI769kKuTjv4mIaDguv4EyGGSSrH+3yG3GL0tMXJzx99Ys2yflbybrtSRYu7iRklFWkJ8Y+Rk1vcu/rRzgFZslrXwMhGDwd+PhOt6ciUAfs4J/5uNVFcC76DpTOPVdTno0cFBa5zcQoCN2ufgSVpiCpHm2FgDoDwqNb+ZkbvFI0IFH33NLJwDsBcOoyiASbvqxassviFkdNUtPzEbf3mGJFbsy/86UVByf3JoWoJTbasRG7i/N8u1szlupNisAy/9FnArerZqtfG/R8hc1fLQkOqjGJmnIpRtX3PkZrZ379BYE+x91vfxVbFHHnIGQ7/bYsitnfIYqkJa4ShiXlZdQHTiXvX5y6ofFcqW0msDG04SP4xwIIlkTMp8Mr7ZV7m0dworuj/036kQ/tqjH8YixQH32dN6prPwkzWEzpi2cNqyPuGRZyf6SZYNK6PuFAVjz2W6WmQsS2KTlOjvFswLcyqasJ+ZixubwyeX3lh/bV9RM2nxLVhTq4aQYSPJ5g4An/g7+Gq0np9TscdLpjqkZ6ZN+kDq3QyXSP383SljMCxZBaMQoX8nnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(83380400001)(426003)(1076003)(36860700001)(2616005)(2906002)(6916009)(86362001)(186003)(16526019)(5660300002)(47076005)(81166007)(82310400003)(336012)(356005)(70206006)(36756003)(54906003)(70586007)(8676002)(508600001)(7696005)(6666004)(26005)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 05:42:43.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689f27a9-1a05-44cf-9584-08d97e54f731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4608
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

We should use the real compute unit number for shader array mask. Some
asic doesn't have 16 compute units per shader array.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index c021519af810..0891c937f4da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -159,12 +159,12 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		se_mask[i] = 0;
 
 	i = 0;
-	for (cu = 0; cu < 16; cu++) {
+	for (cu = 0; cu < cu_info.num_cu_per_sh; cu++) {
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
 			for (se = 0; se < cu_info.num_shader_engines; se++) {
 				if (cu_per_sh[se][sh] > cu) {
 					if (cu_mask[i / 32] & (1 << (i % 32)))
-						se_mask[se] |= 1 << (cu + sh * 16);
+						se_mask[se] |= 1 << (cu + sh * cu_info.num_cu_per_sh);
 					i++;
 					if (i == cu_mask_count)
 						return;
-- 
2.25.1

