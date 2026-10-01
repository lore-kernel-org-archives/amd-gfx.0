Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079ABCA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E2B10E357;
	Thu,  1 Oct 2026 14:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsBEjasi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FF010E357
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ5F+g3swoAV9vdbI7Y3P0eepDfP5SnrBe8lbrwFbOCz5IUkSCq6sf5fZnJBva3SR/2oj4QslMl5+uHS7A52MWMYt38JqaYO6M7tt2RXG79PapYmQC1E1G+W4WxIEVUW3Zac/Y/Tqzmt+xMTTua76MIz8hBbSpcn6tga+IA77wGgaQbfXIXgAxNRs7XOc7PWSIY/T9gv7KdXAzho2dNW8LwKDDMglW/ZQVlsFedIO7XHysaT9qtMrfV2wm+RotuBblWj3qcTTPpRYyfOEv8am9gkAFqE6qNQ2IdmR/sbUgGwn2keEvz7TTnAT6YV4aSjrB8yhAmQA6D6hKqiLNBmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rAuaeqr9IkwKNOSGtuZzi390ftYOXVxWafOFX2X8zc=;
 b=LL5o8uMPXuUvTRuPpTvZx8+WH6n2CQIUUZcxdjbBKImOhq3gPqNVhYfNRYQont0IIXRsW0qVJ+37/2S25BrUUmCqDQdH32wMync+gDkmNCspKKCV9D1U9V26O51B4dxY6zmKgzdHouePtZVh9jDU3VuP1KQA0FDtavq9tdMJxgTT8D8FmXjjT3yWBmxyGKV5gfjfPAiNYZGYuK8Pfc07Qq95PiqpFe4GWJZXOoIQhLR0mxN9hIt6FkTNmfV83m2IkTIhA7qmPAIKe44zOnuIJ5ympwkblRWcMeAdo94AxxtpIYCjMieAy14Z/AQNyHTkvXorpHH702PiR3hevmuVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rAuaeqr9IkwKNOSGtuZzi390ftYOXVxWafOFX2X8zc=;
 b=fsBEjasinjqj6MIqPCKX8e6klvEdTC/fcEiSE9mZwb805OdK9qY9dYqcURIAvnE0U6m1GuTAk3hfIjigisCKeydK+2CKEFkYhIPe2wL8+lrCeM50lPySVNA+4ZXaD0IwYRrduNK1vmZ5RsSMhm3ulecrpceZpEvEzTk86x3qP5k=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:25:25 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41%4]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 14:25:24 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Topic: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Index: AQHdUPNWg+4EkRVVm0ePmOMosMLPZ7boNa8AgACCyoCAAAaZAw==
Date: Thu, 1 Oct 2026 14:25:24 +0000
Message-ID: <DS0PR12MB79937883FC1952B821439A27F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
 <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
 <48abb339-31a7-4083-8775-722fa010f34b@amd.com>
In-Reply-To: <48abb339-31a7-4083-8775-722fa010f34b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T14:25:24.312Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|IA1PR12MB6113:EE_
x-ms-office365-filtering-correlation-id: ae66a9f5-135c-44ae-d840-08df1fc7d557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|18002099003|22082099003|6133799003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: l6Jp/6dwuGoM1P2Ue47lLxdE9Ib0bcMJZdlb06WBmOyUW331yZt/mMIrF90kso9z7sTHjcwwpIg/HVy23EUcVOKeHKYBfKgFandhJQCPcYgxWcEVo7vGiJFmbuwi/pj6gHOE7my7BgdxC63VEyIELHnQq/178NBTrMqZEjkrZc2V2rdK+QY10l9WUmtjW97Re0FJF1mfFLGoN/ZK3X0OoQRNxzW2muyTrWFiGf+optcZnP3PCM0PoK8//FSVvEtbRvEdWL5Ic+Yle3xrPj3GWeCQT9y16niyTG3eQuUTHlAFfffP5mrFbw5Ilf9kBv1UtA9tBPE+ZIaC2se2qly2pVrDf3U8gmOoJw9apIJyX26eT+IE8qC1HXccQ6ANPZii7tQ6WxNRM9aHnVEwWDBYPxNsiq6J2ZY03Bt3BIsLqoVj+0hkjjOJ+2QrA5zBI9nOWkCqjg+mQnOFWWILnq65FbbZT0WTz9JZ4GBPZU3B6sUwcMcFNx7GKHEroO7OBjA6ve5VYPZgGHwZnesTVaAXnt0u2fbqDGGCxSK2GTGRDZVB8jJ7W67w8Gnplbih33h+OhlzPuGrZM6zrzRSDQ2JJtBifn3oZb+4WZ1dtwdecEuzBznYgYmtr7/bNgIX2UYIYoQifQbcx9tLjJ0bz/o5hysFoeH3YYG/YPrlnkNvz9pBOvpE+r9qG78oNkEX3lmUCvKBT19ZWRlYwthjHyVmroPGLkRD7tUP2zg7To7aV9I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(18002099003)(22082099003)(6133799003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oTMayupljx404rHP1gL0XYEoD7e0KfRtd6zHMzUsoLvG0XZNsg59bgfjEF?=
 =?iso-8859-1?Q?RiVwp77tEN3qCPgl0CM08xfE+JQOf9x4QFUaQJdQvfvdsOPQ51E5NFPgMb?=
 =?iso-8859-1?Q?Q5I5tc+B2IaMSRmbSjZw95Rs06i8cseXwzu6eeFm4sTcLy5emUt0Xho5v+?=
 =?iso-8859-1?Q?de2p9gzes40kkbTpIT/+jTGqcjUIht+t9m37FJDu4XaGDbF+IyWTElcSSw?=
 =?iso-8859-1?Q?2VB6A2ZUanGWHuV+TQ8v2K/jULCJ2TBuWtuUwRjs2scNhet+wMvU6azAjB?=
 =?iso-8859-1?Q?qLivjfOqszyaVMJUJVdd18CS7DF5nNR82scnSWcyll01EGMyq5ACW8BCwa?=
 =?iso-8859-1?Q?DLedpvup3Qw3X8lWnRRw9DaKmVX1dUIwQls6Bo8imfplnOyUd/OXfjKVq9?=
 =?iso-8859-1?Q?g160FM8FZjw8ko2VjE/l80lmvdveGaKMv/CYsEITU/Gk8iV6eYKxc52qio?=
 =?iso-8859-1?Q?/4LJZxr9gAhms2Gq0olqNffdimbtGlDxTLmcCxO0jmcmUGf1o0CWoZy/CA?=
 =?iso-8859-1?Q?U/nF9lb9U2Y2UzoxK9wfv1FwgXB0jzR6AiDWDdaLQKa2ipwWeX4/VRAW52?=
 =?iso-8859-1?Q?tLWdhSfSE2cxPUCi6m9sONE/AcquaE5eT64h7fqpbp9PBMuGtERYhtcFKa?=
 =?iso-8859-1?Q?U/mz6SYRe6GoLiql9skz5STeYaC89PQQhn8AhqTtQJ7dgmpOWG7SMQEM39?=
 =?iso-8859-1?Q?ginu8vHjsU1l3JGAl+ETnmni49yapQfdeQUJm+HYWfchZPoL16laP4l6wf?=
 =?iso-8859-1?Q?ZXtmhf3shQGCdd58h6uCAUnjaTiLYkpXMVZwhaCmeFMHzXLm0/LzwaTBwJ?=
 =?iso-8859-1?Q?Cdp5yFF8M97/hggokbi2em1o2rSEiawx6WXL2ejdkZVFh9wBR0XzsrrKuM?=
 =?iso-8859-1?Q?fRErmbpa+Ch4BN2x5r3AykQIoESoCcjKSvGLCX11iksvYp9b2h3DSVmS+P?=
 =?iso-8859-1?Q?PizcG+razuyK+u/FQfBio+pcEPujNMnn8ogmFBMTGrbxadb22S5YhDDfC8?=
 =?iso-8859-1?Q?nBF6/HgTiGqJNa9WTePnJ3JFLABN9RILaZ18HsDaB2clJltvXv53/OMum5?=
 =?iso-8859-1?Q?wzsBjhAO3sqRCp0EV5IVxEqdhuWWFgAv2w6QBn4fw/BVUWkL375mAEeq9v?=
 =?iso-8859-1?Q?drZZ8W11j96BImMeC5UJpgaJZSv/zwqEbP7+whTXBePb2pSK0Xc06B979e?=
 =?iso-8859-1?Q?sGvmWVQxPp9NfHPhwYCztO6YHubqRjDeIO5KQ/z5tK1/kZJn9BSbtBZFiS?=
 =?iso-8859-1?Q?n7uL35c78jIrcYbwbFtfRrHJu23yIC71Ni7jHJR2/zoyVIY1j9TLJCEOia?=
 =?iso-8859-1?Q?M5m/dJsMe/eC12yvG9cMaZ01+lkgMtGgbi7NYaLcvBt0HZQ/XxY7kvQGCe?=
 =?iso-8859-1?Q?eKoWYNGqlxqQKSiZHMjQYB390mC6dr+pLjnxNi3OdoyXv1SN3S6lSDb7Ex?=
 =?iso-8859-1?Q?1kWhpGdyzsvemcYDXmAxqNjyqDJAkm0bqarFBDvMBnPqwKB2kMFZzxMaBd?=
 =?iso-8859-1?Q?BTFPdrkdWvFx/H2L69S5wP8GpaIfGVYsM3UwlXhQFCk2oI3mcDIeNEWdN7?=
 =?iso-8859-1?Q?hD9s55y+vV7SnkNqFr0S1GxBxEjG2VtIGsqm6oX5hsSQFvfC1JaqiqY01W?=
 =?iso-8859-1?Q?z28Spq7Pd+3gL39d+nLVQu/tOGX8gV1Zbi6bu7ZDOSuWAxxXY1qdIxIXZM?=
 =?iso-8859-1?Q?Qggli3fBs8NLdLNciUkMbwCjQQ+9UcfoPG9/faN9xOeSYW5crSr8muQkyA?=
 =?iso-8859-1?Q?X/jaFbBDC9ZDkWCdEdHuA6UOcS+YqcpeZ7O2e2fS83ZY8R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae66a9f5-135c-44ae-d840-08df1fc7d557
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 14:25:24.7573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3hRvTLfEjnF5NVOnAALrtl7dpGmLZ2iI63pwfs4ltkdzQIIApYC9CAjWI4vTe7B3mmwfs5Tz+td8KhM2BeelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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

There is minimal checking on top (e.g. size & 3 and offset & 3) which is re=
quired by both the hardware and umr.  I agree the PAGE_SIZE check is a good=
 idea.=0A=
=0A=
umr really should only be doing 4 byte accesses at a time which is how the =
inner library API is designed it's generally assumed registers aren't conti=
guous.=0A=
=0A=
I wonder if a similar fix is needed for gprwave reads as well?=0A=
=0A=
Tom=0A=
=0A=
=0A=
________________________________________=0A=
From: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>=0A=
Sent: Thursday, October 1, 2026 10:00=0A=
To: Koenig, Christian; Mikhail Gavrilov; amd-gfx@lists.freedesktop.org=0A=
Cc: Deucher, Alexander; Prosyak, Vitaly; StDenis, Tom=0A=
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the GRB=
M/SRBM locks=0A=
=0A=
Mikhail's proposed kvmalloc(size, GFP_KERNEL) correctly stages user data ou=
tside the GRBM/SRBM locks, avoiding a potential page fault while holding th=
ose locks.=0A=
However, since size is derived directly from a userspace read or write requ=
est, we must validate it before allocating memory in both amdgpu_debugfs_pr=
ocess_reg_op() and amdgpu_debugfs_regs2_op().=0A=
=0A=
Tom, do you agree with this? Will adding a restriction here break any UMR  =
requests?=0A=
Please add a bounds check in each handler after the existing alignment/offs=
et validation and immediately before kvmalloc():=0A=
=0A=
if (size > PAGE_SIZE)=0A=
    return -EINVAL;=0A=
=0A=
data =3D kvmalloc(size, GFP_KERNEL);=0A=
if (!data)=0A=
    return -ENOMEM;=0A=
=0A=
With that input validation addressed:=0A=
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>=0A=
=0A=
=0A=
On 2026-10-01 02:12, Christian K=F6nig wrote:=0A=
> On 9/30/26 17:49, Mikhail Gavrilov wrote:=0A=
>> Reading or writing a register through the amdgpu_regs2 debugfs file=0A=
>> with GRBM bank selection, which umr does for every banked access (a=0A=
>> single "umr -b x x x -r <reg>" is enough, as is the wave dump with=0A=
>> "-O halt_waves"), makes lockdep report a circular locking dependency,=0A=
>> after which lockdep stays off until reboot:=0A=
>>=0A=
>>   WARNING: possible circular locking dependency detected=0A=
>>   umr/63306 is trying to acquire lock:=0A=
>>   ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/=
0x140=0A=
>>   but task is already holding lock:=0A=
>>   ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debug=
fs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]=0A=
>>   ...=0A=
>>   Chain exists of:=0A=
>>     &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key=
=0A=
>>   ...=0A=
>>    __might_fault+0xc5/0x140=0A=
>>    amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]=0A=
>>    full_proxy_write+0x10e/0x1d0=0A=
>>    vfs_write+0x1d0/0xf50=0A=
>>    ksys_write+0x116/0x250=0A=
>>=0A=
>> amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call=0A=
>> get_user()/put_user() for every dword while holding grbm_idx_mutex or=0A=
>> srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock=
=0A=
>> inside those locks. The lock hierarchy declared in amdgpu_lockdep.c sinc=
e=0A=
>> commit 1d0f5838b126=0A=
>> ("drm/amdgpu: Add lockdep annotations for lock ordering validation") put=
s=0A=
>> srbm_mutex and grbm_idx_mutex below notifier_lock, which=0A=
>> amdgpu_cs_submit() takes with the BO reservations held, and=0A=
>> dma_resv_lockdep() orders the reservations inside mmap_lock. So=0A=
>> mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two=0A=
>> debugfs paths nest it the other way round.=0A=
>>=0A=
>> Copy the user buffer in before any of the locks is taken and the result=
=0A=
>> out after all of them are dropped, as amdgpu_debugfs_wave_read(),=0A=
>> amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.=
=0A=
>> A fault on the user buffer of a write now fails with -EFAULT before any=
=0A=
>> register is written, instead of after a partial write.=0A=
>>=0A=
>> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock order=
ing validation")=0A=
> Well that's not really correct since that patch only makes the problem vi=
sible and not introduce it :)=0A=
>=0A=
> But apart from that rather good catch, Vitalies work to add lockdep annot=
ations pays of.=0A=
>=0A=
>> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
> I don't have time to review this in detail. Vitaly and Tom please take a =
look at this.=0A=
>=0A=
> But feel free to add Acked-by: Christian K=F6nig <christian.koenig@amd.co=
m>=0A=
>=0A=
> Thanks in advance,=0A=
> Christian.=0A=
>=0A=
>> ---=0A=
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 71 ++++++++++++---------=
=0A=
>>  1 file changed, 40 insertions(+), 31 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_debugfs.c=0A=
>> index aca1a8045afa..5618bd3e2610 100644=0A=
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
>> @@ -121,6 +121,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read=
, struct file *f,=0A=
>>=0A=
>>      *pos &=3D (1UL << 22) - 1;=0A=
>>=0A=
>> +    /*=0A=
>> +     * Access the user buffer only while none of the locks below are he=
ld:=0A=
>> +     * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest=
=0A=
>> +     * inside it.=0A=
>> +     */=0A=
>> +    u32 *data __free(kvfree) =3D kvmalloc(size, GFP_KERNEL);=0A=
>> +    if (!data)=0A=
>> +            return -ENOMEM;=0A=
>> +    if (!read && copy_from_user(data, buf, size))=0A=
>> +            return -EFAULT;=0A=
>> +=0A=
>>      r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);=0A=
>>      if (r < 0) {=0A=
>>              pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
>> @@ -152,28 +163,16 @@ static int  amdgpu_debugfs_process_reg_op(bool rea=
d, struct file *f,=0A=
>>              mutex_lock(&adev->pm.mutex);=0A=
>>=0A=
>>      while (size) {=0A=
>> -            uint32_t value;=0A=
>> -=0A=
>> -            if (read) {=0A=
>> -                    value =3D RREG32(*pos >> 2);=0A=
>> -                    r =3D put_user(value, (uint32_t *)buf);=0A=
>> -            } else {=0A=
>> -                    r =3D get_user(value, (uint32_t *)buf);=0A=
>> -                    if (!r)=0A=
>> -                            amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, va=
lue, 0);=0A=
>> -            }=0A=
>> -            if (r) {=0A=
>> -                    result =3D r;=0A=
>> -                    goto end;=0A=
>> -            }=0A=
>> +            if (read)=0A=
>> +                    data[result >> 2] =3D RREG32(*pos >> 2);=0A=
>> +            else=0A=
>> +                    amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[resul=
t >> 2], 0);=0A=
>>=0A=
>>              result +=3D 4;=0A=
>> -            buf +=3D 4;=0A=
>>              *pos +=3D 4;=0A=
>>              size -=3D 4;=0A=
>>      }=0A=
>>=0A=
>> -end:=0A=
>>      if (use_bank) {=0A=
>>              amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff, 0);=0A=
>>              mutex_unlock(&adev->grbm_idx_mutex);=0A=
>> @@ -188,6 +187,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read=
, struct file *f,=0A=
>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
>>=0A=
>>      amdgpu_virt_disable_access_debugfs(adev);=0A=
>> +=0A=
>> +    if (read && copy_to_user(buf, data, result))=0A=
>> +            return -EFAULT;=0A=
>> +=0A=
>>      return result;=0A=
>>  }=0A=
>>=0A=
>> @@ -238,11 +241,21 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file=
 *f, char __user *buf, u32 off=0A=
>>      struct amdgpu_device *adev =3D rd->adev;=0A=
>>      ssize_t result =3D 0;=0A=
>>      int r;=0A=
>> -    uint32_t value;=0A=
>>=0A=
>>      if (size & 0x3 || offset & 0x3)=0A=
>>              return -EINVAL;=0A=
>>=0A=
>> +    /*=0A=
>> +     * Access the user buffer only while none of the locks below are he=
ld:=0A=
>> +     * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest=
=0A=
>> +     * inside it.=0A=
>> +     */=0A=
>> +    u32 *data __free(kvfree) =3D kvmalloc(size, GFP_KERNEL);=0A=
>> +    if (!data)=0A=
>> +            return -ENOMEM;=0A=
>> +    if (write_en && copy_from_user(data, buf, size))=0A=
>> +            return -EFAULT;=0A=
>> +=0A=
>>      r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);=0A=
>>      if (r < 0) {=0A=
>>              pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
>> @@ -281,24 +294,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file=
 *f, char __user *buf, u32 off=0A=
>>              mutex_lock(&adev->pm.mutex);=0A=
>>=0A=
>>      while (size) {=0A=
>> -            if (!write_en) {=0A=
>> -                    value =3D RREG32(offset >> 2);=0A=
>> -                    r =3D put_user(value, (uint32_t *)buf);=0A=
>> -            } else {=0A=
>> -                    r =3D get_user(value, (uint32_t *)buf);=0A=
>> -                    if (!r)=0A=
>> -                            amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value, rd->id.xcc_id);=0A=
>> -            }=0A=
>> -            if (r) {=0A=
>> -                    result =3D r;=0A=
>> -                    goto end;=0A=
>> -            }=0A=
>> +            if (!write_en)=0A=
>> +                    data[result >> 2] =3D RREG32(offset >> 2);=0A=
>> +            else=0A=
>> +                    amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[res=
ult >> 2],=0A=
>> +                                            rd->id.xcc_id);=0A=
>>              offset +=3D 4;=0A=
>>              size -=3D 4;=0A=
>>              result +=3D 4;=0A=
>> -            buf +=3D 4;=0A=
>>      }=0A=
>> -end:=0A=
>> +=0A=
>>      if (rd->id.use_grbm) {=0A=
>>              amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff, rd->id.xcc_id);=0A=
>>              mutex_unlock(&adev->grbm_idx_mutex);=0A=
>> @@ -317,6 +322,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file =
*f, char __user *buf, u32 off=0A=
>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
>>=0A=
>>      amdgpu_virt_disable_access_debugfs(adev);=0A=
>> +=0A=
>> +    if (!write_en && copy_to_user(buf, data, result))=0A=
>> +            return -EFAULT;=0A=
>> +=0A=
>>      return result;=0A=
>>  }=0A=
>>=0A=
