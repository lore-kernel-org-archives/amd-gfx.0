Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB31C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1658310E3BA;
	Tue, 21 May 2024 07:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d8ADwUq8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053C210E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD3rO5N4NiB/ndl+p13Xxrm/tuPt+iq4WbSiVoTM9Hu+lahjFHud6ovRLhiON2WCg88HOPPttiazTKpXW+X0qo69YumAnsGTYm7IFCl3E5Z0b6t6f53QpnW4zadpQJyKJU3qNB+PsH/vWGVsmpQ7a8IIA8rb4PIt/Ng6HrtD7yQ1hssJBUsp7ebuyUEyPtFa5gz0+JPdpV5Pe+4IIOpckexMQAoOgExXIYT7lTFq6JZsHQisDkcRtia+GJ2SssNhOCNjxCA0K3DjqtuhqPg+tzdBbYvVrwcfGJNlr8TMBmtykmfhpacRRcMnghE2wkCr7qPftFdKmUaZ5TxK6641Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLktOuiHchdyrt8R4cyOtoixowICtBLKDIOmg89LQOY=;
 b=iKOzN4p276U4c4TT65W+WIW6s4Iq0yCi0v8nTrWbsU3/7lGCKfx+w0V+PZIXdls0JlUVBChpaK51WW1rFheCOvxhHb7Rmqv7N7x+K75zoHua/IjmOy2T31XJGgoI0ZUlhCIz3Bu5M747qXSISCgcxxH0FOA5mWuzkiyOMjzMfB0d4nSYgKx/LKuY1Hj81CNzpQYLkOi4T0zY0wMxoNPLcSwwtBTttXVF/RLEzBdAptfTMDwrtjT5UiPPXWiLk+yrRDXLvNghZ+tOtq6GRGNvCnGnKm2GqffAaL8jYwai4qI8odoVugc6CWn+D3HkK3D382/+ZmV01VHRNmEfvXELFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLktOuiHchdyrt8R4cyOtoixowICtBLKDIOmg89LQOY=;
 b=d8ADwUq8mHqTpQs7FLQWcLVRuMbCo7jG1zjoszLVMYbQBaqlvVUEtm4PTAWaYdcAViC79XgDMHmbXYlJLgN0XOIFQHYDhmB8daBfcvRXvFI4bQCsK8b/6utSUZZrCJk9mN8mWLil+icAON6oG0/DyGA+Olxuk9ifrNBJP1Nx8M4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:55:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:55:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Add CRC16 selection in config
Thread-Topic: [PATCH] drm/amdgpu: Add CRC16 selection in config
Thread-Index: AQHaq06TaLoUm2fUJ0a5508FKFw8X7GhUcUA
Date: Tue, 21 May 2024 07:55:21 +0000
Message-ID: <BN9PR12MB5257A0A1BE171376BB7E66E2FCEA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240521071430.750167-1-lijo.lazar@amd.com>
In-Reply-To: <20240521071430.750167-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2ba40c45-95c7-455e-a75f-29e3725fd0c7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:55:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: 3366df7f-646f-4027-c267-08dc796b5d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?DcwCKWk6McvtJd0hRSuoOAiIXYgdspXgezNVlsu5QuOx0qPWo5U+KxMZETfq?=
 =?us-ascii?Q?xP+IbSu8Q8SqRGC8rUOUcmuGCaXcG5pLODtz2FbhWaRfc4J4qqJdtkojAnol?=
 =?us-ascii?Q?NYp5qPNGdoUyFJ9Rg3MyV2W+8w8q534fG+D/1b26dMQYEgUnVaZWlTdgZRXn?=
 =?us-ascii?Q?wH9LA5re+zm7+b76RVs+j7SD/s310eZ9/yrLHkLytMnnQOk/tz0xFdjnhWn5?=
 =?us-ascii?Q?7hJm6NUZJwaxM+5hsbZ76YKV74UXDAzC2Vrspk8myAz1MRTO3+E+QMUpV+te?=
 =?us-ascii?Q?KA2nd+a0uxt+mDpWf6bShVAWshP6ZO1rFd1eW5Uyp10cK/QVm4KbP2Xr+FAM?=
 =?us-ascii?Q?F0vZv7CHNpA/T39zsxHZE82Sdxs9vFQhUEoQicgUntI9HYB+QOXv+/94jYmX?=
 =?us-ascii?Q?aC6TcTO7NRI+5I0T/3G3P+pchmsvZwjHiHCLapGtBzq7cA+IeYYbNoWT8gIs?=
 =?us-ascii?Q?ohHJhkq0nuZSvb08pcNYJB4vmqSahGxCMTriuhAtm+T7kw1Papup8U5v1xvX?=
 =?us-ascii?Q?cQOzZGMl72dGuiBEI3A+jWG+QR/Tt4PfrKo4YNPIU3/xaa+Ex+lM3tVZHocB?=
 =?us-ascii?Q?j5GukWs6TllIiC5siFC0ZR+5l1NEx3cc7gjl0GIf5NkfRjDyACUNdSLF83Jx?=
 =?us-ascii?Q?Fi+zMLR7u7GnNf0JZPKQF1tUV52STo15nqb1L+o3dhAgXw0hjb6qHF82b7vI?=
 =?us-ascii?Q?/slKIksbqNDsY6RakwemtZya+l9B9hj0LVRnQuCTnutFI8rsorUvWTSiAhvq?=
 =?us-ascii?Q?STa4W6iN0egdLmCRpjh74NHGBynWogANT1q8AXKRpiNkineL4NPrw9unY7DS?=
 =?us-ascii?Q?KGrmBjTyQ04rVmzXZAFLVw5zV8XYZHZlfFFAOERDh06RJbiKSsMS4RpzF5g7?=
 =?us-ascii?Q?UWoTNQls43N806BgKudHpk/e93mV4AIy2xQ9REO0M1debxI8fdKJTDhM3Rko?=
 =?us-ascii?Q?7A885TLw0N9ij1xVjwSCVeK+lcbje2OR61gZi6PJbPloQkkHShUXn0AFsWBz?=
 =?us-ascii?Q?sfoi9mbLZcYe6NOpJaa3gvm8bcpPrnUW6erxUw4utBPwAFtoBhlngAkarIGe?=
 =?us-ascii?Q?BsaBj3s34WsonQMpkE4O5+Wyxt7W9iuVD5GJphg6P3AnALSMsM/ftsaO1UeK?=
 =?us-ascii?Q?yUGcYzF3qHSCrq/0agSMfd3x/Dhv7SQh6OYKgqfL8ZsAoQnpDStkyp88nrrr?=
 =?us-ascii?Q?VVS51tCvnY9TCQvWnkfYcnHJEiWF3QA/Knz3CXVahbMg0Akg1+lkytGZcjIG?=
 =?us-ascii?Q?qChmexNIpR0rwkECzHog?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d6bKPgjmQZQ0nIw1u9POEuXYo9Aet6gsTu0hytX/tkd63jpemTkFjIJ2Y2S+?=
 =?us-ascii?Q?ok0X1HsdPRFLpCA9VI7JbZr11QSZjpEr+7ZAQowIfdpHENbi/yboN1/lT5MS?=
 =?us-ascii?Q?RqhQbLe462v2PzV79BZsrvkXkvuTUjF5we830T/LekUkBqpsuftCZd3/eIZn?=
 =?us-ascii?Q?6mC+80CDJG/tezo8hV0pagDqERtaHxXsiOMs7lVmpGf3ZQd6AqqaC8s7qaQp?=
 =?us-ascii?Q?/aPCFpyoetafbysdtVX3ulY3bZlJPUg939jRPKhfWUSPtsZcPrR9myOx2X3T?=
 =?us-ascii?Q?aHM1xfBdFfhPaOEnTPMgMp7VT9Ylo2qsVkTpdXR3Fzi+LZ5EDbQNnT4T+iNA?=
 =?us-ascii?Q?4cwLHmyYYUPIjMXBNip+96q2/bBjhkZ2+tdU5UVAKO70KW46mz+gamkziYKa?=
 =?us-ascii?Q?tgkW7iPRMb6o3nixFUAaRoXa45l9U5F43H6G/iP6h9jzf28nVKZq/2TcSr5m?=
 =?us-ascii?Q?JwuLbWJ8TFIuNsqwbHA2tI+K15jnQx4Aq+Ja5PJyFuJ/qCWJRgSMjc+i/niO?=
 =?us-ascii?Q?1yeCsBtzu9W0qqcct+g3mbvh3t1kWm97n1SroQTQpWJ5ckV0+7wDFjPqytCQ?=
 =?us-ascii?Q?Rd5Sb4SicHeF3J0hlDQa2tug7gJ5F0o8nB+wHcAN1+XKrTZQ0GG9kbnvZqPr?=
 =?us-ascii?Q?EIUjgfKdAzpH32M7QFiCz+AGb8VYUV2dSUfroNNlb7pV42Ekyzkzp+LQIyBo?=
 =?us-ascii?Q?FVGE2+2NS5jd+VzmxVdVcnOCjcePmP3e34HVm79u+b1M6QNJk2/fmEwyEq7o?=
 =?us-ascii?Q?9am/GUX0D7ABUF0Kmjr2VO+nBTN0wN2YTBaKJaUm2+6NuYHi9z4Hj9Dwt5Ka?=
 =?us-ascii?Q?VlPady0W1X8u3Jc3C2A1HjuQN6GSiWChTV7waTKDy+3Etmy3LQaoRiBM6rB3?=
 =?us-ascii?Q?tfFf1W8bpCMjAOGdRrjxoYR5KRWaAkBNSTbfDixO/OpTwe5dg96jqSq5eh5M?=
 =?us-ascii?Q?hQkJ2uJDk3rnzc+wwPbw7PyrekQKgJOmvBwmYz5SjrLbWHabftHyziy766Wb?=
 =?us-ascii?Q?5wRlawHRgVFRwTg2ONGv5GQioDlHh/VrvJtNFCzQJn+VMkkPCLFJirUxJrHw?=
 =?us-ascii?Q?lMyLezlScNS7Z62m/HD6u7nlAcxMQ/o0qhomOMY6f9vowsz+UH2Lg9xBeMDs?=
 =?us-ascii?Q?/FN61pyADi6keCm0hCbcp/jfZzz8KQNt2Ax6Rp1g7SQouZSPYMVy7bT5T5Qx?=
 =?us-ascii?Q?Y4ZT7e0U3zg+J08aON1IWXGdNDiElC207BjdICOoCNPje/dK45MZCjwN9gM0?=
 =?us-ascii?Q?L2w6gKkHuU8YL3L+aCidloKdbowa833ZQlnEQS/wI9SoiozUEwzCF2mPIeM4?=
 =?us-ascii?Q?WpursoimnaMF4xMJo8+s0EQImF1KmTUOsgahLDVLXm9Y0xDxFJ0j1u8a4k8k?=
 =?us-ascii?Q?Iu1fBscRkSIytm8wQHi2tjH835jvMP7D89s6K1FZa5pwzLNv5y3W+p5SoDqj?=
 =?us-ascii?Q?b0719Z3XkWZJHU7Gyh1Lj/m8L1dHNgmcUV5bpsxeTMahoD6GEcWJMgRavJ7h?=
 =?us-ascii?Q?c3gZkglm+1zf9LLs2CWI6xkPDnHbSePfaMkEOrb5gmbdVq7QdZ0vua7tuf9f?=
 =?us-ascii?Q?pQMMsLwdPZmKYJXEEC4T281UxCR88N2M/gfnUyjG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3366df7f-646f-4027-c267-08dc796b5d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:55:21.3258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQkd0xRyctvpVdxY9rc8ByaLAIJs6/7t0uvZyO5WwjOasWt22rSC6a/RWTsW8IH4PNcI8jpohbtf/4vTYkLC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 21, 2024 15:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan,=
 Harish <Harish.Kasiviswanathan@amd.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Add CRC16 selection in config

KFD uses crc16 for gpu_id generation.

Fixes: 6dbc6469ab0b ("drm/amdkfd: Ensure gpu_id is unique")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405211405.TidTWIBX-lkp@int=
el.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgp=
u/Kconfig
index 0cd9d2939407..0051fb1b437f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -17,6 +17,7 @@ config DRM_AMDGPU
        select HWMON
        select I2C
        select I2C_ALGOBIT
+       select CRC16
        select BACKLIGHT_CLASS_DEVICE
        select INTERVAL_TREE
        select DRM_BUDDY
--
2.25.1

