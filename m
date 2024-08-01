Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC8EC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016E110E8AE;
	Thu,  1 Aug 2024 07:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I98ZK5ou";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0209D10E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoeWNe/00qM9cypkUjauRMbidGSoQ/V2u95owmHT2Z0/YnTz01FfU0C88WpWQ/Xkj/SHLqGeRq6InNbY+AI0zQVisncETfrwQR82Ndf4BbX5e9D46V29QuB90v8l5FQthIdkLBmxSQh8Mhz//i5FBSjwDPq9nuCD7X1dbLtRoCq/uqai4CvV9QOzsl4jVCkeUU2olNp0duJJKaEQWqr/FS1OaAihUHhnToOWMHmdMwdJrukMnF6zF0xtRl8Ce/BU11y8qa7WsUQS3YMsmiFR7gmVP0+bsDTFrRiL/9hp5TeeIcvkeiT/gcVbHL9ZcBZ/pXh4Oqx7R53tWCjLDPtdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF9yd/F0iQBSAizjUDsLSTcwJquWPi1M28Je1K7wBxk=;
 b=DytYZ8IuI3nBaP3fWumQujC0vuziQ9krDgJW8w+ueZ5zMazehJiMU63R9AKFUI0KzhaljsFWzWvWNDUTZeQXl0JRAYbDHzszEwbJz8rNqBXFcT4PgJzXBvwJE5g52Tooaa4H2Eh0W9mt7gHJ/7XMRZ53/MHR00K/ZGI0JsPNkqq2KJcK3Ch2ItBcpJgzlKzXAEp/pXL46niaPPGPflJR5taSBN+1xPPhJi0ZXOhjsrBfc2aS7wQ/96AFmkI6p2wrQJDfhp8Bv4Ex7rxfZpKQ5/BBn8NGR6U0G1cK1cvVV6r0okkS6Ak8FDd5nF+/OIRIA8ilm70XMBPQUu7l/zFxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF9yd/F0iQBSAizjUDsLSTcwJquWPi1M28Je1K7wBxk=;
 b=I98ZK5ouwKfFRKPBJpH3K7QR1x7pAI4NsC/5KTezQdri/6M9XZNyIJLyZVmGqsosxJSf3ln+Q9/dyZjRiT6+ANEQpqwG+ICgXwxGHVv69uY9hSX1yVUT0CWZpbneFTsb+afZXpJZyyZSPj2/g9oDutIzxvTyFdVppydgg206zJA=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 1 Aug 2024 07:57:43 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 07:57:43 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Huang, Trigger" <Trigger.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Huang, Trigger" <Trigger.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: save the funcs of gfx software rings
Thread-Topic: [PATCH] drm/amdgpu: save the funcs of gfx software rings
Thread-Index: AQHa4+Rax2gBIbZr50GwzLfvK51ZBbISB5Rg
Date: Thu, 1 Aug 2024 07:57:43 +0000
Message-ID: <DS7PR12MB6333C189AE205B7A6C581B58F4B22@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240801072723.1193504-1-Trigger.Huang@amd.com>
In-Reply-To: <20240801072723.1193504-1-Trigger.Huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8b55ab2e-e4a3-448b-8276-640d80fa2f4c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T07:51:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|PH7PR12MB5593:EE_
x-ms-office365-filtering-correlation-id: 908c62cf-c6b9-43d2-d55a-08dcb1ff9f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BlrGuo8/J654LXhmVrCTceTRW3yFFGrZm9La1sqcwO6a7gOtnbSTbAgGCsre?=
 =?us-ascii?Q?CrIwVfCHs1pkdwbM8pgrOYn1dhYNe5DVsfjcwq/bIF/xvbKt/tju5mtyPoAk?=
 =?us-ascii?Q?NMM4rheDLnSibBX7GfpO4yovlWd0PT933JZYAF+yl8eX17z2GgQ7STCP6lbB?=
 =?us-ascii?Q?Wf9pEU1JMlQ5VYoQe2Ert6dZ6/kSp+EXuDZvCnPGnV+ycAv21efiMk/D3hcc?=
 =?us-ascii?Q?8F6VeBAwfisUpWJJ0RBPabvWziwykEf+2WeXZIVnFPziArxHtvtSsDFpc6jD?=
 =?us-ascii?Q?Ro0HcvCA25SiErSqBnoDxOvbYAPz22C11N29UsviaJ9AWYVNaYUIDPFYK8Fb?=
 =?us-ascii?Q?gFqMHlVrq8AhO1IjnmJrkSE8R3y5BIx+lrHlnoSy8vTTV5P9vircdyKL9+SD?=
 =?us-ascii?Q?U1BbYCZsJBOo+rveWWeX6MBMOQDTE4wN/vvHN4bONx+SReRygrdNcHJMzswQ?=
 =?us-ascii?Q?3KdTsUBgNucl2iK4bq4jjGiyt8UjrrI1KF+w7Of86l/13CJ/1NJgVZ0hgLWB?=
 =?us-ascii?Q?6ftDKgV5jv9eseR/ggGp58ccB9YvlTqvcMknoIfWQEYb0B4LoUFb5C7vcMqw?=
 =?us-ascii?Q?u/Nke1rT//FwJhwsO3LDvawpCSucLUlAHu0unpHABUyreZQnvzb00zhSUFHg?=
 =?us-ascii?Q?vCBjxk9E1GlXiosOLA7FY9gaVYZBKuYd5SHGnrJbfBmGYMpfk0/c+cjRqyUt?=
 =?us-ascii?Q?OFnxJofH1/vNgneLfHMS3CEHYKqnFvJhOb8qJtapBpwI/bBzvdRBwqSiUzHm?=
 =?us-ascii?Q?a7aAOq/plEtW4Qn2VVMPdvazOtJC6YSqjjJRYexC1O2bo4FjTmdhhiIYMdHy?=
 =?us-ascii?Q?M4OfpRnEAInv/kLEdWFC8f38gcocxAtOBC+wbAKYjWQ1YdISyjpAZ7NxEumo?=
 =?us-ascii?Q?fNIBJO1Vz/4Ws5ga3xvGh2j6twkGhuGaE9SIZT4rvPgcXykvM5Hcixm3W9gl?=
 =?us-ascii?Q?HPmLoZrDODqVOl3smXeTPmkK+oNLfzglW58AV60NkTinrtMHEVaJGi3zURW6?=
 =?us-ascii?Q?LGLoKJszZ5iGlaw0T+10LH1Rmt0v86Nsua+jbt875ubWFevSCRgpw5OthVVH?=
 =?us-ascii?Q?RsY1f2jOJdcA3tTpV3/NOVlv2eH5xtx2U2ONpExA+AezdmnoG1OVxwpOYeOT?=
 =?us-ascii?Q?Suf80y2QT05Va1cylIDtwLjqMTbM7RFpFULbsDhAv0pnjmTG0jSa6WryOFiY?=
 =?us-ascii?Q?YHJdqd6g5QZSle4b9191PSMbR5cj30G9Lily+D6hLF3ezA/HvAnzUFO9EgjD?=
 =?us-ascii?Q?Cc3dKdqlu2jTkxWvbuxv/MRVGEGfquSF+OIBTyg9OqO63MbjvpmY2sc2ITXu?=
 =?us-ascii?Q?1BDQq6RkKLXhyP/02p7LOCMnJaSglhhkDrJuVGnMZLsyGMxtYQ3oVH9wvVte?=
 =?us-ascii?Q?PmOA9hIgcX9hXdBATglc1ACaAlibMJX0O1IwtD/V595Otk90bA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0IYtqtivtstOrShmQAjvK7U4FfrbVw3VpS42q8bP9xW9piH9/SfSeysgN2Q3?=
 =?us-ascii?Q?D6T9uwPmYXpwOPmXSeCbzpX3aZmhivHVX9q4Cm7YQ0SQYHGSJhJfI2uoybw+?=
 =?us-ascii?Q?jdATH5DnILy5Hxum0qNBwhlp6t7ZyPopPnH2TZgBfV6jH8i4gZbC8jr+OibR?=
 =?us-ascii?Q?0F257/5CVyo7nLRAXmXV5FMKCYBEaTYP4d13mvitR6RVntF8ha3I8nzqWEBy?=
 =?us-ascii?Q?+vTYognKYcFG7hYhfRoCK4Rzr+0w8m/ntl68k3j+Bhga6V4OinRjoO25RHqv?=
 =?us-ascii?Q?5kDTwzvfg8zHHCH+jZbqMKsPj3CWbmgAme6LzIcMXZhRP227iBUrYn222P+d?=
 =?us-ascii?Q?uJXGYTlgeqn96vKz8XT0P6lDzjPKCjtbKiHnwrFjwpIi7Z0beAfAWPeYfYXW?=
 =?us-ascii?Q?dBrzt0hqdY9XHyoDNCtC8GGmOXHuXDxvzoc1tiU6285fVszp1lqeXwYRKW23?=
 =?us-ascii?Q?R2GCzLYSnzDl+C6WAMoKzzFr5FirbIfEmULDzRGkIl51YQuqkWEsreMRS3Tt?=
 =?us-ascii?Q?GCwrzFh9Rjl9KhJvYhCvgpBVkI5hukaRZEC3ha0te40fG0dqh+MJkA551Of4?=
 =?us-ascii?Q?t1RvGg6WR+XSowrV3miPZW1pqsJSboU4FXF7t8rn12G9VCpWjYW0/2oTtdkL?=
 =?us-ascii?Q?DDIhLc17ktoFx62GpHSD/8uQJj7HZIm0rMi0mjaSGEH4/AwrGVCROPfkkVbi?=
 =?us-ascii?Q?k41uFvnspZJmIyMYHd0Sn4XNoOnJ7UH2F7TeROzRhSZdA7iyRhQaGlkUmGqN?=
 =?us-ascii?Q?wAReQhOCOqAI5xh7AwrNSyimqJoRxJmHb8r6Y+ltn0AIcMS0HxsbNlcXYLkH?=
 =?us-ascii?Q?mP2WoG2NMQT5Zoga/7jtR/J7hLlimWA+gh8QE7JuyYscrLbDlur42/H8o4Rq?=
 =?us-ascii?Q?UT1KcFi3gr5IzrgZt753JWLY2iLXaUwLIiPhbbGghrCMHdLqxtReP3LXaMlI?=
 =?us-ascii?Q?o1rT8MIpfvUWsE/bE+8/vP792tTbtShaEO2ddHzPf2B/ybXZ71a+fcZx+2mf?=
 =?us-ascii?Q?fC/pD6qunUX+nou/2CEw6xXSay9Cn48irK31lE9sYC45CGc1JOQ63Spprn24?=
 =?us-ascii?Q?ngryepSG7zBcgscOrpU19AJIQsU+BB8o87iomnmolyqX8BVUNy69BbUkJeFy?=
 =?us-ascii?Q?33iFJC2c+rGcLA6GJgympNeBzt3O6ZWEx+szXWlk4szBYvsf13CR3z+Nkwcv?=
 =?us-ascii?Q?6+JhsYVKWHDabJBy7D23pSDWZYz/x59JnfcBYMSVLF7QrD6fPOoqERWmESt+?=
 =?us-ascii?Q?F2LHwaGtCAe2Nm/47+5F5t0qj3LSsNs93QNMZhPvSJU7iZ+dH2P6JPAwstKV?=
 =?us-ascii?Q?LBZz8L95qloNUgHZc3iPDL48VgKMj212APTCPy6oYoMxnaip6T+QDLRk+nGP?=
 =?us-ascii?Q?anI6Ya9BQNtBuWP5pEL4T7UiN+W3uwVfifXQJcKKFRX46Y8G5nCDjNmbfLoo?=
 =?us-ascii?Q?lPet4vUKS56himjtehskcBmNyvi2oWjGyv94uzvX/t0mar2z3ZBZpdPLlsST?=
 =?us-ascii?Q?h4+qDXTfDoKwsFqJDYzf0kFgjMmi1AkQCwrEJ24BQKhpdYAomWaMRKKGlCCG?=
 =?us-ascii?Q?zqWR3phWdC4sz5FdwHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908c62cf-c6b9-43d2-d55a-08dcb1ff9f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:57:43.0447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UN28go3hQvfrTv+1qNjcZ2HqsyBvKkM9rD5DZgxqE73Yl41rgRNk9BFLok1sGk/WsMES57OFWKjuPuYdM4eyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Trigger.Huang@amd.com
> Sent: Thursday, August 1, 2024 3:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, Trigger <Trigger.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: save the funcs of gfx software rings
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Currently the funcs variable of a gfx software ring is not set. So if it =
is visited
> somewhere, it will lead to error logic being executed. For example, if we
> want to call some callbacks in funcs of a gfx software ring, like per rin=
g reset,
> it will be failed due to funcs is NULL.
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index d234b7ccfaaf..4dad03a07492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -202,6 +202,7 @@ int amdgpu_ring_mux_add_sw_ring(struct
> amdgpu_ring_mux *mux, struct amdgpu_ring
>
>       e =3D &mux->ring_entry[mux->num_ring_entries];
>       ring->entry_index =3D mux->num_ring_entries;
> +     ring->funcs =3D mux->real_ring->funcs;

The ring functions are set in gfx_v9_0_set_ring_funcs, what is the case tha=
t funcs of software ring are not set while real ring's funcs are set.
Otherwise, real_ring->funcs are not the same as software ring's.

Thanks,
Jiadong

>       e->ring =3D ring;
>
>       INIT_LIST_HEAD(&e->list);
> --
> 2.34.1

