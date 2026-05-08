Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F37FCD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 04:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D8A10F33E;
	Fri,  8 May 2026 04:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="roqBnyUN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D975510F34B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 04:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzU9kFmhnIy5etm6zNsK8pF9modYINAubil+RD6GfOdIv3vKJfWnWOUInIW/mfC3KhrnPtQWbkQP8eursK/CFdqvTdSwm6V67I+5/RcLtDJknud/Udgs6x3HmtmTOhTKp+GzOZsaeDQZ7avdYzztqMkKBbLaZBB/qQ7OgL9Fo49/AdWwz0udshRU9djF8id0y4GfVoykD9KnqvefibMeQNi7wsH5oqB8uuz0yOvIdWxbrzKloXv+Fx336AxogUl67GW90HvTLmDN2Rk/Vf6Bw9u/AjKQ8wgzkvqR3s6oasZcnu/5euwhEtfG+s4FeZ7osAMPSxwKLy9oKFqDJnYgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/fMi1f9YWslBD1i04jBJ97Sgr2UnAq2MySvSl56UiY=;
 b=lI/PiUUs5HxCLM2ALslv7w9JbdII3lErZZWznZCDsDC5fDEacJQJUnP1n9CyIzu+ur6uSn17rrwj1AoiIIsj0O/4TwtArFWTuxt1s+gOtFO7k1AU/IwOwgcYUTxNbkgjlNvL3qZUP6jQqegarEgzWiGli9BwxWpqp8j23FYxsTPxk1FqYTXUDYXeG/ZjLcnIBOfVPDK8FGjHd0yDrU3MagbKdHJrrH7qFkvD+X0Tf2ZCj6+IHP9ZnzvTtQu3gHmxhmTcNmuB1yKQa7M1IQ3ZJQqUZ6dVNspzUJbYDIKkpHyb67LEJ3w4m/PnqcQomD6tFOQ88TVqPym0qv8ZbOb/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/fMi1f9YWslBD1i04jBJ97Sgr2UnAq2MySvSl56UiY=;
 b=roqBnyUNXRFU5mVSeidjdQ1dWBIXQB773NV6FoiZPXe6OGYKyn/10N8vQBhfVgPJdPUQ74JnnYVJDlRhV/Lis+JZy9NyFWB/E1xPbkG8435IkCWl8Du9BlSoKkRA+mCBLj8YfLvIGnMEv8g8S2uBRu4y5B3zeRp8dJzd5g7dt9M=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Fri, 8 May 2026 04:51:21 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 04:51:21 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Topic: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Index: AQHc3pmu+DrUhsRdEkSk2VnZnwL4H7YDitwAgAAD7fQ=
Date: Fri, 8 May 2026 04:51:20 +0000
Message-ID: <DM6PR12MB2972C70BEDCA9C6D968AB851823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
 <dcfc25a2-5aaa-4c62-b684-a70f97f82516@amd.com>
In-Reply-To: <dcfc25a2-5aaa-4c62-b684-a70f97f82516@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T04:49:03.0203329Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DM4PR12MB5939:EE_
x-ms-office365-filtering-correlation-id: 6e8b99c2-b3b7-4293-e054-08deacbd72fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|38070700021|56012099003|18002099003|22082099003|8096899003|3023799003;
x-microsoft-antispam-message-info: h8mJtT9MnCLZf3FL5RZiRJ9JCwT5xiVFuGRUEKyi/TD+ee9RjR14ZQTKtMa5prMTYtgMIxZYim6GLDQkSX2K0F8rIP6s/A4SYNyzorwlb4UCPrJbLKwKj2Yw4X6ueyKXxwnjsYcwf9NyLa7Uf1eV3qWfo5zM7OJWadCCii+QgiibN0KvlOpsrvm+ybced9ZWjS9IrKDuSKDMfdoSR2DQGZkCKIZaeDt/2HvqgEKZ6Gm01m+3RzRpSqbJrjbhsHTliXKmLPf7I4D0yVTP7O+gBxrlAMU0LPS+BEOERkrax25HympRW43ogUz79ACY1TOea6eOSQGA486LQ1f9SreKKGi3aNgfbUVObSiI0OkFxiQokxeFr1PWsFg/cVbpf40rBaSfcjMPFEWX7T9mUfPorikrSC4VFgrSjRqRlLh7zjJO3wsys/gKfwT50ZIspmvZgT9NVQSx4OY57oAyWKo1mdn5HUsV3uxMXEeUY4UmYopA7XLGP/3C2ljnqQT29cbxWuOvztXYIRUqDwhZ1x4BZKDq1RDg29v7mEwRMUiBkDM2aLt2O4lSmn08ETcD4RRWtdU41cKh08hl1UhfyzQizl9bB11uISnqHNtZUYIar/K/de4jZCnBykrcTwI11zcNkhKUL7Gvzd4LhcGM9XGL4LdOkwy9p8OatbXgjiG4mRJVOvm9gE6COMod7ZsRDV/1pR4OoH2ZnEZoJW+s3dhsdUmhJXYHhrm/+An7JIM5Lph14a3eEAhXFUKo8Z7h+Y5k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021)(56012099003)(18002099003)(22082099003)(8096899003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T6fl1zJGqZjo3h/fRBTlOjaewj8Tw6OJV3A3QR310l8zzropXRT2vchiBs6z?=
 =?us-ascii?Q?WaSADOxvi2wfiwqXpV4yhKm+EtKZB6W2ujSEGv4irJS/F/ePeBXnPUPe9b6t?=
 =?us-ascii?Q?cEpFGn4O0jCdeiULlGb4rqVOGuJAknjfRhViM/cj+zNhUrCgaIBd+DlCywBQ?=
 =?us-ascii?Q?l9Q6hue8dwkgEOFnfEDjA3fRCpswQaNyjW4+HWhOt3FBW3WB+XdY3IMom4b3?=
 =?us-ascii?Q?o/1YpoFZXopjB5FJ0iOABe6Su4S/4aL9sK5L0Q4qa6uM8MSH9BFQpilN+Vvv?=
 =?us-ascii?Q?QQcGUonXw4MTkF+1NQXQfF3ZqEsfOU2/rM5wgrqX2itvYpO5GypB+evidKhT?=
 =?us-ascii?Q?Lu1w6/rBAI8bL7JZB9cLm6vOFZQnhFjnD7S2YhEDF1Zk7+TlzkL0AXOc3fNS?=
 =?us-ascii?Q?mruPXJqKvG+FV9BLT94DGblO+tfxhJnxB+D4/7ZiUlqreElUH/4Wi31dxh07?=
 =?us-ascii?Q?WRPiy3pmEWRxzK8xTO4n/trOI/HAYdpDOphWeqe9N/7amCJf/km5AxMxOLyk?=
 =?us-ascii?Q?OGVqXRlukcXapIRqOE7t1DeRIT5xLKCS1aVmlW5FWRahv8Cz1iU+qj2qLo9b?=
 =?us-ascii?Q?CwuQJl5KKLKU14h2OFoBb8JkjL5G4hvZH4PgAPyRRnYxZCGHYNkLFMOL7z62?=
 =?us-ascii?Q?TiK6UUkWOTDmfDCyHIukeebOtM9c4i6iw2TficaooVdlTP25k5ByPIGrvYN7?=
 =?us-ascii?Q?GVDVE4K1tvJYxXvCQTWZwr7uX+58atTagcS5ONXQl+9rMrc3Vt4LipLv7A4F?=
 =?us-ascii?Q?kc9EU+iogg/cYetKDBWb0hnLIAVzNEap6t06pS1B+OP+3IdALtEOjXxSefDP?=
 =?us-ascii?Q?FTHaEjTGBri+k7NEALH5orB2XyMVbf8BFr51wneUZ0GUZBqxav9pQkZRfP1e?=
 =?us-ascii?Q?Kki4GaFLijKftIHFcpmclJvAs/Jco5gM7df8Bg7TswUF5iFU/QsrfLvDQUwD?=
 =?us-ascii?Q?sDhZ1gsZcJUN1MT5JDebfY2+5FCYZV9WxFB/I1zG8PPJQpCmWTR98xUxDNVv?=
 =?us-ascii?Q?gWplsr147kNTc0BliekGrkQQh5hfoZungSqzfmJ6OrFEO51blB4ETdBhWlQV?=
 =?us-ascii?Q?uuP6JDF54ZRmsu1ra+GIaJNNefXH8CmciCzGytJu4n0/EgHybptQvKyRz0gj?=
 =?us-ascii?Q?/rKApiFPzZ9QhGNUYOZLQZ7Vk90aOX19i2jnWea6cbEWhQpUa+ZJSNiwPzd2?=
 =?us-ascii?Q?GRcfdKZ8CtnTlDFWJc9DvGODqynBkiEG5ABpssu+sF+MXvNUzFro+vXv21fk?=
 =?us-ascii?Q?aqFjIwaMrVHpY/hwfyNlCveV2Wg/EfXuQC3lcGZoJKOsiWmCgqcHvssSV81C?=
 =?us-ascii?Q?Pu6Ctquzv95FTQsTxw6cbJHDUHa7JI5blw4bPouur16ZejDdeWfHqVic6lOy?=
 =?us-ascii?Q?JvH5VtdsI0q+wAgAjjJhtMFcW5d5nIsW5cdv2iyKagC0i3FQ1w/5PeTMb52M?=
 =?us-ascii?Q?1g5J/2B611qkZUf0pTAHDn9o3zOG5dl0Zx0yB/GBPphqzoH6I6JYDgMtTeU0?=
 =?us-ascii?Q?P8v5zbWaE9RFZS4mX4b4H54LRDuRccw4LSPJymNd0Mxuow6rK73q/55RykMl?=
 =?us-ascii?Q?AZtmTQqysx34OQilpbGYFLfyzUgGFcDZfagjee0+yzZQXE9J5B5SDNVrv5EB?=
 =?us-ascii?Q?P4WQc9mxonQ246KDY7EKzQNcJweF3rDEbXMb7z5erWUM1q7aY6/noxR6miKA?=
 =?us-ascii?Q?PZfSXOT3CtNx4COoFBHX8cfFqsn6k0y0mIEVSjb/UzbiWnrBdi5C/3HfX0Ze?=
 =?us-ascii?Q?HtKEngx72o4hS624kBYZKAvoPLJDF5l1OYLZ9TLfEtTCAgwG1f0SdHmCLhQT?=
x-ms-exchange-antispam-messagedata-1: 6im7ozGWVhY7zQ==
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2972C70BEDCA9C6D968AB851823D2DM6PR12MB2972namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8b99c2-b3b7-4293-e054-08deacbd72fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 04:51:20.7811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyCEc6RAe7YySNEctBKmK+VwyMrjmWnfHmVk7a1gEZWag8NzjrosKDy7inydPA+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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

--_000_DM6PR12MB2972C70BEDCA9C6D968AB851823D2DM6PR12MB2972namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 8, 2026 12:35 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebar=
an (gc 9.4.2)



On 08-May-26 8:50 AM, Yang Wang wrote:
> Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus=
)
> and 9.4.2 (Aldebaran) ASICs:
>
> - Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update commen=
t
> - Aldebaran (9.4.2): Add dedicated per-clock constraints:
>    * mclk/socclk: Only support voltage control, disable level setting
>    * fclk: Mark as fully unsupported
>    * pcie: Move multi-AID check into 9.4.2 case, disable level setting
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index fd2e63530e8c..9ee3053973cf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct =
amdgpu_device *adev, struct amd
>                       gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
>                       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.nu=
m_vcn_inst >=3D 2))
>                        *states =3D ATTR_STATE_UNSUPPORTED;
> -     } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> -             if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
> -                 amdgpu_is_multi_aid(adev))
> -                     *states =3D ATTR_STATE_UNSUPPORTED;
>        }
>
>        switch (gc_ver) {
>        case IP_VERSION(9, 4, 1):
> -     case IP_VERSION(9, 4, 2):
> -             /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
> +             /* Arcturus does not support standalone mclk/socclk/fclk le=
vel setting */
>                if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>                    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>                    DEVICE_ATTR_IS(pp_dpm_fclk)) {
> @@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct a=
mdgpu_device *adev, struct amd
>                        dev_attr->store =3D NULL;
>                }
>                break;
> +     case IP_VERSION(9, 4, 2):
> +             if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
> +                 DEVICE_ATTR_IS(pp_dpm_socclk)) {
> +                     /* Aldebaran mclk/socclk DPM only supports voltage =
control,
> +                      * not allow to set dpm level directly */
> +                     dev_attr->attr.mode &=3D ~S_IWUGO;
> +                     dev_attr->store =3D NULL;
> +             } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> +                     if (amdgpu_is_multi_aid(adev)) {
> +                             *states =3D ATTR_STATE_UNSUPPORTED;
> +                     } else {
> +                             dev_attr->attr.mode &=3D ~S_IWUGO;
> +                             dev_attr->store =3D NULL;
> +                     }
> +             } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
> +                     /* Aldebaran does not support fclk dpm */
> +                     *states =3D ATTR_STATE_UNSUPPORTED;

I see FCLK reporting is supported in aldebaran -
aldebaran_get_current_clk_freq_by_table.

That may also be kept as read-only then.
[kevin]
No, it should be disabled, because the fclk is always return 0 by metrics t=
able if fclk dpm feature is disabled.

Best Regards,
Kevin

Thanks,
Lijo> +         }
> +             break;
>        default:
>                break;
>        }


--_000_DM6PR12MB2972C70BEDCA9C6D968AB851823D2DM6PR12MB2972namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>From:</b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, May 8, 2026 12:35 PM<br>
<b>To:</b>&nbsp;Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang=
, Hawking &lt;Hawking.Zhang@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd=
.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amd/pm: update dpm clock pm attributes=
 for aldebaran (gc 9.4.2)</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div class=3D"PlainText" style=3D"font-size: 11pt;"><br>
<br>
On 08-May-26 8:50 AM, Yang Wang wrote:<br>
&gt; Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arctu=
rus)<br>
&gt; and 9.4.2 (Aldebaran) ASICs:<br>
&gt;<br>
&gt; - Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update com=
ment<br>
&gt; - Aldebaran (9.4.2): Add dedicated per-clock constraints:<br>
&gt;&nbsp;&nbsp;&nbsp; * mclk/socclk: Only support voltage control, disable=
 level setting<br>
&gt;&nbsp;&nbsp;&nbsp; * fclk: Mark as fully unsupported<br>
&gt;&nbsp;&nbsp;&nbsp; * pcie: Move multi-AID check into 9.4.2 case, disabl=
e level setting<br>
&gt;<br>
&gt; Signed-off-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++=
++------<br>
&gt;&nbsp;&nbsp; 1 file changed, 20 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c<br>
&gt; index fd2e63530e8c..9ee3053973cf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(stru=
ct amdgpu_device *adev, struct amd<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D=
 IP_VERSION(11, 0, 2) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D=
 IP_VERSION(11, 0, 3)) &amp;&amp; adev-&gt;vcn.num_vcn_inst &gt;=3D 2))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states=
 =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_is_multi_aid(adev))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_=
UNSUPPORTED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (gc_ver) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* the Mi series card does not support standalone mclk/socclk/fclk leve=
l setting */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Arcturus does not support standalone mclk/socclk/fclk level setting =
*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk) |=
|<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_fclk)) {<=
br>
&gt; @@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struc=
t amdgpu_device *adev, struct amd<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_att=
r-&gt;store =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (DEVICE_ATTR_IS(pp_dpm_mclk) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; DEVICE_ATTR_IS(pp_dpm_socclk)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Aldebaran mclk/soccl=
k DPM only supports voltage control,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * not allow to se=
t dpm level directly */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;attr.mode =
&amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;store =3D =
NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_multi_aid=
(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_UNSUPPORTED;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;attr.mode &amp;=3D ~S_IWUGO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_attr-&gt;store =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Aldebaran does not s=
upport fclk dpm */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *states =3D ATTR_STATE_=
UNSUPPORTED;<br>
<br>
I see FCLK reporting is supported in aldebaran -<br>
aldebaran_get_current_clk_freq_by_table.<br>
<br>
That may also be kept as read-only then.<br>
[kevin]</div>
<div dir=3D"ltr" class=3D"PlainText" style=3D"font-family: Aptos, Aptos_MSF=
ontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);">
No, it should be disabled, because the fclk is always return 0 by metrics t=
able if fclk dpm feature is disabled.</div>
<div dir=3D"ltr" class=3D"PlainText" style=3D"font-family: Aptos, Aptos_MSF=
ontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div dir=3D"ltr" class=3D"PlainText" style=3D"font-family: Aptos, Aptos_MSF=
ontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div dir=3D"ltr" class=3D"PlainText" style=3D"font-family: Aptos, Aptos_MSF=
ontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);">
Kevin&nbsp;</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;"><br>
Thanks,<br>
Lijo&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2972C70BEDCA9C6D968AB851823D2DM6PR12MB2972namp_--
