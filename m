Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E41C3DA78
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Jan 2023 03:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7989610E22C;
	Sat, 14 Jan 2023 03:02:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4565D10E22C
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Jan 2023 03:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5oNJt2r5H2ZzwOWWXZv1IEsbKspPktHoEbfCbH//BFV74kY3y5C7NAT1ePRN0AmBDzOYGAR+UcGQNdZpRWvs/l2ITmE1RjlcRi67J1iSdzCncUTFKxSfr4cGq9s9eyLUmcByaPcX11qtUib7/ThASpl5Kt7qr9/Zs17gBFoYc8CwZPnzpbQpn1X1jaQ/8SWmT9kOFegilfRwYPZmqVyfdAhIQsYVtuoACfIDMDiaviU6aITX5yg4/4tQah8dJKMnbfCrdDVNElV7X+GhLAPBouLuqsMlfBJ9Pw05p7PNSbCgLvpTC20jQf0s+4p3wOwNYjEcCs58fEZyoNPvZihnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9KpN63fedBHXUPW1AbruDYCZQcMHeto4Gb+LjpDyVE=;
 b=kLXLjEC5RM4mcjxU7qfBsyG0Uhcac0uQN8hawEQcWEqtL732JGTa+lOYW0iE4xJh3CwpqJ5CE8Fqsn6ZMDsnTsTZwWSVBlvGepvKkwZM0QkHVihFw9qCq5C8Ea8r9nscBold1B6mLEX15mVtoAtM2WkEH+A9ZT1+CldMpLAhFPshyQa09lHReKyBkV0unt6tPZWWqGdwyfEVTNhl7MnHNyxpKrwZLBBUzav4xx4l0VUUaepfU/sX74FshaA2I7IKnawBzOn+0ArmDd7Xgh0xcbCbkfCvf8l7j+3xHy+BKwIrYzIed3NVTQ56Wxs9GHLfI06rJ3Y/3bFnWFxtVupM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9KpN63fedBHXUPW1AbruDYCZQcMHeto4Gb+LjpDyVE=;
 b=mk8bF2ye2brbvvcfV/mp9eN1nagOmDgu5e5kgCGd5xXKit0WYsRT9TMbpFsdAeEanBypCVMpohvkdZkZNtHDHOke+y0Zb5EOnm+SGGlTPWrUKO7XFCDt5W1i+quNA7cYv+iU9lx1W73/uKAWD30pN3OcGn0ngjjT+ySNr+Ptgyg=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sat, 14 Jan
 2023 03:02:05 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::b7) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Sat, 14 Jan 2023 03:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Sat, 14 Jan 2023 03:02:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 21:02:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix renoir/green sardine MP0 IP version detection
Date: Fri, 13 Jan 2023 21:01:48 -0600
Message-ID: <20230114030148.139-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: accde5e8-dabb-47e2-5b6b-08daf5dbb74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6r5ycZ67bqLiZvSVQy4MiOXyQ0fNd7jLPl3Ci7/4avueeuYmFmV0rgC+6dqQXLvwNPJetsL6OSQpi19mnG5JWA972M5xyZ8dArh6ttZWsoJqRiil9NPbjyJOxymyxvdDJrYUVsTdEnoDsRzf5hqY8iqcFIk/KmYDD9GLP/2OMYYbLuaeVRl1rJ/HaLqV2DEALw525UvmSIKnVvuIIIQKUaMJNsPF65kZ0y5ZK+V3xuI/Dl5MZDWgM+IFMBugHTeEkgwU7FvSp9+mVuA4FkQiBx+6vlZCaF3HoLcA2FfV+W5piPlirro8jHd1ePKtrMudFQar8gpQt+EpMLngm1DH2M50U/aBOEx9jfrLK8wmPOGQ7gLDXsn36DNegscAhQp6hu1ic+im52U4X+4+/lGzUzboTlInvaevVrWzqh43n/Isj7qjTTumVhADKs7TdnJIDIxxYy7R4SZnFQuEWBm4owZRQTh0arK1ZS6qKV3D7pBrJ0yNBmNXuv0XQEAHZmPIroAnKJBGYYC1MHG98unp1rpoO3gZvDE3s5jOQpZoc8HTZ3EUarTI3EdqmCpkEDVZwhm/lbQJz4qP8jRpV5JbcN1SQeFKZ5UgBfrFn18tx8jpUgwR2iuKpdYHzkcNhKwEqiwXPgaj0xRTXjv8CIE9rPqDQ7WSEQ+nLPQV2q8KgSGoQAru+0Cw7ETHOj7MVuo62PtRk1izl1C92OCJvkCPgcielJc6gQndptzi8O1/EWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(356005)(44832011)(2906002)(86362001)(81166007)(5660300002)(40460700003)(82310400005)(8936002)(41300700001)(40480700001)(36860700001)(47076005)(426003)(83380400001)(82740400003)(54906003)(6666004)(478600001)(6916009)(7696005)(8676002)(4326008)(70206006)(2616005)(316002)(70586007)(336012)(16526019)(1076003)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 03:02:04.7508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accde5e8-dabb-47e2-5b6b-08daf5dbb74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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
Cc: Alex Hung <Alex.Hung@amd.com>, Nicholas Choi <Nicholas.Choi@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ekene Akuneme <Ekene.Akuneme@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing codebase never had a case for detecting MP0 version on
Renoir and instead relied upon hardcoded chip name.  This was missed as
part of the changes to migrate all IP blocks to build filenames from
`amdgpu_ucode.c`.

Consequently, Renoir tries to fetch a binary with 11_0_3 in the filename
and since it's supposed to have "renoir" in the filename fails to probe.
The fbdev still works though so the series worked.

Add a case for Renoir into the legacy table to ensure the right ASD and
TA firmware load again.

Reported-by: Ekene Akuneme <Ekene.Akuneme@amd.com>
Reported-by: Nicholas Choi <Nicholas.Choi@amd.com>
Cc: Alex Hung <Alex.Hung@amd.com>
Fixes: 994a97447e38 ("drm/amd: Parse both v1 and v2 TA microcode headers using same function")
Fixes: 54a3e032340e ("drm/amd: Add a legacy mapping to "amdgpu_ucode_ip_version_decode")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 47549d659d9b0..c03824d0311bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1087,6 +1087,8 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 			return "navi10";
 		case IP_VERSION(11, 0, 2):
 			return "vega20";
+		case IP_VERSION(11, 0, 3):
+			return "renoir";
 		case IP_VERSION(11, 0, 4):
 			return "arcturus";
 		case IP_VERSION(11, 0, 5):
@@ -1104,12 +1106,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 		case IP_VERSION(11, 5, 0):
 			return "vangogh";
 		case IP_VERSION(12, 0, 1):
-			if (adev->asic_type == CHIP_RENOIR) {
-				if (adev->apu_flags & AMD_APU_IS_RENOIR)
-					return "renoir";
-				return "green_sardine";
-			}
-			break;
+			return "green_sardine";
 		case IP_VERSION(13, 0, 2):
 			return "aldebaran";
 		case IP_VERSION(13, 0, 1):
-- 
2.34.1

