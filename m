Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52878C433C1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA384619B8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA384619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960956EB54;
	Thu, 25 Mar 2021 10:42:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65546EB54
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 10:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3AaPEb62HCjzADfsbWHdKWAecld6xYuEVR6CO3yWV7qcxeLHOoXuW5im9vZMAA3fDleRxgqZSmKwD7RghJQF6Plr9tvlOX2aBbQ43y0KgrSs6Tda0FYVNMLjOJVFAmpXJp5v8HayJQKRS4Ah8rcBTI6y0H5+d70wITjgXnx9AGjf9skoSJEMHjw4dvutAwgvsrTn7vNxcxWrnZC4X/7ER8er5XMAbxKJm1WfIWsPEEFJH8hE+Q49Hvt/c9J/LNY0qt7q8uEXNXo3jreNCkrUiRbt0afiuiUrHigdOlzSXgxt4Voj61XtfQxImIRCCth8WcbpZcNK+O5anMz0T5AcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEBkf/NJGDQp3pRDAx+eGYgf8CdplpfSH1WW2jHaDp8=;
 b=ZnAZdXA/DqYLyEbb2Qpx53TS6lJHuoQHORlcSWMDNtfzJER84N4fYxlLDkQmte+oLj7u1MPZoVpUc+Oi4qzLyx1E5Ha1ecDIRv+CPMtlcVYzlDrQeNBj0ttwsuc4+0LcOBEjc5eD9XSsG/KaiKtiCDrjs+d0h1E+GtxF8lyAeYwJvvA5McxoRclNa+B3yH/Vi8U+CmjpJKZeCpY+g6vU2NNyurwAX0lmaZrqWjPNc+quHESXccQDUtz43khemZRnjOJc86JhoZ4Mhgf6i5dvzYnLcOqHKx2mNgFFKUzB4xRt6nFkIR5ww/UjahfL/t8TBgg5MYO6xx5tAtFOZET8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEBkf/NJGDQp3pRDAx+eGYgf8CdplpfSH1WW2jHaDp8=;
 b=sKiYcGfmmHB4OYVUQPzN51osLPgMCphKVz2CxSPOnJikAWyLRFw4d7oY+PL0nWvtQFtaOYaWvHXw0KA9be1USiiZK9qCoSbVbQAoNj2V+s77nkiQPrfwL+O2ecy7cE5/Iqkkriy6e3RNw2f82Xmp0fqxBcRdtZsQyvgJq/fH46A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Thu, 25 Mar 2021 10:42:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 10:42:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: unify the interface for gfx state setting
Date: Thu, 25 Mar 2021 18:42:20 +0800
Message-Id: <20210325104220.26987-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210325104220.26987-1-evan.quan@amd.com>
References: <20210325104220.26987-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 10:42:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3b418bc-b4f6-4df8-b7f3-08d8ef7abc51
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435C92786A04D5A00F69A8EE4629@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4ch7+yq2IA/aAHsK2UBYZcDcWzYx6Nl70cdPdYcdhHony/eakyhWr/bjpyKtAhci0CwVXT9eer7RsDkmNDZkYMyTIUnKRYZ/77A13HR/EtNoBGmEAY6VpKBeXMW1VADsFpG6huCird0ydxWf3XtVirfy22OLNbTaZvWbACrEJcYJfYuv4ZCI7Kbt5KCQeLX26O8HEOeF566exb+2tIF2Qg/oKlds2DnE63I7zQ5AX14wRDOfzqO5AJofvwsryYb9XOUxkuDRRXMJYy2JtU9xNi7KhRLkLYiMG3i9ohUJJLp0bInCqisIo5Ka7cQTHYh2PjuRnE1XqCiDRyItw9ZUKl5q6D3b04vUeq41TMrDDJndzPGQhUrAclAWNs7j0d4aXkbR043jtTS8yDKZ+VSxoUOSmvB8GTqW01uyX+lVG1BmJLh9PTcXE14pbDQVACwSAdZTh4IjONww3lr+Uj+U9etbtAsTkH8VdLAY/nfv5eiJV1WoLK57xuDoYBUi/Fr4gVarTcy8dmqqfX5TMH++kOlQ+KukM5AcXrapRioa39q3hdXyaHCJiSKDv0X3vEqwdT+drJfq3u+eJZR1X5Ew7p37JeFQLjRx24/DyIj2h7lNGIcWt/1QM4oCHjs9zcv0wAeTLf5NL4qH0wZyy5nEgHK50yVaUv5XeaP8H98A50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(7696005)(316002)(44832011)(186003)(16526019)(52116002)(38100700001)(478600001)(83380400001)(26005)(86362001)(36756003)(6916009)(5660300002)(8936002)(6486002)(8676002)(2906002)(66946007)(4326008)(2616005)(956004)(6666004)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dcU1qCKB6rPFO+SpKJpdZTJ63kq5j6t7N9r34+kc57AhPvpfZJnxGtADh7AS?=
 =?us-ascii?Q?JLGKy5Y4XcoqdQSa0z0l3+f2g4QIPK2lpVwyGITlDZ9tOkAiG2PBwLBXUy8N?=
 =?us-ascii?Q?bAFTrrw51lL2MkTlho00Lx17Ws2PbYiARaRntZce/HD1jg7cZEA11GMBnLHi?=
 =?us-ascii?Q?MJCMHGmfVqw06N7DYdUYk1wnIPJGaRP9zNMvqdNPKU5exo6miRFrj6jzWeq6?=
 =?us-ascii?Q?5iROE9zfaNdTrLZAGDgw6H6wZV789BUfYUtbm5gJat2aJODJ5fEzHkaqO6UT?=
 =?us-ascii?Q?vRDyYSNTN2wGUrCVjvE6Nzrk4M4bGmLa25cvn76vj9MWs7akRL/Xzfyg5f1r?=
 =?us-ascii?Q?If9QmybzYiImuSTflbMvg8T0a9SgjeJ23uSfN7GUDgoW6owGbXi5a0y8bW2p?=
 =?us-ascii?Q?ERnDm576vtq+izuyMr52UTpXlSggOrN5NSBjgh/FCv4PjcIRkbOeYnbpn8pq?=
 =?us-ascii?Q?Ys6LTa/pQuDTwj0JkDVZZV5KyA7PV1+L8D0AmF1wcm3NzdcD+yiSiRgzZFci?=
 =?us-ascii?Q?XXk9UFTGJLtMqtrYDSapP57Tx2ntq/P0rtAx4iCnnuOa0d+kU3xWQuHW1/iX?=
 =?us-ascii?Q?SAPh9C8ZDjx4gCjKn/f9gbhzgfpM8O8nmtFLxnoPU8O6nvoYdiLmCJiV4tpc?=
 =?us-ascii?Q?WzMm7Y9pYz/+95a6iFDGwHn3A6+40vHmjWZnV7mqY5uXJk2L174rqYKwI6ks?=
 =?us-ascii?Q?xRrKCJ3cz66bnLynFQVcBB7ORxikiBJOg/Fz3CaWVhPXF5jQSFq7ND7mZU3R?=
 =?us-ascii?Q?1C0myD7+8JdMvdx+sL+eTYNdaK4Qo2KHp7+KcbUZwT1qr2TgZqW/ug9TAaqM?=
 =?us-ascii?Q?Vwv3a5cqIwKb+SPXn6/CvW3vuQBHZaJieZYKz3mI9IIwESQLp9yp2i6M1UND?=
 =?us-ascii?Q?JalTiYkHToCybaksD0OL9Pn0uP8VmYMGrloeyrEkBcq8cORjDYfAI26wjLtc?=
 =?us-ascii?Q?vsCsQj093HVoss6B3pmCnqWvE44uXRntfY+hrae0kdoeqAQSG6OqiMNLaMj+?=
 =?us-ascii?Q?O093+/VKBtOx4/HLA/Sh8eVtEb8Hc/USChVOab4C6TGdwoWJlK6YqJEDRqVF?=
 =?us-ascii?Q?D7GF35pht0o9igwt4VCv8ql4VpaI55ZtnayVJrFYFbmAGRCuCCBqhSegNGr6?=
 =?us-ascii?Q?C3rkP/HpDy9CffXd0LWASw1xnTeHSH28xCD93IkhA2G0v7Wttm2JG1NF4a4D?=
 =?us-ascii?Q?Ni3L4S67Mrjp7NcLcUjK4wTWEOK2zFTMAIhq2LZBTUpEBV/FdROVDZYtMvdJ?=
 =?us-ascii?Q?LvkhjbRqbtDJygBOJUqMl2IfRG70O99/jP8BqqthhYqCSaR9cUNkpg8U9fWq?=
 =?us-ascii?Q?hrvl1tHmaZhuUtCh10zkcaj0y7C/BkRMtNU8H+sqs3LJ2A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b418bc-b4f6-4df8-b7f3-08d8ef7abc51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 10:42:49.9844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JmVDR5a9yRi0ymjg5zbqZw4d0HVAesVeud3u6w7nQLMzU/RVxsO4Tne/Ja3h3hL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to have special handling for swSMU supported ASICs.

Change-Id: I029414efa63c130a1a3aaba908bbf3857c5873ff
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 16 ++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  5 ++++-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index de540c209023..12e8b527776b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -842,14 +842,10 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 
 void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
 {
-	if (is_support_sw_smu(adev)) {
-		smu_gfx_state_change_set(&adev->smu, state);
-	} else {
-		mutex_lock(&adev->pm.mutex);
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->gfx_state_change_set)
-			((adev)->powerplay.pp_funcs->gfx_state_change_set(
-				(adev)->powerplay.pp_handle, state));
-		mutex_unlock(&adev->pm.mutex);
-	}
+	mutex_lock(&adev->pm.mutex);
+	if (adev->powerplay.pp_funcs &&
+	    adev->powerplay.pp_funcs->gfx_state_change_set)
+		((adev)->powerplay.pp_funcs->gfx_state_change_set(
+			(adev)->powerplay.pp_handle, state));
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 059d2c4e4c7f..ae05c16443c3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1317,8 +1317,6 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
-
 int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0d1372d440ed..b2898f93a3ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2920,8 +2920,10 @@ static int smu_enable_mgpu_fan_boost(void *handle)
 	return ret;
 }
 
-int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
+static int smu_gfx_state_change_set(void *handle,
+				    uint32_t state)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	mutex_lock(&smu->mutex);
@@ -2994,6 +2996,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
 	.load_firmware           = smu_load_microcode,
+	.gfx_state_change_set    = smu_gfx_state_change_set,
 };
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
