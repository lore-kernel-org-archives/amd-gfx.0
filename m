Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF4C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 17:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DD723DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 17:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DD723DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D156E435;
	Thu, 10 Dec 2020 17:50:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29556E435
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 17:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYQaO4gL8lrGt0SCZrRD4XgZxqDID0wUkYNACjzcaJ2+Qx6cZLQdKbVt8KA1vrEd5bQsmsxYc4nuttuhEclloSMQiyJEtmQbVUHq3qVmOn+yeFhfnEs9jV4xCIb+W7IzKS62MgdetMU6QyWqVmBaVYRbvd+Dfd11jcgaNbrQeTW26diF8v8fKdwCeveGWdnx0zLB+62Kme8jjwSD1A68Ap8tKVjvUvwpuqRMD6RWTVkrCWEzk+zTinc+ibQaDxzjGH8D+NAn0Krgq6I+DV17jKi1iO3k65B1n7zPBP2U6lvvmdCW4AjDRggYhRU2kOmAj9fOq1A9iY4tWO6As5sc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8U/5eKACWxoZQF+dtWx+gAuJh8vS8h3GWzKpdqq5jU=;
 b=PkGwWsCC7yPFxa67Gu8nlLbpfUFZyMrSvwlIDuLWoV36DkHMQe08FGB2S1D6NosRvnMdXO0UdmlSsHSYgVH5w+xkfbB/5LTT1MtHPvtc/LUrRJhE66WxXaLD+pgBH7IqOifL2KrKW6Qvyu4oCzlABMcMzp8YJQy3A3NJWCnOPP0fbCtsMzhHy5m+XtwcSowRG1wdkF/Fni8gIhAy6isTLS8tQ4NCFJJRqODrOXC1tOf1W4PR6Z0qgVvtACv1Y4YvBMUFBa+Bf6Mv5z3QGeoFXW5mcwWer4P6ylh3sDki0//m3U7KUtdifzp4yKm86JyTkiPcO+1zUDfiRtl2AooOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8U/5eKACWxoZQF+dtWx+gAuJh8vS8h3GWzKpdqq5jU=;
 b=yf1q7Qfnn6afuq7kvPGBR551gxK703F9QkrJkbiTGenpd9rpXtOYap3VbwLExEWd2hd1dCHA1mJpIFb2gd6jogB1gloI04N4DPfnW3StH852sWYPqfjREwl41/7kc2nQcogye8C6lPRy69wURln+KsKHKRXpq5qzK8S2w2xOE+k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1939.namprd12.prod.outlook.com (2603:10b6:404:107::12)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 17:50:16 +0000
Received: from BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c]) by BN6PR12MB1939.namprd12.prod.outlook.com
 ([fe80::f8f7:573f:9fae:e40c%11]) with mapi id 15.20.3632.021; Thu, 10 Dec
 2020 17:50:15 +0000
Message-ID: <f102763220b62e64e377e84a2e8d354bb8d89173.camel@amd.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 10 Dec 2020 12:50:04 -0500
In-Reply-To: <9cc10157-d533-95fd-0f20-8bbc2db75a79@amd.com>
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-4-aurabindo.pillai@amd.com>
 <9cc10157-d533-95fd-0f20-8bbc2db75a79@amd.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0424.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::9) To BN6PR12MB1939.namprd12.prod.outlook.com
 (2603:10b6:404:107::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.195] (165.204.84.11) by
 BL1PR13CA0424.namprd13.prod.outlook.com (2603:10b6:208:2c3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Thu, 10 Dec 2020 17:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 519e3852-9509-4a76-a042-08d89d340cd8
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0017B7260E04F5B491818B428BCB0@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbvAqvgSWn9oeWcTm4PMaJbq+y9+sByGVTn6kUAv+jzyjt/YC9Q7yvwqmC8Qswzd4aCTVYjhvc2sbdEEUHhXVq0bEr+XlNyJMFq3BRgQy1SL0qUOdaS2DQTbhRx0jNEpZawrkF+Vqzp/00cjYF25uz8pLU2b+5egYemFsaE35OQCK75buyXmfx1hE5w6W4Q3rT28YTu79w+YjG6ttVoeoMJpgA4B57YO5VEXASyTqOYYYHaBs0MpXlqVFSNTYMC2o0JiS3Lp2SmSkfN+3xfpRP5pfzeQcxGHs2lONoC/NcwtwL3zLoL5oi+n1THBRz1CAxZsFSfzithK4mvy8E1hE/M/+p7u+nPdjMyNAbkAzK7nKP4L604q8595XS4y+BD+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(26005)(53546011)(86362001)(956004)(4001150100001)(6486002)(2616005)(44832011)(34490700003)(66946007)(186003)(8936002)(36756003)(16576012)(2906002)(508600001)(6666004)(4326008)(83380400001)(33964004)(8676002)(16526019)(21480400003)(5660300002)(66476007)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cE1JdWM2N1pJSUlXdXBSOHlSS1c5ZkJHWTlmSGZiZmN0ZmZwdk1LNmpWQllQ?=
 =?utf-8?B?ZXhEaktVd2xZWENxQmhMQTJWOUFob3ZPZklhdGpjMzlXVXduR0lsQXl0c1F5?=
 =?utf-8?B?SHhlN3EyUFdWNUI2dWZmV3AxcnhnQ29mWS9XMGd3MHJ6L0xYUzB1ZzRYMERO?=
 =?utf-8?B?Q0p6K1YxY3dIZUpZRzNLQ00yVkZwbThOWTBMcllCN2JmRXJINHg3cXhrOUxv?=
 =?utf-8?B?ekNRTWFISWhjY3VzUFlESzM4VkJBWk1uWGVBQVF5UzlaMEp2ZXpVdTN4UXM1?=
 =?utf-8?B?ZFlyRXFDd0o0L1lyalNqeVhjOWNadTR0cUZodE02Rlo3ZFU3UVdnWUFNdllh?=
 =?utf-8?B?Zk02NVFqMTVpbGZyd3lkT0hUTmMyZlNmektEM3FOS1ZkdjJTTTRueGpNZ0NY?=
 =?utf-8?B?VmRLU1V5Rnc5TklZNUY2YjhOREowd1EyZWkwRDZiOXUvZkZaYndtbW93Qm5y?=
 =?utf-8?B?cFFUV3h5N25LUnFHSFkyV0x2aUNWWFhXM0dPMjBVMHVibEM5a0lZK21WQ3V3?=
 =?utf-8?B?dHgxU0dBZ09pN0ZiVE5hUWJteWNOMUdyTVFmOCt0YmV3NUV1cm9leXpHUDd5?=
 =?utf-8?B?Z3NXejlwbkdHWHB3a1pzdlQ3VWd3WVlRaCs2UlYwNXFaQU05d3VqSFE4NFdx?=
 =?utf-8?B?RDBGeTBEbzFGekRDSmVDRGJIZ2Jyd2I4eVIwZ056b1NZWllTMmcwcFZCVndX?=
 =?utf-8?B?RHJISGVucjlqTXFlRnYzdDhaSlpRbUJmT2JkeEVlRTdCclQwRzN3N2wxdzRM?=
 =?utf-8?B?OE4yL0F1azNHNGNXRGhVY240UGVUNG1VOTlncCtNUmQ0UUJBaUdseUhnQUVK?=
 =?utf-8?B?bEhJdDRCNCt3WDlmcm1RYlNUYmVESThJZWJ4WXQ2bUhGREFzQlhRNkNDTEtT?=
 =?utf-8?B?UDFLMzZDa093OXJ5MDZqMHgyUzUwN1ljRnk5aWpwekwxc2dBdUJaYVBuMVpx?=
 =?utf-8?B?aTJ3VFV6ZXo0VjUwSDVGSUwyb0cySFMvemRFdmFiK0VWWUI2RVgzYWgyMXky?=
 =?utf-8?B?MlVtcmFHa2E3c041Mm10S0NVNXpvMU9Sb0lZb25TMnFJOERaa3lrZldNTzla?=
 =?utf-8?B?UzNEZk5SS1BTQzMvNDlGUTAyaXNqVFR4LzhadEVYVHV0TjgyY2d1Qml4NGwv?=
 =?utf-8?B?dmRlVWgwTnpkSzVoQnZrd1ZTZDRVN2VjTkw2RUhYNkw5WnJocTVMcEJuN3pi?=
 =?utf-8?B?NExaQlBKM2M3Uldjc1ZlUWpETnRqTkNZRDBLdWFYQjNzbHAxT1UxbnVxK1M4?=
 =?utf-8?B?cFpUUXJmKzltNVdHMDlGMUhnR0ZtZ0doSFlqeXdHTENkb1dMaWpSQ2JFNFo1?=
 =?utf-8?Q?xcipgXSZ/yvUc6W/OzuqNfGSQvAL4nWYiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 17:50:15.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e3852-9509-4a76-a042-08d89d340cd8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2luNyCL76Gw/dr/JTOiTPw04RHUz2a349dtdhiEeTIYUNKY0bbM/UuSC+YvVgASIUze+iRi9CxDULSqVwxiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, wayne.lin@amd.com,
 alexander.deucher@amd.com, Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: multipart/mixed; boundary="===============0952427456=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0952427456==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-tBFn2fwC3ss4rkV3BjGe"

--=-tBFn2fwC3ss4rkV3BjGe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-10 at 18:29 +0530, Shashank Sharma wrote:
> On 10/12/20 8:15 am, Aurabindo Pillai wrote:
> > [Why&How]
> > Inorder to enable freesync video mode, driver adds extra
> > modes based on preferred modes for common freesync frame rates.
> > When commiting these mode changes, a full modeset is not needed.
> > If the change in only in the front porch timing value, skip full
> > modeset and continue using the same stream.
> >=20
> > Signed-off-by: Aurabindo Pillai <
> > aurabindo.pillai@amd.com
> > >
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169
> > ++++++++++++++++--
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
> >  2 files changed, 153 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index f699a3d41cad..c8c72887906a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct
> > amdgpu_display_manager *dm);
> >  static const struct drm_format_info *
> >  amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
> > =20
> > +static bool
> > +is_timing_unchanged_for_freesync(struct drm_crtc_state
> > *old_crtc_state,
> > +				 struct drm_crtc_state
> > *new_crtc_state);
> >  /*
> >   * dm_vblank_get_counter
> >   *
> > @@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const
> > struct drm_display_mode *src_mode,
> >  static void
> >  decide_crtc_timing_for_drm_display_mode(struct drm_display_mode
> > *drm_mode,
> >  					const struct drm_display_mode
> > *native_mode,
> > -					bool scale_enabled)
> > +					bool scale_enabled, bool
> > fs_mode)
> >  {
> > +	if (fs_mode)
> > +		return;
>=20
> so we are adding an input flag just so that we can return from the
> function at top ? How about adding this check at the caller without
> changing the function parameters ?

Will fix this.

> > +
> >  	if (scale_enabled) {
> >  		copy_crtc_timing_for_drm_display_mode(native_mode,
> > drm_mode);
> >  	} else if (native_mode->clock =3D=3D drm_mode->clock &&
> > @@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct
> > amdgpu_dm_connector *aconnector,
> >  	return m_high;
> >  }
> > =20
> > +static bool is_freesync_video_mode(struct drm_display_mode *mode,
> > +				   struct amdgpu_dm_connector
> > *aconnector)
> > +{
> > +	struct drm_display_mode *high_mode;
> > +
>=20
> I thought we were adding a string "_FSV" in the end for the mode-
> >name, why can't we check that instead of going through the whole
> list of modes again ?

Actually I only added _FSV to distinguish the newly added modes easily.
On second thoughts, I'm not sure if there are any userspace
applications that might depend on parsing the mode name, for maybe to
print the resolution. I think its better not to break any such
assumptions if they do exist by any chance. I think I'll just remove
_FSV from the mode name. We already set DRM_MODE_TYPE_DRIVER for
userspace to recognize these additional modes, so it shouldnt be a
problem.

> > +	high_mode =3D get_highest_freesync_mode(aconnector, false);
> > +	if (!high_mode)
> > +		return false;
> > +
> > +	if (high_mode->clock =3D=3D 0 ||
> > +	    high_mode->hdisplay !=3D mode->hdisplay ||
> > +	    high_mode->clock !=3D mode->clock ||
> > +	    !mode)
> > +		return false;
> > +	else
> > +		return true;
> > +}
> > +
> >  static struct dc_stream_state *
> >  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> >  		       const struct drm_display_mode *drm_mode,
> > @@ -5253,17 +5277,21 @@ create_stream_for_sink(struct
> > amdgpu_dm_connector *aconnector,
> >  	const struct drm_connector_state *con_state =3D
> >  		dm_state ? &dm_state->base : NULL;
> >  	struct dc_stream_state *stream =3D NULL;
> > -	struct drm_display_mode mode =3D *drm_mode;
> > +	struct drm_display_mode saved_mode, mode =3D *drm_mode;
>=20
> How about shifting this definition to new line to follow the existing
> convention ?

Sure.

> > +	struct drm_display_mode *freesync_mode =3D NULL;
> >  	bool native_mode_found =3D false;
> >  	bool scale =3D dm_state ? (dm_state->scaling !=3D RMX_OFF) : false;
> >  	int mode_refresh;
> >  	int preferred_refresh =3D 0;
> > +	bool is_fs_vid_mode =3D 0;
> >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> >  	struct dsc_dec_dpcd_caps dsc_caps;
> >  #endif
> >  	uint32_t link_bandwidth_kbps;
> > -
> >  	struct dc_sink *sink =3D NULL;
> > +
> > +	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
> > +
> >  	if (aconnector =3D=3D NULL) {
> >  		DRM_ERROR("aconnector is NULL!\n");
> >  		return stream;
> > @@ -5316,20 +5344,33 @@ create_stream_for_sink(struct
> > amdgpu_dm_connector *aconnector,
> >  		 */
> >  		DRM_DEBUG_DRIVER("No preferred mode found\n");
> >  	} else {
> > +		is_fs_vid_mode =3D is_freesync_video_mode(&mode,
> > aconnector);
> > +		if (is_fs_vid_mode) {
> > +			freesync_mode =3D
> > get_highest_freesync_mode(aconnector, false);
> > +			if (freesync_mode) {
>=20
> As the freesync modes are being added by the driver, and we have
> passed one check which says is_fs_vid_mode, will it ever be the case
> where freesync_mode =3D=3D NULL ? Ideally we should get atleast one mode
> equal to this isn't it ? in that case we can drop one if () check.

Yes, thanks for catching this. Will fix.


--

Regards,
Aurabindo Pillai

--=-tBFn2fwC3ss4rkV3BjGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEjxfKIKECTdteDMVnC/mGJHAirekFAl/SX8wACgkQC/mGJHAi
renUMgwAxeKuFQ+oRsgjQXP/pmJYDSGIqq3rU+g3X7Mb+LmdSxoSLwA0XX7v4KvZ
RMX47e2knSVgwOyPVbfhtFuCTdjlgGKZlHry94lWzxqIM8Slbr+CGAU9OZCkSeKf
ViXYE3MGLwj8PbTuE0YmzAbKmFS/YtrvbdukPB3uO+7Snht2adc89oaKNNYacTK5
ndAGBkfzssckA5KySynIyScWcQGiL8GaAPp7mxb2dvrmT4HvBU19OGhdp2TUy6Sf
5JYJeMkOCTHhg2USDGxzClAPzX0c8nYIHYXnHmGdr/q4lryhfND/gaOAwcODpYF6
iG2VbJY2qHhDnxXpnvPgHVOVdFDkDSRkQWeZ09VhqVsR/A6mQXZ0glkN+U9solJS
FkJwpuYAb/xb4HWmTAPYQRuZLTUu/6uRT/AkCGZMLO6o4Hylh4aifpR38Sop+Ij8
9+1mfKGFjT4/++Ldd2TvTrs/yFaM1pGa9+nSPfsHSrkV/KoNJ4DIjLyZReZNTu4j
6KGflQTq
=3B+8
-----END PGP SIGNATURE-----

--=-tBFn2fwC3ss4rkV3BjGe--

--===============0952427456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0952427456==--
