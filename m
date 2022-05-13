Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50188C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D13010E5EE;
	Fri, 13 May 2022 21:17:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4FD10E5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQGNVq3huTCi1JxY1J3wL8X0vFVaJf2clYOp2ZAEx8LqNX11IyPTBK/6G3r0PYX5c0i3wQNDhUog2ZeKQjDJQioMGLbwl+blYZg8z6/jZxOYFrERq8TXIx7WT/xNHTXNmxTFimaXfEpn0GJWJ82X1dzI4Z/TgGXL/i9s7mF/Qq/AKZGiVhXzR/KQVuBReAxoZ0CIckpn2MvZLShLNeyb60lIfbGO4MEmZ62HOBre6JgcMknPG6h0mT875O7YEj0c4enp5d1r3MzWasF+/LvUz+vDFUSiw2qN5hBEIbcAV0SugwnAGIbSdzZMD/AjOEyHfOBM1CshdCgcIPTpwdVtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjV6X2MhY9iKjCmISt90Pk2eNO/FwdpALIgBsg2l/nY=;
 b=j0UIHFwfCj4JrBDXjOMWYCCm5Ft56XzJXx+1tCSE/Yyxk8p5mGyXmv85/aAZJsqsg0olsf/hSs0bO6bxE2b6Tq7QOmWywzwyIwIPdCL0SMsTHRu/4FXgZCErb/g0rtUdjhJVhLAYg/39La26v+9t852Yzz3ZPK9krG+RQhVt+cYB7eQH6XQYjq+5tL0StXxp+qttf3vpyt8tuumhqcIbFcJ8BHjdPmmCXgum1/Oh3A5YvhgSNpN2TJD5lHAheZe4hhVtQjrgTRnqLRmPCBoDaY6QFnn6f43NtR4cPpYdeaEI7CuKMgVima2ynWwL/b2Ve9dkNHe2iBbctg7RqkxBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjV6X2MhY9iKjCmISt90Pk2eNO/FwdpALIgBsg2l/nY=;
 b=Wv6Hoh5HSCE5qiDkjbKcqeR4n4Qc67XMF5tPJT1ybj6dlDU2Z8VtLwnVLT4j9Vt/pjJmTxsSiU3FgZ6YzrWyYzxyiCHOjRM1jONsFVOVYZW++SpTVt16EIrgb02EfNB81AeDBfanJTWDdKm17g7dk/sl/ZPe5toCmelM6NbqtYw=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 13 May
 2022 21:17:32 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::21) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 21:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:29 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/11] drm/amd/display: 3.2.186
Date: Fri, 13 May 2022 17:16:51 -0400
Message-ID: <20220513211651.1312846-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71b64b55-d5e5-41ca-5f79-08da3525fe06
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB467816FCD5ED061A819BA39CFBCA9@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlrvjVdJ8R0X5wbVW64ZkdEbnZgS/z/JcC/L1hGWAmS1QMBn0XG3+P98iYyg8eqtVIo63BPoO1LY86+MxHcYvFeQJN3phrpmEiozc7YHbJfYzVSGKrUU5bJdWokJvpsaCT+j/hS0rVBFLTmqp1Y+65Nnm5LlBGUt6y6nau7NZZpd5ZBZIf1NNEAHeJ0gKBTz/8aQ+0/06ZYAghCXbOzEALvf8KLIim5ig2TpOx/Ic1aHpfAp+AnwHjn07skxGqW0H4rbsmT5DaY3OFs8iHgM/oIFBAsxaiXFAIq9qJCRUp1+z1k9rfQnEixwDB1/ODWN2Ip+mwuoh4JxoIqSHSc/p71ajKtXTkauSL0KNDpkwC+RY5usysm0FjtLJ01cSSS/wcLhla0MduP5aw52Sypo3j2vKeVcksI/yQBZEXdF+gtEXlRO1KbP/w+jWEa0C199ogFdZYqViO2rPY4031QrNxGDeSMNJLw39RkfWPkj3LHPIrDTRTfbAbd9aN5wnZLXORu4lP5NUbJwRDeDjvanKcp+dw58zg6OksyoichRrvn5r29rTByO3Ap/ssA9ASPK6PNNL4oQ9uFW2ljneyPlWYmSLnSBC9Z3/Ip1/B5dHNxOo15L+JRrGA6AUG6/ea2lQzL9maVXuc00hNXUhrXbNhU2rIRKm4w9QEtjiPdeDY+rO4c7sF1WJjQ/ZqcsbfClUybBnBm1cwozsU2jsH4txA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(47076005)(508600001)(83380400001)(6666004)(1076003)(6916009)(316002)(54906003)(186003)(16526019)(82310400005)(8676002)(70586007)(70206006)(4326008)(336012)(86362001)(426003)(2906002)(2616005)(36756003)(356005)(5660300002)(36860700001)(44832011)(8936002)(40460700003)(81166007)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:31.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b64b55-d5e5-41ca-5f79-08da3525fe06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Improvements in link training fallback
- Adding individual edp hotplug support
- Fixes in DPIA HPD status, display clock change hang, etc.
- FPU isolation work for DCN30

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7cfc04a8ef15..a31ea3644ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.185"
+#define DC_VER "3.2.186"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

