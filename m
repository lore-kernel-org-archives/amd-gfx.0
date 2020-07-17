Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6402C433E8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B54020737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AMwfPAft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B54020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27B56EE1A;
	Fri, 17 Jul 2020 17:38:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE2E6EE1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbN1VTuAxq4ZCfLhrOfBtiaC8bNmdlN/CdpueNyg3Q7srtHEnyKhw7TYGdm0r/4HH2to0ej8rEd4TL6D0PzvZmGduc+AEn5kHp3tofB/mf5/zxW9wbByuHiZjPB0/ZwpEIKHz5xq4eUL3auUN0B5QZmW5y1clNwsMzNsPd1sdUE0vdbjOsx0ndabXn8g8v/6uO6G708ruswIwKcxWmdR/LXuf2rrntURiv/t4K3Xd4EcXclGv/3Iw5X+5YwT+Ula8l+jwCAq1bByEkGzlqpuU7u4pBlDBiO+kDje/VIq54euwMsvrEJcZdyUT4GNRWNhtobgnEMxd+W4JUXKnmDIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMMrUm1lBA3fFREAKiRwh0na2p46HEftt8DriL3tAng=;
 b=XM4ujJsPxMyP9V0EhhdmuPlBfjuJW65X7upj9kC81ibDOwZmprXjOO7/I3AvkedBzdUK9Xza9YKWFN5A2rpSkoMdOnU8hLabULQxB2vlALkQgSkutr4MJKU3udmGQSqYhY15pSeMSAv3XoSA8AqSEK+QF+moQ9QZY/nskFiZD2iv9Z8j3jgmElw4hJxcHmkIo290X12hJEusA9jGaqzfDtAm4yceeiEO1nZu41RaMA4n1Axyz6pKZSFcE9JFTVm+xR/ww+vxxqt34GUIqSObkOmFwFO4N16sVcK6v78rKA12a8vp9kADPxCqwOCpc/H6W654QPbW7RvrmRRJ7ipqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMMrUm1lBA3fFREAKiRwh0na2p46HEftt8DriL3tAng=;
 b=AMwfPAftM+dht9mGa1izlXSU+XQZTHkoX+rroS+x4FQ5AvNmQTyE8NM2WRsrQNwQPZEPtg5yeSDXnnYOYPf4mp9UA/9BlUa+8prn5Ws9IhicLpp4jJVkPT0eZHIVKcbXivvjjlWpi/Uk7MKcawKRloCk71RF9BZAMamLo5es5gY=
Received: from BN6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:404:4b::17)
 by DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Fri, 17 Jul 2020 17:38:26 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::ab) by BN6PR11CA0031.outlook.office365.com
 (2603:10b6:404:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:23 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:23 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: [FW Promotion] Release 0.0.25
Date: Fri, 17 Jul 2020 13:38:08 -0400
Message-ID: <20200717173813.11674-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(6916009)(478600001)(186003)(26005)(2906002)(336012)(4326008)(316002)(426003)(70206006)(54906003)(2616005)(70586007)(8936002)(44832011)(8676002)(47076004)(83380400001)(5660300002)(6666004)(86362001)(81166007)(82310400002)(82740400003)(36756003)(1076003)(356005)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8053c28e-49da-45dc-935f-08d82a7835a6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452487E2FAAFC431892A1ECFB7C0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSozqvWR5FTUMYb/xwKcNsQ9M3OkkPDDYdlrysKggDCVw3iqmT3oCk0C5O9mMLTbAL4od9r5gxq7Pn/jpEkaHnyeP9zZFotokzVOfNk+PI+/4ys6r0GSGz2BKFu7UGhtjhv6oXlIyi/t2oP6gAlHTemhJr+W1ozvp2WAsQNIG7XQ5KMQtDJw+o2xLIYehF4DDmLnvqkWbepwWu/T91jOOxUWV1xE+rdAzLyZ+A3V+Sv4fWeXZp9dYAgykE2ESl+1VAyTNVvMWyIphG60rorFdeywRSKNx6zeYvJtaBu6Q4/MTfFiJmpdkZwyegCYLCPlCONFxynKwxjm+n8HP9K5BDos9dE26sZzxxhGb6LZo6Rajhx8QBfBA8x5EoK9ooasoC1S4DEXfPBW95sh32t9HA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:25.7056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8053c28e-49da-45dc-935f-08d82a7835a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 513a5f8f817e..e013875b89ed 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf675c6448
+#define DMUB_FW_VERSION_GIT_HASH 0xe6d590b09
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 24
+#define DMUB_FW_VERSION_REVISION 25
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
