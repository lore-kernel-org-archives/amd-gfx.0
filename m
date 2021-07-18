Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1EC6377A
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1904C61182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1904C61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDD36E060;
	Sun, 18 Jul 2021 14:06:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CE989E15
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOpKxxr4GkQ59R9AfoXT8Ydv4YcZROXNuGD2zODzhFodFZKC8S9TE4TrgV9CQLHTaCxSw3djFnmtqLWmAXuP0jGIpEiEOxRTgJ7W2cCpkBK8d7FJKUBPQOLAcYwSEIOCQtvB3MemZXg5zaXcfw2XA4XFmHp9LCS2DPusdoXg/YqjR+uvvkfEr8MXBggvU2oDKJIlac5r0LwufTqfxd4mV9znc1F/ItR5GiyKQBkN6VVvb3ocYZr1j2PDZ1Md/I05ai7gKudaL3m82NvhwYFx/aKv0vAkuGD7ak1Lpxy5X4/4N61qgKv32MaWd8b+KTTYGPnuMmT0uTvtBAKgi2w9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w1XzFrEqoNraC7k4RTStRHIsaNO2LHeIjQEZQamCVY=;
 b=cKi7EXuBjJdc/CMyxxPPN6LNgDK7gMGPaMnvcR+2pBFmiEKvCLYWAGXTi9ieABA7JaUDnV2WsgWSQ7lamF6E41rGXQ6bZlb0tcKO4LrpCbWj8WQXxai7/PgXHameMQZ5PJ8a1j/e6+iAgo5eTUn2e/OtPuPA9kn+2nx3093QdtzihPp5ff5WiCugSDRTrRpL5wtsEhqgNp9qYsiWgogdqT1hI84zuSqgtnP/psG6xCUniCfCtu0Ehau4rZko2h8MzVSnKINyd8NKdLZ+CuxFSrBPwlp7wjjeZ1yagSkKPcoQPCfV+jPvKBApuAcKGn7LKYUJDqGusb5437rfNnjlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w1XzFrEqoNraC7k4RTStRHIsaNO2LHeIjQEZQamCVY=;
 b=u4gcqAslIX1uFA1scJ6JLylWTwT7hRb/uM/Uh/E4xY5bkjLRigQzoev0Ia2NhWDJ8hGyrTk/Fn7dBQkInyz02+ha3ZRES29CToi4rZ7k9Wwa/jp1d9NYqERxQ7GHykoPkoSQBDpsGIeC2kSsrnV0+xIlPsLTZ8J8MRA0srUiK5w=
Received: from MW3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:303:2b::14)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:29 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::5c) by MW3PR05CA0009.outlook.office365.com
 (2603:10b6:303:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:29 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/32] drm/amd/display: Extend dmub_cmd_psr_copy_settings_data
 struct
Date: Sun, 18 Jul 2021 10:05:45 -0400
Message-ID: <20210718140610.1584616-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91684cf3-cf43-4494-e3b4-08d949f53d61
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0109053EC53E960477AA519D98E09@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQKyBOqVAya6mU4DvnoQZ/MZfffl5fGeeQcqw3HAbpf7S9S2NSRRAcH05oLr9tKWcR/YL94jkr+P/VnYWtZCRwtO0S/KPjxuW6ckXjQmrfKcjUY3Xm8PdkNfBh8l1j5O5Ows3jFP+AolsE6dWBppf9HphfAf8TDaTy7dt++GNcEf7E9lWElj60Td/DY6VV4MskLDFCqGMsp7HvdKCkZvpwdsHqnsAVX9p9q3KGgMzh/60tcGW4hMCJjOoAOW8qroZUsRHfIo2caJml5igWZdSu4DhAD302AtO85c2QZCnRmEnUCK85Xufbg+DTdZQ76Hd3aAynOgaijG7TqZo5a8UqVkc5RHNWPosjrEXdRKJKKKO2gQCxsoPB4d3ogltdhUkhPK4ad7o+kYOVzUyF95wMnMkUXF+zRYVg9RoZAoFu2wAF6oTn8NfiP2b75z4zqJG1mJrPVrKsiDelrx2r7nojqYde83tUNsiuXi6Qvmwho1jXr1/+P0qw+5Lqj3yNrVJVdYLSJOULbQOxpKkOb1TneT6R6FQVHyz3fNdXz8i1s0F1mYGBXa0RvYnm1vrGWW5CHhisfMn5RMlnPZkBwVp1yPPTJ0Y2Q98JJNmUxHR48T89QMt6BHJQy9KUArYAEXSTl/I5EZQf61L2a61n+CxbiNCOUuSiZ/mOnIWz3nwh/oNcKcbObWoi6RaeKt+N3qoIMHigcn0j+ysnZKdoewavVpzQRsj5D8pGoW9D9Csbc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(2906002)(426003)(70206006)(16526019)(70586007)(36860700001)(186003)(82740400003)(478600001)(82310400003)(47076005)(8936002)(81166007)(356005)(8676002)(26005)(6916009)(2616005)(316002)(336012)(54906003)(36756003)(5660300002)(86362001)(4326008)(6666004)(4744005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:29.3557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91684cf3-cf43-4494-e3b4-08d949f53d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
Cc: Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Reserve padding bytes for new feature implementation

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 98bda0e3a6c3..53e3d7d573ca 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1409,6 +1409,10 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad3[4];
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
