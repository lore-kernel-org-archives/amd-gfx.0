Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85258C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 22:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7BA10E0D7;
	Fri, 23 Feb 2024 22:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cF2HunZ7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3C710E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 22:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta2gtQzLSwl91QFOaiaAGK+462gCABWlevnEAGDyZQ7O2OEcRA4blOYjOzQH2txxVwtGDRKYSD+HSosuIlDpOt/gOYJHE0CWrluvjswQ9CTyZogQVojSzlZES5JiWbRhmYwBGUMoY6kAohhgXI72WgP5EXcVOJy3gvESdiVhlkmh3xbea7BOunWGibB/vFoxEgpWBHOpuFWmn2mSnb0yrzLSWTSflb3vdfj9Jq+bz1uwduZ1AtoKjRg1v1jfKPgEZknrIm5DIA5SllWrmxSps4C/4hYQmOrB2ZlTWlZFAVwIajmjttWvuIOWAnfOD23k3Y7EUMKkvbyy8oGs9o+CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZhlfwEpOex/RAPzuR3Aarrurofdiz6nWVX8wbL6t2s=;
 b=CPtBgd6NSClNmaacFwwK+9ePTogsasw+MduoWMADqwkjqiBYORZiXoTVft0MoVTSXXTBe6NF3OvH8hublTRzyszBSrU51r6NJb1YBK65upXctyGFPt1mqU+JTcZRBS0diRmB0jm8iPiSj/w5u/Qknvr52vf1lwoTp57XhL9ho5PK+Hp+huSQ9vormCClfpMNRdWO0ggFaTAdcCBhJMw7rycW37Ri76NlXt6Afdff3Q4710EXMFi0Cv1Oc/4m8O7NRoLY23F9MJ8cqLNx1xUds6TUBo7d7vHTpi3ymf8s+pC2ujE5O6dphJWZehi69hV1KkoZwwUtJ6VWvUzbxZyvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZhlfwEpOex/RAPzuR3Aarrurofdiz6nWVX8wbL6t2s=;
 b=cF2HunZ7TQEKNGQ7gVOA2NUazwf31o6oBe3yovm5OHckADBtLX7eyuzfRsTS2s6R/W5jcNSZkuF08vnbbtD+kR0AlHyQJobQKodm5HtWGk9e7wG9B7wonrJUrLWtIfvE+o9Zp5vaEPhmje11EV8pANPBEw1TuGleyjNhsJ5Mzzg=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 22:08:49 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::17) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15 via Frontend
 Transport; Fri, 23 Feb 2024 22:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 22:08:48 +0000
Received: from lmoriche-tr.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 16:08:47 -0600
From: Laurent Morichetti <laurent.morichetti@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, Laurent Morichetti <laurent.morichetti@amd.com>
Subject: [PATCH] drm/amdkfd: Use SQC when TCP would fail in gfx10.1 context
 save
Date: Fri, 23 Feb 2024 14:08:30 -0800
Message-ID: <20240223220830.1830131-1-laurent.morichetti@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4ef1d2-171e-4692-4f80-08dc34bc0310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJBzDiTzi0AjKTwDny/8PUcK9Qd3JKU5gerY6AhKyMBeC+hDAc46psCWzBK/+Rlk0d4RHylZZOp5m9KEWY1wXrHsyTxw6z2ioQRbfn54wfACGr/VDzgklDD3X1FuQBSpYIkEh7Xc5cKoL9Ua7d2AYyysC1AtxPaQM4nmcflBjDvNQrNU6fr3zVqgOLaJwzJgkeMiJepwzRDH8enWtZZ8dJG7mtbUlW04gQER1meDFBwHWD7Gf9QG1PMd59gXWOwH+4o9oWFipJEpadtsolpcs8wMPriQnytU9DQ699HuBSUnbCjQSEjHOAo5cf5IbRrFHWGm0b5/uo8IbYSizEjT76H8FbHeDldd6rEZl8kOtn9dUSDWP8vhC/lumjU3kn1udIUq7R8vJs2IaqiVtGsBGQMOkT0EfOyKw2rcMo17xTyXMFr/N452lddBwLR0vkT2zMnQ/bJgxqP4Cz3hLuVOxJfBwFDZVssnl5TfaZ+h9nU7RR1BrPjYWLEFz6PuBmd0r3r4DuihD/+zxOxBiloqDpNtF8UJ91f3CqvOl5+jUA+VYBtV21CMYgTdfrTWBon4TYVirtK22WTCUrBv8+p11eDALb6aWBQGenX5bG2Yd6N0+IbeuaUq61kgFj6Kc/b8O/q+QmeV518rKN6KglVH7EKHseQ2N1df7wN6qne6f54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:08:48.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4ef1d2-171e-4692-4f80-08dc34bc0310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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

Similarly to gfx9, gfx10.1 drops vector stores when an xnack error is
raised. To work around this issue, use scalar stores instead of vector
stores when trapsts.xnack_error == 1.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 543 ++++++++++++------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 156 ++++-
 2 files changed, 530 insertions(+), 169 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 2e9b64edb8d2..5a0308d26b53 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -678,7 +678,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
-	0xbf820001, 0xbf8201f5,
+	0xbf820001, 0xbf820394,
 	0xb0804004, 0xb978f802,
 	0x8a78ff78, 0x00020006,
 	0xb97bf803, 0x876eff78,
@@ -769,13 +769,90 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x877c817c, 0xbf06817c,
 	0xbf850002, 0xbeff0380,
 	0xbf820002, 0xbeff03c1,
-	0xbf82000b, 0xbef603ff,
-	0x01000000, 0xe0704000,
-	0x705d0000, 0xe0704080,
-	0x705d0100, 0xe0704100,
-	0x705d0200, 0xe0704180,
-	0x705d0300, 0xbf82000a,
-	0xbef603ff, 0x01000000,
+	0xbf820058, 0xbef603ff,
+	0x01000000, 0xb97af803,
+	0x8a7a7aff, 0x10000000,
+	0xbf850049, 0xbe840380,
+	0xd7600000, 0x00000900,
+	0x80048104, 0xd7600001,
+	0x00000900, 0x80048104,
+	0xd7600002, 0x00000900,
+	0x80048104, 0xd7600003,
+	0x00000900, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000901,
+	0x80048104, 0xd7600001,
+	0x00000901, 0x80048104,
+	0xd7600002, 0x00000901,
+	0x80048104, 0xd7600003,
+	0x00000901, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000902,
+	0x80048104, 0xd7600001,
+	0x00000902, 0x80048104,
+	0xd7600002, 0x00000902,
+	0x80048104, 0xd7600003,
+	0x00000902, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000903,
+	0x80048104, 0xd7600001,
+	0x00000903, 0x80048104,
+	0xd7600002, 0x00000903,
+	0x80048104, 0xd7600003,
+	0x00000903, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbf820060,
+	0xe0704000, 0x705d0000,
+	0xe0704080, 0x705d0100,
+	0xe0704100, 0x705d0200,
+	0xe0704180, 0x705d0300,
+	0xbf820057, 0xbef603ff,
+	0x01000000, 0xb97af803,
+	0x8a7a7aff, 0x10000000,
+	0xbf850049, 0xbe840380,
+	0xd7600000, 0x00000900,
+	0x80048104, 0xd7600001,
+	0x00000900, 0x80048104,
+	0xd7600002, 0x00000900,
+	0x80048104, 0xd7600003,
+	0x00000900, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06c004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000901,
+	0x80048104, 0xd7600001,
+	0x00000901, 0x80048104,
+	0xd7600002, 0x00000901,
+	0x80048104, 0xd7600003,
+	0x00000901, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06c004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000902,
+	0x80048104, 0xd7600001,
+	0x00000902, 0x80048104,
+	0xd7600002, 0x00000902,
+	0x80048104, 0xd7600003,
+	0x00000902, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06c004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000903,
+	0x80048104, 0xd7600001,
+	0x00000903, 0x80048104,
+	0xd7600002, 0x00000903,
+	0x80048104, 0xd7600003,
+	0x00000903, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06c004,
+	0xbf84ffef, 0xbf820008,
 	0xe0704000, 0x705d0000,
 	0xe0704100, 0x705d0100,
 	0xe0704200, 0x705d0200,
@@ -855,9 +932,9 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbf850002, 0xbeff0380,
 	0xbf820001, 0xbeff03c1,
 	0xb97b4306, 0x877bc17b,
-	0xbf840044, 0xbf8a0000,
+	0xbf840086, 0xbf8a0000,
 	0x877aff6d, 0x80000000,
-	0xbf840040, 0x8f7b867b,
+	0xbf840082, 0x8f7b867b,
 	0x8f7b827b, 0xbef6037b,
 	0xb9703a05, 0x80708170,
 	0xbf0d9973, 0xbf850002,
@@ -871,16 +948,49 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xd7660000, 0x000200c1,
 	0x16000084, 0x907c9973,
 	0x877c817c, 0xbf06817c,
-	0xbefc0380, 0xbf850012,
-	0xbe8303ff, 0x00000080,
+	0xbefc0380, 0xbf850033,
+	0xb97af803, 0x8a7a7aff,
+	0x10000000, 0xbf85001d,
+	0xd8d80000, 0x01000000,
+	0xbf8c0000, 0xbe840380,
+	0xd7600000, 0x00000901,
+	0x80048104, 0xd7600001,
+	0x00000901, 0x80048104,
+	0xd7600002, 0x00000901,
+	0x80048104, 0xd7600003,
+	0x00000901, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0x807cff7c,
+	0x00000080, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7c, 0xbf85ffe4,
+	0xbf820044, 0xbe8303ff,
+	0x00000080, 0xbf800000,
 	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
+	0xd8d80000, 0x01000000,
+	0xbf8c0000, 0xe0704000,
+	0x705d0100, 0x807c037c,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7c, 0xbf85fff4,
+	0xbf820032, 0xb97af803,
+	0x8a7a7aff, 0x10000000,
+	0xbf85001d, 0xd8d80000,
 	0x01000000, 0xbf8c0000,
-	0xe0704000, 0x705d0100,
-	0x807c037c, 0x80700370,
+	0xbe840380, 0xd7600000,
+	0x00000901, 0x80048104,
+	0xd7600001, 0x00000901,
+	0x80048104, 0xd7600002,
+	0x00000901, 0x80048104,
+	0xd7600003, 0x00000901,
+	0x80048104, 0xf469003a,
+	0xe0000000, 0x80709070,
+	0xbf06c004, 0xbf84ffef,
+	0x807cff7c, 0x00000100,
 	0xd5250000, 0x0001ff00,
-	0x00000080, 0xbf0a7b7c,
-	0xbf85fff4, 0xbf820011,
+	0x00000100, 0xbf0a7b7c,
+	0xbf85ffe4, 0xbf820011,
 	0xbe8303ff, 0x00000100,
 	0xbf800000, 0xbf800000,
 	0xbf800000, 0xd8d80000,
@@ -898,10 +1008,52 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbeff03c1, 0xb97b3a05,
 	0x807b817b, 0x8f7b827b,
 	0x907c9973, 0x877c817c,
-	0xbf06817c, 0xbf850017,
+	0xbf06817c, 0xbf85006b,
 	0xbef603ff, 0x01000000,
 	0xbefc0384, 0xbf0a7b7c,
-	0xbf840037, 0x7e008700,
+	0xbf8400fa, 0xb97af803,
+	0x8a7a7aff, 0x10000000,
+	0xbf850050, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0xbe840380,
+	0xd7600000, 0x00000900,
+	0x80048104, 0xd7600001,
+	0x00000900, 0x80048104,
+	0xd7600002, 0x00000900,
+	0x80048104, 0xd7600003,
+	0x00000900, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000901,
+	0x80048104, 0xd7600001,
+	0x00000901, 0x80048104,
+	0xd7600002, 0x00000901,
+	0x80048104, 0xd7600003,
+	0x00000901, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000902,
+	0x80048104, 0xd7600001,
+	0x00000902, 0x80048104,
+	0xd7600002, 0x00000902,
+	0x80048104, 0xd7600003,
+	0x00000902, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0xbe840380,
+	0xd7600000, 0x00000903,
+	0x80048104, 0xd7600001,
+	0x00000903, 0x80048104,
+	0xd7600002, 0x00000903,
+	0x80048104, 0xd7600003,
+	0x00000903, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06a004,
+	0xbf84ffef, 0x807c847c,
+	0xbf0a7b7c, 0xbf85ffb1,
+	0xbf8200a6, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xe0704000,
 	0x705d0000, 0xe0704080,
@@ -910,9 +1062,51 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x705d0300, 0x807c847c,
 	0x8070ff70, 0x00000200,
 	0xbf0a7b7c, 0xbf85ffef,
-	0xbf820025, 0xbef603ff,
+	0xbf820094, 0xbef603ff,
 	0x01000000, 0xbefc0384,
-	0xbf0a7b7c, 0xbf840011,
+	0xbf0a7b7c, 0xbf840065,
+	0xb97af803, 0x8a7a7aff,
+	0x10000000, 0xbf850050,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0xbe840380, 0xd7600000,
+	0x00000900, 0x80048104,
+	0xd7600001, 0x00000900,
+	0x80048104, 0xd7600002,
+	0x00000900, 0x80048104,
+	0xd7600003, 0x00000900,
+	0x80048104, 0xf469003a,
+	0xe0000000, 0x80709070,
+	0xbf06c004, 0xbf84ffef,
+	0xbe840380, 0xd7600000,
+	0x00000901, 0x80048104,
+	0xd7600001, 0x00000901,
+	0x80048104, 0xd7600002,
+	0x00000901, 0x80048104,
+	0xd7600003, 0x00000901,
+	0x80048104, 0xf469003a,
+	0xe0000000, 0x80709070,
+	0xbf06c004, 0xbf84ffef,
+	0xbe840380, 0xd7600000,
+	0x00000902, 0x80048104,
+	0xd7600001, 0x00000902,
+	0x80048104, 0xd7600002,
+	0x00000902, 0x80048104,
+	0xd7600003, 0x00000902,
+	0x80048104, 0xf469003a,
+	0xe0000000, 0x80709070,
+	0xbf06c004, 0xbf84ffef,
+	0xbe840380, 0xd7600000,
+	0x00000903, 0x80048104,
+	0xd7600001, 0x00000903,
+	0x80048104, 0xd7600002,
+	0x00000903, 0x80048104,
+	0xd7600003, 0x00000903,
+	0x80048104, 0xf469003a,
+	0xe0000000, 0x80709070,
+	0xbf06c004, 0xbf84ffef,
+	0x807c847c, 0xbf0a7b7c,
+	0xbf85ffb1, 0xbf82003b,
 	0x7e008700, 0x7e028701,
 	0x7e048702, 0x7e068703,
 	0xe0704000, 0x705d0000,
@@ -922,179 +1116,192 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x807c847c, 0x8070ff70,
 	0x00000400, 0xbf0a7b7c,
 	0xbf85ffef, 0xb97b1e06,
-	0x877bc17b, 0xbf84000c,
+	0x877bc17b, 0xbf840027,
 	0x8f7b837b, 0x807b7c7b,
 	0xbefe03c1, 0xbeff0380,
-	0x7e008700, 0xe0704000,
-	0x705d0000, 0x807c817c,
-	0x8070ff70, 0x00000080,
-	0xbf0a7b7c, 0xbf85fff8,
-	0xbf820144, 0xbef4037e,
-	0x8775ff7f, 0x0000ffff,
-	0x8875ff75, 0x00040000,
-	0xbef60380, 0xbef703ff,
-	0x10807fac, 0xb97202dc,
-	0x8f729972, 0x876eff7f,
-	0x04000000, 0xbf840034,
+	0xb97af803, 0x8a7a7aff,
+	0x10000000, 0xbf850017,
+	0x7e008700, 0xbe840380,
+	0xd7600000, 0x00000900,
+	0x80048104, 0xd7600001,
+	0x00000900, 0x80048104,
+	0xd7600002, 0x00000900,
+	0x80048104, 0xd7600003,
+	0x00000900, 0x80048104,
+	0xf469003a, 0xe0000000,
+	0x80709070, 0xbf06c004,
+	0xbf84ffef, 0x807c817c,
+	0xbf0a7b7c, 0xbf85ffea,
+	0xbf820008, 0x7e008700,
+	0xe0704000, 0x705d0000,
+	0x807c817c, 0x8070ff70,
+	0x00000080, 0xbf0a7b7c,
+	0xbf85fff8, 0xbf820144,
+	0xbef4037e, 0x8775ff7f,
+	0x0000ffff, 0x8875ff75,
+	0x00040000, 0xbef60380,
+	0xbef703ff, 0x10807fac,
+	0xb97202dc, 0x8f729972,
+	0x876eff7f, 0x04000000,
+	0xbf840034, 0xbefe03c1,
+	0x907c9972, 0x877c817c,
+	0xbf06817c, 0xbf850002,
+	0xbeff0380, 0xbf820001,
+	0xbeff03c1, 0xb96f4306,
+	0x876fc16f, 0xbf840029,
+	0x8f6f866f, 0x8f6f826f,
+	0xbef6036f, 0xb9783a05,
+	0x80788178, 0xbf0d9972,
+	0xbf850002, 0x8f788978,
+	0xbf820001, 0x8f788a78,
+	0xb96e1e06, 0x8f6e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef603ff,
+	0x01000000, 0x907c9972,
+	0x877c817c, 0xbf06817c,
+	0xbefc0380, 0xbf850009,
+	0xe0310000, 0x781d0000,
+	0x807cff7c, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7c, 0xbf85fff8,
+	0xbf820008, 0xe0310000,
+	0x781d0000, 0x807cff7c,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7c,
+	0xbf85fff8, 0xbef80380,
 	0xbefe03c1, 0x907c9972,
 	0x877c817c, 0xbf06817c,
 	0xbf850002, 0xbeff0380,
 	0xbf820001, 0xbeff03c1,
-	0xb96f4306, 0x876fc16f,
-	0xbf840029, 0x8f6f866f,
-	0x8f6f826f, 0xbef6036f,
-	0xb9783a05, 0x80788178,
-	0xbf0d9972, 0xbf850002,
-	0x8f788978, 0xbf820001,
-	0x8f788a78, 0xb96e1e06,
-	0x8f6e8a6e, 0x80786e78,
+	0xb96f3a05, 0x806f816f,
+	0x8f6f826f, 0x907c9972,
+	0x877c817c, 0xbf06817c,
+	0xbf850024, 0xbef603ff,
+	0x01000000, 0xbeee0378,
 	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef603ff, 0x01000000,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbefc0380,
-	0xbf850009, 0xe0310000,
-	0x781d0000, 0x807cff7c,
-	0x00000080, 0x8078ff78,
-	0x00000080, 0xbf0a6f7c,
-	0xbf85fff8, 0xbf820008,
-	0xe0310000, 0x781d0000,
-	0x807cff7c, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7c, 0xbf85fff8,
-	0xbef80380, 0xbefe03c1,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbf850002,
-	0xbeff0380, 0xbf820001,
-	0xbeff03c1, 0xb96f3a05,
-	0x806f816f, 0x8f6f826f,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbf850024,
-	0xbef603ff, 0x01000000,
-	0xbeee0378, 0x8078ff78,
-	0x00000200, 0xbefc0384,
-	0xbf0a6f7c, 0xbf840050,
+	0xbefc0384, 0xbf0a6f7c,
+	0xbf840050, 0xe0304000,
+	0x785d0000, 0xe0304080,
+	0x785d0100, 0xe0304100,
+	0x785d0200, 0xe0304180,
+	0x785d0300, 0xbf8c3f70,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807c847c, 0x8078ff78,
+	0x00000200, 0xbf0a6f7c,
+	0xbf85ffee, 0xe0304000,
+	0x6e5d0000, 0xe0304080,
+	0x6e5d0100, 0xe0304100,
+	0x6e5d0200, 0xe0304180,
+	0x6e5d0300, 0xbf8c3f70,
+	0xbf820034, 0xbef603ff,
+	0x01000000, 0xbeee0378,
+	0x8078ff78, 0x00000400,
+	0xbefc0384, 0xbf0a6f7c,
+	0xbf840012, 0xe0304000,
+	0x785d0000, 0xe0304100,
+	0x785d0100, 0xe0304200,
+	0x785d0200, 0xe0304300,
+	0x785d0300, 0xbf8c3f70,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807c847c, 0x8078ff78,
+	0x00000400, 0xbf0a6f7c,
+	0xbf85ffee, 0xb96f1e06,
+	0x876fc16f, 0xbf84000e,
+	0x8f6f836f, 0x806f7c6f,
+	0xbefe03c1, 0xbeff0380,
 	0xe0304000, 0x785d0000,
-	0xe0304080, 0x785d0100,
-	0xe0304100, 0x785d0200,
-	0xe0304180, 0x785d0300,
 	0xbf8c3f70, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807c847c,
-	0x8078ff78, 0x00000200,
-	0xbf0a6f7c, 0xbf85ffee,
+	0x807c817c, 0x8078ff78,
+	0x00000080, 0xbf0a6f7c,
+	0xbf85fff7, 0xbeff03c1,
 	0xe0304000, 0x6e5d0000,
-	0xe0304080, 0x6e5d0100,
-	0xe0304100, 0x6e5d0200,
-	0xe0304180, 0x6e5d0300,
-	0xbf8c3f70, 0xbf820034,
-	0xbef603ff, 0x01000000,
-	0xbeee0378, 0x8078ff78,
-	0x00000400, 0xbefc0384,
-	0xbf0a6f7c, 0xbf840012,
-	0xe0304000, 0x785d0000,
-	0xe0304100, 0x785d0100,
-	0xe0304200, 0x785d0200,
-	0xe0304300, 0x785d0300,
-	0xbf8c3f70, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807c847c,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7c, 0xbf85ffee,
-	0xb96f1e06, 0x876fc16f,
-	0xbf84000e, 0x8f6f836f,
-	0x806f7c6f, 0xbefe03c1,
-	0xbeff0380, 0xe0304000,
-	0x785d0000, 0xbf8c3f70,
-	0x7e008500, 0x807c817c,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7c, 0xbf85fff7,
-	0xbeff03c1, 0xe0304000,
-	0x6e5d0000, 0xe0304100,
-	0x6e5d0100, 0xe0304200,
-	0x6e5d0200, 0xe0304300,
-	0x6e5d0300, 0xbf8c3f70,
+	0xe0304100, 0x6e5d0100,
+	0xe0304200, 0x6e5d0200,
+	0xe0304300, 0x6e5d0300,
+	0xbf8c3f70, 0xb9783a05,
+	0x80788178, 0xbf0d9972,
+	0xbf850002, 0x8f788978,
+	0xbf820001, 0x8f788a78,
+	0xb96e1e06, 0x8f6e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000050, 0xbef603ff,
+	0x01000000, 0xbefc03ff,
+	0x0000006c, 0x80f89078,
+	0xf429003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc847c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0x80f8a078,
+	0xf42d003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc887c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0xbe843104,
+	0xbe863106, 0x80f8c078,
+	0xf431003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc907c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0xbe843104,
+	0xbe863106, 0xbe883108,
+	0xbe8a310a, 0xbe8c310c,
+	0xbe8e310e, 0xbf06807c,
+	0xbf84fff0, 0xba80f801,
+	0x00000000, 0xbf8a0000,
 	0xb9783a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
 	0x8f6e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000050,
 	0xbef603ff, 0x01000000,
-	0xbefc03ff, 0x0000006c,
-	0x80f89078, 0xf429003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc847c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0x80f8a078, 0xf42d003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc887c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0xbe843104, 0xbe863106,
-	0x80f8c078, 0xf431003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc907c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0xbe843104, 0xbe863106,
-	0xbe883108, 0xbe8a310a,
-	0xbe8c310c, 0xbe8e310e,
-	0xbf06807c, 0xbf84fff0,
-	0xba80f801, 0x00000000,
-	0xbf8a0000, 0xb9783a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef603ff,
-	0x01000000, 0xf4211bfa,
+	0xf4211bfa, 0xf0000000,
+	0x80788478, 0xf4211b3a,
 	0xf0000000, 0x80788478,
-	0xf4211b3a, 0xf0000000,
-	0x80788478, 0xf4211b7a,
+	0xf4211b7a, 0xf0000000,
+	0x80788478, 0xf4211c3a,
 	0xf0000000, 0x80788478,
-	0xf4211c3a, 0xf0000000,
-	0x80788478, 0xf4211c7a,
+	0xf4211c7a, 0xf0000000,
+	0x80788478, 0xf4211eba,
 	0xf0000000, 0x80788478,
-	0xf4211eba, 0xf0000000,
-	0x80788478, 0xf4211efa,
+	0xf4211efa, 0xf0000000,
+	0x80788478, 0xf4211e7a,
 	0xf0000000, 0x80788478,
-	0xf4211e7a, 0xf0000000,
-	0x80788478, 0xf4211cfa,
+	0xf4211cfa, 0xf0000000,
+	0x80788478, 0xf4211bba,
 	0xf0000000, 0x80788478,
+	0xbf8cc07f, 0xb9eef814,
 	0xf4211bba, 0xf0000000,
 	0x80788478, 0xbf8cc07f,
-	0xb9eef814, 0xf4211bba,
-	0xf0000000, 0x80788478,
-	0xbf8cc07f, 0xb9eef815,
-	0xbefc036f, 0xbefe0370,
-	0xbeff0371, 0x876f7bff,
-	0x000003ff, 0xb9ef4803,
-	0xb9f9f816, 0x876f7bff,
-	0xfffff800, 0x906f8b6f,
-	0xb9efa2c3, 0xb9f3f801,
-	0xb96e3a05, 0x806e816e,
-	0xbf0d9972, 0xbf850002,
-	0x8f6e896e, 0xbf820001,
-	0x8f6e8a6e, 0xb96f1e06,
-	0x8f6f8a6f, 0x806e6f6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x876fff6f, 0x0000ffff,
-	0xf4091c37, 0xfa000050,
-	0xf4091d37, 0xfa000060,
-	0xf4011e77, 0xfa000074,
-	0xbf8cc07f, 0x906e8977,
-	0x876fff6e, 0x003f8000,
-	0x906e8677, 0x876eff6e,
-	0x02000000, 0x886e6f6e,
-	0xb9eef807, 0x876dff6d,
-	0x0000ffff, 0x87fe7e7e,
-	0x87ea6a6a, 0xb9faf802,
-	0xbe80226c, 0xbf9b0000,
+	0xb9eef815, 0xbefc036f,
+	0xbefe0370, 0xbeff0371,
+	0x876f7bff, 0x000003ff,
+	0xb9ef4803, 0xb9f9f816,
+	0x876f7bff, 0xfffff800,
+	0x906f8b6f, 0xb9efa2c3,
+	0xb9f3f801, 0xb96e3a05,
+	0x806e816e, 0xbf0d9972,
+	0xbf850002, 0x8f6e896e,
+	0xbf820001, 0x8f6e8a6e,
+	0xb96f1e06, 0x8f6f8a6f,
+	0x806e6f6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x876fff6f,
+	0x0000ffff, 0xf4091c37,
+	0xfa000050, 0xf4091d37,
+	0xfa000060, 0xf4011e77,
+	0xfa000074, 0xbf8cc07f,
+	0x906e8977, 0x876fff6e,
+	0x003f8000, 0x906e8677,
+	0x876eff6e, 0x02000000,
+	0x886e6f6e, 0xb9eef807,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0xb9faf802, 0xbe80226c,
+	0xbf9b0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 7568ff3af978..e1aaa5ce0784 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -44,6 +44,7 @@
 #define HAVE_SENDMSG_RTN (ASIC_FAMILY >= CHIP_PLUM_BONITO)
 #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
 #define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO)
+#define SAVE_AFTER_XNACK_ERROR (HAVE_XNACK && !NO_SQC_STORE) // workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
 
 var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
@@ -86,6 +87,7 @@ var SQ_WAVE_TRAPSTS_WAVE_START_MASK		= 0x20000
 var SQ_WAVE_TRAPSTS_WAVE_END_MASK		= 0x40000
 var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK	= 0x100000
 #endif
+var SQ_WAVE_TRAPSTS_XNACK_ERROR_MASK		= 0x10000000
 
 var SQ_WAVE_MODE_EXCP_EN_SHIFT			= 12
 var SQ_WAVE_MODE_EXCP_EN_ADDR_WATCH_SHIFT	= 19
@@ -475,6 +477,16 @@ L_SAVE_4VGPR_WAVE32:
 
 	// VGPR Allocated in 4-GPR granularity
 
+#if SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_FIRST_VGPRS32_WITH_TCP
+
+	write_vgprs_to_mem_with_sqc_w32(v0, 4, s_save_buf_rsrc0, s_save_mem_offset)
+	s_branch L_SAVE_HWREG
+
+L_SAVE_FIRST_VGPRS32_WITH_TCP:
+#endif
+
 #if !NO_SQC_STORE
 	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
 #endif
@@ -488,6 +500,16 @@ L_SAVE_4VGPR_WAVE64:
 
 	// VGPR Allocated in 4-GPR granularity
 
+#if  SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_FIRST_VGPRS64_WITH_TCP
+
+	write_vgprs_to_mem_with_sqc_w64(v0, 4, s_save_buf_rsrc0, s_save_mem_offset)
+	s_branch L_SAVE_HWREG
+
+L_SAVE_FIRST_VGPRS64_WITH_TCP:
+#endif
+
 #if !NO_SQC_STORE
 	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
 #endif
@@ -660,6 +682,26 @@ L_SAVE_LDS_NORMAL:
 	s_cbranch_scc1	L_SAVE_LDS_W64
 
 L_SAVE_LDS_W32:
+#if SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_LDS_WITH_TCP_W32
+
+L_SAVE_LDS_LOOP_SQC_W32:
+	ds_read_b32	v1, v0
+	s_waitcnt	0
+
+	write_vgprs_to_mem_with_sqc_w32(v1, 1, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_add_u32	m0, m0, 128						//every buffer_store_lds does 128 bytes
+	v_add_nc_u32	v0, v0, 128						//mem offset increased by 128 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc=(m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_LDS_LOOP_SQC_W32					//LDS save is complete?
+
+	s_branch	L_SAVE_LDS_DONE
+
+L_SAVE_LDS_WITH_TCP_W32:
+#endif
+
 	s_mov_b32	s3, 128
 	s_nop		0
 	s_nop		0
@@ -669,7 +711,7 @@ L_SAVE_LDS_LOOP_W32:
 	s_waitcnt	0
 	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
 
-	s_add_u32	m0, m0, s3						//every buffer_store_lds does 256 bytes
+	s_add_u32	m0, m0, s3						//every buffer_store_lds does 128 bytes
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, s3
 	v_add_nc_u32	v0, v0, 128						//mem offset increased by 128 bytes
 	s_cmp_lt_u32	m0, s_save_alloc_size					//scc=(m0 < s_save_alloc_size) ? 1 : 0
@@ -678,6 +720,26 @@ L_SAVE_LDS_LOOP_W32:
 	s_branch	L_SAVE_LDS_DONE
 
 L_SAVE_LDS_W64:
+#if  SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_LDS_WITH_TCP_W64
+
+L_SAVE_LDS_LOOP_SQC_W64:
+	ds_read_b32	v1, v0
+	s_waitcnt	0
+
+	write_vgprs_to_mem_with_sqc_w64(v1, 1, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_add_u32	m0, m0, 256						//every buffer_store_lds does 256 bytes
+	v_add_nc_u32	v0, v0, 256						//mem offset increased by 256 bytes
+	s_cmp_lt_u32	m0, s_save_alloc_size					//scc=(m0 < s_save_alloc_size) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_LDS_LOOP_SQC_W64					//LDS save is complete?
+
+	s_branch	L_SAVE_LDS_DONE
+
+L_SAVE_LDS_WITH_TCP_W64:
+#endif
+
 	s_mov_b32	s3, 256
 	s_nop		0
 	s_nop		0
@@ -727,6 +789,25 @@ L_SAVE_VGPR_NORMAL:
 	s_cmp_lt_u32	m0, s_save_alloc_size
 	s_cbranch_scc0	L_SAVE_VGPR_END
 
+#if  SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_VGPR_W32_LOOP
+
+L_SAVE_VGPR_LOOP_SQC_W32:
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	v_movrels_b32	v1, v1							//v1 = v[1+m0]
+	v_movrels_b32	v2, v2							//v2 = v[2+m0]
+	v_movrels_b32	v3, v3							//v3 = v[3+m0]
+
+	write_vgprs_to_mem_with_sqc_w32(v0, 4, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_add_u32 m0, m0, 4
+	s_cmp_lt_u32 m0, s_save_alloc_size
+	s_cbranch_scc1 L_SAVE_VGPR_LOOP_SQC_W32
+
+	s_branch L_SAVE_VGPR_END
+#endif
+
 L_SAVE_VGPR_W32_LOOP:
 	v_movrels_b32	v0, v0							//v0 = v[0+m0]
 	v_movrels_b32	v1, v1							//v1 = v[1+m0]
@@ -753,6 +834,25 @@ L_SAVE_VGPR_WAVE64:
 	s_cmp_lt_u32	m0, s_save_alloc_size
 	s_cbranch_scc0	L_SAVE_SHARED_VGPR
 
+#if  SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_VGPR_W64_LOOP
+
+L_SAVE_VGPR_LOOP_SQC_W64:
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	v_movrels_b32	v1, v1							//v1 = v[1+m0]
+	v_movrels_b32	v2, v2							//v2 = v[2+m0]
+	v_movrels_b32	v3, v3							//v3 = v[3+m0]
+
+	write_vgprs_to_mem_with_sqc_w64(v0, 4, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_add_u32 m0, m0, 4
+	s_cmp_lt_u32 m0, s_save_alloc_size
+	s_cbranch_scc1 L_SAVE_VGPR_LOOP_SQC_W64
+
+	s_branch L_SAVE_VGPR_END
+#endif
+
 L_SAVE_VGPR_W64_LOOP:
 	v_movrels_b32	v0, v0							//v0 = v[0+m0]
 	v_movrels_b32	v1, v1							//v1 = v[1+m0]
@@ -780,6 +880,23 @@ L_SAVE_SHARED_VGPR:
 	s_add_u32	s_save_alloc_size, s_save_alloc_size, m0
 	s_mov_b32	exec_lo, 0xFFFFFFFF
 	s_mov_b32	exec_hi, 0x00000000
+
+#if  SAVE_AFTER_XNACK_ERROR
+	check_if_tcp_store_ok()
+	s_cbranch_scc1 L_SAVE_SHARED_VGPR_WAVE64_LOOP
+
+L_SAVE_SHARED_VGPR_WAVE64_LOOP_SQC:
+	v_movrels_b32	v0, v0
+
+	write_vgprs_to_mem_with_sqc_w64(v0, 1, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_add_u32 m0, m0, 1
+	s_cmp_lt_u32 m0, s_save_alloc_size
+	s_cbranch_scc1 L_SAVE_SHARED_VGPR_WAVE64_LOOP_SQC
+
+	s_branch L_SAVE_VGPR_END
+#endif
+
 L_SAVE_SHARED_VGPR_WAVE64_LOOP:
 	v_movrels_b32	v0, v0							//v0 = v[0+m0]
 	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
@@ -1190,6 +1307,43 @@ function read_4sgpr_from_mem(s, s_rsrc, s_mem_offset)
 	s_buffer_load_dwordx4	s, s_rsrc, s_mem_offset glc:1
 end
 
+#if SAVE_AFTER_XNACK_ERROR
+function check_if_tcp_store_ok
+	// If TRAPSTS.XNACK_ERROR=1 then TCP stores will fail.
+	s_getreg_b32 s_save_tmp, hwreg(HW_REG_TRAPSTS)
+	s_andn2_b32 s_save_tmp, SQ_WAVE_TRAPSTS_XNACK_ERROR_MASK, s_save_tmp
+
+L_TCP_STORE_CHECK_DONE:
+end
+
+function write_vgpr_to_mem_with_sqc(vgpr, n_lanes, s_rsrc, s_mem_offset)
+	s_mov_b32 s4, 0
+
+L_WRITE_VGPR_LANE_LOOP:
+	for var lane = 0; lane < 4; ++lane
+		v_readlane_b32 s[lane], vgpr, s4
+		s_add_u32 s4, s4, 1
+	end
+
+	s_buffer_store_dwordx4 s[0:3], s_rsrc, s_mem_offset glc:1
+
+	s_add_u32 s_mem_offset, s_mem_offset, 0x10
+	s_cmp_eq_u32 s4, n_lanes
+	s_cbranch_scc0 L_WRITE_VGPR_LANE_LOOP
+end
+
+function write_vgprs_to_mem_with_sqc_w32(vgpr0, n_vgprs, s_rsrc, s_mem_offset)
+	for var vgpr = 0; vgpr < n_vgprs; ++vgpr
+		write_vgpr_to_mem_with_sqc(vgpr0[vgpr], 32, s_rsrc, s_mem_offset)
+	end
+end
+
+function write_vgprs_to_mem_with_sqc_w64(vgpr0, n_vgprs, s_rsrc, s_mem_offset)
+	for var vgpr = 0; vgpr < n_vgprs; ++vgpr
+		write_vgpr_to_mem_with_sqc(vgpr0[vgpr], 64, s_rsrc, s_mem_offset)
+	end
+end
+#endif
 
 function get_lds_size_bytes(s_lds_size_byte)
 	s_getreg_b32	s_lds_size_byte, hwreg(HW_REG_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)

base-commit: 420b2460a743b320868f30e407d4c4685958ea2c
prerequisite-patch-id: 9415524d1e3a92ea7fba9d636f2d34746ca9ef95
-- 
2.25.1

