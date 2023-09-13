Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE3BEDEC71
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 15:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5954610E02E;
	Wed, 13 Sep 2023 15:17:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B350710E02E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 15:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoPge8FAtYr/V6/didBVat5+SWkvZpj/F6hD33LTtbEexarK17J/+1AlAGC/8E1HkCkeGN5k20nw8YJ2BYocWi1GpnTF0C9PiAZrEBinxbE0eAy3RRdKJpw0yn5mlsG/kj7EivAphxlHZGVIdsBJDGLiaa7k0AZJKCjB1JqgK0aAKvtYU8j++QvbYPKKN06GQmDaA0ZX3LCpjHKF1Uakipq6Cob601otjz7pfjMCXQycO34oDd68/EtedgQgBxu2eSkX5sIvA4SbQlXQpH5jozbfgr3x9lJ2Ztls85AVgdhoMXZr4WRU3tx+3YYOSin6HGXo2IG+eqKW2VRTBSlIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLjOgHMXw4MpV4cw9ti6yfTfKg97qdlKqUP1zLYirvs=;
 b=YCZVWCUCpP7nEG14ooGnYFSEiBOSZkucPM2eCtYQd9QbuQdecmpuTlTEXBPb3dnTaiaGqGkD864QOoSAnZAAmyMGS9xgya8xphf5BJFH3Q6QPGQrs03rzDAhDWX+rkiN4kMZRaFsEqx514ZVIYMmV9sdvQ+n48qsaiKBUQR/p0GJYURqx1uc5pZFvNffIx8vzhoGmvMvq49uZsW9SEQDU8xtI1Le8uvmtmD47rjLGCjqj1EVaRMwnRR2nIeuPcg3JOwBWVosDYCHXyjMFbhQv5aQHwVYpH0kRwDsLE09tiiB7WzxWc7LPgBUnwSscTv15xmfIHMH4vuW/f0K7190bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLjOgHMXw4MpV4cw9ti6yfTfKg97qdlKqUP1zLYirvs=;
 b=l7UmAjgKb/QKVA3MtvcT39vb4KUVKjSZMoW/VH/BoeXfjD4TMDU5fyA4o3h+H/z6TC1dxo4uIK1Jw2Kx2gVcDf6HwCBhBjFza9HsfVX7dQmbkTJSK29cNU8cgXGSk4kjrAjVHJ5RIicEzUWRjaglUGPTQxSZZK4q2uuhcy042k4=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 15:17:12 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::f2) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 15:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 15:17:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 10:17:09 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: handle errors from svm validate and map
Date: Wed, 13 Sep 2023 11:16:17 -0400
Message-ID: <20230913151617.18894-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: d6856b21-de5e-4c1d-d01b-08dbb46c8122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9wBRjKwGq6SnYTz0Kv08ynnZqYuSybxTSjpVqnATkWvuSFUeGFS0Wdxj/n94xPZquOu8Sv+RK5JgtZiAvifxcm7CAcejc5ZZylvO50GQMkjT8DzS2HJZfh+yOmUM+6nfeIUA7r5Ccb2LcKHK9tjIz4PHRnJvG7Ah0viAnaXP9CpaTa0RXOC8yX7sAaj9mEVl//fywuI3p54HAZiB0Nwrx162uv2FLdgl8DMxKdy049b0bgUAUsUafEDKrJH82y0xTzS/Df9mb+IUjAlfNt9y6+v9IeZoH63TtIiQ9HeBA9MPpNIYoSi5kvWCzywOzKtoaE/iQ3V8MdFZxXZ4o5QaD5bPjQ1AM1YkteGqBx5gTFkE+fx1PFKn56kShb9+ZXZ3yBhIG6x1Jy3AqdnZg4jJoDC5korFddEN7PKOiOs9pGvUIQCPsx3eVnCXhyJXLsEL9NbEntGvC9ilcyysWA2OKgrDHIAbewEHQEydclp2+mmm3d1bz4H9RjO/Sxr1nHJZh47yeJYn/QcXFavmoC3tNsRygkTB1LHOYadVLRF7XJ911TkmY5ZlOqn5fKAYbux2eBuJYpQ1umYruMPBsj4+8Z/T+fpWcPnrkpZKJCi2g9jC6zoYZlZz7d40xNeB9DkQ2FkboaYu+pfC7AzsoeIufa+2YoqB6rdnD6Vu5gqpJmm/u8XVB31HS14cayEMq3M6XOy/AAA53F2WbZEamnBl95+dH5/UL85IjHNsnkf+//DJEAGUHsa9iwsmpk5PQbtpsDb8yLqQzNs8dwehrTuRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(7696005)(6666004)(356005)(83380400001)(36756003)(40480700001)(40460700003)(36860700001)(82740400003)(86362001)(1076003)(47076005)(81166007)(26005)(5660300002)(2906002)(336012)(15650500001)(41300700001)(16526019)(478600001)(4326008)(316002)(8676002)(8936002)(2616005)(70586007)(426003)(6916009)(54906003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:17:11.8285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6856b21-de5e-4c1d-d01b-08dbb46c8122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If new range is added to update list, splited to multiple pranges with
max_svm_range_pages alignment, and svm validate and map returns error
for the first prange, then the caller retry should add pranges with
prange->is_error_flag or prange without prange->mapped_to_gpu to the
update list, to update GPU mapping for the entire range.

Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: James Zhu <james.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 61dd66bddc3c..8871329e9cbd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -825,7 +825,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange->is_error_flag;
+	return true;
 }
 
 /**
@@ -2228,7 +2228,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (!prange->is_error_flag && prange->mapped_to_gpu &&
+		    svm_range_is_same_attrs(p, prange, nattr, attrs)) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
-- 
2.35.1

