Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6068AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09ED8AA4A8;
	Fri,  3 Dec 2021 22:59:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870A5AA4A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXnjsKS6DjBYC1nq8LEQuUAeb/9KXeoRs2VUX26J4E1lh6qS6aytmEGp5b3stsG8lREDSLsjKSmFw4ow4aYpeghzashTkae/G4l4t4GB1l0pWqXWWLE1ZWxt/HR7fyb0ovVA6mkInN6KEkiG08lFDH/3Ke3j3NwLtm92fA8x2I5gmF56BMZ9lEXIvKUUju6T9ikTJ1Wf2FZH3ROmfDmOyT4VptXYLrPCxkYFJCq4feuyNHCCIGIGtx/LpJPskXkiORFwESCYbhTljyrs3UYNXukZXPpqVtulsHjHNXWodKciqbVn0pzKCoKj1UoqKp/9o3+jKJguUVplV0fKtrAD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSxHlwHD9wI1xPcx5ViLAi8mouaxt1tzKHR5fCW7spY=;
 b=k2UwPWQxf4DO1Yq1r5uVObollJva7NrslmufpubS7me+seNvH6sdGbJ/CRStQAq13c82Pt4RPZmD3XRqllteOn+pJstBP0OMlYUT0VYN9YAc3sKCLzQ2ILBRPwhUn5aSvyGvNvxh11GtcJA3SSkDpjXzPIT0U2nWSx00jHZmgBVOqVslTI/hvXKc+aeyJhV3VaniFKyXMIWrPRz/bDJs8ka2DjMVJpMAvEuo7veYUg7dde0rgM90BJfdL27RxtFDZmQnGD6TzSdSjMRe9xZ50AinvLSQxrReQCCCgcRLjaT9qzn/uKaBWEGZfMYF6mhVe9EfPbaGyl0e+m6E9AJJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSxHlwHD9wI1xPcx5ViLAi8mouaxt1tzKHR5fCW7spY=;
 b=IDwAnc+1/63Yj33VHNU2x7z3xPzkjBwfvdfBa5ii92bNNEW0MX/fGMX/kpUhK5LfX0VZnw5CM1467YerqdtdsU6mcOZVOQO9HmJ1rEm7f2uoCxFhnL089Lb3kmensEHd1R12BLY9rLyJOEej1Ut9X8uZs9apgufbo3A8D0Wi0do=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by BN6PR12MB1394.namprd12.prod.outlook.com (2603:10b6:404:1e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 22:59:00 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::5a) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:58 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:55 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: prevent reading unitialized links
Date: Fri, 3 Dec 2021 14:57:53 -0800
Message-ID: <20211203225802.651367-7-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1faefd9e-a718-4080-1c23-08d9b6b07dbd
X-MS-TrafficTypeDiagnostic: BN6PR12MB1394:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1394B85F9256FCBB347CDF5AFC6A9@BN6PR12MB1394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wz/9kZn770LXzeqvvl02GcPk5rI/IU+02r7aCRBOM655zjkaGkNIfiQrNC9TNPxL3fxBgKZ462lqBT88ToxXmZd3SF+KGE0b1rNbHTRimYOjX+7/vQTU3TFUiV9s4wRP7CCUwZzK4jbuAZgZbqvc9fjs1TLoBbzMciPPmL1gOfFJnpw1qlnz8vOuct8rGVqdGCccLVI8QABYEZLIVrEuUk7Db6LXPveC5YYJj2dPDZ5valz5nXtke7+RKSGZcHRVi0lrAOWeRu/zr5AtCIXZ9NWBwVwuWGsUUzqTrYhhQ/XBmBSUfmihRo3XVDcwnQcb3vNjKvfpNUjEvkpiOLSCg9Hl+ULyxP33Oln8CyubRrZgwLQLoft/Oq8+nl4WCFBvinElzIlu95O/yNnx8sI+flJ/C7LeNY73dpN363CyFmJRErVdxYfnC3vv6MSKeSipyuG59mRqJ0BEjMWO2PD9m73CqhmtbP4/8wMZm5erPxY3BrapIcB0KV+StmfeVWfLjMFWcDfjQ17GsVVlYrVpjIiB9+oqiZbkAh2FWpk3NtzX/WFGD/RrVDRWZdGnFZ8UDUdqhsVEJ88l+mjj5QnlbyMncc6/2I6QaMrWB3pGq6cmcOsDJjL6oYTbMPA9OIlLQyI08tQYIf9pNj8fkG036Vfy+AOWGqDi3QOLhlMBIj6vtQwoTtqQ1qBHdo2LZVHgdrWVjVkfN7HzD9VA9+HyD0yBT+mMeT8OlwPptdjgK87SBhoiLsrgXnerVHqSYPCq1f5kBUPxsVayGZf970AwCUj+MiIqt8+v0qqdxmn4NAE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(8936002)(82310400004)(8676002)(6916009)(316002)(54906003)(40460700001)(70206006)(36756003)(70586007)(16526019)(36860700001)(47076005)(4326008)(336012)(26005)(86362001)(5660300002)(83380400001)(1076003)(426003)(2616005)(81166007)(2906002)(7696005)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:58.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faefd9e-a718-4080-1c23-08d9b6b07dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1394
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why/how]
The function can be called on boot or after suspend when
links are not initialized, to prevent it guard it with
NULL pointer check

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 3d4f5bf049c3..4ebba641538b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -231,6 +231,8 @@ static inline void get_edp_links(const struct dc *dc,
 	*edp_num = 0;
 	for (i = 0; i < dc->link_count; i++) {
 		// report any eDP links, even unconnected DDI's
+		if (!dc->links[i])
+			continue;
 		if (dc->links[i]->connector_signal == SIGNAL_TYPE_EDP) {
 			edp_links[*edp_num] = dc->links[i];
 			if (++(*edp_num) == MAX_NUM_EDP)
-- 
2.32.0

