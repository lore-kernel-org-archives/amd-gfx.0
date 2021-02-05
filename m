Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D0C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 12:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F17F64FCC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17F64FCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A726E079;
	Fri,  5 Feb 2021 12:40:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572966E079
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 12:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLWcYoiCKhNzXcVj/IsJLXyYy+jxx1sJuLhRQVsr+LCyrtZ5+6Szpe3ZK1ZXBTgXoSwzno5/jLd1ZpZ7clVhPMA2vRHN/umSFOPO/hzP+YSw1aR2id39UkbClEWu5IG1+KCUJGmt4x6JW9Qa5MhnXxFlnq65sb6r4EZAbz/byiGS+UKYaQ+M0f9Xr/jEy/oQsSoCuK2yvWa+lz9TNcs782J/txQVx7Q3COxaBSdZ/g5TO5rIxrWqAuR04iaW1AEI17igQKNVG5SEkNcAqqhjJ93tIs2+zu9Pso2Ox6flrNk2ESeYObDfjVIryq6BI47uoBVFk8EFYmG/OJYCtYMXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tiw3JiXbAoFUCZ/ZPZD8xbEVEyu4hX/5JphyP0Sl8rg=;
 b=DPp7hF4HN12O+BipiuYElHQdcROAa8S39k435lG0r34EsX1kWLChuYVBiAQuNQkyrBznd8pciQWFOenna/TVFZGdt9gulGLCtJurV9p5bYK7EEnh3ADU7PkBXFHhlsHY5DklfZLsyQsj/OeoJRpdzr4VHeBU1ZC0BbvS6JmH1mp6sujB5o5ufplwVk5de7iRp6EZ0JZ9h20VIMucY7FcaDK4zcBzNWP74IE8jnRmf1NQUR1si7wwmjq3xJEsZYNX9/osaMuEAUoIkxzvdGgRuclXnvbPL9/YWoxQS7JYPm92DQkC8/7okd+NRFqEsqbMTK9wxARPdUIyn1HFhh+5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tiw3JiXbAoFUCZ/ZPZD8xbEVEyu4hX/5JphyP0Sl8rg=;
 b=wsqMeJsdlqnK/xmY+lVgyiF1RbK3I7WhdgutaxyeMxkZvnXruJZnCCSrgX2sD67MOxqfm1Z26ut0yo7ZZ08F196JjyXx231LtPG/gca7DK2qylCGvreHhw6rkmbbMGmRY4ew4HVvOnyzGrw4hT4GsspJzixLs8Begg3xiho1w9M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 12:40:03 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::7c48:cd3a:5f92:2c47%4]) with mapi id 15.20.3825.017; Fri, 5 Feb 2021
 12:40:03 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: modify the power limit level parameter from
 bool to enum type
Date: Fri,  5 Feb 2021 20:39:23 +0800
Message-Id: <20210205123924.24129-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 12:40:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c4858de-c0ea-4554-356c-08d8c9d32862
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376CAD756A438DA5CACBA599FB29@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beu35MSbusUTIeFjUVcezuxjhwN6LGl3l8YhuV6PQUn0vsvaG/r66xS8DDjNUA8+o1Te7eKDFGWtbqWB9rcgqHQLiNBibSOH3+5dCAvcvZ8xE5RApWHiU+qzJoggEysKLCI36zuN9Mts2wPS0MnW+W+Kxa6Q3fi+d4l5s1afhkSuDv/KgaKfc+aCE65KhJGhNopqZWFrbkjFC++mzAP1jQno3a35Mp+zWlCu9QJcuC1SCBVl1ueB966uN9Fa2MqxLQkEsC3PLq3yCNB91vh8/V5/z/A+KEfkI/1gD6oD60I7/UMBuxVHXC6WQd7O1ASyAhQI3W7/hVqZeybRb2PZgw41zAFmCXdU2TThsZgR6E4mOsR0c4Rp0fhPbwTsaJp25TLVOgmSE3tTSMlcbjukWUtcQH+bmRDCGDoDxdL0DfETRBZI9TcdIwkIGur9JzQzQAVmnXjziDIc5d8CXqVZdV4lCAVPUqlZ19JlBeE2mu1Cz52D8J225fgDloAZgFZrB1UhSJslV1YzZ8gpdlfUrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(36756003)(2906002)(478600001)(83380400001)(6666004)(6486002)(1076003)(316002)(86362001)(2616005)(52116002)(5660300002)(956004)(26005)(66946007)(7696005)(66476007)(8676002)(4326008)(8936002)(16526019)(186003)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QZ/N248wJgcwn5lzxXlH5PbhUZq16qr3PktEkiXuWLIilS8yN40aPMsAtLlC?=
 =?us-ascii?Q?Qpy3U5v4UhLHMqrtMGN7gX1nPkxpefKodS34K/QDDjBB1Qt9JrnCbDdosKUt?=
 =?us-ascii?Q?p/JRwFG2PxK8wwrDic1Svbx4waEL2Yht0W77EMFXtbwaM2PqlT8d7Rs+j4t7?=
 =?us-ascii?Q?Pbteg1KviRcl3yckkZ2NbaiU7fKQqNTGBLbsgU0fOvB3XzyudYE98uF3+TKl?=
 =?us-ascii?Q?LKUXI8D0kpLbcARntAF/+XeEpUeRBoiho6VhUR+ASPRk67Bptpzn1iZMqGe+?=
 =?us-ascii?Q?CWZvXd3Uh1jGyC1waTRNDrsACdZTlFTM6vIv9gYb36W8yuQtkcXrzznz5NSc?=
 =?us-ascii?Q?Jh/N2ZDaMwn4xmfV12wR8OTxGpMYJviu10TqJSX95h7i5xOXETld1A0hwi5j?=
 =?us-ascii?Q?W9KfcnNP7zVKH9pWt6lVD10Sm56LmwYLZkDndVDCUH3HaktckOUHt/IExpTS?=
 =?us-ascii?Q?qatDGC7v3SHHAkdQX2Cg8Uiyvrof9b2jeIaDuf+8MlTc1kOBEU2+ffM22h5z?=
 =?us-ascii?Q?PQTYPdTjPq3+vdmCd25asbogMjpJ1LagXYsJqeJSWnbK6HMXKBCASz4l+0fG?=
 =?us-ascii?Q?iXerICVWHOlSnhooWJfHMzois+jnkQUYqctW2AykOfkYsAeoAK59MIDRorMC?=
 =?us-ascii?Q?lXD8J/OX4mRpLdE2pzBgMvpVq9bn740iMFbMyGWYw9hwsP2w2+dbADu/v2xj?=
 =?us-ascii?Q?FHDAHz99eHHRbQPC3YpzZVXh/leDA+xDun8JhtEhU7fE15Fi6tL/M1F38bwG?=
 =?us-ascii?Q?Exh1rwiG8n8L414ISiZWd6b3wLP6aLvELUuqAbacL7oTJcVreQd/9yUXJVx/?=
 =?us-ascii?Q?cKws9HYsJPT0fSbGEsqpa4MI/uVizZGKigspZtmTuWT0YBJTAEUKZP2RsrRW?=
 =?us-ascii?Q?WMk4z6MLAPPjeOh8OT3Jvf0c34a/jG+2JrMtx0wIsky+zMNZPQ3K7BcJf5Kl?=
 =?us-ascii?Q?yd6jf6wanjBRkqzi97xfkWsv5ESW9cRRJx9tU8FjqMNzXbpJ8jbVq6OUjtdd?=
 =?us-ascii?Q?cqWhG+yL7R9YyffPKMOr8BwgFChJnuATa4BclAhYyqnFM0TRX08dR+1CuYbM?=
 =?us-ascii?Q?HXjn9SlSkwCBEIdvgGq8P82Zb+z4FiMMTbURcgC7UrljxOt+jbpGU4WCsXSA?=
 =?us-ascii?Q?5k7pRKlnsU0uckTbFb+5/JOAMO0S/cHROG7j8dBgundIAWPKNYufnFjj2OB6?=
 =?us-ascii?Q?p060IsFEtII1VaopG6qasdqKnEinwkJGCEONVIP4DJY2w+VW1tS6ed+9vXQ5?=
 =?us-ascii?Q?DmI5V1Ev+X2/d6lf8UC8cr4kbbXYknxIuRLEVQVG/O0dBUKCgkY0uZbsfbsn?=
 =?us-ascii?Q?dsGuT5iBRp+lEAKL+NNgHwkx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4858de-c0ea-4554-356c-08d8c9d32862
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 12:40:02.9490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axUFXZ0kxzu1AUic54acqaOWtjapmYRDCsgzB+F9qYRi4JMJy+IG2/fXoCeRZJrqwcIV2M517LE9JqI133PmTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Cc: Lijo.Lazar@amd.com, Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The original smu_get_power_limit callback accepts the power limit level
parameter as bool which limits to max and current. For possible needs to
retrieve other level like min, extend the parameter type using enum.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 +++++++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index cf475ac01b27..39899e7989a2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3073,7 +3073,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, true);
+		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
 		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
@@ -3107,7 +3107,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, false);
+		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
 		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 44279c2afccb..82a5f4a4faf5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -161,6 +161,13 @@ enum smu_power_src_type
 	SMU_POWER_SOURCE_COUNT,
 };
 
+enum smu_ppt_limit_level
+{
+	SMU_PPT_LIMIT_MIN = -1,
+	SMU_PPT_LIMIT_CURRENT,
+	SMU_PPT_LIMIT_MAX,
+};
+
 enum smu_memory_pool_size
 {
     SMU_MEMORY_POOL_SIZE_ZERO   = 0,
@@ -1218,7 +1225,7 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			bool max_setting);
+			enum smu_ppt_limit_level limit_level);
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c00f3f531965..9017024642bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2044,14 +2044,23 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
-			bool max_setting)
+			enum smu_ppt_limit_level limit_level)
 {
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	*limit = (max_setting ? smu->max_power_limit : smu->current_power_limit);
+	switch (limit_level) {
+	case SMU_PPT_LIMIT_CURRENT:
+		*limit = smu->current_power_limit;
+		break;
+	case SMU_PPT_LIMIT_MAX:
+		*limit = smu->max_power_limit;
+		break;
+	default:
+		break;
+	}
 
 	mutex_unlock(&smu->mutex);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
