Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68DCCE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F8D10E1C9;
	Mon, 25 Sep 2023 04:28:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB0D10E1C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsqs07UGapJcaPoyBQ2mUgWC4g0p8ouGyo6NWYCLJmZBSCwx0bn721COoh3madr/eiV5K6r1eqOcvua41YlzQCctmwm5NSIhOHzNzTrSF4UQ/W++70Z+ySwe84gOFsdKmPxPoCejfjjmulgf20GrPfLXgaz/2PFa8ZRcrEKVlrQn9DCcgEOpFY1Hy2WyJOm/QW7hfvfAByAjAdjjwntSQIzIRj90gdtCEJRPuRqexf6pylUXpuVFPuRIkPmjckVavUpFmne059Dc0ESGKThMDdQcxfSJxctEBgi1Fd8YEdW0ZwWDDiyqP5dhir1QOBiqW/NtjYa3tmuMKzi8Yc9u7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcGkQeV2USczsFkSFy8+kUEQHRDhhCMNRncLhs2+fc=;
 b=GDDA3F2wgr0tPC9nrV3+aXrM9xb6XiPdMFuTg9loez3T948ExAHxj56mIKI62Zinap8FJP6DYvQBxUYvhtRyAn+zTl0pFPI77OJa3qxmuRTLN1T8OVfpz379i2MlfOBt6uqYHDahwf4AVRAQlPmD/wKJs+8R8qxgEfltzi1bWulTW9KOz5QDKzyXw15S14H5yCRMw/m4c+p28fvEMPrKOfhAcWKucu606H4VM2lPm0RDireJD6wgXEwqrP0R2EFYtWw6wunDUA/V4zLv0QzAtXkMDAHtGH1AUNAc5kqnq921PRUdfSo6npQp8/R4TV+BnoMUiPkGRFP7nRQTmZbXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQcGkQeV2USczsFkSFy8+kUEQHRDhhCMNRncLhs2+fc=;
 b=wfiUIB/m24veF+shVaefaYIUBpyxPj8TTpneHe4cAHEuvL/u/6Cg6mgXCms7U0MZF0Hp9T1tPbb+9CaMzgJcgz4qWMZRWVS91r23vG1z+KwQYuZSjcdfk5rESFVbfjQyIhN7y3KHAW2SL/C/kPbglJHZFSiS55tP3z0PMPqQy7Q=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:28:44 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6e) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:44 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:41 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: add plpd_mode in smu_context to indicate
 current mode
Date: Mon, 25 Sep 2023 12:27:47 +0800
Message-ID: <20230925042752.3847-2-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe4b240-8f12-492f-0db0-08dbbd7fe77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPQs3CkASb0MQI3OTJkk7cgS5htBc8YtjCgzwJm+vPrnsR6jqaqUFwta9FMZ7l7ZQ1dTlUGoxdqpReSJG83Pt6zo0XDNV/qJvG/P/L3I3YbStMvZno/XVO2ODgNv3faVCOmS5mnSu7egvu+bixVSKfIQRgzDmv2XHpfBmZmGL8+RYEWb5r6QK1Ltiex6gsq3QuWuC4Hgz/unLJcktV7Iu/gx9KxeuFhd4+9BlGG3CS5mXVRMBoEgmUihC6/Jow/GPiQoUwouerV/5AyRHkjkeUVX8LsyojceX7MlV1t/PCu4+eZMGtimfNPQm4CDxhx8PAgAlGX1gm4bXNDHrLILnawrSke9FxrlYi++W5LF90cxttolR/Z2kpVVp/Ud4uUcnbw56Vmy+jcsufH3nCh9CRoui62fAajPuKtgUR0jgY87P77Kpt0tZl+BEJe43n8zXgeqmvXqqeGDbDDBWZ/hAje+KBLk7422p+ycTcxBfUEaE3yX5w35b7UvpXEwOVaZRMCiYkUMwcZVqRL1FkrS3blJ/e7fm/979pus+ijYzGCQbO9fQG6rv/vo+G+1iz/lKicDd3TC28r30ogmeBtdIHLlK7WiUcy6DmA6HMWH5mZh2puEf16Z5cFl0yQlcUlElrCI+jLI5q43vtukc2PaadVWG5y6n8nuhY84bTocSY+6Af5oJN8qaC5IG8DLFDxgrxKKYEILvpyWt+bYnFvimsu08kne6gbRwcQePVC17YU2H5a+Wo9urj7oAeu0NdquHw4tjh1B1v4qZmB6YQUrDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(40480700001)(70206006)(70586007)(6916009)(316002)(54906003)(44832011)(41300700001)(8676002)(8936002)(4326008)(478600001)(40460700003)(36860700001)(5660300002)(47076005)(7696005)(16526019)(36756003)(336012)(426003)(26005)(1076003)(2616005)(356005)(86362001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:44.3632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe4b240-8f12-492f-0db0-08dbbd7fe77e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Asad Kamal <asad.kamal@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add enum pp_xgmi_plpd_mode to describe PLPD policies.

v2: move the enum from amdgpu_smu.h to kgd_pp_interface.h

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 5a889f733462..e0bb6d39f0c3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -265,6 +265,14 @@ enum pp_power_type
 	PP_PWR_TYPE_FAST,
 };
 
+enum pp_xgmi_plpd_mode {
+	XGMI_PLPD_NONE = -1,
+	XGMI_PLPD_DISALLOW,
+	XGMI_PLPD_DEFAULT,
+	XGMI_PLPD_OPTIMIZED,
+	XGMI_PLPD_COUNT,
+};
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5a52098bcf16..5356b91c6292 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -563,6 +563,8 @@ struct smu_context {
 	u32 debug_resp_reg;
 
 	struct delayed_work		swctf_delayed_work;
+
+	enum pp_xgmi_plpd_mode plpd_mode;
 };
 
 struct i2c_adapter;
-- 
2.38.1

