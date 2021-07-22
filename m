Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BCC63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D3861244
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D3861244
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCED6E9CF;
	Thu, 22 Jul 2021 08:33:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3DDD6E9CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 08:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFbZ+KIZdqNetMMzYa4+InyTfO45MO6i5++e2DkoyJLAnYCwxNmgwGFoCR93EMimPSeUIqJTvlrOMti+o0V1mtPyNVk9VNmZkOnyRBbXc28RvxHyuzNLAG31OywLZXrMQFNrwac1R01SBvgZDvVyPJGkvd4+gZhfzKkyUJiAI2KwhMw/2bTDXFpgsYus+b4UuMJws9cuR+1VAbkHUqD20rE8updCugj3sb5lbTegv4895wHLBQplVbbq8m0m8brzMNPIJX+hhuVipzjtbHlFr3a37VKK9ADV6tm6WIDsUteHWXpnpSREx7lq+OamKEQZc01KGXKVAApVaq8JvsIT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH7dNaye0qCAGz4vLYoy4MbUNvhI0dAwSFcCwM8vlhQ=;
 b=e3hEkM0IDRaTo39G+pJEiCuIbYnsJQb8qasg1WXj2Fj1GICNllt8UB+BE/lKEJL43PnqrRa82Tv5FxEF2B5pt6hPY3Kq1I2e7iUqDPmXW8EIo+A7piOQM+oL2eDvEWKSLpz0q8B3EZcvG69WOf2vfm/nfn6GBKGPZJjyqql927ipo6Tv4rR+xJrZFP4MtTWld2F2X/CjMEToX4sAC/w95ILgek5L9h/ug8rk3pNM1Gc85yYfHI9Vu2SAL2fDWBvCm7jy1dKJzrvX5Ca+N1f7q4XCrMjomnJ5jMD0OO7PxU7LYefH6XeuCND342xa7CF3OasHHbIq9VTKx72NhXUXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH7dNaye0qCAGz4vLYoy4MbUNvhI0dAwSFcCwM8vlhQ=;
 b=FLA9IjxpvnM7gsBU0JyPTilhwkCc6FAbIY7JC1F/qQfSWaNPr6iTvYd+6qUWbHy7M2sje1OjATp5PSFE4qnTPj6dFq22e398/HCn70A6B1lFY5Z/JxwSnSUmOewJRHG2ZMpiofujVUpByMTsF0WRXU7Fft8L2j32sQLQsZwFBQw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24; Thu, 22 Jul 2021 08:33:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 08:33:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXfqifeeLDV50fl0aVa8y8c1VYEatOpKWAgAADICA=
Date: Thu, 22 Jul 2021 08:33:42 +0000
Message-ID: <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
In-Reply-To: <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-22T08:33:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b3e2b346-7ce0-4b07-b044-892d722f4965;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16f186df-3fad-4af9-959b-08d94ceb6a29
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0028E188200EA10FAA2B8BECE4E49@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjVdEB91c0LGFlhSMP6trUnmA/HzMayGBQ3YvOO+IoI97eyx6kR+yS2DE0RMsjaIaQ/W4D1X24nNhucF3U0M3K/ZWh0IYMiPtgjeGYvZ8ZJ+WX8CPBJ4jmRKlWt5v4DyKc47jwDqshj27r4GNl+tFFv8AtpNYV3HvEQ4mwT5+uqdKB19aMm0xcrDWqa3cEFUmdtJVAa10nS+oHbeQFSMu3CwPqEDhx7A2aOk8jkX1IQfLzT85D4jrnTANdpFKYPnOGdTP8Me/YvV8q+3s42jD5HWpZv2DTYFVlKas7gFwKCDFHhABbDwJ0Id60VuOtekfaylQ4KS+nCDpUJ1MSvyk/dmX6mJM0Q+l9ON4BJGAAjn250W2GQAMOgwK/AGUwVSZNL1Ksk5G8DMy4VNijSU9GrXr16OeUB5YWx78vwZH6UsU4MS3mqXEtvQtvV6EL0TgLK/0mcAJADDOivka6SBjbP4UoBPGgBboSmFyy8lXPPLTyk0oXIsC6tCuMZAT8t6OhP+hjySPE41gntiCIUuqSPikyYx4VLbvLh1Tzxm4ApYKF+/8fKrg2VT4CCkFm9t8rrkEBoY3y5G1Q/+9OQGYqZWkUH6yDKKKwx5eGzU/1GLPJqqvgtOdwviF+rlhcecXEhHpEZFODya7Myg3tR716ZH4Pwn3x8QL7VHQyIkUlAGvQ2DP0Q3kn1JsLR1P3cjGYItnnHrHcU1D+XfB9YorDKgj1Ou+uvuP7jBVaaPEss=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66446008)(66556008)(64756008)(66476007)(9686003)(33656002)(71200400001)(52536014)(83380400001)(478600001)(6506007)(5660300002)(26005)(86362001)(7696005)(186003)(30864003)(55016002)(53546011)(8676002)(66574015)(38100700002)(4326008)(316002)(122000001)(8936002)(110136005)(66946007)(76116006)(2906002)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1RjZkR0cXJ4MjZIVytzNHUxaDdqREszQ0hyY0p1MlJibURyWWlicm9Ccnd5?=
 =?utf-8?B?Tm93dFhJa0ZBVlVuVTFTZXVzd0dWQlJjRlJZRHlZM25YcUdNdzJ3NWhqdVRt?=
 =?utf-8?B?THFYNlQrM2NET1MyZjArQ3hxdXRwaHJrWkM5dHRCUlRsd1l6VnUrMTB5aWRj?=
 =?utf-8?B?UnFmZFZ2WWhwalhaV3grMGR2eXl3Yms3TGQwZ3VsM1VRd0x1NHVzOGhBWEJp?=
 =?utf-8?B?TU15TWEzUnhpZVdVL2lYcTVXV1N6ell6NTRJRTkwYjhBeFh0anpXMU5UNkdZ?=
 =?utf-8?B?bDFaVXVNaStSbUcrcWQzMVVIelV4R0JXWDY5TEQyOHpSMWRuMUtya3EzRlND?=
 =?utf-8?B?VFVWazd2VzVKRmxIWXpkaS9Md0RWUWJVemhqUDZaczJTRG84TTJHOUM1QnFa?=
 =?utf-8?B?Vkpncm1wbXpHOUwyS1J5czFyaUVkUGQrVkZPQ2FTM1JXckZTZElpbW9rZWZ5?=
 =?utf-8?B?VytZOFJjWnBPKzhqaGtxMTlJN0tOeThiVWRQOERURVBDQ1J2b1dKc21sRFc4?=
 =?utf-8?B?WENVSytGTFpKN1RZeXVPZzRkckJXVytBOTc0NENyOXdqUWdIUTh2R1hIWE1T?=
 =?utf-8?B?QjlXWjNMOEJjT0hkK0x3T1UyZ3FkOUhzZ0pKWHJGWWVlTEhmNzdkM2Q2QUJ0?=
 =?utf-8?B?dm04cnliMDA2cTJYb1daNFZxWk4rdTRCWWhXMTd6dE1CbXdoQThCQ25JbERG?=
 =?utf-8?B?YnA3WEpFVEprMmZoREx4TVNxVy9pUzZxaFkxTkxCNWNHdlIvUDNMcmErYVEy?=
 =?utf-8?B?bDZ5VmtrYU5qeEFCTHA5NkFCaEJ4MDc1eHIxaHlYZUZoVk1MeExhaWJ2em1p?=
 =?utf-8?B?ZTlkVFZvV3JXKzZDNXRrb3g2Z3plMm1pNDhMamN5TFllb1NvUGJERWkzWWRy?=
 =?utf-8?B?d2dmeHJoVWZWWDlNOUpmbzlaelpjMjNWNXkrb3dIN2VsRmhXd3JlNDhvbGVy?=
 =?utf-8?B?L1NnNUd4cVMvZ0YwcWltdjluSkpUaUJHZWJQNk5sazZoQWg4VnN4bUs3emhk?=
 =?utf-8?B?aGNxU294K1dyQXhaOEk3d1RhcGwwSDVLTmZHMFdYaFpZWDZHVG1MSSt4emFs?=
 =?utf-8?B?WkxSSzFubHV5QkJGRmdLWEl6YXhRU1hsczZ1ZUNiemFialdva2YvVTU5aEdD?=
 =?utf-8?B?OWNTSTlTeGNzSXhZeHNtT1J1emc5K3g2WkdDR2VjR2M5TXVlcWU5K3lEcGlo?=
 =?utf-8?B?dGVuMW9WTmYvNk9ncTIxaUk4bmY1aHRGVk0wSHVoUUtBSnZFYjN5RjB0bTZB?=
 =?utf-8?B?MjR2RVlRRm93eUN3ckZ2NWptVXRtYnAyQWgwVHBsa2o2cXBjRDhJVUdBdk1G?=
 =?utf-8?B?akhmMHNlUHZhRnNqc1ljMXVsRjVlMHdwRVEzbXdyaG9UWTRPd2dOMC9mRUtp?=
 =?utf-8?B?YTJzeHhoTnA2dGkyZUR6bUFOeVFRbGplZnpPbitKMDhWbjIxWmJycFUyK1pY?=
 =?utf-8?B?K1VpenBvTktsQ0ZIcGhqYWVKRHJEZTdMY1d2RGNZWGdiOHpJdlR1b3FncjdM?=
 =?utf-8?B?elg4anRKajJkd2FYdTBUVmtnNkFZNFR0TmVuc0pWcFA4NGdxS1dWSWxOUFpm?=
 =?utf-8?B?QmJhb1FvV1M5dGV0dUN1bHM1OEoyOWl1dmhLUm1iaVUyWlBPNG9rdFBBek8r?=
 =?utf-8?B?M1BQTTJDY056Qi9VZWsxUENTNmlkVWp3NnVhQWJvUXpIcEFFdUp4d3RvR25L?=
 =?utf-8?B?NGRVekN3UVcyRzMvVFkzcnlWZ2FMWksyd3ZpUEp4OEl4cmFFbUU4OEo5T1BB?=
 =?utf-8?Q?XMwVz15gqXFiHw+YXVcUlw7F3OE/5rZEDK6rwht?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f186df-3fad-4af9-959b-08d94ceb6a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 08:33:43.1141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DROZ0DP0s2JQEd41zlnNM7bmrCzLajWTeDE9E9UfJzROh5x2MW2tc3CkTkcjlDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, July 22, 2021 4:10 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
> properly for NV1x
> 
> 
> 
> On 7/22/2021 8:50 AM, Evan Quan wrote:
> > The customized OD settings can be divided into two parts: those
> > committed ones and non-committed ones.
> >    - For those changes which had been fed to SMU before S3/S4/Runpm
> >      suspend kicked, they are committed changes. They should be properly
> >      restored and fed to SMU on S3/S4/Runpm resume.
> >    - For those non-committed changes, they are restored only without
> feeding
> >      to SMU.
> >
> > Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52
> ++++++++++++++-----
> >   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
> >   4 files changed, 69 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index 3e89852e4820..8ba53f16d2d9 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
> >   	uint32_t power_limit;
> >   	uint32_t fan_speed_percent;
> >   	uint32_t flags;
> > +	uint32_t committed_od;
> >
> >   	/* user clock state information */
> >   	uint32_t clk_mask[SMU_CLK_COUNT];
> > @@ -352,6 +353,7 @@ struct smu_table_context
> >
> >   	void				*overdrive_table;
> >   	void                            *boot_overdrive_table;
> > +	void				*committed_overdrive_table;
> 
> May be rename it to user_overdrive_table - OD table with user settings?
[Quan, Evan] Actually "overdrive_table " is  the user_overdrive_table. It contains all the modification including those not committed( the commit is performed by echo "c" > /sys/class/drm/card1/device/pp_od_clk_voltage).
The new member added refers to those user customized but committed only settings. That's why it was named as " committed_overdrive_table". Any good suggestion for the naming?
> 
> >   	uint32_t			gpu_metrics_table_size;
> >   	void				*gpu_metrics_table;
> > @@ -623,6 +625,12 @@ struct pptable_funcs {
> >   				 enum PP_OD_DPM_TABLE_COMMAND
> type,
> >   				 long *input, uint32_t size);
> >
> > +	/**
> > +	 * @restore_committed_od_settings: Restore the customized and
> committed
> > +	 *                                 OD settings on S3/S4/Runpm resume.
> > +	 */
> > +	int (*restore_committed_od_settings)(struct smu_context *smu);
> > +
> >   	/**
> >   	 * @get_clock_by_type_with_latency: Get the speed and latency of
> a clock
> >   	 *                                  domain.
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index ebe672142808..5f7d98e99f76 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct
> smu_context *smu)
> >   		}
> >   	}
> >
> > +	/* Restore customized and committed OD settings */
> > +	if (smu->user_dpm_profile.committed_od) {
> > +		if (smu->ppt_funcs->restore_committed_od_settings) {
> > +			ret = smu->ppt_funcs-
> >restore_committed_od_settings(smu);
> > +			if (ret)
> > +				dev_err(smu->adev->dev, "Failed to upload
> customized OD settings\n");
> > +		}
> > +	}
> > +
> 
> Just thinking if there is a need to handle it ASIC specific. The flags and table
> pointer are maintained in common structure. So can't we do the restore of
> user OD settings directly in this common flow instead of having each ASIC to
> implement the callback?
[Quan, Evan] The OD settings restoring is ASIC specific as it performed on OD table and that(OD table) is ASIC specific.
> 
> >   	/* Disable restore flag */
> >   	smu->user_dpm_profile.flags &=
> ~SMU_DPM_USER_PROFILE_RESTORE;
> >   }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 59ea59acfb00..4752299d7f91 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2296,39 +2296,45 @@ static int
> navi10_set_default_od_settings(struct smu_context *smu)
> >   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> >   	int ret = 0;
> >
> > -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void *)od_table, false);
> > +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void
> > +*)boot_od_table, false);
> >   	if (ret) {
> >   		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
> >   		return ret;
> >   	}
> >
> > -	if (!od_table->GfxclkVolt1) {
> > +	if (!boot_od_table->GfxclkVolt1) {
> >   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > -								&od_table-
> >GfxclkVolt1,
> > -								od_table-
> >GfxclkFreq1);
> > +
> 	&boot_od_table->GfxclkVolt1,
> > +
> 	boot_od_table->GfxclkFreq1);
> >   		if (ret)
> >   			return ret;
> >   	}
> >
> > -	if (!od_table->GfxclkVolt2) {
> > +	if (!boot_od_table->GfxclkVolt2) {
> >   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > -								&od_table-
> >GfxclkVolt2,
> > -								od_table-
> >GfxclkFreq2);
> > +
> 	&boot_od_table->GfxclkVolt2,
> > +
> 	boot_od_table->GfxclkFreq2);
> >   		if (ret)
> >   			return ret;
> >   	}
> >
> > -	if (!od_table->GfxclkVolt3) {
> > +	if (!boot_od_table->GfxclkVolt3) {
> >   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> > -								&od_table-
> >GfxclkVolt3,
> > -								od_table-
> >GfxclkFreq3);
> > +
> 	&boot_od_table->GfxclkVolt3,
> > +
> 	boot_od_table->GfxclkFreq3);
> >   		if (ret)
> >   			return ret;
> >   	}
> >
> > -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> > +	navi10_dump_od_table(smu, boot_od_table);
> >
> > -	navi10_dump_od_table(smu, od_table);
> > +	/*
> > +	 * For S3/S4/Runpm, no need to install boot od table to
> overdrive_table as
> > +	 *   - either they already share the same OD settings on bootup
> > +	 *   - or they have user customized OD settings
> > +	 */
> > +	if (!smu->adev->in_suspend)
> > +		memcpy(od_table, boot_od_table,
> sizeof(OverDriveTable_t));
> >
> >   	return 0;
> >   }
> > @@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct
> smu_context *smu, enum PP_OD_DPM_TABL
> >   			dev_err(smu->adev->dev, "Failed to import
> overdrive table!\n");
> >   			return ret;
> >   		}
> > +		if (memcmp(table_context->overdrive_table, table_context-
> >boot_overdrive_table,
> > +			sizeof(OverDriveTable_t))) {
> 
> Shouldn't this be - compare against the edited settings and last committed
> settings, overdrive_table vs committed_overdrive_table?
> 
> Basically, user_od_table can be initialized with boot_od settings and the flag
> gives the indication that user_od table is being used or not.
> Before updating, check if the edited table (overdrive_table) and the current
> user_od table are different, then commit the new table.
[Quan, Evan] Yes, I also considered that. But that cannot handle the case below:
1 user made some customizations  -> 2 the customizations were committed -> 3 user restored to default(boot) OD settings(by "echo 'r'") and committed
Although there were some changes between 2 and 3, there is actually no real customized changes compared to default(boot) OD settings.
> 
> > +			smu->user_dpm_profile.committed_od = true;
> > +			memcpy(table_context-
> >committed_overdrive_table, table_context->overdrive_table,
> > +					sizeof(OverDriveTable_t));
> > +		} else {
> > +			smu->user_dpm_profile.committed_od = false;
> > +		}
> >   		break;
> >   	case PP_OD_EDIT_VDDC_CURVE:
> >   		if (!navi10_od_feature_is_supported(od_settings,
> > SMU_11_0_ODCAP_GFXCLK_CURVE)) { @@ -2499,6 +2513,19 @@ static int
> navi10_od_edit_dpm_table(struct smu_context *smu, enum
> PP_OD_DPM_TABL
> >   	return ret;
> >   }
> >
> > +static int navi10_restore_committed_od_settings(struct smu_context
> > +*smu) {
> > +	struct smu_table_context *table_context = &smu->smu_table;
> > +	void *od_table = table_context->committed_overdrive_table;
> > +	int ret = 0;
> > +
> > +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void *)od_table, true);
> > +	if (ret)
> > +		dev_err(smu->adev->dev, "Failed to import overdrive
> table!\n");
> > +
> > +	return ret;
> > +}
> 
> As mentioned before, not sure if this is needed as callback. Even if, this can
> be something common for smuv11, there is nothing ASIC specific in this logic,
> right?
[Quan, Evan] Yes, in patch2 of the series, it was made as a SMUV11 common API.

BR
Evan
> 
> Thanks,
> Lijo
> 
> >   static int navi10_run_btc(struct smu_context *smu)
> >   {
> >   	int ret = 0;
> > @@ -3262,6 +3289,7 @@ static const struct pptable_funcs
> navi10_ppt_funcs = {
> >   	.set_soft_freq_limited_range =
> smu_v11_0_set_soft_freq_limited_range,
> >   	.set_default_od_settings = navi10_set_default_od_settings,
> >   	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> > +	.restore_committed_od_settings =
> > +navi10_restore_committed_od_settings,
> >   	.run_btc = navi10_run_btc,
> >   	.set_power_source = smu_v11_0_set_power_source,
> >   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask, diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > index 0a5d46ac9ccd..28fc3f17c1b1 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
> smu_context *smu)
> >   			ret = -ENOMEM;
> >   			goto err3_out;
> >   		}
> > +
> > +		smu_table->committed_overdrive_table =
> > +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
> GFP_KERNEL);
> > +		if (!smu_table->committed_overdrive_table) {
> > +			ret = -ENOMEM;
> > +			goto err4_out;
> > +		}
> > +
> >   	}
> >
> >   	return 0;
> >
> > +err4_out:
> > +	kfree(smu_table->boot_overdrive_table);
> >   err3_out:
> >   	kfree(smu_table->overdrive_table);
> >   err2_out:
> > @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct
> smu_context *smu)
> >   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> >
> >   	kfree(smu_table->gpu_metrics_table);
> > +	kfree(smu_table->committed_overdrive_table);
> >   	kfree(smu_table->boot_overdrive_table);
> >   	kfree(smu_table->overdrive_table);
> >   	kfree(smu_table->max_sustainable_clocks);
> >   	kfree(smu_table->driver_pptable);
> >   	kfree(smu_table->clocks_table);
> >   	smu_table->gpu_metrics_table = NULL;
> > +	smu_table->committed_overdrive_table = NULL;
> >   	smu_table->boot_overdrive_table = NULL;
> >   	smu_table->overdrive_table = NULL;
> >   	smu_table->max_sustainable_clocks = NULL;
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
