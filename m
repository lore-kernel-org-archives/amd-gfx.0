Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061ECC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DB910E711;
	Mon, 27 Mar 2023 19:30:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D8210E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSfiVpiEcb1XkdZLE6GW3yRdWFkyCSTiC+AnM7AsdOjT252tr2gHsljHhnQO7bccNIGzLzf7ClqgF3o+BtBaUZZF4+leEEMkJDGOVo0AV4DIHJt0jXS8TQdUoVEE1TsCEbbLkAveqHiSZp56qwSk2+qfiByaVhSgAf8tVM7s3lPOd1xoDTnGVVSEefq3l3earSkhmOLIgTe/8ab6fEOK+OjIYnIU33M52GY5YJIIabu1NJfGgwo9kALeNUkF5g5CYH2UHCM7vjg8Spdh6pEN6tHnbGmkK7w7yCtlvEwhuZeVnYklReOolD40WKKrhjanDe4U5h21MHpwcnfMo7bX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R91vYy18/3CwapYxb9LRn+HIidJ8fr8T4VV6/FcPyM=;
 b=SnmtcPBbW2+pRMjVODrL4KfGAFf7syA4jfvtWQYbXajMXEonnfPVHrgZFdto8A53hs0MoXdKnFbK3svVcmjO4+wEnF1qOBTIXCKfGt680DQsnoA75GwPNwvGBBlWkIzEVAWiLH8lfC5OLoWX+maW8sP7Km4WYlsFwr0EL1jBUPmhkTJEYm2F8vfZTRPvXwJzHTtvVRztGxWv5HrS+roQbeTc9NxsTjKDc2+nbCcTh9Wr4uzg9oZLXXxeu7kZOorpHjNg8XZU6/I3B6hYjWbF9/ubOfyzeT83gVs4ufSXWPr8lVpkCsj8zM6bW5970pEd44UcLfBWP6FTwNxQa7+AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R91vYy18/3CwapYxb9LRn+HIidJ8fr8T4VV6/FcPyM=;
 b=JdNxf1T39XPzIfn7dGT09R/61Zz6tYBbhc9Vfnl+Pt0qvM5cFBlXfade/+5UzTc0VNKLmztEEq4kF2zzJ7XtIsXCyfkfiPhO7sKBi52r0HGLnG0HWwxNAFtZI2m6n8H0Rxk30SSacK/ojXmnVBu4Oxn9uzvbZptGtw2nKVcw6jM=
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Mon, 27 Mar
 2023 19:30:16 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9::4) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amdkfd: Trap handler changes for GC 9.4.3 v2
Date: Mon, 27 Mar 2023 15:29:46 -0400
Message-ID: <20230327192953.7756-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 89358571-28bf-4f35-a513-08db2ef9b18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdPSOB1BKFHUCreAQ+eoOFdcMuwjt3/sLTIy/zrQwgVXGiNoqeX7e3n9m3Tp9W8jJ+EhzKMXh66yy7hsY3Y/U3ul/ieSbcCYc5E6R2uaEX7jmrK+up7fmXTqdbU3upepqFd8YGgbBTCi2uV9GBboDKgr1yEOz4ocICViI5wfL1Qcq4tMFGL3hInD68SNwJrNNgqQHfE1tic9WbYYGFZSh2J6drQpGTYCa6/pVf+y6V4kjU55appt8H5lRvzYKd+ArL/0KuRvFOt+2wqz4FrrdtDwX5v+BxqRF8hy0HxHjhOqPnBrpUGx+l/ITn/jLGNVdSiMi4sSY7m1G0K4jw7GslxyTUgsJYqBgEbR1m47q/4/O95BGnE/S2E2tCsNzk/uS4JaaIccauF7YtCzTzFJwkcHNZr6kQlLOTQEzVFmQByF7o3KA/2lt4IRehwX2mTiDvjxMqE5z+VFGmTKx9NEBsWT6JZ3eQhNIfenotSGmR+GPBllJRaIsZrPCfy1euOWGAL2fLcNdeNc2otOxexM9AjsQR6SFU5U6tzETdKwul97f+HSp+/bq6n29ryieNzUj8FEyV4TyKhm5trBI0Gc78Bu9kvRjCei/5LMaL1+ihp8+2Vwb62vAsCniiaP+0fBK7QvH1qlZZ0gin1vUA7+BP0OXOVRWV2fQirSPHNd+teHlpuI5pU/ieGUvy5Hj/NY2fTdmDgLMPUAVG/Pu3MT+RMz8ImeJeea0LvHKcUZYas=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(81166007)(30864003)(356005)(426003)(82310400005)(8936002)(5660300002)(36756003)(186003)(1076003)(26005)(40480700001)(16526019)(2906002)(6666004)(47076005)(86362001)(2616005)(36860700001)(336012)(83380400001)(40460700003)(82740400003)(41300700001)(70206006)(70586007)(478600001)(6916009)(4326008)(54906003)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:16.2835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89358571-28bf-4f35-a513-08db2ef9b18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jay Cornwall <jay.cornwall@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

v1:
Check new exception bits in TRAPSTS register
Remove single step exception workaround, now part of
exception bits

v2:
GC 9.4.3 uses ttmp11 to store {1’b0, dispatch index [24:0],
wave_id_in_workgroup[5:0]}, so use ttmp13 instead of ttmp11 to
preserve ib_sts. (Laurent)

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Laurent Morichetti <Laurent.Morichetti@amd.com>
Reviewed-by: Laurent Morichetti <laurent.morichetti@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 487 ++++++++++++++++++
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |  52 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   6 +-
 3 files changed, 526 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 0c4c5499bb5c..73ca9aebf086 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -2936,3 +2936,490 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
 };
+
+static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
+	0xbf820001, 0xbf8202d6,
+	0xb8f8f802, 0x89788678,
+	0xb8fbf803, 0x866eff78,
+	0x00002000, 0xbf840009,
+	0x866eff6d, 0x00ff0000,
+	0xbf85001a, 0x866eff7b,
+	0x00000400, 0xbf85004d,
+	0xbf8e0010, 0xb8fbf803,
+	0xbf82fffa, 0x866eff7b,
+	0x03c00900, 0xbf850011,
+	0x866eff7b, 0x000071ff,
+	0xbf840008, 0x866fff7b,
+	0x00007080, 0xbf840001,
+	0xbeee1a87, 0xb8eff801,
+	0x8e6e8c6e, 0x866e6f6e,
+	0xbf850006, 0x866eff6d,
+	0x00ff0000, 0xbf850003,
+	0x866eff7b, 0x00000400,
+	0xbf850036, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8979ff79,
+	0xfc000000, 0x87797a79,
+	0xba7ff807, 0x00000000,
+	0xb8faf812, 0xb8fbf813,
+	0x8efa887a, 0xc0031bbd,
+	0x00000010, 0xbf8cc07f,
+	0x8e6e976e, 0x8979ff79,
+	0x00800000, 0x87796e79,
+	0xc0071bbd, 0x00000000,
+	0xbf8cc07f, 0xc0071ebd,
+	0x00000008, 0xbf8cc07f,
+	0x86ee6e6e, 0xbf840001,
+	0xbe801d6e, 0x866eff6d,
+	0x01ff0000, 0xbf850005,
+	0x8778ff78, 0x00002000,
+	0x80ec886c, 0x82ed806d,
+	0xbf820005, 0x866eff6d,
+	0x01000000, 0xbf850002,
+	0x806c846c, 0x826d806d,
+	0x866dff6d, 0x0000ffff,
+	0x8f7a8b79, 0x867aff7a,
+	0x001f8000, 0xb97af807,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e8378, 0xb96ee0c2,
+	0xbf800002, 0xb9780002,
+	0xbe801f6c, 0x866dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8979ff79,
+	0xfc000000, 0x87797a79,
+	0xba7ff807, 0x00000000,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbf900004,
+	0x877a8478, 0xb97af802,
+	0xbf8e0002, 0xbf88fffe,
+	0xb8fa2985, 0x807a817a,
+	0x8e7a8a7a, 0x8e7a817a,
+	0xb8fb1605, 0x807b817b,
+	0x8e7b867b, 0x807a7b7a,
+	0x807a7e7a, 0x827b807f,
+	0x867bff7b, 0x0000ffff,
+	0xc04b1c3d, 0x00000050,
+	0xbf8cc07f, 0xc04b1d3d,
+	0x00000060, 0xbf8cc07f,
+	0xc0431e7d, 0x00000074,
+	0xbf8cc07f, 0xbef4007e,
+	0x8675ff7f, 0x0000ffff,
+	0x8775ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x00807fac, 0xbef1007c,
+	0xbef00080, 0xb8f02985,
+	0x80708170, 0x8e708a70,
+	0x8e708170, 0xb8fa1605,
+	0x807a817a, 0x8e7a867a,
+	0x80707a70, 0xbef60084,
+	0xbef600ff, 0x01000000,
+	0xbefe007c, 0xbefc0070,
+	0xc0611c7a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611b3a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611b7a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611bba,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611bfa, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611e3a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xb8fbf803, 0xbefe007c,
+	0xbefc0070, 0xc0611efa,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xbefe007c, 0xbefc0070,
+	0xc0611a3a, 0x0000007c,
+	0xbf8cc07f, 0x80708470,
+	0xbefc007e, 0xbefe007c,
+	0xbefc0070, 0xc0611a7a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0xb8f1f801, 0xbefe007c,
+	0xbefc0070, 0xc0611c7a,
+	0x0000007c, 0xbf8cc07f,
+	0x80708470, 0xbefc007e,
+	0x867aff7f, 0x04000000,
+	0xbeef0080, 0x876f6f7a,
+	0xb8f02985, 0x80708170,
+	0x8e708a70, 0x8e708170,
+	0xb8fb1605, 0x807b817b,
+	0x8e7b847b, 0x8e76827b,
+	0xbef600ff, 0x01000000,
+	0xbef20174, 0x80747074,
+	0x82758075, 0xbefc0080,
+	0xbf800000, 0xbe802b00,
+	0xbe822b02, 0xbe842b04,
+	0xbe862b06, 0xbe882b08,
+	0xbe8a2b0a, 0xbe8c2b0c,
+	0xbe8e2b0e, 0xc06b003a,
+	0x00000000, 0xbf8cc07f,
+	0xc06b013a, 0x00000010,
+	0xbf8cc07f, 0xc06b023a,
+	0x00000020, 0xbf8cc07f,
+	0xc06b033a, 0x00000030,
+	0xbf8cc07f, 0x8074c074,
+	0x82758075, 0x807c907c,
+	0xbf0a7b7c, 0xbf85ffe7,
+	0xbef40172, 0xbef00080,
+	0xbefe00c1, 0xbeff00c1,
+	0xbee80080, 0xbee90080,
+	0xbef600ff, 0x01000000,
+	0x867aff78, 0x00400000,
+	0xbf850003, 0xb8faf803,
+	0x897a7aff, 0x10000000,
+	0xbf85004d, 0xbe840080,
+	0xd2890000, 0x00000900,
+	0x80048104, 0xd2890001,
+	0x00000900, 0x80048104,
+	0xd2890002, 0x00000900,
+	0x80048104, 0xd2890003,
+	0x00000900, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000901, 0x80048104,
+	0xd2890001, 0x00000901,
+	0x80048104, 0xd2890002,
+	0x00000901, 0x80048104,
+	0xd2890003, 0x00000901,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000902,
+	0x80048104, 0xd2890001,
+	0x00000902, 0x80048104,
+	0xd2890002, 0x00000902,
+	0x80048104, 0xd2890003,
+	0x00000902, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000903, 0x80048104,
+	0xd2890001, 0x00000903,
+	0x80048104, 0xd2890002,
+	0x00000903, 0x80048104,
+	0xd2890003, 0x00000903,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbf820008,
+	0xe0724000, 0x701d0000,
+	0xe0724100, 0x701d0100,
+	0xe0724200, 0x701d0200,
+	0xe0724300, 0x701d0300,
+	0xbefe00c1, 0xbeff00c1,
+	0xb8fb4306, 0x867bc17b,
+	0xbf840064, 0xbf8a0000,
+	0x867aff6f, 0x04000000,
+	0xbf840060, 0x8e7b867b,
+	0x8e7b827b, 0xbef6007b,
+	0xb8f02985, 0x80708170,
+	0x8e708a70, 0x8e708170,
+	0xb8fa1605, 0x807a817a,
+	0x8e7a867a, 0x80707a70,
+	0x8070ff70, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0xbefc0080, 0xd28c0002,
+	0x000100c1, 0xd28d0003,
+	0x000204c1, 0x867aff78,
+	0x00400000, 0xbf850003,
+	0xb8faf803, 0x897a7aff,
+	0x10000000, 0xbf850030,
+	0x24040682, 0xd86e4000,
+	0x00000002, 0xbf8cc07f,
+	0xbe840080, 0xd2890000,
+	0x00000900, 0x80048104,
+	0xd2890001, 0x00000900,
+	0x80048104, 0xd2890002,
+	0x00000900, 0x80048104,
+	0xd2890003, 0x00000900,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000901,
+	0x80048104, 0xd2890001,
+	0x00000901, 0x80048104,
+	0xd2890002, 0x00000901,
+	0x80048104, 0xd2890003,
+	0x00000901, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0x680404ff, 0x00000200,
+	0xd0c9006a, 0x0000f702,
+	0xbf87ffd2, 0xbf820015,
+	0xd1060002, 0x00011103,
+	0x7e0602ff, 0x00000200,
+	0xbefc00ff, 0x00010000,
+	0xbe800077, 0x8677ff77,
+	0xff7fffff, 0x8777ff77,
+	0x00058000, 0xd8ec0000,
+	0x00000002, 0xbf8cc07f,
+	0xe0765000, 0x701d0002,
+	0x68040702, 0xd0c9006a,
+	0x0000f702, 0xbf87fff7,
+	0xbef70000, 0xbef000ff,
+	0x00000400, 0xbefe00c1,
+	0xbeff00c1, 0xb8fb2b05,
+	0x807b817b, 0x8e7b827b,
+	0xbef600ff, 0x01000000,
+	0xbefc0084, 0xbf0a7b7c,
+	0xbf84006d, 0xbf11017c,
+	0x807bff7b, 0x00001000,
+	0x867aff78, 0x00400000,
+	0xbf850003, 0xb8faf803,
+	0x897a7aff, 0x10000000,
+	0xbf850051, 0xbe840080,
+	0xd2890000, 0x00000900,
+	0x80048104, 0xd2890001,
+	0x00000900, 0x80048104,
+	0xd2890002, 0x00000900,
+	0x80048104, 0xd2890003,
+	0x00000900, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000901, 0x80048104,
+	0xd2890001, 0x00000901,
+	0x80048104, 0xd2890002,
+	0x00000901, 0x80048104,
+	0xd2890003, 0x00000901,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000902,
+	0x80048104, 0xd2890001,
+	0x00000902, 0x80048104,
+	0xd2890002, 0x00000902,
+	0x80048104, 0xd2890003,
+	0x00000902, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000903, 0x80048104,
+	0xd2890001, 0x00000903,
+	0x80048104, 0xd2890002,
+	0x00000903, 0x80048104,
+	0xd2890003, 0x00000903,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0x807c847c,
+	0xbf0a7b7c, 0xbf85ffb1,
+	0xbf9c0000, 0xbf820012,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0xe0724000, 0x701d0000,
+	0xe0724100, 0x701d0100,
+	0xe0724200, 0x701d0200,
+	0xe0724300, 0x701d0300,
+	0x807c847c, 0x8070ff70,
+	0x00000400, 0xbf0a7b7c,
+	0xbf85ffef, 0xbf9c0000,
+	0xb8fb2985, 0x807b817b,
+	0x8e7b837b, 0xb8fa2b05,
+	0x807a817a, 0x8e7a827a,
+	0x80fb7a7b, 0x867b7b7b,
+	0xbf84007a, 0x807bff7b,
+	0x00001000, 0xbefc0080,
+	0xbf11017c, 0x867aff78,
+	0x00400000, 0xbf850003,
+	0xb8faf803, 0x897a7aff,
+	0x10000000, 0xbf850059,
+	0xd3d84000, 0x18000100,
+	0xd3d84001, 0x18000101,
+	0xd3d84002, 0x18000102,
+	0xd3d84003, 0x18000103,
+	0xbe840080, 0xd2890000,
+	0x00000900, 0x80048104,
+	0xd2890001, 0x00000900,
+	0x80048104, 0xd2890002,
+	0x00000900, 0x80048104,
+	0xd2890003, 0x00000900,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000901,
+	0x80048104, 0xd2890001,
+	0x00000901, 0x80048104,
+	0xd2890002, 0x00000901,
+	0x80048104, 0xd2890003,
+	0x00000901, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0xbe840080, 0xd2890000,
+	0x00000902, 0x80048104,
+	0xd2890001, 0x00000902,
+	0x80048104, 0xd2890002,
+	0x00000902, 0x80048104,
+	0xd2890003, 0x00000902,
+	0x80048104, 0xc069003a,
+	0x00000070, 0xbf8cc07f,
+	0x80709070, 0xbf06c004,
+	0xbf84ffee, 0xbe840080,
+	0xd2890000, 0x00000903,
+	0x80048104, 0xd2890001,
+	0x00000903, 0x80048104,
+	0xd2890002, 0x00000903,
+	0x80048104, 0xd2890003,
+	0x00000903, 0x80048104,
+	0xc069003a, 0x00000070,
+	0xbf8cc07f, 0x80709070,
+	0xbf06c004, 0xbf84ffee,
+	0x807c847c, 0xbf0a7b7c,
+	0xbf85ffa9, 0xbf9c0000,
+	0xbf820016, 0xd3d84000,
+	0x18000100, 0xd3d84001,
+	0x18000101, 0xd3d84002,
+	0x18000102, 0xd3d84003,
+	0x18000103, 0xe0724000,
+	0x701d0000, 0xe0724100,
+	0x701d0100, 0xe0724200,
+	0x701d0200, 0xe0724300,
+	0x701d0300, 0x807c847c,
+	0x8070ff70, 0x00000400,
+	0xbf0a7b7c, 0xbf85ffeb,
+	0xbf9c0000, 0xbf8200ee,
+	0xbef4007e, 0x8675ff7f,
+	0x0000ffff, 0x8775ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x00807fac,
+	0x866eff7f, 0x04000000,
+	0xbf84001f, 0xbefe00c1,
+	0xbeff00c1, 0xb8ef4306,
+	0x866fc16f, 0xbf84001a,
+	0x8e6f866f, 0x8e6f826f,
+	0xbef6006f, 0xb8f82985,
+	0x80788178, 0x8e788a78,
+	0x8e788178, 0xb8ee1605,
+	0x806e816e, 0x8e6e866e,
+	0x80786e78, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xbefc0080,
+	0xe0510000, 0x781d0000,
+	0xe0510100, 0x781d0000,
+	0x807cff7c, 0x00000200,
+	0x8078ff78, 0x00000200,
+	0xbf0a6f7c, 0xbf85fff6,
+	0xbefe00c1, 0xbeff00c1,
+	0xbef600ff, 0x01000000,
+	0xb8ef2b05, 0x806f816f,
+	0x8e6f826f, 0x806fff6f,
+	0x00008000, 0xbef80080,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefc0084,
+	0xbf11087c, 0xe0524000,
+	0x781d0000, 0xe0524100,
+	0x781d0100, 0xe0524200,
+	0x781d0200, 0xe0524300,
+	0x781d0300, 0xbf8c0f70,
+	0x7e000300, 0x7e020301,
+	0x7e040302, 0x7e060303,
+	0x807c847c, 0x8078ff78,
+	0x00000400, 0xbf0a6f7c,
+	0xbf85ffee, 0xb8ef2985,
+	0x806f816f, 0x8e6f836f,
+	0xb8f92b05, 0x80798179,
+	0x8e798279, 0x80ef796f,
+	0x866f6f6f, 0xbf84001a,
+	0x806fff6f, 0x00008000,
+	0xbefc0080, 0xbf11087c,
+	0xe0524000, 0x781d0000,
+	0xe0524100, 0x781d0100,
+	0xe0524200, 0x781d0200,
+	0xe0524300, 0x781d0300,
+	0xbf8c0f70, 0xd3d94000,
+	0x18000100, 0xd3d94001,
+	0x18000101, 0xd3d94002,
+	0x18000102, 0xd3d94003,
+	0x18000103, 0x807c847c,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7c, 0xbf85ffea,
+	0xbf9c0000, 0xe0524000,
+	0x6e1d0000, 0xe0524100,
+	0x6e1d0100, 0xe0524200,
+	0x6e1d0200, 0xe0524300,
+	0x6e1d0300, 0xbf8c0f70,
+	0xb8f82985, 0x80788178,
+	0x8e788a78, 0x8e788178,
+	0xb8ee1605, 0x806e816e,
+	0x8e6e866e, 0x80786e78,
+	0x80f8c078, 0xb8ef1605,
+	0x806f816f, 0x8e6f846f,
+	0x8e76826f, 0xbef600ff,
+	0x01000000, 0xbefc006f,
+	0xc031003a, 0x00000078,
+	0x80f8c078, 0xbf8cc07f,
+	0x80fc907c, 0xbf800000,
+	0xbe802d00, 0xbe822d02,
+	0xbe842d04, 0xbe862d06,
+	0xbe882d08, 0xbe8a2d0a,
+	0xbe8c2d0c, 0xbe8e2d0e,
+	0xbf06807c, 0xbf84fff0,
+	0xb8f82985, 0x80788178,
+	0x8e788a78, 0x8e788178,
+	0xb8ee1605, 0x806e816e,
+	0x8e6e866e, 0x80786e78,
+	0xbef60084, 0xbef600ff,
+	0x01000000, 0xc0211bfa,
+	0x00000078, 0x80788478,
+	0xc0211b3a, 0x00000078,
+	0x80788478, 0xc0211b7a,
+	0x00000078, 0x80788478,
+	0xc0211c3a, 0x00000078,
+	0x80788478, 0xc0211c7a,
+	0x00000078, 0x80788478,
+	0xc0211eba, 0x00000078,
+	0x80788478, 0xc0211efa,
+	0x00000078, 0x80788478,
+	0xc0211a3a, 0x00000078,
+	0x80788478, 0xc0211a7a,
+	0x00000078, 0x80788478,
+	0xc0211cfa, 0x00000078,
+	0x80788478, 0xbf8cc07f,
+	0xbefc006f, 0xbefe0070,
+	0xbeff0071, 0x866f7bff,
+	0x000003ff, 0xb96f4803,
+	0x866f7bff, 0xfffff800,
+	0x8f6f8b6f, 0xb96fa2c3,
+	0xb973f801, 0xb8ee2985,
+	0x806e816e, 0x8e6e8a6e,
+	0x8e6e816e, 0xb8ef1605,
+	0x806f816f, 0x8e6f866f,
+	0x806e6f6e, 0x806e746e,
+	0x826f8075, 0x866fff6f,
+	0x0000ffff, 0xc00b1c37,
+	0x00000050, 0xc00b1d37,
+	0x00000060, 0xc0031e77,
+	0x00000074, 0xbf8cc07f,
+	0x8f6e8b79, 0x866eff6e,
+	0x001f8000, 0xb96ef807,
+	0x866dff6d, 0x0000ffff,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e837a, 0xb96ee0c2,
+	0xbf800002, 0xb97a0002,
+	0xbf8a0000, 0xbe801f6c,
+	0xbf810000, 0x00000000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index 6770cbe3250a..f2087cc2e89d 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -33,15 +33,20 @@
  * aldebaran:
  *   cpp -DASIC_FAMILY=CHIP_ALDEBARAN cwsr_trap_handler_gfx9.asm -P -o aldebaran.sp3
  *   sp3 aldebaran.sp3 -hex aldebaran.hex
+ *
+ * gc_9_4_3:
+ *   cpp -DASIC_FAMILY=GC_9_4_3 cwsr_trap_handler_gfx9.asm -P -o gc_9_4_3.sp3
+ *   sp3 gc_9_4_3.sp3 -hex gc_9_4_3.hex
  */
 
 #define CHIP_VEGAM 18
 #define CHIP_ARCTURUS 23
 #define CHIP_ALDEBARAN 25
+#define CHIP_GC_9_4_3 26
 
 var ACK_SQC_STORE		    =	1		    //workaround for suspected SQC store bug causing incorrect stores under concurrency
 var SAVE_AFTER_XNACK_ERROR	    =	1		    //workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
-var SINGLE_STEP_MISSED_WORKAROUND   =	1		    //workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
+var SINGLE_STEP_MISSED_WORKAROUND   =	(ASIC_FAMILY <= CHIP_ALDEBARAN)	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
 /**************************************************************************/
 /*			variables					  */
@@ -77,6 +82,10 @@ var SQ_WAVE_TRAPSTS_ADDR_WATCH_MASK =	0x80
 var SQ_WAVE_TRAPSTS_ADDR_WATCH_SHIFT =	7
 var SQ_WAVE_TRAPSTS_MEM_VIOL_MASK   =	0x100
 var SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT  =	8
+var SQ_WAVE_TRAPSTS_HOST_TRAP_MASK  =	0x400000
+var SQ_WAVE_TRAPSTS_WAVE_BEGIN_MASK =	0x800000
+var SQ_WAVE_TRAPSTS_WAVE_END_MASK   =	0x1000000
+var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK =  0x2000000
 var SQ_WAVE_TRAPSTS_PRE_SAVECTX_MASK	=   0x3FF
 var SQ_WAVE_TRAPSTS_PRE_SAVECTX_SHIFT	=   0x0
 var SQ_WAVE_TRAPSTS_PRE_SAVECTX_SIZE	=   10
@@ -95,10 +104,10 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x1F8000
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK		=   0x800
 
-var TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT	=   26			// bits [31:26] unused by SPI debug data
-var TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK	=   0xFC000000
-var TTMP11_DEBUG_TRAP_ENABLED_SHIFT	=   23
-var TTMP11_DEBUG_TRAP_ENABLED_MASK	=   0x800000
+var TTMP_SAVE_RCNT_FIRST_REPLAY_SHIFT	=   26			// bits [31:26] unused by SPI debug data
+var TTMP_SAVE_RCNT_FIRST_REPLAY_MASK	=   0xFC000000
+var TTMP_DEBUG_TRAP_ENABLED_SHIFT	=   23
+var TTMP_DEBUG_TRAP_ENABLED_MASK	=   0x800000
 
 /*	Save	    */
 var S_SAVE_BUF_RSRC_WORD1_STRIDE	=   0x00040000		//stride is 4 bytes
@@ -129,6 +138,11 @@ var s_save_alloc_size	    =	s_save_trapsts		//conflict
 var s_save_m0		    =	ttmp5
 var s_save_ttmps_lo	    =	s_save_tmp		//no conflict
 var s_save_ttmps_hi	    =	s_save_trapsts		//no conflict
+#if ASIC_FAMILY >= CHIP_GC_9_4_3
+var s_save_ib_sts       =	ttmp13
+#else
+var s_save_ib_sts       =	ttmp11
+#endif
 
 /*	Restore	    */
 var S_RESTORE_BUF_RSRC_WORD1_STRIDE	    =	S_SAVE_BUF_RSRC_WORD1_STRIDE
@@ -215,9 +229,15 @@ L_NOT_HALTED:
     // Any concurrent SAVECTX will be handled upon re-entry once halted.
 
     // Check non-maskable exceptions. memory_violation, illegal_instruction
-    // and xnack_error exceptions always cause the wave to enter the trap
-    // handler.
-    s_and_b32       ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+    // and debugger (host trap, wave start/end, trap after instruction)
+    // exceptions always cause the wave to enter the trap handler.
+    s_and_b32       ttmp2, s_save_trapsts,      \
+        SQ_WAVE_TRAPSTS_MEM_VIOL_MASK         | \
+        SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK     | \
+        SQ_WAVE_TRAPSTS_HOST_TRAP_MASK        | \
+        SQ_WAVE_TRAPSTS_WAVE_BEGIN_MASK       | \
+        SQ_WAVE_TRAPSTS_WAVE_END_MASK         | \
+        SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK
     s_cbranch_scc1  L_FETCH_2ND_TRAP
 
     // Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.
@@ -265,9 +285,9 @@ L_FETCH_2ND_TRAP:
 
     s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 glc:1 // debug trap enabled flag
     s_waitcnt       lgkmcnt(0)
-    s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
-    s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
-    s_or_b32        ttmp11, ttmp11, ttmp2
+    s_lshl_b32      ttmp2, ttmp2, TTMP_DEBUG_TRAP_ENABLED_SHIFT
+    s_andn2_b32     s_save_ib_sts, s_save_ib_sts, TTMP_DEBUG_TRAP_ENABLED_MASK
+    s_or_b32        s_save_ib_sts, s_save_ib_sts, ttmp2
 
     s_load_dwordx2  [ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 glc:1 // second-level TBA
     s_waitcnt       lgkmcnt(0)
@@ -1058,17 +1078,17 @@ function set_status_without_spi_prio(status, tmp)
 end
 
 function save_and_clear_ib_sts(tmp)
-    // Save IB_STS.FIRST_REPLAY[15] and IB_STS.RCNT[20:16] into unused space ttmp11[31:26].
+    // Save IB_STS.FIRST_REPLAY[15] and IB_STS.RCNT[20:16] into unused space s_save_ib_sts[31:26].
     s_getreg_b32    tmp, hwreg(HW_REG_IB_STS)
     s_and_b32       tmp, tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-    s_lshl_b32      tmp, tmp, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
-    s_andn2_b32     ttmp11, ttmp11, TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK
-    s_or_b32        ttmp11, ttmp11, tmp
+    s_lshl_b32      tmp, tmp, (TTMP_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+    s_andn2_b32     s_save_ib_sts, s_save_ib_sts, TTMP_SAVE_RCNT_FIRST_REPLAY_MASK
+    s_or_b32        s_save_ib_sts, s_save_ib_sts, tmp
     s_setreg_imm32_b32 hwreg(HW_REG_IB_STS), 0x0
 end
 
 function restore_ib_sts(tmp)
-    s_lshr_b32      tmp, ttmp11, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+    s_lshr_b32      tmp, s_save_ib_sts, (TTMP_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
     s_and_b32       tmp, tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
     s_setreg_b32    hwreg(HW_REG_IB_STS), tmp
 end
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4100db469d57..0bf8d75950f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -452,9 +452,9 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
 		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
-			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
-			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
-- 
2.39.2

