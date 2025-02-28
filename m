Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2AEC282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 22:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475BA10ED5B;
	Fri, 28 Feb 2025 22:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdEeNyJD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C947310ED5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 22:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7/2k1YThTVbvzMNCqHqh/fRnTgx2yTu7v17S97iwlmii9HJitjpcF5kvWBU/WIh9H9Y+o5AjHwQzxFuebERTF3LVH4vAZrqZExvLv7TD2gPLU9hUpSAfWO3tUT7hippXM33M8D2o1HccnbQee8OD5vttatfYFTXpyRRXUR0FGPZWUcMBh0nJvUBT9Y7haPJw08ugRB1IqzL1aJ3HCfdGZiQwrC+pNfYxYpnvL9Q50yqrpabO5IBK8uZbIYMRM7KYI9eqlVU5L/tVLmYg9nrdQKdU1oiZHof8pidZetcmy5ic52xM4tWw2qkswfjnjyvkT3w9PFxW7/RDRNPxTw6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep/YRabpEmbJGx72mh7ohAqN9OyF7Kve46gTOSJaZms=;
 b=KgIE+lp3C4vjMMEno6Fj6JQrIpImYZesrHoZzb+IaGblWw1YLomxW0KEe2K3nCm8o3wSruCRgmZFYhm44IFIvZbKWSaUEufWuEBVEcZuOtTaxks0Ec37+ZzqszOVvIpLjWWuGK9pw4OVnUWXyewxvg5euAYuuwpFPhIx5dbTkC3f0LDTJxdRTtU/7O664+1Svn4zehmPA0XiSqPwcZTg5qJiPMAU0QgQDu3QTqKouAURL6MhLzqynQAaxzsk+uM6q3iChvQ82KPhbCC1NfooZbsrFAEnJ/lxDCQRJCIc2vyweeCIbYlGDftd7AiIC8qtjfiE/zZvzimb3s3EAhBxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep/YRabpEmbJGx72mh7ohAqN9OyF7Kve46gTOSJaZms=;
 b=QdEeNyJD574TGjqG0KNvkRKSzLq/9is1XlMvZ+IVGlgA8FAb0cKS3TYLkzlLw+JBAJJZPGW8nZZdfcXuMY+7NpbnaZ7ekUqa38MoazJwVZMSQu3wSpjemOwpEqb2I78iwhWZx4NfV/nXttP8X7mSgBcR2C+VSk5fHWzlWxwvexI=
Received: from SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 22:39:21 +0000
Received: from SN7PR12MB7107.namprd12.prod.outlook.com
 ([fe80::f0be:9fcf:ed00:fe7b]) by SN7PR12MB7107.namprd12.prod.outlook.com
 ([fe80::f0be:9fcf:ed00:fe7b%3]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 22:39:20 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Topic: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Thread-Index: AQHbiIPrbALpkEA/UkmfkfeSkRWPj7Nbj8OAgAHBzLA=
Date: Fri, 28 Feb 2025 22:39:20 +0000
Message-ID: <SN7PR12MB7107C36BF59413D89DD486E88CCC2@SN7PR12MB7107.namprd12.prod.outlook.com>
References: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB7435A4BED4D1DE5C876F5AF085CD2@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435A4BED4D1DE5C876F5AF085CD2@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8a490587-367a-4bf9-a148-12005f208f08;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-27T19:15:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7107:EE_|SJ1PR12MB6267:EE_
x-ms-office365-filtering-correlation-id: 348907ce-6235-4e3c-9103-08dd5848bdf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Njr0eUzsRVaiMvn0HoqZq3JFSAyEAd8YNsnz3OXMQnfoUpMaY/vqj62Lc1Z3?=
 =?us-ascii?Q?dSO8DEBaggNkyGiZPegBB+CJR8zVJyEoingpU5lIYi93sHH9oET10xgMytMo?=
 =?us-ascii?Q?tlIg22VpnJL5ZTTYENauQRg1723sbBCrQ/A3bw19Vb/SwSLnkmPcFJnn9Iq/?=
 =?us-ascii?Q?DoihCWCoNzh3pmQdfmkydgkySG6D3OA4r1BfaL8qc723z8+FFhzQTCVd90Ks?=
 =?us-ascii?Q?fDnALI+8fBTS4r7g+J/8hXfF0425YxI4bQ6lLjSVtfw1nGYtdyabJ4DKBrD4?=
 =?us-ascii?Q?Y+gJrmYuPBnawl4Rki1SoPVLEwpMhrfZKvB0R58ojykDRjuXS/uIDS0amZ5n?=
 =?us-ascii?Q?ybkw0SoZFtQy8MsXI3Hys+BYTRkrGTOWjieGkEwjfLH+rFfUSr3rNMX1gufU?=
 =?us-ascii?Q?iJmv79tfZhU1ZrrC6zWUzxZ90CkqSpkwda3mIW0qT7QiNVgzvp0Pz/i57d25?=
 =?us-ascii?Q?WfZsvSgzcVuA0ui98HHXDArOuYIwFyqO5Cn/XQnH7x/QJ+3Kcq4Jl/IBIibh?=
 =?us-ascii?Q?iUy4nLOTJo43JN0JWQXi1Y1Q4kVD6D0AzJvTEDpdqnhSDobBEcZQxmTiCsvG?=
 =?us-ascii?Q?HBSsg+Cjt9uxsyVMzjrSSClXq6PMQVQrg6ud9Fno2og7rDZKXH9x7Vl5SUIi?=
 =?us-ascii?Q?JnSFpgbYxQUkHHkKjIdCKs0yGyVnFjEwE+CI0+TgUwsABG/voXPVFK7kK8qo?=
 =?us-ascii?Q?uqjbWdglTlwdE/pNRVwD6J26+N8E0XJnPtVTKKP/scaaWmrelWKEpEzTHOUu?=
 =?us-ascii?Q?HwksE3yCqufwHf/gve/nSSPFXW7FczJJskggLIj804mBZdRRwWnORbSIic71?=
 =?us-ascii?Q?rv+P2ByfOUZQ0SQpkbuLl8k9bhkNXp3WTz3Q7vlJfvWt9T7IQ9Li6nJn/UlG?=
 =?us-ascii?Q?mpPp5GzrPNARVXQjy8nwSWO5vfxA1CvAKdif0BsrnedgnMC2CqAUgWw8PrvZ?=
 =?us-ascii?Q?SSwKDGCvwm8rnGtuEpnG/pKemiSXr9pWHRyOVL6UCkRHBiSsrjAdNErHEyw/?=
 =?us-ascii?Q?FMMsUTr4IgvF8gIIZDyxhnSW/3OcvquI1utx9W7WU1yg7dNyJWXB0slpwuzQ?=
 =?us-ascii?Q?zkMzAjyo33IEqK38PUrcWGW4t2DTbbsgI+8UuzUHimz8iTKQvX84KJE1ZqEe?=
 =?us-ascii?Q?8w/ibRC+7uZOYX3OhE07y5zsGjFA1s+1wIcPd/Utn/KPiDpOVdZIxwolZ77T?=
 =?us-ascii?Q?x8vRgbMTyURjzBBH1HaaPSCup9seOUC/FbMNq6DqbKoNPm1qG/qOpERkNISm?=
 =?us-ascii?Q?OqDwbSRJvuGnVC5Mqa1B486JDSMYKqikXskuULHbzEV/+6ljAOY5G6dOfyFy?=
 =?us-ascii?Q?M8HHj8Cz6rL0nA1s6uCWW4MQ+/DWtjohBB4XsTzH26rlC+cTkkcwsQyviwDd?=
 =?us-ascii?Q?FaDwt7w0OyocoQQ9/SPbG/048Du95hln5tp1SrxDHZ9qnjPGOJztOOZSQp19?=
 =?us-ascii?Q?5gTDyu8hBL02LiGEoHLr8fMJzoPGuQUI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7107.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHoE2H9mhSScUaMr+0B+6Ro2DsgQagEVxBcUR4YEp24LzSeGrlKKcyh2jujE?=
 =?us-ascii?Q?DF+2hDbDejuNVxqg8+ySEDlk0xlHlx6EW7JSL7hYIlT0eHT3reZqQgWeGY28?=
 =?us-ascii?Q?0TYH5z3KW+FhAkMuzhQ1ZxUIlCb10Z31CFP5SVx5aOlXlb16FoG8gANE8rB7?=
 =?us-ascii?Q?hydjCMDNm1WsjNMbDu0BcXEP0JpGp6CD/LSPAA4lyHDKlIUQlXSgiuOiKHcO?=
 =?us-ascii?Q?8A5oyVuGTo8nnTwXE8qRhV2RxzgD1tXqV4f7QMFaE2te84X4xF4eGEPnh2Vv?=
 =?us-ascii?Q?ffU0cgXd22cUu4zaNMywauqMYWMdoqOIXx8HWAfVcR86ErTbgwSTqCJi7i/h?=
 =?us-ascii?Q?Nas59UaUdk1tR/jzp40ivLQ0h1iTPDqe/VWnL9vNEopzkyFbZxfmBVcIdPmR?=
 =?us-ascii?Q?hz+/fGup5Gng3ukfn6Oz/q64DLrqPjhQipvo/kcG23QUsm0ulOosgz6tgg05?=
 =?us-ascii?Q?h0CoMaFou4QyFpjk76j2haVBfxAHHo8KLUIA/fBV9d80GGXNAh2P4CFaO8qG?=
 =?us-ascii?Q?r9lSapVqvqp+XvX3B4gZC0/G2V02sRbqSNPJ5NMwEh7BQ3EZzFbg1j7B5w0/?=
 =?us-ascii?Q?/Y4lhZ2TPILZKeApDalDQTCseOyJ8YOsVqEvE0yR8+y2mWdH0tv1V89PvmNB?=
 =?us-ascii?Q?qDBdn1ennj95d9Om/UEeFmm1GcLIF2vvr+SLwTFWTOXav8rc3vJJdE2PoWfV?=
 =?us-ascii?Q?WyFM2CNkeFvP+l2oKvQWVRMCZuC7QJPETj6KWWad9nyP36iLnRdDbXQ3L1tX?=
 =?us-ascii?Q?PX5F/ebibtPbYpgfw51DPEG64H5GFaXUGZOxtUPamckSnJH7p4au8CBtQiSS?=
 =?us-ascii?Q?JG/gM7GHUe4t1NpL1HA6O7K2ho6e38WlG7g3G141S+6pst1Uvr4gPOfckJSW?=
 =?us-ascii?Q?K/h7DFXfPpDMBC/gNWgPEYGBrO7jrfkCTdW3VJh91Cf6QzomNWw3CJQVf9ev?=
 =?us-ascii?Q?JVozoWiBsHHFjmikwrr1iYlvzZTBKlRjdod/b019hOfcKEGV2jokyNSYKOno?=
 =?us-ascii?Q?2+QqdZ/aXBquCIvCzrkoOzdnWxINewZmsCnmIF6rdfIpB172r61GZqEfICFn?=
 =?us-ascii?Q?FPXkSLFGZEAWf1l3ci5Y2tO8gTPCaaYXrB3B79g3iyqHXuU1H6fN+6TQm38a?=
 =?us-ascii?Q?u4OJRuYF2tPITHi8D0YBVjneDq5c/AyxV2m25w4Qxg9nuiVS4PZQIr3eVoKj?=
 =?us-ascii?Q?IzlBi6aNpDRW2/ZoFYWct0q0druA2X7FeBaf8hMXpEvxltCS9erpRnu1D9a5?=
 =?us-ascii?Q?A+gmLFqUfBt3DIqSPZuybLGMr+kZ3lR2jKJCOMxe4pB41HZrQCtysVzbE/TE?=
 =?us-ascii?Q?c7e2S+QNr00H4GNC4Za3LjI1sTczgVrWyAnA5ybSk2yhg7tG3aZJCgGS1G5v?=
 =?us-ascii?Q?ApG2W80YABx/mo4W4cvWVcQWdzyiQjbDGsOMvb002lZoOV7jX7qUnBDX3B20?=
 =?us-ascii?Q?fzkCLAz9YKeFBPPSxrWjL93bY3fIfnf+OK9wLN0EmmpO5oZhO1JSUzMieNf5?=
 =?us-ascii?Q?ow5XLf+7QDq6SFdHdBrZA+m+m9ww00rrJ+C16seAzDy9RhY3DBHV8OtPfbuX?=
 =?us-ascii?Q?q5a9gTJjVs4jHwLVcEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7107.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348907ce-6235-4e3c-9103-08dd5848bdf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 22:39:20.3885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alZ3vTQf3vFDIgaImC3+o2B3mlPU0gaszinSUDFLpwD5ASBI+VGyXWwASEwbMT/6WuM1nikdfEnPXseBk9AOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, February 27, 2025 2:47 PM
To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists=
.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API

[Public]

Overall lgtm.
A comment and nitpick below.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 26, 2025 2:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
>
> Update pm_update_grace_period() to more cleaner
> pm_config_dequeue_wait_counts(). Previously, grace_period variable was
> overloaded as a variable and a macro, making it inflexible to configure
> additional dequeue wait times.
>
> pm_config_dequeue_wait_counts() now takes in a cmd / variable. This
> allows flexibility to update different dequeue wait times.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++--------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 26 ++++++++-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 56 ++++++++++++++-----
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 28 ++++++++--
>  6 files changed, 120 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 94b1ac8a4735..cc7465f9562a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -42,6 +42,8 @@
>  /* Size of the per-pipe EOP queue */
>  #define CIK_HPD_EOP_BYTES_LOG2 11
>  #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
> +/* See unmap_queues_cpsch() */
> +#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>                                 u32 pasid, unsigned int vmid);
> @@ -1745,10 +1747,7 @@ static int initialize_cpsch(struct device_queue_ma=
nager
> *dqm)
>
>       init_sdma_bitmaps(dqm);
>
> -     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +     update_dqm_wait_times(dqm);
>       return 0;
>  }
>
> @@ -1844,25 +1843,11 @@ static int start_cpsch(struct device_queue_manage=
r
> *dqm)
>       /* clear hang status when driver try to start the hw scheduler */
>       dqm->sched_running =3D true;
>
> -     if (!dqm->dev->kfd->shared_resources.enable_mes)
> +     if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_INIT, 0 /* unused */))
> +                     dev_err(dev, "Setting optimized dequeue wait failed=
. Using
> default values\n");
>               execute_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD);
> -
> -     /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> -     if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_apu &&
> -         (KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))) {
> -             uint32_t reg_offset =3D 0;
> -             uint32_t grace_period =3D 1;
> -
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> -                                             grace_period);
> -             if (retval)
> -                     dev_err(dev, "Setting grace timeout failed\n");
> -             else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
> -                     /* Update dqm->wait_times maintained in software */
> -                     dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                                     dqm->dev->adev, dqm->wait_times,
> -                                     grace_period, &reg_offset,
> -                                     &dqm->wait_times);
>       }
>
>       /* setup per-queue reset detection buffer  */
> @@ -2261,7 +2246,14 @@ static int reset_queues_on_hws_hang(struct
> device_queue_manager *dqm)
>       return r;
>  }
>
> -/* dqm->lock mutex has to be locked before calling this function */
> +/* dqm->lock mutex has to be locked before calling this function
> + *
> + * @grace_period: If USE_DEFAULT_GRACE_PERIOD then default wait time
> + *   for context switch latency. Lower values are used by debugger
> + *   since context switching are triggered at high frequency.
> + *   This is configured by setting CP_IQ_WAIT_TIME2.SCH_WAVE
> + *
> + */
>  static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>                               enum kfd_unmap_queues_filter filter,
>                               uint32_t filter_param,
> @@ -2280,7 +2272,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>               return -EIO;
>
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             retval =3D pm_update_grace_period(&dqm->packet_mgr,
> grace_period);
> +             retval =3D pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_SET_SCH_WAVE,
> grace_period);
>               if (retval)
>                       goto out;
>       }
> @@ -2324,8 +2317,8 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>
>       /* We need to reset the grace period value for this device */
>       if (grace_period !=3D USE_DEFAULT_GRACE_PERIOD) {
> -             if (pm_update_grace_period(&dqm->packet_mgr,
> -                                     USE_DEFAULT_GRACE_PERIOD))
> +             if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
> +                             KFD_DEQUEUE_WAIT_RESET, 0 /* unused */))
>                       dev_err(dev, "Failed to reset grace period\n");
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..917717cfe9c5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,7 +37,6 @@
>
>  #define KFD_MES_PROCESS_QUANTUM              100000
>  #define KFD_MES_GANG_QUANTUM         10000
> -#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
>  struct device_process_node {
>       struct qcm_process_device *qpd;
> @@ -359,4 +358,14 @@ static inline int read_sdma_queue_counter(uint64_t _=
_user
> *q_rptr, uint64_t *val
>       /* SDMA activity counter is stored at queue's RPTR + 0x8 location. =
*/
>       return get_user(*val, q_rptr + 1);
>  }
> +
> +static inline void update_dqm_wait_times(struct device_queue_manager *dq=
m)
> +{
> +     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> +                                     &dqm->wait_times,
> +                                     ffs(dqm->dev->xcc_mask) - 1);
> +}
> +
> +
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 4984b41cd372..dd19ae40f0ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -396,14 +396,29 @@ int pm_send_query_status(struct packet_manager *pm,
> uint64_t fence_address,
>       return retval;
>  }
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod)
> +/* pm_config_dequeue_wait_counts: Configure dequeue timer Wait Counts
> + *  by writing to CP_IQ_WAIT_TIME2 registers.
> + *
> + *  @cmd: See emum kfd_config_dequeue_wait_counts_cmd definition
> + *  @value: Depends on the cmd. This parameter is unused for
> + *    KFD_DEQUEUE_WAIT_INIT and KFD_DEQUEUE_WAIT_RESET. For
> + *    KFD_DEQUEUE_WAIT_SET_SCH_WAVE it holds value to be set
> + *
> + */
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct kfd_node *node =3D pm->dqm->dev;
>       struct device *dev =3D node->adev->dev;
>       int retval =3D 0;
>       uint32_t *buffer, size;
>
> -     size =3D pm->pmf->set_grace_period_size;
> +     if (!pm->pmf->config_dequeue_wait_counts ||
> +         !pm->pmf->config_dequeue_wait_counts_size)
> +             return 0;
> +
> +     size =3D pm->pmf->config_dequeue_wait_counts_size;
>
>       mutex_lock(&pm->lock);
>
> @@ -419,13 +434,18 @@ int pm_update_grace_period(struct packet_manager
> *pm, uint32_t grace_period)
>                       goto out;
>               }
>
> -             retval =3D pm->pmf->set_grace_period(pm, buffer, grace_peri=
od);
> +             retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer,
> +                                                          cmd, value);
>               if (!retval)
>                       retval =3D kq_submit_packet(pm->priv_queue);
>               else
>                       kq_rollback_packet(pm->priv_queue);
>       }
>
> +     /* If default value is modified, cache that value in dqm->wait_time=
s */
> +     if (cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> +             update_dqm_wait_times(pm->dqm);

Conditionally store the optimized default value for WAIT_INIT only if confi=
g_dequeue_wait_counts succeeds.
[HK]: Thanks will add that

Also does this permanently leave optimized settings in HW different from in=
itial golden settings?
Not sure if this kind of footprint matters in the end.
I'd assume that anything like a gpu reset, driver reload or dynamic partiti=
on change would reset those registers back to non-optimized settings anyway=
s.
Can't really think of a situation where this would be a problem at the mome=
nt ...
[HK]: start_cpsch() gets called after reset or driver reload. So this value=
 will be set to optimized value. I also don't see this as in issue

> +
>  out:
>       mutex_unlock(&pm->lock);
>       return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d56525201155..9cb21af1d0af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -297,23 +297,51 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>       return 0;
>  }
>
> -static int pm_set_grace_period_v9(struct packet_manager *pm,
> +static inline void pm_build_dequeue_wait_counts_packet_info(struct
> packet_manager *pm,
> +                     uint32_t sch_value, uint32_t *reg_offset,
> +                     uint32_t *reg_data)
> +{
> +     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> +             pm->dqm->dev->adev,
> +             pm->dqm->wait_times,
> +             sch_value,
> +             reg_offset,
> +             reg_data);
> +}
> +
> +static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
>               uint32_t *buffer,
> -             uint32_t grace_period)
> +             enum kfd_config_dequeue_wait_counts_cmd cmd,
> +             uint32_t value)
>  {
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
>
> -     pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -                     pm->dqm->dev->adev,
> -                     pm->dqm->wait_times,
> -                     grace_period,
> -                     &reg_offset,
> -                     &reg_data);
> -
> -     if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> +     switch (cmd) {
> +     case KFD_DEQUEUE_WAIT_INIT:
> +             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> >gmc.is_app_apu &&
> +                (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)=
))
> +                     pm_build_dequeue_wait_counts_packet_info(pm, 1,
> &reg_offset, &reg_data);
> +             else
> +                     return 0;
> +             break;
> +     case KFD_DEQUEUE_WAIT_RESET:
> +             /* function called only to get reg_offset */
> +             pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset=
,
> &reg_data);
>               reg_data =3D pm->dqm->wait_times;
> +             break;
> +
> +     case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
> +             /* The CP cannot handle value 0 and it will result in
> +              * an infinite grace period being set so set to 1 to preven=
t this.
> +              */
> +             if (!value)
> +                     value =3D 1;
> +             pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_of=
fset,
> &reg_data);
> +             break;

Return -EINVAL on default case for safety.
[HK]: Thanks will add that

Jon

> +     }
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> @@ -415,7 +443,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -423,7 +451,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> @@ -434,7 +462,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources          =3D pm_set_resources_v9,
>       .map_queues             =3D pm_map_queues_v9,
>       .unmap_queues           =3D pm_unmap_queues_v9,
> -     .set_grace_period       =3D pm_set_grace_period_v9,
> +     .config_dequeue_wait_counts =3D pm_config_dequeue_wait_counts_v9,
>       .query_status           =3D pm_query_status_v9,
>       .release_mem            =3D NULL,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process_aldeb=
aran),
> @@ -442,7 +470,7 @@ const struct packet_manager_funcs
> kfd_aldebaran_pm_funcs =3D {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D sizeof(struct pm4_mec_write_data_mmio),
> +     .config_dequeue_wait_counts_size  =3D sizeof(struct
> pm4_mec_write_data_mmio),
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D 0,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 347c86e1c378..a1de5d7e173a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources          =3D pm_set_resources_vi,
>       .map_queues             =3D pm_map_queues_vi,
>       .unmap_queues           =3D pm_unmap_queues_vi,
> -     .set_grace_period       =3D NULL,
> +     .config_dequeue_wait_counts     =3D NULL,
>       .query_status           =3D pm_query_status_vi,
>       .release_mem            =3D pm_release_mem_vi,
>       .map_process_size       =3D sizeof(struct pm4_mes_map_process),
> @@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs =3D=
 {
>       .set_resources_size     =3D sizeof(struct pm4_mes_set_resources),
>       .map_queues_size        =3D sizeof(struct pm4_mes_map_queues),
>       .unmap_queues_size      =3D sizeof(struct pm4_mes_unmap_queues),
> -     .set_grace_period_size  =3D 0,
> +     .config_dequeue_wait_counts_size        =3D 0,
>       .query_status_size      =3D sizeof(struct pm4_mes_query_status),
>       .release_mem_size       =3D sizeof(struct pm4_mec_release_mem)
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59619f794b6b..4c8026947a73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1392,6 +1392,24 @@ int pqm_get_queue_checkpoint_info(struct
> process_queue_manager *pqm,
>  #define KFD_FENCE_COMPLETED (100)
>  #define KFD_FENCE_INIT   (10)
>
> +/**
> + * enum kfd_config_dequeue_wait_counts_cmd - Command for configuring
> + *  dequeue wait counts.
> + *
> + * @KFD_DEQUEUE_WAIT_INIT: Set optimized dequeue wait counts for a
> + *   certain ASICs. For these ASICs, this is default value used by RESET
> + * @KFD_DEQUEUE_WAIT_RESET: Reset dequeue wait counts to the optimized
> value
> + *   for certain ASICs. For others set it to default hardware reset valu=
e
> + * @KFD_DEQUEUE_WAIT_SET_SCH_WAVE: Set context switch latency wait
> + *
> + */
> +enum kfd_config_dequeue_wait_counts_cmd {
> +     KFD_DEQUEUE_WAIT_INIT =3D 1,
> +     KFD_DEQUEUE_WAIT_RESET =3D 2,
> +     KFD_DEQUEUE_WAIT_SET_SCH_WAVE =3D 3
> +};
> +
> +
>  struct packet_manager {
>       struct device_queue_manager *dqm;
>       struct kernel_queue *priv_queue;
> @@ -1417,8 +1435,8 @@ struct packet_manager_funcs {
>       int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
>                       enum kfd_unmap_queues_filter mode,
>                       uint32_t filter_param, bool reset);
> -     int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer=
,
> -                     uint32_t grace_period);
> +     int (*config_dequeue_wait_counts)(struct packet_manager *pm, uint32=
_t
> *buffer,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd, uint32=
_t
> value);
>       int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>                       uint64_t fence_address, uint64_t fence_value);
>       int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1429,7 +1447,7 @@ struct packet_manager_funcs {
>       int set_resources_size;
>       int map_queues_size;
>       int unmap_queues_size;
> -     int set_grace_period_size;
> +     int config_dequeue_wait_counts_size;
>       int query_status_size;
>       int release_mem_size;
>  };
> @@ -1452,7 +1470,9 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>
>  void pm_release_ib(struct packet_manager *pm);
>
> -int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod);
> +int pm_config_dequeue_wait_counts(struct packet_manager *pm,
> +                     enum kfd_config_dequeue_wait_counts_cmd cmd,
> +                     uint32_t wait_counts_config);
>
>  /* Following PM funcs can be shared among VI and AI */
>  unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size=
);
> --
> 2.34.1


