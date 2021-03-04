Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A399C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 00:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEEF64F51
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 00:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEEF64F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73A56E454;
	Thu,  4 Mar 2021 00:49:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF626E454
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 00:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrlDSs6E5u2jpFnpdRCwmjx/q+AvxR8cn0jrBUdXvPzjR3d9ilhFcz3xplwQAFF6HmfCQxw4GUXU35rNAyw+6Fkv+phvCuuc/1eM60rJTfBTMCcnQ+7FgqW411QIVKbCLGc0uzNJJvGl8BXXUipuhzFymbA6kILH2pQMkHuVf+MWFhwYiHKaZfZBKvXSXE31c+dlUcdzKnmx7smr1fsOXSN0WbBdssBYVTXQnWbS9S0pg58AHuf4R0iAnpQn2oMz4ijtfWtgIsHg1B4O0XNTjJQp9Gh0PZqrieDIh3ViQttm/b7K/YYY9vIx/gYn1NT2AMBEyJ2rRB13VmIQrz+ayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHcBB4RUnBrNHFYG5tgraciPx9IrLC7NRHDch3pUDU=;
 b=BbkNISt0hwmxU+HsbBbgeJPvXKbSxJpBqLiEA+6IeqJbVliyl3MfHzPMEp7M67sRQguEmdgBItbMY/D84If4NRoH10tnQLZNo2+QKc2EbAlfE3FQHtcSkkHaZroAeE25w3+pZOVvqnEmS5NX5DEXP5V5ijRa4Yb7j3dz61d0PB5WLksLCyTJleUnz0mURFyPRylun9oZD5VWrRcGAE0SXi1Drd26Ltkdn7se9knXFS3Qse/a/IrxvRtZlv5aUph9VZbtb+SwpirKwxLhZCqda5guGdUBoMfLh2AjpCF3xdil/Cwz/d5tr7tg4EGxsVug/71tHfh5nMJomJ8TXoh5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHcBB4RUnBrNHFYG5tgraciPx9IrLC7NRHDch3pUDU=;
 b=aUMX2xqBSslT5ILNIuDd86PKtiKfz0Lf6/DRfqumgfl8j+CjKiOgyjB83v31MW3tUUYFLpjcKDaa9HMQxzCi1fgCnLXCrXbHAa/KdIqsyf+f2ZiynOw7VFNP3cHYPzUxCUDFpFccfJIZAqSrliMy9liVWO/e30V/LlyyWb0npzU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Thu, 4 Mar 2021 00:49:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 00:49:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm/swsmu: clean up user profile function
Thread-Topic: [PATCH v2] drm/amd/pm/swsmu: clean up user profile function
Thread-Index: AQHXEDaSjrFeDyyhTk+5CwXacSndZapy/8aw
Date: Thu, 4 Mar 2021 00:49:23 +0000
Message-ID: <DM6PR12MB26199F76DC70A7AE521FEE5CE4979@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210303140919.29132-1-Arunpravin.PaneerSelvam@amd.com>
In-Reply-To: <20210303140919.29132-1-Arunpravin.PaneerSelvam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T00:49:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=eeade0c7-dfe0-47e3-b4bc-0f52c68bba42;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7f3bef2-26b2-463d-fd2e-08d8dea75ac3
x-ms-traffictypediagnostic: DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433A97F93EBE67651818005E4979@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19cAaZLjmYUetbbssiz+kvYzk1dWim2R93/6QzTnZ0i8jgacik5mPXgKyykbRFA2ZQPQ9SjrYtOizreSi4wRsRPCVJpFi2ZpdQDCHINbAM5Gwea2pNBpkJAE2EJcGK9SMzTWMX7+2uUU4aPwbdkWT+raX1YdlSog4/grGXLBwsN9IJd8vUl4QTbpLlhB0++jv4TU2LxSpMys8A8NSzMM3Riot2e1iG8otBaDgF0zb95/U/v3KewDVWOwIYavozKEAbP4Z7PjAW1F5NgLP2Gt/PiIX2uyQGkD6795zAQM5DTbhXIqBn+D2strkmyqhkQo5NeTqf4DKThu4tVnPc2Z+gHr7zmJQUYaJ4oaX5OEKP+Uz5AK7hmr0tq+sGG8c+8QELIkc3ai6CymFjfTdo+RfAZ1s/43dKEg2wysiZmMeUpafzMwL+FIqxCa567Nrh0jq47+SwM3zBYmdGqESTNxS3AWtLO/mkezc+KkvwuH+FB6KJHIdO29UVFxiR+ObxFFg3SjPhVFSn40za9sC84www==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(71200400001)(478600001)(8676002)(8936002)(4326008)(6506007)(186003)(26005)(55016002)(53546011)(86362001)(33656002)(5660300002)(76116006)(83380400001)(52536014)(66476007)(66446008)(316002)(9686003)(54906003)(110136005)(7696005)(2906002)(66556008)(66946007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ELjgY1S2Tna1ZQgUaw2uSt33D+MCMe52U7iPxyDQpxP0t7NqM6FM2S3Z8eXT?=
 =?us-ascii?Q?2p9nk/YbBq3NWDidBLspmAHaScvDHtAW+41jUPVM2821eM66aw3XF1TUfVYY?=
 =?us-ascii?Q?GNbhQJyl+J1ZXtOMc83cucNqiVhf+oO2hOMtioaOmM/Y1tBBGsQfd3ACcA12?=
 =?us-ascii?Q?p+2M57gDoDv//EEtiPpxrKdxpXHpA3iDclQcieLGQSB14o5RQZjUAZxnakeK?=
 =?us-ascii?Q?2E7bz8lLyDpoPnJOs22gd7qWckGWwrKIrC5mZAFq4mWiMrr0/BfUvoqezrkH?=
 =?us-ascii?Q?VqCyKYjJb5uDAfllVeY/svZE2m/wtarvXLmuGWxvmItvdHTitKPnBGuXrlj/?=
 =?us-ascii?Q?V02olwNWhR6mnYDGFzEwK5yF615j/3jpttY/6tyN3/OUwpNkMC1XIcptKklZ?=
 =?us-ascii?Q?B8OpPD8sp1dnhDwvlwAHEVD1tvIEdFl0w9bpzMdpnKVrXsb2Lk6nGlN92st7?=
 =?us-ascii?Q?NDtZX6JZ+NCZG2L+qvIctI0Pz2QZhdmkXhT0eVHQ4gAKP39dvnEWzQUb4K8o?=
 =?us-ascii?Q?70tWrn6VHhTCI6u11/OcDCXr/ROvSVkIrIb+m8nYcB8gOIGBjKJW/z32v5Go?=
 =?us-ascii?Q?YCO89eZDOkHkY0uQ0qO0XSB7Bkuh4phNDfcCMcRuClw28GkfaDmEWJ/760FS?=
 =?us-ascii?Q?63M8e2WDLJZWbHnRKYpIyHGa6BDwZsfAuuTYeG4AZ/g5bg50aRtr7cFYNeTE?=
 =?us-ascii?Q?NreQNMz5Of2yHZdOhd51eg0paIpMqf2qTbcL7KhgOpyTYjtVZxizdCEmBAxN?=
 =?us-ascii?Q?lWqxRSPuLEKn7LpkJD46r1u1T9Mkr46cFubLOgdeRGLnzMSxIs3draNSlaFf?=
 =?us-ascii?Q?CKxw5WW7zdD6Z+D/iEYaQYh8Wkd4yQaF8zq4ne1AmRUEtVbVGKzTpczjtqUS?=
 =?us-ascii?Q?j9xE7RfENOkF2paImyKQZPNk1S/GU6DKNxZp6QnF7QdoE6WAs/MBjU19fSpp?=
 =?us-ascii?Q?KJTgg3wmmyokqIqandC7FmJVHqW8CpGLYdgC99kkq0mW/p8rD240y6kUaT30?=
 =?us-ascii?Q?wXIK+ieLwY/IPoWRKUCLQt6Sknzzh3rTEZUCX5tPWpAYNiGdj8xFEvG6nIbK?=
 =?us-ascii?Q?j4k9avrp7Apb7hrpyU27T/mMwOPxDw15xvAYoaN0kVB0z+9/ofoAZKkHvzul?=
 =?us-ascii?Q?Ib5rIiABDfQ/rFFoIOslkzUzCU0pxUQ0OghDHR+jv4JGdAsMW9gon9/NxUga?=
 =?us-ascii?Q?283T0a4gjfCMXLoXfHMU4KensA7uMRlqE9G2Ig0UYn6f8mVlOscnDg/XiXwV?=
 =?us-ascii?Q?KPmBhOeQK5ME2KLD0MjFbSbOzMhwNQCSucGsNmAQbm0KGfJcHZjKcdmYvx8y?=
 =?us-ascii?Q?/Jkhpx94yh+abnt5GnEvcqKY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f3bef2-26b2-463d-fd2e-08d8dea75ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 00:49:23.5574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oR1ByfLpCw3fEQVH/maerxKeGa/bMqvlSiiev1nIVZ/Q5kXhRjOy/JuceTI2L+AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com> 
Sent: Wednesday, March 3, 2021 10:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] drm/amd/pm/swsmu: clean up user profile function

Remove unnecessary comments, enable restore mode using '|=' operator, fixes the alignment to improve the code readability.

v2: Move all restoration flag check to bitwise '&' operator

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 34 ++++++++---------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..a64228157ff6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -315,35 +315,25 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 	if (smu->adev->in_suspend)
 		return;
 
-	/*
-	 * mclk, fclk and socclk are interdependent
-	 * on each other
-	 */
 	if (clk == SMU_MCLK) {
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set mclk dependent clocks(fclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_FCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over FCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set fclk dependent clocks(mclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_SOCCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over SOCCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set socclk dependent clocks(mclk and fclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
 	} else
-		/* add clk dependencies here, if any */
+		/* Add clk dependencies here, if any */
 		return;
 }
 
@@ -367,7 +357,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		return;
 
 	/* Enable restore flag */
-	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) { @@ -390,8 +380,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
-					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
-							clk_type);
+					dev_err(smu->adev->dev,
+						"Failed to set clock type = %d\n", clk_type);
 			}
 		}
 	}
@@ -1844,7 +1834,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE) {
+		if (!ret && !(smu->user_dpm_profile.flags & 
+SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.clk_mask[clk_type] = mask;
 			smu_set_user_clk_dependencies(smu, clk_type);
 		}
@@ -2141,7 +2131,7 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_percent) {
 		percent = speed * 100 / smu->fan_max_rpm;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & 
+SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_speed_percent = percent;
 	}
 
@@ -2212,7 +2202,7 @@ int smu_set_power_limit(void *handle, uint32_t limit)
 
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & 
+SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.power_limit = limit;
 	}
 
@@ -2433,7 +2423,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	if (smu->ppt_funcs->set_fan_control_mode) {
 		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & 
+SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_mode = value;
 	}
 
@@ -2441,7 +2431,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 		smu->user_dpm_profile.fan_speed_percent = 0;
 
 	return ret;
@@ -2492,7 +2482,7 @@ int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & 
+SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_speed_percent = speed;
 	}
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
