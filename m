Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69834C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 09:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3207E61DC5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 09:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3207E61DC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF5389FED;
	Tue, 29 Jun 2021 09:26:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDF889FED
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 09:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFTQlkZV3kPjpv8itt9X9wtru5x8+gtI5luiOk7XyJ8MnTCbwHq/kpwoVILy9UReQWr2eWcVc1dNL/9TfkOapzdCiWSkWcGABtZvnp3gVuwVFx001KSAw5jtJ2ZccRe6W5gxmZUW/ZD3Z8r2EGnvsQ2dx5i8pkEIZdO3FOLLH0txtxtRdgKb6toV2vJLCzTBVUMIC2NqBOedP8t3IbX60c2DG4cHo0i2VVpVZ7RPgEvw2I/lVvWx6RLHxJuk0uDqb6tfynw4KnxRP9hIbdBdU6df4j8PKekrpccKPZSaADuE/Fu2AM99KyfIbGg+bhadCnyG76Po7jFfMHeNsj3B8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwlH+2rWc5R4W+k4U1NGNAuKdDjsj4yIEiy5XQ8SVpE=;
 b=YFXKUksV48eaYdxFn0ClYqBpr0KYfqKO2W5fF5XgSRTj+90B4dALL1HqGLBYLKFdZCMBUMsKrbhKcMYrWRyHBL9x6jRaTI4it1fB8ltcInRWTI6DVnqUaupiBL7ph2jMSFu/uRoOXoUSkCrW4oOr685tYIRb0ClPqNWDR5hHSFAi6cfnnTBg6eOFsGJ3A3Rz6F5kO3HCeO17vEYHtjsRDFFSUV1swYDHRO35EBEIPxuqInjtoq5x8jbYJePcPMaPDO/9t3fB3r7Dx5WCvVtWqmu+0++XHssIlKtlPaXbw3Q8FLRGSfFfYlgRDW1v4C/pTFlydryuz2h5kHR4qV3Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwlH+2rWc5R4W+k4U1NGNAuKdDjsj4yIEiy5XQ8SVpE=;
 b=k+6MwqltLW31NANRHrrTuFKB0qRZdFLZPhaviQpKCuLBLuHywc34F9W8XjSQEnivAiOPk9LEkjSghbwyIPMqUzdsi+O+Q5vZZFTd9mqBzBpyiI0xfn6Xz3ZAIdO9bHK38nnc+ljO/uVLVdLM+bjSZ9XRGf9WMzhe2ZL2sIMs61w=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 09:26:31 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::91e1:964d:ce28:294e]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::91e1:964d:ce28:294e%7]) with mapi id 15.20.4242.029; Tue, 29 Jun 2021
 09:26:30 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation
Thread-Topic: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation
Thread-Index: AQHXbHOKJAG/mmkbiE+2ISOh94lRC6squJXA
Date: Tue, 29 Jun 2021 09:26:30 +0000
Message-ID: <DM6PR12MB4603862A0F1A8F939DE1FF72FE029@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ae074494-e2d5-487b-a991-1d479713b4ef;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T09:25:47Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76b6a72-9736-4a8a-3f8a-08d93adffacc
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1163BA47733498701878BEE8FE029@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/WOdqrrMi61fSj7xK+nRZfbH8kWDWJSPA1IMzkNCukVDZpJC0xsHFTBhUtFDM6PEgr29KKwIQ5SKsttDuFHA9ZRvfbU3/cZWgl/Lo5USAXZitjBwgk7l+k7b7c9mrQPRQTAYgOIeuF08oAWmM9N9A3bmwzUxL8Vq6i7frdvCLkrO9sJ8zzqUpb6E+iiCFLb6gvk6AH4EN0MMz52B34CpEn9INPFuijTng8gLAWU0zLCcO/sFDKioIoSMKl1cGY7CT07D5zUX517GF9UU8s8+StT7lhybPRN1TkFt9usBx+37N6Up4oyd3WWA/KtHjbIksXSSpYLMs/z3ysSpMKOh0mvg3kogQfS6sGCFfJDrnJ1vHc0ck780JKgcuX1xwOajDFa2+bykoIuRR7f453oN2FgHctNXOMQ7U6lC7aXIjRMtVbhctYAzQmyjCiL3EUuReBAb9MXIGRLVc0Ci/rAWPwtSgcDUkMwOwD5iXAc2HHVKVMRKwq7BzUnJkyir04avO5vU88GgLRhKc1QKnfuEkFtJpTk9jTYrcgwwPX6n6JFIle1agWYj7dPLCnQpm+Z70BD0ZEWFCXj/VHhu5x0udvPqmt1SkyRuNc+cDPvnGKenDOpOVgkviRCklt0Grp2YedTcvQMUxVCz536XYIRRaOiHQu8SA7B2r+jobpQHcEhlaDXW2w6DJOQhnYYSk+6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(54906003)(86362001)(110136005)(9686003)(316002)(66476007)(64756008)(66556008)(55016002)(52536014)(4326008)(5660300002)(66446008)(76116006)(66946007)(478600001)(71200400001)(122000001)(186003)(2906002)(33656002)(8676002)(8936002)(83380400001)(966005)(53546011)(6506007)(38100700002)(7696005)(45080400002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EP7d9w5uUqBTREcjU7p5kYKb90bpz0My/qQu+L6JzgL9t6auKuEKzinJCUeN?=
 =?us-ascii?Q?BTdEeIir1E9XHLvDyq0u3HRigAe6Mx6Xse2SmwpNvKElQGIC7oO6KL7937N8?=
 =?us-ascii?Q?6keF50vCHxpTz75q6vSMWsLyEng1DZwf6ZZ3KJp9f9qPdgtJuVeODxTd5jkg?=
 =?us-ascii?Q?WHk3tCPAJOe0US0B39yEIvRaa8XPIzx0Zb0PsSQd7t+H9QvFOnM58HjJTNQb?=
 =?us-ascii?Q?xp+KVcI8j4PpWHlLHAO5itWQ67QJaXZ7uRuRG+QUAj1VTUwARDVaTH8OoN5C?=
 =?us-ascii?Q?3pJ19uEcBuXJFiHNj89mibt0t/v15a3K8ipTMI66hNKP3f6R8sPVQa1iDu3d?=
 =?us-ascii?Q?3gaFuXJAQws5IMW2QC9BmZ4lvLPqy4+Wsg79rhZIGVXXM9+FjTJwz0+pfzV+?=
 =?us-ascii?Q?2KnzJoqD735zazL39V3j5u+36fqKtEeCQb0zEGtCqJ2xhc7wVagbFovO/xbo?=
 =?us-ascii?Q?l8ykPdYTagnQkus3xAZIFzzQLHILVDQFeun6sH+UwyJ+NU2BgbllPhXh20GH?=
 =?us-ascii?Q?9GXRJYGERgObxhUCbc9AyduN8nzyYMHLJ8CBQKX0DJcZCMcAiFxZSOIihN6O?=
 =?us-ascii?Q?xYNDZ+0H9wA7qfRkxitmTAXGIBfdY/gCymOWidCTORe0RP1oHcPcI26WU4kE?=
 =?us-ascii?Q?csnE+xf4IV7ghmbZwP4N0bfeaHJ4+6MAik5AtK0aFLBTohxsqNZ3GrJCB5zD?=
 =?us-ascii?Q?mtesL0my3qyxz0UBUnmSxMrQ3Nz2FwrczzDmjUGZsGGrUL4N96XMQsa5jmeP?=
 =?us-ascii?Q?MWjnvhWSulrvhwFU8y+iqspjn+F0D6b/f9XrCaUhEzoQE9OC6PG+Os5yNmGS?=
 =?us-ascii?Q?WPFdwXq8a6tq8adhIJhNyLgdsRwWDVdeXBvX3QwHpBqJbF/+P8t9arfahfPy?=
 =?us-ascii?Q?W4lkWEdbsIghWEmeUDWZNjBjHHoehazQi1Ri7JoW2HvY4MQuopYBmxjby+a7?=
 =?us-ascii?Q?CFRhF9rx8M8P7gqeiIcudk4njmLwM9pxWZNmw7ljhvO7GGMVahfyg7Wf5VXx?=
 =?us-ascii?Q?1I2w71BmThA8lULOcKvJqmQpEE4Es494BCW4raXyX4MubYDCv7AHDT4K/VEx?=
 =?us-ascii?Q?s+P+C4Mn9e6ZKjpR74yLjkvBC15LSDRQ1eqCEssuRDxcd3P5I2cauj7nkpoC?=
 =?us-ascii?Q?KCzhXe5XeUlLdwH4uk/FReOIJp5WV4BOhCb2gE5488mAUmSSTZYdTLm9Rsob?=
 =?us-ascii?Q?fiz6SB4hKVjTZhit9KzSv+PcAH3f275ahF9MDwqsz/eyoRiu/LqYPiGcl0jJ?=
 =?us-ascii?Q?KRyw/al+jaK2KLb+0K+UIkhPlBeYDg5+gVTS7F83ecueeFLcRDzhdOC7+Igw?=
 =?us-ascii?Q?X7bK6PIyjSHKvsXoobrzMWwu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b6a72-9736-4a8a-3f8a-08d93adffacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 09:26:30.8414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4xqRplxMbYugvLVPIo5lilztiFvgk3ubNrz4Nl+W+PKxT10B/S3+BXKWqeA4wn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Oak Zeng
Sent: Tuesday, June 29, 2021 7:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, James <James.Zhu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>
Subject: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation

The ttm caching flags (ttm_cached, ttm_write_combined etc) are used to determine a buffer object's mapping attributes in both CPU page table and GPU page table (when that buffer is also accessed by GPU). Currently the ttm caching flags are set in function amdgpu_ttm_io_mem_reserve which is called during DRM_AMDGPU_GEM_MMAP ioctl. This has a problem since the GPU mapping of the buffer object (ioctl DRM_AMDGPU_GEM_VA) can happen earlier than the mmap time, thus the GPU page table update code can't pick up the right ttm caching flags to decide the right GPU page table attributes.

This patch moves the ttm caching flags setting to function amdgpu_vram_mgr_new - this function is called during the first step of a buffer object create (eg, DRM_AMDGPU_GEM_CREATE) so the later both CPU and GPU mapping function calls will pick up this flag for CPU/GPU page table set up.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6297363..93acf6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -607,10 +607,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,

                mem->bus.offset += adev->gmc.aper_base;
                mem->bus.is_iomem = true;
-               if (adev->gmc.xgmi.connected_to_cpu)
-                       mem->bus.caching = ttm_cached;
-               else
-                       mem->bus.caching = ttm_write_combined;
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index a52e17e..6cb66eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -454,6 +454,11 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
        if (i == 1)
                mem->placement |= TTM_PL_FLAG_CONTIGUOUS;

+       if (adev->gmc.xgmi.connected_to_cpu)
+               mem->bus.caching = ttm_cached;
+       else
+               mem->bus.caching = ttm_write_combined;
+
        atomic64_add(vis_usage, &mgr->vis_usage);
        mem->mm_node = nodes;
        return 0;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFeifei.Xu%40amd.com%7Caef2cb54c9a4489626e808d93a8aab8c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637605189533617890%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Pzl%2FSSuBHjSUjBFQVffr3UneV8hzrVb2cmN8cSnifaA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
