Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A447C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 11:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB7B10E253;
	Wed, 18 May 2022 11:18:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3288D10E253
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 11:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzvAuRN74GhvP5jTnTW5KcEKRJQJvi71V5cjG9zgAsQwmZUO0AXEuoMPXgfoLmsuNBzcx5CRKq8Ehh8Ji4d9rktAI1CuOE2fkSw4zL4FM+pJ91U6SihWE0fBVt8Z+Yja1ybIyIDcwpKbfDf66n3IKFu6z9JFyPmWar90RLRDQlZDCSIt3H39nsR7ajUWitPQV6VPEPwa/E5bZrD/wFQETJKNfcuEez6T42rlcU1HtCfjxvrzkLT3Bd/RzVPlX7RFBxxwDJjvUytNMcZHMb5Tp4bZNYdpoyhg9umxzaPEesqYAsc0PbGeqoPVrpYTABNSTr3+6NMuuAfJymS7JSiN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W404xsgXFyuvFrWEXMZvTRS5e3511cAIM5NjfzSMcu8=;
 b=IkRq2DB2QQiTitqpSzN3Br679QLU/62+hnJGG4m5Bi3TpNZAfQzpx+QQB7IJDMG5qQuOuGUR1YwRYrHVMvRdxfzUzCY0LVzncADRRzI6JVX4ns1UkElwOgt5opXScSNwWuQVc5VGa3K6IzF5arwdXg8SGIy4UZvy1q2kxCEpKGA5xZB6vLoSpCvFZS5bsHUChD3oecwVk92A4o4fOV4UA/X+J10ZS6sHzRIOlnsp+lEu7Dv738t0GtiA859Nldos2gZD9wugVXVitJ6T/p58PfLF4PEG8/DMiJAgxnUBS5mJMqu+py5FqeORSn9el5/6OYxpnukAvZ+Sr++5nzhATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W404xsgXFyuvFrWEXMZvTRS5e3511cAIM5NjfzSMcu8=;
 b=udBQeUtIWLwZ4fZdSrS+OIOqjoewfjgxy8Rn0m0iVQyMmF7lEfcssMjjUo5aMm5kmm8zVJmcjAcKQ0+W0IaJ35HnHn2GrB0tnVvlNcNQEEN7LAriuysRRokXw96Fw+Uy0n1hUHSsQv19YZJxCihZliXtdJ5cg7FpCyAOx3+/60g=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 11:18:54 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 11:18:54 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Thread-Index: AQHYapHDo8EOHdncE0uClA+i9v76Aq0ke4TA
Date: Wed, 18 May 2022 11:18:54 +0000
Message-ID: <DM5PR12MB1770A238904283CD7C4B548EB0D19@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220518083159.17762-1-Stanley.Yang@amd.com>
In-Reply-To: <20220518083159.17762-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-18T11:18:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1a051b42-c559-4b59-8a3c-7961b418517a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9d57657-2dc6-49bf-204b-08da38c031a6
x-ms-traffictypediagnostic: BYAPR12MB3255:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3255DF65E20451FBC0BA8DE0B0D19@BYAPR12MB3255.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4BjR/eZHpechox+YQJB+qKGZJ9do41qkV7cDVTTsSStDA6WKLOlU+wfK5g9mnCarz3wTRv78KaP/L5oA9JVS6mzoU89FtH0oEn5sQ5c1Kam/TWWPsplRXyzR5PhzRIUKHR+jp00VawO4r/ennvLPTX7QI1a44q2fenb5YEbuACMfqLd525i7mIpaNyDDC3OCfZYeWYYSTA2694wxhc+kMX7CXWpWjPjFQc20Y54KnsRcR89dH0LBbK1WprfHJ/e+tIgiNhxamE4IVYtMZbYmV8FWmsF5Y3mJGz3XX1RV0krnraBzrjfbY7KwwUAV4hqeaF7W0Tlc7n9kpOIvyeitoirz0gbfCe1RXsktQv27gbRHMMMdf9umfwCz3i5FTAGKXo0lZml0SN6L1hp7YADjPI9DXlUVtqgG4CQ+v0TkjBjFRbPtfvx+TsczcqdHQH+4u921zodKaaGk3/StPJmyWShMGIbOZT5T3Eyx488dxlJC8OMK/wcWDLqumgctASsLHXjGlQCuNBR5bOG3SlHGJIFpOdEluckga/Y2UCEu0BJvgJfxkADV5Aa5XsDR1JsgYmircvf0GIIpWMcfEpRSUabEvvemkM5ixVE/vjhLtLdya3uxVOTtNyyPPexMicURJiQZUNovOnwcIi8DTpcqdnocJnt16QGJALCvJaMGX5w5tVtTonoN7oeDGYOizYM2iQQrB+6CWqWYZTpcqSx5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(508600001)(52536014)(5660300002)(26005)(66476007)(64756008)(8676002)(38100700002)(38070700005)(122000001)(316002)(6636002)(186003)(2906002)(66446008)(55016003)(71200400001)(6506007)(7696005)(66556008)(4326008)(9686003)(86362001)(53546011)(110136005)(33656002)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r0N/3BMnlSM3zdk9LvYzvIm6ZlClAQW7Ne4+z7weHQO1nqYu5QdGD+xbcpOM?=
 =?us-ascii?Q?P9E+Pny3AfZfs/40Np1Rolv6aUjnKHSoWVRkO4nxOsQRRBLASXL9GURdTGwI?=
 =?us-ascii?Q?lZtmbPOYTJd7IC9B1a4uxKNgFEPZhLtHTrjqrUnEXNI+h8Z6d7B2YRqvg5A/?=
 =?us-ascii?Q?HspoMelyy/fJ8oD5FwmBMMyfkVu02SxLXvXdgwESlJVnvQ1mNUJQrYBxv60q?=
 =?us-ascii?Q?I4HiCWXRJ+/D8QNQ0X+7Sj1k23gUwXXJkmK3zy668G0sKT0YY9SwhW/wbi2v?=
 =?us-ascii?Q?NjoAmYYkR5P9hakgSCIwUAvGPCaqPff+KoVRfqWgtfPD7mtmITGa/4ttz9PV?=
 =?us-ascii?Q?vzFeNXCkdjXtPZT0HpVwO06A+JPidVobxwG0QIb2XeCjfPzMTcN/kqcFYIxa?=
 =?us-ascii?Q?gszg8/QM2mDwiRYEIggbH1ih6ernIx6nU2d+ZaVVibJSHnK0aCBgQJ7/a9Zg?=
 =?us-ascii?Q?f8sDHoZco951nzxSWj+gQktGY/a3a2WSWAEf7kE+GuQpagoDrEKtV83eCabX?=
 =?us-ascii?Q?a7OjnQP1Dog29jCFGwR3RZDNPiiijJ02DQFyOGzp26FUy1mNDuPWRUaa/tFl?=
 =?us-ascii?Q?2bnvnBf9bOhuD2pzUL0HF62nerhyvASL+fj5HP/ySPuH3I9OFa4ckCCwnq4d?=
 =?us-ascii?Q?yaK9v0Jfze0jchmbuv1YNMRlanuyDfBkxecDVPZO0g2qPyf633htGYp6zncH?=
 =?us-ascii?Q?99c0lfHhM4Qt93xwDmK7vGuSTDzMzDo3zXGXzxxarxZnNX9kW8JCO1UFRX9s?=
 =?us-ascii?Q?S1NDpitGGmCZDfu5Fvo/wwol1D4TeiK99vnzDm2V4BQoWEvRNNH1dPqMMBwu?=
 =?us-ascii?Q?QBhlxvbF6hk0zZhuolyenbBagupNzIJUYdMSnMJD4cRZHLPspn8d5fva0006?=
 =?us-ascii?Q?lDmrrpyoJwli3PR7Pm2tP/sbbxVcA5OwM04PpL6beeeF0Rec+HmO6toQIesq?=
 =?us-ascii?Q?q7rHa+wPpHrPbSjaTJ9BH3HtRijFJKEfzYO/qe71bVKVZB1h1rvg4//6zgG3?=
 =?us-ascii?Q?Z1/lnu7YyhyaZdEwZ1+Q5JBF2jo3LSiwo1Bi8e8nKcymF0lnE4w7jpGVXALS?=
 =?us-ascii?Q?780EEavKmy5DtXbumH+f+L0Gfiz4vDoTlWZKf3Yxn9IEhxYBQR6iYvJYXaMt?=
 =?us-ascii?Q?J/P/0Rj/ZG1y4hGQs3CtrflzkydFf1/tso7ygZ6a76ZDKDDwM241m5KMXFfd?=
 =?us-ascii?Q?GCkED6UlDEsvo/jZw3uamcO3Y95O2oybEduex3JtjWX0FoPr2U1AfzxoaQ2s?=
 =?us-ascii?Q?bf3GMhfcVDx76igSRzEObKXLO/w/l2MP6SjNvCpnqF8uNF88XPzQnsikiVaA?=
 =?us-ascii?Q?VqFvh7FXRn9SOS5ov2bv9VnRnq5D09eMvt2ewqTDRecOqJhNpz9eiyoqBk/T?=
 =?us-ascii?Q?1E35aHpmiTUhLyo/86KyuJId5D7CbxPPhnnA0ZkRyACHZqIWw2e5TV6IgJNg?=
 =?us-ascii?Q?OXg1/LsbMJk6QNj4KKakI2NnnICYLfn6OESDexAv8yjVcqk/QYkU9a0mJSRD?=
 =?us-ascii?Q?wJ0gzbyFZR5vfLkCVLl2scbKdMWjmb38/oWqtmxMN0k75JKBKXo2csbaqDms?=
 =?us-ascii?Q?xAv/vkYch+14YAHGU82bY1l+Ozr8Kb2XGv2Wdu4TLei1i2mcyHPbdBrV2UsY?=
 =?us-ascii?Q?gvqjfZf4wnjyLjZbxESgMM5bP22z6Ok7w0yGjPshX7V0YHKOHv4CptCeF1kv?=
 =?us-ascii?Q?RfTUMWezcoK070CdyAg7utANONz7EF+hGOjuliFsRslETj/O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d57657-2dc6-49bf-204b-08da38c031a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 11:18:54.3881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drGf19+aRh7Dnk7joWEUu8rqq+37lRrmEqYjf70VsrpO7Q0tJ7E2m65OT7j1k2RV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3255
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

[AMD Official Use Only - General]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Wednesday, May 18, 2022 4:32 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
>=20
> support umc/gfx/sdma ras on guest side
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 23
> ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  9 ++++++---
>  5 files changed, 37 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 85412e1a04be..e832c5bceb63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5372,6 +5372,10 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>  		r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
>  		if (r)
>  			adev->asic_reset_res =3D r;
> +
> +		/* Aldebaran support ras in SRIOV, so need resume ras
> during reset */

[Tao] support -> supports

> +		if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
> +			amdgpu_ras_resume(adev);
>  	} else {
>  		r =3D amdgpu_do_asic_reset(device_list_handle,
> &reset_context);
>  		if (r && r =3D=3D -EAGAIN)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 31e07dfc874b..12a1f2389714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -202,6 +202,10 @@ irqreturn_t amdgpu_irq_handler(int irq, void *arg)
>  	if (ret =3D=3D IRQ_HANDLED)
>  		pm_runtime_mark_last_busy(dev->dev);
>=20
> +	/* Fatal error events are handled on host side */
> +	if (amdgpu_sriov_vf(adev))
> +		return ret;

[Tao]: can we place the code in amdgpu_ras_interrupt_fatal_error_handler?

> +
>  	/* For the hardware that cannot enable bif ring for both
> ras_controller_irq
>           * and ras_err_evnet_athub_irq ih cookies, the driver has to pol=
l status
>  	 * register to check whether the interrupt is triggered or not, and
> properly diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2b80a3037481..930fa3837ef9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -721,7 +721,9 @@ int amdgpu_ras_feature_enable(struct
> amdgpu_device *adev,
>  	/* Do not enable if it is not allowed. */
>  	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev,
> head));
>=20
> -	if (!amdgpu_ras_intr_triggered()) {
> +	/* Enable ras feature operator handle on host side */

[Tao] "Only Enable ras ..." is better.

> +	if (!amdgpu_sriov_vf(adev) &&
> +			!amdgpu_ras_intr_triggered()) {

[Tao]: it's better to replace the two Tabs with four spaces.

>  		ret =3D psp_ras_enable_features(&adev->psp, info, enable);
>  		if (ret) {
>  			dev_err(adev->dev, "ras %s %s failed poison:%d
> ret:%d\n", @@ -2181,10 +2183,14 @@ static void
> amdgpu_ras_check_supported(struct amdgpu_device *adev)  {
>  	adev->ras_hw_enabled =3D adev->ras_enabled =3D 0;
>=20
> -	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
> +	if (!adev->is_atom_fw ||
>  	    !amdgpu_ras_asic_supported(adev))
>  		return;
>=20
> +	if (!(amdgpu_sriov_vf(adev) &&
> +			(adev->ip_versions[MP1_HWIP][0] =3D=3D
> IP_VERSION(13, 0, 2))))

[Tao] replace the tabs with spaces.

> +		return;
> +
>  	if (!adev->gmc.xgmi.connected_to_cpu) {
>  		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
>  			dev_info(adev->dev, "MEM ECC is active.\n"); @@ -
> 2196,8 +2202,13 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>=20
>  		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
>  			dev_info(adev->dev, "SRAM ECC is active.\n");
> -			adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -						    1 <<
> AMDGPU_RAS_BLOCK__DF);
> +			if (!amdgpu_sriov_vf(adev))
> +				adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> +							    1 <<
> AMDGPU_RAS_BLOCK__DF);
> +			else
> +				adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> +								1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> +								1 <<
> AMDGPU_RAS_BLOCK__GFX);
>  		} else {
>  			dev_info(adev->dev, "SRAM ECC is not
> presented.\n");
>  		}
> @@ -2532,6 +2543,10 @@ int amdgpu_ras_late_init(struct amdgpu_device
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
> index 3b5c43575aa3..72bfac9bf9d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -123,6 +123,10 @@ int amdgpu_sdma_process_ras_data_cb(struct
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
> index 2c6070b90dcf..165cdc2d7f0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -75,9 +75,12 @@ static int psp_v13_0_init_microcode(struct
> psp_context *psp)
>  		err =3D psp_init_sos_microcode(psp, chip_name);
>  		if (err)
>  			return err;
> -		err =3D psp_init_ta_microcode(&adev->psp, chip_name);
> -		if (err)
> -			return err;
> +		/* It's not necessary to load ras ta on Guest side */
> +		if (!amdgpu_sriov_vf(adev)) {
> +			err =3D psp_init_ta_microcode(&adev->psp,
> chip_name);
> +			if (err)
> +				return err;
> +		}
>  		break;
>  	case IP_VERSION(13, 0, 1):
>  	case IP_VERSION(13, 0, 3):
> --
> 2.17.1
