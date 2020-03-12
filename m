Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DDC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 02:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D0920735
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 02:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ssvk19zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D0920735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E996EA13;
	Thu, 12 Mar 2020 02:55:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2386EA13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 02:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5xDYl2+G1+FMwtwd5N9fBL/jv95INigwfQoSSnce/kUFebmo83Pqpb8gJBqE5kb1agYWi5kXk7jHwAfua98MZwAbL3CXIqJ2ef7h23TuDqGiiY+7+90/Q1rNLPoMWoYshb1cMxyCx6HULe3aYzSwEe4APSZhA+tEcXOuJH0aYR7QhdpEwx+RXtUPBUPXGE8n4gHcN9mLF6EoWg+rMawIIWTw0Y3I8ge5NsQEq3x5T73uAsM7msa07hNWX30v6FE+Mp1k/wDxncCEzDbgj9vw1JZ4w0lJUw3wyk/xgL4vooFtmXa1cPyHK3S/si/v9LicDbrJBASQGpd6RsdRhuxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4d96PLlzbtgVAepDJsay4Hi6cYfiaDf3eqwTh0FhlM=;
 b=KE+InYTpnQ3Lf1llQo/7bnJccILxsafUaehZSAJl0ub+B9Lo5p6E3hsQGhxqtwZ55Hw+NWwROxJGcmo8op3uLB6pgOrhXVVSK1JBqn5toJpssM80XdtWXqeQvxj4uMZL7PcG/IeSLYQKs0b9zhYlpPW55t5E888DMocvYv8qyfh+n18EoxbGDhjtU2YYqo4SuOqWFn48tsphfnLLK2gshUV8AoAWIr3f5yrWqgPps9n5rmlfgcg0Gr1O1yUg4VwxCKu+HmkpYz+lC970KiFMHnmeR5jzAE3HZmcEonS/ZApxu/8VxMzBEUoEDW1TArsP+2UmXlYe+34oqNObST/IzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4d96PLlzbtgVAepDJsay4Hi6cYfiaDf3eqwTh0FhlM=;
 b=Ssvk19znKFGYWqK47iVDDzdq+jaQE69+y+GouLz6ylVVls0Sebgsji2UDpQ6QC79ObFvFNjwqyv+b4c3kdysB8tdLzn5f8xqD57t3zITMEWxYk1NBaEN1CuNRFPtsdqP2p78c34c/Q4OFmOkA94TohFqiUIl/YRMnUtzjYnzQqs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1941.namprd12.prod.outlook.com (2603:10b6:903:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 02:55:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 02:55:25 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 2/2] drm/amdgpu: remove mem ecc check for vega20 and arcturus
Date: Thu, 12 Mar 2020 10:54:47 +0800
Message-Id: <20200312025447.21000-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312025447.21000-1-guchun.chen@amd.com>
References: <20200312025447.21000-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 12 Mar 2020 02:55:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cecf843-61f5-41b9-83c7-08d7c630d008
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:|CY4PR12MB1941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB194151724C12A4AA9A0A33FEF1FD0@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(7696005)(5660300002)(1076003)(52116002)(8936002)(81156014)(81166006)(86362001)(478600001)(66556008)(8676002)(66476007)(44832011)(66946007)(2906002)(36756003)(316002)(4326008)(6666004)(2616005)(186003)(6486002)(26005)(6636002)(16526019)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1941;
 H:CY4PR12MB1287.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaLs2lzCkOhzh4qEBSmIyxdzf9hT55fJoek0QZYwlXwWQshR8Ms2AIDaUe1ijf3IXER4rGotQXL0bCiCWvzSjVMZLuTHHp+2i4snUDg1XP+QLtHl7DH6t+V5dqRBeZLpWEatLGtlvbV4ikSVDCSspA9EVkPzBg/LCg/NvhEaEkPInIl52CrLEZINPgVFNAHE9oiEqGeL0gjqc5P7b0Cfvss+m0ZGUK1STifrrCH1mEeylhiyVYGnEtADb/vUhe2Gpcg00Db7lT44u4z8nV+36Zz/ep4HoXTKcNIrPozr02I6Bos88mZ28Fla0K6pfpo17MpL6cYJPpWLkDPWApkQ2kNgpiRld5XMaavGOKlk6Ed2Pa2dAuA8+u0H3695st5zFw14lvLQ7UowRMiSrvgwbJ5sUpdg/TGq7qRF8CPifSlL/s74Y2cKI8+e2uEiRA8x
X-MS-Exchange-AntiSpam-MessageData: O4TYT31jhcwIQykf3goj3dHLjk4mBxE6iCQYY8kkPKV21CiONk3z9b0wPOK7bgZj5FFDdurEK647IMQRhUXWSaUYBaG6P7hjeBxEoxtg6GbPqnHhBII0BHYyOK9wrt8FCxdt5guMvtdurI1RP7HHcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cecf843-61f5-41b9-83c7-08d7c630d008
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 02:55:25.1521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91tfg3cG6ik4ClLtYYtGhLkeW5VCir1aEFqli7zuYAGUkHZfuy5y7E7q7+wiidtOxD/HRlmn8GG6sccgQmcBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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

Memory ecc check including HBM and SRAM has been done
in ras init function for vega20 and arcturus. So remove
it from gmc module, only keep this check for vega10.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..9bde66a6b432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -887,28 +887,20 @@ static int gmc_v9_0_late_init(void *handle)
 		return r;
 	/* Check if ecc is available */
 	if (!amdgpu_sriov_vf(adev)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA10:
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
+		if (adev->asic_type == CHIP_VEGA10) {
 			r = amdgpu_atomfirmware_mem_ecc_supported(adev);
 			if (!r) {
 				DRM_INFO("ECC is not present.\n");
 				if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 					adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-			} else {
+			} else
 				DRM_INFO("ECC is active.\n");
-			}
 
 			r = amdgpu_atomfirmware_sram_ecc_supported(adev);
 			if (!r) {
 				DRM_INFO("SRAM ECC is not present.\n");
-			} else {
+			} else
 				DRM_INFO("SRAM ECC is active.\n");
-			}
-			break;
-		default:
-			break;
 		}
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
