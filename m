Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C8C44515
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 21:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B5110E29A;
	Fri, 17 Jul 2026 21:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="skRc5K1p";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557F110E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 21:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2kx9Uqj4/QTB6P4sgbQi7JwdYmrWumXmYEGqaEwypNj9ubWZSsj0W1/r31eyHfdKMXE9kbqx7R3LhNo41e2Hur2ea8+OWUpYLi3/K6vidtTCWNi7SOmnqS8Y+NKLEjtwiksSGd+FaH+8fRj/7UUYodX3E3NR/WoLXSws2PDe0lpeQeDOtGH6am3LsSnJ1V5nphcN4tpFUPrBNFziyjhFlVlRrXNWnPuYki+7jn+XZnyL1y4a9ERAlJLO7P+UiPYFM6UxnEyMgB6DNecSiiF3k5qwariUuJspkwcA9VRs+gx38Fulhvm8c09fp5d7brh5U633trwg4ay4jBnlz4nEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqw2YSfU2t64qnvbwC+NRllxpklhi6DbOYeWV3zYiwU=;
 b=ygY+O99mf5APEvvl5DBResYBTS56IqJM0FqB4G44l0qUbqq2RADN8rf6YwIsK1IddCRe2mJlAIE+J5xTh3FbpzHD76x1b3aX2Yzudt8t3U7uoDF7X9jWSzUov8uoM7y9xw22dAfVmCKQ/xoO2OX8MEYan0okvRInzizln0rYJzrtLx9VAPjbkIYw1DK5g6ZjndO5hhJM0wi8f0lWrUG51vOukS2lYuZPUHGo+0VWjg1fQC6SiD9o4mdUFSfs6oLhs935EN4x2LY1rf+AWvRYKvh4p7U0yp4adIkB7A2UMVm0QJzR0subOPPRJGr+A33shtyBtYbFePDumZzBVADWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqw2YSfU2t64qnvbwC+NRllxpklhi6DbOYeWV3zYiwU=;
 b=skRc5K1pzWMhVxLxfvtsWvTSGdH5yhblKHDqLvfv/6IOEAjHxpCnqqoRUnqm6OJZ9zYkDE1DpA9n0s9chRPUSS+9WEMu6Tb9k1eaqjsxCVYQ1dbKYe9X+Gqpl0EleLsHbrrye18o5FC4GJPx6nssaW2V0J6+4NkuF3bGr0t95cU=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:20:27 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 21:20:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Soliman, Fares" <Fares.Soliman@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liang, Richard qi" <Richardqi.Liang@amd.com>, "Soliman, Fares"
 <Fares.Soliman@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdEstDjnYbchErT0+RAvNGr4UUibZyPnZg
Date: Fri, 17 Jul 2026 21:20:27 +0000
Message-ID: <BN9PR12MB51464FFC1E39FC0777D45524F7C62@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260713132624.1173426-1-Fares.Soliman@amd.com>
In-Reply-To: <20260713132624.1173426-1-Fares.Soliman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-17T21:20:06.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SN7PR12MB7345:EE_
x-ms-office365-filtering-correlation-id: 64ef3173-7b67-446a-f260-08dee4493935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: mabrHv7obasvUGjud7WwXoXrD5wmqR9QfMbLYu0/hd6E6KHSJ+OB/aEdXhSd4/HVUm1VLjIoz3a2nB2wa4QDHvRI+/Z9+CsCjJ7BUJusB1CgtPclze15+l6TucOukeUtVmzzCE1OLg8tOMEBtuHn43gYk3JmAMGFNRjW6n9ML0/UHONlumbCUGga3guadbcujqWltcEyAtK6tzClTza8IgbRNd6I4bwumvHNlGjSPvOHoFUrhdj/LBjLaSq48eoj/WIngMpssF4OJdgjf7S1LmNFJhh4LNPH13pArnag35ZBwL6wROWrPvMyki2fzV1quhdhZPdzndP7/nOmuV7XUWG2qp7i7sbHrFsWoQuSdAjQdUrvHSUdtd+pE4kuqVbuvcagOaYMrGmtmZRVMai8wANs+rEGtacTBE19TkO5gdRvdwr+OYx99K+wMIIcq3P/Ig5ErvQnIwh3q+vAB6R7GAAry6ADRA82/0xhilYSCi06XSeizt96Y+ndDSiBJp6o7IR9MckwPx7K/3mjQJdNb+xCv10vL0IF/1YH0x7N+y92iXF3dKIbrTEMDUQimVQ2PQvCZiUd2kLrSmgRdeTR5odFvJ2Xlc5uYD943reI9oO66W8Cu3YdIUML0KAC2FIDg6scQoBaRPVSQmj+0caTQYrse6PkFjkXBmmow04gvsDPFS0e7R5xlRxNXmcskd2/XRolKf2GSPuylmBEPNENJvH0P7NgQWNIdDgACwV3+6c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UVgZeWLzg2yKxUeGcuij1MwXNW1++F1NXVKzjVqy9jwuIob8C1I42BlIxDAk?=
 =?us-ascii?Q?QPNgBbNrcAGhKS6mFX86Lr163abloCaDZqPY6rJj+6EL4Fd0XFHdilCaM0R8?=
 =?us-ascii?Q?Fs+slE2fV1ZJpNhP28nKmzlDcd/m/Ioy1tI2fAZWcy5vGyxSKBMjecFfzTI8?=
 =?us-ascii?Q?8e5t9+P/h3Ec27bnuLq8ErT2uiszHPBWYHAbRbycmwBLw4+qDTCeqVF563bu?=
 =?us-ascii?Q?hCMf7nLjiyuJPVKirfb2pVVqjbJbjZyjqstETjPdw2bgwxDngdmftUyw4W66?=
 =?us-ascii?Q?FSyrtNVDc+tmfVQISP+FHlnQyaZUWnR4HGpDz8LzcOcPTrgNrGGHua2vdpJu?=
 =?us-ascii?Q?IuaoYyyrNo7KUEdAmRpWz/daBCYbfARfQe0GV5NqILEcc4hTP7YYjCWnaUWq?=
 =?us-ascii?Q?Vb9ZM+CBk1QL4W7l86rDZEf2gOwCkvIfphscwAFsyOV6qj9mBprFWVV+c+ws?=
 =?us-ascii?Q?QSye30UdSgym2N+gMnBaYr0xpzNOQCLqh6iWz3A3CEExAzYGTKNBZEsS5azN?=
 =?us-ascii?Q?yli+iKG9mIbKThzN5XkRrRAF1BRDlvuJXrQfHE/qDdX97cHtYbG9sR7WxKuj?=
 =?us-ascii?Q?gBDAoWheQXzPBCoQcpsPSODRSdG95DBhFV9vDgNNGF8gVmY7/IZKzI0dbMnN?=
 =?us-ascii?Q?SP8Ri0h3+K4K8h4XJ9/xsMDDGsxcx1nrkC2vVoBUt+cvLT3af8g/xm9N4NWz?=
 =?us-ascii?Q?2wlTa7diT88Qd1g1HFp6g64LcF6+4w2KKaC2DoGNClZ2eNSOtsRrmMu5h+6M?=
 =?us-ascii?Q?eO7iyoKqxAsdgtduKYp+YCuYE3GkOuHkd2hWsrX5KD7oERIpcXg4C7qZvKYc?=
 =?us-ascii?Q?6tCH3W0taWE2iuw/JO5WuD/Y7unBizxotN3bQBbiZ/ozklG7vE7TASWO26A/?=
 =?us-ascii?Q?MDuiOOwRB0fBnJfqXL4BHc+IHFQoaETVZ3YV3t2nOUbvZRbFnx9BvV+XvW96?=
 =?us-ascii?Q?N7xe2hbnYuc5+1RyTu8V7QFYVN0D7Cn+k5iV03KX1hIFP5nfW84/hBoFXiyC?=
 =?us-ascii?Q?asYcy6wu74JK4rsTMFwIUSk+m43joRKUD05ZpV5H7csaQTHamg4b7dSRsqKZ?=
 =?us-ascii?Q?yVUHeGnCCdUkq3b1/bUuPkEYZgJbI4ZBuWmTNpfUAknwViyPo+PwIrYeFEdH?=
 =?us-ascii?Q?XoIBTsx5lXDzShw6mhR68ujHOMqlCpQJLHPCW33bdW+WbL/GPKyBjAsNcBOw?=
 =?us-ascii?Q?aLSnB0YMvpDIMkKe63ODGlFpFZVLX21BeNhAkMnoA4j2A8pbbOcTH+PJ3EfF?=
 =?us-ascii?Q?57uStu1QBTZwE5K3z6AkYj88WcrbdI3If1jiAMAIf2hzQulPn9IQPSKupb3X?=
 =?us-ascii?Q?0RzYPyQNOl6vjGJEOMHdl7QGaSgcTmEFNmy4/HstM5zat/SODS40G6t1vUEo?=
 =?us-ascii?Q?zNEh9KKJeIQt7g5oigi+Zl6tf+YCNYaQLL34XLk25CXzbYtwUSt+Yo7nY2Nz?=
 =?us-ascii?Q?STgq7NtwsBOQK82n0+mpACm7ggOg9bQDfg+J9+E3oDVF1MV81tfIJPIkLNKK?=
 =?us-ascii?Q?m/lmpMEa/PFQtQiLhudD/tNdqJQfsH2x8ZeasWHMX7yrrVruQEboQxlEGxqJ?=
 =?us-ascii?Q?NE4Vu1rXRftL46xdd8gNUE09ARxCRdMJ6KCEz3N6xpGgYq3lcinzsCSGcy7G?=
 =?us-ascii?Q?HvZy7tnKWC/L+vnjbyl0vFwAHSyFzKMzzTM0cPSYqnIdlga0J05HXOOQy/b4?=
 =?us-ascii?Q?8EMXjPcPTXPAy8S0L1sOl7GHp+88L1W/qy870V5WsfVz9dgz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef3173-7b67-446a-f260-08dee4493935
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 21:20:27.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bogQC8rdYhMN4tFn27Kjn5slApPtmYHvJWYRCsIAS6ePmh2KcKKs1ZeSlb++KqeFsTHoIo3GsoO93njqLUm/6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Fares
> Soliman
> Sent: Monday, July 13, 2026 9:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Soliman, Fares
> <Fares.Soliman@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
> gather GFXOFF residency logs
>
> Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on
> Van Gogh. Logs are now gathered live rather than starting then stopping
> logging and reading an average value afterwards. This is in accordance to
> changes made in PMFW.
>
> In regards to messageID 0x52, the old interface uses a start/stop paramet=
er,
> and the new one doesn't. The firmware is checked to determine which metho=
d
> to use.
>
> v2: added firmware guard to new interface, old interface kept as fallback
>
> Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
> .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 50
> +++++++++++++++----
>  5 files changed, 50 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5c4d4ff001ea..46514a1faf1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file
> *f, char __user *buf,
>   * @size: Number of bytes to read
>   * @pos:  Offset to seek to
>   *
> - * Read the last residency value logged. It doesn't auto update, one nee=
ds to
> - * stop logging before getting the current value.
> + * Read a live GFXOFF residency sample from firmware. One needs to
> + start logging
> + * before getting the current value.
>   */
>  static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char
> __user *buf,
>                                                   size_t size, loff_t *po=
s)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617..d94e3dcf7f9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1333,7 +1333,7 @@ struct pptable_funcs {
>       u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);
>
>       /**
> -      * @get_gfx_off_residency: Average GFXOFF residency % during the
> logging interval
> +      * @get_gfx_off_residency: Live GFXOFF residency percentage
>        */
>       u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t
> *residency);
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..4206514765cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -110,8 +110,10 @@
>  #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
>  #define PPSMC_MSG_GetGfxOffStatus                   0x50
>  #define PPSMC_MSG_GetGfxOffEntryCount                       0x51
> -#define PPSMC_MSG_LogGfxOffResidency                0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_GfxOffResidencyLogReadSample              0x52
> +#define PPSMC_MSG_StopGfxOffResidencyLogging          0x53
> +#define PPSMC_MSG_StartGfxOffResidencyLogging                 0x56
> +#define PPSMC_Message_Count                            0x57
>
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 636ff90923d9..acf03838d49d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -252,7 +252,9 @@
>       __SMU_DUMMY_MAP(DriverMode2Reset), \
>       __SMU_DUMMY_MAP(GetGfxOffStatus),                \
>       __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
> -     __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
> +     __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
> +     __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),
>       \
> +     __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
>       __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),
>       \
>
>       __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel)
> , \
>       __SMU_DUMMY_MAP(AllowGpo),      \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 717ba46c8933..1104f8b05b29 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -72,6 +72,12 @@ static const struct smu_feature_bits
> vangogh_dpm_features =3D {
>       }
>  };
>
> +/*
> + * SMU support new GFXOFF residency log interface since version
> +4.63.62.00,
> + * use this to get live readings of GFXOFF residency  */ #define
> +SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00
> +
>  static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,
>               0),
>       MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,
>               0),
> @@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(GetSlowPPTLimit,
> PPSMC_MSG_GetSlowPPTLimit,
>       0),
>       MSG_MAP(GetGfxOffStatus,
> PPSMC_MSG_GetGfxOffStatus,                                            0),
>       MSG_MAP(GetGfxOffEntryCount,
> PPSMC_MSG_GetGfxOffEntryCount,                                        0),
> -     MSG_MAP(LogGfxOffResidency,
> PPSMC_MSG_LogGfxOffResidency,                                 0),
> +     MSG_MAP(StartGfxOffResidencyLogging,
> PPSMC_MSG_StartGfxOffResidencyLogging,        0),
> +     MSG_MAP(GfxOffResidencyLogReadSample,
> PPSMC_MSG_GfxOffResidencyLogReadSample,       0),
> +     MSG_MAP(StopGfxOffResidencyLogging,
> PPSMC_MSG_StopGfxOffResidencyLogging,         0),
>  };
>
>  static struct cmn2asic_mapping
> vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2450,19
> +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu,
> static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool
> start)  {
>       int ret =3D 0;
> -     u32 residency;
>       struct amdgpu_device *adev =3D smu->adev;
>
>       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>               return 0;
>
> -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_LogGfxOffResidency,
> -                                           start, &residency);
> -     if (ret)
> -             return ret;
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             u32 residency;
> +
> +             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                     start, &residency);
> +             if (ret)
> +                     return ret;
>
> -     if (!start)
> -             adev->gfx.gfx_off_residency =3D residency;
> +             if (!start)
> +                     adev->gfx.gfx_off_residency =3D residency;
> +     } else {
> +             if (start) {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StartGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             } else {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StopGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             }
> +     }
>
>       return ret;
>  }
> @@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct
> smu_context *smu, bool start)
>   */
>  static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_=
t
> *residency)  {
> +     int ret =3D 0;
>       struct amdgpu_device *adev =3D smu->adev;
>
> -     *residency =3D adev->gfx.gfx_off_residency;
> +     if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +             return 0;
> +
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             *residency =3D adev->gfx.gfx_off_residency;
> +     } else {
> +             ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                             residency);
> +     }
>
> -     return 0;
> +     return ret;
>  }
>
>  /**
> --
> 2.43.0

