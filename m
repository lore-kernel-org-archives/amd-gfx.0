Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 16:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299362067B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 16:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299362067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7146EAAF;
	Thu, 10 Dec 2020 16:56:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A947D6EAA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 16:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTGr3Mnv7/WFkgAbTZ6pZFj0yKInPPxd7znKYJP0mIQ6nzgdFL68EYjli7WWIZ4nVaaRHCOMi9xnrcIY8/E/qKEalHfaqsEuUGXSwAcDPIHDR4p339Fa8yFoDZhiis8KDPnheyFps96mzUcyt32XKfK3+6/uZJUDy1MycuEkKDxvjFVapj3GA2M/1f8drUlhyYEQoiWPSWFB6pJDbgni3vrWYbXUPw4iynWm0e4/E+9fq5+yp1QPouoG+njOtugWLHs39eGGAuew1BQJvjz/pqpOt/DvaBA8iysHJa8bDoGQqHJQaaYpUjF3xtrkhF8Euj04I/FRlceoVjIHMntQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAXxR+aUHxSRYIdtM21NzmedOIzcH4j4jjQjO2rZKhI=;
 b=BywMWVhEO6uQnkJhUULIew3cRWwE3U7cHLp1Taz3BGuAl0SpqmXtJWLj4A38LednAQCOUAuu3JSkQOS7zAQq+mqNWOoFELlhlrHfvEgpizDtaWW48JjokTXoNsDiWpVkadt9V3tw9aKokc79zr/6XjKQIe7PmTfyRBNrqWfi3MCpRAA2rufnkEzy8diogqUXCYy8Y7eNjCkn34j0w0iV2AcTsksTLAd9OwagC7jtK+l7mpbyF2HClyQGap2YYSINdIW14TMWqiP262byNtM2fcbgXiVyE/oVKEt1VfykEgvzikgpEh9HCrZk9cytYX2Kcn+lz9IQr00bajsV+g0YIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAXxR+aUHxSRYIdtM21NzmedOIzcH4j4jjQjO2rZKhI=;
 b=tdLZ5GN+M3yf/9qFFKiITEKTbeKVIXU6BaUSn0/zzfMspB/ggQIcrWrKRJ2q4Ds9Hvg4j4leiKWdkp3RDObrLHl4iiCLywVnskH47QWpcgig13nhU6i34qsKrErtF4EKuT1UXqWt8d854+fPU2FZZASbpQ0qw7A51yduCw5Gj94=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12)
 by BN7PR12MB2739.namprd12.prod.outlook.com (2603:10b6:408:31::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 16:56:41 +0000
Received: from BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c]) by BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c%11]) with mapi id 15.20.3632.021; Thu, 10 Dec
 2020 16:56:41 +0000
Message-ID: <4d4201861b13b96d9f2c413ca24f73ba32941ad8.camel@amd.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Add freesync video modes based on
 preferred modes
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 10 Dec 2020 11:56:15 -0500
In-Reply-To: <cb537244-e286-4cce-9269-2ead18f3ec3f@amd.com>
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-3-aurabindo.pillai@amd.com>
 <cb537244-e286-4cce-9269-2ead18f3ec3f@amd.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:408:fb::35) To BN6PR12MB1939.namprd12.prod.outlook.com
 (2603:10b6:404:107::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.195] (165.204.84.11) by
 BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.15 via Frontend Transport; Thu, 10 Dec 2020 16:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 724d3f06-de6f-48b6-742c-08d89d2c9156
X-MS-TrafficTypeDiagnostic: BN7PR12MB2739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB273910A8870D03736B8831DB8BCB0@BN7PR12MB2739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyO6qx9DqYlqjQWEH1YY+8OVkM40cVMbDq5UoVDFEpsBC5Yy+sdhVEFzC7FLVDjHAea6102MHoMSthCWAAMgbB3Iat4VUs4u+AY0/wiKiFoCfUTIxZ/5CUBDxG5CHTrZJCpAZNKSr8Fu9SqWwvhN4odTpeUwIfVFQY0uVKyPzJXkMF4l2OGNRuAFRFH6YVE5cvQi57MAId67iKXGPMxfj+cntAk9/WtkyKggDDb3/WgMzbfbMwdnUhjBia5qJf/x9D1WBM5rCGy3KnNenFllgWHW1bj4EqJ4U3tI9mJ449Loa0tNZlWVhuqQZK3V2NZCEPW9aw6esbPdMmauqWPRba63Em1BswN+Qd0sXF1MGvxyvCAEnvENTwGlZETh49WK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(186003)(21480400003)(83380400001)(2906002)(4001150100001)(34490700003)(36756003)(44832011)(8676002)(66476007)(53546011)(66556008)(26005)(16526019)(86362001)(66946007)(508600001)(956004)(33964004)(2616005)(52116002)(8936002)(16576012)(5660300002)(6666004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djRVbE5yVER3UW9XVGVtRmFkYjBRSTZEL1R4NXJZMUVEVHl4S3pLeEhMMjNX?=
 =?utf-8?B?bytzVlNlTGxZdk1HMldDNmFseE5DT3FCYXd0SkZNemxpZFQyM1dXZ0IyYlZN?=
 =?utf-8?B?ZDNCaW1rdGlSY0EwbS8vNFp5Z0hKZnlyWURVS255aUZwaGpncWczVERFTm96?=
 =?utf-8?B?bHdBM1YwRmdwdkFBZi9sNSsyelRpQ3hNZGJQL0hBV3hseXI5U0NKbTVRZ1ph?=
 =?utf-8?B?WGJsTjNIL0xobm1NazA3L2RCYnNud01DdXozbFdpemR6L0JrZzNmRU54NU00?=
 =?utf-8?B?RUhvUjhBeE1LaGkrRmIrZFU3UXJoVnZDNlI1NVhKMXllSGRDakVoWmN2d0Vx?=
 =?utf-8?B?UTkyVzZLcHh6ajV0T1Y4RmlndHhSODdQdE9EeTFIcDRjaWNjUmJXMEZidElW?=
 =?utf-8?B?U2xvU2NOQnczc3pPd2xkVDdqazBxMnFzM0R2cVFzalZGRU9RelFhZTQyOEtP?=
 =?utf-8?B?aXQ0OUZOWUpoUmZzK2Qvbkp0d1A5a2trUm9lL0xqS3dFY2hJaGpWYVBkSGhw?=
 =?utf-8?B?UDNEcWFuTkoyMlR0NW5DSTIrL2crVGh0QlF3Zld4L3Vla3BBRy9oZTdyaTd4?=
 =?utf-8?B?UzF2ZDA5cHJNVGVsdTBudVBqS0hJOWZTVHVGbklsOTM5OWZsa2NyMnM2a0l6?=
 =?utf-8?B?dUxIMmh1RFZCaHR3OG9XL1NqLzJrb2JkR25oWDV5cnNINVJ6Wlc3Wmc0cTJT?=
 =?utf-8?B?ZDdLL295ZFdlcEZTckJjSFp3WW1DZG1ka1VYQUxJSnRKa1JXb01Udm9MVEZV?=
 =?utf-8?B?MFhYWUsyNVNYdDV3OFoxV0s0Q3lwMkF4MVYzelNnWlUrNWtFMGVjdnIySC9s?=
 =?utf-8?B?djVEZXltbEo0aTZmV2dqdXhodUNQL0FoTXpsdW5TaDNHSDdQUEdBNWJkanlG?=
 =?utf-8?B?T0tBYlBsVjg2K0JWK050anRYdHpUNWpBNmkzNXFvODFEQVFwbndNWXdUTzZz?=
 =?utf-8?B?dlNZd0pTZGg3eXB1Um9wUHZEYXlHZG9nWHNxdW9JNW9aTXluaDNmbTU2Z2JV?=
 =?utf-8?B?R3puUzl0K3lmcFRCVHErKzZrcnd2UWJzLzNKd29LcDEzZGlTQytJMEF6Wjl6?=
 =?utf-8?B?SWEyeEFSZEpzdTdMRmtCd2FIUFJ2TGowdzQ0NlM2eitDYmZPbFZ1bEFNWXlr?=
 =?utf-8?B?cWZ3REliRTFYc3R3dkhvRHpNbnNCeG1BeUNsUWRWaHE3YnZxbkpRV1B1K2J1?=
 =?utf-8?B?L1l6R1lOT2RWLzdBd1l0MkxoMTNQckp3YjR2YlllbTI2UlFHdnF3Wmh1d3dC?=
 =?utf-8?B?TEIvSkFmMTBUeG9PVmFicG9NbUNReXVzdjJYeElvRkpETjQ5UTNkY0V5Uk5P?=
 =?utf-8?Q?IvzS1NX64xIRzjIc6mFrfl6cY/aC2G1dP5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 16:56:41.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 724d3f06-de6f-48b6-742c-08d89d2c9156
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPuLG3QH+mpwRwtBWWTOh7PN9sPV+nZz2DioYLMM+xUgp/PHX4KtwYeEohSs7takbSrIRKziH9vn4SIi9awcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2739
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
Content-Type: multipart/mixed; boundary="===============1359143592=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1359143592==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+lCKp2Wb0ch4lsYPMiQt"

--=-+lCKp2Wb0ch4lsYPMiQt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shashank,

Thanks for the review. Please see my inline responses.

On Thu, 2020-12-10 at 18:07 +0530, Shashank Sharma wrote:
> Hello Aurabindo,
>=20
>=20
> On 10/12/20 8:15 am, Aurabindo Pillai wrote:
>=20
> > [Why&How]
> > If experimental freesync video mode module parameter is enabled,
> > add
> > few extra display modes into the driver's mode list corresponding
> > to common
> > video frame rates. When userspace sets these modes, no modeset will
> > be
> > performed (if current mode was one of freesync modes or the base
> > freesync mode
> > based off which timings have been generated for the rest of the
> > freesync modes)
> > since these modes only differ from the base mode with front porch
> > timing.
> >=20
> > Signed-off-by: Aurabindo Pillai=20
> > <aurabindo.pillai@amd.com>
> >=20
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 197
> > ++++++++++++++++++
> >  1 file changed, 197 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index fbff8d693e03..f699a3d41cad 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5178,6 +5178,69 @@ static void
> > dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
> >  	set_master_stream(context->streams, context->stream_count);
> >  }
> > =20
> > +static struct drm_display_mode *
> > +get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
> > +			  bool use_probed_modes)
>  the function name is confusing, this function has nothing to do with
> freesync. Probably drop the 'freesync' from the name,
> get_highest_refresh_rate_mode or similar ?

Will do.
> =20
> > +{
> > +	struct drm_display_mode *m, *m_high =3D NULL;
> > +	u16 current_refresh, highest_refresh, preferred_mode_h,
> > preferred_mode_w;
> > +	struct list_head *list_head =3D use_probed_modes ?
> > +						    &aconnector-
> > >base.probed_modes :
> > +						    &aconnector-
> > >base.modes;
> > +
> > +	/*
> > +	 * Find the preferred mode
> > +	 */
>  Single line comment should be in /* */

Will do.
> > +
> > +	list_for_each_entry (m, list_head, head) {
> > +		if (!(m->type & DRM_MODE_TYPE_PREFERRED))
> > +			continue;
> > +
> > +		m_high =3D m;
> > +		preferred_mode_h =3D m_high->hdisplay;
> > +		preferred_mode_w =3D m_high->vdisplay;
> > +		highest_refresh =3D drm_mode_vrefresh(m_high);
> > +		break;
> > +	}
> > +
> > +	if (!m_high) {
> > +
> > +		/*
> > +		 * Probably an EDID with no preferred mode.
> > +		 * Fallback to first entry;
> > +		 */
> > +		m_high =3D list_first_entry_or_null(&aconnector-
> > >base.modes,
> > +						  struct
> > drm_display_mode, head);
> > +		if (!m_high)
> > +			return NULL;
> > +		else {
> > +			preferred_mode_h =3D m_high->hdisplay;
> > +			preferred_mode_w =3D m_high->vdisplay;
> > +			highest_refresh =3D drm_mode_vrefresh(m_high);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Find the mode with highest refresh rate with same
> > resolution.
> > +	 * For some monitors, preferred mode is not the mode with
> > highest
> > +	 * supported refresh rate.
> > +	 */
> > +	list_for_each_entry (m, list_head, head) {
> > +		current_refresh  =3D drm_mode_vrefresh(m);
> > +
> > +		if (m->hdisplay =3D=3D preferred_mode_h &&
> > +		    m->vdisplay =3D=3D preferred_mode_w &&
> > +		    highest_refresh < current_refresh) {
> > +			highest_refresh =3D current_refresh;
> > +			preferred_mode_h =3D m->hdisplay;
> > +			preferred_mode_w =3D m->vdisplay;
>  why do we need to save preferred_mode_h and w variables at all ? I
> thought the idea here was to get the mode with highest refresh rate,
> but same resolution, which is indicated in the if (cond) above also.
> I think we just need highest refresh rate isn't ?=20

Yes you're right. Will make that change.

> > +			m_high =3D m;
> > +		}
> > +	}
> > +
> > +	return m_high;
> > +}
> > +
> >  static struct dc_stream_state *
> >  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> >  		       const struct drm_display_mode *drm_mode,
> > @@ -7006,6 +7069,139 @@ static void
> > amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
> >  	}
> >  }
> > =20
> > +static bool is_duplicate_mode(struct amdgpu_dm_connector
> > *aconnector,
> > +			      struct drm_display_mode *mode)
> > +{
> > +	struct drm_display_mode *m;
> > +
> > +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> > +		if (m->clock =3D=3D mode->clock &&
> > +		    m->htotal =3D=3D mode->htotal &&
> > +		    m->vtotal =3D=3D mode->vtotal &&
> > +		    m->hdisplay =3D=3D mode->hdisplay &&
> > +		    m->vdisplay =3D=3D mode->vdisplay &&
> > +		    m->hsync_start =3D=3D mode->hsync_start &&
> > +		    m->vsync_start =3D=3D mode->vsync_start &&
> > +		    m->vsync_end =3D=3D mode->vsync_end &&
> > +		    m->hsync_end =3D=3D mode->hsync_end)
> > +			return true;
> > +	}
> > +
> > +	return false;
>  Why not use drm_mode_equal() instead ?

Wasnt aware of this API, thanks!

> > +}
> > +
> > +static uint add_fs_modes(struct amdgpu_dm_connector *aconnector,
> > +			 struct detailed_data_monitor_range *range)
> > +{
> > +	const struct drm_display_mode *m, *m_save;
> > +	struct drm_display_mode *new_mode;
> > +	uint i;
> > +	uint64_t target_vtotal, target_vtotal_diff;
> > +	uint32_t new_modes_count =3D 0;
> > +	uint64_t num, den;
> > +
> > +	/* Standard FPS values
> > +	 *
> > +	 * 23.976 - TV/NTSC
> > +	 * 24	  - Cinema
> > +	 * 25     - TV/PAL
> > +	 * 29.97  - TV/NTSC
> > +	 * 30     - TV/NTSC
> > +	 * 48	  - Cinema HFR
> > +	 * 50	  - TV/PAL
> > +	 */
> > +	const uint32_t neededrates[] =3D { 23976, 24000, 25000, 29970,
> > +					 30000, 48000, 50000, 72000,
> > 96000 };
> > +
> > +	/*
> > +	 * Find mode with highest refresh rate with the same resolution
> > +	 * as the preferred mode. Some monitors report a preferred mode
> > +	 * with lower resolution than the highest refresh rate
> > supported.
> > +	 */
> > +
> > +	m_save =3D get_highest_freesync_mode(aconnector, true);
>  A NULL return check here to bypass the whole routine below ?=20

Will do.
> > +
> > +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> > +		if (m !=3D m_save)
> > +			continue;
> > +
> > +		for (i =3D 0; i < sizeof(neededrates) / sizeof(uint32_t);
> > i++) {
> > +			if (drm_mode_vrefresh(m) * 1000 <
> > neededrates[i])
> > +				continue;
> > +
> > +			if (neededrates[i] < range->min_vfreq * 1000)
> > +				continue;
> > +
> > +			num =3D (unsigned long long)m->clock * 1000 *
> > 1000;
> =20
> > +			den =3D neededrates[i] * (unsigned long long)m-
> > >htotal;
> > +			target_vtotal =3D div_u64(num, den);
> > +			target_vtotal_diff =3D target_vtotal - m->vtotal;
> > +
> > +			/*
> > +			 * Check for illegal modes
> > +			 */
>  Same here for single line comment
> > +			if (m->vsync_start + target_vtotal_diff < m-
> > >vdisplay ||
> > +			    m->vsync_end + target_vtotal_diff < m-
> > >vsync_start ||
> > +			    m->vtotal + target_vtotal_diff < m-
> > >vsync_end)
> > +				continue;
> > +
> > +			new_mode =3D drm_mode_duplicate(aconnector-
> > >base.dev, m);
> > +			if (!new_mode)
> > +				goto out;
> > +
> > +			new_mode->vtotal +=3D (u16)target_vtotal_diff;
> > +			new_mode->vsync_start +=3D
> > (u16)target_vtotal_diff;
> > +			new_mode->vsync_end +=3D (u16)target_vtotal_diff;
> > +			new_mode->type &=3D ~DRM_MODE_TYPE_PREFERRED;
> > +			new_mode->type |=3D DRM_MODE_TYPE_DRIVER;
> > +			strcat(new_mode->name, "_FSV\0");
> > +
> > +			if (!is_duplicate_mode(aconnector, new_mode)) {
>  or drm_mode_equal here ?

Will modify is_duplicate_mode() to use drm_mode_equal.

> > +				drm_mode_probed_add(&aconnector->base,
> > new_mode);
> > +				new_modes_count +=3D 1;
> > +			} else
> > +				drm_mode_destroy(aconnector->base.dev,
> > new_mode);
> > +		}
> > +	}
> > + out:
> > +	return new_modes_count;
> > +}
> > +
> > +static void amdgpu_dm_connector_add_freesync_modes(struct
> > drm_connector *connector,
> > +						   struct edid *edid)
> > +{
> > +	uint8_t i;
> > +	struct detailed_timing *timing;
> > +	struct detailed_non_pixel *data;
> > +	struct detailed_data_monitor_range *range;
> > +	struct amdgpu_dm_connector *amdgpu_dm_connector =3D
> > +		to_amdgpu_dm_connector(connector);
> > +
> > +	if (!(amdgpu_exp_freesync_vid_mode && edid))
> > +		return;
> =20
> > +
> > +	if (!(amdgpu_dm_connector->dc_sink->sink_signal =3D=3D
> > SIGNAL_TYPE_EDP ||
>=20
> do we want the freesync infra to be available for eDP also ?=20
>=20

Freesync is enabled on eDP as well. There is no reason to block it.
Only requirement would be to check if the monitor actually supports
VRR. So it makes sense to remove this check. We are already checking
for VRR support below through EDID_DETAIL_MONITOR_RANGE.


--

Regards,
Aurabindo Pillai


--=-+lCKp2Wb0ch4lsYPMiQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEjxfKIKECTdteDMVnC/mGJHAirekFAl/SUy8ACgkQC/mGJHAi
ren0YQv/XDsIGslf29rRhb+G2EoqIznYZM9NVMi4XJmqOTNjGEvqTpQXLlRtMP+w
4RDGM1x3PGZa50a8Ng0xn5rMHJVpFfk17N5ao89A8GrbqPlVm6hihvoqXr+lBwN2
CdLwwrFxAtJ05u3qa/mnaK1p4htiNjQDo80sDpVzUtOrNkZszPbND501A3NmPH09
aVt2MiEAHUbveAVzx8AmfiEegcLzEZQ6Sxb0xEwvcDHX07J/UOtVRQgAjqVlQlnD
j3MRLRMsZbtQE5ZGbk+TTew9hLrwFxCQQIIrX2cjXUKR2hgvvK4wI/jKvU+TjEt3
+hULA1uiK6uwxNPeYXpXbknPYx1Lvfecp/DJ+gyqUHYKQqS4Oy78P7ISRq0OLnjZ
FiD5xk1IZw5qduupFFuVp6Cw0y+WdjYFV5XQssgwDDRctGHZwISqyojU14esU2dj
Vn+iz7ve0msqFEdN1WHC1+vCkYYVSb776DQ/h148e2alBZ9c0MDuMHQp61cwROp9
wm3wiGTI
=gcOc
-----END PGP SIGNATURE-----

--=-+lCKp2Wb0ch4lsYPMiQt--

--===============1359143592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1359143592==--
