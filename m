Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F834C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 16:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E97810EAA5;
	Fri, 11 Feb 2022 16:18:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F205610EAA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 16:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GThmeVHlErk/GGflOK3LaeHO9CX6gsFgDRV4MeDb2Phj4zeqYDfWfaxi5LJrFSJ/f5GsAlq2QQLCUZjuc5arRnreEspTVgRnTo6MuiPNTpuwaJU/qU5iohJoxnP1fQyNddbxCSFzZu7TRKdO/fQd92s1VADzZ565RuC2V+6WAqu7Q0nDjCl7E3/F+PDmsfEoaHJVcJx/lCvDKvEinegX/1PWBjroy81vXRXHlf9gFtWU4EUsajM0iKF+a7qtdu3NZIVP2FysM2Sh64wWuGwEW7v1t5tXTd2GN4I58QGiXNPsElVKdPYryC0oM44SfLf+21ybahR+YE0jg8yYZP7Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPx2Zi74aldTeKSE6VB+oqdgk0w1ONfrKEIo43JDRLE=;
 b=HdY6usAAnMavxafTm0lZldgOfoG8+gBVoGcVl14YuPAvZw7I+Y2KJKyp/eq7cKLrAzDllMS5iNdd5+RZFIkI6Kk0AapzD55Cj0n+7d6l+CJpENiZ0zxhI9K2lEVxVE3BK7SdSEnkTLjlB4xbQzYfUg+D/xcJqZ6sBzV0j678MY9B9x4MvYcstdcstx3n/Y8KPgEQy6X8i4AO8PEthfytOM1QRURcaY5p90eHO+hhiQ2B0n0lH4hxPs3o61ieFTJmuCs3+NBUhz+srh4e9LGM3CoF2IK/sUEDFc0BB5UCh9u45C9FmrISp5mDuuKAz9YQdJRSzDf64s+W6/omvyRHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPx2Zi74aldTeKSE6VB+oqdgk0w1ONfrKEIo43JDRLE=;
 b=kkl+9ulM8OzLJnKZlfRNXCcY1fmk684Rx/GGYEHD8F8ViS0ooQsPAYIGo1tsIZbz7xgwcirdwihNwCvoFYnkgYXWzDCrOVPYuqZLiDuWc1+4XskL5ZH/n00bxA2KUv/AarDaSw9zaZxSlTRPwkJzuIjE8GL0wwP+i3yaKBwqvEA=
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Fri, 11 Feb 2022 16:18:15 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::42) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Fri, 11 Feb 2022 16:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 16:18:14 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 10:18:07 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Date: Fri, 11 Feb 2022 10:17:58 -0600
Message-ID: <20220211161758.29610-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210025902.32514-1-alex.sierra@amd.com>
References: <20220210025902.32514-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7513cea1-8081-487c-e37d-08d9ed7a1b3e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44242710673B836AAD12DD18FD309@MN2PR12MB4424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1UL0tcwGz1T/9hY+VtnboBM7Kc3bDWPjxoyf8ibJPVBpbl2w2yMSSFb2lVzGu2Jqbbde5Yo02Wa59Czxhb/d2mQA1gUF/yerWZT2rSN92b/S2oCdMx37d9SDRtylUEnzZFZfzdGANNWvtcyvOn1+ntvI7Ryxu1tyOyW+NcpQ1+R6B8IhYdfBfylC36649+fJcoCUXQkDxO4mjKprM1g3On+QdPDf996kZUnrjahP5NI/aK2/8Rw/HX/8A57zoBE0UPfxPiGO+k4WHX9D7C3twUoC59PvHTxcSU6N9qqt9X04A2ebx25+r2bF8e/5hWl+loEOtjLuSaIplt+/m9EzVQJGiKYfqqlhEi1adeXYCqjZwEBMP0CE80fyrzwuFgNGHvbfgpA9yHjNmweW58PsiDJ9NbN6qqtIlG5R7r0XgJx826gsFv2zZLppVrXZt48THFEzrqGv34ch01T9PvboYJZPtFodlol3j75lFiAqL72xuDkMogvsOeYiwfLkL2kVrMSvXN+WiKkwG9ZfkxOrOiC1A4U/TzqCWScauG7gPU95QLe+faZ1VAkSXG9+WgqPDfOlITfNbVJcA9/Q9vP9IlhpgRXL8CaPjtwlg+Royu/mSZt5wNQgavTHfSUKkgT0tuNRWHZAoMtwNcqXX41NBQUsQW9NnmDgEAO6VIK62hxn83oSH1AVlCMizdsx/TrzAdIcam2s2Agn1ANJxOnlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(82310400004)(47076005)(40460700003)(86362001)(2906002)(6916009)(54906003)(316002)(356005)(70586007)(81166007)(8676002)(70206006)(4326008)(44832011)(508600001)(6666004)(83380400001)(8936002)(5660300002)(336012)(426003)(2616005)(36756003)(26005)(7696005)(16526019)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 16:18:14.7597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7513cea1-8081-487c-e37d-08d9ed7a1b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Cc: Felix.Kuehling@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid spam the kernel log on application memory allocation failures.
__func__ argument was also removed from dev_fmt macro due to
parameter conflicts with dynamic_dev_dbg.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..befaadc0e854 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -36,7 +36,7 @@
 #ifdef dev_fmt
 #undef dev_fmt
 #endif
-#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
+#define dev_fmt(fmt) "kfd_migrate: " fmt
 
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
@@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev->dev, "fail %d to alloc vram\n", r);
+		dev_dbg(adev->dev, "fail %d dma_map_page\n", r);
 		goto out;
 	}
 
@@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				dev_err(adev->dev, "fail %d dma_map_page\n", r);
+				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
+					__func__, r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			dev_err(adev->dev, "fail %d dma_map_page\n", r);
+			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
 			goto out_oom;
 		}
 
-- 
2.32.0

