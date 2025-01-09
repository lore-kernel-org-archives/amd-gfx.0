Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E5E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63FE10E982;
	Thu,  9 Jan 2025 03:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yXNSUW5P";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F234710E982
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPrkXVvcntTCHbj6sX1KVSJkm6USlLnxp5XzrJn2g850R2fWLD9PcTTyrkiodpMjhYhHtJsR3NvJPsfAvYhAofcV6OzxL13/c4uZHcJLcZI7YK8Bk2eApNKR5tpYEsPT1l7Bp2p+fPfm/vXC5bk6zXgrzyvbaSAceQKmXD/7nVfj+uDvNGEVzXi6KGDDsjExabTdrv5AZONqtV3UvMjuiIaLa5ueJzkrb5WhOiB8Mwmz2jbpAjWVDQBd/mVqMr1753XhJKRvMOwWWUkAUC02o6eFvtrZP+eU2yLrxWvY6oxEUyxAXqQqahd91IYVwbJ7H+Zdw5UUf8hhLqsA4ilpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxBxYi0MTanmimpJv3HthnSJVd4VQD5xZ+MowtsYJik=;
 b=DS3YL5o8y+94YPGhCxz0u/smCuaKWRxXAAz1ZmuO+Dk7iBhawDz7TkZJt/Zz3M7j8rV9fwk4GIsCI6ExO/ARDK2c5VraqbTfDkhnXg3b7iJxCC0Xs105AfMZcEoKif3pqJEXOEB1Nwbtl+PdIkEKALtId/9VGXxF7e4/smok4pzIi1SXZSpBxE1Fn3B8Qrl0+u51Fa8/J6v5L7U2+cI95LakZ0DzAdZLEVAEG2b6ODmAq8tGLSFPJTlQ6JBcaf7Hvk3Oq9T+uxD/IdJdBDu7puLuj9/+zfh7JeW4CEiWv2d2LV6CBw0FzrBH1NqyqerxYy20ankNWY0NpWin0eBNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxBxYi0MTanmimpJv3HthnSJVd4VQD5xZ+MowtsYJik=;
 b=yXNSUW5Pe73FFci8QKYXAktpaKbq045BfjQn+GgvhfRz1U0NaExk469QeWp3TfhUfAfuJC4SqlnArnUmqw5vKy+8gcrkAyUtGE8qcL9EEnMpnH9Jra6XpIv8bdPB5wltrHl/Yf+F7i+Y69NOXdeQKZewU8UmZWmXIZovITcQAkM=
Received: from SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::24)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 03:06:14 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e5) by SA1P222CA0077.outlook.office365.com
 (2603:10b6:806:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 03:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:06:14 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:04:50 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: add support for MMHUB IP version 3.3.2
Date: Thu, 9 Jan 2025 11:01:30 +0800
Message-ID: <20250109030133.3887086-4-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2393ec8a-e159-4948-65aa-08dd305a93f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ENw1OmQKey/WoOC/vZulCuDLH7hx5A8/R0OykZE/tS6AOsFozXUTGvEBrT2?=
 =?us-ascii?Q?r3PaK+JRLcJTRYIuaXib/X6HpGCdky0csrHqme7970bv8i9g0x7cLgji2hVX?=
 =?us-ascii?Q?hfnGQVHgJCHNtv4ojx4w6IAmtfslA0nWsKZLriomWSCZTIGvGRYXmIZr7F3M?=
 =?us-ascii?Q?inAhrc+VOF7qCnmyaApK9+61/NZuAGRe/hqv292BovheBq8Qv8Vx5mH6uDmq?=
 =?us-ascii?Q?D6LySQ+nfMBGvwwO9vJ8mMJhkE4OoRS/l+sb7t/dkaAw0v/fmcWyYolJTP0d?=
 =?us-ascii?Q?K3n0QzBmfTY+4x/y27Wfn4/cXUszkaBFclD7cVt4JBJjqyWILWPEayeZ2ObE?=
 =?us-ascii?Q?lRohoNe53LtUiF86wiqo4899XL29ImeociOnuEA5zomBHdCsXompbVWIMh23?=
 =?us-ascii?Q?tbeqDrYLxqMMmjSh35FYPUgi1zMPA3p9AMqKXd+9deTew6UoziUCOmqq+mJV?=
 =?us-ascii?Q?gqQpJZ3Y4qiKVEiFBJhWbRn0IgTq+xjjQcDxbm3vW2WGaDNyZkC3PPvOSw3F?=
 =?us-ascii?Q?zXhT8rc9qq7Tk2ytGmKI4IG3D6cNiXylb3saAvKppnotQB50s2ZBkqoyJBcf?=
 =?us-ascii?Q?OaKyascSndwl09JBCNQT4DqZ4ETJkwaI+i9JbGD2IAUZxV2XwRUI3uaVte58?=
 =?us-ascii?Q?asEVwSxZrGch2CN4y0WXVEhzzXRa8rNDrVl05IRXdWNXygDDZXdnu0Yjck9r?=
 =?us-ascii?Q?uEbNIWo/kTGmc0iZABi4OuIQ6zO+P9h1+MQg9UBR2o/7dL9RJybM0F1cnYuW?=
 =?us-ascii?Q?lSy6JzxDF306WmX78oCuSEQ8u0WCDiaBzYEw4m2rEw3Yve0s4MQKZMqIjDat?=
 =?us-ascii?Q?EJKJMFwPYwJ5mYmlT4mBiiqiL2GaWYBkZTsRjRu2mh6dKSr+pJm1ugaL/UCf?=
 =?us-ascii?Q?3e09CKFZjRW57SGPtmqhbdzXeD72EG3EjcKTeicGiSKSzz2x5Je2X/03GUMF?=
 =?us-ascii?Q?bB6DsHbwhkWPLGQRKbKbwjtYT3I6YmceDbRHtDjWF8KY7IO2WGzU95KJ35r9?=
 =?us-ascii?Q?dvxOiAoBNsYbPIif8b+EvfmIShxQuO22bTApUrP2ilBqhc3qmZ94a7FsI1Fn?=
 =?us-ascii?Q?TTCBGcYh1g4/J9xCBYZ4N3WUfvfdabp380S5ikK1HBLDn79QQ1hF1LoOORtp?=
 =?us-ascii?Q?EAw9DcHaNA85eHO+j8RiSoStDFiWkiBBJNczaKkT9VMN8B8rCorbyB/Z//pG?=
 =?us-ascii?Q?plaeuPX7Y8yXV+cCBezUFSEtMRWlcZPEWBd3rrINglQcEn4wPowOOtF9bt/T?=
 =?us-ascii?Q?OgT+Yph4oABIH4Cgo0ZcGwcPNf8KKcaqXdm7+zbRJPay6e772NtWhahr2YSp?=
 =?us-ascii?Q?aFEGx7pY/n0umFCPDQyfBM3K0x+evJ/jqeHbIIVYhdK99/Kn7y9WzgkW0Ycd?=
 =?us-ascii?Q?TIzWE4uYWLZcPzgxqlDZJYslxBM5uG8bXftk7nFZCwRrTAl8uncfpBY4aOaz?=
 =?us-ascii?Q?2UHJABDlAN8b+I0NGZoI7+95NvlTQA59RfSRLZsGV9GP8nZk9LZlO65+50hH?=
 =?us-ascii?Q?99V8FMlKjrV+JpM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:06:14.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393ec8a-e159-4948-65aa-08dd305a93f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

This initializes MMHUB IP version 3.3.2.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 5047b80ab60c..e48b0439f6df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -579,6 +579,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
+	case IP_VERSION(3, 3, 2):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index b4ce3375d3fd..bc3d6c2fc87a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -103,6 +103,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
+	case IP_VERSION(3, 3, 2):
 		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
 			    mmhub_client_ids_v3_3[cid][rw] :
 			    cid == 0x140 ? "UMSCH" : NULL;
-- 
2.43.0

