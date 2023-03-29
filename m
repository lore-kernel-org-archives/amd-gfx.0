Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD74C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C1910EB34;
	Wed, 29 Mar 2023 15:25:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A9A10EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnP3fgGoEGMPf594vNc4rXxNlTHcYLxKPXEq2SPB1ctb2zYVVfMIrQ4/fV8s/vUtjVFo21kQ6q/KqOV2Rh2/zCismHx9dXk8T74V/HYR2LIepLU2UHKraSvXlVJKlrsUpFr0pk1YGlmB4FBPXDvfrV+WDouS9AJ5BbQ5lSnS01Ki/GTARt54A4TKlcipK6tbMVWCNGaeSb8fVAjsmBUfDt0xuiK1EbFuBA/Eo4nNmS71tCjZwAGSDoAORip4UXLy6P7tQPTyO4pgciphVakb/HWHBxjkymr8JaeeSYY/wEzCnO63C0QDAg6rXxX7PDi/Ls3pW5FU/O6LeIPKdpObNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9/dR1qaQO4/hzI2/AIO67tYl7ti92uDQs4tgM2OQMI=;
 b=R+qy0ZzYFjcIxGHdZa7qEI894jf4L1ITYgFFoqMM25PDzAcrqBRKv4vAyKCr1ZF9Et5Xb+mi+0SLbm3PmbHmJml0lxg9ze6Kj+gTJX6/m505wMkCayA972vOyAQp9TkM5QqlNUqIXYXjcpZkdLb3fCePUWyrBaoPepNEFIR9PgX3aGhEC+ghQ+eutVaurpxbJ3IWIXlrhskroXWmmv8ugTzDi4dysJ+NI36rdUvjhMes19tVVNeKOjzLehd0ZcTxwYl+zH+stvGcDLf6p9V7zvCevUpL4KEhaWaBiwWrAzvI3IWx3mXN7Mli5T+Yicl17Tgg+uAnFt306jVacRSFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9/dR1qaQO4/hzI2/AIO67tYl7ti92uDQs4tgM2OQMI=;
 b=0QaGOE0Hrp0BcBGtgg61CbEcZatB8D40osClGDoU9DEboRDFM4854yQdurA1ozoMYKzPxGrATZm3AIQBbTtwGOBRt/IZ8O45+VQ7XHPhSyBweRX71PItkWaSDBlXyfGDjEQNpb6hM3ODrE9NswHdRWlvcxQTw1v89aBkU4oQ+34=
Received: from BL0PR02CA0138.namprd02.prod.outlook.com (2603:10b6:208:35::43)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 15:25:36 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::9d) by BL0PR02CA0138.outlook.office365.com
 (2603:10b6:208:35::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
Date: Wed, 29 Mar 2023 11:25:11 -0400
Message-ID: <20230329152521.1980681-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: afd221fa-37a6-4a53-5a83-08db3069d898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHBueAtcqSjBhmSAKKy6Rfz7nii0gIP3u0spfADBJaddRVjgq66+hEvE0weHAoGhw+71wY6umV5gvDClQPjgwsG/3uazFfR6y47NdilF86sjyFC4VXN7020jIq8SxE1ws7PP6ELXFSF8q3l2nKQb9+UCF99S7WjsEwcJS/yw5XwVZc/Q4a3vphFKbsJSFJ810NvfNiB16oK8XKpTxseoQgkHhDPpJlNXbomLVS897DUs2MfcvxRM4KxQ/5lL2QUox+13QISykAGa1AYqs6+T9mYEnFABgdp2hS5HqSxfX25stblQjKfhUg68B50Ot5fhaF3zoYc/Q7rNjyTg0KXYKn+Zh36IRlabVxH0gZxoBlMb5gIM7//QAIKc63KVSoBBIZhc1P8B6xuPUmpPqIkVyaohr6BjGghfkZVOXc2rB6XCo9hUcNSdhO7aSrXrYoAiqGhmTqduikBcfsIgyMp64XTcbQR98bB8c/FDcb5/PyrBLtTsIM1rt7fxOOXA1OVmh5E0hhyxxrAcBBHB7eBoILLJVwA6N92ZxPaHpJ+CSoNeeZYs6oaKG+awoPF11GLiqnyOa48tRWUOafLc6gdEoxu/LWQmnv7M4pcXwSHESv/VVP/ItKSFGmif9QAr5cnB4v3nxYG2WaBr9zfuR8r2JL43ChM56glz2eZdK141t5aqo2gF3cx24uxiY78TXbSy+/qFKwLs4tilFc+pbc40NBYViCb4lRrkQ/COfP01vVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(316002)(36860700001)(54906003)(41300700001)(82740400003)(81166007)(356005)(8676002)(6916009)(4326008)(70206006)(70586007)(16526019)(186003)(1076003)(26005)(426003)(336012)(66574015)(47076005)(2616005)(7696005)(478600001)(6666004)(8936002)(86362001)(82310400005)(36756003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:36.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd221fa-37a6-4a53-5a83-08db3069d898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX11, the UMD needs to allocate some shadow buffers
to be used for preemption.  The UMD allocates the buffers
and passes the GPU virtual address to the kernel since the
kernel will program the packet that specified these
addresses as part of its IB submission frame.

v2: UMD passes shadow init to tell kernel when to initialize
    the shadow

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..3d9474af6566 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
+#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
+
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
+	__u64 shadow_va;
+	__u64 csa_va;
+	__u64 gds_va;
+	__u64 flags;
+};
+
 /*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
-- 
2.39.2

