Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2559C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 04:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48E865013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 04:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48E865013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4314F6EACE;
	Fri,  5 Mar 2021 04:44:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCEB6EACE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 04:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElgsFeODY72eL5jPHxQO6D/HLJm9LeJQTTDwZN9LrnvrjR7yTKhjtiw6tK80uyDew8NEyGeax0VWoLOqPWOfKuzGj6znHIIyeYviXPGgD0qvWPLD/NYNpnCgDlK3Xu3AyG98wsMJTYNG+MFQgB+/Z9YQQTPg4hnZWeaIkpcbJvP1w3huTh5iv79r+xadXVDKbWLlqplFDTGqTO5D0uBwe9jTwTEYU8tq6QygUWHwp96fIz5zgcRE8/nsq+A8ybXjOBIMD5dQPsW7v1S+hZvisltfMJckX/wBFdZiajtWaYthb+/jm7CBj2DbzcyHFcINC5uFGUOrS6vSnPHZXJf1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UyNRSSF8stqXuJGLiNK04ugSzt/H9d4aeUB4wtjOsw=;
 b=FfUvJfKu71dw9Rvf9mc42KCxMsnU+rZ7GUXqJU91c9pjFolzDW0l7gN4jL8eTEKWa+7g+clNTp2w/muB/GI26lUALYzBfiawDo7Af/PwgXaWyArbITT774+H9wOA0gsj3PjYvFcB8JWaW51FescQ0XvlwtmWZtXJH629kwsykzy3YnhpgJJkWnnN8NMaeavYvyaCAIaFKM+bR6Ab7HtMfpJpbDzgjCIQ1qe2JAdlSFchOej4VTw/lxNN5jZMqqtxdcE7DE8tdDl3OS4WSgejCp5MCbNNoFAny/vEwmRvav7+WcGujZ2OMF2Ig18vwW8JrMEAmlc/t+hyWj5xVQhRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UyNRSSF8stqXuJGLiNK04ugSzt/H9d4aeUB4wtjOsw=;
 b=h8qOPjpHlAspCakplO6sdYthSKecf2JGNr2fUNuiCchxYUTVXraOzbXOU7cyNu8TXVKyreRRvIYN3O84MApncoS7a9Q0D3mOi+TjZzJWYI0gh9JycJ4GPhIJP7tMe4ZStKM9WL2+7p6K64ul+brVykcXu/eB3K6UuIo/IIon7wE=
Received: from BN6PR19CA0069.namprd19.prod.outlook.com (2603:10b6:404:e3::31)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 04:44:15 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::e) by BN6PR19CA0069.outlook.office365.com
 (2603:10b6:404:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 04:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 5 Mar 2021 04:44:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 22:44:13 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Mar 2021 22:44:12 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fini data exchange when req_gpu_fini in SRIOV
Date: Fri, 5 Mar 2021 12:43:58 +0800
Message-ID: <20210305044357.302200-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186d65fa-bc5f-47cf-da2b-08d8df9153ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38359F969F4E1096B4EC0A14B7969@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX/dWJCach0wKv8wWsmz2byu6cT3aT/KQ8osgcz7S7k5yf51uuq/Y+tYoT3Y9v8sZG0JGpDyebrj9UxrKcD4QVAgDgqY3MwLguYAJc4nM8rEbXHFgH1nUCltdS2/MYo2qUxMJdNRTNZ2F+oL7DuNaHuJtk9+W9T4nGB4POZ09zU4wBlJXNaPq0e7ygc3XKkE4AXzhyeLC8jSDFRwpGOHrNPnDtKppmavrQSwJL+n5B2ZGGWCCJ7dUlqQNkEPtZrrd4nT7GQ57Yhyaxkr0sZznjE08Qb6m/sHsaQla6QtAT0QAVQwbtg9Qd8DnGNY2ZH4l0l+v3lzLBUt7WJB262R3DsrotPwhb5KHc/liJBtC66+ib1OK+zSZNCyNxb9XN5W5FieABnhHpAtpX/k600g2eU19Kmu4XnCqbiRZKvWWr9v2VzsI1TBpq0/qL9ikO0JvpApWIR3pfcCr8hjWebmY5KV5wKWJLxUZhVV00SKqHoySUM2MNZJoQxZ9uBoTO+Ud4D4LlL5ooiJlwVHIBJVfoS34ytHF3ipNhDJfmWo4hM8a8ijV8sqBVcqr3ueRGmIy1Wp3jAQvEsG4sKI5IT/MLJ4YBrfJLR0WH7VKKEY+v0zs3brCDmT56KhAPs77chlwFId5QUtsU03LTvw0i+6kc13sLyNUmOimCoGPhSPwftG3s+SiHfH9rmkBGuW24uO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(6666004)(47076005)(478600001)(4326008)(1076003)(6916009)(186003)(336012)(7696005)(82740400003)(356005)(83380400001)(81166007)(36756003)(86362001)(5660300002)(316002)(2906002)(8936002)(36860700001)(8676002)(54906003)(26005)(70586007)(426003)(70206006)(2616005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 04:44:14.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186d65fa-bc5f-47cf-da2b-08d8df9153ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, horace.chen@amd.com,
 jack.zhang1@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do fini data exchange everytime req_gpu_fini in SRIOV

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..e3ed52f66414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3601,10 +3601,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_request_full_gpu(adev, false);
-		amdgpu_virt_fini_data_exchange(adev);
-	}
 
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3dd7eec52344..af1e5d8fc2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -114,6 +114,9 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 	struct amdgpu_virt *virt = &adev->virt;
 	int r;
 
+	if (!init)
+		amdgpu_virt_fini_data_exchange(adev);
+
 	if (virt->ops && virt->ops->req_full_gpu) {
 		r = virt->ops->req_full_gpu(adev, init);
 		if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
