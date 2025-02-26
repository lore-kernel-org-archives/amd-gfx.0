Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B8AC021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBC310E1BA;
	Wed, 26 Feb 2025 17:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQoWlf8R";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0436510E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnLHUycdKBgE2ZrqrRVoyCY6khyeuS8koPYGcrefH/wEO9ZTXgjxB8pkqQk8baGmfhxn7yIWK7sssf9wiJC7wxD309ywbK+zKsMH37Yq2G6/bQ5nJHOoCXwVKNndUHPIFUMhdVDC5SX16SrJBq8jmrpRjo0tpcNlimIzXy2G9TaVEh63mh/i/Tq0C71zwiDj1K3BTFPMJbNcPCftFwM2OIpR+P/n+GMd33sDitafQvAAQR4uv4ZYSu+EEpJw1vCDIrpZ4fNR5i5BGB6s8Mt3LznW7Y8SoIpbpwHAUdLJPGRURPiSOzhFvXEiyX+HUApbD3UenmuU0Eh8emYzkGYzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QFTzd3XhwcD8baJTJFIexxTLPO01LMU4fSH9R9m3ic=;
 b=BSMaEInJwhLJGvIai9N6bclkuR1eRp22+/Mb4wIcVMnCYMx6T59WMcLGyr2+QZb5EeTV7ccHKiD78Bc6Y8hW6yHN//WhpwU5KGxZK2kn59I5Zt68fuGfcTlAp4CcHgG32KCGMM0eXn6rtkiWWuCiH/jp+ZcQxv2ME9MGRRRMTkim7+psIsaLmsXLg+8xDyVlWz6yfxr8IXc9dnnkwGHOySHNRkNbpvnMYLCTi2Ma/NDpUTVXTEwmnfvZx7E/HbZfYry400voodZeuCE7tUuN5mcU5jxLrnINfOerReLGrWug3jsMiQ2PYg88KDIxuxdRE1voFj7iRF4c3xoG1reP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QFTzd3XhwcD8baJTJFIexxTLPO01LMU4fSH9R9m3ic=;
 b=bQoWlf8RQdtiFysWKz3gExCKd2UMifKO3ukonIAIHlICQSypjVrXBzrH9i95acNg/H0ECEJyzgnbnBhKzg28QYStMYUAXX7YT4Csl/MDDTb7WR9282s1c9ji3H4TNwy8JlLL5ri/sTpD0MBCp5hE2EgJnc422AApLUfnVvghUqA=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 17:15:20 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::e8) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Wed,
 26 Feb 2025 17:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:20 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:16 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>, Kent Russell
 <kent.russell@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 5/5] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Wed, 26 Feb 2025 12:14:21 -0500
Message-ID: <20250226171421.14436-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
References: <20250226171421.14436-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c33196-95bc-47b0-75c0-08dd56892614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uR6P9tIi8hNq6Xnn6ANIEfR3eW7XW1yp7VgDJy7ab4mErwLhaCo5RqCt5Fun?=
 =?us-ascii?Q?3cn7o4TDVoY6ym5SYnS6bJ4P6Rl0PHFGCdczDml2nOIDx6zZYzl/VK3bkxu9?=
 =?us-ascii?Q?NokEwBvsB00tF57BWIsEar+ZAB9wK5Gy6AP68RYp5U32aVPiDSX0ecrduXRx?=
 =?us-ascii?Q?JJxzXAZQ+G+b7sGJNtGMvD1KqGUrIqME5b5EVL/zrF8Q5N9wf0gxPjJFSn+e?=
 =?us-ascii?Q?JFen3wH6RsHH6pqG0A4he9oDoV7+cfUINrtpCftfw4bynV5f7ASb6KLgXSOZ?=
 =?us-ascii?Q?YmA7X/F8IovUM8jNg6sPpLu8Y2JP7y8iriE8Bvf7JwkQTUI7a/bgR3hVg1/T?=
 =?us-ascii?Q?T0y5xbNf701syllZ/4G7LT7MTcDcOqVn0K0DqgnkoFD1OhrGacwMg2AdQ8Bh?=
 =?us-ascii?Q?T6Ib8T1iCd26Y/Vl8nxedKtpg4TYAuFlvWlYCaIM8kWZPz1XK3BhI7hXfIGQ?=
 =?us-ascii?Q?OFo2l9v0cANFxwPMFBM0CHI+Gf1CzgtsPOe1EAkL8Eoz2hX/k49STonrtm3b?=
 =?us-ascii?Q?41uJ4l5k3O3QcTBp+rnDo6u+ecMiop9NoJ5buSTRQ34Z6WofI93ZhhRRXkDZ?=
 =?us-ascii?Q?IDHNGMn8d2F8yp3OmFiIVyq+sKN3jeVm62G7NV728ijb1+JybqWEO20fKpVC?=
 =?us-ascii?Q?0Hbfb/e19voDSpRyFUrqMe+f1+yl0ZAyDnjc4IFHZv9eXnJ6w3qcIqnP05ew?=
 =?us-ascii?Q?wUsO1+idJqMEQTnRGqYpreMzl2UgBnmWQUzxQDvA4QbE+Xl8YmekY6EyrG35?=
 =?us-ascii?Q?nHhoXv+f68zdwkbYSod8aEuTuA/FRckkGSRnBKRurcCnXwFYWBx6K8j+N972?=
 =?us-ascii?Q?tEUoDmFhZKfAiGMM6x1Da6zANVMK4wL+HnEhMOpqA19qmxiynaO6DqfkTvXK?=
 =?us-ascii?Q?JiLvfXRDfFYSvd40VDA1sluk1kJ3A2ZvF5v4gFc5CuUA7T4APmV6lRYnUhzZ?=
 =?us-ascii?Q?kCqvsi6mwLCC93kXmiaYADhFKXv+RZAtQOB+pyPIsM1AXcpl8Nd9DyvaK68q?=
 =?us-ascii?Q?dmDc/WFJy9ZLrNaB2wZ0XkDhfx2f1NgmQpbZR281HjyEpc7rFZoxW3OnPOD7?=
 =?us-ascii?Q?V1ApMXII86TShwjGdxpfHOSTUIWqp0Z3pvjrv35tpKuBHTjyZlPyvJA3Q661?=
 =?us-ascii?Q?Z92uAmsfNd/NQ7gkR1Xfts8LMGjY+6bm5t5I0SmTrQXxoGB6HDFmV+1jLX8V?=
 =?us-ascii?Q?a25NKa4KRsMHo0qxWDj1byH0Oln6b/JU/jJ0BSZnwbF6qmvYjQqqgczx7Umh?=
 =?us-ascii?Q?RdeeHiafPY3GnEVt6WOOhckFy3Voz1foq33gQzoFvloWWXm6u/2eGFJcIaHM?=
 =?us-ascii?Q?f375cwKutmyINIxHp17UGcaM2549ul53P//TZMoPnjOFIOdpun4akA1cnhVm?=
 =?us-ascii?Q?0/vydOpMY3fVvCyjTC0lmSJ/D7j4HjwE9d9k1dQRGN3xSpDOiQNUK9M51Fno?=
 =?us-ascii?Q?/KozAc+6NXuRBj3tgmDdP5e5pUnO3wHxHRXL0fxFuTkrFHYDYNASARYb7ECl?=
 =?us-ascii?Q?NVSRJbRuZZxiHLE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:20.4143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c33196-95bc-47b0-75c0-08dd56892614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

debugfs hang_hws is used by GPU reset test with HWS, for MES this crash
the kernel with NULL pointer access because dqm->packet_mgr is not setup
for MES path.

Skip GPU with MES for now, MES hang_hws debugfs interface will be
supported later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 095e73790dc4..b9c82be6ce13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1604,6 +1604,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
 		return -EINVAL;
 	}
 
+	if (dev->kfd->shared_resources.enable_mes) {
+		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		return -EINVAL;
+	}
+
 	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
-- 
2.47.1

