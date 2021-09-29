Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7610611C0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7610611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601576E1F4;
	Wed, 29 Sep 2021 09:22:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F96D6E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evz4teGZO5cg0V3SeoBA03xpVwe5sri1bpc1mBECvq7+1RVC+1OaEiDKIlAtV94X7cT/UJA3g2Niipy/2ikCVyu6IRgusonDNlMBjuZAhtVpliuwFwsJsLdJZTcnAxy4BzXpX1bkT1GQENZt780hsEdw+gj822eG9d2kXSHri0ViB8W2OoZYtG7Jmsuuz/uGNOuQThYG9Va5vmJ0fZU73/m6LMAimrVy/okE96y9GzOsbBwv1DNLZaC54KEXjlSYYkdNiRc9qK4imOv0DOScPIfVMNl82wABBcJHxb5BA3anxOVpfj6r0cpF/cKx1ZPky5vKnG1yRHwiqqAja+PwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fxj9D3Wld+1yjRgVF+eAMRGF2ELtkF9wTMxlX41foBU=;
 b=ThwAudlX2s+Fqs7+DqrWsAyA98h/6wAqojwgRbWVmdgW0odBahXpQ3IOeMAgY8Jffdan7UfjYM3xFPtyMrudC+0zHVwkaIF140ff8sreMrDo3rF1X4rT7jL+n0IDx2+CxLshCSCi/q5bnHCJT4TC67TYmYv2qnItfeZdHDAy5JMckXHjZ5+7XRsJzDa8TRCbw2l/bK86A9/oTHR4tf3LRenMdTHeqd5lcX+UC8SCUC6RX4M0yyD3hsQ6A6zbXL+5z2th3hbadVEGU3OI6XmyAuWPJ+oDhpVI80EPiP6xIOMgiWWOsIP/zJ/o1PLdOHomwsWfw7EUXMf6mZpdLh2rZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxj9D3Wld+1yjRgVF+eAMRGF2ELtkF9wTMxlX41foBU=;
 b=iSQt8CHzita1OLSpwopPTUMjXTUMA7cZy1v7p50PeT0KeqKAx7sZPZ5z1zzHO4i5D8s6LbohDo+vhEJ0zLacpjRcJ4WIZ5ckQLLDcW4bgda8wNAa37sh5XCFak0Ukrj+Q0IhfN+mGwVke0/7CisSLHk1WIiFw/9/ic0O8oZ4o9s=
Received: from MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33)
 by BN6PR1201MB0052.namprd12.prod.outlook.com (2603:10b6:405:53::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 09:22:08 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::46) by MWHPR22CA0047.outlook.office365.com
 (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 09:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 09:22:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 04:22:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 04:22:06 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Wed, 29 Sep 2021 04:22:03 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, <horace.chen@amd.com>, Tuikov Luben
 <Luben.Tuikov@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Monk
 Liu" <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang
 <Kevin1.Wang@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Do irq_fini_hw after ip_fini_early
Date: Wed, 29 Sep 2021 17:22:00 +0800
Message-ID: <20210929092200.783889-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff81c2d-61b3-4758-8766-08d9832a9c01
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0052:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0052BA7491FD94E90AD58D26E5A99@BN6PR1201MB0052.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfJ2gc2BwCZ5amoQj1MHu6p1o1FDA8UGWOTHpoRKicXnmlaI0cjPrxU3mcsk+3u9FX2I58bBt7IMOZYzd2T2VcfN0S/o++ZTEiUKsmlbUeAUyynqdsylscL0T+Ctlv0/YNVRurbe1EX8VCvvwnFJp1jKHlyMjeVLv6U3euJFIVGbwGLvhvzlj8rl5IaClCjMiZFLTKQOCQ69ZrdRWWb++3jVsg2otgTJsG0VRUKMPwSofJjWLNMIxdz/c183MEouTCLQvZ/c+MW3HQ/5fE4mHJeuWHSoAmdwGkxu2FJci3yi/T0lS2VGsz3RFJdzVIRf+EhDbkI4Na8JRh2vs5Y4F4cZrDy7Ejt1ztssuSE76CgyXY68EkyQ4gWIbAltk7Si2RWeg5i/SsdGdsfiPP4Hdgrju0D3+7sium65UdeKM/VjEIvDgLqX25kWgEHpfZgnWmaEPyWvf80157YPWz2dUJZJCTSvo+aSaKxCj6O7KSzU+8xNgYSYXlwYr85fA2CRSs+itjyQTwqjKXgQFoVC7Z9+yjr4C5Lzlwxyko/4DNy4UMl7WvVHMmhdIV+GBQTuJOsQbSi93Ce0e7N/+fK+xR3N4f2NtZYNZfrW1+RomTjOiaZzm8vj1Lzs59t3y8ssPfqjH0qJ1Nw8LXbfe9gxVVi83HNUFCaozW6fzG76OxQjdtqv8yS8m6o9+lerXbvDQ8nrcp1tpU7K8AyzzUhOt5aV4D5db1OBdrsgD+oQAl4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(8676002)(4326008)(47076005)(26005)(2906002)(186003)(4744005)(8936002)(2616005)(316002)(426003)(336012)(5660300002)(81166007)(508600001)(86362001)(36860700001)(7696005)(6916009)(83380400001)(1076003)(36756003)(54906003)(70206006)(82310400003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 09:22:07.5358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff81c2d-61b3-4758-8766-08d9832a9c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0052
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

Some IP such as SMU need irq_put to perform hw_fini.
So move irq_fini_hw after ip_fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4c8f2f4647c0..18e26a78ef82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3864,10 +3864,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_ucode_sysfs_fini(adev);
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 
-	amdgpu_irq_fini_hw(adev);
-
 	amdgpu_device_ip_fini_early(adev);
 
+	amdgpu_irq_fini_hw(adev);
+
 	ttm_device_clear_dma_mappings(&adev->mman.bdev);
 
 	amdgpu_gart_dummy_page_fini(adev);
-- 
2.25.1

