Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6396C2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D26F208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0bbUtDTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE5689EBB;
	Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B7389EA3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5EIUoBRi49SKSQstz3Vbf9968xLUbXPElcCEvrgkCGmCiiGSa8a2K7ItiK1WgYPPprQ7VcLfplQtiuQnr/azQcHRjqh5E7GvtvxHvXmdTtgcGN17hBKyMeoLVHu0S2mf+f1ZAoIVqkE5MqAE3wnA8xycCSLXim9f6OyJDrVh0KLUZCo4Qmb5eiOxC6/6qU9bEwh1IQ1Hr+t+rxd7964p7ns6n1thSomy9B1is8ykqTSJaSZRsdHRKhS9fuy3pq9oh0Xbp5QAQDfe7IEkmf+z/adZPQ3D39iaMIqMMgKBOppEiUB3sIbBFLSdrW94SXcea4qtQl6MkyvlmFY18Vhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0siJe/9B6kFHiXZgPGCgiXan2r1IoaKE/FmcgC2QU0U=;
 b=Lpyivl+sQXn+iRCxSG005GW+/voP8BrNobJ0V/n/fH/6ohvcZfG3sqClzPJzoEvWNKAOmF9ejqMaYPnNgkBtmZr/nh0RVSvxEZPFFSEC6275nic3Q7LI7Tsu48ktdba+DFhFwoq/nK1zpFN5KiBI9RY/8ExqeMv5cBSGrgaPGxJn0yYQFwP0/wXG7lV76Qu2yJ0eNRTEe4kuS9HYKPAaD8XmwuWyALaGwqqN2l9yecwkGVjHvTP00aRwYzBGse48jF7+fXUNSlXcEUr84AZmfj7hwqJX+EcmRvlMeUO+CCoKzmAEC5o88Ee0XyjVsel8zQx31TADmvEJuer8agfdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0siJe/9B6kFHiXZgPGCgiXan2r1IoaKE/FmcgC2QU0U=;
 b=0bbUtDTKz6vx3UrD0svzR9u3UU3uAvAyTA44r4bkDpfAx19OxzuObyKU090D+IN7p0nqtDYS/L/8B/JRmrx/ExChE50LKy15xuNnlN+i2hwc9+8/W07i45+zn4u9H6jayaX/qaUTlP41R35M1iRx3CgxUvP+n5XRzeRqNZ1v4+U=
Received: from MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 07:01:59 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::c6) by MN2PR16CA0050.outlook.office365.com
 (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:58 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:58 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:57 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: for nv12 always need smu ip
Date: Thu, 23 Apr 2020 15:01:46 +0800
Message-ID: <1587625306-20704-8-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(428003)(46966005)(26005)(70206006)(82740400003)(356005)(8936002)(4326008)(2616005)(81166007)(81156014)(6916009)(86362001)(8676002)(70586007)(478600001)(7696005)(186003)(47076004)(82310400002)(2906002)(426003)(316002)(4744005)(6666004)(5660300002)(36756003)(336012);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3634050b-143e-471c-4151-08d7e75437a4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2371:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2371ADF92C1AF74D6EA754C784D30@BL0PR12MB2371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F94yuMq5yT2mFErh6IrCmDFGxBCQj7UMADyVrU6FCrRrlK33izHij/kOBPs3i6PBvWTbiW49QSCl1rHJq+7aG85VAgqON44udEx6fIN8tyH9P+pTqN3IZFH0w8xdVHzvaJjadG9j1PcPFW0tpspJNpngdIXLkxkRSNnQGzXrnbGTOt5+BzHeyjrfeK+bzNcgCAEx6S8lPtNtS9RvJqSzvoUQRBi8zRC9zdhD3GydPnr7FGTxxxT9uap9E3zi4HIKfCzCi1u6KLoY9e+sLPQCD7TfeqqaYz1D+fP692BNg2cGoTwsdZp+lTyu3nss/RqYbGeQ1XTFXWjmpAhEZrrAJCy5xsQ+no0vxRPWvFrGYd1NVuVZudkdjO3DpYzQ8kqo3E2llsDDBb66jhHmsmmSUTA39dwpas58g7xK8NqY0QTMysbkgTUreuah6bpnZuCIqSq5fLVj7CjguodelNSEm2r/qPjKvgcD2qZhKv12R+4jSL5GkE/hRt3dMq5F7jwsisXpub4GTfhfZ5PjBzGm6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:59.2555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634050b-143e-471c-4151-08d7e75437a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

because nv12 SRIOV support one vf mode

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 995bdec..9c42316 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -498,8 +498,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    !amdgpu_sriov_vf(adev))
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
