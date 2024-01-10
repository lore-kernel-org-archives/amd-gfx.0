Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC56C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739F710E722;
	Wed, 10 Jan 2024 08:39:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A72C10E722
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 08:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czmunw719KrpO5pgeJ3ea2C8U5GUHMEpVXZhu4/Fc9v77Aj7qKfszzL7H1IqDVAHAl6Z4qrqc4MrrBJLO6tfWBniqXjDip4V9WckW7tKf6UYQO3818qB5uhwc765PUKnU40bdZ4ZgNwNw7/xUAyZ+2ekyvSuzs+oINhNCOa1wAahXzSmh3vPy5V/gB/woEp0blZo+UVhtdEDdtSUXfN4g7cTaT8kxbimTeD0XkCSn9C7yntKpsRQ1RDsVn/Ccc2oK1AS8a3xiLfjdj2L1dUAXRW80LIC4T07c343rXActZVz+k4gUcOGs3jMM2RWsgRRpzJ35vW0zeTWDbFz6xuJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/40NTOXnrT353KNbbdcyNpzpo8oUI8m69KEOX5Y1AoQ=;
 b=b5DHU+AHBQaznXn9dMGve522N7sKlNFIo7sww+rSgHOnNtdk0Xlov+SuAkxt4UGpGk6/zP2tPcwkcq+dxKH1hZdhMvhEXhPaZvhsahuiblsya7KAnjrJsXNPpsPIKpJbrtCuMFistrP1svi1ZazIuJNZvZHqCemfzL8cjySN8tFTbiejlHaYE8Sen3406GsSmYaoUwg+AXa9ycF7zUt+238r1w4l+bF47ku3V0R3/mbTV0HMNuIiVUO6r4IvqBz+PlH/aBKuq1uyhdayw6758+QBcmwy033H/mZVrGp0RzyJcepetQOEIDn5gcsbkjF50yGrCbnw6gNHamiKbNA5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/40NTOXnrT353KNbbdcyNpzpo8oUI8m69KEOX5Y1AoQ=;
 b=yS0Beqz8fhCTaoTw1jzcwcd8CnHD9S9ysHdS1lyg9bADc8k6MDwwm2+ctLH0aFTYuqXiNH6VDFgSitnLiF21KB4BQucphXmpXsSwJL816+XnpG8tekeoVz27W1a0QEIh0yi7+dhPbBIenbiEQj7G2ZVxCUkQb5USh2UQo7kxY5M=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 08:39:33 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::4e) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 08:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 08:39:32 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 02:39:31 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Do bad page retirement for deferred errors
Date: Wed, 10 Jan 2024 16:38:56 +0800
Message-ID: <20240110083856.412858-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110083856.412858-1-candice.li@amd.com>
References: <20240110083856.412858-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b11b069-3220-4bc8-fb0d-08dc11b7ab15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8+mmRk0OP5K/wRtT/cFCJ33kTbd/P43jp2gesF89WLDsudR3zAIcPatbh8xUDsTtAJQ7t/XAh0po0wwkPO9kjDCavlpZf3gdgssGcDnvuNLqLptd8rreb0Z7hEtvxXH2T36dVcNDVrr2VCup8G4nnpxxsQm7NZzGeklM5WL65ory1KfZ3Ei7HVguBdiSKvqUTDbYsho3ctYUTSeVEb4Vu3pZBOThvArmLULyxBDk/rUUtCKeCUqr2mp1eQCJCnUvsZLKBU94UBfPuGDCAB7oafWgWNlPFXRcILcIrZrQFdIPxOCK3jdoeIPuNQSw4Xc0JkPixr++FwiC2p7Ni7HDbfDhJ2hnMzn90wOzjWIsvL8eCcUH7SohbSk3aOUUs0BwhW+71K9WSMLaplaEeDjxBi3NhYX6N4ejRneKXeJmvG4NCNn6rluHW9L+TEiwJUMRCzD8K82KD0O820+6MXpBFNzAoa7Y8HxpbuuNtRuF0nfe8VWlayJ9ua8ZLuJpmwv5ggiWoDBUQlbCsexztWhQad8hsPgdaQxRsw/11LzPVdvoF6IBpj/P7IYJSSRxVbNlNXKUpAkxdYezXLn8NffajPKnjz1JL1CZRhsOVcfQ58ykukwVpXNOMvB9LiLRTNXCEk3glRvI3nOp+ipVTxxCG7LyLanWHDXZKkz7+UwkDvK93UkmwHy+/aqB3o7y7Rj65wlaeI/eOb6lYZHv1NKU+W5yXU+jXsFNDGO8sw+33FU0rBAW4+YkN0/jgjmBRpPK5ve0iPY4MhqoqARaUKvmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(44832011)(86362001)(81166007)(478600001)(356005)(36756003)(2616005)(83380400001)(336012)(36860700001)(1076003)(16526019)(82740400003)(26005)(426003)(6666004)(7696005)(316002)(8936002)(8676002)(70586007)(47076005)(41300700001)(4326008)(6916009)(70206006)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:39:32.6018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11b069-3220-4bc8-fb0d-08dc11b7ab15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needs to do bad page retirement for deferred errors.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 848df7acdd3210..df61df7e9b155f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -93,6 +93,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int ret = 0;
+	unsigned long err_count;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
@@ -147,16 +148,17 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	}
 
 	/* only uncorrectable error needs gpu reset */
-	if (err_data->ue_count) {
-		dev_info(adev->dev, "%ld uncorrectable hardware errors "
-				"detected in UMC block\n",
-				err_data->ue_count);
+	if (err_data->ue_count || err_data->de_count) {
+		dev_info(adev->dev, "%ld uncorrectable hardware errors and "
+				"%ld deferred hardware errors detected in UMC block\n",
+				err_data->ue_count, err_data->de_count);
 
+		err_count = err_data->ue_count + err_data->de_count;
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
-			amdgpu_ras_save_bad_pages(adev, &(err_data->ue_count));
+			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
 
-- 
2.25.1

