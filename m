Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF8FC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 13:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A7710E59E;
	Tue, 11 Mar 2025 13:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuiMT0Dy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C191C10E59E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 13:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3gqx02zVFZ+tQ3Q4RI7+QHAvLDiFX6Y1FmiRDWFtumjJSgYxFMiLATWdEPZnn3Gp7q2aBYT6bnzmofmGYdfH3UrnGtqtC21f2iQn2hLFRix9ui6NjfrQ1fQohk2f7KDwELKswu5vC/MjEL7rbcvw4XWVyNeaJFP3fXiVosNP0GFyBDvZw+teetUShuGkp6jvcZTOtpGnbMisfyDYSW9GchaHGmR+nRVUl4x56WRvsYmCk7qa0QnOuOnBU6auS6XtMFb4t154NlmcBBunAjCvW+obIZnvAoRmBsbTO47ld7GHpssC9cIQMn9rCHFHkyfJxPqzth2HEmbZyaf/Lm9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqL3y7ceaPdcUpIP+YtJlTFztjt41ork4ihfaUpa9kc=;
 b=eorNc9ve4hmVKZYrOkcz5VnfQnjbxLa5YFqKJeIS+MSj0OrqPN24jlo5TbyzAuaPYlNWKVLXFJU/XP/EnjdxMsTvlA3MG0UhrNnLYLAdFOZUY0LcFssnJXFFxkk02UiJgrfl+N4xForb3jGFY0xKaYsrkusbOfK8E9dzBN7er9VfEH1cAnygUxcYWbZybbnIMI2BA9SkoITKxglmah5xBf6+C2KhUFde4gWVa/SlA+dUaGdYjpA+o29ZFTVXgG1NZDTuLL2YhRuRq+3lxSrabELAezQquklYhYaDsAqSieQcqFIcyXE0/uojM6SyG3PTvdeLUzUjiNQVLItmRJp/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqL3y7ceaPdcUpIP+YtJlTFztjt41ork4ihfaUpa9kc=;
 b=yuiMT0DymaZJLVGUXb8SAWO0GcGB+Prey8oE0Ro/77XC0U3rGloGHXRtToXEfp5htJ7DIZsktWFRVL2PGcw70+FzYrufpXfshVtB60DiZVGmqHXRhcy/phcglIj6mRgFM8ToBhYKqWYtWtKXmx3Y0+Q1m482BgxflNkZD5/Gys4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 13:02:10 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:02:10 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Thread-Topic: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Thread-Index: AQHbjsgeA53XrauAa0CimpS5lhut57Nt6fWg
Date: Tue, 11 Mar 2025 13:02:10 +0000
Message-ID: <DS7PR12MB6005D31E47FC8DF70E6555C0FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
 <20250306184612.8910-3-alexander.deucher@amd.com>
In-Reply-To: <20250306184612.8910-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d0503ac9-ce94-40ae-8faf-e7da4c10c72f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-11T12:47:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SN7PR12MB7297:EE_
x-ms-office365-filtering-correlation-id: 62065de9-2899-4214-c899-08dd609cef53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?j/2DPavYBBMoS3GRpSQVgOfjsPvYK1EjdhaKc6U1Gx33tvPZ/z1USFJ4I0sp?=
 =?us-ascii?Q?dkgTCnCt0dquxpNXQR3FrUohZzzFJqDjpJvy/IpteBGpRkIb8Me0Zq2h66Hw?=
 =?us-ascii?Q?iTFBUdPtraTgUPYdgdZ489CZtUDytIs2CqMxpnDKwZg6oJbtaP0Wt1sDBEtH?=
 =?us-ascii?Q?hiY9cIswL6kgeeiwpvztIp0hV+jX0CZhMKFT8aTpl51riVmEia1QrPCs5yqZ?=
 =?us-ascii?Q?eJzO/Boe79HMwfrakMCNUzXatgjNYwwxigMDn0mFEd/2OOhL/JNCFoz2UdaZ?=
 =?us-ascii?Q?lb/1YFwodiJvNLrHct71FDX8TrZYt0kgEOTkpOhfTPnE1fhOSF8xfT45mMt9?=
 =?us-ascii?Q?ponV4hNTSq/+MKAGv6rHnDh7UCnd/xHD+hc1wr36UTDg0f/D0/NyzECJlfPW?=
 =?us-ascii?Q?J/fYyMa4pEMPmewaomLFBieocLCVM2mSGyq+eFdw6Rz6DY6hSdcnSHKQmf17?=
 =?us-ascii?Q?eNHB12SxmapamkvfdvQmtnMpAiGtGikzMiHwbVrv0gHfWEwjhtueHk/bi7uQ?=
 =?us-ascii?Q?ceaZB0Aq/3UnXD/dGadi869xnjFfKMbaxoyrj30nzpCvh+y3GuBkNDksw4sb?=
 =?us-ascii?Q?Vs50v2EAD3JqizlHeXXnc/MXq36+zh3NmE8AkIOr1K7EQ3sGa0t/3ovjUS0Z?=
 =?us-ascii?Q?lwk+W1fHkFmTVzTWtnaIVjNCWADpvPiBNUf3iRnQgssGTgvDlq7yWeduqRkX?=
 =?us-ascii?Q?pwVIz4XX8HpOwKcO4nnfn7AjHN1upQfmTM+vqrwbCJQ+/wfgxVTPEPu2Ximh?=
 =?us-ascii?Q?TTpHoKTOyIgdMyV4VSyd4w/CpmPjbyqrOoMkSWjciDBUV9SVPu95ZuNm8jbc?=
 =?us-ascii?Q?aGaTtCSdBnkVJkTGeg5pW0Kh0+AAkPFl7EgI30C40kIJ8rSNMz8Zf/SFFSfx?=
 =?us-ascii?Q?0OvntRLSIRAR80U1NTrryz0hDVjR2OdouPxb9Jz1ZLqte6MW+lWmTzZt7lLz?=
 =?us-ascii?Q?KJ2qqzwFVU/j422yZJZ/R8upTOoplsWdUK5CYQRPWRSGjbvmW8e1ODxmV+Po?=
 =?us-ascii?Q?MfjCRoXx2FY+bWVEMmF4drmM5EX8EYPKimbHjaSpEV4Onm8lOFMxaOlCNi0A?=
 =?us-ascii?Q?730+8eL7IWJ8Ut5wIrLjYtka5ooPqqDrsijb/WWNZw7TRxtLt2c4sjfEcs9X?=
 =?us-ascii?Q?qSzs/91yXYZQ2ts+3aXd2JcZfFQc6jdN7YpdXLEAI0vZiVPMDrgLrdbcj2s9?=
 =?us-ascii?Q?NhZnk/54fllFPBCcsCJ7SN3ffyATfXsVdcGlF22vRpgdXzEMyzdraEcTaQ14?=
 =?us-ascii?Q?4eP8v1Pb0UQ9kHhR7x6q0egsqIAXA1MSjMW1ULU5iJkqzofvCjUQYNMxow7T?=
 =?us-ascii?Q?geU8hzLB38BJyd6+pDLWt50Wjw09317HLD8MGngGyb1DTVDYntIw8xSlZAWg?=
 =?us-ascii?Q?PQa/LSJrIoLbtcPCQTTOhZ+ZzIGLoQHHZwippYxJzSiuQdM1tK8HDUA4lIfM?=
 =?us-ascii?Q?+UdneCelK8nEpiyJlEOhU1BDz7faJnTZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7JeRKDqa7EkM3bPvo0S4WPBfaMV6I4Exy0wQPhrme1keQOIbEIYzq0n+Cx7U?=
 =?us-ascii?Q?T15/F6z5vYG9X+++XyDp4uwDnVYzOyEoOsLmdgZaRlwVzQiKvpgN4BdpQp8B?=
 =?us-ascii?Q?ZP8d3fMUSivnedfgOwe5YreLfyCtE2deOXY9thI8LUjuM6zS1i7KvlW9ntfr?=
 =?us-ascii?Q?3sL5Lp/LYFCEYwhAsj6oCqRwH40+IeXr4peef7a055djqDt8d2Xv4Mjbajwt?=
 =?us-ascii?Q?BI4JK4j2KiMTRn/tBP9YBSO2bGp/FgLHWEFQPfaBOKDV+UCdIp8LiLLC0gQi?=
 =?us-ascii?Q?9StqCRYkrxHv0Iz1HQ391uLObozrKcthSgEIgOmKrE3Ynxzf7zpu3cGwFI8v?=
 =?us-ascii?Q?874RO8tf2DZs5T8tBrByh29x48n2JxCGI6jFo+IS0DBMI/LTDPNFSkH8JMQP?=
 =?us-ascii?Q?MuIOeKrHran+7XtMqTNg9xe798VW420LEKPKQ60FuEtQfEj/QglShrGGJiK7?=
 =?us-ascii?Q?n6dFjVlbSYyWypG32lk0Fsnq056GTCo045IlopZ3Vj/9frYxKubSsSVXBmGQ?=
 =?us-ascii?Q?hResOLyho+Tgfp3y7t4dPkp/I6QJ83FvQdaeplIWMWiKl4WLoMH7ZkxIcatS?=
 =?us-ascii?Q?J7h4hdmJQyyCn/wLSRjyB+sHCA8tkiRVJs1CIHWQMLKZPBySt8yXay1qfQMv?=
 =?us-ascii?Q?Dq0kcw+XpARX04CK/wGHO6ObiYDApg9+FwyFxImxR4IrMzYLuX/1qmWSD9jT?=
 =?us-ascii?Q?9Rgfz/HclcsfYxCdTpXs9BtjkqPp+yZ4q/ZnmTSustkRkPlcCpvclVobF29j?=
 =?us-ascii?Q?eTZ6mC8v4ZcLKFZXy3gLFz361EPXVZTsnGTsuyVNDGnzVt+nFtPSJ02qBZfH?=
 =?us-ascii?Q?utY31hfAOxKcU9gSPZJfuaGyeGn1ocE+Hh3Q9gqC1grUkJmzbuNY3E8T/K8o?=
 =?us-ascii?Q?XDEMBhUShjgE21DwMVYdMgJF8WIPVl8PdD+DKY8JKuIzSshXGibD5F0V850Q?=
 =?us-ascii?Q?83UeCPdcnsJofyMSJ1Hoo8uH9YnxH1vZtyuT9BVTJgcDkpRkEnXt0VZCgdAP?=
 =?us-ascii?Q?w4JbTo9r+u/6DhCUm0zAEkyhrjh737vB+9lbqdnCy9WiiQZxB3ZlcdxZTCbd?=
 =?us-ascii?Q?kBCWutadm9Rkph0HFRTIS8/9qIFu0rVeH1WkK9VuQWsDPDs70Ip05pyoWG7j?=
 =?us-ascii?Q?e3iB7qQHhzX/WsyfuGpryieadgGZGDy0CSN+ZDVlICXe0M8S13u8t9XiNBGD?=
 =?us-ascii?Q?3AeW0py5HcNcZEkk+VSUIqQTjkZ4xQ0guvT8HuH5gmCES1Jbr6RfeVyegcnK?=
 =?us-ascii?Q?2vDnR2yrkTIX59FQNuYqmFrFW0zmHWmHowq37mwuY7b/TjGkwA39fYcwN2/4?=
 =?us-ascii?Q?aZ7I3bkE3+3TCimn9Su5cseMkVNcbwP81B9ijwcy2E2ei7xiXgs/o3fSp7Cs?=
 =?us-ascii?Q?eFyMAjiPshFQ/xC/q2oSvr1Ktw03OkNAMYw+46psXmHUxwvEpAc90oKgJ9wl?=
 =?us-ascii?Q?G72KmXsd16uEZpvueGGdV/lZP0JhIgbrvP+dxUYGbx2WLZ3spY1FVLzhfrNc?=
 =?us-ascii?Q?lXryYatxRSiNDpMnVJk4Spzj8Cf9dfOUO1ZQ8vpKw2Fc3I9tguL7FjfE1gSG?=
 =?us-ascii?Q?UjLt03QS1REv0kgImJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62065de9-2899-4214-c899-08dd609cef53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 13:02:10.2500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHEP85SXJfZCSLlWkeX2/anRw5FsZu19fVmHdChSwmh2K3W2jPTnx0uTzoYlgNIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, March 7, 2025 2:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
>
> This would be set by IPs which only accept submissions from the kernel, n=
ot
> userspace, such as when kernel queues are disabled. Don't expose the ring=
s to
> userspace and reject any submissions in the CS IOCTL.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5df21529b3b13..5cc18034b75df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser
> *p,
>       ring =3D amdgpu_job_ring(job);
>       ib =3D &job->ibs[job->num_ibs++];
>
> +     /* submissions to kernel queus are disabled */
> +     if (ring->no_user_submission)
> +             return -EINVAL;
> +

Do we need reject the kernel queue submission at the beginning placement of=
 amdgpu_cs_ioctl()?

Thanks,
Prike
>       /* MM engine doesn't support user fences */
>       if (p->uf_bo && ring->funcs->no_user_fence)
>               return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_GFX:
>               type =3D AMD_IP_BLOCK_TYPE_GFX;
>               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> -                     if (adev->gfx.gfx_ring[i].sched.ready)
> +                     if (adev->gfx.gfx_ring[i].sched.ready &&
> +                         !adev->gfx.gfx_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 32;
>               ib_size_alignment =3D 32;
> @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_COMPUTE:
>               type =3D AMD_IP_BLOCK_TYPE_GFX;
>               for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> -                     if (adev->gfx.compute_ring[i].sched.ready)
> +                     if (adev->gfx.compute_ring[i].sched.ready &&
> +                         !adev->gfx.compute_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 32;
>               ib_size_alignment =3D 32;
> @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_DMA:
>               type =3D AMD_IP_BLOCK_TYPE_SDMA;
>               for (i =3D 0; i < adev->sdma.num_instances; i++)
> -                     if (adev->sdma.instance[i].ring.sched.ready)
> +                     if (adev->sdma.instance[i].ring.sched.ready &&
> +                         !adev->gfx.gfx_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                       if (adev->uvd.harvest_config & (1 << i))
>                               continue;
>
> -                     if (adev->uvd.inst[i].ring.sched.ready)
> +                     if (adev->uvd.inst[i].ring.sched.ready &&
> +                         !adev->uvd.inst[i].ring.no_user_submission)
>                               ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_VCE:
>               type =3D AMD_IP_BLOCK_TYPE_VCE;
>               for (i =3D 0; i < adev->vce.num_rings; i++)
> -                     if (adev->vce.ring[i].sched.ready)
> +                     if (adev->vce.ring[i].sched.ready &&
> +                         !adev->vce.ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
> -                             if (adev->uvd.inst[i].ring_enc[j].sched.rea=
dy)
> +                             if (adev->uvd.inst[i].ring_enc[j].sched.rea=
dy &&
> +                                 !adev->uvd.inst[i].ring_enc[j].no_user_=
submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                       if (adev->vcn.harvest_config & (1 << i))
>                               continue;
>
> -                     if (adev->vcn.inst[i].ring_dec.sched.ready)
> +                     if (adev->vcn.inst[i].ring_dec.sched.ready &&
> +                         !adev->vcn.inst[i].ring_dec.no_user_submission)
>                               ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; =
j++)
> -                             if (adev->vcn.inst[i].ring_enc[j].sched.rea=
dy)
> +                             if (adev->vcn.inst[i].ring_enc[j].sched.rea=
dy &&
> +                                 !adev->vcn.inst[i].ring_enc[j].no_user_=
submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++)
> -                             if (adev->jpeg.inst[i].ring_dec[j].sched.re=
ady)
> +                             if (adev->jpeg.inst[i].ring_dec[j].sched.re=
ady &&
> +                                 !adev->jpeg.inst[i].ring_dec[j].no_user=
_submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>               break;
>       case AMDGPU_HW_IP_VPE:
>               type =3D AMD_IP_BLOCK_TYPE_VPE;
> -             if (adev->vpe.ring.sched.ready)
> +             if (adev->vpe.ring.sched.ready &&
> +                 !adev->vpe.ring.no_user_submission)
>                       ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e9..4a97afcb38b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,6 +297,7 @@ struct amdgpu_ring {
>       struct dma_fence        *vmid_wait;
>       bool                    has_compute_vm_bug;
>       bool                    no_scheduler;
> +     bool                    no_user_submission;
>       int                     hw_prio;
>       unsigned                num_hw_submission;
>       atomic_t                *sched_score;
> @@ -310,7 +311,6 @@ struct amdgpu_ring {
>       unsigned int    entry_index;
>       /* store the cached rptr to restore after reset */
>       uint64_t cached_rptr;
> -
>  };
>
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (=
job), (ib)))
> --
> 2.48.1

