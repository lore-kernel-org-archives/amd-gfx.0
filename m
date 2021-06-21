Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABADC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9671760FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9671760FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AED6E0DE;
	Mon, 21 Jun 2021 17:12:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D4189BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrjSoEzLnbnCgOkLZH2TwT7oU/eNzMMJXvNnG7Z2d6vb8J/hFRXieFc03HsREhruYScRQ++QDF7ZXHNXKM0pdngvWwe4cd9Ec/PZcry4joBPRHZgevnAl6rG+RxfWgizQu7Jo42EduZwykClJJf0RqurmwDHRNwJFVuCgk/WlkbJPoEvZobAtlHc4ru1z3x1VQVWCqLOYlL75vl6cog8PqdN6dPrEnlSWRTNu5Aq6vhu1xtoCsasnBnixm+cyPy5fOgPugG8QZy24I9kwu2dvIYOuT1Lb8QOs5MoN/mRLO3s4lpx4pNe5WlvDfHWRSZE6NsawkyO9x+SvQOgOABhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=jFBU9M+dP3SoB1Y/WYbiTLA2zsDKecU7H/RkHDQupgtEu1F5V/110iLqcDZtb/AT9RmBraajMGkuXr0ObFAUrCadLz7q8xK/eK8HYu+O6+B3lP4dQ/ccUp28c+zbw6NHgvWQVYhFFVKy1Ay7km/5bgamMQSZwhCEJ07kRcne9e3del+9cO/Nc+wOaUx+XU1rDtT3c59IcJ3w+cwSWvxhjeblwkSUVQl5oJWilh3RSaBOB1PLxNuuHfnQ0mCfta3Jel7nopIIRtQ+TtNHURCxlVzw6xb13XUDNSMpQJn4VzeXm4drw5KjEV2tUIyogDjiY1jffdAVCRgbW/igJru/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=GXIGTCRtc4NJffgzOw2uDQfy54d8tQcNYAOZa8XgTZU1oCSMwfY22piVX3H02Vh3ewCp8mwhuYi71OIol8aG3qVtUjkdSVOW66Su8D0o0sgRriTHQYmVCQx/+Db695IRdkO5Dwyn+VsJdJc5bfgwYgT2v6QDzSIVOGzTuY4sDd8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:35 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/43] drm/amdgpu: add a mutex for the smu11 i2c bus (v2)
Date: Mon, 21 Jun 2021 13:11:39 -0400
Message-Id: <20210621171221.5720-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ac5432d-8e36-410f-a86f-08d934d7c3a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12584059BDF9B9999FA32090990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKuLYrvfepp7BE5gvni6FH6toaFgVVgYH+NLcq14ojEvgNkNM6vxDvROko6ktU/ny3saTSHutovO/tV/ciJMUMk3WI77cLP0HQh/i0KFOfXGFnAHSmr1ptu6Eg1E+LB78CCznwlcGS1AqIwmBDmUByFWNpgxgZnesvEFPYG/Urv26Bujg5o205Spk0kFQVgh/qqKjPUIrTqgoIPJZ8zMTnpOFi1MSZ4CQqWNqBUC7S6GIKk7aOqI8BWTdBQ8lz33wbZ3Nw2z8T1QLLIsfUOasLCmIQnHtokm+8gU6+u/JgfagX9V/h0rXtjLmaT9XwVts3xm8TovHl8bpFoFdBcfzQcxGTPkn7VUooM5O58ZMTfpGhTgcLadh3IMP2+CBWUmADo57arWdNmIp433MOJ6Jbb72qZs+G8BFup8KB9zcM4sgXaKUO9WXuhHeKcm1HYwn28SUgKpbI9BVQmbSRgQ+u7Zfif8ULXxwng9gSTsg+4vE0uj4MRKknoVplr5mrWx5cWy3no0HMhIoaIN7xAaKkZsqsT/pT1O9343k3Vn9QwtbonD9yX8RCbAvreVFWcK1UONdEI5sNqrKXrsNoQZY+h2LHmfQmUHqCfAURDCFrIJZei2gVTEtpLthCD31fiIYQEIZGBJJq6NpLYxa6eXpfv8kH/jhGwSKk5Apq+Epa1L/d5sfG7TkLF42hXEy/+B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQfy8Ppl5aQXk2crBE3VQFT9Y56+Zyqm5aSS6Mhmz+hxft0SxiuBFexojtHh?=
 =?us-ascii?Q?28M+xDZmvFtRZZjfyV3e83vofJM9+YZo0E907Lobl6gqnheFUOGYg1joLUGs?=
 =?us-ascii?Q?+qLYl4VHT1volhSUorZp948eCEM1ykgw6sRmuCZ+rayXf5gCPXxoaU3xjZr3?=
 =?us-ascii?Q?cFcPGHECGluKpHuVB1iRsteDt3zh8WeKoqzBkdOn0eLDydmxlG0dlR5fXOrQ?=
 =?us-ascii?Q?OBDwA7riwKJhncK4EhoO49OsrMIk4iH/778pkiYFYUQqyJgUt3l/OOLS0a7D?=
 =?us-ascii?Q?r7un2yuO4K+ofa/ha1U+/jNfkP4U0NyfqnGg7dN7oOvIHzYYnJ/ZcfJ55bsv?=
 =?us-ascii?Q?q4u3S1fNoce3tCzzNKMPuCHDTWcD1CHO2MW24R1xhL/+8veg+QMe2Qge61v4?=
 =?us-ascii?Q?c0dVxdTLsL6QdyjTehfqWARDPvvSE5cUCqnhP6rw9ESpEdsIUA+6h8UT0ONR?=
 =?us-ascii?Q?gVUozzW2bB306uai/2CArJdZ+OgwoBWSKANLa1aD//eEOtZpwS+FG8KCY3pu?=
 =?us-ascii?Q?UcpRB2s6SnYlghjMtn7/C3OZJ/V3IICjX+HHrpClVYWlRgA1mv55BwxXzd5m?=
 =?us-ascii?Q?+z6NbzxC1qN8t9aApuFDQ4+lf+zMMqakrBaDLIISBgVEvmpg5qdmfYmiUo/i?=
 =?us-ascii?Q?eUSCEWY0RPS96FNcRhhjIVORzE1nciMYxRYnpd5ekPHIjN3H1u3N+izj4VJV?=
 =?us-ascii?Q?4WvCMBmTM2wPkEbmab77J68Uy54gvOlJqM1hA2hfYNPlyCgFNv8rcOZsuDNE?=
 =?us-ascii?Q?soFVpZd1b7oO7v8EMxmOxynPIYtfuBx7YDtdG1azDP3GDz12JHckKmdRjaaA?=
 =?us-ascii?Q?niBYbl6P7VWVhf0NqUvkp1OXaSDMRTpk9jeO6nVUoG864BBpqFPeMfYZcKhr?=
 =?us-ascii?Q?joilzKKoRjZ+VQC7n2XR+FzUnbB0pVulth4u+cXck6+G4cL8wTlDc+0wVZnu?=
 =?us-ascii?Q?rZl4RcOuid/W05a8ayc3HTabKa7GF9uA1yEoGxeXScBniCHupuNLMydf5uho?=
 =?us-ascii?Q?wcYi7lgg04l+bVvkVOnkADAGvu67ENVQCahiCUNSpJlHKl0HFka4D/0wTby7?=
 =?us-ascii?Q?Aqcuhay9H4oPbl9N1cK114WqDj90Aah3NhKl9LdjaDzMiGdwxaZ5ZucWu60P?=
 =?us-ascii?Q?DfPT2f+kgSPKDeSn003/hFCoaLaC7pTK/fvDjnno3wF6WIkP/Ne5hMSKdVSW?=
 =?us-ascii?Q?JUWoSafcr3ypByYWJhWoNXzeMm1vT4oZgU4sHo0yOpDHK9WNV+s3VHHV+5mU?=
 =?us-ascii?Q?JF2MyU0gDg6IPSCgTMorBc8sI9cElzT7W29Mz9SV1Yk31vL5rDgCbxl36xCh?=
 =?us-ascii?Q?6FlhbF1yS+CPF0VDcKwinOil?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac5432d-8e36-410f-a86f-08d934d7c3a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:35.5475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tG3gqyg9gVIOK5ukSYyI2Rj/VulLs+QFH6G7iKqtZUUVpohBPzrpZ8Ar6SZurRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

So we lock software as well as hardware access to the bus.

v2: fix mutex handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 5c7d769aee3fba..1d8f6d5180e099 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -584,12 +584,11 @@ static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_lock(i2c)) {
+	mutex_lock(&adev->pm.smu_i2c_mutex);
+	if (!smu_v11_0_i2c_bus_lock(i2c))
 		DRM_ERROR("Failed to lock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = true;
+	else
+		adev->pm.bus_locked = true;
 }
 
 static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
@@ -602,12 +601,11 @@ static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
+	if (!smu_v11_0_i2c_bus_unlock(i2c))
 		DRM_ERROR("Failed to unlock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = false;
+	else
+		adev->pm.bus_locked = false;
+	mutex_unlock(&adev->pm.smu_i2c_mutex);
 }
 
 static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
@@ -665,6 +663,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
+	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f6e0e7d8a00771..d03e6fa2bf1adf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ struct amdgpu_pm {
 
 	/* Used for I2C access to various EEPROMs on relevant ASICs */
 	struct i2c_adapter smu_i2c;
+	struct mutex		smu_i2c_mutex;
 	struct list_head	pm_attr_list;
 };
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
