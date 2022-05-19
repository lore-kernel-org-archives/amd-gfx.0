Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F12C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 02:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344E011A26E;
	Thu, 19 May 2022 02:30:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0700811A26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 02:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip8AhM+rJzRmaSW6cOj3HeSeANTYtDX+WzSFWmzH8dNc0d6I2iAQ2CCjzpxmJnwYI1a05U4s7Ew1tGiV6UixXs42aAVl4OIVCV4DJSFiZH3gt6d/ARH3U5PM6h+dFj2fsHbk6pB33A8+jpKaNnEr48zgsmVrsEEUcPjmZnu9BiG8n+Rvv69wWNhFEXRDpJ2Is7WwYN+2CwmTxh+aGJhMqYCqUIGffBmsynw31KKNHAJrzckdh0u+oFFv85Y9yp9qwHYDP5OcxBdkzsoijkO22Qb6RN/dt1tBX/PPSe7OXlPT7Gb2RWYICbBAI96N4cgmvjzGwcKIV8KxXyil9EXOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBN7ZlZ/YAtpYLSn1058GkjY6One4b2/Lk06f3ve/14=;
 b=KoZ/OTDMRwq7FvMR8+RLypo63PU6avVItes6emf7olbpfi1KJMhFPFMyVLQ7nDMEja+TyUldRCgcI/nNJ9unh4nTPPOkESAyAQtb9NMRdZOXa2lEjLZN/1C3YpxYb2hD+3dQPoC1wMW5htI/59aIMfm/0PhmoSsNKnN0sv6b/OUWC0jLIK3v7xfX851QMhID3rnNr4CWMKL9bUQxejcFp4kaQzEBS9L99LJm23OsCBndjA1b6adTPUiB0nODpPnLpeJNgtwoE9RjOmBinCClbJy/eVLAjIA1/iNwzKl8jEbrfZZo7ZAUnoKsA/KBhdgR9jHrxBCUey3RSbELMps1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBN7ZlZ/YAtpYLSn1058GkjY6One4b2/Lk06f3ve/14=;
 b=qiHq1bCiLfeyFo6HI/nF1XPMQeYK00jeOMLOlqhHUuSz+aysJAMWPNL2s/vXLW5zuiRjJFBlUsc+kBjtAdbGS+lNwygPX72VmUqK2O0Bj0bZj0LQn9NOlzB+78fguCarg6szQS/U6fDj7n1ygRA3T/449scsKz2K+V9f3XS+dgY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 02:30:47 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 02:30:47 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Thread-Index: AQHYas4seEkHaDhAWEOY/BYkAHFXqa0lesFw
Date: Thu, 19 May 2022 02:30:47 +0000
Message-ID: <DM5PR12MB17704224A8610A8DE98FE790B0D09@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220518154428.9069-1-Stanley.Yang@amd.com>
In-Reply-To: <20220518154428.9069-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d98a0d52-7833-4b87-b3a2-08da393f952c
x-ms-traffictypediagnostic: BL1PR12MB5160:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5160D41133DDB81FAD89BCA9B0D09@BL1PR12MB5160.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmbFQnFyxGIZsogy2eEfeaxW8fmIWHVCLvkjR5VfGwseKLfQ9pQsnMFLo/7wvOppULihgIVa7xP3COTJreiHGwGxPo0iMEgeD5gmo+s6bA0pR2hojVw/c0AMTZ/o88G5iYw+P30U5JIKo0TDAVXIS1Kdp+mPyILEEeIaMobZMi2Pd4vVf6Rff8YIKD+GJSrJYl9im6Qgh402+P26Htq84aCVXHyLCPKp8POIPNFQEJPg3U0IA1MxNn36rwyy9thm0f9ibAky6nzXLtGkLvBJ98SJTCdfdmLf7yWZGbkT06s/Y33OwkPaaHqLlfyrzryUwTFuRBo9+Fup4xuNa0e9RG4sLdEKWWPTNGCdBYlE6cTynJ2A/oUfO4fjYRyUhmkC1Gu4t+c2l71GmeCS2kVs0e7XKigNnHhRpTKusMKeeQMynu0xBbNvuOr6t8IDq9d263Pj8j8BbDrcVTYGUPPIIIUkNcfoahfe96/VIbjnYkrIRZ2vWUieqYd37rJ63OJZlTFCwm2Pmwg39jVWPZf/tU482sTE89xSs23Vsx/0uXcbyqpfcXodL7JKWh/1m+mUGGhjBXkOj7W1aa6BsMmHYbKLKefBqQHWQVCxrcexC0Ki5dc4n6rLZ5w7CHYQhet66qEfSqruU/MmUhFswczh42Ythu48KheMSPjMlXxJhUhqWUKgjtqdEmyrwVkyVK29pjblD2AKHxT+X5eHRfJE6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(2906002)(186003)(5660300002)(508600001)(7696005)(8936002)(6636002)(66446008)(76116006)(316002)(86362001)(38100700002)(4326008)(83380400001)(26005)(6506007)(110136005)(9686003)(66946007)(55016003)(66476007)(53546011)(122000001)(66556008)(33656002)(38070700005)(64756008)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyyygWgD6vGLM/qYQrAfUGvlBk4QU2uh24/GUchR7CMpxs3rpUMYjXikYjuM?=
 =?us-ascii?Q?r1KUP2iUq+cUQ2wcgvqe/UAWXPXnvRm2BTRtPv3Z193joq4tyLciyRGjMkfo?=
 =?us-ascii?Q?2n6eVhlJ9ZcAdV4xkkUWKr8EBG8WMg/zvUAVM51TeOLVoo5Tovqk8F6u1YaV?=
 =?us-ascii?Q?asqbRznXiyQGSRBhbPLMvgnV5xQEin4ph4b12wTLJkRBXXE+NuyadGR0bA/w?=
 =?us-ascii?Q?IYuhI6u2fYLenpa/kC+AqXM34Boz/8Bzc23EEDvSWlnSrjz1iLA6tB6IpgZ7?=
 =?us-ascii?Q?a5U/F0iI76J8XRSoUg+oJesKvDSZilQCsE+UwV5RCC2p3EE6b2uDN+qKM18T?=
 =?us-ascii?Q?A8cNAcpIIxKWyG7RzIYyNeY/nbbQ84bHo2gUkd8mhuBwOqiOzGOK4DUxN6G2?=
 =?us-ascii?Q?2ARvlKmhfpKhsi7u1ALIEzSazwU1e8hEydZbuM+BVzE5krtIGQYs4nRIzRyH?=
 =?us-ascii?Q?LBX9jzQCEwXqw5Rq6L1yOacSwghIZvczi8EFqs/yVx444ux6EtHstseWhH2I?=
 =?us-ascii?Q?t5/GdbQcBVtQ+hQM/6pmkpybeRX6poMMbmtDvYcIxAEGqOkpYZafaz7eKNSX?=
 =?us-ascii?Q?Y3e8W1Os099RzEfIM/UHy0sHRgi9y4CSSWzQxLToRIQYchDSb9l/HsGIKBK7?=
 =?us-ascii?Q?vnlrki/C5o0/+S0NCBKHxr0sDGgZCJzmCmevjCGUaGi2vaaoTlhQ7o12fQRQ?=
 =?us-ascii?Q?H4mlw1+evE3JhKLrl8PvUunwaVfEmUsWBZl6VIu+Up0/a0iUdmQTbbgzULuY?=
 =?us-ascii?Q?DfkuQllokLuHeau92U9GwErpfecBddppP5r0Fw6c8yiyyb/WDuT94qpU8QWl?=
 =?us-ascii?Q?gncVGdtcu87GRyuuaBnXKwZb+O83BA2rVzIdzgiQ72zT87YkbMrCVgKWxvlJ?=
 =?us-ascii?Q?d7ye5wbT76EeI6boEJRQln25EUr73dwIXsMLoPNyL/r/Vmqt9wKDwoIVmixn?=
 =?us-ascii?Q?XANJ9Ao1WMrMwZov4/kNShfgmKeTX+g64LQrHIK8otstFKsTFSiPj7NN3XK2?=
 =?us-ascii?Q?HGvwvz+1uQnZuZq2DqX9Bd2UIK7jOmbkJQAJFCU9PJJ6WY7twv8XXXPGgMif?=
 =?us-ascii?Q?fo1A2STkNvmH76cg84B+zNlu7LXSCQYFijzHUZ9uz+52khKuy/DpfrxFDlVE?=
 =?us-ascii?Q?nEpOA6gph0Jnoow5yXr2hbjewAOjzaAyQyamRxE7ywzrAJRLDme4usSfcleK?=
 =?us-ascii?Q?4u4X5AXdLP+mLLbUuci7sgSTbcUV5I2x8NYxjkYPkt4w7O8FSi06u0dOai85?=
 =?us-ascii?Q?hf1aJ6qvlzjXWHaSIvk5GA1J1fEWpeQkhmWbUpDKL5pU4tXdTMf2XhaiRMut?=
 =?us-ascii?Q?/qCNYNeIs+p/OxUE/+zV+EoMI1YKGHM2EjxGVg048M9RqZ1WWE79PJVQuAA1?=
 =?us-ascii?Q?ThpPdvYlD1P81F750KgjS2jQpbFoOgszAL8b+sgLcQ4qOuFwBifRXQasYwmp?=
 =?us-ascii?Q?IiUg85tpf4Y0eCEHct7yDa6lKxJCa5q4qfWUqKu01yOxLfOWha6pr4PtU7I1?=
 =?us-ascii?Q?6udY7sA/iLNTNRhs9CM9KOFWz96tMN2nhBEQtn1ZYakCjzROyiVWyWTY3NM4?=
 =?us-ascii?Q?hMaTmSS9Y4mgUimkFbNb/Zay6iywK39eYAsnTIv5o+D3e+QWBK2NCLgOuLyg?=
 =?us-ascii?Q?LKlHi0/fDHTEOL0FoE2vNKmrm+r4H/H91jr7fZ+wA8cc9X5qNzOEv9EZZjRx?=
 =?us-ascii?Q?15J1QFl9PjDbmnGkCnxy8Pvg3tSzIdUc2tBo5R70qoGHF7a4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98a0d52-7833-4b87-b3a2-08da393f952c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 02:30:47.4335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DPs9KSmluEnjc1gRLgiNUvJA4SjEWkusuckeK4QBp2N6x3KpoW9dtwQeigc72H6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Wednesday, May 18, 2022 11:44 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
>=20
> support umc/gfx/sdma ras on guest side
>=20
> Changed from V1:
>     move sriov judgment in amdgpu_ras_interrupt_fatal_error_handler
>=20
> Change-Id: Ic7dda45d8f8cf2d5f1abc7705abc153d558da8a1
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 42 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  4 +++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  9 +++--
>  4 files changed, 45 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b583026dc893..ba7990d0dc0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5218,6 +5218,10 @@ int amdgpu_device_gpu_recover_imp(struct
> amdgpu_device *adev,
>  		r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
>  		if (r)
>  			adev->asic_reset_res =3D r;
> +
> +		/* Aldebaran supports ras in SRIOV, so need resume ras during
> reset */
> +		if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
> +			amdgpu_ras_resume(adev);
>  	} else {
>  		r =3D amdgpu_do_asic_reset(device_list_handle, &reset_context);
>  		if (r && r =3D=3D -EAGAIN)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a653cf3b3d13..2b28210c4994 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -726,7 +726,9 @@ int amdgpu_ras_feature_enable(struct amdgpu_device
> *adev,
>  	/* Do not enable if it is not allowed. */
>  	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
>=20
> -	if (!amdgpu_ras_intr_triggered()) {
> +	/* Only enable ras feature operation handle on host side */
> +	if (!amdgpu_sriov_vf(adev) &&
> +		!amdgpu_ras_intr_triggered()) {
>  		ret =3D psp_ras_enable_features(&adev->psp, info, enable);
>  		if (ret) {
>  			dev_err(adev->dev, "ras %s %s failed poison:%d
> ret:%d\n", @@ -1523,6 +1525,10 @@ static int amdgpu_ras_fs_fini(struct
> amdgpu_device *adev)
>   */
>  void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev=
)  {
> +	/* Fatal error events are handled on host side */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))
>  		return;

[Tao] The two conditions above can be merged, other than that the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>=20
> @@ -2270,10 +2276,14 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)  {
>  	adev->ras_hw_enabled =3D adev->ras_enabled =3D 0;
>=20
> -	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
> +	if (!adev->is_atom_fw ||
>  	    !amdgpu_ras_asic_supported(adev))
>  		return;
>=20
> +	if (!(amdgpu_sriov_vf(adev) &&
> +		(adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2))))
> +		return;
> +
>  	if (!adev->gmc.xgmi.connected_to_cpu) {
>  		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
>  			dev_info(adev->dev, "MEM ECC is active.\n"); @@ -
> 2285,15 +2295,21 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>=20
>  		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
>  			dev_info(adev->dev, "SRAM ECC is active.\n");
> -			adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -						    1 <<
> AMDGPU_RAS_BLOCK__DF);
> -
> -			if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(2,
> 6, 0))
> -				adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -						1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> -			else
> -				adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -						1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +			if (!amdgpu_sriov_vf(adev)) {
> +				adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> +							    1 <<
> AMDGPU_RAS_BLOCK__DF);
> +
> +				if (adev->ip_versions[VCN_HWIP][0] =3D=3D
> IP_VERSION(2, 6, 0))
> +					adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +							1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +				else
> +					adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +							1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +			} else {
> +				adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> +								1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> +								1 <<
> AMDGPU_RAS_BLOCK__GFX);
> +			}
>  		} else {
>  			dev_info(adev->dev, "SRAM ECC is not presented.\n");
>  		}
> @@ -2637,6 +2653,10 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>  	struct amdgpu_ras_block_object *obj;
>  	int r;
>=20
> +	/* Guest side doesn't need init ras feature */
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>  	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
>  		if (!node->ras_obj) {
>  			dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8e221a1ba937..42c1f050542f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -124,6 +124,10 @@ int amdgpu_sdma_process_ras_data_cb(struct
> amdgpu_device *adev,
>  		struct amdgpu_iv_entry *entry)
>  {
>  	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return AMDGPU_RAS_SUCCESS;
> +
>  	amdgpu_ras_reset_gpu(adev);
>=20
>  	return AMDGPU_RAS_SUCCESS;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index d6d79e97def9..18014ed0e853 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -85,9 +85,12 @@ static int psp_v13_0_init_microcode(struct psp_context
> *psp)
>  		err =3D psp_init_sos_microcode(psp, chip_name);
>  		if (err)
>  			return err;
> -		err =3D psp_init_ta_microcode(&adev->psp, chip_name);
> -		if (err)
> -			return err;
> +		/* It's not necessary to load ras ta on Guest side */
> +		if (!amdgpu_sriov_vf(adev)) {
> +			err =3D psp_init_ta_microcode(&adev->psp, chip_name);
> +			if (err)
> +				return err;
> +		}
>  		break;
>  	case IP_VERSION(13, 0, 1):
>  	case IP_VERSION(13, 0, 3):
> --
> 2.17.1

