Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0070AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA446611BF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA446611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4CA6E954;
	Tue, 18 May 2021 14:16:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BB06E954
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 14:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiNdo16Oq1XGMMmS4YSS2wOCMXsEhW/htzeaxdIZtzzB8k9RJhb38/TVVp75DgFnAD3SwUz4yEgwY0uUzlrnBp/pweXtNOlWE6q2iAG9XO9c+FmB6ujE84hbZhdUFmM52UN+SLncY3T7VHC+lUYIagKxMUY3d76OI7Gt+lcw6bbeerK3B4alOCbolp79Ac71hqEPbwMEm2ovgoLLnn9mjJ4gMAyKVA/piylu71FtiaZrjUmL702I6oyeGp/cRc7FwaF+m9N04TCLk13QxC8PqxGdJZS0+oRvYwDKMV1QUvEow7r/fMKppAlv4abvX4ZkcG12RR3ARI7cwTWKS3REug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42aJxRRrgarzxKWeD//hhQ+5eK39qnbRtFCnvr4oNwY=;
 b=XqEbzZFLzVZZwGE+A/L+Q5038+wYvM2mSQXHq72zfZhVWPjZizkt2AQWQs1CguA7a7gRHhq5irRJzT2+nN6lyPuELeevKQyg64nsVy7Oox6RvdzuDyfdtUiLuO9/ll9dz+Bm8LX7dl6zYxDJgOx/aiXykENXhFbjKPZzSach3/m0zAMnmdj3jK3APVmOwtk3pliUMuYBIMoeIut28aVcJbx8nlebQPprzbRan87T92cC0jCC5zkKKHr2+204Zx/mx5tNV4PikFAdZjRvNILig9gBvSNbaooc8GCParPPCQOp/lphLWviE49Tc0ETe3JOIvEqtCWEM0eip9DEVShbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42aJxRRrgarzxKWeD//hhQ+5eK39qnbRtFCnvr4oNwY=;
 b=qs4JXUEV83736Ar8U5dsidKIjrOJkejvORaAc76pZoiyIOtxurl0/SunSqlT+kHBwoWH55ZvONN6DrdrIEhaFrGVjcUgni7/Fmrv2AsSHprmnsYQx6EG3Z0ntNqx+0N313EfmGKk6qRafW3cppXD923NHmGzh207Ven9kBuXraE=
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by CY4PR1201MB0166.namprd12.prod.outlook.com (2603:10b6:910:24::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 14:16:17 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 14:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 14:16:17 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 May
 2021 09:16:15 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: modify system reference clock source for navi+
 (V2)
Date: Tue, 18 May 2021 22:15:59 +0800
Message-ID: <20210518141559.1360041-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb68cb8-5030-4dab-cbaf-08d91a078087
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0166:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0166486323E4DD7A316F80A3F02C9@CY4PR1201MB0166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pylDIlL9/OpgNjeG+i0SWNAFj62/hLSMthF1r1vYCDmI7zOiHhmwWV0w9wPHrBqdpL5T6xoqh6spUSWiLjjYUobF+J9Jkm/wFUKOjJXdGi1CKLzPBqlPKqO9Fx6gvTAbvssrf4KFiiiYGocZRWKhriz0Tj3EE4cWZOYDLPU2em0yl2dmwj2xcHKL56WidWrE9XY2MAjOTslDMfhyaY9YeLn0mhBOq0T+tSuCfX3eXIaS95gYbYYM9eNFm19KwBnnUV0oO7WEDDmRYOZzYnjyM/1gQMsgB7mq+PFURjK7UasGGBrwFt08FFs1CQSJiEEruwCC8/2QgQPoJlT6S/mujfmoBGn/BNqqaIQ5f14gm7x4K+5PmpmWZ5jthSKjer5PVh0R27NEQoEkrtYIiRYy0K7VacpJDXLGkUaIxyJAUdgAWQ03/38+2bdxgTSAOcAZvI6+CZ5Sx/FebLYPiuBIIaP6p7okYUv13xcNIIEuJzZCrLofkDoWW01n/i6TucsVH3PQxTZAx0kzbvBYRKkUcuYUs7nt56O1D+OCcrUIKbGTsElM3XO83sBuZz+phBpflX+G4iv1uway6rnkmYdvJx7lGveHiDFNVWgg1bLHgU2r6lvT3S6woDqQ1H5EnXQ8ubjwn5GK3IRd7pgzxlQ6M4vSyUOd2Lfkxk39WWYE1OpCEa3GGysfgEaveHiBUz+R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(5660300002)(82740400003)(16526019)(316002)(478600001)(54906003)(8936002)(36860700001)(426003)(186003)(70586007)(6916009)(8676002)(86362001)(70206006)(36756003)(6666004)(82310400003)(47076005)(4326008)(81166007)(7696005)(2906002)(336012)(44832011)(2616005)(26005)(356005)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 14:16:17.2112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb68cb8-5030-4dab-cbaf-08d91a078087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0166
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 kevin1.wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from Navi+, the rlc reference clock is used for system clock
from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
vbios smu_info table as system clock.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 8c417014ca89..3b5d13189073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 		ret = 0;
 	}
 
+	/* if asic is Navi+, the rlc reference clock is used for system clock
+	 * from vbios gfx_info table */
+	if (adev->asic_type >= CHIP_NAVI10) {
+		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+						   gfx_info);
+		if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
+					  &frev, &crev, &data_offset)) {
+			struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
+				(mode_info->atom_context->bios + data_offset);
+			if ((frev == 2) && (crev >= 2))
+				spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
+			ret = 0;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
