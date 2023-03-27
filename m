Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF87FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496BE10E145;
	Mon, 27 Mar 2023 19:36:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1865810E71A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbDDfmgnrnK2t1hPWTQd1PuKel67BZttZNuACTHwaBKOykw0FNunlsBDh6t4vXtyOmJ3ayEutiuHsDXgiTPS+UDsf5yXK4ndWHWh7F+EayyYJAzwVYQ/fM43vulnjxkVkJZBV00HMhgWAe9jGBIZAZC3nYKW+qlqwWN5hN+zF2dCVwtdY77Y1zVRZzFfTsNewtAXqf0y6NgyLXOJTuOrcoteV2rOrNjs9IW2N8jSkQAnalZDoSDH1gBfmiz/gPqA5azSjh1xUq7gQ9Bq+yanD35LSZZqLdKwDqA1JN+oG8cS2xGxhI/LLECLsnXhHZo7kqOl9RGeZwfJz4xoutwLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSicS860YUDTWZ57etFMOV+jS3N67QGMrHEN2pAYB9Y=;
 b=cDnqbuusFX87cLoEVRJbWigLLOHUy8N846x7y5DYXbJwPq3Dbjlc1mJvewuq9oAFUD/hN3h/L3G6g6U6Q0dMlCxj7Gzg4gQV4/ifQ5easRPM4rYlGA4Et9jA94K9Li3OK9BWRxf6762cOYu84zi+ritQG3x8xqXQzq7DPnmoI84N+Nubb86JSLBzVnRdLz9/ZpU2WR2kZBPPK8e7jS2LaF/7q97qqUJZzNHrffihIvSInyLdncyRpRNGs+ga6VZ79pXD/qCXg9HlMPhTO0aNyTF2cIjmH99TxPc5Mmqpr+re1NT1odIp3y2/U1vj/174QWxDlJKJX5sC0X7BQXFdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSicS860YUDTWZ57etFMOV+jS3N67QGMrHEN2pAYB9Y=;
 b=sDX+Bdzs0Vu5QuWbyzAXrs3oY54uJo4ki4LuZmBSfulkUKsCDGT4iJTTqWAsAML+0tyEbIEzmdILWYy8+crtZMmHHmC89yQTOefO+Qsj56KqBjv6t3o848bKQPADK7i4rRPOQqPWsDVcG9tbYOH2ufsthC+aj6mdrvtErdR+l24=
Received: from BN8PR15CA0063.namprd15.prod.outlook.com (2603:10b6:408:80::40)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:22 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::91) by BN8PR15CA0063.outlook.office365.com
 (2603:10b6:408:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/28] drm/amdgpu: separate the mqd_backup for kiq from kcq
Date: Mon, 27 Mar 2023 15:35:39 -0400
Message-ID: <20230327193602.7901-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 28acf16f-2bdc-4581-76da-08db2efa8bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJ0GqFnYujvuYmGcDWmdKhfISOIZEV6uKKnXbnmUinUnbUUfO/g8MrWbIk5rjQeWFvTND7SsASEqb/7RN7LKI26RLHOhoDFVxFdYg7mgcYPNqVPdCE+C+EqHAFlmRUQU78R7cdnItwV/a1sZfrWQ+rOFyxSdypmT1dNY1nSOuIXohTzKsQzcjdZKKUPJR2Rke+QoCSuxozK9tYJRPkAe/0zZsJp4QzJpD6bxDLuRHL6Sb1BHVgMz/fPDsRbf57XveCPPkHvzVsel+A2hFFxiMMjLILTS4NGDer2KYnK0s7ylN1QwD0DzIDfPDBmmfkEAQA20sDa64BR1KvAOy4j0gyLXL9ar1U51sC/u5d6SwzTXxQsxmhMYG+KZfTaySSaiS3rp4rHjBW5fOUanHFCrMM3pGX3jezfy9R6tZF9tcpR/qcShQVUwlsf0Nvpied0y3KOytzVgO1sfKzZX644YYUhf96jEASA4zgLCS/QiJLNPcnKFETJKIMmwmI06HdiVmd4Y+q5eccLqYJGNfDomlnUTzTTvKD/tSTIRiXT8vRaGDpZSjZHO3QE2d+9x8RX+p/J29TdNI/SxCbKP+SUOTb2fKT2MPpaqjo7eScceuGG5yU/X4fNS5dhFodDNcbQ/d5XMiQXUOFCfgSAfKbUJpr3oM6SjwdGzlSONk9h8u4DPCi2Tt7a4woUwvDW6Bg78cZOfS7VgLws/dGbhrVsvmqPDR+ycTvKuCHWUVhZygCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(82310400005)(47076005)(356005)(186003)(478600001)(40480700001)(26005)(86362001)(7696005)(36756003)(1076003)(83380400001)(16526019)(8936002)(70586007)(316002)(5660300002)(36860700001)(70206006)(81166007)(6666004)(336012)(82740400003)(41300700001)(4326008)(8676002)(6916009)(4744005)(426003)(2906002)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:22.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28acf16f-2bdc-4581-76da-08db2efa8bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

This will benifit the mqd indexing for kiq/kcq in multi XCD case.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 830323310694..d811cb038e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -75,7 +75,7 @@ struct amdgpu_mec {
 	u32 num_mec;
 	u32 num_pipe_per_mec;
 	u32 num_queue_per_pipe;
-	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS + 1];
+	void			*mqd_backup[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
 };
 
 struct amdgpu_mec_bitmap {
@@ -122,6 +122,7 @@ struct amdgpu_kiq {
 	struct amdgpu_ring	ring;
 	struct amdgpu_irq_src	irq;
 	const struct kiq_pm4_funcs *pmf;
+	void			*mqd_backup;
 };
 
 /*
-- 
2.39.2

