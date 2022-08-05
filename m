Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AF3C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B4E8FFC9;
	Fri,  5 Aug 2022 18:02:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25C2A07D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JveRljfqJc6thCljllbl2fsMr1YlotSBCIySA+WQ0SAVRAdiJ2205YjIHFkrGl093rSfXz6ZFjRxsjOKMTbg2YY7mu18wCENZyTm6gB1CVOHj8MwtsvnLjvZzX8YhxIal5BQx3ySYcmXeAbW4mgCNuHzwLe3nuhcBuflugQHGxTS19sTYgs9bCTbajgEVW3nj4eAEuxgya0moHIrVAB0dkitpl/V8Jxz0byZx2X26O/W+MG6cCZtoOm7B86nFrMMaUBX6o8k4nQc8LfN8h/gYNe7G2iYd1ir09HQoOK1HdYDBD9vPKNITghg72SO/E2sFM1fupetytSbdPsaJ9tS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzDQKaGscFfgB2E/Uef1fKTNlLOpiHObGbfAcXfN+7s=;
 b=oPubV2z7Zr0/1HGNRsCU9mFMD2i9vydiX6KhE/9/ORlllvPrbpJT+JdJaDZi4OAEkHzVNa3VyH4Rn+/OHt4xjPHEkj6UMG6xFgy3pm/pMEb3yEl3tTS9Zt9qoOpszN39kqT5B9kA6zmMUkW/oXabMcw+hdUai2LYmuTJ3Diz8cYY2jqEM2nUDAIROEKe6jrFeZ8FBCF1Y8K67YSx+gWXmnUDG2pJlSoilGZ6cCelw4TWD1vY9z+dWjr6YvBDm3X/Y1eOtb9DmeCS/S/IE9W5sVF/VaCKBcqnX5+JmqKCHmERRdRvoB5ORrt7TST5SJIB/VJ/FvIyqM4EW2u5Nddyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzDQKaGscFfgB2E/Uef1fKTNlLOpiHObGbfAcXfN+7s=;
 b=zwxgXbEeyknDVZ633dsOYjXhlOxQvVWXxB2w8eNoi5sJZ7fha+R4hACzTQDHiv4oRpiauYYbJx8S/FXi8YwYINzGaqe46SoIubzOCekC5NZF9UoLfYmEjf5JDTWyGxIEyAcgbHxBLmN/WJnc7OLiVQiPQYimhrFuCoTzWHJdP3o=
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:01:57 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::53) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:01:55 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/32] drm/amd/display: Fix TDR eDP and USB4 display light up
 issue
Date: Sat, 6 Aug 2022 01:58:25 +0800
Message-ID: <20220805175826.2992171-32-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3975c927-8480-44e2-bd3d-08da770c9628
X-MS-TrafficTypeDiagnostic: MW6PR12MB7071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5y82liuJxLj0+aEm2bnoWQk0DVDZKh0TbDiIXUVNDEZjQxgqCYiLOI/hd4ZPDDt9yrl9GMvwlIDFpTvV9d1Ao6c2W1K5hl/8QFKiZlT9WBP0/OfIScEBSKjv6n5KVj5TXl06Rp9EtHQUswccNbMw6+5sZ85RpX7JF9MjFSZYzoQHi99lpf/VBISrUdYN/t//GXpr32AqkCSw8BGszCCW1iEy3VQygioNulBYxwQwDvLtk/dIabXZldFkiIGD0/cwRUS2VUFn4raO6BEUj9UtOVfOHcfLOhIqY/3JTx3PubFRVsImslYJXgk6Ap0xdm0q0OJEpg4pCkv1hHc30LhPyFFutFLD+g4WSzxdYC00Fxx2f51be2gx/N7ofveIsoLpqEzjudL8Sg5Ai42KvM1xnTWOfWmiR84mUCR+ZlC3GLmeZmrDQBZa7j0uVOXEeBmKQoAt0ga5DAxRLaNRdWwbs9Uco0zAWPxDwJFl2jPMFusoL7x7h5awRyFDnzUifea/aeSu4pIjnWfeDbhNPK4MhLQiStSmddi5ZdsBHZaXKbVH5Uy58F/+2HVcWOP7oCAEkXDsf8exNfPVRYoY5/nDh6lqwLWjW0/bf7v71ks02BzF+UVo21oLNuuxN2+TgOGH0aNuMK/LwBiVp+Gf+wmYPuln/GlNH/bWtuwtpFCcSpzC5qR2/oZocEZyTpN0DlpgZS+L0l8/U67gDa5aSqdaNpdHneccphEQaDJfkm88JdbIsmPQwFC/t428pnICVbqiOY3XJDG2KIiGC2FHWBRP7j5OzR/uSQOCPrW38uN2JrriLCuZR+UxuS2JjmSM49XTy4QNHhKp4sh/Hw8TFN56A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(40470700004)(46966006)(5660300002)(6666004)(8936002)(86362001)(4326008)(6916009)(8676002)(478600001)(7696005)(316002)(70586007)(70206006)(40480700001)(40460700003)(26005)(186003)(36756003)(426003)(336012)(83380400001)(36860700001)(1076003)(2906002)(356005)(2616005)(41300700001)(54906003)(82310400005)(81166007)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:56.7974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3975c927-8480-44e2-bd3d-08da770c9628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Meenakshikumar
 Somasundaram <meenakshikumar.somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
After TDR recovery, eDP and USB4 display does not light up. Because
dmub outbox notifications are not enabled after dmub reload and link
encoder assignments for the streams are not cleared before dc state
reset.

[How]
- Dmub outbox notification is enabled after tdr recovery by issuing
  inbox command to dmub.
- Link encoders for the streams are unassigned before dc state reset.
- Added WindowsDM::forceDpiaUnplugForTdr() API to remove all the enabled
  DPIA links. Because after fw reload during TDR, current DPIA pairing is
  meaningless and there would be new pairing process.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 08f533f86520..0bc6174aae61 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4340,6 +4340,7 @@ void dc_enable_dmub_outbox(struct dc *dc)
 	struct dc_context *dc_ctx = dc->ctx;
 
 	dmub_enable_outbox_notification(dc_ctx->dmub_srv);
+	DC_LOG_DC("%s: dmub outbox notifications enabled\n", __func__);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a0af0f6afeef..9544abf75e84 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -344,6 +344,7 @@ enum dc_detect_reason {
 	DETECT_REASON_HPDRX,
 	DETECT_REASON_FALLBACK,
 	DETECT_REASON_RETRAIN,
+	DETECT_REASON_TDR,
 };
 
 bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
-- 
2.25.1

