Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB91CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B026C10E6D8;
	Wed, 22 Oct 2025 07:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g39wo1EU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C21910E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6O2mU2SYR2HXqmimsf3nUBEZBLQ7gahIDVpRA/LD7r+9+eL7l/cfvd9v1x1e+78lWI5bnxo+HLP/6/qN9PZDNsP+qRauu4iqLTU/rHYd6PRts1+IGl+3/i9rwc46zhhqgrkLMVSyR6K4D824V6r8jb93B2+5/zF+uivQIXsmBELkAHvgI4pJ4oQGye9cKR25E+k1RntWTR/mhIYxCYJlDtjBrbSvFwuAcVFo66qJ8sbK3X4NAVUW9OpbOXqYKKDJf2xcjrPJ1lL57IdjU/2ctznRSu2qJEXMlaNtbWZW6O+6lVw7WGcxQhM+ZG2EGZJRXZRa3EP5cWq4TtK3cNeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsiIS5E+7WsEvir8Vqr5V8zZ2qv59nnMARz+0TWdhP0=;
 b=tyE4NadvhiwW/ECsTKEqNaTfrRZ55828GHgDFcUawo/tM/YuwDEkL0pNQygEHNlx9PW6NTMQVWGunmE8qYRes/nuGPlY1yyyjQqs4sQF3Q4tv7hervnpxRFD0feYOWa7s0waNUYGi2gQpPYZ9Z1oGkXZGKeAYDH7QuXTGOuRFeE4wIBfi6+h19+yWprUWYPTmND24IqYCUzWJa8mVYTzk1pHf0CCTPfVNos6bteQEbVMu1K0uuTs4Q6nuYSq0WlvZpBmcjzvPMcrtelsY24Yswu2U8Cxok+aQsH2hxXLHwHJKc1C2BDMBMWokDHMTUJkLT1+OPuIa3BhL77ngKMMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsiIS5E+7WsEvir8Vqr5V8zZ2qv59nnMARz+0TWdhP0=;
 b=g39wo1EUNzc21zEUc1fw1PW5ZUptxjmcILvakUFyOCCYDLAhAr+xfZ3o3hF8n+PeNFwaltzlE8suBIe2wFuqUYKiP353Nk3SvF69Ip6/YhZDBMFUEr3I3ZeOXpmMNjqJzUtwgRAn1GUks6lSB/q8zGnoVrAGikmddlY1nwKyTEw=
Received: from BY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:a03:1b8::43)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:20 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::8a) by BY5PR17CA0030.outlook.office365.com
 (2603:10b6:a03:1b8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:19 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:16 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 06/18] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Wed, 22 Oct 2025 15:30:31 +0800
Message-ID: <20251022073043.13009-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: d4032270-08ee-427e-1d8b-08de113cfe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1E+y4ZJJlWNWdRKNBAWFWN+KYbAhvHj+T3i2UflY6ipljid/hjyX/6V9F6a7?=
 =?us-ascii?Q?UXijgPtchghYsMSBFqZw7kNu2yAAuTpBZeQmNXavYLKoRWlOUGBAczDfwpSr?=
 =?us-ascii?Q?ZzTqAVNv5s35cxQDA52Wu68SPtibTLYCEXdq496NEHTO0Jwqfbt3ztnJ9awo?=
 =?us-ascii?Q?Ok9eiTnm2S3AnoUpIfR4o788jtm+kZOKIBJ8278OUS7ZbrNBcTxX50fSzyy0?=
 =?us-ascii?Q?KIwbUAVjtaVyBKxozlEBBYxEog5v+XiK9t16/d5cOK2kw1FwjdoIwLstXnLj?=
 =?us-ascii?Q?tTzUu1zJreiOEN8xwim3eARJUBNg3pwmFASFU0WOx+xoZcomq+suDkR1j4cv?=
 =?us-ascii?Q?LU6YwO8/GaWdCsylOocx3Oe9S/SAIkWmKT2SyblepUuCtICwcd+F75GzWJEA?=
 =?us-ascii?Q?EJ4KaWrBcF7z1bjY9QcEDO9V/FuAxql9FbAetMXEsZStYdLKuyBptnxfK+L9?=
 =?us-ascii?Q?4Ek0lKZq4lpKT4Use1SV4UC9u6LJGXcgQ2+1S7vO6Q6sR7o96SexUO6kHlEB?=
 =?us-ascii?Q?9VZ617HMNI2VVKSHnKT/SXWubBvuLAX90s8+TG8xt6DXEh3AbvvxuUCjlSfF?=
 =?us-ascii?Q?uoTwNPvUC4Wepb3UDX0tsQef8ReH0PxG1IGBuyeT8rcEYj+agiz3mF6qfYOp?=
 =?us-ascii?Q?XBsPRSNkJ767/kXhBZJ3bln2UqB32z64CgbgV5bWSkgpBDkZIumq1xY+nn6Y?=
 =?us-ascii?Q?D5f59ksRy7OZ59JiLaJzsl4BCwQn4jr/aq1/obBMRRNO+ij+jwECGfDjh9nP?=
 =?us-ascii?Q?73mCNOdZCTLYusvZwrbR/7YD7U+5lp26u+O4HO2KOFLzbEq9U1BQBl4DZeK7?=
 =?us-ascii?Q?Qak2Mr0IYAB9kkkLXymZCw2zCeBTx4QFkBSZ+fNpEQNfoaqi4bqFRTRTxIvl?=
 =?us-ascii?Q?CfTCrbjJU/3rUd8FzxHt0QsPg2mx4ZKUP2GW8vgSsYs1Hm33c1TzCEk6UB3b?=
 =?us-ascii?Q?GDHAUnyvVXr3QyFOTfUKwveyezLvWhOLo9OtpKVUxV+Zv3EJQGmyOOGUDeSB?=
 =?us-ascii?Q?jLLEsaQDzEqP1WWrowwFf9RdJXTxNORKUwhqlJTDJUaeCkTqmCi8+NSbjHZF?=
 =?us-ascii?Q?rVYbZv2Is6rzexBmlExONuz8cREWVFcNOhWtcSQOsUElYUTQ0BneVCPYzS73?=
 =?us-ascii?Q?iPBUNhZuMNK1f5abHNs1jimBjMIeI4yDx6RNbvcNbiEVBdItJMK8lkAwRh3G?=
 =?us-ascii?Q?JGLxJUpnAkylKyMADkCi9HYB5+AkKCj85KGa1DNy1g/i/E11M08PZCTCLk4M?=
 =?us-ascii?Q?LhDlZQ4YmFbCn3OEzHFJ1HrmV6sw8PPfquUZKR8eNbiWqgUnmqefp/UjQ93b?=
 =?us-ascii?Q?hDOKO5BSl74HNT3vYcno0aZ65HNLygE/YJZUD9s1dVwq9lVoAuIP7pyVGXpn?=
 =?us-ascii?Q?EEzbOO/dFiR81Qo/UYTK7ygpAK4Ch4OL5mRjWobGYpsffqCSlB3Y4dp2jzSV?=
 =?us-ascii?Q?V3yWMacZ8xDRQ11BwSqw+vsTIll9Dqao1fTLoFWKapqdQYI2Reoo24Qav4f7?=
 =?us-ascii?Q?gpWhSmueda0fjBkFJFVK8D0SRbZ9CuPWZ7rLz2g2cMaHVHUul2DTtfBLmFtT?=
 =?us-ascii?Q?ELHSdHKDAAtkGqdNizE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:19.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4032270-08ee-427e-1d8b-08de113cfe94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
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

svm ioctl should only be processed on the primary
kfd process because only the lifecycle of the
primary kfd process is tied to the  user space
applicaiton.

Another reason is in virtualization the hypervisor owns
the primary kfd process as a privileged one.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 158e75975557..58d90bebdff7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1718,6 +1718,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.51.0

