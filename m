Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D5C10F26
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C4920678
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 07:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQFN3QDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C4920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E368E6E9DD;
	Thu,  2 Apr 2020 07:20:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2ED86E9E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 07:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gisln4Oo4LLF4T3MldLClAh2/fml0FqRRrEP9QgO93rYEBiuVoA4r3YOZNmyGevp0I0xx3zjr2F5SxrCGtMtTqc/UR8iDWXvfTkC793B5/qamEPMEkHPJCYDFLkI+S3n32V0t/mwUHDkgULma256AaDM2NVVhYar/FAy1vDv66XGFsOkjRrdGWtmy+1lJfPOhy9IIJ9reXRR4Vf5ac+YlTxLpftaUwQX+3TJFSbvmbaeoab4QQWoIDTE+WeWFmNptqtxFZTjcRdqNMUnt4OVrInjTLS8XOuNk8h6NKMgzSpXp2rIpu5PXas6M1wbCKatVagWQf4FU2XvN5q2wNMVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mmRxSBUi3VEp0iYED9+2csPJkb2K6PIOirw4FFDFA=;
 b=Iebhp7XyNNVSmR5pKafatNWRLekYTd0nf7bilg1ZubmHshbzMwCMc3jtuoDwmAPnJJ9w5n43IKLDMzee4Ak6NsgUB+Ruw8/pkyGRqN5AgZTGLySRzI0FNaMyv3KDdlSJB0g+bas/pYQl/yqKGlcQjPUDz+X3ZR9NmCwuKsm+MscTsG/W69w3duSLLtI26dJke59Uom6pyK3VbXbSyfyd4u8/XSpCRJmmcHdbuAj3DGMSq6PS5EOjvbeNCocdpIjuc7aw9nIEW01btWRnC9/+D+//mFIIfQF8onbpZCjS/2F2imQCRDb7ifeTmJPoQT73dznBzSLAH6/ez4NzQX07Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mmRxSBUi3VEp0iYED9+2csPJkb2K6PIOirw4FFDFA=;
 b=XQFN3QDsT7W+FnpU23ofF1V4wQTGpMYN0eqVVJwz87NUPlaUs9+nRnTLSs15XdsDgfF/pHY1m/z7piBVzaeGLDeblCOnU8zd5ic5qA51GfUDq57SZHhtsx4dJ6j2y8uj+OuKbLM7n1JOsVf0x+/aLiRBoMVr4VXMlOaAdbptnxY=
Received: from DM5PR21CA0005.namprd21.prod.outlook.com (2603:10b6:3:ac::15) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 07:20:11 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::31) by DM5PR21CA0005.outlook.office365.com
 (2603:10b6:3:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.0 via Frontend
 Transport; Thu, 2 Apr 2020 07:20:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 07:20:10 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 02:20:10 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Apr 2020 02:20:09 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Date: Thu, 2 Apr 2020 15:20:06 +0800
Message-ID: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(46966005)(8676002)(36756003)(70586007)(336012)(356004)(70206006)(2616005)(81166006)(8936002)(81156014)(426003)(6666004)(316002)(4744005)(5660300002)(47076004)(7696005)(82740400003)(478600001)(4326008)(86362001)(2906002)(26005)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91d82e5-e874-4615-3746-08d7d6d6479b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4319:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43193C3CA614899D7037484BBBC60@MN2PR12MB4319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 0361212EA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcqIQL9O5c+O6pT1JrESxx/rOT6rzFd/LRCoYojIMnE9vn437RUQTy7gWysUtQq8CvokVH70rBUk3ZzDBHHyaDz4RyyP6qVI0KVCx1Tv7xmB8hzdV8CJ5ZLl6CBul7WXBtRfDUM3UJquLBbfwFzRea/B1wHe4U40wC1Fj5OWSt4aEyNBPi1s+0AhtkWSydSaARVV0NNuJ78BRJnu6ceSF7HkN8oPtZ7G+kWX4tXiE/1VeEIwsc5PFXPE+VjfT3etxawPJK3HTg0cRduCitc8i+9VBbdNiZcNjc3Ob/5+A0SfRqtQ1eVizVyi0S6Kub+ZHmm13I4FiDUE5SEmO7G00YbXMM1GjrbHpyMLTRkouT1nYoaPfkAg8MMLxrQaHz6Ygzvg2rOtnJ5rFeFIb9V+X2IIN/kxxiX3Ba24FzoT7Td18eyXwHI/CWekdXnZDDHtX29BF113HJbxP4vLvqm806k6FCDulfjBEGppmRkKDIgsJXz3cXwDVN9BtCzMJwNTIC3lPkcGKkaGMLuLQ/U7Ew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 07:20:10.8025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91d82e5-e874-4615-3746-08d7d6d6479b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those allocated
memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17..832daf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3847,6 +3847,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 {
 	int r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
