Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3163C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0E6101E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 04:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DE0E6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE50A6E23D;
	Thu, 12 Aug 2021 04:01:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DB46E241
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 04:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+irtZwyNEaj7C8BB2Yt1wXrZrYpT4lhDAO1IQ/G8LRbX5gXvakiK9GajydQKCYLOqG/mRmUYInRdGgCwEXjCxucaCA70sY7Q7hUpNKon5jjexnO3l+kPIM3G1A4bzLtqjZ7OaaTrmbGmjZpDA5hGb4z4y9bCus7DaMX/v2Wb9jwMFKlGBonIW4fpiP2AEvAbcxqGhG4+OQR/DGcIL+KktNPSofnSz3LK29zef8APgB5c7uktSfEN9fH3soS9a15fGHjkPavY6JOomba4kh3/wtDc0bhO+R8DOxid58e/nVZzM0DQpAANeOvVmZeaG/iUTnHTGDoIvtASFtfAgFuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvDnO8Y6zTwvc62RfAlFq9vY9yqSdrXsXMOiMjaMzPY=;
 b=QEuLOotM5kc7veeePPnkLJUFQEEHhqKriq7D6BuhR5sjE2b1MT6orbIlhCcCitxdyT2Je7AySyHvX0l1FVFZ9QW1m3KWaG3C56HOwuxCEofuiQxg1x6sfmacfd74RR13mKQ1bnDQgjkt8e2ue+k8cYcgzQLO9UmhMt6ggfHnWt61hCyf+ZGsA4fb9CN8gykgS7rcM8W28hQdseL/EsWoAUqV6bpDmNrGQaeHv3mlMf4nhjl+4qfP+XHvJCjJ/EZtZgVoAdbEvjOVe1Y71ks3l4Y9EHAZPONt8QsKMRxGpS6Q5BXViyQnbMQ+jow7wCVLquHFokRdzDB4eUYLbCNMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvDnO8Y6zTwvc62RfAlFq9vY9yqSdrXsXMOiMjaMzPY=;
 b=2bvGSWos8r1ptkXaDIYf1U042kRKbxjun2fI24APrYJ66gXi/swVEfXDay3V//2P2CUElWcARqjoWnNEUcwNsBqSrs+NBkPiJowNHhD3YheSAOQk9xCkK+TJotFXUQd+mIbbCFYxZMNW7NqgqH3tDuuSRQXkanepwaBk7eal9AI=
Received: from BN7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:20::19)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Thu, 12 Aug
 2021 04:01:46 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::3b) by BN7PR02CA0006.outlook.office365.com
 (2603:10b6:408:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 04:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 04:01:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 23:01:44 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nils.wallmenius@gmail.com>, <Lijo.Lazar@amd.com>, <Guchun.Chen@amd.com>, 
 Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
Date: Thu, 12 Aug 2021 12:01:09 +0800
Message-ID: <20210812040110.1293682-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210812040110.1293682-1-evan.quan@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4d587c-64f5-4fb6-63b9-08d95d45e6ea
X-MS-TrafficTypeDiagnostic: SN6PR12MB2701:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27016C8A98969079BF967F0FE4F99@SN6PR12MB2701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J28UiMp8mjzm83M+wEoebryisb4Qw3RVaM1lrfgU2ZASCWLop5TMZubHLZtYpjHbwLeOJOz5p1IXrII/ugThglNraJ0RyXlD+2S+iqh1nacS8NQoDTtneYjO/ztOlxPck/N4PowSdhzUvaePX/rXn3ispHW9z8NYQzgF8Zgzlx4Phg/v0kRTd51YC+kOwYdzzXDHF/gYCeAD70hweKuagBR+MQsoz6e5Qf+sP7/G9xO2RAx0/Rdh4maRkdRWS4ikM5z2j8Ps38+VCLH3RTl8+kIPlrWPfat2/5b4kMmveQu4ibzb0LQr/Yogysaa7PlmVVi9ZpsT1mD3yERrTCk5i6Md3OSsGp1kGU/V2CZqjy8Q6tgH0TT88EaB6BYi7t0UZD2Gj0QYoqwcyKOurSU//fcVXjKJmnLTZyNTr+HEVolhj64vzcYg5yxbMPX5lEU93sYXALEvawdxDT3cAcOWZPEyRc6liONwsJlyzvDrzNLddW3Nk9GyKm7n5Dc/I7Y9oAb+im/ZqVo70CLZub2uKbZqth1oXoMBJrbTO1SaU3Ie/I5+/b9rBgFF2LXrAnuqN+ywrINMvlqAgvigkSjsZ8+g9H4pGXb7RWc3YROa0sa6KwfRiQx5kscOUNne6K4NSCS2N/WOPT+6Ocq8EnsZnbW0zbDlUqeIXm00UlR/mtd0g0gRWWXuqHQy6TUeYsT65WjA+T9b8JG+Rfu1YAl5VCXd0LGrYaYbWTHmxT2qj7fwDiaczqfU3m3Y3LzXvjJoWnKWjUa2EFUPla1u584qzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(82310400003)(36756003)(83380400001)(34020700004)(70206006)(70586007)(1076003)(508600001)(8936002)(356005)(426003)(44832011)(8676002)(5660300002)(2616005)(81166007)(4326008)(36860700001)(336012)(26005)(16526019)(186003)(316002)(54906003)(7696005)(6916009)(86362001)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 04:01:45.7413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4d587c-64f5-4fb6-63b9-08d95d45e6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
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

As the fan control was guarded under manual mode before fan speed
RPM/PWM setting. Thus the extra check is totally redundant.

Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 9001952442ba..20ece0963f51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1208,9 +1208,6 @@ smu_v11_0_set_fan_speed_pwm(struct smu_context *smu, uint32_t speed)
 
 	speed = MIN(speed, 255);
 
-	if (smu_v11_0_auto_fan_control(smu, 0))
-		return -EINVAL;
-
 	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
 				CG_FDO_CTRL1, FMAX_DUTY100);
 	if (!duty100)
@@ -1237,11 +1234,6 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	 */
 	uint32_t crystal_clock_freq = 2500;
 	uint32_t tach_period;
-	int ret;
-
-	ret = smu_v11_0_auto_fan_control(smu, 0);
-	if (ret)
-		return ret;
 
 	/*
 	 * To prevent from possible overheat, some ASICs may have requirement
@@ -1257,9 +1249,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				   CG_TACH_CTRL, TARGET_PERIOD,
 				   tach_period));
 
-	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
-
-	return ret;
+	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
 }
 
 int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
-- 
2.29.0

