Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C047CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED7412A698;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6497912A845
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEDh7VcLhdUofoOna8U4Z/9IKrSdGdSwg3pMo54OOI9rrYYZ7CekI3k17sjGkC4KXrYbclUyw12PzsAoWQ0vQRPbr40KeIdy8IPYhFEqYO3dnWUDZpdfAVBwmHw6wP3604v/yDi4K7BiXWm/0wE2Ce+vKr+jURsbH5XXwzUfiSABBJSVEdpCQxQTIcOBE9nngNLduDwPctt0Rpzb0dvM5jHrtlDq1xp7xlxwG5ryAbbAHuxzW61nQfBWdJz8SFd65sXkpAZ1f6r8FqkUHYHh+Z4RQYd83yZ2RNHWjlgLPWRszvsaybXXVk0/kFAsrwrhRaml7iEXBjZhmKYwcePPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZO3dskVjRJC2rWBLznC9MGXk1TQTIKsVVnWX8oOQvY=;
 b=RGr1XL58Sl2lPwF43Ue/LHbU/OHvUmiktzu/mrNLvGafJ7NBy4uYYxEaCgbohoHp69LV8bgK5rJQUptnoSl01B0sQrvr8Q3sCBSodlgLwwcB/nSiEkwpK6RiTtW3OoVkM9DXRpXPu2pw3Mpe4qhz5USbkgRqT91+p00tDdJ8M9L6GXgacl9T6HO9qV5uIln3KvnWu6A7DhsoZe56HUqjA3RRaCrjtD7zVMQJPS3ieGqMCHhALWIFcSvrSizM1rbXWy7peRJqk9k0yCptWk1cZO/dLRt5dFCHBwRl+W5ehAA5gYRI/oRQ56CBacSG83Xhk+TGmTVCGg0nluIRO1qm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZO3dskVjRJC2rWBLznC9MGXk1TQTIKsVVnWX8oOQvY=;
 b=XR3unvVXirnxK8z+L84dI1Hd/yPGbppeDQJz2zAjvV3FH73qyaZumKgKn+sm9XHTycy0cGdjs47O99F8skfpl+ljt5LOna2RlWkMcFus+3XxvT5puAC6tiKj3rbU7e4b9SNg5Thnv0dr+BO8EbLEU62PeNKVJYmSqPNXlNkm+tc=
Received: from BN6PR19CA0108.namprd19.prod.outlook.com (2603:10b6:404:a0::22)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:16 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::91) by BN6PR19CA0108.outlook.office365.com
 (2603:10b6:404:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:16 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/40] drm/amd/display: Indicate stream change on ODM change
Date: Thu, 30 Jun 2022 15:13:09 -0400
Message-ID: <20220630191322.909650-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a943958-4a5d-4a4d-4051-08da5accb9f4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0bQi2Dd8TSXcZdlgiR20/uoWD0cGCK6ewVCoTjt8Soj+vBtXyW9AJAULqZZqgD7gMV2s91TxTS1Iyp6QvuMq16IvCah/7oArOLxbeuZxZzKeOkh1GVgBaNAQOxHKEUU2WcN0/zERA56R9iW+qoMM1jC4K93fByAj/NIz+1Fs3/1OB2SvMrfNBeX7T3+HaMG15hlGucJEho6TsoGX0vCFORGBi0p7chi2qIFxo/MfPH2Dui+Db9H2MGpchANnVCpr0ujXYxsH0TRM5AwcgXyHZ66bYvf46wPcaKqgJU0+E8dK+PtK6vfn4pLwlMoc7zRCA3QsOlh7rwQTdUUE2dXWJCCIyI+4uEi1+5LCRerPzzRtSKibfPqGlt7BUGbG0fH78CXDrES3CqFht+BdvXu67LYzz8ZiNhbqXOA3d6fCn2GRjPS0lqZb2aESoredrM8AWERZqqGtEKKOaQeLs216sukK14RJmclPc5GN1U2C2E2PWB88at8wcRmtn0I4VSZTWh/lz2NJcGRoT8DtBdC9z+uT9IfS++jx5SfPDsfS1+bNHKX805jZZ+GuAnAu278njalXe8OroQmF42mrvogZIWujg2r8Xgp1aydW8HA9PKSyJalS2r1lLlwpANUms+3gHIsoTid1W6KP6tdnz1X8m9ikkkm4oS96gvdtKCG3rP0NqLSCCqHQGHH2O2517bioi/MrM3jkVcvqlKzFWudocHlZBHRLioX7r1fZQDxwjQlA9xq4pnostdaABHfcCO7gHmuiqptMA7yVFkCHf0chtx8ZEIOo5+obOA1VSP9yfUlz66gSW1T2yd051unFRn8XBQ/ptoHdYEwXsu8UMHn5lsilJAJvB4ef+hqYd5HyN0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(40470700004)(6916009)(336012)(83380400001)(41300700001)(1076003)(8676002)(81166007)(2616005)(5660300002)(7696005)(426003)(356005)(40460700003)(6666004)(82310400005)(316002)(86362001)(36756003)(26005)(186003)(8936002)(70206006)(4326008)(16526019)(54906003)(82740400003)(70586007)(478600001)(36860700001)(47076005)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:16.5341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a943958-4a5d-4a4d-4051-08da5accb9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
With ODM policy 2 to 1, there exists a new use case
scenario where stream content is unchanged, but ODM
may be used.  When this happens, the stream needs
to be committed with a new pipe setting.
This did not happen due to stream change
detection logic not accounting for ODM.

[How]
Set ODM flag in stream and commit stream when change
in ODM has been detected due to policy change.

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h        | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b67fdb31f75f..3d45f6cae1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1702,6 +1702,9 @@ bool dc_is_stream_unchanged(
 	if (memcmp(&old_stream->audio_info, &stream->audio_info, sizeof(stream->audio_info)) != 0)
 		return false;
 
+	if (old_stream->odm_2to1_policy_applied != stream->odm_2to1_policy_applied)
+		return false;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 2a2f719587ee..c3d97206ed89 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -276,6 +276,8 @@ struct dc_stream_state {
 	bool has_non_synchronizable_pclk;
 	bool vblank_synchronized;
 	struct mall_stream_config mall_stream_config;
+
+	bool odm_2to1_policy_applied;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
-- 
2.25.1

