Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A09EE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDEA10E4E6;
	Thu, 14 Sep 2023 02:02:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E6910E4E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVRZhKGOS6yHyfkzPX5aVb7vwLfGrUbpmRzelN4iIzKVFKqeaRdT58IhmbPu2jGhloi2IzjEWwkf0uoBGd6OrAtHxGC3ZyurKEQ3yPK5RXtXCV5c5+f82obuXrJesdhvC51a/8IvK4FPrnt+k2p38s3LPkkBRpB89WkvUX7ypjcZHSrsRqhvrMdKfD2PWbLFveLKKA9CqhUHSVMJV77Xc8fPtnv5UWGLusJT8gMl9JFLKUeJ190cNNqnnzLc9am+RFfm6A+dhvnlkH1+q4fxxfLwmdcBDT7boXeaMaoBI3I1Y9dUCdtvTo+DbQLrJtWt6xHJHvtKMX4+LSp/I05vMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ZCno0Gi6Z3ByWR1vxVJQvM7fxk/KvT00EKCRWek40=;
 b=oPTMH1fHx2VrYO3sWzFdwiLO3QXldhLQiLt7u2sZaztHo6pl7CTJjcDv6yzqtQIYMWMNqX+DT9omBNkhridPRPwqlsAjQNxTMK4sFM+4hmdfMv7vbMDedzulHdxdMJOH7LKEVKM3xtAnVd3QB4kX5mz9LtjXtMFmzf8Waq1DqB8lTJHs08pUmgY1Y8cS5mbsDYJQ5At+71J5vYH2yJOMSFJ5AR9Df1DdWfS6OyioPUE6IsZo+McO+qv8z4M4UraVYwPcQD93NnqSPOZ6OBYFkpT9jRnBdU7M3ulkzSM31GB1tNERfOBtfqEsV1Yn+MHsOGOg3rshm5rKx7PklAVzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ZCno0Gi6Z3ByWR1vxVJQvM7fxk/KvT00EKCRWek40=;
 b=iMxVTnFnSwkcVkZTuRc9wrOfJmB6qcbAiJ6kUegt3z+2ZdKQOT2HxLGaStNWwGn5+rIp9OwJ4mxBlzvuFo8JmIFERyeVCqV6uRhjzLTyurfTkENyxF1sto0oLQ7T2zaETNJozK2OVg28enM1/5Jue6ad65mawe5k+rlfW5Mflng=
Received: from BY5PR17CA0017.namprd17.prod.outlook.com (2603:10b6:a03:1b8::30)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 02:02:14 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::c3) by BY5PR17CA0017.outlook.office365.com
 (2603:10b6:a03:1b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:02:13 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/28] drm/amd/display: 3.2.251
Date: Wed, 13 Sep 2023 20:00:15 -0600
Message-ID: <20230914020021.2890026-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 781f1c6f-8e27-48eb-8267-08dbb4c69d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P56h2y6vUneEjGQJK3Xej1PjWq7y9DZkSkPFWo6uOCGjdL5GdOLc1X+BSt3VbClSDizQy7QWi42nuEuuBdZ4Ro6XekVENZlQzZzXKzRo6fK/01KUr7bT2C3HoQdcMkmTQ56qcEw/Y0ZbgLwKrrVNwhtkVzW2GVjhV27AP2lA9OmlfytvXuiHlXP/1ha2fSa40hbXo2CeMkx6nHBcyTpBKS8t+mu+PGKDb14S7rNxFs4ElSdKJymrBZci9MClYMdprFAGhWLJjjYZ6Ay8HIn6mjowhhHL4xBeff416ZZBa8hfi/0Tomd2t1qCLDWmS5QiJHPj50+8ZFqcp7F4QWIW6hAX375qEZS253xBbV9ps5GjQa1iBZKbV9+aOB3/FmG473+FApoxgFLh3RpCkp3N8+MyUB1Dndmv1OpM+ErhvyULpyi2+JPrX6E39IM/VV6k2PlqW/D5aErWOSUDku3D4eSpzohzBatglFPpqqy3kcl+7HbLE3pXFzsvldskNod9V/MsboE+m2LY+b/tVWapdmpogAdtDzMhV78+Wq9RoUeEPv/ZA7HBlDmq/Zs3x4pjprB0+rJGvd0xFdMBfxDM3Ke1sKZYwc47K3TGrItCpUKhRJmnPSH8r42a7U0dKAJDPSovPDNSD6xkktvQr4jGm1URF/P+infMhPpHp88R8lyeZYPzm+slMr10cFqXFgeNTRtIq8/Wt8CngOa3toZ3rljxD1wWwwuUoUTzysUm50SYP42K7Qr+0q1wjFxSw/gzssIkMCl2L965Tih5m2hBDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(316002)(16526019)(83380400001)(6666004)(47076005)(81166007)(36860700001)(36756003)(86362001)(356005)(40480700001)(82740400003)(336012)(426003)(8676002)(40460700003)(2906002)(1076003)(54906003)(2616005)(26005)(478600001)(4326008)(41300700001)(8936002)(4744005)(70586007)(5660300002)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:13.6944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781f1c6f-8e27-48eb-8267-08dbb4c69d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f7e207efddb4..48021d196484 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.250"
+#define DC_VER "3.2.251"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.1

