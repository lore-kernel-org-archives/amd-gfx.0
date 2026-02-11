Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0484EECD6D0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 17:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F75E10E633;
	Wed, 11 Feb 2026 17:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y3RG1g9R";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEF210E633
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 17:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1aw9WytULxFFPv+U2EolQ7tVDQqwUjVA/Br6RLZNwkr0SPWsD1udYXAh49JlQIs8k/Zh/C7qwyIBdQqBT/VHvjyXEVdZ60a/vbgXQQQ7hKN0T6OwDIIMoNmO9+dNqbDWukjZBx68dBeTvmBcDF6fP3TUERipWQXquTl1Q5Vb1CRAlFjurLEtMn7RWTQoWkJtodtHypUKjdbhyNMmxHEe/GPtVsTrrW4lafSM6T4xwHTzkO/Ix5LI9sOMFtu91/uij18Rh07LxwCtPz1s1r/YImrvHTXYEK2TFpSfDrWbRaBMbQpR4XbZvclaQWo7h1E1mut9vSOhrVXaSlVIOFKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io4EN67fcBFT6eSsu982Qa/zzhTNM9INiaIuPQoeyEs=;
 b=sMjy6SLScV3EqqUb17WzazsNmgRPWOIxfL8tC1yrcMRvoICgCL7o0Kh3bGwPjJzsiDeG6yYkX+qClYvibKjTOd3IcB7owSXgz5dslId6zKtPYrrYvARUJC0AEn96rMw+S8IF48NM5pffY+7neNcgCH/yZO1WAGRktfuzeWjER6J8jJ1fK/seNYODI5Dz/bkGIv87YqD0RWD0te0BATqtWlA3jLlCBJEXdodvLjyM1uJceyUPZK29AqASZJ0LLr1kH8ALWwyBrnaJKeQmngzyezGPynifyEf6QRK59/Mg4kkllKcpo62lw+rOdePl7EAtqnd5Ks1eTBdpbroLUmTuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io4EN67fcBFT6eSsu982Qa/zzhTNM9INiaIuPQoeyEs=;
 b=y3RG1g9RB7bNfgc9tI+U/1m2EVRV947OR9Tc2lXaT4wX7Vb4bNCaekgOEB+E4hNQ5JBR0/BgrCOYTKyzTol3VNAAxjUJ638faCdY9mX6eUgAvr0rFOwCLW1bTaSE85dkGf2tQhhAELVUYMU81rrYN0CA/tizWptDCJuqiufx69k=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 17:40:51 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 17:40:51 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Disable MQD queue priority
Thread-Topic: [PATCH] drm/amdkfd: Disable MQD queue priority
Thread-Index: AQHclDI/Ec1gLN4ni0uYbIQTGxZ1sbV90Muw
Date: Wed, 11 Feb 2026 17:40:51 +0000
Message-ID: <SJ0PR12MB8138CE26802219BE203965BFF563A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20260202105326.140826-1-andrew.martin@amd.com>
In-Reply-To: <20260202105326.140826-1-andrew.martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-11T17:33:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|PH0PR12MB7930:EE_
x-ms-office365-filtering-correlation-id: 9d716fe4-28ff-4589-f148-08de6994b355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dqqSfxHNzn30jAD8oUIPgLZVE+ikHtj08JT3pYu+D6l3AEyMT8EVqkt7Y6h1?=
 =?us-ascii?Q?qm7D/pRCrbWzwEtXBBgIh2ojp8xh938Clkms96ltPeSNznYSFmjF6z800CAq?=
 =?us-ascii?Q?wf5VWS9T/wIMjgMKycIaKbRg+kr7oFU9zAYnnsIydGovC/AMYDqJhw7kYkzP?=
 =?us-ascii?Q?WbA4L1//TaGG/HIe0AsIZX5LkfnsMOGKsxd+DIagM2iK5QLgbEQRSLKSaELM?=
 =?us-ascii?Q?pzQZ6TCMrqNpJ51TEyjKodG284wKvme7dG8LZsMTenqTOV6Tcwnf2AjegeLc?=
 =?us-ascii?Q?ppvtMqWKA94R7oEowfwqB8f2U/lZFDmO6KpLylw3se/rBejcEwlJn8pw/Ppy?=
 =?us-ascii?Q?lk2mnUaTcwGQlTlPIKEUuQlEzfksBs2b6iGmFyrAlOrEwKOZE5dJfeWKfGIc?=
 =?us-ascii?Q?o9vUMOFDZaxhTM9Zdoshb+AGfwnDQsa2boYQOY2ViNxPQT+SnARAMgthOnNr?=
 =?us-ascii?Q?4+ddIysgbdpMW2PLX9gbPBScwh2p3e4OHv1yUtlFZL1GsimCyQdVgFeGAOsk?=
 =?us-ascii?Q?NdfULIMKSzYaj8HWKpBtr4jeL6NVcriVNfz0PHwrDJ7BBk0m6/WnjlnTV/Q4?=
 =?us-ascii?Q?TTx8UbKApnF9xG8uVin3P87SQCdpeKOUQUU/MGff94dQqc7QZ5S9xbOjnKTp?=
 =?us-ascii?Q?TKMj3AV99asgW9Gm5i70/kTzhLYUPZLhfKXVfUxzW5SKpUJS2HtWYmOlJvsG?=
 =?us-ascii?Q?30PIyevagFogyoCNVYvbHEQkeQWZ9u+0oWahTEw6THLG2B+bNivln0Tb1W1G?=
 =?us-ascii?Q?KGUjN+1nO393ulGgidVboj8cyALGEZRe/Vp+E9mo+I3oZ3HNcjUih/Fb5BHw?=
 =?us-ascii?Q?QRH8sjTMBa4NG92wrFvl0iweDtu68cj1yUiaRThTJzdfod2n2VL/ZGX3jBZw?=
 =?us-ascii?Q?2EDGJqq+V8Kc9jBnZxmJESDlVO/AWY8X04Yr/1Vu1dSutnF24MBNvw5IlUFB?=
 =?us-ascii?Q?6LoFS67lAVYaeDXIoxwpxrHUmprNjHyc68B1/+h+6dYc6JMaFtY6YkofsTUI?=
 =?us-ascii?Q?P5u/mQ8IjMF6C0HSDfw0W2G17Qm9kk/LZjZY3tFAY01QxEJALUAhdQMuKIb4?=
 =?us-ascii?Q?cjmV/o3kBY/KAzHndqFclArD/WF0qL4TIqUchvz21P6HmYtuxRBfSygixtKX?=
 =?us-ascii?Q?PRvIuhT6S+GYnkYbv70wZmhAxVxxo5HY2ZentjAUsIdltJ4l0SrJzuhsZIZQ?=
 =?us-ascii?Q?+nbsOyP+mIWub2d5v9J29QPNcKibYCCE9JrLxB99sT7ug5XTFEeWZkSq1bWP?=
 =?us-ascii?Q?j6jcwm2HA/xe2rJRzqvKeGvUQuqTUuNIRuipOD2u0uH8axoT+6P2eVJKdUhY?=
 =?us-ascii?Q?7skLZZpM63YLiFbpFX/ZNWUS9Eb9+WYHs6wCuiGrssl8qMrhq7rNilpeg64N?=
 =?us-ascii?Q?9+Z28By3IFSj5CbR9vwe5JFt3EV6Lp+7Vqa5N6N35FJVDyZeOiljsY6if80T?=
 =?us-ascii?Q?oAbzemyEL/0vqfhQk/roS6zKZhZRLEbDoIT5ls+Am6q0y+RxdyPM+dMw1DI+?=
 =?us-ascii?Q?uVbVZT1bdDr2zP9iwphzt9UsmsN4DI8w19YI/Ngak7zOaXCSHkhubaI8mBFL?=
 =?us-ascii?Q?08Dn5GpphtRon/NbeEfnqw3wfHEX994OJXPTCPSw1ftsbc5Uo3SMWr4/P5zy?=
 =?us-ascii?Q?iKkr674JT3ej0937Y58dYOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g6VcHhct83QKgAjpGEgxB/U5WCgrtnO/vyKKb4PXMddpULLUOR3DCIbHCgiV?=
 =?us-ascii?Q?qD4dnG1O/EVAQPBu1DkaJfNDklVGS3DPIR/T3HPSkq/G7LkRIcgCKY7V4O86?=
 =?us-ascii?Q?oj7s0ndwpf2vW78jGKbtffz8pX/ijdygdtj6A6plfxdl0mVoZxLM9VOksNr+?=
 =?us-ascii?Q?/1H5dqH003NMuoNkoQ4DUHgJdE4aoK7RE/ogpqLvfaRALZ6uM/KyIvKsN6OO?=
 =?us-ascii?Q?oTHHl1oIHNLyWOvC1BylEsfa/re3JYKNKm1ZAA8zQP2AbIp6NvWtHMpFiU6G?=
 =?us-ascii?Q?95knVLNzmSbRfgQCnHSOz3rUBVwmnu0FEwASudveWW2fuxHDioLYpoCzxU1S?=
 =?us-ascii?Q?1t8+hqCaRqS+knSrVf6AjtKWvttB9QiUMmfaO5LPyn/W0n6IA4KCqCEEoPpU?=
 =?us-ascii?Q?OY4gejky7wUYZIETBJbQceKuIaE9wPoCT/FNsv8NOetG62sg+4l8FG/usoQi?=
 =?us-ascii?Q?8e+i9404QzX58gAKMYIgWTnhJWt4ete1fnO99kdRx1jspBWzkRuFSRi7yR9p?=
 =?us-ascii?Q?H6b+yZ+WJwSCdgOa7vz55O4HRXxZbPDisYn7RdJ4toWN0Nl2DkzmREFUKmSB?=
 =?us-ascii?Q?3duhCPsLYE9Huqd3X1URxUIrxZrfiVUqr1nbK5Om9OXBX/4KAqB09VGC7TIG?=
 =?us-ascii?Q?pW4ut51+ir2mS4t0oJNLXvXsNDlCdjNbN4X2SXhBuBE8rvsmdAiKwKdq06w4?=
 =?us-ascii?Q?Jw9LJBMC4wdDJtK10puHI0L2v0P7dlEY7mgSMoo3mzcwDr/HWJ9y+V7y+1Tp?=
 =?us-ascii?Q?KlxptE6w6Sfsy9ajg4dBUozqrSqFLs1JY9PiqR38wXjcYG+W1YjSYtwjDmg4?=
 =?us-ascii?Q?4vtkw2SWE9iviqGSNZ9sx5nC4ZeKq/u8k7TmQTHxgqSxuCg+5SrHsi/+83Ra?=
 =?us-ascii?Q?Ke/vLrI9oIlPpFCwc8kVgcIlXUR/Hs/M7nacI1fuEd2hNt3P5XcY0iihJTEe?=
 =?us-ascii?Q?SsSMeDmDsPyXgLPb9/4a/UZ8LsCymDfks9WCMfNTz2rPI0vnt3h5i9pDgZRv?=
 =?us-ascii?Q?fjWjW+se1z+uSpImE0glF6GGVb30Vna9iKtKq8mlZ3KVvq9CFSbkwgZ3IN1i?=
 =?us-ascii?Q?DVIl0svIzCTrfh7l2uqwEZkFD2YdUN8djkXaOw+AUuBO/Xej50zffR7Qr9Us?=
 =?us-ascii?Q?dux/fjQh1nD/3Ok2lNikpxead5A8u9i3oEzDDNefEKccsDFhjlSCCc2UYDC+?=
 =?us-ascii?Q?PHRmjzvOFMad8NUqfzbPFZzKzqX378RtP39L/cO9yp6ZD7G5ohfqFSzsNY2G?=
 =?us-ascii?Q?re2Md+ukhDntMa7hiY57RJx8lDVVd6yxY+14AJqGC+54yfb1T5I7nQBBtZMl?=
 =?us-ascii?Q?Mx2VtoMz7ig+yj9XpsXv8EfI+3I88JfKVjMp2JgtzKwrxlJhY7jJRzSlnrG/?=
 =?us-ascii?Q?S7STz8KfEIJlMIzXqlPkMkXxVJEmLjc0BXaqIbD0JVJpEtvdo8I+TajuRoce?=
 =?us-ascii?Q?mPdl3CW7xo+tkZGDl4pWh7wm0miz8CMlaxGcAd+5h5gVMq3aQd1UGCoppJi/?=
 =?us-ascii?Q?lF4NdvTVINDvUILvToThKCEQ99XZ90ZNwHFfd7ljIq1H9GfEJHClGG9mO0jt?=
 =?us-ascii?Q?Q0SBSzV+V+a72HHlIqkfDduaBSL4BWji6ONZ4CzWoKMEerjPXraHv8+X535z?=
 =?us-ascii?Q?lWWiXDXBHpZfiewnDglsBLGCeVemtm13t3UwwhpYofFTI1FKV6ARWCuKPvbm?=
 =?us-ascii?Q?xc7OZfKpHfEoqTskUHBCCKbcQbY7eG0bEqrP8tHrfLDznMNY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d716fe4-28ff-4589-f148-08de6994b355
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 17:40:51.8003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrNM4aOOHdJJ65jnWYNO5zR0ZsoLNSgcxtVPxBjI/reN5e4/opDfsPP4sXTQ5QNhzDjqzNlKEAq9nXoSa6X3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

Greetings @Kuehling, Felix, sending peace.

I want to draw your attention to this 1-line change, multiple customers wou=
ld love to have it in.  Lot of details are on SWDEV-548025.

One love!

> -----Original Message-----
> From: Martin, Andrew <Andrew.Martin@amd.com>
> Sent: Monday, February 2, 2026 5:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> Subject: [PATCH] drm/amdkfd: Disable MQD queue priority
>
> This solves a "priority inversion" issue, caused by the language runtime =
making
> high-priority queues wait for activity on lower-priority queues.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..bc4ceba35908 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -106,7 +106,7 @@ static void update_cu_mask(struct mqd_manager
> *mm, void *mqd,  static void set_priority(struct v9_mqd *m, struct
> queue_properties *q)  {
>       m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
> -     m->cp_hqd_queue_priority =3D q->priority;
> +     /* m->cp_hqd_queue_priority =3D q->priority; */
>  }
>
>  static bool mqd_on_vram(struct amdgpu_device *adev)
> --
> 2.43.0

