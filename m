Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD868C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 07:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C1923123
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 07:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C1923123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506D289BB3;
	Wed, 13 Jan 2021 07:05:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58BD089BB3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 07:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB/tV1UnCadihB8VkBYThMneKzy42FeZ2f3UHBBvpsF4goLESRJeRAnXLD0vp8HTiprh09CLpnqE2N/31j+z3kEzIam/ajfI5ylEpJ/5TR/Mxf9/EpdK9EtuUbB4Lgj9aLTULdZML9IHuBPBLMvfvmMXQpwd1JaePdWKv8JpnbkF9lQxsCcH/rmekyFBNHAxE/CFZidY8Vh05BOrRfJ1eFIfCoSkENj9szQiKkZFXkIdFFXZqBQvrMIyR7iJCNkgA9bY6pnC131CiiwC67x1PcNDBChR4mqOnm9jCJEjvOEyGG936rUtcShELIwFMRlv427LJcz3X4KsckoUe2QrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+x4ImWKG54L474ebfZ2FIq9tmudBkVOHfcbdhfLloM=;
 b=BSRhMCqgcabRTcwpaIMsLXse7qfYZvCUDBLauloZFc9mqeOgGzRS/JK2+ixHR86uR6G4sna5RyoTxLiL9SaHz6y0Knw0Z+TVJ7snw5rEJXkLH154z8J03AmApcuRRu8rwcylKDurg+O+/RQw2fWAZxpEbvNucWIfq0zh6V4ylNoxFZypaF35cEsNJXSK7teqmWgQ9c+v936qgcz46oU7GdkXtJ5+Bm3xnTlbOAfoWHgTaiPmN6spBy2RhE+r1IoEOMpIfDCo51vxgkS+cZSJHMpoWM1QfU2rksx9AdUQii/b7UDo+8kCayvfn41e6TCSm3XUbsu8S77F4fHziY6MQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+x4ImWKG54L474ebfZ2FIq9tmudBkVOHfcbdhfLloM=;
 b=NNyrVHY+MrAuKRI5UehBnm4TSORbm5dgm7NQeaLEb1ozIyvCi2XtEHxBTe03Vz47e3x7uY3do+gpCToS6zWF52AbUduart4+Kin1sHogyNuOY/CjpSxvNUyJmhEhC6c6OcooDcvRS4BEYrJMvc6acJusK7MexvVTap4fxZGS+gY=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Wed, 13 Jan
 2021 07:05:46 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Wed, 13 Jan 2021
 07:05:46 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Topic: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Index: AQHW6XZ9N1P5j4AyYk2NBhFMHNW1HaolId9g
Date: Wed, 13 Jan 2021 07:05:46 +0000
Message-ID: <BY5PR12MB4115BB10E53B16ACDA6AAC208FA90@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210113063612.31468-1-Roy.Sun@amd.com>
In-Reply-To: <20210113063612.31468-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f41058ae-6778-46e4-bb1a-e7d819b03bf0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-13T07:04:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.113.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 563c7a8b-bbbf-4d83-c7ed-08d8b791a6b7
x-ms-traffictypediagnostic: BY5PR12MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41328FE6C5ACAB496ABDF1DB8FA90@BY5PR12MB4132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNV8npagekKwh68efivLki/a85ZTv4DTd6wjQQ65wOZASaOj2sNlg3Fj5hSKZV43dpQ98jAbDNP0ZvrrZaAaTKm9KlHriyTmHXeCWhWUqzFSVJwonVgakbSggkrUpc8fVt8viYuDxwZrpo/GHH9BzDSViEoqQDpUaxAa4JjTqU5ZtjjCyogdUgI+Edy5e7lEz+2ZQPPC/gz+2LN86rR7ZjDsmOcXxsfZwPnWL2nD65d6kOjtjXojFycIYiUicvqSwbNpIHJwGBtIgho3284r5V/k7blUkkPEW6Z1lGuovk2ilpv3ZuNlF8f5K7va5I0kMI6VeVDpKx0yvU4FMPNIXiwEe/LD7tR6MRS0Sp4nDCeW3jRFy7CdCyG1haWb9cesXrvYB30wb4PZgVUMrWZ7a9vdEH92IW3Ag6ysRE1qnbNAna9dZv7RfbUeuoolWpyEvie7LYUv1ACj7asfd7vpAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(66556008)(478600001)(66446008)(2906002)(110136005)(64756008)(316002)(76116006)(4326008)(45080400002)(52536014)(86362001)(66476007)(71200400001)(7696005)(55016002)(5660300002)(8676002)(8936002)(26005)(9686003)(83380400001)(186003)(6506007)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4tRcYa18HeDz3qRZ+xLa7sh8r0ybnvmR6y5iYIeftQ0nBAhP468mXNhTL+hG?=
 =?us-ascii?Q?iGd3bhHnxJiqkzqUurhvudx/6jPr/VGB8L7K/WWt8UJMBU+nsahawserDB6I?=
 =?us-ascii?Q?BJGzgGct59MQy1iqNkygyTQ/6IX8hVF72rKv2B5lOcnL8UNAZ/jbCyYFX1Em?=
 =?us-ascii?Q?bZIGxbNulc7LgRpgJuEc0/gsKz0qlk6TLwbCfLUPxQhGurgMk4DjEdUgiU+z?=
 =?us-ascii?Q?O7hSe/cGTRbPJYXgkdYYlPaUe/qZ29io1FM5+E3NbAgbFlrtvwRY/+TtbIVN?=
 =?us-ascii?Q?iPCDLy0hR87x5b5vhptOSjeVHg5WIqXbQyNUYUCMFL9smMxLjysB+NUx6OC8?=
 =?us-ascii?Q?AA0JUaPNWekhkWrk/bjs3jcG23UdJOY/q06rey8MKCCuFNVoDqmfl7XLQFI/?=
 =?us-ascii?Q?Ia1r2mjguCYfgz/0j+Fb8WMj628dXm4u4kz8zG7uWSvGY8kMOvqC1N+/vbIj?=
 =?us-ascii?Q?geluXRyQ1T03LeMmsX6Yz+FwAeTx2R6Y1syMqhHxOM6lDZq1adE+zqpTC4KO?=
 =?us-ascii?Q?xocFhS82ka5Vm7slrFlEPY+32E9U+9EdZI0W0q9spUuN90BCCuJQ9C+o1HSd?=
 =?us-ascii?Q?IgF74bKtKpeZmjiinviHXJ2iBikoWK6RlVaVEsVAeyINnHDYXLAq787PFFmy?=
 =?us-ascii?Q?3lrqPXXOSxxHbKdZjTwF9KBboRYcuC715vsRqZcWeDaNRp70famyUZMropc/?=
 =?us-ascii?Q?1nvlEiGnBwa0pyDwyGXG1S1zVs9BCNzEufq5uEJeXdOyAdlFlDN4+NSqlq1P?=
 =?us-ascii?Q?27IRoKlLpLlzMwHfuYuBgKnI7wvwAfF7xkVaHgTOQ6vVVwy6i3kCwsfP/Tkc?=
 =?us-ascii?Q?rWL5SvxSXgDFr6JxNn7ZHjcYRtTIjSO6YaW1FDQvj8vAsFmUhmixSpvsGqX9?=
 =?us-ascii?Q?10pUYKMkhYFlZ5A6lygDT8/o6hBdsae+H6a1JoAlwDGncke1nGmq6AqmLn83?=
 =?us-ascii?Q?c/CaUDkCHrfMBXvMjqT8FKiW6IG9DWhA1mx4lFcwCVo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563c7a8b-bbbf-4d83-c7ed-08d8b791a6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 07:05:46.7162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kq0DaKFIMJO/lh/UI1Z2fMR3bsC2/yoF2V9JevsOi2d3WUKeUFJhBZGbFBej36Rz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Roy
>Sun
>Sent: Wednesday, January 13, 2021 2:36 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Sun, Roy <Roy.Sun@amd.com>
>Subject: [PATCH] drm/amdgpu: change the fence ring wait timeout
>
>This fix bug where when the engine hang, the fence ring will wait without quit
>and cause kernel crash
>
>Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 48
>++++++++++++++++++++---
> 1 file changed, 43 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>index 6b0aeee61b8b..738ea65077ea 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>@@ -41,6 +41,8 @@
> #include "amdgpu.h"
> #include "amdgpu_trace.h"
>
>+#define AMDGPU_FENCE_TIMEOUT  msecs_to_jiffies(1000) #define
>+AMDGPU_FENCE_GFX_XGMI_TIMEOUT msecs_to_jiffies(2000)
Please check the format.
> /*
>  * Fences
>  * Fences mark an event in the GPUs pipeline and are used @@ -104,6
>+106,38 @@ static void amdgpu_fence_write(struct amdgpu_ring *ring, u32
>seq)
> *drv->cpu_addr = cpu_to_le32(seq);
> }
>
>+/**
>+ * amdgpu_fence_wait_timeout - get the fence wait timeout
>+ *
>+ * @ring: ring the fence is associated with
>+ *
>+ * Returns the value of the fence wait timeout.
>+ */
>+long amdgpu_fence_wait_timeout(struct amdgpu_ring *ring) {
>+long tmo_gfx, tmo_mm, tmo;
>+struct amdgpu_device *adev = ring->adev;
>+tmo_mm = tmo_gfx = AMDGPU_FENCE_TIMEOUT;
>+if (amdgpu_sriov_vf(adev)) {
>+tmo_mm = 8 * AMDGPU_FENCE_TIMEOUT;
>+}
>+if (amdgpu_sriov_runtime(adev)) {
>+tmo_gfx = 8 * AMDGPU_FENCE_TIMEOUT;
>+} else if (adev->gmc.xgmi.hive_id) {
>+tmo_gfx = AMDGPU_FENCE_GFX_XGMI_TIMEOUT;
>+}
>+if (ring->funcs->type == AMDGPU_RING_TYPE_UVD ||
>+ring->funcs->type == AMDGPU_RING_TYPE_VCE ||
>+ring->funcs->type == AMDGPU_RING_TYPE_UVD_ENC ||
>+ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC ||
>+ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
>+ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
>+tmo = tmo_mm;
>+else
>+tmo = tmo_gfx;
>+return tmo;
>+}
>+
> /**
>  * amdgpu_fence_read - read a fence value
>  *
>@@ -166,10 +200,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
>struct dma_fence **f,
> rcu_read_unlock();
>
> if (old) {
>-r = dma_fence_wait(old, false);
>+long timeout;
>+timeout = amdgpu_fence_wait_timeout(ring);
>+r = dma_fence_wait_timeout(old, false, timeout);
> dma_fence_put(old);
> if (r)
>-return r;
>+return r < 0 ? r : 0;
> }
> }
>
>@@ -343,10 +379,12 @@ int amdgpu_fence_wait_empty(struct amdgpu_ring
>*ring)
> return 0;
> }
> rcu_read_unlock();
>-
>-r = dma_fence_wait(fence, false);
>+
>+long timeout;
>+timeout = amdgpu_fence_wait_timeout(ring);
>+r = dma_fence_wait_timeout(fence, false, timeout);
> dma_fence_put(fence);
>-return r;
>+return r < 0 ? r : 0;
> }
>
> /**
>--
>2.28.0
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C2df180bf7aaa419f
>387708d8b78d9dfd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637461166168063291%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=2n3ZbLF0ZT%2FakzxlcBI3c%2F9A0F8EIzvKzDj2OPA0DmE%3D&amp;reserve
>d=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
