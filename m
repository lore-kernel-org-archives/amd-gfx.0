Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302CFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB12510F6A4;
	Fri, 29 Apr 2022 17:48:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC1910F691
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJRKL4LVEToVrP2bTCtwEFk9AxaWz3g4xqS1aIFvpNiO58rdNmw9AzvI6bMxO9CHuATMZPXaIMxiVsqcbO4sFXrzn5iHTUZqMa5DFbJY7onDbLQmNe1YOQ2wUqatuAAeUWRnLX7K1zbVm21/YC4rIU9oVFPs96Cbvy/cFtwk1GrPOGdWRHcngwwyUbfx2GynOcgtTMMPP3PzsINn41QOZmX6tvuqBvseDwMy0hUMmqhFAZPNPxX02CIwsArM1D+3lL2kljjML8LMWhIEIfnuTsAwqehHpY/gJiCcdJh8gAsc9ARgdZYM+VKsY24EZJDjQ2aA4Wb5VzpwpIoNV3x65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyYT5XvhNinPz266hy7Jdp9fM1dbqrASkEatiN9O6+8=;
 b=EuO0nctGHBoO+LJe3Y69NI+OLN88kDEgFDHlHROLI/gwq2swrnZ07h6z1+EibB7StmBRn1ZtKJVfjeGiOBAGYpWtG9NuDjtHfHwfC2yWOqKlg1bTrvCxQJjGpuKXnzSXVvbKOZuoreWzpXTH+2V+a8ugGaiSHEdEdwV4B5quAS8NRlvnG5eMUU8gdItJrd9AazHRtWuHq9Pg5flazVbj+eNAtrRUZQged3SuBDLTcEgpRI2wv8YI2/Ytc1aIsqCBjaEeiXPDmmEuc1VVUzwKS9CjaR5je81aS+rXpk/FJMCZx5e6AiYMDEIpMbEEQZnetaecJpQe23Opl5smjQ9EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyYT5XvhNinPz266hy7Jdp9fM1dbqrASkEatiN9O6+8=;
 b=ZIzePgLhfMqTiBIgs8YH7qI38whfdFLWF8FUx73RPFayNh2Utjzqa5KrowwXnHoVGssbSqCYCUA6uaF8pYTsB2CZ/OzWV7+TlDQcY7Ijt4+4WKjDlnn+QlhojgVmHsE0Ur1r6okUAojvmFzjdQ3SAM4IzUNcFylE7JDZg8sbitI=
Received: from DM5PR21CA0023.namprd21.prod.outlook.com (2603:10b6:3:ac::33) by
 MN2PR12MB3359.namprd12.prod.outlook.com (2603:10b6:208:cc::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Fri, 29 Apr 2022 17:47:13 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::f2) by DM5PR21CA0023.outlook.office365.com
 (2603:10b6:3:ac::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 58/73] drm/amdgpu/mes: implement removing mes ring
Date: Fri, 29 Apr 2022 13:46:09 -0400
Message-ID: <20220429174624.459475-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b782eb0-818e-4aa6-0f05-08da2a084b25
X-MS-TrafficTypeDiagnostic: MN2PR12MB3359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33594A46B389AEA3E379DB5CF7FC9@MN2PR12MB3359.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4R+oKz87mQyQCvGFQz5G17diE+Tt0+35q5rb7qCTaWc2r5Z8atw/9Y6Kwqh+H9FLP8Nr7Aeh1P9OZ1Cxp7fSFEBRr3HvtF4Zf0M23oCSiRkNub8k5NXq7NTpvJhBXBQsNjyinRsSePA/JKBf2CQ271JGTmtnbxH5bQZB34fKbqPUYLwBOj4UMDj7ikLn7SDr6izoEvShppf6xOcGQx/0IlJnqXexWbtqv7LNXZ5dUQfrRadRzPs+9WEfUp/rjUjr9qa9W6GPRK7cYT5rprqO0ZKls0NKbq/9keUe6EIEBh0CrxaVrZs4vRUrIlNA87y2HNlUOveJD66B1/gSK86izqI2eiFwjSM+EFDnwC9nYLkBi/Jyg7A7WYs1Nc1pWoWrOpD+gVG4J08IYAVbFMNypwyGSB/rG4/3KfDj1GbaHceYDFuBiEi4EJG54WQsq9pmm7jullPP3+LgxnP41VqKpCkKAub5NDd6FTTAwMpxkkUTtdAyykqoTk7DHYDC/omzU5HebSdUJBDfaet1ZNGxDhXK1mCPJ/T8Rm0iRCik2/NEmP8lpDig++VfHmeMI+s6KPdZMzBamkp/AjGAEtdIXUwnesias2YTppWZTLp9gfpENKVC0v+Xn7eKAoRReW4zgPBvS6bnb4ABmcl8cvMwgnha0PLuFyVRdbsI9BmErppL3Pb8NaGmAW+E5arDg5KcgLykUUIm7m2CQHBKNFGNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(186003)(36860700001)(1076003)(356005)(2616005)(426003)(336012)(86362001)(16526019)(81166007)(47076005)(70206006)(70586007)(8676002)(4326008)(5660300002)(54906003)(36756003)(83380400001)(316002)(7696005)(8936002)(508600001)(82310400005)(2906002)(26005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:13.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b782eb0-818e-4aa6-0f05-08da2a084b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Remove the mes ring and its resources.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 827391fcb2a3..fa43a7e3c9ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -846,3 +846,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	mutex_unlock(&adev->mes.mutex);
 	return r;
 }
+
+void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
+			    struct amdgpu_ring *ring)
+{
+	if (!ring)
+		return;
+
+	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	amdgpu_ring_fini(ring);
+	kfree(ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 1fe5c869f37e..37232b396b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -258,5 +258,7 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
 			struct amdgpu_mes_ctx_data *ctx_data,
 			struct amdgpu_ring **out);
+void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
+			    struct amdgpu_ring *ring);
 
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

