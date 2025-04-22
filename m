Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCF9C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 10:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E36589266;
	Tue, 22 Apr 2025 10:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fXlVfuUL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DA189266
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 10:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgv/+UCTDb3cPkKRohpcANVJjO7iStPxwW6zqFZ9N+QaRqqw4BGLq8BxCIbPy8eT7GD+52ZCdqDdlcrJVkf8K4fNo8Es190Kmk2Ip6TRKobjwRNk2UrkVnywdXObp/A82Jnwd/v4Q4RVPA4OD/iiYKBBsjj82sCUBnK/GwCmdafDY5G0BleJ222+iDZK74I450YjeJjv4qEcWYAq7HdIM8XtWyn5dU6nbRxtpbvjraONx+4VcyJ0AJxN1sC2xjpLLG1CcHmb9+3DfXfkNX/5B5j+/kqYI8m09vYBsSGREp89zSJYr29OsOcItXCU0t3n0EW2AFNfyXM0opi2TQzy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PDPtj4vHgmBxYrfu7A2mZAPG/HqNU9QIAS/nk+ESmA=;
 b=xI+Z0xpIgk++PDNI2DevIG2Bk+p0Z2k1HYqMLG9jZB1zOlnrI3jkid0BJDjbkAEZUOHOxLwi78F+zHDUoGCAG4p6+MfpmdOLRA/1/WfUgBMda/oeLmM9DIS1+QsWQO+AF8DE6Y3BPff4kS/3IkVw/qy/XQX2U46k4jaZAWZe2NEmQ2Ow8SdtEh+VYGYkStL6bjIqOnQxXsj1lGJoypt5bU1zs+Tb/NRhIRghrQjGpA+0OpiTIFQio70ArxGgBwGACjYuG0XLbaDUBkwsl1uWpkK1kRWewjigU3kB/W8tAj6jXJOl0QfjMg8EacPjOY9P0+VUSVYEmxcFRXP/TBg/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PDPtj4vHgmBxYrfu7A2mZAPG/HqNU9QIAS/nk+ESmA=;
 b=fXlVfuULptWlHVoykhHC/Nzu1bzEqF9rLurKOS9wxO0icYyzdJxUqzhRPMP7UfWowkM/IgprP3UH9A0CGcudXtuDcpR5+1X6NSL80WDRT5x1ECSupRTEXjraBnK6jBtTSsF62l8MN+Mm4/XMD770lo05djCjk1z3GsO80yv5U/E=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Tue, 22 Apr 2025 10:38:36 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 10:38:36 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbrSrMwUAwzOUgZU6XmBWROciIM7OmUzmAgAKBUfeABrS9yQ==
Date: Tue, 22 Apr 2025 10:38:33 +0000
Message-ID: <DM4PR12MB593795CA6451D087678119E3E5BB2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
 <DM4PR12MB59373376DA78522AAED69B83E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB59373376DA78522AAED69B83E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T04:07:44.6450634Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|DS7PR12MB9550:EE_
x-ms-office365-filtering-correlation-id: 33a595fa-8b6c-4d97-17fc-08dd8189d669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?vFIv/neLCsdWHCuxdlXo1qdRIadvsNEF0quQJ8JKmeX/S9ISV9dJw84k?=
 =?Windows-1252?Q?DYF5r49jxsAwsvr7g/eHdw64iyXkf+HcVYA4K7IiYb3SQlgqPJaFTUDT?=
 =?Windows-1252?Q?PicCxzV5nX2U9KCj87IJpQd1eREUypW2XaXpSU7qhNzJRMf58s/i/A8F?=
 =?Windows-1252?Q?GjpSsvf90GijGADqaKGOoast9rbC88X7x0KAKvrx5K1KjUtvsJHN3iXZ?=
 =?Windows-1252?Q?t82b5UrwEXPQKPYDd2Smkvv1F4BahKyfe2dRhkCfNjdgqqJprXcD5UXq?=
 =?Windows-1252?Q?pRqqb/V/bLRx3IWd8wJ6dX5Gs+PWtpdBAb6lx8YnwUSxdGKffhkA+PQk?=
 =?Windows-1252?Q?MK9JSPazKZhBKiSLMGqEw4HJkzzQd3q3s1V4xvhoSE8e2rVVDMxuI8Rt?=
 =?Windows-1252?Q?YHqc8MW3GwYxvVFhGjp+YIDllLDZVgk5Bu4/ntFBak56tOd8YrSobBnW?=
 =?Windows-1252?Q?caO0dB+7AT9bnY3uU1lX9OJRAOuv7NOztsIP0Ft0Su734iATx7WDoRGJ?=
 =?Windows-1252?Q?674t8JWgHkFGBSDbv+Bnr7RmW7bc1HdfWdzdV9OfdunZEWTcdFgTEv2R?=
 =?Windows-1252?Q?E+PP9pTbsT63RajGtB4zoBXtds99YsjqTfSuDMHc8F8++6nQpz2oEf4n?=
 =?Windows-1252?Q?NnARkkZZKBEcjVDwVP0FMIH/txeaVEJsgnA13rGXB+VAYTbq0CyNwLHE?=
 =?Windows-1252?Q?5I25iK/bFMEWrZzCs4oH3pgVwfrkgVC5HAXbF2mXJVFzYsXW8dZPlI7T?=
 =?Windows-1252?Q?Q0L4f3uZFnLEqQ/4l5MqORzXy5ly13IDuP1cSmp5VBLLlB2vyaXdEns4?=
 =?Windows-1252?Q?Q5rGdrxOl7kPnRk049yGbn7aX/yH/zCHLTRzaGPW+FfmdwMPo4R6YnG4?=
 =?Windows-1252?Q?CNyYeFPDUhtdETDzySE58zWsj+LVA/S6W2iA2wPzcaOOZ135bviciuy+?=
 =?Windows-1252?Q?T6RRkYpEoe9j7mC53MN6oHNo+7rE2+cqnXnVlA90k0SmDb6nzrrLPjh+?=
 =?Windows-1252?Q?p62dqO/JlTLJbFRKjyBafCIepLTl1QWI1XDHzJE8kfYVFCCHMI1WjEvv?=
 =?Windows-1252?Q?KZAOqrG6zsvXccy1ZZPbcDLO0k4jvPktExbTswGQ1vzxIkO2viZWK8fp?=
 =?Windows-1252?Q?IDj2lrIqsI0EgGz7O8d1LekLKR08fPKdNlkY7ZFOlQa4sZukbAiant3N?=
 =?Windows-1252?Q?KyYqN75Oo6LClhw9wauOhaeWk5lVbGr3CVr1eOrVLQQyp1P2KUmRa2La?=
 =?Windows-1252?Q?XmnZKatHc7+XFm32/PPUCV+yxfRo+1hKD42wB29AysCAlbNSLL2e+CIP?=
 =?Windows-1252?Q?CX0Nz3TGVmgWFwI6aJbkBhb9+O9FJl8VZ8oI5XrzQyww4ckNwgIkzr9m?=
 =?Windows-1252?Q?PNwKcyXPcTobC/CRXO7SrvP5psjP9ds+cD3rjVliYG5KMfT3tuZFBeOA?=
 =?Windows-1252?Q?DBj7keTvtcXb0K9AjhW8mYVKe+hpOil5f+ktGj7GX/tanMSP3At2ufv1?=
 =?Windows-1252?Q?CblDfiAZe2ZiCNAwbP5fLIbbaS23q8oYOUcjR9747uZcsojyzx2V51AL?=
 =?Windows-1252?Q?h5SJIlbMbfbej3MtnE/Qmdz6CDILdWLy4qFzINSqmPG49CUArRUfkUud?=
 =?Windows-1252?Q?ZWk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?aAMR4s8mvLTiTQ+0FwM6TWYeijL9F+scKeIwPjx391ncxooVaqN+xGCF?=
 =?Windows-1252?Q?5hzn5zrfhu2ZBIMC79fGixBGj/LjtfuTn1qpYdibw3xuM5RRTjDJvFDo?=
 =?Windows-1252?Q?aocFlOxbOkbaL4I8l2umq0DZLofP19fJnWx5prH+4rxDzkA1lB5IcGWP?=
 =?Windows-1252?Q?p24nH3X54QFVgVDg/XW5D9TpMHVFEY+Fu7wQZdY7Q2d9yT+BA4/RcGDq?=
 =?Windows-1252?Q?4oqw3bZoQZeT0omV/cVlIKXf9RtqVhEcEJxBZuYSg8mYPOQa25gG2WEc?=
 =?Windows-1252?Q?pvBqHDZScyhFDSdLTdmyzQI7F+TpBABlZ7Gm+HKyVFHNn486RFrROozs?=
 =?Windows-1252?Q?r44pAMmoKem1eeOEWl/F7fSV2uiID+qZc0J0RYHzISLua1odE2HpskLB?=
 =?Windows-1252?Q?Nzbz20jOhMeEWYhAcY8LXzmiAsHExCINTIvcsX8iZM0xsn/KoXUmgZVe?=
 =?Windows-1252?Q?TJRzn3smcJi//LrwBKYevFiL/fBcQ0bp/+xa8I+cPy2JVzpVvgcTPwrY?=
 =?Windows-1252?Q?qlxEWKQ3Y3/v81AGj5lDR02VgYSCUW78erzhQB2ohJKvn6SfyaLm6E/2?=
 =?Windows-1252?Q?eAy0ZZz2en//sq9xVnQefoa2ZQ9ouZSxw/SbWzVTQkVcgn7MXRaolocW?=
 =?Windows-1252?Q?6Tng36CAlQHmQlmsy1h9xSX3ELcOlJdvw3DilzwmhdhVeONZ2eEhZDQW?=
 =?Windows-1252?Q?RFJ4WjuCm2GGsgyYf97TdXNv4YvLrRHtJTykplk9TzznNgxitQ5Dfboa?=
 =?Windows-1252?Q?xtTEG1lvdEc7BMMAORFdWxVVfCm9KtnNf2f/nMDg9Zj59JmkZcb2X7iv?=
 =?Windows-1252?Q?WZJTLM0mY1iIsGP3ykhXCXWrr0MMi+SPpYX54h65/0cQ6M7JgJWpapQn?=
 =?Windows-1252?Q?s1XGVIrPgjxxQvwEkX2WOXvexBO/4VEZ+gc999YoXV/yUomkS7TWI6b5?=
 =?Windows-1252?Q?2rFzr3X5wdwI/WR0RUxeIleRSDFqye/M7r3yA6+XMzuyx9nZiaGKcZVf?=
 =?Windows-1252?Q?Ty1JwDxPvCJUxgtQDfNXzvrUOdUpkmjMLgym46Jri8Bp8l5SrjWbBDX4?=
 =?Windows-1252?Q?X2SKR6wWZb1U1+MKPbBiR69MU8QdoWM/T4gq0Tk4qBVrcIAcMiWKcZ/e?=
 =?Windows-1252?Q?RCIlhW8olMBMTBEMIxTQ0p9RBqfuCKn21lwnmB6bGzRLSO6WW5iUUxxj?=
 =?Windows-1252?Q?wiKShs/jXfzYSxqp7W5PsUmfEoRYzC4xUyOMJL9zjSNZxJ/09C/KqkfP?=
 =?Windows-1252?Q?23DKPHJdgkVixfJgYxIf6LPOP/addB+tqVAtQc2eG5lLZy0eLoFQflOc?=
 =?Windows-1252?Q?292Vi620hbLk8VfhdN+bhgGsyhQdy1Ph8oosh+3nn7S+gg86B4TfpeyY?=
 =?Windows-1252?Q?AOlJAlkM/tS9DebzophhHx/CDG/akrbiOSlEaU8VlpnxCs8gwHpkFdRb?=
 =?Windows-1252?Q?fmxRi5i6VDahiVBxhLywwcYfO6PIjJ/gRqybJFnnm62GDV5gAcr9zElh?=
 =?Windows-1252?Q?MyfZ8a2qb+Z8n9reQGKrvvVOpM18skUNC+AyoH0kOK8Bd942y1W2zzUS?=
 =?Windows-1252?Q?K8jVcUHRdZtWc2Q2sl5oakEwaMJIUXKtzosZg7gamYMRxD33r28TjSeE?=
 =?Windows-1252?Q?Q47tKnjkkXtNXe5unpfzAlJLKurJFr/8MNaK0tmIuIkXplX+FGYlH3T3?=
 =?Windows-1252?Q?GEvLXQqbpVunjgD2rMEHduH2peT5O8RX?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB593795CA6451D087678119E3E5BB2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a595fa-8b6c-4d97-17fc-08dd8189d669
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 10:38:36.4068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjhpp2RXmTfDwmdiq4TYJgdqdrCegeuMv97kql67fWSVVsuMaiEu9GP5svmEqrkt25k4QC5G50pI+G4piZiVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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

--_000_DM4PR12MB593795CA6451D087678119E3E5BB2DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping=85

Thanks
Sam

From: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
Date: Friday, April 18, 2025 at 14:26
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thank you for the review and the feedback.

>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_object.c
>> index d90e9daf5a50..83a3444c69d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device =
*adev,
>>                goto error_unpin;
>>        }
>>
>> -     if (gpu_addr)
>> +     if (gpu_addr) {
>>                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
>> +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_p=
db0) {
>> +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_P=
L_VRAM) {
>> +                             *gpu_addr -=3D amdgpu_ttm_domain_start(ade=
v, TTM_PL_VRAM);
>> +                     }
>> +             }
>> +     }
>
>Please NAK to that approach here. The GPU offset should still point into t=
he mapped VRAM.

This change is to change to the default GPU address from FB aperture type t=
o pdb0 type in this centralized place so that I don=92t need to change ever=
y callsite of amdgpu_bo_create_reserved().
Could you suggest a better approach if this approach is not acceptable?

Thanks
Sam

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Date: Wednesday, April 16, 2025 at 21:52
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
>
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
>  6 files changed, 82 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5b60d714e089..e706afcb7e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc,
>  void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu=
_gmc *mc)
>  {
>        u64 hive_vram_start =3D 0;
> -     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_phy=
sical_nodes - 1;
> -     mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical_n=
ode_id;
> -     mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
> +     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_phy=
sical_nodes;
> +
> +     hive_vram_end =3D ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_page_=
table_block_size)<<21) - 1;
> +
> +     if (!mc->vram_start) {
> +             mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.ph=
ysical_node_id;
> +             mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_siz=
e - 1;
> +             dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%ll=
uM used)\n",
> +                     mc->mc_vram_size >> 20, mc->vram_start,
> +                     mc->vram_end, mc->real_vram_size >> 20);
> +     }
> +
>        mc->gart_start =3D hive_vram_end + 1;
>        mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
>        mc->fb_start =3D hive_vram_start;
>        mc->fb_end =3D hive_vram_end;
> -     dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)=
\n",
> -                     mc->mc_vram_size >> 20, mc->vram_start,
> -                     mc->vram_end, mc->real_vram_size >> 20);
> -     dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> -                     mc->gart_size >> 20, mc->gart_start, mc->gart_end);
> +
> +     dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016ll=
X - 0x%016llX\n",
> +                     mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc->=
gart_start, mc->gart_end);
>  }
>
>  /**
> @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *a=
dev, uint32_t vmid,
>                                     &job);
>        if (r)
>                goto error_alloc;
> -
> -     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> +                                                     adev->gmc.pdb0_bo :
> +                                                     adev->gart.bo);
>        job->vm_needs_flush =3D true;
>        job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
>        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *ade=
v)
>         */
>        u64 vram_size =3D adev->gmc.xgmi.node_segment_size * adev->gmc.xgm=
i.num_physical_nodes;
>        u64 pde0_page_size =3D (1ULL<<adev->gmc.vmid0_page_table_block_siz=
e)<<21;
> -     u64 vram_addr =3D adev->vm_manager.vram_base_offset -
> +     u64 vram_addr_first =3D adev->vm_manager.vram_base_offset -
>                adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segm=
ent_size;
> +     u64 vram_addr =3D adev->vm_manager.vram_base_offset;
>        u64 vram_end =3D vram_addr + vram_size;
>        u64 gart_ptb_gpu_pa =3D amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>        int idx;
> @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
>        flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size =
+ 9*1));
>        flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
>
> +     if (adev->gmc.xgmi.connected_to_cpu) {
> +             vram_addr =3D vram_addr_first;
> +             vram_end =3D vram_addr + vram_size;
> +     }
> +
>        /* The first n PDE0 entries are used as PTE,
>         * pointing to vram
>         */
> -     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_s=
ize)
> -             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_ad=
dr, flags);
> +     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_s=
ize) {
> +             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
> +                     (vram_addr >=3D vram_addr_first + vram_size) ? (vra=
m_addr - vram_size) : vram_addr,
> +                     flags);
> +     }
>
>        /* The n+1'th PDE0 entry points to a huge
>         * PTB who has more than 512 entries each
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..758b47240c6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>        struct amdgpu_bo                *pdb0_bo;
>        /* CPU kmapped address of pdb0*/
>        void                            *ptr_pdb0;
> +     bool enable_pdb0;
>
>        /* MALL size */
>        u64 mall_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index d90e9daf5a50..83a3444c69d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *=
adev,
>                goto error_unpin;
>        }
>
> -     if (gpu_addr)
> +     if (gpu_addr) {
>                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
> +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_pd=
b0) {
> +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_PL=
_VRAM) {
> +                             *gpu_addr -=3D amdgpu_ttm_domain_start(adev=
, TTM_PL_VRAM);
> +                     }
> +             }
> +     }

Please NAK to that approach here. The GPU offset should still point into th=
e mapped VRAM.

>
>        if (cpu_addr) {
>                r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..5ebb92ac9fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdg=
pu_device *adev,
>                /* In the case squeezing vram into GART aperture, we don't=
 use
>                 * FB aperture and AGP aperture. Disable them.
>                 */
> -             if (adev->gmc.pdb0_bo) {
> +             if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_TOP, 0);
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_BASE, 0x00FFFFFF);
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP=
, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 7c7a9fe6be6d..73ac05b9a1bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>                adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>        adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
>
> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))
> +         adev->gmc.enable_pdb0 =3D amdgpu_sriov_vf(adev);
>        return 0;
>  }
>
> @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>  {
>        u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>
> +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> +             adev->gmc.vmid0_page_table_depth =3D 1;
> +             adev->gmc.vmid0_page_table_block_size =3D 12;
> +     } else {
> +             adev->gmc.vmid0_page_table_depth =3D 0;
> +             adev->gmc.vmid0_page_table_block_size =3D 0;
> +     }
> +

What is the justification to moving that stuff around?

>        amdgpu_gmc_set_agp_default(adev, mc);
>
>        /* add the xgmi offset of the physical node */
> @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>                amdgpu_gmc_sysvm_location(adev, mc);
>        } else {
>                amdgpu_gmc_vram_location(adev, mc, base);
> -             amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BE=
ST_FIT);
> +             if (!adev->gmc.enable_pdb0)
> +                     amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLAC=
EMENT_BEST_FIT);
> +             else
> +                     amdgpu_gmc_sysvm_location(adev, mc);
>                if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
>                        amdgpu_gmc_agp_location(adev, mc);
>        }
> @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>                return 0;
>        }
>
> -     if (adev->gmc.xgmi.connected_to_cpu) {
> -             adev->gmc.vmid0_page_table_depth =3D 1;
> -             adev->gmc.vmid0_page_table_block_size =3D 12;
> -     } else {
> -             adev->gmc.vmid0_page_table_depth =3D 0;
> -             adev->gmc.vmid0_page_table_block_size =3D 0;
> -     }
> -
>        /* Initialize common gart structure */
>        r =3D amdgpu_gart_init(adev);
>        if (r)
> @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device =
*adev)
>                if (r)
>                        return r;
>
> -             if (adev->gmc.xgmi.connected_to_cpu)
> +             if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb=
0)

Drop the connected_to_cpu check here.

>                        r =3D amdgpu_gmc_pdb0_alloc(adev);
>        }
>
> @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devic=
e *adev)
>  {
>        int r;
>
> -     if (adev->gmc.xgmi.connected_to_cpu)
> +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)

And here.

>                amdgpu_gmc_init_pdb0(adev);
>
>        if (adev->gart.bo =3D=3D NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v9_4.c
> index fe0710b55c3a..13b229d07ac4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct =
amdgpu_device *adev, int hu
>  static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *ade=
v,
>                                               int hubid)
>  {
> -     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev->g=
mc.pdb0_bo : adev->gart.bo);

That can be written as adev->gmc.pdb0_bo ?: adev->gart.bo

>
>        mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
>
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +     if (adev->gmc.pdb0_bo) {
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_=
ADDR_LO32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.fb_start >> 12));
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_=
ADDR_HI32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.fb_start >> 44));
> +
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_AD=
DR_LO32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.gart_end >> 12));
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_AD=
DR_HI32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.gart_end >> 44));
> +     } else {
> ++            WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO=
32,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_start >> 12));
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI=
32,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_start >> 44));

When you indent the WREG32_SOC15_OFFSET() you need to indent the following =
lines as well.

>
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32=
,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_end >> 12));
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32=
,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_end >> 44));
> +     }

The programming of the end addr is still the same, you don't need to change=
 anything here.

Regards,
Christian.

>  }
>
>  static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint=
32_t vmid,

--_000_DM4PR12MB593795CA6451D087678119E3E5BB2DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Ping=85<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br=
>
<b>Date: </b>Friday, April 18, 2025 at 14:26<br>
<b>To: </b>Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;, amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thank you for the review and the feedback.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; index d90e9daf5a50..83a3444c69d9 100644</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object=
.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_rese=
rved(struct amdgpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unpin;</span><o:p></=
o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt;&nbsp;
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)</span>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {</spa=
n><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_off=
set(*bo_ptr);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&a=
mp; adev-&gt;gmc.enable_pdb0) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if ((*bo_ptr)-&gt;tbo.resource-&gt;mem_type =3D=3D TTM_PL_VRAM) {</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_=
domain_start(adev, TTM_PL_VRAM);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&gt;Please NAK to that approach here. The GPU offset sh=
ould still point into the mapped VRAM.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">This change is to change to the default GPU address fro=
m FB aperture type to pdb0 type in this centralized place so that I don=92t=
 need to change every callsite of amdgpu_bo_create_reserved().</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Could you suggest a better approach if this approach is=
 not acceptable?
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.co=
m&gt;<br>
<b>Date: </b>Wednesday, April 16, 2025 at 21:52<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.04.25 um 12:46 =
schrieb Samuel Zhang:<br>
&gt; When switching to new GPU index after hibernation and then resume,<br>
&gt; VRAM offset of each VRAM BO will be changed, and the cached gpu<br>
&gt; addresses needed to updated.<br>
&gt;<br>
&gt; This is to enable pdb0 and switch to use pdb0-based virtual gpu<br>
&gt; address by default in amdgpu_bo_create_reserved(). since the virtual<b=
r>
&gt; addresses do not change, this can avoid the need to update all<br>
&gt; cached gpu addresses all over the codebase.<br>
&gt;<br>
&gt; Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; | 43 +=
++++++++++++++-------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 8 +++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |&nbsp; 2 +=
-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 29 +++++++++------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nbsp; | 30 +=
+++++++++++---<br>
&gt;&nbsp; 6 files changed, 82 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 5b60d714e089..e706afcb7e95 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_devi=
ce *adev, struct amdgpu_gmc *mc,<br>
&gt;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struc=
t amdgpu_gmc *mc)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_start =3D 0;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.num_physical_nodes - 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.physical_node_id;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&=
gt;xgmi.node_segment_size - 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.num_physical_nodes;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hive_vram_end =3D ALIGN(hive_vram_end, (1ULL=
&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21) - 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mc-&gt;vram_start) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;xgmi.physi=
cal_node_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segment_size -=
 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016llX (%lluM u=
sed)\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt=
;&gt; 20, mc-&gt;vram_start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt=
;real_vram_size &gt;&gt; 20);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D hive_v=
ram_end + 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =3D mc-&gt;g=
art_start + mc-&gt;gart_size - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =3D hive_vra=
m_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D hive_vram_=
end;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%=
016llX - 0x%016llX (%lluM used)\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt=
;&gt; 20, mc-&gt;vram_start,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt=
;real_vram_size &gt;&gt; 20);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GART: %lluM 0x%=
016llX - 0x%016llX\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_size &gt;&g=
t; 20, mc-&gt;gart_start, mc-&gt;gart_end);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;FB 0x%016llX - =
0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start, mc-&gt=
;fb_end, mc-&gt;gart_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);=
<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt; @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;job);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_alloc;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_pd_addr(ad=
ev-&gt;gart.bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_pd_addr(ad=
ev-&gt;gmc.pdb0_bo ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_bo :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_flush =3D t=
rue;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;ibs-&gt;ptr[job-&gt;=
ibs-&gt;length_dw++] =3D ring-&gt;funcs-&gt;nop;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &am=
p;job-&gt;ibs[0]);<br>
&gt; @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_size =3D adev-&gt;g=
mc.xgmi.node_segment_size * adev-&gt;gmc.xgmi.num_physical_nodes;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pde0_page_size =3D (1ULL=
&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_manager.vram_b=
ase_offset -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr_first =3D adev-&gt;vm_manager.=
vram_base_offset -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id * adev-&gt;gmc.xgmi.=
node_segment_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_manager.vram_b=
ase_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_end =3D vram_addr +=
 vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gart_ptb_gpu_pa =3D amdg=
pu_gmc_vram_pa(adev, adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx;<br>
&gt; @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PTE_FRAG((=
adev-&gt;gmc.vmid0_page_table_block_size + 9*1));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PDE_PTE_FL=
AG(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_addr =3D vram_addr_first;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_end =3D vram_addr + vram_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE0 entries =
are used as PTE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing to vram<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_end; i++, =
vram_addr +=3D pde0_page_size)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i, vram_addr, flags=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_end; i++, =
vram_addr +=3D pde0_page_size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vram_addr &gt;=3D vram=
_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The n+1'th PDE0 entry poi=
nts to a huge<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PTB who has more tha=
n 512 entries each<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index bd7fc123b8f9..758b47240c6f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *pdb0_bo;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped address of pd=
b0*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr_pdb0;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool enable_pdb0;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index d90e9daf5a50..83a3444c69d9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_devic=
e *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unpin;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;gmc.enable_=
pdb0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)-&gt;tbo.r=
esource-&gt;mem_type =3D=3D TTM_PL_VRAM) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(adev, TTM_P=
L_VRAM);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Please NAK to that approach here. The GPU offset should still point into th=
e mapped VRAM.<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; index cb25f7f0dfc1..5ebb92ac9fd7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART aperture, we do=
n't use<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable them.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_sriov_vf(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 7c7a9fe6be6d..73ac05b9a1bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &lt;&lt; 30=
) - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noretry_flags =
=3D AMDGPU_VM_NORETRY_FLAGS_TF;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(9, 4, 3) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(ad=
ev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(ad=
ev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.enable_=
pdb0 =3D amdgpu_sriov_vf(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-&gt;mmhub.=
funcs-&gt;get_fb_location(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || ad=
ev-&gt;gmc.enable_pdb0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
<br>
What is the justification to moving that stuff around?<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_set_agp_default(a=
dev, mc);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi offset of th=
e physical node */<br>
&gt; @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;gmc.enable_pdb0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_gart_locatio=
n(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_locati=
on(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp; (amdgpu_agp =3D=
=3D 1))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
gmc_agp_location(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize common gart st=
ructure */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gart_init(adev)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.connected_to_cpu || adev-&gt;gmc.enable_pdb0)<br>
<br>
Drop the connected_to_cpu check here.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D a=
mdgpu_gmc_pdb0_alloc(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || ad=
ev-&gt;gmc.enable_pdb0)<br>
<br>
And here.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.bo =3D=3D =
NULL) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm=
/amd/amdgpu/mmhub_v9_4.c<br>
&gt; index fe0710b55c3a..13b229d07ac4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
&gt; @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(stru=
ct amdgpu_device *adev, int hu<br>
&gt;&nbsp; static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hubid)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev=
-&gt;gart.bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev=
-&gt;gmc.pdb0_bo ? adev-&gt;gmc.pdb0_bo : adev-&gt;gart.bo);<br>
<br>
That can be written as adev-&gt;gmc.pdb0_bo ?: adev-&gt;gart.bo<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_hubid_vm_pt=
_regs(adev, hubid, 0, pt_base);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_START_ADDR_LO32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.fb_star=
t &gt;&gt; 12));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_START_ADDR_HI32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.fb_star=
t &gt;&gt; 44));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_END_ADDR_LO32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_en=
d &gt;&gt; 12));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_END_ADDR_HI32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_en=
d &gt;&gt; 44));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; ++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W=
REG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 12));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 44));<br>
<br>
When you indent the WREG32_SOC15_OFFSET() you need to indent the following =
lines as well.<br>
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 12));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
The programming of the end addr is still the same, you don't need to change=
 anything here.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *ad=
ev, uint32_t vmid,<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB593795CA6451D087678119E3E5BB2DM4PR12MB5937namp_--
