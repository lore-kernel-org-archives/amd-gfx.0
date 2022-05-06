Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3FAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5347710E5CA;
	Fri,  6 May 2022 15:43:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0BB10E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndZN9co+vZRi0w3lZbEcy3FmdcDJupO9/R+4zYUQFUSnv510/b61tYNQcHAEs5os8x4v5yh8/6XjBEbwKfv3MoSH6q+kqgK0VNO7Ce3Y5W69w237G24qAbSZRPY2teTy3Rxyf+gG+CDGmxltYbcxQRSY5erhdoGP4d0+m3uDcvTmYJdJeozjgxAu5AMz7+wphd0qyhMqMCUOS6etTLpR5WOt5kAVLo2GhAP6SJhcBuBISyrEqdWXYJL4swsn80oCow/9A3APsb5KoNDxi2u+M/Y4XNLiyQsNYLEhIXYtCw60n+VSBXBfTA2e18yM0/o5lpGRvUjryZEo/GB5GZZD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGxtPuiYXb8F8jY0JKar+JQm5ebsnL2SSsFRaelJtdI=;
 b=U9Df8AUw56R15VsGuzqd1gkdmMk+k2bJS+ex7h+oVHcYlzrRdLx1nADoNuNF08ODsN4ZnKdvPYnuGbRgD5Pwxu2yggc2APCjU7UyjIWK4X0E8rFgGbxes92NGep1DZU1NF/X+rhOpQEUwH2IQUCpP2czZ3++agZ7xe9nFspaetDs3/3Y1yJ+q3Uq2nuTeiXEjLbC1wSMpabtYOIP6gebDqx8zalLOgDPF6U5j8Oek/I/n9LtUdYkuu3aSE4Wuchl0Ir49PqE195RSBIWYf+YYEIOzxtellnjbsmzRyDgJNWk4hj4J8reqjhOzdQH1560nVS1Dm9LCYLlQSj/DrhP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGxtPuiYXb8F8jY0JKar+JQm5ebsnL2SSsFRaelJtdI=;
 b=ekRjyKShpoxNPvSy+OEcITWYy6uKyn01BNf4x0ihP3dsroyHctt8VHV4Yku8GfsHdFWv9LHKtGWAjAp+4pDh7Iif9U43g/43re9fSxQJQJQy74g1qj1QFvIkFSiEfJbu6me64nEOJi+/NpzffO1woY8aKIwVlVhbpV4nDpan5Xg=
Received: from MW4PR03CA0108.namprd03.prod.outlook.com (2603:10b6:303:b7::23)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 6 May
 2022 15:43:10 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::72) by MW4PR03CA0108.outlook.office365.com
 (2603:10b6:303:b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:09 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:04 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: do not calculate DP2.0 SST payload
 when link is off
Date: Fri, 6 May 2022 23:42:04 +0800
Message-ID: <20220506154214.3438665-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933e5f39-7738-4cde-ad4d-08da2f771f31
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB256492D010A9A6A2A5348B44FFC59@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTgOf90u3s41Ovjb/0i/FtfNByVJ+fMCNow/cOMgHDVvTnl9utW4raeXWJ7AWrtDqtqC/fcM8sYSijw1i7XSylH9o6OLBsCz7StY2TI8kMBN3kMbqkqvsRu8iMDJ9sqb/GXc/tGZose9sf71t+WsgjVW33FRloxzOrT9lg8S8IPfV1Bgj2DwOWKPzHvBuI4qqN0y4yF1oenX1tzeVg4CAYcg4+kOHag8fUhMl2QK8G7oTdfaKajqiNUo54v5kIHK+a+s6XIZr+aFgKFjkeC4XGzfYE870tlxpkW6T+mCaVIqyyE8ldbt1hbtmnMS7c7EDk3faU8pi74CibgM6lHMbJN7+8ZCu4NqXMFUfR5cFPjx+R4DabknF4aTzDJN8UU13/q3C3m4Gf6B8XrlfHF9bPegcMlEyFh9g6ZoTH6FHEgaiKqiSsO8o1MzpkShDQm0jm+EK8rcppw4m6PVzoJnh2DNoHfa3xXbZRyxDGinS81L4TY6j4AhxQvcI1atiFJ1/ZIX3H8c6d+ofElXhr5wtVbwpjlUR7HtyKkmGQFo8siyqfxjRo2+gGuetmVLzsYaIVZKScoZ2zAH/uauaIqd/QbO8UXq10Kzix0Rta82G4afyd80A0rfInKSUqWn2qU1nf3Irq1z6VwG9gYDhWeLe0LwVxILXgiS8ogizSw+pPrBT1NYHPGLhGMW9fIP7vnJyU07IUcSo+4KrxOJ6B2xmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(316002)(8676002)(36860700001)(4326008)(356005)(86362001)(186003)(336012)(16526019)(2616005)(426003)(1076003)(47076005)(26005)(40460700003)(54906003)(6916009)(5660300002)(7696005)(83380400001)(36756003)(508600001)(82310400005)(8936002)(70206006)(70586007)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:09.5434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e5f39-7738-4cde-ad4d-08da2f771f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
There is a chance where the RX issues HPD deassert in the
middle of link training, this will cause our logic to
abort link training and turn off link. However our payload
allocation logic needs to use current link settings to
determine average time slot per MTP. This will need to
use current link bandwidth as divider. This causes divide
by zero error occasionally. The fix is to skip DP2.0 payload
allocation logic if current link is not in 128b/132b mode.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 48e274f9ea84..07f154fc4e56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3546,7 +3546,8 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 	}
 
 	/* slot X.Y for SST payload allocate */
-	if (allocate) {
+	if (allocate && dp_get_link_encoding_format(&link->cur_link_settings) ==
+			DP_128b_132b_ENCODING) {
 		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
 
 		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
-- 
2.35.1

