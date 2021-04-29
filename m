Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0E66140C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E66140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDB66EDE4;
	Thu, 29 Apr 2021 10:27:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8D46EDE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMHClMe4qcZ5jQPB+xahWHvdYJcGJD9LRfWqOPMdDiOaZCk2JurPZbShWbPqiLzYPJLwcLgb4cBiTjLssIR1BB7S7zdMa5dE2tY0iSVNLJhMoFr3qOgShuqwjcmB0BEc4jt4ImzzHJ9lsWGtbZJtbB0HutjkbC2sjT/V6wnfmAM4WXOVQFf0v05uzGKGzirjzPuh7Vqby8dc9okHpyDPBEMdcirSoBn46P8+Oetq6mbImVUUP07kogBVAhPm+pXYVvrqFtKWcV8XB4Xfz7d5j3kPJ70u2cu/how1MHrJ/SodEYCwQKtcYi2glkIdiwFoCHDxuJ9yprLtMexi7qGK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27EkBODmOr1TD9TZtevIk52vJYMxt25VnZgUOq2nELc=;
 b=E5NzvnPOe0Ei6m3ohkGgTZJiHU7vsxI4zlfcPsAEw1HIidxBWZFAJkSPMQKfBHg4pUlve5udd8UygTJCEi9azwCxDFXcPZ57Ug2wPleVtc4+DB71orEac5LoC9eSRvRWOjNavxVE3HuOYfpQVRxE5siv8ij+uaro8xPhDLUySoYOkjtvNZQfb6SRMPXniM15AEbQ3LjaQzzBnso+o9vxlPacl56dBipmGAiKi2OM5oJzaKtrX679ihAF8cGM5rqy0ZMWQTG3sawjZ0fy+bB649bAM0hT+B3iKl02dCBHLCI5FwP5xpwpHd/tXibbnfs3O1zKFQ64P5jeFhb7e5MwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27EkBODmOr1TD9TZtevIk52vJYMxt25VnZgUOq2nELc=;
 b=MyjOunWBFPB8uf1Jgjmr0j0Q+cXQCedfXsAEY67c13Gb/d9KWUkjtwhg/cm7w1FG+1PYsyowqggUeLK+EEreMtqRimOr5xNFgynRbEKgzoSlA9knkKCTkuYypsAdUS6iU5cq6vJFmcUEy/Z9CwqIjoG1IGdzt9dBAa1SH/ocYVw=
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 10:27:03 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::26) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 10:27:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:02 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:01 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/12] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file soc15.c
Date: Thu, 29 Apr 2021 18:26:36 +0800
Message-ID: <20210429102644.31172-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 160f76b9-c7d2-4daf-7a8f-08d90af95497
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672EF34BD361A2CA70BE78CF85F9@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYvNSzImvFvgEX2vGvyCTggMDyofgfG3RaVf8mqqwYmlsJcdAU3KviECeA5gK3hQesOqqvgFjQER1gqE+A5KznzU+NrpwGui4ZSbop3uCEU8LpQ33Hla1KB2Uz2vuD6xJRfgTPbXh5m+QePc4MmfeEP0YSEhcfNxfRVsp8BoqYMEvKiyXpjod829a3GaBapsDmBmkyBXrl3UxI8PmjlhVoaNcdgyF6Q7smr2DKBhVFaDu+enqQ/undRYy9Twfczc2kfMwvEa7VuHjx/gh+d6/wne8zYSEEWeT4XJUvz0eS23DVgn6IFcaTAzAdWoKm9OoV//7HaaJXCyKnP/JOQtqUt2v7y7YFHeakch18Yu/IcBSP6kv9lhOWGLVE4SZwnMLh2kBrSqUqkpE7axbCpgjNBoubMuTL7+8tl3wHypljUx9+ybHlyOV9NLy9LQyDszElMfSYn8GvhmdFo4VL0fQDZEbw+OQTZDQ8Hxuhuxg6DtQeGCbCH852qJ4PF8PABPifWMhjGIe3KgD+aOsNE5jvIshydjwuIR3xjLFWGLgbKzvbK5cC0AEBwAkI/0HqTO1qvu+f2s8ygy0nV476er++lxjfWkWLY1SL5A/uIZw8Boqi5v0LhtxEnQHfllKiMLtQKGhhWgRn2TPaOC4CEm2Y1mxqWg+bLPgj4j/RJzmDzjawx08v3Q7yHALl7KD2Xb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(5660300002)(316002)(426003)(36860700001)(336012)(8676002)(82740400003)(36756003)(7696005)(82310400003)(478600001)(86362001)(4326008)(6666004)(81166007)(83380400001)(70586007)(8936002)(6916009)(1076003)(47076005)(2616005)(70206006)(2906002)(186003)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:03.1024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160f76b9-c7d2-4daf-7a8f-08d90af95497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
index d80e12b80c7e..bbd6ec2277d7 100644
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
