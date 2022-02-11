Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ABBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8E110EA01;
	Fri, 11 Feb 2022 07:52:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AE710EA01
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFgnYLWCbovgxJq6UEpIm/gYOh5KFCBPDxK2QwmQRU9viS+lW+D8CHRVYH0QPQ3tBygEAQ+y1oE5quyslz36o+jRgjIDSLzP7wXBooTeAxUVYNFpJN/5My6R1EOAkwpSr7tfqizzmsZaeKRKiMuGeY0I3V85H6KcFSBZViOHRU9yHgVcOD80yL3W9ZfXbVt14d3aYzBvXX8fITGXuF+FimxuJdV8mbMYb9tFjgZdDgdXhIVKlTCBGn391Bk+nIEFQCZItbDK2Dv2C22YNeYlKTINYZ2sjbTaQmcJ/gjGVT/8DSK5ifNKyXkHkT9GRNWJPzcOOfatflRcsEx3gZR8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3j2lJ9XjfJ8Lxlha8WPzkmzQPG+WxfQcc3EI0K27WI=;
 b=g+5JW2fQgz8Pr0CTq8/VAgH3lE/MSCVLvREAy5w+HrprwRCTR8DkS6pPKQHdzPj6w4/GrqZPpT/H3Q1e9+HJF4fcJmnrzLCkb4Vi8itUPAGp7EK9WnistWWEVB4461TeuTowyh3sTpmJhZEN9cxzMQpyPmMM4dpWF/5AfYxbVBzgnr0Z4FRgwpp2xxzAoY8769JWvJ4aEZFKBR5sniP7dmJpFBjnH6wD49eKI4WbEb39Fyz2nUYZGT/9j4udAzGA05/o7n+GLHk4Dxhrgd5IYjBzYSwLl2j/OD7SdzSIbpiwlGkMjrVOvRv+Dl3T7Un8Oi6qTtDYECulKbktWnmZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3j2lJ9XjfJ8Lxlha8WPzkmzQPG+WxfQcc3EI0K27WI=;
 b=fuM6F88lGg1Zx+V0ak2KB+WQKJ3PMTE6YL5HOJeXqMgXml1yC9sbUKIbvzUptVbreLwOezERxjivAahe0I3dHxGs1Ooq6goRNFBVJiEjX0BIph0ZRLgnSi/qr/1HS9RPDGpHgz5HMH+6zuWzPSuzCz2K2NVW168/uPDhd1PKs80=
Received: from DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) by
 BN6PR12MB1251.namprd12.prod.outlook.com (2603:10b6:404:1a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 07:52:38 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ff) by DM6PR13CA0015.outlook.office365.com
 (2603:10b6:5:bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:37 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:35 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/pm: drop unused structure members
Date: Fri, 11 Feb 2022 15:51:58 +0800
Message-ID: <20220211075209.894833-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ec2cfb-7b45-4c55-7e82-08d9ed3378ed
X-MS-TrafficTypeDiagnostic: BN6PR12MB1251:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB125122610EE2F4DF81CE3455E4309@BN6PR12MB1251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boNDIZ7r1928KYWmxVJWssumaoGUFQtWrDwdqnI46awPi+RZMUEkUAsVnWItnkHsnb+83JCKQozP6v5ldcfydZnp+Kj7rQRX5S2+wQL2GZICJp6qonpXlj3vSy++0CqBky1cuEg97lEuhgec1cFvFlQ1fM4K7B6O9VmZ2+UMkyoZnRT/xbnSF2744jjpsjBZm+qS91Qv8gcEIOmxwmTATNvoouszJRM9ARSLwNKi7eXAhBLlgHFi5/ERivVHVA4zx2BlfbDvsxrehFbfkgum4q7Gr3qYFAwd+GcGmymZZoAhfJ9tKW89oT0IyR3RcIYn2mNdcc0e0Et8G1PHrKZ+banxyE6xjZzowt2qlMrGswHpERPsrEcAnvhWi3MTnaWxRzrp6kIrrlE4b3oSULpNdNWMLKIVCNNu0MHG0c63tbhKaXeW7m5mjv/ihWX0mepPmSCrF3OPrmS9McUCQNVo47ObY2KgUE16kO80iJse/w+ae7Gcqp5kFaHBkwzW8vmYjKk9Kn9aJ+CabSnoOXLJoTSZIejzLG9DtMsAgrLwhEQ/nMfmPsJB6Os3khUAYtw+H40pv9Hr3GkzXo9yICrgJuzrnXRlD2BdJinLAN9TRFCFoxKLMWfatJJXMIcnBge7sb73+eYBFLyT91Ko8nnS9n2iFcvaY/S7FAV0loDiYqGa93tC2Vcbp8cSJmnMEvGT9lbAKhqPUC7qis2+rX2xBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(186003)(4744005)(16526019)(508600001)(82310400004)(81166007)(4326008)(356005)(2616005)(8676002)(36860700001)(70586007)(70206006)(44832011)(1076003)(47076005)(5660300002)(336012)(6666004)(316002)(2906002)(83380400001)(86362001)(7696005)(426003)(8936002)(40460700003)(6916009)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:37.6487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ec2cfb-7b45-4c55-7e82-08d9ed3378ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop those members which get never used.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iec70ad1dfe2059be26843f378588e6c894e9cae8
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fbef3ab8d487..fb32846a2d0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -373,8 +373,6 @@ struct smu_dpm_context {
 };
 
 struct smu_power_gate {
-	bool uvd_gated;
-	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
 };
-- 
2.29.0

