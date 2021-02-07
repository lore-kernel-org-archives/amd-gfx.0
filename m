Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEDC433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 01:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F7164E87
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 01:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F7164E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096246E506;
	Sun,  7 Feb 2021 01:53:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2176E217
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 01:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVwj8aBDzUDO7AMWyEtE8KaOtnV7/gHdF/+wpXl3+F9cOwspgHnaj8G7DrvCHY/X8c8gCWs45Im+FBP2svMBzH/Udw6Xc/1M8pLLpGDuiT2fifvU28ZeWOF4StvChh086So3ee+F8QHDhOcqtqux68qnd0G0ypLKhMqMRGZ69+1w7mJAAkP6+DAsJNn5eVRZU35h0Qj/eWHQS2YP42XkRq73waYI/yb6sxNAWRg+Id7iPtRdSsGt/syTTjy+0LRUb+CYOIHnDExdgzDWCiz5kavr74QewO8F8M/4Uix5GorcWFe6Wt9choSr3e0fOku1mimfiMyHYbmv11ohSrOS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFt9P4M0hQ3xIjl0Ed5vRQHsh2M1wdXW9y88Gl1meHY=;
 b=JwOu4vV5Jfp1gX97xJTX8Vnkol8BpDFcDE+xzPmGJfhdveZ2K0IVj1eg31zO0yAwOgY+urx6HPjNgyW1ZI2dxwYjJRgg/Nf9Na9xuEprYHdBUGrv2wlB9zGypMOa7ShIDZfMO8BdzxTUvad5qH/BvmkPoZqgraBM/a0jk+uzEqiX8atZN+Gph/muJAy8zOqytjwzhZ1bz2FWQtbtAaxwRWG9Mq/eTijkUuBzYhhe9qpHsboBfsC5HRL3YdLP3Oj8dDq3WXsSNAwdTnQ5oDbExOTET0NudP2SL0/Pn8YeY+5s+Ouu2TidTjxYNbf1+ns9onCB7L0TKMZHul/BFkSxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFt9P4M0hQ3xIjl0Ed5vRQHsh2M1wdXW9y88Gl1meHY=;
 b=s7ZMFLZsOpHgoG49xChnWCyvv2Rs5+USnAxQTqcM+p0SwtMqhCd9acOWdxMo03MagbAtU4yY1+TODoDtWkwhRrbyYXRXbl5CtSwZbHVv0FPhGuwTpByq4qv+cLFdOXY+QXDkGVCqrF8kV+h4jCYJuvD64wUY7xFOr4b2vk5qd4o=
Received: from BN8PR15CA0064.namprd15.prod.outlook.com (2603:10b6:408:80::41)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Sun, 7 Feb
 2021 01:53:50 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::c4) by BN8PR15CA0064.outlook.office365.com
 (2603:10b6:408:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Sun, 7 Feb 2021 01:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Sun, 7 Feb 2021 01:53:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 6 Feb 2021
 19:53:48 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 6 Feb 2021 19:53:47 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable LCLK DS
Date: Sun, 7 Feb 2021 09:53:44 +0800
Message-ID: <20210207015344.21442-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82b50b1-0057-498d-4cee-08d8cb0b3677
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484874BA610045282E9448D8EB09@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whvx+zPYOmo4DzEl2Ku1R0BtzXD35XzPWiu2K0cE18OlL10rOD1P28g6U/yO7hRDmYNhCR5frEeBqNNspoyVuaEeJ7oWvZYbQ2mi5y4RCpriaLIlZPxfRX5rKMGZOCUtLnAOyeNGLLg8hK7YDAOQ/ECsxvRA88sifeuvGxJuL3C7nF64ThLWarFSXqvsHfpqpTiKgVpVbX5Q8z6VPFKyEHBLNZteN86IbubkAN+yvF9qwndiOrKC/kHff/L56EPPWbzwd2odTvcV+WM1BBw/LqdJ2x2NHEj9yl1udY/Qc5r+ZgJ8NsUZN3iq9r1fbDevSwX9vU3jXJ4jwq5TkpQkyzNqiFxXy43W3w2ACorJQVuLBe1778xP4Q/h7DM/SBNdH0HtFihBtkg2n0zvgTpeAYwwgESHNo2AliMgtF//ejDg0m3F24PTy+fRIOC79b91ziqoMF4fPru6k1e9eOfDKAAXOoQ68ZLQ61dDKkDEIcck8mq7gDgRfsnbrsgH4sGQV1KwofW172C1Nm+1Gp9qWH2rcC7dKzoiIhXpett8zK8N58Mp6WTergrOyfwLENz0g/K7Acz+lrN2PWCzkzB0zcEbD365HIHgkda1DqQS6taEOnGOOipITpTHrJxdFbaR4DLRL0su9JZtnz45hKRVE2Tja9tbcnFBLTi4gjrCaftvTLwmQrI/PRb7TXjDOX9L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(70206006)(81166007)(478600001)(70586007)(356005)(47076005)(82310400003)(6916009)(316002)(8936002)(4744005)(8676002)(1076003)(4326008)(44832011)(36860700001)(86362001)(5660300002)(26005)(6666004)(2616005)(7696005)(36756003)(426003)(2906002)(82740400003)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 01:53:49.1352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82b50b1-0057-498d-4cee-08d8cb0b3677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable LCLK deep sleep and it works if we enable ASPM:
modprobe amdgpu aspm=1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b9e47f3b0231..d208a434c7cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -242,6 +242,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_UCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
