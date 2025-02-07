Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D019C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 16:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B9C10EB73;
	Fri,  7 Feb 2025 16:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j87E9Grr";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E521110EB73
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 16:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kww/1Id8So4KwGMEmbqQ8w1eMQPVBOCMDsaRwAv1ckkN7+uunnedHCPYfV4siDv0R52jnuuk0uU7Z14aneEyytnRwE/5EHH4ukUnGrG7b6gzieIQuBlicmNRtr0O7XnvoeB+OhgQN4mWCDazuDIFl/nmQBbx4nkTEyMQEKhA1z3umEzwS9aIIqOjK7N8ZKxs3BGnB0igNtK6hQsntFc7LzgN5FyV+4cOMyYnJLQW2LF+pZsRIfwszBS3ZdAjwjeWxu52qwQIqfxdokph9nC85wctRkui3Nu+l2iWJJQb9g34ecvYcZ4y2w/heeOkw/z8IM4kSqql/gi/ZMXrBKgxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zR4b/V2kroFk3+TSN+7jQON52OoOMbUqvOR0CnzSTU=;
 b=BSNxhBrtBZGXeRigsDFSfKlgO+psVmN45O5WHOQpBfW3AnsOW2DIxknQRYm5U0Z0NsXk+hEMiDnY7H5iOwgpwsOMckgmBkGHhAi3StwsZ0zyFZhFe/15mXH+D61UgBslejkjk4rV0f+dsI/9CMJg+Kk5gjBsWiEYe82UKS+w7v3t93eQRz0JiGZC39jdtAKmRMEuJTfm2+ViAq8vEcxHg22dDiAP/d2oSEXTv8YiKJS2lKACGv3l3WTjPYGSqzTlbD4mFT0/wOs42wbEmEJ9mp8ZM5hjWGZ1xnkYYi21OFGgaMHkSWnHedWUKNafwfmcgD6vEvFR075dxsVZJEy9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zR4b/V2kroFk3+TSN+7jQON52OoOMbUqvOR0CnzSTU=;
 b=j87E9Grr67dCtjsdyoR2jWA39dSNYN1Z0C2XEE6mX8lBt0c9rfTIBT5+wemDfzx2QXfjEpdUJRmanbFYZ7Os22LER14yYuwjTPCIpR+4tLS9YgIujb9ZHqCTSSgysmXYKB4vrtjBio87NmQhl2hIdZVc6PNqegaMaA9KP4ss2/Y=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 16:28:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 16:28:30 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQgABLTACAAKRScIAACgyAgAAAHPCAABAFgIAABqQAgAAGyoCAAAMekA==
Date: Fri, 7 Feb 2025 16:28:30 +0000
Message-ID: <CY8PR12MB7435933A1D8983F4661D762285F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
 <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T15:54:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|LV2PR12MB5920:EE_
x-ms-office365-filtering-correlation-id: 84a8a259-b05c-4c02-bdba-08dd47947510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qqqhJ5Tu9PqtTV7jBRz7Wc7GSDGISVV366obzdAJbmUlsFKsg1KNEAjz/8OB?=
 =?us-ascii?Q?s2Zm3xg7FW8HsEYbGTM+6ZtR/vJ3VKemivXrwwq401tginan/vlHdVHJxG5t?=
 =?us-ascii?Q?LKBEifhHItC+E4/oS6hYOFj7nwtgvz8m87C5WGliR1nHFb+xRjrtQm9WUwUt?=
 =?us-ascii?Q?8+feW0tWO9TimBgQIxuLxWLLh2f/IWpp0YXPGXSzquPxxwPjM8quXSVjxlky?=
 =?us-ascii?Q?uuO6han5gzra/TO9OWnSG9KQcYuVvpG4ct4T5idOgItWfxcth3AfygPxspP3?=
 =?us-ascii?Q?AzzzLUQc0Y0SOLznV19sNoVVAAdsyrXDebtOkcOOSGdPDPPk9K+Wh0ppJi14?=
 =?us-ascii?Q?u5fmHtpHbPHtp47bdTMEgf974GxXl4DsfjLNlpDsYBohUocHBAMH39kAiHvR?=
 =?us-ascii?Q?Lsq6kWc0r56n6cT4SKPeJ7je2WjobfZdQ438u9lMY6dto6pSOQkktoGKobT/?=
 =?us-ascii?Q?x3Zprr+7Tv30msjHeiS+k9XevEYV1nuE6BjWuN72e52BPA1bG3aUFf8HrS5X?=
 =?us-ascii?Q?9SMPxjFntSH59eMlbHtBIDm4PWJ4g/Uw3VwmZJK2khpmRoxQfwO4BvyY4vyc?=
 =?us-ascii?Q?uibOwziRRTtvsCizkTyWR6SGuC9lkhbwtiid/AVfJAcL6nBaTTjucQ28Ggmz?=
 =?us-ascii?Q?x5v6apqlI8jv7Hbdwfn+3nHUTycpvNckfAzYGIhvZvxrEfXFHOlI7BfAHo6u?=
 =?us-ascii?Q?DPrZObZqBbAyw1QE65dT+XoWKeg7J/0zWogFr44cWHlBFkiVrz8jBpDEUcGw?=
 =?us-ascii?Q?jjFSGaFWQCHloy8tLt2ZCSzgNU7EKdlzsRoxj7qAJX1O1ojSKDB1dzX0qcES?=
 =?us-ascii?Q?PMPENlkan67UAVn1wMOTd7wy0YLCYC/kjxDN4VxS+JRE5nx3YHlBQ9PczVPR?=
 =?us-ascii?Q?vdiOgfrZ3GrCvkwDbVBeakfMlFfbH3QFg8Kxzcm80p1Na2li7CKB5AYtC7Pd?=
 =?us-ascii?Q?Kj0hIAkqcXrPnghVh6SPam8fTnptBoBEJUzN5C/FjIXDbKyq30cwo6KAxiZO?=
 =?us-ascii?Q?4nTTiP5QQNohRKaCf/eC4zbtc7erO92wc3viUwJWxgnSf7DKDyneyy+VYpDj?=
 =?us-ascii?Q?BAeHMGE7/ttEJ5DlvoNOnghh3czC14MHdz7PMTcj0t7z+/gJieDTwQyxh5Jg?=
 =?us-ascii?Q?VT4bcs4KyulXSYp66VlwgDMuVEYjAS9mtvErLnpc9sfsngcYKopm59UFZ8OQ?=
 =?us-ascii?Q?ktGFfU5T3khptstQ089MR3sv4zKNab27tEFeBSQJl0JxmVBl1Lfdp4Dls/7+?=
 =?us-ascii?Q?w4N7ey4GLnBU0qdkVZvd4/jccWyRlTEg+3LrUJB3tHDH3onQFsI+jx5Ranzy?=
 =?us-ascii?Q?rLQGSZPlMMp5K4SPankFf0ap9PjScfsSW/KdixABPj5AY3MyrYR8HCtSYxPG?=
 =?us-ascii?Q?+Kfb2za1yfQEgkzs1/ZfEtWFc3ywEyLxxp4PjNH6Jp6t4UQEZQRASkbaM3QP?=
 =?us-ascii?Q?NvhZp76frXGAfnjWllNlVVdrY2rcD8tf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+MTC++8V1AYHk40Um+2p9a5FQ/RxWv1DTPitM+TUL0mypHuNjAgPHahWd+1G?=
 =?us-ascii?Q?ShLCQZfHc4FYr+XkpMNubWAk9rwclIw+K10MkJSvKFlvHfSZ7+ZRFW+9ayqp?=
 =?us-ascii?Q?Wx02bJQZQTNsESc6M6h59Ac6mQDyop4UH1/ql4OIM2xpzxmpHnMzi/dFnqwU?=
 =?us-ascii?Q?2tz2Yq/rjV8jVArEI/h5Ubf7ktd8kyBzePnE251C/hnlooM+LfV0kcAlGlsB?=
 =?us-ascii?Q?X12RezHZq2tMM9dMprwpfbRcFdNxT0D67+ra13/8soJcaKqz2AonDoKKxz8g?=
 =?us-ascii?Q?U4i/TVNrart3RE0+yFiG/8mzpBS2DL9NCt37rbNaOKhTPh3VSi7kVuxygNFT?=
 =?us-ascii?Q?/uhKJ6H8Frh10NDN7AtmrN7AQMcLXU/EnG/HEYZW70RBvxGvqC0U7Vh9JZGw?=
 =?us-ascii?Q?hvo+6JDrdm8cyYxN6zXfTAVp2ryCZdPdAMcNRxiJMg9SqFod/qKo/DipFSV8?=
 =?us-ascii?Q?DSxg6FIIVBxb/GLcuF3lL230wISVXeCYqRnDdusgpI1PD42KbbAl6DJqEDjG?=
 =?us-ascii?Q?57T8cuxOULnC3mtHUtjsb5xcMaKdKyDIk8XEeBN4tRAunLOCadPsmhcvu/jt?=
 =?us-ascii?Q?li1Y0uE9e7IM1akLNFQEicdRNnSkpkwPCEvqYFaHrEUw4+bbweetfaibucJL?=
 =?us-ascii?Q?sYmYWohK7dfWqzKw3KVaGYq/AGLj1n9I7IU6Fj43DJx6HIs41isKjZFKeZAO?=
 =?us-ascii?Q?/STyyG736bEA0Vo3n7ZFi1cBtVqOo60IjWCKnxncFIMmkA3m8wmhLrJgQqDS?=
 =?us-ascii?Q?pduCBD0ra5O3e66agHElqjmwbpGp1wym9EjFCcBAbCjZZX/wi20zwZMOFR7C?=
 =?us-ascii?Q?9b7csmhplGKpcGgoLaIE8tzlCJJoFS7gKTL3mJFWysXbGH7neuVVNS8fWKkO?=
 =?us-ascii?Q?QqHpT8Js34m17QWICP5D+HsN5ZnDKbiwLKLxFSbyoBlTUmczATYDOLqKXfjP?=
 =?us-ascii?Q?XAQxdnM90tnE1tIuE8eSOXsOB2tjVEqfy+kq65gqPTwc0duzGWpHlOYsAhT1?=
 =?us-ascii?Q?rA4aPeXeF/WdGB4qyHuIwbBHD2sZzDs68Uda/9yNYsufQiwfl2QuBfb+saGa?=
 =?us-ascii?Q?kvEaHjReOZFSVjCy8kwUk7aw14RRFGarlBV98ZG2i6R4RIeg+hUNHds3ZddV?=
 =?us-ascii?Q?JwnZpegUIeD5skV1iNHwTbllKVe1pQIbEbRDWd+evSVU7jVaTQTHQpapIOXm?=
 =?us-ascii?Q?fVsSYgQMvZgx6Y4vVmYnMu2IJMpP2OXUWtfmmOar/8sqrZ35L9BMGZjmrFvN?=
 =?us-ascii?Q?FtujI9mg5mMQwiQ0tBqjpPh/xh+R2k+KhnIKo15zXUqUlqnkMwnsSxlGyMbs?=
 =?us-ascii?Q?BSpS85fW6pdxIPs7aEw6eKTg9YYTKFg1dRH7xV4QdSwJlEtMqHqHw576XKGu?=
 =?us-ascii?Q?uhATkBUsrQQKvlptyju4LkUnkH3PmMCfl+ixEdtoOjA3dt7PQSvy+L4+MtyB?=
 =?us-ascii?Q?dweJZSBTKEpCAXNp8cnecVDd9VAw+CM2JZrumC+fXPzN4DKLVFtu0yXwqBU0?=
 =?us-ascii?Q?LtOjl2lt3tzJZ81n3cmUsduRGI4nGBS2Ivu+cBs4EhMVcgdfzYlK3nAu8XAt?=
 =?us-ascii?Q?LTPV2R6J8W6Ax1Pud/U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7435933A1D8983F4661D762285F12CY8PR12MB7435namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8a259-b05c-4c02-bdba-08dd47947510
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 16:28:30.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 940zhSviGEXUKMtaebavPU6q9cUE+bJrn3/xS2b4G5QBUQysKl+T+jCwSZAH9sXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

--_000_CY8PR12MB7435933A1D8983F4661D762285F12CY8PR12MB7435namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Well ... I don't know what other feedback I can give here then.
We're bouncing back and forth talking about language/function/logical struc=
ture or whatever.
I'm of the opinion that there are too many unnecessary wrappers here and am=
 biased to unbroken steps that make it easier to debug/dev later on (at lea=
st for me).
Maybe someone else has a different opinion.

Jon

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 7, 2025 11:06 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery


[Public]

It so happens that driver gets part of the XGMI information through registe=
rs in GMC. The intent of those registers is to help GMC to figure out memor=
y access when device part of XGMI hive. Driver using those regs doesn't mea=
n XGMI is like a sub ip of GMC, it remains separate.

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Sent: Friday, February 7, 2025 9:26:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> Sent: Friday, February 7, 2025 10:18 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discover=
y
>
>
>
> On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Friday, February 7, 2025 9:20 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>;=
 amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com=
>>
> >> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>
> >>
> >>
> >> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
> >>> [Public]
> >>>
> >>>> -----Original Message-----
> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>> Sent: Thursday, February 6, 2025 10:56 PM
> >>>> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>=
>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>>
> >>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery
> >>>>
> >>>>
> >>>>
> >>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
> >>>>> [Public]
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Sent: Thursday, February 6, 2025 8:13 AM
> >>>>>> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop=
.org>; Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>; Kim, Jonathan
> >>>>>> <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
> >>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>>>>>
> >>>>>> Initialize xgmi related static information during discovery.
> >>>>>>
> >>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@am=
d.com>>
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

--_000_CY8PR12MB7435933A1D8983F4661D762285F12CY8PR12MB7435namp_
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
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Malgun Gothic";}
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
ial&quot;,sans-serif">Well &#8230; I don&#8217;t know what other feedback I=
 can give here then.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">We&#8217;re bouncing back and forth talking about lan=
guage/function/logical structure or whatever.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I&#8217;m of the opinion that there are too many unne=
cessary wrappers here and am biased to unbroken steps that make it easier t=
o debug/dev later on (at least for me).
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Maybe someone else has a different opinion.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Jon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 11:06 AM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">It so happens that driver gets part of the XGMI info=
rmation through registers in GMC. The intent of those registers is to help =
GMC to figure&nbsp;out memory access when device part of XGMI hive. Driver =
using those regs doesn't mean XGMI is like
 a sub ip of GMC, it remains separate.<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kim, J=
onathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan.Kim@amd.com</a=
>&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:26:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;<br>
&gt; Sent: Friday, February 7, 2025 10:18 AM<br>
&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan=
.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawkin=
g.Zhang@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/7/2025 8:06 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Friday, February 7, 2025 9:20 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com"=
>Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.co=
m">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info dur=
ing discovery<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/7/2025 7:29 PM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@am=
d.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 10:56 PM<br>
&gt; &gt;&gt;&gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@=
amd.com">Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhan=
g@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi =
info during discovery<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 2/7/2025 5:03 AM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 8:13 AM<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org">amd-gfx@lists.freedesktop.org</a>; Lazar, Lijo &lt;<a href=3D"mailt=
o:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawk=
ing.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Kim, Jonathan<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">J=
onathan.Kim@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH 3/4] drm/amdgpu: Initialize x=
gmi info during discovery<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Initialize xgmi related static information du=
ring discovery.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Lijo Lazar &lt;<a href=3D"mail=
to:lijo.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<br>
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
&gt; &gt;</span><span style=3D"font-family:&quot;Times New Roman&quot;,seri=
f"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB7435933A1D8983F4661D762285F12CY8PR12MB7435namp_--
