Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0745AC54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 16:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778D710E31C;
	Thu, 22 Sep 2022 16:18:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573F910EA6E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 16:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2fFTvkX5H1lxNGUAjC7qCN4+jaACTiwc36H3snxJUb8zmL4l0e5l3U+yJas6AsIehGzZCAEVEerqEnbAu0rJ7HDBtb6wnVPygIJTcE5j/5u+Ui7Qk7RsFOPEihwCNhk4jrqhGzpsjeH+UoVHBPujAmz9FTeGIPK64mcDMmK4kEpNm3DeuO0OvHr/DqWc4KbnVk9+F09zZppUp9USp1UJ4yQqUKp/+Au/5Bn68RRzOZoeoSEiv30zHZzqbNHajplqgVX3rXjmqGO9oKDQtEvBsKHgvi1h8LmmZC1yzORotPN9QborCMwGH3raoCljlBlL6tEAO1g4mWGmiMe5xCjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BorPEjdBK5qZrak9Yt0MkvIxMqAe18I0C7xnHhOW4A=;
 b=BbB9UMeUn068fpKnmnBVXFxodPp2DDViD9f7oWU0+ZLaLXWqzmicMbMAUUNgzuJ0iqXfsLKz7hLxgxNdz2G7qYnInqrXgi4wJN/qGBdZeeI6cP4AmZ1+OsR05UbyPBW2NlpGsDTGZ9bmtuZlKeMMkP3C3SGfmllNAVuBmYZGuHcjqP8RfUDWTmj9XcIYNyN16x7Wb1HUDTSwu2I4RuMOIvs/FPbgxO7G3nY2MxwnhmwL6dhUq+lBUwxc0ocIAZmBJQmISED5nyl7TpKqSkNboeaHpzHX/p/comt8QuRJU1deyE1KO0I6EDe55EiUUu2X5fOLAkMCCYhgiQxdYzaH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BorPEjdBK5qZrak9Yt0MkvIxMqAe18I0C7xnHhOW4A=;
 b=VAQpsWEAtX39b//Ck8nQVwuU+CgmoiX02ENmfR/x1S/t0rfbvsuYgBzmVQXuNwrOhOuxljK6bDEbUC+T7BxJQKsEbANRRmxk2ZNHRI2ekqjlnUUiPZyAddOJwRpGJzU+7ijQpDXAFPbyJ84ls349qfaEy/Zdx4T6hcFr3eqBjgk=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 16:18:37 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::13) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 16:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 16:18:36 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 11:18:35 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable SA software trap.
Date: Thu, 22 Sep 2022 12:17:03 -0400
Message-ID: <20220922161703.916705-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: eb07e59a-de5d-471b-15fd-08da9cb61a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOnu6FzFxgXk1mMIcR05oWxiVPHqCunNi6OAkCyBHvgAPPLGaN6XMxG1V4HwXpmYcUBqQPemGtCty6kgH2PyOs5W1U2H8TUw7UhMqI/C1FNvm87O5JCmI2Jakdp+boeT6yIMOwQrSGJChLHhnkM9sdFhFtjEjgzZ6aiypmDawbfLWTyCBmhfx3Pw2QOtwoSPuWaY4STzV2iWI9zwWcdCAb7zcm9yrrwoUvXTSo/xaBdyDDbdb6CW0ZZPqI6aJKUqE43CM4otI/J6HRmgEO4j0/luLpZ3TVxPdcvP2OjH7PeNLdwcxSvvV6ll+6kp2bg0peiBZguS87yQDkkdjmPd5EDHVVv0XJd0LCl93ZQf4hdwJRAcv8mGFknoAaOvlDuWbQVh4EVjdIWOUBIL3dOVJk0cFSZc3qyE5DTjS5IdwL/MIgrxDX1bKGunEqRFuhBteTZK95OIXKkuyneGR3SlXSzJ0riosD5XMjsmzD/Tevx3Z5Vddp9wfgKnk/T75kqHNKJChopoZd1r0+LokbKlDAXvfQDUyu1QYcE+pGJf3i7LLzcD4hueaYR+sWAw4iwljWHnnB71MFtkQWezhdYDLdR4AV/r97MsHTaMBPYcOfQjhKAtYD+8izMcgyCVOvIU1rqHqmzwFFDj2/23AXgY0iHiNJ85Gh4p3j/UotTc+wHjpr7yDwXslS/LV5RAF2yCoosLvd6gQde9tTOLqXBMJc5cyYACNR4MOA4zv9GqDmBvYq1UtSyt9SwV7m9Z9ZGqhmlGuy3Y2Am2Tae5u31tJqrmzDZu9OX0P3NHhREY7tk1ZJaXe51vWxJNrERgvX6L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(81166007)(82740400003)(8936002)(356005)(2616005)(83380400001)(70206006)(1076003)(16526019)(336012)(186003)(426003)(86362001)(47076005)(478600001)(26005)(2906002)(40460700003)(54906003)(316002)(6916009)(7696005)(44832011)(41300700001)(5660300002)(70586007)(30864003)(8676002)(6666004)(40480700001)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:18:36.3338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb07e59a-de5d-471b-15fd-08da9cb61a39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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
Cc: Jay Cornwall <Jay.Cornwall@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 David Belanger <david.belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enables support for software trap for MES >= 4.
Adapted from implementation from Jay Cornwall.

v2: Add IP version check in conditions.

Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  26 +-
 4 files changed, 437 insertions(+), 387 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b64cd46a159a..cbc506b958b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -185,7 +185,11 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
-	mes_add_queue_pkt.trap_en = 1;
+
+	if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
+		  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
+		  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3))))
+		mes_add_queue_pkt.trap_en = 1;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 60a81649cf12..c7118843db05 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -742,7 +742,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbf88fffe, 0x877aff7f,
 	0x04000000, 0x8f7a857a,
 	0x886d7a6d, 0xb97b02dc,
-	0x8f7b997b, 0xb97a2a05,
+	0x8f7b997b, 0xb97a3a05,
 	0x807a817a, 0xbf0d997b,
 	0xbf850002, 0x8f7a897a,
 	0xbf820001, 0x8f7a8a7a,
@@ -819,7 +819,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbefe037c, 0xbefc0370,
 	0xf4611c7a, 0xf8000000,
 	0x80708470, 0xbefc037e,
-	0xb9702a05, 0x80708170,
+	0xb9703a05, 0x80708170,
 	0xbf0d9973, 0xbf850002,
 	0x8f708970, 0xbf820001,
 	0x8f708a70, 0xb97a1e06,
@@ -1069,7 +1069,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xb9f9f816, 0x876f7bff,
 	0xfffff800, 0x906f8b6f,
 	0xb9efa2c3, 0xb9f3f801,
-	0xb96e2a05, 0x806e816e,
+	0xb96e3a05, 0x806e816e,
 	0xbf0d9972, 0xbf850002,
 	0x8f6e896e, 0xbf820001,
 	0x8f6e8a6e, 0xb96f1e06,
@@ -2114,7 +2114,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x007a0000, 0x7e000280,
 	0xbefe037a, 0xbeff037b,
 	0xb97b02dc, 0x8f7b997b,
-	0xb97a2a05, 0x807a817a,
+	0xb97a3a05, 0x807a817a,
 	0xbf0d997b, 0xbf850002,
 	0x8f7a897a, 0xbf820001,
 	0x8f7a8a7a, 0xb97b1e06,
@@ -2157,7 +2157,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x01000000, 0xe0704100,
 	0x705d0100, 0xe0704200,
 	0x705d0200, 0xe0704300,
-	0x705d0300, 0xb9702a05,
+	0x705d0300, 0xb9703a05,
 	0x80708170, 0xbf0d9973,
 	0xbf850002, 0x8f708970,
 	0xbf820001, 0x8f708a70,
@@ -2189,7 +2189,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbefe03ff, 0x0000ffff,
 	0xbeff0380, 0xe0704000,
 	0x705d0200, 0xbefe03c1,
-	0xb9702a05, 0x80708170,
+	0xb9703a05, 0x80708170,
 	0xbf0d9973, 0xbf850002,
 	0x8f708970, 0xbf820001,
 	0x8f708a70, 0xb97a1e06,
@@ -2475,7 +2475,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xb9ef4803, 0x876f7bff,
 	0xfffff800, 0x906f8b6f,
 	0xb9efa2c3, 0xb9f3f801,
-	0xb96e2a05, 0x806e816e,
+	0xb96e3a05, 0x806e816e,
 	0xbf0d9972, 0xbf850002,
 	0x8f6e896e, 0xbf820001,
 	0x8f6e8a6e, 0xb96f1e06,
@@ -2494,438 +2494,441 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
 };
-
 static const uint32_t cwsr_trap_gfx11_hex[] = {
-	0xbfa00001, 0xbfa0021b,
+	0xbfa00001, 0xbfa0021e,
 	0xb0804006, 0xb8f8f802,
-	0x91788678, 0xb8fbf803,
-	0x8b6eff78, 0x00002000,
-	0xbfa10009, 0x8b6eff6d,
-	0x00ff0000, 0xbfa2001e,
-	0x8b6eff7b, 0x00000400,
-	0xbfa20041, 0xbf830010,
-	0xb8fbf803, 0xbfa0fffa,
-	0x8b6eff7b, 0x00000900,
-	0xbfa20015, 0x8b6eff7b,
-	0x000071ff, 0xbfa10008,
-	0x8b6fff7b, 0x00007080,
-	0xbfa10001, 0xbeee1287,
-	0xb8eff801, 0x846e8c6e,
-	0x8b6e6f6e, 0xbfa2000a,
+	0x9178ff78, 0x00020006,
+	0xb8fbf803, 0xbf0d9f6d,
+	0xbfa20006, 0x8b6eff78,
+	0x00002000, 0xbfa10009,
 	0x8b6eff6d, 0x00ff0000,
-	0xbfa20007, 0xb8eef801,
-	0x8b6eff6e, 0x00000800,
-	0xbfa20003, 0x8b6eff7b,
-	0x00000400, 0xbfa20026,
-	0xbefa4d82, 0xbf89fc07,
-	0x84fa887a, 0xf4005bbd,
-	0xf8000010, 0xbf89fc07,
-	0x846e976e, 0x9177ff77,
-	0x00800000, 0x8c776e77,
-	0xf4045bbd, 0xf8000000,
-	0xbf89fc07, 0xf4045ebd,
-	0xf8000008, 0xbf89fc07,
-	0x8bee6e6e, 0xbfa10001,
-	0xbe80486e, 0x8b6eff6d,
-	0x01ff0000, 0xbfa20005,
-	0x8c78ff78, 0x00002000,
-	0x80ec886c, 0x82ed806d,
-	0xbfa00005, 0x8b6eff6d,
-	0x01000000, 0xbfa20002,
-	0x806c846c, 0x826d806d,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0xb978f802, 0xbe804a6c,
-	0x8b6dff6d, 0x0000ffff,
-	0xbefa0080, 0xb97a0283,
-	0xbeee007e, 0xbeef007f,
-	0xbefe0180, 0xbefe4d84,
-	0xbf89fc07, 0x8b7aff7f,
-	0x04000000, 0x847a857a,
-	0x8c6d7a6d, 0xbefa007e,
-	0x8b7bff7f, 0x0000ffff,
-	0xbefe00c1, 0xbeff00c1,
-	0xdca6c000, 0x007a0000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb02dc,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
-	0xb8fb1e06, 0x847b8a7b,
-	0x807a7b7a, 0x8b7bff7f,
-	0x0000ffff, 0x807aff7a,
-	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xd7610000,
-	0x00010870, 0xd7610000,
-	0x00010a71, 0xd7610000,
-	0x00010c72, 0xd7610000,
-	0x00010e73, 0xd7610000,
-	0x00011074, 0xd7610000,
-	0x00011275, 0xd7610000,
-	0x00011476, 0xd7610000,
-	0x00011677, 0xd7610000,
-	0x00011a79, 0xd7610000,
-	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xbefe00ff,
-	0x00003fff, 0xbeff0080,
-	0xdca6c040, 0x007a0000,
-	0xd760007a, 0x00011d00,
-	0xd760007b, 0x00011f00,
+	0xbfa2001e, 0x8b6eff7b,
+	0x00000400, 0xbfa20041,
+	0xbf830010, 0xb8fbf803,
+	0xbfa0fffa, 0x8b6eff7b,
+	0x00000900, 0xbfa20015,
+	0x8b6eff7b, 0x000071ff,
+	0xbfa10008, 0x8b6fff7b,
+	0x00007080, 0xbfa10001,
+	0xbeee1287, 0xb8eff801,
+	0x846e8c6e, 0x8b6e6f6e,
+	0xbfa2000a, 0x8b6eff6d,
+	0x00ff0000, 0xbfa20007,
+	0xb8eef801, 0x8b6eff6e,
+	0x00000800, 0xbfa20003,
+	0x8b6eff7b, 0x00000400,
+	0xbfa20026, 0xbefa4d82,
+	0xbf89fc07, 0x84fa887a,
+	0xf4005bbd, 0xf8000010,
+	0xbf89fc07, 0x846e976e,
+	0x9177ff77, 0x00800000,
+	0x8c776e77, 0xf4045bbd,
+	0xf8000000, 0xbf89fc07,
+	0xf4045ebd, 0xf8000008,
+	0xbf89fc07, 0x8bee6e6e,
+	0xbfa10001, 0xbe80486e,
+	0x8b6eff6d, 0x01ff0000,
+	0xbfa20005, 0x8c78ff78,
+	0x00002000, 0x80ec886c,
+	0x82ed806d, 0xbfa00005,
+	0x8b6eff6d, 0x01000000,
+	0xbfa20002, 0x806c846c,
+	0x826d806d, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb978f802,
+	0xbe804a6c, 0x8b6dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xbeee007e,
+	0xbeef007f, 0xbefe0180,
+	0xbefe4d84, 0xbf89fc07,
+	0x8b7aff7f, 0x04000000,
+	0x847a857a, 0x8c6d7a6d,
+	0xbefa007e, 0x8b7bff7f,
+	0x0000ffff, 0xbefe00c1,
+	0xbeff00c1, 0xdca6c000,
+	0x007a0000, 0x7e000280,
 	0xbefe007a, 0xbeff007b,
-	0xbef4007e, 0x8b75ff7f,
-	0x0000ffff, 0x8c75ff75,
-	0x00040000, 0xbef60080,
-	0xbef700ff, 0x10807fac,
-	0xbef1007d, 0xbef00080,
-	0xb8f302dc, 0x84739973,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00002, 0xbeff00c1,
-	0xbfa00009, 0xbef600ff,
-	0x01000000, 0xe0685080,
-	0x701d0100, 0xe0685100,
-	0x701d0200, 0xe0685180,
-	0x701d0300, 0xbfa00008,
+	0xb8fb02dc, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0xb8fb1e06,
+	0x847b8a7b, 0x807a7b7a,
+	0x8b7bff7f, 0x0000ffff,
+	0x807aff7a, 0x00000200,
+	0x807a7e7a, 0x827b807b,
+	0xd7610000, 0x00010870,
+	0xd7610000, 0x00010a71,
+	0xd7610000, 0x00010c72,
+	0xd7610000, 0x00010e73,
+	0xd7610000, 0x00011074,
+	0xd7610000, 0x00011275,
+	0xd7610000, 0x00011476,
+	0xd7610000, 0x00011677,
+	0xd7610000, 0x00011a79,
+	0xd7610000, 0x00011c7e,
+	0xd7610000, 0x00011e7f,
+	0xbefe00ff, 0x00003fff,
+	0xbeff0080, 0xdca6c040,
+	0x007a0000, 0xd760007a,
+	0x00011d00, 0xd760007b,
+	0x00011f00, 0xbefe007a,
+	0xbeff007b, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xbef1007d,
+	0xbef00080, 0xb8f302dc,
+	0x84739973, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00002,
+	0xbeff00c1, 0xbfa00009,
 	0xbef600ff, 0x01000000,
-	0xe0685100, 0x701d0100,
-	0xe0685200, 0x701d0200,
-	0xe0685300, 0x701d0300,
+	0xe0685080, 0x701d0100,
+	0xe0685100, 0x701d0200,
+	0xe0685180, 0x701d0300,
+	0xbfa00008, 0xbef600ff,
+	0x01000000, 0xe0685100,
+	0x701d0100, 0xe0685200,
+	0x701d0200, 0xe0685300,
+	0x701d0300, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0xbef600ff,
+	0x01000000, 0x7e000280,
+	0x7e020280, 0x7e040280,
+	0xbefd0080, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xd7610002, 0x0000fa6c,
+	0x807d817d, 0x917aff6d,
+	0x80000000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa6e,
+	0x807d817d, 0xd7610002,
+	0x0000fa6f, 0x807d817d,
+	0xd7610002, 0x0000fa78,
+	0x807d817d, 0xb8faf803,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa7b, 0x807d817d,
+	0xb8f1f801, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f814, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f815, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xbefe00ff, 0x0000ffff,
+	0xbeff0080, 0xe0685000,
+	0x701d0200, 0xbefe00c1,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
 	0x84708a70, 0xb8fa1e06,
 	0x847a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
 	0xbef600ff, 0x01000000,
-	0x7e000280, 0x7e020280,
-	0x7e040280, 0xbefd0080,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xd7610002,
-	0x0000fa6c, 0x807d817d,
-	0x917aff6d, 0x80000000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xd7610002,
-	0x0000fa6e, 0x807d817d,
-	0xd7610002, 0x0000fa6f,
-	0x807d817d, 0xd7610002,
-	0x0000fa78, 0x807d817d,
-	0xb8faf803, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa7b,
-	0x807d817d, 0xb8f1f801,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f814,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f815,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
-	0xe0685000, 0x701d0200,
-	0xbefe00c1, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0xbef600ff,
-	0x01000000, 0xbef90080,
-	0xbefd0080, 0xbf800000,
-	0xbe804100, 0xbe824102,
-	0xbe844104, 0xbe864106,
-	0xbe884108, 0xbe8a410a,
-	0xbe8c410c, 0xbe8e410e,
-	0xd7610002, 0x0000f200,
-	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
-	0xd7610002, 0x0000f202,
-	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
-	0xd7610002, 0x0000f204,
+	0xbef90080, 0xbefd0080,
+	0xbf800000, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xbe8c410c,
+	0xbe8e410e, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
 	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
-	0xd7610002, 0x0000f206,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
 	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
-	0xd7610002, 0x0000f208,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
 	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
-	0xd7610002, 0x0000f20a,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
 	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
-	0xd7610002, 0x0000f20c,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
 	0x80798179, 0xd7610002,
-	0x0000f20d, 0x80798179,
-	0xd7610002, 0x0000f20e,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
 	0x80798179, 0xd7610002,
-	0x0000f20f, 0x80798179,
-	0xbf06a079, 0xbfa10006,
-	0xe0685000, 0x701d0200,
-	0x8070ff70, 0x00000080,
-	0xbef90080, 0x7e040280,
-	0x807d907d, 0xbf0aff7d,
-	0x00000060, 0xbfa2ffbc,
-	0xbe804100, 0xbe824102,
-	0xbe844104, 0xbe864106,
-	0xbe884108, 0xbe8a410a,
-	0xd7610002, 0x0000f200,
+	0x0000f20c, 0x80798179,
+	0xd7610002, 0x0000f20d,
 	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
-	0xd7610002, 0x0000f202,
+	0x0000f20e, 0x80798179,
+	0xd7610002, 0x0000f20f,
+	0x80798179, 0xbf06a079,
+	0xbfa10006, 0xe0685000,
+	0x701d0200, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ffbc, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
 	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
-	0xd7610002, 0x0000f204,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
 	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
-	0xd7610002, 0x0000f206,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
 	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
-	0xd7610002, 0x0000f208,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
 	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
-	0xd7610002, 0x0000f20a,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
 	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
-	0xe0685000, 0x701d0200,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xe0685000,
+	0x701d0200, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8fb4306,
+	0x8b7bc17b, 0xbfa10044,
+	0xbfbd0000, 0x8b7aff6d,
+	0x80000000, 0xbfa10040,
+	0x847b867b, 0x847b827b,
+	0xbef6007b, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0x8070ff70,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xd71f0000,
+	0x000100c1, 0xd7200000,
+	0x000200c1, 0x16000084,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa20012, 0xbe8300ff,
+	0x00000080, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf890000, 0xe0685000,
+	0x701d0100, 0x807d037d,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff4,
+	0xbfa00011, 0xbe8300ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf890000, 0xe0685000,
+	0x701d0100, 0x807d037d,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000100,
+	0xbf0a7b7d, 0xbfa2fff4,
 	0xbefe00c1, 0x857d9973,
 	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8fb4306, 0x8b7bc17b,
-	0xbfa10044, 0xbfbd0000,
-	0x8b7aff6d, 0x80000000,
-	0xbfa10040, 0x847b867b,
-	0x847b827b, 0xbef6007b,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0xb8fa1e06,
-	0x847a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
-	0x8070ff70, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0xd71f0000, 0x000100c1,
-	0xd7200000, 0x000200c1,
-	0x16000084, 0x857d9973,
+	0xbfa20004, 0xbef000ff,
+	0x00000200, 0xbeff0080,
+	0xbfa00003, 0xbef000ff,
+	0x00000400, 0xbeff00c1,
+	0xb8fb3b05, 0x807b817b,
+	0x847b827b, 0x857d9973,
 	0x8b7d817d, 0xbf06817d,
-	0xbefd0080, 0xbfa20012,
-	0xbe8300ff, 0x00000080,
-	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
-	0x01000000, 0xbf890000,
-	0xe0685000, 0x701d0100,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff4, 0xbfa00011,
-	0xbe8300ff, 0x00000100,
-	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
-	0x01000000, 0xbf890000,
-	0xe0685000, 0x701d0100,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000100, 0xbf0a7b7d,
-	0xbfa2fff4, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20004,
-	0xbef000ff, 0x00000200,
-	0xbeff0080, 0xbfa00003,
-	0xbef000ff, 0x00000400,
-	0xbeff00c1, 0xb8fb3b05,
-	0x807b817b, 0x847b827b,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20017,
+	0xbfa20017, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10037,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0xe0685000, 0x701d0000,
+	0xe0685080, 0x701d0100,
+	0xe0685100, 0x701d0200,
+	0xe0685180, 0x701d0300,
+	0x807d847d, 0x8070ff70,
+	0x00000200, 0xbf0a7b7d,
+	0xbfa2ffef, 0xbfa00025,
 	0xbef600ff, 0x01000000,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10037, 0x7e008700,
+	0xbfa10011, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xe0685000,
-	0x701d0000, 0xe0685080,
-	0x701d0100, 0xe0685100,
-	0x701d0200, 0xe0685180,
+	0x701d0000, 0xe0685100,
+	0x701d0100, 0xe0685200,
+	0x701d0200, 0xe0685300,
 	0x701d0300, 0x807d847d,
-	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000400,
 	0xbf0a7b7d, 0xbfa2ffef,
-	0xbfa00025, 0xbef600ff,
-	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10011,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
+	0xb8fb1e06, 0x8b7bc17b,
+	0xbfa1000c, 0x847b837b,
+	0x807b7d7b, 0xbefe00c1,
+	0xbeff0080, 0x7e008700,
 	0xe0685000, 0x701d0000,
-	0xe0685100, 0x701d0100,
-	0xe0685200, 0x701d0200,
-	0xe0685300, 0x701d0300,
-	0x807d847d, 0x8070ff70,
-	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffef, 0xb8fb1e06,
-	0x8b7bc17b, 0xbfa1000c,
-	0x847b837b, 0x807b7d7b,
-	0xbefe00c1, 0xbeff0080,
-	0x7e008700, 0xe0685000,
-	0x701d0000, 0x807d817d,
-	0x8070ff70, 0x00000080,
-	0xbf0a7b7d, 0xbfa2fff8,
-	0xbfa00141, 0xbef4007e,
-	0x8b75ff7f, 0x0000ffff,
-	0x8c75ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x10807fac, 0xb8f202dc,
-	0x84729972, 0x8b6eff7f,
-	0x04000000, 0xbfa1003a,
+	0x807d817d, 0x8070ff70,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff8, 0xbfa00146,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xb8f202dc, 0x84729972,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1003a, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef4306,
+	0x8b6fc16f, 0xbfa1002f,
+	0x846f866f, 0x846f826f,
+	0xbef6006f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa2000c,
+	0xe0500000, 0x781d0000,
+	0xbf8903f7, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff5, 0xbfa0000b,
+	0xe0500000, 0x781d0000,
+	0xbf8903f7, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2fff5, 0xbef80080,
 	0xbefe00c1, 0x857d9972,
 	0x8b7d817d, 0xbf06817d,
 	0xbfa20002, 0xbeff0080,
 	0xbfa00001, 0xbeff00c1,
-	0xb8ef4306, 0x8b6fc16f,
-	0xbfa1002f, 0x846f866f,
-	0x846f826f, 0xbef6006f,
-	0xb8f83b05, 0x80788178,
-	0xbf0d9972, 0xbfa20002,
-	0x84788978, 0xbfa00001,
-	0x84788a78, 0xb8ee1e06,
-	0x846e8a6e, 0x80786e78,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20024, 0xbef600ff,
+	0x01000000, 0xbeee0078,
 	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa2000c, 0xe0500000,
-	0x781d0000, 0xbf8903f7,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000080,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff5,
-	0xbfa0000b, 0xe0500000,
-	0x781d0000, 0xbf8903f7,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7d, 0xbfa2fff5,
-	0xbef80080, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef3b05,
-	0x806f816f, 0x846f826f,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20024,
-	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000200, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10050,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10050, 0xe0505000,
+	0x781d0000, 0xe0505080,
+	0x781d0100, 0xe0505100,
+	0x781d0200, 0xe0505180,
+	0x781d0300, 0xbf8903f7,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffee, 0xe0505000,
+	0x6e1d0000, 0xe0505080,
+	0x6e1d0100, 0xe0505100,
+	0x6e1d0200, 0xe0505180,
+	0x6e1d0300, 0xbf8903f7,
+	0xbfa00034, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10012, 0xe0505000,
+	0x781d0000, 0xe0505100,
+	0x781d0100, 0xe0505200,
+	0x781d0200, 0xe0505300,
+	0x781d0300, 0xbf8903f7,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffee, 0xb8ef1e06,
+	0x8b6fc16f, 0xbfa1000e,
+	0x846f836f, 0x806f7d6f,
+	0xbefe00c1, 0xbeff0080,
 	0xe0505000, 0x781d0000,
-	0xe0505080, 0x781d0100,
-	0xe0505100, 0x781d0200,
-	0xe0505180, 0x781d0300,
 	0xbf8903f7, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000200,
-	0xbf0a6f7d, 0xbfa2ffee,
+	0x807d817d, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff7, 0xbeff00c1,
 	0xe0505000, 0x6e1d0000,
-	0xe0505080, 0x6e1d0100,
-	0xe0505100, 0x6e1d0200,
-	0xe0505180, 0x6e1d0300,
-	0xbf8903f7, 0xbfa00034,
-	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000400, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10012,
-	0xe0505000, 0x781d0000,
-	0xe0505100, 0x781d0100,
-	0xe0505200, 0x781d0200,
-	0xe0505300, 0x781d0300,
-	0xbf8903f7, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7d, 0xbfa2ffee,
-	0xb8ef1e06, 0x8b6fc16f,
-	0xbfa1000e, 0x846f836f,
-	0x806f7d6f, 0xbefe00c1,
-	0xbeff0080, 0xe0505000,
-	0x781d0000, 0xbf8903f7,
-	0x7e008500, 0x807d817d,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff7,
-	0xbeff00c1, 0xe0505000,
-	0x6e1d0000, 0xe0505100,
-	0x6e1d0100, 0xe0505200,
-	0x6e1d0200, 0xe0505300,
-	0x6e1d0300, 0xbf8903f7,
+	0xe0505100, 0x6e1d0100,
+	0xe0505200, 0x6e1d0200,
+	0xe0505300, 0x6e1d0300,
+	0xbf8903f7, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000050, 0xbef600ff,
+	0x01000000, 0xbefd00ff,
+	0x0000006c, 0x80f89078,
+	0xf428403a, 0xf0000000,
+	0xbf89fc07, 0x80fd847d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0x80f8a078,
+	0xf42c403a, 0xf0000000,
+	0xbf89fc07, 0x80fd887d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0x80f8c078,
+	0xf430403a, 0xf0000000,
+	0xbf89fc07, 0x80fd907d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0xbe884308,
+	0xbe8a430a, 0xbe8c430c,
+	0xbe8e430e, 0xbf06807d,
+	0xbfa1fff0, 0xb980f801,
+	0x00000000, 0xbfbd0000,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
 	0x84788a78, 0xb8ee1e06,
 	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000050,
 	0xbef600ff, 0x01000000,
-	0xbefd00ff, 0x0000006c,
-	0x80f89078, 0xf428403a,
-	0xf0000000, 0xbf89fc07,
-	0x80fd847d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0x80f8a078, 0xf42c403a,
-	0xf0000000, 0xbf89fc07,
-	0x80fd887d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0x80f8c078, 0xf430403a,
-	0xf0000000, 0xbf89fc07,
-	0x80fd907d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0xbe884308, 0xbe8a430a,
-	0xbe8c430c, 0xbe8e430e,
-	0xbf06807d, 0xbfa1fff0,
-	0xb980f801, 0x00000000,
-	0xbfbd0000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0xf4205bfa,
+	0xf4205bfa, 0xf0000000,
+	0x80788478, 0xf4205b3a,
 	0xf0000000, 0x80788478,
-	0xf4205b3a, 0xf0000000,
-	0x80788478, 0xf4205b7a,
+	0xf4205b7a, 0xf0000000,
+	0x80788478, 0xf4205c3a,
 	0xf0000000, 0x80788478,
-	0xf4205c3a, 0xf0000000,
-	0x80788478, 0xf4205c7a,
+	0xf4205c7a, 0xf0000000,
+	0x80788478, 0xf4205eba,
 	0xf0000000, 0x80788478,
-	0xf4205eba, 0xf0000000,
-	0x80788478, 0xf4205efa,
+	0xf4205efa, 0xf0000000,
+	0x80788478, 0xf4205e7a,
 	0xf0000000, 0x80788478,
-	0xf4205e7a, 0xf0000000,
-	0x80788478, 0xf4205cfa,
+	0xf4205cfa, 0xf0000000,
+	0x80788478, 0xf4205bba,
 	0xf0000000, 0x80788478,
+	0xbf89fc07, 0xb96ef814,
 	0xf4205bba, 0xf0000000,
 	0x80788478, 0xbf89fc07,
-	0xb96ef814, 0xf4205bba,
-	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xb96ef815,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0x8b6f7bff,
-	0x000003ff, 0xb96f4803,
-	0x8b6f7bff, 0xfffff800,
-	0x856f8b6f, 0xb96fa2c3,
-	0xb973f801, 0xb8ee3b05,
-	0x806e816e, 0xbf0d9972,
-	0xbfa20002, 0x846e896e,
-	0xbfa00001, 0x846e8a6e,
-	0xb8ef1e06, 0x846f8a6f,
-	0x806e6f6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x8b6fff6f,
-	0x0000ffff, 0xf4085c37,
-	0xf8000050, 0xf4085d37,
-	0xf8000060, 0xf4005e77,
-	0xf8000074, 0xbf89fc07,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
+	0xb96ef815, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0x8b6f7bff, 0x000003ff,
+	0xb96f4803, 0x8b6f7bff,
+	0xfffff800, 0x856f8b6f,
+	0xb96fa2c3, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0xb8ef1e06,
+	0x846f8a6f, 0x806e6f6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x8b6fff6f, 0x0000ffff,
+	0xf4085c37, 0xf8000050,
+	0xf4085d37, 0xf8000060,
+	0xf4005e77, 0xf8000074,
+	0xbf89fc07, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb8eef802,
+	0xbf0d866e, 0xbfa20002,
+	0xb97af802, 0xbe80486c,
 	0xb97af802, 0xbe804a6c,
 	0xbfb00000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 250ab007399b..0f81670f6f9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -43,12 +43,14 @@
 #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)
 #define HAVE_SENDMSG_RTN (ASIC_FAMILY >= CHIP_PLUM_BONITO)
 #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
+#define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO)
 
 var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
 var SQ_WAVE_STATUS_SPI_PRIO_MASK		= 0x00000006
 var SQ_WAVE_STATUS_HALT_MASK			= 0x2000
 var SQ_WAVE_STATUS_ECC_ERR_MASK			= 0x20000
+var SQ_WAVE_STATUS_TRAP_EN_SHIFT		= 6
 
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
@@ -183,6 +185,13 @@ L_SKIP_RESTORE:
 
 	s_getreg_b32	s_save_trapsts, hwreg(HW_REG_TRAPSTS)
 
+#if SW_SA_TRAP
+	// If ttmp1[31] is set then trap may occur early.
+	// Spin wait until SAVECTX exception is raised.
+	s_bitcmp1_b32	s_save_pc_hi, 31
+	s_cbranch_scc1  L_CHECK_SAVE
+#endif
+
 	s_and_b32       ttmp2, s_save_status, SQ_WAVE_STATUS_HALT_MASK
 	s_cbranch_scc0	L_NOT_HALTED
 
@@ -1061,8 +1070,20 @@ L_RESTORE_HWREG:
 	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
+
+#if SW_SA_TRAP
+	// If traps are enabled then return to the shader with PRIV=0.
+	// Otherwise retain PRIV=1 for subsequent context save requests.
+	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_STATUS)
+	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_STATUS_TRAP_EN_SHIFT
+	s_cbranch_scc1	L_RETURN_WITHOUT_PRIV
+
 	s_setreg_b32	hwreg(HW_REG_STATUS), s_restore_status			// SCC is included, which is changed by previous salu
+	s_setpc_b64	[s_restore_pc_lo, s_restore_pc_hi]
+L_RETURN_WITHOUT_PRIV:
+#endif
 
+	s_setreg_b32	hwreg(HW_REG_STATUS), s_restore_status			// SCC is included, which is changed by previous salu
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index a6fcbeeb7428..4e03d19e9333 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -358,13 +358,35 @@ static void event_interrupt_wq_v11(struct kfd_dev *dev,
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				print_sq_intr_info_error(context_id0, context_id1);
+				sq_int_priv = REG_GET_FIELD(context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
 				sq_int_errtype = REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
-				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
-				    sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+
+				switch (sq_int_errtype) {
+				case SQ_INTERRUPT_ERROR_TYPE_EDC_FUE:
+				case SQ_INTERRUPT_ERROR_TYPE_EDC_FED:
 					event_interrupt_poison_consumption_v11(
 							dev, pasid, source_id);
 					return;
+				case SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST:
+					/*if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
+						  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
+						  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
+						&& sq_int_priv)
+						kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
+							KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION),
+							NULL, 0);*/
+					return;
+				case SQ_INTERRUPT_ERROR_TYPE_MEMVIOL:
+					/*if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
+						  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
+						  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
+						&& sq_int_priv)
+						kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
+							KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION),
+							NULL, 0);*/
+					return;
 				}
 				break;
 			default:
-- 
2.36.1

