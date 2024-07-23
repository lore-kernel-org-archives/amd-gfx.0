Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED0DC3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F5910E559;
	Tue, 23 Jul 2024 10:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aYPnbXX";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8264910E559
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 10:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keghSYqPkAxou/k7EToP8g7YwKQw98poXutdb/9c+ONWjqsn7BNk68Hl2AgPcn3BCVhLe1wgXKea2DcnBLrjrDAp/AjqfISEyQLtsCLAHi+WlEBhFxBqG0BqlUdIBpuTvlp7vgno+9EqVDaIkn6QQFaaZiz5XGxoNOPiCBkWF7hO3ycgLPktWgtFnGSioAHh/twBB0znqqJfZwqnzN5P0GjNRShYoOhdJ7eafqD3pi8iT9QCWWEL8qBN9GE7vyWTDj1RII0yRMBdRsEpW7/c/O6KfJfV+H6EcEuu+feUC+Cb+GzLc7PVYrbkiatff/Hs9v55HfMXc6zGfdkcITEWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOxasCQUNhnL+yhaqNk1R20UyUN3ZC9Sw13qVLaf1PI=;
 b=KJ2E3PrsPiRlhHbSq9P/BcwYcfBT69bOuwwL/QrLG6JfDfObt+OEc6iVI8FNTjNZ9I4vbvLaU3jA60jh4hfohkBNo+Ee+qHhDalTM7e3LbQ9LZzKn8kPJ+0cOLgVjridJj0QzQlM2P5Ll7ml/Ax33zBjKbc4WV61cpMZOuAn/wK/AOLOWj3k9IuR3FnnXf6e3h2a1/moUnuq5Cj35FKEKQ99tY6S2JD5PPTsSCyLeew8mr4W0WJntPEab51ha3Ogssb9uhNiSUzCz1BCQCjLD7cwdhpq5zFx2LI+3CJw/9/yws2b+GJChuxNV86OrNWd80+VxPu/mkZ8m33S7Zn9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOxasCQUNhnL+yhaqNk1R20UyUN3ZC9Sw13qVLaf1PI=;
 b=5aYPnbXXGIG1e9qvI5lowDFORMf4eTfCPm+ltTW+ni3rvvdEoPixdflS0fQlI/fQkT/Dcwo6p+gpIpprXNZxdNMwHkOatgy146Ym/Y3dOZCfQRivti57752lpXIvAMZyyOkfRA3l2cvnbeqQXZXozifYvVS7CrJyPxAq5XTnuE8=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 10:58:11 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 10:58:11 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "Ma, Li" <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix potential probe issue for VCN IP v4.0.6
Thread-Topic: [PATCH] drm/amdgpu: fix potential probe issue for VCN IP v4.0.6
Thread-Index: AQHa3OcqL2GPHdGikEahQVCbeQioqrIEI60A
Date: Tue, 23 Jul 2024 10:58:11 +0000
Message-ID: <CH3PR12MB8074B7AEF17C2A3116EEE77FF6A92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240723095850.296140-1-tim.huang@amd.com>
In-Reply-To: <20240723095850.296140-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e0ae8dbe-86f9-4d02-ade8-324a7e518b55;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-23T10:57:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB7554:EE_
x-ms-office365-filtering-correlation-id: f346cbd6-7c65-40e0-ceda-08dcab0657f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WmKA03IDfh0gf74pvFfi/kh3qxwlEhlwInyefOrHXuUidkIbagLWqrDOGdTI?=
 =?us-ascii?Q?H1va/GyzR59n2UCioxPcXTPKlVEpISeql49gKR1cFPyEmygiiLET6iLWQeOu?=
 =?us-ascii?Q?UXGk5zxm0b/DGGcb5NNtfu8j1VQ1s42+tLPFbi55/mXxILtktHQKgCjKHHUk?=
 =?us-ascii?Q?kRmTWkPKYIb8c0eV4oDUt73lyBt2VOpHii5y5UEPqUMEsnYwJwJmZu0QX9Qe?=
 =?us-ascii?Q?3FRamL0tAR3EJAc4xuiMAxq0eDTaUPLKD1VenAKokrE1Ynb7nlxvn8li4f1a?=
 =?us-ascii?Q?OmSpaUytukOL2Kuq6S3+rQOdCT0ECmydsnHFPNkzhV29+0NQGWSxNUf5/i+2?=
 =?us-ascii?Q?F47CpGxq+Ltdp1XqznIUADtxmQPrl2NsujJnJMVC3to/bYq8XimZgpMG7ofF?=
 =?us-ascii?Q?ElJi5avIzuaq0fmDLaaGWST13vfKPUt3ZEJkavEzJrdWGLSi290v9KhkyZqu?=
 =?us-ascii?Q?vUiJUJrGWlZZPNQwnKULr7AqGT2x4kUzcIG5LJMtGyIXbL6/HwELTpUC7114?=
 =?us-ascii?Q?ukFVw46HlvmeI+TFnzmzo+AaeO5oSf3vwWbR7x8QTqU47OldkYCXjN5oF5bQ?=
 =?us-ascii?Q?0wh7jIGYxh+RYGSHZ1H/0eTTwSH3vz8SMiOBCX1lo9TCUqskZSr7W9S5ct7a?=
 =?us-ascii?Q?/6HDejPJ9qJ+auQ1qr9t3apGYTA5S+v6GhIsG3YUqfxDoxwuz34lTrIYAuKB?=
 =?us-ascii?Q?E0PA/F58MJz6Q1I1rrOstBZA9fVDjzXlCC1+ygyAUOzwbxF56MnTi83q2zNj?=
 =?us-ascii?Q?ecI+QmH5XO3QEK4mxNVHfUVQu0qXDJW/fMruuLjcPUGu51mxBzPK6ElN0mZe?=
 =?us-ascii?Q?bjZvbctP3sRrpz7hYGp0CYD8KP8cS2QOa6SNvmiKNnd4cy1k1JTU7fgM90fO?=
 =?us-ascii?Q?Ejy6oSh2aibIypiMkd4eNdlMuCwteG0Xtndq0DIWU7bu+NjzUjV9A3y3r2Ba?=
 =?us-ascii?Q?S2HzsEQJ4Fm72GVEJ1vz03AjjHvpU8vlPMOaz1FsunDme/VXCqLnaZywSR7h?=
 =?us-ascii?Q?BPS0VwzQMjIf3gBWk9EYILUz0B6YSE37X8kyeC/po2TYz7tIJDlofU0YL6HP?=
 =?us-ascii?Q?89Pruvz+H1YhBgT21pQ8XYF0MomQMEA0+4z+RRkPnkH4K1GX3YG7uiZGAIgD?=
 =?us-ascii?Q?k4H+yPgBWnuQYZTZaTHe1IJw74Yd7Rrug2KdPiZ3K3qH3INzjfcQRYBgcsuO?=
 =?us-ascii?Q?MJiNVi33vk2Ubz+JP9/CkL1QAiw8RWKuHvnKjHQ0sFyCLZq0+SqUcdmzBUea?=
 =?us-ascii?Q?yiLiwTrJSE/rRhmla23V+DSuvg9x0cl9FwEuYK3IGQnuNJRGukVSQg5MQ8J3?=
 =?us-ascii?Q?wNs+KTXr5NC/oi5asYr9PSsIkfB7tEpuiNrz0DwOGFm8g5YbkpPpQUtY6d9z?=
 =?us-ascii?Q?tpQ7PTq1uKdsofdbdQ7HQpqyZWUIiOO7VpJwUCoR324jPpfcVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlRLGtXM2b21kI7GdW3EVJ97t3oOqQtToEBqOc1JlKWWK2B+xsJL//IWJVKV?=
 =?us-ascii?Q?DBwZX/jtHfHBpdW5G03fVgkG2/T5F8k2RUP07oTE5voJ9FFUgco6SFQrRgkU?=
 =?us-ascii?Q?BoSevVbzmpHExWJTJ1E0mMfVK/xZ6HcarNvr790lBGJhZtSltbEK7KJmOOi5?=
 =?us-ascii?Q?lixW3vMFkLgr54JPuSAyoVy+yvg3sUR9QQSFGkObEJK4Y1U3VXPrf+668Blz?=
 =?us-ascii?Q?G7CLCNeTUZdOWnIRFK0FPhMlIz48DT/h6WhlgNhmQQnVYYELFFAkUUCifA8R?=
 =?us-ascii?Q?JrpQw9moRrnipBA8ANSraqBniPiiTcLruqkDCPfexRBDOSCVHUFW3NraBRHF?=
 =?us-ascii?Q?7veTW0fjaFIUGPBki8nAVatdIspO1ZACuHrnB07Q2ymg0aprXEqn8WJC5xUW?=
 =?us-ascii?Q?N/L4jcegau79be/sPPtMgyGelpK6jrmn8d1fBPZgu+FE/T4HB16i/4brx8yu?=
 =?us-ascii?Q?599FBpZj/v4f2QGds/UfIAYoNSv7m27s5oqaA0O1ir6tZ6LPLe9JoirGB1PA?=
 =?us-ascii?Q?S0xY/n3wBvXdJSeyqx+NeMV4qUWx1tBBYijQ7OOf3G8C1b0QJ5F1nrcD5olu?=
 =?us-ascii?Q?Fg0+mlSfg6ZIIBM+MDMaTrJixX+INnsO2783ebuK+NzPsfhI1qwbMnWylNq0?=
 =?us-ascii?Q?ldpFtsSDOAYArc8Sx/mfj3tEThXIr9YOtmOArX/Wp7rC9JHIyqWu+JAxkoRI?=
 =?us-ascii?Q?zMDqEEZfoN+lKNKiW4OQt5iEWmnlpvPgjwyP7PZ9yFJZH91mCj53UlqP+0Dz?=
 =?us-ascii?Q?broGLkFbthzay1STNX5DGRIJ5YMMG12/ifERrD90AvfBQ6z72293QM4EKJbp?=
 =?us-ascii?Q?jMtCZqJmSAFZ5fM/6aAGabtNGq+/6ezPjpgispsTdFXglEFstWZZRlzCobL0?=
 =?us-ascii?Q?J0Do4VEbPZZ2C2tRjUwjymriuhDQ6DK8PrPW34plEz7+g+IXJyrElrJOqHtO?=
 =?us-ascii?Q?uLkEPZ97Jck0HxToX8cfaB9P0HuFfsXQRnEECyebApCc2Fzigda2h3a7dL5x?=
 =?us-ascii?Q?GSx6Bm0FvOciofQjjCpWf0aviznuosvMXledAY/OrkzAqiUk4zW1WjcObmzB?=
 =?us-ascii?Q?arjr/GXXi8QiyJTXWsObELyCbMgG9X4hV1yL26SNUhkZ36+fP55XrdVf5Ogi?=
 =?us-ascii?Q?DWUzLFLAMStdPR899RJJ9A0ycQUR37WtLEcma3n5fOZSl8Qa9roqBQix7KdB?=
 =?us-ascii?Q?SJ9ODW5uxrRk1NpPpOMEBC0JXGGGIA8USOu4MtO84Rd1uo0GAuLmF6PO7MXs?=
 =?us-ascii?Q?CfLV63zbxHz4wZXjdlXAgrNG9fBa4DxVjMn/hIIvnhBakRAg0xUmQL3z4yEl?=
 =?us-ascii?Q?emFhlvTzBQ5WpK7CpEjPi/GrztlPUocl56BGJYoKIz5cAKuiL2pmoNoVDGZU?=
 =?us-ascii?Q?nnJwibMaEWOQS3yXwQV+Mhnm8412KooRnPOrFPxT6BxcjN+pkRaZvCwowPtv?=
 =?us-ascii?Q?ioFJHv/tg0byJypOMhw5hpHEJyGqBnBswuPoUSqr6TK1d31bNNG+hEJgdQn9?=
 =?us-ascii?Q?GYELHL/RFFDv14SvKFltvAYiOE7TsWRmFFzGMpXncv0TcAfHTDZPuhkqjRth?=
 =?us-ascii?Q?bsvYqwBRJkevrhAnt0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f346cbd6-7c65-40e0-ceda-08dcab0657f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 10:58:11.3375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1C6stSO6poqXXe3XOtYf9CBzOxU5PIqhhIgUil0HBLu78Qj/+Wra9Dvme3vRZEyP/PgeI3EoI/43MdlAGzeWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

Please ignore this one, will send out a new one to apply the same check to =
more VCN versions. Thanks.

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Tuesday, July 23, 2024 5:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Jamadar, Saleemkhan
> <Saleemkhan.Jamadar@amd.com>; Ma, Li <Li.Ma@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix potential probe issue for VCN IP v4.0.6
>
> To prevent below probe failure, add a check for models with VCN IP v4.0.6
> where VCN1 may be harvested.
>
> [   54.070117] RIP: 0010:vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0
> [amdgpu]
> [   54.071055] Code: 80 fb ff 8d 82 00 80 fe ff 81 fe 00 06 00 00 0f 43
> c2 49 69 d5 38 0d 00 00 48 8d 71 04 c1 e8 02 4c 01 f2 48 89 b2 50 f6 02
> 00 <89> 01 48 8b 82 50 f6 02 00 48 8d 48 04 48 89 8a 50 f6 02 00 c7 00
> [   54.072408] RSP: 0018:ffffb17985f736f8 EFLAGS: 00010286
> [   54.072793] RAX: 00000000000000d6 RBX: ffff99a82f680000 RCX:
> 0000000000000000
> [   54.073315] RDX: ffff99a82f680000 RSI: 0000000000000004 RDI:
> ffff99a82f680000
> [   54.073835] RBP: ffffb17985f73730 R08: 0000000000000001 R09:
> 0000000000000000
> [   54.074353] R10: 0000000000000008 R11: ffffb17983c05000 R12:
> 0000000000000000
> [   54.074879] R13: 0000000000000000 R14: ffff99a82f680000 R15:
> 0000000000000001
> [   54.075400] FS:  00007f8d9c79a000(0000) GS:ffff99ab2f140000(0000)
> knlGS:0000000000000000
> [   54.075988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.076408] CR2: 0000000000000000 CR3: 0000000140c3a000 CR4:
> 0000000000750ef0
> [   54.076927] PKRU: 55555554
> [   54.077132] Call Trace:
> [   54.077319]  <TASK>
> [   54.077484]  ? show_regs+0x69/0x80
> [   54.077747]  ? __die+0x28/0x70
> [   54.077979]  ? page_fault_oops+0x180/0x4b0
> [   54.078286]  ? do_user_addr_fault+0x2d2/0x680
> [   54.078610]  ? exc_page_fault+0x84/0x190
> [   54.078910]  ? asm_exc_page_fault+0x2b/0x30
> [   54.079224]  ? vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
> [   54.079941]  ? vcn_v4_0_5_start_dpg_mode+0xe6/0x36b0 [amdgpu]
> [   54.080617]  vcn_v4_0_5_set_powergating_state+0x82/0x19b0 [amdgpu]
> [   54.081316]  amdgpu_device_ip_set_powergating_state+0x64/0xc0
> [amdgpu]
> [   54.082057]  amdgpu_vcn_ring_begin_use+0x6f/0x1d0 [amdgpu]
> [   54.082727]  amdgpu_ring_alloc+0x44/0x70 [amdgpu]
> [   54.083351]  amdgpu_vcn_dec_sw_ring_test_ring+0x40/0x110 [amdgpu]
> [   54.084054]  amdgpu_ring_test_helper+0x22/0x90 [amdgpu]
> [   54.084698]  vcn_v4_0_5_hw_init+0x87/0xc0 [amdgpu]
> [   54.085307]  amdgpu_device_init+0x1f96/0x2780 [amdgpu]
> [   54.085951]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
> [   54.086591]  amdgpu_pci_probe+0x19f/0x550 [amdgpu]
> [   54.087215]  local_pci_probe+0x48/0xa0
> [   54.087509]  pci_device_probe+0xc9/0x250
> [   54.087812]  really_probe+0x1a4/0x3f0
> [   54.088101]  __driver_probe_device+0x7d/0x170
> [   54.088443]  driver_probe_device+0x24/0xa0
> [   54.088765]  __driver_attach+0xdd/0x1d0
> [   54.089068]  ? __pfx___driver_attach+0x10/0x10
> [   54.089417]  bus_for_each_dev+0x8e/0xe0
> [   54.089718]  driver_attach+0x22/0x30
> [   54.090000]  bus_add_driver+0x120/0x220
> [   54.090303]  driver_register+0x62/0x120
> [   54.090606]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   54.091255]  __pci_register_driver+0x62/0x70
> [   54.091593]  amdgpu_init+0x67/0xff0 [amdgpu]
> [   54.092190]  do_one_initcall+0x5f/0x330
> [   54.092495]  do_init_module+0x68/0x240
> [   54.092794]  load_module+0x201c/0x2110
> [   54.093093]  init_module_from_file+0x97/0xd0
> [   54.093428]  ? init_module_from_file+0x97/0xd0
> [   54.093777]  idempotent_init_module+0x11c/0x2a0
> [   54.094134]  __x64_sys_finit_module+0x64/0xc0
> [   54.094476]  do_syscall_64+0x58/0x120
> [   54.094767]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f45495de6875..8d75061f9f38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -958,6 +958,9 @@ static int vcn_v4_0_5_start(struct amdgpu_device
> *adev)
>               amdgpu_dpm_enable_uvd(adev, true);
>
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
>               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
>
>               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) { @@ -1162,6
> +1165,9 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
>       int i, r =3D 0;
>
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
>               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
>               fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
>
> --
> 2.43.0

