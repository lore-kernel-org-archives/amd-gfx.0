Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C6AC47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 19:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82D110E164;
	Thu, 18 Jan 2024 19:51:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7823710E164
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 19:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgyyILZSkbvAMMprwwPhJOMnd9d4OzN1xOezoxz4Gme0Zvc5z6lGUzLo272lnUU5V6wIcjeQ/eNXi47Pj24Cxs+YO0z3ILNDy9tt8nlIskxiWB1yU6uqeEz/ZipFCoyxeFwTPFqZY76NKxHmp2qnLe2f4/O80lTR3uVipxT81Rt7lyBQeO9hZvuzosKImr6lG5J/RivtfZ+WH2RaMRAPXsmnS2mBOBhgO1jRt7N8YkUBVHF9RHd8LfnAracD7WRjShG/mrcwXfl5KJBJiOh3c9uH85JGL/v1Z2Dzy3g4rSYqwOymoXRgKY+m6nexXEYDc4Lz6LyxlItPd4RDue/dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMUYIxEiW+q8C90nSdWtu3vYqMmPbZfo1mIZA2xZSQ4=;
 b=En8PEhLUzriQD8V9mtlKvyOncWhurvF0qzRc8X7TM4+u1WJS+5Fn23l1Js0+elioSdCAWZ0l/mGakwtyLmnEFafpR5MqmQdHT6zip7bSgZ+p0OSw1YdPu5pRWkhFCsrtoc798dNDsH3VNcyupIjIKnYfUC+azDJNrPao3+2avkiT8FXvxfiav9omGb5wCR5X6Ofq77USVCx4kctdelnsLfPt4BDara2GJrqp4jidwzNcq+6smUiL4zoKh3ti4JFGG4tG4xPMco5EV6ACoBYvAFT8Y3AogEthDx0JbPa7A+e6J0Kc5nDgeaN4Uz4jfHJz5MrFZ0hdrJHYC/2Z0pUkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMUYIxEiW+q8C90nSdWtu3vYqMmPbZfo1mIZA2xZSQ4=;
 b=pdotIMbwN0JLY7F3u0y3PZR6ffsmY4nRF8DSzEMtb0f+5SYxQaB4CLWfjC+XnwREkX+ini72Rp8qJvKD5tPlSFmsqgMMxZQpeS92ZWpCNvLhT8pPJESahrfOQ8RXSMEohyvAeBKBqc3t0/WJIQjkAdf/DXu/dFjaVXxu9kPBCts=
Received: from CYZPR05CA0010.namprd05.prod.outlook.com (2603:10b6:930:89::18)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 19:51:20 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::60) by CYZPR05CA0010.outlook.office365.com
 (2603:10b6:930:89::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 18 Jan 2024 19:51:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:51:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update documentation on new chips
Date: Thu, 18 Jan 2024 14:51:06 -0500
Message-ID: <20240118195106.3669705-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 034ec3ab-d61e-4307-1e79-08dc185ed7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqMlUoqtGFtcw54jbwuGe0iilLKfuL/9aFpWuGPK2d/skMmbF1Yc+Jg2+y9nOYGRxq0A9ELb1URLn7NKhuTe8VTFY7N7X8lGI6LX4AFhNxzzgQIDQIWFHfYPx06JuZBRYPoxqP2M8wncnAfW1E2JY1F0ScNWT2KoLLGRYgan6QGrYYLTzLRmSU6/J1M/4wNLzKM1P18wnwBZsCNXbUg0R3ZULanlLYXkO0Csen1wBC4lBAp6vdjimqpI+5goyP2i8bzPrGHGSkH7SYD0Cgv8GHg8n+9GhHhxrEYXFuPi11vKUrHZYPeSfe/RAin7fLNqQhqq6tAkjdzsxRyntp9TXJLebm3kUc0wc13xgAmrJQv9cO1QS+OcN88GRZ6j6pWYcSHz1h6OIN0zyROTbWyO3SJA6rVTkYDZsR26E5XQqxNsaFEW4JF3oYlAj8oAJQ/cZN7Dugx05jg1Jq2jV7MgV9eaUgV6oXUcssVr8r2lQW1sQow2QEwJDmJgof91Q80GzDdMAz5vcP9B9LZ/1U9fx8LmGIi8ld7bO4FsaM4ZZc7LffggngSrgDYIhoXV7vP3soRzJXxY7HxoooTEyLGnOOUjuLS2iQWsZtNcFDzQhE8qVhc5Brrt8ivE8JXSsJpeFwImjmNh5E1ZV56KaWw2Ihyc2VPor3CuIWGms5wsqkzIPcK5a45/NUxAC43cUCIQvVRV2xWgNucF/vBLPORAoZGY9ibaYgzYBwtyDiTFKQJDMX7cIN+OnMQA3829YZaASBLnkicwVHSh7CkqFfO3KDqOhawR395JfcGrVWVSi0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(356005)(41300700001)(82740400003)(36860700001)(47076005)(81166007)(36756003)(40480700001)(40460700003)(86362001)(316002)(8676002)(478600001)(4326008)(8936002)(426003)(7696005)(6666004)(70586007)(70206006)(336012)(16526019)(6916009)(5660300002)(2616005)(1076003)(2906002)(26005)(545624020)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:51:20.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ec3ab-d61e-4307-1e79-08dc185ed7e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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

These have been released now, so add them to the documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index 882d2518f8ed..3825f00ca9fe 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -16,6 +16,7 @@ Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10,
 AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
 MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
 MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
+MI300, AQUA_VANGARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
 AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
 AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
 AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
@@ -23,4 +24,5 @@ AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0
 AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
 AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
 AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
+AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3
 AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2
-- 
2.42.0

