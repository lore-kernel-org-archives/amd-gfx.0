Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B3C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 03:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8717110F220;
	Mon,  6 Jun 2022 03:13:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6216110F220
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 03:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj92GNt7LEirx7UvSjzyyps5klyVpSWlWEX5m4iHS+Xvwk2RR9sAeV5Iyyq8MR0P6uQzWSVpc5vNSd/NZQLlEI3ebCqdFsdC/V3RLqWFgYMdwv6v7cZIHsxU8m/g++/ZB6k/ubDLLKD8tc9hvvPyw1srmguF8Od2LIJDmPQzuiZhCoSlXRK+gsyY+ieIsBJYhIzG0qepivRej3R+6mS/gj9X1xKOz26ls5AHkHkM8UvNn/uzkhrWZXQ4vvjR5RYP3VlsbLMNh/deWp1hXI473dAliV1T4kqrpY4m54EJ84WV5F1cw247w+rZXronDkpFyDSwbeDPgzOSlYdbRWvZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kD2zG6hdL/ytLJz/YDzgqG2OE2kk8Up1RRfCgzoN0=;
 b=XSTlzvwV5phX2Ninr7fmy5SPxvlc+dwTHzDOYn1e49hxLT02fqUoKrOd3SWRlTWhISmPPIHOVlvBwo2ThvaVPlTtoBPxivphubs0jOn84s0Tb0Y49cimrbJjEGmpwxwfF/sA/3m+P7DPcfdceQ9IhNXAy7pFj21I8cNNHKyt+CD9v9VRFln36EuTPt7FiNVwzodvedNeKiivRlevyZL9XTWB5KhM8xLheyxDrcGwa52eAygmFNc7gfht9mhUwYgF1Ql7j4QIreL0SB2oqZsMZBXMBCEwM+ICimIpQJFkKrQdjm2oOrSIOk9HGD6jdS9iHOCpG2x0iQd9vDW/KcCi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kD2zG6hdL/ytLJz/YDzgqG2OE2kk8Up1RRfCgzoN0=;
 b=eEutsmkcK1cYZVTgZxWtyJhM6txTIGiBi6yow0o2xepFbPZT2DFnUhgIXoPutdf6GId6gy/a+XTMwZWtg5W2HdVt7oVqtU5kjjEnQ+yVd9T5a8EpGm6jpeliDvVGnMcCYfG4ZuPjqJtumHlNacV0l8QnMDnpBY78imxNkDJIh3A=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 03:13:23 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a1) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 03:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 03:13:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 22:12:31 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/6] drm/amd/pm: drop unneeded dpm features disablement for
 SMU 13.0.0/7
Date: Mon, 6 Jun 2022 11:11:24 +0800
Message-ID: <20220606031124.1818265-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
References: <20220606031124.1818265-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4679cf-a472-4ba4-0d9d-08da476a8402
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3818E3947E8A09BFC7840143E4A29@DM6PR12MB3818.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bj1c1CQ9J5WczSCS2WpXL9fHucb5jbBU8uNOBHAjdTFmbqnl6JkKP8Ngat+urZDndOux9lK2K7035h+o0GDqLpHGIWvj8ffL3X6VJ+M0u2NPFC2uvtJXRPZG0LtE+kqVtxZaUkY3zXWyuQ9m6yEITw9a/ivXQURxnCEF81OO6Jts/Bfc4YtVlMuphO7b3QkLjSKZb521PA1a/pDk5hta1OMNJXANVMICVTtPy5vjH6tNGnwlCJ64bkZs9jqLxf4xkY/sdl32CLP8m4z8h1LYAMfDHboo1cstmL4xLBRLmpFBBiIuL5kP41ZeIYildKebUeP++4FD6uFsWdRcQUtc8EmJxK50texU73WBC6cvGKWMJ487v6qHBjktOgu6JsFq3dF1ZOU+wWWkSNDSy1aVDWfONUvvzPFZoK0Q+v+cIoxVjN4P7r8UtTcfKw/YjqUFHsl+i2VRkhWa+uUHxuAgepzr40x82vS6KJkOlltBUiGMl9Btgs5Pr04B9ysvYHK5UC9AOfWJhsw09jPeIba6ivoX9hTA/s+U/RSW4FUXzttVhCSuq2TDWx+6kcVu2j4ejQQy5d9WpEOCCQAmHoT3V70OMVhJjYPNMHtvwxkJkg0KYDopyo1kor3vnMwiQ8FFE7NFbeJwQ9lwDFjSiEoNP0JL9AoVVHFFVk6IGJsWtMcXI5en4xbaJobD4l8Y00QX04z4u7UlvgrLM4yByyNXZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(47076005)(426003)(336012)(83380400001)(4326008)(8936002)(54906003)(6916009)(7696005)(6666004)(316002)(2906002)(70586007)(36756003)(356005)(70206006)(1076003)(44832011)(82310400005)(86362001)(5660300002)(2616005)(81166007)(508600001)(36860700001)(16526019)(186003)(26005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 03:13:23.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4679cf-a472-4ba4-0d9d-08da476a8402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3818
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW will handle that properly. Driver involvement may cause some
unexpected issues.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I77da7d894485a3ac6a1a956e4d2605d0bc730c25
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a2db68847477..fd269b8510a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1402,6 +1402,18 @@ static int smu_disable_dpms(struct smu_context *smu)
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
 		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
 
+	/*
+	 * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(disablement or others)
+	 * properly on suspend/reset/unload. Driver involvement may cause some unexpected issues.
+	 */
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
+		return 0;
+	default:
+		break;
+	}
+
 	/*
 	 * For custom pptable uploading, skip the DPM features
 	 * disable process on Navi1x ASICs.
@@ -1439,7 +1451,6 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 5):
 		case IP_VERSION(11, 0, 9):
-		case IP_VERSION(13, 0, 0):
 			return 0;
 		default:
 			break;
-- 
2.29.0

