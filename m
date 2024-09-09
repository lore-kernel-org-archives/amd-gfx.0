Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE58ECE579
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 11:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF0D10E1DC;
	Mon,  9 Sep 2024 11:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSeFjI9Z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317A010E1DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 11:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE5QlHafL5Gbqvy0I8ZeFC+1ayf9NcX0OJWDaXMs9fLWYMUE/IiY4Lqm/77SIkX8Tgp+S7jMQw1IXf2DlrREE8l5k5sz4K3/ihb9AR4IIaTA1c+TRPD7FGAn6h9GJHxDNDwwONJfrn8TkFWRQkWZIMiJh+Ul4EC1xrJnUNCLjeeWMAYHk7Ja8t7Hol9zvsZxGrwWoXOoYxlhlR16+QdZHYOVj0InPsn0FVBcvg57nR8hjMDAqExWfEudg56ZEsCMji2iL+iS1XJpJDvmi7gDEll8+SZXOF2j44olus2mfTO5thGsltuVj9LL9msNsceAqC3HkJjZsw0r7zNLc4LI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8PxTwgaA1cq0QX9IQmHCMEEX77OaG8HOPBaYHuTgb4=;
 b=iEy6kvqBJ9IO3n/JF52sYNe/b1CU0yWWy/tkscIv1tAYiVHeH+dHdP2HiLAjK4u7jwVVYPUKB4xWihSN627vWu8LmBGBmU6U4NCcbkh5Q2wDCh0gKSmSIrvuVGLZmcwYiKrsqbq3Rq4ELUpZeGjapTFlW2WE17r1Se087hCWIZTboVvn4H2EpNOytyZHd4EfC27KejK/2PjBgyjMdUOab3kF5JU83A82P8xOzSGlCkc7HYRucxBemkpcNxURUXS2FsepTtnT9vVRBazIwDlV6XJ8nheunRsMNsFr1AFEW9vNbNjikg+iRtx2oWs8Bt/Ko9ajYF0Bmv6pT8uNkKHdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8PxTwgaA1cq0QX9IQmHCMEEX77OaG8HOPBaYHuTgb4=;
 b=tSeFjI9ZOUaZAkrPuyxf+sHzyAMXLg2dfsUpNK0/aH6OkDR53N5t7PqmvlXKhg8SUykdqe87xooZe1mqk897XcsWc6M7T3oDpyRcQ6Vs3BrExvWk/cwMuPwfYJaCpBxc/XIaYvw8v3K1THufPD3kdl+709Pn8+U/9aXsixjjwyo=
Received: from BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) by SA1PR12MB8947.namprd12.prod.outlook.com
 (2603:10b6:806:386::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Mon, 9 Sep
 2024 11:05:20 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF00016417.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 9 Sep 2024 11:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 11:05:19 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 06:05:17 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable RAS bad page feature for specific APU
Date: Mon, 9 Sep 2024 19:05:08 +0800
Message-ID: <20240909110508.19202-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a150b1-71eb-4a7e-5c7c-08dcd0bf4b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L/XqDYZcc9nYxpNt4BNj4JgumbhIkUlE3D6JkKkSE7QMYiapkUb6I110RgWQ?=
 =?us-ascii?Q?cWZP9E6cdE9Tg8gMPR2Q2qDkQepz6/y1HYgMxmnEzoiPDh1nNihqiIyO8se/?=
 =?us-ascii?Q?bOFPLCu/CSxV5ImgHX6VxI3QzkEQKx5JzdBJlFI6bXXow5ntsnyGoLfw22Q+?=
 =?us-ascii?Q?UrD2p0C1D3Yjc4twAHDvOqZP3bl81tli5fXF+dTdUJMx8pOKoLDXInIzVCto?=
 =?us-ascii?Q?uz+AzN78LqM2BqLtw6mPrO0OZZ2mvwsGAlY6Wmh7iDxQVeZ5469/7ujOIQ07?=
 =?us-ascii?Q?8YLg0al4BP5X9017C4BpfF90ydPk2tvxpHPpO3keVcNFnzfq4C3+eWXyzRN2?=
 =?us-ascii?Q?ydAPNwUDVSOHb0aXUF9+VdDyyHXpUSqLhVxNcxF1GDCXQjLeE5SThLs3+u9E?=
 =?us-ascii?Q?mZXL2YA5SCJJTcfr/YixdmXMiEbmWMW6yJqOFfvW+L/WvcwSWbGgrJ13awEm?=
 =?us-ascii?Q?D2Q+RcubY2dRr8RmnVcEpdZN6ppgfs+0mPD6PXEhU16yTwuFb9+4DswyXCjq?=
 =?us-ascii?Q?aMxhJ0CrBBAPNEFanD3oCahZvyb6f7p9x/vYqhWXkznM2gW360C89BAszo6U?=
 =?us-ascii?Q?YXGBkIyuIP/NGOklaRqudKxWxDe7k+k40A5SYkwREX+A9f4ERl3RYnYxB/4c?=
 =?us-ascii?Q?GYIq33wpzeXw5zCJSYiPL4vnN1oRNdCHyXqINfPgfqolHecGaHjkkTplINu5?=
 =?us-ascii?Q?r13xAoqeu/eYYXhU0wZbdKQg4idad0pqbT7tEKkp5GYf49jRRg/ownTijpAJ?=
 =?us-ascii?Q?hHbO1IkKUjvKYP8ni3xnZ0S2vzuX8Vh5g+P2ZJOTJiezYX1IbJEp/STkQ/zy?=
 =?us-ascii?Q?E4/SYhudu7zwGPz400XMVpyMb4efZU1JB4gtoMIT3+8WqW4O2wkv9jtCpdlB?=
 =?us-ascii?Q?yowJDfZ/cF3h7pap6SNyf3aYnmo1mqk93FC7/DSORymnKmctEY+oqU7Uj4DW?=
 =?us-ascii?Q?k8w1cxYtMPoyaJQuHQ1iwFZ2UTrcDEQIJrtRCHVu2Pbc1MDtXm5kJ4awM7PC?=
 =?us-ascii?Q?A0OiKy2TRYSsOI4Q0edqOLJMMPI5rMdjN4cFV5Gu2Q0fw/C88RQfzTbCP9jc?=
 =?us-ascii?Q?bCGJjT5/VSQVZIxjVzZDB0UqG2dVFQ9m7pU/M4SNCR1niprQdzWTKsdrrzG6?=
 =?us-ascii?Q?6uWaX4y+l2os2G3DVlJDkU8s+4Nl4fdDn6DmZDGzNEX8tOarThHw6XIhJxmJ?=
 =?us-ascii?Q?jJ1aS0DQHCq1TH+VX0y3j66bMnC1t6NzyhUl79rJJ7tojkZx0aPkBb/cEWfq?=
 =?us-ascii?Q?wNyzS8D9SzAz6eapzKrY0lh9aaYMrpSY8u3QU665Y4bx8xWrXHvD3IPLXc0M?=
 =?us-ascii?Q?54+lnX9a7DnTCTT2cb6Q+lKgIw5ljsCsLYGBBvGUrJLEZJrnwf4h38onIBZN?=
 =?us-ascii?Q?C1mWehRdooWE56zCRbSUHlrs/2TMg+/UBBKHZRE/JyhzU7ejmBSrgC+W1mq3?=
 =?us-ascii?Q?6W7ObnkxR3+LdOh2Fiw7WMfRXqFPHAxT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:05:19.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a150b1-71eb-4a7e-5c7c-08dcd0bf4b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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

The feature is unsupported on specific APU.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..d46f216a33b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3679,6 +3679,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_init_reserved_vram_size(adev);
 
+	/* bad page feature is unspported on specific APU */
+	if ((adev->gmc.xgmi.connected_to_cpu ||
+	    adev->gmc.is_app_apu) &&
+	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
+		amdgpu_bad_page_threshold = 0;
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto release_con;
-- 
2.34.1

