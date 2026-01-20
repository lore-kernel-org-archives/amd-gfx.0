Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653D8D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF0A10E56D;
	Tue, 20 Jan 2026 07:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQwpsRcH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBF210E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IflJLSxLOBf/GssDI9kYw1UJ8PPe9R2a/gNklHl/XUP237zPltEm7uzEj0Udt2A8v80LAfJf3IHynNz4u8DmWVgZqHNV4xpEUggXsRH1JZGDFtxOC9EA/iFl9XFOviV6x/8Hr2kVEHEZCHCd0+HnuOeKMVSUnuCXuZdn90JsZ6nLyMMhJ2y+cW6EFlbSimKP9RLv4G+1KP6CKQhix1BcfBHfbds/d1kClwNGnkfs4xZSv1STyY8c6DE3EzNrcAMA4CdHmqbfZgOBwwnzu64EOBwmtKLg7N4lztrQ3i3rCVUuVcJRqa/LWi8LRjojwVvLqC0VhloMuAn0KxblSBT95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qryPsRw84QlIt1Cf7jVJq3oqzC8XpZvpZhzX9poaVF4=;
 b=k9VZ/+zMe83sb1iTsf1y9JzW1mPvzd78Ds+RY2e3yD6RBbwLk8hqB0EtFgYwvdsLW0HzXC3U2XNVw/AhNEq85JaeVPUBdgJyqVaK9mkwed9dhoT9PWluiJTPs2tiVyw9V4GU+pjtD0BsyuC7FRAJmdQ+lM+oq/Dwjs8AJMKJ/iGv1WxrV8AkbogkKzrMD5VkGnfMyYCvb7AWHfMsWa12cRRc3d/hfX0EhudMJqdyG53hmJ1X5v82rYgYItln3XY7qvHGUZqKgIaNUtLr4eDYNUyl0ldcZ00yBuSg/GZQd7CrgaSIZo5SoV3972JSzmlmoH3/Rk2aTe1ffL8NBsl5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qryPsRw84QlIt1Cf7jVJq3oqzC8XpZvpZhzX9poaVF4=;
 b=DQwpsRcHRdzde1f/BgaKZ02RRgvh5zN3UBb0NhIB0sra9p36oEfDJDxn96WQIFlcrZJ4V9abBD0kNDZjOhqARqXnbE9XTR47mr+9tMvYIKQ0MX+cYsJMzMTyCmPH89RR5aPfAbBVBRZLsnzgUUcF1HijyrXbnIFhJYy4Quqp2mo=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:32:37 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 07:32:37 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Thread-Topic: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Thread-Index: AQHcid7zbw+Z14LFGUWOAf0wRctX/A==
Date: Tue, 20 Jan 2026 07:32:37 +0000
Message-ID: <MW5PR12MB56846C5597516A2CAAB4FA68E589A@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <mailman.4415.1768885942.6456.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.4415.1768885942.6456.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T07:31:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|SA1PR12MB6727:EE_
x-ms-office365-filtering-correlation-id: 14078976-07e1-4727-367d-08de57f615d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4022899009|13003099007|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?mKez+izVJLo1fNIgetJQsSEVrpetZ/vISa/iofFvmIAZY6DmU6BqMgpMMlQG?=
 =?us-ascii?Q?WXj8ZwYVhc1ZYNax8EK0KEPkKCZCVDZNb08505IWShMTCJ4ps9DHb44xNRZ2?=
 =?us-ascii?Q?NVCNrgPsByQKT1uXBOPR1IH0iERs3ab8YVNiQYWcPKY2Tj3+SFSaDIMnmo/X?=
 =?us-ascii?Q?PxWSxCoekUCbW1zZh5yg6cTMQ5bUIRyhNeElfnXSTmyVyXOUfDXlHLrqiXLI?=
 =?us-ascii?Q?hUJ3NXEI+CQ+oVg7uneGLsjtm5F/JCNvxwAcsK4VLcKR105fRy2n9xWK9+5/?=
 =?us-ascii?Q?OaIrgrnCFEy8QjmNWeA5CHeLbYiqaDKtykVe9PuIuAuh7TB0PI4nlSpwHIgg?=
 =?us-ascii?Q?v4rhczpoNKOL43BsP74+7AuXOyEQJNsNDxBUCoHaYwWdEOAbws8DR5FnvQD4?=
 =?us-ascii?Q?0wYwNaVlSGK5b2qkP9UvC7BZwPPa4AZWMeKVwba5LfhgZ/E+4/lhaKyxcOwV?=
 =?us-ascii?Q?60Y8gOxmdSLgxsAGtJ0AVgfooIVX5qwUV/UywyhaCMaQLKI0AEutt9+RqLln?=
 =?us-ascii?Q?RDP60rxRyo6YWvIswq0YLvwbTZAlVdrRmWFMnOWg3IEKo7pyROEnALDUXqE+?=
 =?us-ascii?Q?qvcUWeyTA6GByEkqlhLObBjXkMPvgR4oJ9GmjFUEYR5JaGA7xIKbN/6eVqpM?=
 =?us-ascii?Q?RuBjCqeU3DeetNIxUH46Cpx9FfWK4EUnO2CCX2nH+pXVYmWr/pf9onrbgr8p?=
 =?us-ascii?Q?s2XI1ZvGmsGPIuKwXjEGuOScU6tU/lV8nHWk4djAWyn31WUlRMHPEW2sQP+1?=
 =?us-ascii?Q?t5Jhcqi2LaCYTsseyRQtOXhvA8+fzVnOUoV0tylSjAfURfMUWQjMVbaAl7Ox?=
 =?us-ascii?Q?I68yKHjJHrC16DivFe0wzVYMH4oCvwi7pt40d4AOa6LsbyI+k4hPg9g7ZdPN?=
 =?us-ascii?Q?Rx+BtujIvrreFIdF6NobxLRoh+JpPP08eLgrlCLbMJEvZE8ZsWOdWFbEIIxk?=
 =?us-ascii?Q?jtz7fxKC9MBUc1HRfNyswZ59UCQrkKsNH7k0Ouldbib2K6PuVY9U4AUDIwT1?=
 =?us-ascii?Q?0Jm0yk6ZczVrURnKr+OO1JopLin5vBKd8SuoOu9djqMtjYCsOBq/prIR56rH?=
 =?us-ascii?Q?pcJ5elAJnhn+PcC4MZCPPYo6XKjDCAg2UlXJfwIbodMMrAeDSQ83m9w3UuTq?=
 =?us-ascii?Q?BAnLR+J8Rr85d6z0Tl94SZFMj6gCPWJ9UC3PaiyEOvsFJmRIuR2UWlGQmZ8u?=
 =?us-ascii?Q?3PxRp/iEDIo+IaY5xhUvjtei7mvyWatrmG3O6/OXUGluYohS4rB5zUv2FQKR?=
 =?us-ascii?Q?gUtga+IqxrzYHJCGrgjN6eCjoNeI2eH3lsUsJIReAKkI/3Ah4T4jwp2qn6+H?=
 =?us-ascii?Q?UNiGtmRpobj2/sptpHd+R+9D9c5AYpsNXJA40/EXagsfEpMATdQm6yMAjixd?=
 =?us-ascii?Q?fm9P2lTgGeUVaWlQcYws+Dp0G/SepXc72NmuL/zMlctG5RzGxw0DUXvGAgZJ?=
 =?us-ascii?Q?8v19/jKrZP+FWotUMHUoosn7pSzBQ5x0uu+V0HhB4rn1HtQ4aewtfmXsP/By?=
 =?us-ascii?Q?YoM4lSkWI6F/0d5Cv1EsMt7N5S5pJcgMBDKeV7DKvoI+13pluPIXkQg9qEEJ?=
 =?us-ascii?Q?3HVA26Og1d2hUw54JFP4vmqenXmVW98Td+Hn7lZx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(13003099007)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RrKqSxutnyi3qGa5kJJDglONelZb8oYa6ty4Jrt4VbmU0mqfRIh2Z6F3E+F4?=
 =?us-ascii?Q?Z2zn38PiHz13jkjSOoR8w8XMl4o0Fo7hatldIsrKsJd98mN4XUkgBwSIkmox?=
 =?us-ascii?Q?r0iGH6RtUtg5lt5tp7VI0NL65Lf7G24j7yU7AbWNpCG0fgevhjAkIZbRPv6/?=
 =?us-ascii?Q?g5p9x+mSm/Q5jYCMyUM/e1gJk1R145vOFU0RjKNcx6OBTEBu3ENWBXyxnmRT?=
 =?us-ascii?Q?rBAOj7aZdpq3zMsZZLRlp1/8slLP3RloR5cKL1pRsqi0qBvF+folW+eWLtCs?=
 =?us-ascii?Q?ZfWFnCAc1cDdn9eYoS8lYBQJE/f4bz9fo6TU7zvzQ2Xgw0yY//7mjj67ZL6m?=
 =?us-ascii?Q?G4WWl4rrnIguv2QgkqXws614f1oa4QiKk/PA2VZ6DT6pvoYshLfC1MbQnUr9?=
 =?us-ascii?Q?+KSSkcEdZ8F82BF7yMvhp3jAf6zpV2zHVYcwcw0cR/wts4+glmmjgft/87K5?=
 =?us-ascii?Q?cOfSTKtU5mTDBGk6b+rN2G7ueCiKh55HhsrIkZFwjfgGKm7Ne02c6q0wiUHE?=
 =?us-ascii?Q?F6WciNSvJef28pzc9RcvEtLpaWBxr2oay/C/KaTXhLoe4zTfLMXkT9thUnoe?=
 =?us-ascii?Q?BrU+9SZL/WxRm7aun/Jx9q93FHdWezBzgvXufvLJYmD0dNY/pHiHydAqAqQ5?=
 =?us-ascii?Q?0+F2WJ4fci6Spbv0osbai2cBUurYXKCk0DckBi4o2A5iFwNaUJxdHHVrsJeD?=
 =?us-ascii?Q?K1tHcqjC0qElUMcZciyLjBGKvvM+jrzBOqSFTr3fPdFpE9V8z5YzFzh1GMOt?=
 =?us-ascii?Q?kvExSqSM+IG+XlCcfubIcmTFSSo99YbpPrMGl/GFnTIweX+HFSvUIpEnHGIt?=
 =?us-ascii?Q?9TAPXcWlGik4MpBBco5gpnYqjCYwN4WCjNjmQaOlfPPcREz/3EYeJ9xl/+mX?=
 =?us-ascii?Q?V6U0sDYguo3l2Knwvao3/0vYc/LewaOl9ZrVwCdQ39wyALIclKxq6jMF/Gn4?=
 =?us-ascii?Q?wp0AEZq21VJnt7AGfEJGPEWH/u+1imNWvbMNBm6FeLOxVJTh4Qk/Y545I8NL?=
 =?us-ascii?Q?741i+yDbVvx9APhid630FD5FpcOiVAm5w4jT8AQ/SM4iveVK72g6MIB2sQNs?=
 =?us-ascii?Q?3Txeq2oEgFOzf70CPv9UBQGWYWrPPc4RBxbnxVvB9VVk5EMa0SYdWL/gyMR/?=
 =?us-ascii?Q?tliY2Qr5utUy5VK0NTC19J/12HoyJigIF9d2+FRwLU0GST0Cm0q4UVRhptNC?=
 =?us-ascii?Q?No5sQ/9WtvX0z+iOoJdeNgfMA0zHs7GZ/dw6+fl7+vJvlObUUqIn9im9wF1h?=
 =?us-ascii?Q?g9wkLJuviRDP9y7ZEclO7pguTzYXEEarV0w4QCqkQ0aiBxN5fP9XQAkxzseH?=
 =?us-ascii?Q?FRD3b7LJclcr7ItrO0kjuSrjAMqvUM2hF+XAxaZAGSOMbbxNxhMlynPRtS9f?=
 =?us-ascii?Q?bCAWoquUrBzZKE1hQdh/9OItAsN6r39wRZSIv/B57dHI2N4ihy88k8QoQ8H8?=
 =?us-ascii?Q?96umqFQnd4F/ykTxctkcgxlKrpCsp3oRBU6khbW7nFYUpUI/0jUpKwnHEC6F?=
 =?us-ascii?Q?/T+pz3jSzbCW1ly8FVTUcHuEbTClSORqEe+cBAfI5apBqKhI67K4k8QKrakU?=
 =?us-ascii?Q?mgE0NEZNAdWnyt0bxxnQZbU4rme1BEJ3uhaDOWSsKyUyedc1NgbL7GB8vHY5?=
 =?us-ascii?Q?8+tHQ4rI1xE1/xIA8lGALRW5AOgkOothmT5Hx9oMLHkGKNJ38cxR/Fvkbcyi?=
 =?us-ascii?Q?jugf4yGK5yg67+oJvKkhbTqjxHrkwuCUL3kilP0SAWjHyZFO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14078976-07e1-4727-367d-08de57f615d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:32:37.2443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyzrqhyRzxaZY7hDsbXLHEwNJ3s94pj12ZGuDSSGirGhB+YVF1N7A6sgFuqBM6zShPWG3+NDzzjKcmT4DWYjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gfx-=
request@lists.freedesktop.org
Sent: Tuesday, January 20, 2026 1:12 PM
To: amd-gfx@lists.freedesktop.org
Subject: amd-gfx Digest, Vol 116, Issue 317

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific than "R=
e: Contents of amd-gfx digest..."


Today's Topics:

   1. Re: [PATCH 10/10] drm/amdgpu: rework ring reset backup and
      reemit (Timur Krist?f)
   2. [PATCH] drm/amdgpu: mark invalid records with U64_MAX
      (Gangliang Xie)
   3. RE: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
      (Zhou1, Tao)


----------------------------------------------------------------------

Message: 1
Date: Tue, 20 Jan 2026 03:41:02 +0100
From: Timur Krist?f <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Alex Deucher
        <alexander.deucher@amd.com>
Subject: Re: [PATCH 10/10] drm/amdgpu: rework ring reset backup and
        reemit
Message-ID: <27258781.1r3eYUQgxm@timur-max>
Content-Type: text/plain; charset=3D"utf-8"

On 2026. janu?r 16., p?ntek 17:20:27 k?z?p-eur?pai t?li id? Alex Deucher
wrote:
> Store the start and end wptrs in the IB fence. On queue reset, only
> save the ring contents of the non-guilty contexts.
> Since the VM fence is a sub-fence of the the IB fence, the IB fence
> stores the start and end wptrs for both fences as the IB state
> encapsulates the VM fence state.
>
> For reemit, only reemit the state for non-guilty contexts; for guilty
> contexts, just emit the fences.  Split the reemit per fence when when
> we reemit, update the start and end wptrs with the new values from
> reemit.  This allows us to reemit jobs repeatedly as the wptrs get
> properly updated each time.  Submitting the fence directly also
> simplifies the logic as we no longer need to store additional wptrs
> for each fence within the IB ring sequence.  If the context is guilty,
> we emit the fence(s) and if not, we reemit the whole IB ring sequence
> for that IB.
>

Hi Alex,

I have a few ideas that may help simplify this:

1. We could rework the pipeline sync so that it doesn't depend on the fence=
 of the previous submission, similarly to how you already did for gfx9.
- Then it becomes unnecessary to re-emit the guilty fence or track where th=
e fence was emitted.
- This also fixes queue reset for the case when the maximum scheduled submi=
ssions are greater than two.
- For those engines that do not have something like VS/PS/CS_PARTIAL_FLUSH =
and ACQUIRE_MEM, you can emit a fence + wait_reg inside the pipeline sync.

2. When backing up the ring contents, you could replace submissions that be=
long to the guilty process with NOPs, and remember the start position of th=
e first submission inside the ring buffer. When restoring, you can pad the =
ring buffer with NOPs until you get back to the same position.
- This way, all the pointers to things inside the ring will remain valid an=
d no extra logic is needed when re-emitting the same content repeatedly.

Hope this helps,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 37 +--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  1 +
>  5 files changed, 54 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> d48f61076c06a..541cdbe1e28bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>       return seq;
>  }
>
> -static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence
> *af) -{
> -     af->fence_wptr_start =3D af->ring->wptr;
> -}
> -
> -static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
> -{
> -     af->fence_wptr_end =3D af->ring->wptr;
> -}
> -
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -126,11 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
> struct amdgpu_fence *af, &ring->fence_drv.lock,
>                      adev->fence_context + ring->idx, seq);
>
> -     amdgpu_fence_save_fence_wptr_start(af);
> +     af->flags =3D flags | AMDGPU_FENCE_FLAG_INT;
>       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -                            seq, flags | AMDGPU_FENCE_FLAG_INT);
> -     amdgpu_fence_save_fence_wptr_end(af);
> -     amdgpu_fence_save_wptr(af);
> +                            seq, af->flags);
> +
>       pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>       ptr =3D &ring->fence_drv.fences[seq & ring-
>fence_drv.num_fences_mask];
>       if (unlikely(rcu_dereference_protected(*ptr, 1))) {  @@ -241,7
>+230,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>
>       do {
>               struct dma_fence *fence, **ptr;
> -             struct amdgpu_fence *am_fence;
>
>               ++last_seq;
>               last_seq &=3D drv->num_fences_mask;
> @@ -254,12 +242,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>               if (!fence)
>                       continue;
>
> -             /* Save the wptr in the fence driver so we know what
the last processed
> -              * wptr was.  This is required for re-emitting the ring
state for
> -              * queues that are reset but are not guilty and thus
have no guilty
> fence. -               */
> -             am_fence =3D container_of(fence, struct amdgpu_fence,
base);
> -             drv->signalled_wptr =3D am_fence->wptr;
>               dma_fence_signal(fence);
>               dma_fence_put(fence);
>               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,25 +709,27 @@ void amdgpu_fence_driver_force_completion(struct
> amdgpu_ring *ring, */
>
>  /**
> - * amdgpu_fence_driver_update_timedout_fence_state - Update fence
> state and set errors + * amdgpu_ring_set_fence_errors_and_reemit - Set
> dma_fence errors and reemit *
> - * @af: fence of the ring to update
> + * @guilty_fence: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_update_timedout_fence_state(struct
> amdgpu_fence
> *af) +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring
> *ring, +                                           struct
amdgpu_fence *guilty_fence)
>  {
>       struct dma_fence *unprocessed;
>       struct dma_fence __rcu **ptr;
>       struct amdgpu_fence *fence;
> -     struct amdgpu_ring *ring =3D af->ring;
>       unsigned long flags;
>       u32 seq, last_seq;
> -     bool reemitted =3D false;
> +     unsigned int i;
>
>       last_seq =3D amdgpu_fence_read(ring) & ring-
>fence_drv.num_fences_mask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>
>       /* mark all fences from the guilty context with an error */
> +     amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
> +                       20 * ring->guilty_fence_count);
>       spin_lock_irqsave(&ring->fence_drv.lock, flags);
>       do {
>               last_seq++;
> @@ -758,39 +742,41 @@ void
> amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence
> *af) if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
> fence =3D container_of(unprocessed, struct amdgpu_fence, base);
>
> -                     if (fence->reemitted > 1)
> -                             reemitted =3D true;
> -                     else if (fence =3D=3D af)
> +                     if (fence =3D=3D guilty_fence)
>                               dma_fence_set_error(&fence->base,
-ETIME);
> -                     else if (fence->context =3D=3D af->context)
> +                     else if (fence->context =3D=3D guilty_fence-
>context)
>                               dma_fence_set_error(&fence->base,
-ECANCELED);
> +
> +                     if (fence->context =3D=3D guilty_fence->context)
{
> +                             /* just emit the fence for the
guilty context */
> +                             amdgpu_ring_emit_fence(ring, ring-
>fence_drv.gpu_addr,
> +
fence->base.seqno, fence->flags);
> +                     } else {
> +                             /* reemit the packet stream and
update wptrs */
> +                             fence->wptr_start =3D ring->wptr;
> +                             for (i =3D 0; i < fence-
>backup_size; i++)
> +                                     amdgpu_ring_write(ring,
ring->ring_backup[fence->backup_idx + i]);
> +                             fence->wptr_end =3D ring->wptr;
> +                     }
>               }
>               rcu_read_unlock();
>       } while (last_seq !=3D seq);
>       spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -
> -     if (reemitted) {
> -             /* if we've already reemitted once then just cancel
everything */
> -             amdgpu_fence_driver_force_completion(af->ring, &af-
>base);
> -             af->ring->ring_backup_entries_to_copy =3D 0;
> -     }
> -}
> -
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af)  -{
> -     af->wptr =3D af->ring->wptr;
> +     amdgpu_ring_commit(ring);
>  }
>
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring
> *ring, -                                                 u64
start_wptr, u64 end_wptr)
> +                                                struct
amdgpu_fence *af)
>  {
> -     unsigned int first_idx =3D start_wptr & ring->buf_mask;
> -     unsigned int last_idx =3D end_wptr & ring->buf_mask;
> +     unsigned int first_idx =3D af->wptr_start & ring->buf_mask;
> +     unsigned int last_idx =3D af->wptr_end & ring->buf_mask;
>       unsigned int i;
>
>       /* Backup the contents of the ring buffer. */
> +     af->backup_idx =3D ring->ring_backup_entries_to_copy;
>       for (i =3D first_idx; i !=3D last_idx; ++i, i &=3D ring->buf_mask)
>               ring->ring_backup[ring->ring_backup_entries_to_copy++]
=3D ring->ring[i];
> +     af->backup_size =3D ring->ring_backup_entries_to_copy - af-
>backup_idx;
>  }
>
>  void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring
> *ring, @@ -799,13 +785,12 @@ void
> amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, struct dma_fence *unprocessed;
>       struct dma_fence __rcu **ptr;
>       struct amdgpu_fence *fence;
> -     u64 wptr;
>       u32 seq, last_seq;
>
>       last_seq =3D amdgpu_fence_read(ring) & ring-
>fence_drv.num_fences_mask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> -     wptr =3D ring->fence_drv.signalled_wptr;
>       ring->ring_backup_entries_to_copy =3D 0;
> +     ring->guilty_fence_count =3D 0;
>
>       do {
>               last_seq++;
> @@ -818,21 +803,12 @@ void
> amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, if (unprocessed &&
> !dma_fence_is_signaled(unprocessed))
> {
>                       fence =3D container_of(unprocessed, struct
amdgpu_fence, base);
>
> -                     /* save everything if the ring is not
guilty, otherwise
> -                      * just save the content from other
contexts.
> -                      */
> -                     if (!fence->reemitted &&
> -                         (!guilty_fence || (fence->context !=3D
guilty_fence->context))) {
> -
amdgpu_ring_backup_unprocessed_command(ring, wptr,
> -
       fence->wptr);
> -                     } else if (!fence->reemitted) {
> -                             /* always save the fence */
> -
amdgpu_ring_backup_unprocessed_command(ring,
> -
       fence->fence_wptr_start,
> -
       fence->fence_wptr_end);
> -                     }
> -                     wptr =3D fence->wptr;
> -                     fence->reemitted++;
> +                     /* keep track of the guilty fences for reemit
*/
> +                     if (fence->context =3D=3D guilty_fence->context)
> +                             ring->guilty_fence_count++;
> +                     /* Non-vm fence has all the state.  Backup
the non-guilty contexts */
> +                     if (!fence->is_vm_fence && (fence->context !=3D
guilty_fence->context))
> +
amdgpu_ring_backup_unprocessed_command(ring, fence);
>               }
>               rcu_read_unlock();
>       } while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c index
> fb58637ed1507..865a803026c3b
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -185,6 +185,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> struct amdgpu_job *job, dev_err(adev->dev, "scheduling IB failed (%d).\n"=
, r);
>               return r;
>       }
> +     af->wptr_start =3D ring->wptr;
>
>       need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
>       if (ring->funcs->emit_pipeline_sync && job && @@ -303,13 +304,7 @@
> int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job
> *job, ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
>               ring->funcs->emit_wave_limit(ring, false);
>
> -     /* Save the wptr associated with this fence.
> -      * This must be last for resets to work properly
> -      * as we need to save the wptr associated with this
> -      * fence so we know what rings contents to backup
> -      * after we reset the queue.
> -      */
> -     amdgpu_fence_save_wptr(af);
> +     af->wptr_end =3D ring->wptr;
>
>       amdgpu_ring_ib_end(ring);
>       amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c index
> b82357c657237..df37335127979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -104,29 +104,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring,
> unsigned int ndw) return 0;  }
>
> -/**
> - * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for
> reemit
> - *
> - * @ring: amdgpu_ring structure holding ring information
> - * @ndw: number of dwords to allocate in the ring buffer
> - *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * doesn't check the max_dw limit as we may be reemitting
> - * several submissions.
> - */
> -static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring,
> unsigned int
> ndw) -{
> -     /* Align requested size with padding so unlock_commit can
> -      * pad safely */
> -     ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> -
> -     ring->count_dw =3D ndw;
> -     ring->wptr_old =3D ring->wptr;
> -
> -     if (ring->funcs->begin_use)
> -             ring->funcs->begin_use(ring);
> -}
> -
>  /**
>   * amdgpu_ring_insert_nop - insert NOP packets
>   *
> @@ -877,7 +854,6 @@ void amdgpu_ring_reset_helper_begin(struct
> amdgpu_ring *ring, int amdgpu_ring_reset_helper_end(struct amdgpu_ring *r=
ing,
>                                struct amdgpu_fence
*guilty_fence)
>  {
> -     unsigned int i;
>       int r;
>
>       /* verify that the ring is functional */ @@ -885,16 +861,9 @@ int
> amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring, if (r)
>               return r;
>
> -     /* set an error on all fences from the context */
> -     if (guilty_fence)
> -
amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
> -     /* Re-emit the non-guilty commands */
> -     if (ring->ring_backup_entries_to_copy) {
> -             amdgpu_ring_alloc_reemit(ring, ring-
>ring_backup_entries_to_copy);
> -             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> -                     amdgpu_ring_write(ring, ring-
>ring_backup[i]);
> -             amdgpu_ring_commit(ring);
> -     }
> +     /* set an error on all fences from the context and reemit */
> +     amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
> +
>       /* Start the scheduler again */
>       drm_sched_wqueue_start(&ring->sched);
>       return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> ce095427611fb..6dca1ccd2fc2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
>       /* sync_seq is protected by ring emission lock */
>       uint32_t                        sync_seq;
>       atomic_t                        last_seq;
> -     u64                             signalled_wptr;
>       bool                            initialized;
>       struct amdgpu_irq_src           *irq_src;
>       unsigned                        irq_type;
> @@ -146,15 +145,17 @@ struct amdgpu_fence {
>       struct amdgpu_ring              *ring;
>       ktime_t                         start_timestamp;
>
> +     bool                            is_vm_fence;
> +     unsigned int                    flags;
>       /* wptr for the total submission for resets */
> -     u64                             wptr;
> +     u64                             wptr_start;
> +     u64                             wptr_end;
>       /* fence context for resets */
>       u64                             context;
> -     /* has this fence been reemitted */
> -     unsigned int                    reemitted;
> -     /* wptr for the fence for the submission */
> -     u64                             fence_wptr_start;
> -     u64                             fence_wptr_end;
> +     /* idx into the ring backup */
> +     unsigned int                    backup_idx;
> +     unsigned int                    backup_size;
> +
>  };
>
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops; @@ -162,8
> +163,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int
> error); void amdgpu_fence_driver_force_completion(struct
> amdgpu_ring *ring, struct dma_fence *timedout_fence); -void
> amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence
> *af); -void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +                                          struct
amdgpu_fence *guilty_fence);
>
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);  int
> amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring, @@ -314,6
> +315,7 @@ struct amdgpu_ring {
>       /* backups for resets */
>       uint32_t                *ring_backup;
>       unsigned int            ring_backup_entries_to_copy;
> +     unsigned int            guilty_fence_count;
>       unsigned                rptr_offs;
>       u64                     rptr_gpu_addr;
>       u32                     *rptr_cpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
> 6a2ea200d90c8..bd2c01b1ef18f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -848,6 +848,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
> struct amdgpu_job *job, r =3D amdgpu_fence_emit(ring, job->hw_vm_fence, 0=
);
>               if (r)
>                       return r;
> +             job->hw_vm_fence->is_vm_fence =3D true;
>               fence =3D &job->hw_vm_fence->base;
>               /* get a ref for the job */
>               dma_fence_get(fence);






------------------------------

Message: 2
Date: Tue, 20 Jan 2026 12:03:39 +0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Message-ID: <20260120040339.1086611-1-ganglxie@amd.com>
Content-Type: text/plain

set retired_page of invalid ras records to U64_MAX, and skip them when read=
ing ras records

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 0c84c7ab36d1..13d901c0ed6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2784,6 +2784,9 @@ static int amdgpu_ras_badpages_read(struct amdgpu_dev=
ice *adev,
                        if (!data->bps[i].ts)
                                continue;

+                       if (data->bps[i].retired_page =3D=3D U64_MAX)
+                               continue;
+
                        bps[r].bp =3D data->bps[i].retired_page;
                        r++;
                        if (r >=3D count)
@@ -3090,6 +3093,7 @@ static int __amdgpu_ras_restore_bad_pages(struct amdg=
pu_device *adev,

                if (amdgpu_ras_check_bad_page_unlock(con,
                        bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+                       data->bps[data->count].retired_page =3D U64_MAX;
                        data->count++;
                        data->space_left--;
                        continue;
--
2.34.1



------------------------------

Message: 3
Date: Tue, 20 Jan 2026 05:12:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Message-ID:
        <PH7PR12MB8796F233C5A112DD0B94A051B089A@PH7PR12MB8796.namprd12.prod=
.outlook.com>

Content-Type: text/plain; charset=3D"us-ascii"

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, January 20, 2026 12:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
>
> set retired_page of invalid ras records to U64_MAX, and skip them when
> reading ras records
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0c84c7ab36d1..13d901c0ed6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2784,6 +2784,9 @@ static int amdgpu_ras_badpages_read(struct
> amdgpu_device *adev,
>                       if (!data->bps[i].ts)
>                               continue;
>
> +                     if (data->bps[i].retired_page =3D=3D U64_MAX)
> +                             continue;

[Tao] the change is fine with me, it's better to add comment to explain U64=
_MAX is used as invalid flag.
With that fixed, the patch is:  Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

[Patrick] thanks, will add this comment
> +
>                       bps[r].bp =3D data->bps[i].retired_page;
>                       r++;
>                       if (r >=3D count)
> @@ -3090,6 +3093,7 @@ static int __amdgpu_ras_restore_bad_pages(struct
> amdgpu_device *adev,
>
>               if (amdgpu_ras_check_bad_page_unlock(con,
>                       bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
> +                     data->bps[data->count].retired_page =3D U64_MAX;
>                       data->count++;
>                       data->space_left--;
>                       continue;
> --
> 2.34.1



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 116, Issue 317
*****************************************
