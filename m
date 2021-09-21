Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6362C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8240E60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8240E60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A16E6EAAC;
	Tue, 21 Sep 2021 18:08:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEB76EA8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzPy7XyJsjKSb3/B5XIPspFTeJoeKAu4tLaiTls3llPqZfV5T98xGLnv3GKYLz+QimvbgIIQFDdXd7mDXvAT0356Lk6L424gtFYhG0vPt2aQNxCzbvxfd9HJIGwecxbgOFpWQblnQvhAf6ofjysEefpa9/0v6aO6YpC5DCk0x27+1YP3AVeocNsCldaj29lLkmwj3FZ1jnd90WTF/PIgDdcPUcDn/oJ+1vCj2egOjr4UxpKHNM70pBnE0YLX6TmBUIRCM1o1r9GLOML8jTVTEhGlyPck/ZQZ+FXcOYy4db/wchWHCMZjOIPZX8TYFuqKPYSM/MNSjIFBkS3jgj/9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dTjYhWD5QyRG99c//CN5exdse458X2x9Wd9jy4PDN+A=;
 b=HFgWzt2+Y7EO79oBczpAk2VLPHgaGH8iQldHBteFAxcNW3EN/NaTu+zQ7PU1bkR8sxXQTxceedrrVwyJ1GuTk8FOXm3LZwM7iDCipfePVBJc243fO0vleu3PfEUDWFC559OeKkhdy51LpTOgxXqg5KM9aiMkc8kZcc0hZn+Y6K/rX6EN3DyqMX2jKYmG6eGCFqVxqkJS1sl/bwbVg1rQMoNAvImJXS1l+e/L1NkAt4hvgzXOfkq+aL6QF6TYKus89Pubk3tEPUCeDtrGx9ZgSpQkgxenu4Qn3pyivzRXp70dSZ4PAH4RufA5Uym68f7HNH5gE/HddY/p/Yo9sPP+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTjYhWD5QyRG99c//CN5exdse458X2x9Wd9jy4PDN+A=;
 b=VhfM0t+2rNGfoUvd+Ywna0AXRTekUrmkCEMkx+nDsYZv7bMQpLCS+MTWSYQ52MVFqPUlcT6guDqABkeRF4bQ3GqjArAffO1/iVvuxO2Az7XXOJveaBLIut/WxJ3eYzjoK3nt6WmMxwhWHsh16xDLL9S28cliwr56bk6U2BsDMNo=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:57 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::5f) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:57 +0000
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
 2021 13:07:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/66] drm/amdgpu: default to true in
 amdgpu_device_asic_has_dc_support
Date: Tue, 21 Sep 2021 14:06:55 -0400
Message-ID: <20210921180725.1985552-37-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c055eaa-c9d1-4338-4067-08d97d2abd74
X-MS-TrafficTypeDiagnostic: DM4PR12MB5261:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5261BA51B8438D000C0AAFE6F7A19@DM4PR12MB5261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NosVPziqwmACESRZqE/zmN+DySEeDIJxzUT+FXI2UtiTkNMNP2OwMU4RYNxBu8mwfcmmGz7dh2cFfUYQmkswkRJaB4wmwMMOpI6k1XIURB2YTjndva2ALfCuHGLJ/qvhqsyx4IHlxWnu5uYfLJnHWrgkjeIQpoZqkGrZE2ReNuNtqq7kRbAQy4nwHnle8zT5CPbh1+IVd+KhYENkHT6UqKU63TeqfhcyBuTSdP93YRTZyuZEJzunpD0Fd0PTyo0YlEpn/6uR8IJxcvJauUYZx+HrfX3qw1b1ixA53pKFAOrz6tQqQ8uOYw3AmUt6dRh5JghNTEatks9QHTuzyJNBtIVJsEgJndWG5V+X2WfVDe5G96MKKqJ9dUMEKMpO0Bbnjc6JLIBvtvHOwGRWY4wmt7S6xGBQ3tM9ZyXzGkxXBE7qPBdG1tlQ4S31vSNxpgIvzld0/UwyL5dGwLJ1yk66QjXkaa8FA5wc7T2ZdHbn28EtnY+VYMNcuKXLlnp74F/UlWQa24fHpkYC6VBFKTDobASd8YVkGnW9AlLhDQr2Ph4PDJCwksroxWU+BcWXBCk5cooelnKrfS0VMFIWF3L/pIR6ZC5thBiICS78kYonyDPXX+pN0c7xXP1O2wNSEnOsvn/O9/6Gm0JDV4vU8lALO4nZ0tuSffZ40vm9etNCXVUabLuERmjqaD/I0KWO0KY1wupwDmtW8g9qjDdZRvr7PLS+/aHb+9ZXV3uH0gW4JPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(36860700001)(70206006)(5660300002)(16526019)(70586007)(2906002)(336012)(6916009)(82310400003)(186003)(2616005)(83380400001)(508600001)(316002)(8676002)(26005)(426003)(1076003)(356005)(4326008)(47076005)(81166007)(7696005)(86362001)(36756003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:56.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c055eaa-c9d1-4338-4067-08d97d2abd74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
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

We are not going to support any new chips with the old
non-DC code so make it the default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d64e5a209cf4..3f2686296f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3212,13 +3212,15 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
 #endif
+	default:
 		return amdgpu_dc != 0;
-#endif
+#else
 	default:
 		if (amdgpu_dc > 0)
 			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
 					 "but isn't supported by ASIC, ignoring\n");
 		return false;
+#endif
 	}
 }
 
-- 
2.31.1

