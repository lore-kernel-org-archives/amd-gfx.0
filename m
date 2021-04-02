Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF5C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6280F61103
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280F61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E946EE13;
	Fri,  2 Apr 2021 06:47:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48A46EE13
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3WK7FCBW0YX4ZvGotVK58glSNb9V/Dl8zsKf2NkATwkCfnCNlVe7dG4amdeNU5eGg3CjhQjxav2x6z6MF1elb7lFd502KgW+n4UJC6uJ2gOwZUVZ3hnXX0BDeF4cFjf+gwHmtzBsuVpaDa4FNnduFih7uRhZ95+dvTFUPtVyTSOap+Wvul3S+XVYEKXjnyNzKfpvijnfpCAkwFWlNh8IhT5rBFEgEFGq97SITInRaB4UvJuzpittGi/DQNCFDpjBpizwbjjWIxXERO1F9zCtvenIkdCCRNzQ5xFhe9jetG1SMCf8JlgdAby9kyVuaqUSSmA+Er9ODoJ+7CStkDfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnLZHtzpCZTt4zRo1zgaBKtPQ7hra2Mg5p47z4DUAM0=;
 b=CkwmeARLFGnh83AFC4h+PcKrFAp0fb9D0Pt68XizZYEGhDmxHb3jM4MAHlzNU9adpg03huKarbKxlC9q7M4gSTC/KO3XK5xJwhJ3rS+jqnEO6EvIuju4EA3Ax29Scn/4F0oryptyqrrskFlMfUH3PVABIBzmZsYb32nODwNtOkS4fhmnbGTLlOuB1rUBBj460x/f24SP7uuNXA8FILZgxFB9gTw4N5Nbrlt5WSmUUvBQiPa3G42LkkXWzdHSbU+23DtnFISDLzLAOBuFyy/wcDOKBr2NwwZswKkcrISKCmo7mk4mmrwYzoKtUj2HZHfzLFXnE6Tm/bk0gRiiDEJzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnLZHtzpCZTt4zRo1zgaBKtPQ7hra2Mg5p47z4DUAM0=;
 b=Pj/g1GGS6NsJMTpxHiJZesfoAvdHq+lO0VwSl7dkLgWnnBB/wA6KalcZ2zIRrXDPe9VsrJCZg1Rc7lsck7QLUp1hwmEmvAnLhSB+4nN84qzfj6Ieg5pZV/kf21GSl3vixxh3bdjTc7Jf7eEcUgWcnJgh71SGHMopobtgEHcevyo=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1734.namprd12.prod.outlook.com
 (2603:10b6:903:121::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 2 Apr
 2021 06:47:39 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 06:47:38 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 11/11] drm/amdgpu: split gfx callbacks into ras and
 non-ras ones
Thread-Topic: [PATCH 11/11] drm/amdgpu: split gfx callbacks into ras and
 non-ras ones
Thread-Index: AQHXJ4uey1GIFywHAkalS3LegEDTlqqgyOXw
Date: Fri, 2 Apr 2021 06:47:38 +0000
Message-ID: <CY4PR1201MB0072335D3457BAF45B1893C0FB7A9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
 <20210402064345.14093-11-Hawking.Zhang@amd.com>
In-Reply-To: <20210402064345.14093-11-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-02T06:47:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=eb9013f2-de51-4e66-add6-7444af61523f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1057e71-3846-4a22-5ede-08d8f5a334e1
x-ms-traffictypediagnostic: CY4PR12MB1734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB173455D7DE545BF60150F1ECFB7A9@CY4PR12MB1734.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKDjNwC0nyH4facP3K/Q96oSIP1rH1mdKugEqLvHZcbLYN7i9VbELjfYvMZu4KOcOcwMVMz6EBb/T79hsZcdfqH1o9fNsKevLdis1jJBGygxU39G/6ry/l/VyPCrLI5H6/ROXNp4q0XnFNcbOMXArp14/snKTKmpQTwfJXgcgT5bGWM/BI0qzHSx0zfVHvOAeK/B3Ud33aSI1rwuXDblmMp/V99alQZIY/ycohcp0gB50md82BU64zbaujXCK5ymg712lrvs2rXZz32qPJ2F6jjbn0db8GZJniOax7S6j3L2KCnddWfj3EzuS4k6HcdfKLONfJj+m6uwAwq1rLUWWDcTfb4IvoNlyCkno/RFvefrRoMZmusxLAgeSrZFv/vBgNvFxi3rX4oYoVmchNEH2uQCRNE8UW0fvDTcsnCP5ODN+KUoQMFIfAASXilh/RDjlbc0xvaHqBQTvnpwWPvVxkBn86e9Fdj6Dv5mvYeBgwwIknYE5ZnN+0viNdG8o67Kt5hK7RcHrW7PmE9ZW6quIVZTWYc0P6xrt16TUKtZYdHlT2IaI5AP1QQKsowgpZtSIeEMaqF7+QG6fBeV0t2elNC6+ZpYVf5c9lYRLnnb6MfwY9E7OO1x4N6jJRy8FDpoygYmkyLO8YOwZxAcuqmGmHqS7n69xvSEK7i/2vJ5UdY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(83380400001)(7696005)(33656002)(2906002)(110136005)(52536014)(9686003)(8676002)(478600001)(30864003)(86362001)(53546011)(26005)(66476007)(66946007)(76116006)(6506007)(186003)(4326008)(6636002)(66556008)(64756008)(66446008)(8936002)(71200400001)(55016002)(316002)(38100700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5vvdiJ68/LTn1vKG1R8nbiLoPXkLJ1jjSi34ewM5Qy+1ySap1g1/PNTY3GMM?=
 =?us-ascii?Q?4SazZ1n+Gelq5Jpju3QXZuvj5CSuvb7y6M6bcypDV6BOAtYbx79K9yciLJXR?=
 =?us-ascii?Q?XZKtRsDSAws5NJziFj/6khu4g0OIwwxMXvi7XUFvyySYGtsbcDprZexBAWXT?=
 =?us-ascii?Q?AYdWDxUKeIUeL+0rGh1l4wPBX8YB7jhUMxse1OTX9z8mW5KjorPgurQEDapr?=
 =?us-ascii?Q?UYENJlrGAFos3dXMJ5a50msA2UdI6025UH32ew93YaJi3l/QdCwuj2A9BsJ1?=
 =?us-ascii?Q?43pP43WPgk+IEY5vsUnZjlIxHENmYEAbIV5LKoCsx9pXlnt/kA+ryWIV+A/K?=
 =?us-ascii?Q?fS1RIOM2Ky9tnjXWIUoFm/1HNiTHkd2Zj/WRAiuwiKsGvJzSEQDrgXBs8GZp?=
 =?us-ascii?Q?ARZPSjxoaDZ0Fv7n+LTXWsUkylw3+NMcbYuFMxdchUAIbEJqzInX56gpF4qM?=
 =?us-ascii?Q?WnJ6e3S/inQiyoE3iNliRrQ/ZYcNy+HD7net7BDlgG2rtNMg7JOqf2rt2V5i?=
 =?us-ascii?Q?IhFCRJNsBsaiigsOV0TUVseshUhzTo/1N5vUxYUqrfhyk2QU1gqh37gyR34e?=
 =?us-ascii?Q?vu1PMaatHRWBEdAL2haotzXhYqXlFzyYrfEPiEHu78U/Lpvi3W8+yQRJgyq6?=
 =?us-ascii?Q?ZZyhwW7+DFLpksKRx/T2aKOXYCgIrMAq8GvdV4Gzi9ZF5At22amwWpy/wnkr?=
 =?us-ascii?Q?jDhgzkaLV7gsk26KaDHx7nyc8t0l3BqJEF8YAvfJsqsJ6dbibWD9fUWv/eaL?=
 =?us-ascii?Q?9NJ1pOR6ZI1cJY9CsomeMGsy7vj70CYqWgNy2iugf2Hc7N2zkRVCDe5zdmXc?=
 =?us-ascii?Q?cEvFIdVDLHPUJkmSDueiYXBNIno64u41UmOpV3esBtoZEfHcMbbyPQKTyJvM?=
 =?us-ascii?Q?jmmuOCydIjqnFvXJGC+m2oPJVTFYMOCEeP8/4s9BLWDxe/ZMyuGOXQ38SnFY?=
 =?us-ascii?Q?LsGdUMywWKbVsox6Sje6TzOW9J1r8Sei9bPRKNiUuIqgNbwn3zSitNQ4ErM6?=
 =?us-ascii?Q?BlVMmlxzEic6dnbXa7gprWYUD/oEKnVdi6ib3BJeQ0k1A5l3cW8O4C59L/4C?=
 =?us-ascii?Q?DZ8w/wxKX3KX4mVZ6OpTtWNo1GuWaD0G2XkGBU24Kyvoe/Px+HR5HbhHDy0Z?=
 =?us-ascii?Q?SoCV0R7+9GmXNjq7Uh44Kp8rCsrWdd8ESaglCG4VcLdc1CcSrMKczB+GzUEN?=
 =?us-ascii?Q?9GjYOJIyoQGgoQCmP9zfKLxIJlNPAt8/9MZwNHdQwgjYOZPgd2pbLxRUEHbP?=
 =?us-ascii?Q?F7I2WfTX/igervsQ7ZyIRjyypVTDUaCkc1pOGf493ok1azysywAxt7EElSON?=
 =?us-ascii?Q?GogX6TU+i1q5qfooSsm0yd1K?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1057e71-3846-4a22-5ede-08d8f5a334e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 06:47:38.6935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5lFohP6maxpEP+emXjnwAfGhPugopIXtVM0jVLfR62BGcMHmURlwLUcP6Vq6bn+rn8jaCb2NuEpyN1ZhYjKMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Patch series:

Reviewed-By: John Clements <john.clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Friday, April 2, 2021 2:44 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 11/11] drm/amdgpu: split gfx callbacks into ras and non-ras ones

gfx ras is only available in cerntain ip generations.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  5 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 22 +++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 30 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 68 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 20 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   | 12 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 13 ++++-  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  9 +---
 8 files changed, 92 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 12e8b527776b..95d4f43a03df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -677,8 +677,9 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		if (adev->gfx.funcs->query_ras_error_count)
-			adev->gfx.funcs->query_ras_error_count(adev, err_data);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_count)
+			adev->gfx.ras_funcs->query_ras_error_count(adev, err_data);
 		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 38af93f501e1..d43fe2ed8116 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -205,6 +205,19 @@ struct amdgpu_cu_info {
 	uint32_t bitmap[4][4];
 };
 
+struct amdgpu_gfx_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	int (*ras_error_inject)(struct amdgpu_device *adev,
+				void *inject_if);
+	int (*query_ras_error_count)(struct amdgpu_device *adev,
+				     void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*query_ras_error_status)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	void (*enable_watchdog_timer)(struct amdgpu_device *adev); };
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev); @@ -220,14 +233,8 @@ struct amdgpu_gfx_funcs {
 				uint32_t *dst);
 	void (*select_me_pipe_q)(struct amdgpu_device *adev, u32 me, u32 pipe,
 				 u32 queue, u32 vmid);
-	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
-	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
-	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
-	void (*query_ras_error_status) (struct amdgpu_device *adev);
-	void (*reset_ras_error_status) (struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
-	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
@@ -330,7 +337,8 @@ struct amdgpu_gfx {
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
 	/*ras */
-	struct ras_common_if		*ras_if;
+	struct ras_common_if			*ras_if;
+	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b55f470eb747..1d905bcbc1ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -792,11 +792,13 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->query_ras_error_count)
-			adev->gfx.funcs->query_ras_error_count(adev, &err_data);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_count)
+			adev->gfx.ras_funcs->query_ras_error_count(adev, &err_data);
 
-		if (adev->gfx.funcs->query_ras_error_status)
-			adev->gfx.funcs->query_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_status)
+			adev->gfx.ras_funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -852,11 +854,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->reset_ras_error_count)
-			adev->gfx.funcs->reset_ras_error_count(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->reset_ras_error_count)
+			adev->gfx.ras_funcs->reset_ras_error_count(adev);
 
-		if (adev->gfx.funcs->reset_ras_error_status)
-			adev->gfx.funcs->reset_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->reset_ras_error_status)
+			adev->gfx.ras_funcs->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -926,8 +930,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->ras_error_inject)
-			ret = adev->gfx.funcs->ras_error_inject(adev, info);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->ras_error_inject)
+			ret = adev->gfx.ras_funcs->ras_error_inject(adev, info);
 		else
 			ret = -EINVAL;
 		break;
@@ -1514,8 +1519,9 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	 */
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.funcs->query_ras_error_status)
-			adev->gfx.funcs->query_ras_error_status(adev);
+		if (adev->gfx.ras_funcs &&
+		    adev->gfx.ras_funcs->query_ras_error_status)
+			adev->gfx.ras_funcs->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6e49b239087a..2111e4c46a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2089,45 +2089,22 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,  }
 
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+        .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
+        .select_se_sh = &gfx_v9_0_select_se_sh,
+        .read_wave_data = &gfx_v9_0_read_wave_data,
+        .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
+        .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
+        .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q, };
+
+static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs = {
+	.ras_late_init = amdgpu_gfx_ras_late_init,
+	.ras_fini = amdgpu_gfx_ras_fini,
 	.ras_error_inject = &gfx_v9_0_ras_error_inject,
 	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,  };
 
-static const struct amdgpu_gfx_funcs gfx_v9_4_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
-	.ras_error_inject = &gfx_v9_4_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
-};
-
-static const struct amdgpu_gfx_funcs gfx_v9_4_2_gfx_funcs = {
-	.get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
-	.select_se_sh = &gfx_v9_0_select_se_sh,
-	.read_wave_data = &gfx_v9_0_read_wave_data,
-	.read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
-	.read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
-	.select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
-	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
-	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
-};
-
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)  {
 	u32 gb_addr_config;
@@ -2154,6 +2131,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		DRM_INFO("fix gfx.config for vega12\n");
 		break;
 	case CHIP_VEGA20:
+		adev->gfx.ras_funcs = &gfx_v9_0_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100; @@ -2179,7 +2157,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	case CHIP_ARCTURUS:
-		adev->gfx.funcs = &gfx_v9_4_gfx_funcs;
+		adev->gfx.ras_funcs = &gfx_v9_4_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100; @@ -2200,7 +2178,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config |= 0x22010042;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->gfx.funcs = &gfx_v9_4_2_gfx_funcs;
+		adev->gfx.ras_funcs = &gfx_v9_4_2_ras_funcs;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100; @@ -2433,7 +2411,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_gfx_ras_fini(adev);
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->ras_fini)
+		adev->gfx.ras_funcs->ras_fini(adev);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
@@ -4752,12 +4732,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_gfx_ras_late_init(adev);
-	if (r)
-		return r;
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->ras_late_init) {
+		r = adev->gfx.ras_funcs->ras_late_init(adev);
+		if (r)
+			return r;
+	}
 
-	if (adev->gfx.funcs->enable_watchdog_timer)
-		adev->gfx.funcs->enable_watchdog_timer(adev);
+	if (adev->gfx.ras_funcs &&
+	    adev->gfx.ras_funcs->enable_watchdog_timer)
+		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index bc699d680ce8..830080ff90d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -863,8 +863,8 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status)
+static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
+					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0; @@ -906,7 +906,7 @@ int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
+static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
@@ -971,7 +971,8 @@ void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_DSM_INDEX, 255);  }
 
-int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
+				     void *inject_if)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -996,7 +997,7 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)  static const struct soc15_reg_entry gfx_v9_4_rdrsp_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
 
-void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
+static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 {
 	uint32_t i, j;
 	uint32_t reg_value;
@@ -1021,3 +1022,12 @@ void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	gfx_v9_4_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
+
+const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs = {
+        .ras_late_init = amdgpu_gfx_ras_late_init,
+        .ras_fini = amdgpu_gfx_ras_fini,
+        .ras_error_inject = &gfx_v9_4_ras_error_inject,
+        .query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+        .reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+        .query_ras_error_status = &gfx_v9_4_query_ras_error_status, };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index 875f18473a98..bdd16b568021 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -24,16 +24,6 @@
 #ifndef __GFX_V9_4_H__
 #define __GFX_V9_4_H__
 
-void gfx_v9_4_clear_ras_edc_counter(struct amdgpu_device *adev);
-
-int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status);
-
-int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if);
-
-void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev);
-
-void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev);
+extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
 
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 2e94998c9812..9ca76a3ac38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1283,4 +1283,15 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
-}
\ No newline at end of file
+}
+
+const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs = {
+	.ras_late_init = amdgpu_gfx_ras_late_init,
+	.ras_fini = amdgpu_gfx_ras_fini,
+	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
+	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index c143d178ef98..81c5833b6b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,11 +30,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 
-void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev); -int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if); -void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev); -int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status);
-void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev); -void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev);
+extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
+
 #endif /* __GFX_V9_4_2_H__ */
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
