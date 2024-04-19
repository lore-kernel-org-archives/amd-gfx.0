Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6037FC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 15:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE11510ED98;
	Fri, 19 Apr 2024 15:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OR5HObis";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB40010ECBB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 15:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXF9t+k171cOV5x/0Pg4BIqTjhf/eBnMs3nmy9SHDAjRTvXlKIiGZX7Kh8QCXoXKBi7D4aMdA2dDXsMUOq7pFLfXZqQcEydEw3PjPv1mmgOLwale16pkJfugpNI99ak1ZS0H23xD8VJil6IxDk4BBBxhuT3frShruv4FiK/MP4FZcoA7ub5jAzPIeVSmkUVFJaF9CpTIC9ujBSi+zD+ohC94NyZZAlhmRqv9DX7+Xxmco7L26nYLeaqnQRNkcwLo5wTBcEt/ZNFPceypgGN/zCIOWdAqphrDLFxuosrchh6DVLNo3UY+qRpuTU5URpLJWlbWXOY4zXJxuOzONlBPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NavRsiQvbT417yEwT4yNtAuqS4ZdtjG6ZJMbDj59+Co=;
 b=Ha5of438NdoBb6bnSZy4XE55Wv2eAU1BcmYAfKY6e0Wi6zqGN3H6MNVSIAqR3x5M/x8iJb8pdAe3Cf1fQ8nuZNk4HKkBPv7sjo+Tt0NhDULezui7Cs93TKYp4AxaB2Zhb0bPZhNXKj58SRRD1GLmAUDQf4fIVffH0kyLdQGDvWIiM8Vsv5T2q0I9MqPWPjdSW4jK6py7RbsfKoNEk9luspbaB1TmyBkLEqhcHYdXgnRibR8O1JjwoBFbf9rcM1aE1i4XsVfq+7m5dPIeP2612ZfRZEflx09F3xpkxM5mDWx8yNu+6WoJzmIHraHb6haDOkfZmN5D/z1yPNfKss0zTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NavRsiQvbT417yEwT4yNtAuqS4ZdtjG6ZJMbDj59+Co=;
 b=OR5HObisY9bQH6EU2TSdh4HtpbJ/DmDlNSlXUIcN+EnpgQWSzamxUgbRJD1oIU6kvhgr4pU2z5wTMyEfFzs7b2Rz7dTxFhJsiZw6Xxg8ZqC1vQNlkEWsTUxLz0aDg8Ga56DVrvk8DoPMkmpEigYSihgHcUYKukyPpg1XEPaWM/4=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 15:04:51 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::46:75b:a3ad:d2f1]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::46:75b:a3ad:d2f1%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 15:04:51 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: demote unsupported device messages to dev_info
Thread-Topic: [PATCH] drm/amdkfd: demote unsupported device messages to
 dev_info
Thread-Index: AQHakmJAaASJDiT2DEq1uPS+cd3Pl7FvsN7A
Date: Fri, 19 Apr 2024 15:04:51 +0000
Message-ID: <BL1PR12MB58989DABDF0A3F8C73D80C1A850D2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240419140124.1900789-1-alexander.deucher@amd.com>
In-Reply-To: <20240419140124.1900789-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f9fbd860-2408-4974-809b-4b9100b0839a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-19T15:04:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS0PR12MB7771:EE_
x-ms-office365-filtering-correlation-id: 2786a11e-5c7c-47e2-647b-08dc60821023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?Oc9qJIhAi7Cxv5qznkC4TuB5j+fXmtA9rNAukCSaw4OVrn76a1fxPkpkRxap?=
 =?us-ascii?Q?kNKDZFFZ/cFcqM4J6vlS3vyvLCkGMjTZJ3RsiRpAI5KemgY8tWBwgCx1X7LH?=
 =?us-ascii?Q?QHQnAv5s6JiBf6+CH9RT5B4jaUOTdLttgD15qRajo7PHSsVPgtI3Ieot43gM?=
 =?us-ascii?Q?0UjPjUOqfcz6i7MOsMEnoX5BApB0WuMUp1V+/cA91A3KMXjHo3W9TmMMTc7e?=
 =?us-ascii?Q?82U0tGzq9Iiy4Kb8kwBLqaw/7EPNMch9Jk3w9jMV1+5IQPQhVy7ZSyVuvati?=
 =?us-ascii?Q?HEtIEXQIhY+End9aC0BB4heTooW4mocWiP7fiGP7yLcOiFsoYkL8hgMrlFx9?=
 =?us-ascii?Q?Hd3hmrsMTwXLo13P7SybaOdX11kayfkbKB3lWlPilerj3VJirv5SRN9h+VLT?=
 =?us-ascii?Q?zBUqunGRe2t5MB54w6ojieU5eUJY6/WK0wwe5goEPfpQmv5RLNIVVqbzAHxP?=
 =?us-ascii?Q?D3kcixkz0PrwNdBQEqKFDH92/6aUI9m0n5rJk/kMFLqDUU7cEbcN4iuHSIQJ?=
 =?us-ascii?Q?92MbuRn+bJhg0HGnrDV6sertXnxkgCvjnpqKORi65lFOI4fyZjjWHuTQJNuH?=
 =?us-ascii?Q?Zt/aqIB25ZRqDQxfAC339PagrdnwrD9CyWyDdM3vnUDKzK6c8hkoHiWECFR1?=
 =?us-ascii?Q?4ljOrxMnClNkoln3JaxjuOaHScLdaVB/I2/0Z+KXsyEba7WaC0/f/2VjK1WV?=
 =?us-ascii?Q?jOtiW/cYEhf5fCLMNhC3Z+Cl+XHkF9ghAW5j4IR/K+6VTJBEfcI9Ux2wpS24?=
 =?us-ascii?Q?cDl/0aPrQxDXrPw7yKDSnDFQRhu1oA4dII5N3eJWT8cvsQZweEeVq/K5NfiC?=
 =?us-ascii?Q?zcSXEXjeAhkDFhoQFIEmWoX78sufaEkS5WlGczXM3+ppEq4+umW4MrFtFTYU?=
 =?us-ascii?Q?GRpCHZFssxb68dEOmaozIlFd3FFoK0vR/qCDNfqDrJljVOaEV2v2MezasRZ3?=
 =?us-ascii?Q?SGg/R5jKR1xeDfSuZbezjSD4lsx4c/VnT6rLYKXwEBwXMCSDf0jt/M6VWOw3?=
 =?us-ascii?Q?lUEOpxjU8sEd/IM9InookYomlc+l2Cc0YzkgIifS5YVOGLc7eDmAeIfj32Ol?=
 =?us-ascii?Q?3u6Jm06jgHSj2A9IvQKbfEh7HDDmVOyHgTF12QqJkkPCv7cPa5Vqsh1KKJr7?=
 =?us-ascii?Q?sfYkZfFQydMJExmEFCOPz2gQ2kvhImh9rF/2aTL6x+r5LgByJveIX5FwFVAf?=
 =?us-ascii?Q?AFK/HQlOqxjUcUjjTlqU3X4M2ORptnIEgIPKYI7g456ilVrRTxPctDgUsMDe?=
 =?us-ascii?Q?ZXYJifWQdfb8bA4TVCm1C68LJ123wvCmMn4qbLGN8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nkif7gPM6DhryVa4PVy6/yIeAkRLfTKXeyIEGO9DywcPhfToehsJw5ZIfCd5?=
 =?us-ascii?Q?kaNMwqY3xaVZHQzskk654KW6yUAeJWlHEnUv952MiZZSwVdRh/XEKJedNnh1?=
 =?us-ascii?Q?FarNB1j7Ou5pnSJT9nv8NIX7Q1pFlt6VOF/8PcqeHnC2Qkc93TkJ2TbnHYk+?=
 =?us-ascii?Q?XlekO9EHRZrlHosCet24OIewub6SRUSy+0awCFko+KYDzEpdSY8LqLfswAGr?=
 =?us-ascii?Q?mHYcJfvoS0w9bZ7lKzCQf/+pMd8mcR1/eP9F3bU+PkoRrmOKZocHg3E6yuiF?=
 =?us-ascii?Q?9g5Hi2IoZ1ntHIOvSNiMun3BcXHEhqcpO4SQRD7LvLhPl3Qbh+SKXLu4iiuv?=
 =?us-ascii?Q?/qS3HZQcHElzq7xcWkEelo5mkzAOfiIukFtV0TsEnPzi89CoTjk0sMESNLYQ?=
 =?us-ascii?Q?ag0kala3xZeWXVtN1jHVkS1MzF6v3oxSsNmReci9B2h8+DhdRDVZdDPLXwUw?=
 =?us-ascii?Q?oSzqfEAzdyMChBPNSFcrM3WWHy0pu8ikfn9SQQRi59OZv+YCJRzoAZAGNB8s?=
 =?us-ascii?Q?jZChB/KuwxhUtJBA0UdDKARorbV8F53OrRPRoFHqOQZEt11jYVkTc3aQ78G2?=
 =?us-ascii?Q?i0okCjqp5oDnMw2v168qxk2VtWoTQqkOtuSv/wmRNF9fk0rQsRRHOBO33S3x?=
 =?us-ascii?Q?gr0ajuKdT9BV4MhVrAws3jl0Ct1LYu+/FNnz/4SFPpp2NoT6al1zkKEjflBX?=
 =?us-ascii?Q?bH8OhnmefuJ2hTgIQuU4vAnqoMivnVrxigAI28k0U1o1rRdm9xnI+p/eaIOx?=
 =?us-ascii?Q?Zw7a08AtuAiyAd4MELw9pq/foHYr3fw/RuIcFgxlhkywXh+L5ww7VP7w/bIh?=
 =?us-ascii?Q?SvWP4x3KnVS65Jb0vtJ/JkYwOGW02HESg2HEGov8Tddi+WMjEAy5BcukywPr?=
 =?us-ascii?Q?exo3aoewJ2MRReBMh6rFAEus/bBA6x5jDCzHtqrDw7P55d/RKVamIKVqvu8d?=
 =?us-ascii?Q?49OLQUnW57pKrQVcmh99CdpZZ1aeDsI1+3ZGJiwyfyunztQaMkf+rK9Y1uJG?=
 =?us-ascii?Q?m8N4lPhfjf1a23Pod98Tb6STmko/qPUMsAmz8n7CoIQSqAICTXUMnDuvRvx2?=
 =?us-ascii?Q?KtXGaKRqYHablsU4ECe1xhAD1pBUtBptN0/pvQV3AuX3XrnTxApvk5Y0C6LC?=
 =?us-ascii?Q?HjUQyJbztxyYoWTW3cehe8DfqoUus1qx2jOoErLM8DOE0hNdJ2d9xMSbh1+h?=
 =?us-ascii?Q?BIv0pqR/ObeTIwurVm4J0XGVymeu3eBJ9h9YlPTVnAkvffHZpR2yCV4FgU+P?=
 =?us-ascii?Q?Ugely6z5r5wmsjsk2fCrNNQT7uwCD+jW9oTvvsoRw3vql7KFiETf0daXso4B?=
 =?us-ascii?Q?uny+cz+ZGHkBh8MKiARAYRtp2qXu1agdxnNPwJNklmA8nyTDoMoiyAWoanNS?=
 =?us-ascii?Q?rJNh7YApsYE7ZbWJlgmx3ua4hwfOZ/8asnS7w+HOsKqXH+QI9EVVRHHOwdxO?=
 =?us-ascii?Q?kVxpQOI/5c/F16zxnk+gB4F90h4/p3eqAaDvMT0W0HjDNo5NObZGLnlA36au?=
 =?us-ascii?Q?XDgNzMrE2x+n9pD1uzSnxL/VitzepZfZCo9CEHODUlLfgJmWjW+CJUnCoVMo?=
 =?us-ascii?Q?epDLztls4ahPJgKDlyA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2786a11e-5c7c-47e2-647b-08dc60821023
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:04:51.2420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4fSLaXliZ0VKW3Hrh6jZHVNDFzKpguJif5kMAmobR/YW6S3LBG018AjGaFWk1AvOTsf/7IzzVd7O0Heaw+2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

[AMD Official Use Only - General]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, April 19, 2024 10:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdkfd: demote unsupported device messages to dev_in=
fo
>
> It's not really an error since the devices don't support
> the necessary hardware functionality.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3331
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 719d6d365e150..9596bca572129 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -435,12 +435,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device
> *adev, bool vf)
>
>       if (!f2g) {
>               if (amdgpu_ip_version(adev, GC_HWIP, 0))
> -                     dev_err(kfd_device,
> +                     dev_info(kfd_device,
>                               "GC IP %06x %s not supported in kfd\n",
>                               amdgpu_ip_version(adev, GC_HWIP, 0),
>                               vf ? "VF" : "");
>               else
> -                     dev_err(kfd_device, "%s %s not supported in kfd\n",
> +                     dev_info(kfd_device, "%s %s not supported in kfd\n"=
,
>                               amdgpu_asic_name[adev->asic_type], vf ? "VF=
"
> : "");
>               return NULL;
>       }
> --
> 2.44.0

