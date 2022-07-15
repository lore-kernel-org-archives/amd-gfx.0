Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BC2C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C1710E9EB;
	Sat, 16 Jul 2022 14:35:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C2F10E06A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 14:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJpJn0EnLaduspDIGnphugs1buO+zJGt7sh1mX3/wEi4JLJ0h7Wp+jaon+vAhRVRKJB4AEW1PjdzaY5X+vjAFcjnvuk1W4sOZS39bMLjacbxGh3ah8a8YszT2hmZPALDw/BdGFd/dvzwxV4PicekD52JSExBkQoubhNUnq7iaEPLC66P9CTRY2rIcmgJGY13PVQFBoc3Wf0S313Pp/RAt8tLWSkD/MLxGFJWpxbOobfKJIfMDUpvbfkKKJ8Yp/PnYFsvo3wbXeOC1RK7PqKavO4WhTfHmeTEDGLB9tS1DboQ47FNjY5e0OXac+w9sI+svwfCIyeSn7uw8kiPorkaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA4AXF8fPr1yilUjOXYA4QsaAgEuA0BWX7BuUvVto6Q=;
 b=c9w7GZ/5zOdHzZ9IgOIV4f2O5CEko9lGOmkx+72aLzGHkQjw9FVcTQE0XRMu0yDYH3fn0SBNJvXj3PmzhPS5WgzNPOQ8msGWMf22lDVJv7bMRdpek9mw9wP1AgXWgsJvwTjh14SZqbpb0MDlJgQp0uh30sVVQGkVJkj44ZVWYf2wSF6QNKgZKbmba5AJHLYkz8p6PTcdD0rPJyyJxGiEJutF0MIDcd4egX8Sqa+/Q5WRVkhIAotcAtgChe3QbE38+9Sfy93ZlirPNtalRq2C3w2/j4A2+bGYbfbDP87mWEfEQuiQ1U/tJT18gH3R3lWXcS3fR9k/1xIfKfpRCueVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA4AXF8fPr1yilUjOXYA4QsaAgEuA0BWX7BuUvVto6Q=;
 b=NIv2JYmTDgDyIhSfm5mb3v4OeCS+8+GrAH2boAhUfyFf8423nSa21FQ/FkQKXD2jNVmFkAJTSFCdy9YOUru00esCj4pJ52VWhXAL9bp7gfXQBgFfwY5GoKIErgdRZgGERz8QQ3LTwtqMNFOK0fPGXVFZIfI6eNpjmocSkpv3GaY=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 14:45:07 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::36) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 14:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 14:45:06 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 09:45:05 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Date: Fri, 15 Jul 2022 10:44:53 -0400
Message-ID: <20220715144453.46786-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c6bcad-f38f-42b0-027b-08da66709c2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIX/BAtLLAvcgpfUHfwMuX1LhjwxQWANB0MaIfbI9KMauzXP8tMUKIqYtxsQMMCJ5Z5wo72tSbpzgxO2h9iw7cNU+G+eyY2uk3UmF9tkNdwZjXy6MEXRSDkdmFeI4XWcgy7MDYmD5gHzAneX0WuYV6FD3uXzfNlxFem+Mfi3ytXaKPWVUF+sEYtOi8amA8TO86fCYz5cLw3Y9c7rD/TdbcGPkSUXs8DsRQvwJgqnXgbbtt9YappOukR4RWufxUmiS18Hr49W3VKaIyKf4sWXS2+kD4jj4DIzMPlZmlVH1veYKQnLddP/ZQnNSyaiDH1lHLczK3zvt4etAlaTEhPBTFaDEKZTCXtDDjkh86HaMNP3zf6vpEgUaiJF/8YTCSgjw2boRDhlJIyUzuD3mqhDdgW5UUfzqFPutFHzJVB3HbIZh544g835oo8rWmvGrQ5fFc+Dndca/TIiPIvw6V7p2GnCLOEo+sWSljNoBu/YTOjUtXqkZt9+wqTvwO7wg+NTr0t4d5Jwxjsz/M3PIqF6oMPgyFiYhM/0kZQYw7YfN547iW6bjxAisHwBTXBgQD3pUHdrghQlnHDGrUwhm5y4xjpLOEe9bCHk4vdKNA84RcCSBzSLK5qBrrJduhkxopj+98DxM05tKfqHjrwwAbpk30ysMykJY+igafcq6PDGacWgcYHEO3HPSxpRh7XgdVm0FWTI5mmwFRrKiny0MaQeixzcLyDQj+l3o0TUqgZQMtejtpw718qAwKMDHLXXowHuQ75zPf+fkrUzQoPYErvKM7aZnG9JFvIrYFbdrd8Rjp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(81166007)(478600001)(110136005)(966005)(36756003)(82740400003)(356005)(7696005)(41300700001)(336012)(426003)(47076005)(70206006)(6666004)(26005)(54906003)(1076003)(186003)(16526019)(2616005)(316002)(40480700001)(82310400005)(40460700003)(2906002)(8676002)(4326008)(44832011)(4744005)(5660300002)(8936002)(83380400001)(86362001)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 14:45:06.7168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6bcad-f38f-42b0-027b-08da66709c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define HW_IP_VCN_UNIFIED type the same as HW_IP_VCN_ENC.

VCN4 support for libdrm needs a new definition for
the unified queue, so that it can align to the kernel.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..fe33db8441bc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
 #define AMDGPU_HW_IP_VCN_ENC      7
+#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9
 
-- 
2.25.1

