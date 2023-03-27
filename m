Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E724FC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7BE10E736;
	Mon, 27 Mar 2023 19:46:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B18810E736
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSjagwf4qyrww2U9XrT1tOXUmUFeM/lOLN2EXRtqR3VSsmwv8rgE3Eohp8Wn5+Kv5xXpHPOKpb1JJt7ndD7xpvxlnA0dXGO+ZHRQdofeZSsViIkHNKIKgIi/+Pm2RQjstrOGlQPiSdnJAxfiWjwcxLQbsNtSvmTePD+cAxl597tmoI0wk1u4WdzGQqxFqDo9C1QQ7YiQET+Nh5ng6UVQZHazFzrZMxXxqY6G3Kk9zMU+K8TDnKE8pz34bHI3SuZrNzVNJftJK0bJIvaW/L93ad1pq1WalHD+dYSBb69uOr+WMCmPeZtVX2r9Xr974Z/TtC7iyDG0KtCTbolzbgILEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiEeFB0+RRQx+XoYkOVQOZ0C9SacYUXAcFmcyU2WEhI=;
 b=fqKD1hEr0Pc66NboQCiGhsLvIas8ifIffRhRNDS0OfGEcNbYo7loUxVeJJjPHQscA8iZWvBTr5UsMsucSP7jA6TCQjZ4J5srQIzMDgK7LoNfZISq5MR1wb6ePBgcyRoyXeA+YiT2jMbqqIUEW0iIlTEww/of+7b7CzlPliWMjeKZmbzDAqjc4kiQ4VUI31XIRPhA7CKJYlaax7Vy0u4KfnS4bNixtCcVW0oE8JX4GzJd78viDob3xMMy775JNwJdjsCVpQ+9HfLmOyJjUH8vLsIVO1a5ok9vZDto5/QCdLCyyO5zDoi5uFM8N1nu6eahZG7kCPgHPbTAzhZL3dVIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiEeFB0+RRQx+XoYkOVQOZ0C9SacYUXAcFmcyU2WEhI=;
 b=BZv3CLMtw50uSKBCH1JdJwkG+4c4E1/bnDWVWIZe77WhkLG64ynnn5lBIs1B/QN0igU1lSfiZK4x5ZKPVDKtBDppVanftpf1HbDsrIn+VjLDoIzZ13RrYLvO4d4bd7j8Et+t7Fler3pJ0Jmpu5hbeoFfcEABgwN+dklSSO4MzkI=
Received: from DM6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:5:15b::14)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 27 Mar
 2023 19:46:42 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::f3) by DM6PR18CA0001.outlook.office365.com
 (2603:10b6:5:15b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amdgpu/vcn: enable vcn cg for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:18 -0400
Message-ID: <20230327194622.8109-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0583d234-0804-434f-381c-08db2efbfd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1f3QqExZf+rRejLzagfOr9l4d8BZg3iymDEcwHiU8D8pdWPWURJcP83hj+1N345BdM/vEjDbjORacVv44gafbkWMnHSFTyQF6TlJc5EBDiK3O43PVQlVGghonPUK4xEw8PMBta/0+wO6wI/mKL1qT0T/tYcwJIj0EAkK8tsfwd9q4hxfJ0bpWyEc35C36KeLOIOLejOYmj0tl/eT4pYlwUAG9uLiwM8ZGSwd/SthMrRERL//OQSmE4tLofiixepVRE0jQXil6xb2lLaTp3+Hrj7oZHbw8KZFrLBiudX8xTFg6+GR23lRiy3XcvhnTB8D/WeQ5bfCs4l/QdgBmjiz8iIm6zHViQyfcUrHuo1JmjkMMJpo0kCDxA2+LvQxi/bsSoISIE33ZB0AN/6KnTrMAJYe+yNQ9RessNdmgciyfZpMeL64IqgQ52dmm8E/YqJhybs7/T0pzVDzccbce5BgWLPbeF/Lq4c2ykh79C/Nmsrmz4QUA5KJJ9U67WOQYgH+fbnkyvTVKt/zKOvOpFR/GupMFASpEJTImyYD05mtYWYPQE/JPNJD6uCtUul7USCQ4v2MGZN5o7p+WbX55yGFVltrCBH+R7f5N1yfuZHvRKD4uXAF050QlK10XYBCv4cJOsgMOeMuvp8FclyV99/l9bQHlPDpZm2UYp0m1693xmm+0rMWaakvJO5ec0y2WNOI5NBrOU/U1s3XtLJhBAJ0E75Unb78/R7kxKf7T3CNR0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(356005)(36756003)(81166007)(186003)(2906002)(316002)(54906003)(26005)(40460700003)(40480700001)(426003)(36860700001)(2616005)(6666004)(336012)(1076003)(7696005)(70586007)(8676002)(86362001)(8936002)(41300700001)(478600001)(6916009)(4326008)(82740400003)(70206006)(4744005)(5660300002)(16526019)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:41.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0583d234-0804-434f-381c-08db2efbfd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn cg for VCN4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6e66808b1f26..5ccdf874da14 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1104,6 +1104,7 @@ static int soc15_common_early_init(void *handle)
 	case IP_VERSION(9, 4, 3):
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags =
+			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_JPEG;
-- 
2.39.2

