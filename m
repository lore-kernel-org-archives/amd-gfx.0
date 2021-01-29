Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461A9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F1564E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F1564E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3B76EC39;
	Fri, 29 Jan 2021 21:28:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708496EC38
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3HONKcyw5KvuujaqgBiMVe5hEO/elL1VSNkwIPRL4YY2KtgRVAMsNf7dvEuMTWbcsKFtpIF3IjxDcw3EaUBAZ4Y09y4I6P3C5rt+Ts+Ewr1UVFqBKM5BTL05BDCQJ3Fvu9wigM+37kPE6RXevt2gnAR672LzTyN0LDf8ackCm7EnBu7o65BJw/4f8ftaSYaw7GkwVobTv7Z8whqgxGOg8/Mql8aWgJAadDfMAEJJ/9uUEoVKhaUfuHJ0TFdR2oFgOjkL9tueSkkfRcPvvdCVE31jQQaG1W/pA1Hr3z3h2Ivofmsr3NttzlA/U0GcU9oWg7eZOBCaD96USUC5oJHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R93aVO0BkTKimIwxLZf/Gv+PG1vsqMmLaZqjt/j/YGc=;
 b=YHgUCw36xDLqqSJeWCR0zt26pdx9+LwT9y+hybruWMQhHq89QFeST/PimoSxzBBZvGg6pY8Ojf0EDc3hKhDJqeIbjcJ0N8EV9/2sy5ebQJzgf+Ijl6Uc3fD0/GmAiWM3M2+hmoAPERDjPpJilv0N+9NG310SSQed+640X4IxDilu8vWYSF5PWh3GsimfvO2jwH2qTLc/sQihYNEFFy8fzt3WPdcnt5yS4iUWBYfcWZdPRQn4xQoWsCkwP3U8noCqB/G7g22+EX9zRE0XBeqVds94O8W3glMn7wANZ/hJtdEEIq5vy//Yv7Q1TGsoORDS1rVDWuBQ1OjweixCPjancg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R93aVO0BkTKimIwxLZf/Gv+PG1vsqMmLaZqjt/j/YGc=;
 b=I5/SgHFkPGDHCiZO7nYruubwONymfSY0xuY4ZyelCx9SUvkKnG4bYa4IlqZ1+cmEgbMIDvTuFXfKFhQZvhvjBWdIsBeBSGKEBlTDr9KVB/ShyrbJgi2QfBfojD4rInu1e9/bCfR4h7nZt9/kScPLDKl8LXtshJqUFwQQAZDxKxY=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 29 Jan
 2021 21:28:41 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::a8) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:29 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:28 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/27] drm/amd/display: [FW Promotion] Release 0.0.50
Date: Fri, 29 Jan 2021 16:27:51 -0500
Message-ID: <20210129212752.38865-27-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff30d37-e66a-4e3e-fd99-08d8c49cd889
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13242D38A9E38C8EB91432E3EBB99@DM5PR12MB1324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrJwGjTmZJ+sXWBxcfyMyBQx00N7164Tg6Jk46qRiveNo0WC3Lc5mR7lEMcYSacS7IJ9UVPo2W9y0c2GxH+kcZVc7rbuL4OIAP0H/DBNBAcdnlFv3pjy+xURJgmE7kVg6NX3ryLBtgLD1P0TBOuybizw4rUwKrEMkSS2b2tlowxiwUHKWboac31NOe37lTLG7ZXShhIVy5Cp8mBYv+uXOT58pLmHNf8A3Fhc/9+JfX4of2P7s7uK96TyQLzki8Z1k2+Tr9f4SH7wD4Cd2XvaM+CzsdNYpXqxr6Ld3owLjKfX2TDk73bHgG0r48hS6SD0CBx6UANPlIyMSu1wSyBhSt6bvmH9D6a00bkaAh3KwXpJSOyZFuYqQ9bmgzpePMhhs0OFwM/jpUmesfdmXZIkJpkwqrErFttN/nY3RJBsqCp+2e9uPKZqKjQADCa5uUqSiuQ1sQJRIQ/Qi1fJo2yklqD/oeVbENbIZWyHcvxbhfVIhZRde+W1KO5vnODt98fT6rdFK1xFZxAHPASOHmtrhzHJpmI/1zI5aLGnF19FChcmvvvN+uGL6KYrjxbyBgdYgXiRIL7XFUa5lYJ86vM3IHloC1sh1WvsQfWkujKYopY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(478600001)(6916009)(8676002)(316002)(2616005)(83380400001)(426003)(82740400003)(4744005)(81166007)(26005)(82310400003)(70206006)(7696005)(70586007)(86362001)(4326008)(8936002)(2906002)(1076003)(5660300002)(336012)(36756003)(356005)(54906003)(6666004)(47076005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:39.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff30d37-e66a-4e3e-fd99-08d8c49cd889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index dbfa2ecf805c..5aaa35c8c172 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf2f2f3a96
+#define DMUB_FW_VERSION_GIT_HASH 0xca1cd48c9
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 49
+#define DMUB_FW_VERSION_REVISION 50
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
