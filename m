Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFB606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J4RhGRD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCDD10EC1D;
	Wed, 18 Nov 2026 16:24:45 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862BF10EC1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 16:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIaDacnut8srJY4nNFEMmmA8dKb4n5BvZSClDvFNBXTAax605W72c6UV7EDqiXj4FtYYcptxb8+uUrrcyJKTeeqU8TcJsa6pbCjIa+Ny0ztdinnJoJweKurm6nAaIpW/i4Mep1VvmE5IGXS3EF2zzDqj2mPLXic1g5HniQT/44465MVTw3LkL3QGikLFY61nM/IREULt5n/hiQP/E/3MhbPOwvDUyI3JlfqeELFol91zV0UWXvg940YY/XkEGQo1nqHn5n8gqAwrnn44D5cAd081RjwvCM2dWjIkOXhwXlAOtT0FYVekg84WeRELMYZjRUZLYjsPNHmz+4djzEnv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyk73ervzk1iJSL2P9wOJXsEOFvnFOgDN9TZwep5LVs=;
 b=UwodtOEj3pYlHihGk5huF/7cJ6a/18prAth6j9atwXWCn3PnRXmgSV4FnSlq9z6NPEzoGcHs6+/Y7qSzgnza/zhmI0RUs79m96aEQMp7NzbakvBzWpJWRXRBogbKMRQ7L6kbXUVD372dIGnIkzrRP/ww/98lhn51nDWHtQ0U5uY6ciZBLEFMwbPPC/6Pl1XRoZwp7g6Dnr1jQ2PJ21kzwdPki7U7WZLAN3oWQv9eDZpSXWVnQp8KSJnDOFirVZOxEL2+XE5lmiMqypM1El/d7XKPw1fHJGcGftIZ7Av2nc+O2JQeMgreK+CeAIuV/c0jqKgvuMfH8vBUNHWaS9kQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyk73ervzk1iJSL2P9wOJXsEOFvnFOgDN9TZwep5LVs=;
 b=J4RhGRD2J72VrXp3cRgaSw6b8LP/pB3qKnaDS/CItzZ1dxB5oZGylzxq6aBRYYza2nOITORRgJtfrxZMnCIr6dcXiFi530Gz9x88+ZwDkNijFV02rlbJMSfCzo0tTF9hIUfBlv9+BGSg0W/IkTkRJm4sijPWjDNPVAestjfP/Dg=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:24:34 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::af) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 16:24:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 16:24:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:33 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:33 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 10:24:33 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v3 3/3] drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the
 caller's partition
Date: Wed, 18 Nov 2026 11:24:26 -0500
Message-ID: <20261118162426.1642532-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118162426.1642532-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261118162426.1642532-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bbfa45-263c-4676-cc15-08df45906e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: yd1CO/9VLCON94sDtE8owG7SLYZMNljcLS97QTEj4uBhRK1ioerKadXR3JQpBWS6SSAbkV8R5PNW0wI/dwBqUa5CZHwy0svvy9FRkUiQoLhyJIraW2oXN1Cw1LwKo8QUSDqYn75PbH1326S0K34KIDYazupiMAAYz7PksRvpbvX3NmrRRmZ5J4BbUl1VfYAs5+XxlrQWDWoFzk6+gRc0f0Hl4vuiwh8qjetQjtJYMXXcYjjXBxIKh/Xn4icFW07fpqRrfqXCtcxsqAOWwqF+WlEQsQGyMGGZWw5tu8Es5FoUzwQj4WiCJuqyNtQ23deyoOKh1Kjui82e8u8CuK6Sf5sdh5UuXPxX/SZ6BEHbe9jot245FxLQr8ZYqSt5tx4Ylt9zXQTMNeS+4dHw/VI2xV5l/TcbzUitT8qAw0/ufxNYeaM//DY6O0VpAwBB4wKnQkR4eFL8eCYqx0/40kBTkCSBljyS7dktOWLxGWYBEAORyOJaErxyTvphCSXTtoybN62WMHGt9FfZsEdRY3JYk5llUkXDSYbqkj8+SsX2Go4glcCFMK4N2ou918ssO0sySwnqstXt7f/68657NQRixb/ukqxrtTdk0akKVO6e7/VPaJoBjCn6oA1ddBgXlRzHRBaOfqgoC7f0/WSz3Fv2t2w1xGf3ahgxnEtNfnm2tBo7HTGcF9x+Uz6MO84FFm2UC38xAM5Jvsue33oXONd0DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lbaieS+6CH4ETZbWq3jJJgLVduRLslzf2Zdc7QGzlTo9bnUdJ39u5fpDPF5XFmgj8gfHSC70C1iBF+2276YI+xBraVmfELqUHR2cZnqsWQISHsbpiqL+fi4vjN8X05z6sfSGmCQPeTRJZU3eW6yFqr/BdPoRYc4BG3j//YnpcanXpvoZV2d9FqejR840WksKfKeE9NCymFextJO7c4mUcS24411/pLkyzmGtsPDrudDvifSwJEZL5j7QYdDxzIjQ+E2uNPDlZpQvAo6o2T8rUZIiei+MjhQd3f4t8h9thwck0s18oVPB8YLsVqi8zWgf/fyvl/WX93DpZAKCqqtW9FXe7Xg1Afttlj17Xf2uHBvj7YSAW6QAJx0YLfUMdFTZ4H569OMbv+4qz128ubsbTyqj0HpZsfo59PylW2RkglNfDCH0YDegXIT8E2S1nQbS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:24:34.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bbfa45-263c-4676-cc15-08df45906e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

On partitioned devices every partition is exposed as an own render
node and fpriv->xcp_id records which partition a drm file belongs to.
But AMDGPU_VM_OP_RESERVE_VMID reserves the VMID on every GFXHUB of the
device: a reservation made on one partition's render node blocks every
other partition from reserving, and rebinds the VMID's page table base
on XCCs the caller can't even submit to.

Derive the GFXHUB set from the caller's partition instead. The
reservation then only covers the XCCs of the caller's partition, and
each partition can hold the reserved VMID on its own hubs
independently, matching the isolation the render nodes promise.
Unreserve keeps operating on every hub, freeing whatever the VM
actually holds.

Without partitioning, or on the whole-device node, the mask stays the
full set of XCCs and nothing changes.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e81fbe32e3c8..131bafb5530f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3035,6 +3035,20 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		uint32_t gfxhub_mask = amdgpu_gfx_logical_xcc_mask(adev);
 		int r;
 
+		/*
+		 * Scope the reservation to the hardware partition behind the
+		 * caller's render node, so other partitions can hold the
+		 * reserved VMID on their own XCCs independently. The
+		 * partition's inst_mask is logical like the GFXHUB indices.
+		 */
+		if (adev->xcp_mgr && fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) {
+			r = amdgpu_xcp_get_inst_details(
+					&adev->xcp_mgr->xcp[fpriv->xcp_id],
+					AMDGPU_XCP_GFX, &gfxhub_mask);
+			if (r)
+				return r;
+		}
+
 		/*
 		 * The root PD reservation serializes the per-VM reservation
 		 * state and keeps new jobs of this VM from grabbing a freshly
-- 
2.34.1

