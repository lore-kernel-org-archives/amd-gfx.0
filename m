Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422AC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 16:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F9210E9AF;
	Thu, 16 Jan 2025 16:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p49kZ4WJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6BE10E9AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 16:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu7m+3JxBV6hnMcK4gu5BvX1P+9i6Lo/0AkLwqhWIUKv7US1mhHoUxzbgN2+rrxY2BNexsGmaeVNXKsSE2VzWfGNj9Uc3XUnFXHfJRhZouJo7X0Z0wDFkRe9x6ED/Wzo/FwJO/3qGBJtFJnUN9hQbareDQcp01tUTN1OZJFmhuOvDobyySNbSOvHq7Q/tnPIgfBuoD3Z2SBtv0NyOJ6pYOOJ+4pD4QWUQlZFVuyquBpWkg2ftzhmHqIFddWOzXcr+2pWetu59JCR0k5f4vHIrxzxY43yg1rVRuXCEnXUiQhlvUn4qbPDZAdlTuyEfT+fw6vZ3HyBf3Y0hoeY052Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A+/ZYVh3PpscLMsYiFG0X+HCLJ8IgYN5jgp8CGWzbo=;
 b=iYum8v4CRsNfdNHfSO3FRLFRQu7heyQqktRbs2I4qMrwDqUb4AJFWfJNBNfGq10hmxptpjwLOXiPLIF0HETJtByG59RpICf7Ca6nCzFUWNjrG8wzzC3r9wm7Eo+eA/vAkf3uEAYwX20MTOrnktYJH+2Kp0YtlsCKc1v4YLr4BaBDSe0F627+8w2m3ZXT5Y4MgGBkig2EmwXZNaRI/JijYgDHsAc0dEen3FX6YAvuIySsMlulSfV/6lgR31RT6oZF49927ZzPxarTXblNfJ+Rz9UxzWtDqWl0/kH0jkGs3UBSA53Gz71vBKOWy6CZh5ufF34SHkLReIYsjoF6wXgUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A+/ZYVh3PpscLMsYiFG0X+HCLJ8IgYN5jgp8CGWzbo=;
 b=p49kZ4WJ329OAAdacSyAARyp6boj/LKFlgxZ6UXD3MHLJT9PG9PZlwI8j+Y0uVfG5oBp2KrjxDi2qbSJ729GvjPfnWBaqb4Oyaw7udjyDFBLCT3awnlDPvHN7Bk5vIUN484OKftwa2dI4k5/SXv+/JWSe04mVsT6XzPF4YcV87s=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 16:20:49 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:20:48 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Xiao, Jack" <Jack.Xiao@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Topic: [PATCH] drm/amdgpu: validate process_context_addr for the MES
 shader debugger
Thread-Index: AQHbZkNa/koG/R+y6U+zZIWe4qYqD7MWfdzAgAKkHACAAG/9oA==
Date: Thu, 16 Jan 2025 16:20:48 +0000
Message-ID: <CY8PR12MB7435CD1D4A1E308298D1728F851A2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250114051520.2917015-1-Prike.Liang@amd.com>
 <CY8PR12MB7435E8013AF15165A30B8D0585182@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS7PR12MB600558CE3227FC5817DECE92FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600558CE3227FC5817DECE92FB1A2@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ff1206e8-ebed-451f-92c9-5ad0389420fd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-14T17:13:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH0PR12MB7908:EE_
x-ms-office365-filtering-correlation-id: 4861db2b-1b04-4b95-1292-08dd3649bcf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+4W4lY6sG9SmKI1Kvf26sD8gXeBCBUJswKNT4jXPP5LjDkgxzFGJIq/I9iBR?=
 =?us-ascii?Q?TTbeQ8gCWbOuB9QmyWLr6v6gnZBxbTthBvmBuY/4GHQR8QBPO4uIxU6B86cl?=
 =?us-ascii?Q?OgyHSz+kotaiiw4D6eLs4Ie0OI0y6mlFjRF3DiMa1ay3hvedSlRKywW9hQiv?=
 =?us-ascii?Q?D9UwCv3rRAhi0LR85hn58bKlLOx5t8S31z+KCkDBHmMd+5HUBFYqezhxirIS?=
 =?us-ascii?Q?xcjOtOzts7EuS6OixlEuOAPEOWMMlwZl81yNZZPX/sZVM2/ZyMwSaqpjf7cO?=
 =?us-ascii?Q?cAuZzIWyt2MMW2j0aMbKJBUbeT325qnAp+M4fZnJlUo2phk1Zc/6aMzzuXBh?=
 =?us-ascii?Q?/yLBUypGDcuAkoJv6S8w/BCyVsrTrlHe8pCIZm8Y2P+t/pxe1sWhelyQIMGW?=
 =?us-ascii?Q?WYasSvFPMKX72j/JEDfILlNLAP0uswuFMyLS2HCC9pL99LbavDOdyOp7AMfG?=
 =?us-ascii?Q?1jB70d46GZ7A/sqkesF9THLDef2KmpGqOUxD0Sivw3a/PhjPVn4vFRgvSjZy?=
 =?us-ascii?Q?SVCsEwE5Nu87AxR1KCwIjWmNvtFv0Y0syIMccwNN7Rv2qBsGQ1ZlnB6f2PQB?=
 =?us-ascii?Q?M7Sg6v2ATai+qKGKBh9gvssxQA7NmypPJcl5xhX86wNg+NUinZAYYKIfvd3R?=
 =?us-ascii?Q?62NcLw9mtS7ei/WrVwrREcS1kB4aSxvBKR2wBIUkN/oNoGkhb+t4CtDXkKKo?=
 =?us-ascii?Q?Yd8WFTvSO4tOFMgKv++A5FZy/piDQMSvT5Jk/FrZp7X4jVRRLbPBk9VGZmqC?=
 =?us-ascii?Q?ZTOZsGiCmk/+bZ2emGfHnngRhdQ/dcEs6vZxCs+xH5WObHJo/NQIJcMtT95x?=
 =?us-ascii?Q?6Fg1Cr6Q0Rc8UKQnzYPgYpeFTY1lHmS40mZP9S1iVA2mWGHGlQFD4qDr0uai?=
 =?us-ascii?Q?WWI9ckwcxKqPKFZ3wpUttBB4NwkKHH+XSp3yweYQxxLzQ/9xYYGBSRhNGwNP?=
 =?us-ascii?Q?EXKWu5ZqoSdeh/WQiQzz8l0G9b5Zemu/guChPN54AITKs+gWE1nWVCepfryh?=
 =?us-ascii?Q?qxqQphnG2j8W6FFRED6R2hNpbL+JRMmUEz4i0VRx6qNFr/MpVM41dHwHRKNv?=
 =?us-ascii?Q?LVQbALDGKKBabEhGdJLCQiiCDvP8hhhJZsdE+5NEQOPzsmGrwBnUGvWEUOAC?=
 =?us-ascii?Q?I10WLy2EQHP1PMEt5PMAsJT/IZkMZJiEyDFTAFgabil/vgMBNpjeCmiO7KsK?=
 =?us-ascii?Q?2FR4ZosVMoDHZyep5WVZzJ1Lf85FLwuHSyd2jPNekaJYplcPdyXdjn+reaJG?=
 =?us-ascii?Q?qBxyamtAG5L4DDJCvYJhQosXSxoDsIwM4fRpSspG2xvjtIpFwrQBm62/Zs6Q?=
 =?us-ascii?Q?8fZDIu34uEWSNoZ7h2hsApBQq6ynxJbHqWNZ5Edp47kuzo528tsUok6vkqB8?=
 =?us-ascii?Q?PKxFAnAGslKRhottqCNTQe3FQnjyiySDd7BF9VRIGTwpOhRjIQDx514s01yO?=
 =?us-ascii?Q?NY7zKELeytoKY9RK1fWZOpodY25X3Lkh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RZqQo4UcwECs+ghQMy3Bpu+1K6f6Qnw2xBGlYuNkCFJucUCa19MDyAWwbgQb?=
 =?us-ascii?Q?2MyWWUJj68JgihoFuCiyxf2Nb1r01HAcis9Q0t5Ajkflq/RHJTMiX84PEQzW?=
 =?us-ascii?Q?TToDbRzB4Gs97hm/WZcNV4AsqZ1soYkL/jOfIh0nVYp3YWPGLXTAwf6V0x+f?=
 =?us-ascii?Q?s/wvqvDbZ/EnITaOI9wmperVol84JyClvFh892XM8hFxIm03lwn5ndXkvKcB?=
 =?us-ascii?Q?HfOkVxPBH2Gwe8tqdjy4HJL41IUK9S2FCYCOG7MW7EQOcCckMn+RHp09Rft8?=
 =?us-ascii?Q?fGThdB3V8VHFfVEgyGU000uv80jQeJ33skPI7n2hbQi8sXjMhiPQPH/I3qj8?=
 =?us-ascii?Q?hmxEwroRZSyRj4EQNnqmhhuKL+E+CtC9kMVAtOT6GlXw8dWsmF0TLB1F9j8j?=
 =?us-ascii?Q?xdFiJw/noapPESyy58VvlQQOvb4bptgArjkSgQMYkw1RnoACbehxlcvk8Slo?=
 =?us-ascii?Q?70HtDtK5GYDA+3V38c0BHH5NyetSbuNVOj5Bgc/kBwfZvDh5mBsXzWtCNo9F?=
 =?us-ascii?Q?T5SuHotZCVbso8MwNZV7HC3iUXuanAVcB91o6rQsasp7hQiGRhEvSvs3v9mn?=
 =?us-ascii?Q?uVCwqrem3J1i9bcEuhxEc5tpIeoQuZut1bLjFrOimPGQDtX+/EVxKVW98Q4E?=
 =?us-ascii?Q?PHNI9ECH3z3DD0Eka4bR3dGKszTU8jAvufmiAMfY8Vs4ZHjEW2mwLOGIBEXZ?=
 =?us-ascii?Q?bsFO8Qssgsip8/pX0BM2LSdWLQ/71Krw6hkSYXNicwgyYrj6vNjTKHkgocDM?=
 =?us-ascii?Q?+kp/YlNuenpdxM3ZiSb3vBB5SZ45PDAWKNDbdVCBqd6xRhrhRNB6Dj2xNY/o?=
 =?us-ascii?Q?UXCJ3DhD0dhTmsD3lQDM7+KdNXKj7UrxgiA33a3yAxANtEZqHNX+dRpygFp5?=
 =?us-ascii?Q?nJ7d0zSBLQhMnZ1elZ+7lsTS+cdgJLLhRiGbASNuNrPl8GMUsPn70uAVO+eh?=
 =?us-ascii?Q?cHc+9gmGvhdAx3XaLk0xUgfXtOlhMNrle/OofZrvUZDMnc+pfEMCau7IGM8B?=
 =?us-ascii?Q?ug0J7+r3dSoRc4DVWCFuYhD1lKSrtVGm1VgVlazfsAVvzIF1tqUtAXa039Fk?=
 =?us-ascii?Q?YCcZu5bGw1LudvOB9UMmklHp50DQChUfa80kXyBBhSddTXwdvWrTibhrzdbY?=
 =?us-ascii?Q?1coOBXrltDUiXKb+W0yvhU0u2KuY9QDP+e6vk4EgRo0jrt2V4ArclTMFA/Sp?=
 =?us-ascii?Q?9ajhr2/BNPqXnxMMoYCu+lFlztLkPGxrLqXRTkQpCDAyJhK0VbSDSlyQzKjs?=
 =?us-ascii?Q?ppBnLyBVYIsDzvJP8xzLMwmzHXb5b8AREa8530sdwVhkJie6KpkscXCXq8bp?=
 =?us-ascii?Q?CIoVtsH3Ylre0xJz9VWjCmoXK7924aXL04tTk/W9XE6GKa6rQjqGTwstIHGk?=
 =?us-ascii?Q?+e18Kjt3yk0dMqlhChfaL29a/Rwle/OHCqbHpoqBCxGTUaLf26P0CrW8lrAv?=
 =?us-ascii?Q?2j6r/KP9NRC+VU6zjXS1JsnC34PI0b8hHdcLvd5OI5jGidwsqjTZ2ONrm/X4?=
 =?us-ascii?Q?skiO5rJ9k+aXu1TVA7JtwC5vJIl8uS9V8UTs9pIBsrItncrve5ximMFc12VN?=
 =?us-ascii?Q?mU1G3lDbd0R1okY2Yqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4861db2b-1b04-4b95-1292-08dd3649bcf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 16:20:48.6927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq9l5eklgKZpXJEKaW4LLO7ddZUThb0FN949byXaXIaF+S6Ra0vYeSkt6puez9mS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, January 16, 2025 4:16 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org; =
Xiao,
> Jack <Jack.Xiao@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the ME=
S
> shader debugger
>
> [Public]
>
> > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Sent: Wednesday, January 15, 2025 1:14 AM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: validate process_context_addr for the =
MES
> > shader debugger
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Tuesday, January 14, 2025 12:15 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> > > Liang, Prike <Prike.Liang@amd.com>
> > > Subject: [PATCH] drm/amdgpu: validate process_context_addr for the ME=
S
> > > shader debugger
> > >
> > > The following page fault was observed during the exit moment of the
> > > HIP test process. In this particular error case, the HIP test
> > > (./MemcpyPerformance -h) does not require the AQL queue. As a result,
> >
> > I don't think this has anything to do with AQL compute specifically but=
 a quirk in the
> > KFD where the KFD only creates the process device mes context when addi=
ng the
> > first queue.
> > Maybe we should move context creation from the KFD add_queue_mes call t=
o
> KFD
> > process device creation when MES is supported.

Looking at the git logs, the allocation got moved to queue creation recentl=
y which is probably why we're seeing this bug now (added Jesse).

Commit description:
    drm/amdkfd: pause autosuspend when creating pdd

    When using MES creating a pdd will require talking to the GPU to
    setup the relevant context. The code here forgot to wake up the GPU
    in case it was in suspend, this causes KVM to EFAULT for passthrough
    GPU for example. This issue can be masked if the GPU was woken up by
    other things (e.g. opening the KMS node) first and have not yet gone to=
 sleep.

    v4: do the allocation of proc_ctx_bo in a lazy fashion
    when the first queue is created in a process (Felix)

    Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
    Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>

Maybe the solution should have been to transiently disable runtime power ma=
nagement and leave allocation where it originally was.
set_shader_debugger (wrapper for mes flush) also gets called on debug attac=
h, which can be a queue-less call that requires MES process context.
Having to remember that MES process context creation happens at the queue l=
evel is confusing.

Jon

>
> I didn't look much into what queue type is created in the HIP test:
> MemcpyPerformance, but the issue is that the KFD queue isn't created when
> executing MemcpyPerformance -h. This means that the MES context process i=
sn't
> created yet in the KFD process that is released. In this case, the MES qu=
eue will not
> be set up. Do we need to create the MES process at each KFD process creat=
ion?
>
> > Strangely enough KGD has an amdgpu_mes_create_process call that doesn't
> seem
> > to be used but does exactly this.
>
> Yes, it seems like dead code and may be implemented for user queue cases =
in future
> usage. Maybe we can exclude amdgpu_mes_create_process() and
> amdgpu_mes_destroy_process() from compiling to reduce the kernel binary s=
ize. Hi,
> @Xiao, Jack  could you please clarify why we need the unused function
> amdgpu_mes_create_process() here?
>
> > Otherwise, since the driver is always supposed to allocate and pass a v=
alid context
> > for any mes call, maybe it's better to do a context null check with som=
e comments
> in
> > the kfd_process_dequeue_from_all_devices call to reflect this quirk.
> >
> Yes, I prefer to add the MES context check in the
> kfd_process_dequeue_from_all_devices() function rather than creating the =
MES
> context regardless of whether it is required to create the queue at each =
KFD process
> creation.
>
> Thanks,
>   Prike
>
>
>
> > Jon
>
>
> >
> > > the process_context_addr was not assigned when the KFD process was
> > > released, ultimately leading to this page fault during the execution
> > > of kfd_process_dequeue_from_all_devices().
> > >
> > > [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > > (src_id:0
> > > ring:153 vmid:0 pasid:0)
> > > [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at ad=
dress
> > > 0x0000000000000000 from client 10
> > > [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> > > GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> > > [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client =
ID:
> CPC
> > > (0x5)
> > > [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> > > [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> > > [345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS:
> 0x3
> > > [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
> > > [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> > > [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> > > (src_id:0
> > > ring:169 vmid:0 pasid:0)
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > index cee38bb6cfaf..4d313144cc4b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > > @@ -1062,6 +1062,11 @@ int amdgpu_mes_flush_shader_debugger(struct
> > > amdgpu_device *adev,
> > >               return -EINVAL;
> > >       }
> > >
> > > +     if (!process_context_addr) {
> > > +             dev_warn(adev->dev, "invalidated process context addr\n=
");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > >       op_input.op =3D MES_MISC_OP_SET_SHADER_DEBUGGER;
> > >       op_input.set_shader_debugger.process_context_addr =3D
> > > process_context_addr;
> > >       op_input.set_shader_debugger.flags.process_ctx_flush =3D true;
> > > --
> > > 2.34.1
> >
>

