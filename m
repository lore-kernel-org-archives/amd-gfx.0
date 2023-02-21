Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE326C64ED9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 07:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3980610E010;
	Tue, 21 Feb 2023 07:51:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F3B10E010
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 07:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crO/AtqrwrdOyr3cnlv3OEPy2bO7z7nVr8Xub+LzHavfAsuBVns2sax4ag3RTyzYZBXjUP9/QtOo5GMuA6Mt9gK0T0SMHiW9S0i+Rs8qdfv73h+Wib/L+zTu6X4rSHKGWLMHFToz6ty3UmsVvPqmSoxteWav3uDy5iSVs0BHl1RggUgAWUySCn8+SxXxdlh9QbNoaa1M9mc2AeU+eaHp8pdlWS/giUdUToCAXTIXj+KNPoy2pAdITFNwuZJnWR5captnsvZRooCaJtn4jUB95yORF9ApN9LsKrAxTdYMRCpMA6JBIkZKDB57GivOHG9E1kGBEvkk1XujG72K+65XsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c6gtA1bkDTs3L0H2ph274HYbJAelUL4LJBgw5RgVBw=;
 b=UcPux9dxLQ7ZoYy8zD8Ni41/6NzKfKCwxSAKZv3joQKFoU5ZyF8XLrzvaTmsLH0mwEm3cbxk3ip93BfzaTF8K3MaZ9tL4vjpEo7JavyDrP1SKSZXYhugGjichNYCDG9mk7mXT1/H36OcpyYSlJD2Idl7inQTzQNmTKzdk83eIiuS++PFWpeAuiZpPJ01i6bGPsb6vB/P4NaVYMbxz8SepN3cLO1nkZkkylwbwiaKBFCQYekAxLAQpmpPrvmANhSUPcSEdzJ57qnUCxAu3Zjyk2e8xoM2CBvSgjBzgUZIuj3S76DPAIynNR0Xx+yh8KyZxAwB4iglR3NnG4uQa/8Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c6gtA1bkDTs3L0H2ph274HYbJAelUL4LJBgw5RgVBw=;
 b=SfV4jBHJJlR6l0uyOAS8lwmSa1iVjxqHlsERnoSBwwJPhwMR8Hob1ujCGDnKKk4vInE2p9buFUDqdSeqGboEmhp/OY8NzMwgOovSPBDPVSnaYlM9iC3EAgWH2IOqbDzoQHYceWVahF9GzHNnw7QQD6bjAI7tITBLXd67LzmjhvU=
Received: from BN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:e4::32)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 07:51:45 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::86) by BN0PR02CA0027.outlook.office365.com
 (2603:10b6:408:e4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 07:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.20 via Frontend Transport; Tue, 21 Feb 2023 07:51:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 01:51:43 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: no pptable resetup on runpm exiting
Date: Tue, 21 Feb 2023 15:51:23 +0800
Message-ID: <20230221075123.1831895-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221075123.1831895-1-evan.quan@amd.com>
References: <20230221075123.1831895-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ad342c-2ff4-40d9-88c2-08db13e07ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20l6nyLF2tEH4TXqehx+9rSMkOc5bBNnBpxN6jA8nTghXFcPtizFkbULmF1bYP/InsOUM0cNDa4NLAYror1kVE3Y6vlKkTFjxSOjGpoSe4s8SiJqItmT+uiwaRAk5wPxeoN4kK5AFZfxWG8VNDpvVfwEaM5GwVifVQEitej52LofqjDlqtV9psdpmjyEceXsRe7WLIZV3Wh7QGjOPWtLOYUZV71LkS3PiwUwFlNfB9Up1ckWmeHE8v0ZgojHIfUfupxjKJhfUdPeIv1DdOtVWNo1DLI70Y2PNZRuVACt8Rg2QiCHBntXTcqzRZwyCrh+1FybuIaUgEc5fAMwafZmsBctUF+giDZfcu5skY2mCkDFiRWgiK/C1daOGQSGwcBLG8pMogEuzqPqU59v4/rT4zgtSUjxOkhxtpv4AsEy8eEkFTLb7e0JShlEX8koTjzKjtREkYFrryNgF+EAtiEknLl27Cinq0Oi1b34COxvO+9tmZKSMNz3U13GPgEBBNYQDtNC6t6vg/hlp+p2V+fqQCX2Wiv+yinVo1YjT+5T6ZtD3AyZVumSNkpaEnN2V2Cy41tma7momc7i6irXjN0t+mmfXtETvvmUqOw2sDQa1JCqUG8kxVBseAT9d8f44iE4ILNYlPncMyNyrxGw4iSm1ZljyHy8RhdT9wbeJJ6TOlFEW86cm08khKZ2yKG2ZZ5/riCCREgt5Pudn99hcBpSbx1krATW0KGfoIWWgsu/xss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(54906003)(316002)(83380400001)(8936002)(2616005)(70586007)(41300700001)(70206006)(6666004)(4326008)(8676002)(6916009)(1076003)(26005)(47076005)(40480700001)(40460700003)(16526019)(186003)(7696005)(426003)(336012)(478600001)(36756003)(356005)(82310400005)(86362001)(82740400003)(2906002)(44832011)(5660300002)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 07:51:45.4842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ad342c-2ff4-40d9-88c2-08db13e07ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is assumed the pptable used before runpm is same as
the one used afterwards. Thus, we can reuse the stored
copy and do not need to resetup the pptable again.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ib6d61f8e8cb58df45d9e24725b0672239b3ff653
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ff806a2e804f..bb25f14f0733 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1220,10 +1220,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	ret = smu_setup_pptable(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup pptable!\n");
-		return ret;
+	/*
+	 * It is assumed the pptable used before runpm is same as
+	 * the one used afterwards. Thus, we can reuse the stored
+	 * copy and do not need to resetup the pptable again.
+	 */
+	if (!adev->in_runpm) {
+		ret = smu_setup_pptable(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to setup pptable!\n");
+			return ret;
+		}
 	}
 
 	/* smu_dump_pptable(smu); */
-- 
2.34.1

