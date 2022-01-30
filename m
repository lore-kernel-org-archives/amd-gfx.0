Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235C1C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 07:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEC010F230;
	Sun, 30 Jan 2022 07:35:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD3410F230
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 07:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFmFVWgjdD6xqsBuxs7kSD1WxP4JpObeUpi2dT6UTQmhiRwMJvD+7v7+lD7KCbZbGnC6ZYVI8tqk2oIrMA6D6kuyKWXyzsXSqBn3YSVudQ+9sjHwsSnxrNkKIcrDuhNZPEuT/L5ebfYxs6n4y5wodbd8q/GNevEUKbo2N/njeVRYDGLoVkole1XHr4TvpYScRJb0T9gjXeW3ZeRT/nIqGyFY1v0rTgWdwLhJ2aEFE2ObiVj0kqekVDrymI27EVSo8QAPwC8oDgnfX6yHGv3OZndHzzSsY+qczvA6mLiKN6PEO1y1u0pUaiSyXZR1XzayTzKS/jnEMxUZT4iFPnmwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aha6xylwpeGDT2fl6HuLEzV0BivgTgvwUi89Eil0oZU=;
 b=dIB7Yc8qeenbSM9u2uQqqF1Ur24SlZ0Tdf6SRqKXHxyFf50qRNIFsMV5aazka+o66w4gzHvDccmnMIB2KKZlou0z8c4bDRMq8M/ZRM8TuyFv+mT4cP4LLy+rRSlS1igo8+UoBbwkmhh46FidRScnT9SK/uUveVjgQwzx4Isp/rXdNeryRXtSJe39UMtAZX+OObGD6pw/IXf84Nsgx6kkrwuZIhwmqRgaAv0FI74s77uSUvuNeGkDoNGaNozT5Tle5aeKnwY2J32+dTNE8vNjdSrQ4MZ40E73BLT3ZZYTA9T6H1n9adq4fg/eh/sNVkoikovh0uSfCzX8hAdv9yQxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aha6xylwpeGDT2fl6HuLEzV0BivgTgvwUi89Eil0oZU=;
 b=tyTT4GmQnf2sZAxiY0SUlIc5EnBewtPV9hpFgXh4yZxb8j9hmVlKoru3wVVE8zCwC1mTCYsWbFsixpD5Be8Ia9+or0E1TCXjEk/mQzWUCjVysVS4Zz6SPtQMP6JyN6lqm8CBQq9b22tF7BCVd/tvQLxjWANxlZqhglY3EoeK8rg=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sun, 30 Jan
 2022 07:35:08 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 07:35:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amdgpu: Fixed the defect of soft lock caused
 by infinite loop
Thread-Topic: [PATCH V2 1/2] drm/amdgpu: Fixed the defect of soft lock caused
 by infinite loop
Thread-Index: AQHYFai1wKK4kiXdvE28m0It4GBVY6x7LGtA
Date: Sun, 30 Jan 2022 07:35:07 +0000
Message-ID: <DM5PR12MB17702B5D5AD2E588DF2928FEB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220130071140.3846493-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220130071140.3846493-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-30T07:35:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a37bb3a9-fcb1-4553-afbd-e0b61c9b6b8b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-30T07:35:05Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 18fdeca0-f56e-43c3-8c43-0eeaf3b85a74
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 477ccb8a-8702-475f-bba6-08d9e3c30a2a
x-ms-traffictypediagnostic: BN9PR12MB5084:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5084E393651C5D7C5486D3FEB0249@BN9PR12MB5084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:246;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9BphxXLoasM0pLzZ/INV6aKJoDBA/ub1GydcU57R/sPOJyVhnhIVH22jaFcAm6Wjn6TfZJaQCqjN6guSM+Mv1t5UW6DYE3cSKBkdt1mthGmO1NXiY6H8xc2BcyX3sxdkc/+h8Okyhw7+taRhr35N9oCBa9PyKX9yVEDdQfAbTjkhYpU18pHCjArCxr50TMNLjO3k+Un7jmW3degSpbhY61lMZKR27YA39HPU3lnNLCHkdk2XjzDKiHd2cXC6/5/EP14gX6JdRRp0c2uh070C9xbcLUQcU/vrYa4jltgg+Vh1YWe+OrOJ9KPILH9EjcKAOGVPBaHN4fq6fqj+AmBEmM5XWce0KEw7mENFBpXj2ypc7lfjblZYSBv6Wl/FkmeyNFOIJ5u0SfUYI61GGht0DBQmffNh9opvzUissDj34urpdlsDGm2Pjf0ejU6y2Pc93ObHMVbBXpoQbBQRmDLYBcXufdPOSzRDbW1oxB7Y/UpgBwh+/J30SxVJAZWIBtmKDzXARJp/34D5YQPte8OoFpblvUM5XfTml3jkJ6Xw+YHtzAPYRnx7n3QXQK1mGDBLsrvjv6UHBixw9Jl/NFTZcwHY7La2PvKo36IPOdabqZM/BOzR0d898pBoOgihLekOUR1q0lP9LfrAmQ3zFZOoRHx70sJlAp1D6Sm1zmhxRQIKgSF7UCiHGdYmOuIvCTR72kL+3wqp5iHQTNiXSIRaTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(54906003)(52536014)(83380400001)(110136005)(316002)(64756008)(2906002)(76116006)(66446008)(26005)(186003)(5660300002)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(9686003)(508600001)(38070700005)(7696005)(53546011)(6506007)(71200400001)(55016003)(33656002)(38100700002)(122000001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nEoDeLVSYGOZXoH8KHtUPD9vC/YSCHLQcLH8aeLio9NahfSzYAXtXHYOgf6J?=
 =?us-ascii?Q?R9dd3k5Gd8gF50KgXsjWh69fDGQ/ceNf6rKkdubes9W00eesbe12ShjFCCKp?=
 =?us-ascii?Q?HUeazXjPet+2LzInS0FjNlo9Py0PE8m1+G1HljKQcuVKA7GD+MYoX8FBAGxs?=
 =?us-ascii?Q?t1grdXrGaU9N3ExVsc6wVGnXyT0ld/PKjakDCtsLzSw+aJu8uC2abX+Un2Ty?=
 =?us-ascii?Q?5sefj+1yID0uaZCNVF7FZAUGNbD9L4sl2cAOvYVMdRXcqj2xuJiWMaNXrm6M?=
 =?us-ascii?Q?kYwI+5RmaoFGCqwJLGFXjIBlU3xmclES1Jk798NaBy/v6rqABVgyPlovFeE9?=
 =?us-ascii?Q?QCLGSJF3lG91yvmgv0rfpehyCTvqVxxdDaoVAvdqTSaBHy+tQsYxW+CjWU/F?=
 =?us-ascii?Q?n1TuQrDjF6w2WnSsRjWj2LIRCYazQl6gLYwWutOEXjrNwoGic3rzksasWRwa?=
 =?us-ascii?Q?GQuNNL1rPe74yY4go9SSXQwBFvJyyowv22ZoW5b4NdrKy3eKNb/3jdCj1Mbx?=
 =?us-ascii?Q?GAul/95XVpW9j9JWdGsVrjMIpulEm7eZ0FTm+vRgO57qzijVmPNK3I/CauqL?=
 =?us-ascii?Q?qBymRjnhtQ3PZcH+YwWPi7+WPZWTVvUV59j1sIcSztJp1XyfWd9kk95itmFh?=
 =?us-ascii?Q?zjEFmr4LCFezzzN/jzqyADCYtNB8E/F2xvgTg3dvfPLKEeeNZN54JyvReaoP?=
 =?us-ascii?Q?N1R6/HZhD5CsUxubkJ0e4zlNlUvTUc5fbFDAh713HoOorPOMXIPIHyic13Xt?=
 =?us-ascii?Q?pT4KF1eUbmKR7ggPrKEfti6JzhGzUukevT5qm2SZtxfbo6nrtG1kV+nRNjDE?=
 =?us-ascii?Q?/UjEDQkjliNF4oCALCeHK/zLnlJm4qirX/P8XM6szt2QOJT3VLGEhgJm/En5?=
 =?us-ascii?Q?m08eoWpf5m4NnWOdhgJljiD392du162R1cd26A+PjnITd6cav6GMQSy3eszT?=
 =?us-ascii?Q?Y6N5GU04y130rA39tATy+Yctc2YtZVLskDXgWLuD7CM+wFrvwm43z88nLQJI?=
 =?us-ascii?Q?wmG1JaMmOeBvS677FhGnIs+6BwzM7pQoPVt/03ty1Ri+F0YP9xe0iq9fx3XZ?=
 =?us-ascii?Q?W91yYDd8FUzMmkzVv9zo/t7Mq02R50oXCHQTnckxyWaGgf4vTlOTZNmMLdq/?=
 =?us-ascii?Q?3wpACRZBxRaCFyROvZuLTb0x6uYuxsmT0RxSiBAZj2oGyvl+HIe+cjAzBkN1?=
 =?us-ascii?Q?uhjN/grBbQeHnybAGwSPrLU/Lepe3zJQPFhvBy3TlL2cqrdIhipv+fP1d5gi?=
 =?us-ascii?Q?FlaTITwIOa5PaIGX+egSynAPhHY+EHnIStiYTkO/7YVODsWTOiHeuv7v9rpO?=
 =?us-ascii?Q?JV4db8uYonUTTJdHPEW1WWv2mAwfHfx+vZvSkroYLmkUoPA4WqRo1NYmHoI8?=
 =?us-ascii?Q?2F7kiNFqAyJbl7YutneQZebb1XEI4WMeY+5p3h4lRnWgz7p/lXEJwYlciU41?=
 =?us-ascii?Q?QTbszaiSudrFFXoYA4J1fVfFRz+dwrzaWmqQvUGhzeQ4+N4hmKJvwZg/kdWz?=
 =?us-ascii?Q?7qaEqZ0QvgVCRVFxSmxbuFk47tvaoNDa7gtHo4+jdXo1dL2QFJwlINNciQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477ccb8a-8702-475f-bba6-08d9e3c30a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 07:35:07.6774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnF1MOiW2bfNXDNk15aeQGhbr70Od8LNbPu9xwZ8nhcKjrvSV6Vx8nP8zfm9QUNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Sunday, January 30, 2022 3:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 1/2] drm/amdgpu: Fixed the defect of soft lock caused =
by
> infinite loop
>=20
> 1. The infinite loop case only occurs on multiple cards support
>    ras functions.
> 2. The explanation of root cause refer to commit 76641cbbf196
>    ("drm/amdgpu: Add judgement to avoid infinite loop").
> 3. Create new node to manage each unique ras instance to guarantee
>    each device .ras_list is completely independent.
> 4. Fixes: commit 7a6b8ab3231b51 ("drm/amdgpu: Unify ras block
>    interface for each ras block").
> 5. The soft locked logs are as follows:
> [  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           O=
E
> 5.13.0-27-generic #29~20.04.1-Ubuntu
> [  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU,
> BIOS T20200717143848 07/17/2020 [  262.165698] Workqueue: events
> amdgpu_ras_do_recovery [amdgpu] [  262.165980] RIP:
> 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu] [  262.166239] Code: 68
> d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e=
6 4c 89
> ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8=
 28 48
> 39 d3 74 25 49 89 c6 49 8b 45 [  262.166243] RSP: 0018:ffffac908fa87d80
> EFLAGS: 00000202 [  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e=
20
> RCX: ffffffffc1394248 [  262.166249] RDX: ffff91e4aa356e20 RSI:
> 000000000000000e RDI: ffff91e4ab8c0000 [  262.166252] RBP:
> ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
> [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12:
> 000000000000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc13943=
20
> R15: 0000000000000003 [  262.166258] FS:  0000000000000000(0000)
> GS:ffff92238fb40000(0000) knlGS:0000000000000000 [  262.166261] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [  262.166264] CR2:
> 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
> [  262.166267] Call Trace:
> [  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
> [  262.166529]  ? psi_task_switch+0xd2/0x250 [  262.166537]  ?
> __switch_to+0x11d/0x460 [  262.166542]  ? __switch_to_asm+0x36/0x70
> [  262.166549]  process_one_work+0x220/0x3c0 [  262.166556]
> worker_thread+0x4d/0x3f0 [  262.166560]  ? process_one_work+0x3c0/0x3c0
> [  262.166563]  kthread+0x12b/0x150 [  262.166568]  ?
> set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++--
> -  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 --
>  2 files changed, 33 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9d7c778c1a2d..9b94c9c4960c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -75,6 +75,13 @@ const char *ras_mca_block_string[] =3D {
>  	"mca_iohc",
>  };
>=20
> +struct amdgpu_ras_block_list {
> +	/* ras block link */
> +	struct list_head node;
> +
> +	struct amdgpu_ras_block_object *ras_obj; };
> +
>  const char *get_ras_block_str(struct ras_common_if *ras_block)  {
>  	if (!ras_block)
> @@ -880,7 +887,8 @@ static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
>  	int loop_cnt =3D 0;
> -	struct amdgpu_ras_block_object *obj, *tmp;
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
>=20
>  	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
>  		return NULL;
> @@ -888,7 +896,13 @@ static struct amdgpu_ras_block_object
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return NULL;
>=20
> -	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n");
> +			continue;
> +		}
> +
> +		obj =3D node->ras_obj;
>  		if (obj->ras_block_match) {
>  			if (obj->ras_block_match(obj, block, sub_block_index)
> =3D=3D 0)
>  				return obj;
> @@ -2527,6 +2541,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>=20
>  int amdgpu_ras_fini(struct amdgpu_device *adev)  {
> +	struct amdgpu_ras_block_list *ras_node, *tmp;
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>=20
>  	if (!adev->ras_enabled || !con)
> @@ -2545,6 +2560,12 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);
>=20
> +	/* Clear ras blocks from ras_list and free ras block list node */
> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> +		list_del(&ras_node->node);
> +		kfree(ras_node);
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -2754,14 +2775,22 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object *ras_block_obj)  {
> +	struct amdgpu_ras_block_list *ras_node;
>  	if (!adev || !ras_block_obj)
>  		return -EINVAL;
>=20
>  	if (!amdgpu_ras_asic_supported(adev))
>  		return 0;
>=20
> -	INIT_LIST_HEAD(&ras_block_obj->node);
> -	list_add_tail(&ras_block_obj->node, &adev->ras_list);
> +	ras_node =3D kzalloc(sizeof(*ras_node), GFP_KERNEL);
> +	if (!ras_node) {
> +		dev_err(adev->dev, "Failed to allocate ras_node!\n");
> +		return -ENOMEM;
> +	}
> +
> +	INIT_LIST_HEAD(&ras_node->node);
> +	ras_node->ras_obj =3D ras_block_obj;
> +	list_add_tail(&ras_node->node, &adev->ras_list);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a51a281bd91a..a55743b12d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -493,9 +493,6 @@ struct amdgpu_ras_block_object {
>=20
>  	uint32_t sub_block_index;
>=20
> -	/* ras block link */
> -	struct list_head node;
> -
>  	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>  				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
> --
> 2.25.1
