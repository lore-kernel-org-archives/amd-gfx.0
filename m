Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A730C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 10:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D25C10E1BA;
	Mon,  1 Jul 2024 10:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VYkxVi24";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9FE10E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 10:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzr/atJQmK7QW6ELALnUdLhHkPTq7MM+B72Ry4tib/COiZBMR1T1ifDQXCORCP4xbmcFWsQR1o148XU9jHybT5qz56BfrCsejhPl3+pf2N/7aY5c7NhOMXNNECcn9CEZMja/jlPvqQ6mXOzUWdbzHdCxuduiBE3VZI59O6GsQT3qhE8yajW8jNfqfTfJy333BvoW0G6PxlJu+iVqIhD0kkZqpjjDgoqPYsN3y/aEg8BcgACG5p5r2UhXzce5ahSk06wzgOmpxmyh0Jj01BENcSMfyO4DoA8Nl/+6FstV5h5Dj2PqGjT9PHunwWDtJl2RNAIuJFw3PWHnriEqxg3yDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlMa8cm9amzhzYMZYHp7M7IIV/3+lOHG9FphWryt9+g=;
 b=dlCuNjCjDK6c06apcXsII2lFv5OnSplfpJ0DJ5NM0VTBmAenU4+Epw5eJFBGKi7hG8VAbSanMZ8QBOt9KUw43hPur3/fClOAGa9ZTGNzQAViOZRcfq/W/tdnhP4ZTtuf9HVcA3UfyPelem9XKLf8hjGN5JuO/SNcCGt4jU4uxecR7qLr4sy/N7XBNZmTiTPkuwAbSpJnu10nacaJD5gXbg6pXa/LJ2nKEwp/HrHcNkhBiu2cs4938JFQcserfhriWhSPy021I5ERnbL5QBBGLXS26A08VSOm1qVCJs6ykWCkcZjJMkEJ1pZVQ1LibeCaLczwFTchOZ/cxwDaYsbZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlMa8cm9amzhzYMZYHp7M7IIV/3+lOHG9FphWryt9+g=;
 b=VYkxVi24t4wC3a/l6a9W/hebfVv2h6sEma9gsaSpZRPdYFKo8h70eszL+MsaFx962Vt+otb5QnlTQVst/27cLjNo66Y7XXhOV49rBTCXb71NDaLgG/B1cIP7CZYaSHj/GOpO2obj/TlqE2oJGvCC8HcOiTaQ4qtsra1DQImXXxk=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 10:12:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%7]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 10:12:34 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for SMU
 v14.0.0 and v14.0.1
Thread-Topic: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHay5AGODqI4Bw0rEOeKpr/kyQRNrHhnIWAgAAGTOA=
Date: Mon, 1 Jul 2024 10:12:34 +0000
Message-ID: <SJ1PR12MB60755B24C8B84F80C603D043FAD32@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240701082253.497435-1-li.ma@amd.com>
 <CH3PR12MB807405FC838F23406317E6AFF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB807405FC838F23406317E6AFF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38d3300f-7874-46ad-be2d-18fe3b150fee;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T09:29:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|CY8PR12MB7436:EE_
x-ms-office365-filtering-correlation-id: e93eae9c-dbdc-4e68-e9a5-08dc99b6535e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RXK0TNrmvLiONW7FLRri/qoBaUdUCJ9iRaH9P/TZS8bratl9EjLtXEu3VxMl?=
 =?us-ascii?Q?EXN9rpmLu1ywj3cjJ6Urhq5DdMTpqF4RBu16SHVIDctlkCVnnsYYUuwMNiuU?=
 =?us-ascii?Q?T1sn/vFzSP4o8g21+M9YkLPeNZFAEefmJbT96CmetvFsQiCWPYBk3u4EoxLM?=
 =?us-ascii?Q?9lUHbgO+osJq+nATD6pWwQNxKonzzliItjGD4e2OwotVRoU/Inyo4aWoAEON?=
 =?us-ascii?Q?enXVbdb0D2tksFftUoNuUax/FCrXwydMms4mb/xwpokNY692bEifp2A6C8AW?=
 =?us-ascii?Q?Ofy6Jo/gc77rJ7jiDoYs3NaIboELVxpXx9UjQKpX0BcZ6iHBm2rTpJNK3avC?=
 =?us-ascii?Q?+bgu37z1JTxNLgH2YUHUuMJsUxa9Ox7HvLPGtwW+BzM6DuhnwCyL+c6cBw02?=
 =?us-ascii?Q?hZLBqUwWqvBK2boPF6qa7j8dOkJY+kcVW74YiLJwtkpDuZ2kRVCfZi27YY1h?=
 =?us-ascii?Q?DDzMKN3BTwH+l7kUSrEA1hWzj80+ru/Ypnoj6mDiC49ZFHuFrjfINBxK8xrI?=
 =?us-ascii?Q?M78wb4yuXD/GCqDGoug7nOliBh8bf5auAcVBCxBL9Wq5gVOFiYxs3MuTRdpf?=
 =?us-ascii?Q?6NR8cYVxVG86iMsjZ1yYkuKUucgqmqnwb88W4p+cjViychqExXoPM0bagXAQ?=
 =?us-ascii?Q?01f8Myww5vIYcYdaHgh3b/oCKUZdaD5sWz+gJ5WJEIPzvRhcdR1EOfJuywbk?=
 =?us-ascii?Q?3gtbIp42hPczaGLcl02+PRddiccaTW+DubW8bsoscr5CG7QuoisXEfgrPRno?=
 =?us-ascii?Q?bgJ+fgjVuxQmkUl1I2RmbkI7E0JwSLzHqpgU6wSbArSr+CFdHfebt+eJIEA0?=
 =?us-ascii?Q?VOmdMEhENCh9bFAJgeAPTJ606y9E+eIAElg55h2n1PFY4aFzl/UeDxdVn006?=
 =?us-ascii?Q?ZgTXVCeBF3FRszc6D5YSigdseb1mcSpoh3ToLRqjEH/3LW1wFP4tupp27SEo?=
 =?us-ascii?Q?/M/VhTcIipRhT8N73dJoD6hxsCsRJNYuBx+GHJUxL+gtih2OFd/+t5wt/Asw?=
 =?us-ascii?Q?HM87v4TIgdDhFl/CQQFdGV3JsjboKYWzY9u6zfKgi/JQtPLOPXE9H7iJev0m?=
 =?us-ascii?Q?1aFUsqpaeUpdYqgWDSZx4OqRIKpqSDBJ6iD+9TqZRWAIsXeokUxjg/rWqRh5?=
 =?us-ascii?Q?MIM61Ymq7KS1F0XIMATnKQklIp8QBeIHTuGJn/RYBnRY/ywCzAHoMt3FhFaW?=
 =?us-ascii?Q?jEgn4GyhW7tktCYUj4mSqtgyX6TPdRBPmXXOD0s+gl4khxPi4gX7Pt5fwucA?=
 =?us-ascii?Q?CJHHHEPc7KAkhu9Xz/EaP3QGrSz93fEbID7hhWHcDJkUTG3PyPIDmEgnBQl7?=
 =?us-ascii?Q?x7R0ClL304P5NW1e33vZHG347IExeQXiPbCL2KEsL/2d/GGsYl10LTC/djgE?=
 =?us-ascii?Q?ioU0fWw6V4DvTt4nsOL4EcFfCSW2yG+1kgWVelRTyXJvvOPckg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e2WbViqbU/ahq26t4B1Of95kJ8vXqSjptfIag3+8jBDnqFDVxLRG7JanJxvZ?=
 =?us-ascii?Q?ZCPGM5yM8eHQgG23UnxzEk1+aPttbNOb9HyGnuCoxnWkk9u3VbFYJ1U1v+7r?=
 =?us-ascii?Q?bNvBuIFUwQLkkw//F2tHv7NfH2PkCIpqKQp7dVyLfNLoCD+i6qTp8XuX66Vz?=
 =?us-ascii?Q?tweUjbkX2EWCtmTceC0qWSiIR6DvkorEh3Tndz7YKraZOzyQRms5gxLzZxlG?=
 =?us-ascii?Q?UkalSBUIc8quvh+6xE8IcIfmdRKWLv+3eVXjKqI6hJOxQMWA8VF3wfOW4kd0?=
 =?us-ascii?Q?pG63fQZp8iFzYW0PCOlfRdeZlwBTmArwciPOsxAdCcKWjLTj4wP9LtA00A80?=
 =?us-ascii?Q?XP6nsFRfw4d0IMqRPRRRacJIjtJ/jVrMTfN41Lr8KhcplMfz68F7Q11ikBaV?=
 =?us-ascii?Q?hhHmzchB62aAWw1UT/6BSOn49hT47z+mPNhUXqFjfajKAgRoTjxP8N2QHn8K?=
 =?us-ascii?Q?au0PiMgA8vPZqYRbXHj9ah/O1CkMGFRM329+EvPq61qyeJP+hTYDM5Mv538k?=
 =?us-ascii?Q?ACWQcEarn84Wx1h1u6O4Y8/O8kbRLQphgpyQgT5wfQrboZZOD5+y3XnasugT?=
 =?us-ascii?Q?BmUhxyVEWHG4MRio/kSd82UWFMeEWgdaqEPahEAuleG7TM310PP2zSE2Yufj?=
 =?us-ascii?Q?yggFZPdgkvYFsMfxp2PP59P0+ssgoXZ/3k7FQWruM8ngGbDDUACN7INCPkfa?=
 =?us-ascii?Q?GsD6h7SNQznk3vjBsPmLvnbW4iRukgv9TAHBqtwS53z39ur9edQGjxvzIex8?=
 =?us-ascii?Q?A96kVwgU2r6k2KqHVhoHYxjcz0s71ebptvjMXTKqNDZTGd+P0ZVD2KkImNyk?=
 =?us-ascii?Q?Z2SPur6TUiF55vuhVQv04SB/NHW6S6pkiY39Fs+JsUQ5r/FO7ZFN4LYdodoB?=
 =?us-ascii?Q?qta72X/Jjnn66T87Mbr1HR/LZVzV9UonLlBXlpmuRcW3O5gf+S7Z/g7JG9Qt?=
 =?us-ascii?Q?BBY4SVgp14wbw02AOflPL45TkKrNlfv8ohquPAJfP8vaB78Y0i8YyLMoOmvo?=
 =?us-ascii?Q?6j5oCCcghHbCqcrB9oJZpUDcUmjVyP4SuakDiIqDOyo5Pg0YjVAzpREFSwTo?=
 =?us-ascii?Q?sMPCJP6as/IwyAzoSc3WyPMTHZ/+7AT5IQhuWqKb7X2Ux5gWdkMfmmSwxDDz?=
 =?us-ascii?Q?r7vJyjMBxi5dcocvdjkL8VkBf1xANIbul26F9klkqcXApLUQXs9pm5VDXdUC?=
 =?us-ascii?Q?CGwLjwocez7gfayJ+IX16yNecOhNAc5QxDFRBWV3N6qGVdo8Bw+XUToLiGik?=
 =?us-ascii?Q?J4i1QcyUQKJqfGfwv3wxqSTQm1RBHAVfELaUkXzFiOpuVe8ynSJRU0oFY9Ml?=
 =?us-ascii?Q?3zYVBti/7365nJXwHzFWiVYOwl2v48K+lj1tu6ZMW2UYVpaWvvVDDIcUjabz?=
 =?us-ascii?Q?U2qDxTFzmcnd/oL7NOx0duq17zbzn5Oa3dHLsJF6Icgu2L8JTMWkvX8ZIIw/?=
 =?us-ascii?Q?A/gC3amyaiW+oyoMUf1OHFQGpU5Dq7bgbZAeKrTUAUWZCB4hB/6f2VMxjaz7?=
 =?us-ascii?Q?bb5gqlzb/tJCfCczsqpplVppv/84ULsF9281PcF1tKgOfoAfmFqnxjPagm5G?=
 =?us-ascii?Q?UUPFdfmDhCTq26ZgysI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93eae9c-dbdc-4e68-e9a5-08dc99b6535e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:12:34.1536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0GzQzt8qPGgXTAotPi1Qwso70i8iyjSM0J4ku7BEk5xhhtelQkpyu1iUMn9Qp4ZZO12wh+QQUMhJ6EKQfwYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

Hi Tim,

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Monday, July 1, 2024 5:34 PM
> To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amd/swsmu: enable more Pstates profile levels fo=
r
> SMU v14.0.0 and v14.0.1
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Li,
>
> > -----Original Message-----
> > From: Ma, Li <Li.Ma@amd.com>
> > Sent: Monday, July 1, 2024 4:23 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li
> > <Li.Ma@amd.com>
> > Subject: [PATCH] drm/amd/swsmu: enable more Pstates profile levels for
> SMU
> > v14.0.0 and v14.0.1
> >
> > This patch enables following UMD stable Pstates profile levels for
> > power_dpm_force_performance_level interface.
> >
> > - profile_peak
> > - profile_min_mclk
> > - profile_min_sclk
> > - profile_standard
> >
> > Signed-off-by: Li Ma <li.ma@amd.com>
> > ---
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 150
> > ++++++++++++++++--
> >  1 file changed, 137 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index 18abfbd6d059..d999e3b23173 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -65,6 +65,10 @@
> >
> >  #define SMU_MALL_PG_CONFIG_DEFAULT
> > SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
> >
> > +#define SMU_14_0_0_UMD_PSTATE_GFXCLK                 700
> > +#define SMU_14_0_0_UMD_PSTATE_SOCCLK                 678
> > +#define SMU_14_0_0_UMD_PSTATE_FCLK                   1800
> > +
> >  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> > SMC_DPM_FEATURE ( \
> >       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -723,10 +727,10
> @@
> > static int smu_v14_0_common_get_dpm_freq_by_index(struct
> smu_context
> > *smu,
> >                                               uint32_t dpm_level,
> >                                               uint32_t *freq)
> >  {
> > -     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0,
> > 0))
> > -             smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_leve=
l,
> > freq);
> > -     else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
> IP_VERSION(14,
> > 0, 1))
> > +     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0,
> > 1))
> >               smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_leve=
l,
> > freq);
> > +     else
> > +             smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_leve=
l,
> > freq);
> >
> >       return 0;
> >  }
>
> Does this conflict with the ongoing commit drm/amd/pm: smu v14.0.4 reuse
> smu v14.0.0 dpmtable ?
>
> Tim

Li: Thanks for reminder, the change in smu_v14_0_common_get_dpm_freq_by_ind=
ex
and smu_v14_0_common_get_dpm_ultimate_freq are same as ongoing commit
"drm/amd/pm: smu v14.0.4 reuse smu v14.0.0 dpmtable". I will remove this ch=
ange
to avoid the repetition.

>
> > @@ -818,9 +822,11 @@ static int
> > smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       break;
> >               case SMU_MCLK:
> >               case SMU_UCLK:
> > -             case SMU_FCLK:
> >                       max_dpm_level =3D 0;
> >                       break;
> > +             case SMU_FCLK:
> > +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     break;
> >               case SMU_SOCCLK:
> >                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabl=
ed - 1;
> >                       break;
> > @@ -855,7 +861,7 @@ static int
> > smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       min_dpm_level =3D clk_table->NumMemPstatesEnabled=
 - 1;
> >                       break;
> >               case SMU_FCLK:
> > -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     min_dpm_level =3D 0;
> >                       break;
> >               case SMU_SOCCLK:
> >                       min_dpm_level =3D 0;
> > @@ -936,9 +942,11 @@ static int
> > smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       break;
> >               case SMU_MCLK:
> >               case SMU_UCLK:
> > -             case SMU_FCLK:
> >                       max_dpm_level =3D 0;
> >                       break;
> > +             case SMU_FCLK:
> > +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     break;
> >               case SMU_SOCCLK:
> >                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabl=
ed - 1;
> >                       break;
> > @@ -969,7 +977,7 @@ static int
> > smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       min_dpm_level =3D clk_table->NumMemPstatesEnabled=
 - 1;
> >                       break;
> >               case SMU_FCLK:
> > -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     min_dpm_level =3D 0;
> >                       break;
> >               case SMU_SOCCLK:
> >                       min_dpm_level =3D 0;
> > @@ -999,10 +1007,10 @@ static int
> > smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
> >                                                       uint32_t *min,
> >                                                       uint32_t *max)
> >  {
> > -     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0,
> > 0))
> > -             smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max=
);
> > -     else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
> IP_VERSION(14,
> > 0, 1))
> > +     if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
4, 0,
> > 1))
> >               smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max=
);
> > +     else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
> > +             smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max=
);
> >
> >       return 0;
> >  }
> > @@ -1268,13 +1276,67 @@ static int smu_v14_0_0_force_clk_levels(struct
> > smu_context *smu,
> >       return ret;
> >  }
> >
> > -static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
> > +static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context
> > *smu,
> > +                                     enum amd_dpm_forced_level level,
> > +                                     enum smu_clk_type clk_type,
> > +                                     uint32_t *min_clk,
> > +                                     uint32_t *max_clk)
> > +{
> > +     uint32_t clk_limit =3D 0;
> > +     int ret =3D 0;
> > +
> > +     switch (clk_type) {
> > +     case SMU_GFXCLK:
> > +     case SMU_SCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_S=
CLK,
> > NULL, &clk_limit);
> > +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SC=
LK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_S=
CLK,
> > &clk_limit, NULL);
> > +             break;
> > +     case SMU_SOCCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_SOCCLK, NULL, &clk_limit);
> > +             break;
> > +     case SMU_FCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_F=
CLK,
> > NULL, &clk_limit);
> > +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MC=
LK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_F=
CLK,
> > &clk_limit, NULL);
> > +             break;
> > +     case SMU_VCLK:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_VCLK1:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_DCLK:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_DCLK1:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > NULL, &clk_limit);
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> > +     *min_clk =3D *max_clk =3D clk_limit;
> > +     return ret;
> > +}
> > +
> > +static int smu_v14_0_common_set_performance_level(struct smu_context
> > +*smu,
> >                                            enum amd_dpm_forced_level le=
vel)  {
> >       struct amdgpu_device *adev =3D smu->adev;
> >       uint32_t sclk_min =3D 0, sclk_max =3D 0;
> >       uint32_t fclk_min =3D 0, fclk_max =3D 0;
> >       uint32_t socclk_min =3D 0, socclk_max =3D 0;
> > +     uint32_t vclk_min =3D 0, vclk_max =3D 0;
> > +     uint32_t dclk_min =3D 0, dclk_max =3D 0;
> > +     uint32_t vclk1_min =3D 0, vclk1_max =3D 0;
> > +     uint32_t dclk1_min =3D 0, dclk1_max =3D 0;
> >       int ret =3D 0;
> >
> >       switch (level) {
> > @@ -1282,28 +1344,54 @@ static int
> > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > NULL, &sclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > NULL, &fclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > NULL, &socclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > NULL, &vclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > NULL, &dclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > NULL, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > NULL,
> > +&dclk1_max);
> >               sclk_min =3D sclk_max;
> >               fclk_min =3D fclk_max;
> >               socclk_min =3D socclk_max;
> > +             vclk_min =3D vclk_max;
> > +             dclk_min =3D dclk_max;
> > +             vclk1_min =3D vclk1_max;
> > +             dclk1_min =3D dclk1_max;
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_LOW:
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > &sclk_min, NULL);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > &fclk_min, NULL);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > &socclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > &vclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > &dclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > &vclk1_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > &dclk1_min,
> > +NULL);
> >               sclk_max =3D sclk_min;
> >               fclk_max =3D fclk_min;
> >               socclk_max =3D socclk_min;
> > +             vclk_max =3D vclk_min;
> > +             dclk_max =3D dclk_min;
> > +             vclk1_max =3D vclk1_min;
> > +             dclk1_max =3D dclk1_min;
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_AUTO:
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > &sclk_min, &sclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > &fclk_min, &fclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > &socclk_min, &socclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > &vclk_min, &vclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > &dclk_min, &dclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > &vclk1_min, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > &dclk1_min,
> > +&dclk1_max);
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > -             /* Temporarily do nothing since the optimal clocks haven'=
t been
> > provided yet */
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SCL=
K,
> > &sclk_min, &sclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_FCL=
K,
> > &fclk_min, &fclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_SOCCLK, &socclk_min, &socclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCL=
K,
> > &vclk_min, &vclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_DCLK,
> > &dclk_min, &dclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_VCLK1,
> > &vclk1_min, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_DCLK1,
> > +&dclk1_min, &dclk1_max);
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_MANUAL:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > @@ -1343,6 +1431,42 @@ static int
> > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> >                       return ret;
> >       }
> >
> > +     if (vclk_min && vclk_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_VCLK,
> > +                                                           vclk_min,
> > +                                                           vclk_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (vclk1_min && vclk1_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_VCLK1,
> > +                                                           vclk1_min,
> > +                                                           vclk1_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (dclk_min && dclk_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_DCLK,
> > +                                                           dclk_min,
> > +                                                           dclk_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (dclk1_min && dclk1_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_DCLK1,
> > +                                                           dclk1_min,
> > +                                                           dclk1_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       return ret;
> >  }
> >
> > @@ -1520,7 +1644,7 @@ static const struct pptable_funcs
> > smu_v14_0_0_ppt_funcs =3D {
> >       .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
> >       .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
> >       .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> > -     .set_performance_level =3D smu_v14_0_0_set_performance_level,
> > +     .set_performance_level =3D smu_v14_0_common_set_performance_level=
,
> >       .set_fine_grain_gfx_freq_parameters =3D
> > smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
> >       .set_gfx_power_up_by_imu =3D smu_v14_0_set_gfx_power_up_by_imu,
> >       .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
> > --
> > 2.25.1
>

