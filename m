Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB4D75BA2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 02:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B18210E04B;
	Thu, 21 Nov 2024 02:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6tITMV+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EB510E04B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 02:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1PUxax5OO2kKWJoaDIb8EwVY2dTPz643Xgjw/+5KYUmkVj3fVOgk9QAGy+yGg0y4sE/ZmJeogUOCjSSX+hek/Uxf0NEIgIJBlrhNT0N2onlKHqL/z3kuD2S3JOayv15kX8rUXBWmB53zKdZ9rIBVb+I3U4G5HGpHiD/NWUyixiYnMi1ujZUn+3IrRR8EY6zt17RoCYawybbxT1lb1qi0iFOk+8DbDeylU/X4uzHdenbuUZyydakPqsm3Dek+4mznX06cnQ9CpygKBXhUjRjdduL7FBefYfB7PInicLSBbpw3MZas/mZ4uWH+o7RYwkV4CDUwmmv4TjA+13FD+myQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJWi4bR4CInL/32ywEOmK4qjPLJhmW+qwNbe/bcTQqo=;
 b=jvLJqZgFlePL6dVhqnaIKTEbI33FXDsNj5px0b/8vOBHb/MgZIVt3y7tjnoVrt7+yQ6Z92r3+NNGRktQqHWfiC7UqX0oFDNT9B6gna6A3DlWR27oCHdcb5ROv2IWIhYhXvSHzjCPGd9oUAkhMKTryHLsQn6KEyrNeEnaAkYI8QbTZkVW4XnMgRNaWGjDyvai2toJQVHQ8OIRWMvbAPoRUc/iDxVueUPLClmZ1uxW8p0w8ts5KVxbxnGTP3OGNM9uFhAB9CZsAerq9EPKrtM3L3z00PAaKhp5IHmEYACbekBG9ehxwTowsmTmeDLx0M5KRbdnwx2XgnOvWP2Gv8OObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJWi4bR4CInL/32ywEOmK4qjPLJhmW+qwNbe/bcTQqo=;
 b=m6tITMV+KyAHLCfdtHnKOg4GjrZTNMSBiwesxpj06ZV0g2BEq9rUou5Y10T7O0Tv7DIKBbvnQ9IyfH4Lv0f/aCpF7IaO0V6AjGaB5zBj+9SP5KTOvtA/d9NeLTz4XIHdCOOM3zfnPiQcG4lK1UtRx1UHoLO+tNfnkO8wryRTe4g=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 02:34:11 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%5]) with mapi id 15.20.8137.027; Thu, 21 Nov 2024
 02:34:11 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "Wu, David" <David.Wu3@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers
 corrupted on vcn v4.0.3
Thread-Topic: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers
 corrupted on vcn v4.0.3
Thread-Index: AQHbO0il4uneRIXimUOgvWPcFvxV6LLBBO6w
Date: Thu, 21 Nov 2024 02:34:10 +0000
Message-ID: <PH7PR12MB79887DC5E45F5DBB320C84669A222@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20241118094737.1024533-1-xiang.liu@amd.com>
 <20241120123432.1075304-1-xiang.liu@amd.com>
In-Reply-To: <20241120123432.1075304-1-xiang.liu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=085bf6d0-66e0-4c8b-91ab-6e032efc7724;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-21T02:33:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|MW4PR12MB6756:EE_
x-ms-office365-filtering-correlation-id: 3262d934-44c7-4e1d-edfb-08dd09d4fb3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|921020|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mvhWAh9th6lnCSzeq2Zi71N6dy6+fm4PSvHL3uqFpDYlpSMhCh4xA15oAdJS?=
 =?us-ascii?Q?7zKJ68votJAoDazG2Wvqf9gqAH7YeB+ElLuszVTlTPRze6QaZaEwWOCG6DaW?=
 =?us-ascii?Q?M4rhOQhlhxb7Sjf9ABWPMJlStCnSLi0qi6ZRjzeNO7R23VfyP9g6GI2127GW?=
 =?us-ascii?Q?n9cOl18euDyWIJ2YXcRgSzVH3YerB/VmYK68iqozf9sbyWsAMhfj1GAgv4K1?=
 =?us-ascii?Q?+dX5awE78f7io/exh9mqXDZPPBeJqOnILpCA5+rSvd/gI46EEQW0N5ARJfFM?=
 =?us-ascii?Q?1v9f8Chje7F4qRrZOjkHlsLfL1KdDLdzXNZPLX0UJlm1JidMikrjeBsCXEg9?=
 =?us-ascii?Q?zaBv1x+GRmWin3eJgWO1YDmbGsAKWUPzHdtVUWX+oLb2xTIYPJx8U9oXAm4i?=
 =?us-ascii?Q?SUA5YGAV5MwD5373n+eJj4D2G1GwC78nTAsq4ymhxSK1MZJzmQL813hQ2iMC?=
 =?us-ascii?Q?IQghr3dPcic7clg0jCORY/mYYV6XCvXLXcwLGPQpDenR/L0631kKOJ0RWjss?=
 =?us-ascii?Q?uxt68gQyaQyEiXYs+VJqQR6sLWeS0AhOPcFnR1MUhQazmP17NDO/SHwUP4Zw?=
 =?us-ascii?Q?xDvbi/t8SYBoczU8c4wV2pJmhwzBGg+J+RG8VRYBs56+g1Kizz8jWfo6riwi?=
 =?us-ascii?Q?U98fr3vf51BIrGSgSiBBBwqlbZIlGjNgyp+bd0NJr5DxHWnJ/JAKxIXeubh2?=
 =?us-ascii?Q?+jQjIBtsii9tKsVts0tb272e1Gw56fRMD284g7QLXJgzwKUx7vfahH9Pmmel?=
 =?us-ascii?Q?LXr8HRFNZ2LBZzUrYAUQ6regPMaZ8M8cBfmL82fthtTNRLr3bTWfHo6y2IWE?=
 =?us-ascii?Q?6ynlLFX5z6+SRb4nFFq588HgAhLNUvkn52x7eeoD+JWucY3aucw34pNdGqx5?=
 =?us-ascii?Q?TuyXRdHKGtsAE/8DP7OttOvT+kjPYTbisNsyG9rNsBKWX100Y+aaOCWkd6vt?=
 =?us-ascii?Q?Bz8wHKw3IlWl7FeFiIpsfB0ZWJoNvX0gMyCXDdRPOHhJLUNj/TJirGRPGgbv?=
 =?us-ascii?Q?PudqlnEX44BAR8kwzsPggkWyW/zQlYZwGndFqG/KQFJpD3Uee6XonqB+YJ7I?=
 =?us-ascii?Q?3Gqc6rbcWHrkcwJxRHaRPpd2mRlrNl5VS0kLrNgQVkFKjDpBMY+f9I7KlP0g?=
 =?us-ascii?Q?w9q9yOdbGNyYbUbJAz8T94dvcegqMf3+dRoT6rJVm2S59dHLQwV1XlXi7WoO?=
 =?us-ascii?Q?lHH0n/jd0k9siaSvFmk9qCINzeD+EHcvArjQNIfp3hWmBMlWuwgs+go78yr4?=
 =?us-ascii?Q?yebQn38BMhXvG5HrGvYhy8XqdwHYkz5mCKuWgUqxNW+jkbKuSm0E4Nj1A5pa?=
 =?us-ascii?Q?TM8vYi9c6LHi9/ddgEJLQN9t+M/V4J2ARzV5RjN6GPS8bYAIp1kjSnjruIsH?=
 =?us-ascii?Q?qcZnQV05EHywQYgpFt/vKAq/XQmY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I38x3060GJTida4/v9OM7sB5CMbahFTITDEOz9f/BtGC68ut0UqFT+3kSCv/?=
 =?us-ascii?Q?e/Wgxc8YS9oUjAW7ovE6742HZouOzqQGT1L2pHoRhMsiVZv/HjETyVc3pwOK?=
 =?us-ascii?Q?1e2v5p6JiLEvTq2IWEclzzJlll7PwCSDYF3BW7VFHLchkHs5j5G9/5LEKxIN?=
 =?us-ascii?Q?i2lta88ASiuxajcqIUpWTW8SV7q5yEPPR0Y+oPfbPliffPwFmJmATsv92YqH?=
 =?us-ascii?Q?t6q9d7dN8ZvKHL6/dygl/L2f7XVCplIfEBdz46+uTXd3uGpwu6kTCkDEZJT4?=
 =?us-ascii?Q?AIrhU26wVFZHM4/SfD659UKA2H7vBxoFS+j2iW3QtyXy0vgmDCd3TiGNIt3M?=
 =?us-ascii?Q?uEojQ1u9wshYnV3iNjARhgwqFAqPEM/uSGNpgFdW08ijdc2z6tBfO6JqV2qC?=
 =?us-ascii?Q?BfJDuj9knZdInbV/jPoombubv0I4awEKU/gFylMLfbC3o3dw1QzCQBUNyxTR?=
 =?us-ascii?Q?O06wxc4FI++DosFBpVwAUQHsz1ABE8TxSAdqu4CI1LaFOjjeUSwIjI68inmG?=
 =?us-ascii?Q?4xFMMowqA8JR/qA9u/T5ygfJwvICogQvqBT5r1eyBVRILhAXP5L7Go9H1023?=
 =?us-ascii?Q?TR3M3/JhTQXLI/hd78dmo7HJm7cz7E6b2om6dLn8w1INBQsYfS3UvuOfrBwt?=
 =?us-ascii?Q?SOSFQ97R/l17Xor6ww5sDUsjUloxMg3uHrPG/z5dVQxodk4FCIYG2s30C5Io?=
 =?us-ascii?Q?/z040FsbQvoYB7f+zP7bLy6SJhKWBq2UJL9UXNKejY5uhk4Nj4YArqDikJoP?=
 =?us-ascii?Q?re6Gh2Y9KgRJxY+xUutXHE0bdSfYWtegcRNA9BPlAzYwDC7MYtdzMKeoGZcN?=
 =?us-ascii?Q?x8iAkqOmNMr+CRX/TCcIxt09aJ+jmdkyXkL2voJvkK0yqKhaOALwZWyahLHP?=
 =?us-ascii?Q?FfDXs1zbFbj4i+tXaGewR+8baZ5ovqdrF8M2C/iLAJ0o4mmzkT6wLXqAYZy3?=
 =?us-ascii?Q?q75MqeCV9FgrYc9ELzKC+6QGVbIsbYaFa+IYhyNsjNmt7afbZPMheKuyeHMq?=
 =?us-ascii?Q?9swdYxZO9FUXSZDjrFG6oBubyjWKNBnXDKkwB9ViHp07dt+20yWsIFQydOAu?=
 =?us-ascii?Q?H1K/6oQJ6uKh4oe3vdai3LZcxzLcPpPG+152hl46zLjXJtuGdKJxVClrWLK9?=
 =?us-ascii?Q?xgRV0XVi/wrL+V8Tnjhm08lydbBL/Vd/zP+lxeOAPXtnfCjL/L3c8GykShge?=
 =?us-ascii?Q?7jFUD61zfxEFJnGSgCMhf1uokwbzQWS4fqgX8V92YmiM3UuByEHlym7Aw6vW?=
 =?us-ascii?Q?DDvCnIIXWRDDAWGovmd63Ly8xbjIWVtAQYa+Q9EU7r86wdjwFjk7QH5YEVXT?=
 =?us-ascii?Q?GdQSFAlNh1KjVrhWVjMryM3RRVMKGiTLERccB5nozzHzCLNrugNzB9d70NOw?=
 =?us-ascii?Q?c272itSsILbY2THEbZvaaHAaItxc0232jWVpJDJFNdVDUP0JXVXdhBnqnmOU?=
 =?us-ascii?Q?wR4TkS7KnLoEktlUJ6AuX4jWGPw43cGNt1AcOfVzUmLKoAroSwkaruY/3TaL?=
 =?us-ascii?Q?XdOgkfyCuA6jCdQP5xcdl1bHJcjR3bniWxtGIJwoE10lJKda+UNGIs7ibjt2?=
 =?us-ascii?Q?FZFiiYFtfmYQbnc8b8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3262d934-44c7-4e1d-edfb-08dd09d4fb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 02:34:10.9415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN128Be6vObXxEE+V+46kdkasaGLqUGzSRKyQ02s1eGXNK08IU1KNfxQ8IahXLxHaWoT71YDuZpzDMqeLR3+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang =
Liu
> Sent: Wednesday, November 20, 2024 8:35 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>=
;
> Liu, Leo <Leo.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Wu, David <David.Wu3@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrup=
ted
> on vcn v4.0.3
>
> It is not necessarily corrupted. When there is RAS fatal error, device me=
mory access
> is blocked. Hence vcpu bo cannot be saved to system memory as in a regula=
r
> suspend sequence before going for reset. In other full device reset cases=
, that gets
> saved and restored during resume.
>
> v2: Remove redundant code like vcn_v4_0 did
> v2: Refine commit message
> v3: Drop the volatile
> v3: Refine commit message
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 30 ++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index d011e4678ca1..c678631c6887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_bl=
ock
> *ip_block)
>       return amdgpu_vcn_early_init(adev);
>  }
>
> +static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int
> +inst_idx) {
> +     struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +     fw_shared =3D adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
> +     fw_shared->present_flag_0 =3D
> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +     fw_shared->sq.is_enabled =3D 1;
> +
> +     if (amdgpu_vcnfw_log)
> +             amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
> +
> +     return 0;
> +}
> +
>  /**
>   * vcn_v4_0_3_sw_init - sw init for VCN block
>   *
> @@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block
> *ip_block)
>               return r;
>
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -             volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
>               vcn_inst =3D GET_INST(VCN, i);
>
>               ring =3D &adev->vcn.inst[i].ring_enc[0]; @@ -179,12 +191,7 =
@@ static
> int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>               if (r)
>                       return r;
>
> -             fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -             fw_shared->present_flag_0 =3D
> cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -             fw_shared->sq.is_enabled =3D true;
> -
> -             if (amdgpu_vcnfw_log)
> -                     amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +             vcn_v4_0_3_fw_shared_init(adev, i);
>       }
>
>       if (amdgpu_sriov_vf(adev)) {
> @@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>               }
>       } else {
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +                     struct amdgpu_vcn4_fw_shared *fw_shared;
> +
>                       vcn_inst =3D GET_INST(VCN, i);
>                       ring =3D &adev->vcn.inst[i].ring_enc[0];
>
> @@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>                                       regVCN_RB1_DB_CTRL);
>                       }
>
> +                     /* Re-init fw_shared when RAS fatal error occurred =
*/
> +                     fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +                     if (!fw_shared->sq.is_enabled)
> +                             vcn_v4_0_3_fw_shared_init(adev, i);
> +
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
>                               return r;
> --
> 2.34.1

