Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ABC43381
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197492339D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197492339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C213089F33;
	Fri, 15 Jan 2021 09:50:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6A46E041
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 09:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlIOrK24ckWEm60+6u720gMl7wncUT4Zz/QRYDoOl4ourZL66PPV2wiZyDIEmSuRE+PO+wCAFHgIpNezGiFdyBGVRx+5DvPLZooljb2teRRjmyvNjCDCi3vawHM+4YQYBiy9z/EKZG3pQFJj7ncGv8j117RWz8cQXxC54SMLA7O7BNZv6g3B+be6uJCDly21PS9v/V0l4JZh6I0IvctS0wXoZER5xzN2bSbACWRQNZYkPOkyi6XxMeX2aIgL8E9YqNnZ0hcGPEcnan3jbeVu7wk2CiGZa3I4foLBRwLYIN7ppybywHpGYQGSbyJLdYpzy19XVdB9cKFJY1IgsN9W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+ifnm0zbW7uFLaMn9PXxiyXZi7DbH8Srv8xgONrO7k=;
 b=eolRSoVzeFMP7YDnkf7UKeglF3JexosiHUnRjiaRU/cLvKuaZHVWu4zowDD/M0zWsJj0wEh0KGLD+Ag8Mxb3XL5eB5YEVBFIloja9DUKmwYwUE/i/KCdqicP47ZY4+Fjoi/RDhAyGnDWmhn7sFCjLjGJlAF2fNBvlJcBJjTuueYqjmoYxZ1lxHyDanCYC7j4aywB4QIQQyh6J+0Oo9RTRXPqUj1bd2QHkEGoiOqN1YTikMbICIphn4TMKdhu16yT8hwONisFPt4WVaWp0X4uwwIDJyubkUiAgHeVSHVesPToklwU6w6GrFrmycDaBdS6Ni986Vrm/u6Ge9a0lTZXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+ifnm0zbW7uFLaMn9PXxiyXZi7DbH8Srv8xgONrO7k=;
 b=zT5SPFLDmyglLZ/AIMiS+90qlox4gk8MXvtAc3+TjwCwfZvW0nkDlU7jBnmRIUVin0YsZoFNVNvtgmyL/JurPW2pYrJ2tC0i8Ma0HUABuCuPdc3MeezlWmze227fW5Wgr+uoUGh5L6bo0G2ACZSq6R0Dqgj4nvbdHIUX7Y6SdyA=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 09:50:36 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 09:50:36 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Index: AQHW6yGnB00tXH9EH0+DLmPWUTIFR6oocASQ
Date: Fri, 15 Jan 2021 09:50:36 +0000
Message-ID: <CY4PR12MB1287BB7FACC53E6156A9C7E4F1A70@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210115093406.389563-1-evan.quan@amd.com>
In-Reply-To: <20210115093406.389563-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T09:50:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=349d5cfe-a923-497d-903d-d771062d6fab;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ebff1fe-c877-46ea-49da-08d8b93b0278
x-ms-traffictypediagnostic: CY4PR12MB1749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB17491CE2E9D023F83F083035F1A70@CY4PR12MB1749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dj0Fr7NbSJvluifQsiEQzXMdjfL0AfXX8Umi+7lc6SV3w35YnNkGkPG/ui6MQSpz0++qeifMAcGXQSuOFzjpbtYMHvPh8D4/uRkEaMEqhxlX2Pp4ERyuQvHpRCGEy//47NlQkzrj2ZVhFHU4WayxiQhHIT89dm6SHi8WhdqqDkMFirtU5CwF0EH0q58ymSr1HB1fukkQySKQALpJ8sk+Ot2NoZOtD1/igh6jH1DZBb6gyX0DfEKB2qGHKW+9F5KLGvZFQNtq4pAhauaMTSsWBwfy5CIi5z8cwt39qzsEuG6N61eusr5SmaU9cMUIK9WgjFfpOm20VW7LaY9ABS+X5sy7pkJw0KpjDDUjPuApM74PAz/jJLwTfib68NzSzDdOJlVVFvCM8qLJZzUCEzNMNKB1zzEtmVbtFpGznIUsZe1PBKXc/f8eoV1yzAHXv1RyxDxNaE5SM9Gm3R+w4bDC6UMccFzTGs+dc6dTVaEdle5h7vw7bnXqYeQYJSPew8u6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(54906003)(4326008)(55016002)(26005)(110136005)(186003)(45080400002)(9686003)(64756008)(5660300002)(66446008)(316002)(2906002)(6506007)(53546011)(52536014)(33656002)(966005)(7696005)(71200400001)(66476007)(66556008)(66946007)(76116006)(8676002)(8936002)(83380400001)(478600001)(86362001)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VRtfvJlWWrt89F1BOTZYyG8IVdOhDIyk7IYa5T/akPeM6/jqNCXdkuT165Js?=
 =?us-ascii?Q?dqBcfDufAtGguShNblDobZV1kWIv5aHLez9R0cLQmSY2JHe2uW2JttButRuG?=
 =?us-ascii?Q?iEhLMjE6hpTSUQ/kMZyBofnOhIrct6M95l+8lNE8Dbfg9KR7xMG0E2VqZsEE?=
 =?us-ascii?Q?0xtO/np5CFAVmqAWk5LTLhuEqcWqTPMtTgjnQfqd25A8J7r5kYZ9JMB7OKEE?=
 =?us-ascii?Q?7twG9k5LallwY04BT9CtGlZXJHADvCKf9z6ITqtAW7RQ9FKEn0HWpqk3YuKi?=
 =?us-ascii?Q?UDuX8R6QKXsrmKk+Ff1Hi4xAy7ZZSLvBlZe7XXhPjz7WHiqdWXVkM8NOs6Wt?=
 =?us-ascii?Q?DfQ0DqjNwwtC0oiMKRPB5Ev6TiXWNqBbKCXbWdwVBDOXs1/MmGkmsRxyymC+?=
 =?us-ascii?Q?cpeBI0Y1ADrOuvfyAOwYKKKaqbTTNCnCvkE1BHXLzIIEG1CaR8TgbhZUzofJ?=
 =?us-ascii?Q?dg23doRkN3fXMRq3pP/zjzrqy0bkhR1HexSXYUh9kpr82SqL4yHukag5jQiQ?=
 =?us-ascii?Q?DX+IMFmy595z0T1PIeEPMnOjAAKdwFIwGRE1F4L3/B6nCGunE7Pz3Z8h415V?=
 =?us-ascii?Q?9bVLMSmrZSFk79j38qKH0ZnPgtn2X+CrHNBwp0X2GgaYsnzJl0hntAmJDDqB?=
 =?us-ascii?Q?TRU0nL8FNQfg3q4onDTw3syoZnmwQ+mTJ8BAzBm4MTB4SXzrfmC2lj5r3tuv?=
 =?us-ascii?Q?w6H79IH0OiT4jvn56b7SuheJExB/tti2mWyb4dpSQbI4GMQKxZscCfQrTxL/?=
 =?us-ascii?Q?Ee+C4Gh/uiB7lJuXrfBjmU4Q+YzllyCXFRRtshwfTQz2vYuIVrs3t5iiSf9n?=
 =?us-ascii?Q?s41LkW1rZkImG9Twnr5d8ZhfKHMf+MFbdWr7tT4H4+FRX/jErld6CrVj8gLO?=
 =?us-ascii?Q?xE+ZziFds+bQyOpx0KCy9UEehenvNhU1JrY1D03N5vrbRTwyytH/PaUBUBtY?=
 =?us-ascii?Q?VTUD+ic7E/MoQ0MGzIgcwas95nyfsvIsoadvYLFqZCU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebff1fe-c877-46ea-49da-08d8b93b0278
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 09:50:36.7022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TL4WM7h5IPgijpA73yuZqcIH8SYoHryuFD6l3cO7/A2lzJJCaJmWPNwP/cyG4i212kWSPBXKTIzUeo85mM5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

A few nit-picks, please check.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, January 15, 2021 5:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving

Support Navi1x gfxoff state retrieving.

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 13de692a4213..2857f1bf4e9a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..50566c613971 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,27 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
[Guchun]should be smu pointer?

+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t gfxOff_Status = 0;
[Guchun] Any cause to use capital O and S in this variable?

+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+	gfxOff_Status = reg & 0x3;
+
+	return gfxOff_Status;
[Guchun] return reg&0x3 is more simple?

+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6736a835d7b34d71079f08d8b938c8a7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463000831854828%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CUVBdQmZcOsqKxzoB4ut89g1UFmCW5PNDR6vvPIwk%2FQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
