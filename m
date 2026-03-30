Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6111061B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0F110E6D0;
	Mon, 30 Mar 2026 19:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ia++fHYg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60F910E6D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viAfAwQdZ34sN4Fum9+F5H8e6jYpiuYutCnE6xt85pLZM6L6eRDlqUzpEpVz1jeJ3r1zoSJvOwAMqZd37ty7KShxvTBU5jzrAzbamKHd8qKTOuihldMRRu4IoVXXCZ9WOXsg0qmJmwxRkIvrggYTZvNLIEx3aql6p8h679v6xVSfmEbYDz+vVmKKE7YpI+wfW4zplYAVfLE4g1EPZfePP39Lf2HhUz3QVMYjcUleSAxN0DFagIZRag58Ts/a5ZKCrwTIn9q7ftln7QrgUqN6gjXgGk9a9x4XePcAOWPBjW5A/MX+48fctjYkVnDZ0RUIGioh8F/WRdbfpPBXjViM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Hot+6Z5+Nn75kWY7IlHGu8wrgyDTNWiWqWq+c5Nfc=;
 b=MCjD5d8WGUrLOkVVS56pUAVfKOKul3GXrxF3t2jEncAlIex0DOggWOVTOdXzsfddckZUlFAx5d0pG66aMUV8Ag/PdxmsDD4aO08sZiF9Og/8rGJbUxPV8cDhuB7GycH+3XaKZrS1SrV0YQMduB+QKitpOCeGHND3uYvk34ENtfSWaTM1Pw/W0Dux3aYiHbUzCyyfH4I9vXbcgbX9SQj5Q75i9kzVOYeMRc1SRok63uvYjjuJJ0bcXMfAIM8MFfdhSNmtGj7ImuQKAmcJq6LyJh+xkTkXaaOcQMoSJOF0jdivu32z082J4jo9e+5tDFwv1cByym+HoaNyAFxouTdppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7Hot+6Z5+Nn75kWY7IlHGu8wrgyDTNWiWqWq+c5Nfc=;
 b=ia++fHYgAujah618ilPTLOOvqgB3D5KR7F3xGy3yeUMcAs8IjPojnv+iUsvGCz/x3jrwCpJ0T+7O7m/tcKWMg8+K3X0Tl7AVKchCviK1Y9iFGvd57RULw/2n5PW49XpsZYXM/wNtg+LLUrPTKwTCPuorr38d3EvO9nCm77CwUBA=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 19:58:38 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::67) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:58:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 14:58:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 14:58:37 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:36 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v4 4/5] drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
Date: Mon, 30 Mar 2026 15:57:56 -0400
Message-ID: <20260330195757.901509-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330195757.901509-1-benjamin.cheng@amd.com>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa2f761-f326-408b-fcce-08de8e96bbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hwiSoP+J4NRfyM644wvs8Zxyms/WdGss2Vj3IfZiYlJDVSxivXDExPq9UcIDNbrmPz3dedYKbqV5eIP4SokfeB9AAyLa9vss6TChuPazaGWXEspd49W4HCkPM4ytj9cPrdtg9z/vj8s65FaIxpXDzJc3I70A5VIA2sn/VRGzk6VV9Rn5c/tkI89GiYFqA4kNbt2PzuEfi45GZKxDyw8QzkxH6Yi+oc/yVc5TV0Bk6kTcxgfLLgixDhFtDCqgPpNemsYoyd23H+c6v5RSoFojYf1GIO3yguAMfBkb1YoezQe1WbxFHjlSrIsO2POUFlbJnvNTPN9UY0hWiZquS+eZ6ZL/zl4IcQGThawqx9mjm96FU9RMe+dsHbA/92wUoc3G7dQSw525NpNwajowspCUPC2UhtOG1OE8kCBZCPKI5bbtmoxajflpCoxgMyqvv4ySOsoyvHTaksBMyBMzVsXrBWBYTz0Gt93bHyj7njz+2splKEtqf2Z5wUyKwzkkVY88X1ROdW1hNZamUCZWZvZ6wx4pk1LQIz19a8y6O351MHXU/Xpvy8i4VhDzowABoJznVUPslRyv2R7HUtzLBSkAaaK40iAe6NKJMDjIsjqhA6na7TMMXSG+1WOh5/ZBhgtOOGcvvZdJ5vMapW9K3WyWBroMQgCEj3TYUgfmPSJ4Lw4p5feqxDidWH0eJ2q3uazHJsnPApDdNH8yRQ/ei6X6T3/fLAdbRQzBh0LMYEn5gqtmeRfvZqaB5YyGcUoO2bDzOGxlbsJSD6kosWzoeYmIlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4VA0zF14vLf4610BFkR3ef6WtL0RdYF7MJ2vjEgU6nV5KkE9SSwo9A8eQw2zbsaGGCFjRvOTk2VcEfNPAo5h6PbELyPNJ7f38s6c6yEm0dtPZFDw8dUTT55XAAf9CZe1TcYrd1iRN7YF8K5H9Peo/jsEsOdXGmHBBCok9RsQlPLdfY5xBHn+miuBw75I1Ak+sFqshLr3/EFkzQD7vv8MEH7W4NKDAu6wYuNGzUIjnG+hSUV0lYStny3uhn5ySot66WqGwWTbYCiMQFL/c3LXOZYXpKV8XxeaBOQ+LpT4itG86Ko20Fl9lvpWQFPDjqs97cfPD+8qg5372pKtWj7CTAZyaPDKvSA8iJLXVKeYzTnItfiChh/MV72r6hbiG2L45fjttBQTk0uc8goz1rgiOPUfr3O6VjcV3NKIzOJUN6Wt0ZG8s+usNHSccVvx/1iL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:58:37.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa2f761-f326-408b-fcce-08de8e96bbae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d17219be50f3..1a1cdc14841a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1847,6 +1847,11 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1863,8 +1868,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1872,7 +1877,16 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1882,7 +1896,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
-- 
2.53.0

