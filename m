Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4140C60EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4140C60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538FF89D57;
	Tue, 12 Oct 2021 15:53:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617FF89C59
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 15:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoLB55saj8p5w9hyi2fL1NNAMf/Z9+0lsWh68wMleC49SZcRWUSLIYlNvHjxVBMpidI8pnw0uU1e5jprytlx+34wV23kEFRjT2qDCr46Co8HdqH2pLxvhcCFhjLGG3g/qdztdL7yB2Om6445t3Vn1cylYkQCu48/JkQZsiWPnA/kvBFJogReN193+S+0evQXwbeiUg7BgkYVmETXI/QSqr3veKp8spJ6PboAp6mZK9W7poUQVlsvi/VAA4+mZ0BodpopYWwwMri+EG7I/btjJVzMaKAQqSA4WQmd3AKjkYkGF2GgBJNHU5Tn8DFfFcaz7ksk0TS8BXEghnfq7c9BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9qlWTQADCTBwkENzJQBn4JlXBNtH05UwiFHuQnrzL0=;
 b=WXVVi7U/PAT3e+2jzlRi+rnyhxkhEB1x2tLAAdWiDYESok0VUuorw1wNZ2DBF7zHaliYaa/4wq5QCDmnL2KDjozg8vTfstAAfWdmIIM48QwIGuRTkVTQW4c9lukrEb0xXlzYxrN0XukoA7oeCGwC+2J6mThCx3uSyeuMnToRIMleeKdOMIDeza7L5t/RGpPtuFmObBfLoD1PiBqG85aTtsnHd4/E88/cpDV3VFvxjmDSKXIkS658DTsUB8YTyJJs7Xli71u5DlyeK1WUjW+ioTiRZS1cwIgw4Rgurd+QM7NP8vDMdIszhYQpohpgSyltfstz+PU8UyUC32GqZkoBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9qlWTQADCTBwkENzJQBn4JlXBNtH05UwiFHuQnrzL0=;
 b=tDqx1gEoWx075AIvvsABCVgkt1nFJ6pJFa4wP9GXKPx/mol9cBotAUZ2Pr0OvR3zpjhPjtZ9fNrmrXRK0GwQNn8xFKd46GPXwCIn36kEwg8ROLFE9DsknFjJ6cUnoVh3igzL8gAFd+3AzfC1Of4ZIGBTqEdffB1cfRdFi6V5/kg=
Received: from BN6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:404:121::16)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 15:53:35 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::fc) by BN6PR18CA0006.outlook.office365.com
 (2603:10b6:404:121::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Tue, 12 Oct 2021 15:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 15:53:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 10:53:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/swsmu: fix is_support_sw_smu() for VEGA20
Date: Tue, 12 Oct 2021 11:53:06 -0400
Message-ID: <20211012155307.1059170-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012155307.1059170-1-alexander.deucher@amd.com>
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe351b1-29aa-44b2-a416-08d98d9872c4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080391966F5A758EC88305AF7B69@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMNuxjbHoehKLjhpIg2VScdVqKEa/5+2hvicwUNDauw03upt7fVw+rH99oxHfthD53hcfc4vD7MM2V/oeyQucAOYZFgPrWwE1kIpbblVYO1qJSvBHxGxHPOzj/sF52GBrPV010sP89NFbAsKe/4w8Cw/JNcHsaksEQmYzF2mjJoMe9loV6JqXuoiHrP4+0V7PDfCwJ2uJsjksTgjKysy3mbXEVOqE1bgnTJyABx5RLGkXzKP6goC25PgfKtNuFYxLp+EUhkXDTOXsIXy9gm5eLWvlpr8k0cPI+gMuVbHmdMewqQCX5QZX7IUyAE0Teeah7Qk8nvDM0PZDEkxq5nH5XB6Fy0eDWp0WVIlXfX2d4KslPbDrD7QLmfa5YbJAYSv9SIbagb6UD3PLG/u8MQ3MSzop20n5V6qlDBR+Zzf+QNVklZHh4FRWMV2+CV2FmZDIdkWZ8Wf9zK6jQbfPt6RjCBfwcwKC6xS/j9tNnJ1YqzH3amrq3cEiZqaVRErOvhWXMcamqYlLtoU51/KdHrBpZjv+ticjS9LrvUK4luXKVhApOd7o5LQceYxvsu5+gjt1jZp9koDUIryeRgMrfUY1sv/JtVeecEyZbqFYrxNnCNtDqjjl/TXmGQRVrTjALUmS+dWSWjT6sYbKiLGumLYjwBjUpeGMIaHRe1tGC7t4r3npbR6+Z4tVKz9YctpJCw8isIjXlCo6+PSAR26zeT52n4nINK2rNltKKDGCCyoPRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(1076003)(16526019)(8676002)(70586007)(7696005)(86362001)(26005)(186003)(6916009)(336012)(426003)(47076005)(81166007)(36860700001)(2906002)(82310400003)(5660300002)(4744005)(6666004)(316002)(36756003)(4326008)(70206006)(508600001)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 15:53:34.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe351b1-29aa-44b2-a416-08d98d9872c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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

VEGA20 is 11.0.2, but it's handled by powerplay, not
swsmu.

Fixes: a8967967f6a554 ("drm/amdgpu/amdgpu_smu: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4ea7e90ef60d..f5bf3ab0ebad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -455,6 +455,10 @@ static int smu_get_power_num_states(void *handle,
 
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
+	/* vega20 is 11.0.2, but it's supported via the powerplay code */
+	if (adev->asic_type == CHIP_VEGA20)
+		return false;
+
 	if (adev->ip_versions[MP1_HWIP][0] >= IP_VERSION(11, 0, 0))
 		return true;
 
-- 
2.31.1

