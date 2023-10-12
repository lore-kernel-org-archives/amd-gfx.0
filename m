Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC272CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0711910E46D;
	Thu, 12 Oct 2023 09:01:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4C610E46D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHoEkM3yTLQKIBXvhPLg7IWUgGSx0J5JbREd2gBlC6yFDA8xhlOSw6yN14JcKXMXq+1ThqvbkA6g3nhP0cZB0v/0eHBV72HKH3jKayjMhdCUsRc4gVg5qa7TiJ42ywCOnl3kfNhIJg9UViICzEVV2gm7CdySCI7ygbfrq5ySn2ltYqBytlTsrTv85N5I2yKbipDOuUMG79g4J+L9W8o8Q1+cXoO9X1SO6JRWN7mKkzXR7iOnvIPAJQpliDzGDDJexZQEJ4OzDPZkPyjDbaGNZ5DwGoNdbobTOgG7o4mJay0CfgJVn/eWIPaJKFuB4Ul+cAT0RhzQNhjP5Rk92BqXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CghFq87ff/XSdYZ4bugqp2nCa39Lo8HNKo+n8nz7sAI=;
 b=dUDP3+oELnB8YvDOqUfnsAG+xvzhoT/T70TSaMU4qFUEaKSnukFdZh5/sU6IYtmR8JD+qb1QUXTl5nuOIXvYCFItoPHGzVVzJucNrcphfFKUl2ZYmSUiMujENtf8cv4PhBuU52TGANfK4aG9ufaUooteiGrP6kc+1VWV/2dneUayWZZSzQG0YzTP1P8eN+xpjb5VeYUeM3Q52MrOKxCFON1HtckzfrBCd7Q1HtPrILjJFiwS8dRJsGvB2Ps/JHDD1Se31Hp+Y/ri0ZbEPgRuK5jGyEwI6V8lNEIEjPHoNWy7oKdvp2aj2BOCF/NXuu6+xl6E1WAGKFCDZ9S/lC+hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CghFq87ff/XSdYZ4bugqp2nCa39Lo8HNKo+n8nz7sAI=;
 b=HosVw+DfjQM2x4Y4x7zhOapaztANJN6qJA3vN+6RvE62UKYSmGF27nAmCGugK6d4xH+67r38rZ8iyluuYTUhvnQXANMw+kkmhricdsiaRUomCOzVGrOk0uRbbtUqh1VoLjjDOUmoUvsdYhRAIqo0HKhLd1WfT6Hg5FTv0M2HloA=
Received: from CY5PR13CA0067.namprd13.prod.outlook.com (2603:10b6:930:a::25)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 09:01:11 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::c5) by CY5PR13CA0067.outlook.office365.com
 (2603:10b6:930:a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 09:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:01:10 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:01:08 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: record mca debug mode in RAS
Date: Thu, 12 Oct 2023 17:00:32 +0800
Message-ID: <20231012090034.31055-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231012090034.31055-1-tao.zhou1@amd.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aec401-394c-463d-e8af-08dbcb01c7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrZIy3aFx5Mlkvg1ho4+XYAny4dTL+UQzKVk7oCrmlSPzytWRdu4vfDbde7zfzUgyopECUETnq8RMxI2ik11UmGOwZ4C3AC0WGNN77ZYxprMbg/Tvvt+1qx8KXZ+HKoxjTMfB8sQTR4SJomaq6v43k8sy/1CTFDBxGuyImyp4WouInjI/URHhi+SUFCV6TXER244wApgLPIqY/EZmtrOwira0AzaP/szZr9cZqZonuRdowVe99W3wIjOdxUDjETWqHWeQQlG2WXst8s1yueDAxZJPBVbHqxd7WFknXAUfk4KpQWRdw8iequ6e8vULBKG3GhCFWv8O/+R1goow7rSCZPPrHHb3Gj2heeuakIxR6dwsu+H25d/M7VS7X4NWhsfkBIASA5JZ8rWU8+ALTO8mVuIPbKpb3R1FCEbMnVLXjfQ3X2FHQtazEG6S2vhqVRZVhqYSGX+XVhTFTD5fnAPY7MnOP6epr0KLtvDqbst5KvIzPDFFeBzQhRujHGLzGdxHByed5dP702DtMuTQ10qLC64vV/cbGDrVNLD12iKuthdeIFONuG0fvBMtBAoqlLyiszC3da7AedbFMFg4FfLzunx5IP08/anpxJPtHvjl+tUo+AhuYHdgvBMgRWGsygpr8+o49rAzNyiWQ6DzgCfAVywOy5C8KQdu9K/3GCBteByo2xk51QsRzUbxTpRmkRdB/HKtDzzBvdXYiE/ZU7fpCQdiwicIx0axrpzj0RKY2U69WDrrgrz2sjkVuTKwMpTiAxGhnVK0Mwbf28rwzrIFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(7696005)(81166007)(356005)(36756003)(86362001)(40480700001)(336012)(82740400003)(36860700001)(426003)(26005)(47076005)(4744005)(4326008)(2906002)(8936002)(2616005)(16526019)(478600001)(6666004)(110136005)(8676002)(316002)(41300700001)(6636002)(70586007)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:01:10.9791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aec401-394c-463d-e8af-08dbcb01c7d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call amdgpu_ras_set_mca_debug_mode when we set mca debug mode in smu
v13_0_6.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..55b0846337a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1414,6 +1414,7 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu_version < 0x554800)
 		return 0;
 
+	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
-- 
2.35.1

