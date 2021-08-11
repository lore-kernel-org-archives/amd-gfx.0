Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C07C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E2C60FC0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75E2C60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D7D89862;
	Wed, 11 Aug 2021 14:56:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3589B6E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 14:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXvG2Kjdw7k5YSe6X1foptdKEDiiJYMumGfTWgRmtxX8mqlKRzRdeFgHXTTi9H/XgyeNyv8wX4cyZidQxGUYZgVw8WwMxj9JBHhkdZ2ek5m4mWkKJ8s6uTvHNFtTU9P8vGig51K2Oc/2twFJnX7twUAQru2Rk+p8jxpbw101P/WxnA1VlLI5viix3zHczExgsTldeM0JVjpRZsUyHpjQG5kRlejzQsx1kO5kCVqdZ+jFS95RWR+NyO63lZaHPl8mkBWUlRquDJOfiQzynEd4ep/u2yLfb45t3b7q2p0qJ2N8IdjZlH3NtSUS3gw5hdPzn7LmIp4duS4gY7P2gAO3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGrKa1xbELi6u0qraa5ys5ZiWPFrx+1Ez3SUMCLqcxk=;
 b=gYqNc6z1XZojUKLRq2hIp/1myTfHzKhxfcdxelXggDd8V2FXCzZGhFt9wG0y+tdNLe7vaUcd2LSFwlE+2QnJGET3rnx1k6RCHm5TQzZW/HWE7CvBeqw+LrlaNRLfABChlvblaQ8SUdML9lOl+3XZrAE5QiOaQgc/LgvDLVpcZR5rB+ZzwEtEztwPmetXHHtH2pZJtSouJ6y/rfttgHI79fJJ7aficChioOZTHATKYltfTE287759HUddlPZrkigtj1QlhdOm9VR5NzWad51qksy7yJ9yZm4lsYZAVxcz9gv4Hjh0Y/FWXmkV+Q+Np32s4LQ2qNVNLnIJJL/B+kR7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGrKa1xbELi6u0qraa5ys5ZiWPFrx+1Ez3SUMCLqcxk=;
 b=kV7P+aDijBLb8EBHntk40xKqi9gZr+/jMKNtoVPGzIsRpze/4+iTNjKfXyWSKKfTjbjRQlQ/avYadyu+NWOypxvfwlPecDUfrCxDIOHf3iDgoEqYBeWlJCxuC4+ynVK4F/6fZGlrIWoGSIULK3WiDGNluWXj/bhWrPU2y/hVYrE=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 14:56:54 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::215f:6d11:1f30:ea03]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::215f:6d11:1f30:ea03%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 14:56:54 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Topic: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Index: AQHXjV7g3QSeBqIeZEyeOWISP7mIHqttgegAgADkq4A=
Date: Wed, 11 Aug 2021 14:56:54 +0000
Message-ID: <DM4PR12MB5263FE38F3ADF1C31A39BADDEEF89@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210809204048.2735-1-mukul.joshi@amd.com>
 <DM6PR12MB27613B1C5C6926052F80A81B8CF89@DM6PR12MB2761.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB27613B1C5C6926052F80A81B8CF89@DM6PR12MB2761.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-11T14:56:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9ccec323-9df5-475a-a808-02e53911fc4c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86db4169-c376-420c-a587-08d95cd84221
x-ms-traffictypediagnostic: DM4PR12MB5199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB519955DFD7533BBCD68A8108EEF89@DM4PR12MB5199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBxPfOEbU3X00X6BO/aJAeagaI8atRVh/0sqHqo8XfoYfKcH/7Ndh5gGaolc757Kq3SUlcUxCip79LqEMkMb8AYFqoxPLDnMiTpoFbA8S0NIYtnmSx/lqQKBCHNoSh35cSuKJJjah5cKWp9pkGcUAnqu6dehBa0T2iXIlMAGf1xeSaKP8xTAb+aJIBB46IzDdF5iON6Cyvy3azdr8ouvd95n6n0ziXkPbD+tI94Osa9SvrJx6KN1MkGFw4pK7gP9F+I/X6gFnZp+Pbyaz3WzkSYNWl4i3Ruo+44MMW1DwhdWBfwhW4MBfM4utzTky/a9RBSg1V+sYBRTtRFUtOP4psDj0E0o2Q6JFeoqY46q9ZZP55Y190lWTVdw7ZHCoOCgYw4TRkuHrobI4AY4N4yXxEA4PFLErDpqPDb7uA1JvtbG2lVvgs0rdvJpkkBegY7ZekMsB8O1RS0JjScQ0DtKkFjQq7VWJ1G+Y3OkpeEgqeinmHFtcktqUMDjALo9tfGLonirh+Ue7KlRbh6NS+vTSGOHE3mZ0fkpWU6GVBXcV5YlSZr9H5rFu1E/aY1x7pSy+2u5VoeaxUzQNZT0U8qgcjv8pWk+o3su1YekPX0aqDTgaIBioHW9cgtk8nsqHA9rySCU+MORZ12rEbNJcwIauHmHNb591Pd4dRBH+nsBWG5VSJ2QmHnr2TxHGrIy1fmbCLAkV2UTq9bhMwh6RTCxMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(26005)(66556008)(52536014)(66946007)(6506007)(53546011)(54906003)(66446008)(76116006)(55016002)(110136005)(66476007)(5660300002)(64756008)(9686003)(186003)(2906002)(71200400001)(33656002)(316002)(86362001)(30864003)(83380400001)(4326008)(7696005)(38100700002)(8936002)(8676002)(38070700005)(478600001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3f6A5K98gdK7jQNe3vJ7lm1+agXOpTM0jsB/33XcwLtxXFKmnU7DCInRW4w?=
 =?us-ascii?Q?VbxQMGL+qPyJD0rh4GGyWAaGWi/WGdGaYqMivK6ab0HbMtn6Yu0UlRG4EtNX?=
 =?us-ascii?Q?46pWH5/cdp2Uo8VQYqXBrT31280czYYqfrUAc9KXyCoxXxm/w4SXJHcLeqS5?=
 =?us-ascii?Q?HeahLCFm07WL3rN0F5jCtINfSoLgbumx80rR8nE0cNNVMToJQ/BI2qzZUFBR?=
 =?us-ascii?Q?PORs7PS23fqdOaSrYWjzuvyF7XKIa3nmOkcFT9M6Q5nqGLrxeKUVz5fyVccW?=
 =?us-ascii?Q?plJnkMKX+MJWBhXQEhtO8GTUUwreHOK587aUczUkaZ+4DGxXJU9h4lSTcwOE?=
 =?us-ascii?Q?YM3zXPi0TtA6S0fvhrEfBuBa4OXHDP1EX+fc86qkU6A1a7/iBJ/LRPpb4K8a?=
 =?us-ascii?Q?653+kClXPMocSQgYnSdZyIJCLZ6K5OZEHCOSiZdpVy3l+w4dJb/VMIUV8H2Q?=
 =?us-ascii?Q?3Wr4hy60VVsAliQqG5V+oCfzQqCqiZVVp6FhahhLdyvLlI/dx1drjOscKV5Q?=
 =?us-ascii?Q?QeAWRy6US4+8oqvHSDOL4yQnOdzztgDhtNga4ZOpWjUo5mBd4LoXs2csaFXN?=
 =?us-ascii?Q?EbmYrm+0jv1dG8H4Q/KFN4uHeh8sKlLM3gx41/iRa3363DTKfbKSZgmxp52r?=
 =?us-ascii?Q?tYid0LEymmcZcewfs96/tipwh570P6zZS7ClQg8DXsuADOIX7lmokgC6hWhH?=
 =?us-ascii?Q?MB/wf45K6bGqgvQD1DUP5cpvtKsrPNuJAM+9db3YiYZgLDz3FBrG9IpYlolB?=
 =?us-ascii?Q?kLYSwFnbxi9zJc6x8VQwHYHcsOTTAyNo91dIXSybB8RVMW3WyIswoKYaQjII?=
 =?us-ascii?Q?s9vMeNJqNBFxjt0jjKn1z9yrVGeMFH+Bo+NN1OLDMThy8/gfizzaeAVgjcJV?=
 =?us-ascii?Q?t4rLZ2J5AJOMmW8GUwonK86WGvy3oOoXKbsA+qO0oVHj3S0NyI1wKqLPW8aD?=
 =?us-ascii?Q?y0ep51O2QQykdDo6j/wbQu6iRuAtspaYgv2rkeZjbrsJISq5ymS7T1r5H7cU?=
 =?us-ascii?Q?3BP5beeIzW0mG6oHh4+DOKtA396wsXs5n3aNyZi/MJSe8SgMWWQoDhjgN9VK?=
 =?us-ascii?Q?IIV+aCx2EvA7lu0Eo2iPg+rpWw7Vz4awYfWCrI827jSUHeDXHSL9BnbH2Urk?=
 =?us-ascii?Q?tSpAGvKKzO2YrB/tY4a0vQH2Rn5TPmXxpUeHx14YhXywR9Xuqidf4oxyxkRP?=
 =?us-ascii?Q?UifPb1bqhoh2x5eOrxXnlZgUiQ8skO9D4QofUY8aE7u+nLgv55cI5SLdGWhO?=
 =?us-ascii?Q?SvcaapyNa6zkanp2fpGBH8zTfK1Pq5mWr55CZ3UQAYedEmilXVNZei3c748P?=
 =?us-ascii?Q?bd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86db4169-c376-420c-a587-08d95cd84221
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 14:56:54.0743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLXrE8YItNF33g0aHrUP2A+zWm+5aluXehqyubwm5oxQGsOPvHz1n6MeiZJmKREe0HTJxU557lj6ZY+6uSEA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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



> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, August 10, 2021 9:15 PM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay
> <Jay.Cornwall@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler
>=20
> [AMD Official Use Only]
>=20
> Just few comments inline. With that acknowledged Reviewed-by: Harish
> Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul
> Joshi
> Sent: Monday, August 9, 2021 4:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay
> <Jay.Cornwall@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdkfd: CWSR with software scheduler
>=20
> This patch adds support to program trap handler settings when loading dri=
ver
> with software scheduler (sched_policy=3D2).
>=20
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Suggested-by: Jay Cornwall <Jay.Cornwall@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 31 +++++++++++++++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 31 +++++++++++++++++
> .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 33
> ++++++++++++++++++-  .../drm/amd/amdkfd/kfd_device_queue_manager.c |
> 20 +++++++++--
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
>  5 files changed, 115 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 491acdf92f73..960acf68150a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -560,6 +560,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void
> *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -754,6 +757,33 @@ static void set_vm_context_page_table_base(struct
> kgd_dev *kgd, uint32_t vmid,
>  	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
> }
>=20
> +static void program_trap_handler_settings(struct kgd_dev *kgd,
> +		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +			lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +			upper_32_bits(tba_addr >> 8) |
> +			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>  	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping, @@ -774,4
> +804,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>  	.get_atc_vmid_pasid_mapping_info =3D
>  			get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =3D
> set_vm_context_page_table_base,
> +	.program_trap_handler_settings =3D program_trap_handler_settings,
>=20
> [HK]: Naming  not consistent. program_trap_handler_settings,
> program_trap_handler_settings_v10_3 and
> kgd_gfx_v9_program_trap_handler_settings
>=20

I am following the naming convention for the other functions defined in the=
se files.
That's the reason the functions names are different. I don't mind naming th=
em all the same.

>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 1f5620cc3570..dac0d751d5af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -537,6 +537,9 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, voi=
d
> *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -658,6 +661,33 @@ static void
> set_vm_context_page_table_base_v10_3(struct kgd_dev *kgd, uint32_t v
>  	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
> }
>=20
> +static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
> +			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +			lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +			upper_32_bits(tba_addr >> 8) |
> +			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			 upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  #if 0
>  uint32_t enable_debug_trap_v10_3(struct kgd_dev *kgd,
>  				uint32_t trap_debug_wave_launch_mode, @@
> -820,6 +850,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>  	.address_watch_get_offset =3D address_watch_get_offset_v10_3,
>  	.get_atc_vmid_pasid_mapping_info =3D NULL,
>  	.set_vm_context_page_table_base =3D
> set_vm_context_page_table_base_v10_3,
> +	.program_trap_handler_settings =3D
> program_trap_handler_settings_v10_3,
>  #if 0
>  	.enable_debug_trap =3D enable_debug_trap_v10_3,
>  	.disable_debug_trap =3D disable_debug_trap_v10_3, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index ed3014fbb563..154244916727 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -42,7 +42,8 @@
>  enum hqd_dequeue_request_type {
>  	NO_ACTION =3D 0,
>  	DRAIN_PIPE,
> -	RESET_WAVES
> +	RESET_WAVES,
> +	SAVE_WAVES
>  };
>=20
>  static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kg=
d)
> @@ -566,6 +567,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void
> *mqd,
>  	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
>  		type =3D RESET_WAVES;
>  		break;
> +	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +		type =3D SAVE_WAVES;
> +		break;
>  	default:
>  		type =3D DRAIN_PIPE;
>  		break;
> @@ -878,6 +882,32 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev
> *kgd, int pasid,
>  				adev->gfx.cu_info.max_waves_per_simd;
>  }
>=20
> +static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd=
,
> +                        uint32_t vmid, uint64_t tba_addr, uint64_t
> +tma_addr) {
> +	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> +
> +	lock_srbm(kgd, 0, 0, 0, vmid);
> +
> +	/*
> +	 * Program TBA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
> +                        lower_32_bits(tba_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
> +                        upper_32_bits(tba_addr >> 8));
> +
> +	/*
> +	 * Program TMA registers
> +	 */
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
> +			lower_32_bits(tma_addr >> 8));
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
> +			upper_32_bits(tma_addr >> 8));
> +
> +	unlock_srbm(kgd);
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>  	.program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -899,4 +929,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>  			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =3D
> kgd_gfx_v9_set_vm_context_page_table_base,
>  	.get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
> +	.program_trap_handler_settings =3D
> +kgd_gfx_v9_program_trap_handler_settings,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a972ef5eae68..6fd6b2248992 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -211,6 +211,14 @@ static void deallocate_doorbell(struct
> qcm_process_device *qpd,
>  	WARN_ON(!old);
>  }
>=20
> +static void program_trap_handler_settings(struct device_queue_manager
> *dqm,
> +				struct qcm_process_device *qpd)
> +{
> +	return dqm->dev->kfd2kgd->program_trap_handler_settings(
> +						dqm->dev->kgd, qpd->vmid,
> +						qpd->tba_addr, qpd-
> >tma_addr);
>=20
> [HK]: Since, this is not defined for all GFX generations, safer to check =
if function
> pointer is not NULL. I see it is called only VEGA10+
>=20
Sure I can add that. However, I am making sure that the function is defined=
 for all ASICs after VEGA10+.

Regards,
Mukul

> +}
> +
>  static int allocate_vmid(struct device_queue_manager *dqm,
>  			struct qcm_process_device *qpd,
>  			struct queue *q)
> @@ -241,6 +249,10 @@ static int allocate_vmid(struct device_queue_manager
> *dqm,
>=20
>  	program_sh_mem_settings(dqm, qpd);
>=20
> +	if (dqm->dev->device_info->asic_family >=3D CHIP_VEGA10 &&
> +	    dqm->dev->cwsr_enabled)
> +		program_trap_handler_settings(dqm, qpd);
> +
>  	/* qpd->page_table_base is set earlier when register_process()
>  	 * is called, i.e. when the first queue is created.
>  	 */
> @@ -582,7 +594,9 @@ static int update_queue(struct device_queue_manager
> *dqm, struct queue *q)
>  		}
>=20
>  		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> -				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
> +				(dqm->dev->cwsr_enabled?
> +				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
>  				KFD_UNMAP_LATENCY_MS, q->pipe, q-
> >queue);
>  		if (retval) {
>  			pr_err("destroy mqd failed\n");
> @@ -675,7 +689,9 @@ static int evict_process_queues_nocpsch(struct
> device_queue_manager *dqm,
>  			continue;
>=20
>  		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> -				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
> +				(dqm->dev->cwsr_enabled?
> +				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
> +				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
>  				KFD_UNMAP_LATENCY_MS, q->pipe, q-
> >queue);
>  		if (retval && !ret)
>  			/* Return the first error, but keep going to diff --git
> a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 95c656d205ed..c84bd7b2cf59 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -44,6 +44,7 @@ struct kgd_mem;
>  enum kfd_preempt_type {
>  	KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN =3D 0,
>  	KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
> +	KFD_PREEMPT_TYPE_WAVEFRONT_SAVE
>  };
>=20
>  struct kfd_vm_fault_info {
> @@ -298,6 +299,8 @@ struct kfd2kgd_calls {
>=20
>  	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int
> *wave_cnt,
>  			int *max_waves_per_cu);
> +	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
> +			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
>  };
>=20
>  #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.17.1
