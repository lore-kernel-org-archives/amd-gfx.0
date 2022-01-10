Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA901C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 07:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375DC11BC1D;
	Mon, 10 Jan 2022 07:47:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBE311BC9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 07:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPQGdQYPltH4vnXuUZoUa+rl65Wpncm3izCaRdCbd4b8tLJQNoVv/fBl8BmcXGtDJGmwH44NO5HZYi2/bTroxCdIXj/X3bR26IwAteNW6lPt2BrqVJaIFyO+O6Fg1kKT9nNDT8etKacMib3WMH5TXCrM4SxI8gQ0Bp+CLNlPX3UooQoXIsuhAwDAIr1r53/cq/se+gNShnxqwgTdf01JMlSQ5iu5ZIFiCIoQ6Ci7dCm4Qbdavzc0nckvln32wyEK3gqQIFZ9mF2AnBxOljgd2r7b/Y0CTclKZXrJU3ZIX4mK/MgfFA9YqnYn/vsLJquU3NF0FU4xqv3zSi9zHV2l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uWZ5m47m7jXbGcJIqJesrhenIJCbKwtkzqXDIzvbKI=;
 b=SEljppe+HavszoZ1MLSaRSUc7HQdocikxphHXu3Uzmcq/3NFsM9IBlRi5zBOXi19aCl7yCBOAgBMn8pXGp47qc8bCfY5Ubs5fznB04sNuXyh/HZS9SQt157TzMGJQ5jKE05iOiuIU8Dp4z0wQqS5pSafBp3Y/0DEqQzNh95KQrePyLFGJmXxedyW3scHVAfBq4ixSeqE8je+xvdjeHcxQOJsNvMC2aBGKvzjLBMr4Acg6E8gdv5guH/fkyUiLdFAtfNO3fEeKb/XmbT0q2hgNqZVt3NOqmHi6hdBUOw4A58OAw7TpPGr8SEg6lK3eqLFH38oAFlfySBL0iN8hShmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uWZ5m47m7jXbGcJIqJesrhenIJCbKwtkzqXDIzvbKI=;
 b=Ng7dih/EBN7m6U1UJp32bprQbuqLaOu1gZ1UE5pm7wdTfV6pTPyVnnzj4Z1VvfVo2t2Kc5ML+hCrkDKqvvatgmsPcpgLYIPLg6XK/o4mVlfYZUvL1aavLNLZM0GQxRCoI2FDqbR/QOCxawTW9Jm9eREGMeG0jbqJ1OlSs28gFDY=
Received: from BN7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:20::14)
 by BN6PR12MB1907.namprd12.prod.outlook.com (2603:10b6:404:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 07:47:14 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::12) by BN7PR02CA0001.outlook.office365.com
 (2603:10b6:408:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Mon, 10 Jan 2022 07:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 07:47:14 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 01:47:12 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: ingore failure of GmiPwrDnControl
Date: Mon, 10 Jan 2022 15:47:00 +0800
Message-ID: <20220110074700.27602-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 755d4276-3d3f-4f31-46ce-08d9d40d6b0e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1907:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1907A9017B7E087C22BB197BB0509@BN6PR12MB1907.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY8zUs5d1hjQRHYcZ6pxQzt8MDsarXCD53+0bTW+1HG0JmMCGt/+pRL9JUALRDKV09kn+tIe+JBmohHhjm6sRqfIpUYgNfxkJH+BDMrFQsKizJ+QbqDiTcgYfhVDiKgWedPAgY3m6VdWoLLb9WjEMsalWqiY/5eJhPBygbQw/VlMJscxnXrkEBO/L+23U7CSYs9CY3EkUCD1+NXJxBlSDv66jfCY8DnomzXht/lNWeLfSwF68J4dFXJmnzyk7KN/hPIqgtqkU5SzAE7GfZbOBpybNvYRyyeSNjJwLhMgKrFcaCGb1ZwBPZRwmbOD4wY4EURPexIMMN8M5ji71JyrKmYNTSbQNk2S+0XgG/mAbGViWllU0Ehdf90PsAP5NQqiLiiKWJ/G4N3gF+NAlGmCDaSczhZtyAlVfAlw8bOtwCz2icofvvWqyO336vXdkrG9N8XVB2jPwUYmRTpMvfBhWaxXs0MkbwigKjjUxjao6leuigf9BH/xgnBEu8VV8NFx7PVwNLZJYV/ue9sUn4wWM8KAZkQGLAi6dJ0MOKmD8e9X0KKSpi+QVTdwG+APleCmFU275h2SIbbMst/SYZV4Zh/ifnUOkhnIj6g6jAdkt+iTbKZNHfYUTvVrOXt+ZyngC8q+XiDSPvPUdtOFniFK8v7bwY4rgTRAkpgDOsMxXitRvya/uCYMi+97met3vzM9xdpMpTKrkUOR0FfoX0cEWGBs9+2ow+oNqD6L+qwlIrGOrk2Wku/pNyPTOXCF4Ys4FCI8aZJSbGGqINfZsxSmzrjq6Lz4F3CeEJ0p6AKXkyKryD6reD8xrFMwNOOZzlZW1s6m1seVRN5hnGhtiRVdlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(36840700001)(46966006)(40470700002)(426003)(336012)(2616005)(36860700001)(2906002)(186003)(36756003)(508600001)(16526019)(26005)(5660300002)(7696005)(4326008)(86362001)(70206006)(70586007)(316002)(40460700001)(47076005)(6636002)(82310400004)(1076003)(8676002)(6666004)(110136005)(8936002)(83380400001)(356005)(81166007)(156123004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:47:14.4928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755d4276-3d3f-4f31-46ce-08d9d40d6b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1907
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW only returns 0 on master die and sends NACK back on other dies for
the message.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 261892977654..121b0ab5823f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1625,10 +1625,18 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 
 static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_GmiPwrDnControl,
-					       en ? 0 : 1,
-					       NULL);
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					   SMU_MSG_GmiPwrDnControl,
+					   en ? 0 : 1,
+					   NULL);
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, ingore CMD failure for the message */
+	if (ret == -EIO)
+		ret = 0;
+
+	return ret;
 }
 
 static const struct throttling_logging_label {
-- 
2.17.1

