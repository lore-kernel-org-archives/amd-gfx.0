Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C268C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 22:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA15610EAE3;
	Mon,  6 Jul 2026 22:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTrD8Bjy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB93610EAE3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 22:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaP1gWtL3VujF8jYFW4P2qIUB3Q8nH3SKRtutpOanXRC1oAX2m70dCaqmkSXg0w5oJzkVLWdeIXsaC4qaMNPB7hBlZTK9JjZ6HAxTNXLyfXqOLbj/RVAehuWs84/Caz6xmmBjcm43ASslVEJrY6xIZQcKLS2uf0txAEty/tHh/9mFcRAmyQ+1RSFPggq+moNjRvrA4573TuQx2/kBEY4qmSvU5gLglKJlInK5uPmExLNSc4gJIn4m14B5Lgnym311UdL88LKrgtrtcUIfJRtAvFekcLB+i/Gd/7Jp7/kKq35Q9dSNj7W1fDK4AR8UvnkieKrNhPvVQzJhukdCvMRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS+TgkVRkeYrOeFzkry6rCVgcdyFoI6UWwYOGFgDSHI=;
 b=sDdzO6df3N+uvirKR8pksqCTegBP/6GxfGLIvJ3UMSJhGNo6PQhhcynZZ2NswOw5vgQOl8PxirptMhVshfdWChFA8c+zr+53RuZ6X/f0rIjhHi6Iiz+Q4Jk4uyCml5hAZ8oDV+S4wHG81yZx6KVvN3muF675lhSS2Gix6dVkAnv0vNUoVajJNR8sIdrRUcJmRCJKuMpApnjOkRCnROPBDY7UcS2At23276ViFpSEVfs4BZLXJXxkO5RF/A2Xta1S8j54odqxoCoXeTbWshATBMev5GCZnA1FNzgWztE/hoesa0j12BEuWJElP1JIA8AnE2h7LkoZ8tDYZbl1BtFCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS+TgkVRkeYrOeFzkry6rCVgcdyFoI6UWwYOGFgDSHI=;
 b=QTrD8Bjyw+Tez1JMJGwqqSJyvQVscQ5uWr/a8hIC7Uc3piEnIpVl/Y7fpQJFI+Vb/dkjQCkg7QFIZeb7IRWAIzBwVWQTtO3tBzSaVcIgdYtCRUhK2wRxaV9/g/1xcsvdXsCzZmK/W8reIWeU68M2vXzvnfZItnsd4nqepSJO7HI=
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 22:01:43 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::50) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 22:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 22:01:42 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 17:01:42 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Vladimir Indic <vladimir.indic@amd.com>, Tishko Araz <tishko.araz@amd.com>,
 Max Erenberg <max.erenberg@amd.com>
Subject: [PATCH] drm/amdkfd: Fix named barrier restore in gfx12.1 trap handler
Date: Mon, 6 Jul 2026 17:00:43 -0500
Message-ID: <20260706220043.612554-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf7c748-dfc0-4351-7482-08dedbaa2a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WZyTPd5MKXkUTBZ8EQAwhxoFAx61hY2RrOuHu+ncHxBjMbKkhrXzOEe5r59APsuo8SDde1g6f9zsR3llzHdkaeUPlkR/lnpUz7UaAF/lirOAckfKOfURa7HqdpmR/v6guPD8oB+Ox1M9C1TjR8f91hfrE7lyCWCIqk037i1Iks4TAL+ScskUOqZXhlKckZ0ohLEQBqT4l26dbhMORuDPWgRKKBtHWHfO48r5okq8jdkmPQY+c9qAgEOCZ1hPdXF17L0vHapSeeLeUvx7uzXC/VstmR2CxJgkBqRketMG1GUvEiSUJM83z8jImTdwlMbi25PN2Ha4Lud5J4ZCy6U2QksNT4e8AgpoRFuPyw03Ve1FdE2JR0n9bfcUW8lL3Vlxx2TVjPjk7GVigyCMhIef8oavROJ6e/WdAeU9Q+i273bTZAojYY/eQS447hxlgq62C9qfUL4ytGEf8LAj35GgSGvJ4iGpsSjFYgwgOqeOp+AbQH0GwaqBpNkraQrRI0QcBNduXHZBalLEdtVVTaOUCbwh1q5DH49Q5r1xC+Le70De+6hyzNiAN28J1/f0NBDhR3AyNXiSqgj5NZr7mKEGyGFl4ZDDt+9E+TAfkuA2jW3xfWgN4brWZn8WttU0JXQg/SEfmMlN89i53Jf3SL2XRiwWoaeRQNRUeamTKCY+GRfkXWwHNuOxJ9HbMnI4WTerSEo7HC+nrT3nVdHu8sQOcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Os1Ot10U7VNQNO45RBqo62vdhYzwUFIoD6M0p7XhRqCe3n3MRXX7gACjOz+9fhcfD7M+swrTowetX0M7xtI9+cSpsiqd/dyEJbqdPNSFaqlp09iwT2DPfPH5MV+kvdlGyQhbZQJ+7uhvXn7tTAOc52e1+dbIwT/4oH4b31c/Xx4Sl8MGDnseX6GjEscTdUWy4/y3MmphPbfG1kR3PWe5x65uH6uj4r/w/7Gy6PsjApbJri55wHo2MHsJsez4oaurKbxy3s27fxWHSxg6Wn8QxAbAM8LQi+HoWAIXPoDa0/faGQVp28YcZUhyfX3AEmEr88aRUVmeVIIwx07n35DHzrA1HcmtZirBAn9kVpE0OUKeqZhUPcOgpt3hL6qCUKL9anEZ2V+6jD638YlQRTwe1Pnv2ZQrdBGa5rE2y7UFgIy9FT6+OuOWxZZG4RXbe9mK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:01:42.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf7c748-dfc0-4351-7482-08dedbaa2a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Barrier state layout has non-zero fields above the signal count.
Mask these off to restore the correct signal count.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Tishko Araz <tishko.araz@amd.com>
Cc: Max Erenberg <max.erenberg@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 150 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |   2 +-
 2 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 54fa76f374c9..42e4a5773ad6 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3929,7 +3929,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00030000, 0x807d847d,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7d, 0xbfa2ffe9,
-	0xbfa0014c, 0xbef4007e,
+	0xbfa0014d, 0xbef4007e,
 	0x8b75ff7f, 0x0000ffff,
 	0xbef1007f, 0xb8f20742,
 	0x84729972, 0x8b6eff7f,
@@ -4070,36 +4070,36 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xb96ef812, 0xf4601bbb,
 	0xf8000030, 0xbf8a0000,
 	0xb96ef813, 0x8b6eff7f,
-	0x04000000, 0xbfa1000b,
+	0x04000000, 0xbfa1000c,
 	0xf4601bbb, 0xf8000038,
 	0xbf8a0000, 0xbf0d806e,
-	0xbfa10006, 0x856e906e,
-	0x8b6e6e6e, 0xbfa10003,
-	0xbe804ec1, 0x816ec16e,
-	0xbfa0fffb, 0xbefd006f,
-	0xbefe0070, 0xbeff0071,
-	0xb97b2011, 0x857b867b,
-	0xb97b0191, 0x857b827b,
-	0xb97bba11, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
-	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0x806eff6e,
-	0x00000240, 0x806e746e,
-	0x826f8075, 0xf4605c37,
-	0xf8000010, 0xf4605d37,
-	0xf8000020, 0xf4601e77,
-	0xf8000034, 0xbf8a0000,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0x936eff77, 0x0002001a,
-	0xb96ef81a, 0xb97af804,
+	0xbfa10007, 0x936eff6e,
+	0x00070010, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb97b2011,
+	0x857b867b, 0xb97b0191,
+	0x857b827b, 0xb97bba11,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0x806eff6e, 0x00000240,
+	0x806e746e, 0x826f8075,
+	0xf4605c37, 0xf8000010,
+	0xf4605d37, 0xf8000020,
+	0xf4601e77, 0xf8000034,
+	0xbf8a0000, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0x936eff77,
+	0x0002001a, 0xb96ef81a,
+	0xb97af804, 0xbe804ec2,
+	0xbf94fffe, 0xbe804a6c,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbe804ec2,
-	0xbf94fffe, 0xbfb10000,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
@@ -5066,7 +5066,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x018c0000, 0x00030000,
 	0x807d847d, 0x8070ff70,
 	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffe9, 0xbfa00184,
+	0xbfa2ffe9, 0xbfa00187,
 	0xbef4007e, 0x8b75ff7f,
 	0x01ffffff, 0xbef1007f,
 	0xb8f20742, 0x84729972,
@@ -5208,64 +5208,66 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xf4601bbb, 0xf8000030,
 	0xbf8a0000, 0xb96ef813,
 	0x8b6eff7f, 0x04000000,
-	0xbfa10022, 0xf4601bbb,
+	0xbfa10024, 0xf4601bbb,
 	0xf8000038, 0xbf8a0000,
-	0xbf0d806e, 0xbfa1001d,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804ec1,
-	0x816ec16e, 0xbfa0fffb,
-	0xbef800ff, 0x00000080,
-	0xbefd0081, 0xf4601bbb,
-	0xf0000000, 0xbfc70000,
-	0x80788478, 0x937eff6e,
-	0x00070004, 0x847e907e,
-	0x8c7d7e7d, 0xbe80517d,
-	0x917dff7d, 0x007f0000,
-	0x856e906e, 0x8b6e6e6e,
+	0xbf0d806e, 0xbfa1001f,
+	0x936eff6e, 0x00070010,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec1, 0x816ec16e,
+	0xbfa0fffb, 0xbef800ff,
+	0x00000080, 0xbefd0081,
+	0xf4601bbb, 0xf0000000,
+	0xbfc70000, 0x80788478,
+	0x937eff6e, 0x00070004,
+	0x847e907e, 0x8c7d7e7d,
+	0xbe80517d, 0x917dff7d,
+	0x007f0000, 0x936eff6e,
+	0x00070010, 0x8b6e6e6e,
 	0xbfa10003, 0xbe804e7d,
 	0x816ec16e, 0xbfa0fffb,
 	0x807d817d, 0xbf08907d,
-	0xbfa1ffec, 0xf4601bbb,
+	0xbfa1ffeb, 0xf4601bbb,
 	0xf800003c, 0xbfc70000,
-	0xbf0d806e, 0xbfa1000c,
+	0xbf0d806e, 0xbfa1000d,
 	0xbf0d9a7f, 0xbfa10002,
 	0xbf068180, 0xbe804fc4,
-	0xbf94fffc, 0xbfa10006,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804ec3,
-	0x816ec16e, 0xbfa0fffb,
-	0xf4601bbb, 0xf8000040,
-	0xbfc70000, 0xb96ef81a,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0xb979f822,
-	0xb97b2011, 0x857b867b,
-	0xb97b0191, 0x857b827b,
-	0xb97bba11, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
-	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0x806eff6e,
-	0x000001c0, 0x806e746e,
-	0x826f8075, 0xf4605c37,
-	0xf8000010, 0xf4605d37,
-	0xf8000020, 0xf4601e77,
-	0xf8000034, 0xbf8a0000,
-	0x856e9677, 0xb96e04a1,
-	0x856e9577, 0xb96e0421,
-	0x856e8e77, 0xb96e3021,
-	0x8b6dff6d, 0x01ffffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0xb97af804, 0xb8eef802,
-	0xbf0c8b6e, 0xbfa20003,
-	0xbe804fc2, 0xbf94fffe,
-	0xbfa10001, 0xbe804ec4,
-	0xbf94fffc, 0x857a897a,
-	0xb97a0244, 0xbe804a6c,
+	0xbf94fffc, 0xbfa10007,
+	0x936eff6e, 0x00070010,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec3, 0x816ec16e,
+	0xbfa0fffb, 0xf4601bbb,
+	0xf8000040, 0xbfc70000,
+	0xb96ef81a, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0xb979f822, 0xb97b2011,
+	0x857b867b, 0xb97b0191,
+	0x857b827b, 0xb97bba11,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0x806eff6e, 0x000001c0,
+	0x806e746e, 0x826f8075,
+	0xf4605c37, 0xf8000010,
+	0xf4605d37, 0xf8000020,
+	0xf4601e77, 0xf8000034,
+	0xbf8a0000, 0x856e9677,
+	0xb96e04a1, 0x856e9577,
+	0xb96e0421, 0x856e8e77,
+	0xb96e3021, 0x8b6dff6d,
+	0x01ffffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb97af804,
 	0xb8eef802, 0xbf0c8b6e,
 	0xbfa20003, 0xbe804fc2,
 	0xbf94fffe, 0xbfa10001,
 	0xbe804ec4, 0xbf94fffc,
-	0xbfb10000, 0xbf9f0000,
+	0x857a897a, 0xb97a0244,
+	0xbe804a6c, 0xb8eef802,
+	0xbf0c8b6e, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 456db8199899..0da98cbc4c30 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -1387,7 +1387,7 @@ end
 
 function restore_barrier_signal_count(barrier_id)
 	// extract the saved signal count from s_restore_tmp
-	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
+	s_bfe_u32	s_restore_tmp, s_restore_tmp, (BARRIER_STATE_SIGNAL_OFFSET | (BARRIER_STATE_SIGNAL_SIZE << 0x10))
 
 	// We need to call s_barrier_signal repeatedly to restore the signal count
 	// of the group/cluster barrier. The member count is already initialized.
-- 
2.34.1

