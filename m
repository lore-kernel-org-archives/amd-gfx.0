Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BCDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E76D10E8BF;
	Tue, 14 Dec 2021 04:18:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A1210E8BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbGhhiwS3POnc5ZJB8IdGBtsB/mDPMQUrzKdQ/9VnxqjeAHIps7wBPHLn8k1q+3Z6ohYL5GhyDWDo8/qB0+/HeBomTApmuBmzu37alUplNKHPLbGju5ibpVHXrcfqUFCmvCOTQmb86mox9ukBiV4cx504NbPZKxdpve53gVjoSSybKgqvKsdO+S0Hso6AwmQsZAMlrxEj/1lpxdm+3VlpYtKv//1rDQGvuyrLtKMnl4pqK6cw/iYMpQYG9tlpyd+PPr4pILYSF8ATvz0sRQdYxF3orIDcxKWdESBp929DUGOzBCt/87qf4WjGxV0dRIu+5qz2bv4aPpgPHC3OZHzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bWFDXdD+i+IEdtZYixvybLtE04QUDW+OldeUOPJEmg=;
 b=lGEg3eZcBfcI/QMHeAZZcOW2H5Tb30BF/VmttWMbhJAEHwiDAZI/PuCh/TshlwtnQQPGoq3Xw2VL7U74feXbnOZYQsxDFmMMSFHV84ughLWvxwcZKiMHFgIsqtKBmB3ME4RQewgzHwBY/yJ0+J2QR9Mx60xN95F7EbSh3tzwFQWXTL2yqHkEQwlp6x04Mr+/Ccz4uPkwvekOPScB/crKWXiBbpt027sP8497oxp2KDkXsNnMVEAsLi5SvSdh8R6JHCfmbdQQNB28hm+IuhmwpbShWFJdzbJKO+c8esxMRbTQClltO/TxO4sExCwelf8HpY6UBHCJ6CJe5plzT6IcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bWFDXdD+i+IEdtZYixvybLtE04QUDW+OldeUOPJEmg=;
 b=HHa75pWpZ84uuHOoy5C6KrIKUaUj1hRRyymtog8s7xxzU5lTrkXSxynVbchLxR1pGV+uwJuDoNl5sM9+rOqdQaEyQuMdJFclu9xA89/DasAD0XLMxAph4ynyOET/POv9OGjhKnvNi0t2YvaHk5iN2xKTtZXHiR7nfjcWUjGq0dg=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by BYAPR12MB2648.namprd12.prod.outlook.com (2603:10b6:a03:69::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 04:18:22 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::ba) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 04:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 04:18:22 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 22:18:20 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 12:17:51 +0800
Message-ID: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc34d919-0ced-4523-c785-08d9beb8c444
X-MS-TrafficTypeDiagnostic: BYAPR12MB2648:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26488F40DF3E568DA6B0F504B7759@BYAPR12MB2648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC1qKkD0qvTG+sdfAlHM+ketBYyT62SHLOvdifY1JUmjLgiv02xKVAmuebAbOwo17RuuGRsB7PlhNuXCl2HZqP02Mw2cyI5fHoeGtS+4lgi4m0+kwzkB68wWy+87OakseYnyDFSKG1OaMBw42fnbUzqB03f1kU/o9TtNmM17FvHmdqrQvBB4ExkOnDQ5MfFM5rg1HSg6YLqo34mihywXboAbFi2dCa9VXmqoOeJainFtoaCalqtEwJkds6kOyR7App7LpF4fFhRAXbXt9nupMzRpuf4ZlUPk3/Qzt/2hA2wM3YB/fmit6NeAULG+OZBXPtrUSpwmIkcbzEZ7oKJ9NIPszFaSunFKkGqGMOOZMa9PbB3llK5ZI3zHZD1y8FzDJAi2WyHiW2x5+Lw7JlOdEH0+q4ycRziTKjSSfzQneWLk/Y6zabyEBQx5EHENJrQ7XMYIu/QvidvPFNEUmP0eAoy0tw5pUlEZGvTaRiWRWaMz1BX5iacRiAdba9exgfQzw7qctFDrQREtq0X305h5ky0daoLM5M8XgHawHrcacmWc+EZi+1LKNSTin2Ap4F/ivhiuRwwnTRGEJrhb83cqbMIxNz0e+n0tOnFo+tS8PjEwms10kcRQeuh+4RokvuP3WUT52h6v+/0YMO29nf+LXakLxLR527t1FqFDdgGqz3kvehncmQuptM9SWFea8hlRct7kk56bGyQQA5e4U9Ae8Zlh+OxftN1gEqyjbFBbIAPOm++W+iQGD77tGkoeHLPW+BP/0eQnVpyLmxkHPWbX2SdDN0SDKcaVIR++mYMsS4w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(5660300002)(8936002)(426003)(86362001)(316002)(6666004)(1076003)(4326008)(82310400004)(4744005)(6916009)(2906002)(7696005)(40460700001)(36860700001)(47076005)(336012)(70206006)(26005)(186003)(70586007)(2616005)(54906003)(81166007)(16526019)(8676002)(508600001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:18:22.5303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc34d919-0ced-4523-c785-08d9beb8c444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2648
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
psp tmr bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

v2: fix wrong judgement

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 103bcadbc8b8..4de46fcb486c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2017,12 +2017,16 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) 
+		goto skip_pin_bo;
+
 	ret = psp_tmr_init(psp);
 	if (ret) {
 		DRM_ERROR("PSP tmr init failed!\n");
 		return ret;
 	}
 
+skip_pin_bo:
 	/*
 	 * For ASICs with DF Cstate management centralized
 	 * to PMFW, TMR setup should be performed after PMFW
-- 
2.30.2

