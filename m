Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D549C10F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6223F112B0C;
	Mon, 22 Apr 2024 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iERWkrqJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DFE112B12
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QScV3Hws4xLcK6EarNVBsfokMjUTc2GP6ALxHRW+uhNU+dCFXDE9tdCzvt7lvRH7845kTffo26Z1h303ScVanTtTBfS1YaJRIkGopt7fzGwCDmK1JFhnj7U08CjDZGRf6RyfDpQB8b/yPYm1xA9GbKSCqIq9SKMxdsPmUwk+/WA62DVRpf4fQfT43yzzBnGKg6NjBJ/WzEN2oFYRlQwQU4OBo2wVyrfB84tblVhI/PWb8c0PPN4xQc0YcpHvJjQUXecrv00kOfIqLnssKtz0AcMd5MJAq6ta6l3Exnor391guTaq+pVYEitN4Jj2+Ermfyyui6nWJkrc4jI5epOTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=i7zYWIMkRkte9tBW+ijySKGi0p88Pxl/mKH+jaeSDv8R13QtFxd3TGCAdEXsuZ4W/JKIaJPjAZpMjv8E0B8yxbMETv3MYMo3QPGbZ0N04k1ZbGAR3/b7oD/sHejnJMUHD3nLTYiMPZf3ERRZi8QEnxyoWzNDmPEuceSY8jscuZ1SfRqCEwyClZxsjL09bOWlx/wmOKnTYH8Z+3Obj87pw5VxJmDvl25JzE712HISv3b05yw5h2fOn36ZeIl+oTjLSKC0kmDDNpYq0qkgjIxINW+L3oeftFx5U1qn4zjWfoIpuhd/EzPGt2U7phuUoAOG03zz3dUqOWRiubcQtpyIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIreQ1+HJmiev1z2bEWU39E0dFuGu825c8ykSAWQvI=;
 b=iERWkrqJAv9d1I3THaTon5bIYMJyRbXPCXRKE1OfPEWTL32pxRcFmnycmIM4xSjDzAaXdF4HGUQlxNAdfbIFU+7b0GBIOLL0ydJyc/fE76R/Ct9tTF5N3oHoMhADg5IaYHD/+kf290GUDvOhPV3oDmtfXDBflQOC3dXJfUvcxH4=
Received: from DM6PR05CA0064.namprd05.prod.outlook.com (2603:10b6:5:335::33)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:59 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::1b) by DM6PR05CA0064.outlook.office365.com
 (2603:10b6:5:335::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 7/7] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Mon, 22 Apr 2024 09:57:25 -0400
Message-ID: <20240422135725.11898-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: e6634650-80de-4696-0978-08dc62d43862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SWdZ/G6qtrVvxx3nUsGcpnRPjmT1thSAMuAkpuAc0o2j7UQFpe3ifS+h4Ngk?=
 =?us-ascii?Q?yEFYhm+fW8Ll/oEeG09+aTI03lOWyUs+L4kVVNf5k463sBLBb+NaTVGOPhWr?=
 =?us-ascii?Q?Z+cbAxf8er+3kTqouOvxMCnaXEhFuYFdgiDMpPBN7jnWmCL7q+8kR0soNNwS?=
 =?us-ascii?Q?RfeMuMjkJZ6uSXOP2qczvSLYY1Qqew70V1b9zLExV7wXUfoCZDhEXB6dLmzD?=
 =?us-ascii?Q?V4k+creQN41yeIziVEXGAdMaPibXAjbdkqCjJNqB19lLUMXKcss+2gew9i7C?=
 =?us-ascii?Q?Sx0XfC2PgBHy+5wtxYofZyf8DvAayj+hGuFwpw/mu8c5ovpNmUpiuUBlev6l?=
 =?us-ascii?Q?ZhIgofm0ZIyCF6FbC1OXSW5gHgXdEL5tSLjkufS/EUw1Bt3mUoFBN57I7smP?=
 =?us-ascii?Q?Sv8gkfI6ne4LYde7lxYalPyqnVIK/vjaAbBWxUwelEtOnMbiNt9lL5SBv+Mn?=
 =?us-ascii?Q?0J7JqrpS7Eqb3uFmtigQRpMKPv78RsPRotM/dy9nHUfIduFkPd0UorO/mNG1?=
 =?us-ascii?Q?RJ29Cm68X6/yJB8dqKV4oj0YQy/pLB0MIaPKLI45o7ijeAXGt43+1koLROro?=
 =?us-ascii?Q?bVWUzT/muGIZm9seduQEzWo1pNyVc0w+aZ3PDcqT8SpvpG29uRaVUs0/mBeM?=
 =?us-ascii?Q?ncZSu8LOVe+NSePJ2iCggB2rc68reXX7aEfaFKQrvCh94THjRr3ngNHDVs9Q?=
 =?us-ascii?Q?0Ph9JsT9paxD5ScyZtLEtlaqQ6gEz/ZJzfLT8dIBlFZGjxRbc19YZ4hevu/m?=
 =?us-ascii?Q?fw6+MzK89lmQtTfVXWiiUzB5PhLRRjDzLSlc7KH5ByiQBhoDI9FyR2Fdjixm?=
 =?us-ascii?Q?lzFNXmNvyXrrYONWpGHHk/Oecqvtbc7QXOEhflFHIuPj8yEwZT/u83mH/g2+?=
 =?us-ascii?Q?HBqQ3WYT/P3kSnmI8OJO6JQVPu6p/8NpSuVg9bDfXAtXyzowmqEOSB5LSJhu?=
 =?us-ascii?Q?/KJdyVG9pDaaNRBO/MC5zEK5meTFSVmOWRQcheMHquYdDC3ZTIQQ3q/ZgQZo?=
 =?us-ascii?Q?0z04FFhIp320jv9aVuaK3SmQ+wlUvGTW/8i99cHRg1f7QQKJSy/TBRQf9JKg?=
 =?us-ascii?Q?Mz/eSpFScsU6ihe7czwH2+gd450bCDYQBDPGnclHpS9Dip+1cN6lbnQVuT2u?=
 =?us-ascii?Q?FC9Xn9UBy9U+UczKSD/IQ44bOhDenLhBMAGJbhc6LAZIyt7JyXvaNqz0H4Rw?=
 =?us-ascii?Q?+ROGGeLhkJMd3VL6+/IXGhVQpMpFBKDX1XEi5/FFw/E8aiCO+CDvaP2IzzfL?=
 =?us-ascii?Q?ljkFc8/syXzKY7Rhl8VFZ6YjBSfXVy4yMDh9o2R8qMyNyo742MAKt4LBGeCC?=
 =?us-ascii?Q?HVTEWNHntSTIg/MXwxU3XJE8DD+MvETn/Aqza+d0gpUyHJodf4xuD/vrR1mg?=
 =?us-ascii?Q?rcj2TaBaRtglDwI15LOnfFwHgTTT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:59.6118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6634650-80de-4696-0978-08dc62d43862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

Bump the kfd ioctl minor version to delcare the contiguous VRAM
allocation flag support.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c1394c162d4e..a5ebbe98ff7f 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add contiguous VRAM allocation flag
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.43.2

