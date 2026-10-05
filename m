Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CC3CA5FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 18:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C1E10E5E7;
	Mon,  5 Oct 2026 18:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zlo27vVf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0459C10E5E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 18:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEn2hncGWCOUOWqgupiKOVpDdaQ8OwjQnV/bcjcnBu+pMpfz+SzMYSaUi1ww0/I3TGJZuEx3RKuZU25b/gBOQzFJiMV+qV244cwKqd/oQWVemU9P5huah5yc5lPbEs8IFZqmL/nQ+IdG0KBkebiac7AheiGLMiSxVFqYr/684QmWOucLVUPVA2W0nGS+pGwvpw8u/lmHeNBWXL2mz25g8MhUPia+/46G+ib3ApFHIQ+zn5sUk+lWPaIB4089vaH5v2onEMA5Btka02khLPZJxLEEXPGyetDhcepY+hyyRdheDjqD+/+cBYFafOPgcwkCethJEiUNGTZbkhrrAOGi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4XZjvg4bZWXtjDiJF7UYJpmhDtKl8bHlrYlyiDkL5c=;
 b=eIxRS0ct5h+D7QCVpr8/wYkf49G/vlIG3WwTIIwqHmbDWbJY8ggbMy942YIqLoecLLBOuuvlwPhh3gxpsQscrGdMdtCxZT0hKOfF9y65p/HywC1vz9TOyq3zLO6WOWiUR5Caibj7O8aK7t50i9G/9xsvQy7s6U8dnZYVOtN0edToAVqJFSyz+IRdWKrS6m//3xcGKI/0tZARNqF8fij8iLw2I49FLpMPjL+8U00NPuuLMgeJ2HqIAllT6jvuKsD2PxBsctJ0Z2lAiLxT+keRwWmM+Dzzh6cyXZ9/aFyerPlgZooRADemeC4LBwBwekM6votmjy1kH43UKpQFRaOiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4XZjvg4bZWXtjDiJF7UYJpmhDtKl8bHlrYlyiDkL5c=;
 b=Zlo27vVfe9Mxa0VDV1HCPlpK/SNkShXeuGXNTIbJS0tNQUlYsoM1+0sDQxKmMNbMy2sn73CdzRIjYDI3V7hjb1CQPn0jLOSiiHY9VACrvezd3sYyrai0L36h2oWwIpWQfBSMnHvBBIyAH/Zha/Ewxnr1zBxZONQNlT7UPX4yWfc=
Received: from BN9PR03CA0342.namprd03.prod.outlook.com (2603:10b6:408:f6::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Mon, 5 Oct
 2026 18:53:00 +0000
Received: from BL6PEPF0006C3E0.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::20) by BN9PR03CA0342.outlook.office365.com
 (2603:10b6:408:f6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 18:52:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3E0.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 18:52:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 13:52:56 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Fix svm_bo use after free in svm_range_clone
Date: Mon, 5 Oct 2026 14:52:45 -0400
Message-ID: <20261005185245.1060657-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3E0:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: b18d10d2-1d0c-4b81-6c66-08df2311df21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: AmUHx03WSjTem3z6oUvrczQXzprPlcYs6jSBJ403DoRq/kX8Sr5EYozJYg/h9R/2NIAAimiTbIs1CyjoCyDLhihrnbZ6iY7EtQbechi8NT7SDQQVDIMoIK7Ku0QpX4i/JhJ1B9HpRHl0dXua1J6j/ohuTyVyZG0RduwDo2nwMo+mP13EM+JrvP4pnnWS/pJ8OPg6wXHgDQgE8E7o769+Bucozr2FjzWuC4FotPgkVX/cHG1e4sPYiOHItUcd2CJFzMyAYDNanCc3pY440TBqfV1Cap/totjnoszoWgLmXr4u3A5gHoCWjAzt67zcW9WLu5i6vR1Znyoes4ra8mijZ9sLiddGImWh+YEqAW4H8Hoqp/qEgso1/Si9zwXT/ItpmH0GCgCIxp9O2I8pm3C85P4wVveF2axcOS7YX44WCnu1LBUOJMP+FctFAebltoAaq4dYNqFnSddMOXamdO8dWJ3ZDkuIazDki5mPY7D7ZbNrL3AU3vco+VFd43fW1ttHUrr1S+yQ2H7Siuq1EZi1+K+/NpuObFDU7KdHtamUPxSfKsk306QADUueozLvKbyZ2HzrCx8/yL/l6eaQTThEDcjKzW10lCV/6nlxbOkM7Adb4Dd4v7x5DY0l8Kk43K3wtitFS4uJ85YkpeeDsv14ceo/1WnWi1/wJA5tvnMHSaDAl1OYv2Fa3W5n7+poASTyRs2xdV0zdoL0bqP4CnvSsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: reVOfIT/y0Kxuxp55o9gsSgwMzs3KYJoTyW1W4oweb2nu94wMw6MpW2xBO6kRkwpGGrz2Nq5iu5Az7UV1Yag27qsB2upWmLEBQuArElaxx51fAOloz2Lw6N9oVPztG9qve8yXavfdZ3X77y2IS3+gsNa6vp2agYrJYVpVZgvrW+wssMzVq2Tx85g0WApi0D2iztqyujIDITfFEiDrn3BgsQo9mNwbrXWh8oZGUuy0WzVznSUaFm0KBmrL7zHfqConGM5QgmfQe/LSExlK/LEePDOragw4kNQTP2XWFBdYUOo1JYx48MCGZGV8/RtDyuP5IcAk5iK2eW9h6ob5uODnjAkpMxZurMEYJ7wAG60HKc4G2GGqLrtIod+1kHwVpkaKgJ8PE/G9NaH6iJgkiVXlPSxO2S6u3S3660FBw+ev2xJaEyRARSOQY7hgCU5U2/m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:52:57.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18d10d2-1d0c-4b81-6c66-08df2311df21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3E0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

prange->svm_bo stays set after the range drops its reference in
svm_range_vram_node_free(), it is only cleared later by
svm_range_bo_release(). Taking a new reference based on old->svm_bo can
therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
pending, leaving the clone with a freed svm_bo.

Check old->ttm_res under old->lock instead, it is cleared together with
the reference drop, same as svm_range_validate_svm_bo() does.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..536e804bc2c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2158,7 +2158,14 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 		svm_range_free(new, false);
 		return NULL;
 	}
-	if (old->svm_bo) {
+
+	/*
+	 * Only share svm_bo if old still holds a reference to it (ttm_res
+	 * set). Otherwise old->svm_bo may already be at refcount 0 with
+	 * svm_range_bo_release_async pending.
+	 */
+	mutex_lock(&old->lock);
+	if (old->ttm_res) {
 		new->ttm_res = old->ttm_res;
 		new->offset = old->offset;
 		new->svm_bo = svm_range_bo_ref(old->svm_bo);
@@ -2166,6 +2173,8 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
 		spin_unlock(&new->svm_bo->list_lock);
 	}
+	mutex_unlock(&old->lock);
+
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-- 
2.50.1

