Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53823C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1601D60F4A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1601D60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFDD6E52A;
	Thu, 26 Aug 2021 07:13:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587286E52A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIPFXGJhIJQVrps/5q9ekXbWFYJyBITt3PnfwfwB465DLNYgxWHTjia6YMIY8Q1G9a+2P9nFXY+y+2z0W5O6pIqsr0NKsfts3s+1pmGDGnYISJ0HnANS5uY9ISkJCWJ5HHwAvt0c3K51xWrSBTuGbu8SW4v7Vtcrj++GgDBaa90Yc7AQafY8AmwruMozV4TCjK5V/ByfPqY849Y71KiYMOhaypcQwhsA3E2RunbWZP/csBZcj54g55v0ChfbhM3xz1mmN/2jlFJVI5FRjsMUqsEQBtZw0XyNoJm2Jgx4uGuekQvlNl+VHNtsqrr3HKj42KmPNgOR6EL7QQjd3YdfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6EyIvo40uVJMLqEc9OJZbmRn6wMrwYyczfAgH4LMtU=;
 b=IYBPHTe+CRfeOu9vZDeZMfB9D2r+Hx89qGF59B3Bp9rZScKcaquEre2cPKd1qRQUOa4OkKIY6nYLIo4bWYJqD6jwRuZcyEYdhqmXrkgwbSV+cN0J7dmn0kts1eCmIaOGKeuQx0sr5mXY0gcvRtootd35daDn/y0y/Aevd0eebJ+QzyHl8BgEH+REINol23NUnfb1r87ka5A0wLegbgDX8Ae3TeocyrpOkU/tTuM6hw6binrVbmgkByROP1e9MFDlFZnLpy0788kULQxPI1FSdzuHTzoJxZeeKcyfsaEZj+eYPLW8x2Yy0f0EQJAcfS4cRHhvZKk3DC5wd3gF6isUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6EyIvo40uVJMLqEc9OJZbmRn6wMrwYyczfAgH4LMtU=;
 b=obOjEgla13obC9+9K4mXyWw7mpQzXvxVDRR1+T9g3fLbb5EldrKBGLWTkQAGijhuqAnx4gOuZiv8WH5xCJ0gnUKXAuhUsV7O8z0LQtxRqcKn0aZvmS5DsHKgDfmNjaCfNOPsTa1/XM9bR4ta9Sgcg/e94LzVbjoDYm8kpVVQBB4=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 26 Aug
 2021 07:13:31 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::a6) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 07:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:13:30 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:13:22 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/vce:set vce ring priority level
Date: Thu, 26 Aug 2021 12:43:03 +0530
Message-ID: <20210826071307.136010-1-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef8754a6-dadb-4a87-ba0c-08d968610204
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-Microsoft-Antispam-PRVS: <BL1PR12MB536289B53CB0C79A45D30066F5C79@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llLXjSoT8+LensvgJKF27EzUawaHIvShsjEYkSqf51n8ZhBTngf99pHvn3lwCIDxbyJu9S10hc2YFzRWvLJP/dmlpPHGgPgKXkjJ42DwJQ/wMYWawaLeOipiqKOxgZquy9g+GLZXHwxFUnE1BBEtygd+QolOClZgbCqwMFQKWILjgxnKA2nJjY9YeZLSxo/8AcmhycYcZLLzqs0DbqpqfVT0Vj14gMeXf8NOtbVX6rvrCUpiZY8pLbMSLvrYepsvMd09gCinSgTCAWUi5ZHP9gMzmf6Bza7MaioOaP7KoZltxJVgAWMnuaqXGdvAxxJWdkj5SVqpYJsWGe6XqXbVg5ZG6Qw7dXaj2LNtC26S6zo4kxxmHWEQqHp2C+BvKfaV5mwjit7Zg8MID+Aks82wJNCreX83sRovkwQPsrQhJjfxqPTqOMzP7fa+6kS/fF2rkA0NuqKIS96kZ491+Dp8gz4MI4etMmgc6CnaV2EX8P3PQ/BU2OAYNmDDF0MGUlL6XDmCDnFyg+m6T0kl6tgdGOxCdMoO5TpPe+2zJChNIND1ak/kJMNOl92apIKh0qmT2pt+4fIavnz0XLC2bpGzzpcKgU5xH2tKSPQIxNEhYE3kcfxSWONg9kb9Y8bPXenep56+PlrVT90GheyL6+DpqdCfuW7+fMQEKg9aw3Ncg7gWzD8glsQPKyrM+1tYti49w+28nIBrmXZdWvilMre01Ye4EtMp+oQ+uk1QpBNst8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(36756003)(8676002)(16526019)(316002)(26005)(2616005)(70206006)(82740400003)(2906002)(5660300002)(6916009)(1076003)(70586007)(478600001)(86362001)(4326008)(47076005)(81166007)(356005)(336012)(54906003)(8936002)(7696005)(426003)(36860700001)(82310400003)(44832011)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:13:30.2967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8754a6-dadb-4a87-ba0c-08d968610204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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

There are multiple rings available in VCE. Map each ring
to different priority.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1ae7f824adc7..b68411caeac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
+
+enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index)
+{
+	switch(index) {
+	case AMDGPU_VCE_GENERAL_PURPOSE:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	case AMDGPU_VCE_LOW_LATENCY:
+		return AMDGPU_VCE_ENC_PRIO_HIGH;
+	case AMDGPU_VCE_REALTIME:
+		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index d6d83a3ec803..60525887e9e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -32,6 +32,19 @@
 
 #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
 
+enum vce_enc_ring_priority {
+	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCE_ENC_PRIO_HIGH,
+	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCE_ENC_PRIO_MAX
+};
+
+enum vce_enc_ring_type {
+	AMDGPU_VCE_GENERAL_PURPOSE,
+	AMDGPU_VCE_LOW_LATENCY,
+	AMDGPU_VCE_REALTIME
+};
+
 struct amdgpu_vce {
 	struct amdgpu_bo	*vcpu_bo;
 	uint64_t		gpu_addr;
@@ -71,5 +84,6 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
+enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index);
 
 #endif
-- 
2.25.1

