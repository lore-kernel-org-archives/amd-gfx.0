Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B0C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 07:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B2B60F51
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 07:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8B2B60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A4C6E7D7;
	Mon, 26 Jul 2021 07:20:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE986E7D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 07:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjdzojB5AocaAz1xJNAjM1k0D7sgiVW/jU5t11PfhN0euA7/lXNXmAI3x9MRb3psAiLlFZQobtbPW/Glw2c1Na1US5c3let1UumVCWtdOPsxh95HLnbYo69Rd28atDTGmX/v3O1hOup9kQDhHBC0xr0TGuerwpjRlQAHU95PUP3dqn7bs/HNTFs/gezJeOo9AJVjKMk8K5fhngVOKm0Dxu6CWa86oTGxkIi7xJ/9Rtpo9zGey29mLm3D0599V6UuTvzStXPCifJBElzt/Hk5YKjsmjwGKtivzl0ok9grG+GSXGL6ywbeM8F2icpjLix5s3OkekEsGnjgLZmIdgj4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5weDR8FvpJxHibTSgJXkydDF4dESEqT+rPTDTmu6ywA=;
 b=KaOVWyRz6Wr+7gPRCs+uH2BaF7WhX4iwp0pmptref3/VMMgS//ugEI6h20PFxNE/ksfKOHNSPyJ9W+l1m0YnbJ39amj0/Q7ET1itqsSaJQDfntud7fifpMKP3Bxx2dihGevK334QoKCihfhxpoxw+J1z93k0caoi48O4fdkGQs+PnRXUxngVcnWWemKYCYfjtnh9RjK25eedgtMkdKeNq92rMjmpUmqNrquOVqd1s6oUbWiFqpSqMZLsJADHgGPyvJa3g5zc5tEnTawSxm1jvimNwYDe/rRLG04A2Tp2RfobHF62ut4SOAo4lIs8y1tVSekls7uUFC+0WTgVPfUdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5weDR8FvpJxHibTSgJXkydDF4dESEqT+rPTDTmu6ywA=;
 b=J335xZ9ZI9S252UNY0uKreWc9ff9O5oR044bP4DrFkn2M6MNWwHFai9/DjjwgMwFmvhjvAzgr5V9l/Xo1saHsnntyHR6gKNcT/ERL0t87xULJu6p98W6rLuTL1HfyFuRSY+MJ6M+cyhvsX4unfGsrKjyeRs4lVXkcDYVs6gmSaM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Mon, 26 Jul 2021 07:20:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:20:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXf6KANHQDLK+RWUihc6l8oJsHFKtQVlYAgAA8PwCABEHSUA==
Date: Mon, 26 Jul 2021 07:20:00 +0000
Message-ID: <DM6PR12MB2619215A91AEA55DF4A4DAF3E4E89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210723090933.806633-1-evan.quan@amd.com>
 <1b728523-e245-13f1-b649-ca422d29594a@amd.com>
 <DM5PR12MB2469EEAE60BBC25160F35F89F1E59@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469EEAE60BBC25160F35F89F1E59@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-26T07:19:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=02dc6d91-93a1-4131-bcb5-824011d8eba2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c1c5ca6-572d-4851-40b7-08d95005c7ba
x-ms-traffictypediagnostic: DM5PR12MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB46791B67E487B424797864F5E4E89@DM5PR12MB4679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeqAmCZIsJ8YTJaW7DIBKQ1HAO46O6CcG/VYHNFJDIKqLGAUSaQkrmE4xhODCsqSLj7YPGGQlpPNtLDaXpof75y5bc821EnbUsV4n8O611m+Tr3jIsbZYe0X6MlcIidZckrxtB3AFqImGs6nQOMDB4JSrNiMWlL/atPVMGYPl0gRLOFC140pbSOB9BgZ6eSgldMjKdwphXks+TGRhlJwHOmJOq/K1lbth/2USkhU6qrvlGL6XNEVfjMdy69+SzNONyTjCyDvucIgE40LaOerXdld46OnCcJ0ldt2NF6/cBqY7ztyyrRZxlEqng4VVVUnOEUK6p8Lvq2FHttNQrT1NRQ3yx9Rx0qV+Y2hi3+ZnUmopQP05leMWgKWQknF5bzLn+5GPHNu3hx2e7Su17086CgCeq8L0JMrivacvzTDZGtVHvl0iQoK/A8eZG0ZSIwwKknQ7hRZxx3Kmrj+ySLdMeWSIgmUQsmV37jKCwu4yToLIbbLOG/9eMSjqBp1CY02ekAI8YEPu8Hqt6MyjE1S1znixvWS7lSEO8fbl3g5+CUmlfMoat+4218JbORvXjRqV4GvWbbKbh8IstlYg4PUQk4eYn8C7Ea4/VAPy6zvVkw23vGsdpDyeDO0b7zcQJMlqTsCUsmhzsqHmb0Tt+kIhLL52nOYBtagsfrVCDDsfEEn4tWubj046Lz/nJCGMdKGWOBjTO616Hmx9QVeZ6SSiF5IFI3lf4dAQC9PX8eJ3o5inGHSuGLNVaplDZVmuwIVbpxSfuREiQx2WGIzK05hM+rKFhxXzgSTiIJv70vrMiwqdp1EpBhgDamh0rFDUII+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(2906002)(316002)(30864003)(52536014)(83380400001)(86362001)(8676002)(4326008)(966005)(33656002)(26005)(8936002)(38100700002)(66574015)(64756008)(122000001)(186003)(7696005)(76116006)(478600001)(66446008)(71200400001)(55016002)(6506007)(66946007)(66556008)(66476007)(45080400002)(9686003)(53546011)(110136005)(5660300002)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GgoDOlOVdwYGe9yJYVDi15L9MU/5hrcj3XoA+3psXkBYQ5cTY3lLrY/EzZSY?=
 =?us-ascii?Q?3/wyNQe53HvD/srw59kLIdIieUr7vA9gmiPoMmPrpxTEzEqZNsOnGOc2G+RW?=
 =?us-ascii?Q?G2xWgBTcYfZqIEbvmybvt8vCD3RqoFfZdHVCeGN+uIQbw4ftmFoixyuk2BZZ?=
 =?us-ascii?Q?qTHun26JKlNcdkEi7FXxXpciQZ4xU12TGz6vc/tKYWzsoORwvIi/+8N3GBbC?=
 =?us-ascii?Q?jCFbDPnC6ZQ79jNCpP3I7CsVXULj8uIqFsk6eNef+94uTAQ43ddbEwoE9AkN?=
 =?us-ascii?Q?JQ8eJ3kyEz20V8KnOkThOrnkatplpedxkFytPtB6LPJINRqizXmQLU4s3m/v?=
 =?us-ascii?Q?FagYHgAW/1N0EE/i6g/GkPuSaK1z6F20jAcq++u14+qJhaaK2uRvkxM5fJ2r?=
 =?us-ascii?Q?I4tWmY0pyhSt6JGwwjqWswTbP5rUh1UwqMSILLxZYwKeilG+W1iUsvpDQxKN?=
 =?us-ascii?Q?7AxUt21+C4S6QXBwH1jZf4fctPiWZ7YiIXAxi/fMhnzvpckch53bByTJaTwO?=
 =?us-ascii?Q?uckyDhTMYWTqiJePhxZZrVsdhdqRCmX2A1LNHvIpeAOjLJARSa4uQwm9gLJB?=
 =?us-ascii?Q?zGZd/Q3/LogKYWivR83WXb2h3Ox/PYSOO15mzomXc0TEmxAeojHjyOjXGX6S?=
 =?us-ascii?Q?vHlQ4xGcgHT2X3c9YNB7v21VUPma3HSHvBAWi3q2KX8qMDL04fihSLQch7v4?=
 =?us-ascii?Q?zOaGgqVIhkggaf+B8JhA/g+9mLYG3ielMXHTB8c67yvkUlKvF1yOhNWJEIK8?=
 =?us-ascii?Q?9pg1yzpHkzvo+N1+yNY80prmDQRU9q/TRUdmzm5xGs7GGJZ3Lym0OdHBsjLF?=
 =?us-ascii?Q?GQcsSA2GmM9W7fUb3DZL6IVQG3LHNrLyUbBN9rrfUm8xAt9rskeI4BlCukET?=
 =?us-ascii?Q?u7GtP5SWUwQIYaobTewOmyKer102EpnUEjZJd0E7rvMlr4FqETBiyxjH5QKF?=
 =?us-ascii?Q?4c+H9ZYOWsibJ2ZVawRiK1PSlHN7c/JCOCaVzlw8g+i3PR79It7ah2S5RGdv?=
 =?us-ascii?Q?hBtd2SbXu0+GOmOfPlWVKu3+m+Sc98Eq+XZigDHWpVN2Puhjd5lSZ6NjTdmL?=
 =?us-ascii?Q?Ylk0PNgb/5zIectIOYwuCTlsVG1Dszh53um9EBcN1eDw04TX+/+kJ09SmvQv?=
 =?us-ascii?Q?1Q7bb447d5Rp3IBm0nmteTmEC88r7qnq3iXZkgyVddePK5ZNIA7lqQomkOt7?=
 =?us-ascii?Q?1YFNWfTMGDJhcyOlFz1gjLXf+vAPzVpV8agPmOOtsg8d3AymR++6kzDKBw8d?=
 =?us-ascii?Q?7PXry50JXOyX59zK+B0GdMiIoYT345q+hv4vjpt/9f10vDPx2toJimOLEU2C?=
 =?us-ascii?Q?NhSt/slfzbiTE7buxxx9nsDx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c5ca6-572d-4851-40b7-08d95005c7ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 07:20:00.3957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd/NyxYUyqK/0aPWSo4jw8e/lC43vIVL2LhvzCOU3l/y+JU0wunRheo33773IDay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
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

[Public]

Hi Guchun,

Currently, the smu->user_dpm_profile.flags seems only used to flag whether we are in a process restoring the user customized settings(power limit/fan settings/od settings etc). We could either drop it or expand its usage. Let me consider more and make a follow-up patch for this.

BR
Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, July 23, 2021 9:45 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH V2 1/2] drm/amd/pm: restore user customized OD
> settings properly for NV1x
> 
> [Public]
> 
> Just curious that in the patch, it adds a variable *user_od* serving the check
> of applying user customized OD setting. Instead of this, does it make sense
> to use the *flag* in struct smu_user_dpm_profile for this? As we have below
> bit in pm/inc/amdgpu_smu.h, can we add another bit for OD restore? This
> will help unify the usage of *flag* in SMU.
> 
> #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Lazar, Lijo
> Sent: Friday, July 23, 2021 6:09 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD
> settings properly for NV1x
> 
> The series looks good to me, though I prefer to use a common logic to
> restore od settings so that smuv12,smuv13 gets the restore feature by
> default once they add the user table logic. Don't have strong argument for it
> unless Alex, Kenneth or others have some comments.
> 
> Anyway, the series is
> 	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> On 7/23/2021 2:39 PM, Evan Quan wrote:
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
> > --
> > v1->v2
> >    - better naming and logic revised for checking OD setting
> > update(Lijo)
> > ---
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
> >   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55
> +++++++++++++------
> >   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
> >   5 files changed, 82 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index 3e89852e4820..c2c201b8e3cf 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
> >   	uint32_t power_limit;
> >   	uint32_t fan_speed_percent;
> >   	uint32_t flags;
> > +	uint32_t user_od;
> >
> >   	/* user clock state information */
> >   	uint32_t clk_mask[SMU_CLK_COUNT];
> > @@ -352,6 +353,7 @@ struct smu_table_context
> >
> >   	void				*overdrive_table;
> >   	void                            *boot_overdrive_table;
> > +	void				*user_overdrive_table;
> >
> >   	uint32_t			gpu_metrics_table_size;
> >   	void				*gpu_metrics_table;
> > @@ -623,6 +625,12 @@ struct pptable_funcs {
> >   				 enum PP_OD_DPM_TABLE_COMMAND
> type,
> >   				 long *input, uint32_t size);
> >
> > +	/**
> > +	 * @restore_user_od_settings: Restore the user customized
> > +	 *                            OD settings on S3/S4/Runpm resume.
> > +	 */
> > +	int (*restore_user_od_settings)(struct smu_context *smu);
> > +
> >   	/**
> >   	 * @get_clock_by_type_with_latency: Get the speed and latency of
> a clock
> >   	 *                                  domain.
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > index 385b2ea5379c..1e42aafbb9fd 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> > @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct
> smu_context
> > *smu);
> >
> >   int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
> >
> > +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
> > +
> >   #endif
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index ebe672142808..8ca7337ea5fc 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct
> smu_context *smu)
> >   		}
> >   	}
> >
> > +	/* Restore user customized OD settings */
> > +	if (smu->user_dpm_profile.user_od) {
> > +		if (smu->ppt_funcs->restore_user_od_settings) {
> > +			ret = smu->ppt_funcs-
> >restore_user_od_settings(smu);
> > +			if (ret)
> > +				dev_err(smu->adev->dev, "Failed to upload
> customized OD settings\n");
> > +		}
> > +	}
> > +
> >   	/* Disable restore flag */
> >   	smu->user_dpm_profile.flags &=
> ~SMU_DPM_USER_PROFILE_RESTORE;
> >   }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 59ea59acfb00..d7722c229ddd 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2294,41 +2294,52 @@ static int
> navi10_set_default_od_settings(struct smu_context *smu)
> >   		(OverDriveTable_t *)smu->smu_table.overdrive_table;
> >   	OverDriveTable_t *boot_od_table =
> >   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> > +	OverDriveTable_t *user_od_table =
> > +		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> >   	int ret = 0;
> >
> > -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void *)od_table, false);
> > +	/*
> > +	 * For S3/S4/Runpm resume, no need to setup those overdrive
> tables again as
> > +	 *   - either they already have the default OD settings got during cold
> bootup
> > +	 *   - or they have some user customized OD settings which cannot be
> overwritten
> > +	 */
> > +	if (smu->adev->in_suspend)
> > +		return 0;
> > +
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
> > +	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> > +	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> >
> >   	return 0;
> >   }
> > @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct
> smu_context *smu, enum PP_OD_DPM_TABL
> >   		memcpy(table_context->overdrive_table, table_context-
> >boot_overdrive_table, sizeof(OverDriveTable_t));
> >   		break;
> >   	case PP_OD_COMMIT_DPM_TABLE:
> > -		navi10_dump_od_table(smu, od_table);
> > -		ret = smu_cmn_update_table(smu,
> SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
> > -		if (ret) {
> > -			dev_err(smu->adev->dev, "Failed to import
> overdrive table!\n");
> > -			return ret;
> > +		if (memcmp(od_table, table_context->user_overdrive_table,
> sizeof(OverDriveTable_t))) {
> > +			navi10_dump_od_table(smu, od_table);
> > +			ret = smu_cmn_update_table(smu,
> SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
> > +			if (ret) {
> > +				dev_err(smu->adev->dev, "Failed to import
> overdrive table!\n");
> > +				return ret;
> > +			}
> > +			memcpy(table_context->user_overdrive_table,
> od_table, sizeof(OverDriveTable_t));
> > +			smu->user_dpm_profile.user_od = true;
> > +
> > +			if (!memcmp(table_context->user_overdrive_table,
> > +				    table_context->boot_overdrive_table,
> > +				    sizeof(OverDriveTable_t)))
> > +				smu->user_dpm_profile.user_od = false;
> >   		}
> >   		break;
> >   	case PP_OD_EDIT_VDDC_CURVE:
> > @@ -3262,6 +3282,7 @@ static const struct pptable_funcs
> navi10_ppt_funcs = {
> >   	.set_soft_freq_limited_range =
> smu_v11_0_set_soft_freq_limited_range,
> >   	.set_default_od_settings = navi10_set_default_od_settings,
> >   	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> > +	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
> >   	.run_btc = navi10_run_btc,
> >   	.set_power_source = smu_v11_0_set_power_source,
> >   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask, diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > index 0a5d46ac9ccd..7aa47dbba8d8 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> > @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct
> smu_context *smu)
> >   			ret = -ENOMEM;
> >   			goto err3_out;
> >   		}
> > +
> > +		smu_table->user_overdrive_table =
> > +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size,
> GFP_KERNEL);
> > +		if (!smu_table->user_overdrive_table) {
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
> > +	kfree(smu_table->user_overdrive_table);
> >   	kfree(smu_table->boot_overdrive_table);
> >   	kfree(smu_table->overdrive_table);
> >   	kfree(smu_table->max_sustainable_clocks);
> >   	kfree(smu_table->driver_pptable);
> >   	kfree(smu_table->clocks_table);
> >   	smu_table->gpu_metrics_table = NULL;
> > +	smu_table->user_overdrive_table = NULL;
> >   	smu_table->boot_overdrive_table = NULL;
> >   	smu_table->overdrive_table = NULL;
> >   	smu_table->max_sustainable_clocks = NULL; @@ -2101,3 +2113,16
> @@
> > int smu_v11_0_deep_sleep_control(struct smu_context *smu,
> >
> >   	return ret;
> >   }
> > +
> > +int smu_v11_0_restore_user_od_settings(struct smu_context *smu) {
> > +	struct smu_table_context *table_context = &smu->smu_table;
> > +	void *user_od_table = table_context->user_overdrive_table;
> > +	int ret = 0;
> > +
> > +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> (void *)user_od_table, true);
> > +	if (ret)
> > +		dev_err(smu->adev->dev, "Failed to import overdrive
> table!\n");
> > +
> > +	return ret;
> > +}
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cad0c1951c4f54d7
> a88c508d94dc1f9d6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637626317788023084%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =tq9QDYaQmRxqBNRpFZgRQ0DPBSO6AI3YFN033RQUgOI%3D&amp;reserve
> d=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
