Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC1C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC4961178
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFC4961178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B13C6EB39;
	Fri, 20 Aug 2021 23:30:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AB46EB39
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrbbs7npl9QpC4sdKUCm6q5pULscniyFaOd83U5WIJ0ugG5Q7Z/Uv2yxevW6wMBjf0AtR6mEKuKgg+pdUFSS29gvZcUQgIJNqYyvo3SbKKDu/0/jni/3E1ZOPEHBaR1+DbLB8zZ4rU0YP8SKpEZrh37JonK5cCj8OBbHt78ECE0jvi/ZbXbONgvDW/RKPnmWLpfxJ1xY3ZSTGQYaxYL7XQFIzZUH0r0Ud1PaUUvnXSntexvn9Y7ExIXiLv4kELYkjLojUkNmUF8zyXAFsKLwjhVc4SqGPXfSXTdNhDyzMJA66Nlcn0eLV8KB/Ux19sH84ti+Hz6pJXgE7TyGrTJSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQgvww1XMoI+sF3fj9TFlg8pD71IWBrnSGUXsrdyjjs=;
 b=gKPQgxD/CBIskiupeWLCLwV4HE9AfmG2oNdsLGi+tgMb+LWE095AY+gEMYcR+OOtjWq25/5xiK59GzkIlwLnWNMQHIsumR7wzKMZ+S8XHVQ4hPblW/o2BSpg3bru4ZO3uwdEHq8vlBk3Y4XAnM3UEcvCGUzDESneGMmy8m1Adn5w2zznRZSDRvCAteOI+LXCYkpv0DE4J9HlkXWvytWlZTumfcr4F76A49dD1/tyW8YjSJ+EJS8UNGE3G25SgyUl+ecrd0jX4NVSFjnN99auqakelrzXm0/wO0O2XD0juc9Ft+Geu/P1ne9DCvsrCnmbKVbNrw2cTx9GILRcg1jI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQgvww1XMoI+sF3fj9TFlg8pD71IWBrnSGUXsrdyjjs=;
 b=qpFGNsPxQTPyhJSE91u+Jua/6mRefTGgNslDjUaTKl9vm/PeBXzsTW6rjd05q+AbcknBBFtxDTpTAHWHdx8kj3R8gNGV97Utfs1+7xwVENoCQvOYkQW3PMEApBPZos+DqkIiwsRHq2rab7f2+R+wkAsOWtZqNXyGFuJSlGlMwnc=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 23:15:46 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::c6) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:45 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:44 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>
Subject: [PATCH 09/10] drm/amd/display: [FW Promotion] Release 0.0.80
Date: Fri, 20 Aug 2021 19:15:19 -0400
Message-ID: <20210820231520.1243509-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ad5917-31d0-48af-9a49-08d964307090
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365D47D2379E8EAA718F8A5FBC19@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/UJodUF4IJRHxRlP8fTAt6fd404zDGzDpY/oKAKXeaaDVTTRyMVP4bhoynW6D4qnRV4dKJ+qsDWFEvqMOJOBBhtqTIefpPx6JIVOHDyNZ2bm60KOAgH2VyJdmRHL/B8sk7nA2wuUuRd4mskduWZBzlfc1ftjbhHRzM+OCXJdEwRCyquVoXkorP1TbXNiVv3uCGxNK7usJG8F09LJmVFWWDvNZSlScgpM2aZcjlOuT1e90TJN1vr3Lf1jVILfK1Hb8VjYVYyWMl/wx3VcPF2aeRnN8b3hTSu/W2Ikcx18d0cbf5LpOx2EOpnvMGi9Hjb0yX5ghdr2cgGrKyG4WWbk1J/QEhSyxZn2FhyoFYoQx0vqd5KBMvF7N1Ps/LrSlXmMbhMUD1/kO6BrEETy/EnsZgBs2Y5IFP4CmzNWTfHogyF/hLhU4g6ckQqZYZ6E+6deUeHoxvHN2mZLvQsDmDxLwuRGktz6ouV4s5619eZ6ON3I46vE+u3zJOHDVBtXNxsOmnU21myKB/WQzBlYjE/CTBseR4SuzpG76Gq6AmDkbZBRfdVC2FKPkCx51Lb/n1MRrDmHYiV3xephTXDaIxO43e5gDtpdgc2O+faL3PzKMG1Y4yWgWq5MlQ3c58N/KbKbS6o7sKgF+zHvtpqgpZfuJsf7+BZnojP+vGiKILCxdlF1PyHtCdDJZEJJiPLcnGn1HgNgiXGpi1MIMyjioTOgg28ChOWcEcB0yeNjmbOlgeeKDrbtvXfL/bcxYrJ0+PsKWK4VN6icb5r5fnJLrElXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(2906002)(5660300002)(54906003)(2616005)(83380400001)(1076003)(8676002)(81166007)(36860700001)(16526019)(6916009)(82740400003)(70206006)(82310400003)(356005)(34020700004)(6666004)(26005)(478600001)(4326008)(426003)(186003)(70586007)(336012)(86362001)(316002)(44832011)(8936002)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:45.8938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ad5917-31d0-48af-9a49-08d964307090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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

From: Anthony Koo <Anthony.Koo@amd.com>

- Add volatile to avoid incomplete flushing of data in rb

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7b684e7f60df..b322677dafbd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x7383caadc
+#define DMUB_FW_VERSION_GIT_HASH 0x591aacca1
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 79
+#define DMUB_FW_VERSION_REVISION 80
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -2485,14 +2485,16 @@ static inline bool dmub_rb_full(struct dmub_rb *rb)
 static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_cmd *cmd)
 {
-	uint8_t *dst = (uint8_t *)(rb->base_address) + rb->wrpt;
-	const uint8_t *src = (const uint8_t *)cmd;
+	uint64_t volatile *dst = (uint64_t volatile *)(rb->base_address) + rb->wrpt / sizeof(uint64_t);
+	const uint64_t *src = (const uint64_t *)cmd;
+	uint8_t i;
 
 	if (dmub_rb_full(rb))
 		return false;
 
 	// copying data
-	dmub_memcpy(dst, src, DMUB_RB_CMD_SIZE);
+	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+		*dst++ = *src++;
 
 	rb->wrpt += DMUB_RB_CMD_SIZE;
 
@@ -2601,14 +2603,16 @@ static inline bool dmub_rb_peek_offset(struct dmub_rb *rb,
 static inline bool dmub_rb_out_front(struct dmub_rb *rb,
 				 union dmub_rb_out_cmd *cmd)
 {
-	const uint8_t *src = (const uint8_t *)(rb->base_address) + rb->rptr;
-	uint8_t *dst = (uint8_t *)cmd;
+	const uint64_t volatile *src = (const uint64_t volatile *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
+	uint64_t *dst = (uint64_t *)cmd;
+	uint8_t i;
 
 	if (dmub_rb_empty(rb))
 		return false;
 
 	// copying data
-	dmub_memcpy(dst, src, DMUB_RB_CMD_SIZE);
+	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+		*dst++ = *src++;
 
 	return true;
 }
@@ -2643,14 +2647,17 @@ static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
  */
 static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 {
-	uint8_t buf[DMUB_RB_CMD_SIZE];
 	uint32_t rptr = rb->rptr;
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		const uint8_t *data = (const uint8_t *)rb->base_address + rptr;
+		uint64_t volatile *data = (uint64_t volatile *)rb->base_address + rptr / sizeof(uint64_t);
+		//uint64_t volatile *p = (uint64_t volatile *)data;
+		uint64_t temp;
+		uint8_t i;
 
-		dmub_memcpy(buf, data, DMUB_RB_CMD_SIZE);
+		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+			temp = *data++;
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.25.1

