Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C00E68974
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 10:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC16610E856;
	Thu, 31 Oct 2024 10:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Aid80b1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD08110E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 10:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VThM6h6GcXumT09b14I6TaU9hY6AZTgQgokEOIqrIYbriL8R9628MeRkg+RhFWbqikG1SZcKZBIDmy8qPYHIFNlQjrU3TLMXrE+h5+DUsOwtxZz6JXPP69+kwU5b+gO6/4OddG+un2nwdmUtzTgNOtT61/OEEpNrfDd9rNSEofIM1hyBF58/jstkzJpv0fKH4MlDO82/UirCSEIT0TsbV+mTLO5nwzaGQw8LGZund4dY+oFhCIdQqOP4/ykQLsJHQYoKkvVf0G7OSUn9oaGqO0omHSvy1Cq4Ym2j+jU2c0PqAq6br7Bvf7HsJcs4v2eE60aGMc2SwAim2h3lfhQfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdEsyHSgxdJJV7f9MKzLGRbBcSMaKHyn0sdzkzbZ9qY=;
 b=B2XnWvRsEf862v+bx39apCBjDJ2Tbe1kAhXdzRv4rQ3+WMVnA67QbXorGotaZJZmqIdNPcuMX+4KzN4mzchLdqbYaE4mwskikbKdnRSUdbAddthVzaNG7p6uyWl8L3BR49sCkJ29JEbPrM2D/MNGtkF/nGxllekw1aBxrfZ6Rybi0LTNKMHssWj3mk6CeMFoSWdWN2IIA786VjZl/+iw4twwm0J3LGvAycCJVO8vXHt+wheq2LBwMIOPcsoJ3O43nHaQzsex3lkOIrvUTfl24SIWca0CdDX5VJd4+mL9ZflWVWKoGVeIFKs0ilskfEdE4wQFHZgHoGa5Z3BTZ+Nepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdEsyHSgxdJJV7f9MKzLGRbBcSMaKHyn0sdzkzbZ9qY=;
 b=4Aid80b1OE+l7HT4cCP8URmo5rVilxyYMedYme1ayuAYakkSXU+y45hIEzy5stWq7tFZBf+I3LxgiBK90MyWWz+YmkEyMzcomUja5JI26ASZ1wJA71a20p1Yd+CFO2KqoC/LMMISeYsAKIBXs8umOt1F/MYezBn/Oy6wy/bxv+Y=
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 10:51:15 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::73) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 10:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 10:51:15 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 05:51:12 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RESEND] amdkfd: check ret code for ioctls
Date: Thu, 31 Oct 2024 18:50:59 +0800
Message-ID: <20241031105059.251085-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae5d537-cd74-4299-0858-08dcf999f13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j052KXQF9p6sDDVfNxmkq97rcy5YENl9RakYazUmfcd2Wg0U5B5KxSZ/w8vd?=
 =?us-ascii?Q?HOj4REMG7B3nJ3trRvLXefodWG2yqiXFs4nt5nIC3hPC3E8kQJdSzB/FTRUA?=
 =?us-ascii?Q?y54p2LZ9J2KUJg1u2QpmciGJGeXpNCz3CsXqLNOyHVy7ulYxPcwPyFzfyOH3?=
 =?us-ascii?Q?gSTNSThPXAkkf+/NZODtX/FOA0Qx+ndgVCaLpQTH5Hy5eEW0C+8WR94dfuB3?=
 =?us-ascii?Q?K9MEndWbycAqdVLRs1fNThJPJtxyQH+7QGBjWm2qmAPzhvy+lLzPi19+TEf2?=
 =?us-ascii?Q?pyURXylfsJ8anSYk3wvoJIS2YWquGESFMULnfRcj26ewPiYMMZYDI/bv1JMJ?=
 =?us-ascii?Q?/Hw2tkq5ddoHLo0gZcSM7q1sJ6vEdHPOcczO/sQzlff3gbcMr5KX6sDavdAB?=
 =?us-ascii?Q?0VLt4pL0A1RKjCmROzeC1qJDvg649pi68hUjqkaaRmhpIsPkh9kJL9us/XMD?=
 =?us-ascii?Q?zLvHNU9d7nH8GCib6TnESqAXxqF5fBw+zWwvG5ZpPPFC6V3RcVbYJbZfFMwp?=
 =?us-ascii?Q?2kx1BmD6862zE8QyxSk6VL8mjD0zkzTAtyNt+ANLCmyiyoNMx7e9lZQjZ6dn?=
 =?us-ascii?Q?DtaVErIHbgQ8abS4R3RZ0/O9KgO0cZd9rc6JSWDHd6jdDb788h28nsBgCd1s?=
 =?us-ascii?Q?HVA+1t36ysMWoy0WAOw6IzgLbuHSb7kqbr1ZIxh0Z6b4hBhnET9RR+rGBkVG?=
 =?us-ascii?Q?+hHtJisuTLy3Sl0xclf6Tm+vviW2JPkzUSH+pCpU6I+9IIjaRKNbhFFNy7/m?=
 =?us-ascii?Q?WKB/o5L+vPZra9OOsB9Pwf1TJePj2Gc1iJDHuXoOYXwMo1NsCnMIo7vzY7g1?=
 =?us-ascii?Q?15auwB6SvFkAHSfOVDwvfLuqpRvUyG+dkfNqqQC8RwGoh+Vebnle9hN0XQOM?=
 =?us-ascii?Q?HAoZyb90LF60XyLbDCSHbqzDQ2CsedtSjVWCk5DsRV7KAQMA4Ln2zwl2aLiF?=
 =?us-ascii?Q?DoSitNcKCdG96yeL+z/dh2EhYq4+oMZrrYxW3G8/4DHDgNkv1EclClxBzYsK?=
 =?us-ascii?Q?SyWWU18hHJDofRadD5R5xJZjw5/tQPZ54AGYx2nFHIte4jyH93Gvj9T80GFU?=
 =?us-ascii?Q?E63ACLzEsZvkYMWw591VJrAfHynIY4PCc2fhA5oDdAEUpipAyAWcSJ9FzSVk?=
 =?us-ascii?Q?+o0srwtnHuzl72fzoqhZXJC+7BRLrB5qMpzzRf0okzLlEA0CKEYtTGxsnc5U?=
 =?us-ascii?Q?As+CmWzit0nOF9luiFV7sieZWjXqzwLnKYJ0BO+BiLoB8nA4DxPFa70Aitsi?=
 =?us-ascii?Q?I1gYH0+1P0baFn+4cYSz3iAZX04d0qDc9PBIzlAeLJxGh+lonVAJjlXxVUP5?=
 =?us-ascii?Q?amlSK1WNj5RSV0SLk9mDG8Rfe7Ly3A9MAC33KJCodHWt/EqEpQlvODNQhVSu?=
 =?us-ascii?Q?izVV+7QJIfHH6TMJwzYPjCITUxHXQY+X/OZzKB9MsVrYhLpvHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 10:51:15.0892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae5d537-cd74-4299-0858-08dcf999f13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

The ioctl functions may fail, causing the args unreliable.
Therefore, the args should not be copied to user space.

The return code provides enough information for
error handling in user space.

This commit checks the return code of the ioctl functions
and handles errors appropriately when they fail.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3e6b4736a7fe..a184ca0023b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	retcode = func(filep, process, kdata);
+	if (retcode)
+		goto err_retcode;
 
 	if (cmd & IOC_OUT)
 		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
@@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	if (kdata != stack_kdata)
 		kfree(kdata);
 
+err_retcode:
 	if (retcode)
 		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
 				nr, arg, retcode);
-- 
2.43.5

