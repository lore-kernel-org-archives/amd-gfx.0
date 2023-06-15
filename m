Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0CCEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 14:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC0810E500;
	Thu, 15 Jun 2023 14:03:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB4510E500
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 14:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZMBb0OEq01hBX5UDb7Hb0rgu7O3W9ra/YsWb6kPYq1ev+tg5XM60RSBoSsnYhTteNoajRJUqlCpnUkrpWZaKHzUgCBKy2p3KnR4xeiPBqZ9g/hOPwF6k0NZrCbHDzU3UjJF1iFfpGfVz+cRpRZ2T0r6NngSKO3F6tjALJnWwDfDL2hKKJ8Qcnbl33jfDmjtLeLIg8a0zVoCqdmo0Bl3aBvF7c024B/cwjsd/OUmmqK0hyVaCYZjzW/GXBFppPW10dg/K3BVxDNe7UxzyKlkZJXo7TLesu+KzpolP1mUgvuzIhsEiZJIe+YUb/sb+1TDC63IDdJ8HOyKDXELRsAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8i2N5g2IbK7R+g/jE7e5ep9SxM00Xtk8N4NIxkBvCw=;
 b=ZHgzVBGocaHQvarAv0lam3Y4x8+t3eJ8pvgxyMMdibvPSYg8IJ32f0Igedzznfyl4HP+remg+OIDjxZz2fshJOJtfc9Ouee2CBkqbpzFmpl+aP/BuI/qEOeR3q/6pOXCKRl3TbopgMp2Ue5Kg2f3cwL5MDBhDyHx3gshGpnjtWwjTFL/Ao1GuH9NH6CqUd3Vjp/M+VcfW5mZz9A8q1f+Zujnx2T7TgVqM2cXu20Xfj1d0OCTIKBcJ+X8mqgTePvYnP6o7zIrdqMy1LY4sGurElM4A/tlf/MGNq2qJp6/h25jRqV1XkEoHf0SQ6jkPYfg2AJ3Q719p4Qg5OjpoKqwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8i2N5g2IbK7R+g/jE7e5ep9SxM00Xtk8N4NIxkBvCw=;
 b=HMgHEYLg7fMPoX/8l4JNTnEofvq5/KIP1960oQ5POerDmd1Hbs8cCMUjniTyNUuPVYQhbdIsytZWOtpZFTOKmhAAdNO97kjwFC6NoaQhbAmFTIrFx5pu7l+P8PSvOpYjEUzJ46QcIQfYZL9iCPabx4dkpY24h1ybk8XMgYKDWYg=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 14:03:15 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::a4) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 14:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 14:03:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 09:03:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: mark GC 9.4.3 experimental for now
Date: Thu, 15 Jun 2023 10:02:57 -0400
Message-ID: <20230615140257.607185-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 60606e38-7646-43c0-7a82-08db6da943af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrHlqPCNTFtgBiaRngaXcEo9R9s7Ju3860s88CAa2+7H3gFjASti+A4//RdPzcQmsaCzvDiG6watuzjLDOWkFp/7BShUx8mzqu3pHNWoX+7TArqXNKwjReKHKuo9FbyXh5nqLaqss+2tv4iEY4033QfP4kCu7Elk/79fXLaQNN2xyBgKXIRJ6Y/q53yAA3WhwfjEeijvIqMu0jYGB54AhGxlBQ6ekJAzz8fJSicu9NX6fkpXkos7RsdDrCgC/jNSBhMvIZ3uvkafbttPYhdkA/K4KglujPR5XLXpPJSrTF394s2LgyKRfQ9vXyCa60iq4cHPxauZ38the7U/2MowpYWRSbS644ls0MUDfx5c+t3CjGEGxse1doBfskFqs5NYrmiAhBp52hsknFB5QWTvRLhRYtWAVBD1EU0jDPsfN2LE6Ae6jtsMh6hh7BBPRiDrcfAh2KIWvxLd67KX6Fj5RYscIG8Ihbua6yBczTEj9503ux8eQ+hy55giYnw3uyvMS8tudn1XnW97UrfJg2jeHAlPQZowpUYsoBrdAFdb9kTsMayBlQAQJChEPzm534ddiUDgAEXhSRf6XHPycvivVPFMqIPQ4aTfSNjUMDkjKaWXiEql+hFWMUSKsZukYq3cpVKRg/V2N+jNkAO2T2eEFu36XxRiz8RfjVSZEDK3k+QAxW5H/q/kBVEJgQwG5NygOnjxQa51tPCTJB5/hT618T62mNgMS70SwlLf9lDpuacQzARbw9vMQ72TapqQhKP1ylHig49/KHeO26hRpMwqhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(316002)(4326008)(6916009)(41300700001)(8676002)(8936002)(4744005)(186003)(478600001)(70586007)(70206006)(16526019)(6666004)(36860700001)(7696005)(86362001)(40460700003)(82740400003)(81166007)(26005)(40480700001)(356005)(1076003)(83380400001)(47076005)(426003)(336012)(36756003)(82310400005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:03:15.4125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60606e38-7646-43c0-7a82-08db6da943af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mark as experimental for now until we get closer to production
to avoid possible undesireable behavior when mixing newer
boards with older kernels.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 859882109f55..60f765676a9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1896,6 +1896,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
 	case IP_VERSION(9, 4, 3):
+		if (!amdgpu_exp_hw_support)
+			return -EINVAL;
 		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
-- 
2.40.1

