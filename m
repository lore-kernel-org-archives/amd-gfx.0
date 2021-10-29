Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D0260F4B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76D0260F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C8C6E9AB;
	Fri, 29 Oct 2021 02:03:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9746E9AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 02:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/uKXb8acUTJMTnGD/uwxndaHgTfz3lDFUSw+f7NtJoWIz87HhIwJc/fum3jxipvrwXXInJp3dypazA9NZKEexTXuJz1umoaW8ZuojvOlPmoxebSp7S+pXNKQA/VMHHiVTWZRKlDeMFCD4x7tYqOLvP9IbIEpPGz6MmBR6pCG7JnqUdOi3E5NFfbUmDL2dUWbN4HFoAh5ZMnrFIGbyKe0a2BetLVD3riULUKzMPUYqGuvL7bG7JCvWLaYe/Nexda9BkUB8FaAs3WcmKJLJURMVBMRevS6n60jluvFFHW1U3kovuUvMQKeENhsHpEYNNkIJsSHw8bBza+bHYJMNCprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXlnM7VU39acWw+1730Z/wG+o3AAx8GHKS82tLdhQw0=;
 b=GADt6VJPNF/UeNX79IXt7dF3e7p5eiZl4ENa6/ZFywiRUwNNgAvqd8jnXUt/O/s/iXIvNJBz9PpPdWa7cfXECDAxWb4XqXqne09DaFtlRlczPaVTuzZws64i6Kpa5NGIWqflhc4IyQ/fhKR5Qi1dpmm0mIZM0gSWZVYsmUxjU4jGT9WL8ydAqwa6CMndyFQaHNB3VqCHPM86X3rwuRJNthEupGuYMEXh1yeR/Cr9EOFZbgFowPGeKUGd7HiK4sgQx3ka1MMvU1zJl/ZPTH+JAzuIB3kgtTOIptPPMMhCpZfluH9iN4KEPAGFhNLXHtGZo/snDx5lj1ffGGoqpZmUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXlnM7VU39acWw+1730Z/wG+o3AAx8GHKS82tLdhQw0=;
 b=rrQmLl9JY0umJ/vAJ41m2oA1WOz7krFFAfaUNbuQP5uEBhYomoL+8fMVPxsopYlc4dD5/z2dGsjS+Ik9rIjFSDI5y+E/NvLuow5voAGWK2YBRMJErKneLXUFWGBLR14svIDZh6SWK9aQv6/G9texPy2odWV3oAYiV817JdstwIc=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 02:03:07 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 02:03:07 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for
 APUs
Thread-Index: AQHXzBQM5GCAsoUQ7UutHQzVR+PUiKvpOfJw
Date: Fri, 29 Oct 2021 02:03:07 +0000
Message-ID: <BL1PR12MB5237861C3D8EF870C5A84156F0879@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20211028155336.2990-1-mario.limonciello@amd.com>
In-Reply-To: <20211028155336.2990-1-mario.limonciello@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-29T02:03:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=085fef46-2c2e-4786-85df-2269528d17c6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88c083cf-5653-4582-06de-08d99a804068
x-ms-traffictypediagnostic: BL1PR12MB5143:
x-microsoft-antispam-prvs: <BL1PR12MB514399E57A3EAE7D0433CEE3F0879@BL1PR12MB5143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIS5KMSdHUszQIRyBR668OaSr+jOTi3YAm2D8gKStSz7qbuUv75BuQr09+YhE8Soadp4rercL5Uh+xpmlVvZcrnx1zKatPGzeym4t1eXdkKoa1by+t0h1g2pLF6IPLxMVRGqoNQXOKXvcNu/UF8FIrcb8m7TxHJnd1Y5uDKIjB46cZ9SrtyYzSxpUQ5FkRyVcZRbq+cz8LwpaeYAE1BHr/7kblrrC+H9UtuceV1ucmheRzkobch5V66999SSBQmoCWxxnYCJBeW1+JxbGHZ0wyHmHdlmB6alpOLNet7eJ+iUah6rmkq87ccEofSEK2ZfB5PjIIFFcMiBwpvZCqQKuIixpApxOd2tab7K6YLb3ot3+2MikIe0WaeAkB2jmZbHqDh7GsPzTszQrvUjxhdaxZWIUqyYCisrOB+tuL+WbAlRsSfaTE0xHQ7WjEVibBuHxy1VQI6rMQNEymFu7WL/HXnpyKXqk/FKpEDA57+wpVkbfiAbuQYKZX6W2mSLr/PWecg5A0DpngBmYpfxSDMYvYpo8N1kBqqhQpG+k/xxDhquebNA9QBPQEeSDbRfy7VaklbyZ8EH2Shr8NMhfbONxZjWu9t2NBHfYKoUYO3kT1pNbezIC5+QW4LzzCVZelChSU7odWPpVPIqbOu6nl/pFSO8zrmwvBFgsJ99JA0PJ3vnQfdjXXNgont9Dwvh17su/flt1bgb9fUaiwiwrm/6TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(316002)(508600001)(53546011)(66446008)(8676002)(66946007)(52536014)(110136005)(8936002)(66476007)(66556008)(64756008)(6506007)(26005)(186003)(7696005)(5660300002)(19627235002)(2906002)(33656002)(76116006)(55016002)(9686003)(38100700002)(38070700005)(30864003)(86362001)(122000001)(71200400001)(83380400001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3s8hb0mmMTmxDp0YhqGoizhTAOJUT6RAESnaViFZOs8QK/27bnbKYU3mwPl?=
 =?us-ascii?Q?7ixrAI/RBy/aul7KAtMdoSJXqpWpQV/33CUJoum6hVJPFg2YsOzaQ7N+Nlw9?=
 =?us-ascii?Q?jxK7vQJuu9VSnODJEPw4WhC7SycDFmYIaW/K9L+3KdYYaW2DV2zbYewdMAYK?=
 =?us-ascii?Q?Tz5vMJaO8F4Hu58t2CGzz6ctzlpnIFwU/+EJNjg73Jbh86wLWhrUzd1jZRfN?=
 =?us-ascii?Q?bUK1dv93D4k0LE1Iff6Xp6ylurO8Hk2hpyHtw5L6BIfLO7pv6fcOrxlX6KBD?=
 =?us-ascii?Q?vYXWIgWBHTJPIonmgAxGYEYbEgJ8t7k0srG6V9Z+Xraj628+vrc+aKnvmryQ?=
 =?us-ascii?Q?0AUiWp75PQafn6y+rx4Yjzy8gEiGAY8epLh48RAVLE49KO9TiPe0p2jhfO/2?=
 =?us-ascii?Q?I6kwxzJNcgV3C6+iL3hMYiaHQummlJvtV/Jj+IHvXiEgQ3zklhNgP7S42qF9?=
 =?us-ascii?Q?9qyUFkJxN7acGcodS0E4B79P+gfwczyis0B/7VKH17OX3npIRM1ajr14jsNx?=
 =?us-ascii?Q?0EbmFnmnQfHe9FDjW39dRxgH3Eldx8WPBTT25pqMbRc4mUhcEKRMvIEWnWmr?=
 =?us-ascii?Q?6+jpwYnMDVX84JjPztlsEFWak4NFbHP6Eg3jaBM5nYNvhIZUhWCUx9YMwaTH?=
 =?us-ascii?Q?YstMxCcUNUW5L/eAf0dK1FQXX7gcMJrD8gqw45YVLKi+xof4yod4dRnT12kF?=
 =?us-ascii?Q?cGJng0kD6vrQ2F36Oj4edCQBhOdvPMPTa9LWJnPLxfpPfuGN1o5YiFMBJu/L?=
 =?us-ascii?Q?XjW6Z/kSwpXtXBw5mb/miYtOg+Wxt+sz5KmxOvVC60MVz7Zz+83lacxi+eKz?=
 =?us-ascii?Q?R+o9wsVyC73NPw4EsIXo8wu+cq86M0DIFa0eGRTtD5pvumotNkMezcKWEPv/?=
 =?us-ascii?Q?hg1y30oNmT2aj8PVaDUvpMjeMO2s4tjoxSIStli4292dv7M4PPU76GmplESD?=
 =?us-ascii?Q?v46JM0diqbghT8P9R7ai88pHqn7+bp+ueTG/jUSDXf4b356vRSQpPz82Rc+S?=
 =?us-ascii?Q?+yj0oK50KIOGRRnKvVV3F3FV7SytyOPRy/l7ZSy+OHSwt51FsoJK9DlXiGDN?=
 =?us-ascii?Q?TA+VKl/4QdptGfE6ruxl39GmO8AiLeT5Dy2j18IRY5wrwaCP0n3zju3V+9rm?=
 =?us-ascii?Q?VuwwdXZwb60ClCohI/D7klGcGuhRqjYgxq91kgdPots1xma9b6T+dKZwu4jj?=
 =?us-ascii?Q?vAvzuGAPM3KhJPcv04O6DJyecFbkmt62UpuY8J2O+h69KHaYhRSScprsJaKu?=
 =?us-ascii?Q?TmdLakLo3D51OQFNJ5GxOuacCbh2Ak/LA8AFjlYigDs5MW69S0nU8XS09zvt?=
 =?us-ascii?Q?0eOih8aSHlQFpnb0GStWaiuPDGVIvGV3hqOwIyV4VEHinqfKH6q5K/U62wIe?=
 =?us-ascii?Q?R3kTHJS5tj98L+XsL33mCaqaN90nKj5LkHsNOwRreYIk3H/AU04wTCswyQkq?=
 =?us-ascii?Q?MLra2h8Bg7D3GcD6DildScJLcaaQR+l/ODV1H40+dZsm6FRhqJH984SXnvsW?=
 =?us-ascii?Q?uU6joEtgKU2anlN/3U6mdM9iZ9bN1AMKduaVkL8tFPilbTWp8a7WWGMiXHLK?=
 =?us-ascii?Q?qiB0jJ2eThlo88dGCbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c083cf-5653-4582-06de-08d99a804068
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 02:03:07.5402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhsXW/Vb/YOWuZ58xs/A8tKBAgJLOV1hMuwma3l6GmrUrD59KtMDM2fVcC0K3nn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
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

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Thursday, October 28, 2021 11:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support
> for APUs
>=20
> Although this has been plumbed for Renoir, Green Sardine, Van Gogh, and
> Yellow Carp the functionality in the SMU doesn't do anything for these AP=
Us.
> Drop the associated code with them.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
>  4 files changed, 2 insertions(+), 262 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> index 1d3447991d0c..23d24173bc5d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> @@ -51,7 +51,7 @@
>  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN;
> VCN is power gated by default
>  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless
> display
>  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin fo=
r
> GFXCLK, argument is frequency in MHz
> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active wor=
k
> load type
> +#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
>  #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power
> down GFX, i.e. enter GFXOFF
>  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare
> PMFW for GFX driver unload
>  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32
> bits of DRAM address for Driver table transfer
> @@ -63,7 +63,7 @@
>  #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min
> for SOC CLK
>  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min f=
or
> FCLK
>  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min f=
or
> VCN clocks (VCLK and DCLK)
> -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
> +#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
>  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock
> frequency
>  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK
> frequency
>  #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of
> allowing GFXOFF entry
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 421f38e8dada..2451d990d577 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>  	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,
> 		0),
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> 		0),
>  	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,
> 		0),
> -	MSG_MAP(ActiveProcessNotify,
> PPSMC_MSG_ActiveProcessNotify,		0),
>  	MSG_MAP(SetHardMinIspiclkByFreq,
> PPSMC_MSG_SetHardMinIspiclkByFreq,	0),
>  	MSG_MAP(SetHardMinIspxclkByFreq,
> PPSMC_MSG_SetHardMinIspxclkByFreq,	0),
>  	MSG_MAP(SetDriverDramAddrHigh,
> PPSMC_MSG_SetDriverDramAddrHigh,	0),
> @@ -182,14 +181,6 @@ static struct cmn2asic_mapping
> vangogh_table_map[SMU_TABLE_COUNT] =3D {
>  	TAB_MAP_VALID(DPMCLOCKS),
>  };
>=20
> -static struct cmn2asic_mapping
> vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> 	WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> 	WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> 	WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
> -
>  static const uint8_t vangogh_throttler_map[] =3D {
>  	[THROTTLER_STATUS_BIT_SPL]	=3D (SMU_THROTTLER_SPL_BIT),
>  	[THROTTLER_STATUS_BIT_FPPT]	=3D (SMU_THROTTLER_FPPT_BIT),
> @@ -1010,80 +1001,6 @@ static int vangogh_get_dpm_ultimate_freq(struct
> smu_context *smu,
>  	return ret;
>  }
>=20
> -static int vangogh_get_power_profile_mode(struct smu_context *smu,
> -					   char *buf)
> -{
> -	static const char *profile_name[] =3D {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size =3D 0;
> -	int16_t workload_type =3D 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to
> WORKLOAD_PPLIB_*_BIT
> -		 * Not all profile modes are supported on vangogh.
> -		 */
> -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -
> -		if (workload_type < 0)
> -			continue;
> -
> -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size) -{
> -	int workload_type, ret;
> -	uint32_t profile_mode =3D input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile
> mode %d on VANGOGH\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload
> type %d\n",
> -					workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode =3D profile_mode;
> -
> -	return 0;
> -}
> -
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>  					  enum smu_clk_type clk_type,
>  					  uint32_t min,
> @@ -2190,8 +2107,6 @@ static const struct pptable_funcs
> vangogh_ppt_funcs =3D {
>  	.set_fine_grain_gfx_freq_parameters =3D
> vangogh_set_fine_grain_gfx_freq_parameters,
>  	.system_features_control =3D vangogh_system_features_control,
>  	.feature_is_enabled =3D smu_cmn_feature_is_enabled,
> -	.set_power_profile_mode =3D vangogh_set_power_profile_mode,
> -	.get_power_profile_mode =3D vangogh_get_power_profile_mode,
>  	.get_dpm_clock_table =3D vangogh_get_dpm_clock_table,
>  	.force_clk_levels =3D vangogh_force_clk_levels,
>  	.set_performance_level =3D vangogh_set_performance_level, @@ -
> 2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map =3D vangogh_message_map;
>  	smu->feature_map =3D vangogh_feature_mask_map;
>  	smu->table_map =3D vangogh_table_map;
> -	smu->workload_map =3D vangogh_workload_map;
>  	smu->is_apu =3D true;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 145f13b8c977..21da7989f1ba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping
> renoir_message_map[SMU_MSG_MAX_COUNT] =3D {
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> 1),
>  	MSG_MAP(SetAllowFclkSwitch,
> PPSMC_MSG_SetAllowFclkSwitch,           1),
>  	MSG_MAP(SetMinVideoGfxclkFreq,
> PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
> -	MSG_MAP(ActiveProcessNotify,
> PPSMC_MSG_ActiveProcessNotify,          1),
>  	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,
> 1),
>  	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,
> 1),
>  	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,
> 1),
> @@ -120,14 +119,6 @@ static struct cmn2asic_mapping
> renoir_table_map[SMU_TABLE_COUNT] =3D {
>  	TAB_MAP_VALID(SMU_METRICS),
>  };
>=20
> -static struct cmn2asic_mapping
> renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> 	WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> 	WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> 	WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
> -
>  static const uint8_t renoir_throttler_map[] =3D {
>  	[THROTTLER_STATUS_BIT_SPL]		=3D
> (SMU_THROTTLER_SPL_BIT),
>  	[THROTTLER_STATUS_BIT_FPPT]		=3D
> (SMU_THROTTLER_FPPT_BIT),
> @@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct
> smu_context *smu,
>  	return ret;
>  }
>=20
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size) -{
> -	int workload_type, ret;
> -	uint32_t profile_mode =3D input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		/*
> -		 * TODO: If some case need switch to powersave/default
> power mode
> -		 * then can consider enter
> WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> -		 */
> -		dev_dbg(smu->adev->dev, "Unsupported power profile
> mode %d on RENOIR\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload
> type %d\n", workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode =3D profile_mode;
> -
> -	return 0;
> -}
> -
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)  {
>  	int ret =3D 0;
> @@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
>  	return 0;
>  }
>=20
> -static int renoir_get_power_profile_mode(struct smu_context *smu,
> -					   char *buf)
> -{
> -	static const char *profile_name[] =3D {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size =3D 0;
> -	int16_t workload_type =3D 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to
> WORKLOAD_PPLIB_*_BIT
> -		 * Not all profile modes are supported on arcturus.
> -		 */
> -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -		if (workload_type < 0)
> -			continue;
> -
> -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
>  static int renoir_get_smu_metrics_data(struct smu_context *smu,
>  				       MetricsMember_t member,
>  				       uint32_t *value)
> @@ -1389,11 +1305,9 @@ static const struct pptable_funcs
> renoir_ppt_funcs =3D {
>  	.dpm_set_vcn_enable =3D renoir_dpm_set_vcn_enable,
>  	.dpm_set_jpeg_enable =3D renoir_dpm_set_jpeg_enable,
>  	.force_clk_levels =3D renoir_force_clk_levels,
> -	.set_power_profile_mode =3D renoir_set_power_profile_mode,
>  	.set_performance_level =3D renoir_set_performance_level,
>  	.get_dpm_clock_table =3D renoir_get_dpm_clock_table,
>  	.set_watermarks_table =3D renoir_set_watermarks_table,
> -	.get_power_profile_mode =3D renoir_get_power_profile_mode,
>  	.read_sensor =3D renoir_read_sensor,
>  	.check_fw_status =3D smu_v12_0_check_fw_status,
>  	.check_fw_version =3D smu_v12_0_check_fw_version, @@ -1429,7
> +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map =3D renoir_message_map;
>  	smu->clock_map =3D renoir_clk_map;
>  	smu->table_map =3D renoir_table_map;
> -	smu->workload_map =3D renoir_workload_map;
>  	smu->smc_driver_if_version =3D SMU12_DRIVER_IF_VERSION;
>  	smu->is_apu =3D true;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a403657151ba..8215bbf5ed7c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping
> yellow_carp_message_map[SMU_MSG_MAX_COUNT] =3D
>  	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,
> 			1),
>  	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,
> 		1),
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> 		1),
> -	MSG_MAP(ActiveProcessNotify,
> PPSMC_MSG_ActiveProcessNotify,		1),
>  	MSG_MAP(PrepareMp1ForUnload,
> PPSMC_MSG_PrepareMp1ForUnload,      1),
>  	MSG_MAP(SetDriverDramAddrHigh,
> PPSMC_MSG_SetDriverDramAddrHigh,	1),
>  	MSG_MAP(SetDriverDramAddrLow,
> PPSMC_MSG_SetDriverDramAddrLow,		1),
> @@ -135,14 +134,6 @@ static struct cmn2asic_mapping
> yellow_carp_table_map[SMU_TABLE_COUNT] =3D {
>  	TAB_MAP_VALID(CUSTOM_DPM),
>  	TAB_MAP_VALID(DPMCLOCKS),
>  };
> -
> -static struct cmn2asic_mapping
> yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> 	WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> 	WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> 	WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
>=20
>  static int yellow_carp_init_smc_tables(struct smu_context *smu)  { @@ -
> 543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct
> smu_context *smu,
>  	return 0;
>  }
>=20
> -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
> -						char *buf)
> -{
> -	static const char *profile_name[] =3D {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size =3D 0;
> -	int16_t workload_type =3D 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to
> WORKLOAD_PPLIB_*_BIT.
> -		 * Not all profile modes are supported on yellow carp.
> -		 */
> -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -
> -		if (workload_type < 0)
> -			continue;
> -
> -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
> -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
> -						long *input, uint32_t size)
> -{
> -	int workload_type, ret;
> -	uint32_t profile_mode =3D input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile
> mode %d on YELLOWCARP\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload
> type %d\n",
> -					workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode =3D profile_mode;
> -
> -	return 0;
> -}
> -
>  static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>  						void **table)
>  {
> @@ -1238,8 +1154,6 @@ static const struct pptable_funcs
> yellow_carp_ppt_funcs =3D {
>  	.read_sensor =3D yellow_carp_read_sensor,
>  	.is_dpm_running =3D yellow_carp_is_dpm_running,
>  	.set_watermarks_table =3D yellow_carp_set_watermarks_table,
> -	.get_power_profile_mode =3D yellow_carp_get_power_profile_mode,
> -	.set_power_profile_mode =3D yellow_carp_set_power_profile_mode,
>  	.get_gpu_metrics =3D yellow_carp_get_gpu_metrics,
>  	.get_enabled_mask =3D smu_cmn_get_enabled_32_bits_mask,
>  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask, @@ -
> 1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context
> *smu)
>  	smu->message_map =3D yellow_carp_message_map;
>  	smu->feature_map =3D yellow_carp_feature_mask_map;
>  	smu->table_map =3D yellow_carp_table_map;
> -	smu->workload_map =3D yellow_carp_workload_map;
>  	smu->is_apu =3D true;
>  }
> --
> 2.25.1
