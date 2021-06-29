Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C5EC11F6A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B3561D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B3561D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9597A89FBC;
	Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14AB89F8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFDmNz82wFvKloIfFmtsPVLADzzEqkfNgCRH7O1EjSYLCY/F3oTX6IcBQwl4Snq2zyeR70hPM/j6109zuHd7KBFL4UGtNBcNJh3Jsx9w7alvOzZnqm4lvtb/2QbozCN9p/1mdYSx9HQWqoRCCEPe9cPn+JdCg4lh867VwG1LPI6cfN+p0Ca3OEEyTLSnIbyEN9BvYQ1ZsKys47hcRlZadix1e28BsRVJplAOED+4w6ZMGNqWgH4+8tJ+rhnvyWZAf9B2YufelP/5mBsAXRCz7WXt3nv9pqhq1fFiUtpQsdkkecrGfiBkRbisV4qnwOr7uJ5oCzpnZlLLk3zbtJL4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMLNBsSkQuW7cbbxpBuo6knOq0phDZsvKNyX9x29Dig=;
 b=kpySMNLQCKqV6Vui3wKji/jZIUgJRpnyGl2NKy0FnGVFdNkc8r05LhrTmCR7FRMQtvAVNGcHrVth1FnVOABjT3KiDaHNtqYVZTbZ8GvH5njX986Xjb7858cAa2a4iNXeha8OJ9BdNNsSp4XHjXYLA/3CWxeeR4KUe1IKc4C04Rnr877lpd4yGFkOriydsdB9xWEqBGSJAB9Td68dJwKyiwzcUWJFONeKrKS8oMjaYqvMezLKINowioAgPN0IkvBavLDv/zmNYptpqdnsUfqTaAQqgSuDb3l5j2brFYd8L6d8iNjIJZxOMU9wojgWakHQVteeRaNnqiAn7xhLIdQjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMLNBsSkQuW7cbbxpBuo6knOq0phDZsvKNyX9x29Dig=;
 b=KTzla/iZL0EmgkVMEf7fFUwamAL7Omz2RvOSqWqZP0QSdK3RSEWC2wb4+6hxfkdC7X6nFiV3yFG08y4/em46iE5BP2PZqkew4R7zVr0jv/eNt0mc2ElbQ3+egw34BD3lBAnCJ/pzFHzCPluOnm0X43zt8JCSXtCqeVqqJTuzDzY=
Received: from DM5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:3:7b::16) by
 CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 15:54:59 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::fe) by DM5PR13CA0030.outlook.office365.com
 (2603:10b6:3:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: 3.2.142
Date: Tue, 29 Jun 2021 11:54:20 -0400
Message-ID: <20210629155422.26118-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8d9195-7f42-4dfa-096f-08d93b163fdf
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0183:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018319C869BE59F579F44F5F98029@CY4PR1201MB0183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Alp7iBvx3kj86Aoiw6BxWMbJSQDRVz7zBamMgThjbskaFY8DMMjSdC8K+l/13yr6ZS0DrQtV9kBGk5GAvtGKjTQyUoUrBWi87fVxuexUE5jKuRc0yk7ip1Fom1q2H092VXsJlPCIoDLQYlRRQPE16S5WD0f30ZEt7cqBRt9fUr23htBtfsraNLrAFTxY1DTWr5zrDLngT/rvbbyXXy6IsbOG4amam1DuLvxQnrbHxdt7NR3CRKiUNPGLOvvooa3GAlyVvhhndfv57u9ui/o9sPyM6/f8Yhe1WRFVvvv+QIcKPgBuTp10YacDl+x0QATubzSgmU4hltbdH0FGFnffyqrukSMPcOlHNYa0Vid4yGc2Yb0uz9cq59YVU6P/wp/fwpcq9hzSWTwlJfkxy0Bd57in3tXCP7PInZn1/0aOdG4c92/oz47PMRI8rq1joS9sOUZU1LVTIww7uIAXzzW4hriPzUd0H2WPAhKLqvggrUcJQ483AvW37gK6zaO2U9niCAKbeeHrQyUuzhdvEHLsyBdHuyppUQbsFqn32mfZTnV7o6+nCUfazMk90CNupSsRaDC76LMQMsvD91dShqW4h52EEu+MM0A6a1C1AUWq3GgPpV0UlLz/XAW+Tcejkm6vZSqkPl5CfpC/acQ9Y7Av8BK5XyjY1uxdcIpU8uQNiw5FkptxJeg9WySbYeqJynwaBY6gGAIncRdWcnRFj2ewdifW+UTIeOj0/fr4VnjRwCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(2906002)(82310400003)(8936002)(26005)(4326008)(36860700001)(54906003)(316002)(6666004)(47076005)(81166007)(478600001)(336012)(5660300002)(6916009)(2616005)(16526019)(86362001)(356005)(186003)(426003)(4744005)(82740400003)(8676002)(70206006)(70586007)(83380400001)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:59.5477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d9195-7f42-4dfa-096f-08d93b163fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.142 brings improvements in multiple areas. In summary, we
highlight:

- Freesync improvements
- Remove unnecessary assert
- Firmware release 0.0.72
- Improve the EDID manipulation and DML calculations

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 45640f1c26c4..b62d21131af2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.141"
+#define DC_VER "3.2.142"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
