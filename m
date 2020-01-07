Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE4C33CA1
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756E2081E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q4B0XIza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756E2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB2D6E130;
	Tue,  7 Jan 2020 20:56:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1104A6E130
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 20:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJVrCWRststdoic/LViDbm7CZkg6Yj1cktVBrVXauE56AX60XL4U4nXfUny/91xX7JX+RLyS9Rl1neFFP4xPuNTSwl6XtqXFQnTLVxxhnyTcpQqkExI/1erCOdNVVgNyaTAOVvI7ZckmJVXljfgx6I9SJ6e0r1MnuAQcQU/anSeMue5eO1ti/H4lUmQlMM5VDvFW+CrcNYiIPThRG38YVcl/N0XeX9mW4oVPgdoLAPvQqdCyvuMFwlVFdv+4wIXecvpqAJJnVqAjiBZjKWIgvCo0iyED+D82Bjy3Kk4YXdOfN7YMoR6JqzGOx+CyqbTchPS2qTvDac5KdBuPqaGd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC8BwQhx3qLNDNo20FNU75MJwuxyeO3k1exg2XG9CD4=;
 b=YlmY0uB4rBXwLbDJC7xcFQHbqvl27Zp8o/iH1r+N2rixO3NoB00aoyj2lo/uiSNF4+Oo4kEcTxdfbZebRdasJ4MqzbDbYNcx4ax7VjxRwcGskGa0DXrQXbG9/XRbN1lqU8CrXHO1cwk2yH7uZpbCpxHSgC1mEsZPJ3DE1YKpd7i4pevOiZEk5duFFpoayxfr2yLn+NB2R+rLvOeldbZErRe23JdGmR5c9/J0bYf09+lXF1FJr/W265SIM7ICI0OZLrOq9txkpFiuv4+53ixGWktUbcXqpQdDWSKLNaloElb9AZCT9c8+jKreYo6n0qzmzHrn+R4rudvuNHAglk+FyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC8BwQhx3qLNDNo20FNU75MJwuxyeO3k1exg2XG9CD4=;
 b=q4B0XIzaDYoElSTBvDzkuxFE+Pl4PCxWuGcbtIjuoqQcsHQTlel7eqm41Mz8f+v6gPtP1UCJVcCd1pAruhFaflkmwkQ34fxHngu9TQFj5YmiHnJrLGfX0ObC/kbngZpLerql0m3HNJPAsybrhO+oP69ujpX9BkS4rqmPLpkhjpQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB4089.namprd12.prod.outlook.com (10.141.184.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 20:56:18 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.008; Tue, 7 Jan 2020
 20:56:18 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/vcn2.5: fix PSP FW loading for the second
 instance
Date: Tue,  7 Jan 2020 15:55:07 -0500
Message-Id: <20200107205508.2651-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from ubuntu-Golemit-RV.amd.com (165.204.55.251) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Tue, 7 Jan 2020 20:56:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26e4773f-ec46-413f-ceca-08d793b40abc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4089:|DM6PR12MB4089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4089C0F8CC143396F1C848F7E53F0@DM6PR12MB4089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(66476007)(66556008)(66946007)(7696005)(2616005)(1076003)(5660300002)(956004)(8676002)(6486002)(26005)(52116002)(36756003)(44832011)(186003)(6916009)(478600001)(316002)(8936002)(16526019)(86362001)(2906002)(81156014)(81166006)(6666004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4089;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6k2lQ9lzSDlFWzddtXrZKY5LXWfrBhTQoCSYLrxqJaDe+oWK1sXJBB+6kEEVwLyTi7YThPbU77dCtS+N8iwOv8wFIirfoH2owj6BZoMDXoFwbluTjb6W2e9QwuQLl/oHhAl7LUQ7pVvMEFt/OkGSSwG3Vdyner6SXKITh4pcMwLf0eUsDUVwll8ZgzEFxlGeuVFUlF5yEhGr8fBCJMRbROGiG4ZmpaebP9fopoMu98f0ENwcX3lFJ40JQc/OXYBiyL251AeDLRTgS/4xBla1tqnKp8WZVoQn9TpiNdtUt6NgG3hOi5Rbf8pBL5AXfaUssaepjgavqrBX+DOJ9zHUtyW7GNfXZaHwcbII4JQkU08JrDuGlm2xnraMzDDUQVhuiLGjVylWI0kMKKtqpoAzvtIEITKCP5C9/HBxmCvC3CL0LjNmRWPyud8Y0PwlxZ+k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e4773f-ec46-413f-ceca-08d793b40abc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 20:56:18.2185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxEEhw9jcUvFeLY+Qfq4M1Q7aAHKKsKNySGfCg2HL0F/sCyd+sO/AgtZKilpE5jP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ucodes for instances are from different location

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 4ea8e20ed15d..fa9024988918 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -384,9 +384,9 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 		/* cache window 0: fw */
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo));
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi));
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
 			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
 			offset = 0;
 		} else {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
