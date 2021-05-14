Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590AC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A8C61029
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A8C61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6B46EE1D;
	Fri, 14 May 2021 07:27:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3636EE1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ1JAgOFExCwcnWmqCQQ7n6C6k/ISRjNnxRfL3B1k2GfFlRPBM/aPGdP54gc3+7Wdql5vg/hDZBvYqnhDOpWbrt3qeA4RU/Mxa8rTEZW/29GshmrMhmm9w8doNS77qoDZdwZfLp+tPTO/DKnLzGIYTNTW7ckcxd95RicehCMBNYJeycIDv7Ss4pCwAX6xIHY3MIsiQRHIM+37XnnZboW5jmHV9IbjmFRqp5cvN3WHDJJ17SpuE+ytEQGfBDLV/gSAeoH7imi49Kxs0Jd1qiQTE6EWTSuYpVsuu1BH0O+vL2N2Z8LCASNYo5MoNd/sUyJW6DqnSfEsRrKW5xkJ2sWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqzabFWpPoE78fzOCtp4OYIL1YGBWzSREPsXPAl6Vws=;
 b=KXTObhCU2qoBmfO0+bFQQTryaAq6GDCZLzuyszCh6wjOULbfHd+snRB51TWzZHcOq/pB8HRvEewxyaGK53LWg9V1HItQJzVoB31dYTlM5ohfon0fBw8wA4A7r3g76e/mMRIpxj0LCJD7023gdnsotKpUPFTSy00XVTFEr+WPxQTuYE+fPYSOplbsoeW/P3aRXawb/W0puoyca7fFAyO+Jk51seSujDsOqpXnYVhHc/ykV/vRDumTB6Hiaz0VgaxeUBbFjGM4HfMYMUMGRUxSM77of1+9ENCnCDviGvcDLp+PDGEpD+K8qKX1kkJ+QxzQ0JnNukoLxjW9+DvcUi4nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqzabFWpPoE78fzOCtp4OYIL1YGBWzSREPsXPAl6Vws=;
 b=i3IaN+Llssd8GpXihI4WKLy8QhPk0dwhZJUpLMABB7IOeXCCVq0p5mpfhwIqJHQI6gOUjnR5Xu8Z+XjnwbZ+WKnxWKstRvtkoZQn47XVoJ+3PsuIieQ6HUfIo7Qr0OGa7tgeOLvRNnI0f4zLrH9MsVbQUchA0jQLgMrEL8D8IrM=
Received: from CO2PR04CA0111.namprd04.prod.outlook.com (2603:10b6:104:7::13)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:27:22 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::e0) by CO2PR04CA0111.outlook.office365.com
 (2603:10b6:104:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:21 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:20 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 07/16] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file soc15.c
Date: Fri, 14 May 2021 15:26:57 +0800
Message-ID: <20210514072706.4264-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd0be93-3e85-4538-9aa3-08d916a9b6c3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23978ADE743DAAD80D039EDBF8509@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LT1O9S9FGTMs7PDNiTjEM+QIfcx4IAK+GQM2fuoDS7MlzRl3yiwU3Bht6Lhl3IzLdM8/z/gm3EsR99pporIVk57bnyEzliliCBVL/UAb5M3AOMjnhbs1NKk5AJqtCg4+oeBqYZA4TzM3SJnPouWE/v+1GXHwVV64REZY+9WLrAjo+K1opSJd+Y8ifiIP/6ctnqXn9cCQl3gE59vpcKgge1ObEmo1QOdBthDvA7gvqTlePGrJumrrZqXmWKelcexvyu9q6QmUSuNN6B/42PA8LKOUl78EJUUq8hQh6etQNaLs74KN3I8G3j0YahX+OYUJOyaQFXmsigggnPAO0MN9ugTO2Wv7/+nPfoN2hZUP7aYmrkmi65T0ya0ylMEenSCML2doVMr0LKM2IIpJun5WjeBe3yi2z6djA3xHP+DFTX1bJreERoJFMnYlcq9qaB45wACYEutksAggtDMESCXYwt+6LzPQ47T5RlPPHKUlhXEo6sRng8q5hpJXay2k3wRVZLM6Yz9NHDZTJIC+fbyVn3VAfA9GzD+al/B5rqH2UDNbMXsUiHjRZjpEIbb5V3nM/TAfZ6EUaH5B/1CCbdwALfgEWS/ht/kTv+ZbDGmNNf9vjMHhl4dlGzsIMO6lLq+NZWnbEj76tsC1286gQIBTvJKIXk3wYXn+S4see6itEZeLqJeN0z0MYEe3vedWjqGZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(26005)(478600001)(47076005)(1076003)(82740400003)(2616005)(8676002)(316002)(7696005)(4326008)(36860700001)(6666004)(8936002)(336012)(81166007)(356005)(70586007)(83380400001)(2906002)(70206006)(82310400003)(36756003)(86362001)(426003)(186003)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:21.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd0be93-3e85-4538-9aa3-08d916a9b6c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
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
index 28e9f6b726a6..e1c5dfd1d771 100644
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
