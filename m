Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ED0EE20B5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B297210E830;
	Fri,  6 Feb 2026 15:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iPBiYJhF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E44C10E830
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0IC1nNL1MXFfTfoCPvYHObI27wGflhezNdqVaCvC948SOVNxhgTNs10iXkO5/7Zs7o5kcMXhIcKQExR4XK6Nmq7udJfnWnDUbnCUgD1wBI6gYoz0RaYJP460dPCSlrsSXcaT4nk686YLC1R1ZEWne1bop69mJQ0P7WeyWfVcOkVriIb1Aq2pDTGonKC4IU6JZw9B+g1uWbF9eyp+/pWlOy1cXLoTT4popUyOZfStqaRxn41TPzdJ+lRTQJTQAXob7rcr4xtV9FMmbaFeIpTE6MKmlcrSU24k09wVQJh8lVNvD6T/neOdpeS54HU/93yR7bbHwPmU7aKq1oE5agudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+EK6FsImTMxQml14nc/yTXAukPipIehEi5rA+p2hJc=;
 b=BYMQIt0Lxk7ldou76s4bUZHpYh378Wyf4JKdGjuBiwmVmHgf4P3152U/2nZ09GZrl9l2nI+UiIcY23PaIt3IhC+ReHGt/IUztvODboMdhJU4j95dgtsK2V832C88whuLxFPpDgsXWDMKu7PJq5TOV+Hh0D10L8UhLXx4nZvLSB/siP8UyeMoZnbHRFIyPRPgy0svjcB0crSb4STqwIk7JogPdPvQjHOgjtNL0vwqpT6raI/CMp529G25433HeGEqqi0L/4UPz0ezb4sepwxnpy1gyawXQvvVvAy/Mevw4t5ldijdpOZCChBuummHRtJ5xY2ScME5cwjC9ZXFU42p3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+EK6FsImTMxQml14nc/yTXAukPipIehEi5rA+p2hJc=;
 b=iPBiYJhF3HnsZTZ88vu8S9N21JlFF+rKw+JZiNGrmhy01n/ApNmHvtzsN6luoBjvMfAAIeaa/muGd23JU2S4DXQDiZ4mNb/ik/nBDue4XNqoHSp1tOWXRMTUplFtOdPZKqAk61dr+m2y6CDV2bL55jn3LJWicGIXLqzkDeUA97c=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 15:53:57 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::76) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 15:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 15:53:56 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 6 Feb 2026 09:53:55 -0600
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Kent.Russell@amd.com>,
 <Felix.Kuehling@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix Null Pointer Derefernce
Date: Fri, 6 Feb 2026 10:53:37 -0500
Message-ID: <20260206155337.654477-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 245b5939-fd60-4848-55dc-08de6597ef6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N6I9QEoH6erde23LjDr2hIdpl+XHKJVHtvkkboKqJX36l+3sakLkM7U1IPdi?=
 =?us-ascii?Q?gBAPbatwiOHKIi5RSMn3KaBIwcHmFKHriXdegbdm1zH9tufXKws9NtOuK5AM?=
 =?us-ascii?Q?eQqIUcKw/5PG0iOTslFUBlgoI42LdQul8Dt+UL5BGiCa9LXaathR8KJQJFuB?=
 =?us-ascii?Q?OwJy17PbAJHHPfYibIxjRoANyWE/Jjg1O/jQKXDBsrKnWmh5ffARHIoZr5uQ?=
 =?us-ascii?Q?/pdfoTPDoYjmVACjfzqAesSDf4Mo3N4nc6hbRHv817VEEIF7kBi6qx6kQInm?=
 =?us-ascii?Q?4kBtbHFdCoBJyyZA9XWtmuMF3REwniqANrbG1VScTH8t9khjX8/9Dr0B4xTc?=
 =?us-ascii?Q?iiieC8vjr1nIGubJgZo34TV1aSQwvRbi4pqZ0QzQsjEXsQ7lgdd4/+2lnfcO?=
 =?us-ascii?Q?JBpE7vc4Rdp6iSpvXz9XgkAff8//l7THEzojCgOren+ha5rdjp5wtsbtQlmD?=
 =?us-ascii?Q?J9eq2o81zijehjn6rkIb5wd725FAHkKhjVgiCOxpOdFr3Il2LmjI+4aSbIKk?=
 =?us-ascii?Q?6U0HGjX8KYfPwjUsLE7y4mq94MMeLOG/+mBm/TT95CjDtvBUM+O3NFHhu+FZ?=
 =?us-ascii?Q?6mw6JN3TzjKfKPGHxUIgKkbBMicIZww0Ps5pFVr2IOFt0zM6IscIlGoE2dEC?=
 =?us-ascii?Q?Or/k0Jkd90tJAM/83Hg1Jj2C/aG/qoaxCIRXRuQNkcW1I+1PWQOvom4dv4Mn?=
 =?us-ascii?Q?qx+qiUBo84k5oKRp8LmWkTmN3UdkU4t+S0IvrlKwr/Wk6k1oN8DJ3b8Kg+g9?=
 =?us-ascii?Q?SpMKfHCzjodMwjnN+0uYdj6pKnNbubDwL41NGnFYst0x2taTj6lx+FeaASu+?=
 =?us-ascii?Q?Xcz3TZzTssuXY21rpKmLj0vMFyTx5XySw/wfPk6c1jlohmYcoe8Yp08iNhWE?=
 =?us-ascii?Q?nlnHd0z1DmhYkVb+yvPnwgyrNhc4x0OSEVgxSIGBoR1OH4PRsP23S/+scsle?=
 =?us-ascii?Q?9S2Rqh+ZQ1Om07Zg4Cs1umONuFT7ez0ggexePiPLopTpUaD0uxKS9OVRoJfe?=
 =?us-ascii?Q?9gZOyoTEj5et8cDed1ipefD4Sma5H9oh+2CQmvzbA+DqUk4d1Vp56XRqsr2q?=
 =?us-ascii?Q?fff2wzskD/VSZporyXBgijJKZHyV9FeQxjJp7qB2XYx5E3xbTpnehdVRNdmL?=
 =?us-ascii?Q?GNd3waTWqF04XUo2NYsc0+kpaX5UWFNKnIuleY9uz/Q2Ekoy3lBP1F276QTC?=
 =?us-ascii?Q?Vhr3AeYP9ypcX5ssXpSn/jigpuDxThPa6ZfrwgWk0AhccJSZ5CanG3U5bsUz?=
 =?us-ascii?Q?dWmZ7ZBbY9i7bp9hh+k6cvHE92Ta6bdjibmfG/yEUuaWJAUMPrfUpcFdtTP+?=
 =?us-ascii?Q?dzVpGKlVcFFsC3ie6yIbS6wv8uC9U9cD6V/OIUIz2QVobZz1LHSePV/ZkndA?=
 =?us-ascii?Q?RgEAxLVi+HF9IDmpk06QJ4RzYo/VywK5h3+tFZcvPGR79tNx4o4LJqYplucb?=
 =?us-ascii?Q?yome2brAI3C2Wisq2B8jAZtFht7vKM69neDd8IEVtjWeW0nK0C5YmuTLoJ/8?=
 =?us-ascii?Q?CIO8uMmjW+DH/l+1gY1xBvb/m02U3L/lCOCWWqG26s45JA6f1pllzPLAhLfh?=
 =?us-ascii?Q?cAxT1t9M+Bus68T8kwqhx6iAMR+nGdqf+zB2rW9hVyxW4VYZtWX2eN0xi/om?=
 =?us-ascii?Q?XcCxxQfPZ48F7Oa7TEnyZ1MNdtMa3pk5ZL5UX4EQoVSM3NGHinYJ/bGEok5p?=
 =?us-ascii?Q?gq+5IA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dDY/F481H/ytUCIiwcchUSY+wx1AC50O6A4A3cKV20X6ecSNW5i5Lzw7bV2pAQYfwRSca3tC9mIY0tgxusT3vfRzZLU7vFM+hNKb14PH8aV7DL4cI/BsZ/yVqrttBs4JdY9mmxGG5JdUtpDuX8fASdIlCijMod88xfQCBHw+IN/UF5COxstyrzMEVBikb98I+aN5PunaUL1S2QJInIIw2fNY+09nBDIlGZN8w7agyBxOPW1Vq25RgSiCM/Q0PA9bWrxzunOGYuNjPxgmB/30EV2kePzyY/l4dMJ4TSHFZKdPA31lw8jh3v6NAqBLR2UrXhmeOWg20US36XR5G7UCUfcPqAhVx1iErewzenGFNI4j8UgctaQSGu2t1TKXPgP1gEH92mUXnXSexqJXZSSm2STry7r+3d68N4i+ww7SDdBMRUaw8psX+p+NgF8hzCg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:53:56.3427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245b5939-fd60-4848-55dc-08de6597ef6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

It doesn't really makes sense to dereference the kfd_process pointer
then check if its null right after, the order of the instructions has
been changed to address this and properly check for a null pointer.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 732ad1224a61..1db565442c48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	struct kfd_process *process;
 	int ret;
 
-	/* Each FD owns only one kfd_process */
-	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+	if (!filep->private_data || !p)
 		return -EINVAL;
 
-	if (!filep->private_data || !p)
+	/* Each FD owns only one kfd_process */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
 		return -EINVAL;
 
 	mutex_lock(&kfd_processes_mutex);
-- 
2.43.0

