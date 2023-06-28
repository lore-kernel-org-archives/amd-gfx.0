Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17158EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8254910E0F2;
	Wed, 28 Jun 2023 21:24:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4ED10E397
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cltkj9RCAWSKKGxclaFS6GGD1IvERJYlNTDqa+ncLdJ1ZQxppsm0NQWXAGBonzXXI9lnTkPKsB+gKDqYAPPqpoib2pP6okEAticyFQjpvZWt4bDm9eIjeJgUgMi8xEbAucWmOFKj/1h5JcxYMy44CVDZqx8R53XY0Hnt5yVTx8W9+EWr/93CG9nKbCX9fo8NDhtPDKAAou2S9yhGmzWgb6+Ilpkhze5WdXxyvfmr6LOSxI8+d1QZS00s2ZW0FQh/6i0w9ukq+DwpIir2oBVxDI5MHkScWGdmYTz+3hTkodQYKWN+HE4FA2EFXU4CCRMKJrsWd3TM8fgRL9S45JXgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=e0IA433XaEHUezXF8tslRavDGhHUhG0BGn6oPWGpBmp3WzYORR5tg179DY50PpHBO9BCljMZDXV4+udaMsSxwCJRm/PyQNoWtadZe6eN6ofyst5I76muXHrm4kex2rMlKJBB1144ScfzOrLbt/L63GEpXNyymhSqCpOaRKhD5WC7NDO45+lumRCegM9sLpqmZjk4aVHIFHctMJATvvf3rz7QQTY/2ub6D8MWownAOyhCD6u3+K4YVxcIjlYuCNKE8WZ7cSq73DcH9R3z8+EnGFSRHcSUkTqj9vr2N4iuqdYIksgJdslYa+yHPrelLuuYJOS/F6rcB+S5LBlWvBIIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=19uw9zP7MLMnXCDK1K12hCVLQ/gHpwRb2/lqaLeDROppyAjUmLPVuEdhSYxXNz5WUbpKnF9OZ/mAIHKVB1KWhv4F++TPHhd+jgrqt6FbTiOwn8MlFWnZ9qz3ANftKoEZBhddYVpurs2tT2JHcnAFdoTyPkWEewC2Ud0LkeRjFOE=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 21:24:01 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::79) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 21:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:24:00 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:23:59 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdkfd: add multi-process debugging support for GC
 v9.4.3
Date: Wed, 28 Jun 2023 17:23:20 -0400
Message-ID: <20230628212323.248650-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628212323.248650-1-jinhuieric.huang@amd.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed12920-1639-499e-eaee-08db781dfd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWDSyFkeGfP2H5qNyoMJUzt5TqBMIGTpHXzWx6Wj1H9Z1n3LQdUubNcl51ttf3mlsse62OOd3Mglqu1EPUYui3n0A1RsMVuRPw54CrTvzVbyaerU7Co50fQtq/AbtkTYUaJP0l7YkIAZOZskwjgaWwuHtNjs6GLmn0h9wDk6KDjP9tn1bJznNg1eu4fhlBR5ia4ls6slQx9tQJZkz68AGZPdUVzhEt168id19oKrcGfB3XXZcUDDt6zdITe7hsH0hMyasulnP7hVUnkEQtXBjTq38BqsaJvtOtT4prjs2O2MtYqlh1OMOhByc3FUQf7CE30KWXRxW3JUz5r1Bwy04cR38xgbVBmuUBWenPcbRTVor5ArE6NEw9vYtOccISpGeccWAdJ2LGqiNSxxChqTb0bj6Tuo8p5wQyHUWnl2kcE5nvIWs6A3er9Ei5varUQiEMe0pok3+7ELP77e/Uqu6LOjfWArY+LAavffiI2xm2M+a5KObpmz13mNQECC+G5EG2Z+Ztt4ECemdvVuggyoF9yKROkWQA+zvZHj9sfEbk7N4zBU2+C9/yYz9fviyVFhrghlQp8thzLVqFQjvs2kQm/GoQ20RfDAeLPGHjy/C9H4jjJK6BFxKfYourjERB8wIWUe97HS4CWPvXfXALuW46xKkAes8dEDa3WKl6ChaPx0p6tq+6Jx5oNiVgcMLEVmt2bYshO0f2eHuhEAwJGgzAiNRxFfEGZvph3Zrn/n4zLuD/eKLDj2H0VlI34FhbKPe4ImiCBWslqVaKv6vileMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(16526019)(40460700003)(7696005)(82310400005)(70586007)(478600001)(2616005)(186003)(1076003)(26005)(336012)(70206006)(54906003)(6916009)(4326008)(8936002)(41300700001)(5660300002)(316002)(6666004)(8676002)(40480700001)(2906002)(82740400003)(356005)(81166007)(86362001)(426003)(83380400001)(36756003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:24:00.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed12920-1639-499e-eaee-08db781dfd7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
MAP_PROCESS packet to support multi-process debugging.  Update the
mutli-process debug support list so that the KFD updates the runlist
on debug mode setting and that it allocates enough GTT memory during
KFD device initialization.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index a289e59ceb79..a0afc6a7b6c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 
 static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0);
+	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	        KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	        KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
-- 
2.34.1

