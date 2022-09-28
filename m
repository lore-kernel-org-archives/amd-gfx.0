Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD017C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48DD10E935;
	Wed, 28 Sep 2022 19:31:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B417B10E935
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXf/a6BilwrB4OD4BnpJIMOc6B4/EWBxFAE8MbYSITG9EQ/o78wD2wEwT/x0t1j0iVBevFCw90lv4OmymEYmzsVRHVG+n9s8mNFiMfeWJYRoGDz4VMV/4O0ho4zXysszqwKfSjxqZN2sz07rh1+8lEjyxhSYjeq92M0lrfLh6D1yJbM1GfcxrWT9euossK8OImnxVhza0WZSvJb8ZGqpsaU4IHT0KeG5fcJTJZIVgwP/QPWIq7ExJGSHr8zUoSKhtKqjld/xiAoby3h7beijMndB6F+p45fIa5RLBKICTO2nxfPZB9RpK6kfIoEuqJaj1WjoFJAjmzEQr5TutbYShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYYVgfwidGj2zMLFo/NZdYFEvbR2SPraIUZ57Yn3uds=;
 b=AtNY/YtS4hc3ro0y90Dvmx1ldOJGAmzaOBWEvtyUZtRSb1nXyZMJkxJjOcsGPyocM/16UPavtpVp+OQPeEIMZ1xYQcByGiEpFmceC4Wh07F3qxQphpz0OuhW3tXYpBdIalkhjdt3lm7WTVfU0B2IKCVtP21XX2RGNJV/kPe5pPFbshiKajA+t4M3JTATCrQot0ymkb8d+h3XarHtIB3GDiKQ9I7rp1UNvl4wqtRUiQZ2z216fpgXsELG9oe6LJ+IdNtIVsWgbHzukDdqYi9/2aQVDIjRnhSqZlhxoSp2LIyE1qFvLGylaiqyA5xBm+okedKXYBme0R1ZZu4uL9P2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYYVgfwidGj2zMLFo/NZdYFEvbR2SPraIUZ57Yn3uds=;
 b=Sfe4K9MY1scKA3tsORCNjWC65mHKDfNQt0lSet/eDuE/5clNOZTNX8UQo9++clhmyNYZJBClSnZXqnGRMZOSuohInsE9WPgbEQfnpCZCPKRV8phgGb7kdY4A5tZ25sFudcQkw4+f4tk1o9c19d88Ovr7IcnvIjM04+2SfZbkMr4=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:30:58 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::88) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.23 via Frontend
 Transport; Wed, 28 Sep 2022 19:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:30:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:30:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: ignore rlc ucode validation
Date: Wed, 28 Sep 2022 15:30:43 -0400
Message-ID: <20220928193043.5729-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 75518449-e2c4-4083-a261-08daa187f803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhrVM5x/JThZ6iV+0mNq4ef9OdXDD+jYI6KuRbHjf8zXZiPej/OpZPBAfYpE8qDqkwxDsHkc0RZaW132qCXlUSqhRiEr0sHAbSsyxZgJrUdTkFlKW4rigdTBDPm9kmAyVB2SC9Od+prl9N0yqJx7Ff2EEdbXpUW97lMYSRhO2M0Y99M7w94quxOJ14hkOeOxuCRRkWItpxPFgBHaVlO3SncR9kZnVRZ3riA1GUw17ZsM1FhAemS0idh4FIkknJrwBlx+9iajtTMDhRRl1PrhADeNUjoWdK8SLGOp1EYjcXYzHxlZTZeBK1hEgFzyVz5NlcpSTMkwuFMUFJDAPEa2abrKTOJpTmXhayBFmVRKqiqO/1FR5eTe5FaDO/4BHSQm0fDR5H+VGbSx6zcEdTjAGOuKp9l4vWgCSljGsJ3oMWpD89qUQbHHe3skYBBl6Qno0Neq8cqaUDDm+aamY9ITTzlicSs6HsRwUrSkhiYzkw0zKHCqOvXOBewClazkTd6r23hxHpycP7Usyj46YkWllcThAmC/9p3NbehIHKCUJ35S5t4AKg9zHoD5TQn83lTjz0TJIILblCuCEW46cDgYKyczHx+Eu/445o1YMcVe9paMK7Vkzl4CLl5TrxyxjmtmQ1LscYIEu2Uvb5ysllKB3tQo5cMkiBCuUD4KwoeIndiwnRR3JWIE57Opn7pqOV+sRuVG9rlPLz5ZYfHqHFhLMntaDa1RsoUhcYnT2haTKw7a8Ib90p5rL6io6ayx7dnG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(356005)(5660300002)(2906002)(316002)(8936002)(41300700001)(70206006)(86362001)(4326008)(426003)(70586007)(6916009)(47076005)(40480700001)(186003)(40460700003)(16526019)(478600001)(83380400001)(336012)(1076003)(7696005)(82740400003)(36860700001)(81166007)(6666004)(26005)(966005)(2616005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:30:57.8116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75518449-e2c4-4083-a261-08daa187f803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

There are apparently ucode versions in the wild with incorrect
sizes specified in the header.  We never checked this before,
so don't start now.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2170
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 18809c3da178..af94ac580d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4061,9 +4061,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
 		if (err)
 			goto out;
+		/* don't check this.  There are apparently firmwares in the wild with
+		 * incorrect size in the header
+		 */
 		err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
 		if (err)
-			goto out;
+			dev_dbg(adev->dev,
+				"gfx10: amdgpu_ucode_validate() failed \"%s\"\n",
+				fw_name);
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
-- 
2.37.3

