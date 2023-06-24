Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8524EB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 05:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC0110E002;
	Sat, 24 Jun 2023 05:14:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDFB10E002
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 05:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFfeMVhpYlNt+fbZAJfqwzrx8IzcObHmhePm4OXC5ncktT/0teN6cwN5kaE2AlEhrSW1eXrpBd8aKuL5NrnNaa6K6fI9zidPJRCKKmOJ+k2NRorjIwB+2Py6FLugoBxCgRnYJ2PXYpCuPt8y74LDoiTMlChdLmgI1Pbuwhhi87JhavoyGuV1Pv+8zyTVW1UQbnGfzP15Zm93kejj5Ii2wZBALaJ0fW+rctqWflmyhumcv1vEHPr5RQr24t/k/dRw9cCJqRCKa7I1IE4AiznwfLvGyz6FE9anM1AP+355qbi8Apcd81vzdFSVluN31suMrfUDu3Cw/Q8r9OYJ3thing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u74BPd2A3Y/tKf0Arvlyaux0Hnjn+1BMrGbdUtr0kRM=;
 b=ji1QeYDHvk1afw7nGdlTW0d325gWhiNWpGBtXccoVhwbsnVtID2Y9RihXN8odVrznf2OQ++EodGLVAVIt7ZRP6cEkOllS4tuRzw/XPsIKhzRiXXq6pyAKKHC4tQLRjJAgsmv/IvEbkNCgc5PaSU7fd8q7BdtH5xNtLkBIPzuysdAI5lxj+Q+fFVqY4jRTo0CY3WSU4q+I0i0IN9LSJpYppuqEmnOILDxXG+HvG08URw6Ipj3gH0DcS7D2x+6sM5TIsADS6QWyVN7xwbSQ0qJuDEEkEaRexwetui2kX9LAZ+IjrO93J+ne5cYOO7rheKN4q5wF9tLpBvHiFVEGagNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u74BPd2A3Y/tKf0Arvlyaux0Hnjn+1BMrGbdUtr0kRM=;
 b=VQIh93bv0EoEs+5IDO0sTGrKIspGPrwsT1K4H4NKr5fNibiuGknFlj44tg9U7OkgMD4GnuJD+9znsEcNiYcmcXP0SHiNa0YK9/OAQzChOrXKwUWJhLYtFs0sHO2N7iZbKWu1xC4lVa/2+9XPO0TioTiAMc3zBAJcrgGzhUe/OJo=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 05:08:52 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ec) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Sat, 24 Jun 2023 05:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.45 via Frontend Transport; Sat, 24 Jun 2023 05:08:51 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 24 Jun
 2023 00:08:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Date: Sat, 24 Jun 2023 10:38:34 +0530
Message-ID: <20230624050834.1240111-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c23356-7a84-4bbe-2922-08db747119d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+Lf40eENV0EeBA5lFE/BfRU2g1k37d7n2Ryv0CrkLQqpE9JLBrKaqwoIkKbr1CmN8Yfw+oZ7rWzKMvnLh1Q7Rp2op++TXfjA6sZNCXJ+8WcJMibkO9ucXDMZB0p+izWdPW1vXk9dFU7cF/IrTG8KfQ1dad7YiLfl+1w3QlNytf35veM3mE9BM+upqxcO8hR6SmrjOBKGj91uDrnstWChCdOVhaIzg5xPx55LF24AvxIIC2xMsERNcxL1jT4CIHvX2flZh7HPnWNp7iD02so7QduJSccJtnmbPwfLrGMhyOJMBiTK3y7kCGkgKg0iMxti81xxNhJTFteBP7MYnIoPdKyhO95NWymozckVgoTPrXpPdB2BRWCnhSOfWRn2ZW0RA8ieRdGIgHlgGDNBIs9qCWX16aPJ7Y9y6Vo+7agTHmSSmoJbblBXL1ja8PVXsyRSAxpq7d9y+9ITflu2Nx4lXswefi4WLYr+DrtsxJN2naX9sCHs7cJTaXK1PQQ0yCoMV94OHZPY34U9DgC0P4DNo5jp+z47+f4KZ1PvKbydU/rJQuSB0w6GpPa9A/0h8nrmqCiHNFSQPMwO1wmHaJimNaByqV8BAoBMe+VUPdPBC14Wtasn7Q4z2nsk7AbOR9dR0bl3nAIrhSc5Hm62ml8xqzP5Py3vzcxDsl6gj6nT6ctzzKjpYnsXujDp/zKkCN9ftvt5Fb8DF1RLuBjuO9nLBoPyGh5qg0Zxqf5Is886DPi4GGvXuKi6iPVyY4Rb9l5yn0wDaGAfTYjG48RAxJHrh6tCwQFTJVxdNNgMDeiU/gINto+0Ua5oobQRnYMs9N2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(26005)(186003)(2906002)(82740400003)(6666004)(36756003)(8676002)(6636002)(7696005)(54906003)(478600001)(966005)(86362001)(110136005)(4326008)(316002)(356005)(47076005)(2616005)(81166007)(426003)(336012)(1076003)(41300700001)(19273905006)(40460700003)(5660300002)(83380400001)(44832011)(8936002)(70206006)(70586007)(40480700001)(36860700001)(16526019)(36900700001)(562404015)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 05:08:51.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c23356-7a84-4bbe-2922-08db747119d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch complaints:

WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html
+               char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2: 
 - updated commit message
 - Initialized char *buf = NULL; in the beginning of the func

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cd20cfc04996..dfa3de065182 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -373,6 +373,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	va_list args;
 	size_t total;
 	int n;
+	char *buf = NULL;
 
 	if (!log_ctx) {
 		/* No context, redirect to dmesg. */
@@ -400,7 +401,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	total = log_ctx->pos + n + 1;
 
 	if (total > log_ctx->size) {
-		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
+		buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
 
 		if (buf) {
 			memcpy(buf, log_ctx->buf, log_ctx->pos);
-- 
2.25.1

