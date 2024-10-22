Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0495D1CDA1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 06:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835DA10E5E7;
	Tue, 22 Oct 2024 06:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8luop5P";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB39D10E5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 06:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCO4fzsqNKXAZpHmMrvRevkBTBIYjAUHmpfnjREO4jfSTwtP9y9mxaQkmqg8e2aKYj3t4r/MljvfUo+MaWZnmkwgRI+sJiMHHBqGZPBHV3vb20y4CMAVml/WdQF3x5SdJ64Y/0wHhHc8tK+u0AvkE5WHEzwfunrNfGd/d6eFywcNj5nswucmhsQDWWXS76e33iza3Ml3ADtWwY679jTR5mQgj4/HuuevI+drMwBY6gwwcDIll8afilJfKEOV2lBgXhgbX7C58bc3FP+p/rT1QaOoBZbCPkgAnpgCHlsR8ldUzjqSjFQ2tnxW9922+S6WzbFShT0Oyo4OFiAoO21i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygwg1aZ2S1eTTLtuTqyeOQxJxYB4mpBzGZaOYQglhPk=;
 b=jFRDqyQGdr6VwXcBzuAIKmZsQPfbi6J1dstO9v42hcqRc7545XrrsHJuu7hjAalEKKFTtE/InFd+GqkbzbscawYr3eOrFdhVs2ZaJUZDfrP4DwqHUDN/EGeB+52gwdB4Xd7Ceb4K36tdnMkPUFsruQwBH9v65y4wlgo43myvjjOOVIpagBVAq5MsqScYmh4rzBcXEQ2tkba6YwhB3xAI2QXSVcDN0V95s4OO5iZE+/EqBfrydLcdVQrBBGhKxn7P+YatgG03spFWbYSzraEQNoekwOovNMT5tLajt41EhrDgQDeJKS5gfqM7uqhIgKLNA80Y1cDfNcJJ6RZbWt/rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygwg1aZ2S1eTTLtuTqyeOQxJxYB4mpBzGZaOYQglhPk=;
 b=a8luop5PClyl7iFgfPMoiy8WtgOLEt5gjfUGriHiNdaJSOfvvcdcF9koYEe6CK3eRiTCMtwCE5tyHIUR91RYfWRdeHhuesk/406QoK8+pQobScirptwtGfK49WSnv7AMMS/wjFB4o4IFzE3Jt7DT7KDvivz7Tc06+mOcMMIyplU=
Received: from BN8PR15CA0052.namprd15.prod.outlook.com (2603:10b6:408:80::29)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:33:36 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::86) by BN8PR15CA0052.outlook.office365.com
 (2603:10b6:408:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 06:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 06:33:35 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 01:33:33 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Reduce redundant gpu resets on nbio v7.4
Date: Tue, 22 Oct 2024 14:32:39 +0800
Message-ID: <20241022063239.1517315-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 577233b9-ecfb-49d2-18a9-08dcf2637515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ma0xPxfJ3xzZBGZhthwnGMB4ZSC8qOdL9qPPYIjPN2qwXVsZVawH3Zr5HRGi?=
 =?us-ascii?Q?zgaDzFD4I3bTbfw8j5I6Gn1GK8mbDmpAz8qgXwwRS7OUxDxYLmJiziGp0Twt?=
 =?us-ascii?Q?Msc5ecvvorzeiHxhas7+vukROrME8lmLHKEiK9MQI1NB182Ks7IfBJ7jWQiS?=
 =?us-ascii?Q?Q17YzKPNP4h6GRdaMlgq1BcYpuFLQJVEkEmS8f+pLnh/HsVowTZR9vSeDg16?=
 =?us-ascii?Q?SwsLDdHFsDKT0Kdj9MFPAKi1WYfNWQQ92/xlNvQrk1XlUczkH3mgHjbg8Wbr?=
 =?us-ascii?Q?YWJaf4ANC+QvEwGvthtIhc1BEw9jstS1YPqpFNplZMfqYF8RbupCznPJqqNe?=
 =?us-ascii?Q?JO5VzRVt06CQiCqIkWegYnqNGXjtgzxmkAc6QJfgn4ORnZDJe89NRh0yhri2?=
 =?us-ascii?Q?EGG0zHrKXz/NcslqrwuJp88G4KiQ3rvdenSyTma0mmRY9UyT/U65QQiKv3pu?=
 =?us-ascii?Q?F9uoTDeHa2EWs59l8/fniEUhBp8KNX5zb+/02RwU/iTt6vvIedXa46iLql1e?=
 =?us-ascii?Q?uKuE0vVWITuQtBIysmsr8HJjdhqE0H4xJJvsOFM9Olk3gqAVE6xnDWcKVW2O?=
 =?us-ascii?Q?2+3oxRILiRkmUYfhBBglbxqUtB6Q2hWUmhoT3MkoP0fEonR25U7H+uFDkzOD?=
 =?us-ascii?Q?+z5HVFr3cEGVykgAL0T7+hozmUtgYCGKFgJ3ARA7UMRrq4NXgPqUByk1KXBn?=
 =?us-ascii?Q?B+CaDIwFBFc9Y7N1gqxnfo8pGB3rjZcKD8PDlSB7moGnjXqqY6mU89A3OWu1?=
 =?us-ascii?Q?HYTKIjxFnJDp0jOsYuYG9kVEHt5sT91jhVPOMqrEdyHXoVr2JjKPASCJXaTU?=
 =?us-ascii?Q?VS7ye+VV1NArCJIOhaVtc9Dmpv+/XKOeBrEQLCdw5T7XJfnpexV7jB5P1jXS?=
 =?us-ascii?Q?BjmIWrxJhzEvpOZn3DQ68jg7PklfCzascnHY+F8pxKMsWwHWv3nbg8tOU0dA?=
 =?us-ascii?Q?GM6iJoHxXDUtsm2iU6MUJBBcWI5Vx8hLxBccKiVI3YtG/GWqiCgXEXxNCsdg?=
 =?us-ascii?Q?o124XwHda9zwhtG9EDLvk+FCp5Oijg+4M9z5637cQ4VzCR56CFvOJD5Xh+xD?=
 =?us-ascii?Q?xxzl4SBajPVi/MvkVlmqy87cu24o3klbl4+QJ/p3syKVBvCDZ1OEB9CUw/Re?=
 =?us-ascii?Q?TyPDKD8mJGofm61q5YrJzXLsosrIfroeUjI9K5JW/QYZOWSOWqKdLvYqJBb2?=
 =?us-ascii?Q?NN8Fo+/ITN3Ox+kke3O/L5cYIsR8hfCANnzuB7VSn11EbuxSg37X2UbEZBig?=
 =?us-ascii?Q?FY/vMtGgj5DJxe+S0r3IzhJVWIjyWc2AjQ6XHMH716mNPTNkuQFOVISC/gfH?=
 =?us-ascii?Q?9GLq2sz1w6xhBCSKhs5+4r379puIL60s0mEgUFjEwyAa2uoC5ujOBQ/MQnYq?=
 =?us-ascii?Q?cUiT7Uo2Yhm8srh4c26SB37Wk23Bqm9RcExsyA7ivjtLcnfg5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:33:35.9143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577233b9-ecfb-49d2-18a9-08dcf2637515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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

On nbio v7.4, ras controller interrupt and athub
interrupt are generated after injecting UE to PCIE,
but gpu reset only needs to be triggered once.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 9446bf6f82c1..97782a73f4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -414,8 +414,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
 		 */
-		amdgpu_ras_set_fed(adev, true);
-		amdgpu_ras_reset_gpu(adev);
+		amdgpu_ras_global_ras_isr(adev);
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
-- 
2.34.1

