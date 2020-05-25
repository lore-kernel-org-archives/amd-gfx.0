Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5825C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A172D20723
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LqCFWiz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E876E6E119;
	Mon, 25 May 2020 18:13:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3016E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCp1irxHdInYMhFbLUKH3VrKI2rNQ1MztSCU8ALhaY9UQe4YfW9IFTh/4L3JVlfO8jw62mt1z1vm0yCUI9aorQjpykKgPwZggHuQHvK7kHat69oEZYQN3ET70LaKoNWda4KOWyizl5TXMpNgvN2VhUjG1uZ1MzdRnEPY3TLxKE7MQUWag+CDhK95u4xClMmEo63cw0AuV2lYJdbQLKHh22heM79l7flhHcgn5LZaVIy/vK+KJSmi0OJVuAJT16Ogh/g8a8w44jb/pA5HWSratfXDueDbRpIaVh0TLVEF1dEFcvdqguZdXK8jmTzMRpSq3SHQkVZGLN7luZoQ9l7wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT9V9PN4uFB9vu/V2S3qpAqtjWwskbaAvc7V3fDxTD8=;
 b=DV3Gjc3UeaHreNAVKFSSdO3hXzNty2AAPHJNIDd1SW+bJKqqBiyxMMm/E/nUyY15Eq8Otrh7B2lZfTT658yt5byLmI6/+Xo+D1aqH1te3DhTZ/TDvSuiUyzvCbD7KMirbwb4r4xgXBwwGN0yD5FfYR1mHsp6gBzg499amE02tHgTSecyuDywNugXjrtSiKiogqzLv8LJMbYIZ1hfI/tdj0gfTiLAapYoWrtdvn1f4MogJRwHa1eZeFGBNyZ+VKFC2/uT61U4bzDG8VLkVtkc19+Y0SsrUmd5+zuLeDu4O0poTo70bd0Z5SgRHGkRdiqtUXvdFtxtZd6gPu/rFVTrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT9V9PN4uFB9vu/V2S3qpAqtjWwskbaAvc7V3fDxTD8=;
 b=LqCFWiz0msxnQf+tFgFpIq1BFZ4s9vMGNMANMcM5zDxtU4aC0prK5WPG4o4vpJurcUeU6gB6rCMUtmZ+/J94/7OfK22Fk08flb1viUYR1DoOLC1PYigfkPiEBwSV9Lp+S/XS//nnIKY6pI3r8EwRzZos+S3OSjy2H+2iP3VmTBY=
Received: from MWHPR21CA0064.namprd21.prod.outlook.com (2603:10b6:300:db::26)
 by CH2PR12MB3656.namprd12.prod.outlook.com (2603:10b6:610:15::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:19 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::6e) by MWHPR21CA0064.outlook.office365.com
 (2603:10b6:300:db::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.2 via Frontend
 Transport; Mon, 25 May 2020 18:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:15 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: [FW Promotion] Release 1.0.12
Date: Mon, 25 May 2020 14:13:04 -0400
Message-ID: <20200525181306.3749-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(186003)(82740400003)(26005)(2906002)(8936002)(86362001)(36756003)(478600001)(70586007)(70206006)(44832011)(47076004)(82310400002)(1076003)(8676002)(81166007)(356005)(6666004)(4326008)(54906003)(6916009)(426003)(336012)(5660300002)(2616005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22712ccf-03db-4faf-808d-08d800d74d66
X-MS-TrafficTypeDiagnostic: CH2PR12MB3656:
X-Microsoft-Antispam-PRVS: <CH2PR12MB36561953797FCDA9CA88D4FBFBB30@CH2PR12MB3656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyOjn2oap9qaamuMJFS6KS6NtTb2r0vOuauWPYsyD65Ov51b2Y8KEggYgJ3+GxIFHAGJ3zMNA0JdavnEWkphI3xcPRFm0eZwLIBsExHh8S4K2tHl0xgu3+irBOkENPkf3p1UqA7XhCphteNI654Na8EcOxD4yjMvIE4ZM1cxJE/ZtOLi+rzTNDxBKc+eEphd3Cq6IzPOn/eBvE+oY3Q4+TKQSBMYYHbOboiwnZhgxRLnF+icEMksp5oyS1KD0jQoj9q9q7Yzodw2fiEt0IoLZ6+SnW0xhWmoFyQpw+QAwJtE2pRSiw9bUmzwLCBas6MWkrSxMb7yTVzyhON/hh24DUpCrlP5XmjsTfOPLo3xngRjffbnf8I8LUGJWPN/uEzfzt3iJb/5KHb1YMLRQXBmGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:18.7857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22712ccf-03db-4faf-808d-08d800d74d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
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
  - Combine all interface dependencies between driver and fw into a
    single header file
  - Add FW Versioning to the dmub_cmd.h file

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 48baf92a1cb5..15ff4e471c3d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -34,6 +34,14 @@
 
 #include "atomfirmware.h"
 
+/* Firmware versioning. */
+#ifdef DMUB_EXPOSE_VERSION
+#define DMUB_FW_VERSION_GIT_HASH 0x718f63a96
+#define DMUB_FW_VERSION_MAJOR 1
+#define DMUB_FW_VERSION_MINOR 0
+#define DMUB_FW_VERSION_REVISION 12
+#define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
+#endif
 
 //<DMUB_TYPES>==================================================================
 /* Basic type definitions. */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
