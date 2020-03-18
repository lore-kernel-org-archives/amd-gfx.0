Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C2C4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2738820752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ryz+Tuyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738820752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CB56E984;
	Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1D6E982
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9DBWgP3E0sf+eo034AdYjxtneKzfKi9iQjQQIv8JiUcEVheJ+GuGLbHch/aEuOqJfIzeR5BEK898TrDz/gS+4O3HQFdbUP98fhiRJNPGYxRlkb52qZwCWPUJW56lEVTqaEmqrRycB5MMjpVcdJnodNo6SEtAbX66jfQunTb//AQIhon6K/07IivMIjqgOKiTwbfHmMdtd8psQVYyHr3mv9EnujKUwpRGmO40X648OR/mE9V0UWeryngABXGTx49LF+QTOwTzQSlcy8se2eoyUtGqFqjr2GB0xRSklNZ5ddDnbht6bd3Y/kIJ4RxEhY2aUKyFo7hHLwY6yWZIH2VMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MglOmO0ssK+INTmjDgTt4zpYJ+7Pg+dz5ots7hdTsQ8=;
 b=kxa42c7naHJg4cVZKs5HqitGMJdOYXPi3L8cGQaaIKEQkOY97o8U3n3rqT83sJoopdcZyRC2aAnYmCysAclHbhQt1Yu7/V8aqJFw3UWHgY79TV6Fdi9RqmSEse3zBoadFgvCWs2+1GVCvl+bOADNYPlp/QEB/30jSqF2hQEY2frqIsJby0HLiiLpQr8XL7dgbvEw/pK7czONr0Cq6z1wqYvzJEfQd9dYpokxsso/4JEuC9ru6XugCgpZTyeGkFdZvi1Zfjpr+kD6lXtHNGcN1SbflxorDYlN2DGrVoe8NKj0Ft6mZL3s5MabuhKC2rd0fnixexVv5jtaM/fexsrpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MglOmO0ssK+INTmjDgTt4zpYJ+7Pg+dz5ots7hdTsQ8=;
 b=ryz+TuyoGp93W9klK9tRiNhoT9iXBMavgUBb0WGfQT6jT6fetCUytv4U/ZHJ1QqyLMjDUzSX//K5rYk2F2lU+KwtUQfi9BZbzePs8jE6kc040qDCwPAPQ1jk0cBUc8EPRlHJ3Sfq7eEfVkdbzmZW5I3w5E7r6yORFpfLsvr2E8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:22 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:22 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: reroute VMC and UMD to IH ring 1 for arcturus
Date: Wed, 18 Mar 2020 17:51:15 -0500
Message-Id: <20200318225118.10756-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d60f6da4-ee75-4426-c280-08d7cb8f04d3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44150E11CDAD0E74F5755A5BFDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWjXMYyxNbvTgegQsoeF4IhyZ2raTmeOZbkcFm9gJBai/f0xtM8fPzRj5GyZIZzupnAESOexdNJhg8BIPDaYAwtcgmXPlWGLVQ0XkJ3z29wvGL7NXzv9BwTf0Ny8smE1XN5ymVHkE7KjXj4VzDYidtKpLxHqg2t+VVi13bEr5J2G1OqN3VI8HHgAzWhdD6hOqMOViBafyGF2909pNIpCvr+UAfbNxb4IxJRWGkwcAakI4inTDY7IN4uoKLzkTdLdv2BAKjHYQ6ecPXfI85yVe1AQSw0UtSLIHCK5AEptSc+9XEBW9dCmajKMKWu1rrn1k4bkg+wPTA3VyHCPEIfV2uZyMvPp3b/5nE8ddNmzkS8jN+BzU/tkxM7DVxlnHglTmUQgGXBwCL1tlMOUJuyXjtUSSYneneQqGF2N5oSeYxnZmqlOtmbNOWUQGp2vRU9q
X-MS-Exchange-AntiSpam-MessageData: kG517oeEyuMOQRDbH535GQaWvBdkIJF4X0Z3+mCDYQL4IdApr8NfJuoCNwA9dJSShbN5SwSJFcb+vJdd43EPx9ZFxe352I3ezcIbqUreflmbfgZ4/G7durY/22G0aytO/hKXaashPc0HWaSltKUIIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60f6da4-ee75-4426-c280-08d7cb8f04d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:21.9237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvEqnNiy6JGj6tEViJrfzD6Nxo68VkolAbOz23eGLdAC4yfNfaA9op4YceU3qmHCv8TAfjMg9laKOpl5a3qtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Same reason as commit "reroute VMC and UMD to IH ring 1" for vega10.
Due Page faults can easily overwhelm the interrupt handler.
So to make sure that we never lose valuable interrupts on the primary ring
we re-route page faults to IH ring 1.
It also facilitates the recovery page process, since it's already
running from a process context.

[How]
Setting IH_CLIENT_CFG_DATA for VMC and UMD IH clients.

Change-Id: I189a6b35c9f5bd55d001fa9672d7d08ba4e8591e
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
index b687fcc4c9b6..73a00e752ead 100644
--- a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
@@ -205,6 +205,24 @@ static uint32_t arcturus_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 	return ih_doorbell_rtpr;
 }
 
+static void arcturus_ih_reroute_ih(struct amdgpu_device *adev)
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
  * arcturus_ih_irq_init - init and enable the interrupt ring
  *
@@ -246,6 +264,8 @@ static int arcturus_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
+	arcturus_ih_reroute_ih(adev);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 		if (adev->irq.ih.use_bus_addr) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
