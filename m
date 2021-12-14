Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50665C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4DA10EA1D;
	Tue, 14 Dec 2021 04:18:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56A310EA1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZhDW7G6V90To4B5hI8EA0mhAyn3Vo2G/Wwz6E5yD8ngqU8uxaGcGyOcQVzwvYJlhwifec4TMv9/+idzd6qAncEJ+zt4q3ZL/6eg9lJHRuJK3HJDEiBDoI4MZa2GQ2BlUMf9NcEZ5vktWJ+1XXsS904BN1Ko5W/KVpiuz8Sgne1irIWUmBIR1cGycaXuTMUyF3w6xG2BOa0Cu+aMc9vULXyynLZ1lbbtXmFGAv1Nfdm7lPUSCbPwvx9s4+FzMlzurjkDSt2QK3hhqTAgLV7BnPJMT432aJSclrJdD7V3quFuYbOD99PanRlHBDnG2lB8eU08W9m9BURNs7nxraVZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA5F2lh0TXOKfQ95VQ8VQS6UpdqiTvQyPaIor7Cja7M=;
 b=T/FsVVaZl0rJGD0XKXNNwr+oIBo/tLa3QtcbsNtLHVVKA9VDl8E+AH+J8TUSt4UehSF8CHYRaOO7CKZR7DtDkyYAtKcCYj4pAq8qqDKO7JKKOX7KwxBbT/m90oEfaT/NDcKLxMMsGo7LDVSK2SaBXt7jpgf1wLcZQipLD1S2XL/i0etGeSrbkqWDRyzupgD69lVawX3oS7h7GGF9hGOklhdGG6E7hdkXXWxkTby21JQGsOa6KqCZ3hB4MHk1pPyyy+VS70Jry7caqM86VoRcxzkUvr2gQ4s6hr99H5DWkZpB1fVieL0nujD1flmUP/uPpWig/a4cyD+cUxmYM7d/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA5F2lh0TXOKfQ95VQ8VQS6UpdqiTvQyPaIor7Cja7M=;
 b=f0Ko4lJQCCS1cBTi0dBJr4uvLIgq0VAe0RwIa9ZRq0TbbXbIikmY4gvnV4flqQys+4aFTg3jEgNEO0y3QU7XJCh6AIjeKSdIqFdzRdzQJoPia2CbXQsHDnvawc8jUFQ/Sttgvh+maJgyv9Vy2XOxvqV/jNnWlIeETLN8QU59BVQ=
Received: from BN6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:405:70::16)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 04:18:52 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::18) by BN6PR12CA0030.outlook.office365.com
 (2603:10b6:405:70::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Tue, 14 Dec 2021 04:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Tue, 14 Dec 2021 04:18:52 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 22:18:50 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 12:17:53 +0800
Message-ID: <20211214041751.23647-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
References: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b07cbd-598c-495e-42fe-08d9beb8d633
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2356721EC02526B34C2F0276B7759@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YT8hb5s45b1/+/NFwpjmExZV9e06sDvT8t3fRCTq7VJhW4jB/76XVfmKAgDTbKsnkkoTqGroQL6n4urlhmBsTh58VBJSlTGTrlQHa8Spnk5aIYxC1IzzAePRDhYshrWbShK+GyqXpGyT0d14+26EtcIlqVzxf0IpbAoUP9fwB6kp008mGEpNMdXnalETc13BU+n3UPzFon+7xztsFxsdohDQOBflRX87M2fU8lQbk00YTnA49YWy3HJ3+774lqP6fFaStWZMVW6Lqqz0w0brI/EiLvrDph7nGFbUCp3Vtt3hV269QaOLsrUPZ2CJ8ZIeVTbuqBB8s4ohg2ruWgTE+Eaqr3Qu0jGCJ6Ktp9d0xYeo12/l8JBHIB1y+nrRAt4KZBFh4Y8abJ7ftK9hUCCJvJp6PsH5SJ8b5kovNrHnGgi4LP4LEoT9QRwIxUzdGW8+8joooiK7tQ/unDiHtoBQPIuOPjpeEP5BWE8YT63TxW6KACZZ1PwDCXfMdVB2N/CLIGuF1eRY3fSIlErSDLgXMJMItE1VtcE18lozSz/1IXGZAhCQq6+upeCkriMJiUb4qRS9ybiYzS1MEF4Zw8lnnF+Q3io360gAuOLMlYOw2cTo3ndHZZ6IPGo2QZ9bOpPzbjyUqDWaU+ym2kL//TWpHpkRYX8B7TGMSOxg0Pkb8tEoNbufblyZf5HYitqeJi7VlDLTSXzR2ImJfwI6W1lMZbcY9S4Mmvp2uTY+i+hpRIpX+ESgwnI5poX0BhwIqJ4R99Y/cn86ClYhFLkp7ygnNLFzwW4IjMvxtB3JzftLKIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(70586007)(6916009)(8676002)(36756003)(81166007)(2906002)(40460700001)(47076005)(8936002)(1076003)(426003)(70206006)(5660300002)(4326008)(16526019)(336012)(7696005)(54906003)(508600001)(26005)(2616005)(356005)(186003)(36860700001)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:18:52.6266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b07cbd-598c-495e-42fe-08d9beb8d633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
gmc bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

v2: fix wrong judgement

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d696c4754bea..ae46eb35b3d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,10 +992,14 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+		goto skip_pin_bo;
+
 	r = amdgpu_gart_table_vram_pin(adev);
 	if (r)
 		return r;
 
+skip_pin_bo:
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..d91eb7eb0ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1717,10 +1717,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+		goto skip_pin_bo;
+
 	r = amdgpu_gart_table_vram_pin(adev);
 	if (r)
 		return r;
 
+skip_pin_bo:
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
 		return r;
-- 
2.30.2

