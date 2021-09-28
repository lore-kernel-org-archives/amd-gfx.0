Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE6BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610AD61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 610AD61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F4F6E8B7;
	Tue, 28 Sep 2021 16:43:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03926E8BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6bRXavw/N96PJ7jWov7EnnialFMpu1plJ/kj/jDSkNblRAVE8B/U5NTNj2tenimcPdjw5dHPOtL9G9EvhTKt3MZ1vbaA1OAqbC9CZNdiKrxSClTp2wle8P3e/dDBslKkB6BdPuh8Pmmw6JhJYngktGMYv8NrOcQIr2XCpKDJrP147dgX+BSxs9LUh0ClAYx3DU2pz8qdoRVo5QRYZLVvOsJ6XLH4Uv9hRb3y5HfdNiiEeJa3W/gow557okWyEfQqRL4YKxITvgruevSNhxaghTQRB5+W2LgMKtRBedywD9Lqv/FyV7sFbQkFlQAtkhzIv6PDOAZzQsAkVKSwbPB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Z2mNAory5UQ5PZ9OrnXmCgmbylMRfjUgcX39z5Jf6d4=;
 b=juH0aKfNnKLbAj2KP5GqdIJQtwUd2sByaDZVIvpZy47ZUT8/Vp9HMa1NpjeA3URQBEPi+IydGYBzjdmM306FeP3aJSkU69MpYpEGZKLECC/YQFQvTeE0XiFtvBOPqXlj9gNxWw0PY5+SzBRcYOcWfTSd9RrRfFIZEIQTxqeUQYM1y1ErdNQpQbjGv4vMQpI2sn8M3ezjltXbW15WIGNIQeg9uBhCCwzuVWDG1/Lvip1vUcYdAq8dVcyoNwX2r5dxHKnZSk72fPHVfuEsR68g42AZUR03qk1XYqZPdYmsMQIe4ZMy4U6Pui6sR53D4VdNgPeg6yzZtbrSi9HWy1suvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2mNAory5UQ5PZ9OrnXmCgmbylMRfjUgcX39z5Jf6d4=;
 b=j1lXBSWOy3oOH0mzyn3qMckNni67JPL3VhKnJZgYnkhlykYjMKAyYk9FZUp7hN/siMOZmHDjGptfkNvEa6J9p28IvWhzGmmfVZ7dlNjsqaDzA40aajJkFEm60QQ7jIjeGps9G9ezGVWLdzBIxcLJQuwyseCpYwS2qV/25Zmji6A=
Received: from DM5PR07CA0123.namprd07.prod.outlook.com (2603:10b6:3:13e::13)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:43:42 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::81) by DM5PR07CA0123.outlook.office365.com
 (2603:10b6:3:13e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 11/64] drm/amdgpu: filter out radeon PCI device IDs
Date: Tue, 28 Sep 2021 12:41:44 -0400
Message-ID: <20210928164237.833132-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e8f9d0-afba-4594-6654-08d9829f2131
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2636B1B84C9EDF8B11B3F1F5F7A89@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRI32bhCwXA51lH84mTLJS351Obsu0p3jMJLmIo0kfOx8f+xqP1cVY1PcN08d/fXnaqH3j3DlpAlc/dfcwvFmq+6sdgimQa6KfFJQr8I2+XNdkfeVfPldrS7CsrPxWs1rj5+XFTkNTDN3zlEGlblwBiGoQ+DPJUxEt0iObxlgjyR4P3vnHKGhvnmGTrDo11cwM1B5R6TThcIXAEPkher3+euPV/4+GCSq5hl12uIh83Hl27WEAkGQLArp/TpytBYcdhgHezUoSmhpwezbeck/PWPAZIRQbZHpYco1BqfSvlw19IRYPX05Uhxm295+yes5S6sFdxuWCKLWm2PbFU9uEovd+NZrjoGev4TZsv7QvVo33WmivX+MmI5FiIBxeNSdpfmwlfagjpMGKrUqTNp3nhYyb74Q80iK3es73krK/XecLmlc6OINPrav+VUyjz/qfEhGtbW5e1tLXz/3WpvI96QjNYqwXmphUGhfhJOWR57XIWIKdbwJIXjohAi7XPcNIE6bXryI2EABUhfJ5xeBq5/3P5XKw8N3pFj5fqChOUqiHLXfv7oOCZbI4iXSbCWMXfVGO0pOJesqjX0bC3wgH6ea6w4bNEd6IcMgrdqkt5Nr6XVfuMw+2BAqc0SnpCC06i9EYNPeAkNSyN2t1+67iTEeOaouadXLK4Ja9x0JtgzFFEHOtFc3oZ90VE3AWApLepY4TO0vIiqDxLPclwOKOD9Y5cdQ3T2OZPvHG+tOLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(83380400001)(36860700001)(4326008)(86362001)(54906003)(81166007)(356005)(66574015)(7696005)(6916009)(5660300002)(186003)(47076005)(36756003)(8936002)(2616005)(2906002)(1076003)(8676002)(26005)(316002)(6666004)(426003)(336012)(70586007)(82310400003)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:41.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e8f9d0-afba-4594-6654-08d9829f2131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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

Once we claim all 0x1002 PCI display class devices, we will
need to filter out devices owned by radeon.

v2: rename radeon id array to make it more clear that
the devices are not supported by amdgpu.
    add r128, mach64 pci ids as well

Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 638 +++++++++++++++++++++++-
 1 file changed, 637 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b6ce53fa9b03..fdfa8adc80f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -891,6 +891,636 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/* These devices are not supported by amdgpu.
+ * They are supported by the mach64, r128, radeon drivers
+ */
+static const u16 amdgpu_unsupported_pciidlist[] = {
+	/* mach64 */
+	0x4354,
+	0x4358,
+	0x4554,
+	0x4742,
+	0x4744,
+	0x4749,
+	0x474C,
+	0x474D,
+	0x474E,
+	0x474F,
+	0x4750,
+	0x4751,
+	0x4752,
+	0x4753,
+	0x4754,
+	0x4755,
+	0x4756,
+	0x4757,
+	0x4758,
+	0x4759,
+	0x475A,
+	0x4C42,
+	0x4C44,
+	0x4C47,
+	0x4C49,
+	0x4C4D,
+	0x4C4E,
+	0x4C50,
+	0x4C51,
+	0x4C52,
+	0x4C53,
+	0x5654,
+	0x5655,
+	0x5656,
+	/* r128 */
+	0x4c45,
+	0x4c46,
+	0x4d46,
+	0x4d4c,
+	0x5041,
+	0x5042,
+	0x5043,
+	0x5044,
+	0x5045,
+	0x5046,
+	0x5047,
+	0x5048,
+	0x5049,
+	0x504A,
+	0x504B,
+	0x504C,
+	0x504D,
+	0x504E,
+	0x504F,
+	0x5050,
+	0x5051,
+	0x5052,
+	0x5053,
+	0x5054,
+	0x5055,
+	0x5056,
+	0x5057,
+	0x5058,
+	0x5245,
+	0x5246,
+	0x5247,
+	0x524b,
+	0x524c,
+	0x534d,
+	0x5446,
+	0x544C,
+	0x5452,
+	/* radeon */
+	0x3150,
+	0x3151,
+	0x3152,
+	0x3154,
+	0x3155,
+	0x3E50,
+	0x3E54,
+	0x4136,
+	0x4137,
+	0x4144,
+	0x4145,
+	0x4146,
+	0x4147,
+	0x4148,
+	0x4149,
+	0x414A,
+	0x414B,
+	0x4150,
+	0x4151,
+	0x4152,
+	0x4153,
+	0x4154,
+	0x4155,
+	0x4156,
+	0x4237,
+	0x4242,
+	0x4336,
+	0x4337,
+	0x4437,
+	0x4966,
+	0x4967,
+	0x4A48,
+	0x4A49,
+	0x4A4A,
+	0x4A4B,
+	0x4A4C,
+	0x4A4D,
+	0x4A4E,
+	0x4A4F,
+	0x4A50,
+	0x4A54,
+	0x4B48,
+	0x4B49,
+	0x4B4A,
+	0x4B4B,
+	0x4B4C,
+	0x4C57,
+	0x4C58,
+	0x4C59,
+	0x4C5A,
+	0x4C64,
+	0x4C66,
+	0x4C67,
+	0x4E44,
+	0x4E45,
+	0x4E46,
+	0x4E47,
+	0x4E48,
+	0x4E49,
+	0x4E4A,
+	0x4E4B,
+	0x4E50,
+	0x4E51,
+	0x4E52,
+	0x4E53,
+	0x4E54,
+	0x4E56,
+	0x5144,
+	0x5145,
+	0x5146,
+	0x5147,
+	0x5148,
+	0x514C,
+	0x514D,
+	0x5157,
+	0x5158,
+	0x5159,
+	0x515A,
+	0x515E,
+	0x5460,
+	0x5462,
+	0x5464,
+	0x5548,
+	0x5549,
+	0x554A,
+	0x554B,
+	0x554C,
+	0x554D,
+	0x554E,
+	0x554F,
+	0x5550,
+	0x5551,
+	0x5552,
+	0x5554,
+	0x564A,
+	0x564B,
+	0x564F,
+	0x5652,
+	0x5653,
+	0x5657,
+	0x5834,
+	0x5835,
+	0x5954,
+	0x5955,
+	0x5974,
+	0x5975,
+	0x5960,
+	0x5961,
+	0x5962,
+	0x5964,
+	0x5965,
+	0x5969,
+	0x5a41,
+	0x5a42,
+	0x5a61,
+	0x5a62,
+	0x5b60,
+	0x5b62,
+	0x5b63,
+	0x5b64,
+	0x5b65,
+	0x5c61,
+	0x5c63,
+	0x5d48,
+	0x5d49,
+	0x5d4a,
+	0x5d4c,
+	0x5d4d,
+	0x5d4e,
+	0x5d4f,
+	0x5d50,
+	0x5d52,
+	0x5d57,
+	0x5e48,
+	0x5e4a,
+	0x5e4b,
+	0x5e4c,
+	0x5e4d,
+	0x5e4f,
+	0x6700,
+	0x6701,
+	0x6702,
+	0x6703,
+	0x6704,
+	0x6705,
+	0x6706,
+	0x6707,
+	0x6708,
+	0x6709,
+	0x6718,
+	0x6719,
+	0x671c,
+	0x671d,
+	0x671f,
+	0x6720,
+	0x6721,
+	0x6722,
+	0x6723,
+	0x6724,
+	0x6725,
+	0x6726,
+	0x6727,
+	0x6728,
+	0x6729,
+	0x6738,
+	0x6739,
+	0x673e,
+	0x6740,
+	0x6741,
+	0x6742,
+	0x6743,
+	0x6744,
+	0x6745,
+	0x6746,
+	0x6747,
+	0x6748,
+	0x6749,
+	0x674A,
+	0x6750,
+	0x6751,
+	0x6758,
+	0x6759,
+	0x675B,
+	0x675D,
+	0x675F,
+	0x6760,
+	0x6761,
+	0x6762,
+	0x6763,
+	0x6764,
+	0x6765,
+	0x6766,
+	0x6767,
+	0x6768,
+	0x6770,
+	0x6771,
+	0x6772,
+	0x6778,
+	0x6779,
+	0x677B,
+	0x6840,
+	0x6841,
+	0x6842,
+	0x6843,
+	0x6849,
+	0x684C,
+	0x6850,
+	0x6858,
+	0x6859,
+	0x6880,
+	0x6888,
+	0x6889,
+	0x688A,
+	0x688C,
+	0x688D,
+	0x6898,
+	0x6899,
+	0x689b,
+	0x689c,
+	0x689d,
+	0x689e,
+	0x68a0,
+	0x68a1,
+	0x68a8,
+	0x68a9,
+	0x68b0,
+	0x68b8,
+	0x68b9,
+	0x68ba,
+	0x68be,
+	0x68bf,
+	0x68c0,
+	0x68c1,
+	0x68c7,
+	0x68c8,
+	0x68c9,
+	0x68d8,
+	0x68d9,
+	0x68da,
+	0x68de,
+	0x68e0,
+	0x68e1,
+	0x68e4,
+	0x68e5,
+	0x68e8,
+	0x68e9,
+	0x68f1,
+	0x68f2,
+	0x68f8,
+	0x68f9,
+	0x68fa,
+	0x68fe,
+	0x7100,
+	0x7101,
+	0x7102,
+	0x7103,
+	0x7104,
+	0x7105,
+	0x7106,
+	0x7108,
+	0x7109,
+	0x710A,
+	0x710B,
+	0x710C,
+	0x710E,
+	0x710F,
+	0x7140,
+	0x7141,
+	0x7142,
+	0x7143,
+	0x7144,
+	0x7145,
+	0x7146,
+	0x7147,
+	0x7149,
+	0x714A,
+	0x714B,
+	0x714C,
+	0x714D,
+	0x714E,
+	0x714F,
+	0x7151,
+	0x7152,
+	0x7153,
+	0x715E,
+	0x715F,
+	0x7180,
+	0x7181,
+	0x7183,
+	0x7186,
+	0x7187,
+	0x7188,
+	0x718A,
+	0x718B,
+	0x718C,
+	0x718D,
+	0x718F,
+	0x7193,
+	0x7196,
+	0x719B,
+	0x719F,
+	0x71C0,
+	0x71C1,
+	0x71C2,
+	0x71C3,
+	0x71C4,
+	0x71C5,
+	0x71C6,
+	0x71C7,
+	0x71CD,
+	0x71CE,
+	0x71D2,
+	0x71D4,
+	0x71D5,
+	0x71D6,
+	0x71DA,
+	0x71DE,
+	0x7200,
+	0x7210,
+	0x7211,
+	0x7240,
+	0x7243,
+	0x7244,
+	0x7245,
+	0x7246,
+	0x7247,
+	0x7248,
+	0x7249,
+	0x724A,
+	0x724B,
+	0x724C,
+	0x724D,
+	0x724E,
+	0x724F,
+	0x7280,
+	0x7281,
+	0x7283,
+	0x7284,
+	0x7287,
+	0x7288,
+	0x7289,
+	0x728B,
+	0x728C,
+	0x7290,
+	0x7291,
+	0x7293,
+	0x7297,
+	0x7834,
+	0x7835,
+	0x791e,
+	0x791f,
+	0x793f,
+	0x7941,
+	0x7942,
+	0x796c,
+	0x796d,
+	0x796e,
+	0x796f,
+	0x9400,
+	0x9401,
+	0x9402,
+	0x9403,
+	0x9405,
+	0x940A,
+	0x940B,
+	0x940F,
+	0x94A0,
+	0x94A1,
+	0x94A3,
+	0x94B1,
+	0x94B3,
+	0x94B4,
+	0x94B5,
+	0x94B9,
+	0x9440,
+	0x9441,
+	0x9442,
+	0x9443,
+	0x9444,
+	0x9446,
+	0x944A,
+	0x944B,
+	0x944C,
+	0x944E,
+	0x9450,
+	0x9452,
+	0x9456,
+	0x945A,
+	0x945B,
+	0x945E,
+	0x9460,
+	0x9462,
+	0x946A,
+	0x946B,
+	0x947A,
+	0x947B,
+	0x9480,
+	0x9487,
+	0x9488,
+	0x9489,
+	0x948A,
+	0x948F,
+	0x9490,
+	0x9491,
+	0x9495,
+	0x9498,
+	0x949C,
+	0x949E,
+	0x949F,
+	0x94C0,
+	0x94C1,
+	0x94C3,
+	0x94C4,
+	0x94C5,
+	0x94C6,
+	0x94C7,
+	0x94C8,
+	0x94C9,
+	0x94CB,
+	0x94CC,
+	0x94CD,
+	0x9500,
+	0x9501,
+	0x9504,
+	0x9505,
+	0x9506,
+	0x9507,
+	0x9508,
+	0x9509,
+	0x950F,
+	0x9511,
+	0x9515,
+	0x9517,
+	0x9519,
+	0x9540,
+	0x9541,
+	0x9542,
+	0x954E,
+	0x954F,
+	0x9552,
+	0x9553,
+	0x9555,
+	0x9557,
+	0x955f,
+	0x9580,
+	0x9581,
+	0x9583,
+	0x9586,
+	0x9587,
+	0x9588,
+	0x9589,
+	0x958A,
+	0x958B,
+	0x958C,
+	0x958D,
+	0x958E,
+	0x958F,
+	0x9590,
+	0x9591,
+	0x9593,
+	0x9595,
+	0x9596,
+	0x9597,
+	0x9598,
+	0x9599,
+	0x959B,
+	0x95C0,
+	0x95C2,
+	0x95C4,
+	0x95C5,
+	0x95C6,
+	0x95C7,
+	0x95C9,
+	0x95CC,
+	0x95CD,
+	0x95CE,
+	0x95CF,
+	0x9610,
+	0x9611,
+	0x9612,
+	0x9613,
+	0x9614,
+	0x9615,
+	0x9616,
+	0x9640,
+	0x9641,
+	0x9642,
+	0x9643,
+	0x9644,
+	0x9645,
+	0x9647,
+	0x9648,
+	0x9649,
+	0x964a,
+	0x964b,
+	0x964c,
+	0x964e,
+	0x964f,
+	0x9710,
+	0x9711,
+	0x9712,
+	0x9713,
+	0x9714,
+	0x9715,
+	0x9802,
+	0x9803,
+	0x9804,
+	0x9805,
+	0x9806,
+	0x9807,
+	0x9808,
+	0x9809,
+	0x980A,
+	0x9900,
+	0x9901,
+	0x9903,
+	0x9904,
+	0x9905,
+	0x9906,
+	0x9907,
+	0x9908,
+	0x9909,
+	0x990A,
+	0x990B,
+	0x990C,
+	0x990D,
+	0x990E,
+	0x990F,
+	0x9910,
+	0x9913,
+	0x9917,
+	0x9918,
+	0x9919,
+	0x9990,
+	0x9991,
+	0x9992,
+	0x9993,
+	0x9994,
+	0x9995,
+	0x9996,
+	0x9997,
+	0x9998,
+	0x9999,
+	0x999A,
+	0x999B,
+	0x999C,
+	0x999D,
+	0x99A0,
+	0x99A2,
+	0x99A4,
+};
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
@@ -1253,9 +1883,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	struct drm_device *ddev;
 	struct amdgpu_device *adev;
 	unsigned long flags = ent->driver_data;
-	int ret, retry = 0;
+	int ret, retry = 0, i;
 	bool supports_atomic = false;
 
+	/* skip devices which are owned by radeon */
+	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
+		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
+			return -ENODEV;
+	}
+
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.31.1

