Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA82161213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA82161213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB9F6EB11;
	Fri, 12 Nov 2021 00:56:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA1A6EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxDJnlBPD6ln3SJ6oeDhOVJEJljincWx1x4Sek7P4QPGlGkuNzH48WvL9T3tWd9WQ6ISNqwi8eo1FGYxFWVG/v21Q6yYesNHHF/GV7QxBdCDN63m9dq2SNmrM8IRaaQaJafIt3olcj8ju6MEzkUCAcCGRikxX2Fxy2Ay/t/GP29dtPoHRH/EyiPYr3b6OEgsw0RPcs5+iJirA7a3iEdEQeIe6D8vjl0vcE81qeKq2iUhjZprGsbdmY4Y57m0aZVY15BaHrXkVneZZzfs7usLUYpQbznFLShEdc/kp09kIiFpDCqPmbHInxuxQBuust/2lFhFI4ahpFNAZ4hME/qD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoZkdLYsmgEuCwhHkrJw3kxgIcgHa49PU03f00J21S4=;
 b=WOLLmiC2bs5J+L8e/8yZNp7UYi27Oa11ZB0xy3nEQrWBI793KvIh8ii6pJIFboeUrBob+4ZHTUC53OzHms9TG/zMw3ydiEEvK+wyD43N0IFTYC1wO4wyXTp0DuKE7Dw0MAJeyp4OwKTK12GgetMDtEUYmG2cPkdimsuxijihxZ+Dgok7i99oApJZsDXi6Rt0rpt1EvPyPuoRdr0QlSdJNGA9/ndqTuBhvorHXJGU5jsQqnEZWNMakp5ygfwrMLQ5eXKno3/xB6mZ4MUy+UVsjkSwdKOuYfagfTO5rpJ4WThxqbi4gQPW1PRtQ3kR6Pc0V7+3nlMChMn5jlRhobUNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoZkdLYsmgEuCwhHkrJw3kxgIcgHa49PU03f00J21S4=;
 b=fLVYok8NZQb6YQG5tmwOIDznWe26asGJeBDY3a7g6q5o5h8pDu7ugoeTLkcQJSSJeTQhunzXBUpwc5zKdmNMudGam5muag1sUSol+dst44Dni0BcoJ2aaRhSnYXpij4L/B3T4+3oHec6e+Kvw7/4v5RNHGIEPlciZHQngIaYDUc=
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 00:55:53 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::f3) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:49 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:45 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: [FW Promotion] Release 0.0.93
Date: Fri, 12 Nov 2021 08:54:35 +0800
Message-ID: <20211112005438.5505-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e339f1bd-9ed8-418c-09d7-08d9a5772d80
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55201AF649D0473DBB3E1386FC959@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEIFdvydbmvhWfeHnGicaSjfhX5oiFsdQbh1N0LOcKDpAMp9vs+SAydYwFlkBSR9e3moyT2TvzkSkzXe4TgSZFdd0rjPnvcuW+1eK0lA34hF5ApKlE2LYOX0iuIYriuNKXpCTYb/o7i00yE5dVM1rVyoYeUGkHh8/I6Iqm2Kat9V+dCMJ9TZe6APCtc7+/8mpCzExTHZkWqlTx4vxF38MBO3+sUw13TsdjpQ8YC9dxRkF4x7uPBwuvtw1DThD+eSoq5JRR8TJIs3a42vkZxiouV5B9a5bqKIQ8UuSyXGstgiBxyctTf4XI9XVMktaU1JN7/iwXpLhKEdp+M0ffMhlBqG+BXx5HDn1NeRqNTRQhzhsxXaSb2N/xY+XTq3AuPbrJ0Cmnms3K7KPQLe8qNh+AHqDCE3YmhtYxkHVN/YqMqFQ1X3GFaWSluzxZVwiAvuSezRnnxZXqywFOEJc3wXwJk8dedDtoB8zqANwc0cJy+ENo/+UvQzxHJLN2oIqc9I9D1DdPxGlTNSjQW+PCOb9KoxWc/+IggYJXQV51PGsutPU5h3sP62/6898kxoEwb+lWzqZHo1QZ4QnLDqFUVWUwWTrXTwL46ki0W3gXLlDG8niuOLYWe+OHSe2lNTK0pbzrMVurVHF+9evAKSXT2o7HsfvQ/mbZCeE8LO37JdXjEzZWon5NBC5xc9rl3tp38ECl6VSzS0QC47+8E6Rhqt2KbLrlengIxYhTv9puc+Jsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(54906003)(186003)(6666004)(336012)(8936002)(36756003)(70586007)(2906002)(70206006)(4326008)(1076003)(6916009)(508600001)(82310400003)(316002)(2616005)(81166007)(5660300002)(26005)(7696005)(83380400001)(36860700001)(47076005)(426003)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:53.1103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e339f1bd-9ed8-418c-09d7-08d9a5772d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - Fix ARR39-C issue with scaled integer addition in rb func

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 014ebd7242d5..20efa1f61914 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x058d3791
+#define DMUB_FW_VERSION_GIT_HASH 0xcd0e1e7a
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 92
+#define DMUB_FW_VERSION_REVISION 93
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -2726,7 +2726,7 @@ static inline bool dmub_rb_full(struct dmub_rb *rb)
 static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_cmd *cmd)
 {
-	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
+	uint64_t volatile *dst = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rb->wrpt);
 	const uint64_t *src = (const uint64_t *)cmd;
 	uint8_t i;
 
@@ -2844,7 +2844,7 @@ static inline bool dmub_rb_peek_offset(struct dmub_rb *rb,
 static inline bool dmub_rb_out_front(struct dmub_rb *rb,
 				 union dmub_rb_out_cmd *cmd)
 {
-	const uint64_t volatile *src = (const uint64_t volatile *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
+	const uint64_t volatile *src = (const uint64_t volatile *)((uint8_t *)(rb->base_address) + rb->rptr);
 	uint64_t *dst = (uint64_t *)cmd;
 	uint8_t i;
 
@@ -2892,7 +2892,7 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
+		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
 		uint64_t temp;
 		uint8_t i;
-- 
2.25.1

