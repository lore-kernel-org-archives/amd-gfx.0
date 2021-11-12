Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A999C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A91461213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A91461213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EEB6EB27;
	Fri, 12 Nov 2021 00:55:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CE16EB1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMEFZfTVeH3gPR7TIlPlOAqcL4iCK6DQdvGx0qxsYKoA0tn93URfMHtuQy0PAhnPKjp36F/J6eqYqHse0EMjSz9snsqrxcIIYMAAmV6Bj04ad7X8/R0yvyloYqgMdgfiYuriS64wGHfIhuSz5n6ggZ3DEKtT7b0Y5QtFUT1qSQbLIL8S4bSUqZEtpjF0dJy9rNZe+v4joAURX2BEkp4dzxtBctYcOCE6MY7EVC27YZvXysfbK5BFXax35+ZMEEr9AfxhfhBuaaMXE9S0HBg2zTeD+kn+pCcnJYVl+Y4l+YgzA+Km8AOtLG8JDIeOZwygXOlIYW92+Vj8kjhjiHRD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woxqpcTsPOWLSoxLO0BGLVKxto4ULTeCLjdW8yts4c0=;
 b=AG7kPUXOR7nntMyXRTiSQpDER9PyPhZfJ1yvYP+EBsf51rhFf6J9jedwOV+Do8fTlIfR4TsP3TV9B8I85YSoJHmcxr5MAKz20yMov6in+oVXdd0AFYMFjvWF71faxDfkEPdqqppmGVtiMvIvw/NG3TfW01ArLHK1pRg5/jY6VgV3aQ4uz73U8iwav7gVq3Hpoq3O5hCpqMxvjvT6u20rGB39Du1oKPG6zv3AHVUfAS7A+5mT98KgU+npnwRk0V9lu5OQufQv3zIckZmSc/59upO/6Uaj1yuDqNHgbrM7MEA9iBZHkUp+Cdqcdi//6Mbc9TmNNP3Nk4O9xy5IOWywOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woxqpcTsPOWLSoxLO0BGLVKxto4ULTeCLjdW8yts4c0=;
 b=rUVan+dNuQ3rwdO8ys9XD2zRLF9HW41rAb9NImO7XzHjRTd9wuTRLpITvVVDCaSHSmEjEX7S0/3pq90KxQBCb3NXjesQG1zca+5fJmo5A/ZoeEVT0V2C248uUrY1+2V3JIy+0BoVU6iAY5wbw896cPgS3ThE2fizsAWVWpaWUDY=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Fri, 12 Nov
 2021 00:55:46 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::b6) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:44 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:41 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: [FW Promotion] Release 0.0.92
Date: Fri, 12 Nov 2021 08:54:34 +0800
Message-ID: <20211112005438.5505-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a532ca-9856-4194-dbb9-08d9a577291b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3017249CF18BC67154DDF713FC959@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYXBE2idAxp1P4mTE9iDFhECF1g4I+yuEmh4Xy5V5Pt/pPKfwDX0rlIq2/mpy0pX0Kb/Z3Sb/iier4m/QqXyvdz6t9rEE9cBzhh3LG63l3nAHPFRAvIzAP2ngv/xh6bypsQWr1v2IFSz+QDtoAAHp5tchbBBSdLJX7+n05bogGJhKidpDoOrO6x/cyyTZaE50R1aR64AzntYEJe2L03o7HgfnZG55RJ71qEkq9Zqf5HNZ2Aeruu8HunLW5D21EWbIzkNWkbXuJq4LcDUDHAtO58rvKRZphsE76uvpCx105KXGNdm1Qk6pdF+GPseZlx1ESzyXzGw0Zjn8owvAr50ca5/Tsu693aysYNdd9cceG0bs25HjJzOb+LSLSPVjJc56ThEaDfH2xYVxseUkQ93Mp2Vpf8NusySTYEPsgWvmcB+DHlTg1Peq/yNHfDMFIQI27CLXbgrsdoIB17a3zxBs6rAXw4+iZXBc9zlY04r7WOBLQISSINobr9VF1I9ulpjU9ec6sVqXQA4V8yEBJOIGN9nysAJuInHtsyOcGuw+gKeFsNJB1Fyt4ds3zW1JjQSVqCQRZILBJPfyJ0gwZsxFpfTR+O8FlwEYFdVhOuDZVbSG/p/hv0xAktFUUDxCOo0Rqj9wHZgXB4fqEwE6ghss1JGPIVCIQw8tc9uE36GVC9Sio+rtVvglzaEC7fRIqIV58PDmpHMHkehLkSdSyrFdXCA2oWo9Mot0PBGH7Dg5Ec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(36860700001)(4326008)(36756003)(316002)(86362001)(54906003)(2906002)(47076005)(508600001)(5660300002)(426003)(6916009)(70206006)(82310400003)(4744005)(336012)(356005)(8676002)(83380400001)(81166007)(2616005)(1076003)(26005)(70586007)(6666004)(8936002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:45.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a532ca-9856-4194-dbb9-08d9a577291b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ba30ab11b2ae..014ebd7242d5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x1d82d23e
+#define DMUB_FW_VERSION_GIT_HASH 0x058d3791
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 91
+#define DMUB_FW_VERSION_REVISION 92
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

