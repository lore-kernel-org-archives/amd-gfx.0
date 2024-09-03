Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471ECCD343D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 14:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AEC10E5C8;
	Tue,  3 Sep 2024 14:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsWHEtzF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D27510E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 14:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyy61V6Ws2tx+nkfFFeQTXqZ32RbLF9eFfbnDOxng1cHnO4/y1qo/VEcGTfR4zc+CWDhaLUcEuONl0nOUUeke7sOdK8PlaTK9BpOzJS2TcukQSk+HbnausuM7ltvXhSwmIX6Go3g19wbPOMhHhTjEfvw/pim7ff3sWDb4szB7GnSaCWp1BzuLhZ6t6MMpi0GUYTcP2HSEP74OT1Rk8ReaFXXoZPBdrVF4DypQZRbkV+Ep6iz4vnRnagAXzRRmL2DJHka5W3MymEG9H5ul+X+tO6tbZ1HxWAuuDWBfBPz8Ra75lMCs46Sz/f+FiJortXn+6Dh0Yt7HfY6iqcIcR+K1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDNrBreoymBj5z6LiMkWTKp3j6piROBYtnM/kQXHKq8=;
 b=j0z/9HPPZgmaSqqB5D2FFOnUfCbd9RfIQeZDLaSnblELnWwoB/OwvUg85lRYwTpaM9/3/HQkxvvC9egSsAKDmeN3peyK7H69JC7hwtyVTbSYdhf0U6ZOKafH1gQAZ/pYJ6Oz5GLPghsQe3R7De4dWtg6ciIk3laVtbgC/oGHhhsyWMutuxge0vG4WhA/r4EaySqLX5StmxR+LwrSK8EOKapPiInI8GO1GbnKvEWFI/LUoKsljOTzjO5QCjMqahMkvg5YrUQ3sH75ioASNth8joC7rj0HbdprEONG9bXNlH2CzEsovyO1OV50NTl4eo9JpEbK4mvAUUk7mS5IkB9qwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDNrBreoymBj5z6LiMkWTKp3j6piROBYtnM/kQXHKq8=;
 b=lsWHEtzFdhJsQaBzw29VAbYZZ5/G4zXgxb57x7g8+ySX3hbAXn9i/bQTfJQzWZ+c/irqdwyGsiTUkMQ+zyudEAA1Z14eBSFCJ5d1uHi9otOzn5iIUufz5Wcw1ddBHA5u3UtiPbZTTPPJim9b5/t3wdXtoCwSnpbWwCuUEvH/fx8=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 14:56:20 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::5a8:7f31:78b8:c41d%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 14:56:19 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3] drm/amdgpu: Surface svm_default_granularity, a RW
 module parameter
Thread-Topic: [PATCH V3] drm/amdgpu: Surface svm_default_granularity, a RW
 module parameter
Thread-Index: AQHa+mC37CfUy91dA0qOTXjysIQk+LI+0cSAgAdbwYk=
Date: Tue, 3 Sep 2024 14:56:18 +0000
Message-ID: <DS7PR12MB832177862E4E27EB692B4BE2E3932@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20240829221334.313701-1-Ramesh.Errabolu@amd.com>
 <78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com>
In-Reply-To: <78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-03T14:56:18.406Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|PH0PR12MB5631:EE_
x-ms-office365-filtering-correlation-id: 8c6028ea-7d53-472c-6039-08dccc289151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kGt+W1JH4ckspjqDDYGqnxbuGPsE0bMiRV917wOTSEQL2kKpEcYyJNKBHE9K?=
 =?us-ascii?Q?HZydR8RSZvVUroOJvmPqr6kKzMZjHnXtGZXwPiea3Paky7aNcqKizuMpTLFB?=
 =?us-ascii?Q?ESu/VR9gk6JeEMU+fw1YE+MzpnEhl06Bxr9q8xSeO2Auebtkd9CvN6cKY8z6?=
 =?us-ascii?Q?EgFAerxDDY6/Nc7vsVuOJOjQ7tjfGi6WT7Vx4TbmhCEsBKEFQOnDp/K2q6dd?=
 =?us-ascii?Q?KguY/J9pYOhIA7emP9UXxe+pbQamzw8LQTzDhXoAecmqxItljKrYxCGHMNUY?=
 =?us-ascii?Q?kNaKpvGXoW7XD/CVXtf9Ta19dQ4t+OrPQE64KNnrWxxuZ7W+2aPPQea752F7?=
 =?us-ascii?Q?K7TwN0yo/69hiSuiAmoh44OsRbJQmLvRVgzYb6DgDAwG47i1V1m/fT/amJ6u?=
 =?us-ascii?Q?Gu37nvZxoL64B1EUJIdfw0PMaQWWJgjMBrFI01KL77+RLhwfzhYfeRQXnagA?=
 =?us-ascii?Q?rl9yjgQmWOpctIyTKjwbFHaUHNvNTaPYMurLj8qA/ebBtXbZ/GCH+7R68qpG?=
 =?us-ascii?Q?Z8G89IntuGYpHNYpY6ZmfU9MBiXN8ZJ5ronsFCFCuiYnkaof3P/QaAEj5yQG?=
 =?us-ascii?Q?QuNn8WBEvoCOgdH1nn6oiccO3AV7MZi4cS3uRrxRA8J8u7DBRCUpQI9iwXYi?=
 =?us-ascii?Q?TMzBLr9Ww2UNxKoX7qwXW8Y1M2dzOp5vHk+qIPO8Gs8l2e+khzXm0h5xZwXB?=
 =?us-ascii?Q?yLMXuYvOlu0QLCDKsYygHMbww1Hm1M74kmw5ae+UOtB1ABrBvLnd7pCF5sNn?=
 =?us-ascii?Q?3DqxyplCW961Do0dTrb+u7Ahep3F2yK5qCyFJ9rQOOSQrQ4cB37zUf3SO79s?=
 =?us-ascii?Q?Zc8TkxDwUUxYm5XrOtThDQ4atXYQkhmXFz7kQ79OpYmeAQDph+FCC6x4Rcdt?=
 =?us-ascii?Q?ueCH3B2udAWQBkGPHNCyLl8sTLwD6im2xIv39IhBL3leSGSkfS8cZ/fT/5US?=
 =?us-ascii?Q?SSFkdXRT7PpoEnF6VN40QYQ6aG7zM9pllsCioctwKnrTKT3L+TChJsopyvb8?=
 =?us-ascii?Q?VbuXySlCrbolOK/TrjKf1dMOAVh3Yooktxcz5hu42rpA6CZPAOfPjI09ji9f?=
 =?us-ascii?Q?3Zei2XEmL8IbocJG55jhHkqvY5+HHZtL0w40IMuCDCotLLKtPISfP5ewnS5y?=
 =?us-ascii?Q?AQubWCg0tukbZwIggItqEGdsH5c084JimlNJzt1XpHvVTJFN20n/PAO1nLxn?=
 =?us-ascii?Q?warYe7LKzzUeZOuQICQI09XOojGMkSCVrGQdLdGPNNdXxTNkYgB7gjohw5zO?=
 =?us-ascii?Q?SxEXp6QlYphS9J59Jxut2VQfaPdkp7ovtF1Obq+ao3jKnYR5VyBZ0Gk6Z68P?=
 =?us-ascii?Q?+6SmpaeQ5xJUFWBc6FcFghJnJkLE2pcE3N/RlXaCjMg06yiS46pr7B4+lAVq?=
 =?us-ascii?Q?DGL6XN8IBzbGp6agzKTImCcLlTpe+cSkie0YbQs+YVht4iNXng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AqfB+5Y34mVtS+1XkGFujJOmnnrCKe4M6o5on4ojsooXKW8qiS9lwvG+aMMz?=
 =?us-ascii?Q?ywkEIaeO8QQIID4Z9B8Rk50UVhxS8zPzKum0fGYlbyD5lCLhhyGUhaYnXv+d?=
 =?us-ascii?Q?FM/M0y2b1wuonNDL+VIUc/FL5j1Fjz+4VbRQJLu4yVBpHGTrwX9Cv420+gBT?=
 =?us-ascii?Q?9Zp+7lCFH+UzIVY9axRdKWm9+4m9FsHJqL43Vp1V+Po6zCxLOH9vZ4b1Cyof?=
 =?us-ascii?Q?sxT0zER6ld/6cJAoT2OW1SgtEF8YlWUDzY4DxHdOy79ipKigupX/D5FSnbX8?=
 =?us-ascii?Q?7imAJaXwuWHc2+Bc9ve6CAoNsDRP53L45AHOxSme0lZ5DuM390OQ7+zcuRGz?=
 =?us-ascii?Q?/J5XvEUjc7PFjfrpEW6Mo3E6ZsHqEFoyKCEkOasMJ8d0379BTxbIENJwLTzO?=
 =?us-ascii?Q?ICWVM/9nyK6Ikv1IbGQGZUsNpt9AA3HcMmr9X+NgrDavvOzEMUaq+rNNxcnO?=
 =?us-ascii?Q?1EcI1q5ycwCYaeJ5vp3PKao1mIF/512SbEMlm6ZQ+KrKUR6kxLgyTj1oGSkb?=
 =?us-ascii?Q?4UER7XyJhFTG9/XP87uGgXbr3Fcx2Bq+nBnSopyfvuiEsQHCnWiwZHjIMeQV?=
 =?us-ascii?Q?FH5vUC6uY7qSRJar+Cit1fF6lxuDEdoDU7gl/7WcTUf+JmOwKovs3Cn5Y5mz?=
 =?us-ascii?Q?NB8NPDQWu0orCxDKm0yvMwdwVXgIaoC+NNpSuzKtBFc/K7eiF4kepMEHwUVh?=
 =?us-ascii?Q?GfczGVXyvsY+YZWWPg2M4MjFSkHO+6oichRDmB7n8uQ0dQe5LJLUIBFiIi+O?=
 =?us-ascii?Q?zP4tD3+gsh99fLS6EH3J951xTWDW5JEAyRYIuyaHvZnFnbVVQEiOlPp3f8Y0?=
 =?us-ascii?Q?BMA6wFsl1cyTSVHchJ+phbWRNcq410uZA7aBMZO/kwu1QDDyGXFyMUIiM06F?=
 =?us-ascii?Q?KuFpnDhls6CyLdmmDrwFLrVYJmazyIE16y7uMZmMoIXLf2cli/rs+wkOdlhX?=
 =?us-ascii?Q?MkQak0HuxtEDgEUTJ4Dx0tY23Q0PVUS2le7nmHrAYIUQXWOEvXxBBQWMXWS+?=
 =?us-ascii?Q?JOhzrQgBi6U4UDursLLewAwA/m5++qgyDjqg4CSRUbrp7X9sv46x1mdSr6JC?=
 =?us-ascii?Q?DTtSi4qzx2nOFxcUKp6MJ/k35siNLUtR+Y0Cb2i6QjK2KAajzNfIYIG0Ni69?=
 =?us-ascii?Q?sDe/HK3YuIdBEbH6fivDpuWiR+rD18stsGImKKjYNvkMDArHPzrlHchIMfl3?=
 =?us-ascii?Q?g9bt01EuPFxsSIYCWr04SlERjjBzPmHHfDQgVVmuidD+IjDjBrIOw4Djo7/u?=
 =?us-ascii?Q?oqR2Uo4qAbbkc9Qv47bzSxDb3WL8SYfPYtnk6eYTvhx3fiHM5Ee9bGOdkaXI?=
 =?us-ascii?Q?BSkRbJ22ipTJ1Rwoxns60TNgHOF/Xks+Gbic4IhV8cyCLrou3k2Jm5zvAVT4?=
 =?us-ascii?Q?1XIK/ZjQGmXPkpmsgYCGTCa/909Wol+wuATcWRp4JEJHiIqdn03sHzROO5JF?=
 =?us-ascii?Q?+gXNNTmRZQw4z7mVUAPoEs0W3wprxIooHHv8Qti+VZGS+JyRZB0No9koV61v?=
 =?us-ascii?Q?mZIlEnzr7VUdWjGAZJDc+QVr2x89gFOcpfZ4EThpDjA8QkU9WiB8XOuVfrYG?=
 =?us-ascii?Q?xa0hrR4+4Kd0oCp/CoY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB832177862E4E27EB692B4BE2E3932DS7PR12MB8321namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6028ea-7d53-472c-6039-08dccc289151
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 14:56:18.8133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKIEhC5H+8oGD//lzRlLNbEGUUF6/37z+bJMnEpjDrnLb03NfSUsCuGIfUR8wlRGSsz+R3MJgKZSmPJtbhCIpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

--_000_DS7PR12MB832177862E4E27EB692B4BE2E3932DS7PR12MB8321namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This is not a request from a customer. It is surfaced to improve SVM perfor=
mance especially for non-HIP workloads.


Regards,

Ramesh



________________________________
From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Sent: Friday, August 30, 2024 4:01 AM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V3] drm/amdgpu: Surface svm_default_granularity, a RW m=
odule parameter



On 8/29/2024 5:13 PM, Ramesh Errabolu wrote:
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Enables users to update SVM's default granularity, used in
> buffer migration and handling of recoverable page faults.
> Param value is set in terms of log(numPages(buffer)),
> e.g. 9 for a 2 MIB buffer

Forgot asking if this parameter is request from customer or used for
debug/experiment purpose? If it is later, how about put it at debug fs?
There are already many driver parameters.

Regards

Xiaogang

> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 25 +++++++++++++++----------
>   4 files changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index e8c284aea1f2..8eb934af02f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -237,6 +237,7 @@ extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
>   extern int halt_if_hws_hang;
> +extern uint amdgpu_svm_default_granularity;
>   #else
>   static const int __maybe_unused sched_policy =3D KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* =3D false */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b9529948f2b2..442039436cb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum =3D 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
>   bool enforce_isolation;
> +
> +/* Specifies the default granularity for SVM, used in buffer
> + * migration and restoration of backing memory when handling
> + * recoverable page faults.
> + *
> + * The value is given as log(numPages(buffer)); for a 2 MiB
> + * buffer it computes to be 9
> + */
> +uint amdgpu_svm_default_granularity =3D 9;
> +
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -320,6 +330,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int,=
 0444);
>   MODULE_PARM_DESC(msi, "MSI support (1 =3D enable, 0 =3D disable, -1 =3D=
 auto)");
>   module_param_named(msi, amdgpu_msi, int, 0444);
>
> +/**
> + * DOC: svm_default_granularity (uint)
> + * Used in buffer migration and handling of recoverable page faults
> + */
> +MODULE_PARM_DESC(svm_default_granularity, "SVM's default granularity in =
log(2^Pages), default 9 =3D 2^9 =3D 2 MiB");
> +module_param_named(svm_default_granularity, amdgpu_svm_default_granulari=
ty, uint, 0644);
> +
>   /**
>    * DOC: lockup_timeout (string)
>    * Set GPU scheduler timeout value in ms.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 9ae9abc6eb43..d6530febabad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -868,6 +868,12 @@ struct svm_range_list {
>          struct task_struct              *faulting_task;
>          /* check point ts decides if page fault recovery need be dropped=
 */
>          uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
> +
> +       /* Default granularity to use in buffer migration
> +        * and restoration of backing memory while handling
> +        * recoverable page faults
> +        */
> +       uint8_t default_granularity;
>   };
>
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index b44dec90969f..624bfe317c9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange=
, bool do_unmap)
>   }
>
>   static void
> -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_lo=
c,
> -                                uint8_t *granularity, uint32_t *flags)
> +svm_range_set_default_attributes(struct svm_range_list *svms,
> +                       int32_t *location, uint8_t *granularity,
> +                       int32_t *prefetch_loc, uint32_t *flags)
>   {
>          *location =3D KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>          *prefetch_loc =3D KFD_IOCTL_SVM_LOCATION_UNDEFINED;
> -       *granularity =3D 9;
> +       *granularity =3D svms->default_granularity;
>          *flags =3D
>                  KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHE=
RENT;
>   }
> @@ -358,9 +359,8 @@ svm_range *svm_range_new(struct svm_range_list *svms,=
 uint64_t start,
>                  bitmap_copy(prange->bitmap_access, svms->bitmap_supporte=
d,
>                              MAX_GPU_INSTANCE);
>
> -       svm_range_set_default_attributes(&prange->preferred_loc,
> -                                        &prange->prefetch_loc,
> -                                        &prange->granularity, &prange->f=
lags);
> +       svm_range_set_default_attributes(svms, &prange->preferred_loc,
> +               &prange->granularity, &prange->prefetch_loc, &prange->fla=
gs);
>
>          pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>
> @@ -2694,9 +2694,10 @@ svm_range_get_range_boundaries(struct kfd_process =
*p, int64_t addr,
>          *is_heap_stack =3D vma_is_initial_heap(vma) || vma_is_initial_st=
ack(vma);
>
>          start_limit =3D max(vma->vm_start >> PAGE_SHIFT,
> -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
> +                     (unsigned long)ALIGN_DOWN(addr, 1UL << p->svms.defa=
ult_granularity));
>          end_limit =3D min(vma->vm_end >> PAGE_SHIFT,
> -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
> +                   (unsigned long)ALIGN(addr + 1, 1UL << p->svms.default=
_granularity));
> +
>          /* First range that starts after the fault address */
>          node =3D interval_tree_iter_first(&p->svms.objects, addr + 1, UL=
ONG_MAX);
>          if (node) {
> @@ -3240,6 +3241,10 @@ int svm_range_list_init(struct kfd_process *p)
>                  if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>                          bitmap_set(svms->bitmap_supported, i, 1);
>
> +       /* Update default granularity to one bound by user/driver */
> +       svms->default_granularity =3D min_t(u8, amdgpu_svm_default_granul=
arity, 0x1B);
> +       pr_debug("Default SVM Granularity to use: %d\n", svms->default_gr=
anularity);
> +
>          return 0;
>   }
>
> @@ -3767,8 +3772,8 @@ svm_range_get_attr(struct kfd_process *p, struct mm=
_struct *mm,
>          node =3D interval_tree_iter_first(&svms->objects, start, last);
>          if (!node) {
>                  pr_debug("range attrs not found return default values\n"=
);
> -               svm_range_set_default_attributes(&location, &prefetch_loc=
,
> -                                                &granularity, &flags_and=
);
> +               svm_range_set_default_attributes(svms, &location,
> +                               &granularity, &prefetch_loc, &flags_and);
>                  flags_or =3D flags_and;
>                  if (p->xnack_enabled)
>                          bitmap_copy(bitmap_access, svms->bitmap_supporte=
d,
> --
> 2.34.1
>

--_000_DS7PR12MB832177862E4E27EB692B4BE2E3932DS7PR12MB8321namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This is not a request from a customer. It is surfaced to improve SVM perfor=
mance especially for non-HIP workloads.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<p style=3D"margin: 0in; font-family: Calibri, sans-serif; font-size: 11pt;=
"><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Regards,</span></p=
>
<p style=3D"margin: 0in; font-family: Calibri, sans-serif; font-size: 11pt;=
"><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Ramesh</span></p>
<p style=3D"margin: 0in; font-family: Calibri, sans-serif; font-size: 11pt;=
"><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">&nbsp;</span></p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Xiaogang &lt;Xi=
aogang.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, August 30, 2024 4:01 AM<br>
<b>To:</b> Errabolu, Ramesh &lt;Ramesh.Errabolu@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH V3] drm/amdgpu: Surface svm_default_granularity,=
 a RW module parameter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 8/29/2024 5:13 PM, Ramesh Errabolu wrote:<br>
&gt; Caution: This message originated from an External Source. Use proper c=
aution when opening attachments, clicking links, or responding.<br>
&gt;<br>
&gt;<br>
&gt; Enables users to update SVM's default granularity, used in<br>
&gt; buffer migration and handling of recoverable page faults.<br>
&gt; Param value is set in terms of log(numPages(buffer)),<br>
&gt; e.g. 9 for a 2 MIB buffer<br>
<br>
Forgot asking if this parameter is request from customer or used for <br>
debug/experiment purpose? If it is later, how about put it at debug fs? <br=
>
There are already many driver parameters.<br>
<br>
Regards<br>
<br>
Xiaogang<br>
<br>
&gt; Signed-off-by: Ramesh Errabolu &lt;Ramesh.Errabolu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++=
++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp; |&nbsp; =
6 ++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; | 2=
5 +++++++++++++++----------<br>
&gt;&nbsp;&nbsp; 4 files changed, 39 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index e8c284aea1f2..8eb934af02f2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -237,6 +237,7 @@ extern int sched_policy;<br>
&gt;&nbsp;&nbsp; extern bool debug_evictions;<br>
&gt;&nbsp;&nbsp; extern bool no_system_mem_limit;<br>
&gt;&nbsp;&nbsp; extern int halt_if_hws_hang;<br>
&gt; +extern uint amdgpu_svm_default_granularity;<br>
&gt;&nbsp;&nbsp; #else<br>
&gt;&nbsp;&nbsp; static const int __maybe_unused sched_policy =3D KFD_SCHED=
_POLICY_HWS;<br>
&gt;&nbsp;&nbsp; static const bool __maybe_unused debug_evictions; /* =3D f=
alse */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index b9529948f2b2..442039436cb3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum =3D 32;<br>
&gt;&nbsp;&nbsp; char *amdgpu_disable_cu;<br>
&gt;&nbsp;&nbsp; char *amdgpu_virtual_display;<br>
&gt;&nbsp;&nbsp; bool enforce_isolation;<br>
&gt; +<br>
&gt; +/* Specifies the default granularity for SVM, used in buffer<br>
&gt; + * migration and restoration of backing memory when handling<br>
&gt; + * recoverable page faults.<br>
&gt; + *<br>
&gt; + * The value is given as log(numPages(buffer)); for a 2 MiB<br>
&gt; + * buffer it computes to be 9<br>
&gt; + */<br>
&gt; +uint amdgpu_svm_default_granularity =3D 9;<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * OverDrive(bit 14) disabled by default<br>
&gt;&nbsp;&nbsp;&nbsp; * GFX DCS(bit 19) disabled by default<br>
&gt; @@ -320,6 +330,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, i=
nt, 0444);<br>
&gt;&nbsp;&nbsp; MODULE_PARM_DESC(msi, &quot;MSI support (1 =3D enable, 0 =
=3D disable, -1 =3D auto)&quot;);<br>
&gt;&nbsp;&nbsp; module_param_named(msi, amdgpu_msi, int, 0444);<br>
&gt;<br>
&gt; +/**<br>
&gt; + * DOC: svm_default_granularity (uint)<br>
&gt; + * Used in buffer migration and handling of recoverable page faults<b=
r>
&gt; + */<br>
&gt; +MODULE_PARM_DESC(svm_default_granularity, &quot;SVM's default granula=
rity in log(2^Pages), default 9 =3D 2^9 =3D 2 MiB&quot;);<br>
&gt; +module_param_named(svm_default_granularity, amdgpu_svm_default_granul=
arity, uint, 0644);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: lockup_timeout (string)<br>
&gt;&nbsp;&nbsp;&nbsp; * Set GPU scheduler timeout value in ms.<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 9ae9abc6eb43..d6530febabad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -868,6 +868,12 @@ struct svm_range_list {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_stru=
ct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *faulting_task;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check point t=
s decides if page fault recovery need be dropped */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts[MAX_G=
PU_INSTANCE];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Default granularity to use in=
 buffer migration<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and restoration of backi=
ng memory while handling<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * recoverable page faults<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t default_granularity;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;<br>
&gt;&nbsp;&nbsp; /* Process data */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_svm.c<br>
&gt; index b44dec90969f..624bfe317c9c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; @@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *pra=
nge, bool do_unmap)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp; static void<br>
&gt; -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch=
_loc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *granularity, uint32_t *=
flags)<br>
&gt; +svm_range_set_default_attributes(struct svm_range_list *svms,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *lo=
cation, uint8_t *granularity,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *pr=
efetch_loc, uint32_t *flags)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *location =3D KF=
D_IOCTL_SVM_LOCATION_UNDEFINED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *prefetch_loc =
=3D KFD_IOCTL_SVM_LOCATION_UNDEFINED;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity =3D 9;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity =3D svms-&gt;defaul=
t_granularity;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_=
SVM_FLAG_COHERENT;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -358,9 +359,8 @@ svm_range *svm_range_new(struct svm_range_list *sv=
ms, uint64_t start,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access, svms-=
&gt;bitmap_supported,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes=
(&amp;prange-&gt;preferred_loc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;prange-&gt;prefetch_loc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;prange-&gt;granularity, &amp;prange-&gt;flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes=
(svms, &amp;prange-&gt;preferred_loc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;prange-&gt;granularity, &amp;prange-&gt;prefetch_loc, =
&amp;prange-&gt;flags);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;s=
vms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);<br>
&gt;<br>
&gt; @@ -2694,9 +2694,10 @@ svm_range_get_range_boundaries(struct kfd_proce=
ss *p, int64_t addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack =
=3D vma_is_initial_heap(vma) || vma_is_initial_stack(vma);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_limit =3D =
max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DO=
WN(addr, 2UL &lt;&lt; 8));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DO=
WN(addr, 1UL &lt;&lt; p-&gt;svms.default_granularity));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_limit =3D mi=
n(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 2UL =
&lt;&lt; 8));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 1UL =
&lt;&lt; p-&gt;svms.default_granularity));<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First range t=
hat starts after the fault address */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =3D interva=
l_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node) {<br>
&gt; @@ -3240,6 +3241,10 @@ int svm_range_list_init(struct kfd_process *p)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-=
&gt;dev-&gt;adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bitmap_set(svms-&gt;bitmap_supported, i, 1);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update default granularity to=
 one bound by user/driver */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;default_granularity =3D=
 min_t(u8, amdgpu_svm_default_granularity, 0x1B);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Default SVM Granu=
larity to use: %d\n&quot;, svms-&gt;default_granularity);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -3767,8 +3772,8 @@ svm_range_get_attr(struct kfd_process *p, struct=
 mm_struct *mm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =3D interva=
l_tree_iter_first(&amp;svms-&gt;objects, start, last);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range attrs not found return=
 default values\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; svm_range_set_default_attributes(&amp;location, &amp;prefet=
ch_loc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;granul=
arity, &amp;flags_and);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; svm_range_set_default_attributes(svms, &amp;location,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;granularity, &amp;prefetch_loc, &=
amp;flags_and);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags_or =3D flags_and;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bitmap_copy(bitmap_access, svms-&gt;bitmap_supported,<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS7PR12MB832177862E4E27EB692B4BE2E3932DS7PR12MB8321namp_--
