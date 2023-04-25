Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF4AC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 06:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC9010E69C;
	Tue, 25 Apr 2023 06:45:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC7310E69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 06:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byQGK5Taj6ezFaxzDeCtCsq5HNUZCdZwgLMUIaD9riTek04RZ7MmIdYzpIIAdCmNGpD3W9AyMUfiSX4nfm42qAh/hXLQS4UQE2U1IN+gir33B93RbJWaAb7iMb07D8MaysVhs+tAbAdHLzgTL2l9Ej5rvnM5Lc0/GJbZWOKZNyyu4OGd2XQYk9NnCz2FX/SSGHAxRUKzZGzI3UKkv9BTHQYnTT3ktneBMoo+vXkGkhSSQpewOTVtWaXe/E07Nuuf85x5VshgsCKsxYCVUzD5PhdHk98XrcJ7CbCpzy6A+JE8r4pxZdAUym2XGiFsOur7wTyfauZr54wsH7hAExd+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=880Sl0gMBe2ct8q/x+cUQmH+MLD9czBce5lpei6P7AY=;
 b=oNpIMZaRloS56ZsDYABS+SWZKbdZVByA1ZgqTrRJ73N57okylL0Ida9y8WBTfQBR0TH2plspbcEc10N/o1LTOTYtZrpgoTl3dynWuWGmphsAY7u2ndrlT0BRUoQ+LLZQmVwh6QeJyKGG6mx4WD56g6+gEec2gRH8XdXbIXASbxyL9McyJwbBV8gj18FwtHOMneOQapO3NnCr3npqnL42lhFLXXsz9TQumw9tdADwEAnFlEIJVoHTqza2J6/3fXG1HpdinV6LbQW8RSZRWBcRnAUP02RTk1aSQmvp8VpM7MWbvg7DbgzlRfbJbvV9F256RL7BDkkKmiKseePIghr+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=880Sl0gMBe2ct8q/x+cUQmH+MLD9czBce5lpei6P7AY=;
 b=gCLI6xPXcQK5w9GOn5cnph6dbImjYRwyFIEajIaQOGbN+AJKNA+Y3SoWEMcKb/jMA4yEpdSA85SJsnQaCdfj2QMbN+TkksSPyln69QHOXxFPHesB3NSLe0NrCHPAbzPtNVCTC8t2sOEohZHCizAn9YBFornSy6v0BkFMVVVVmzM=
Received: from SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 06:45:00 +0000
Received: from SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::2312:a262:5631:369f]) by SN1PR12MB2591.namprd12.prod.outlook.com
 ([fe80::2312:a262:5631:369f%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 06:45:00 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc
 hw_fini
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and
 gmc hw_fini
Thread-Index: AQHZdpjETijCHdUyH0eNvq6G6SEYdq86UpMAgAFBcqA=
Date: Tue, 25 Apr 2023 06:45:00 +0000
Message-ID: <SN1PR12MB2591578C55F3E7E157003999F7649@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
 <BN9PR12MB525758042CF80D29449B0AB8FC679@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525758042CF80D29449B0AB8FC679@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-25T06:44:58Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2f844e6f-5dee-447e-ac11-29e155c12978;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-25T06:44:58Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5cc44b33-3cc5-40d6-842f-7e35d79b15ea
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2591:EE_|SA1PR12MB8946:EE_
x-ms-office365-filtering-correlation-id: ba536ff9-1a3c-4917-b35b-08db45589761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9h1rdZmIHwTxRlWYkBd4rnccCRqfR0VKTSYiIQUtsfrRFWMXfcNAyYEQXGQeoR0y5yd5rGzLI4fkAYc5kABIo9ebbivmQvGfNU7GjwAqtoX1burJTDZaujYotWAcOW0SHv3/jzpCKgg5MMC6OpmGh7HkYLHkA64TwAZhS8ztGzNgn5f3S3Ko/TPFZbc+IHc/cmGs+mSQmSWW2yADcQaQwLsGgQDvspfhNQpu1Lzl+4tKg6j8UaOviM3ypYZ2sZlxComhWPWkpg5QRDPaKhLXLCzlbhas3FagUBdWk3i5vG8QCPpufI1ZCK0Y2gfw4pGhXnRmYLpPj1UHdWqgQqvC0DHX2S4jrKgj/cHLp+vMyorlozWBf+HgLvOw0uxCsH2VUz+RTGa3lfgiRpkbrvgplkJk1XPs8+I4j2xYsvxJ9LnKyPYKtxi+yesTH6vu1c78jpncaKfaLdVEOBidpb7GOcpNri/Tv7EO60HpWlxXD4PT8hN4nLD6s9exb9QhPXuVLcghWyPUMjUPriyjPM1nSL7GuTLXuKm3OZifBCFXy1hjE6FxUlCYROGn4mt8ocDEUQELFemgnYyxr56MrTQhgDOOxiLaK5nJdCK8bboa1tr8SjGSU2Ies1Q4/BIJP6u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2591.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(54906003)(110136005)(38070700005)(478600001)(76116006)(316002)(4326008)(66446008)(66476007)(66556008)(55016003)(66946007)(64756008)(122000001)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(86362001)(186003)(6506007)(26005)(53546011)(9686003)(33656002)(7696005)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81xyJbEcvkgiwoER7bXycNLTsGxep18DXKSTfPG6Av423X0joxE1yzvnp8xP?=
 =?us-ascii?Q?hwWLZtL3txFm+3/1FA+fUOAGW4joX/EAbVQ3tJ6WtVu3zOIzSmPd2Q/EeGBI?=
 =?us-ascii?Q?mmahrnWKt8AGBQlgeOkHk8kEx3Px8aXeMKoebJ6tRtdT1Fuc6WBnX00HgEvm?=
 =?us-ascii?Q?eyifNx73ED5dEf3yMhJUf6ofh7E3RuVzVNjpOEh2Wecf6YFvFCEIB8fson6f?=
 =?us-ascii?Q?/4xchPnNx8HcbbiVdjhYp1O7v/t7P3ESXinBom7c0k0ZYyXi0rQzHlZoaP9Y?=
 =?us-ascii?Q?yHb1I5xLhvc1nyfF57QbrVP+AjwFN3K8M5CJm1u4WwQLk/+fj0cbcC0GvsUJ?=
 =?us-ascii?Q?tfOlXGTgTY+IgfPum6Mh7/yf7DFysGsJ7/nHB6nyB1HYPWc0hbqhJObod/n2?=
 =?us-ascii?Q?LO9bKvDBedoXcChqsf+tnFBq07PoY54r2TkeedJNPae3VGsDpUB1//u7ie/1?=
 =?us-ascii?Q?BKhqmoevYX6PgH1TwmuiVgLNMu5e+szizxnziVZyKXrr4mPUrUFpIYpV24eD?=
 =?us-ascii?Q?0vag/axZzj01gfuwa7ts/jq6o03aeAJHyuVmQIqyziksor4nXWoBXDdy+IB1?=
 =?us-ascii?Q?Osodb4MQzWqut575+kWLh9AHG+n1mRH2zuh8EU27ib7xGGXkmlKhI2LoYdmK?=
 =?us-ascii?Q?dWICIUu+4C8cz139c9+t1bpS3RXepsf7zH6Hdjnh6SjaPIa6zYrcl4Q8M5Ib?=
 =?us-ascii?Q?PFZq5snSB/Ke5AI8fUsZO4WDIjD2l7Tid3WRGiHxjno3Hg5ptd3gmk88jAy5?=
 =?us-ascii?Q?9bMSWqf+OmqnWUTQS/QWCPm57/jmEK3RarCcZDerStepklHP0n1MpAQGBMCV?=
 =?us-ascii?Q?YU47weTMlJisG6TA9L8tIOuL8BNUqNWRl5hgNKX6NSivV7FNaUL4fPQ18kv/?=
 =?us-ascii?Q?LFeSHVeUEUnzGRI1Y8CHA4HgbWg+KfcFl4AWVsYpKb8gENyC9bdGyPoyzxn/?=
 =?us-ascii?Q?j4PmBNpe/dr/3Dv1nH4ihx58WLWe+Ek14XZtV8oGBp8yz5X42x47rvfwHVoJ?=
 =?us-ascii?Q?NrsM9/Oi21H/rBk+mgFHiqFzQRjAqSKPhyinyz8XOg5bk2YU53psXI7YjKLb?=
 =?us-ascii?Q?e2G0j9A+5mTtIsu2Yf5YtyAPVZX5ILswq9prc3xxnZae9skyB6omISj9NNPJ?=
 =?us-ascii?Q?X8YSI2+fwNh3x1YzdfhnXoX/wmTRwvgnq6RusCecX0CVK5BwJv4U0ErhXaRH?=
 =?us-ascii?Q?eCbJpLDfcWDOtqpJaRMgOnZW2BOy8lhXGyOgYfw6KaBjCWiEsL5nTEtLBdro?=
 =?us-ascii?Q?+FMIZOGNaNSKNFAgZr+lM9PS6CMxiARGwdfZfkns/YzAkmXYyrHj4PSXuY7g?=
 =?us-ascii?Q?e0ueBhbu0utUqBHRMng7j/amnQA3v18XiB9iFcDPmPfbZkpn1hWnDen74ByB?=
 =?us-ascii?Q?sHNoiNeo9AgJ/IgiU4dBzSihBREm11lX0i0GtubI/EbMa0yNetym0STGtAKj?=
 =?us-ascii?Q?0gzluoLmD7dQCGgILNWnMc3hZj0vjmVgvlxjqeEhEtVx7D05ERsNGm/sY2la?=
 =?us-ascii?Q?PDR5xGc85tzWGLvE84a2J+wYmeD+1nmuqW72dDiW12J9WZAuktZ3NGY84ZNw?=
 =?us-ascii?Q?zWiPC6YL4puEg6e051I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2591.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba536ff9-1a3c-4917-b35b-08db45589761
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 06:45:00.1991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gl7QXa3EXtO/ZMDEZwHcdq2RHtLy76O8fytYK4Z/lwCZHkbGhYhdjLybbgMzYH95uYvVrG4UycdWoTmv5pxWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Hawking,

Thank you for such a quick review, I think your suggestion is a better choi=
ce for solving this issue.
I have updated the fix patch about this issue, could you please help me rev=
iew it

[PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is not needed a=
ny more
[PATCH v2 2/3] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fi=
ni
[PATCH v2 3/3] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fi=
ni

Thanks,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Monday, April 24, 2023 7:28 PM
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yao=
, Longlong <Longlong.Yao@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and =
gmc hw_fini

[AMD Official Use Only - General]

Let's handle umc and gfx ras cases in separated patch.

gmc.ecc_irq maps to df mca interrupt, which is enabled by firmware per IFWI=
 setting. Check GFX RAS mask is not correct in such case. host driver is no=
t privileged to enable/disable the interrupt. As you noticed already the se=
t function is dummy one. then just drop amdgpu_irq_put call for gmc.ecc_irq=
 should be fine.

gfx.cp_ecc_error_irq is not used in gfx11. Feel free to retire the interrup=
t for gfx11 in another patch (i.e., gfx_v11_0_cp_ecc_error_irq_funcs is not=
 needed any more)

Regards,
Hawking

-----Original Message-----
From: Horatio Zhang <Hongkun.Zhang@amd.com>
Sent: Monday, April 24, 2023 18:37
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zha=
ng, Hawking <Hawking.Zhang@amd.com>; Yao, Longlong <Longlong.Yao@amd.com>; =
Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc =
hw_fini

The call trace occurred when the amdgpu is suspended before the mode1 reset=
. For the IP block that do not support ras features, the relevant interrupt=
 is not opened during initialization, but hw_fini forced the close of this =
interrupt, which resulted in amdgpu_irq_enabled check warning.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu] [  102.874019]  gfx_v=
11_0_suspend+0xe/0x20 [amdgpu] [  102.874072]  amdgpu_device_ip_suspend_pha=
se2+0x240/0x460 [amdgpu] [  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80=
 [amdgpu] [  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu] =
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu] [  102.=
874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu] [  102.874375]  proce=
ss_one_work+0x21f/0x3f0 [  102.874377]  worker_thread+0x200/0x3e0 [  102.87=
4378]  ? process_one_work+0x3f0/0x3f0 [  102.874379]  kthread+0xfd/0x130 [ =
 102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

[  102.980303] Call Trace:
[  102.980303]  <TASK>
[  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu] [  102.980357]  gmc_v1=
1_0_suspend+0xe/0x20 [amdgpu] [  102.980409]  amdgpu_device_ip_suspend_phas=
e2+0x240/0x460 [amdgpu] [  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 =
[amdgpu] [  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu] [=
  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu] [  102.9=
80687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu] [  102.980740]  proces=
s_one_work+0x21f/0x3f0 [  102.980741]  worker_thread+0x200/0x3e0 [  102.980=
742]  ? process_one_work+0x3f0/0x3f0 [  102.980743]  kthread+0xfd/0x130 [  =
102.980743]  ? kthread_complete_and_exit+0x20/0x20
[  102.980744]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu=
/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 543af07ff102..0f6b037558bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4483,7 +4483,8 @@ static int gfx_v11_0_hw_fini(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
        int r;

-       amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+               amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 3828ca95899f..25f466c26d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -951,7 +951,8 @@ static int gmc_v11_0_hw_fini(void *handle)
                return 0;
        }

-       amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
        gmc_v11_0_gart_disable(adev);

--
2.34.1

