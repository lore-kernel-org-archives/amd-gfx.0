Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1BC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF8A60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF8A60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB306E938;
	Mon,  7 Jun 2021 16:48:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204D66E93C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvKPMv35C09c4ieX7Z2v7B/DElUDggkrZSOmXDPnNsG7ph/us0gK7TroabW81uFZ4Tc79IQz4R1jP+XMATlet1kzmUB7E6S+BPQ1oSeBOoeEY/8nc8PqzQuBwc1ytPKqPx8NVOcaMSxV2gwCXrKZrXCfPSWRatHwtvqboSuhEz3xwayIPA8BdYoADEFlw6N9LeLw4EYO+cxPwuseHxTebjXvzUXUmH4fWrkFSizlHjMrEKZkgE+SUGzUGwm+zaDD1rJW2HK9rwseore3ux2leDjzWCleV73UK6V/x56DWnaxHRW4JvwCODJ60jY5wKM1zCdB2CTAJDMAEzkG/UF0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGVx4id/YplsoWYInGd/iDrcLqehQkZm5v4Q6m0MhuM=;
 b=O2FsYcoG0PYBVjfeWqp3H8fV1QIsL8yv80f31el04jNQpkFV4jqXbIEsW57B6yNSKuyp5n8XQNiykd5RfwU/g3jLC/KBBB5QnpE2gRGvZnM8ltYSz1Pzi0ZETTGaVPSfgFg+8/93Mnzu+bNcGMAZJpwzGnUNXyDhG9fpUKfPNGvmm6Pzvi4HqFr8PDPhE+dq9LcgLB0maOOrOfCO/OSkK12Xc6lg2WxK2oLSnOQ7M0CiupQhDzX6qhMFYusrZb9Gf9vr2MRRUu/8m+j+nllV181fLJw+06Bs5XHLpzHNFSfbF7KPUJ+zK+8adRSfIm3LSukkbjo0hSEGjCFVaGxUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGVx4id/YplsoWYInGd/iDrcLqehQkZm5v4Q6m0MhuM=;
 b=IdG/lzELF93jBwlv9mRQNghuDI2j5W0bK5boYLNCIjX9hHs5rkDz5HTCcDNrME9F6ap7PUv2SxQt5AC13U6L3+d4TejrI9kqjSS8jvw3BPPaeoXHKXmjEe1C4nwZm3ALfhLlRhutaxcgCPBfHxreZKpmt9JhPock8Unl+vLXtpg=
Received: from BN9PR03CA0616.namprd03.prod.outlook.com (2603:10b6:408:106::21)
 by BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 16:48:47 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::8f) by BN9PR03CA0616.outlook.office365.com
 (2603:10b6:408:106::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:46 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/30] drm/amd/display: 3.2.138
Date: Tue, 8 Jun 2021 00:47:02 +0800
Message-ID: <20210607164714.311325-19-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ef6470f-98a9-42f8-8538-08d929d41e72
X-MS-TrafficTypeDiagnostic: BYAPR12MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26140292A90904BEA7BDF898FF389@BYAPR12MB2614.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrDTkN7sxwvUWIEy8LhZRmLZ/wbuUD/rOK/n+T52jBDLuF2Iy8CVbWLX9ZoPyCmPXerZfb6xwsJ2t6fiwMy45xkTuri3616zO5bMX4aSH/uPa6wVJzncpzUaHWSmb81+eorzTeYsEUtUlmO4PnWiLqJ9MidgC1F5eTce7nQfC1SSsQqiIltlTSEYKC2KJ6O2JHpqiExi0QQzhkvrx3WMEc7NPvoa7wpqWHvIjA8QIPmbf7tTcgOUeDlE6E2M8j+qD90RTk3FSXkV+Oyqg1etnwXVk7oKA3gS5znCDDwtobpDiEZv3OoqPuNTd6pBu4Q06gwF21oIh7pQRszsMqhMw6ld421hIYl3E3dTt9HqAe4i42RkLVO9JXkl7Dj8CLcLg6sDm72ajJDjtctylefrOs/Dsguu1wsYFf2/9kxQYJZ8frz7tKiZvwLTHUWvUtkVmfaaRDbtdbxxYjkp1YvK3s9zbm6aT4gukh255UQehA4oRRgrWLwhGmRq5aYOPgyeyrMHxp2ODCeduWr+8jWhDYeC0fa8LJ3dVmCXmSUrxcQpR7XsRBDldbYdIbM6uIhYj5qRMSbiivJMyl0lt2PStliS0cJ2FRklY7Tnfmi4+csS6rk5w2co5uK04Xb3Hj0WwWm6IMlceZAcimOaGp/xKpTI3TEi9OCPsLJA8BqFKsh9/NVZb/aJZXoxAI6c16jh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(186003)(2616005)(86362001)(6916009)(4326008)(54906003)(47076005)(44832011)(1076003)(16526019)(26005)(8676002)(8936002)(82310400003)(70586007)(70206006)(6666004)(36860700001)(426003)(4744005)(336012)(7696005)(2906002)(83380400001)(36756003)(82740400003)(478600001)(81166007)(5660300002)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:46.9828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef6470f-98a9-42f8-8538-08d929d41e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric
 Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c0fbcbd4cbfc..356e15c9df60 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.137"
+#define DC_VER "3.2.138"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
