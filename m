Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18318C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDEC10E1D6;
	Fri, 18 Mar 2022 21:48:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEAB10E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej1lY2csgi5BwSTcPirAG95SeELO+hIYAQK9WWHJuA9JNeEVzSzTgqlPFdXFoTfhCJkyxylX0CPmKKEA+3YdJQh6oRLtkNkInzqZvHe+ABGSqubpjewpEzVIbmOWHJ3NxtA/3DKvusJBmSjDygsgnimPszoS4jvodL0/2zcUXWLxTRbCj2MpqMd4NN7XFmbSTunsRe5Tm7u+Z78Q7lu5wf2vjo/Hqc5FnaBX6Dpgo8K66SgFgVMmIFxdh7DDNrNtKRrsw6i0zUsnOPCXazHmBaPl3nQB0jkfPuUiclTRi7fERQIMZtM48keSlJMiqJWZzhgMCdWTlqWHmOgX6u1bQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmnVob/+OyW5/bQyIk4kMm56z5bUa0anwUhjQ54egS8=;
 b=OQcF9oA+itufQUC7g/emD7ZjBg+egz3cEfnnJlgwnxkGWHiKUXC5M8kin76BTaGtlv32+HDcT4B2y2nqlsoeGr8j2Hof2ADGN15zFrA7uv+yaJ7JuSCBBafxI7GKySAw4yWHS6UiDBT2xxtnU9gvh5lvYMX6wWoyQcuVPPGub43RhRB9ykD43+jdeJBtmI4ryau6h+Btx0orPdF7p+C9akzrmTa0DhXSqsv6VXj3gPJMXOYI9S5La9OLJaFXxUlmjzdYwU+lJcg5Djx4hVU3R4XA9wQA/U06AuwggYWEt546sh+t6q02pxkBgRzyCI5gD2gLwL6Fvdt+KxpYq9PAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmnVob/+OyW5/bQyIk4kMm56z5bUa0anwUhjQ54egS8=;
 b=sHgxSGV2GUqQan+5upFx05MEFZT3mBbLu21qBcs/icGY1i/ZUeyAHTAoyzxikkjRMQ/Br7I+klmZI0hai7snzXHNezleuFLM9lacTI92FMCp6C1DsGpKWLzrAEnnNv6zsAMpsndreqjo8ueyi5iLq46ZzW8GUyjT7G4ozk1XuwU=
Received: from BN6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:405:75::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:48:42 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::6e) by BN6PR17CA0027.outlook.office365.com
 (2603:10b6:405:75::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:48:41 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:48:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: fix audio format not updated after
 edid updated
Date: Fri, 18 Mar 2022 15:47:49 -0600
Message-ID: <20220318214800.3565679-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b70345-bf8c-48c4-437e-08da0929117a
X-MS-TrafficTypeDiagnostic: DS7PR12MB6008:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB60080F2B128708B7103645EBF7139@DS7PR12MB6008.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRjpBeluW6Ikz5wkp79EINoUhPM6JJmuVBTw4RMv5xWfTyXTqFuSRycD4FoRvfXl6X/iVpodE7aqpqAXSqF6o8tJw/3XiCZwg2RNe6BQb2t5Fl/b4IXT4Sg+27pHDMyT/FyF9dV6Dk/4du2+kQCymEWcjpReDzxGYU5vVbs4YhK7qAfpe1gIy5gHOMw3vv7Z3Khd33xpwmmHvbMhDOpS/S0EI3OEBj08hrQWMYuRTgFkgQF6hBuFPujjN55Bk4+hX9+6YHkz9hiDkbXhq89+MfvGq5b3UXLF0an9XdSRNm3pO6NTFZRM9MPTaNoblJNAbd8RrstwDQsCnp1nglZVN7zf2BWIbeF5HE41Hpqzn0yJUcoRNlNtZrVesUv1nm9EnKYKkQY8AoN7uo4BRAFox4KqFxSiDa7jtk2AxV4QOw7VX/NHZlYc2NK9drsPcO8O9tl5MiYmZ3E8gEWLrkMAsQO5ZaFeCiYbq5k86AsMihpgiIPhcTIGv4Y4bOUcRkADoRIYzs/l7eERJP2qP2TIG6k6zxzx8+N36jvQabW1lVeRHaJFyC9IKuHDYSXRc2wG45F9qCdznYyOyRdb9ndBF5WtlUTiNh0X8VG3Wj9H3siaX3ldrO+CKPnF/+JGK+aSQiMK8HATZof/UrqZfwmNSYiD+wX4MBZKW34Id1Axr0ZQ5N97G3QvWDTcbJV1XGyuJYRR309NnT5f+imA9nJhwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(15650500001)(86362001)(426003)(2616005)(1076003)(186003)(336012)(356005)(83380400001)(44832011)(26005)(8936002)(2906002)(47076005)(5660300002)(16526019)(70206006)(40460700003)(4326008)(7696005)(36756003)(8676002)(6666004)(508600001)(316002)(6916009)(82310400004)(70586007)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:48:41.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b70345-bf8c-48c4-437e-08da0929117a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
for the case edid change only changed audio format.
driver still need to update stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7af153434e9e..d251c3f3a714 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1685,8 +1685,8 @@ bool dc_is_stream_unchanged(
 	if (old_stream->ignore_msa_timing_param != stream->ignore_msa_timing_param)
 		return false;
 
-	// Only Have Audio left to check whether it is same or not. This is a corner case for Tiled sinks
-	if (old_stream->audio_info.mode_count != stream->audio_info.mode_count)
+	/*compare audio info*/
+	if (memcmp(&old_stream->audio_info, &stream->audio_info, sizeof(stream->audio_info)) != 0)
 		return false;
 
 	return true;
-- 
2.35.1

