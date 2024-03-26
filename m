Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EDCC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 09:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC1110E199;
	Tue, 26 Mar 2024 09:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewr1na+f";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE4610E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpO70xgtmTF7tkiiFwm7HNy62csFK2Ukn2bhIEh1Bflj3xVBc59aVmI2PxwBw2zeg/8gRAzYagpPUTF7cUEeMOnPf8tB1He9oeTCBWZtZy6WqqqcwTjB3hi35516GT6+3hLLrEcgJGOrWYYvLirf1pAagACIYuMevDWpOJegOLUjsZC7LLPKeHdz7pMtjD2h204/VXMQtcs8Dp05U37lcepPyUXmBnPJ2LyuXVr2U8zOFqg7J7PON1kFKgmFM2/oSVlle1IErTl1ziwuvRg+owzPW8iznckuzpKTlfEgE5ocmelN7eJRSGWTX8iOr2hdze7hvwDsNJ+4JmDx38XUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyUHn+CI1UiBCtsOKKbvqURGqQfsbZbRIILh2B4r15k=;
 b=mjAvjvr6dBZwCHr8cANiYMtcNBYNPzwMXUTrd3jb905s6MiZNK7HOXf8uuA6uiZw4zLbElz/rsotYBr3Wb9HjrkccUVcirGz2k+iOasrCU4/9/JEAMYx0AT3rifK8QBHhIGIy03liWP1je+JA2jB62mV39H7iJcviXhM6tH6V+hFHRELjOkJt7EzW+lmrWno3n8UpzNDN6V7SnwiU4llHfzQJVaa/c4dbxEKLPaug+PbDA0tm6oW6y0OBs0DHFSasfU3XZS9DGgUM1mXuEFh6vnzwIj5POGAtVxTk1M+z+ObWMjvmQYKhTeqwp6gC7K8EibgkU8CnfhbDCRpaHaE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyUHn+CI1UiBCtsOKKbvqURGqQfsbZbRIILh2B4r15k=;
 b=ewr1na+flY64E6ImKUzaXxOmrAEpmXkIsCObpGgmRoE9CaUkrXnhHg2FOoMJBbeI+AfS93sQt5bIfQdLdZ3CDnT4ods0XGO8dW50twYNx8Cq8wewRzuZ97GGUr7KbpWBlb4oXAXk8NISP5fOEqaIeQ4wzhb9e2LjejdoNKoxByY=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 09:12:59 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::5c) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 09:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 09:12:58 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 04:12:56 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Change the parameter of
 amdgpu_discovery_verify_binary_signature
Date: Tue, 26 Mar 2024 17:12:37 +0800
Message-ID: <20240326091237.2863782-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bf447c-249b-4048-b6c0-08dc4d74ee34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8WF5zifboJTiH+A61SDVO3FKvJYp8G2xoAnurJU9g0HuUNgI3iKGHrsMtUiBmFDw0lHTReMboAi9/bXwp17ISo907GetvT/hl6Z7gaH3AQ4W6hHi2majfyWUbvfsAepx4xWphB/D9dZiXwugSeulzzGmyurrMIcpoHAzU8Mn9TPvQTLnXqsUVu1gqwXdA4qh1KCxlwQBzpwruuJuBexPpLkopolfjxwDQohBBDBj2rNPWLQqfbhcx9Ted662axqRSnPRCVQwF80rmlbzmJyTKSxJSgbtZtEkuRRbyxaI9eCn/2LcSldvv3dNruMVKOqAz+ML1QR7FtWRe3BwTLOpkwZO40u0U1mJV3S8QuIWxlnTnGI2Enq6GCvWCLAvgJUpijCKrESbjxfvAoqogMJ0PwtfYNlj80yPf0IoInnm9agHLcM8assKAzPPcSVzVczCJE4n3owyqcrGBCPUkKr2s2jdvqDnDLiGaaSYe5J/97Qc7KRIIuf7aYSwv6xvORFjG6oaux1jcN51FMiWRmj7JOLp4msPYPGidY5km0lggKFJV5aBf/+OWO8cC/kW7I5X7Y2FCh/IJ7+jh641LKh2D3HNFjYzuAgksEtLrYlMHIdK6b2+0Un2rIxJjWN2PkAfZLs9hG35IPOTVMHNwuJcYHoxTRr/lLbtIQEKC5Y3MSLC1NBi8u+Hbww8luOCRUIVhkH6gXlR9dd4HISYNrsFxF4X0eZgYL4IxqL8TQIunQMS5hlbFvEYcnkTPG/Vrh9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:12:58.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bf447c-249b-4048-b6c0-08dc4d74ee34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

Use struct binary_header directly as parameter of
amdgpu_discovery_verify_binary_signature()

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 230412fc4d62..e6041f0b72fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -334,11 +334,8 @@ static inline bool amdgpu_discovery_verify_checksum(uint8_t *data, uint32_t size
 	return !!(amdgpu_discovery_calculate_checksum(data, size) == expected);
 }
 
-static inline bool amdgpu_discovery_verify_binary_signature(uint8_t *binary)
+static inline bool amdgpu_discovery_verify_binary_signature(struct binary_header *bhdr)
 {
-	struct binary_header *bhdr;
-	bhdr = (struct binary_header *)binary;
-
 	return (le32_to_cpu(bhdr->binary_signature) == BINARY_SIGNATURE);
 }
 
@@ -399,16 +396,16 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 	}
 
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+
 	/* check the ip discovery binary signature */
-	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+	if (!amdgpu_discovery_verify_binary_signature(bhdr)) {
 		dev_err(adev->dev,
 			"get invalid ip discovery binary signature\n");
 		r = -EINVAL;
 		goto out;
 	}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-
 	offset = offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
 	size = le16_to_cpu(bhdr->binary_size) - offset;
-- 
2.34.1

