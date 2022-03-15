Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A4AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 02:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7084B10E39B;
	Tue, 15 Mar 2022 02:33:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0988D10E421
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 02:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRU4n28AsxkwCQvRLraSt6Z2z6mo4/G+WALciIhaMYbGonnS3BTF4jCYTu1ZqSrp6FCAv8f+/OJXlTJJhZPdcRB3r2fn1XYpIBV3XP2pbLKuctZqvc6k8wkSkeCvk6VIHWvYOvCP+V1hEeR8SEEID/GS/UyzUfU68O+TJ7z+QHri3m2kjn1Qr3D0+cX50Gd7TGLGrFbUEogDX7Au4VyE/+Q/GQ5jyib6MjyHgBRBgyRrWWxUDvBi0U59lHt0g1L4xeAWOEr0KP19xqUAXjj/jFxmkgCD/ZVALOLMY/WgVJJhTHbJ3uKKBlSQUMa4e6U3fhFHkjgziEh91mjuCFM2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFQ4E9IQqAsKvSXBatWWOCiTg4tibF2U1aajTEnU5i4=;
 b=CR2dgN5+Lpt5ElJivLa0lzWL3/QeslCLtn0pbedXHP6zsUO4hFznFT6XJdaU//HaJgOzhr4VxMtYQEktoIbHKjR49skdz1M7eUlgGjH5Q16XgSeGwMXs+lpHkwlj8ogIS98WbfoH++CFAEqWLq7OgSg7mt9xuzLOLbHJGssSOaA+IFfN2/McTyVJWITRe1wvhBXPtjeicqq3q0IQn3Ng+/dNX/6yHWM91ozzlzZUzh/5TA8us07sPdnBOx76RnjbCC+U1Ks9RzpdDKCR2TiTy/m3smJJzGkCaYgG56GWKK+Ciu17RPkAnuF/7LJr5MTQEsEg05MW3CLFlCWEXFg9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFQ4E9IQqAsKvSXBatWWOCiTg4tibF2U1aajTEnU5i4=;
 b=wZ4jQOhhOKhr7gAUDcWAt3anUeYu1i/uvVwAgiD04oZS72Fllh0nSp/QxKSlKC4oPC/6fsBAPgsh5mDxpGk7bCt///kYtfbsIws/Ph4qi8QSL7MzpbApngm48jpuuBy7WrWAIgVUtqwtXqCqf4RBphUMF8mKoQlxp/HxOENBM1w=
Received: from MWHPR22CA0038.namprd22.prod.outlook.com (2603:10b6:300:69::24)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 02:33:23 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::dc) by MWHPR22CA0038.outlook.office365.com
 (2603:10b6:300:69::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Tue, 15 Mar 2022 02:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 02:33:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 21:33:22 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 14 Mar 2022 21:33:20 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reload test
Date: Tue, 15 Mar 2022 10:33:15 +0800
Message-ID: <20220315023315.436797-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9872ecf-be4b-4ff3-dc94-08da062c2ced
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50889D6D469F62FFB1DAFC5895109@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IxHAJtDOXMBmjK4pyFGG7X32Kh9Zkzag0v8wyYEXZTvV94zRyU2OS4G2aNZr7nRP77BSxyrVi89ak7yytaXHQ08SZBEC5c6K3hLeE4oJ6EY5Hw6wi2j5O5c8Y2FaJHcQ54CdFtXUvlZdcOBNvqH0Qi8hGK9ECo/6g1ADqXLGd3ZdX9Dhgfx0NKLMVkF0CQpYdceIQjFBl/ZTVa0R4i4XnGcIj7qlQqU562tp8dQf53JvQyQlzuboIq1rSP5hSm0g5/U7t0SbYfWTk/hTf+xFDScijyu3A5t8fKmg/jLj85N1dZPiQoxVnXLCwyLPCNXBUC65wmPwdLHaTlUfsP6WUvRWWbF5IZLkf+zsKtBRtGCYKCTkEu2cWDVumrw3sgEVIN2Pkc/++TtPh3OVpqG7W9lApt8LCvPPnrrnVxnkLJogYdCeHJg9bIR2ff3dxpt+z1fkt63K6k6qawohi2wU90NJxKDz8MVWuf0GqdKSUpU0EwNs3SBDrJ+kmghLcXF7oIDL46RNuWVGMujh3GIw9OaSQgTUD0l3XSrbVdHHAZqnM+7tBnUx++lC8/5emHqJf9FriBT6S4lgLeOmrxqSg7aZFnnPD8z4DP9w3TOuBJC7+wNp2eOUWqXUdkFqzWLigwDtI7U1UzYNq4ndpFyjVaYJoScs25Utx11tsIzCN5BRDb1EvCMVIMXh1aHMVIXlL3pbGR5A9AHNDc2InYRdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(316002)(2906002)(86362001)(36860700001)(40460700003)(47076005)(4326008)(8676002)(1076003)(70206006)(508600001)(7696005)(6666004)(8936002)(2616005)(356005)(6916009)(54906003)(336012)(44832011)(426003)(36756003)(26005)(5660300002)(186003)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 02:33:22.6585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9872ecf-be4b-4ff3-dc94-08da062c2ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhu James <james.zhu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
On Renoir, vcn ring test failed on the second time insmod in the reload
test. After invetigation, it proves that vcn only can disable dpg under
dpg unpause mode (dpg unpause mode is default for dec only, dpg pause
mode is for dec/enc).

[how]
unpause dpg in dpg stopping procedure.

Change-Id: If6ec3af694e1d6b63ebce386a563f03ca6d291c1
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 319ac8ea434b..6e0972cd1f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1098,8 +1098,10 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 
 static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
 {
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
+	vcn_v2_0_pause_dpg_mode(adev, 0, &state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.25.1

