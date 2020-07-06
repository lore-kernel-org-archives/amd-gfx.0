Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C69C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE8C20715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dK/ECoya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE8C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575286E317;
	Mon,  6 Jul 2020 05:06:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DEB6E323
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEqDqMPHBAGwSiGst7SSJk6hUrOKjiH7xTupnV6/4bmJAQU1nECnN4s/TiYcub6JoPwDemXB3TkfnWZr1f5je4fdO+iZEOFC+yxe/KgziDb3gJyDem41aizzInRp/i58goNuynIAyV2cla9WZS0Nb6tSjVJ3rv/mscu9eUwzr/8pJ4slAVm1ovtB1PQVbl/Ov12HEOMWv0horNmLhcGGhRG9a7l5lDhSMWMs1c7aQIYSQ0oaHLWi3rZbqesJzNGAG1TBbTmbDUukt2kPWwWFGifRVuR06hoUsrpRmXZtyaDdB2pQRT7G4fJPeC3lZM7Ta8HN9LERaIgskAwSFie/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba4cP9G/0wf43rWSjRAQiP2BDj7Z3QftAHmJn3Y8HRw=;
 b=AKUDnrgBhOZeUYEseGuskKMgVnKmDvzz+kmq9YnptlNGpH/BV2vtL9XqIwDIzYa8Kmehyns6j4vYyGYW/+gB7fY3ITt8VPtpuXzJCk38UhPjWRGjTUshOUyc3lDUmOFSWzHOi11WRnrdg6WOSeTijJy0V6oJ4+gesRZDpW2QkgceCiNJQCCUJyqtegikAB2zCyv/lQu+/TdRujogKaQ1gjODvBUvUw9fKvGjIWM5mm4iCPLkq5ETf4lbLwcEG6oBIuNaBn3fQ46xbjOsxBvuEiYiaRdsd1bRWej/8+QH4Q34SWeYyeq6/tgiN0I0NrWL7bLz5YNpCOP6GeqnJ/1dHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba4cP9G/0wf43rWSjRAQiP2BDj7Z3QftAHmJn3Y8HRw=;
 b=dK/ECoyaxevtd3VcX5DrUWEU5E+GcofETGAiQykmydL4qWummqCtCg371EvdylGWPYJsARstEOrZjPXEvkPd2sh4zRlLRBqI8HXDSgvyhK+OWg69+EoXIbDBZjIunMaJF3LPNG50l3F/8zXceUiE2/RAgC2ys358kRMNNhEwi74=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:06:13 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:06:13 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amdgpu: use register distance member instead of
 hardcode in mmhub v9.4
Date: Mon,  6 Jul 2020 13:05:09 +0800
Message-Id: <20200706050509.714975-13-ray.huang@amd.com>
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
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:06:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fadb95d-635d-449e-d464-08d8216a4e03
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470C5D7B8D13CC064BA66D5EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icjd2aKHctKmiSSvX21Gw/0SHNZwoF0rnMHkDiUkZzrM1k+04YiFei1zBHD4U1Rx8LtC7cKuI00GjGeBXbqjAvcpwilAAHrTP30Z5+YTnAPx5oh/EtjauTi4zriLzD0FK/4xKKb+UUFeerXZFPLf6FhrdiMF8AUDs9XM0LOA3VHfiI9gKMDDtx3m6tt0sbZTzxYVO3WLnQE5mJF/8d3y4b+rJx5aiocapHUtXicSpWDPcnS4oHljSy/z3ADzIALc1gKTEloWf6kA6IuqMh+H8OQ227PLsHQhk5GskxP54T6/TulsGMLi251BU+0CzoWbUcYR0qxfn6je7XUq9RctCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4csHGNWnmz69n8U3mbWlrgnTT7e4wvymEOwUaTEsHGO5uQAz6nZ847anJNe7znVEb8sXCmAiVYPL7tDpb1Q25JAmz5mjloBwY82sNi0MWbMhaY+lRMGSfChK1BpMUpHmenND7F8JZ+ri5RGTAQahuy3DcuX5VIIfaByx0gP9jFcyBDsvdWONeX1Ke106mVnsSdWnMt2iAck7pS8n26HtzWIvrfAAvd07P23NQni8j1/uwEc2K/3WmK3o0fenRFigYhi+R+r2K21EQ/1629zgyg4l2WFSpvWXnpdKvNU7aILSudxSdhkggVJFzwVZF875ga7lBEgzCfVDe80JvqYBzbA4zVxwKm7CU/5JJEEdM/OJRLMCkv9N0s+WZyJ5CjBjCOps+WATowFgIXvI1g3bwkpN+h3TMB/3/E+r22SUTm+Us0mqqYY817zo4fhEqSRTE4+Ykne+FClaQnKiR8eS9VJ0YGTe3gwyzw0iMgy8z2vP1XjNpIt0qp/A7bLYQ7+H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fadb95d-635d-449e-d464-08d8216a4e03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:06:13.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YpM0KPkoiP5dHD7lNRahehMm+LKLBBqzy26zC3F71mC9IV5VsReHUAJUDF+f1YKhOv9xsT4aLpinVhNieCCoA==
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
in mmhub v9.4.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index df2c316accde..9979f54fef57 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -57,20 +57,16 @@ u64 mmhub_v9_4_get_fb_location(struct amdgpu_device *adev)
 static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct amdgpu_device *adev, int hubid,
 				uint32_t vmid, uint64_t value)
 {
-	/* two registers distance between mmVML2VC0_VM_CONTEXT0_* to
-	 * mmVML2VC0_VM_CONTEXT1_*
-	 */
-	int dist = mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
-			- mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 
 	WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-			    dist * vmid + hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			    hub->ctx_addr_distance * vmid + hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    lower_32_bits(value));
 
 	WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-			    dist * vmid + hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
+			    hub->ctx_addr_distance * vmid + hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
 			    upper_32_bits(value));
 
 }
@@ -301,6 +297,7 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
 
 static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	uint32_t tmp;
 	int i;
 
@@ -335,21 +332,25 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !amdgpu_noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
-				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i,
-				    tmp);
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i*2, 0);
+			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+			    i * hub->ctx_addr_distance, 0);
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 			    mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
-			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i*2, 0);
+			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+			    i * hub->ctx_addr_distance, 0);
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 				mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i*2,
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				i * hub->ctx_addr_distance,
 				lower_32_bits(adev->vm_manager.max_pfn - 1));
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 				mmVML2VC0_VM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i*2,
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				i * hub->ctx_addr_distance,
 				upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
 }
@@ -357,16 +358,19 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 static void mmhub_v9_4_program_invalidation(struct amdgpu_device *adev,
 					    int hubid)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	unsigned i;
 
 	for (i = 0; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 				mmVML2VC0_VM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + 2 * i,
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				i * hub->eng_addr_distance,
 				0xffffffff);
 		WREG32_SOC15_OFFSET(MMHUB, 0,
 				mmVML2VC0_VM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + 2 * i,
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				i * hub->eng_addr_distance,
 				0x1f);
 	}
 }
@@ -395,6 +399,7 @@ int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 
 void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
 	u32 tmp;
 	u32 i, j;
 
@@ -404,7 +409,7 @@ void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
 			WREG32_SOC15_OFFSET(MMHUB, 0,
 					    mmVML2VC0_VM_CONTEXT0_CNTL,
 					    j * MMHUB_INSTANCE_REGISTER_OFFSET +
-					    i, 0);
+					    i * hub->ctx_distance, 0);
 
 		/* Setup TLB control */
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
