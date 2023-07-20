Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75289EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E2210E559;
	Thu, 20 Jul 2023 05:44:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B12B10E557
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbGNsQ7jJwE5d1cnPs7LfWh3mSeJeZ4NapwTJ8p69X263BMgLNOexK4QGdJA2vERF1UgHQYgt3aZrEKNyC4pPU2KUNpRi3n3OeqLtqCXDNW0l+5ocNPCW1QgMrVFUAbdgyByyQBKJzMfIsDxBwwHcbd2aG8X+pe3IIw7uGMJlJht0vA5fhV23a9+2Ii7vERckdvaNlv/Dzsl+z48q1nd3CGsSLRv5b1xigy6iag8m9NahXkFHCopu0u3ZBcORrNpRN9B0oOqusaj/AmQHawzX3V68CZ2yMqnsDD5VJRVDD/YmH1OhNxqV2d2Kst/t29SoMWFDRJtALL/VsPfx30FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpVzpXF6lM3AeZTxF/Y97IgUbLM7AAIs7pkgR9t6Evk=;
 b=VLKbgpthipd/d1yrGkkHRYSvCkg1dpgGY0akkcF8xzN93Wc54HMngiPhh89Jaw8GQdbgGDG9zGZdp0kmf6K+YW4Cvxf/DV0ChmHAbzI+afdizqoI3yv9Byv3hgL7OxNaoT1+++MVk/OamjzN4axoisgY4NVNwASnUBDFswuwrPplgm202OY5LeBAd+YStji9lQHoWB/4p6ZDGKuLJjZA1UdBNpzzBLnbD7bufnJEP+juWf++l4XhjV/i+jV4w+Bc+cENqiQqbOX0z8sS+MEUcIwQrwcWGrrKZ2tLoLpdHBuOk4CmOkOrr7+CO9Dnpxhg819uUDbQjDq+JchjIvufow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpVzpXF6lM3AeZTxF/Y97IgUbLM7AAIs7pkgR9t6Evk=;
 b=Lkk0vfmzB2UWMxqVL7YA71KbF2fq+pY/3O0HrP6B4UB57+akbJLoIIKZDPoDHedjaUXnAj510hbW/tMrqv0xbxUslDeOwAaPDC1z5WVbZaIPK0ELUf4+a6dGKXYUm1TJA4Paxk0lb0jUd3cebJCbsjWbZwIy5ZjkjoiOZ3+yOyc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 05:44:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 05:44:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index
Thread-Index: AQHZuszmO4hIgmErz0CpE0IbEAp2bK/CJJbw
Date: Thu, 20 Jul 2023 05:44:18 +0000
Message-ID: <BN9PR12MB525775C5BB1EF817A39E54CEFC3EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230720054134.1187589-1-YiPeng.Chai@amd.com>
 <20230720054134.1187589-2-YiPeng.Chai@amd.com>
In-Reply-To: <20230720054134.1187589-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7740685a-fa31-419e-ace5-00bc620c30bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T05:43:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: ab17050c-8a2e-48a8-3586-08db88e45c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwHVns4wE1yYBfHbMmYQFkHUuKKS4my0q91L6lCatN4wjBIXDfndnTCzg/yM9O0y3ss4ToffXkc/cN60RqxytZuIlhqyoNXu/lLtnDefGg/lnQumRi4FBLLdMWTz2xf1+QMuch/9NPt1h72hr0Y3w0knyaCXun/JPcVDgmF2jwtT1AAYaLd02FB/NvXj62ygmMq1v8mCPprLtnxPZz3ToMsSQf0rKNYUBfKf6MKcppcokOUaNz7pvNSYl+2wc4XWvqAF9b6n/V3AezdiHerziURJ1ulsRBIeyGCd8mkMqgkWUcQy9/nIo5niA00rjbTy7FpD5D+FRuC5EjrOw7ORCSA2TxxjgQAfraHltgPnHZz+2My9x6ZjgWaXpWcWbFxUaN0Zm5vXp2gIgOEwWzkuhtcCZ4kyYkI9cYShGH34XUPGrtPwCV+lFZnXCIuBpETOVOH+wD4QwjYsTYJjQddBIbY6A+XK/4FFyUhf2nXMYYajfBVByr4CkabCnwGLfft9+CtDgDqCudY2VT3KVaCf3oLoW4uYH2NapG2j2jEyGChEjx40InCCIMiMVBlRSfaiDXDQQtV7NXWFNbI3PAO0O2iKdeic1z1TTkSUdeUyZ/+MXpRCcjmicyBwmv52cHPS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(110136005)(478600001)(2906002)(54906003)(71200400001)(7696005)(8676002)(4326008)(64756008)(66946007)(316002)(8936002)(76116006)(66556008)(66476007)(66446008)(41300700001)(9686003)(83380400001)(52536014)(55016003)(38100700002)(122000001)(186003)(6506007)(33656002)(53546011)(5660300002)(38070700005)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?00qGLIMT7QW3/0B0kW/K09Abh8RGc0Wwse9U560xh/3O0Y13EIw/Mr6vbsug?=
 =?us-ascii?Q?7okpAnNIFRJ4Qpd0HXXn/GahAKd0RQCcrIEp3SvYBwZmpykwBZTZTnN9G7lv?=
 =?us-ascii?Q?xXxs/EiBCgK2uZKpAU1P1qiaHKTbqqiAXHrxhM0nbuDvDE9o5vggwiOoeFyw?=
 =?us-ascii?Q?xfheC7k0OMhgRpgPUG1JN2DZ690kAhmiTVW1GfBTlQyftXWBgzq5hZdVSfh/?=
 =?us-ascii?Q?biMk6kE+Y3XgZzHCt+quWvZoZldWGuFFL+ZZYVNNkJ6gedOeNCJWHeXKDVv/?=
 =?us-ascii?Q?9Zpt9dsL6i/YEV1cRQkNmCYN49Gtruy1LLAHqfYDd/OES117BERUEHy33/eD?=
 =?us-ascii?Q?zwUUR8APtYVbXswS933aKTcE2tU8lFngZdpk3U9RogLqDie9O7oXMN4G0FK5?=
 =?us-ascii?Q?cxFVTg4Llpl+uXJc4tTxKQqzyHq6QjYPRWlGPL4ZF7FXV3lYPG3ylN5KmmVb?=
 =?us-ascii?Q?1YeWf2aYAWViy3cL28edHewjgyrRBF3mETt5TfYqjM4XZiXghuGmWfx4jilS?=
 =?us-ascii?Q?95lSmLaCvd1nBlVeV3zjAYJ25i9OmiHYD7nNLdhaAozd8rbFY22I7aCzZkLF?=
 =?us-ascii?Q?2jcoEKq2RwWWp2yJS4aEsBu12yHgXxzfCtIITMfG1VrdbYRyIY8XoCng9mgU?=
 =?us-ascii?Q?/dWLjMq3fTfKhw3l1epIiGPacc6+xnezAm3Q4tclbpPKMuLvuDgyD5Y5aq7i?=
 =?us-ascii?Q?P0M9a/0p4OqR3k+iVqJuM/oIf+rcPf3OiXOkqYF2880TNMWLUq46/wvc5619?=
 =?us-ascii?Q?bd2cYw/7KpDxzsEPTteLtGn4Ch3YoIxHv+I7Mn1KIvnCDKS6kfG4HMpZSyJ0?=
 =?us-ascii?Q?RlN6aewIjvt2g7aT1n3T5p8lR//11rNtE5Oljj9uGq1tvULeXrEacnGNwuu6?=
 =?us-ascii?Q?5bl4TRRuNW0qIVcnJLpYIN9IVehanpj11JjEpHtgqVKFsUtyBXnqL/81BYQj?=
 =?us-ascii?Q?BpF0pGwLbAJSKmiPwMflkZEYr1Nru2McOXE8XLbrR69XIODMnfRkKEBG78QB?=
 =?us-ascii?Q?DQrpyfOiFfdptau9opTwClbvnbXDrQ8viwgpTL0dB9c/nsegu2I5Q7O5Gc+c?=
 =?us-ascii?Q?Al8Urz/2zF60ObAnnQ0493J/QFC44CfmbqoQpWOyLlYAs+8voOCYp/Be5EQg?=
 =?us-ascii?Q?SkHqjfN9MTsb3P91XzQojxF1jA4UhiN4WFoqQiKWGrmkjFatyV1vY7phBiC4?=
 =?us-ascii?Q?CmyyUor0LyZgo9V705S9XIL3+6OD67ptYRgJsGYHW2bQ/RLS9XD/gXaN+ZdY?=
 =?us-ascii?Q?Zd1S/wqXYUwTc1yLruX+22n939sJVFOVIHShq4neW/8URYeqTuUnxV8DOCtH?=
 =?us-ascii?Q?ydj4M15vUWJhX2w1h1YbV1pBuYxu+dHxuoHFW3Ec//1Gxk0nMP32NlFF/xyj?=
 =?us-ascii?Q?imWIxWgqLC/3NFeVvf72FWoYCu1j0xlGiAEQdmWG2IrKQzBy2oOMhWNHtHDE?=
 =?us-ascii?Q?qQndC77o1mXfXYGzC8mOtR4dMHlpcJKyyRAHizwarVQvIL+GgN7YRQpXFr2O?=
 =?us-ascii?Q?EdOueuOEHZdr+LWR2t4NTPhuWXBB6pbxVHZ1BbNM/SMUZCw9FxiCljvS7UWY?=
 =?us-ascii?Q?EoLLFU+PI+Q+jWstGpRf64akwU60sNzn7KdwK39U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17050c-8a2e-48a8-3586-08db88e45c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 05:44:18.4140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1q94DQ9aq9KxypQU8cEa7hdA4QMIx6NTuHYurJskjJL1CZIgmaxcYqQNbf5VvRvjLyeOGk4XIjObzgsQQ2TYzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please apply the same change to gmc_v10_0_process_interrupt.

Might be better to check the client_id =3D=3D VMC to decide vmhub.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, July 20, 2023 13:42
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index

Fix incorrect vmhub index.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index d04fc0f19a29..c0b588e5d6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -97,10 +97,13 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_de=
vice *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
+       struct amdgpu_vmhub *hub;
        uint32_t status =3D 0;
        u64 addr;

+       hub =3D entry->vmid_src ?
+         &adev->vmhub[AMDGPU_MMHUB0(0)] : &adev->vmhub[AMDGPU_GFXHUB(0)];
+
        addr =3D (u64)entry->src_data[0] << 12;
        addr |=3D ((u64)entry->src_data[1] & 0xf) << 44;

--
2.34.1

