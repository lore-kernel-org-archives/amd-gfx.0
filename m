Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AFDC4706C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377DE10E53F;
	Wed, 10 Jan 2024 02:27:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBAE10E53F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dET5fME1mUC8eoOmzkluSNGwZ4HHXr4VRhQ8OVyvH43UfT7BvcdIa396XOynYmEHrfJMpKol3YKjUExHVDm5HfSIcJ5zyPxxPF1+iiH6FuaQvZdIYELD5RKPRJWtU6edWQ9JBwGEcQ0u8ZNyLfMJEkCIKHubwN4DB4AYAwkVsCsg8IqHCOEkE+MWZfzgpm2N615vEHdobmC1iyyRLv4ufNvHcWqksCF6uJrZTMwNRN9XiQGSXoKMlHr1LvP3DkHVGU7PJPNg5WppqUp7repaoHSD3+cTM9U6E0Wj+Fp6UWd/2KyYWeu/Xh0mg1q4z49U5SP3qKgoq4X/Ant99iVOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suvh9KmgZb+7LzOca/ax5UL/me0YF66X4CJT7hhL8AQ=;
 b=Q3ZwRe3+Mr64gJ3/mSqXJNPeyZtyINTAOtifb71bbLEpK4iwUx4YgEvTRR2jfqPmVcHkfeM/i4mjke5Y53LoONtp/SWccYJ6VEndIov584Bo4/qocevr9+COR1C77+mTF6mfEc7sN3rYPNSsfGqGsAIBxI/IcplqHfPKpZLNPm/cKE3hxkrP9RQFeZEHxUYL9ZzdOJfotD2rvAIEDDZYkRolbILx9ZpIdg8sGayz6M+KyN0r0v4SZwDo2oCIF+eiSiNtFkoZAiW1bi1cA2+ei/sDNUnzdX8OVr17ick6/kOE98X7R6lpMJMy964RXphud4zr+P71QJTBnnD2kMohPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suvh9KmgZb+7LzOca/ax5UL/me0YF66X4CJT7hhL8AQ=;
 b=LuHffETfhRVPnhQZQb8K3nqi9dhYs9qGd94qukzfMLes7w/qqZNwUcJWDaeZfo4zvtVmIE3yO90Xaan2p8yLdwx/2w/9MoHfPAr7oybsxfeACNF3ogJGDhmmatNIQjI+ipqYFVWnXcqRb3GT+UJKJkJV0svZB4DBN1K2aJOuhkg=
Received: from BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:27:10 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b0) by BL1PR13CA0095.outlook.office365.com
 (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 02:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 02:27:10 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 20:27:09 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query mode
Date: Wed, 10 Jan 2024 10:26:26 +0800
Message-ID: <20240110022626.374753-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcdc531-4cef-4de9-ac03-08dc1183a64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyU7uT5CbEvBGmy8JIlfngoCvFaAzcrgpGlR9oLxEl5WCpd0KdQRnX9Hrq/rFw5k+mvK21MR9Yfdlqz/9N2CXpsG8XvgFPd6LRw6AwJ8gxgqHng8RNySkee8UemK5vn/qvqcq2qrd0dcl1S72tx2MRoqRxr94TrwWacM0hX9SIHrAnVzRe2muwNRZg2zZSCxhsJy9YT3Ygk9XdXaZhx8iJ+K1Mg6yhZ48NZBKHII8K3xopuh+1vHEd+C4cCp3dkKjkVacGFJfUuul9YaHza5D3zr+ysF1HLvU1no151XCFiXF3ThKNiXsi4Dii7eGCZk/AKPatuhTF/uc+zIOXeHK0CSTUwBE6wWa+vqiErkpKrIs08+rLbz+YO7YiSR/PY+6hk8fG8lRL62YPqzz37ICUI0g2nKAgR+8rXpODOnLVeZDxDWOkt5ZCO1P1vDDvdw//DLonoPvTLtSflVLod/e5hSua4g5F+3BgUkaW+l0Fku+wXbS5y3IaNYQOygxwUV3uy6GNrvtnDLkZVaUF5/7pk6EaxXmUm9Z2/lZXiF7Rtn8KrwcLdAymIBErp0I4/So5Y9wjPKNToEtXwwVnJ1s6xhs+JvffkPEne1cOxkNkGSU4bDYoJoqHMG0QhexvrPb7zs+DSuUHg8TEtq/eHSu9V9vgJS4LyhXAlvRQQqoE3uuWI1ICbYB0u+E54iSiqQ8yFWQgLGzDKZYHhrBlbyVI3XsABs7yY82dsnwxqMvjo6JuLfaZHVOtRUVf+GnnCcet57Uu5JtiLNEWceryFXBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(16526019)(26005)(336012)(6666004)(478600001)(1076003)(7696005)(41300700001)(426003)(2616005)(40460700003)(82740400003)(40480700001)(6916009)(316002)(356005)(70206006)(70586007)(36756003)(83380400001)(86362001)(4326008)(8676002)(44832011)(8936002)(81166007)(47076005)(36860700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 02:27:10.7598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcdc531-4cef-4de9-ac03-08dc1183a64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu v13_0_6 eccinfo is supported in firmware query mode only.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2cb4..29396424a99609 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2896,8 +2896,11 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
 			void *table)
 {
-	/* Support ecc info by default */
-	return 0;
+	struct amdgpu_device *adev = smu->adev;
+	unsigned int error_query_mode;
+
+	return (amdgpu_ras_get_error_query_mode(adev, &error_query_mode) &&
+		error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY) ? 0 : -EOPNOTSUPP;
 }
 
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
-- 
2.25.1

