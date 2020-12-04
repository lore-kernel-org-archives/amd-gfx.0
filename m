Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B77C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE3B22CE3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE3B22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885F76EC71;
	Fri,  4 Dec 2020 21:31:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5BD6EC71
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ9p7mKMrb/DEyI2WDrHI1nk/k58orHhDDxaezWDy1FEnudmbbWOCv9TqCaFeiGer/3/s/7+ebHZD8ALGauX3shqVrDlnRlAquMEuM9AZva8RgR139ecw+QPxcIjGju3i0fQzG59UZL1Pwnm//Ot60bq34xpVCkj+EPZRYycBjRpxRG13PqIxGM8ZsM0w3uOtkjKJVUUu9Kn84C917P7V6W6Lr9JOB+jd37vupmO5t2nw1TkgUlScGNKQpTEbBcwDn/QvNtYGrpVTuRrBo7pZyUcoyC09n2CH6Znf/Xj6O7a0Wvt9NS6tueSANwS9ETtTMfwQz8NG2kpcGN//O4TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPDaFJAKrnNqwR4hpUESfYvnzfd3RjXssqfBm9u04Eg=;
 b=fWyTDbhmsmKmruDmALWDyYRkX4SCY/YfdGv+rpl8t2ga5vNb/aiLiEhJmRdbVhur8Bdb8hbm16d+u8NPm3ONrvcUL/XyLZdMfI2PO7efO8+/QiKHSsInFKheHCq+wUPfHC+fdbGQ6uAVYV5bCNaoAr0zEB+J/DAb9YDO3eftC4krHfuJvMjaz2VRAfjRDyskxpsGb8S4MCv7m3ETK3Y3izu6Tg6T56IjlP83Ysn5G5YUsCCb+rvnp6cZy0aRO/djpCCVMgMG4fLLNXDXvTorbkbazSiPT1u35t/EsxHuKvyccbuUWqz+z6mF25ZhyiLNeR7h1KDV1cSsf+SLn5FgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPDaFJAKrnNqwR4hpUESfYvnzfd3RjXssqfBm9u04Eg=;
 b=Guks6BVGA2GwKV1701mXyB+YOt1CEfp74Z07fCHCsttbVivo6iMsp7fwe5VfDQSFUZ4ttxPQAXP+SqfR0ZeDiHhnUq1jaFiz0bUGcr+ioTsIFTDeKBHj3BEJ+s9bHKrIxolkvKBcjNrGSRJOe0c2bKvUcpxm8ZhaG9oVVh28FJY=
Received: from BN6PR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:404:b4::32) by BL0PR12MB4724.namprd12.prod.outlook.com
 (2603:10b6:208:87::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 4 Dec
 2020 21:31:17 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::b8) by BN6PR2001CA0022.outlook.office365.com
 (2603:10b6:404:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:31:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:16 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:31:16 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:31:10 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/17] drm/amd/display: Revert DCN2.1
 dram_clock_change_latency update
Date: Fri, 4 Dec 2020 16:28:48 -0500
Message-ID: <20201204212850.224596-16-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aecb36f-5687-4268-6235-08d8989bef09
X-MS-TrafficTypeDiagnostic: BL0PR12MB4724:
X-Microsoft-Antispam-PRVS: <BL0PR12MB472480EFAC6375BAAEF095BCE5F10@BL0PR12MB4724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zqfqn3zSDK/gW3Y3bVqMtKfoms9/tebDXz75WJBhI1N16qmLlziFf9cFVkWQpC5045b4yPZHgmSHcNvIYxhZ3Fda45W/KMrjw8XttmAin7xvN4xKdAv8+V12odKCfLPSy6C/tjwfAYdfAmsStIyZ9uGz087KnM+8HIN0oqDUSE8N3Sv1kxiN5Z3Ld3MmT9e1kxq2tVb2CDI9RgajYqiXhCVfaQiMuit2PSed8yJUlb7xwDho3nG4E61zJcDNI3beH+te0fBpgWn1P84PtHVh9eWmlhqy1r0jvJbIJNPaDMMMLMCkVJKsnlOoe+5VK3QoOp8tpH0FDIsKZyG5x5aGo3yHq7FBxZGoFDLoanddJPz537VGHlplJvXMLQJ8KKpIVJ1OIr9epnK+JjPxIkgLgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(6666004)(356005)(82310400003)(54906003)(70586007)(6916009)(81166007)(47076004)(83380400001)(36756003)(26005)(82740400003)(336012)(8936002)(4326008)(186003)(2616005)(478600001)(1076003)(44832011)(8676002)(5660300002)(70206006)(316002)(86362001)(426003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:31:17.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aecb36f-5687-4268-6235-08d8989bef09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4724
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[Why]
New value breaks VSR on high refresh panels, reverting until a fix is developed

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index b000b43a820d..1c88d2edd381 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -296,7 +296,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.num_banks = 8,
 	.num_chans = 4,
 	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 23.84,
 	.return_bus_width_bytes = 64,
 	.dispclk_dppclk_vco_speed_mhz = 3600,
 	.xfc_bus_transport_time_us = 4,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
