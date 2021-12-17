Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FBC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC0610E68B;
	Fri, 17 Dec 2021 21:24:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5D310E651
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEYp1X+KjQGANbHVMb/AUwHnvYtg97axv56V3/5R9LH9MoVCXQzexNKZKm1nR5gSbppgpFO2+H8XUkydCUl8X0yTQ0mDLtGxn6+ao320x5fPWiZkzsrVc5yq7s5C+AVxOnJHX5xu5ArxHKQm4vRkVrh8ICacON4nL5dz0F0PerRwvvscAY0R5U3dUBXSvZzrrgG+LSG9z6j3HfKCjhfhpkTmdX1odPGE2v4eJhAMptRVyELl82HBWgWpIC4MqHAx2oWxeu9Cw1Gp3+vf7N9HY+hOUIAhp5d7dYd8QzWT3lMk9mjluVuNUUpMogZviRdTwcbDHA6HSR6MBSoMCmQrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7WDt/o5M7rqr6u6TBNWH47PVMMuwXpWmXj+uRdE6M0=;
 b=nkm4dioDTSre75HHP4IKlr//nDxToYixbui1+8ye4ySmJm243Yy48bjhZznk/9PhzkY+mTKKLgCwySUJp2/Rh1/4XWvYV4+1Hht/iXmTRK1I8Rsa1q15JG2/LRgz5z0rKRdu32BSIfhK97GXyPRK5rpwcutgjAPQWbhDcDnsIYwxj/ppwluEC209mRmUmV4cF8J1ziKnNXPPk5a3GrexVSJcwEC9CgJZSahhofe3anZ893eMpRNNXnNDlBo9Zsk2HpxCV3iRSa7jwM4evRYsJGib45pk+lehnKehy+pKcbaoZi8AlKtXOh3FzFLDInR2Rbj5oBprIZ34naRwZI51jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7WDt/o5M7rqr6u6TBNWH47PVMMuwXpWmXj+uRdE6M0=;
 b=34E8sgATkqYi0BNsuT8MTZfE57sg0J3qDMadWmthyxGPG72rbh85JzThIrYaSflDeWkkwmbEAyiaeDcEAYRvdp3S5BHYOMbfwEuc7tHs3Y+9T5Ngg+afEXmwrSq4RqRHaOvQnzP9iiWvocckPt+EYHa9Fs0zs0xzTOAMblI+Ggw=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 17 Dec
 2021 21:24:29 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::7b) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:28 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:26 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: Block z-states when stutter period
 exceeds criteria
Date: Fri, 17 Dec 2021 16:23:52 -0500
Message-ID: <20211217212407.3583190-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6bb293-8d44-487a-b7ab-08d9c1a39bf8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5339:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5339F1DE1A32DE802EF030B898789@BN9PR12MB5339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpYEu7JkhwU7zNxPdCIDx4E5pKDibSXRn6yi8xuT1a4O/hkJkdxquS0m5JNQxiK1NYsx9m/sb71keJVtiBm7TB4N8EV94Y7frt1u6iBRdLlpe/FUofO6xt1TdFB/CeRtsGsknVuWZjaYO1HUgVlMb1Y7zDwvftzVmvNNcWE77LGcPYpyNarDzpSih4cD1l/peyZH9u0w5B8vZcn53TuGWVFbOShPrvRDibUlAeFcEzSnXw93UQ3GqN9I3n7EC9Yv/tD9DW6w3Q7zo2LFYu8EVlNp2upfdBQTDIyn69MRPHFtlPJ7qZ+5OzL4q6YZqST42dvOen3jyvvVfsTlpw3dcDqUqBCkLhnWMZhqcJbl6dvlq7OwVmhSRKIvVnRAKfc9B49Xc1N18Q1aipVwzmabLPwLJ70/ND/v4reZUXMllNDAvmeXlwtIyIU7ba5WEaF7acwQTgio0rEQoYlV1m0B7j6tDlin8Pe1/9nrBP6ouILOqN253xtydBegSiPzsGsHu2zu8XoHpEPPhgSCmTRAS8kRPzqA8m88Ytw9QQoKTkN73zUknEIFp6Y38xgJrXoLX6hFzIhMndpUm6ENWLedGc6AsNZleP/T4XE3PGeAyPsV5Dkpj2Z37jBV2OVc2mLDR+ROkDXgmEWXciEWT1CnXQuhfgqtH09wglRzTqgeigD5JzAqQ6YYBVFizWv9rojuv9bCbJtBnpOj664G0fCUogj0vVXdmPhb+gtj2aFzyriMBmLRzoHiMWuOhx0H8+KUKJR9UIquYJ8E7uSD8JStWaLKOa4l4eP3DCUoHy6t9dw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(82310400004)(1076003)(8936002)(54906003)(70206006)(186003)(40460700001)(16526019)(86362001)(426003)(47076005)(336012)(316002)(36860700001)(6916009)(2616005)(26005)(2906002)(36756003)(8676002)(6666004)(4326008)(508600001)(5660300002)(83380400001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:28.8515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6bb293-8d44-487a-b7ab-08d9c1a39bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Stutter period won't be less than 5000.0, but if PSR is enabled then we
can potentially enter Z9 when MPO is enabled.

SMU will try to enter Z9 too early in these cases (before PSR is
enabled) and we'll see underflow.

[How]
Block z-states (z9, z10) until we can add a new interface to SMU to
signal when we can support z10 but not z9.

We can revert this once the interface change is in.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 40b122a708ef..2a72517e2b28 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3093,8 +3093,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 
-		if ((link->link_index == 0 && link->psr_settings.psr_feature_enabled)
-				|| context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
+		if (link->link_index == 0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
-- 
2.25.1

