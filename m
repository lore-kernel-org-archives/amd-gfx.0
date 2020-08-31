Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DFC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E5120719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fU1ObIaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5120719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA40A6E3A0;
	Mon, 31 Aug 2020 15:51:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31426E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXjwSleYbytUZ7oQeR8jwZw9FLa024S0L9oOGOeQhasg8ED6ELmzIfZAGaTTo/q9wZCNejwBn/MHDDSoDkqESV2WMaLbw5t0+crQyiXL+3OBKe9gyrr9zW0T9zXGxFJXFfDaEkr3jU+IXMfoRSwg/sXan8FXIk0QdC8Em4uqQI6UMHoFPWqaDsU1hea91ETDyOtwz00SMP2PJsAACSITZdrrgbHTzx9++BWpXAfX62Q3d4lkewsWvJeCSDYu0BWpZB7Itak2Nb8MLtMWNiwXAygfeqmkCTbfBw+l4bzdcK/uyaN0H+8GPqFXKQjIerozlzT7EEOnUk7Id6Dv330Vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGzvEqWX7fppaPDbwdKn1WOa9UGbOEXccGpdIRsLIg4=;
 b=Uxy3/IsbEfCA8QbzQ6kOXu83EBlI8rOumzJqnTjfxVCN7UnaKHpsUIjpJX5BnuS92L4012TsNzWY5p86t3Fvi5nAGre+ki9V/wIf7I0TWFq2XD4jzY8Rm/q3dtV6S3hGRorD2YGFMAxkQrD+a1D5rvQRurKe65iSFc/58zFTFRNmudLjM83290fO1MjQcqqPfFXJ6V8sevTCvSixCzZx0zYIMc6cjHWXVg9PgY7dzOkJP1H0Tz/jOK+6e1n1/MuQI4fOIYJsT51X2LysQl6DwNsQ9QKrNoQsw2uaFsmudRu7OZAItH0bB1QbfdWetS+guEcqsPFOaoAFfNf5r+OUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGzvEqWX7fppaPDbwdKn1WOa9UGbOEXccGpdIRsLIg4=;
 b=fU1ObIaFK24Uck704GplV3J1NROo9TvKK8rTuqkCYj4T91zF0TIC0i3EQzdCp9B3jX/mNmZ0USjWAWumJ69IymKTKxNg04eZy79YPp8qUpg/Ic43c/x/UFJJr/NGNsZZT0mOTY5S+wb7y3lV0m1gegGTqzcWjv/h9tdMpzTvzfM=
Received: from DM5PR07CA0160.namprd07.prod.outlook.com (2603:10b6:3:ee::26) by
 MWHPR12MB1709.namprd12.prod.outlook.com (2603:10b6:300:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 15:51:07 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::ba) by DM5PR07CA0160.outlook.office365.com
 (2603:10b6:3:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:07 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:05 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:51:04 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 8/8] drm/amdgpu: Minor checkpatch fix
Date: Mon, 31 Aug 2020 11:50:49 -0400
Message-ID: <1598889049-28321-9-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e57145a-8b1a-4bce-7421-08d84dc5accf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1709:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1709653ACB5002200386FBE1EA510@MWHPR12MB1709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3cCmgJaA5dMDcIPnDS7fMS9vKBvupQzknEUchhusIB2cLmv8xy7XpLR4P+zd0JnCLr0cpv1i3vckb6aRQqK+T0DzQU1bh0FqZ7+1aUamzW9wQ0YhNecsrrz7X4MkANja3rwtnPL6+MTJQswrJ1Wi1wExaV+kBcundApFA+t3ceYDV/RKQH5TT1tx6hm1H4M3S+ru8MU+JtyZQoLU+aQ+TvmbCp7dipbJ4EEoOYv+e1kHFgTSQJrDoCHTkHpygV345V8hLsKOBtPFsBJ8vlJnVZbZTCzCn4UNNh5NSZFRtg+yeufkZNdidVFxIdjRH7YnvVNuHT7AzM4Uf4U5qTgI/dKqcqorSDIY4c/NggUS7EMtaKW8oJGfPHIC2bXInUEH832qWFDGnKxk4Bm2ucokw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(26005)(2906002)(86362001)(70206006)(70586007)(186003)(36756003)(5660300002)(478600001)(7696005)(426003)(2616005)(44832011)(356005)(82310400002)(4326008)(82740400003)(83380400001)(54906003)(336012)(6666004)(6916009)(47076004)(8676002)(316002)(8936002)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:07.5188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e57145a-8b1a-4bce-7421-08d84dc5accf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1709
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe720c2..16c7842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -353,7 +353,8 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  *
  * Returns the 8 bit value from the offset specified.
  */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
+{
 	if (adev->in_pci_err_recovery)
 		return 0;
 
@@ -377,7 +378,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
+{
 	if (adev->in_pci_err_recovery)
 		return;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
