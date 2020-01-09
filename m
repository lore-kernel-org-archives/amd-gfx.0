Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F8BC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 07:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CF4206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rkAT7p3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CF4206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3AB6E3A4;
	Thu,  9 Jan 2020 07:12:59 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2026E3A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 07:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixYJ9/TE0hgSAID9eH3slIqcflgGWCl/H4iVW5e64P4vInLBaRf64RdoiXedycBOP8dux06nd013rOGZo+yBFMyZTaEGi6qVsEbboRWsEc0Uy/mH33FJw8XgJoBy3GMcavOLFXBhU47qQ9v92w5R9+z1uGXbg/pSIFnSJOKXG4Z7xxvqLglRKmiHg8mFsonuFdjV9x4jpyhHMwDnIuG9H6dEBzqWAQahDbADAIqS0F2RqnLVDLhoanxHOv/Mz3WN9gmdkHmhhNyDfJV7HA6ZxjJJiVM25o/bjnqvWTpPGicRbu2/adH52cov92cCKMyQiA7wKfVeCsxYpa3oWCaGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYVWSrS21aj/8Oqh7Y5/RU7yDSy+sH3EUI1JIpwo4PE=;
 b=YTg8vUo+BpPv3caAKwOdgCXS9ia0HlzDVnJkZh96jRE1OMUte4OCNcnt/0senYDXph7yqVoZgEc44DoPcktgbNSGVwTEgtXQeKJljEI2VvLi0kZ3HcSH22sNWuezgXaB6/B5GCYl3LggF5Eptw1TniYbG8B3poGCiuhyFqVXbIJ0s4ETKub2iu5MKZ1p08XL+BEpCCw3q0+UkNBp2og6/gnNR4l4Kqi0IjU0T4ZLhQkVH1tpxen/LaC0R3EBeQYZ7jqOlWe3Gi0/bG7wWu65cegqIuhXUtSyCK7k+E1TxSl78Wa34hSb9aNzsIwqD2+7PLuANKBtnBMBzWqrZyJe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYVWSrS21aj/8Oqh7Y5/RU7yDSy+sH3EUI1JIpwo4PE=;
 b=rkAT7p3nJSpP4azyOMrEaXXOo6o2GrlIESqw4ktZJCEHoIqXICXW2azxQwtSw8aq9y14t/Y7+WEPQ2QJjRbcI98Tl1s+7CRCk8AWGuXU7oUQ6bLp9Kala1HLJxjq8U5QFdrkAjlzDoELA9YOvk3pdRtZBaonFFfoOpGUcL00gYM=
Received: from BN4PR12CA0005.namprd12.prod.outlook.com (2603:10b6:403:2::15)
 by CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Thu, 9 Jan
 2020 07:12:55 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by BN4PR12CA0005.outlook.office365.com
 (2603:10b6:403:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Thu, 9 Jan 2020 07:12:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 07:12:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 01:12:53 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 01:12:53 -0600
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 9 Jan 2020 01:12:52 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/powerplay: sw ctf for arcturus
Date: Thu, 9 Jan 2020 15:12:49 +0800
Message-ID: <1578553969-30579-1-git-send-email-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(189003)(199004)(478600001)(44832011)(6916009)(7696005)(5660300002)(26005)(336012)(86362001)(186003)(426003)(2906002)(356004)(6666004)(81156014)(8676002)(8936002)(81166006)(2616005)(36756003)(4326008)(316002)(54906003)(70586007)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3910; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ae4954-a4ce-431e-13ff-08d794d35903
X-MS-TrafficTypeDiagnostic: CH2PR12MB3910:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3910A7780912EAF00110B3F98E390@CH2PR12MB3910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d79/bsoyTkD6Q9dQTEtePR5Ik87c3NarivRR/0KfL68pN6+EazSp8lgs/s81n3hfsYBqM2v+oGbpTTS8OWzSmkZoPC7siZDXpXHAyM58v66RXlmPpE/d/lpYom3czPJaaepng035HNRsKboSFbjK64LCKtcSMstczAlT0IEUN7tITHifLZ62qSxb+yF/L87d3NzWPra1rv9ngW2Par3YSZfeal3OW9B2KarxhIn252Sa6sjagSljrL9qZzpKY9146sI5RXPTPhTasxEmkjgoJQxqp5Bjrosjc1OXOaJSdPY2B2qzHdDMi9wescC4AYVyGAZplj1981BJLOw6xpWXwzGn+dC3wbYezaw6xifecMeq1aW1g7FLX0GlHzCq8olHrwTJnr0lfohzPg2p5bRuV5eXuiOJBiI+qqEgn1WXahDHzI8lMAfkglUYTX/2UHfK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 07:12:54.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ae4954-a4ce-431e-13ff-08d794d35903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
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
Cc: evan.quan@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change the sw ctf setting to smu_v11_0_set_thermal_range()
since software_shutdown_temp shares the same definition and
name in all the smu11 project.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index e804f98..76bddd5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1154,11 +1154,12 @@ static int smu_v11_0_set_thermal_range(struct smu_context *smu,
 	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
 	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
 	uint32_t val;
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
 
 	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
 			range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
-	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
-			range.max / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, powerplay_table->software_shutdown_temp);
 
 	if (low > high)
 		return -EINVAL;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
