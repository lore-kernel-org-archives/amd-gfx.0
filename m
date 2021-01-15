Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ABC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6C923403
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C923403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D252389D52;
	Fri, 15 Jan 2021 15:01:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB0289D52
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 15:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGv8KV4LtcxGXgG84cMHghHcz3/iKn6R4b7qC5AiO9cyu+u87UT5hVBnN1M84tejUWWX39st7ufVL3TyA9ZvN0xB2vJDPybGD8h33wegWhX0F2JXwN3Uv7+eZVzH5fjUplk5YNzpC267XJKSjgAWoC5go8NueipvKV1HIfCcnNzzi2LJ9QKaSnlvkH6tgs99MZhQiTSwG9XI+tt4fWJ8yJUlonBT0KLHr86COb8hbHd9Z1H5DIMZOn6UZwOaDvhmK7vi2tEuvYx15HxDo5z+d4kccv7DUq1qyZtZz79IBfJ0UqcFjIQi9OdJKEYmjlZOyPJrm6NJlZHpRZeFvx6Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuJdPyf01sV80cIQr8AgoCrU8mVP3xXM0GQ9Sgvhqc8=;
 b=RC8mxRyvLT81dllRBqTJdDOHsiCNDbhZMXTTglddMiA6C7CrcTveubOiddknPB7d4HaBvvogvWFUKtE1QJ2KzagSgkXEJGlyt1yJ8XzzxtqMqajeUszyLQ4oj/Wuwrm5bRJm6UMeqHqKweta+Cd9OfDg4IuLheJziGH4N+arzWjzBrgAeu/C70dB/NpF/xxRzZ35d0dUqmPRZFEIWHO8pXKuvkasLxMzjfkgm38JeAIbr/A0aF3jUjyjrlmp5vuFn7qGM0pLDN/et80W7NoYOudJ3r8yvuW4nALfg6aKioRCsgPPuRYZHmJmcuvNFUVD4OybVdLsXY4ZUtqSPigsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuJdPyf01sV80cIQr8AgoCrU8mVP3xXM0GQ9Sgvhqc8=;
 b=JGxN2659/xhd/dloRiZ1IRqVBcMRsPoyCiT04B3EfrXYuKo61WOPs/34NDA/59Dd1Dnu6N85YTWZCEe+BL68C7AJ9dJ5Pht+nFFLShbfJH6Ar84lngsPdCV+0kNOuzlTYbBQmmzjl2QjFFR+qoQXyyVaHkHp1qtjlhRi3TpQUqU=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 15:01:13 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 15:01:13 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Index: AQHW6yGmvP0XSqoS5kKa7GbMqKXoS6oowlBQ
Date: Fri, 15 Jan 2021 15:01:13 +0000
Message-ID: <BY5PR12MB4885E2F10BADE35CE3B0FA39EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210115093406.389563-1-evan.quan@amd.com>
In-Reply-To: <20210115093406.389563-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7c310fcf-a3e9-4e89-bbb8-c090dd58d7c4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T14:40:32Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.195.14.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfbbc944-8b43-4278-5ecb-08d8b96666fc
x-ms-traffictypediagnostic: BY5PR12MB4306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB43062F259298E2E2B02A65D2EAA70@BY5PR12MB4306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfdzBd4JuPPdQDbEUswGVcbJwMqo8ZSKh48uzk06YJW4NA+dF3coYoJnNEM9seFL75qZos/vnqZbGQzXLUzJqVynOd6wqQKCRD2v2bfon5iwWt5KdTho+go/2hYCVSJBX7KLX2QDdK3JH+LkEVsaCjMCi2V9u+0gBPt5FKDBqVn2IJwi8/Dz1Boo+ZbYpafUzTpKspoyIUBNNmoob97KNMqQwEJkUrMeWpYbpL9DI/2wQIUKqSUM8TdQIsiCo6TwiX3gjwVNGDAjpDgwSgL4/ZGOFi+63cK6uCEvWov/IDLcmIRDeAuNHLulHewFlcvU8Yrf9mNG5yHIQiFpWf0OgsaMRYBz0wHJNe8gY/2uQTNr3JUzfVZW1ZZk3vds/Nh5e85qWZt6VJOLnIikzSQkkkDHAjNwdq/VV3djrBjbZ6imGdnbWJj67I5jsORn8cZ2rrsmZQi5g5KZN5DPob3b/QslXHhatvvXDx+Ff8COGYMNn2LDovRLOA5Y3URgUHBt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(55016002)(9686003)(45080400002)(478600001)(26005)(52536014)(966005)(66556008)(83380400001)(66446008)(86362001)(8676002)(110136005)(71200400001)(7696005)(5660300002)(64756008)(186003)(66946007)(66476007)(54906003)(2906002)(6506007)(8936002)(53546011)(76116006)(33656002)(316002)(4326008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ns1glhkNUoxlYdQyHiabQ82wYf2zLzSEIoqJmdKkVOYeo2Ntky1p2R5DN1VX?=
 =?us-ascii?Q?k4qiw/UCwfdQAfV+WVki1D6+1XQpW98c43sNO2J3nzLQkTUduRZWOsreCi8X?=
 =?us-ascii?Q?5V4O7dT+ruocQAugHO0hbdlBKGkfJjT/UqFsX0VRD0ijp0LZI3TfsoHBu2c7?=
 =?us-ascii?Q?BopuZo2T9DgBTtM+xvdVJp8PI7yHrTt9U2LM+Iv9uVRh0ZtkQbu0uCAYCK2o?=
 =?us-ascii?Q?SQ5KgmVqM2tR/qquQ5yjbUNIma8ktYLPN5BoCsuly7BEiBI+VD/BWJj4DJdH?=
 =?us-ascii?Q?my4yWJwqrNLf1utJGMlR3wmtfrUK5X+3sZE5LvFg5AnVX1AmUVSNyN5qq27Y?=
 =?us-ascii?Q?LaaWMbyFzEUwt57ZuBPRb+Z1gOahIw8C1YqxxCh3mMSx4tQUexGi4wWv81gU?=
 =?us-ascii?Q?xwTX/2GpwQQzGPQK/o9Rkfq3/J4E8GuOozUAP/T9VUN6nMZnYzS/J9qciOeJ?=
 =?us-ascii?Q?iKt45Wwuwa0jljqrarrwhAmjgDBFSoQo7nJpgHRDak4DZLdITz7COD2AqZUi?=
 =?us-ascii?Q?mM5nAmureJkXry4QSl8NeOQAJRftfqQxZ6ITIbjoxg3nV4IVc5PJYkBTuRuX?=
 =?us-ascii?Q?ew+D0hXdOJaysqFNPJb80e7tyERc6yuT4F7ej44Xv/mBZ2oRCgeLODMMOP7P?=
 =?us-ascii?Q?1+vASqoxMYvqptgnEbqm+C7N9FaNPLb+Zu8zP/jDr5mi5/g7FoY8aaONILjT?=
 =?us-ascii?Q?tRmG7Amb4XZ/FlakX6FI0t7LomJ+thgPSD8saxkLTW4K2HUNtEPrUBdKHQ6W?=
 =?us-ascii?Q?TLE8mipbCsLlv7sRikImaU9a22c+5h08NDvZYdSoC/dTsPTIwT3k0PGNYfXo?=
 =?us-ascii?Q?gIXA2IKIa7Dxi6Ta0BhS6d4whyrVlAHx2lWpTjwPniKk6xgVNZcepS86Vshi?=
 =?us-ascii?Q?qU08vx8cPFZ61I+Hwar6wzm3Rt61O0579W6yMfqA6UZ95ZBDpzrDTZRQJiE2?=
 =?us-ascii?Q?frbV8DCr1lxBqOC+6uDUSZHh6SPuSj8It60uG8sCpTQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbbc944-8b43-4278-5ecb-08d8b96666fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 15:01:13.7627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqiZhOgm0bP6tdjpOQVXXxixKsEcQjf5nsDyjoGgjDvJ5budfAHEgppaFwr8a8BIR+dGAuIoLNA3JBuAmFvPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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

Can you help explain why we need introduce such a callback?  Seems it has presupposed pmfw's internal
Implementation.

Regards,
Jiansong
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
+.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
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
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+struct amdgpu_device *adev = smu->adev;
+uint32_t gfxOff_Status = 0;
+uint32_t reg;
+
+reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+gfxOff_Status = reg & 0x3;
+
+return gfxOff_Status;
+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C72d2ceab33474d94460908d8b938c75a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463000820920597%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3WeEJ8EjgUYyA%2FAF7r30%2BOCEPNkfLwsPWuFhEIfRkU0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
