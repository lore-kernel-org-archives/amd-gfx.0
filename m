Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F496C35659
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568E2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QW+jxg3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3568E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911BC6F4A5;
	Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124CF6F4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft2xiY01TE/W4Ilb0JKXatTzKHLtpZe2QQhscN6L4TH/pVkCYiQ9NZrojQU7yp2y3gJk1wFT5DIvih3hgXKgre4k8nPLDviis2HwLxV9L+wzMQJf7ajPBFFp3/mQddNE9EW3v6MoPcGRLB9kja+GByw9W/ulWNESsx3QZSMUMAK35CcXcKX8PIZIpqeYsH6mDk+4aVYRBVpY8LrKkC9nvLzx9exB/kndtNk6tXCPbDlFlnb7HC1VVoVMsY4s+ebP8e7JHoQbgpHRsAvPorx1V/pi54FH/h77PYL6haevpT0E6quR7K0Q5en1laKrEthzt+3p4SFIGH4Oj8DhRlT/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtKtGjIOOM2tzzHXiunaFq45AjvJKkaQ6lcp4plLpbo=;
 b=AYLARUH9hJwJxXhzoCbflqvIHSsKjPzZ8IpDGTy+OTM8aY4vz7cBDPdYHrt9ZLmbSuQhUnBZ0i3+pn/VsFgaN/lEWB4AIsiLLHV3uV821KngmEslMxDDTA4cmvLfmJmr36lZ0l2Du9MPggE98DFRmWWK9TCbrJtnFzftvK68Kl0JBNVhrmkaTim5spi3V5TlFycXKum+PzOxNDEgBsw6KGO7fC0h16RY/jJw2WrrXfxJQzk548PeC2wqnQvvarqgxuvg05B3y4YdRQQBSGxqkMLvWd1fqYVgzqY7In0cUIcxAbw+HgktL6KW2EQLTHJTWtwS0LT6o3wDUvKcOFHt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtKtGjIOOM2tzzHXiunaFq45AjvJKkaQ6lcp4plLpbo=;
 b=QW+jxg3+PwOW2HK+VTFTLIqsnzhgSq9B3jzlDDgawu9+KM0SVzdiNcrnRBQeeWHA7fQVKTBqQ18V/Pmk22fB13T4xlA6QDm+LQjBU2A7nxlBFVYAYfbJncdPsowz0tzqRVArSDUJTiTCOmeeuzzk5OXzyLMIcotqzf6UkSB1OOs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:57 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/35] drm/amd/display: 3.2.73
Date: Fri, 21 Feb 2020 11:03:02 -0500
Message-Id: <20200221160324.2969975-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c0b1096-9392-41b8-a100-08d7b6e7a767
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409714930D02BAA8A49337698120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(4744005)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYL3kjXjouuIH1TX5t4mKARyba+BusE2KqUtiaQE0aYCE2ZiKDy9rqzi2vwlW4PD7kZMNEg5xlA2UoN5UpotD2q4q0sjdZNJytQ2KEXZ82KikzBeVwGatKahSjN7SCWOPSeLTXtK392Ht3A391k5M/a7j3g4pKpyB4FNQZeUpweIdfN8Q7HMV7LUvKCfix2y42FsiAbh/6QMmENCBmup3KldYT+odfE9Z/03I96CiftvIljdQWue3VvZs8ZdKom0qCW4+jGLRJymlTnGNw0a1BS6vK53d993fEpmA/aSJK0nuUCMSDjodI1VO2zeYERt7DJsDxnHst/d9ZG8/RiBwfAHrgeia0WcnqrMJcKSfBkLi4A9ckAjKWxxqTe6zQKrLu3bqj/AcBCv8pRUDqo9aWhXGM5C3fsoxqNp9kZORF4vDDc1zpEshvJKoRtRYiOy
X-MS-Exchange-AntiSpam-MessageData: qoMCMnPtzSMlpGVLNq6s47PTRjovOJVvXkuOdb9diB5OpmRh3y3gPQWpjsa2OTZAFqbWHg5n+anikFe+RomSdpvyPQxbnH8yvtMCsP1cDmNAVDyaGRKFxaB6eUvi53e/JYerpYdLM6/8D1/bF50hgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0b1096-9392-41b8-a100-08d7b6e7a767
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:56.1180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI10Ds0tet+jVWJ7WooJ5InIvacXHYbxbkUAAXedVPUqsRprOBEiq8ny7gKAWFh+BFIejxTy7zyn2Hg24O3Cug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f77b3acfeb06..b3f6311d3564 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.72"
+#define DC_VER "3.2.73"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
