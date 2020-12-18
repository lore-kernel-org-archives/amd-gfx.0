Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBCBC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8309023B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8309023B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7F589A76;
	Fri, 18 Dec 2020 22:30:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555689A08
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naBp0U06jLtkAd12TGV0NOe6tXjxNTHZENTOeKKT5h3upjYxV70yb5TTqUWrxwF8Y3PF6/7jH6r06FZe+uESAvK1XuoI9S09ZV2rYp6RquVblfWzQ8aXALVPKv3eVtYeEy5qGw+eJt7SSo16R519Tnhe94jiJjBICfIOmEQ04C4TpnBXQoxwfZpuDzzgMiiJDv8zTx785PnvWNh+aDF2VITskyYpyg0NOvzaus6R8lCzM+Ej1u29W120cLrHaSYMRO5Wq2WvP5P9QwCSSyGD5qPAJftPWtBKTKVRztml85noH3hj9X8CqU4F+/IvqlVY8vsKesYvcqNw93dYlN3cTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPJi1TAgP60DurtQU2kOB0pyRaNhyfIdYV8zJ5+O5fY=;
 b=eVJ32L5Ww+WKfjcz9KdspOLG6U0wb4Qm1HC4W0zgush4xKhDspmQ62gzl2/JpKY18PVEcc50IKyVMSfhOprPaV9XBLHAafv5tt6goZiMPrQKKfT7yYmYQwdMmjiiOfZtvu/ps8S2SQybAPnvEy7E+g2SYXTak0wufbvwnJknjfyGdgoig2br7hO8ipG1WzRYxf5iLBn1FA4mWmeWZ9nQysYbw+Ppy42vs7CfLUBcdtxofPs/Z80A+4Zs3La4aEHzlLoN8y5CWExEE3mzB618NgTk7n/QGyqWYwMonI7ith0dOvB2R0iBHXObupuuV+JndqkcciiOqnpclE9vYuBXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPJi1TAgP60DurtQU2kOB0pyRaNhyfIdYV8zJ5+O5fY=;
 b=ATe8fkp0Gap0nuqi7OCDL4AY99EsMVyZF6tnSR8U9ppPWIfPAbkpxhxupGMz5lbiHUWxoqTl2wgnDaxd5QS5tIqGZgOGmA/l1Y9yZhDyrjVJVCSaCbylmymXYk6qRhr7+nSdiJFKYzMqtsxu6Jns6k6BymdhxxlItTeLQlNna9I=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 22:30:06 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::3f) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:55 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:54 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:53 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: change SMU repsonse timeout to 2s.
Date: Fri, 18 Dec 2020 17:28:56 -0500
Message-ID: <20201218222904.393785-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bfc97d2-8910-4557-7ab0-08d8a3a4777c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:
X-Microsoft-Antispam-PRVS: <BN6PR12MB129751502678AA299EA66962F5C30@BN6PR12MB1297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrtH/5/bLJBFH5ImXL7wGRxe/Nkam3fr2J/Mwceti5RJP3IYqCrI7GA5jeMSwTTk8OPDfRY/spXJtAuBzXoFsfZXZ+RtK6MYrZXgPcQ9D1gZD8bPuh1hBUwfTR4+VUMlHj/5fnTvcze1CF+W95CeSZ2SDtv6aNm3hEjaWCqcmKA6QXwL74fW8fo+XiGiX0Wy93aTcjCb4Ni6WsLgzUQybL8kY9qxh9BvBl0VlzDozia68gsMbIMDd5wwIaQ2KDO4/Ic5jPTi+OQWnU4w15hbbUGQDnqszjYGG3L2nV95yGH0Ms4L1Y3w5mA7Ux9SX9cEuoha2jylkLzJPbK6oZFjeAGf5nxdVVrM6schFHapWZE/NSFrfQ+KGmksjVMuBSSJqYH93kgGUgDa5x/z46DQ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(7696005)(426003)(8676002)(70586007)(47076004)(26005)(36756003)(81166007)(186003)(2906002)(82740400003)(86362001)(8936002)(336012)(356005)(83380400001)(6916009)(54906003)(82310400003)(4326008)(478600001)(2616005)(5660300002)(70206006)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:04.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfc97d2-8910-4557-7ab0-08d8a3a4777c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
there is some garbage showing up during reboot test.
Reason:
SMU might handle display driver msg defered and driver will send
next msg to SMU after 10ms timeout, once SMU FW handle previous msg,
parameters are changed to next one, which result in a wrong value be programmed.

[How]
Extend timeout to 2s so SMU will have enough time to handle driver msg.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 11a7b583d561..7deeec9d1c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -99,7 +99,7 @@ int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, unsigned
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(MP1_SMN_C2PMSG_67, msg_id);
 
-	result = rn_smu_wait_for_response(clk_mgr, 10, 1000);
+	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
 
 	ASSERT(result == VBIOSSMC_Result_OK || result == VBIOSSMC_Result_UnknownCmd);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
