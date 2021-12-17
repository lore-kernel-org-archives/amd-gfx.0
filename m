Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A91C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CCC10E603;
	Fri, 17 Dec 2021 15:31:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52CD10E603
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdjd6PB0hfziYRhIkDHUfkbapCf/gm3VZAG4oiHgeueX+JnX7VKFlZhQaKdmZLokPVFndGb4V0GSNv67ot01mgaC6vs9OIN87cT4uBOSriM8McKYWJf15hYryYDAif87JyT5QJjl1RPij0zXzOuthEyMJek5wuTuBYAjInJ0lhnU4AZioNkixkjr/GWn5L2UnbxBzwMQIiZMqq+O7eelfcXzDZ2Jlyx9y8C56MYvVRPxSU9j2IAeFY8lwsv1NXXPvvcLQrsgsCZSItG7J9e8qtRPJrFBxa7JhMUOR+t4yvuLlHuxemGosR1I2w5C1LtNPBTlS9Pqin8mdPWe352uIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tULpY+cW7XkE3ZxtZljbsS2zumIjy42PnBJsSfOXkuk=;
 b=LfBxE56pBSxNzYr9wkOXsrwin+djk7dmOldZC80Iy82wFlzXhcOS/CV5ZdGWPi4NutlnWxkArBRlPgJE6aqMAqKuM576T4ogGO/9oGSoVxmHggUNvPwC8aGVpmjC3R3eSk5tbZYxl4u9LQ4lOKFKlPoYT7MLBMq3Gp7yubzgd7jtn2pBfqlnx8y7Rlmsho1+wrhs7wRaxciNODb6eJniGHmGbLGfJaG+E9OkgdWan8ud5zFIV2O0L9Eb/sCpX9a4rPAu9NGd5moHVhAkWTJQu/9kPGW83FZdM567uLTZW5L8Hk4dsYs555Y0s++xlpLgY6FaipQgiPpVS7bc6670Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tULpY+cW7XkE3ZxtZljbsS2zumIjy42PnBJsSfOXkuk=;
 b=Mlrdtw6+jZ81Uns/Emzgm0cZLBrZV9rxD0ibyVGlzw+UVIw2uTEIDuWXtTYcTyoeLh3wXis9YV2XFTWVAqft9EBqxnws9ze2b4a0XhfRpydnouN7jXHx3siLEpHSznTTe8sB92mKcZR4p3jmz1s4HPBWzOrc8cgyKLl2r2Ho/eE=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Fri, 17 Dec 2021 15:31:56 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::34) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 15:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:31:53 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 09:31:46 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Only overwrite serial if field is empty
Date: Fri, 17 Dec 2021 10:31:30 -0500
Message-ID: <20211217153131.321226-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217153131.321226-1-kent.russell@amd.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc03d1c-c7dc-4821-bcc4-08d9c1725a6d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0091322D25528F62B87451A785789@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4svFWycsQcSXzycWE0voozeVrwQ9oGikbmXFdXsGetcmU8q+3Vpm68XVryB9DZ1upxuc/FaFhxApF7rYGG4yNIM0HBYQktO3q473hDjrPY9MaZPBvOLva2M8fW1kyzsD4RO1g3A1y36xlqna2mH2anbSqK4uig5qhF53zkxVVoho0eBBYHTWWH3WxI7qzazpp/IfLG/QDRxMn9PaDhX9++59uVunsJBEKLKjnJDIXxn94E3sxEclwa/hHsgJNoYlw7VLDh1AKmB3K/uyNS2k3RV+ngGq3ACOQJxwHYGcgGoeDyzB3ace+5LedDeRO3MlaW2adAnItD3kcYKDbnJxZWcOW8eSCfigN9WmR1lsD2pEgzs1wR/80ok3s8EErQzJ68dHdapl6XWy8vDRlqAF6IpgeHmiy3LVFy1Nk+SPnGrPfpltCIWYt67dhsPhvkqKkQdPc/1st/3hnj1Vizax7dFnkKNDsQbCJ5ynml42KcAAwc6MT4YUkmsYYDa32UCrONbjXtmPlFLfnV3pbWiLat+/EXsGvuVBBN1DVxLrUYXMgKg7xzBxiGNk/d6f2p86gqas5X5Zqs+FbWn9rAfiVcU2dP3dYWx+raUnfT+RRGHhBB8IIbQ9HHgcd0EJiOOcwMc5SG1S8uA2xMVs72uZTclZ8wM8/+7n82wNeGbaKTCBkH+RrNGj1JjaneQ2ZHvvoZlnvICCiEKoSHtjliKw+2hRN1Phd0C/h3QAlR4uPj6jUZcZDAsJck5Aw4CNDN5atrHVmSeDVdMyf+8QQ7XX93cfPeD7Fzp0e8OUer36ys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(6916009)(508600001)(6666004)(8936002)(16526019)(47076005)(8676002)(186003)(44832011)(36756003)(26005)(70586007)(36860700001)(316002)(40460700001)(86362001)(426003)(83380400001)(82310400004)(5660300002)(336012)(2906002)(7696005)(81166007)(2616005)(70206006)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:31:53.6341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc03d1c-c7dc-4821-bcc4-08d9c1725a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Aldebaran, the serial may be obtained from the FRU. Only overwrite
the serial with the unique_id if the serial is empty. This will support
printing serial numbers for mGPU devices where there are 2 unique_ids
for the 2 GPUs, but only one serial number for the board

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..5b9868011f4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1605,7 +1605,8 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 	mutex_unlock(&smu->metrics_lock);
 
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
-	sprintf(adev->serial, "%016llx", adev->unique_id);
+	if (adev->serial[0] == '\0')
+		sprintf(adev->serial, "%016llx", adev->unique_id);
 }
 
 static bool aldebaran_is_baco_supported(struct smu_context *smu)
-- 
2.25.1

