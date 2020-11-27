Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098DC64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DE721D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RZHv9LC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DE721D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77FE6EDE2;
	Fri, 27 Nov 2020 14:11:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BF66EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0rFCO31RZRk3GgScz6aEA8gEBMiPrFn6+HM/vKQg05z0EE1Sa9eFBTWKVhF1sii2BVsGzVds9WH7UZ9O/teKFCSdC0e1pjrG0KPjCu/ZFhEdVvUbKYzWIf91AlVX/ln1S2grV8oz0m4o7dagLmaADvf0WjtvSY54pY6enC/UAV9EnZPfOMv4WUOoXfC83Gz9pKp8EBu7WSY/VNtPXws+LtuHWqTNDIHZ71geIoTiqzSokpdmHp7ag2vHvz61hvL2H2iDmbP8mHpP1iIHnzx+Zxj/OTD6500uHpVn3WOMzS8QRDVrexsiaNAwQDml9j7I6iUXb04g6cIl+dKm5p1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtniMYXWCy5Wy3BfzQs3h86Cyizf0WGP1jY0RBSHcsc=;
 b=knu+ACssMxZr+TdfTtBmqKwtjADJTYcCRnMyx2qrHEz+fX29E3fRFuGHCC6yHGUwb0qxJZviKOiQEaz52fakGnqCHlAsp/t03OHk5VzVCCxsxFuzgfahHqvIgzB6AhHZ9Fc2XCS/ifyVUvx/5NM9/OatPaXY+Li/9jrRmg/Bd2cVPkyRtVzAzIgcL5oVFZUeWES5VtOXUQaEefk/2ejqM/VUxnnYSdRZ8Jr2UE7cwrYk4X8CjNa4i8bw49rw7dIUxs1b7WlK6IUDXEIZcPFwNHw0wWQ+/alMa7qhDuzj3dtZSt2Te2YyB59xkudQenvIiYWNDjjuif7Gn6BAaW/rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtniMYXWCy5Wy3BfzQs3h86Cyizf0WGP1jY0RBSHcsc=;
 b=RZHv9LC1++gJhiILLa80ctHPDSE/2SrzC0EEKhjtw2jdVQSzGoacnKoPz3KFNPmVFMaLnImWxObI4TCL+y2Do6h93TnrDCmeJKpaSF7SslrBM7l7knYp2UwjuPo++IIu2nFoZNuWLmopdGhgmm2/drPbfmOIIOu8m+6UM6tTlBE=
Received: from MWHPR11CA0019.namprd11.prod.outlook.com (2603:10b6:301:1::29)
 by BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 14:11:31 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1::4) by MWHPR11CA0019.outlook.office365.com
 (2603:10b6:301:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:30 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:19 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amd/display: Do full modeset when DSC debugfs is
 changed
Date: Fri, 27 Nov 2020 09:11:04 -0500
Message-ID: <20201127141107.7731-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77b9575-6ba5-47a7-a99e-08d892de56ed
X-MS-TrafficTypeDiagnostic: BN7PR12MB2692:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26925BA5C37A5D6D4642E8678BF80@BN7PR12MB2692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:92;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqPLFWgSyEDEJSI9bBwG0niTPPycOb7JlibR/rtaQUPE8caVSweroPHiJnTgpbJf2VrH/xX7ou6HyNK1NBd6DOO5MRUFDO1RFYr9pes/0OozGosHRZJ4mPnUegtKHHKaT0xjsCGNs7pJQKWzF11Jfx7k3+U6IzQybZq6FMiqgERQGYc8dJI35XDGTBhyOtvVq6vHFsVakLfPyUjZIRHqmF6GK38BUjkoDdIv7tWOFwM2AFjSytX+s7pFAlqTi2OXlPqfnqC8lOEgTsNeKxN7AnzASorXE65MUYbqfLZPNgc+ALEvSh60/NJ+ahQyNmAyfz0lA0QHHfvIpuzVzXoeUUmgEryap1dZ+PctInUnyTpI7xnKRKrjBcNDgRmhzzSR6xkgaTLzhwXceTYYKHjRqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966005)(2616005)(81166007)(86362001)(26005)(186003)(82740400003)(4326008)(47076004)(70206006)(7696005)(70586007)(82310400003)(44832011)(426003)(356005)(478600001)(316002)(1076003)(8676002)(336012)(6666004)(36756003)(5660300002)(6916009)(8936002)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:31.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77b9575-6ba5-47a7-a99e-08d892de56ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2692
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[Why]
Whenever DSC parameters are changed we need to perform full modeset to commit
DSC changes to DC.

[How]
If dsc_force_changed is set, need to set mode_changed on new CRTC state

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e213246e3f04..f964cca5ad6e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9316,6 +9316,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret)
 			goto fail;
+
+		if (dm_old_crtc_state->dsc_force_changed && new_crtc_state)
+			new_crtc_state->mode_changed = true;
 	}
 
 	/*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
