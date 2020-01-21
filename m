Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADDC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F7421734
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nxyJZjWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F7421734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B436E297;
	Tue, 21 Jan 2020 21:39:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54A86E297
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 21:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw74x6F8113H+GYHEddwrBej/uYcD7J+r8Dsxg6H2gQ8Q8LFL6i9QOYHWR3g8F63GC7L/7US5+ZCC0c91FCWr6GMFtOkumcSBw8KmoXMA4ss0FJpVjtr67xytP5ZkEfQraVIHecZT8Gh+8oCz23isZN3B2TwTyMJgo+AEk0lRuqjwHkHIqOSfvaRX3OUx/h5GWBxImLz73H3hBP2gkeXm2s0Zmlw5tpnFtlIUZcZuB6oIX+ie+8x9ZeEyhgrKRlJJN4fehFtrrrReg2CL4bgM4vfxfDAFpgcqIIVORM+uH8ogKITmYqICkN7vVlj68A58A1uaSfFclVSmxfziQHsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7irSOXLrtxHgKY25GBWbgvo4M/oreE0TSxKtmfpITVk=;
 b=XFIpRNSmNpOqMfkkHSWYhTOQWfo/tFP+09GdTvhvkj464VrxvGr1CKPl8ZAVKHK6viAH9yarWaUDe/wcZtOSXJgcKEA9gQlzGg9pMUSaEvzOCqtzAI1dcayZKBsyTTSdEqaHhpkEwmtWShUqnz7aXqNbux1ldowaiy4sJHESHW6ZKMyRPW9235g/vwEx8yrmWAX/l9PaiBYr6HMneA7yJhROIJYl92ShHA9svL8Jf1m/iuhJGYrk8SALJi7f053T5b9h72lSXRN5kwxEFq2u7wCjY8b0rdSIVNSdz5xa8VsaLvcF6LTRjSk72tr17DhcN/nbOhHkRFVNkYPxGCbDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7irSOXLrtxHgKY25GBWbgvo4M/oreE0TSxKtmfpITVk=;
 b=nxyJZjWwTlGIovU/WqwfvQQmJm6Jy92HA6zHyqC0ATqW6okC/hDlRhm5bqSiRaM6w2Wd3NFA9nPMkmZHsTEZmxTjTphc8EDdReBA2q/hkF7HwNO3LR/K0XlVIB4Z9M/YoN/ajQ8Zo+sffevD8suQNL6/jIPMvstPphW+Z0kBr6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3094.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Tue, 21 Jan 2020 21:39:38 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 21:39:38 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/5] drm/amdgpu/vcn: fix typo error
Date: Tue, 21 Jan 2020 16:39:30 -0500
Message-Id: <1579642771-8907-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::37) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 21:39:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8c87f11-017f-488a-dbb3-08d79eba6a65
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:|BYAPR12MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3094F9FD1A8B776C522B603FE40D0@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(52116002)(7696005)(5660300002)(36756003)(86362001)(4326008)(316002)(4744005)(66556008)(66476007)(6666004)(26005)(6486002)(478600001)(81156014)(81166006)(66946007)(8936002)(8676002)(186003)(16526019)(2616005)(2906002)(6916009)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3094;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzfTuP6HUt7Tz3yYWuSE7wTnvWBeQjqaPfqQpvfg4+Pp2BJSnR4Ejm1roKcKoa6b67US21031xhGQUMIrNfizscONTFPqkKfUqAa+/X6pCCPu+JK11kkZXDYbqSOVZFdFnjDgOkk4+9L9IvwjRwfNgB3lI2/y4/FBDa+23jx7i69KYWEJuU5hSrSUX6Bzk9Vf0aLQyLzkv1z+86OsVtZB547FmWRkbQP+vYt8t71DQFuyQvdU4klnv4bvFfl7uJD+XoMz8R3GK045C2x1ED84jxBnV9DOY/rPLD2e3t2+bSR6kiK/Um4VzQkll9be1Wj1yHgP3eA9ltHRtpSBZGoCIxqu2QJzce2AMNx900gN5WNMGjOszmMfH2VlGl7fSKVvEfuyYWWtw371C3RSLa1XU/y+aemHjy9Df4RP97escHGznaZxXWKn+J0m5QldDZX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c87f11-017f-488a-dbb3-08d79eba6a65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 21:39:38.6078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRE9IeYpGCpBqmLo8zbjXGqUM0o2Q2RkbUU46HYa4vdRIrM1qVeJBli9tb3J0IkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix typo error, should be inst_idx instead of inst.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 60fe3c4..ff4f4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -111,7 +111,7 @@
 
 #define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
 	({											\
-		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
+		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 					\
 			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
 			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
 			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
