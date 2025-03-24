Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF08EC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 08:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783BE10E219;
	Mon, 24 Mar 2025 08:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cx+iwNtI";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B095A10E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 08:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPzi9kk+2owZ2fFpmSvtWb+duVzGjI6eqkfOskCI1Y+YwEEjRlaQVWcRXXk1RJA7joj1kncAI97LL16ycrh51oqPNs12q4NK27m+otQqTb2SdrwJKIF7lLpTMV/wf2kgZOU0ttqNaHLLyJH3rkPek3+dXPTFgDtu+D6UwJ+Ux7u1FIyWWNen40Z+mqbmtrPFugyT1Rrx08kOPPJNY2apDVw44vfaxY99FEePmfqc7VC9JgbDc7f7EGubXn+H4DcRWb52PD5QSF5hERm9FIFTT7NxkaNF+2zdbMcKNHenefCD+oFsrk1zcOzOFFioTcQ+69VecSQ0OwAt5eecE8B5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEU6s2CbA3VS+sFFW6MENlbZvgdjPUMJ68pCTenjPAA=;
 b=GXQNncebpQDZuXS2Bcajq0WiAYKrQFCAhB7wuTKb6Hu67h/qQGkCiEqrjAV1KhHSvPC4VhiDTBdNl/g8TnPo9iXibRsB9CcSaJj/yVlak+9xnEoihZuZuLWmTHQHN+vLHdPx/R0pdl0Z4jP8beBQsXVc42M0gkOc/SpLDPgroJEJAlh7RgWpX3Z3BzlcBJrRP4+jgdju6MmfqIpf40gy3UUZeYyc5eC5AXUBTxAHxj3bdmQ3sg3OMMzCM6/IFUN3OsraW8N6hBC7iArNh2YFF+4Z1UOe5SqbFOgBDpD024IJdsfKUqAufdB3DNVbXymWlnChTucwumrFWLXqGqbzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEU6s2CbA3VS+sFFW6MENlbZvgdjPUMJ68pCTenjPAA=;
 b=cx+iwNtIFCvYkQ/SVimnmqNY/aeyTA9lyAAwCN58ntI8dHRSleymiBoNQrh0TeQcnmOYuSKK40L5O72OoVMObL2LP/jLzYO+nObfO3v61wgov0S2fZySOJRMP4qcNJQ5Qzyv1oJaMJ4siU3XlCi4TgWwoz2pLnXt83fDtk1qGVU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:09:22 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:09:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
Thread-Topic: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
Thread-Index: AQHbnJKbEHBA4qdRYUKNgnfgMNNFP7OB7u7Q
Date: Mon, 24 Mar 2025 08:09:22 +0000
Message-ID: <PH7PR12MB8796AC4778FE646CBC57244CB0A42@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250324075833.382787-1-lijo.lazar@amd.com>
In-Reply-To: <20250324075833.382787-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6356317c-f4fd-4e88-b0be-96f1cb54ab12;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-24T08:09:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV8PR12MB9208:EE_
x-ms-office365-filtering-correlation-id: d5a8464e-df2d-4acc-77d8-08dd6aab2f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0rERn8oIS3mwxIG3pi5kHrUOVZiaAlsazaX+D0yXvvK1S4LVQyiXD5ZvxASO?=
 =?us-ascii?Q?Z/SbA73wjWp+YR/2Tg3g669ZA65rJgui/Vyq07b2M1GidIHaqaq5z1QKkDtk?=
 =?us-ascii?Q?TO9SCpJ6099dl03hJ50Bl1R/rb0vUSwc57X5qydM5vyp5ybsiVquMVJBWYk7?=
 =?us-ascii?Q?s0tlyQdCLpG2Dwg7TiU0gkzIjLkjiO6dcO7VZQmt+S4fjQ8jS+DB4EvRx7S0?=
 =?us-ascii?Q?jroWxD/2112fQaHR/7Xiw8O7+Iv7zuoImR+b7TlUD3jJt3ELuGxePl/w2yza?=
 =?us-ascii?Q?Gc1BeYS+YzADzZqhHeGHYbJot3QsNTxcBm4czVhA+JQX8gSZSTZLn7JKGjVP?=
 =?us-ascii?Q?BeLpnkxO+FJ6iVmAFKoBiWzNnwTXV0a5atuIrVW0drUdT7ops/LgAf1aq0CK?=
 =?us-ascii?Q?ib6mnx/GT1jf3X7p1Jo+sTEwE/26mmj6wWZTSEvgwMCaQFNCrOcQYmvp/uYp?=
 =?us-ascii?Q?LRi9Cj6g6DUir8fwJ373P0YEXECD0txX2/Op6EfaRohGyeA3R+QrMg+oPuaA?=
 =?us-ascii?Q?73wmrrAqOLUifE6Bi7LO3zHzdkRTDPZGLZty3JLvEf4B9jzk0NmP3+uKmWfs?=
 =?us-ascii?Q?roMhTxx5dCf/fXDA0ZgVpxgSO8Kqpv0S3Ke4Qhii2PO/1xOqxtJJOxpUy/C5?=
 =?us-ascii?Q?P9Grrv410GUSDE9PBTriEwgfLQc74zvYunWnAR1JNizQEnbhW0o/PMtz1MAQ?=
 =?us-ascii?Q?/27uUCA59E6i3RU6wv0rhCyljP4W8mBCXa5lVbXtY0/hbIfkm9T16lf/megp?=
 =?us-ascii?Q?vqyDZXgV8CnkAmDXgEubS4GtwaZRAhrog4Adddpy+qNbump7Ab4NLYmr6F2f?=
 =?us-ascii?Q?FjgZkUHb3oVq5Qz81FxOdELuaQN/0qyWHnaDenY8R2Yk5GL4/FKpr+oOomHs?=
 =?us-ascii?Q?/bmE44rGJWyFlGtNoDH/HzFk5sGFSWAD8NncmpxWm/Fngvltrhc4TAZed6hz?=
 =?us-ascii?Q?rpPoTGaPf/rYK9FtCuzfniRlbzvQKSaniw0uyu38rXGqAZZ4Rng8+zkfnfox?=
 =?us-ascii?Q?hPDpgrildUeeEBOpmTgBNyGstIZhXVWsCz0+PppljQfTVVtyBlkJSCfN0uCx?=
 =?us-ascii?Q?L8ECirkdc66E+KfaXxky6cakLFRsOwS8C4Bt76kDwvjs1C+KdHhsz8ag6QBG?=
 =?us-ascii?Q?VSnZhPB7qZvp2P9/g2M4Ou8S7CpLGimC7tUXB2M5vxDuDr2C/xG+nak4k2g/?=
 =?us-ascii?Q?sbhGYI7cfO1UcCD1z68N2Vqz79LuxefSm4Gv+Z/ZmOFDj2hA5Ao3/cSC+yjk?=
 =?us-ascii?Q?Qce3kexLpd8y1o6NCmQ4iCNZDo0KECdpVw5fLZC7/+jq/ZZc1at/7pw1kedX?=
 =?us-ascii?Q?97Tx8wo9ZdMr+yQsqoYCpVmZzJyaFvODzNcrJb2CwzGEXtZApGl0fQGhASAX?=
 =?us-ascii?Q?5BCb7NcuKtyvUasRRIGzDEF8ax9W8AbnVwKqL4RgfRF6RdejtLf5XcZcUtbt?=
 =?us-ascii?Q?L2qtpIh9TffXHjQuEyHv8ZQcfmGXLrTl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dTPCsOcZrdgtl9kvtTI1Or0SK0XZHI3bYfwYj9/i35gZzY71Zs8MnxRRr4V0?=
 =?us-ascii?Q?nfpVu2IHXwOAlpTlHZpWqjk89DWqELG7Fs6rQ1ihw/8OSAufkMBeGfzmaoMZ?=
 =?us-ascii?Q?wG3oc11CpWO33QKO/1Gs12eqc3Y6Gmabwn+lNKwIDatvQqJKhDggO0TKmQyJ?=
 =?us-ascii?Q?/3Ust03zJvMEYYm9zaj6Dtz2eBoKlsKlijklmuv1DwJM4ES6FzukE5cd6Y53?=
 =?us-ascii?Q?9LbkiS1EogTX2vve0UsvaGYKEPHTcURbJWfJkvUwJXcd7vy8J/NMznDG6x8/?=
 =?us-ascii?Q?+Bcu7DxtSlIdDUlurRlMJYRA9hMUmWKLw1SoXGPXmHHLVH6w7isDnsaX/1IT?=
 =?us-ascii?Q?EAPNQ8AsJUUNJuivffnrvU1+dCM8iP74iHJEfcFVBQS2jJtEN173DySOj+A1?=
 =?us-ascii?Q?rZkNzy7Z4Cvbn3O5zF7HMebaCvqkXjN5rb7Y+gWMXvg6F+hphzED67kI5qkd?=
 =?us-ascii?Q?2sInFshChnzw1EKAl3rQn4xCxTxJ+MioijzpTH1zOePR279lU8xTR555uY/o?=
 =?us-ascii?Q?Q7TuaB2M281f576EAY5EgkRTKO/3YLX06ydYjD2+tclyVlwp6rC/tCZgE05P?=
 =?us-ascii?Q?tkT92oBy011Qa4cxnaP5want64wu76jjTNgYxl2JZ6/2+saPROHR7nK69SLV?=
 =?us-ascii?Q?CNS0HgYO/W4Hk+n4HZ5n1hS0mZMM3SXbscrX+7KyPIQxN9Ma8ah6ThXwZ9jE?=
 =?us-ascii?Q?+enSU4/OLGYPbN8CMdyeY/ANhekGzXq8nUJD9m9F9fpCJnM8b6nC18pmjF07?=
 =?us-ascii?Q?WIbyzJfc+3ZIaaoBkIV79i9tmBoJaCPKf+F0cdVTiLuKrxh8QLtfZKZ2mg/5?=
 =?us-ascii?Q?SgXJC1iQfWRzWC6rVm9JNTSeam+ZodRDMPA2u9yVz9AzVWAA/JtRaY7VA+Ao?=
 =?us-ascii?Q?nUSLREMaizLTdX8s/kahh4SDccYvlE6XRU4ErT2qvp/Xhsz1jBaSUcHzMtl4?=
 =?us-ascii?Q?Ix/ofXuQ6yq4N4iFpdJFMsQkERcLRSrXFpWJIuT3w6O2W2jOJBXCO7B7XmQw?=
 =?us-ascii?Q?UgOquxEicGvWF0USUVI303MeFpkUzhPOJNvQvN/JKFsVevjmCdzBSnhgmRT2?=
 =?us-ascii?Q?Ook6nqbvV0KuFmtgJ4wGn3EJKB9q615PNkkdCPif6J7fcHTUT+jtwXSuO48B?=
 =?us-ascii?Q?OLq44MQNTLgTknyOOYCEH9ydKs156l/bFWA3uwr6J0TlulH/nUyX/kmLq0kA?=
 =?us-ascii?Q?8g1fQBdzKgtHEGMtt50kULmFMReJn5yG0IEcZBB2Z+KQpU/Y0tdyVf9AohX0?=
 =?us-ascii?Q?ouDR4tRzsYRMwTrRxAfcl9RQP1b4r8BDhpg08RzIQscTGlUpzFU9dKiFTn4Z?=
 =?us-ascii?Q?TJ7RbHSQlBs+6vbMKE3Mn5i+dnUO9QRO/DcPU1JQUF2u3a59pI9EW79Gx1FV?=
 =?us-ascii?Q?UBTKQFv+3couWXkDxDGimxT99iSP3eM+Yp8aCWymJkus7ucJm5ZntuoVjnFE?=
 =?us-ascii?Q?3Cl0GoyisXn4YLNVXlbxCkAV70DFtPN18nyB77jMLi4s1oRKLRO/AObuFJ3c?=
 =?us-ascii?Q?rWnxOazHWvyFH5THjIipvDBRnf/JszAGDKuoZHPRLifo52VcEmGswSGDhNNH?=
 =?us-ascii?Q?76Am191MIzfW0v+d5do=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a8464e-df2d-4acc-77d8-08dd6aab2f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:09:22.2911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bckZGCh7XnjagLE2WlvL9tx1p+oXPfcD2UWsDwQNGuqwWGXyDJ4nVIagz2pV/ohN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo L=
azar
> Sent: Monday, March 24, 2025 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
>
> Compute partition DPX is possible in NPS2 mode. Update the compatible mod=
es for
> DPX.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 3c07517be09a..ae071985f26e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -473,7 +473,8 @@ static int aqua_vanjaram_get_xcp_res_info(struct
> amdgpu_xcp_mgr *xcp_mgr,
>               break;
>       case AMDGPU_DPX_PARTITION_MODE:
>               num_xcp =3D 2;
> -             nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE);
> +             nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +                         BIT(AMDGPU_NPS2_PARTITION_MODE);
>               break;
>       case AMDGPU_TPX_PARTITION_MODE:
>               num_xcp =3D 3;
> --
> 2.25.1

