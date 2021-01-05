Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DFBC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886692065D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886692065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DE16E0A5;
	Tue,  5 Jan 2021 08:37:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F33A6E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 08:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAveTfj4tJ+UTgD5+igWVt04gurAc2mvUO3OV0Mcm/tYBxofKNZsg9I6v0uX9Uu0UOkeyWoqd3d3ePaUbawPhjp1vrzQC8fzWoki2BzGILFO5CiixCTF9s7eOTfEmi7fsB098anhUGZAqoTzmS8aezpf4vzZiTE8MskmG9rxMLa7Pghgzq4tlpMnbVs6OjP/2Tz/Ee+OjnwC2ZYU6gyLk2DVlNIsH18sFfi5KEHMWOM2ymdCOCBM0oeQRUe34MjPtqkn4nOELtCIDo3CS40FirvduUdxNgGmenLini9tUPT+uv07z8YwZbl0jK/C1IShqRcWZCStRhDMdlqWJIEbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npPIJC6vHRBOpLFPzBR4m9AuYAySW5rjMsa8pk1ua50=;
 b=nOl6wSTQtu/mMFccxarFNie+BPyNdLYtYN6Qr2xJ4RtroHIF+tTVxknnwlpWH4ZOGyqFLWKe30OOiR347ITr9O2rtRK6clzFwc03/dxBpww4KrXSHbFvcfBc7HAJ/hb0Jzh47FEV/ntrUoczMaMsb0HtVFNdbTYw0Qx0L80sdrcpE4WYwrPpfuaexMvWskufnXirEqtm3QvcFzm6R1TGX+/CVPPGjmO7nUkkfhuB1abcTdOL3b3Sl2kG8A0IQh0Uj2T5hzsvubp0lIGtKKH0WeycySidkx8/XbDppcq23iToYYScXz1zSNUqrZpp588ot/LEpAg29lBJzz+sUKhOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npPIJC6vHRBOpLFPzBR4m9AuYAySW5rjMsa8pk1ua50=;
 b=H4MzoMkjXB9t7JXvbPRqH/ru7HuVtX9DknDQoOJzfmhKiMyzdiyV4907DGWrxFhr+ZCa3HFhfY9h94HahITHlBNCTsVcE1tuXrIiWZM2l3AoB4Qog8L/N0ljBTNyr/U/CdgvjxoqZFBR3BIEQaS5fLkhDSIT9E8JnfgAfMhZFsQ=
Received: from BN4PR11CA0016.namprd11.prod.outlook.com (2603:10b6:403:1::26)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 5 Jan
 2021 08:37:30 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::72) by BN4PR11CA0016.outlook.office365.com
 (2603:10b6:403:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Tue, 5 Jan 2021 08:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 08:37:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:28 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 02:37:27 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add new mode 2560x1440
Date: Tue, 5 Jan 2021 16:37:15 +0800
Message-ID: <20210105083717.468585-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d3ed629-4280-4b43-5f41-08d8b15522dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3293BB9A23F849400ACA51FF8FD10@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rfp3WPSPFd+vlF5zOX1XMfWRd4N+9LRE/aY1EXDupfWDXuO6qLvDRO9jwcs0Mq4kc4P4v6A1wggl5P2XXW07RNcR6HL/sykLAtGTwY00CPyIIIIsUI1B1nEcmRE+Q6+PFRIuTumBssvTgJjdYC+QCpwH0xQHSpNkEirmNX/ijuiHjXDdaCEsO61Qmp2WjP4aUd4EGF9Es0yWPXr0O2aKNCL/VQwThpQmmGm6Y9M3i9wi+/9gSZf0P4lcZFEnVezysxcjpmamuGlvmlLD8lBPYVb0U+YF/D5z6BEHldR6weZq4jhnE4wkqTKqKPkmLdIb04U0ONm+V22yk135pBgUIOYkBLJ38iO93JMO4NlDExsrKyXmNhWJ4+AzIr6ZdutAQTJxfMBn8f8mC+9/mbyIJpvYAC2r+MxBXvSSB/U5c0KIiZWZpwc3Wx6RbqLZxcIbwJj1SKyWCaWsGG6YnUHvcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(82740400003)(81166007)(2616005)(36756003)(6666004)(70586007)(356005)(47076005)(2906002)(478600001)(1076003)(8676002)(8936002)(316002)(426003)(26005)(336012)(83380400001)(6916009)(4326008)(86362001)(7696005)(82310400003)(5660300002)(186003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 08:37:28.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ed629-4280-4b43-5f41-08d8b15522dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index bc3dcc262fc2..2b16c8faca34 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -324,7 +324,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	static const struct mode_size {
 		int w;
 		int h;
-	} common_modes[21] = {
+	} common_modes[] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -342,13 +342,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 		{1600, 1200},
 		{1920, 1080},
 		{1920, 1200},
+		{2560, 1440},
 		{4096, 3112},
 		{3656, 2664},
 		{3840, 2160},
 		{4096, 2160},
 	};
 
-	for (i = 0; i < 21; i++) {
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		drm_mode_probed_add(connector, mode);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
