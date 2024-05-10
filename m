Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FFDC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278AF10E176;
	Fri, 10 May 2024 02:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGSwxyKX";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8262810E176
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4YKFZkfGQqcaXpt8+gngAr3oN/kbwr/Xo42WX+9dEDBNEoAd3SPGKVhQC4qXzzE1dSfXIUZ577ruARrl5SLKmPpu8H1IUEyrIOSJKJpH/DrKq+9pmq9xl5h9trPyD/d5YzVa9ILWHljDYSORMUqOupkPDKjZqL3Wd+13s1oRADa7eFyEjrKPiFLDpQmAcRrSRu/wJgHFqXd8c7Rl2eufsDe9Qc5wXY2i7L3HdPJmG3rHt869Y8gLR6Ish0G7zhQ/E//fRxV8hOm8vFjZanyvVXnu2SAHE74yE8ETdf2zYsXyetDvS8E+cVASKeaFGj+5H5xSwIwEiSKx7ySRu7Dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLkCF3JYTk9PfKRxmKTRl7iJeysFzT0M0syU+F9vNNA=;
 b=HzbWnAVSV2s7DAjzLCoYf8EkeCFuN3ABI61uRZq4R/4b+htDPbqmtM34xauC2/n4ltun4foLyl380LtwN9Yt/Nt44vE8tY7lsmHboSKZTkRj3hkXopIUvUpOCv+t/m7EHnyXgbEzZfvny2bt06rs8PELHmQAX5J/o9o+L5Ea5iXTvBi2IzCwZYPEbeq4bcGaulpzkLe6dEwJPQk1ugv9dFZLSTd3Vk9y1codDscFJZFJU+bmnJrzT39qpZcAznBXDr+A4qJHU1/5rAApEo1XarChN7umxCv1zUpLhnTmaEQcbW6Gf9hS9KXH8OunPdR3C4JfeZ6TLReNcRa/h/Q6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLkCF3JYTk9PfKRxmKTRl7iJeysFzT0M0syU+F9vNNA=;
 b=qGSwxyKXJAm66aMSRRRKMrHM7eGGQc74kNAsF3U5K9Rh9oATdkWwwRZrdlOcUMn9TEcUzM9haiTSJLCVL+Pmj/h9jjTJDq0nKGaRaP074dsaujC7ImDfo7u4n+DrqNKEwlAPVQOVOwmR56LFewbAfssMoCghnDHKWgNPj9WLX5U=
Received: from MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 02:53:44 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::37) by MN2PR22CA0011.outlook.office365.com
 (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 02:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Fri, 10 May 2024 02:53:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:05 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 11/22] drm/amdgpu: remove structurally dead code for amd_gmc
Date: Fri, 10 May 2024 10:50:27 +0800
Message-ID: <20240510025038.3488381-11-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 17362401-e4d9-4435-b844-08dc709c67df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fY1BpLzdRi9ctwC68PxEszfoN84K107Fe3M7HbjLnIdhRboQtYTUbWvwGK9G?=
 =?us-ascii?Q?O1nXZwpR79bU48FRVGd7PInJfVLTOyjTeBWfCPPTg8BqDbLlj62kQyF8+kGc?=
 =?us-ascii?Q?agjku/ELRwjk1mr5uy8nr3Rp8t/wQQV8f8aX46DZubZITpr8lbj4/sN55qss?=
 =?us-ascii?Q?2UtkPmTDX721P/HnCZlGrEouHsc6DYR71S7THPNixiY/pJT1LyCDEdUT6EkY?=
 =?us-ascii?Q?OU9OTpA3wZUm8cAC4VB9nyMdE9vdCTFM6VXffwQGKuYAb+C0bD3aHPUTnRL4?=
 =?us-ascii?Q?HIB1XBFJXvWcUFqqxEJovoSmOjOFb74dcYnOPqhIp2VKl/jGlZaVObOfQHvE?=
 =?us-ascii?Q?uONEyKBMaufAqP0KnEeQxpS02OPe+itbtBPGKfvCp3Pkg34Y7oStpeiG0PEL?=
 =?us-ascii?Q?9NRke+myWS/yMMf37LW3gjECRGIPw4UnBsCSFH0GP8jc6g40Csjf2bzs8B4P?=
 =?us-ascii?Q?NY3D6aJLZH7Tinoyf/oRBjXZJRVGVey6CgRiCYGhDKHjpM92w987fYyc32w5?=
 =?us-ascii?Q?lBnQjG72+Dy9Ok9ysG0NnnQkxoMyjbnlMrGij+Wng+FU4x63+ia0zoWHkDW+?=
 =?us-ascii?Q?MX58uunSCpTkNTN1yDdYiq2Pp7qDmPXbw/cZMcF0J9U2K3qX+WOqR18h8KkW?=
 =?us-ascii?Q?Gsnu7/6LB/QYj9vIgw6qmTR3GRwkfiEy0t9tXkpQ7sms48lVl03qKkxm6KN6?=
 =?us-ascii?Q?8hdrU4ZfymMf+4niE2IAfWGK18pIrXZLVSbxRBfKWfwOkkXOARtLD4+ky+T/?=
 =?us-ascii?Q?ojoYdw7g9pk2rop8fCJa0MfzXtF5v5wlZ6A5W9O76uH10U06q+IcbQh0+BpR?=
 =?us-ascii?Q?jX1I5hz11ep+TXPA4oi4hvhJdWg78sIy6kfIwYlrEd9UDQzNdKyG8jSlmUhA?=
 =?us-ascii?Q?4SkS9GZK300GKaDQTvfaXARWGL27tX0m72psitfhMFvwtRNyGNlToi0vwsaX?=
 =?us-ascii?Q?9IuTW7J7QnG38/wA7rrGoDZmvI43EJPsNszzRAhFf/4OwdX1RS86as8xDtx2?=
 =?us-ascii?Q?v1etNN0H/9wLOQ1IltDpaeHaqHQg40C3laWP/nXakum6aXfg/keD5t4KChOf?=
 =?us-ascii?Q?TCiiFzmDx+qNy9/uBy874ZRybQxgLDR0pPsiPUoalyZPV7ju4zBbausmw1SH?=
 =?us-ascii?Q?RV/sWtU3G2zxLzK75gyX5PDg/XEOAP1QschXIR3ojAuKHEH+pra/JMtRxxFk?=
 =?us-ascii?Q?EnItkxhP25/9xKQiLPIKb4CHt8vq2lrCeWXdXOAlqTCXJXEB8D39Z1ItuUJb?=
 =?us-ascii?Q?MZUbfZbvHhvsBE4f28hjS+6uzkekt2eywiRod/tvyK8US9EhY4XuSRgogN56?=
 =?us-ascii?Q?5z6vY4iVYqUcF3VqDAvelZQvwlwxUgfJMlxoYF2gGBz0Dh9SoNS+ZflwOyM1?=
 =?us-ascii?Q?YZGPUPE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:43.9380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17362401-e4d9-4435-b844-08dc709c67df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

This code cannot be reached: return sysfs_emit(buf, "UNK....)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a5f970fec242..f8ed886ffca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1148,8 +1148,6 @@ static ssize_t current_memory_partition_show(
 	default:
 		return sysfs_emit(buf, "UNKNOWN\n");
 	}
-
-	return sysfs_emit(buf, "UNKNOWN\n");
 }
 
 static DEVICE_ATTR_RO(current_memory_partition);
-- 
2.25.1

