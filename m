Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32160C3DA7A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 16:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF7A10EA7E;
	Wed, 14 Oct 2026 16:40:20 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2F010EA7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq3qi7zhXvjZV52HRur3bDZVJ0gMks1PWntNQheDg6G+IU8TxtGqtXE8c2dT18ukKed8z2pwUoLHhzjkTd+pt5Y6QIO4KQE3hl48vX6f7z5s4Z3XsKA323krY9+uhZX299tyOKA6aT9yLZ5NA0eTGkP4pkTVkQtk1tu7bqbA8MUYtn2+U5A7rK6/buiR7bz6xrEdxVLy3IlOovWBUpRPGdWWt6QO0zHFKl2MiVXJp1eGjdUJ4wd+6Vdc8kSmV/evDc4IYwwdrIXtzS/wihuY3+msRNZEEEggWGYYLDu1Acm7XB6NOrg+CMsTxwrkQTo4bcddO8Z0an/B8PkQQNUvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVnG1IGzndjw3SFKQVTTYIgY/SM2pmGY6gSAsbHTHQ8=;
 b=au4vl2uOqIU1PxEyqCrDOvbcD3UlXgMMKqixHs/YXRjOK4l33u7LVcM80kVD55YDL4LGEP2x/KPUaoQYtdGR6QQkGzEi0sHLu0TWUWjql3l4yAhplqQuGsKd3P9i0JRbW8JWE8tbJokTCY1LrbBv1Cxr1IsOMKxsnCcTX7O2rg5JzHZ3891i5UarFys3dTUeo2mT+/16m3tSIb2/hP5LXsZoVIPOJcBotmQCZwbggvKACYwWYXRBo8it4iZBR3zYfFBeB/uv4yESH5AjPAjaowIzotc/spFcfbBy27MDGyYd6wTfpB5LwY4j3A92RzfxNCOyIWd32WjK2U7FvI95HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVnG1IGzndjw3SFKQVTTYIgY/SM2pmGY6gSAsbHTHQ8=;
 b=u9T2+A6hokJ+UALCNX2VUWFa45Lh0jQxxBNiwvuwU9QClkAicr5Ik76JEOmEYx2BsbsbnqMk6qzeeXA/2RfES/NxN0uF9JEjtDRnTAQjMllDijJhPYGtzamaIhT75Aumy7FfggY+pEVuD781T+yJOl05YiACph9gSQW/p114ilc=
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::21) by SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:40:09 +0000
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766]) by PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:40:09 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add log when register access is blocked in PTL
Thread-Topic: [PATCH] drm/amdgpu: Add log when register access is blocked in
 PTL
Thread-Index: AQHdWyPWBkfFQ/deG0mViHQ+JLejfrb8XJEAgADiZDA=
Date: Wed, 14 Oct 2026 16:40:09 +0000
Message-ID: <PH6PR12MB3452249EB34BBC1CEAF52C31A2859D2@PH6PR12MB345224.namprd12.prod.outlook.com>
References: <20261013150147.2896846-1-kent.russell@amd.com>
 <CH2PR12MB4168A20F20C38E9732F2E57C9C9D2@CH2PR12MB4168.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4168A20F20C38E9732F2E57C9C9D2@CH2PR12MB4168.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T02:38:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH6PR12MB345224:EE_|SJ0PR12MB7458:EE_
x-ms-office365-filtering-correlation-id: fb5de2fb-c96f-4d5b-9c25-08df2a11cfa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 5sZVmGq/xbVXRbgcfsK9tkFUEs/lXTFzifEjGAbEr6wfw6yu+8/ViYBSeOw2ieSYi5aMVwFh/KsVxm/yTbb95KrAa9or3puwofApL+4l71Ti30xtJpyGr/4c4jfFNdoxaorGSeZ9IiEY6bQb9K0OhUnkjg0gUUCwhWvBf1FWpASaY5VZNfCoF3g6x/dEOySbfYCh9pz1fXfhtiftuol/qOMhWqEikL3uTSo5cyGBHaZiln/aFDNA29U9jyAj8/a1IRu8VuSxrNz9Q8lrf/bafwg523KbxO408y1/oJcivpi22AQ9/hE8i6bzh7bhkeGFeuK8nI8lNwHJxIEEIIRRbW9vUm+wUc4K4holHhdTZfJoO5atcELdhCuL5Jkqz7OUV+Qv64mq8EeILEo7aT/B0x0QVqKGrY8khvAs4KwPbzzYOLWr7ItALXwgq9ACBlMucwnb2CuEWHAeBi5BRJlnOvrvwsXSfiMLNXecp8vLpW2LrOWK3exll30q/mu4BFycZRnQomJc439jpbC96j8IauxTuBsXhyU6sH+bnPJLpNWqlMGfLQ5U7os0H6UqcVP/m7mS+7J40P5j3DQ3MkGOA/s0XeoNyYNxzGuU+uBnX2NgsXHcaFeH7tGSAJj7R70ey8QosCQHQ+tXXV1/WGxYYsnCD+aprvSoBoL+w8YM+YJ3Cy3xMJuJ8FKYFtsowm5ezbank6kbprvIP881JQPFeCeRWZqNM/75g1qv42Q9h2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH6PR12MB345224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GECFCf1mWbrVy0qJ4KObV6pQD/ANZlfrfrLf0VjiRKOFhC0Cy+CrDE8SAt7T?=
 =?us-ascii?Q?ppBxFjCEMFaM9X9yWKzfYlpQKHbog+N5YlZXjt29xLnHnKZgukC3tzphrghV?=
 =?us-ascii?Q?Ef0PujSX7Gv46ipny74kZsN5S8+L/wiT3TRO9OncEZTn7CbjVp1nlnlGrTJ1?=
 =?us-ascii?Q?5UdpMMb4zMQhyTZc7VochmrfYk5OdrMJl40UhfPw8GdWMd6YEjwUzj84vG6H?=
 =?us-ascii?Q?EJMfNBZ6hXDeLyI60P4st4MAQxJe1RXzyD+YDXN6EUvK7U6IYykStakHs/Ek?=
 =?us-ascii?Q?k7XCoElRUWFYncpDBj+LyMxrIforM/i6+KJ2EL/sMsy87AQGd6oyiKn5hstP?=
 =?us-ascii?Q?BOZUK4lpBq//qeAcVyxjfzBJGmA4b27+GkCjrTxiJKPQrJgn4vH+Q1JJuA3X?=
 =?us-ascii?Q?LsG1ptq/ObRced4PDuyaJy6Rc2g9CdqqB5nznHNHgrJ91jCpgLDLsXuXR+4k?=
 =?us-ascii?Q?Di9nXeouWWUx/28UuQAeuZbbfrcG1OVh9NZa/t4MAkHUtlEt8wk/YzPB9DKx?=
 =?us-ascii?Q?RmqMvenFfyc3xbJrCSBA1u5QxSbu7kbGxSnMHC1XRJFM2972C/n4OC0mAcDn?=
 =?us-ascii?Q?BIHFm0ZF2gGtQtfOFJ9SbGhUt/PW4dXaQTaRS1VpWxSGrKwFQGtz1le8fY6n?=
 =?us-ascii?Q?JZ/gaZ0vVzyhDRpxw0uKPY4hzqraqsQJXBHoYPlLN4vmuTXR3rTOoomQCNTu?=
 =?us-ascii?Q?D5LV/aN4xDXXT75YgjIJjLO/b9pFR7YjtVpr/sjoXuPqCNl+CkYjHp3dVAKm?=
 =?us-ascii?Q?TzTpqD1BDzTJFnM3gmNcI3knzyT6V0nFH4lkt0F3e8Cgudm2tUr4mW5EgLKK?=
 =?us-ascii?Q?eJ9+O9SO9mlCXzv2dVlspyka2iMICPOMiStgXkI3/AUCP0m0hVzLX+ADxKsY?=
 =?us-ascii?Q?64Ee9fleAWj349njSq1w2oUgfc/1fK1hyK6CEjf1dOAyPateUnEbfulffbah?=
 =?us-ascii?Q?/K6SiVdbT5Nn7YQhdcv5LlUF3s2PLbaC+qjwlVUBNbbfsQojjMSJu/VNKGAo?=
 =?us-ascii?Q?peG09bXWBHwCTJwj7Gc/hcWYHCwE26LUzGqlzE+B4nvwazKTKgkt+B90xfBV?=
 =?us-ascii?Q?VUwL/2YpFc70ianNy0X93iq6cVDbdXN/dxMEPc5j0K4wBx6tyIlMBsCuTyhm?=
 =?us-ascii?Q?jGJENBRSu3e0DVS6K7Oi+6JZnjNWRQHnodlI1Yz7FlKPIs8UQ5dehS1dNnuK?=
 =?us-ascii?Q?hnocioA8NKdjavSDmc5VgGdUNSFjE2W7HqydWF84DtMgBJbJtJAkAiAX7A4l?=
 =?us-ascii?Q?Ag+0k3OnfSFkTD9O18kqpgIyl4Y/fzo7rQT19kyFxTYGiilleAFh0oERDYsW?=
 =?us-ascii?Q?fGDulW7uyBPHNiJiE/U4+FzILvHjEBWsoLGB6bfOKa8HyqPQqUeMsCzO2KN8?=
 =?us-ascii?Q?CEcoKboKJXOrMBXV+/GhBPp8Iz6jiJkc3j5YRY1fMQSbS7PbQz6sn6jHUDxd?=
 =?us-ascii?Q?iUFWCgjzQL6GA2U+6NstaiIMNKK5pEhp7Gm4Cm5pw4BA8VvlFpR2JY3phT2o?=
 =?us-ascii?Q?Jk5Waci8e9bwX7VyIMOzgRToFMy9USFmAECqkMhDjudMEveWobvooFNnBnrL?=
 =?us-ascii?Q?bS8K2t0MEAKswccpiUPd6NmvfEi5fhbV2asl1M5bdAL5FIWXWspDuHff9Pbg?=
 =?us-ascii?Q?hdHDYozZui/9qMjFGXlkVmkrVuu0+HAFjTe4V005F8phd7u43bvIuMngA1nX?=
 =?us-ascii?Q?Z4YVirxn/nZXbBiOvYjEojSu9GXE+6MymK68immKHFcXDR4E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH6PR12MB345224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5de2fb-c96f-4d5b-9c25-08df2a11cfa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 16:40:09.6400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjzteM6hOYICL1LLlpIVSGgMxJWBMzTdjAvhW2QczKWKsKNARXF5GW/0pcoCwFKhf2zRwyWFhWH3OA/lHa1W7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

AMD General

Thanks Perry, I confirmed it requires MEC195. New patch incoming with the r=
equested changes.

 Kent

> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: October 13, 2026 11:09 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add log when register access is blocked =
in PTL
>
> AMD General
>
> Hi Kent,
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> > Russell
> > Sent: Tuesday, October 13, 2026 11:02 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Russell, Kent <Kent.Russell@amd.com>
> > Subject: [PATCH] drm/amdgpu: Add log when register access is blocked in=
 PTL
> >
> > PTL will limit access to specific registers. Instead of silently droppi=
ng these
> attempts,
> > log them in dmesg for reference. Also add a dev_debug option to show wh=
at
> > pasid/addr/packet type failed.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 34 +++++++++
> >  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 76 +++++++++++++++++++
> >  drivers/gpu/drm/amd/amdkfd/soc15_int.h        |  1 +
> >  3 files changed, 111 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > index 3572eb9b5758..1ce8313e3c26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -171,6 +171,7 @@ static int gfx_v9_4_3_get_cu_info(struct
> amdgpu_device
> > *adev,
> >                               struct amdgpu_cu_info *cu_info);
> >  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, i=
nt
> > xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_devi=
ce
> > *adev, int xcc_id);
> > +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> > +*adev);
> >
> >  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
> >                               uint64_t queue_mask)
> > @@ -2661,6 +2662,7 @@ static int gfx_v9_4_3_early_init(struct
> amdgpu_ip_block
> > *ip_block)  static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_=
block)  {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
> >
> >       if (adev->gfx.ras &&
> >           adev->gfx.ras->enable_watchdog_timer)
> > @@ -2668,6 +2670,10 @@ static int gfx_v9_4_3_late_init(struct
> amdgpu_ip_block
> > *ip_block)
> >
> >       gfx_v9_4_3_ptl_hw_init(adev);
>
> Could this be moved into gfx_v9_4_3_ptl_hw_init()? That function already
> owns the PTL control flow, so the interrupt enable would sit with the
> rest of the PTL setup and follow the same PTL state checks.
>
> >
> > +     /* Enable PTL register skip notifications if PTL is supported */
> > +     if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED)
> > +             gfx_v9_4_3_enable_ptl_skip_interrupt(adev);
> > +
>
> Also, older MEC firmware doesn't support the PTL register-skip
> notification. Please gate the enable on a minimum MEC firmware version
> (e.g. adev->gfx.mec_fw_version), so we don't turn on GENERIC1 or decode
> src_id 177 as a PTL event on firmware that doesn't send it.
>
> Thanks.
>
> Perry.
>
> >       return 0;
> >  }
> >
> > @@ -3327,6 +3333,34 @@ static int
> gfx_v9_4_3_set_bad_op_fault_state(struct
> > amdgpu_device *adev,
> >       return 0;
> >  }
> >
> > +/*
> > + * Enable GENERIC1 interrupt (bit 30) for PTL register skip notificati=
ons.
> > + * When FW skips a privileged register access due to PTL, it signals
> > +via
> > + * GENERIC1 and KFD receives interrupt source 177 with skip details.
> > + */
> > +static void gfx_v9_4_3_enable_ptl_skip_interrupt(struct amdgpu_device
> > +*adev) {
> > +     u32 mec_int_cntl_reg, mec_int_cntl;
> > +     int i, j, k, num_xcc;
> > +
> > +     num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > +     for (i =3D 0; i < num_xcc; i++) {
> > +             for (j =3D 0; j < adev->gfx.mec.num_mec; j++) {
> > +                     for (k =3D 0; k < adev->gfx.mec.num_pipe_per_mec;=
 k++) {
> > +                             mec_int_cntl_reg =3D
> > gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
> > +
> > +                             if (mec_int_cntl_reg) {
> > +                                     mec_int_cntl =3D
> > RREG32_XCC(mec_int_cntl_reg, i);
> > +                                     mec_int_cntl =3D
> > REG_SET_FIELD(mec_int_cntl,
> > +                                                     CP_ME1_PIPE0_INT_=
CNTL,
> > +                                                     GENERIC1_INT_ENAB=
LE, 1);
> > +                                     WREG32_XCC(mec_int_cntl_reg,
> > mec_int_cntl, i);
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> >  static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *=
adev,
> >                                             struct amdgpu_irq_src *sour=
ce,
> >                                             unsigned type,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > index e241ad7d55df..8dee8c43824d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> > @@ -123,6 +123,28 @@ enum SQ_INTERRUPT_ERROR_TYPE {  #define
> > KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000  #define
> > KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
> >
> > +/*
> > + * PTL (Peak TOPS Limiter) register skip notification.
> > + * When FW skips a privileged register access, it sends interrupt 177
> > + * with GENERIC1 and provides packet type info in CPC_INT_CNTX_ID[31:2=
8].
> > + */
> > +#define CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG  1
> > +#define CPC_PTL_PACKET_TYPE_SET_SH_REG               2
> > +#define CPC_PTL_PACKET_TYPE_COPY_DATA_READ   3
> > +#define CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE  4
> > +#define CPC_PTL_PACKET_TYPE_WRITE_DATA               5
> > +#define CPC_PTL_PACKET_TYPE_COND_WRITE               6
> > +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM     7
> > +#define CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64   8
> > +
> > +/* CPC_INT_CNTX_ID[31:28]: packet type that was skipped */
> > +#define CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT  28
> > +#define CPC_INT_CNTX_ID__PACKET_TYPE_MASK    0xF0000000
> > +
> > +/* CPC_INT_INFO[30:28]: queue ID */
> > +#define CPC_INT_INFO__QUEUE_ID__SHIFT                28
> > +#define CPC_INT_INFO__QUEUE_ID_MASK          0x70000000
> > +
> >  /*
> >   * The debugger will send user data(m0) with PRIV=3D1 to indicate it r=
equires
> >   * notification from the KFD with the following queue id (DOORBELL_ID)=
 and
> @@ -
> > 142,6 +164,30 @@ enum SQ_INTERRUPT_ERROR_TYPE {
> >                               KFD_DEBUG_CP_BAD_OP_ECODE_MASK)
> >       \
> >                               >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
> >
> > +static const char *cpc_packet_type_name(uint32_t packet_type) {
> > +     switch (packet_type) {
> > +     case CPC_PTL_PACKET_TYPE_SET_UCONFIG_REG:
> > +             return "SET_UCONFIG_REG";
> > +     case CPC_PTL_PACKET_TYPE_SET_SH_REG:
> > +             return "SET_SH_REG";
> > +     case CPC_PTL_PACKET_TYPE_COPY_DATA_READ:
> > +             return "COPY_DATA_READ";
> > +     case CPC_PTL_PACKET_TYPE_COPY_DATA_WRITE:
> > +             return "COPY_DATA_WRITE";
> > +     case CPC_PTL_PACKET_TYPE_WRITE_DATA:
> > +             return "WRITE_DATA";
> > +     case CPC_PTL_PACKET_TYPE_COND_WRITE:
> > +             return "COND_WRITE";
> > +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM:
> > +             return "WAIT_REG_MEM";
> > +     case CPC_PTL_PACKET_TYPE_WAIT_REG_MEM64:
> > +             return "WAIT_REG_MEM64";
> > +     default:
> > +             return "UNKNOWN";
> > +     }
> > +}
> > +
> >  static void event_interrupt_poison_consumption_v9(struct kfd_node *dev=
,
> >                               uint16_t pasid, uint16_t client_id)  { @@=
 -352,6 +398,8
> > @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
> >               source_id =3D=3D SOC15_INTSRC_SDMA_ECC ||
> >               source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_MSG ||
> >               source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE ||
> > +             (client_id =3D=3D SOC15_IH_CLIENTID_GRBM_CP &&
> > +              source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP) ||
> >               KFD_IRQ_IS_FENCE(client_id, source_id) ||
> >               ((client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
> >               client_id =3D=3D SOC15_IH_CLIENTID_VMC1 || @@ -538,6 +586=
,34
> > @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
> >                               KFD_DEBUG_DOORBELL_ID(context_id0),
> >
> >       KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> >                               NULL, 0);
> > +             } else if (source_id =3D=3D SOC15_INTSRC_CP_PTL_REG_SKIP)=
 {
> > +                     uint32_t packet_type, queue_id;
> > +                     uint32_t skipped_addr;
> > +
> > +                     /*
> > +                      * PTL (Peak TOPS Limiter) register skip notifica=
tion.
> > +                      * FW skipped a privileged register access and is=
 notifying
> > KFD.
> > +                      * Data from IH entry (not registers):
> > +                      * - context_id0 contains CPC_INT_CNTX_ID with pa=
cket
> > type in [31:28]
> > +                      * - context_id1 contains CPC_INT_INFO with queue=
 ID in
> > [30:28]
> > +                      * - context_id2 contains CPC_INT_ADDR (skipped r=
egister
> > address)
> > +                      * - PASID comes from CPC_INT_PASID (already extr=
acted
> > from IH entry)
> > +                      */
> > +                     skipped_addr =3D
> > SOC15_CONTEXT_ID2_FROM_IH_ENTRY(ih_ring_entry);
> > +
> > +                     /* Extract packet type from CPC_INT_CNTX_ID[31:28=
] */
> > +                     packet_type =3D (context_id0 &
> > CPC_INT_CNTX_ID__PACKET_TYPE_MASK) >>
> > +
> >       CPC_INT_CNTX_ID__PACKET_TYPE__SHIFT;
> > +
> > +                     /* Extract queue ID from CPC_INT_INFO[30:28] */
> > +                     queue_id =3D (context_id1 &
> > CPC_INT_INFO__QUEUE_ID_MASK) >>
> > +                                     CPC_INT_INFO__QUEUE_ID__SHIFT;
> > +
> > +                     dev_info_ratelimited(dev->adev->dev,
> > +                             "PTL: AQL request was rejected due to inc=
ompatible
> > user input; please verify your PTL configuration.");
> > +                     dev_dbg_ratelimited(dev->adev->dev,
> > +                             "PTL: register access skipped - pasid 0x%=
x,
> > queue %u, packet %s, addr 0x%x\n",
> > +                             pasid, queue_id,
> > cpc_packet_type_name(packet_type), skipped_addr);
> >               }
> >       } else if (client_id =3D=3D SOC15_IH_CLIENTID_SDMA0 ||
> >                  client_id =3D=3D SOC15_IH_CLIENTID_SDMA1 || diff --git
> > a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> > b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> > index e5c0205f2618..736b02ccdefb 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> > @@ -25,6 +25,7 @@
> >
> >  #include "soc15_ih_clientid.h"
> >
> > +#define SOC15_INTSRC_CP_PTL_REG_SKIP 177
> >  #define SOC15_INTSRC_CP_END_OF_PIPE  181
> >  #define SOC15_INTSRC_CP_BAD_OPCODE   183
> >  #define SOC15_INTSRC_SQ_INTERRUPT_MSG        239
> > --
> > 2.43.0
>

