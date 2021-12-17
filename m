Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A63C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874CB10E5C0;
	Fri, 17 Dec 2021 21:24:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7122410E4E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khZHvHIx2BaDoTxDeVspppp7GL/+uVh4YZgo4EzbhYYdp6Gj0eysbov/fTHLtpB0kNbitB/szaFgYzyti0JVR2JyoiM7UY8v7/LrMuZFBxLbJuU1Q1JXFkjaIsyYdK+7NaFr/yKpGV/9esv/Iqw6MngpH9xxTuHmrPf2rUemE81TaiT2zDJwL8/SPu6DAkelEwk3gLpM+0wKk0rNm59idm9bihtRbL+cb8AHdKou1kBpou4sZhohEXrlKdMCeTWJufcVFtsKNQU4XKhtSHnYigObWO7Pw021DWt3ds4ipDha0RI2ttiuI7O8u4gEK5P7oswkOpeit9f5RcPUbzfZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD+tPpthSmxWw6B+SO8guZ1p+Ke3mULq7mAznHs4qUA=;
 b=HSpKL2N+dJeljxyeM8i7fksShISJijBlT9SJzHtkyuEciziSooolUoLIugIJAvSsj6uoawB1GUJ35R13Q6GZhv4D1YgHdHZUHKAeJIg9ERieie2xONJiY/tVOijNil5YOZyX+bfKraN0rMtb1YD22i9SYs995sMZ0OygOgl6F1yzTUifJzMBO/w4rGbTDEdKKmcryOyf6Ncc1169mMij6PNoUh5s5sq59j8ykvotAZA5OvTbRcV1KgBs5KCI9KD4JeUaTbkjnoQIq3ryiUzlpoLxId2eWo87JXhma+DqcSUF4XWn4fyYh3H1gyKP1nHMnaMQR8g+JJFV57tItF2TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD+tPpthSmxWw6B+SO8guZ1p+Ke3mULq7mAznHs4qUA=;
 b=Q/tG8jNcOfbcx4UvZdBL8o1kk+Iw5+XOBv+/TKas0NiNWel6AK+t4b8Sl/fpjcyMPLVXDFGyJGYojjM4AC0pBWoZNqVsE9NPaxsYcFpKfAwwdgTMP6UvmOf6RYIGHQx1O6SKe6ZOfEdg/b0uJjeGf66m8IueZYwErxK4ehJ2RLU=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:27 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::47) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:26 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:24 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Limit max link cap with LTTPR caps
Date: Fri, 17 Dec 2021 16:23:50 -0500
Message-ID: <20211217212407.3583190-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55688bc0-6617-4161-310b-08d9c1a39a68
X-MS-TrafficTypeDiagnostic: DM6PR12MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4236C830D1C28CCE5794AE7998789@DM6PR12MB4236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiKwZ+9IUu7rufIeSv5/Ij3hCqE86rg1+bnwKlmOr2JLsSLL/UBGc/t++8MkpN3c51df9JqwJ06+A60EnMt8LydMZQeVbytWHdvNmX3KJL/2x4YXbDPke1G9513uhvk5pq0oD02NRk/P+Bg29qoTpDu7g4Lg/I2bnf2wOiNT9GX+FSJpkmMlwI9BlETu+ohSB1I9Vhw5NjgoBgAFDWoalKbrVX5i9ZLitL3lybY59pXzRnOuF5B2QAEtHeXRUqZHgAOf/OGlvAzkBJw5qfe4TnRL7X4b3nQv9iLFDQEFn7ZXIZmafIhjQE6f4YOF9yqm4vqPx0Zf/DfvIb2ikNKhtT5BnaXvC/vs0UBr9Apk/MWYG5SdWx7WVMAM5df+jN8T6M9R7GX1y7HYVSI7955Xpk6ejalA8oVcfvqZOeUINjdd8XD3yFHortDwLTJZ1OG0QmI9hhnoX7v0jDbCY2FKq52xKFo/Eyo1gAg44MYW4Kd5l15XjAdzYzsf6kSQJ5TCMxhOtT0k6I1kRoqBN2jC8SNndGTN1ce2Ria/27Pqvgpiu5hYMzBUlMDW2pWVCaqzXOM05r2Bm7EJPREZSYnXSIhzjgfvlWIJ6fvhAK95n2qP0RUfu9xp50m4S979UHz+XvqW+yAXxGaKVKR5fgzAw7y2RkCHTRw6m6YS/bq4LiG+jJidaQh7KvzIJojllBTGyEYT5ud/UhUJrVKIJKflhb4ikFCVJPLYiwEGyFcWWfrEBwGjQ2uaxUO22JnhYd5dkVUhI7ZJdUIIXxA8sT8/vV3dqIQCeyJaYIWFFVv80DA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(2616005)(70586007)(26005)(83380400001)(426003)(70206006)(82310400004)(356005)(5660300002)(36756003)(1076003)(8936002)(36860700001)(316002)(16526019)(4326008)(2906002)(40460700001)(47076005)(6916009)(54906003)(6666004)(508600001)(336012)(81166007)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:26.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55688bc0-6617-4161-310b-08d9c1a39a68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Cc: stylon.wang@amd.com, Wesley Chalmers <wesley.chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Max link rate should be limited to the maximum link rate support by any
LTTPR that are connected, including when operating in transparent mode.

[How]
Include transparent mode when factoring in LTTPR max supported link
rate.

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8a35370da867..6f552f7ee1db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2873,7 +2873,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (link->lttpr_mode != LTTPR_MODE_NON_LTTPR) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
-- 
2.25.1

