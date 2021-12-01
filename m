Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6445DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 09:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED356EE7C;
	Wed,  1 Dec 2021 09:25:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9A16EE7C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 09:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blgf6jXET5U9sMN6NxIL33KSJK0tlR6ypN1W6LQXG6JjqTFbCLvjd/0F+UyQ8g6q7MMYfB3zu/oghErCBxnmvdsv0x7wfPQUgXk6B8VTFZVtYktH2SBa7MXkcfNV1vgfXXRcs1rrcJXcq1ON6rpzLX8o0gWvlftGXd2Iu1uuUcmjVDKYLVMCBiFIEksSpp3BvwMvzIq+TYQhr23jB1crFhYpKFT1sUB1hfqh48oo4INKNFTEKt32IeG738PwZHQlikHkjrYsRKJ78YMWFiPnCcm9H43WTqUQdwhIL+RvbXvW+k2Wqq5fQGE1HhdroH+r8YiNanhBTGFADCZ2PCoIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dci0W6YFPyJzgQ0E8oth6c6DxWXQQI5mUZqMUdfLoCY=;
 b=AtAh5UujAmZZuKf+XXniiFJZ63tu1UgOZyVS7UH2zjwkhoMYwGmxYyd8bhJcRw3jpfmo2CI+iLgA8yiwY8R5ONaYmOcgBNwd/ublM9NcULNbnamaljzHxGUz3XITbN3vH5clexX7u6BX6in/ER7VY43jtGM6DoPDeZjlycLAJUQ7Eg+Gvd2Fg8envnpRUoQEDWun50G6HtcTQFELfAQXuCeJw4NafayUxujp2xMOIGq1lcHLKZjsUIXXSIQvfJ3BJOor7YqRng1ujMDxgqwcpEx62/uVDSHm3MvVuukAOcxYye3D2mtZelD+MIP8NdT26FWrFE3dwPdLXUWC1yBRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dci0W6YFPyJzgQ0E8oth6c6DxWXQQI5mUZqMUdfLoCY=;
 b=nArVg3aMW2PSjkkFob4M9rsmSQcUkDBPhoJjUrx3YpeJoPtkmsfhBlyHBYXBCzKO/kJWuBOylP8p/HqXgWGwGGah+DmnPupnCJgxeL0Iuv4nszXcPQA8RnJyBzUjVV6ZkX0MIiD2oseEwJuc+xgCLUYkZqKnmVhRQJaoDz/CrVU=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 09:25:15 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::c7) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 09:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 09:25:14 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 03:25:12 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support to SMU debug option
Date: Wed, 1 Dec 2021 17:24:58 +0800
Message-ID: <20211201092458.3348858-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f48d3568-dbad-4869-deb4-08d9b4ac7b75
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14139D8DDDE828B3410824FEFB689@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeZmDH2Nm7bwm1mHZBhgpqyelPcxsHL5jnbFXzkV9G7tyM6BU4Go5D+qE95D4vTWQMdDtryAl4obZ+kDdHC2TbX7y2xK48ph1VKbPNJ/CYw36Mh1MjFBPnVktSzxjGYbobO2HrsV0zgaHvRYdIGomPnJXJcfPJ15HIC+Kyn5RmWFyXFNbXXBIwSoU7GrZEPpUkjE6V9ql1h+9VLbRndwFXcjZ7qGIIj/5DPtFVHlXjLNWnYRqv/41uCRmcmWDB+u8f3hz1rvLd36LrgRr6ShXn5tD/OIpUI87kV8RwJnPfhbt6LMrOzXihR4xQ3AlJo79wNwuO1ph/YCUQotTK39yzD7dDeSRtvhzt6mdZNTrpzuFoZF6hfExD/hkgB7Fc1aXCatgq/07GFRiOGbLAGnjrhTYGsLNwLGGGXv4Qiu5fTyob5z7K/q7M1d/PuU/NHPc9PPUukoVP/Jkxh9LAhuuOIiT/N/UlqEtTSa1Pkr+nwkdWMNHfCZ/56BDK0MpWcNStY1gLreU0reSswNgX1LBNo1HHrFnWMq3yIewa8+BS1RS9iz/6Cc+UkiApyKRLkgjqvYOa7FGld4vryRW8id4514KPsBpjLGLBDXdd0nBYe1AMqy3I+Xyqh70p/ZmqBxFNqcYJaHcFuzL+VaGk/FTs/f9fHCv3/csLinC+c6LhVIw/LdA7QYhlE3pFL4MuijwgGWizkLEUBjWA8Zqz7/nina8Mpd/mIXw3jKlK9eDPh1QvhNFmTKNcuXptRkM+ZCpxbE8xgkYO9IDVRbTw+OGDndy9diKaS6lCrk36jzA5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(54906003)(47076005)(2906002)(83380400001)(36860700001)(1076003)(16526019)(26005)(8676002)(4326008)(6916009)(7696005)(36756003)(2616005)(70206006)(336012)(82310400004)(40460700001)(8936002)(316002)(5660300002)(70586007)(508600001)(356005)(426003)(81166007)(6666004)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:25:14.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48d3568-dbad-4869-deb4-08d9b4ac7b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To maintain system error state when SMU errors occurred,
which will aid in debugging SMU firmware issues, add SMU
debug option support.

It can be enabled or disabled via amdgpu_smu_debug
debugfs file. When enabled, it makes SMU errors fatal.
It is disabled by default.

== Command Guide ==

1, enable SMU debug option

 # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

2, disable SMU debug option

 # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug

v3:
 - Use debugfs_create_bool().(Christian)
 - Put variable into smu_context struct.
 - Don't resend command when timeout.

v2:
 - Resend command when timeout.(Lijo)
 - Use debugfs file instead of module parameter.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..86cd888c7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (!debugfs_initialized())
 		return 0;
 
+	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
+				  &adev->smu.smu_debug_mode);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f738f7dc20c9..50dbf5594a9d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -569,6 +569,11 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
 
 	struct stb_context stb_context;
+	/*
+	 * When enabled, it makes SMU errors fatal.
+	 * (0 = disabled (default), 1 = enabled)
+	 */
+	bool smu_debug_mode;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6e781cee8bb6..d3797a2d6451 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 out:
 	mutex_unlock(&smu->message_lock);
 
+	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 048ca1673863..9be005eb4241 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 		goto Out;
 	}
+
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0)
+	if (res != 0) {
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+		goto Out;
+	}
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
 	mutex_unlock(&smu->message_lock);
+
+	BUG_ON(unlikely(smu->smu_debug_mode) && res);
+
 	return res;
 }
 
-- 
2.25.1

