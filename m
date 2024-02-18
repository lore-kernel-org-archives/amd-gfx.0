Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767C4C48BC4
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Feb 2024 07:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF28310E089;
	Sun, 18 Feb 2024 07:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYvieppV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3256F10E089
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Feb 2024 07:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEt3I5dnpmBzrHKsWL207957eVIQQ4wxMGnsginnM1ijzefY/OpYJX1bFXQrRneuOnLRouXGg5MJsL7dGdtp738OUFzTrH7Mv/AhAgJqVENxK22GCsohjJsvvqDkfCxxzDCn6xTMdDbb8gHGIqOz0GxHtFkhXRdBO/+iph0Z/xVWmb35RGsEgulYeCMB/REWA4MQnxxqonjgANRgky8M7JJrwhASQxbbjwsaa9HYmP6iXYAg/fji1tT5Oh4ckprc5/tPD/gi+C/ChhPdAilCkVCmHeDY0+qhZSGk9v1yN0Qp8LFC8R1zhBXskWCtJbELjLDC1ws319IS4uj+Iv/dIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waYVzJL2A6oHagdvEJHPoZzceIkagfU5L6uS1IdqFM0=;
 b=PrNQmALTIRMa9KNpSj4MhLc4Fbu+rSxg469Ox/S3zBUheQEtFIqHmJ+n6r4ZBV3Rux56dl1C5SWITsFq9jdQ5OoyDgFv0J0pB0FcaYTB+2pC/NGWROrCmHOe4VXVs3m32RT6Aab6EEEmc9qu+VmU1qrcTkkzY+qhBqJMO2DT10NgZuVcaAENqUxhfl2iKe1QxIhQR0Am25UpLI7Rs/h9/4GO63NXJmDitfEZRB+Mu4X8pQSLN6T+iH+RhhTAWcehOPb9+wL+UkmRmo7j+5DUSTvwE3cjbRI7eJCENhzFLE8T7Z2gHGLtzciH3CGB8I63vnyVpcmhWDGDmfLDm/GbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waYVzJL2A6oHagdvEJHPoZzceIkagfU5L6uS1IdqFM0=;
 b=BYvieppV9ghmgYUsbu6uL6ZKSIP7dpplPJtXkJ04ih6jGg9jwxOvvkSAyw3k1mW/OgyPky+sRgzGfUTPkhXPyz2z9fvSwwpMah6eu3K1qCnhRSRJ81bvrJz1MKXAjma3g0bNhvqZVFxEwChsPrFaewjFJStRfhe9kgJMaSY5Y8g=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Sun, 18 Feb
 2024 07:56:58 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7316.016; Sun, 18 Feb 2024
 07:56:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Do not enable/disable bif ras irq from guest
Thread-Topic: [PATCH] drm/amdgpu: Do not enable/disable bif ras irq from guest
Thread-Index: AQHaYjyAi17KM39Km0GTRgUKJ5NIhLEPu2UA
Date: Sun, 18 Feb 2024 07:56:57 +0000
Message-ID: <PH7PR12MB879604423EC1694203313B24B0522@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240218073117.2185-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240218073117.2185-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=700e2eed-a5c5-4ea4-b4f3-54905f63d67a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-18T07:56:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB6410:EE_
x-ms-office365-filtering-correlation-id: a937221f-f0e2-4781-eaf4-08dc30572e6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6QaEMTwtS6yG0H9id7cRy3Uqq3ASDBAi4N7KWJvI5bJ4IXLi8nBpNuNbKOiYz6nF46xjXeG1vAXjzuATwUJH4Uu26ipiSWKBrn5jR6F7UCV0EbHtduCMoe503sXrimZpvF33EIHHDN8iLbTDSA6Bh89UpxS1jIt48iSz86z2W8Sr71sMlR+x3WPj0YbB+sCsvMwB5qQjSOt3ooXe2yjwved/yDltJNpItUGJbg0NI4rE5cnHZp2eygcSN9hoiOORwoKeOWQiQxRQSd29qdDd+3xGRjtgI7QOuZl0dqJWa3AwuoJzVavcQWLf0+HcN9peYDMhBrg6VpeDvdARIZmYM12chC7ehDa6YTC1Ou6AM+g9K7nSFzCI3DV1nbIj3waOcfO5yKHZJABPvaM9NSKkw4HyOWEDHEiHTCIwTKYOSLbzy0ux8paWi8WzYXbVyF2uCbecbLJMriDks50+WFTLqFEUZZi9Hw0Lgb4MOx/SZLktWn8L1aq4bcwo7oKnQh9QFYxFxlbbPm9LrglmrE0nyNEY3EJRwrvMOVH1eWj9fDDvmOTXQmVOsmbdmoOHEsfvA8pmZpvJgs+CJZzxBZ9vf/Au9u4hahZ6jHj4RD3cv+JqBSUc6UWhloaBo7HveGxG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(33656002)(86362001)(122000001)(53546011)(316002)(7696005)(41300700001)(71200400001)(478600001)(110136005)(26005)(6506007)(9686003)(6636002)(38070700009)(83380400001)(38100700002)(66446008)(64756008)(8676002)(8936002)(66476007)(2906002)(66556008)(52536014)(66946007)(55016003)(5660300002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoUoxLEDvfB81JG8dtvmjGv5mXWD+d/YwzbFzbEMPgFVV6VpjCUvzVG6JAiV?=
 =?us-ascii?Q?5pWG1dbf7d84g7ZbAUeVZc6zXzlFUAYq2TD6tKdSFKLFT24kvnYgCtjbGv22?=
 =?us-ascii?Q?t1GhaWLK3R0jBziqqqrDFh0yrBhVhr5i738cWxuwBq+E44PaCkuevhyLKvPk?=
 =?us-ascii?Q?5HpUk/efSFUqRrOaGPOMLEMqjK4GDI0lokMGJG+YMBHMv6Nxr7Nh7S+TTmgC?=
 =?us-ascii?Q?7Ca3VKJP5B7DOfznF42SJVNwgxr0pHmkDMrJQHgyGUDQ5Ju5eWOc273O9XJT?=
 =?us-ascii?Q?t2IqIjpciUDO8c07yCS5MEWbZvcftqJPMSAgm+ZoVIcQ8bxhYX+5AxoAL/M0?=
 =?us-ascii?Q?HQjC+f7ncXpkk3Bt+1nO4xIpa39m8pYwtcruVKUxtbxowFiK+gXblvEr+p7L?=
 =?us-ascii?Q?oLm+6qFLpS0uqboyMXAwI29NW9o1xL/P3qzq+06rWP9ugLDkIFo4m7qb7WrT?=
 =?us-ascii?Q?F0sZYj/YqvNxARkRtWqaF5prlw/hQ8+/5qezgCkD8gyuuqlC+IgtwtQ6tV5H?=
 =?us-ascii?Q?mqI8PcQPD/bgbHFjgQS/5RmJagx6CdGeDzNqinIK2/O7bMH0byvjjdM9pCtZ?=
 =?us-ascii?Q?1naIMAAo5DWoaHpu3ZbsjN2HM2XEz1AOosYsfWbdJkS3MIw7Zc0omQkGIUCS?=
 =?us-ascii?Q?gLdq2IJo/mAMaBHYDI9YDVqSAMZdvBvlc/FHSG3fkOI4TZxx7rWOJhYVqX8C?=
 =?us-ascii?Q?BIaavQPry9IIFwBJtpQ/QIXgRqF4mfvOQ7jb11b1hA94AnDZdWy1Rm8UhrVf?=
 =?us-ascii?Q?MwMLOBv1UyT2gMI8yhvCog6F8xLN6eKnceHhC+PSMw3HM1pUBi5F/7lVau/9?=
 =?us-ascii?Q?Zra1oWcMUwLqlKBLiaP0aAMOE0/loztIzYgfKU6d3VPi12JofWwk9p5wnJkx?=
 =?us-ascii?Q?Wkz1lv6HhcJ6QHw7ipYyXWr5eHbBouPIfIQZhXcjE3kFiNb/qwyBLOvLXS3L?=
 =?us-ascii?Q?asJK9xWPs7EKrG3aimaIrBbRu0ixHTSAAs7SuSTAR7jJxuEGVwg9cWR7kjZN?=
 =?us-ascii?Q?MlkclaclapTTGwmIrfSM2gaE6THi2cWRrOHw2nFSS/EigQ1ThyiqfaAzkH20?=
 =?us-ascii?Q?ywKrJj3UQVifYoOCAk8YPxOIar1+Afhk1FcpjY4kvwHLpkLAeW/XnRO88aNZ?=
 =?us-ascii?Q?aFxO3Q+U6oqfWlfF+knYCUDl74FzqKJUhR5rxfBFOFTjIAfBf9HLSAJzfjXz?=
 =?us-ascii?Q?6RD4u6WnAOpKSiDf8kQ3mmLgl+0GkKIZriExT7B+P7jH5+pWFHkWF/yYsac5?=
 =?us-ascii?Q?Yx7ixYSmRQlCkVcm2NloDqz35ZYv8qnVVbFGs0DdmghLGw7pohy1Sg0zTBlB?=
 =?us-ascii?Q?J36CY2RfW8Q3L1KoyPJa74t8dQPCuTxaWcHSDFhDZEybc69owIdVrq/fTbYQ?=
 =?us-ascii?Q?QSXPGkmCLc3mAN1uYla8vk44fn7UCEI6RgYuQZWErT+/tuLVJUbLFQkFWY3j?=
 =?us-ascii?Q?/EyvnV9CqpWqX4ex48jgNaQACUIE/xeGRG3VqWQs3TkVOjJBiuIX3ZkCmXNH?=
 =?us-ascii?Q?cGUfAUcxxo9lK/IU7mZH2VSDdbQpFUb7qN8Bx/+F4T4LIjjS5tfkJD62JMjw?=
 =?us-ascii?Q?FJl7GcI1u7rWVDCOqh4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a937221f-f0e2-4781-eaf4-08dc30572e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 07:56:57.8780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/Bn9g66PMJuR85KqMc4oNa1Kqrc/inMNyLhpOU+3jvjow2ywamWaTd2RWBPCD+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, February 18, 2024 3:31 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Do not enable/disable bif ras irq from guest
>
> Only do this from host side.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 15033efec2ba..2c8702560090 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1278,7 +1278,8 @@ static int soc15_common_hw_fini(void *handle)
>       if (amdgpu_sriov_vf(adev))
>               xgpu_ai_mailbox_put_irq(adev);
>
> -     if (adev->nbio.ras_if &&
> +     if ((!amdgpu_sriov_vf(adev)) &&
> +         adev->nbio.ras_if &&
>           amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>               if (adev->nbio.ras &&
>                   adev->nbio.ras->init_ras_controller_interrupt)
> --
> 2.17.1

