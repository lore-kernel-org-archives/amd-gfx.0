Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A6FC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AF110E293;
	Wed, 30 Nov 2022 06:40:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D0510E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqetwwylxIpD9cF3qzKG+PCV4N5YWlvKt01oxpab0aULg4UfPRzM4zBUd6td1XvN1cQKQGsjibbVmkBYN0E6daDlN0KOfMGCSI96x2gjeUuRDl5fyYxhg4A3eOMHGr4vVauXfRc6Ajl9xDjQTpAQxEZl39+GEULzsM4UdhyVqtsgKnbB/wpBnOQWTemDDxcP1lhUtzXVSIChd7GWiimB4lQ0Jo3EtiATzeTMvjVrnC6W446blqkBI1X9U75mpKQnkxdBH8VT9/aV7HOhnlOatC2XPvErF27CNu4vXxVI+yD5JLVQNi0VQBvDPPRZZP6mFlWEXhLphiYyhUuGKaht1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxPRNzItuhOxPd37HmlGRrotWFme0aPpDlOvr5z42+E=;
 b=k5CZCCU4cbDcv/YxQMBVvUPmIplBZSiSJDNsPuPjz3cL5zYu+HOs88Nom8KQTQX1Glho8XbGlJGaNhdZfAWs3tuiaS++M7hozTp9IM7coFCp/p6O2lqqPn6xtS/mfa6f+PPup5AGBL+SehNddY8I+hMMOvmf1RL9J/iI5wVRHp04Y4wiE0gp5YqfvKr9PIu9lPM6xCTgXrjnDmFGpFmNof+zPwr+DmEbR0H4neeh26w2BIwIfQ5eEmWy8o55xWt9p2OLI4b/h0NCjVuuurt5kVPRrBYaHxCupP8XmuRmsg0Lx3dz5OJFoWLGoBBWZBzbLWG8EKC9i9KRTqjl6ldVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxPRNzItuhOxPd37HmlGRrotWFme0aPpDlOvr5z42+E=;
 b=tN8tIIvYT3+L3er0BBofv5Xhq0aTrP4qYbnEijDkgZCv4G3SXZdKroYTuFETvrGNzLSaWRQt7OT7ZWOW848/L5KpvEoKU4sItuU4QhV4cN3VjlcPHIiwTxOtm5zshvCq6gZdjmZqqUI370pVKS4iTToHGnHG1ZuNBIQs7cmxhMk=
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:53 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::27) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 06:39:52 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:48 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Ensure commit_streams returns the DC
 return code
Date: Wed, 30 Nov 2022 14:36:22 +0800
Message-ID: <20221130063627.2398341-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f4f805-e2f3-40cf-4dde-08dad29daff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpnwpz2VSlHxqgD8TCtzgSgNgMa8/aVZYk0Qa+mWT7asg1B2TXrorL3sA/x19L/DFxm//ST8Htts9ea4tyWU6jZ/L+UZKuZsu2L8w3vIwyLqPgZ3tueJ2ECNc13ue6+JxTHvQpGd+76BOaCnks/Hm2+XA6KuLFR1fIk+h2w2Vp5L4lzHQ+2DlQ57XLrIBikOvOiqzl8ppXEt49dzdd0W818ADnlwhZtxfIMvVUTIKvkXcD/uuJmUKhDqPZgtnMAxYOMQ2nIS3R2+n5XS4gU2jLxFUjqqdZJMnhuliBwibd+UcsFSJJglSdezxgie5sSHq/jnB21PWHHyKayWI7bOwUgygxOV7Wxk7ehRv+RgQ+X9i1jK5qDiu79AlEzv2Zl24/P+I+TQWVHa6fZ5Wg3mE/R04saSZA5pyBs8CbalygM8uaFHQz+ymHGiz4A2fiiXW6wDAkwof2P3E+uSirb4lFo3MzI7GlmQlwlUA3w+wI7FM9Bk8x7NcSBG/zO3VmFp+Yj03I0Xjo4LjpEI4z3gvMh9zOYR+dO2R/l7sfpfbSoBPyzkVIeRyOuLBSBrb6zpLpr8GZpQN3c12NQK5fwFCsXr5hV1UODx13eKHIKf5mc2XOG9nKTkeB77xeAszwy3w3nDbTr4DkOLKkt6r9hLKKgm2aW46xgwzQVYJy92yN1iST25ysnYiDMT4U533qEvD3rz25F22MC2Mk0V4tg8aPRj+kcvPK6RhLSRp3+RctE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(83380400001)(47076005)(7696005)(44832011)(26005)(186003)(426003)(86362001)(16526019)(4326008)(8676002)(2616005)(36756003)(336012)(40460700003)(6666004)(70586007)(40480700001)(70206006)(5660300002)(1076003)(8936002)(316002)(82310400005)(82740400003)(6916009)(54906003)(81166007)(478600001)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:52.9534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f4f805-e2f3-40cf-4dde-08dad29daff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Ensure dc_commit_streams returns the correct return code so any
  failures can be handled properly in DM layer
- If set timings fail and we have to remove MPO planes, do so
  unconditionally but make sure to mark for removal so we report
  the VSYNC and prevent timeout
- Failure to remove MPO plane results in set timings failure due
  to lack of resources

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 486d18290b9f..0cb8d1f934d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1988,7 +1988,7 @@ enum dc_status dc_commit_streams(struct dc *dc,
 
 	DC_LOG_DC("%s Finished.\n", __func__);
 
-	return (res == DC_OK);
+	return res;
 }
 
 /* TODO: When the transition to the new commit sequence is done, remove this
-- 
2.25.1

