Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E86C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 02:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105C610EE12;
	Fri, 28 Jan 2022 02:34:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3857910EE12
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 02:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHYLx3AiduW0jkhB0Z/MPuBUQolDWJhJ5jJvvQDNBpbzu83zciQoP1hl3lSgZq8XCWpZkUmVHLz8Oz2+Av8ppGg2nGoF0pXHre4DvMZLME6jMTZvoPzUrI6ANW1IgTwbfnKX9KH9vl+SLx02ZAAesJkU887dhOJxyyNIs04hySev6caiZhcth4CpZaV6wQOE65uDhbguxU0NxHtD0i1tuwwWDHWe3GQ6aYpzfXlYIfNjoWK2mL6HXqljK+lGVzB7uuZChteoGW8nN6rvPiV+M49ac1ft3T92tQMAi2IYA3eYkhvMGj8Pt/ZPxpKKozgrP7BinH0dF3rMnAbEtgx/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIo0E/Yd2cIqZSyjJToxx9VbiglPTYV/qXc88TTDZxQ=;
 b=CMpbSm8U1q8+OxFhrK4P6HReXAOAgWo60fyDfWAfRq883TotH/UVZsAKq9TBGvMYUMgoTPf6OW119hOL5epZxcU2YE6PiRrIQHbXrsKkRJ6Tirj32i7gw/ZJLQ1Nemn56PTwfD5fMn85GEofHHeZJx6KxaIxT5T8GBGVknJz4Ybh7S8z83RyDZeaHCfGDRzY+7qHzZ+qPKsYmLMfFdDNgaccJPL9TwFQ7PCQxqMPLFtT6OIHYeeajNc3e42unVCL9dzOY9ySUYLBR9opCXOWoTt6FaMZbtogrIg61fHxeyqsK8S86LsPQ17kCNPR3UT5lA31I/n1JXoECjgCaoLUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIo0E/Yd2cIqZSyjJToxx9VbiglPTYV/qXc88TTDZxQ=;
 b=jnnsmDUXWS9NOcX/kHTYhxgJo7FHouswEubRRdyTd+upnxTAbE7l8isScdSCC1zk/T8ES3qpBcrZQIt0VukNZL246O/kxNGdSscAs3xvkdK3EvhaGK9Z8zZ63VgYMR+DNxCNSR7eJpLlkHOBlZWbyOlPK6b3s99MoHNA6Z32rw8=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 02:34:04 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be%6]) with mapi id 15.20.4888.020; Fri, 28 Jan 2022
 02:34:04 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Topic: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Index: AQHYEdLUqv+l+snVMkWySvGKcSJw8axzjpeAgABPAwCAAL9QMIAAzHQAgADFr7mAANJtgIAAuL53
Date: Fri, 28 Jan 2022 02:34:04 +0000
Message-ID: <DM4PR12MB5294035B7A2685C9A1EBBE1895229@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
 <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
 <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
 <DM4PR12MB5294D2C47F12FC897406884295219@DM4PR12MB5294.namprd12.prod.outlook.com>
 <1f6ae3fe-5463-cf80-063a-2c8a500b9b2a@amd.com>
In-Reply-To: <1f6ae3fe-5463-cf80-063a-2c8a500b9b2a@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-28T02:34:03.985Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 04f625cf-f77d-27c1-df92-bd3c8fe38570
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c45715-2cb9-4ec8-ba29-08d9e206a6ee
x-ms-traffictypediagnostic: DM6PR12MB4252:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4252A00FDFBAC5D3A1AD3A2195229@DM6PR12MB4252.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+ZQ+OJoxSVFv+sKndnKCZzt+B7OV3td/WmfSN4v9KemouX12BRb2wWSebuMEEuNLFnp6CUv5S+JAHwlH3BRBhtKnPZ1u25dwdc8m94JWfxGE9foHfrU2knoPi50n6lA3aNXIw6iy0bj2V9ySJ9uctECu9she2kjoHkcZ+5OR0sK5KAgnKQxi3U8aXu/FzcicTsYyq08Olzo5gqPrUTTFGHPKnEtfQQzY3TPH/9pehAKG3e7UiBI04fWxZHovepcL9pl9miAeatb54HwNaupfm0diwpAL3aT4ICrcyogvG3wmklaCG5mxqTdbDW0BrFne2F0mM5ZMjdoRbthL0hNRXjXGhGLxHn4TkoN2zyPcwfC33tAmKMFPjsJMYT++9rlbDPjZh500kzGOh0IQYbbxAk3QSOcrzUGN2TbOyw239Xca9jbkh/iByENHUBNqJsW77iFm/7PO/BY1KfT6xkSSshEoWUrwxztANzYWwW1vl3jxkSPhoOrJmyTlOL7D+6Q5wd/LbsIOnzpcbyudg5CefbemUB2WKg1osisyCk0heo1n+NZ00d3HM8EAGl4idJiZYo94XOh9YhzwXurX9+uO6T9DijrxU5jghJBYCdY1Cn06AQ4S0qjH0WX5F8AWErzhzaJo75AMhw2qH0qkgZ4o2mkC+ghh1BbXGRCgf+SzJ6+5V1gDcf0yN+DbuuJ1DccTLixrOu6kJjZrPHj4P6aSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66446008)(76116006)(66946007)(66556008)(19627405001)(8676002)(8936002)(4326008)(55016003)(66476007)(86362001)(52536014)(316002)(5660300002)(91956017)(122000001)(33656002)(9686003)(15650500001)(2906002)(38100700002)(110136005)(26005)(54906003)(53546011)(508600001)(71200400001)(6506007)(7696005)(186003)(83380400001)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mY/lT+aOxTgnM9U/iKC/bxrG20UJnbAa8CMvn6h7NWmuYcaoG/t5ugP4SY0c?=
 =?us-ascii?Q?73cGXCNiaGrnURu08fp2U1TdCHV5Eo8Bj1sTgpV4NHVw3MthSfxpOJLVeKm4?=
 =?us-ascii?Q?rEEjna9LgWHnUW1YXOp5z3xokxD6RWbGdAx08ds8GWZpPqeQxIc3M7IZvnbL?=
 =?us-ascii?Q?XkmI+Huro8DM0JH315trv/qDxowDpd/Qkro4IYQJuAdAXSqbT/igMtfBYWb2?=
 =?us-ascii?Q?AwVOaVZNol1+q7f4MLWCNjJ9IWnQezaopS5exiX6HoP3lmexHndSd82thB9i?=
 =?us-ascii?Q?KvhXKVb1QBFV5+jce6YaB6zbdINv8D/CazoHsvGv2cy3VUvPhlgh3i1EKobf?=
 =?us-ascii?Q?eZdvHqcJvvi9b4E0iwKRjuR1+DDVD7NjEIZqSgpTnSHCXxtEtd4Qv8W5FRgm?=
 =?us-ascii?Q?n1UsCr/iRPEWJCpx309sn/CvlnHkLYmdzOIyoXJx5yfihhEj3rtUse+CJsxy?=
 =?us-ascii?Q?XLKDLDNePWE6f6xcXAWGln+3DieZwhdLZU5xjP96WMa2zoxm3o1pbW54qtDw?=
 =?us-ascii?Q?ir5FFxDJLbCUamI4Wz+8ovgncIcqAHtv6I3tBedbqJl55q+ajNgAz68Ha2zW?=
 =?us-ascii?Q?TTQpK2KAwcXdoeJEKLluCHrhqPmAY+0G4mJIoKWfJYNAjNfj8mOZayTs7AEu?=
 =?us-ascii?Q?T5A6U4YJEYHrDLyQsyn+brTPCIJfKTvE6GHPxBiMHpBg5PXwZxdrdvjH52u9?=
 =?us-ascii?Q?+/DhNZqwirrUd7FryfIMhkElNBxO06XTu+d4nFHo36gY55RB78nP/zbJ2oRm?=
 =?us-ascii?Q?CYOPLKwAYbCWrYNPkGi/oJePuO1UgRHnC2tmDalKi3Ehj30huoKHREryIN2r?=
 =?us-ascii?Q?4NSau3xLS39aSZMOdwP2UKj9ULQcybgYdm/PqtqaMmUjipkIlITERwaO/YsA?=
 =?us-ascii?Q?CX8QlDpDpZjtYSrrRxvYdGRvIGmY+bZS+Rod2uGzVCRzYB/ELFPUtU39Zevg?=
 =?us-ascii?Q?B6rfussxEQn6Eu5KkGpI0xqVWUz8C16osy/4cdXyzntwYsPvielv8Dbvj6ap?=
 =?us-ascii?Q?FSWQAjY/biKD5kjLTCuKeiBEJcR/wfioF2vWP4LwfexqHlUsvjiTz58HRxyK?=
 =?us-ascii?Q?9mXhAirwOGjhpRqj+gIZIbyIiwVZcQ8tkQ4fXXgNv4tYxxMc15f8ClAdx8hv?=
 =?us-ascii?Q?7Z1p9PlBJFSFLCoc4ENwtST6iE1VddkXXoHYOiR5Iw3prFPFx8LZiuTP+jz0?=
 =?us-ascii?Q?33n0M2qMZLjXaTSmT0mYbO0GOBet3rgtCmjYZySxBd2SFLZ6f5Wy9HCQNwq2?=
 =?us-ascii?Q?YwxDoSCY8FCZAoIwtHIV8iloNQOUO5dEcnFzGimBUOrjGWUdauz23qmeLI2Q?=
 =?us-ascii?Q?Ee3KJTx1sedZunep8IRNuIY94HuhhJ2q8GW5YUvGK/DE5awRYeDrxwBHslFW?=
 =?us-ascii?Q?P5KreT0APzb/dZtHyTWS1SiZAzlBDkxBiSm5xkSTajRi8VcfAvrBul+RH985?=
 =?us-ascii?Q?nLjGVgmRh3LEsLx6YWS+lQma6SsBuSkgq5ijCZms/4f2y4zkWPsRyYR6Twbn?=
 =?us-ascii?Q?6qB/ZeSRDmXTL5/QuHuCc563jKeOL05nArVrrG3i12it5rinI8sGCUmtQDG/?=
 =?us-ascii?Q?6pbgu2Fkthl/1ojncBe3RBkVurMSGyexEnFwd+n5P2Zh3meaeNBVPilrRQH7?=
 =?us-ascii?Q?nZCYhXYDOSmOc7Y4A8FB6s0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294035B7A2685C9A1EBBE1895229DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c45715-2cb9-4ec8-ba29-08d9e206a6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 02:34:04.7510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2s4fmaVr86NyuCLcmpbcmlPv15nKPJXKaLtQsPc5HsdbkKCF/5U2rZXOd7BrG37hVhJlnyLfrOLYUMTkPfntw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294035B7A2685C9A1EBBE1895229DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

The error message is from HIQ dequeue procedure,  not from HCQ, so no doorb=
ell writing.

Jan 25 16:10:58 lnx-ci-node kernel: [18161.477067] Call Trace:
Jan 25 16:10:58 lnx-ci-node kernel: [18161.477072]  dump_stack+0x7d/0x9c
Jan 25 16:10:58 lnx-ci-node kernel: [18161.477651]  hqd_destroy_v10_3+0x58/=
0x254 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.477778]  destroy_mqd+0x1e/0x30 [=
amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.477884]  kernel_queue_uninit+0xc=
f/0x100 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.477985]  pm_uninit+0x1a/0x30 [am=
dgpu] #kernel_queue_uninit(pm->priv_queue, hanging); this priv_queue =3D=3D=
 HIQ
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478127]  stop_cpsch+0x98/0x100 [=
amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478242]  kgd2kfd_suspend.part.0+=
0x32/0x50 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478338]  kgd2kfd_suspend+0x1b/0x=
20 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478433]  amdgpu_amdkfd_suspend+0=
x1e/0x30 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478529]  amdgpu_device_fini_hw+0=
x182/0x335 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478655]  amdgpu_driver_unload_km=
s+0x5c/0x80 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478732]  amdgpu_pci_remove+0x27/=
0x40 [amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478806]  pci_device_remove+0x3e/=
0xb0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478809]  device_release_driver_i=
nternal+0x103/0x1d0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478813]  driver_detach+0x4c/0x90
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478814]  bus_remove_driver+0x5c/=
0xd0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478815]  driver_unregister+0x31/=
0x50
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478817]  pci_unregister_driver+0=
x40/0x90
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478818]  amdgpu_exit+0x15/0x2d1 =
[amdgpu]
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478942]  __x64_sys_delete_module=
+0x147/0x260
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478944]  ? exit_to_user_mode_pre=
pare+0x41/0x1d0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478946]  ? ksys_write+0x67/0xe0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478948]  do_syscall_64+0x40/0xb0
Jan 25 16:10:58 lnx-ci-node kernel: [18161.478951]  entry_SYSCALL_64_after_=
hwframe+0x44/0xae

Regards,
Rico
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, January 27, 2022 23:28
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin) <KevinYang.W=
ang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod

The hang you're seeing is the result of a command submission of an
UNMAP_QUEUES and QUERY_STATUS command to the HIQ. This is done using a
doorbell. KFD writes commands to the HIQ and rings a doorbell to wake up
the HWS (see kq_submit_packet in kfd_kernel_queue.c). Why does this
doorbell not trigger gfxoff exit during rmmod?


Regards,
   Felix



Am 2022-01-26 um 22:38 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only]
>
>
> The rmmod ops has prerequisite multi-user target and blacklist amdgpu,
> which is IGT requirement so that IGT can make itself DRM master to
> test KMS.
> igt-gpu-tools/build/tests/amdgpu/amd_module_load --run-subtest reload
>
> From my understanding, the KFD process belongs to the regular way of
> gfxoff exit, which doorbell writing triggers gfxoff exit. For example,
> KFD maps HCQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ,
> these both trigger doorbell writing(pls refer to
> gfx_v10_0_ring_set_wptr_compute()).
>
> As to the IGT reload test, the dequeue request is not thru a cmd on a
> ring, it directly writes CP registers, so GFX core remains in gfxoff.
>
> Thanks,
> Rico
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, January 26, 2022 23:08
> *To:* Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> My question is, why is this problem only seen during module unload? Why
> aren't we seeing HWS hangs due to GFX_OFF all the time in normal
> operations? For example when the GPU is idle and a new KFD process is
> started, creating a new runlist. Are we just getting lucky because the
> process first has to allocate some memory, which maybe makes some HW
> access (flushing TLBs etc.) that wakes up the GPU?
>
>
> Regards,
>    Felix
>
>
>
> Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):
> >
> > [AMD Official Use Only]
> >
> >
> > Thanks Kevin and Felix!
> >
> > In gfxoff state, the dequeue request(by cp register writing) can't
> > make gfxoff exit, actually the cp is powered off and the cp register
> > writing is invalid, doorbell registers writing(regluar way) or
> > directly request smu to disable gfx powergate(by invoking
> > amdgpu_gfx_off_ctrl) can trigger gfxoff exit.
> >
> > I have also tryed
> >
> amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,false),
> > but it has no effect.
> >
> > [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
> > [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
> > [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
> > [10386.162297] amdgpu: mmCP_STAT : 0xffffffff
> > [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
> > [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
> > [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
> > [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff
> >
> > Thanks again!
> > Rico
> > -----------------------------------------------------------------------=
-
> > *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> > *Sent:* Tuesday, January 25, 2022 23:31
> > *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico)
> > <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> > <amd-gfx@lists.freedesktop.org>
> > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>
> > *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> > I have no objection to the change. It restores the sequence that was
> > used before e9669fb78262. But I don't understand why GFX_OFF is causing
> > a preemption error during module unload, but not when KFD is in normal
> > use. Maybe it's because of the compute power profile that's normally se=
t
> > by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.
> >
> >
> > Either way, the patch is
> >
> > Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >
> >
> >
> > Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > > the issue is introduced in following patch, so add following
> > > information is better.
> > > /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> > > /
> > > /
> > > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> > > /
> > > /
> > > Best Regards,
> > > Kevin
> > >
> > >
> ------------------------------------------------------------------------
> > > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Tianci Yin <tianci.yin@amd.com>
> > > *Sent:* Tuesday, January 25, 2022 6:03 PM
> > > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> > > (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > > *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> > > From: "Tianci.Yin" <tianci.yin@amd.com>
> > >
> > > [why]
> > > In rmmod procedure, kfd sends cp a dequeue request, but the
> > > request does not get response, then an error message "cp
> > > queue pipe 4 queue 0 preemption failed" printed.
> > >
> > > [how]
> > > Performing kfd suspending after disabling gfxoff can fix it.
> > >
> > > Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> > > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index b75d67f644e5..77e9837ba342 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct
> > > amdgpu_device *adev)
> > >                  }
> > >          }
> > >
> > > -       amdgpu_amdkfd_suspend(adev, false);
> > > -
> > >          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > >          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > >
> > > +       amdgpu_amdkfd_suspend(adev, false);
> > > +
> > >          /* Workaroud for ASICs need to disable SMC first */
> > >          amdgpu_device_smu_fini_early(adev);
> > >
> > > --
> > > 2.25.1
> > >

--_000_DM4PR12MB5294035B7A2685C9A1EBBE1895229DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The error&nbsp;message is from HIQ dequeue procedure,&nbsp; not from HCQ, s=
o no doorbell writing.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10:58 l=
nx-ci-node kernel: [18161.477067] Call Trace:</span>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.477072] &nbsp;dump_stack+0x7d/0x9c</span></d=
iv>
<span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10:58 l=
nx-ci-node kernel: [18161.477651] &nbsp;hqd_destroy_v10_3+0x58/0x254 [amdgp=
u]</span>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.477778] &nbsp;destroy_mqd+0x1e/0x30 [amdgpu]=
</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.477884] &nbsp;kernel_queue_uninit+0xcf/0x100=
 [amdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.477985] &nbsp;pm_uninit+0x1a/0x30 [amdgpu] #=
kernel_queue_uninit(pm-&gt;priv_queue, hanging); this priv_queue =3D=3D HIQ=
</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478127] &nbsp;stop_cpsch+0x98/0x100 [amdgpu]=
 &nbsp; &nbsp; &nbsp; &nbsp;</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478242] &nbsp;kgd2kfd_suspend.part.0+0x32/0x=
50 [amdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478338] &nbsp;kgd2kfd_suspend+0x1b/0x20 [amd=
gpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478433] &nbsp;amdgpu_amdkfd_suspend+0x1e/0x3=
0 [amdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478529] &nbsp;amdgpu_device_fini_hw+0x182/0x=
335 [amdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478655] &nbsp;amdgpu_driver_unload_kms+0x5c/=
0x80 [amdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478732] &nbsp;amdgpu_pci_remove+0x27/0x40 [a=
mdgpu]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478806] &nbsp;pci_device_remove+0x3e/0xb0</s=
pan></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478809] &nbsp;device_release_driver_internal=
+0x103/0x1d0</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478813] &nbsp;driver_detach+0x4c/0x90</span>=
</div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478814] &nbsp;bus_remove_driver+0x5c/0xd0</s=
pan></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478815] &nbsp;driver_unregister+0x31/0x50</s=
pan></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478817] &nbsp;pci_unregister_driver+0x40/0x9=
0</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478818] &nbsp;amdgpu_exit+0x15/0x2d1 [amdgpu=
]</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478942] &nbsp;__x64_sys_delete_module+0x147/=
0x260</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478944] &nbsp;? exit_to_user_mode_prepare+0x=
41/0x1d0</span></div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478946] &nbsp;? ksys_write+0x67/0xe0</span><=
/div>
<div><span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10=
:58 lnx-ci-node kernel: [18161.478948] &nbsp;do_syscall_64+0x40/0xb0</span>=
</div>
<span style=3D"color: rgb(23, 78, 134); font-size: 10pt;">Jan 25 16:10:58 l=
nx-ci-node kernel: [18161.478951] &nbsp;entry_SYSCALL_64_after_hwframe+0x44=
/0xae</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 27, 2022 23:28<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Wang, Yang(Kevin)=
 &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@=
lists.freedesktop.org&gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix an error message in rmmod</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The hang you're seeing is the result of a command =
submission of an
<br>
UNMAP_QUEUES and QUERY_STATUS command to the HIQ. This is done using a <br>
doorbell. KFD writes commands to the HIQ and rings a doorbell to wake up <b=
r>
the HWS (see kq_submit_packet in kfd_kernel_queue.c). Why does this <br>
doorbell not trigger gfxoff exit during rmmod?<br>
<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
<br>
Am 2022-01-26 um 22:38 schrieb Yin, Tianci (Rico):<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt;<br>
&gt; The rmmod ops has prerequisite multi-user target and blacklist amdgpu,=
<br>
&gt; which is IGT requirement so that IGT can make itself DRM master to <br=
>
&gt; test KMS.<br>
&gt; igt-gpu-tools/build/tests/amdgpu/amd_module_load --run-subtest reload<=
br>
&gt;<br>
&gt; From my understanding, the KFD process belongs to the regular way of <=
br>
&gt; gfxoff exit, which doorbell writing triggers gfxoff exit. For example,=
 <br>
&gt; KFD maps HCQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ, =
<br>
&gt; these both trigger doorbell writing(pls refer to <br>
&gt; gfx_v10_0_ring_set_wptr_compute()).<br>
&gt;<br>
&gt; As to the IGT reload test, the dequeue request is not thru a cmd on a =
<br>
&gt; ring, it directly writes CP registers, so GFX core remains in gfxoff.<=
br>
&gt;<br>
&gt; Thanks,<br>
&gt; Rico<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; *Sent:* Wednesday, January 26, 2022 23:08<br>
&gt; *To:* Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Wang, Yang(Kevin)=
 <br>
&gt; &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen, Guch=
un <br>
&gt; &lt;Guchun.Chen@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod<br>
&gt; My question is, why is this problem only seen during module unload? Wh=
y<br>
&gt; aren't we seeing HWS hangs due to GFX_OFF all the time in normal<br>
&gt; operations? For example when the GPU is idle and a new KFD process is<=
br>
&gt; started, creating a new runlist. Are we just getting lucky because the=
<br>
&gt; process first has to allocate some memory, which maybe makes some HW<b=
r>
&gt; access (flushing TLBs etc.) that wakes up the GPU?<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; &nbsp;&nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks Kevin and Felix!<br>
&gt; &gt;<br>
&gt; &gt; In gfxoff state, the dequeue request(by cp register writing) can'=
t<br>
&gt; &gt; make gfxoff exit, actually the cp is powered off and the cp regis=
ter<br>
&gt; &gt; writing is invalid, doorbell registers writing(regluar way) or<br=
>
&gt; &gt; directly request smu to disable gfx powergate(by invoking<br>
&gt; &gt; amdgpu_gfx_off_ctrl) can trigger gfxoff exit.<br>
&gt; &gt;<br>
&gt; &gt; I have also tryed<br>
&gt; &gt; <br>
&gt; amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,fals=
e),<br>
&gt; &gt; but it has no effect.<br>
&gt; &gt;<br>
&gt; &gt; [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed<=
br>
&gt; &gt; [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff<br>
&gt; &gt; [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff<br>
&gt; &gt; [10386.162297] amdgpu: mmCP_STAT : 0xffffffff<br>
&gt; &gt; [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff<br>
&gt; &gt; [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff<br>
&gt; &gt; [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff<br>
&gt; &gt; [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff<br>
&gt; &gt;<br>
&gt; &gt; Thanks again!<br>
&gt; &gt; Rico<br>
&gt; &gt; -----------------------------------------------------------------=
-------<br>
&gt; &gt; *From:* Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; &gt; *Sent:* Tuesday, January 25, 2022 23:31<br>
&gt; &gt; *To:* Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Yin, Tian=
ci (Rico)<br>
&gt; &gt; &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; &gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; &gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen,=
 Guchun<br>
&gt; &gt; &lt;Guchun.Chen@amd.com&gt;<br>
&gt; &gt; *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod<=
br>
&gt; &gt; I have no objection to the change. It restores the sequence that =
was<br>
&gt; &gt; used before e9669fb78262. But I don't understand why GFX_OFF is c=
ausing<br>
&gt; &gt; a preemption error during module unload, but not when KFD is in n=
ormal<br>
&gt; &gt; use. Maybe it's because of the compute power profile that's norma=
lly set<br>
&gt; &gt; by amdgpu_amdkfd_set_compute_idle before we interact with the HWS=
.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Either way, the patch is<br>
&gt; &gt;<br>
&gt; &gt; Acked-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [AMD Official Use Only]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [AMD Official Use Only]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; the issue is introduced in following patch, so add following=
<br>
&gt; &gt; &gt; information is better.<br>
&gt; &gt; &gt; /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/<=
br>
&gt; &gt; &gt; /<br>
&gt; &gt; &gt; /<br>
&gt; &gt; &gt; Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
&gt; &gt; &gt; /<br>
&gt; &gt; &gt; /<br>
&gt; &gt; &gt; Best Regards,<br>
&gt; &gt; &gt; Kevin<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; &gt; &gt; *From:* amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt=
; on behalf of<br>
&gt; &gt; &gt; Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt; &gt; *Sent:* Tuesday, January 25, 2022 6:03 PM<br>
&gt; &gt; &gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
&gt; &gt; &gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; =
Yin, Tianci<br>
&gt; &gt; &gt; (Rico) &lt;Tianci.Yin@amd.com&gt;; Chen, Guchun &lt;Guchun.C=
hen@amd.com&gt;<br>
&gt; &gt; &gt; *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod=
<br>
&gt; &gt; &gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [why]<br>
&gt; &gt; &gt; In rmmod procedure, kfd sends cp a dequeue request, but the<=
br>
&gt; &gt; &gt; request does not get response, then an error message &quot;c=
p<br>
&gt; &gt; &gt; queue pipe 4 queue 0 preemption failed&quot; printed.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [how]<br>
&gt; &gt; &gt; Performing kfd suspending after disabling gfxoff can fix it.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930<br>
&gt; &gt; &gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br=
>
&gt; &gt; &gt; &nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &gt; index b75d67f644e5..77e9837ba342 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &gt; @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_ear=
ly(struct<br>
&gt; &gt; &gt; amdgpu_device *adev)<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(=
adev, false);<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_set_pg_state(adev, AMD_PG_STATE_UNGATE);<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_set_cg_state(adev, AMD_CG_STATE_UNGATE);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(=
adev, false);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workarou=
d for ASICs need to disable SMC first */<br>
&gt; &gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devi=
ce_smu_fini_early(adev);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.25.1<br>
&gt; &gt; &gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5294035B7A2685C9A1EBBE1895229DM4PR12MB5294namp_--
