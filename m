Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18CCC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 18:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF4110E3D9;
	Mon,  9 May 2022 18:19:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EEC10E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 18:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV2gOGZB3UEBhU8uXGb8QwyBiEQk7DFUXWHRtaaVK1Qx5vZqEd5kZ7gk7x9tD/6NhA4GeSk6ZiC7txagBWv8BDLCWZIzqukwAm2hT0NdN9wbT5a07AjeoVmwsdOd8rzuywDhgTcha99u2DyxWH7BGin7etLey5U5rMLCIrZRjS2qLp7WMT97ZSN3o/kMcnokwEwtWP1w02F9uMD/JInBq5B0eQ1koFKUqXb4zDJHz2z8FNxLrmEOQEP4s+XoJNnXNJXf0oX0W8K/o6mMzTRDkQ7dsGwYvwGu9Mt8B5B8zsr+wYSxPzSpQo+t8Eken/+M2dXf1IvoeJfgrwTlkKimNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jpZCqKWuxlJO4MO1NQASxWFeM+4GHXUnVVa6TeC8Jg=;
 b=F3e7vzlrkTRQp8TkT7Ei4AEy3ZhOmBD45hA+ElYWpWoghMUp8ej++bPX8wXzEUyE3Ms9oM7L03L3lFg/K/Vz2U1pKWocIwzzLDRRpw+iCZzaK1eJZyqtHmJoIvtcxCURI7mQzMF4rWdxsoQUvyJVQqf2U+/P/CZVchj3zv+AtFQ9VImJVCbWo48qV5mD8coLoLo54mi3O0VRq1hDwxEVqlcj3EqkAeYsAQsy14TdKGz723IKm1UjN2qSy51EgV8Ju3Ern3eIc1z3kz6w1dkDjckBusMQ//uS3YsCj1gt5LqeIw1c9cm7vAAapmE84HYj6lyTat6EnwiFShtHtErPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jpZCqKWuxlJO4MO1NQASxWFeM+4GHXUnVVa6TeC8Jg=;
 b=c6Z+znNG5g6ZVVqNYJJ8PScf2Mso8pa6P7bktqakJpSq0BZSdOgcOnt5jTAdjBeYKhLfydzS5VwLsRgcS9fTJpHOor9beSiZcX9MJHhlx2CbK4+fN0cj/XwZcRuC7NcJ//o/hTntrECQDEnlcNPtlNsKl0IhvZ6YSNdEWBEb4EI=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 18:19:44 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::10) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 18:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 18:19:44 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 13:19:43 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu/vcn: include header for
 vcn_dec_sw_ring_emit_fence
Date: Mon, 9 May 2022 14:19:33 -0400
Message-ID: <20220509181933.17376-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508173008.281673-1-James.Zhu@amd.com>
References: <20220508173008.281673-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 377f6681-dfba-4447-d0ea-08da31e87e43
X-MS-TrafficTypeDiagnostic: DM6PR12MB2604:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26049749D4AAC9897FAF3B8CE4C69@DM6PR12MB2604.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igRi7z32sKY0q3N2wcRpL7aaDD0of8fYrMU3UHdHJQN7AEsn1qmllkvFZltjq8osZWCE6avLpJafKOzuqGDzRlbT9VIvULhDdEXRn2FSBv3oAaxGGd7TopuaL4vm5JUyBMV2VN6Jp8EpwHHZkDqOBQw6p1hYBRTEVEzsogBUgEWAR0pQW4N0ioZTu32LsI6R9DOEm2i39406WuTs4LeQqdhdywflelPU+pPl+0O7CNfPHm0I2LCcAJInoakznveJXrCFHHLhJXmBbDrtlYljSPsAfOElm6+uN6kyo2TSWzyxgpPePntsf5YX+MCQ9kqxVQ8wNlYPDjJ56fqPJUxikDiZy+SVK1tdA36Or4zC6d0qnXbRKN7WlB7u/MqZpoYbglWrxsI2vt9KtIjJ6YDxTfJ9f/7U+4inw+FHRgTIxTClVoubXiv+P8pNkCXOOzMgo1K9gXM3xNfKC9fwT01Dn6vzdcRw9Kq3FAxXYBjzAMgXK7WZ443AESv1E+N7T3uPi6NMjNG/TpGLdKHRfK2V+g2q3nd+yMdfMuyHkp86xQeeK5RZLZgo0JOO1JXqMCbWvmqvZeERrf+o3sYdICxPGB1FDoYPNmzul4g+BLiAeHc+nYNUcjOPPrNrP61QeghnykrqslIM9SZCvdPi5A0mC507XfR7FDQSzWyCju3CfZzK0fSGjA8j+3HPvDjhrQfwmDBHlLEBM9haSRWu0lNeyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(4326008)(8676002)(6666004)(86362001)(70206006)(70586007)(508600001)(36860700001)(426003)(54906003)(6916009)(47076005)(316002)(83380400001)(40460700003)(336012)(1076003)(16526019)(186003)(7696005)(81166007)(26005)(2616005)(5660300002)(4744005)(36756003)(82310400005)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 18:19:44.6268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377f6681-dfba-4447-d0ea-08da31e87e43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
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
Cc: pmenzel@molgen.mpg.de, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'.

v2: regenerate patch after git rebase.
v3: update commit message.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index f4f97f0f5c64..1ceda3d0cd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "vcn_sw_ring.h"
 
 void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	u64 seq, uint32_t flags)
-- 
2.25.1

