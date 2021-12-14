Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E6BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767F610E9B9;
	Tue, 14 Dec 2021 04:12:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3309F10E8BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhKPLILlQu25PMpVOZeUU5KveDXPnjmIbRuOSTlOp2oZIN0oUs2QqJkhsxdvelGi73WavEOMR9Q+Y/rnpOk8y5RKrCShV50RZXhoq/KSYYLR5+avIsqEEnzOch95Ds5fa+4Oc/5m4118jbWnQgKk781vW3BbkytIKL+cTXIyfxIQ9YY4Mk41l+uXBbfx/HfB9ccLc3SE04/bUYo8ItytGrTV1YGE1e0hjvbdC3n87AadcsO7caKs6IsS+t+IG/HFonv+LqkBBjj9qBlJwaFOHXAQg7aRQvqb5NTrXz+rvSfeMTTMy+FLu1HFHxwem+sIEEOOgqmm/RPo6k7DqzJUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlxkabxB7MLZMdPO82sg8QCdektUnsoGZvTBhsQzj4o=;
 b=k015YzDJiTyUFxV9VoMmy8yPVHQOFezjKaNQ27kDKUclviaZWtZjvSQguOD7GNC+9fo7qnzep90QRls4LjQjLcRMfKyrSPh5FG29nUWd362AfIu6ZxkjBGVg3sUTrCEyEQCeZY2FGtTz+2Zi+RnF9x5DQBP7Om2nSawL81reFqLcQPYfc9LbbUBHP0rNW+v4wJRtwXThg9sYxDJiCTNINpTg6FEWMsJN+X0IeDo6uRUMkOT4zVE9fZQUMlI1iJqjcDDfzpJB5y3sgcx429TS9TTCQNJRCaH+G/PR2EJubkRlcFi5DbNDQYp90mWhvWhnMex/RajdfCv32XhrMDNJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlxkabxB7MLZMdPO82sg8QCdektUnsoGZvTBhsQzj4o=;
 b=ywhN1VZfbtFpR8AYORk66m+gHFeMpAzFun8iYU1k5lzHKMYBV1uJK3jYvm7iKHnRSJ+T18SgSZ31MTT76ix+WYsgpZl5gMBydiA8vrvZgHW6+lHiO+C8gePk3+6qPnA6rltWt/4aL7fneMRsVhULDum4z+MrV/Lr96ByUDm3xqU=
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 04:12:42 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::47) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 04:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 04:12:42 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 22:12:39 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 12:12:14 +0800
Message-ID: <20211214041213.20120-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214041213.20120-1-Jingwen.Chen2@amd.com>
References: <20211214041213.20120-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e25c67a-6e7e-4420-5653-08d9beb7f99c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1688:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16881BE790353630F9415B70B7759@CY4PR12MB1688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVSaM4QiUknEOG2p/Fo3Qo0R3TqQ8EW1JyvJKFKW31hXsd4N3S2ye3m9F2Igb9lYs5XqtgccnterBYmTMDzuLhgKXDej9EarnDWooHbuekK0VNP1RL6tOvnB1vwsPeBCnlRp/ka3p1UToCyBBKa9hhMfXvukzuz7Sagi1B0mWo1Vk4BuaXDwDZScrVc3aObu0BYcBpC9lszt5l/qOArUtnid7c/eG4mgq8KoPMzQ1c+lL24vwE03Tt/s/n18UckQPsVCze4IJwAOQ7Cs7t1DIBtUE9+XNmi0ujxaF/DEuQ2QAOx+EPQ7L/1TVnGMWPx6sq5mhhhvqXJ4JwLW7hIHAwMC9LzHqOY1CghTRX3vize+msUZn7HfRYvOHfzoG8FDuAjlLlIwv4Vzj9FMAb1SGZ5FkjCfgCH4mTYJ/OaEsIpXAG+AaliwtxFZETdod5Gj8daKbzmBhMdHFphMRl403lLQ2lnR8PZ4M0rPMjQlhBHXSVvYT+y6HpO51sMkYPPPveLf2+ebu1APH/TVYEK0AQrgm7vmf1GjYhmHVRwJbNEl42cE5aFMMLVa2JH+EE6rhYEgtHJDsJaf76D9YV4/y3Hzrc/K2nNh/oNaLwn3rJvkZFxerDTTiUeomoPN/29DzOKo1kfg+7wf8VpYyUpTvr8vQAotCLTzL6xR1WTB/ciyvEdxsa4bdRShlbOei9HfRs37yNeb0LPQcV0gLFBpOg1NZVkpq8YMuqg5WCya2m3YE2iQpBDBeGonJxTCNMrbatm/DNdL3sE2mn1EtCni9WkC7Ppw5d0yW35ZQXx8A9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6916009)(356005)(82310400004)(47076005)(8676002)(2906002)(426003)(86362001)(8936002)(40460700001)(316002)(336012)(4326008)(70586007)(16526019)(5660300002)(186003)(81166007)(7696005)(36860700001)(508600001)(36756003)(6666004)(2616005)(54906003)(70206006)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:12:42.5388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e25c67a-6e7e-4420-5653-08d9beb7f99c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1688
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
gmc bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d696c4754bea..927cf1e68520 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,10 +992,14 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev))
+		goto skip_pin_bo;
+
 	r = amdgpu_gart_table_vram_pin(adev);
 	if (r)
 		return r;
 
+skip_pin_bo:
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..d91eb7eb0ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1717,10 +1717,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+		goto skip_pin_bo;
+
 	r = amdgpu_gart_table_vram_pin(adev);
 	if (r)
 		return r;
 
+skip_pin_bo:
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
 		return r;
-- 
2.30.2

