Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CECC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B94020714
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JCh2EPPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B94020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 161226EAB7;
	Fri, 20 Mar 2020 00:23:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F5A6EAB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZXv3+ue81QzPuMx6ioaDwXL25ZJRjPjjgLSgo9fE9Zi1jEMwCE317Reo8rz0EPUERm99WGSlaMDSeSdsv7u5V1032eqKZEDeaqZS66Yl2k3cWo4uWoLLwzKXCQyW2cjJkibB5LPpIPjGC3Xhj5d/h9g8sw99kyHsSH+e2gLDQwIVQsShfVfOJKFXs7brb43eYSCuB/Pa5b7/oHr3j/5TeHJspPGVUVQwwEL9NyqUKN9zW37GH1RmMW09z6h+M0LJhyb/k6WPYHD7tWve+ZIrFaUo69pDIuf8Oxqddz7V6tfhlivUW/oQzGfVahutiQ0YzxjAm473vSyQvmSc9LgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOB28rLF/iPZp2YTSco2lCAtpASsygT262VRhdA4hmU=;
 b=AEhNiOy3WDMGtRYz8UMeJC/kJbj7n0bwx27Cn7CDnhDXkRxsa2LoFqLuXqUgKNjJkWgEB8Nf/7SDo/iHnmf6RtxXs0cqyn84C9ahC6ToEon6k2Z6oXApkBFflrGZjVpzcaYJMORK6H9E4erBimItk6CvzUnMumHFD1IT49eAaUpcviaEWcnBLWS35Z9P9wKLwoHmbZYKx8yP83MGYtABIsVXabUilCc+aPjOYPTn9heTjv9yyOQj60PSkwvIEq2w0TF+kObHbVxh/tTAr2lxswYhjCQhi2EfGmWwCAxXJlSNF1IWTmzFLjG/h3XazOnns8Q70JIqfO3knU5FLDAAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOB28rLF/iPZp2YTSco2lCAtpASsygT262VRhdA4hmU=;
 b=JCh2EPPJv0tqk/uv4PhsP/NeEuU1VYzdoYTBnJQVIU35apYvZHv/pycPaJMmmxMLZ5upKCeDVJREoalS0TU2JjFwneXaEfGxzlm86fcZXrRgOAU7b1M3pScEnEplTE3USl7KToYQZ6hJr4UwykuGRj+UCM7QhiVgStNjrWC7+ms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:23:54 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:23:54 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: reroute VMC and UMD to IH ring 1 for arcturus
Date: Thu, 19 Mar 2020 19:22:45 -0500
Message-Id: <20200320002245.14932-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320002245.14932-1-alex.sierra@amd.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM3PR12CA0130.namprd12.prod.outlook.com
 (2603:10b6:0:51::26) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM3PR12CA0130.namprd12.prod.outlook.com (2603:10b6:0:51::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Fri, 20 Mar 2020 00:23:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39a00807-c187-42aa-17e9-08d7cc64f226
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:|SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB436572D3DA751E5BAFF594AAFDF50@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(6916009)(66556008)(86362001)(36756003)(81156014)(7696005)(66476007)(6486002)(1076003)(478600001)(52116002)(44832011)(5660300002)(66946007)(8676002)(4326008)(956004)(8936002)(186003)(16526019)(2616005)(81166006)(316002)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4365;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eQ1mzzQ+QUShM5TOzyT1xSQPXGeDYp6gxZ43z9KpmgSGWfEVcjy5vFECotGF1WX/420nSQjJIyFppgV6iJPxmiNKUkSJz5rbZjoRaI7KfLMnRMkBlQUPMS7gsD/eEIuk9RD7GsOP5PWDJucNIehq1u07RW1hg6bjYuCTut3n1ugSnbS9OHnesBy9IXpKtrdVcor5yyewmUJVJSKz4PQtulOpBRLnXmOj0BqJ8BCgqdfm9wpKUHTb+VmDpJuzAis48edmXsMNXMj3rjRjjNNnrCWm3caksZ/XT7vIGX84TeeQf7YDmpGMM0MkEFpbxgT2Rzcu2O4hI4CnuSfO5ltmSzhEgfnG4Xbkk4ROxeyVwrXIm4L51c/ukXdIRv+ynuQpWWPxZ64yV4zhdmXfAjgfLWYBk+qDVOO+4dsA1v6zexxjw4gi8BTJ8YgirApQ1Cg
X-MS-Exchange-AntiSpam-MessageData: 5Hlc+6mk3/3VpEkJSAxQbddUjslR2iDtAjaSULNtHdxATFAdGquLhR3xqUU4UZwg3vTsCIeFfyFYy1rUzlH5RuDXNrkn56oMYSYX1c1rEFcEbGYYchnYuPCwHNZm+p2zK4XAWvn/YGXYaExkTiKjLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a00807-c187-42aa-17e9-08d7cc64f226
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 00:23:43.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELY2BEoL+HKK06h2m1DZJiMVX7cQ5KWoyz99T/zu88FJbOkN9jZu7VOGPFqbf26h8715YjqrcKhynsV8Nb7gCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Due Page faults can easily overwhelm the interrupt handler.
So to make sure that we never lose valuable interrupts on the primary ring
we re-route page faults to IH ring 1.
It also facilitates the recovery page process, since it's already
running from a process context.

[How]
Setting IH_CLIENT_CFG_DATA for VMC and UMD IH clients.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 8d41b4c27205..95abbf67ead9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -210,6 +210,24 @@ static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 	return ih_doorbell_rtpr;
 }
 
+static void vega10_ih_reroute_ih(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Reroute to IH ring 1 for VMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+
+	/* Reroute IH ring 1 for UMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+}
+
 /**
  * vega10_ih_irq_init - init and enable the interrupt ring
  *
@@ -251,6 +269,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32(mmIH_RING_REG(RB_CNTL, RING0), ih_rb_cntl);
 	}
 
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		vega10_ih_reroute_ih(adev);
+	}
+
 	if ((adev->asic_type == CHIP_ARCTURUS &&
 	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
 	    adev->asic_type == CHIP_RENOIR) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
