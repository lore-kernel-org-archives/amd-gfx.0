Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDABEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2087610E5AE;
	Wed, 12 Jul 2023 17:13:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3273510E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX2zKBigC8rU8tpDA7QJPhEK3oSNl7BQIi2VRL2VKG1y/O3dNIn2iKDh3pnIA2uazJ7rJvTANsRDepdkgrE3QLr+LZVQkqBjNzdyOJUEbOZliSbq6Lfwn52USKr5mOYZYECNBiN4jXvfUs7k3xF5S/h88DEKCnlYFb3l0zWXrynidxeH64cQ9b3lVvTYN+K0R1Ih/BOordYo8BuAk7wGh2vK1K7CrmzbOHMUtv902giKBc6YiZsAi8T+tptaZeH5NAQRnTszyuMdwUo8r0TvGpxLPX7PiEhSUUF1SsS4QRt4yymd2tqByRCAKYUcB1Eh4uOllxsX8evusU0oUaZNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+moT5JDfBrxg4pCqppFJekOMNLgSlgcWcEc+q4lLiQ8=;
 b=KQA4vXMFPGi101h0kxjNWXYxxZzndyKJ7f6gth9vPGU99vnzCG9E0jJR2n8Iwf/QSsVo9F1cWdoI43brAyZpvsptDiiz3F/JvcRPNX9KNT7TKWKrx4KQ6wE0PU+6Dl1FEehgXimMLoaJKHjx9UYLq+VoQBJw9C9smp44yQXkIsYSHs4RIJoJU0fscAi919/jhem22KIo6lkg7T2ra6WBQGMz5W4/kiLJyf0mAo0C1VctNyetLKdU7TRxrq2bjLc1nDkgpMn9u1WUtC1HBodDF3ejbFEqJFUdUT7Hugxeucqqyu9j7Qx+lZT3Zx/g3YRRP+3MsPtkFBEiUqU/Ik2YJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+moT5JDfBrxg4pCqppFJekOMNLgSlgcWcEc+q4lLiQ8=;
 b=dqD+jgQOdqw1Y1m+q1GgrBBEoiod36PIjO3zDvvbP8dIOd65k+21K4aBMydrJjs4YiiqpXrXyf+5WxLgu+JNkfUWOf93ZEsk3zEl0glvrsOtuh3jVost5CCmmWFGylRVUPsAZ5EqXGtiARw7zAPvhVfD/BMjMhedR4Tfz8ZmHGE=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:13:22 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::e7) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jul
 2023 10:13:21 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:17 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/33] drm/amd/display: Skip querying caps when DMCUB
 emulation is in use
Date: Thu, 13 Jul 2023 01:11:17 +0800
Message-ID: <20230712171137.3398344-14-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e25801-183c-40e4-b265-08db82fb4bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uugit+jXgoff3gFrMUmxyDBjVwujeGCEqAwyaTrdzNo+U94hxxyK99tvYrC9JeguKnGdxLtTPA5RCn7SYVi6cfyTcxkEI0jlV1mENINFuDQKiSZLwzK6OxbgEUPyc7hJ2mrhz5xrkD8tabXf1IF2JxQjBOxdbto81aOv10XDYEFlHtFi+jFn/KgmeF24+u/rtGQNrE6jqLEbzSIUIxkEzhU1Mh+aT5/ETInUKFZTK/cdTkSX3zddXd4FyCPiMH+H/axBEP7qXY7zNkDv4vu5PnG10C1j2N4uGcx7qRaduFpJ39Yvt7su2L199p/AN/mV7WcnW83QYq0xwUn09UtuuxGKYWiGB+OxcZpNT+QYe/KZiVtyOlscBRipTkoRW3MNCqzH7yzdrqwigzJvIucuc4U0HXKvksB+KZ6VBny+WvjsyjeLZfpj8++0XHIGeXjC1THQ2eIpXMQZMW8UjToYj2oWEOxkXX/CUYnR90+FsubaXs/z7jZnZWJyYdE9YcwNn8iqPvgyzg/Cb2m+ANN1qc88yuuv82rgNFv3A3ScXTD4OM8eE76XvzRct5SkpniyQgRboopGxLWFqPZVfHCbw0vyfHn9JK7QIDJCZoM+hATDtFHEKXiokXOOsnxukCmQw2bhiXehDvg5o8WZNOWQtyIHRfRekTkOrko/qVv5Zpqs5Tw8l+DW9zRR2Q2zOFTe1/qlAltxkJIu3LKfBOMRkqC86ROaFDfeUKiIB3rFK2fDpvn9tT+xVa9rc14F1Rmb21bJN9bhkLMiFxfVTjSLTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(36860700001)(47076005)(186003)(1076003)(26005)(426003)(83380400001)(336012)(36756003)(82310400005)(2616005)(86362001)(81166007)(356005)(82740400003)(40480700001)(4326008)(70586007)(70206006)(6916009)(2906002)(41300700001)(316002)(8676002)(8936002)(54906003)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:22.2565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e25801-183c-40e4-b265-08db82fb4bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <haoping.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Workaround to avoid accessing DMCUB state too early if the emulator
is in use - we don't support any of the features the caps are querying
with emulation anyway.

[How]
Guard the query if emulation is in use.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c753c6f30dd7..24433409d7de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -381,6 +381,9 @@ void dc_dmub_srv_query_caps_cmd(struct dc_dmub_srv *dc_dmub_srv)
 {
 	union dmub_rb_cmd cmd = { 0 };
 
+	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
+		return;
+
 	memset(&cmd, 0, sizeof(cmd));
 
 	/* Prepare fw command */
-- 
2.34.1

