Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE68C43219
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CEA10F67C;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A3A10F73B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1IIVN6prmzmcAfOmALkxkkVT8wQAQrbs9hVCIi+JlpH0358gfXRTNL1w2UHkks9PVJVHZKFwTmKi1AB2GqajH2gCLQWA8y5ibyjBgpJZmQOpfGsz+Pan/GydLsgGipe0GmIOXwKqKsT3JBaGY3Dss2Xx+dUUF3ndYcbmCtYQqR9Idud0tp12RYMb55tOkNwXyOzAfEibKoLT3sh+UF1BUi6/Cy7pM4FNMjWmHUkniqKmuWyB7okk6h5MEQZCQq0MVGuq0KLDAO9w6QQIgKtMRN3kHc2VjNuu5WiMjwGYQqYK4u+b3uq5BUWuFcegPcpqmQ2v7//bZA6z5mt23z86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpBa7lbbQrx8NXBWacTM13HdR64Wa5gHMakJAAlzWxg=;
 b=iWSp3jS/JUG54uN+RKL9DOGs3jQh1Wx5LSYpJ/Ncs+BnK31/SaQelJnRQqh8hgEVEyQowf2BL5w7ollYyCWT5J2JowP0s5HMObLnV7NKOxRZxiJfz3dJSZt1q534J2cZHUBZonafU8v6eBBwF8XGSdBFRLyFUUmEM/mUyU5ffH4ul5UDuGTbzpwUG4Wwa677TlI8PEjtsXXPKLgbyqTsQukQ1LwqV3uCI2IiKzX+zAbZXkVw3cydGLSpuFQJZjfvl++/h2jrLgCnDzJU5ZBXrnxg1E+bAqLafQ/Hxk16IFsvYaMbzcEIMsgK7fkHlcRtgR0G7DUtiqUriNmQ6BTpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpBa7lbbQrx8NXBWacTM13HdR64Wa5gHMakJAAlzWxg=;
 b=oYXOZSxRT+qTehwmDbAhmZqhRsr/lWPBFz2gVQ+Z9yCV8JSxejnnuAeFBxyWGHot8VgCF9lUFAfPXk6R6zs1MDU89Q+kMjXCH3o+StmkfeJ3pbm5d3B3KeZLRrFe88ztudMWl8Zd7rCXoGPbfc7GPUfqKgx3Xv0OOKmzEIlQXmw=
Received: from DM6PR18CA0031.namprd18.prod.outlook.com (2603:10b6:5:15b::44)
 by BN6PR12MB1571.namprd12.prod.outlook.com (2603:10b6:405:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:18 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::e8) by DM6PR18CA0031.outlook.office365.com
 (2603:10b6:5:15b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 62/73] drm/amdgpu: skip some checking for mes queue ib
 submission
Date: Fri, 29 Apr 2022 13:46:13 -0400
Message-ID: <20220429174624.459475-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1fd610-3d79-4437-8726-08da2a084dad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1571:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1571BF3A77E9367C219FD60AF7FC9@BN6PR12MB1571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgnnKXpYlqGv1U4soo4VzrD6rklfoR1mMelE1HsTwqlFtXl4MXEMiywRcOzyFcoAP++jBs6BWyA/w7YRylTiqD9v3y/gT+J3bCgVxJtGxwIh39hS+/ObwzHuevob+dqMwGizNNcR/Bgc5HkZXjNFuX4SZ61Q5jGIlktYXdJsNEtueHXLaH4mjUkB6OuCJI5TGHiH5gArR/NftnCklwl7f0a4ANpfKmP+swMRa0v0HuxVITYZe0h1uFU8O+E+6inovIZuGaEYClsH2yQfA2VqwZXWs4YwtFMP58J2e3IN5ZOBk8Yx8hPFNuWTt91lMPFSFsSnbhsyJ3nv86SBSKsqWaBA3G2wV5hrAyvoxh87+42b2ajdvFq2WMRpHk4LtV5K1rn/U8sf5W9mJH/klXIKDVHkLdshvwrbgkaQMf6d0xOjsLqRalXxyOsjzC7LTIT6UfEIBvK2CerdRqimOzufIGVpQYWKVz+pvht7sPyQII5j2JRE+OEg5xHVU2nGeEtXDhVN6VTK3XfhwOTD0VG2oKWPlUybByljOynh0wKzbXdp4rm9prNztgniOeCf0JbkMKH33etx0UdaD8COVSlH0CPRslHMhqFv5+js/6aolbSzpZBcskKckxPBwo7Puwt2lQPB0J17TJXYuHC9Q/RaLQg83K3Xxlusd8hXldhN3pKyqJ91lty9MWaxGNTu8ZUnIi6C3R57oUAw0x8ysv1kng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(7696005)(70586007)(70206006)(26005)(2616005)(316002)(6916009)(86362001)(508600001)(81166007)(36860700001)(1076003)(47076005)(336012)(83380400001)(426003)(356005)(40460700003)(16526019)(186003)(2906002)(36756003)(8936002)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:17.6575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1fd610-3d79-4437-8726-08da2a084dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1571
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Skip some checking for mes queue ib submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d583766ea392..d8354453cc29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -155,12 +155,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		fence_ctx = 0;
 	}
 
-	if (!ring->sched.ready) {
+	if (!ring->sched.ready && !ring->is_mes_queue) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
 		return -EINVAL;
 	}
 
-	if (vm && !job->vmid) {
+	if (vm && !job->vmid && !ring->is_mes_queue) {
 		dev_err(adev->dev, "VM IB without ID\n");
 		return -EINVAL;
 	}
-- 
2.35.1

