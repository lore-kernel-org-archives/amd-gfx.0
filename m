Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDFC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BB164E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BB164E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017376EC26;
	Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1097D6EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD1ajOQ3i3RGeNX5YuIeNacdRA+HS//HDyTo13Y/wQ1Z2sdFfZ5PDZBoIiBEpPttVfnrBwmqIGBgiCtvb8KqQkawc/+BGDlkZ+KLeVby6k0W2tLCk/XJ0BNk0G+N5T37AcZ0nlQ2oXKnNq/XFeB1byumTFFlXEartKSSwkCMD3IzmxqdpKYjk93sYW0hLvgp70HJ/AV8HLxqF8UO6uquAQvW2XEGDgg36+iTrght6QQMiQbO3Soiu9643w85pE/UxBoDXQ/TolEFPX7s4L50rGzvn5zyQUY2Q53gIKODkWUt6iMs4No5UPDx6o8OLjFkN2NfeViZIO193ClnidPz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTNJ2uFRiljS7TON9+kYe7Fgr2hdCYDd/a+ugmQHWx0=;
 b=IwZCZSPbHNl7ilVYfgAcg6eP/qxxe7THQkJdCcSFvN+s6qYV4CL/qE/pCdFvelzoeSoxkBoQ2N4z9l94t5k4XJNJraqi0W2KeBpybQ/StQS93i3pUKZfMxCek0oBYXRYzb6mwLtTJBmNWXuc+nRdNv0Ejgj3fICMYKKWEPaCZWB/3D1q7kfTlei2AZX7cG+vDOTn9Nh0gpVp/hGJUPsvdIJzQOwaYWz7xgjFihgXLBuG1IJXuuHYvg49cmy88UGHVxcRWHBgAuV2zII0UsguCyeAA9XsLP1+T6PVPdSMf8rSzDoFXEJa7SuwwiKJjfLR1+wfWpNpHtRhJV5WTnSllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTNJ2uFRiljS7TON9+kYe7Fgr2hdCYDd/a+ugmQHWx0=;
 b=vySF4xoAq4JO0mrSe0VVBucMbq8CJWEkOQxmifg1VmTQGfNxOi/woG6MXoT7Wst7q/ZJ2h4cCRtJWnCIGVnBc8WyYGVgyDucDc79ugxWTLKlVhpr257nxC5PksT0COG4XmpxgwI2BJ/uVu+l08Wqmiho31qjTtf1L+5LXVShxUk=
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:11 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::4b) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:07 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:07 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/27] drm/amd/display: [FW Promotion] Release 0.0.49
Date: Fri, 29 Jan 2021 16:27:34 -0500
Message-ID: <20210129212752.38865-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbc339b-1fcb-4c01-0b32-08d8c49cc6ae
X-MS-TrafficTypeDiagnostic: BYAPR12MB2901:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29018C70CC91E58E11728C84EBB99@BYAPR12MB2901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqOqd/s1CFt4Oz434vZ+hCm0DCnYrzQq/pSe7V/Hkek2DdosViJrpMSACtU+Fxx5cmWMV7NOckli5UzdxW+bKrUdJo0PrBgWMJjyH+FL2GqObLddzCoKb2tZgCOYBh7v5MTLubfquAChNleObGj6pkt/qamcvNv4dPr0aU62OPVjUxH8sZuN6J1Q0tO4TYBmcKeNGLINlGR6ZaIq81Tdx3QFhFoAwFY0Y1J6hKyUoGtgcJ9LR9pMmSFdmjcrqzkaamgZ5EQlZq2PFdvHon80M3PVa/CE7ly7Sbtv6gMVIzJZapM/VkewnRoTpGY3Mh5uUQ9461Rjlc788jCp28KJ3noTTI1ueOmxhmyAB/Gr4yDlYV31AM9PhYc0DuRGpRjPbcetcfkurxF2Yl3dihAJQoFvVjJKQB4cfors0r+wTa43TA5DXpCjCKERc62tpaf9fQUJR36erFwOgvt02xC7WaDDIqW6BRSOHhekiZgMCu3z4VvoDQR6iQ6ye4Gwjhns9VaDofEw7RPq6T45ns0crVdSeypdz8MbMqiRWSMhjWGh9WG+L4//GpQ4ZmjGWgSvL4i1UgT/deYnOhJqo9jMRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(82310400003)(4326008)(8936002)(26005)(70206006)(8676002)(6916009)(83380400001)(478600001)(5660300002)(1076003)(70586007)(6666004)(426003)(7696005)(86362001)(2906002)(82740400003)(2616005)(36756003)(186003)(356005)(81166007)(54906003)(47076005)(336012)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:09.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbc339b-1fcb-4c01-0b32-08d8c49cc6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add field for passing line time for a frame

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 98dd8b5f463c..dbfa2ecf805c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf09c02ae3
+#define DMUB_FW_VERSION_GIT_HASH 0xf2f2f3a96
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 48
+#define DMUB_FW_VERSION_REVISION 49
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -653,6 +653,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t multi_disp_optimizations_en;
 	uint16_t init_sdp_deadline;
 	uint16_t pad2;
+	uint32_t line_time_in_us;
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
