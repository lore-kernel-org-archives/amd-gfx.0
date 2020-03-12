Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4CC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DA0206BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 10:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VHDt5TEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DA0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF116E0E0;
	Thu, 12 Mar 2020 10:43:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEDD6E0E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 10:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGjvB5HCqF/Jap4FPFbmg0uPM3rdt1/mz5z7Fj1N+hpWrqVSd5pN2hod4OQAuO9Gwy4r3He9b+Xm5CTocsnihJ82JmgAM/D6L2SGyKyw7OUB0ZxmtmCy6qdh/1p/CdX3+Dt6CMBy6IR9ivXPAp41umpjWZuA+qCmZWQYy/UeX76Ch5IDTKTaqalG/lg+cZBEtU7lcH1/bbgVha9pHFAAdNkr/c16ldnKIw+8li+vdvVKfFRno2RrnIIFGJrh2aaRpqwStPLngLP71CQDq34ObB954kUYi7EApbilkrrQbtAOze9Jn9iZYb8VK78YjdOzNH0xUX1gSGMA6ObqZdvPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv8JodzcoxFCvPKNxnDhLpZdANeMKKZLsd+T1SWYAUs=;
 b=LPxIFLOpe0FpAX/8QJXBmUZDAYPUsQ9IiuiS8RMJcyNB3SEVTR69DrAXh+r/Wa9YMPZw823r3eqgV+fFerVyM8umCFB7AwvljDn/6jrjxBUfvmuexHUf/TNZR0mrbo2oAVPTd5wHSUZbszMsBJ1MQlscCFHAD3Ha+ybFR9SX2YSQOjMJE5h9mF1roayrqRbXYvmE7dieE4q+oWUSfKTNqRTED+QTP4/zWjMPsipKL+ubhg9WisuBXrFEuxGfUjgJMjmASgqI9drZ3UaftKLC7WU3+pConyaBbGVB4fAQ61zw5/WB+vhE/2K9qXeqI7UbhxuEM3hPW+6HeTfqtorEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv8JodzcoxFCvPKNxnDhLpZdANeMKKZLsd+T1SWYAUs=;
 b=VHDt5TEQON6FOZ8ZG8wD2pe7U+yl9C2oCSTBK7PWOvT+JpdMG7HULj3zojvIYp9NDZYQyqWT+A1fQVcQB2JlAdm4Ti+SrX+gcbf4vfwGgdQNzRJMA79U9kEZiwy4C+z/wxNEjDZTTREqAbXsj5183us9UoWlGlaGg89H2YtruZA=
Received: from BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39) by
 DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 12 Mar 2020 10:43:21 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::d7) by BL0PR01CA0026.outlook.office365.com
 (2603:10b6:208:71::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 12 Mar 2020 10:43:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Thu, 12 Mar 2020 10:43:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Mar
 2020 05:43:20 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Mar
 2020 05:43:20 -0500
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Mar 2020 05:43:18 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix warning in ras_debugfs_create_all()
Date: Thu, 12 Mar 2020 18:43:16 +0800
Message-ID: <20200312104316.5234-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(186003)(70586007)(70206006)(81166006)(2616005)(426003)(36756003)(336012)(81156014)(8676002)(26005)(8936002)(86362001)(478600001)(2906002)(7696005)(1076003)(6916009)(5660300002)(356004)(54906003)(316002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1738; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831e210b-9891-48d4-aa2e-08d7c6722ef1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17381EF4C96E1C49BD494E179AFD0@DM5PR12MB1738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0340850FCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8fhpG/nPJnRQsyyR9zBzffIPa1PLnu55nZpY3ugpWHUBVoZV+vuR0APhEoJ66sX2efxgw5OQpZYzQX+hs+RGhC8uwCf1ey3ztBd7L6JjHjR/W/42ekFXOwmfEPYrUfEsKtioDHF/nkDRyj95uo2RH2NDSOqmgUw9ItmS92r2uyvJk4FqQ/LwrF8EAivG4OL5M1uwJaq9ffdsE7xvmuxXJsYibrAHSjlmXfmo1O5hiW0Vmdp15+7/MMGOKDXm0p64IR4yEJRKtNSVMoqXZp5LMyuxt9XAmvgw18Bl1Rfa5Gi/eWFI86pNPAXMozGZvs5Rn8a1TbiBhopfiwx0B3mO/t2bjlahLJZyk7iGS0KLTFnwPycnM7PwUBMMeP8CP7R3gqBejqONZOsVyiZGTC+KSMT+NrmSdr0OTlJzWH00BwokrCwmHUm+o5l02fsCx39
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:43:21.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831e210b-9891-48d4-aa2e-08d7c6722ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
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
Cc: Guchun.Chen@amd.com, Tao.Zhou1@amd.com,
 "Stanley.Yang" <Stanley.Yang@amd.com>, john.clements@amd.com,
 Dennis.Li@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the warning
"warn: variable dereferenced before check 'obj' (see line 1131)"
by removing unnecessary checks as amdgpu_ras_debugfs_create_all()
is only called from amdgpu_debugfs_init() where obj member in
con->head list is not NULL.
Use list_for_each_entry() instead list_for_each_entry_safe() as obj
do not to be freeing or removing from list during this process.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I33d68d5c0b9db2744732f4db924600afd99f956c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ce8548d5fbf3..ae2d569ac678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1116,7 +1116,7 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_manager *obj, *tmp;
+	struct ras_manager *obj;
 	struct ras_fs_if fs_info;
 
 	/*
@@ -1128,10 +1128,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 
 	amdgpu_ras_debugfs_create_ctrl_node(adev);
 
-	list_for_each_entry_safe(obj, tmp, &con->head, node) {
-		if (!obj)
-			continue;
-
+	list_for_each_entry(obj, &con->head, node) {
 		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
 			(obj->attr_inuse == 1)) {
 			sprintf(fs_info.debugfs_name, "%s_err_inject",
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
