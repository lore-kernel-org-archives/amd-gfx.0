Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB13ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 13:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF32410E0D9;
	Tue, 30 Aug 2022 13:33:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C480910E0D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 13:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ40ufki3+nU/albiz7MUFloiHl9mujEanxah2339j47w0GLXjNgejKDRRtgmkLeSPRcTqph3oCFrF9yTXFqXgSJ6leb9Z8sWXK8EkI8+Hww5Wmf3xglpudXXPRuRfpj26/b0jXeAs4VZHPGcHtBgsyjJMYK34Q86nh2PVxMtVrt5eM0SDMSNBgIh+idTkOJxTCCwGkCZPbre7f7yEytO4X6qCfBIJYhP6Qsb1Lpaog9QzZSZmoKrku7GWDfgIGoylu4HZomusYU706eyr4RaBmflL5tB/aXO4K3awGzbL/0GdJWLtfe06gs1VpgG1gtEvlC5FmLpblxquxWzuvbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d+Gka+JpRMa1eybh1Ofcs4wWTtsmwAZQ1+4QXibRDY=;
 b=QYlcn2959AkhHvcNpn9rC/j3yCpbOSChV+1H+CWRIqIqXnAfxFtHgyX8K2Muqfl2abDXQBTEcs2Y4XdHnJII8gKlcZEHIdHPWVyIJoG3AlOlzs3C8TS1dtRpEN5ytv+g3sdMsShkLbbk7KYPqn05P+y/xYWOwtVzjq+kcBsdNuRiVpyhSDcwal52JLYblwRvm1bQmy3LMVK9yTx57PoZrTmXvmiSYUcqRxcMwqrBQRBSwbm2J0klFQZLHVAO5FOOgStfgdJYXB2OHjFZX+fo2/q20cSIULDFC/1AQa2xzVS71pSepOo0VhApUMGKfl3Tydba72/xBax8wD9o2XK+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d+Gka+JpRMa1eybh1Ofcs4wWTtsmwAZQ1+4QXibRDY=;
 b=Zk5PSWBSCxdGQFuz02uKRqyTDCCaiQqlW/OB584TRBUUMDg8nEwzQheRJKvTaUziwfgJPiwtBULcqZ+zY6NoobH82kcPs/Vm3Sletxdkado3lOUa2C4smhoC1xh3AjdRBc3G67tXUZR61cK22HDJMWBgJnacfaGtNgcaGDQD3TM=
Received: from BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 13:32:57 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::e6) by BLAP220CA0015.outlook.office365.com
 (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 13:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Tue, 30 Aug 2022 13:32:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 08:32:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Fix indentation in
 commit_planes_for_stream()
Date: Tue, 30 Aug 2022 09:32:16 -0400
Message-ID: <20220830133217.1770055-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482f482c-25a8-44e8-1168-08da8a8c2659
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7weYM2tFB/XhTDMcJy9X6WuxuWAuEelE1Z/mKsuyuu2+ep1ZsX0XNxcElbfiFVEgh/jUXQFjByfYTuaAVG1Be3Jr3TNEHIExPLt8CL4WqjoBS0LRZI3ylLeefTbors+XJzeEiZLUYWP3l0u7m+uDKCoT5hs2zcoohDfARRkmCdtT5cPF7bCu8GU4rn3VVfyhEa510ZgP37CKQxSAbp+c9m+JVJ+mldyHqqgnAHZCpSStfCSApNmLsUwLevsfP8ocjID/z4wczvBP+2l1acmqZ1cnkrkA+52tE915bGx5XMm/VllyFXl71L05W5Sl23An5RV/lEEEs0jij2A65wTTManPbap4QCKqc3NziQt9ZO9nzF42gtEcJTdkt7hU61G4PocAKO7g+WxTjLzkJurnTKBJf/xA68AYSmcMnSzF6jKd0vMO5LHJ0LavugEhnAclTTiwdw7YaNfazwNgOKpWImVzUJmiiAfRZCDbH3OxEQtjJnaHXtKPKfeXYeX9HSdrC0OkcBM9ScYVHkCwHL9NB5d883sfPDN9C2nyB8++LDJcmwr1hWgEuP/EcmvGbLHveF3nknb85Tpa8WUkqLjMmpU5XYlF4Yn6GTG8SGp6Qe2CtEGEZpMQx1sKEKHTVbQNo1TpaUcNQGqgMf0Jc/SOMaVjnoA7kpvSEVd9q5Pr0XrkmoQtZDbiSpQNhyWXIJTHEiJIN8OdQCrnHMHWFptYsGmenaUIzrWhN5i2oeu0Pi5dx927mAYQ5I20srF26dJBbaN6bDk4ZFAZv9Anab4TbIpanqU2afE3pMCLkgr/tk13aRkVULqhbzxVH/H0GuDY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(54906003)(6916009)(5660300002)(8936002)(4326008)(8676002)(2616005)(426003)(36860700001)(47076005)(70586007)(1076003)(36756003)(316002)(2906002)(7696005)(41300700001)(6666004)(70206006)(478600001)(86362001)(82310400005)(26005)(356005)(40480700001)(81166007)(336012)(82740400003)(83380400001)(186003)(40460700003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 13:32:56.8991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482f482c-25a8-44e8-1168-08da8a8c2659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes a build failure.

Fixes: e990bd60716d ("drm/amd/display: Only commit SubVP state after pipe programming")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b49237390cce..1a4ea9639049 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3507,9 +3507,9 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
-		if (update_type != UPDATE_TYPE_FAST)
-			if (dc->hwss.commit_subvp_config)
-				dc->hwss.commit_subvp_config(dc, context);
+	if (update_type != UPDATE_TYPE_FAST)
+		if (dc->hwss.commit_subvp_config)
+			dc->hwss.commit_subvp_config(dc, context);
 
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 	 * move the SubVP lock to after the phantom pipes have been setup
-- 
2.37.1

