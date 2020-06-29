Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F89923403
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p0nEVSWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F89923403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3E389D8E;
	Mon, 29 Jun 2020 09:35:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A809D89D8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 09:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxdDUcGjuBbfvdHdHbw4wkmyNMK4gzPdT4RmDbWB3PtGyNZqa1ji6RUIdA4ncIfVyGi+kp9U0FT1YIoFJeHsFSu0SbpK8axHlNqR4FwCGRp2889VaXGXjq/0BCFpyAgXaA4SPM5QXXYset6o/ZS3WqGFmJNYmQ/TsrASmSqDmvjXXSIRT72YNWb7Q3c4ad17C53SYuZ5pg/ZRM1DWXw0Izy2eT8xY1r+AlBo/Zkf5b0Sxg9yh3/2szrMX1tyYnP1/bCbLXfGPxHkvc3yXtVbXcY5UugFKGFzzRa0ANyfO3MGJTtgO8PVxf6YtmQRxc7HlKn/Jf5EbXb2K8+CQoFFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBJAxLBr0EVrCNEMUGJI9c5q6KyOYSfqo9U/Fa0ZAg0=;
 b=Mp09NrrWcl8Xidfz7jgXhu65OqmG8TO7bHyeZEIgn37u08ptwNnARBstlbgQmEERucOrYoQCRRFjSbxEuVkaSlTIy1G0ee+TcARVOLOQIiFxm6zBw8pwZ/fUfje1VRpw1HjJqLhi0J9nQqGwLwJHm3Uxrw13RmvPNNjR6Sx8nBv008NsZHwAOKtsf74KFCydTttaEwIwc9hP9fWcjq79LZvHl44X+xBjUeRCEsvFM3aHRBFkIM7WU6rOJENOOON6aB6+92e8nU6nID+VPD7mulpF5lttkRNK9DhQnqiZoaCmR3tD6Evg6xRfy6pPim+aZtvL0vUK6OvTM3BBDWAXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBJAxLBr0EVrCNEMUGJI9c5q6KyOYSfqo9U/Fa0ZAg0=;
 b=p0nEVSWdbfiPFS/vUPEXLdLFcUCyymJWtGXSvR5VyHeJfVgHBlPX9OdT3KIoENJS4P5/LiOGDium/X0Sla5+4UayodAVA+pRrLmiw2EJkfNItn/7+P4O/QP3Akf+/52RMpG82qm4mh+b4xjVEKgf4D8U0TT7ziiX+L58QdpTN0o=
Received: from BN6PR04CA0090.namprd04.prod.outlook.com (2603:10b6:404:c9::16)
 by MN2PR12MB3248.namprd12.prod.outlook.com (2603:10b6:208:a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:35:44 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::6d) by BN6PR04CA0090.outlook.office365.com
 (2603:10b6:404:c9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 09:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 09:35:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Jun
 2020 04:35:43 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Jun
 2020 04:35:43 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 29 Jun 2020 04:35:42 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make IB test synchronize with init for SRIOV(v2)
Date: Mon, 29 Jun 2020 17:35:39 +0800
Message-ID: <1593423339-2773-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(83380400001)(86362001)(8936002)(82310400002)(356005)(47076004)(82740400003)(26005)(2906002)(4326008)(186003)(5660300002)(70586007)(81166007)(70206006)(6916009)(6666004)(478600001)(36756003)(2616005)(426003)(336012)(7696005)(8676002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c1a349-e641-46a4-dad9-08d81c0fcba6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:
X-Microsoft-Antispam-PRVS: <MN2PR12MB324809CF95C75A383797939F846E0@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsoQTaztqa7nQKVb+f1KOCHFkW+r1DxKufhC1LaXuXJIvXcwm/a7zj6z4ughQEPtdbZYZdL1EWe35Pu3HjtGn9+XCOrtOucUQJ8S0aytoxoUl8psQAVJMebMEpv00tntkGXnEwyzECENewIkf6+NSaZdEDImarzNC8MZ9X+Zh8u839D8RhtQn+4pZ+OWHDZIKrxVszGlqM43IEzt3QUwQne1ARIlOt4tUjmcAQC139tUBCYGVZwQ9Z2oofygnJ5Ids+SsQ3LNgAQSrZewwvXzRhUh0ZTgBCwEYEPC1cS3xFsPrnukYmfGess2xKMSvm2C/r0o3FdNp7lgF6D50VM/XATcZ7/g+5lqNX5Duf5XaYdOczeApEmlt1c3HmVRGZCAMI8r6QHivYq8DLlz4NZBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:35:43.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c1a349-e641-46a4-dad9-08d81c0fcba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

issue:
originally we kickoff IB test asynchronously with driver's
init, thus
the IB test may still running when the driver loading
done (modprobe amdgpu done).
if we shutdown VM immediately after amdgpu driver
loaded then GPU may
hang because the IB test is still running

fix:
flush the delayed_init routine at the bottom of device_init
to avoid driver loading done prior to the IB test completes

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 457f5d2..7a4e965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3295,6 +3295,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
+	if (amdgpu_sriov_vf(adev))
+		flush_delayed_work(&adev->delayed_init_work);
+
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r) {
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
