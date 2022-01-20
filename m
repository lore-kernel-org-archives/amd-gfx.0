Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723E4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 08:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AF589E5A;
	Thu, 20 Jan 2022 08:02:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBD689E5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 08:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsqEXjMgwGA9hkX49LbRz22roVcy494j8/18ukGhnCGmikVL5Uw6nQMvYr3N4Igi/UdazjCEbh54k23ai7PT33A7WkaZW5L26HZ0nRE21B4VqeNxKj/dKs2N9t/2F3zr4HmjsNYFvmlz1JAtn0fgotuNaQzyY1H50+Bnk3sFodo0IEVNG4Ws12qL0dqQnwUzd8CpqsUevKYZtycF/oyG/bxLlaP2rhQ4yCchKXI2Skd+fn1J5IQ4dV1vEHNc8j9h5whuhts120yhGkstsezirzTW5w9e4uuUcTvPgGURWns+bYqU3rDwFAhNx1Asn7QsXC6tB2li0TWR6Y+0FZUy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L/5sH+sjOfaixVtOinlP/jeewI9ioUKhZEhPFO9zh0=;
 b=DA9FK0Ee29fWQL3j98/yiiESoom+/4mBNUgFA4rnjzk4lP9c2qM9yoYJ4Jl6lKqtC/w7Iv6g3glShrJRF5OdI6RQobppIqQrRJRMrB3SuDBulM3gcB2NnqffuXuVJ8+7LJMcFz7jINXIM8o4fochMTZz+aGr21VtMMktqIsRObGZXwOAyLqckZKaH5PoSQCVW2cYr7eyQz7ok7NEJItKWXazEx6e4rPmI46IrCocmLeGpzHYiqGr5re2VoTUHOQehtCQrDYXBeoUhoQDtdtYbiz7RCPvQy1CX0VecmmNrHMcUwiHDI05/+Lf4A/1Om+U7JKHQe46vPy6XUlgsDcAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L/5sH+sjOfaixVtOinlP/jeewI9ioUKhZEhPFO9zh0=;
 b=qrgpYDZ8kfdhiKV8IvQvZP/45TydmVq4X7tbyMGzQX78exoNcjn3BqJWnIhMYAbRmqM+ciZuOUD+APikQLUtCOATU7LQEEOcfA6syUIkPwkqLbJfofCNkvxd+2l4UbmMWQGcTDfg+tBuuA+qLEcu/sFYpoxUkQoqtoQWIr+o1go=
Received: from MWHPR10CA0012.namprd10.prod.outlook.com (2603:10b6:301::22) by
 BN8PR12MB3425.namprd12.prod.outlook.com (2603:10b6:408:61::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Thu, 20 Jan 2022 08:02:39 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::e1) by MWHPR10CA0012.outlook.office365.com
 (2603:10b6:301::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 08:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 08:02:39 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 02:02:36 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/admgpu: fix the page fault caused by uninitialized
 variables
Date: Thu, 20 Jan 2022 16:02:20 +0800
Message-ID: <20220120080220.27663-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30bdfc49-5180-42d2-875d-08d9dbeb3a8b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3425:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3425F5C00DCFFAFB467203DFF15A9@BN8PR12MB3425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56XqurrOjvd4tnl2nsONtaKRR3HYnDWVm4EV4nkXcQTMyLsqbytWNE8QIGzn+YKDjjdVGbmvko0ec7l5KrdYRXGKu49g4+ktI+R/p+fhO8k18ilufaIk4UyM0Vo5RUK/qz3Ot1i5MfkdUqDnnmTGuF2VZyBE+3Y02NbDcUYPEmaec8uallCaU2XHlqcYkeM7ZFCD+g6/G6sM7LmKKZ91YZI86q75Al1TfUunxGWIdF4W/JftYn2c56t07nm8noiIs54Rdye5kRZhiV9Az7VGWWrpabwh73oOq5++uUhPHFubTF+x0+IHJRC5JjP5eFllil3LE2eMCQ9TJm2BlVUZI+6EM7ir7RKPqAlZ+1tRg+JsXs5d07Eh4GNVnG/wktacJV94YDEjI2TzR0fYgOWpqsvyc//ObQhS1DqVUfTB6d54Sez4pdOEKrYsO6w1jvcFr4ZZhc4ZwHVtdxMAHHS3bwKiEZNbWcxu1PnxAg5yIapZpTQpnmtJfFKuY1UWmcCAkew4DnQjU02Vv/iju4BCHMHJ193JifMnVo7s7N0Aj7UwetZj5YqrJ29lB3grkqwGjUpXDlNO0NVWrUCeRwuUafmXISnSW7+bouVNklesssd7FCV+y8HWKP5/n15FJ9C6D89Bu7PDXCHSnt5XqXdR0DuxyhAtbgnodIRn99RCu0hsC1AyqGPskstQ+pTckVHl24cTGTRbGkyTeNAHSHsn4uTd7xp+sDkylm2yjMhsVv0qQ1/Lq64IeonMKcyBuorlyfNKRKTmomzr4RyNhbmyWCS4bp6IxQpxt863on87+1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(47076005)(356005)(4744005)(4326008)(1076003)(2616005)(316002)(6666004)(81166007)(54906003)(86362001)(5660300002)(70206006)(70586007)(7696005)(40460700001)(2906002)(336012)(508600001)(36860700001)(8936002)(36756003)(6916009)(82310400004)(8676002)(16526019)(186003)(26005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 08:02:39.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bdfc49-5180-42d2-875d-08d9dbeb3a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3425
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
Cc: ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will fix the page fault caused by uninitialized variables.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c65d82301bca..09780a0f874a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -828,9 +828,9 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
 
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
-	struct amdgpu_bo *vram_bo;
-	uint64_t vram_gpu;
-	void *vram_ptr;
+	struct amdgpu_bo *vram_bo = NULL;
+	uint64_t vram_gpu = 0;
+	void *vram_ptr = NULL;
 
 	int ret, size = 0x100000;
 	uint8_t cptr[10];
-- 
2.17.1

