Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E42CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D5420663
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ifxbjWiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D5420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934DB89CE1;
	Tue,  2 Jun 2020 12:53:15 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDC089CE1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 12:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ootn/RufYg/03mNnxwQoPu10ht0eTdxHe0w97nvkdHPCnfvwO9NMML8rgVDe0FcW9zU1AM58Hn7Cc3bbLlN4W2F+NykWbp3PmZeJzPjYRcc+cGYEqRUzZX8wYJ55EzCWen/eUImc9Ed811B7hOxg00u8DrYmDWzVDWTR9ubaVX/2NnLzvoBOelF+NHhmnDJ7dnWEFuZ/99GGyNoIeVMM0219J8kA3ksBS1SvrnG2xMxg9jwrF3gzi7tB/ZMUdNeDzRIU0wNg7QyRU/5RvEmqhJM7MCyRrIi1B828yLt+pLLNOmAZ4gY5R5aBm5h6IgfcGhOzSVtR1IF5XhDn8kv8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=R8VLTsOY77j+NKZC50ffIwnTp03LUReOHGX8FWdciebHc2ZDFFUBItK63dGuuLgjttI9GXstQhRQe9mR0KUWMBhjkWfkXg7vAuGKngTqSs0bzLAC3OpiUaQd7IcEU31mLkxpeWo9Zbvs8mwB8L9+4agkIGxP9s8Y3YLOeb3rm3JCtDCRTJI3qCvgjyWcFJckW2daz+GlQnTp4O8HWA2zgF8Gy5Hv7JQvFDRyeaoP6/3tFcGYU3wlMZ1gzTvQ0E+5LIxpE+JL6EeyXe+7f4yjinhLx7/VLQOAeWTd/Qafz98W3j+vb0+AbNer/deyCVoZ9+NeJMfsPr6CmvCfH3pjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mKZ/hrD/Vow6aOSOzkSlI3zBNXi24WpVkZ2OcaItA=;
 b=ifxbjWivYQoSSX6zIsAhKQzVVknDW6526G5/0FPmPCWhhPJFeT3fH2pIKR9nmyc8Yqx0a2HE7pATMO1hJ5vxXktkVQpZdKTU8LF3TYl06xKHBfaFrM/ZS234cOR7u1YseK4daKLF+0BOpL1nFXaazN9u62QJA3kV3slImwluQ/Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 12:53:12 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 12:53:12 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Date: Tue,  2 Jun 2020 08:53:01 -0400
Message-Id: <20200602125302.1839-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 12:53:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78d0a22e-f96c-4065-1e87-08d806f3e899
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2828AC1AA5D1631A6172244F858B0@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eX6oPgXf9dpc4Vgop086ShN2ZlOnlMApJV5sNcShmRtd0xv9Zx5Kts9fE/AHVFnxEOpVZQsuYBwNB5/5IaoXrsbslweQhM5bKA0Qe7QPEzua0NULxvMYgm6iN/qd1elNlhZD23yDc5RTmAwI6e2dg7NGlzi3D6knT9Z2iGO82KIienA9zdsrKv2ttp9Uo0QWAmXM/y5AAAeYEjRE+OM5XCJEpXP8GsL9EZNHqBZR+FW8urk+KCsVbdxb6GeBIjoiep0rfjOHYIIJdoP83yB90NZrXP2jqmd9Qluz1CZP/ULZKJttIOISttG++AUYpF18/l6sh/B5O3K39mPCXxDqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(86362001)(16526019)(186003)(6486002)(6916009)(26005)(5660300002)(66556008)(66476007)(6666004)(8936002)(8676002)(36756003)(19627235002)(2906002)(1076003)(52116002)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WEDWQEHQ7+5sBxMwdX50KZIRQxz8L/YLsfsgT7hxVwKNEM8z2mx0il6v74764NR50H13i4g51frWOfxb/MOcu/w1r3Q2z7ctWoVxFvyPkurXpr0Iipi7AbVntg2mAF2cXyPp29jhUfIEnYPr0IgorAfuDn1cX+jPpv0ObMcY0GPCkyEEcGqWiVoZUvASAWNcX3bqDHL+jnhoUjV27Frio+MLQO6TCMMm2pqBrjxzrTsDOV1fiPu0dDeCGLZiFBCCheYL5UZPHz/9hV56Ya9rChjyJweWevQNXJberVX1Y4UyMFkxcuh5UjpA67EG+E4EoatBjZZ1+5xjbG429bp/7F2gWDtV6EUhDQY/10gBaxPVd7M8hJr+J9SaDSmQMu80+GhImawPgUkdANexW3m39CoCeGV5wRB9T/8HBLNFg4D4nLxB+y1LgwPQnyrsivSJFo/Wb/3RIiHAxmYYqbAuAzJInYL03BU1/RZ85GCWHvcbwoDv0ucLf5ZudvLc680c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d0a22e-f96c-4065-1e87-08d806f3e899
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 12:53:12.5461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXk2cfbVMOy7WLT91KhXruP+IWbDKs+jykSXxvLalpJQ5I7vKSFiH6wW5XhoS190ehmrHitFyJgN5Uqlx9Z68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
