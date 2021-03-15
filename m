Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE55C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 07:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF21E64E49
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 07:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF21E64E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E5289C6E;
	Mon, 15 Mar 2021 07:11:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1628289C6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 07:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mObdvgW4vVjFUde7AGAmox4PlDWEJ6JIZeOFnM7tuY7X5QY0tDjFSoc0PB86FC5hc7q+vQ7dASSVdg4q1NhUOsRecw07XlA/70daoZxkBKE7Jr/IrsZledRlpxCWb+O74OanUzEV0k2U4cidyEByZjPSR0H6ZgsIItyOb7+6hqGgOu45Y84UtfGYs8r/lfe3XU5dGHRKdepl2BroUJlmWKt8N1IC5GySCPfmq6aydZFsrwWBg11qwmqPfLoofDfGgu7wTPGgK9g+ZhIOgbv+ef3ixNHFmN+JL8kNVkMv7LY4hY+opgKwJ6vPCTi6YlZsW6W8lgeFusJauOsCvoiDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktJ9WP1PVJUQccxIGV1ZO7OXwDTl4d61xlM91KF2zGE=;
 b=YdPbHfarj9O99FnwEsdwO1rA0vPEdAORhcpoNEOXQSqSu8ojGyH5gHKS7+phNKFnIPH18J9ZsEQG6wMN7zboiiRg1dR40US0nsZwYIWjFkMa77xfGvjgPqES01aFyq/mSRFQ8fmRZlH7YkLjKjnPhPPFo1xlrQoRs9vEzFtUUB/K3cpJ51zdiHqYjOoifG32sxCAnIGkyjsh4e6FIji0uN7jqSWhaZlIA4gTzooKxYNCfHwyABrlkNt1DhHsPuCg/cWjjqGwtV9DwJhc7X11n2sjqFr2DBYuhnqvCdz8SaJrBf5C8QpzpQDCzl3d68vVZG8YoN/zXZ2gYFbbeMHscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktJ9WP1PVJUQccxIGV1ZO7OXwDTl4d61xlM91KF2zGE=;
 b=iY2ZOP6ybFZDdNpjd+tDK8laa5JOSbWCxjumS2bVBs8fexl03L3yejGdWjF4aqfYPLMdaH6U+cECZmFR7cWkbPSLQwH0bOgVoHXs9Wm0G/9BwESe9NfHuNDHMk+ejxwoBdr7kJR6UixrpwLiu8/mYsDu/tWROpjVBFAN1d2TtsI=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:11:27 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:11:27 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Topic: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Index: AQHXGWbW4oPL2DTD4EWhsdjDotTQAqqEob/A
Date: Mon, 15 Mar 2021 07:11:27 +0000
Message-ID: <DM6PR12MB460380E2364B359753ED5D00FE6C9@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210315064541.4620-1-Feifei.Xu@amd.com>
In-Reply-To: <20210315064541.4620-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=73d778f4-8525-478c-816b-42beeb22ef1b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-15T07:10:27Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfed9fd2-cb07-4dbd-5ff2-08d8e7818cf2
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB438554332D424179D127713EFE6C9@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTuObm5C+5zdiu4baK75drxrMgZHMNvFV7jKFKiDcYVF4Kdxw1BO1oM+jAqO3FzV5uikOoDm+wztGQIUY6+gaZGCwqi3WJzkv2fYxFqwxdSnHmXmCe/wVujCHy4Qjp155e3sfu8rRO1rlU9zntXCzS2wTtgi3FYNuiuPzrySz5NEJCRMExU84TlR8BOvAQRUDXYB8rHqpGTb9oUxOQYbRMiY0GrkE80LcPmgGGL4UyjE94M7O8LVi8DpMqxIip6m3VSfZP6UFv9QXKyBmiCKrBc8zPQUGiD1X2AEef4q9uHTirB8Bf9leViOCaHvkO9gfiWvLmRS9gYgf2RkBhsj42qQHuDgVUQrBhBT2oPK7+Tqo2aRQIqYvrVDzV0P7LSQ5IHeTh1cFM6ZdYWHaWCnG/Pp08qll19Z0fdZSYjZ2gJUkS5oHWJ06HMdbl08L97j1cqwLFgjK4fLLnfb7nyFlTW0nmiMGXg+jKUD3X8Is51qHkqNmUknaywRpiLV/5gnyl/OtMHZQ+8ucXv5QnY0PlYMbudYE2G2J7pHotnHXNhrvrI7ka+4GtyvAIQOYmVC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(66476007)(66556008)(64756008)(186003)(66446008)(76116006)(86362001)(66946007)(26005)(33656002)(52536014)(2906002)(478600001)(5660300002)(7696005)(9686003)(55016002)(8676002)(6506007)(54906003)(71200400001)(83380400001)(4326008)(316002)(110136005)(53546011)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jlsNTt2PxrhkXEMUjqn32EaeJc0EOBUJMoH+2LRPexcFIjPN9nJq4MvhQHpX?=
 =?us-ascii?Q?+r5N7WYZp5jsNKFzwVDtRNrQn7GnqnnEuHSRVfXHUm0YKrVGg/rgUWYguF9U?=
 =?us-ascii?Q?315999LMyQJO+xoBN2l6M48Z8849cgzRAwnm43Z/ws/e0lMyz4/yhqv54jZv?=
 =?us-ascii?Q?9W6lo0SO0A9USly/L/jAy0psjL3+d7UgtlZo8mXnFqes2L6MHg1QhCPd3unl?=
 =?us-ascii?Q?d7WAjmFtIKjai3raL3S46zsFMeLqUBukIJ67eBf9SuFy1fR2NsnyivzxhMLG?=
 =?us-ascii?Q?g9V3dWBB64gRCYSfzoAqEcKKL5s8o3SKDMXa6JTi6YGKfm0DJZF+zJUcIx40?=
 =?us-ascii?Q?m+GBze+S7/v2jTc8CXvZ0sLwP78cUZWdX+0brTZw4olSI+t3sCABHDlsdBGR?=
 =?us-ascii?Q?ACWSPcAIYfzesdUAI+EqJtk62CoNPYUnnl/NB2rNPRLWZx8/eijdceWwbv5P?=
 =?us-ascii?Q?lGf7lEAHeH0CfSpth9ADY192+5ySYMh7XnNBuD4kwr1h/ucGBjHPmTim/hBS?=
 =?us-ascii?Q?ztDyqVWf5UooWknyN3Ogi2dH17fXYp5bH0E5T0fIQQmApsJT3UCsGVNVC4le?=
 =?us-ascii?Q?2yVh0Xuy+J5AXI6+5FEtU+MhaP17rmLLMxL44+RovaD4QzHGfhovIMQGyPui?=
 =?us-ascii?Q?AFvfizQVFkRMwcNmj1nh3BsBFmXvalvKv6pAZPIwedOJXKoSyZJ2gx0Of+qC?=
 =?us-ascii?Q?nXAKXz2s0ITX2EbJGWybZX9C8M0SmOnJDiwW9n5UsimR1ZQ0cnxrhKmdMTGN?=
 =?us-ascii?Q?6SyzgwxHyLDTB1moXXES7VtbZZ1Y/Ixy+DOpLbk6kr6lraLJsywAxx3u/WoX?=
 =?us-ascii?Q?AjpPZp2bqWvwJvhrqUVHmkSyfgYreUXAYuWKNMsPVHtn3tJ3eKpbdfquHHQu?=
 =?us-ascii?Q?u4HtYdMEbbptsUZIv5spiVpPDoph57GLR9rneYwqED2MJ/Qxad6MhHvGs28Z?=
 =?us-ascii?Q?52GS6GXqHKsy1yu2ArHYPXyLAmQBLCZhcVBaeSY6XDChhihYAKVdbTKcJXch?=
 =?us-ascii?Q?GpeGqwruxaUXStr4rT3h4F7DuNGguvb3uY5Rgl6n8lVYA6XGl0FyXI0Lo3vm?=
 =?us-ascii?Q?goHx/1c8UiECFhuky9zlknyfPrSGMtDDK993aPzKud8XVdgCsoapy/Qe/R+j?=
 =?us-ascii?Q?WJnLOAYU+sjyz7OMieXgQLTrgxWCg+tIbdfsAk6UdQRShttH6k1LAZF9WER0?=
 =?us-ascii?Q?z6GvgX0JiKrdA8Fh3+LRXPcspEkWi2kSBAJsgz8uevq0xowlRq/wF4mdiEmD?=
 =?us-ascii?Q?j9y5fPmimiSfhJklx6wn29x/Y8oCzPJ/iJ1EfGfpwNSRR1upr2nonCrWm8jk?=
 =?us-ascii?Q?fMZA/bp4TEopeqOCRU3FytnO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed9fd2-cb07-4dbd-5ff2-08d8e7818cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:11:27.3547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rO0ESYM/SdNQCHdTDkfpO5dsVTX4hwE38JDxNmM+xpRUGhEOpTM2N+FdC97EWce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sorry, please ignore this one. I will draft a V2 to remove this one:
if (!adev->bios) {
-DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Monday, March 15, 2021 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

Some ASICs has no GOP driver to copy vbios image to VFCT table.
In this case, it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..dde27b26a735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)

 adev->bios = kmalloc(size, GFP_KERNEL);
 if (!adev->bios) {
-DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;
 }

@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 return false;
 tbl_size = hdr->length;
 if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short #1),skipping\n");
 return false;
 }

@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

 offset += sizeof(VFCT_IMAGE_HEADER);
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image header truncated\n");
+DRM_INFO("ACPI VFCT image header truncated,skipping\n");
 return false;
 }

 offset += vhdr->ImageLength;
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image truncated\n");
+DRM_INFO("ACPI VFCT image truncated,skipping\n");
 return false;
 }

@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 }
 }

-DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short #2),skipping\n");
 return false;
 }
 #else
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
