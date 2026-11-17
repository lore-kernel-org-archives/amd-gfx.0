Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C69606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Yo4P7CEb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A506010F5BD;
	Tue, 17 Nov 2026 11:13:51 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0989F10F600
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 11:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0ZKCbfVWnH5iacoS3En972fGi+dwyMrsgPwjOmwsNelFgLmpjzxDl2gAFpTPZwh03IHnOJmlfvUMFA3bpTOBLpLgNtU3TOJErfJyx9spM8YgZ8eyLhSvH1Qc//l3xNTTFpSk9BthQI56vxjNzGiKLG5v++Kb75HiPU1bJd2DWoRmmOuU6iAykgXnBEAe+OFhCT2GQoLU6ThEbwFUDnDiCe1IoG/bZxCYzwuBvhGlCV8aTMIZUyUjlaQXlELXx84FKPq69fCWU5jawNOrE7GseZlTJ/ZXaQzz+bER3o6VysnMEohwWfDqFr9Kr3KIwsiXG9IOZnKo4TJXwHLbN1OIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyy3FSkRhObDt4TfDrPcU47obT56pRprU8KtLp5Zbwc=;
 b=YSXeI1vT9jL3BPKcCYeybwYeJkS76zVjfFN32T3N3TYwyQ2SPbhe7Niot6diyaIhqBf78I8N3lgQBqkCopsulybVW30Yo+ZUlOLvcLr7P2F6gQKT7AClU1RMx1f6kw/snp2TfIybQZX0K1MSDhkoGDDCUpTJYsCOEVHi/ir5iHanAKqcMICHvKmGN1+j6ffBeOC0/d8QTKZMcb17+vMVSvwwTDGkV0xC6oDRT+DbmLMa9jc4T+mkiLOasYPpoOiB5PgtUozKCSJnXuaWlGWCH5ocj8BEK4xzbXY6pyt2haCMJ1ntXhjzVE+649JCg2TTz0QMicMcAn7YydnhVK3+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyy3FSkRhObDt4TfDrPcU47obT56pRprU8KtLp5Zbwc=;
 b=Yo4P7CEbsLdaSHeXAt0MkeC2PfOb5hReddE5CLOc9W514J1Su8rcYQUUxcQEhRpvJkhJvn3AiWGKlx2IXLubNEjPJ7esZy2eWTPcuK8yc9HrKK1mXwbRI3E6cto9P2E16pk1w8yH0HBKBBZ9NrShUFUUmzyKbyHj4ixDnYzOgHk=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 11:13:40 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::85) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 11:13:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 11:13:38 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 05:13:37 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: post the ASIC after the reset done at init time
Date: Tue, 17 Nov 2026 19:13:10 +0800
Message-ID: <20261117111310.3042190-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 905cb1d6-c1cd-47ff-bbc7-08df449bd4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|261026121527099003|18002099003|11063799006|10067099003|56012099006|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0wyNMNcdVENtfJTcpy7+74DMP47gslfp7oLJ7+GCnv862HpDpY+JsnmpJ5r45Bvhtey9My7Ratu0BP6H8QdcEVgnbIkgQt0zZlyANJmiwcxKMHNWp1F1kCUGanq5VsF2jY9l0xsjpmVQvU6pMZ2B2PrptItIb8MVMSjCvzOXvHPvSaftBiR2XZE7lfwm/dKFnNWBWabeHxYvxWwy4azSct0tyFkDvKR0K5kpLX8pKShyk1jG9oUNri2mfYPQk9OsxO0Fl0H3TuVwJbWrP8uyn2eLXkxL23FXO+D94Bswp5T/PdM3r6C6YUweDQRhqhl8EsI5LXo/BJtXMWzr8bnVkTGecNpWFeIHfOwJCf78J8KCHYdGTGB8zf8fSisABAc8eSqtEOVkAPQ0j1dkP9QlVlrELZjWIztunXkcl0FVxtsBk0jfZKpvFT2bm0inubYeiQSRZy+CcNiqB9kujjP4SHjXw6QKklO74fzciprj1IDbdVCOiNA/8IN9AnqO0zjZFoGFAZr052JHsSO1dWbtA80PwNCZnoM0J2XFaig/wioBsNDGP8HMlCn+jANAzIuG2pIMbByiuI3oA1Cz2IEuX/LkzchFDiaw6UlUxbi/zPk/yUJKaQdZLdNLZP/UgZlTQ/zI1813AlYFlMuDydgGtQqSUvThMogHO9R/lv7zud6N5gZAAijLX71A1F9ugOC1qZvS9CP2zJr3iVX/C2APXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(261026121527099003)(18002099003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SrKjSXmoIyyZVm0qXr3mI0H9fpWdEtF3TkSO4dJET79dkPK0gYOC47MIxX3zYimwEtgw3pRw2yeEMYN39NhxIAK6k69Gmf7qIzyPcgrZf7Im8KRAdnv4Ina8kjVZveDA0Md3iPNVte+udb3Zck1XzSoMbodtc39Ta9l/ZvOGZ1tAwYpledig0gIIiJtVWYsiy0+ZiedlmJO+w7NL8u3uxlSra/033JGOAQKfofp26jwe8YBygH8jB6BRKf3mlnGxAOiGn8VKvh6cJwvp1cKcRaSV1txeXFUZ2rhzXXg7FXYaY+JdfK5Utzy4xb1hEJfSNqMVERZp+rFx35CIA61g8cAk/+gpILYwjTxJCFnhDBDOaM9/OmQUsTkfOtBEiRUDYPn0bc2aCEuVD0bV3yibkuK/6RIpKczmE+3JNczrPE23+IMR3jXKhYfyqX5jdcac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:13:38.9403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905cb1d6-c1cd-47ff-bbc7-08df449bd4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

When the driver is reloaded, amdgpu_device_init() resets the ASIC but
does not post it again, because BIOS scratch register 7 still reports
ATOM_S7_ASIC_INIT_COMPLETE after the reset.  psp_sw_init() can then
read the PSP runtime database before the PSP is ready.  SCPM is
detected as disabled and the PPTable upload fails with "Failed to
transfer pptable to SMC!".

how to fix:
Set has_hw_reset after a successful reset on init, so that
amdgpu_device_need_post() returns true and amdgpu_device_asic_init()
is called.  The ASIC init returns only after the PSP is ready, so the
PSP runtime database is valid when it is read.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9fbe1c75897a..b4b149e1ad00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4105,6 +4105,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				amdgpu_reset_method = AMD_RESET_METHOD_NONE;
 				r = amdgpu_asic_reset(adev);
 				amdgpu_reset_method = tmp;
+				/* Post again so that the PSP is ready before it is used */
+				if (!r)
+					adev->has_hw_reset = true;
 		}
 
 		if (r) {
-- 
2.48.1

