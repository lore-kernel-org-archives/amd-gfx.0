Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7FAC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5A322D37
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 03:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5A322D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AEC89EAE;
	Tue, 12 Jan 2021 03:01:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E397689EAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 03:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK7EMxYW0cSa67w1dQXdUzXO4lD9qsKeDOLfuw8dqp8UQJul22BgAiMOgTqYoOuDmny2UfTwSVY902O7KM2IGIqRFAk9RDDOeclYRAQUQRVYl2zsp6Y9+7Q6BwD0MVO4YQfC4jyllcJ5rc7wdv8ZUu1urXy1MI9AtwdYfUsJDYZHRbNFGjxKse+xoZvtomVdQ7COugMREkNNBBnoTObqT8K7oTviZNPVKXZN8uss8EsGjXt7V+cbF6rMqaniJ7FzKetu0/TLsDu7E6OzkoyADef1d3mB/gY3OVn6ST7uW7RQ3eAb9KRPCi0A2C34u3SEeQBDRNV5BCl5v1NTLbKt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmJnf8uXWttWV5yZDgGT9IdTNJJzo1SFMvf/RzFhm84=;
 b=hu9zpETedOmG4bQ2hZzAdswHlpit0JTf+cXOjMNeZrJ6+1Ocd55x3/YCODTQRkjZDOiiZ23scA2vaa60tjbzv8Kxrxq847+1NbKhzXsSvWVE2vtF8gQV5WObIud3uoCPDYF7UVGuVASMPGXlSFr+rSrxFZso9++FxL6QcotCd9lY5u//trgAc0FH17mhT1a2PBxvN9O1fwJP0AjyK/2B2ZuJpC825OwtW5ZRe+UD9/8tj9A+ymPEseSnfcF8Q5LVo/Lrf3RFfwv7FYSpmJ5brYHoIrIFee48g+lIJa5f+bdNQfvfDbcfn8Kl/Ksrll0+HBh/ktUtFt6HA9ZuyqqRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmJnf8uXWttWV5yZDgGT9IdTNJJzo1SFMvf/RzFhm84=;
 b=fgeSllhh+Xhkpq923QbY7n2UbMqlHGVzyjZYXhbxq0txtqdNhloLiTGYpzo2KQQpcae1pn3sVOg/6ZFYunf9IveyElzQoi1LKVBv1ZVNw+FjbWjtBgEUrVuU0oAOHXnjXxrMXZqsZK9cERWp/62ELtw3PHYW9ueUQYgQCGsVniQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0117.namprd12.prod.outlook.com (2603:10b6:910:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 03:01:21 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 03:01:21 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Topic: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Index: AQHW6F0deU4NmNrDbE2gwZB6UsfjN6ojTVJw
Date: Tue, 12 Jan 2021 03:01:20 +0000
Message-ID: <CY4PR12MB1287CCD6B57FD4F7AF025520F1AA0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210111210236.2376738-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20210111210236.2376738-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-12T03:00:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0ee04a0e-da34-481b-b8f4-0000d384a351;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-12T03:01:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c3ee91ce-e2c9-417e-bd4a-0000106b9702
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2714c4aa-d4f1-4237-bb90-08d8b6a656eb
x-ms-traffictypediagnostic: CY4PR1201MB0117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01171DE6284BA45458A62BFEF1AA0@CY4PR1201MB0117.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ydt6VAOnkX3PCKUNt4ah8KacNIjyHb9qj4oOXIhDTihYp2cW9ewdKAHbVLTNexcOfEYwjp+JQ97zJvayz/ujmYgG4v/oM1F6skzi6/tc+FLmnDIROT0E60EO4Uc71uF4BrrxKZEnSOvKQ8DKy21eYgqcRkuSeMTcOwu7BbGFLip63Oa+AwDlV7jjmk0t1O6aav5oUKFmMMXfcDZZYtA02NlBl56VwOLUU6sixZ9cUBdviE7SeBQ5WlTQqWGzwbt/HXbFMNPWQqL0NY8wtNUAVzQIhydyUfNB2zUpp2hdgkv8T5MbRGUy34qKksJiBS4HaRF6wUKqg8FG9l+//VwaK5c2g2GMeNmE1qlQGSUywOknBI3vJf3zHKuaMwgKRolO7r6bpcuE0GLkEDkkMG1R1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(71200400001)(26005)(76116006)(66476007)(7696005)(186003)(316002)(86362001)(55016002)(64756008)(9686003)(66556008)(83380400001)(2906002)(66946007)(6636002)(8676002)(66446008)(53546011)(6506007)(5660300002)(478600001)(4326008)(8936002)(52536014)(54906003)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8j6MJfRaZCxMtUWI+BkRsLIK3GoPB9ZeOOgOTI5pq5+V5E/kSC3w2S5KfhvF?=
 =?us-ascii?Q?PkhxETKyuHoNlhV1fjjxMfegtliGlhHG1TcK88KoOe+vDzCONcASKyAJ2E1e?=
 =?us-ascii?Q?MTZjqf+2kFItofAn9dznhOJlPf3oh7YuRoslT2Z4E3tiBolk8doTsDwKSwJ4?=
 =?us-ascii?Q?d5Ai3yYqm60w3nlWB7oGADh+MfCCTk+ZZJyhdCiCWJtm3VoASpOYL+DB0ZX7?=
 =?us-ascii?Q?WWTdKYfC2j7a/2ufVl7YbiDDXI+9dqF/AKWP4vi2cbUOpESk/mInJZNvgXZy?=
 =?us-ascii?Q?OsOWQq21w5OV5fDZRYwfI2VWF/X79q0XZfCv8jYq5Tn9fJCMEvHS+/39wSwv?=
 =?us-ascii?Q?t3flAzFeQaBe1IxyQNXWYY38HLaioKdhnsL2bASQSROzUFnNIxLM/syasJwq?=
 =?us-ascii?Q?G2bIrYeSeP9+ob2iY5sacrbVeoSqaCqaKeI9E+LfOVdvF7FZHj6frff8/ImU?=
 =?us-ascii?Q?IQiQAd0mXpdwJHXwPC6iEeShSvZqixo1hd3u9MHKZ0Jgjlws+1TYue+c+v5B?=
 =?us-ascii?Q?3Y0vPADPM4PdtrBeGkw/RmO9NMjm6PoOLfvtF6jvAV0zss7QKK9WvUbBtr/o?=
 =?us-ascii?Q?fYwryYcgbiXbb8rnCV2oJeEChrJ5Aqmi0aub8uypHPyo4xPioO56ZADOAG0j?=
 =?us-ascii?Q?XtX7VYPDctgEGzpm4ch6xvW7s7fFkbQjuhYeJkiLjUu5Xb20JByS5hWIYkUZ?=
 =?us-ascii?Q?EwtEBC0wfmWKxpxLjso2Cd+5nIHXVXeNdVX7THKw+fRbxfs5mhiipjCeWYhK?=
 =?us-ascii?Q?z3s3xz2xtEiHd3NkEAsdkvePH+a80cf5w+JksOz2Ia4lj5XokG1YYkyRLfiD?=
 =?us-ascii?Q?ALfCLQjtSj7oKNmfO8turS9wSo8IvHTkvPfBV3hXI/R4x2J9nBhWuCRuxxjx?=
 =?us-ascii?Q?CDQYhU29VKB2gr4N8ByJHS2aUNo8Fqy1fW6LN6SdBT6DmfUDvA/+QiCHFR6n?=
 =?us-ascii?Q?A6uT3dnNvP0do1lyvgIbFj2WKphYTLuhAz6zdFC3yP7S4nGzhHKCtAvdf6eK?=
 =?us-ascii?Q?MQAF?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2714c4aa-d4f1-4237-bb90-08d8b6a656eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 03:01:20.9622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBnj1LmseiCZ2pX77njO9HK1KtxcSFEycwxQOqQD/PEcZDwf+/4UsQA7VU2esnZyRTNfG4vkOuv7I4ODKGvZvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0117
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

When using dc_allow_idle_optimizations, should it be guarded by CONFIG_DRM_AMD_DC_DCN?

Regards,
Guchun

-----Original Message-----
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com> 
Sent: Tuesday, January 12, 2021 5:03 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

[Why]
during idle optimizations we acquire the dc_lock, this lock is also acquired during gpu_reset so we end up hanging the system due to a deadlock

[How]
If we are in gpu reset:
 - disable idle optimizations and skip calls to the dc function

v2: skip idle optimizations calls

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99c7f9eb44aa..858c6ff173ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)
 
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
+
+		dc_allow_idle_optimizations(adev->dm.dc, false);
+
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false); @@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 		return -EBUSY;
 
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	mutex_lock(&dm->dc_lock);
 
 	if (enable)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
