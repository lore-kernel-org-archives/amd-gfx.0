Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618F2CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 01:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDD410E9A6;
	Fri, 24 Oct 2025 01:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OEr/QArL";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0257510E9A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 01:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMPmD8V5QuI+BC5xLBpnoV9zLZ1zW/MjfeDRRedWg1Dp2kuj18Tin79/44ROi4X1YTgDo9JXi3bYNJa+GZ55b+wcWuffaRmAt0GqPrE66WrJ+pKk7GyLHHzgLXT8n11F5rLleilWLmIA2kox3qbzs64MyYJ2p+W3mia12A9kG4atPweW0M6Fa7tYeYvTae37y64iqGYTVw6t0Lu29bg8Bw5xoNe3dKF3pWo/AF/esO8AHO0vr/wJzK9lcpH1QqCMdwoyrqc7gUGZI20G+uGyZi4ivTPBfPpOBDDraIrINpiQu9PzSaVFF5PNUBqsVBLhFChc50zvBoK+0a1X28vXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ehEYEQ3V9YcoNe4M75/876A0KUwhgtSskyfS5izd8M=;
 b=F4R10MagzgBa0S6DNGy04QHXoiSf4qacSQyGjbmXR8O0ejsnNQG4DnpFEWPbtQ16nY65cj/utBhOusfG9CbFso4WRMyqBu/DDy0A0QwhINyrB4TSZIgkEF01lLeo1m62ML7cYk+6tlwI8Vws04S10uCSTooN6wmc9oY5Hk5gDUGePmm8T+Gjl+MLxtjUaeJJLI9jHCVL837y1zP8H5ScD9jzcpi9vW/vaGzfEhiWx1oOo08EZn0l+Qi2NX3o+D8uunR6b34GtOKjgDnkDKY/E+dJm2osxLm6BwuodAnzhjIS0IcmhWALLTuCSus0dROQ2idEmXZCoC08hqYjThwfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ehEYEQ3V9YcoNe4M75/876A0KUwhgtSskyfS5izd8M=;
 b=OEr/QArLH4paMRB1Q8jJYWUirBhayJ+MpVcpLPvgn6sMsnC1ygNkBvJc+h5ZExD/Bt/HSIoKjNfVOcOGG4oJkucYBEUWA5Jg9ElfYSpIjVxbrIPO24M7DGe6OyW7RUL4snlYQuLwWMwYI8AHzKtFoZ54yefJ6019bn1V0TKf2ds=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 01:04:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9228.014; Fri, 24 Oct 2025
 01:04:34 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: move reset debug disable handling
Thread-Topic: [PATCH 2/2] drm/amdgpu: move reset debug disable handling
Thread-Index: AQHcRE06xlTseFxzSUyPYTrIWJK6KrTQe7Dg
Date: Fri, 24 Oct 2025 01:04:34 +0000
Message-ID: <DM4PR12MB5152F9DB8DFC08533DCE13CEE3F1A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251023184504.5643-1-alexander.deucher@amd.com>
 <20251023184504.5643-2-alexander.deucher@amd.com>
In-Reply-To: <20251023184504.5643-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T01:04:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB8329:EE_
x-ms-office365-filtering-correlation-id: 1588e4eb-5894-42cd-1bb6-08de12994bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ddlYTr9IY6VX1w9j4n9PnaRZI8aI6yqKtjdXFVBP2RJSiz9nm+l/5LhwZ5TA?=
 =?us-ascii?Q?P7J/fCPq+6Nskg3jckxRcXwpYnOLgtZNW02Y9Uq66S0i3HLsk2tdRdr/D9Ce?=
 =?us-ascii?Q?TFQ7zDXQybzs6Jw6HrvTWeLptZ+0Q0d9jJj7uG2b6WwjKN9lVyskebC9cUQO?=
 =?us-ascii?Q?EtKGaexvnv2bfROKlQuTrwg/2ftwK4ZzODW2IcXCClXfdMC4cr+8Qzq3WGWI?=
 =?us-ascii?Q?z00azoEJONRBh9KPXCinPpd/L1KX3zqF81MioQivW5DXvnjyeYzKwbPm3gnN?=
 =?us-ascii?Q?Sj8W+823/eYJQ+lVQ1CRmWoBYyUVZtXx+niJ+HYlBP1mjKisuJiXRWICwoRp?=
 =?us-ascii?Q?eERT2aG5E2vtufxyEnpByH/9/jwyn8EWYtwLzhmzr1Dcefm/nZl1UyfqVPt8?=
 =?us-ascii?Q?mo/sOMlJLx5D9kL8+/GTECrpBw86RTCD9/tqMDsCc2Idit+FiSeDVZifpW7N?=
 =?us-ascii?Q?DEQGT+bnvapCfObjA+HYpGqsVOTvw+B84kO/X9TrKX23yugjWUNzwwrTmicf?=
 =?us-ascii?Q?W20XniDBvw8P201rup9hIl0683HwKOepNZDrO9qrrDckntT+wIOnTdRjLSjr?=
 =?us-ascii?Q?VGRiRA/2ca8jGgqPVLEfiDoqUMggZXzn2ygN2W+PvgmB3C5uNS9m0kWJFXf6?=
 =?us-ascii?Q?BXeJfSVma04DdWU6CX14iUI9uwn792wyefo+D7YyUc7edL9uy7JYKaC/vMSf?=
 =?us-ascii?Q?Gv79ehLI6NfkQqHZMnIrCWfB7tKM3PQhRcdLvQagIibXYHzO4SxWIbnqw4pc?=
 =?us-ascii?Q?ezPBhEl+9Y8VsitpuP22O1TacYrIz9KoPDw86jTLElz27VorSlktJ3uAnkyN?=
 =?us-ascii?Q?KiD+j9Yu0QoLDeEmydhh8VXQsBHrpvpKWjcySSjwAFv5XYJ6gKhrhnonObW2?=
 =?us-ascii?Q?f50nuhebhre/hnEphTA23F4kSuKxz2+5ff2GqJOHLJkpZwUTW1Du5p0/O/Zh?=
 =?us-ascii?Q?TVL2bR1WivcCAQuVZ+5jEKEn9MN8Wc1UQqHAHZYst8zM0YrinxYT1gyEbFE+?=
 =?us-ascii?Q?nJeU8+9pgqWUV62U8xIap5crL3LwJLHYvpqtzh0ZPsZkPdA/AxDtESTp6wUn?=
 =?us-ascii?Q?1oqCbGmANoyaTujy3+zsaYtorE07Bi/ARojKP0SX1+2ttpkf3dY4hXf9oTls?=
 =?us-ascii?Q?BCeEHYv0wtMXjL//+K2h7A6paFUB7W/2mwo4DoB9tp3KB8FHucNgr0Woffv9?=
 =?us-ascii?Q?FWVPngmSUEpgZLh//I6GS4v3lN4gr8Zd8yziYsUTCM9A7fcVhwcaxQOjZG6y?=
 =?us-ascii?Q?ExxkXyK2ud4mUiUKGKpVBNgRGD9f34dF0w2mXjWsQuK6MImZ28iyJXYZNDNh?=
 =?us-ascii?Q?kQGLfhmcQDavQNERtqyGTv7BqqGfcdps8Z1qAk5LEd6dN8tNj5WB7JAUUNO5?=
 =?us-ascii?Q?Sb7DL0FDmCxeXL9DR6giil1vQROEGWWUlMCy/aHAT7w7no7UDMayhbPmFev5?=
 =?us-ascii?Q?/sqAbm3vvWg+YVzUfiSYFNOWxQ0QPM6iAQwzcOyax/NRNx0NlzMufzVSm+m0?=
 =?us-ascii?Q?u096RP7fq6qZMbdHOhzovWCYnNp4cJ5k1JH0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tkiQr0l2F3UIHfILOwmdXJu4C6URJjMhxo/IVqJ+u1Y73LCBHrzUovwDJYE/?=
 =?us-ascii?Q?KyAcgG3MEB9E0YVajXawGakVgl1g7o9vPNo9HjwBpXWZxMSeI5z+NJhjDixn?=
 =?us-ascii?Q?IJODRNntWVaB+cI2cH65KYafj3KfWNrALDZxUI+q1FQBQ0lY1lnTHUmo6rKd?=
 =?us-ascii?Q?bvAgWoQGb9RVR884gWfiwh64NtL2NKk0VR906C7XSQvVKnfyjb/buITLEv/O?=
 =?us-ascii?Q?hrZBh4ZBIv4FJuzaKI6u5M9F0jFMaZ+fgyga4E51y7fWfUk3UzdMZhqwYrDc?=
 =?us-ascii?Q?GZgX/V8mc0GixU5fctO1msr8mHme3+gDWq0YDC9FaaxswWkX3O22UFwhjyMe?=
 =?us-ascii?Q?EuyGfBR2Vnou7KhAp2inZPFrsG0KpMY++yjjz/4CHy4qPAWfRUjX4NfKZJD6?=
 =?us-ascii?Q?dKyCeKjcltSjX4FbLm1bQ23Xv9Zy7EOOuD7aP2Peek3gxcBcdLd0BM4INzbc?=
 =?us-ascii?Q?79U0+J32o1EXtPgizEqXO+7xQ3ntrQAJK54TckQVwbQwHc5r1af6uVtAbQz3?=
 =?us-ascii?Q?w1XCVXgLWBxoNtcvhZDLZF6J+9jhatJmykle9GodZb+X8YD3UCN+8fs9Ipkv?=
 =?us-ascii?Q?U6NaAqBZr/LEINC5yzMED+GlMpFSZ9eD/ap3DP0boDZ99sSU16v6MoWGv/oB?=
 =?us-ascii?Q?LLOOJzlBq5tV6tUkQ5DUCrBX72bbbZefQnyCyZ3X9w222HQfcpB4UwIjxLYb?=
 =?us-ascii?Q?v5M9dgujS31gg7QEEC6DEmNbe1E02J0OOVs6/+UcqmjvYMz1lLk8WHJohRPC?=
 =?us-ascii?Q?PO0NCwUo4DEcEN3Nd8n9YUzaiODyG0wxBG5xPPFE5gWndzfi7qfz3nIUhNd8?=
 =?us-ascii?Q?t8fbm8nmA5iOuiL3zvABzNAXd2QF738xDqR4PfY8OAMlEe3bHqcRwPy+hO7b?=
 =?us-ascii?Q?xTMrdG3oNSUgQrYu9//tiHn7VGo0eEoq7UeH9PQXlrOfTbEiN3GQt7K3wekI?=
 =?us-ascii?Q?jW8ek5KgWlNkXruMmK7TKx7z2eLEmFKsa6bE2pq1i8ywf1jck3GvRBZAZTRo?=
 =?us-ascii?Q?qcHOMRZkXBHSsswYMpCXLNfFtrMwvXHHwO7TCPQr++HYsV2mJ+Qho9ngyv8H?=
 =?us-ascii?Q?0BINDvm7lF/d/lI/1qWq1FJYcme3axbLbLHFmyRzILcnVQ2kOSFV5N+aXGn2?=
 =?us-ascii?Q?Jq2UKLieuS37aa8RaJDlt3tHjQe9onH+dFi7IZeJ3yqwSN7CEYc6HpnQMeaw?=
 =?us-ascii?Q?X1Q43KaOyiMsgudzgmPQr7VggvDiUDF1oFKts0vrQZZThLiCjVmUrBd4WJGm?=
 =?us-ascii?Q?5di2bxoc5T4SHVzuCSxM204fYDmJCtAofSvtmljsxzyL+HEcuLWD+5N+MeP4?=
 =?us-ascii?Q?SfRQLg306klapMOHtkELYosaDV9/rrlFrLat+99V/6grFC2ErCpp4ReFlJmA?=
 =?us-ascii?Q?MqxKkgc4wzImjmNuDY9d+7UVgpaBwKt2Rb1VXEsIKTh78b+F/f3zgI0qTe03?=
 =?us-ascii?Q?9gUDbT4t36yiWR/iSnMTy+rObeS8Nxt14HYltJQQEEBLhweyZvEjHdf5COXW?=
 =?us-ascii?Q?HSAQl4OVNWLqB0lN45hcbkrv+q6OHOHlmKSzg5C5m/srsIGsIcUsuxxlbBxb?=
 =?us-ascii?Q?ccq+oMkOPkmNMhmMyik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1588e4eb-5894-42cd-1bb6-08de12994bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 01:04:34.6240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIzrusf98mHO4PTJ/pYl1F78lVkQAhuTmrBpWj/EloLnL2JIYlOGFGAnpOY8tAg3kfv9liHiOcogVdM+pOKpYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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

this series is Reveiwed-by: Jesse Zhang <Jesse.Zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, October 24, 2025 2:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: move reset debug disable handling
>
> Move everything to the supported resets masks rather than having an expli=
cit misc
> checks for this.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 8 +++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 6 ++++--
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 3 ++-
>  12 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3842a15e2df8a..3d396ab625f33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -130,11 +130,9 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>       }
>
>       /* attempt a per ring reset */
> -     if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> -             dev_err(adev->dev, "Ring reset disabled by debug mask\n");
> -     } else if (amdgpu_gpu_recovery &&
> -                amdgpu_ring_is_reset_type_supported(ring,
> AMDGPU_RESET_TYPE_PER_QUEUE) &&
> -                ring->funcs->reset) {
> +     if (amdgpu_gpu_recovery &&
> +         amdgpu_ring_is_reset_type_supported(ring,
> AMDGPU_RESET_TYPE_PER_QUEUE) &&
> +         ring->funcs->reset) {
>               dev_err(adev->dev, "Starting %s ring reset\n",
>                       s_job->sched->name);
>               ring->in_ring_reset =3D true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 43f769fed810e..bf1b90a341d8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -468,9 +468,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ri=
ng,
> unsigned int vmid,
>       ktime_t deadline;
>       bool ret;
>
> -     if (unlikely(ring->adev->debug_disable_soft_recovery))
> -             return false;
> -
>       deadline =3D ktime_add_us(ktime_get(), 10000);
>
>       if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !=
fence) diff
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5bbd264f8357c..39b8adf23a9fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4959,7 +4959,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>       adev->gfx.compute_supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> -     if (!amdgpu_sriov_vf(adev)) {
> +     if (!amdgpu_sriov_vf(adev) &&
> +         !adev->debug_disable_gpu_ring_reset) {
>               adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 6994fb2cbf917..e1785a8984662 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1821,13 +1821,15 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       case IP_VERSION(11, 0, 3):
>               if ((adev->gfx.me_fw_version >=3D 2280) &&
>                   (adev->gfx.mec_fw_version >=3D 2410) &&
> -                 !amdgpu_sriov_vf(adev)) {
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset) {
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>                       adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               }
>               break;
>       default:
> -             if (!amdgpu_sriov_vf(adev)) {
> +             if (!amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset) {
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>                       adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 8d6000c7ce26d..b86a40e7c2d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1548,7 +1548,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       case IP_VERSION(12, 0, 1):
>               if ((adev->gfx.me_fw_version >=3D 2660) &&
>                   (adev->gfx.mec_fw_version >=3D 2920) &&
> -                 !amdgpu_sriov_vf(adev)) {
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset) {
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>                       adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f1a2efc2a8d0a..0148d7ff34d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2409,7 +2409,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>       adev->gfx.compute_supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> -     if (!amdgpu_sriov_vf(adev))
> +     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
>               adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>
>       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0); diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index e0b50c690f8cb..c4c551ef6b874 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1149,14 +1149,16 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_bl=
ock
> *ip_block)
>       case IP_VERSION(9, 4, 3):
>       case IP_VERSION(9, 4, 4):
>               if ((adev->gfx.mec_fw_version >=3D 155) &&
> -                 !amdgpu_sriov_vf(adev)) {
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset) {
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_PIPE;
>               }
>               break;
>       case IP_VERSION(9, 5, 0):
>               if ((adev->gfx.mec_fw_version >=3D 21) &&
> -                 !amdgpu_sriov_vf(adev)) {
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset) {
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>                       adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_PIPE;
>               }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index b95afb4afd032..5ec8e28980d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2361,11 +2361,15 @@ static void sdma_v4_4_2_update_reset_mask(struct
> amdgpu_device *adev)
>       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>       case IP_VERSION(9, 4, 3):
>       case IP_VERSION(9, 4, 4):
> -             if ((adev->gfx.mec_fw_version >=3D 0xb0) &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +             if ((adev->gfx.mec_fw_version >=3D 0xb0) &&
> +                 amdgpu_dpm_reset_sdma_is_supported(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       case IP_VERSION(9, 5, 0):
> -             if ((adev->gfx.mec_fw_version >=3D 0xf) &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +             if ((adev->gfx.mec_fw_version >=3D 0xf) &&
> +                 amdgpu_dpm_reset_sdma_is_supported(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 7dc67a22a7a01..8ddc4df06a1fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1429,7 +1429,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       case IP_VERSION(5, 0, 2):
>       case IP_VERSION(5, 0, 5):
>               if ((adev->sdma.instance[0].fw_version >=3D 35) &&
> -                 !amdgpu_sriov_vf(adev))
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index d3b2ac5813383..e163369773adc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1348,12 +1348,14 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       case IP_VERSION(5, 2, 3):
>       case IP_VERSION(5, 2, 4):
>               if ((adev->sdma.instance[0].fw_version >=3D 76) &&
> -                 !amdgpu_sriov_vf(adev))
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       case IP_VERSION(5, 2, 5):
>               if ((adev->sdma.instance[0].fw_version >=3D 34) &&
> -                 !amdgpu_sriov_vf(adev))
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 032cabd8fa8d0..fbe166a4b9b88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1356,7 +1356,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       case IP_VERSION(6, 0, 2):
>       case IP_VERSION(6, 0, 3):
>               if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> -                 !amdgpu_sriov_vf(adev))
> +                 !amdgpu_sriov_vf(adev) &&
> +                 !adev->debug_disable_gpu_ring_reset)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index cb5a9daed63ce..007f527d54e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1337,7 +1337,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>
>       adev->sdma.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].rin=
g);
> -     if (!amdgpu_sriov_vf(adev))
> +     if (!amdgpu_sriov_vf(adev) &&
> +         !adev->debug_disable_gpu_ring_reset)
>               adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>
>       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> --
> 2.51.0

