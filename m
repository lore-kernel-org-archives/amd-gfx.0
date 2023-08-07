Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9556C001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 19:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BDD010E0E0;
	Mon,  7 Aug 2023 19:02:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAD010E0E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 19:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdFhLB+5/JyfjQedrWd0dqwT+yFp9h7c3N4pG4JxlZtKx7K9bVydZJnWwSm5vVH4Wsh7P6FpDBDbC0UuQMMO9rvR0wVKhNSh+o8VWE7j2FEvZAyndl24bTkf674tTXbnqhAQWrQuydHnzWn6V8Q7+YHmyDpaY9J5jHVp/7gIzKwqEWzanDgdOA+Qy3RkNp9BAautnIrjV5kAbhftetY3UGthHKxwU63VB5QxQuRu7uGeQ+zf8c0xankcnNP9PlBBGaYROjpNOlvbdHefGXeuK46V07H0UlETy4pOJ5GRQYLn3sSPY2kx1V/Qkkj/3MDDvl/BFN2TMaKc0B8L//hiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaD1J0wSLHxcTW2lXVCUpZplsk/jxMo9ULdtpPNlwwE=;
 b=nrzND/BDBfCti00rpCGNhVfMbrA9wEz/fsoTqHvI+G39gRtJQJIRUH99lNrmYmXWfWjC5LD3ML06Vfs2J75luMk/ffgIP0nFehSnMBDNhC64zFIwVDX1uGAEESuDugFry1ab5O+Bc6QGNF+0sMPw4H1ooGvVXdtIEWGnY7FdFBJ0xt0WS5Da9anRLTl7HtDUP0LPeqp7glnKMwcGlrZAwzMCedk3Lo4jq2+ZHmZseXnz3W/nYot+rWJs5mCcCS+oUw1RGeLD0W6w6sCs3bTBSgcn21I50eNR6Bq0tyvUzGjmgvzFb4khzH7Axvg52AzA+cgW8xQPpcWJB2vbl8UL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaD1J0wSLHxcTW2lXVCUpZplsk/jxMo9ULdtpPNlwwE=;
 b=TodD7YQEdbB2nJn1n98kCb/anjJlzI+E9XoCfXiaty9pBditi4JFIgTSNQklNHo8nDb81iM5/8DKlrtCNlFXBr00CR8nhPaykt5qwyuzR6jLKOz4jiskIMySFc9he3DYcm962KqqtpRFGyRb/XUh851X7tPK3guJdFUbAZBu7Ng=
Received: from CY5PR19CA0009.namprd19.prod.outlook.com (2603:10b6:930:15::6)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:02:07 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::9) by CY5PR19CA0009.outlook.office365.com
 (2603:10b6:930:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 19:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 19:02:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 14:02:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: only enable CP GFX shadowing on SR-IOV
Date: Mon, 7 Aug 2023 15:01:53 -0400
Message-ID: <20230807190153.837900-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ef7d80-ebb3-4c44-2e8f-08db9778cb67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBsxVaCZYe96jKMnBrWa5hnSec/YebIfv1E2aCfSkeTogK3WYick6K7la+SB0ZwuhPnhK3K3SSKknsOW4O5Bq7hfiBOMUntMSrs9xR+2OXva+1QXpp+vsuIBJmm3z7UDQJhZPcMowzSlaVAnwCrL4/bb8tDw0zcRX/x5mWdde/0W9O7scpFChtMs+D91Oud7BKq4x+Np+nBUJoXg4E6/JnU+Q7KhMhqB6+UOzEwqfrHoseVWJ5p62p/G+kupTBbmGeV0bR29aNVapb9R8iF0lnsOsiwKAfQ0TWYLHIjYaVNHAMqHWHPB/tPZhu2/j3a3ik1dTT+9JZqGTCwAUynkmEzibOCdvzrJDUeSEUmpY1NoDPYWfdp7RL/IMtcx8D3trmod7ujf/S2YVAQx/UPQyxQBLZH4qSNudGQTJLnHFabLxi4/p8dsricuEknBw/vUVDbsVWcX8gElI2Bt5PCOQkJXHEBtfbe48n99GktRf5aFkme0nebDOwlfNpEenjdKs/y6wfcr586N29sJUpU5ARVGXj9dTlvYIL+3wHb4ftlwaPJ/JYDdfPAU1zlNH4iBtQncj3ROUQl1xfk/C//aNsEVqoinK4lE4Eva+xNMmo0WUj7xaSNzSypu+IUEpNGbKbOXjes996qan9zGzibaPk1z24pRCI5PJ9bGoyw8hkbtI7SgRvwQhlSCtg2Ep0d0K7IgS8VIcHRAPbC/dJIneoE6N46y4LuGwRJE1/cZdspOf659W57NXL7jCBKL1w0Od9m0KIXhS2obBtkzb0jlHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(336012)(16526019)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(81166007)(478600001)(356005)(70206006)(6666004)(70586007)(7696005)(82740400003)(41300700001)(1076003)(26005)(426003)(8676002)(8936002)(47076005)(4744005)(36860700001)(2906002)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:02:06.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ef7d80-ebb3-4c44-2e8f-08db9778cb67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is only required for SR-IOV world switches, but it
adds additional latency leading to reduced performance in
some benchmarks.  Disable for now on bare metal.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4d53d6f13c3b7..288fddadb0085 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -472,7 +472,10 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 		if ((adev->gfx.me_fw_version >= 1505) &&
 		    (adev->gfx.pfp_fw_version >= 1600) &&
 		    (adev->gfx.mec_fw_version >= 512))
-			adev->gfx.cp_gfx_shadow = true;
+			if (amdgpu_sriov_vf(adev))
+				adev->gfx.cp_gfx_shadow = true;
+			else
+				adev->gfx.cp_gfx_shadow = false;
 		break;
 	default:
 		adev->gfx.cp_gfx_shadow = false;
-- 
2.41.0

