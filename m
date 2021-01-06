Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A93C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480F823104
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480F823104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EFB89E15;
	Wed,  6 Jan 2021 11:42:11 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680042.outbound.protection.outlook.com [40.107.68.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8556589E15
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 11:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpbPAMqAQhRndkJqvvib0glVZeyovOPOyYAtUTTZyAFWRiW/u8jSaOS5uxMPNy5c9NpoqW4QTi1t6xWkKgNmJIcGjB6DOr5chuKRbp6LN+FoufzdPusC8nC1Xef9glAMHNvw93Bn1Qi1AnwdHTNnRovPpgW8qGLM4bL+lAgjxbPhjUEJd+0UPYKrBoO/CLDsWRPSlOHyi0A74lNMEPPU3Tmkj+zindE/VRPFoqqG8/RwR+qm3u2dVzBXaGh0IlmYWfQrUlAyaW3zkGNZfmM73uZ61EwJWDoyAT0hb3L2FYxaWRSZWwbTZk/O9frbbkBKmA/d24LvY9tC2oSeyA8qPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5ur7sMr6DO1HYLhjICLgyXrFt1i1RXI+4XKgXd8upw=;
 b=EYVFKy/5Lz4wkMAYUiTapyKIGou20De4E6Y/Hch2/YmSgNHqlsQHNChcgewXbTwrkRujlBjx+dCIh5l++grlZnKBNTXYkYAKMvNbcpS1V5esC+tUukoJbheMsvrabLxEwmrX9+P277h+FReKwl6CvPnnhl90CuZjDgpaVZEKrWJ5XF+K8EWiWMs40ZFLMFMOY63/uUfotwvaepXvm+pput+/OyHPDOrnGmq3HGd0CYbu0wuCSV+evMUTpKfi3kGHFvf3F1d6dNG9Jj6QionFssgRY+tQHCrIg9a29uU1aDVG/PuGgcZ1lNwbNh6XoUgoT03JJXLMH1mp9hn1ghvtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5ur7sMr6DO1HYLhjICLgyXrFt1i1RXI+4XKgXd8upw=;
 b=Vi/ua31jPKS77WbbjmaE2kB30nFxMCCi04LLERxK5EiFK6zlHqCIGHEJnoFUu6q/iphU4RuWOzWODfcujvDbsL3YyaVPDEIjYQkmTMmc9gKswGjAIlNjDThz1RRcxBGLLki2/yXnQHGQzpFNM7soXtyGX/ciyKvc+uzMD6iH1MU=
Received: from CO2PR04CA0135.namprd04.prod.outlook.com (2603:10b6:104::13) by
 BYAPR12MB2758.namprd12.prod.outlook.com (2603:10b6:a03:6f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20; Wed, 6 Jan 2021 11:42:06 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::4d) by CO2PR04CA0135.outlook.office365.com
 (2603:10b6:104::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 11:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 11:42:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 05:42:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 05:42:03 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 6 Jan 2021 05:42:02 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: For sriov multiple VF, set compute timeout to 10s
Date: Wed, 6 Jan 2021 19:41:57 +0800
Message-ID: <20210106114157.566182-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c70f2bb-7b55-44ea-3845-08d8b238170e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2758:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2758203A580601BC657031418FD00@BYAPR12MB2758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nidiO89Ya9yiYI76frKOpjGvZxPPPwqOjAswldl6dBxtKjyTMiM9762aAYWwp5eWliDrVGakX7ysPAAPCMw6QN2g+NE5St88lUkKvpXsqwGhd0VBafU3mSGditoEvtFFFZDUri4uC2x20rsjOk1M9kvpH6u0Tuprj/Qw2Yhn6WTpJZ/V/vVAYS5rbqbpHe0yN7OhRVROipUHn3FV1qyY82ewFFDbfM7HDekzt12sPnI07Y27pkfvw6267wZe8IK+t+XjSSrvNk4eeeKPN7xGxtOumqTHg4SnPhRrEQuHFPSANBY7YsaIU9MO++Jd6kB8MsorN1TAImvV5ba6MYExiFepvr0LMDSVFyOKsOziFgTNH3LRGVC/MiN0ElZhv/E8PhkowHDy31zUWNf1sEqHE8s3lZHCcOwWkOkVqIxaQ0e58uf8qkziuRcoVxvUGfcZ+8ZlZYaD6+sbFvEEh+zgV8Y23lV6hO//kCUHQbNiuzrmK3fI1aVm7ldhFfANnS2N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(7696005)(82740400003)(4326008)(316002)(81166007)(2616005)(47076005)(356005)(478600001)(70206006)(6666004)(36756003)(83380400001)(426003)(34070700002)(8676002)(8936002)(26005)(186003)(2906002)(70586007)(86362001)(336012)(5660300002)(6916009)(1076003)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 11:42:04.6036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c70f2bb-7b55-44ea-3845-08d8b238170e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2758
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For multiple VF, after engine hang,as host driver will first
encounter FLR, so has no meanning to set compute to 60s.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b69c34074d8d..ed36bf97df29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3117,8 +3117,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 */
 	adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
+	if ((amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) || amdgpu_passthrough(adev))
 		adev->compute_timeout =  msecs_to_jiffies(60000);
+	else if (amdgpu_sriov_vf(adev))
+		adev->compute_timeout =  msecs_to_jiffies(10000);
 	else
 		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
