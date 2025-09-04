Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E3CA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 19:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB9210E345;
	Thu,  4 Sep 2025 19:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECTWwvYp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1528210E345
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 19:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPSGBHqgCCJShPwziuJaoy1PsFk8eJxmBg74VL8U8u/RhGsOqYOA8ivYZ8eoA93IVYUtaF+UgldIWBegPDstZWqd1WTfe1nfcBickwGMtTZKXUq/BFkd44cGY/VffBBUfp+HtQSGQujQiupWkrWfdo9jCrVrq4vPrtY6esGspDPkjTzMg7GXK0HGeqw36eeDGo7R55CSAIpkM0LPICv0zLZbsqTbIFC8k+MvvmQFR6Jrdrok4C3MTsXLLhxTDbm7jb/YT2ozUYAY6aED0akYUVDryIV2F55baWwect1mXi/wbCkjEhi+nTpQqRR07k8MdXdhG9MGH2su5i5KxtnCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buw4N9CvC+iDIBCW/RdQL28PsMaZ8apu193wFu3O7UQ=;
 b=mFxYHuAG6Zdx88LAWMRVDOvkeiEB8LTqgxHrricTR4LZkD/BJXo9CQxfGxk1ZtaEpceC4LOiXVo8eFfOO7CqvpecAGJg6Bso8U49ZyFvxA6jCKkkzbtQMYNgxD/MVoIGtrxy6+Jpgr2vBFnG2x5j9Omsbe1wrE2pcL4svPesUmLieyneVj/yF0qa9f8AlES3whzJgcsp3H8e+Q0rWEI9cCaj6Cj9CjAkgMBYaOK/NGzsAnQ7OLM4en3hjNmexNs9xF8W4U+r7tz3pAlCOaNfKYeJG9ouTBBTJjsK/cmde3niZMNmHROvFhEN0wuRr3RZGjchiMvLvSD6yj+gNAY7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buw4N9CvC+iDIBCW/RdQL28PsMaZ8apu193wFu3O7UQ=;
 b=ECTWwvYp7lQP+YTm0No6xcWqG0T6eTKAf8OOl/qQT+Q/LkxzFepeAuNSrkD+kGz2AUgU3VoPlKn8137mLjvS9BtJA8amlfWC9SsOJcC0npAdqC/A/JExWkRgiEGlMJLeFVP8S6ZnOG2SiJHzDmt4Edp1u9/J4L6JRUYLDXFK6Lw=
Received: from BYAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:c0::45)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 19:14:10 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::cb) by BYAPR05CA0032.outlook.office365.com
 (2603:10b6:a03:c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Thu, 4
 Sep 2025 19:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 19:14:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 14:14:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 14:14:04 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 14:14:04 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <wayne.lin@amd.com>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, <stable@vger.kernel.org>, Imre Deak
 <imre.deak@intel.com>
Subject: [PATCH] drm/amd/display: Disable DPCD Probe Quirk
Date: Thu, 4 Sep 2025 15:13:51 -0400
Message-ID: <20250904191351.746707-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9608e66f-4455-45c0-3c96-08ddebe739fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zJi3hYIDJrvd+1hhOzDFBN+GdJFHKVTJx+4g8ZMQQK/k6OhOjY9nmQHaYw0t?=
 =?us-ascii?Q?eAvHDXuGpmY+GTsBoYlWuQFDqmDZBskHrJZgKbi65EZcYlwtmmFKPWBrris1?=
 =?us-ascii?Q?plRTx6rM7ekhSLbJ9KWFx6VGZzUAjAOcisSvWNq2Xg0EYRN8noSkN01YHQV8?=
 =?us-ascii?Q?00VYxAkm9W1yF199pELvh1ZFvHnKqAl/jUUyVnXyTaUXVH9j9AI0WnZobXXC?=
 =?us-ascii?Q?YlSB4sertywil0Jcdn3fOZxBDfSplUSORW6SKFA/SVj0BOqyYuVVXsEFo+Ty?=
 =?us-ascii?Q?m742Yf3vGrBTuip2yTUpDm7zhjMKQQvzxxoXGtY+kMxykSEtB2PWsnPYmjW7?=
 =?us-ascii?Q?cDLoUPnc6Ib5JMnOPQoDOx9d2vUaDWmAWfoKv+djdHKsnmtTNeN7HiTso3vH?=
 =?us-ascii?Q?9kEaR/gzjzyQJLPfbTatMQA32WThPbzOe1TVW6AwwSvPfNuO7DFR4QXcdhAc?=
 =?us-ascii?Q?4sHhKOnpv+NvRN4fhNckbmzedm4Sufl6aseLa9T2bRgSeDSIU866zkBNAZ0o?=
 =?us-ascii?Q?VrHShnn7in/CVl9Aa/KDazU4duERJCbhgTefZKEj0DoeKemjZcAfVgIdMnsV?=
 =?us-ascii?Q?t6xqogFJZH8RpyyecpyiCoPpgOpgAWrBpPo4CmV0s9FBiJang+Z7/kcXQWz/?=
 =?us-ascii?Q?iR6TXGqETUTSxBZHnUigOCz79JakALNSbQ9esfWDm4jKNkazQI5Ljk9d6h1Y?=
 =?us-ascii?Q?eZqZKm0M/RPD+v/B08dzmU/jb6d2RrLD68m2S4O37JV3VRDyoYFP8SiVb4dP?=
 =?us-ascii?Q?IZlY/26isuVI0k3l0vocwIoTq8t9qh7ItVNeorXkY4FUluGnpKCQnzGS8SWm?=
 =?us-ascii?Q?lg2neKDqaZZrCtPoILP068MbiDaO7/8QJ/CYc2N5ro5n9DOqGqR4jTYGmmK9?=
 =?us-ascii?Q?WQAfBSVPHQh3hVnoZEeCMGBnwHU7seRE8ljoae8WFCqcVn8bhVW9xrb4mzEX?=
 =?us-ascii?Q?f4GBoe7wQkuwwuq7AVyMaUNsLLe1K4RRKcF+z52RQOzf+1g5UhuJd2OUc05t?=
 =?us-ascii?Q?utClO2dlCNAMMGotCrgVDFW3hrav38jg1oikr1tUacVHTMOOENDg728KuLn6?=
 =?us-ascii?Q?IwJyYapIGOgt4wh7N3oK8I0U3le87M8/S931nU71r91R5gjUifqIjlr6IAM5?=
 =?us-ascii?Q?nIVKNZz34NAFofuSX6WTP7Vsh07YoZJ26aJMEgXULeSJ1FrkrJOUWJIaBrS9?=
 =?us-ascii?Q?mz88MpR7sPT75ACGqOXATVzAltWkOVhAIczSTkSMlhTzeWR9CXmKWde0BFJF?=
 =?us-ascii?Q?7Tert0jYiAFno7AksKij4zj3QWr2NAoy5ksEX7IWgm+547UHxwRyOPQABKWn?=
 =?us-ascii?Q?PJwOYC+8IaADjeg0g+7hiLd1DwU23sSsHKd5rrtCWM4Lj+ah38e21LEms+/G?=
 =?us-ascii?Q?LQEW+MnlLIvlYknyi0KKImqPz/fKEtps82dh1zvY+cMizdr49Ztr65rLCrJF?=
 =?us-ascii?Q?ikG50TlkuoTFGmtr6+tHdpRMVWCVa+VIp3IBHrGADXetwrVgexrNphPMcoF8?=
 =?us-ascii?Q?p/RzjROSdA6LJYH5oUMkntltFWsWlEQtZt9C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:14:09.7811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608e66f-4455-45c0-3c96-08ddebe739fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable dpcd probe quirk to native aux.

Cc: <stable@vger.kernel.org> # 6.16.y: 5281cbe0b55a
Cc: <stable@vger.kernel.org> # 6.16.y: 0b4aa85e8981
Cc: <stable@vger.kernel.org> # 6.16.y: b87ed522b364
Cc: <stable@vger.kernel.org> # 6.16.y
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 25e8befbcc47..99fd064324ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -809,6 +809,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
 				      &aconnector->base);
+	drm_dp_dpcd_set_probe(&aconnector->dm_dp_aux.aux, false);
 
 	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
 		return;
-- 
2.43.0

