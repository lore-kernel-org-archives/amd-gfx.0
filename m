Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5794EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1687864D92
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1687864D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFECA6EC3E;
	Fri, 19 Feb 2021 22:16:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4C86EC3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDMC9pw7uGrf1Os7Z4zU/f9zKq1pe44IiZ7yP/6gQT94oxpzsZXSNqnE9OyMatQ32l/k0TRUSayPNIhKnlBBHU8HduZPFhmpu7ljDyvKDgCmFELyxFERCchb+97/bgjteTI0A4GCenWLC46dNx24aUyNZnTGJRAPtsN7gmtELsKVHfM0trwFEm7YlH9JpH+WFxgz2CzDhukc6lVJgPCAqwqWr6EuRYe2uej9TjZWk5OtEAnBIL1Zo9d6up1BhZxxSmLP87HkkFu8Mc/6DCa28dKBmBol4ALDyygIwuEj+4IFNFuxxY5jS9sXf9g37rQ88vf7CrR4wiougEwqICtPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z+QW6jrVG6Q/NoAy629EGVg6BdZ2QHpmKNtK+vpd9E=;
 b=G92P+dvZ9zVNXJ1ho/+++iuB7gF/X59VuF6HLmfNkmchkNoA5mahIJBnUScFFbEKUPMyEK0Os4vDSd79vAkMT/VCD6C1RWcg4NKfLaGGqMV739OE8/AtElF0xLtCouIP4VVvZGqlKs8C32fBdDkd/1GqujuXR4A1SIYXNkBQiTul+k7JShNT6ukWyFAC/o+uMWRAOHHQlb0F0Exw7HYJSgJ6SSoB3sqU6CtPRPgDDqHQK+2vrDpsNYCBdt39/r/jZRaz5DAfGCN4CD+EVVUeaSLTCPK5LeBHUOwy+TJRU8I98ILq7sHt3Jo6RV4WeRSWidNCan9yXbMeJrMsXYN0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z+QW6jrVG6Q/NoAy629EGVg6BdZ2QHpmKNtK+vpd9E=;
 b=RdfSC7abAYv1mTC5OBjM6svuOYXu+wg7MnBXDiohSRDkV8gINjig0v7wgN4NODf4+NxgammYMHvsCXOUQFmL6etbUcmDlkuHpfQPtJ45i85/c5vqfFSYiQ0cxUAXcLqZBwq+lrtRNCaKTATP7HosbsNlX1peVWM/ox44nPuTIK4=
Received: from BN6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:404:f7::14)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Fri, 19 Feb
 2021 22:16:50 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::8d) by BN6PR11CA0052.outlook.office365.com
 (2603:10b6:404:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:48 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:47 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: move trace buffer to uncached memory.
Date: Fri, 19 Feb 2021 17:16:06 -0500
Message-ID: <20210219221612.1713328-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467609d6-28ea-4c0e-4f1f-08d8d5240d72
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747D29A9B23DD684BA1F67DF5849@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJbcE5En0wU7optIIswkjgmsrSaLwowXZcBC3XTDZpxMgOXgxktve50xWuwov3CzKFwv+6xiUkomoGOaPePUWGwYB+aSNC+cFseRjRIN/dO62VD2KjHQ0MqTx9PPJwZ4eTnmGuhE4NgcLstvK9VXAFlyfFWfqnzE55eu2Yi8O3L6zonKcMZWgRQfAIDDk4V8xDPrIikEQdihyhQni97JTC2gTNvjln77xbHxQb74/ELZldff3p8q30lNMrGzG6gMypJ5O3WpjARP7Kd8VHFNvyvxTTSDz5vFdiWKpt8B/G4PZtwZzh1QNtsP67s5Wvsh//eOjRYa341T4s6yy3X7JOf6Ssm52ixDH1hbF1QFEHYwoIt47lQ2RSxmHY54PHG7PAQVTkZY8fTahFkWXepfBMWQoq1mTa/YxL/zLYbmUUmXpUx9YF7qH0JxCidMnJiT4LQmyRU4DpMPqOiOegDTinQsS74zcoVdm9xRfasWe0fAKx6qqKs79yk5QtanNJoziQX/KHll9zBenQKUYF0IhK/vxTQZrdnIrzhouVi4Kc0VJSz6w+kwfNyZCXb75ulHpHd8+dURyz7D1j9jeGcBKV6D53gUwVm3oWjAk6oC6N8E1lQGJOKavSuwGQbMC8VOihlqQJyljVuAUCMNvemWCGfjt0XrUnXokCe9f0ep71w+mXVfiuuZRbVJIFbVjs/r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(26005)(54906003)(36860700001)(82310400003)(5660300002)(8676002)(47076005)(8936002)(478600001)(1076003)(70586007)(426003)(4326008)(7696005)(2616005)(356005)(316002)(82740400003)(70206006)(2906002)(6916009)(186003)(83380400001)(336012)(81166007)(6666004)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:49.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467609d6-28ea-4c0e-4f1f-08d8d5240d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Move dmub trace buffer to uncached memory.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 7 +++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 7 +++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 8e8e65fa83c0..ea30da4f794f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -248,6 +248,13 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
 		  DMCUB_REGION3_CW5_ENABLE, 1);
 
+	REG_WRITE(DMCUB_REGION5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION5_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION5_TOP_ADDRESS, 0,
+		  DMCUB_REGION5_TOP_ADDRESS,
+		  cw5->region.top - cw5->region.base - 1,
+		  DMCUB_REGION5_ENABLE, 1);
+
 	dmub_dcn20_translate_addr(&cw6->offset, fb_base, fb_offset, &offset);
 
 	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index a62be9c0652e..30c6d631a431 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -75,6 +75,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REGION4_OFFSET) \
 	DMUB_SR(DMCUB_REGION4_OFFSET_HIGH) \
 	DMUB_SR(DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION5_OFFSET) \
+	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
 	DMUB_SR(DMCUB_SCRATCH0) \
 	DMUB_SR(DMCUB_SCRATCH1) \
 	DMUB_SR(DMCUB_SCRATCH2) \
@@ -123,6 +126,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
@@ -200,4 +205,6 @@ union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
 
 bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub);
 
+bool dmub_dcn20_use_cached_trace_buffer(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index b4bc0df2f14a..fb11c8d39208 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -180,6 +180,13 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
 		  DMCUB_REGION3_CW5_ENABLE, 1);
 
+	REG_WRITE(DMCUB_REGION5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION5_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION5_TOP_ADDRESS, 0,
+		  DMCUB_REGION5_TOP_ADDRESS,
+		  cw5->region.top - cw5->region.base - 1,
+		  DMCUB_REGION5_ENABLE, 1);
+
 	offset = cw6->offset;
 
 	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
