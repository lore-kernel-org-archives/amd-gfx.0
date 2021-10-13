Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2901960C4D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 06:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2901960C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CFB6E08C;
	Wed, 13 Oct 2021 06:16:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689956E08C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 06:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkXPgMVOshlTfHAh7NR1cVFLP2Oj81hdZDL8Wuq2X2iGdVrF975IXtrdcoPNCqmngk8+vNcr/SRBXBetK/ty2UmJgh+CjAF0GrilRLm3K/a40lTlzfqUucxnldyBy0ICUu5eWw95Ibjdl6QMwxorXKKAkcPRkKG2/BQ86bBVigssHb5vpHGMeyncOlV4LrDnrBop/Ro9LP/7IYdZvp6rkAwJZDW6YS9/K5Pd2h/xZnLu/ozJyC8ZFZ5SE09SY4agOmqc2b1bzwTjdXdZ2Wcki8jf3X7xiWkO/ctpIBGzUy84426P6OjuWc0sgcFe84msKG0oMhfczy1IhCYHggYcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69cS4Fj2gQp85sx8N77IVLo3jQM0DORRlxBeKdTMA/c=;
 b=aZn9I0XkKeZ2FOS02lMB1VfkwkZ9FtehkPv3HunIGoJuuhxWLx2scosFTKki5F0S5T9NZMG1x7zmHmO785czI003ub+ByfHA1suCQLvmI9nUQB2E6Z+tNLbHYmo4gCC9qmjcdPSDX8a7yWIg6uU+199gHcf5F6cWhhzqoxS0SJHeXn9UqHhixotHYzl1eZOAK/WQM8aMIn0Y4DCAodtspt0VLR3aTBW8saVY8gViXzEJugrhyEYHikcxEWty5R7udH86lMlab1UE8bZ+kNjX8kTT2KVnV0Jnv9dz8ZpkGwzXzu7vk+eZL0IJJLw7CBLhbUehw+AIYh1zmHpf8DlWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69cS4Fj2gQp85sx8N77IVLo3jQM0DORRlxBeKdTMA/c=;
 b=G8Jf7Zh38Go7Ea6BU8Y2oA5dEDq2AT6gJO7S3IlzSt4SBwvTWlWGKC3XhSlg+Cbhd33wSXrgr23aMPLjZMp3ILUuHDfKbQQb9luk2WP5LD0boiidEAkITyt4aysNfVVVux4BalAeb4sI2LM/lqzTi20qNCewkiXatGanFUelQI4=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 06:16:34 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::cb) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Wed, 13 Oct 2021 06:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 06:16:33 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 01:16:31 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <James.Zhu@amd.com>, <youling257@gmail.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: fix resume error when iommu disabled in
 Picasso
Date: Wed, 13 Oct 2021 14:16:04 +0800
Message-ID: <20211013061604.3404343-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013061604.3404343-1-yifan1.zhang@amd.com>
References: <20211013061604.3404343-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3969dec-9339-4597-f011-08d98e110130
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-Microsoft-Antispam-PRVS: <SA0PR12MB451039F9173112B42232CA2CC1B79@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyFbEzkepDfrHJCz66a6CGzNUi19KdSUW7fQs6ShJ3E2uyXRDSBnJd0M3D0VMfdBbwfvzphKy8xwfXw3bhC+XBymbyCmrfw6dC8VjlsnRQEyg4N60JEaNSr/qlo2+jgtOSPhzeRCt8KsjYK9FBDgixiLYmWF0nQo2INTHLlBrEo4fF438rvCxTmP2EtvJ2ZpiRD7gNOWRYctwiUKj4IBYcFuLu/kd/sJdHgGKJNbmK2lvqmT5DL4+d4YgjdEEnHc0SeRHbAs0W04/bMRsAntDGuRPozU4mTyRkcaaaPAakea8UwX+yfKZA24lSzCfPrlOxmepH3h8PqH/otR5hSURWamaRxC5Wej68p1ry2BDyC2jFL5T9+Clgv0c3PwVWvq2OBi9uBOyUncTBENNjgvwXfD7pn19+a7Xra4jRr/6PdQLzJGFe+rZnfRUqqm+RStR3tyeO8eecjQllxY37g6CMi1CrXXRLPITpKOMbb8EM9Pa126c0qmoJgi6lXuN7mc7/AjDmZnqlQ7gVuPdDXbbHHkPPypTot+WRcEbVBswZQnx3jfGnkH6urO7eoiYI+bb/b1XBaReQDeDyRRE9PZ5lNqvToWXFHuSW8mO8oaKU5i2z/D1G1XFmP3wD6UzJmMcbIZGaELBKP7Mnb7jjE/MaKxHxDnyWgF9uLs+Z9GOofMyVJjGXAgL8V2kw2Lm3BAtCZXMdjGosX5docMk/qDDZ7Pqg0zSK++1z2nLxABF4w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(1076003)(8936002)(36756003)(16526019)(6666004)(82310400003)(336012)(70586007)(8676002)(83380400001)(2616005)(70206006)(2906002)(4744005)(186003)(7696005)(54906003)(36860700001)(47076005)(81166007)(4326008)(6916009)(356005)(508600001)(316002)(86362001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 06:16:33.4774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3969dec-9339-4597-f011-08d98e110130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When IOMMU disabled in sbios and kfd in iommuv2 path,
IOMMU resume failure blocks system resume. Don't allow kfd to
use iommu v2 when iommu is disabled.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 08eedbc6699d..99d2b9c875ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1021,6 +1021,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd_double_confirm_iommu_support(kfd);
 
 	if (kfd_iommu_device_init(kfd)) {
+		kfd->use_iommu_v2 = false;
 		dev_err(kfd_device, "Error initializing iommuv2\n");
 		goto device_iommu_error;
 	}
-- 
2.25.1

