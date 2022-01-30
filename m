Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CCFC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 05:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0509310E57D;
	Sun, 30 Jan 2022 05:31:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B244510E1AD
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 05:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6qTvFgMlmmMr85TYTEchaFQ1nM+F6OhCy6+4jzHDXKKZ2SJtccmlAgOBaSkkhpg1Chg5hkY+pHSq9VXkrPD5lXeqIVUO9WgB629ECtM3r8tMCXKDu7LKialh0/Xf8vIXoYb1tZR1jJWTFt72dvLxBI8giW4QMqYN2iJ9QbsrslSLDpteniXrSjc7Kfx/ivCVQoH2W0oJE5/cEudPctVqa57iKvuRvQWBBiqGu4KuqJoc5F1cKPwNMaVmFQ/eDtqe34jl9YFYPpDqpNmLQJ8hBFVIdVqBysPslCIqd0OMV2L5BH7xm1Xi5NifsZ0HqKtUbvIGWTUKG4ZkFA6AEANhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuLhe1jL9hN83UrR53i33MDK/oyNAh98SxOdPEjGOQ4=;
 b=eppu4Obu3LJuau9MJaIp/WabhAY5UpgrQdC5HFsbrZN/7jMbjDM2NzYRZplv2BBb9jKxWNzTNzQM819ZzD89ISag66djjG3W70HMBpQWyfi1iAjYd0cwfT/t9MjSYHqjMVRdhIrKrv0ElNZMkd8vCN2YTULrgF98MeQot+j0G6jiO2BNV/NjF6PfCjMD+/ahbxVYgXrvgpZfBztm0B9Yajc8vyzUnEGFObg+bESre7/R7/1DmhhGw8antCRE6xXy0eC6a7JwjouN6dpwOI224DvuRtLzDEZ1WXS/Z5d8w6l7BmBDeDG9n2BOZAlHTy5w5Bcv16bJsvnTGY9utAHPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuLhe1jL9hN83UrR53i33MDK/oyNAh98SxOdPEjGOQ4=;
 b=Z4Gewmk0NwreJgNFJj1PFOgEl+PvybaVhT5GxQ/1/GpBkmfiCXuqqrfTD5D2y/X1c9Nnvl03xMG5YE0sk28W0Ub3FmAHaQN0sTvCiQBak3IY5ZZMzP7GR6WRFy86v2e8Q6wH3DVLJokpnEBs9sxWwd4uX8iuZSi5tKwPDXofE28=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (20.180.7.88) by
 CH2PR12MB3688.namprd12.prod.outlook.com (52.132.245.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Sun, 30 Jan 2022 05:31:08 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%6]) with mapi id 15.20.4930.021; Sun, 30 Jan 2022
 05:31:08 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Thread-Index: AQHYFQyUWuoo9i8xLEqF7l1qichYhqx65koAgAAknmA=
Date: Sun, 30 Jan 2022 05:31:08 +0000
Message-ID: <CH2PR12MB42155287A7B9E2DD31B09D0DFC249@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770916E530D42230CFB4B9AB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770916E530D42230CFB4B9AB0249@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-30T02:55:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=78b4fec1-bd90-43fe-b9c2-bd7da1bd82fe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ddb2ee-4c01-42a5-2b56-08d9e3b1b7f2
x-ms-traffictypediagnostic: CH2PR12MB3688:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3688B303FCBA6BD36A385EABFC249@CH2PR12MB3688.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UVQkO0aBKSInitSFbf1u0RGauwclm6X0QhN07gpVZnmomviM4vNnmUkRcR/XloC2+mtYaeX/adQAv9wWq5xqNgqtY+m/+w8lNxL/yOB3QKudOyg3yWV6ySEiwVfDHlTEv0OAL9i3d9FMG1AZOMPRSh4f3n0qv/SCxc+cq3THXvKorfIQyT67xu6YZ3PaR/QscjB+FGeM8gAnMspZ+3b3lsvtzmjqDXSA4U80VZqCZMZdRCCLO+HeHdNftINRFBBiE6cThLTrJEJUzaBjCBHZlqCKd3pCPTCdSA8LyleThpOEmPnXJRmAo/1nOQKqDKwjhyBqGtoK7L8Mi6ED05M6Otgt2xiSg8XtPwlq8GPQAaqrYaVLqcSrxc3DjoGYBZAC5Lmr4f0M//+JdE14m3MoncULzRk7I6dMwC9cbZl+O7ohhj2RwKgV3kwT9sAro8VTwBMYOprgNKjCW8hHd6jDfLeXPfnVIXwIBcuJ63rb+y9u00EwTTvWspfolUesVyNF20iMXgMQTQYO+0Ls29l1tzQWjlgJbdH6ijOBTixEm/H+i6882koC0xdnNykobHmltEQThT0oQeGR9eiZtzi3Vk7IkUXZQPs+VIXYIdNYYw5ap2nYRmeAGR1N2kL9QtvtBB01iUds/+AJ/Eqe4UiZaa0sK0GQIrOcyqjkZVwZhjcIhykyRRWFnKGlNHe0UOMDg2XJHGeNoS6UdgWNOaPGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(64756008)(66446008)(66476007)(66556008)(76116006)(4326008)(66946007)(8676002)(86362001)(55016003)(9686003)(186003)(26005)(5660300002)(110136005)(53546011)(54906003)(6506007)(7696005)(122000001)(71200400001)(52536014)(38070700005)(33656002)(83380400001)(2906002)(316002)(38100700002)(508600001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDCva+FadLBF3bwzCYkO7ix8yryl1k6mtVzVE7AZzzK2isuhJPWGLPAkPh4q?=
 =?us-ascii?Q?7Y8s/N3JEmkVFTqnogMhrNH0y6WGd6FBZ+HVAFFu9LmJvsj2jFgOZUEDQK34?=
 =?us-ascii?Q?aKeRFQhqOLPofKTkB+r3xPIwOLVNDOk3c8HQ42ckV7m7oU8WTFTAaONmNGQ3?=
 =?us-ascii?Q?0gztebhJ4XbWl6py16hQTueHqVASs4GanRJQBmiOb1mCUlP7yYV0Sz9Tfv9q?=
 =?us-ascii?Q?8cU5yZztwct20d+c3H72gKo4WdpD+8Rk4aDh29zHHmiCItu+MscUlWLVdnGQ?=
 =?us-ascii?Q?z59+uw+Hcs/8Ih9Z7HrdlGANgOT2TLRqGfTpjQFH6DTgnlFEKWBxfB2I+xYM?=
 =?us-ascii?Q?2bbWAVmztQaINuK1MtDgjZBzSpoo8U4vRLnLqiZYfVB969FImjF7NMayArli?=
 =?us-ascii?Q?cuQZ7GfUGNWmIGLJZBYTLtpSdS8hiVzz1w02tpBAX3wgcTdiDhPJYTRHQwIG?=
 =?us-ascii?Q?IK/CD5J3Jjvs7LOl6ecCYKGH48fBBtrKqMXDtAiHa80QhJ10C87+fKo5V0GB?=
 =?us-ascii?Q?4LjKkkgvLasvym1LIRbBZYQxb2Imq1IUI2wulB/e4qXHws5/uLuml4HpXmc7?=
 =?us-ascii?Q?laKS80CUzWbN5LhnO04ONcTquscaSCdoI6ooftYUFzqS87JM3FeQqeSQuQYG?=
 =?us-ascii?Q?6xSvza/bLdG/bkHSwklWZZuBK9va9aNprks26MHrPNAS3UiSV5VBTa2q+h8E?=
 =?us-ascii?Q?QlPYcfSOgMUtd2bSaIrZs52fIIIGcDc87IUqqCiQiBbempo3LncT/m7Qrw7o?=
 =?us-ascii?Q?hrwJANeGNUCViXosQCwz+Oq9Oy33JqR1mUSjp/Cgd2ZXjYNmQOQxPDDowZOx?=
 =?us-ascii?Q?EICKlO1OT8SDdbCsUKTlUCzLhDLZ93st8+X+pl1wD6VweDNvkuong3IKl/xi?=
 =?us-ascii?Q?QUAsd7XpWw3jM8dzoZMKb61izFpFwjqlneSqRu5+OzAfEXcyUWBMG+YEB/L7?=
 =?us-ascii?Q?H++BO8gzr7hYr0FJgA0fX0gZIfIsj70id5kpRGjMmKcXMhV99QA5naldusRR?=
 =?us-ascii?Q?nAAnFh/YZlZjYFBo0QoheuMqVIGxSKuARWrXsGHSSOjPhhrqNzm5D5eBd8iZ?=
 =?us-ascii?Q?3xvPRqCiBSL5xx7hVUWARvgi+/2S8WkHu+TAzjFxn62fDDznliRa7WP0bAjK?=
 =?us-ascii?Q?YdPN7r7yDb1uqR6eNmC/RCzV7NDxTjGT4eDzi8oRBEKKJRjBITlAHY0RTtfR?=
 =?us-ascii?Q?ptbs9bvVs3Qv5G0LNsm5WQi4YwhzMfKjn2GpLtz2JpWQwFJe+MVCeG//3/zu?=
 =?us-ascii?Q?CB3JE35kKJY0cAWcQxyqnQBIMjGnBMq1bFnzP61PA7WmCm9wW8YNYCK4yZKK?=
 =?us-ascii?Q?7qYPRbyhjcm10KUtPYRjF+3zJ19k3Xbjdb2PpibN4806TiLgsX6wbI1GtZ/Y?=
 =?us-ascii?Q?D2QajH56PHJ9hH7pUX6TbM2KNXAj9Zl63P/rb48iJeaZ1z7BMYVADQW1e2bL?=
 =?us-ascii?Q?OKD9rzKvrGpvGbnzYY27pONgw9lxmYhPRTWA1HuRGWWqXPUuA23p3LNeG4J5?=
 =?us-ascii?Q?8n9KHWEWOfaO7+TRStoGEDlcUBNnJVBsn2lZdEQZuaNGxExJheiGHh/sfTxU?=
 =?us-ascii?Q?tkcMPsUyVqROap/LkN5rKKoraRUyfHHRD/QOwHZ9QzTOHGaMsxFGtY5BJxwV?=
 =?us-ascii?Q?fIlFUuwFPwgu97FD61aYoBY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ddb2ee-4c01-42a5-2b56-08d9e3b1b7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 05:31:08.2891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VAoGRHxKv0r1zfqQTzdWeBSKBFu02bdNfy8Brgz8h/TwlpF/7Bz8IqyReXdGBBtdcpplh1fCcFm69+yphyVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3688
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

OK

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Sunday, January 30, 2022 11:20 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused b=
y infinite loop

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Saturday, January 29, 2022 8:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused=20
> by infinite loop
>=20
> 1. The infinite loop case only occurs on multiple cards support
>    ras functions.
> 2. The explanation of root cause refer to 76641cbbf196523b5752c6cf68f86.
> 3. Create new node to manage each unique ras instance to guarantee
>    each device .ras_list is completely independent.
> 4. Fixes:7a6b8ab3231b511915cb94cac1debabf093.
> 5. The soft locked logs are as follows:
> [  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           O=
E
> 5.13.0-27-generic #29~20.04.1-Ubuntu
> [  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU,=20
> BIOS T20200717143848 07/17/2020 [  262.165698] Workqueue: events=20
> amdgpu_ras_do_recovery [amdgpu] [  262.165980] RIP:
> 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu] [  262.166239] Code:=20
> 68
> d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44=20
> 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d=20
> 89 f5 48 83 e8 28 48
> 39 d3 74 25 49 89 c6 49 8b 45 [  262.166243] RSP:=20
> 0018:ffffac908fa87d80
> EFLAGS: 00000202 [  262.166247] RAX: ffffffffc1394248 RBX:=20
> ffff91e4ab8d6e20
> RCX: ffffffffc1394248 [  262.166249] RDX: ffff91e4aa356e20 RSI:
> 000000000000000e RDI: ffff91e4ab8c0000 [  262.166252] RBP:
> ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001 [ =20
> 262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12:
> 000000000000000e [  262.166256] R13: ffff91e4aa356df8 R14:=20
> ffffffffc1394320
> R15: 0000000000000003 [  262.166258] FS:  0000000000000000(0000)
> GS:ffff92238fb40000(0000) knlGS:0000000000000000 [  262.166261] CS: =20
> 0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [  262.166264] CR2:
> 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0 [ =20
> 262.166267] Call Trace:
> [  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu] [ =20
> 262.166529]  ? psi_task_switch+0xd2/0x250 [  262.166537]  ?
> __switch_to+0x11d/0x460 [  262.166542]  ? __switch_to_asm+0x36/0x70 [ =20
> 262.166549]  process_one_work+0x220/0x3c0 [  262.166556]
> worker_thread+0x4d/0x3f0 [  262.166560]  ?=20
> process_one_work+0x3c0/0x3c0 [  262.166563]  kthread+0x12b/0x150 [  262.1=
66568]  ?
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
> index 9d7c778c1a2d..b0aa67308c31 100644
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
> @@ -880,7 +887,8 @@ static struct amdgpu_ras_block_object=20
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
> @@ -888,7 +896,13 @@ static struct amdgpu_ras_block_object=20
> *amdgpu_ras_get_ras_block(struct amdgpu_de
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return NULL;
>=20
> -	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		if (!node->ras_obj) {
> +			DRM_ERROR("Warning: abnormal ras list node");
[Tao]: dev_warn is recommended.

> +			continue;
> +		}
> +
> +		obj =3D node->ras_obj;
>  		if (obj->ras_block_match) {
>  			if (obj->ras_block_match(obj, block, sub_block_index) =3D=3D 0)
>  				return obj;
> @@ -2527,6 +2541,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device=20
> *adev)
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
> +		DRM_ERROR("Failed to allocate ras_node");
[Tao] dev_err is better.

> +		return -EINVAL;
[Tao]: how about return -ENOMEM here?

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
>  				enum amdgpu_ras_block block, uint32_t sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
> --
> 2.25.1
