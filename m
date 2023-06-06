Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C4FC7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5625310E311;
	Tue,  6 Jun 2023 09:17:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9AA710E30B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbOOps1svoFsiXh2uSGHMCAu5TXZfz28n3oQ5REUZ/zANV94406q3re1f+lpQR1PIOyIW2H3gS1H2T8nM9dtbWybNcRp2/biAekxhGu009ZGZP+oXICvKv2sQy6Wle2xLLlCNMJPWNw86nV3UJzDVMfcETcLdy/VyDkSv1FgiWoy2VTQ1uQUIba73VGGoGbUMN3rv+L8zLXtPNzJJ5YgiwM/BhTOBjkmLPvFZJkXGEqgFUL1WrjfyXTivY8+YtJlX9Ej2+u8rpM9kRj4m0NeYI/hcSrWEEjF5kcRHSM6ARAEgPzIO0lFj5jb4gzSGUmdgrcjOURe6cDS9M0hQjGohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p63lyw1JZKoOYTrQgS/b/fkO1+bLq1m0FNyVTJc9/Xs=;
 b=BESqL7QTjx6bz66UytH06cL0DeLxBWbthnIwZI7km3NDWrzY3j65KVuoOsuKm7WSkhU9GqMDF7wDPt/OAlVcdVJKY4WIhUU/hCzyGQy8+RodKViA+DYNWr+pvQkf468tRJT2c9f78YP67KcTC7iwm6wmARKgL7if7m/wFrPeSyGYgBCwJeUOy8kHVCIbg61dOFBtb04SnWz/R1tbhi0WeXQWQIvbPwtWA1wlRzV8BXV0CBxffA6+iXg/cimPgXdJKikrsEi/Dfs3hoxpDE6hffAgKeOScyWQwFxbhPQtCq4h/9YD1Iis0xew5tFPYu09ysqJ/cic6nuKi1xrT5crMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p63lyw1JZKoOYTrQgS/b/fkO1+bLq1m0FNyVTJc9/Xs=;
 b=eRwlTdDOmWMVGXQrdEo41JDfI1A0PKQUY5a2c4rCS3iyJSf17GvWAgoL9vYcN1hjV5qUcOEc7WM1CXBjwFPvYiYMQFkveM2z7P3bbHaxlkyc2WIphSnL8Ze6YsoK2z3NrGeHZkuWmSW3UeUm9Qk2rpFF5P/nEH2B3N33XAHpyd4=
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:51 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::19) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:50 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:47 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 04/17] gfx10+: iterate only over existing WGPs when
 scanning waves
Date: Tue, 6 Jun 2023 11:17:12 +0200
Message-ID: <20230606091725.20080-5-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8739a46b-c3ff-4214-518b-08db666ee6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2Tp06U+J9Vdv3CIGJBxqzcTNxtLBVtVybJQLpxq29AHxiMjti5PRbcNTPbATAPBvwhc4GoQckycqGwx5hnmRTF46mECzhiTKPQAC5qZ3o9IyX/4YVdhW6s0mWBH6hYpa4RlKGIolruh4OorjyNlZMPf/wohT1OeB+yUVYsdUIKArWOVWi32WsV5ucWCdhpljBlz6c/yTfYR3VZhiuvg29DkHXucCV2GtK4aWe4TEPyCGva6v9BTFMkjOB8w+x49cm/QgNDPQxdho/yHfQv0u6wlxx5XLnxTKFxX+poFuwI5iTQhCGcdvbcaKurY4oKygW1ol1ZDwq+gq15q60kqsD2Eh6W9ibwgZEaUPTQE3kLvkH1ttNgFZ/HoXpz1rI1iKFk1Uoa5njniYKLfgbd9Qu0cgitOHZnXUT84jAXRM4PCVVXbeSs5/7L1ZOfHVl0IsBYpvf1HP7ODBS7lFTErTSuF0b8zjPfHnLcN6/hxM9MokWYqRnzJFGmsHQs9aRDzS+0M+l2DB8TGMpRMRIEsai2SlC76MXLTXro7D+yuRL5aXrScuyNYmzxbulC259SA+3oBdn74sMi6nUW+rHg5GWPKeFcc2kiWCT2fpUt86jWqVmSd5FLrKoDs4YR4YUwEv3eLQr16AZHkJunXFiO4dfSMG02F++jCsyG/jc1ppXD4Y5FaZlDHxBATYdmkzW5HpTxTekWScWExG01+sTra+HGBCd2knJlRqcEFSz+AWRVqN4MMixbH4BsnODgimumV4T3wu527PkAAmNHvt/4TKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(47076005)(426003)(336012)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(8676002)(8936002)(478600001)(7696005)(110136005)(70586007)(70206006)(4326008)(6636002)(26005)(1076003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:50.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8739a46b-c3ff-4214-518b-08db666ee6da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We overload "cu" to mean "wgp" in a bunch of places, but max_cu_per_sh
is always in terms of CUs.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/scan_waves.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
index 767520c..3279cc2 100644
--- a/src/lib/scan_waves.c
+++ b/src/lib/scan_waves.c
@@ -618,48 +618,50 @@ static int umr_scan_wave_simd(struct umr_asic *asic, uint32_t se, uint32_t sh, u
 	return 0;
 }
 
 /**
  * umr_scan_wave_data - Scan for any halted valid waves
  *
  * Returns NULL on error (or no waves found).
  */
 struct umr_wave_data *umr_scan_wave_data(struct umr_asic *asic)
 {
-	uint32_t se, sh, cu, simd;
+	uint32_t se, sh, simd;
 	struct umr_wave_data *ohead, *head, **ptail;
 	int r;
 
 	ohead = head = calloc(1, sizeof *head);
 	if (!head) {
 		asic->err_msg("[ERROR]: Out of memory\n");
 		return NULL;
 	}
 	ptail = &head;
 
 	for (se = 0; se < asic->config.gfx.max_shader_engines; se++)
-	for (sh = 0; sh < asic->config.gfx.max_sh_per_se; sh++)
-	for (cu = 0; cu < asic->config.gfx.max_cu_per_sh; cu++) {
+	for (sh = 0; sh < asic->config.gfx.max_sh_per_se; sh++) {
 		if (asic->family <= FAMILY_AI) {
-			asic->wave_funcs.get_wave_sq_info(asic, se, sh, cu, &(*ptail)->ws);
-			if ((*ptail)->ws.sq_info.busy) {
-				for (simd = 0; simd < 4; simd++) {
-					r = umr_scan_wave_simd(asic, se, sh, cu, simd, &ptail);
-					if (r < 0)
-						goto error;
+			for (uint32_t cu = 0; cu < asic->config.gfx.max_cu_per_sh; cu++) {
+				asic->wave_funcs.get_wave_sq_info(asic, se, sh, cu, &(*ptail)->ws);
+				if ((*ptail)->ws.sq_info.busy) {
+					for (simd = 0; simd < 4; simd++) {
+						r = umr_scan_wave_simd(asic, se, sh, cu, simd, &ptail);
+						if (r < 0)
+							goto error;
+					}
 				}
 			}
 		} else {
+			for (uint32_t wgp = 0; wgp < asic->config.gfx.max_cu_per_sh / 2; wgp++)
 			for (simd = 0; simd < 4; simd++) {
-				asic->wave_funcs.get_wave_sq_info(asic, se, sh, MANY_TO_INSTANCE(cu, simd), &(*ptail)->ws);
+				asic->wave_funcs.get_wave_sq_info(asic, se, sh, MANY_TO_INSTANCE(wgp, simd), &(*ptail)->ws);
 				if ((*ptail)->ws.sq_info.busy) {
-					r = umr_scan_wave_simd(asic, se, sh, cu, simd, &ptail);
+					r = umr_scan_wave_simd(asic, se, sh, wgp, simd, &ptail);
 					if (r < 0)
 						goto error;
 				}
 			}
 		}
 	}
 
 	// drop the pre-allocated tail node
 	free(*ptail);
 	*ptail = NULL;
-- 
2.40.0

