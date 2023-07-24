Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB2C001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 08:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CBC10E078;
	Mon, 24 Jul 2023 08:36:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4399D10E078
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 08:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC2GU8EItHH/QlAu2a5/FjJURsOgGxWN1580vpDIFZhiNtjKHWcLUx8Hi3MlrxbjXxIQ/FrQSmIsnm7JXS61Qi/4Vayg1DDYnQCGGsfBr2tdvc4vZRTbmhFDA0ujC3/ilzjiY62VnN1aaJ2ElRQ/SHhNvXj3seF/BNghKt35s6cKkYHOC9P1x9/TTs0WQttLA4WNsYs2xrwyhE0EYTo06SZb7+4suiowulNngwE1fDWcspByQvrDSnt4cyjIenJMeKX8yjxGjQsMx2znVwrdFvhDAKLEV4lbJvd4RmMHuq7b4PAKlHEkvZv78CLkJddCcJyhP30N6zA91FrAVofKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2r+AsVcufy8TbOYi5dusFC7+QSXeSw9rDZOvAx16/E=;
 b=DU58HMmYDwikXukkdWTjXnzKZ+rLLaCl/HMbsOJUNS6N31bEISLb6jyAJ9sUO9aHJlmnVIbRyiHLQWgqxDU34hHGT7fRt2S5rGH0Qbj/C0QZqTCmmPHBAV7WBvOLHFVUEaXfLgh2eNCKq4LzjyyngKwRsZW1C//32UCVmuonqUB+CZyshCuOKmg8CYTUR3mpLhdPZVgMqGsjk4JSUwjoIwZCa6BIU9PwEs+obgOd89dpNMyZhHgEUte/yAp15Wxk/k2bTpNEM1gxDPW0T3Jix4ylE4yw62xniP12+a6nDcQrXTBo+11n3MtzWYP25D4G6Oqy6SuYi//8EdqIq3o9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2r+AsVcufy8TbOYi5dusFC7+QSXeSw9rDZOvAx16/E=;
 b=2H4pxfZFHW6Ob5qds939ksx8al6WSE6Zin0bUr9ZKXMrt2T7GRRQxJSlxLijGxKUEsAF1K3WbQWPZn3/y5TaVL0uY6m6AFPRCFZeCJyY5eKzbDXONaRSQZZetHFRYFgCxLQdRGT78I292/TJEDkD3mMOtczFVRQ/OKaxcORiuXs=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 08:36:06 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::2c) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 08:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Mon, 24 Jul 2023 08:36:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 03:36:04 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 03:36:03 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH V2] drm/amdgpu: remove redundant variable declaration
Date: Mon, 24 Jul 2023 16:36:02 +0800
Message-ID: <20230724083602.454512-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8d49eb-ebff-453b-82b7-08db8c21058c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ee4BwUF8tw6Ab8QZYYZRBNkXXZQH2xgUyUOOhbYss03/No4c3YMeRjU1l1GOAcJ3yzPOUkm22T7uEVHsZt+dPcssXg0T8Uh7CQ7VdUm/5Qk4brvrBdAgltPV1OfSqYfNtfDf7I/ruqFWC3PaMt3QZCdb/fn96tQ0979Ies9El9bw8hXWOe1l7XX7kkIKGdWo1zFs15WF6HCjpjX51xzGgEkO5pCrh/0/JhzG+WGl4plROGrpyZ/kQhlEC7aWjgfm5OjK6qlgvET/LuW/QR/Ve9It7yAmESAV6odUHA7nJaaHmarehXdtWYUZQUtEgVcBy+sMeY1COI8CJ+hqzZ2xHlVVIOpyygWKNf8vzbLgxGiLFd8xZHAUUUYkQPX5bFnNc13gDFiFth32kr9Dz0VslFUk3TafclUDKlzd709EOfFRG6ZGQXfpAqbKjc1IU6T9OrGkSs3jcB8Ajlqir+KJD6GBf6KweqUyKqwQ6JPwEx4yKRCxYQcyGYG2NRXsHz6qXyBXUi4HPhPInbPMgsqAgVuWB14TKG5qYZB5vFL8kuI+Cbat2CiqDkj2A5exaM0NM6qL2qATWNv6N3LXyZmPTtWlL7F656Rkl7YZJVX2VD4cI8SoBZIz+4h70ewV5P2GGlBGJHInaIgzuvkpgNnlBNp/VIgb9w3DSXb+piwU/XMVet6k9eZktFgBbWaw1z1G8rn4oGK86s6xhdUAu25PjCoMvFTYMljqRaG5ug4oxkpjLF90STdbNXzTg/VxkWvgZpJXvGwdZwFhObNTGIOt3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(5660300002)(8676002)(44832011)(8936002)(316002)(41300700001)(4744005)(54906003)(110136005)(2906002)(478600001)(7696005)(1076003)(186003)(336012)(26005)(47076005)(2616005)(426003)(70586007)(6636002)(4326008)(70206006)(83380400001)(36860700001)(356005)(40480700001)(36756003)(81166007)(40460700003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:36:05.6242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8d49eb-ebff-453b-82b7-08db8c21058c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
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
Cc: Bob Zhou <bob.zhou@amd.com>, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

building with gcc and W=1 reports
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1618:15:
error: unused variable 'domain' [-Werror=unused-variable]
unsigned int domain;
             ^~~~~~

The variable domain is repeated, so remove it.

Fixes: d769528e4649 ("drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info")
Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5ac7544cc068..3f98174fb764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
-	unsigned int domain;
 	const char *placement;
 	unsigned int pin_count;
 	u64 size;
-- 
2.34.1

