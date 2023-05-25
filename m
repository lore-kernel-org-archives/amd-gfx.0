Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E208C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 07:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6C410E12A;
	Thu, 25 May 2023 07:46:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B0B10E12A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzNfhsD5dUT2nA3bfPYTzB7yKoYkMEe6UoEQUwd3MZGnon0ZEmutMVT62oc1BJPVLqcZxRW+EPTX6xXZ/GqIUt/DuFUMR6YUWnD/jmnKXgVCsi3GmPpLC5tdta+Lk30ocLTgMZLxeDUIITcqkQm/eirk+aBuDhyyHDM8+DU29hQjLVdE0g6RO1SXxI+5D3+TjcQB+nheJBpgun1tEHGKekK5siHWE/YVSlMshIE+0TZRvP/5IDaRvuyMsFNH+rcYWfaymTgZA6BvpO3nVeicLKjqWxeJnM8atPRbok569DXggBwb3CzL/h8A44Ct650pqS1SNHqvQWvTjI6rvwk0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUY00S58Gppps2BVlmWy8MUeMyRV8uHBbST+FRlQ6bc=;
 b=aB/Xyn0AcMAYK19Z2W0m7VwVBDO1TJ5cQdM+BcpnIqKvmLpKV6wvwz1WXQVi3OXZF/SqxwktSV19QLqEhexpSTO8Rq7PayuNp3uOtThtSejYy05z87GAu05TyaOFgj9O0YjpihG6xu6HiF6Iby/U15NwzZkUK9tbWOqpnLg5XEqMeggbVptKbYnNEbck2NsYKVlpR91Z7FhUY8X2VVh7o14w4t/RykrH/vd9MB179Un8p9/l9RcEMgmDvM5bGT1H2KRONaivOxiR9ZTVZlkLLBbhj/Gr4rxP6siO/MlHaaGjDun8mdFUcCsasYP8PHOgv6i7UNxXWLd2Lccp1+cMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUY00S58Gppps2BVlmWy8MUeMyRV8uHBbST+FRlQ6bc=;
 b=eyqAabHvhJVjfkEVP33b4q0jFvF8Fw34Uj0648hvbncukdtv9dDoCxMJblEpzIb3vZGn+4HODqbaiSsAinwtifzwgdGANmUYPkCAVm0yhCVUCRw5DZBVCIpi0ZHmSP6YcwNyD6zCxqzxpUiCrJOoHAg8cbsLZWlIvEyx5kpwHoY=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 07:46:42 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ce) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 07:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.17 via Frontend Transport; Thu, 25 May 2023 07:46:42 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 02:46:39 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: set the APU flag based on package type
Date: Thu, 25 May 2023 15:45:45 +0800
Message-ID: <20230525074545.24166-3-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230525074545.24166-1-shiwu.zhang@amd.com>
References: <20230525074545.24166-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: c198fac5-87d0-4e76-8539-08db5cf42e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YesrDoBzlLUsBt9Ivq3y73AURZEAEjUrien2+jTqSMHpn9c3LdFPW6rGJHVUCaoGtsUrBrEEPOQmAGzvYSKvKYKBH8s2jp/4HtUuMNsz17KO113EG8ZWVpfkInXJ4s/EqWSFMsPT9xax507TI0T4aCbORzoyQGg8xvEaxrGf5msOINpEjiDJIm1dSN5k1vwSDLrbgHKMfAkpY+trjUt4mOY12cQZ7hHHJ7jZ7ie673bi6O/lLo+0hH+R7Mi15pbMY/BJyLYn0f9ZsbavdrCUKQNro4N5Pr05Ky5qgH2xw8C3mdQx3rv83T8PsoFP2RjN7c6DLe4a88cTl3/tl/5R5llzdyMPq1iMNasNsvLmGgcKjqIoRUqbSABv90/pOW74vUYw7rwJZdie0B8aKKzDAu/xK2Z4MjyrpW7a8zojVuzG6Z1slhLn9nAsoOaFj4dg6pkSN7rV2VbGBuDfdyA8MTggTopuat1uD5Brnp+rPbEBSPzY9WvpAEO5TUY1+9v46VZi6cnc2OQ2TEHqXGxLkQxrahUowIs6OEoKmf4QuXo2B6WOR0k+2kAKyCaFn0tzCLTkaFukmyv8Y2XjsEaEPD/zrXYVLYTvIBK4tBqhLzEaMFuBzNvE8q1K/YpZp3X6D1S2G4naBzkTW6jnGCZMUrPR1oio5jKYphigahKhC76eMzGnDbyF/ga7Fz3eoHdF88M1k01jKMfMc9je67sUl3EiKVWTlb0VWhJaOij7a3umnh2dtFf2bu1pmy23qBU/AXKewAdliPD4l1zLZDjWjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(70206006)(70586007)(316002)(81166007)(6916009)(82740400003)(356005)(7696005)(41300700001)(82310400005)(6666004)(478600001)(8936002)(8676002)(40460700003)(5660300002)(44832011)(40480700001)(1076003)(26005)(16526019)(36860700001)(36756003)(426003)(336012)(186003)(83380400001)(2906002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:46:42.0299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c198fac5-87d0-4e76-8539-08db5cf42e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since currently APU and dGPU share the same pcie class
while gmc init needs the flag to set up correctly for upcomming
memory allocations

v2: call get_pkg_type in smuio 13_0_3 is enough (hawking)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a0685a5ebda6..859882109f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2500,6 +2500,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(13, 0, 3):
 		adev->smuio.funcs = &smuio_v13_0_3_funcs;
+		if (adev->smuio.funcs->get_pkg_type(adev) == AMDGPU_PKG_TYPE_APU) {
+			adev->flags |= AMD_IS_APU;
+		}
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 8):
-- 
2.17.1

