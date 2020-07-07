Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACEC433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 08:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370C12063A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 08:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d6znRepV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370C12063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DE289F63;
	Tue,  7 Jul 2020 08:04:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FF989F4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 08:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3CyuV6nkeUEz3LKozXxdpU1B2NUTQ4Kzw+wXtGaHWPBEKa1uIJn0Pxqp78zbbsXzJcP6bVqL4aUlZIpY1kowWTBgZhg+7/tOV18PZst/VIy4SddsQ7k2ZBzDj5BtfbLkkP+rzS15uQceG4qyZ10gaMIxr6oZpVj64zdjiUo2O00Ntc6Pu0REeLb0EojkEMJ9nKGm65A8PA20GyGgo8ozQLE4U9bQV3MOHuvZ8VNBfRDmPrxbNr/U/KPu1mHKhgXNKyED1wW7Z9QFOS4z0AtjYqNQM3X37Hg3Y/MImI5XsSfcyrzM/GuvM4RMl8pbRCxwLvE/UWXlNwB7lhqNe4WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAYNc3ieBedYkLenOfs64FzoDp5DNfGXXmnsfReQnkA=;
 b=mrjnLe9JFFZuvc55BZ4YT0yTAmE3VohsVrP1Yxi56O2Teq7f2g/2JEeLCQmda8zwU3wuG2NnG0s8HSBU+dyiTItutq0/P/Pl1i95QkPoDLUuvXV7ksIeio4Cg1lTrNUaW6TJZNoYlr+Nc9j7HOtSs0OfFEHXr7GAccM2B00QWitfzwB9ATQP3sCzyG4rLrpn8O1wVO5Dx1NBg96h/z1F8hPcVaMuIbo46BSZFx8DHj8+eTpfxb9qqX1ivFz2WegX2d9l5JuzlBpJJn6Au4tBIL1n5ERjzbA+Qt3h6NveZdetXvzAJOBqDS7YlcL8zJHwrSbvaFhkpbRYTdwXVZ/tWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAYNc3ieBedYkLenOfs64FzoDp5DNfGXXmnsfReQnkA=;
 b=d6znRepVhIPbwX5LJZxo5ePc2FeEddMfs1g34+7B5T/hVkQjZDOnaSH1l6Tw5ILs+TkdDA7+hCS/QuohPlYF9qf/BBTWe6o9FWezh2tk1SLq2zm5EZZfxKdt9juvjbVh2T0pV3D7e4M039dtcnEMHRbDEuxTR8Hjhbpc9lF6MDM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19)
 by BN6PR12MB1233.namprd12.prod.outlook.com (2603:10b6:404:1c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 08:04:00 +0000
Received: from BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::ecba:2f1b:24eb:9e5b]) by BN6PR12MB1425.namprd12.prod.outlook.com
 ([fe80::ecba:2f1b:24eb:9e5b%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 08:03:59 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct vram type and width for emulation mode
Date: Tue,  7 Jul 2020 16:03:41 +0800
Message-Id: <20200707080341.4270-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0144.apcprd02.prod.outlook.com
 (2603:1096:202:16::28) To BN6PR12MB1425.namprd12.prod.outlook.com
 (2603:10b6:404:1f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (58.247.170.242) by
 HK2PR02CA0144.apcprd02.prod.outlook.com (2603:1096:202:16::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Tue, 7 Jul 2020 08:03:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8da8fd9-d27d-45ab-2da1-08d8224c4df4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB123314C7C47512F5E138BC27F0660@BN6PR12MB1233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEkvrCnx5IG902bvCYP+zCzAkKtZtL4JI+dIcfITswiYD1DbU20bfY2k5SXCcsVF5Wp7LiJNiCxdqS/l2BGM5Ojswj+r0rpcXmp0SN74eY/cR34NxxOQ5x/fIw8EsYTj1vbogkkHlQdvdGQFW92dQbVZk6ZDhOGz9Cs2lc6Vw4hrC7yZ7gTE5UOssRzeOcZzN1Vz+wt1RQEDekwMp942GRQta/bpoJ4uV5xSshZp95wBvee614D8C8M2zYkuMX/8NUJSJiWfFe2wddQl/VwMyul0QCLxgRcSMiuP/FA3HdJEV/jrtsi7uFR6YADw6ZxC3IMgucMTGv29XQXXnGHGyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(316002)(86362001)(8676002)(26005)(5660300002)(956004)(6916009)(83380400001)(2616005)(2906002)(66476007)(16526019)(6666004)(66556008)(66946007)(6486002)(44832011)(478600001)(36756003)(4326008)(52116002)(186003)(7696005)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Zw5TceUVIiI4hneUZgN98zsn0DLceBzIGqkols97+xVfUi0+JHSyX3+gOTI1KII4MvN16BdJvG1p0uw2heUw74nh7v64VwEAaaqHZaep/zpKba4nMQKG/xDmUQWWSRmFCOaW/24sJE66f0gm0WB2aVobQaK3/WnBIkMeSRyHE6HLoNgaVVocoTYIYTZHIgeeNmS4PpQUYrG+RPP70940O7KNTDB29lpm4YqmgYiFE3wjKIGblqe+sRkOiMbq1HRIJO05tyJelW+SowJP+zkOd1yPoVkyVyly2j6MbBNfKc+oxR128LpALzir1K8zYCxHLlG5QVse+ok90dI49+qehmWPU4/JsYcfsTJK7zto18mrueVxT7ZFy3XlOv1a0TthKmBkuWebm9hVpwZ/HvAKGwrD8TGXRmU0L2vTWmscEH2IUFHoQ3UAh3steiwXlHn6d9K1LY2QNYYXnKhGVHCCF2nSel7OwnQVK81eeJ6F2kKidIqUGKOvgm4Vg4HZm5PX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da8fd9-d27d-45ab-2da1-08d8224c4df4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 08:03:59.8919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjBNV1JktyINc1CNGo3f1iq9u2qTFx2tAHL9YAJIwtE1LSI5jmHqevzrO5W8l/lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1233
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
Cc: Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For APU, vram type is DDR4 and vram width is 64
For dGPU, vram type is GDDR6 and vram width is 128

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9e6b039328df..8e30a57afe18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -846,12 +846,12 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_emu_mode == 1) {
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
-		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
-	} else if (adev->asic_type == CHIP_VANGOGH && amdgpu_emu_mode == 1){
+	if ((adev->flags & AMD_IS_APU) && amdgpu_emu_mode == 1) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
 		adev->gmc.vram_width = 64;
+	} else if (amdgpu_emu_mode == 1) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
+		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
 	} else {
 		r = amdgpu_atomfirmware_get_vram_info(adev,
 				&vram_width, &vram_type, &vram_vendor);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
