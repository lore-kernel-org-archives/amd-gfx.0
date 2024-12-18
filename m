Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C8E77188
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 16:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE6A10E992;
	Wed, 18 Dec 2024 16:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tlEjraA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15A010EA07
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 16:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcJP5x4oSTHqhyn/KBtjstuROmoz9ycChLyA5qk822oWB/bK1jvb/WzhY4bwy3gPcLnvFVZdlCCiHA7QYDbKIrX0hOK2ziGxOpv/zMmU4yUUkX3ORKxD39XfgLGx1T5876PP+JgeY/RdyqioElj82sr6PQ0+mfq3tgy5h4anaCjCvknFLV6/2yOAM48Oh/GQ2tktP9mDi81gAB9xtIEIc3l/4/VYRTTdtCARwBBsm7qm9BJ6ApBFAquiKLovj8aMAhc0xbG9P6GSsHJ0eMcBhHDLIkGO8kj1QY0xhb4EIUA6eb6YhrW561B3zhyzTAeoYP/Vtj9Bd88ZMzndfgDQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uySqZWTweiQBNqI8mOmYPrfG64ATBhlypDWWAOwz+MI=;
 b=VvkngXAfVkwF5YOGx5T2irByyXNi0IEmZj08fzzW3Kyx3ig7U35PoUKw0+BJg4ntMnHfqi/qnF1mquySUj8wR5P5m9DYozYp35jKBeAVYtE9zlAuBSZgJE2yrsnNprL/ovDy7eePRhHKIBD/vuboBEeQ/K6B2NWCQ37fExUUIR/qEzbiSYec0cSR9nU7g1WsZ+cPlKly3qn12oEVFu51ztW5w7OsTg/kPxmtaWxCtUnC89oTJv9UB9RzbBcpYD+O6wKodtjr5AGSY8xGc6r2+55XNzQi2K5+Hyx4NkW3vZ/C0KzR0B2fMU2Fr8KSHRO4BQnqY7Hjsst1beD3jmnuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uySqZWTweiQBNqI8mOmYPrfG64ATBhlypDWWAOwz+MI=;
 b=3tlEjraANs4VzovYMcRiez6/AAa+HmxAb5hCQv8bdYA0qjb99dal5Fid0m28zftPiT9mYGxu+QrMA6EUy/GShCyr+XdbA7CEt+GEi3ouMgXCNzke5KCL4TFl7Z93dRSoS9bYPmYS27M857xPSLaVrNF2i0P6wM3f2wlZYxVOs0k=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 16:25:57 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:25:57 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Tobias Klausmann
 <klausman@schwarzvogel.de>
Subject: RE: [Bug report] Regression with kernel v6.13-rc2
Thread-Topic: [Bug report] Regression with kernel v6.13-rc2
Thread-Index: AQHbUWUGrwzIpjZqAkic9tNvX9Hge7LsL9Hg
Date: Wed, 18 Dec 2024 16:25:57 +0000
Message-ID: <SA1PR12MB8599BFD6EDC3C98CEFCB62ABED052@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
In-Reply-To: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=07ad2f79-8965-4c0d-813a-5cb4c0c015f2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-18T16:24:39Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DS7PR12MB5816:EE_
x-ms-office365-filtering-correlation-id: 28a07787-4f1c-4de9-5a58-08dd1f80a6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?w+kgCyxK991JdgQiUGQ1xVNx6zMwPxnC9mwF0jDSIe7Fb92uqZe19YrOuir0?=
 =?us-ascii?Q?CBkUBWrqDI7nYZpUoGdFzGkgWAimoVkapEvBTcbm953LCv8y0iKuucV8/EN2?=
 =?us-ascii?Q?Xti99jOkw1UxlK1TGqIdMypVhfd1IzwzGitNTKCyc6I0UdcqLd74dQ6wl22S?=
 =?us-ascii?Q?Ab049RgQPpPtxkfrrOFekDEN5viAnvUQtkpkZqMDX/YSetUxVD0HWBnZNMnw?=
 =?us-ascii?Q?q66SGNo03lt5zJqJs4D7HhpKPuRV8JqZDh7cRJhy7AqqzGZEs3A1vUV0inD2?=
 =?us-ascii?Q?LQOS/YoiK0yzIPw2ylNYzPlHO0Pg6Ntlj/Ncw6EF1d6r0PkAffSgq5rd62jE?=
 =?us-ascii?Q?hnYZk0ZEAiPspZ8/hMHQHDCCZExMKYlZ1hOBz1m6cuPGZJf0wc6U8rlfhj+4?=
 =?us-ascii?Q?bC0v3fXUj9qHkKhLt55K5tyimniW9QYK+E4BaojHoB0c0Uxza0xMsFC78HXj?=
 =?us-ascii?Q?G4HY0LGDW1cy4X7sFFECo4y0/NyhmAsybU6Wd+G+ma7ky8Zqt8vEGWKCXWCM?=
 =?us-ascii?Q?Rol34sU9EzZ9CB/Q0PtDQ9RCZzwekTLRAYLvEbbxhhx9yxs6OsfGyoWEwOxi?=
 =?us-ascii?Q?Zvi6NvP8dRdHlKRPdRP81JEd0ODxregP0JNLsVu0W7KhQVHc8kKzGUh4pp8Z?=
 =?us-ascii?Q?LJE6bbMeTy37EWKZKVhEbOMKlBbEctcbhpYI6Bd5gHFDMA7QGGf35P8rFBQm?=
 =?us-ascii?Q?coOipd2YEwU4SQH4+DIO+ssb1uiXidHoXrbDA/O1o9K7LDuSR6vAAoZH0udn?=
 =?us-ascii?Q?0bwhzf3dt7R54zK5ddRd7th0GEYWz+ZCCBFLcr4an3QkYZqGW4LuKGDP3Jf4?=
 =?us-ascii?Q?3XC0M/7ZJDeQ8QGDRCdpfHx+PKAqFDH3D/4fCZnLmRAsQ+PCoOJgXId605SY?=
 =?us-ascii?Q?6JCdEc148fx+xBXiDhyUp6Au+70WiDLhpPRBqvMmD35BUtT2TrfXlgROxN7W?=
 =?us-ascii?Q?Ml+X2agqbav6Rvs1PhjoIqG3yPm63ojqhKq3p73+Ec9tTXimoxq2T1NHqNjr?=
 =?us-ascii?Q?0gPd1Q8fPYypR1DBcwooQEJ3J/t5SXi+EU2xWefg0QgQRJTh0tHf107pVGfI?=
 =?us-ascii?Q?JIh1WraPlAfwr5aEoKU8Kk+s8HWbWS3qgkrSZxVrHve+IjsiLDnwRmTKnQ8X?=
 =?us-ascii?Q?WkdNO116OQF4WMklfoPTMrfrjqtE0pp5dErn1oUaU2IpRRjuXKkeOlKGUDYw?=
 =?us-ascii?Q?4nnja7Nh7bMSaoRG74QR3NzAgyp+PbyD2L/U/Kf4zGvLhzfFLP30/2Bf+6Zi?=
 =?us-ascii?Q?P60ZQmJVpuSAlDatdysKcW3xHDzfsHEgtEv/auKC0sJhaebZTKD6g/MzDsYa?=
 =?us-ascii?Q?AyrmedKwtwqlvCsDSmGJ3WKymdhxPOi/SOEMiPwR7H71vHxkPFpTva9Lm8D/?=
 =?us-ascii?Q?s/U3GHD9nTtdZ7/0rUcH8q+OfA9LvTzWnZ2dnpPly4HkzwUNIW+FCRKcghk5?=
 =?us-ascii?Q?WgT1AFz2JkRlZPGOkyv1c+qEBcl+nnGL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlneodk00YI8Y8OCTHNIQUvyS5ZtCNIingi2yvFUUmMpPAD/JndixAN/cVYk?=
 =?us-ascii?Q?o3LmQC9CZxQgYjPM0NMjor1Dzo9F+7536zWMF0z24wJEFhpRlCwt56fDmise?=
 =?us-ascii?Q?gUi2mwynw6QmNNWwkinELGiPTgvp0p0B6iny4KTxcMnAjXdoBFYLmvD7a6MP?=
 =?us-ascii?Q?TXT4LyNcWhs/R60epvKcpPJyepIHOpWycE339VReBgLYKrpN6ugVwL7UUoo5?=
 =?us-ascii?Q?RgrA9o4Fcxd2euxKYlXVRo7gOoBZhrIc6qKjBaO+nUJUxIdvhQCGd09pBuw2?=
 =?us-ascii?Q?s53mg0llHwbExK3TV+nvuRRzm9jjhK1sCBzCYH0UrN2VZkI+8XN610sKaAtF?=
 =?us-ascii?Q?aJVLEH/HTnF3oCEn69lfLyTRMrpX1rVxth6L6R1iKF/2EyAthLoFFKda9nFC?=
 =?us-ascii?Q?PiFY73ZygavtGh8VGCJl0PUgYMWclkV1MZ0lHiyT+EwvpcebOITkoVyN/hNJ?=
 =?us-ascii?Q?903j4i6KC/dZ6/Hu4MJQTl1iX+8kXVY/g36M4n+QadPCQ3hS2PU0fHKKvwFP?=
 =?us-ascii?Q?6PhRDKFkXrcst47cnBLGHACm7FlpNv59Zk6JFyRE6uF6JJU4KRdohrdYlWIT?=
 =?us-ascii?Q?cEbWpVGsm/92ULWbKwsKA+funpMcNwcE908Prk+P2LBPS5FiHGDo6HswbvCr?=
 =?us-ascii?Q?TzE8JMvvWfN/shivtIW0oXl1Bau3HP6rBQ8h66CCkoVLnzS7lHtsac9KwNTC?=
 =?us-ascii?Q?KMN5gFt/Hwdyg1fHOREKlmANgkwsz2i7iKEnvQUNWROWc4ZwyfEZj8G/p/0h?=
 =?us-ascii?Q?kgz8Go4qlnCJTyGAJbvUsw+K11+tKouNTdL6quDpwj5C6GdB/O6tN4vvUdz9?=
 =?us-ascii?Q?oyUOz1QHU0/JpApvhbe7Zz//DzQYubv6AZSsfi0Pb/t6KZ2cNgkf+e2iHvNf?=
 =?us-ascii?Q?Q9X76iBN2tCjUhDbhAGAxWoVBanWJgICPE1ODRtcx7MpXNAzn6qZGu3WCv8i?=
 =?us-ascii?Q?ESrj19LB1EsLKYNba2ipJZbkncIsl2clxM2XAlEqIIdtpGzACS+wWfrHLXGb?=
 =?us-ascii?Q?hSTnFGwZmy0U6zgNd4T6P3QdWIDbKA8w9So8H2q20gwLn7U648i/RQdsXt/Q?=
 =?us-ascii?Q?Rg8b2KRMFH7uANB/XWunMkDFL2Na5H14Uaj3aurnHera85lIGbUylPP2UsFP?=
 =?us-ascii?Q?2M9FuB/LbcMMRjLoRZJywUFxXTjzEwXtO6DwswaozXSMpXbN6mb3fCuqncOd?=
 =?us-ascii?Q?3CRCWaCSr/QLfiq58flsuT7F4tatG50UIQtUXRMdrtJA76PlSl+w7205Yxbm?=
 =?us-ascii?Q?4VeMIehUS5MWsVsodWNur1pKhGdD8xdwUICyh/M5cq2T4DFK4fOONHauVaM/?=
 =?us-ascii?Q?4N2tL/IPSFdbAxZTqS6l3eZUXaHHt0+Rbm3AcmJ08zjYEskc5bD8dfMhNXiU?=
 =?us-ascii?Q?pTprQMTvlBt45oiL4p+gx+z3oXDR7DX/hfEkhYpM9m22JCxGUZP0jd5UEPoh?=
 =?us-ascii?Q?OKWdRd6/jtWGB4mi2Y+i/qryz/OVfa6f2pFwRUOTHdnJDeVkYAUehRVcTJ+r?=
 =?us-ascii?Q?lQ/fTl4VATMfIuqXUX6VUBogOt6s68uuxLZnOs05qXDXRJpgAHghyDN+QmlH?=
 =?us-ascii?Q?ApbLlQn9a8zR7EsIAEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a07787-4f1c-4de9-5a58-08dd1f80a6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 16:25:57.4184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4q8v9K6C7qjb4bUsY2HBAHrfx6CcPlvmaTw+3WDnwOFM13HkNd1GKQPi5pt16Y2LCeNbuH3bv2OSgj8WRN8Drg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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

+Felix

> From: Tobias Klausmann <klausman@schwarzvogel.de>
> Sent: Wednesday, December 18, 2024 10:54
>
> I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
> example:
>
> [Wed Dec 18 15:56:24 2024] gmc_v11_0_process_interrupt: 10 callbacks
> suppressed [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhu=
b]
> page fault (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040B52
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x5
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty U=
TCL2
> client ID: CPC (0x5)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MORE_FAULTS: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> WALKER_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> PERMISSION_FAULTS: 0x3
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:
> MAPPING_ERROR: 0x1
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:169 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fau=
lt
> (src_id:0 ring:153 vmid:0 pasid:0)
> [Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page startin=
g at
> address 0x0000000000000000 from client 10
>
> This happens when loading nontrivial (~6g) models using PyTorch. There is=
 no
> immediate crash, but if exercise the model for a few minutes, evetually, =
the GPU
> crashes (sometimes the whole machine).
>
> I bisected this betwee -rc1 (which works fine) and -rc2, and I landed on =
this commit:
>
> commit 438b39ac74e2a9dc0a5c9d653b7d8066877e86b1
> Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
> Date:   Thu Dec 5 17:41:26 2024 +0800
>
>     drm/amdkfd: pause autosuspend when creating pdd
>
>     When using MES creating a pdd will require talking to the GPU to
>     setup the relevant context. The code here forgot to wake up the GPU
>     in case it was in suspend, this causes KVM to EFAULT for passthrough
>     GPU for example. This issue can be masked if the GPU was woken up by
>     other things (e.g. opening the KMS node) first and have not yet gone =
to sleep.
>
>     v4: do the allocation of proc_ctx_bo in a lazy fashion
>     when the first queue is created in a process (Felix)
>
>     Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>     Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: stable@vger.kernel.org
>
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 15 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 23 ++--------------=
------
>  2 files changed, 17 insertions(+), 21 deletions(-)
>
> I am not sure what the causal relation ship between the commit and the me=
ssages I
> get is, but I thought this report might be useful.
>
> Since I am not subscribed to the list, please CC me on replies. Thank you=
!
>
> Best,
> Tobias
