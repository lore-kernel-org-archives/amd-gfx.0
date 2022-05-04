Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E0C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 15:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C1310E515;
	Wed,  4 May 2022 15:04:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BEA10E821
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 15:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2UQJZwJLQ+7H4bKSRnIbiA14N+q5ixsrzRavevJIcsfz5Xge6+kYmL4376PlbCfSK+nA/xo3Pihrtf2Mt0FrV/2UaHqOx1fK1TYi0tfwfjMcUOJAUfzAE4mvSOlodeqBSiphderez9mm3cFGvSPO0YjT/FvMRfkAvkETBWoJF/z1ObxWcjbWfIZMZHSQ2l34SDUyWBBVJ7xiLdBsEulQILobraM53Em6+iXN8ti2YexshMUJG63e7CyEayButq68xDClom4+APf+M18A0ga73sdWDbF2yjUrOlEEGH2kEVgm7LrqM1DvpBjZxGlhtYpyKjuajuddR6mjy6LIshwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DMIV09oJrgFWSAmnTec72Eb7stCNrIOgVSBXpnPpz4=;
 b=PXAoeU1oAEllygIH4qQacG4lf6cZc7y9iZcLMigt4aiY9Rcr9hIr3lU8IgkGKCd5Gqenb40+rhEmEOtAZJWObv2/sx/lcifqhF/Ul/B8qD3wxw4d3CV+iF2oGl8MC2NofRXtWfqIZa3ea/sxo4LrcGUS+N61LPCmEnl33SGcHGNR+hda43l+pLobmRtYjFpsG7QuxxPSYiKFjKIGwCd1FWv97ML6CrHR7adnhPueEawj/x7UsUEAofpCEHXcCJisoQXtVGnDJH5hgCp5mhWbau98Lm0fvTBVRXQ4qMCqpFzBchDNPKUFzdhtlgKgqCm4foOBEaIZYPrO+cQw9/61KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DMIV09oJrgFWSAmnTec72Eb7stCNrIOgVSBXpnPpz4=;
 b=Pyt4DbvFa5SK684usaI++FFtOp07+00Su4WGhgelsUeaYgYhbdoV2Q6xJ+Denjx5n8ljhrykIEbuiZsh7ETb+cFYpcFMdKuOSvGa8liWnkDGdqiRcIgN+T+YsLbzvTd8vLYY+HXvCs/F93LjqrYQfye9FX9nwgQTseCCnzrrn6E=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 15:04:27 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::4c) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 4 May 2022 15:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 15:04:27 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 10:04:26 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] add common vcn software ring decode.
Date: Wed, 4 May 2022 11:04:12 -0400
Message-ID: <20220504150415.667764-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaf5e283-9d34-40bc-1d8d-08da2ddf6236
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5289BBA2EC055FF6B8B6AD4DE4C39@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acqKhgecR6ibBfeSwMgzzcjH+p1NFWzHdNaCHTAA90zZzb2/ujnw+cWcie3taPiW8aBBLm3Wzu8xBUm6jAhc52pqizLCnyfaBRqwTrzuVyDsQy1Jyzj0NOkUNLAgQdVJSCPz6jccpqYb5GYfq83J92hEt7AOKwHNReUUNW/Pgs67oc6MtIXpmFU2T7Og1ogeTd9N/Daq1/IUAClHq39QDrr7Za2aTczOYrSt9Tui5fLUrDzoNjU9vHTlQXA/5u9BOGoC9pfTVl3H/PihH+T8WVdfk7KzXNTXPt+/zat3W/a62nU21QaqMtzt9B4bWvXDqdT+20wDGGnQrmTvW8/e7Q4dpgrIOBIkyvAqv7qP+7F4ruDVZ92gYTewMvavZcd9BaLpK+LzhMFlPTgjHbKg+RSgN0xo8wDQ4ghZv530Nen2naGvD2W8dRQ9ZoPCxFwkJuydMTPypblbJlkHhyBZc2i/jJe7yenE4X2M5Ke2BZmieilBgb0DszkeQFPLNwHHA+cNM0SGQJf+ndGyswP8FZOiKqriDLal8lJmiBQgjKPCy5NUR9Q0DiEQTKn2idowhZvR7QfVbszpWOUOqdXWF4JsEqn1pAgDBYUSB3zN1dPgIjOGbG5Bfn5M3dm8ILVdyu/1otgFkf9SVFjYv4+qi3cfj4ZHHlJsZNERH2OlSzVN3Wpj8C+4wlY/x6t8neKAkiSgFrpBsjDz+RvVEdcXFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(2906002)(356005)(4744005)(82310400005)(86362001)(8936002)(5660300002)(81166007)(336012)(36756003)(426003)(1076003)(6666004)(508600001)(16526019)(186003)(47076005)(8676002)(4326008)(2616005)(26005)(316002)(6916009)(40460700003)(7696005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:04:27.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf5e283-9d34-40bc-1d8d-08da2ddf6236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: add VCN_SW_RING_EMIT_FRAME_SIZE.(Suggested from Christian)

James Zhu (3):
  drm/amdgpu/vcn: add common vcn sofware ring decode
  drm/amdgpu/vcn3: replace ip based software ring decode with common vcn
    software ring decode
  drm/amdgpu/vcn4: replace ip based software ring decode with common vcn
    software ring decode

 drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 85 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h | 44 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 80 +++-------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h    | 12 ----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 20 +++---
 6 files changed, 148 insertions(+), 94 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h

-- 
2.25.1

