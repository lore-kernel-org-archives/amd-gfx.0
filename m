Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC24C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 09:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9CD6E511;
	Wed,  8 Dec 2021 09:02:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737196E511
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 09:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceY1YA35kNXBIzNaRHRLHCbtb8m856DMzo7nJGhK4Egy6njPH7mHznbSTpTgfwuMPgZKaHdvXR9HK6UmkHAwUeG44noCBQxRSZGZ0tm3cLdgY+rD2r8HcbK+3FRN22KJy6tm6THKCvhxd3vTSidJHSqMiOza3828C1CQL5LQHx1VCP4333q3k1uZfcHaijUTS99GmnnkszBcGz/8zjnfrBg7hbogbvnkKumYHJC4i9Nb2Icu/Qdan41vrwO35xWqu2De8MpI81HimsLJLcT1AOr6E1UzA35pgT5svL9iVTrfhOTJTAfWP5An5i2gg55fxH1L+BNigPoMo/gYoNN4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP6wAiUJEbsz34grOAVKKkkjE8+WyzYAAAnKx7/wEL0=;
 b=NVq57ntvd9snSZ6d6KB5DE/sY3hOZpfmo3zfUkHTYoTUUpr1qg+ZRnqdojs1XGVShiRxl3wA/IBfxqE2XDPIM/sw6whGzdvHEB2pc1ztsqawJCGeF2/SwTpUrzEG9E4s/IxTsB5MqHkDkG+NmF48QmJHNQkHu8yHgcexO/edoJs7CkQU1tZwyxb9spAxSNBr9t5cA9ybSRfS+x/OsH61vHDrRiJVtUWQLlBPnUFf7Y8kRhZb8jwNLnYRW75MmkbNpPUT8SRgWgnNrOJWfKR2WSmZ86rYfQD6WhUq7OVombSBHYXiG3zfbBTc54M2x5+iIbb3zYywwBqof3I3WXMETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP6wAiUJEbsz34grOAVKKkkjE8+WyzYAAAnKx7/wEL0=;
 b=ToxzHk3o4JIuSA1UpUaTOFl+9nidZ6f5PU2QAys1K4BKLretKXslr0jiU9x8JARi/Dy7puhWSHXzBZAIYLo6UyXlJbfJnfCZe/JN9aAM2yQsSt0Ny/d7BmshKjSetias/K0ucBqjo3ONUTtWD+ZfbXuI57PpKxA1ekMJLjivP8g=
Received: from BN6PR14CA0008.namprd14.prod.outlook.com (2603:10b6:404:79::18)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 8 Dec
 2021 08:46:27 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::ee) by BN6PR14CA0008.outlook.office365.com
 (2603:10b6:404:79::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Wed, 8 Dec 2021 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:46:26 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:46:25 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
Date: Wed, 8 Dec 2021 16:46:14 +0800
Message-ID: <20211208084615.437375-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4689516-936d-4903-b16c-08d9ba2738c5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45086F3A1A16DDF9BFBC6FFAE06F9@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLjqUWPg4PYnG63+sahMJpMQYS38NPm2tvR7L5sevzzPRZcM0otcNFW5X+Dk2a5KhTLVCzZZmmOJBycbIpf0FeoEuJEsv3MYglQuxAaIUCibXvd/KxDH5q/s4j17jDlHX1qHA6pzNdHwc81+aHzugUPMmrfKi+5R4is6bQf7wstPkOKbDuHr9OhqSJTdTiuZgsxewtL8ttb0P+uFZSXzEiFkCW6490cvyqTea5tP7mx1kXJQCGvWSYpD1p4XOVNy52msaU3viuLZz6xBGUzojBakZyrDI3q4oFsLU325xyCl1B7NxcFqPU23fCGfMl4W6fDKpWz/upfNKd6VxkJY1slY7GrSDpR6ExrgjduNVCxJqX2Ul1R29jn7hJ4XEAnUCaQhY+py1s3/lCyLjbdIv3D4cZgTEG47fq82cd69xarjfzrl/cI64Fg5vcHfJZokUMk0xwOID/0LW+wyEIgjyDpZTuypq2x5ITRt51x7w+viOixWcDoJv8cOMknZPQRosF539Un2DrJpbC9gTvrmVdr2Axy68Fy3/MmTDXCXXMxF4spTmo0WFmJSqgrT0HS2tGIOILcrYG3O8eCBR3M/JLIoGoTRXegZvk/CwQ+LX6vfXZOSPKe8pUHVbqexZea92AhRmZjkE+JchZ3ZKaHRoWJUgEfhxDKf2p0ponUGQe552jX2qndJEDDRD5HO4VZTn/izJX6f/ypZLh0jMTmpJvWt64kBVGTu+x+m5YsOP4fVQDp46BcHJJBNj6V4oIvZvIBdeBNc2zuy3B0kkBiiKwqN32Rhx/8c9RVvVhs8Z4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(47076005)(36756003)(6916009)(508600001)(83380400001)(40460700001)(7696005)(6666004)(2906002)(70586007)(1076003)(82310400004)(336012)(70206006)(36860700001)(2616005)(426003)(81166007)(26005)(16526019)(186003)(356005)(8676002)(8936002)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:46:26.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4689516-936d-4903-b16c-08d9ba2738c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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

Guest OS will setup VCN instance 1 which is disabled as an enabled instance.
This will cause VCN ib ring test failure during modprobe.

Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2658414c503d..2323815ac32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -293,6 +293,9 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
 		return true;
 
+	if (amdgpu_sriov_vf(adev))
+		revision |= adev->vcn.sriov_config[vcn_instance] << 6;
+
 	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
 		ret = true;
 	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
-- 
2.25.1

