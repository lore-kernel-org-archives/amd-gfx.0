Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA470C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440DB10E43A;
	Wed,  7 Jun 2023 06:48:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F3210E43A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpmSVjn5qO+i81IHhgI7l4baasRC2zeAq4Gudn/2UTbobes4+5iovlnhg+xbQ1VMXBK8lWOGXrsxRYNIijFeVxJHWU7mi6gt9PeS+jC4UE1kIK184d5qh6zUKiQqeOerjQuXcP9ccDsjjTdoZqj7lutPNCV4hjN67AtngSAwkSuIY4XRNsPabilTGH70f+W3LrjFrUAje30HvH761/8PzbpU4Jp3lSdPYcxjiS1qt2wsERySdK89My4L7d9e38M9fX96wY/h5wtLcVQAEPgv0gNmuPfxnfLhB4c1oyFvkFdRo5vb8EAqFH82af/lRp481XLQJJKVYWeTuV+wugCkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IChq4iaf3Y6gmThNnU7K2YaJFvg6n/469DRvpFBkQlo=;
 b=VcOPrCXT4cGHXBmphqZZJGRIfKZFr+XTXmQCSQu+L0Mmi90GDmXkjAKha1bNyaYv5SB9pX8yzj7nrqZrH8moS7HOmpZaJ1avJb5ijPEWVbI/3rlMKCQc6sAcCwz5Q53Zrz3K7hu3FG3JN3PmGRXZP8lpfcNaIA6Njeu3x9gN5c7Lp6HGvk30p5Rdj+Kl+Rh8x1z9JsDSNEzyeJmhXyRr1CStyHY/oOLFIFUDRH1JT7QAqa69emcV5Q7EcxGVgSHR4MsQJrexiOtsQsIwo5aigKYQk1TB5rHDAfNLEMGhEuuRhr2InqBpvMqc3gB2R+1i9jN1Qzlf1G3kayx2gOjk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IChq4iaf3Y6gmThNnU7K2YaJFvg6n/469DRvpFBkQlo=;
 b=wyaYvD+StsSmJBUS4XEH8OybQo0wKcKXzKpJqUJzHwy5H/MdBOsNSNewCXPMM/PbYAnvDwAqS0i8aRPYhx/AsEil5ym0wl6ELwnLRwHPeY3EtQhbD2D9ILEYW1FxHxNsOkyhsaeQvshma/PLgUb+M77VBNwet9HfqUs3IVQkCvQ=
Received: from BN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:e6::10)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 06:48:24 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::73) by BN0PR03CA0005.outlook.office365.com
 (2603:10b6:408:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 06:48:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 23:48:23 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:21 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/6] drm/amdgpu: Rename ras table version
Date: Wed, 7 Jun 2023 14:48:09 +0800
Message-ID: <20230607064814.27226-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: c01227a9-0cda-41c9-7b28-08db67233077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlIADzwf6qRJnD40IPBQBGDyCIosQVrPxxh5n7l+qL6EG8KXtngUQ+l/Bne1tpjpdnsANME0l8KRQUs/6Xjulgu2Bkn4ugIhvYQgPI6mvEhOrEnlZ5D+D36cngFv/ODz4MOdRAL27sEy476sp+kDygULEr7/z33B3HLwEX4uKoZdEFN376yqmj6ftQGydtcSl3QA/aLZ/wqwwcEgM14jzvQFSrkYV3VXjnJ4o+u1HR3taXe9Se6UzgFtxmGTHYTRAbMtFGPUuzggLNwhmaoD/APL7ghqDrElScO2KBy8R/JjDhjVwo45Im5HlHBnxCkBzmw9vR2chfdL+HnVTm02H6QRin4LuFYFewDqjpWlW3rF2f+fCuyEAzyFm7jyIF24OQzHObMjf9KIL+CuR2q4hZayDaAuyagu1KOUNBrzICDC7D+aeapGPDviUSfxPyZICK7nszJz69FQJouCq6L4nC8KFtKRZi51TqrT/UpGH8RqZ7NMCblO27qX1KoyqJQycMb/lv4PbckCZNNIc2yiMS8seW7e3DzTvmqUPcM0/OkLCMN/xlQ5NYXhuZX+XFauUffo+pZtnt4zCByxYksBwsgHxwwi5EsNn0y0ACOFR9Iom+EolV6WffBcmdze6BNwD0jIY5wXff022hRnd8kspnKY9LdOfV5hRh3yXcDcSFpkU1F26ak3+qiOgSRqc0zwbYV+cyMOnyTO0oFhfUko+RlOgroelEd9F1Q1hyOAQ31yYXZC/Jfikb3fJ1pdpSEtQt2oXMgkTvicrtG4z1oO6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(7696005)(478600001)(110136005)(41300700001)(5660300002)(6666004)(316002)(1076003)(26005)(70586007)(70206006)(4326008)(6636002)(2616005)(186003)(83380400001)(40460700003)(2906002)(47076005)(426003)(336012)(36860700001)(81166007)(82740400003)(356005)(40480700001)(82310400005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:23.7241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01227a9-0cda-41c9-7b28-08db67233077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename RAS_TABLE_VER to RAS_TABLE_VER_V1,
move RAS_TABLE_VER_V1 from amdgpu_ras_eeprom.c to amdgpu_ras_eeprom.h.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c2c2a7718613..e9a848db3ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -68,7 +68,6 @@
 
 /* Table hdr is 'AMDR' */
 #define RAS_TABLE_HDR_VAL       0x414d4452
-#define RAS_TABLE_VER           0x00010000
 
 /* Bad GPU tag ‘BADG’ */
 #define RAS_TABLE_HDR_BAD       0x42414447
@@ -289,7 +288,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	mutex_lock(&control->ras_tbl_mutex);
 
 	hdr->header = RAS_TABLE_HDR_VAL;
-	hdr->version = RAS_TABLE_VER;
+	hdr->version = RAS_TABLE_VER_V1;
 	hdr->first_rec_offset = RAS_RECORD_START;
 	hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
 
@@ -575,7 +574,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		control->tbl_hdr.header = RAS_TABLE_HDR_BAD;
 	}
 
-	control->tbl_hdr.version = RAS_TABLE_VER;
+	control->tbl_hdr.version = RAS_TABLE_VER_V1;
 	control->tbl_hdr.first_rec_offset = RAS_INDEX_TO_OFFSET(control, control->ras_fri);
 	control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE + control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 	control->tbl_hdr.checksum = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 54d9bfe0881d..6d21cfdeffa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -26,6 +26,8 @@
 
 #include <linux/i2c.h>
 
+#define RAS_TABLE_VER_V1           0x00010000
+
 struct amdgpu_device;
 
 enum amdgpu_ras_eeprom_err_type {
-- 
2.17.1

