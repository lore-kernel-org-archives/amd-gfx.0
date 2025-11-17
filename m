Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A465CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 06:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3CD10E2C7;
	Mon, 17 Nov 2025 06:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbSYpzth";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448F510E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 06:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvg8AMnqYvUvn6MP6Ca6BiCnyqyWBH5UuJtVbbMKxV5vkC5Tba6azR1Y+WiIpGMzFMfp+ngxX/xBJ3DUxWGTS/I0cPC95+xERlfhapYehqMsO65/alRD8XIBfCeu7P8nZ58dNHLPa6B2hiXDSuiaoXVCU80hUEyzJ8u3tTRTTAH2xD3q49kmMn4sEhham3xFLteEAOLRZVWWgMkQStDk7jM8fOy3Ed5YlkkMbUrw6zyaFPsXNiUer56jlXbdXEZcUyRdtJcYEA6ELwxEBdfyMpZnQp5dP4U0dM6t227Hlwy5mmFvYzeIyn4E6FU3x7EpFseFM8EySgzptxGKGSizaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjK8kCXD26KgNLK1BeqC21yWpffg/zfuTHnOVOykM40=;
 b=dG4h/4Jx0XHgBWr69KG0dhrC76x5DpUPDAijiPEOjPZHLE3GIraSzy5/BN8wdVZwENFsRkPCR658vsfaf5xpbxQXBWzRpAVX7/Xystzd2bK4WwAEMcZhSUYAciG1fTGp0dE/5Pf3WpREhouRn4VvGxakMMtdX2XT0Lmjrukb2Iw7YnFwVlmispt2Z6WQdSlshQtVg/hA1SqM2Dq5Ht6LPC8Kyg6KFMKuSAVsX1bsPF3tnN5kGAgahWqDtFED5EYnsGvbiLnKBq1nOmm1Ri30dS/avUgdYzoJddzU2hxY4pQgJQS43RDdLE8YvWWr+kIU1qir5DJ0EyUjYdfH2kFkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjK8kCXD26KgNLK1BeqC21yWpffg/zfuTHnOVOykM40=;
 b=mbSYpzthUzT9v5Cg3t/c/wBmlEjkpsujJGtKuQPzmSpfw8KKvYnAn38VEuv/PPDT4gSYEpYeUhO7N/FoUa8fUHg3GcQ4RjQwu2IgsgvVHEKgIv3x7qeotAVrFKPID6hy4VYJ6TY9I01bqLTVsaA2v9xpwoq16jvbZifbnTdgIH4=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 LV0PR12MB999067.namprd12.prod.outlook.com (2603:10b6:408:32d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 06:41:49 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78%4]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 06:41:49 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Topic: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Thread-Index: AQHcV4zXFUhXLmdr4kOtOBYJUQ4Yx7T2aqzg
Date: Mon, 17 Nov 2025 06:41:48 +0000
Message-ID: <DS7PR12MB57688B92299CD948A68820479BC9A@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20251117063821.3434458-1-chongli2@amd.com>
In-Reply-To: <20251117063821.3434458-1-chongli2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Philip.Yang@amd.com,Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-17T06:39:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|LV0PR12MB999067:EE_
x-ms-office365-filtering-correlation-id: 79fede6c-407b-4de9-69ec-08de25a46272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+aQi7ihz8j8Cflyjvw4rJr8NZ+tbPGHDxiTmULf3plfg06Sis0WfRT1anqoT?=
 =?us-ascii?Q?q3dxFusJslgBt+2jiwJnHiUdJSyqc3QPZOVRV07YU/a0PS/MNUEwFAkIK7ZA?=
 =?us-ascii?Q?mb8/mpdqPM/wQ2Bbv7pBNdagcUv3MPOvw+MhyRsYQ5BFTauRFwBoBgAV1vzR?=
 =?us-ascii?Q?GfYIqfw/bW7F2ZdIeiowj5etYBjHTfwEmn+uOEd1zBy0YAzT/VawKHcXuRtU?=
 =?us-ascii?Q?mThX61NnM7n8UrmYkCOhCQ0CwqAw0fT5mpotYbwAXIm6dReQCxKsxd9M+6dq?=
 =?us-ascii?Q?MDdzYGLL7WPlkdoTHgLuxhQCjnUP9bJk+/XtbYQ6H0KLvdcCLMndntIWVy33?=
 =?us-ascii?Q?SIFzSTrqrm+cZeTUf20QSTDG1CecMd/t2PMxO2AaZw7xo3Pk4WzDxnXQ3WrF?=
 =?us-ascii?Q?ysyQud6xR0HOOsh0TUXv8me1FRORfd9kf8fGuZejYg6v++d9C0qoDvmukN3T?=
 =?us-ascii?Q?Z3AQlky9MXWsAShLM0DE5o/87nPo9l67VFLMiHS0owNewxwS6/tCGEbFuqJ8?=
 =?us-ascii?Q?5UstzRYfqtUic/tdJRNDrlhHnDbni3ISPi5VyuKpRJm6iwRA0gEjtCIpygiT?=
 =?us-ascii?Q?M6Ttz19qpjg3NSpxGOCfLUVY+U5ihgOkAgF1VL5TYpCK6eFidVlX2Qp9ymIA?=
 =?us-ascii?Q?IvUaOXn7BgjQj+ngC+qqBRyy5Exd82HaXr3vEMQEXzzRwaXs+09MDgS0xMSL?=
 =?us-ascii?Q?lw5T9XIxgNd0LppiPxonAfHwMLjg7lU5+o6dTFdzGOKebzBT8Dkp7cF8991D?=
 =?us-ascii?Q?2bvtwkMPv7KkUL8J8B89bEbw4732GF7N4CCPtqN1TGdLpYb1yfLcKP+ye0/N?=
 =?us-ascii?Q?+KSHXRmknee6EbeZCUXFvK1jhJtrz1JphrhX/qqPhvhPKsfakE3JC4q31odj?=
 =?us-ascii?Q?ZBa3+erMgVk2+JQOohqRRYWBtm5zlPVSMTV53qUyOFr0ykvSRLpmTeIEXlRo?=
 =?us-ascii?Q?3TJlzaKQQ+ESCb4ylZzDuE9rDc019N1WB2JHVn7b4D5Dl5phTKPDFX4d/uOK?=
 =?us-ascii?Q?TdKIcbnQMs1MlVWxJgMFt4BcZeyw00gYuBaO72qyQdD3vP5H4cUAUaKvgOIA?=
 =?us-ascii?Q?Qf0h1Zp7H8JhsDCkGtf8Ic78WJCLcriQfTBNHx+2BSlVujHp83iGW23RkM3x?=
 =?us-ascii?Q?72nAazSiKG9Yj7Bejb7IWU80iX9dAUOzE+W8jaTIX7GtG/YlyFjkYhxPbzzp?=
 =?us-ascii?Q?RE6rlOz0fT2ac7BJ1qznMOJcE1iTsNzOYO1uzub7gO13paN3lEKjTYa7nHCE?=
 =?us-ascii?Q?uFOQAD7yO8zHCzlai21OSrKZBAfRoJLXoKtl5zpR2CjAi7rdMh2xFHTBt8dr?=
 =?us-ascii?Q?XqwxArI6nUANwFbDViVKZxeCYmGfd6xpwaxej1+2tFyTJx+2MpZgtIk4l95T?=
 =?us-ascii?Q?4fe7qV06FtX7cGweFgcDnZOZMY9xqDtNaX7i7dWbU/0dhu3sPjJagsAyTYc5?=
 =?us-ascii?Q?krH5GTDNcV7H4thBguCD633frPcdILyizgm2xTWRoTt4k4Kecgsccc5z0vOo?=
 =?us-ascii?Q?ensCa3tLiXDHWQbYqSjnVKV2lfNrPi6+zvqz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tv+IddOoiWhSjENF++3TYFMrpCD41ZvfCs4Lxyjw9mnBJtVfXOTdM4RjX4eL?=
 =?us-ascii?Q?92n6zzAQi27fcPtFoU1wnl2+jRV4fDXVF8+JymNZUbeEgB1M2+2PYbA/XDc/?=
 =?us-ascii?Q?GelXnzsGZeHpKfaqvZFIRCaqg6K+bmTSc/BN3lQm3Cx78ac1VHW7z17Krs5q?=
 =?us-ascii?Q?Ofayjd42IV25DL7aEwm3HPBMf8jcmGo4pusVM2LExyz2XRlI8kxvF/sJOSGh?=
 =?us-ascii?Q?y8OrM1JQ5I8MHqctS0NjberLX8onabudqqLEwrTLvSfJ+Q7isr0fjEgsVOHX?=
 =?us-ascii?Q?8BPUfR3I9myjd48ghLN529+5kZFhJEF8LU6Qc9s2UosBxDCcq3j6B5PHCWG3?=
 =?us-ascii?Q?wU3jGQBXFPwMs9TJ0XnPrRUXCEn9xcHPjJBpwhvzuLy3FOv91cnvSWSToYuE?=
 =?us-ascii?Q?kOoCg/zECHOo49r1AUXIhdWOgsV6JKYYpPL3zTAUo3CUATpqdP6poql+e4Uk?=
 =?us-ascii?Q?/Su7G4ig59YAWJ/cNmm2ZSRjzrr6s+LuVByna3lN0sneq51ud98awrnrJbac?=
 =?us-ascii?Q?ddnMXlXUruifADtSDuSDMDLmxo7IBNPf14veOqbonwBQv1Itq7TQgNBB3OUa?=
 =?us-ascii?Q?HIIhf3eIMBp87sdkue5srtyeuNtbiBxhfNEA86t+nQ4trRirm0yXCaSaaCvO?=
 =?us-ascii?Q?um+ddabPczPHut6aELjX48m3pvHj5KeOY37jJj0qWT4XxG82+Upyv7IiIRgA?=
 =?us-ascii?Q?jJCasJx4oRf90WD6s2+RGJMGkpfZRWpQrSGgNkd1ytOXI7MFJYTln72Yd63k?=
 =?us-ascii?Q?aGQIB831vE/J8yYwYqSf+q79FBjirGLqBdTj4/W3N2AEwgLzcsF2R+wjwQXp?=
 =?us-ascii?Q?Oglv5T0mp8f0WzsA44fZvwiOx2aOgNjjyk9ookYznNTXMYvdkeExTxDJfeoR?=
 =?us-ascii?Q?gzywMiJ6r2KSKjqtAyYmUXE90VXqYi1PsfGJKQ5FHIea73p9KoQGl/0yQcR3?=
 =?us-ascii?Q?ayq7tKVXP5kYq3gfVo28BM8XGixQBjVuA5fsIYwZfhNhuueFk6ymgfJY14Bt?=
 =?us-ascii?Q?rHG7bLYCTj6KOZ0AyyL0OpRBANOjx1ZDGVS/BGKJayeKmZF3VtyWJlE8J31X?=
 =?us-ascii?Q?VhpJ2Yx4IrzHvFj4Fu9JoIjNKbmA1SGs5OLvDkm7B/Jn4xAm0GmSHSqLpfGm?=
 =?us-ascii?Q?lz2hIa3Za95MDtpoZSDLgDmE3exN7So0VPAS0nskZSTKZ08QSCxxADnrlSgt?=
 =?us-ascii?Q?equJuSW1iiODbdn5wcooeN0dpOZSqZeGKMz+VUDjb2lGrl1X4cmAkj1g0Z/H?=
 =?us-ascii?Q?SBGyW3hqiDqFKo+nZY2gJ58TPdEgBj2O30m0Qrdg1uAfdjbJM27mnEKQyCdR?=
 =?us-ascii?Q?dPiQG2Dv7OkOMr/0Cg6i4moRees5ctZLN5okx7YUETFHs8Qk6xI9uDjfTw6s?=
 =?us-ascii?Q?mzh07Hr9dZRLcX4pN4BUr5fRCPt1x9rR+LCpGh2ISx73TYvhqIU4zzFj35sK?=
 =?us-ascii?Q?vUmjbuiUIiVeRcDIWp8JndUYmsFACdXf34prxzGImX8GMW/X7p7J2NNLHpBM?=
 =?us-ascii?Q?7bWpbJ7WkeGCoXsGT9QvjhB0CGYALWYT9tDHWJfUTpilXnnyGpgXhJ65x5Im?=
 =?us-ascii?Q?/Q8MkWMe39q2Mq9ZpKs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB57688B92299CD948A68820479BC9ADS7PR12MB5768namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fede6c-407b-4de9-69ec-08de25a46272
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 06:41:48.9095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/5xpigEm2lUiFOExTahi+c+ocz4uImQaxKU6hOERoXj901lqLyraMUCcHAALTWC0rfTz8ylGP6FN69zeAb8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999067
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS7PR12MB57688B92299CD948A68820479BC9ADS7PR12MB5768namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Hi, @Kuehling, Felix<mailto:Felix.Kuehling@amd.com>, @Yang, Philip<mailto:P=
hilip.Yang@amd.com>.



Can you help to review my patch?







Thanks,

Chong.





-----Original Message-----
From: Li, Chong(Alan) <Chong.Li@amd.com>
Sent: Monday, November 17, 2025 2:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Y=
ang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>=
; Li, Chong(Alan) <Chong.Li@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in amdgpu_devi=
ce_init.



[Why]

function "devm_memremap_pages" in function "kgd2kfd_init_zone_device", some=
times cost too much time.



[How]

move the function "kgd2kfd_init_zone_device"

after release full gpu access(amdgpu_virt_release_full_gpu).



v2:

improve the coding style.



Signed-off-by: chong li <chongli2@amd.com<mailto:chongli2@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-  drivers/gpu/drm/amd/amd=
gpu/amdgpu_device.c |  8 +++++++-  drivers/gpu/drm/amd/amdkfd/kfd_topology.=
c  | 23 ++++++++++++++++++++++  drivers/gpu/drm/amd/amdkfd/kfd_topology.h  =
|  6 ++++++

4 files changed, 37 insertions(+), 2 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h

index 40c46e6c8898..6d204ba2c267 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h

@@ -37,7 +37,7 @@

#include "amdgpu_sync.h"

#include "amdgpu_vm.h"

#include "amdgpu_xcp.h"

-

+#include "kfd_topology.h"

extern uint64_t amdgpu_amdkfd_total_mem_size;

 enum TLB_FLUSH_TYPE {

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c

index 0b40ddcb8ba1..b4e1f258119c 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

@@ -3333,7 +3333,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)

            /* Don't init kfd if whole hive need to be reset during init */

           if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {

-                       kgd2kfd_init_zone_device(adev);

                       amdgpu_amdkfd_device_init(adev);

           }

@@ -4931,6 +4930,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,

            if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI=
)

                       amdgpu_xgmi_reset_on_init(adev);

+

+          /* Don't init kfd if whole hive need to be reset during init */

+          if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {

+                      kgd2kfd_init_zone_device(adev);

+                      kfd_update_svm_support_properties(adev);

+          }

+

           /*

            * Place those sysfs registering after `late_init`. As some of t=
hose

            * operations performed in `late_init` might affect the sysfs di=
ff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_topology.c

index 8644039777b8..8511b00a7463 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c

@@ -2475,3 +2475,26 @@ int kfd_debugfs_rls_by_device(struct seq_file *m, vo=
id *data)  }

 #endif

+

+void kfd_update_svm_support_properties(struct amdgpu_device *adev) {

+          struct kfd_topology_device *dev;

+          int ret;

+

+          down_write(&topology_lock);

+          list_for_each_entry(dev, &topology_device_list, list) {

+                      if (!dev->gpu || dev->gpu->adev !=3D adev)

+                                  continue;

+

+                      if (KFD_IS_SVM_API_SUPPORTED(adev)) {

+                                  dev->node_props.capability |=3D HSA_CAP_=
SVMAPI_SUPPORTED;

+                                  ret =3D kfd_topology_update_sysfs();

+                                  if (!ret)

+                                              sys_props.generation_count++=
;

+                                  else

+                                              dev_err(adev->dev, "Failed t=
o update SVM support properties. ret=3D%d\n", ret);

+                      } else

+                                  dev->node_props.capability &=3D ~HSA_CAP=
_SVMAPI_SUPPORTED;

+          }

+          up_write(&topology_lock);

+}

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.h

index ab7a3bf1bdef..129b447fcf84 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h

@@ -202,4 +202,10 @@ struct kfd_topology_device *kfd_create_topology_device=
(

                       struct list_head *device_list);

void kfd_release_topology_device_list(struct list_head *device_list);

+#if IS_ENABLED(CONFIG_HSA_AMD)

+void kfd_update_svm_support_properties(struct amdgpu_device *adev);

+#else static inline void kfd_update_svm_support_properties(struct

+amdgpu_device *adev) {} #endif

+

#endif /* __KFD_TOPOLOGY_H__ */

--

2.48.1



--_000_DS7PR12MB57688B92299CD948A68820479BC9ADS7PR12MB5768namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Arial",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Arial",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi, <a id=3D"OWAAM2D427DBB0EF6485184A7A2A17B3FF4B=
7" href=3D"mailto:Felix.Kuehling@amd.com">
<span style=3D"font-family:&quot;Arial&quot;,sans-serif;text-decoration:non=
e">@Kuehling, Felix</span></a>,
<a id=3D"OWAAMDC892D4CB6B2433C82AB8499F2D0D85C" href=3D"mailto:Philip.Yang@=
amd.com"><span style=3D"font-family:&quot;Arial&quot;,sans-serif;text-decor=
ation:none">@Yang, Philip</span></a>.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Can you help to review my patch?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText">Chong.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Li, Chong(Alan) &lt;Chong.Li@amd.com&gt; <br>
Sent: Monday, November 17, 2025 2:38 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@am=
d.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;; Li, Chong(Alan) &lt;Chong.Li@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in amdgpu_devi=
ce_init.</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[Why]<o:p></o:p></p>
<p class=3D"MsoPlainText">function &quot;devm_memremap_pages&quot; in funct=
ion &quot;kgd2kfd_init_zone_device&quot;, sometimes cost too much time.<o:p=
></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[How]<o:p></o:p></p>
<p class=3D"MsoPlainText">move the function &quot;kgd2kfd_init_zone_device&=
quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">after release full gpu access(amdgpu_virt_release=
_full_gpu).<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">v2:<o:p></o:p></p>
<p class=3D"MsoPlainText">improve the coding style.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: chong li &lt;<a href=3D"mailto:cho=
ngli2@amd.com"><span style=3D"color:windowtext;text-decoration:none">chongl=
i2@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp=
; 2 +-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 8 +++++++-&=
nbsp; drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp; | 23 ++++++++++++++++=
++++++&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_topology.h&nbsp; |&nbsp; 6 ++++=
++<o:p></o:p></p>
<p class=3D"MsoPlainText">4 files changed, 37 insertions(+), 2 deletions(-)=
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_am=
dkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<o:p></o:p></p>
<p class=3D"MsoPlainText">index 40c46e6c8898..6d204ba2c267 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<=
o:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -37,7 +37,7 @@<o:p></o:p></p>
<p class=3D"MsoPlainText">#include &quot;amdgpu_sync.h&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">#include &quot;amdgpu_vm.h&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">#include &quot;amdgpu_xcp.h&quot;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">+#include &quot;kfd_topology.h&quot;<o:p></o:p></=
p>
<p class=3D"MsoPlainText">extern uint64_t amdgpu_amdkfd_total_mem_size;<o:p=
></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;enum TLB_FLUSH_TYPE {<o:p></o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 0b40ddcb8ba1..b4e1f258119c 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -3333,7 +3333,6 @@ static int amdgpu_device_ip=
_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Don't init kfd if whole hive need to be reset during i=
nit */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (adev-&gt;init_lvl-&gt;level !=3D AMDGPU_INIT_LEVEL_MINIMAL_=
XGMI) {<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; kgd2kfd_init_zone_device(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_amdkfd_device_init(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4931,6 +4930,13 @@ int amdgpu_device_init(str=
uct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;init_lvl-&gt;level =3D=3D AMDGPU_INIT_LEVEL_=
MINIMAL_XGMI)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_xgmi_reset_on_init(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Don't init kfd if whole hive need to be reset during init */<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (adev-&gt;init_lvl-&gt;level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI)=
 {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kgd2kfd_init_zone_device(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd_update_svm_support_properties(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;* Place those sysfs registering after `late_init`. As som=
e of those<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;* operations performed in `late_init` might affect the sy=
sfs diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 8644039777b8..8511b00a7463 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">@@ -2475,3 +2475,26 @@ int kfd_debugfs_rls_by_dev=
ice(struct seq_file *m, void *data)&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+void kfd_update_svm_support_properties(struct am=
dgpu_device *adev) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct kfd_topology_device *dev;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; down_write(&amp;topology_lock);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; list_for_each_entry(dev, &amp;topology_device_list, list) {<o:p></o:=
p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!dev-&gt;gpu || dev-&gt;gpu-&gt;adev !=3D adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 continue;<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (KFD_IS_SVM_API_SUPPORTED(adev)) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 dev-&gt;node_props.capability |=3D HSA_CAP_SVMAPI_SUPPORTED;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ret =3D kfd_topology_update_sysfs();<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (!ret)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sy=
s_props.generation_count++;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 else<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_err(adev-&gt;dev, &quot;Failed to update SVM support properties. ret=3D%d=
\n&quot;, ret);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 dev-&gt;node_props.capability &amp;=3D ~HSA_CAP_SVMAPI_SUPPORTED;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; up_write(&amp;topology_lock);<o:p></o:p></p>
<p class=3D"MsoPlainText">+}<o:p></o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topol=
ogy.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h<o:p></o:p></p>
<p class=3D"MsoPlainText">index ab7a3bf1bdef..129b447fcf84 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h<o=
:p></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h<o=
:p></o:p></p>
<p class=3D"MsoPlainText">@@ -202,4 +202,10 @@ struct kfd_topology_device *=
kfd_create_topology_device(<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct list_head *device_list);<o:p></o:p></p>
<p class=3D"MsoPlainText">void kfd_release_topology_device_list(struct list=
_head *device_list);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">+#if IS_ENABLED(CONFIG_HSA_AMD)<o:p></o:p></p>
<p class=3D"MsoPlainText">+void kfd_update_svm_support_properties(struct am=
dgpu_device *adev);
<o:p></o:p></p>
<p class=3D"MsoPlainText">+#else static inline void kfd_update_svm_support_=
properties(struct
<o:p></o:p></p>
<p class=3D"MsoPlainText">+amdgpu_device *adev) {} #endif<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">#endif /* __KFD_TOPOLOGY_H__ */<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.48.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB57688B92299CD948A68820479BC9ADS7PR12MB5768namp_--
