Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992166083E3F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=op6vrdH8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E7A10E45C;
	Mon,  2 Nov 2026 17:41:50 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC7610E45C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 17:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o89t46MFodmrspvq0AlTeV66ivaSaQaLkrdtqNCgD/wZzXGe6IA+RgboR2aTQfhVipTMBrW/HSus4XJkMLeK9GIMohOoaiV3rEuIvvtvryDsq8UmwvAXOgX2W7t8kzOUOWulvCkG53YedrLOGBqGC/WQhghoCSAKCRpRU7EMwDABrHScAQod8rMAaqltt3g1IGjHSbhYj1bQVDv/Y/UUlRwA0OPfBSQkPz8GBXCCGO2FDKKibjOP9K8sQ6S6FQbBLx7vuWI/0qRsZEQluSQMeSBxFw89/cBFElhw0XWHmo4kpwQSRdPB4OVSaWwuMMFXB3NaiYThDHmI7MmnyTRKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHfKVcx6pl8l9W3e8iqPzbRCtwsDCxIKtYMDY2c5JIQ=;
 b=EJIuXTR682pFbajp2C8AgXuEcuDuR5jVytbKJfvaC5Bn2gdBHYSgJMQpsCvep/DDm2HIzyge3jImBsHb5GJD8a40Qz2f9N5gGnmBV3HzGqt0GIF+IzLcgLrxou42Gp4gRkbBB65Z5CuW6gLX59ZantrDlV9h4rm/pTeKlFZJOqvsiZBdQw1bFKYmX+jwk+j9UL6OUilnyffbPjjgaRyhYqBrN6NAYk+PfJhoTKZwRjqJVWJs0IXGK+KmrUjn9AfYdmvmABTzOG56B72gg3ZMoUmJYaDUhoV9hRvSAoQVdSw/NknIKDFpoCPjSZQevioKnEu8M/vo/eZNkLQyNUvG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHfKVcx6pl8l9W3e8iqPzbRCtwsDCxIKtYMDY2c5JIQ=;
 b=op6vrdH8TzD4jp8tcfli5ZLxOQyVMmuivXk3lAO0UhSB/FjxttysJyiJBJTC+qdHiL0YG2CdTX3Y5dUfBw25w6kZCxyTxOVskLlcnoP7fMSdOhjb4ehbPt2EAcFOtTYJwY4DsvA6p3GsfgXqN8pUtej9KgxPTxnHsZ9SES7kHJw=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by IA3PR12MB899783.namprd12.prod.outlook.com (2603:10b6:208:621::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:41:39 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:41:39 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
Thread-Index: AQHdZ9BSLA5xcHDK5EWJ/SgTc/U/J7caNtKAgADYwBA=
Date: Mon, 2 Nov 2026 17:41:39 +0000
Message-ID: <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
 <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
In-Reply-To: <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T17:41:39.148Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|IA3PR12MB899783:EE_
x-ms-office365-filtering-correlation-id: 5feb1631-6b95-49af-4223-08df39088ce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261102123227099003|38070700021|261021121427099003|11063799006|5023799004|4143699003|56012099006|261009223027099003|261028144727099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|8096899003;
x-microsoft-antispam-message-info: aoZv0ncoCC0SZLq7wSD/6RgvPurkn9a9bJsfhS1rnIzaI6xjWNgLOhy/lIKtYABq3pcH6mS2B7gjP56qFTZYPjuFYJTqCmkUaqZcUMb18SezlQUz2CbbprHIdzbihnTJ8AJQ2Z0gjKHue7EsBHdLMmSqezl2hhJ82GREo1r8yD2nYZMEoyhxzUS3b29cFRGFYVHUOnQQbOTo+y7i0tU5+XvbFHHWtZ7IprFGuDvPiEXq+d/iqbR/1ri2joe44oWRuNe3wN6j4CsJepm1kY7OxSQv6QJ6TdMMIYnymHw2B6KDWyQmjbnOegrJ3yFeCO7h+835NiGH+ILmalxnBvGhw24WsGKxdMy4AixuxDY2oE5u1UY/YcAvuiVeBxnekMYgfk9CkhXqsHh/NSyhx57RvXCbeo1l5vQHKCRyqfxT3ZSb+XftDtal0hzA63/MLKlBnj+7o+pMo8muEjilbYAueDF0p5uYc+m/BYh+b2SLPZFOGsRSq9JS7VayKGMxJ/zyY+vKyhCgHu4kyMo5qkb/QI8b8uYviwddW0TPENVWUJ3aKR0zAKetg3uZzK138UVVT0NKddehEMQik2zTtssFmCzhvncgrWKKedqXdRYjJ2efppRlr1pSZkgr5CrOYzL+WP0zpNLDe1Fz/miF/cvRry/jsdTQRvnlV64Z7Q9h0IpW6ue275gGAWqmMUwtfmENoRqAq5M5StZbu0/+QDwqn/nDXlXWywAh+c8rqFk7ckQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261102123227099003)(38070700021)(261021121427099003)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tzr3wGd0I0qopR4lZd7RxvhaoHcpVseqtmwl+XB+rF82XGrUxO4VLrw6t332?=
 =?us-ascii?Q?tyTULNBoQ3a/Wiv6fndG3qmcuuOyz6cAnT7dEzwql9jPACInH9/8iJHI+v62?=
 =?us-ascii?Q?YAbV90HxoY8eUzrIspc4QKL57Y1zZigvlF3cBl2Kym4odEstATlIKVHI9H+l?=
 =?us-ascii?Q?wQ3VsykAJYXiU7818mYJILd8FUrUEw5sdSvEbYyE2AfqOwmnbfpkC7d02R0J?=
 =?us-ascii?Q?SAilFCWlQqhUkKSHrHaXSyd3if59iX63YCHgEvUAq701mtrfXzotnh/RK4tS?=
 =?us-ascii?Q?zXVUbhjoZGiPyNlP8PKEKBSQfZ9/RWRGg/yyrMRadOQEg/YyokHZeF/tIj85?=
 =?us-ascii?Q?08TzriwLcwc4DYuaHiQgChZbKHLPImuFDYDVHtCd3GLjlCeWmyvVB9n2Usjk?=
 =?us-ascii?Q?uKZW2aGwc1LDcLR+hhMm6n4WVSrGgvvmD1FAQUyHfDEdC5Kamx1bsiKbFWi9?=
 =?us-ascii?Q?IxstImAPA1vpN741WRzbTQwynJx0ovOpUFR0FLDmFwXSnodOaJqmgh4xEFN4?=
 =?us-ascii?Q?sGhkXJNfs04UcMci85d7ZDSwblrOeTFBmSSz0NfdFEFdmilyUpwGePfiHPE5?=
 =?us-ascii?Q?pOjpH5g35POcJ793006z7sas1S6tyzp1TqXLXarwvyJ4f8UK/SRWjqCgxuDz?=
 =?us-ascii?Q?JN4KAMJ6BFSRrY/UW8kLVNwJpBfDSqlhDSjPKWaPTOnfu2HYrBEw4OS8329l?=
 =?us-ascii?Q?mFEN2I3V1DxCW0FO1So/mpUuXJ1/alrOKInhKc6dcKhRzpINs86fqQ7pNH4a?=
 =?us-ascii?Q?OumBbUvj0hLV4303unbhplsmIFEnW1eXLeCOEZ7sufyi3f/YmSPrCj7KVKFo?=
 =?us-ascii?Q?6pk0TZ18r19JMrIR4nXjQZynRthAWLi5Q2Mcq4CWhxVQSmtH0b+pQPbISQX9?=
 =?us-ascii?Q?keU6dBjsyC0Hw9oEvGLskCRXSRtjguEJKSXG3CLIxuzw25Btj0c9USr1+wNd?=
 =?us-ascii?Q?riYh4QJefS1iWoRoxwh+EwttaQhfsYj/Xw93cua/NgIoYjMhsk78gMUYAivA?=
 =?us-ascii?Q?WVJ36PgXx3iiNF45kf1M9I5CjZ1beIipVE65rdd4tgUA45JzGh3M0lgsjG8C?=
 =?us-ascii?Q?/9zTTIZWW3husA16gADq9RSFKKSW4lXnjokLmxyXoqJp3uLsS72zMhniRzXZ?=
 =?us-ascii?Q?trKOAQY5eGKJfn8O51Hi3BHDKExd60So5JgDgnLHYdxsjfyP3zdp5PD1x7ny?=
 =?us-ascii?Q?BcJ90DRzdKcIKAzeHEaR7bExgyviMFf4qh8SVTiK/BKSjLapdPxfE9Te8uAj?=
 =?us-ascii?Q?HQHPTE55G7l25PUOSJvvwkpNcroYDG3Y/Aqto+Ux7RmrvuMj7GC/NFdaUelQ?=
 =?us-ascii?Q?pFTcgYPTpCYcDrhQqR6cBWBy+OwLFlRbBc0NmeNlQQ4uWE0QV4Cdzvm2Vm/+?=
 =?us-ascii?Q?xsL3ZNzmOaHC3QP2axjQh5tNikz8uJsffg5An2KAWnHcHvDFZPx67udJuEAG?=
 =?us-ascii?Q?cqmgkGjHJvGo9zrfvFndup/t5x1geem9/+Dop3rKDuOQzaSfUlw2cDgrk+SJ?=
 =?us-ascii?Q?800NwcB+tYQQZKj1VnQIla7prM/WIg5ytxleqDosZNiWfkDtlmwNDaCisy6J?=
 =?us-ascii?Q?69pjBFRmwNHNY4JaSl6fdA50ZrLHLGmzUu+vFLRb18l8/0rzgJHujAjh32GK?=
 =?us-ascii?Q?RMOERzR7H9QJU+CXTdN1ljyv+YZiz3BkLofbBUthsAfvF6jACkGtEvVfdIsR?=
 =?us-ascii?Q?LicPmcwLN3jaF1Si3FZ2ai3SnKkrnPfeUlYWFgr2xUOqaUhQ?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB6121D39D1B80B22A317CD00B806A2SJ1PR12MB6121namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feb1631-6b95-49af-4223-08df39088ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 17:41:39.5791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLwGmJxSO3aX7j9f4r1soQ1mC9qPji6qsFu0sa/aheBjxJPt/drWa58N88gud1aLMOwO2Kc/BilUcutw2rM8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB899783
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SJ1PR12MB6121D39D1B80B22A317CD00B806A2SJ1PR12MB6121namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

+err_release_full_gpu:
+ if (amdgpu_sriov_vf(adev)) {
+ /*
+ * Release the access the host is waiting on so it finishes the
+ * handshake instead of timing out and FLR'ing the VF.
+ /
+ if (early_full_gpu_access)
+ amdgpu_virt_release_full_gpu(adev, true);
+
+ /*
+ * Mark the VF inactive so the later fini path does not send a
+ * request the host will never answer.
+ /
+ amdgpu_virt_deactivate(adev);
>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>early_full_gpu_access case also?
>Thanks,
>Lijo

No, it should not be called. If amdgpu_virt_request_full_gpu fails,
the VF holds no access as the acquire handshake never completed.
There is nothing to release and RUNTIME was never set,
so the amdgpu_virt_deactivate() has nothing to clear.
Jumping to err_release_full_gpu would send a release for access that is nev=
er granted.

Thanks,
Chenglei


________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Sunday, November 1, 2026 11:32 PM
To: Xie, Chenglei <Chenglei.Xie@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang <Zhigang.Luo=
@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM aper=
ture is missing



On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
> returns -ENOENT, which the early init IP loop treats as the GMC block
> being absent. Init keeps going and dies later with a confusing -ENOMEM
> instead of the real cause.
>
> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
> point where the aperture is actually missing.
>
> On a legacy host the VF already holds exclusive GPU access at this point,
> and the early init error paths returned directly without releasing it, so
> the host timed out and FLR'd the VF. Route these failures through a new
> err_release_full_gpu label that releases the access the host is waiting o=
n.
>
> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
> adev->virt.ops, and call it from the same label, so the later fini path
> does not send a REQ_GPU_FINI that the host will never answer.
>
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
> v2: Move the runtime cap and virt ops clearing into a new
>      amdgpu_virt_deactivate() helper and call it from the label. Drop the
>      redundant SRAT error log already emitted by
>      amdgpu_acpi_find_gpu_memory_in_srat().
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>   4 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3ced5c18daaa..3b6a3d86348c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>
>                r =3D amdgpu_virt_init_critical_region(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>        }
>
>        switch (adev->asic_type) {
> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                adev->family =3D AMDGPU_FAMILY_SI;
>                r =3D si_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>
>                r =3D cik_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>   #endif
>        case CHIP_TOPAZ:
> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>
>                r =3D vi_set_ip_blocks(adev);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>                break;
>        default:
>                r =3D amdgpu_discovery_set_ip_blocks(adev);
>                if (r) {
>                        adev->num_ip_blocks =3D 0;
> -                     return r;
> +                     goto err_release_full_gpu;
>                }
>                break;
>        }
> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 &&
>            !amdgpu_device_get_rev_id(adev)) {
>                dev_err(adev->dev, "Unsupported A0 hardware\n");
> -             return -ENODEV; /* device unsupported - no device error */
> +             r =3D -ENODEV;    /* device unsupported - no device error *=
/
> +             goto err_release_full_gpu;
>        }
>
>        if (amdgpu_has_atpx() &&
> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_COMMON) {
>                        r =3D amdgpu_device_parse_gpu_info_fw(adev);
>                        if (r)
> -                             return r;
> +                             goto err_release_full_gpu;
>
>                        bios_flags =3D amdgpu_device_get_vbios_flags(adev)=
;
>                        skip_bios =3D !!(bios_flags & AMDGPU_VBIOS_SKIP);
> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                        if (!skip_bios) {
>                                bool optional =3D
>                                        !!(bios_flags & AMDGPU_VBIOS_OPTIO=
NAL);
> -                             if (!amdgpu_get_bios(adev) && !optional)
> -                                     return -EINVAL;
> +                             if (!amdgpu_get_bios(adev) && !optional) {
> +                                     r =3D -EINVAL;
> +                                     goto err_release_full_gpu;
> +                             }
>
>                                if (optional && !adev->bios)
>                                        dev_info(
> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>                                                        adev,
>                                                        AMDGIM_ERROR_VF_AT=
OMBIOS_INIT_FAIL,
>                                                        0, 0);
> -                                             return r;
> +                                             goto err_release_full_gpu;
>                                        }
>                                }
>                        }
> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amd=
gpu_device *adev)
>
>                }
>        }
> -     if (!total)
> -             return -ENODEV;
> +     if (!total) {
> +             r =3D -ENODEV;
> +             goto err_release_full_gpu;
> +     }
>
>        /* Request full GPU access only for the remaining SR-IOV init work=
. */
>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>                r =3D amdgpu_virt_request_full_gpu(adev, true);
>                if (r)
> -                     return r;
> +                     goto err_release_full_gpu;
>        }
>
>        if (adev->gmc.xgmi.supported)
> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>        amdgpu_smu_early_init(adev);
>
>        return 0;
> +
> +err_release_full_gpu:
> +     if (amdgpu_sriov_vf(adev)) {
> +             /*
> +              * Release the access the host is waiting on so it finishes=
 the
> +              * handshake instead of timing out and FLR'ing the VF.
> +              */
> +             if (early_full_gpu_access)
> +                     amdgpu_virt_release_full_gpu(adev, true);
> +
> +             /*
> +              * Mark the VF inactive so the later fini path does not sen=
d a
> +              * request the host will never answer.
> +              */
> +             amdgpu_virt_deactivate(adev);

Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
early_full_gpu_access case also?

Thanks,
Lijo
> +     }
> +
> +     return r;
>   }
>
>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 576a818db522..a4dd0299fe11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_devic=
e *adev, bool init)
>        return 0;
>   }
>
> +/*
> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed ini=
t
> + *
> + * Clear the runtime capability and drop the virt ops so the teardown pa=
th
> + * does not issue host handshakes the host will never answer.
> + */
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
> +{
> +     adev->virt.caps &=3D ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +     adev->virt.ops =3D NULL;
> +}
> +
>   /**
>    * amdgpu_virt_reset_gpu() - reset gpu
>    * @adev:   amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 3971bcc1ed11..3520af170278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *a=
dev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)=
;
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)=
;
> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index cd276a138e10..3bb13cfed92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>                r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base=
,
>                                                        &aper_size);
> +             /*
> +              * An SPM VF has no FB BAR0 and cannot init without the HBM
> +              * aperture from the SRAT. Abort this GPU probe instead of
> +              * limping on as if the GMC block were absent.
> +              */
>                if (r)
> -                     return r;
> +                     return -ENODEV;
>
>                adev->gmc.aper_base =3D aper_base;
>                adev->gmc.aper_size =3D aper_size;


--_000_SJ1PR12MB6121D39D1B80B22A317CD00B806A2SJ1PR12MB6121namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<blockquote style=3D"padding-left: 10px; border-left: 3px solid rgb(200, 20=
0, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+err_release_full_gpu:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (amdgpu_sriov_vf(adev)) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * Release the access the host is waiting on so it finishes the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * handshake instead of timing out and FLR'ing the VF.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ if (early_full_gpu_access)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ amdgpu_virt_release_full_gpu(adev, true);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * Mark the VF inactive so the later fini path does not send a</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ * request the host will never answer.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
+ amdgpu_virt_deactivate(adev);</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0=
);">
<span style=3D"font-size: 11pt;">&gt;</span><span style=3D"font-size: 12pt;=
">Shouldn't this be called when amdgpu_virt_request_full_gpu fails for</spa=
n></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">&gt;</span><span style=3D"font-size: 12pt;=
">early_full_gpu_access case also?</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">&gt;</span><span style=3D"font-size: 12pt;=
">Thanks,</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">&gt;</span><span style=3D"font-size: 12pt;=
">Lijo</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
No, it should not be called. If amdgpu_virt_request_full_gpu fails,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the VF holds no access as the acquire handshake never completed.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
There is nothing to release and RUNTIME was never set,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
so the amdgpu_virt_deactivate() has nothing to clear.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Jumping to err_release_full_gpu would send a release for access that is nev=
er granted.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Chenglei</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Sunday, November 1, 2026 11:32 PM<br>
<b>To:</b> Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; Luo, Zhigang=
 &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the H=
BM aperture is missing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 29-Oct-26 11:36 PM, Chenglei Xie wrote:<br>
&gt; An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACP=
I<br>
&gt; SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat(=
)<br>
&gt; returns -ENOENT, which the early init IP loop treats as the GMC block<=
br>
&gt; being absent. Init keeps going and dies later with a confusing -ENOMEM=
<br>
&gt; instead of the real cause.<br>
&gt; <br>
&gt; Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the<=
br>
&gt; point where the aperture is actually missing.<br>
&gt; <br>
&gt; On a legacy host the VF already holds exclusive GPU access at this poi=
nt,<br>
&gt; and the early init error paths returned directly without releasing it,=
 so<br>
&gt; the host timed out and FLR'd the VF. Route these failures through a ne=
w<br>
&gt; err_release_full_gpu label that releases the access the host is waitin=
g on.<br>
&gt; <br>
&gt; Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and dr=
op<br>
&gt; adev-&gt;virt.ops, and call it from the same label, so the later fini =
path<br>
&gt; does not send a REQ_GPU_FINI that the host will never answer.<br>
&gt; <br>
&gt; Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
&gt; ---<br>
&gt; v2: Move the runtime cap and virt ops clearing into a new<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_deactivate() helper and call=
 it from the label. Drop the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; redundant SRAT error log already emitted=
 by<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_acpi_find_gpu_memory_in_srat().<b=
r>
&gt; <br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++=
++++++------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp; | 12 =
++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbs=
p; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 7 +++-<br>
&gt;&nbsp;&nbsp; 4 files changed, 55 insertions(+), 14 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 3ced5c18daaa..3b6a3d86348c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_init_critical_region(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt; @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;family =3D AMDGPU_FAMILY_SI;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D si_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt; @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D cik_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
&gt; @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D vi_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_ip_blocks(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;num_ip_blocks =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, =
GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amd=
gpu_device_get_rev_id(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Unsupported A0 hardware\n&q=
uot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENODEV; /* device unsupported - no device error */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -ENODEV;&nbsp;&nbsp;&nbsp; /* device unsupported - no device erro=
r */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_release_full_gpu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_has_atpx() &amp;&=
amp;<br>
&gt; @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_I=
P_BLOCK_TYPE_COMMON) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D a=
mdgpu_device_parse_gpu_info_fw(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_fl=
ags =3D amdgpu_device_get_vbios_flags(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_bi=
os =3D !!(bios_flags &amp; AMDGPU_VBIOS_SKIP);<br>
&gt; @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sk=
ip_bios) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool optional =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; !!(bios_flags &amp; AMDGPU_VBIOS_OPTIONAL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optional)<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_get_bios(adev) &amp;&amp; !optional) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to err_release_full_gpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optional &amp;&amp; !adev-&gt;=
bios)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_info(<br>
&gt; @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_gpu;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!total)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!total) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -ENODEV;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto err_release_full_gpu;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Request full GPU access o=
nly for the remaining SR-IOV init work. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &a=
mp;&amp; !early_full_gpu_access) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_full_g=
pu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.suppor=
ted)<br>
&gt; @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_smu_early_init(adev);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +<br>
&gt; +err_release_full_gpu:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * Release the access the host is waiting on so it finishes the<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * handshake instead of timing out and FLR'ing the VF.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (early_full_gpu_access)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release_ful=
l_gpu(adev, true);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * Mark the VF inactive so the later fini path does not send a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * request the host will never answer.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_virt_deactivate(adev);<br>
<br>
Shouldn't this be called when amdgpu_virt_request_full_gpu fails for <br>
early_full_gpu_access case also?<br>
<br>
Thanks,<br>
Lijo<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_d=
evice *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.c<br>
&gt; index 576a818db522..a4dd0299fe11 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_de=
vice *adev, bool init)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +/*<br>
&gt; + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed =
init<br>
&gt; + *<br>
&gt; + * Clear the runtime capability and drop the virt ops so the teardown=
 path<br>
&gt; + * does not issue host handshakes the host will never answer.<br>
&gt; + */<br>
&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.caps &amp;=3D ~AMDGPU_SRIOV_CA=
PS_RUNTIME;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_virt_reset_gpu() - reset gpu<br>
&gt;&nbsp;&nbsp;&nbsp; * @adev:&nbsp;&nbsp; amdgpu device.<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.h<br>
&gt; index 3971bcc1ed11..3520af170278 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&gt; @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device=
 *adev);<br>
&gt;&nbsp;&nbsp; void amdgpu_virt_init_setting(struct amdgpu_device *adev);=
<br>
&gt;&nbsp;&nbsp; int amdgpu_virt_request_full_gpu(struct amdgpu_device *ade=
v, bool init);<br>
&gt;&nbsp;&nbsp; int amdgpu_virt_release_full_gpu(struct amdgpu_device *ade=
v, bool init);<br>
&gt; +void amdgpu_virt_deactivate(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; void amdgpu_virt_request_init_data(struct amdgpu_device *a=
dev);<br>
&gt;&nbsp;&nbsp; int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u3=
2 req_code,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v12_0.c<br>
&gt; index cd276a138e10..3bb13cfed92f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_=
block *ip_block)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_acpi_find_gpu_memory_in_srat(adev, &amp;ap=
er_base,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aper_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * An SPM VF has no FB BAR0 and cannot init without the HBM<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * aperture from the SRAT. Abort this GPU probe instead of<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * limping on as if the GMC block were absent.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base =3D aper_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_size =3D aper_size;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ1PR12MB6121D39D1B80B22A317CD00B806A2SJ1PR12MB6121namp_--
