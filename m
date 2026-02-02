Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A292EE7DF1A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 18:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2434D10E1E7;
	Mon,  2 Feb 2026 18:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGUhmEA4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC6A10E1E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 18:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5X2/hs2xd5ez3+pm/soQ4qPPxJyOM0goVwmAqny8PTqZ3Umf0rjitdyz3IB43vqtFd6WihbkGI4jea7YqmJQdQDyipqUgc/IOenT0M+/eJh9B9DnMtkALzCxcWGU58pa4EzQ2qn6Hjz3/Q1ughXtiLc/TlgHWs17FaNJ9HQN0X1bXIH/Bveo8VjgZxPvKil+YMTKNmMCe1c9xYGDFyx2IBoZZQfy1c1qLDRG3zfAsPpKAB3167z6otNOAzo/f8lHTgqKV6MWtLCXRAqkDwO/rqbRdfQWfA4jGPOj2iDxnGRSAEb9oZjFfwWdbxGtFSwgIxzo1lbJLqa+gj3IVSkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pLfPCBVlSwo+ZY0W4zNuUmhES56Iv9DTnnSGVGIfUc=;
 b=rtYNmwuUEMtXO+c5jdqCm5o74PzcpjUGtS9GScBlDTn8zXMZPjq8WYgdpyab2bgjjMJ6gaKPfXRQZUD+R7W07z7hw5X9xomcyb3lrTMmgTFPGDReioL5guhCHalGsnlTheRoTMxPgkKZn3qwks2b49D+TYAQ+oCUs4ushaGVwHOCbbkUTQQZffs+th6B+A5YXjJKkIcbjPKDq8uQSShp9z6qFI3rKsmfyw8F16XuW3muXh3uBNSJV53dOsYMuoQbRosp6Dfn5Jb20WoQdhOerkZJhZc7RwlaedbgOc5h6t3+n8L6NL66w/A3w8gEfDh3NcY968Sbw2eELTpBem+mgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pLfPCBVlSwo+ZY0W4zNuUmhES56Iv9DTnnSGVGIfUc=;
 b=KGUhmEA4WbMsI43zevbeWaytyCRBRAxoCjoBTw3jKSPyChVk70UcgWM8KbMBoG1lAvcKuAhIpxmSvzPdDQG5kPJHWVubFyuL/Zn3PwvCNEmvZal2WkbWEIl2wfmIMF9ejscx1bBjlDCB+QYQcFIwiz9kqTT8/9ze8IbAt6JfSIY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Mon, 2 Feb
 2026 18:57:11 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 18:57:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix out-of-bounds write in
 kfd_event_page_set()
Thread-Topic: [PATCH] drm/amdkfd: Fix out-of-bounds write in
 kfd_event_page_set()
Thread-Index: AQHclHGAUN50Cu8i2EKoMCaYiQXmHrVvwmrQ
Date: Mon, 2 Feb 2026 18:57:11 +0000
Message-ID: <BN9PR12MB51469547BF209E1C5D47185EF79AA@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260202182619.586640-1-Sunday.Clement@amd.com>
In-Reply-To: <20260202182619.586640-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-02T18:56:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS5PPF5FAA0E762:EE_
x-ms-office365-filtering-correlation-id: f8d25856-1e7c-4b4e-a363-08de628cdf17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?twJtoX6AcKfNU2i0Nr3Tm5xmjcx5fsl0HG7aqlGFA6GPjfwS2qVZbDUQyyYp?=
 =?us-ascii?Q?1hS589uM8urYKBf0VxJK7PqMOMwpRN3qSsvQq/Z2EW44/KQvjlJ1AfqlOpVr?=
 =?us-ascii?Q?MXXyK4NTa+3yNF/qoSfQLUURbT/EOdXzOPqTrx8qrJXkyNMp5gvUXpSNh4Fw?=
 =?us-ascii?Q?cF8aMU946iei9svFCSSM/2rbKh4iCML6XlniQpf1KYf64ephx1UDHgdpxHZ5?=
 =?us-ascii?Q?kC3wrTEtiK5q6FPzxSttzP0DueIaPYjrJ144FeYv7ROY6WccJcRpMf1NOKQS?=
 =?us-ascii?Q?MbexssLuw1nUlKzp5cE8pKhOcJsBRUyHsN2JCRkMbXoTwzSI7B9N7iYyiFSG?=
 =?us-ascii?Q?GSC8IDPpQxxQHkb9NI2UoL7UBApFTXGw3H9kV1TaTTkGAHNepAw2kq0NPco3?=
 =?us-ascii?Q?ZQ27kiaJRZ1uQTwLcOhIS09mafSEajTPAJBs+ubbQoPog7sFSBdTHjl/u6YY?=
 =?us-ascii?Q?2U+VJlMbMxdRX4YtOUS4adcLVezqWE+551g0WUTWkoPXSc8fToG9hwTBAQdL?=
 =?us-ascii?Q?ccsUfWVEt/5j05RbwvUtzzy+wa6CUpTSHCE9S5QdyRaC3OX42LIb+aB1q+Hw?=
 =?us-ascii?Q?gTeB3ks+58oRKdrXjCvCMFmF0fEoCJ47vMRjLGTPc499Yl8076TrFkHmkSuK?=
 =?us-ascii?Q?E5b7QA/MLQyWj14s0eY5EeanJQCo3MA9qRBV3MFNaUpzjed+mHHm2+HJCKis?=
 =?us-ascii?Q?K7Uk3Q+b+i5vLIZelaF2pqadIoDpP2RQSP5tJZArBVLfoBADsQdUK1cQ8a2l?=
 =?us-ascii?Q?czJP8lNAM75euVWA5lLXFMuizPZV8U4KDtXRK6RysyRRRswOMJdJXgnhWNJB?=
 =?us-ascii?Q?UAWYFXQfmoFX4kcYAlnyUpg3Ch564a7RIgRpZF1Y6m5QHcsi2sSuDLfh96Bb?=
 =?us-ascii?Q?07t2zybYHHD23sNk/R93wgXKKTOKZh4Y/yH6q4b9RSCwa6cg4aP6RoLtBn+J?=
 =?us-ascii?Q?Dgu60/cES4TvamAdUWZfEEytrNIl065AhebKd7tKxQlO/IXVG8QKj9JWKsbK?=
 =?us-ascii?Q?Ti+BFd7+eq/asK+mp+Zb/J7tqBG39e+NL7qTG3oCYHp+XQkJGJvVxs1OldSk?=
 =?us-ascii?Q?TcocTf3h84MGDr31vmFCErKDMKBYsp4UHrwfpbB6i+wQTPnLPUuYMnNzDf5q?=
 =?us-ascii?Q?rvRxWTe5NW1oC/z6EkDpvnSc0snYJ7tg4Yu4AsCI2AD61C7FNSeE33kPeyBK?=
 =?us-ascii?Q?ujzLQbeUpO70ZLzepmXOAVHqd1+jzofI1v9RbLxjX6c5wyXOMVSUSCf8DPE/?=
 =?us-ascii?Q?f461rIJP9Md1IbTXp7JA7jC+UyNdMweg9r38jDO4zUMH+pM95ixVoybDz2YX?=
 =?us-ascii?Q?EbB3/cXVDFvp2WpY90mNuT3Dem36h98vsv57YRnOiQXark3GSGt8WgFg4/dz?=
 =?us-ascii?Q?fSX2oNz8e3PWC+kgMisVRPR0aa2brH2ACO12EfkxeHxI9vaHag4vfgA0UCpV?=
 =?us-ascii?Q?GzNvw8LkGBsdTuU+x+c/Vsg3MakxbhWwMXBtUBzivyDkIKeNRUXjh8X2a0Sv?=
 =?us-ascii?Q?BedFDLFNRa5cQmPW2eUGZGc5yfkxXy7LdIUyXag56O0X0NEcf0uRVfSDrNWs?=
 =?us-ascii?Q?KR/eplS+W/2YFGsXfhSqTIqzLBI4guORwL5MEC6K7yXOVCgHdv+AOuqrF7e4?=
 =?us-ascii?Q?crSZAmpvm925VrkbGPoRFDg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S+5h2ubvqcuH4QlMvxvW9w6vj7Ym6iSzwA70wxJ/pPh1/WIKS8LRyUL4s5Kr?=
 =?us-ascii?Q?/o31IVq9/dOIkDHpVRWktHQfu/7YJKiU7ZnStVtqqGt3eB95NvY2FGas+cop?=
 =?us-ascii?Q?IUQJrL74T91my+BqBcE6XWaJcyHZTc0RZPy3SNhPdWDaE3URC9bTXCT01aqI?=
 =?us-ascii?Q?bx0v+xp0w7el6qS6emFU07t0k4MSdOXxNblzivK4RaPOuU4GnbzBtwcVH2Q7?=
 =?us-ascii?Q?jY/r/C3Z4jz7Z36LOW1cHNv4/WYVYtAg3bOxeJzXyIKUC4tfdf1c5ryuCu9K?=
 =?us-ascii?Q?yYtzIM67lzHfAOw0wOZwXMpIiy8GAYN72YeFYfCnFQ7xVDXd7sIhngJicjnz?=
 =?us-ascii?Q?zzKB1tzOxmzYM69szeSP8ccnJcrpp8Fi0tBft0xD+KDBe2RYvKoRk2TknZtF?=
 =?us-ascii?Q?8RPre7sN26+WUTwKJCBRaAo6jxYSx7YGJpBP6DZwG2p3EAwCTa5CT1TeB4un?=
 =?us-ascii?Q?Pg++AOelz4e2TSWI0Qhs7EfU1JtkHwkDrSUDlnUfmpGw0syz87a285BiOy+R?=
 =?us-ascii?Q?gjNhpUfEoVJ13yQ5kD4dIqkIgVMLWuwwqDa4NVNvJ3ijxNdG4Z47LCSaZAdy?=
 =?us-ascii?Q?e17lm/r5gbNI4imtldRUDi31GwtHchRex1a7/OOCl3MOsATEl3GAu8TU/Fw+?=
 =?us-ascii?Q?sYriUAfQi+Tdljk+7j3OQKpKjBzmCSieFdugZNselS1545kBd4QCxkqY793d?=
 =?us-ascii?Q?BfRdZmmdyP6az103uFl1j2pZgA1RYc4/iVPnHGHMR2vmbOoeFOvz0ftj2Wxn?=
 =?us-ascii?Q?3irYLjxbeYv0j8/MT3och5RoCFHeYuGyY7yHnzFzGBwYD0qSUWDMpa6UhErC?=
 =?us-ascii?Q?cRPrrBGzsN2vnY91Qt+u8h6CcsfrEvYyPalTca98qnPVs50D1z6NQUJYJQ6J?=
 =?us-ascii?Q?p+XJe/M3WBIcFDHurb9ZlVxLpMyd+ZsSiojdiD3XXG9eY64G0iMSDJvlNEyv?=
 =?us-ascii?Q?zvlo2J8Y9c7Npb8UhR08v+W4TB2mlxfQsoPEhxbZXSfk48I+91NPuzUPZMWK?=
 =?us-ascii?Q?xG43je/QcVnorDrrWcfrbfn5PMemun8osRt6sc41ImCBv1fjFW69oVGKY9J2?=
 =?us-ascii?Q?x5AWC693R1lXqQ4BwyINGC8GzXhxrW+ImKckyc31tJ3L8jMzNMxim6XqfreV?=
 =?us-ascii?Q?IBt4P3iImbzHgagdC9PVkmm2v8e82QEdcXleqn6n+mwjxkPg0IpcD/03d5EM?=
 =?us-ascii?Q?SwqLv8LTMbDi1eVnOL1eWE8AAQZ5Rs1F/Q3VVxcUSu9Bg9BaAhXXM+uyT3fG?=
 =?us-ascii?Q?GT/JaC+kN3egzJqPKRvzB8UlVsioHSakk7tShGaJtHGK/f0qDdZqh8MvKis1?=
 =?us-ascii?Q?OLE2Buo1QvFyMBcjXy5lMQ1ZnI/GJb0Fe+nmpUhiNzJytFyNb1mOkvONbaM6?=
 =?us-ascii?Q?rPKtccoNC87dhA8RJL7+v+Z4w/uefEfBVCGCxo6iz4pt+ro6bjJtHn6O7PrR?=
 =?us-ascii?Q?AfODSwfubQg4LnhZ1Be7f+OnGHMtd0PYfALtqHFog7WX+MEq4XysVRA/nqOx?=
 =?us-ascii?Q?uy7foMv4Bqu/tlWoL1C5yHI5Ttan3DAkRg3qMYFdVNGcOPRm8Ka1lXjNzs4R?=
 =?us-ascii?Q?fd8zlkqo5mlD99W7lgJ2dU9Pmq7QfUgaswUmFVnLYmAl37P1qn8FvnSlgwup?=
 =?us-ascii?Q?NfX8zfR3Q7pOP7dhsG7Ya/oYinOw4/blpB/j2mHQu+dMNwjuvrNhOzoNGRsl?=
 =?us-ascii?Q?92EKqRagBFRN7UB6qZqLeTsKsJVEq/2/ZKn29VdrNY+FMf90?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d25856-1e7c-4b4e-a363-08de628cdf17
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 18:57:11.0933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOGXlHSqZb+NwXw45Qpmc/CoG//7jIrNS9h+5/Chk3D2xk2+CnwUPEoenEth1sxyKwz8ExgQL4KYskY5b8eO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
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
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Monday, February 2, 2026 1:26 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Clement, Sunday
> <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix out-of-bounds write in
> kfd_event_page_set()
>
> The kfd_event_page_set() function writes KFD_SIGNAL_EVENT_LIMIT * 8
> bytes via memset without checking the buffer size parameter. This allows
> unprivileged userspace to trigger an out-of bounds kernel memory write by
> passing a small buffer, leading to  potential privilege escalation.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 1ad312af8ff0..bd93a28f1026 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -331,6 +331,12 @@ static int kfd_event_page_set(struct kfd_process *p,
> void *kernel_address,
>       if (p->signal_page)
>               return -EBUSY;
>
> +     if(size < KFD_SIGNAL_EVENT_LIMIT * 8) {
> +        pr_err("Event page size %llu is too small, need at least %lu byt=
es\n",
> +               size, KFD_SIGNAL_EVENT_LIMIT * 8);
> +        return -EINVAL;
> +     }
> +
>       page =3D kzalloc(sizeof(*page), GFP_KERNEL);
>       if (!page)
>               return -ENOMEM;
> --
> 2.43.0

