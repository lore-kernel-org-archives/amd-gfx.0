Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D44C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 03:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9722F10E162;
	Wed, 31 May 2023 03:53:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A7810E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 03:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWZUfRvXPnzJzgV6EnO6ht46dDYghLWsSZ+GMOu7Qkh0KXdAzZQuAZVnnXlKZDW9D8uEHO/l7SuelRGD9YQBTGJrCSmCXhy4TAiAIpHZIipYCxl2Fj3w3swEXtvwdqw6yTEumOgAhK1MGslF87zI0OkrcG0J4wba70C0MECyX6opEiOwFvXuwwcThgP/irKyghvF0/KJzTkj8/mBYNV86OAcl9nVYWg2M7QRWjnl+m355P3p9jVd7MFxPwDPXGzPlDsWElM7iTEeuZ+36MBcXC2EQFuRQfiSPwB37424oCyRUH1X1hmlP9njs15c2e6xWBsHALo9Jv1E8e1c3Ys6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ9rZbeCmmV3+Crs8wtfdZ1voRPhZLcvUAgnYv840Vg=;
 b=lI8QRAx5sw/Taelnoc9tz3DENOsyehz4UNGywCr6mhCj4btwrxdHPyLXtbnpiGHch0SsQ4i/jfBmKfqyIh+dk3IZYjtImSEOAu7A//DLEmhRxWxV6wx4GU1BvnF49APb5v9aEGHKs/4K7ICh1i5n6+rUPxyLetJS8kP7y0IJ/fMTtDo432yj5zvuWnJj9XhbA7hIOI/auFqgkMHuk0f7oBbIcMNDXCpA0yYwfDR1HAzyCagK5uHqM13iqWsckD6L9U6EjDFbANnZtheN2SFRNG1ePqNvqgv4IL9MI+KMj69PrPe7hBuyzfU5mfwUfeUjjFFvr9gMJ6mdLLaIbNQJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ9rZbeCmmV3+Crs8wtfdZ1voRPhZLcvUAgnYv840Vg=;
 b=mXMUUADB5EV0uCIXHfPh12B6GfPgsELxceRoDuu2q5LNiQIp75609ES61FItmlCxbRHhRNGzpaq9czMpTwVcg9OnWQZqk0A/iQVL+bPPN/1jcqc+dTRx1vvIUYV62SF3WLds8iYmude+9Ny2pr2xD8hYNvjC3TTLo76erseFxt4=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Wed, 31 May
 2023 03:52:55 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::fe) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 03:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 03:52:55 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 22:52:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Correct kdoc formatting for
 DCN32_CRB_SEGMENT_SIZE_KB in dcn32_hubbub.c
Date: Wed, 31 May 2023 09:22:36 +0530
Message-ID: <20230531035236.3229523-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc1148a-f5d4-4638-0143-08db618a8414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjrmQO01DTEzcaeRCu2Jvt4tXffFoEANlh7orFLYWw6c8XY9w5kr7wwJt0wFCn45gwfnCD+CUwLQ/wNLKwTmFVEWM9cqeQcqfFBB0iI00vnmRmQciV3QzHFdMOx8xF7f2AWXNhXrAN87z7gv9lZArlqwt5NgB5SP4clSUwwiR87UXI0j17EYwpGhu55/FK9lvpsY6gxdCAE7QUpGZnvc8vkZXJjvHQ6zJX8Bk7A1Ubv3hzctWFlmAc2R8yhkR39avByYUEGJ7bwWMtS7uoELtWlfLuk0DVVKPTAXXMkgavtyp5nsyKJagzRcnJ8QD74se6IfPAMz6TdoBvtvVQtshn0UbrdQbZDmMk35iuSfeSCqcWqLq357YTjVSnm0BPVZerSg3nELLg3ejA19x7nooAEk3iJtuX9PeFEhNzlhtxEptircX8T1/OagciezCT1vFFMYWmc6eQVJ5Gx4Kz7h/44uWJBmzoIGqEsl2FvP8fSRxQoHUDdvv1lpAk765oltguU1Wfp0IcXnVdapTM3Jdm9cV4yBEBUcOrYg7TgibJBnvuSSlg/CBdi6yBgsdrxQTGGuZo+lqBy0HgQb8HvBw0Scxv/rWasbr9hTpQEcsSImG5y0J4hdl4qViwFGE9IYbgEvpcan3WVyyW293Ext6BmPboVv7BOCupIZ9sFC2SG80ilo5JW2Sc6g6tn8HRbbdTcPj+1C27U5HouhsvfVEmzyaEoM3zkvI9qcBKxyTVavDh9C2na0UZSwCfTJXAjATix0gHzpVLaEZ/sIKMYxcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(426003)(2906002)(54906003)(47076005)(5660300002)(70586007)(82310400005)(36860700001)(8676002)(8936002)(44832011)(83380400001)(6636002)(478600001)(41300700001)(70206006)(4326008)(7696005)(40480700001)(6666004)(40460700003)(316002)(110136005)(26005)(2616005)(86362001)(16526019)(336012)(356005)(36756003)(1076003)(81166007)(186003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 03:52:55.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc1148a-f5d4-4638-0143-08db618a8414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hubbub.c:45: warning: Cannot understand  * @DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
 on line 45 - I thought it was a doc line

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index eb08ccc38e79..a18b9c0c5709 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -42,8 +42,8 @@
 	hubbub2->shifts->field_name, hubbub2->masks->field_name
 
 /**
- * @DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
- * DCN32
+ * DCN32_CRB_SEGMENT_SIZE_KB: Maximum Configurable Return Buffer size for
+ *                            DCN32
  */
 #define DCN32_CRB_SEGMENT_SIZE_KB 64
 
-- 
2.25.1

