Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA098C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC6C2072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DbAFyVbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5849A6E588;
	Tue,  7 Apr 2020 07:53:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0286E588
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 07:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV+jgFtNaiBYljvaHX6EY3iQe1uCyN1gos9Z5inYa1ap9vwOIDAnis773h/vsEg8YxGr7uI2CcoIpld1EUdSQp8bZfyU8+o9k5jAPuuwhjzjclS4yDIWXC26Fi2WXnKw7+Vf0RNB/BUn7CioFculBkfXfM8EP5OHdN6dWp4v55+NOMXxz72ZqrZ/GuAXdkRC4yHJOuMpHaZeYaTSgvultxqulp2Xy5ExzlvgGGN3IG4nKJvDJ2mEU9+bubrDnijnZLUypppj++5HWDJYhfayoGZXEapmlqJ1WLVU6LjaIx9k9PiNL234ty1M6RwBHnkGXY7NxaIPmpcgceOMUIn/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hWuRKXciQ3Yc2TiUxxT+9EjQaBp+lruAjtsNdWOos=;
 b=DZ13HbErmUXvbvV9SMwjQ8v79yj8pduSS7IP4vPoz4iKXwnWNZfVHlZF/WvwgspJAqk8zjB1gKSBO0SXjRA7kQWpZW+7qxQOHRkFp2Uc6Ovbd2OKq6bydXpVYCfKFxeP/SDugR1rttHyY+TqWrJQKSvZNWaeBmXvE3eFXVMdtvVFrAJRUMvzR+8Z9KlO9SjBDlBx3KSx07HCY0eRi1PjSdTeAi4nmF6gbEor4wE/l5Ioa/ACjQrTu2inCEL8pvAqoeBsGoF1ELTl65dVJSOI2zADLJlvKcJ0bfXNLZtmI967yq4Ahhdhjkja8tcEwxY9B40qJ8KyCdjF5qQewtwH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hWuRKXciQ3Yc2TiUxxT+9EjQaBp+lruAjtsNdWOos=;
 b=DbAFyVbXwt12be7mUjbFct07qwrFkA+lRu0afaFonwgm46mKl0pd+o0//sEtdCUI0UWNW5/3bbtIbJ4SoFFHedWfSS7rZ7l4a6f9sKbrTjTyD3pvqpyMkGdnmEdBW9zuQEsYkzdglBuxTr4D7J42X8egWohSpxjEJC/Bcm/FwFA=
Received: from MWHPR11CA0015.namprd11.prod.outlook.com (2603:10b6:301:1::25)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 07:53:01 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::c7) by MWHPR11CA0015.outlook.office365.com
 (2603:10b6:301:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 7 Apr 2020 07:53:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 07:53:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 02:53:00 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 02:52:59 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 02:52:58 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Date: Tue, 7 Apr 2020 15:52:51 +0800
Message-ID: <1586245971-31228-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(428003)(46966005)(70586007)(70206006)(8676002)(2616005)(186003)(26005)(426003)(336012)(81156014)(8936002)(81166006)(316002)(5660300002)(6916009)(47076004)(82740400003)(36756003)(7696005)(4326008)(86362001)(356004)(2906002)(4744005)(6666004)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb9007d-71a7-42a8-1bbc-08d7dac8b1f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2927E36FEA69EA11B500BAB6BBC30@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8yytCpIAAnb8uFOFllo1QKzhc0BEOxNEKPqm24gN7sJlGBf3oPqaai3PSrO23kcN50cXSXLFlbnuwVyl4Cxu8SkmNbPK/KxCbMYBQoaFOX/BAyhclUCw8HGKu1xfrr7ZCpQPXgPCTIZbcHYZx0YUiBOy/nv4d5EDB4d7O56vfrVlVT7HGjbkj5PHSeyAjZ3GGijb5WP5HgUg/ygfvGk6HtOmACQCEukXkhU6qFLECaNoenTU0EhG+gVvkf2gUI9YZesejkaJ7bCOtNmVbYkCECR6GIQDLaIxvQmuV5AOj4DR/E4WMv/6dMJH9O8ZYNnZx7KniHrafaYkohlYmf2npCQfAOhBtkZJZy8cffXhKxKz6Rr4KLuORtoEjmHd8pEvLXwPdYyYhw+98ohyHERZh52FzA41lZj5dEMGPlAirvhIBG4cJnKJLri1NkRTeokhGTevQ0PzbL8LIZ/WSNzVYcjZMZHXVsAYu57Q+6wvbzevfHeChsaUdieFWP9zevAR0/4/NDRjwJjgVThiEuY5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:53:00.8561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb9007d-71a7-42a8-1bbc-08d7dac8b1f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those
allocated memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d94eff9..2e1f955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,6 +3852,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
