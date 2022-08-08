Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE7C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 22:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484E69B55C;
	Mon,  8 Aug 2022 22:31:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00429B534
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 22:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb4ThLVLp8e3PxNiRRYgOqoPDhbQUoUgrwepkmOZOCqr6YG2jrQB6Xi/T6DRp9l0LIMPO0SpwlAmj2WFEEitSVR/kUcC6jhldZwI9anJEJY5K1ZQj+HJUsyedtt/Kbl94Uwt4Il+5COiI3xo2mL1COx7dB8cPzTbHqpoEAbvSsOUAs84qdzO3xWPQ2MeloBr1sqnhku/HZ8xmWdWBUrwkrxL3SDF1PRPsbiDHrHGKr58NzR2eGBCaht/VbZaaXW0j+A7vg4jice+ZMbqOsXK/KHmysOUhypDzJRWh8xiaksLku4bGUFcEZNXPRu55P5ritXFsqaTmldKPJE31iXMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu78Hh3dXo4Wy+qkVF0pMUlQFpqdU7ykStP0LHBLae4=;
 b=VB3Qd/BF969UBFeQmMUsfzC5zUAALcfDtWcGbnjqCSpQ3exfar4vyYhZMZbl+cRxkBFpYWiYiFp42dVaZ1TGDgfxJCt7mZ3qGWSHewbqBTLJmqmOd3RCBEyjia7+Tz0JWjcu4/pgDUn5kO2B/epl5fFfiQdbNwitJIlCI2Hbh3VtE50P7TfXCI3UBdum70CGsEJznFaptnR+yD9MgazilvRted4kwl3krbssdkxWSWi5VZXoO0scnWLTkP7xG/FBY5m66zfYsljhYPFfBad/qc79yEXTv6JIhEETVn09Yn9MpDMfA69toussjm9NQnyMf39aZF2UGMQniGZyqm5Z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu78Hh3dXo4Wy+qkVF0pMUlQFpqdU7ykStP0LHBLae4=;
 b=u1Psx5Pljjl9K85LrZPDSMJ703pQH1XYJXjKRmCpqTDWG95zefW3KYzKC+YnjtvSq8G1ySUCJUDGKu1m2WmBhprqA9TM3S5wtG7i02DzTX5Ae7M7JMkP6ppzsJ2ad6b9RXLs/wBsMP8hvnkAuwguAa7cjZLKqGQ3nhppbJsEXZw=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 22:30:53 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 22:30:53 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Milinkovic, Dusica"
 <Dusica.Milinkovic@amd.com>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov
Thread-Topic: [PATCH] Increase tlb flush timeout for sriov
Thread-Index: AQHYpxfUd4E04sktykOPAqugJHA3Fq2lgnSAgAADRiI=
Date: Mon, 8 Aug 2022 22:30:53 +0000
Message-ID: <CH0PR12MB537246946D63A6599FD167CAF4639@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220803090134.529299-1-dusica.milinkovic@amd.com>
 <CADnq5_ODjyTHPpGcsuHpbmaC-_MXvzKq7xXVKY9e5q7bwRBAfw@mail.gmail.com>
In-Reply-To: <CADnq5_ODjyTHPpGcsuHpbmaC-_MXvzKq7xXVKY9e5q7bwRBAfw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bede6f13-7b60-4bc3-f534-08da798da764
x-ms-traffictypediagnostic: SJ1PR12MB6340:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dI0SpY3a+1OOBm8KCkju5CNv1oU33xT0+HxPmyaIT15f/JtTVk6mVEZgEa186o5IPcZk/yqFoMJZnaVptucejr7EOKWojr303jSTvB1y+VBeP4u3IE50rwm3AlptwgfuI1Cx1S6buB50cK4Z5TRSRmM6MYjgSPLKXD/PbEAu+ZFIbWb+Dgya4es/w/bLZRnAHCIFN6ruUbVi49/luEcdSU9eRRTD3RR4uKaPNMi7IxyOHazti+Ei8fbBVnlLFJsU2urxD3LddvHtI+qsQRHigWOzBZ4q6TZKnr3uNgjjf4YwMADKgUSqKw55hRpwquT1AnED2EBTjspxGNP01WWoND5J5eU/DWNXOAjPpfDlMnb1lHxMMh4o+Xo8PUkKx55W+E0+c7N5D/U74QNZR2wT1TSmBlsQvWguSPG/Jdn0Sem+rYkSRn/uqXvXhSo7085X40JQvsKuorZf42JS9SIV6S3YduSNXt2ispZHc4LqG5tn4C+3R1rq8+acSZJ8hguCYLNVmZTiDhtXXQ0s3LfH/SP5tu80NPPAXlK14MIoF+qFMjZw5drceXtOsGV4qYCQ67qAqA6YOuXB3xbOr5ZCr4L/jOl/MaQyj5Y2/zCoHo4v8EVmiYcGosV+PGkrNRUL7xwDfRMVj5Kxj7pBgWUrDl+rzbTSRlkyKpOGMVSZbcwskAMQkbXp1nsWYAS4gfBCsXcpUlGkoD2SuwR+8umRvALy5gtCJ8rfY57Hcut5MjR3IWvVIWck4wQL4XC7ZST1zdEfvAsoRELqHk9WtC5PiIrIJDyqCO/pJMS4cKz/ErRvQDgaqyD8/8FkE4Mjc6/L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(26005)(9686003)(38070700005)(53546011)(33656002)(478600001)(5660300002)(6506007)(38100700002)(2906002)(7696005)(41300700001)(122000001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(52536014)(8936002)(8676002)(83380400001)(76116006)(6636002)(110136005)(91956017)(71200400001)(316002)(55016003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ceuFJ0hsunNvGFGwTFSDE/TRHvNLtSaT0PnFpnhiREp3ooF25XVgE/WWC7?=
 =?iso-8859-1?Q?pv8dZ/Ai6rWULpaR3Yfzd1bgKVfoMcb7cU8f6Tn1PsVyatIu22kztBD7Ly?=
 =?iso-8859-1?Q?NMeKLzldywqDhIH9519fHvw7aEO6rECt3BoPiiFgipU+HC31PrSzlkwu8i?=
 =?iso-8859-1?Q?IvIDXRfzRdwo4Rnj0YrSPt9Bo8dsXoJGmwJbcfyLGIq0OnPPjh4bWrCdzA?=
 =?iso-8859-1?Q?et5+458Qen+mi7DeFzclUjlHbbm13eMte9KJoQrr3FrcRP7nDafdk7lxl1?=
 =?iso-8859-1?Q?c/XWVH75g+/ZirIqprpKrnFfufmbZizGLDEu1JwqHUWVKaK0wxQsQBZjw1?=
 =?iso-8859-1?Q?ChBtx+F5S5pN94dVK77ELrjQ2skw67tcWSASqdg634FBtBPVq+l/3Wq/J7?=
 =?iso-8859-1?Q?y5yUALV86AvuM8nq7BD5DzJPKvKVyj9D+HzF0TBL1JH2Aosgau693vjJQy?=
 =?iso-8859-1?Q?ZHJUIBHFwXwlVh8odlNa+Ai0ZiB5k6Dv504Z3JuYQQR5UxZTrH137gdszz?=
 =?iso-8859-1?Q?BgzY+qqyuNP/lr+hdtlBBmHldqBwYu7pWqXVb0hXy8Gk6uTsa1AL4cM4E1?=
 =?iso-8859-1?Q?FlppkgGDu19u+MD4hQnhM2N1VQPUROEUZY/4J957B4+We7KuD+Jwl4FAzj?=
 =?iso-8859-1?Q?V06mdzQcDXI306QHe1uWmCmtivQyAcWFva/orqvEEZJ8TddO5UwAGwibVb?=
 =?iso-8859-1?Q?7P1YezxNOgfODJ9fDnWJ0/E33QY85xuWPljBxSnoUTQxyF+BrRYj06Ds58?=
 =?iso-8859-1?Q?zz7AfyoQ1lQAYGXYLQMgr+yaqC71GXlwTE33C3AzoGfHi2w7szMr2qeX+r?=
 =?iso-8859-1?Q?L7r5Cxa9BHamuMlUUFv7aai8zpUtPgRK1I5gfX/WghCVoGXZEnNLi8yyIy?=
 =?iso-8859-1?Q?aJVKwLl9GT5ChCeavPtNbLm3Vthkk72XTYjHh/3MIQDnk+HUonFKYBgM/p?=
 =?iso-8859-1?Q?pPpm+mqxi9c/ApsWCewWOhGxdCLbLnSXh3NjyA5gGn1CFmXpdWjz9kgWxt?=
 =?iso-8859-1?Q?Dn5iX7fFNJcNl5NglBica/dihd8jq410NoN4dwz+79m58Zm2FJqDtXsn0U?=
 =?iso-8859-1?Q?iTX41AbiSnlVzxIL3i5Sn6QLlieeQ87AbShXJTQxH7xV56FyU+U37nOcGM?=
 =?iso-8859-1?Q?BlwYMozTPyBQXPQfgH5B+zK6KvasUXXFOqPXWG/OlTaRZGt++LMeLFy7/V?=
 =?iso-8859-1?Q?CFv8tkc6SeyE/nDhqwz5gEoKvywtQf+k0asa+EcPPU9TpY6MFq4IWeSSpN?=
 =?iso-8859-1?Q?crKDhZE8fGI6oZtQ/LLOixs9Ms3OfmTXrhJYB8G0dGEXrHsl/S5m2JGYLi?=
 =?iso-8859-1?Q?PvtChgiD88XWKKApFGBHK43VZp3KSN7A/Yxvk0DJAIWVABjbDapnkVpWUi?=
 =?iso-8859-1?Q?yqXI9bQKJB5Rc2/XK2WHJyNuPOW3OqCVRiapsrk5vPqCYyUazodHh2XH9T?=
 =?iso-8859-1?Q?UMu0tXrilv1mh4WCmyBmJkoS6YYpmxrN7NyyvkeWLyFUxnHasY0xeczqUY?=
 =?iso-8859-1?Q?qPj2/kxC/mvgcRMSaw6cbJFHxQ+dhGIoah1J05LlQAZrVfYmlh9tKHIZWV?=
 =?iso-8859-1?Q?n3svsohJCW+gIWjFacCyTiqEUj1DZbqwRRDEoAc83dE6mooVDfyI7vsRPw?=
 =?iso-8859-1?Q?X4PuddxsZnjnU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB537246946D63A6599FD167CAF4639CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bede6f13-7b60-4bc3-f534-08da798da764
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 22:30:53.1638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiTBy9TSpvnz0DM1codkCqvqBN42gvZ1aOA6cKrdBXFAwi051NazyDtS7XJbfczPR1D7LPC79Gc3XabWzsf8WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB537246946D63A6599FD167CAF4639CH0PR12MB5372namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

As I discussed with Alice ,this change is when multi-vf running compute ben=
chmark (Luxmark) at the same time, which involves multiple vf  do the tlb i=
nvalidation at the same time. They observed kiq timeout after submit the tl=
b invalidate command. Although each vf has the invalidate register set, but=
 from hw, the invalidate requests are queue to execute.

Alice, as we discussed, we can use maximum 12*100ms for the timeout , it sh=
ouldn't be 6000ms. Did you see issues with 1200 ms timeout?

Regards
Shaoyun.liu
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: August 8, 2022 4:49 PM
To: Milinkovic, Dusica <Dusica.Milinkovic@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Increase tlb flush timeout for sriov

On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic
<dusica.milinkovic@amd.com> wrote:
>

Please include a patch description.  Why do you need a longer timeout?
 What problem does it fix?

> Signed-off-by: Dusica Milinkovic <dusica.milinkovic@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..6ab7d329916f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

What about something like this?
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :
adev->usec_timeout;  /* wait for 12 * 500ms for SRIOV */
...
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);


>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 22761a3bb818..941a6b52fa72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       uint32_t sriov_usec_timeout =3D 6000000;  /* wait for 12 * 500ms =
for SRIOV */
>         struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
>
> @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> +               if (amdgpu_sriov_vf(adev))
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> +               else
> +                       r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);

Same comment here.

Alex

>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
>                         up_read(&adev->reset_domain->sem);
> --
> 2.25.1
>

--_000_CH0PR12MB537246946D63A6599FD167CAF4639CH0PR12MB5372namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit;"></=
div>
<div>As I discussed with Alice ,this change is when multi-vf running comput=
e benchmark (Luxmark) at the same time, which involves multiple vf&nbsp; do=
 the tlb invalidation at the same time. They observed kiq timeout after sub=
mit the tlb invalidate command. Although
 each vf has the invalidate register set, but from hw, the invalidate reque=
sts are queue to execute.
</div>
<div><br>
</div>
<div>Alice, as we discussed, we can use maximum 12*100ms for the timeout , =
it shouldn't be 6000ms. Did you see issues with 1200 ms timeout?</div>
<div><br>
</div>
<div>Regards</div>
<div>Shaoyun.liu</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> August 8, 2022 4:49 PM<br>
<b>To:</b> Milinkovic, Dusica &lt;Dusica.Milinkovic@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] Increase tlb flush timeout for sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Aug 3, 2022 at 5:02 AM Dusica Milinkovic<b=
r>
&lt;dusica.milinkovic@amd.com&gt; wrote:<br>
&gt;<br>
<br>
Please include a patch description.&nbsp; Why do you need a longer timeout?=
<br>
&nbsp;What problem does it fix?<br>
<br>
&gt; Signed-off-by: Dusica Milinkovic &lt;dusica.milinkovic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp; | 6 +++++-<br>
&gt;&nbsp; 2 files changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c<br>
&gt; index 9ae8cdaa033e..6ab7d329916f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct a=
mdgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
What about something like this?<br>
u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? 6000000 :<br>
adev-&gt;usec_timeout;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
...<br>
r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -ETIME;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 22761a3bb818..941a6b52fa72 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout =3D =
6000000;&nbsp; /* wait for 12 * 500ms for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ri=
ng =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq=
 =3D &amp;adev-&gt;gfx.kiq;<br>
&gt;<br>
&gt; @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, adev-&gt;usec_ti=
meout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, sriov_usec_timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_fence_wait_polling(ring, seq, adev-&gt;usec_timeout);<br>
<br>
Same comment here.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ev_err(adev-&gt;dev, &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
p_read(&amp;adev-&gt;reset_domain-&gt;sem);<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB537246946D63A6599FD167CAF4639CH0PR12MB5372namp_--
