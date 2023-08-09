Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70D1C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 09:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1791310E40C;
	Wed,  9 Aug 2023 09:50:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E02910E412
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 09:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjc8tpyJ2D0e0aDZJkfhHRg5MoIdwZPyGqwDmbqXfk6idzDPXzW08CPniFgZY1SpI4ONDokve/iCy08m24rPLB1Y6FYLg+x/0Tf/MzOs7Fa6wMyNCIXLzWOl+1I20eBzHmCVRG76Bj2anZIHkiTrRCHfTWF2IypBvludAy5tqkWDqPO4pWmW8Rlyv5NjPHXiwxPVVd70jdRFbt8euw3oTFelrBkIYirVrGxa/E3Jyn2DYiAcyUzHaaU+GJbHOyw3Rz3HPiu43NpHO69qZCFOg4kcM/BnufJKIDc7dLruIPoRErd0Jim2CCNTPlbEpQfwgl64Ozgd12WxLC12fvbWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pahyytRbKxnUODuM1WvFU12ExyFNl+/W9huGsf3QRVc=;
 b=htdVHduMfbH/6yfxkSsu9aNK9kv4NhyYJ0Fv8xqhveOoFDHHmWN7yue+sQgsrwG2gUbgLD4ro4/zPwxkCEDILeSaZ8wdaxnkrYUmYMlxp4aU7t10j4FyvYTPLWCNJsx1m6EUNgu91KwDaNOAdCFKuh8zFWUufNXNk+BnZy5Db1Y3stoxb6WzmlzmyTlb6iOTR3gHrN2oltU1PiDQV/iy1Q/o2alN0xiq5773teDsO/c4QYU6cP12UFYM7oIS8DraV6kqMFsNlRnZIasUploa9YuOtHoafqZZyB3EV7c21yw37dVEN04uwViCmTHI9T1qYcotoA28ZHqI2Z+5vW8iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pahyytRbKxnUODuM1WvFU12ExyFNl+/W9huGsf3QRVc=;
 b=EbBr5dvg19Ae19xnn3IqSTPOvJ7vAW9gpsoICW1A7LfQFftOgrtta3NOgDWD3kYuVbYD7DOPuvjMHtEtS7Pm+644klsMb7XEIWsBB6Eyz0RoZpz5IqY1RwvE/Oy0DitJqS/Gfq4gLE0fHfr1iTtJkFuJOAOgzF+oXOd/BcNLC/0=
Received: from DM6PR02CA0070.namprd02.prod.outlook.com (2603:10b6:5:177::47)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 09:50:26 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::e6) by DM6PR02CA0070.outlook.office365.com
 (2603:10b6:5:177::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 09:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 09:50:25 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 04:50:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/radeon: Fix multiple line dereference in
 'atom_iio_execute'
Date: Wed, 9 Aug 2023 15:20:06 +0530
Message-ID: <20230809095006.253119-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: e54d9891-9294-47e4-aca5-08db98be0e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWL4r6pEjqeDrRB7cdRpeo3Drl6Ck4Yn8f8jaa9VB0HRN4DdhTYGiQxODcFb7QJ3vajfPnNiIaanm+2d1Tn/iTkG0nXqKb8J9yHxHpqZZK42wFGntEC8dz8ojmB8YIvObVoBjbmBK4zEmGYGpUFvJHNIsmIUQDmv2+JMn4JMNTd8TIP6dNPRHcCFjiCr1nf0fldENgI3xFbGWel/zZc09ReDpkAbUro5iEXdK/d5wMLMNwxofHGPseaW7sj5mkuQ+GxfxJr0q1mkKwMflcKSmzNzRMpKaxTth0Av4lJ2FbEpwn7lfzSZ7Q9ZPSXvL9ZOmi4wDMVQbLNS6VcIpQDLZT/DxIzAKSIM7b5bYFPN425ffAE1ew+NikEAW1XY9qGKk653BntfTEMfUePkPSP/5XTM2mZfGnDq7eJ+lhP5dCXpNdLnPEskJHrAu08DEdJDp5RmhnXb71ObA9mvP94Hx+e0dJXgRY4a5rlP5csLA83FLRdKXqc4nZB5r5f/QY4jMeq9AblFehIRjWPcizNBVXGFrANVHiD7D7b73ICp7dLF3LhOHuAVl0BTjzeSoR2H81QP8jowwVc+oZuS/Fjn6b18nhj4yoCyxoxVLuUN/bd0GNwYTag2I1nVUFLTkT9NqOE9ptDX5qFFusaWOKlLMa57kohZvudqvfaCefjfoiunKNq3LTDbMjEOLRcRH6rICIaCNpFSrzm1ZimurLi021TvDb1AxszLnaBkbmW3xfA7bXlGTGZnw5qCC5RRJteJd0eer4A2EYb5xBq053uBNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(66574015)(426003)(36860700001)(83380400001)(356005)(82740400003)(478600001)(81166007)(2616005)(47076005)(16526019)(336012)(40460700003)(1076003)(26005)(40480700001)(70206006)(70586007)(8676002)(41300700001)(8936002)(316002)(6636002)(2906002)(4326008)(7696005)(6666004)(36756003)(54906003)(110136005)(86362001)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 09:50:25.5830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54d9891-9294-47e4-aca5-08db98be0e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: Avoid multiple line dereference - prefer 'ctx->io_attr'
+                           ((ctx->
+                             io_attr >> CU8(base + 2)) & (0xFFFFFFFF >> (32 -

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/atom.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
index 93acb0e42bd6..ceb6d772ef94 100644
--- a/drivers/gpu/drm/radeon/atom.c
+++ b/drivers/gpu/drm/radeon/atom.c
@@ -163,13 +163,9 @@ static uint32_t atom_iio_execute(struct atom_context *ctx, int base,
 			    ~((0xFFFFFFFF >> (32 - CU8(base + 1))) <<
 			      CU8(base + 3));
 			temp |=
-			    ((ctx->
-			      io_attr >> CU8(base + 2)) & (0xFFFFFFFF >> (32 -
-									  CU8
-									  (base
-									   +
-									   1))))
-			    << CU8(base + 3);
+			    ((ctx->io_attr >> CU8(base + 2)) &
+			     (0xFFFFFFFF >> (32 - CU8(base + 1)))) <<
+			     CU8(base + 3);
 			base += 4;
 			break;
 		case ATOM_IIO_END:
-- 
2.25.1

