Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29375C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7BF10EE7A;
	Fri,  8 Jul 2022 22:56:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB4310EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBubLT64h0pM5pWCOxkkAMEVKUGeJaFzDvqsTYo6uqTz7IFRO1BPvfhDnLDpTLbOz/WihPHnRU+bfcja3dgH2I0baEJXCQsg9b2Y9Ecw9q1Yzd49bYJ/nQvCvH3Wgd5OLElBNp3ajk4Ra7jD4JQiF2u97JXG9HdDbrIcNrYfUOt1DHfYRmMsuqI2AO4YYZ4GLiFp8TWRxgENJi5BckKLzJFs7ry/4yh+How9M4O7Cx1b+HMjZSvFVPYN6GDlaPoZ4jbjZPd3/K17sEdUX7eqaFprVzE9VKAmDy8WPm+I+Yr2gUmneMbKnTUXlxltxEo/9giMmGUXan9bSOzM+00stw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGb9nFKfeHOkFwRft0CNpck9IDNxEj+EFied+nygZpA=;
 b=M+l3wEOWvh9MXgHrC18LCxditPAWLVWIXIVqBa6bzRo2UjGFnEdjUMH7F+oHXdJow496z07WSbec7y7zXabO16Mt6V+fYUFCZB57WwFMgU2GSvgOuK3JNWISIfCvKAmc5cWL6IxKhkv7cBom1NZ7mOahwrhuwTzB3zH0jkqDP6yScmt9qv+3xKhN1krnCoUgqYMoPaI1LTVya+YSv1Cgbc4K+OfXyC4Jgawoj5lNtB8MQURCr+/MfVOlXSE2bMAS8h7hS1fgSlZ3hXvNm2POWiDga7xBWKseveB/bxfo71XiVKjIlUgepW4AjeG995sEQKtVBMd8kEqDek6LOvbqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGb9nFKfeHOkFwRft0CNpck9IDNxEj+EFied+nygZpA=;
 b=KRdvJ2bMBNdsC4MlhujHcGJl0Y6JyReE9ju02QZU1yjQiCx3WRW4brrupQs/4LdJeiry0LH7eMysl7B/1CGk9s21a0xHUwe2F/iH4FrTdGuKd0+jgrwWQ7R45Roq9kZfXRFFU0RiwCO1nQsGl4136j9liGpcKibYWzFXvG1ItGc=
Received: from DS7PR03CA0308.namprd03.prod.outlook.com (2603:10b6:8:2b::31) by
 MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 22:56:03 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::46) by DS7PR03CA0308.outlook.office365.com
 (2603:10b6:8:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 8 Jul 2022 22:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:56:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:56:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: bump driver version for IP discovery info in
 HW INFO
Date: Fri, 8 Jul 2022 18:55:49 -0400
Message-ID: <20220708225549.2061140-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708225549.2061140-1-alexander.deucher@amd.com>
References: <20220708225549.2061140-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c38315f5-3762-46ee-5cd2-08da61350887
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6b2IVpquYN8bpgpT/Ig4g0o3o6XIqJJ6jcTgwUyBJ7T3azL86sHkx1R7OGTbISNxcw6QSAYkBZKcL4WTMzNIllI/Nns3s8KIcNiRkolmRwl1HM29wNn2189LroyPsE6I16JXqJSNcznvlEJucI+7cb2YlJq8bd82h3Sx3lqOk2dQ7JY1hUBK8pyDe2CQkoGgcePvbCinKezEYts37ESXKruT+nPEqHfnTstFsfWgE2CuVBF6RT1FUyjosTrwatZMdAyHrY98a5yrrwXvwF87fE0hiejdpZpAYmFndAmsPD381cw45zwLMo/FqIrDE/xEdVfmBscp5RdmFh6qjPveeVWS5VQN7VhMSIK0oH8gKtOgGDNUSCCedDZik8HzlRJH5s3yChcATaToToK5ZJ4H17uGQieyV3pRJjPRNIq290CrdfZrs+grJuCdf08ZShRGZz74ii72SM5eGXOej6kN/Sg3mUpkuPPZ1sT5LodFIF5beoFd7Kbf+WhC3mdbLDr4ZdVV1BGcSxxsBn6BQaUUBD50mGEBULvNl4LCBnG0i7tyiNVuhUsEYAgdo0LZUZoMAKFyf0XLxymckYwugj3j8PYmHquta6P5vyJ+oeorSxKpbz1u8YUiAy8xcBiwnh9xj6aRjx4EwGTLRvMesOvHUZIRd8rI79EbJqEF0o+vRuAKRrNG2ela08n+SSbH8Su88obN+G2eHbXM9k7vIjoxt2Y0TOTHDUrPsqumQJz1/i+kDLLFJ6syYUGIGYLmpxKHVMtPhRWU8LcjLtrleBbcdT0xtPIGQ7vqfuIVE/QSKWJn0cE1cU9RDyktf8fBIQs5IkT0ldUebnrwdWmRX93qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(70586007)(356005)(8936002)(81166007)(82740400003)(6916009)(316002)(86362001)(478600001)(70206006)(966005)(8676002)(4326008)(26005)(336012)(426003)(2616005)(83380400001)(47076005)(16526019)(1076003)(186003)(6666004)(40460700003)(7696005)(41300700001)(34020700004)(82310400005)(2906002)(40480700001)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:56:02.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38315f5-3762-46ee-5cd2-08da61350887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So userspace knows when it is available.

Proposed mesa patch:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/17411/diffs?commit_id=c8a63590dfd0d64e6e6a634dcfed993f135dd075

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d6a5d0f424da..c716cea0675a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -100,10 +100,11 @@
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
  * - 3.45.0 - Add context ioctl stable pstate interface
  * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
- * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
+ * - 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
+ * - 3.48.0 - Add IP discovery version info to HW INFO
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	47
+#define KMS_DRIVER_MINOR	48
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.35.3

