Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D3606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F/7TkUX9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B843E10E4A2;
	Thu, 22 Oct 2026 20:49:43 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2732F10E4A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 20:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe7bP/L742dZkJfubqsRgiwzjhpGHF5glPsrHk2AJ+KlbJMzyTv/MsACjkZw8bnm0gQpt66Jo4ElgWtcBy9+PQVUoMxzegE60CYyGMkrCoZ3DoRLTdJUQm2kOznPowQsb/9NXhGl6SV1A2MZOq0H835mMCVBm7N/SC1SO6jruisSJpZDHP6UrIzY+eGpCW1etVboafa4NoIs/AyLuVo1QfNhmkYLcTEvPJOZW39+/VVtZIx9+1K6CnUoSGMGZGWUkKDTWxQiVNl1B9cotHL0x7A0awcVGQhocn+VUr803Gxo/tJwHu60yGBYxW6eoDtIXVyu8Aay1sR8kcf/LBzxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvtXCOWkAcqu2/WCnUHuAWYw1tddlF/TzrUlRs6oIPo=;
 b=I511J7wok8b9Yeq8Wb3MDRenX91nnhFZC1aKg3hpqLqL0215r3pTpCpTBFcuonItoV96DwxrSPkclYkrnbQd44l8ch699VdT86ZGCKNgljZMMwDep9kPWYVP4KXarL9Rcg5ZVsD2GAug+Ld3dGfUKN3ykVU+6tZy8UASbDCGVZkpclTHY9QqycNayV1nOabf6O3baq+exnjcZG9LXGOzhiQvJG+JF3nDc0J9FkAZJ6F64fZDxtHOXhv26RkIbl7CdeL2S0V+bdQKS0WoEErvh5MuO3sldgRwfD0YPbv3F2bZ56R+NtCcKFVAFNXLOpyyMe/P86+yMRFzF3JhqMIxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvtXCOWkAcqu2/WCnUHuAWYw1tddlF/TzrUlRs6oIPo=;
 b=F/7TkUX9hiHWQ4EbFqXuVoJcBqADupcXQ+kM6awi6K7h6oj0nOxr/HW36a0NqZh+Zr3+mO0hdujrvZ9jxBE13kf9PBf0nR5Bkhgw0ySsG7dl6RGrl6QAXX+N39PXsAR5vA6YiQQxDnICfX3a/KuuF8OQV4sZkaP5ETOgBxm9IYg=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 20:49:26 +0000
Received: from CY5PEPF00000E7A.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::66) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 20:49:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E7A.mail.protection.outlook.com (10.167.247.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 20:49:25 +0000
Received: from epyc-7282-ubuntu-22.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 15:49:24 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Vladimir Indic <vladimir.indic@amd.com>
Subject: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
Date: Thu, 22 Oct 2026 16:48:58 -0400
Message-ID: <20261022204858.4143484-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7A:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: c270c61d-8af4-4323-4f1b-08df307df59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|261021123027099003|261022105027099003|56012099006|261022075727099003|261009223027099003|11063799006|10067099003|18002099003|3023799007|261021121427099003;
X-Microsoft-Antispam-Message-Info: 39zolGL61FQUCUkmmd8Srk9THHD3ox7MVFdY9PlqqWsoTgEM6esIS5NK69ARTSyXMDpsB43Fmo5tbVL16GJ6OMDkFUTX8dendcdHJis9sQXAivrJQCqO1ntyTP0R+g96GC5abrvjA95CrqakCnpJChvjINlTz9w0oTU2v6q2xz+N5qx3sS3X1vViTg5GGtL7NQy6OPhisVB81xdNFuYMlUjWp8u7W3w0rfa/X8pyGEFnWfeczbeCjREGqT0suuX3aPnXsHg4tqPAjpITAr447gge4lMx2UhvY80aq6So5tAz5uWFzYiclN9b9gNdEWQrCXrYVotlaJOXamCoFeh9NacvNMJlMuzL/sJiJhrFATZ98Ua0xRypqouEePabNrjzd7GciVk6NtQtPA/JS8sNG41r3f3JakjDA6R67eZz05Po6vI5x1lrg4EHEi4AXkEA62T+yK7BdnuzFuIv3Rs5obSWVaF3f4HWRlBTwvNARvSBSo4DDDLzOzCA+79X35IGfxCMuHh5G2o3sTFTETnoa2hyevosFxQHJ9oj0ktyAl5RAWJJe213/v25wKwEw2q4MDuufSyB9HY8Ud+taD4bIf1Lffq8AnwnuMCx5mfCwhpi+whzaKuHscIMuupfueaW9FAx+QUb0e/ggq8XptTYrdlHJ4N3a3QjykZT5iI/FxZv+29lX/2SSm4Tk9o/+FVqewPHnMpRE9hc+COlsZUnQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(261021123027099003)(261022105027099003)(56012099006)(261022075727099003)(261009223027099003)(11063799006)(10067099003)(18002099003)(3023799007)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YmzXE3YcL7wpKvziKQHE7X81zS9k9kMbpWbpt6hrJ+kT579x2PqAaZiQ+0O1+hCIYE7jfB0BOncQUYpZe3we1wingBnsno+4fmCn85rlbgaFzdeeqRQ+OfzOvALSaCTBnju3h/ua+7cSMc6bc88NdLqv0u7iyR8BHKnlLcrZMkvnjqO6aEfHLEOKrrQxF2YUHVuW+RHXIU1Z6t8YmIwHaizZgGka4vT2K89mQlbVWevvq4lpvJ4Q+oaxN8P2ShQwPixRIgO0foBG5B3w+/T/iCme1D9w3HqxbzfTPJoL9kmna5JPDUIJoS6gx8QAZ0I2s7/21Pes1h0g+uluEida8nqT6hN4l5HxHRV6pCU6yQIYPP6sHXSYM5LDN0EglYmFOq6XYjTTQjte0JhZXCW9dmy+xPO6FdNJOpl3djuNHWv6Nth9fiaMaHrL+XZHk08e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 20:49:25.8884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c270c61d-8af4-4323-4f1b-08df307df59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E7A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Split instruction fixup into two separate workarounds:
- Trap during VOP3PX: revision 0 only
- Trap during VALU/SET_VGPR_MSB: revision 0 and 1

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 695 +++++++++++++++++-
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  12 +-
 3 files changed, 729 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 5cf306de0d96..5d468460f532 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4600,7 +4600,7 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 	0xbf9b0000, 0x00000000,
 };
 
-static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
+static const uint32_t cwsr_trap_gfx12_1_0_rev_0_hex[] = {
 	0xbfa00001, 0xbfa003e2,
 	0xb0804009, 0xb8f8f804,
 	0xbefa007e, 0xbefe0081,
@@ -5301,3 +5301,696 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 };
+
+static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] = {
+	0xbfa00001, 0xbfa003d0,
+	0xb0804009, 0xb8f8f804,
+	0xbefa007e, 0xbefe0081,
+	0xbeee0080, 0xbeef00c1,
+	0xee17406e, 0x00040000,
+	0x00000000, 0xbefe007a,
+	0x9178ff78, 0x00008c00,
+	0xb8fbf811, 0xbf0c877b,
+	0xbfa20002, 0x916dff6d,
+	0xf0000000, 0xbf0d857b,
+	0xbfa10006, 0x917bff7b,
+	0x00000480, 0xb98001d1,
+	0x00000000, 0xb9800291,
+	0x00000000, 0x8b6eff78,
+	0x00004000, 0xbfa10008,
+	0x8b6eff7b, 0x00000480,
+	0xbfa20018, 0x8b6ea07b,
+	0xbfa200e1, 0xbf830010,
+	0xb8fbf811, 0xbfa0fffb,
+	0x8b6eff7b, 0x00000bd0,
+	0xbfa20010, 0xb8eef812,
+	0x8b6f8f7b, 0xbfa10002,
+	0x8c6eff6e, 0x00000080,
+	0xb8eff813, 0x8b6e6e6f,
+	0xbfa20008, 0x8b6eff6d,
+	0xf0000000, 0xbfa20005,
+	0x8b6fff6f, 0x00000200,
+	0xbfa20002, 0x8b6ea07b,
+	0xbfa200cb, 0x9177ff77,
+	0x007fc000, 0xb8fa04a1,
+	0x847a967a, 0x8c777a77,
+	0xb8fa0421, 0x847a957a,
+	0x8c777a77, 0xb8fa3021,
+	0x847a8e7a, 0x8c777a77,
+	0xb980f821, 0x00000000,
+	0xbeef007b, 0xbefa4d82,
+	0xbf8a0000, 0x84fa887a,
+	0xbf0d987b, 0xbfa10002,
+	0x8c7bff7b, 0xfe000000,
+	0xf4601bbd, 0xf8000010,
+	0xbf8a0000, 0x846e976e,
+	0x9177ff77, 0x03800000,
+	0x8c776e77, 0x8b6eff6f,
+	0x00000480, 0xbfa1000c,
+	0xbf0d8e78, 0xbfa20002,
+	0xbf0d9877, 0xbfa20002,
+	0xb98001d1, 0x00000000,
+	0xbf0d8e78, 0xbfa20002,
+	0xbf0d9977, 0xbfa20002,
+	0xb9800291, 0x00000000,
+	0xf4603bbd, 0xf8000000,
+	0xbf8a0000, 0xf4603ebd,
+	0xf8000008, 0xbf8a0000,
+	0x8bee6e6e, 0xbfa10001,
+	0xbe80486e, 0x8b6eff6d,
+	0xf0000000, 0xbfa20009,
+	0xb8eef811, 0x8b6eff6e,
+	0x00000080, 0xbfa20007,
+	0x8c78ff78, 0x00004000,
+	0x80ec886c, 0x82ed806d,
+	0xbfa00002, 0x806c846c,
+	0x826d806d, 0x8b6dff6d,
+	0x01ffffff, 0xb8fbf811,
+	0xbf0d847b, 0xbfa20078,
+	0xf4003eb6, 0xf8000000,
+	0xbfc70000, 0xf4003bb6,
+	0xf8000008, 0x8b76ff7a,
+	0x80000000, 0xbfa20027,
+	0x9376ff7a, 0x00060019,
+	0x81f9a376, 0xbf0b8179,
+	0xbfa20068, 0x81f9ac76,
+	0xbf0b8179, 0xbfa20062,
+	0x81f9b776, 0xbf0b8179,
+	0xbfa2005f, 0x8b76ff7a,
+	0x000001ff, 0xbf06ff76,
+	0x000000fe, 0xbfa2005d,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20057, 0xbf06ff76,
+	0x000000fa, 0xbfa20054,
+	0x81f9ff76, 0x000000e9,
+	0xbf0b8179, 0xbfa20050,
+	0x8b76ff7b, 0xffff0000,
+	0xbf06ff76, 0xbf860000,
+	0xbfa10051, 0x9376ff7b,
+	0x0002000e, 0x8b79ff7b,
+	0x00003f00, 0x85798679,
+	0x8c767976, 0xb9763b01,
+	0xbfa00049, 0x8b76ff7a,
+	0xfc000000, 0xbf06ff76,
+	0xd4000000, 0xbfa20013,
+	0xbf06ff76, 0xc8000000,
+	0xbfa20027, 0x8b76ff7a,
+	0xff000000, 0xbf06ff76,
+	0xcf000000, 0xbfa20039,
+	0x8b79ff7a, 0xffff0000,
+	0xbf06ff79, 0xcc350000,
+	0xbfa20037, 0xbf06ff79,
+	0xcc3a0000, 0xbfa20034,
+	0xbf06ff76, 0xcc000000,
+	0xbfa10031, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20029,
+	0xbf06ff76, 0x000000fa,
+	0xbfa20026, 0x81f6ff76,
+	0x000000e9, 0xbf0b8176,
+	0xbfa20022, 0x8b76ff7b,
+	0x0003fe00, 0xbf06ff76,
+	0x0001fe00, 0xbfa2001d,
+	0x8b76ff7b, 0x07fc0000,
+	0xbf06ff76, 0x03fc0000,
+	0xbfa20018, 0xbfa00014,
+	0x9376ff7a, 0x00040016,
+	0x81f68176, 0xbf0b8176,
+	0xbfa20012, 0x9376ff7a,
+	0x00050011, 0x81f68176,
+	0xbf0b8176, 0xbfa2000d,
+	0x8b76ff7a, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20008, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20003,
+	0xbfc70000, 0xbefb006e,
+	0xbfa0ffad, 0xbfc70000,
+	0xbefb006f, 0xbfa0ffaa,
+	0xbfc70000, 0x857a9677,
+	0xb97a04a1, 0x857a9577,
+	0xb97a0421, 0x857a8e77,
+	0xb97a3021, 0x8bfe7e7e,
+	0x8bea6a6a, 0x85788978,
+	0xb9783244, 0xbe804a6c,
+	0xb8faf802, 0xbf0d987a,
+	0xbfa10001, 0xbfb00000,
+	0x8b6dff6d, 0x01ffffff,
+	0xbefa0080, 0xb97a0151,
+	0x9177ff77, 0x007fc000,
+	0xb8fa04a1, 0x847a967a,
+	0x8c777a77, 0xb8fa0421,
+	0x847a957a, 0x8c777a77,
+	0xb8fa3021, 0x847a8e7a,
+	0x8c777a77, 0xb980f821,
+	0x00000000, 0xbf0d847b,
+	0xbfa20078, 0xf4003eb6,
+	0xf8000000, 0xbfc70000,
+	0xf4003bb6, 0xf8000008,
+	0x8b76ff7a, 0x80000000,
+	0xbfa20027, 0x9376ff7a,
+	0x00060019, 0x81f9a376,
+	0xbf0b8179, 0xbfa20068,
+	0x81f9ac76, 0xbf0b8179,
+	0xbfa20062, 0x81f9b776,
+	0xbf0b8179, 0xbfa2005f,
+	0x8b76ff7a, 0x000001ff,
+	0xbf06ff76, 0x000000fe,
+	0xbfa2005d, 0xbf06ff76,
+	0x000000ff, 0xbfa20057,
+	0xbf06ff76, 0x000000fa,
+	0xbfa20054, 0x81f9ff76,
+	0x000000e9, 0xbf0b8179,
+	0xbfa20050, 0x8b76ff7b,
+	0xffff0000, 0xbf06ff76,
+	0xbf860000, 0xbfa10051,
+	0x9376ff7b, 0x0002000e,
+	0x8b79ff7b, 0x00003f00,
+	0x85798679, 0x8c767976,
+	0xb9763b01, 0xbfa00049,
+	0x8b76ff7a, 0xfc000000,
+	0xbf06ff76, 0xd4000000,
+	0xbfa20013, 0xbf06ff76,
+	0xc8000000, 0xbfa20027,
+	0x8b76ff7a, 0xff000000,
+	0xbf06ff76, 0xcf000000,
+	0xbfa20039, 0x8b79ff7a,
+	0xffff0000, 0xbf06ff79,
+	0xcc350000, 0xbfa20037,
+	0xbf06ff79, 0xcc3a0000,
+	0xbfa20034, 0xbf06ff76,
+	0xcc000000, 0xbfa10031,
+	0x8b76ff7b, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20029, 0xbf06ff76,
+	0x000000fa, 0xbfa20026,
+	0x81f6ff76, 0x000000e9,
+	0xbf0b8176, 0xbfa20022,
+	0x8b76ff7b, 0x0003fe00,
+	0xbf06ff76, 0x0001fe00,
+	0xbfa2001d, 0x8b76ff7b,
+	0x07fc0000, 0xbf06ff76,
+	0x03fc0000, 0xbfa20018,
+	0xbfa00014, 0x9376ff7a,
+	0x00040016, 0x81f68176,
+	0xbf0b8176, 0xbfa20012,
+	0x9376ff7a, 0x00050011,
+	0x81f68176, 0xbf0b8176,
+	0xbfa2000d, 0x8b76ff7a,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20008,
+	0x8b76ff7b, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20003, 0xbfc70000,
+	0xbefb006e, 0xbfa0ffad,
+	0xbfc70000, 0xbefb006f,
+	0xbfa0ffaa, 0xbfc70000,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf8a0000, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0xb8eff822,
+	0xb980f822, 0x00000000,
+	0xb8fa2b01, 0x847a997a,
+	0x8c6d7a6d, 0xbefa0080,
+	0xb97a2b01, 0xbefa007e,
+	0x8b7bff7f, 0x01ffffff,
+	0xbefe00c1, 0xbeff00c1,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0x7e000280,
+	0xbefe007a, 0xbeff007b,
+	0xb8fb0742, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0x8b7bff7f,
+	0x01ffffff, 0x807aff7a,
+	0x000001c0, 0x807a7e7a,
+	0x827b807b, 0xd7610000,
+	0x00010870, 0xd7610000,
+	0x00010a71, 0xd7610000,
+	0x00010c72, 0xd7610000,
+	0x00010e73, 0xd7610000,
+	0x00011074, 0xd7610000,
+	0x00011275, 0xd7610000,
+	0x00011476, 0xd7610000,
+	0x00011677, 0xd7610000,
+	0x00011a79, 0xd7610000,
+	0x00011c7e, 0xd7610000,
+	0x00011e7f, 0xbefe00ff,
+	0x00003fff, 0xbeff0080,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0xd760007a,
+	0x00011d00, 0xd760007b,
+	0x00011f00, 0xbefe007a,
+	0xbeff007b, 0xbef4007e,
+	0x8b75ff7f, 0x01ffffff,
+	0xbef1007d, 0xb8f30742,
+	0x84739973, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00002,
+	0xbeff00c1, 0xbfa0000a,
+	0xee0a4074, 0x008c0000,
+	0x00008000, 0xee0a4074,
+	0x010c0000, 0x00010000,
+	0xee0a4074, 0x018c0000,
+	0x00018000, 0xbfa00009,
+	0xee0a4074, 0x008c0000,
+	0x00010000, 0xee0a4074,
+	0x010c0000, 0x00020000,
+	0xee0a4074, 0x018c0000,
+	0x00030000, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0x8070ff70, 0x00000200,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefd0080,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8faf802,
+	0xbf0c8b7a, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0xbefa4c88,
+	0xbfc70000, 0xbf0c807a,
+	0xbfa20006, 0x9371ff7a,
+	0x00070004, 0x937aff7a,
+	0x00070010, 0xbf06717a,
+	0xbfa2fff6, 0xb8faf804,
+	0x8b7aff7a, 0x0001000c,
+	0x9178ff78, 0x0001000c,
+	0x8c787a78, 0xd7610002,
+	0x0000fa6c, 0x807d817d,
+	0x8b7aff6d, 0x01ffffff,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6e, 0x807d817d,
+	0xbefa0080, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa78,
+	0x807d817d, 0xb8faf811,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6f, 0x807d817d,
+	0xb8f1f801, 0x937aff6d,
+	0x00060019, 0x847a8c7a,
+	0x8c717a71, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f814, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f815, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f812, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f813, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8faf802, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xbefa50c1, 0xbfc70000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xbefa4c88,
+	0xbfc70000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xb8faf81a, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xbefe00c1, 0xbeff0080,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x010c0000,
+	0x00000000, 0xbefe00c1,
+	0x7e040280, 0xbefa5081,
+	0xbfc70000, 0xd7610002,
+	0x0001007a, 0xbefa5082,
+	0xbfc70000, 0xd7610002,
+	0x0001027a, 0xbefa5083,
+	0xbfc70000, 0xd7610002,
+	0x0001047a, 0xbefa5084,
+	0xbfc70000, 0xd7610002,
+	0x0001067a, 0xbefa5085,
+	0xbfc70000, 0xd7610002,
+	0x0001087a, 0xbefa5086,
+	0xbfc70000, 0xd7610002,
+	0x00010a7a, 0xbefa5087,
+	0xbfc70000, 0xd7610002,
+	0x00010c7a, 0xbefa5088,
+	0xbfc70000, 0xd7610002,
+	0x00010e7a, 0xbefa5089,
+	0xbfc70000, 0xd7610002,
+	0x0001107a, 0xbefa508a,
+	0xbfc70000, 0xd7610002,
+	0x0001127a, 0xbefa508b,
+	0xbfc70000, 0xd7610002,
+	0x0001147a, 0xbefa508c,
+	0xbfc70000, 0xd7610002,
+	0x0001167a, 0xbefa508d,
+	0xbfc70000, 0xd7610002,
+	0x0001187a, 0xbefa508e,
+	0xbfc70000, 0xd7610002,
+	0x00011a7a, 0xbefa508f,
+	0xbfc70000, 0xd7610002,
+	0x00011c7a, 0xbefa5090,
+	0xbfc70000, 0xd7610002,
+	0x00011e7a, 0xee0a4076,
+	0x010c0000, 0x00008000,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xbef90080,
+	0xbefd0080, 0xbf800000,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xbe8c410c, 0xbe8e410e,
+	0xd7610002, 0x0000f200,
+	0x80798179, 0xd7610002,
+	0x0000f201, 0x80798179,
+	0xd7610002, 0x0000f202,
+	0x80798179, 0xd7610002,
+	0x0000f203, 0x80798179,
+	0xd7610002, 0x0000f204,
+	0x80798179, 0xd7610002,
+	0x0000f205, 0x80798179,
+	0xd7610002, 0x0000f206,
+	0x80798179, 0xd7610002,
+	0x0000f207, 0x80798179,
+	0xd7610002, 0x0000f208,
+	0x80798179, 0xd7610002,
+	0x0000f209, 0x80798179,
+	0xd7610002, 0x0000f20a,
+	0x80798179, 0xd7610002,
+	0x0000f20b, 0x80798179,
+	0xd7610002, 0x0000f20c,
+	0x80798179, 0xd7610002,
+	0x0000f20d, 0x80798179,
+	0xd7610002, 0x0000f20e,
+	0x80798179, 0xd7610002,
+	0x0000f20f, 0x80798179,
+	0xbf06a079, 0xbfa10009,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x010c0000,
+	0x00000000, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ffb9, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
+	0x80798179, 0xd7610002,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
+	0x80798179, 0xd7610002,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
+	0x80798179, 0xd7610002,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
+	0x80798179, 0xd7610002,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
+	0x80798179, 0xd7610002,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xbefe00ff,
+	0x0000ffff, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x010c0000, 0x00000000,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8fb4306, 0x8b7bc17b,
+	0xbfa10042, 0x8b7aff6d,
+	0x80000000, 0xbfa1003f,
+	0x847b8a7b, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000200,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20015,
+	0xbe8300ff, 0x00000080,
+	0xbf800000, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf8a0000,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x008c0000,
+	0x00000000, 0x807d037d,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff1,
+	0xbfa00014, 0xbe8300ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8a0000, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x008c0000, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff1, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa2001b,
+	0xbefd0084, 0xbf0a7b7d,
+	0xbfa10032, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x000c0000, 0x00000000,
+	0xee0a4076, 0x008c0000,
+	0x00008000, 0xee0a4076,
+	0x010c0000, 0x00010000,
+	0xee0a4076, 0x018c0000,
+	0x00018000, 0x807d847d,
+	0x8070ff70, 0x00000200,
+	0xbf0a7b7d, 0xbfa2ffe9,
+	0xbfa0001a, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10017,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x000c0000,
+	0x00000000, 0xee0a4076,
+	0x008c0000, 0x00010000,
+	0xee0a4076, 0x010c0000,
+	0x00020000, 0xee0a4076,
+	0x018c0000, 0x00030000,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffe9, 0xbfa00184,
+	0xbef4007e, 0x8b75ff7f,
+	0x01ffffff, 0xbef1007f,
+	0xb8f20742, 0x84729972,
+	0x8b6eff7f, 0x04000000,
+	0xbfa10044, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef4306,
+	0x8b6fc16f, 0xbfa10039,
+	0x846f8a6f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0x8078ff78, 0x00000200,
+	0x8078ff78, 0x00000200,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xd71f0001, 0x000100c1,
+	0xd7200001, 0x000202c1,
+	0x30020282, 0xbfa20012,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xbf8a0000,
+	0xd8340000, 0x00000001,
+	0xd5250001, 0x0001ff01,
+	0x00000080, 0x807dff7d,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2ffef, 0xbfa00011,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xbf8a0000,
+	0xd8340000, 0x00000001,
+	0xd5250001, 0x0001ff01,
+	0x00000100, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2ffef, 0xbef80080,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2002c, 0xbeee0078,
+	0x8078ff78, 0x00000200,
+	0xbefd0084, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0xbfa0002d, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10018, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000060, 0x80767874,
+	0x82778075, 0xbefd00ff,
+	0x0000006c, 0xf460403b,
+	0xf8000000, 0xbf8a0000,
+	0x80fd847d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0x80f6a076, 0x82f78077,
+	0xf460603b, 0xf8000000,
+	0xbf8a0000, 0x80fd887d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0x80f6c076,
+	0x82f78077, 0xf460803b,
+	0xf8000000, 0xbf8a0000,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1ffef,
+	0xb980f801, 0x00000000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80767874,
+	0x82778075, 0xbeff0071,
+	0xf4601bfb, 0xf8000000,
+	0xf4601b3b, 0xf8000004,
+	0xf4601b7b, 0xf8000008,
+	0xf4601c3b, 0xf800000c,
+	0xf4601c7b, 0xf8000010,
+	0xf4601ebb, 0xf8000014,
+	0xf4601efb, 0xf8000018,
+	0xf4601e7b, 0xf800001c,
+	0xf4601cfb, 0xf8000020,
+	0xf4601bbb, 0xf8000024,
+	0xbf8a0000, 0xb96ef814,
+	0xf4601bbb, 0xf8000028,
+	0xbf8a0000, 0xb96ef815,
+	0xf4601bbb, 0xf800002c,
+	0xbf8a0000, 0xb96ef812,
+	0xf4601bbb, 0xf8000030,
+	0xbf8a0000, 0xb96ef813,
+	0x8b6eff7f, 0x04000000,
+	0xbfa10022, 0xf4601bbb,
+	0xf8000038, 0xbf8a0000,
+	0xbf0d806e, 0xbfa1001d,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbef800ff, 0x00000080,
+	0xbefd0081, 0xf4601bbb,
+	0xf0000000, 0xbfc70000,
+	0x80788478, 0x937eff6e,
+	0x00070004, 0x847e907e,
+	0x8c7d7e7d, 0xbe80517d,
+	0x917dff7d, 0x007f0000,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804e7d,
+	0x816ec16e, 0xbfa0fffb,
+	0x807d817d, 0xbf08907d,
+	0xbfa1ffec, 0xf4601bbb,
+	0xf800003c, 0xbfc70000,
+	0xbf0d806e, 0xbfa1000c,
+	0xbf0d9a7f, 0xbfa10002,
+	0xbf068180, 0xbe804fc4,
+	0xbf94fffc, 0xbfa10006,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec3,
+	0x816ec16e, 0xbfa0fffb,
+	0xf4601bbb, 0xf8000040,
+	0xbfc70000, 0xb96ef81a,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb979f822,
+	0xb97b2011, 0x857b867b,
+	0xb97b0191, 0x857b827b,
+	0xb97bba11, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0x806eff6e,
+	0x000001c0, 0x806e746e,
+	0x826f8075, 0xf4605c37,
+	0xf8000010, 0xf4605d37,
+	0xf8000020, 0xf4601e77,
+	0xf8000034, 0xbf8a0000,
+	0x856e9677, 0xb96e04a1,
+	0x856e9577, 0xb96e0421,
+	0x856e8e77, 0xb96e3021,
+	0x8b6dff6d, 0x01ffffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb97af804, 0xb8eef802,
+	0xbf0c8b6e, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0x857a897a,
+	0xb97a0244, 0xbe804a6c,
+	0xb8eef802, 0xbf0c8b6e,
+	0xbfa20003, 0xbe804fc2,
+	0xbf94fffe, 0xbfa10001,
+	0xbe804ec4, 0xbf94fffc,
+	0xbfb10000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index b5af2c97a091..1e248af0e9e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -28,23 +28,26 @@
  */
 
 #define CHIP_GFX12 37
-#define CHIP_GC_12_0_3 38
-
-#define HAVE_XNACK (ASIC_FAMILY == CHIP_GC_12_0_3)
-#define HAVE_57BIT_ADDRESS (ASIC_FAMILY == CHIP_GC_12_0_3)
-#define HAVE_BANKED_VGPRS (ASIC_FAMILY == CHIP_GC_12_0_3)
-#define NUM_NAMED_BARRIERS (ASIC_FAMILY == CHIP_GC_12_0_3 ? 0x10 : 0)
-#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
-#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define CHIP_GC_12_0_3_REV_0 38
+#define CHIP_GC_12_0_3_REV_1 39
+
+#define HAVE_XNACK (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define HAVE_57BIT_ADDRESS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define HAVE_BANKED_VGPRS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define NUM_NAMED_BARRIERS (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0 ? 0x10 : 0)
+#define HAVE_CLUSTER_BARRIER (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
 #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
-#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define HAVE_VOP3PX_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3_REV_0)
+#define HAVE_VGPR_MSB_FIXUP (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define HAVE_INSTRUCTION_FIXUP (HAVE_VOP3PX_FIXUP || HAVE_VGPR_MSB_FIXUP)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
-#define HAVE_HT_TRAP_ID_WA (ASIC_FAMILY >= CHIP_GFX12)
-#define WAVE32_ONLY (ASIC_FAMILY == CHIP_GC_12_0_3)
-#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3)
-#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define HAVE_HT_TRAP_ID_WA 1
+#define WAVE32_ONLY (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define SAVE_TTMPS_IN_SGPR_BLOCK (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
+#define VMEM_ON_TRAP_ENTRY_WA (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
 
 #if HAVE_XNACK && !WAVE32_ONLY
 # error
@@ -76,7 +79,7 @@ var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
 
-#if ASIC_FAMILY < CHIP_GC_12_0_3
+#if ASIC_FAMILY < CHIP_GC_12_0_3_REV_0
 var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
 #else
 var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
@@ -707,7 +710,7 @@ L_SAVE_HWREG:
 	write_hwreg_to_v2(s_save_tmp)
 #endif
 
-#if ASIC_FAMILY >= CHIP_GC_12_0_3
+#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCHED_MODE)
 	write_hwreg_to_v2(s_save_tmp)
 #endif
@@ -1281,7 +1284,7 @@ L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
 L_SKIP_CLUSTER_BARRIER_RESTORE:
 #endif
 
-#if ASIC_FAMILY >= CHIP_GC_12_0_3
+#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
 	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x40
 	s_wait_kmcnt	0
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
@@ -1393,7 +1396,7 @@ function get_sgpr_size_bytes
 end
 
 function get_hwreg_size_bytes
-#if ASIC_FAMILY >= CHIP_GC_12_0_3
+#if ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0
 	return 512
 #else
 	return 128
@@ -1550,6 +1553,7 @@ function fixup_instruction
 	// Instruction is 1 DWORD otherwise
 
 L_FIXUP_ONE_DWORD:
+#if HAVE_VGPR_MSB_FIXUP
 	// Check if TTMP15 contains the value for S_SET_VGPR_MSB instruction
 	s_and_b32	ttmp10, ttmp15, 0xffff0000				// Check encoding in upper 16 bits
 	s_cmp_eq_u32	ttmp10, 0xbf860000					// Check if SOPP (9b'10_1111111) and S_SET_VGPR_MSB (7b'0000110)
@@ -1560,6 +1564,7 @@ L_FIXUP_ONE_DWORD:
 	s_lshr_b32	ttmp13, ttmp13, 6					// Shift SIMM[13:8] into 7:2, Src2, Src1, Src0
 	s_or_b32	ttmp10, ttmp10, ttmp13					// Src2, Src1, Src0, Dst --> format in MODE register
 	s_setreg_b32	hwreg(HW_REG_WAVE_MODE, 12, 8), ttmp10			// Write value into MODE[19:12]
+#endif
 	s_branch	L_FIXUP_DONE
 
 L_FIXUP_NOT_VOP12C:
@@ -1586,10 +1591,12 @@ L_FIXUP_NOT_VOP12C:
 	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
 	// Check if we are in the middle of VOP3PX.
 	s_and_b32	ttmp13, ttmp14, 0xffff0000				// Bits 31:16
+#if HAVE_VOP3PX_FIXUP
 	s_cmp_eq_u32	ttmp13, 0xcc330000					// If 31:16 = 0xcc33, this is 8 bytes past VOP3PX
 	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
 	s_cmp_eq_u32	ttmp13, 0xcc880000					// If 31:16 = 0xcc88, this is 8 bytes past VOP3PX
 	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
+#endif
 	// Might be in VOP3P, but we must ensure we are not VOP3PX2
 	s_cmp_eq_u32	ttmp13, 0xcc350000					// If 31:16 = 0xcc35, this is VOP3PX2
 	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
@@ -1651,10 +1658,12 @@ L_FIXUP_THREE_DWORD:
 	s_mov_b32	ttmp15, ttmp3						// Move possible S_SET_VGPR_MSB into ttmp15
 	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
 
+#if HAVE_VOP3PX_FIXUP
 L_FIXUP_VOP3PX_MIDDLE:
 	s_sub_co_u32	ttmp0, ttmp0, 8						// Rewind PC 8 bytes to beginning of instruction
 	s_sub_co_ci_u32	ttmp1, ttmp1, 0
 	s_branch	L_FIXUP_TWO_DWORD					// 2 DWORD inst (2nd half of a 4 DWORD inst)
+#endif
 
 L_FIXUP_DONE:
 	s_wait_kmcnt	0							// Ensure load of ttmp2 and ttmp3 is done
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0f96c9e3fa4d..edafbd9377b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -564,11 +564,17 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(12, 1, 0) &&
+			(kfd->adev->rev_id & 0xF) == 0) {
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_0_hex)
+					     > KFD_CWSR_TMA_OFFSET);
+			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_0_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);
 		} else {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex)
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex)
 					     > KFD_CWSR_TMA_OFFSET);
-			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_hex;
-			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_hex);
+			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_1_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);
 		}
 
 		kfd->cwsr_enabled = true;
-- 
2.43.0

