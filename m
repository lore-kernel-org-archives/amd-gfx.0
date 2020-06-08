Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96508C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C69F20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="td0nMIEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C69F20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1712D6E48F;
	Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB4A6E47B
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKJfijs/kXbpGh5vQpH3a96nAFsWBCYbCGYA9mzse7d4Mv2+bv1aDbB5SOCA7LJO0suhwMRs83Skkn8MsMDvK7W4Fmp5e7ejfS3VzS98nyaIVTHLJ59zFjhyr4bbjnMcTfCS2+m5s5htnZ/kxvNTyh5hbNMw3xs5A31MWBhxvNLnNDiuMeMYcTpJflxlWX66kE3JdQ39s9xX+7r6cPw3R6nS8+5h7gd4YEZj7d+L6P/0a4wFI3Qi9iQg+CApK4oKKzR6hPvTm7P6CScqlUQ3p1c619/vxGireif1k6VNwZT1MerOdGo+VGLb5xV40724U8lnX5HRrQPj5ttIseak4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkZDZ95/wgZflKj8BjJ0/aSrko5Z2UL8OPPdzqWAy44=;
 b=GdhbuioXdwuxiebN6vecmErKy6B5WNlhVLQIYWJWz4e7m0c70LxNJjG6rKZGEYxLVJaTQ5VHsYaL/rVwjacA3oQCxcuS8lC+R5ROKU4OIyeOqcccPIE2r2SDpLVfvJ+xa0AbIWbm3IeD0HD8/PERquNFS5aJPECLR4Hk6mcSlQyeSCJY+l7+gT+b/WqLw8UU7mjh3CZ15WsUE8TLjYKfpwGd4GR60QpCQ37jP/lipOu1jZBapvMve2eCZ9FRPjoyyC8WAYPC8IaZ1892nCvpGFNJqavQxCyZadsYxG9SeaxpAi5nd6GkYgXL4t8XFAuo7CE2FOfxWt0JNJIV3JGyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkZDZ95/wgZflKj8BjJ0/aSrko5Z2UL8OPPdzqWAy44=;
 b=td0nMIEzL25iY0NWGzGwDC3KQ7A+NSUtiIpaFSSJv+dYYmkcf/wja1uhk2Neqe9XiUxHW2E3TaFzYA9uxnOdddjtOtMeTOyzjhm+W0uihOWk2XB2arF7qpuwtHCpRajh2UJhnKYguLaxu3XVx3QuetKDRBxovghPUb9EvN9iTw0=
Received: from CO1PR15CA0094.namprd15.prod.outlook.com (2603:10b6:101:21::14)
 by BN6PR1201MB2528.namprd12.prod.outlook.com (2603:10b6:404:ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Mon, 8 Jun
 2020 04:59:40 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::59) by CO1PR15CA0094.outlook.office365.com
 (2603:10b6:101:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:34 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:34 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:34 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/28] drm/amd/display: [FW Promotion] Release 1.0.14
Date: Mon, 8 Jun 2020 00:59:09 -0400
Message-ID: <20200608045926.17197-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(36756003)(186003)(8936002)(82310400002)(356005)(70586007)(316002)(478600001)(54906003)(2616005)(426003)(26005)(6916009)(44832011)(47076004)(2906002)(70206006)(1076003)(86362001)(81166007)(5660300002)(336012)(82740400003)(83380400001)(4326008)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a38f993b-f044-4b2a-b6b5-08d80b68bff1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2528:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2528BFD4319EEC0BBD92698AFB850@BN6PR1201MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi5LyxMGZaCM2psvgT8wFf7Z+BBOVqvm428tu3LCpBF/F70X7+A6cn13O/o+Jp4peth8uCqWR4WpXptcfewlcWMYMz/Pe0Oi7Pg9vcEZtt8r/4/nMLPFPBySOFpQTusBRX4NjrVxBaDbCRgj0bJA3v76JM8LUj6Mn8gAtVn5XTDEsvDOmKvOGkg8GwMw184s+Lhwr95+8SGzig0Vo1dyv54bpD1OtGefiVmFY1GgxGSyr/UfAjcrfjWzPdwkdSIlm6LUl2GSxUp0+v0lRYqhWqkp7s5QvjVQfz4HQ+qxHPzRHv3mWDI4eLsdeRQ+sKv0PIpik2R2USXmxghAuVB8bN9civ9cZsMHng8fnk7okZYxieu/g57vO3GKur2E6rJAZChwuCdDQI1fGT03HAcM/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:39.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f993b-f044-4b2a-b6b5-08d80b68bff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2528
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
       - Add SDP transmission deadline for PSR config cmd

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d04d2fc9ea61..5066c639670e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x3353119e1
+#define DMUB_FW_VERSION_GIT_HASH 0x5470fd231
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 13
+#define DMUB_FW_VERSION_REVISION 14
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -421,6 +421,8 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t frame_delay;
 	uint8_t frame_cap_ind;
 	uint8_t pad[3];
+	uint16_t init_sdp_deadline;
+	uint16_t pad2;
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
