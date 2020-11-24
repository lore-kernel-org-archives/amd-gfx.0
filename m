Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC0C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 06:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5100B2076C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 06:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AgpAOfpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5100B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8668B6E1F6;
	Tue, 24 Nov 2020 06:12:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474166E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 06:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8g9/B8LxdU+gnIJ5P1YPwGnuIr1VOITLHwSLq8B0vhKiiGQ44FeNPdfSr0M3kwCwtv3jkTrxHA/vItgIzIfnrmwW958GadGpivv0N/nnVN+cuJBZigmSkw2cZVAmUs2rvnTjLUQhvp4gGu4uA12sqg3o/X78PfKdBDEOdTnSbp0J/1KoiWjpWO7HVjaMqcmC6paOUjx8MKFmuS9zvfeGW1VO+5GmEPYMwXr4s/BGe6JVhNB6JEuqpak1KixlTVPKWSuG0tltP31J0W7eYIx8KMYw1C020jUaeGl1XCokCmq4aWEphm7xioVW1nA71m6qJB74u6lDYorMf+eNGpAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz/Xt7Mc6M3prGrqbBGnz6oGv5eT5yMA3H5tqHX4DHA=;
 b=hOV6KnwMSnY4WATEORSRJFxssIXAySD3H1XKT02kifwYhmpjhUa+oBWLbXhijOa9lyINpxW+fIYgfhqqXWcxEto28+blWBE9FTY9XDW87xP4ClDqU/4yXYA3dMGJOuc6tFAJNKS7Nmucv7psD9wEhBIN1rjFT3A2hv5oUA8/97tDTOJIDn6e4r31T7FE+AxxXvj0UGsleGDKrtBG8eKjhNWVeK/mZYkJyESENxFQQvhVdid502flqGv7od1btaVyp29pI8IzTBqmkKihKJXgle3zK/Ly/5swli0mhNuG1l6r8TR7uhhQNs/loLyB43YKUtK3L0AZQqYff0Q1AkFwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz/Xt7Mc6M3prGrqbBGnz6oGv5eT5yMA3H5tqHX4DHA=;
 b=AgpAOfpYOtNU+zI/Epw6EPrNZuIg4h9x9bCfWMMyZirGsZVM7gQTIcDP2NRqHHq8c2g4cRgpPkYCC/PjuRgTa3FlmrLt8+Cs+wusuCaPWBEfSP0wLmyD9F2AAi4go3DG458XuKnSmpa+Rq1IwaF8kZ7TfphuD3v14zzNp232SpA=
Received: from BN6PR13CA0053.namprd13.prod.outlook.com (2603:10b6:404:11::15)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 06:12:09 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::74) by BN6PR13CA0053.outlook.office365.com
 (2603:10b6:404:11::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.15 via Frontend
 Transport; Tue, 24 Nov 2020 06:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.22 via Frontend Transport; Tue, 24 Nov 2020 06:12:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 24 Nov
 2020 00:12:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 24 Nov
 2020 00:12:08 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 24 Nov 2020 00:12:07 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip power profile switch in sriov
Date: Tue, 24 Nov 2020 14:11:42 +0800
Message-ID: <20201124061141.2383304-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37382cfd-1ee0-4631-2ea0-08d8903fe01f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41756639944BC0202AFB9AC2B7FB0@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cobJbBkWU/K0jSbhbYxn1lUXLkGsngUY7IqfflxicnnHkhJtIn+WVBNS5oIFpu65NDKkoImdDALPWyqdIENwpBIXwwTaJchRVZqxaXcsiUvEYO2QFrHoOj/N4o440W2t0gnB+WHNAgAn+qNpCxXTUvGMLPlde5wEPhYHHtLUBxzm4z5Bso27j9eFDQJO0U6JaXQAv09HIw8vALqlD/5uEqq/PU/ltzeOvnj0459IO1lLUP3Va0PKSj+/ci+QhGKY6WU+g7P2/idmp+Gq+k5efZmFMwq5iB3/R7O3WT9B5SL2JBLsGVt177vxHu8ANbKUY+e9aceU7YHGds88lECeY/vSYpjw5xnt6qnjSxtSIi3sQoNLo4ZdMNENhh+qIT8jRIvrNeUjuhiZjK0rUSHSeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(1076003)(6916009)(5660300002)(8676002)(36756003)(4326008)(6666004)(70206006)(82310400003)(336012)(86362001)(81166007)(2906002)(316002)(478600001)(7696005)(4744005)(426003)(26005)(47076004)(2616005)(186003)(8936002)(70586007)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 06:12:08.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37382cfd-1ee0-4631-2ea0-08d8903fe01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

power profile switch in vcn need to send SetWorkLoad msg to
smu, which is not supported in sriov.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 17a45baff638..8fb12afe3c96 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1168,6 +1168,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (is_support_sw_smu(adev))
 		ret = smu_switch_power_profile(&adev->smu, type, en);
 	else if (adev->powerplay.pp_funcs &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
