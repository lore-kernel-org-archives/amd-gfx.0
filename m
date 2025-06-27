Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E508C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 15:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BE110EA66;
	Fri, 27 Jun 2025 15:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lN34K88l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3833E10EA66
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 15:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcG5JTjGL8usOnUn0r7yqXmdLtfGY32WPy/RNjSuE+Bkfr4IzmKsz2EyU+844/1/5HGR5gt2RroPE/4oQ9pN62UmWzQUGneDu3pjpK0UFc2uQUIm2/lAPwU/OmgtsayEqTngNNDy6iTySaA7DgLbVRHTkeL155WHy2AC9vztFJbwEoilrhbcXJ2JHM2b8hL4STsttnNxuzGmdUwHguUIBMQIOEDN/bUfybOFVdYy15K5erQsTXoaKo93twtvOtADIivvBVqTSvJrXISbUNoXBBIIPy2qHf6aYMZGnYRe2F5K/brGYG5fAsp0i6JckAJ11AnBRC2q/L5yl70Cjofsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aik7QFHik93RUvlCwMoArtJxbrb/YXMPG90FiiZbu90=;
 b=t9NzDf0+4j9+cMyUSHSZnteyetAsJbl2Q5YT73tZr40oZrVVk2PxxlkpsMv/YaUxplUbIwMZFBVgHWSvNKQvX14l4wtt095rmmoLlk9PGAgnxlxYdKJSlV5iAdhQ5nBCdZePTAmYfT0vR4iNwWWuU8VcY0rGcV9nVolpU6RO1Ta88UAJAqhy5dLr24cTTF4kANbUuaEHnP/8w3ly7emBDYF8JC1+IYsYafTlYoR6Ktvok577VyWzhGyeVWPQM8MBeiZ6Ik5m3x0gMJ0wjSxq+kbioyKfPr94p4WrohQcNMmbMrK8ig1C9WkHIhFDCbyvBeTnOh6BKXDKoN9N1q2oaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aik7QFHik93RUvlCwMoArtJxbrb/YXMPG90FiiZbu90=;
 b=lN34K88lIKbaLkfOrrtGdHDHnVBzs/vIlIaK9Pv/2DfaW8wRoan5TEZN03fvaimCCjRrfXbXiYxbwIptSuBrUtgOJgfUDjkBfnYPbO+2T/LwtZWil2rrIDd6pcANs8dchgNvxU6rtlu0L/thOkmLs2oI1U5V50lj90+TOSu4nIc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Fri, 27 Jun
 2025 15:47:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 15:47:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>, amd-gfx
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>, "Huang, Shimmer"
 <Shimmer.Huang@amd.com>, Koenig Christian <Koenig.Christian@amd.com>, "Lazar, 
 Lijo" <Lijo.Lazar@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: RE: [PATCH V3 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Thread-Topic: [PATCH V3 1/1] drm/amd/amdgpu: Release xcp drm memory after
 unplug
Thread-Index: AQHb5KrJEVj5k9RGh0q0RZci8E1ztrQXKsvA
Date: Fri, 27 Jun 2025 15:47:38 +0000
Message-ID: <BL1PR12MB5144DD6965ED1B00AC12B230F745A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250624015254.1162196-1-li.meng@amd.com>
 <20250624015254.1162196-2-li.meng@amd.com>
In-Reply-To: <20250624015254.1162196-2-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-27T15:42:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4360:EE_
x-ms-office365-filtering-correlation-id: 614dee76-522f-431d-a8d0-08ddb591f1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oJAY0XhBp/G8Os3gVxFIpETq+zerSE/PqHKYFBmvM3TH2p5zldu9sa5IfN/S?=
 =?us-ascii?Q?LYOskDqtuJZ2DL0WRrpvkguSqLYnKMEh8euZ1G1Y+CVyb6b3jvQzru+LJVom?=
 =?us-ascii?Q?1C/xrYdpU/nVN8ddGjWskCqY7wS9ebgu+tJkVHDshxxZz9sSzOvgaUB5uHl3?=
 =?us-ascii?Q?0cfXJlHH2Bb9Ypks0bCSdDofe29h0PGvVOfj8eEJuHZzlHVBf3mqGZVhqVk+?=
 =?us-ascii?Q?0Ulpuzo3nOuUop1N28+VSilSBRzOziC4Jn8tvDYE2n4U6lKeryg+pbGUF49D?=
 =?us-ascii?Q?AeWMblBSeiRgfi8Hsof09U+XSdgW7SEaqQmAwbsQXdDA9qJPz8bTzWLGFO/7?=
 =?us-ascii?Q?IzogqTNWDdZxNg8GNKqlj82Lo8yiSOcUQqNQwpLZKG17dOkF9pLTTsIDt73C?=
 =?us-ascii?Q?EqtsbogLp0Vllw70D9kLACTfUeOKDYYb1XvxvLlIbfr+ZzlSWJ9FMx1i+Xdm?=
 =?us-ascii?Q?uuvgPSdlkRMmurTIBGt2HE20hkb06yH3T5l/TZ/2xNq8Rau8+pbdvfCxYwm1?=
 =?us-ascii?Q?1qJIPti2J2JtV+IW28Q1JfVEeKEbwajHvpZ6aXPM5CGiSs6gepdoWmg8gvg3?=
 =?us-ascii?Q?2EEKI6ancfwAY7Wwrx3pr1aDT+gLO+T4gsQS62dw9jkQkp+JIlRNe0eEY7D3?=
 =?us-ascii?Q?p5WvY02TipSuZqoE1jXq6yKV1UyNxkO2AiJRE7L4vir9QuYYW2LMeTid7C0E?=
 =?us-ascii?Q?4S+w0jb+tLksIjjyuWkhcCL77ikNzF1KZyOmY5O+cDWqrftoxumHqCLgMh74?=
 =?us-ascii?Q?K3XUPeT6k7Fk/rYbGS6K8vlQbjfbIBl8i9Vj6HBn5EQH4GO0M3I4PN2DuQwB?=
 =?us-ascii?Q?miZObm7IJGLYwQnFIqtijmD4qOzmZkvqqtqkXLOsTQpP9Oq4F33F5ZC8HHZX?=
 =?us-ascii?Q?Odc4GKetGKUphMW35Zck9ehEmFs0yAH/eaPDTtv0aLmUrs8jgECdWlSXJnKc?=
 =?us-ascii?Q?C/J0NzsuZgs7txXdrwl1+3B/m3cIfa3Tu1bfSU7oDHr6mDvJNHY3BK+GMOet?=
 =?us-ascii?Q?HBCpwLFCKdOQhdJ8cl54flyVhd0HGyzMr41Pqg407K9LDP/dN2pCFWxBYtdG?=
 =?us-ascii?Q?bddTDZqQTt1c4sN2Xch3YFj6uJm/qafL/TQEmlC10W/aGfiwQi5MWGIwcP/h?=
 =?us-ascii?Q?cRn91U5pq1hscCxQH+7KvvhQBRjASqamYdDxzpZ2o7Oi7zSL0vO9UiDgxq7t?=
 =?us-ascii?Q?j8sBapFlqxLUK9nFwLgglBSW/4j8XnvObvRN6gDu6HX3QP4DdBAvkybDvmsq?=
 =?us-ascii?Q?fjyH+VRZ9ncXB4TysMg3tAcoBz65i0tLHKCdOMlVPyNNDZIqFuD9hQgTZWsI?=
 =?us-ascii?Q?z1M/0am9nr7neraw5046Hwj0nX9G9XVRT7y3zS0r5ZWRtDAxWl0CFlAIYIOZ?=
 =?us-ascii?Q?l7rAxWf5NSZsqn40KF5c8q/R/+WndgTx4qYKhA9iAJBwcZq0hk/8aQhqvaxq?=
 =?us-ascii?Q?8BnE46U5b9NpSO1Hi1454Bwj4Y6l3YkywJFF58PjVtovwDYzB6fcBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zk3rcY/kAuSIYti0E8wF1a476cWNj+gCNUWqyjoz0Hls16dwxoIHLBBJ2QNr?=
 =?us-ascii?Q?K/KvMRIawl9NqdL1vyJHNpYEiIGZXtuwqrCkztcx1vUw2V7Pv8NeQvBGRNqk?=
 =?us-ascii?Q?faywKHMmCZn9d9d+vHlkgk0jGOT9yA2k46gDIiSvNWLcffRf4GXdmW37mFvJ?=
 =?us-ascii?Q?yoVTpyEOEP43fFPF+eq0l7lqRoYu/IfcZYQJdNy3FL9BOVIgRTTCh+9tloLh?=
 =?us-ascii?Q?PfjD8AJfQj9xXCMZw5vITZMd/GMPyt5FfLTO2z4wn3nhOggROYQoAMcl7ecJ?=
 =?us-ascii?Q?QwD858fj85z0r5JW0xF5kxdp38UuONdwUXaXxU4KvIwBiP0tNymxzgeafFXU?=
 =?us-ascii?Q?flONSHz/bwAkm8gcUjxg0n3S1NV1QvNwaFnv0BHnHw6fMNHwr2H0z8fkNo8E?=
 =?us-ascii?Q?XPZrxNSY6DocEHNch2BwNrNqH1WPZeIEzkCK30MzV8Lv15tgJMowFRmjhfT8?=
 =?us-ascii?Q?u6rRlMVj/2E2j2wEWBSJUImK7djTtBkX+b8vVIVGDP/yVwnvQulWG/sBPa3w?=
 =?us-ascii?Q?9xJh7Il+/bq1UjrIIHAIXZ+KFRlLdyKaJRwuPsJmHntpwT+3qBgui9rhWucz?=
 =?us-ascii?Q?XShlwijumb2l9wfVqnUBrZj+sLbxfyb6Hgj+PoNhBttWVnTx9yOmIhsSpDSl?=
 =?us-ascii?Q?m2vnmT1bJihRJBhTpWpNfGqnohNxqMwUrb7u8rMdh6o7nMHbA7c+s3+chdg8?=
 =?us-ascii?Q?5OD+cIdpLz70wyRgDWZk0XG7x5UXEbFw1V8rO76i+/onCxbgkuLHpZjnMyaL?=
 =?us-ascii?Q?FQos+BaO1Ac+gq3f+dXm2Pk2JPZrzV6vCoDt0+yAbEeB9bL5bb7maGxtH+eR?=
 =?us-ascii?Q?SSoX/wjiloJqMdCZL1dZ7C9XI3yHwl9yDCn/TV3VF5FbuisuHSPyXlJvQIuo?=
 =?us-ascii?Q?3YYWHX8W1cB4gHcy0ISKIt+nMZPkQMtXxevDUxEDA5W1Q12+DwaPbJK7xH9M?=
 =?us-ascii?Q?DlLCogmUpT0ZafH/5XCARWddYP98Nabs1Czd998SFKhXPWNlc99TwkZPHjix?=
 =?us-ascii?Q?MLZk8lPjaZkLTwGzzhDlhDcvyAwsNwIcfWVFSpl1RiQrUNo7/Y8v2We0arVY?=
 =?us-ascii?Q?acUU52oyNa4fVsbQ7bOq5K/m8A7lnVU4obl5XE1/NXATmwfJh9Vzm+SxIVvd?=
 =?us-ascii?Q?zTnxt514vOvRwyaMcKJXSRR/Bum48NIDtZFkBO/p1dWUh5le78Z1bD7XaDWb?=
 =?us-ascii?Q?bwCCXHmoLqqX21X3m68wO6yryWDRppQkGNV6lMDMw85ZSNEBz3+kFJ02QvOO?=
 =?us-ascii?Q?vLKNliaUTgDtSB6KzsW/l2SL6jM74TJWYMU91H9Lr983zgUS75JO3eaxyQlt?=
 =?us-ascii?Q?RuQd0oQ6bpitIZNAXf7Yl6RG0Vg10RiCZ7VTdU3QLPlCdbf1FIPbLJ8Wh7C5?=
 =?us-ascii?Q?app84bL6kuNhOf1kI/AocUNsZ/P5ZW890vIW5Lcp9ZJXq4UbWUNMCsfUD271?=
 =?us-ascii?Q?7EBuyYG+AlgxKhKsVzlRgu2xlBxGZbkvHjb9cX9j98dPyerTF2u4beJMojI6?=
 =?us-ascii?Q?99PTmbITHvGTKBxa2o1FLiIKye+NNoJ3LcfjLIU4n7Ye5OCiQLmAwtTZN/1l?=
 =?us-ascii?Q?c3+ROBn3EANFVJv9YDE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614dee76-522f-431d-a8d0-08ddb591f1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 15:47:38.6460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LK89dyunK3bGOqvpzh++PsfXOOYdVF32hwH8DJGPVF9VF2L0RgWBAVufCEuZsGAowN83ZExQjmNqpu41jWPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

[Public]

> -----Original Message-----
> From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Sent: Monday, June 23, 2025 9:53 PM
> To: amd-gfx <amd-gfx@lists.freedesktop.org>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Koenig Christian <Koenig.Christian@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Jiang Liu <gerry@linux.alibaba.com>
> Subject: [PATCH V3 1/1] drm/amd/amdgpu: Release xcp drm memory after unpl=
ug
>
> Add a new API amdgpu_xcp_drm_dev_free().
> After unplug xcp device, need to release xcp drm memory etc.
>
> Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  3 files changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 322816805bfb..70c44961af95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device
> *adev)
>               p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
>               p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
>               p_ddev->vma_offset_manager =3D adev->xcp_mgr-
> >xcp[i].vma_offset_manager;
> +             amdgpu_xcp_drm_dev_free(p_ddev);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..3a8f3dd19a12 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,29 @@ static const struct drm_driver amdgpu_xcp_driver =3D =
{
>
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)  {
>       struct platform_device *pdev;
>       struct xcp_device *pxcp_dev;
>       char dev_name[20];
> -     int ret;
> +     int ret, i;
> +
> +     guard(mutex)(&xcp_mutex);
>
>       if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
>               return -ENODEV;
>
> -     snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +     for (i =3D 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +             if (!xcp_dev[i])
> +                     break;
> +     }
> +
> +     if (i >=3D MAX_XCP_PLATFORM_DEVICE)
> +             return -ENODEV;
> +
> +     snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
>       pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
>       if (IS_ERR(pdev))
>               return PTR_ERR(pdev);
> @@ -72,8 +83,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>               goto out_devres;
>       }
>
> -     xcp_dev[pdev_num] =3D pxcp_dev;
> -     xcp_dev[pdev_num]->pdev =3D pdev;
> +     xcp_dev[i] =3D pxcp_dev;
> +     xcp_dev[i]->pdev =3D pdev;
>       *ddev =3D &pxcp_dev->drm;
>       pdev_num++;
>
> @@ -88,16 +99,47 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev=
)
> }  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>
> -void amdgpu_xcp_drv_release(void)
> +static void free_xcp_dev(int8_t index)
>  {
> -     for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
> -             struct platform_device *pdev =3D xcp_dev[pdev_num]->pdev;
> +     if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
> +             struct platform_device *pdev =3D xcp_dev[index]->pdev;
>
>               devres_release_group(&pdev->dev, NULL);
>               platform_device_unregister(pdev);
> -             xcp_dev[pdev_num] =3D NULL;
> +
> +             xcp_dev[index] =3D NULL;
> +             pdev_num--;
> +     }
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev) {
> +     int8_t i =3D MAX_XCP_PLATFORM_DEVICE;

No need to init i here.  You aren't using the assigned value.  With that fi=
xed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
> +     guard(mutex)(&xcp_mutex);
> +
> +     for (i =3D 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +             if ((xcp_dev[i]) && (&xcp_dev[i]->drm =3D=3D ddev)) {
> +                     free_xcp_dev(i);
> +                     break;
> +             }
> +     }
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
> +void amdgpu_xcp_drv_release(void)
> +{
> +     int8_t i =3D 0;
> +
> +     guard(mutex)(&xcp_mutex);
> +
> +     if (pdev_num > 0) {
> +             for (i =3D 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +                     free_xcp_dev(i);
> +                     if (pdev_num =3D=3D 0)
> +                             break;
> +             }
>       }
> -     pdev_num =3D 0;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */
> --
> 2.43.0

