Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2529261269
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2529261269
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D401B6E924;
	Thu, 18 Nov 2021 09:58:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97696E924
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4G092p0iw7g06SrLGokvYJkHA+0z+GiwQHyRrlsrsSvxB+yyipPQSciL8XCRa9WxieNJ1ypUc1HxxjQGpB0LYdp/gQdsFUh8uuI07heYv1+/HuGA766ZcvL8h+4EvYsr3zzMCfzufDEHDFMgCGtXw/hCDzDtSamjhe63ovLex26i1diuqFEkf5SHm2Yc/9R80hV6NIAeVY6UD9SLEV4PHnLbVhY7Sy5RBI2iStS4j9CFu1+peV8FYgneY7g1dfnOZ3tObrbBbBrn8SHwAwCX1JTaIVRyHowZEH4HMJY2bG9/0tmzRzzJxlkMDVpNRLJQBzs7omIzGRHP5ip9ybQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv1ilD22lGilZU1wkHzzkOWVfA88L0eDIY+49iG+2aQ=;
 b=dg5N6naUgTz9O8XDA+l16+LNYlKKaQ4t7EYxEnXW6PtyMWqQGOy4xUW+OabZZfDbfOXg5E2W28zgnI1U4Z938LYaTTno2oyoWUR3fCzfT0lMSTzhec6BdkW33eACFGobkI7bL4FqhMxff9kU7KgnuFg5GTxh1vDMswEZR4RBzx7exwmiWzjoRAZlpCksc0F6wrybxJ+qpF+mdRmWY8jrhE63uHLNO4mc+KKVDXraUNYUkhfNA4V8m4iR/bnrt6EFWPTXI2pYrI0lVm9uo52nW1KlSaiu/QqmkF7/OPCsuERTVBu8OsVNqnPb82juDyMqVaGwuypo5povIzvnEnkInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv1ilD22lGilZU1wkHzzkOWVfA88L0eDIY+49iG+2aQ=;
 b=K8ECGvkfcu2GhPKoL5ugGjiWO4TmyZKWNEJjN0KkQa7otSmWdF7DSBuJNSo3twPA8m9kHMhJ3UA4OLwa8T5OGlTHX/eAbk9LTBRP77gPjLqXWi9949hqWt/NnMztqHq1fKro425QlnqnZL9PN46vvX7rweov6pnYXU4vK5BhM/0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Thu, 18 Nov 2021 09:58:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 09:58:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
 aldebaran
Thread-Topic: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
 aldebaran
Thread-Index: AQHX3F9kQ0NnnGgiAUaQMRE/Fo8Vf6wJC5Pg
Date: Thu, 18 Nov 2021 09:58:29 +0000
Message-ID: <DM6PR12MB2619F27FA83AD0C14BD2AC9DE49B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211118093344.4361-1-Stanley.Yang@amd.com>
In-Reply-To: <20211118093344.4361-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-18T09:58:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d2211935-07f0-44c5-8284-c31b328c5197;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e35533c-80af-4f5f-dbb2-08d9aa79f941
x-ms-traffictypediagnostic: DM6PR12MB2828:
x-microsoft-antispam-prvs: <DM6PR12MB28285AD46CD10751326F0899E49B9@DM6PR12MB2828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sg4y7xwRs+GylToE/OZmAr0flApncc+juZhBhSBmIGV1K//XVe9AkC/23hMvi/+JvcIv5cluEitXQGSehyGmjHbzt7lXgvVtRXOPXVyLICOF0YaJUmhvgcvvqwJ/H4zcEeQWb1v3iyEFQXyCdG6veNVyBuspSNHbATWSn8b8SMHvCXamqCiVTINREifFlkGUpBvC2mSZ/Zub54x4Io5GQeGwftDbk+RVWIYsh0+9zoTjccNCAqvmXRimYOyivoNuO1TC+ju3TiVaCYnmcVm4cRgnGm4LITgzSq9kl1zrWQoQiWmLLs1PQB2V/9SEsYznZg8SbvC/613Mk++Or5ukeLYnRn/nP+EUC2aLDqSiwbo3BDEoOHl6WgDeUanbxtI5QeVPhi9NowNWIyz5oWee6TI9ZcBZqJaVv9Lzl4mCtrosRaQTBoa4VdfOPPBCx37D3Pbbirvd0Q6SIACoJRYSZqW+vA1HpatbF+69EUW+bn/eP2mepNYeLbjlCf0uYhHSEi1eHMl9iscUpC3UKlF88v3OSckjR2APiDgLh9ogjDZ3Tu4bzQpM0BAXmpBZZA8qZ7Msh2s/66QmoQCoJmkEAeF0WVkB3ivApWpvnsglYqwlhXkyQHZlEDg6ovzvnxU3o3AMxYrGKO0tiqfQlNuyNFGSs/3CLyI0bYpTa7jJ3iDsaIk7V6fGIKIvko5ftPH5DvFroZn+R9+28HBBXYHk2Fco6nrzPo0vC3Ll3YBlamg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(64756008)(19627235002)(55016002)(508600001)(7696005)(26005)(66476007)(53546011)(186003)(66446008)(921005)(4326008)(6506007)(6636002)(110136005)(76116006)(52536014)(83380400001)(5660300002)(33656002)(66556008)(2906002)(316002)(66946007)(9686003)(38100700002)(71200400001)(38070700005)(8676002)(122000001)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?niLhfHZ80Fw3JVK/MbUkvVyLic4DbeD01PfxmX4tqkVXXa+eiRfQbgsc/VdN?=
 =?us-ascii?Q?bVkp4g7gCUDehng58Zq5/QE3Vf1kFbSYv2c5eSv0jbxq4rBErhVj19JnWxyT?=
 =?us-ascii?Q?qIvuGewBMlfgu1Phpq5sbasopAt8SfA7RoV/CBMYWliwlocdhqG+9gJqBs0A?=
 =?us-ascii?Q?swuN2lPX6hugik8VnDKBYHpa5Y4lWX7YaedjjK31/3xVV5alv9Wlt9AFk0UM?=
 =?us-ascii?Q?A3SMUakAZf5xjqOznOwyJx4XfOkbcNM1MjP2LyWmKuY0zwFNO/ty2JI+PTD6?=
 =?us-ascii?Q?dDlbbs3KSK9JRLUa2VnxbYe2yJdLB6+PxSsJDgjrjbGol7SHBIl/foIQr8nQ?=
 =?us-ascii?Q?BiOU7wSkMalRyBOfIRrIIKuK2HN6QoyTOqCY+Joju+gzPXW60CcptJWjYcd0?=
 =?us-ascii?Q?gjAuN8fmmvWrJgIm2KprGPBt2UiSlwK6Zik9DVABSk8LM0rzFhk216Jbwbwv?=
 =?us-ascii?Q?BxwIzlBgVmy7sPcVzMydXyQ/9EMYs+XLArJiWNXXfHlHbU3Vp2qKmp1RlLic?=
 =?us-ascii?Q?/8Xvgio9fXmYzfzzs12kUDCQNQbdY5EtjMewymmQqwVx7B7Ze6H2A+EuFNpK?=
 =?us-ascii?Q?feExJZcIAdbbp9i0a4eSrmXfffGqYUkl8gicRziEqoAkUP6iYA/QTGJPM7Sn?=
 =?us-ascii?Q?CWbKpOteOftAkJT7aapA/Y3u4Q4a/TThR9TXVPqQTe+BJEqjlpLvRKPub7Jx?=
 =?us-ascii?Q?mEd4ZTYW5El2qXhB7AY1esJAUdhgM+B3Gxww3YhsPQA7/VC4Rt7sXpVHX8Wu?=
 =?us-ascii?Q?zmIodnKQTfj1EMDnv80tpByIi54PCNmInnUetrLJWYsZ8fEJ9S6DhKtpRuHK?=
 =?us-ascii?Q?deZKadfR9xrVoWkPjrh5qDgYABAmgTH9kcNxBep1XRSLYH0VWIjI2EplIVeJ?=
 =?us-ascii?Q?tv7/kOaR3toZiT4WILrFFiDjxz21aEXDdVAVk/viwey1+gh4ncb0jJLj7XgL?=
 =?us-ascii?Q?WPQnE5g+7cCdeiZPJnz7K1FX3Bn616mwc7bZWZmiZpzW8DKjFuFxjxiEKK8G?=
 =?us-ascii?Q?X/lcw4ewpG10mUCrnrNQ4V8lvks9mx2f1TMRHLOM8/hFJ1GCmpOUOyk4fdWc?=
 =?us-ascii?Q?1npMENr/6C6X+2UJOWlNuwPZFKGvcbk/X7Xye2epLM4+uDhCJLJRng9yNT6H?=
 =?us-ascii?Q?OfvVlCPIllUFIDVu8wTnGhDePrccNceSXU+9fMfa7WBBQ6lzYbLyQlOdn2i+?=
 =?us-ascii?Q?8ufGjLCiMPhlcyozB/qRMdYORyZvSYgo7LWH9ggjr9sH0B7CwX/5GyFrLV8R?=
 =?us-ascii?Q?Q0OLRvsNM8ugUiguuvFZn/WDuAGEL9PggDZXk1OslbA8kPesJRzhGDx4nakK?=
 =?us-ascii?Q?sTUdR8Dr3zcGoNh+K5dndoJxudRZq56kKndaNSXn2yZGw0tRg9hc/xX/JBiS?=
 =?us-ascii?Q?SMB+TAQIvsyAGVqgiIL4OLYDbzutNQmdMlSEA584tM/nBpD83x4o0SzEgweX?=
 =?us-ascii?Q?XjYkyndZuOFvmylcJQtPfvzTVqMiWBFIqiXZVJiXNafmpaXnpZ4I6eoGCWhh?=
 =?us-ascii?Q?V7c4CP3mcjg99BNAT03U1PUgEpeM+ioDv0t3jD/AAuZfsCuLHs+kGXaK7DiC?=
 =?us-ascii?Q?M1yj3rnlkXMbaEf92fI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e35533c-80af-4f5f-dbb2-08d9aa79f941
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 09:58:29.6854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crJlYCfNM2tyw4eryfthm76tEW/ebVoktkF0fwltmakoFNUbSPmgKW1Yt5d6TCJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Better to update the patch title as "drm/amd/pm: Update smu driver interfac=
e for aldebaran" as all other power related patches.
And please update patch3 also.
Other than above, patch 1, 3 are reviewed-by: Evan Quan <evan.quan@amd.com>
> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Thursday, November 18, 2021 5:34 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
> aldebaran
>=20
> update smu driver if version to 0x08 to avoid mismatch log
> A version mismatch can still happen with an older FW
>=20
> Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  .../drm/amd/pm/inc/smu13_driver_if_aldebaran.h | 18
> +++++++++++++++++-
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0.h         |  2 +-
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> index a017983ff1fa..0f67c56c2863 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
> @@ -140,6 +140,8 @@
>=20
>  #define MAX_SW_I2C_COMMANDS                24
>=20
> +#define ALDEBARAN_UMC_CHANNEL_NUM    32
> +
>  typedef enum {
>    I2C_CONTROLLER_PORT_0, //CKSVII2C0
>    I2C_CONTROLLER_PORT_1, //CKSVII2C1
> @@ -507,6 +509,19 @@ typedef struct {
>    uint32_t MmHubPadding[8]; // SMU internal use
>  } AvfsDebugTable_t;
>=20
> +typedef struct {
> +	uint64_t mca_umc_status;
> +	uint64_t mca_umc_addr;
> +	uint16_t ce_count_lo_chip;
> +	uint16_t ce_count_hi_chip;
> +
> +	uint32_t eccPadding;
> +} EccInfo_t;
> +
> +typedef struct {
> +	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
> +} EccInfoTable_t;
> +
>  // These defines are used with the following messages:
>  // SMC_MSG_TransferTableDram2Smu
>  // SMC_MSG_TransferTableSmu2Dram
> @@ -517,6 +532,7 @@ typedef struct {
>  #define TABLE_SMU_METRICS             4
>  #define TABLE_DRIVER_SMU_CONFIG       5
>  #define TABLE_I2C_COMMANDS            6
> -#define TABLE_COUNT                   7
> +#define TABLE_ECCINFO                 7
> +#define TABLE_COUNT                   8
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index bbc608c990b0..44af23ae059e 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -27,7 +27,7 @@
>=20
>  #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
>  #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
> -#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
> +#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
>=20
>  #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
>=20
> --
> 2.17.1
