Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2586C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 05:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F1210E210;
	Fri, 11 Apr 2025 05:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZ2MwrEv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309FC10E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 05:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDJsYD3ytD1Vv4p48DjfsGTJjy2CEyqLRlvyEwwCbshZXBeMJlg+b+Mecz3vZTuIvp40ro5+LpptzRl8Vm96sjs4R+1NofhDOXv2zqY1Tp+Y4urZX9gX8G636dOcOYAW6+q3M0AOhhys+MtEJe3N4/0c0PFGN2biO036Chk8nfhw2oZHax2cYMxf+g8qUxgoGJ0zEMOt2jb4mOx4ShV5KUq6n8GecnCJOFhfkcgimZ1JnIacY5tC44Hij2FNV9GhAfvsNoFp0O0kIox3yx5N4w8ciC8PDEX+LZVkPwS7hQhHN1seSYdwWGHxPWp3SFUY0X07Xy3bns5eiF79JIArrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNa4UH8rb8Jt5h/o8dyc2aobOWeXMR4EH2dMeoH8SZo=;
 b=K0A1Sl0s+clPepdAMZHu/xnzNyL2qirJNLgL/VDt9rH8+aejnyLFv17S1jHMfyYw1vXyw9000cKZHQOogEJ1Z/0H0tzp01NVJ1FGkzhamHQSjOYZus8LFjeSCSGnv2M+/12pEQ3/PlOLKUp83X18T26CylwkD1rv2P5dvRXFxtIYKGa6fXr6zPhdoVtMKEHYOnlo3Tv0Mnkiw4CTI9IbQbL8CyzDbu7tLOB9X/PAfr0fBOzwza8mjbvrIJqi1aePKkSa72Sq4e1zel7sX5jKWzY1X4AhR+utzhhdb7G8u89Osji/lR+UvumUxNtXBrEngmXphegap4HDZO8xjQa6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNa4UH8rb8Jt5h/o8dyc2aobOWeXMR4EH2dMeoH8SZo=;
 b=eZ2MwrEvx3rBwj8O/HTMGdqlJO62jJoj/wGy1Prg0dceEyG8HO2EsyUoAQ2Kg6pcrQWdQoR0b8iLU7/Y4oRpAvnQnq1KUDn1KfC6UeYG6sps3Ak567T3AgBI2mFRkdGmvJdaz+B633Pev1gpM/R6PqXq71HDMZiJBidqipqB8Aw=
Received: from MN2PR19CA0059.namprd19.prod.outlook.com (2603:10b6:208:19b::36)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 05:18:02 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::de) by MN2PR19CA0059.outlook.office365.com
 (2603:10b6:208:19b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 05:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 05:18:02 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 00:18:00 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Set RAS EEPROM table version to v3 for umc v12_5
Date: Fri, 11 Apr 2025 13:17:03 +0800
Message-ID: <20250411051703.320093-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dbdde1-66bf-4b9f-d30d-08dd78b83b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u7hQIIIxCGBHjzWHYu1cQuwLnmD/D6YSGYUrRQHtHpB6mBRup2QPUcvMSCYa?=
 =?us-ascii?Q?UesjiWTaS+jlmaq6ORqvwgzwcjxHfYz9u1iIhow9G1xQSpoiolpc1s+j4RR+?=
 =?us-ascii?Q?FQgcVF4F+7flzbI8Y8+8JtqoGyAWokuLpkHClc0q7pwO8R3oLJGqR6J9hDWk?=
 =?us-ascii?Q?wReozZCbviGoTnbIJcOgCv5rwEPQKst8VkaeXM1h3gCjRD9Kc4um42SjHo4d?=
 =?us-ascii?Q?OkPpk18O9mU+MB16eVmyGpQrdCNzDjEWzSX/fs4DoS2kJCv+qAVu7mMliR5E?=
 =?us-ascii?Q?mDyp4o341ulM/Zlum0CyWXeYNWeOAk8k0CIIzgTbebPLMYH+BzPXDgkOeCj9?=
 =?us-ascii?Q?4XCD/7AJ7gjoFZGhg2eUl6onU1wkGPkms2T48Zj79LgrdoaO9eK6dwGZoJAN?=
 =?us-ascii?Q?y/hsVOxEF0eWPshfcLkmXX01IWBokLvXRTod1Vw1hBDl2Dknd1+Xzm+n8XaK?=
 =?us-ascii?Q?n96NOzzFC5J6kctb4i8fP1zMOCNkyuPJYd9WnfFTp+bWWs/azVjz18tMZP/s?=
 =?us-ascii?Q?o/33jyM2dFeha2Y0qRQ49tvxBGtyDK8foeHIC1ROkzNnDMGq052hi89CA428?=
 =?us-ascii?Q?NPb43HhYhdd+SLl1xHRFxgTGBjRRh+e/ibkVRMJAa+MLvhTbDRG/2jl0clr9?=
 =?us-ascii?Q?v2XoEOER/wy/vCWkcvwz4E7i+RVle8HgrC6GW/o/1RvYsMb5HBakIIJfHxoy?=
 =?us-ascii?Q?VlpEwSegxTmrF7RRCsQLYS/ha0TE9j+P10CGXbCuevSvldItVISe8DjyknAo?=
 =?us-ascii?Q?sVcNpZithWo7WfwgnBNuKkqsxysGzAV9V5/NFTetmCEIW6SvZ4le0JGZqNzX?=
 =?us-ascii?Q?qDIwOpuJ29GVqrKFA71B7+wbvES0Pxjg08LxMIZ54J9elWwSOtc3s1eumCJK?=
 =?us-ascii?Q?8S7+T8gygb+/49ZLezEyhSY2tvvevHhMhfFr0AgR6pF/qqgyAMh844IwDEwc?=
 =?us-ascii?Q?asfT9ekPoeBKYSPy35CCiZCObevidxX0h9EOcQ0sHtuPs/8TX8P+kOHsHjNJ?=
 =?us-ascii?Q?FMYEWa3qYRwSGOCJG0YF83YDIE5AV2pqVdFeRZyZed/cx1Pu8gTxYftDBnZ4?=
 =?us-ascii?Q?X2l4gaRWGnEiqyI1fwa321i25OAfz3hmoyXToScv1VSEPJxLh8nvEIFQSRIJ?=
 =?us-ascii?Q?3zkMi0/D/ZgsPkBgDz9PabBYF+aQ0dG8IIFSGAWgy0WAptAWdnVskBYLUZxS?=
 =?us-ascii?Q?SL1nTEu9ax/denEtf1uhjWUmQEqLAzt63WjfsJSAQobrwYYL5EDAcMK1PfHD?=
 =?us-ascii?Q?lsrRpuuSRkmcZYpRt7PBZASsFtR7GxRQPu53woEabjvp98q3cmDlyYhbpfWO?=
 =?us-ascii?Q?UhflFXNSFyRUChhFwuO23eCghwNYFKH5SHiLnTysWGkoRS3l+mF3mA3HSWj2?=
 =?us-ascii?Q?fGFaKLucvsEY/WECjQTBLO12bE24XFniqiT8EGM8PXHHHPuDKDZu3lfStQDt?=
 =?us-ascii?Q?3BGT1JxMBwVF2SlILFM2l8FnppNpXoqDlka/ORob6xqwnu2OIlrWQ95FCBrT?=
 =?us-ascii?Q?D8NJRdzCQhbC20rHZQjSynHfWBGVGgtQJjEw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:18:02.0215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dbdde1-66bf-4b9f-d30d-08dd78b83b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
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

Set RAS EEPROM table version to v3 for umc v12_5.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c985d58fdd7ddc..2c58e09e56f95d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -418,6 +418,7 @@ static void amdgpu_ras_set_eeprom_table_version(struct amdgpu_ras_eeprom_control
 		hdr->version = RAS_TABLE_VER_V2_1;
 		return;
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 5, 0):
 		hdr->version = RAS_TABLE_VER_V3;
 		return;
 	default:
-- 
2.25.1

