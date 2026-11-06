Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B31606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e4u5oQj5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21F710E26C;
	Fri,  6 Nov 2026 07:02:58 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23D210E26C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 07:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0JBDrMybN2aedj1LeufHfpP32pd63pu+3VZV/4FNWjxqumdooHsrgDTvfGQxHxpW282Q2lKrR6nppDHCpcKksg9VDnMsoMTIODo7SAzQKGvraoz1nhYbc9b1jKMjvMxJ8B4uszW6kyDF3ZoQ2nu1ut0t2EvwH0LpwU3XPL6d0tXyjQtwSEOqTQWRnGVxf9gN9FyKFa19S7+AmAttGeGaZW4SrfNRhCNlysOnmsyKQjPyiUJ8eMobhe7OZ0iC/RIsqmHNvEtWm9SyB7ZQ5x6wHxZ9Ddr3ApGLfhwBAzVKMIOJRxZaXBW06TCpdHfJKJpwx/jRfex4z/DWNf1rmXH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTUEtQOX1g2pc55gxd0jIqUnBOHpLPRPwy5NquIwbKQ=;
 b=kh/1aUW8Gs3C+PykzoZkVIIM8UKj1ctbZD+X4o6JLfLdZu/YJHq/0FdRfLs9z/hzuJWL7kjqSqj0KsZtkTyi10HeJIMnIFzGNuIAhcle2Wb6Kc+HnPTUoZVI2LnG7Gpyq/2yejpltuXkM6ovcJl+k6ITBtEw5JQN5x4W8APSuoFW514EKOO/jGgta1m0DzzYYFVYB++NZKkSUZDMXLQdlrlzXjM/R/288NWOY63qu6ynytCxKiEX72iyt/Ov3Ow8npu3lzh4MQE5VqRbBdKI13Y2/0V/vkANSUkx8L6W88Z8beJK2nf+QD3kTvQAI6XcMOXO/zAEZFaSDr4jfa3vDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTUEtQOX1g2pc55gxd0jIqUnBOHpLPRPwy5NquIwbKQ=;
 b=e4u5oQj5SM2kotJPus+GVoiRwJV0fhHl83TuusV41cYFrZN3AgchGQSYd7esKOU776I0vzPNewF8IrQq1IeIqEpGL9A0ISL4U0BRiNOQ0QDi71R5Crq9fJ/nNmDkuYkU1iCpT9ZNDHZXJ4tOqG6gN0cCTBsOBZad2raOhWGpcrU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:02:50 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 07:02:49 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size
 limit
Thread-Topic: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size
 limit
Thread-Index: AQHda2cDrQT/JWclzEqn1BP8J+qCrrcgorVw
Date: Fri, 6 Nov 2026 07:02:49 +0000
Message-ID: <CY5PR12MB636974AF9E0B54C482EFF35FC1762@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261103074312.2467826-1-perry.yuan@amd.com>
In-Reply-To: <20261103074312.2467826-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T07:02:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA1PR12MB999230:EE_
x-ms-office365-filtering-correlation-id: dbe3df73-9fad-46a4-d5a3-08df3bd3f842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261009221727099003|261009221227099003|261009223027099003|261102123227099003|261009223327099003|261022105027099003|261009220027099003|261026140227099003;
x-microsoft-antispam-message-info: e3Ovy7+U2/T4ghEgh38rLuHXU2rNsCT45uxhnJFG8C0NPxX5B68APHAxo2RSmyhKQ9R4k9SU4HMfQFx+VKJC9chHhrbFhTkQPrex5+SBavAMsrO6mrIeVne7rak42+U96tTz9VUBx7IOLMUHNXe/TG2cdmkjWLDsGBj4Sc8kCD5/QMj7iZfv74IhK3dBetjXZVbi+tLoAIjYNjBCrCcLP+TQRZOP3HBcHp0QuRnXHiQG3Eq/k739lLlhBhVF4R7YceQ+nHxWXWVkVRAduX4BSxA1lrQ2R/fPEv5rhiDl2IGhwXxY/fzLcygMxeXZe86SRnpTIxka6wQiI7vymdaZaQIXi3mOCYBc23WH20qfcQs22ogwwZHImJnfUpS6loK2NHkd72T+p3OAKKlf0+F8+T3KtFM7YUvv8I2EoO+ezf28wY1206XCPNW66AEb46s7AffwgcsKv6reTOXldQhpyeCggkqMRueN5uA94r4N7PnvSDV2Bfv7oOgHniKZ4BNPBm936bXRvWiZ7s3esvbhOHABn2Ga+9hkSYqCdVOPAnry0yw/NA8z4gnj91hpI8XXeY5Us7pI3ADJDClelJb4mp0cn+21zU06Mn3+Q+DFCkgsZ3J3tkoUQmdpiDBlp5Iya1BCbCQRDSivQ6ppNOh18CoEN8o0dfoNgIESdbxNAx9zL/oRC3GkVn4fXO5hYCXlx/t0a+vja4ie5kBSGZQj0OQbcMI55aWEf3SrofnHnjU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009221727099003)(261009221227099003)(261009223027099003)(261102123227099003)(261009223327099003)(261022105027099003)(261009220027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gtKnUCVWqq1ZSP/JWOhJgrZpTJCea2p0UsBVSPWIC/vToctZtOPTBDPewY?=
 =?iso-8859-1?Q?0wZDQH6dQMqdG4PucFizviagF2/BeYmX0YUouxexFiSievjX7hbeELaN23?=
 =?iso-8859-1?Q?P0M+cQLRGBB2fP0Thb8hif0+PqVBPxJsbXj0GamJh6xp+Gd8W5DS4jOrMu?=
 =?iso-8859-1?Q?c2Jc/aUo0pF/iAro1/rj22rfmjtxNnBppOxEP/AL3BuZpW9MavodHiVMU9?=
 =?iso-8859-1?Q?GFX/6A3myIf4/by/AJOYdVuF2GDNeyFyOGI+D8MeOjMpPzFn39b96jf1Iu?=
 =?iso-8859-1?Q?1fiy9TCxph/n2tDTawW9uc4iEbqXqFEzTcOCorDi3zJT6gedwDCBOwvh9v?=
 =?iso-8859-1?Q?kKC1fuplT8eVdf6Xqx5CU7DeRaZGA96rFtsVh5UuzUuHFnCqB7UYIDbFRS?=
 =?iso-8859-1?Q?Or9rbXRj0gwpg9JwmpuJ6i0vSac3Hxxfd5SZTbazHvn/amtOwmcZ94/4cS?=
 =?iso-8859-1?Q?i9SJhk5+PDuXGh+q6TTlJn/366QT7fIKM1YPpvTj13ka53t+BOfpSKqpi8?=
 =?iso-8859-1?Q?7DG3hR8D2IvxgG+E1Q2L3gkvetYJKj9VteUzQIt6/1sdXS8gtFJJz1zvKb?=
 =?iso-8859-1?Q?rYYc0DFEBX12K1PvpjUNg1QoMedocYtegzR4Rt7A+hYAUbW4h2R3U2MnSu?=
 =?iso-8859-1?Q?nhmfe9tsrFUrrt9cmZ9+by84Bh6mxN6+XVu/UTgR+t5VIz88EH+9GYLqpJ?=
 =?iso-8859-1?Q?CPdeVu0zeaNhcSM2CO//CnPqdu0+pGvxSApLPVGjRrqVzobuaiR1I1TiFx?=
 =?iso-8859-1?Q?GgLLDNOJA8o1D7cidS3KZFUtFbU9zML+kdHXflThzMWyg+5dxeBES9Y9Hl?=
 =?iso-8859-1?Q?dIxvVpSZjbPW0L6NJNeEVVvOM5NkZ37xepWhr0jweg5pxd3w8bl0LR3vpf?=
 =?iso-8859-1?Q?z8YY63wswLReIMiqyVOW/BWRPb7t1DiSa1BITDRdMhwLRXqlw2W5ufgxRk?=
 =?iso-8859-1?Q?e+jEkAsLAdxjSH52la6cn3itamBO7+buObI0/tLTtAeRPncyWzwdLFzqta?=
 =?iso-8859-1?Q?O2e3aaTm+Lo0/A8vW5z+Ndw8ylchEzD6su/jJG5HnfgkN7zXnSlkcLEWWn?=
 =?iso-8859-1?Q?Ia5zd8l5PglybJ35HtnYd/BziF41WzJGlZ3gmDqkhDDUNGX1rQM2JPK+iv?=
 =?iso-8859-1?Q?aURAQSNOpFKuTqpgV+GS4GSQ4tp8hUR6DIMcaYTIDdrwO+9raM0qxBfrQP?=
 =?iso-8859-1?Q?DqIPIbE3dthGidJ1W5JpIU6DouqqVQoC6PBAqGMU+fzUmJFhEHX17lug8q?=
 =?iso-8859-1?Q?ekm2SSI8tK6XkHSRuv5R3p9aEDHdRikIM22i8JVo3qwnMMrSGFzF/+P0W0?=
 =?iso-8859-1?Q?Tol+jAeWn+PH4n5pfExh49CuBnbmk6gE19sZ0moLoViItMUdGOFipmw3iN?=
 =?iso-8859-1?Q?pin2aJViW2hnr0whfoEBKXszAPUJ9U4M77Bc4mHqWLBbqyXZDJBuExXscN?=
 =?iso-8859-1?Q?jG+X4zduqosqhMNc5O+HNnkGGy55tt4R+P0dXTPdpvQWwPGCCrCFQPnbu3?=
 =?iso-8859-1?Q?Bmcd+R8/85rK8/FD4TD00JCRaXwRtR0Qpp75Lvsr4peNu1+f165MVkM5hC?=
 =?iso-8859-1?Q?H7WWCst74JWWF3Y8edSKZeLiJukOqqdisf0iV8MIdqAoWOuQ4Z1U25UeXi?=
 =?iso-8859-1?Q?M9MVxE0XOgCrBu3Hxs9RM9adYw5YQ0iLYRMLqwzjOkMBpe6aMls4ZxP0VQ?=
 =?iso-8859-1?Q?1QdPzjGT1fRph5qHHaYp8HeKq8PC+6X8JtABKZza3tbOuxqEchpB5+DIXW?=
 =?iso-8859-1?Q?QoM1Sq91TMTWgrWHN+SrctuhM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3df73-9fad-46a4-d5a3-08df3bd3f842
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:02:49.9031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdBU0s2igEQpuWbCIcycbdrm5o4wL9JeRERJzoL5mwfTBS2dZU1C9NuB7rWgplUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

This patch is

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, November 3, 2026 3:43 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
Subject: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size l=
imit

The GEM_USERPTR ioctl now rejects userptrs above 1GiB. Existing application=
s that register larger ranges fail with -EINVAL, and the limit might need t=
o be adjusted based on customer feedback.

Add AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT (amdgpu.debug_mask=3D0x4000) as=
 a workaround to lift the limit, and print a one time warning naming the fl=
ag when a userptr is rejected for its size so affected users can find it. A=
 zero sized userptr is still rejected.

to disable the limit:
sudo modprobe amdgpu debug_mask=3D0x4000

Suggested-by: Christian K=F6nig <christian.koenig@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_gem.c | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5a32b54b1e9b..0355af0433ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -959,6 +959,7 @@ struct amdgpu_device {
        bool                            debug_enable_ce_cs;
        bool                            debug_hibernation_thaw_resume_gpu;
        bool                            debug_disable_ip_block_soft_reset;
+       bool                            debug_disable_userptr_size_limit;

        /* Protection for the following isolation structure */
        struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 5e0029530b79..ee5e61718151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ enum AMDGPU_DEBUG_MASK {
        AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU =3D BIT(11),
        AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET =3D BIT(12),
        AMDGPU_DEBUG_SDMA_RB_CMD =3D BIT(13),
+       AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT =3D BIT(14),
 };

 unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -1092,6 +1093,7 @@ module_=
param_named(seamless, amdgpu_seamless, int, 0444);
  * - 0x20: Enable experimental resets
  * - 0x40: Disable ring resets
  * - 0x80: Use VRAM for SMU pool
+ * - 0x4000: Disable the 1GiB size limit of GEM_USERPTR
  */
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by defaul=
t");  module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);=
 @@ -2345,6 +2347,11 @@ static void amdgpu_init_debug_options(struct amdgpu=
_device *adev)
                pr_info("debug: enable SDMA RB command switch\n");
                adev->sdma.sdma_debug =3D true;
        }
+
+       if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT) {
+               pr_info("debug: userptr size limit disabled\n");
+               adev->debug_disable_userptr_size_limit =3D true;
+       }
 }

 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned l=
ong flags) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_gem.c
index 348693023563..77e0e063147a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -567,8 +567,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, v=
oid *data,
                return -EFAULT;

        /* Userptrs are for temporary uploads, not a general memory allocat=
or */
-       if (args->size =3D=3D 0 || args->size > SZ_1G)
+       if (args->size =3D=3D 0)
                return -EINVAL;
+       if (args->size > SZ_1G && !adev->debug_disable_userptr_size_limit) =
{
+               dev_warn_once(adev->dev,
+                             "userptr size %llu exceeds 1GiB, set amdgpu.d=
ebug_mask=3D0x4000 to lift the limit\n",
+                             args->size);
+               return -EINVAL;
+       }

        /* reject unknown flag values */
        if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
--
2.34.1

