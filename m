Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CBC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506C02082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tnrERarf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506C02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57096FC3C;
	Fri, 31 Jan 2020 22:17:21 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6A16FC3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkiVs/4XAO4ye3FYiv6iSRRCpNTHhcz4/oN/46vS8asBa+eOT0Lntfu1eGvqwL0ETRv6sF6oDbcx3adoIDSnmNidq0YGD3fGfVpCKTLnUzcuP0iD8YiJeYg2SCe9cXAayFzXMqzp5AFHvjjf6WrrPQ+VzDy/cFKsYNnxx4+XF3PvzKRlDh1bo+p9Edh9dzHCNXAgvUQKCf1Kk0vgsLpVXPaQ0pKXlSLgUzAHR6gVyJKbG3LIJvHJrJnY7tdXJWCyrlBIwXY0pfU0gyCHLD5+8owv+zDR7Xqst+3u8Oa4e9ceWo5ZQEirr0VKUSdkYfc72QHi1vgGh5T6YItsNUGlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKFy3yGP2zkwAxnprvd/5wOhh3meH34QuRSpc+c4pRY=;
 b=nMxxEI2JahzvPBxeP6H5tu2GtEu9g+EhDytqymrHU2/BmzYs/DusYdMOeYCOJANXMki6QPBdRACS0X1Ea7g11V1SNEatj+6RzmgFRqQ7NVzr5eb5fHD7Idsl9q8hXtYawmSLXK8WHEcTm6+XgV6iKtz+PSQU1DhlUaGpZ8wIGoYKQFHGsyBAiOysHbStQFbPjVW9d0rZQkEEXqXW6koTy3+UZ6zNViX4GA0mOv/vYGak4wKZ+mdpAoT/NYILUU75JSeHg8hUbkdJwuT07Zpos6I5KKpFLdI+hsIA2WaSbIdi6+XYwpajwoB19MvKuXQMJPL0e2oVp9BWSX0XcOijVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKFy3yGP2zkwAxnprvd/5wOhh3meH34QuRSpc+c4pRY=;
 b=tnrERarfuahgVDJdOQSpmRjxAu+LfQeMH9VZ0H8XEUWA4fKpwQavMalRJng1CllMZIh3Fgjb7e5Qkx2TGEDlaTTtpsNrxdfruGNgTeCpJU7tJMR4sYI+4yBP8DNeKEiA2WmxFk1RW67CDDfdH3Q7rEhP18ZDO45MYUMl1xd/6nY=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Fri, 31 Jan
 2020 22:17:14 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:06 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:06 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: 3.2.70
Date: Fri, 31 Jan 2020 17:16:24 -0500
Message-ID: <20200131221643.10035-15-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(428003)(199004)(189003)(7696005)(70586007)(356004)(8676002)(4744005)(2906002)(70206006)(8936002)(316002)(26005)(478600001)(81166006)(81156014)(1076003)(6666004)(54906003)(5660300002)(6916009)(186003)(4326008)(426003)(36756003)(86362001)(336012)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3207; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c923727-ebaf-42b3-5032-08d7a69b52d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR12MB32074D55D2801010DE183874F9070@BYAPR12MB3207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA/nz7k7KECvfib6LVYKg312Dzhh6l0/8XZSPHigMMRZMCb1UKIqmJ2k4TUxM63DuaMAZm4qS2kZlFAuKWEnUhsW4K5nRlmZsaNDGQ+5JXKfUOQ/Xiz7IAq7KpToucvOMV3y0EglI+/pyEbw578KnVQTHTvcIXEwDuX7Lvdm+PwEMhBiyCvAMsFdik5JO0ali7Wwc6piBMMmHAfKXQ5H8AY5MFO7gyoEPY+Tv+82MVWBPH0uIV4HssSnBqgDKrWTWz4ZqoHYI5968/NW8EttL3gZVbw7PvVkfrMpLJi7U+ih+1NrGkIh0MfbPnxY9Pyy6LlHY5X0JoAh7P5pVIl/5h/2YRzYukxo0xxYkJTuF/E90vQuk0GxOP2I+xvNFyUlAWXtPoFX8nLTTCOnVzVXsFy5Fi5kqcE7p8mrs743etKMUftOuutgo+II7QEUOEAR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:13.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c923727-ebaf-42b3-5032-08d7a69b52d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3207
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Aric Cyr <aric.cyr@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d00b72df469a..7be2023f1a66 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.69"
+#define DC_VER "3.2.70"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
