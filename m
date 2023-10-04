Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00073E7B5E1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9808A10E368;
	Wed,  4 Oct 2023 09:25:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D00D10E360
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsNI/6DBk/hrkb+qW+Q0/9ExN+4a+HTGMvNUZScvVccAJkDW5AK8IliY2iTeFGPLMKV/oQLwAeTrtsRPBfj+aS9PqdZ7YbnmC5ZFHVVShI7+dcLeNaOzi9v5gdEpzasExWlKBE4sMTI/J9MqurQQOzZDR/X7xAgG4EkU8GldQJvWdkXnfNOybaWWNCdg0BpsIpqJS1zxvF/F0BB95VcXHUOvlLkSnDPfRJ9HCa1bT0yZtNhSzg6ERHZBvqIgJ/zbPccsVLY/78h0zNnhXNfCAjfSX67k9joqY75JBmeY5UxcOL4Kt/gLq2GIUBKU07VDsr0saGct0J5CLGNopXsVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdiZrSukoqonAaniM8mozucrRYwEo5ZkLWuIEZ3qf4c=;
 b=GJNc1Z8zFYqtZoqONX8qQSridjdyemB9FIwZJSZzYgqNiYu+pHaR6N58v6zyyWMj8qZ9sdNB5sl3e3q/nSyEV9t6nxSU8mzAeEBDDUBog07VHzRuk9pwG9CFRQD25mG+dkVVOfu9dM7wDJUppJh8lhYu4yoaydUcjhz4aVuPx7rA1L7LEQU6BCoNuMzTa9yO3wU/pMhQgxctd6rna1LCYpF0GN56WTM2PSPWY/Nc3MZfgmrgWh4zXfuQW75mDnvyKPOSfN1P6BORwAo84pm+X9j1r5w97vYsvH/aiA4nV2bCwns3oTzj/FNxESla19izPhWPXJy4P7JeGgey0JNYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdiZrSukoqonAaniM8mozucrRYwEo5ZkLWuIEZ3qf4c=;
 b=gTjlGHFhi8gVqJFVGilIpoUM0sfgUouBczEq9jXUMilmFURKyMnrmychsYZTzvgw5EjBJ3JgU5Ss486ApgREeDnjyMs8S5h+vooM7nCX5NqMVBJli1HZQiL+7nfwXt1iGCeqW97vk/n2w1KyFHzjdhy567kg6bFIpvNzAzoaaEs=
Received: from CYZPR12CA0007.namprd12.prod.outlook.com (2603:10b6:930:8b::25)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:25:13 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::3d) by CYZPR12CA0007.outlook.office365.com
 (2603:10b6:930:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:25:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:25:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:25:08 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:25:03 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.255
Date: Wed, 4 Oct 2023 17:23:01 +0800
Message-ID: <20231004092301.2371458-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad44990-c062-45ca-f24b-08dbc4bbd008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxYNuuc06wR4Kc62nI9/KF90bV2A4p6yj/6LImL9pvXfs0RjRfhVahSZhtk0rORW9k4Ft4os13rx453Uxb9Kpp3dc2b6pa8hBq8leZ+KGc2f7uWd1vMgav5pEM+Bc90eYgKNMSs1IhKzysfQSOjzSqurE7gNFjXxaUixqqlcXTjJX7hlAisA8UdvhNRsaO6zlM6+1r7ALG6eOqjdgGDZSATc3GAbZk46swvY+Ddb+UhF0iZfwMR5agOP1AobvStHpNzLnxcc0FqDEMNC2vx86TvpRDJzwizykfI2iMVzYJfDFnKVaY88aW+GvNbQXvVSbr1kAk8CnofBmagUBxFuBoaMUKnMzPSBGzx1KkwUqOT+S6FIHA7aNf/5fk5XtTLts+zuXltApFWrm64Enl4CWDbthHJedRADRYdyIvSc41Eg3s/8nuaTnzvVHaSfwxvV/v9JMdnk5b2//7vUrfD7Rm37PmGh8+OEg0Tvu6EP3EfYSh8HCzN2vSNKeMEwECUSa8PEFWUwsU4lVjvcKQxpUiZRiqbbYTEppbP2wYMxScKzavRbwlF4j6BrmuUmPizZompx+EqyMyMuBg4MqjzkemM9TJRUObpnYFqe2UTFJXv2bBMFeggjI69eMeViUhgAiZjszC2UaOLRSKNWTNTl+8NcYCwM+5sWHmqkVlOKYLrkx1MACF7p4UExNQ6Jm4wpJE2V0QNNzlm9UeUo7BPTMMU3LcWBb+lBGBZjoZLojYGCeQFGpz8rU5wpe9MCwzBdCC1BTKWtmZD0Uy6P+HUaaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(8676002)(83380400001)(426003)(8936002)(4326008)(336012)(47076005)(70586007)(41300700001)(36860700001)(70206006)(54906003)(316002)(6916009)(478600001)(26005)(2906002)(7696005)(2616005)(1076003)(81166007)(5660300002)(356005)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:25:13.0295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad44990-c062-45ca-f24b-08dbc4bbd008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Refactor DPG test pattern logic for ODM cases
- Refactor HWSS into component folder
- Revert "drm/amd/display: Add a check for idle power optimization"
- Revert "drm/amd/display: remove duplicated edp relink to fastboot
- Update cursor limits based on SW cursor fallback limits
- Update stream mask
- Update pmfw_driver_if new structure
- Modify SMU message logs
- Don't set dpms_off for seamless boot

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0b9384707106..9f6d8d5000bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.254"
+#define DC_VER "3.2.255"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

