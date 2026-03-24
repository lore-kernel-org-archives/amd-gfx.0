Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA7F54AB9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE5E10E5DF;
	Tue, 24 Mar 2026 13:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zc++Nl67";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E71210E5DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxskvZ4v/aqITE1Gw2aFxqp5sG6CIdZmKEv4McTllqmH9zQJpKQTijQ6KPCWIZKnMuXqezWlyQvN7vlM7p8u8DJY5an5S2Uh6MtVb9axT+l5qej8Y+jxi5+3BlyP/6rt07XNKR6FEEzVFsH8zz+oTv4fq+pjpW8cM9RosiRVS7IwMDirYvMMc7q2hUQcSoD5Frhu8JoQs+siMrLBpnPe455WXt+YcM1KFQTClKSRAb7k77y38M+VJPKIL0RXikc0OM9aNblwA123ELyqF6Tn2Krg8HxYTpx18J5GoaXwxy2AmxtUq7vc70sFCPiwnGQ9xHoaXOsxSWuuORStz4lGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvOWgRbMrO+tN1HqyJeJOxLYeiedbo1iU1bswsRUy7k=;
 b=mJJnvys+/FS2Rr50QAlsYryrYCLMPm2PFfcSmunzhPpBlZ9bYg3fGGVXfK6bQEmvOA/8PBqfCvXNGPoKHwR/l61zMk6Vl04X2GxWcVB+o7cLhqrowJcorDVN7T9MMIV2+Wclbm502W6WVofjDrNfoZz2kTYc/WrQNwo0Manq6zzJnybhDhUjxiQW1oO0Eavj6eA8YaCOySGojW8u45JQY7DqUgjGhSxZbcp9galD0FYzd6zsIJC/V7WQexJ7dIQkqlCh9e5Wus+hAMhJS1t/M60G3p9xfEMZUObnC3dyqyju3Zlynmch8HLMqRskSg+8AeSk1f8qZXslAm9C/Wxejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvOWgRbMrO+tN1HqyJeJOxLYeiedbo1iU1bswsRUy7k=;
 b=Zc++Nl674ofJyHIot9lhqEqO5+vPYBcctzG84VTgFid/bzfGnGlozsHmvkaHaLzRi339qjAp2ChWy0LITp5KIKFWg4SuqMTENlboDpR/T8Fpy5tFyCvoq95TXVt4sKK9merM5Eq/6QpIfxf0uHtPsgRyYr66Hp4Bhd+eayxLobY=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:40:24 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:40:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
Thread-Topic: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
Thread-Index: AQHcunVvqVksCE2yR0qTWwFJstpeuLW9sfSw
Date: Tue, 24 Mar 2026 13:40:24 +0000
Message-ID: <PH7PR12MB600006CE3FC81B5FF6985A87FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260323033023.3338683-1-Prike.Liang@amd.com>
In-Reply-To: <20260323033023.3338683-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-24T13:38:09.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: 4b663e91-feab-4282-17f4-08de89aae704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|7053199007|22082099003|56012099003;
x-microsoft-antispam-message-info: KlvHLuro4Lpm+nl+D/NcbnLr0Qnro6Pbe34Z/Uf5mj17FPyxFjg2zkXNc7R4ps7pSdqKxzQNvuN64+UwfKklhnbW7cdNaDwEpnujKosUj4HM+CW/GK72g5pAZbZckoUocOKvkiBs5gLyRcsMr1bs1RzzYwNpjk/9kBqcrMZIfQ1TsKxPqxKjJLnjs0lFtKN70Y8tIW9geYrAWnx9scJyDhM0x3SBDIvZQgFfJz4R2Px1tZm+1lbpH6YMgihYX8AlPn6veyS7y9u+OqP+qkpIdgCtR88ds4KVEZt8T4wKkrrM9qy7BhX33iKGbECg9jKPJqVndOHwzgjKzPeH+K8rmJOm08Wuz9aq8qNhaldw5UUAipqcdxViODH8Kqsbm7xh9CsJ0fRP+j33+8cHiMSCnNg8/OEbKSG6h/QU3jKW4hQRwg3g6kY1VhfmIr+VSD4VLxMOHHLItoP1PwRrrno209lGD/+r9HBaAvB5DPd4KmUtb001ALY5RC2c9qB/7EmBgI7in+tmh982dRodP85qaB+v/6HbMPV+h1829mdzMXjdzEa2jNAf3fwulRGLB0yzSJvVHdgXZ6J0/eDh4BqrbbMMevJTcXxQjG7+pvPaZjL7dcqmIKthYafz8I5lNmQf4vGGHzoKL7E55K9xz33IKIqcVm+nBFpNhYiNFaog4uvk9c2bc1AVpE/WJpMz68ZGJdRVXfvZUfJitpRLChLL2hSmHIS/xFfTqH0ZKyiU/lFTEaHdpkIMAWKrGHwIbCXN9pGNkGJh+EmdsqnLvyDNsSQ7gZEHY7JhsEF3ZCWZw5k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(7053199007)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yig9mBNA5+MQi+zIga1MIf54Qq+MTK6fnOjhQocPgInX/5eObGh6kAupcU7j?=
 =?us-ascii?Q?pbsN5sNisNhIoOgYJniEt9xneoGfPN8zaH6WnWX6X0Z1/36zk4qCogkMjTWH?=
 =?us-ascii?Q?4AEKWxcBvrJfZWOOozDzTpo2iphB8L4bwAxsZUmL5SC0Gf/rD8NaQLgK6+c1?=
 =?us-ascii?Q?yLL5Gj29dgZsAKF5ZLq5tSVdakvUKTrKXTNODxVReIKFyFn3SzqoVlRpulsO?=
 =?us-ascii?Q?x95xD4pUoCd78vlvxyud5OZU46JWn/REy5Z3RZDtsIhfehTDg+R2M6LlAKe2?=
 =?us-ascii?Q?8X5JUBMpOC3TDp/WGHAGc56nq0zOQEQIui2TU/RedRQvXqseEeV4FHd9ltMX?=
 =?us-ascii?Q?FJm73n2/KxIDmWseMeuXY9GAyopTKxltqONjgWP9SVj/uYmz6ykHfhfYi7U4?=
 =?us-ascii?Q?ivQBedUto11Ozj+zx2fGKOtAC5qj+9h22ZTQps5HjWGUjE53QuUalbZALc7s?=
 =?us-ascii?Q?/L12K1ZSCggqo2RLHTbuJaexM8UGVZh1fViq0+hGfxuJWlozm+ROSw340S5A?=
 =?us-ascii?Q?XrNEzyKb6kiHgQKtGUDZzwT9AvSls4BRe960UD+CEoZMGGSGQ/cGB5rTffnD?=
 =?us-ascii?Q?wQk3UYLUQxnwseqi5aSRMaRTIh/qbLFYZqbxaH48AWm3vDCP8ONFBGVxsiWx?=
 =?us-ascii?Q?UkWbb/eI1MVsHZRWip7K8s+73XkV+wiSadvNFGmx7BQQtrmUJC5JMtlb6skW?=
 =?us-ascii?Q?mBCoDEZgJdj0/1bVHKjCZ410XLqoypz+rm6zQLpLXllydd4iq8Pua0gNqXiW?=
 =?us-ascii?Q?83ESYoOVnsGbcvDXF/cYvDDKEOoRsmCitUP+i8te/HQfPViNVl4ghEBPaWEl?=
 =?us-ascii?Q?s7E9gUIBFYQR7WtBDEv/KOvlA5e8V9amk9nTSGU/NSPBjYiazmtdZXoL232j?=
 =?us-ascii?Q?/ybgU/8zj4r4HVNvB4QIbeBTx4HuyaFJOQaowwOSNnn+mRqV/RdDwnlWZHDX?=
 =?us-ascii?Q?sVgGRDOOz56jJOa0zyg1gOe37HdpDkh5+FvJhYkWSTE0jWXoVVhfvP8ROIz5?=
 =?us-ascii?Q?EhOxl0OS70DPjvMTV1BDP9MrQiguK7Hmw63fH0i7pD77V92F1q7zz34/qZik?=
 =?us-ascii?Q?S/Zkcbtwk/9xFNDZCqAnv5fdlyTcqsYiiS9K2qw2Ihl5+7RX1LdWTIH5pqLu?=
 =?us-ascii?Q?lU81qsQk9QyppG9JzOYuIlUqbzMI03mwDWvVH9rxX+EBrBR628kDx6nHhQcf?=
 =?us-ascii?Q?0XK4e4RzFHT1iAUUPpo5GRF1RllrPi4PuB1kedQjPcmosg3/KG2K9FDY+L+S?=
 =?us-ascii?Q?5l+UzhqEG91s4QksXqAoeUNIQPia3b/xAWtENalU2ftEigIxQTcHycERsojC?=
 =?us-ascii?Q?7s/VNDVxp8NDFyd7jrRCjR/txYT0YRgw/P4BwBB0Rd94mMPwId0QemfYa3v9?=
 =?us-ascii?Q?hsY+Nw+kn1/zsIv7lFr/hHG4zj4jvTZPKE779FxcouOj4jcKzjUX29uyDz/+?=
 =?us-ascii?Q?ydJ4c4mz5/eEm69P2fQYsBlz6hyrq2fj/b4TWNEufp0OfHiONC6ycrpSvauM?=
 =?us-ascii?Q?eFHcCGCVgHVv4CH3wP3dlJbj1yDGBJBrtqRTYmsZtjBFYpUxTcQN++UK0XTg?=
 =?us-ascii?Q?fw85xBiAau9GAxrDpE3wB6Cwi0VLQGZqEp2OcFdjlpr9TiWZQJZDnTvyvR2R?=
 =?us-ascii?Q?wZ0DLO9b2KAA5MZWxJ8o3q4g8FMsJW4h2JasGBpC54uhJ7a/ViQz7UkRBj4Y?=
 =?us-ascii?Q?cxd3G9yzrUf2gNHcLJ+Y1SG6R3mpQJ7hvaZaBYIpINYQo2Iu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b663e91-feab-4282-17f4-08de89aae704
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 13:40:24.6257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InGLlsVjZX5GvLE6aH7w7NRul8WlXACQf8h1nsQJAOnHPG1cNpClF5s3kI7vDOLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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

It's not too much change, so ping?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, March 23, 2026 11:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
>
> Filter out the invalid userq emit and wait ioctl input arguments.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f93da45cfa7e..7b2700a0c0ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -483,6 +483,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev=
,
> void *data,
>       if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>           args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>               return -EINVAL;
> +     /* After the mesa allocates the input obj properly, then there
> +      * also requires filtering out the invalid obj number.
> +      */
> +     if (args->num_syncobj_handles && !args->syncobj_handles)
> +             return -EINVAL;
> +
> +     if (args->num_bo_read_handles && !args->bo_read_handles)
> +             return -EINVAL;
> +
> +     if (args->num_bo_write_handles && !args->bo_write_handles)
> +             return -EINVAL;
>
>       num_syncobj_handles =3D args->num_syncobj_handles;
>       syncobj_handles =3D memdup_array_user(u64_to_user_ptr(args-
> >syncobj_handles),
> @@ -946,6 +957,22 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, =
void
> *data,
>           wait_info->num_bo_read_handles >
> AMDGPU_USERQ_MAX_HANDLES)
>               return -EINVAL;
>
> +     if (wait_info->num_syncobj_handles && !wait_info->syncobj_handles)
> +             return -EINVAL;
> +
> +     if (wait_info->num_syncobj_timeline_handles &&
> +         !(wait_info->syncobj_timeline_handles || wait_info-
> >syncobj_timeline_points))
> +             return -EINVAL;
> +
> +     if (wait_info->num_bo_read_handles && !wait_info->bo_read_handles)
> +             return -EINVAL;
> +
> +     if (wait_info->num_bo_write_handles && !wait_info->bo_write_handles=
)
> +             return -EINVAL;
> +
> +     if (!wait_info->num_fences && wait_info->out_fences)
> +             return -EINVAL;
> +
>       num_syncobj =3D wait_info->num_syncobj_handles;
>       ptr =3D u64_to_user_ptr(wait_info->syncobj_handles);
>       syncobj_handles =3D memdup_array_user(ptr, num_syncobj, sizeof(u32)=
);
> --
> 2.34.1

