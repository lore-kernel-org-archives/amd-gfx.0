Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12586C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 14:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FD510EDA5;
	Fri,  6 May 2022 14:07:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC97510ED98
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 14:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWG4SuPpwOhxJSiTscWIElbqAkGufdCvFJ3wnge6zpNu6UKwAzJ6tBBmQOZWFrMSwGfgovA4SqQUAFGgAjy3t5I7iu0V0a0NUqJgajLCs7fqlNel//37YiNSl/JLhSQJZ/IJEcdw3ptHs/2XGHOtSu5Eo1u063+IbgJAONz0ZvoDfvtDBmDyWdCbbH9TABRqsRWjm2ar1qvpPhwODvhabqT3OVq4gp26S5p1Hg2ucO11asnWHrrUjVKboLJyiMrpCSfYdPLpO+0RyoUR5lB1ib62FVaSV67RY2v0EIVu7OwdjExs7nZx3ENeWzvQtf5ceOmT/JB5j1Zmk2DWEgzuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YJR2tYepgNI9xYtrd3RKmErWqbKIouz0uNrKOfSUTA=;
 b=Xc7fCkEHzW2uSaH7qy/t3Dki09GnI1ZTREyji1uiAcwnEShW20iqt81Oi+KsE+OqyVYG05TfZOs67/b3U4X4FKBXkgzgXzwXdcQBIDsIICidsn5onXIGICmdBj3k0tDJzt0E9UDquyfRFPy6qk3S3i8L/0zGgx0Jb40+IuZHZILag4GcfLvK7l6hvBPfc92jcDWK8LDLXQ/aAUCt+C8h5+WsKrrwvJGxoo5QKVjGGNLKFLoBhJXeWoxxj3gvboHc6pHSl4AJcfmIw3m6fEM1IGAaZa5C+GJpZBogM9IoNDnKPmsvGbN+nem31JJbx/uq69MJmyPJZM5IPpQGdIgH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YJR2tYepgNI9xYtrd3RKmErWqbKIouz0uNrKOfSUTA=;
 b=C7onSFAQKgPsWBcKdAMl7QNIwKRpSI1IktkUxeu4Sc88qSzevAN4htu1jaPVVW9YvslTqU+2EwaegKk3Jd1xqVhEjo5xTIAU8czOtO4jpUUhJKFaLwDfqSIyzJOdLY2IdKWuv0qa4wyo6l4tcxeAuKJj5wRrEk+a04wnzqfrPa4=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Fri, 6 May 2022 14:07:05 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f6) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Fri, 6 May 2022 14:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 14:07:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 09:07:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use proper index in
 smu_v13_0_7_get_power_profile_mode()
Date: Fri, 6 May 2022 10:06:52 -0400
Message-ID: <20220506140652.2448793-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1bd8c3d-d9fa-4ca7-8f76-08da2f69b360
X-MS-TrafficTypeDiagnostic: DS7PR12MB6118:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6118EAF2BF62BFECEF222F01F7C59@DS7PR12MB6118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/DlCB3TlVcMPgmSGLGYEeFYt8jciU/i7Bdj2AHB3vx4HQbVLuKr0tjZBbOHsHeeuzlXn/dqEVu/dCxgStViaIttC/h9eQqOz44QvMcQvWYN1JgVSY6o9ILRd0NWVj1UZlKh19AKbPmxFUd890DnsgH/FNNwGStV+LdeMVHqqBt/BmIqCRm+rrhtTS1PgSu4DTi6NF93R10fvdZZwJbVRrEIM32Ntb38QifCulfYDVHjFtWT7Idd4KSyJSedqCTSZCqZ0u3IQ2h2Z92A/X9SvxEPJpc7sF+hAN193kRLBlJ+xvjnJJj0ebH9a0asRgOTYAkKLeJHkN+7LT4d7pvmnT33S23x4lnCYtxrYTzY6acvllQaBVhABCpxwnRn7ZAxs6iujMo3IVf0bICEqS0I/UWAPG2amkjEbIvxpMboxWCgPg6CqHLbf56Gtg7m7yrY8DXvI9YEbeuCdlTC71sDTMzwmMqqnSaidBBArRiRgk9KTHNjm9zqTGfn6lJ11ZkRaBSOi8LQdOmsddVcGYbmFQnHd5WFfRMTLUcXgHBm/xdb0XVRrSvFGOjuVsXszShoc0Df3K+fje94ShMP7VelVlgLhU8xe9C6TTjunRURTZzCt2B6PULSw47+7Z6L+bzoNLuXqTmhQeyo5ohvM/us/kw3nTFdf8RntvrhR2xPobRILmUli+Q1DaoDoBr4UZJ2vwxPzwvOw+GhAJORDdUdPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(70206006)(70586007)(86362001)(8676002)(26005)(36860700001)(4326008)(186003)(6666004)(82310400005)(2906002)(7696005)(36756003)(316002)(6916009)(54906003)(508600001)(2616005)(83380400001)(5660300002)(81166007)(1076003)(356005)(40460700003)(336012)(47076005)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 14:07:05.3086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd8c3d-d9fa-4ca7-8f76-08da2f69b360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise we get an out of bounds access.

Fixes: 878205b8c170 ("drm/amd/pm: enable workload type change on smu_v13_0_7")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8e576054bee5..cf5800822174 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1361,7 +1361,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 do {													\
 	size += sysfs_emit_at(buf, size, "%-30s", #field);						\
 	for (j = 0; j <= PP_SMC_POWER_PROFILE_WINDOW3D; j++)						\
-		size += sysfs_emit_at(buf, size, "%-16d", activity_monitor_external[i].DpmActivityMonitorCoeffInt.field);		\
+		size += sysfs_emit_at(buf, size, "%-16d", activity_monitor_external[j].DpmActivityMonitorCoeffInt.field);		\
 	size += sysfs_emit_at(buf, size, "\n");								\
 } while (0)
 
-- 
2.35.1

