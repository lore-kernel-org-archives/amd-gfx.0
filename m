Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F63C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 11:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F70810E171;
	Mon,  8 Jan 2024 11:34:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B50D10E171
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 11:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtAaIMiWejzLdlZX3JJw/+PWlXKiIgx8m50UCGwt61MyYlcBV8k43GL5n2+XfLIpWUcF/uOMJeMuwwZmwEOj2ykPL8uzuEona8prRqL0LALtXVLnSjg7rVWNtwV7asw7hRfU2BYkJWS/P1cuAASqVPp+dM8nr3Y7P3nUAFKRyfCHZAAUvujadUG6LNkN7W0QOQ/s36dz+OpLU2FdypkemG8gmGHoCdgSjPNVaOZH67JyDFCfELbvKO5GG67S/vRtYtKp/AAT8UM3u/JwS/6IUW1/aVaWWyaZbC+jJnc7i20rADXHz/wVjPrKddCRXlwuVLTxn1wAKsI0/r0VjNtxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbn0RJ5UEthE0jO7eLsY5k6Le/DG4deYWu6NZ6R/IZ4=;
 b=Gi72OHUsbNihpqfLWpRrNgxmflwvsDS0YafrvKTT6/6rrpaniF5ALPLSgqdaoQ/sTFcscjA/dTzxL1jcZp3MU934XkTc3NlJkF+PhYxXDTPMxd2yn8Y4fCA97ANb3F6HaSd75M/8IAPJyuuR1T8pt/z+DVVF9SMih+7AeNBBXkh43AquRHfB5Kbnl+JOF2ac42Vav1s1uvOCWJXJNzvatWbUUrD7/J8p3BOPKcWzFypOhvwrudLZTkBOeWmdlFaR3pkstEwGReNHeEW5o4lw6+OTEnf0I8wC2f4J2/GGn58LsHR8v7he5XeviTj8LByhVmbRT3QQw50jUFyYCFNomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbn0RJ5UEthE0jO7eLsY5k6Le/DG4deYWu6NZ6R/IZ4=;
 b=Pd6FOO5ruQ7jKJO+sxDp6MqlYlCUOU5acJ6cvyxUozpM22nIfH3cAop5qjF33dw5oXpgB10dyRitaAUSMROsWDIjBnv00NCGAkuNZScH/QCd7roZVH6FNznPeVPY+5qm/w3Hg3S4V85aOoD+j9RYqw+eE98pnrj9DdMbHCeF2T4=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 11:33:59 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:33:59 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH v2 v2 3/5] drm/amdgpu: Add ras helper to query boot errors
 v2
Thread-Topic: [PATCH v2 v2 3/5] drm/amdgpu: Add ras helper to query boot
 errors v2
Thread-Index: AQHaQX/unTRwGcEe/Em4YesJfNUTa7DPyJqg
Date: Mon, 8 Jan 2024 11:33:59 +0000
Message-ID: <PH0PR12MB5404B5520BFC6BAEFDB4E86DF66B2@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
 <20240107154011.12927-8-Hawking.Zhang@amd.com>
In-Reply-To: <20240107154011.12927-8-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22ccc2e6-cf7d-45bc-8e9e-bfea87cb07ff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T11:28:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|IA1PR12MB6628:EE_
x-ms-office365-filtering-correlation-id: 2b8af7a6-3ce0-48dd-da82-08dc103db4d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hOBGM89EqooQsgvcImpEIBRMwVvl9QZOKEmNWQWSJyRAmWWf/fk1R8YkPr5UEgKWGjoAWDyoj4WjN89HmzL7j6ke2SqRHACIGa5agFWbfDRHYw3IbrvquLaM/bwgVlrx4HoF3zLDEMLN9zY2Pnmm9HbZ8ZNA3eXhCtYqOl3G+esTX0sgQqP9uvdbPrAWetVaLlbRsoNYWXszV7sGyA/7wBwMwEyIJSf0bleEiK3Q3ZwIcIhgmURDXBIj1YL4AVcpD25plZsxLoEFuM0e6N4/xMPjhuVCViwt4D/A73ninFR4IsQusjYA+4JC82ANTEqfn1li+pHX9t+avGOLLy1kX7hSslNsrCu/WYAsrwX4xn+Tu7XqVfYYKkhJk86Tc+hu2edTzeA8gxWOv0kOhcnhsS07v0WLyNkda/5+7n/zsHGDRhILyHTC9zCS0SIjmH5bZAbcR8U2/gcAPJvztAS28lGd/QoAmqHY+PMCVlgpxJzGgEtbWRxxI1Y4EglmwJ38dBZK3InrWUDQfayedILcasBckUyanVAzEi8MK+qBmps6R1BMs/hg0AnZinx1m/OLgTUMy4PUDr+X6uVWpi+ckv2HSaFzb1vTCQkkkFC3Pj6PmT4MxY+ncvRsVL2I6whJ1i7ecmjQI9Nv5/NF+Agng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(122000001)(38070700009)(921011)(55016003)(86362001)(83380400001)(26005)(9686003)(53546011)(6636002)(110136005)(54906003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(478600001)(52536014)(71200400001)(6506007)(7696005)(8676002)(8936002)(33656002)(41300700001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WI+Ebw3RMoAFf0+cM8HWqhFirHk7BBDLRrLvwM0e6qebkJT5UHch9biksniC?=
 =?us-ascii?Q?EIM3aIqpWWKn2lcTX3dRQhk+9gE3TSkhaWkTRjUx6Zw5Kmc47fkKhgssPYNB?=
 =?us-ascii?Q?YWt0iXk5p/f5IU3jogK6GPjxxQkbxs+eW6OKWqe+FcXmd6GjzpLeI0Sy7rLa?=
 =?us-ascii?Q?/a6udCYsTojI7xOgZFp1ozyVZY530Qs9tJoMOIHM+Eba4fgaIWwr+/S/MWwe?=
 =?us-ascii?Q?gsP4tW5sZbMHz+wwo1XJixi5cfIfyolf0jDUSbM7uEvlImEgNrhpci6jGWF9?=
 =?us-ascii?Q?NVm0hFOU82F9OXxXM+qdeMm5SgZHqZbadYlmFyIKA7T8saMJLDvZPZOAn1cz?=
 =?us-ascii?Q?Ro+FTXo7His3J9fKCdIedO+QLQGqq+xqFlKo3WqAIHfBwgOilYlYw3DeqqUs?=
 =?us-ascii?Q?YhpIG3Xi9Cz37qnG21tTSDlIypJV+FEc2RujS/gfDXah1Sa3th7Qz5HZl9zY?=
 =?us-ascii?Q?FXB1EleJ1j0XSR0DUbnGeYWz51grCeP3f+VLWHVxkXsqBJt37NDocLdk9A5J?=
 =?us-ascii?Q?OQfLmYWrtcne2NP3ryTzSs5K7ERHx7oZFgK7ywXSLWVJ4AZTbzX+7zKTI9ZJ?=
 =?us-ascii?Q?RhxHxcjUh7FzOH/ajcPUZakQnkkhE1NHze/O3TcafSp7J82/A6ebcuy5nBXY?=
 =?us-ascii?Q?untJJ9widw+AyAKdZ6d3SC6qUISqzo42VMyf09cmiViF6/6Daep7seSRFRZo?=
 =?us-ascii?Q?JJD56xtaXqDwqoQqtoqwWWN0/1UJtjPN1EOOoDP0gJg41y0rTchK5+e7AgI/?=
 =?us-ascii?Q?L/deX08W3/rKJw6xkdbN7I767V/OJgh1IIBGVPbuJ6bLglE9GghaVJO2xrYu?=
 =?us-ascii?Q?gUEJ4FYzHj3pB+8us7ikYFk9oqoyOY5YLvgmeNwOUxatPZSQeaUlA5ciidSx?=
 =?us-ascii?Q?DQLkDuACoCWGxDdRvLJW9UpC435B/7odY/Rb8PlyJ0KB3DLOzcRRfSwNmKVk?=
 =?us-ascii?Q?T9bFgoaWAu+npTD5QszUUqFOVE4npoFOJCq0MQIG5xDx4U2IJ3Sc8SlK8djD?=
 =?us-ascii?Q?gh8hPFuuRjqAHLpDe5CrxZ097Szk+m0DsI/Z49y5Vtk/5feiVYELwhA8ydji?=
 =?us-ascii?Q?d5m9ZByYDgLzzhYaa8g2bKaIi7+yiYdqSqgVMnwvyA8nE18VyYPb0rMEPt2G?=
 =?us-ascii?Q?I7SLdRTY7KGy4hxzry/X7XwmdIrORziSziwO70CJO0YEDpuhI0slOBuZqlMA?=
 =?us-ascii?Q?PkRjdq1fGPzkZDck+cyWMJ6fOLfBnLbZZEwr5kihWc/LCEyIzw89XoarzAn5?=
 =?us-ascii?Q?qwY1CLvj3PZA04k1USAqQG902WaNNnEUBxOxhKJQNqjez3hUv8fkvngFd3Ae?=
 =?us-ascii?Q?It164voqSfNXsZV6UDldKXtT2lPH7E8GggK3fbEjpvVEFUmZq6OYeXwp3j6k?=
 =?us-ascii?Q?nY9TKcV8ZbeVWrubtKZYqj7/LMjyAv6fdsw5LtUyD1EGh+7uGVrHCjEHsO5d?=
 =?us-ascii?Q?DHZv0YIRhYuBTAm/JFmFi7uMe2aLAXGBhOXlFrlse+Ho+m8x1KAKi8EixT9Z?=
 =?us-ascii?Q?uzZy8r7+TvuyR5Uk1AsaFH9SGBzEPvgZC5yLy3qEp/Kc0s2WkslHysbzUGOn?=
 =?us-ascii?Q?lebYd7YC3ZFxQe+qzJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8af7a6-3ce0-48dd-da82-08dc103db4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 11:33:59.2557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6cUtlYsMaqqkIxYLiyuJUWyt56JXy8oGgpZKI/NlYs7ORh08ISl7OfQNl5RzG6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The patch series is Reviewed-by: Le Ma <le.ma@amd.com> .

If pattern is changed on future asic, we may consider using macro of asic f=
unction callback as well.

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Sunday, January 7, 2024 11:40 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH v2 v2 3/5] drm/amdgpu: Add ras helper to query boot error=
s v2
>
> Add ras helper function to query boot time gpu errors.
> v2: use aqua_vanjaram smn addressing pattern
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |
> 15 +++-
>  3 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9da14436a373..df3aa69be425 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1330,6 +1330,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define WREG32_FIELD_OFFSET(reg, offset, field, val) \
>       WREG32(mm##reg + offset, (RREG32(mm##reg + offset) &
> ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> +#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) & GENMASK_ULL(h, l)) >>
> +(l))
>  /*
>   * BIOS helpers.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index fc42fb6ee191..a901b00d4949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3763,3 +3763,98 @@ int amdgpu_ras_error_statistic_ce_count(struct
> ras_err_data *err_data,
>
>       return 0;
>  }
> +
> +#define mmMP0_SMN_C2PMSG_92  0x1609C
> +#define mmMP0_SMN_C2PMSG_126 0x160BE
> +static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device
> *adev,
> +                                              u32 instance, u32 boot_err=
or)
> +{
> +     u32 socket_id, aid_id, hbm_id;
> +     u32 reg_data;
> +     u64 reg_addr;
> +
> +     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> +     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> +     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> +
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +
> +     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw
> status is 0x%x\n",
> +             socket_id, aid_id, reg_data);
> +
> +     if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory
> training failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, firmware load fai=
led
> at boot time\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, wafl link trainin=
g
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, xgmi link trainin=
g
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr cp link train=
ing
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr dp link train=
ing
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> memory test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist
> test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +}
> +
> +static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
> +                                          u32 instance, u32 *boot_error)=
 {
> +     u32 reg_addr;
> +     u32 reg_data;
> +     int retry_loop;
> +
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +
> +     for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
> +             reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> +             if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
> +                     *boot_error =3D reg_data;
> +                     return 0;
> +             }
> +             msleep(1);
> +     }
> +
> +     *boot_error =3D reg_data;
> +     return -ETIME;
> +}
> +
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances) {
> +     u32 boot_error =3D 0;
> +     u32 i;
> +
> +     for (i =3D 0; i < num_instances; i++) {
> +             if (amdgpu_ras_wait_for_boot_complete(adev, i, &boot_error)=
)
> +                     amdgpu_ras_boot_time_error_reporting(adev, i,
> boot_error);
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 76fb85628716..5785b705c692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -32,6 +32,19 @@
>
>  struct amdgpu_iv_entry;
>
> +#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 0, 0)
> +#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)
>       AMDGPU_GET_REG_FIELD(x, 1, 1)
> +#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 2, 2)
> +#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 3, 3)
> +#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 4, 4)
> +#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 5, 5)
> +#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 6, 6)
> +#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 7, 7)
> +#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
> +#define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
> +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 13, 13)
> +#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
> +
>  #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS                (0x1 << 0)
>  /* position of instance value in sub_block_index of
>   * ta_ras_trigger_error_input, the sub block uses lower 12 bits @@ -818,=
5
> +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data
> *err_data,  int amdgpu_ras_error_statistic_ue_count(struct ras_err_data
> *err_data,
>               struct amdgpu_smuio_mcm_config_info *mcm_info,
>               struct ras_err_addr *err_addr, u64 count);
> -
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances);
>  #endif
> --
> 2.17.1

