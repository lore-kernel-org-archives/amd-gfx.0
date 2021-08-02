Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B9C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 09:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6781860E76
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 09:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6781860E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248EE6E524;
	Mon,  2 Aug 2021 09:30:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252BF6E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 09:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNkbwGNVWG5TqJsLIuX3tPEikVXqwvaFHHLFYwZgvFkOS/GNoG0/EUQKgIsW5oKBhMx/DQjAtFGkR0DHZIJcHK0n8wLjDxXOWTi8R4bFnAjgIVbJwY8lV6x/WLjSF2H9nm9h+zymRZnZ9o/cI76ZX0tg8yReweMw2I16vQy+snYQrOwfpsLRT15ivg/mIo5VT0pnIQfgMKFI3DiUwfL6X+xUo541rdcSCH4LaWHML/NxLRlMt+HTasQyqMP9EKtm38g8/zGRAp2Zh/5TFvUQUVbjnDalSTy4jR9++uqywBYCxPQtj4Z0n0kIjPJob2SmJWU97ltDUP/NK5UPrP7cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUOzDBn9zS6x6uBebfPQhGQvoAbi3ozWter+1V0u4VQ=;
 b=Pluo3UPqzD+i+I6xvDhYs8mH+3LYWdiiZ9xHIMBOWbnYsDH8r9TJ+k+g+R5TrnHM8iJ6AgcwaU95ri1qFbGY50QpAyj3yWFhO4rUNZTadw4g667bTPmOG3bfkafqWohgywzugbWP2LiBqa2NexmS+HjRIQrIQnROiq8Pt+5YCecVQP2KSg+mZXuqBa6ujuh3EFDQZpSOzU5GVJqfd3MjidWWVFk0vxaC4bLL7OY055l9NhwI9vofDMMz3GCYlkXjCGjJflr6SWRJGG7hbbXZimS6gmy0AMo39vSVBGVd27g/BW5yJ3SYV3zQkyIjXpshmq8/r8iesSKuOXkmWIx6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUOzDBn9zS6x6uBebfPQhGQvoAbi3ozWter+1V0u4VQ=;
 b=Ds7Ch4lhd9qg54XqWkyP6Yxx9FwyyXUMk9cyUXyvALL2sJcdMccvihm6k1zreEMlymTKqXqbaPjq/RNUUI5B5JMk+Wrgw2RuL9iYduEFlCzMbDm8VqMc2igyKiH0monoZRVB59ZxgChl3rVAgLStfxDebSccaTWiKxh+7XEOq3w=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 09:30:53 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::50) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 09:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 09:30:53 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 04:30:51 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: check CG flag before querying CG status
Date: Mon, 2 Aug 2021 17:30:26 +0800
Message-ID: <20210802093026.277263-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1eed67d-ea35-4b95-e97b-08d955983923
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38173DCDEBB24C94A75706EFFBEF9@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLfOgMou5Jl38TVf8DlctCfowfMb7U5cOA1ia+GdZ9RSKl6hE3lFZTklvfPC7ka6hRvPGuMX+fQXi4FUQJZtlmQrzbjVcZeDIPDCkgag5GoKITQAXhJrOmGK27o0+cf4fDKh6oXNcu6q3HkrpGP4BrKx98QkQl6Tx5WFBM5kxFvcQ1L4ZbGp9+de9SVGHIVRrI+Kyuc25punfiECcDbt8OidkAOEUnM/K3e5Q3uUgneX1WLYOS8gvA0NkEL4SMUb9VFhzPodL+7jHDP2MuyTZSx7eZQhrG434Hcg8Lxf1J12NgE4iV21+UYr68jHxg1SekguhfXg3zP3SsCSA2uwkFxb+cGBOrEY+1kW8qiqDjKhFeA+binXi0gjn/hkYJWskemHKKr+AeuWJQ2LEygbhSqjAkk7qpXO2J3HPgXm8HSXAYAqz2Kk7+cwzKFGl3xbJZaCiFrnSK0p54Vkydk5rF3XfOwL1OaGNozmAr31AzCswtoTsOTOiOdccO3FmD25RE2pRK8hXUG2gVYuFhcuVjtn16YPcohO9s8BhMffMjIXybHi7F9KUiEgSYpnlhz2YrtExwTmZpoklR8a7Ipal66Rg86t1GBKifVywccWoO1cwdFs6rq1fxztXw/P9z7cJ0bS30PBxtxM5lgZrlHCSkAPHSZViD8fVupJo7iq3BVVBKyYM86x6E1u27gBBu4H59TpnqDxfXhu3xnQH5dnI9kDeoorF0yZKFWhdTh/ZTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(2616005)(83380400001)(54906003)(16526019)(316002)(2906002)(82310400003)(47076005)(8676002)(36860700001)(186003)(336012)(8936002)(26005)(7696005)(1076003)(356005)(81166007)(4744005)(6916009)(478600001)(82740400003)(36756003)(70206006)(86362001)(6666004)(426003)(70586007)(4326008)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 09:30:53.1240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eed67d-ea35-4b95-e97b-08d955983923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

For ASICs which don't supoort clock gating, querying CG status
may cause a hardware hang issue. So add a CG flag check to exit
directly in such a case.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b1d2dc39e8be..a7afcdc50ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1671,6 +1671,11 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 {
 	int i;
 
+	if (!adev->cg_flags) {
+		*flags = 0;
+		return;
+	}
+
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-- 
2.25.1

