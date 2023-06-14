Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD5DEB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 04:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2C310E099;
	Wed, 14 Jun 2023 04:28:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA3310E099
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 04:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy8tZZbH5iQA7aVB2mdtMz2NZ7LtWC9nByfz9RSy52N//YWuV66gZFOxCQE3bBJtpU797RpKbYEBU66/sOB2jjXiqalKvJkw6c2XT6FciZ9sxV2GPqm+5D8Tt3nbxi/mxyoxHl0QZtXhQlrOuQiun17VaHKU6gxnEEGSA8r8/77KBIZmaTO2c1NmVu/d0ohDlOfrnKRtJgggIcxKsi/HeJfqsC8J+ZREB8dDJJ/2zuMsR9/yqvW2KuITjyQBS4fuzVxAx+6fqZx9mjo1HmrPXtElB1xO12drGBO2SNdUMOemI4QeN4CVGqM0Ti5iliUZvzvLbYfN+9Y1gxVzEbOwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhWqvUF/ToPjHNP7CwzQSumpnhapvGjze4ytkiheuYY=;
 b=DXFFi8qIGxVRMp4/kBvmbIBw2T+QPsq5Fpjy9XKbWalpQW2jWiXKWE7V3n8ys40dxo+/gJj9l7Ckr7mI3L1mcXcicuPi7lP28i/MigYrSwIXGoWCVAF4C5O6l8wGSSHqXo2xRaijOv9NQWR2pMN95DvIPx6ySzxT8r5N6dDmxIKHElN0ExPvL5yA09cKZhrN4ylZ+KNlJpfAafd73OO9KH8U4oY8/iOHssqTh5iDIG5HUdCFNZh5OsLZmYXrgPiI8LfZsvjsESNnu+jH+Vj6SjZdKkyY5lAQDArgSVAbdveW9qITWzp/5QEVnhTHEpZV7rXK66SsaAubrUNVN3hb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhWqvUF/ToPjHNP7CwzQSumpnhapvGjze4ytkiheuYY=;
 b=N8wv+8Fy3Eedkmf8ovarPz6ZvpyfEPnQ60AOf98oFMvz2o/jULOOx3d0BVHHzWfIvCRaRh2wLSL8C9OAqwk0EFCOp1tDqKJyL7a+ZJ3hl99a36m/Y9RG6aIG07OJhMeNtbAIjkZDFHi7oY3ic5ZcEbdLUKf9VwDH3/WRWL9LTM4=
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 04:28:08 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::2f) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Wed, 14 Jun 2023 04:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Wed, 14 Jun 2023 04:28:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 23:28:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move calculation of xcp per memory node
Date: Wed, 14 Jun 2023 09:57:48 +0530
Message-ID: <20230614042748.1588642-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 910aa82e-a7ae-4a3d-1928-08db6c8fc105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qT/1E2evtNevFvZymhlDwlTNx9XGg0pw2kt90xgafeY4H2TFIMXFCJe9LCgJN9bWAK9iQYPLtPDSLr4xkNJBCexXeI25eeRuIgoqk0XzDXfVWN+Rt/Ea03CYsqkkdCa+dwe3PxxmxGRiOAZbTppm97iuTM6/gd66+f2XwQhc0Jog638h85fkFEaiZ7YepwBtVkuXJ7ktRUCytUE8Weuzd3jWT3/KglVpyhtRIRlb/HN/D4nfZbmu98WzsVgHSTV7wGZnLqWDgDcllMDMPK511bPSGc0EACSSIWmgA2htOnADcrzirLi5Sfhc5scz6mrRQsfYfrViBaPBt4BtA9CFfrg1Ju5+OF8NbDVj8fXu82NqAQ3m9dlj+0RYZYhHosdfb0LFzM1I1ACUkLOVgLb5IGjF5pI2w+fAKTdY/Ir9i+e0eK6GnJkTiA3h2dQTsz24iXROd6YYKJ5XT5ooacHFAScEnPu5a8UwWs6ySzQ/exU4GMJyCABb8D1XqqvrQn3gtYqVikGhE+2RAy3VlbE+VetcLEQOaVBKmYeQCrAwJi1Grlk522t/HjeZUHwhRZkiLMsnHCnwjQcnyrhszcWN+bg8AXYmpLfrZ+/ooyPPqTnBJnWM4by1bLUq8TlxYqsAUUdbgzdA2fTxmIW9lBy0wwOM+7StOwrqEYqfNwp4p/R/Hc5Joi3THt4E5NyDplLLdvbtqDaglKcl6k51mkISBLL0p84Rvk0u9PUpmXHCDeaOcQOFg5nXoysrIi6uJobiqwjE1skE+LfqTmArjXzn0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(7696005)(6666004)(426003)(36756003)(336012)(83380400001)(82310400005)(2616005)(86362001)(26005)(1076003)(82740400003)(356005)(81166007)(47076005)(40480700001)(16526019)(186003)(54906003)(41300700001)(44832011)(316002)(2906002)(8676002)(8936002)(6916009)(4326008)(5660300002)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 04:28:07.6110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910aa82e-a7ae-4a3d-1928-08db6c8fc105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Le.Ma@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Its value is required for finding the memory id of xcp.

Fixes: 2130f4ca70b7f ("drm/amdgpu: Add xcp manager num_xcp_per_mem_partition")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index d733fa6e7477..9687df9841ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -132,6 +132,9 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	for (i = 0; i < MAX_XCP; ++i)
 		xcp_mgr->xcp[i].valid = false;
 
+	/* This is needed for figuring out memory id of xcp */
+	xcp_mgr->num_xcp_per_mem_partition = num_xcps / xcp_mgr->adev->gmc.num_mem_partitions;
+
 	for (i = 0; i < num_xcps; ++i) {
 		for (j = AMDGPU_XCP_GFXHUB; j < AMDGPU_XCP_MAX_BLOCKS; ++j) {
 			ret = xcp_mgr->funcs->get_ip_details(xcp_mgr, i, j,
@@ -157,7 +160,6 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	xcp_mgr->num_xcps = num_xcps;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
-	xcp_mgr->num_xcp_per_mem_partition = num_xcps / xcp_mgr->adev->gmc.num_mem_partitions;
 	return 0;
 }
 
-- 
2.25.1

