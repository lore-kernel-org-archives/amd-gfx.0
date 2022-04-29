Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD825C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1267910F43B;
	Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DA810F2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1qEZ6FrrLKwyuTY1PNZjwuhqEKepQwK3HcBjS+RjUygM4Zi8RUiPfh3eEJ4ClKFKkd+N3iMTxT51TSyAEr/lKURxsIpBxwE0FZXi4vamQql40BW83hnvHscihyMY2ZUvQZdMtCGZcuSjBqNSUyjpZyGFqWVr0H59K557j2VDCwRpTAHOjBPz21voeg39VNkEs20cawcAj3mTJ1lu/1cS0HOf2ks/y+I+hC5HBi3EjU7U89mEg7GM0PJz1Oq7dvFkng5w6vEZcL7tu+G6AUFefHpp9laDg/PkaTdUDSoHRadN+Ykw/LpEm/ZULuCmL1BoDDMao6OlxQvInWBGh++1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kZhOw6/YFi66sPVYAGOKd7vXYNajdWRy9kq0RRmoJU=;
 b=ZiBJy1zm0w4+vfoOFms95wrezqUjqpyU9apUePgEmj0mEbDpdGMTRp6lqFcj5BbF+XLqDSiLZe0U3uoswsTDJSq9XjYDyTbGEItWapZ7laVOJlp+/WayT+KGqN8/AOqRvEN78ZI+RgR2m1aSqFk0FT7Snrga84Wgj7mAJCh1cENHwDNe0bi6uiwod9smJws4kjlV5QyV5NkI0Ys6bQJth5mDHA2JMg7JcLAzGNy/BjH4FaijS93iZiX/Lf/jnULEvhwt84CJqwNH9YVCax+CA8DDb3DtGuhUzHUA6zqJxWKX7XNhOah37NqQ5pYA3dsI0VCzeP0UBKOM8qQa7LY5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kZhOw6/YFi66sPVYAGOKd7vXYNajdWRy9kq0RRmoJU=;
 b=1VBfIPEuZY4rQpjbxKkZTsizJBigUAqkgU3PxfOnNOLffzTYIrmwVnjwkoalmtN0enXqkdWc+Y+IQP2xIg3qbFLAzGXJUkBvHXWGodR0Std3O7cHsbm1olLp0M0hiDSfLCv8vCu02Swj2QIen/B1QnI4dYvfkFEWWdmGBqXvD1g=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by BN6PR12MB1828.namprd12.prod.outlook.com (2603:10b6:404:108::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:47:04 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3b) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 43/73] drm/amdgpu/mes10.1: call general mes initialization
Date: Fri, 29 Apr 2022 13:45:54 -0400
Message-ID: <20220429174624.459475-44-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94fe4dcf-c9c5-4ca7-0b61-08da2a08459b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1828:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18284415BC27DEE3AE9E6BA2F7FC9@BN6PR12MB1828.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTM+RgiAHmsbTbCJi7vGSZO2S5i3FjhJAfI5cC4ovN4mSfnfEeBr1gYcCbMgHcEOrm8bzer8LfMZBnK6hpe9XbchEjhM74qZFnNhM6h1ppfiDyaWyqjlUccnOTA5Iin3q1219VsOeuKr+uKEbvEpGt0hHO4UPR+z/SM+KgjJ+uPniNu+NPovJ/JqxzCXs1RvrAhuhetmA1yTSivaHmZHsXlkXJzvpC6w3DIMkmpyGATiX7K+Jr4w2mqvwDuETSuhSJXnkVRh3jtaSwTn+/VncQ3z+p2ZRTJbpn2wbGKIBZPYBh5xYwE0n0DxzoMCZ8vrk2PVLtMfdYvfAK0LPQm457u7tA0HyvHOUIeXB29pYkZT73nU/cj016UI8zH5afw/mRVh9p77wAVQbZGVK4b9iy1fQd8OPUXDb5Ohs2bG7MyMCByjBWxZB5cI4NuMnG07swtMdZVMw+mBASNSjkUfRnre92JTtTYyC3tqmd+eFN5CBR7OHc39wafslgam6PHPpwGqRQUlEwvrc+aYxEuSOcQMVmqlSAzU1yM+E8qdvqUqcNcJhAzBNIhGn2Mlwt8y1erpUuUr0yr4fAAUlK37u4yDzXFZv5aV4k/jsT3ofiddsVUBFUjn/4vpy9JU44UNdLR2Vn6atasca1xWHYR/40J2CeKtU1RSGDe93/m8ajcq+ca/vor/1BuBCPzVAmMnED8m9rPfmvsUlbR7ZR++6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(6666004)(7696005)(5660300002)(26005)(8936002)(356005)(81166007)(426003)(1076003)(2616005)(186003)(16526019)(47076005)(336012)(36756003)(6916009)(316002)(82310400005)(4326008)(2906002)(54906003)(70206006)(70586007)(36860700001)(8676002)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:04.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe4dcf-c9c5-4ca7-0b61-08da2a08459b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
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

Call general mes initialization/finalization.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index d77242e0360e..94812164998a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -935,6 +935,10 @@ static int mes_v10_1_sw_init(void *handle)
 	adev->mes.funcs = &mes_v10_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v10_1_kiq_hw_init;
 
+	r = amdgpu_mes_init(adev);
+	if (r)
+		return r;
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
@@ -994,6 +998,7 @@ static int mes_v10_1_sw_fini(void *handle)
 	amdgpu_ring_fini(&adev->gfx.kiq.ring);
 	amdgpu_ring_fini(&adev->mes.ring);
 
+	amdgpu_mes_fini(adev);
 	return 0;
 }
 
-- 
2.35.1

