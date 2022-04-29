Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC07C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7357210F606;
	Fri, 29 Apr 2022 17:47:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8291410F65B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJQ01i4LEsZsP6se5YXFyJQ/4ZKCCs0DhxZz8etIHtI/2wQZtL1NzJmdcInTOlMHpIVCpt4XcowyX2AIrTkYCTyIeWOrYaARtYSvblInbX2Dft2ZiT0bGgpoX/e9WmN4bcubkpbZNILnMW5LrsNfHSspCDSuzvcqnAYbSBF2Gp7dz4dmap4TKpnNg1qBDwiwHQ2Pcpz6MB8ONcBlGm7KP6Xw+q23qHsHOhuZ3JRX5M5WoFohV1AwhsOmfQ3h2GNAWmKH4mN3Qe/1870mlyty09p3Rvwu5kZ+UZHI2z7IZEvjy7hFMPVm8QW/LS+7aDZDtkqX8u/qAvave19xWwT/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlv+3PL5wvObgTWVDI+jMyA0pb7ki3nOGLeLrf1Jn3I=;
 b=lyCdGQ/wbQZKFErRyFureEnAQPb1uqgbxRqJv7Wvc7RV6yj4bFP2/uqRsTBYbTqmUGzbRTChpQSpzp4zRzsW4uFw2I/S/xvU/+s3dHwxiATuC+belWTwsk2k95JC8pcg0+fs0QN8hcT1QyJhQyD9SZm+reZorPUmyBJfpMUyzIOjdz8R60N4xJPXFvN32dIwdZ3DVYonNlIUxMSUWxE4kMQvY7p6n4qhY3cFJqmaNWr6dXUuGR2atPRybWCRzfyF1EH2v+E6EfXoH8bpfS5x7tcOUTvFeNWEoBi+UHcqSkC2ej3tgx8fPHgyidMi7ZnHzJmj8cUJaNQ8USUJiRTkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlv+3PL5wvObgTWVDI+jMyA0pb7ki3nOGLeLrf1Jn3I=;
 b=BgzlnYU9CxzP8i/HatbMqFuqJMhIYgg0G8WWMOfYx34Hi3USN5hXQWeah2vHQjwRnw6yI1p4VWtsrsVyu/uySg+dCnpEue/VXDaSQKp8jNQMPwTO/QMrQsUVytX8ZDwBmykcp0yl6q772LkGVEUgB03icsoLr3Apid7iVOM846k=
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by MN2PR12MB4800.namprd12.prod.outlook.com (2603:10b6:208:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:21 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::6e) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 70/73] drm/amdgpu/mes10.1: add mes self test in late init
Date: Fri, 29 Apr 2022 13:46:21 -0400
Message-ID: <20220429174624.459475-71-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a16da9fb-703f-4402-b4b4-08da2a084f93
X-MS-TrafficTypeDiagnostic: MN2PR12MB4800:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4800E25CA49FF4FC69E02349F7FC9@MN2PR12MB4800.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F72pI9VJmmvLdG/SZhS8iIl0tgubB8Z+RKKjCGk+YJweOo5Hb7m0GrRowXaz3rlHKA8YOpqIlTOepAmEJHe7Bs2o9UQLwlmvXW9bNb5hip1RxscWxJHZ5AF9iMqfubqXYO1OzHQlX/0FQrTrCwxzP3GClQZaFQDq+gloB/rYEdQFCheFkLzXr/MR1DH0myATV+I4cNuKPBuEoqpCFLMaXf/ts4wb2HBkc1ExIb4dVu03NICYPA5LEjPoYB1bnbON0Rv/eWfYtVWOOdPW088uvgfdtWNq4ZfeG+L6NVu8YE7G7gnOUooqZvsIzUuayZkbfEJ31dUjtOdz15lQV+UjRSRFo17z2K+eJs/UbxKe9kEOW5opWBtmyBN9EJzg3vpZriSd0pqR3w2cLhg61QzWaomVxjoctqSKEuUVzdPa7wClkBAgEDDWGnKs5p5rINVDjqm7r3k35F4ZTaC3uIkpoptrn9smX4CgjMhJcIrLmaQpce+wZ3lt6NxHvXlG6xGXWz6PUOyQ51ZPb8oZC3YqNt68ZmlMwgLsRslUmg2BrgmxBqmQUBQufdt18X4cHNwJs5mgw8LkaOTwzN51fGrHZJFsChLqJlB4lMfkFllsNEsK2QmlIaP0Q5v7kI8Tbw4CSgpV5mTH5h3KsLUm8cRYoU87zihUbXHPl6ktEuyBW0ElnMNmCKrpbPuTkq4EjhgCem+tYd3v/3ULyKMIbu6eEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(426003)(508600001)(186003)(2616005)(86362001)(36860700001)(16526019)(82310400005)(336012)(40460700003)(2906002)(81166007)(47076005)(5660300002)(6916009)(70206006)(54906003)(8676002)(8936002)(70586007)(356005)(36756003)(7696005)(4326008)(6666004)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:20.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16da9fb-703f-4402-b4b4-08da2a084f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4800
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

Add MES self test in late init.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index d468cb5a8854..622aa17b18e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1142,8 +1142,18 @@ static int mes_v10_1_resume(void *handle)
 	return amdgpu_mes_resume(adev);
 }
 
+static int mes_v10_0_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	amdgpu_mes_self_test(adev);
+
+	return 0;
+}
+
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
 	.name = "mes_v10_1",
+	.late_init = mes_v10_0_late_init,
 	.sw_init = mes_v10_1_sw_init,
 	.sw_fini = mes_v10_1_sw_fini,
 	.hw_init = mes_v10_1_hw_init,
-- 
2.35.1

