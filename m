Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C5ECAC5B8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CBB10E828;
	Thu,  2 Oct 2025 17:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOOcSysd";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBEF10E828
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB4o0oGkd66qzoQ5eVZrKnvKNwLKXZKkl4zUxqUuPG+I08m8HySuF1hkvyNXi15QZCm8UMxBn+8D0GOBVpi8IKIKKrvnUaR3sLJ2LcZApvJW3RieiJ+TpyJIO+y3oKm2CMTqO+aqqXNHGgAosn0LhTQjSIMmGElJTuvaC5/k8Kq13btRJ0xYW8dvm/JxRUkdY7qMFyuGI5rfsIqf6jOmldziRJEq6U5f9rwqs8eYrGQ8x3VzjK7x5RXuAxcXSDPcTmg65VJWpaEtFUZvt7KCC4R9m3B0Mv2hSMg/Clm4ec41M2RQinOQPrvWq7SwoNAqaRCQb1Z2tAhGJ9hdYeES/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m8c1Cun50Fpo+ClsRbJqJGq1HqVPOdyUBOfk6MpcPU=;
 b=MxKlL1PNXueMe+o/quSCe6f3tN2rBVLp3P2OdMsIYQF7vQNmKCabfBgyW0x4MO244VEtRm8PsG9XV1mIAFI2GQKAkjdkeoqhT/OYuy/4P6vEZ0V7m+4+Cza5GJnlzxswEeQCBUFQe7Ze/NFe2NdD6+eoq4+qOem/s2AwrqV3i4Olwi15QDU48LeCkW64elSb7sttCK4oqmlf8rvsyx70m8HMPaEErAHZK9c6Nx8IghRRaEcewlSBxvPf2JskQJYiDb+gVYx81EglBsWOfczQpycXvMYBO9BB5XldJTFOCSXxgtOXIh30EieHUPc6I+NnLHgTsFLrdUkdqxFmAURN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m8c1Cun50Fpo+ClsRbJqJGq1HqVPOdyUBOfk6MpcPU=;
 b=qOOcSysdlavkta/w0D8dROCL0NlfH5NbEoo8oEJBanl/EXq+KfzjQl6d6LWSQ5NZYb6zeckD+G43PUzdXYeUKdbbKAUcqQUWermbLlFqSLXatex2ie0CRILwPsPVr5GLvXFqxwtUs7yE1PCB88qAvDWFWI08/r5xAZ6vdqMIXR8=
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 17:43:54 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::fe) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:49 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd: Don't always set IP block HW status to false
Date: Thu, 2 Oct 2025 12:42:42 -0500
Message-ID: <20251002174245.1691343-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: a1084837-d17e-45eb-142b-08de01db4180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FnQu/anDVpVW7xIhTA83ZqG/GnBh+OE++Ev7ijH5vJyqLkyokZnXms8Sskx5?=
 =?us-ascii?Q?GmFFewOl1kkNWgURsvr60iDmlH/cShdUv5Ientv4jj2X9BmPlb7jxN7IlbI7?=
 =?us-ascii?Q?7io0QDhrx76rpP/VNZbfs6EQVrwujy7mIoFSHTNMWglsXrq/Iq/haKSJaJcf?=
 =?us-ascii?Q?ggkTg0j72jSJ06ZUhDUZHm3Rk//BTWT0LYnMt8WWEtdhzExPIkqzCuIVevWC?=
 =?us-ascii?Q?UuW1nfGBx7PI9B/g4wdI3ioaBzs4Ty7yjbdLbmYpYiXdopjyObF8E0ttHqqG?=
 =?us-ascii?Q?nXV1YrP6GByB1ZqU40QoBi3w948K0Kcj+ZAE29LouDZKsSZaVlC84ysBf6hx?=
 =?us-ascii?Q?5D+BW/aUKLikdGTXM9hQy9OP0FWNkOUGbFXdw1GaXwGWBD2rolAAqw643KS7?=
 =?us-ascii?Q?L1ew5eJLXITe4AS5O1+K+XcBxYzA8+HCDuYqSyUQdrKhJlE4CVZQMjJ/qOAg?=
 =?us-ascii?Q?IDGHbaou8KY1oM8ZDLDzmlmM5iFHI2oMb2jCOeCi0FSqvFjigDnawBwdu0Oc?=
 =?us-ascii?Q?seoaoW72l0ogw73Otq6bf4JMBjje3YIJMf4CASzl/mXw43hp3mjEapd+ACzi?=
 =?us-ascii?Q?p9RLWhGNGi6JbeRf3nKPBCTmk4dSZbBz8pT8ZUQMk3ru7whzTfXV3sqmPxMD?=
 =?us-ascii?Q?Du70rBYNZTSfjw0vT8sS/5IwjPsseugJcfnzmG8lcLyTXoQlaTWDQNreEsIV?=
 =?us-ascii?Q?nIaY59CIM0aRfcsoDX21hiO4FyEm0hx8NTFvMOrJITP0hbMxtDpTdeMnrmlD?=
 =?us-ascii?Q?qho1rjacQ1DIccE3iJ7fgzgBZ36+aeXjSZJMFZt6QTh/yFtZbiWfDhSFCkab?=
 =?us-ascii?Q?qkDA1yvrrMgCm53kmn0eCCgwuEKlvaedkQaJDFTlX6S4K76zz1hqWv6CAlE5?=
 =?us-ascii?Q?ldjhpF00a+ahNBtWQb1Egh9tY7nxzSniiN2EsbqWchqW3foSDu2xWyXdiKk/?=
 =?us-ascii?Q?F2yngOm9mcc01zpwZP+k+n4P/AMmzsruKss1wyR1BbmXQVMEa3tx72pOsxiO?=
 =?us-ascii?Q?Ys5hltAynIzz5HKskaCV35QVrMfRgvPSFC+JGTAJKmAXv6XeVNX3iRm4tuKT?=
 =?us-ascii?Q?u5VfK8EoYzMsTQoXUsBXRDHa9XGWls0TqwrBU0zQIy6DDRYvcrIyoPqoreSJ?=
 =?us-ascii?Q?XiXW7xRsR53SV8i/ukw2soUqjwdpMsWgOzwUWcD9IXOt/qYNP63VuOCAxSRr?=
 =?us-ascii?Q?FUTna6y0QzwEAviPUq8FOwyL5ujddRnw5xFpQpE9AWWSU05fAWeQubbpLnA1?=
 =?us-ascii?Q?Q/8CkDFEV91xP8QQKGvDp7y52ED2S+iGxeyn9f0HsuMDLvvHbA4P47mzn3w5?=
 =?us-ascii?Q?EC4rCb+hZEAJRrQ5uyq5X47hfQwyjhLkga9m7kA8AGQats0zH6vjrG8RinoW?=
 =?us-ascii?Q?eTpLwmGTW/BjfEkg+zpnkcPnc1T5WdY5khhrFmDfHP0gAFx76WQOa4WU9PsY?=
 =?us-ascii?Q?AxQw450rnJX4t5HoShg5fXd8/0zmuXgnhwzDkGLuzpo1Oug1jMWpK3ZsPLtv?=
 =?us-ascii?Q?sfncBF4pJw6t92cj8d6xzb3NCFO1u0jwrBEqUk3rS9YC80yBGQgANWVzAGZE?=
 =?us-ascii?Q?cpia6dqmKDgnDpDKg/8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:54.0190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1084837-d17e-45eb-142b-08de01db4180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

amdgpu_device_ip_suspend_phase2() calls amdgpu_ip_block_suspend()
which already sets HW block status to false when succeeding with
IP suspend. Remove the explicit call in
amdgpu_device_ip_suspend_phase2() so that the status is accurate.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d8cbfb094920..1ad54dda6bcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3857,7 +3857,6 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 
 		/* XXX handle errors */
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
-		adev->ip_blocks[i].status.hw = false;
 
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
-- 
2.51.0

