Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4E2CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2D510E95B;
	Fri,  3 Oct 2025 18:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjV4/Kl7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8508E10E95B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7rfb+/UmxXIYpO4wATSB2bb9weS+S28QCxkQnipxVMCzG8srG2bhv5D5gTMSAwa3qFWtDVSFEgsu0YSBkyvVQOZKN7kK3/XpJOGh5v7UA4BI4JghHXTtbHgzNYvEBXzhXHz6WGVfFGf6q5vP8bvpoDdwjyuFT5p/oMMHq3I3bloVMObnxwPk4TUyZHIi/8CfLO+0ytNPlaPBADcu0rFeOPWgVqEdWueWMhHCGGzvADtCJG/Jvt030zQDttbkYva1fRoEyxlzAb5fagzJYYFHyqYMlVsbMsSVtemVCqOwY7aTHXslGXLcOx12A6M9e18qVQTJBEJIoJMl3iQIV2Gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8dj7krG5rovC95hAOWQ/c30PR/TK4Y5kBqUuwuDkII=;
 b=xY9EG3kOQ6jOTw00Oa29vRMl8q7KqwMm8elqNEppSz5FOZpqW0sef9IR9SaEB7rXr1Kl303hErZJNfQ2b+RssYW3abRcAvfwDUdpKDwSA7UWAGnjWsYCEwuQUNX8mrnnQAQt6DnYMBmKxpVts7Vfr8Ik0TeMm3RzjfbYPcZRpNmgt11qdMqh8tLnEB/uS/5+nY41knE57M4xVpuyC52FVAKiMCmHflkJY2iYgod9tgsKvrSUQHR2Mgcs1IfUbKpTRJTmHNSBUtTMFuaz920HfEr0Tfirs4k/7J6Eu46TYcSVrFpYgpLTHy5H4Rn3A7HNbRrpByxb1oukE+r4w3L6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8dj7krG5rovC95hAOWQ/c30PR/TK4Y5kBqUuwuDkII=;
 b=FjV4/Kl7yn6mXrKzVl2sHOnb80KeIrNVgL5AheVq0RYrs0dB6QDIb3b4dYA+lKLTopQRxrmLsVPc9VHTmdtO2t6ZNzdx/+TOIxaK8soNXwYHM8hXTb2Cmc+Ewz1yzb5YNSJd6q04NzPdfD8e8ZqwO6Ee8p3mB++vBNv0zrhjY5s=
Received: from PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 18:15:52 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::82) by PH0PR07CA0012.outlook.office365.com
 (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 18:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 18:15:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 11:15:49 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <Xiaogang.Chen@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/3] drm/amdkfd: svm unmap use page aligned address
Date: Fri, 3 Oct 2025 14:15:16 -0400
Message-ID: <20251003181518.24270-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251003181518.24270-1-Philip.Yang@amd.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a12e63-d598-4b1f-992c-08de02a8e34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NSPvThHQ5HDp4lU+S//ROlXkWbhdVVWcbEYF5HYIoneZi/4/kAOp6VbOJ9m5?=
 =?us-ascii?Q?dURGnLCuDA1lDi2rb5dxELRz0L1at6fxYVbGIuoHDNQ7FLIe2A2hWaSywP6D?=
 =?us-ascii?Q?5P74Mbb/IIGUqaUU/ppFuRLSySsNFtmX7mrpcrCsUWv+lC14PgtfXNl6tOpq?=
 =?us-ascii?Q?u1TMzh8Weuv2EToVwhB6PFe/I9Vpd9ojKO4U3N1GRmzZS8CTTu5iicZej1jr?=
 =?us-ascii?Q?A7lLAOAShYrmNkRj9PMfN1WRQaNPGi5Amsdg7EpcjjmT4Z/he8jH0iPVUfaf?=
 =?us-ascii?Q?AFQmmYKoQJw4bajdZG7NTGt5KbkXhDxkOUyNKoJKxe0/PjqEsFzZATKZtM8B?=
 =?us-ascii?Q?GmR5q7Jtgke/CDuzRDxrSyMg12FDmtnTdBOq57/BwAyvSA/q9JCgXhvn0NcN?=
 =?us-ascii?Q?lMOkn67qQezFUrIFo+3daDvXraWyReJIOC1Dtt6RzCxL2Rah5vNdcvYFN8kN?=
 =?us-ascii?Q?LuxQeMM6YzmKoqPJOHxGyx+Tr/789jaFPpHzEMx1MeMJK6MuK5JHbac3H57w?=
 =?us-ascii?Q?5O2j87GibvUJrJ4J94SocWQ7zbBTDiirKSrKQAhTO7/fwHULqIdD4umnpv6h?=
 =?us-ascii?Q?cDK1pysU7xACJvIiZkAlKgr2lwRnT8rKd5o4DDr5tyxQ48mtHhxhidkibplr?=
 =?us-ascii?Q?2gWQL3Nd/TL1bMuSpLamYllHRoiYp0KqFXRl2+tXefRFoIaK5g0vK3o7IU8v?=
 =?us-ascii?Q?A/PGImpuRsJTgYlq8NkwYQEIYxxXLraQkjKn9mwaWjeM6amvrzq0jnaCSrdh?=
 =?us-ascii?Q?ybTSCjbSy0jSa0DVhNxxIGBHSJOCW8VWpq4U0XmV2pOtba45Ov61feuC6rqX?=
 =?us-ascii?Q?GBuEA7Tf33eNLHsqg6KCognzCvX2kyr/3RViUd0X4erRCfU4uynITPXnc+qT?=
 =?us-ascii?Q?ZGC83hgIh/D4MGxKvlEFiHYhr60BbMrKwfQOruzT7rVMMoOUSdsHvOQHsQxa?=
 =?us-ascii?Q?KwXQQ3JJQ7rmjOdlg7xApE3W2qkQqaG/tkcP+R4NAGrzN5RWUvFt70boHVKy?=
 =?us-ascii?Q?ggz2a8FOLD5WlznV8buYYevZdWmK0x+mrsMwrfsXnGMsdx/m/zBMgbXxCGb0?=
 =?us-ascii?Q?YUjiZNU/esRoit5hZ2NtfOaKqhEqG9QiUI+xsFFJ0VnfDupsoeUAunQDBlni?=
 =?us-ascii?Q?NZ9JdUNAzTL+a4yUCPJTW6PT7zT2BssB2Mn743GXxleKM0OqD15LFVtondBL?=
 =?us-ascii?Q?2hUEXWQWrs58OJVW33OS5vUUsyOhNFbF7GqLqPv21OQs2t2cJQBh2TVXPUHK?=
 =?us-ascii?Q?/M2U6WMJmT7UmXGp/ABrjhDOccxzI0GuWoaX1zw20yYHPBB3Hyd7sohWQVmy?=
 =?us-ascii?Q?P6Up/OaPV36NSSjX2/1B5+C1Shf9PJ7PaVwGgOh+Zvg3Pgx0ZgHIAf7QlEKl?=
 =?us-ascii?Q?RNC0qb7mdxFlE8FYEPMfjdUiGPZXkdg/0+rIWsO8OM8dQW1tCuZHkblHG1k8?=
 =?us-ascii?Q?u7I2TwIFxUNwsb4f4FXcYDib2m0dvHilzoZOFXf5/qwubrXLXTcybhEHWohP?=
 =?us-ascii?Q?B22u7prRqnR/zxvNMkFAWyTiCBRoXgi9opdiAkdthMeDwr/Rzzh31kf5Ktj2?=
 =?us-ascii?Q?LI8F6MAIazwadxOSzBk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:15:52.3386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a12e63-d598-4b1f-992c-08de02a8e34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

svm_range_unmap_from_gpus uses page aligned start, end address, the end
address is inclusive.

Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e8a15751c125..0aadd20be56a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1723,10 +1723,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				svm_range_lock(prange);
 				if (vma->vm_flags & VM_WRITE)
 					pr_debug("VM_WRITE without VM_READ is not supported");
-				s = max(start, prange->start);
-				e = min(end, prange->last);
-				if (e >= s)
-					r = svm_range_unmap_from_gpus(prange, s, e,
+				s = max(addr >> PAGE_SHIFT, prange->start);
+				e = s + npages - 1;
+				r = svm_range_unmap_from_gpus(prange, s, e,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
-- 
2.49.0

