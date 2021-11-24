Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E72C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 02:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9D66E16F;
	Wed, 24 Nov 2021 02:21:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88B36E16F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 02:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLO0VGRiyDJL66XPo0331RQBYSp8n/vUb4TxQgnfGEiQfa5NswRdZoriY405IqisBCap1EEYiHlDFmEFswWTjwwRpZVw/8VnBHRtIpBHCKxEKVU0oQyQGfKyewN0uuFL6fCS1i/NJPXZURtvX55HBSA1fWdj7glTeBsPxYLl/VcJjpbAf1qPqLaFl7NiZ/yHMPVQqeLaIEh71p/S6Pzp1AKaysJPAXWJFqRyTJS73ktRTKN2sz4A8GXyDMFV4K3D+SnMlfOkU7pI+rsafOGJk1ciOzcaW0rB4m034CbGx0uuyDaNJS2RZ8r195+/BMNIHjSms+oxFrrume5dNbAB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec21ySlSICieH4kNejXiZBJQEbNufbh+GfPZL47iPG0=;
 b=UbEhITRRQEo2JWUlXsja4i7MdMxVcC6CSahTjF01XRXUcyh+OC+ZsOUmaE6nML0JasX4RUFv0cPogKpyUvGiqxs60wRrOkkRnCLbfNsagEGl/QpuwQZBxZthKJJ2ALAdW7RBZKFNKG5sKCvuVv3PV8srzh6+x9AOUFXCtp69CiAOpjqQYlHhtKvOugIlSqOCinsV4/HzW6ylPlYnLZGRT/kUAQfpyi4txlUJGx+a+ZumRVlwO4LSz0ho5+6nIwX/7EU42SItpavu0bLvlWfPljQ7TCxpUTpJAEZo7YrvvsiZaOAguOm+TZJrh//nkTCpFmbZv02hDOwFyvX9kCShxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec21ySlSICieH4kNejXiZBJQEbNufbh+GfPZL47iPG0=;
 b=0GjoAhr39LubmHVnx75oMM/f4MWIMvjV/LbbN7L0Y5vFxNEK34o1r/lew7pBKhPSOOJdRCqjhvhkQ83DjNMatImQvaOnsVXLhqqaWJN6pUlRDe/u9ZAMZz8uyYfMv5oWgXMboLJgckpiba0lK0rSwVQwAbjk9mzwG6136lQ+aNk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Wed, 24 Nov 2021 02:21:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 02:21:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: fix powerplay OD interface
Thread-Topic: [PATCH] drm/amdgpu/pm: fix powerplay OD interface
Thread-Index: AQHX4KTu5CNDCHFPeUCz22Al6mfiqKwR8pWg
Date: Wed, 24 Nov 2021 02:21:41 +0000
Message-ID: <DM6PR12MB26193EC6C8A2E8D1C3B34D2BE4619@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211123200113.1979433-1-alexander.deucher@amd.com>
In-Reply-To: <20211123200113.1979433-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-24T02:21:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=03762733-f2c6-48a6-9871-a197c7fd0e4d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b6299dd-fcdd-4e4a-376a-08d9aef12733
x-ms-traffictypediagnostic: DM5PR12MB1356:
x-microsoft-antispam-prvs: <DM5PR12MB135664221496FB519A01211AE4619@DM5PR12MB1356.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:17;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnIvsv7i/pQoI0hTeGfb2I+i+vw47jzucnLL2OPcnOhnnKqqmgaSAAsqeffJ1JiMvvu36gt4smzONlpcZjebHvweVHVIUwz+LPOeaxNx6WID4tt/1tjUsgjAaMcjXRd0xcFyYyEXIXhFNoCpxTyTzC85c6y/xcJ4LiqLPk5Scp6HxqQpDXBTVOiqQ95MBcD9EDuj79sg81dNMPwB2yID+pPMRY2joUHC2D6EXlNH6Q3nzs+NIPJgaIHgTbPFLIKcW8Er+YFWL2JW7WcC/RUvGXJ6f9Jo1b2ebtUsQTPPmzt9L1K8TsYfUXsbUkoj4yEZHAC8+1CrxikVwqWT9IN/u9lL3aUlh71TMWmjK7u5AA2jMvkuPP7m6Dya2+kuUSfebBY0Ht/CVuPzetKTbAbrI9WJT3J31XW0FWGzPzTLCd+v3BgU5XkT2u1b/iycM2hlG5+1KEQz9UDmN3HKouMKY/MtvijPG7atrixVppwsW+7Cuwja/t12QEx64Pfl8w6/2ittTPNJ16bejJ77J9NcENCzTwFh7nlEn6OAdD7JxyJdMpIb6++G/RzlHURyPY/2m2U01bwROH7ap+nocuk/1HjHberP87W1NilvItua+o5EPLbnhqz2Ddv2//ST65Ap5ozl14tAzYfhQ/SEHdmChrjY8MkrbZEPjMEb4hfCRVNWXR7WsZ0FSZ2OqLbILKeX5WcI1TgxGw5zTw8mmViBszQKO6OJEptZyOqiJUpg4zUgths51d9Q2HuWmcprEp64BJgoEXpcTpahmfATot7lNkslCJA7vFMheTWA605LLs4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(966005)(66946007)(66446008)(76116006)(66476007)(33656002)(66556008)(53546011)(316002)(38070700005)(508600001)(9686003)(64756008)(186003)(122000001)(38100700002)(6506007)(8936002)(83380400001)(4326008)(5660300002)(55016003)(2906002)(26005)(52536014)(30864003)(8676002)(45080400002)(110136005)(71200400001)(7696005)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wv1auERl6kxkjqAEF9h17osWG8Cy/kWe9wXGnHRIjg9++elNSPKsnt4hqwP+?=
 =?us-ascii?Q?r4iD+kJ8fYXuT/xk/CGBz9wkaY5+3WBCC7rzlDlinK0VGTB2JwvnVsrvvcfb?=
 =?us-ascii?Q?igYWvKVj0gs1fSxqeY9VH9vmAcbdy3Gf59uCwK/D0FTxQsyz06FeXCVlzmNk?=
 =?us-ascii?Q?S4VXn1Qd/Wsf+v5c9yIKd9dGUfUApMlSbvi8EWwio4mn7nXsZNE44NIiJZlo?=
 =?us-ascii?Q?a994gj+7eAB1rC4MF/b6rBNQlpGFTeu+mlNi6rmOqMxPpbcoE1milLzlyfhz?=
 =?us-ascii?Q?sSx5zftpRRxpLOdeNE3r+G+wWtLnq1WHyfsxx0x3fO5WW+loMqGmQBs0Rl9Z?=
 =?us-ascii?Q?CX2niWnmDh3Ow0LTJddzuSkKyFu0s0hLSATQoeWIFlgpZPkXbfjUik9k437d?=
 =?us-ascii?Q?v0p1sXGTppJe+D5HgDWGXrXeSAPow4nneCBENVYhTcjKDgE0mr2V6GJ6KhQy?=
 =?us-ascii?Q?badD0QGnU2/wC0OrHjycoknYAG9mVKN1GYroZvqlQHsMu7bGml/og8s9GyWr?=
 =?us-ascii?Q?5gaEOm9/798Sjr2HN9RYikaUOwUTAz37MV+F6241X5Z2fylrTRoFi/WlMwBQ?=
 =?us-ascii?Q?BZXt0QtT7NfHmlFnN2WvHKeOxmGReeq+vvNFFjoOFnwVaHa+cRzrL/TV5Tx5?=
 =?us-ascii?Q?8uA5tIKga98K/udcDOhSuUOIHbflaIkz5bv+weWZtu2Y4KexBsvjg5RPcJKp?=
 =?us-ascii?Q?1DBNMNaJlBFgn7yfh5+tc6oWDhJu//0duv1LnsbGuAT76V3AIFeMOU71w8yp?=
 =?us-ascii?Q?8z4wu30iEX8lVSOahzP8xBZc5pNjFKJfu/GdvM0ViYsqqroXf1JLYUWrhgCD?=
 =?us-ascii?Q?4BmmUhuEVnB7hu1YCNxzw7VHJ7cizyEqGRGsVWEmps1GCn2Z7K9eofZN2f2V?=
 =?us-ascii?Q?0UqD+O3ka/yZNvCFAtmUzFATkpGSQSqWzna1H40xUfoF/x6IkOh9KpSeuqt3?=
 =?us-ascii?Q?O3MD1s11igDi+HfZFuoGXYJj42dH7rvg/zQsLQuyqvP6t5RdZgjpy/wt2w3t?=
 =?us-ascii?Q?fuVdQoucq/jHS+hsihzZKGGoUMFgFUedR34jQkTzzk+SpRFu2WLXIlmUDfFV?=
 =?us-ascii?Q?u1caJaMjhAxHKMbgKdp1HqRY+/D0g5jx+uBOMLxM+0cPqKFKQ6Oatdi4inKk?=
 =?us-ascii?Q?zvHD8PAj8InKgSdWac/KUzIE0b0BX2G7J+nDpm3JiRvE2Hpgi1QllLr9EP39?=
 =?us-ascii?Q?sUexrkkl6nAtECNLNUiWglfazxwEH/6EGxz1rNs2Gv3gpeNgOnwOMus1ffY4?=
 =?us-ascii?Q?iiX1UwZoa4hwnMmGFjePqgiQebyiX/gFDvW1SPisf4GRifexh2bpQswpMPwk?=
 =?us-ascii?Q?ZI7cIim+siWBFddoZeUjCjWnDb/Onf9wWxpBXbV+o+KNb4dqKq7cV2TbWOeW?=
 =?us-ascii?Q?dmZzj5a5AkzVYMe/LHuJj8NipRF4aeyja1ZyNjVTXmLtFr2lvA0cbe5HQbvA?=
 =?us-ascii?Q?q0VDdCi/wXag+cLrnXtatOfLRbE+6JjC+60rXdl4S0kr5UjbzllXVEqQrxd2?=
 =?us-ascii?Q?OM9IpwSPY5coD4i6O3oLondLMgPjOko/1ulge2tqrex8GCIhbObITiOJ3v+j?=
 =?us-ascii?Q?5Tw8FRXFSVF5JGq9huA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6299dd-fcdd-4e4a-376a-08d9aef12733
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 02:21:41.6985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pjk13rcWE46j+aWI4qnxSTL8CoEuLTR8fGMwh0qiJm0CTZMYzcxLOyBwCgTgsvux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, November 24, 2021 4:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/pm: fix powerplay OD interface
>=20
> The overclocking interface currently appends data to a string.  Revert ba=
ck to
> using sprintf().
>=20
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1774&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7Cfc28
> 95d7646643ab7b8d08d9aebc0fb6%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C637732945016986765%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0&amp;sdata=3DUgMIgPfWnSKlGFszZHUBlYQcgzHwZ4zAlCmLMhhA%2Ftw%3D
> &amp;reserved=3D0
> Fixes: 6db0c87a0a8ee1 ("amdgpu/pm: Replace hwmgr smu usage of sprintf
> with sysfs_emit")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 20 +++----
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 24 ++++----
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  6 +-
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 28 +++++----
>   .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 10 ++--
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 58 +++++++++------
> ----
>  6 files changed, 67 insertions(+), 79 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 258c573acc97..1f406f21b452 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1024,8 +1024,6 @@ static int smu10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  	uint32_t min_freq, max_freq =3D 0;
>  	uint32_t ret =3D 0;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &now); @@ -1038,13 +1036,13 @@
> static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>  		else
>  			i =3D 1;
>=20
> -		size +=3D sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> +		size +=3D sprintf(buf + size, "0: %uMhz %s\n",
>  					data->gfx_min_freq_limit/100,
>  					i =3D=3D 0 ? "*" : "");
> -		size +=3D sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +		size +=3D sprintf(buf + size, "1: %uMhz %s\n",
>  					i =3D=3D 1 ? now :
> SMU10_UMD_PSTATE_GFXCLK,
>  					i =3D=3D 1 ? "*" : "");
> -		size +=3D sysfs_emit_at(buf, size, "2: %uMhz %s\n",
> +		size +=3D sprintf(buf + size, "2: %uMhz %s\n",
>  					data->gfx_max_freq_limit/100,
>  					i =3D=3D 2 ? "*" : "");
>  		break;
> @@ -1052,7 +1050,7 @@ static int smu10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  		smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &now);
>=20
>  		for (i =3D 0; i < mclk_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i,
>  					mclk_table->entries[i].clk / 100,
>  					((mclk_table->entries[i].clk / 100)
> @@ -1067,10 +1065,10 @@ static int smu10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  			if (ret)
>  				return ret;
>=20
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> -			size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_SCLK");
> +			size +=3D sprintf(buf + size, "0: %10uMhz\n",
>  			(data->gfx_actual_soft_min_freq > 0) ? data-
> >gfx_actual_soft_min_freq : min_freq);
> -			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size +=3D sprintf(buf + size, "1: %10uMhz\n",
>  			(data->gfx_actual_soft_max_freq > 0) ? data-
> >gfx_actual_soft_max_freq : max_freq);
>  		}
>  		break;
> @@ -1083,8 +1081,8 @@ static int smu10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  			if (ret)
>  				return ret;
>=20
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_RANGE");
> -			size +=3D sysfs_emit_at(buf, size,
> "SCLK: %7uMHz %10uMHz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size +=3D sprintf(buf + size,
> "SCLK: %7uMHz %10uMHz\n",
>  				min_freq, max_freq);
>  		}
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index aceebf584225..611969bf4520 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4914,8 +4914,6 @@ static int smu7_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  	int size =3D 0;
>  	uint32_t i, now, clock, pcie_speed;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock); @@ -4928,7 +4926,7 @@
> static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>  		now =3D i;
>=20
>  		for (i =3D 0; i < sclk_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, sclk_table->dpm_levels[i].value /
> 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -4943,7 +4941,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  		now =3D i;
>=20
>  		for (i =3D 0; i < mclk_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, mclk_table->dpm_levels[i].value /
> 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -4957,7 +4955,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  		now =3D i;
>=20
>  		for (i =3D 0; i < pcie_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %s %s\n", i,
> +			size +=3D sprintf(buf + size, "%d: %s %s\n", i,
>  					(pcie_table->dpm_levels[i].value =3D=3D
> 0) ? "2.5GT/s, x8" :
>  					(pcie_table->dpm_levels[i].value =3D=3D
> 1) ? "5.0GT/s, x16" :
>  					(pcie_table->dpm_levels[i].value =3D=3D
> 2) ? "8.0GT/s, x16" : "", @@ -4965,32 +4963,32 @@ static int
> smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>  		break;
>  	case OD_SCLK:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_SCLK");
>  			for (i =3D 0; i < odn_sclk_table->num_of_pl; i++)
> -				size +=3D sysfs_emit_at(buf, size,
> "%d: %10uMHz %10umV\n",
> +				size +=3D sprintf(buf + size,
> "%d: %10uMHz %10umV\n",
>  					i, odn_sclk_table-
> >entries[i].clock/100,
>  					odn_sclk_table->entries[i].vddc);
>  		}
>  		break;
>  	case OD_MCLK:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_MCLK");
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_MCLK");
>  			for (i =3D 0; i < odn_mclk_table->num_of_pl; i++)
> -				size +=3D sysfs_emit_at(buf, size,
> "%d: %10uMHz %10umV\n",
> +				size +=3D sprintf(buf + size,
> "%d: %10uMHz %10umV\n",
>  					i, odn_mclk_table-
> >entries[i].clock/100,
>  					odn_mclk_table->entries[i].vddc);
>  		}
>  		break;
>  	case OD_RANGE:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_RANGE");
> -			size +=3D sysfs_emit_at(buf, size,
> "SCLK: %7uMHz %10uMHz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size +=3D sprintf(buf + size,
> "SCLK: %7uMHz %10uMHz\n",
>  				data-
> >golden_dpm_table.sclk_table.dpm_levels[0].value/100,
>  				hwmgr-
> >platform_descriptor.overdriveLimit.engineClock/100);
> -			size +=3D sysfs_emit_at(buf, size,
> "MCLK: %7uMHz %10uMHz\n",
> +			size +=3D sprintf(buf + size,
> "MCLK: %7uMHz %10uMHz\n",
>  				data-
> >golden_dpm_table.mclk_table.dpm_levels[0].value/100,
>  				hwmgr-
> >platform_descriptor.overdriveLimit.memoryClock/100);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC: %7umV %11umV\n",
> +			size +=3D sprintf(buf + size,
> "VDDC: %7umV %11umV\n",
>  				data->odn_dpm_table.min_vddc,
>  				data->odn_dpm_table.max_vddc);
>  		}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 8e28a8eecefc..03bf8f069222 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1550,8 +1550,6 @@ static int smu8_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  	uint32_t i, now;
>  	int size =3D 0;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		now =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr-
> >device,
> @@ -1561,7 +1559,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  				CURR_SCLK_INDEX);
>=20
>  		for (i =3D 0; i < sclk_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, sclk_table->entries[i].clk / 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -1573,7 +1571,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>  				CURR_MCLK_INDEX);
>=20
>  		for (i =3D SMU8_NUM_NBPMEMORYCLOCK; i > 0; i--)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					SMU8_NUM_NBPMEMORYCLOCK-i,
> data->sys_info.nbp_memory_clock[i-1] / 100,
>  					(SMU8_NUM_NBPMEMORYCLOCK-i
> =3D=3D now) ? "*" : "");
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index c981fc2882f0..e6336654c565 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4639,8 +4639,6 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>=20
>  	int i, now, size =3D 0, count =3D 0;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		if (data->registry_data.sclk_dpm_key_disabled)
> @@ -4654,7 +4652,7 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  		else
>  			count =3D sclk_table->count;
>  		for (i =3D 0; i < count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, sclk_table->dpm_levels[i].value /
> 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -4665,7 +4663,7 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  		smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &now);
>=20
>  		for (i =3D 0; i < mclk_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, mclk_table->dpm_levels[i].value /
> 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -4676,7 +4674,7 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  		smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentSocclkIndex, &now);
>=20
>  		for (i =3D 0; i < soc_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, soc_table->dpm_levels[i].value /
> 100,
>  					(i =3D=3D now) ? "*" : "");
>  		break;
> @@ -4688,7 +4686,7 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				PPSMC_MSG_GetClockFreqMHz,
> CLK_DCEFCLK, &now);
>=20
>  		for (i =3D 0; i < dcef_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  					i, dcef_table->dpm_levels[i].value /
> 100,
>  					(dcef_table->dpm_levels[i].value /
> 100 =3D=3D now) ?
>  					"*" : "");
> @@ -4702,7 +4700,7 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  			gen_speed =3D pptable->PcieGenSpeed[i];
>  			lane_width =3D pptable->PcieLaneCount[i];
>=20
> -			size +=3D sysfs_emit_at(buf, size, "%d: %s %s %s\n", i,
> +			size +=3D sprintf(buf + size, "%d: %s %s %s\n", i,
>  					(gen_speed =3D=3D 0) ? "2.5GT/s," :
>  					(gen_speed =3D=3D 1) ? "5.0GT/s," :
>  					(gen_speed =3D=3D 2) ? "8.0GT/s," :
> @@ -4721,34 +4719,34 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>=20
>  	case OD_SCLK:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_SCLK");
>  			podn_vdd_dep =3D &data-
> >odn_dpm_table.vdd_dep_on_sclk;
>  			for (i =3D 0; i < podn_vdd_dep->count; i++)
> -				size +=3D sysfs_emit_at(buf, size,
> "%d: %10uMhz %10umV\n",
> +				size +=3D sprintf(buf + size,
> "%d: %10uMhz %10umV\n",
>  					i, podn_vdd_dep->entries[i].clk / 100,
>  						podn_vdd_dep-
> >entries[i].vddc);
>  		}
>  		break;
>  	case OD_MCLK:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_MCLK");
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_MCLK");
>  			podn_vdd_dep =3D &data-
> >odn_dpm_table.vdd_dep_on_mclk;
>  			for (i =3D 0; i < podn_vdd_dep->count; i++)
> -				size +=3D sysfs_emit_at(buf, size,
> "%d: %10uMhz %10umV\n",
> +				size +=3D sprintf(buf + size,
> "%d: %10uMhz %10umV\n",
>  					i, podn_vdd_dep->entries[i].clk/100,
>  						podn_vdd_dep-
> >entries[i].vddc);
>  		}
>  		break;
>  	case OD_RANGE:
>  		if (hwmgr->od_enabled) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_RANGE");
> -			size +=3D sysfs_emit_at(buf, size,
> "SCLK: %7uMHz %10uMHz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size +=3D sprintf(buf + size,
> "SCLK: %7uMHz %10uMHz\n",
>  				data-
> >golden_dpm_table.gfx_table.dpm_levels[0].value/100,
>  				hwmgr-
> >platform_descriptor.overdriveLimit.engineClock/100);
> -			size +=3D sysfs_emit_at(buf, size,
> "MCLK: %7uMHz %10uMHz\n",
> +			size +=3D sprintf(buf + size,
> "MCLK: %7uMHz %10uMHz\n",
>  				data-
> >golden_dpm_table.mem_table.dpm_levels[0].value/100,
>  				hwmgr-
> >platform_descriptor.overdriveLimit.memoryClock/100);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC: %7umV %11umV\n",
> +			size +=3D sprintf(buf + size,
> "VDDC: %7umV %11umV\n",
>  				data->odn_dpm_table.min_vddc,
>  				data->odn_dpm_table.max_vddc);
>  		}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index f7e783e1c888..a2f4d6773d45 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -2246,8 +2246,6 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  	int i, now, size =3D 0;
>  	struct pp_clock_levels_with_latency clocks;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		PP_ASSERT_WITH_CODE(
> @@ -2260,7 +2258,7 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				"Attempt to get gfx clk levels Failed!",
>  				return -1);
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz / 1000 =3D=3D now /
> 100) ? "*" : "");
>  		break;
> @@ -2276,7 +2274,7 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				"Attempt to get memory clk levels Failed!",
>  				return -1);
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz / 1000 =3D=3D now /
> 100) ? "*" : "");
>  		break;
> @@ -2294,7 +2292,7 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				"Attempt to get soc clk levels Failed!",
>  				return -1);
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz / 1000 =3D=3D now) ?
> "*" : "");
>  		break;
> @@ -2312,7 +2310,7 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				"Attempt to get dcef clk levels Failed!",
>  				return -1);
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz / 1000 =3D=3D now) ?
> "*" : "");
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 03e63be4ee27..85d55ab4e369 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3366,8 +3366,6 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  	int ret =3D 0;
>  	uint32_t gen_speed, lane_width, current_gen_speed,
> current_lane_width;
>=20
> -	phm_get_sysfs_buf(&buf, &size);
> -
>  	switch (type) {
>  	case PP_SCLK:
>  		ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK,
> &now); @@ -3376,13 +3374,13 @@ static int
> vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>  				return ret);
>=20
>  		if (vega20_get_sclks(hwmgr, &clocks)) {
> -			size +=3D sysfs_emit_at(buf, size, "0: %uMhz * (DPM
> disabled)\n",
> +			size +=3D sprintf(buf + size, "0: %uMhz * (DPM
> disabled)\n",
>  				now / 100);
>  			break;
>  		}
>=20
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz =3D=3D now * 10) ?
> "*" : "");
>  		break;
> @@ -3394,13 +3392,13 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				return ret);
>=20
>  		if (vega20_get_memclocks(hwmgr, &clocks)) {
> -			size +=3D sysfs_emit_at(buf, size, "0: %uMhz * (DPM
> disabled)\n",
> +			size +=3D sprintf(buf + size, "0: %uMhz * (DPM
> disabled)\n",
>  				now / 100);
>  			break;
>  		}
>=20
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz =3D=3D now * 10) ?
> "*" : "");
>  		break;
> @@ -3412,13 +3410,13 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				return ret);
>=20
>  		if (vega20_get_socclocks(hwmgr, &clocks)) {
> -			size +=3D sysfs_emit_at(buf, size, "0: %uMhz * (DPM
> disabled)\n",
> +			size +=3D sprintf(buf + size, "0: %uMhz * (DPM
> disabled)\n",
>  				now / 100);
>  			break;
>  		}
>=20
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz =3D=3D now * 10) ?
> "*" : "");
>  		break;
> @@ -3430,7 +3428,7 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				return ret);
>=20
>  		for (i =3D 0; i < fclk_dpm_table->count; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, fclk_dpm_table->dpm_levels[i].value,
>  				fclk_dpm_table->dpm_levels[i].value =3D=3D
> (now / 100) ? "*" : "");
>  		break;
> @@ -3442,13 +3440,13 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  				return ret);
>=20
>  		if (vega20_get_dcefclocks(hwmgr, &clocks)) {
> -			size +=3D sysfs_emit_at(buf, size, "0: %uMhz * (DPM
> disabled)\n",
> +			size +=3D sprintf(buf + size, "0: %uMhz * (DPM
> disabled)\n",
>  				now / 100);
>  			break;
>  		}
>=20
>  		for (i =3D 0; i < clocks.num_levels; i++)
> -			size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>  				i, clocks.data[i].clocks_in_khz / 1000,
>  				(clocks.data[i].clocks_in_khz =3D=3D now * 10) ?
> "*" : "");
>  		break;
> @@ -3462,7 +3460,7 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  			gen_speed =3D pptable->PcieGenSpeed[i];
>  			lane_width =3D pptable->PcieLaneCount[i];
>=20
> -			size +=3D sysfs_emit_at(buf, size,
> "%d: %s %s %dMhz %s\n", i,
> +			size +=3D sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
>  					(gen_speed =3D=3D 0) ? "2.5GT/s," :
>  					(gen_speed =3D=3D 1) ? "5.0GT/s," :
>  					(gen_speed =3D=3D 2) ? "8.0GT/s," :
> @@ -3483,18 +3481,18 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  	case OD_SCLK:
>  		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id
> &&
>  		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> -			size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_SCLK");
> +			size +=3D sprintf(buf + size, "0: %10uMhz\n",
>  				od_table->GfxclkFmin);
> -			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size +=3D sprintf(buf + size, "1: %10uMhz\n",
>  				od_table->GfxclkFmax);
>  		}
>  		break;
>=20
>  	case OD_MCLK:
>  		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_MCLK");
> -			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size +=3D sprintf(buf + size, "%s:\n", "OD_MCLK");
> +			size +=3D sprintf(buf + size, "1: %10uMhz\n",
>  				od_table->UclkFmax);
>  		}
>=20
> @@ -3507,14 +3505,14 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size, "%s:\n",
> "OD_VDDC_CURVE");
> -			size +=3D sysfs_emit_at(buf, size,
> "0: %10uMhz %10dmV\n",
> +			size +=3D sprintf(buf + size, "%s:\n",
> "OD_VDDC_CURVE");
> +			size +=3D sprintf(buf + size, "0: %10uMhz %10dmV\n",
>  				od_table->GfxclkFreq1,
>  				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
> -			size +=3D sysfs_emit_at(buf, size,
> "1: %10uMhz %10dmV\n",
> +			size +=3D sprintf(buf + size, "1: %10uMhz %10dmV\n",
>  				od_table->GfxclkFreq2,
>  				od_table->GfxclkVolt2 / VOLTAGE_SCALE);
> -			size +=3D sysfs_emit_at(buf, size,
> "2: %10uMhz %10dmV\n",
> +			size +=3D sprintf(buf + size, "2: %10uMhz %10dmV\n",
>  				od_table->GfxclkFreq3,
>  				od_table->GfxclkVolt3 / VOLTAGE_SCALE);
>  		}
> @@ -3522,17 +3520,17 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>  		break;
>=20
>  	case OD_RANGE:
> -		size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +		size +=3D sprintf(buf + size, "%s:\n", "OD_RANGE");
>=20
>  		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id
> &&
>  		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size,
> "SCLK: %7uMhz %10uMhz\n",
> +			size +=3D sprintf(buf + size,
> "SCLK: %7uMhz %10uMhz\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FMIN].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FMAX].max_value);
>  		}
>=20
>  		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size,
> "MCLK: %7uMhz %10uMhz\n",
> +			size +=3D sprintf(buf + size,
> "MCLK: %7uMhz %10uMhz\n",
>=20
> 	od8_settings[OD8_SETTING_UCLK_FMAX].min_value,
>=20
> 	od8_settings[OD8_SETTING_UCLK_FMAX].max_value);
>  		}
> @@ -3543,22 +3541,22 @@ static int vega20_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
>=20
> od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ1].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ1].max_value);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ2].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ2].max_value);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ3].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_FREQ3].max_value);
> -			size +=3D sysfs_emit_at(buf, size,
> "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
> +			size +=3D sprintf(buf + size,
> "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
>=20
> 	od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value);
>  		}
> --
> 2.31.1
