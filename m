Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E67C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1C560E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE1C560E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F9C6FE5B;
	Sat, 24 Jul 2021 04:11:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6904E6FE5B
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI10ug4ZXJKqnD2MRk/3kPQMq15B7NYcDkk73UWGTLu8caogrrWX4WZXye44vbq0C6Mls22WBQsSwIFkT+ApcrPNW03V10ePi1uTgYD4YDIyc1b/WDw3iWVPOJfoZ71ADvMGrobMFGFHuDCk5HVh8XQXXtxfijI2FoDzn1D2cnolDR4Zp+x4wz7hsvQ17btWLdVR2MuIrsJ76p1FUKTpUV9/y8tHSMo7cI8i1/MPGSKUs4zqFvetK37DAMVsH8T2Dsk3ZD6atYfqVzOs8drolukaa1c198lahYHjBJJg1XjwAH+YJJZnvdoKrygxPh+8pnWFMy0t4kahTOshxw70Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkaoOYezGyIVv9/5Bn7zTtbKcmeGjWRY3ACHjmInvTo=;
 b=gJA9thM8zuv8vNMu77KZGHzLqFD9lB1R5ZpXb8YnWYQuHnq474/9ruzGslfDggLkmQYX0iQsa096NBoOV6YdStEKxhSF2UuANzjaZ6B4HE783lxb6P/Vq7Jys3e+1Oq+Cu+IKicOoJTeaMeO0DPx9er/6mZ2sYya2OSwXhP3kjEukm3hZrqO1EWs5gnzDHZItWDaGAgO26JyTFahikKe8YSQkjmS1TwzMfkKd9pzgsew0gTDQhTflWiS2CLZKTfnEAXHhgOrIwC/1br3KqoK8WC717W9AYxf+CfcRRMiWTuMUhVfP30UXcVwvgQ/c9qF/Yl1aIJ+oq6nMI+gH6h0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkaoOYezGyIVv9/5Bn7zTtbKcmeGjWRY3ACHjmInvTo=;
 b=N0PdDqn/xG66ynet7UK1kHyIpNXMBjlA309EOQqphjQkAHZYywSCSn4PcH9Gn8jb1e7gtJwDobWXCi1u1CadfH212U9DpKNuC7iufypzt2XZBqha89bLNfbw2MXLtBvBRNCS8icyeVrF4tirj35pD4KZ7GqkherNWM9cXjaxoOI=
Received: from BN6PR2001CA0034.namprd20.prod.outlook.com
 (2603:10b6:405:16::20) by BYAPR12MB3541.namprd12.prod.outlook.com
 (2603:10b6:a03:13c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sat, 24 Jul
 2021 04:11:26 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::3a) by BN6PR2001CA0034.outlook.office365.com
 (2603:10b6:405:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:26 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:22 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: fix missing reg offset
Date: Sat, 24 Jul 2021 12:09:54 +0800
Message-ID: <20210724041001.3875757-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7184cd2-72ad-4981-bcc6-08d94e591b0c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3541:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3541C7FC588D665D2AF4085197E69@BYAPR12MB3541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOS9Nt8x/zUjZqqVITKJJPAdPWILh+5Gh9rN6KBE7dCGUr1d0pgf11uHWZYzfqPK+F8iJQHTnsRvqsCVi09QIihgrnU5GZV3nHAufWYwewza7F89oMFcVE/GRBOiwNjPbdS31EUZFKazWj5l3oe9reeNL1LrHd3HLfgaw2+olqm0mdqwSOd9uq+yj8RDB09Xa53+ybNvIf4z/TuB2Ugh1onMFMI07PDqi5TgxnpF5SeKT0VYUopqOd+bJQBxFVMdGnfsPOE/OdyrGopmdXMGOb3L6mg9WtwgQ/Hg+hoCDubOvZi42klHHCpZIq4MUNeCCX8mxz0gW0dpL4LKEEu5YlcMoVXhzAI2k+X72rcTOSjlTQyxgXAPrz5NMU6doS2HIr9sXHw5xOqj+AvFkU+NRTV+yLu117lQQyd6FNclStjT44HVxNEULFcwvNV5jVaMgiZs3JQy0P/SrGZLzTIVi7QH9rDpFfn6AhCwrL8Nm2cPuuUzf0+wNldEiLDKO924dI1RHOwSDEGUFLFNTJOysrmnp+89zy2TG7ZlWmFR6+X23ew7xou34H8SPD6cZ56guaNHw0iQOjW2/wuuwC/l+FcG1V6ltGsKVpYU/8yJPWwvjuwfn3rGSDmfFkakICVGFQI/umAKyUCs8PycMdRe4/TD9U816KgF8cvt3/LbFknmqaXWp9SUMBoD5i9g/IgeYjNjEUUjpQCP5OH09YQXANnuka4niXcTX3BKjSbg2ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(6916009)(36860700001)(478600001)(70586007)(26005)(7696005)(356005)(316002)(83380400001)(86362001)(186003)(54906003)(47076005)(8676002)(16526019)(81166007)(82740400003)(4744005)(44832011)(70206006)(82310400003)(6666004)(4326008)(2906002)(1076003)(5660300002)(8936002)(426003)(2616005)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:26.1991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7184cd2-72ad-4981-bcc6-08d94e591b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3541
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Initializing was missing reg offsets for the dmcub test debug registers
causing assert

[How]
Add initialization

Reviewed-by: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index c3ead13f4e2b..61446170056e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -38,7 +38,10 @@
 
 const struct dmub_srv_dcn31_regs dmub_srv_dcn31_regs = {
 #define DMUB_SR(reg) REG_OFFSET_EXP(reg),
-	{ DMUB_DCN31_REGS() },
+	{
+		DMUB_DCN31_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
