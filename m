Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14055C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 18:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7624610E566;
	Thu, 20 Jan 2022 18:04:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B7A10E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 18:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd9mUYA3/Dfy1g7Ypn90OFK41w1Uj/2PTxpBm1mee6TTj2BshWBzlau4h3sa/S2T2L+YCEpGC48Pj71DO+bHynnBvVBvQ8gU+uxGwJPsg8guZrCzO/t3curTJwVMKD5NZbPe4j8ePF+/9YDHhyMdNckVG+CbpEVPMH+TMnvprE5ELNR7+AVq/v2mq55sZFH/acYNx6jrgCx9hFbCOSk19UBhejqsVC6OGLteMGTDJVg9eXTxRFdD+9aOtJegApfTUf19Zw4XsMtO3vKxqNAN1yvJI42JPrXkKIDJVIebMQwU9X5FbO0mgIIw3oxZc+g0U831Cg9PP1nRKzogIdysog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9Iiojk3ECrwfW7U08wU1wykwaNqZyGFopD5MSIKhVk=;
 b=aoXsjdPXs83whL6WNYwCxmTgxc/nugLZ2uZHcUbNKwLrFE4QTLmyF2bflklhqzRZDPYWn62X/qK6byRh4BAGVBPtcEirAxPJ7ADRpQWxEZJ53PFcCRdmdYO8cjr6lzBxKgDU3BxIhv/aYAPFogtJexCjAY+tTFDdJt6SSL6kiinxo9rF9QUj1zsKRo+dWQ/QmmGvwqaawKl9DKMl5usV97aLs2fXIC2TBhXmxviVUUh+Snh5Ni2f1hqg6iBkMIQHo8WwX0G1Nd6PtExk+wXnnpsPYvBy1wIoN+R/IzKoa6nk1Gtylhy6byrr53Z2pt4mcnJ10B7dDvghLSOjJS9dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9Iiojk3ECrwfW7U08wU1wykwaNqZyGFopD5MSIKhVk=;
 b=WG8Yjv92AhILSd94NQQB7sWKYYc3EIqQDTtoH1yehE2EEDPAxlWHsEfFa42gxQtuQDs/ph2E+9vLQrJTwTe/FOgv+BnHM7rK5c/51X6kPJ/nEY85TCYiN8jYduWiMp9nJr7rNSpBhwybu3qc1/DRXHiMpo+c8lMEDhANF31/Efo=
Received: from MWHPR13CA0045.namprd13.prod.outlook.com (2603:10b6:300:95::31)
 by DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 18:04:44 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::fc) by MWHPR13CA0045.outlook.office365.com
 (2603:10b6:300:95::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Thu, 20 Jan 2022 18:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 18:04:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 12:04:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for
 long delays
Date: Thu, 20 Jan 2022 13:04:29 -0500
Message-ID: <20220120180429.616236-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120180429.616236-1-alexander.deucher@amd.com>
References: <20220120180429.616236-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e877b8-9478-4fc0-e19c-08d9dc3f56a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2972:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB297223E61114A62974B31DD2F75A9@DM6PR12MB2972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNSWJBQ8IlqidlgyNpvLJ3QFBJUkL1xAJcsBD+HI73mD000oZBgtVjzWWeR9WjW4wXowGc8vk+qhQ0rt3YA9EutUhFHOAMX8HZQxmmdJipK6T9i19+eGJgJJYXVSHUjUyPwJAZhHC9O6Kr8xnOujMh4sqXFtE+pQm44Z/BFL+hkPQTJhLq62T2bm7ODiJyXpISk8QbZat+7TSs06V0cKAcusR83Una1kTO31zMYbuQkIcnuczYF+kzxUHl3R2XecRr4PzF7aV2ODzlSbOt/v6gSWgHQ3Sr/8dXZDZRI+dGUbtu47FXj0DDUKqdFVY4D36xr1NEWhtWepBJ9HYIcqY5mFUMPo0w031J9neBuPMq1RF5FwPhZowf4bgGyPSnB4JPh4zNxLr5kYcCR1q/bjxiTyu1tgYTN/qHWE9s9A2JMQ5BvURaS7xGMAN6UH1GXt3tUToFFW+VP9E6smQwtERJ8+OF/P3VMziSfJJ8Q3MRckq1jUAqJpbcGP82tSlFzFW2EO1RheTsmKkl9244o/G97dr0CUf6Z2vnzcbKPdOe8MwS1TPkFHGgfv9DorszDUcz5lZ+ZnmxPU90CrDkZu79A9xCZeNH9f8ky9vmZGjpAplGGSkr4Zsmbaaa1aKXufPKm5kIhImod4keN4MNU076MyX2QDt3xPdNTOF8REJhB18VR1xw9iWiZPCMP0sjJ/kQbvXZ9/wW/ZiomhmT50cJaJaSm2juC32MBsf8rkvHfxN/i+gRV5BxbUtPCg9aL8JA1yL/EiswPWn/QasCwZHC7ZJHGC/ykVSuTSHysSyPM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(6916009)(26005)(83380400001)(1076003)(2906002)(86362001)(7696005)(5660300002)(336012)(8936002)(8676002)(508600001)(6666004)(47076005)(2616005)(82310400004)(36860700001)(356005)(40460700001)(4744005)(426003)(316002)(81166007)(4326008)(186003)(16526019)(70586007)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 18:04:44.2704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e877b8-9478-4fc0-e19c-08d9dc3f56a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
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

Some architectures (e.g., ARM) throw an compilation error if the
udelay is too long.  In general udelays of longer than 2000us are
not recommended on any architecture.  Switch to msleep in these
cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index aa1c67c3c386..eb4432dca761 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6941,7 +6941,7 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 			}
 		}
 		retries++;
-		udelay(5000);
+		msleep(5);
 	}
 
 	if (!result && retries == max_retries) {
@@ -6993,7 +6993,7 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
 			break;
 		}
 
-		udelay(5000);
+		msleep(5);
 	}
 
 	if (result == ACT_FAILED) {
-- 
2.34.1

