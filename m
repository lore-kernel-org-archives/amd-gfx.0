Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2C8C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1C410E61C;
	Fri, 21 Oct 2022 07:36:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566F510E60F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDuDGCsf2w1Jyopych+q6/FLL4jlcCn0j/yvOOQW4LwqTsWkWOmTieZ+41+/cE8a4YoSqAlOd7X0feZkui/ArdSFeb82YNsV0Fn5hH0j4gyiSTYWp2fcRqG7aYM3rQRcHH3nxVAk3FGqjuVuC3eNbzaQ9N210qrR1Pz9WjkFGzzSi/mE2ZqUU3XKZd50NZBoSpT+Vzi0zfBuyNYBCf9uoQcJ0LkERqG2DcIEjExJzKZct56fFWOdkBp2xrbBJQehkmaEFFDdbKeFSuO3efCWbFblIzF/fwaYAAwkteEVPQTJfzaVIeXwNspvZ5Xy3kCBzZ9w3CfyRHAOP51uIXK3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms/KMTpEuoHCqkjKhwDy6NDkklxIfNWcGRhV+9IvYr8=;
 b=KMsAZ4pgl5P3HF1tjOOR0M5p1vaLfwpHIDM8Wtt/AS/Yv77Lg+6aDskuDUHQVbe0YWEeQFO6QlwPZUKaO7j3k48mQqwKhfE0CHIIiRYGEGmVCH3os8vT/5qE5k52kt9Rwd+r0+2hVgd1NlVgT2xoe3gcYYP47RFuf/ZGPNhfJ+OW3HZkgJNSIVmPT3rskJWfGXUTLG/i2XFEY1o5cXR4uU4MXrMB2jKu8RlMslpuvSVaskzcdYPK24HDYq+7wrYMqjUnTKWWwCV26BF+ag/WM+xEbTJpmGlRmj6eAf0/rvGQP9ClWdi7Hj941BEZYgZ35LHofDykJapPF8YMxm8dSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms/KMTpEuoHCqkjKhwDy6NDkklxIfNWcGRhV+9IvYr8=;
 b=Cyf003bEhLWuDNBQeebNpzi2oGZXUKIMMMkobHzUvzs82i4Ow9SAHn3wWwHiq1Lj26v7eDehQIgvG49k94F8+o72zXxdzJuHIZpMzZHH51O5RXQPqnDCmjAUQx16FRF4fMYcAfQpSQWGdNqR4ywQMd7NjAJJN9tT42cfaWIi930=
Received: from BN8PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:94::23)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 07:36:20 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::9c) by BN8PR03CA0010.outlook.office365.com
 (2603:10b6:408:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Fri, 21 Oct 2022 07:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 07:36:20 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 02:36:18 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add RAS poison handling for MCA
Date: Fri, 21 Oct 2022 15:36:04 +0800
Message-ID: <20221021073605.20352-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021073605.20352-1-tao.zhou1@amd.com>
References: <20221021073605.20352-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 006a652c-3e32-4c70-7ee2-08dab336f261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVZpUocmXEyFKicrYiRnadMwe+jVJOORg+Ki5LNucd+hqeY9RbpV8vWLJg+QQcZfsojW3WbHSfkbbPK2Dav/9iTuDkZSbAkbgAWVu3SIPRrV4WlOqBRUSmOlHom9bgHIs7UM/cNfxdracuQTFSy0FCffX2f9v8gH6zePwArfAYMv1YsoPvziXxexXg8itlcuKx1piLrKYlQB81my9KAjVjPziQZVHHV7HgICKIhqP9KkwSIVoQxN9pw5Q3jaO5CWA/YbbUvO2IZdfWj9pj0x/8jCF1paVlwbPmz8pNtsnRp/LzKKzYcTmGC7aSLzaf0V1gFyxxqQbBUzcpGgHJFierY/QaUd2HSN8TtXJlltq8Qn6iiEwaJa6iClhhdYEYnCM3Q7TaXnyjrIWWXruyIjxpPak2ZoNaBUGv6iQ38wLBgZEK2WRG4+LMp5UNqvlvdhiVKS3Cm1Ep1L63MDivwRQPDhkhw3HtD+yLKBOhs/Kmhb9t525xZt64au7GQfcKRDuyCS9Yz+6mm1r+ooJoMGRvQW2+53vPPc0ZfvHgVkwam/RgDTBpdstHNNM3L+U+1ADnihtNIao059uUKNV38noYZULb4nQPf5H8y4xV/dt7vLX+1Pf9F0nDkpBN/fxzoXe16mqo64aJiaHGfjnQk0cZeHiEAXRXtsKU4QkNKcekJBZoQdhpghWDoTnB1+GV/iAxulurGnKcKlLCQPLF7kDPin/xlGXDs/TBkSS+VzjglxXFIzF3vYEurw3omu1DrUzqgQi+80p/kT6iCUbOI7n81E/+j5VyugTcCiJXfcpmGznuERb/ac3R1xUycUB7hw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(83380400001)(426003)(110136005)(70206006)(70586007)(6666004)(8676002)(6636002)(36756003)(4326008)(36860700001)(316002)(7696005)(2906002)(40480700001)(86362001)(47076005)(40460700003)(26005)(5660300002)(8936002)(81166007)(186003)(2616005)(82740400003)(478600001)(1076003)(16526019)(356005)(82310400005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:36:20.1959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006a652c-3e32-4c70-7ee2-08dab336f261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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

For MCA poison, if unmap queue fails, only gpu reset should be
triggered without page retirement handling, MCA notifier will do it.

v2: handle MCA poison consumption in umc_poison_handler directly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 31 ++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 3c83129f4090..758942150c09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,19 +169,28 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
 		bool reset)
 {
-	int ret;
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	struct ras_common_if head = {
-		.block = AMDGPU_RAS_BLOCK__UMC,
-	};
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+	int ret = AMDGPU_RAS_SUCCESS;
 
-	ret =
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+		struct ras_common_if head = {
+			.block = AMDGPU_RAS_BLOCK__UMC,
+		};
+		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-	if (ret == AMDGPU_RAS_SUCCESS && obj) {
-		obj->err_data.ue_count += err_data->ue_count;
-		obj->err_data.ce_count += err_data->ce_count;
+		ret =
+			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+
+		if (ret == AMDGPU_RAS_SUCCESS && obj) {
+			obj->err_data.ue_count += err_data->ue_count;
+			obj->err_data.ce_count += err_data->ce_count;
+		}
+	} else if (reset) {
+		/* MCA poison handler is only responsible for GPU reset,
+		 * let MCA notifier do page retirement.
+		 */
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);
 	}
 
 	return ret;
-- 
2.35.1

