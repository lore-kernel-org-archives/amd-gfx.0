Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D061622249
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZVIBsqVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061622249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A2789A88;
	Thu, 15 Oct 2020 08:29:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E5F89A88
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 08:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh5ui2AzHfF/h5dX4IxSdKH7vMlPkeSawGlaeQoQ+eVU8/sSrHwpaU/KdbpIV3tORTH3C1r7t6wvOk6zUbsVBRiVeM8aGEziqMIFBVqruo/0SsmgZ0q3PIZWgyt449WK8bNarz1EEuAlL9eBbUjWfh//Oozd8fmK/yspjRlN65tEIzo3Rdu3zWfnVsm/YgkA5TBeTGJAfbqhCJxoYNtIIvWsRt+2ZywkUbglOj4iXnlVKnS5FpgtxZv2+AFOcYwx5MnOykPJFOffxdltTtpt2RRv9s4PR8/qmwRMGPJjbtYBfbmvaQPWZchO2/mS/qupNP8fUH4TGGXBG2Ohsh+UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeERxXtkALaDDDglBigzi1zSo/alc0d5TKh92bBsQ2Y=;
 b=mjw1M4CJIPSvytvgt+zxUAVC0Ee+yPUUlfnlbuqApmA6mqlL+u94UJgZ3IqQdDM+rInA29VTzGthhM7P5mejwcBsMB2RGOHLZKbtqLvWMxmW2s7r/nbKrz4VjCb5rRsoQVEP+WxcPBYMuyZqG5MSQryABpj43aMPJJjXBc+V3USW2WMPJlSP4KGEe2c5keDWF8eRv47s5bK4CNAZ7xXjSxPyrH5bQSt3gMrMbeKH8DeDPLnLtACY1Kpe5Al6J9EQll4JLoBfxSygNSsU5zVxoUMnciZcElAj1bqQSaup/TeYi73m0usgSxR1dEUX4eduFwCshtAGEggg1TMEePEyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeERxXtkALaDDDglBigzi1zSo/alc0d5TKh92bBsQ2Y=;
 b=ZVIBsqVHwiRKgYGYePey5bDiLTaN/1E0ENGFiL76sje8l0JehYBZrFmrUnMHH9WpoQeg1BqS5QRPFpoEas/gkBUzWa+s/mM/hSYVp2qsoWbm3Df8naea7n2L5dVDvM/bz39ZtWzSgY5edO+iDhrpFks7c9FDwOXd3Wm3XnmDqxw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 15 Oct
 2020 08:29:35 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3477.021; Thu, 15 Oct
 2020 08:29:35 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: enable display ip block for vangogh
Date: Thu, 15 Oct 2020 16:28:56 +0800
Message-Id: <20201015082856.215547-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015082856.215547-1-ray.huang@amd.com>
References: <20201015082856.215547-1-ray.huang@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 08:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26b94c37-62fe-4675-0838-08d870e472bb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2457870386E4310956581F7FEC020@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWCCumfzthi4a+f6+EcVyAR1QjZt+ZAN1KOogY52xvZmLJZWmtA/+ZOGpNH356B3he/hZc//DABTZTrMs6oI2zm4gMcoVIwYLjaLtLtiZelzobMgbGBdAHWlU2m17CfREtsqX4iKOaWGNKzZYP9qGMP0e4oXYcrgocwtfZt9BAffWEdf1cYXxGyn7AoGaGOIVueu3ub9xPYzwaHtZ5yRoEM6/+XHsCel6nHX5t/rT2XsBUkOSlcmKZtzrKVl7pCP067u48rEaUPqd4XT8RjWp6uDkmpgGcK/k48oQm9JNTcixSZG/g+gHuPdvOqZbtUxID+CfMDCLVJSVbahazulcYVfsqe8f+YT5VAYplZNvHpTnDsPs7bRZTLcbghpSy6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(86362001)(6666004)(8676002)(478600001)(83380400001)(4326008)(1076003)(956004)(6486002)(2906002)(2616005)(36756003)(52116002)(8936002)(6916009)(26005)(66476007)(316002)(54906003)(186003)(16526019)(66946007)(5660300002)(34490700002)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zMeYatNMVv08WHIQUTbf1Oq9qVePuDyT9XGl2S9954zaFpPUZG7WJXfGOMYGz1vozBTN6k27RZ86d+/IINXw9wOgHdVhR88zoxn9FuKe0gG+vh/qadv5sRmnVdGPRREPJIB6ce/S1+V45SWW3Oy6YW/z7kwq+TebFEYC3PRQFM/VZG7AwmHu4xLHQjFe0a8Cy3AcHxWqudxwQPXTzRnD14fND4xWleC+dAdER9saGjggE1aD7jybs41CErlq3RMrMKR7BUWus6aq9uZTY2Cu1EH16eaN8kKeZGFA8Xw2Nksy1FJn18+vid8k8d8tOcmbbY87Ty+V6sTOXbEPHQUQRXCyELh5O28GV6pWSVB8vccOSrJk2e6rtXgAXasjYtGEjEVsmxFWXfCMH/KybsACXbz706iZkQejH8efHhMU/EFthm0uBJ3YawTxdg/fszGBTkimLFCP2IdqAVV3JtY8YPSutJUd+FtIAP4QPXwCQH3XG0jwzRwYz2voS/WEttA/4I+JfvdczYYyTehGrKWpmaS2f5K+L0Kkq7Biepv5S4NojHtXZaVh7cAbqHxdKK3C4K+yrSBq4FPTlGhYVImIDzawr4/y4dd8FOYNzZFLtR/onwaYXuPNPKLGVUKkoKOicHXl9TERWKh5wmTbXBeX+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b94c37-62fe-4675-0838-08d870e472bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 08:29:35.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/osLZAusQlgOsITox35kSTqz3Zlwum/6KO68WbZuPxgv9ZFhoDO7+fFjMELFw4nb2xvQGLkNKlmu8tsIydDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to enable display IP block for vangogh platforms.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2f0ce854160..15ffb47bd1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3014,6 +3014,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_VANGOGH:
 #endif
 		return amdgpu_dc != 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47bd79c9e6ea..217533e2f181 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -621,6 +621,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
