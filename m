Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A422CC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 03:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2735A10E0FB;
	Fri, 14 Jul 2023 03:42:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C51D10E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 03:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts64sNYWw2vRvByZMuAgeYe026LsV8yd0rDuO2ZgvEOkhCLljSRmaq14+lohJW1hZqbdNn8UiR5p1QsSpSMxJY/gsau6PAal0zgjn9524OKZ83H/4mUO/ZG62MoZDShkyUrjUIYWP0SA7Wft42BzQ4HsaKzqmoDZUR+vX7+xxtE7CszSC2l7XLwVbAkd5FydyawLnQX1BFdvjJJ+0Dv61EILikPvAXYUj+AZ6Xkv28b6r7nYcHD96XDPE4YFuDHvgl3oM29hoA4psu6rRDpPYmUiJmmIEQxhWgQJQBXgR9nhqEu3hY610MPRaI+lvAO/Pqm86hsexG30QMeMwskV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpE/BS+XNW+J4oc8Dpx59pUEJY85sDX+n1kP5sYs/Po=;
 b=IiwtfD5tJZVXWmH+xngCMNTgY6okoBzC9fh6YQlYX4V/M7m1ulLsOMQ4AoW9PZf5uJ3xHmacTeJs4DtIrLGXvMKOFu8MkRo82b6uCwc7BMTQFo7ya0aJ+dFgl5liVkkZ9G6PV+xcS5SQBgFenNJYB5E4O8+A062hts8S1yrYsyue1th8A2mSICowrvyDRfjjZs41UnpJkDjffp52D7I4YXaUaMb3QAq4RotVAMqx8HwVlTXTIq86LpQ0bgi0DDQRu21HKzF+2FIRuxIdbdd3bc0BX13/dgtNawUk2dOIe+s3Ou1o76WkaH7PlGsA0CxYTK/jCtTdEy6lYSBxTVGMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpE/BS+XNW+J4oc8Dpx59pUEJY85sDX+n1kP5sYs/Po=;
 b=JJeJ7mu7NyRy6oRPInQuOEFE5IxGlTzlnIDQ18+5Ghmh0ZQtikLz4tqLD0qoToIRqBwDSepjbk059FoDUgcTZCNrqOzzlxtoVoruY6D6rKWdq3HDqYYYiS7k9sd++Rh6BTjy1xeGCrWss92Y58UN8cDRUr007KPDz/WpAnXbrFE=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Fri, 14 Jul
 2023 03:42:23 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::1f) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Fri, 14 Jul 2023 03:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 03:42:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 22:42:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 22:42:22 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 13 Jul 2023 22:42:20 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review V3 2/2] drm/amdgpu: Disable RAS by default on APU
 flatform
Date: Fri, 14 Jul 2023 11:42:16 +0800
Message-ID: <20230714034216.500658-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714034216.500658-1-Stanley.Yang@amd.com>
References: <20230714034216.500658-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DM4PR12MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea16de1-07e7-4d92-30cb-08db841c55bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uucCPTReF0VmuIIgyYoqbBQ/zggJCxMOZmvf+J518O8AizcLbTp8dgXhGOjfgMEcBj9VYz8HNwMXX6dE/gfDdndvCCdNnaQPAJu26BgvWkVwGJfNgSzYOhZA3ksKVsw8YXBo36FVrZJePXfZE9fISZO+gE4ETBkAaRDd3Ulq1o3t6rXValMqiwdWVAy6xCOy0WsyqxtQznS4P68JN4uT1E5YXIKkgGomWHrNuDfg2BmhBZi23CKMP2pnsB3wJN0ugeOBDrHKVWhAvKPRpDnkeVU8T5jAOfPqtOL5hHgQ7tc7Q+dAzm2P2HVbYhMtHQQZ+pRarfZ1C4+tSkXpNPICZepMRGqav9Otoslf3BneNPw0zU4iEMXbcYgh0QtOLTuaSdkmFPZCiXVI2uoM+02YMIcfd8mqIqb/6C3o+t95zoBuVaYy/Mw6qSxyeBiaQf7EfkzDiF45EmizyYGQbbkV5c7LLfFOxl4MGNx80Cy3w2AIIIRwzzIfYKA5Sv8TQCFIH1mi7qpauQ7ETb0INd4MJkvk5vPn9/INjyI4yqQmIgyocCI6urqjJRX3WkUWbMlrV35Vwy5/ZSXXc6T8gnLsfvJ+5MtdMaPCtiEepy2NyUYKixmqYO85EWk18zdElFarD6dwt21yMk1vtracx1oyxgC+cReinp4PfKgWlBNAnJWZRS31A2+ywVDTZPhUELqQt/jzlpH7PxXDMSs6R72cQEpt+LlbaP15rBVFSkcO0C6i3ZN5+4iwp2dps9qFJHG2Xt5QmnbrXRozPjQkIbyE9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(1076003)(41300700001)(26005)(426003)(336012)(4326008)(6636002)(70586007)(70206006)(316002)(47076005)(82740400003)(356005)(36756003)(83380400001)(5660300002)(478600001)(86362001)(2906002)(186003)(40460700003)(6666004)(7696005)(82310400005)(8936002)(2616005)(110136005)(8676002)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 03:42:23.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea16de1-07e7-4d92-30cb-08db841c55bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable RAS feature by default for aqua vanjaram on APU platform.

Changed from V1:
	Splite Disable RAS by default on APU platform into a
	separated patch.

Changed from V2:
	Avoid to modify global variable amdgpu_ras_enable.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8673d9790bb0..c46e0ed9165e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2524,8 +2524,17 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	/* hw_supported needs to be aligned with RAS block mask. */
 	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
-	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
-		adev->ras_hw_enabled & amdgpu_ras_mask;
+
+	/*
+	 * Disable ras feature for aqua vanjaram
+	 * by default on apu platform.
+	 */
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6))
+		adev->ras_enabled = amdgpu_ras_enable != 1 ? 0 :
+			adev->ras_hw_enabled & amdgpu_ras_mask;
+	else
+		adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
+			adev->ras_hw_enabled & amdgpu_ras_mask;
 }
 
 static void amdgpu_ras_counte_dw(struct work_struct *work)
-- 
2.25.1

