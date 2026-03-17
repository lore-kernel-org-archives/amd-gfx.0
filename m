Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F270AFD875A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7462510E257;
	Tue, 17 Mar 2026 12:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9SlqqAO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AB010E351
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvz1ocF++lfeVPbl6HZrU1sgH4GssKlA5f/m/GLCYn2MAHTj44d6YwFIC/GCpHO04Uf05ertB4U2o+u445PI1EE6kVqzUoO9QhXpUGLsy4J62ZenqlTMfplIxR9usrebwWi9Dxdn+3EpzAyVUn0hmB8rQPVjPTrWNt/lsgcFpzzn7rfMWhVRDlLyFkFQymGHHo8CcbcT2rWLWpUK+BbNOAXKCmbbKre/GZtiQB4TtT4IpzLzMjBedpzy9m/HfYkphpX3XwiFs6uofuimc1ZpmPBSQWemOJRfyQ5/Dq1hCxHCt8XWYL4AhvrdQPA0nvWVns2mFa/LGeXFAk/2gXPtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMLdQP1LEIQ0NNiFXvMQDzUPeJMmjehFcj6kSMTWUzo=;
 b=caPWuSgnJLrNZcwnZN7u1OLCTK8alT6TTYbA7u4fNummtJHRjpufU6J2aR9/KuFwkKvKdRS2NovHOT5LgCySd22GLagrNkN+iWL7UXwEIQSnVYAbUrPwvmNRhzcqKk8PhzokZ7jSAhTY2s1DK5fMEehe0JvFD59cDZJ6iacvLQWfWixGNhS/sEDH2o0ANJz9Y3rrIGLjX0WHgwJrIvYSa4dBd1uiDhZjosQpjdL3izCxSd47H/py+VeI34/3JvY94d9bMIyVKCVS2y5QX8k3qyK5enrhVOucdNy+u9k0fkZjuK2VBm+XhRBBmkkQPjEGBcNkX6TYwhaQntpMiO1oNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMLdQP1LEIQ0NNiFXvMQDzUPeJMmjehFcj6kSMTWUzo=;
 b=V9SlqqAOHimEQOxb074iDFVCeM7QeU/DpEzgO+l6HWLyBSvooHgn6sGA4ktBib44Ae1WMlUwI5py9ryGbWfgP5J4CELt6bT2qkg0AM5XDp9mMdGNGNz/+OctZQ1m7hLzdk7+tq7oT+rv3IQ1gW3T7wptq7aRt4rv9rxsT29eeW8=
Received: from PH8P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::12)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:25:53 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::d3) by PH8P223CA0006.outlook.office365.com
 (2603:10b6:510:2db::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 12:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:25:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:25:50 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add client id helpers to mmhub
Date: Tue, 17 Mar 2026 17:55:25 +0530
Message-ID: <20260317122529.361748-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ea1e55-ba07-4f33-fc9f-08de84205476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3bh3uKN0HNB3M4x/eGi1Dk3X2eql/ITUWwLeu/O0AlBHFS/c4le89WglVW+tHHrN5+ySvUeJkuo6YYwfjBObAT8zsknb7Xagzgtmw3uQFxAn8Kb5TxTkNEOqn0iuZtZ+MbnLEIPLqM1UBBT2UclPH4615OeNDVJ6mpf6ZXcC0+dNhtwltWM141PqrBNyqrRo45Wtb8SmmJqBw3rHY9JPO2TVppvb0COz0ztj3mtkNcDNig8Nrozww8SqkMZJGf72qwrxpD4bf05YTBHDDyckuBYUce1pUXVfsaVthXBs9+Feho2152oNsxUofpM/HuGeTT+UYRNgORs4kEE+rHjwW1fU/9UKzRe8az8ZbAri9GZKawl0rP9qlMhmxja/Okr5WhZs6C/T278XQzj2QL1p2AE4LBJFTqwWbr2Q2XyfFyhhfvMfEoMdO6xldlz/73E+vxd4T4BMmPJ30w3TFWogQ3FqOeyE0R3tU64Fo5eF91unSLyREP4+8o33zvRXPbnque6NTKU7xviIZZP7XPUTxHRuQmi1It1nhICKRXshfu9AdZewiqBPc/8eCg5Hq6cynFJjQ3U0sJqLIaMFt/RYn/uFEtDZjNER2E7mC/Iurt+98leACknNYFecQUb7kaMVMqCcm+MV/7xizkp9IxwkcVef8mxrw3oEpaUHMfsa7ueiGeuAL1oCIIXZV8XinjxZnRc82rAP5lhSvM+X6BjK8w8OntYb98I2YC3AYlHj3dNFgkmPjdqOMVBYk0ZnqNiGMJfyPSRyoQec2jPv1ljw9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8jI0F8MJ5JiiRpJGSYdAXZEefLVbb4gzygb/591vNAJwMOp5CJynF9upRg8s42fYgBDREVp6m3KVqH560xAmKond2n9rHUIOlg2D8Si0ljwERp9Rkw4gqB2RT2MzUroso+hd59hzRqWaUN9HKrnAXATSn0xztGdNFzCbPcR4po95426pV4pQsg1OtG8MrJlpnVHtYOBCBcScHnnXXijeSvTi09Tmb0s51nAZwEnckXi47jVaP+EhUNEjs51/YM8Wj4CFKkHPhiYCwFr9wG/Ei+ie07yDDpfVp5S48V4sNtTxkddBRPw+hdQLuZOmPEvD9ZK5/W6CV70TAqzXJynYMS9rRkzTSvzyisRmM2SGDB3QmXxuPVEPIsosH7bPabM2CcN5kiQsPqQmy3ygcRaFWqY8ksIkQpUhtJ3e6iAwR6C/u2kdjRL7Y0M4UrI80H/P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:25:52.3658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ea1e55-ba07-4f33-fc9f-08de84205476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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

Add data structure and helpers to get client id data of mmhub.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 92918101a95d..6b8214650e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -66,12 +66,37 @@ struct amdgpu_mmhub_funcs {
 	int (*get_xgmi_info)(struct amdgpu_device *adev);
 };
 
+struct amdgpu_mmhub_client_ids {
+	const char * const (*names)[2];
+	unsigned int size;
+};
+
 struct amdgpu_mmhub {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_mmhub_funcs *funcs;
 	struct amdgpu_mmhub_ras  *ras;
+	struct amdgpu_mmhub_client_ids client_ids;
 };
 
+static inline void
+amdgpu_mmhub_init_client_info(struct amdgpu_mmhub *mmhub,
+			      const char * const (*names)[2],
+			      unsigned int size)
+{
+	mmhub->client_ids.names = names;
+	mmhub->client_ids.size = size;
+}
+
+static inline const char *
+amdgpu_mmhub_client_name(struct amdgpu_mmhub *mmhub,
+			  u32 cid, bool is_write)
+{
+	if (cid < mmhub->client_ids.size)
+		return mmhub->client_ids.names[cid][is_write];
+
+	return NULL;
+}
+
 int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.49.0

