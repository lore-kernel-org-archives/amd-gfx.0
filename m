Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41633CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 16:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A2210E0BA;
	Fri, 19 Jun 2026 16:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqC11G0V";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECD110E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 16:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUIR1h7UQvTGKgEkyciSz/UuAdEOLKwZGRkRAutPkHc/o2CH5+oyGesAlL3s0iEzsm61JW7n4o70sXvkwPMARv7N+Sf9e0x93Ho1fozrudzrm//GBIa7g0X/F5E5ElwidJbbU1Z9Aylh3bPWEy6yP3nFKqhE+P1LkOro/Ak+VcEw1Msp4eQ+3lnCWwF5WwobcR+sUsx2qQSd/XfKvU1XLz3IgcN1qT69TI3fglf2jYGjOcyc6gBVeYZnG5LJ8bQx8G4lPHtNlnguEQmQkGg0ayzgF10d4JnJgHpkSJmIrfT8kxupLvMJVXdnwNJt7NCmslZQ3r0AfP8OXSDGGMoRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZCOdVGSqPFzdNBQHEObpxOmMuYiKPn2MUObPvnCp0w=;
 b=TKSlCJoh9SdJ5+2tG2hadl05mArGKMoEbBmED3fGPK9uu+6cQK7vawWisIEEPF8qqfDbjCWJEJ1QVFr6NJGnp6EmlE3cJxTGidi/gL/lB4YzJ0Y+BcJEba0yz6U8G3i+8Tgdrjy+HsjIlmDRKSwsypXeIZCuY3Vb5yHK+l0pGqQfF9vYZFFdIHsQCQm2/DQ/qX2lNvGvf7bqdnr95m4r0Hom/9WQlRUaW5/k7edZoO40m1UWERj9ltIJdCF9EkCMv6oKWBkEZmZAGlqXqJE7z8QAXml3gpi/IxeUdj3kKPaN9DuyW/xRt9QliBM7emDSNcruvV46mKwNbwmWEOKg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZCOdVGSqPFzdNBQHEObpxOmMuYiKPn2MUObPvnCp0w=;
 b=QqC11G0VqBX7XJ46UawSE26Ve1D1nKccJXmWy4J0OZka/F8V/6SQGviRgjDSMuculQQqiefLESjzy20jNOoNAhEQ7yCBhJl9E4c638G/bxvdgg+LTCtKzCyZjmFxbV/Ne9NOFF1SV5xZ+DbygsU3TJpoByvD2Bzrr/wlb53dO7I=
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 16:46:23 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::84) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 16:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 16:46:22 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 11:46:19 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: change a PTL warning message to debug message
Date: Fri, 19 Jun 2026 12:45:58 -0400
Message-ID: <20260619164558.93761-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fc221e-9610-479a-e0aa-08dece224b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gki7y5I1NibJxucFOJDyH9mNRp1ROs/1NbqBpAii1RNQIEU0cbMo5b2744Tt6r1fWyuPR0wT+9SgExEj1hs93GS39pnkolXfgwmT79EzQRaj8o+gp/RsuIJ2DY06QZC3SgomiZ9cRDT1oURhXjXIa7rqFBt7FLRF3JOlzWoAAPROPvwdp9VXXNLUsyme9cINJsv2xXY/1ZY+Ohz5KK37XeSh8EsTE6YtQPWJJOzz7L8KohmIU5cv5pMlEYh3LgzpIfG52CZhiV9yzDt/zQoK8MqcsHfqeinPjb7NgpZMaXxqBhs7sDo69lb14IVNk3mWGuszWpT+x+eiJnoHD7IE68HihOO05SkZKEGef+nDEeCxcPmHyVrl1KszrelxJ3KBFwUTBlNXqvZCYiOltmSTv7n9Z4T97ClH9FID1MvwDvVOC5Gtx0QqGpI2tOcpS+CD8lPQ08aWxZVTtfNOuzKkoW/AjGiAO95vAfovD4HaC9lhnnJ66BAHzzldLQFkOsoI+8gay5d0bQwEsozHufZ967pOv8QZGMN6ekSnei4kKtzMEn9ibFlEhPOLkRAvWNJhKvmugUmbJiZQo82aq+whDmE9lRucmvgVpZFh+RfVYXZZeh7lfAYmeSy6Ao49aumkZUZbxBVJ5pAEfGiv+pZC3EQ0rz3uIOlq0O4msCdBIodG3F7kuLolVcN2yCrPmf/sLDm4qLVeJJUQ1jbxLa+f/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uUhcc4oiOchw6u7LMzYPREpQUsG5SAXF/43TELB9G8bRtZebGK+swYbzPQGe5Dj3+F4GHo4/8iVGDG2BE6amhBPo64SGlXbCXbK+o0R+xQMX/DPiKFb+MsRHppsNCHhivUSOj0g8+a6kGa5YrkFoTJV4vdqOUoM6VLOsoy2ccGS7YWS30xxMue2OD1UVFfkDWw/gUnlNkwRCnEBB92XYXy8tNEPMe8bXlZjd4hcWLsPCpcl5gPJ+COdqz+dXXqagPsddcuJ/NrhrAdu9Uwdt50WnRmlHPqGY2SQpl7+zBPt0JQGU/eokVvXpuVypD11t2ipPk9FI41TjnA8ezXn7tNAytAn+HaYM2W+5gu5OZZGeF6WGilFYUIkcc32VD8J23+Kr7q8ErFJmK2qR1KlB1XlyRWIpoIZAQlBBubDwuie3fdwP6K4IBrCscCTlx321
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 16:46:22.4179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fc221e-9610-479a-e0aa-08dece224b87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

PTL is a special feature for gfxv9.4.4, but the warning is
always appearing on other ASICs when rocprof is running, it
causes confusion, so reduce the message's level to solve it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 575b13b557af..566955adb58f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1813,7 +1813,7 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 		ret = kfd_ptl_control(pdd, false);
 		if (ret) {
 			atomic_dec(&ptl->disable_ref);
-			dev_warn(pdd->dev->adev->dev,
+			dev_dbg(pdd->dev->adev->dev,
 					"failed to disable PTL\n");
 			goto out;
 		}
-- 
2.34.1

