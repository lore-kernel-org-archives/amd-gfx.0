Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACEFC87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 17:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6ED810E6D9;
	Tue,  5 Aug 2025 17:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rn6KgpxW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D8110E6D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 17:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww2xOa+24SyOm4JFxIjmNJaZ6gmfTdaed31jrhsZmQ6Vn+KP6HigPZSRYAJMRK9lX/6SU2aSQgfcH3J8CiJ+vThCAoni5D2eFC6HqEhvc3LnVfYlaplGyzLbWglCY16a2C0oksq6YI8njCYPWRIFtR7y0mpth/nL7flg9GQLkhH4zAwrjSFYd+d3VOZ2jYRqmnV/E4n/+ahUeQvRSmQPPjNq/NbZtH1wlW4iknt8b9Ad1JB5CwEywtxyMGRzCK5MIrnwmd8lNNG3dKj+u4ovtlcPSFo1mtjejqjGADrIqgwYcDQj2cz6bMHQTLAWWyZhmB3E+0K9vzVba8jl0RVfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ87uhAFr70m8upiie/4YoM/cdECHdbVzQIo9tnIKSo=;
 b=H45wseIFeE91nniqkxx/uclQanqNw2+9tFTRwBwT9O3JlUBv6CPYk+ZlBHV89gJpr6OzqXbS1WdLzSqXpivbwqmOJuFGCc3mvY+A2Wm88Lrby6850iZjqzULyj89OfSvux6ehVmhhj1mdxgz9NrGZi/GQcbT5tI4RmAgreST54k/jU7kfcGxIRCx2lqmDVc9L5vrDDU9dRZt+KC7V1m0Pkb+/uE/BKBUYFSeomNAlvN227eGTs4hp5k48oNmSZVl4J23kDBemYmOq4++hJYptKd+jbWyDYDMUoMALj+FbWSOxLD1OBd2+rg+kbGk/FsHzE26oNGzCVNSZ6Enj/3Mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ87uhAFr70m8upiie/4YoM/cdECHdbVzQIo9tnIKSo=;
 b=Rn6KgpxWoDMVQgmL3DjqPWtVAlo5xQqCv7yRWigdruXA4ktPn//1jZdACMRTbNFjoRQ+gHH6MidqDGHhLzdqGbhEBOxkLlIFjx4MfqNZaAO5rLsqRGr6ArIHDUJs0j0iRoWN/0bULS/sO3W54Tu7QQ4ylLwB0OBfsFgYk5aWt7I=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Tue, 5 Aug 2025 17:13:30 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 17:13:30 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Increase cache interval time
Thread-Topic: [PATCH v2] drm/amd/pm: Increase cache interval time
Thread-Index: AQHcBiDHLs6ZS6XgDESJIX5qUvOko7RUPn0AgAANgAA=
Date: Tue, 5 Aug 2025 17:13:30 +0000
Message-ID: <DS7PR12MB6071544EAAE22A7B810F27168E22A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250805155058.669805-1-asad.kamal@amd.com>
 <PH7PR12MB78203D095018F51230B8037B9722A@PH7PR12MB7820.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB78203D095018F51230B8037B9722A@PH7PR12MB7820.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-05T16:21:57.9838117Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY1PR12MB9626:EE_
x-ms-office365-filtering-correlation-id: 5c2a812c-999b-4c61-4245-08ddd443667e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Q4elhRmDT2hOVxeW5vVfFzlvaX5MmFZSPykiEa8ZPZMysNfzP4b9VikANwX+?=
 =?us-ascii?Q?oQ47gnqce4VCuSt1O6yMr9S/iUhm3zjoPHFso2XvtOD9MEYmZ0KfoNDEESLZ?=
 =?us-ascii?Q?AualQCZiLOWXY0AqoulBF6WIOLIuHzuebwJRnIO+IBgvO6fxKXkw69Vrs3RN?=
 =?us-ascii?Q?MKbt35X6Mb0SJVu6BHz0dElbv126i2gBMtXjtW3PH2vKKTXLpX6i75DeWVbc?=
 =?us-ascii?Q?cQtD6V+mtx6TMW/97CxvjB/hbABuC8uj1EaQOr6uumCEYkTpZhelr6hsOaPs?=
 =?us-ascii?Q?7hNaD07kU+0xaj/8YB1204xqqnMHy9ZMdkGd2jOcEK/yO7076nOFiHTcqctT?=
 =?us-ascii?Q?uD7uvYPpnaAjr4IY2mJ/tAv+rDLtQ3vvvPD+I5GAzWn5Bs20UjY/PUqzSz3b?=
 =?us-ascii?Q?1Jo89O8+I0GFKuNgUB0VUJWRrcBfk+FZiKLLGzpgVQMvmEnMr1muBpAemysW?=
 =?us-ascii?Q?yIeDJWfDKofjGXuHvxCk2+jitBGbvNR144l6ZmJXo2TavoooseUF3WtvgPgV?=
 =?us-ascii?Q?THahoL63TRlO/6ctUWceyuO4kq9oTvdUKsvmZlow1L6ktdE/xwZ+9arxnz+j?=
 =?us-ascii?Q?F8HKsh3QM8H8i2Re2YNXag2fW/sgIhB5uiT2bJ2jv9JpfGwwWcZ8g9WXhwvQ?=
 =?us-ascii?Q?dBHRpAmp5IpKQMyu4IXnkjgXbcnGbSA2u7q2Vuqysrgj1Obj3OtikOMgJVwb?=
 =?us-ascii?Q?BEGQotxglIo4KO8Fekg7jjf6WggyiyrY6xOt0ZYTS6UrgEi++yV1jW7B8t3B?=
 =?us-ascii?Q?thHJROq1+NMc437mhQXTts/gmvXPevpiSMXIw6cX+ojk0pq4YCPjigxhbhI3?=
 =?us-ascii?Q?9WMoUdkB2sO8K8F+I0Z3e18ITiQn72w5Yz5R7W+VfJl6I02+4Im1HmdElcPs?=
 =?us-ascii?Q?jWWWQkNxnsQUEXa0uGNQT4+v3vsL5tiQ2WMjDf/Z1n2M1MdsffW4w8mhxDLH?=
 =?us-ascii?Q?W3u/JYCohRCXvXFyIyF9DxRrhoxyuK1ynpM440kfpwEfEQhyND2Rx/Uq+Z0K?=
 =?us-ascii?Q?jOD/hMqMXP5UWqRrurXOeAKDY9PNezi3lPomPWdFos0fbEjBVS5oO6D8b1yP?=
 =?us-ascii?Q?UlUkk/1amsgigmHPoZYHIo1kZLJ94DO5r6p9rmn0Q5vZZqoUWJvzQB0prmoC?=
 =?us-ascii?Q?c3G8poQTxcMfB7EHjSk17PWQbCB4hOGu5zno/iqkZIttmckJMdyporr4QY1p?=
 =?us-ascii?Q?su0vc85Gt1n7kkgxwvqdGIViS7HjGun7+JvTTHaENNUczglopuNPm1UuZ4ge?=
 =?us-ascii?Q?7heE62Sfug+vRiO1mUaGcOmMPRxcax9lKMQ71ugr0M6VVwY8FT6dA6Nds/wT?=
 =?us-ascii?Q?5iNX9DiB3+uDcpFCNPZlcZdpKgBRyl3yw6rv01byx4/sPva/py6rj1XQPrN+?=
 =?us-ascii?Q?oW/CChwkx3eFzSgqrM9bNAHXZU/EE9Ht7ZtPFm1OVSVACCMbZcVrJa2UL57f?=
 =?us-ascii?Q?qEw0QcWbPUAy8Ff9b7NPc4MZw17ZobgEsGM8e9lWLSL0lCswA56BVg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IDWjG9A018UydL3VDtr/ThJjVskt3h+oaRe9NU5dUEajLy4F47kvTMoDVBdv?=
 =?us-ascii?Q?wQeOFieWW5r7fTFmqytWeU3qNvRO1wpM/WJMO63OzUdC7FhCsnVshLIIELop?=
 =?us-ascii?Q?4xZGlzvBdmfv4dI+oPIFKe6w27TunFPjl5CtRBynYo+hbDKro8pa4U066OFm?=
 =?us-ascii?Q?eN4gF9kiVPrLs1OXkKCMo5A+t9WghwmJPplUiYDdhHf0fMWTPgIkNUQ0fLGW?=
 =?us-ascii?Q?0cRlxRCr5mhoigp4pvnNGKAnUKHNraWJjaBanN4TFUpxuNwVhH5AJtFXMTak?=
 =?us-ascii?Q?efgDy642RQ9pmeqFh02DYYnW2tblrWYmAUM7wXpOGa0n1EHj7ixQvIdBWAmS?=
 =?us-ascii?Q?0kCBjqhRx/YROz5SJrBFhUgIWd0ZXPSeUyhTgKash16nJsd3zau4K6y8WkwI?=
 =?us-ascii?Q?AWMuyiwxD0PkNf5RhvB1jBErUciFZYM2hy77/neLfcR7xQLe+O8D7Nlivp1B?=
 =?us-ascii?Q?gBGFOX5KKjzbZrr3aaETFbS68AJkrDDjhWetd+RnWg2NKODoEfRGEF4DFXg7?=
 =?us-ascii?Q?/4SUb5C73tCHzHeXbE1ec4cQg6EEjsykf61mLPap1Dq6bMq7KyqUjiIz3KMB?=
 =?us-ascii?Q?4VWvajTL42u/shLQfx7Vb+LLh7OED2OWawPwvgVbz3y/RU5zCq+MUVvQEf2m?=
 =?us-ascii?Q?2/XnTyfE4yo09RUQnYPzmQ9fXw8GxiKpzhZzuLfuO8egh0cUBKrq8/VIJM+h?=
 =?us-ascii?Q?KAPJT30AaPcPgi2iB6HaCt+pfFDhNhfwMvqie1G4aSnbtBLpCZRZTKk92hcq?=
 =?us-ascii?Q?p+s8Tp5hW+fCnBjBvivNRGQbUWBtG+oWXC0VnWqgTst/QPtufgoEkxNRYSys?=
 =?us-ascii?Q?//A1SiX6d2gc2h1KLaKZrbQzNpBQrtOS0MuB61lY5CHlZ2Fu4u89sEoreqgH?=
 =?us-ascii?Q?ESrTDRwYtGxEyN40tRLjCqKasu13NKCP2xv5BjCSO4Qh44E30hIyj7OgYsD1?=
 =?us-ascii?Q?Csx1D734EpipgyDKWNulvEbavtkm7INQ0uD/Fc1/MXsAwBe+fJWnPBhZhgnB?=
 =?us-ascii?Q?+WobObbKg5+D7Y96y5ATJtmO3nfahwV2NSX0s5c7Eu0SYUnLUOffQLjlrOQq?=
 =?us-ascii?Q?E8oLkpu5Y3F1ksUBKk1FteVe+F3psLaVLKDLA6fU6M6poHDVBBhuE0DA4eiD?=
 =?us-ascii?Q?C4X9HzDcLTFpUmAmOSdqnMJo+UPaCeppLk4D90rcpsQfgWTbfPajsXUFMqOk?=
 =?us-ascii?Q?ShFTphx92LneEfmiE6SztXB9+EBs2zRuUWyK2aW5XCxF+JeALyzWcAp536Ud?=
 =?us-ascii?Q?JZz9v/0CMIr7CHDrLcRHkS0fNhhrnK9DD56zFu6LsRERLKGWFRN5c7re1gb0?=
 =?us-ascii?Q?/Mdsjtfp4vwUmCfJKAPW0w9OU0d+rbQdC4IQR/dxLfenRNYz2Qrohj28Vyvy?=
 =?us-ascii?Q?/budvpXe5iT0GAhPYD0uGhMC7l+3NDVERAc+0PXI+NxZVWWhAEzpubjsVztF?=
 =?us-ascii?Q?K9V/YGrnS4GPTLe9i1TGHoZ1hxMsiGuI0GaDfg49qo69D6p1OehHS9lK+7TV?=
 =?us-ascii?Q?RRR6tXcrRD2qJ/ssVZkNkmZGNJiAp9lqC6nWxfqRmEZD+kMfm9e2DvXPNRiw?=
 =?us-ascii?Q?DleqE91uaIDsyZpBkk0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6071544EAAE22A7B810F27168E22ADS7PR12MB6071namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2a812c-999b-4c61-4245-08ddd443667e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 17:13:30.3553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPPXvxJXvkT5UWI8jqfkQx3lfbDS3guuEn7gLrvD0vaNPQj0G+KBy+3T+DzigWxwwma5Zwu0fLs2JaQkEAuAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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

--_000_DS7PR12MB6071544EAAE22A7B810F27168E22ADS7PR12MB6071namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Lijo,

As per discussion offline, understood the requirement. Will drop this patch=
 and send a fresh one as discussed later.

Thanks & Regards
Asad

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, August 5, 2025 9:54 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: Increase cache interval time


[Public]

Hi Asad,

Sorry, after initing the cache interval time, I meant to move the cache tim=
e check logic to swsmu level and not at smu v13.0.12. I believe this was th=
e original ask from Alex.

Other SOCs can customize if required by adjusting the cache interval.

Thanks,
Lijo
________________________________
From: Kamal, Asad <Asad.Kamal@amd.com<mailto:Asad.Kamal@amd.com>>
Sent: Tuesday, August 5, 2025 9:20:58 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Lazar, =
Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; M=
a, Le <Le.Ma@amd.com<mailto:Le.Ma@amd.com>>; Zhang, Morris <Shiwu.Zhang@amd=
.com<mailto:Shiwu.Zhang@amd.com>>; Deucher, Alexander <Alexander.Deucher@am=
d.com<mailto:Alexander.Deucher@amd.com>>; Kamal, Asad <Asad.Kamal@amd.com<m=
ailto:Asad.Kamal@amd.com>>
Subject: [PATCH v2] drm/amd/pm: Increase cache interval time

Increase cache interval time to 50 ms while fetching system
metrics table for smu_v13_0_12 since polling interval is less frequent for
this data.

v2: Make caching interval soc independent, however customization can be
done in soc specific callbacks(Alex/Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com<mailto:asad.kamal@amd.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..c62d68d7410f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_con=
text *smu)

 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
+       struct smu_table_context *smu_table =3D &smu->smu_table;
         int ret;

+       smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval =3D
+               AMDGPU_TEMP_METRICS_CACHE_INTERVAL;
+
         /**
          * Create smu_table structure, and init smc tables such as
          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..7a52c00c700e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -32,6 +32,8 @@
 #include "smu_types.h"
 #include "linux/firmware.h"

+#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL     50
+
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP          0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP          255
 #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES   1000
@@ -258,6 +260,7 @@ struct smu_table {
         struct amdgpu_bo *bo;
         uint32_t version;
         unsigned long  metrics_time;
+       uint32_t cache_interval;
 };

 enum smu_perf_level_designation {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index fca50f6a8ef6..5ead66375d38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_cont=
ext *smu,
         return 0;
 }

-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table,
-                                                bool bypass_cache)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
         uint32_t table_size =3D smu_table->tables[SMU_TABLE_SMU_METRICS].s=
ize;
         struct smu_table *table =3D &smu_table->driver_table;
         int ret;

-       if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metr=
ics_time ||
+       if (!smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
             time_after(jiffies,
                        smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_t=
ime +
-                      msecs_to_jiffies(1))) {
+                      msecs_to_jiffies(smu_table->tables[SMU_TABLE_TEMP_ME=
TRICS].cache_interval))) {
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetrics=
Table, NULL);
                 if (ret) {
                         dev_info(smu->adev->dev,
@@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu=
_context *smu,
         else if (type  =3D=3D SMU_TEMP_METRIC_BASEBOARD)
                 smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics=
, 1, 0);

-       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
+       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics);
         if (ret) {
                 kfree(metrics);
                 return ret;
--
2.46.0

--_000_DS7PR12MB6071544EAAE22A7B810F27168E22ADS7PR12MB6071namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Hi Lijo,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">As per discussion offline, understood the requirement=
. Will drop this patch and send a fresh one as discussed later.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Thanks &amp; Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Asad<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Laz=
ar, Lijo &lt;Lijo.Lazar@amd.com&gt;
<br>
<b>Sent:</b> Tuesday, August 5, 2025 9:54 PM<br>
<b>To:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le.Ma@a=
md.com&gt;; Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v2] drm/amd/pm: Increase cache interval time<o:p=
></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p style=3D"mso-margin-top-alt:5.0pt;margin-right:5.0pt;margin-bottom:5.0pt=
;margin-left:41.0pt">
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Hi Asad,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Sorry, after initing the =
cache interval time, I meant to move the cache time check logic to swsmu le=
vel and not at smu v13.0.12. I believe this was the original ask from Alex.=
<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Other SOCs can customize =
if required by adjusting the cache interval.<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"margin-left:.5in;text-al=
ign:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">From:</sp=
an></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:black"> Kamal, Asad &lt;<a href=3D"mailto:Asad.Kamal@amd.com">=
Asad.Kamal@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, August 5, 2025 9:20:58 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.M=
a@amd.com</a>&gt;; Zhang, Morris &lt;<a href=3D"mailto:Shiwu.Zhang@amd.com"=
>Shiwu.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alex=
ander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Kamal, Asad &lt;<a href=3D"mailto:Asad.Kamal@amd.com">Asad.Kamal@amd.com</=
a>&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: Increase cache interval time</span> =
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0in;margin-right:0in;mar=
gin-bottom:12.0pt;margin-left:.5in">
<span style=3D"font-size:11.0pt">Increase cache interval time to 50 ms whil=
e fetching system<br>
metrics table for smu_v13_0_12 since polling interval is less frequent for<=
br>
this data.<br>
<br>
v2: Make caching interval soc independent, however customization can be<br>
done in soc specific callbacks(Alex/Lijo)<br>
<br>
Signed-off-by: Asad Kamal &lt;<a href=3D"mailto:asad.kamal@amd.com">asad.ka=
mal@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----<b=
r>
&nbsp;3 files changed, 11 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index dc48a1dd8be4..c62d68d7410f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_con=
text *smu)<br>
&nbsp;<br>
&nbsp;static int smu_smc_table_sw_init(struct smu_context *smu)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;tables[SMU_TABLE_TEMP_M=
ETRICS].cache_interval =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_TEMP_METRICS_CACHE_INTERVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create smu_table s=
tructure, and init smc tables such as<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TABLE_PPTABLE, TAB=
LE_WATERMARKS, TABLE_SMU_METRICS, and etc.<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index 611b381b9147..7a52c00c700e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -32,6 +32,8 @@<br>
&nbsp;#include &quot;smu_types.h&quot;<br>
&nbsp;#include &quot;linux/firmware.h&quot;<br>
&nbsp;<br>
+#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL&nbsp;&nbsp;&nbsp;&nbsp; 50<br>
+<br>
&nbsp;#define SMU_THERMAL_MINIMUM_ALERT_TEMP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define SMU_THERMAL_MAXIMUM_ALERT_TEMP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 255<br>
&nbsp;#define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES&nbsp;&nbsp; 1000<br>
@@ -258,6 +260,7 @@ struct smu_table {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp; metric=
s_time;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cache_interval;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum smu_perf_level_designation {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
index fca50f6a8ef6..5ead66375d38 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c<br>
@@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bypass_cach=
e)<br>
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, =
void *metrics_table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_size =3D sm=
u_table-&gt;tables[SMU_TABLE_SMU_METRICS].size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =
=3D &amp;smu_table-&gt;driver_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass_cache || !smu_table-&gt;ta=
bles[SMU_TABLE_TEMP_METRICS].metrics_time ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;tables[SMU_TABLE_T=
EMP_METRICS].metrics_time ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti=
me_after(jiffies,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&=
gt;tables[SMU_TABLE_TEMP_METRICS].metrics_time +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(1))) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(smu_t=
able-&gt;tables[SMU_TABLE_TEMP_METRICS].cache_interval))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMe=
tricsTable, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(smu-&gt;adev-&gt;dev,<br>
@@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (type&nbsp; =3D=3D=
 SMU_TEMP_METRIC_BASEBOARD)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_init_baseboard_temp_metrics(baseboard_temp_me=
trics, 1, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_12_get_system_metri=
cs_table(smu, metrics, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_12_get_system_metri=
cs_table(smu, metrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(metrics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.46.0<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6071544EAAE22A7B810F27168E22ADS7PR12MB6071namp_--
