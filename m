Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD076606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rLZooKoY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4511123E8;
	Thu, 22 Oct 2026 08:21:10 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE001123E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOSxE2scTE++1KntMX/h8RglPex4v1VjS10O06ewf1atTx3X7OXEt61rPV0Pd3GAv+q2hpOLfu8ldWv8UCAJhE5ea8YXJPSJGB7ShtzbbmsKV7n/zNCXta8ZU4F0yw0Z7jI+sXcfNkUhu9gGBHM1srA2pmJRERuDsnCXuks4kx9C8BtdGhodXoO12dCooksBIS1JRmvFrnfjulL50cag9ic2I881BK3KNU0w6F/hP0ksgHaBWiR0oCfagunqQj1Yw5dVvIKs970SOugG2oiybD4dfc4ERmuKaC6jHPu9R+DpqE7/0PtLCqNjblPomUYWJ1d9+nttwXSOq4SLKSPfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhrgUu61y7yZ1xRpCO5ScgTBQmQW7mno7ZnysOMbzsM=;
 b=r2PH/H92Pj0Ss+3dOcHIKnQj52YQf5WttHuSth/5CHRPZQJROu8wL2vMfGp6UTV2DmHbPWB9WIUjQE+G6/ufEBCfdTeSw8hUB0b4a2bxOtUHoNynd71e3fKJ15jaFQMl2hGGhp7UhMnhUG+XnXmdWLjAuUufC1jEeeDmAFXHOftG9u9c5J53RiyObBIOLvMLMVVQKBOhUfaM7uRJh3o04A96MpGOFgNs6O96lZobtp5OKr06/u9HsDoGPsVaio5SmbdVurw7uUYo2IljqL1ofZNe0J/baccMlurIbMFswUm3dkPB6lH+plkPwKCCa9nnZ0Kqx1UQKmQFBg4l0cUsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhrgUu61y7yZ1xRpCO5ScgTBQmQW7mno7ZnysOMbzsM=;
 b=rLZooKoYiiavh7fxAaNKsvasOsrJnhQzho6LpQDCcEBzJjvR2ZQW2XKZ9e/nS+B5x98kIw+eEeHF8C2OvWs+F+Qt/eBLrFQqxsWNrtisA4w+tx7VEnWzvQESWurqz0aVhyfXGTsABZB9WZLbSxIZLb0F148MV7btnokEvMEjsVA=
Received: from BN1PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:e1::20)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:58 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::42) by BN1PR12CA0015.outlook.office365.com
 (2603:10b6:408:e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:44 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:42 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 12/15] drm/amdgpu: show the engine reset in the reset masks
Date: Thu, 22 Oct 2026 16:19:52 +0800
Message-ID: <20261022082011.331462-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 38196869-7840-4604-2d0a-08df301566b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|22082099003|18002099003|261021121427099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: AJ6dZhxQhJj5PsoOmiiZ1ziXlW32u5IO181jf3Z7rSxNhxIBNobLKLs6NRnYeeMBlcUCFJlcteaV7eExratL6Jc+pa0JmV+J34YuBmBFge1JqNkt/uSvOqVr/OfM7B7YZiFUieMed4wK9w75NxAf4kipmoMk5RnW4nlu88teVl/0W8xEbZ7EwS+Ho3aUl9yPD+T67x9rF33MBafQavUbMyMj+/qmg/vpFNOeAoHyU5g/lbgyJPpYgWZwH0sVPgUHOlz9KXW2Iu2tQ1/eOkX2/VU9tdI4Ziaz+e7HXpWqvMQsK3lrUllXeneUU+lJ42ElrbCTQ7awQ3a7xW6z5GudpyE/bZNPDu60+m1cgJdcxQBc+N0qqhL5GStH+eAlE+PgQUB+t87qDK1B0/iqb2NEQ2h9zfnUXakr3VCZHk/KR0r2NTtKuCcMjjhYT4O0E+lyg58y+0LXSyb+/lmm4YHG9Cj8pttngOlMDzzLOpS6oxpdusWO8/cwpLLm9bEHeUCYtq0x2PUIi4F4Efrt8ZGVK/l3+tjt6R5k6pS8qN4Zpv5PO5nmpGGSLE3LUh29xE4cEdSY6VFOFfDUEfpZdHrRX8v1O1h7tfSAo3wK3WwEG7N25bZkTN4nvgrG2PoSxcCsxmboNWWEjPwPLrud7NxMU/+8SuU78OwhP8e8Gw4obeAS0TopIvCpY0Do8dXTEEs6i8LmoH4dIWRyUSXvEXt8aA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261021121427099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0cS7vgksVRdyDZtx1sEulrtSuJpOzrRdt5e/NmNVbMHakEKezjLCx2ceie/o4LRgvcch5yFk4wXphRrHlS7zwdT2zo2EUZD0QtTuWIL/qOdCTX0vzpwT54t615xABEAgyFHce3KoCa8cNUOSdFWaaUn2gEDu9QuUQk/VKrNGZAkiNIWKu1cposTUGeecP/+n4ez884/IZV9KR5LYaJb40Mw9zU9Qw3iaftGpl4hR+pg6V71kEMv13/o6+JJC9TY5NRiumx7wacB8nokJjlqB0PIuyJSSRxERZjxq4EvVqRojKFItFS76+VNvCWprV17B29Fev1oVH1jvfoqvTirZF2qMX+tFNxHnTgiK/LntEjQbxFk0TyDNANMnFerczAAgfSPEBt/flQ5/5hamXW1797KSGMqZUXmhrm+3hnIjXtBuBkCQQjs/NHKddqP5NJKx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:58.5202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38196869-7840-4604-2d0a-08df301566b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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

Show AMDGPU_RESET_TYPE_PER_ENGINE as "engine" in the reset mask sysfs
files, eg. gfx_reset_mask.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..a09254a47373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6831,6 +6831,9 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
 	if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
 		size += sysfs_emit_at(buf, size, "pipe ");
 
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_ENGINE)
+		size += sysfs_emit_at(buf, size, "engine ");
+
 	if (supported_reset & AMDGPU_RESET_TYPE_FULL)
 		size += sysfs_emit_at(buf, size, "full ");
 
-- 
2.50.1

