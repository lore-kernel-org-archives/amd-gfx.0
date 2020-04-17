Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C918C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5226121D93
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yi14jF3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5226121D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EA16E2DA;
	Fri, 17 Apr 2020 05:24:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B184B6E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 05:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYTtfvG4muVWhkDS66gCXkYHN5slOsc4l+JJQe8Fz7TgWhAlWuyyNBW36t+UWXFdRpgO9Qv5NyJ+XMIEN1Vz3a2PAWeDm06OAtrgwveOihF9RBYmA0fuwQUxePcauknEn2MO6lzSS21cf4x08q8cMTGuSVoRQf5VlMT9/IyUvLY3gqI++kNpz+yGVNlgHB6rKO75bHn6nApSuvxl9CGZpOymPW9wEJlH9iO50rHcgBz1M/LJWm5YGe2O8Un1+X8yW6GNXD3hjT7BLG72FlkdFeUGalUCAaM/rysuTz5X3qeby6PsDR2sRH6a0lmQzQcR6vdvDprkVNfxMqFq8KncXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIj7yByznAIwKAXaWnM2kQzW8tqtCRzPBeQj9IlaICA=;
 b=eLQ9/qAXpdC9uHojlCeyrqgakyjWvK6uyqnOezw21MRSD8imhDJLo7uMtx2DeJwx2hdot5CJ5kJU3ivB4yHdgH5SxorMCvM5U3HAPEFYF3dM1WfM2M/aOOs1bWPLmv6cJKuB77brYT/uXyEwUgkWXPIhHEJgEYyZPUEvPbrvYrSmqDXv+SbjxjmcZgrozki+mObL230loLGP0SOhrGWbJziPHzSPlItBA2Ri3lYk9I4YD5x+vBYTARVmZDlFhvL3nnA7/I3/gfqW1QBlqLqJSMn7I/bqrmmEz07q5zYQnF7aESq5woGrCkfA1k9XLL5Q3Xcr9qh6k/Bh0Q7RrxZONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIj7yByznAIwKAXaWnM2kQzW8tqtCRzPBeQj9IlaICA=;
 b=Yi14jF3yDQYzTpzpOxMPWdzKn+lY5kB7WnLDOveNvG81FS13LmNsNe3PVNM4+P8UBDKC6FXOkjj0BklnXtmMzwogEKbpSTAB2x2h34bQrxyUDzddywTGMnKYV8VHwXi0qqW3qyc9zkDBe3yRvVjuk7BOzA7IaGYwXF5BQw6OuU4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3003.namprd12.prod.outlook.com (2603:10b6:5:38::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 05:24:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 05:24:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: load SMU IP for onevf mode on Navi1x V2
Date: Fri, 17 Apr 2020 13:23:49 +0800
Message-Id: <20200417052349.28301-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.1
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0004.apcprd06.prod.outlook.com (2603:1096:202:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 05:24:09 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d2ffc83-2338-43f7-f9da-08d7e28f8f4f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3003:|DM6PR12MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30035C6D62642D710BD8BE41E4D90@DM6PR12MB3003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(316002)(66946007)(6486002)(52116002)(478600001)(7696005)(36756003)(2906002)(66556008)(66476007)(26005)(4326008)(16526019)(8676002)(6916009)(44832011)(2616005)(1076003)(8936002)(86362001)(956004)(5660300002)(81156014)(6666004)(186003)(32563001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWrAOqZL1FGIYKL63HPb0oAj8mxIo3OspcxBFlyzw817JAsrlR3uuUuuqYyNwmBbSdpXo2fidQAXmhwq+wdGg6eoUAZkPU5C36X5ckZ67NOtCFPZoa0h1813ExHT9R0M0EM4DNVC1QfYXce7KDEhCthK4QmoIE47wAOa2o35ZLRSn75uJfpsfsThr9xxcLcCo5ZmHbY7Dkcam1zYNOMpnD9VwmAXbYlozF4N1Nhb2tINJsuP8gITFy9nuuoiSSRybi5KQWMEsMXmQd8zjoF8IkC3ZkS0kfqXGHrpJ0p6ugkN8m5RpkVNqlVDKXHP52Xu5gZOR1Ws/0QRl6W+afQ9aO9O84vAnd+ktIwTTqY2BjK8GEdiS04yuFqhwfwg0sOjNEr/UzX9ZALh3JuM5l8uTKaCl1SbVE7gdXBybhe8J1ijIUGITPntetbHFyonSVYivNxdRJy8miigFbEWqqex2skLGSaAebIMNJb2RnvYBzAOubU2Ayr1WfMVeQn6q7jP
X-MS-Exchange-AntiSpam-MessageData: eKVDgF5M+z2NeNmlkJpph88mwtEUQax590zlXSZJBBtnH211C5FelC07Xix55Zli++KxdKtMLOwhnhQmih4N4Dkk/vkQPa5X+w1Bz0f2JymaxMq3zFRQS8oUf1quIilo7lia0Mzofxru7e9+CqyXiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ffc83-2338-43f7-f9da-08d7e28f8f4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 05:24:11.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSgBs1MkFZQA6LXlNTC80y2c95DyHxW/e4U8W+MSCN/FiQJQqIPqi/Q0uloPPee2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3003
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
Cc: jack.zhang1@amd.com, Evan Quan <evan.quan@amd.com>, yintian.tao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU IP needs to be loaded for onevf mode. Otherwise, there
may be accesses without initialization.

V2: added SMU IP for all sriov cases since there is necessary
    checks in IP operations(hw_init/fini)

Change-Id: I513aa4140f1169ca048b64985cafe9c7577afca7
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 995bdec9fa7d..15ad9f78344c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -474,8 +474,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
@@ -485,8 +484,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
@@ -498,8 +496,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
@@ -509,8 +506,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		if (!amdgpu_sriov_vf(adev))
-- 
2.26.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
