Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28632CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 12:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6222910E451;
	Mon, 13 Oct 2025 12:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UEiOL5mH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36AC10E451
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 12:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk5/E1DTjDSc6el7KkLfHsdBuCl86nqzdsAvGWAzQvwi+RZcfQZ4IFMz8dvBUH2SE7+YDMlVqZ3+p0DHvmTNj3hV+DqGkfKUfoVFl2ZZsNwMXICb2bUvQDybXzUiXG80IhcEWSSsxddniBJ7MBXgOXnwpAC4f5+SkLjYoHWY+SWU0fTnH1xpeZl7QZV4CoVX0fnPm0TqZT4k9XBHjhEa3cx6fwz8YCz/u7JCYZFnIClf4UEbRpwtceBc+Kr3zWfzYqRxmkL9+xTSgU5rSbbjU3WkBW+Aew82+AFnICsWzriBocrqxZrbGNe5wzcuRdmheuBuMLPzSTkmMQRPPDYI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+A/z3GcdJxBc0yDrEw+WcB56+wg1Yy51KY4wr8xb9A=;
 b=dbmb2rKD9kv6VMaTEkr3aNBncxI5h7VJWhAyn/gvElC08gkV5gpYkQdf/uxhK2WMltgcigs9q06zLj+EzsYE7LZwpcF2N7qVtKNF1t+jRxHIaWH2xjuEQ46GTuiW3geP1y9HCtT66R81eFiG8/2w1gVWqi4yo0h2oKenuVFMwypxQ1LS1Ma1hIvoSkS1Tq5ruAuSFzLNtuX7pxBodZ3L0Ipx+pMUcWHKhIW08ID0ltkPloYKBnP7VYf1+lBPQcvAA+1hgqDC3kWkamKgUvRj9cWQhGy3arlOMDjhunOLPJZlQJmwtD3IY27PZ571qIgS7nULp1iC0ZNkj192L41COA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+A/z3GcdJxBc0yDrEw+WcB56+wg1Yy51KY4wr8xb9A=;
 b=UEiOL5mH0LEDC7uHtS7/ieCz6eJQt4V76rwAZQ5jVp3p/XLEryABBheS8jalsyjaK2TTPmnlaBHOfAPFKJmFPZeCJaXpuj2eFL5Gat7zvlwZFh4YDJ6wqzOUWq1xVX4Ow3A5PDfPnY8KHIoRYpqJMvb2gAUoTN+/kcSbTc+NShs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 12:51:54 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:51:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 compute
Thread-Topic: [PATCH 5/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for
 compute
Thread-Index: AQHcOisWJwDEJRjjX0K69BxU3syQYrTACg7g
Date: Mon, 13 Oct 2025 12:51:53 +0000
Message-ID: <DS7PR12MB6005678AFEE0C3A9A0BA21DEFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-5-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T12:48:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8875:EE_
x-ms-office365-filtering-correlation-id: c8b2b2f0-4196-434f-eb4d-08de0a57491c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0gDZTBNSYoyt6tsW2/yIXpbFkiSOS2FClTw3YImP5O4EB302BzzDzF5PfU5i?=
 =?us-ascii?Q?j95gbRa/QickKP9F7NBZs+3OK0QG8oUeLtNL0MgBgpQ6+10oRHatsz2iMSqX?=
 =?us-ascii?Q?uPhLyyUfJWvJJWUtbpxw1rYE4x+lS2c8sCjNvHtSYd2eifyX0VWWM3qQwwFM?=
 =?us-ascii?Q?r19e+4ShvSnG53bDcdiie66zZDpguzhtHYemlTDc4Mc4cu3dlaBo6l1jwQFh?=
 =?us-ascii?Q?kDrfMBqGdF6In1YCQ2RKac3wxEYMSReHHEvkrwcw5WE/O80Guf6DTrBoyoJB?=
 =?us-ascii?Q?poUuugW6qYpqWZatJR9/Bldp9AL31I6gVPKND4TJ5XOWouSaHcv6vAPI1Df8?=
 =?us-ascii?Q?tSHb355pihATFRV27MThXFAJ6yMnq8uZCsc9rVI37XXDoQHTOqzvB8AN0SsM?=
 =?us-ascii?Q?svdNX1Rjmq48/6JL9WQyH78UkOXlnSqzncS2H85W5gXJWOKSzkKRHD93fYoI?=
 =?us-ascii?Q?PgBc7Uk50mUO5C2RGCOgDlnuFukHSFadUo8FmtY/yShUKcpN/MzVlA6YeTiM?=
 =?us-ascii?Q?BRECDXoLB2rkFCFwd7yX1cTsiQx3kc44VkX69JBNEOPAS4Mexk/brBnx2TWA?=
 =?us-ascii?Q?2KHxfU0XTnXwH7u4NA6zvnVyoGsXGjt8B7zBuSy25pzLVXGl9hPk4mKvP2Wg?=
 =?us-ascii?Q?Lr9JGo5CJ1KOaSATLXRUxWVfGFiy+gNamhYIdP7g6G0CO1ldIoQxl1RT0kyq?=
 =?us-ascii?Q?Wu/fgQM9quVRtOcYlkArinkOpyrW9S9CgK2l1KZmm1PAHy46Ui8jla+z2Hyr?=
 =?us-ascii?Q?1DIbZABke+/e5aOoAWfNnS1hIZPrqoin11v8rBb4db9WU8BSPMB4Fqn9CfDz?=
 =?us-ascii?Q?xdjzKtHf0WBSDcfmX0CfjqzelwRtfEI+uDG2tHO52mQGzkBsjcGBJJt225bU?=
 =?us-ascii?Q?6pQS4PQEDdD6fib1BpLg3Br8xiQkXhmnljGCWVcawG4nZE2XZ9xfX6IsRvqm?=
 =?us-ascii?Q?tS38uK8+Vcwz0npxoC9JPCjhuSwy2ENlDKW0luSGfyaNNEqazWkoC/W8uOrH?=
 =?us-ascii?Q?U2a1Nh7PzBFe0FwV0GYy4ejYgxhXeYxV/NfNNZBn1Tzeq6THFpQW6DAh9VdU?=
 =?us-ascii?Q?n4owrYcNBFb8M1z2MVDTFGHvaawY3XlOFviF0sjzzpubVdOAmHNq9hMBSLV0?=
 =?us-ascii?Q?fMJuKidsXN9dcf2koMQyYi0NfclHCPf6pACjwpzyZvWvu78DzjxoXPFV0yIW?=
 =?us-ascii?Q?/biiS9yYMrbvkeQpnKoY0WwjB9PPcBu/mlLhYjzjmIjAV2bAOdls0NzrLNys?=
 =?us-ascii?Q?vWmYmNFP2Zg6SEzEVj9Hk2KSH56C/ajOrPVmkJsOFPL7TF/PKXgieRKMjArz?=
 =?us-ascii?Q?+ckLWh6BSjM/yQ0mY5e5VTLwtFkB3GcGYghsM2/mGyoG5InKHvMHSye5NrqV?=
 =?us-ascii?Q?i3n5WalZF9zTBu8jux/0/fMZWUU9nkF8p60lfremC7H5mispcefj0NCUx6XO?=
 =?us-ascii?Q?gSzO+Bqt3abscpvzX8thhLZon7BSXxRZ23H0baWtf2o3Qnun8Wn3PORQOL+y?=
 =?us-ascii?Q?rUacApm3Q3eo5zS/jUIW1Cc4rHGQ3exUmhV+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NUq1yHlnc2l9ZK7nwfvC/D9DlIlrKzF3MsNXpYdl/m2GOWxMzK0I21AdEI8R?=
 =?us-ascii?Q?eSUeTDYQALawmj9qkzzrMNTu383W/H+RvAgswCHG7J+fbCxmyYhvkP3OLDe/?=
 =?us-ascii?Q?yNQ4l3wFbjBjoYLjtnxKSDdS9kStpU5XxpeiQLpvHdH451N75VjSiM4lKn4+?=
 =?us-ascii?Q?ukMdIPypygidataVt19dnlqmfrHZn/3UzupfDr23M3O/phgdDPhr2wbRsPDj?=
 =?us-ascii?Q?SN3doxdjNr41Ac/BFzMlWatJAz7XqiZ1lE3fvC4UuowlHkyFEnpC3GrVtiB3?=
 =?us-ascii?Q?h00KtHO7ynVMRtstBP9uJ9tMgHb91q/EtTdTgzuvWw4sslOM4rGiqxCed3nS?=
 =?us-ascii?Q?5tu+nsHCs+PYc2TXG00JPIq3WIrUEtdGQPaf11xSQhFXlomO8gpZz7x63UN6?=
 =?us-ascii?Q?sP7Nyb41CkRyr+IKeQtAGE4EyYiSgyHOW5nXS/V0taKUTXU2k0l4KxZVrwTI?=
 =?us-ascii?Q?lj4PLDcKUlnWYuU+G59wcmi33DZzTkiJSzeL17x+HvufcvBVjQ/l8kjbdZHK?=
 =?us-ascii?Q?nx/iwdByhembCeFl0aFqXEuxofykJn2iOoJEdUaR6P2kmGkmhFcm1Q6GMlTK?=
 =?us-ascii?Q?FypsBsTHwpVBg6lShdvffjKv3K3elLakYsYEfJTcK9yKU0Yn0AqZKN1bLgMm?=
 =?us-ascii?Q?NXELPV6wOAHwAibYUvDtkwGRu5nVDCKXtIf3h0DbPmmxmCWXsP+SznrjZVdu?=
 =?us-ascii?Q?0bnlL6Pu9JF0JtPY1ViFdgJ/SiDbbwIeafYtqo63I11yWReX9xxuIPyDtfIX?=
 =?us-ascii?Q?hl9o0KUKAnd5SiXtZI8XxEh4VAJHo30YyVONplZ3Ag0V5Wn6BsfWuLLOjjzP?=
 =?us-ascii?Q?rwws/elPtohMLjMQXQSvFdjfO4PIEIehk/jeLXjLLQLkpagTUJyYVnAGVYEd?=
 =?us-ascii?Q?xFWfMi3HdVjIxSoBSJprR8iwKE8p9wq0Q0u2gq/3PTDHeBZl4OuFuRYO8wU3?=
 =?us-ascii?Q?Pnov4omtHDNljcWa71Mzz7EfXgs5FFNSdYhA9A7+HedvcOq3jgNZYI/9llf8?=
 =?us-ascii?Q?RzUCZowSIyZZ5OYv5RmeNkvb9rAq2S0Q579WQGIxiFYnR8BP4wBbrtV7CYLF?=
 =?us-ascii?Q?O68J3cihwDvbv8aY2hXjbO8wP/FQljhiOWhTm2wLl5em84HQ0DSMGVWNv9o1?=
 =?us-ascii?Q?RxrYzRKPVY1+0xIfzjXnGpiW1U8s2WzZAdH6VC+/Y59Kc57U+2Y+in4lGCQO?=
 =?us-ascii?Q?wMxf/B1J1LWGPECkSGlslepaFSC+wDEjw/wLp48qkp13zKFPvI3HCuvaIxTk?=
 =?us-ascii?Q?jVjnFq+Rbwb6BR9loLMXItiaVeaIVIaMepv8OcAJSVEj22G72ZPAzbIA3YWP?=
 =?us-ascii?Q?OkkhMiTZ3EDQPNBfkuz2Ix06NcDTS4FW6upVYmdxrnBRbVXaZNOxkEXzweAr?=
 =?us-ascii?Q?5BTLANt+poa5uET2QQtBRnUYm56Ixj4+0mcUIR6mk3k4F0j+XHz8xkdIb+0R?=
 =?us-ascii?Q?+FJiKgrGpXfUl3E3kzBuClKhI68yGJGNEGJnpjm+PEMfB7cTCQbnJNrmo3QI?=
 =?us-ascii?Q?8KlyDw6zQBrIpfxJ9Kw+9sP75lsc54bNDrbhcEpPoAhqwIRDec7y0IE9uus3?=
 =?us-ascii?Q?plAeQqARMp6T0Mli/Hc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b2b2f0-4196-434f-eb4d-08de0a57491c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 12:51:53.7746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zo5++017Pumh4FHzY524c/RfSE8uZk7DogjiGyCjcU0z5RaAkd/uAHmNwvlA/62n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 5/7] drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS
> query for compute
>
> Add a query for compute queues.  Userspace can use this to query the size=
 of the
> EOP buffers for compute user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a9327472c6514..f368bda40be41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -391,6 +391,24 @@ static int amdgpu_userq_metadata_info_gfx(struct
> amdgpu_device *adev,
>       return ret;
>  }
>
> +static int amdgpu_userq_metadata_info_compute(struct amdgpu_device *adev=
,
> +                                           struct drm_amdgpu_info *info,
> +                                           struct
> drm_amdgpu_info_uq_metadata_compute *meta) {
> +     int ret =3D -EOPNOTSUPP;
> +
> +     if (adev->gfx.funcs->get_gfx_shadow_info) {
> +             struct amdgpu_gfx_shadow_info shadow =3D {};
> +
> +             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow, true);
> +             meta->eop_size =3D shadow.eop_size;
> +             meta->eop_alignment =3D shadow.eop_alignment;
> +             ret =3D 0;
> +     }
> +
> +     return ret;
> +}
> +
>  static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>                            struct drm_amdgpu_info *info,
>                            struct drm_amdgpu_info_hw_ip *result) @@ -1359=
,6
> +1377,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, str=
uct
> drm_file *filp)
>                       if (ret)
>                               return ret;
>
> +                     ret =3D copy_to_user(out, &meta_info,
> +                                             min((size_t)size, sizeof(me=
ta_info))) ? -
> EFAULT : 0;
> +                     return 0;
> +             case AMDGPU_HW_IP_COMPUTE:
> +                     ret =3D amdgpu_userq_metadata_info_compute(adev, in=
fo,
> &meta_info.compute);
> +                     if (ret)
> +                             return ret;
> +
>                       ret =3D copy_to_user(out, &meta_info,
>                                               min((size_t)size, sizeof(me=
ta_info))) ? -
> EFAULT : 0;
>                       return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> e5252bf597b36..881e8cc986e2b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1638,9 +1638,17 @@ struct drm_amdgpu_info_uq_metadata_gfx {
>       __u32 csa_alignment;
>  };
>
> +struct drm_amdgpu_info_uq_metadata_compute {
> +     /* EOP size for gfx11 */
> +     __u32 eop_size;
> +     /* EOP base virtual alignment for gfx11 */
> +     __u32 eop_alignment;
> +};
> +
>  struct drm_amdgpu_info_uq_metadata {
>       union {
>               struct drm_amdgpu_info_uq_metadata_gfx gfx;
> +             struct drm_amdgpu_info_uq_metadata_compute compute;
>       };
>  };
>
> --
> 2.51.0

