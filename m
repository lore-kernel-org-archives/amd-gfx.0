Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FFCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2928710E9B0;
	Tue, 12 May 2026 08:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AdQl1Rj+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFA210E9B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9c/Q6ePjvg/PYBSSMEGZFeKVK3IjRji4Zht7Qi3bYeiGHEhvrGna27OAgIb/mFRHcasgY6MPSK3d4BZdQJlJTiIiiy01Q87U8Fx2YMD6pUzF9cvUqgPV0hsfg7qDLwHqNemmhpauDjIJE9YRaclxXLARbHt+DidPTtOtnzkfnaDT8HuUfFMfGIpBSgxL2xz+YNRDYfgBAyxraFEAza/b4KzM3N7GxT5qmYSx49KFyRF3Zw5k5Q4hIb9c/y9key7zeCldoYeAwxWzosefe4wsj61e7E5eVvZhDhZNwyKk2KQJ9AdWJPHCrEPjlPfTt8B/XtgS9spqv5qt16O6oPZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh8wVrxSXvfV9XP4lYOfyD4FB9/YNxOaFjBbMdS53HM=;
 b=WiutL8BhhzhFXj07zRaoAelfqu/QkomhwuaZKoI5KkwdvbQHeb3HaVFyOwQCaTsGZpPwtZiRfZKXlwy2m7PVDahKf41HhYtD21RQw9Z4mWzYMUJ/dLowAzrohXStFERp0mB2TP/jD9/BQXhxxtDC0Du6FXCwDQdDyYFlGW14sNff3stzhbnI91LeHaK9NF5TbutGN5q46AwYqOWJeaR/FRnryG+92liEt4kM5vD2gXSVoQRHvTLj6HjptT4dQG4DxVTPCha1XMQyPkiJRULOOU6YJq1BhnbKYm8gwgpo8QgkN1wWr4fwwe07hoBOt20RELRK4lLf3FApNZy9bO/6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh8wVrxSXvfV9XP4lYOfyD4FB9/YNxOaFjBbMdS53HM=;
 b=AdQl1Rj+5rUgTFF1yqywAv9fF94qq2IEg4lOkpWLwKzJ/RuLdbMLC8pjWotDdKXwPV+nhJi06puD0T34c06wjj5WJFW8sJiU9tp3MKBsQaf2Ynl2QqUzwRg2GxAmZMbWm0WUGf+HEQYRikriUH6nLeBtcKDo0yxbdFYm6L7Y/jM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:31:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:31:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
Thread-Topic: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
Thread-Index: AQHc4U29uZexPDvJbEOGoMrJNlwCF7YI2YmAgAEg4gCAAAvuQA==
Date: Tue, 12 May 2026 08:31:09 +0000
Message-ID: <DS7PR12MB600517D37304CA24739B42E9FB392@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <c4c71c7d-01f0-4249-9f8b-c10662f16b64@amd.com>
 <660f56b2-7a64-4f45-af69-3fb07c4bb848@damsy.net>
In-Reply-To: <660f56b2-7a64-4f45-af69-3fb07c4bb848@damsy.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T07:53:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB999251:EE_
x-ms-office365-filtering-correlation-id: 609576c1-7312-4d81-738c-08deb000d1c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: bvisJUHHRR4F24QzA3gI3FHabz0YIizqvxZwWSlIiA+dre5bpLgGy0O3eWvy/W1TwGDyyGMjlS2aWTXI8bLYXOUFFrfNioVgy3lwfYipmwjk4GRNnJrAMvQgMDmyJvqm1pyIiF7t/esjYyQhQ/ZAJCQ0uFHbZQrzg8QOae4KYQgAFhJv6JbQaHwptk7sJBjh1VHg/67667GGVGWhE2eniOXIKtvU+ABwXY6ufrdAQ6o1YYdFMaZNg3WTAe9knXwdTWD4Pti3njJmlIuRG2bAO8LVI+1kGBhB3weAhmUGaVoTJsBOo/AVPnTiFTW+LqmmsRbE8RtAGDkkHiHCr8lMsztkYSWwYf2MUhS3SGQJEU20yFaH+KsS2jujdI7nTQkMyp0Q4AVgONX32XvCusEU1FvfzYcjvTXWAEmSwOQO5NL894BrXSBTAJwASFHOoCyprLLt9Fq9xKQI61Q4J1G1BFqW2frKz+UclJCnSqNR25sptDZ3fSC12fGarGo2KAhTo70iRTsuAwUs9fBXHG3893lNMalLr6URYlzxWvTBz/0+jq+RyVpaPuYeSy57+43HbFVFsgW74jpy5OMUvPBp6m4jQDQ8xWogaufpMjjz3TT7ALaszveEz92syW8tMbTaiv2rd1IacTVclb4wwzkv/T46j+6FE4IODdwGMtIk1nlkCX0ZRiB7UsHvuaUx/B3WdPjTxSPjNyd13KGW9/QQ6f7pANbNTP6DPeTiJd5+g4sojsRP6zesnNSgKGu6MzUr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i5ZbNQa+CLKb7tiz2NDAOwE3hnhyEamImmzbCmpLkI45vcJQqifRRSl0xc?=
 =?iso-8859-1?Q?1NfOZytBSx/zNIjLj3iG/rpTjthbt931xDhIWMg/Qe9+puV8U3Htp918ZI?=
 =?iso-8859-1?Q?863busOp1aFk5eCrPj9ukLbMR3gRnLvYVFMMK9M11APoYVyNKomE3FdIXE?=
 =?iso-8859-1?Q?5dOqjZSyqa41RfxXyKB7BymmKAu4lqltASbpqpkqf7myX+woJhqfSWiDKv?=
 =?iso-8859-1?Q?LcY0iAOkeJJfAHCmW6AzaU05CQZ1YfBoKiltdCO8IAjkUEAARB1FzUHl3w?=
 =?iso-8859-1?Q?sglgm46weid90ljZygM6V7F4rBQFVAreOQmsIV00MoeSHhCJL0mbiFeOzP?=
 =?iso-8859-1?Q?qjwkq7qu/MwkTRrLgYf/ZRuF96d445se12u6GH2IbjCKdvuj5rUi22wHSX?=
 =?iso-8859-1?Q?dShoPKOdl866mzfSU5aScZDc1fH1PZTKvgND+K7SRDNmOsPXdiEA4HDbjS?=
 =?iso-8859-1?Q?7g8O9dqiUxAFi+x5TsdxW5sQc0CgcXqjfb6S1ypsHyyW2iEss8KtPixiBr?=
 =?iso-8859-1?Q?vhz2tHM9o0ckNBoAtxq28KlJietpqwOukqAv661ySEnb3e6vCwHDK+D8bN?=
 =?iso-8859-1?Q?HZSzIYd978wmUsSIllkdYju03hyLz/XfqJeqy1X3PL30GtzK1QEgq3QnU8?=
 =?iso-8859-1?Q?jCqe4AWV8PSgp46ykrJTnOjR3XOkEGoxHGrt8e5AfNm2xgJny56HGDiRYe?=
 =?iso-8859-1?Q?WGC6FDA2ZWAOIHnt4xMzJfolEmTHEGPxcwAfUGQdZgpSKKmoIULHGETA5F?=
 =?iso-8859-1?Q?xHfHVIZGL3V9cN60Gef2embUhpmXIQh3cRBreqSaU+p6KcHyUj5NOWZX+4?=
 =?iso-8859-1?Q?n14OMdi4iVyk5i3O+aCrvyKeqyuBZLkIFfP3FiDNemDUn/hPkl5ztrAAuF?=
 =?iso-8859-1?Q?yuu+hzTfFO+La8lT1tXQo/Hq8NzZ1JgyRPm/EQUaQLw6imcCv/5g6L+BMF?=
 =?iso-8859-1?Q?0eRvSyL0PsD7uHi5ABXAQGKFButhbdLBHqfEF3d2/eBUHZ0EqUO8Le/2WE?=
 =?iso-8859-1?Q?nn6kre0/cT5s77Rlt2dD7Sq7RnkbqZ+NxcIEFr47WWzOdJJ6MVkJEVhj4X?=
 =?iso-8859-1?Q?k/zOif92dE4gyt4lvKu3k2TvNWNojyNVKC8sUoXXVJZm/xA6Bg8IHeUNGI?=
 =?iso-8859-1?Q?Vis4aqxZJP8h4ikziV5W9LUtBt8tL4Vv9FKEdIW7q431opzQxScDrbfd/+?=
 =?iso-8859-1?Q?fWnNMctIsNg6UrC3bbcmi8VeSEMqa8UsrMSoT6lZJpeKa0lO4Pm0mYqgwu?=
 =?iso-8859-1?Q?PPphjopeeTUXWFJ21dLoGFY2Wo0lbIiGqLhAqlaPdQ6q6zEHWWYYb2lhFM?=
 =?iso-8859-1?Q?5qnsvHO+HqNGlz8qPvLIY88ATWSbM+JZnupchuQUZQxofPkWMeTAC8YcuI?=
 =?iso-8859-1?Q?nqhxOWdeS9g4ayjs2/KBh1X0fvSS4MH/H0l+JON2ERD7T7/EmD6QeeTm/d?=
 =?iso-8859-1?Q?/LSL7jNkNhfXnvYQQFOJ+VsHWlH+S1OcbgS1Xvmrmk+npOZYUPpbHebdUX?=
 =?iso-8859-1?Q?er4PKG7SZDrtLC+CpfG8un2tUuQJd03jyAMx9cMryXE9QCkj3IvU39ZR3b?=
 =?iso-8859-1?Q?7fSmgjvOvvDgLoTxlkXC0+ZGZGNDl9kff9GvczmsQ3ZgftAjwz345hAlAr?=
 =?iso-8859-1?Q?tcY0W8IrOvu0kP9LCgEify1x63QqpuZ0YeSqtk+bF7x3AbKtAjpx+E12xV?=
 =?iso-8859-1?Q?m6LIlJwVxp/QiH4eM3eIMjT0KfpAHkOUGaSzsStdN1uHZTv6qcRYCL4E7f?=
 =?iso-8859-1?Q?ZZQPn64DlmbLjRSr7RdKnHEgvkZNWWoJ0ple5MUqWEOi5t?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609576c1-7312-4d81-738c-08deb000d1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:31:09.8742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gidpOEFivWcCqoAaRqOqN6ejsC98+7JVLrAy/L+prJpSKvm1AnVlvugaCx87+IoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
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

Regards,
      Prike

> -----Original Message-----
> From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
> Sent: Tuesday, May 12, 2026 3:11 PM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>; Liang, Prike <Prike.Liang@amd.c=
om>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>
> Subject: Re: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepo=
ints
>
>
>
> Le 11/05/2026 =E0 15:57, Khatri, Sunil a =E9crit :
> > If i am not wrong Pierre eric did work on the traces for user queues.
> > I have dropped my patches for the same reason but not sure if the trace=
s patches
> are merged. Could you check with him once ?
>
> No my patches aren't merged; their scope is to expose something similar t=
o
> gpu_scheduler events to be able to observe user queues activity.
>
> >
> > On 11-05-2026 07:24 pm, Prike Liang wrote:
> >> Add ftrace events around user queue creation and destruction to
> >> profile queue setup and teardown latency.
>
> IMO these events look like something that could be done with the function=
 tracer
> (optionally using the func-args feature) by tracing amdgpu_userq_destroy =
/
> amdgpu_userq_create entry and exit.

Thanks for the suggestion, but while the function graph tracer can help cap=
ture function-level boundary metrics,
it doesn't provide queue context in an accurate or readable way. Patches #1=
 and #4 could supplement your
implementation and would help profile the userq creation, destroy, and evic=
tion latency.

> Pierre-Eric
>
>
> >>
> >> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58
> >> +++++++++++++++++++++++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
> >>   2 files changed, 69 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> index d13e64a69e25..5a01f63d1f32 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
> >>                 __entry->value)
> >>   );
> >> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
> >> +        TP_PROTO(struct amdgpu_usermode_queue *queue),
> >> +        TP_ARGS(queue),
> >> +        TP_STRUCT__entry(
> >> +                 __field(struct amdgpu_usermode_queue *, queue)
> >> +                 __field(u64, doorbell_index)
> >> +                 __field(int, queue_type)
> >> +                 __field(int, state)
> >> +                 __field(u32, xcp_id)
> >> +                 ),
> >> +        TP_fast_assign(
> >> +               __entry->queue =3D queue;
> >> +               __entry->doorbell_index =3D queue ?
> >> +queue->doorbell_index : 0;
> >> +               __entry->queue_type =3D queue ? queue->queue_type : -1=
;
> >> +               __entry->state =3D queue ? queue->state : -1;
> >> +               __entry->xcp_id =3D queue ? queue->xcp_id : 0;
> >> +               ),
> >> +        TP_printk("queue=3D%p, doorbell=3D%llu, type=3D%d, state=3D%d=
,
> >> +xcp_id=3D%u",
> >> +              __entry->queue, __entry->doorbell_index,
> >> +              __entry->queue_type, __entry->state, __entry->xcp_id)
> >> +); DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
> >> +         TP_PROTO(struct amdgpu_usermode_queue *queue),
> >> +         TP_ARGS(queue));
> >> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
> >> +         TP_PROTO(struct amdgpu_usermode_queue *queue),
> >> +         TP_ARGS(queue));
> >> +DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
> >> +        TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> >> +        TP_ARGS(queue, result),
> >> +        TP_STRUCT__entry(
> >> +                 __field(struct amdgpu_usermode_queue *, queue)
> >> +                 __field(u64, doorbell_index)
> >> +                 __field(int, queue_type)
> >> +                 __field(int, state)
> >> +                 __field(u32, xcp_id)
> >> +                 __field(int, result)
> >> +                 ),
> >> +        TP_fast_assign(
> >> +               __entry->queue =3D queue;
> >> +               __entry->doorbell_index =3D queue ?
> >> +queue->doorbell_index : 0;
> >> +               __entry->queue_type =3D queue ? queue->queue_type : -1=
;
> >> +               __entry->state =3D queue ? queue->state : -1;
> >> +               __entry->xcp_id =3D queue ? queue->xcp_id : 0;
> >> +               __entry->result =3D result;
> >> +               ),
> >> +        TP_printk("queue=3D%p, doorbell=3D%llu, type=3D%d, state=3D%d=
,
> >> +xcp_id=3D%u, result=3D%d",
> >> +              __entry->queue, __entry->doorbell_index,
> >> +              __entry->queue_type, __entry->state,
> >> +              __entry->xcp_id, __entry->result) );
> >> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
> >> +         TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> >> +         TP_ARGS(queue, result));
> >> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> >> +         TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> >> +         TP_ARGS(queue, result));
> >> +
> >>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
> >>   #endif
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> index 3077ca4e27a0..50c46d31fbae 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> @@ -33,6 +33,7 @@
> >>   #include "amdgpu_userq.h"
> >>   #include "amdgpu_hmm.h"
> >>   #include "amdgpu_userq_fence.h"
> >> +#include "amdgpu_trace.h"
> >>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> >>   {
> >> @@ -617,6 +618,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr
> >> *uq_mgr, struct amdgpu_usermode_que
> >>       int r =3D 0;
> >> +    trace_amdgpu_userq_destroy_start(queue);
> >> +
> >>       cancel_delayed_work_sync(&uq_mgr->resume_work);
> >>       /* Cancel any pending hang detection work and cleanup */ @@
> >> -625,6 +628,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr
> >> *uq_mgr, struct amdgpu_usermode_que
> >>       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> >>       if (r) {
> >>           drm_file_err(uq_mgr->file, "Failed to reserve root bo
> >> during userqueue destroy\n");
> >> +        trace_amdgpu_userq_destroy_end(queue, r);
> >>           return r;
> >>       }
> >>       amdgpu_userq_buffer_vas_list_cleanup(adev, queue); @@ -650,6
> >> +654,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr,
> >> struct amdgpu_usermode_que
> >>       amdgpu_bo_unpin(queue->wptr_obj.obj);
> >>       amdgpu_bo_unreserve(queue->wptr_obj.obj);
> >>       amdgpu_bo_unref(&queue->wptr_obj.obj);
> >> +    trace_amdgpu_userq_destroy_end(queue, r);
> >>       kfree(queue);
> >>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >> @@ -754,6 +759,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> >> drm_amdgpu_userq *args)
> >>       mutex_init(&queue->fence_drv_lock);
> >>       xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> >> +    trace_amdgpu_userq_create_start(queue);
> >>       r =3D amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
> >>       if (r)
> >>           goto free_queue;
> >> @@ -809,6 +815,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> >> drm_amdgpu_userq *args)
> >>            * This drops the extra and last reference which should
> >> take
> >>            * care of all cleanup.
> >>            */
> >> +        trace_amdgpu_userq_create_end(queue, r);
> >>           amdgpu_userq_put(queue);
> >>           amdgpu_userq_put(queue);
> >>           return r;
> >> @@ -826,6 +833,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> >> drm_amdgpu_userq *args)
> >>           r =3D amdgpu_userq_map_helper(queue);
> >>           if (r) {
> >>               drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> >> +            trace_amdgpu_userq_create_end(queue, r);
> >>               mutex_unlock(&uq_mgr->userq_mutex);
> >>               /* Prevent racing with close */
> >>               if (xa_erase(&uq_mgr->userq_xa, qid) =3D=3D queue) @@
> >> -839,6 +847,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> >> drm_amdgpu_userq *args)
> >>       atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> >>       amdgpu_debugfs_userq_init(filp, queue, qid);
> >> +    trace_amdgpu_userq_create_end(queue, 0);
> >>       amdgpu_userq_put(queue);
> >>       args->out.queue_id =3D qid;
> >>       return 0;
> >> @@ -853,6 +862,8 @@ amdgpu_userq_create(struct drm_file *filp, union
> >> drm_amdgpu_userq *args)
> >>   free_fence_drv:
> >>       amdgpu_userq_fence_driver_free(queue);
> >>   free_queue:
> >> +    if (queue)
> >> +        trace_amdgpu_userq_create_end(queue, r);
> >>       kfree(queue);
> >>   err_pm_runtime:
> >>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
