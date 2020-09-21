Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FCC4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9295B23A5D
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nbxSC2id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9295B23A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2726E079;
	Mon, 21 Sep 2020 20:55:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0FA6E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 20:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbPjV98Nfx2XL8sM8/H3pn5IKNz5OhjdqAWzaTBjXtxVKDLj6Hv0CO3HKylWKJ/0YG6Scc3TBVcJKjJDalJ/0OUQifaCtqdFOnHSnEMEIOz48uqib9qmuZNnS8wXqepCupdjDmEsznfQ5gapRXkn+8yf28mhM2APLaA49s2rfXeOLqDt/WEgfm/NPaKgNI+7cjFHv8zDzWkRl7SBp1PB8XkgNY9Gci/mqFfoXpnWSPfMM9aeMKd+KNhk2c7MyWiU00wAx1dlG5ISMjHhpD8DGeRKMfVcOmcVbcM/3tFxjpC6x9812MLY8Snanb/nUCwM8kUbDcIEyL/AHcSSf2RI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHsZC+jtHPMzU26Eh9jItGOEHW2Vr63RhoUslRu41Zk=;
 b=nMNkJ+4Ejf2PFKkFboBnwE3rOJOmb0iydOMCHcWK25UKRoSsTAgPsaxl7rwHEbx0ucTKxwGkSfhJztc4owIsfTDbLbPPMPxPJRjInlaTf5WNOb6bcFT+hDy/WdRjmdAh/u0djOC8vvWcD28ypFehRp7yRTXCydUvL8FNrMEICt3filDyIUHItYJsxkO/xox68Yivi/SM68Y47mRUuPkBSlJBcA++q40BvpTQq/KSXjjij/EKX2dSqt0QeNIRi08HBUOwJ5NqCLqrSseWSIC3C7Wjhi33I8CY75Ty+GnJTOU34LYWJIvuAbitJgEMXylJ874IJSXlel/BtZ0vqFQRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHsZC+jtHPMzU26Eh9jItGOEHW2Vr63RhoUslRu41Zk=;
 b=nbxSC2idmM7n75GuI3f2BD+ZcIZ/4ixShmdVOkVr1/+LJ1Wu14IlMqkhMR7LE3KQVIS6akEEq2/EjXsaRxLjCAhFjkvqyURVJMDsifLwuKsOJgVSuuqNc48Jw5iNsduJcAkpwecj2JNTOMl1p1F32/iX2pRzl34PR/WgMQPuzgk=
Received: from CO2PR07CA0075.namprd07.prod.outlook.com (2603:10b6:100::43) by
 SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Mon, 21 Sep 2020 20:55:00 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::7c) by CO2PR07CA0075.outlook.office365.com
 (2603:10b6:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Mon, 21 Sep 2020 20:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 20:55:00 +0000
Received: from rkhaire-dev2.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 15:54:58 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue for
 SRIOV
Date: Mon, 21 Sep 2020 16:54:40 -0400
Message-ID: <20200921205440.13113-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73af4737-8600-4c35-f2d7-08d85e709b0b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28314488BE420393E8BBB1A7873A0@SN6PR12MB2831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OV1vqd+31bbiakvnOeC82xJiBV2wf4mDgEbzpkMfAali4othvx9euoynofbCUN/8RCGhriva/jNrsqS6wyjcmAYRkUBCW2MqC2JBVeuD4r+wgPzugoQB0TKh8TgISMUoffuFM9ke/r+FTGmmYM1uEOh3438ik5e4c62iw2bFKjOI6PZMxhFF5HKk/SiM9eMZwX55iaW6kPeoMsZ+89V8A74YykwnBi5HYmTGTaOVlhp87WRv5UPPIs+0rxMS7WrIIvuD6gVliZHpIqmnDFPZFOUvg2W56mUWSXNEDjFO4UThL0bFi++lzBAge7rnq1oVY/lcwGyaLXzN3WUqkUanLBzB2wMYC5qNR30wpjD5Nl0Rdisky2YYRAZAXSMdxnGRFKGhLAiLUMFRQtBRlUZJtXgw4PpGIx/lCdnyG1Lpzz5HJesruxu6R9jRoTPThCKG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(6916009)(70206006)(36756003)(478600001)(70586007)(26005)(186003)(6666004)(86362001)(5660300002)(8936002)(8676002)(336012)(7696005)(16526019)(426003)(4326008)(2906002)(83380400001)(44832011)(2616005)(82310400003)(316002)(82740400003)(47076004)(1076003)(356005)(54906003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 20:55:00.1885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73af4737-8600-4c35-f2d7-08d85e709b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 Rong Li <Rong.Li@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Frank Min <Frank.Min@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7429f30398b9..4f611cd68940 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -51,8 +51,19 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* workaround on rev_id for sriov
+		 * guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+		 * as a consequence, the rev_id and external_rev_id are wrong.
+		 *
+		 * workaround it by using PCI revision id.
+		 */
+		return adev->pdev->revision;
+	}
 
+	tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
