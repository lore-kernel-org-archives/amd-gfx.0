Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36CBC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 07:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8939F60E0C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 07:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8939F60E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443626E7EF;
	Mon, 26 Jul 2021 07:30:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05AB16E7EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 07:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEjFYtX7D93HBZho9wj6Qjbxj7vr7/NKZKSySdWUbeJCniVh9VO2o8D6vKrWspgrn/UM8qjVq84uj50q7RPlb2T5BCsIvH+gPlZHwB/WhQsq6ca5O8jRbuyKHVs74x6PYoNU7HY36uPvZ78YEShMpfaU4cqLkGMXcNCLgHLixIYRUAZDkpNgccHqBVKDAWN6RQ0d4ZnfBFDzUjKlR0R4YKCg2O+KgNf015P/azSjjM0uEfRM0wEqYi54Q2yj60/U5Q+1XS69WNPPoMlcJ0AevYdUk7qPnwvP0h4ylB5EMA9k963VC3k6lwlWZ5SMicly+kJptzvLe6b4EXf8jteCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMqVMp/RGpDsRpV2socJtVSBH9BURUmueYd7LPiDOoY=;
 b=FXiP36LOywkTqUl998LlHuVecT5vsj/o1MSTn2JmMZbWvSHqy3a0IAAHyNFqJmy71NgnK5/xjUGCbuLCSznWb2zo92OQqYr+csa0ev7XEACY2qXEgJJc96p5qAkkVLPvbxttRMR604NIRLeDe1ohqRcaVQq8ENCB3JV6hUrBc1j7Vl/8oQDQzflhaZt/Mgcu+ioWL6wIed0I0+ZarBKVQ0g3pEkFkET8G4vXloKSAvAlDV4p8UhOmeqyBM7fFHf3uoUHCEiMkNlyyXkPwMcO9nFV5RLm+IbyN81A2UzPZnGnF1mNGALAUPFdBUT1leikAFvoodOStfBAHU+jg4x0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMqVMp/RGpDsRpV2socJtVSBH9BURUmueYd7LPiDOoY=;
 b=dX/mYnRGNr7veG67wnRJln+YwTfPxjoLHEULnnhZWWB0r+7oZ/+RsCIjJGgN1jUKzr0x6v4YT2ewLXmrEbeZ1BYrlVfjPvwr+tF1I8vHppAaDKTBXvSbukY8GWxillZ5VtylvAR55KmD4FlAXzKJqlsSLHwT2XzM4gLQgam6u9g=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Mon, 26 Jul 2021 07:30:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:30:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXf6KANHQDLK+RWUihc6l8oJsHFKtQVlYAgAA5rICABE4g8A==
Date: Mon, 26 Jul 2021 07:30:36 +0000
Message-ID: <DM6PR12MB2619FC7A7BA4468EEC001BAAE4E89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210723090933.806633-1-evan.quan@amd.com>,
 <1b728523-e245-13f1-b649-ca422d29594a@amd.com>
 <BL1PR12MB51440587093D45E69AFEDF1DF7E59@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51440587093D45E69AFEDF1DF7E59@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-26T07:30:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e798acaf-3615-4c3a-f359-08d9500742c0
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB358013784336CE2C945FC2B7E4E89@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXu2ikn9kLCQiJxh/xBNmNRzLIaZMemREFCS2armyANuwkxYsRJ/gLVO5nChRI5hSCMJN9p8GueMhkR4Lp/W95FjhOA0NI0Z6oPA0XN1BsXsjXBDxuJlvFLrdELfHEKJXQcy9oHs6gknc+W8m7SH5rHPBgdAqF+fcsSMR9WXlsYX2fVMPCE65n8biM6JocPYqkgnC7Hrk9i1eyW+HYf0mhpkL41YKfvpqi/ShiQN5yqTkTg3NDuKENSomby/r1a2ZF+SQBYAeAc9+YBHFXcoTZ1u3FtUAQfAv/0FFqXdyi8tbF3mwGZigWjyWr8/Y7HETkv0/B5gHZzF6gUR7/AruQujgEMfhunwxDqj4gpGXwFclRVto+i8Byor0z4xkzDiNMOUsHhlipCJe8BUDnVCa8cDa4Vjs5Hg76nyNUcgrh7AJgmf9Lm0y45/6cJTiRTb02zdGRv5suEnZzzmgF+5JFBv4eATDZry8A7h6TUWU4sar534OBQQOQpg6h4GDf0j2WxrGUhtDgVBG/EceoaoZvPY71queAPAKA2HdSuId2jy9klb0S7YZb3j1LX//TQSqQrv8WPQMlZ5S/7ez9/gqrKq0AgzkL+9bpoIkN68KAe1Tot7WH8tsin9HqK6SIxHt8prVSIl7Ojbd6ay0S98+gYWjsralHJUxjMbyOnTizrb1h6XpygN/xhFac2MdFreB00Sn8l/MJDAaYVNfdmLuuZwsNTtRvDfOcEX0ihtFfk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(2906002)(316002)(30864003)(52536014)(83380400001)(86362001)(8676002)(33656002)(26005)(8936002)(38100700002)(66574015)(64756008)(122000001)(186003)(7696005)(76116006)(478600001)(66446008)(71200400001)(55016002)(6506007)(66946007)(66556008)(66476007)(9686003)(53546011)(110136005)(5660300002)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?20MmV4EryYVYAX3qT3D7W9HCQ2TrnPVJGjnmvLBqhiLE8tWzf4E76MrERsBh?=
 =?us-ascii?Q?xufV8Cll6Jn7ngFOTjyU9ikfVxd4kJ1DjjIymLrk+nj8BugQvai1my5VP/li?=
 =?us-ascii?Q?GyRI3Mgj86mHDRRyd22LYREiqMYzB7NKxBOW4VMllRiPLbeScAbcjoy/81qx?=
 =?us-ascii?Q?yOkvqgT1ilJGUOsjTu3x4vERnZ3n8XBcKYUgDa7X3upLlkN6EXsCUtfHQ5D6?=
 =?us-ascii?Q?l+z96ja+NfEUmL0nGKLYwDlZyRpb8helAIbWivMPYFw/2Xv9haa4xByu4mQa?=
 =?us-ascii?Q?AfZrNU0ePX1zO4jPS/y4dmXfQ4IQmzY5RRSevvqV6x3a+a4TLbB7gRlrT4j1?=
 =?us-ascii?Q?U4zOoPEru12A9y6y/cCmZqzJVUsBxGymLl/5YLZqHT2E8haf6RRI3sSkjUh2?=
 =?us-ascii?Q?nh2YwYHaPMqVHjDASRbILWZ2DSk6CyzaTqnP+02y7Sx19ADTXdGXgHoKknlv?=
 =?us-ascii?Q?UdlJRfkXnZamA5nPOpRItPDjIQHzijpC3IEtuUEr+5Zm/bQ3u2fNoJmB5Y6H?=
 =?us-ascii?Q?LhNo2BMPP2N6LWlh8/z/zqRn+Gu0DXx29u52s/8fNeqOgWkDf1qNr0qHnfUd?=
 =?us-ascii?Q?Al1I4FnCTMzGKF0nEf3uXWhkIQ2A6ubum/mouz+5FuQYIcCJlIVV7RobhwFF?=
 =?us-ascii?Q?rVxrU7QQH64YA9PQNQprQZLPL1KBekGzw0t4D59p/pUgwJhLF6trZ2EZ2LdL?=
 =?us-ascii?Q?cT7ni0kEjDDGRjtqeBibPz5/kF8eyXvvdc7Xxd4om+uKO9tDztIEqVIJm43D?=
 =?us-ascii?Q?mFtbN7LbEPtxpCiue5S+sf1iFHgEFGGtTBgg2DRNkDxloUKMGOdzDsDfYeAf?=
 =?us-ascii?Q?8LlLseKb3f9Ndg9iuGdMImlnMz8FfriG7KTP5z5bQ4Qs6zKJb13R1UlaOfwP?=
 =?us-ascii?Q?dmJ/WHWPtKXC/FOPt2NITtjJx4Z7LYUCDnE/9NPMu7FI1h4Hb+ATRl8IElON?=
 =?us-ascii?Q?ciEA9rq8ZeBg/GzzlqHp/iWmJyDMFZqSSHYjlFzusEtDGAuERv4uSH3x0JUi?=
 =?us-ascii?Q?yXoNEJeQea1F/R9vcoo9cte2sesp3/MACq20u5dWQerADMopov3uCAVjUzij?=
 =?us-ascii?Q?9k/38cHhtxQPiycaYbdTMLGBNUxfLfOo4epOIFyW//OjSKwDvz8nHjDmO6KO?=
 =?us-ascii?Q?H0sg8xj3TMfziv7uzFmHzwwyO0XvBgAG1Qm+rN2WTYapaMfR1OOVOOgf7SIR?=
 =?us-ascii?Q?ddE4Lqw3cbLOdcq8TRImBZlFb6RYfn1ebQXOu2tRm9lkMIkvPUARYXrdBT6Q?=
 =?us-ascii?Q?0qPdpq3AGLjjXnxMw/iIf0Fw5ikNBw2vUJG66jsGWWy42JBcbfYANCMtDKlK?=
 =?us-ascii?Q?vdg0rBLWmYuKCkQ2Kh6nYhNg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e798acaf-3615-4c3a-f359-08d9500742c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 07:30:36.3471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6LGn+fYQ6stS41dhKXaAJf9g4IRzzx+i+SoEzkndskicYN++etc6hp/ogc9wHic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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
Content-Type: multipart/mixed; boundary="===============0666828421=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0666828421==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2619FC7A7BA4468EEC001BAAE4E89DM6PR12MB2619namp_"

--_000_DM6PR12MB2619FC7A7BA4468EEC001BAAE4E89DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Alex & Lijo,

For now, those code for updating OD table are in smu_cmn.c. And they can on=
ly be called from _ppt.c.
So, unless we split some code from smu_cmn.c and move them to upper layer(s=
uggested by Lijo before), otherwise this cannot be performed.
So, definitely we need some follow up patches if we want this done in a mor=
e generic way.

BR
Evan
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, July 23, 2021 9:36 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-g=
fx@lists.freedesktop.org
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x


[AMD Official Use Only]

I haven't had a chance to look at the patches too closely, but if it could =
be done in a generic may, that makes sense to me.  Maybe as a follow up pat=
ch?

Alex

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, July 23, 2021 6:09 AM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x

The series looks good to me, though I prefer to use a common logic to
restore od settings so that smuv12,smuv13 gets the restore feature by
default once they add the user table logic. Don't have strong argument
for it unless Alex, Kenneth or others have some comments.

Anyway, the series is
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.c=
om>>

On 7/23/2021 2:39 PM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feed=
ing
>      to SMU.
>
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
> --
> v1->v2
>    - better naming and logic revised for checking OD setting update(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55 +++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
>   5 files changed, 82 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_smu.h
> index 3e89852e4820..c2c201b8e3cf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>        uint32_t power_limit;
>        uint32_t fan_speed_percent;
>        uint32_t flags;
> +     uint32_t user_od;
>
>        /* user clock state information */
>        uint32_t clk_mask[SMU_CLK_COUNT];
> @@ -352,6 +353,7 @@ struct smu_table_context
>
>        void                            *overdrive_table;
>        void                            *boot_overdrive_table;
> +     void                            *user_overdrive_table;
>
>        uint32_t                        gpu_metrics_table_size;
>        void                            *gpu_metrics_table;
> @@ -623,6 +625,12 @@ struct pptable_funcs {
>                                 enum PP_OD_DPM_TABLE_COMMAND type,
>                                 long *input, uint32_t size);
>
> +     /**
> +      * @restore_user_od_settings: Restore the user customized
> +      *                            OD settings on S3/S4/Runpm resume.
> +      */
> +     int (*restore_user_od_settings)(struct smu_context *smu);
> +
>        /**
>         * @get_clock_by_type_with_latency: Get the speed and latency of a=
 clock
>         *                                  domain.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v11_0.h
> index 385b2ea5379c..1e42aafbb9fd 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *smu=
);
>
>   int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
>
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..8ca7337ea5fc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_=
context *smu)
>                }
>        }
>
> +     /* Restore user customized OD settings */
> +     if (smu->user_dpm_profile.user_od) {
> +             if (smu->ppt_funcs->restore_user_od_settings) {
> +                     ret =3D smu->ppt_funcs->restore_user_od_settings(sm=
u);
> +                     if (ret)
> +                             dev_err(smu->adev->dev, "Failed to upload c=
ustomized OD settings\n");
> +             }
> +     }
> +
>        /* Disable restore flag */
>        smu->user_dpm_profile.flags &=3D ~SMU_DPM_USER_PROFILE_RESTORE;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d7722c229ddd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(struct =
smu_context *smu)
>                (OverDriveTable_t *)smu->smu_table.overdrive_table;
>        OverDriveTable_t *boot_od_table =3D
>                (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> +     OverDriveTable_t *user_od_table =3D
> +             (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
>        int ret =3D 0;
>
> -     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)o=
d_table, false);
> +     /*
> +      * For S3/S4/Runpm resume, no need to setup those overdrive tables =
again as
> +      *   - either they already have the default OD settings got during =
cold bootup
> +      *   - or they have some user customized OD settings which cannot b=
e overwritten
> +      */
> +     if (smu->adev->in_suspend)
> +             return 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)b=
oot_od_table, false);
>        if (ret) {
>                dev_err(smu->adev->dev, "Failed to get overdrive table!\n"=
);
>                return ret;
>        }
>
> -     if (!od_table->GfxclkVolt1) {
> +     if (!boot_od_table->GfxclkVolt1) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt1,
> -                                                             od_table->G=
fxclkFreq1);
> +                                                             &boot_od_ta=
ble->GfxclkVolt1,
> +                                                             boot_od_tab=
le->GfxclkFreq1);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt2) {
> +     if (!boot_od_table->GfxclkVolt2) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt2,
> -                                                             od_table->G=
fxclkFreq2);
> +                                                             &boot_od_ta=
ble->GfxclkVolt2,
> +                                                             boot_od_tab=
le->GfxclkFreq2);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt3) {
> +     if (!boot_od_table->GfxclkVolt3) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt3,
> -                                                             od_table->G=
fxclkFreq3);
> +                                                             &boot_od_ta=
ble->GfxclkVolt3,
> +                                                             boot_od_tab=
le->GfxclkFreq3);
>                if (ret)
>                        return ret;
>        }
>
> -     memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +     navi10_dump_od_table(smu, boot_od_table);
>
> -     navi10_dump_od_table(smu, od_table);
> +     memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> +     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
>
>        return 0;
>   }
> @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_TABL
>                memcpy(table_context->overdrive_table, table_context->boot=
_overdrive_table, sizeof(OverDriveTable_t));
>                break;
>        case PP_OD_COMMIT_DPM_TABLE:
> -             navi10_dump_od_table(smu, od_table);
> -             ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (=
void *)od_table, true);
> -             if (ret) {
> -                     dev_err(smu->adev->dev, "Failed to import overdrive=
 table!\n");
> -                     return ret;
> +             if (memcmp(od_table, table_context->user_overdrive_table, s=
izeof(OverDriveTable_t))) {
> +                     navi10_dump_od_table(smu, od_table);
> +                     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRI=
VE, 0, (void *)od_table, true);
> +                     if (ret) {
> +                             dev_err(smu->adev->dev, "Failed to import o=
verdrive table!\n");
> +                             return ret;
> +                     }
> +                     memcpy(table_context->user_overdrive_table, od_tabl=
e, sizeof(OverDriveTable_t));
> +                     smu->user_dpm_profile.user_od =3D true;
> +
> +                     if (!memcmp(table_context->user_overdrive_table,
> +                                 table_context->boot_overdrive_table,
> +                                 sizeof(OverDriveTable_t)))
> +                             smu->user_dpm_profile.user_od =3D false;
>                }
>                break;
>        case PP_OD_EDIT_VDDC_CURVE:
> @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
>        .set_soft_freq_limited_range =3D smu_v11_0_set_soft_freq_limited_r=
ange,
>        .set_default_od_settings =3D navi10_set_default_od_settings,
>        .od_edit_dpm_table =3D navi10_od_edit_dpm_table,
> +     .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
>        .run_btc =3D navi10_run_btc,
>        .set_power_source =3D smu_v11_0_set_power_source,
>        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..7aa47dbba8d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *s=
mu)
>                        ret =3D -ENOMEM;
>                        goto err3_out;
>                }
> +
> +             smu_table->user_overdrive_table =3D
> +                     kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNE=
L);
> +             if (!smu_table->user_overdrive_table) {
> +                     ret =3D -ENOMEM;
> +                     goto err4_out;
> +             }
> +
>        }
>
>        return 0;
>
> +err4_out:
> +     kfree(smu_table->boot_overdrive_table);
>   err3_out:
>        kfree(smu_table->overdrive_table);
>   err2_out:
> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *s=
mu)
>        struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>
>        kfree(smu_table->gpu_metrics_table);
> +     kfree(smu_table->user_overdrive_table);
>        kfree(smu_table->boot_overdrive_table);
>        kfree(smu_table->overdrive_table);
>        kfree(smu_table->max_sustainable_clocks);
>        kfree(smu_table->driver_pptable);
>        kfree(smu_table->clocks_table);
>        smu_table->gpu_metrics_table =3D NULL;
> +     smu_table->user_overdrive_table =3D NULL;
>        smu_table->boot_overdrive_table =3D NULL;
>        smu_table->overdrive_table =3D NULL;
>        smu_table->max_sustainable_clocks =3D NULL;
> @@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_contex=
t *smu,
>
>        return ret;
>   }
> +
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
> +{
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     void *user_od_table =3D table_context->user_overdrive_table;
> +     int ret =3D 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)u=
ser_od_table, true);
> +     if (ret)
> +             dev_err(smu->adev->dev, "Failed to import overdrive table!\=
n");
> +
> +     return ret;
> +}
>

--_000_DM6PR12MB2619FC7A7BA4468EEC001BAAE4E89DM6PR12MB2619namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Alex &amp; Lijo,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For now, those code for updating OD table are in smu=
_cmn.c. And they can only be called from _ppt.c.<o:p></o:p></p>
<p class=3D"MsoNormal">So, unless we split some code from smu_cmn.c and mov=
e them to upper layer(suggested by Lijo before), otherwise this cannot be p=
erformed.<o:p></o:p></p>
<p class=3D"MsoNormal">So, definitely we need some follow up patches if we =
want this done in a more generic way.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, July 23, 2021 9:36 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan=
@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD s=
ettings properly for NV1x<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I haven=
't had a chance to look at the patches too closely, but if it could be done=
 in a generic may, that makes sense to me.&nbsp; Maybe as a follow up patch=
?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, July 23, 2021 6:09 AM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD s=
ettings properly for NV1x</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">The series looks good to me, though I prefer to use =
a common logic to
<br>
restore od settings so that smuv12,smuv13 gets the restore feature by <br>
default once they add the user table logic. Don't have strong argument <br>
for it unless Alex, Kenneth or others have some comments.<br>
<br>
Anyway, the series is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Lijo Lazar &lt;<a h=
ref=3D"mailto:lijo.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<br>
<br>
On 7/23/2021 2:39 PM, Evan Quan wrote:<br>
&gt; The customized OD settings can be divided into two parts: those<br>
&gt; committed ones and non-committed ones.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those changes which had been fed to SMU before=
 S3/S4/Runpm<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend kicked, they are committed chang=
es. They should be properly<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restored and fed to SMU on S3/S4/Runpm r=
esume.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those non-committed changes, they are restored=
 only without feeding<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to SMU.<br>
&gt; <br>
&gt; Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440<br>
&gt; Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan=
.quan@amd.com</a>&gt;<br>
&gt; --<br>
&gt; v1-&gt;v2<br>
&gt;&nbsp;&nbsp;&nbsp; - better naming and logic revised for checking OD se=
tting update(Lijo)<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 +++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 9 +++<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | =
55 +++++++++++++------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbs=
p; | 25 +++++++++<br>
&gt;&nbsp;&nbsp; 5 files changed, 82 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm=
/amd/pm/inc/amdgpu_smu.h<br>
&gt; index 3e89852e4820..c2c201b8e3cf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_limit;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fan_speed_percent;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t user_od;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user clock state informat=
ion */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_mask[SMU_CLK_CO=
UNT];<br>
&gt; @@ -352,6 +353,7 @@ struct smu_table_context<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *overdrive_=
table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *boot_overd=
rive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *user_overdrive_table;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics_table_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_metric=
s_table;<br>
&gt; @@ -623,6 +625,12 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND=
 type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input, uint32_t size);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @restore_user_od_settings: Restore t=
he user customized<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD settings on S3/S4/Run=
pm resume.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*restore_user_od_settings)(struct smu_c=
ontext *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_clock_by_type_w=
ith_latency: Get the speed and latency of a clock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; domain.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/=
amd/pm/inc/smu_v11_0.h<br>
&gt; index 385b2ea5379c..1e42aafbb9fd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *=
smu);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int smu_v11_0_set_light_sbr(struct smu_context *smu, bool =
enable);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index ebe672142808..8ca7337ea5fc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct s=
mu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Restore user customized OD settings */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;user_dpm_profile.user_od) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (smu-&gt;ppt_funcs-&gt;restore_user_od_settings) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_fun=
cs-&gt;restore_user_od_settings(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to uplo=
ad customized OD settings\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable restore flag */<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.fla=
gs &amp;=3D ~SMU_DPM_USER_PROFILE_RESTORE;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 59ea59acfb00..d7722c229ddd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(stru=
ct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.overdrive_table;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *boot_od_ta=
ble =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.boot_overdrive_ta=
ble;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *user_od_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (OverDriveTable_t *)smu-&gt;smu_table.user_overdrive_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)od_table, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For S3/S4/Runpm resume, no need to s=
etup those overdrive tables again as<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - either they already ha=
ve the default OD settings got during cold bootup<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - or they have some user=
 customized OD settings which cannot be overwritten<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;in_suspend)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)boot_od_table, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to get overd=
rive table!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt2) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt3) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt3) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq3);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(boot_od_table, od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, boot_od_table);<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(od_table, boot_od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(user_od_table, boot_od_table, sizeof(=
OverDriveTable_t));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu=
_context *smu, enum PP_OD_DPM_TABL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(table_context-&gt;overdrive_table, table_context=
-&gt;boot_overdrive_table, sizeof(OverDriveTable_t));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_COMMIT_DPM_TABLE:=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; navi10_dump_od_table(smu, od_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_ta=
ble, true);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Failed to import overdrive table!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (memcmp(od_table, table_context-&gt;user_overdrive_table, sizeof(Ove=
rDriveTable_t))) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(sm=
u, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_=
table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to impo=
rt overdrive table!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_context-&g=
t;user_overdrive_table, od_table, sizeof(OverDriveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profil=
e.user_od =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!memcmp(table_conte=
xt-&gt;user_overdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;boot_ove=
rdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(OverDriveTable_t)))=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.user_od =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_EDIT_VDDC_CURVE:<=
br>
&gt; @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_fun=
cs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_soft_freq_limited_range=
 =3D smu_v11_0_set_soft_freq_limited_range,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_od_settings =3D=
 navi10_set_default_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .od_edit_dpm_table =3D navi1=
0_od_edit_dpm_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .restore_user_od_settings =3D smu_v11_0_rest=
ore_user_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D navi10_run_btc,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_source =3D smu_v1=
1_0_set_power_source,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu=
_cmn_get_pp_feature_mask,<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; index 0a5d46ac9ccd..7aa47dbba8d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r3_out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu_table-&gt;user_overdrive_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(tables[SMU_TABL=
E_OVERDRIVE].size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu_table-&gt;user_overdrive_table) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err4_out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +err4_out:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp; err3_out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp; err2_out:<br>
&gt; @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_=
dpm =3D &amp;smu-&gt;smu_dpm;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;gpu_metr=
ics_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;user_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_ove=
rdrive_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;max_sust=
ainable_clocks);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;driver_p=
ptable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;clocks_t=
able);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_ta=
ble =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;user_overdrive_table =3D NULL;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;boot_overdrive=
_table =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;overdrive_tabl=
e =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;max_sustainabl=
e_clocks =3D NULL;<br>
&gt; @@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_con=
text *smu,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D =
&amp;smu-&gt;smu_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *user_od_table =3D table_context-&gt;us=
er_overdrive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)user_od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to import overdrive table!\n=
&quot;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; <o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619FC7A7BA4468EEC001BAAE4E89DM6PR12MB2619namp_--

--===============0666828421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0666828421==--
