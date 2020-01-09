Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36058C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062FB206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="luNZWCxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062FB206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ACA6E369;
	Thu,  9 Jan 2020 01:09:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B7D6E369
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 01:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esdVfRnBaTdnnqhJ50gKD/nKUnTHST5R+zmD9IQqigDKG0Rz+TfkIQQbVUft2RYVeR+lm4hnkVxVHLBSBm/Ip//cIn3zQ3HltVrOd5MNHoaJ7SLG3vm+ieh2dh90MrlnraouknLx4dJTWzZHfV3b51u386IkQocyxKiNk5j908xktNrQ53zKxdCWlkn1j4KcCh/IFd2rZNJUcML8os4KKqRCPe2X+tZvsxQg7CPglm9MVd5cXUzDEzyqeZjZcfsKMwNnxp0QGrKd4psmiOt8USR4nYwukiVLTe1j7QDY3iEUV0MPnFt+pCmo0+yRJBcleO7BqYgYrrO7YkrNhsuUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a78PcxKzOuE7PLhvjq5sXd+wU5+CEjC4D/gE+c/Ojiw=;
 b=jqaGW+E4ky/WK2InhscDC8yz21hG9hytXNCTHProg5VUfhlFfJKMBgzwYI++o8ReLlUY6ZLsiF6RKZtKGw3AIPHdZehnKvth3kmyVlCNBwgeoez3SUJrNxvQh46ioaP2xdtHoeZ1i8CXyHWCxaif+Xv+CZ9F6U5wnVcIyEas6PxVxfosheP7NqYK5M1mtUp4zs5IWknlZb+yV10pKWKrs4af42XQlD52ZI8848sSoMeQ4fTGCdT/CwNHTSmMcejWZceXyDrlC55jH/wL/eIf/jUVrRmT8ZJ33bEnt2BJu5umU8pOhzHRaBkcMebXW/m4GSSC6LwNOqvIvCX0yN/AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a78PcxKzOuE7PLhvjq5sXd+wU5+CEjC4D/gE+c/Ojiw=;
 b=luNZWCxhTOdRHadPEeoNOO6uVSzRgEfk5aY8EcrBWU/QMsPA6XaXILCNrrVwZE1KnBJlum2TwXPGullrvGeedtQ5b9BgXHi5xZg+amN9k1Kl6R2T8/H7ZgECPC3DQ4pHyNjWcUozOvkAm+E3roI4I0U+fXYigRAzgm3PBiPoGkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3031.namprd12.prod.outlook.com (20.178.53.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 9 Jan 2020 01:09:53 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 01:09:53 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 Dennis.Li@amd.com
Subject: [PATCH 2/2] drm/amdgpu: calculate MCUMC_ADDRT0 per asic's UMC offset
Date: Thu,  9 Jan 2020 09:07:42 +0800
Message-Id: <20200109010742.30091-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109010742.30091-1-guchun.chen@amd.com>
References: <20200109010742.30091-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0055.apcprd03.prod.outlook.com (2603:1096:202:17::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4 via Frontend Transport; Thu, 9 Jan 2020 01:09:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca8ef37b-c202-4455-e4cf-08d794a0a21c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:|BYAPR12MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3031B963FD05E2746F7F87E5F1390@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(478600001)(5660300002)(1076003)(44832011)(6636002)(4326008)(6666004)(316002)(6486002)(36756003)(86362001)(7696005)(186003)(66476007)(66946007)(26005)(66556008)(16526019)(52116002)(8676002)(81156014)(81166006)(8936002)(2906002)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3031;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibzQgOQnJkQJSUT42G445XL0JIsyy4WXwYPsdwmqmA6bf0O1w1yJCYD3kuy9n+usKNvZ87pAzJM5b06ylkCEreSm79YcYTMXEGSJQ5pJpXj5SKrYShCjqPhit0P5y6z7gZa4KObu2Uj46zUv79lBnv4ERwOoDKSOy6cTwXezsc2R5BmmiSIYa3ndg58TmDuIkLSQHEE8wIoJ02Fd1hPBpIhEcKPyVtqG774nj9zBYQwVQsMG4sQtY85Ax2Z28z6Idtqio9wiQqTm+aspc2ItUCt6LswHk/zm6Tjzw10C/ZTAID5ORO1PpV7nqCy/dzY+ckP8YG27Vm9uhlbHYQbHLMaX1P+v6eDhfvxcKeqc3V0Nm0VZ9vIqgWD2X93Q3SE+eLRLRJDQPB+MEfvqX01AA3kjvBSU9fWgYUJpIBRIIHsZKNSBw+GQrbGV1PXjc8SE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8ef37b-c202-4455-e4cf-08d794a0a21c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 01:09:53.4313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAlm0diE9IJR/zrUUQvcYNyYsDOc2dEkdRBtfkAvKVjlsKf5r/L17Pmr/pCbLvJK61KxcDpdio6Op00HYKokTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hardcoded offset is not friendly. And another benifit of this
patch is to keep read and write access to this register be
consistent with other similar UMC regsiters  in this file.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 11e924dd88ff..11428b66c74e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -30,8 +30,6 @@
 #include "umc/umc_6_1_1_sh_mask.h"
 #include "umc/umc_6_1_2_offset.h"
 
-#define smnMCA_UMC0_MCUMC_ADDRT0	0x50f10
-
 #define UMC_6_INST_DIST			0x40000
 
 /*
@@ -186,7 +184,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 					 uint32_t umc_inst)
 {
 	uint32_t lsb, mc_umc_status_addr;
-	uint64_t mc_umc_status, err_addr, retired_page;
+	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
 	struct eeprom_table_record *err_rec;
 	uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
@@ -194,10 +192,14 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 		/* UMC 6_1_2 registers */
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);
+		mc_umc_addrt0 =
+			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0_ARCT);
 	} else {
 		/* UMC 6_1_1 registers */
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
+		mc_umc_addrt0 =
+			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0);
 	}
 
 	/* skip error address process if -ENOMEM */
@@ -214,7 +216,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-		err_addr = RREG64_PCIE(smnMCA_UMC0_MCUMC_ADDRT0 + umc_reg_offset * 4);
+		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 
 		/* the lowest lsb bits should be ignored */
 		lsb = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
