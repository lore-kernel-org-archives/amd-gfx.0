Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CC5C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 03:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F1610E3FA;
	Thu,  9 Jul 2026 03:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4hS/pjp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5055610E3FA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 03:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ/IKbFKtJiqS3E+q3xt3HbuqSP67N22MBRJ3M9lbM1FhhukOpZMTfT2vm0qY9fZ70axF8bQ6TCXVOdJzJAqmeJWla0p/knpqBh9YYfpODXPCWUtKVvZ53f3LVT+N5DvuvIKjR+erbZfcU5JIakpQrZIu2iCES6cyCZ4kExcs+ZfmoPMR4kXoYVlwMzAZyJD4kwDQ5YHu/0RAmvQF48lPaacJPaNaPAm6fX5qpH2DPAToMca/HptguKF6QE5z5RUE29ZmCosZKyh9+j+QWRAowUcXBSbt2CyWS4Ig2i8FnOvQ48VR6uuNgQA+tLAsRQ2hv0t0FLpD8ShfpZoRKH7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsTY9jQkTH6SJM5NeSQK3pD6nduH9WVUi4gJ5UHuYDI=;
 b=sZd+FVaJgIfvAYG1Iw46B+P6vs5VwgtSvE8qc70rW/hmx3HwIVZJv+lKxUEtQD09l8mrQCMbdbRCHQg16g1KTc0Xwpveao4JTXkKO+upp/i5JwgfJoPpyIA713bp+H8eXqEYVHiVs8C2WqCa4OMo9sIPEynWdtzceYuo9mJd8kBPH1l8zw56aM0qicsmp7KnyaY0jCztGyeeLel8RUr1VR1gJ8ISnEglp/99x3fwgy4IdrgVuEexdYuZOETJ6iRX2XloRRf5j8waQHohANwM0rHNws+lNsY3jdDNgJhKZOLDTrlaoK0kFKFZukzeeGazGRT+00tabglCM9YRZCubQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsTY9jQkTH6SJM5NeSQK3pD6nduH9WVUi4gJ5UHuYDI=;
 b=N4hS/pjpdIXP0WCNS8Kx/wMbc2Wlr1bFrTVfX+caEBnfIv8vFtGhn8oYa4f/RaMEJn4dnid3GeFAdmH9L/xEFML5p0GjX8UmLG07IzbJQjrmCdTkre5qyq3Fogrsu33fU/Rc52F3KiDKkkSkKEkuihsM7g1GpC7Dsmrmcsp9NAA=
Received: from PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:11:52 +0000
Received: from PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0]) by PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 03:11:52 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Use unbound workqueues for deferred
 DM work
Thread-Topic: [PATCH 2/2] drm/amd/display: Use unbound workqueues for deferred
 DM work
Thread-Index: AQHdB+eTgZnNljE7qkWwrLlpOv6sErZkNUeAgABbxiM=
Date: Thu, 9 Jul 2026 03:11:51 +0000
Message-ID: <PH7PR12MB5595140ED933655C4BD3A4AD88FE2@PH7PR12MB5595.namprd12.prod.outlook.com>
References: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
 <20260629165129.5550-2-geoffrey.mcrae@amd.com>
 <6f0517d1-df13-4a93-bdf7-9f91ccd24a01@amd.com>
In-Reply-To: <6f0517d1-df13-4a93-bdf7-9f91ccd24a01@amd.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T03:11:47.597Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5595:EE_|CH1PPF93AB4E694:EE_
x-ms-office365-filtering-correlation-id: 974be105-c8d6-4cbf-4709-08dedd67d2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: sBQ0TNn9I/uS4XC6iwU41U3ltN3ssvXqGCgNvRPzE8vcRmif1NosQLmQgtAb+PGHc898N7TCEIpMHBX/JTo09RDP+oazQ5yfyT1rRUG64INjCwk1NbuYE8l4h4FYBKTsyB9vyP3nE7zcAXumOSL0eMRsgEZELcbB1exmfveUEVDrMkzINVBKmgSeJCEYXZxwAeITxo0YViBYI4ufV0Nif69WBIW7ZIYosTror5SONRFPzdoUvXRgBWz9YuRTjNX8yrVuAIdg3aCNYJkaOFk3qXCEezD3Tq92prQjf22Sd2O8YKR+2Hi42MYX5sA3umvmIphMOVQbqJmvG4HU0nBYnOoDSLXy90TjBpz35v5lKxpuQmCtv7EYuTeRz4Mwi4SDuHVgIFD9zzGltEyKL7jbs409erfX7hv6AWd77rEkFOcDUceScaA2lzSzdeAuD9T/Nd9SqR/MbOvxeBRnchYmlyx+vAqCSM5qXeBaL+ntq/BIdeyEZ5YIx8pvoVs2KA7UYbUtCxq8zDFbrxTQaM1AcfipA2FUfGCyxvFhxbU092oyNPuRDaQ1NUfxiGfFqw9pWRLMFzeoFp94FMWuFFl7hvRV5CzvY6zuxw09ewSgHy+em2vmFoy35a+XW9nqLMDEdf6kjbahvABGWZnCKo5gwyzD9CSo+DFXOBxLtYLF7bz4YzzGUtEZMl/WIIc9a62aPdhwaiwSEYQjwYs0kbRBuMq7P8jOhIl3qpbVf5D5/rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gWKEmcCCwaWzZcMt2iPvvHz32tuccjiucoFweKrit2j1/nQX7Snf4bY/RW?=
 =?iso-8859-1?Q?ZXYyb78nmyScfUQakD6TdQbPL//rR72PrYzGEpIfCj2CaBHSpv3uZPEGjx?=
 =?iso-8859-1?Q?DrXzLVEVpNdtFEdTth/ptp308QsCaXrG9NA3HyT2e3+5NfIY33QKZY710N?=
 =?iso-8859-1?Q?9vNzHfupIXweV4uokQpD1OplPSKPKvdmHHIbNZvVo5A5ENADjgYfALq69+?=
 =?iso-8859-1?Q?koCTMjJ/vi99WDAWjuc4xwNP3eYF6YkJVFg3NLD4sty1DpKFeNOySCmeFS?=
 =?iso-8859-1?Q?O93vKNx3mr0eQYoDaXTfVmvZ8q23Vusq48rDz93FqWl5Pm5RWUXncO35O5?=
 =?iso-8859-1?Q?bfGKRNsEKZI2/8GREonti59yq7ckPmQUbGAK7o8Zk1v3JteC4VA1kj6Vws?=
 =?iso-8859-1?Q?a+R8x3Z4Z6iemkK+WHtwyafGzB0/+vJFDXxZGF8UVReEQV8D0WwbKkH21E?=
 =?iso-8859-1?Q?nVYPP5ooHevM+1NMEJRGLNQ1ljRmUAdtyLDeYsWL023r5USQRhsCULGzHe?=
 =?iso-8859-1?Q?4JKm3aWvGftNDzkOpdlM4UE5oBlYePRtcLZLjpy5LatrMjHLDFRCD3+0Iy?=
 =?iso-8859-1?Q?uzLGH5ckn3F0X22j5zY6uy+LLSWqwnw+ZR/TDszsrja1n/912Sgxj7CFps?=
 =?iso-8859-1?Q?9k7WPI9o/wZ5mqXDcJHuumb+aY679/zqOwkKrXIuMbZlEiT4eG5iM//Dlj?=
 =?iso-8859-1?Q?1oS3dOo28rchXCyOPRzRunwK+Hx+TjGMjsqc+SDvSfy+KdR2dIe8wjCphG?=
 =?iso-8859-1?Q?gYfK8Pgu+L2KShYNUvjgjX4ktCaIuGKEMJ6D4R+uKyPJi4V5dWiFb3nS1B?=
 =?iso-8859-1?Q?qa0/8uEerdkGrNdZdMmJpj7XOE1xN8mAAfTag8zDXjSG0kWIBynpy67mM1?=
 =?iso-8859-1?Q?tvWp+gA1xJFEk5iJUMVg7EUo7pHa5hyp8mTQU73TO/AkivqM6XfRWD2CaF?=
 =?iso-8859-1?Q?Tnoxk1U8BfdII2b9msAAorBpn9R+DOaMkhrnmR+jai2h3yLOE9HYbHUxry?=
 =?iso-8859-1?Q?uYCsRHuG4FtRk/ErmxLXmZvbkHn5sMShDNea7riRYWvoQuyyJ0HLcQnTx3?=
 =?iso-8859-1?Q?E0v0pALj/urkwMCVAXtM5BBKQ8A2KovhBCMGUL1Ps06DCZE+3lSzU9faLM?=
 =?iso-8859-1?Q?GcB0GaLumqEk4Zc/MR9oXeHLvsnBK8UF1mdFxZD/SGfERhO68Ad8jDwveo?=
 =?iso-8859-1?Q?NwSV5I+Hvf1t/w0yN55Hyi46LYBvXM/c8WwiyD9zPIe5KEcv9zQsAiAsys?=
 =?iso-8859-1?Q?MKcLGGdTo4r9f6PjEZNkgrK6WZmMuTdXDVNU5LDo2rIN2B5FeSSlUM32qS?=
 =?iso-8859-1?Q?osUqjnvY9K2UiTn2/3HLnnNC1ZJq8jzStmaBnO86BgOpD9zFMpNDu7/kD/?=
 =?iso-8859-1?Q?vXE2eER7kPnbcy+c52jAjiJRaYNdAXLZXwr1WGlHKDkeTxXhrDTxlfL1yW?=
 =?iso-8859-1?Q?v+WWlz4JwYAXMLi3OqiecYofgUFRbYj5YzOMxBRylF0eiNMAJFB6rnBNL0?=
 =?iso-8859-1?Q?WM7964UZAQGNEmxbTi2HiRyfqV8ClsI/uAyaETwXEESKsozK6JmcpFMMOM?=
 =?iso-8859-1?Q?5OgKP1iiK/KceoSXI89bhKJEvbvFLKpZhXTtCpL0bh68r5qiqhzcTOqzrt?=
 =?iso-8859-1?Q?xqNM9moEWFxHlI7aWO7oSUwNly/gwspk61vCV5x/cUP1gwtLyuONSk+sxL?=
 =?iso-8859-1?Q?qmEOHGXPDKiOaTr1KESPF4jzgQU6Ol87MzaxXpJ9VmRk5FTZXZO9BYQwyd?=
 =?iso-8859-1?Q?o+v1nvjqJs99QQEtqEHF/w9FDgOQZsHIS+5iPJlHXK0u9r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974be105-c8d6-4cbf-4709-08dedd67d2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 03:11:51.9971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gHn4sMo5XgsNMwQBXeFsAUsAiN+CO416HxApF03xmMICKz6hMi7kQRnHWqv5l09mvvxD3dnFegb/CrAD1T44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694
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

On 2026-07-09 7:41, Leo Li wrote:=0A=
>On 2026-06-29 12:51, Geoffrey McRae wrote:=0A=
>> DM currently queues some deferred display work on system workqueues.=0A=
>> Low-context IRQ handlers are queued on system_highpri_wq, while deferred=
=0A=
>> vmin/vmax updates are queued on system_percpu_wq.=0A=
>>=0A=
>> Both paths can execute long-running display work. HPD and HPD RX handlin=
g=0A=
>> may involve link detection, AUX transactions, connector state updates, a=
nd=0A=
>> hotplug notification. The vmin/vmax update path calls into DC under=0A=
>> dc_lock to adjust stream timing. These paths can therefore trigger the=
=0A=
>> workqueue CPU hog detector when run from per-CPU workers:=0A=
>>=0A=
>>   workqueue: dm_irq_work_func [amdgpu] hogged CPU for >10000us=0A=
>>   workqueue: dm_handle_vmin_vmax_update [amdgpu] hogged CPU for >10000us=
=0A=
>>=0A=
>> Move the deferred low-context IRQ work to a dedicated high-priority=0A=
>> unbound workqueue, preserving the priority of the previous=0A=
>> system_highpri_wq usage while avoiding long-running work on per-CPU=0A=
>> workers.=0A=
>>=0A=
>> Move deferred vmin/vmax updates to a separate normal-priority unbound=0A=
>> workqueue.=0A=
>>=0A=
>> High-context IRQ handlers remain unchanged and continue to run directly=
=0A=
>> from the IRQ path.=0A=
>>=0A=
>> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
>> Cc: Harry Wentland <harry.wentland@amd.com>=0A=
>> Cc: Leo Li <sunpeng.li@amd.com>=0A=
>> Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
>> Cc: Christian K=F6nig <christian.koenig@amd.com>=0A=
>> ---=0A=
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +++=0A=
>>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 34 +++++++++++++++++--=
=0A=
>>  2 files changed, 35 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers=
/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> index 88687a7e01a5..4a7965f76acb 100644=0A=
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h=0A=
>> @@ -324,6 +324,8 @@ struct hpd_rx_irq_offload_work {=0A=
>>   * @ddev: DRM base driver structure=0A=
>>   * @display_indexes_num: Max number of display streams supported=0A=
>>   * @irq_handler_list_table_lock: Synchronizes access to IRQ tables=0A=
>> + * @irq_wq: Dedicated high-priority unbound workqueue for deferred IRQ =
work=0A=
>> + * @vmin_vmax_wq: Dedicated unbound workqueue for deferred vmin/vmax up=
dates=0A=
>>   * @backlight_dev: Backlight control device=0A=
>>   * @backlight_link: Link on which to control backlight=0A=
>>   * @backlight_caps: Capabilities of the backlight device=0A=
>> @@ -565,6 +567,8 @@ struct amdgpu_display_manager {=0A=
>>        dmub_outbox_params[1];=0A=
>> =0A=
>>        spinlock_t irq_handler_list_table_lock;=0A=
>> +     struct workqueue_struct *irq_wq;=0A=
>> +     struct workqueue_struct *vmin_vmax_wq;=0A=
>> =0A=
>>        struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];=0A=
>> =0A=
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> index 3a5de9364ed1..f4bfd7e42f9a 100644=0A=
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c=0A=
>> @@ -397,6 +397,21 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)=
=0A=
>> =0A=
>>        spin_lock_init(&adev->dm.irq_handler_list_table_lock);=0A=
>> =0A=
>> +     adev->dm.irq_wq =3D alloc_workqueue("amdgpu_dm_irq",=0A=
>> +             WQ_UNBOUND | WQ_HIGHPRI, 0);=0A=
>> +=0A=
>> +     if (!adev->dm.irq_wq)=0A=
>> +             return -ENOMEM;=0A=
>> +=0A=
>> +     adev->dm.vmin_vmax_wq =3D alloc_workqueue("amdgpu_dm_vmin_vmax",=
=0A=
>> +             WQ_UNBOUND, 0);=0A=
>> +=0A=
>> +     if (!adev->dm.vmin_vmax_wq) {=0A=
>> +             destroy_workqueue(adev->dm.irq_wq);=0A=
>> +             adev->dm.irq_wq =3D NULL;=0A=
>> +             return -ENOMEM;=0A=
>> +     }=0A=
>> +=0A=
>>        for (src =3D 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {=0A=
>>                /* low context handler list init */=0A=
>>                lh =3D &adev->dm.irq_handler_list_low_tab[src];=0A=
>> @@ -491,6 +506,16 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)=
=0A=
>>                list_del(&handler->list);=0A=
>>                kfree(handler);=0A=
>>        }=0A=
>> +=0A=
>> +     if (adev->dm.vmin_vmax_wq) {=0A=
>> +             destroy_workqueue(adev->dm.vmin_vmax_wq);=0A=
>> +             adev->dm.vmin_vmax_wq =3D NULL;=0A=
>> +     }=0A=
>> +=0A=
>> +     if (adev->dm.irq_wq) {=0A=
>> +             destroy_workqueue(adev->dm.irq_wq);=0A=
>> +             adev->dm.irq_wq =3D NULL;=0A=
>> +     }=0A=
>>  }=0A=
>>  EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);=0A=
>> =0A=
>> @@ -610,11 +635,14 @@ static void amdgpu_dm_irq_schedule_work(struct amd=
gpu_device *adev,=0A=
>>        if (READ_ONCE(adev->dm.irq_fini_in_progress))=0A=
>>                goto out_unlock;=0A=
>> =0A=
>> +     if (!adev->dm.irq_wq)=0A=
>> +             goto out_unlock;=0A=
>> +=0A=
>=0A=
>Do we need this check if amdgpu_dm_irq_init() bails when dm.irq_wq fails t=
o init? No=0A=
>handlers should be registered in that case.=0A=
=0A=
Agreed, this check is not needed at all and will be removed in the first pa=
tch also.=0A=
=0A=
>=0A=
>Patch 2/2 LGTM otherwise.=0A=
>=0A=
>- Leo=0A=
>=0A=
>>        if (list_empty(handler_list))=0A=
>>                goto out_unlock;=0A=
>> =0A=
>>        list_for_each_entry(handler_data, handler_list, list) {=0A=
>> -             if (queue_work(system_highpri_wq, &handler_data->work)) {=
=0A=
>> +             if (queue_work(adev->dm.irq_wq, &handler_data->work)) {=0A=
>>                        work_queued =3D true;=0A=
>>                        break;=0A=
>>                }=0A=
>> @@ -642,7 +670,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgp=
u_device *adev,=0A=
>> =0A=
>>                INIT_WORK(&handler_data_add->work, dm_irq_work_func);=0A=
>> =0A=
>> -             if (queue_work(system_highpri_wq, &handler_data_add->work)=
)=0A=
>> +             if (queue_work(adev->dm.irq_wq, &handler_data_add->work))=
=0A=
>>                        DRM_DEBUG("Queued work for handling interrupt fro=
m "=0A=
>>                                  "display for IRQ source %d\n",=0A=
>>                                  irq_source);=0A=
>> @@ -1905,7 +1933,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_de=
vice *adev,=0A=
>>        offload_work->stream =3D stream;=0A=
>>        offload_work->adjust =3D adjust_copy;=0A=
>> =0A=
>> -     queue_work(system_percpu_wq, &offload_work->work);=0A=
>> +     queue_work(adev->dm.vmin_vmax_wq, &offload_work->work);=0A=
>>  }=0A=
>> =0A=
>>  static void dm_vupdate_high_irq(void *interrupt_params)=
