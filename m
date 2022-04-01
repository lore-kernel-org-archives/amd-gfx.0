Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F79C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 07:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE65210FE6A;
	Fri,  1 Apr 2022 07:18:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCA110FE6A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 07:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkkzJKUr3y7mMN8fMD586xLe9UvfzLMq0tYq2pzOttgPtqCVgQV9vrJFWWCOUWIAtc4fBOX375PVluysIbiDaVKohFvSq4Zp0VRpkdasN+ONKsAHzHJfOHeT3EaAqjprAxUHHjcEj3gC/lnAyrfnEG34PZguOj3p3Bvq1C4e7BOjd9k2dASwW9QV4JS4HI0gnV8ePvUL/0JPrbdD2hrCWyp0AWFwK90mEDJfXHYkOt+7SRMTByWgHiY7k27dywERw6Ez4dwDJwdMuKrLRHJDm1/LzYmQP3ML/bPiH5X9LVsd1ZvVrU4ljCYIFetB6WpH/ec7/EGpwYgfli0p0BBqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoQ6OgAeIy9xcVQmuwmZPM60AS60Fc55EiXbdDxw9Lg=;
 b=kBNEG8xb/tEo7s6Hqno8MNYK8aBoN2xCjixwsezjxyl5nk6wo85Cwl9ByaNbPmkN3rYpxwwiYpmp53+5ugrXuCKyNodWOrNjcs9N1S5Cta1tPC6gYfL+rQ60tSddcahge0tpdsL3PALkioxJaBDCCDl3h/Tuvn6ueb+9xmNwb1aCyy5p/vATYiq7OX24VKYWvifIiDN4WQALYdUVX4o7C3KqnMr0DF0qXDWIj7DAJnwGTKMfa1WQk1JHgPjZtX9+Mo14aS1y0AKa8HZ16cwXjUlIVJsocdR+fACOOgntw0xQL9lmyfLViPJB2TggLIfRPK9xW6l7dlGmaiOqSQrfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoQ6OgAeIy9xcVQmuwmZPM60AS60Fc55EiXbdDxw9Lg=;
 b=I9p0SXHnXjHQkywUhK0gieA1ObWoCUDAQRLw6w0oQlaZu9XiHUOij4enILDlNt57LRGAs/5Am3mRZDq2mHWQDACCIsF/roTc+6YugQ7QVn6hkLRTA4W1t8VmT4s3U2MSm0QFRpj7WxnXSsaaLTrI9thUtqAAIuesMd7L3R+Qojg=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Fri, 1 Apr
 2022 07:18:25 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::2dd8:c3f7:e0cc:bfb6]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::2dd8:c3f7:e0cc:bfb6%6]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 07:18:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Topic: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Index: AQHX5/LJ4D+1UL2cPU263eD1r1iEEqzZfgGAgAANK6CAABQxgIABvleA
Date: Fri, 1 Apr 2022 07:18:24 +0000
Message-ID: <BYAPR12MB2615DA93084138A62E593442E4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <DM6PR12MB2619B0D5271592A645F67845E4E19@DM6PR12MB2619.namprd12.prod.outlook.com>
 <20220331042729.3490-1-amarsh04@internode.on.net>
In-Reply-To: <20220331042729.3490-1-amarsh04@internode.on.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-01T07:18:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fd5c7b8f-d6d5-4568-a911-ff2e4d86ad46;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2601117a-52e9-451f-d20b-08da13afcf95
x-ms-traffictypediagnostic: SN6PR12MB4750:EE_
x-microsoft-antispam-prvs: <SN6PR12MB4750E3FA690714B86656D578E4E09@SN6PR12MB4750.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0eoISSgBhms+n1ocPSJb8MO+NDyIrfJyiN4L+kirF8czkEFDcAit0mjvvsxBTAnhLVBp+JqRRNZO/d6sgllvAb7gz8DlI1/fgCsVsnq7XjUFzrZKz70zKv6VuEBvCjMrGtUx2uVuyYwYhrZ08XYHHvwRa8jh9TN5nQUNyrBcGrlMALFnczAhkl5AUuiP1s2A9FwrlJQh3R4AMIHfk4dsjz1aecNqmGOos5NjpJ0Wy5LuOBy3ccXbd7aSBarBJsfuzrBlCcDE5m+Az7bX+JQlB9vrYjl2MMIIdSdwyxCocM8pdu9zM8XA0ruNO5uh23VXcADm2V1J/ytCRnDfTRRh+GVRV5Di4c6K/H3eJ1isrizGwD7AJ6Fnp+bbVqV0yqZBMDQQBvxkW5ZzMy43TqiRgbE4e8Nf44GDzMIsAGl9yHao9ARInSfS2TTAxF/a4Ouf2f8+GnsLNftvFh0FGNi61UtUT6NoDAvCZTp6M+De5HzB+aUHEQ7gtlmnIzUQg0HHzEi1O4LfSoObZwxSKPA9oa8rzEV79E41Glqf/hWZJO7PJmHIVPeaaLQkvNkXilnML/9B8sqxf1TNz+VuziP8Kehl/pQjusrF+OeDfYvo2kvbWFu8BGbJqond2SN519LTWTJwGulShBeJGsbzHayz9JSmJHO0gn93/EtRknJvMedDdlYxuxQb8rQh10z5d5M6QTVbpL94UgoudT/W+xtbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(76116006)(8676002)(66476007)(71200400001)(33656002)(66556008)(64756008)(8936002)(508600001)(52536014)(55016003)(66446008)(122000001)(66946007)(2906002)(4326008)(83380400001)(26005)(7696005)(38070700005)(6916009)(316002)(38100700002)(186003)(54906003)(9686003)(86362001)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYWGt8dWFzi1wWYrPjigvQNyrUFIAa04eid4mRzjNX6L0yKHc+EvIgAf6rqS?=
 =?us-ascii?Q?SgXH8DX6w2Oj34dSbCYP5dAf67ECQwCAwixQHFHATmBwBD04xPqC4cqg6Y+A?=
 =?us-ascii?Q?45scvRYK6QBcO7em5+TAHrvh2pSkGLihb4hFG4e61tRIZFflS84rhC2R1nbD?=
 =?us-ascii?Q?EXSItdsU0qwZ93HBZ00VmAnaR84iZj2bVsjfhjYWp/DJWTMgALHnSIsw3uSJ?=
 =?us-ascii?Q?dS19pUeu/06O+2mrXX/mUpiWT7N/B4p7xP7SN4piXCk8bTRBUaj6CVgDY5JX?=
 =?us-ascii?Q?JO/XAZuDueudhgx1bFq277TeaVg/2QAqZ8eLZDvls/4fj0hYwhXzjUD1XM4L?=
 =?us-ascii?Q?OzeINGJ6J2bynu5j7fcIcEGUYV1lP6t1NPkW4F+NR84hODh0VcmGCsensNS2?=
 =?us-ascii?Q?DIRoll/y5HLAuHi7J+7U85plxgIyZNySRjtaEqI7cjrmXNnwV/nPAZHYZIck?=
 =?us-ascii?Q?exI+MYVjhxDbyF7RTxRb2Eh8+ALEEsRbNtfPmT6Idwri80Af5YbsyHzUyMCQ?=
 =?us-ascii?Q?ZNSoXB8Ldbn72fcrG1GZDqlfLyTvFBjheBf9aGIvPaoW9HqEbXrGvdIc8jbi?=
 =?us-ascii?Q?Brc2mEwJRYbQ9N2KKTDN9cWqY80f/LhLvKilEUrDmRXvsqcfYHoNOZQ8P44L?=
 =?us-ascii?Q?j0Ts5QXOa0IfnxbN8WPruo0F3I+iKf2VFsf4MA1AiuQVF0JtCutu0xjxqTPv?=
 =?us-ascii?Q?ofm8bX4gQXyprYpaH4FmbiUDRjPiRUx7YHIUTC0t5SNtU+GwujAQxUDgz6ne?=
 =?us-ascii?Q?MyPGwVcn+LU1reUaLo2vvqZupyTttnQ6421aMytcxwojMhZVJju067MufgoI?=
 =?us-ascii?Q?+K3u3RTr2j+OJXE+IOQ0O64OBzr9xFzizqzaoF0z4DKCDUrSU0O3x55EqFoN?=
 =?us-ascii?Q?ImvgkR9jQpxCNCmQL8m47zvdEfLO0VmI14dNmbFrvccOQ2/LjpCF1C1ulHAw?=
 =?us-ascii?Q?XRgbznZr20dIVNPznRX7VgqLOeMiwZORBF5M/CKXFO+sbiv/LB6B7vSVo33G?=
 =?us-ascii?Q?+Qdw9MfP/v95zL5kXAAJ+To6zRh/5oLtnl8Y/PFV6pRa1/F/n4juuATP1UqD?=
 =?us-ascii?Q?DvabcGtVyLE6g+LMFqUXoEllpKs2+DXXUNoqDT/o9KbxXAAuKtsZFussrmX3?=
 =?us-ascii?Q?CBdBWkqStNFgC7F3GoLHYKFL9A9r5UYfs8H73RSSaNb1UK+PCVL57snFFMkE?=
 =?us-ascii?Q?hXYTl/T+6no7Lo/ESXZQjvhOaix+PmeqGgY/RRD1GMRQi22iXGgrHV0C5Rn/?=
 =?us-ascii?Q?sJGC1poSu565S/LoYNwfQ8zJgNWBwStDQvVs6P1JVZN7yGOYftpdFq3GS8Zi?=
 =?us-ascii?Q?hPy37zSnT9B5VSI9E2jo34300LzrWHBPzvE0lT8y66uoRnVBtQD65AZUpccJ?=
 =?us-ascii?Q?Zer1+mUddmn/YeivqpR3Z+zz7C2ugItv2Oz4ARTdjS6hG0k4uCUCFxkcTojK?=
 =?us-ascii?Q?atpdjm29eY37Zu10t8HPd6lZlAzTEjj0Lv0vPiLGBW2TY7WLF54ib6fgo266?=
 =?us-ascii?Q?GmuuNlB0KIlkvjbxr2Is4wKji4Aenv2/KgupUejy+vGiRzjtX01ynJ81X8rZ?=
 =?us-ascii?Q?7cD1ZBahmrdx4EgvlbNlx33bHJE5Vv8PDvVbdSFWM9Aa4znGt5JWKSxk4tYY?=
 =?us-ascii?Q?T50oHRwQUcIkQtJVWQK1M7Muczxgb97+rNhqPi2VZ8RXm7JRKaeM6ItfL+oB?=
 =?us-ascii?Q?vozRru2Qztgy65XUBq1tG6XhKr3G+Sv1Yb/yZKQMpIsx7Z8G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601117a-52e9-451f-d20b-08da13afcf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 07:18:24.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SrY7Th+j19cHVFzS9LynHmal6cNnDGj1Z/UDy6gKxdfpSn+ffXMJIJEA4ejCUwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Arthur,

Can you try to blacklist amdgpu module first and then do manual driver load=
ing?=20
Hope via that you can have a chance to observe the errors reported by drive=
r.

BR
Evan
> -----Original Message-----
> From: Arthur Marsh <arthur.marsh@internode.on.net>
> Sent: Thursday, March 31, 2022 12:27 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
> arthur.marsh@internode.on.net
> Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
> amdgpu_dpm.c
>=20
> Hi Evan, even with the patch below applied and built, I was still getting=
 no
> signal to the monitor upon loading of the amdgpu module and no response
> from the pc except when giving the magic sysreq boot key sequence.
>=20
> .config has:
>=20
> CONFIG_DRM_AMDGPU=3Dm
> CONFIG_DRM_AMDGPU_SI=3Dy
> # CONFIG_DRM_AMDGPU_CIK is not set
> # CONFIG_DRM_AMDGPU_USERPTR is not set
>=20
> kernel command line has:
>=20
> amdgpu.audio=3D1 amdgpu.si_support=3D1 radeon.si_support=3D0
> page_owner=3Don amdgpu.gpu_recovery=3D1
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 89fbee568be4..d7dc9c5b3df9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> amdgpu_device *adev, uint32_t block
>  		return 0;
>  	}
>=20
> -	mutex_lock(&adev->pm.mutex);
> -
>  	switch (block_type) {
>  	case AMD_IP_BLOCK_TYPE_UVD:
>  	case AMD_IP_BLOCK_TYPE_VCE:
> @@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> amdgpu_device *adev, uint32_t block
>  	if (!ret)
>  		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
>=20
> -	mutex_unlock(&adev->pm.mutex);
> -
>  	return ret;
>  }
>=20
>=20
> Regards,
>=20
> Arthur Marsh.
