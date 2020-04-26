Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98065C54FD0
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 11:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61164206CD
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FQT/oK3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61164206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1ADD6E02B;
	Sun, 26 Apr 2020 11:13:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CAE6E02B
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 11:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kasbNHcl+k2TFupMrdL+32iNwZFK77wdxsHcdRJmqS/qfWTHcmPQ9+RY4xZ08f4zMwy3en5MaWZMeFiduEcxl0efIQJnnZ8SV2oi1oXbiqFejwpjoFGtQicc7smsa6uZc2MIoA54z983UiBY739ChVUrDoA0IjP9szT+fa7haqsy8OUmJpywO51aZjYakjTDwtW57l6b9sU0ovk8V5ACZ/G0V9hSYebUpbub7524d3G2dvMdk3oFEOqHPavYbX1vVNdCXi/Xm+WfIZGT+2s3s2LFJ5PwcKnrPiGOgRjrpHFxW/RiSeZARX2Ks4G/RsiQCiKdwfU+WqyncZgaPZygKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEBCzwBVwY9k9LP9O1niHn4K4LXJBc5ZCY5CgG9wpLY=;
 b=S1N1a1cmRfDxk3gfInGwbtGjFOon17jslKCo/KT6I28+t67L3+HXZ+hOxnZ7aADgqaFFZea3/KibGO1JN92kN3l9UMyPyi2/3613cEt1q7YBcjETISbitfDxGm5PPWZz+C539BHwUxo/gQin2vvwcToRt914YKw2QHCQZZM2rPzooFk0QjQk+ZeyAm4Cl0Ct3EYFWLwiWpfst3vlzRSgNIwRNBNJLmsarCQD3ez4JzSQ7/C4kECZI8/jH+wwHWGrbEctpeK0J8OT34TfsCC6PsjH0tVOrCNdlm4kPC02O661QgrFHGczH2ERY7qIO39sRs7J5V2zO98xC9tpL4fIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEBCzwBVwY9k9LP9O1niHn4K4LXJBc5ZCY5CgG9wpLY=;
 b=FQT/oK3Yps0JLuIb2NcGnQ7uBEqFwJ6pfJRyXn4hQVtv9kYJDLEdenWoRjFP7HbT+W3uuTiyXh9pqkxyewYHnZoahsqxtdXV4dzGQR7srjffShF4sPlhYScNPGd5/usPrABVHvVkxFaFomwo4fwZIuR5OOEkHoJwQjdnX3NXScM=
Received: from CO2PR06CA0059.namprd06.prod.outlook.com (2603:10b6:104:3::17)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 11:13:14 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::72) by CO2PR06CA0059.outlook.office365.com
 (2603:10b6:104:3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 11:13:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Sun, 26 Apr 2020 11:13:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 06:13:12 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 06:13:12 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 06:13:11 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: avoid using pm_en before it is initialized
 2nd
Date: Sun, 26 Apr 2020 19:13:05 +0800
Message-ID: <20200426111305.10755-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(428003)(46966005)(1076003)(7696005)(186003)(26005)(426003)(5660300002)(81166007)(336012)(54906003)(2616005)(47076004)(70206006)(356005)(82740400003)(316002)(478600001)(70586007)(4326008)(6916009)(86362001)(6666004)(36756003)(81156014)(8676002)(2906002)(8936002)(82310400002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1b8209-8b9f-4706-5f9b-08d7e9d2cfd3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42544D0783466691CA6109F4E4AE0@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03853D523D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDX1NwFA0tbEH8D2Yeic4Y3W4Bzjln1gPjcZuv5hoU9XSWz3ao79FCQNH0b6GS49CCThl3qwkZneP9h60jka1XxAmOL5oQc1q6ZCaUzqSHnDRs1hF/Bt4LouFXzv07lCil2dcOtkmHHpMSe5XTUwwvNJyeRWdGyNqj7IOC0CvXFdQwXaAw0x++kQ6ATSmib+pV25op8IKfq1OFG3B3I1FCKXb+ffZ8lLbsP/FadfC5w/wjnPoQcNsHxyTd6HKzpNi8MMECWHiE9n5PPzD39/BID/AfJR39ouWIb9Px3dtNGMjdjVKD77ng6JFh5ffHtjVKcn13CeNuWzD9qlyLUykBlP21HeNPNLVEHweX7I0pQtla65gxYxNCTqmWK0+7BB/sT6n6WL4TtqoLIadAEME9SA3ATJsVzSSG35VJyvbKjgPnZjh7i50yq0cNpnpdXt3h0Z627G3ktPzbERcTLw+pM3nk9twjGrhVx4qaRHuhYPpTWYQIWsQ9Fsi5K34dD9dtO25gW11EUlVvS8N0jX1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 11:13:13.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b8209-8b9f-4706-5f9b-08d7e9d2cfd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: Tiecheng.Zhou@amd.com, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hwmgr->pm_en is initialized at hwmgr_hw_init.
during amdgpu_device_init, there is amdgpu_asic_reset that calls to
pp_get_asic_baco_capability, while hwmgr->pm_en has not yet been initialized.

this is a second patch that avoid using pm_en in pp_get_asic_baco_capability

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fdff3e1c5e95..b27f71c75550 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1438,7 +1438,8 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
