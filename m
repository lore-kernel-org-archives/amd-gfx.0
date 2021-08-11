Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BB1C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276F560527
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 276F560527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A145F6E0DC;
	Wed, 11 Aug 2021 08:33:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00416E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 08:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlpJ5lpT29hTGMdKAPXTfincrduAXEPZ/KOBOl09pDVYGWReqxSs9M2Ns3MYsyNFJKdS/k30/UISgHu/DcrpssXMdWqE5QcrokkQiUtjl23jyVG/OrdHIA8BlyN9ZSM0MJsjx1v6cqomFZXLmSCJtuOdbXUqLNavhiiqQylZ/qn4MTxbui7id9UoDDTu7lXuP2wIKeb+VUAsRHojzGIUrlaHbYLmiUQnoI9bjJXxz9bcQPSToORbjZPNoKnYHugaSfmMnHgiOLmNkD7DnglZwJlTUtDYSqaTc5VyapkmkMwXfEZFTfwliXuMvKV8qMblJmCYndm+hukTuJtMD2Fv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD6vYUoR1ooWk8+Q3HR87RqpdRaZ1u+gFpuFR94oIZY=;
 b=ZQCoQB1tKdnJLD89rCDZteqDBMllF41hPWDy6Fvv747lmkx3D1sy6sSnM5HJoqnd9rblZBrh4bYnT1WnOG8xZnt2b4+vTlHy2PoJhuuRJ6zQ89Wl1YU8AYdXGCG+roMkyxD3a1l9JQwq6KeczlgsXlJw0Qg/O66w8lxvtRGd2x4VrzAVJciRaW8nSe7MbNilo+TdqBIyovjGLfQ5Gm00FV+ViVEykboxcVrmAbhGthH7Hg41srYPIKbqoM5sq+lC9e9EF2cc2qEL04eOb02qwrI9cwdurqxEN5w92TdvEnAaIxJWp+z0xHesfpY1Y3ua/VvYBAfQXPkDxRj9olY+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD6vYUoR1ooWk8+Q3HR87RqpdRaZ1u+gFpuFR94oIZY=;
 b=GshRkJsrvRmIidfU4mSMLpkl8gMBy2yUwxBuji8Sd7MJrDXNNEnj7j8utXBOMJ29chRMj8nNSTAzqOlQiKWXKX8G/FWYVSiD8Mc8zVg4XqS228CCAv2MwJiFSN3GWoiq3VByz07pHEeXTPtYFVadDRDkm0zxjmbjXCt1aOZe0EU=
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 08:33:38 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::dd) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 08:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 08:33:37 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 03:33:35 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH 4/5] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
Date: Wed, 11 Aug 2021 16:33:22 +0800
Message-ID: <20210811083323.1084225-4-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811083323.1084225-1-kevin1.wang@amd.com>
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f9970e4-4773-4472-bd55-08d95ca2b728
X-MS-TrafficTypeDiagnostic: BY5PR12MB4100:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41004545F89D546ABCFE585DA2F89@BY5PR12MB4100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lRnV5zfdQKt9f5ImyCJk6CzLfKZcCogaTtkPgaXz0BTJYYNqNcry2caHaCo24zKgIMYd86AMH2RfkGP1rAKnca6cLpbthNVWpThwpHqAyM7klD9crQqXTw0M6gEiB0eTXK7z1qv6s9bxKM3NARVYbQLuvKTssT9mDSaHXu9fgwZuh+JtXI8ugK1S1QNKctPi3OjoQ4KQVF4ha6XQrxQ1UQL0T90W49Mi9VPfGW+eYuPc/wcZ1Lwt8OYYUfBQHZtisGYoMIMjzcxpPdLwTnBYL/7/+bA63BTyypQA/33uIGBLJaDHwgCKnoJC7lbNzPvuzt8JuTeUn9r2p55lWR+qdsYrdyHvUhJ5Z6qfub9yEMzM38xtEA8GCPv8QrCI1ik3hTy9/sMvnnDBzeyZzoz0fpbd7kbyELRdwqBiClmp/ahspQdG60Fcd6lsHiw+FcE6FPZNzjlzS629w8oqpWXRqvDXJfYX4KX1iZMddoFO6pQZFY+NhKwYQDpTOcIQrlvKrnKekGiatzcmJrUe9A+uAxxnsyPujlz1DWcW7CiCzXHmMGdE49rONopPdA9J7SSXN/ztV7lU1PAVF7+DGzLcptvnQU68MkTqUsjYhtExCn2Q0mvs2PLFw5TymhZJrxCi/1m5uKJ9WAGSKVAxD3ff8Kb3TH6ZHOJrIPzolB3zZP47NozGNdAP+Olw9MNhef5xbrbOamAcIOXKI8GpreGywexIz+inYB/oeMNx2gh7BmUM/M83WBirzZGH9XDeR9tL2IZ7CTvofcMX80tH/7EQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(82740400003)(8936002)(70206006)(82310400003)(8676002)(1076003)(2616005)(316002)(478600001)(34020700004)(81166007)(5660300002)(7696005)(6666004)(36860700001)(6916009)(36756003)(356005)(16526019)(186003)(2906002)(70586007)(86362001)(336012)(426003)(26005)(47076005)(4326008)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:33:37.6553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9970e4-4773-4472-bd55-08d95ca2b728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

1. change return value to avoid smu driver probe fails when FEATURE_PPT is
not enabled.
2. if FEATURE_PPT is not enabled, set power limit value to 0.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index fd04391364ac..e00ac43515bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
-		return -EINVAL;
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+		if (current_power_limit)
+			*current_power_limit = 0;
+		if (default_power_limit)
+			*default_power_limit = 0;
+		if (max_power_limit)
+			*max_power_limit = 0;
+
+		dev_err(smu->adev->dev,
+			"the PPT feature is not enabled, set power limit to 0");
+
+		return 0;
+	}
 
 	/* Valid power data is available only from primary die.
 	 * For secondary die show the value as 0.
-- 
2.25.1

