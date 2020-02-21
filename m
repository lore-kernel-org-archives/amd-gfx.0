Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ECC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895B92067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uwaAsqrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895B92067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C12B6F4A8;
	Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 604506F4A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CItgnKvbq6ToiF9Mk0rQOvSD5QGU2oaq2p1FxLWdjcPYl53o19qD0Jz8jWRXobAJrYh7lkJqMXdOscnRCpguPv3/fUzWqxkQZ+p/s3ag7gSJxZRdGF70VXv3sIaAb+MlfZkMCDUxWnlEdZYnGI5eqqhiXHjbD3jdvB7TzXfmJnwmHfhGRyrE+1x/y3h1YRUMlPVrqrieYnEyuBhzjFVYxPgaGjGo3IUkZFjXYuHrGx4PfP88DBtNuMdD9udEjTkMhJeeLm2FkArFjt14KvqnI8hHD08Vp5T/Rs/iXoT/nWqmrke9VlNr4/nw4NIl0HHmm6egCxIe8xFEDK25hvwNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0shsGe/pQC+Hjcny/gfx5Nq6TOPD9naCHfFqJ/4WCw=;
 b=l7r0+uNgJbnfL7tx8HcDvqnKierOkaxrr5iMIQA5Pdtj9jg1GB0/UYhgk0ziItKJScC+D43tmkDwxO8x9xVKVz4uIOyiQ1CcqQuNXnKDSzU0vhbSV62cnZi58JCNIFAmZ4PwqzRRjg4Zq2ZAzmW0O9UHzNCgqK0jekUFMPaV8zaC59MhuKYeCr/J7JmrV/6z0TyLA5a7u1/Ad5RuqpmPmJMkh47Q+hWNhXKtdS8UvFy364OqVr+nZ7k6HE09IVj2WPR2Ibsbg98Zea4LESat6ANdE11By+uzNv17ktxYcS5lJSbqtX/oE3IOG5b4e++1ZBYy+T26Ja37wTFDHgInmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0shsGe/pQC+Hjcny/gfx5Nq6TOPD9naCHfFqJ/4WCw=;
 b=uwaAsqrlA+/B8hVfrrmiK0dNs+pxcwkJZrBxCZhzhpt/Z51iSNT692P9hAi0s4O+Irnozn1x3EZHmFTTsl96sMvMgHGZCW5WTlUaKn5BmyTv4bahgv4qKABnQWHjS16I7snNqIrmG16OhOwLFK3bh/yjqAW29FS32F4dqdQQpfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:54 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/35] drm/amd/display: Add dmcu f/w loading for NV12
Date: Fri, 21 Feb 2020 11:02:58 -0500
Message-Id: <20200221160324.2969975-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0215621d-5040-4351-853f-08d7b6e7a511
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB240932583375F7870761133698120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eDWUmz8qNWQEyyvp/R9QQ9C2JzMtf2vszTSdQ6YQvOrStF5aMEDieONPR13awYr5ac7cqCsL2lVKiLU3HzwTeSVF4K95xOmii3kdarjB9xzpeR4tb6sRQpu4ug8uSpMaHT4c69Mi7SXU8mOLsfpU6c8Ys5/5mmqNtwNC7+hpRiAXV7jbMaSXtBtVRueHKwC4PKbADK9K2JurAivDEnimDhSnRE8KPiigXfH++K425SAXEX4DbaYdLTMeOmtYA1ei2Gp8yXUx5rXv/h3Juu/+6qRxZreZvSebXK0RRBHfBDhr+jS6HN33Lve3j43xvCeKx1vKePY/ZECM/q5daeuyw9DQFaBg2qiL/e0kfUoWnoNec4ye15TL+Sl0xZnFtYQWiWzHc1Wy5R4O2N6UXW8ybx0njJTbJMDOWG5xdLHByBrCJOgHh6/6wQ/DljyhE7p
X-MS-Exchange-AntiSpam-MessageData: X409G/tGlvivqAnHHiq92koLnvndGy6AHyIv75eflGRDEjbnpFsQjnA6Ej1Pbh/ZRfDvQ975MeHi34N1GT9ncYDc3BwUABkRQdcXhOa54a/EheIufO87ufrXBPYt0bqLpf7d+Kg1d5mb8InCEAJbmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0215621d-5040-4351-853f-08d7b6e7a511
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:52.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lbagHBlPkIzghBqF8kHdqERWQnNwFSk/AEiU05/B2hTX4SREXw5ky2hvLNHP0lZBrJztybkhFW3hxfcYjhP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
We need DMCU for features like PSR and ABM.

[How]
Add path to dmcu firmware binary and load it for Navi12.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 933bbe8350bb..bd88396a8469 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -98,6 +98,9 @@ MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
 
+#define FIRMWARE_NAVI12_DMCU            "amdgpu/navi12_dmcu.bin"
+MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
+
 /* Number of bytes in PSP header for firmware. */
 #define PSP_HEADER_BYTES 0x100
 
@@ -1088,9 +1091,11 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
-	case CHIP_NAVI12:
 	case CHIP_RENOIR:
 		return 0;
+	case CHIP_NAVI12:
+		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
+		break;
 	case CHIP_RAVEN:
 		if (ASICREV_IS_PICASSO(adev->external_rev_id))
 			fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
