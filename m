Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7714EC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD2D10E4C6;
	Wed, 31 May 2023 13:16:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F5610E4C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIvgkGBFNtuIWlQo1skm6NBqXViuZ1lqaqS5Ao89cvfVAlAlKR8qRchjF0s+kwKtTtn1fKNwAc8JAqFUPDttev9CR3v2RMftWliCTa09leJceoEonSPxKAiYrZQDTDFQUMdM1RtGW21BTRWTgRO7MQrB6ib79BIsQR2UNTvQ3kP4BiDz+ZUVCOIiGh0EhsA81/n/eZ5ayobusTP0bn1DJkm6BVyDrYtsk5R57+qP08pQ99ci9eQp8dEaiQheIfw9RAw3qmB//ZyRJWK7dJylno514Zs4g4/dQgZLv/ODTi5NHZo9rAAVVIBXwreNXrpNRc74gLDsiWMbe6NB5Md2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+2FhNH61oKW1jDUyVM+ab4R7Tw1avAkgZJH8pFjiHw=;
 b=bl5/wnu9GEcWMfF/266D8hcK9frXrnC0occPgLl5cnxcXL2Rlwe9IKV24dy+Xuv1kKjSWcco4EJiEqqGT1QR6s0o/yZ7FSQXDLF/dJGi2wWsTtPChGcl1p/wrEJcGvp/zzM4R1JDt3A9g2oEbWwxt3yQE9IxwrL4QW5CXC6YZh9tuxvCNxrodxs/kh7diG6MUGahEh/i39jIJ2LAuKXvRSCd2JbEzeKL02HqKn2qC1uqg5s+GNWpvgFoAiJUgf1EPqeUWffy6e5jvF0UpxUC8hyy9yKJ1md4SU7LGFKCCWuOMo6iLpYy8PZyFFZ9zFmpEL1Xu87k3P7hAsNt+T4Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+2FhNH61oKW1jDUyVM+ab4R7Tw1avAkgZJH8pFjiHw=;
 b=hbtjSLX/4J13+RzwjnKIEVita6A5Y2uSeOyLNC7l5OCNmuTKFOCWCEko7DNmIpRvTRzce1KMfOyYZTxCSkk9TSiLfsFBuJfDCsSDh70s53PI60iJcgas8BeMIV6gcTzMxv0Q9d7zxutHglQE936IqE85ETqIKjI2l8Lcg4GS1Bg=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 13:16:16 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::4f) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 13:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 13:16:16 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 08:16:14 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add unique serial number support for smu_v13_0_6
Date: Wed, 31 May 2023 21:16:01 +0800
Message-ID: <20230531131601.806247-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 811fd55a-8a25-4c10-a4c0-08db61d9375c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwxEe0kkPnm0GXJ/20zIs4EDHXLuOtEf+qWckg3ZuPNem8qq3CY+Na03VV1FouctA/2yRn8YufX75ysyphpUKpA8wd7Tc9bWJ7VhyB2wbbhXfDqdBVVCKJg7JC5yO5veKA/JNSE98ONVnspdeUP5bNhnzHs5bu607qNshS/VATa4oA9tgs8xppDaHCxiKl6xhGux+t06KnIqnZvf4qnWNC0nhtXQRY4oEoP7FUt37+WOJ+Qfxs9pBajEkvPOHJvcIxnu6FyRMxHCsEyTQ9ijRCj/Eesq9488F4Qacc8skMQBAK94PGwZCm3P+zPhFstg/xat82irb/W8Z4zPv7aGNFqyqvebIRyfMjL5jz1eRxu1VLcKQ0WubVMFo9luGVIhANGKov9I/NZhK8aaXEZkbDXQX5rvIrQNgsdrnFzPu4G2eNc62OsDP4Gpvt3QL1wHTUDExzOdQab7DK5iW+iV/CynJsgA8EwPjpmfzufcM+hPjE5BVac30dX6MuuSAbtQ5l7kdDyeZ9buRPS07eDYLd/DlxWMwVknIYhx2QyKy+d7ByJX4J9b+oxOHrUyf4ZLQSH0r/+f+WhYWxUIKmX25alNmcTcrQYbSinljzF/nLhUohhcrYpIPIej+pXjBSRJwZxuBdXrXYYWvClyFLCy9o7WxfH3yNS8oF455r7zHt8CLqTKOu4ogA6Fo6K2Qj1dgpeproLy9CfKIptwKsTD2NZ15Ea/OL1efzdDlt69Y+zLPAjNvWmoeFlU7IB+956KSHyzdSiAe/l++gCXJnejZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(44832011)(47076005)(6666004)(83380400001)(41300700001)(16526019)(7696005)(186003)(316002)(36860700001)(1076003)(26005)(82310400005)(86362001)(2616005)(40480700001)(40460700003)(336012)(426003)(5660300002)(8936002)(8676002)(36756003)(2906002)(82740400003)(81166007)(356005)(54906003)(478600001)(6916009)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:16:16.6266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811fd55a-8a25-4c10-a4c0-08db61d9375c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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
Cc: Le.Ma@amd.com, lijo.lazar@amd.com, shiwzhan@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

add unique serial number support for smu_v13_0_6.
(use aid0 serial number by default)

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b9f32e0364db..75255e0baf91 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -192,6 +192,7 @@ struct PPTable_t {
 	uint32_t LclkFrequencyTable[4];
 	uint32_t MaxLclkDpmRange;
 	uint32_t MinLclkDpmRange;
+	uint64_t PublicSerialNumber_AID;
 	bool Init;
 };
 
@@ -352,6 +353,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 				SMUQ10_TO_UINT(metrics->LclkFrequencyTable[i]);
 		}
 
+		/* use AID0 serial number by default */
+		pptable->PublicSerialNumber_AID = metrics->PublicSerialNumber_AID[0];
+
 		pptable->Init = true;
 	}
 
@@ -1856,19 +1860,11 @@ static void smu_v13_0_6_i2c_control_fini(struct smu_context *smu)
 static void smu_v13_0_6_get_unique_id(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	//SmuMetrics_t *metrics = smu->smu_table.metrics_table;
-	uint32_t upper32 = 0, lower32 = 0;
-	int ret;
-
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
-	if (ret)
-		goto out;
-
-	//upper32 = metrics->PublicSerialNumUpper32;
-	//lower32 = metrics->PublicSerialNumLower32;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
 
-out:
-	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
+	adev->unique_id = pptable->PublicSerialNumber_AID;
 	if (adev->serial[0] == '\0')
 		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
-- 
2.34.1

