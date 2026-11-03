Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CF606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oxPTIC7+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A432510E70A;
	Tue,  3 Nov 2026 02:23:53 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C5D10E70A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oivZpWocGY/0L5tDOVeXV2IB1FWRhhum0ivhGRiQsgI66/IKekzJ3BtpYgCgMOWUHd7MA9Gdik9cLSTdGVFjEXn0fF9FgCha4SijXa1HEWJ1jEe10fV1tsomaLME2QhIBsvQGQdwTOJxVbeotgs3mjaAumdDqyC87OVsv/KYRbj4b6WyYy24KEvdSUkeEABBaVWCcMn5GjkaxEuyHkEMCNFhx2No973RH+ClUbndmCXUiWMem6en7/2ZSqrvpyXEqFsHU1MhplapAyJOf3YGhLwzB1HJqmh7RYa1njzJzKdzpgU9i3IWgYxecJVBh7YEJ8ODYjYj9TPxxaEx17Ca/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgGSWKot7rbiOK5gPEWWkIC/vM/oSrO+BAjrd5uCJU8=;
 b=O5fB+LI8jh5TYuaIkcoPo/Lqu57hCkeIwNRIYSfO3Oj2dGZPA+lf5qgGzoUSm82+nKwXoQ0gbob1iid2QjrMPO3M1puxFiiG5KmWHqPFV6X5T/vyL2uZzb+er3TdHqg6gwwnabJMsWlCcWab0CCuZ6M6nBn+Z20yPs3G9QJvqDQQJg8eYa2XZpnO8eBxiIExFBcQIFkytKAWgFs5bmo9Em7ZehET1XKqyYk+/WlbyOEKPasRkCeRfLDNtk18t2eL6tTR1rIjozIDcTjj1QCx86YEeupQdkXjqfc1KJuwolFDOprPvcrpl7uY+ZzwgWDMFHUuTtCza1ITkAUJGOEYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgGSWKot7rbiOK5gPEWWkIC/vM/oSrO+BAjrd5uCJU8=;
 b=oxPTIC7+Isum6spT+OYNWgH8XRXC/YIPg6O22Q8GqEh5kVWHlXqzPCKX+p3kGDBipVZZLaTBwm0vQAE41tQXicD9WJ1qncbUkZx9UHOGBH+DVt7xZWWmBw4fnjcVQDOM7ojEYLnrtvGmXVatgSc1X8smmEvPJ+3inaBxE8bGJxU=
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 (2603:10b6:510:412::21) by DM4PR12MB6231.namprd12.prod.outlook.com
 (2603:10b6:8:a6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:23:42 +0000
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534]) by PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:23:42 +0000
From: "Mishra, Apurv" <Apurv.Mishra@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Bing"
 <Bing.Ma@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Welton,
 Benjamin" <Benjamin.Welton@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Topic: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Index: AQHdZXp2jWnHRxXIqE+TJf38F30kHLcU1oKAgAbRRHk=
Date: Tue, 3 Nov 2026 02:23:42 +0000
Message-ID: <PH9PR12MB135921425EE80A888620150F8D9F692@PH9PR12MB135921.namprd12.prod.outlook.com>
References: <20261026184707.103933-1-Apurv.Mishra@amd.com>
 <15edff8b-a5fc-428a-8e1c-7f0c5c5de3bd@amd.com>
In-Reply-To: <15edff8b-a5fc-428a-8e1c-7f0c5c5de3bd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: James.Zhu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T02:23:02.153Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH9PR12MB135921:EE_|DM4PR12MB6231:EE_
x-ms-office365-filtering-correlation-id: 1334cf0f-0106-461d-54ab-08df39517aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|10067099003|18002099003|22082099003|261102123227099003|8096899003|38070700021|56012099006|5023799004|11063799006|4143699003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261009223027099003|261009221227099003|261028144727099003|261021121427099003|261021123027099003;
x-microsoft-antispam-message-info: k2t6+rftKKbRFvie6Z/jCzxj0Gao0nTFlaKxzWPW4TSvwVPKGYXFGi/1V9i8f6OVk6NLDcqisXhjE4yAQjh4bQ4jcBYIR2gygdMSVfBHInORtGqJWD7jPaHRte0bH3w8O/QOAb+8DEO36ZovFodrJh0Lz9sZdx1ez8v+uA72E+UrWAgaSRShmAWMmqUMY+eVeHKmbByQyk88Ku8weO/uCof7xmFu75YghjRyX2DunZt0N3tGA1SaNtFVr8P1/zHCKpFy+JZFXh2zfig/ZGiH3zWcT8H8VLHl6rRuWL3lh2OFrEr1Ry2Rzbdi/cDUzh7TYaAqXEu91cMnASHOaRnSOjGyi6wGFFRHKLfZhmOFZHu2kCEp3jtn4QBjANQ9TkwSx2b2WgqSVvS4dV9/HcK+ER+3S43tmPLY4WyHBnU7oqr5b8uWbcfIuydebmAqmVSwVxPCC6pJTTgtbk0yMCLABDYUiVvl3K4Px+RHpSqyCE0aTngdBEt0M2M+riPxAdS04T1gJKjbCAj6ozhCr3Aa/wZoYEFxMOpTRiERPZOds5CSQDRrjVWaA/AUZkmbhYp7aDINR3D7OaHYiqIOOkdgl6fnR6mRW0dLO1VJarTDGa3Jo3ogzpOKwKAaQG4XH4k45yow9t4SlmsbLEC6LnNlWsKOE5QnT0o8MD+VUiQsrINheKhFqE3MY7JWqSt+BLGoxFJHpWJN9ldp3bL1cmu6qA0Age8ftqgsRBXgyi6WS0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH9PR12MB135921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(18002099003)(22082099003)(261102123227099003)(8096899003)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261009223027099003)(261009221227099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RbUtVroqAHwB38Sljc2vu+l70tptKZ3OEAjVR9dMtpZMzgo6pz6S5JMVWs?=
 =?iso-8859-1?Q?5c6n/olMQslAs9Z9xLRndzrxmN5tI5fmzMIpF7acBLhM0S0wDU79kF6iJN?=
 =?iso-8859-1?Q?tDNXTQYuaVyd0GbKVUYjD8OZzrSUwOwFHysLmVgyHKrllNA81dBsdfeo27?=
 =?iso-8859-1?Q?YnmYszEukNYJCC44B8+EyFfmkzVR7TpIqnHyKfDGnIqQxvb9Qi1RmTpKSG?=
 =?iso-8859-1?Q?0MJOCazFdDQ5VX02xrGsajocmi6dCR/zG/+n5J6Zzq4RX8PCFhOJ7BTE7L?=
 =?iso-8859-1?Q?GjhiZyuwEdhuMeSAs5HaAVCsRBLsV7AMiMfJKfUf0z8sCVgkUVcfs9mOnQ?=
 =?iso-8859-1?Q?cYDVF1SmO12jM72Yp+oPzoi7zoGO6PgFZviVPK3RVgv3PpUsNujt3Ww9Eu?=
 =?iso-8859-1?Q?GrSR3++7rykdYIW0AMlQ7yxkA11Eb8PAlswiCbKBtD8GwV87yNtinOXs6j?=
 =?iso-8859-1?Q?06vLZ7aEJw1oIcHkeuM719K9NIviB8aDw/uY680GIJbkHGJFWzDj/eWEuq?=
 =?iso-8859-1?Q?AmbkW7B+cwOPyZaSDDfMNwDsHe0FlNF1GDhdA/iM0lxqA8lcszEuef+evT?=
 =?iso-8859-1?Q?oWrjlsksXLAto4Zob+HmHm+ryIt92qSNHAUcatN/Z8wCgXhHSIt7KRkVoz?=
 =?iso-8859-1?Q?95eF0pLgyJT6aTuCgUuQ9GVahdIJBPsfrO7s/RNSKi/Lkd8U74RPPJGnwp?=
 =?iso-8859-1?Q?1kw8yLc99GVzw/IjKjFNETkPSOPikHm9c7ij0Gnru7XXL9motBeAFasWcq?=
 =?iso-8859-1?Q?NV4tKwvkUsBSMlQaJH3C90AazcsK+f8CFm9gzFELFp8g5QiLefIMTGNM9H?=
 =?iso-8859-1?Q?wH/sfJJrKpYZlOm31e5pFcnzRSjDKddIOgKrwhVsg0cRigxH5WlmBbHSob?=
 =?iso-8859-1?Q?2AuibyYeAPl3hyeDF6ZST5WSXTaifyzaouDxbENFq718TVlML0g2llfMRb?=
 =?iso-8859-1?Q?tOZDW2h2/WEujaltYUCFgOU+vCbz29P9zp6aU235Jbyu4bQmTPt7PT7M5Z?=
 =?iso-8859-1?Q?AXer6PeKNphbMS8K1DP3ao60C39f2xrWYpUEUVv9DWRIE7XsrMuxfCdSFM?=
 =?iso-8859-1?Q?L9i08ybq1Bt0EzBn9b2zTnN1r7N4hqG7n41ETndNhM42H1SWWsMrzmbJSs?=
 =?iso-8859-1?Q?tsTqS55bHBF5qIwX/rf7cD+DnfASxJEO4N5KxCydnVrZ1uNxOncW/RP2Jn?=
 =?iso-8859-1?Q?8GQjrkmxFFa68O9Zyh/mfDAwm83u2pf+Qfhg8oU2uYKhJ/WjA55gEE5eoc?=
 =?iso-8859-1?Q?CAUxF48/Nn9BknhUhRpLvN7PPjdw8ewSqt6yOGKrhV3S7222v5YKF8n4cI?=
 =?iso-8859-1?Q?eOQuJOAMqpXkH66h+m5MITRtH9Hao1HY4UfSyA91HbmTtnLI2DN8JL+3Az?=
 =?iso-8859-1?Q?Qbmuh5fP3e1SKcI6OabcilQIj3cGuLkDgO+/VqjwYxwidCVra4+zfPartt?=
 =?iso-8859-1?Q?dZH6+tz6W31BOfMe/+Ukv+QTA/9tobZxm0RoLD3f1OAPUm9b7oFcZfH4ac?=
 =?iso-8859-1?Q?ZvW7oTjBsN/BvX1iG9FKzsA9DcU5BricDy1fWsRSFde0JEhv8kP2gaM2jI?=
 =?iso-8859-1?Q?Ykv5QLxUdfyfyC9EYb8HunzYABAbac9OKOhEbils06OEwdBheMUfVP5LAw?=
 =?iso-8859-1?Q?/Zzc39E/gLo6Uj+VtYXnuQvQKQfkWrm/kuSDnmLTluGiyjBrmnbLgdEz2g?=
 =?iso-8859-1?Q?63R5XBYKh3YOFZ7+dbTmle9Bk1oONI8VDY05EVBtGdPzSe0Vh8ypahgzO9?=
 =?iso-8859-1?Q?mRZN3SAJwnn1tgcNyKNjPXats+nrAht/D6SlnGN3Hppnn6?=
Content-Type: multipart/alternative;
 boundary="_000_PH9PR12MB135921425EE80A888620150F8D9F692PH9PR12MB135921_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH9PR12MB135921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1334cf0f-0106-461d-54ab-08df39517aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 02:23:42.3053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6yI1v6ToyiMO0R1KeCuC4hsHF/sg1e5sdyz5tBKbWwPxiYb+L+j/f4zs8UB+lhbHcSltT+bz5lJqIs1Rnn4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_PH9PR12MB135921425EE80A888620150F8D9F692PH9PR12MB135921_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General


Thank you for reviewing, @Zhu, James<mailto:James.Zhu@amd.com>. I will send=
 a version 2 of this patch for review. Please, have a look.

Also, regarding your comments

  *
Yes, a lock holder that sends lock=3D0, perfcount_enable=3D1 now keeps its =
lock.
  *
Yes, aqlprofile writes COMPUTE_PERFCOUNT_ENABLE itself (Enable() in pmc_bui=
lder.h), so dispatch mode doesn't need set_perfcount().

Regards,
Apurv

________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Thursday, October 29, 2026 2:10 PM
To: Mishra, Apurv <Apurv.Mishra@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.c=
om>; Kuehling, Felix <Felix.Kuehling@amd.com>; Welton, Benjamin <Benjamin.W=
elton@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC re=
quests


On 2026-10-26 14:47, Apurv Mishra wrote:
> Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
> RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
> workaround (STABLE_STD) needs root and pins clocks.
>
> Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
> perfmon clock on per XCC, holds GFXOFF off while overridden, and
> restores the previous state on last release, resume and reset.
>
> Use it from KFD_IOC_PROFILER_PMC:
> - lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.
> - lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON needed,
>    held until process exit.
>
> No DPM change, no new ioctl, no struct change.
> Bump KFD_IOC_PROFILER_VERSION_NUM to 2.
>
> Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 79 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 30 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  5 ++
>   include/uapi/linux/kfd_ioctl.h             | 10 ++-
>   10 files changed, 198 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..551051c5e6d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2773,6 +2773,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu=
_device *adev)
>
>        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> +     amdgpu_gfx_perfmon_clk_restore(adev);
>
>        r =3D amdgpu_dpm_reapply_umd_profile(adev);
>        if (r) {
> @@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        mutex_init(&adev->srbm_mutex);
>        mutex_init(&adev->gfx.pipe_reserve_mutex);
>        mutex_init(&adev->gfx.gfx_off_mutex);
> +     mutex_init(&adev->gfx.perfmon_clk_mutex);
>        mutex_init(&adev->gfx.partition_mutex);
>        mutex_init(&adev->grbm_idx_mutex);
>        mutex_init(&adev->mn_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..b1b3fbb49a9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1015,6 +1015,85 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_d=
evice *adev, bool enable)
>        amdgpu_gfx_do_off_ctrl(adev, enable, true);
>   }
>
> +/* Force the perfmon clock on, or restore the saved state; @save records=
 the old one. */
> +static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
> +                                        bool force_on, bool save)
> +{
> +     int i, num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> +     amdgpu_gfx_off_ctrl(adev, false);
> +     for (i =3D 0; i < num_xcc; i++) {
> +             bool on =3D force_on || test_bit(i, &adev->gfx.perfmon_clk_=
restore_mask);
> +             bool in_safe_mode =3D adev->gfx.rlc.in_safe_mode[i];
> +             bool was_on;
> +
> +             if (!in_safe_mode)
> +                     amdgpu_gfx_rlc_enter_safe_mode(adev, i);
> +             was_on =3D adev->gfx.funcs->set_perfmon_clk_override(adev, =
i, on);
> +             if (!in_safe_mode)
> +                     amdgpu_gfx_rlc_exit_safe_mode(adev, i);
> +
> +             if (save)
> +                     assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, =
was_on);
> +     }
> +     amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
> +/*
> + * Refcounted override that keeps the perfmon clock on for profilers. Th=
e last
> + * put restores the previous state. GFXOFF is held off meanwhile, as a G=
FXOFF
> + * exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do =
it.
> + */
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool ena=
ble)
> +{
> +     int r =3D 0;
> +
> +     if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
> +         !adev->gfx.funcs->set_perfmon_clk_override)
> +             return -EOPNOTSUPP;
> +
> +     mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +     if (enable) {
> +             if (!adev->gfx.perfmon_clk_override_count++) {
> +                     amdgpu_gfx_off_ctrl(adev, false);
> +                     amdgpu_gfx_perfmon_clk_program(adev, true, true);
> +             }
> +     } else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
> +             r =3D -EINVAL;
> +     } else if (!--adev->gfx.perfmon_clk_override_count) {
> +             amdgpu_gfx_perfmon_clk_program(adev, false, false);
[JZ] amdgpu_gfx_off_ctrl() takes gfx_off_mutex and, on 0 <-> 1 transitions,
pm.mutex. That's fine while the clock gating side is lockless, but once
it takes perfmon_clk_mutex (see defer() below) we get a cycle: clock
gating runs under pm.mutex (amdgpu_dpm_reapply_umd_profile(),
smu_enable_umd_pstate()), giving pm.mutex -> perfmon_clk_mutex ->
gfx_off_mutex -> pm.mutex. Taking one GFXOFF reference per hold outside
perfmon_clk_mutex (before locking in get, after unlocking in put) avoids
that, and also makes the pair in program() unnecessary.

> +             amdgpu_gfx_off_ctrl(adev, true);
> +     }
> +     mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +
> +     return r;
> +}
> +
> +/*
> + * While overridden, record the requested state for the final restore in=
stead
> + * of programming it. Returns true if the caller must skip the register =
write.
> + */
> +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id=
, bool on)
> +{
> +     if (!READ_ONCE(adev->gfx.perfmon_clk_override_count))
> +             return false;
> [JZ] The count is read without perfmon_clk_mutex and the caller then does=
 an
> unlocked read-modify-write, so this races with the override whenever
> clock gating changes at runtime (power_dpm_force_performance_level, UMD
> profile reapply during reset/resume):
> - the CG path sees 0, the override programs ON, then the CG path writes
>    OFF: the override is held but the clock is gated;
> - count++ happens before program(save=3Dtrue) reads the old state, so a
>    request deferred in that window is overwritten by the stale value
>    (same window on the last release: count-- before the restore write).
>
> Suggest turning this into amdgpu_gfx_perfmon_clk_update(adev, xcc_id,
> on), which does the check and either the write or the deferral under
> perfmon_clk_mutex, and calling it from update_perf_clk().
>
> That still leaves the other read-modify-writes of RLC_CGTT_MGCG_OVERRIDE
> in the same CG sequence (MGCG, repeater/SRAM FGCG) unserialized against
> the override's write. Covering those would mean taking the same lock
> around *_update_gfx_clock_gating().
>
> +     assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
> +     return true;
> +}
> +
> +/* Re-apply the override after resume/reset reprogrammed clock gating. *=
/
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
> +{
> +     if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
> +             return;
> +
> +     mutex_lock(&adev->gfx.perfmon_clk_mutex);
> +     if (adev->gfx.perfmon_clk_override_count)
> +             amdgpu_gfx_perfmon_clk_program(adev, true, false);
> +     mutex_unlock(&adev->gfx.perfmon_clk_mutex);
> +}
> +
>   int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value=
)
>   {
>        int r =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..1690eb3e37bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
>                                 u32 queue, u32 vmid, u32 xcc_id);
>        void (*init_spm_golden)(struct amdgpu_device *adev);
>        void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enabl=
e);
> +     /* set the perfmon clock, returns its previous state */
> +     bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xc=
c_id,
> +                                      bool on);
>        int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
>                                   struct amdgpu_gfx_shadow_info *shadow_i=
nfo,
>                                   bool skip_check);
> @@ -503,6 +506,11 @@ struct amdgpu_gfx {
>        uint32_t                        gfx_off_residency;  /* last logged=
 residency */
>        uint64_t                        gfx_off_entrycount; /* count of ti=
mes GPU has get into GFXOFF state */
>
> +     /* perfmon clock override for profilers */
> +     struct mutex                    perfmon_clk_mutex;
> +     uint32_t                        perfmon_clk_override_count;
> +     unsigned long                   perfmon_clk_restore_mask; /* per XC=
C */
> +
>        /* pipe reservation */
>        struct mutex                    pipe_reserve_mutex;
>        DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_C=
OMPUTE_QUEUES);
> @@ -635,6 +643,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_devic=
e *adev,
>                                        u8 me_id, u8 pipe_id, u8 queue_id)=
;
>   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
>   void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool ena=
ble);
> +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool ena=
ble);
> +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id=
, bool on);
> +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
>   int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *val=
ue);
>   int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_com=
mon_if *ras_block);
>   void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_comm=
on_if *ras_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 315dfd806d56..0a80dacd0932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_d=
evice *adev, int xcc_id);
>   static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
>                                      bool enable);
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on);
>
>   static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint6=
4_t queue_mask)
>   {
> @@ -1147,6 +1149,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_=
funcs =3D {
>        .read_wave_vgprs =3D &gfx_v11_0_read_wave_vgprs,
>        .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
>        .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
> +     .set_perfmon_clk_override =3D &gfx_v11_0_set_perfmon_clk_override,
>        .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
>        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
>        .detect_hung_queue =3D &gfx_v11_0_detect_hung_queue,
> @@ -5499,23 +5502,32 @@ static void gfx_v11_0_unset_safe_mode(struct amdg=
pu_device *adev, int xcc_id)
>        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>
> -static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> -                                   bool enable)
> +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on)
>   {
>        uint32_t def, data;
>
> -     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -             return;
> -
>        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>
> -     if (enable)
> -             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> -     else
> +     if (on)
>                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> +     else
> +             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
>
>        if (def !=3D data)
>                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +     return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> +                                   bool enable)
> +{
> +     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +         amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
> +             return;
> +
> +     gfx_v11_0_set_perfmon_clk_override(adev, 0, !enable);
>   }
>
>   static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index d334fb805020..8774dfd64022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_d=
evice *adev, int xcc_id);
>   static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>   static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>                                      bool enable);
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on);
>
>   static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>                                        uint64_t queue_mask)
> @@ -957,6 +959,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_fu=
ncs =3D {
>        .select_me_pipe_q =3D &gfx_v12_0_select_me_pipe_q,
>        .detect_hung_queue =3D &gfx_v12_0_detect_hung_queue,
>        .update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
> +     .set_perfmon_clk_override =3D &gfx_v12_0_set_perfmon_clk_override,
>        .get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
>        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
>   };
> @@ -3938,23 +3941,32 @@ static void gfx_v12_0_unset_safe_mode(struct amdg=
pu_device *adev,
>        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
>   }
>
> -static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> -                                   bool enable)
> +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on)
>   {
>        uint32_t def, data;
>
> -     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -             return;
> -
>        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
>
> -     if (enable)
> -             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> -     else
> +     if (on)
>                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> +     else
> +             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
>
>        if (def !=3D data)
>                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
> +
> +     return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> +                                   bool enable)
> +{
> +     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +         amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
> +             return;
> +
> +     gfx_v12_0_set_perfmon_clk_override(adev, 0, !enable);
>   }
>
>   static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 1589fc6413af..0b9e41c26182 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -211,6 +211,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_d=
evice *adev,
>                                      bool enable);
>   static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
>                                         bool enable, int xcc_id);
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on);
>   static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device =
*adev);
>   static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>        struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
> @@ -746,6 +748,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_fu=
ncs =3D {
>        .read_wave_vgprs =3D &gfx_v12_1_read_wave_vgprs,
>        .select_me_pipe_q =3D &gfx_v12_1_select_me_pipe_q,
>        .update_perfmon_mgcg =3D &gfx_v12_1_update_perf_clk,
> +     .set_perfmon_clk_override =3D &gfx_v12_1_set_perfmon_clk_override,
>        .get_xccs_per_xcp =3D &gfx_v12_1_get_xccs_per_xcp,
>        .ih_node_to_logical_xcc =3D &gfx_v12_1_ih_to_xcc_inst,
>   };
> @@ -3155,23 +3158,32 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct=
 amdgpu_device *adev,
>                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OV=
ERRIDE, data);
>   }
>
> -static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> -                                       bool enable, int xcc_id)
> +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *ade=
v,
> +                                            int xcc_id, bool on)
>   {
>        uint32_t def, data;
>
> -     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
> -             return;
> -
>        def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGT=
T_MGCG_OVERRIDE);
>
> -     if (enable)
> -             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> -     else
> +     if (on)
>                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
> +     else
> +             data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
>
>        if (def !=3D data)
>                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OV=
ERRIDE, data);
> +
> +     return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
> +}
> +
> +static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
> +                                       bool enable, int xcc_id)
> +{
> +     if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
> +         amdgpu_gfx_perfmon_clk_defer(adev, xcc_id, !enable))
> +             return;
> +
> +     gfx_v12_1_set_perfmon_clk_override(adev, xcc_id, !enable);
>   }
>
>   static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *=
adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 6c710e4a5220..8e3104ce181a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3410,6 +3410,7 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,
>        if (op =3D=3D 1) {
>                if (!kfd->profiler_process) {
>                        kfd->profiler_process =3D p;
> +                     amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
[JZ]This now touches the hardware (SMU GFXOFF message, RLC registers), but
the pdd is looked up without kfd_bind_process_to_device(). pdds exist
for every GPU from kfd_init_apertures(), and the runtime PM reference is
only taken on bind, so on a runtime-suspended dGPU this programs a
suspended device (same for the put in kfd_process_destroy_pdds() when
the pdd was never bound). Suggest binding under p->mutex before taking
the override, here for op =3D=3D 1 and in kfd_profiler_perfmon_clk(). That
makes lock=3D1 return -ENODEV on a GPU whose VM was never acquired, which
seems reasonable.

>                        status =3D 0;
>                        mutex_unlock(&kfd->profiler_lock);
>                        if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_S=
UPPORTED) {
> @@ -3427,6 +3428,7 @@ static inline int profile_lock_device(struct kfd_pr=
ocess *p,
>                }
>        } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
>                kfd->profiler_process =3D NULL;
> +             amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
>                status =3D 0;
>                mutex_unlock(&kfd->profiler_lock);
>
> @@ -3444,6 +3446,30 @@ static inline int profile_lock_device(struct kfd_p=
rocess *p,
>        return status;
>   }
>
> +static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_=
id)
> +{
> +     struct kfd_process_device *pdd;
> +     struct kfd_dev *kfd;
> +     int r =3D 0;
> +
> +     mutex_lock(&p->mutex);
> +     pdd =3D kfd_process_device_data_by_id(p, gpu_id);
[JZ]Same binding comment as above.

> +     mutex_unlock(&p->mutex);
> +
> +     if (!pdd || !pdd->dev || !pdd->dev->kfd)
> +             return -EINVAL;
> +
> +     kfd =3D pdd->dev->kfd;
> +     mutex_lock(&kfd->profiler_lock);
> +     if (!pdd->perfmon_clk_req) {
> +             r =3D amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
> +             pdd->perfmon_clk_req =3D !r;
> +     }
[JZ]With a release path this could take an enable flag: if the pdd is
already in the requested state, return 0 for enable (idempotent) or
-ENOENT for disable; otherwise get or put.

This can also run while a GPU reset is in progress (KFD ioctls aren't
blocked during reset). If you guard it with reset_domain->sem, take it
before kfd->profiler_lock: post_reset -> kfd_resume() -> init_mqd()
takes profiler_lock with the reset lock held.

> +     mutex_unlock(&kfd->profiler_lock);
> +
> +     return r;
> +}
> +
>   static inline int kfd_profiler_pmc(struct kfd_process *p,
>                                   struct kfd_ioctl_pmc_settings *args)
>   {
> @@ -3451,6 +3477,10 @@ static inline int kfd_profiler_pmc(struct kfd_proc=
ess *p,
>        struct device_queue_manager *dqm;
>        int status;
>
> +     /* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON neede=
d */
> +     if (!args->lock && args->perfcount_enable)
> +             return kfd_profiler_perfmon_clk(p, args->gpu_id);
> [JZ]
> - For the current lock holder, lock=3D0/perfcount_enable=3D1 used to unlo=
ck
>    the device and enable perfcount; now it keeps the lock. Probably
>    unused, but worth stating.
> - In this mode perfcount_enable=3D1 no longer enables perfcount on the
>    queues (no set_perfcount(), compute_perfcount_enable stays 0 in the
>    MQD). I assume aqlprofile sets COMPUTE_PERFCOUNT_ENABLE itself?
>
> To add the release suggested above, please update this to:
>
>          if (!args->lock) {
>                  /* Dispatch mode: perfmon clock only, no lock, no CAP_PE=
RFMON needed */
>                  if (args->perfcount_enable)
>                          return kfd_profiler_perfmon_clk(p, args->gpu_id,=
 true);
>                  /* Drop a dispatch-mode hold first; without one, unlock =
as before */
>                  if (!kfd_profiler_perfmon_clk(p, args->gpu_id, false))
>                          return 0;
>          }
>
> with kfd_profiler_perfmon_clk() taking the enable flag described above
> and returning -ENOENT when there is no hold to drop, so the existing
> unlock path still runs (and still needs CAP_PERFMON).
>
>        /* Check if we have the correct permissions. */
>        if (!perfmon_capable())
>                return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index f0ce5fc4a138..f753ecae842f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -895,6 +895,8 @@ struct kfd_process_device {
>        u32 pasid;
>        /* Indicates this process has requested PTL stay disabled */
>        bool ptl_disable_req;
> +     /* Holds a perfmon clock override until the process exits */
> +     bool perfmon_clk_req;
>   };
>
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index ac18c2be6ecb..7a8da8d36962 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1180,6 +1180,11 @@ static void kfd_process_profiler_release(struct kf=
d_process *p, struct kfd_proce
>        if (pdd->dev->kfd->profiler_process =3D=3D p) {
>                pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>                pdd->dev->kfd->profiler_process =3D NULL;
> +             amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false)=
;
> +     }
> +     if (pdd->perfmon_clk_req) {
> +             amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false)=
;
> +             pdd->perfmon_clk_req =3D false;
>        }
>        mutex_unlock(&pdd->dev->kfd->profiler_lock);
>   }
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 564faefe6978..d7fb52c30df0 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,7 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
>        };
>   };
>
> -#define KFD_IOC_PROFILER_VERSION_NUM 1
> +/*
> + * KFD_IOC_PROFILER_VERSION_NUM history:
> + * - 1 - initial version
> + * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on unti=
l the
> + *       lock is released or the process exits. lock =3D=3D 0 with
> + *       perfcount_enable =3D=3D 1 forces it on without CAP_PERFMON and =
without
> + *       locking, until the process exits
> + */
> +#define KFD_IOC_PROFILER_VERSION_NUM 2
>   enum kfd_profiler_ops {
>        KFD_IOC_PROFILER_PMC =3D 0,
>        KFD_IOC_PROFILER_VERSION =3D 2,
>

--_000_PH9PR12MB135921425EE80A888620150F8D9F692PH9PR12MB135921_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<p class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 8pt; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for reviewing, <a href=3D"mailto:James.Zhu@amd.com" id=3D"OWAAM17=
9688" class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" style=3D"margin-top: 0px;=
 margin-bottom: 0px;">
@Zhu, James</a>. I will send a version 2 of this patch for review. Please, =
have a look.</p>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Also, regarding your comments</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:true}" style=
=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: disc;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<div class=3D"elementToProof" role=3D"presentation">Yes, a lock holder that=
 sends <i>
lock=3D0</i>, <i>perfcount_enable=3D1</i> now keeps its lock.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<div role=3D"presentation">Yes, <i>aqlprofile </i>writes COMPUTE_PERFCOUNT_=
ENABLE itself (<i>Enable()</i> in
<i>pmc_builder.h</i>), so dispatch mode doesn't need <i>set_perfcount()</i>=
.</div>
</li></ul>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 0px;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 0px;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Apurv</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 29, 2026 2:10 PM<br>
<b>To:</b> Mishra, Apurv &lt;Apurv.Mishra@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma, Bing &=
lt;Bing.Ma@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Wel=
ton, Benjamin &lt;Benjamin.Welton@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Force perfmon clock on for profiler=
 PMC requests
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;"><br>
On 2026-10-26 14:47, Apurv Mishra wrote:<br>
&gt; Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because<=
br>
&gt; RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing<=
br>
&gt; workaround (STABLE_STD) needs root and pins clocks.<br>
&gt;<br>
&gt; Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the<br>
&gt; perfmon clock on per XCC, holds GFXOFF off while overridden, and<br>
&gt; restores the previous state on last release, resume and reset.<br>
&gt;<br>
&gt; Use it from KFD_IOC_PROFILER_PMC:<br>
&gt; - lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.<br>
&gt; - lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON neede=
d,<br>
&gt;&nbsp;&nbsp;&nbsp; held until process exit.<br>
&gt;<br>
&gt; No DPM change, no new ioctl, no struct change.<br>
&gt; Bump KFD_IOC_PROFILER_VERSION_NUM to 2.<br>
&gt;<br>
&gt; Signed-off-by: Apurv Mishra &lt;Apurv.Mishra@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp; =
| 79 ++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp; =
| 11 +++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 28 +++++---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 28 +++++---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 28 +++++---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp; | 30 =
++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp; |&nbs=
p; 5 ++<br>
&gt;&nbsp;&nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++-<br>
&gt;&nbsp;&nbsp; 10 files changed, 198 insertions(+), 25 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 5069042b5279..551051c5e6d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2773,6 +2773,7 @@ static int amdgpu_device_ip_late_init(struct amd=
gpu_device *adev)<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(a=
dev, AMD_CG_STATE_GATE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(a=
dev, AMD_PG_STATE_GATE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_clk_restore(adev);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_reapply_umd=
_profile(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; @@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;srb=
m_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx=
.pipe_reserve_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx=
.gfx_off_mutex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.perfmon_clk_mut=
ex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx=
.partition_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;grb=
m_idx_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;mn_=
lock);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c<br>
&gt; index 0ae6e990c310..b1b3fbb49a9c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; @@ -1015,6 +1015,85 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgp=
u_device *adev, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_do_off_ctrl(adev,=
 enable, true);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +/* Force the perfmon clock on, or restore the saved state; @save reco=
rds the old one. */<br>
&gt; +static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bool force_on, bool save)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i, num_xcc =3D NUM_XCC(adev-&gt;gfx.xcc_=
mask);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool on =3D force_on || test_bit(i, &amp;adev-&gt;gfx.perfmon_clk_resto=
re_mask);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool in_safe_mode =3D adev-&gt;gfx.rlc.in_safe_mode[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool was_on;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!in_safe_mode)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_sa=
fe_mode(adev, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; was_on =3D adev-&gt;gfx.funcs-&gt;set_perfmon_clk_override(adev, i, on)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!in_safe_mode)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_saf=
e_mode(adev, i);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (save)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; assign_bit(i, &amp;adev=
-&gt;gfx.perfmon_clk_restore_mask, was_on);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Refcounted override that keeps the perfmon clock on for profilers.=
 The last<br>
&gt; + * put restores the previous state. GFXOFF is held off meanwhile, as =
a GFXOFF<br>
&gt; + * exit restores the register. Returns -EOPNOTSUPP if the ASIC can't =
do it.<br>
&gt; + */<br>
&gt; +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool =
enable)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || !adev-&gt;gfx.f=
uncs ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.funcs-=
&gt;set_perfmon_clk_override)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mut=
ex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;gfx.perfmon_clk_override_count++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(ade=
v, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_clk_=
program(adev, true, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (WARN_ON_ONCE(!adev-&gt;gfx.perfmo=
n_clk_override_count)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (!--adev-&gt;gfx.perfmon_clk_overr=
ide_count) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_perfmon_clk_program(adev, false, false);<br>
[JZ] amdgpu_gfx_off_ctrl() takes gfx_off_mutex and, on 0 &lt;-&gt; 1 transi=
tions,<br>
pm.mutex. That's fine while the clock gating side is lockless, but once<br>
it takes perfmon_clk_mutex (see defer() below) we get a cycle: clock<br>
gating runs under pm.mutex (amdgpu_dpm_reapply_umd_profile(),<br>
smu_enable_umd_pstate()), giving pm.mutex -&gt; perfmon_clk_mutex -&gt;<br>
gfx_off_mutex -&gt; pm.mutex. Taking one GFXOFF reference per hold outside<=
br>
perfmon_clk_mutex (before locking in get, after unlocking in put) avoids<br=
>
that, and also makes the pair in program() unnecessary.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_off_ctrl(adev, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_m=
utex);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * While overridden, record the requested state for the final restore=
 instead<br>
&gt; + * of programming it. Returns true if the caller must skip the regist=
er write.<br>
&gt; + */<br>
&gt; +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc=
_id, bool on)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!READ_ONCE(adev-&gt;gfx.perfmon_clk_over=
ride_count))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; [JZ] The count is read without perfmon_clk_mutex and the caller then d=
oes an<br>
&gt; unlocked read-modify-write, so this races with the override whenever<b=
r>
&gt; clock gating changes at runtime (power_dpm_force_performance_level, UM=
D<br>
&gt; profile reapply during reset/resume):<br>
&gt; - the CG path sees 0, the override programs ON, then the CG path write=
s<br>
&gt;&nbsp;&nbsp;&nbsp; OFF: the override is held but the clock is gated;<br=
>
&gt; - count++ happens before program(save=3Dtrue) reads the old state, so =
a<br>
&gt;&nbsp;&nbsp;&nbsp; request deferred in that window is overwritten by th=
e stale value<br>
&gt;&nbsp;&nbsp;&nbsp; (same window on the last release: count-- before the=
 restore write).<br>
&gt;<br>
&gt; Suggest turning this into amdgpu_gfx_perfmon_clk_update(adev, xcc_id,<=
br>
&gt; on), which does the check and either the write or the deferral under<b=
r>
&gt; perfmon_clk_mutex, and calling it from update_perf_clk().<br>
&gt;<br>
&gt; That still leaves the other read-modify-writes of RLC_CGTT_MGCG_OVERRI=
DE<br>
&gt; in the same CG sequence (MGCG, repeater/SRAM FGCG) unserialized agains=
t<br>
&gt; the override's write. Covering those would mean taking the same lock<b=
r>
&gt; around *_update_gfx_clock_gating().<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; assign_bit(xcc_id, &amp;adev-&gt;gfx.perfmon=
_clk_restore_mask, on);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Re-apply the override after resume/reset reprogrammed clock gating=
. */<br>
&gt; +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.funcs || !adev-&gt;gfx.fun=
cs-&gt;set_perfmon_clk_override)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.perfmon_clk_mut=
ex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.perfmon_clk_override_count)=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_perfmon_clk_program(adev, true, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;gfx.perfmon_clk_m=
utex);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; int amdgpu_set_gfx_off_residency(struct amdgpu_device *ade=
v, bool value)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.h<br>
&gt; index 5939e1fb3b24..1690eb3e37bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; @@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 queue, u32 vmid, u32 xcc=
_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*init_spm_golden)(stru=
ct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_perfmon_mgcg)(=
struct amdgpu_device *adev, bool enable);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* set the perfmon clock, returns its previo=
us state */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool (*set_perfmon_clk_override)(struct amdg=
pu_device *adev, int xcc_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool on);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_gfx_shadow_info)(s=
truct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gf=
x_shadow_info *shadow_info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool skip_check)=
;<br>
&gt; @@ -503,6 +506,11 @@ struct amdgpu_gfx {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_residency;&nbsp; /* las=
t logged residency */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_off_entrycount; /* count of=
 times GPU has get into GFXOFF state */<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* perfmon clock override for profilers */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; perfmon_clk_mutex;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; perfmon_clk_override_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; perfmon_clk_restore_mask; /* per XCC */<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pipe reservation */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pipe_reserve_mutex;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);<br>
&gt; @@ -635,6 +643,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; u8 me_id, u8 pipe_id, u8 queue_id);<br>
&gt;&nbsp;&nbsp; void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool =
enable);<br>
&gt;&nbsp;&nbsp; void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *a=
dev, bool enable);<br>
&gt; +int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool =
enable);<br>
&gt; +bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc=
_id, bool on);<br>
&gt; +void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, =
uint32_t *value);<br>
&gt;&nbsp;&nbsp; int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, s=
truct ras_common_if *ras_block);<br>
&gt;&nbsp;&nbsp; void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, st=
ruct ras_common_if *ras_block);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c<br>
&gt; index 315dfd806d56..0a80dacd0932 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt; @@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgp=
u_device *adev, int xcc_id);<br>
&gt;&nbsp;&nbsp; static void gfx_v11_0_userq_priv_fault_work(struct work_st=
ruct *work);<br>
&gt;&nbsp;&nbsp; static void gfx_v11_0_update_perf_clk(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool enable);<br>
&gt; +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static void gfx11_kiq_set_resources(struct amdgpu_ring *ki=
q_ring, uint64_t queue_mask)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1147,6 +1149,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_g=
fx_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;gf=
x_v11_0_read_wave_vgprs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp;g=
fx_v11_0_select_me_pipe_q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &am=
p;gfx_v11_0_update_perf_clk,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gfx_v11_0=
_set_perfmon_clk_override,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gfx_shadow_info =3D &am=
p;gfx_v11_0_get_gfx_shadow_info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hdp_flush_mask =3D &amp=
;amdgpu_gfx_get_hdp_flush_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .detect_hung_queue =3D &amp;=
gfx_v11_0_detect_hung_queue,<br>
&gt; @@ -5499,23 +5502,32 @@ static void gfx_v11_0_unset_safe_mode(struct a=
mdgpu_device *adev, int xcc_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_S=
AFE_MODE, RLC_SAFE_MODE__CMD_MASK);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<b=
r>
&gt; +static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC1=
5(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_M=
ASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__=
PERFMON_CLOCK_STATE_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<b=
r>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_c=
lk_defer(adev, 0, !enable))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v11_0_set_perfmon_clk_override(adev, 0, =
!enable);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static void gfx_v11_0_update_sram_fgcg(struct amdgpu_devic=
e *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v12_0.c<br>
&gt; index d334fb805020..8774dfd64022 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
&gt; @@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgp=
u_device *adev, int xcc_id);<br>
&gt;&nbsp;&nbsp; static void gfx_v12_0_userq_priv_fault_work(struct work_st=
ruct *work);<br>
&gt;&nbsp;&nbsp; static void gfx_v12_0_update_perf_clk(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool enable);<br>
&gt; +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring=
 *kiq_ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; uint64_t queue_mask)<br>
&gt; @@ -957,6 +959,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp;g=
fx_v12_0_select_me_pipe_q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .detect_hung_queue =3D &amp;=
gfx_v12_0_detect_hung_queue,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &am=
p;gfx_v12_0_update_perf_clk,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gfx_v12_0=
_set_perfmon_clk_override,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gfx_shadow_info =3D &am=
p;gfx_v12_0_get_gfx_shadow_info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hdp_flush_mask =3D &amp=
;amdgpu_gfx_get_hdp_flush_mask,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; @@ -3938,23 +3941,32 @@ static void gfx_v12_0_unset_safe_mode(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_S=
AFE_MODE, RLC_SAFE_MODE__CMD_MASK);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<b=
r>
&gt; +static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC1=
5(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_M=
ASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__=
PERFMON_CLOCK_STATE_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<b=
r>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_c=
lk_defer(adev, 0, !enable))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_0_set_perfmon_clk_override(adev, 0, =
!enable);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static void gfx_v12_0_update_spm_vmid(struct amdgpu_device=
 *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v12_1.c<br>
&gt; index 1589fc6413af..0b9e41c26182 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
&gt; @@ -211,6 +211,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgp=
u_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool enable);<br>
&gt;&nbsp;&nbsp; static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool enable, int xcc_id);<br>
&gt; +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on);<br>
&gt;&nbsp;&nbsp; static int gfx_v12_1_init_cp_compute_microcode_bo(struct a=
mdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; static void gfx_v12_1_xcc_update_medium_grain_clock_gating=
(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, =
bool enable, int xcc_id, bool force);<br>
&gt; @@ -746,6 +748,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_vgprs =3D &amp;gf=
x_v12_1_read_wave_vgprs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp;g=
fx_v12_1_select_me_pipe_q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .update_perfmon_mgcg =3D &am=
p;gfx_v12_1_update_perf_clk,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .set_perfmon_clk_override =3D &amp;gfx_v12_1=
_set_perfmon_clk_override,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_xccs_per_xcp =3D &amp;g=
fx_v12_1_get_xccs_per_xcp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ih_node_to_logical_xcc =3D =
&amp;gfx_v12_1_ih_to_xcc_inst,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; @@ -3155,23 +3158,32 @@ static void gfx_v12_1_xcc_update_sram_fgcg(str=
uct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG=
_OVERRIDE, data);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; -static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; bool enable, int xcc_id)<br>
&gt; +static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *=
adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, bool on)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC1=
5(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);<br>
&gt;&nbsp;&nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (on)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_M=
ASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG=
_OVERRIDE, data);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return !!(def &amp; RLC_CGTT_MGCG_OVERRIDE__=
PERFMON_CLOCK_STATE_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; bool enable, int xcc_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; AMD_CG_SUPPORT=
_GFX_PERF_CLK) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_c=
lk_defer(adev, xcc_id, !enable))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_1_set_perfmon_clk_override(adev, xcc=
_id, !enable);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; static int gfx_v12_1_xcc_update_gfx_clock_gating(struct am=
dgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index 6c710e4a5220..8e3104ce181a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -3410,6 +3410,7 @@ static inline int profile_lock_device(struct kfd=
_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op =3D=3D 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;profiler_process) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt=
;profiler_process =3D p;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_perfmon_clk_=
override(kfd-&gt;adev, true);<br>
[JZ]This now touches the hardware (SMU GFXOFF message, RLC registers), but<=
br>
the pdd is looked up without kfd_bind_process_to_device(). pdds exist<br>
for every GPU from kfd_init_apertures(), and the runtime PM reference is<br=
>
only taken on bind, so on a runtime-suspended dGPU this programs a<br>
suspended device (same for the put in kfd_process_destroy_pdds() when<br>
the pdd was never bound). Suggest binding under p-&gt;mutex before taking<b=
r>
the override, here for op =3D=3D 1 and in kfd_profiler_perfmon_clk(). That<=
br>
makes lock=3D1 return -ENODEV on a GPU whose VM was never acquired, which<b=
r>
seems reasonable.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =
=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_u=
nlock(&amp;kfd-&gt;profiler_lock);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ptl=
-&gt;hw_supported_state =3D=3D AMDGPU_PTL_HW_SUPPORTED) {<br>
&gt; @@ -3427,6 +3428,7 @@ static inline int profile_lock_device(struct kfd=
_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (op =3D=3D 0 &amp;=
&amp; kfd-&gt;profiler_process =3D=3D p) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfd-&gt;profiler_process =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; status =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd-&gt;profiler_lock);<br>
&gt;&nbsp;&nbsp;<br>
&gt; @@ -3444,6 +3446,30 @@ static inline int profile_lock_device(struct kf=
d_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt; +static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t g=
pu_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;mutex);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D kfd_process_device_data_by_id(p, gpu=
_id);<br>
[JZ]Same binding comment as above.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd || !pdd-&gt;dev || !pdd-&gt;dev-&gt=
;kfd)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfd =3D pdd-&gt;dev-&gt;kfd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd-&gt;profiler_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;perfmon_clk_req) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_gfx_perfmon_clk_override(kfd-&gt;adev, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pdd-&gt;perfmon_clk_req =3D !r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
[JZ]With a release path this could take an enable flag: if the pdd is<br>
already in the requested state, return 0 for enable (idempotent) or<br>
-ENOENT for disable; otherwise get or put.<br>
<br>
This can also run while a GPU reset is in progress (KFD ioctls aren't<br>
blocked during reset). If you guard it with reset_domain-&gt;sem, take it<b=
r>
before kfd-&gt;profiler_lock: post_reset -&gt; kfd_resume() -&gt; init_mqd(=
)<br>
takes profiler_lock with the reset lock held.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd-&gt;profiler_lock);<br=
>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static inline int kfd_profiler_pmc(struct kfd_process *p,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl=
_pmc_settings *args)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -3451,6 +3477,10 @@ static inline int kfd_profiler_pmc(struct kfd_p=
rocess *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_queue_manager =
*dqm;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<br>
&gt;&nbsp;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Dispatch mode: perfmon clock only, no loc=
k, no CAP_PERFMON needed */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!args-&gt;lock &amp;&amp; args-&gt;perfc=
ount_enable)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return kfd_profiler_perfmon_clk(p, args-&gt;gpu_id);<br>
&gt; [JZ]<br>
&gt; - For the current lock holder, lock=3D0/perfcount_enable=3D1 used to u=
nlock<br>
&gt;&nbsp;&nbsp;&nbsp; the device and enable perfcount; now it keeps the lo=
ck. Probably<br>
&gt;&nbsp;&nbsp;&nbsp; unused, but worth stating.<br>
&gt; - In this mode perfcount_enable=3D1 no longer enables perfcount on the=
<br>
&gt;&nbsp;&nbsp;&nbsp; queues (no set_perfcount(), compute_perfcount_enable=
 stays 0 in the<br>
&gt;&nbsp;&nbsp;&nbsp; MQD). I assume aqlprofile sets COMPUTE_PERFCOUNT_ENA=
BLE itself?<br>
&gt;<br>
&gt; To add the release suggested above, please update this to:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!args-&gt;lo=
ck) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Dispatch mode: perfmon clock only, no lo=
ck, no CAP_PERFMON needed */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;perfcount_enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return kfd_profiler_perfmon_clk(p, args-&gt;gpu_id, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Drop a dispatch-mode hold first; without=
 one, unlock as before */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd_profiler_perfmon_clk(p, args-&gt;g=
pu_id, false))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; with kfd_profiler_perfmon_clk() taking the enable flag described above=
<br>
&gt; and returning -ENOENT when there is no hold to drop, so the existing<b=
r>
&gt; unlock path still runs (and still needs CAP_PERFMON).<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if we have the corr=
ect permissions. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!perfmon_capable())<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index f0ce5fc4a138..f753ecae842f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -895,6 +895,8 @@ struct kfd_process_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates this process ha=
s requested PTL stay disabled */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ptl_disable_req;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Holds a perfmon clock override until the =
process exits */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool perfmon_clk_req;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp; #define qpd_to_pdd(x) container_of(x, struct kfd_process_d=
evice, qpd)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c<br>
&gt; index ac18c2be6ecb..7a8da8d36962 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -1180,6 +1180,11 @@ static void kfd_process_profiler_release(struct=
 kfd_process *p, struct kfd_proce<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd-&gt;=
profiler_process =3D=3D p) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.dqm-&gt;ops.set_perfcount(pdd-&gt;qpd.dqm, =
0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;kfd-&gt;profiler_process =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_perfmon_clk_override(pdd-&gt;dev-&gt;kfd-&gt;adev, false);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;perfmon_clk_req) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gfx_perfmon_clk_override(pdd-&gt;dev-&gt;kfd-&gt;adev, false);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pdd-&gt;perfmon_clk_req =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;de=
v-&gt;kfd-&gt;profiler_lock);<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_i=
octl.h<br>
&gt; index 564faefe6978..d7fb52c30df0 100644<br>
&gt; --- a/include/uapi/linux/kfd_ioctl.h<br>
&gt; +++ b/include/uapi/linux/kfd_ioctl.h<br>
&gt; @@ -1558,7 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;<br>
&gt; -#define KFD_IOC_PROFILER_VERSION_NUM 1<br>
&gt; +/*<br>
&gt; + * KFD_IOC_PROFILER_VERSION_NUM history:<br>
&gt; + * - 1 - initial version<br>
&gt; + * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on u=
ntil the<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock is released or the proces=
s exits. lock =3D=3D 0 with<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perfcount_enable =3D=3D 1 forc=
es it on without CAP_PERFMON and without<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locking, until the process exi=
ts<br>
&gt; + */<br>
&gt; +#define KFD_IOC_PROFILER_VERSION_NUM 2<br>
&gt;&nbsp;&nbsp; enum kfd_profiler_ops {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_PROFILER_PMC =3D 0,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_PROFILER_VERSION =3D=
 2,<br>
&gt;<br>
</div>
</body>
</html>

--_000_PH9PR12MB135921425EE80A888620150F8D9F692PH9PR12MB135921_--
