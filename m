Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B69606A32C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N1RpsI3L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86EA10E2B1;
	Mon,  2 Nov 2026 20:17:19 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D34E10E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFcIUXJG6UStHjrJ5acI9AHD5CKfDYK1hWFjeRn7pDhJIyWQf+i3wdavOPI32FuyEcvf53DSlXjkqYXUtWFWC3I/4h+mXlrdkLSoagms93ggEiZwzXDYB0kKBMD+n3yhPWbjNG/Mzt3Ljo3SN7TRmtl04uwY9VH4GQdhmEATdauH2vEIREHXIGZicdKlUlWDj2cBj9fnYUbqVPcCaHYb//ug1LCJeB44v9LKBqv24v2JL7jguNIu1fkwIViAiwBXIWHFEvwAlELbC1S5V9uy+jl4YpBnsNEd6R/ZyMGSChdDoGXq1T4VZRUB9QoZ9z14+1sN78xqk5zU6dHR9d0ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hKc/q6Wqaq/Dkk2XggToYquqe1SqbZprtf3Gnu9tNo=;
 b=bOX/Ke3KzoyUUu5AbrNh8LrCx0SWrlSiJVTP4AXa+tiMJ8u0F43yv5BsdTgQVywzsfxA+udzZDRDpSqubUKPylVgaR0v9kNNbv1hPv+CctyUKk19ajJX4dQeAklC0BkeKDTYQijrG2IqH6eV1nDNXyMq33ZH8r3aTD2zvqroWYVHqzXr0TmTlb0/dQSIvq0np67Ybj83hq5x+K62tEEbx+dNfOjjkn1KOl4t9BajuLdtLN45FATi10b3iK5mzXo7RX8ZCWSCkcYLDcUYcM6eLrsk5kWH9qWapBj8Sk6JKcKV9ityz4oQqe9OkX2g4SAbQem0rlp5gIOttX/lOu4MuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hKc/q6Wqaq/Dkk2XggToYquqe1SqbZprtf3Gnu9tNo=;
 b=N1RpsI3L+9475togptbsDFCEqQ2q8E0Cf1JETsyGQsX7lS6/FIzGILvzbOOi0x7+sXBNKOdkeDbsjU8l5rIk5VIqJZnLLBpY7Jm+AefOwcTg0bzL+ezZFTp0/434x/zltVg9B9rnvyC+0Y/d1XpJdrgJhJva3y5To18WHvZSgn0=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by CY1PR12MB9583.namprd12.prod.outlook.com
 (2603:10b6:930:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:17:06 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:17:06 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Topic: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
Thread-Index: AQHdaHfUSRAEsvFx50uWjyFlJSUj9rcWlrWAgARHa4OAAF0UgIAAAaTA
Date: Mon, 2 Nov 2026 20:17:05 +0000
Message-ID: <CHAPR12MB999247AC90D109E731175BB99BEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-2-David.Francis@amd.com>
 <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
 <CHAPR12MB99924757FCFC078459155A971AEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
 <3d5a7903-367b-42cc-958c-66ff65565194@amd.com>
In-Reply-To: <3d5a7903-367b-42cc-958c-66ff65565194@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T20:17:05.359Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|CY1PR12MB9583:EE_
x-ms-office365-filtering-correlation-id: 461e6c5f-5ac2-4fb6-d100-08df391e43dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|5023799004|4143699003|11063799006|261022075727099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|261022105027099003|261021121427099003|56012099006|38070700021;
x-microsoft-antispam-message-info: izx8HeUZvk6Cw4MGdlan/WL4KEkbL3EZghMJabCSmezLKz53+oD+oRT5oaO8ny/DpU+IAmCRW9agShC/Fhs1axyyjEiGL315i22P+tme5ObzEiCgWByHxaL5fcA9Vgt28BMvqrF1pTc4nxZAn0hbesUE0iGHAty8ttsoG5VcLmYv71K+v2yWTC7CH22sOL48dk7TRrsBroUVcemhcQQ25nU8KKSO45HjVviIeDF2K1Va19Gz0ln08NkvjeFWKmbsGQeUCy+WB8QKPquziqIn/Yg2f7fPcbt2nXiUy5Wm7W5Y302p+5qw1e3Axp5itbCjDlVNEdsYRyDe2zkWftuyXsmJMo2DaobTGNdsnHSsCPgikXVrtKtPCQ3Ed0Q990xkYdOIa6CTUB3924EJHPYpb1j9Twuqz/mMy5XEldDH42maV7BXK8+l2Vn/pgD9CfA6izy8NdFBKMV1tSnazc/qcwVSern/wP6Zfa0x38HJBkkFPvxxDxdupQYj1P/ZByUSJmtLgsi2w3EBsXk7XRxLo2kQniJpmm/3gvPNBRrOB5Fr5KmfQC4CREK4qD8uqp2JBcAuzy5jmtcK6fTsjumZ4B+6bedzE803/Uk41ndAeRR+8PFmzY1acPM5SUoeMQQfTiq+mO5H8Ow3tD7IHO90kC/B7u4TVWXuZTVR6QYCo7o5hor5954IPnmTWe9MxaM5LUKU63bxt9rwjMTA13W//5/zy8Stbg+2YHQ4TH4yzY4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(5023799004)(4143699003)(11063799006)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261021121427099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ayTIQQCHqYnHshjo+ZAPFbbt98Ka9Iq+zKyW5yoeXjsiPialbH9zDvLX4sV8?=
 =?us-ascii?Q?qL66AsUSQs09GXsH80ew+aKm3t7DgZJDNIHSnv2otUGKXNah6ez0tdorO0g8?=
 =?us-ascii?Q?aEc5Uhyu2y+18yQr3AsovyBjQ/mlKuPHaIV4uL42Y4V1MKLy6Ws5KGbtLdEA?=
 =?us-ascii?Q?XpQqJB0fni8WDc8gdfsMjSejvN5vwAnoEVxERD45DfWXBaGZsg748xxfiOMJ?=
 =?us-ascii?Q?+I43e8NQFmcLqvxbPSH28dng5kpqM9AXm1PbXuMZoAjyI0HlL68pSxrrbe6S?=
 =?us-ascii?Q?eCcRkzXeldTlEcONUad7gtlvzYKHGTEE1Ao8zA7itILB/PbNP4xctogx9Zej?=
 =?us-ascii?Q?D5UUNMMZ6jUYBG+usSSMP8d545mx1CVA+S4EePp1fMtJbmflsyNTKPqHfPrq?=
 =?us-ascii?Q?/AcgRQ8w1N+3dHgn7swbWYBBmIjVAdP/keVUY+m63OksXeTNMy68z7S0WZU9?=
 =?us-ascii?Q?6UJSl64kGz8Hz4sVzhM1tsUX6YBUJDRZyZNNIJTfbkM3VLcLTI698jtv0RS7?=
 =?us-ascii?Q?GzRecsi3mrNbnzPcoJiY+7o3DB9RpCy5ELsWLM3HU21o/LdeAx40KE61pgF6?=
 =?us-ascii?Q?tx6RdltJ+I+clgAsjWQhrDTEhpvdHYsj7An8fsTzGXbsuGP7k+KFsAxV4kB3?=
 =?us-ascii?Q?fsZdimdi+AJ215y9IYBiFm4+YMDd+Y/9gMpgB/9RyxnSwUMMLofgZXEyjID1?=
 =?us-ascii?Q?fMT1JtleHI9AOGzpkYCkziGXNRBypV/0ifsUD0RqZPTzVjXY5wzKeV9FP0+e?=
 =?us-ascii?Q?3Z9KpsSqZhghywXI2a1gVB7er/h69eAer1VClAFEaMo0JvekUJPZjWX/oM0B?=
 =?us-ascii?Q?ekeTtYVtn4L5pWj4Q5o3DaK2woNqWAuqGcwKR7KGIXExNk6KqiP7gEQF3AT7?=
 =?us-ascii?Q?WXQCi9SDySOyjivQo0ciJr59VzbnMjNCAp54gB2/unmCsVCdzKQPLZOImqZ1?=
 =?us-ascii?Q?ArnHsxbXMhGEPwlnLQ4pN7jUg17SWvAHxE3dkH7ASIo69JvZdHHU3Gdo6PAC?=
 =?us-ascii?Q?x44UotaKKcrgx5nS1jDujf8zYFlMaBQin9+yDYaW/pu0yMETjJdbtcFqyO5x?=
 =?us-ascii?Q?ygkUqUJ+cqqWi609VVXs+A6F2r9OkKlmp0yNVowOWr+N/jD9Qo6nUWoGDSN+?=
 =?us-ascii?Q?jE2CfbFxiiLgQIO5wcXYA0VfpyKNtmonnoBl6v5jYgHLVCoymjtY7PTHgsW0?=
 =?us-ascii?Q?+Qi0641LK16CGyyyNaCUaXYjn6yhAM5gHmi1KsfL4eAMWKbYKXTIrx4TMlo7?=
 =?us-ascii?Q?v6JFu9y43bAK+yoA9XDTRvIkhViDMFodicaoOhToGczc+NrCewv2R3hfUfPX?=
 =?us-ascii?Q?ynu35j7NbyjV3wDtHYA1vj63zqnELPZw6p0oW7If4VjlnKPxIROjkNnf/gSM?=
 =?us-ascii?Q?9bIO9HoZF0TWQLO/SuP52r6esVS2FzvllwcC/WHjdSYrwAaABxl7GsYBs2yF?=
 =?us-ascii?Q?zBaNrMWB1OgsA3Fpa8k6XSZpk/83RwnkBstt0Yx7z6JRF/NKqyVoaoEWp+i8?=
 =?us-ascii?Q?FZkKdRH/d7YQ3BjW8MFPagnfs96gxAX4Rp3DB4vwrEE2Ln9h4h8uY5+NKTBV?=
 =?us-ascii?Q?7RHobFFZ+nfS0SPSrc2K0bH30ru7YThGm10elbFxzviQZTVeqJZ6mjrBZLR3?=
 =?us-ascii?Q?w+klwEojP+8qbMG4V2p8nIyA/QL8boX4bf/YrgfMhg9WfMmZhq76yggdV6Zj?=
 =?us-ascii?Q?djTVGJ6AftY1T9HWMxN4sB/qt7FwqX0NiwDu2P5tAu9tpsVZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461e6c5f-5ac2-4fb6-d100-08df391e43dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 20:17:05.9837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKA59MX3rHeC/XrIXTAjUIFnXvAXmAdlK+/XLj0hfVQiTU9OEihDZyOoFXPRx2Gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>>> I'm curious what this case is needed for. In what circumstances would a
>>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>>> wouldn't that break restore anyway?
>>>
>> A lot of mqd managers don't set mqd->get_checkpoint_info,
>> so the ctl_stack_size ends up as 0.
>>
>> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
>> topo_dev->node_props.ctl_stack_size anyways, so I think it
>> makes sense to default to that value if the input is 0.
>
>I guess get_checkpoint_info is not implemented for GPUs that don't
>allocate the control stack in kernel mode. Either way, the control stack
>ends up being saved or copied into the user mode context save buffer, so
>the control stack contents are saved regardless of the size reported here.
>
>With that in mind, I think your change kind of makes sense. I think the
>cleanest solution would be to just ignore the ctl_stack_size in the
>q_data and always get it from the topo_dev->node_props. You could even
>remove from the q_data completely. It's not needed. Just make sure you
>bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
>driver would fail gracefully.
>
>Then you could also remove all those per-GPU generation
>get_checkpoint_info functions.
>

I think that cleanup makes sense. Is there any concern about bumping
the CRIU priv version and creating this incompatibility with old dump files
when we don't have to? (We could for instance just leave that field as
padding)

David Francis

________________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, November 2, 2026 3:09 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue resto=
re (again)

On 2026-11-02 09:39, Francis, David wrote:
>>> +
>>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>>> +             if (q_data->ctl_stack_size)
>>> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / n=
um_xcc;
>>> +             else if (topo_dev)
>>> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_s=
tack_size;
>> I'm curious what this case is needed for. In what circumstances would a
>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>> wouldn't that break restore anyway?
>>
> A lot of mqd managers don't set mqd->get_checkpoint_info,
> so the ctl_stack_size ends up as 0.
>
> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
> topo_dev->node_props.ctl_stack_size anyways, so I think it
> makes sense to default to that value if the input is 0.

I guess get_checkpoint_info is not implemented for GPUs that don't
allocate the control stack in kernel mode. Either way, the control stack
ends up being saved or copied into the user mode context save buffer, so
the control stack contents are saved regardless of the size reported here.

With that in mind, I think your change kind of makes sense. I think the
cleanest solution would be to just ignore the ctl_stack_size in the
q_data and always get it from the topo_dev->node_props. You could even
remove from the q_data completely. It's not needed. Just make sure you
bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
driver would fail gracefully.

Then you could also remove all those per-GPU generation
get_checkpoint_info functions.

Regards,
   Felix


>
> David Francis
>
> ________________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, October 30, 2026 5:15 PM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian
> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue res=
tore (again)
>
> On 2026-10-30 10:05, David Francis wrote:
>> CRIU queue restore doesn't acquire the bo buffers in the same way
>> normal queue creation does. In normal queue creation, the driver
>> gets an additional reference on the queue's underlying buffers
>> that lasts until the queue is destroyed; this prevents the
>> queue's buffers from being removed from underneath it.
>>
>> Acquire them, but don't get the svm bo. SVM isn't yet fully
>> restored by this point in CRIU and so there's no svm range to get.
>> This will be addressed in the next patch.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>    .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++-=
-
>>    drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>>    4 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_chardev.c
>> index 6c710e4a5220c..d8233337b8d5e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep=
, struct kfd_process *p,
>>                goto err_bind_process;
>>        }
>>
>> -     err =3D kfd_queue_acquire_buffers(pdd, &q_properties);
>> +     err =3D kfd_queue_acquire_buffers(pdd, &q_properties, false);
>>        if (err) {
>>                pr_debug("failed to acquire user queue buffers\n");
>>                goto err_acquire_queue_buf;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd=
/amdkfd/kfd_priv.h
>> index f0ce5fc4a138f..eb4d35a42e917 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>>    int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, str=
uct amdgpu_bo **pbo,
>>                         u64 expected_size);
>>    void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct qu=
eue_properties *properties);
>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct qu=
eue_properties *properties, bool is_criu);
>>    int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct =
queue_properties *properties);
>>    void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **b=
o);
>>    int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 4c4a3a8587f46..509529af2dc3c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *=
p,
>>    }
>>
>>    static void set_queue_properties_from_criu(struct queue_properties *q=
p,
>> -                                       struct kfd_criu_queue_priv_data =
*q_data)
>> +                                        struct kfd_criu_queue_priv_data=
 *q_data,
>> +                                        struct kfd_process_device *pdd)
>>    {
>> +     struct kfd_topology_device *topo_dev;
>> +     uint32_t num_xcc =3D NUM_XCC(pdd->dev->xcc_mask);
>> +
>> +     topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>> +
>>        qp->is_interop =3D false;
>>        qp->queue_percent =3D q_data->q_percent;
>>        qp->priority =3D q_data->priority;
>> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct =
queue_properties *qp,
>>        qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>>        qp->ctx_save_restore_area_address =3D q_data->ctx_save_restore_ar=
ea_address;
>>        qp->ctx_save_restore_area_size =3D q_data->ctx_save_restore_area_=
size;
>> +
>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>> +             if (q_data->ctl_stack_size)
>> +                     qp->ctl_stack_size =3D q_data->ctl_stack_size / nu=
m_xcc;
>> +             else if (topo_dev)
>> +                     qp->ctl_stack_size =3D topo_dev->node_props.ctl_st=
ack_size;
> I'm curious what this case is needed for. In what circumstances would a
> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
> wouldn't that break restore anyway?
>
> Other than that, this patch looks good to me.
>
> Regards,
>     Felix
>
>
>> +     } else {
>> +             qp->ctl_stack_size =3D q_data->ctl_stack_size;
>> +     }
>> +
>>        qp->type =3D q_data->type;
>>        qp->format =3D q_data->format;
>>    }
>> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>        }
>>
>>        memset(&qp, 0, sizeof(qp));
>> -     set_queue_properties_from_criu(&qp, q_data);
>> +     set_queue_properties_from_criu(&qp, q_data, pdd);
>> +
>> +     if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_si=
ze) {
>> +             pr_err("Failed to determine ctl_stack_size for compute que=
ue\n");
>> +             ret =3D -EINVAL;
>> +             goto exit;
>> +     }
>>
>>        /* Per-XCC control stack size from topology, as create-queue requ=
ires */
>>        if (qp.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_=
enabled) {
>> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>
>>        print_queue_properties(&qp);
>>
>> +     ret =3D kfd_queue_acquire_buffers(pdd, &qp, true);
>> +     if (ret) {
>> +             pr_err("Failed to acquire user queue buffers err:%d\n", re=
t);
>> +             goto exit;
>> +     }
>> +
>>        ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_dat=
a, mqd, ctl_stack, NULL);
>>        if (ret) {
>>                pr_err("Failed to create new queue err:%d\n", ret);
>> +             kfd_queue_unref_bo_vas(pdd, &qp);
>> +             kfd_queue_release_buffers(pdd, &qp);
>>                goto exit;
>>        }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_queue.c
>> index 6010a5d7a7eb9..18d24ddb455eb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_propertie=
s *properties)
>>        kfd_queue_buffer_put(&properties->cwsr_bo);
>>    }
>>
>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct qu=
eue_properties *properties)
>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct qu=
eue_properties *properties, bool is_criu)
>>    {
>>        struct kfd_topology_device *topo_dev;
>>        u64 expected_queue_size;
>> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_de=
vice *pdd, struct queue_prope
>>
>>        amdgpu_bo_unreserve(vm->root.bo);
>>
>> +     /* CRIU svm buffers are restored at a later stage than queues. The=
y'll be in
>> +      * before the queue is actually used, so no risk here
>> +      */
>> +     if (is_criu)
>> +             return 0;
>> +
>>        err =3D kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restor=
e_area_address,
>>                                       total_cwsr_size);
>>        if (err)
