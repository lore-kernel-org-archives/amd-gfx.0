Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9775DC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 04:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5085C10E4B5;
	Tue, 30 Jul 2024 04:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bA4hGpfx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E833610E4B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 04:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfIodhhalJfe98lDodmADm3uJPRryIf7q+LHZMkgAoPGDancNnW475TyeoYR+V2QM16qHtA3YrXpd41nZ0TQLKo8obXSjmlHOuuZ6dq6VYieoMZKHpkLufjVY/c4WoWCHSwJidNAasogPQXFoQCPOKIZy99XiJp2UX7o1WmArtQJ3NRVctW3FMxxhV0/UzfWlbKhE52eez2fmJLKi3NJqLFYw84waJxivw6NF5T9Fi6bkgCNwuQDLvkFNoKh/epoVNLiHFC0Mc2RYEDTEQjT7HJ6lzddPr28UswJFQKPmkMXTTwY4mMr6hkd/VoDPex4clzNzbfkDv17+Ef9QZjaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ac+3l/sk8PzsgYnR3Z1G1RG4ayccLjrBAw5cnY0wzk=;
 b=Tg5G0rJPy1lu6ATftL2QWCdJbizLeIQHpYCjHKihVjQQnc7e1392KTcalA01PzLw0X/PBYoM1AdvVW4aB7mC2FBQASHZ09nlxEvcfVJNjNYv+TSgHmCLkK14H8avsNRnU6DS+TXVFoSGjGzTy4ONwatZt087fUpuu/ZRIq0qfXm/DLcV+NFKSJi4TfQkhQeZH4Qn4QMzkkOT0C+uz2Njr9tIHQ8Tmcr/fjqjhg3kjSiQpNyjSOukgVD3SZAMuTTOtPhpbsERWN1OK6okdWOD5eIU15rzh5zTBnMWoPMTTr/sZlDcgOpR6xcgKpr6WwIEISQT2aRLayodAAy4X/6hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ac+3l/sk8PzsgYnR3Z1G1RG4ayccLjrBAw5cnY0wzk=;
 b=bA4hGpfx2Jr1nYM/IpQId2cdyJOwBmokG0+X8wCNiyb884nKrH4vzKJnQvVIrDa/pnkKuPrXcob64c6rBPLQRUwLmMjI9po48ARevbJ2lCmk0J11+57Me4OqinV1/zAyqxVXXLL7iSDKaiqcXRsdfpEpayyNJRNi7DR30LKUh0k=
Received: from DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) by
 SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Tue, 30 Jul
 2024 04:45:44 +0000
Received: from DS7PR12MB8084.namprd12.prod.outlook.com
 ([fe80::36b0:212a:1d6f:6559]) by DS7PR12MB8084.namprd12.prod.outlook.com
 ([fe80::36b0:212a:1d6f:6559%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 04:45:43 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use CPU for page table update if SDMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: use CPU for page table update if SDMA is
 unavailable
Thread-Index: AQHa4jo3B9kCIGG5LU+1dqBSXEqwH7IOsIcQ
Date: Tue, 30 Jul 2024 04:45:43 +0000
Message-ID: <DS7PR12MB8084D14F073863C42606396BF6B02@DS7PR12MB8084.namprd12.prod.outlook.com>
References: <20240730043652.1455274-1-yifan1.zhang@amd.com>
In-Reply-To: <20240730043652.1455274-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=59908322-951e-49e6-8bc1-a19fa7526a48;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-30T04:40:00Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8084:EE_|SN7PR12MB8770:EE_
x-ms-office365-filtering-correlation-id: e90648e6-a3a1-494d-edac-08dcb05278a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uDL0IuV9kOIL29yMnA6hR5Pt/iW7nRI4X5hH60xYw844NAiCxVMrteh9X5?=
 =?iso-8859-1?Q?z49Kzal9PXe9pHbzt8kKMa1cjBGvweFusbG5nV7RlhyvjGE9dZ3bFlNxrh?=
 =?iso-8859-1?Q?Y9w1aSRk9m0NLCNJia5sT7HMrxnJD36yN4FVtx41xGIc+GmNUsMXVjngOl?=
 =?iso-8859-1?Q?fKfH8+hBXiCfs5cWX0ajhMKNH5zVLiLtbMc7fnEcONuwao7HJa9fDYGdR/?=
 =?iso-8859-1?Q?GLD7zJjBRIk5z6sdYF/U0AoncwWCnSxkIuqbg7MbWY204xJSI7IQxZ4syt?=
 =?iso-8859-1?Q?RJzY6rIeaJg4QA/mAxJMKhp366SafYIiPXKrNwHm1HhNdolturbWZO66L2?=
 =?iso-8859-1?Q?UwRklJ0W1JmFd1FkEw4XnVSQAkpA8+D6Qdv+OHqnkPGImB9KYBXWj+vlxi?=
 =?iso-8859-1?Q?fVEXcRGQUiJsV8XbudDV99EEkHyS+wFgAgKLumapvVYOymttybrPZOh9nd?=
 =?iso-8859-1?Q?HqZhYOWczFZBp1Xzs1fGxAB553SlN+oQwt7tYIKWUL0/evT0Hc2kVtmkbB?=
 =?iso-8859-1?Q?vbQgZC6I5Zg2RMWAnfMCwgBBUPMbJtqlKMB4EDk/++L2lOBS7SaEHy8jPn?=
 =?iso-8859-1?Q?ssE4Vruze/Pbt0r0PhOpdnzIrI5dEXcgSkrGFdYd/0Uslu+Kk3KsCP8qhX?=
 =?iso-8859-1?Q?biZrQ6hpjQkZDyX0mEy+hfzmN9B6ZDlH2iQf010Bmq0tZ4Gzodu/HaAsMM?=
 =?iso-8859-1?Q?Q1sHS4piHhLPD4bDoKHxZBeTuth2ws5LmgegC8O9gZ/dAPBxk+fBKhoBIZ?=
 =?iso-8859-1?Q?cc6wxJJdPWPhuziR1ogcWrSuuiU7vw76DAY2Gdweis+8gqGpTGRd4VyJhm?=
 =?iso-8859-1?Q?LOSjpfFWfJj57l/U1ubI4TyQLAnanGcynqNIUM0qYkh3z07/O71ksg6K90?=
 =?iso-8859-1?Q?IVPG81aj+o4tPzHDYH5cn2M6CGM3uvAvOd6n1+yO89I48VUj2dcJcbiHlM?=
 =?iso-8859-1?Q?vHgdK6AlLGml3buKNu5szsZG5aMNmm4QlOMcypAD2NhUqu1NGsy+tHIHRY?=
 =?iso-8859-1?Q?cdLvsGN13DJSR0MU3PPhLmZRhvx0i2dtw3mCHtFGJtH1gYNJX9NLsC4yGF?=
 =?iso-8859-1?Q?duoSccCbthdCwQ5PRrCFLtRAK0OmM+4VWgYeLa+CCcokOUpwtwRJEVdoUz?=
 =?iso-8859-1?Q?StG6Fqgrqh44OdtD7ScGfNPH7XB54N9n+E1KajhAZTBittjC397QOMocSe?=
 =?iso-8859-1?Q?BHDPjsFpzQrrG13CQz+To4uZWL3BaqsSqyfTvBmgSw+O1lOmlxwr+LQmWW?=
 =?iso-8859-1?Q?P1OREuz9Wkxj9u6NowRfVUFWqP6Lm+LJFW09ZeVdErV2U7ta90kISy1be6?=
 =?iso-8859-1?Q?gLMffH7pSiMfgy0vZGNU6JaElC+PKEoATIuU7Pf4aFb04j1qR7tsS1+ADD?=
 =?iso-8859-1?Q?U5h7ihxXnaJKM9ktD1Fexxae/NIlZozSgQGkY7ZlVHEM5hNxw+vIFn4UvH?=
 =?iso-8859-1?Q?rloMS3F7ELdVBn7CLPzWZ0HTTi356ZiD7mfxvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K2TPWV4fRbb9zSFSwH+4NlncniXrywFSW4/wgyVyFC7egAGPtTcdgptKOf?=
 =?iso-8859-1?Q?hMvpZheHlfzSxXsT1HmuI8rURPvJRyVvuqNTJbF1qeKX6xQqYp8ygM6kE9?=
 =?iso-8859-1?Q?6upL+UC1WFOjWUh9KrsIXQKA/TEYo3YvgO3VmYDhM5lgMeWKzp+se9e5Gh?=
 =?iso-8859-1?Q?5suifHwCsJG9qDxH52XaqEsp4XWYqfhzyf2tf+YbMlbuEuZGB1x65VsZrM?=
 =?iso-8859-1?Q?sR8GYla+bcK+HGzQZ+TDraLtq3Svtj0FoOca4sTtVJROOjREfpqsbVqbhL?=
 =?iso-8859-1?Q?3qIEqJDyDP4nQbVoidYiswXOb/R86alEbF1LwQEbWFnqt9UBCFhh9A4Ei6?=
 =?iso-8859-1?Q?Wvqu/xQCNhD6vSsPuH9/LNRQk/JFVpvvcNfCQxP/aoJ4du+WBDWvDoArob?=
 =?iso-8859-1?Q?S/XTHXIS4Rl2K/Y/7rgzbVekKhlonCZ73VM8JYwlcC5otSlmxwN3DBdcK0?=
 =?iso-8859-1?Q?dPg7Cd4zXLwXJ7l63X9AwZOzOijhBPuwkCfpc9SG1/Qnl0vHKedHJGOKpC?=
 =?iso-8859-1?Q?szHwOvEN1/qlMQGGd4LN2cRBzRhsMkYzopd7Dl81nShy4A98NLjtat4TTU?=
 =?iso-8859-1?Q?m6Nr4kgm4GYnbbPRmlv4OiMcSXl/K0qiEsZ8cZbx/PSgyNZAr60XzgYm47?=
 =?iso-8859-1?Q?YsiVhRQ9zVZsHAZjkEecUt+3Xp4xIj6Gp/vB0CZPbuTxC4inwRN31W7oHp?=
 =?iso-8859-1?Q?feqUEDqJ1oZKTJmqrpGDoAGZyKr45yEe5UNCp5H329dLAwFrUbW2qAlHFN?=
 =?iso-8859-1?Q?cUrYSgnT2FLUY/JG2Y+FsRqO82SGYVy8mqgwyMAdTUI8NgGzw18ghSustQ?=
 =?iso-8859-1?Q?+Ac1wdt5UAEO/vv/80e4COUXn82VcfxvrLVoDV/Vpc+Ng+0iieWNivJfxl?=
 =?iso-8859-1?Q?BP+S/+mBj6tWIYTK0S6ggtzWs0WwZ2lBmCYvzO7yN3YRZKNUrq7lEcSm7W?=
 =?iso-8859-1?Q?qo6xf0o+mcSBVPQyIV/8NH4E8KGkhx8IyG0mExy6uhkQrVq8sucuKK086z?=
 =?iso-8859-1?Q?xmbZrNZoxrvlKXwcT30Khxspb3+cPfRazv5q2sYKfNAJhvt/pxIBzcNVCW?=
 =?iso-8859-1?Q?w+8XaukDPF6OIDQ8YhKZycXLKKeZikTZeiAp0JvbqxY3Ftgxv0lTHNZkOV?=
 =?iso-8859-1?Q?tfoFkSbaReUUVJCC1asmBKVUhdx5H8uZz2zjfnz4Sv0K6bSUd4qPG3aDIx?=
 =?iso-8859-1?Q?/rtlBGNGLWP5Ev4As42tdNF1XpCkDoc9O5gXLXr//sGZKKzVM3PCBd7FW4?=
 =?iso-8859-1?Q?jjSkOOje62hLNYNfYDr7KYMJn8fouFVpwMzIVW8YTQbMIAroM0IUe3FZaY?=
 =?iso-8859-1?Q?QtXMiOLrFYGNBU3oUtpust9L64Nz6kGdfWlyzZFNPJ+/MdROFQHVMB6ky8?=
 =?iso-8859-1?Q?GFn4spLIme6DCAhwG8RM6waZ15n3eth60mw+MWI1E9R3CtCcYcub9Ha6zF?=
 =?iso-8859-1?Q?K89ecwfqP1k0xGPipR9vJnIe3QjsfvuxW9aqkb6I0RPVJL2CCTat5c3BCV?=
 =?iso-8859-1?Q?vvf9KZrFf15ahVkfct7TA9cODrTrsmtRSwZy4xD5TqttcvCsBtxh/a8NzZ?=
 =?iso-8859-1?Q?Ke0fNFpdJ+490B9SOBX2drz8K7ITugTOaGZgVITpaQbLnSeU6RkfNoEKR3?=
 =?iso-8859-1?Q?fEFlzQHyTI3gQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90648e6-a3a1-494d-edac-08dcb05278a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 04:45:43.7098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ia7Q7gLiSFZMkxYHyiPiCKTB55GBvSsHepNHmrkp8t1SYwWdoOti3U/b8QXC9eSCMuSYg7VrjsZq/cPbf3svJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
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

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan
> Zhang
> Sent: Tuesday, July 30, 2024 12:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: use CPU for page table update if SDMA is
> unavailable
>
> avoid using SDMA if it is unavailable.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a060c28f0877..bcb729094521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2397,6 +2397,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm
> *vm)  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm
> *vm,
>                  int32_t xcp_id)
>  {
> +     struct amdgpu_ip_block *ip_block;
>       struct amdgpu_bo *root_bo;
>       struct amdgpu_bo_vm *root;
>       int r, i;
> @@ -2426,6 +2427,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm,
>       vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
>                                   AMDGPU_VM_USE_CPU_FOR_GFX);
>
> +     /* use CPU for page table update if SDMA is unavailable */
> +     ip_block =3D amdgpu_device_ip_get_ip_block(adev,
> AMD_IP_BLOCK_TYPE_SDMA);
> +     if (!ip_block || ip_block->status.valid =3D=3D false)
> +             vm->use_cpu_for_update =3D true;
> +
>       DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                        vm->use_cpu_for_update ? "CPU" : "SDMA");
>       WARN_ONCE((vm->use_cpu_for_update &&
> --
> 2.37.3

