Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32ABC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 04:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A57910EC99;
	Tue, 30 Apr 2024 04:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzTQmh2I";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9341D10ECC3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 04:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxUf9f1HfQRr7uJ2dYp3vx5N8IMg+qvkLzTpYL7Q/mP+yDFLZuOLY1Vy2DlwMJtADN3jI8CaY9hIrXMoGA5V0LOIIRGnSzsFFyx5W3ENZ7Y9lHjlcZLuhoqdQ3BPS4bqeEL3HHXm+CxjGWAjwC5ZXNENGzVmM3P3pDyhSAeOQ5aReurgx30vFEwcGEXZtAKaHSWmJJn33r6caQlAmGc4SRLMfZwE0FoVoBY8AXVvN4ILxCObeGnFZWES/Vk2/25ER548Mcw475GvU5694UQGLdpRYsoElpZH/4QGnLaHPIOaMqkcCukShzvj9QqthLrty+2HsGC1l9QEf2/Y0ED5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4qj9O1bpPpOopajQjsxsotAwJSJP0ZHuwgL9tn8kZU=;
 b=O6QX/zxoWw0qwv9lJgZk0fGkKJqxpJbZdOSuxZBNzzHQ3ZrXpuBTxwjq9mnnXwvF5c50XYcaLNI/txc6iI95/sMaDe4Wb8NuXZSvTq0RClLZK2v5UpshfW7yT2LRI7RHqbOmc8nWUpZStTf6rUyZAaUGqXXMOOTr368oT5RT4twpS4FZ0FzIspi+c2poYBdQhaiEK241i/vmxEChq3eC/yVspEQkoFGTGoqRKFi7JGxxghwCrCp0agxVte6Dz5xAU+bUIUK0adWXpr45PbreC0efh1A1F4+U+RMcWIvIWiUZVO3bwz4BRQiQK6qUJFdPafKHRAhuynZwOKotp+GfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4qj9O1bpPpOopajQjsxsotAwJSJP0ZHuwgL9tn8kZU=;
 b=vzTQmh2Ih2OU2/7ZHw44O8OkJn5mK6tmEX8mr15G8zpNTtWLFPy3iSXDFz9SnZx/VS9WD5aS6GGNz4TolHti8kPhMlVKu/E8XD8mZ5hDlQfrqh4uEy9G3yEE6jwuDOcugP9xvQBlpxQHmKiVfkmEjGRy5R9IhLWi/3deuqWDxms=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 04:51:10 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:51:10 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHal3fDuIWs75r2/kCois466O5n57GALpJggAAMBACAAAhy4A==
Date: Tue, 30 Apr 2024 04:51:10 +0000
Message-ID: <CH3PR12MB807453093FD198A33E7F8361F61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426011426.1340586-1-Tim.Huang@amd.com>
 <CH3PR12MB80748CBF93E22B4B8E4D138DF61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
 <PH7PR12MB59970CD6D5438368938B597A821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59970CD6D5438368938B597A821A2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c21f75a-151e-4cb3-8e19-d7f3c9b4a995;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T03:30:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CH3PR12MB9026:EE_
x-ms-office365-filtering-correlation-id: a899620b-81c3-4f14-631d-08dc68d127a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cVuq8O3x5tTVCm3FFaX1JVg0Sp9BGHapFAe9CCY76LpWK69AsIjiXvGMPAH0?=
 =?us-ascii?Q?uvPSNUatib4GkLfzw5Bx73+zXiM4FEy8QdF1StTsLoVOHHFien0Ne2CN0Vp5?=
 =?us-ascii?Q?G7HY0F5A0Vn688dj6GGGocPI3dMS/3mg026TSmWmjVKfkM+BVJXPx4p0aPN8?=
 =?us-ascii?Q?6VTLEZ/IP7QsI4lMq5Jqn4PisKRvbu2Rq9pcU80ecr9BJeFrK614o+L1PUsO?=
 =?us-ascii?Q?rqfwsKU3CIbiFFd0NjYJbmy3NL84QnS/RJG5dR5n39Y9CrSiYWGRsNvn0oCj?=
 =?us-ascii?Q?T4FS8bVeVGV3+psWd0mql5ZHF/O0LA3nQChY+cRvvPZidQ3V42jFKKd0+Mtz?=
 =?us-ascii?Q?HUZwEUSKuw8vfvqtFwhX6+wwPCoTRz0+l1zfnTr2REINrs4DO84UeE5z/Xqu?=
 =?us-ascii?Q?1eNMpFeiD9z4CJMgDs+4RpKHEk2uiLmpP6h9EaATtMqzTPl1oNUm/WwdTfnm?=
 =?us-ascii?Q?fOsUWHu7uheXx6E3Tn7+5yxz4lebgzF1OQwZyvsWUrFW8MhPYRRQHVYsUvsp?=
 =?us-ascii?Q?WSaeGYYr89ZnK/hU3UXiJCfODiDuA5FPf7ItSoK0vjnK6rMNNbfwhYsl9XSp?=
 =?us-ascii?Q?OvoD4eQRWtTNDKpaDxOOWforQZs5EQRDAsyLW3x6yCz1yFfHj5Fi1qOzHT6w?=
 =?us-ascii?Q?0ypxy/dLr5jo97k+n0JNZChBBY9FfvuVB7KX6C+x0SRrAbOZR20MTPhXDXFa?=
 =?us-ascii?Q?/3ilEAjT0NioB1i7H5wYTlPZN3BDa9xx8M2cuj5wFJDgXbOE02KLPRQzDPIQ?=
 =?us-ascii?Q?mxbSRnyhZzf2YJUL17dhfiIKfqiHdDyM3iyiJZRdR9IrxGsfaNgUf7AR41ZU?=
 =?us-ascii?Q?Xv6dQqA3wMZUNAxRErerppNCe5fuMga7ntDAGUqx+KHugZrvapwCRpE8HGrW?=
 =?us-ascii?Q?2DZLyJWcjSrk8o/R88hvlGiEM3cHLLbtlm4hWR3x2NGWx87taagpYrly2nkV?=
 =?us-ascii?Q?tc90Lb43QDeX3hiZeIbHfc+YwpLQDDTbM4CLbcYz6JYddWgEW+JSHl/YjuN9?=
 =?us-ascii?Q?y0KX6LurvVbW6HU0FLP30WyTgdxVm7yz/pcDp+UwZJXVc4apmWWEnJLqhRSV?=
 =?us-ascii?Q?dAXM2U+Hh9205qkm3zJle0qyAR66Tbygq3UD2Y6/5knnCZTlhJ6MuOlyzflv?=
 =?us-ascii?Q?Nsj9A8yrBltmjfL/frurWjLl2o5uhOF2JL5EsXAUV1Ic5705EJkvZcv3oo3u?=
 =?us-ascii?Q?I/4+oyv+syZJu0s9Crroi5bDDxezK4BqGmpkACiO8N9M43zu4AZnzJust11N?=
 =?us-ascii?Q?FICJk+J2eWv/eL96xA4ihCEgrmJSyooDATGUOcSiCMmvVBBX4UIr3vMj1gwq?=
 =?us-ascii?Q?VhNqEqoP4Ew9sLqAWJQl1dfO7yBYm3BNTYP1d0VcA4Jd7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qz9Mc5tslMbHMg1Sugo1bXPzLfuQNiNd+ngst7xO30Pe8hA0tHALCMQtQOjA?=
 =?us-ascii?Q?WBs70XrMcgASzLqdxn0omF1oA7ylbPTadPjJSKOWEA5qqnAdYHmmUbjIpOdW?=
 =?us-ascii?Q?VfSb9nzCkz4BkoXpfEo6tUuAEEh84CVc/ORoQ5J60RcuAp5uOm5XBQXyEbCw?=
 =?us-ascii?Q?Urhp2vCamJitVf+s59c7rPiD51zcFd7sp0R6fsF8y82Zt7xp5X0wCfJCD01D?=
 =?us-ascii?Q?1/3k+tI7W+uJksdLofh02YP8+ykl3OUnLGavaMhgCwoAWeSrKC1CMzuAWRC5?=
 =?us-ascii?Q?aVoN2NuGdH+T2Mt+xu09FS97mBzIIq03kIjTzsSc3rdQnSZge9byVFsTKECb?=
 =?us-ascii?Q?PfQmRL5tAEB+lCl6XPZDUpqBzQIRxkaiSgM+FkZb4gRqiaE6bxLduel929fZ?=
 =?us-ascii?Q?E9WfCN9Lb7pJhpFuIX/0jZEnQj9Gev6dYEoJ6tre6XE2LQZFUsOyM9w6kY4g?=
 =?us-ascii?Q?qheEUGbsl1jesVpLfXkYZCnko80hcLAP8EbwibyofDcivZTZqbsuRhP1+2S+?=
 =?us-ascii?Q?T7xrBqYTbZ0MsH6x1v+gBFYVNvfopLnHVnK09xLVE0y+GAJumZOmvOgkt/42?=
 =?us-ascii?Q?+W44/ET61ui2A6iv+wAzFOm2xo+34huOzrb0JajkDVSnlOnfw7g2ymKRxAn7?=
 =?us-ascii?Q?BkAICCbDXIN1nH7VLfcR1WLElAREPHHLPM27KEc5YCoEHY/t53Vuezq5t30N?=
 =?us-ascii?Q?hYnfuTUvhVrsftF3SZ6ea8VF3OLfPn+TcfkpVa/35diYWKNY0TyTanXnkKlp?=
 =?us-ascii?Q?CAXCDqjPlsWupe3wvPmzUOXbR8MEbtku+7Mgjsb8b6I+of3XdhBPciAheYf9?=
 =?us-ascii?Q?wMpx1yI7i+s1tHT2J11N9NNmv4260CJhXoA4lcx8I12DYnbYerkZzfGNssLL?=
 =?us-ascii?Q?jJMt7d1lX6EYIJqKqbuUKitTGiGmBoB2jSQbOzUzYmk7dPMjtUbC6zO/TrLH?=
 =?us-ascii?Q?K73l7hnd8XwcJVHgzMLiDQzXANfA0KXiGaClKWmZcCFFuTEbK0ETE+vIr9b2?=
 =?us-ascii?Q?RnXhurWQJhCqhD9SPdizf0smp2MIPXjGZUjDk8MM6gWk9TSuVXs8S4NQozKO?=
 =?us-ascii?Q?wgkjMhiN+CF/F6Uq8PJvIvSDaD7jlmRun8MGR+JcqQO7ew5mv1ZoGfsRpF3I?=
 =?us-ascii?Q?QJHUAieiVXZt4ePxhlduRK4iGUdJQkgqLS55XonoCaFVmizvxcsWde0JSiwx?=
 =?us-ascii?Q?FCElbZB1iZwMXvSqhmoCMCIjjtMMm5GQEvL4LYnYpXcsx5wLiBvBzGgq4gxN?=
 =?us-ascii?Q?mmSLtnqbZmDTi+ORn5z4iXAyv+jAaTjoqTOqkv0w/Fo0VO7AjRRYpB1XWqBN?=
 =?us-ascii?Q?k+ij0fDyr09D2UpwwuSvMcwyPPv8T/axmo5ysfA2uPjx+MJOmOrlc8udE+vA?=
 =?us-ascii?Q?V59VTpwY7OsEpxDZjjAR4KTAtxDN3WOPzMRZT4IU0HUE4icqY4tYjG7m5E3F?=
 =?us-ascii?Q?RzIwslgPgPEinWHoZ/Qj0v2egGkn0uG3CsNDhCEw6niK4NN/eWzx3D+WISqY?=
 =?us-ascii?Q?uaUsCOl8PCJYCr7Y6eCTUhm1khbDvmVYrDL182ZhwYOz9i40rB8e+wvCt/Vz?=
 =?us-ascii?Q?4fCseEI7zFUuEfeAD1VlG5a2l1SRktOnY0gnPabC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a899620b-81c3-4f14-631d-08dc68d127a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:51:10.2420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6Czvr0kw5WzYm52JwUreb0I4S7/9ohDUNvZLTAlwML3iJRv5u+W6irIE6Srr1cHuYjQ6xvCFBULV3FfnzsYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, April 30, 2024 12:14 PM
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warnin=
g
>
> [Public]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang,
> Tim
> Sent: Tuesday, April 30, 2024 11:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix uninitialized scalar variable warnin=
g
>
> [Public]
>
> [Public]
>
> Ping ...
> > -----Original Message-----
> > From: Huang, Tim <Tim.Huang@amd.com>
> > Sent: Friday, April 26, 2024 9:14 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> > Subject: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
> >
> > Clear warning that field bp is uninitialized when calling
> > amdgpu_virt_ras_add_bps.
> >
> > Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index 54ab51a4ada7..a2f15edfe812 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -395,6 +395,8 @@ static void amdgpu_virt_add_bad_page(struct
> > amdgpu_device *adev,
> >       else
> >               vram_usage_va =3D adev->mman.drv_vram_usage_va;
> >
> > +     memset(&bp, 0, sizeof(struct eeprom_table_record));
> [Kevin]:
>
> It is better to change code  to "sizeof (bp)".

Yes, agree, will change to this. Thanks.

Tim
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
> > +
> >       if (bp_block_size) {
> >               bp_cnt =3D bp_block_size / sizeof(uint64_t);
> >               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
> > --
> > 2.39.2
>

