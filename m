Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA8C77B62
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071F110EC63;
	Wed, 29 Mar 2023 20:26:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD48410EC5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRvqUc9dKVP0wdFdFm4ptbpkfgwwnf/KvoD4hBol+3mvJKVO4Kzz/LydFWwyNaI+MX2PNyZdTVOztMOpcrlsWUNVwzcSt4k3DVspyHVITO5e8Ioh5A67Ej8VIHYHcY+6rFtRNmv/7CnbTpThr6cn82WmfpwhWNxyjw2QXQ27AJS4CCrGcf2xxLYfP2v9yEVy5QxnTgjDQnOvzns8FHufDS5SFYhwoiVD2X+Bhe8rW0TEt2w8zgURi54w8yxGA6ODX1oJCvRdFgikwJeboa1f2GGNtJu7kpPrd5Wyr2SBBsnkVvr573AI8yOGhtRfcbbrT1tUAbhPRl0plPboV1VyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls1hwivCgOQVQ1QFxeh+KJJilV8/+R+kGMHW/j/JGbs=;
 b=amPBhGP1rA988XBiBUDeROyoVxijCiaS06dXPZ25o29H/spNgzhp9pwAsiusZrdDSSJ6OmSD81p+rQgb2I9kfv2MD5j7BtaG3k7pf+cf6TibmskV/OE7EiY2ZGrZ406cZLcoQuPvMlICiw8D2RIcn7xcadUz8HeVP794XXNXBEcNVK+BgsBPihnXSL8qKa4zj1AnitNZc+oe8bSneybXVp0ahR1B8IC8LAcsitqh5/R9S/gST6rzLKV9zRCqXbG5Pqz1IPkZcfN9mfF4voZm4I931c/JSuD8gBPl/HFvguZa74vGn7ZHFx01jrenQaXrJtlRLws4SUc3OJi9kzcwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls1hwivCgOQVQ1QFxeh+KJJilV8/+R+kGMHW/j/JGbs=;
 b=zjBVASUd1tJIUmA/NP5TbpMnulKCnF2mdksvFC6RPnO53+0twXp3I4bLiN0/C8wE5YC3rukhjbJcM9wgsuCkEJnJsOJh1j4ff48kke8B3nBKopMZbsi/XarJe5bTnSIqXP6xT0sZto0I92CKAz8YNW1Kju2kBH5YQhRSiu7TiZQ=
Received: from DS7PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:3bb::15)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:26:07 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::72) by DS7PR03CA0070.outlook.office365.com
 (2603:10b6:5:3bb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdgpu: init gfx_v9_4_3 external_rev_id
Date: Wed, 29 Mar 2023 16:25:45 -0400
Message-ID: <20230329202548.1983334-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DM4PR12MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 903af97f-6a50-4bcf-4ffd-08db3093d3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9ehhoOvVsq6s3RjsoU1kXn1ondH8G8FpWIE/0EK2OODYPEpgLBl33OGV+OR0RnU9rAZzgNeSbdIhcVQgFdnRcBt+gV9qboyL7MyCqp0bVFmO4EHqD8QDU5u6KBIXSPBzfWCHoXDuMaHOUiKSHczoMcJ2YE5m9pHL3L61uHQoMG+PSh7wEATzccCvaQ0++ocMTA6OfBvxjLrzBn0+ylTliAp6oxqVkmLiEq8qEJWhT3KyjgfuhgugFOh3gFf9on3tLo3JqgzeKzXqANjMRxn8fouDDwuMXW9EEycSFBomMcqfRqgzfZTd51/8cbJd7Ln+c7OQ1eKApoejh4gIfqCEvCH0WQKH6EwIw3Xic/FpT6To5UFXT3dh6NZT+/tp8UPd5zE0msVedyM7XxyYZ0/gInEF7MY8hDMRnfxmZmnZHq4bVZTwLxQBHNwK8gIWRHFvWozvcgKgOvCloez61wxQdagyudqnR3Mel1JG9L5aB+XDvo9HtMpAx8raPF1aOJOeRSE+iaQIPrIYZJzlezxudJGu7v3lfW6HGDEFAkW1X6/rvRhDdTFm4VO7mOXGOP1wOvdxKwjJGbFZqOAXQear4Dr4ZYt6++6kBftDVzF20yaKsjyiZFvZgIxKLbq2xBN7bqNf/VkosIqyDgUt++keOKqWAjIJb1OXn8aEzksKg/P2gYFeFP4RY52MX+MLNAxNjfPtVSLUhwtfRL7nygB4GOlrphfLCObUWGih4tfXaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(1076003)(26005)(6916009)(54906003)(316002)(478600001)(186003)(16526019)(47076005)(36860700001)(70586007)(70206006)(336012)(8676002)(2616005)(426003)(41300700001)(81166007)(5660300002)(4326008)(356005)(2906002)(4744005)(82740400003)(40460700003)(8936002)(86362001)(40480700001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:07.3066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903af97f-6a50-4bcf-4ffd-08db3093d3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

it is used for user space driver to identify gfx_v9_4_3 chip

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 76c159f90775..3838c82f105a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1135,6 +1135,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
+		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.39.2

