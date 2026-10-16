Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051F1CCF2C0
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 17:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6624A11292B;
	Fri, 16 Oct 2026 17:44:07 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E6A11292E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 17:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUb/inyDcP9aVXZI2giNjJLWrMJT82qfD8K89WBpt4yj1JrEkgyadHagpxDLVbtUnoPUNA4PSiF83c3ka9EY7Fl/xgxVj6JPXYBmYvKPOA7zM+I+qzEHl8BbzKskcGkZprgMNBpFhLkGHdykW2fFhkFlQ+f7wgZtm8+DodyeB1copYM4E/DngA2OWMhUhYb7JuSPQ7SwKrRCa3NYt0pHYQI26gahs4IOt18KEO2ND+3iM0+u8FO6Xhx7pm8rcNFZ7S0S1M92ddRVeK5JGFkzXe54TARwQxN41INFP3XuOFO106P+d3znbVParBf458oh+3wkk9w8cuegLI8tH9Q5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGBNWzRxXKa2WhK/b+cESkZivEaR2UYdcWKH/bZ1RKg=;
 b=f27GNKjmJBdUZDafamoqUigfr+Cf6FVD6aBMQqnzJhiFVKLPwJQGHrqTVs+GVK1H3dItSNlPU1/LUWY9sEvRFvxMEPL91nD/CmRQEIlRpqUZuf+OGrAdwAcldr+mzMS1FAe71LuYz85hkeL007yKFBEpwxVD7RH45iSFwYRVP601VfxZvzO2wt3dleHx3ohGS7qEornknje5HLYkJXEgtK0ujCkaf+NzhaLtCH/HJ27doWrP0mg1lEL7NNzowwhX7EllvkDyF48N3xhK38AGljH4nsFISDY22/RnjCdBo4t/IsmT7sfvAtxX4SmhgXiYKLcJYJkseh7FPXz0uSJ+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGBNWzRxXKa2WhK/b+cESkZivEaR2UYdcWKH/bZ1RKg=;
 b=3mgTqsAzuO7vWSvtkUjHoQWvMPn8w+oxpX+eR0Oh3Ceyn93Hpa/n1psK2H2+vhc4mky9IYPFwvS0evM74bfziR0aW0/KPPMNGRq/5A/q+auLj9M3Ogjfq6hpQEJFiwpixW/8BK0COndUaJWW3/NBoh62SN6kC/c0DhU4M8qJ+fM=
Received: from DS1PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:458::8) by
 CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 17:43:56 +0000
Received: from DS2PEPF00006E22.namprd05.prod.outlook.com
 (2603:10b6:8:458:cafe::29) by DS1PR06CA0002.outlook.office365.com
 (2603:10b6:8:458::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 17:43:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E22.mail.protection.outlook.com (10.167.23.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 17:43:55 +0000
Received: from MKMESAKHNOV01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 12:43:44 -0500
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950
Date: Fri, 16 Oct 2026 13:43:32 -0400
Message-ID: <20261016174332.302210-1-Elena.Sakhnovitch@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E22:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa9149f-8b5c-409a-1e93-08df2bad0cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3lQWbRmRmmotkVhPby349P5HFMC1B4XYsjjn97Yp53XJOPEpFijSgvcsP/CXNRO9KCRpbt1g2Q60DVuI9EDCYoONaV6oVh0Wm654fVfFjLVLT8SKUdK57lPeXK7kETJFgULAro/vebzz1qXzV8M1ovJC9O99f/5GjV9Jwhukv1XBDpi/1Bkh8XUJ+2hjGMXtaHavK1qCKOakk1LeikhC+DFDIMYJV0gQ6xFY2VtP8UXUKk02A9DEGql8vydwrNR1YUPLaXf0pFz3157p81fn4P1E16Xw8nev92+AbF06aEPTMaXvZqe9dYnXaaUAYbS/0rl6mS12otyNJ0D0kcjbgfcn0NqTXGpcwGZtbC5j4+M/MqIWl9Ih0pEaj8eNsYSypJfaLsAVozJGYR4Hlljk/osn1APPUo+UJBzs70ZwMim4l2cw2schpiBVyJAv0xPiheU5e8KO/1tJH5CXqRTDkYAPRZxgYNWa0lOcPyzohZlkxQNwP7mqiOFcwx94rh9sCZtkApPw+cU7OzOlXwl4f7s0cWExaGWl0b0tUHH2szClruTfNcGgBNNuq3ONzdld9MQpFMP7lixRGnRICBsku8c7/MTHwx488+kGC2JKE6etv0fuIpcvfx6KNVQMRbUicTWylENoHauyVm9cckDllT4hdyO2Zyyl1qC6ZffSO85h/4kNMeBPZqngCT0eMNOzkzR0aiMRamLeuuSJxbqlDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9rzLt4rCGiacF8hYim81pW3Rb8hlH/KUbQNTiiQFIyMygGVoOSrUDS2OPNEW++tEd8l/aMfgGs0eO4aNYQSiCv3ni1HXYdkNvuBCAeWbYo6MtQ3iD5cUGHzqITxujrE8AuTo2IC53GG7HFRKV6QyCOL/p8FSTIHn4CTY/uVynr7BJrvhqinMYR7uKdnlYKaiXQzse56uHnMxc2Y0rsdbzi/e0imgmS9RsfvhsIm6DphdniZQGkUuyZv0Xxs5gkDV+UGlk5A24r412q6sDJ3RjimNtyy7uzSQt1tk0dCPmfG5C64AqgcDNaGySzCUqPIzlHi3bz4ArAzNxJD4yyYGchDNZUEAZeCW3KjWKq9N78SSfjmnnWErXRyDPQHaWBXejsqgDYuMOMZMDFcpacnh38k/qLXDpxqBsGyY22pW+AbmVtgyq6OfqqypAFHeVfVf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 17:43:55.6423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa9149f-8b5c-409a-1e93-08df2bad0cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E22.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

Similar race condition as Vega20+XGMI. Add the extra type-2 TLB flush
for GC 9.4.3, 9.4.4 and 9.5.0 too.

Reported-by: Shahzeb Ahmed <shahzeb.ahmed@amd.com>
Reported-by: Manjunath Gaonkar <Manjunath.Gaonkar@amd.com>
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c058a00bf2fb..7583e4993301 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2181,10 +2181,22 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	 * (type 2), which flushes both. Due to a race condition with
 	 * concurrent memory accesses using the same TLB cache line, we still
 	 * need a second TLB flush after this.
+	 *
+	 * GC 9.4.3, 9.4.4 and 9.5.0 hit a similar race.
 	 */
-	adev->gmc.flush_tlb_needs_extra_type_2 =
-		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &&
-		adev->gmc.xgmi.num_physical_nodes;
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 0):
+		adev->gmc.flush_tlb_needs_extra_type_2 =
+			!!adev->gmc.xgmi.num_physical_nodes;
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		adev->gmc.flush_tlb_needs_extra_type_2 = true;
+		break;
+	default:
+		break;
+	}
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
-- 
2.34.1

