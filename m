Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108E0C77B78
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BAF10E222;
	Wed, 26 Apr 2023 16:28:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F323A10E222
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz2TTdMMCJQbVlzCMzHXOSuTG3AUZ8EwOva7taW3oVYOjcSYlHKsMaCD/uqT0NJHN4z8U7c3rxl8u29Ndw8+vfn6UYHi4pLY+G4LgNHGeJhzaZPr5D0HPzfXBrF4nV1m2P+r0uxy1cxd/G08vbTKUpEPeRuRZnSYG6Aux9uEFFrV/9fPQfuCktRedx8WUmw8urvYJXn8i/mHJTY62/fZoFsQ0l+KVMrZ3I3UyOr0f2DuKC7dBJeserELrGA743mxIKogjzpeza/GZXElh981st7qZZhXeoT8p714e96h1B7pxUxc3mt50cK7wJ5Uf3lSib4cHupOkSrh4/l7mhTjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+L0VrURazCynqNUWzucPwjzIXpHGMExUFrcKVsBmSc=;
 b=IIdMy4uM5P+3IijBh+lQPGfan2u7Z/4TpGMwRMQpPdjg2JOTmjIcqxbxgNPpylHFrTnLBiGs554AOs7kzCapzmd/IkLxalZi+mQEhUclXuDoR1JfmhSm4dMZ0X9zWsdTCF8ouOKsIeP2JOX7FxfdnfCJ2djjXW4WiHggQs0tS3L4pUQ60T2pMr89Biu3PWPBqxQZwzLJJLSNUxtMfpjqBg7p2xiAZAmz/dmPIrUp6M22PaoSj+m0VCTKbSCkZJBZdF/PajBV3jQur+wpAz5gZafZUcOy9EWGZXsCCgBJ1R2InF4P4DFUymFsJWcw8aNYp986+WNC1JlvULXE2Pxfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+L0VrURazCynqNUWzucPwjzIXpHGMExUFrcKVsBmSc=;
 b=BB75s12bKNccAoLZXDHqJiawnv8HLmygGwMdJLkDiE43J3LbVLocN19Ds5hPleur7RdKK80lGBsHIfyWAxOIfV6qmUT7nLqNx1KQibiFXZmN+JcmNgatFHlDhaobwGExtn9+kdeO3897Q7IIlw6eQoaTb30wE9WOxI8fqE7WZ1s=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:28:19 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::ef) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.5 via Frontend
 Transport; Wed, 26 Apr 2023 16:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 16:28:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:14 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:28:10 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/display: [FW Promotion] Release 0.0.165.0
Date: Thu, 27 Apr 2023 00:27:11 +0800
Message-ID: <20230426162712.895717-8-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 566d8a14-792e-42f8-7618-08db46733ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6HgFAx5AhqCym/hpHMbVfg6X5iu5pmM8KlSdEuogTH3VVfErS2gU50WGhMra9iw2CKHKaqoKCeZo4TI7vPrQR/v44GJSNoJrpo+Tw8kpvQLCHS7H8gyvnN4PH1RISw0FlA8eehM4MzbUwFQ5/eOZ8+x2Db/riLLlyWicEPGpjOvVxzaaaa8Rm+E4dJv2Q9NJXXKU/lcH0v83iVEueAkDtvi2GklWgTgKAm2zKP5938HDW6wIa2MgDcsjSlqsXvFXBvI1P310QepkuhOcjDWmdQzZFloj1ktlMsEc+OjsNWDjnePToUqBcq3BZ62vls5wI7HibYAdcPytB03Zmr1IOEFWQeys9slC7vowWtqUu0Ynv/RD7YZsFd/MJRizcZbSwzvlT4A+TZ5k3yZAX6mAOkVooy7V91bMPr+Ke5z6ROSh5TLaQs9XwOFyXRo2PpKQVgQ1x/McsEwoTf3SW7IiJ+xpBDOX4ZNTgpAVNBiw+aLUK82h2XJFQckMHs6UtBBiZju+1HXZNY3dzihKgs9Dq4OH8aVTjdq7n50WUQVk+WY/A/2eoogr/rJEUvqR0dyIVBRdRGCY1g2Bu/C9z2KhhMhUPERZl9PnQxc7N3tcqCYikvWIt1Rf6Ajhx08Lo1ST+iXvxL3vv+e3V5WLboBp+rhAVrUnwp0a729b+ZhJi+/k3y21uo2MmbACLIG1IB2E12GsvSV2mpESH0YhRDXOTjT5MQWuHGX0FTKqtZPmLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(26005)(1076003)(81166007)(356005)(82740400003)(478600001)(7696005)(6916009)(41300700001)(36756003)(86362001)(54906003)(4326008)(316002)(70206006)(70586007)(47076005)(2616005)(83380400001)(36860700001)(186003)(40460700003)(40480700001)(8676002)(2906002)(8936002)(5660300002)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:28:18.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566d8a14-792e-42f8-7618-08db46733ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add dmub boot options to disable ips states on init

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 09d4d0d9b92c..af1f50742371 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -398,6 +398,12 @@ enum dmub_lvtma_status_bit {
 	DMUB_LVTMA_STATUS_BIT_EDP_ON = (1 << 1),
 };
 
+enum dmub_ips_disable_type {
+	DMUB_IPS_DISABLE_IPS1 = 1,
+	DMUB_IPS_DISABLE_IPS2 = 2,
+	DMUB_IPS_DISABLE_IPS2_Z10 = 3,
+};
+
 /**
  * union dmub_fw_boot_options - Boot option definitions for SCRATCH14
  */
@@ -423,7 +429,9 @@ union dmub_fw_boot_options {
 		uint32_t usb4_dpia_bw_alloc_supported: 1; /* 1 if USB4 dpia BW allocation supported */
 		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
 		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
-		uint32_t reserved : 13; /**< reserved */
+		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
+		uint32_t ips_disable: 2; /* options to disable ips support*/
+		uint32_t reserved : 10; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.34.1

