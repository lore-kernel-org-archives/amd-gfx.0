Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFF3C54734
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 08:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0965210E4D4;
	Wed, 28 Aug 2024 08:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JLLnnA22";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2E410E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 08:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kmo6gnVLSmQYm4Ex5kJhNrDV8BG2C9KioWXNOSCD/dtDqUCptD9oxOU4RxU0qg3XV9qneNE0/qFGDy8+Ow2xgtq2LcbeqSsP0rYjZc79J7vNk84TRwQGFViWvK3rE3XCPSY2fEV+PZZMK9B8YYFjPaZpgd5MSnnfa6/XkMwAnkhn1ILlCrPIK7W2Qzq7ClbcFKT49B9PdVs6vfsWJ0d4/VaFwL9pF/dfFw2rWt1kj9tAZ37k2k6JF9fTqFCHGAeQ9btmz6IviWtq0c52ODyFn9U8R5Pcw7uHhNcvhHtvTDDCOBSSY4nWYFNBkM3D9quJZ2U3PLoDYuJbfDsqO8pKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZLrNjoBXXgBPU5DCUE7AruYCN6wobtS/5CMP3UA5jk=;
 b=S64DXIsdn6bxRkeus+qM3oTX7xn1dhgDM9AkZwZiUA/D22m07xRdBeCz3N9nXSmTvmbD0tENsenLI/jcXhZpybry1D3kl3OgGgaCPYPbRVfJAG2pi+3seHYi4AFIa5zG1quG8yKV+hzW1ggGu/IjgHQAbLWMA/LwCKg4PM6gYDxX6E9B4RY0NAKtGQ1lK9f9K+V2YpBn1D+pLFtwTjsTtiR3Je36YJCNE5IZjs7n4mV060tbJ04ucEIaxRGvFzDiPlFISj3KXaoUqfVyItYQY3CLivCRAwVaVn+WhaGzgpkmd46LsrMII3v9eCWcbQ3tV/oLaF0cQEGUfIjnWRzB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZLrNjoBXXgBPU5DCUE7AruYCN6wobtS/5CMP3UA5jk=;
 b=JLLnnA22ijpjDEH2Xi7VBycb8URsNVg9AX5bwhR/79H+zF6DRgHHRYKPAuen8SzVe5WCKqq6eCajpu5EeHVbzwznYxyEOisBd0pJ34OaZdj08mtsjMJkkduY7oQoDN+hbq62mM+5guEQqd0R0ViUaZp6jcMpyBmJMvdrsz+JchQ=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 08:20:09 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:20:09 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Move the dumping log out of for loop
Thread-Topic: [PATCH] drm/amdgpu: Move the dumping log out of for loop
Thread-Index: AQHa+SGYznpoqagwdkqBHqr5eq0aBrI8U5vA
Date: Wed, 28 Aug 2024 08:20:09 +0000
Message-ID: <SA1PR12MB74424DBF8C71E3100127EA1CFE952@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240828080916.1498029-1-sunil.khatri@amd.com>
In-Reply-To: <20240828080916.1498029-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d2982e61-a15b-4fbd-9731-ec95fa9159ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-28T08:18:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|CH3PR12MB9077:EE_
x-ms-office365-filtering-correlation-id: d88f8cfe-4e0c-49d6-87b5-08dcc73a3b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0ejF2PK8SuGzCBC0cOu378mmWqFxjjWDIto8aoIrXFe+ntL1sEKLZVVk11FV?=
 =?us-ascii?Q?Btacuwa9MjqYmNoFrsWs8DDk0jW1zdwgUXB5edzred47EpUAEsaGiRx3zvSF?=
 =?us-ascii?Q?8yX+2ZUzILdVwIInJtaMwWBw4XjSuH/udapNTmlN3gUaZmD59I1Nem7sfCrG?=
 =?us-ascii?Q?TK38fYyQtt3MFmB1xYMM1oSToCJKVIEg0FRCm57fwcciBls3Q5GfTYV2wZIn?=
 =?us-ascii?Q?XVPRnP7TFLWOgic/UWCt5OZ85W5gbRv8VjwSvbGVEazhNKmin+4TphxhN6Dz?=
 =?us-ascii?Q?82DZoLFr6SFKCXsFbA/zKkBZlQNPuT8w6rtSzeLaklNPkDjwRVkDb4zT1r17?=
 =?us-ascii?Q?AXGCBhs0/l/O+1ZEf/iDxhytZOeCFbbfqJaIWcplaGvRlPzrrpHQws/D0FTo?=
 =?us-ascii?Q?NYrVD2dIU1EJiZfwXZweGKGCN+Y2ctRbZFBm7e6jyQ6wyul/9evQpaj0vEtL?=
 =?us-ascii?Q?bHkQVfhGPhPqjeo2w0Reo6lV/l3WNAYJs9Zdg9uH9TQ7uBdF/2wapYbI5/BL?=
 =?us-ascii?Q?TCBSDHIEuJD52TcHAz0cWX6YGV6MNbFO6aLa7IwllKKHzc68YTsGl80K7/uw?=
 =?us-ascii?Q?QPW70pVec78AFtDh2hvLJV1ESxYyiCUdQp5QFLrNSj7+58Hc5x0yi70kHPgI?=
 =?us-ascii?Q?50G0auZNRvGehEe6qRmYsZzyECiry1fsViDBzUwrGVp7+J0bk3MqxYx2aa2w?=
 =?us-ascii?Q?9Tu30mnkNvo0v6FgwDl93ck5MucyTOAHpqLFfccmM5y52gMrWHJfdIDEP8WQ?=
 =?us-ascii?Q?172rw3Istamj9AkyVDRm/tpcmRXS8efMXoU5lfpjsR7pmbgTYQUwvKTNVAym?=
 =?us-ascii?Q?uDlP7ymhgIPq5TYdgvTCI9HN64m15vEvDD1sOqFEVZH2jPQHfLynbuYRpxfy?=
 =?us-ascii?Q?HRx8Fv4EzKxf8yxlu9ajkPuBifYOT6WfvT331KvS0CHKxwerjnsVXUGvZzmf?=
 =?us-ascii?Q?DtKOFdqazUOxzIiEBbin0jzFIfEBxuSMuDkcSS8Rz7e1bHBVr2m4M9FOiK08?=
 =?us-ascii?Q?4eXuqsOrneR6tmyk/BkYg4BH3N8k18AOepIkZLp7uJ7khQUttvxuPH+BXuY8?=
 =?us-ascii?Q?tzTnE5tdv7yyuyzr1qri/eLRKtxDTbP7TCGMx3g6d9xTexMykM021mGFafvQ?=
 =?us-ascii?Q?h8/K6iA2ar3bUNbm//O+SmJjtiqc6Vj2APR+SRvVrLspJj8E7Ihl0NbfFa7w?=
 =?us-ascii?Q?O6W2lHxZllvqOuFYWxeQ+X7RQPNn28WJe667GmWXcf+WU82FYzLfeog7xbW4?=
 =?us-ascii?Q?A6fm1yP2U2qb9Q34fr2CCjPl3Wuczs2S/sdGEpNj47g67SNECln7QfHw3EST?=
 =?us-ascii?Q?sUvx3nfkFyC0L+CsrQMYZMa1eYlNTgzFTzz++vH/DkFKx9Ib7gcVF/dI/w8e?=
 =?us-ascii?Q?ZTmS4BtQ0wgUxJJXESnwT6X6w+kWkvybAXmvAorGMK7oc5OgAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ktnuCLRA0Ql8WRJeQLAXkXmsmi5/Qb5wq9vJ3h0o2+/zncopDqpR+re4wLjz?=
 =?us-ascii?Q?svUHI3YqCZr0RXNAkh55rEJbfjrrxGCee/xY4pGDM1gMNAA8u69h0iqCe9Qh?=
 =?us-ascii?Q?mPBDXNhjh/AP6R+BkCWjjz4QFi79NLIizVzGnoTsH2m/3oUpsie7Q4rPa3Ij?=
 =?us-ascii?Q?98Bp9MxvCZrlW+7gpRoOcUXzReevg3u3/xktuCRbChN7bpQsQFnzfVI4rvn5?=
 =?us-ascii?Q?yhxZvGBvw8plCSzyiOc7xoNaURaXoeCECSOeK1pg8BjceudFl6GeRf8RkQT8?=
 =?us-ascii?Q?wduY4oWmfTBQLsl2dLlJe351rJ+8JJ+yKuMbAAq9zYpm/6QM0vdrFo6nyT94?=
 =?us-ascii?Q?x/kBGTQq6cJiffFacR+cyJ0dwbIluPjUwrXkl1pspc+eOc0LejeCy9BVA/Cf?=
 =?us-ascii?Q?cVgM1QR915uJfNunCuijWAt/evU/f5G71iNVHEdroS18D5e6255q4M3YVWJR?=
 =?us-ascii?Q?bpV1TLdOrypzQG42Pi7175h9EJUU65osh7HN/99IWzOknJaRVx9xdHGh4exh?=
 =?us-ascii?Q?qm9iBNLwj5WD6TwGBvU8b19GPi1gc0/Zn0WC6JELnuTAUXy8zd5UO5EwDvvO?=
 =?us-ascii?Q?1i5N5zQjRAs/xb9jMlgpY3QwSO0nCnbJTsQeFvbkAc8NpyN8U+h+FKWefepx?=
 =?us-ascii?Q?jUHgdKIk8osTJPAONeAdqVgPyKNkCOJ2YhEtrXhragRL67Q/PbaVr1pQRJsO?=
 =?us-ascii?Q?6aR6cX3eYLLKuGqUxLhklnwfvxGy+ZHfLGnCCrPOAG9Dc6H9v4uoFXYSHceY?=
 =?us-ascii?Q?m6KFl8iKjd6ItDOdfcIYbRCKwEAx+fw0DRfb2ixXduer6kECiF0vmjEQCKGH?=
 =?us-ascii?Q?psL8BPKwxkgcsvj86uKokPjUx1BJyVU70zMJN/Fg0mxbF+PrprgAdeN2Vcx0?=
 =?us-ascii?Q?0pR1WhyWoaXPdDqEam/Wy4wx2rl7KEX/7hM2fQ+LnkbiIWzw5xIJVT4X4rjf?=
 =?us-ascii?Q?xcQi/Y8AEx8XZKitkaonuUxF69+RSK7vanWW4BgFi9yAxXUMs6mQcjZoIwW0?=
 =?us-ascii?Q?dpQfb/397zDgsULa9u/LJwlinFSolp0JXrbeZhW7SkUBojhh0bb0h40h4607?=
 =?us-ascii?Q?nr+ruxQOskPG3cKdv9RuyE/VoYhzM2ndMpsaFpchQid21cxQCRQ1Q1z+OcBF?=
 =?us-ascii?Q?6VEzasKkVheiyd80Vrpb+e91ywBI8lydI7JN8D+MSYSfo9551AF6btyXcSU6?=
 =?us-ascii?Q?StTls5A2+JZx5rAbELYif2f0aE5EoqWPlyi+qxjncpHkg2c8CuktQVRZj1kQ?=
 =?us-ascii?Q?Sn9TYLrWRFyiINAvLBkmafgvnGavj0MTPpK9vvWIgeMcSDTFLesrn9UkrVle?=
 =?us-ascii?Q?3/1KGP64AZD6uIfDUBr2TbD12SYLLMNMPYfYHZummrEv6oq/OFoPdWH17rVJ?=
 =?us-ascii?Q?ZQPwmJdd10PksiuB8cxPMvTuQ3uDG4aghZIFc5ismxVvFN4p6vazRpKIHpZN?=
 =?us-ascii?Q?mWxhuLfYbq51y4HO0myFcjGT3P1GTb93wWrqGW73A4K/PUGl480Btyupq79I?=
 =?us-ascii?Q?9qHuFM8cJiKfsrQey3kKf06iirnhrmsn8ORKMNZvwds/peIpGZueWs29fn4V?=
 =?us-ascii?Q?aQZzO4yV3tAUUavYzxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88f8cfe-4e0c-49d6-87b5-08dcc73a3b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 08:20:09.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu1S8lZl0hVNT/X9TPOfUVGPLWK6fy0YNTQ6zIvg916CLCYZiR8/4KhBPJt7zaFMiV9ZPHl5uX6X2QCfP6kr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

Acked-by: Trigger Huang <Trigger.Huang@amd.com>

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Wednesday, August 28, 2024 4:09 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Trigger
> <Trigger.Huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/amdgpu: Move the dumping log out of for loop
>
> log message "Dumping IP State Completed" needs to be logged only once
> when state dumping is complete.
>
> Hence moving it out of the for loop.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3000a49b3e5c..381c886298bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -39,12 +39,11 @@ static void amdgpu_job_do_core_dump(struct
> amdgpu_device *adev,
>       int i;
>
>       dev_info(adev->dev, "Dumping IP State\n");
> -     for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +     for (i =3D 0; i < adev->num_ip_blocks; i++)
>               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>                       adev->ip_blocks[i].version->funcs
>                               ->dump_ip_state((void *)adev);
> -             dev_info(adev->dev, "Dumping IP State Completed\n");
> -     }
> +     dev_info(adev->dev, "Dumping IP State Completed\n");
>
>       amdgpu_coredump(adev, true, false, job);  }
> --
> 2.34.1

