Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE2CC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D99D10F314;
	Tue, 12 Mar 2024 09:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JiGpHQoG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACD410F314
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmlFeFG0KTtnCiENTSqPo2k1tU6m9OD1UgQAj4CbxG5vUskbL0qGMyeXCTI6wIyG07/mqPHI1D8pX2gd0QhdOIUbgT5y+mLH39IEd8c0u34sWfpGYlMg+402CcJnehfoI1EVqX1RwMTPA8ncJaO4r5pUY48lD+uEjYVI7RyVB9rtGDqr7VjIJgwUmCGRRCXP864vf4mcldKUe4dc7EBk9yxPN2xVycDfLMel3VzuyYmJtoHBuqa44VmdWrWbA/VysvNurFuPrgEV8HHK/5ZS2EBsqVpTBWYkmShpiyzXcDCWe14JEC64ahXoDKrDtBC4NJpyyMZvAcDQ9fjtBBUEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQpzIDrj5DF7hzLNBIuh6iSkFZPFZfYhqZ8+KSs5rlY=;
 b=mwNBim3qOql2UIidGvliixfCykpzBQYQk8ObNsWVxndASwPtiGKO2r3oSTwGBiv4OTiqnQb10Pc3nwiqsXuSJVF7rqEt7EKL1MBEBypYuvWDVfLWc6YCttVRVfRwGCnY8hWbT/d7Qo7yUZ+/KArFZ/AnI/QzzgzFWDtJLhb+wUmfKll/yW8QjDZ+9yBN6msGxwuT0iFazrA5/hguWWVsxqiKLjg7XYd+fZS9IO4j7qDvpPG12dSag/0G10OXreWi6lO3958JNheq4EzXIjeRFF0PCrR2VEkOn01koCufO/5t/ijRy6qNwODFFzQq86EJpq8BX+Kxm/8yM1l++1VWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQpzIDrj5DF7hzLNBIuh6iSkFZPFZfYhqZ8+KSs5rlY=;
 b=JiGpHQoGYwj0Yn1mq06dZGh2YEFbRlRVG7xU70EsSTtEIbMVSmT/ZkyUBlLE98oGmFKo9K+5q8E3dNUCIwELDqAM+4z8Ee/QC5KY+GaTLkhIjTMF9PcG9eDYcMrBaHWsJzV1iyqfAihZOuXbq71O1Tq0zsSLsAuWZn6sAnsTn2Y=
Received: from CH2PR18CA0058.namprd18.prod.outlook.com (2603:10b6:610:55::38)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:22:37 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::bc) by CH2PR18CA0058.outlook.office365.com
 (2603:10b6:610:55::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:35 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Gabe Teeger <gabe.teeger@amd.com>
Subject: [PATCH 16/43] drm/amd/display: Add debug option for idle reg checks
Date: Tue, 12 Mar 2024 17:20:09 +0800
Message-ID: <20240312092036.3283319-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4449eb-51f7-4ee5-2af9-08dc4275f4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KU2NPETLVY8f1ih9PX5v7p2TRCMImIoz65qSG3MvVI4dJOHIHkSj8xw1fQxmb7c9QwMRiaGcMa3MVmwGvOtCfa+i2uqfo9TvTu4XtTnoN+8Zb7QvMar91gsDBVJ1NQsJQ1xcmg53lhWHZLeK90TZrrlh7JLrRANUE5q8STLCiBUWp7UJJFBML21e1VlnxvKQyKVHYteJEEeQJ5UB2Dx4JMVSEKcDtxw8CmotcVJuCTQhs5/4ItkmBaefvScT5mLOZZd+vajIl/DTonkZaifI61Je7z3mGvclcp+Dah1ByH0jtk51m8J42F9PEP96z3/ePrCGxE2ZR9j8mHg7PsMMjqZCbAAS1QDLqbRqiq7IdtmCL5jENzH6NqnVPktDandr5BxU0sUuQKCQAmR21R1hWQkcX+Rdm3E8tY+xyAPhNklotj+mr6PnBhADIa2sNDPkHDv1fDUvS5NTztZzEm2QQlTB49+Z8G+ytByQ3CgnyF0pqJw3/1b1jVfoP5Xps50I6bR1fTq2ciK5VGQXTRctV8EGevBdGDcMXFl1PVB7IAX2O16YesHUNmZbul0hwpZXg7ati0IG46NZF6aIInb6xzcCWgiogpTJSIgNB4JgtF0yVKg+a8TkUBF7xI9rFGSat7eqffux4nhQQGMbfPvcHCa1VI8EkmT1sEI2ovMtnte7pExZwPhwQbYix8cDOTT4Jta0+qw3TjeH9Yi8ZmiSpwl7u/DvyxEyPDuofo8ReRbFt+2BZiEvX/gVNJOwBAu4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:36.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4449eb-51f7-4ee5-2af9-08dc4275f4e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Leave disabled by default due to sequencing issues around power states
where these flags aren't properly reset.

[How]
Allow re-enabling from DC debug option.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e17ddda8ec38..8abd19e7f826 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -991,6 +991,7 @@ struct dc_debug_options {
 	bool disable_dmub_reallow_idle;
 	bool disable_timeout;
 	bool disable_extblankadj;
+	bool enable_idle_reg_checks;
 	unsigned int static_screen_wait_frames;
 	bool force_chroma_subsampling_1tap;
 };
-- 
2.37.3

