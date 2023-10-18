Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA1CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573E710E3D2;
	Wed, 18 Oct 2023 11:40:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010F010E3D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnvHo+gQDl/7pvNTW185sn6gd+gE540paiKWx+VsMtsnQa5O+VtmbCblP3Zik7xmLPIQ1Hp0Nto2AcYW0Zyfk8mbJv+9d126wXG8L1sAPclZPyuH629HnRRyyk3ge10NKl/WuLzcBqmkpjg+lgUrnf+MsM4xX9epkDArpT6tVIn45YAkRotDxumNURu57fLoqMklnSyveJ+ks8CAd5z5Xc+S2YkAW78sNSYJQx/vncpaWAdKJPUTpLtKoo5s+fQJDIL9fFlXtBb4sOI0+FE+np8ROba+hUhc+FlmXzEkDbS/6U5xHAbGvwP1yH2CS/WhKsxy8jO9X79zehiv7LxaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzif7wlWy7DAiSYVyjZWGRASlDDf/qYur3UpuD/RPcI=;
 b=k8uadEk+k5LtexZIh2ojJ3ywc8vOvQN+6Ni3Av0gE8reFkaktAZjrOsxGCaei5oa2MsoTd1VIn8LFwukYFBzSDm1ERvkI+wKDquffVZ/UX9R73/2bwj9F8AM9qCWo7haavkWKxvOwz0yD5ifq5wMactRFE+3yOi6NdLj9fI5cpEx2Q6NtBtJhAUa8zTGmQ9wGkHIp/5pxVdCYj0cGXDIlasl639oK/6oWugnAAsyyK+CyKUGPm9PlI8zbatwL1ot0h3VaJirY6H2+8g60IzdxO/IzPzYRalcFxkoF38JSqhmBwUm3rG9vkeEb1gX83tH2rMfzlxevXQiqPiVlI2LDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xzif7wlWy7DAiSYVyjZWGRASlDDf/qYur3UpuD/RPcI=;
 b=d4igKixS0vk9YzrvnWNw7pL6pXHTAEspXvh64PofJD4UInRXeDEnz3RykAu3/NICNi6LR0PikVgUJndg4uU8Ky8/TibFVcckZZgm1a0TcSRJjtn5OJtX8m56FiYtlZF963/YSTHN6JMxYrI74md3+WYMAwV/audsOe8b/CWzlq4=
Received: from CH2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610::18) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Wed, 18 Oct 2023 11:40:34 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::5b) by CH2PR05CA0005.outlook.office365.com
 (2603:10b6:610::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 11:40:34 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:31 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: bypass RAS error reset in some conditions
Date: Wed, 18 Oct 2023 19:39:56 +0800
Message-ID: <20231018113957.20079-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231018113957.20079-1-tao.zhou1@amd.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6f88e6-4b55-45d3-c6ff-08dbcfcf0a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fILMDYuPrs2KlmwWV7wSr7UFJbDoQ2qrZ4DXGEaOU9G2vgc5F0pZ4sxkyUSgNHWriFRfM407SmHgVcf2UdXjlHDSGjZ7IcSTzBZjCG3kuO0RopEgC6Q7ltH694TbcPdJNliQL4Pwwum7NxkYc1qo+MTrPjw6MFxWzDW3qtrMUHbbiHzRhR0+A54rtW/gonXbGrn1NZK4nqCz6W09xoV2Lzar5wntB7gCvkBL+vIcKXroOPK1/8yozMC+XZ/he9WLIQIBGIrIbsvy6QxohJWA0SMpFoBrCn1W5wdtZxIjt5DzZQotiZoe3JFc9xoL8piKijg2zic4jlp/CF4rGnnkrm6R5Yrxa4Xj/JRn9V5Kw8NpUWaKneF66TeVPOTnTP08kZJEya9Ibhju/l9rqpNXB1mz+H6ua3ZQrHJXMFNWXZLQtWoZovEkJ1tNa1giClGxURV2/hdoUOQHWiSXcOPwyugllNHXpliNh2m1VzeBF1wBLXeaFl8j6Lwy7e0QiW2C6NF9XPdt82DIQKPNKol5odeZYvJVDW3Dlzo73N4uPEl6CVELfcTCDWuGxcUJHb3/EMJTu1uSqDoUs7mjvkkektmYpRrWQC7nY/urH86irDbhfCVuyZknWtdZ+/wAz8frI6ROc8ltK2qDyI2ip2O++PAd5WqYq6bhUs5Irkx68bPYxSWd3gbt+QSShR5ReUqPnJ8pdUbdnpTYdMeVk4AoLv9uTkKCs9bLNedjJLxL3XwASftEWqLWpxiOqQeEURYoiZHcacpRhqENKpsJRqjANw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(40460700003)(110136005)(316002)(6636002)(86362001)(356005)(82740400003)(81166007)(83380400001)(336012)(426003)(478600001)(8936002)(26005)(1076003)(2616005)(16526019)(6666004)(7696005)(36860700001)(2906002)(70586007)(70206006)(8676002)(41300700001)(5660300002)(47076005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:34.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6f88e6-4b55-45d3-c6ff-08dbcfcf0a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW is responsible for RAS error reset in some conditions, driver can
skip the operation.

v2: add check for ras->in_recovery, it's set earlier than
amdgpu_in_reset.

v3: fix error in gpu reset check.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0eb3dbd9d548..95c181cd1fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1178,6 +1178,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1185,7 +1187,13 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 	}
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	/* skip ras error reset in gpu reset */
+	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
+		return -EOPNOTSUPP;
+
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
-- 
2.35.1

