Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF7FC44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 10:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D45610E052;
	Tue, 14 Jul 2026 10:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWd4uYsL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0087810E052
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 10:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUOyVpQTx9kY75sUtFolf+EZzqlQ+6lKs7R+gHd2aSHszVzy7KhJzqttjv9up1i6Xs8bNjMZg27He5kMsLjH+1xnhwQ+LnuSCRHFyF9oH8hIQIHu1cy8NL2NqhwpiMXU4l0f/e2PpsHtCsajYCgXN4hHZr1b40472o2VMQdyazuYLOnpLseNvfKCSsgH9+Pk/Sur+hZ2gJ11ekAkXxxh14mVulgRiXY8AHfZ4Uj/ybObP0vpMF8kda9KgwvJVZ5DLvm8NYaFObMOuDjCVNEfomw82r44exQfMdQGz6HU1Wu0clCnXLKDtoVZcG4qvE+3VEu1tJ9f0H7Gv7Q6eQ1iCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyppKyWEej7hXUP7uJ/M0ItBS9WEOYKo5HCoDJH+RcY=;
 b=V2dLg7wvCde4pyjgXHQr3q9B2xcxU4P+Ufzo9aKfOGBnZhVevq8D5ngcdDWmIk3OkUhgrqlsl7BcF/YjLU5q+rlpG0ia7AdLbihvHosCUWvU4zdO6HNmG6CIv/agVIDG3QsGKYLLn6SpHc/8eLIitV0/sZZokRXfiontkdOH/TehTZ1SlUHKjcNYWfEhQKl88Wj/JRwimb1lBTHe3UECVh+InwTDS0J5drzT6tsqiTkHo4GsfE1GYdWbvg2Ebx6D7YR879gQULT8fouVBcdTWhuKig8SU2H1g837xPPYzuiSYxa06YJPq8vIFMYq7EAyBz+iQFUqTmPOfL6D2+0lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyppKyWEej7hXUP7uJ/M0ItBS9WEOYKo5HCoDJH+RcY=;
 b=BWd4uYsLCreyRIjGDE+UASkMCCN5KGZh1EwZEsyaOf7W0eTu99RCzEWEAsc18Pd04FQJBzBuzRl37KKw2hwkhIkjoOK+OFrMdGvYFCzBq4QnTsvWYbFTowJUE+Ke4rLWyr2NWX89iGSzmhmBLwcfsKKG2YJcizNMKilk/04SwyI=
Received: from IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 10:45:35 +0000
Received: from IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::3d12:dc5d:9ed7:abe7]) by IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::3d12:dc5d:9ed7:abe7%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 10:45:35 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Topic: [PATCH] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Index: AQHdE3dwrIi7wO85T0G2NAuGF0IY47ZszMkAgAAH/lQ=
Date: Tue, 14 Jul 2026 10:45:35 +0000
Message-ID: <IA1PR12MB6332C9925CC2273459F17520FAF92@IA1PR12MB6332.namprd12.prod.outlook.com>
References: <20260714095832.52308-1-xiang.liu@amd.com>
 <94866f41-1a60-4b5b-9ebb-89eb80697ced@amd.com>
In-Reply-To: <94866f41-1a60-4b5b-9ebb-89eb80697ced@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T10:45:34.589Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6332:EE_|PH8PR12MB7424:EE_
x-ms-office365-filtering-correlation-id: 6a12b0b1-75e5-4a88-a90f-08dee195090b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|8096899003|38070700021|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: rvxAdaDPHSOCic/k7lX0aIcYWEkcQPCLTEwHc7udfI9Xqso99BuzX7FhDQFUTxsA1EUtR1zszEl1BNE+rYWV3UM5WDVywF93p8H/6IZj22/8TBxeYdiVHjjLNh9sHoWRL4ng8KvroE8j4HKi1ftw3YjIa6/z4eTQ+ZqmJa3LjySGnJUVsoGcZg7JNl3xWDluKZ7o2XtQBFFN/mIM/L7lAQFEg27/2aeuPlvzyzu8tL36p34NUX45Znsg6OUsuCh5mHgUCkM946YWZPz/YFFZfzoEswYmS1w9Qn82f/QMhAgGeTgqpB2nuhZacxZYcmTw6rssWVFTrKf76KxTaW840ZiFFtFK1ei8s/vQovbkQhoJw6vEGfx6M4COILiqSB55pfYgZosg6Hdsh3ixcv4Xi4+3VV3TvZAoOPi2WPBmIIguYCv+4K0s4CYrgRRl8jEyU7XSBK/iq34JEtZGdzx8gy8yjB/QszP5W3IfblwDLzh7GhqQAFNXsBYY+MqdTvCkBkS7hvXn2VLaSHD15DE6ljjf7UtE1Q0VlXgVjHQf+fxoYQqwgsT22fsCwDyhQTKo04JfQEMFj5BKVZsYHU7HKHLFekjxhMiZ1Z2df1Hm6AE4UzpkMgAtEmbymfoPLglxHf8rnvpQgMfyPXzKqCsXcrOn4ZIcybNwiUT6cC38nlj/jhwQVbK0Zb2KP2PTA6W64g214SCNiPtD+JY9QG3Y4bgnqW23IIIJHm0TGX2ABZ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6332.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(8096899003)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xORjEKwlVKz0BjoAykOzSZS4lMNElsrD1ZawkXgxLPOoCDklKrQdH0Uzyq1H?=
 =?us-ascii?Q?9N91NKukopwW0F5WybBdDvbMxnMnFayBa7Ms9Nn5w+MVA6QDyPysbQZHM95Y?=
 =?us-ascii?Q?EZPJlJU3co5yfRq2bwWJ8SmtAaviTkamvjfNME2oIs7mnzAKLaFD5u7DXfFc?=
 =?us-ascii?Q?Zdmr8JBBg2q2jb5vNe0LGEeMOTr2bi7fHKm1sZWemb7bIDFPnsIoncOrQvFh?=
 =?us-ascii?Q?iC4jJ2iMS4YiyO4Es9TrCNVtNGxF7RAD04okQuW0msoGVO1vvVdEc/cWkKeh?=
 =?us-ascii?Q?3FT0bgw7jW0s/32QqWcl3mU4LoxZ6FvYp9MZkri3BHZmtetGCEryPMhUP9oL?=
 =?us-ascii?Q?Jrd+7eH/8iaMygpfk5HL7jK6srBynMt5vX9Rn9HlA8ETbAZoIn4oGnaefOKT?=
 =?us-ascii?Q?M1JEQqGqboISEKwE3kdWz6AnHfpHLcqo9VoNg5C7uiikbOXHKGA88O/7n+Uf?=
 =?us-ascii?Q?68Yzvbn2zP4MgRvRdlzngGbdQhxJQvTDTH/7EjchtVOb9FYpy0Hm46UZFy4w?=
 =?us-ascii?Q?WWBI2iINMwe77uBUT58L4/jn3hJ4ybEfk9fIP7tVNZ3B5W7C+X8dEAqEYUub?=
 =?us-ascii?Q?liASvVXSXB8/tt/vxraEBWMsOOIIhQPKzFpInqXijvPy/cPc7Un9UbgOavJX?=
 =?us-ascii?Q?cz1GhIDM3mX9WT5D5+yWbjcPGnphfghgQB47/gdAo8ivw+qWKwXm2TANIqlF?=
 =?us-ascii?Q?RBov6Hm8FKg33I+yJ+EfWnxJmCw8fs4Ht2O+KPqZVmF14kWNyN9s0BDrpUji?=
 =?us-ascii?Q?5Osj/F+ugPHYt2RTDsjY/jJOqGSFgT8PDPueqOomKGRafZ4K03xDAJzq76hm?=
 =?us-ascii?Q?R18i4aA4w4wjNySK3IHcpFP3kn7hdQeh6xLIWY2Z+/sVtXLWJwmzH9xM4H5Q?=
 =?us-ascii?Q?FuW1pItDyky3pwcMpHGiBLImAdh4NZvb9RuHzHjCR0W32kqR2Y8JYX59fPV1?=
 =?us-ascii?Q?gNy0vcnT3B6gysEWbBVBLt4FVKQPt+rgPVTEBxESFYAX8KQO5mae30fQpgut?=
 =?us-ascii?Q?KhZeKHCglB6Atq6IhhmqM7muDLGMVHxB6aESXxcXFB2f3UCXzBv1FE5ejo3U?=
 =?us-ascii?Q?4iCvr5g8Ea5hY+Ypr2AghISfXq9CqcyuqND5EMJwo6jI99BHK0Ah7llBKMl3?=
 =?us-ascii?Q?auYteuLnoAPc82j2l9mPTtS7sHo1Bm5XSJE9ESYIV4vUvssPsb60LPFZVcK7?=
 =?us-ascii?Q?FbqhWLcGAFfCaPR2f9y6D8T6SMly9BHTLEOzsbCtY00YVDMde1aQAAMX7v0j?=
 =?us-ascii?Q?LXOqmK9b2RalUCtR1lm6WM4og9/lEI66Pl1G+Owpq0Zp2hOaDtKZnI6MMsuc?=
 =?us-ascii?Q?DlhLHTchwFW1+BIdVQzatTII6HrfRwXCy/UL27UvnzZ6du0glWDme8PzOe0g?=
 =?us-ascii?Q?cDhM0ZeRNSfHIO4TtNeoV6zlADFFJtAj3oyh251UI0LxWwgovG2NaLFUL6jf?=
 =?us-ascii?Q?gX+h1K5PPlLvSl6J2CiHWp8Nz8ZqAkaR38nKIhKDbuKAK2Nta0f/+H8hz4Fk?=
 =?us-ascii?Q?JSnZrWwXoWHA5rz2l/XNoImtqYcfE1G/J49FcIwNJLWU2NHtPxPDZLg44pTr?=
 =?us-ascii?Q?GGq8KGx9d1r6NuYAFD4xg2cA/tMQXh7F6UjArrUBFWeucJvilEgCHYPEoVHz?=
 =?us-ascii?Q?eFqyb2r5bY0MHLIS4gUrP3AhwwaJcUwhJQzZTeX3lWGwofyGk8+BtEK01xjh?=
 =?us-ascii?Q?Lhadu+9wRfD+Lx2uAXXW7JFU9IIZK/Pg6rKBcqF5TC9PnX5R?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB6332C9925CC2273459F17520FAF92IA1PR12MB6332namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6332.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a12b0b1-75e5-4a88-a90f-08dee195090b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 10:45:35.1053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95Hs5O/8J5uazVtZW9AW5uqOTCgibimW7cMhBVsqyggvcdICXs98SZ+E33oIsA66ZqrV6iwTgh08D2gl46VNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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

--_000_IA1PR12MB6332C9925CC2273459F17520FAF92IA1PR12MB6332namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Thanks, will improve this.

Best Regards,

Liu, Xiang

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 14, 2026 6:16 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amd/ras: initialize CPER after XGMI reset on init



On 14-Jul-26 3:28 PM, Xiang Liu wrote:
> The XGMI reset-on-init path can run while the device is still at the
> minimal init level, such as during an NPS memory partition switch. In
> that flow the normal RAS IP block hw_init is skipped, so unified RAS
> is not enabled when the early CPER initialization is attempted.
>
> Resume RAS after the XGMI reset-on-init completes and retry CPER
> initialization for devices that still do not have CPER enabled. This
> lets the CPER ring come up once RAS is ready while keeping the path a
> no-op for devices where CPER was already initialized.
>
> CPER may now be initialized after the normal debugfs setup has already
> walked the ring list, so register the CPER ring debugfs entry from the
> retry path when debugfs is available. Track CPER ring debugfs
> registration to avoid duplicate registration and clear that state when
> CPER is torn down.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 15 +++++++++++++++
>   4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cper.c
> index 6fb129025761..7513541e6eff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -504,6 +504,7 @@ int amdgpu_cper_fini(struct amdgpu_device *adev)
>                return 0;
>
>        adev->cper.enabled =3D false;
> +     adev->cper.ring_debugfs_registered =3D false;
>
>        amdgpu_ring_fini(&(adev->cper.ring_buf));
>        adev->cper.count =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cper.h
> index d12c98077d9d..76df176eab9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
> @@ -51,6 +51,7 @@ enum amdgpu_cper_type {
>
>   struct amdgpu_cper {
>        bool enabled;
> +     bool ring_debugfs_registered;
>
>        atomic_t unique_id;
>        struct mutex cper_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 3d1ede5f8de2..78130f8565c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2184,8 +2184,13 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev=
)
>
>                if (!ring)
>                        continue;
> +             if (ring =3D=3D &adev->cper.ring_buf &&
> +                 adev->cper.ring_debugfs_registered)
> +                     continue;

Instead of a new flag, can this check if (!adev->cper.enabled)?>
>                amdgpu_debugfs_ring_init(adev, ring);
> +             if (ring =3D=3D &adev->cper.ring_buf)
> +                     adev->cper.ring_debugfs_registered =3D true;
>        }
>
>        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index b265b68e0f37..4ec8e446d377 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1400,6 +1400,21 @@ static void amdgpu_xgmi_reset_on_init_work(struct =
work_struct *work)
>                 * initialized, and for non-uniras devices.
>                 */
>                amdgpu_ras_resume_after_reset(tmp_adev);
> +
> +             if (!tmp_adev->cper.enabled) {
> +                     r =3D amdgpu_cper_init(tmp_adev);
> +                     if (r)
> +                             dev_err(tmp_adev->dev, "failed to initializ=
e CPER after XGMI reset-on-init\n");
> +#if defined(CONFIG_DEBUG_FS)
> +                     else if (tmp_adev->cper.enabled &&
> +                              !tmp_adev->cper.ring_debugfs_registered &&
> +                              adev_to_drm(tmp_adev)->primary->debugfs_ro=
ot) {
> +                             amdgpu_debugfs_ring_init(tmp_adev,
> +                                                      &tmp_adev->cper.ri=
ng_buf);
> +                             tmp_adev->cper.ring_debugfs_registered =3D =
true;
> +                     }
> +#endif

Here it could then init both debugfs and cper together since cper is
enabled only at this point.

BTW, is it possible to call both inside amdgpu_ras_resume_after_reset?
If not, better to create a wrapper function like
amdgpu_cper_deferred_init or similar and move inside that.

Thanks,
Lijo

> +             }
>        }
>   }
>


--_000_IA1PR12MB6332C9925CC2273459F17520FAF92IA1PR12MB6332namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Thanks, will improve this.</div>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 14, 2026 6:16 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thoma=
s &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/ras: initialize CPER after XGMI reset o=
n init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 14-Jul-26 3:28 PM, Xiang Liu wrote:<br>
&gt; The XGMI reset-on-init path can run while the device is still at the<b=
r>
&gt; minimal init level, such as during an NPS memory partition switch. In<=
br>
&gt; that flow the normal RAS IP block hw_init is skipped, so unified RAS<b=
r>
&gt; is not enabled when the early CPER initialization is attempted.<br>
&gt; <br>
&gt; Resume RAS after the XGMI reset-on-init completes and retry CPER<br>
&gt; initialization for devices that still do not have CPER enabled. This<b=
r>
&gt; lets the CPER ring come up once RAS is ready while keeping the path a<=
br>
&gt; no-op for devices where CPER was already initialized.<br>
&gt; <br>
&gt; CPER may now be initialized after the normal debugfs setup has already=
<br>
&gt; walked the ring list, so register the CPER ring debugfs entry from the=
<br>
&gt; retry path when debugfs is available. Track CPER ring debugfs<br>
&gt; registration to avoid duplicate registration and clear that state when=
<br>
&gt; CPER is torn down.<br>
&gt; <br>
&gt; Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c&nbsp;&nbsp;&nbsp;=
 |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h&nbsp;&nbsp;&nbsp;=
 |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |&nbsp; 5 ++++=
+<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp;=
 | 15 +++++++++++++++<br>
&gt;&nbsp;&nbsp; 4 files changed, 22 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_cper.c<br>
&gt; index 6fb129025761..7513541e6eff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c<br>
&gt; @@ -504,6 +504,7 @@ int amdgpu_cper_fini(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cper.enabled =3D fa=
lse;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cper.ring_debugfs_registered =3D fa=
lse;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;(adev-=
&gt;cper.ring_buf));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cper.count =3D 0;<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_cper.h<br>
&gt; index d12c98077d9d..76df176eab9f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h<br>
&gt; @@ -51,6 +51,7 @@ enum amdgpu_cper_type {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_cper {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enabled;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool ring_debugfs_registered;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t unique_id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex cper_lock;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; index 3d1ede5f8de2..78130f8565c5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; @@ -2184,8 +2184,13 @@ int amdgpu_debugfs_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ring =3D=3D &amp;adev-&gt;cper.ring_buf &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cper.ring_debugfs_registered)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
<br>
Instead of a new flag, can this check if (!adev-&gt;cper.enabled)?&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ring_init(adev, ring);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ring =3D=3D &amp;adev-&gt;cper.ring_buf)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cper.ring_debu=
gfs_registered =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;vcn.num_vcn_inst; i++) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; index b265b68e0f37..4ec8e446d377 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&gt; @@ -1400,6 +1400,21 @@ static void amdgpu_xgmi_reset_on_init_work(stru=
ct work_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * initialized, and for non-uniras devices.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_ras_resume_after_reset(tmp_adev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!tmp_adev-&gt;cper.enabled) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cper_init(=
tmp_adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(tmp_adev-&gt;dev, &quot;failed to initiali=
ze CPER after XGMI reset-on-init\n&quot;);<br>
&gt; +#if defined(CONFIG_DEBUG_FS)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (tmp_adev-&gt;c=
per.enabled &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !tmp_adev-&gt;cper.ring_debugfs_registered &=
amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(tmp_adev)-&gt;primary-&gt;debugf=
s_root) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ring_init(tmp_adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_adev-&gt;cper.ring_buf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;cper.ring_debugfs_registered =3D true=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
<br>
Here it could then init both debugfs and cper together since cper is <br>
enabled only at this point.<br>
<br>
BTW, is it possible to call both inside amdgpu_ras_resume_after_reset? <br>
If not, better to create a wrapper function like <br>
amdgpu_cper_deferred_init or similar and move inside that.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_IA1PR12MB6332C9925CC2273459F17520FAF92IA1PR12MB6332namp_--
