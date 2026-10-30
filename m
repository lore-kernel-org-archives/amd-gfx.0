Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E654606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yhDYbp1X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21ABA112649;
	Fri, 30 Oct 2026 06:31:29 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69437112642
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAzaXAIi5VImdHtr/OXvAQsqYScXAfPGpz/RMArDojtkNKBa3ot/blbiIjhJyU6GOqGsIpPO2mT5k3G1BWjCjr+WLX/MzH88R6QV2nzKqiwjn/aaDvla3Nlj35kABI016a3dc9D3c4IlN6zWMcNV439Mh4nqTFDqDP8j59X/KyPEcSfKuqNpSCncf6Rb3ACoVDi/wjPXYx71TvNN4yvrJoFEjX+2+kDDjHwCdhxa6BahNgteiWpf58qx/LNRKVxkPqGNlRM9nl+ORHim8DnogukW/I3Y+suLShvL2KQfXgdVrggDp5qRI6+yzqiQmL1QOdEnBrWQqfzQGz9tvHLNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWLYQkfDL9eeGYgk1Ogf5m4WpZS2ciuwEbgkZC/KudM=;
 b=cL+jvUx5beUpG2WZRfpbKlm5g1w34oNpvZgpdABPix3nTKMnMQ5W21/ACS/R1nTMOHTc2x+lloJIumg9CMCwgIllXaJWBYxwziwpKtYXgLBUa9RVSvfWT4bDxhzl9j9n2nmDSuoAm8fdAOo3U4xHUhvo4Fnxsfnh02IAwZZttkN5NFPCXSiPDgzSbIR7Hu878yHtJfS+yJWar06StWFrEsOrTMrOl9z9y572ArGj4+PjMkQcz+QS3r1saiVh11+c5OzwfdoGjIAD0wSpUm/0ceYwT0rSPShugW8AnyIITeAWBZe4OYCfyX0okGSJbe+2gOnkEVsdUfmbj1s4L7gAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWLYQkfDL9eeGYgk1Ogf5m4WpZS2ciuwEbgkZC/KudM=;
 b=yhDYbp1XNihRa0n6CaLnSJCUBGNnZ6Mw+Je1+45JdzbSCZHX6b83hAvXP78CDYENZVGr+n3jLS7qycHRdtqXLVCnMjuQLtohiiE1CqWQzmDEVgnS0zirfInYRSmXghkbFb59DRon8vWnZAhc6kZj19jhb1jTJO7O61wcMPv821I=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:31:16 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::58) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:15 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:13 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 07/13] drm/amdgpu/gfx12: set mqd->perfcount from
 mqd_prop
Date: Fri, 30 Oct 2026 14:31:35 +0800
Message-ID: <20261030063141.2773032-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: fc32f65a-11b0-43a7-fb91-08df364f665e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qKR7wXfW394Bew5/XqJP8rZrIY42f097h8gwNRzZpAmYc7nJzzGCng0ZZumOeM2iWxd5QFEfbpqaVpHsgdsAL7EVoulWkW99CiMoENXi8dSfSeRK0Ao3Jrni69U5kxm6rUT0C+MqOfi16Tmj/9NS6eXCU1bB8Oeqd/KVboEdNVKuSXQSXm9U5TBOhU7mk5DX50KXhHS5tgfbiXjgeb1WM9bFiO+y322jBDgMNA+kQSpiqTCGk05JRnbGeKsfHCRuqQMaxHbaC0IejqinY6mWrbQrnXvbQsKEKqBY+LkK46+xSiYBcciLm85haKNLxZHFHtteqhANq0GsEk+Fu56oOOTmOlIiYO1zeqvQ6xXyaVedGN1NWNDoxUv0Y+gzpavGY5VA8M00yvSiOCiptQmaPNrp9MpLjerMJXZrD4RlJsOJBhv6yer1lEYr9sCVbKcjsU9bbmpjdvf6L8y+dZsLQYO7DeW56kTQIeNhy/gt9aqRe6EWDRF1ktut4PsAJ7FGlM8GkTggR0ZNurT+mz39RmFCcyYPklcDyFYYhWjg4O+H2ydIE1B+6MHOMNa2+dCsdAkCQJMG+fhP6tHmsASe/12YIfcxc9+u9nhsWANxuvZDNXA+wcuBJO7VRPIsSJMM79fiNxNee6C5YI9agmzm+/LgiarCk644wG+Tg+CKuv0b/1t9FWPiglSfTUhYWzuo0ZnZbTdL6hrn+9SPpHBurA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4h6Zr6EtSXgU/JLeaq078/xyJYxLaOljPqOth68+Wn9tNz7ZfkfvcMX2uu8MVajAlxSuiHu91qp9aRUBHbZwlRfW95H4Mp8Jk/2ClVrhTojqXVAff7962Kw948PR+mtpRuMvW7ezYugttl5b3zTTJc8E/ypXPtjxtaoyCpwUYrAro5Ol42fFcRAWSoS3l32DnYSklHy7TzIAEYKh1Q+cj4/VgWfw1sHSIU3On0TtN49sggLELs8EPinbNmq+NLmVGe0SQqQdWNod/VLM9aAcPFT9LkJSEukzmpj+FyP8swSl7KEqtfFMtZKXvXbRoJUBL3xXqRWCA5uKkouGJc8o2nIdLzAudyzX5BJ/SOPy9zRcIEsjlFAbQ1BsAExkg8+BTrGWARbev38Vsurbn4V2uo9GtzGGu3lVu9H/AWzAPoZmwZWYAUFJZc6C7w1+Kcqe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:15.6899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc32f65a-11b0-43a7-fb91-08df364f665e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

This commit sets GFX12 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 398e9c463ec6..655b1784860d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3163,6 +3163,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

