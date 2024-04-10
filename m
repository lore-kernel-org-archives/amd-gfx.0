Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4641ACD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A915910E3F4;
	Wed, 10 Apr 2024 21:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vq8ojxB8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2134.outbound.protection.outlook.com [40.107.220.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B4110E3F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moJ6mSdxopArJZaL0SB0seIladZua1xw+w6synt0G214bjWuueZdO4ataDr72TmK0d6sunnpqTkKT3MvDQz29d0Z0eI5kCUtvHQX/7VxBSGQDU829TeCCf79Sw3+0KzTkfIw2upRrw2thpIppfJFqG4rSjbCqvmx1JGsoaabyho5GNjsLCVEiVXqNCctfNioWvyMYrSkaQKslVlzRLBQ/KLk1ekMnvZi1ZBiN4SDwDr2y8AVKUAinlZ3Jr8I+P1t8YaI0EY/tmFLyzVE3nPhBf3XsJARSgmXNLIvOcsl68v2AjiUNYakrfLIBD/qZg0VUC7gtMVXbSSC7vT0bjBXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZYkNeyszjnPv6ink60CYgfGwi6X8dKtOj0Et4C6fpE=;
 b=Pnfjo6Fc7HjOvIQAFfuWTGAJ+YKrhbLYycKQ0kYUf9IHNPJ0vPuunw/v07t8+h87/gZ/TJcIQGT9gAB/K7xwegY4Sc1rYAZ0HpgN/F/hrEc55a8YkonCtuE6ZbyUyZt7PQiJ3G1kvHBlXMjhbskJMYghHAqxqokgg0eT+QSId66qVeTwk7W6eFq7ETn6/RK5qqS360KFZBRQ+NFB7PgWYfqWkjV6fE8HDSkkw5cbTJhI2aNlAIjztHURhHjW/TbqVwYrKDKi9NMdV/TB71h+zChfdd5hM9Z//Hl/j3r3XToAhAT5tldH50rxT1e3NQsGQAS/iekKr+TmjOwJis/gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZYkNeyszjnPv6ink60CYgfGwi6X8dKtOj0Et4C6fpE=;
 b=vq8ojxB8h4U/2GovkqpKVryd9mrtOjFmjjWWeQs02WqnnOBUlTpRayoG1TRnmkvoACf4BpJ+PaZe8V9AP7Q1KuFibreZVae3RlmrZG6z+LvRr10+v6k/FAC5hWaVFhQHb3u9nCJnwv5F8trdXxzk/GhApAq9f87DRqVDtol6fhE=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:08:58 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 21:08:58 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
Thread-Topic: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
Thread-Index: AQHai4JzMHSglBUCR0SP2+nMA/0PArFh/yCA
Date: Wed, 10 Apr 2024 21:08:57 +0000
Message-ID: <BL3PR12MB64254EDCBCAE40727EEF7744EE062@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240410200432.1578125-1-felix.kuehling@amd.com>
In-Reply-To: <20240410200432.1578125-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32924c04-6807-4590-80b8-c7df60a78b30;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-10T21:07:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|IA1PR12MB8406:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHSyGrtKPZQm0hYAWjgOl4u4H+g9/ISUq+qjzhDmYeRMKqS4p7eBzO5k4l2/bRTD2CwCokcNUKfJQMUi7v0ygsInNO+hJvZsv/vuk29uDyoj1XwYVhdpvaCuIDww2Q4K4mWV0/Nc+APS+cWOPagn6RwwppHHQOA6CqjgS/u3/dzhfqOPY59jImyBjeX+f4+7n0PStymV3p3j7N67PkZ9Q9C0AkEnn2Duh6zoWGU0rs+0WQucdkeEQ7a8Dyip24N6vlgxCF5wAsOVAPsYASC2L5Dui+vFivU6/Td4/XibdaZWxfHkKRrDCnaK/kYi2u6ZXZHWX+TawMGHjspuRqjlNvp5MPW30O4kMnmuMDZILld/yNrudf7ttwEOLKLoG2fXB5inhUclHEuhmYrSYQxRdD9BX5lT8hSuLKXw6PEouS80GHFvnRbm6Jn0Sn5Tyidnlr/LbkYk59eDNzK8u230I+5+ot/iqaOf/WlPA4WHETlqmpulZsfmmhwTfKT8L6VOvN+X0o8KYocj5yQr5sZGXq42k6eGodyFBeYtW6mRajEgBTzXQEYVdnLkqZO2vIPbDREvvLlR4ankEywGUX9A3RKHcWES8W58alJkreFM75t5NpOFazjqQvxmeKZucp109GE/1y3GD/CXCI/yqRyFsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ikfI/Ukj2DC/fUZW9xH57I4rWNI0XTuzdF94Y3dajLtFyZATcnA4Cmm3PTZi?=
 =?us-ascii?Q?NwBxc/U5MBsshGaIhudutyGLy/8iD9RiDR2mWPwG7RKMd9bEepYDY4vEx59c?=
 =?us-ascii?Q?81cgxtCgPyIqrJwxkXKZ4J04Hdk4S0J77zn1AsBvyj9GmRDNidV3hUarPtZR?=
 =?us-ascii?Q?dNp292+o6MSHT+T9Ku6xNcPM2fgf8VKqqQ1UY459CcBc2H41cROTPdvUDIwO?=
 =?us-ascii?Q?byngx9L9+BbfABcGXF4bsCY90hfx2rIjfuU8pr3qSTCE0dFKt25H8onnuFfE?=
 =?us-ascii?Q?SCspDdNVhq6rHMS1DE9i3iQnpgBBhzVEFdMWFJxtyDDkNuatPwoaxVKXAxQ/?=
 =?us-ascii?Q?/GKtylg8KclawIB42TYvDIZtMNFspWTZ2KZ8brB++G2WEHxWnxeXTtQNsgHt?=
 =?us-ascii?Q?yW8/OZDXxRhzJfUBmFMXNiKia7svSeAX33lW1Mlm5LRy0/Vr+udMW8MgLuf9?=
 =?us-ascii?Q?UAZZOE6yuN7gQHxfN1SeITkrozdnbWlK7G1Z4tqKKE5hADyUv0/d1HnPZwst?=
 =?us-ascii?Q?96jAiM7q05N/whsiwiKysz1N+AN4AbhMssqYLC1DfUkZny6MKuNA0Ul+HiNJ?=
 =?us-ascii?Q?pvf9iPNHUdGolQoMj8HcxuWcPAiHvN52Y1U8/Ej/NXmTzOivBPGC8wWmeojl?=
 =?us-ascii?Q?mjgPVewU9TE6qRLXwlEZepsLP43fAvTrCZgtRonwiibk1r0myH+uptbPFUR7?=
 =?us-ascii?Q?iZUySUwnLwRldtQ926ji1AbyK3gQYpDAeoxzcwygW3GqGpLBAghLcMX00rqC?=
 =?us-ascii?Q?fTHvdruXkEWMrcRYZNl8IIL/Qiuhwer08FiiOwjqFy4tEex0j1OnBcoX0f/t?=
 =?us-ascii?Q?AKYiZX6+wPNPYw0cK25t1ummy7xqOhIb2eSaqqo59B+k/uGxfx+PxFfkPjNT?=
 =?us-ascii?Q?eZGojjnErDeANEKz4yiG32CfDHMJsy4EEqn9DOjujQ+p7h88JJGccpyqHFlG?=
 =?us-ascii?Q?2pcurOXA+7xvCMBTLjqXDp+jcdaY1DMrDB/t5JwQzZjKpsNRECBhg75J3imm?=
 =?us-ascii?Q?dX0nwI2jRn1bqD8xmYHjjdrwl4xqH4jCRMOVamV2zbJdWoL/1AkaEEOrheFR?=
 =?us-ascii?Q?Qw7EZnABjlW0rXfDWGbcBunEtP+YsQVd6HommT6bSic4FR+Afvw3eytrm6eZ?=
 =?us-ascii?Q?HGJNeYKM0TOLYGG9ddmO8zFyJQKEoXjw1FisPtTRZacKRD+IN65clM+b9MFm?=
 =?us-ascii?Q?fUGiS4gMWENHLIRH6Irckz8ZH5yxkxsCCDb6duyFhdYQthxeW/OSN2GeRFQA?=
 =?us-ascii?Q?1C7L9Z9CpdnRhSmn09ESAJtctBa797hz6oAPEhNDF8Nk6sO+a1FxYZD28b0E?=
 =?us-ascii?Q?7WRg/L4aGqGNWvXF05rKZxWgzYrYlyqkPc9/JrvwP5TPWTGjiTnNfvKy6rw2?=
 =?us-ascii?Q?/hMwsD9HMHbjwzMTmJN7h27WXb+JfrzX9M9ph+aOJAgpbd7Onb7fpQWvLxoP?=
 =?us-ascii?Q?Eof8B7MGLi81Z5J72rNbCq9302EtdlGfo8g0A8ZetYOxW+c60wxCzBAkpW6m?=
 =?us-ascii?Q?PwbK7DQZNuQ01b1WXuhhhREYqrkXDShGSmL9qFGBoO1k4kjmzAfD2xgak5r9?=
 =?us-ascii?Q?5f53Ok5MbUMR0teETgQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952c4fd2-8b7d-4005-2e26-08dc59a27012
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 21:08:57.9214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnSGtBfsIO+HYbg1+YHV2GLIxq/bBtPG3TfNIb7H5mfLmmbDFMu718rkb8XrRwVUb8qzhC8C3b6GAG0Kd3WSVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, April 10, 2024 4:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Fix memory leak due to a leaked mmget reference on an error handling code
> path that is triggered when attempting to create KFD processes while a GP=
U
> reset is in progress.
>
> Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and
> disable")
> CC: Xiaogang Chen <xiaogang.chen@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>


Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 717a60d7a4ea..b79986412cd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -819,9 +819,9 @@ struct kfd_process *kfd_create_process(struct
> task_struct *thread)
>         mutex_lock(&kfd_processes_mutex);
>
>         if (kfd_is_locked()) {
> -               mutex_unlock(&kfd_processes_mutex);
>                 pr_debug("KFD is locked! Cannot create process");
> -               return ERR_PTR(-EINVAL);
> +               process =3D ERR_PTR(-EINVAL);
> +               goto out;
>         }
>
>         /* A prior open of /dev/kfd could have already created the proces=
s. */
> --
> 2.34.1

