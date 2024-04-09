Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CEDC67861
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Apr 2024 09:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3415010EAFD;
	Tue,  9 Apr 2024 09:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="peLKJ765";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2138.outbound.protection.outlook.com [40.107.95.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8B410EF02
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 09:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYv0PBvUm/LBKF6q5BWLV+wjmLKajbN5kxlmwEpvpT4TI4DZ20xgVB5sJht3nYlu4hIECIc9ircPQSEKYBSKmFIcXYP0Iqiyu5Nr4YWkFj4ZFXEcdd0OwfAMv8MRjCCrLW8vjYbrV7W7EDE7cMG7APtSdLszIEVU7izeF5EeHf9JP5COlmy7/VWkgAka7CaLkv2j9mp9e7dd8hXvTlXo1chatwYT4lOyOeCZOv8ovRFwblbuSLQwCaN3lTXXYDquRn/lTodI/eT1EE1g3UKPsyfnltmEfKxG8WoVdtUcg1sXN3GwO4LfI/QUBYuDU0ynEJW60WY3S+LWEFYGhYPhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ2hEGiTaf4mPJ/SU2HBUeszcL/a6omiYkjLYpuCA4k=;
 b=e8xC4LD7bqZVZbJ0JTevRoikPwkYkEXDaQxlEjzJDsphfGcYwGcgoqJPvgcg+TBb1bUZ2KF/4K7oYSuZhR/DPXd6gUmnXSSTBX24/OIXu31oDgKk0GlJIHIVlcXdvNo8Bgbi6kdHYx96KL11lOpFX16e8BFe/pqDM3y+Q6ejqufgZJVOc0Pm95vaMX0B/HSu0Qg9xwzW3Qze+h+WSHTIaLtk009hyuY1fODl8vnql9X2wNsIJCZ1x0swpHWHqzozjbq6mSkGDGEoCBl9i5yWumdrmasYga5umFiPvOUK9XWGZnvgft35sXrpkicA4H3jIL8BBL1jtR4bejFur1d6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ2hEGiTaf4mPJ/SU2HBUeszcL/a6omiYkjLYpuCA4k=;
 b=peLKJ765xttpyW+eDROxb8Y6MosiwN2dssiE+x9ueZMuML9r8Stvjxcg2imQzo+4bk6mbVxxciaid8ehgQ6CJO3RWpgLnPi0QUX4y3M6bfWtsVMo9Uxw7iDvjE73IxqOJwJ64DKSaiB3C4oIujLzm2AmLDhFJiio+9uqI1QMdoY=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 09:28:01 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::9bf1:7cdc:4c83:4da2%3]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 09:28:01 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTzI8oX95f2kWPs2o7WORGDLFfRo8AgABumqA=
Date: Tue, 9 Apr 2024 09:28:00 +0000
Message-ID: <CH2PR12MB4215C10961061988C90358C3FC072@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
 <PH7PR12MB8796CC8493C2784DDE1A53F1B0072@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796CC8493C2784DDE1A53F1B0072@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3f6acaf8-9c91-4363-a78b-97425260c117;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-09T02:45:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB9343:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9jMmdM0zKjNkUoGtWPX2KDuTOl2CdO/ryrBqjoLw2qaRqf0FaEgblNkXW2pu0XkPCWACiIpwZTZrgYcZ4Rix0DEAjrlp4HYl3fGYdEOezzGTcfnpsB1I+fWNJD+NnCXtLigmtVefzUcomUSaQfkyqSEuUqtJQPM61IzXT96Npy4MIeb6U4JqLYdCH/p77Y/uBOPMTDw2htNTs6FkQxT6ViLzIhlsZS0WVXY96Gv8zX3gomkoG2Z/GBbkgm6M/9dwDONOWNFDU1hkHzxbvWw8gX0IMI2/0VvXjK8vlPmZzyfb3LlekUGQpVFIQdgWSmu7Y0s6X4reiL3TxB/oHAVft0LHuiaTEBqebKbI2i2wsw28+qX7/Pd/hsOjL2j8ferGfGPrG9iZF54b1DdSpHmx8nZXGXNvwxG/oBbBMAKtpIfYkwdml9TOIzPDzXWgA/kigYqIJMaYZrvNVZMyPBDQPmFW1Z9mT+Gk0foP+5I85s/5BDezRLFIy2dpFlEmz/XsZ39mYewEgUHzo2Ox7nd41GTSq45kcV10Gb1kKrWlxbqjmaOOddUNqjpqOGKhh9jeM/yUH6X1cf//DZEdGS2H24o7ROg4xQXsaiQHEkxBL05GG1+aXl2ERRnx02IlxghPIx9tsuk9xZyKQHIt6tPHJCN7ib8R992QnFJCYJQgLY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iGJLJE/dJWLb0cUa5tm/y7F0GAGrMpgBJVGwFRvUnnMHTBw/T+WkDNhkUoBz?=
 =?us-ascii?Q?ZUy+jSHgF8AiEPN4NrZtqZ03qOhfbLq28FNMtWYYqz1ftB1gggixQayyCMNH?=
 =?us-ascii?Q?UO5eKR9MsJ29SKb4llWg4GAUT298WEqMzbfrcBXRs9r22RU4EuGKottNIe73?=
 =?us-ascii?Q?EqW7X+INMom+EXfsJJn/Fc/qdmbUGXeRW0tymkNo9Da1x7km1FurHS8i91Ln?=
 =?us-ascii?Q?LXmt+HYNjhN6JFSEhim34yulTw9lXKbNw2DY/U7/tEcZ8ySBZf786cYwyJZQ?=
 =?us-ascii?Q?GtiAyic9/wLCgfHF4PcFcSRJx4HNN/b8wZ3vKOTFvfIFQpH+3szha9a4Kuj9?=
 =?us-ascii?Q?MA4VdFvzlMdl8XlPJoptYUAy7jvf7OD6M6ky0NWZjQ8H9kopX4OrvXDQxi1S?=
 =?us-ascii?Q?oh0hqav0Tdc3sGizQlqj4dFh+3fiqSBGVKS5u4IRFoaF/Ll8vEFFTQnbrFuE?=
 =?us-ascii?Q?mn5xnRCqmb8odKsFLHhU7TQavh6oeJzYLvmWlQW3r1JR5+b3i1txSGTYWhTy?=
 =?us-ascii?Q?8aWUXZGrSWT9uHcmq1XvGw8I1F7kg/bGGaTkXBxG0ZruO+6sf3Y4AcQsvNGH?=
 =?us-ascii?Q?ZXBqrDABMVKnUNn9Pilf4VYpbkf2J9bmlXXomqESUmCSPmKQL7ughaYY2xmb?=
 =?us-ascii?Q?VkICGcoH2QNJmkixVXDkr9bMR6zkze2IuYXQBQmqRiCHT9Hw1lZ6zzZ4RR+b?=
 =?us-ascii?Q?G1DUzryHXJxtK7ZI+moKLK1aEGpe62/cizNq7dzGt38/TxQPeVAYeE2ZnKQ/?=
 =?us-ascii?Q?70xFo6CKlJ8dbairJgIHQnxSeQ1OP3zJzCpEFuEm1Wf1LvOJuwNmMpmHPbkK?=
 =?us-ascii?Q?AkWzj9aO/baKQGk503mf7B+3GuzBgBMlbasU1721TwAOyGsyp2Syz5XBaMvr?=
 =?us-ascii?Q?tvv/C6BTsg4ElzVIiwg2IBs8rWk65Ta0qcftBh/mISwFJa5XzfecCWDq2p82?=
 =?us-ascii?Q?5+XkE17JUs7uYdzLh9LDQzvuMGFlTwnNBRwpskRDzT/cahkC9Wf2K+653ePL?=
 =?us-ascii?Q?H6W5VNl9fp8fTWOAogfzoj2n0nOdn+t0ZYYey64NtvPJ2cxrmXrlcIFZi1CC?=
 =?us-ascii?Q?tdOl3BHAyMz901Oy9l7t+i5xuXlOSzlzBkqz9xXSHWRxG3pIj2EfxzblPXBi?=
 =?us-ascii?Q?RvFbnXDybYwrQilSKFa0K/phAE5SunBdZSzR9rNaRbIzYmQ4Af6byUVQmZ4G?=
 =?us-ascii?Q?tJ24Lc6KJz5Ejr5uL8/ZPsrywM+sV9xO7wb0ggw5SRVfwjqtERwBIdwncM2I?=
 =?us-ascii?Q?rbLYB6GcBOLqqYQmQ5lKvaAaVET95rncnDisoqk1OogyjEpuBCdTU0bYm5Qy?=
 =?us-ascii?Q?rt+lRvaqqlTbRXt3YqUMrnQLzNix/Enw5m7Yba57nOoNPAmUe/Iv3Sf944Ji?=
 =?us-ascii?Q?o6O+j/R5mkeYgloZar/kLwk2HKSk2W0OFUBGF+qW+rTMHdvv4oBBkVzeDh4J?=
 =?us-ascii?Q?mnjzGaHRx6klkDqaE9bXvJqszbkloy8yGcKvEXx2VjWtMXuNRdvQRuqtHFc8?=
 =?us-ascii?Q?njOLZOsmWsCQOdX15gLsBFE2Moza6RFOrmLClcoZSvCAI9X3JjfcPc0VbtEj?=
 =?us-ascii?Q?wOk1fW0HasGHVzFlZ7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723c2d24-911e-4d80-7df8-08dc587759c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 09:28:00.9932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ov0Ro24a8Y1Tt7wMM+mtJSiik2vofN3KLxdrexbjDGRhyu0ZwbE6LNRD4QXLvQ/YFnYfeVIuLuooXWYK+sZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
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

[AMD Official Use Only - General]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, April 9, 2024 10:52 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, April 3, 2024 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [Why]
>   After calling amdgpu_vram_mgr_reserve_range multiple times with the
> same address, calling amdgpu_vram_mgr_query_page_status will always
> return - EBUSY.
>   From the second call to amdgpu_vram_mgr_reserve_range, the same
> address will be added to the reservations_pending list again and is
> never moved to the reserved_pages list because the address had been reser=
ved.
>
> [How]
>   First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do
> nothing; If the address is already in the reservations_pending list,
> directly reserve memory; only add new nodes for the addresses that are
> not in the reserved_pages list and reservations_pending list.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28
> +++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..0bf3f4092900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
> ttm_resource_manager *man)
>
>               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n"=
,
>                       rsv->start, rsv->size);
> -
>               vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
>               atomic64_add(vis_usage, &mgr->vis_usage);
>               spin_lock(&man->bdev->lru_lock); @@ -340,19 +339,30 @@
> int amdgpu_vram_mgr_reserve_range(struct
> amdgpu_vram_mgr *mgr,
>                                 uint64_t start, uint64_t size)  {
>       struct amdgpu_vram_reservation *rsv;
> +     int ret =3D 0;
>
> -     rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> -     if (!rsv)
> -             return -ENOMEM;
> +     ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
> +     if (!ret)
> +             return 0;
> +
> +     if (ret =3D=3D -ENOENT) {
> +             rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> +             if (!rsv)
> +                     return -ENOMEM;
>
> -     INIT_LIST_HEAD(&rsv->allocated);
> -     INIT_LIST_HEAD(&rsv->blocks);
> +             INIT_LIST_HEAD(&rsv->allocated);
> +             INIT_LIST_HEAD(&rsv->blocks);
>
> -     rsv->start =3D start;
> -     rsv->size =3D size;
> +             rsv->start =3D start;
> +             rsv->size =3D size;
> +
> +             mutex_lock(&mgr->lock);
> +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +             mutex_unlock(&mgr->lock);

[Tao] we can drop the mutex_unlock and add if (ret !=3D -ENOENT) for the se=
cond mutex_lock to avoid unlocking/locking repeatedly.

> +
> +     }
>
>       mutex_lock(&mgr->lock);
> -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>       amdgpu_vram_mgr_do_reserve(&mgr->manager);
>       mutex_unlock(&mgr->lock);
>
> --
> 2.34.1


