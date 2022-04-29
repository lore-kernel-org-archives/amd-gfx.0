Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9450010F891;
	Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9C710F89A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODL2lownpjZ0VD9ndUNMY+KUqCF4n1fElAsDYb5UleMckPRCt6ZSrwo8dZjGXA2ZJUw+j2j+v14C4tQqldOO2V2TfzrW7ebls7aGVJzxmT9lpC436M3HoQoWPqfRjqbvcycbTLLtWYXNzOFICaTN//bFx+dd6B8dsVFlO/tMiH/ohyC/9QfxiDp0c4EqO/w9mFxNd7ieYdl2zCBLWGj+Nacz9sXtADD+AeeubMkryX50VX+wKqO5pjqfthyBY/ZitnXoBA4qBWUie8uH8XYBBXt1M7HW/1WfoY/ualk/VUKZlZANIjP/NQpB+dyEimOu/7vxAnib/faei/O8iq5mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIZsyol/M7Y5jq/1s8poR5ibUuqWghTI3+EskTtZg58=;
 b=jvDJWoWMbhNyng5yIZCv0fVEF2mC0hgHeJXVzTaz2Ywt0KVJHhLPZwVkbGWsGMN/sU1gAHRA6AEgowQ82MJoGeUhM0Jry5PWh9tczoFXWjHeLvb5CA33OJVjZG00r96YeONWBE/bsbq+iyS5RSdQLxObkOutsrNa3//1yPjj8Tnfcoh24X3lbO627WVQZNHQmsOxrBlN6yAMONb0743sXF5TWIApKx4WjRdtFMs0CL59sV/Xdu7SZ/y59h5YzQncQvhQpAqWXUzU0JPu2ea8ICN1rnXIrnsndSeQcfMGnlP6zXgo4xWGubR3Gyih0/BSSGfHrbTsgl/27Ot/xQ7hZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIZsyol/M7Y5jq/1s8poR5ibUuqWghTI3+EskTtZg58=;
 b=RoxLiVSqfw+PCqG492HUt7RDMLxdKbNARXdGSIxx4q0Y+nkGT9z1/C8tsR5OKgku/HVeLIffiM07Lm90gPm1VQug/bXb2QRFUQ7NbOPph2BTFthapvB9mEO/6vXn8q1KTw3VFUsdxDmlWKZjtJQuLuGT6uFwwClUP3FEFNVUtgs=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:48 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f6) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/29] drm/amdgpu: fix the fw size for sdma
Date: Fri, 29 Apr 2022 14:02:11 -0400
Message-ID: <20220429180226.536084-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baac5894-67f0-49d0-d82f-08da2a0a7857
X-MS-TrafficTypeDiagnostic: CH2PR12MB4890:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48905B0FBF350CA2C107B4B4F7FC9@CH2PR12MB4890.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeBW+LL9gAgwIJjl2KT/an3CRMkyY1g3zjVvAUQ+YUmoYvJP89IxIscoOx/v9gA4ZhLJUvS7rRG1JO+/+u9h+qzt0MyT0LYydisEoxYT0QOEPJgXyTuExoDuqtvaCBmC7GkDn3I2oCmKQK6ERXAYYyBW7uvutHblEKWl02+AMbiB0RWG3IZQumdMQzBkF4GNuhwpdw+RDTmkYtAh2zI5DrzZPVK9J//IuDCZqYCDsoXWxTL2v8kO290viEJ65vsxd4L66Fl4mK3eKlSzCONBEvdBaErtF0htSKU/UrneDLmkBN51BEEWjp60JQyXV6uy0vn9WjZM4x8Z4PR0XKsMhciJytAc+voaVjmJu6DMyDaJxlqSYXmZQLP5TxKIJXB65oJFO8Kke+BBtUijqx5AEwSQPyhNz33jiAKm8FOXhZJctXf9Jg5M6hQnkx81KJy71v1OXT3GUH1b5WNtV8Fy0bdv66nq4p4h6F7VPW3zxrVtjlVQtDl5T03M+LUVTQXXX0Qw/IZ+vO/d/g6ttomVV9K4MlJBrAf3SqDLa3qEgSA/rZTTg9MW/JsnjbAwMJe/P6qEcCN8Fz2wVpd3Itp/V2WXP3Z27PfEXdE8CfjV0i8PlaZuYjlCwMR7g9XKIVsco/kksnJFVZN2niBZ4VvbDyU087PmCUg6z0EOSBVPLLsU4AyvK0g0PuUp9ihbMOFFgHwNEl/5IntPTSfKv3G8PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(4326008)(6666004)(8676002)(1076003)(336012)(47076005)(2906002)(83380400001)(316002)(70586007)(426003)(26005)(6916009)(186003)(54906003)(36756003)(16526019)(36860700001)(82310400005)(81166007)(2616005)(356005)(508600001)(86362001)(8936002)(40460700003)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:48.1534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baac5894-67f0-49d0-d82f-08da2a0a7857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

For SDMA, if use the total size of SDMA TH0 and TH1 to allocate fw BO
may result to the ucode data overflow when copy ucode to BO as the PAGE
alignment.
IMU have the same issue.
Fix the above issue by alignment the fw size per fw ID.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 5e731db12e17..f8ff9128c15b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -688,12 +688,12 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		switch (ucode->ucode_id) {
 		case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
-			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctx_jt_offset + sdma_hdr->ctx_jt_size);
+			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctx_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(sdma_hdr->header.ucode_array_offset_bytes);
 			break;
 		case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
-			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctl_jt_offset + sdma_hdr->ctl_jt_size);
+			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctl_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(sdma_hdr->ctl_ucode_offset);
 			break;
-- 
2.35.1

