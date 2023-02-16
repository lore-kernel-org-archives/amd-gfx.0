Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2CFC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA6210E10F;
	Thu, 16 Feb 2023 07:57:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A435E10E10F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLwRTE+V2NM0i67S4oemVN4DE6PDAnlA48Npg/O7TI7smcWiiavY7mw5/NE+KRvLFfvFgmR7Klo98kyl8zFd+XNKFxAMUuhQEp7OML7DVF2J6ea775E+v/LIY+vrME+RB6/3XZGi5HDWUYilD/5h1iNTJ8EWSvjEepABztYcfryj0lYCY0AK//8xK3pSxd1pL9J8+oADw/wO4VoZN9xdVS41K5ftvI/u09EvfRSoYprsM4lNKhxMox1+TKqo2hmRzOvck8QXJ0RdEIrgPwrSux6j3XVnX55K7PBLrMuInN0KUNy5YXBGBkPGCTYVdiRmNMotE6G5qWenVNlWVPw38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+fuBx+RiUZUrCe0YplZbetvoPwy4ADIwiORl86nA58=;
 b=CjIe/sW1kauazAMSUxdAzGV9xDWxOAE+ixRuoNtydRTIAwTtrh6xGFec+94U1gIhwM/MmQWApRxe+mL99yVPaPAS9pOSQEhcViYw0NL4pdtSvB3Xofhk888N/X83ZPWJFWnAijWOkoad1JiF3cXM+Oeu6mUfTy4SIpIqfbE182WFHNDzxx4KZWdNdOP6PtLr/aOZjGesu/E9alq2iKLk7FAOc0EO2MikbNXreU8JAaDuhKtBLzEb6TyKrStKhhIOqI6CixB/lNIXPZKtIek479aSB3OH68bf1sM2iPjCleHOJDGbknpduQ/EW0BM19qUrIBcavFjWiEnumTd2H7ISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+fuBx+RiUZUrCe0YplZbetvoPwy4ADIwiORl86nA58=;
 b=tBwKYLTpWKVqCdJxgdVaKNGS6ofOGa+Shr/zQZfOAo0HThZX/uC5qZ4hHJpArko93kHc2c3pCFAb4yDqIvzesuyzhWRHb/5t8zk+Mo2akDpeFKX/K9XmhQp5wfgvifAGjUnQvVLI7EE/jPx84DEBV1qTXX+7b20loPosh+wsqGk=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 07:57:43 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::73) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 07:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 07:57:43 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 01:57:41 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad page
Date: Thu, 16 Feb 2023 15:57:31 +0800
Message-ID: <20230216075731.21355-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc129e1-8370-4ff9-9d5a-08db0ff37c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VcLwvS26j47U2HVpqEmy3KGQZneqLLC1aG1FR5LZWcvyHsUjGjvIl7ieXfOQ3I0abHihsRPoESr+QBRzyCmeqP1Wkw7DYcuXVY8DyT5CtSAxbxSaXnOwIw7nLylP8kpTeDtekdQXQjK8exm1eRUpzZ8plixzcifrwTsdm0mkd9qvAUtDCyXQvIRxS7z6tPZpu8ZgZ6ZpglcprqGyFRXog98Dz3yx505PP4x75jFqaoewiGoT5oUrAl4ppL15EITaZN4sgJqQoG81VhKOzzWJAUSqfAh03DWjih9ZGeV9g1ozp5u703kRYr+2eTZjFa/E/91pHdD6PiKX3f7+4LjGntfuBbL8FWa4jYt9P1P82nv15mooMunQecOn/83wesBqralEkOuio2gGUrPGuciSu/UdvSm/aAPINocnZIKKiAhevch4TdpusAr+WzmqVj9zGSX1blRcmGYQd1j1+Ju7FEMs2QVTVBLPKiBBt1nwt68r+x7ZnTHlAmlD6mfFl21AbBmCwCAIWIYUvFvEfL8dloWmhuPMz7bbci0LNSHBJzidzEyZT7s+3PDGMrUEqkGQPfOJW5UT5wko3eAOZEmecOSITsFW+dZePDtyArNKrS7lrxNphLHV4GnWGCaJgh3apYrWYNCa4B6mwefiGxQAX/+BXf2o3hDSm3BgiUOaDdz4kcDfmlA/Oc2DHIBRobRYLdeLQjww3vFuK2YHpx/06grvDmkxNLdWjfRFMX0sJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(26005)(186003)(16526019)(1076003)(2616005)(40460700003)(2906002)(356005)(4326008)(41300700001)(70206006)(82310400005)(8676002)(86362001)(70586007)(36860700001)(5660300002)(8936002)(7696005)(82740400003)(47076005)(478600001)(426003)(336012)(81166007)(6666004)(110136005)(316002)(36756003)(6636002)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:57:43.6333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc129e1-8370-4ff9-9d5a-08db0ff37c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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

If a UMC bad page is reserved but not freed by an application, the
application may trigger uncorrectable error repeatly by accessing the page.

v2: add specific function to do the check.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6e543558386d..5214034e1b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2115,6 +2115,30 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	return 0;
 }
 
+/* Return false if all pages have been reserved before, no new bad page
+ * is found, otherwise return true.
+ * Note: the function should be called between amdgpu_ras_add_bad_pages
+ * and amdgpu_ras_save_bad_pages.
+ */
+bool amdgpu_ras_new_bad_page_is_added(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_err_handler_data *data;
+	struct amdgpu_ras_eeprom_control *control;
+	int save_count;
+
+	if (!con || !con->eh_data)
+		return false;
+
+	mutex_lock(&con->recovery_lock);
+	control = &con->eeprom_control;
+	data = con->eh_data;
+	save_count = data->count - control->ras_num_recs;
+	mutex_unlock(&con->recovery_lock);
+
+	return (save_count ? true : false);
+}
+
 /*
  * read error record array in eeprom and reserve enough space for
  * storing new bad pages
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f2ad999993f6..606b75c36848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -549,6 +549,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 
+bool amdgpu_ras_new_bad_page_is_added(struct amdgpu_device *adev);
+
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..1146e65c22be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -147,6 +147,10 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
+			/* if no new bad page is found, no need to increase ue count */
+			if (!amdgpu_ras_new_bad_page_is_added(adev))
+				err_data->ue_count = 0;
+
 			amdgpu_ras_save_bad_pages(adev);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-- 
2.35.1

