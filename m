Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F9C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 20:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A85A10F78C;
	Mon, 13 Jun 2022 20:02:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120B510F78E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 20:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXTkYAkGaZfzHI9FPFl7Shr5FA7Pk0zw5ttHb8Jaz4EWyIyUEkg5wPb9nbwFNKVMWWT44Rr0YNd+oijLl9W2SLX0kYkwf2/i61Wt0sIf2m+FDg96smU61QOh0vUQoOfxbO1QxESq2mTj+gv0JlwbSMEanT9n0Iw1YWzPppXPUXLcKDwqnIlizccdvy4H6CKbQDV/qxADkc5vISiTZZ38ZgYDcwqaLm4ExA6LOgd410l5eNw3YU70EYOBS0ttI5laBUfptUQhJ+14SJcK3DRd65IKDwJnQgQfnSao8cVVVvL6yhqmZsTBtYVOK1w7M2Eu77J9qrA27uNw8uKUnhZ9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALweVUN4WMRBJWiaxiJ6cJmNOZqtUg8Bv60n8Ak1F/g=;
 b=dS4XWeqjV7MNs7hI1KsvYTJgbPiXq321/FW4zepPI1OcSBNiik1GyqgJDJ0L11MGm4J7sa198O8NKI4Rn8dqQTeWwi9w/bZTZ4VcfmPG5ozlURcnYV9BkjX5+iEoB6x3hEh3f1VMhep4miNAWlAIm0g7WdADk8dGXHXB8x4NjKgUizocs9k9S6sryPoQftm/unwvcwPakWU9J+m62v88+fWkxfDk3PdPUDWlMVLWgUvggOU+FxHjj8Eou5S2Vgi6ms118d9cOu4EJ85mTweTBjMmOXsWd6BiNPNgjX4p2iOVy8Htb+uwX0sg/kvUJeDm3rgmSmuJS7DpHFD3TvVppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALweVUN4WMRBJWiaxiJ6cJmNOZqtUg8Bv60n8Ak1F/g=;
 b=sm9Wrr3d47DdBzQ4QnCFovpkZJNkF5kPapUHTB8+y9XXflxv8m1ylSJY+Whwva07XbUB9lO1LnLNIFpCZh09QYiB/1nYkPovjDHPQ/mWAplvwJyYe2yV6d0jWf5bweUe8rlNZ5r2dM//JaonLn6/+MBy0AcVNpUQ+TIvHBDO0tM=
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Mon, 13 Jun 2022 20:01:53 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c7) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19 via Frontend
 Transport; Mon, 13 Jun 2022 20:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 20:01:52 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 15:01:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
Date: Mon, 13 Jun 2022 16:01:10 -0400
Message-ID: <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a120a1e6-6705-48ab-0490-08da4d778f7a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1301B9E17F995FF0AB36646298AB9@CY4PR12MB1301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWF3dp15L9kjNoZhrSzVDSpIeaKV3io7eKIWITq0GNuGEWEpoacG1u60KeS9IFmCh4irrGgr6/R+vjZQMX7y9WdN9Nd2EoqZn7bYqaQ9j5+yuGGmM5vrj0qzErDJZhNCwHtlrEdNNqkhoD+Vy5D9M9X/CnfGk6VsiBqWkua5WTV/E+hdSIxvizsS5bYBgbGbDU/4LVbKBWj2py4PT5eSMP4zj/Rm6crO55wsU+gf9QRkdfUQqGHmTGU+YYx/CE54Zdeng4xAbaHamuYQBtfEdfS+fzykzMQxJ9i+gAujCdQkmwQj+PMHQvHOudp9QvHNrzVc93hvLDWwSVt3UyCAa2w10ChuFHt1lT4/DzL46HQpU4pNYf2YaCy6xBvojo/F8KyYopmhJWec61SKrRMLgGF5eLsbEuImJMOkB3iE7yrnFQKlr+PBhTlBNvadvnXeN8w2SpO7oiO+rz4PofvINc+LdOf25ugW8ij7UMTZEF/FKOFGV1p4a3W9XasB+/7XEWaE1wMcfToLK0Fr0hzGs0OAqqX7BRu3McbSORQiJS6ir055ess2amXKEsNRPICk4UqiwvuLMSR4zo9smCxxSkfJmth5LqV3ENoU0X5R/FK1/0TUQsDOxjykr2RJWv/l/+vRJDE084eeqEJrn13lWbDHqRBvByRKw/myCxcKx72R4QJAnT+5qBo6IrPWudd0PtrgBt5p1E+p6LdKZB4qaHXuWoTfwUbg8LIFQiz0zXU7DQSEKd/W9EU70yvo1NeA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(186003)(83380400001)(336012)(47076005)(1076003)(16526019)(2616005)(426003)(81166007)(36756003)(356005)(8936002)(5660300002)(7416002)(8676002)(36860700001)(82310400005)(2906002)(508600001)(70206006)(70586007)(26005)(6666004)(4326008)(7696005)(6916009)(54906003)(40460700003)(86362001)(316002)(545624005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 20:01:52.8838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a120a1e6-6705-48ab-0490-08da4d778f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Mark
 Yacoub <markyacoub@chromium.org>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 Simon Ser <contact@emersion.fr>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, maira.canal@usp.br, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, tales.aparecida@gmail.com,
 Sean Paul <seanpaul@chromium.org>, isabbasso@riseup.net,
 andrealmeid@riseup.net, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Amdgpu driver is used in an extensive range of devices, and each ASIC
has some specific configuration. As a result of this variety, sometimes
it is hard to identify the correct block that might cause the issue.
This commit expands the amdgpu kernel-doc to alleviate this issue by
introducing one ASIC table that describes dGPU and another one that
shares the APU info.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Pierre-Loup <pgriffais@valvesoftware.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/apu-asic-info-table.csv        |  8 +++++++
 .../gpu/amdgpu/dgpu-asic-info-table.csv       | 24 +++++++++++++++++++
 Documentation/gpu/amdgpu/driver-misc.rst      | 17 +++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
 create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
new file mode 100644
index 000000000000..98c6988e424e
--- /dev/null
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -0,0 +1,8 @@
+Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version
+Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
+Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
+SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1
+Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1
+Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3
diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
new file mode 100644
index 000000000000..84617aa35dab
--- /dev/null
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -0,0 +1,24 @@
+Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version
+AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --
+AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1
+AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1
+AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
+AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3
+AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3
+Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
+AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
+MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
+MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
+AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
+AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
+AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
+AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
+AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
+AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index e3d6b2fa2493..1800543d45f7 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -32,6 +32,23 @@ unique_id
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id
 
+Accelerated Processing Units (APU) Info
+---------------------------------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1
+   :file: ./apu-asic-info-table.csv
+
+Discrete GPU Info
+-----------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1
+   :file: ./dgpu-asic-info-table.csv
+
+
 GPU Memory Usage Information
 ============================
 
-- 
2.25.1

