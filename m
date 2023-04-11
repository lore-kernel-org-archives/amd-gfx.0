Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A4C77B6F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 15:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E26810E195;
	Tue, 11 Apr 2023 15:45:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3CC10E195
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 15:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7pS3CIUv4K9UPwBDU8tKI8vJquOAVn43iJ8iiB+GXpkN/2kcP0e23UWgtNd7tHWSnWA/fFksuLjRVKM8ojinAGwJnZDd7rIhJZAnYcY9y6Qer09oXap360uJd2uL1pV03KWN0EiUwOTf39tr8tYv4EF5ubHy7lNs0EPUR5xWro8n2lI0KJ5SDw7F1KjrF5hrXo4To30BhxyF06wJMtaknAM6Piig+4+2NuuDPBHf9ezkT3sQSDnZMsw+/3mabLV/KnkRYa+L7DYQKAkqFLXmmsMxN7fTIiwvFso6nMUPV8CgtD4hmhPkmG4ixCM2k80uxXGeuW0l5+1mgf7TuYcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQOGPvOKZooPHhxlIbsYgKhdLYBveTeWVD6pnGDxc7o=;
 b=InZwhK1gjuXSBDVMPSVb3Hb1cwpXIjZwiCnhHf5j5UUfR1SyPCUPa+jf9Fc7aG4IypOkkMBZsB25Q6KK3AzWYdok9hRK007Aq9KhLbJO6nnGXL4Goqu3u8ehC/aYlAUNYPSqOVybVxgRJjVVp8eJG/+pT7CB5PzLAzqy6+9nUbGDHhVOuleWQCdaXeHGFPqkgypl2yLEMD3CAS77QbimMN1R0mLfVw2z0rgQgt6ZDmgU9FrxugiiVT+bU6jXflfT7VVlgSwnNqrjTsPIgOxjCXZG6oknvSefiYdbDzZO79/6Lqd5lwtiIYt1hJilfMHh+DhtUNsg1dvCT9xxFeaYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQOGPvOKZooPHhxlIbsYgKhdLYBveTeWVD6pnGDxc7o=;
 b=4NhvOcQCFEEou71WzBGRtZ8Y9xfPi78ZchcUJZK9AFvrtnUlWgllgM7KzWQ52jrsfRkP8ojbfdxXvT7q1IU9cekin5auC3ibUSxaCpCHbYGv3rllGClTLSbl5m5tnafOEG3ahYbPlQjtgtM7Z/zbDy4pNfQMNO7tCTtLH2mzSuE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 15:45:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::34de:5470:103b:594b%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:45:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
Thread-Topic: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
Thread-Index: AQHZbB5cjDe8qwOcSUu4RWFPW/tL0K8mQI1g
Date: Tue, 11 Apr 2023 15:45:10 +0000
Message-ID: <BL1PR12MB5144200BFECABCF7204B9BBAF79A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230411023534.2439943-1-li.ma@amd.com>
In-Reply-To: <20230411023534.2439943-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T15:45:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4138af36-ecab-4b72-9ed1-ead4c576da47;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T15:45:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4d8078c4-1ed3-43f2-ba58-947fb2cc2050
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH2PR12MB4040:EE_
x-ms-office365-filtering-correlation-id: 939e46cb-8a5b-424e-d30e-08db3aa3bbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEtFg8hsIr7LoYqP9t5r4BdNSZ80Ke38L5M14wFSv5v3gAeNG26Qf91ioLWR8iGB5c243XQar5NCd5oOEcz1YL7YhMNwp7VTN9UlimC8yHZDb+W0qkSL/7OTj0wY7tDMJgY8RksBPyriPqVIpPJcig+zJWHDYgr4O++sR+GOM1RyLqSd76Xt7F+XU4ncsubx5quvvFfz/rbbgd7nMEm5hfxGMc0S7a3Czg+Z657+nj5wyn1bx5Qt5FAqRHwxvjia0u97j7FaD0huWduEHXzHRMfB6uCqANLIcboWbOG8gJmAxw3MAfTQHI1XP1vHLTYZ4AKL0OMqSKnUk2g9lBhKVrJdyzb+k86sriBVGWa6apqK1xr+FNGyZAr61ht+gMqvjHoHdFpSEE4J+pGqhs5r0OjJ522Vzj/LgeVXsxLxN+nsrksMDwSdck4et5r488RCMUXW+XP0DHjQVpbU0TuBY1KVDdllvxcd/VzAOeodbBJjjiTwFVJ9diAaGZBVPzq1yQu4pWgo0Q6f8WXKGrXuCTySxvMCOa0N6ES/WDMptolDEUIXYLWZaEuOalU3Zcq9GzNPT1RlHpZzVLIkI800jaEpHCQjstuI0bpCfCWmBjAnmou9kWo7SJ03lm6+YyRn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(71200400001)(478600001)(7696005)(110136005)(26005)(316002)(53546011)(9686003)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(52536014)(8936002)(66556008)(122000001)(86362001)(83380400001)(55016003)(33656002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xy0ufGZxpsA6YbUtwbZ3bVWLrASlq6OMnpnivdL1SFhqU8Osc7Loz+VZWcgb?=
 =?us-ascii?Q?7UTPS7QWcIwaWvfdH7MsV2quCAt4C6iBNw9M3Bk2jfz8fQqf/1EYjxU4f52I?=
 =?us-ascii?Q?U+5/IUnC55zbH9PrJxtDes9DtAYj94HTXv2JFsaJPK4euaazXWQt7jOTpl90?=
 =?us-ascii?Q?m1rgrY3lCWpPrlOM30DL+yH2KqNJ4f1XKcYZ22O/yR2ONjGZtX2QOrEixDTm?=
 =?us-ascii?Q?W3tk6alqTblATwREsm/0k1FCPYrdTj10fsCX/TxXR2f6Ai2V4EW3/lKe0iSE?=
 =?us-ascii?Q?Hgkiyg+yOjGRMDRL6ZTtw5AQ9ntecX+VkNh7keca6yWxSTGU9+PTZ42gMFxJ?=
 =?us-ascii?Q?2q9P6YTt/LoehhrjV3BT3YIu2O8ZULJLvUzq3lfHp4Y5zyWZq71BNzQRdAH8?=
 =?us-ascii?Q?bsLRk79R6f2tsK6vhTEsRAswLhowXS1rNdkiYXajssf8ZZdWPqT11c9w41i9?=
 =?us-ascii?Q?MsTGdsaga377gYRX6eh16mDu21Vx8+WOZF2KW1jP+KfFic6ws9aB14/C8St1?=
 =?us-ascii?Q?esb+S3Ixvd2Re/dHmBSd9hrGhISb5q6GPYnkNInUa7JHvQ8UH3bEpSLtgAgF?=
 =?us-ascii?Q?I62QkAGyaFBD2wVVSzhgH2YB2APi2A5W0tQQ1bsjkeeeN2YWHn2E5qSM/wxE?=
 =?us-ascii?Q?XHV5thZvZnZEwfSoWpPEq2xcIVfCgIVIZ5FXRwMRGgzegnMWufz+BLzbCYbg?=
 =?us-ascii?Q?4dgFECXzA5IVCS5Iq+BDMtVJ4imQuM87xSO8EXrxhHbIBhingr/RrWUOTyYD?=
 =?us-ascii?Q?4mbsQKvhwV8gvTGyp0f0jMEpmuE9qb0ZY0QhWrI45upemlcP89Y02dzLYws7?=
 =?us-ascii?Q?eeopxVutMoL+5XR6gPg7DmbI/R1YPMYlJlwW/P2C+l+aWsSxj+9CU/LBYOl+?=
 =?us-ascii?Q?NUUHhHX6aS/mvJwkscg0IdgVkARhUMZFOolu4qc7Zl4uZpsjMREgoZzUZ4e8?=
 =?us-ascii?Q?KegybrVEUvFDCc2LZtgfAbpCnO10DJ59HYsGEt8Gn7HzTuOxaOXv8lQD0ReQ?=
 =?us-ascii?Q?wNJ53QB7Q7gnCQB01+ES/Lpezt2Iso/h8xc6hlsRtvSO1DwxdeQ5B606SEq4?=
 =?us-ascii?Q?X9WwCzcj9ga7d4eQ5UFDQ36NVY1LbKjYyU5uYE4Gy6IMUHthu68wdKxet3sj?=
 =?us-ascii?Q?l+Vefr71OyRC/hYyc1D3vK94RApHYjDapy7fSJuTxsw+0GWZfE10WV7CMtyg?=
 =?us-ascii?Q?c6oAisGxQcdaQxM/Sz3BUBDh6ODXTz0nH33kJ5Q4DbzGNX00uT6PuLXk581Q?=
 =?us-ascii?Q?L1oJwoicqjjq844IQbwMuwXRR16+tG7HSGbZ+cxQKHT9q90EdA/5woGb1J8p?=
 =?us-ascii?Q?+SLvIMSqFL65HqeQsvH0pH2ndaS5j3z1k5g2q4erOEd+9aLT/O3TEYecmw7L?=
 =?us-ascii?Q?msu4nn/e0Z5tk+vWIGutpyaBjGMQddeA+5f+EmQZ//79BDltg9/jZxjOe1el?=
 =?us-ascii?Q?7D85NGY3XfFlu38XWoWaETYjZ8wLmNqyaqyaUB3SMdA4Yzdi8sS4gOUNtd+P?=
 =?us-ascii?Q?48YWcQgg8M54szRUNNcsDbHfuXlpoq8+ucpjDA0m5Q24+7f+lj49LkGhc8YB?=
 =?us-ascii?Q?0v/aJ9ZcfYg9BFySjqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939e46cb-8a5b-424e-d30e-08db3aa3bbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 15:45:10.9604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0jJTvh9O/9556klfF7K0XgLZVzaGEvamFabMF5e8UvtrxPHedNXrKImclhitOThqlX8rqN5SjkCeG0Gk/NZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Monday, April 10, 2023 10:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
>=20
> Rename MODULE_FIRMWARE declaration of gc_11_0_4_mes to
> gc_11_0_4_mes_2
>=20
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 67f7557d545d..7e8c15cd8dc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -40,7 +40,7 @@
> MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
> -MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");

I don't think you need to remove the old ones, they should still be availab=
le as a fallback if the new ones don't exist.

Alex

> +MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
>=20
>  static int mes_v11_0_hw_fini(void *handle);
> --
> 2.25.1
