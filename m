Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F777C47077
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 22:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B5A10E306;
	Mon,  8 Jan 2024 22:37:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8FC10E306
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 22:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDlMsG4UBtCduyQ0pmkLCZ5EiRcg/b/HmXCLFEg0lB8q47bh+1bXyzBDqEHdKQBxarB7jSoBSk3UuEpbyUXBgRFWdS0Tk6g8GpxuIccQBxPRaC05ndCjoGe6BUoXcSj8uuqWgpCbEL17+de2h42b/oqgQkUuZkmHIImxjimWkitMBDUhtx1Ci6EP/s8D055ZkukPbQg8a3Xj9MTlz1pfRINWW7l2WI2ccnkXj02U1RsmXxQ+Xg14Dlp9VhpmVaRHAQeG31SZ1C2zUXT73v6s+HeIsScpDDLD2nrByKT0st/gRqiLbflyVUpij1fQgzTM+jOn8m8FGKQigrzZ7hiU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fFkPtx/Hj4g46zaKFkADtlsZqG/EXuCopYyJR1Ri4A=;
 b=D715MvPTPDIZOQSQ1/NgR8oQr9EXdPbMEeTiY8hP3E35Cy3eeiJaW1D8hZXzh/5muSiLjdr9pTlqa+p73EYjcQJP0hhDc1otuOG39/VbNFeWkS+1cBUW1robCMkrAiVZBvAyNMR+a7ENIK+UiAUMgUPJFTneKBYh39KIHk/wN3uXzWyk5CUdm4rUGE5ubYt7AxVASijcSl803CPf0L0HZ8f3YMw3/rRf4YUVmJfFGBg4HX6casC4MwvSZs6ETco7WXx3emnHluWBfxrHJSkMT0X8zme53fA3Bvjyhr2bIFN7oJCSUzyzOlqcpoQ9R8swBNeA4BHFWn8cgz5QJs7ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fFkPtx/Hj4g46zaKFkADtlsZqG/EXuCopYyJR1Ri4A=;
 b=Au0mAXiq8yrlKggS2KzT/2Y3Ysro2FBqgQbw1l+xVgvPZLu+uqefmz/wjaFQKKMboa5BsoCRZRKnnA4VtlXbCtfEJBzWh+8Zfmb1flmI3HQoZMB2kS+bLflPpP8YEQc9cLZHAceKcQgvCgLgTZt5lSpBjyVrg7vX3X6+YhmYSDk=
Received: from BL1PR13CA0132.namprd13.prod.outlook.com (2603:10b6:208:2bb::17)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 22:37:16 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::39) by BL1PR13CA0132.outlook.office365.com
 (2603:10b6:208:2bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 22:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 22:37:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 16:37:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdkfd: Set correct svm range actual loc after spliting
Date: Mon, 8 Jan 2024 17:36:51 -0500
Message-ID: <20240108223651.14997-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d5d6be-1b84-4db0-64e7-08dc109a5e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0oWprRYbI3iVOsn5d4f7qzWpMRcSyjHltUIiG0vxTCjbAIQxZieygv3INv5B/ZSTySaoAn2IgZGmcn/L7mRaSeFHF7w1XvP/5Yviu4I5tt84lSVhk8NGLONFM2KrgJvvCt4e6PpH6QPqgelfD2zVSZh+pfitQe3FC2bluzjmpvgHD2X3PAqxGoZOjCCY3M7DPFXforZGcwfEBxXO+ZFoB7z10tKttzpmOUP8GAvfrTwJcpqenJ6mqyLfK6nbHMWuQ7ajXjB9VLljtrJlhpA5zq7hasmlaWl2tqWLxa5N82XUHu48WOchHWKmN0yfH0Qqr4VxPmNWPvCUPlbmkpXSsSRi2Nsxty6CLjOSfgREzCdf33PF0QOd28WEjP5DErVIk4g2hAQcFFPx3Znj4Cr99lTwMErcxQZk/ns3r+u7NzhbnW26pmkUFDH8o9M0MeFa2OIGOvvICxpdzw3UPEzMrmWeTNTYRtXTj5R1rMPdZA0IIyb9ke84Mctdlf2vR7ByJbBSfKZCZ3ciR4rSgtOCBGC4+6a8VWcqCnE/4lRCxmQesicxbrVRFWOkKWi5jGwsdEHwuZ/4SxqFNdsgPPiMp2MKO3SWzGL4EDhBOVnVVUb4tbWiGiqaMl5UAg/MRLjBQtp5Zj7q/CvYBIO05AnKkLGjmbJMBeplOi8UHF/vK1L8JoK4YL61ACXQC+/knc1w1nTi6Uk/pwv3B1w8jV1I+z7a+pBAjEzR3qrxSMVdMfJw2+ApOFpvhwr9HWrdrGFQzbn8TQx34Fjs6xWkiP5rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(70586007)(478600001)(4326008)(36860700001)(6916009)(316002)(54906003)(8936002)(16526019)(2616005)(426003)(1076003)(336012)(26005)(70206006)(83380400001)(7696005)(6666004)(47076005)(5660300002)(2906002)(41300700001)(8676002)(36756003)(82740400003)(81166007)(356005)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:37:16.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d5d6be-1b84-4db0-64e7-08dc109a5e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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
Cc: Xiaogang.Chen@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After range spliting, set new range and old range actual_loc:
new range actual_loc is 0 if new->vram_pages is 0.
old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cc24f30f88fb..cb09e1d3a643 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
-	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -980,8 +979,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc && new->vram_pages) {
 		old->vram_pages -= new->vram_pages;
+		new->actual_loc = old->actual_loc;
+		if (!old->vram_pages)
+			old->actual_loc = 0;
+	}
 
 	return 0;
 }
@@ -1058,7 +1061,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
-- 
2.35.1

