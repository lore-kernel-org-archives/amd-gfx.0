Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D455C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 10:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32670206DA
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3A+flAc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32670206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFED6ECF2;
	Thu, 12 Dec 2019 10:02:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277DF6ECF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 10:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNqKHJHsY+FYADxhlFtWcvVkTilSmCx7U4jH0g42ZS3Xkq16IFlOi4wYvU+5XVx+reS/3NeYTJNEzCeLKESSt3bz8QXOyWTVhx4S+OGFpy1u/xNwizMnzis6aJqG2nfrQNC9KOLk/LAM+6LCZplsR4TQlIza9RE2I4AUt3rXLIBqKDwTvnVjM9X4zCaEJrGABkc1xHfCzo8bBx7EP3DhVim9nVTOBLIWNkJXJRp+hXgDEkdIof/iKQW4mMX262Dh0COF2mfVLeBvAq9gBCMTJC/MqXfgQcqfk8MhEokiM/8IPW+oTD6s58doHjhp48I7sRYR+yOcP296Mj3bwdn4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgNFx8qW8Ry24notUCFbxysX66wyr+60hKhz6P/Hy3E=;
 b=NTTG33SaVz7fMfFhUOQenZZk7F/3IBxTp9gacIN68MA3qfvSifvVlOs1mlmpT5beutqByjuxtF+PIE8s/GBSklGSWHFTaA9/mKvG1JVvdOjLvFTBCkUI4EyPZx3jesa+34PzbRe+DienjG4KMy6YvJeZEPiZYbkZzdfB4dughjW7gc5WQnFhH6BOZbkXL0+mSRoYSoEEaRkLlduv2wTHDI15ZV3f4HNyjLBAGMKqAdkKg1pxiAb9jJev+cv1L+JpLtvcQty/2g60ilfIvDaZB+YQ2mWQ/PNk8OSSn4I2nbg4HteA9VWpyuzgFJFrDKiNi3e6bQXEozgw0GhSEUtEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgNFx8qW8Ry24notUCFbxysX66wyr+60hKhz6P/Hy3E=;
 b=3A+flAc4D0cNWF5pyvY3Tdsq/KosS+RYJ6lqFUdYD6lEq2xHo3NSNBQvmgNAW1oEEd71wOUERE1Y7hXbLHs0U9Rd+vRzXDOlXJLgeJICA2+MEED9S9T6ek0GqLlnkprWBTyKaA0EMMazWThmK9Uzgvp4mKMR/MfinskRBJE70js=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from DM6PR12MB2891.namprd12.prod.outlook.com (20.179.106.13) by
 DM6PR12MB3209.namprd12.prod.outlook.com (20.179.105.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 10:02:21 +0000
Received: from DM6PR12MB2891.namprd12.prod.outlook.com
 ([fe80::150b:d50b:fd87:a1b1]) by DM6PR12MB2891.namprd12.prod.outlook.com
 ([fe80::150b:d50b:fd87:a1b1%5]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 10:02:21 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Prike.Liang@amd.com, Aaron.Liu@amd.com,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Date: Thu, 12 Dec 2019 18:01:55 +0800
Message-Id: <20191212100155.8741-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To DM6PR12MB2891.namprd12.prod.outlook.com
 (2603:10b6:5:188::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6352e319-2257-473a-024d-08d77eea60f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:|DM6PR12MB3209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3209263F65AF84FDB63C13DCFD550@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39850400004)(366004)(189003)(199004)(81166006)(81156014)(4326008)(66946007)(478600001)(316002)(66476007)(8676002)(6636002)(186003)(66556008)(6506007)(36756003)(1076003)(26005)(6512007)(52116002)(86362001)(6666004)(5660300002)(2906002)(2616005)(8936002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3209;
 H:DM6PR12MB2891.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mxdbu7jztrL31vYFi6+a8Cx7dh+ynA191Me24vUirm2ANxZBdk052elphyhD0iBkNXkqvrOqtjbtER6J3ec6xrWkQfBnAQTljaSxeEJId/dhNYkYjWRZ9APUxmfOXCJw5d/PnNNpBJscRAJvQjT0wG2Vfzk2Bn6GQ1IDa83qoZCjSLkgSpoILKrNLjVSCwJ4RZj6a90de8HTEzCQ7hgCrlvbeFMvPT1FDycwxqd152f6EwD0t040A2kUBu2TkL7enzmzNdaCFdrp3sBFOERg+KOfe/ABImJDLy3tsoLHyNx0dudU+nd40JnSryQNq2zYZPMxSJ7rnhrjPCYtZDpD5VJfff+1QiBFiXtys66W4iVJc6EYVobmi/MkCji0nh+o5GPik+5fjC6yO2BoJCIIu47TWvhOtbq7nLwbn4F7z/nAd+7fvSjjjlqqkrp8HjRx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6352e319-2257-473a-024d-08d77eea60f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 10:02:21.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzgDPhXVMw1J1BCqAv5/1KPOK5drAIwYi7tSnHVy6HZOYgW4cX08xR8673tESUgz9AkwEjMNcKITD9hKvC2kGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

When smu version is larger than 0x41e2b, it will load
raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
needs to avoid adev->pm.pp_feature &= ~PP_GFXOFF_MASK when it loads
raven_kicker_rlc.bin.

Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ea58d0e5be4c..56a38d67a949 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1038,17 +1038,12 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		break;
 	case CHIP_RAVEN:
-		/* Disable GFXOFF on original raven.  There are combinations
-		 * of sbios and platforms that are not stable.
-		 */
-		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8))
-			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		else if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
-			 &&((adev->gfx.rlc_fw_version != 106 &&
-			     adev->gfx.rlc_fw_version < 531) ||
+		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
+			 &&((adev->gfx.rlc_fw_version < 531) ||
 			    (adev->gfx.rlc_fw_version == 53815) ||
 			    (adev->gfx.rlc_feature_version < 1) ||
-			    !adev->gfx.rlc.is_rlc_v2_1))
+			    !adev->gfx.rlc.is_rlc_v2_1)
+			 &&(adev->pm.fw_version < 0x41e2b))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 
 		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
