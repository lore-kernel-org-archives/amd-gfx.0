Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD508C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8098061184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8098061184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863586EAA7;
	Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3819F6EA83
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcfFuY+cUK1yAzUEOfnNWVNFtcBm8p97uuvZfWZ1UlgeYPluHROc1xOsYsVFbgi2yKSSk6H90PKfGbO747mCEdB3Av7etJU+B4dQyU7uIBeGif1A4hSidvkNB9QlnXlS0FjYoWIgw99WSJR5KO/b16NYIpKFkxC+QDPmVNbDPDIoh5kpKaXjgRR7eAhxfKWr2XSFez2ioUZ4tW28iwSrq510GcQ2XgIeI4zckyDzzWym+rv8mbJQcFEoVAbCKWJFBz3VVfkOJgNtK/uslHaqw/ITOZk3tEFmvie0DnjTA0j+10eLzheEPtNqw3n5t2Tb09OMQwQwuYL9Px5sq/gmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bcY0w8F3TRyyAuNcFrhO0DQf6lIY9X5ODh7oaUcqqlk=;
 b=nIxlAmrGMqLS5/Hje7EnRV8+b2/m5LAiFcZ2l4Mo/SV12nL6R1DqSqrfSBZ8QXG9vc+1braOri3ng9vOLaQZVjP9/Cd4FB3olLHzxc+XyhGz2ajl9wR32P5KGaX68C6VrveGMwI45AJ/yFiTtQHMleYa+oiXucP8url0/wmuf+O64mzUiGoK5QpGts2SJ/1uKtQrfmnzLHKJ2IIrMq2dk5ONIGoBzbMuWuhptfSTS7Ba3xiY1Vb0zCDGP6t+HLbvWKpJaK5eP1ZA06D++yTLTdbZ3Kix9c9SaTfgf4soxjfJrt0Ui6Dgqcll8WEZDSC80yUCIZIWIT81/eri12xJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcY0w8F3TRyyAuNcFrhO0DQf6lIY9X5ODh7oaUcqqlk=;
 b=Sxssfh3iUOqTjO+PY82VyB1B1gZJAFdaZq8TI9mq5FbaRFLbYDQoyhNE+8/FAJiYsbcozDXCXl9lhAs/qF2llUSRa21crmXyOJIvkgUNRRKavhjeajrnyIJPmHBIfrmJ4KaKQ8qXfxkwf2J0GZk7PyG8UT3LCT7GxBIescMv+L4=
Received: from DM6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:5:174::23)
 by MWHPR12MB1503.namprd12.prod.outlook.com (2603:10b6:301:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:56 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::60) by DM6PR21CA0013.outlook.office365.com
 (2603:10b6:5:174::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/66] drm/amdgpu/soc15: get rev_id in soc15_common_early_init
Date: Tue, 21 Sep 2021 14:06:53 -0400
Message-ID: <20210921180725.1985552-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 704e489a-7a31-4a7a-df9e-08d97d2abd1f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1503:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15032BA89A1A80FF227166DCF7A19@MWHPR12MB1503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5daLAcMNGxu8rGHwob0orIYOiX3E8Ut/Cg1Ikugqi/LyMkHn/DTXjIWWz9yI2Un27FeKa+NhbPnRdefbNKbViMJ9MCIsLWZdbFctfGmGcBQUTSjkwXITVDdl++1WjngY2Ju9NMiqHSth81YF2Ts0jVwTacpp9U7n2kx3tELH3mnsHlIF9jhJEVX7cSOMkDUe9XX3HOJ4WvVnmCQqQPWdx8T9r20aQXiCBDORM8xvCSgAJFjh7zo6HY2FgDPzSzC7Smu9S+NT0sLES8APslWDulpeQkDOUDr0GK4hUil6ZVlyToFV9LgOCQfAkWWqOqd9+L85il2qf1+HW2GxRK9VkbzCfUxjQ2yBKjpFJKtUJfmWVnDbbOUI+BW0OxamFeP+uFZ8wj2aGsTNGXUbbmlxY9VM5peVPxAt9cK52rQQtAUX6rwGl/DABFua7Q2zC0X4VJrPhK6LjA2Mxgf0HWoIoe6UK5Zj54QEz4S7QhPhT8QnBAxJthXY+2cNM/Dn74IZmIcK6hBDMc+ps1vYBuHNxNGUvD+3rlzTglxEanxsj+dmVOQiIwLyMyBztl16SbcKdBYoy2bUHz0IrY/lQi/aTGvopBOpoF0x9ClAaRqN9uT8/OgsyH1O0n9c0YUOdVC88TrOCEgQSx77/ECqsyj5cJ4RMJDqXW+MFF5zxo9yWp1+iaQcvPK60kZtdEmvhcEnX70tHZQQ3pVbxEgwTM6t1t85okYXS/oAoiVKr1cd1QA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(336012)(4744005)(508600001)(86362001)(426003)(36860700001)(16526019)(186003)(7696005)(2906002)(26005)(1076003)(2616005)(36756003)(82310400003)(5660300002)(70206006)(8936002)(70586007)(81166007)(47076005)(356005)(4326008)(83380400001)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:56.3893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e489a-7a31-4a7a-df9e-08d97d2abd1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1503
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for consistency with other SoCs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dffe7d7ff9e2..f26d33faa0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1155,7 +1155,7 @@ static int soc15_common_early_init(void *handle)
 	adev->se_cac_rreg = &soc15_se_cac_rreg;
 	adev->se_cac_wreg = &soc15_se_cac_wreg;
 
-
+	adev->rev_id = soc15_get_rev_id(adev);
 	adev->external_rev_id = 0xFF;
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
-- 
2.31.1

