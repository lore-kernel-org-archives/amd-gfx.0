Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E18DCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 13:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A177B10E0AB;
	Wed, 18 Oct 2023 13:36:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA3110E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 13:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8i+5aTkCeSxTb9kmoici41MfBFPE34jC0AYuVgoZPrAxk+Df7ITzP6DHZHovA2nCvqJ3pSp8k6OS6686ScuYU0meS1nyFBs6y5mrbUczdjCV6drLrIHiUGSVryo5cLfi8PetTjQWiVAtXK240tJpnB+Qxq5OhVNKcMDjN6tEKJJpm47aCd6KV2RqBRuOZqE4ZUHoCm1tYeAIEix+3XCiV13lHx4gdsV6djNRd0XDCyqCKV1RlR+PT3qnmOPRLpgI+EVOZmvW+U7G4IR8P3xj04N1noMR5nVVwMrw2VEr8VPRLosBCbIm22S9w4ADYh9woxnEowPME9EEEu9xExs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTxa2YnKSxfxazBiEJ59AcSkDCdtAtqWD7D6Q8MUycc=;
 b=gLN/jT0YiPT+QLm2kseqXqgKi3oH7xvqTZKfyKg0cbmcFLoofLDwZTOhxl2MPsD+/XFlkCf1Oq3SHtp8fYzetnl+yA9yn42RGCGkgZfNW51g9G+NOJGvEdfqh4crfGRXzmxCLByWg45WQ33e9MN+gMr7WwhJD9g6GODmcnYnwkmgXFuIp8f5iUlaW3T6csY22ixHLuHnB6ZZea3xBGe+1FrfxmjpDddp03S5rC1994hbXg3rrNRcONnpFXF7KRJ/5XtIgCA7eoE7vB5kVsDpjZZkzdLRdJ6D3JHF6y6b50G4xPsYi3u+vPQX8eZiTq0TLZ1xDU36sZ33OZrMDnAG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTxa2YnKSxfxazBiEJ59AcSkDCdtAtqWD7D6Q8MUycc=;
 b=SovSjPQiVZV75rBEUXVy9q0/timi9xtFrc3LnEL6vouLxH5xU2lnATNgd60eCoECtSAfB9R2WEaLzA9S/+NSjM9udu7mGjlxBzhPuOhk463B0ID/SEX0EOxhxm7kB+Y9zGAyxZuIoEvTeHLLRxppXO19HBZ7eVMgGiFlr0JElrA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 13:36:39 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 13:36:39 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Thread-Topic: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Thread-Index: AQHaAZep68smsPCrA0eYAgRZjhWLtLBPiYaQ
Date: Wed, 18 Oct 2023 13:36:39 +0000
Message-ID: <CY5PR12MB6369F24E1CC12D5682BAB3E3C1D5A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231018074931.139904-1-jesse.zhang@amd.com>
In-Reply-To: <20231018074931.139904-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fbdda52-d4e3-401f-baec-bb5633e8c668;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T13:23:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DS7PR12MB6191:EE_
x-ms-office365-filtering-correlation-id: faea9346-2825-4a1b-283e-08dbcfdf41dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QakTQ0iwLkfV78g8qL60my3EjaDivO8sG5wtUpyrblvuSlawOzG/kYd8RiTUyR3ft0Ynl9cwInWzEp0cp51UG8yqwQjvjx6zvr27dz6xa0bfkQGjRzcsKphhw9FT+WoZhUfA28zr/CPR2CoCOk1OpyoqiM/AdvF6PZCjscbEZGoPX//W885P7mt76j1hClSA4G3MbFyobw/2RA5AvEhHoJpdpL/7rrKkhfMWiy/JpT9jpW6HFbKK/6MBsps6iUdereNZ2B7tcX9g2cPqdDBX9IAsWDuyOiud3FGWHa/mraoYX+aOz3kT6mpqltp/k3+yuAcFnIdc1Sj/fUUHUNYC05jhbbBRYYBUrklW1CN67OO7zWn+P1TuzehkB0ZWDd5AmIXjvS15dz2J5aDQJ7nyyjgB4TRhY/RUErQo9C8g/mpXL6/jSdFBrJ6j5EctfQHVR19Ejoyamd74nouzn3tNxcDkLvAYi3FIQkpbjkjqP0SrvFFd/QczIanVYyyFjDKLLCMwAGa/M2/l8CR8oeDT30s6o9ufw31Li7jMhqLYtrR02weFcc1YUzICql8/XZ6hJJdgDPFcocHUG4IoZxYuV08jNS/O5OX6fDkDRtikoE1Tpve6L2bWwS8HPT+g6SyG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(9686003)(7696005)(8676002)(8936002)(5660300002)(4326008)(52536014)(41300700001)(316002)(54906003)(64756008)(66446008)(66556008)(66476007)(76116006)(110136005)(66946007)(478600001)(55016003)(38100700002)(6506007)(53546011)(33656002)(86362001)(83380400001)(122000001)(71200400001)(26005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wbjRMoq9NDvW+y6vzD2dhjTljMmY+dayy3qVmbpmiDlCjSAeinbpvT6jezPr?=
 =?us-ascii?Q?4gE6Lm4LfsKTHN1z55SyaHR3UqC2Znoymu4KsHsxLRfEViXT29O8XE6uKjMo?=
 =?us-ascii?Q?hAOBg+kVOJtZEC1R69IuU1lqRStTTKL3S29vAX/5yFOdpy3ufe18vaf39hPj?=
 =?us-ascii?Q?E+yzM0fhWvwBVYFWYasibB+bD1FtM7FL28SVu5I8NSxofPXpNnSjy3jU+n4D?=
 =?us-ascii?Q?h/Ka9PEFx5k1uokV+KUDL13XdsOWOa9nnjPcxeVPLlLcXPtnBzfd0xpUTgI0?=
 =?us-ascii?Q?w2fu5yIaraT67dlLshmorCZDfxVWGvecTZZoH/8IBJxS2DwdFYN2RDqGQqqK?=
 =?us-ascii?Q?hp7Ek864omkjnzkfd/lPVBcZ6ZDPQnavGuV6LudMFkTPtOmXDznGOLnhkVRx?=
 =?us-ascii?Q?9L+8YbHhwk1vXg3iDqSAC6rlp0TViajth44B+o90KehEK7B6mj5+U2DKYYcB?=
 =?us-ascii?Q?99+QXpHeBJh/c97UWllohTSH07eCtPfT6+HU+bwy2Jv7Krdj+EQQDMU4fUL1?=
 =?us-ascii?Q?5Xw23B4JAhAy2S9P/NjP/M/sdz9ZJjdycXO/BDW4K/6eqWaiUGov0xzmpWYe?=
 =?us-ascii?Q?Wng4HAxFA8NcPfkJ+TN6ON8oj5ur1ORFqaDSTMIGACUd2kUZvTVHjtFzhsAZ?=
 =?us-ascii?Q?pDezZcO7CPHPR71+GTQ4QwrZO2gIxvi1z61HMCeGT0v7+Rpm5j2yG24RC0rw?=
 =?us-ascii?Q?YSeDgY/orGuWb+aAOiBFSxCTslJSftZuTejM951c4V/HQIaa+wdEjWpnLv3T?=
 =?us-ascii?Q?fX0lk5aPvOxeKjJ+ExjXTgK2lpY0I76Nfhp2v+pvTHoHRxWDt9hUhR2Jnh/7?=
 =?us-ascii?Q?xror88tB7ylyBr/GbB279C5yiXGHhYkEug1v5Ns3Gotp+xLbwJz3HBg2zLRF?=
 =?us-ascii?Q?iNJ2EnsI+oIq8c82sqcQ/tiTSNt+cIoz8vWUsnkhj29tkyU5FJ8Ps3U4sJL8?=
 =?us-ascii?Q?URmxeCk76OwJSg93ELYl3AVcES8brFSjElelQANd+4KHiX6QtX9oOM1h2RvB?=
 =?us-ascii?Q?3RwqlZHxFgIhFpEnpBvMOpt5t4Q8n0k7eAZuYuV2IJMFayIbw8MGrpvJYLdA?=
 =?us-ascii?Q?u7kE0QUAAxzzecM2iOlHCGKcV5OJOnYJ3osW8LMyH6Ood4ngXLg9yqztrPPD?=
 =?us-ascii?Q?nnYN6I27VD+nOhMMNQhTqahpwYfwcTO15noHzzmrrJtDJUgxZMfC2Slvs7MG?=
 =?us-ascii?Q?FA8vNqXPWZyBh0vMu3xqChStMCKA8XPC+8ErFnC+oXJtFzOdUqdTfl2siORs?=
 =?us-ascii?Q?wX4GWb77V5aahNcqCwXFUYUZvTNo9OmixaXx3I0xDMMa2L2jg5rHoREIgyGB?=
 =?us-ascii?Q?aB/kvAruWTPmBj/v2LLu2Rl+hiSiLisgB5jvuHjaVnuOYtPXLyqLzWJstjrH?=
 =?us-ascii?Q?Kw6VCFKUp9F8NIso3Mr9bOb58MgmgC0x2ke0op6Zu9ZIVFbKv47kzIcniHhO?=
 =?us-ascii?Q?2hzTr9c+594Of1WfvTiheXfrwG8919Bx50356LxB8Sp3jnivzSBLn3l19wv+?=
 =?us-ascii?Q?knVLnzAykKwvV0e9L55EQjJVYxhL/bdcmKuuRJvjNEHOW3P2m5HxwrjZY6/M?=
 =?us-ascii?Q?AZU1AQq7fyr6ppS3prE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faea9346-2825-4a1b-283e-08dbcfdf41dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 13:36:39.2694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+EimciTS3yCsHUl+kJ74PQFQFHnwKWOLnvH44emHIoCRg5nyq7Bsx3OyROCp7XI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Jesse,

This patch is only a WA for the error log. How is this issue reproduced ? 2=
55 looks like an invalid value for a prange->granularity, it is better to r=
oot cause who set it in the first place.

BRs,
Yifan

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Wednesday, October 18, 2023 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)=
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue

[  567.613292] shift exponent 255 is too large for 64-bit type 'long unsign=
ed int'
[  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE   =
   6.2.0-34-generic #34~22.04.1-Ubuntu
[  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 =
09/25/2023 [  567.614504] Workqueue: events send_exception_work_handler [am=
dgpu] [  567.614748] Call Trace:
[  567.614750]  <TASK>
[  567.614753]  dump_stack_lvl+0x48/0x70 [  567.614761]  dump_stack+0x10/0x=
20 [  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[  567.614769]  ? srso_alias_return_thunk+0x5/0x7f [  567.614773]  ? update=
_sd_lb_stats.constprop.0+0xf2/0x3c0
[  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu] [  5=
67.615047]  ? srso_alias_return_thunk+0x5/0x7f [  567.615052]  svm_migrate_=
to_ram+0x185/0x4d0 [amdgpu] [  567.615286]  do_swap_page+0x7b6/0xa30 [  567=
.615291]  ? srso_alias_return_thunk+0x5/0x7f [  567.615294]  ? __free_pages=
+0x119/0x130 [  567.615299]  handle_pte_fault+0x227/0x280 [  567.615303]  _=
_handle_mm_fault+0x3c0/0x720 [  567.615311]  handle_mm_fault+0x119/0x330 [ =
 567.615314]  ? lock_mm_and_find_vma+0x44/0x250 [  567.615318]  do_user_add=
r_fault+0x1a9/0x640 [  567.615323]  exc_page_fault+0x81/0x1b0 [  567.615328=
]  asm_exc_page_fault+0x27/0x30 [  567.615332] RIP: 0010:__get_user_8+0x1c/=
0x30

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 7b81233bc9ae..f5e0bccc6d71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1169,7 +1169,7 @@ svm_range_split_by_granularity(struct kfd_process *p,=
 struct mm_struct *mm,
         * PTE will be used for whole range, this reduces the number of PTE
         * updated and the L1 TLB space used for translation.
         */
-       size =3D 1UL << prange->granularity;
+       size =3D 1UL << (prange->granularity & 0x3f);
        start =3D ALIGN_DOWN(addr, size);
        last =3D ALIGN(addr + 1, size) - 1;

--
2.25.1

