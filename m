Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2AAC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 03:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722AE10E230;
	Tue, 30 Apr 2024 03:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J398vnhX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A50C10E230
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 03:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1u2BbL88MpiLeKWD78Vewi1lU2xsP0SLUju1UDFY49P0TS/mwgrQIUErkiOfM80L/tYPRHtYWJ8xj9kmvdV+8+ABpmL7hSv8jJRuQ0t5/MjoDBMbKDCmNUFsiBvlPWedK6x6Y53UFKZpt8ErzlyoPEMqEooqxg7yMFuMq5qP0ReprNMM8BN8fvlpsc1SflmEB9t/X42YHu6ehZFL0L1nxd/i9hp47Bh/XS9TM7665M6MMK9Lf4Fs1BEbP4Cx0PxdBplbTF9PQt9nh7vxCBjOmS/As/CCV87Q2CqZ7nzNox1cPUDjq2jkJ//kiL5UNCuQdPjdPAl+KTATYK/SkJYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3cdMjFzB6n+UzGRo94MIZuSiZqdOQ6K+x4E+GWk9Cw=;
 b=DrdP+VwwuVnGUCwN8xVVng+6DlNxLsMuibxTQ+ya4msHQ2kxKfgKTPLEaGJSvD96/GHgHie8mnyeLhGo9e/9NrDVBZlGp9sYP4WL255fSCgsbgqxrBdfLG4S9ErJTxr65QF+AQ0bu4p2/uohg3KSGYbTZe0XZZyuiDZN7r3a4aX4jSXXk3E+x4bMM5q+JUAMOGHLQNwPi4EP0fyEhD6qjKcF5iSkvYLF3WCVgRDjF/mK9Pq1ol/ZFhrcpjeGELNirhb+6nx5B7r1gKtzC2gpeC6OPBd0SiO2E7+YRNUvCryfxfOnvGipd8wQ4BTYY6OyPomm5ThdwZaRnZCLw3p0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3cdMjFzB6n+UzGRo94MIZuSiZqdOQ6K+x4E+GWk9Cw=;
 b=J398vnhX7gizNpVXWm1Sz0sm8BTqmb9fARkcLfO7kEi3GC/GU9wF5sN0sk7KYwaQG54j/a72hlDIDLX/p7t1wxTX9NUoKP2RWxODgp9EAnbTppb7StcqkkdWlGFlLrGRXRybB8TBOuS6AGJVxotORoEyfz18EsFtDHznty3h+Lg=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 03:31:52 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:31:52 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHal3fDuIWs75r2/kCois466O5n57GALpJg
Date: Tue, 30 Apr 2024 03:31:52 +0000
Message-ID: <CH3PR12MB80748CBF93E22B4B8E4D138DF61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426011426.1340586-1-Tim.Huang@amd.com>
In-Reply-To: <20240426011426.1340586-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c21f75a-151e-4cb3-8e19-d7f3c9b4a995;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T03:30:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: 1e660f41-c468-4a35-e66d-08dc68c613bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?W3YXPAE/Y3g45uWDt4vTIaQQCZVeWSd5/NE5SzISM6F5pmphrgMpjpe7cSkP?=
 =?us-ascii?Q?l4uFJWkI+qH6Ilkm1k/kzL4umNJ//i4Pm2sBB/LhoSCrgTstvbryLLtTGpSF?=
 =?us-ascii?Q?x75b+nqxpNQoN2SDZm0hV4kLZkXrDQQiONbhCECdx3aflKynAbcZ7wbysI6I?=
 =?us-ascii?Q?/bMVYm1p2lu2LNMEOj1pCWLixbdNUQc79eEOYJ/fpMe8HGMz4KVK1kMqjYw1?=
 =?us-ascii?Q?oxMMeOomLKjo6ahwmo+fOeCR9gIllOFfYtTzwMyoLCvCfXrTfLAgdTHkfLIY?=
 =?us-ascii?Q?Jwqax3qCBuI+cL6Yn06l85kNfioccL4pw7nwTh4uVIgHnmZwlqsu4phYotLs?=
 =?us-ascii?Q?Aw/lA0LGiMkSR4TStNpx/QaJFHJ8FLCYgmf0AHt916jHwlyMoh2BxeNR+mS0?=
 =?us-ascii?Q?3n/fy90b9BXATf5kZfzssLRDU3Hn/CjzCPcPGeCOujErfYDBfrwdzijaDeY1?=
 =?us-ascii?Q?3EzP3Aah9UNwE+kYgx+RFH9+Hu2U9VtPHr2jjKUQvLG+5NH0JT6DwWZ6E9Z4?=
 =?us-ascii?Q?xoDqsPeF3EzfJ9ivQiBDJajMfRKy1jHtvtuFpxNXdTkyw4ewG476QFUhX55U?=
 =?us-ascii?Q?/Ms9oYnUu9ZzGpLQO5Ecp4Rg3BPCH9iYjOczKGb44x6dBW82bSHR7sj3qt0r?=
 =?us-ascii?Q?KW34tIeYixdCwjMbZlFDmtsniGhGyYZvPmA7fN9/THaSdLEDydIPXygNjN9U?=
 =?us-ascii?Q?96E7s2EqVqHlJJcTPbUi/AlW3Wp2MaCvY/wnL5qyvGnLYNglQVG0/cz8djAw?=
 =?us-ascii?Q?eMNaMTRcKtBJAojw4yGQ7j0RENYUut/sOSXZ3fkxiQVZppWag5d+SCCjNDDl?=
 =?us-ascii?Q?BxJ6P3aGNvGiKOn9BzeZ0D4Cjc4XSEtvjOoQAbhcz5Nnkfxo5Xv0XgXsL87u?=
 =?us-ascii?Q?EKNl7m3/cbsHGhZTatqtPxXUgZoI4G+J62XyqmNQP0s4+eJmCZoTSIAr5Kzn?=
 =?us-ascii?Q?1jGD3BE7F1yExtJfCF8FgMsfJAwMushqvZy9mnQ5pSoUOIHM7txyAzLUmlaf?=
 =?us-ascii?Q?vxmtYEMIL90MhGS0DAO/1nq+10ZEa6EqOYcfLVT9oCXd/N8jO1PHZG76e5mD?=
 =?us-ascii?Q?bmE+G8n7PwDJoS/45milPjZhRs89gXf0zMT8m9LGYkeguNvlKvG9h9+6nNZW?=
 =?us-ascii?Q?rI2+WLuiEywG19pxF2MjTGMfq+jyb3a1skJ8Hu8y6Xw38Rsc5G3Pks9JB8ta?=
 =?us-ascii?Q?yhDWEARo02lwUBZtOeT5b1+oZOk0R9XxGMNIObgSgeV2QR35GUdPk4K5nLJ0?=
 =?us-ascii?Q?FAIOSuA+zkUstPLEfDKYFbP8Mt1bDchi3p3bkQuoS+QeyeXQKKK+tJ5gRJgA?=
 =?us-ascii?Q?SGVtMVs4p9gjxKvSS6T+aECj5VGovHAIRYkldLugKIwIKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bo1vW4u6E05bqs71vxKEjHyLt6q+X4ya1T3rFdehfXC+DAxt5NQv4LXF69+A?=
 =?us-ascii?Q?TGPnUEvzHDm/62cAYt2m3u23VFpVWR0IfbH1pUww5QbbUEC4k83LQ2r5qqnG?=
 =?us-ascii?Q?bZkA5Ae2Nq71VvmR1TTH7HNAS7MzX8c7emyRTnYtSYUO1Jwbh1qAnxiLCgkX?=
 =?us-ascii?Q?Bt+rFgx8wkt3X+fdO1EYighVt83uSpaH62OinROBi6y9NN5ixpLNBLNrqxKO?=
 =?us-ascii?Q?8E65i+dTkwbXJAOkDXkhJzti4hHvsslzWMKZKbE6TGEKetR3/TPfV3C0LEjY?=
 =?us-ascii?Q?otyHjtJcG3c6PPPQkWiDW+Cji97b+fm9a6byWf4SMv36jp9WTtL3oly6LAbC?=
 =?us-ascii?Q?sXrLK8dQfG2/MgwdEcibPPBU05pWBjSUOCn8qNvvwsWLd+VHZ3FyPJsff07o?=
 =?us-ascii?Q?ov6Q/MCwH5090dX6DI7IvRLXjURYRmzwcxmUEpajDgYHku2XEIaoaK9zOdiK?=
 =?us-ascii?Q?tSHPtHEu2UitmnHHMWnXXMjWjRQnL5hnbluwsMfNazj2neNCz5OGqC5A/qwE?=
 =?us-ascii?Q?h2O+mT3FSfishr5Ud5EsZYWBCxyIvFR5SWoO6VqKKli1RLUYysTmMUWNPPn/?=
 =?us-ascii?Q?GI4V88zd/r8+Cmf3X48dzX+u09U+IKeu7Jezdbi0LQjvIHQ/yATA7dYh/nKw?=
 =?us-ascii?Q?DOP9sRil6dCU9hgd2DqAzd7X54Bkkgt3TR8GIu5wXNYhZjd8j0UrzhbTzPGV?=
 =?us-ascii?Q?s8rwcMBJAV41uMdkKnooOYrIjeWEuJmQc3SYYmqu/7DBiejkosUOHrPnAsrw?=
 =?us-ascii?Q?8CvOuMDoBoKb5X/vTEwR+yC9UVs24wp26BhdcevNAnU5mY5eIaz05xKa79kN?=
 =?us-ascii?Q?4NJ3sppYHREzOj7IQBgUFFqGLd8P9XhMEd2cWYW9V0Y3QjzYmswpheY+X7EB?=
 =?us-ascii?Q?+NqSFwAfSDl77Be9krn35bjKe8J/hcqN5R0Heh+5OcBgOzu5xLA3dnuxbnZ9?=
 =?us-ascii?Q?iOpMnf5DTovCd8xNXbz2oFTkkle43TLdTdnBo9/xpuyGmGMpSJdfMyaBE479?=
 =?us-ascii?Q?hlZYHkXpe614xfAuAwMZBZVucC0pDDXCxUKrWRjtSfYmcx0DqfsQDIoivagi?=
 =?us-ascii?Q?wBfdRI9SIQvvKSAiigCck+Z95tDOEplPdJhehqvWNHhdEx7EtdR/3vHuLFOq?=
 =?us-ascii?Q?K/UqhMJUx4sdvGAAKBonCf790PiQ7LfVnbKIjpTwufr3GE77L8J4NrqxYQ5t?=
 =?us-ascii?Q?uSMWQ70zz0mVObB3STBsHH1kWNg9BnohhW8E4bJXA1dWwHhqjoR0+Q061GGS?=
 =?us-ascii?Q?resRysHkZmVcXxgvNSNxfWa5FSnE1qJVBQ3Jx+XtjDqHkxX4gKJCMPETw7xz?=
 =?us-ascii?Q?Rg6qkL97wqFd+JU84tPkXB3ZlwSWHaD3V++wjUUg2KCIR1N7ZBz3TCsQk9//?=
 =?us-ascii?Q?ucYtokeuxd98G2s/hasUl4EGhtP3gN0H4yOmy/0hzyaVYFcFESg1nFIPaMkA?=
 =?us-ascii?Q?nbQWqBrDXk1vSkeuHhXsVNWDCD+SFsOwcbpqdnnk0Y2bYKes00A22HwNbfvb?=
 =?us-ascii?Q?ykzVVjllsawuJCBAbBUK+TnNH5SMLKnlupJFuiXdXijW3BVuZSS3E0/yyFkh?=
 =?us-ascii?Q?nUyTDxYnAPedmX3XDJqFheVqtIsikClKrCDsEQtl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e660f41-c468-4a35-e66d-08dc68c613bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 03:31:52.3533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ufdzns2kvcuOURwJXKYmcDE0BTyHv5GRQp8GLhFdF0JfhenXv1yoqEmCtZLaUB8hazSDXtQ44pQMMJ2FxYqE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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

[Public]

Ping ...
> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, April 26, 2024 9:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
>
> Clear warning that field bp is uninitialized when calling
> amdgpu_virt_ras_add_bps.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 54ab51a4ada7..a2f15edfe812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -395,6 +395,8 @@ static void amdgpu_virt_add_bad_page(struct
> amdgpu_device *adev,
>       else
>               vram_usage_va =3D adev->mman.drv_vram_usage_va;
>
> +     memset(&bp, 0, sizeof(struct eeprom_table_record));
> +
>       if (bp_block_size) {
>               bp_cnt =3D bp_block_size / sizeof(uint64_t);
>               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
> --
> 2.39.2

