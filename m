Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797DC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1315C6108E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1315C6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64E06EC1C;
	Tue,  8 Jun 2021 15:28:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479906EC1C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUD3iqk4ODtF6XSYJVK5JRSpGiWt1nDQnorxxM9/zShoNsTnXKO9ySkOASpdy0iyMJwThuUcdjC7KZ4sbrafhglfBm4rwPQHHOgzTXrMZreTOoAc7jMZ8JRz+tv1edQcBpLeEH0ZVHoow6yzyKeSu6dnCjBVisujMgvYU3Xi56O59+h+ZG8A2Fm8Wvhl7SbopFF83Lfk+tN3YQ2/P55u7UoRwL8YqmEaV5WZst1Dw1KgZplkBO9ZHfYfGZuWkPAih/VygH7fhkT4AI9YpNmeHnhp+KFWPzl5tHuXCR0g1Tkh+zK+eUjzIaPpXEWxHPSwTFYIOgOf1pBV34VU6NlEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMJGxqzgW30m8iWeJR86S5ruZ+mKWb4dV1h6ryAeoHs=;
 b=Ph6JwgcOnhTk1LilfyEvT/yJ2gHOzYRCJX+QFNCMxEhKhOTDCu2sHv3mbdKIblxPpaaMsMRO1mcKGLMrnuQwC8RGuGgB9AhorAd9JWhTzXGq+EQoB2Wzqp74cqhn4kKDr5ZYcaXyhjW3DKFkb84LAvTEhKpaAuW2KPI7VbhvfyW10BkSJb5QrSgKNx8MjnlyXZORZJ5+bSn2RBe2gM81g8VwXXX3mHc/gTOUtGXwRGl/t5qcOHuHyybRpG4Osn9SeaGPzRqCuRl0fpbhGDR4lEd9hxVbmt4PE9UjZb+Vb4c030MmELTLOBBjbfDcWuYOtc12THBCaNYAZugSN/PsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMJGxqzgW30m8iWeJR86S5ruZ+mKWb4dV1h6ryAeoHs=;
 b=jTk52vDRuAfbAeYJtLbgEL8cDtjDHjvpKEgCYEGt/ZTQswceFL1MMzOdV4qOAoayLMNVt7E/guzAP6LnHNbd80OFhKLLQQBUn2yv03nswuSG87eFCj6gV/dHDnkzIRWY2N9jrTpoGEdjIOa/uKMIv+S3Endat007uLYUA9a2Gos=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2908.namprd12.prod.outlook.com (2603:10b6:5:185::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.21; Tue, 8 Jun 2021 15:27:58 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:27:58 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amd/pm: correct the power limits reporting on OOB
 supported
Thread-Topic: [PATCH V2] drm/amd/pm: correct the power limits reporting on OOB
 supported
Thread-Index: AQHXXAtUPe8lDH979EqbD69JQ+A3PKsKPYcQ
Date: Tue, 8 Jun 2021 15:27:57 +0000
Message-ID: <DM6PR12MB27610C28F1293FD34138F7E38C379@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210608020915.1568920-1-evan.quan@amd.com>
In-Reply-To: <20210608020915.1568920-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-08T15:27:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6c0922ac-b5ea-4db5-ab65-bf1dc5ba6d1f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3675cb-9651-434e-3f48-08d92a91fe9f
x-ms-traffictypediagnostic: DM6PR12MB2908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB290887EED1E1D1A131574B808C379@DM6PR12MB2908.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZsBatPguVYTj6ITGX2vZdBPv1kFaPgEocQZ5AHaM+nlyReIe3T3Ku1JS/+PE2q/HjhVUmjpA6RgEcn1Z+NAWJHrd9IIKkAOU6N4h/x7j7oB5FKjtOnLODMAS3XRrvvJ3hiQA6ukKTtZ4hnt6ROFdDpljxKiUHcfA6AKXjul4N1SCxW32P5yOrPTocjiVH57+sflIkouxB4OTbShdNihHZRHvN9jifVJiMEg9ilorfrFh+Qgdm6j944Yjlm5hyCehxNRatiw2y/JyySidmnMgf/AWxzePC4ZarV105vRLaEvXfRero6GN3JNblbC3tO7MQTKMJeowXoif8WwU9+VheX4W+lhb68an+ySZ31pv9D7pfEglEQ7PWJAL7fpLED9hHaRH0PovfJmwIiaRZ3ktlhYuvBF+FB8a9nX6Lx5W/tZke+iy79rSR5GQNx+ezuaKvEz2Yt/4IMNV+NANi3TsskMZACIu4UHHydVbaGO1ygFzOHBN/F9r6UhJP3obDbnccajnxd8I4LFcB4y7MJKAljNbqmMCcDAP9PI1FhaDRL5F0BX/3OYR5Bi7HMQleFSzN0km9QSvKWPAaKheBQ2XEmdDFbF+SYH+o5cgm6WtNQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(9686003)(53546011)(7696005)(66476007)(64756008)(66446008)(8676002)(6506007)(54906003)(55016002)(66946007)(4326008)(33656002)(316002)(5660300002)(52536014)(110136005)(30864003)(478600001)(38100700002)(122000001)(86362001)(2906002)(71200400001)(83380400001)(66556008)(8936002)(186003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JKre7p+tfMhbmi6iQgcmi2WkHfvhXkNfNfg2XdKDN2TlnyPRnuXDMYqLXxqC?=
 =?us-ascii?Q?JS2YHhoMQgNuJNtDKrVC7yBMHG44t5z2QqIpYdvA4lykK7mQBR9ddMHN1oTP?=
 =?us-ascii?Q?KO9wpwXaZl78uidkTaDP2S002LIglNKLWa0MEichIaLEAqlIX0/dbMznwNOi?=
 =?us-ascii?Q?1gn89Fx67wjzNmR2CTG+AbAWNP0NWliokuoKpByJeuegwOY+dwPpVYczhU6k?=
 =?us-ascii?Q?7QWb/Dt9LH9kHyTIWbhTL8AkYSEzmtbj/T5yf+BXI2H/mQhZrO2bsM9fY4TH?=
 =?us-ascii?Q?m+AQvrplN01p2XFTJHf5ic+hzSPfWeg06vvN/alhTtq58aP7K3ZCK6ZJuQL5?=
 =?us-ascii?Q?0hTH2fDvMEJOhvyW4ANoDcPdO3VGvnnbiAE45Fl6ZiSfSxjw1eLWOfBP5y0m?=
 =?us-ascii?Q?y+DAmT0rh1wNMg/QUISe2DZQazuzcARc9L6riEr84khX0PQxkPGb9fiACY+p?=
 =?us-ascii?Q?WKPPBzu5RIaZ0qtvczBB9vkTrOgRuxa5DZRvHPB2OhS3/qhc0Fd78sJju8pT?=
 =?us-ascii?Q?NZtLGgrAhK7oT8+1KvODgEIdjE4tiXs4uNVmvRWzLUp6PWEOhYGV5M5afRr8?=
 =?us-ascii?Q?36l5Dwwef3HJCt4Ht8cc/RGY/OHoyn7kZYjpyBIR2ph8C0fY/yPzgYhlfOfE?=
 =?us-ascii?Q?pYvs/QqRC5bEZJQgZYizYwtK9cJdSGfbazhlOLuEn4P1kLFFU4uxAExAi7i/?=
 =?us-ascii?Q?ltrOONFqBdTBYRAVzjsmTZMVG3EsmxnEVAOy5oboUdImJng93m+zvhrO38bM?=
 =?us-ascii?Q?p4EikqtHEQ1KE8yzP5lc2aFwiAI9NGaZ9KAzQfKn2yF/kvfnM22AaHgjw0zA?=
 =?us-ascii?Q?8ascrTICEwFZaYTlONxS89MsEyofuwiHTkpjFLWC+LIxKSTBbzKkjr6Z7WUc?=
 =?us-ascii?Q?ygGp0ThWKVcmjwFTzWIQpO1UuGMhpLyS17bbNJmp9olyhBa5MaM0Z+7xirdI?=
 =?us-ascii?Q?Ep0ZY48XQui3zXf4r85pyB02Ad3LXp+UoaR80TsYtrnN/+iFHdLuIrjuZDf+?=
 =?us-ascii?Q?DIbLNREbYRiAjsYgjkHYY0zYsnLx/tnH4tqJ96snBBqXtpAsD4nEJPtB71uq?=
 =?us-ascii?Q?usC+Sz8Y2wKhATI3j1VMvmK3Vx09yKNiPXQhrYsgqjqEufKwVg8n1OmMtMze?=
 =?us-ascii?Q?WO5K3DM+SMTxVp+UAzDDu1GUaknutGsceFCPA+HquBqQLJQCsfOhii6FGsPw?=
 =?us-ascii?Q?HT4HRrIqaZ6D+2Xz8Rn4ZmwzdSJ7Mw+zMeO/DTBI34asHCs6fRT5M86AFbnM?=
 =?us-ascii?Q?Eku5ubb93o4Hl0SFbERig5jVd2cRJwd0BJ8TaJh4s9/BaYZcf0Mj/zbeJIqs?=
 =?us-ascii?Q?We7HIfAjpj1Xa66swG6khkhf+0rv3fA7DRPA2IhnkAFlDa1F1tR6E7mZFwdn?=
 =?us-ascii?Q?fZH6H+1I/bnyWYlsBlwDZgysp7ss?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3675cb-9651-434e-3f48-08d92a91fe9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 15:27:57.8560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAO/P6JjvafdpYnY9JsQge8mvsh3Loi/WtYzday9UgXP/r2oUGnWWVwupUoiaWQQuxJNnNY+dEiIc0C80qy16A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
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

[AMD Official Use Only]

Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, June 7, 2021 10:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V2] drm/amd/pm: correct the power limits reporting on OOB supported

As OOB(out-of-band) interface may be used to update the power limits.
Thus to make sure the power limits reporting of our driver always reflects the correct values, the internal cache must be aligned carefully.

V2: add support for out-of-band of other ASICs
    align cached current power limit with OOB imposed

Change-Id: I63450ab75ec6ceb7f345bd3704295a28db23b881
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 28 +++++++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++++++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 17 ++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 8 files changed, 95 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..fb7438224872 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -723,7 +723,10 @@ struct pptable_funcs {
 	/**
 	 * @get_power_limit: Get the device's power limits.
 	 */
-	int (*get_power_limit)(struct smu_context *smu);
+	int (*get_power_limit)(struct smu_context *smu,
+			       uint32_t *current_power_limit,
+			       uint32_t *default_power_limit,
+			       uint32_t *max_power_limit);
 
 	/**
 	 * @get_ppt_limit: Get the device's ppt limits.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6aab65c684ba..57da4dbe94c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -688,7 +688,10 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_get_asic_power_limits(smu);
+	ret = smu_get_asic_power_limits(smu,
+					&smu->current_power_limit,
+					&smu->default_power_limit,
+					&smu->max_power_limit);
 	if (ret) {
 		dev_err(adev->dev, "Failed to get asic power limits!\n");
 		return ret;
@@ -2191,6 +2194,15 @@ int smu_get_power_limit(struct smu_context *smu,
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
+			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
+			     (smu->adev->asic_type == CHIP_SIENNA_CICHLID) ||
+			     (smu->adev->asic_type == CHIP_NAVY_FLOUNDER) ||
+			     (smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) ||
+			     (smu->adev->asic_type == CHIP_BEIGE_GOBY))
+				ret = smu_get_asic_power_limits(smu,
+								&smu->current_power_limit,
+								NULL,
+								NULL);
 			*limit = smu->current_power_limit;
 			break;
 		case SMU_PPT_LIMIT_DEFAULT:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5959019f51ad..dbd9838bcf5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1174,7 +1174,10 @@ static int arcturus_get_fan_parameters(struct smu_context *smu)
 	return 0;
 }
 
-static int arcturus_get_power_limit(struct smu_context *smu)
+static int arcturus_get_power_limit(struct smu_context *smu,
+				    uint32_t *current_power_limit,
+				    uint32_t *default_power_limit,
+				    uint32_t *max_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -1190,17 +1193,24 @@ static int arcturus_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = 
+le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POW
+ERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: 
+%d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 74a8c676e22c..695c65767258 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2138,7 +2138,10 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
 	return ret;
 }
 
-static int navi10_get_power_limit(struct smu_context *smu)
+static int navi10_get_power_limit(struct smu_context *smu,
+				  uint32_t *current_power_limit,
+				  uint32_t *default_power_limit,
+				  uint32_t *max_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -2155,18 +2158,25 @@ static int navi10_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled &&
-	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled &&
+		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+			od_percent = 
+le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POW
+ERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: 
+%d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f01e919e1f89..a9e35c1255f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1770,7 +1770,10 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static int sienna_cichlid_get_power_limit(struct smu_context *smu)
+static int sienna_cichlid_get_power_limit(struct smu_context *smu,
+					  uint32_t *current_power_limit,
+					  uint32_t *default_power_limit,
+					  uint32_t *max_power_limit)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
@@ -1783,17 +1786,23 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 		power_limit =
 			table_member[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = 
+le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_P
+OWERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: 
+%d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..35ceab408a26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2051,7 +2051,10 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);  }
 
-static int vangogh_get_power_limit(struct smu_context *smu)
+static int vangogh_get_power_limit(struct smu_context *smu,
+				   uint32_t *current_power_limit,
+				   uint32_t *default_power_limit,
+				   uint32_t *max_power_limit)
 {
 	struct smu_11_5_power_context *power_context =
 								smu->smu_power.power_context;
@@ -2067,8 +2070,12 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	smu->current_power_limit = smu->default_power_limit = ppt_limit / 1000;
-	smu->max_power_limit = 29;
+	if (current_power_limit)
+		*current_power_limit = ppt_limit / 1000;
+	if (default_power_limit)
+		*default_power_limit = ppt_limit / 1000;
+	if (max_power_limit)
+		*max_power_limit = 29;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6ee9c4186f02..1cf1efcee09d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1132,7 +1132,10 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
-static int aldebaran_get_power_limit(struct smu_context *smu)
+static int aldebaran_get_power_limit(struct smu_context *smu,
+				     uint32_t *current_power_limit,
+				     uint32_t *default_power_limit,
+				     uint32_t *max_power_limit)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit = 0;
@@ -1152,9 +1155,15 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 		power_limit = pptable->PptLimit;
 	}
 
-	smu->current_power_limit = smu->default_power_limit = power_limit;
-	if (pptable)
-		smu->max_power_limit = pptable->PptLimit;
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit) {
+		if (pptable)
+			*max_power_limit = pptable->PptLimit;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 68d9464ababc..33101dc93bcc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -82,7 +82,7 @@
 #define smu_i2c_fini(smu, control)					smu_ppt_funcs(i2c_fini, 0, smu, control)
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
-#define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
+#define smu_get_asic_power_limits(smu, current, default, max)		smu_ppt_funcs(get_power_limit, 0, smu, current, default, max)
 #define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
