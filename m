Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE63C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 15:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F4520870
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 15:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M7+iA3Kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F4520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9135D6E21E;
	Tue,  7 Jul 2020 15:41:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC78D6E229
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 15:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/1yg1zFhD7flBZAJzwWnin8HbUS+awmjZK5dWqvl6rcvnnGoSfAm6i3MGbDPmtL/lCl7ZEL+DYbKm78XDsGjA2e/7uCW6RD4R8W7SS5KVSjGvOrDeZvbllsjRpHAFMNXcvwuCGsuQA720PAYihz3GW6KZwwxrRPK3UecLnqoFqOzg2PRibBzwDgwX/VugAR/SarKGegPc/BQsp5Fcj83+FxUZhxrEiYt6GCz0C9GpIoOaskWnSjo7Xlzs0Mrg3mg9BkHJiHs0BU+6TlliADx+8QF95HsH9bJPeqt9WfdoQWkZanEo92mmFsfLboeTcDlVvWPFpgk+x6enEBRw9iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNG0qjVFmhga/JNeDwutLLLS6Yd5K5P5VjP4aQCNqDA=;
 b=DpwDaI+UiZkWCf8ynN6wkT80RO0rhD/8UUqFF8h38udG8rYpJaqhDji1VRPnXJ2nihHb46hgsCev3CBCD6TnFH17p8gVoBOQoHgsoqiM39cnUMDEi03l2YCSFncGteJFguto8NLVDwcFoBLNIuIBkfIr/4BKWOtc8rxhhSOO7y+i9HMmpmIcP43X7h6MKf0G1InDZXPDK4xujmaTGSsDJkmv35k67V1P/OHw1slgkzfJqjyA9Qa2TsVNJlm1PvG1lr9LOutHuoUBgJtc+yQ0zmcBpbwVKwmVeVVmJLS5U9slc2ac+rmeGF8cWEVAtZ/xfNXg+OzEThg/YANmQNIlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNG0qjVFmhga/JNeDwutLLLS6Yd5K5P5VjP4aQCNqDA=;
 b=M7+iA3Kc5DmfcGJJMDkhu1cCxkcdrjeleaND54dnf/aykwK5fG/v2BZPAksSRrDZzQFiXOn5EKUhmYewcGzF7Wi67MtspYD5RpWqkQswDpqsZBUvPzj6PmMHbBzSNXMtDdtWwZuMJTkh15r8/2/VDQYDGnihnaMaJryED39tQUw=
Received: from DM5PR18CA0058.namprd18.prod.outlook.com (2603:10b6:3:22::20) by
 DM5PR12MB1627.namprd12.prod.outlook.com (2603:10b6:4:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.29; Tue, 7 Jul 2020 15:41:42 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::a8) by DM5PR18CA0058.outlook.office365.com
 (2603:10b6:3:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Tue, 7 Jul 2020 15:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 15:41:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jul 2020
 10:41:40 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jul 2020
 10:41:39 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 7 Jul 2020 10:41:39 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add missing CW4 programming for DCN30
Date: Tue, 7 Jul 2020 11:41:01 -0400
Message-ID: <20200707154101.5715-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(86362001)(6916009)(336012)(47076004)(2616005)(70206006)(70586007)(44832011)(1076003)(5660300002)(54906003)(426003)(316002)(83380400001)(6666004)(478600001)(36756003)(82740400003)(2906002)(356005)(82310400002)(186003)(26005)(8936002)(8676002)(81166007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8186a77-fc4e-44f1-066d-08d8228c3e86
X-MS-TrafficTypeDiagnostic: DM5PR12MB1627:
X-Microsoft-Antispam-PRVS: <DM5PR12MB162755F89DBDD609422C6038EC660@DM5PR12MB1627.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iynaI/fZGmuuzYhMzGgmZYhjqrPvdoCZLpC6QzcPctFQVnr5yuwxffMnwgabHMkAmgEmaZnJPijgVZDYtvO9XH9pw5CgLuUyf1Er8qFPX87K8wbWLtGV1Fy4rvNsZs7eayMUy4hpsKqKK0BMtVVuYYJ4SefndIugQKNHQh89XGJvFiw64TF1RHUh8rm6LNEhZiyLUIAH5LZkWLyxhEvGFu1mot90lYeT1Rn0ri2XVGffzgSghrk8ovgOfIt532NnHXgACyQs+hPvmJoByp6Gf3PuHz4UiKjr8V1gyZXYwIsCdpcw0YP0dRdWxui3B0vGmSmWpWyVH0kxAFnB2EJwqtDew15pip9alX7OF1YW7l7WLTX898O4m+X2LDixaglo9r+EmRDsPxwCiBwIC8wYZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 15:41:41.1822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8186a77-fc4e-44f1-066d-08d8228c3e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
To support inbox1 in CW4 we need to actually program CW4 instead of
region 4 for newer firmware.

This is done correctly on DCN20/DCN21 but this code wasn't added to
DCN30.

[How]
Copy over the missing code. It doesn't need address translation since
DCN30 uses virtual addressing.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index ba8d0bfb5522..215178b8d415 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -153,11 +153,22 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 
 	offset = cw4->offset;
 
-	REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
-	REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
-		  cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENABLE,
-		  1);
+	/* New firmware can support CW4. */
+	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10)) {
+		REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
+		REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
+		REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+			  DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+			  DMCUB_REGION3_CW4_ENABLE, 1);
+	} else {
+		REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
+		REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0,
+			  DMCUB_REGION4_TOP_ADDRESS,
+			  cw4->region.top - cw4->region.base - 1,
+			  DMCUB_REGION4_ENABLE, 1);
+	}
 
 	offset = cw5->offset;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
