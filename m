Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF2C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 04:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82C560724
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 04:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82C560724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C1B6E8F5;
	Tue, 27 Apr 2021 04:51:50 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750081.outbound.protection.outlook.com [40.107.75.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4B06E8F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 04:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPQcQzE1uhXv0aJeBpItgPUWiQZnFYmYf3yP9rTqggHshVmTD0rn0+7QHd/DUkSBieIxqEfd1KvDu2+wk9BPTH6H/klvwwqbrtMlCDLD4AxNr7uwoMVCvfIjceHiAW2bZSHm2Y128Vwo1Zc3OQyHtC50XOe7Xnm2X1ptcvuyZzYIZkiM4qJsCrjbR1vZMigo1oAbHI2iLxcZt6H9x0Chyh/nxrZnbTcpGA6zD6fsHBxGq15OwWRmo21AXs+sqaLLn0cCm4x0U0lJw6ympO4RFuUwJk1uyefJSeRhvyu1mjaPTpl5Fm14RxBNEElvX6GC2jnJ6EwnoyVVYn4+iDx7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOrzzKxzknGhy+rdgnkSgzx1iN5GL1uKTj5a4ReUZhA=;
 b=S+uVjD686+DDAFLfQPUGEjOlE/vSd5a6yzIz7N7HGikJblRGSWUAY9d/qFRCVpwjfFjLqyqty4Xk0wFsUxKb6atf2rBxO5+dB7ZF0+goLUkK09SciiPKqX3BS5XprpobHENMsDC/vXUNknciN/sArKGI/S5/5D6MJhviwUf89rFwH+lMOFgymW0ZuNWR8VTlgrx3r1XVSMaQy/3ieTsGbFQ7Zh/BKoctcuPYzOi2kWZrrRr7OnHkjnZfzVs05NgRJBvtlgnYUAGWkY2EggzzpLaCpWRJl1YPCZ3J/dHXLMaRec9r4uWN+6G5XRkToQAO9jBJGjdeKQpUX7Ksr4ZyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOrzzKxzknGhy+rdgnkSgzx1iN5GL1uKTj5a4ReUZhA=;
 b=hQjUuSd7DlAnMhCRWLdk4mWNH9gacDX1yXh4DH4qvI3mGxNV0oHqmNv3BtuXygDaZhmmHCv+rJn/yIoX1/i2KSatBjwlykVoaQooZXfoe+zZB9zy4Ha9W7dcO23ScO8A2bRGJD0TVFspuoWlBZA4/2wsidf8pBwo1q74JsNll5M=
Received: from MWHPR04CA0027.namprd04.prod.outlook.com (2603:10b6:300:ee::13)
 by SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 04:51:44 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::f8) by MWHPR04CA0027.outlook.office365.com
 (2603:10b6:300:ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 27 Apr 2021 04:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 04:51:43 +0000
Received: from yocto-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 23:51:41 -0500
From: <pavan.ramayanam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Handling of amdgpu_device_resume return value for graceful
 teardown
Date: Tue, 27 Apr 2021 10:21:18 +0530
Message-ID: <20210427045118.87459-1-pavan.ramayanam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c4b5a4d-f9f8-4924-ab27-08d9093827b5
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4765CC09A9B9262DAFFE3E7FFE419@SN6PR12MB4765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGVVZr0uoGLWsf1P+yAEerYtjkntMP4q9Vzlq9SxlwOjfeKuvOvUUsA9A+ZgI30ZpzHrwi+CFJjyOCgLUOmcj7AHiHWG7SyiRt8mhBGkUBS9rRt+w3SDAA9QkW9NMJHkHvEn0dWix2WQX4LdcrAescrK47shvNtMJ2m15KRDMG1TUQvoEnzxK2eperhS7xPvcLREu64lEx7sj96JDzRSJ0gloYdOudcfwSXIeDD5p5a5gHAiF+Rcw1usOu9hjcv7AzILUdSKnYP747WydEL4mHbM5rcHnyShdMnZQSwtgPw2AxXmg037QKsV7fWODxFbG3qL/t+Qw9GgEMAWEmkp71NFV+wgB8Ndh9T+iT81+yLkrzcd3BfCspeqZOatwzXFa8M0BXWT0OsV8s+MUoOTaNOMlqMoiS2OGc0gyqTwNI9yvmhFFKfalqrh5C7VIcwGDlqHKspNkbK7G9PRXk2+JrqV9clkD8JZKaWfQOpA0qOrbBh7O/F0eY3/dqrage5mTUhX6+9XwsW7tg3w+eeIBUquGCMKkwmHN1ZZbYSBHrwTXMSzZYZ6a9698R+EybwghA5erxYCfdNMB7K3aCN5Wg2tq97QESerP/u9QEjfEpEM7IzQ9f9MO8tL7vZKv8n6yusO2SnpYPqrpFiUH/u6F2sIOH7X5JnNAc4nFWqVzdZEYUPioKt90WomJs0oqWj3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(426003)(6916009)(6666004)(26005)(36756003)(2876002)(4326008)(47076005)(81166007)(478600001)(1076003)(356005)(54906003)(82740400003)(186003)(4744005)(16526019)(70206006)(7696005)(36860700001)(70586007)(8676002)(86362001)(82310400003)(316002)(8936002)(5660300002)(2906002)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 04:51:43.7122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4b5a4d-f9f8-4924-ab27-08d9093827b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4765
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
Cc: Alexander.Deucher@amd.com, Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>

The runtime resume PM op disregards the return value from
amdgpu_device_resume(), masking errors for failed resumes at the PM
layer.

Signed-off-by: Pavan Kumar Ramayanam <pavan.ramayanam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0369d3532bf0..03f3cf194300 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1574,6 +1574,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
