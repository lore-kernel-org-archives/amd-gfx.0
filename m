Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2111C352A4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AF720720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aBT1Hy3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AF720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AF86FD0D;
	Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759186FD0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdZlxZP2Z+VsnXUknCs+FpuLG1x+xY11CQML9NxS8VM7YpCTW26+ITXbBlvA2jfMssoxU76zyuh3dgbaW5UgNQXghKVYOpS/oZAKShWB0lMHU+qNjg1ftU5MLACHwLVZzn5pV/JEBPNNkdPqVAEfkNgEUY7/tTfuIxyq6ugqmsRwWkkl8jp9ecH6Xhjns3Rpq/k7oXPX5pyJHkouWVFxWypOL2KvccIc0N7whevKI4D6/MetYxGfvHWS5wJ0WhHzCQn1Y5qC3AGKo9sIKZdJ6sjemcnevR5+tek+CEMfPt4Lyd+2M6WOK5BAbOW2Uu1yLc4js0pzQjA3m17EHKCQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TvWJoxkc6wVaSYZgBA0QzkFVxD6qzr8XZHUzyP14Ks=;
 b=l6LAnB6wj/nSyftKP0OlDZrL1IlkU4qHISJyZ4PmCtiOhglUkZnpH5ol0HaXf6wG5q/bNaNmZW7QI9RtUXlPeCF4F4EyMCKKRmpZQzmzbpZbIYY7MnmX60MAyIq10+6q2oPrvzC4sUkpkIyWicigq0rrOKO/9OfPWaU/yjh2kdJuyHtXFLkG3RiT2dKQttn2O+uR5o5VDSdEmgtr7rqXq3B9gfNEphg3Ot9yojFpjyIqEFIjasIaFVlVowTR7jxXoV5v0Vopcl5Lt1g3UjICbmPFFL8mByhbnZjeAKHzHP+aTZuiks840fhTyxsUN1d47OsDE2ZovIv02lac7pH04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TvWJoxkc6wVaSYZgBA0QzkFVxD6qzr8XZHUzyP14Ks=;
 b=aBT1Hy3pLXASql8jIZfjmxdE0C8KGTnDj8K7QBAoMI8bBQHLd94mVpx5gkBU8COstW5+P3QeWpxtHNs93Nzi0TjOhrlgF4wI8rPohDDUCe2brxU9cpwUPY4s9msIgSHDAjDzR/Jsm2kohWB7hn5PJPGWw3wWE4/Hb3acnb6ra6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:49 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/17] drm/amd/display: 3.2.72
Date: Fri,  7 Feb 2020 10:50:04 -0500
Message-Id: <20200207155010.1070737-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c5b0ef3-4f2a-4f75-a186-08d7abe57ffe
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440B86895CEC7531B2DB174981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(4744005)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYPCSNEPD/zKdyyWL8S7VJw4RS/KEj+wod6sjzmnh6yQ6xD3J41MuwFM0BJ76iAE0+TxHAZFNKdEWWt7UQFo7nTnkFnaybbz3D6L3Q1fYEpOFFFCNuHmkUtj96SYfpEW0ktx3j8s1/EmZqk600Vv7cSCIorPUwvkFeS39pTN3KFVKBkS8m/yOGd1B5agJjx7kd8OEWr+fAR9lbC89TN+tVpZQuDc6h9OIhrvFKtax7y+2Khq1SzRbyZ1nX7/aEXzp+NzJdbCKOq3mv0IA8F93sMnwpRt+g/YcG8o7nFx0uVEAstBl3w5F7grqApAOwmr/1yP2p5q3rzwT60t4x0nLVVDlGZWAirdwu16akxX4Lhkavv3bYMXLiBQ04RCaN6wCyZRmZL60njQWIIey9nchYYwtNlzFKrZCwjCmyM/y0FPJ18+RkXx3IlThQDx9sst
X-MS-Exchange-AntiSpam-MessageData: NeyeY0efJwjSZLBAZ/vjMGwTWKINVHrmk/RR6Hj1x2P4KC4rGOeOTMFuizYfWM0yLfPH3DhpgDPnKM/TqhZp5yFqJLdAgZRq8RgF+5ie9cocni4oowMeV1udkllgFrUj8cgOHG0uiiK9CLuUQRMGsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5b0ef3-4f2a-4f75-a186-08d7abe57ffe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:48.2077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKsLdTeSzuTMJGqC5w42MYSjCemvZ3IJuD8QjVbXIMmi598OUAPb90PbLxMHSfpHuZatNcqjUEBuyIW5gILdog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8c88706040a7..f77b3acfeb06 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.71"
+#define DC_VER "3.2.72"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
