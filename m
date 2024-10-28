Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E304AD33990
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F1210E1F3;
	Mon, 28 Oct 2024 15:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQ2RRguw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB88710E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4JS15CZYibF2ndsFLzhHrlVyTGmk+JIjuhNMFV4D/ZOExsYmB7Thb4GqcrT6JD4NavGddANQPzsVSR0Xddk9zB+qwPs9c2/je28aM4KHrVAJrLjRdrE3iP1XABjkPK0E28gF1odgA2REYM83DERw/zpCi43/ZouWseLgm2GNfbFew1AiLPiqstyqcihaaQmR98tvGffE4Z1v46piX7oHAS0vJeBqNhfq/2OS8j79TULWlFjW3JWTzL7kTJiy0la1wejbPJ5F3m6YaUJnSUwlbTkkrNmqU1SCsTe4PfNbfGzGZt25qtIZFkdgl4IqBoil9FhNI4cPvmfYO1SC15vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6polejlAo//XV99ZEYEOY2sWF1jcOujsQR8xNxAGYYc=;
 b=JNeS/7ItD11K8xGny8QPISUovZADy39er9OtUXUPckSmFMGeB2TfHj2dWy8VRwv5TzX6d6cchTYQUruimfxg0+/3Ztzd5qMiZWamvFeFhztJGWrcseCSWne+ieazBSX9YSVS7MQGkGfb4WzudXwu/Yi1NTgC2Ca3vUk3TwwMvo9LqbpGOOp3K8XD06/JwXYRpEOR9ZaxhGMNsA5/ba2wzoXI+B6rwBEINNjFTzXVo+6XeD7PV65XhpdxXaWVtsoL47CWTq1wh4crHLsLud+gnQtWEOcQqmQ962Ncb6EXfAmKsSKqDHpSuytAlkyqO6bJ8R4f3KsSmCqICXem7uLDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6polejlAo//XV99ZEYEOY2sWF1jcOujsQR8xNxAGYYc=;
 b=DQ2RRguw2NHR24peCI5WoX1DAM9iVoAJjEJfN7IJ9u0ZVyUWGRVyMa8M+gJR1A05QtIYiPccbrInX2NVKIo/7j9e5O+1E1PQVkxd+05h17T5AxsmYDfXhcugaK8OcMpmGQheYVZYAuoUxFM54tUpj5Bmww3115tNVPxbZOi6S6Q=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 28 Oct
 2024 15:30:54 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 15:30:54 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v4] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Topic: [PATCH v4] drm/amdkfd: Use dynamic allocation for CU occupancy
 array in 'kfd_get_cu_occupancy()'
Thread-Index: AQHbJoe7vwNZo3FiN0Ws2Llzhu8+KrKcSnGAgAAFE9A=
Date: Mon, 28 Oct 2024 15:30:54 +0000
Message-ID: <BL3PR12MB64255123295AD6A96A2AFA46EE4A2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
 <20241025024328.3657725-1-srinivasan.shanmugam@amd.com>
 <ac3a4e54-3b67-4dd2-8f78-47cd663ed729@amd.com>
In-Reply-To: <ac3a4e54-3b67-4dd2-8f78-47cd663ed729@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8da7885d-6924-4d27-b424-55b6d80d540e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-28T15:30:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: 587d9034-aa26-4f45-d62f-08dcf765830e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEpRRzBkbFhNVzRsZzlNRzdmWTcwdEhqU3FmWFQwSFBWaEFCYy93ZHF6NndO?=
 =?utf-8?B?QkVvS1FON0JCNVEvczBSZ2prdzhMdHZ1TzIvVGNYUHZGc20zU3hGM2duMlBH?=
 =?utf-8?B?cENjNjlDUFpDcEcwb09tYW9rR1JaZUgwZGNEb0t4dmszbDkwNlk2dlF2RGVF?=
 =?utf-8?B?amNKbW5aWTBBSXV6ZVdsZW45S0FFYnBYbEprYjJJeDNSc2kvaktpcnhYZWNK?=
 =?utf-8?B?aGtLUmZ0enplWm9aVnUySXJmL0dkZGRha3RXU29USjhDKzloTFh5Q0l4SG90?=
 =?utf-8?B?U3ZJMEd5cHdERG81NGtGc2NSZkxHcHZqcUYrR1ArQ3lraXhkYmluekkvZ3Fh?=
 =?utf-8?B?c0xad244WVNIMTR1MXpVeDJyblF3UDltbW5GeXBxZjkvd1lDaG5zeW84ODFn?=
 =?utf-8?B?R1NzTk9tSzZRZ1AxRVQyUDVJZXlwT0haODlKejZlYlJjUURLdzA1Q1IxS3Vx?=
 =?utf-8?B?OHdVTHpVMUJqWlAzMFBmaGNhMWUwRGtDZStjVGNndHJpYXkrVFZ1SnY5cDBB?=
 =?utf-8?B?c1hHWVZ3SmR5N284RE0wR1drL2ZjVEtIaU9UWGFGTHA4R1BHSDI4TWF3YXM1?=
 =?utf-8?B?SmdZcGhkaE0vWnpJdmZBQVNSTUFiLytIV2RiR0ZDdkNxM3hUUktZeGlaRWdk?=
 =?utf-8?B?Q0NwRVVEaEVPZDBtbklmSEFId3FNd2FVMWNabENMU0pNNVFqWG5Ecno0UWNt?=
 =?utf-8?B?eDg1ZDBDZGN1LzFLZUM4R2pTNW9oTUhSejJLQjF6YmtvbkRzN2M1VnhGSDZ0?=
 =?utf-8?B?ZGdPeUdNWmY5UjFYc3hhZ1VZa2FFZ0lBRUNZeGVkWjg4V1lWUWd1YlN1blFB?=
 =?utf-8?B?bFdnZWIwcU5yZDZrNUF1Uk84NlVUNEt5M01DR3B3eVI5UFBkalZEMlo0RzN6?=
 =?utf-8?B?akt6dVA0OHZUZmlmNmNsL21VOFVEbkp3NWVBUHYraVdva0c4RlYxVUVZNDQ1?=
 =?utf-8?B?TTJhVi82UHl4K3VqeU5kQ3hMRU9CN0ZrQWlVUTRxVDZsRU5LMnFZSnhlT2ty?=
 =?utf-8?B?YU1TNFN5TmNhbXRYUlQrU3hNSzFKMzd4OURVenZuQTh6bDV0R25ka3NaNnM5?=
 =?utf-8?B?bkNEb1RnVkZMcmR1L0o1Q3p6RE9UcWpHVGNtenNVeXpLMmVNeXpaWFJvTkdk?=
 =?utf-8?B?NXZNTlFwUmFGblhENmZra1llOUwwdXVNVE5MVnZTZGVWWmRCbWl1d1l1bDNs?=
 =?utf-8?B?MTZtUWJlK2JoL2k2UmNSblVjclNOdTlXc3lDU000RTArVUc4aUhJUHhPNXJz?=
 =?utf-8?B?NzJQK0MveE9RQ3dpVytYS1JkY2JZVUV3czZHbTkzQmR0Zlo2RWRMbmhFdTVn?=
 =?utf-8?B?bXBQTUZobDZwaFJkYktKUDg0bUdIRTlwWkVYMU9TRExJc1dzS0pUQ2EvcVdX?=
 =?utf-8?B?MkxrUTQ1Vm1PS3BZQys4ZThOcmpxNm9pcWlEcHg1dXkwVFl3aDdGS0ZIRGRz?=
 =?utf-8?B?cUFaV1NrS2orUmZhMDNuUVNlK3lWZ0lJZHBRK05CVVlWZStlNDh1V2VxbzBu?=
 =?utf-8?B?cDdGcHpwUmt3WXpjU1NFQ1RUOG84YllVeGVUbnRlemZqZWQ5SEtoT3BqSUxm?=
 =?utf-8?B?Qm5ldmRNNHBsN21yRXhCU1RSSDQvTU5wV1B0YTVLL1F4VmYwVDUyM2RyajV1?=
 =?utf-8?B?ZWNuMFU2R1JDUGsxMm1oVjF4VCtHWHJzRlowRGdDS0UrODYwdi9abkZhSk1E?=
 =?utf-8?B?VzdmSkQ0RkJ1eDNGL09HcUE0RUNmMUVvZHNLNnJOUnRlRnViYVNIT2tPUDQx?=
 =?utf-8?B?aUVjalFKN3M0L3JmRm5NYVBWWDlLYitiMUVDOFNqdk5MbzRXSDJPbmhrZDdT?=
 =?utf-8?Q?CN3hMVzJ1rPdAWwQtn6ZXB1ne8sqrIcDshPJY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkR2Vi92U0l6OVI1bWhxVzh5WEo0SU9wTXpLQ0tyS2t4U0gzakI3RzZmVmhS?=
 =?utf-8?B?WnpCL3NzWll4R1RFM3VRZkhEcVNNNnRnWFJJVkhneEFNR25RdmM1WURmem41?=
 =?utf-8?B?UXNrNzBYWjd3V0VrQ0pCRjVXSUFqUXhYNHZObnEyYmZBUlR4bm9zSFdLWWFG?=
 =?utf-8?B?cURTeHNQT3MxYSthWVkwSGdOd0dwdzFvU2pDTEx6SmdkMitkQUtEVEFwRnBP?=
 =?utf-8?B?UXVMY3FPYmFXUFFZVmVmNlVzV0ZJeVZJb3pWeXYzTXFwVjhVQVFaZUFKb09s?=
 =?utf-8?B?TGE4cERLUGFHZVFnMlV1Y05TbGdtLytjdDN0Rld4RUhVRTdITDd4VktoZm0z?=
 =?utf-8?B?c3Z4UEx3dUR4V1FKVENZKzBCTHRqa1VaOG1EUmZ5ZzF5bUowZjMzdy92TGNq?=
 =?utf-8?B?YTBBcmQrcDN2YlZIT3BWOWJDY1hkbG50ZTNqekhTbmhPM1FhVE9aZVp4VzNF?=
 =?utf-8?B?U2JValhYbDNlR2M1Tm9CSld2U0xMOHpndHVHejg4ancwY3F3WmpKSnBrS0Qx?=
 =?utf-8?B?T3kxeHE1NVdhNVlrNkNBUnFEdXZ3SHNZRjJGMXorRFdOZjNBbUFMdXM5L1B0?=
 =?utf-8?B?dWU2clRMbk5Nd2RyeWhNL0VtRGNiaW9CMzlSeHpJTUxDSitScHZhOG5Mc0FR?=
 =?utf-8?B?M1ZoaGlhVXA2S3pGN1JjRUVBbWZFYzhqcmFSdzA2c2FWY1l0V09FQzhDdGt1?=
 =?utf-8?B?bEN5K2gvM3JNYXpOOVhkeWlVeVRVeVNBYmVJd21WamNrZldOeU55RkdPMUJG?=
 =?utf-8?B?cStGamY2YkNRdE9CV241eldHSGp4WDNaa1lZMjNtd0xNT1lOb2xiT3NsSFNj?=
 =?utf-8?B?aGhJQ29OT2Y2V0p0UGhHcWJXMTFsM0NPSDhqY2FEZ3ZZYUxPd0h6bFhaWVZq?=
 =?utf-8?B?R0dnYXpTei9pTFh2M3pzVzY4K2JxaDZobi93NDhNZ1ZoY2tmZ2phWCtNQUsv?=
 =?utf-8?B?NjVzdTVlVXlQQjV1bHlrR0QwSEdZWEgwYWN1VlVjdTRONjl2S2dtdmlBQW4r?=
 =?utf-8?B?cGJLUXJHNGJNWHRIY21mWjlUQmY1VVR3NnRNTUhNcXVrd1liQzd3ck5BV2c0?=
 =?utf-8?B?UjhGOEwybldvK0g0VGJZUFhhSk9aazBsYlJXa3JveHhWZkFRWEwyRlpYam43?=
 =?utf-8?B?RzJISXl3R3hyTXp2QXJoUFQ4QVpxVDhVUTNoa0djRXNOZ1RCandvZTRCdGMz?=
 =?utf-8?B?UWJkUnh3eFdrenpoejU4dzc5cXAvM045Q2RiL1Z5MnhENUNqUlU5bkFuVmxV?=
 =?utf-8?B?b2lGeG1QME5lNEFQNVVodG1tWGFoYjd5WHE2aUxUOS9ZOHRXYklCblMzOWJz?=
 =?utf-8?B?L3ZjYTV3d3d5RUdyNEV0aFhUcUxyMTJ6WlBiYVVnNlBGQ0lBbUI4VjludHFm?=
 =?utf-8?B?ejdkN0NqQVNmUTVvVXg5WWcrNlh2eUZLd0g2V0xJWHplKzdpWHNuV2UxWHBm?=
 =?utf-8?B?VlRoT1dteCtxdUZxQ0htbWpSVkh5aVN3TGFCY0REUk5nVmFFbVJyb2g4S212?=
 =?utf-8?B?eStsUGNLSElYMnZOaitRUEVuYStGbms5SlFjdzlxam1GYm1pOFB2bXZtOENs?=
 =?utf-8?B?bXBWd3c4QXVRbGw3c0FCQXIxMUs3eWo1dFVsNlJudnB2RWFJY2VIdHVjWUNs?=
 =?utf-8?B?czEzQ0dScEUrd3UrMHU5Tzc5b1lPWVpsQmRMcUlqVXkwdjB6ZExqSkZCWWRX?=
 =?utf-8?B?SnN3T3RPU0F1YVdiWU9JTkFzRXgzdmh1YmNFMzd3RHNMYUNId3lYR0I5WjJ3?=
 =?utf-8?B?QnplVjdXdFhmK1g1ZythcFNKR3oyeVdJT2JFNDZWUld6Y3FLMzRGdEk1ay91?=
 =?utf-8?B?ajRyaFUzczF0R0FGRjJVdGNBZHhhQzZ2V2R6NWpoRUQ5THdYYkk4cktKQ3Vl?=
 =?utf-8?B?TWlYZk9ZcmNNdkVIZ2U0b1RxWi9CaERKZ0NFci9Pc3JJUldlUE9GaE9PWTJ3?=
 =?utf-8?B?enByNWlTWndpdW5QWlF5Zk1XYU5zekVxT3czbEtoeE1oWjdLNndkTlpoajgr?=
 =?utf-8?B?UHVsNllWVDhLeUZkS1l2a3RBRHRGUEpBWGhsUjl0UGNkay9ONzUycm1HejEr?=
 =?utf-8?B?YjRZdElxSm1VdmRlaUc3Ykp6MVNSRG9CamJHRlNLTHF3SzNLQmZFa2xNejg4?=
 =?utf-8?Q?5gQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587d9034-aa26-4f45-d62f-08dcf765830e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:30:54.2024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2eIRZ7zaZaJSYSatkc3L/HGoxMHhTPosQKR2qhhn5TD0BM0u+LoBc1qwfuL+vljs7AfIK7WFyByubd13b62gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FO
IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIg
MjgsIDIwMjQgMTE6MTIgQU0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2gNCj4gPEhhcmlz
aC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gZHJtL2FtZGtmZDogVXNlIGR5
bmFtaWMgYWxsb2NhdGlvbiBmb3IgQ1Ugb2NjdXBhbmN5DQo+IGFycmF5IGluICdrZmRfZ2V0X2N1
X29jY3VwYW5jeSgpJw0KPg0KPiBQaW5nPw0KPg0KPiBPbiAxMC8yNS8yMDI0IDg6MTMgQU0sIFNy
aW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+IFRoZSBga2ZkX2dldF9jdV9vY2N1cGFuY3lg
IGZ1bmN0aW9uIHByZXZpb3VzbHkgZGVjbGFyZWQgYSBsYXJnZQ0KPiA+IGBjdV9vY2N1cGFuY3lg
IGFycmF5IGFzIGEgbG9jYWwgdmFyaWFibGUsIHdoaWNoIGNvdWxkIGxlYWQgdG8gc3RhY2sNCj4g
PiBvdmVyZmxvd3MgZHVlIHRvIGV4Y2Vzc2l2ZSBzdGFjayB1c2FnZS4gVGhpcyBjb21taXQgcmVw
bGFjZXMgdGhlDQo+ID4gc3RhdGljIGFycmF5IGFsbG9jYXRpb24gd2l0aCBkeW5hbWljIG1lbW9y
eSBhbGxvY2F0aW9uIHVzaW5nDQo+ID4gYGtjYWxsb2NgLCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSBz
dGFjayBzaXplLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgYXZvaWRzIHRoZSByaXNrIG9mIHN0YWNr
IG92ZXJmbG93cyBpbiBrZXJuZWwgc3BhY2UsICBpbg0KPiA+IHNjZW5hcmlvcyB3aGVyZSBgQU1E
R1BVX01BWF9RVUVVRVNgIGlzIGxhcmdlLiBUaGUgIGFsbG9jYXRlZCBtZW1vcnkgaXMNCj4gPiBm
cmVlZCB1c2luZyBga2ZyZWVgIGJlZm9yZSB0aGUgZnVuY3Rpb24gcmV0dXJucyAgdG8gcHJldmVu
dCBtZW1vcnkNCj4gPiBsZWFrcy4NCj4gPg0KPiA+IEZpeGVzIHRoZSBiZWxvdyB3aXRoIGdjYyBX
PTE6DQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9wcm9jZXNz
LmM6IEluIGZ1bmN0aW9uDQo+IOKAmGtmZF9nZXRfY3Vfb2NjdXBhbmN54oCZOg0KPiA+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfcHJvY2Vzcy5jOjMyMjoxOiB3YXJu
aW5nOiB0aGUgZnJhbWUNCj4gc2l6ZSBvZiAxMDU2IGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQg
Ynl0ZXMgWy1XZnJhbWUtbGFyZ2VyLXRoYW49XQ0KPiA+ICAgIDMyMiB8IH0NCj4gPiAgICAgICAg
fCBeDQo+ID4NCj4gPiBGaXhlczogNmZjOTEyNjZiNzk4ICgiZHJtL2FtZGtmZDogVXBkYXRlIGxv
Z2ljIGZvciBDVSBvY2N1cGFuY3kNCj4gPiBjYWxjdWxhdGlvbnMiKQ0KPiA+IENjOiBIYXJpc2gg
S2FzaXZpc3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+ID4gQ2M6
IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPiA+IENjOiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZh
c2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiBTdWdnZXN0
ZWQtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IHY0
Og0KPiA+ICAgLSBBbGxvY2F0aW9uIGlzIG1vdmVkIGp1c3QgYmVmb3JlIGl0J3MgbmVlZGVkIChN
dWt1bCkNCj4gPg0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Mu
YyB8IDkgKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gPiBpbmRleCBkNGFhODQzYWFjZmQuLjZiYWI2ZmM2YTM1ZCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IEBAIC0y
NzEsMTEgKzI3MSw5IEBAIHN0YXRpYyBpbnQga2ZkX2dldF9jdV9vY2N1cGFuY3koc3RydWN0IGF0
dHJpYnV0ZSAqYXR0ciwNCj4gY2hhciAqYnVmZmVyKQ0KPiA+ICAgICBzdHJ1Y3Qga2ZkX3Byb2Nl
c3MgKnByb2MgPSBOVUxMOw0KPiA+ICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQg
PSBOVUxMOw0KPiA+ICAgICBpbnQgaTsNCj4gPiAtICAgc3RydWN0IGtmZF9jdV9vY2N1cGFuY3kg
Y3Vfb2NjdXBhbmN5W0FNREdQVV9NQVhfUVVFVUVTXTsNCj4gPiArICAgc3RydWN0IGtmZF9jdV9v
Y2N1cGFuY3kgKmN1X29jY3VwYW5jeTsNCj4gPiAgICAgdTMyIHF1ZXVlX2Zvcm1hdDsNCj4gPg0K
PiA+IC0gICBtZW1zZXQoY3Vfb2NjdXBhbmN5LCAweDAsIHNpemVvZihjdV9vY2N1cGFuY3kpKTsN
Cj4gPiAtDQo+ID4gICAgIHBkZCA9IGNvbnRhaW5lcl9vZihhdHRyLCBzdHJ1Y3Qga2ZkX3Byb2Nl
c3NfZGV2aWNlLCBhdHRyX2N1X29jY3VwYW5jeSk7DQo+ID4gICAgIGRldiA9IHBkZC0+ZGV2Ow0K
PiA+ICAgICBpZiAoZGV2LT5rZmQya2dkLT5nZXRfY3Vfb2NjdXBhbmN5ID09IE5VTEwpIEBAIC0y
OTMsNiArMjkxLDEwIEBADQo+ID4gc3RhdGljIGludCBrZmRfZ2V0X2N1X29jY3VwYW5jeShzdHJ1
Y3QgYXR0cmlidXRlICphdHRyLCBjaGFyICpidWZmZXIpDQo+ID4gICAgIHdhdmVfY250ID0gMDsN
Cj4gPiAgICAgbWF4X3dhdmVzX3Blcl9jdSA9IDA7DQo+ID4NCj4gPiArICAgY3Vfb2NjdXBhbmN5
ID0ga2NhbGxvYyhBTURHUFVfTUFYX1FVRVVFUywNCj4gc2l6ZW9mKCpjdV9vY2N1cGFuY3kpLCBH
RlBfS0VSTkVMKTsNCj4gPiArICAgaWYgKCFjdV9vY2N1cGFuY3kpDQo+ID4gKyAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICAgICAvKg0KPiA+ICAgICAgKiBGb3IgR0ZYIDku
NC4zLCBmZXRjaCB0aGUgQ1Ugb2NjdXBhbmN5IGZyb20gdGhlIGZpcnN0IFhDQyBpbiB0aGUgcGFy
dGl0aW9uLg0KPiA+ICAgICAgKiBGb3IgQVFMIHF1ZXVlcywgYmVjYXVzZSBvZiBjb29wZXJhdGl2
ZSBkaXNwYXRjaCB3ZSBtdWx0aXBseSB0aGUNCj4gPiB3YXZlIGNvdW50IEBAIC0zMTgsNiArMzIw
LDcgQEAgc3RhdGljIGludCBrZmRfZ2V0X2N1X29jY3VwYW5jeShzdHJ1Y3QNCj4gPiBhdHRyaWJ1
dGUgKmF0dHIsIGNoYXIgKmJ1ZmZlcikNCj4gPg0KPiA+ICAgICAvKiBUcmFuc2xhdGUgd2F2ZSBj
b3VudCB0byBudW1iZXIgb2YgY29tcHV0ZSB1bml0cyAqLw0KPiA+ICAgICBjdV9jbnQgPSAod2F2
ZV9jbnQgKyAobWF4X3dhdmVzX3Blcl9jdSAtIDEpKSAvIG1heF93YXZlc19wZXJfY3U7DQo+ID4g
KyAgIGtmcmVlKGN1X29jY3VwYW5jeSk7DQo+ID4gICAgIHJldHVybiBzbnByaW50ZihidWZmZXIs
IFBBR0VfU0laRSwgIiVkXG4iLCBjdV9jbnQpOw0KPiA+ICAgfQ0KPiA+DQo=
