Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD21010F89A;
	Fri, 29 Apr 2022 18:02:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E812B10F8A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/YmT3uenlVj3cRZQm2nGNBNlSKZdBdO60sHfjSLwhWvqnfli2XyKUy2lpzj2pl4PblvbMnM2TYtpeoKD4WJ2xtUCZnLMChTgJ+2Gz9DdbOso3gfMyZRsOhYTIV1OxQ6Xu9TZJAWnX0QirFXRLEctJLcNZsHtLC37rcH3fyR5IHST2So5Zk/sJS2NdcbidsMwm4UzHc28Mi9JKJ9KC4qOovXG5R68cgGdOyA7G3lfZz/MEMqyHYI79G5ZPQlswtHRaUJo+IUaL0S9KcQT1XVxs9Nuhrc7yQ8mV5NbJjMlQ8JD5P8+krtYpxnC0bpvLpK05pckWlMG4Hc05m4fdf0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM/9+DgbKJlpTBk1Tw3z0xN6h1b/wHFiPw9ih7jcNBw=;
 b=L+O1FxzamYyl9JdyC6Qtwr2mYWpPXJMXxbzVVM+iEJtZx0uh7na7054/4BBqwtQJf+QHOPEAR3eXVgsLDEpl3bfJvvtU8hHYwLb5d+gXD/lBNTSvfbIiHeJFJGt3hc6EKcS+y9vq3Q4uUlK51SdXA//J34edMwz8UOcG99lJ83B8z0H21UcWyOGZL3BgqnI/32/Wd66ScsQnkBmp0eKY3Fh4fT7YpKScDoSjP2ePki5gJhbFfsOK78bOQ9aCaW9mIrlHLxXRdmrpwj02+Rlhf3A4quI8bmmX9QPEPxAJinDcsvwI0C4Vo1Ok6Xo41Ezh8/ljs6NCQbSuAnKOCKn1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM/9+DgbKJlpTBk1Tw3z0xN6h1b/wHFiPw9ih7jcNBw=;
 b=Bk7nm48UJulyeI2PQ6Fm4DOZnl2F1JU21YEwptOgnb0s/xki8TBDiK9G5T5qbU9hvfw+ka+bWeBillOms8Pu6r0XpT+Pp3NgdzqczGD+UzYAMnPyEOQ2iNEUd/sFLYkZ5MldHYgv+/97ATn/BOPp7+IH1VG/mE407+YfnWMEz8k=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Fri, 29 Apr 2022 18:02:47 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::94) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/29] drm/amd/amdgpu: adjust the fw load type list
Date: Fri, 29 Apr 2022 14:02:07 -0400
Message-ID: <20220429180226.536084-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7394decf-149c-44f7-7334-08da2a0a776c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB25961D812920C75D59BC2957F7FC9@BN7PR12MB2596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNXPP69fa3mXvwKVak35GcmhTnferwk/MGH3kAGOiKFH/dwa0ct++pjxySQ5HsYt5Y6WyaXlvsPw+ezYUqlwfnWk7gozWnrUiH5Q0bTSpBgRrE5CJSoD87TVtRGIendXaOaLa23F1rmvofXYQbCkKjdMtozuUXWeSjurAqrXdFx94zL674wcL7Y3yZrBOn3NzL3ExaUKH7XJZlR0CeV+pkVNNTwZQeMUNgmu3lhG/x6tOn7KFL4omDmvYzIRABXFV7b2nCJ4OwTP2sxEcTHHqEaXv+5CqEncDzRyhVg1lPkNpYrEO1oH7vo5haGNVViaDDHyiZZiZGYzqNYncUGImOC+tDl/W6MdnE/stw1ZrYeHhg0Var6MiUSuX/mDGoUPwu3Y5RgWjtr2a79QL3MloVW94q2LPgpZdvSRtrBQ0p5mo5m9UHX5YV+ps0u0f9iVLSm5QS2hXIRyUxUB23n+GAGo4yllu4KGw4vSHKwshD+5rovMrX+11CUcJNZhAKV4WKwAt6h1hiW/GBSZDVVR4RjV+xpQC31pIpAubnNkzM7ycj4JyTQ0KWb8E/2GmwJNOcN34HNDe23oS+aUOL51oJuQcJj+KweJFR//edQ0uBt5SsIWb0sURcDBjM9PIYEKiTSHyR0UzFJlHAJRG9uIklR40+x+zURNlhTE3wocymnS8Z/e8TOIMRIZS0LDmQf3hGxiXrPLRC7FAl9BlZPvAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(508600001)(47076005)(5660300002)(40460700003)(186003)(1076003)(36756003)(83380400001)(316002)(336012)(426003)(2616005)(4744005)(54906003)(82310400005)(356005)(2906002)(6666004)(6916009)(70586007)(70206006)(81166007)(86362001)(26005)(16526019)(36860700001)(7696005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:46.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7394decf-149c-44f7-7334-08da2a0a776c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Use 0 for legacy backdoor and 1 for frontdoor.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4042aa268dd6..4439e0119f19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -445,8 +445,8 @@ enum AMDGPU_UCODE_STATUS {
 
 enum amdgpu_firmware_load_type {
 	AMDGPU_FW_LOAD_DIRECT = 0,
-	AMDGPU_FW_LOAD_SMU,
 	AMDGPU_FW_LOAD_PSP,
+	AMDGPU_FW_LOAD_SMU,
 	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
 };
 
-- 
2.35.1

