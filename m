Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A500BD6ED31
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F03210E942;
	Thu, 21 Nov 2024 13:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+9Dewej";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEAE710E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKIJ3WNPPjEEB2lTnIgbGXDncvHweOP4ucdoq8qFcvp/Un+kemcbeacX9u3OG42l5Ea9mJe3lDxdczhxMvt3ZXAZLLqin0T3pcAwm5BkfNecv51vftguZzLJeNhjx2pH819XHtlTQrzpOoZwVbKH5biEK8SGGgFlKMVnTbKLUTX0culc2nGzw5ruDkY9qc0eahhrKovbm9y2B2/DqIA0uNyqmXkQo40g8tP5L7OW6Ace9pYKP4ShLtHDGDF6o5Wy7GlZGvo949shWNvAs0DAahoXu6b49mZimt/lj40rg7rVJ1k1Xn56upAekH/qN79T103TlxY3lmIfZHnm3+0r/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDqKqgvxdnXKsEE2qjB9SjMyOpV+lV1fpi5gSezy5R8=;
 b=L/5cyV9OAUTNapbpjEZqW5noZo9kudy7mejGZbIMp37MGYa5RoeenhXPGNYYmHHBl8LVXIbUChuphIclUTPJt7Mb07pO+cppS2R8fZlz+q7cgFRaYe32UdXOsO5Z5K29Zy3jZ5i2pDTWPCOphx/CS379ETgAW2Hg79d/6JH5shLCwpLweHhxK+0r5w1nR13nmqf70aqP+93QPLJKvastuqMtSAMvv1YpaHmSuVX2s5/KfzpqIKjBmXItAx2cPM6pys3f65Upve++fjWRRN8a7MaKuGz0ComVn9pELytL/rJlby235CiBqXGBC3dgzPCCQNn3fGM9uq+np8Ic96LGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDqKqgvxdnXKsEE2qjB9SjMyOpV+lV1fpi5gSezy5R8=;
 b=g+9DewejpY4+eWCO2Jqywyr2Ts1ECzT5ntos6HFOy7hiwQ3BGzOJjnsPSpC5AaQVMYQOK8v9MLxYsRIAORp38AZFHfqKhjv55q5AxWyXshCfKKjRuq/O76Srz3YbVFU8Ya6R5ASySjRg7RZBWfjRIRUJFU/2+KyCZCy2aYTuJT0=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:33:35 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::8d) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:34 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/gfx12: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:33:01 +0100
Message-ID: <20241121133307.594-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: de4bc583-b819-4346-5213-08dd0a3119a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L+NWoZzmUOYF4aBa9ETnpVk2Q+lzkUfFihJluI6mdz8WzZETpKHjdTiAKPHb?=
 =?us-ascii?Q?ZnkTqq9gDeUVhPsK/QFIKYKC60Xzfn6X/59110RlXIy2NGLZpxkWidgbM/gX?=
 =?us-ascii?Q?H8j1JQmk/SWVSs7qKWs9YyTAKmPWLWsWRc/eXmjkJ3tW58nOQYtLY82Mddu9?=
 =?us-ascii?Q?mXAykUCB8ky0t+l7zoR25lT611SeHygKrjB2pt3AXfvBRrRQpf+NkKSryfTP?=
 =?us-ascii?Q?Bsr4e4BSE5XxUBlTnqHBI481QULDxEQ4+akkMqDhkAEcwwiJ2o/5vhriTA6A?=
 =?us-ascii?Q?GeRWMKIYWsYHBCma6rlJx396k+PODr22JUzaLNtIMOgRemwM5DRTWv+qTGXo?=
 =?us-ascii?Q?V0S+ocbyJdzR8OMGGc91IItzlnLykR6JqQa2cOVTbeSSuLZTZTZ+zMcUU7iO?=
 =?us-ascii?Q?kUsWAwC45JOwbmnzl89gwp127eW3WC4KnIpZrvAxXclTQp1hSdYaLRguEJk5?=
 =?us-ascii?Q?pFXMbPQeMkgMIeNRwHPH429LvpPn2wZrGKefXG5/t4zqot5XKZj5FDCbDuxA?=
 =?us-ascii?Q?uWeBWYPj1aGJebNQq3/7o9iLCj/Pc5SdMc+1PUdD8945NmP1MFUKZ5GVSghX?=
 =?us-ascii?Q?QpPCJV/SfvhXmHHY4WoRNv6a3KmJmDvQYamZeYE7uLu/qhuCXC3rMmC8eN2y?=
 =?us-ascii?Q?EYdNooVRe/34hc7280mmFhUjQQy+dBKvX+yhYtDWNwRexaIEIohcj8+IlGba?=
 =?us-ascii?Q?R+EgLUXEH4fd+ltAlVABhv770GxHvjJd4D1TnaDj/XkvGp4uDY8B5gl0Mp+Z?=
 =?us-ascii?Q?coJwGmhp01DYFflV3AQAbKa/F8qcBsAotz9RLu603hpY/I7Z3pRiLTfwlM3L?=
 =?us-ascii?Q?wu4P7U9SpPPtsiofiJmHCTnvrGL3wEUosrwnT4nk9n66KVzuboThnw/yxPHP?=
 =?us-ascii?Q?rBaUccHl/KPWE/cYKBMKXlhNCNpFkCQGRDAsOvBCpy1J4nw8+8wstsC0QnBn?=
 =?us-ascii?Q?3lKOtfUgj20KC1NF9cE3fKhQlcsHdRbGdS00LdYkVgW4Ei2t1aBX/YMjK5FY?=
 =?us-ascii?Q?Q6f6guwuM5yfQX+J0MWEjrwP9tmQnu4JgtN8WpKPZmWUutmJsOQvpjQ1vSHz?=
 =?us-ascii?Q?0MZHQLKvq+YDauzxaNo9AtIt2T4I7ikQgaSOLoO46SttL2AX7u3lSBbaXvU/?=
 =?us-ascii?Q?oDe2/biSopRWsXg9HRbPmFsoH1TJpgglHEJp3Rx50QvCZXA6OKF2covFypoL?=
 =?us-ascii?Q?funeme0L+1Fch1MMGhVgMJqy3jHkxCpemH6tJ1WOJvaOw47Fg8s9vUEGFnnB?=
 =?us-ascii?Q?zqnwFygWGGrwF1Re2fpfyrSqmVr0or/Z6DK9MbXQKkonnmXURbNDuOR4DMf7?=
 =?us-ascii?Q?TWiior+jX+Y5Okzw2y2fCsNS5g30tE9NgRatTN/bOT53mGRq3hlw94GdWaf7?=
 =?us-ascii?Q?t0cbr9smoDrDo8FtTaTI6+mUNPs65tZU/QYVhWtu0NH9oxo6gA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:35.5506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4bc583-b819-4346-5213-08dd0a3119a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower address mask (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 546ea709d43e..3a7532db9b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2962,6 +2962,12 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
 
+	/* set gfx UQ items */
+	mqd->shadow_base_lo = prop->shadow_addr & 0xFFFFFFFC;
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

