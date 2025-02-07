Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27804C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 16:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FA010EB67;
	Fri,  7 Feb 2025 16:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BlL1Q6mp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BAE10EB67
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 16:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKMKFIcStSCzwzOr11eEhvmz0hdFOzDCX4ULwZmfzYH1Lbq+CIyUacJpDq1j9KZAb2N+Jbumlg1BcLUxjKP0oqh5O1Ah6YrU0DDVGqofh5SyEgHXOc18bKkgQUR1TAYQLruFGgB39pm82TrmESJPFaJfT3anqUdj4r/NBGdvdJAZ3Q57GSM75cIQA5ixw/uP7x9Od3ZqSNO5qK5nJazBFt6ljVMWmoybiSQxDDofvxhPlj0y88TevcAmYSAOPTwT8NzhU5KzSSfM7eVX/y2gKW4k1pdx1dWaasfNxjnaYwl0PlCVX4RX4K8gSf2F4AJ48SmyhzGQbAWleXvJTG0z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8bpDcv74YBNv9aRo+pTzyr62CzpqTqOzSaiaeHXHHw=;
 b=nK973hQFhvaU3R96TTBCINRvTupun2B1trbYs0fnFFPKjCUTDhc6lJB6vTXIpMHIueAIOD30+B2uk4ZFdqCzbDBBC04maJ1OiIs8ccrT0xPaF9I2QMgIOttwC2ACQxZox8RqXUNxXoMVx3s9Zvoh2ZcNjNKl30d+zHmFbBBXfpkeAszhEkZPXhu9V+2KERbZ8/bzpumiIPzykUBerzHLd6APMFct32YZvMysDnCfV8kluN2wt5xl5anfkPXAsW4U95un+OHT4mpKLPi4AW/icm7C8TyOy5y969h2yHlT+yKXdIGcczapS+kGGTLDZR1ni1o02F69+X3Qkf90/6MEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8bpDcv74YBNv9aRo+pTzyr62CzpqTqOzSaiaeHXHHw=;
 b=BlL1Q6mp6q43RhQ+ezYEIok/c/HPlLyCTsUxovgh2dlZaEcvhKUrVjk2zYRRImgsg+cVrV7DiRycD6YJj10lSxxIYhB9I/DLuSQrWCQtld4bRimbsm1906bsvWfxGRCDhcJD05D/e+7EOyH1DBhZZTN6n1WSwTQWT9kWUHTceso=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 16:06:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 16:06:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnufoX/znsFkKKFBtTIxr8MbM67caAgABJgQCAAKiIAIAABdaAgAAEawCAAAu2gIAACroAgAABmPc=
Date: Fri, 7 Feb 2025 16:06:09 +0000
Message-ID: <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
 <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T15:54:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB9526:EE_
x-ms-office365-filtering-correlation-id: 8c3c7035-88d4-4268-cbda-08dd4791560e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TpvZjvWZRF7pw1Bu7/mHjkRB9dYRazl2aMCi1/QYYd5jtdfGol2cnn+M1YGc?=
 =?us-ascii?Q?l8sinoYaMOWBpLRdQMj82Bo7v+BSTZjX36s307XBt9RQ+lPvMiZtX/rKY/qu?=
 =?us-ascii?Q?uyEWi0P8U/voh23lmDl2nc1JHsdruthXOUUM1bnJlC7NX9uistZP7vcRLkR3?=
 =?us-ascii?Q?5vAmqySuFqp8dpibC1m6t3NgTYQYIN5oiMLQ3jPj3wIkhrA8VHJzpKEcwIq6?=
 =?us-ascii?Q?YyDBuzpUwFS2kesh0id1lT5ZC52fbA5avqnVjRDaaeGAk3V9S95jZPFESGGc?=
 =?us-ascii?Q?XDdCt4gMb63jqmE49yQujglDBmJOFHQNyFReSFH1RalpcoJWZjvuNaIrYDQQ?=
 =?us-ascii?Q?mhyJT/lp1rKKIgCqsGuzvBRHKOCvVuC/LP5vlsjYxV1YcIq4hNoHY6ixy/Ts?=
 =?us-ascii?Q?3AAfW0+yQNXqKM58h27D0dj9wb/NlKnN1Lxbmdrpmc53Xt6xm5n4lcfs0vTA?=
 =?us-ascii?Q?R44I3xUhxdJgIBUzK3p1Os8DlfT2eNdBOegrehicQGXEyYCPKZHq6NQL7jCP?=
 =?us-ascii?Q?Wa7N5SRUx0okYnVUONVDehuvnKIA8GKh0Qd6G9icfptGjn9HZAq9LKYZmooK?=
 =?us-ascii?Q?yPM2WhATJcWLg59f/S0hHt2sMEKvgZfBadimKgMbdlg/h9naklpFwCVoVddT?=
 =?us-ascii?Q?1MrLwqPicu0edMBpuoSuIkaABecXoK474pk9KlbstkgbewcGWcY+mkUzEJIk?=
 =?us-ascii?Q?ENoKZQS5Xq/Awf2srPxq2WjRtWnM4d07wXnztKayP6EnyS+iYZ9o45DjUu+8?=
 =?us-ascii?Q?c5JJ7wkT/SqnB4mD1miOetJ8H6hG7eefYSwmfMo43fgwNk4V/7sD/zJBTmAI?=
 =?us-ascii?Q?0/Rq5ALKAmJLReRcJ8hbb5ZJhy4ho9D4AOuhmEuuwsa6WCRWfRveuChCAWdr?=
 =?us-ascii?Q?VQQNJnB5oTOzzPik8kwJEHWG5urXVJxMatDwuCdDC+YYj0AnS+CXLBdW6wXb?=
 =?us-ascii?Q?PgZs76tJBzq8lQH7qxkCpleGYvmdLMVjxJZJZ5mzJDqXLzZmvyfKedTx8drA?=
 =?us-ascii?Q?inPMWEttKdYGx005AgMLc6YDmcDseFR0aqO/V1D2bSZgEAx+tGQkZrtLu1Pa?=
 =?us-ascii?Q?vvGT042h0tTySDTRvy91RaR9lVu+2reLtNjg9m3wz76M4EjbU+iTv6H6CGDA?=
 =?us-ascii?Q?oqdDR7RiSRwvcPsnRAA2ic5QdZP1nGdfNPQiyrykKrIOhpmE4YewpxAiSkp0?=
 =?us-ascii?Q?8yb/YIiUd5z4Si3J3XaYswoul/lwh05jlMyW0OExFuz/Y7w5VNyDW5OEtw2k?=
 =?us-ascii?Q?gUR2u5RS+CAJb7+4CSPRaw1sNgeYZoJpn37De6o1Jpsg6sqy5Z1cXNoTUyUd?=
 =?us-ascii?Q?YAnXsV4jQtBbAtNjXkCQXc/i6FHTmwSee7fXuOgiXlK6IKx2bIjqGuy5ssgb?=
 =?us-ascii?Q?QelYIr+OtzErBh6C957hvct3BDzhBZZaF+oxoorYdLdlFhAig7x+1apbgXcN?=
 =?us-ascii?Q?nNxtNa+XYTEYC6gKE+oTNT52zNQEmVJI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwMyxb297i4M+B4HitdBIv7zVoA+GtOYVdAjuMCiI1LquI32il3kbDBrD+Ii?=
 =?us-ascii?Q?1xJuTrebCCRbVasaAZU1K/fLfdCXFb0Kyad4ohEoDlwpFeXT8arzxSIngQ9z?=
 =?us-ascii?Q?0UzGWBV+BVCcwrsN97y8PnBpYgV9+dIzU5t3kdAa6GldLNJ4G/2Mbcc1Dr3G?=
 =?us-ascii?Q?NY6FNk5HbaGMabzbk+Muv9chmXkHb8KNeV5m6CxEMClm9niWXrxSAlV6/haV?=
 =?us-ascii?Q?uUMwwmcH6nkK6zb8neD802dcFKFSvNNWUaL7vUWShIbcEvob9v6oqu1v8Irb?=
 =?us-ascii?Q?Fjy/jACOuienUK4KkARKjYkq4OvPnqJFD26LIvghzHmNLJY4RSR4SUY8I81k?=
 =?us-ascii?Q?mjTE4Q3RDxWchnYat62Z8EaHUQGrR2k37YMIKbQXgI4OsFG8ieDtU0R7KbBe?=
 =?us-ascii?Q?LctFIlNjcL3Hyg1ZMHncQL4oyFIl26EFVKG32e6uTV0k0Vs3K0y7xgZsxBAz?=
 =?us-ascii?Q?e/9sR5o7W2tqeeWiz1+TUekiBz/kTkPLAWDgyezXu56T86cmfi7xR2i/33x0?=
 =?us-ascii?Q?yjju9/Is5bKb4nUNSCu96xWfAGexKbn29Ce/gZl0/Ie0+0am/+skIr2N/fnO?=
 =?us-ascii?Q?J09WRL9LlOBysb0LP9kXFeazxN4XrGfbKNCmHXv0Dor0zhiVhIE/8K1x9CRV?=
 =?us-ascii?Q?mCkNe3uMwxOY7OOmtuEkaoKOsFLAcPE+vLrxgw5/MnG3ajkmMxj4YbdStx8Z?=
 =?us-ascii?Q?o5FnT0S35e+Hp5/+g2lUBQyF29s7lZB/5obgpPT3mrj7w5K2zApf/8mWnv32?=
 =?us-ascii?Q?vJgAVqo5v3QmQIRBnmBK5Kte6brLCwJ3yAqMB6OCDRfIlYSk3N5WK67+DlG9?=
 =?us-ascii?Q?S9WFJJ6mqIjXEpbYUQLDO9iwWOgv8wy9CzY3CrmFbk8dtRXQnNN/GHEwZXHT?=
 =?us-ascii?Q?wiVw8Asw+EpUAePhYGqbbnztwo6yGmHNH2w5wGKZ5toIEnnDj7y+s2+16Klt?=
 =?us-ascii?Q?4wPTFbzmdAkgThQIqphgXrExf/Ga3OLfTavXkOMeoFGvC2DaUj6nZnH1OUIM?=
 =?us-ascii?Q?lzbul8zGYr7Bts7dpIgAeCNsS2kMBlFn9lOgD2QMuay2NchrZcU65pJz1u+4?=
 =?us-ascii?Q?7F8pZRrlj/R+xO7IrIXmi7Um15HQr6DPbYqcn+yfoWwhzKZjKaWePFZEgbPj?=
 =?us-ascii?Q?FiKUksyFDew8oplRbjWabeL6Z0BTPL9g18OamoB9JPWPJY6iVXDotFNTfYk5?=
 =?us-ascii?Q?FDCX34iQq2cUVWGxH/uYJwH0bXpyKlCC0t7IyfZF/KGXoiADLWZxM68XL+wf?=
 =?us-ascii?Q?4QGaZi7L0yBFPQa/shlRLUuKkMpzr6LfBvlZXabkPenaBYWTi5YZwYYULol2?=
 =?us-ascii?Q?CXzmUZxpmHSCiOWgvKisom2DinQAkAd8gf9dtFq7SG6FMr2oFd6GqfA8pObC?=
 =?us-ascii?Q?6SDu53w7VldIM7qJZDi5SIrFOjv+pKL3udSt7B8+gDJw37XPEL0mXCJVODKW?=
 =?us-ascii?Q?Ndi0pl4cdnUc5Uf2uv0VgcFGc+73B8ozM/7zgDOOyZ5LdKhqqGRtQ93ddN75?=
 =?us-ascii?Q?Kft6MphROtgn7qIm23P0xjYCT54r2iY5ZpoemzCuwQFI/d506OsIDBYJUHE9?=
 =?us-ascii?Q?FjSX8b6ooxi+duGmMlWoOPZvPPJLWYpGANlm3OQ2?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB7804043F80CCE669305F984097F12DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3c7035-88d4-4268-cbda-08dd4791560e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 16:06:09.5646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lE22N5dqOAeKisUUUpNGW5iPEv4iXZLjexjAc2mgYy+F38hFMAvyyUBLZN/ZkWRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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

--_000_DS0PR12MB7804043F80CCE669305F984097F12DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

It so happens that driver gets part of the XGMI information through registe=
rs in GMC. The intent of those registers is to help GMC to figure out memor=
y access when device part of XGMI hive. Driver using those regs doesn't mea=
n XGMI is like a sub ip of GMC, it remains separate.

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Friday, February 7, 2025 9:26:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 7, 2025 10:18 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discover=
y
>
>
>
> On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Friday, February 7, 2025 9:20 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.or=
g
> >> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> >> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>
> >>
> >>
> >> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
> >>> [Public]
> >>>
> >>>> -----Original Message-----
> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>> Sent: Thursday, February 6, 2025 10:56 PM
> >>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.=
org
> >>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> >>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery
> >>>>
> >>>>
> >>>>
> >>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
> >>>>> [Public]
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>>>> Sent: Thursday, February 6, 2025 8:13 AM
> >>>>>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com=
>
> >>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
> >>>>>> <Jonathan.Kim@amd.com>
> >>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>>>>>
> >>>>>> Initialize xgmi related static information during discovery.
> >>>>>>
> >>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++-=
-
> ----
> >>>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> index eca431e52038..d4eade2bd4d3 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> @@ -2502,6 +2502,19 @@ static int
> >>>> amdgpu_discovery_set_isp_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>       return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *=
adev)
> >>>>>> +{
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> +             adev->gmc.xgmi.supported =3D true;
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> +             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>
> >>>>> Can this stuff get rolled into xgm_init_info and called directly in=
to
> >>>> amdgpu_discovery_set_ip_blocks?
> >>>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separat=
e things
> >>>> seems a little confusing.
> >>>>>
> >>>>
> >>>> Intent is like this -
> >>>>       Set IP version info. This is the job of discovery and kept ins=
ide
> >>>> amdgpu_discovery.
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> >>>
> >>>
> >>> Then why are you proposing to set up static information in the discov=
ery file in
> the
> >> first place?
> >>
> >> I didn't understand that statement. The function - amdgpu_xgmi_init_in=
fo
> >> - called from discovery sets up the derived information. Only IP versi=
on
> >> info is set inside discovery.
> >
> > Snip from you're last response:
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> > You're calling amdgpu_discovery_set_xgmi_info which calls
> amdgpu_xgmi_init_info which is setting static derived information in the =
discovery
> file.
> > A wrapper called in a wrapper is still doing the opposite of what you'r=
e saying int
> the snip above.
> > If you're trying to avoid this and keep discovery clean, call xgmi_init=
_info in
> amdgpu_device.c somewhere after the IP blocks are set.
> > And put xgmi_supported definitions in xgmi_init_info since that doesn't=
 count as IP
> version setting.
> >
>
> This is only about structural segregation - like the place where we want
> to maintain xgmi related data. Functions setting IP versions and
> information from discovery table is kept inside discovery. Any function
> which adds further static data out of the IP version is kept in the IP
> related file.
>
> This is not about a logical separation like xgmi related information
> derived from an IP version shouldn't be set at discovery phase.

Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.
Otherwise, we could end up with a bunch of word salad.
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.
e.g. gfxhub_v2_1_get_xgmi_info.
Then that would take the pressure off all this file reference jumping and v=
ersion checking.

Jon

>
> Thanks,
> Lijo
>
> > Jon
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>
> >>> Jon
> >>>
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
> >>>>>
> >>>>> Maybe roll this check into xgmi_init_info i.e. void early return if=
 null.
> >>>>>
> >>>>>> +             amdgpu_xgmi_init_info(adev);
> >>>>>> +}
> >>>>>> +
> >>>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >>>>>>  {
> >>>>>>       int r;
> >>>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>               break;
> >>>>>>       }
> >>>>>>
> >>>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> -             adev->gmc.xgmi.supported =3D true;
> >>>>>> -
> >>>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> -             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>> +     amdgpu_discovery_set_xgmi_info(adev);
> >>>>>
> >>>>> If you do the suggestions above, you can just call amdgpu_xgmi_init=
_info
> >>>> unconditionally.
> >>>>>
> >>>>> Jon
> >>>>>>
> >>>>>>       /* set NBIO version */
> >>>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>
> >>>
> >


--_000_DS0PR12MB7804043F80CCE669305F984097F12DS0PR12MB7804namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto">It so happens that driver gets part of the XGMI informati=
on through registers in GMC. The intent of those registers is to help GMC t=
o figure&nbsp;out memory access when device part of XGMI hive. Driver using=
 those regs doesn't mean XGMI is like a
 sub ip of GMC, it remains separate.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Thanks,</div>
<div dir=3D"auto">Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:26:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; Sent: Friday, February 7, 2025 10:18 AM<br>
&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/7/2025 8:06 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt; Sent: Friday, February 7, 2025 9:20 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists=
.freedesktop.org<br>
&gt; &gt;&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info dur=
ing discovery<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/7/2025 7:29 PM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 10:56 PM<br>
&gt; &gt;&gt;&gt;&gt; To: Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-g=
fx@lists.freedesktop.org<br>
&gt; &gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi =
info during discovery<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 2/7/2025 5:03 AM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 8:13 AM<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; To: amd-gfx@lists.freedesktop.org; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Kim, Jonathan<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &lt;Jonathan.Kim@amd.com&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH 3/4] drm/amdgpu: Initialize x=
gmi info during discovery<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Initialize xgmi related static information du=
ring discovery.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.=
com&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c | 20 +++++++++++++--<br>
&gt; ----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; 1 file changed, 14 insertions(+), 6 del=
etions(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_discovery.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=
.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; index eca431e52038..d4eade2bd4d3 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2502,6 +2502,19 @@ static int<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_isp_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +static void amdgpu_discovery_set_xgmi_info(s=
truct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Can this stuff get rolled into xgm_init_info and =
called directly into<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_ip_blocks?<br>
&gt; &gt;&gt;&gt;&gt;&gt; Breaking up discovery_set_xgmi_info and xgmi_init=
_info as 2 separate things<br>
&gt; &gt;&gt;&gt;&gt; seems a little confusing.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Intent is like this -<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set IP version in=
fo. This is the job of discovery and kept inside<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery.<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Then why are you proposing to set up static information i=
n the discovery file in<br>
&gt; the<br>
&gt; &gt;&gt; first place?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I didn't understand that statement. The function - amdgpu_xgm=
i_init_info<br>
&gt; &gt;&gt; - called from discovery sets up the derived information. Only=
 IP version<br>
&gt; &gt;&gt; info is set inside discovery.<br>
&gt; &gt;<br>
&gt; &gt; Snip from you're last response:<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt; You're calling amdgpu_discovery_set_xgmi_info which calls<br>
&gt; amdgpu_xgmi_init_info which is setting static derived information in t=
he discovery<br>
&gt; file.<br>
&gt; &gt; A wrapper called in a wrapper is still doing the opposite of what=
 you're saying int<br>
&gt; the snip above.<br>
&gt; &gt; If you're trying to avoid this and keep discovery clean, call xgm=
i_init_info in<br>
&gt; amdgpu_device.c somewhere after the IP blocks are set.<br>
&gt; &gt; And put xgmi_supported definitions in xgmi_init_info since that d=
oesn't count as IP<br>
&gt; version setting.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This is only about structural segregation - like the place where we wa=
nt<br>
&gt; to maintain xgmi related data. Functions setting IP versions and<br>
&gt; information from discovery table is kept inside discovery. Any functio=
n<br>
&gt; which adds further static data out of the IP version is kept in the IP=
<br>
&gt; related file.<br>
&gt;<br>
&gt; This is not about a logical separation like xgmi related information<b=
r>
&gt; derived from an IP version shouldn't be set at discovery phase.<br>
<br>
Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.<br>
Otherwise, we could end up with a bunch of word salad.<br>
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.<br>
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.<br>
e.g. gfxhub_v2_1_get_xgmi_info.<br>
Then that would take the pressure off all this file reference jumping and v=
ersion checking.<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt; Lijo<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Maybe roll this check into xgmi_init_info i.e. vo=
id early return if null.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_init_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; int amdgpu_discovery_set_ip_blocks(stru=
ct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2769,12 +2782,7 @@ int amdgpu_discovery_s=
et_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_se=
t_xgmi_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; If you do the suggestions above, you can just cal=
l amdgpu_xgmi_init_info<br>
&gt; &gt;&gt;&gt;&gt; unconditionally.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set NB=
IO version */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (a=
mdgpu_ip_version(adev, NBIO_HWIP, 0)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2.25.1<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB7804043F80CCE669305F984097F12DS0PR12MB7804namp_--
