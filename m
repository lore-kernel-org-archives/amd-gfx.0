Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305BBCCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37EB10E164;
	Fri,  3 Oct 2025 20:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ja7RPrkx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2419210E164
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3uXsfazny48IS+YJ+bAACApi64kiuHDPQREavdGrDWg57KdBKiamosXgB4HwC1fyPDfJwYYWcYZsbrND6/DOWb8IE3RQGjLKc7K9k5qtFWUfBblVe7JD4xbu2Uvm+1vFCoCz7i3pZcS3z0+Gk4pMl9uqbwFqpFLblNSxyfBIf96wNguVLT1RSTxZ4jk1CkdEnleXsoEG6M/bs6m6Xrf4DQWK3AGgRTTTyOuBnOFAKuVZWvxIENTJ2kcFEMHO9BATVxzxop8hMkycOIKLr49Ew1dpz8TaRQ+mlirJool1dxHR1mxzul27ahKlaOwUmClVWeiWQEm4tYt/viGxJabCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0cP8EFhUelVPqZ0lwv7Lnm353reI3fp0c0sNZ4pkgA=;
 b=A//NqHsRn8TXg+e1aQDtDqdLXh7FJ3C/rkTcu8rxKvpYqUYkQBZefiJUdtIw2hDM735z/ehIaCWEJqQel2Lz5ZbD9YisvxVyF/lzyr4dSjCnNRPud8Aby2SFqE50HPiPBlWQEza65OMD/9cVjiURBq9aqNDsy6deQYO6xNruHd2JRoAZ/GGlzCPlzdBqEE7rtizcJYGGsy3MFLyTtQyxU27kaAt5c59P0V1XAtA85zBK4GXePxpeAWUuknYloA38HRLsO1Gr5mQ4SVlimlLUoKGtnhj8MkyJea0gMVr66q/vDCQ0FlIofZ/kX0NpY3/zWpywv/wXrUWPwAvGJgo5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0cP8EFhUelVPqZ0lwv7Lnm353reI3fp0c0sNZ4pkgA=;
 b=ja7RPrkxsDd7/31yMD+MR6akfQcbooPOPGzvm5LX3G7zWyo2sLhEkvkuGwU7RzCu34Wp9mOdbF105PKV6wAUPjrGelGkHp8DtOJlm6qkl2b4pge95gC1dyNktFKaBFFkR7S2peaYlpGeapuFDlikhco63CJluhAdWkg/Y/Cd0JY=
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:09:29 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::60) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 20:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:09:28 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:09:27 -0700
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Robert Liu <Robert.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: Fix two comments in kfd_ioctl.h
Date: Fri, 3 Oct 2025 16:09:06 -0400
Message-ID: <20251003200906.2204636-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf8016b-e2aa-4ca6-f03c-08de02b8c1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UzpsCquNc5IXEPodq6hLxlCfQi7ri2dmxLpJqUhR0vvpmi9yxY9X/UEIawry?=
 =?us-ascii?Q?emtXBJNfR1NdqKVPT5VbbfKt3lffv3USdQ6s2/buDFpZq/9hptpPHzqyHw2G?=
 =?us-ascii?Q?u0v3T5VpVUrT1x7YfHZ89X44rugwpU0gr/Dje2v78jJh/zYe+sibkv7w283v?=
 =?us-ascii?Q?3eptAwHYej4nRbxIgOlqltqZiT62z22PGmouQn2usVaGgBeucLuPZjkUFrFO?=
 =?us-ascii?Q?M9fh2zBilxI625V6iyaicLkwoZd1Dd88qML9ZYLYuAiyYBnGYEYJhHrEg6DA?=
 =?us-ascii?Q?35nl8DX22mzz2rUjMFW3KOSvmm9yMzTsPlkbSQKmlX6z2xXuy/Jn3WN/ToZq?=
 =?us-ascii?Q?cUSygKCGgpB9tblD45NKEs8/5r8FBIZntVVBp1+5PmYmkU40W6kzemXLf4Mp?=
 =?us-ascii?Q?2N6mww85yJ7jL/KRzjwJ6wHYxDdWn5adgAWB7S8sDVfeRGiyzopdmx9s8rqk?=
 =?us-ascii?Q?TUp9MeR9pe7W03z6T/4vfoSKHkok7Mqg6JjgyqWMi3IkHn0yNznSR/g5uVDG?=
 =?us-ascii?Q?/whO+grGrSznh6AEgscCrDqH0b+jgH2UrVl6s3kK5re7Mjr2spEdogqyX3zN?=
 =?us-ascii?Q?ovtclTMvXzxr5XuIY97BzY6CMHXy984Vr6kp9pO6TpPrpJIku2/j2lEQBuVp?=
 =?us-ascii?Q?LbKba2oJlAWb6AEbD+9Q4zWsyyFzWrjx5hhN9YpCmIJZKAVQ4n87TRvMFNQG?=
 =?us-ascii?Q?xYs+JNpr5ZlFC18k311JXOL4gRCKntBycLcBj2XZZ4KG4fJkA4Iwx9BS7Ese?=
 =?us-ascii?Q?u8Z3iv5N3B2oXb/Pgjjdol+UgfFIxH+kYZc0k0UXur+yFd0WicY9CklXYY1T?=
 =?us-ascii?Q?j++X3fBRUfsdiFEjtL0vrMs7zCdDyRkXamfGgASJ9bXRyE+KWY1NDRQNBOaW?=
 =?us-ascii?Q?+HeVeb6ycl82rmrw9fPvhZD0lIIJj3efCIHTJPkzka6v2YOnQH2XhLm1xJOs?=
 =?us-ascii?Q?GGCzrKDCqfLnL+9fnONp3xOwcPegwIAS9u4HZi7DJXHHZijHOO4hObsJx+xD?=
 =?us-ascii?Q?Ky3TmMvIqFBz4Kyeo790vGT58Wrka8Cwfy8FjlwGuUmBDFCZ5WhCuNZB8Blg?=
 =?us-ascii?Q?0C09KlT0rOwh2X2daGqz0iMidok26FWwFaLdxl0Jt0r24oNNbVu1to9Wgs2H?=
 =?us-ascii?Q?Li7KqZqY+4kah6/uKQRP8u0xjt9UbzVfsoW0MVqv+yLGzepMgKEV7wLqJgth?=
 =?us-ascii?Q?Tq0Vkpt1BVGTslOw35zY/CR3ZqmPJcLl7Cea2NqmWLr1rM08z/B2KBYPVo2a?=
 =?us-ascii?Q?Ex3FLKgLwvlZ7hwcwwEH8p69Tixnmkxaj8dw6KKlqYxSSxxMmVdUR/WR5RBE?=
 =?us-ascii?Q?mVc6YkAd+yo1Ub1I5N3pKI1i2oSIYChLzjWriZ8lNc9MBq94zlkT8oTlHMTL?=
 =?us-ascii?Q?dRYaelXl7oAz6Y8UdLoITnIIqDNHeb3LLUPRoBSulaeUwHmmjo607XOku1y1?=
 =?us-ascii?Q?Rlzflht1PM87k84RTe+LrdK3Ei/k+a17vS50lYqCPkvi5sMUh12WdU0VcHIj?=
 =?us-ascii?Q?8hZBRo3mcaWSJOR45bJlfv01I0rD7iPfh9LB7u/A+8Roiyj8/hXUXV9ZVwV/?=
 =?us-ascii?Q?Q4Zpl09uIOxmAkERtNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:09:28.2571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf8016b-e2aa-4ca6-f03c-08de02b8c1df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
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

Queue read and write pointers are "to KFD", not "from KFD".

Suggested-by: Robert Liu <Robert.Liu@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 04c7d283dc7d7..5d1727a6d0405 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -67,8 +67,8 @@ struct kfd_ioctl_get_version_args {
 
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
-	__u64 write_pointer_address;	/* from KFD */
-	__u64 read_pointer_address;	/* from KFD */
+	__u64 write_pointer_address;	/* to KFD */
+	__u64 read_pointer_address;	/* to KFD */
 	__u64 doorbell_offset;	/* from KFD */
 
 	__u32 ring_size;		/* to KFD */
-- 
2.34.1

