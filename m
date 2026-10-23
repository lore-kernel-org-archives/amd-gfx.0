Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA1606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ks41Egmg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C4B10E5F2;
	Fri, 23 Oct 2026 09:09:37 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0C2112A59
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgZ/ne8Y0mNQkUYZM7tXfWEVs/E5/mJg38n17YC6pykNCKJMnLDANn13pMELgW20LBdyQxwolSITWpqJvT6XQ81bB90RbA9zEWnRIYjoj2c4i41Lj0Y5slZD138yEC3M/cCSlhlLqHAW6MLoZVh+4E4ECeHGORj3J7IiHLOEbxpKOVy9Z/eTenGzgizXi+nJWyFgs6aBwtIgy+4XwB+0xMhMgSeD3Y4ryY+SfTr+C2E1aQ1PWw5fDKQ8ob2Bo0g1dj9VfIHOkOVDJSm6OoLeBH8aVKlNKVam4O07URpmTfezDPSRIZZuAdSYn7wtlXJCEudaHafbonPkRbGK3VUClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJRtQza7XlFO0/mxyoqOz97tXOvoitrTdwfR11QFC3s=;
 b=rU4JEn2MsYdxcmiwF2cmakZjtpfYrXzz6GQpIegGKBtsOTIoubD5+FexIhBg5c4F4a8s4gN/DoqWBc5syDqSj/rMgYrGgG0bvLp+9pZMDyIgKng8UzO29CEHDVREhznQTlCgYbY4P3z7KOy4+H2HIG2qaubCZCP+B8OQ2YgHVXJeb8Gd1ATTHqo+zAvm19br5lR4xiy8jLiWgAlw/RzrpnYmBQPfXKMXRtSBBD7hiqe9S/pE64d2xBbtitD/02quO8NzT4aoDTVQ3yiBprE9SureTZJ0p7uMjMC8EgF2OfCzDDJHIOtb/1wbnleuvHLhfyzlxPc5yq/BsD7CkQNdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJRtQza7XlFO0/mxyoqOz97tXOvoitrTdwfR11QFC3s=;
 b=Ks41EgmgCwIWke4ZCGtm6icq8Pf1Ye4cLi4xsXxrnn9ODLFrdOAkreMmCYJgNbl510q+Vrni7Kl6WrMpvjX3yx3sGzdCFEMOTecFbWRp2btVCYHyd28/+jdCovsb7jw2zLF45mmzu0TDCWF6pjNAZXTUXMrNm0kiFPkRI0cVUBw=
Received: from MN0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::21)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:08:57 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::5e) by MN0P221CA0027.outlook.office365.com
 (2603:10b6:208:52a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:08:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:57 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:54 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 09/13] drm/amdgpu/gfx11: set pmc_supported for GFX11 family
Date: Fri, 23 Oct 2026 17:08:41 +0800
Message-ID: <20261023090845.670581-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b883fa-dcef-447e-089c-08df30e54533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|261009223027099003|10067099003|261021121427099003|261021123027099003|56012099006|261022075727099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: IMrPx+K/TSqtT599Tgci2FRznH7IK5iTfRwCDw6nWTcaNGNEh+0DpTqUhe6x3FRtnY0oGLXJ4LQCbi6trufWuU8TuqGGg/Mgt5SPOOmHZyjc9SHp9nHORwSqwQM3exZW/vMda1zuZUNG1nQWawRR1RVRQw1DJ14SH0Ls0CJcDBtXInJUK2STjI1aPDwnVftNL6Kqz98+GiHBohlS9SAjbMxPXvbO+7JcDiEKljTfClu8Jz1Ye77Yj2w8MORU1xDUWbPlj3bQ20OtTURRcVo60QMBurKaMnNmuYF05r43tX/sD9opBDwVxfeLem6VDhKjgJwdKTvW2N64pDq5Og0BbSssB/+6jtIucMvm6zT9q+93+sUHwoXX2baSG8EIYJhDa+IEZuGiZ1OoOjaGXlXdNHFCypsVrynGLFPk63IDgXpf/33jjonMi9bsNFSCIVYbp//4V3s7cZDkQXTODY65p4LKnGmzr6G0WsKj7+MHyMqqccrsixdsrsoTChiFZoxaqT1Y32tvEBg0RhhKAhOuc1fdp+KJsLQ5Kf19lGD7rTLNeDFw0ZPI+HaGsATxoBbtUNap/V1aXQvnYLTL5JwStrT0v1xhjkBIJoibRp06lDsYhulU+571GfTB38VRA/WQmw3An+TMhBd9VnDPkwttRAqFmEl7CA/ORMClJRvLKl8HEWGFe1t+cW+JoqsOddhH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(56012099006)(261022075727099003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bWO46Px8kDpGoQNErzWGnSQilPC0WYxsPLoTKWtRoDz1u+G3eaMziMsfFKv3ZtP2yTONtscEBlQerJJvag01FW4heM1j5pBwGZCn3ZsuM34HmBjIaroiqfncbZ0Q/9sVZrrXkt1ILpUFy5B54gnz9oG6wwijRavU0mHlQUONayICI3C9b1ZkZS7QQckEkWfc5wXwe+cPDFu93u8lHr2yP4Pba64blOzKaOTGd0ihV16H+OlZ0IIKqsYlbxCZQ2aBBnxGqPcKdPdkMESBdfOV9WK78OkDcyTE9RNUI+KIzmVhHlOdl0jLmgpwWQGbE4HWKQdFApyv7+d0h6xE5QsfRYpNQmgKYl6GfV6V7FXUf74z+kyXlSnD4hu6DWypMhOMNI82h+W7KVGQZjgSohJ/6MlsSru1qIT52z08futCNrxA/laKdhIyx60f/1qYS552
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:57.6173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b883fa-dcef-447e-089c-08df30e54533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some GFX11 models are capable of user queues and have
mqd->compute_perfcount_enable, therefore they
support PMC.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e5ff9005d204..87875dbb6432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1652,6 +1652,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    adev->mes.fw_version[0] >= 120) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+			adev->pmc_profiler.supported = true;
 		}
 		break;
 	case IP_VERSION(11, 0, 1):
@@ -1664,6 +1665,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+			adev->pmc_profiler.supported = true;
 		}
 		break;
 	default:
-- 
2.53.0

