Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E87C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 11:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBEE10F1AC;
	Tue, 30 Apr 2024 11:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pX3i/VwQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F288810F5C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 11:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmPXfF6ado4xkdwdwrofcKf3jXpT4iuC9ixRHwCjHSvJ54NyQLdMVyPFq4RZeV0I53bl6hdvqD+ZWFze64WnqtZrJyysohVrQ1++lXQrnDVQfRoHy+cP8QcJMqTMvd40kG9LAj22I5ZHdxUHceGaJJdD0mLj4b+5XR7OHUz6G2i/gqmAK0KirdAAutiDcrbG78chgqAWB8R07oQJBwn2oIV9gBbKhf5KlBzEqUgBiRxP+oc9wxVUaBVmmYd53GNWVydrH3i60Eec6vZQNkAXZD83WG0FQ14jVf4ppLGlQhmoi4ZIEFoJAMmZAMUhbUz8EhrMNzyUNVI1vNZ5sBA0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIg+yBbVl+ILxLvRSnSV4QAu+IO5gkpWvmHhv7ETgPU=;
 b=Xi/X9Wd8PCF+qKO+nGl7iei2KM71S9EPCPX0WOiKMrazCFXOTUCOUmmrKqoEjI5Lo2ETvVTex/Ww/UIzBRdaYgXS0PyO6zkZU6AWb34mKPbtbD0viRwQEv0xUaiM0eNtKQ/s7y6yxQAFWs9aO7n+ma0K87GA1pRGv56hf9amS9bzc0d0LvyTr2tmvwjk8vrtA+2T0z2+ugYiQlUF319BMKz+uS4rlaH/evMt0NQOxyX+NE6aHtO2wFMuoKWm/bYA4OEXSlahPjR1nEZh4KEcjpEjsPFXx1f+GUw4aAzsU530rf5woCeZLHELUIhRg0JbJF1V+ptVGlSgkIe1JOgcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIg+yBbVl+ILxLvRSnSV4QAu+IO5gkpWvmHhv7ETgPU=;
 b=pX3i/VwQDNDj7rJ7mrZ2ZkB+NLZW8JM/HMJYlAS+OKT4oxlyTZYxQJz1tvLoIR+hsv8sNF+1agC3LrRAvn1+Lluh29nPpUPo9cOJ3mWhI/iX55u8T1bftaZuYaaYWHxCiPsb2P/Skhfz8lNxk96wGuYo04wYZqAG0AJIbaEn7jE=
Received: from BN8PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:70::14)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 11:36:47 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::8e) by BN8PR04CA0001.outlook.office365.com
 (2603:10b6:408:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 11:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 11:36:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 06:36:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <james.zhu@amd.com>
Subject: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
Date: Tue, 30 Apr 2024 17:06:20 +0530
Message-ID: <20240430113620.322882-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b12864-6750-4b05-fd85-08dc6909d1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b94iSPws+pVvzVGkqXjAE2FJ9ciMGnFdsSw7DXooXZiFEwj0JFbL2Bkb0LHd?=
 =?us-ascii?Q?GZY9HLZQR9s+TF6LdiDM9sZ9b5dNnQ2AthShXA8FaqrwL2VLO46zTI9a0Pzf?=
 =?us-ascii?Q?UugTcF9Q4tUyslybym1SnSgNNmhbNYGSNSYuC0hLa9LNOrE4/HUMN+gpqRkZ?=
 =?us-ascii?Q?w9j6kzBHBQ12QDXD/bkHWsSlw1S3TpqDqvCTXW5FiKOHhdI9jAoRKurDbC4J?=
 =?us-ascii?Q?WhK3g+a0aqC+IfyiC37qjBATpgvKoyFb4KEhZE6pOAXQ2O3VSMbkpQlaYTzV?=
 =?us-ascii?Q?TW5VKL49Yc36DWkZ68XvIzTkflBqqoMjvjyVSebes2NrkzzGjZ+u4MF6XA1B?=
 =?us-ascii?Q?GEoedKou80UU7z7BwgtCVSi/iVXpwOk/Q2VNo6ML+QHnsyBjN6M8r1It43s6?=
 =?us-ascii?Q?AJk+ij27B1lvAwtRLH5XbH8c7W00luXcHLDKMLTRzDYohURVUW7RppxBF4kQ?=
 =?us-ascii?Q?8SgwIK85vTPQXBk8yKmBRzFN3eod53P+gKIzL4juZL4ucskqBnbWc5VyIOhj?=
 =?us-ascii?Q?TSKPr9UhOswSvr2vqn5QZJsDnsJEYVanJg6MmdZ6tRREn2uACJB3eR6nnd+X?=
 =?us-ascii?Q?QeOCbo++W2AlO6arQ+dqbN+CYBbzIGCrttDLuD8+yT+6XvJ0zY35Faqv9a3Z?=
 =?us-ascii?Q?60utWtNmy7e90QHnsOc4gmQC6uka2TxEBQ5uQajgGmFIk4kj2tt1LriMhOce?=
 =?us-ascii?Q?UxoP0kcFuU6MG1MyKGi6OLU/WZidMDAemPSQNYeYGzbOUZiB3+lF4t+Pw3Wy?=
 =?us-ascii?Q?VfJaZulRHFVU4zFmNs276r4+CfZZ7apeBAk1kf5+lwJ6AywByb3dZy5F33gF?=
 =?us-ascii?Q?qhBXsP9WM10IPBcYH4jAvD7G9IpGIHBKY9/W/rOWchz4+TjOapmHI1gUqRw1?=
 =?us-ascii?Q?wum3NZBx2LMQorJ+MPFsN/aZmq/1cXs2ErXw+oPSsJMSco++3K6xmtTjpodO?=
 =?us-ascii?Q?+uhlxV6P8s9MegTYYlJa3AdVhm/B5mvHlMrKo4kLS0V1FhKklHL7gD1AgwyR?=
 =?us-ascii?Q?F3BY06EFin02z9WHSOXYXgt7U2LCxfGmaZ3EkpiGb5yoBIkaQM+oHsGLNtVG?=
 =?us-ascii?Q?cs2Y+N+6NddVhIVG3ucEn2TNdPBCf7H1JPjigdoWCe2ZO2gtXCUcRA+tZLiL?=
 =?us-ascii?Q?iTDmMs0h6w2aWwb4SFl/Yl9UoIXjyeDvoWUyKQH7vpR6N4z7OwfptoHaDGfI?=
 =?us-ascii?Q?89GDpcb++WOF/NvgYz0lcrzTDVNpjCDMriI+yHxgpiDK3h7zyKzEN43hiyOj?=
 =?us-ascii?Q?eMWnhuM7r41zd1FI0Auuo4ZjBeAYN7+ENBj8hjlYuebsOQHl6fX0mD2t2JjE?=
 =?us-ascii?Q?S/ZUiseCehGtBPGExo4uwyzqpmHFMYXhF4mmjvsN+Psuy1sPBmgp6ycrhAb+?=
 =?us-ascii?Q?wXQiGBY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 11:36:47.4753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b12864-6750-4b05-fd85-08dc6909d1c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

amdxcp is a platform driver for creating partition devices. libdrm
library identifies a platform device based on 'OF_FULLNAME' or
'MODALIAS'. If two or more devices have the same platform name, drm
library only picks the first device. Platform driver core uses name of
the device to populate 'MODALIAS'. When 'amdxcp' is used as the base
name, only first partition device gets identified. Assign unique name so
that drm library identifies partition devices separately.

amdxcp doesn't support probe of partitions, it doesn't bother about
modaliases.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 90ddd8371176..b4131053b31b 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
+	char dev_name[20];
 	int ret;
 
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("amdgpu_xcp", pdev_num, NULL, 0);
+	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
-- 
2.25.1

