Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E43C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 02:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54B610E05C;
	Tue, 21 Mar 2023 02:41:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8957B10E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 02:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm9j/90llONqoygb6RDQ4snrnxyt0C+8UOKawWowoO8HN5PE9YcXhTNRSeplrIGtmTtKcw+v6TPHxwBKBsB18xP92aLbq09aQ7VBTlnIyvK6YmHYXoFDxAhoEj0AIqvwWKhGps+5oiKoHSPd7mAr1ZazLTHNTmTfrbuNtxbSLaM7G0Fkk1lzNLEvdACzPscXxmaHNo1IaQ7nhns7v3xBsJFIntbmZq2qO/ikYyrukWCpZN1Ei8V3e6pFiEn7SFkHSjSr+cmdrVnl4vIHTMoSZNlrEqSwk8nFo47waMdbt4/Urgu0uxn80hRInzEnypIM7uRpsUSpgpdlnELJmAao2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jli5/FC3wUsVfjQUuGbGYatE+NjnXdAmv3wu0jjMlSs=;
 b=JS1XwS4ZM5LnmPePbgnEtOQhmcwJFPqOLtVQvcXoScZsV8B12QfHy+nxtcPt6qC0n14Vlyv/KM0smkpEWIXqM4gyKs35B2RNhJwDmOwd0yexayB0SpWIN4KhoSjUS0CMjJp2zu4O387fKXjabQXbO0eamS/+T8qZ4iPY9nJ2smD9purP6grXqw65brD51VaYv92twg+M+Y1W7YDEXk9/1SK+pkYVgfGp2akZW0N42ZEZltYbcE2QRXgbFu/4mFMhy57wZFBmfAHEzUgZ3di9qFsiXX4eE2i5Aopy1CSSEsBsP1IBkqmZauLuS0QfHLsIEhDhoK3SANPcSxpFwwW0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jli5/FC3wUsVfjQUuGbGYatE+NjnXdAmv3wu0jjMlSs=;
 b=e6Eu/+/PkP8MSJwcsi761NF5X05O5vCX2zuagX5EOtDMlxPGEZhGWNWlxilouWmJEKcCXFVaICwUFz9/v73X1/tpFyhDgDGR309X2ogda8TWb98OpXmdrc9DlMpDn3+KZcOVNGuFRs67uQKRFxoDxEneOBG5pgYqPJpjf4XAFWA=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:41:15 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::8a) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 02:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 02:41:15 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 21:41:12 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: enable ras for mp0 v13_0_10 on SRIOV
Date: Tue, 21 Mar 2023 10:40:18 +0800
Message-ID: <20230321024020.139199-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 20eba694-eed8-4fbf-06f5-08db29b5bdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbKmjdaF1fDfnFYCfyvXZmRjeiBhaVO5JpbImopaCOFTKvwyPs2WZTCZjPr58EHIZVPwhdKviLwFCpzoXp+dn9erjxe9DgnJI5m5lfZJIHLGLiTls6YTn3SjzCNxRjkNM3x3sD5sFvsGDFJnoYiPh2Z4eXuXGH8hldRYPGkJ4MOxs0nUXhCnZGZjOvR/c56DWOzaHZI5+UvTIRTlp6QHpNZSpRIUEXUyRk0aNdpdgaEp+tb7ioj8vHpu9agMg1+KFla2OSeAOPTB0JKjxWLypfWBNFqmcjKJmxx8w90g2H+4dj+qnnKhRmaNTkyYalScqf9fLqm3BfxIGOps8pUQ2O1RxwG5SZFmZvyLKpsAS7NV+KtKHln28JsqPhmon1SGEkvAP+0Ju9p8s2uKQsakHNgaQXLQWLEcEHpZDtj4i8IFAVHbH8n+SJnorRTSyh+rhhT1RQXarleiQTPPOVJsYVBBJzIwMaSGZEt54m1CESit+cBopS+ZS/+hzWpBVfoDGjswIVemXwBgzmuUy/6+r2F9ZPNp/Xvr1ZhxidibV1jVLrNczPX7bkn21SKWFpQ4TXitR+bEZuC02K/RS091FI1BFsgJ8bqIWQEUSuTCOHOO4xNoQhrNQhrcMqEgMKvFNRjcwZsso/psaUCnTSYXAUKyEPcqDd7BQ8HnOCPtxUb/pMN0jUTTK2stIDOXE607+i/1YCcin+wzEOIubJe5iVcM+XsDJrqJpCNztePz+U4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(5660300002)(82740400003)(2616005)(1076003)(16526019)(26005)(336012)(4744005)(356005)(47076005)(81166007)(426003)(2906002)(36756003)(7696005)(8936002)(41300700001)(36860700001)(40460700003)(478600001)(40480700001)(186003)(54906003)(316002)(6916009)(70586007)(8676002)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:41:15.2738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eba694-eed8-4fbf-06f5-08db29b5bdcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng
 Chai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable ras for mp0 v13_0_10 on SRIOV.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 63dfcc98152d..94a3deb994ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2340,6 +2340,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev)) {
 		switch (adev->ip_versions[MP0_HWIP][0]) {
 		case IP_VERSION(13, 0, 2):
+		case IP_VERSION(13, 0, 10):
 			return true;
 		default:
 			return false;
-- 
2.34.1

