Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E399C63797
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 19:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CA410E12A;
	Sun, 15 Jan 2023 19:22:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8945710E08D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jan 2023 19:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDBSjFiU3dohRhebZztoaCQDsYXE8WZbjTr5wHSs05OtXs7LPXfJgs4Xm4aTMBLQPGGeomtfiMOYqK/520fvmdpF6DKzMtp0YsuKgNZ3ewIeCppDOvF5mVUtjTdkt0RYKAuptbWM851eLtpQPtjHeM3t2RW8wCOnSb8z4FUsxovdAiB4fFtHr2jWvEM/8P7rXtZd4ko7uxTulVHu1EbUZWKE3Bcr3VroVWLi2DNAwJeoUJ7PQG5GkGCZ9jLaC+7+2gXaiZxcH+iF7BXY8cp7q6UMDZe+63uFNKoY8ube6Q6RJ16kaZnegZSZgOMw40te/quvHDddhlKCNcXP2HdN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUNsJ3pkRXr3QSPFWvwCCzm8eZSmY0cCKo//92hfVCg=;
 b=Bo8GDBCkCdjiyXZ5HrZ/LsUWASK41nGRp8k3AIJ8LSB3cnvzg+qtJoWQ1YvMoBtuziPq3vLcNyRNfC7b0v2CiHMx6iEwbI9kKCoYYW7pgNq71vpsDsUpkDez8k/LuDOJRwGEhd1F8dgpKUIs3uoCJl/8ps5dp1OHVAyBVRjEs79eM0eR2/AMOK0jniKKM3SUcAUU5egLc+P65tL47dwMOg5i99dfM5ZjYOXCN1v2ee6gwEizAwRTBoo52DkWb2RDoQ63XaRbslkCb40XkC6Y9GscJ72hXygTpQru1o399Apod75cN0JAjfQJdd/AsxbSWF3+OoKnLJ8siMqjoAzM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUNsJ3pkRXr3QSPFWvwCCzm8eZSmY0cCKo//92hfVCg=;
 b=To+Bn0I+Xtj+BaiYkGoQ1F2URFph+bEgoavV7D9WqTFdO4NwAD0GLWrrEHjz+5ePwvfKT332ukG3RqPYFEjRG2R2hCtlqEbxQ6xdXnt5EFlchLhtL09zlAxWDeJToYn4UFWGMp3k5fuMXWDHDtojYx9+bVDHw6Ci+1QU9ZIB9Qk=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 19:22:07 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::30) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 19:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 19:22:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 13:22:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
Date: Sun, 15 Jan 2023 13:21:42 -0600
Message-ID: <20230115192144.4566-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a6d15a-06d0-409b-26d4-08daf72dca5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fPT495xkInHk6HpeJ/RWSAuR6FLDzrDvo5t1OaSMFhotqGgDQfdhDuXS1wK1epxEDEojg/EsT4J4v0h5Mk4GYKq65fXHe8Hw45bS7Pi2QYyRLHf6bXo5oRc2kZIWKn6Vkry/87x+/dGEAf0CNAKTDtVqwa6nBsHqM9XLEZSOjUVlvH3dYyGBJ3/0NUjbSnfJafBMjDZoVSe34vvNA9jeKPFcrg/v4c9PL89muNvhR3I2KJHocFKNMYTyNaJDugBGTBEWQtDXmVpNFTtGcHAjBJLenMus1bIvI+5lHk6l2eP+hOm4X9HPXzKseJAHpDY6+0LkVhHrRUEEL2SQtCkDdnlwpJ3YWN5OlQ4yXU6z6o5eAr5GCwcz3OxQTX8vU5Fq+hEIpOi4GzZkdbZ3esZD8Tg7DllosKSSGV1b2DdG14xAneGvvtH6PtOo9Gk32XaSN0dIWwTbK/FWBPYoU3h1JinB//gtaJirClbrpfR84+heX1Fs71C1aKvi7nzw8lHGe6ZZBSHw0bighwBvExLe/4q+12+ow0AKZerUDs2zwVutiQymn4BUU3OfvT5hjBRxteA9zqiwcCeqLsF26Ea2Qn+uDKhRobb0s5nUyvmEy+fzFvc3aZkITebfOkiJ9l1WVrgCLNCcVtWAe0ZD0xWD4VDN8tT1omXt0TX9s7TuwUReF8p92/biY0UBH38UQsAlqW/22Ca2u5r4ctVh7OzEyrRifkNfP9foVoYlcY5YQw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39850400004)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(7696005)(36860700001)(26005)(478600001)(2906002)(16526019)(82310400005)(186003)(70206006)(40460700003)(40480700001)(1076003)(426003)(316002)(4326008)(8676002)(41300700001)(36756003)(2616005)(47076005)(83380400001)(44832011)(81166007)(356005)(70586007)(8936002)(336012)(5660300002)(6916009)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 19:22:06.6125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a6d15a-06d0-409b-26d4-08daf72dca5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The switch/case statement currently combines 10.0.0 and 10.0.1, but
10.0.1 is only used for Raven 2.  So split the two cases up to
make this clearer.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index c03824d0311bd..0d950ae14b27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1074,15 +1074,11 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 			}
 			break;
 		case IP_VERSION(10, 0, 0):
+			if (adev->apu_flags & AMD_APU_IS_PICASSO)
+				return "picasso";
+			return "raven";
 		case IP_VERSION(10, 0, 1):
-			if (adev->asic_type == CHIP_RAVEN) {
-				if (adev->apu_flags & AMD_APU_IS_RAVEN2)
-					return "raven2";
-				else if (adev->apu_flags & AMD_APU_IS_PICASSO)
-					return "picasso";
-				return "raven";
-			}
-			break;
+			return "raven2";
 		case IP_VERSION(11, 0, 0):
 			return "navi10";
 		case IP_VERSION(11, 0, 2):
-- 
2.25.1

