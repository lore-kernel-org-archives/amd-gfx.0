Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF20C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C1A10E893;
	Thu,  1 Aug 2024 05:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVMtYSP+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D22D10E893
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCQOl5jD3i6D0XGsIW+YTgN71sXyNRn5pnORyY7XtgQwJ6avvBzVZ2QehKiDaKyT32WJtbEMOduaHHjvjEeYRlA3B1Zz6gAV1KXAJFi74hqxtMCLqBwFI8WE1pMJfDDXAoVnM6r4mvl7Ud7LMcXHlqNy45X2hbgDpq6wa+JOPqhiBVft5j9o5cCrLo2r0ssfhMmXuBJSrSIPqk6zsVZYIWDFaVO91jpJM6zMYZN0CswNElzWkXU5qjj4IYoZNFkkvvppqWo7pfQlYGTJ7zch7nOJV9Qv4GrpT+AJImmFrDR7pgRw2EkQyUtVSKM0dvnbdjZg5AgnFUCTgshPBj8NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56mnE3zvpeLEKWEUTdA4JckIaTlTJmYHOf+wA641HlA=;
 b=gyP6d+JwfVJOFi6mhMLT3woLLItubaZKg0aORddYvkHd1Mj3IbMMfqxNzt1jgqZyUJNj/npvDvshvjINEM3CWCsopb/fYuDHrVJMHqtpYNEWAZ0+/Pvmy+mD1AMPwu8L/6WjoZKDb55d8LeEKqgV5qLHsh46DvddcrSLaIbjWkQPGkMhZjdbkT9hGmLd4CmUIwdJk4FNYK2EzjsV3C5hprOQ8WP4by9SA2Cm3Qe/dM+SNE0pgQaQW9FU9I6wCMx6jlfgztbj7wepHqODamoS0HDsZG+xigxdz/+aZUAvnBGQ2JBAkN4AEUFz58uBMNcuQhE1e7LwFA6JIl7IK29yBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56mnE3zvpeLEKWEUTdA4JckIaTlTJmYHOf+wA641HlA=;
 b=NVMtYSP+aYuXhqewHvCL61jsjPt+NF8OHqwpxXdubUQzsbEwyj/A7JIjDt1xl00HskMVd5dCPBfWwLruo6pEEhRPUIO0S/e1yDfDND8H5lE+/4oN681q6eoNHYz/HyqZE/CWRR/CwMrRoPul9iOD1G4lNoxXbpUpv1GG2EtUd3A=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 05:58:27 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 05:58:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zExnRuw1cXkP02nZh2cKZwugrIRt02AgAANeICAAByRAIAABixw
Date: Thu, 1 Aug 2024 05:58:26 +0000
Message-ID: <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=60b2d777-4128-49f9-8b5b-a6aaa5eae599;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T02:59:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7413:EE_
x-ms-office365-filtering-correlation-id: af7f9e1e-eac8-41a9-e9f2-08dcb1eef628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5lcPYWO6AEfqLTSJN564UpO/GiinCg613a6qtSonxs6kMQgsORu/iLlZIRUZ?=
 =?us-ascii?Q?yDfKqtzzy/FAls18MisxY5SLRGcpy7AB5VTFGlctj/+GfdC7t/qqB1mkSxt7?=
 =?us-ascii?Q?ID0jIu6Cdqj2FW7DqnFZGoUcC2jyHtqo2VFkWCa8c6l/dYgy9ucrFs08wahC?=
 =?us-ascii?Q?6dj5B5icC5FKjX+Ij9uT0z+eWfl6DVnVo6rqQhw9V2VDa03NgBP+IIjJbX3w?=
 =?us-ascii?Q?DeJqTFnXN3j/ebnPRQJUSfKvuMAe0XAJVOzFGybccT2yRCnkF2yltwLBy8po?=
 =?us-ascii?Q?Kt5IdRKoWx/vnApLyFDgh5esDVyHeQuvOIh81wNl9Cam1IefV+2z6/pAwdC5?=
 =?us-ascii?Q?IwjwbsxrArS4S7chkQnx0w23gPPknbVi/faoHmU7EJh1CUQGSid+ci9sfzD6?=
 =?us-ascii?Q?49fdE3Q2+0y38GKDPMekd3sRHw4Hc9xhh2SQ2u5QJXHwXbiypXX1/YAY/Jv8?=
 =?us-ascii?Q?+sWL2T2T8tCteRA1RiKXlP3JT62mdvgNB5Q0kL3mDq1DmUKD4WuC5kfK2V/e?=
 =?us-ascii?Q?4G17H6AWykzQQZDZX06kMUkipUc7/JPit5WjjAVR+8XJAFA+U8Jz97LSNQ+p?=
 =?us-ascii?Q?R3V9IfzVMN3DG9hzkfleWmYFUcuXG/X8YYz1ckgBQk7EerRONryLaKpzOzsu?=
 =?us-ascii?Q?aPBVexvO2+x6sQnr19LoC7dKiZE++I6ggyCD/lNIB+GBqFXC2VTeUJY9XUEr?=
 =?us-ascii?Q?T86FgCRs+uWO+RYC7hmkxgYryKAtDY90nYVBfmyJgaeVxzLUqxZVU3ZXKpxz?=
 =?us-ascii?Q?FrBRPqaNYHVNJ0g9DjCuLIs90CVvCZsVUDsuY2u9K452sLHjzOtJ3iW/Q+JZ?=
 =?us-ascii?Q?1l9ZZi1LuNGU8pcMLxHmGTxo3lFxsxNW9upShtj6DEjN9trh/V8gGOfLjSwk?=
 =?us-ascii?Q?dV8re395FQ+P5d1kYFVBBFyiTZzlu37PIz0/FFqjfvob0MI0eZnvLhJQFGMm?=
 =?us-ascii?Q?kTemvaHdwnouZUVmWzT53R4I/8N6uyorrK7xTgJ6nTSXoGQH6qGNmAjpzcw4?=
 =?us-ascii?Q?/U6PkhPONnEK3gNXjbxpVzF9Nzylb0FEz+jmTsXu3UgcHuUHHIYy6GJQIuha?=
 =?us-ascii?Q?6Jt9EaNu/eVUadMd1WeqZzsbiftBeZCNxu56f6rlwcQCNDGwZSJUY+l7/pWF?=
 =?us-ascii?Q?y0MXJV9JVJYlNFboLmYu+cYpcN2ySKaj2zB/kXR3CDhK5//zHcREDn8FHkIP?=
 =?us-ascii?Q?0P4x1oa3/K+VvCLf7JPLKDf+4td8i/Fm17ovmjsxS2Xdryh04lZQ6NR7Wr/L?=
 =?us-ascii?Q?rkHnVPrRizhDbPu+vajgigi07BvG66hIiHkc/pp5iFd/+ZiZ7lzjisCGiFIl?=
 =?us-ascii?Q?TOCLWKwK+7HnTAED1eH37DFuBiWgCIzwVoA7/P0PngAjf5ZCCPAAK3BDXM3w?=
 =?us-ascii?Q?Is8ooTDYko2JXlGeO73MBxH2uAm73r0gTxi3JUF8m7F6qTXKQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j18nIklUx/F+RcpSt1Fu2xrQQXcmceMiEtUNWwCPnF3Ub9e9cZ2frFkmpYy6?=
 =?us-ascii?Q?lqh9y1132aD52IKyhN1r6PjJ2yJ9Exm0YSMeBNEcxZ+BDmmd5c1RUnKD8XRo?=
 =?us-ascii?Q?mAizpeP1oniQ32RmKL6+mHsUQI3JyMSNSpurvsRk+a7E+8K47AFSkhxHWy1g?=
 =?us-ascii?Q?9V0RbnhP/4Tj6qZyMkkpSmyDyneTz6VJlkC0QGtA7U9MF1s4vsXqVbxkcdIn?=
 =?us-ascii?Q?qIibPlTx5GPGaWoklM6IxRiKxySGEIgoIbBh5R2xrwsyXbEqgGssunzjI+Ox?=
 =?us-ascii?Q?n2wMqfpU974RW+Lif9ER3BHf71FYqiQ2RA3vHGYnAZ7S23RPonxEXd6F+nGE?=
 =?us-ascii?Q?W/Rs/KjMAaPRZMtZV3QlxF8uJ16fAqgC5edye6aTOegBeAESK4gGr6o4vwvy?=
 =?us-ascii?Q?v97oqQSP5hq8JNcBfk4udDM25yio0ama01HPtOLtSwuSFq7mnR4QWk0TMoVR?=
 =?us-ascii?Q?uPJ4CZGTPO3Kv71tiWUFYc80IeJjdp4M/pxronHbXHU7vJF0OX9vDCKw/3dk?=
 =?us-ascii?Q?ldYVpvdYwepC0M2UUgEi1A6VBEAauj225udS0RLHeL7bvub5gtnOP0jKO1Ii?=
 =?us-ascii?Q?MVBeAGOAkj7cxqiGu7e/spZqQKUXjinQkiRyFJvMs/FSMp0bf9HODyVrir1q?=
 =?us-ascii?Q?KJa5SqY/qQ01koCB2pXO09EnI/bCXWaFZLz6DheauD3hog5UuGR9R1fprjWF?=
 =?us-ascii?Q?77Xdzca6kjQK32DtwV53UBl2ohi2+fAmPTcryvQZQ2ASAsw1pMm9LM+eE/DH?=
 =?us-ascii?Q?LaIxPJV7VsxgXgANumjYK/XjAdTu10W4cAbzETuDbf0dw0hQvbviiNXnbj4A?=
 =?us-ascii?Q?yXQJKvn21qp+BJABnZGExhxwQAbKXolU91dbw57iJYowS1nbYGnwfWvzT2aa?=
 =?us-ascii?Q?zpr7eqWAWePaaerCpHlp/PEvzdJAYpm1B/ygAdn/M48XPM9shKd7WUlh56Ss?=
 =?us-ascii?Q?AUyKcYLceFC0wJuAEt6Up7iJVXOJFB3EG4y3GBsGgRb5mUe9t/DdlWltZpLo?=
 =?us-ascii?Q?skYr/v4PznzBg/5e3SHD5fP4JdkFYOtwVBl/CF+JWE2OUHn//U+qPdBuuTXa?=
 =?us-ascii?Q?e+7sPT+uR2s5u6Fbx4BgK13OpCiO5pjSvtVtPZe4fCaBWrzbJgn6F32TZ1FT?=
 =?us-ascii?Q?yc+2vSuHnc8iLoJz/EMfNr6ma0eqklRn1iHJLh8yehL5jP86+tNY5TncuYBD?=
 =?us-ascii?Q?QoOk9lOYeSK75hm7VllAttmHX1ITAoPQSUTPHwPUzA4RH2aCKLTndBqsZUgo?=
 =?us-ascii?Q?+tYg7aGGfGr2s1dUy5DoSjvWHqZW2RBkdDHYrcApIa1bolTC4Ue2cG4ZFO9d?=
 =?us-ascii?Q?1nl0ub4CBf2L+LRWng1rl3ie3Eydu3TGJG8vZBhMdHCvrU63LjHwsdtQOwXy?=
 =?us-ascii?Q?5WiA+N9pIhYSKz8nJYqeu6f/aMHiG01cDXiuADEa2vHjAUDbpXM1ayBnCGe4?=
 =?us-ascii?Q?Saxav0Ej10U7z6vnGmGdLKL8T7W+cKH5qy+JmBRTdcosA5hbBtmJy57MVKzF?=
 =?us-ascii?Q?O7JTU8wMMI3WOuy0xIqkEU0R8cKP6FWHXspVOEqm1n0/OHOheO0x4Be+4enn?=
 =?us-ascii?Q?zO5eNPBG0Ljb1SufEXY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f9e1e-eac8-41a9-e9f2-08dcb1eef628
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 05:58:26.9498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UpAqmXXVJwt2RIeNpFaaeTp9p2vpd8MvyVvWuAwfTf4OwYu8A0HAuT6T1His3ks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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

Yes, the bad status message is printed twice with this patch. I think it's =
harmless and the second message is more convenient for customer.

I can add a parameter for amdgpu_ras_eeprom_check_err_threshold to disable =
the first message if you think printing message twice is not a good idea.

Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, August 1, 2024 1:30 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Right, it's functional. My concern is whether the kernel message in
> amdgpu_ras_eeprom_check_err_threshold will be printed twice. This is the =
end
> of gpu recovery (i.e., report gpu reset failed or gpu reset succeed).
> Check_err_threshold was already done before reaching here.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, August 1, 2024 11:49
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> I think the if condition in amdgpu_ras_eeprom_check_err_threshold is good
> enough, no need to update it with is_rma.
>
> Tao
>
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Thursday, August 1, 2024 11:00 AM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Might consider leverage is_RMA flag for the same purpose?
> >
> > Regards,
> > Hawking
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> > Zhou
> > Sent: Wednesday, July 31, 2024 18:05
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery
> >
> > Instead of printing GPU reset failed.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 355c2478c4b6..b7c967779b4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct
> > amdgpu_device *adev,
> >                 tmp_adev->asic_reset_res =3D 0;
> >
> >                 if (r) {
> > -                       /* bad news, how to tell it to userspace ? */
> > -                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n=
",
> > atomic_read(&tmp_adev->gpu_reset_counter));
> > +                       /* bad news, how to tell it to userspace ?
> > +                        * for ras error, we should report GPU bad stat=
us instead of
> > +                        * reset failure
> > +                        */
> > +                       if (!amdgpu_ras_eeprom_check_err_threshold(tmp_=
adev))
> > +                               dev_info(tmp_adev->dev, "GPU reset(%d)
> > + failed\n",
> > +
> > + atomic_read(&tmp_adev->gpu_reset_counter));
> >                         amdgpu_vf_error_put(tmp_adev,
> > AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
> >                 } else {
> >                         dev_info(tmp_adev->dev, "GPU reset(%d)
> > succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
> > --
> > 2.34.1
> >
>
>

