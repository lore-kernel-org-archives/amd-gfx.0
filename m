Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5FC54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D892076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MBUSrcK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D892076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B7789E08;
	Wed, 22 Apr 2020 22:08:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690047.outbound.protection.outlook.com [40.107.69.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8490189E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2gwcnV/WCmP9BJrM+iOCw8sz2DwjuvznNcqA3k6h83zqc2HrKr0vAag93+mw8phX5NhVO9O0s+ZI8u21XJFi8bBkHAS8XmVQVUHmEgGzhgITOSL/Kq2+jbmpMUN0ICGUV5bJt4iiQ76zL/fwTPGV+zTbysG0SyCmEBsQFvtQF27FgmrdGlc4A5J/n8yZGjYwpsuAx9jJadgbGvz8vqbUVLvyj5L9SwoRLvNbtaRnXI2INjZ1AInJ4anl9hIn6tPf1KPz+gOKwmWgwpZepVbZHIFKH1PMHb9vp0mVBg5yFJLu7E2lHPrMMavXsm8G1oudyosZwe1sBnxD2jnC8Ns+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVwh2fAa4et0E30LkxEibd3mJFCXN51XyxhYtd7WoaU=;
 b=MNdikzOSDZMhUMpA2w+sa7fRkYLNQRUyT77kcpUFiA8atSEdBzu4NMnU4Ht2iFWN2P4EboQMUWCpiPI8mbYpzg/Qb6v2aSmTyjHdhao9z11RHZel4zPZLfFFyj3ZtaB3Fem82/WXCU39Y9D56h+PIxZ7yKkE/vT9x68z95m1PaY6H7dkaPBc0lHQPaguXDxTIRe7dlleSZnZq2jguwQYsA+iijZRfzuEcBVudfuB+TQAWRHCEEBWKKc/9EyLrYbevpgDD+xb1goIIbURsnEefhRrZ1+Q2Uffsbh+N7p1mpYeEzta+lN2jv3ldAW9cg27swSsIihQWwydPwzBDitB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVwh2fAa4et0E30LkxEibd3mJFCXN51XyxhYtd7WoaU=;
 b=MBUSrcK0seHiegpug0h2SIE7/iWsIkAmGxIPwSstvW16nTbX/TMewsm0SxwvDgQCpZCjhCYz89gdJpUYxc55vn1hW3lGExFmuSt+/7ODstDcu9h5ud6Ai47J3TXhTN9cuIRz9NUrEZmEP1rfVbOvE23noMKSLXdNLyCZbLhUV7c=
Received: from MWHPR12CA0040.namprd12.prod.outlook.com (2603:10b6:301:2::26)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 22:08:11 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::c3) by MWHPR12CA0040.outlook.office365.com
 (2603:10b6:301:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:09 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:08 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: 3.2.82
Date: Wed, 22 Apr 2020 18:07:47 -0400
Message-ID: <20200422220805.15759-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(46966005)(6666004)(5660300002)(4744005)(86362001)(8676002)(478600001)(8936002)(82310400002)(47076004)(54906003)(81156014)(1076003)(70206006)(36756003)(316002)(7696005)(6916009)(81166007)(356005)(336012)(26005)(44832011)(82740400003)(4326008)(2906002)(70586007)(186003)(2616005)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6c4a539-3cee-4cee-3b95-08d7e709a483
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-Microsoft-Antispam-PRVS: <CY4PR12MB19090B6C8AA996DEEB3D4DB48BD20@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8akvEXNgXgYqyCtOgsU81rV3YtgtUtevNsftvgW6U66ejD1tHMLEvAJCp7lJVGeg0fxuZrRx8naFeR+gVAR3V5APG6U06N9zhPkH8coZYTjQB5TL55qeIDeLPDyD9owZKeUa3L3xQuge7CjDAk/MOdQ7KUQJioprix6MxeuodT2DONV5pl/KlcUQ11MRJCkA5Ia+oymAUw6XKkrilVieNnfEXRiHGwpiWFq14oSNtPaGn+19nZKsTKRI8KifjuXOpVsSKGfu30V7JT9w4KG1o7ZX2+Lvdq4NBywSpFAxzUP+lplX2Xp9EhvtQnc+JhnIJ+JD87RQsPypS5SmxlklCdg0QPyGlBebKLCKQA3BJrB1IYA3MkGJ2k+17gdAJEGxF1hMFhd2T/8Vp7raodqD0ywEP9Brcf2EunFulTOYgjILYWHvv7my5xTwrZlj/E++iK7D+UBmh/kUURIe9jMMOC/HiQwKE+Z2+4GTaq/zbT1iDvtZ85ahkMHihvaOGrOqNj9WSU59e64uPfXkchO0Cw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:09.5371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c4a539-3cee-4cee-3b95-08d7e709a483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5432ca1657b1..84e5056521a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.81"
+#define DC_VER "3.2.82"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
