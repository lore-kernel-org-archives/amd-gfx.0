Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFB4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 20:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9ED10E197;
	Fri, 18 Feb 2022 20:43:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2752710E197
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 20:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJOFJ06PXz1395v4yp+6TlUx1Z0bycKMEidFF6674ohRwT0ycKpnfLuM8za6GxTr3LitkdVDFJHeP6IYGXInpFT2ZRtsCJLNJn8AkM6BJSkH4vIqo1enK1bMfDQXKIWvv4v+YfA67+jRnb4+rzvpn76ICdNA/j5OHk3aNAjesT4ZM/ZwG9zLcXpW4K0o0BFOxFaGQJBhpudkCZuZY0AM5Ejodk7M092FX5XsNbR723fkd5ufYC8sFYIIVEwtVkmI0hBwNpiHibXVQKr0gEP6KB9SD8+SjaB4b/QYGa0N+uD1/tKYqB5XXCFHktcN4RlW7uQFJJnK/2gJZdpzYN3w6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyjpRj0dk4x49M8TNhtZRdFBYU/kYzB7kDrsnTfmECk=;
 b=lRLft4k4ViYDCnoRzdW0HPubjstWjmUJ6Ei7jWD2/xWWux1RlzASPs1nLotIhucGi7vJ2F3+9GA8vpBSk+5vXzDyXFySgCx8/kW776SSIErkyhodTDi0Kd4494vxyq3zOVB7/0T6mnRscdFenjsEZJUWB9fYUFc8GE5M2DXZboH3mdLQzoQuDGCvPSO2GkewEMiOuiPbxN5qEmS+37hERu+3MPQQB1ctlVG1xC7r1dQqGrPCVi3Ix6TS6Sl+7NnwiLmFnZsz70i5AG7ZiKGqZMdxV1bKfznHUQqq9ctWxj1GEhHrlBR8pE6ohAwniRbhBQSeaIxmrjGW5b0p3IQleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyjpRj0dk4x49M8TNhtZRdFBYU/kYzB7kDrsnTfmECk=;
 b=J7kmTyTcCWwzRuwXutP/G9/Sa19EQZMYfiCu8RyvQuqSVnla9ktZ0Icep6J8euQMRYkHual/Nc4pBKCvgU+lSPFjN4wHeL8DkK+fk0trVmBXIm6k7ZyjG/M22BZPoCACpRaVBB6wlY85dbIblrcytVnf60j5rrE5FVRfpSNmI0U=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 20:43:01 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::29) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 20:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 20:43:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 14:42:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: make CRAT table missing message informational only
Date: Fri, 18 Feb 2022 15:42:48 -0500
Message-ID: <20220218204248.830299-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20a59fec-f62d-464c-fcd3-08d9f31f4103
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB412819D05F45C7BFD0059EF1F7379@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgp2a8YgiV3UtPMJic22M3kHIBY9zizHF0mB8RH7fANmvMNDnzd8TVwNbxRkVaCIVuOQtb0xaMMWowtsV3gIpMZG59R6+HbJQPv7CZ1c17708nvW0BVp3ciV3rw4tEKnOow18yCF+cZCMIzDgI+EMGBnjFvNGIyM7wxu5GJ7ppJv85GXFRtI3pMMg3ZxozUjL2zE/n5HzBG4W4Djhw9TJwOoWlJ9bZ3zCTAE2eGDtzvqdzG6WZTUcIxmWjcqk+e7zE4muICqHwyBBiY8nkllOj10mndQyFs7cJnUIlZkb5Zo3+vhGV/BP6GyhwwuBhSwpaUzNMcbtKzAQapkY2zBKlLfegwyviXRyUGGI58qhwBZPUvD9rbWtxN24QJ3yQIr907bz9glNoIyMvE4Jdtt2oa5asb9aY147WW2TtUUGIxUQlf54HZSdze0o0pAsb1u/hHhpIBlRbmgSsLFtagrDlrd+I07vMiFNwR+EEMMzSlNZgheTD0/38jvsoMHQhqi12YbZHl2oEpN2J9EjHi0qeaV0+fEs2VdE+2hZp970w01wCjVqU6oGoonB4GqSm4WVfMEFG7IOC6kFk1GwTbK59X5otMeffddW7q33RsWisCrBwclS5dvZzt4eTjHNP9ewto22dQ9MaRq0VhQo1pUPjSRC4nTKdSIz34kTidRP/EG7B+CPPANm37fSpvOPO1adpny8KNsWyKpXaQPL43HnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(508600001)(7696005)(8676002)(2906002)(966005)(6666004)(86362001)(316002)(6916009)(8936002)(4326008)(47076005)(70206006)(81166007)(15650500001)(70586007)(4744005)(82310400004)(5660300002)(16526019)(186003)(26005)(40460700003)(336012)(426003)(36756003)(1076003)(83380400001)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 20:43:00.9170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a59fec-f62d-464c-fcd3-08d9f31f4103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver has a fallback, to make the message informational
rather than a warning.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 24898238b024..1eaabd2cb41b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1569,7 +1569,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	/* Fetch the CRAT table from ACPI */
 	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
 	if (status == AE_NOT_FOUND) {
-		pr_warn("CRAT table not found\n");
+		pr_info("CRAT table not found\n");
 		return -ENODATA;
 	} else if (ACPI_FAILURE(status)) {
 		const char *err = acpi_format_exception(status);
-- 
2.35.1

