Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D900E8B383
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 01:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E933C10E25D;
	Wed,  4 Feb 2026 01:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3EmBjDn7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988FC10E25D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 01:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAvTC4mO1mpP2x3oAuIVT9nqEBcaqXgt/7LdS7VLzEoI4mEw5xd+jpsqfmZnTLvnmLzgtqcvjtlk+NYzixfINWaFdhPeME94k2LenJdCSCakU08pow7cR3npFfl7RdIOtTV2G36CbFn3m0kVj7dK+0etje/hRIU/qUrvU5HOYC7HIe0Tf3Mgh2X+dpgl9Wmvdft3eR0+U/F9lXbU4we7dpn4n7ZSh+98efJlOgMxhMoFpMESpJOHsZhbxN4DjOUYpmulhPTz3RcmQvjcMhmPKGg2RzFTJjGiRuu++TP1XWRvtpCQa4f6foCpx4UyfY9hvlqWtfq08fnrJ2xq2c0LmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8z//33hcNrDI3jgwJ0PdXt8t7VNUieswA1TEf4hK80=;
 b=twQwLlrZ8lN6vO+yY1N4gP9DqIbEsGbHtwucKZmgC6LMT9D/Df9riawngYGXjFs7HB0i3ZaYrgpk8mT5xIbH6hfkyYgyRpRKDWHOVMXKju/PHQsn3jxnTGYGX3nGYneG6342YxwyMfEscijErmHnZ2VUxIg+ZrZB8bk5Fwi2o/1dDJ+Jtv90kMVkkx5sOvMCSiTPDfxv9fKqn84zcyryijm5hV2BqOEFXQS8n007CL8qRLhn8AzU2iAD42xesJ8IZmVuUetcxj8QdEZsvIB4MAhU6uoHKj8LpJACU15PnMQXkAtYcODHMUtUGjtf3BTBNJ+F5Z5afSbuMI7aOEDUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8z//33hcNrDI3jgwJ0PdXt8t7VNUieswA1TEf4hK80=;
 b=3EmBjDn75vIob6R56LoQVu2wbOIBL9LGRjZNDZJyWMZnPoxQo2jMrsndYMqOZZ2VP2QwwtHV1RxIHXvGlH3C8lS1qOtYd9rluXsyPjs1VQsBjRTqkhE1Hnh8TatJ2KIngdSL5EcMZSU7+3GyAC80vNG1G3VxLP7NwtTSry2mz9M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 01:43:08 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 01:43:08 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/sdma5: enable queue resets unconditionally
Thread-Topic: [PATCH 1/3] drm/amdgpu/sdma5: enable queue resets unconditionally
Thread-Index: AQHclS9K027mzB8gNEiwE9sQYxJT/bVxxFEA
Date: Wed, 4 Feb 2026 01:43:07 +0000
Message-ID: <DM4PR12MB515239EDFF36120BFF292E7CE398A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260203170506.21205-1-alexander.deucher@amd.com>
In-Reply-To: <20260203170506.21205-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T01:41:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BY5PR12MB4307:EE_
x-ms-office365-filtering-correlation-id: cc69fe79-7893-4d7c-1895-08de638ebf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oK8Ae3XWKK7vjjAwy8ID9/gk/RR0gYsVPs+CV6nC5oXvfPU1nX4gjHyc1Z+D?=
 =?us-ascii?Q?xqJm7DhUmhH9ubV0JSZnCwdLtewHwBzvVtfXZBnUy1yuTG/dFhMZBIwLgI/D?=
 =?us-ascii?Q?DmO1t+i0dQXpLJxejL1YHweQ1Nc0krlE2iSN67/LRHJed0xLbMhcCgscgM7+?=
 =?us-ascii?Q?KHXwkEghPdiM6v/GhFdvHo2WRbxN/9TX3tWYKYNX6tTQOlwV0s+v46vvMUrG?=
 =?us-ascii?Q?Xu7g27BjmDH44d0VdCivgOKFtkZC8S/yejo5JeqOANSKjYE53s8y9jQtoeNj?=
 =?us-ascii?Q?bCyvRkAj8UpCsNR9+cotW9nTHRgairLfBrtHFp01trTVPm16WuRsC0HF1Ass?=
 =?us-ascii?Q?WIJdPepSp21ZNH0lZTXmyooKBLv9VUz+Uczo8dkqSXTCypZ0yC73HOlufMxR?=
 =?us-ascii?Q?9qejW5sg3wicyIjZQ3wy8notNnkGi6Nd/nYlvIMD9GvetLV7RpKX9Ee3DC4D?=
 =?us-ascii?Q?T17rLniqxuNHqfFcq9BWWcLkKdxuSeYtATpcjpxwXrcCGj8qpMtQ0Kdfmhyb?=
 =?us-ascii?Q?hR33YfTDQHxbiFJcaMotBeVqYbbv5jbYYk51JikDvYqF3yJoWp3h0EbUwh0S?=
 =?us-ascii?Q?Bu0ygfqATQpXgeoiw0/Uxj3Rexu/xDD2kp8j+XS8bq73AmFPZoLhnhnbaxCH?=
 =?us-ascii?Q?UoW1BniLYu5SuRey5hGuEebeFeoueJ9cj+CbOqhR6BjqCiV5fZgVZWTSsRnd?=
 =?us-ascii?Q?V9oKKuM4/1Zqiz7VCwsRIF8x+PM8BuGIvXd6aGBJca8WLT2NxZN3rdCSRHR1?=
 =?us-ascii?Q?rLjE+zo6i0f63tfF4VtRTXjFMkkrPkr5W7vLlDRTOSGsTttkMjOTjrseqMFs?=
 =?us-ascii?Q?okNuVK6V77acEtnAKogkeIgtzVoJAGrDGjZSdeJ395iegtE0qOEPdiK7BR/0?=
 =?us-ascii?Q?f7NaNpsLfoZziLREXSGGt6ERogBnuJXWUt/8skCll5WLZbKhz56m2I22wRfb?=
 =?us-ascii?Q?YY0EV1LTw2QH6OJdY0J2YCsC6HEl88ze+ri/Bve4bGh0Ms68djVNiHajE5MT?=
 =?us-ascii?Q?biqE4yje6VTEu3XrX31Vy5vXSQy4jP/c+a/4Jo9fsRwqx8dX2rFXxxtgpfze?=
 =?us-ascii?Q?fb/EACiJBqtl/+PcRm2nePEk21jM2cgfrriqQ0tIDN5zd/zibba3+Q4+Owef?=
 =?us-ascii?Q?ugZGIMux8IIgX1NHByKl1mPqjwf/qOw2Tj29Q+KWCom59q7uzM87RdXq8EB+?=
 =?us-ascii?Q?BUlglq5olHqdG98lErLCWtb+jQRojzSuXjwnvRlRDL1Je8yURTYJ47f6PahA?=
 =?us-ascii?Q?dAdqqUkMxD+7k1KA2BdH/DNlUhKSiq5xreoqk+/uWdCq2iF0+j/z7z17MGwe?=
 =?us-ascii?Q?c8lyq1igZLbbn9BJdCETWcYPr0eo8N0C8NZNeO1q2Rs1NSZch8SmF0W0rdFW?=
 =?us-ascii?Q?6AUe7TlFfRlNkqYMu5dtVRV8l7MAuctUS1mCOCEYZC/MIcArFGYB1LHDNJkO?=
 =?us-ascii?Q?W5nhj1Mt4XoeKtEtP9xaxQJzeCBVVFgH2x3fCmTzxJaAglue8ab1HWjw4XMY?=
 =?us-ascii?Q?p3ZbXS4avEY4nXq0Li0TI4lm1CTKIyf9uHGIrDABsqERlGQx+ESPFgSHjkG4?=
 =?us-ascii?Q?sE0qoP9523XL2ZN87Ll2PZyceztucS8L10jLrPzjeT7HDoX8Co0jTDNMr77R?=
 =?us-ascii?Q?PtuILYup9JVgp2AtmEvKBdg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3D7CRqbquQoxyUq9pS4TbOG+BtL2g87dVG9N+oZM2aJlzn+F3g4d7+Hcfxi?=
 =?us-ascii?Q?005KlH2/dzWmBwSMt7I3/TRkRPUagwwi6hq38DeU3WnC/00mErxPE8ZVJVsu?=
 =?us-ascii?Q?Pt4u6Vb+ZpdtRehrlAACIl1E0lQFY1rSzbbaZaUvChJggZxU5ChP4Hgh08ML?=
 =?us-ascii?Q?gwKVTSnSeBL6z9tzlpELCVh1CQ4m/vh8P391S50Was/MArQ08BoJ0yDNq/9v?=
 =?us-ascii?Q?Q3/QHyq9aYe3X6685h1Izy3EyogPM6XTINJLHAXXmnayYRScROayh2Xo71bm?=
 =?us-ascii?Q?7ciC6ig7wCHU2irhdc3h0nUam51lBKNbN7xZ5Ii4V5ZT23Y1ZPsKIRmqB429?=
 =?us-ascii?Q?t5Sk+4sMohsTPd6XGJh/fze+RDrNiNFfegh0a9sM15s0hMCp4NWfPwVYT10U?=
 =?us-ascii?Q?ubhFptb99lqzLClMtb6Q42QHYN0A1AhF2WNKWEH8Qyw5mpaXl/jL39hxLjFP?=
 =?us-ascii?Q?aPjUTDrmFjOiHLNO0oqTRDvdtP/YRebPHYpUutIyi42xf3iKA/klwIpqY43y?=
 =?us-ascii?Q?3tepkLEPKZGbhL+JvanJkNUUDS6/3neYXIJdHtB32ZBRun0jXclu4vtibxI+?=
 =?us-ascii?Q?UU3sadfUkByZTbiey8asOHYkcnz1ztjPm8FALczWYj4pVYxqcXLf6lFnXtNs?=
 =?us-ascii?Q?kteI5j5XikeuUswQOyCPsBhR8HX7LnLhC3ZChZ6IJzv1gskcVkIAy1jt80rL?=
 =?us-ascii?Q?QorBuVEfCikUNTMzlEhyLX+zJaBVaviIFVGAbo78eobIw8+P5YlHkRPBnHlo?=
 =?us-ascii?Q?xh2vGDGiMmWpR/KQfkqOkuvzVZkJNOtKIB2pLPUbgoQfCZ+Mqw0wgaR5YnUg?=
 =?us-ascii?Q?Ln0rTPNf08b1D2wAzY8zeBb2WqQ2BolW+dIVQ3nZa26tOpCmWBydH6JhG91b?=
 =?us-ascii?Q?TOCK8M0v/CqAjdyy/Io3jISHFtVNtAI/ZPZgSuobxYAPHPdYXKUqBiPySF+g?=
 =?us-ascii?Q?4EgzOp20wXrkE8wYHbZC2Y58wJUgMVDi6A5aqMGMa2msuBEl5tDIWljTsgxJ?=
 =?us-ascii?Q?+xd7AQ1ZmWAQNbu/NQsYehFs7Q5hYahNogWxnE8YwEDeHjJcPR4Hi1PdbNqR?=
 =?us-ascii?Q?tJOG674X5+iFmvr0TCnwerMoivTsHVb2KO5fQ8aOW/01oTS+145or7jRu3Vx?=
 =?us-ascii?Q?Rky0Oy3MduMh1TiGhUt7Gvzx685OuoTmvfE2ieufFUrsMzjcRqsT3eseOCWo?=
 =?us-ascii?Q?Ej8YH+VBMGzUKtzaAZkmmCE4obqJeEFXRczFSQipUrbZ+B6Iw/JBd9lIMWVq?=
 =?us-ascii?Q?MTwp5Ufxyin+BS+r+h6Lb5hsHIMmgMIoVKA7T3ido1fNRI6n3Gw8y19pVApD?=
 =?us-ascii?Q?4OBwxLLpO+ydnDZUknBCE6QjFr1y75VbEQ5Q/hFCvkt+hMu+bUaNTfDPnrcD?=
 =?us-ascii?Q?tsmwc+cZ1Gm5BxZ5pJCk9cDFBMWzAYiT3L/QLZmMSymDU7HCt3d+Inw1oUqg?=
 =?us-ascii?Q?2GlpIEdzchM16yDdbO00JO6Bu9Vq1Cn/3PB+Qiq/6J/qd9ViyRTkVb63CrTL?=
 =?us-ascii?Q?9Kp9xdn2cSynOUpbsf6AU2/UXyy+HHxIvWvoUbZnayF0zz6wrrBPruvHFKGG?=
 =?us-ascii?Q?Y9zPoBy4Trv0rUl95CxSRd7H0hhS4MzzlwivtEuM1LrY+ykemwPnyGVuYglR?=
 =?us-ascii?Q?Te8pSBBuN3Dbdh98qPiUiF5qGR4CRIwaWkxa66C2Tngmme4RxDv5Y2NP22e2?=
 =?us-ascii?Q?vyrchNYw25WpNm58YBtHBbI02tZZndfVzReArpuvEwuYlK6y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc69fe79-7893-4d7c-1895-08de638ebf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 01:43:07.9691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/BlUIjW8tKb/d6IOOLmwmeMZVpeyNe1KgaXMLDdMtQKv+Oavx8TGVBVwwcqr4rOALVQjMSOPz73oWMjE+p7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

Series is:
Reviewed-by: Jesse.Zhang <Jesse.zhang@amd.com>

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Wednesday, February 4, 2026 1:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/sdma5: enable queue resets unconditionall=
y
>
> There is no firmware version dependency.
>
> Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask=
")
> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index edb1e4d3f9292..afc22843f7940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1427,18 +1427,9 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_bloc=
k
> *ip_block)
>
>       adev->sdma.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].rin=
g);
> -     switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> -     case IP_VERSION(5, 0, 0):
> -     case IP_VERSION(5, 0, 2):
> -     case IP_VERSION(5, 0, 5):
> -             if ((adev->sdma.instance[0].fw_version >=3D 35) &&
> -                 !amdgpu_sriov_vf(adev) &&
> -                 !adev->debug_disable_gpu_ring_reset)
> -                     adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> -             break;
> -     default:
> -             break;
> -     }
> +     if (!amdgpu_sriov_vf(adev) &&
> +         !adev->debug_disable_gpu_ring_reset)
> +             adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>
>       /* Allocate memory for SDMA IP Dump buffer */
>       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32=
_t),
> GFP_KERNEL);
> --
> 2.52.0

