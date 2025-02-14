Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89525C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 12:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F40810E288;
	Fri, 14 Feb 2025 12:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ly5VkVJd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF4010E057
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 12:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPqY+Oqc2+roiJ8S9C3d8EeNlMpTTT6myBpE+BBCX/CBuwV6IHjpeqBwkaRf5aMiyK7b/lprUHq3NvAVPLuL9j849AM9PDWdCzGgtJrogdjn2IK2v+NKblntCe08sIudkFB7PlfUFj8XlwoOnOpMZESwWRrwLf6ETFuB2gb1dhiMqScR6nYR5ZpshgeVF8ROQj+NU2+tPfibvMMRebM35Uq+toACmbTBv5K/GhbE/fF0spFC7jkBwSyhAGmZcHOgY+qcks3/7o5M6v+ZvLw3YjupRWQSLFf4wtkT3AuxutWvvsOq6X1NtRQ4fgOdzZ8Tf4mbnQbIviL2pw+I2UiisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFpRx6Mu8JmqWk4S/1+GsoEckWtlj6dgdIpV7MXp7js=;
 b=hnWxPDnUVVhvr/vCynUGzWyZyCPeTcGozijcDiqkMt6/xy/spV42UmNoE8cyL8UsGtUIi0EmqVtnVqYzuLbcdVjihNdoWf87JFTCy7u7zsreRkVowLX61EfqL+nIaclS8I3r9WetPm78iHWcmvKbNIHhbqfwO2vRYwcLdakDloc4Ayh8y2BjyYoULo3BPoqBAEiBoFd3B7igRU25Vtx2OJe/kORv+pxEve7pMIBmpQAy4UU6AwBOUZH7g0a5uFINGFeXDkBr01WSNvPHHYDpgvrmuZZDZRfHb5OcTDgEFPBDyUatp2vVbw9MK3FnhBMoizRemo5Ms3RGOvX/jWRscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFpRx6Mu8JmqWk4S/1+GsoEckWtlj6dgdIpV7MXp7js=;
 b=Ly5VkVJd/kElAAp1+PMFPAnMSHXYlZd6HncPE4o2/11PvIqLr7o39VY8y45RMpplKJWeTBRr37s4Gn4ad0tcONAqEMUePAVk8Ju8M5rfxSiT01FzrSiI6qr2QaKhnzY7kPqtYqqAMf23ELzQuadrZK9IUXqgr3LmjHbRLBAU+KE=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 12:14:23 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%5]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 12:14:23 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
Thread-Topic: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
Thread-Index: AQHbfshJItCUqvFEfkKcWRtn/KSiDbNGm3gAgAAR+ICAAAJVoA==
Date: Fri, 14 Feb 2025 12:14:23 +0000
Message-ID: <PH0PR12MB5420391BB3877E5DF10F1451E0FE2@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20250214100718.2663073-1-le.ma@amd.com>
 <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
 <13d5afc4-4f97-8fe7-0c05-647bfb768abc@amd.com>
In-Reply-To: <13d5afc4-4f97-8fe7-0c05-647bfb768abc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c5d7d7ad-5da8-4fbe-af7b-92857ef5e426;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T11:50:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|PH7PR12MB7331:EE_
x-ms-office365-filtering-correlation-id: da862725-489e-4bba-79d6-08dd4cf11e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rkdy/y2xvn8l4tsXstAmatomiq/YG2JZqkG0ENG8CVrv6vp7WrxayRswey?=
 =?iso-8859-1?Q?y2XKA2xKpDK/JBvZ+dHeuFIAwV7ZDtO1WOywiWGNpvZDqqAZwL+lKl6bda?=
 =?iso-8859-1?Q?/Aip+HJH3Dug812UFiN387a1Zf4xCUM+lY8vru3f3T0j8z4g7Bqfusy/rL?=
 =?iso-8859-1?Q?H+pACigQEBtJh+sJ7biY2u2lxnBUDiurrZi4GH7uP8rR7SbsOQLvGR8YaW?=
 =?iso-8859-1?Q?e7lxkU5vt0TRn7Z9owI6g3g4Fny52WA+UxZoi+CxdLnI68fNt15S4kZUtM?=
 =?iso-8859-1?Q?vaJxEbtzS4mXOykEH0HkojvlBQ6LYC7KbqaGVN4dC03NLA0EzngYzk7Ez+?=
 =?iso-8859-1?Q?KsjQ8M9KLb3u6MpzQAS+wm5hqXFYflTWe6tZ3/Fn1osQc7XFWU7kekacmT?=
 =?iso-8859-1?Q?HDmYTx2NOB8khzuVqYK9RSfha8ixHbVkxvj5TdGag22bxAW5ryNlcX5g7C?=
 =?iso-8859-1?Q?Fd1humE5dB/0wfLAPVLJXr6hfHRbYo+SNe6LY1hmBs1CC3hehgrU02vHRO?=
 =?iso-8859-1?Q?17obtMiROa09Dg3d3aJjH0ykpAr0mDZruVkyZ60CQFQuOfJENfvFeBpwwG?=
 =?iso-8859-1?Q?iqurKDKZZGsoU7Y/LRyOe2uqNYuDg9uZBWZI4uelP8KYujEfFCaj3JGbzj?=
 =?iso-8859-1?Q?W7sBYYfYXqV4ymsXvPFp1+FHWM3qTuELrqOfFuHlvOmxhF7q06YtFyST8E?=
 =?iso-8859-1?Q?AnmU1ZJBA9R61mzSdZdH2yvegNh4movYboK9Z4I2KwUvvrNLdvv0aNZX9C?=
 =?iso-8859-1?Q?MTE9BcmTGfIgiDOuOUZZSCTm9YLi0yi7+80XQf4mYwEwUTKQQGuTMpUAz8?=
 =?iso-8859-1?Q?Ao+M/vWKpd/q0OpT26eQ2MFHOIr6mmy0T/M7z9KDP40l8LG9OeSdH8iwTw?=
 =?iso-8859-1?Q?5soM5jgAI80cuJc3gTiIeHydkNczerUvbYAAHdaAFXIHEpdm9HyedJKejX?=
 =?iso-8859-1?Q?EIpyRTUzZC//svjV3AxlRZIHZo9LaKRWpySkWCa8tzSXgLOb6drKyjRNog?=
 =?iso-8859-1?Q?0CtrcKkUO2N7E8Xa+Kuiu41nS9u5QsOcJzJzlU0YQR8oOqRRgd4noMXqlg?=
 =?iso-8859-1?Q?BB7FJX+AwRCmoZIDOoQ+Jfv5h0icLPEIvYiM3asB+ymlsLOP1uHjBSbNrv?=
 =?iso-8859-1?Q?VAGxMAK5+UDFdby3+XEC32+zmjSfubnjD/gI9kJ4FW0d5UXPUnU5OVPW6Z?=
 =?iso-8859-1?Q?nImEjlz+6o7iv1q2YRRVwSUevsCWJKmTcpw4msBHYPoAhhEuEzo/KJQVrL?=
 =?iso-8859-1?Q?UYyKTHCHsh5EplsRgUIwwWUiVTGyjXOUq6orlTRhK2AaD4jyPn5v6flsaw?=
 =?iso-8859-1?Q?nvbj0Tf2R+zmL4RIDLtSUAE5V5dEseg+zX7C+9xrTYMUIWBKbD+gRbkfQV?=
 =?iso-8859-1?Q?uJWWEuTrD8A4Xdmoiv9LUUGFSGMwdwxMvKX22/lGvzTjCx7xJgrba0Ft9i?=
 =?iso-8859-1?Q?VWpBPqbV7umsNLHpyHQUvWDQWOW6YPAtlbOsNS1qf+A74RDe888es050SZ?=
 =?iso-8859-1?Q?k+I63EhIwJH/X1KE5ZLS7v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5wSciWwFdgnXFjoO/L/93CojDS2i03tQN1COjjhDW/Ik5N5kFBNxgH4OQe?=
 =?iso-8859-1?Q?Bj/T6cgCaGQwI3zm6RgJKQk+OrfnNHjhc1oY9uqzApsMbAMb7/TePYRK5A?=
 =?iso-8859-1?Q?pEE6e5/cLc5aQ4l2/A1IsZ046EZOpWpLTjortCZRE/iL45b6Y4IHE2XREq?=
 =?iso-8859-1?Q?vL++8sRvIAebQT8kRsn51FyFdY5SnXTdsPTgYePar6X06bVPXLiUh0ZwSS?=
 =?iso-8859-1?Q?SD8laaPC05FDt6Rm05GYFtYE/UmmgLx6+BP7RHU8XS2yFkZDFtxkKjmOdX?=
 =?iso-8859-1?Q?EewASEnY77DcVzWxeaFZKAUUGKgw0i5KmmiMNgIw595/3rEuuQQp9cmBoM?=
 =?iso-8859-1?Q?dw7sxoFHVfy40mVrUC7KDPkAWAul55dvbHXwYkJspkErrDWqBEN0zIvXPJ?=
 =?iso-8859-1?Q?k/T9nlj1dRHYtKfiMJMDnnAQlwaKw9PgFVNaPIFWPsTmHHYnZ6r/WuDw01?=
 =?iso-8859-1?Q?qS6GxImGZFpMmsOezqKmzTifxZK0s4s2MTaamENL8YBEczTT21BmGNtHrk?=
 =?iso-8859-1?Q?u2bB9SIYpFdj1unM8lGWRwr1odY8uGix6804bJl6z5J+OM+Wxm4KiUp+E/?=
 =?iso-8859-1?Q?0ue3HD8Sz5YTd43fsWD+09G0QIwWPfuEjPryREVG+xOlwHErgkDgyBKJSV?=
 =?iso-8859-1?Q?qO834GqTnhJKFFHDyt5DZ4ahodVGrmxVk7mz/wi4Ksd0ELzT1ZdVO+8N5s?=
 =?iso-8859-1?Q?GgNnyqo6cY73pqMFmoEZSG/2LRbnyXzvHzwQKAIssaC6Tts/11fQZLKbAy?=
 =?iso-8859-1?Q?qE1NeQE6uQJcz0LSn1O2SR9JnxuBP3G+Phm/jEduxKMBluyutfQ3kWWiuE?=
 =?iso-8859-1?Q?wQ2lFuiAz1ZAIeuYjIHq223v/chBzKy6OlKvWTiLtIkirIAGm3wctYO7c+?=
 =?iso-8859-1?Q?5MGDcSXt0xi+1QxtCWSfNGpBj+YgDdmGh3LlWG2CBXzav0Oz2+7AoftpkB?=
 =?iso-8859-1?Q?VlfiMlQYuLyNSGwhWW2PMR5rI6OjvWDo5gf8pTAcPPcyT7EhqjY9tG1kPV?=
 =?iso-8859-1?Q?Yf1BUsMNiinSPq5j5N0qgPv1ubVlB0RcW0aDb8S+JmMaLyW12YX987c5dN?=
 =?iso-8859-1?Q?KUDlkRzEG/1intgNdv+GruSQ9HF2FO5hOaMoabobuDIzk+joyCJqyt3e0r?=
 =?iso-8859-1?Q?NR2nPjHdcG1A82eFM2l4sYdLQNAnJG32r1IZ5MihocoxImtRqmju7IpinA?=
 =?iso-8859-1?Q?D0Zf/QFxOJQtPO81+RExPsJjP8sUHTQ2OIozk4E2hwT/MTd87Mvynk2E9Y?=
 =?iso-8859-1?Q?IW4Gm+4w4EVCcSHjlX/7Rqfh8ouoYgsDGWZvIjSU0fN/iNF4387F0ZDXtM?=
 =?iso-8859-1?Q?WlPABP441l3nXnakJ8JiHfIFniLXkgazopdXOoZuQ6BqUfp/zR2eCbdhu8?=
 =?iso-8859-1?Q?JhilFTcXHDP57BT1+D2XEZUe7XAeD209buBoGUi5TUVjo7wrON/LHOHIYG?=
 =?iso-8859-1?Q?/4WwOc8ti4tO9XpWL77UTauazqmrQl4S84vd4J9U+a25Gt4xpcNTG84Ti5?=
 =?iso-8859-1?Q?2mx0SuoKSTwoTRdl7Q6ST9BUZSSRLsFw3g43L+yGs+wBavq+mBLb7KEygq?=
 =?iso-8859-1?Q?zHQ7E539BM9IU48r5gMrw73XAIJcvi83+bvAIA03lRkXVJCxBP5kZPy856?=
 =?iso-8859-1?Q?UAXKToYk2LgLY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da862725-489e-4bba-79d6-08dd4cf11e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 12:14:23.1327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydpPWYp7A4qeUUhS+x+aK0ed2fMjrGMGRkfBksugnOdnMOX3uCMM4obXUhYaoKTL56gpuWSLo69CkPlUB7XBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

Better to put the fence outside amdgpu_gem_va_update_vm. Since it is passed=
 to the caller, and the caller must keep one reference at least until this =
fence is no longer needed.

Thanks
River

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yadav, A=
rvind
Sent: Friday, February 14, 2025 7:42 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Ma, Le <Le.Ma@amd.com>; a=
md-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>
Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not rel=
eased


On 2/14/2025 4:08 PM, Christian K=F6nig wrote:
> Adding Arvind, please make sure to keep him in the loop.
>
> Am 14.02.25 um 11:07 schrieb Le Ma:
>> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
>> will show up explicitly during driver unloading if created bo without
>> drm_timeline object before.
>>
>>      BUG drm_sched_fence (Tainted: G           OE     ): Objects remaini=
ng in drm_sched_fence on __kmem_cache_shutdown()
>>      -------------------------------------------------------------------=
----------
>>      Call Trace:
>>      <TASK>
>>      dump_stack_lvl+0x4c/0x70
>>      dump_stack+0x14/0x20
>>      slab_err+0xb0/0xf0
>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>      ? flush_work+0x12/0x20
>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>      __kmem_cache_shutdown+0x163/0x2e0
>>      kmem_cache_destroy+0x61/0x170
>>      drm_sched_fence_slab_fini+0x19/0x900
>>
>> Thus call dma_fence_put properly to avoid the memleak.
>>
>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>>
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 8b67aae6c2fe..00f1f34705c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -759,7 +759,8 @@ static struct dma_fence *
>>   amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>                      struct amdgpu_vm *vm,
>>                      struct amdgpu_bo_va *bo_va,
>> -                    uint32_t operation)
>> +                    uint32_t operation,
>> +                    uint32_t syncobj_handle)
>>   {
>>      struct dma_fence *fence =3D dma_fence_get_stub();
>>      int r;
>> @@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>      if (r)
>>              goto error;
>>
>> +    if (!syncobj_handle)
>> +            dma_fence_put(fence);
>> +
> Having that check inside amdgpu_gem_update_bo_mapping() was actually corr=
ect. Here it doesn't make much sense.

Agreed,

Regards,
~Arvind

>
>>      if (operation =3D=3D AMDGPU_VA_OP_MAP ||
>>          operation =3D=3D AMDGPU_VA_OP_REPLACE) {
>>              r =3D amdgpu_vm_bo_update(adev, bo_va, false); @@ -965,7 +9=
69,8 @@
>> int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                                                  &timeline_chain);
> Right before this here is a call to amdgpu_gem_update_timeline_node() whi=
ch is incorrectly placed.
>
> That needs to come much earlier, above the switch (args->operation)....
>
> Regards,
> Christian.
>
>>
>>              fence =3D amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>> -                                            args->operation);
>> +                                            args->operation,
>> +                                            args->vm_timeline_syncobj_o=
ut);
>>
>>              if (!r)
>>                      amdgpu_gem_update_bo_mapping(filp, bo_va,
