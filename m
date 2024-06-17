Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC9C27C77
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 03:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A106910E0EC;
	Mon, 17 Jun 2024 03:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tlh0FH3T";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAE210E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 03:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLWq91mk7lDzkjV9deE0f3327H/HIVwVKXULdcA9PorBlr9+o4ViRP+Fe2WXkyv9gPkR2PF5Ikj2vaP24la6ufZLUejx3f47SgmQH53rnJBYd9KrrpCWjMjCgrXQGjEUpNR6GyUeQgR8inzFAZkPzi9QCcZ2oR3L3oNDyBAYJ883ZME4221DaQqzTkgrnEguEUPCdr7RiiSoZPpUbreOHZjEgQ+QpEjOQfPqnTGM239j1sDs4zPjWOSuJ9LFd2AZ7wKYPJ1g9VZt59mA5ajvwapCtoxnRFnyvzYpjlbUNos0WJUjrBWzCsBT9PB3su8rIVuy7gakEQjjFqXk7yuLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUHalCSW3QREEfAEVNEDhcP+UtE5m3yPNnE8oU84MQY=;
 b=AsVfJPYAKzdJMkRENDpg5xDRaOipCiStHzwwt7Pn0FyCsm9hGuSmpKjKWYgR0SwfiLqNCD7euGXGgX4BBdGjeJrahh8Y0qgwfCIoQ1ghKAda7g0cZV1xv9S6SC4oW0BZ3ItxMWY3qQ7hFY8ikJxyqF+vqR2Xk96WRwZhq0a+3MtCfY6Y3Jv+4YqGSvhiTyBu2+NTg9+rb4aq2tS/SAPZG3ooCOtUzDe5TnU67t6iJCPUWpwJGON4cN6QtE5Jv6FYCJKiAnZfkzMJsrSihROiU9DoJ1zEPYnCUbrvoqwj3ezowFdJdEZrdzWRpjjnJQamgdGA/wLaBJNPNKzkbABX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUHalCSW3QREEfAEVNEDhcP+UtE5m3yPNnE8oU84MQY=;
 b=Tlh0FH3TiSE23fb6XgiA0HxNgFRUTHGPh6ia+aplMZMvPhiM7UNgyOJBOE9Wn3l3dlMTCx4jmA9sPdXCb6s4vYBpAjOp708558mKl0xhBk7j//87hLwGaX9T+HJH9ZCjCfdBXFqP0U+7T6EzLbCuiA9brHY3P9QhuyPzA9r171w=
Received: from DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:28:13 +0000
Received: from DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f]) by DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:28:13 +0000
From: "Chang, HaiJun" <HaiJun.Chang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
Thread-Topic: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
Thread-Index: AQHavkt2mLYCWGjOKEKv+fV+YNkb0rHHJXkAgADv1ICAAytIEA==
Date: Mon, 17 Jun 2024 03:28:13 +0000
Message-ID: <DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2@DM6PR12MB4958.namprd12.prod.outlook.com>
References: <20240614111022.236072-1-Jane.Jian@amd.com>
 <2bf881e2-9db1-47f8-b8ec-dee5dd7a295e@amd.com>
 <DS0PR12MB780478C3B4C8DBC2E973191497C32@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780478C3B4C8DBC2E973191497C32@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-15T02:07:24.0915620Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4958:EE_|LV2PR12MB5845:EE_
x-ms-office365-filtering-correlation-id: 5537d259-fc04-499f-2ef0-08dc8e7d852c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y6ccKX2zasKyytPo7tUD9bciHVDXajOhQg1pU1FtQfgyXK4T/4dNG+PlNFKq?=
 =?us-ascii?Q?PzciNQsr1WQh+HQzjZu96iF3L96V+YWLpYfrZpf24j+s9LNKEguzurP13bJQ?=
 =?us-ascii?Q?yPgEUw3EgMH+qysfsqbjc+lSpOZTl/6iBSbDa2BFsZ1J2QhLjsVjiEdYdiWn?=
 =?us-ascii?Q?l9U+pKvtn6ER6t9WekLtCsfC1z7Frwwfw6nqlwaPkaPbC91rUYdoYktGh3dL?=
 =?us-ascii?Q?QaEjJVsOXvCDiuK+Cwbo51Sa/r65ImdBN0A1GIL4p4VWqxQ+e9D9iRW6MCQQ?=
 =?us-ascii?Q?LGcxaJyYGUGXJm0C9/LSXuDa0WzQ5xsKNIeMtf5gDzLne/biILNujDr4299o?=
 =?us-ascii?Q?oKnOUnT8599/lDFiVMLjDG7HX9zXSq5ybrqBCEPJWpYCG7VSpm8L6Vq/B6wC?=
 =?us-ascii?Q?jwrg6EUQvR8Am2G7sxPmXONx3zQVNoziH7g4UIiIhrzuwTDAGr+lCRPzhDAA?=
 =?us-ascii?Q?ZSxfccTOf5VOFm1B1qMpgnPbhAv+DhOmUqmMF+EaPnAHDNDtJiMLK1s6bXMQ?=
 =?us-ascii?Q?+ZGFj4SzBbG2sBEXFm6t3Ek4/U3FFIUax+01ewVPjnroQ1z3xYVJ6DP8EWPf?=
 =?us-ascii?Q?5+Z57cKqlrdiYo6pxpZcqLOvvXVpeMdsQTsMa/VwAKxcOWgs3W3QyNDI2PaD?=
 =?us-ascii?Q?at4GpFiiB8mTmD4IdHHSAYEx3Qu9TmAcC4ZTDItTvOqPEWspj1HLT3bkV1OL?=
 =?us-ascii?Q?gtB1aD/1s4DqkzqFXdNuon1EMuXiFB0akKHNgXlXRGSVET/YAHbcUa6QbJX9?=
 =?us-ascii?Q?0Sll21R6sJKuoeqbc0DwIVMWIwnXRA5udQ39iNyR7CbePqNeRIbxrTMiZvMJ?=
 =?us-ascii?Q?phqMC1Mf2Q0l4PphyiiMEJ9vqrso9kvObnWeOJXn2FHx6bXtNvYHRrrGhvnr?=
 =?us-ascii?Q?GwnC5vTNIoDCgmT7RsS3oJmGVKLVyLAuoH0Gtc2cQp2GlVLa3qq3seI1sbTf?=
 =?us-ascii?Q?6f3vecmADiesu0MZSo+BbW2dzkmcFThQbir4avGt7bTqj2hW303IGk61AXoi?=
 =?us-ascii?Q?e/gjjr/485nae3NyYbqGuHsT1gIyd3MzoixG6Fvl+Lj7p7fd5HbxISR/nF13?=
 =?us-ascii?Q?hkaM8Mtcjrzz7QI8JPrZf1fG75nxjHXtht3meCjbZ6O9N+S3tDEXS+RNnX8l?=
 =?us-ascii?Q?aUDomOFtep3E60wBTMW6BWJ30srh+u2mRppylVDOeSiNyucoyxh5y/3GCAwT?=
 =?us-ascii?Q?sdxdZQjXNrOU0H5OzHp3cOJrG73VUCAGNDhqrROnSohH4rWGl60rbuXK18Id?=
 =?us-ascii?Q?d57XgyQwRj/YZUHFUtDLNedhGU+d11aMCYjan5IA0EYpvNCGeV+GnFBzPQSh?=
 =?us-ascii?Q?urGiLTn+6W/2XDMczin1QrsfstxKSY5KmSUTTU7DD/vcKrAPsLBShvby2TsQ?=
 =?us-ascii?Q?PEuTQFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5+KG9EQvUope6EKWDOfZVwXtWUSPc5EU2RJrEIC5bf2/4S8rxVJo1NAbzLq?=
 =?us-ascii?Q?7GiH6DUUHARW+txCngkNGEwb7SVgSVZw5Xi/Oedhcxzq7uEY8JNqfK1HkCF1?=
 =?us-ascii?Q?HQjQfus30q1PEtBxD9RgtwzQ9Pyhr8S17sIPV5QIt6TR+V0+Fy+HeMDDe/f0?=
 =?us-ascii?Q?4CWUeK62uUbAXlDiR5oUEP7bZ67qhxCowqDakz84Ws3cxrLlIZm8hdXZ12Lx?=
 =?us-ascii?Q?eDMpY6VKJ4haIpHiMDtsG3kEtNa1blKj4cm+ufBoKO/7evfuP7Ccu4828TNu?=
 =?us-ascii?Q?sahOeBcwDKOi6QQaRDeOpxdeB7FzHaxzkeW5mQd+McaxOJ9iG2UX6ne1MuoA?=
 =?us-ascii?Q?6Z6kaJ2iRaHFxeFjENgGiPO1/o0dqD+N9teyjP1Eq/088isx0yZ8j9JLXG7t?=
 =?us-ascii?Q?2gJ/wcc6nS4EOzD3SzGtAgG5Rgz6aa2B4pi+2PNkeBU092AOD4HJo4dQlFfg?=
 =?us-ascii?Q?3xvpDgeZ5u4Fr6BK42VZY6cvg5QRPJUDjQhujKrObNmzBfpcSFlghdb2URm2?=
 =?us-ascii?Q?Ms4nK3OcrKwyv9Jc4J0jufb5WYj5dOV7V1ufEvYOEvB+yuJlg13LUyr71eWt?=
 =?us-ascii?Q?f4IEF1NYQ/gkZCTn9dcakD27lsBgWDRE3P0Mj+qqti5VIXRVvHZgqjupUTP6?=
 =?us-ascii?Q?CoGqmh9wkjN4SukSeitRiNAdhynSiHQdTlbgmQ95YHfG1WMNnU0EtSf5b/Pi?=
 =?us-ascii?Q?gb1O/oEm7YGiKAaQwtmIkJD4iPfc7Nh/Nb34kn7+RAvumBWMMUpD/dZF62zj?=
 =?us-ascii?Q?uCPstj5C2B4vgwEhF+hjK89yGiQ7VevU9fAY4mWhsqXdTho+ax+6249d8o6f?=
 =?us-ascii?Q?Dt827ZXr/GlqPBI0dPjltNSD8iIRdI6MFBJIq8aQjkgMwZ77tEjn3U43WhzL?=
 =?us-ascii?Q?rd4OjpXC4XPtdSpIFJq3aLrePTpu8pJffk3C/wxru+MtX4DACf8L5o0Y0XJ1?=
 =?us-ascii?Q?cjDx7EUz/4duoD+gfgD5964hD3/2cB03Hf+cqKmo7LVV9WZxnlq2EsgFvDOI?=
 =?us-ascii?Q?IXXqC2go74UOjav2sIapp2UZvENN2JupCG4YyxSDhO0zaEdcyOF3E0m4nOW5?=
 =?us-ascii?Q?TPgPps+se+HqzKZ8Ah9R59bb3JTc0BmRXo3Qk+dyREXODEAtoECRus2WA563?=
 =?us-ascii?Q?0CKF+kJvz+AUdCS7MLjg23cnGsqfgn3cidQ2XgBtsR+udhZZpv8M5/VGyaIk?=
 =?us-ascii?Q?uRGgzgsJrju29joxy46c4PGlevZeTeYJD24E8iM+Q2Ob0xp22WgCLvOXgWOl?=
 =?us-ascii?Q?k+e7lScIrD8GIu1LN/oeGtCQPFgXt8H5GXiVK3NbX1HFi305sFzljXWbRs0L?=
 =?us-ascii?Q?TKg4HeItOK1FugLskcmWHTWpiwuB9HqDMY5WXvl8ig7HOWdGfs9470eWJ/j4?=
 =?us-ascii?Q?a/F0BYST/2tzSydIOHKwq02NwddO6oYcDnltRkzjbzZRDmN9E2B9y3b7zI1f?=
 =?us-ascii?Q?Ox120zaL1y5eGI4bd0w1uTve3F/GomXavFsUsYxb+MJzRClhe67fccsCXJjL?=
 =?us-ascii?Q?Za14RmdRaSj1yja2bCHCzuSpCCvfdJ9xo6gFyDRd/zNmsIzJ6HQ/8YnuiitF?=
 =?us-ascii?Q?wfCUmqqfV6peY4Gv/Wg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2DM6PR12MB4958namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5537d259-fc04-499f-2ef0-08dc8e7d852c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 03:28:13.5984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPpAYBT2URPiRoOoowgrX5K3QBE6hLBqhkK+Unfk3sKmwV4OWiwc6Zpt2eBX14kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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

--_000_DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2DM6PR12MB4958namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Lijo,

Right, 18bits are byte aligned range of local XCC register, 16bites are dwo=
rd aligned offset range

We find the normalization needs to be applied to many functions, like

  *   KIQ: amdgpu_kiq_r/wreg/
  *   RLC: amdgpu_virt_rlcg_reg_rw
  *   KIQ: amdgpu_gmc_fw_reg_write_reg_wait
  *   KIQ: amdgpu_ring_emit_reg_write_reg_wait/amdgpu_ring_emit_reg_wait/am=
dgpu_ring_emit_wreg

For sriov gfx register access, it only has 2 ways: rlc or kiq.  Both of the=
 ways can use local xcc offset,  so we think it's simpler change to init th=
e gfx register offsets with local xcc offset only.

Thanks,
HaiJun

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Saturday, June 15, 2024 10:09 AM
To: Jian, Jane <Jane.Jian@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Z=
hao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov


[AMD Official Use Only - AMD Internal Distribution Only]

Never mind, bit 16 and above is probably because of dword aligned offset.

Any reason not to do this in kiq/rlc based writes to normalise all?

Thanks,
Lijo
________________________________
From: Lazar, Lijo
Sent: Friday, June 14, 2024 5:20:30 PM
To: Jian, Jane <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>; Chang, HaiJun=
 <HaiJun.Chang@amd.com<mailto:HaiJun.Chang@amd.com>>; Zhao, Victor <Victor.=
Zhao@amd.com<mailto:Victor.Zhao@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov



On 6/14/2024 4:40 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
>
> [HOW]
> for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bit v=
iolation
> since kiq ring is always local, local address without XCC ID is enough to=
 be sent to the XCC KIQ
>

The description is incorrect.

Bits 18:20 represent xcc id. To guarantee all paths pass a local
address, you should just strip bits 18:20 in kiq/rlcg read/write
functions rather than here.

Thanks,
Lijo

> Signed-off-by: Jane Jian <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index e14acab5cceb..4e38a66a52f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_devi=
ce *adev, uint32_t xcc_mask)
>  {
>        struct amdgpu_vmhub *hub;
>        int i;
> +     uint32_t gc_index;
>
>        for_each_inst(i, xcc_mask) {
>                hub =3D &adev->vmhub[AMDGPU_GFXHUB(i)];
>
> +             /* for sriov only init XCC0(lower 16-bit) to avoid higher b=
it violation */
> +             if (amdgpu_sriov_vf(adev))
> +                     gc_index =3D 0;
> +             else
> +                     gc_index =3D GET_INST(GC, i);
> +
>                hub->ctx0_ptb_addr_lo32 =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
>                hub->ctx0_ptb_addr_hi32 =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
>                hub->vm_inv_eng0_sem =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_SEM);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_SEM);
>                hub->vm_inv_eng0_req =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_REQ);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_REQ);
>                hub->vm_inv_eng0_ack =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALID=
ATE_ENG0_ACK);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG=
0_ACK);
>                hub->vm_context0_cntl =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT=
0_CNTL);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_CONTEXT0_CNTL)=
;
>                hub->vm_l2_pro_fault_status =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
> +                     SOC15_REG_OFFSET(GC, gc_index,
>                                regVM_L2_PROTECTION_FAULT_STATUS);
>                hub->vm_l2_pro_fault_cntl =3D
> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROT=
ECTION_FAULT_CNTL);
> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_L2_PROTECTION_=
FAULT_CNTL);
>
>                hub->ctx_distance =3D regVM_CONTEXT1_CNTL -
>                                regVM_CONTEXT0_CNTL;

--_000_DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2DM6PR12MB4958namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:931626053;
	mso-list-type:hybrid;
	mso-list-template-ids:1848386526 67698689 67698691 67698693 67698689 67698=
691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Lijo,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Right, 18bits are b=
yte aligned range of local XCC register, 16bites are dword aligned offset r=
ange<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We find the normali=
zation needs to be applied to many functions, like<o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt">KIQ: amdgpu_kiq_r/wreg/
<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:=
0in;mso-list:l0 level1 lfo1"><span style=3D"font-size:11.0pt">RLC: amdgpu_v=
irt_rlcg_reg_rw<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l0 level1 lfo1"><span style=3D"font-size:11.0p=
t">KIQ: amdgpu_gmc_fw_reg_write_reg_wait<o:p></o:p></span></li><li class=3D=
"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1"><span =
style=3D"font-size:11.0pt">KIQ: amdgpu_ring_emit_reg_write_reg_wait/amdgpu_=
ring_emit_reg_wait/amdgpu_ring_emit_wreg<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">For sriov gfx regis=
ter access, it only has 2 ways: rlc or kiq.&nbsp; Both of the ways can use =
local xcc offset,&nbsp; so we think it&#8217;s simpler change to init the g=
fx register offsets with local xcc offset only.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">HaiJun<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Saturday, June 15, 2024 10:09 AM<br>
<b>To:</b> Jian, Jane &lt;Jane.Jian@amd.com&gt;; Chang, HaiJun &lt;HaiJun.C=
hang@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under s=
riov<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Never mind, bit 16 and above is probably because of =
dword aligned offset.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Any reason not to do this in kiq/rlc based writes to=
 normalise all?<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Lazar,=
 Lijo<br>
<b>Sent:</b> Friday, June 14, 2024 5:20:30 PM<br>
<b>To:</b> Jian, Jane &lt;<a href=3D"mailto:Jane.Jian@amd.com">Jane.Jian@am=
d.com</a>&gt;; Chang, HaiJun &lt;<a href=3D"mailto:HaiJun.Chang@amd.com">Ha=
iJun.Chang@amd.com</a>&gt;; Zhao, Victor &lt;<a href=3D"mailto:Victor.Zhao@=
amd.com">Victor.Zhao@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under s=
riov</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><br>
<br>
On 6/14/2024 4:40 PM, Jane Jian wrote:<br>
&gt; [WHY]<br>
&gt; sriov has the higher bit violation when flushing tlb<br>
&gt; <br>
&gt; [HOW]<br>
&gt; for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bi=
t violation<br>
&gt; since kiq ring is always local, local address without XCC ID is enough=
 to be sent to the XCC KIQ<br>
&gt; <br>
<br>
The description is incorrect.<br>
<br>
Bits 18:20 represent xcc id. To guarantee all paths pass a local<br>
address, you should just strip bits 18:20 in kiq/rlcg read/write<br>
functions rather than here.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; Signed-off-by: Jane Jian &lt;<a href=3D"mailto:Jane.Jian@amd.com">Jane=
.Jian@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++---=
-----<br>
&gt;&nbsp; 1 file changed, 15 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; index e14acab5cceb..4e38a66a52f4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_d=
evice *adev, uint32_t xcc_mask)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_index;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_inst(i, xcc_mask) {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub =3D &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(i)];<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* for sriov only init XCC0(lower 16-bit) to avoid higher bit violation=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_index =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_index =3D GET_INST(G=
C, i);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx0_ptb_addr_lo32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_PAGE_TABLE_BASE_ADD=
R_LO32);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx0_ptb_addr_hi32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_PAGE_TABLE_BASE_ADD=
R_HI32);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_sem =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_SEM);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_req =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_REQ);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_inv_eng0_ack =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_INVALIDATE_ENG0_ACK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_context0_cntl =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_CONTEXT0_CNTL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_CONTEXT0_CNTL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_l2_pro_fault_status =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_L2_PROTECTION_FAULT_STATUS);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;vm_l2_pro_fault_cntl =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, GE=
T_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, gc=
_index, regVM_L2_PROTECTION_FAULT_CNTL);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;ctx_distance =3D regVM_CONTEXT1_CNTL -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regVM_CONTEXT0_CNTL;<o:p></o:p></s=
pan></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2DM6PR12MB4958namp_--
