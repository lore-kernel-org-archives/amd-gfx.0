Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B50BD3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 10:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3375C10E114;
	Wed, 10 Dec 2025 10:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MXcKFbTH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BB610E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 10:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCTVQsEahrBauV8Ms9znFQ0OOZ4Vo4zCPDQtO7GKOf39Hq6g9O1Q2vHvIV6qgcN/RRlwEQWrtS+Pv86QvcW35Ts8YBK13jncOIdKFU42b18JFq5TOp5RSGhhP7WohyU/83Msqc1POdvp+MxvSSVCSy6ub4F4WPNV0jlj2KbjWkqrseOS0HMWA97oWSkSninmWXCFi+b5ckPQzKkVySsFiu+tgeRFNaUNhuEaeg+Hsu2XIEf9ANDZT6etUuqrVOR/dZhOsLRf08TEbXDvJvpp+p1lOeJZCAsT5iSPZaa0PTs3y3wDG51eX/oQm1ChO753qF2WBbFz0b/Ekp6/KkQ5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2VclROEiMiuYrYkdj3906AXXcofNLFAEiU2W7OZNj4=;
 b=Jx67i16d4MhXwEBB7hl9BE90tYA8knfMUJfcCRvRpCxTbiJpDth2oODA623QvMQMHsTBL0SzbnXTRWqPIKM9A0f1RQH0SDPy4M8/r/VNLrlZO60FX4zPE9Rs7V8xHF7P68SpigeyNer2fYhuX6Sapb6gMS0IGJ3jJrTjERoDHTM6vLr7fVJ3QXQUQPHy+FQiIYaa4v7dXoHBZ3faf1ZVK2Lex8Sf/cbpjx+KA65ahWnSI+u+NDZD40hP5/CdWqVmdb0QrYgk2ryCJzxWrhqWjwCR5nRDAE6hy4spPqrFf0wH17rFV9KC0EeeQTOB3y9JYWO7CKUIuaR2SMacilzKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2VclROEiMiuYrYkdj3906AXXcofNLFAEiU2W7OZNj4=;
 b=MXcKFbTHeQynxv/MANCWsfPxulLUpa5yxk0RDJt0Og6DWUV41TS0l8t0JWsV9WcTbp7yGxnK6AI3U8mG1j11JlCUcZCAtL1IrzvEsOC/6FBKFv9GbO9C3Utt8vyvlJ8NIbMrPrkWYpd1ALZxsiUDq/K97O/kEXSq1OQTHVmiApI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 10:18:21 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 10:18:21 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
Thread-Topic: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
Thread-Index: AQHcaO2W845K0EhyQkOGrmuD/SK25bUZDkqAgAEibtCAAHLeAIAABGHQ
Date: Wed, 10 Dec 2025 10:18:21 +0000
Message-ID: <DM4PR12MB51524C29BB6DDD3D5A326010E3A0A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
 <c1aa6e1e-88a8-4b09-aa8a-f239f1306b9d@amd.com>
 <DM4PR12MB51521EBE33AC44DA2EC192A0E3A0A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <23b13d2f-c232-48d2-85cd-1d2656c93bad@amd.com>
In-Reply-To: <23b13d2f-c232-48d2-85cd-1d2656c93bad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T10:08:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9410:EE_
x-ms-office365-filtering-correlation-id: 2b8b91b7-8825-4e22-5d16-08de37d571dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lp1Fd81A5uSrnH4Anwr5JgUBMb9qAwRFamXzLyNQXRy1YpHrA/JRZyM+eEe+?=
 =?us-ascii?Q?2wKuop1CQ6umtVy4nVeQcN1V9IpI74JflIhTnIuDoQvYWWbXrQFIwzlROGvR?=
 =?us-ascii?Q?MqZvk+H/oR5nm4b7mEtYRcArx3Tu51OWFQnPKamsdLdQKFrhxx1mq6mQwjv1?=
 =?us-ascii?Q?kTco7V3VleUnYw6CT1oSGKOWSc0QFzfH3RHt6DGsX51pi9JEv/HDg8EF+vgP?=
 =?us-ascii?Q?Ckb5QgKidL2b+ET7GjELMSN/PV0ZQlKCr6/TF0I2rDBPfJI5Xx3SxRUyAJmO?=
 =?us-ascii?Q?QFOYPLblRMsA/gfTfaHI6XYEPE/EaiguwQNkRQSsDaKoYHfQxQnamJihYbB9?=
 =?us-ascii?Q?CnxjHF/HJgKu2e2BOalUqxT55MRYYZbaXdyGV7LFCokHn4IQBgzDgiY3sRyN?=
 =?us-ascii?Q?5BjXM0t7u6OEfUnJdlso+GDM6SFiCFtJLcdUiI0rUieJgk+QO4WIlgVHp0JA?=
 =?us-ascii?Q?6Q25UfEEQDdFv/rTyrrQGAz+6/Mr7SZ4TpXX7ceJ6N9cgwhxy6gX6QTdhZVH?=
 =?us-ascii?Q?leBsv1DOgZQ9ylParRXEhvIGct5NhjPRmZDv73kolJiC267efkHRaZVjJPsF?=
 =?us-ascii?Q?Q5yqeVTqqAqCHZpnq/aTV3PVxQf28CZV6aVNCydlpkSckaemzta11ltBeUzs?=
 =?us-ascii?Q?0qn9ZWj26wbt4RRHH6R0dagg8NZRTWCQFd2rnarMkITGmNesJ+tufptdpQID?=
 =?us-ascii?Q?1DACO/LE4CTMdmPkAmSZlAYNG0UNKeDpTn1eM93O8DukYUSj6zZ4pDXGc4Dv?=
 =?us-ascii?Q?vAJgft8XpIell3/3phaDga1FGCKOSLH6ew7fmMEZG+mcrfPR2ypfEhpJYCF6?=
 =?us-ascii?Q?1vxJRpikcT/lisgbPSxhsBAcmKBKzUuG5EMIfPpPVe5pg/wjHrCQHmlVR0cM?=
 =?us-ascii?Q?44UX71BjoWlayzTQz3aYBym9pnb7uF/zSh1Uo87T/7ufdteCc/7P+O56mj5B?=
 =?us-ascii?Q?fBfcJXfVTBLmd4KZA7zr9jPPrbdh9alMtG74sk71TRh7CdQO5AZ2CqsRa11l?=
 =?us-ascii?Q?Y89Jk6h/5Q4Z3wTpW+88QiyQsnkzf9AohS8OLD6KzoiuYVlS2gf9y4DEFUKC?=
 =?us-ascii?Q?9EPP2kXdBwD2HQwtr7bS79gq0uNTTfC56oa1rCI43hRiK/FCwf12eftO9LSl?=
 =?us-ascii?Q?p61UEiNRA/6eOP1BiYmf1Oh7WkeKGF3SWL0JtA2S0WueZq8z9dd3soSL1D9a?=
 =?us-ascii?Q?631jsW2/ybA+zxsqrDscUQUIyRSmRt7LLyB6cFX3PdCiyi2vfFlJbHdHMNWo?=
 =?us-ascii?Q?enbO4qKGJvL95ph9T3YNEvvK3qVhUkVfa95mVDgGiRguavjzG+3KNfg5JjvH?=
 =?us-ascii?Q?jo8vuM87TYpvk5DVUcvjQfGv2lf9FgHMUL2RGHcg+WXw4/fb8tgO6+ponGZu?=
 =?us-ascii?Q?OOhLPsC0msGuJu98LeTMFZSzdxTxi3TGjANuj3XL+J6joN8hXts6c7EnmfJ2?=
 =?us-ascii?Q?e22FvW+FrlMl7pHEuFosiQ50dK7jd3mV6H9J+pccVOV4DxTfmaP2rQ/sI574?=
 =?us-ascii?Q?wYxavgtrv+pD3YLL9DMbkmNq8MEKnR2YD/L3P2QKtwvXw1Q/NqE0sDLhTw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WAmISZN4M9F6XhLWHO4uU+rdMplz4lmxaGJHbSW3X+2iiABEMJTa3XUPhF0w?=
 =?us-ascii?Q?YR4zPLPvakSycgsNYPEfIsln5pEFayhrPOgIMH2fmFpboRW5Gv6uWaxUh6Wh?=
 =?us-ascii?Q?PaGxcbgv1cuJ0iYwxcfAXkEEqQPY/JYZ+NEBBZAxyEIcODK4rB0NJeuyYYX/?=
 =?us-ascii?Q?AB/xxE5h22pIvusLu6nCyxKAn7bLuqhIbge6V3T2fAn0GN8C3A5Gg29QWGse?=
 =?us-ascii?Q?9INVOD1/ps4XrpBfbXccDXOSgK3/4tbfJC9MkVMweA8ZDEtthfwGr5OboTHq?=
 =?us-ascii?Q?JQmXSSl1nrUlYS6h22M6DkBrcb5tAHj4EvV7s+QeUO/CpYyfTpRLOdBk2q/X?=
 =?us-ascii?Q?tlLixbi7VfqiEu9IjnTkaFFjqWs4JX+yOo67HCYHJvblNsue4BXj0wleADk6?=
 =?us-ascii?Q?4VreD+Mm6pjmoFFy/oiGLu0iMD0lzf9WBHslmaFSQtsb1rHcAeeCoE9Z9vLx?=
 =?us-ascii?Q?N7tuvbMWB+K18Q4uVS3utI0oLYrsEGBo5ww5hPvE8BeHuMs3pwGBtZN5NgLx?=
 =?us-ascii?Q?ZLIPs1S4qOTG7LyzptisDl9CqWk+wQg94zJAhilJCgW/l7x0XsWaJz7w6h0e?=
 =?us-ascii?Q?2x6fhbsH2dPxGW8yz21dpQfRbKDEr7vQnMhx+bkGGspXIot6z7Y7M2K1nM4d?=
 =?us-ascii?Q?sapvrPpE5fi9gEjezmR3J/fbnrpSOx3n+FT8biic/rU0ZxYEQ1LDa59JTwQ4?=
 =?us-ascii?Q?MQYOsXm/69ic7ywcIho3WRycsS05Y0rnIVBhotdL60DCDHvuJwI0Uyc1H4hA?=
 =?us-ascii?Q?HbZjkbGsb7D8PFqlBEWW6rLn1y1oEiNhNX1I7NNeLU/GcxBZkRcmz41t7YwE?=
 =?us-ascii?Q?6VrFWbmi+slH7rV4xcs+c3hjTtqqVdh1taw8GeizMu5KCERc4uGRVqMQOZGD?=
 =?us-ascii?Q?d/rBFD8UIEnEeYIq28QdB2y5FV3BZQpX6NVdlaWXZVKW6YrhEP1eQ5SFspi9?=
 =?us-ascii?Q?ORhgE987WFTpfMnG9tE2gAn/ufM6je1qyEnXOeJPi5W8NfkDVkFcvfFpzDci?=
 =?us-ascii?Q?CsoaMgEksiwNDnuUoPwHinUv8b83C3ud7meaPiKDtGqfg61uEnFOlWdXktVe?=
 =?us-ascii?Q?CxZ5sFMJHseqC7pyKxaCVRkYeZLrVcIe0hjEQoTZD00ghZ9zgRez5ZSksnak?=
 =?us-ascii?Q?OKhRgEsgIN0DqUB3jcubxpoeiSbG4RBKGceZNHNCpFlkf9OsMr+Ntba+J5ky?=
 =?us-ascii?Q?u72P0TtJy3acnJLHyuxVeJNEKuCx5FIrc8RCI2CI0BlIwmc+5JdmjyMEyDpv?=
 =?us-ascii?Q?svh9AmtdqYBJFYNKmxcZLsPImMwDz+sgdn9sDk3O4F5Hc5apftcaWqwuLVfK?=
 =?us-ascii?Q?Iulu94AwT0UWUD9LyI2vUIU4qxLXwqX/15vK6vz/YlLE4xXl1tQ64BMuoJmV?=
 =?us-ascii?Q?ahKBHaOY7pLHI4gFvjg25f7TrbAG2KqDP9wgvlFOPqnpKTn+pTWTMlXpiJ9X?=
 =?us-ascii?Q?1c75grjkJW5zKx9SC6PB/Nm2fzdzxhDZgQayoLhXQeV3tewHE/PmVzmH6zYp?=
 =?us-ascii?Q?UTZbQLZIwkGjrD2KZmjGflgqSbBtnDb/p1tHLw05O5YrIfkCKHp3gqQNCdUt?=
 =?us-ascii?Q?pPb0zPXjWIG8TdbXlK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8b91b7-8825-4e22-5d16-08de37d571dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 10:18:21.0837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp3ee4m5yru22y1izFJnjWDMlIoNU5czm+nc1gZdOG9yfyCuWdPS91vJ64l76zCDpFxA194ua9axrbomgwjuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, December 10, 2025 5:53 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Wait for eviction fence before schedulin=
g
> resume work
>
> On 12/10/25 04:04, Zhang, Jesse(Jie) wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >> -----Original Message-----
> >> From: Koenig, Christian <Christian.Koenig@amd.com>
> >> Sent: Tuesday, December 9, 2025 5:42 PM
> >> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> >> amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: Re: [PATCH] drm/amdgpu: Wait for eviction fence before
> >> scheduling resume work
> >>
> >> On 12/9/25 10:23, Jesse.Zhang wrote:
> >>> In the amdgpu_userq_evict function, after signaling the eviction
> >>> fence, we need to ensure it's processed before scheduling the resume
> >>> work. This prevents potential race conditions where the resume work
> >>> might start before the eviction fence has been fully handled,
> >>> leading to inconsistent state in user queues.
> >>
> >> Well signaling the fence means it is fully processed. So this change
> >> here is just bluntly nonsense.
> >>
> >> What exactly is happening?
> > [Zhang, Jesse(Jie)] Hi Christian,
> >
> > Let me clarify the issue we're observing with the SDMA user queues unde=
r
> stress.
> >
> > **The Problem:**
> > During stress testing of SDMA user queues, we intermittently see stale =
doorbell
> values persisting after the CPU writes to `cpu_wptr`.
> > Specifically, after updating `cpu_wptr` (which should update the
> > doorbell), the doorbell register sometimes retains its previous value, =
causing
> inconsistent queue behavior. This happens randomly under heavy load but i=
s
> reproducible in stress scenarios.
> >
> >
> > **Root Cause Analysis:**
> > After signaling the eviction fence, the resume work is scheduled
> > immediately without ensuring that all internal driver state updates (qu=
eue state
> transitions, MES state cleanup, etc.) are fully visible and consistent.
>
> That is a massive bug and the root cause of this issue.
>
> The eviction fence can only be signaled *after* all queue state transitio=
ns and the
> MES state is clean.
>
> What the heck is going on here? What state are we talking about?
[Zhang, Jesse(Jie)]  This issue was discovered during SDMA user queue testi=
ng in the IGT. After updating wptr_cpu and the doorbell from CPU side,
the doorbell register sometimes randomly retains its previous value. We sus=
pect this is related to the  memory synchronization.
Do you have any guidance on this?

Here is the internal ticket : https://ontrack-internal.amd.com/browse/SWDEV=
-565880>

Thanks
Jesse

> > How about changing it this way?
>
> Stuff like that is an absolutely clear NAK as well.
>
> Regards,
> Christian.
>
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -1130,8 +1130,27 @@ static void amdgpu_userq_restore_worker(struct
> > work_struct *work)  {
> >         /* Schedule a resume work */
> > -       schedule_delayed_work(&uq_mgr->resume_work, 0);
> > +       schedule_delayed_work(&uq_mgr->resume_work,
> > + usecs_to_jiffies(1000));
> >
> > Thanks
> > Jesse
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> index 2f97f35e0af5..ed744b2edc61 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> @@ -1238,6 +1238,10 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr
> >> *uq_mgr,
> >>>             return;
> >>>     }
> >>>
> >>> +       /* Wait for eviction fence to be processed before schedule a =
resume
> work */
> >>> +   if (dma_fence_wait_timeout(&ev_fence->base, false,
> >>> + msecs_to_jiffies(100))
> >> <=3D 0) {
> >>> +           dev_warn(adev->dev, "Eviction fence wait timed out\n");
> >>> +   }
> >>>     /* Schedule a resume work */
> >>>     schedule_delayed_work(&uq_mgr->resume_work, 0);  }
> >

