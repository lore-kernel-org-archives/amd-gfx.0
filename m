Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2FDC88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 22:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADD010E0A3;
	Tue, 15 Sep 2026 22:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0ksythP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE32C10E0A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 22:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7yqeJcoHwy0jcjWhWrCoyQmN9vb1hO8uT+a2tauVMX3tu/BZ4LViYrWIN8SCKUy76AMAn+JZQ6a00E7jc2GYrMS9osLoKR9dws1gvq2ot0lHHwabSo7dA3cYD1ioGuRVUSxC0NxXVUp8ezHtnHSIoR5QC2PVtGuGUShaZH1k/NB+2Md+3eDzD+O9ZuIpUOKZ9z2VkAYXFqome1V1s5LtYR10OnyGcI3yjoMuCJoV6DQ11FkchScNIXLDsfbnO+QXi2wfYinaK+hvx4zJHVUtERIoaerTDql8AjAcud4KEjG++x7uYFZ8ICHjJPoq/M3emY6SWpiGjnFbuLV9eRSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2FodNRXXb2xw7WHNld7BIT1sDhlQyGzoP8FiftpQyc=;
 b=F7xWoGWyerK9+khw4sl8idYvVnKPPvqd0/60U9FFxzjJE1YrozOiSisC+AjHz9XMkvZqjQoaNKYRFuOfmCCfGdHW1Y4uJdMdjOvLIfJ6CtOfJwOHTi049htSeJfInySknly94uFhVcLAHq8drPDHNLTUHL9wZziJxevrEokGZzugYVdeU9GrlpR/ka8jGLggKIsDRSnQqdyb3sFhf2VTOnOrsH8bmAAAjoKllo9V0kIfV3dnLHfPZka+f66akVal4YLSFTaAqmPJ57Wpd7dXovtRmXlWcOMCETHGXx1iQndXeGnjVfkn+pRa2Tkn1XekDGujxvNzzxeuSOFXarBf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2FodNRXXb2xw7WHNld7BIT1sDhlQyGzoP8FiftpQyc=;
 b=e0ksythPyuQxd16sC/4iHtXYvg3KJ0tCmvBoij3Kg7Of+sf65O9j9p52MIRixRxfor0fkWTuAIVQNN2S3RhpDiYY7+xTP/nnA8LEsJfeXOEL3loSrVxBjc9c6nO7As+dz0PKjuxY7Almx9HaI8zdeaJSe6zATT0YzAWTthvRKjY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by LV2PR12MB290147.namprd12.prod.outlook.com (2603:10b6:408:3a8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 22:18:40 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 22:18:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
Thread-Topic: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
Thread-Index: AQHdREnxDQmTuAT07kC77BpleWAtybbO4dCAgAFVvpA=
Date: Tue, 15 Sep 2026 22:18:39 +0000
Message-ID: <BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
 <CH2PR12MB945710EE0E52DC2498C528C28CBA2@CH2PR12MB9457.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB945710EE0E52DC2498C528C28CBA2@CH2PR12MB9457.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T01:54:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|LV2PR12MB290147:EE_
x-ms-office365-filtering-correlation-id: 081b72df-c864-4cf6-4d8e-08df13774b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: iaEi8gXa9iY+kuf/9I8oBrsf8ziWaGfDr70JgLSm3jXGlsbVCGgUG3NGm9y3yQ6gkGL1VlY22Ivmb7snAtmnLgOfUG35j7GKbDczusIXTYFuwDZ3jQh3VkdA1+lNm4VYFz4zbnXA2WJFUd4wVDeuRVE4lWtu0iiSvnWJ1NlPxreKIpLikB67Qu1PZ0iFeGNb1wcC0PLXy2cSeBRd38GCy0R4wCv9Lh9jtlP/MBWnA5Urg/QTG2r2ar095+n/3iudfR/4nyRJrOzObEL0fk/U7yiRp4UX+aqOAQ0YUN1TZlHcFHXEQ15gjWFX07oGWWeUNmf7wT21oMfs1mqjOIFrRsAl1wvSkuIBWprGRpb8P01GXA5A3T1YeAPpRXbbGIweGD23kB6Zp+kcIEPqjNTvTdL5it1AfPLhq71jwPZYVfCrAlGbbU/zQuHwC/KP/nsq/tPU7fDxVrNeQXOzAIP1BdMeOFcksW/NL3f/Q3WzuKt3R85ZDTC/ZzBRn219a+vdFm6W/gMj90qTe6O8pdx6Q2IkJxG/kwihVX2G1CmrY8f5NJcRB0zEM4zryEch3rXk5sq4C9mAIiZyV2C1nYYGJQoFQdsDTXheX4ugJvtA140ezRocCN8ipLJ/SjlMAkXDRkaSw0ya8ejtJiPIW6HRbgGmFkVuwsYUMuWp+BBWFMs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJw6QTcBnAdKBj5mLhlq9ye02AD2IasctnTG+1D1C/6Tayohn4oLq0IebOvb?=
 =?us-ascii?Q?dv0fAV35CuO8jSXKk3Q2VzD8oGcoZ9vfH/fF052kSVOHNnJ8expvvWtww0aQ?=
 =?us-ascii?Q?eXNeCgEH3RoUFlCrccdMVQ7YCx9mrvhqlasGc2xG/M1+SSFLJsGZ0nq2JCIU?=
 =?us-ascii?Q?RTN/kJiNQVXZKKQ6smMxDVQ2rFQj2bwkXga73WMo3dAYJmGSytVTaE3yhSsc?=
 =?us-ascii?Q?fsF8cIaUxdDl4DA75fnpaePSvTURUPF35h9VmRp8v+0xXNs/pcF9sxy7gLOe?=
 =?us-ascii?Q?h977CVhJNz5PoN2nvw/kVEvb9eyjGl2IeM96GGat3jEDIiT26gzZ+VtCKJOb?=
 =?us-ascii?Q?oKH1miJrDefzZZgVMuyBByCeNlAkPPDgLeXnANn2vmaMrY56uVOS4eKEWH/B?=
 =?us-ascii?Q?V/k6Rwh3UOdxHOgKWbJ0vH0A3OinBFe/IOBHIHTOqov8isRKSWY9wfeLvjZH?=
 =?us-ascii?Q?88SFPn5Y2cC04Pp1+BSj8gQtz8CGJnKZ3slFoxRJoklovwekseZuZcHzClFa?=
 =?us-ascii?Q?TJ7CPg0ek+MKh20TjKjYF+q0DRKytALR/GjuiSrQNJqMaJjM2dVubZUqyC++?=
 =?us-ascii?Q?TDKG2FRQGFJyXxeKD3iSqkgrZwJ6QY90zap0/JrMeDYySL3V2h2gex+0bdVT?=
 =?us-ascii?Q?IuMHblJzgv34jNwf1ggsNrZfGDVQJlsT7hZExMxamZ5/MpGIaY8tLC8cT3B2?=
 =?us-ascii?Q?e6dN1UgatG8awk7n9MUJ7p7ugpK+OkuZFFCCJkceWx2LlbW1Vl76eGwuWI5a?=
 =?us-ascii?Q?qPtNtpwQYC4m3EX+W+IS5ci47UR3PnroUbRR5ZY76bB67TWdrWeL6l+u2P8p?=
 =?us-ascii?Q?s7xj49Cj++8Xdx2QzRv5iS3slJe/ym9njy353tRKVhyu9a1JRqtIn/5iScsV?=
 =?us-ascii?Q?3vPWb7vDDiLP6wWK0lFYaYSVXmO9DDUz0SP03DlyvkUtwHWQQ0yRz8JMhKP2?=
 =?us-ascii?Q?TK9RahFEyMSsxn9a92osccl6fW/yVrl34oystkr7/vBmwArxpkK8M/WphgIw?=
 =?us-ascii?Q?QdLMQQn87eIH/D/vG4qk8oAK49GxG9hJcmOUDDOk6lTQfYJP3A9vmznnfzWa?=
 =?us-ascii?Q?aOikaUXthy3lQvFfpVCjpjyy5s7puePA95HFcmhImrUzNXSVve1kWuSUGmXR?=
 =?us-ascii?Q?WSf5/Nf86jvbh/tYUUdOrbTl/6lwmerAm5KNGwiYz6arxYX64re4JjmjjZzw?=
 =?us-ascii?Q?hxg7F+/MRjzaGaO4WTcSxTINITzno/rCAj0Bb62uomm7J78JF+aolR4YV+90?=
 =?us-ascii?Q?byeH51P4VOPOvnnNa4ikppdJggm01+PKtQKjVnDSlFGefOAyJdG+gSQWyDUL?=
 =?us-ascii?Q?Q3V/TUPUN2L9Tf/kHh/lsOx/77AsCWpc+4tSpkp5VPV/PZvo6IpjphMGo5O2?=
 =?us-ascii?Q?TZ01+J4b1nlvG3Jkk8Z10i6Gb1TtjM2NC2+D3aWIG/vJRkhzPIWJKqgk39Yu?=
 =?us-ascii?Q?MHiytNi8r+oozMTgsn/2so1EH+O5WoJ7tEQhsQV5SwJnH7wW7xs7WdvAVrSB?=
 =?us-ascii?Q?vcFihgCqGVdI+U/rWYwxcKXSmZFD+ZJnRJEmtKhqzQVN1B97ZZ8isLP+hAZ0?=
 =?us-ascii?Q?cTy1IMCzsnV8Mjv7oc1F8tn3AJ/MdF/AhOLhK0ghFkiUU8Z7Vv7owMz4QFYm?=
 =?us-ascii?Q?eEi4XvlpBmP+Tjs8UAZ2yO16kOb4FIH+KFDSjte9K0efV7Vqmyp9l+wqjDJh?=
 =?us-ascii?Q?2wnskTXJPnUPa40VoHjAZ3jDHNrUCyj5Lqfcjsrtefe05nR2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081b72df-c864-4cf6-4d8e-08df13774b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 22:18:39.6104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiZm9AspwutqybSD2l/jPar63cfu18kfjQjP4DkF2gAEWUlimbjFqGERqHT0rReP6E+RUltmYbbJ+Yv5bnbS9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB290147
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

AMD General

> -----Original Message-----
> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
> Sent: Monday, September 14, 2026 9:55 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by i=
ts
> kref
>
> AMD General
>
> Gentle Ping Alex

It doesn't look like Christian's concerns were addressed.

Alex

>
> -----Original Message-----
> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
> Sent: Monday, September 14, 2026 9:07 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu,
> Lingshan <Lingshan.Zhu@amd.com>
> Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
> kref
>
> A struct kref is embedded in user queue, which manages the lifecycle of a=
 user
> queue. However, several code paths access user queues without hoding the
> kref of a user queue, especially from the doorbell XArray.
>
> These accesses can race with the queue destruction process and result in =
use-
> after-free bugs.
>
> To fix this issue, this commit:
> 1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks
> up a user queue with locking and hold its kref during access.
>
> 2) Implement asynchronous userq destruction routine, because the last put=
 of
> a queue kref may be placed in a code path where can not sleep or conflict
> locking with the destruction process.
>
> 3) Hold kref during access the user queues
>
> 4) Keep the userq manager alive as long as its queues, to avoid UAF issue=
s.
>
> This seires passed amd_basic tests in igt tests
>
> Link to previus discussions: https://lists.freedesktop.org/archives/amd-
> gfx/2026-August/151692.html
>
> Please help review
>
> Thanks
> Lingshan
>
> Zhu Lingshan (10):
>   drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
>   drm/amdgpu: keep the userq manager alive as long as its queues
>   drm/amdgpu/gfx11: hold userq refs in private fault worker
>   drm/amdgpu/gfx12: hold userq refs in private fault worker
>   drm/amdgpu: implement asynchronous userq destruction routine
>   drm/amdgpu: hold userq kref in MES reset
>   drm/amdgpu: hold userq kref during isolation scheduling
>   drm/amdgpu: hold userq kref during suspend and resume
>   drm/amdgpu: free userq by kref_put when fails to create
>   drm/amdgpu: take queue kref in userq_create to avoid UAF
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214
> +++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> |  18 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
>  5 files changed, 246 insertions(+), 46 deletions(-)
>
> --
> 2.53.0
>

