Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83D2CA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 13:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A74B10EC7F;
	Tue,  6 Oct 2026 13:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpNrcewt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740A010EC7F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 13:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsPf70vK1EoSftxNti2iL1APd9D6BG3CILkcrPSHeEMPgxy7l8Y5nkntIELhlO5PwDq30H8LXn+CjhmYmW7hF3HH6/BaJNU0ft1ouedS0ISECGgfMO9geELlKWYvQN5IuTzS3FnZpGhaHygNJxTQxhRRFMKu8U/b0vSbQh9tE8k01I3enmzJnyncq8QMjiVXuELSH0Hg0WyPAygzpxKk1rdrdp4rtLSxB6x3JjHb06aY2EoZOpb6x7yHF7cFp3TnNRjWqXQ0qqGNediE6X2cAIvr60M8Aey6XhLLHSk8HJENynpuGvx333qNlJMy7CFrlkhMOmtJmpscu90xJb84HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl80DVzD2WddX8AuS1q5IrN5zLDxEvjbz0n788AQFk0=;
 b=yMQRSbyhdNEyIJ76P1w9FbPS5EvL9OTEruC1bMHig9S0bHSmZ1uj6Nn6d0a9QuPY5jEm8MJfrGPzRmyv/ye+wnAMxrwkH478wlxwb4hf96PYdJGQsekUYPuAWQbZEGjvPRYkL69NVwbVRrLkLaB03uV6yd429yYtww1k6mx5XwEz1IOUjxyb47X2VMbgcsmuWorM1dAYJituSDcQCncxuvDQjehISY62T0j2A6hnOXTGRCtH0ggVv3oPKbgupMkOfLDVtWdw53+3ryao3DV0H1W/Gyljjib9EoSSfxw2kv/gaLrKh1gsAq+z3JkWCicDXzwbst4kRQfIsVs+SFZFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl80DVzD2WddX8AuS1q5IrN5zLDxEvjbz0n788AQFk0=;
 b=xpNrcewtYpIrrRDAYLDfPRs7GI1X7x8YE5UbpM3v8MtpDaGPUIKx49IZK+Z0uHIZCMrJsCm825LRp2UvyRmytt+NqreMkUoElqULb8LdTtzel+rS9j37mzLblzSis+79VUuAhYaF1RL5CNxYjjNrwPLe/+V0T+MMLJHlRAs5i64=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:51:22 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:51:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v1] drm/amdgpu: exclude npa_vmid from the userq vmids too
Thread-Topic: [PATCH v1] drm/amdgpu: exclude npa_vmid from the userq vmids too
Thread-Index: AQHdVMj2BdP6tZV7tkSAXzNyVts2UrbwiWAw
Date: Tue, 6 Oct 2026 13:51:21 +0000
Message-ID: <BN9PR12MB514670B4B9D0049C7467CF71F7952@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261005125629.1688549-1-sunil.khatri@amd.com>
In-Reply-To: <20261005125629.1688549-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-06T13:51:09.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|LV3PR12MB9213:EE_
x-ms-office365-filtering-correlation-id: 9b461ea5-cf46-413b-e79d-08df23b0e7b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 6hLZPMDZ5cknDQkhmzVJWyWCPFlqRsclM95MvpvGYPYkpmYZIXGPvuB8rNMcyrETvKJ9aKF/nUg7b/Ebn+WUX8wN2bJRp2qxP7YtoPl7Mapn+GZAvaDvVgetSqSsgxKYdw9eiMVN0msN2gYi4picDABY/MeILT7E1yAosfdyyrwYl8Yngt9UVRJfiB7DDahvCgpGdFBVjEglpXFc/f8QVtKJWeKgZJcGDbLmNUMSFc245YgHUHqO4f3OIw2gW4QqjYNZQsI+GYysA+EvRXOUFQpwRe01p6gItA5k4M1YnD5YkmcupibLvgxNQJMfe4EPpX/xPEWpLeRLAz3bLxXiXmGY8OV806GZV9pYvJRYJDCl6epLosB9+Nf3rzIxON22OcbxHrxiVYOddNAdXXf0qPV5c8cHtWGcsS1yZfTIpj04fRJEyxQgM5DqPWwB6xNSjRBbIsuw7OcmJyEv0DTi476ipruCXsLl34OdUHbQ9lAnAXyyC4aUsgozsASGAmCq+IAlhM3JUkLm96golzsH0G96VOtSA5lPDx3v3Y1fhpX66hIuwGT1bcdEeZTeEuizzMA2y80tiM+dLlYaSrDKruLz7dqKNwpK+yOVsn5BP8OD+IoF4TrN+6DHzd7XodvH6VGwcZWclo7+Qf/9xfZZHgM/sK6VtGuHz0cXs2XypP7u7Y0UHyDUrgvSHktQldIRzFYXHzn5ApdHndn24LBUWPYV1DbSqCg2m1ix6YuJCPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V8UjmVG9IjNr4IaioMVUdYP1ofOkWOV924jpdtJHymZZC7fvEvi/t2Rd2OFc?=
 =?us-ascii?Q?mLZ3JMf0Geog9BZHQQAKdR7+Prba1qGmarWeGaozSiRGvTw8Vz6v5WmQ1ytC?=
 =?us-ascii?Q?1EOawmtK0T6GXJUxUYFVWSJIA5dAIhqc67EnRJCWh6RqQ9aXJRCt3NwpLET/?=
 =?us-ascii?Q?J+sQ3XhWLlmzRBUOCLy04z/qG7xKUn/jIrPUU/w8wLgeLp+gJgx1tU6+AA0q?=
 =?us-ascii?Q?lzk8tX2moYr42OuXuD3rWoM2wctfH31+WXmrL9G/LNVELxWh/+3I2O8GzunU?=
 =?us-ascii?Q?yNrA3JAgXCh66av+GIVRkF03cwaRHDcm5WmkEiHLXfS3Ls6hAW+e00fTIfgc?=
 =?us-ascii?Q?hbvkkGSkXYsUTXY6jL2IQMT7BXINJyLmK2kBZbZrRD4+upHxSN1xB24JdehD?=
 =?us-ascii?Q?jmUbm5yzxoTGFapVkmKfOKDSZqgeqTZb9zv9bNBBMa6SlSBYGtDILHMC+nEy?=
 =?us-ascii?Q?oSr8ZCFWVqBmpZDG/cpluPjyimm3nU2DMSQeZ94w3PCGCdkitIQsdTypWyNy?=
 =?us-ascii?Q?a0dK12ee1OzWIDzSV5bsilKn7u+HRMZyMRz1lVBKTbuAeqPub+OgRdLsJLlL?=
 =?us-ascii?Q?+dfP2LpMVSdD/XcemAty5+5gq9p6WNI0MdIa6wPm8vlM6rLmscy1kOixFCNW?=
 =?us-ascii?Q?PDYGnHVFFuiGtsZ4QXSJCls3WosAHUd9KSOdE/49tQerjrgkC+Ceqs5jqzD6?=
 =?us-ascii?Q?qy5SCoVeM2nUeAltVht8R4SquQ9ZmSiaC0eHfQrRA/2d9P9bx8WvCE6jav+C?=
 =?us-ascii?Q?JJxn6d66BhorMsoySz28bdSS7h/7SkbgZ2nAxOjp5F8a5myskSeyIDNgEoHc?=
 =?us-ascii?Q?C2IZ7s+SYCgFEVFdw/keHfhS40LOJBahr5eW6bEOKh26q+RMTDcfGLk0b1/1?=
 =?us-ascii?Q?+Mi8lJFUT8q7bbXQZS7epFhiqzTarn5EBiibYMgpKkVy/lRcvM9k7U/IYSla?=
 =?us-ascii?Q?f0KEJQkU4PE1IIOigHxDIWunuSlExWdwOCWp1yQ+h63bDdUxzUN8h4/1LMjx?=
 =?us-ascii?Q?+sM8IVJlRNGD5OiOFSVlPu3V9qqzfpKofDecr3x1V3WK/rhd9oDMGxkPF5ZO?=
 =?us-ascii?Q?WeNgaFKHkAE4qDTvYl3AdpGpSpc7A39dwHHpS7YVckNaS5GzofOg5WuGzmlC?=
 =?us-ascii?Q?++mJnkypdeoDpJucNm72v4olNUSoxfnRzTnDPjE0GKYBnl7yBXsp3FL2QJfA?=
 =?us-ascii?Q?bvoSs3ht7ElxebzpTE9V9M6h64NB4LSxW8k6pfx61z9IOo5erJ969XNgFkzW?=
 =?us-ascii?Q?f01D8DDRWUiMBrwSXqwakR7eQ+bxifLSAgUfrKHd8E1cUq10upyScMsEkatg?=
 =?us-ascii?Q?ddDsMTq26jmkSKbMBNrtCl/PfIxpqDic35RZcrziwcKtWUitfz8Z+f9+96zC?=
 =?us-ascii?Q?spAevo5QxLLRXGZuGWBbgj4la0u6oWiySJHQ7flv64rDS1su7hnB5wQiZx/6?=
 =?us-ascii?Q?ttrOAvwDHuoH12h/sQYYUFEIhVcraBijWCpfxLoH4xTva160GI4Xhoey3H+x?=
 =?us-ascii?Q?hLChpjM8vzBjtSEbWbzV0LqoaNAF9APxXglMG7vbgTeyvicUQ8Yno1bPdHAg?=
 =?us-ascii?Q?rVmnnIdkFyKJjVlulovhjz2zJFjANPI4RA/mAa536enkD80uIXBW6NZFJYxx?=
 =?us-ascii?Q?U+hPOmM/Mh9Sjp9iSkYPNnQ+IXAHpArYj7VtmhEhzV9T25Nb85mJA/m92l1p?=
 =?us-ascii?Q?w3naiOLBtnV92jPbj1XLtqObcoaoBA4SYCxtWY/QZfN+Bb0T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b461ea5-cf46-413b-e79d-08df23b0e7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 13:51:21.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNpvKAqGLRz7CopxztBiBVh64p6+RfvZh0Q5DN1A8RoSEZd9dJYpMCF11x0CTm5N9kidKo8v1Yn3roKvxBSeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Monday, October 5, 2026 8:56 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH v1] drm/amdgpu: exclude npa_vmid from the userq vmids
> too
>
> On IP_VERSION(12, 1, 0), we are excluding vmid 15 from the available vmid=
s
> in kernel queues for mmhub but its not exluded from the userqueues mmhub
> vmids and it is a problem.
>

In practice it's not a problem because all of the queues MES manages are co=
nnected to GFXHUB so we wouldn't get a conflict, but still worth fixing.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index ab707b1c7867c..fcc1d580fa946 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -1014,6 +1014,9 @@ static int gmc_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>
>       amdgpu_vm_manager_init(adev);
>
> +     if (adev->vm_manager.npa_vmid)
> +             adev->vm_manager.vmid_uq_mask_mmhub &=3D
> +~BIT(adev->vm_manager.npa_vmid);
> +
>       r =3D amdgpu_gmc_ras_sw_init(adev);
>       if (r)
>               return r;
> --
> 2.34.1

