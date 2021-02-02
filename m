Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD62464ECB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD62464ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F3E6E83D;
	Tue,  2 Feb 2021 02:22:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3C16E83D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 02:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4JR5nvwgKBLiffsukmK6eE6IjFFFllB+A5r8gPsVa6knTk9vLL2RES7CEWagsXkk79DvEK5cQzXIUa1Jh9Easrdhrn1p594/GcnzW9nEqEJXEWQ1sWfvfLyPylrBQOWHBIS1NhRTh5vFfIornXL7yIKKOuphWC4zEjHoAUgSso3DfsFXBwXwV/9D5ji4RTb5gjqelSZ3eMifHk6piGvePXw1uNcWSnTiL0cIkt6DEQ1jWa8AL7hvMZ8RGUyll9JGMXX8okXNTFPUfVLlORDMM7JEzDkrObXQROAu1o7P+SMbpP5axQDzs99Uve8QacaevAFsDjMS9UNtj7QM+WRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0XuPzzOGP/2adqSI6R2Q0+7ZyPdYWM1U/C8dyx4/lc=;
 b=BVP39KO70nw2hiaEoxtwNVxo+t/b7JoUh9xkkfDOaL+hvw6COny9WqUuekDp5mWi8/VASLwXy/Kv4cRnhuiznXredrUclFti8KqFAKIGdGlGEflexGDLWGLSnTp34GYD/ElmvVtVzJWBhG9w+cGZVvR1k0wsRGmLkXsV0irbcaO0SHvwstQxMfKU7T243401OXxb3JZ8XD8aVC9THQ6OAGQWawcG/muJxNDyr43puNp5P/oNHUT8XxakvALkr74MjRlYsL5aoSrObUT8oiiAX0sueJRNOmFb37KHk4Iq9Kh/NTLlmAjB/AvKqegFNxzuu7y/Giu1hyC6qsnY3uwLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0XuPzzOGP/2adqSI6R2Q0+7ZyPdYWM1U/C8dyx4/lc=;
 b=Bgb8ofjTJqnwCMYw4Rb6BegG0im3ozeeantZgKNyxjWqlug7YjS+5H9CXNiOmRD0NoKKDNy0I9M85m3tFsHh8nUMzfFYDjC8CVb/FAl10vcYXSkQgkPZruTc04fAU6ud7XoTszXhclR2tQDtOVjZltO2Gdfl5btV4az0WOHNd0w=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Tue, 2 Feb
 2021 02:22:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::992b:4e6b:afe3:ff25%2]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 02:22:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying video
 caps (v3)
Thread-Topic: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying
 video caps (v3)
Thread-Index: AQHW+Lsq6qyBvJnqyke2S6Av83vBt6pEIt8A
Date: Tue, 2 Feb 2021 02:22:44 +0000
Message-ID: <CY4PR12MB12874953BA63D6CB662687D4F1B59@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210201165605.465228-1-alexander.deucher@amd.com>
 <20210201165605.465228-3-alexander.deucher@amd.com>
In-Reply-To: <20210201165605.465228-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-02T02:22:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f4db52a3-5aca-427e-ba2e-835398d91e0e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feabdbf3-fd5e-4c8d-4f98-08d8c7216cbd
x-ms-traffictypediagnostic: CY4PR12MB1909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB190901F177829A9349E17B20F1B59@CY4PR12MB1909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vexZSl5HgST2KQoD42RngyolvxaVmO1EmrV3NZIFd3g34wbJV+dQJOQNFLNZX7tB94ls6d8oZ1hVPdWNdvChHi7kT+NdWdrzxIiOLKXXGBWXdGTrk90By18PiUV6518PUHrz8OLIbi4VrCgDQKrvk1sEV9uK/lRTzt77poujZS1F2w28qsRYMktnnNjzghMp4idWWljgeX+PrJFZ8NEVh9HQ8iJAaHFsX9iGwIoQkkJOBDYdN1gZVgXACQawOYUCubY5yfgGNzpZSzLTVb+HDi69U7a1e8SZxEyNSITtbBClVmfC0/d3mWCdEhSsMpKZNe0Ae7zf4rQDQ8bf4ntUqgEnlb1x+4o2cAkhrb5gMhtco0ndflde5izvw/wUVzj9+k9/4+v2FDqriErtv/5k+XCxMetFFJ5WopviAOlOCrTB7JiFT4yjL0I3lsqRBTJAX6pCDbYTvHFCi3bFedx+zDjW1I/XLFpPINgoC0RET4P1iI4EadiyQmQIF5E9q+N18abOvImTOwqHHKxAPfZg4I1Uc1dHyNi0F8WprO/cT+CT9bCXkcf/yGFxkBA+nlgt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(45080400002)(76116006)(8676002)(64756008)(66446008)(66556008)(66476007)(5660300002)(316002)(66946007)(53546011)(33656002)(7696005)(86362001)(83380400001)(4326008)(52536014)(9686003)(71200400001)(6506007)(26005)(54906003)(478600001)(186003)(8936002)(2906002)(110136005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1LDyNLKlX5eb2KUdrvt5b2Q6daq1PXkr4viPPD9ZWd9I05HmNdJNNu+HTF7B?=
 =?us-ascii?Q?7JJBfdNRFBTJ2fmBcwdgGapSwnwzRyWGYP3A9aL4XVaxEr+BX8dLSIYIjAaC?=
 =?us-ascii?Q?kJzqfp8A/Lspf5rlCxgQywJWbHaYhzCXBtVNO05Bd745Ne6xHNMVQjlKLLVz?=
 =?us-ascii?Q?zD8ULIhfEW/NHgYlspRcnnGrChp1aQkueuTIP0WbPlKW4xhXLRZ3tYt4fS8B?=
 =?us-ascii?Q?Y4eV8ExDWCTU1km5P37eGRwuPZ+2lIY8/dgT7mR6H7LBE8kuCbZiDYmtIvzb?=
 =?us-ascii?Q?Afsh/wVsj9bQ5c07TREMbyb5FgDgMoHmkBot98VyIcD49bjiBscxGNVukSuX?=
 =?us-ascii?Q?5J/eL5SeoYE5BSR0BQ5viMCPfV0R03/YWQ+VYly6BdhM6TGLX4yl7puoJrvK?=
 =?us-ascii?Q?3Z5AeXt3jTvAMEN/O9r35mrtYDTzYydUKJXffGtdLztI1aoH1a9nWaKf5z7I?=
 =?us-ascii?Q?6EJEoGQ6K2yngOe6vFGG6Bk1cdrtrgpfpOGHiS+Kx16NifO8MSBxhKrlpHKg?=
 =?us-ascii?Q?kLRtQ86SQGUt3J5h856VmXtEkYIHwPPgk8aADuGAHbd/j02X9B+U+bdEk5MA?=
 =?us-ascii?Q?nWl5KeolHgmYCjyk9KHoxn2IFM46p1T6cOx8pj4JxQeEvFnOBD91U4oYQ+o3?=
 =?us-ascii?Q?SzRWlRDelb8IZFIyg2EHHCUefFUDrWBXQlE2qPv1gN7ZxBLrfj30evO6Nq3m?=
 =?us-ascii?Q?DCuJsX2Lr/8Fesjeae+MJP8pNOrEFi9k/+pnQLaNNvuqvPfTKwO7IgAb9DKQ?=
 =?us-ascii?Q?0YEOIS39jwOF+J10tbYqQ1YzBxAliWkf6P4hVdfkl6CQGspifL+7JrmVQlHK?=
 =?us-ascii?Q?GIaCd3Wb3ode8/m7wEHgGNdTD7wzOmZh0avVj7JcF3YHrU3xLeU0htb5WjvL?=
 =?us-ascii?Q?irQ5RB+1hcXvJMNUpTuhNadBVizWtxXscTET75PX3fiIRMjyAYLJyo84ycSa?=
 =?us-ascii?Q?avwVNg9RTslA9HBAjBtznMjykEwOvsudKBZNfdw47CE1ClCk2LxucDvm/MTC?=
 =?us-ascii?Q?dEZ/AX75v2qptP3nFT7jFAqQcxP9M3buIjLcWZQigmK2a/2betyyKMpRNzza?=
 =?us-ascii?Q?JOxcVcfw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feabdbf3-fd5e-4c8d-4f98-08d8c7216cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 02:22:44.4199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUVHSr6b6JrjYkG8nZEKbjfhhUmzuA7RUpnEzgK0RGFl4vS9LsFIYHDzDOqthfeyxwuEhXKFCBy2iAeYN4ICgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+		case AMDGPU_INFO_VIDEO_CAPS_ENCODE:
+			r = amdgpu_asic_query_video_codecs(adev, true, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+			break;

One duplicated 'break' here.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, February 2, 2021 12:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying video caps (v3)

We currently hardcode these in mesa, but querying them from the kernel makes more sense since there may be board specific limitations that the kernel driver is better suited to determining.

Userpace patches that use this interface:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fleoliu%2Fdrm%2F-%2Fcommits%2Finfo_video_caps&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cd6c0951db7304c035c2508d8c6d24c47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637477953819079552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=cypiYoi86eR9VhTBhtwqNu%2BAAgTPFb%2FJuqzwpblzT0s%3D&amp;reserved=0
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fleoliu%2Fmesa%2F-%2Fcommits%2Finfo_video_caps&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cd6c0951db7304c035c2508d8c6d24c47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637477953819089548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PPsnvjzuh6aZKZxsZ8fADo9RWMY8WN3QxZxiiAazoS4%3D&amp;reserved=0

v2: reorder the codecs to better align with mesa
v3: add max_pixels_per_frame to handle the portrait case, squash in
    memory leak fix

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 58 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3c37cf1ae8b7..390362beda0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -983,6 +983,64 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				min_t(u64, size, sizeof(ras_mask))) ?
 			-EFAULT : 0;
 	}
+	case AMDGPU_INFO_VIDEO_CAPS: {
+		const struct amdgpu_video_codecs *codecs;
+		struct drm_amdgpu_info_video_caps *caps;
+		int r;
+
+		switch (info->video_cap.type) {
+		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
+			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+		case AMDGPU_INFO_VIDEO_CAPS_ENCODE:
+			r = amdgpu_asic_query_video_codecs(adev, true, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+			break;
+		default:
+			DRM_DEBUG_KMS("Invalid request %d\n",
+				      info->video_cap.type);
+			return -EINVAL;
+		}
+
+		caps = kzalloc(sizeof(*caps), GFP_KERNEL);
+		if (!caps)
+			return -ENOMEM;
+
+		for (i = 0; i < codecs->codec_count; i++) {
+			int idx = codecs->codec_array[i].codec_type;
+
+			switch (idx) {
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
+			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
+			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
+			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
+				caps->codec_info[idx].valid = 1;
+				caps->codec_info[idx].max_width =
+					codecs->codec_array[i].max_width;
+				caps->codec_info[idx].max_height =
+					codecs->codec_array[i].max_height;
+				caps->codec_info[idx].max_pixels_per_frame =
+					codecs->codec_array[i].max_pixels_per_frame;
+				caps->codec_info[idx].max_level =
+					codecs->codec_array[i].max_level;
+				break;
+			default:
+				break;
+			}
+		}
+		r = copy_to_user(out, caps,
+				 min((size_t)size, sizeof(*caps))) ? -EFAULT : 0;
+		kfree(caps);
+		return r;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 7fb9c09ee93f..728566542f8a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -782,6 +782,12 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
 /* query ras mask of enabled features*/
 #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS			0x21
+	/* Subquery id: Decode */
+	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
+	/* Subquery id: Encode */
+	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 
 /* RAS MASK: UMC (VRAM) */
 #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
@@ -878,6 +884,10 @@ struct drm_amdgpu_info {
 		struct {
 			__u32 type;
 		} sensor_info;
+
+		struct {
+			__u32 type;
+		} video_cap;
 	};
 };
 
@@ -1074,6 +1084,30 @@ struct drm_amdgpu_info_vce_clock_table {
 	__u32 pad;
 };
 
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2			0
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4			1
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1			2
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC		3
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC			4
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG			5
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9			6
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1			7
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT			8
+
+struct drm_amdgpu_info_video_codec_info {
+	__u32 valid;
+	__u32 max_width;
+	__u32 max_height;
+	__u32 max_pixels_per_frame;
+	__u32 max_level;
+	__u32 pad;
+};
+
+struct drm_amdgpu_info_video_caps {
+	struct drm_amdgpu_info_video_codec_info 
+codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
+};
+
 /*
  * Supported GPU families
  */
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cd6c0951db7304c035c2508d8c6d24c47%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637477953819089548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=19QB8BUXVKwLvvCQDVK4LOn6rFkO1jagHJ5RR1WD8rw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
