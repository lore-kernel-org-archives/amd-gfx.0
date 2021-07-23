Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E470C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 06:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FD560ED7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 06:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0FD560ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765C76EEA8;
	Fri, 23 Jul 2021 06:47:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2906EEA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 06:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+iXCSG3pWfWAdMiELvoeJnhXhTTm7neRsTXmxpWm650tk74vUYuuTZsu+JZJpmAkJzK7FjruVg8E5nkt8IuYCoxobYzTkEeOk3Pv73Ft3buOPrX7mSQUdrNO6pUyc0u//11Q/FJ073EjhZzYYi4AZo6NxxWvARvlTcfD+TdEiovj+RUix/M4CvwGwFJbPslQH1EGvF15M7KyhZALmO9AciSqID22kzjLGA2b/LBfvnbtFp9yFLgJ4bMcM/54fEOcHdImU+2T1yURGOeDBw8cfS1ID8/f0IIDd1UqObfs5BUsj0EvnsIoGLdMRQV5BF3Tm9TTVw8RdI+oR3ZpVQ6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCCR0l2ZWAdP7Z5+GvZ6HDNtDXcMNY0lBcNdcfP8ehw=;
 b=mVhCxqdnzjA8mW6dxUDZeMj1k1HNJPHMEgWddlXyw6DTQVpLREPAhh0qAGiWuOxdN4On4M4HQpNXhA03NFZs1MhvycXPjnbo7Ke4+sQWD/+hIR70RA1y9Vv42ktz7Hk2mBDonLrlN40evu+1Wn/jMnIU0VJDiwkUyjMJMIPzIQPNZX2+STUwHwVgSFuKbMwY+WU5dku8e3CB5TAMhPaEAsIsyzRIvrxrk61jNsr8IqN376dJD/SvLfgLCpKO49UUAweKPgmyYsqDQCP8Za3xMfd85A93kgbVQsXawBJCwaUpJykRxiAXmL3aWeBBvTT8NItxd3dmMJuFTfaH3uUM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCCR0l2ZWAdP7Z5+GvZ6HDNtDXcMNY0lBcNdcfP8ehw=;
 b=RdXxzW0B5VwQumIfgRpltQdOABJy2dHyTB0k9DDyPofSN/hhtlXMBLviXChstrP1JhzWywHIz+NB9r92VbNp/rg2qU1WndRl6nua4RoK+CdVmpaS9Ls+6lYRzgap09aAISqUzofeM/v6hSKfypeDWwu9TezhftwwT6raKBjOZZg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24; Fri, 23 Jul 2021 06:47:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 06:47:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXfqifeeLDV50fl0aVa8y8c1VYEatOpKWAgAADICCAAAvBAIABaXAQ
Date: Fri, 23 Jul 2021 06:47:43 +0000
Message-ID: <DM6PR12MB2619A8E359A153660B23092EE4E59@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
 <DM6PR12MB261987F64682AB6A0A337A30E4E49@DM6PR12MB2619.namprd12.prod.outlook.com>
 <47ba61d1-d76e-b10f-acb6-fa25bb4c4d44@amd.com>
In-Reply-To: <47ba61d1-d76e-b10f-acb6-fa25bb4c4d44@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T06:47:39Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=12f0aa7a-45a4-4996-9001-1fe9ae08a9fd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac1e7217-a25e-454f-467d-08d94da5c5c6
x-ms-traffictypediagnostic: DM6PR12MB2826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28265E1EB3DBF580181C4CCEE4E59@DM6PR12MB2826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOP4qA9/aJCWGm0oCCF9BHzQ/SKBvueFFUKi3FF+n4WKDHbF5Wun+Gjnf0PRssa0ZQJV0F9JTYImKD/thJYhGbof3RYiRQiBj2rE2mohqCSQzvk9KRcvdE4+VcThROuwrdebFOOmTkfZGD20cGCqeJiytnON3FfZeRPP6QZaYe21xIF+GsOiUk//muN0g0NgvIUxYrmvsSIH8eD4wSHm3PijPpQ10OMupuc74SZcQ+SdMsXVMUH8YNFAomlSXCizp6qDWwhT2tpRsqx9igTvhiCWGY4Cb7vMaWwBG8FgkEyMXY1yeYX6Oz7GXHR6VRx5UG2eUhAq4g/aa6XHT5UiSgFawsa+jSsu8ccg90ppwc5lqc0s1rAxXIOhOhYPavwICSHlGJfLF9s+oi2WoSK4jzwmvtudicSSQYjiYOQNgIa6DcJcDnNRouXLY0s2Wf5Bvvs+YGKrLXtX9cmhoeUkq4SQwtTC3X9VV3uCjpn3nW5LnLVvbn40fGrKrbc4DxgywJ9MvkWfX0kZXw/DOtkjzwscet6UN4A1aFuEDNADT0sh4yP+aQO1dZI3T97b3aG0SnBvLGC8pDy/7MJsZsZvrKSvk/ZGiSwqaLbTW8F/Az4cz3ucOtxIZwNO6Cw07eN3JXJageaGF29Zwzr7AQxs/kY2dUwST3Rhp2Rl2Ej3b/fwM/ntRdQdzoSxSzpfjLSsebCVgOWriz3B1Mle/klarQngTYRu0N5yAPBIJOzMpug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(26005)(76116006)(66574015)(55016002)(8676002)(4326008)(6506007)(7696005)(71200400001)(122000001)(86362001)(33656002)(38100700002)(66946007)(53546011)(9686003)(30864003)(5660300002)(66556008)(8936002)(478600001)(2906002)(110136005)(52536014)(83380400001)(186003)(316002)(66476007)(66446008)(64756008)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blc1Z1I4Q0VidjVZZXdGNHplVG5HRUFyaVRSYUVNMys2VWF5cU9OekFTODRw?=
 =?utf-8?B?cTB4ZzZ2aitaU0t3RFRwK0JyK3phVVVGQzNxZWM4NlpPNXlzUytsd3lwbVVZ?=
 =?utf-8?B?YWxQeFZZdzAwLzVVa3hrbm1JUGlYSStabTU0bGZuc1VkdHNOTFhzWnJwWWt2?=
 =?utf-8?B?ZDF4cTJnVUdYdk1samp3UjZLamFSdXREOW1SRVR1SXR4cld3NjQ5THJVUVF5?=
 =?utf-8?B?Mjh6TVRrU3ZGRlA1b2M0cjRqM2RIRFNtZ2U4dm5UVTZpQ2hOU1RkaFVpN2J6?=
 =?utf-8?B?MUhGVjRlSVJGM2dGYUtiN2hOTjVyaVhhaVY1V1EvUjNOd255b3lHTzdRT3FR?=
 =?utf-8?B?NTVoTlBHSERjTTZtaUNlZFdldE5TdEpuSHJzUXI2UWgvbzlpNFlhRzJZbTFL?=
 =?utf-8?B?NS8rVDNhaWFIRFhrMHRFVDIwbUdJN01qYUVVQ1JLWGZxOFpQYVdyUk9OTWw2?=
 =?utf-8?B?WG9IRWxtTUI4RzFnRGFCcDBCT25WSmRaRzFNcFp0SUtzOXJjVmlHZjA4aXAx?=
 =?utf-8?B?d2lSZzByRG5TR3JyQ0l4U2U0RjY5bGdWYXh6c2RyS2FickZ0dGVVUFl5bWR1?=
 =?utf-8?B?U0ZOZ1FvNkk2cmE3U0hlZm9kQjZveWdwQWZYSFNRU1lRMjlCNXhFNXU0UW1G?=
 =?utf-8?B?OWQrNmUzWkxzSkJPUXRLdm0zb0lSM2FnU2lBMk5FdjhyOTQ1eGNlWTZaaGZq?=
 =?utf-8?B?bkt2MkhTaC9EV1pyWWpxM29GdTJHczlydm1HUmpIZ2d2WFBDT0NzdkRQL0xC?=
 =?utf-8?B?RXhsaHFYeHVsWmRYK2tDRWFVNEplUVVrTmtsYUR3alBkM2NVdS9uRlg2cXZx?=
 =?utf-8?B?eDh4MGJkeGJ3NTcrNE9jVkpDNXcxM1BUSmJXY0dVVFZrK3h1aVJsRktONTFs?=
 =?utf-8?B?b3F3dmo2RStyOGR1RDF6VTQxMDRSNDFhWW5EbEI2Qzg1RW50NnVJMjNoOURw?=
 =?utf-8?B?c1phNE5NcC94V2RqYlRxT29qeElSVmNBZTlzd2ViNXMwWHcvQ2dIeUhXWkx0?=
 =?utf-8?B?WXdpOEpOY2tvRVVad2svMmJuTWtSZ3dGK2VtMnJiNzNYeVk4UnBQcW5oK25v?=
 =?utf-8?B?Q25IaG81cElhdUdlSmFwWEROM2wreTlaWFNOcjd2cVFicERlM3B5R1lsYW15?=
 =?utf-8?B?ZGJCRUphRFZVM3VUaEhGMmxubU5PWmw5RGk5a2RpOU5vSG5hOURKaDRkOGlk?=
 =?utf-8?B?b0VQQld2eEYxUjEvYTBVbm9iU0QrZzFQVVVqT05pbjk5TEdXaDFtQnYvcjNu?=
 =?utf-8?B?ZFdjeXlqS3Z2cUQ0NmhmOHArVG1JVUhadWlGbXBUOEs1dXI3Wko1MmRRME1X?=
 =?utf-8?B?dFFzL0M1M2xEMlFPNnQ4SWt3SXRkei9ZUUtoTElzZ0tubnRoL3Zjd0ZId2dC?=
 =?utf-8?B?SFVyeUtiUjcrR2piS1VYNC9JZUpnMFRlRUEwWU53ODlHQWgvdnBjbHBWOVE2?=
 =?utf-8?B?ODlFK2xpblhQNnBsZnNRYWFmWjVEdEdPQ2NwYkR4bXJlWnBCOFVmRUVjY3Y5?=
 =?utf-8?B?SFUvWU9XN3RWT1hodzN4NWZsZnR0T3ZlcG04MWhNT0xmZktpT2JFQzVCY21i?=
 =?utf-8?B?TVVjWVprV0U0K000N1N6WjYrZ1owUmtXdnNUK1owTkJxTzRKT3c3UkRLSGM4?=
 =?utf-8?B?VGRKYnVHWUNzVWVpZktGZEptYjhOVE5JalRmWGE1Qm1pZDdKOXZDai8xUndU?=
 =?utf-8?B?aDRDT0tLN3doSDAwSTNLUGNXMVFFRk9KaS9XbHA4a0JmV0tVcEYzaldLd0xL?=
 =?utf-8?Q?1AeiAEcpcbabUfhq+gh+aeHm47HFOdldl+wuT/R?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1e7217-a25e-454f-467d-08d94da5c5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 06:47:43.2064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8rBojuNDYZiHDdT0/VMzoysQky/M6lEhZcgACvnu7cSNEjmA2t6Zu3uU4jc5TrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
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
> Sent: Thursday, July 22, 2021 5:03 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
> properly for NV1x
> 
> 
> 
> On 7/22/2021 2:03 PM, Quan, Evan wrote:
> > [AMD Official Use Only]
> >
> >
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Thursday, July 22, 2021 4:10 PM
> >> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD
> >> settings properly for NV1x
> >>
> >>
> >>
> >> On 7/22/2021 8:50 AM, Evan Quan wrote:
> >>> The customized OD settings can be divided into two parts: those
> >>> committed ones and non-committed ones.
> >>>     - For those changes which had been fed to SMU before S3/S4/Runpm
> >>>       suspend kicked, they are committed changes. They should be
> properly
> >>>       restored and fed to SMU on S3/S4/Runpm resume.
> >>>     - For those non-committed changes, they are restored only
> >>> without
> >> feeding
> >>>       to SMU.
> >>>
> >>> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> >>> Signed-off-by: Evan Quan <evan.quan@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
> >>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
> >>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52
> >> ++++++++++++++-----
> >>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
> >>>    4 files changed, 69 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> >>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> >>> index 3e89852e4820..8ba53f16d2d9 100644
> >>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> >>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> >>> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
> >>>    	uint32_t power_limit;
> >>>    	uint32_t fan_speed_percent;
> >>>    	uint32_t flags;
> >>> +	uint32_t committed_od;
> >>>
> >>>    	/* user clock state information */
> >>>    	uint32_t clk_mask[SMU_CLK_COUNT]; @@ -352,6 +353,7 @@ struct
> >>> smu_table_context
> >>>
> >>>    	void				*overdrive_table;
> >>>    	void                            *boot_overdrive_table;
> >>> +	void				*committed_overdrive_table;
> >>
> >> May be rename it to user_overdrive_table - OD table with user settings?
> > [Quan, Evan] Actually "overdrive_table " is  the user_overdrive_table. It
> contains all the modification including those not committed( the commit is
> performed by echo "c" > /sys/class/drm/card1/device/pp_od_clk_voltage).
> > The new member added refers to those user customized but committed
> only settings. That's why it was named as " committed_overdrive_table".
> Any good suggestion for the naming?
> 
> As far as I understand, the problem is overdrive_table can have intemediary
> settings as the edit/commit is a two-step process. At any point we can have
> user_od_table keep the latest user mode settings. That is true when user
> restores to default settings also; that time we can just copy the boot settings
> back to user_od table and keep the flag as false indicating that there is no
> custom settings.
[Quan, Evan] For now, on Navi1x the "restores to default settings" is also a two-step process. That will make "copy the boot settings
back to user_od table and keep the flag as false" tricky. However, it seems that does not fit original design. As per original design,
the "restores to default settings" should be a one-step process. Let me correct them with new patch series and proceed further discussion then.

BR
Evan
> 
> >>
> >>>    	uint32_t			gpu_metrics_table_size;
> >>>    	void				*gpu_metrics_table;
> >>> @@ -623,6 +625,12 @@ struct pptable_funcs {
> >>>    				 enum PP_OD_DPM_TABLE_COMMAND
> >> type,
> >>>    				 long *input, uint32_t size);
> >>>
> >>> +	/**
> >>> +	 * @restore_committed_od_settings: Restore the customized and
> >> committed
> >>> +	 *                                 OD settings on S3/S4/Runpm resume.
> >>> +	 */
> >>> +	int (*restore_committed_od_settings)(struct smu_context *smu);
> >>> +
> >>>    	/**
> >>>    	 * @get_clock_by_type_with_latency: Get the speed and latency of
> >> a clock
> >>>    	 *                                  domain.
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> index ebe672142808..5f7d98e99f76 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >>> @@ -416,6 +416,15 @@ static void
> smu_restore_dpm_user_profile(struct
> >> smu_context *smu)
> >>>    		}
> >>>    	}
> >>>
> >>> +	/* Restore customized and committed OD settings */
> >>> +	if (smu->user_dpm_profile.committed_od) {
> >>> +		if (smu->ppt_funcs->restore_committed_od_settings) {
> >>> +			ret = smu->ppt_funcs-
> >>> restore_committed_od_settings(smu);
> >>> +			if (ret)
> >>> +				dev_err(smu->adev->dev, "Failed to upload
> >> customized OD settings\n");
> >>> +		}
> >>> +	}
> >>> +
> >>
> >> Just thinking if there is a need to handle it ASIC specific. The
> >> flags and table pointer are maintained in common structure. So can't
> >> we do the restore of user OD settings directly in this common flow
> >> instead of having each ASIC to implement the callback?
> > [Quan, Evan] The OD settings restoring is ASIC specific as it performed on
> OD table and that(OD table) is ASIC specific.
> 
> I was thinking in terms of final logic that is being done. The below structures
> are available in common table context and we have a common logic to
> update the table. If there is no custom OD settings available, we could handle
> it with the flag.
> 
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	void *od_table = table_context->committed_overdrive_table;
> +	int ret = 0;
> +
> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void *)od_table, true);
> 
> >>
> >>>    	/* Disable restore flag */
> >>>    	smu->user_dpm_profile.flags &=
> >> ~SMU_DPM_USER_PROFILE_RESTORE;
> >>>    }
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >>> index 59ea59acfb00..4752299d7f91 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >>> @@ -2296,39 +2296,45 @@ static int
> >> navi10_set_default_od_settings(struct smu_context *smu)
> >>>    		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> >>>    	int ret = 0;
> >>>
> >>> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> >> (void *)od_table, false);
> >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> >> (void
> >>> +*)boot_od_table, false);
> >>>    	if (ret) {
> >>>    		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
> >>>    		return ret;
> >>>    	}
> >>>
> >>> -	if (!od_table->GfxclkVolt1) {
> >>> +	if (!boot_od_table->GfxclkVolt1) {
> >>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> >>> -								&od_table-
> >>> GfxclkVolt1,
> >>> -								od_table-
> >>> GfxclkFreq1);
> >>> +
> >> 	&boot_od_table->GfxclkVolt1,
> >>> +
> >> 	boot_od_table->GfxclkFreq1);
> >>>    		if (ret)
> >>>    			return ret;
> >>>    	}
> >>>
> >>> -	if (!od_table->GfxclkVolt2) {
> >>> +	if (!boot_od_table->GfxclkVolt2) {
> >>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> >>> -								&od_table-
> >>> GfxclkVolt2,
> >>> -								od_table-
> >>> GfxclkFreq2);
> >>> +
> >> 	&boot_od_table->GfxclkVolt2,
> >>> +
> >> 	boot_od_table->GfxclkFreq2);
> >>>    		if (ret)
> >>>    			return ret;
> >>>    	}
> >>>
> >>> -	if (!od_table->GfxclkVolt3) {
> >>> +	if (!boot_od_table->GfxclkVolt3) {
> >>>    		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> >>> -								&od_table-
> >>> GfxclkVolt3,
> >>> -								od_table-
> >>> GfxclkFreq3);
> >>> +
> >> 	&boot_od_table->GfxclkVolt3,
> >>> +
> >> 	boot_od_table->GfxclkFreq3);
> >>>    		if (ret)
> >>>    			return ret;
> >>>    	}
> >>>
> >>> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> >>> +	navi10_dump_od_table(smu, boot_od_table);
> >>>
> >>> -	navi10_dump_od_table(smu, od_table);
> >>> +	/*
> >>> +	 * For S3/S4/Runpm, no need to install boot od table to
> >> overdrive_table as
> >>> +	 *   - either they already share the same OD settings on bootup
> >>> +	 *   - or they have user customized OD settings
> >>> +	 */
> >>> +	if (!smu->adev->in_suspend)
> >>> +		memcpy(od_table, boot_od_table,
> >> sizeof(OverDriveTable_t));
> >>>
> >>>    	return 0;
> >>>    }
> >>> @@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct
> >> smu_context *smu, enum PP_OD_DPM_TABL
> >>>    			dev_err(smu->adev->dev, "Failed to import
> >> overdrive table!\n");
> >>>    			return ret;
> >>>    		}
> >>> +		if (memcmp(table_context->overdrive_table, table_context-
> >>> boot_overdrive_table,
> >>> +			sizeof(OverDriveTable_t))) {
> >>
> >> Shouldn't this be - compare against the edited settings and last
> >> committed settings, overdrive_table vs committed_overdrive_table?
> >>
> >> Basically, user_od_table can be initialized with boot_od settings and
> >> the flag gives the indication that user_od table is being used or not.
> >> Before updating, check if the edited table (overdrive_table) and the
> >> current user_od table are different, then commit the new table.
> > [Quan, Evan] Yes, I also considered that. But that cannot handle the case
> below:
> > 1 user made some customizations  -> 2 the customizations were
> > committed -> 3 user restored to default(boot) OD settings(by "echo 'r'")
> and committed Although there were some changes between 2 and 3, there
> is actually no real customized changes compared to default(boot) OD settings.
> 
> On restore to default, just copy the boot_table settings to user_od and keep
> the flag as false. We are using user_od as the latest user preferred settings
> and overdrive_table is only used for intermediate updates.
> 
> The flag decides whether to restore or not, but at any point we can refer the
> user_od table to look upon the latest preferred user settings (default or
> custom).
> 
> Thanks,
> Lijo
> 
> >>
> >>> +			smu->user_dpm_profile.committed_od = true;
> >>> +			memcpy(table_context-
> >>> committed_overdrive_table, table_context->overdrive_table,
> >>> +					sizeof(OverDriveTable_t));
> >>> +		} else {
> >>> +			smu->user_dpm_profile.committed_od = false;
> >>> +		}
> >>>    		break;
> >>>    	case PP_OD_EDIT_VDDC_CURVE:
> >>>    		if (!navi10_od_feature_is_supported(od_settings,
> >>> SMU_11_0_ODCAP_GFXCLK_CURVE)) { @@ -2499,6 +2513,19 @@ static
> int
> >> navi10_od_edit_dpm_table(struct smu_context *smu, enum
> PP_OD_DPM_TABL
> >>>    	return ret;
> >>>    }
> >>>
> >>> +static int navi10_restore_committed_od_settings(struct smu_context
> >>> +*smu) {
> >>> +	struct smu_table_context *table_context = &smu->smu_table;
> >>> +	void *od_table = table_context->committed_overdrive_table;
> >>> +	int ret = 0;
> >>> +
> >>> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> >> (void *)od_table, true);
> >>> +	if (ret)
> >>> +		dev_err(smu->adev->dev, "Failed to import overdrive
> >> table!\n");
> >>> +
> >>> +	return ret;
> >>> +}
> >>
> >> As mentioned before, not sure if this is needed as callback. Even if,
> >> this can be something common for smuv11, there is nothing ASIC
> >> specific in this logic, right?
> > [Quan, Evan] Yes, in patch2 of the series, it was made as a SMUV11
> common API.
> >
> > BR
> > Evan
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>    static int navi10_run_btc(struct smu_context *smu)
> >>>    {
> >>>    	int ret = 0;
> >>> @@ -3262,6 +3289,7 @@ static const struct pptable_funcs
> >> navi10_ppt_funcs = {
> >>>    	.set_soft_freq_limited_range =
> >> smu_v11_0_set_soft_freq_limited_range,
> >>>    	.set_default_od_settings = navi10_set_default_od_settings,
> >>>    	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> >>> +	.restore_committed_od_settings =
> >>> +navi10_restore_committed_od_settings,
> >>>    	.run_btc = navi10_run_btc,
> >>>    	.set_power_source = smu_v11_0_set_power_source,
> >>>    	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask, diff --git
> >>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >>> index 0a5d46ac9ccd..28fc3f17c1b1 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> >>> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
> >> smu_context *smu)
> >>>    			ret = -ENOMEM;
> >>>    			goto err3_out;
> >>>    		}
> >>> +
> >>> +		smu_table->committed_overdrive_table =
> >>> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
> >> GFP_KERNEL);
> >>> +		if (!smu_table->committed_overdrive_table) {
> >>> +			ret = -ENOMEM;
> >>> +			goto err4_out;
> >>> +		}
> >>> +
> >>>    	}
> >>>
> >>>    	return 0;
> >>>
> >>> +err4_out:
> >>> +	kfree(smu_table->boot_overdrive_table);
> >>>    err3_out:
> >>>    	kfree(smu_table->overdrive_table);
> >>>    err2_out:
> >>> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct
> >> smu_context *smu)
> >>>    	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> >>>
> >>>    	kfree(smu_table->gpu_metrics_table);
> >>> +	kfree(smu_table->committed_overdrive_table);
> >>>    	kfree(smu_table->boot_overdrive_table);
> >>>    	kfree(smu_table->overdrive_table);
> >>>    	kfree(smu_table->max_sustainable_clocks);
> >>>    	kfree(smu_table->driver_pptable);
> >>>    	kfree(smu_table->clocks_table);
> >>>    	smu_table->gpu_metrics_table = NULL;
> >>> +	smu_table->committed_overdrive_table = NULL;
> >>>    	smu_table->boot_overdrive_table = NULL;
> >>>    	smu_table->overdrive_table = NULL;
> >>>    	smu_table->max_sustainable_clocks = NULL;
> >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
