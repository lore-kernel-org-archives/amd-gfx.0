Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234AAC77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAC710EDE4;
	Fri, 14 Apr 2023 15:54:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA8210EDE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3LsA09Rvf2DDhB45fnrtJZLv/X8x3PQQI38ODPl3RT4uEq64ToUplvAxM5uMLnQBYvFAyI2QijIDzzGpy6FB+5drConHHsXUaR714pA0Y46KgKtiAm9rL7MQRfag9aQYu9pPtnj3nc6y49NABOmuX8Ui4qClrRW+VxIFpHNrXuDMF+e/hczPoE2A7o30D8ROAJmBg2jYiPtRFeCNMviJ2803ylfpUFEsrjKZurzk9E7hgxQgLWINhgmnk2t/TbJatuFXOUs1mXb3PHACgMZ1Y4SN44aYzkC92nR7zvtDHOUO7N+zkZXJiWatLmpgUFcEXxH2u9HShIW/+wAbZG0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75+lLx6ElrH2mfq1c7U0nSARSMYxwsNPoq2r73L+jLE=;
 b=jX1qWYOSz7pQ10VJt0tfIYVMsWwB13cqzqeTarTKM5rTKJeSxeLZcFeKhTUDZ0AAfho7oQWnLSRig8nbieGttvC9xcx4rgJIZDc82RahZQtmdeR1rqqhYO2qpOuqAW5ujxia9gpdifwA7bNlSzXxRx51QpYtCHfuyI1sJnZ+LxVaPNhoDurmzKRud9s+Vsn5eFIoec4EEhYUrFnP1dzjQfFcAVQ/5hlIfyEC5r8ELhRgY80SOjhKQ1tDwTypb9BqdiNFRRyO6du07nd+ueW1u7A7JDUw6VQmT30V3rT765Engh8zyxl6EMNCnbbKGKm14Ot+cvj+XVr4OG+Cb7lr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75+lLx6ElrH2mfq1c7U0nSARSMYxwsNPoq2r73L+jLE=;
 b=lsW3Q4Uq/TptKkGZ66a4VYwYq1shkzxteTCQpLJf/vah6GwBlmeP4et3a2OBG0m4kYAAxBIC1x6jyKs2+KqLCNQAyQHkxR1MDBm7MyUymbLcNRkzMib3zAvUT533ecTq1Hs08JF2y4Z1PEwckxt+ZlRYvSHXIKNZGRHlhdXEfjo=
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:45 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::d7) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:42 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/66] drm/amd/display: Return error code on DSC atomic check
 failure
Date: Fri, 14 Apr 2023 11:53:02 -0400
Message-ID: <20230414155330.5215-39-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: c7965df8-1df9-43d3-1c3b-08db3d009138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxhbA6HwpKW00cL9utClbWhdtQXtKIOeDTiGvyHKhW7mWted4NRFW/Fo3khlDtAX8bO79iZAjyg0LyJgY54NFZTZKLQcMCGFtxa00Ys9LM0ymi7Bq3c4x2o4+ZhnRtDDjTRmTvM1oqJziEQiXXEQX4Pt2/LZHZVNuwNKEdHhX+x6pj4nPvzwYXAZQyxEI3CZfgzRl7TA2zsIKkU0+enM58M+9P5zfnfsQYIAwMHyFqXYd8RuX/WV5VtrHvnmosahTqulQtCcHeXwXmqk1ROjEx2tUvt2jNPVw8LivAUaFVniKB5TqaMkT1M0WmVk7zHGG4ModXBaRt2jIVux2PuPVdlIuca3vDgl5JKB3qqZNFeEagvqDHck0riZeY8KO8nzvQYYkBgbYBw6RV3va9CU2kXvw86io1KlVAJyh01MsRXEvnblWt854XkqVHNm/8WYJTcf+JETLKNMHZbkNHutgsCrBRyIneZhs8UDpJ5E+cWdckMDA/myCpq7cFFqfnAWQ/qllQTXXnra0WBTlTF7OUp0wwxjVySH+A3BUHAzEFupXYXFjvAaby+rn/JYT951vVdmQZyGJDWDXvQfYLb0NAOoaopZWty0yM/qTn37oRZRo3MVS1B9noTpIINB+tAXw+aShM7gVnEgCqeIx1hLOekMukDHmbYhVoN1C5u8LqwShhd7YEn4mEAt+ZkUZ+1wL3Nc3XtnIcRb28LykWOm9IljlAA8dslpyVVVG+wmgvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(83380400001)(1076003)(336012)(2616005)(426003)(478600001)(54906003)(16526019)(6666004)(356005)(186003)(26005)(2906002)(36756003)(5660300002)(4326008)(81166007)(41300700001)(70586007)(82310400005)(8676002)(40480700001)(6916009)(70206006)(82740400003)(316002)(86362001)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:44.8256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7965df8-1df9-43d3-1c3b-08db3d009138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why&How]
We were not returning -EINVAL on DSC atomic check fail. Add it.

Fixes: 71be4b16d39a ("drm/amd/display: dsc validate fail not pass to atomic check")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71e3bc9e7f8f..dfcb9815b5a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10169,6 +10169,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 		if (ret) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+			ret = -EINVAL;
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5dc79b753d5f..810ab682f424 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1410,6 +1410,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	ret = pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars);
 	if (ret != 0) {
 		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		ret = -EINVAL;
 		goto clean_exit;
 	}
 
-- 
2.34.1

