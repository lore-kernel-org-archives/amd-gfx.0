Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE8C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 08:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA99A613B0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 08:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA99A613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD706E1B8;
	Wed, 14 Jul 2021 08:39:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA416E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4FuBfBQ/QavgMxL7DrO0ImX31KiujzdrDkRKC/OdavCOqwPKwgsG47k5vee5bTWCt0jAIanH5gRHed3H8rwcJEUPqvb2fltoBdMxfO4GTLsPsQ0FNsLSqfXhM7O+lOzj/zP5amMe28qjo4/K/Zg6RnyQJ1p/wvKWMmWBUTtySwUOsieKGncOvcg43nqUqQgPzcXsi6X4xdlFjR7zJOSJAt9sPLqOdlT5auRYxftrvOJ/GwszsE7vZrf+DbopYPW43pRPo0/TgBV5kmuW5cln+wM/CvtvnbHXEzbM8NL1bQ0+IfDYshnypCFFa/4qJsQ8J6QGGENbyfOWu46ODRE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi3dDgkwqPWmqSS5sFGYqxiUMZV6ldK+Zw5f+TX9MNs=;
 b=iArZ1ReZJPxbTFOOjcRuSZnUTFtCglSwl/FWnQiQPn6N5+5ZW9ZwBPpaE9OMtZPj8BQIpYe0bWPwx8KgXBVFSz/CHvb4+XI58fLs+wU6iPaJiYMU3zpH5sRjkkUIKw8ldMyWjNsivhEt6CCfNhvAMCZMmmKeG/s6aElm7nvwrUIQlwpelH+NxPxfuyRk2Km972qLZ+pZWRWj+dhs8DF8mLdYpMBDxyFNy3f1O7ZDQ0H0vcaDCWlmj1uV3tkDbyM2hfcoaR1MKwjLSBEsT34gRqbNWS8uU9p/phvrj8IcWW4c7gSUWNSYRd4gQzo7hvDK7xGplhdpQ5yGDyZ1XF8nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi3dDgkwqPWmqSS5sFGYqxiUMZV6ldK+Zw5f+TX9MNs=;
 b=DFoEUPZnyprZwsbFWDBD90kEcNYXmIcXJJJCbnNSc/+D0cztr3iT2BaCX0aFqduSHSWLx97arVSAiGc4M2wIFDphh6Xvgl/ExtP/pHnx6mBzwWCZ8cC4+6lboxzUUo/ICQ60PluMLrVIjnkqNeGs1gaOeCFbhJHzgsMJ1txF+tc=
Received: from CO2PR04CA0104.namprd04.prod.outlook.com (2603:10b6:104:6::30)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 08:39:18 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::38) by CO2PR04CA0104.outlook.office365.com
 (2603:10b6:104:6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 08:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:39:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 14 Jul 2021 03:39:14 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <stylon.wang@amd.com>, <Nicholas.Kazlauskas@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <tianci.yin@amd.com>, <jiansong.chen@amd.com>
Subject: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse(v2)
Date: Wed, 14 Jul 2021 16:39:01 +0800
Message-ID: <20210714083901.9312-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b359155a-33ee-4fdf-1508-08d946a2de55
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514745886FBF60A39EC3BC1F1139@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9PLCQ7pVubzwwIaijrF9/D53ArNuCA7eknnV/nGAzbOrHTbqTUOXmvPZhfO2k4Kxw17AolLsi5JRRwi0bUMazGXDGhlNqjCxZw1mSv5Ve41cbajSocHzYkDk49+f/iQtKlo11JdBteLvO9Sa8hUCwbP7n7/wE9IAl7ha1gHT+kkwbPCy2+sABKRL/qnjYGkIKdy1uE5bAwpzzhb5BsYfp4j7Y4HXnIVs16/c1PigB8cUiQPlNLgF0beo5qBSQ4CVCdMiPz55b/7OU2/3mrFDCMwAtILCQXr/yIATon1WG9ftW6tpWUubVtxEUTefcNc6xrkfj97l/+08A6sB9FWr6CJcEqZQdtUbxhxYyMCO1/rzXpLuLRku73JIYJkQefNWZ/TF6gqh4snQU/kzxR+ZzYpvvHRbWvWz/XbGUuMjr5UqzNBD/SJ8brepj0zyHYvQZY/596lqkIRfIWL5EiWFth1jygMRu3SeqWZnrHhmqHOzR0kMauLM+Kp7S7ZmjsdINFBgtRYo6hR7/Q1dJ3p8LvoT83PTFUJ//+J7DbX+B6ORvREebKOVh+Lgqh7umrDnkOnIfJ4+5IHOqPc8mlRH+wbUnYxBoikI5v9IvPaCI3F1z6MjXjKowPFUVC/zxkSkfwbFKuahq1cJ86kEH26XmXE0hcg8c4QNbdeni3UmSDaiLvbf2tjz3uNvXWdfmdp2jdHVLDDxIO1++9EFFKUb6c60qflf4IOw54gY8BaQ/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(46966006)(36840700001)(5660300002)(82310400003)(8676002)(47076005)(70206006)(186003)(16526019)(1076003)(86362001)(82740400003)(83380400001)(26005)(6636002)(426003)(8936002)(2616005)(2906002)(6666004)(478600001)(7696005)(36756003)(4326008)(36860700001)(70586007)(336012)(316002)(110136005)(44832011)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:39:17.6740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b359155a-33ee-4fdf-1508-08d946a2de55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the unknown CEA parse case on DMUB-enabled ASICs, dmesg will
print an error message like below, this will be captured by
automation tools as it has the word like ERROR during boot up
and treated as a false error, as it does not break bootup process.
So use DRM_WARN printing for this.

[drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA parser results

v2: Use DRM_WARN to print such info.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03db86bfaec8..f7ed4d20d168 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
 		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
 	} else {
-		DRM_ERROR("Unknown EDID CEA parser results\n");
+		DRM_WARN("Unknown EDID CEA parser results\n");
 		return false;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
