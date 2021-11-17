Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E71361881
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E71361881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7372289FAC;
	Wed, 17 Nov 2021 01:51:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D75289FAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 01:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYRfJVtMh8sSclXTcqMZUVKry1VulJU/lWN3/pQnERs3eYiMitmo2P+1x77hkh58prFPQlbhp3sW053QS67sqwsTD177ITqjCTGR9KJdsL+XlOeFpA83bhMCeAR6L+F/rlxYNoT1EiYQqbwhaCZ8VoSuQVmOXwdMZaCYvweSy1vpXKv6/0zpGQ+ldxZVCiK/9yhQ9AZkb61g/W+xpoLA5jzmHyrdE4kGElEWFGocpQk+OvMrBFIoWU7z+3HmnJ9sBLB58HoZ0imClkVg9P/Zznh0pbhjTZFPjh7Lm0yl0Nu1hkKBd2sqsyuTYUXzOs7HLKoY7MVZoVnyqtC7azyoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NarZeLJFQCnpi40B08YhToy4M82Xv0jhb2W5ypE8Uts=;
 b=C1TWY62So5ZHeG5Hj3gx8ff6AE4SU/z/MWn2Ku/1oehgrFPNoAEiKbzwdUl6QrFS2DDI4Klr5zNlQCxSA6bZQ595uwv7OFh7eNcQ+GzamAubWQNP33kaBESE0g9fIcI+FpNPZYvFuQYf7JzbPCzBDKXkTgWuZSbCbujkaTgetYHwr7WT/q/w5qb7krVwT67qKFIVsQG17BA2WC625qO0RUAq1u8rSpiCdIE2wO1gbenFB0YbpwixrpIFDNva2kvZk4jhXTtTY0K2yHESM6MNP1oKPC1x2sxU44wGyCuWs1UV2aa1mouUO4rRN18nSpQm4jF8vzy5ElydA9EQIir7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NarZeLJFQCnpi40B08YhToy4M82Xv0jhb2W5ypE8Uts=;
 b=QaG4LfroV06IVF4VCk2PoZx6WGPvwjAh6bi2BEIfryldxFyvZjGWAb7LRTGCUCGLxws4SVhhOoMG4CiHZkW0kufjDeblUeLZ2h55SxcqQT6D7mvC5rZEi3OcyJ97tjsrWEAfjJbykk8JVqiSXwzWYk5Mw9VezRQh/B6VlqLoAnA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Wed, 17 Nov 2021 01:51:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 01:51:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Thread-Index: AQHX2sBcTsaCWLUn+EGADXGbyE8jw6wG9bQA
Date: Wed, 17 Nov 2021 01:51:25 +0000
Message-ID: <DM6PR12MB261907441290133746853DF5E49A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211116080247.32143-1-Stanley.Yang@amd.com>
In-Reply-To: <20211116080247.32143-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-17T01:51:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b547768b-f0cc-4fc1-99d4-a0e6c531e0fb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 419b4d06-57a0-41b8-ea2d-08d9a96cc3d6
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB32744AE1B858F0831152E487E49A9@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xQFQY6/J2onj9w/P6g3s1hZ5h5QLy4LMmMjxObZCJQYcgl8of5+G6QUiq6imwWW7lVTsLCuEJcoIHKWQNTA3+UyNkmn1sR/3wLvm+b5b3vs62NjK6e3voPlIVhh+IpyliyJbKFbdFY5x19gZGQwL+EmghOOdCDmInJfYcuL8lJ+Ny/3YbTm/u7TB10w5R43l5JekwyIGTiabtQtnzh7E7W1ijQr9YFM/vHxrshrF+iPXkWyiojPT8QUc8+G0Dvd7RDNHZdA1aHPrhjE1zUYdS7I3euQxk3+12ezuxTn9FFIcs1MsfKKy5EGGkiNLBqWv8Cvs++KjzT2vR1gvwD7XEFFZDkZRzF/Gn658929ccBdwhb9HzBoHMUnPNPnbRCI8Rs2vm/iXuYfL24626F+NQ+JuJiQgzBMTzKCMEfm1mjCURdbfEgGAIOG/I+4OED5Y1xSu+XoImFaWKaeOc27eBIJymXdXETG0LgkDmTV6+lp47EkyOGHZmqd8T2aM1szCAvtnwCwbgbP6NwkNHzNPNRR8/NY+NWiTZe3HQtSb+Dh6e1VcS+A5SkKb6Dumn7y6TYCGYoTUO8RTYH2DZ8ZzycJ09FCWnt2ku3SZjET3LXpOtoSiJqOaAkX5NG/d/sGJGbUtI32Nnhf4kM9DUDH7IF6mElng6lqHT3AAmF8BlvDTwxAy3epVzSzlMUlYk8AHVTkfaL/Cs16y8GbYVxrdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(4326008)(6636002)(86362001)(38100700002)(2906002)(71200400001)(38070700005)(33656002)(508600001)(53546011)(9686003)(55016002)(6506007)(7696005)(5660300002)(26005)(316002)(64756008)(8676002)(8936002)(19627235002)(52536014)(66446008)(66556008)(110136005)(66946007)(66476007)(76116006)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvr59iUfuY6UOUr02g+xD5nz2qTYEuKlssD30cW5be2kDCnSCXSdO24Vcjqj?=
 =?us-ascii?Q?8B5EK87Gkv/xYmWGgRpYMWDTEm3LBzTt3kIooXXKxiKXU3htfXR+/65jLS+/?=
 =?us-ascii?Q?/xTR6Quvm4PXIA82H26wgmtbGMHod/AzpVihdMKC1/jEIgMl4jJbwZ6/vFGp?=
 =?us-ascii?Q?7XeuMC69F5EfST7DQppYKe9x0tXYuo37hlBeYee+kJ9Go3cvw/kwRsaKQTmS?=
 =?us-ascii?Q?EqeGnKZNua9JmtLN0NtJ90wuVR/n40PLhl1zhD8BYxBDGK3GpNpf6x23vT+q?=
 =?us-ascii?Q?6CNBzGeolTCnw9LHLXfi4j9IeOoCsbtHWK5ZSIKosvrL/VPwWJY2lzTsqghv?=
 =?us-ascii?Q?tjMmOPvkZi664SK6UAUsJRpAehO5wegbM0LVS7IdiD+Uy7jepF5odMDapPfd?=
 =?us-ascii?Q?AgGkJw1CXUnTHJ1Gxo5Nkyg4yQMWSe9SU23ebXdRrYgvn3JLB8eLScbwYk0B?=
 =?us-ascii?Q?/suB7Vwftug660K2Tb8OnAoqTYq7BrHO8mIteNe6M2pnvwQQTAdGF07LPGop?=
 =?us-ascii?Q?90fc3qIhS2bAss03tD5JO9ePqQBBzTXVue+xK8a5ihSGhoAHsQKWEKpRE2DG?=
 =?us-ascii?Q?4NHj6S48hE6H/sx6RFKuK/lpauHIEAYRi1ozc1ld8FkgpLQVYTxlLuqyEUg8?=
 =?us-ascii?Q?n/kohEl3rW9rM7V43PMO8Bq6ng2AKWJWcsfz/e7tsqkh+fD/uXs3pB/VxEzL?=
 =?us-ascii?Q?ui+BdHJgpsu+uPYO8flbMDYUC/83gnrGgMgotjduUKQMpQK/ytFv/bQ1DcYt?=
 =?us-ascii?Q?XdKpmqm5K7EK6crp1BqzAP/jKanx5o3A0rF8EQS+OmKgkMl+UfJZKlDvwdrn?=
 =?us-ascii?Q?jW/cPhaCCck67OT1Fe8/L8IDDT5LwKy5jLd6glrEXGQ1sKWfbGLK22kde3kF?=
 =?us-ascii?Q?j/WyPTU3dKSGd9wumVEUIpT0iJ6jqdtPqP68HrnSt7IUIH4fW/LSNwg0+ECH?=
 =?us-ascii?Q?MC9cqSCp0OLQaWgGFZfsdZvy8ccijUwzf/bm7sCMg24AFlAed2/x8nbwUOPw?=
 =?us-ascii?Q?Uu/SoOQa8bGnrN4XOuuK8ypy7cv3BAOpm9iLuMKKmcgGWHRJNW9/CuDADMaG?=
 =?us-ascii?Q?I5trg2CqMG1ZPt32P/EJRoCF3QeFUBqkXlWQdX9Xvfl8t2QUwnVyLtDiUaUl?=
 =?us-ascii?Q?9hMYQuPl0+8VvNKwFs5Xn4DEXSRVWFs2C2SuTtjN+92/ZVeMrWziLaYv996u?=
 =?us-ascii?Q?MscmFAuryY7IcYUXkNYnF3k9FWxl2jah16wjoLmQv0xTNpsMkLiYo0eosOik?=
 =?us-ascii?Q?78xRz5/jaqGCIoBqT7GSSKlaqjYS0OkAXrYDsT1XwOryLhJs2pgtBRnOwck4?=
 =?us-ascii?Q?QytfOLIr2w2iH3I5Xw2iTVKXdQv6xztLf9EmUnK60/9cUdxkiNFeoegNg1im?=
 =?us-ascii?Q?9dKJCZGDeFbU9dWSzIWIB2VBb8UwnvBVnmwegdW5LrCzzYcYyNQLlgSMUnmY?=
 =?us-ascii?Q?DvtNcv7Kl6+4yuM5Pyyb3hQTs+xHXyRJX7x34jvevjZVx7zEjagEiSN7pHra?=
 =?us-ascii?Q?+CoXlMlIBvXo/GB2sqVJ+MMvPraYtcRPrblinRS5zjepi8+B1otRPPG+6YVn?=
 =?us-ascii?Q?n1lfZltlwhZ3d1PtQ9g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419b4d06-57a0-41b8-ea2d-08d9a96cc3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 01:51:25.5590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TejtWw/o+QmkmxpuQoBp5J0CCcJ+ir6viLXYPfbqaNrANLOIxB/4lI5KEe9a0KRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Tuesday, November 16, 2021 4:03 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
>=20
> update smu driver if and version to avoid mismatch log
>=20
> v2:
>     update smu driver interface
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
>    uint32_t MmHubPadding[8]; // SMU internal use  } AvfsDebugTable_t;
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
> index e5d3b0d1a032..2e35885c7287 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -27,7 +27,7 @@
>=20
>  #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define
> SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04 -#define
> SMU13_DRIVER_IF_VERSION_ALDE 0x07
> +#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
>=20
>  /* MP Apertures */
>  #define MP0_Public			0x03800000
> --
> 2.17.1
