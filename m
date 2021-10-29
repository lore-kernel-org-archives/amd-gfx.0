Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B685C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3FC61175
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA3FC61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FF86E139;
	Fri, 29 Oct 2021 15:15:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0676E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6cHTRMXYTb7voEFHuHT4l6ZpCxnUSiAiLuxysDAOxtDYrYRVu5kDwik3tgyR4vJWSBEQwsJK26/PnSb/06Doc5Gqy6ZD5XryPbtmYOXwxMr3IUIFm2P587t+Q6bKa838X+aipSuhz2H49RtNhICGnmWHXxliUsBFXJpjsWNRet4BytAQL/oe6E5NHpusQqQwfNtW/29ZcrmF8mGvLbJwtSqLMQ0RpbDphjh39VhIFnBVKc3g6Mgu8GMhYM6c/3X+c9ooyRroFd01VY0U5eU+En2ma+Zx/AmivU2krhAlWZ+frYkiCGmpOL+at2yhOoB1wLPUSfXcvtRVqrAulvmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jej8E53+GLSogh+h4GuX0SKg3j8IUaCbJpfnegq65wY=;
 b=bFvqGYGbT71kf4giudyuAh7PMgSvMPPaJl1/tnOGzcMH9H8lmzs005/x2e+H7TbW5ENfJyYzGldb/7Vm77BxfHaCb9ky14aAwaz8lVATisXh+YV1x8zmT0YErXyPS4fDqvCkqdojBnb63MmVKutZcLPTPlEat0SlI3iQYACQpjmHPSLeyNxBwHWFVljpj6johfArY/0uDCQip1HdA7wh2NW1CsKkvtrI6bnYkGt857NJHsqgvh00QYnAP7wtz939nsRctyL+4YZqB4nR97vTgL+CNu9q8DHDj7DyJvIaH/qogZYqWOHSacDMw7Pdp7zmeN1kCIq1ZDJnSeMTeP8iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jej8E53+GLSogh+h4GuX0SKg3j8IUaCbJpfnegq65wY=;
 b=uNRIw6s8wqpNBgU5fJJcA+COW2gsVEY/gpmgqHtuFHeDl7tMByIgmnSsiSrNWqLeuS9jkqsBlRVXnb5tWU50v+4D1LX4WDwBf/+3wUvU4faNixRJwe9YVBFU+zCulVJ7o9jDdIsvQkcyzAxl/JIOzwnUe76Y+rOAATJ9K6hc3s8=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 15:15:40 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::bd) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:28 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.0.91
Date: Fri, 29 Oct 2021 11:14:55 -0400
Message-ID: <20211029151456.955294-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd3dd67-6d6b-4986-395a-08d99aeef786
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5428D354FEE7D8EFAD5C63F68B879@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXyWiAkslGPVHyIJbAIeUz2YDa1bUJxLglWMv8DHXsnoRBJ7VzBPF+yDIYTMYbz44on94o802bPMie5Uvne6B06afPkyui+mXsilKYqg47N4xdk1mcAzdFhDCzYcFsCYrJrJ5H+tnX3G3y81rHEmfO/avhvu4TD7hZPmwwC1r6EdVpsrsFMPZXuwsZAWBGakekqgWOOQjek7PbSGpcThs/Ycf1eQHpLBnPxeirtz2IqxKHNn4enByndkzJKy40Q0zzb7ht6JznNuqqy6vWg/otPoHuAFE2dH1fnLN/Soen2XofUNj6eZzQa2k959EI0uQOY+MflIlMAR2rSNLtRIHaDlf1NpGLrl5WDSmV280jtkVXsA7UBFvzMi7MVH+2/FQH+pvNqk1QVL4prNuzRKlqBTk8MOpFyQ3skYtsntkeiI7WtslVlzSDry1xJ64eFynla+xkkOQYQxP588Ybb/f7Xps2KF6CWdV56qCwkyaE6l2G3KbcAqIgjjcYjzxwUlgrPRCfvNh162oeDjISR0S9W2jaWJbvrK9t6HbjTW5vie5g53fW75wvnolntOKR63UaPEDAs2C2n4eXYjbDGmihpvrgp0oncLaFwKuqgaplj+lRmshGpDoEA5+K/q9VX0EuCa+QC9D/0f21f770vkc3uosSm4gVuW9WdLGIJSlmOt5ztSb9OEFjnGyQe51OALxSyG0KQQ+n7MyE4EpoTeksyOkek67O3/zmIHO0w/0gquDV9BxVro08T5J9AZ1gNisM8uouwpSU1n9bLBcLChEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4744005)(8676002)(36860700001)(26005)(356005)(70206006)(70586007)(8936002)(316002)(186003)(2906002)(44832011)(336012)(4326008)(6916009)(426003)(2616005)(81166007)(54906003)(47076005)(6666004)(86362001)(36756003)(5660300002)(82310400003)(1076003)(508600001)(83380400001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:39.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd3dd67-6d6b-4986-395a-08d99aeef786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6a79818337a1..1c4cac4a4894 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x9525efb5
+#define DMUB_FW_VERSION_GIT_HASH 0x1d82d23e
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 90
+#define DMUB_FW_VERSION_REVISION 91
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.30.2

