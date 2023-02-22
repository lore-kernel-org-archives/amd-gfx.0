Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27775C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B7510E3FE;
	Wed, 22 Feb 2023 06:42:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 858D610E3FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5U1NsKh1Hh98roT7rbh31dZDMkCb9To6bBprL/Ojhqf+PxMxLPE9yh838hcjeRE+fT65YWwxu8yQ4j7W3aUs650iC//Gk52KlIiEQUqW34jNjr96VQ3bmjOHkaU+TSc2sCes+bCljcx0sLSUz2VBiv5dHYavRCdmY7YVxckUdXsgyJkMqc62GIYqujvSeSvSeLAHfSWvbXnvzxNyQbKD0xkGjjVUYAXSsY9yZHkmpSd8U2igd4IWmqkYeZJIq1jJh37Qbaq2KPN9fg1r07FGJ3pZvRx7JLehGOu3rcGoY1gdoPUjhG1LXq9RvoToXwVL6rpev4+rHcjF+PFEW/I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zepuM0PzuJz6rRH4Zg84ItLERq+uojO4QU9+0eNrg9Y=;
 b=RdxT4ZGJWARmaEu7YdOvuT7Q8ZRevR8mNThZN4Q2tvZRpiNcmLXsLO2viua/qkMVytAT56e0QR5sTbZNoakVw0UPgz6JVknKnFWmdk2wbNUsOXzgvL2CfO+PSNiG19ALR2YAqa59V+B3sRnIOtifxGL85mjD2ngPeax52yvnXbGepz4Q1RSiN25N51t5X6B9gEfb4Cr2MYABHe8Jacb49yBE0dMreV4DOqCL6t5xiS0IhWPnBU15h6kjmHeu/DHamlJefSBTVSDLwz+bU3Wg4fmtIJxeGme7hgam6Kj1QLAqWdsHEQomBRwpszxAP3jUI1Jk/NSujNCSIVm1JmMAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zepuM0PzuJz6rRH4Zg84ItLERq+uojO4QU9+0eNrg9Y=;
 b=nEM5+LF6n2TD8JYBF7KJ53pMLVpix9AhxzdJg3pzzUbDqP0uSKj1+VO6/+Mfw2eeKeIY+OfcrkbK6gWkaVYMY2Z9S653q4bUaxRO/JmM2cdjQT/q4jcEJST8ef45bxgZVypYlDyxtO2oCxNs0+NLa3olvqlu8KkSv15SrzZ/njg=
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 06:42:19 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::33) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:11 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: Extend Freesync over PCon support for
 more devices
Date: Wed, 22 Feb 2023 01:40:31 -0500
Message-ID: <20230222064041.2824-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: fde03461-b150-4873-2126-08db149ff212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZ7e8jyzLhmmVcB5Nqweuu0nhA9sNOrVaY49ck/f3ik0Z4agJR3vdviWw6EHt4n06R79ipdCNninq4doOnmNsWm+mL9+huEQ9E22mZQVg2ZkVMq15WrpFHpE7OOQpxvSP+uIcibVPPv5U19ajezGtVcR6HqQHvWrW1UiYk388IG5Xqixwlj2rocHasZU+4LyUw3QLJJtqKgLH2EwAtLR2vQOO75WLDeFMJ3AKYdenrC6XRs2edg7bNFZll8ViGUl+AaMoxSOiyghI2+yGZAWWzPElkHtIiw6EPj0Nw21Asx1tNQSKq8weauWXWyYtmGt51FG/wlcXFbdgW3hfT6QYkevlgowiyKbBV+RA/j3wv7iOAq1cvXcwdA8q3R2E/a757tBK1J94dpodBB/sTiIaJ3BNfekYOS6VN55ysxqpt8lGbt+/8dZpC9aMXHGb/KLqPpg+BkDBxqaEHsRUqB0w4CG4Z/AxdYrwcmMxgRQNgRVTeOrGceYFGRXbYLLMTjxq0hNHDb+A2Dm4mzbwcFVKaRwVAHTgSreterPBZnDnpMdsJI7NcnllYev5enAWFFap1FKLX9OLke8Mmixymc0UNDvA6iVmPhR5YnuL54732GLojQpUzy5rU2/Af/ZKuwYc2r8ST8dJoQ2sWPxP8pj+euN6oMNhFPnImqTlyClGqXsg2CaV05//aKoJBCCp7PDHI87f6Q316mi4zVnWCxfL7akBzioJafnXr1YSS8Jn9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(2616005)(5660300002)(36860700001)(6666004)(336012)(16526019)(1076003)(186003)(26005)(54906003)(426003)(478600001)(316002)(47076005)(356005)(40460700003)(8676002)(6916009)(4326008)(41300700001)(8936002)(40480700001)(70586007)(70206006)(36756003)(44832011)(81166007)(82310400005)(86362001)(82740400003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:19.5905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde03461-b150-4873-2126-08db149ff212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sung Joon Kim <sungjoon.kim@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
More branch devices are able to support Freesync
over PCon so include them in the list of supporting devices.

[how]
Add more compatible PCon devices in the whitelist
for Freesync over Pcon.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6fdc2027c2b4..1583157da355 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1149,6 +1149,8 @@ static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 
 	switch (branch_dev_id) {
 	case DP_BRANCH_DEVICE_ID_0060AD:
+	case DP_BRANCH_DEVICE_ID_00E04C:
+	case DP_BRANCH_DEVICE_ID_90CC24:
 		ret_val = true;
 		break;
 	default:
-- 
2.34.1

