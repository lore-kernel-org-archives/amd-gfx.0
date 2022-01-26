Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF238C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 14:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B11D10E62F;
	Wed, 26 Jan 2022 14:57:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E7710E62F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 14:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLkuY64ig5Zt9b2BdEVIhoPiUVcA6C9iDXAn2CiVbWorscWK+6O0rkBLPJ//ufN3C1BlymmlyoqZ6u+MsRVj6d5Pr/KlXAu1xu5mduEjX5MlugQkVxSMETw6b3lHnyC2SSRVbB57sygTHDjJX6bUb5BY44+LcSVyfFT56YX+1ijBc+a9qCU1bBi9e2Vj+KlBAGwUPVTGLZRQQvBAI90oqSMRDkratfZUCs6xWDp4pRZi9PcE6NRRBGg/XWQ/L2wCD8jmlBd0T3lwl2oc/9zCNVgAkgFOlFe/fH8QjdZ7UJMAPeIro28m4SHWOrl/4LqTv5fSjp+Sf5ZjmA/3RA/dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CtYTvzgtGJg84N0yPUmVL7hzX9NiJ6qcRU4FyOtusg=;
 b=Zfy9dNq36MXdrFfzP2JxX/aFFrSc+VqcFl89HwzFqo2FFsfF0qwzWqYbzV6R9CUMxdNGC29weKOjcGB8RlUwtFrZFbqh3rNCK7LTMQXWiFtHfOLp/NxHWaY/FR8C+VWWedYqGo7ywDDgIBWNjBZIU0X3Q9jjRoaO3Y5EjErKXXAY8HBd4mmf2ZiQrJLDIbs4iWg9yVYiqSWIj77kKW7cymPR6SeZ1ADxAAac7RL3DnLQIUXeCHEDJ2sNRFvHyGayoEzHGtwi75QAU32/hFOLow4+i6lECHc/FRivt/U64afWVFYboKVQWYBBarHEBKZHzQLXVhFS0TRZe7Uq+iS+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CtYTvzgtGJg84N0yPUmVL7hzX9NiJ6qcRU4FyOtusg=;
 b=WcCqSxKMAZNDRG2uhtu8ydwoL8xhCg6vsdRkoJL9zr+FqIQLezvCJd9/nIS+wAFVIs9PYzEjTr4RyuX5A5vfV37ka/84T2/FLElh1vRftoYo2pAvKkMNa6XN3eg5p/7BQVZ/Z6orPWw9osI0SHJ7sxmRnix3XYIu9OiqB0Va7Ks=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR12MB1445.namprd12.prod.outlook.com (2603:10b6:910:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 14:57:27 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 14:57:27 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 4/4] drm/amd: don't reset dGPUs that don't go through
 system S3
Thread-Topic: [PATCH v5 4/4] drm/amd: don't reset dGPUs that don't go through
 system S3
Thread-Index: AQHYEmqOPllBJW9FWE+G+a6NlkgKjqx1ZN0A
Date: Wed, 26 Jan 2022 14:57:27 +0000
Message-ID: <BL1PR12MB51574B9B0E8DA25C650BEFB5E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-4-mario.limonciello@amd.com>
In-Reply-To: <20220126040944.4324-4-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-26T14:57:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1bcba238-93e2-49af-85c3-5a80207040b7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-26T14:57:26Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 423b92e6-d128-4104-a836-198e68160201
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ff52893-504e-440d-af1d-08d9e0dc2b46
x-ms-traffictypediagnostic: CY4PR12MB1445:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1445D8CC2F7B1D6CEC4F9C16E2209@CY4PR12MB1445.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvQ2vICyZUhaf0letfgR7ugfPsp32Au1SVBQiv6VK0SD6iPHa67vl12Tyl6iDcNBn55mvjoHJDXF4l9vSjKdp62rfKvurflfEHZMIKb+bJjSiVo9aN4idQtwt3vb2Nf8GaBp+NNQZJtEDYyXon+rX6lLG9rrrwwCi8Ce/0HO3IAMu6ynNEgn9x/hN/cfqvoW2Qi17d0s5Vg94bMAmSPrJSAw7STOVYRUIwVWBb1ii06NLjCh/uxdGYhzkvZ1nClrC8KHlFQEB83jYs/+PqdAivYqqEyrIFwSfkVL7SdQju2lhIASAMxeNFGQWD0uw/pLKe80CPkeHRMY29/PiwRdQANQeO8v+ugJnX+pJZ/EtmHpgcjrAVw6IgWryfRi/npjafcOmIsc+VTLNcvx8JQf5KJqxMCf4JexUvUBK57IZxNBnjq7X5LLcwwBXDWI0Xlym2FZa48+0zJ2IajPGtzy3euTlZHorCleemHJZTg9W1VndBtzNbWwnd5J1fZODcH0zzo1YyAXTXBKeJJ3zRdd/djG+95qrxaULxFMuvJqv7he7uFdT0MrShDjpexF++VGp1/A/De+Z8HJQfOjjPoLSA8vRF5L31fTLnYFfeMtaLi22pS8ASsrkfpsuanP5ObsoxDdMJOBQeYe6lGTpn1PJeM7MMXTZPs/b6TuOnCVTiR9cqJK9hHmwZST+OaENHxHp726PcmXLavLZoZgVbtc4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66446008)(9686003)(86362001)(64756008)(66946007)(4326008)(38070700005)(76116006)(66476007)(966005)(66556008)(2906002)(38100700002)(55016003)(53546011)(83380400001)(508600001)(316002)(6506007)(52536014)(7696005)(186003)(33656002)(6916009)(71200400001)(8936002)(5660300002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ip6UQtIGBN11nUygzvI6SGaocMb5sRT+xBqK0LblpYlQPQvjKawYTYeGMZjo?=
 =?us-ascii?Q?4rnOrN0zZpALlkQDBAMykDp6XG66Y8moILupCqM+aBcc3VaKy1nWDp7oHokJ?=
 =?us-ascii?Q?xA/pmY4XDIOenFiBTChgqbuj3al/7CI0nXkn69FIDfMvOZbGyNjcsn4HOZ1R?=
 =?us-ascii?Q?GsbF+9hKCJdpxEUklRpQiUwu6IhKZ0qZz6ypYwFjJAISRNOUPwp51kKwYOzV?=
 =?us-ascii?Q?90ptlp8jkpdlZ3ul3uT33Y55ukgFFEhtqYmqwSxoHy6wXLb55pGMyBV4zwUS?=
 =?us-ascii?Q?5iXjDA/2/+Drmu6IaWrgJa9R0AN9yNI6EeAezIj2lod+W3BkuzLUYDTrnsWb?=
 =?us-ascii?Q?b8w6nD8rjV+nKt3zGmtxQgaECfBLXTTn71iRod++TkgknjIswOZXOQ6ej6UH?=
 =?us-ascii?Q?NxeXpOo7Hveu9H0i6ebd/idWb2H6A7NEt28knLD0gqkM+VH966/FlUyOrOda?=
 =?us-ascii?Q?Gk7oUlviUIU/gdNInS2QoByK7b7S3VuhUQ09nrweF/GK7wiJ7oLNCG2r8X6B?=
 =?us-ascii?Q?DRdRVzLIluvg8IsVRxJf73bzpNKeQxM0PNPPgcp7hAMll8T0pr7m9Hjb6zJz?=
 =?us-ascii?Q?zMmQnvozJcr08pMgIcxDiZR2zji0/B92qGfJG2kkvjW8BwkiQf5O7BXqy9RP?=
 =?us-ascii?Q?gfbBwjP+wICPkUDNm6goaDD6z3CkV1j3GGaNoga2oBzVtTn7YSG3+vbSljGU?=
 =?us-ascii?Q?2EE+ZhNUM4F+X3RfchuCBig1xOZDhmXweu5r46ZRIoa/liq9odyGBc+fdU8S?=
 =?us-ascii?Q?I/sbyQWmCM7xHPhWcvHt1Fbu2bcdN3M0ZQOYmqVC+OEFLaTLON9/BOT3n4tY?=
 =?us-ascii?Q?Ysw9CFQsDCeUS/pjAyOfvJLggOEWaCmlj3PY8nPlGcI5u/xMcMOuY1rZuS/V?=
 =?us-ascii?Q?0a8ECiWAOQ19GJYW2kXCv8OZm6yw4jNQfWAtARO3nTbE4uQMz0sNTPZ+zl6k?=
 =?us-ascii?Q?OFSUOPelbKE45GDtHMnm8Vlzt2TQp7Twk+YWiZp7d3kB4ASk3p2YJYCuiB2t?=
 =?us-ascii?Q?ja1wG4drT/Yxt/5e8C7KW0FrGHZ/Ej/Zp75IMGF/IHWg/MR2D5hhPHtzvxWQ?=
 =?us-ascii?Q?HfZxX0RYE7ZipSFaLHc3gQdygxcbVo+r6dxgU+zob5h+NDdxJGTA4JcIOLvk?=
 =?us-ascii?Q?oMSNApJAUHHdK8uk0XLDxByRP8iF7SIIEdxqNajem8oJ+TLVfes3eA7fkijY?=
 =?us-ascii?Q?dXBLejMPIbJQoQrTpvHiKqkyOUx3168eAqELF0nrBgy6xTPBcMXeGLYV+6A3?=
 =?us-ascii?Q?aOnmNOE/yPaTiL0JZl9EjadHmiIqLuXOQbsqw5hLnoxu594U9BnTQfN0WJmy?=
 =?us-ascii?Q?jN6H5kI+vj9N8TFOfVq8xP1b93xUVdlkpyoVu7wnNLbPOOSsuT8iytXnIiuy?=
 =?us-ascii?Q?CoI0UN193DbcQqZleG07rfETi1hevoDM+oV8BqTNbNRk3vkk9Oex3/EcfXmZ?=
 =?us-ascii?Q?1SKnvh82ab1ZPAdBpirmZdByChdn3eD+0zAFARsV3T+tDL42qvuRO4FRaevG?=
 =?us-ascii?Q?6rGYTgYfUwHScr7I9mZkK5eB8brtYOThuJj4tCuf8tngEr1TuVHFQJKeTYEV?=
 =?us-ascii?Q?cImuBLIbQ1pwOtoz1miO99z+A64z/3GBcQgNZAxlEOPnwZDHvGFFK1MW2pp4?=
 =?us-ascii?Q?ehqBQWMJhFDvGV5OlioTLeX7Jcpp0PunrB5tIGEiVBrJAacqFH+bPREfC0sb?=
 =?us-ascii?Q?+OX1L9t37CtJLlP16Jn0Nyv9l/8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff52893-504e-440d-af1d-08d9e0dc2b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 14:57:27.2021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnkKFYe9/xIASx5Vw+kGy5CpD1x2Fn4oRuQ27WU+bE6xnji17inVK5RobZaVjo+r7Lj2JLmAHOuHb/ShtPDfPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, January 25, 2022 22:10
> To: amd-gfx@lists.freedesktop.org
> Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v5 4/4] drm/amd: don't reset dGPUs that don't go through
> system S3
>=20
> dGPUs connected to Intel systems configured for suspend to idle
> will not necessarily have the power rails cut at suspend and
> resetting the GPU may lead to problematic behaviors.
>=20
> Fixes: 6dc8265f9803 ("drm/amdgpu: always reset the asic in suspend (v2)")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1879

Testing has failed with this patch on the original issue mentioned above, s=
o if
the rest of this series is OK, this one at least should be dropped for now.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 123ec5a07dd5..66290f986544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2319,7 +2319,7 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>  		r =3D amdgpu_device_suspend(drm_dev, true);
>  		if (r)
>  			return r;
> -		if (!adev->in_s0ix)
> +		if (!adev->in_s0ix && pm_suspend_via_firmware())
>  			r =3D amdgpu_asic_reset(adev);
>  	}
>  	return r;
> --
> 2.25.1
