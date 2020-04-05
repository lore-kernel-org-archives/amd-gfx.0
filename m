Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDEC2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C7D20659
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lH7qjR1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C7D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071E06E277;
	Sun,  5 Apr 2020 20:42:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8808E6E2B0
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCsXg3eywqDzj3UMI13uBHH7jK9KdSJpmMXAkrj4s/79ns1zfvtz4yyyYPtsmYG0EbsO8Q0TCzccA6+ENJhDB3ZYKNc4jaA5L+XO7Yb3CJpAjYL1yXBJG0rhgUMPL0FYT9uG75oOPvPEeKFxaP7BLehuKwiv1iWDvPCOQxTA0fxMhPJpZX2xZETI2MGgb4Izea34+dVQ7M/vUvwikzgd2G3+ssh4VNRYowu/N3702XDfb/BUxQZin7T1daUlg+9cL+K7yQBQqyiLhXuKU3XqBNRQLrSUlQ0dsnDJCrsIy9eBAJbOtB1JHvWYuw7MnsQVjFJOFRVOSOSGZ4BwkkFs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vYa/1DZwZ4GKt305FzcsRpD004UmKFlsNfZb+dQXEs=;
 b=Oe3/sebISIyjcec0YQP4bEhZt0hyxRL0aKkh1YYT11kp1Y0cOe9cbYw2HbEAB61lHL1jo4ShEsXlENtWuhp1WEaqfRydCrekc+/f6Rywlj2y5VSYKivaT2JaJUH4xEEIxNqcOvhLTJeo1SY2OpvpvCBpJSPZeitvsvSnm1ZTDznRXsk4kVCrpJH+OXA0XQDMgzH8igJ2vzhrLlOTE1Z1b8pKdQh7L8+KkN2M4etVixb0AgdOapyqkT2mgnZU6KBDDWWhih6ttIsh99rQ6J+BGEsSAjaHzp1ik+32ZvXFmNmwUuQM99gwu7zbk8rsVDo8EBEzAbuG1FxcK+IC/BvHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vYa/1DZwZ4GKt305FzcsRpD004UmKFlsNfZb+dQXEs=;
 b=lH7qjR1HzzQDghoqpOiiYJPA1bbQfqaAUm/FjQoR0gl2ffcgWRXIuevNbARfnRTk6IcMo6rJ5cPkoAoYr468LH7xeSy34gFW3+wNo4YkGJzmfF2eCzfGJSqvdTL0eM+gUjjGYBkPUrIvCSDJWW6MLqMjcanaHZJXj+zfMw5VzFY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/36] drm/amd/display: Remove unused defines
Date: Sun,  5 Apr 2020 16:40:59 -0400
Message-Id: <20200405204115.683559-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:57 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bdf0da0-2521-4f24-73cc-08d7d9a1c937
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555D56FD067371618267CC798C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3xQGZl6oSVqUUpwdEzUOSEnw/psVIoWbO+ELdHIt73OALzgEs2WA5aJOgQRn0Nn0P2ePH4/Whv7VztUQMA4Zx+t9uENi/XYdWjgnVN33HsbdPSnsazDeRZbwNrPVt6b3ei3V25PTfa0bwAQwqH9WTs88dUNpSzs0A63AB3t8QmP1kNzG9Orw8zpwHno4e6OpwuY1jeZyltHr2/57d3g54/OHttY9qOU8m/P16/XyZLP63Q6WMYL9D2VwKAgeCqHMoomdyBt+mgVlkg3FyfJml87hLjS9Xv0xsBAAbJxUd0FOEiYLKkxSa7WvNEGKpr1G4SD7O22gxxUbzyRoUOKnBasjIgCME8BJlRDU0nZ2DGYfpjWH2xgeu6bYd5j0PtFSHoYYBOv5HTtFlSADQr31Flr+bD8pui2uSWO1jmP7FEfHqoavScngTh6BWHbXpVQ
X-MS-Exchange-AntiSpam-MessageData: sWw7fZDd0VpfkG4R3+CARGqYbd+owTvbH1krEiq6e6mamaoHvk5tBkthCJjx5JePNF9fOxi82qx8P9fcz6vDueFYZNugthxL2iSZFu3Iv+ChteC//eP3KRe33tCuhq08v2L6nhmGNyiGjR7V0rhhxhVSzuj1jTjZJzzbCxTV3ZQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf0da0-2521-4f24-73cc-08d7d9a1c937
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:58.7049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU3Q2/RHaqZYwMmSrY1g538f/hQsfgH8/2Ac+FYWdBC5HQ2xlgj55IzDZi6pMd77d1wzRpq83+sD5nMrQDLt+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
 Anthony Koo <Anthony.Koo@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Defines aren't used. Remove them.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |  3 ---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h    | 14 ++++++--------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index bc109d4fc6e6..31a9b12ff880 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -60,9 +60,6 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 		return false;
 	else if (stream->psr_version == 0x1)
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
-	else if (stream->psr_version == 0x2)
-		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_2;
-
 	cmd.psr_enable.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_enable.header);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index d37535d21928..cb52ebad0ef9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -32,17 +32,15 @@
  */
 
 enum dmub_cmd_psr_type {
-	DMUB_CMD__PSR_SET_VERSION	= 0,
-	DMUB_CMD__PSR_COPY_SETTINGS	= 1,
-	DMUB_CMD__PSR_ENABLE		= 2,
-	DMUB_CMD__PSR_DISABLE		= 3,
-	DMUB_CMD__PSR_SET_LEVEL		= 4,
+	DMUB_CMD__PSR_SET_VERSION		= 0,
+	DMUB_CMD__PSR_COPY_SETTINGS		= 1,
+	DMUB_CMD__PSR_ENABLE			= 2,
+	DMUB_CMD__PSR_DISABLE			= 3,
+	DMUB_CMD__PSR_SET_LEVEL			= 4,
 };
 
 enum psr_version {
-	PSR_VERSION_1			= 0x10, // PSR Version 1
-	PSR_VERSION_2			= 0x20, // PSR Version 2, includes selective update
-	PSR_VERSION_2_1			= 0x21, // PSR Version 2, includes Y-coordinate support for SU
+	PSR_VERSION_1				= 0,
 };
 
 enum dmub_cmd_abm_type {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
