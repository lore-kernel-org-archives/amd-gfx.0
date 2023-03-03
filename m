Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A23C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 16:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA41810E6F7;
	Fri,  3 Mar 2023 16:24:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4669D10E6F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 16:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIX8mGZGVhRXiGjLGYxs4//9vAcmfOgUsJsp7FCRrfsB+rLcDAWXmAl90zrXHextke2RwSlLegv8RXCqtgFuRdBlMA6DXAgiQid1ohOK02kKzFAr+QM0+kfd6S+20xUy8LbZbCQA4/pdxcoldBA0KB8arYnV/EUhXlOdhHRTuGk+lM3dT6ou3VJRZaivA2LT14Vtp8CCG2tZGrFQ4UTHa2h3a6uFyQp4PFTn6RyCFolgQ4v3KrQ67DJk3FfkesjU6+aaF1bU0GADjDQcsrRj7Lp309A4UK5XjxZP6Zk464kPBr7qnTKutsHMuzQ5XOis3GiKtQX3skaoL7cvj60XWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J5tg5WnhTZavr4K6B7mtviG+0CoFa3SggftPOkfczU=;
 b=asIaZO+X8Qt2tHoIVlAFWmCssRKYw2FWrr3nj/zDL9UKGl8kfrRUyv0F/l8L6Qq8Dn+5NDcp2e0cKcGxndZq/igvTruhFRHwhVjYO0ildn/RlrHxQjs8CTz4wmgde4J3mrqsNVH5A+P9PaG/O27Q9qz5lErOk2iGSyfJ2sLZvadVj58xdv5que7PdJoqA9AWrLU2ic3MfgQa+BJKc2DqDpnJM3gIbajSE4aeJYEswjRCCkX1o2OwlaYiElSez3ZSqjEodH0C3Zm3bM8EeQqBcD04spckqBnxHMK/UvQgyhgl17SI4SLLXY39EfmhSqOjW9iP00Uv0sUkC4vNLZZWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J5tg5WnhTZavr4K6B7mtviG+0CoFa3SggftPOkfczU=;
 b=Xg0otxn9FwXa954WlQ9P/rN3YfLFjhB80Bqy6wv9S0m4920fDax5x3XmawC3ITIhXlMly7YH2sEg5nqp2oU8qeQHG8pV3+Kmq/SrTWjm317Y2BqBLzthWlwzWpvJauTxOTAA81JIm+6eFXDQQawb26acnrdkey5PYwr73lSm2LY=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 16:24:08 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::dc) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 16:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 16:24:07 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 10:24:07 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Optimize end of non-contig VA ranges
Date: Fri, 3 Mar 2023 11:23:54 -0500
Message-ID: <20230303162354.1335561-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|BN9PR12MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf18f1d-33ef-4715-e9cd-08db1c03b6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFrPEkOVEXAfEsmbR5Shqqwh9qLewEu9M1Kjr7zKS1ZJMQA3lkrz2ZeJqRso/JIgiSj4a6ABGC5mrwX/Jg7cplJNPbGte+rDkZBk8zB4XncgIFhLGSqhnTMoz4OZlSSEeo2Udw6UNxM+cTH37ZXLoLUyCGcw279m6zcW9EGCDGK+rADeFjHJ0psWwN3Mwm5MUWqWTgprhjoTlE5gILykyEQly+eS5hjLo81Wn1o3SSM69pHGvYD7ZJnbZ6gz0WMgXDQ12CppztwtM4+QMYthirLWpUdZXvfyFe+m9D2gKyBz4BPtbc6FqJ3ONFDBKTiEDa+qQtHFTsjiMrrUEnrK99CvGNDWV7uIDv+jednE92UwWDLgCE0IbwKBM9FWoz8GBWBxL3HGqVFmuif1IVYqukKp/hj75FotxdCVc8pym51E950NG41NqYt6IYGWjlqOsfvf3BvwwbabIw1CoTHfhueWbjeq26yoIPZGPIh+oRoMvdPF4WmxwoDrgT5kNqu4Y+0F1pVzbL/qoJyT4Wc16UgL1eAuKSzie5FK+rx3mnOUMR+9iim1UZmRjDbWB2xTE+Ddx+vJ6AqE5ZtZw6r0lPdKAvRLxXe4poRilCkLAEtjX9Pr/0yRxfzXJZ+qkgVQ78/jhTqLXgYZjBSu7It6pUO2BhqV8DXFBH4G3EFqGAG6aFrw3mcx92z2JbgEVxs2ACQU/uHvcPTSoZqj7XXKKLIG2tx8UiKVN49Fn5IkV4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(66574015)(426003)(36860700001)(47076005)(40460700003)(36756003)(6666004)(82740400003)(8936002)(5660300002)(81166007)(478600001)(2906002)(356005)(40480700001)(86362001)(82310400005)(2616005)(16526019)(186003)(336012)(26005)(1076003)(4326008)(70586007)(8676002)(6916009)(70206006)(7696005)(4744005)(316002)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:24:07.6819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf18f1d-33ef-4715-e9cd-08db1c03b6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
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
Cc: Philip Yang <Philip.Yang@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Treat the last page in a non-contiguous range as part of the following
contiguous range.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc379dc22c77..759e1fab6e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -866,6 +866,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 					    pages_addr[idx - 1] + PAGE_SIZE))
 						break;
 				}
+				if (!contiguous)
+					count--;
 				num_entries = count *
 					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
-- 
2.34.1

