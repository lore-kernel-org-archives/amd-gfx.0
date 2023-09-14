Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8D6EDE983
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 06:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC87410E506;
	Thu, 14 Sep 2023 06:18:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE2710E506
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 06:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzIMhan6OAae15eTCdMnBhT+xzQAl9pzu8xLOafYVQGZCOp7dHBIMtxvcD5oFRNsftE/BZXsWJUWRhLR801Oy9RShoIe6+PKWBYDrJHgXmbT4I1bmAz9X/ceOeOxV1q1DZgypzaJICwb0qXNSfjhCEAX1Slp+GuK/ld/X957YNLWldwrl9yHIDFYSqTW3pUsjWGfrNwFg08LgJcP8Ynwlo3qL3FnLj0LFmJUho9/LV9CPLJtuewwfd6lSeXWBrc4cgT/tLyuwMXia9wnuUn1a0YMnBVgzijs07apym7vfvjAjQlyntT7phYraC5vtR31ix3M+p17LVGExKSHWVjI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aax0GvY4Nb3HNErI7gqFwWbWUZOe8RPhdaZCQys41Uk=;
 b=I5oJs2OMS58741YK794VC/vzhpHtYJ+gLogmaDijsYnOiJfuhuwxHe3U1AO5DulMDssLWIDjWDFE8yOsm+jobo3RkNfDKMxQBNy/Q/433/EyTU2GQyFF+SjIhPvIkFr1cNb5M0nXW9lqR508PJ/cZpMn05jPBVlhqaM5nUfmqC4cAdT5O7CyOLp305Ms+w6CfZHeF01VHQprv+u2P2rzgupfNCzCMYXY9behQQeUq9zZrUChSpv/VBeoYNzmIo76B85mcUOPAJstw1J85/gwXj63NJlKPxxXwr5/f6Y5PadtKwqM6fgco5lM79vlj0XCmceBghPKF/X4Bqt1yw8H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aax0GvY4Nb3HNErI7gqFwWbWUZOe8RPhdaZCQys41Uk=;
 b=jLbhUEuzRLJbiBMQnhaNB9NlyKE+GAkSa8BXuyeFwKYYaVhMAAgLJ9/oMkz0ArQlR5aXv5FAVEq5MhZF27wIecISdmQlaPBHS4IwnUeSBpRJqUVO7yJCe4Qw1TiGq5PGSzLcYUsf5fHeUuaVfbNV040YDQ5Nsy6uHYtaCe1RSuA=
Received: from BL1PR13CA0253.namprd13.prod.outlook.com (2603:10b6:208:2ba::18)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 06:18:22 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e8) by BL1PR13CA0253.outlook.office365.com
 (2603:10b6:208:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 06:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 06:18:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 01:18:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: Report vbios version instead of PN"
Date: Thu, 14 Sep 2023 11:48:03 +0530
Message-ID: <20230914061803.1231775-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d11c22-6851-4144-4304-08dbb4ea65ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CLUvyW+VOagNeVMjH75Nq9SDEoaMFemZMT8+Up871POWXT7z3z44Vd1W8c3Rc3EwCbl/nttHp6fjq4TX3+0ikwUlsHwglozaVhTSWJ3PuaPGxxLJMd77eLQ2LssZgEufpiBM2xmh3+Duv7lvPAl1RxBuDap0oo1wtFCEfe3REfj2488tRBTp91f3N6hJWfEJ9+1hNrTCsx66abiS9Gwe6wruhXA96NdB+csqfttOOHH5l344bV3p0G4zt3aeSf8FFfMKv9kJWX2fiIW3qi5vaqaHaEg9wfIihyx9IWswur/+Av1zZw1BC9+H6ZAwtQXGLy6vhfegNo9UMippR5oIKBSjVpoT6Yw9fj2WfNNtkpbw3yruNwGjn6WixRDGQNWavVHtwElAMYrbU5uMAGJ8xDKpLe9GsJStTqUUFOki4TpzcH0cre05aK6Y+ejkX9OrsAfK0WochFylgwC7frHM67Pok+oHsTFrYHMHRzYG+MwgADMpyBeA2dydBdtxRV2mNuTuSIQcwL/hDbHMuUjyq1zd7nVU00WnNcfEjzREXyauzNbqUeMAUqKJliQ9LlgCq/qGefccAGhuAtSASSv9KVM8ah6xaKGq2t5ssZAx5rIS8VNfzratObvxE2EtXf+P7DfLKii5uimfC8LFoyk9iOSfjr0M/ppcKVnlKy7Gq+UxBDrfbG7eMpVjd/X/OXpoPpPpbXNgee/6QFlaJQ1B21gD5yvVIdU9IT9UthINV9uu18t6CqFcXqYkztwBz/GNgCSgGEzMi1+awSo1MiwaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(7696005)(44832011)(8936002)(4326008)(8676002)(6666004)(41300700001)(5660300002)(4744005)(54906003)(478600001)(6916009)(316002)(70206006)(2906002)(70586007)(26005)(16526019)(1076003)(426003)(2616005)(336012)(47076005)(83380400001)(36860700001)(36756003)(82740400003)(40480700001)(81166007)(40460700003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:18:22.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d11c22-6851-4144-4304-08dbb4ea65ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit c187a67725b47f9c1603359a51b79cc19e27442a.

vbios_version sysfs node is used to identify Part Number also. Revert to
the same so that it doesn't break scripts/software which parse this.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 73ee14f7a9a4..dce9e7d5e4ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
-	return sysfs_emit(buf, "%s\n", ctx->vbios_ver_str);
+	return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
 }
 
 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
-- 
2.25.1

