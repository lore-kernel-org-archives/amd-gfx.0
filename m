Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EF310EAD5;
	Fri, 14 Jan 2022 01:37:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2C810EAE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2nVxLjz7nzgV2q4NDLTm+DyEeAQNdWKowzTN1E+UXy8Q/mar0Cl2seuGl6A9eOhHmYhfXrQrJfi+Rp5+lRMp28pp5EOR4B+KFzAVC1zILgDmY+OEwsxCd5nTUTCYsNj9kEC4voSye32F1mpS+yz4UBX4ptNWvrw/qcVW/mAAFgz8ehYLKx9SHfLrAYFTOo3wRAWtC1+RYTXNCsBSf7RUER18Ei82IIGSyQCYmyMWuR7tjERQIhfRijgU8wqBg79rvB4QKLNuVmgd7TFjkKQUVXP4lNc1oHreDD8490JkLvNthR2US0EDS1q1JqHhGIHS3qcgSWE/prgNHSqbzAvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYz2Vds0ylB7lGzN9lq0CWrazKHGBt9ZT3hDcd9e8l4=;
 b=F+IGvixuaqn3//8S+XL3c4Aiic82qkydXd9U9oy27rq3c54PO6JVitNliShdu9Zqoe5Wp5NGvQLiAnTYtcrcPaXtclitK/tShy7WnVajw0wrXe578AVWx/ZSxEOccrGZvn7uXXaUDG28EIM4BoXApf9JOgBLvUFr3oaQT31c7BXsXcOvvbMtcSytX8+k2kjpc58eoN/y4vTbZTqqNYoEAuh8UtGlKt3nlOO7sb84QTkw9M/lQk2kOQ8kfhEAsjY084PPBvZp2+Nhn5sLDv6rMeUeTD+K7u11GOWp9NBg/l0SWIAuQhD+mTiJqlSSXMF9YArlI6ZENoZpijAdGNoXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYz2Vds0ylB7lGzN9lq0CWrazKHGBt9ZT3hDcd9e8l4=;
 b=LtYwCoheVcl4Q0AWQKfiPAzv9M2lFZPQnNGv2gO4M5fkHfE7VMsVrz59/wvu7OoeEFG8XrODvagcpV3tLFrSjR9XGjGVxJfcm5EUdH3qr8hqCA/WBj2sZDCrDA9QrirMD6BABsSYWjgbA0zPNQd2hi+vWpWdYRHafS2OgU6wCRM=
Received: from BN6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:404:13e::18)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 01:37:15 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::31) by BN6PR13CA0032.outlook.office365.com
 (2603:10b6:404:13e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 17:37:14 -0800
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:10 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Reset link encoder assignments in
 atomic check
Date: Fri, 14 Jan 2022 09:36:45 +0800
Message-ID: <20220114013657.3119627-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93521a37-3711-4627-bf7d-08d9d6fe64f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4976:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49765839AB4D3298210B999EFC549@DM6PR12MB4976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxkAO5wdDF/laxx1zUQ+bBT7lrsSMyPmNVj88snDlV3aNaNM5kBQXULdQpZRDGXpXbKbkMNW/dQumCHPpCLnTiu4myENzD92795dbDv2flvWZY3+wof7fIUO87s3tyKN7jvL0InVRuKXQQflg8MkpCJ7mApZgqeqNoqm3uqHcpldgJTN3gHPwGc9ksDdVvVV5ME5NkMcM17xzqDHbrC0mNpLXCXpUn9sAoyl3VvEnAdjuwi2pIG5U1PA7drfo/4qGmmbjARBHk2UdD9QrCARxizGbMkSHnJwzf54rL9bCBYie2vOeo7blZClxHIx9l7pvRWMWTEZ/Z3e6sb9lM8UdjbwFDjYA+GmLqFe0iZTV7JLTEuKoRoN+/QcVitBGDyPIswd2MGj63PjFiGHEJrs68k3zRF6VikiTb37ucURmVSQzr5QgojwUlC8X+9slCN7Enwb0Cn7rlwo7GveuAXROAq/rY68LCfNdEm3H2Tn2pKI9Sid6sBNEe34zrd1SI3rcWDLfvRFG5hOwR9kzTfqa/r2T/L7Ai+2mmCzYAHs58d05EfPWns4/KiTtHZeY32tToxoypkoJP3G/ZC1aByc830UjdTeXT2vhv7GwskY/59pONFkMh9YBdYo+ps9ebN+5Lq7dt4PwpwaUKfw/bmrdji74OM35zV2qvUijJwUEDNwfjwf+JflN37oYfxTxjUX6E6XqnB1G9rKlHlMxODtgb+DgJp93JHgd7GDhj8n6Xtri8DdAd1VDCXj4kpeoTakPSCVHU9YZdxlTlzqq7wd2uQz67ueM9guvH3IDLu02+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36756003)(70206006)(40460700001)(426003)(47076005)(36860700001)(54906003)(508600001)(6916009)(316002)(83380400001)(86362001)(8936002)(70586007)(8676002)(82310400004)(6666004)(2906002)(1076003)(5660300002)(81166007)(356005)(336012)(4326008)(2616005)(7696005)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:15.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93521a37-3711-4627-bf7d-08d9d6fe64f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
The link encoder assignments must be "invalid" before commencing
on the reassignment operation in DC. A failing atomic check from
interruption of a signal could often leave the assignment change
in place and trigger the assertion.

[How]
As a work-around the link encoder assignments are always reset
before going into DC validation in DM atomic check.


Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a22c25c707b1..17fd37ee6251 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11227,6 +11227,18 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
 			goto fail;
 		}
+
+		/*
+		 * A previously failing atomic check, for example due to a
+		 * interruption from signal, could have changed the
+		 * link encoder assignments in the DC state.
+		 *
+		 * DC expects that link encoder assignments are *not* valid
+		 * when committing a state, so as a workaround it needs to be
+		 * cleared here.
+		 */
+		link_enc_cfg_init(dc, dm_state->context);
+
 		status = dc_validate_global_state(dc, dm_state->context, true);
 		if (status != DC_OK) {
 			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
-- 
2.25.1

