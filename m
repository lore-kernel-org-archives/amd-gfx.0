Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D30C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 02:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0478710E324;
	Tue,  9 May 2023 02:18:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C957B10E31F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 02:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK9aQ6Fc2I1CFrtTHJXu5oURKjAj4eiGfDlxw8twk5OZGLt4yjawN4F8nMST99392nlv/M/9NZd6NkZcArYTDXa7XEMBxB2tgPjwytDXt5AnKSItiwQJ1/DeYR4QLxwG+ODLjFzeH1DUQgO0hgSURiWODM8nfC/HtSouMLX8kI+3d94wRerNNF20Ss6JjoVZtgCe+LyFJO/wMr333UpglCIs0SH5794rJOVXk8sFrM0w6GgRkkGJHANLmOPqURr6N6YVyxHTQVkp9vLfQFGOErqSa092uCFM/sxvSvOC42r7cpJK9T5sho5lvkOvP3kxSsllcyjGvCnAvkVVNGPVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQCFFcCsdrM73UrWcgUURxEXzpHfJdCrC8FZN2cp2ws=;
 b=KtlS8Cl+kKn8LXxvZ5tcA2wswKSiSJCq1ejT9nFbI9XJp0qbGVl1V6A02eM3nxXcTAYvj9eSsujvW5URx+nKxzl4a4x1un924ivsPAqyF/YTGicQunL7/IqgCSvn2ljNG1v2ey9iLNSbHGw2NjmMiqCPrZU1smIVSgTQhjE8HAmnwuVaqG28Dl+pzIwPPtbpNMaotdpY2KeHnpFc0wb5s/N002+7DRLwK+8sScc0M9Lnw/Y0nCLYYlxQXZD4Y5BVImY+gb52hRh+yCm2GPWVEWNcBpcJx6qbhqViUG9OLynvJon9JUJBdvIRXumUPWr0dlpFJBBysZRFih5v5h/k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQCFFcCsdrM73UrWcgUURxEXzpHfJdCrC8FZN2cp2ws=;
 b=Zqrt66Ods149BB1P5rL3DNX3/nfT+3bn96x3RI0tTRz3uvkdYxwxWA4/BAUyknF5ejCTiWRMh2nMvk2JunEzt58pfkIfDmSwbT3pGo0M1wbSm+xYKtXDYof295qtP2/2/IXktDzy7ADSa3VirGkktOXpkRlb/rUmg/GlV2nl0og=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 02:18:38 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::18e1:c084:6d96:3228%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 02:18:38 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 vcn_v4_0_hw_fini
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 vcn_v4_0_hw_fini
Thread-Index: AQHZgZaedECm1LDmSkuLl2V/4Z4GV69QNsOAgAD+PPA=
Date: Tue, 9 May 2023 02:18:37 +0000
Message-ID: <SN1PR12MB2591DB732225093C6BBBBE6AF7769@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <20230508101931.32544-2-Hongkun.Zhang@amd.com>
 <DM5PR12MB1770ABDE19DAB199BF573ED7B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770ABDE19DAB199BF573ED7B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-09T02:18:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c83f220c-00c0-4247-afba-3455092b50eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-09T02:18:34Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a2aa35aa-696d-442e-9a95-6790f4b1fce1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|BN9PR12MB5083:EE_
x-ms-office365-filtering-correlation-id: 0e853e24-f8d3-40cf-748c-08db5033b2e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMjABHa+MWJbzSHxTJa0jNw6pUb30JtOy72DkqYVh16tp3w9vkzSq+Wjqpppib4Fnj9JHJ1YLjOZmlGD/Xd4EZueF/l/44kGLczkDZdqiu1CBfRMsysAYPEBT7hS+o04qaF/T2eKrErTcqW+F5TzdLy0YQeHPfcPKO0i76dGDMVFCw+yq6gz9xhvYmXdL5pLRlGmoIIOyKu8TZ+5dDJ1lne1S6EH3AN5s4Tnial/hX8Q6iYQKDLbOL4FPnJ+qAdZ553MmbV5SeTr2YbnDc2HkhkETTAJiYKBEeMLG3T0hd22FdyfwssNHoCuNhzybjAYuUhA6RxZykDbWvkJb70E4TOkoQxcIDepXqyoIJYM20l1yHYEoGw0WchBkJONy4H6dkn/Nh5YlJ2bhZoYHlDV92MJDbmN3YA2sNUcHNKC4qgUCmMfBhu/e4OmuzA7mwJ+qQAiPrKD78kkmncYqGuoR1PFnpSd0LPzRJUXkENj6cI66jVlTaj9U/vzPT4QTrAj8whXlAkf+9bWJeTt9jewYONWavr2E15syUp3dsAEQzKA2gmHZHaFKowofchswH7Vccqhnv44vc89A99zB7xuzRH9zqFEmqgKzvwGnvmVYrhAIfEipqa2iYLFefn4Lfy0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(86362001)(66446008)(33656002)(316002)(54906003)(76116006)(4326008)(66556008)(66476007)(64756008)(478600001)(66946007)(110136005)(7696005)(55016003)(52536014)(8936002)(8676002)(5660300002)(41300700001)(2906002)(71200400001)(38070700005)(186003)(122000001)(38100700002)(53546011)(26005)(6506007)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0GJQOuy/kEvMTUEPZwMZTi10dNRqMkPh9f5X/GIdCeJ2pAekiswcM2JFcgVF?=
 =?us-ascii?Q?8vvraOS4ZYaoU9iY6yY831FcDWkOb1XaULaSUoCIVWyLYrkW+3ZORAWl3ZyH?=
 =?us-ascii?Q?+bcm8wwfPEwB7qVbOS+rZ1daeShT4QfZurSgDgkAfd9LYuClSLla0zPrK7CL?=
 =?us-ascii?Q?KzwX7p5CjHMPrR9aRf/JwzL2fnhbJZFvq23IyFpKCpjuVx5bTF/2Mf9/9f4l?=
 =?us-ascii?Q?2ByLFzmSfQr9b7+Ubrb6/+wZFOLYlNdA5JE1/71VSN/uPnrBGClp8QNP3sTP?=
 =?us-ascii?Q?d+ljb8bKaLGnlRS6S6+oayBq/4j6hHBEO45KD7PXWB8mLmmAvy4LQz5jvnqy?=
 =?us-ascii?Q?mbjo7kAl9ItodvF2kA8DU6Eeb+rWgZXVWpy8kpuAXOz6H/6M9qa1QZhlzRYG?=
 =?us-ascii?Q?+0LAC3PZAM2xfeae7TlCDWZUk2s7RK3HmrcSc3Nm73rAeIt5Yots3gDOwtqz?=
 =?us-ascii?Q?ekTSZpnGOWQNCPNKiFXbtf4uQPcW9AoI06FHkWcrjNqFWaNOLRJx3BGC/xCB?=
 =?us-ascii?Q?V1wvu0CuB5hyk0dgdWDxf+X00jUDDUz7lJc/QPPLl7sXwa0YCUE+d70Ea9G1?=
 =?us-ascii?Q?wMDe8kzD7s6G/is6iH0ktf+6cYuRTKeshCQx8te9eWGaK/8wvo0VEYkSjlFk?=
 =?us-ascii?Q?J+0KnW9lytTFFn+aYHMRP76IqKCaj9YnKkEOOW+QuoBlKz4/K672kSh6UPiA?=
 =?us-ascii?Q?DZsB1MDOTqyKMgk6vZYFct2Z0uixvSgBJ43A4O+N8og0DTgklL9XM48AMqfB?=
 =?us-ascii?Q?swKuHWh9gmYvdx9fbbnKdKWrC2Xu4dM+y6t6nsnb9yTuWvve8VCw17kTzvEG?=
 =?us-ascii?Q?mXZtxeWFJfRNbeWJtZ0Y0ostaNYDC49ceHq7ogUf8myh4Gzo2QlPWudaGJ0c?=
 =?us-ascii?Q?1r52KT6CjcgkMUhImcSFkpt9nUb57tgRqhrhpGo+Vw1ojMstNHufOcw8UTep?=
 =?us-ascii?Q?BeQSoM41BQRKYSmT8ft82oXfUnPOB04nrzQjj9Q4MIavPtpj6vaSN1eS82Xl?=
 =?us-ascii?Q?jKP1XwlXwQPO1nXfCY0isY+Hsv5Rcu573hdftI1CzT0yWmxolYrZqgTEo5dl?=
 =?us-ascii?Q?MJ/gQrW0MEpY88EjtXeCXeyJoE4IkXq4HrK8R3UBXjVI6RT7T64OpR9YjOGU?=
 =?us-ascii?Q?s5rj+Q2RbYhEVgSZzOhdtM6bggvYdgPtvpyhju4pXL3tCEs7gLouW7DWLwhI?=
 =?us-ascii?Q?izjdOMSV+o7SeGqjyLwMwjWRfyKRANZInbCoHqHq+qhu7Rgitu4ZmosdnUfk?=
 =?us-ascii?Q?N0xtWoGk0itxFSv8C8o/DQYvvdlOTy3alXfxkC6J0W7KQ3+c+CTmysF3GHaB?=
 =?us-ascii?Q?ToQuU6/CSVCVNLaFJRTY6fYUBtTE8ih5XQAeoLndMdkb+wYKPW58rY71kM8D?=
 =?us-ascii?Q?cJ9G1DOKSIp+E/3qXzsE0Qv+PH+Fh9/lkwNmMrpqI28Vugw3Qcz5Dpdt5bVE?=
 =?us-ascii?Q?g6K7wWyxANpgmtl2DrylOFlyQdJFH5y2J4pHe2WKnrygK02aVocPb5x5TgBx?=
 =?us-ascii?Q?me1TJOuOyR3lV6I4MbjRTAA1YiweLl7WmjVj17poc2D4F3ZL81hdDbyWsuRO?=
 =?us-ascii?Q?8WOo30Mtu7EXQLvFF2c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e853e24-f8d3-40cf-748c-08db5033b2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 02:18:37.7384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xH6csXofVinuiLeMc956pooIvFk8PNgMWabcbnFMAZ3wfX9nFEZDpXLplE/UsY8vkox9Qo9qYB4oLade+bpWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "Limonciello, 
 Mario" <Mario.Limonciello@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Tao,

Sorry, I forgot to check, thank you for your suggestion. I will update this=
 modification in the next version.

Thanks,
Horatio

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, May 8, 2023 7:05 PM
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhan=
g@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.c=
om>; Limonciello, Mario <Mario.Limonciello@amd.com>; Liu, Leo <Leo.Liu@amd.=
com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in vcn_v=
4_0_hw_fini

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Horatio Zhang
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio=20
> <Hongkun.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhang,=20
> Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in=20
> vcn_v4_0_hw_fini
>=20
> During the suspend, the vcn_v4_0_hw_init function will use the=20
> amdgpu_irq_put to disable the irq of vcn.inst, but it was not enabled=20
> during the resume process, which resulted in a call trace during the GPU =
reset process.
>=20
> [   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
> [   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09:
> 0000000000000000
> [   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff954c568e2ea8
> [   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15:
> ffff954c568e2ea8
> [   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000)
> knlGS:0000000000000000
> [   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4:
> 0000000000750ee0
> [   44.563633] PKRU: 55555554
> [   44.563633] Call Trace:
> [   44.563634]  <TASK>
> [   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
> [   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
> [   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   44.564061]  process_one_work+0x21f/0x400
> [   44.564062]  worker_thread+0x200/0x3f0
> [   44.564063]  ? process_one_work+0x400/0x400
> [   44.564064]  kthread+0xee/0x120
> [   44.564065]  ? kthread_complete_and_exit+0x20/0x20
> [   44.564066]  ret_from_fork+0x22/0x30
>=20
> Fixes: ea5309de7388 ("drm/amdgpu: add VCN 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index bf0674039598..b55eb1bf3e30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -281,6 +281,21 @@ static int vcn_v4_0_hw_init(void *handle)
>  	return r;
>  }
>=20
> +static int vcn_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +	int i;
> +
> +	for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		amdgpu_irq_get(adev, &adev->vcn.inst[i].irq, 0);

[Tao] we can also check its return value and exit if the r is none-zero. Bu=
t either way is fine with me.

> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * vcn_v4_0_hw_fini - stop the hardware block
>   *
> @@ -2047,7 +2062,7 @@ static void vcn_v4_0_set_irq_funcs(struct=20
> amdgpu_device *adev)  static const struct amd_ip_funcs vcn_v4_0_ip_funcs =
=3D {
>  	.name =3D "vcn_v4_0",
>  	.early_init =3D vcn_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D vcn_v4_0_late_init,
>  	.sw_init =3D vcn_v4_0_sw_init,
>  	.sw_fini =3D vcn_v4_0_sw_fini,
>  	.hw_init =3D vcn_v4_0_hw_init,
> --
> 2.34.1
