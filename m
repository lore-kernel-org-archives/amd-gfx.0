Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1465CDB474
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 03:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AA810E35B;
	Wed, 18 Oct 2023 03:00:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAB810E35B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 03:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju28aNz1tscyBgV+/BpDO94hzDx82Rnxu34zin4rVmy/TxrFPXHfSc/jwBP7h51+vGYhTL3Nx72Nw8LmN8HJjG50gM11vj5+ZpO0fodzsBXXcm6gYLYHOcmZFen8i7awiHV4X1GsjNqIl4vUvmFP/YrqIhB9ft+FRE64WJxEHHHyV7MOk3Rknrkha1lbh39uFBPwW/fMcvvgAdWztUjGEuHyEVhQT2b6Yp3+FFF6KHiyjGk1kZhtppgj6rCt389lPMDq441WymogOYtHpKQ24Ha6eM6rBS2znuMChyJ493vNrKSVegLb42I2sdqsSWyLrktF4HGevzoo5XJeF42CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DBiVWyUDyI1WnXccVYQ0ivyRKrMueZIfM8FF/oFjo4=;
 b=jbpic9OjQyGNDKRIpy1hTHD6xx+Q38fuiTAZA3bO8SniHP1GNJ07FsBVOcf4Nctii4wzjNTWiQpC9qyQ68Yepo4GukAulOPMa3NISsPHOZRHYzBNQ6gDuwBTxPf/18T/z3FetKMFUo0GM6DYVZhP1t8zYnGQAIa4IKCe5Tu2CnBdGEh4BbJYzj+ws+X5NXeYt4WdtNqauen6F9yJsMRG+g+W32Zo5XZFjPGjgZHwY+0NqLNtZXgQ4ihk5nK0tPECeSzjuaBVkCwnkZ9jtIWj9mjwgHDXNbwaMAAuRMKRIk4BD7XjRcZ9nDsKwzHpoc3t5d8xDA4Y+I0DHT8BFPCF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DBiVWyUDyI1WnXccVYQ0ivyRKrMueZIfM8FF/oFjo4=;
 b=DcHGI5SJX7pVE70b4P36AniJUL7y54CbzyxbpJgkLURgkAj6mNpLrz+qD1wt/A/agwt7NlqoqfMF0qcI6uOGvNfU33Md2v0qxc3rO0d7ZslYh5c5U3/596c5dm5vDkyOJ0wJjrmT3fF/eahTuBEDlWMEjYVkmdW4FoQL5cH6O18=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Wed, 18 Oct
 2023 03:00:28 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 03:00:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Thread-Index: AQHaAQdyhcEM9YZoFEeHQN6hRwrWi7BO20CA
Date: Wed, 18 Oct 2023 03:00:27 +0000
Message-ID: <PH7PR12MB87962D8997F0A360450D5F0EB0D5A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20231017143638.3203961-1-Stanley.Yang@amd.com>
In-Reply-To: <20231017143638.3203961-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7bb9da4f-da0e-4530-93b9-558752e1d879;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T02:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB8603:EE_
x-ms-office365-filtering-correlation-id: 18e643f9-68e7-4e91-f629-08dbcf8661b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qslTiO8xHZ1C0NKFekUtzk673zpYry70ry4FBhTw3EkIvy/OjIw1rSNL3fqIOCHc6N6wJG9G8nwjL0HRXtmH6TQnUSXbygBYrQpYLG/NM4UaYHUS0lKSrBOUXzUJUC0pNWdKfIX1Nmm2Ky5drSLE/KPrXaaqExUxGJ1TsD/s7DIbRX5xuyuN2ozFQD/Q5FgmqwgKSxYz1SNTRQOqqQoV6eCiztTh/d74xduQMo9+i0ZcnLvdv9wIe+AyNprqF1GW2TRkVc3J7n7EH2cb+Fnp8rBM6bwHCOJrk8LKi3M8qihNoZ/W70LD0th3RWnGn9NHp3GyB2ojy0V0VnJSIXEYqUEplrbtDGIsmRcFeYmhH1ZYaWm6q6qiE16FGJm6ieafO8jciZzKVAWdIURd4dQiaVePIwdMSjtMeX33+oy4/Fro/I4CiXMuqLvndz8MmgOFt2y0w8fRvMYbG2gQtXAaZXyp86RnuUaEBvY+OdTh/zKGufUDqcAs7So+Z4kqdb8uOg5RRO1zZ1p+JfCnWHSZMWT5pp3upL5N5/oLgi6cyKUqvaDGzgGHKlg6sR6+F4Pug45eg6EVv1y4uZEEQ+WeuT8tdHXbzGPxRkBw/fhTi6ji9lDC8kX3dvGuHBZ9UOzn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(110136005)(6506007)(9686003)(7696005)(53546011)(478600001)(71200400001)(76116006)(26005)(66556008)(2906002)(66446008)(66946007)(8676002)(8936002)(5660300002)(83380400001)(66476007)(41300700001)(52536014)(4326008)(316002)(38100700002)(38070700005)(122000001)(86362001)(33656002)(64756008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cj+djP/wW5iK361Ly9lPvD0jPSIXy6wd5OHDZYPo94Gtne7rb2Hnw+T6rznR?=
 =?us-ascii?Q?NlncCbRMgdv1rC2POespGk6OGGVMBlp4WSD3LmMFAclkBoCN98L/BMpzQNRU?=
 =?us-ascii?Q?SLFrvAp+2mVQj5gAxUSg5GxaIqpqeLRdVpulsSWlRqI2YE9F2pQJymdsv76R?=
 =?us-ascii?Q?dN0lJUReFdTUzF06CVdiNOUf3O9BX9eMo1RBd/rly5XpcqjIksoAhbUvvZ3L?=
 =?us-ascii?Q?Zpk0q+f1V7sQnbdukWoXl0vqmCVsGtfnjFCgSR7WU9mBQpDB8JFUWusj0msL?=
 =?us-ascii?Q?Ftu8CfbjgN3TZ77uD6SwxmG2c5Z2le8aF3ZNmf+e+ZfRmVBfMqiSnoxCyqsm?=
 =?us-ascii?Q?IH+eVaxODHb9pqYHFeiYRq+SUMa8vi0yX2uTnRREWBpaEft3IXpInwIB0sqe?=
 =?us-ascii?Q?q5AJJkfdsG803PsU/qqOP5juAiyiFxvz3T8wQVhFW5xoBMemZI6IOUB6PyWF?=
 =?us-ascii?Q?0iW2fiYWMW41iXFHctaBpnUUDlqs8Var0jXPC8jYnpc+7IonFg8btf34rVW9?=
 =?us-ascii?Q?yK6oYctuGch6/cNSq2DAjX6CLnqF5qwY7KzhLcln5dAI4x1ocGQjHgoSTLUj?=
 =?us-ascii?Q?PqmQ4O5dWA2w8u5+uhJqaVmaG/4tRiZ8rtFBaxLofBDEUezEgmE0h9l7su5E?=
 =?us-ascii?Q?YVjLFbtE/l96PBkMvc/QKYXaeNaL37x9Tr6EuRxLMo1oHldo6eUOOb7rlBZt?=
 =?us-ascii?Q?f7yh8mpGrmw96NY4Md+adF50q2pDy7x0EzEXDOnWe7oYIjnm25HRIcZndME1?=
 =?us-ascii?Q?YNkEiSt7KrIc3lpji7jDkz13Hl62bDa6LsE9E3Bjv3XogpeNz11zx820a5me?=
 =?us-ascii?Q?FstIm/13meOEZfQYN8gutDM3d6G7N4XOYg9QKellLAMUw4m6TyvgRxn2QPZC?=
 =?us-ascii?Q?x8/BiPqwP1xAg4xpKHDnZVfRM2mv7BIqZkNmS2VeS/1joB1zLb6ZGhgOg+Cy?=
 =?us-ascii?Q?6MJwilVFVaz7ynMO3iblonQJ4DvgSFirn5lIBnWtwvis2bdityXSGhdbTLFx?=
 =?us-ascii?Q?Tyf1OeDkwDPaKA81GDLyJnk0oOLQcqbjvQaI3YA1cf7nIoRnsmmpJJSVEJuX?=
 =?us-ascii?Q?Kf8L1PmKiZ+gT9leRa6TJdSbQlk7M783yWN+Q15GQBelmPq3mMX+ii6+5tvD?=
 =?us-ascii?Q?in2XGaWpGVbQp4ClH1G9WIbNXZnLPZHdOdENPq1dkAp56ApdmG7io7KmmGUE?=
 =?us-ascii?Q?FE9JvDnvZdIPcXQxvpsnjlvAANhiW2zjsIQswTY3+pwiRPO5M4FlKIOIDlvZ?=
 =?us-ascii?Q?Mr9fgrGKN8BV08syEreYhkGtKrdvoZ2PCirVNmvrygwINWqo78glF/5rlQrN?=
 =?us-ascii?Q?8gbnfMQ7jYgCTtDgS+zVLgwqDk/MhIfQcK9TfEyAHtk+wh1ze5nhyHuOdPoU?=
 =?us-ascii?Q?hZvqQXOvxNdgQxPaV7JwuzZjGcrOG/jsfYd6HtIdhm3HmYGWBPWyIftoVqjX?=
 =?us-ascii?Q?xfa9oQ2FME+RWta13V6W1v6GSHhtPv0HlAYdx1rnb5KBwrIGFBY6j65uUtup?=
 =?us-ascii?Q?2HKHqtOSFJhQmzaNBn6XJOtykHgT0AybenaZOJVWh/Lsqc85k7Lk7q4XZiua?=
 =?us-ascii?Q?Av80L03wHrfzyvkTyd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e643f9-68e7-4e91-f629-08dbcf8661b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 03:00:27.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oO6MMZlTtmf1ONYBpr2Rh/qZj+PfqrvIIu2+jN4+Sf00EllznrEk/UuIq8uPOc+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Tuesday, October 17, 2023 10:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
> during ras gpu recovery
>
> This is workaround, kiq ring test failed in suspend stage when do ras rec=
overy for
> gfx v9_4_3.
>
> Change-Id: I8de9900aa76706f59bc029d4e9e8438c6e1db8e0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9a158018ae16..902e60203809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu_rlc.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xcp.h"
> +#include "amdgpu_xgmi.h"
>
>  /* delay 0.1 second to enable gfx off feature */
>  #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> @@ -501,6 +502,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
> *adev, int xcc_id)  {
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +     struct amdgpu_hive_info *hive;
> +     struct amdgpu_ras *ras;
> +     int hive_ras_recovery;
>       int i, r =3D 0;
>       int j;
>
> @@ -521,6 +525,23 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device
> *adev, int xcc_id)
>                                          RESET_QUEUES, 0, 0);
>       }
>
> +     /**
> +      * This is workaround: only skip kiq_ring test
> +      * during ras recovery in suspend stage for gfx v9_4_3
> +      */
> +     hive =3D amdgpu_get_xgmi_hive(adev);
> +     if (hive) {
[Tao] the hive_ras_recovery should has default value if !hive.
With that fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +             hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
> +             amdgpu_put_xgmi_hive(hive);
> +     }
> +
> +     ras =3D amdgpu_ras_get_context(adev);
> +     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
) &&
> +             ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery=
))
> {
> +             spin_unlock(&kiq->ring_lock);
> +             return 0;
> +     }
> +
>       if (kiq_ring->sched.ready && !adev->job_hang)
>               r =3D amdgpu_ring_test_helper(kiq_ring);
>       spin_unlock(&kiq->ring_lock);
> --
> 2.25.1

