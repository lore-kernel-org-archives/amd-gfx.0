Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA3C35246
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE322082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cvV9rxcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE322082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F4D6FC3A;
	Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69A36FC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDdJxAiNEnLokhytvEhjugJ8BMztsiHxqsRqkZLJbOgCC/VQN13lM63OSIhnrTCyUIhOQLTVf/IOe0b4zSdgpk2LiKFETiPGb9FH+ydZLZjx3/4xTpuK88MKnk+8BIG/rYnZgaemkYKTp2EjZrB5RffkRWY0PXzNX6ezCTmfypiQgtY1FLvkgoGWv4J7OLOBrwfqlbI8Ql8mnhzURrBCrXLwy4AT/A84VfpwxnnfVC5CYkz49L02QRc/3WJfHbJNU+nC5v3eZkyKjxLSOjJrhlJLuXKqbM/9Kw9k9Zh833PEV+zLDd2Dg7CD6e0LwP43bgzjLYNDSON4jvCkCX6jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyQdz14/ZMKIA/stR2XUAjngQw42dw4l9gonuH0YfRo=;
 b=cKw4vF2SajfQfWN2NYI3nh1i6egstES66fFXQQ1mjXQQW6ZnM8AsgQpUKk9AkdUk+dtlTJGVi6ULpdsnjBrTZ+E0j6nq6jqdnLo04VohUGuV0NB+KVd4E7xmdbTHGb52ljKlxgeMjUXS56U2YKlycF7O1iOa4Qy+SdZAzaRwzGaasbkW9GiCTUDH3bOpxD9AWcejCCDO3x4i6EGtzcUlQvlmuvk3hn4YHSqv51+9FzeEVUk8Hb1e9XE+Pbtl9bOMTuWFuYfSkdkDBgZexO9AzzBclARICeYA2tOBDnSeyQIt9KViYMg7UIqwDZKMnH3hCXZZOdqNWNeM/lCpHCNzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyQdz14/ZMKIA/stR2XUAjngQw42dw4l9gonuH0YfRo=;
 b=cvV9rxcs60kvc2M9n76DhzR7irbgCEYZmWM580hk0uyeojwTLSG9Gk2Ga1mVx27oW4KQaDR1N3htGpBbER1U1CyF9uJ3ris+3rh8+1OKb68coby/kg6yA7FTtdnu6zpbCRcoZl4rjQJCb6Njm1lJVqkZVbOZdrxXssuROtd0QNg=
Received: from DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) by
 DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Fri, 31 Jan 2020 22:17:09 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM3PR12CA0088.outlook.office365.com
 (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:08 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:07 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/33] drm/amd/display: Update hubbub description comment
Date: Fri, 31 Jan 2020 17:16:27 -0500
Message-ID: <20200131221643.10035-18-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(189003)(199004)(26005)(54906003)(426003)(5660300002)(70586007)(70206006)(6916009)(336012)(2616005)(7696005)(478600001)(316002)(6666004)(86362001)(356004)(2906002)(8936002)(1076003)(36756003)(4326008)(81166006)(186003)(8676002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3804; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7a4adc-2996-4efc-206d-08d7a69b502c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38044AF41504E99F1A660707F9070@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkSWDJnSGKg+JihuaS0wZcfSOK/tZcNpo9BEV1+y5zOgkCFNuUPGmgWkNFqoLNY4Kf2155YMduY+TU5u9mASs8IzxlBNYkmW8S9f9ludaTJEFN2ZHiCRaDxrcii5EaiLs5nx8D6dp2QaSG7p+LvMMk7AgBkiuvWAaAxVMkGZdhtVV8UfemclwTIgLeQizmbq2p9LjCcg9P3z/YWaDBg6tNn5Ow1LIVZ3H2luIdkHkEjAkX5IkZF0RLxO8U5dIqg0psxLup6VGOy9fE1axbKQ9buBR8QiFb/fueUXlj8AZtaH25nrPO0AsZdKvtvnsylwpQ39HhRVNIP8Xm21UvJ2JdA2OKEL9COVcMTIYLX92k+IG1kmPFCl2FBha8gHy87Brtc6Z/23d8558jwzC728q3tVLtriK4hH/f8vr/C1DsuPyUYgxOftT6b8qRD4yXhb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:09.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a4adc-2996-4efc-206d-08d7a69b502c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Peikang Zhang <peikang.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

Description for DCHUBBUB_TEST_DEBUG_DATA is changed to avoid any future confusions.

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   | 63 +------------------
 1 file changed, 3 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index f36a0d8cedfe..870735deaca7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -147,8 +147,9 @@ bool hubbub1_verify_allow_pstate_change_high(
 		forced_pstate_allow = false;
 	}
 
-	/* RV2:
-	 * dchubbubdebugind, at: 0xB
+	/* The following table only applies to DCN1 and DCN2,
+	 * for newer DCNs, need to consult with HW IP folks to read RTL
+	 * HUBBUB:DCHUBBUB_TEST_ARB_DEBUG10 DCHUBBUBDEBUGIND:0xB
 	 * description
 	 * 0:     Pipe0 Plane0 Allow Pstate Change
 	 * 1:     Pipe0 Plane1 Allow Pstate Change
@@ -181,64 +182,6 @@ bool hubbub1_verify_allow_pstate_change_high(
 	 * 28:    WB0 Allow Pstate Change
 	 * 29:    WB1 Allow Pstate Change
 	 * 30:    Arbiter's allow_pstate_change
-	 * 31:    SOC pstate change request"
-	 */
-	/*DCN2.x:
-	HUBBUB:DCHUBBUB_TEST_ARB_DEBUG10 DCHUBBUBDEBUGIND:0xB
-	0: Pipe0 Plane0 Allow P-state Change
-	1: Pipe0 Plane1 Allow P-state Change
-	2: Pipe0 Cursor0 Allow P-state Change
-	3: Pipe0 Cursor1 Allow P-state Change
-	4: Pipe1 Plane0 Allow P-state Change
-	5: Pipe1 Plane1 Allow P-state Change
-	6: Pipe1 Cursor0 Allow P-state Change
-	7: Pipe1 Cursor1 Allow P-state Change
-	8: Pipe2 Plane0 Allow P-state Change
-	9: Pipe2 Plane1 Allow P-state Change
-	10: Pipe2 Cursor0 Allow P-state Change
-	11: Pipe2 Cursor1 Allow P-state Change
-	12: Pipe3 Plane0 Allow P-state Change
-	13: Pipe3 Plane1 Allow P-state Change
-	14: Pipe3 Cursor0 Allow P-state Change
-	15: Pipe3 Cursor1 Allow P-state Change
-	16: Pipe4 Plane0 Allow P-state Change
-	17: Pipe4 Plane1 Allow P-state Change
-	18: Pipe4 Cursor0 Allow P-state Change
-	19: Pipe4 Cursor1 Allow P-state Change
-	20: Pipe5 Plane0 Allow P-state Change
-	21: Pipe5 Plane1 Allow P-state Change
-	22: Pipe5 Cursor0 Allow P-state Change
-	23: Pipe5 Cursor1 Allow P-state Change
-	24: Pipe6 Plane0 Allow P-state Change
-	25: Pipe6 Plane1 Allow P-state Change
-	26: Pipe6 Cursor0 Allow P-state Change
-	27: Pipe6 Cursor1 Allow P-state Change
-	28: WB0 Allow P-state Change
-	29: WB1 Allow P-state Change
-	30: Arbiter`s Allow P-state Change
-	31: SOC P-state Change request
-	*/
-	/* RV1:
-	 * dchubbubdebugind, at: 0x7
-	 * description "3-0:   Pipe0 cursor0 QOS
-	 * 7-4:   Pipe1 cursor0 QOS
-	 * 11-8:  Pipe2 cursor0 QOS
-	 * 15-12: Pipe3 cursor0 QOS
-	 * 16:    Pipe0 Plane0 Allow Pstate Change
-	 * 17:    Pipe1 Plane0 Allow Pstate Change
-	 * 18:    Pipe2 Plane0 Allow Pstate Change
-	 * 19:    Pipe3 Plane0 Allow Pstate Change
-	 * 20:    Pipe0 Plane1 Allow Pstate Change
-	 * 21:    Pipe1 Plane1 Allow Pstate Change
-	 * 22:    Pipe2 Plane1 Allow Pstate Change
-	 * 23:    Pipe3 Plane1 Allow Pstate Change
-	 * 24:    Pipe0 cursor0 Allow Pstate Change
-	 * 25:    Pipe1 cursor0 Allow Pstate Change
-	 * 26:    Pipe2 cursor0 Allow Pstate Change
-	 * 27:    Pipe3 cursor0 Allow Pstate Change
-	 * 28:    WB0 Allow Pstate Change
-	 * 29:    WB1 Allow Pstate Change
-	 * 30:    Arbiter's allow_pstate_change
 	 * 31:    SOC pstate change request
 	 */
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
