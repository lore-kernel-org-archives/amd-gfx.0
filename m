Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E193C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 10:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759258A96B;
	Mon, 25 Jul 2022 10:32:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C7C2BE50
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 10:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMIza5fXOyMPcUm3UMRGLjlcyUVlzi3HGwPb/SS7qa0CuBqEOFQ51p2V7iN4rRCqdwKK+BGm46JK/e2asN7+B/Rp5p6ui5hrdk2+ZNs9p4MOfcFJVjyf8j8Hj/aRR+9XlOwVVx4TLU6M/rBBezDMcABGkcgVs/lMKR44EI0FL81WNc+pnB0a9tWv3POblO7Ia1Y4VACuVWQAyi9BzQe6/xjdmVLUkfIMEtJnbMIHAZEHxDHo7mzQtZ1LyHaaiyjRcHs8mc9FTaAcK3EyClmJKGxOmjs3mpNv9rtj9ideIt50q6x5IJNN/uKwlDJ4QGhQcOVRi9mxe58FA/gOr7+uZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzG/31S76YSHl+/txf0gXs653GyxkJahZhF7dkeSvLE=;
 b=GnP+BhAXEX4i5Bjv0p4ngTirbOYejLbWzLRG7K0v/RAVFnEn8kfmqLI9Spj0ErOJ0yQ9p91LNu2iw7yyayf9PCNuRbWAZo2g4ATyylK9/h1zZCvBV7y61qAIxKpHrpb5xL2+G/MNlNENdl6DkrZ1DUmzOWH3Z/GIDzsMMSfmuNKeiPeZmT8U4d8fxbEaP29yRAMFKYb8GW/HLU+dJXbsl83Nf1tUuPEIDpCNFQTDEsBtg6a4mr1UsMk7cZqYvOadru+KcoyqC+Ign+emOVtw56CyFqshzWM4NEhTnirdxYUPL4DWsToId3MoRrf4mHcvXDJUTqi5OOh+0VQrofQssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzG/31S76YSHl+/txf0gXs653GyxkJahZhF7dkeSvLE=;
 b=DlIJayvRHkQ8BHrhxUHIK+yebcaBZYEj6ZHwftXa9MdsMKDiz7k5NtBTu1O4wtUt2g1ry4kZ2Lyk8kfAJxNEBuTSDgS1WrVvaRijFeiwijXyJlGFV2afuEZu7ZQgO8DKuOAb7fNCgMcZZ+tio1OxlzgCSizWXu1w0WTQpW30Q5A=
Received: from MW4PR03CA0159.namprd03.prod.outlook.com (2603:10b6:303:8d::14)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 10:32:25 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::9f) by MW4PR03CA0159.outlook.office365.com
 (2603:10b6:303:8d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Mon, 25 Jul 2022 10:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 10:32:24 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 05:32:22 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: remove an unnecessary amdgpu_bo_ref
Date: Mon, 25 Jul 2022 18:32:05 +0800
Message-ID: <20220725103205.2085630-3-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725103205.2085630-1-Lang.Yu@amd.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f751817-2794-4050-7b30-08da6e28f733
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfCuPUWLbErjIknxo+DlBrcpogTGjVFyEmv3887xq+oLLOIF7P4UDDwTs1vvcz1m6h6+ARjum/o1M9bGqTmRPP/Y9mjnCZ6A3FsLzNas2esiWYv04ontm8QhRFCfKJ6fVgNUxBeaNy7iz5fNvlroY6hyNL8FM0x2RmjsNj7I6BsUOscRt0JTUjN3xLExWw8LxOcam88CFFGo9kIpQ3g+VdulRdcK10KDweypTlh2mEYNV0fwXYm0OiBPqqTq3vlUn4d5C87R4ixzWejxmjQOjLNQoht5WZT+pTb+uKFoOyXKkP97NiP4VEj/lBoCyFNi6Y8IkzhZu1FgNRAkoNawzpUSeO88e9O2oPyYtl69H0nCOmRG9flNQSZKtpnbrAqu81U8RFPgknRVP3E+5queXso9vvwgYkmVtcHaXfqkjlxCKO4pAgo5r3KxrgbDBATlFGnF5Gm7gW0NO8bmuBYFFLcH/1WtfiYiKghCX+3CLWVzQgsMaqfPp7HNJoBkUsjQZrBFEdbyqeyxoGZIsIVBBk+X02g0sswVsZjBh6Lzw1owLi3zSvR52uYO2r+pVTEehkj/6iP5ALegbHGvhN3OBRczihxIDwjg+mz4Qzx3IO/+ByjNasfXabK5BzZA1cxXqjAHTjYpwwydXM3n37UWMdM74Hza3g8RAZtMARlwz5wSiInZm1DYImCkZjAMrzuykj6BG5+pDV9dwYYBB+JEnevVyuDXQY7CrNGJ7Q2C4+ycSceS5VB6hO4VtOJdYvDS8aF298hKM5KEMo+Lsfo8nGHrTehxoaJ6oMjhK0dIOEbRd8nyICClCOB+9APg+Fj8Dz7E1NsqG7e+vlirpdxmpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(40470700004)(6916009)(54906003)(316002)(40480700001)(41300700001)(478600001)(40460700003)(6666004)(2906002)(82310400005)(70206006)(4326008)(70586007)(8676002)(5660300002)(4744005)(36860700001)(86362001)(356005)(82740400003)(83380400001)(81166007)(16526019)(186003)(2616005)(1076003)(7696005)(36756003)(26005)(336012)(426003)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:32:24.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f751817-2794-4050-7b30-08da6e28f733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to reference the BO here, dmabuf framework will handle that.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c1855b72a3f0..802c762108b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -827,7 +827,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 
 	*bo = gem_to_amdgpu_bo(gobj);
 	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
-	(*bo)->parent = amdgpu_bo_ref(mem->bo);
 
 	return 0;
 }
-- 
2.25.1

