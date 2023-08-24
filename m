Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD246C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B7110E5BA;
	Thu, 24 Aug 2023 21:31:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D67010E5B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYYkgCEs4AO/TA5PKlMVNWGgn2QRSZYpyCG7lMdSgvweA/HeOq3r+1T9F/65TfjQ0TRRAEXhwY6G4tqxZGVoOiuk0lEgtGRtqC5UKUCMaMEvUAUSRlYiE7ww+oGZfeb7Y7w1sADGoxtTxXTUJERAgJvSNgCkAUkunKAnUK3OpcUycTPCkE40+dkZVOKbPvYnKxESECRFsR3fQkDVIdusiiJ08cxexfQhtw1rGoO6Thx0onUUk3i9n5IYM+Ytr26etaeyH/AI4GWRuNp2vqwFgcmwAbPDAN8UjWRxcTSYKGvBQX8rDwcKy19qgQLVFH6/p0sGq+E8bgSgwV3rEEodbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Zs5sIux9tyeTs52DXjIJpNP89U8dnzUbLuP9Qv8LM=;
 b=cMVfZOCEbzo677R6H9EAC9z6ghPqRt+PlrRCHVX17cku56yCNPv9zyb66zVcgAZ4sJfY76tzMzYABBMq370edjLv4w4JARnuLEGcxLVlmGfi3HUC2+HscPt+jAiT81hTEFV5fPVqOMwwg8EAmeUzJJqykVbbjFUEEQWlTqpc9enxmGrQI2j9nZqEQ4CdPV0w/KHoZS69WG5SPR2p4IxQGE5FJP4TVPkrG8SW+hD+/ZHgAbIr0/myFrRNd/XDvdV7yPpBhebAZ+CszjTEdSp08uevL+uRax8GOOfYpTTkXlP7FyB+TnkhmRm65pV7gPbm5M8kFcC2veM2g+974QDdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Zs5sIux9tyeTs52DXjIJpNP89U8dnzUbLuP9Qv8LM=;
 b=LUlbloYj5d2hf4Gs/1l6OdhAlrNya543fKLm+eBFn2ntvtSX6ahOYcLT/0+1RIGxmZQpsZWMN1KnWHVHBfdo5T37ZYYNfuBpnx4ELMKVTNPZiSFlUfguous+PhNerkGXoz7yTBdR8csIWR2OXtnunGYfaGoB9xeBWp5FqiKX3Fg=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:47 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::18) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amdgpu: add VPE firmware header definition
Date: Thu, 24 Aug 2023 17:31:12 -0400
Message-ID: <20230824213127.2725850-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: a06deb8d-3195-45d0-1a49-08dba4e98588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIs0VmHJn6d1p/FniIOzQ+qtG9n3pKjQkCm94nlT1Jj3PaPmnpyyj3iqDCmNlvFeEXwNMKdDLbqxLVBT95RVsR9/kAmmmxc5/R2nuQsrjRuLkuGF2sv0SZXQotZmdU5Mj36z5sW9ii3YyyBqbUmpaThgS3DdNAmE1kXU+w+RynaIrHN3gzNRqqVnpbGZxlYAq4eyrQHIxVUWYS6RL2yA6T81Y4oJs5jXUadTNWaH4njtPg+yZ/PDUuLY4ieDTBWYL3an/4M9ggpzQFxEwzlgcmYmn79k9lmFg4dBt7cLcQJyLYb/QtvysFPMrDCltVRVUVFn5i71gLM7+lDW3vYdP9fmw4jiDhV4XuCM4vtlS9AhAiddul0J4MIv3VFKd+7qe6k7q9jCxeaFdisx6nSXLjMVPVgQaoTH9SpewE6UNFIKgV4InHhVswO45HwtRd6DMkj7X8Z4GRbN1NOiFWa3+Zh1iEyColside9BF3QlsVZynkUxey6qLebmM+CEoPcP+ZrHRO5cWL7Vq7YUWGxPgWVlaPmLk8RrTIpwBYRh9WAdaQT9/vCHBtxSVnS95d2b0GthF+rSV5pUmBc1g68ULLDb9/NW4x5hoaKMLsnfliTxj3vxPH+4S1iFZZMW8gYJ0OIGQQeRRcqWb5hxPD4KY7oBtG5SQZ0kwrGo+9PSEaUA7ZW7mAjyBgzGAynUpBtydWR/4KxSN7tFa3J1R8xhZdKz3mlQgi9pdkGi0Ei1A0/SJjUN6vzWvTOfVyAdX27TbsGl/Dz7JWb1NzRn/7g+YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(336012)(426003)(47076005)(2906002)(36756003)(36860700001)(40480700001)(6666004)(4326008)(8676002)(8936002)(26005)(7696005)(16526019)(478600001)(356005)(1076003)(81166007)(2616005)(5660300002)(82740400003)(41300700001)(6916009)(54906003)(70206006)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:47.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06deb8d-3195-45d0-1a49-08dba4e98588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add firmware header definition for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index b03321e7d2d8..81a8ddbd6b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -315,6 +315,19 @@ struct sdma_firmware_header_v2_0 {
 	uint32_t ctl_jt_size; /* control thread size of jt */
 };
 
+/* version_major=1, version_minor=0 */
+struct vpe_firmware_header_v1_0 {
+	struct common_firmware_header header;
+	uint32_t ucode_feature_version;
+	uint32_t ctx_ucode_size_bytes; /* context thread ucode size */
+	uint32_t ctx_jt_offset; /* context thread jt location */
+	uint32_t ctx_jt_size; /* context thread size of jt */
+	uint32_t ctl_ucode_offset;
+	uint32_t ctl_ucode_size_bytes; /* control thread ucode size */
+	uint32_t ctl_jt_offset; /* control thread jt location */
+	uint32_t ctl_jt_size; /* control thread size of jt */
+};
+
 /* gpu info payload */
 struct gpu_info_firmware_v1_0 {
 	uint32_t gc_num_se;
-- 
2.41.0

