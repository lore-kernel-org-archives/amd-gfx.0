Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1566C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80763613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80763613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A5D6EE24;
	Fri, 14 May 2021 07:27:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BF36EE1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljNBVh84DUo29t9v+fy9BxRTYiVIUllkwAzYUkSkFrAY/OHBpCK6O20+WuyjflqaPjuRzYa9WRi31Sf5QcAnd4fDeLTVIbGfwn9aVId62wz1Y2QQSTXa3gMJE/4e5YWDlgIP44alstjck3stB7f5M+PcRqY3I0FlwErWHiez40G1ZpBlyd7+of0TKXaMJ48nUIchgeArsUlSoAUPP4D29Cbq9+1gjtln+xb42pPC3EKId9Nf/sAMdDqMhlqEqEsJxMwI465U7gBt81gvKb4pxfeOEyxc6t5SuNQwTHwJYZ35Y6aLKIPU3gSWF3RqVx+RfqjudKEKG6a7tJe4kl0+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=O7ZCJY+kdkBvyDic+4EgYcNNpypnDrsiRR7PRB1jQSjpMhW3iAC92x9POtN3ZC6/Vu3dNdJ5k3DtnBvKl7oNYVERpQggV46Er3mpZzkPe14KDIddh9y5k2YZqH45SO+b7Mcu6Ym4nPZcB3eQPKgLAkak6YN/RC4oi/IYOUlMqPocBUFRcnuth/gcDXw1wiU1uOVe1/2i0UIvJAJ3tri5FvD84jUBf8sr+5Teuy9/oDPp7LzvCqjF/QnlNlWjlSkeq1gE+hdkfr9mBT4/680FKOlssxcviOv+FendT41ZLxMfoQ+aFufE8p282aPdTSKbiuE45C/JPDWN4uagWaKlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=glV+gz7wFkYYqJ45RZKU9Efj358naz1LfAuLUgn1u0C+5RxbmRnW+kLNJ5+df7BsF7JhQ6eTL1tAka1NFCGO2NtEQg7alYIrB2Z6y3UJ75nFlIfsTzcVQjtde9XekM+uSRHERcrL8YeAs5QLkfPkrJ4Wx0jQIrwf5fD9SDqNIWw=
Received: from DM5PR1101CA0006.namprd11.prod.outlook.com (2603:10b6:4:4c::16)
 by SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 07:27:25 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::4b) by DM5PR1101CA0006.outlook.office365.com
 (2603:10b6:4:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:23 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:22 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 09/16] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file nv.c
Date: Fri, 14 May 2021 15:26:59 +0800
Message-ID: <20210514072706.4264-9-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9282ef2-5a03-40a7-4ddc-08d916a9b862
X-MS-TrafficTypeDiagnostic: SN1PR12MB2495:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2495F5B8C65D220669391698F8509@SN1PR12MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiuXsrbRbmCaksGuS3C906XYYVN4BEcSD9OklaA0zQUCWdAwJAebG4WaprigVudy+KmjWgUFnf1MmhFBUaYVnsxqjSu+tSu4pqgTLX9opySx0tZTjmwOqTMnRTbl+ds2ZDGBo6F7ROdUAgMYcrIBNNkGRhBaSybl/ECE83V4nmW3Adr3byW6FJjkq1b8lQJVqJf/IyzlA9tVkXOcacH5ol4+ImHSh/zzIfWeDROf+bYk+5iBrvlFDSllmA/KT7Yism91gSoSZ1WDFxJli8giw4yX5C+SSXxE5UWSJStnRKlFt1n4PU9OO1/ze/YO/eQzBSuI31m3qyzd1gmjnexx7/gcBvjnaY4ObdquimbfqJJ05uj4YMZxHOLRtO26ov62RpRV28yux0obyonOewkyMPwg2WG/0WKS0fRzAKt8R8EPKCXsWlC3sZ1NglaG14XbRqYh+r5/ALdtcLUAEyVDOb4pXIOF8hlHdfoBgyF4iNvLuIhKX6a6s/WVMBfo4Li+VNe3NYH5JnvSgWRLoPOkHkM1lRA3TfdLUdLLB8c3VvMkOXCGLdI3xtw4CkuUknnAu25qmVIFfsIKJuhlmtx1/pm7In0JaJj7TanJRRPHWZKiyTPc++6C12jH/l0fnQH+mmI8OAC1eLWPzjb39y/0d6q3CFnrnv5O2Knl9oRMn27bAL8iwfqtxqMF/DShIaWr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(36860700001)(36756003)(8936002)(356005)(47076005)(70206006)(5660300002)(4326008)(86362001)(83380400001)(70586007)(426003)(2616005)(81166007)(4744005)(8676002)(6666004)(336012)(82310400003)(26005)(478600001)(7696005)(1076003)(6916009)(82740400003)(2906002)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:24.7310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9282ef2-5a03-40a7-4ddc-08d916a9b862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2495
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..f2f0caf560f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
