Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0866FC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 08:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A72601FA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 08:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A72601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA056E497;
	Tue,  1 Jun 2021 08:12:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DF56E497
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 08:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEWsQdKF6HQgwLQzKKLZU5WrHqfBqoLBEqPt3ALJvUsVWzKQLIlvfnFPoyhNwnHTuqsjiFtA+NX7XQvSiO6lSn038SiRv4PVH0Sk+vSYDHumxW7270hsj+t6eeIWY2YOt4gTHkWEqr2IGmyz2w/tY0S7RIACBLzS9zFYdG2MXzOCsaDBGxnruqSj32iOmbu97MdUSnRr9kydgW6ZhnKuNifOkFxEY77DurQsh+tVK7JyRVEBNVyjQ11WtJatKHHSzP/mvgyYP2i0y96oqV3+wPC0uWuzX+EcD4g1R2Wta9kWEvTaQAwYxXqAP/zLiNFa+FUgIYM5/IBXhJotXN0LPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqjYfJeOR3i2KPblgK6I3gzWlZ2lM9kC42sO2n4MhSE=;
 b=QPE4WnBNKLW9A9K30relcojgpntYdUtI7/j5J4wRVY0cZ+UXbGlOXhkUibW9k7Jw2z2XhpJiy54LjC8NEsTn4b+LqanOSCoe9lseI9hL1c6qiBjZpsXAD3AbqI0StN5ZUQefdE1chubxRJJOiSdh+Q/+cBLYE0z/z0oz+V8msnvIw/hrxt2MG1VzUcA14RfVdTEGYJik8UjdKvy+G95EDoqXvGpXiViURRH1fkFGUJdR+4emNaQ5vP62YeOyNXLjSxaWzPx4V3ilX5wFJRkN1toORG8tM3SBZQ3g79DHscGUaRVFlta0XX+lcSy47GCjDvSBt+BhYGZwtQdeFsOhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqjYfJeOR3i2KPblgK6I3gzWlZ2lM9kC42sO2n4MhSE=;
 b=qxuLtKaKwac8oKMeg25dnut9VOSeBUqzEHmwd4ZnSw6I6GZblh+OZ1M99VGSZl+WlnkEZnDaWiVjgHeqQXeKjdr3AC47C8z4ITjBwWICDLKEdf/t/zTlB3p6HQXaMfS/VCJn4SSWiz2pmQhgdLa9sTQcyiX6BgDTnd59np0y0X8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2506.namprd12.prod.outlook.com (2603:10b6:3:e7::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Tue, 1 Jun 2021 08:12:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 08:12:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] amdgpu/pm: add kernel documentation for
 smu_get_power_limit
Thread-Topic: [PATCH 6/6] amdgpu/pm: add kernel documentation for
 smu_get_power_limit
Thread-Index: AQHXVBYlrF2yKwWJ20CAddIITBBchar+0z9w
Date: Tue, 1 Jun 2021 08:12:07 +0000
Message-ID: <DM6PR12MB2619444F7625060C0ECC5F88E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
 <20210528230621.16468-7-darren.powell@amd.com>
In-Reply-To: <20210528230621.16468-7-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-01T08:12:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e5300b7a-e143-4316-9e23-05dfc794dd92;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a60176c-36c5-45be-8527-08d924d4f2a2
x-ms-traffictypediagnostic: DM5PR1201MB2506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25069FDE897EA7E5E7792F0FE43E9@DM5PR1201MB2506.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBmIGVqNRpYBc34WUR5XF8PN+GtYWbz9UY6zCqmletPG9dIEPbaAgo+y1rLqa0JsTuZ37aWeqQ/QawR3KmcjhZpnziU9e+7fLeBPJ7qn/Kk3Rpjl49IuJSKwFaFTUPvxy6Wluvle7P2nd3UnLF0korRw9+95bksZb5VREBpxXzUvJcxsEz7NdCzmS/ovETPSIKOaPOjpLEjYb2WycEJeh/5rC00Q+HzIxqIrBKnIKrD95Qff+5zbBPw2GkYZ3u4Gb3Q8ODUN8f+TWz2Ghdkn4DCcoXEjstHoB0oBOB7amNNxx0ga2bVaXUXoR+Nn2iPjhKkXf3Ai3QDFxgQZAa44yavTANijDprMdaRT03quw3nWVrIKdJlcGQRt/5kKacgzs3GRP7MlJ9LxGVnRGOA/lQD4wwKhRl1r8qm5JxLdPzXAKEZRPwe+eBAMTcjnXrivwC6YHOpGUI4lSp/6/I0GPZTuZRs6PeljD7aHgzrJQfTVjM3k5UfcEE71A/GlgbAnyzRd0pFBkBBGoIOeeDjVovEmYy730osHM+kCmL+/VzFmyZtlC0M/i4el/LXTTcHtCJUrRuEQlSLuV2s4j5zCQCQuut+5i1oJ72CCsLwhJtxWAUqJVnLEg1MnNt2I31BNlIMO5lJkoDwmXJoosftueTbpv9e1TRcDTXh32f1KLzTYmcG5Y48U+8AGl5izl0mjkZatVOUtTGrCc+BVO2P2a+WpjpfzgMkdDxZVxH2QcBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(55016002)(52536014)(966005)(8936002)(5660300002)(122000001)(86362001)(110136005)(4326008)(45080400002)(83380400001)(316002)(33656002)(71200400001)(9686003)(76116006)(186003)(2906002)(38100700002)(26005)(53546011)(6506007)(66946007)(66476007)(64756008)(66446008)(7696005)(478600001)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yiozP8BcazfPotkrt1GmNVTRyJr5oBv//EtD8bD6mAUZWL626pzQxndkYyyL?=
 =?us-ascii?Q?EtesfxmNCEPfDClSKUboZHjhSsf7C4jS9AG+5TUzeF84mL2WirsU5RSm9IFW?=
 =?us-ascii?Q?CS45eVc9rtnqtM3jYNuePeT4dOrvhKd87dzDH7WsimiMVtDp+nHN/43JhTwD?=
 =?us-ascii?Q?FWvKvtp8k+0XaTIGWTzbCl4X8cQrH5rLKTeVkMdX28Q1AsFbmcteni3mPFlw?=
 =?us-ascii?Q?C9D3OYpyFWbBHZnift0jfvjU2sgN2xvM8kOMfSx2Ayxu5Hnhm9kzgLxdCcwL?=
 =?us-ascii?Q?mW+Dl0hrdlNz9Ify+JTG3R70a4kmF/zBrEjfoNn9Inf0Cx223MfsxDSRgdpv?=
 =?us-ascii?Q?MFrdVLMV2elfDukU6AyPHkM4iWvBPlZS6C4F9HFvc81LaPO2D0agiX/mmtfb?=
 =?us-ascii?Q?C25suvYXI51z5+Wu2cTpP8Wg6QjGc+DGOyAjqL/XmH9hwaR73GW8KjC8DpW+?=
 =?us-ascii?Q?Hsi6zELe3HqIL5J6dnIZwelYbaxZVGTgsvaNddQ/zmwJj169G1FdBaprpkQ0?=
 =?us-ascii?Q?ZzXUTuq5CP4611ebQjk/eWpCtqllpjAD8FLpEzTWqFBI2iUe6opR6acyJhZh?=
 =?us-ascii?Q?b5Si6xk8YRmpxLw2Nv2+mREFfl3nCGfpjXGMRaKHcvRkn2YTndxkJqtg64UP?=
 =?us-ascii?Q?eILHjBXrhIhkrDtYz82pC3IYEI4ddoNjkDd2rFK8W15BvuGUcbBRo9oIiFz9?=
 =?us-ascii?Q?CB8oqxUoA3eRBeeD9zP+A5xcX8KudJ6HSQ8qoE6eLoHJAxWpYRI+FDZDo7pr?=
 =?us-ascii?Q?82vEsWSKgAbhc5X3PIEGo0UkanJXlRC2JdHwjVCO1sym2VfZwj9AeHrRLHEP?=
 =?us-ascii?Q?x+2oj40n3Y/RJZmTQUHlkeFNmOp/s5OIxfwHXHb/P5Ek4ryNqyigK+ZnVleb?=
 =?us-ascii?Q?OO3R2b76IcU7ckd/ffHq4LcX2sMQqcnbB5OLUQyg02Sf2Ftb/O+8F7RCAJp1?=
 =?us-ascii?Q?wOiaZ6ABTQDGm8b4a7CEqLPS5mMLisFWaq3KHL7bTgS1fRVxhuzbYhepuRsk?=
 =?us-ascii?Q?80Cp1fLfKTG3NfG/Mk5tY3LonmTdXA+fUqhn7il6sWOn5vd68MNt1eAZyKv/?=
 =?us-ascii?Q?bUj2wy0vI4kQ7BjWmBJGB3KrSsI8xnWCCDwQDk9FeSHcn6EDWLKhcj7cWNwQ?=
 =?us-ascii?Q?sjFMBAIo8EqiX0OMN50kttYXgPdhy/X1NdteBHMGJH3tk2qsT2LbtvVZY/N/?=
 =?us-ascii?Q?hg7Xxu0ERpTwrICyjWYNoLA0m3Bv43+v8fQgffg0CWfRR0wfn2TBvcYpu0p6?=
 =?us-ascii?Q?9oORMR6nyI9RKi4MYJ7tfeovTBJSaOfs0FuzyHDQ+xVZrWVL76hw6FQuAGhv?=
 =?us-ascii?Q?hzwxYpWs9iBfnUGvB7hq4/Sj?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a60176c-36c5-45be-8527-08d924d4f2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 08:12:07.1629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3ODV1GTzTDTkejcb/Wrto2d+kzHPq1oMvjkNfxhxnIUZXh9sK5+9VXOL02OzXdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2506
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Darren Powell
> Sent: Saturday, May 29, 2021 7:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH 6/6] amdgpu/pm: add kernel documentation for
> smu_get_power_limit
> 
>  added doc tag "amdgpu_pp_power" with description
>  added tags for enums  pp_power_limit_level, pp_power_sample_window
>  added tag for function smu_get_power_limit
> 
> Test:
> * Temporary insertion into Documentation/gpu/amdgpu.rst
> ------------START------------
> Power Limit
> -----------
> .. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
>    :doc: amdgpu_pp_power
> 
> .. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
>    :identifiers: pp_power_limit_level
> 
> .. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
>    :identifiers: pp_power_sample_window
> 
> .. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    :identifiers: smu_get_power_limit
> -------------END-------------
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 30
> ++++++++++++++++++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 369a72f03e92..46d2fc434e24 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -192,6 +192,26 @@ enum pp_df_cstate {
>  	DF_CSTATE_ALLOW,
>  };
> 
> +/**
> + * DOC: amdgpu_pp_power
> + *
> + * APU power is managed to system-level requirements through the PPT
> + * (package power tracking) feature. PPT is intended to limit power to the
> + * requirements of the power source and could be dynamically updated to
> + * maximize APU performance within the system power budget.
> + *
> + * Two windows of power measurement can be requested, where
> supported, with
> + * :c:type:`enum pp_power_sample_window
> <pp_power_sample_window>`.
> + */
> +
> +/**
> + * enum pp_power_limit_level - Used to query the power limits
> + *
> + * @PP_PWR_LIMIT_MIN: Minimum Power Limit
> + * @PP_PWR_LIMIT_CURRENT: Current Power Limit
> + * @PP_PWR_LIMIT_DEFAULT: Default Power Limit
> + * @PP_PWR_LIMIT_MAX: Maximum Power Limit
> + */
>  enum pp_power_limit_level
>  {
>  	PP_PWR_LIMIT_MIN = -1,
> @@ -200,7 +220,15 @@ enum pp_power_limit_level
>  	PP_PWR_LIMIT_MAX,
>  };
> 
> - enum pp_power_sample_window
> +/**
> + * enum pp_power_sample_window - Used to specify the window size of
> the requested power
> + *
> + * @PP_PWR_WINDOW_DEFAULT: manages the configurable, thermally
> significant
> + * moving average of APU power (default ~5000 ms).
> + * @PP_PWR_WINDOW_FAST: manages the ~10 ms moving average of
> APU power,
> + * where supported.
> + */
> +enum pp_power_sample_window
>  {
>  	PP_PWR_WINDOW_DEFAULT,
>  	PP_PWR_WINDOW_FAST,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5671abd58bcf..b7a9037a2dbc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2166,6 +2166,16 @@ static int smu_set_fan_speed_rpm(void *handle,
> uint32_t speed)
>  	return ret;
>  }
> 
> +/**
> + * smu_get_power_limit - Request one of the SMU Power Limits
> + *
> + * @handle: pointer to smu context
> + * @limit: requested limit is written back to this variable
> + * @pp_limit_level: &pp_power_limit_level which power limit to return
> + * @sample_window: &pp_power_sample_window measurement window
> + * Return:  0 on success, <0 on error
> + *
> + */
>  int smu_get_power_limit(void *handle,
>  			uint32_t *limit,
>  			enum pp_power_limit_level pp_limit_level,
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C171d1673dbaf4dad5
> dbd08d9222d473c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37578400133814296%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> 1L62QveKX%2B2UjfHPF9TUE8BREmMYbJkHUpQPlzmi324%3D&amp;reserved
> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
