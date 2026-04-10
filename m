Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18550F44842
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 11:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC31210E05F;
	Fri, 10 Apr 2026 11:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wIlUYzrY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DBB10E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 11:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLoEbIFWlwtFrO50oY59dFlY9EJF4GKUoVQTsTIEJRzHff1+QhoDO4X3647SIYAocjz+cvTeswv17sKSfieNiEfW3KgvwztkDLFS1dg9yPGhIrIsH7mpB2K0+j6cVkha3ywO1CHfTa5/vRA+JjegtaUGENpw9iTU33+ui2E7R5O0kLPh/rbiMtDTHYfilx9VHB5yagKvoQjeZLkteU8SuxKUX+YwvheAjdniT9MOZgjr0zqMCbQlnCSgForwN/MHqPLQak2aEhfD7ijuF9jP64by82l/rveMKAV61sV6iaX8GM9F3otSMFIZmPzGO8FgREieyJ1krwt0XtB8/kp5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEfjxsRR3mYkTd32cLU9YUDDbhUdO5HdJdR/k+kdx8g=;
 b=sECA5XQZKcHMGKttpOCV8cp8+scAaFnOcxD75WDhS6FQY1ZFeBAxC1TsIoeGMkM0OcDr0RuNWUp593oeyXiGALRMjbzUgiGV+TxbO7QXrSbetr20LM7D8VyQpaSnyaDQe3Pif/udXqI02dbwNeQZs22ngVwVz+QujwdSiOLFg5MdXUdHoQJIsosl7+eCU5I1YmHynTCVwBV1TsabDaD/oYc0bwy+4tPEIbsk56eHXBFSzZxhX+WvKDk6IuhAed+80kpQwUz1arKX5nRhygvcfSb0uiMLwDOeysLEjXNhTT9N8d5EVHWzydurmwrjtmd0Canccl0dalQnrRfznXM4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEfjxsRR3mYkTd32cLU9YUDDbhUdO5HdJdR/k+kdx8g=;
 b=wIlUYzrY+cYqS+8uBCsVFJvdhSYtKilapJWApepZXz9vUaIFI8ZZEF8M6jgzpuqPFJAduuAjR5kMCUoxdS/YTSzEdjIXjLnJpt8mR1gT6tKpJoUPRZEGV3DzbWFtBuuPJRPW3I4SNrRxK6+iAW11fPjt3zAtafuVoJdD01O70H0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 11:55:33 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 11:55:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix CPER ring header parsing
Thread-Topic: [PATCH] drm/amdgpu: fix CPER ring header parsing
Thread-Index: AQHcyAK/mjNA2M87QEqHMuIy2cH3sbXYMMrQ
Date: Fri, 10 Apr 2026 11:55:32 +0000
Message-ID: <PH7PR12MB8796C34213C5C06CA8B055BBB0592@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260409092403.572319-1-xiang.liu@amd.com>
In-Reply-To: <20260409092403.572319-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-10T11:51:45.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB6628:EE_
x-ms-office365-filtering-correlation-id: f4df4f91-c268-4356-0a78-08de96f8119c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8tnavGtDWSDKODwY69hIJ8z1HzxXSKMZwBOlWIihr3XK0tZdCfY4A9Ib44kiJi9sL7nnDtirZwL0U7YbOOlElyi2tOV922EvCgS6VbB3ii8x1qH6ZAXvSnZ24KZTwX879bdWCZpRcVojtGcmYT72DsXylQc3yzkyjDlSnsREsE3P6KrzAZdPRHxjO3OxcZQx1Zrq98+qoatxMKiuo82NVSovi1FAFM2K5urJopE927bF2m93r7WXjkyUpXHV988KO+GISa1CoZAcfhrNfQoFATo6Y3myyVpWb7JhZhM1p6ehxOdZEUl94G6rKyuKMRZPwlrefKq8006JC4lbUnkvq4QOIyQRFDN+vGXcSAZe00uu45Q/J7yQn9tCSND/gnWBTrmpgR6M2esUZMmKrO+RWmMT2Y6YuIr1oOR8RnrwOBsZwluMQgQ635VoEEgeCDQc4uI2j6S+wXhnxWAZAgsCMGtzjBF0SOG9b1QFh8NUUcVAJ7vfigZtYyuAUgK4YFMBKm41TZjlmMnd1gA44BQfYAsEuFjusf4NUh/FgSaODUuA4lwzj3IAgR0rxM3JpwnBO2iLQDFaaV6ixspZIb3/03JERQimApW2g0wkLBS7tB4F9ohbV+CT2SlUBCs/VdKc0ximUKH7onwJgYgtJBGmXx7LedtOzlhMrcln1K7BjMXHqL7aTbCjwbtsO90Jx+5Ms/rOY2jTdEeQHIOG6R6TWnbxOUc5lWJzfgoe+ARQSqhIU5f4IYMCFyZonl5gzIpHNd3NlKigLy1In9Pf+COx8HQR4/KRCoF+jUEE+so+v2o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/xQz5mpaItEcqlLphQv/cGxWNBpAdpUV8hfYOhAvAQoqj/Vi2pS63tWx197?=
 =?us-ascii?Q?rVnGub8ZMrDZg1ZDq/X7kRoqMINaHAH72B6qX1sY3YlcQWqop6p90gUtSyOF?=
 =?us-ascii?Q?oIXrneq9X7LtwX7a8s0rQ8Y16id46H/VjbqyPcQSZcO5OvUulWl58iaw/Arr?=
 =?us-ascii?Q?O4/28PcDHu9NEZbeB2uT2s6yLUkjTRP+yCuoBYaS7WjObwsp8pq0Kw84AzqU?=
 =?us-ascii?Q?/rdTnwA0h5/dmv3SMiZL08lHITogl18EYP4WSB5TfU1zsAKd7W48MMWvpXDp?=
 =?us-ascii?Q?7FQ8+vjI2s+4dkrM04DIr4gp5I7qYEPQ/HctXL9LAwDhqNteIERCLpsI/hcX?=
 =?us-ascii?Q?kCt0TTCfjDdwLNlDRXoWvx/Xjj2xAGl1V55LQ/ipWY4Zm9Bvze1iLaccEHfC?=
 =?us-ascii?Q?bbn3G7+wfPBfq3eLNSgw44lqNiodIwIBnZVl+e7FlTErb1RUaSPj8IQqaICT?=
 =?us-ascii?Q?WM9XepD2pbHpXsqgeiJDQzDt96ouxMbHLvALyR1+97MmlI9ht5IdtlQt3Ptl?=
 =?us-ascii?Q?BESS0vwwYGGg7OUL7gvfBqpV3YpOfdmqXkt4qoVvz//ZIixFcHh6Js2RmvMS?=
 =?us-ascii?Q?w7sdEA5Cb8g+YLKFKyHisuxlwdXGXRuPFBmEAYUFviBZmTBds07ivex2y2M2?=
 =?us-ascii?Q?X748M9IT/TCnTuiU+V5+fyDsodxd7WIuDyZ8LAJLKxtfVrFL5lvj9RtLpkXe?=
 =?us-ascii?Q?3ysrK7vS59Mz/g/0QuulDkIbZO3hP9olWhWTbKFucDpDr8crIDyZPihGbhi4?=
 =?us-ascii?Q?zZ9C/rPMu5Q6nrdTvP7V/XezuN1yi+tBGGMKRYoxJKiYWKy+MVjsQujR+wrA?=
 =?us-ascii?Q?N8cEQk9E0acoNqLNSwHzeMuMbmKkNviupBEoF6L109P4jraMJ7xp9MSVsajk?=
 =?us-ascii?Q?NA8YtWPPPDaQJHldJK/fZUU0xqfVZ7SEVtkRgrgRjX8XzOoLx7pixdxsVqaY?=
 =?us-ascii?Q?8ljf2qTC63mNHnq6dZSp8T1h2ZAiQl1f9xUJwGyRqhmYTRgcarneMQulDLYP?=
 =?us-ascii?Q?reYocP4Y89hHNj0J2m0LmYDP+B1kpxpBk84E1vq/AnlsUaWr7uK3qJwVZ/an?=
 =?us-ascii?Q?l7BMJRQuaDc1jOvFpJMGVsyos4hEJlhShSV/ydWYbcQAFrUd9rpiFeOofDwc?=
 =?us-ascii?Q?634MXsfgd6MSQ4GprfYcfvLOe8Epn1x9T3o1sb3+QYYKem08jMYzul7NgPBs?=
 =?us-ascii?Q?F5tCMM6oRSC3DluDCxyYz9HVzB2RV+x1bCGr+Z3zLdj/OEBde6pyUyc7+XXp?=
 =?us-ascii?Q?qQ5gcpjNxGWbA+1giM67E6zyKBKOSbGztJxMYPLXp83VnH96ycNf/HvPt50k?=
 =?us-ascii?Q?hyYm8inxEh9144EcP9hUCcKI5dV/RkC+qXDjwznZwjP4I9662HGuQdouALcN?=
 =?us-ascii?Q?BKpbb0VEPpZ97+B5bZCHvf0Q2EZkeDh4G7EiaFGZHyTQKMqqpWaCuGeBBLAq?=
 =?us-ascii?Q?qRS+lLOXTOmlrYRKSrzzP+zD+gFWHLuPo87CuNpymmMjtc6sNf4VCej/oM/T?=
 =?us-ascii?Q?gPj8sgaqlTf8ZVohUQoCKGBIW6SWgisgnQBs/TWowjuC3e9LSU9OK7MGPqY7?=
 =?us-ascii?Q?8AzkBul/ChiIoMJz8VX7jOmbE9Rk+WdqVJqMdenU8xKii8V4K28xjNphPeKM?=
 =?us-ascii?Q?oI58op5z+b9stsiilpTJIQ/wVcUkLNOzOoR7JB67Ov84/pczhiorxEWeqUZt?=
 =?us-ascii?Q?eWCxEci/Obh24CldopsBvdd4NjY2rmx09m+GHgsjKno0ZEOm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4df4f91-c268-4356-0a78-08de96f8119c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 11:55:32.4144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nex20pn2Jez/bjGzEFMYUDc1t2xFspzMGouqv1zCxhA5ZMrZfY2YBQLAUn/x5EAy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Thursday, April 9, 2026 5:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: fix CPER ring header parsing
>
> amdgpu_cper_ring_get_ent_sz() parses CPER headers directly from the
> circular ring buffer to determine the current entry size. When the ring i=
s full
> and the write pointer lands near the end of the buffer, the header can wr=
ap
> across the ring boundary.
>
> The existing code treats the 4-byte CPER signature as a C string and uses
> strcmp() on in-ring binary data, then reads record_length through a direc=
t
> struct pointer cast. Both assumptions are unsafe for wrapped entries and =
can
> read past the end of the ring mapping.
>
> Fix the parser by comparing the signature as raw bytes and by copying the
> header into a local buffer before reading record_length, handling wraparo=
und
> explicitly in both cases. This avoids out-of-bounds reads in
> amdgpu_cper_ring_get_ent_sz() when the CPER ring is full or the current
> entry starts at the tail of the ring.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 34 +++++++++++++++++-----
> --
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index 35fed4a05e1c..54ee4f7e7a0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -426,23 +426,40 @@ int amdgpu_cper_generate_ce_records(struct
> amdgpu_device *adev,
>
>  static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos)  {
> -     struct cper_hdr *chdr;
> +     char signature[sizeof(((struct cper_hdr *)0)->signature)];

[Tao] I prefer to define CPER_SIGNATURE_SZ macro for sizeof(signature), wit=
h this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> -     chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
> -     return strcmp(chdr->signature, "CPER") ? false : true;
> +     if ((pos << 2) >=3D ring->ring_size)
> +             return false;
> +
> +     if ((pos << 2) + sizeof(signature) <=3D ring->ring_size) {
> +             memcpy(signature, &ring->ring[pos], sizeof(signature));
> +     } else {
> +             u32 chunk =3D ring->ring_size - (pos << 2);
> +
> +             memcpy(signature, &ring->ring[pos], chunk);
> +             memcpy(signature + chunk, ring->ring, sizeof(signature) -
> chunk);
> +     }
> +
> +     return !memcmp(signature, "CPER", sizeof(signature));
>  }
>
>  static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos=
)
> {
> -     struct cper_hdr *chdr;
> +     struct cper_hdr chdr;
>       u64 p;
>       u32 chunk, rec_len =3D 0;
>
> -     chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
>       chunk =3D ring->ring_size - (pos << 2);
>
> -     if (!strcmp(chdr->signature, "CPER")) {
> -             rec_len =3D chdr->record_length;
> +     if (amdgpu_cper_is_hdr(ring, pos)) {
> +             if (chunk >=3D sizeof(chdr)) {
> +                     memcpy(&chdr, &ring->ring[pos], sizeof(chdr));
> +             } else {
> +                     memcpy(&chdr, &ring->ring[pos], chunk);
> +                     memcpy((u8 *)&chdr + chunk, ring->ring, sizeof(chdr=
)
> - chunk);
> +             }
> +
> +             rec_len =3D chdr.record_length;
>               goto calc;
>       }
>
> @@ -451,8 +468,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct
> amdgpu_ring *ring, u64 pos)
>               goto calc;
>
>       for (p =3D pos + 1; p <=3D ring->buf_mask; p++) {
> -             chdr =3D (struct cper_hdr *)&(ring->ring[p]);
> -             if (!strcmp(chdr->signature, "CPER")) {
> +             if (amdgpu_cper_is_hdr(ring, p)) {
>                       rec_len =3D (p - pos) << 2;
>                       goto calc;
>               }
> --
> 2.34.1

