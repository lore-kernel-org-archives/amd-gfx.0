Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359CFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7883D10F4F0;
	Tue,  3 May 2022 20:37:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F7210F51A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhIqXXvqeAB7U4wCSRsoxO0bllnwaksBCvAxD6xsCnalV9ifrUb1jSE36nBQkoe7/oMQhus/LuvD5DPPSM7+k3QpFCsCgi4XhW/8h+6ofK9Gj2iwlT8Hd/1Jxa70Oa7SxrvtbTv/u7OJDgyMKYXHJPG+2M5uL960twxOpofr9zxpgLKk0YT+0bm2qpX2u8nvlmO6QCetpG1n6jwykH48zKpx9dNr7SXKGcIfoRE5/tRNXrK/abOvNJGxLo1h5QGqOe4ytwlDmwh/lUY0ITA3d9h4zRrIR2QNkqtTG4UvZMLqoeCAP3xRlELUFoGa8cGkBkUIvafVVrsagflzhPvuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icOWvBHrxLxhDSe8h09PSxuGxg30fkcsCOsBhuPursA=;
 b=QurkXI5DUCg5PZdKmxPE8acW0p0TQnp3Qx1X/9Epzeu27SIrcftiO8ZHJ2Yc49haR2Mha7Cz0gdQxqbV5xMkswyMmVFP97MI9jGxjZQGxmlr1/rku35lbTaLITHi33P/Ef0P5ELM0+7mvw9hTkGwlEWD40zWDUs9dJb9HkNrfgtv84ce56Eigu8dLmi8fjblits/ov7JZT+66RQs+nnEM0zrCBprK3uf7i7OTeV6Es5Flb/rA3OP4deAMhCaIrc9gaKmebIazm45T/AtTulGvIcXuFTRYdPftoLaJg8VOLoW+xk4G8B8ISHekR4MycAHyBxBC6Pnv3FLkIGWYXliUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icOWvBHrxLxhDSe8h09PSxuGxg30fkcsCOsBhuPursA=;
 b=B+0ea/eQgzHBn6R2ZBvJGorcQvAY+zGHdqjFvsSVDfiLo+Xpa3cuPMjP44fUC180oB7kk2ShDijBNqS33dGAUaZJvBXgpIWfUhubP7w8VJlw5iNFM0jtZPF9QOI+KoyxW8qqoDAAfFaBMs4iCKTlGnb56/uhXemghIHXkob8p74=
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Tue, 3 May
 2022 20:37:44 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::e7) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/26] drm/amd/pm: change the soft pptable id for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:15 -0400
Message-ID: <20220503203716.1230313-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f5e023d-c7d3-43db-fc26-08da2d44c6fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6280047DCCC9BC56BFDBBFC2F7C09@DM4PR12MB6280.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgoGC3ivjvPgG1Ecp6TgDWzHORv7FvZhgY6JXwEmI60BUnyqH0U7WkRNqTE2P00xID4nKwfun96btTSqXpcKwlAxWwabqA1QF9Na795L9/V7//r/sHhgA+zc2H8Wl59Bo2PMwxuv0dhZfCbiyo0zij7yf+Bri6wbYblSN5uDDFBJwBajyaA2mCny5/yEkR5Gel9lt3tb1P/NRddBQliubgiansr7ZQhhZpN4lB4gnape9xOH/TmwUBHHdRjG626VFZCL5JuDCKEYhd44wsy39laQ8Bz+o/FSlb5QLxlQvMlvmRLnLUQb4d5ioIlGlMUIuM2ORz1zUc4Eit0pFtQSKwi0VV9wAYVOFH6e0vm1bmArLggZroQhlooi4FQSTAh4Z5hooAMVeWu72jePzlGN33G5siJy1xa+LIIxLSC25Ey1+YwfhBXFwprcaZYT17mTYUOTcUKtEZtG44XBYXM54aJTpL+al4myOju3/xpkx1hHvTz2LT6UeUDwP02+NmJ2+buRIl0bmh4MlJKQlhfVn77otf4UdcOAkWKBMGJJ78v2YDT8qxoYcqu0a3pCn2IeUz1JTuJoO2Oyl1+UuOT2ta+Cn9JtiRNKoEFxmQtFjqo1/8Ss+ArmdOrITEJfm3vM9KtVQvbc5oNUq0Pevt58ZkOJ4aTX6eFrVMLiE7ye/0QP7Ejf8gFaHuCI2BLUSYjw3xGFelt3K3+2fme74mUsFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(426003)(47076005)(82310400005)(336012)(83380400001)(2616005)(186003)(1076003)(36756003)(2906002)(36860700001)(54906003)(8936002)(5660300002)(316002)(40460700003)(81166007)(26005)(6666004)(4326008)(7696005)(356005)(8676002)(508600001)(86362001)(70586007)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:44.3809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e023d-c7d3-43db-fc26-08da2d44c6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

change the soft pptable id for smu_v13_0_7 according to pptable updatde

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 65ff98a18699..2c57bc573ee8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -210,6 +210,13 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7) &&
+			pptable_id == 3667)
+			pptable_id = 36671;
+
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7) &&
+			pptable_id == 3688)
+			pptable_id = 36881;
 		/*
 		 * Temporary solution for SMU V13.0.0:
 		 *   - use 99991 signed pptable when SCPM enabled
@@ -445,9 +452,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 		 */
 		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0))
 			pptable_id = 9999;
-
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7))
-			pptable_id = 8888;
 	}
 
 	/* force using vbios pptable in sriov mode */
-- 
2.35.1

