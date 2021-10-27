Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6564560F9B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6564560F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74BB6E8A1;
	Wed, 27 Oct 2021 14:26:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A236E8A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dee9OiLg8XaknA9OdEtFzDkWI7oCgPfUqH+mNtDf1h6eM4iG0MQ85l/Jg2AcWGXc7yPkeVIZGf7tMKo6AGCGm0Ls4dk98H1v2MJCdXvPJLzL7HnXLR+rXh7mI4KT1RkSSmXr7fWMtQKXBnY4uAuJ/QYwsl21sAn3EJmtQPKiOjOCF+v1eU4us+sikAbP1qyKlpwkGjTIsU2BNgBYfOIwbIyPkw8aQCymi0fRfOy1epFFPzH1KKKudN9w5de2mARUZ88h0EUYTePXsCC0Idm365W+uZlbBDgNaHJdiJlf0MoqreW1HTRJ0WkpaWNcriHPn1tiN/dDK1QYvNqChFnbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uot3WamdgEBJd/+a7PPRjDdNaXwWUhHzv+VXH4+jZos=;
 b=RTxUds8nBJMxzv17PpoMDqdblFSSSAECBJhwk4FJSTX/9OKB5pKGX4kybEzcs4ZLKZRzFwBNtoOgj5A2n5CfEiaMCjucMEMuOo08SjVkIBKXQAs/OT0L6Tgwh03vo/YPR8AzT56JEsfrn1Dds3UJc3uOp7RZVLcuWamxX8PTDNthcRqVaKKUURo9ZF82kxhb8U5p2e+miXLLPN6MdBl9N7CyvBE4tkmHzX0sa2IQJDAlrFbyfaP+8krB66Bk4ra52u/o0NKtc1BXSgK2glh3Ktzwub5upmL+l3UBNj1jiVKjfa7CHmZvkk5WCvxvs0ZT1XOMV5TIIT3uQKwExHt10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uot3WamdgEBJd/+a7PPRjDdNaXwWUhHzv+VXH4+jZos=;
 b=AMMmWePpRZDLLu1mJ9/fq5x7PEXBW/H/Kc3pwlYZ0O0WsbPSlyrvMAxt/f0Nmj9nMDMyi0uD5Jja/PYWUovLJhscXdspsuS606GrgnIbbfkR+wfjQi6gGvKaU4eDiMLuESV5OZ3qy7mOlTIm99sm7vEQc4BkGhC2yTUxZLZVVt0=
Received: from BN0PR04CA0155.namprd04.prod.outlook.com (2603:10b6:408:eb::10)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 14:26:40 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::da) by BN0PR04CA0155.outlook.office365.com
 (2603:10b6:408:eb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Wed, 27 Oct 2021 14:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 14:26:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 09:26:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 07:26:39 -0700
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Wed, 27 Oct 2021 09:26:38 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <rodrigo.siqueira@amd.com>, <patrik.r.jakobsson@gmail.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 0/3] Fix out of bounds writes in amdgpu_dm_debugfs
Date: Wed, 27 Oct 2021 10:26:32 -0400
Message-ID: <20211027142635.9459-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7d1aeb-7bb6-49a5-808a-08d99955caae
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39762D846ADF3E6E6675F3C58C859@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3AoEistveoOo4ejcR5C/U2ckk7ybldgLfaqvHeySJGsAMzOJ/wNwDhYcc3kzk6ggtxAmOfMUgcHta1ULBOJKdFlaRYs6CkDB/LRhvQcZWmn16ugVIAu9bh9n2QzNoZCWIzQPgwqRQev9G/YUyklzU5KuSqHbQouyYy0W2RFnAisV2V6y1CTD0aNkVk4G/MfA/Zc/mIR/Bny57Wvbk/3Dm4r1cz5ab7QvFK1DXyx1J5HUPB4Vj3JL1XxbLU5UGstgtf+sM/TCQmeIeI2FSy5/U4T+1/34ebFXRh+iaVzYlc8CKgkPPefbtDRiFoDAbRGfAdCgJKS1Vnc+/ZE/b147cPGdKg2wBGLVC8Fqqsx3HS6fbuuk+3lX2NTS7T4TvQwH/EBRpYZ9S27XisIv4589Vzu8umtnNM+BAwN0HFxXe04Blh1oa4xx7/l1gn/Ww/F/w1K5ShxOimx+FQxVu6is2ZyAjy+Inkny0/L2Ze0DWn0gL6lYIiDFMgtmZP+BJEm2TG8k6+fDrxjXVmljd//ewRCfl+2BVTbaEXAUVBmfS4sQ5uDXI50+2uKwzgpd7yOa786MnW4NvqtC+vAGS2LLMFuCKgv01gz1NP8OZk88+nqBfCfts/kN/AOtEQ7qWw2wjc58GAtAGjIKGdp2VMTeyFmmU3yFaNFb0tjEZvZxkaV5GN4xU4f86ccQ203O7G+5/C3z4abQ0ZSapXOmDkZcAq2jXmUcv4YHM7np1s7DBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(110136005)(6666004)(5660300002)(1076003)(8936002)(2616005)(316002)(426003)(2906002)(356005)(7696005)(336012)(44832011)(4744005)(508600001)(4326008)(26005)(70206006)(8676002)(70586007)(82310400003)(47076005)(83380400001)(36860700001)(186003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:26:40.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d1aeb-7bb6-49a5-808a-08d99955caae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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

Fixes for out of bounds writes in amdgpu_dm_debugfs as well
as a fix to disallow partial copy_from_user so we don't
end up inadvertently reading corrupted buffers if a caller
fails to initialize the buffer to zero.

Harry Wentland (2):
  drm/amd/display: Don't allow partial copy_from_user
  drm/amd/display: Fix dp_max_bpc out of bounds write

Patrik Jakobsson (1):
  drm/amdgpu: Fix even more out of bound writes from debugfs

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

--
2.33.0

