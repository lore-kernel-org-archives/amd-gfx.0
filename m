Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2B7ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C07810E394;
	Tue, 30 Aug 2022 18:40:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED0210E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcaDh47KEnr4sZS+DaBmr6EhmtYCNlvOXaTlFHVkzYlmuBNzXqUf0vk0lqV77ox0E4kXhK8X74XMvNbO9knebHDtSWKiCNaeP6D94DVpPDHCvG2TKaPOvHR/CzoatE0DGY8672DbjlTKK4EHok6M8CBw9pMIvEWrf+o+/mJxXW/jAe/QsRHpO8rOYTgtqtdq8KKcAku3wyn/gK0Rm1eZzPKvqqthQmMp2iHtnL+qVR0YspqfZtjZj2d8Hlro5Xr/WR3KnSHCc3IpFhZd5JIWDt4xMdWljQaKFofP9xlFdIklNbPK5/4HiJvErv5ENk2fUVKYwVa5jGw+MxzYsGZUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsMKqyZ1oLqKZWgS4chGFFcfjTxfdi9vNdB70u1/V9A=;
 b=aRQSOqub32lJPsjYU0l43qdwBdKamFN8xqJyVNsHCT95H1QnkkDJG/bqj0NWBSoDlmlEkSg7FH0edNJAnSgBe1/aaAU2aPIBNrDSyVOcDW78hnTTUV9O5nqX8BUlDR9AEapnC59lfT1wlJ3r1tkt+RiBcbjbuP7HZwcf5leNPdqGBQHQCHNH0K1Q7zXXLb7YRveK8djGRrArrKqJFwQ5JrWSHhP3+hKdwAunvztzAqTouq5NrnFuVdZDFY60pMx+AItUbOCAR+Whl0zy2H/z8ClmuWudQXlMSk6Nt3+WXWrA/5xA3yJ9tuF38sBOQdOHB9GvPCmj9De9POnZYPi1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsMKqyZ1oLqKZWgS4chGFFcfjTxfdi9vNdB70u1/V9A=;
 b=js6vRAzsCJo8yvnIC1y/vZVc16iyzj4cdG/0hOEapYZsaxURJaLaxAXC+LquvUZ6gXfYdWegmAvr2SPPssH6yGJXNITuYpM7pB10OcMQM2pPTeIsoWqMs+aF/A9PZuXYGTaScnEzhaBLPhfqn9Uds7qEbUwLo0+hYDepGQN00Z0=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 30 Aug
 2022 18:40:37 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::7f) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/admgpu: Skip CG/PG on SOC21 under SRIOV VF
Date: Tue, 30 Aug 2022 14:40:07 -0400
Message-ID: <20220830184012.1825313-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de085b95-4616-4736-e540-08da8ab72177
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3MJrXHw8pk39YltJxTimG33KdNcLl79NrWKwxFetUSLAclmzCREPOyU20+7SQ+2H6XYwxs0R1ZPDZRQX/04RA1PQ6gH/D3wI+ZhLgaqWytA33rWMPQc7D1C/RmIcqalW2KIXFpAMnxMq+h1drIlR3rgYp5iCjAK1NwAG9uywmZCRYofKmx4z5wMOh28z+AOLuor7awEp1YM7G9dDxhcmziIhyhqkrnQBi7VYN18m2SPVmxqRUFiQQNSts8di+h854yD87ozt9rX3fe4BtqDmrUmXmCi56D9bY+1LwjyvXsktKxHxeLkhfPhBWR2uLP5lDrlS2ky1t3huw94Xlm+xogLAkMg0XpSVIcaP+VN5LWqP7JoA6vKWEDeeyQhmdrSN9qzvIcRTZucP4b9Z4FBaliJ5m+KLCN+EJOPsUhA0gj955qhSQ22x8o3LqtXM2Xp4PK0CgheN8t8dTw8pZO7wmyx8rfNi8quzYNeMS4XNnHe42Vxblhpeh1/CzhEih/T+85kKO0lGqO4DHv9Y3SNPeD6fU3uRCygCz4AjeEPM33JxTldgHrD/UzbthW6Zo+I73Ka+GI6L73jpEbfuxbYQvTGQKEzB+fSuw1zXXLUAa/8Ce9xkUEjI7AFWw87i2b7gB/c3+z0tFVl3n+/ZfC+YqoNwWixZ45gPetRliBhScr4Ic01nzn2vhZOT9DuO9R2mzceHUQC/pESUpSi56T2rlkZj50H60ipMKX2RgPmXAIvZ+Is1mC2uugaJOEiQxu3tE11/xp5K8cbEXZvvMFbny+L8lFw6eyorhcXZ2cDFNvUQK41am63gP6SH2dgOla9KPshf/0LnFXzWeGHHl+anRcZ+0Gvt8F2VN0rdyw4eKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(5660300002)(41300700001)(86362001)(70586007)(8676002)(4326008)(70206006)(81166007)(356005)(36756003)(478600001)(6666004)(83380400001)(2616005)(426003)(16526019)(336012)(47076005)(186003)(36860700001)(82740400003)(7696005)(1076003)(316002)(40460700003)(26005)(40480700001)(6916009)(54906003)(2906002)(8936002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:36.9469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de085b95-4616-4736-e540-08da8ab72177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
There is no CG(Clock Gating)/PG(Power Gating) requirement on SRIOV VF.
For multi VF, VF should not enable any CG/PG features.
For one VF, PF will program CG/PG related registers.

[How]
Do not set any cg/pg flag bit at early init under sriov.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 47ef671543b3..34a267265971 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -582,6 +582,10 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
+		if (amdgpu_sriov_vf(adev)) {
+			adev->cg_flags = 0;
+			adev->pg_flags = 0;
+		}
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
 	case IP_VERSION(11, 0, 2):
-- 
2.37.1

