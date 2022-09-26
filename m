Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6349C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 09:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C2810E65C;
	Mon, 26 Sep 2022 09:23:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9B410E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 09:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXXb2yTAPUanSfK4oTmair+QOJUmHUxv/ZtOoxh3tUWSYAkCN9mFYfu7wsBvOKCUF7IvvLvhG6st7bIqvjIEaPORD8UMkSMuRitI+0rThHK9zvefaIVzi6Z+PS1JWmB/LaNX75wLwgCnQM7QI1S6bh8EKdaDd2z6P8SCgbYvb8jP64PyrS/1NTITWGDvjKDW/RJSmwx2LqpFn7KoQ716HWRHPvQbwBBa5QmMypKlE6GThCNzHV8VP5zcjr071GAdoHiAg9G9nj6dyj9gg+Nz0rtfjbp/pedZdRy8ixH7lVZHKSWzqdnjnQ6773kjZNCJLy6K2VoLwyK+5iHounVI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyP+teF5yRVkm6NGC6hqq7spfWMuSdPhbeSX5fJgcW8=;
 b=oXsLXU/gycxq8wHfIAsx+O6CjszBUkexC1Dz66/Pf+F580UTC8Ijhs3iJ9A6wYuopXTJlgZF6cvqjlivcKeHs9OiBXoqYx7BYJI12G5bV0QcvvG0sCA3d/bOC2/PmFWj4aBRFV7kG6eA+GHLN3i2Yi5G8rJ1D0YMDkUpCdFbgySvE/3hHJ/evo3E5K10OqbO8DiI3mBJ86cYW6jLn/Oqe8ty2e3HLltJSTss3nGo44WiozRoP5DsZ55bJWXV8kID3ITvoc3TzpCkzkm1+xBp4O5EEM8NP+r39hHrNCSReo6cwJRvoL8tz7exGnkrCcDEXrvsH7B18Z3TKvViI0p7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyP+teF5yRVkm6NGC6hqq7spfWMuSdPhbeSX5fJgcW8=;
 b=pQbDlPjzGbXu+BMa0HkXjjmG7QVdQk5G7LEpo6j58isteTWpDtaxIpz9VacDv249fyYwbrGGxdEiR0I9ZM+9KqGf4hzfwFdsny4cfTck8oeTj9Y2QWVf69mk2dzfznZXPjWpFXtR+jb80OwWUb8iD+74k+hvXcjJvTxSjT0WH0w=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 09:22:54 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f4) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Mon, 26 Sep 2022 09:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:22:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 04:22:51 -0500
From: Asher Song <Asher.Song@amd.com>
To: <Dillon_Varone@amd.com>, <Guchun.Chen@amd.com>, <flora.cui@amd.com>,
 <yuliang.shi@amd.com>, <jun.ma2@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix a compiling error
Date: Mon, 26 Sep 2022 17:22:26 +0800
Message-ID: <20220926092226.96988-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|CH0PR12MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: e7746e50-b414-4b89-4847-08da9fa0b11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUGvZKo+sfRGyQO4MRlMtjW3ha6z+MIw+P9CEOwK3/Py/olAdP1NvR02+DDmIhWGT/ae+WbT7tMxJsYx+t4wnG2tUvnfkjN00UDgoMeUkUaIdEboiL9HfMqWZGs06sgmA3DQVQtd2xUiCLapMQNT39mwmdI92hrrNxNy7H5OaQf+F4bf7MziWv1gpMNWD24gJ9a/SB3XBQOjJ4vdsv/j9vSuJMkUhMH2hhH0470Mnsw7uKAvlwFaE2/1QxYCFCv4STpmadrLWOk21+JumKfz9nN14f7M4KvHApwFdcU8PCbT4dCnarVCRIsTijF4kqxONdblwg2n9Jq1AqleOvqSostEx2RgORpeA2k4QBylQEVdPLgM4eZw5gY1riHUJ+BZoVeJBPbmYvECu9UWUmfiwV6UGmm7mNuWEFPBLStszfZQ08UkHErQocaXyXqc5eJJOU6ujm8K7H55oMAuVxUvSC6AxrsPMRxsVxJFWtp3Xd3M2Y93MGN2ym0GjNM1SODxel/aL/70DQ4kWnu4iBP6smyZm2IxudgP6+29pVG2beGPK/ECFTd2af9W7tXyLGZRbxZByPa9NtAYntgemxDyWsfXgGJsSu/3G7XEPAaMHmD5LyoznPMCxN6Z7kelHaE0WNK4NaSnEZF8RyeyNszX/k1ke0I60qHFS0wWYdgqJjFIOv3ozvNhTJ82fYmd2e/AJ8URsG/ZLUsHoJrlqhQXJcOhakrjO+0yDyPzLgZKSWkukt9AdQKxv/747XmgRdqUAOqGBs2FQLK2ksjQ8pefYLQSJLKdmIB2TzlnyAkByUlTyolAGrKPXQkXEfz8YkB+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(82310400005)(81166007)(356005)(36860700001)(478600001)(8936002)(426003)(83380400001)(110136005)(6666004)(40460700003)(316002)(5660300002)(26005)(336012)(2906002)(47076005)(4744005)(8676002)(40480700001)(2616005)(70206006)(70586007)(4326008)(36756003)(41300700001)(1076003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:22:53.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7746e50-b414-4b89-4847-08da9fa0b11c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch fix following compiling error:

error: ‘for’ loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 772ad200c5da..d58c5085600a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1405,8 +1405,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
 		bool safe_to_disable)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-
-	for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	int i;
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
 		bool is_dsc_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
 
-- 
2.25.1

