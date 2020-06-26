Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E486C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404DE206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f702UW//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404DE206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97F66ECE0;
	Fri, 26 Jun 2020 16:20:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3016C6ECDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTx/bbVbOeRKUCBjg/awbjno2+wDA0vvxWfJc6F3G+KHpLgMWrqpjjkvMLd1xB3pONJvAFDpNNJel2tKhaER4aVdLnBV+2SJFB7QKY/TLxhYZ+yov0aWa0f+lKhEFPW92fZ8f+PX6f9QDZcALjYSkE5sLJJw+15oad6kkrM8ZzdfR0/zXkGP4qEAtxugO/wIbiJrb7qvvyhjPNK5cZRCCJh3zW0NC+nwC3pynIFxC6wrlnoCC1/zXnWDfguWQtUJdNZTwzidUvK6j8V+woyfNPnX3X40a0UOlXB3uh6mF6YvWIgGnmI0vcsdN2a/pb4Mwz3eXsJxQUwepoEwZa1h5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LozY1KrAvZTrj85aZxupMjNsKwzNxTyoBkfl9pxUvdc=;
 b=QHYJjIyAtTMWe8TOZixUzM3ZSzNrqjjC07egGG4favqwG9xhH0wDXm3NQ7fwIbRGdrEDlso42qrX5en04qfIIhtFPbDu9wKGo61oxlg/0YSQ29riEiZbB9w5HCdL8GPDG5E1z+St3zzhGAcqATV447/TERPnv1E1V7ON5nRmsTb8YgO1xgvvXFuKs1qvfnXHr4MmQ/pjBD0jTZIJSWxMnjLdkll3Q83jQI3CTvcqkAjSItccap7z/L3dA1y2ABQyFj7+1FlubwM92pYUXy2c90870sM/WWihuqaSxmnd8jlngDGOJzFu2ybpebex1R/MPa/MGVCT/GBFL65b7XJZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LozY1KrAvZTrj85aZxupMjNsKwzNxTyoBkfl9pxUvdc=;
 b=f702UW//O5vkvXTFfxU05w1JbgiIJGxcnTK2Itow3jz/paUaBZ5dIkYEybPnNlSSzRh2d0TeK0oC465KW7NnbZ85tsQvB/RekpLIsZZe3e6v6YEssU8erkYlwKTXIJyNRSWW2TwOqonUNkfpQlKUm1cKqcaQNY1yKourm+5PMHQ=
Received: from DM5PR18CA0073.namprd18.prod.outlook.com (2603:10b6:3:3::11) by
 BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Fri, 26 Jun 2020 16:19:53 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ec) by DM5PR18CA0073.outlook.office365.com
 (2603:10b6:3:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:53 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:52 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:52 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amd/display: [FW Promotion] Release 1.0.22
Date: Fri, 26 Jun 2020 12:18:44 -0400
Message-ID: <20200626161847.16000-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(5660300002)(44832011)(426003)(336012)(2616005)(26005)(70586007)(36756003)(356005)(186003)(4326008)(70206006)(6916009)(81166007)(82310400002)(1076003)(82740400003)(47076004)(54906003)(8676002)(478600001)(86362001)(2906002)(83380400001)(6666004)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6354b733-f169-49c9-6779-08d819ecc20a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35552E3DF7D683B8AB613996E5930@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu/tv6a1EqCepA9uA49y0fGqoFWJDCwNzJDKzjIvCl3Tgl6u5jsnpxgPIY9GoAMqwFMZ8aEzsUOyX8JoxKE38IqjPyZs3KfKo3oNR0qY3V+4QbQWN90TSDbDpZAJxw9oxI5ZqoVRjlN2Cpht0EOUlWsV8aHBm+M74WU9GfXGik+FfEZJnljpvDXNXiF14slS8O3/x83ojISQ/6NkZZh4XKIBmzfvawoCuwq4gMJ+NLt8MV13t55TXVtDOCEn0sEN8Pa6cZS3wQUjmQUmf+MQb8qhlXyRovZeMvyat7xBaR19zIZkFBox/Sh7eUhtl+b3P2oJoccYQVRoENjp/zNaoup0PgtW7O/Dj/N8I3JW7uLlQB5ltMDMsPVOUOP7dRLtrSUlmcomuU3fYQ5+W60tXQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:53.0493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354b733-f169-49c9-6779-08d819ecc20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
- Add command for notification of active streams to DMUB

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ed88d42cb16f..d6c7a20c23b2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x6eb25fd7d
+#define DMUB_FW_VERSION_GIT_HASH 0x5b1691c92
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 21
+#define DMUB_FW_VERSION_REVISION 22
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -260,6 +260,11 @@ enum dmub_gpint_command {
 	DMUB_GPINT__GET_FW_VERSION = 1,
 	DMUB_GPINT__STOP_FW = 2,
 	DMUB_GPINT__GET_PSR_STATE = 7,
+	/**
+	 * DESC: Notifies DMCUB of the currently active streams.
+	 * ARGS: Stream mask, 1 bit per active stream index.
+	 */
+	DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK = 8,
 };
 
 //==============================================================================
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
