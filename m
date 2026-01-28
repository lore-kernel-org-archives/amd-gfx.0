Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0D5D2FEFA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 00:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B177C10E5D6;
	Wed, 28 Jan 2026 00:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1a4vQd/J";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC05410E5D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 00:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsZyHtcHFqBljpYfLQ0eaBygEdQtuXFK+Biq0dxChkIauLcfN0q7QA0IDK7jl3c0SfKrhfkWNBg/h1sug2ow4+KlYZjn9dz7H4nYjQ3axQ2HJdaYIcoF6tuhxCpyYT2fC7YQTsWwZ7q3ybl7My9gsoyENq3tE1UhtDvHFQgYS2q88EoIWu92wuv5X+2AY5PpohpSjDcwWoqkkZGqoRWuDKEsWHm5S5Qs/DYme6HPRBl4cCVX5og0mDVdjZVERydMYP5Bi1wAVO3m0jnsrZPl2rh9c8RcKI1xYprMoOG7vlQL3R8gYsVB9LLeMEU+wI+F1Ih+8LD0EsBXjSIMG6vWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5Czd+UzXyCYvP7QaJZl5fTQEouNE6UmTH6V51INs0c=;
 b=n8I/BaWnifjYqEteyKSeM3GM6hHGIb1giAkolO7I3fx0yNsvv+TBL5liL+Bs76Fnku/upNfTOdsXML53YN/syFwOEOseDZD+eCUyMsNz5QEyUEWS7WB5gPOCZQ8pVKgX22OXVCGg3md9VqOz7DfJDteAXEi4y+RfWAe04WAh4MsOKnb+l5Apvmz+S0TJig7LfrDh22KRWmW9Ga1yc1gN7oaAI8Urv2Lex0OL/sVFs3ejOk4MQiKU9EmU64v6Hq3XZJBy5JfE7OGzf8K4HN0y7gVw00gYHJt4icrRVAT4nQ69n8n1teXhWyLfFHKq4+kEBlj4tJV+EqXp0igfq1BP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Czd+UzXyCYvP7QaJZl5fTQEouNE6UmTH6V51INs0c=;
 b=1a4vQd/JQvF0rAipdx+6EtLxHW8Rm/1sdQ7/xh+jyPzAPArblx4q9R00X6yvPS/ZEsZKqOgEEaE7PAQYTqSbiS5s8jbTVJ0PUyZfk+dbOA02+hN6GJnLo86Xeo0SKcrCIjbMO/B8tj7sp7fz+8QHq1w/euvw0iZ1U+JDxPZANJc=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 00:41:19 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::cdfc:80cc:2903:19b1]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::cdfc:80cc:2903:19b1%4]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 00:41:19 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Topic: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Index: AQHcjq4lLKFCpMmowUOrqVnzYmzTsrVmNfGAgACJ6nA=
Date: Wed, 28 Jan 2026 00:41:18 +0000
Message-ID: <MW6PR12MB8898FD623C11B634F82170CAFB91A@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
 <BL3PR12MB642522950BEB4F9936929AAAEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB642522950BEB4F9936929AAAEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-28T00:40:01.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|MN2PR12MB4335:EE_
x-ms-office365-filtering-correlation-id: 5f7b9971-eedf-45a9-d2ba-08de5e05f3ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4NRxeZo9N2BAtalFs7u/sWo4Ywz7/5MC5w5W8TJ8HtdFDwAvIYrWUpr2QIJq?=
 =?us-ascii?Q?aCuvnOaz70cB9kzY8j3+w0cedxdL9gwLPYD2/K/skpqRbVPzMNkSTI/ErkfS?=
 =?us-ascii?Q?nxB83o6XnSEscXUZbxd4vUYEm7dqmN+VMHOtmaFiZX1ffcUpbczMfKZ7Q7Yw?=
 =?us-ascii?Q?ftU0LC4gHW/qIimONG8sv6Zgjb/N7hHlObq1TiHNjV9kDggO5GMpCY6Tcob8?=
 =?us-ascii?Q?xiUg7XstHSITi2sLbtBm0E2Oml5GX29GOs18kZUU57NGFKAmCVi6M/KqNBo0?=
 =?us-ascii?Q?ZqaGnQvAl/ahY9zyX7pHUfWa4JQhEqV5JL4N0lLLpoZJzNbZmYjCyT1zWi0Z?=
 =?us-ascii?Q?WjEqq9y8bIpWOhJWIlnkgLEsLc15vKgfzFm1F1Y1GEyOSY9c5TROg4TGIKbP?=
 =?us-ascii?Q?GKrJoJvKFkMLQL4fL31VQs6rcXDEXRBV8jIEZ0OKuZSCfF1uLzibResIKog7?=
 =?us-ascii?Q?xi9asY6syHazUdgLyBPPyjnjWEeu4Unnr6nUchtJSwzaWytMtnB2ug2qtFB/?=
 =?us-ascii?Q?khH7AxwGZclGyXwh8d4+e8vLACwLED7jEFRttQHaxx0pO4jCaVcEA3hnQxcA?=
 =?us-ascii?Q?Zxeyz9auMJhFjPdbmoATZAirNUpv10zRohYrgMd0cEreJF4Lu6oLVjlkL6ZL?=
 =?us-ascii?Q?cvHXQOd29s+hVo0R+easPE4+QwQsZuEcQvv0OirwwYJyKA4aZQjlQG5P0O+x?=
 =?us-ascii?Q?rjKcKu/i9jCk8wlg+hadO1lM+oZTsOy8lfYHUlueCaXXz+PmeQ4ZJaiHnEe/?=
 =?us-ascii?Q?7/+Ln0w2NP4JLXUXdctXKlGvP6oGDgXEdzWs1nH18AAGMwAFc1w2HRtFUzZB?=
 =?us-ascii?Q?lG3n8CMju7yRgTw7TTjn0XynTyeqE05Jo0WP3rQryOWQfjuI+NI5lMWYDXB3?=
 =?us-ascii?Q?GEQQlo5ik60A3/2+BvGEjVD7iUJ9diNQdLSUUNZ8iIkp6LbtwArOR52+Hqbf?=
 =?us-ascii?Q?2UbDNiLi7UOyJfm0c3GCxijcw7easp7AK2htMKxQHy1NXYvJej1y2U2ZII9a?=
 =?us-ascii?Q?jbRkn98qAGQXyLiKnRj9ByylTIhR5gUQWIck5RdlyHuV7NJEzYjEXMzBaX7m?=
 =?us-ascii?Q?WuvwVh8ift32PUOSUM9GApHj5y/aOL6RXbutbDf5Mag1RQoXsXYVdrMsiqjg?=
 =?us-ascii?Q?2k9anGRVrojLaH4lGq30q10TebTphpjNje9ARpultYLvi3Ee8pxWx6p+U0gN?=
 =?us-ascii?Q?up5s8emm1BRKiAOcntymIYWb8mMuy35mM4flVxjK4AM4IF4wm8BP0mK3CefY?=
 =?us-ascii?Q?jVDTOdWQ6fwC0Ji1xQjHPkLzjc8naeqmxHXadzL+ZbzBcebG1Ke8RPu1lZyz?=
 =?us-ascii?Q?vmWCxahX/uzTL5Nkms5uZGYbvVxIn+5PQ7eEKT8K4lQPbtGjLankl1O8AkEQ?=
 =?us-ascii?Q?A/UszuVuXqvHRCuVLf7GUSpt33cuFQ+0tWNi8y7ZHBr44XW0EPgZ992NWPCs?=
 =?us-ascii?Q?Yx5n/HiUN2EBgP6kjXhDe2Azo27jfHvEZQxpZ5OhuE3rsm88dosNxjyOCCpb?=
 =?us-ascii?Q?Iiw6OxIPiBSgCXKrqlY8q94aTuEhr03qWfEubm/nnzeATIlqtZSqkdFacRQ1?=
 =?us-ascii?Q?Tr/DY5nZX2V/s3NTUihp6CV4eX7o+8Z3fmFQ8xzNPkIhNGFS1CHwC4DS44mB?=
 =?us-ascii?Q?gLHwhNFXqhTpzLpGzDeOv/0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lo8N+3Yg++KPzVSKrQWPPh6/HHOBh+Px5YgClbKwlOVqK9eq+QTXQArHFkkF?=
 =?us-ascii?Q?NEvnEE0E7OMZDQ/1B2Gqo8/f7kn8Xns2OCVwBlCaPj0ysDYU1ktrg2B0BYEi?=
 =?us-ascii?Q?zf8y8ECZrOlvvEZOmAya0+XnGxynP7VZdIHSQNBO4jn1qaqJ2sNsnKlFhTTh?=
 =?us-ascii?Q?MElCiJF+AjiIg1aKpWzIs/bTsoUSEZTB6p70HFnBc7Cu7NJ7GQ+1PXcKctvA?=
 =?us-ascii?Q?+F8EMHF5Q60o6MputMfqW9NZLyHDq91Sx8hpmKslMV8yZpzAtuz9+0wi8fRJ?=
 =?us-ascii?Q?y7pHaHYdR8AcZcrDhJGHOpkXTSOlkf8cttgCl4lHs2sBRUSKQ+m40VNazNcf?=
 =?us-ascii?Q?WIf3R6qoXHZ7et/ILkH5k/VWndMY4d1S3jHTmYW73Ev8HMrH6NpKPnwPt7ry?=
 =?us-ascii?Q?xXGfI75MwzoaNgCXz7De5rKHN71IT6hdpmhGVwzm/joz3lib0ElMcuxu0J5+?=
 =?us-ascii?Q?s2gQFTw80Sv4DGlhtzkaF9RSXlnPYrUzXCwqlm2M91ZsXANFA8vM5h3te0Aw?=
 =?us-ascii?Q?L26kDaTLBIJM0sN5sP/H++gryfpcFOA2yZgNBhejhH4TQYSC53C+iHuHztdR?=
 =?us-ascii?Q?53voElkpVYAA/WBK9/dbq1k7m/edwf8vhMzZRKQ/HKzUiw0lvSqxR18NChDZ?=
 =?us-ascii?Q?yfC4hA4JdJuXUYt+Bm18cuyCurSirKsV3PJhCbDY/2Z0IuMHyB9ymI6xzXHd?=
 =?us-ascii?Q?R0yb4QTPBPIlEsYa4/KOrxZ3C5TS75wsj2Cb0pSfHQwf8jKhswXsYoCCr5L8?=
 =?us-ascii?Q?ezhy4AN3iBJbW4HsgERGg4gZKXcP6utxUXMwsy/U7gj+ACdg6mTl6NhZ0y+d?=
 =?us-ascii?Q?bwDHm0WBIcd68uKt0Q0SrulSntP0pl7xAxOeU8m0ahJ8EMk0gpyo/IrC9yN1?=
 =?us-ascii?Q?924A57Viq8LfrtjGlJ3okemtz7q9iThm7CArnTmXLbmKO6DdSzlQNt1lridh?=
 =?us-ascii?Q?Vu/7l/zMdCbNjeULlQmYpM1Fos6bTSwEJ7tdgQkz31THCWr2uEpnsJbIzEYp?=
 =?us-ascii?Q?FjzN0zT6QtRx+MAegtKrn3n7EsuF79Emw0IWN5gIQla78l8Z3DImToDzXqSd?=
 =?us-ascii?Q?H7SZiJaBU/ydkTlXeuOcKfSfVnBcWI89MuITs6kmLqnVDK8jqjYkwlrF4omA?=
 =?us-ascii?Q?zBkb3EilENVz2/JwFvK11IBhJMuwmWkOmAQN3ijoA+u8wd50Vlf9RZQqbNcX?=
 =?us-ascii?Q?lpy3Ul9XY9aN1dJ+rYumgyp3UlZl/u4cbevWEoMq9mpD4lOnhleNsX1n+TgI?=
 =?us-ascii?Q?bZ2itk4vv2da65kuoY2KThE+wpQ9/IzJhK1ni2hkDBhmUQb2EjNxVC6pnODr?=
 =?us-ascii?Q?cdvz6AJRDZFJL7Bj1v/yNLLth/RCAjSgLYyI2VYEorawwTwcx2/0AN9NzpU0?=
 =?us-ascii?Q?UO9SRaTsRwH4tT6KwdiLIGUOSKSYz610hB7S1dHevGIiCQZYTfv3i+Z3nVgB?=
 =?us-ascii?Q?p0z5oezFsw/GVinD9uaBlgNvMzsK97AfKc0T1uc0tRlFrAiJ0kJE5dU6ZkpI?=
 =?us-ascii?Q?uTtordOfq0y34WiNo/x+wqqSgJg2ikG0jThLLbw3OBTMiU4/bTEb/wgblbjJ?=
 =?us-ascii?Q?c3ZJpMFaW91dummjwKotC9nDVZ6dqPm++GHlGGTpQILphBL7TL/Cmod/wxtE?=
 =?us-ascii?Q?mijibNlwMYk/AMbV0NdbEqb3zryXlZBLCvpcBHovSqxLkGs39ln/TjMNkEcZ?=
 =?us-ascii?Q?jsJequiy0zUOWo/U1UFe74+dT87HUURuUVbufzVcUJBVc0HC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b9971-eedf-45a9-d2ba-08de5e05f3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:41:19.0594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Mse7HoNxJE3pOpECV77miEszo4ijg4EHKOSjt2pEujg+Ctk1xjH6RNHa8Aq2uxn9B9/2EzlRjl9fuzvvvz7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

>-----Original Message-----
>From: Joshi, Mukul <Mukul.Joshi@amd.com>
>Sent: Wednesday, January 28, 2026 12:26 AM
>To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Belanger, David <David.Belanger@amd.com>
>Subject: RE: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Yu, Lang <Lang.Yu@amd.com>
>> Sent: Monday, January 26, 2026 5:25 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
>> Belanger, David <David.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>> Subject: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
>>
>> MES FW uses addr(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
>> as fence address and writes a 32 bit fence value to this address.
>>
>> Driver needs to allocate some extra memory(at least 4 DWs) in addition
>> to sizeof(struct mqd) as mqd memory.
>>
>> For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, allocate mqd memory with
>> PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) =3D=3D PAGE_SIZ=
E,
>> it doesn't work.
>>
>> KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE.
>>
>> Let's use AMDGPU_MQD_SIZE_ALIGN to avoid hardcoding in differnet place
>> and across different IP version. It is used in two place.
>> 1. mqd memory alloction
>> 2. mqd stride initialization
>>
>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 9c11535c44c6..41f32ed39113 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1239,6 +1239,11 @@ struct amdgpu_device {
>>       struct amdgpu_kfd_dev           kfd;
>>  };
>>
>> +/*
>> + * MES will use memory beyond struct MQD size, 5 DWs currently  */
>> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) ALIGN(((mqd_size) + 20),
>> +PAGE_SIZE)
>
>Should we be using GPU Page size instead of CPU page size here?
>Maybe this should be AMDGPU_GPU_PAGE_SIZE instead of PAGE_SIZE or you can
>use AMDGPU_GPU_PAGE_ALIGN macro instead of ALIGN here.

Make sense. Thanks.

Regards,
Lang

>Regards,
>Mukul
>> +
>>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ad=
ev,
>>                                        uint8_t ip, uint8_t inst)  {
>> --
>> 2.34.1
>

