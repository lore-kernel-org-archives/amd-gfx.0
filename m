Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37983C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 22:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69EE389EA6;
	Mon, 22 Nov 2021 22:25:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EACE89F01
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 22:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/NjEHG12UFJ0Jfq+jozqhhPSWUTuWprjVSE3b6K1dRFk+Cik4fVMdPhWjd0TMBymLxiA1wkrK4jkqh42XnD4Nn2d/HTYx5Kf5yTwMat4ssWus7zcqaqn9OsLrgyIbakcsDLdrrATbZBJt4sGADjSDW9Yf5MgEeLwr4s54Jp3SG4nNbsBWc/rgEE++hgjbo1PVpQmrQygy5jHktgKr9FKFVemlix0sn4TlmpNBTQwhlvfdQ1PSOiXsj9ddP81AwE5MzsUrzWPQUIqRihENuh0XOlzTqwzUPudQkMnrtipfVUbwTTCLHgdqrMOtFA3RuCIoK1YtEjcllMGAkjrXErbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRfwkugG7tksupQoXu/brXjYJ1uQEQMnsnvuC+2It2A=;
 b=W8+4PHZUj2rCLm53cCz4jcXThObvgmT6kSsb6cybEMct3OeDXYm1wa++AYG3WY8/95iNl049wZMPp+CBCP8WJjfadNR6PNmIxlH5IWHY1ap1fg3PlRRoftxZLX+xTI30OLiMzkcTmKOwpQ6Vx2ban9w8WEIcK9MMXsaO/NJQiqPlTKXdOfbQOqlnjdICuuK327vozYaWvZo4RZBH61RkQFd9iWsuu6BcYpcBFd56rHS7fQR7bOb8NsJjv/wavl4K7xJ/5WERDGWzrUlUuw9Ut6D9itOEGRPe/VOExqNPhh8KrqpoYxAChoJ+Dw94GF7/GSfTMA31HR22ktgWdWC/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRfwkugG7tksupQoXu/brXjYJ1uQEQMnsnvuC+2It2A=;
 b=Wh8I4edFEf9zbZsMQszkpL1tMXB/kkaAaoZTzzbbs/VCoxr+5zAkaXOT/0HTXnAZW/747k4CZ/JJtE4s8BSEO5bohqVRFOYSBumx3zwTr4CKFgITXCWTCTXY1Qy9e2RxiW/wCypz+vj39Mn3mGBvrek43BRfTDJViG3CNGQHLD0=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 22:25:35 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::46) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 22:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 22:25:34 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 16:25:33 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: Sienna: Print failed BTC
Date: Mon, 22 Nov 2021 17:25:11 -0500
Message-ID: <20211122222512.58886-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122222512.58886-1-luben.tuikov@amd.com>
References: <20211122222512.58886-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d8ce4c-8caa-41a9-e053-08d9ae070085
X-MS-TrafficTypeDiagnostic: MWHPR12MB1581:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15811F7576720906D919821E999F9@MWHPR12MB1581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byH1G1Kq8o7EmMCPL46Y+A9+tdLv647jSMgDp3R7vMRpYJVvtE1f+WupX6JHhreFvJtIZoUV3iiQdSLgk1fDmzHdKJXunygIG21EI1lQcaKsL1ccCnicUiY9euR7AzmMJfMk3qjOtECBxpvj6/JcP1Hxd1A3JaZ948YUUTNRncYgsVUnm3T4A9G/isVT/nbGWvwxpRFDVmPKfZe45R2F6niGlhJbzgnw/3iL+3xI0ghvjeqE2aabZdQdS0hr0b66G7E7OE8DZlY+ohJi1Q9ymKsFVX+Jr9umwOBTEYvglUNeRbYsTqSJoXD1rBe0K6SLDccSwv+N5UL8Y3k7oLoMEAdQXZ4UC/B+OCkNZy7YYP48p4JiXgDF85Nnyx2JHKchhUbNgz6lIlRr3NzJkrNDNLsAyjeM2WhAkNctcN2CJsjjIVvZolwktnydUWWtDIYFx8BZVvaY15/0wCx8SEGBvlygHl/4hi3368Zn9a2XgAO9zofWT9iJUzi2iTywJbnVUyQqUgFmjmPncdbcjfY+V2wAIOk3cYSRLVogZgn54eL4pqr3orMRzLrATcHsNEutBnNX6q+niVVc7t16gnvAt3HjVp3lMzo438ho/GnLbeCXrmLEE1RH71GANYbnAIGvymGwdnGR8lSbZ21DDU3aLkoEc8RD/pDjCHtDmif3fO7Z3r8vjPSsUaAu1Q/OvzDMfqZyOfEyLFX19WKma0zbMHEMORAS6OzFDQNPgA8w6Rk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(54906003)(82310400003)(83380400001)(36860700001)(316002)(70586007)(66574015)(6916009)(2616005)(70206006)(356005)(1076003)(426003)(86362001)(8676002)(6666004)(36756003)(16526019)(336012)(26005)(5660300002)(81166007)(508600001)(47076005)(2906002)(4326008)(8936002)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 22:25:34.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d8ce4c-8caa-41a9-e053-08d9ae070085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a print in sienna_cichlid_run_btc() to help debug and to mirror other
platforms, as no print is present in the caller, smu_smc_hw_setup().

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9d7b4fade30121..a7e3d40d8f0ecc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2142,7 +2142,13 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	int res;
+
+	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	if (res)
+		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+
+	return res;
 }
 
 static int sienna_cichlid_baco_enter(struct smu_context *smu)
-- 
2.34.0

