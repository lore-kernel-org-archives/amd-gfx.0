Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA950C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 06:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CB310E095;
	Fri,  3 Nov 2023 06:00:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D8610E095
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 06:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrAtiw3RDxwdeGsEDzm3I7r4+SPmba7IMnsac3SKK5iwcVFC+80FGdyn43X53gy9oPCMwoDPYTwokar0aLxfXvIGidLpoMbpoiA4r5mS8xlzQqXndU1RLeYAtosMwYa2mJsIIf+zhHXYpCPzpNPRrsDVOxe6IZGA/c2bbreBYdTN4n2Yc+mMyz2nT8f8h/GZYFSlr/HR3wNNwpzP/fYAxEoKSrMnmFVLOpSa0CH2k/GXeYzIxqZexkCDIqFYsAXLZiu58KwsDw30eLZHQwvAFFnPVMEl3FemLYgdIgTR2xyA3pz0H8LK747HHB0Z1LR5GA0gxjQvR0Smp3ac2rJ7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXJpc5FtpMpM+2xfA540dveOFmM74R6Nu8yYjET2OWc=;
 b=ZKws/JmGvSZH4FdayOJb7fGrI1MVE4ftNJXZRJA1CQNuNMR/uQY0PLdPoEl0j2pB+c+b636Bz4XlKCZ39lCrzKUmYwz4kG84718Pn3XpHlQPxAk7ZC8rBYW7VrVuTVi7PKSUsvEpNWbT0EHwCB7qQ+qSfPa4RT8Fc4KYybRAUaHwvpfPzYQJL9c8oDbGphDqOFKbCtdMdtcVEvFFVl80UvX0sNx32rAdqoRjUh6w0ZZxa4BbMbRdLtI2Q5i2Ip6vjsX3A4lQBwNeScOZ4YgRb9mb8ma50SHlU9OlWUEGlX0vQEvupeuX9FT7V7SwrbQk1+naxyqZ+/Nxo0A9r5SIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXJpc5FtpMpM+2xfA540dveOFmM74R6Nu8yYjET2OWc=;
 b=IngH4pYzHxkySUL98wl5QLvQZhHyz7ZZI+vO6tsL9ls+XHQ2uweecHRmew6u4mcjRAy34gKo8z4I26nme7N4ED+BLnZCsQ9+8gjPNBpa221i5wlKNfg9aNfWcNHtRH1hubTzJdDpbHrmKnoExwHh2CHyq0U75GqDYZ0oVwEXdzQ=
Received: from CY8PR19CA0030.namprd19.prod.outlook.com (2603:10b6:930:6::21)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 05:59:56 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::d5) by CY8PR19CA0030.outlook.office365.com
 (2603:10b6:930:6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 05:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 05:59:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 00:59:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: Hide pp_dpm_pcie device attribute
Date: Fri, 3 Nov 2023 11:29:35 +0530
Message-ID: <20231103055935.481843-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103055935.481843-1-lijo.lazar@amd.com>
References: <20231103055935.481843-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fa8435-0dc4-4f2a-9b0b-08dbdc321b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBYVLugyxkL3Ro3+4V0BcP95Y3VCiLeKmcOlEtymU1b15A7goyUE9gqmnuUGdRZBCjyJqI+wt2aQCQdAL8MAxROZYfeBqsoXP2gqTgtez3xF9WCA+PPeaDxkYK5ZucfkMFpLf/QFypxZ2ZmJAjYTgvR4A/3YyPJlBn6bYGDTQ9iHe1nvrhtYp+dKhgkW0NGIjOzLdgsAwa0wRjPhxqELklQtXKUWplVSiB7V4rOpjg9+iOzeyPuYfiJVUjG9UOzaVbg56AOgDpqJvDKFZYxJXm2BCnjJXj8Lra3CuaIiHdnasuhpS0YkPiwzxuUy4LRRIpPLcHxCv5qMx4WOeYN/dJKQb27pT7DsUxGPsa8x1CygFPRkwn8qPYeByTjdhZWGPTJb/Q8ckpKundwaiCT7D5MN4g77LxZKHaYE2+YHcbvxmSqxa16mqpd+yUOPtVfw7MoK5dg+IINk/s72TL8vPELeTHGwqFC47V0Aw4bHGAt8t4AIw1cf/5R7pIaXLY/VTa1EhsGrB0XouWIZZtuJXRkp7wm/FQfviaJa0gqjV1C5t3ec6hMgqNslnTGb2MVm/+YKFAWCK/iNWmFkotzFyqxQAEyh0Jc2WHNTZaz+j6s1bEFLb/z+w2ht3zqE/knqErgiiE5Rg6IZzYdT963MIvwzzHNUOKZMfMeYl/vsJ0y2dQjJ47VZFXQmIdd3NPYybFnR29zfkUE41LxV09mMvevTFrn5DfhcxlC9JLoAHLOKrVU/JVKGRUxG+RfHAt9qzLHK+YzKpLf4GMPsEcSBmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(336012)(1076003)(2616005)(16526019)(426003)(26005)(478600001)(6666004)(36860700001)(7696005)(47076005)(83380400001)(4744005)(2906002)(5660300002)(44832011)(41300700001)(70586007)(4326008)(8936002)(8676002)(54906003)(6916009)(70206006)(316002)(356005)(81166007)(82740400003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 05:59:56.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa8435-0dc4-4f2a-9b0b-08dbdc321b14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hide PCIe DPM attribute on SOCs with GC v9.4.2 and GC v9.4.3.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 083048131bca..8f57c77a45dd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2249,6 +2249,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+		if (gc_ver == IP_VERSION(9, 4, 2) ||
+		    gc_ver == IP_VERSION(9, 4, 3))
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
-- 
2.25.1

