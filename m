Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A34C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C65664EB3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 23:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C65664EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7BD6E110;
	Fri, 19 Feb 2021 23:11:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7F26E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 23:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzkLGV5VMJ5rpaFMPcT6abna+hZFXXPEFlrVWjgNhSkI1gGaMJs4wGlXUHUdlNXECCRmbH6f1SDW7/VcVOOhCfVoC1SIBURT856A2PdCQP5GGP7orjlZdkOtPxJdvFnwWU2v9Jd0zoUGtSYmJwNJwcUwliq6S1gmDea2+H8rJ24osflfn73fHhXSi0ZecE88Mvag5vyn2VkEVe98lpV3i4oRfAtLKr+kmC3+22Cto3x1NUY3lo5fKlJuXhgFU49jsIH+BKKNpnmpnbX1GH6TUBmKsCm0Y+HBTlKZTZIykEwmcXrGhI0Aud/BjBuy6KC3isGdF9tD8wZGNaLfLT13fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QstQzO1Nels6q0OthhcQN71U66MYyJgejG+8/ofpdIg=;
 b=Yjk3wrPj/UQ/4BrbUxJzKPTSnuuDj0bJZAxQCMBN5jBWZLovk25fmrGTnm0isXaFBITBp8fzXUfyz3AEVf+B3g6mCkAMokoV4T7Ieay2aSQT13Ap7T1x1BNc1ivGr5fTlVx1FXaV0R3hhj5l4s3CBo63yQv+RAgSbSDJYeYFaQfU9qr3i2H1SY4YLZM9q1dRZrIeAtcCC8m33CKrAcgHNPmSV5kLFaCuBvrsxWwY5tl8P4+HQ3RseqpdC8RlYK9dDdaitutNQQ4bB23PqWdg1OlAKEQpQh1A3zE5z6Qhy7PNvnIdNKDOlPMsr7FjfM3ewnXWnoOAlH4UcvXnp7wIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QstQzO1Nels6q0OthhcQN71U66MYyJgejG+8/ofpdIg=;
 b=2b+bU+vbv/tUWH1Vh2bzX9bTE+G8tXPn20HHg8tn6gB7/UujjQ/ChrfIkgm6awfdo/doaFVtWQU9h1vltJGvRqlzhDopnr80MzbLy2fCvkvwTddRy591bteJ93uMVO0OcFDZeZaXBX7wKZDaABeh/CL2R0Z4+m4KilxKh3fBlAk=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 23:11:28 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 23:11:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXBl01v0ZbFS6gCEmvb376iost8qpgHEyA
Date: Fri, 19 Feb 2021 23:11:28 +0000
Message-ID: <DM6PR12MB383566CD518448A1C68F0556F4849@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011846.28413-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011846.28413-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-19T23:11:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bbc90143-d234-43a7-880d-406b22b83d0b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:edb9:4d5e:ad1e:3441]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9bd3f6f-69d3-4747-ec0b-08d8d52bafec
x-ms-traffictypediagnostic: DM6PR12MB3515:
x-microsoft-antispam-prvs: <DM6PR12MB3515B9135E1581D0D1D259FDF4849@DM6PR12MB3515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEsXy4vd6WuupsZhlDlXX2fsCZHA3BHHho99pXIe3SFYiSXzuduv3DrgVfUE2CDhAkXQQlGoYtyiaAIyZdXqyATrPocy6LbTyXh/k5iWTHVDNLdIT/gONNxwtqsdTWMJKOX/QAgfUT+yVXwNKBCLwc+ajo8xwIcC8RJxwK+dE88noM79FS4OLDw1IYP0qMqxi0CsUwjh48VGZ1wwM4doZf3qtGqRkIu4aV6eniZ1KkBJ7OJSzQFERb3f5Jzuwb4io1HXeH3Rwn5+41rHuCE4s1z7KqRWmS3dDtRqRnXrQmaF0XlzcjnCOFUs7Sa1oF5Uh6yii2FD+nu+C72vCSz/2Iq2/IATBeIik263JJ1p4KcA81lcG1AFPOPRwbj6x+piP8vFX41kqXVRT+4XAGYBz/O6IRX+NT/22Y2xKh1vsArHtS3D0StkYsYKQrGfCL7WuRPYpsGFdH/NlhmgKY8nzPlFcx6nKv+Ble7XpUoZZl3Bv3GZrcMuOCjG/EQea9xiJBJ4/dSogTyojQNBLh5QDv92MO0Qo7Yl0nT2AA2azmNtRbgJjYQujVwcQXen1YTO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(71200400001)(66476007)(6916009)(7696005)(8676002)(83380400001)(2906002)(66946007)(478600001)(186003)(66446008)(64756008)(6506007)(5660300002)(33656002)(8936002)(9686003)(53546011)(55016002)(316002)(52536014)(86362001)(76116006)(66556008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ljt52i79YEkfuWCnTOR1oJ8VEhABMBHm2oIvOTJWKeF/CYnkDQEZ1+p3kwf6?=
 =?us-ascii?Q?E1xzUulawmRxrqbClNoE+6xjrbK91xyM6ePC2RUltG9E3vwW0nUyYdHV6cML?=
 =?us-ascii?Q?C1RrfUwrWTULZWF/Wjn7lLXyAEtW+4vdr4yCW3LRlTrKaF+T4EYsV8leUIQG?=
 =?us-ascii?Q?aFBXIMi4ZRBhtkMVOdeWI0M4e4K9l9top5nWxPVT92ahOh9xkouYtv87TG6L?=
 =?us-ascii?Q?0SUD2ai1gMlwqCBqFv+lvWvuQlp3gNmPz4YDy/lGWbwzMvTCOsqorVGw+9AC?=
 =?us-ascii?Q?L08TDXFrutUk+eolT+IYnWdUOsoqCuiuHpO7xrWPSivn+hV7Xya4oFrv8PcC?=
 =?us-ascii?Q?FhDdS/Xbroiw72KuUbTTOyG724d+NppC/alO96XeiNP9PBN5ZJxuD3E+WjPG?=
 =?us-ascii?Q?hUD8YHDLqIiRUGMrnrvyLjdFfQuj6ZPxv/PtS7FVp38+qQvvKaAEHr9K8kPw?=
 =?us-ascii?Q?BcFt81iEvJ+LWFOCRa4uWMT05HiNpP1Qg5Nk6CItNtWjQQbEEXDoeNieeM+y?=
 =?us-ascii?Q?UahhRi8yeDbkrCiPg4sdSMBJCU++zCVmE8poV2cvsi5iCxwTZbuS+P3dmUaN?=
 =?us-ascii?Q?ba8W3hsp7EvyjlShQ6kOki9x7gzOVR1sj2OhQl7SJ61LEt1IQO6qyaMuoyPV?=
 =?us-ascii?Q?A6jnhR7deYjpjnSQiTPq0ZjSFcaycG/EhwwubnB5QxW30vO/HYZxMmKkrG+n?=
 =?us-ascii?Q?RW45G/2gbNk9y/YKR4gHl1Fd3/+zSJUQTGOejYf4SgjDSM8+NAp+BV+Wsf8x?=
 =?us-ascii?Q?gePf4uRF8TVheulWkumr008t6jE6C+kYEYVv8BxFAlcrOdPVu7l12fFwzyDg?=
 =?us-ascii?Q?/F8qDvbMcDZHLk7H0JLml/IDGTxbQENBJnJL2QrVgNwG1FFwx36vQ34R4He2?=
 =?us-ascii?Q?3li8az8Rb7NL6y9now7ePkXkEZZfFiZjMlmtLo9rkVck56x5Bvxj/mzUOT18?=
 =?us-ascii?Q?nJfmXGQQ5orgkN1l0wGZI8FRh8UL/b8QoXW8ic42iHLET0gDhwP5icUuTmCw?=
 =?us-ascii?Q?ifZp4dCIBP2mdl2pKMfsAXbH/DeXHjyd6jhUu3NR6YEJF0Ujq9WmlkM0cUAF?=
 =?us-ascii?Q?RuHhKTrohZlZ19/Zerb9fIT9dcTm7iIPDJTGAElLN4jnFgezbmo6y/Se9uKH?=
 =?us-ascii?Q?ZBxPo0JqEwr6Pl/f0erSRz1OJZ/Y5eiZEbfL94xVcc6vPAPCRKm0sKWnNVQJ?=
 =?us-ascii?Q?Buo0nF/zQ2eVWgOVHJ0qp/wGVZgrQ9atmab26n3pMLLMYmTeHYhOUxBNtJk5?=
 =?us-ascii?Q?M92e/hZihRinI7yr6SWEaOFLKAIllS6PI3s5a0EOp+5g3JTpSeIDTHEVCSkS?=
 =?us-ascii?Q?fbwDrkvGmBpy94fpNgokM/xejcKy8Pc0AGMNZDMXSs6YDl6mzKrj7UYmkIm0?=
 =?us-ascii?Q?2FNg9HcEu1hbXZRKYwaAYyV2tWZK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd3f6f-69d3-4747-ec0b-08d8d52bafec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 23:11:28.4015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhZ6hhwdocXrczzfQf2i0fYu9C+dlFXYJ8bQoARr808Qb6zdJXE/Lm7HTXK0GJeeDQ4xBw3DnJM9bWatWMeLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping .

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Thursday, February 18, 2021 8:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices without sync to each other. This could cause device hang since for XGMI configuration, all the devices within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f9ad7ed82be..9f574fd151bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4790,6 +4844,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/*enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..5e127a59b121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/*Don't do the real PSP HW init if we are pending on XGMI reset.
+	 *The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
