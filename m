Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F116C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7CE206D3
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 09:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HspNU5lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7CE206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F316EA29;
	Thu,  2 Apr 2020 09:28:42 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853C66EA29
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 09:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALbsLgOFdX02EHWY5JQPlyMICDF6McI7A99ieCjiDDjvE709qAFCC2hetPJ71XkFGc3uHTfl7AxRbKVxJgc07BLm4lMXq0hu8GfntOQL6b4M8ws5P4GxDcc/HG4KlfYGX+UFCqf+3bS+iOYOrRYzz3daF8OWp+tlrbWaLhue3NOnMQN3NpUg18vqjP4hBQDVYwy/J7xs/UFD8FDPwxUDDLkXkYc9/tply75uCBMc9HrY6LXZ7GYoOi2PNBRnnwq5tzNu1FPDhFYA1rfJVvppJceaN7e25rH41ATaVUfIenscgVK4/81CGlB3F/F6fNFuTSo17jf1eaFblPPik9dcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE3H/sHEloQNnO+pzAWUF/lI6XfWSfXSO5jIvxcByTA=;
 b=ZeIK4j2u/loXZLxTnl/jooCb42HyBez8CJKviWWsaXwFNElCzMZyu6qJGOLdJHOhpyu2g9q7+0Cet76znsacXGAsYeeLn4OFe4cmxLtNOi9OQXHcspUrP+VyT8dRHskPNfZceTi7GTYmAJWLJQgtaNRB7YNljJyHv5b1WeqYiqPSSoi5trmLicRMtpnwxbRhdp37720RvcjFQroReGXNSQaEjdnDgTBT703rrod2raknwPGcU8/5uKRzaPSj4291EVk1rX9vhuz/wrBZm7PJzblCDeMhKg642YqU++/rsCjfB2pkbHKskrLRvz5Tfz+JhN0KAQHJYWHAfqffOMVehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE3H/sHEloQNnO+pzAWUF/lI6XfWSfXSO5jIvxcByTA=;
 b=HspNU5lWN7D7D3S18VfEvmjT6JfeeqcWF20pjg/3xvTSPEpyLa+O01LH1ilqt8CbyrPs/e3g8TT54JTaVzFio1JshM+H/KjIxNaScuZXAHajGx8XFrqS32OhEWNDDc+4NcOC1MUpkEVIWCfjU0iYB9GBBqo78610izLcpc/+kpU=
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by BN6PR1201MB0113.namprd12.prod.outlook.com (2603:10b6:405:55::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 09:28:38 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::eb) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Thu, 2 Apr 2020 09:28:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 09:28:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 04:28:37 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 04:28:37 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 2 Apr 2020 04:28:36 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: avoid using pm_en before it is initialized
Date: Thu, 2 Apr 2020 17:28:33 +0800
Message-ID: <20200402092833.30558-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(428003)(46966005)(5660300002)(6666004)(356004)(2906002)(8676002)(8936002)(81166006)(6916009)(316002)(86362001)(36756003)(4326008)(54906003)(70206006)(47076004)(1076003)(2616005)(336012)(7696005)(70586007)(426003)(81156014)(478600001)(82740400003)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a76358-3fa9-4949-731e-08d7d6e8398f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0113:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB011327AC389A437B286E008BE4C60@BN6PR1201MB0113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0361212EA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMQtRpSr09Y4vW24mQwLF6W4YamvMmrZj5oxrvo+IxgRi9U7mQ/SCf6Q2Ec8CbSeMXTYfDElpdOOrrU51Gf5dvEdn8GUTZaLQDLepagrLTg18TCoUgHJD++5yeQHixOQopT6DSpFJdkh6lyw0VfCVQzKYyEVImXyhzDGtZu/I+ptW3Wol6RNVhv9a2bey2GMyav63oYd60PmdLEZL2tWEQ+4Y53fXjOWCJlCZ0yMOCVoT7ti2qeRhPpEGtOKT1qNcylHg6EJFCN59tQFeH1TpA70cJr0jtLI9mWxiZ18By5bOFgB+DYWAXu0ynyREb+8R2TNDwFnPDdD0b+b/mF5G1JxXfemoZ/AL6V1w8egFSTWAh+52yEXWWNh5Zax9RnNxLZ7SiFzoxmp6W29889gkYFrNUUD1X5WmI/vVML8kXSjRlKHD1CICTsKAHlTy8i7IQWB4JB+SM8DZGNozMGOVhHry/wC+JW2T13gJZwF+i6/U2j1ENa5EzpRUUglJooP6ACYcXX5a+IC3G6KaAhWoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 09:28:38.2233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a76358-3fa9-4949-731e-08d7d6e8398f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0113
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
Cc: Tiecheng.Zhou@amd.com, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hwmgr->pm_en is initialized at hwmgr_hw_init.
during amdgpu_device_init, there is amdgpu_asic_reset that calls to
pp_get_asic_baco_capability, while hwmgr->pm_en has not yet been initialized.

so avoid using pm_en in pp_get_asic_baco_capability.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 71b843f542d8..fdff3e1c5e95 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1455,7 +1455,8 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
+	if (!(hwmgr->not_vf && amdgpu_dpm) ||
+		!hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
