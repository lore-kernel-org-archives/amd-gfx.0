Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520E0206A4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BbPbsn67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520E0206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B6B89CF9;
	Mon,  1 Jun 2020 17:28:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B77A89CF9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 17:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr41xepGcCspisz1zIwtqTZg6u2cmIvIuLc8xQgK6Tm4L+1/Qno7NEUVrQRJLhdIOE/xuu1GpMi0D35TyDx0NNlySLUM03lktSNgO+SgC8T+AQ7gjptTMFtZiOALPR+Xgt78hE4v4caN/xPHFC24uznPUxqpA++wkekNxX/9WfC+g76nJvLCwxIQzFTnJPxAegDOk1MFYVcXPmA4eryXUpXDN/Hcj6QsPMwpD0vCI6+mfW/68SjOHpjk3UaoU4T7Zf94YzwhP5z015J6muhHZD33B4teW1p6rHxivgjApd0F+heeMohSn07syec5RhXhBG5kLUO8TA688p09BGVNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=AFsRfZNrKu0IEGrQMMJ9QhHoJJ6GbdRcZgFgBIDUhom4432Uwd/G12UAHPbLC5OIj6WBbvKHgsWINAXc+/gUCdF60TKqa6AYfzn9qx8t5dD2buFPBltYpyYpogCksArFQ3ntWzizMJhHOHr6fr3vSiQSS/dWFquM4ClDOfY2uPVvXJ35CZLkEkGTX8n+TRFO0E2aEjTcwcobM8GQphXknJv4UWFq/bJVFlGYsajScWbqvnj8vAlPyxsfQUFRrFN0rJySXLK8gn3R2tRqUIy/ZT23QiM33cTuBPPKgfAB5dej1UnsdIDwFdcnmmTqPQjV1u3WwYvaUAZc89utPJ9ANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=BbPbsn67jl/X5jDjWZ1IJphwy9bamnxwt8mqfKRjioGOXvJka7hyPe0c4Cczw42ziR1KJ3RbjYfP0gD+rU786yJztM1dy29nBAFIAS226X2NqOezD4Zfw1b5RuEV8bYLFcsDmQvlF7f9VVljooTYG9x8RM3QKp1A8Z6DoJVBhuY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 17:28:28 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 17:28:28 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Date: Mon,  1 Jun 2020 13:28:17 -0400
Message-Id: <20200601172818.5560-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 17:28:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19182775-be7a-4c35-0b42-08d8065132a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26684CB6D051147277107B9A858A0@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VrTlCc4EYXEbvFHBWIZ0APikhfMsrxTGhSmDhnp3loO39HHf+s3hvQ52M91GLuToWAGLjKUnepYCgpsayDrkpAi9990oZF6o2MgyfIq8n0mIhMdziQMHgEQzknTSKk23eOZmMVXhMfiQ+1g7sQE2r0f5a/esjmTphwm1iEV6G1FLEZMKF4tdnflZi/QRBRLspJR6LFsIDsH3qdb5jm0ZOYXZcM/45tjRLNYWduq1YSYdCnq13AZVNeEcLWdksfC8BgA4I122kXXs6UOpmTTJS7MZ5Dvsk7hcdejGbCu8GHi9JE8nMIsWtuU8IfTxh+p0TWUkvjqZu8qEDirH6euGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66476007)(2616005)(44832011)(956004)(66946007)(8676002)(83380400001)(4326008)(8936002)(66556008)(6916009)(316002)(36756003)(5660300002)(478600001)(2906002)(7696005)(16526019)(26005)(6486002)(186003)(6666004)(52116002)(86362001)(19627235002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KyPluwdejBJXk5FS+cK7QyTzNL12FCbsHewm4+C1AV5omxsz8VF5wS7Y1qmY0v6hpq8mbVUdua6zx2RttmzG2Pf3sFmShYRsUN+THb2Qd3/5AIVMqAiPvcWwmgyogqjad5IbIV5QnnmagSDS1c/uWUHY5xBM+Od29jMcSdsHXMwYGUr+D0mPpQd1DXnNtYZS+Gtwzkeo4693AgYwEeo7N6bl6nqsNDBfW4uectTeX6y7BaHImBmL3dQkmi+tJZKV7ZqbbAeLVHGB/AGPLVzkU6D/4N3xHSBQsVhHmVRUYm5UYJwQj9FXhLdTzOgasOwhEj0TiBTBGiA9kPBKOWjFBCAly4apW/rCnDYju/rI5rIwvv2krc72jv296JXxt51jxeIPGmvt+UBgAmvu8pYU4rM2mo1QQORe/nidNTBGM30DzhtODIaM1AEkC91CIFDQaxxTP13i6xvBME9Q2CLLfSajH6kd3e5qnoUD/MeRag4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19182775-be7a-4c35-0b42-08d8065132a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 17:28:28.6712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDnYdr7ehK8KlAKM7OkQLwcVOG5L5tTruReY7PR4Y6W8673c9IQK4JVVDBjTf60kxwJLBeAy2oKfJ0zimBuLsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the ReadSerial definitions for Arcturus to the arcturus_ppsmc.h
header for use with unique_id

Unrevert: Supported in SMU 54.23, update values to match SMU spec

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I9a70368ea65b898b3c26f0d57dc088f21dab9c53
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 302b7e9cb5ba..d66ac7457574 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -129,6 +129,8 @@ static struct smu_11_0_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable,		0),
 	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl,			0),
 	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl,			0),
+	MSG_MAP(ReadSerialNumTop32,		     PPSMC_MSG_ReadSerialNumTop32,		1),
+	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32,		1),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index e07478b6ac04..79afb132164e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -117,6 +117,9 @@
 #define PPSMC_MSG_GmiPwrDnControl                0x3D
 #define PPSMC_Message_Count                      0x3E
 
+#define PPSMC_MSG_ReadSerialNumTop32		 0x40
+#define PPSMC_MSG_ReadSerialNumBottom32		 0x41
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
