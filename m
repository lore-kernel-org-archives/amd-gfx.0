Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0FC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B24F20753
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 10:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="reDRst93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B24F20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DF46EA1C;
	Wed,  8 Apr 2020 10:33:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380E86EA1C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 10:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZigx+GYoldPoWrpBh6j4bN1QSYTXv0Lu/enZPbz1DQ22YqzqBsvcKIfLI9MZxn5bZEihRc0gm6oVe2f7ReXfEj/4j+By8lSwOFiMR+6rLeu94N+pf8VAsKhq5Mzzcs/qA2xhtNOSqD36I+3Qi0aTK2KYKG0DIec+6WZJzUPsWa7gMpOW4XeXI8YynSc5r6Cov0WkcsyZjqdNdVIjqU9Hwi0wWLLitsrZGNUVDPp+LWXgk95ihg9I3jMh3s2lsjQvbAEj+DbDHYJG3fMadmja8VZCpFlFM+hQQ8JstmeHN3fC8G9CojqI0PP4zy7Bp/E1CDl3+NbtaTpBGgvx9ic6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cuKqNGuG2Kdk2vSWmN/VBU/nEXLdltaR4vJoTte3V0=;
 b=Wli6txbhFG4lxcGeSIt7P8VmaX2T9QgeD3dozP8qaQtLKYCBIPhGaeybQB6QXW5L9CQ3XfXLbbcZkDrv/EjFJoQqvct4zPmwiWMOjOdGQ0DCeoZFGn/ytRn/5SUxL56Wtd7Fff9ySsivadCl80Ff1t9xjl6Hc6Gmcc9yg6Y4509ND+TnipKOg+gySJP4eQTYwtq9KSqCio6ltcP/R0ljFZC8dJUfg5IKRxegb97YGiZhu0yUR1D3NpTP3N/Ax1BOPbJLbh8kfKRYIgXB9KX4eL1az7dP0APovhBgO2v6rPL97gzPKGyjk6ykvFg0s2JL8H+YNvAYaMFJWsnEoOHKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cuKqNGuG2Kdk2vSWmN/VBU/nEXLdltaR4vJoTte3V0=;
 b=reDRst938hUK0z8CKHYv82rJFiVUPvdqubbK7c/VZ0QzI4C+VJz+1Pog9lHw9HfV6mfPbQhKV5VJUqxNI/zwiSl3aQr2VMCoVeMGhNlH1r0w7YDaLTO2J9x6mNpLLwdXU5htvdZkUXHlEsk3zRVEBOE2+GW6ZYlDp1ZKoWwML0M=
Received: from DM5PR12CA0055.namprd12.prod.outlook.com (2603:10b6:3:103::17)
 by DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 10:33:47 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::6) by DM5PR12CA0055.outlook.office365.com
 (2603:10b6:3:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Wed, 8 Apr 2020 10:33:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 8 Apr 2020 10:33:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Apr 2020
 05:33:46 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Apr 2020
 05:33:46 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Apr 2020 05:33:45 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
Date: Wed, 8 Apr 2020 18:33:44 +0800
Message-ID: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(428003)(46966005)(8936002)(5660300002)(82740400003)(478600001)(4744005)(4326008)(8676002)(2616005)(47076004)(26005)(356004)(86362001)(7696005)(336012)(70206006)(316002)(6916009)(81156014)(2906002)(81166007)(186003)(70586007)(426003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35477665-5b81-4fa4-a6c3-08d7dba85217
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546FA2956CAC0E1330BA638BBC00@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0367A50BB1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63Jpe7BgYnfZauSNCHafsqmQ8NA+7NYwCdqSMu5k4zf5Fh9HcNTLia7ynJ2/ZRe3E/VA0BgaSVVoIAQrEaAJQXPI7l87g04C6XR3nvOt0BC6yvEmfxnF7QQ/KvNG5JPf2fXtGYPZwW7mmM37oSg+erctcNpt/ZolHAgZGMMgu2PZ20aZlvxwB5dkQcP8A423jaJH6g3WSZFs66JdEUikAt9erMoXsd3AWsIRnjATECNJG+mbBnq2tW8s6SyI/TsT8UnwN6Y6GGThSiz946J1HvwuGUkp3AkimCiXrd/KC15kLMcIW7wcIC6Ac+k+ODcrL/YcYeKVr56RlJYXfI0tmdDDL5WtsWwzk+/Ko9/rxANQHpTr+easbjUbFEJA/9lP1FTAHqHbvdqoe1whDNBNZtpDJ2xzAN6SnTF1OntJWKVmM+rL5bDH7M30AoV1Vq9jWGwZge2Pmkla2lt12d+5ly5gply5WwZ1o9+NdUr34/ARfQrimLJ3vfcbr/QxlQR3/C3npBSAw8y/gxCXYC9M7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 10:33:47.3575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35477665-5b81-4fa4-a6c3-08d7dba85217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since SQ_CONFIG will influence performance behavior, it's
unsafe to program in VF. Therefore, program of SQ_CONFIG
need to be moved to PF under siov. Skip it here in guest driver.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2d56b067..9bb89f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2575,7 +2575,8 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 
 	gfx_v9_0_init_compute_vmid(adev);
 	gfx_v9_0_init_gds_vmid(adev);
-	gfx_v9_0_init_sq_config(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfx_v9_0_init_sq_config(adev);
 }
 
 static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
