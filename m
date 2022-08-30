Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C3ECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C1110E38E;
	Tue, 30 Aug 2022 18:40:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2F989C83
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLrw1qAyuyvjvPJw5ImBy1Gvh66gOyKfN7n+wa3F4DJKfBnNvq0kXMMTzRF8s1izyYctkyufgGcGl8Je5YMkZolr1uwmSMAUzXdx3TC4BMfS7gRL3E7sda7y1bjNR3r+Lvb44dkZl9/Ou267TVTapHTbC12b3s24/s8aVasyCnwB257tBkQNH95r+hBFY/UHFG9bYWip/bsZlRkinKvADMD6X/BlP5yhCtjILTJmtgk56TfoJNjfsH13rFBM1IxcMIAr+leRkWOi7/dXepOaztvr6FpbYm01eQ/zNKSo0sWhj2u1ZVmYtpNCFjHj1WYNHlckUeALE87xMqoFo+mdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sh0C+1U+XDH5N3BCUxXQIZ34lUzWpzU0zs0fWdrq1U=;
 b=GtAUG1GK/IjDJWzofSLCgWsem1asAm7QYvLdJ2AjeffYb6Cx8iaucEnZt48R5iLwnknlx0iFh1HS7EivSMdnkDWV7LQf1n7c9coqC4fSWr+euH6Gqwo0d3Vhl/pJnP2GFNjfFNS1cwYq/hVvuq61R0nEWx01TRQj6LBBCaSXFwKSDNOgHRfpSUo+dq2tfoU1kfNQfNhqrGa+g/wPgc1RzGnTHAb750XhFPbK6LyVbbiVD9KP745suUtLVxFCWiXoI+8E8YN0E1yNfoTlRqKwUK2CT+roTTVZdO3LKCxQ8/+7GQbk+lRRHSTBHlRLT5+rWptEmRWQgmypR7A7c2tO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sh0C+1U+XDH5N3BCUxXQIZ34lUzWpzU0zs0fWdrq1U=;
 b=oKKS9PL62Iu54nWZwUad0GM8OtMQ7yT9KLCuRTKQRELSJUa3i/3gpeQjd8YAiNCIbepCEyegAWDbYIhOIllUu843nEvZ2hhob2oGQEEYm1iFoK/UcqAMVF1aj8z4LgwImmdhmnaOdbBsqXOJpkEQA5ce0hq4TUGhnKqrpDESH1o=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:35 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::cf) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amdgpu: skip "Issue additional private vm
 invalidation to MMHUB" on SRIOV
Date: Tue, 30 Aug 2022 14:40:03 -0400
Message-ID: <20220830184012.1825313-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56c0f39-0cc8-4b3c-0747-08da8ab72093
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F6HoAuPHwZMfHGNuUQ2UC+1IGvlTBFf7/AfE6XJphp87ObS/VsTMuYLShjS5kxcaOw4VG4B3YHmJyR03fzlQQgf+4JqwlCnE/MePg94Yy9VsGTwwuqUX83qFWV/gCBby+EjFhOBRlBScBVXiH1TfvHHJ47WbAae/+Fd/tJjmvBMSFin+Dkxhi6FMxs7YkjHONXMbGBEpAPcU1JrPPZdq+AxPiv0uJBVVzOcJfbcPTKl+rikocnVy+LJ0BbN6bfSaGwaSxioAN4sJMeB2NxHvQBxEVuybKyp2i6EpHoSUvX2+5hwfO52ihgMWi3K5e1HpKyOA3QS4TBTm+np2B2KtRuLv+slC4hcZDc/SzzATOj4Ji8cptACVRdYJB0yVDkgWr0N2EgJ6PJ8ewGcE1VOJoU7mhOl+wiZRzHC41UNy8y+jwU/UFadrwn5ZQgUjg4xy4KSSbf1cSFhDKOK8QDMFVKMzMKiPGUzTWmnfnt6fs6BCyE9Za/Xt/lVmS0dBzad0TUd1XaKbJnJZS6+dmWL92tY0fvLGtu6taKfrbFRXD6ehAfjFsYn9Mdpqb7gOv1Dqgm9N5z7eGkNPPC3mXVN8Lot3wf+n0h3Gir+ov5Q1ycKcdBGsa/OXeMP5NOTXAUpApGa55qTWokjsFHsxgVa79ZViNaMXBT3TwA7YJEqhs54/Bv3x3tegpPhbHaADvCXb1FFZf4RCHtmormXVZmHuDho6E1ghhNME2gdKmbfQgyzC/XVpUew1ZmpfALN7L6/eNnLUnkOS2hSnuVNSIv7mGSgRbPqs1C2hEKMSltCA9CmxxmKHZddKWPMlYU/WAYY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(40480700001)(82310400005)(7696005)(2906002)(6666004)(2616005)(82740400003)(336012)(83380400001)(186003)(26005)(36860700001)(47076005)(426003)(16526019)(4326008)(8676002)(86362001)(70206006)(40460700003)(70586007)(1076003)(54906003)(81166007)(6916009)(478600001)(8936002)(316002)(41300700001)(356005)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:35.4313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56c0f39-0cc8-4b3c-0747-08da8ab72093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Horace Chen <horace.chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
vm_l2_bank_select_reserved_cid2 is a PF_only register
that cannot be programmed by VF. This feature is only
support HDP using GPUVM page tables to access FB memory
which should be disabled on SRIOV.

[How]
Disable the feature on VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 497f52283a30..592729cb0f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -234,7 +234,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	/* Issue additional private vm invalidation to MMHUB */
 	if ((vmhub != AMDGPU_GFXHUB_0) &&
-	    (hub->vm_l2_bank_select_reserved_cid2)) {
+	    (hub->vm_l2_bank_select_reserved_cid2) &&
+		!amdgpu_sriov_vf(adev)) {
 		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
 		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
 		inv_req |= (1 << 25);
-- 
2.37.1

