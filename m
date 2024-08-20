Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F5BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D078910E4C6;
	Tue, 20 Aug 2024 06:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bY4n28Bz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F6910E4C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJnCAZ2wUDr6jeJ8EWCepJt7TcpVPmHpKwTl98lcZyDV4exw1xI+bL++fQgDFqeAsvnSlAIz4syv+i2DL6vkUgTBCADf44h91aFrx2RgqRavU57Jv3gTI3shWB9dr6Dxjuwl9VrkCjIz5+QqhvIBZFwTk+N+WmJuTnVZA//LKry4+XpPiGtlpKHbM+yc/9oOP21MZSOs8YLGmmY2AWN5JWBQxIg7nS/YqZDa19qZdi5KiRNBXJSWqLwCYu9PYd/whxOpPk5EVufaYhti+LKkAkQeeoPA6sh4M3aSG6qXHUz9f8fE1SKVpto6nBtmBPXRUuoA4kVzVS+Oa+KKp+gFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2nKK8mTUhVRax8Qcxq1Wkgghjd7iqZqUc76B4FImso=;
 b=f1h3ECXN8umqhzsZWFsSgvOExpTgykIkrb19e4don58pC2ZRBT04j6BgGRJezbEwbDbjWMDWN1u7X6L4vXE3WL08wxWtjCou133hjhopKm4QW5zoHzzelsyMCuJXOOuA6soDgpN/+iUFvJZcLKckutcR5g2JQ8kg4TVeAiAEqdxv49P4DwcbLkYZUMgk3pRwGx8YUpIYjXdkBIExOycIouZ5OzK3uOFRiyfBXIb+Mud7/3ClrCU4GY54IZ71QZ1VZrYIWIREpYAPPA5kS0WRaiThkYe73l4Xv7ki5jOlFZNVV8bo3KvjY2W33gAO2hbUVrXt6sGLOQ8kiDqnoKYTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2nKK8mTUhVRax8Qcxq1Wkgghjd7iqZqUc76B4FImso=;
 b=bY4n28Bz+Z+vSw265PH179lIAWRzJ2/nyNECGcV5Os0VK2aTtzJ7yqnKLipw8Lek7wT9U+pIb66IlpBcGIoHe3CG4jhNfhHJ8gysg0xEP/jKzlTVXdfy2sve9shWGmVE/e7mIMAVkpJ4STYGaLYTGxd8PjHWW5HRCo/ANTqpyZ0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:11:30 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 06:11:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Fan, Shikang"
 <Shikang.Fan@amd.com>
Subject: RE: [PATCH v2 1/3] drm/amdkfd: Check int source id for utcl2 poison
 event
Thread-Topic: [PATCH v2 1/3] drm/amdkfd: Check int source id for utcl2 poison
 event
Thread-Index: AQHa8sb9ri2ZiKrx2k2/gf6cSGeoBrIvqckg
Date: Tue, 20 Aug 2024 06:11:29 +0000
Message-ID: <PH7PR12MB8796CABB16222969EAA799DCB08D2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240820060512.16061-1-Hawking.Zhang@amd.com>
 <20240820060512.16061-4-Hawking.Zhang@amd.com>
In-Reply-To: <20240820060512.16061-4-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=434b5f34-c119-4503-9e53-0932d01c1f22;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T06:10:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH8PR12MB6938:EE_
x-ms-office365-filtering-correlation-id: 3025a85c-e6a3-4732-11ef-08dcc0deee92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XmtXTW70+STUKtFBkjCxODg41vWxs0LFb1/aV7vEIaLbm0oS0lLZtA/2Py2T?=
 =?us-ascii?Q?uQPSgFXKb15i24Hg5QW0IdSHpatmxe0xsNoD6FYIG0lcHSYbUwTNz7Ex332X?=
 =?us-ascii?Q?5jsREiogBUurJh7feWlYz+xCoL8cJChq3PORiv3HAMFTH5lB/6H1DvSx383i?=
 =?us-ascii?Q?44cXs9HLyecMljWwMghTa9xfeWk5qQBp2XtK1vrfg1Sa8E/SukJe42xjMUC5?=
 =?us-ascii?Q?u/agsgrJHrgmQ/WAghKt/8lkqLw7ljDaFjwLqjgDeB7CIlP6JJ3tbk15zph6?=
 =?us-ascii?Q?4HUNsEnIOkvBMIFea07yCgb37XIWnimN+ImlF2APyQKq6ziUYGiS0vCuVFWD?=
 =?us-ascii?Q?GbxcBJoaaPJyVgBT5T/GhacWEk4HwAHa0cAQwuRQ7qB35H+5n6OGCs8zkmrE?=
 =?us-ascii?Q?Rtbit5yYFmbSvrJ+EC0oNZ5gi3vnYW1wsAkRjBSwQTYLCD0q7L7tvq1hhqR7?=
 =?us-ascii?Q?0dtM3O/WUhxLAIqtmaQ7NLaOfJ45nMZAlF7rCzAyeWCbsdXC00BwQQyHcw4n?=
 =?us-ascii?Q?Th9gM9myJjEKxdRKqmVyyssakZf+g61IuofDrgVePT7lSGjua9nfXeFwLPfN?=
 =?us-ascii?Q?188w/WJXjzmggPhEY/VlLXZ4g9rtQFA1NchkaSPE4soYy4wHcYFSHe5fhFVf?=
 =?us-ascii?Q?3aIfQDmrGx8Bxb/0gsmBLnoHD3t+KaM+iFAn2CxsdBTGNaXaRLbKIOP4Fn+u?=
 =?us-ascii?Q?7dSPagM4yCHulYEUkMTD0HduSNie0vVF1PSWc5+LC190g6jM78K2tbNaXWQM?=
 =?us-ascii?Q?Rnq3GuI57Qw5BVrstplS/ik+zWjzxhJye7zMIylfTRatmQYRCswjUrBqBb80?=
 =?us-ascii?Q?xsfTzQW4UqmjYm4I0je/DigBD32b4q79Htbx55wCx+cyvhIYziGaUaQ25wI5?=
 =?us-ascii?Q?1aeRhuZwCR58diCdBQD9fGfHCg5U1FB/vbuZCSpBLX5dlu472I+4Fb/3WRZ5?=
 =?us-ascii?Q?yMsVcUpMj9WLHMRfH8wjozsVBfmdDNr1nBnDuYPRelfL6iAWasB1ULSosw6O?=
 =?us-ascii?Q?6Pi3mg95XJzHwcw+LUl8o5UnxjT1B5gg8fkCP0z5ShqPAKbxKhJGMUfMI5h+?=
 =?us-ascii?Q?KcQZKY1jPvBmXXeIXiF72FULKAn/cn4ZHG/npT/T1KsqwzK+zrXk95Q7DOwa?=
 =?us-ascii?Q?c9xr/gNx53wC+7VpfR9f8bxJeqTq8S+kfAxpIxf6qoAauAymcbbmDlQGgxza?=
 =?us-ascii?Q?IiXenjvlk4ARclrq7bTj5RGAdVRGUNH+5ef5rXEbwOkNTSPkP3ruIOXLyN8a?=
 =?us-ascii?Q?gDfd+zrbfmlON1+yrZMYh9/aEDiFURpBSsZbWzirHxt19Vab0mAU9Dss1nur?=
 =?us-ascii?Q?hsCs33BgcdzJ8y0vLIPwMDoRnYIJk/hWlLldBFz8AGjgHtx+PHm7lC3xTLXU?=
 =?us-ascii?Q?9sxLRF9irfpuXaG/gk4Fj4S0LrT3Zqd3xMmcqSEEL9Zslwe/Tg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N1gTnu9otGX+4Yb1xk94XzxLJYeWr/nOgMCnVVH4qYpnIQXk8gB/eM/7gTXa?=
 =?us-ascii?Q?RfHpbsi59/Jsl5h/GcPSmGzHnoOcsHuaeOon0+hvlLuRQUzR6b9N/KELEhfO?=
 =?us-ascii?Q?J8KQMmH3jgcpAQUCJPTh49CKhSBduCHrNS4VqoWsUlftHCTV4emH5ZJ3/IGx?=
 =?us-ascii?Q?ay815S2P226OXcI32sE2QTKZ0961Hv08aYlZREDKvpz6yrNjtElQI4ZwUlOu?=
 =?us-ascii?Q?5NzkbIhDBasz6iHCHiUjlosi9Yt+8eHAPITDhmPb2RcW05dvhnJ+6ANlqmWB?=
 =?us-ascii?Q?zqGcdPSVPgjhfWGedwEvjPVgiNWBCHU+BkgzTh3JU5F0tREc98yjztzWsHu8?=
 =?us-ascii?Q?3Dn3+8OQzK+FvQ9X8Zi5t5bdI68z2h9ryzwfitHwwUpzkPcwjV7zkct6SGLz?=
 =?us-ascii?Q?DVjuZAAa832uz7GN1vjMsY8ZXwcVUcZIymT6qPwZ6Itoxy/yq1pDVjl2zcvr?=
 =?us-ascii?Q?iexPQy/cAIJZcELDcDlPzYC/JglbQpFCfkgEbVOsgPXsCEeZD2X3MU4j67e3?=
 =?us-ascii?Q?WnnfqEJpz05GhTRFQk5Bar+RBkdxt9PHgAaTwdTLHKadaB56T7WvNZn85n2f?=
 =?us-ascii?Q?zsI7m2J573PJrm6waOwYcK70cP13lZ0CYtnI/J6K7yGyxNN7La+kqd13z/Yt?=
 =?us-ascii?Q?xiuAKYrYWUt4KjiHOWDUVgpvj8rLsT0zVHLDsnzl6fftJ3tyRN7QS0D4MM1s?=
 =?us-ascii?Q?Z4SE7HtO8cbWMAxEIvJHhcBn2c4h30ZQ7sJtGAa4sa+IWSPR05CU2/xtz984?=
 =?us-ascii?Q?W27sbz4QQiv3FCRu2VJ7p0G8HM4O5+KF629BGrl6xraqkbTEkwjD+5DB7p3/?=
 =?us-ascii?Q?vYgCPwoP06HfnTB2wirQjV0l1QdtxbEf1rtv8R34BBwOd5A1lzsMjv+PHunP?=
 =?us-ascii?Q?ZpVcBmWKllM2BoQIajAw86SKQAQb87opymo8ZGrED0cvombuYIEmHYaENur2?=
 =?us-ascii?Q?TXe/Ap13WHE2NGHCeThISaj4+gyomvii6DzVVpsGEzUQ5oFlp1/Hj7ijq0BA?=
 =?us-ascii?Q?KygQi/ieeB8xjYdVXOxUTqJfrm11RVRS2MOnR7vGlxHLfvCltzZ79fComgk6?=
 =?us-ascii?Q?c83EnpYwxkArKvCw3IYLaNnXb3SHjGXbCkFK47syw3inAaCf4wNaJOC1ftvc?=
 =?us-ascii?Q?WJ41ygyj7yX/TbVj18fnH28UlhJqFSouYjG/pwfJcuHZiJ6sNNgyja0fwcS2?=
 =?us-ascii?Q?780twGalPK6sLdMkG6nF+VnXBVdlNSkHP8krjFfiXbB41nzVzlxKly0kOW+7?=
 =?us-ascii?Q?ezWuldp32JbUJntixclLzCejbE8g2N7gSdot7rQffo/nldIcHCaAlz9GBZwt?=
 =?us-ascii?Q?kkIrQTEj0D7G6cRN0tZT74tpuE3fLHWR71+kmFOTbekSnezgOn8vfW4ToLXs?=
 =?us-ascii?Q?OFd7REVXxgoXYkRDHynm5lX9FZyX3y29MCjpD2Ceo4pWWXrzZM5hBYFbFxJF?=
 =?us-ascii?Q?In2mL0DRsb52JiBASaW3tSUdV03qx9m/h/HfPjdQb+rOITPL8shibDPWuhEM?=
 =?us-ascii?Q?8Q051QG8gkR5JQmi7f26oTFhQRIrh9/VRz42toihSwnUb5O0e/TO58mC8PK5?=
 =?us-ascii?Q?1YiE+fAec42LwDwV9h0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3025a85c-e6a3-4732-11ef-08dcc0deee92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 06:11:29.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwbG3YEYMnsF/okWwOi67d3Kt8lX120thImXh2PRBaz/aLxPGg+DW3FTX0uDnsHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, August 20, 2024 2:05 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Fan, Shikang
> <Shikang.Fan@amd.com>
> Subject: [PATCH v2 1/3] drm/amdkfd: Check int source id for utcl2 poison =
event
>
> Traditional utcl2 fault_status polling does not work in SRIOV environment=
. The
> polling of fault status register from guest side will be dropped by hardw=
are.
>
> Driver should switch to check utcl2 interrupt source id to identify utcl2=
 poison
> event. It is set to 1 when poisoned data interrupts are signaled.
>
> v2: drop the unused local variable (Tao)
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c    | 18 +-----------------
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h         |  1 +
>  2 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index a9c3580be8c9..fecdbbab9894 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -431,25 +431,9 @@ static void event_interrupt_wq_v9(struct kfd_node
> *dev,
>                  client_id =3D=3D SOC15_IH_CLIENTID_UTCL2) {
>               struct kfd_vm_fault_info info =3D {0};
>               uint16_t ring_id =3D
> SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
> -             uint32_t node_id =3D
> SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
> -             uint32_t vmid_type =3D
> SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
> -             int hub_inst =3D 0;
>               struct kfd_hsa_memory_exception_data exception_data;
>
> -             /* gfxhub */
> -             if (!vmid_type && dev->adev->gfx.funcs-
> >ih_node_to_logical_xcc) {
> -                     hub_inst =3D dev->adev->gfx.funcs-
> >ih_node_to_logical_xcc(dev->adev,
> -                             node_id);
> -                     if (hub_inst < 0)
> -                             hub_inst =3D 0;
> -             }
> -
> -             /* mmhub */
> -             if (vmid_type && client_id =3D=3D SOC15_IH_CLIENTID_VMC)
> -                     hub_inst =3D node_id / 4;
> -
> -             if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
> -                                     hub_inst, vmid_type)) {
> +             if (source_id =3D=3D SOC15_INTSRC_VMC_UTCL2_POISON) {
>                       event_interrupt_poison_consumption_v9(dev, pasid,
> client_id);
>                       return;
>               }
> diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> index 10138676f27f..e5c0205f2618 100644
> --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> @@ -29,6 +29,7 @@
>  #define SOC15_INTSRC_CP_BAD_OPCODE   183
>  #define SOC15_INTSRC_SQ_INTERRUPT_MSG        239
>  #define SOC15_INTSRC_VMC_FAULT               0
> +#define SOC15_INTSRC_VMC_UTCL2_POISON        1
>  #define SOC15_INTSRC_SDMA_TRAP               224
>  #define SOC15_INTSRC_SDMA_ECC                220
>  #define SOC21_INTSRC_SDMA_TRAP               49
> --
> 2.17.1

