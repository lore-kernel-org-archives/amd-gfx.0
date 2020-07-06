Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B37C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF05720715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uc3nWk7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF05720715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2626E30C;
	Mon,  6 Jul 2020 05:05:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A3F6E30C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULqkGJNozB1mmq/9r6GTxQzC8rDcCQAazulZTT33mZKDUTXMR8YJSnZOUcWuFeyJ8pDKATMs4S4o35LjX83KyLyrQ/s/lakos7VZK+v+fLVs7QIDbszAgIa8gGQ6Cw3FVQPUego+QV6XWJkcWvtwH2y9w4DtkfN/7lTArbiwLDKibPatTn0YuAxHSFkDMXxTVeaxtAIaLak5BSHFwyI4N/6ofleBMIPGV7mnPM4QLNH0eU702x23nsxTxgXZz8CzwlFBzosoP4u0J7pXJcLDJfUqu79w6Rk+kS0cPZLpQEQAdOludGRpsbS/vrQHnTsRA6dS+j3SdRCBbrJwoVnj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC47PognbJqL8G2JJL/xi7JxJzBh7vv5Qom2HVCPyOo=;
 b=lb2HUj9K64zSEZJyq42UCMx53xUM5+x0lQtXRwKYa8byqstpiPPCvHxDJNZ1G9oSEaISKSmF8FT4PzFzqb4PfwxX4zLNNwHkoNCbv2pbAisJfEIzh1ycnk7EWz3uNRsZ9K5eJswlUzj7W+RpKB19LDUXf8GS00Ph/EyX2cLXbh/dqIVWeSjVR4OGLh/qGz42wUgYHFAQF/r34BQMCUQrHzD6uirT9eZYVHbF8QpbkaOTpot+yCDBmqAX/sCQre05DVXugA82PQ2TdJphkxdvUG58uNJCKPt84Spgwwa0RZ+5wh/W0fpp/mANYrMJs0O5lh+dlJwsICJg4JCaQuS6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC47PognbJqL8G2JJL/xi7JxJzBh7vv5Qom2HVCPyOo=;
 b=Uc3nWk7wtPiY0BjCNFop/o5bYw0JPH96ZIU7xoERRRI2InZat9jNh7b4pPmcrnsiXWTOPfJC0KJuahBx13d7Y+QCB+jq/cTZBX/gteyrqhNk/OxicOxFvs6Tq9w9baSMA5XiPPNedYe93CD85ZbI5WjnWtxpRGugJ62ZhXHzHFQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:50 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:50 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/amdgpu: use register distance member instead of
 hardcode in UVD7/VCE4
Date: Mon,  6 Jul 2020 13:05:02 +0800
Message-Id: <20200706050509.714975-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8993e6a0-ecf5-4baa-96b7-08d8216a4042
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44708A0B06CA07FC3461C013EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6P2IQ/PEYCv9vMQi0mGH49iIB71rlATeAd/4Fs4AxKJQR75ZU2G/FM8RvfqrzArq3tbOnbzLq8mJvDZ7C4hVTfWGVV4pV6RfHB+D97Bwmm15OyAygOccaPKatfsnj9lXB4fGZkvqWzG+drb5pQDhOyacFjqf3q3HpCnOnUwtskspPj82WbwyXymI69zgv3flVrNlCfGJOZknDIJH7g9ZpCCxpD1ecm4W1VjCIZa8DXQfC5n+82PPmPDLWcuoXkreewONHFaJGcEYYeOGSyG2pujY/zPCjsXGBDV6fv+6LCCRrtqfPhDBa5j8PT8YmrapukqU1xMBdpH4Fy1WFGpXaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ubAvTjVEgR6EYPu3mn2UxQ64zfmbtsCcCmOl0ydWpSa37yN11wDekpa/pi2k/v/InWfV2KUh4+U7xpVbYa9H810Zdco8kHCCK4ZziSayqZf57X1zOA91HYGUB0OdhJiwCuedNrh+lgFseUAvdRvpuOmhlXLJZ2/ZJZyT8nJOJE6AbBVdl0bSWYRjD9c04FPF+AJ7HRruUIUIDCBkDY/yLBjBDuCU2LuBJceDx8ryX5bwCinacLZsMMKT3SyFMeR/eGTOEO0pL9J5JJs79tiyqylTvUKYYvb60YshBDGW2C3RQcuXl9e81NRg2tiJj+9dBeHdDWVjitj7CyYF1SC25I2cjDGD4HM+MfkQSTNNSZDTDOr7w4BbaZsxO3mXLOhVv2eq8zEoyLwfdhOXkvJTOD/bsmH2tWb5POpRLE/C77jff/tZfh50Gfh7CpnlqisjHdtagROzoUABjs8KuJhUYmqJpWsZLta/zOn7hyCwfPFSirrEoMkaL7jDl7f9zCwB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8993e6a0-ecf5-4baa-96b7-08d8216a4042
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:50.3899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeySM70M0vT0e7oTYIMW8D+3TTNFMkQzr5V8db0umo56GvgLpWBLM5Trmqrz+2hAdkhSxde1N9NLu7ywGqvmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of hardcode
in UVD7/VCE4. They are for the same ASIC.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 7a55457e6f9e..e07e3fae99b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1375,7 +1375,7 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for reg writes */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * 2;
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
 	data1 = lower_32_bits(pd_addr);
 	mask = 0xffffffff;
 	uvd_v7_0_ring_emit_reg_wait(ring, data0, data1, mask);
@@ -1417,7 +1417,8 @@ static void uvd_v7_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for reg writes */
-	uvd_v7_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 + vmid * 2,
+	uvd_v7_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
 					lower_32_bits(pd_addr), 0xffffffff);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index a0fb119240f4..37fa163393fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -991,7 +991,8 @@ static void vce_v4_0_emit_vm_flush(struct amdgpu_ring *ring,
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* wait for reg writes */
-	vce_v4_0_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 + vmid * 2,
+	vce_v4_0_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+			       vmid * hub->ctx_addr_distance,
 			       lower_32_bits(pd_addr), 0xffffffff);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
