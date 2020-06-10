Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B07C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 23:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4484220760
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b3K7dHfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4484220760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A766E86D;
	Wed, 10 Jun 2020 23:21:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1C66E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 23:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPtoe+lVr96xlmFtkQ5xrstPCLyMhQcv0XHSLB9SALWTSpn2pw4sNo5/Mjx/3TIc+ApiVUVR/dZsC9nhbej1uEVtTBTGj2Jf/nXnlqwSIjTloTHAaVC5PiQvlM5Nzur6y1J6S7/YSiLDb4Mgqu1B4UlwmvHlKadcM6e4/TOHriFkcndOpFn9qDkvWlJH2jZ7HiI8XFFHrDkor/7g/f1U6tDVRhgDi6ydOAAE6bNRNpQhEJvvUeJYYSlmlEp8+vv62OVPOzC/U1y3IxDYN/73oSK0ukfkLwBIpv5I1uxfA6l+dhEowFHuJmtNo+eZ3oOyy3kHZ1md8uhtFHwnQw8KBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbuWkPu6AGu8Db90j0FKVa7dy4kJmqpWIf6vHyXJG2M=;
 b=aLm6CS/mC/U2DpIQca+GGxzrWraaaSDfIH/pGCusoNgdN5Xm5Bd/BCg7+OMeT2Hm1M1S6HPjw6xC8giz0V0+acNkMtcK1T94sqDhy/CSNhuuhnttMo1PerZlJMG3yNZjMazPqfZT/O3FrV1r4FgljMfdfSybYiNCp8Z0o+LJuD43OqI31v35rn93HaKrgCvwFCWOu5kXkst8rPffZSy47YNPf+qf1iKpZKJGP6s8pORC8VfqCHBvianBqp90m0eSOGY3UYJJi9Ts+Y9lGNb3KDKioT+cyw4Dx3vMGYTu7XEmU819F0ZFgHQOySFTIkXymErCXxdY8V+cXgQ3O52kAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbuWkPu6AGu8Db90j0FKVa7dy4kJmqpWIf6vHyXJG2M=;
 b=b3K7dHfQFoGONYAx6OAaFn1pIwQ9Hd7zj8C2+1KcSqnc3piEPlcjZP4ruZvGT/58Q8bWJdodcUgXbpshocSSzWpvKV/0Humk11jS2SKUdZ8CkKem9PLBr08BJRljoAacZb/iB72nO1xPIl8zx8FvbBWTWaJT5S1uGoFnKQ9Qyyk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19; Wed, 10 Jun 2020 23:21:35 +0000
Received: from DM5PR12MB2375.namprd12.prod.outlook.com
 ([fe80::5118:a660:9ba6:f638]) by DM5PR12MB2375.namprd12.prod.outlook.com
 ([fe80::5118:a660:9ba6:f638%6]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 23:21:35 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Reconfigure ULV for gfx9 server SKUs
Date: Wed, 10 Jun 2020 18:21:17 -0500
Message-Id: <20200610232117.182296-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: SN4PR0801CA0022.namprd08.prod.outlook.com
 (2603:10b6:803:29::32) To DM5PR12MB2375.namprd12.prod.outlook.com
 (2603:10b6:4:b3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0801CA0022.namprd08.prod.outlook.com (2603:10b6:803:29::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Wed, 10 Jun 2020 23:21:35 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a90ca0f-7e6e-47db-02ab-08d80d9504de
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451D341C8FCD25C6849C3D4F9830@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hA5lYTXWEA5elibdNzAD9dGKBY2vsmAZAIhyMuAWME+7LHiq1RdRrFZfahX4ISe/L+JVMnwsMzSbivfutVKph8bCLP/lp59orHl77u09Y95MtoIjWnB4VTgRehlUkrc9myKmKi5nqv/WeNWwnWmvzt0F6hLlyZr/hpwQmMm3Z8zwymQt4lyU39rBEOWq2c2QoFoPEVP2Y5JC1AnEZ+rQRH93tSmZxlPDI5yyHX1BesVDojz5xiWI2kMrrYQVd+9muzR1wwZHSLmp2y5hZDDhdvmMJOp/DFcAbUN6ckvy/l2r5Jkbm4yo/OVG/Ibbjulw7ThzryHsxrATI8mg6jszA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(7696005)(6486002)(16526019)(52116002)(186003)(316002)(956004)(4326008)(26005)(2616005)(66946007)(5660300002)(36756003)(86362001)(8676002)(2906002)(8936002)(6666004)(478600001)(1076003)(66476007)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4V/FaRGMRIq2IzlDZFvFLiW7MS/acyQcBXogUSLwDrQN4g29G1rumwgxWO+P0rptBfYrioY+1oEBwJdWk8YwAp9miwIwAEPlgu6eFSjsAlfXF+kz9pxAcgIUyRxgLNCiV6hXG0EUnQTS/6LztAuacxGsBq/SDOHZZUVYP3YVGPGWsarRiy3UphtVITqOVp8sI2C2xLXnUBRMJDlC4cofq6HeLhMevglaQiJPEb7+aN7Iz4QK48HqiIRDj7M5fArCFbXyEVilg9QZd46/7dYuxSPlovptmAiBCjDwnOETiV05hvkLI9J3/4y+JemxCXpyxJHnJR1Ez7QKmrYXBHmyIN1yy5wwTO2J969BJ+hJsBhVnUGWptfIde/zHV1BwT5JR7qrbGaKhuPh+3aVbTA4XHZY4DKLs80skI9WkySCgbPJVgO4a+jiYqfhvDzZL0/DTTQrbSpNTCLNHiNG0LibLS0Z+taznBCaGu5RHk7e5/w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a90ca0f-7e6e-47db-02ab-08d80d9504de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 23:21:35.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gNVXHL6kcGT3b9H7wZI/hbFeO9HDdqoPsHl1slxqOaQmIlYlMEaQunrveTt+I/K4ke/lfTI8xJi8HJlZLov4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA ULV can benefit low-power modes, but can sometimes cause
latency increases in small SDMA transfers. Server SKUs have a
different trade-off space in this domain, so this configures
the server SKUs' ULV hysteresis times differently than consumer
SKUs'.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: Ifc33aa857714c4c209b19a5d44e0a05c478db195
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 2f1f47de9634..58382646d962 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -505,6 +505,36 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
+static void sdma_v4_0_setup_ulv(struct amdgpu_device *adev)
+{
+	int i;
+
+	/*
+	 * The only chips with SDMAv4 and ULV are VG10 and VG20.
+	 * Server SKUs take a different hysteresis setting from other SKUs.
+	 */
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		if (adev->pdev->device == 0x6860)
+			break;
+		return;
+	case CHIP_VEGA20:
+		if (adev->pdev->device == 0x66a1)
+			break;
+		return;
+	default:
+		return;
+	}
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		uint32_t temp;
+
+		temp = RREG32_SDMA(i, mmSDMA0_ULV_CNTL);
+		temp = REG_SET_FIELD(temp, SDMA0_ULV_CNTL, HYSTERESIS, 0x0);
+		WREG32_SDMA(i, mmSDMA0_ULV_CNTL, temp);
+	}
+}
+
 static int sdma_v4_0_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
 {
 	int err = 0;
@@ -1813,6 +1843,8 @@ static int sdma_v4_0_late_init(void *handle)
 		.cb = sdma_v4_0_process_ras_data_cb,
 	};
 
+	sdma_v4_0_setup_ulv(adev);
+
 	if (adev->sdma.funcs && adev->sdma.funcs->reset_ras_error_count)
 		adev->sdma.funcs->reset_ras_error_count(adev);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
