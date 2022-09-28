Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD0AC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A330F10E9B9;
	Wed, 28 Sep 2022 19:41:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5366110E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1sb5Fx8pKZRvUJn5dkZhdEiRHek9cEhoYPlDksld57YDVATo2+231pt9/jnrEWsq2Fj9Zhn9VyqD68tLO3vLT2I9ix46qNPKp5A2nDhmv/bJWD90AXj45QEkW2epGfkzuaRzk41nc+JyGanCYkJMpLHp3RNYmn4nGNGLpCl8qoWbQPvZXl9jZ1o1sS58u5rA9p2cUBDFjCyL4olj3kGeq2fibLDTCKQXfISy9kWk2KTR0GEC+2GzEBPk+q9cQeIWZCWFJ2eFU+eUPb5BdRKannpVSIcd/jc5VOIItoK8U997zs24Y9HJvnlF6JTFwhRGYPI+uEvYP6wMH0xtmWAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCiw8xah7imXHKihhwN+ceOqZBdCwh3+/eo0XnjwhVw=;
 b=VSWBNl9nlO+X8bz5el6olgDCzZvlQlTReJQ591dW7L6cq/kwXiu7lxrKX4xkMvLyGpFMDnzgMpO4rxLW0mdQRPSZuTGW6qMsrVBcRc6k9lKp2RvVQSDXyZ8hjY1lBZYk4R8/9FSxbBlbDPZyRRpYOh4JdICyBcZ4LP21xBNEjZERVjKgqOIX0iw9neyXbv0BliTkXlgSDE7tRlFLXhi0FYHCCJKw+XcWI++B8Yjlnqa/9OXW/Vkn/lWTKMKal/VRzJ+QOY9aSYccUIsOkE0e+QqY+jifatdFtFZXKgEVPJHKX3Tet9+lvTQEJMv3GI+SWOD/ZGeaHgUkF2YhHpUzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCiw8xah7imXHKihhwN+ceOqZBdCwh3+/eo0XnjwhVw=;
 b=khgyhs6Vtx8UEgSqag3/cNjo0O5EEFUpjpuBkgCXGlJOJdTFGGJLfiaSNwzADwm1nbOZyBL1/l7K2PVCsAWHcg/67eeZ4cKVKtDOJ6M4KcbDPRABPqk5wG1Pi0iN5jp1/oiv8IAVXv9eUG93BuSlMhTFxiL8/vrLxobAu6F6lRM=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:41:02 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::42) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:02 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:00 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/36] drm/amd/display: Disable GSL when enabling phantom pipe
Date: Wed, 28 Sep 2022 15:40:02 -0400
Message-ID: <20220928194028.144879-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|DM6PR12MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6b70f3-9876-47cd-de1f-08daa189603d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAWca/OmBSudmyPQXQ6HvI7Zy5YfUtnAA3+Wxybn7BO5g/IlZw3RuCLWPJOxJR7udCbGmM0CQ5075lHemv5LDI91SyxuPQeqB+mXAWYEW4xBF+4FcR1+B90Qqijz15wqYAJANOeOPIdPzskFr0wVA1qMnviScytu2tgitXFMTwmC7hV2u3Al1vZi0xeblJ9nT5P4JCpwrCyJtp9tPNs4c32dr6ZO+hgAZ0FNK6gUt44dlinqvzmnCJ9zW5sHmYDMYQSuuL7230/PxjgFwju11m5CJwYN/ELQ66K2cNFsBik/A8cfNC2hyyE7leNvYmFaAHe3HEQjA5p73R6GZODabZ7DFO+no6UWbhOKK0ho0FLUzC9/w41v4RuHwLbzXyTuBZB62aKrcBA+wtjCTTCXhLQ5K0zcEfJuz9nx6OCD7qz7qJU2BXJF17Bz61Ri8A53TqaIkiORTwYYRuj5mJ23coEiE1EdyWeFDMGDIxzL5GktR8PGIcKPtJD7+gMp7wsqwl9RYITxzOvx1X7G89QhtA/+ctxespXVMjOnfpeP/mUWzLfIcOSnBCoGjyYyJmV3cLlC7kHRuvzKsqU8qHwMYR6V9VBOkypMfrF3lCtW86r2P11IsnBCNNs9ZYrePqCbkoDy21z54bFgkU6Go/jF+lFcmroTPDlPxIswUtjf9C+/MUWm2EdTC+LXg/JlOXKp7UemFevNDLfAUTiw3Xp1LAACQ8QJNEyYfp/Vp4Kb/TZmh6r27QGktzBwHlWR3p36hkAYqxCV4Zx8cLoZeWEfKVGE7AZdQ1GBFxdWT6rGw02OXy4kMKaWoy4a3AQ4H0XIk7KNOF+ywvITyWv48iOPqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(40460700003)(478600001)(44832011)(5660300002)(356005)(2616005)(36860700001)(8936002)(86362001)(316002)(336012)(426003)(7696005)(36756003)(8676002)(6916009)(186003)(1076003)(26005)(54906003)(16526019)(82740400003)(81166007)(4326008)(70206006)(41300700001)(70586007)(2906002)(40480700001)(47076005)(83380400001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:02.2980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b70f3-9876-47cd-de1f-08daa189603d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
When enabling phantom pipe on a pipe that was previously
using immediate flip, we have to disable GSL or this will
prevent the update from taking place right away on the phantom
pipe when we enable it in FW

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 2038cbda33f7..830562f4139d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -79,6 +79,8 @@ void hubp32_phantom_hubp_post_enable(struct hubp *hubp)
 	uint32_t reg_val;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	/* For phantom pipe enable, disable GSL */
+	REG_UPDATE(DCSURF_FLIP_CONTROL2, SURFACE_GSL_ENABLE, 0);
 	REG_UPDATE(DCHUBP_CNTL, HUBP_BLANK_EN, 1);
 	reg_val = REG_READ(DCHUBP_CNTL);
 	if (reg_val) {
-- 
2.37.2

