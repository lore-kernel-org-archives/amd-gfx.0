Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A227C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 18:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948D110E0BE;
	Mon,  1 May 2023 18:11:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C32710E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 18:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf7x7bWodKk6qoQxQ76fH6auvJIMLwwJqAIkxO/gDjx27aXXfHhLrwNOCzk7E15RE3db/eYr/wB8qxhstphMzTB2WkG76Tn0p2UGRNseon0WnD7rocqHhitaCcs9zC1N4P5QvmRqcSi6U+WBqSOyYdNKfWQexTevdJpU9p9/14m6VTasJv1V+Jp+AZSbR16ys/jAcJwfIGNDRpEVZx3p4vQOCq/ZU0Nv/pNe0I2/6e3fl/X+bDaq3Ezyyv0KRsTJzkZ+HAiZ+1vTJkuOnxwAWtBJ7kIickyZExRjYHfbn3Yzyt428PygjjJHtAKRtN43KZ2NPKXBl6T4bjCaebMYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4pLJLL75D07F411u2px/gyKi02TQxEXzzl63m0Q0Ts=;
 b=mkVD1nHXPDx9ztfZOuyEvcGamig72RCFsOOvqhUx7OtgkJ/0bhqV9ZIE01wg4rDxoKHy5QEzvUkrVTyE8LLPdUFB7r8MokfenH1olh6djLwdOyi73Kla+Yc52qfo4Q6FCS+3oHwonUeQPCaqFV/z6rwK92zgwMPS4QkM8o83Ul6Kdd7buto++bkIeBTmh7mRXd0heK2mDbKrMLkvlvi2zq/hRMn8TTK3PI6nzMjbO4jC8oIBgCDGLiQLlmupZdcZrrq8RCyf5CtvZClD9H+AQQX/BkYvYihu1ybhsXZYjN/S3TG13YGHZ/h9/jr3a+annDs4L7oBWF5LPCk1OayCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4pLJLL75D07F411u2px/gyKi02TQxEXzzl63m0Q0Ts=;
 b=YUIrxMgiBndurGjJU1LEYLio4Pvr9lRXsuL1N7d9Iw/9e1RPxQhxTvJwxT+7jNaNNmx7r18GA9qYGSZ3CmbscfG+swOLNbMDEAr9ox8F9VJvq0+2iTPf4Py/69Mv1eyZy6+uRDmHRmtCPayCdSYX7YoHMBp/NkzV1++zLrd7CSw=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:11:21 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::b2) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Mon, 1 May 2023 18:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Mon, 1 May 2023 18:11:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 1 May
 2023 13:11:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add new ATOM capability option
Date: Mon, 1 May 2023 12:10:13 -0600
Message-ID: <20230501181013.1202531-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: de2ff090-f9bf-4894-926f-08db4a6f775a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HE4ksF4ZhcLqF7/70QFqGbGpaxri7VBKJuJ/u88+3GKWvLlGaCSAzSMnqXmYFUwlzs1VxuZuoZ/K/uIVDUA8PFoP1jGkDQlxwi5pcjvBbxPZzmhjip3jNTJHTLAgTmOnlyum6I77frMSjq9au8K38Se/XVGPhhz9O3b5LNUds1pJBmbuQfLztvgcxxL7vf8rWxU0UCVQOe0DWtUbtSCXaozxWYizcqbFFGfp/CPm9ymI+LLGK30iT+OxKT9prhIvWKC0ypy8WgLa6UWcyd0eQQOjrEEZBx6bXvhGaGsaoNFpUhbz9UquoAPF0MweamdZprb8qnskP8JTcWMnir/5Zd8gAQzEjeDuZ7pzI03L1aQVmG1L2bctZg/KKEnY8O+4eT2jC0PIcvvxRIqpWobZtJHmE80oOTh0skZzZx7S23jcy416CadyDeYR08JS84XV4ErTy4rDNMA5JrTwAhf11xE1WxlmC/JCZwLWiNuXHKZ+o3EgXzAJrXPvOgyPL9puRwhpADbB7VCy+03NVzVyVyaf493Uhmh+zQkSTTceIUi0MFBE5Xxo49r43G9779o29OxTCTq40eFSPdGaCwnow8i7NrT2FqC1GcyKAxV4AuFzT5xBvHKqkSoq4RqbYOnYfnSrRzuFezCG1nmcoCurej7bWEIbVlDICC+ust6KrQfp3k3BD5vSPT6CP64XcR7F7jk6MygUsvg6GtoWjj3oFIv8ye1jwp3G1w/zy48KBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(356005)(8936002)(8676002)(41300700001)(5660300002)(47076005)(86362001)(81166007)(82740400003)(40460700003)(1076003)(26005)(70206006)(6916009)(70586007)(426003)(4326008)(6666004)(2616005)(478600001)(40480700001)(36860700001)(54906003)(336012)(36756003)(316002)(2906002)(16526019)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:11:20.6838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2ff090-f9bf-4894-926f-08db4a6f775a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aurabindo
 Pillai <Aurabindo.Pillai@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 George Shen <George.Shen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ATOM_CONNECTOR_CAP_NOT_SUPPORT_DP_PLUS_PLUS in enum
atom_connector_caps_def to better identify if passive DP to HDMI dongle
is supported.

Cc: George Shen <George.Shen@amd.com>
Cc: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index bbe1337a8cee..c77b46898c08 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -845,6 +845,7 @@ enum atom_connector_caps_def
 {
   ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY         = 0x01,        //a cap bit to indicate that this non-embedded display connector is an internal display
   ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL      = 0x02,        //a cap bit to indicate that this internal display requires BL control from GPU, refers to lcd_info for BL PWM freq 
+  ATOM_CONNECTOR_CAP_NOT_SUPPORT_DP_PLUS_PLUS = 0x8,        // a cap bit to indicate that redriver on this connector doesn't support DP++ Dual Mode (i.e. passive DP to HDMI dongles)
 };
 
 struct atom_disp_connector_caps_record
-- 
2.39.2

