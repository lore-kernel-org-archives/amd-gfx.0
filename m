Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82377C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5928F20826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ii9xIGIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928F20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAB66E1F5;
	Fri,  3 Jul 2020 08:59:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D86D6E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9AOQlTdU4tV3ruvzpMNpHBcTa+0O1pbqdoEPtlEGy8e85Zl5hd8BL+IHxnrVhfwMWUqiCHKMVpgMDDI9Fa7+cbF36rj+Q4Vsmhu7IHTKoxbzyoTWtVY2TQSIDD3M3izMgMtEryK1fDejWLqDXBuzc5zGIHZH7Jjm+A+rTPj09ZXIS789B1QzXhMbSotFu5mH6zz/MGl9FcmSNy0ZatuEmAW2cMr7vjrdWqArFaqA7A8NYo/4uhNOCEnHaoAoRf25L+pLWD7rUnmSn+oA+IcbdvdmrTTdDahCSD4NIqu/X3NwVMc9eciMR96V5nzVT4PmalUgVLOx5P4t7ixmhGNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/2oJFKeiLaOmeSo34tXwkHUKKsJ7ks2BYbJNT7Nn7U=;
 b=OMiQSECW3K9o7fQlAdVDjsLlKBNVaDjgRyF4kgq+aJzzmUzFO27W/pObctavn7yBP90DQXSKrCAdGi5IzqMHHvkvilvrp7wugUQCQn7gJxLnG+mczbkmejh9RiHAb7GIp3TaPNtmDSR/SnpXz08vVk+vrzw9zyVb56TffSZimnfkVrgFrtuTHRpFSa3MOjVRF/eC8RdRLHbWAUKV4DnQYh72K4Niz282WpTNHu8c/qR/to2ySi1RS6ZTUwR6hhKlBNtW6I7F0l2FsvPaiC1Y1IWx3S1CUy78LEWTnvRbqvqcIjGMbCQcFyjNqxMgvSK3vO259aWgawwPDc1ez0nWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/2oJFKeiLaOmeSo34tXwkHUKKsJ7ks2BYbJNT7Nn7U=;
 b=ii9xIGIiiWIKvb3ULR28zuSkkfmi2a7UbFk7mWVnjHWU0Q37tda1zNFHMl6wgrvjh46mWtOpI2s61u2+finA76cm8WiEFr31tyHdjp0jxkRSHk2jEFpe0md9GWLhu+L7ndsz05atQ65Jrt14MBLKIGYXpHG1ttmbBGSqP2J3HAk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:58:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:58:57 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amd/powerplay: maximum the code sharing on thermal
 irq setting
Date: Fri,  3 Jul 2020 16:58:17 +0800
Message-Id: <20200703085818.7800-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703085818.7800-1-evan.quan@amd.com>
References: <20200703085818.7800-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:56 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66746d84-dbac-4a93-b0e6-08d81f2f5218
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353E9FFB251E2EBDCEB2DCCE46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7tgTCsaocDVVJ50IvqbfKGMZO1FCvVCQW6pZm6zDqpMjMSTat2GRTX2D74vU6Zzxrc9qDZL51WFY+j5mAWxiSDqJiH772RbGyqGSypISJZFS7zL4/URWBYssPs1sJ0dGA0856RVZHJv950tDLsqhYq54PC2FG3KT3xcucJdkjsJUe8cZG96shK3Q/i6Pb76A8OkiFw2RN3iMxxJZImm+ldhqTm+XR2uxXF9dETcuHk7134Py6e8UHGDbQFwelPdbfOjs0dcRSzP+9GZ1gxJLfaSvcCGRYgGyogjT3I34Km4PVLqDld5ExEo131jwsIK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ea59lTmOofkCQBEI3CT6gzyteZeaMEG1lyFvMb6hbBJnbL0xrRf4SULsfB0HKkuA77RwlvwizQ0qDbIQalVLTIeri4a/gswmYhVFLVW3xa1RhLtwvs9px4vJR1O2/gnq41jKcrwy3v3CRUw1s092ehbZq/91yReY1EWQrqqBm5uOie+SfGgovAUxbKo0Kx2WFNZSBsesmVphz4JO/lMA/NlX2gSBuNYvp49g3eef/qM0P7FpleCe8kkJ+1ORQehaqQifH9K8vvjR/GbsXwQnMurDKXlh+LUG75NVAZK5Zp4eUB8P8NaO01R+/BerGwBcyt5EKV320/mNs0e7daOmsmSHIVQLEvJMVmeQSlOLqgtJk4HqD0olGvKdkBtAFfK4QRpL3slnMLjQ8poIyBETgzpNxj0AVyHfZrJxMukme7ETVgicdVEEH+USUHIOVO80GWFwApweFZ3jlZxFk099ZiPjGeWzmvsTMEjXvLER+8Pms3oLY7WnAhh5jzeA5jtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66746d84-dbac-4a93-b0e6-08d81f2f5218
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:58:57.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsnzEjIiQeDAasVVm6HDAbAHg7aW+xv4L8RItbco+KuD7OzbHz5y0H6GgcyV2Plk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Put the common code in smu_v11_0.c instead of having one copy each.

Change-Id: I6d0c27c5810ebc3273ef8b4fae07ac6dbed2715c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3404db490eb3..86a118a3a80c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1089,10 +1089,6 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (smu->smu_table.thermal_controller_type) {
-		ret = smu_set_thermal_range(smu, smu->thermal_range);
-		if (ret)
-			return ret;
-
 		ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
 		if (ret)
 			return ret;
@@ -1347,6 +1343,8 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
 				   unsigned tyep,
 				   enum amdgpu_interrupt_state state)
 {
+	struct smu_context *smu = &adev->smu;
+	uint32_t low, high;
 	uint32_t val = 0;
 
 	switch (state) {
@@ -1367,9 +1365,19 @@ static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* For THM irqs */
+		low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
+				smu->thermal_range.min / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
+		high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+				smu->thermal_range.software_shutdown_temp);
+
 		val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
 		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
 		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
+		val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 		WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
 
 		val = (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
