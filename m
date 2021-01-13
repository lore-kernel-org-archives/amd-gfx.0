Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70866C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 02:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C9322DD3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 02:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9322DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C72789B3C;
	Wed, 13 Jan 2021 02:04:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8B989B3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 02:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCgGCm8d2uaJ26FpIXMD5hQo5t7pEzl7QO7SHYSWsRsmdvUlida7SQ3a5Ea6vvw58DMn7VuP5P5HLA7gpgzL7uo1DiJ5seWaao9NCjhNAJfkgmqGObrjOVM5aOD35ZGXRcXajPtvAx57/PO6GONUyDJBD4DZtE8carwdvCfGWfMtMvC0UDbHsKloKdoXAUI93jSMWjKC+c2a5ENz1f0p4HoPXICR4v+gZJI8Zkb0BkiqMySvrBOKhdUn4c9FixR8hwOi+1hiQ0dd/C0nP9po3DNcgbnCR42IJ7EymFYp40KzTjUdUlH3XPrt57PiK0Zt2j9QoI5yNnemGxLUO4T7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFn4NMfN0+V3G0alOijvC4XnNGvUu1Ma3Uffo30oyMw=;
 b=WkTN1rv0gRO+zjfHYQUXTyCgXj7v0TBb5Nl7MLhhJ1xKUwwh3ez2gX3ily9aIrZ/Hs7DCDZvGx2a4kwTogJmXQ3U4A6Bm2FEJbLsG2jlmmBC4ONTMSC/50h+Wt8naZBap7vEOJiv6dlgJ0OUf7XSLsD/dMh7aKMOPzXQiyZAzNlL2wDOkwlxkKGxAjKuRPOFICdSBYkPo5zLTSjGco/Ll5uueZXia6KxfA7T4XX6IbwrQErHACvP87UZlSmmB3ZebrbaFXmGEZDCwe9lhRZaYBABWRcBeeTpGtm3ChkwSyn7n59b+pjelXCeAmHqYviP5KhhGJpYSfN6mE+AiaIZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFn4NMfN0+V3G0alOijvC4XnNGvUu1Ma3Uffo30oyMw=;
 b=Kr9TwkWMkYgi4eKi3m3X2+VdM293ZjbO/K6CvOBnU6e8VSicjliPyc+0DK3uP3YanOac98YaXM7of1qc2ZTsN/UBHwOXsT15N/VGac2REYaxpWrd3YRN1xLbvvK7M7/yGKQ+q0hOuuN4LOUOynocy9TKdNzkgcXz7/hMHKIiQlo=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 02:04:37 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 02:04:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset v3
Thread-Topic: [PATCH] drm/amd/display: Fix deadlock during gpu reset v3
Thread-Index: AQHW6P3h8nXffpvMbUueJIw35sUFz6okK82AgACjClA=
Date: Wed, 13 Jan 2021 02:04:37 +0000
Message-ID: <CY4PR12MB1287EC7EF636A32149A108D4F1A90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <MW3PR12MB455434CFD3336676DB64B077F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
 <20210112161326.1159175-1-Bhawanpreet.Lakha@amd.com>
 <f1c18246-cb0e-bb6b-d69d-76f88852fa3c@amd.com>
In-Reply-To: <f1c18246-cb0e-bb6b-d69d-76f88852fa3c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-13T02:04:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=993767de-9ec7-467f-aa9c-0000a12f6b0b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-13T02:04:35Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 823355d9-c64e-49da-8298-0000b364511a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcc81114-4723-46d9-3621-08d8b7679472
x-ms-traffictypediagnostic: CY4PR1201MB0184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01843C32B85321A4D17DB77AF1A90@CY4PR1201MB0184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mFYuAyO7HqxWfce+jeAOct5Swb+cPL+VDAZz8onYnBai4QTTMduLeww1XBG2mlynoO2Z8KEhny0cNA0DdVRDOYr2lj2xBuDZaX/XY5BJKywDtV7w60pa2uh6/BlTv9291su0vCxp+Ui4Re8gYvcgneuJ75Dy//lRySuKgppgPAdOt7x6zEKueBhqg9BR8AloH1Mev5POEHUWidy0NkqJgk5oP49JHSVV1Qo1k6P43Yi2oQI7LZw306uttRS8yGnBLdSlIuh5YOBCbdbhoLvMPfEhBFBvcgO+yJTh/RXpc4DNUAm7/OmddH5tjwkeAWTXGbOdgRa0C5fHIFRCUuR+VvQ67r4zrP4mDkXY+sssotvI6a6MDlSQ9dCm8Rj+BH9VXvdEmS33w/A2K5TBPdjFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(66476007)(478600001)(8936002)(26005)(86362001)(316002)(55016002)(66446008)(2906002)(66556008)(64756008)(33656002)(8676002)(186003)(4326008)(6506007)(52536014)(5660300002)(53546011)(83380400001)(6636002)(76116006)(71200400001)(9686003)(66946007)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WnFsN3JmdkRmMzM0YlRrT3V3SU1vY0hVbkhVNmcxTHU1Nk53WmM3TzR6OWFI?=
 =?utf-8?B?NEl5c3hzMnMvd2ZtZlpWVm9WUmkrSzFHWW9HczA1MjR6QzA5WFdyUFNCYStm?=
 =?utf-8?B?Nk9nUlVYQzBBbjAzL3U5NFgxWWRyR0pVTStxL09wM0wxc1VJQzlQcTVCVUov?=
 =?utf-8?B?RWZjVmVETXE3YVJkMzVQWWFkMi9reEczZTRaWDA4R29Fak5vZ25sV0RUVmx2?=
 =?utf-8?B?ajhqVlBVOHRsbXpxRmxuc3NaU2pNWFh3RmhQdTd4UFVpUGdHVldacU5Ga3hk?=
 =?utf-8?B?K1R3VHBNNENSV1p3TExoZUoyeUNEQVl2NzFISnBpdEpEdUg3NGJETnZmWXJQ?=
 =?utf-8?B?MmpNLzMvMDhKaWlUY3VDbVVQbDVMM0tqN25MejRmNHZ4VEhSZXMvK2ErczQv?=
 =?utf-8?B?MEMyUkw4KzU3Smw2MXdQOWFWTFVaTndqQkV5U2RzbmVYa3FsL2kwclM3aUZn?=
 =?utf-8?B?a3U3VUJNbldFS2xvMmNrQUMvNitkOWFJcXZMYUlYajBCck5RVk96MzFieHRO?=
 =?utf-8?B?N1BUMjJHNjBlSVM5N3crVFJmaGNRd1NCM1RBTXE2SkUwY2s1aVFORWNoZEgx?=
 =?utf-8?B?aDNDL242RGU0NlpzZHdiaDlyVU44Zm84RUxUUE1mUVN5Z2UwREtqMEdIWm5s?=
 =?utf-8?B?M2FQZlp1T0tLSzVmUnF2Y0hmMTg2UGQ2NHNvWHNmaVh2ODRvOU1pLzFXazRK?=
 =?utf-8?B?MmNtS2k4MGlUaGpYSTZVNFYvNjhzWi85SktYYzh0YW1XeW1NcGl3Y29ndjVm?=
 =?utf-8?B?QllTeVcrWExlK3B2RUFKbmdPZmhPUFlVa2h3a04wUzJPSElnbGk4UC9vRHJN?=
 =?utf-8?B?ZHBScDdBRVdhMjBxWDR3VGs0aXUyYTNaSk9BMnhKS205TzBsSmJEajBlZktW?=
 =?utf-8?B?dUZpMnU5QnRBVnFWS2VoMWU5ZVgwdlAwUVNoR2dlWmJkTU1hRlhCeG1wNFdX?=
 =?utf-8?B?emI4aW1FY1FmUFB1eXVuVm5IWXF0ckNXYndJR3VhY21ZeEUrbzJlTWtPbTlz?=
 =?utf-8?B?eVozZnJ4V2dTZHpKNktRV0lQVEk3dXFFWVFtUUZnSWVJU0lJZ3FmczV6WjRn?=
 =?utf-8?B?MWdlWFFRMzFtL3BLbTJzdGVOSTJCVklLTXgyQ20xZnY0UmFJYXdzMkpjSG9V?=
 =?utf-8?B?NW9mUTdTY1dXTHBCOHBPY1FaZFFSdjB3VjNTOTlid250bGRRMklVeTZCT2h2?=
 =?utf-8?B?ejBoR3VYS1dIUWlZVzQ2TnRKZDRORGd5Q01xTUdBYWNOZlliOFFnUTdLN2Vy?=
 =?utf-8?B?ZkpPMm5jR2ViLy9LWFdlWGV1Rk4rUjBab3pEUlByaXNxM0cvWkQ4TjB3Mnh2?=
 =?utf-8?Q?guNiGzCDQs+3j4d9S0nksyO1KijRmaebJN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc81114-4723-46d9-3621-08d8b7679472
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 02:04:37.2073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soEPJWLvtUXthLYdYSSdiB9+hkBn7gST9MMX4GTmsEF0FPjGdryxcpuTeqlcihZsb9QvgCXX7PE45slUrjGOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com> 
Sent: Wednesday, January 13, 2021 12:21 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset v3

On 2021-01-12 11:13 a.m., Bhawanpreet Lakha wrote:
> [Why]
> during idle optimizations we acquire the dc_lock, this lock is also 
> acquired during gpu_reset so we end up hanging the system due to a 
> deadlock
> 
> [How]
> If we are in gpu reset:
>   - disable idle optimizations and skip calls to the dc function
> 
> v2: skip idle optimizations calls
> v3: add guard for DCN
> 
> Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for 
> linux (MALL stutter)")
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index de71b6c21590..82ceb0a8ba29 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1816,6 +1816,11 @@ static int dm_suspend(void *handle)
>   
>   	if (amdgpu_in_reset(adev)) {
>   		mutex_lock(&dm->dc_lock);
> +
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		dc_allow_idle_optimizations(adev->dm.dc, false); #endif
> +
>   		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
>   
>   		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false); 
> @@ -5556,6 +5561,10 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>   		return -EBUSY;
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	if (amdgpu_in_reset(adev))
> +		return 0;
> +
>   	mutex_lock(&dm->dc_lock);
>   
>   	if (enable)
> @@ -5572,6 +5581,7 @@ static inline int dm_set_vblank(struct drm_crtc 
> *crtc, bool enable)
>   
>   	mutex_unlock(&dm->dc_lock);
>   
> +#endif
>   	return 0;
>   }
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
