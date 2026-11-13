Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528C606A8B6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eromlCMx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BFC10E065;
	Fri, 13 Nov 2026 10:15:18 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ED310E065
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 10:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob5p+mk/HwnAnDFavr5nLBQjnG3aZzXFGwroE9L8X0KSEk0eStVXB9JIF9YaC1xqhdmgY66ogJUB+/szh5hLuiZrDWF6D++cYwEobV4yTE54plXePKg3f/P+SR9S0S7qVnN9fogy6t8c9GJAR3RkrZ7uJynZI99ZXeCwFy2s/k+XyEMGjWiVxcmjajeWwjZQ90mmG8ApNGw3J6Rh/QFObwYAewUqO6+Bl8Vb8qDBx3j9fkTFf+yZsU4iKQRhAgUg5zG2JtnKlWHoOhCZGLfxEUpEW1BpedLRxrkdjtY4H4axn/JrStIKYrleMLnud6eP5xLiNZ3KgZDRQ1MqE5wLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=RJTq5GMfl9OphNd9AhsF096fNekXviqq1gtSZpGDL8FI5DoeHgcwUt8cC8nOSc7Ro1gjSoSvMN+H/kQVrjMgNUpXElchrnx6IE4skI6DOT5p3o3ZcBK1E3f+6Z3Tv7ga0PuwZVLoj/QuQYSdIL+KigzjvYwCpR6YXZ0oOQgCGnkB42MFjiXD+9QXfyYbq1tdWCbxDz3C4zNv3gbjFiNfDVUjrS0zqILJOlO0hw/hxEoSq78OSER1k0+7mRD2Hnm0U5Cg1RnJ8XFdXl6hzSQvz4x3w+mgBzDdU+7qNc1GFWgb9Hc8JxWFuhAv9SA9VKJ3BG/OSeN2CR4BxFEKlYFQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=eromlCMxL4cMdEGRbPOoMdAbeEvGtrklq+/BRq1Q4h55bMXVjeMLb1+Ro+igiXH2OfWETWd9qws85qbhpeAc4X06mlZ4SJLDZNh9Nhn3+P6Q73lN8mQUZKXXoCkFfQETOdV+CfYmhNc0SQTsRQihKrbcHcqq7+ScAER54WBy1aM=
Received: from PH3PEPF0000409C.namprd05.prod.outlook.com (2603:10b6:518:1::48)
 by FT1PR12MB689230.namprd12.prod.outlook.com (2603:10b6:170:c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 10:11:45 +0000
Received: from CY7PEPF000000E8.namprd04.prod.outlook.com
 (2a01:111:f403:f913::3) by PH3PEPF0000409C.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 10:11:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000E8.mail.protection.outlook.com (10.167.247.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 10:11:29 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 03:54:50 -0600
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Date: Fri, 13 Nov 2026 17:54:41 +0800
Message-ID: <20261113095441.1604-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E8:EE_|FT1PR12MB689230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc30c4f-4519-4d93-dff4-08df416e7c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: zRQ2mXA8iCl8KsxOrYXm+VCilpeHPWZ4vS6VbdWbAtZCTF4k9xNG1Yo3L6ZEtI8sNZgfWeqOtJXxgNX77a8CqQh9r0W68amk89fG4QZ9id4pWOCmMSigITLDLq5Br0xse6ji/l45PhuAh4qsmsM1yJpFSMEx1XnMqbdf1gPSTm0KETwFtE0tOWJXXfWCp2lb8LP0sc0twaumkZjnthvWnC8F4T75EJZpR2uRvyRqPYv1lFWUxt0H46+Js9Ee2TYHYsddIete3TF/r77Yr4AnsJ/vN7g4nrWrdJGqoigCfnCtWxdxqzKNVIEZFPVHleDy9nkyHLQ1CdekCU065FTuJ+qwqzw5Z8vTLhNCFgIGpOxYiFQq3yTu5FuDsxoEdmmWlKVNFljMwRDZxW2FVt21xYaxXsdHGtNYm9JTVzT57/D02FvFi1FFPo9HC4n8ox99kIAz3Gwz8k2egNVnFHK4iTvHuCsjC8XUPJ9jOG+LrZlbRxK3ok5nvCOEmF4BYTEXzfyl1CF/dj+298y7V1oQ+7ZVrTl4UqjbF4pZKL9IJpxCKDiMGeuNjUCCgZm+cM/DIQPgUXOePLHImYG7dEuw4SVfveJqaDaXLa9laL/kSy/s6cIb24q4GOC7JcfRC86xU0pDQ3jG+MwOVeV0Dm8ZsVaqrd0gnHQti6DheSYRyE2QgAmDdZsY0DrZE5leA8H874XZ+JaShJ0BlzcYlmvaXYUhXwjtPCOTHwXAI+3L4hc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IRuwuD54gSdhj7w08QKDpAqrBI9ah96dyTPwPiVK+Zrc32tN6WCB7xjKZDDlZX0ql9Is6gA+Fy6iqY+Bbx/v23j+KAGhNMdzOE4qyLqkNDBUFpYTZ0MM5q+nix5nH8StFIn2qDJASqqq4lGNVpBR8fyHfMndV7JO8Pkppa4C7VHav/YhamFswVw+DZfoECxDlQIsEx9+PPYu7Noy2iiSFnFTG/OpEMOuc1EotD4JuOyfft9OuX74yW1Zly4SrPxGSmEvWRAHjZAyVSBDlvHhyKHD3Kbs7pWA0sPXQHPT+EIi/2AsDaUDp10kwpAqHUkSZcyiMe0yy75J0Je0uxBoCfpGOdrNofxfvnV1yuuxbeKE5AvXw1Z4n8Nb6lCU0/v/Fec2+Ov0YmK0NCv/L5zQ68wPNdfoQV5AywIRLNr5HtufRJThrUsiJoLuiIAUL8u7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 10:11:29.7818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc30c4f-4519-4d93-dff4-08df416e7c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000E8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB689230
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset.

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		return 0;
 
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+	     amdgpu_uniras_enabled(adev))
+		return 0;
+
 	if (amdgpu_ras_query_error_status(adev, &info) != 0)
 		drm_warn(adev_to_drm(adev), "RAS init query failure");
 
-- 
2.34.1

