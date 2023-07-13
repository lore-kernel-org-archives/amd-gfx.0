Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54D4C001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 14:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585AA10E6F0;
	Thu, 13 Jul 2023 14:51:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB94D10E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 14:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHiB4lysDZQHtDMPZhXPDqvbe66zjK2feYuQrgbp5Fn5hVZbJ+eDn+wRcCuXJVMsclqmqP0zIUWZplyWEKLgD3ZdggeYPV/8PV7vJS/BlgDReeIXaaX3EqGz+1BAD2NKxO6jfr2jqFvNwV631CYTDfLlk2GIn2tAj99gio8V9AHFinzBFogyl97dlI2iJZWhq7GueMSblDN7GOVhF6AWFsYKw+An9ZK5OcCLWtbO1+iidqC/FKd8uA4JDlbzy58HrJgMkGycFLfdXq2YVe7QUm1/DIvCF1mW/ek0EKE2oXFmugMcd0iE+qh6VUrc7tSuf8AG5rod8Jj/rYLJaNYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj2JWJbv3HY8Fuv2ZRKzARLgNiRvWDMUw9Fw4vH1+L0=;
 b=TS1zrrtLgDNmTY/1x6YlG/0DLEhKVbYiHNl0xaIJnsuXYARl53i/+9sTJ0FIjUk7t2OMLA3pfpo698dQ8KbmjW/g523/L9yl+yC/eMUbtzAL9PkyghHVb7AWDK4sCLauobAGc65kyh/9Bh9EZD8W1dEblJ4ucg0s+Hssq4wFyCSN7SFupXvJ4ItXvWVEbx8x0HI7AsmBF4ogHnS3SyMIrmfYeQz+OYC6ipADF7Gb2EoWL4Rn0FwwIgJnAGb6K/w3JZLIIF6ctlc/47J9PKpVjnQ4S/5K5RVaPeIoyObWWzUXG5CPGy85Ip3J5ezKohXr55SkxEYAKkd0evCAi45S6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj2JWJbv3HY8Fuv2ZRKzARLgNiRvWDMUw9Fw4vH1+L0=;
 b=fJdV7GTyYAAZyj6uSfalobRA137X5QE0yBHvDDH9rKqmwwJuLfUGio3SY+d44BS8hkVDo6d/Kk1e4EnUKZ/RLXaFokG31IyVt13lIvdG4eNGg7R3PpZZhurD5hsGppOBRON2THmjfckIsXriuF5IejaHietwExVWJNpEx701Rd4=
Received: from BN0PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:143::7)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 14:51:03 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::a) by BN0PR10CA0029.outlook.office365.com
 (2603:10b6:408:143::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 14:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 14:51:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 09:51:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 09:51:02 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 13 Jul 2023 09:51:00 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review V2 2/2] drm/amdgpu: Disable RAS by default on APU
 flatform
Date: Thu, 13 Jul 2023 22:50:56 +0800
Message-ID: <20230713145056.54876-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713145056.54876-1-Stanley.Yang@amd.com>
References: <20230713145056.54876-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d9c505-3873-48c0-4998-08db83b09449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mSQLbme+mqU8HZmDT75NjsVNTTd+BN/xxpEIguZ4Hfud4hxvMAesO7LH7V3tluNSbH9l11IGBSNt4WNt6GRBBDcETZLpYkQvBIwn7Jn2pjEnu1uF02NzbbQvw2DP58sOk38toRCl2oOz8cH4Y5DP4yWhzR1bUq1UWDo85emU85xpO4veXoyEqTncuK9rr06HE81zMZ/e2cg+JX2jvn6+kLMCaej6YMDQpWyoBEIMn1EsFhy29qH7JObzMBIv6nT/Z7NcxAT4exkwrvqDpoH0xa+5/NSboKgU8B7y6f38hdByjFbEsdRbD3Vx6eXRmF4nuFtrec+ulIOf2qjSytY+dyP6vTjhuCEQibc9vD7aih8FxA6iV/zo8CP+1QhH4r31il8jSUtza9ZdSclxc9KQ5xYGymQTVo7yZAKvKRzL0gyWVt0c+b+N4QhS9gkEoA0yRbc92eVQ7RHX7cR1mYY4Qm13W4MbKxbPDYgMrO284F9pSvRjymaM/jSh9LH4IkG9qTrCnyWV30nhAWb2sZRC+KewtQWl6Xw7pXcyFSLKi3BPN/Si3j9ZbnG35pJjviEmfJCyLdkmrduiirBweCZSROuORVv3ZT4x3OKCMRTRh/6ohpk/NnxAjwA4o/CRPsovOegOQAiAClsuaMvvDRRfUA0AIducyPwSnZbPHXYYWxRrMOs9FFakt1RfUbLr8bzYKyM9fO/zDpkoOBCW1z9j0a7csfIeIhF4lYQRBkY9qus/GwkjkkjhnnenSWzlNuusBU1HLaM68eerIHtp79oCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(110136005)(41300700001)(40480700001)(6636002)(4326008)(70586007)(70206006)(478600001)(5660300002)(2906002)(8676002)(8936002)(316002)(6666004)(7696005)(40460700003)(82740400003)(356005)(86362001)(1076003)(26005)(186003)(336012)(36860700001)(83380400001)(47076005)(82310400005)(426003)(2616005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:51:02.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d9c505-3873-48c0-4998-08db83b09449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable RAS feature by default for aqua vanjaram on APU platform.

Changed from V1:
	Splite Disable RAS by default on APU platform into a
	separated patch.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8673d9790bb0..ec5f60b64346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2517,6 +2517,15 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX |
 					   1 << AMDGPU_RAS_BLOCK__SDMA |
 					   1 << AMDGPU_RAS_BLOCK__MMHUB);
+
+		if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6)) {
+			/*
+			 * Disable ras feature for aqua vanjaram
+			 * by default on apu platform.
+			 */
+			if (-1 == amdgpu_ras_enable)
+				amdgpu_ras_enable = 0;
+		}
 	}
 
 	amdgpu_ras_get_quirks(adev);
-- 
2.25.1

