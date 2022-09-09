Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D9ECAAD3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 16:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5634710E0E4;
	Fri,  9 Sep 2022 16:51:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3968A10E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 16:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB/YRYaeNodesszWD4b4mUFCXUdfDWTPjcwesDzfCWN9N/DlvyKUnvgz2doHV7Dl26q+ukD5S2DCc9GRpEkTm1BAXDJS/gr7rSOgzwmLChRrhf1lCf6JJM9zGuYm+eL769A5/R+lYdpXzgTrgRd2YE6r9lLAaImOYDTTz3XogH6iGXaQTa4MUlKlHIvIJsuuijMD6t7ZHekp3Qgme4SfU3SY8zHluVGNwwST2JZL0FBvX1qdw/QE2acea1HeTtcYLrM1iCq/4OElHILqRHtvLvkbN0pdmCXXjRvuFHJP7MFt9MNCcCErB5c/6Ay1hrcN17vjicOCU8wkzpC6xz65Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyFLEe+QUBiuukqz/V4EMGCz4APkZK7UXAeis+AQE10=;
 b=O82nRVOKlwJjyLL04A0sQ/YwHsSl37I1Z8vmdHI9MSab7/mpbFwVtNG449DxeWxLqtE4lXr4JM4fCwNB743jwm2ucBmVHyhYRgsmA2X5uHbZZcp7nLTutG0ky9hcwRT9KI0KsYn3UCKimDAQHXf2PV2rB6fPmc8ZqzQR03lEgT0YP1ITHSrZwkFdfMMkFHRS08GmJOshClK9GK4iBHe5UXUcKWwDyIa9Fewc+j6S3TEqCIU5ZjdDvWywss4zonyZBTXF1JCWYWiuSaF2YZq5AVP4yt50W4eiZJkLYvBZTtGI4zRsWrIHxW0gaamodP4s9tgLp3/3bq31WgrKqoY4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyFLEe+QUBiuukqz/V4EMGCz4APkZK7UXAeis+AQE10=;
 b=a29Ze5SmTlke/bnE44Rlkr7RX+/pDQV8RPAivct/I+rIYabVShlXgknvxAsDUIQURZnNPp60sRzugSYTiCr0UMyZR1sJRr3mKxujLYl31g4jtE2gPzpS5mArWoSK3ZtmVXyWX/hkAXSJ8mcyJzXCAMkbWKBI7tVIx/ol7ldPIf4=
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:51:14 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::e4) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:51:14 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:51:13 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix hive reference count leak
Date: Fri, 9 Sep 2022 12:51:35 -0400
Message-ID: <20220909165135.24645-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: d9360790-d2c7-4e8c-27a9-08da92838212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcqEA/8t+xIhMhQY3tRwMzY+hfi4hXipJDcZAyZJmVjHOm1O9j3qqa2Z1qKwmuYa5L/+AdJj7FrEM6hoO/rd7t8+q6BMlvQDgUT/0Gn18Sckx9UjsN3C2J7goJUcgdSrSsSSP8qPXyebhevFON/22e5HC/bxbyVgS8hLVpojobPiVIDNuqkREEk82slsLn0sag2cNe2nEo447y0mb7OvLp/vDDGPgehWCrFFJ6EdcYweYv+MDgJrLtw6YHVJLYXV6W4BJfEPEFw9/4subf/4PjB80bi6PLmgRoftRW8OwNRyVGObJHXPO38ylhd6pdFqNwhYs2WFi/BVusaLxtFwij8UikvGgTQ/P4NOABdZpgEmFo16H8JZtTIEvVYPDpH9sITItrkStDU1iG1T3wr5jsLSvpPipz9Y4h4qr/SytFm/P5lEZ7e2H5ISKTNaUQuIxyNd8DxgEjIl2ug9Gz45pPkksLfiUzfllJVDGSe/NfWFo9M1VzLmBlCtaIZP8HcYQDiHnsk/hbqBdpnGc3GmCsQcQfreja1CGW6MZADad0R41BnoNRz5C5qwrCY0PdH17R5wnNj5jhpNtHLoNIpikX3tpEwXSKdFdPO8jjAtZoryZAHvPr2++GTgT2UwP6Z39KaKbjr78DOB/gtqihVPcCkjlD4gL8LwsZYu5wbO6EvxyTD/npz/Fj66Gg2XUxqox9GrshcH68hhptrw6/NVqKLSRWER6wfOO5i7mKCF7Z26u9cK2DWlHT77S7GB3eJeJ5KXm6pfT1pvWWX4XcoFtx5lQiaguuPqywAjDKN5FYX2FXVAMzBoL/CV/1HObOdKhWuUeXFfy/TkR+gD0HG+Sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(36860700001)(26005)(40460700003)(356005)(81166007)(82740400003)(316002)(6916009)(54906003)(8676002)(4744005)(5660300002)(70206006)(8936002)(70586007)(2906002)(336012)(1076003)(2616005)(186003)(16526019)(426003)(47076005)(41300700001)(83380400001)(478600001)(82310400005)(6666004)(40480700001)(7696005)(4326008)(86362001)(36756003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:51:14.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9360790-d2c7-4e8c-27a9-08da92838212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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
Cc: Vignesh Chander <Vignesh.Chander@amd.com>, Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

both get_xgmi_hive and put_xgmi_hive can be skipped since the
reset domain is not necessary for VF

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e21804362995..943c9e750575 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2451,9 +2451,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 */
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		if (amdgpu_xgmi_add_device(adev) == 0) {
-			struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
-
 			if (!amdgpu_sriov_vf(adev)) {
+				struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
 				if (!hive->reset_domain ||
 				    !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
 					r = -ENOENT;
-- 
2.25.1

