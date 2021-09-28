Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E23C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D276101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41D276101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21E86E8BB;
	Tue, 28 Sep 2021 16:43:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C036E8BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfswPsgCVmKnJ2CkvJYV5BYy8sRR/g6ENOJGCmx1YBxVH8iyLtkktlQenzvODmDvSs5yXnuqIYQMD/Kqx4i76PCqnmH3W9AAkR8cHKNVHb19XFvtn4EPctjjCwlTUiekkJVW7apaTDLaW6h2m9k2PjUv98GZjJ6YW+kUegBf/mFKvyMqV4nnW+My+dxLKoWzb9yXtS1IWyka8OF/LEOWTH2iLOV1Sia2BNgmzb14WGt+n/24zD9dcsxfmktrnQQVjZ7fr5r0vTVX825vPfaCV+riFL03/q1Cc2kOR8j1iGSGJIMVMhIwiiR3eolMgOmeNhKI3xETXzUSmgvlldV0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Efia/eu+b2eTCrBl+Gp2XdRe5WjlrrLuVW46B3+WC04=;
 b=EtlcVqC+HvL++hF6FaQ5MoT/nprwDqgat2ThiMB3CPRQm4Jo9UG7JPGbmQdHVqpPQjrrfp6FUgpnadB3Ja2Q2uGjnh635K6NeuiTa/djN+zUUAPzOQFCcu0EPeCsRzgBB4SxMq0wr0Ps22pQc8ghSSBnF42EDeB1v4TBWKPgK60zkz1j+8aj60w27QfjYLn+2mBOsnmLTvLtaW8mxRj9s1kMi1gVOzfg3+QEbH/Kd8kocVj4C/Ka/d3g3XJLaIxBOueqUsiw8L+grgJ4ygkcWj0sAgXdWKoxk/6lK775maU7HHlGNtJHHcFyki5BTQdh492f/+cz3pPlQMe2YA3ntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efia/eu+b2eTCrBl+Gp2XdRe5WjlrrLuVW46B3+WC04=;
 b=NlP6/o4dGyKwiJ0SolJ80iowLaXcdSU1IsdP7ySMvV6eJnp2qoVap6BCEx3hGZcvpDo8S0ZR01S4fGLpEhC4t4PM6F97w3pZSebKb7g3iZkaTubYR8uN4YcxuZPO73Zx4Nl2rKm6R2vbHivH5aQE8WxF+H8tkPfxCflDDRqG3cg=
Received: from DM5PR04CA0031.namprd04.prod.outlook.com (2603:10b6:3:12b::17)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 28 Sep
 2021 16:43:45 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::8f) by DM5PR04CA0031.outlook.office365.com
 (2603:10b6:3:12b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 12/64] drm/amdgpu: bind to any 0x1002 PCI diplay class device
Date: Tue, 28 Sep 2021 12:41:45 -0400
Message-ID: <20210928164237.833132-13-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3295011-81e0-438f-d584-08d9829f2359
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49105067A0F01788A33481E6F7A89@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cikDsviy3TXlq4D4CsAsaKXdRjqcVJBHmh/4+nitPKoJA8FyiWETchl85/mPwvPTkgiKdFR3HYLiz92xm5kE6hgPW84mi61Cho3L5T49+O8w4nzgctIcPzrKiF1v+b2ml+2qUoYh/oKl7KA6trcrJ1VfVbfLfdDWGMTFlq6jp9sZKboitDLMka595eRywa9D3PYSHnqh2ngLIr+JPEUu6C+5hmJhvY769IxGhtzLWIlVccN7BWTyVWbZFyYDl83UDcBMgIasZ6vNc3ge8GD6VLKeSn/sN8oi88Qk+M2abfcuflyL2afLGy1k0eODIIbzIvhAUROzf72ckRE+pIJYTI+LK7APZRyNVV5dNcjU9lIu2v5q411S6qv6x8smX7gIE+ZK/ASJDjP4BadFdaR822F6Ch4STKmtwt+rPGVe2iOBGk+IEUWb1Q+osiFLsrWfTa89UT9wIaTjfE5LWkW660Z7ceJU/hzi6DuLCrN4sNyycjYhBrFX8XGW++Mlj1NfFceEdS4U9uWVgiVmgsWraxzYxHYSjN0z/9j+lRnXkTr5SpXbBTLBmycRS77he4RcNUGJP3kSw6hUIFBG1KsKHZ1pWnEeo6tK4HQYz0a5spEjpoHicEp5W7yncFnbmKrV6CUu7KDsBuTBHTVuQPeikYWdeUItANXot8bgzz+2xfvNU67XZr+KD/sVDDNYHbz0+FEkF2SQBCauJ6Yq5uvr+LwWIjT39Y5qHew8mDnql4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(316002)(16526019)(82310400003)(86362001)(7696005)(54906003)(6916009)(186003)(2906002)(36756003)(70586007)(336012)(508600001)(4326008)(8936002)(26005)(356005)(47076005)(426003)(8676002)(81166007)(5660300002)(70206006)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:45.3407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3295011-81e0-438f-d584-08d9829f2359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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

Bind to all 0x1002 GPU devices.

For now we explicitly return -ENODEV for generic bindings.
Remove this check once IP discovery based checking is in place.

v2: rebase (Alex)

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index fdfa8adc80f8..8953cd430506 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1870,6 +1870,16 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = PCI_CLASS_DISPLAY_VGA << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = 0 },
+
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = PCI_CLASS_DISPLAY_OTHER << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = 0 },
+
 	{0, 0, 0}
 };
 
@@ -1892,6 +1902,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
+	if (flags == 0) {
+		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
+		return -ENODEV;
+	}
+
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.31.1

