Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7DC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3550C61CDE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550C61CDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1DF6E9A1;
	Mon, 17 May 2021 14:39:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CA56E99E
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVdVgh/Cp50PgJZbXMz83ecOJ5Ctce67Y7tUFfSZWIBgYavOR6HfVWAd2fY8zNhJmjaNpDoOnjVqrjw0/bLMX8O/nLbNcXMvrBOIWwd3YiHpJ2M5ILQqGotWdowEQtFYmo81XXENadOM6DZGXkXBoOViGO0DzYwoLziMrUJYsKivIj3qd96w3KWlBYxfyrfCsFSnZeR8JSS3C7sbIaUTRaQAq+Sfr0NF/fMxoKHG+SdDEl0PP0sacCu146V+q/HEB2i1zKr48toTygWy92GZTWSLdWczUgevyfOl+fnfGoTx60A/mWXEHt5CvxqCzyK7KclK4ZU//R97+QlLDo0Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9MQZ29475mtfS0dHnijZoa48F9Ovi5xiGdx7Z0HTk8=;
 b=JVWCv5CjFviQHDAQZbyLXdoC5SS8tkTgFGvatDomguqlZdv54phnyQEQLQOsFYD+a045M2TkBbxux9nWxUhc5TmVkhAYD72qLxbiFPwcv8da9AHBhUQ1vXGOSfabDF/yyafRPddIs5OY8unhF7I1EwBKZwJ8cThRwYpzXiul0mTcpwGu7TOyIrEtWR0b6GT+rLptRCrPE/56YTg1g9b9E5LymsqcjMXRD6bodXdpVRO2tUg8P04hr2WEMBsqx9HYaZBKxCMhY9sVWQNw3j8JtaDP4qDExxTCSHIruMe4DFttglm//cVZk+jlPkJX5jFijGUb2w+o3i5+LSn5LzPcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9MQZ29475mtfS0dHnijZoa48F9Ovi5xiGdx7Z0HTk8=;
 b=pYlNphzarwwa9AWXTVZTB0WTalnCTxrU00nHaLfx66eL/9HaFqD2LuMpqFpT5itdYbotU2CkDBJEZMh7RdgXgpYItU9MAPpvW3fFOcdQVCAoOIzQrzJ/jamxh6GeM/a9TneNskkL7++i9j89myXtTXrepROsB62uuiJ/1PaZLzU=
Received: from DM5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:3:101::25)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 14:39:22 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::bb) by DM5PR22CA0015.outlook.office365.com
 (2603:10b6:3:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:22 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:21 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 04/10] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file soc15.c
Date: Mon, 17 May 2021 22:39:04 +0800
Message-ID: <20210517143910.2125-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ef8765-ed5f-4dfd-bfdc-08d919418fe2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4519441807E3A0340801A815F82D9@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WI9A2rbtoV3838SBHbAbFhZRhf9/PZp+xeKxf8fWusiHBeeDonJ/CYgxaqJwKeJXKKUNcugPHF99Op/f2/udMqPUeYGDHUl9XsoY79RmqwtqTcsOxNE2gm4TmA8hkctorUu0/OGd4YOQTbbKkyaU+GbfNqShHf+YXAUHmDsa0NVdINAzRJoGYHC4DkVkyNPt3trtEZXmqm9EuzHRSmaCS7UELAVqu3YrLHw6Gof/67fEcOiO7i56uT7K1/i/qCsXR8OsyLn4i0Y87UPEaQ8JWfcSwZDDpldMKf+yPJrmecQNy1If/O7c+xP8DcpnQJhyyyxufImq78Vir2CAy5ktWxV/y5fh4rnKADvY8lApCg7dUe+5yWvZM5Edld0RUK3M4thNFqA0AFJ0tDa4TD6sumjBgD9NFAUxDfHNJM7qw/2tJmhEZ7T7lnn5KF9H6supxJhfChohURDJWMwpamkWvxnJiHFFf25euruLCR4siEecFYBmF9fzplTjRPlf64mBCAAYCyNK+sAO2ASRx0a/2xFuYvCQlKzDeupQ9esCW+04nuNPYG2aud1JfdqkfdZRqvrDh2kT9qVIhw45H9ponPLlTlVu/DFM8n9aZfroT1tE78RZhbbca6GUMIc00s1PMh1UpnQIIQcRMjg2s27w2VMHvG2VFepSwQHMEwZF3GqEwOdNATMymOHuUBzdvdjG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(36840700001)(46966006)(36756003)(2616005)(83380400001)(6666004)(2906002)(426003)(336012)(478600001)(36860700001)(1076003)(7696005)(82740400003)(86362001)(356005)(316002)(5660300002)(6916009)(81166007)(186003)(47076005)(8676002)(4326008)(26005)(70586007)(70206006)(8936002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:22.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ef8765-ed5f-4dfd-bfdc-08d919418fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 080e715799d4..50f6574e1d35 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -632,7 +632,9 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 		if (entry->and_mask == 0xffffffff) {
 			tmp = entry->or_mask;
 		} else {
-			tmp = RREG32(reg);
+			tmp = (entry->hwip == GC_HWIP) ?
+				RREG32_SOC15_IP(GC, reg) : RREG32(reg);
+
 			tmp &= ~(entry->and_mask);
 			tmp |= (entry->or_mask & entry->and_mask);
 		}
@@ -643,7 +645,8 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
 			WREG32_RLC(reg, tmp);
 		else
-			WREG32(reg, tmp);
+			(entry->hwip == GC_HWIP) ?
+				WREG32_SOC15_IP(GC, reg, tmp) : WREG32(reg, tmp);
 
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
