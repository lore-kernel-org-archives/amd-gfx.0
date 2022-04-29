Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC09C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BDD10F240;
	Fri, 29 Apr 2022 17:47:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E4610F1D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLIJrk8CiA3934wkchzdc0fjIbk2tKb8oBnrSvrSJKASexzqZzxzrh/TJQEKBeQkJay6l9ZPC9FlHlniMcKbMN3zXq90TdkE5tfzFXb6mRgEIR7TVfFmlm1pmpAK1VElOHqlyk5N9UAbNcV67XkIWtPiZNFp5+pGkU24vRHhCGv4psLqRtx+gl9HGcURc8FGsHslvNk9L2PsR6W/1VnZDOJEoXl3fqviJHPQ5qs8iulFtmmREPVCHG1GvC8NhZd13p2+22k8Ea3jX/dLJupODrAEhA/UbkQWZ74unbwt2QfKiyK1h2FhLu1yMJ6Rkq6Qpvp/sMj2bY4XvqhfByLxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poxg6BYhVAb1TJAtYWvYt29L9drhd+zZF9snVzPHfWI=;
 b=V3CFm8DcBbKBirFWlhGeXWOWy6TKY9hVLwM0g7J48TUkSvjsdZt0wmed+JlQplG8Z/2pITdcyePmdqg9PnX3QAJ2IJCWugKQFYwjir+GBlzK2SBuX+RTKaPHI6Zxu4CzV+GwJZaXx6KmxI5Fv3GU96TDOwAmyE6jx5XuU7X2+DVDo1cRQx6CxCu1lTX+e4YhhOab6LKAcX4mVX3VAx7zWVZqGm+aRUoGg2aPz6VpfUspv8hvTa5dRV7qy/1vO8wm4q2wKDevPEPuIzIH+wA/3TUN7Bn/ztJmN6pkRgxBAi2byBtmo8rcLDGJYmau8F+08zLic7fP+ubansTkYEYdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poxg6BYhVAb1TJAtYWvYt29L9drhd+zZF9snVzPHfWI=;
 b=DkToaUdZptF5Oa8+R63b9zUDI8Ps3x6BAF+/dXpzpaZR2fN+qFD9tirjUU2TGrzieuqHy3jBfDN0z50N5lgmkkI631RROaGq1Y/qoAIPcJLKgmPnbGkoaCyhOgavMNVj6NUGkRRkc6eRmcAKOwiVob421gfBLvW95WyZ8xOCTRw=
Received: from DM5PR08CA0037.namprd08.prod.outlook.com (2603:10b6:4:60::26) by
 DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12; Fri, 29 Apr 2022 17:46:45 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::66) by DM5PR08CA0037.outlook.office365.com
 (2603:10b6:4:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/73] drm/amdgpu/gfx10: inherit vmid from mqd
Date: Fri, 29 Apr 2022 13:45:24 -0400
Message-ID: <20220429174624.459475-14-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4933b742-eedb-4cb3-97d8-08da2a083a69
X-MS-TrafficTypeDiagnostic: DM6PR12MB4531:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4531BDA5797C5AA001BFA87DF7FC9@DM6PR12MB4531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhS5KnlbpsH2nWAOu0UpVXOpQpBCJsUpojLdsvSY3Hy1vBGdk2a9C9KVuN7bn2k0rfk3ID40iTSJcyMMLJcbQEO+UbX/u+UE1JGamrLeornmBppKlx+LjG7kj2il8lMPwgvrNLllHUvre5bnmkQBp77u/VSmAzxgPtGVzwsa2UDWSG0DNmPSS1aWGLMh5wD6lVU8EGif6WZjparGnYKxNIypEE3ofH6YixZPI79HTFh9MDWNyPywKpUokC+p98fRjtRfkGFCxtA3J+d5MF6SJPXG1S4gbKDUQlMShlNwNq4PqtH42/mflNnppNpBek/4wzcxVlL/YeyWNcS0WcflBS6NH//fkFLPjpIiAlfscCTvBp3ufHXVha/2sLJQxkGb3IbELCPae8RSjpcc+pA4S+5QehT0MWMcsYA+FlsIgFzNzxe42iYBsyFNm/q6LgYzAN3LgYvmbrsKuPNqP8BcqYXfSlYtpPKbk96JWtl1I/UrpebrC6xkiR9LuHQU3rq6xJ4BV0VzyQNwvVtTDAVaub7f45GUqUpVCsKLU6YKB/+bTUs5Sq8UNg7+AsF/9FPDmhev8wmodJQwlmegLnDF6cAR385RK0TXh3Q/W32kjZznnaAQuwTUwolrPaN3HVjV+LALDuGbgdg+TTtXQVpsk5Gf57MVIADXwl/oXDgTiF7bcf08BWNjGYM9wL6tKdoT2odvGtWfFWJjOLTc08HokQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(508600001)(7696005)(81166007)(26005)(54906003)(36756003)(316002)(6916009)(36860700001)(2616005)(47076005)(426003)(186003)(1076003)(83380400001)(8936002)(336012)(16526019)(2906002)(4326008)(8676002)(82310400005)(70586007)(70206006)(86362001)(40460700003)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:45.3356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4933b742-eedb-4cb3-97d8-08da2a083a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
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

For MES manages vmid assignment, let vmid inherit from mqd instead of
ib packet setting.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e6e601296097..0d91632f563d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8602,6 +8602,10 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
 
+	if (ring->is_mes_queue)
+		/* inherit vmid from mqd */
+		control |= 0x400000;
+
 	amdgpu_ring_write(ring, header);
 	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
@@ -8621,6 +8625,10 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
 
+	if (ring->is_mes_queue)
+		/* inherit vmid from mqd */
+		control |= 0x40000000;
+
 	/* Currently, there is a high possibility to get wave ID mismatch
 	 * between ME and GDS, leading to a hw deadlock, because ME generates
 	 * different wave IDs than the GDS expects. This situation happens
-- 
2.35.1

