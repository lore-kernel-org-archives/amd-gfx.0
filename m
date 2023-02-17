Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D643C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 03:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B913F10E12C;
	Fri, 17 Feb 2023 03:53:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E0710E12C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 03:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpcu3RPhbhO8T9ffR27+44AHd4IyKPrY9yfSBkF9rAJ25tej/QcICbFd4FWSCgVBgCo5G9RrTOKHq2gQHVFlLqJIKg+Fi+cdbPb95HCRrmvM4wr0mUitpKHFOTpfsgA7AtXfpnUuYwOvUc/5U8TKpzKrxIoFbeh0wuXl0E5thtFsLrirvn7L+KjOZeWTGeEhnXOp6DtsvTfq8FbAeP13QusoirdM7cJA0lkAL1SGbCZ+A9gCBS6+wXblfanvNFzZXHEGpYLlelbKiHK+IJUAxJ5G0Lr5p2ti0ZURZ/UmDGyAevop/Rk+Hk4RNgMA8+5hDnJjWev5YQEcK6C2ePecgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieS7Bq0QL4f8BF5dGVyeQ6Ze2la+Mf4CZlpFdPxLW6A=;
 b=bYBxkALFriV6aMdxvbL/wSJYcvOldQ/057eRCSKH0/XIqJjk79hXWzv0rdVbtK0zsFJpdUapIqUqumIOisRWX/3fJRee+ydTaHZYHcybhUF8qEawXHzSl9ropnIn4NEejrS+zNITtvMW3+ba9859Q4J7sjEqUdXrNYX9QqVl5oXmc7SN351OweKJYaiHCXfe8ulYr24TuG2BHK0xEpJo/Uv+JzaK5BQkZyxqL7OwDp7/AMZhDax+e8mWU1V+4fSMiVIMVrIR/KfXSanhxNJDVbNuMg2A1SLQXjd/eRDzO2ccRHK0SrYavwABxhFQm02LmzV1jj+/c+QvtyfE/TAXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieS7Bq0QL4f8BF5dGVyeQ6Ze2la+Mf4CZlpFdPxLW6A=;
 b=40wVgzWhugBHc3+B1oTPEMpMa4afeaR6gI6harnXsoZnrk1bTxOoEZPW28QKcxa724fkGbvDvddp+JmrZkCFWBrGa8ZJbkHTVdZ4jPOczjgOdORBJxboC3DVeGSvq1qpX8Aaazya/pqBhRWnazftH9tp/aAbSpTonP5L013AITg=
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 03:53:27 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::c1) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 03:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Fri, 17 Feb 2023 03:53:26 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 21:53:24 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE count
Date: Fri, 17 Feb 2023 11:53:13 +0800
Message-ID: <20230217035313.4616-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230217035313.4616-1-tao.zhou1@amd.com>
References: <20230217035313.4616-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: d7663237-15b3-4924-1fa9-08db109a864d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2y3nx3bkp8dWlbTrwK6CgX/X/IABzy+4XtSeP+41ZIwB2mjz6AeXMvIcQO3jAca0v8KG0MqJ/eHoJ2/7eaO+mnkPR6o+grjKsCGm+vmc5xODaQJyeFfbVN0q+eMC/1ZmpAnr7ciKTnbDUnPDo3E3pODQ7cipIrpPv9xDPvjeFlqbuM1u3T/H3FdZifbwdujwTQYx+BaJ43mO9mojEDwupkajK3Q+WRpWtgaQwNrARWjZKyt3MVrsL+1PM6ItTDHESDJXn0ZjbvVvmYPvEUAeeVCOXAUAZk/p3c0FFkxeQ9LsmgAykcixibApvKzIBpKnonzTDR+6vKWP/ru/PiqB7KApAbR4NX1TKAzB+uykxqllUP7o77jPgAM1zJ0UIQLgoHMj11V3ZL9Mgc+YIy1XWQJkpMJS54o5eAG5f+WARfRD8S9R+gUakVnrs4Df+ar5aAqTj7bESCz8y1zr1hNUQQMYzMb0fbmP/S/JWDNJ4UBOrl3wwJHoWvhi6nsJgK5VN7d/ZLKg0MgLNi/OypALVEx0oTW6Od1a16rLI1T/nfVdRhagXpoMKS4COM4QODIVqR7bv+UOHMg6E/nMomVGvOQacqWyWJkwWzsXVmAZXkduobUD3gJ1APVOWHTS/P3EBKvSWEIs4nVCUkvHPZAMZUqzaAtaduYhEIxCSuYGxhv6eaqAL02hJWlARtGOXbLFwUPuoHNoIyxj8xDb1PW20vlEScLpy+c9JbyJAL09Dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(2906002)(336012)(83380400001)(82310400005)(40480700001)(2616005)(86362001)(47076005)(81166007)(82740400003)(356005)(36860700001)(40460700003)(70586007)(8936002)(8676002)(5660300002)(70206006)(110136005)(6636002)(316002)(4326008)(41300700001)(1076003)(6666004)(16526019)(186003)(26005)(7696005)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 03:53:26.6485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7663237-15b3-4924-1fa9-08db109a864d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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
v3: remove duplicate pages, calculate new added bad page number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6e543558386d..777f85f3e5eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2115,6 +2115,29 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	return 0;
 }
 
+/* Remove duplicate pages, calculate new added bad page number.
+ * Note: the function should be called between amdgpu_ras_add_bad_pages
+ * and amdgpu_ras_save_bad_pages.
+ */
+int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_err_handler_data *data;
+	struct amdgpu_ras_eeprom_control *control;
+	int save_count;
+
+	if (!con || !con->eh_data)
+		return 0;
+
+	mutex_lock(&con->recovery_lock);
+	control = &con->eeprom_control;
+	data = con->eh_data;
+	save_count = data->count - control->ras_num_recs;
+	mutex_unlock(&con->recovery_lock);
+
+	return (save_count / adev->umc.retire_unit);
+}
+
 /*
  * read error record array in eeprom and reserve enough space for
  * storing new bad pages
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index f2ad999993f6..e89c95438a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -549,6 +549,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 
+int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev);
+
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..45b6be7277dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -147,6 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
+			err_data->ue_count = amdgpu_ras_umc_new_ue_count(adev);
+
 			amdgpu_ras_save_bad_pages(adev);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-- 
2.35.1

