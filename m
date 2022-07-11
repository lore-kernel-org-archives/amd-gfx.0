Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E8BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 09:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285D511AEE8;
	Mon, 11 Jul 2022 09:07:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE44112A99
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 09:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK1ulgJ7RzwgmPthZdglZz/c05pkJuxpR9qEnAOhIGQToXOEQR2KeXIwoas6R6U2dGOpEdo3BnJDxGT6Nq1YrngFjwcJj1gNNaBYH2j0hLKjitBNn22uGvy90t/9zKeAT9/anu0nz/FLKn52dYO0quZIPWLA57fQcEk2GyHGnavs0VoD3sXKxhw1k66xkbOiOhKrPd4swN3M00PJ0t2zAGGo3+5BFC46h9uT+Eu50Enjrredp3s3oGYQ0JLYSRMH2/bVxVV4hQTfp2Mj21IltvPqNtZKqdSRFl9QB7mLMY1Pyq2h7HpzhTFFiiKB8mwJzJZ8iAVU0YkFCnpz5U+PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhT7DBDYZAjmtbisgzp+WQV42rP4u84xer6sW1j8T1o=;
 b=l0+ldmG25v7wEhi30YOOF9slgMeVADYuXK8ocIqb5mSRx1GiLVK6MfV1/o3KUjnv4cX9upLdUF8S1OECiSSNTNvoUOuYTbmlaljqM3iydpiX6kbhB/5WDG1w78EkSpaZrAXjHTWOP/ORtNjyW3zGRMINkO6dJ8kQIlcaisAgrdzkleVxTyfB0rOXR5E5XkJpRt860+ZbzVXleKDLrCd5e7mFsWAxsdhi8RZxA6Unl9kceu0A07CTkW7P5cRWT/U7qLKtAiOZ2I4HcVgj/XRmAqINeg2sXy1U2ovJZLBvQPCbEwfCkk0RjbthLIb6FsoI8jMtSzJDbK6SjHf6uljf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhT7DBDYZAjmtbisgzp+WQV42rP4u84xer6sW1j8T1o=;
 b=DbWInvbW9ws8N/AlK3rXdPvY1LJe+/V9rmQmUw1o6PZCGHq/TlEhohZBEUOgkOrTKhWxJ4pfZ4X6+VJw6D85acqMyoQ9GQhjBxTSK7KARbbCBWdOcLvMdeqQLyrg9y5SnSShdyxDx/33Sy2Tahz3pVVtPHKQiZLPBbaBIC05dY0=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 09:07:47 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b594:e040:ee7c:92e4]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b594:e040:ee7c:92e4%4]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 09:07:47 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct the MEC atomic support firmware
 checking for GC 10.3.7
Thread-Topic: [PATCH] drm/amdkfd: correct the MEC atomic support firmware
 checking for GC 10.3.7
Thread-Index: AQHYlQPwO2xFdwYag0i/Qk5G76Rjn6144UGQ
Date: Mon, 11 Jul 2022 09:07:47 +0000
Message-ID: <BL1PR12MB52376AFF60199F3FAF58637FF0879@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220711085504.2143925-1-Prike.Liang@amd.com>
In-Reply-To: <20220711085504.2143925-1-Prike.Liang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-11T09:07:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9cbd0979-04dd-4fa7-9d0c-e04ba159d8e3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-11T09:07:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7cd99172-4206-4c6d-8f2d-59784643554d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79f49df3-f510-459c-f6f2-08da631cd2aa
x-ms-traffictypediagnostic: DS7PR12MB6094:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUNfGHuWtXyhvMO8Q+l25e7MOMBDWtVplmkVGDCTpijGG+NGCe9B21OZ+m7+zz8Avo49f6wweC6NXxg17DxIOwJQ+SkWD6Q/DMYZbI0YiVO2mDhE0lLK1J5SjjXmnritstM/49M0Qwt4BkDlwxbs1+pR5KrAEabZCFF/7i0qJcyzaclkEUtzRJLJRHZ0dDT9EwMG0mKRdnEKae4ZPKjAuVJTt/pHbgDgQm+dhRtXts5+/pm6RDvEE5grgbaJKw1tNQ9+ohZ2Nyo+3A6hrNPrrc40lBajGo+gq126tuLG+cVzgq2ZMyFN67oQcSn1+0QjEddOe4P4sLSfBM8I3lnHAkCyxs3LCbv1eEpJy581agsHT8OLAVfGAK2DJxv3io5f7NEZqAH+egUTmC8AquYRET0sjxLbgkIWWxswBz4dyrm+I/Wjpn3pBMxEoYTxb7ovc444pwgBzvRt9WSclQ2zyx4VOykZY2FaicoqcwEODtoda+WWtbJPc4MLMSbKcV5yB+8hxMlwNHf6XTD19+c3xzjmu4KbOmTa1H6MqntMQijzDncWX+jDYbILtAfJ0Bq4QxBWDsmKgM0AWXFOhpQOpNsfeLt9bJLmkTy9luiubpjC55dEhRVODmbxHVA9FtOZK1rSr4gPJsfmdEt4wIlPLMw6oWWhI0uZcP9pqD3j1OJz+yQfhr8x1vpQYGAsIGeLLZOG1M+Eii0WKbayAI9oFLUwrw5DUhu9yrIjpsdTvS6g5mAvlipd3kC3XTXopRl+IZDnokJD6a7lSUHGeQRjcujP7ZGXWKVG4bylo/OG0QIOZg3BZvWxkqivxq8JAMFk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(2906002)(478600001)(33656002)(38070700005)(83380400001)(122000001)(55016003)(66946007)(186003)(76116006)(52536014)(8676002)(86362001)(316002)(66476007)(54906003)(8936002)(66446008)(4326008)(66556008)(64756008)(5660300002)(110136005)(26005)(71200400001)(38100700002)(6506007)(41300700001)(7696005)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S71a61qK8B8GoIA1Rse+ZicV0szeVg1XEh0zMfHPI0TQjsh8uxfq46+q/oyv?=
 =?us-ascii?Q?hPtdUZXYKj9ro3LLYPU385v+J1Mq5n11Wzffxj3U0LMRPar18510lc3WTUp4?=
 =?us-ascii?Q?940BOJRKJ4n4hgrbF1uRtIJ7KWD1ewN9Z8glZtFZkVDM0ROK/IxEohN71S5v?=
 =?us-ascii?Q?+mAg5vRN3n0G2yChgT4a8ZYuq4mxeuRH9gNIp4/JJ0xNl/2hbbSypFfl+1CQ?=
 =?us-ascii?Q?14Xm5ryx5HoxpCjgxAfanSyBsI2r0lO98qmfcrP4DaSHNGYLUO8SfAf1x2/X?=
 =?us-ascii?Q?xZeK0QmNea9gZwTUlWuf8bU30mQvMpmp0vgioN/+Yku3pV7DzgGB3Da6Zu6z?=
 =?us-ascii?Q?1rbjImurLc589zZFiefuHso+b+rhVaKgiFiYXYSbcf0XBZXnm11I2WJ6DV9e?=
 =?us-ascii?Q?b00f/U0Dr0FT10N1ld99BX7BDOFbYzPqFyH8NoOzvGMss/jVIRJgWhipdNWe?=
 =?us-ascii?Q?IO6V8SlweXwuHR+xJeCUehNko1jXT0Y/eLW+DJhYnzVpazrUxOb7rFCLQdqf?=
 =?us-ascii?Q?6m5nsYZ+iKl7UPUx562P4oXxFj12GTWLVXFxGy/Wq0MsByGdJ39JweYwMG4a?=
 =?us-ascii?Q?aWZQjfI5GeHpHWBM6kheg/nbsjG5QdAr8h7d4pA/GJ11z+WwnGYBQJKH2Dnu?=
 =?us-ascii?Q?CP176U1Cqe3jvnPPFj5S8x9+G2r34YLeGotPLtKJGNQvf9wA866pqSwphuuT?=
 =?us-ascii?Q?4eVnIS5YZLF4zzTkJWIMUTa7NloIWjr5gon0ZR/sbzt8vvEKKApmQ3nhyoOJ?=
 =?us-ascii?Q?Yl3QkSE6YTk4gx6/SNyuBIvkHam+5ucOAQV6cfAKcW+vbO0PQmop0Reb2vuf?=
 =?us-ascii?Q?J0XCJ5IeeI6tBRs8gh6CT2alAUNHtF8i/oDIBIsqWY2LMisF+BedfmXqwEWV?=
 =?us-ascii?Q?4hMl267r0v5wW4ISyY3+RgIhRk4kYpJotrcq9xfuVpxHRh+ZrMm2MpX42pJM?=
 =?us-ascii?Q?K21wC7Hct3q2PKrS8M20C3L4KxZq5ZcS3VbMQOvLZOc/YEA2HQSVUCI44ETb?=
 =?us-ascii?Q?cwWVi34JhZWd3z3XW655tQM5t1whGxJ0lcv1y+iye2rgkeyTLvHge4WapQGQ?=
 =?us-ascii?Q?kf7IPCqsOWNMmFeGWQE9sRuZBRckFhRCYyiLNoSIMQZCXuj3/07R7ChbA9Tg?=
 =?us-ascii?Q?KKXGBJkOqbx+dbjLfkEyJLOVi/F2OaNRa5lYG60Lan51UOE1GyFfeD3QQnvt?=
 =?us-ascii?Q?mvgh00QFMw3CAqOcPbYGKE7NDoSJgJR/71HKAz7F1X7Xa7yzgbooW++mgSjz?=
 =?us-ascii?Q?JBkPu1aKVnaOGjmzakVqfX5EcJZVD9QZn5PIKCjTmPaPQu4unmvKPbwSQrrY?=
 =?us-ascii?Q?rQSCKzUey/wFg5T7mOb17j0ZxM3eC8CKZjurvF0Ao2RQf3JgeIFOKo/4YRmE?=
 =?us-ascii?Q?oxt30a+YTkPvAEKrqjOjEthebpW58QyBQ2nOH8ix/3pn4vY13DNxUJbDtoki?=
 =?us-ascii?Q?VEEVy8syvRZokEr6tSaT836eJvhnCNPhCebiDbiqW6IhjclTgk+KafuK5j27?=
 =?us-ascii?Q?DyXfnPcfQDnByDZ41uXgQfIzEjbk8KtLq/sCtCLp4F3NGRcQYral9Doax5eb?=
 =?us-ascii?Q?3ZJNCgvSM4/62I02Ves=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f49df3-f510-459c-f6f2-08da631cd2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 09:07:47.0844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rSsiYI+NLsP/2uOPkcNb4XplasDwNQUH3wqfsCyHVzuSGWMDZ3I86v0vcAR5epj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike
> Liang
> Sent: Monday, July 11, 2022 4:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: correct the MEC atomic support firmware
> checking for GC 10.3.7
>=20
> On the GC 10.3.7 platform the initial MEC release version #3 can support
> atomic operation,so need correct and set its MEC atomic support version t=
o
> #3.
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 6ec0e9f0927d..f5853835f03a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -184,6 +184,8 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
>  			/* Navi2x+, Navi1x+ */
>  			if (gc_version =3D=3D IP_VERSION(10, 3, 6))
>  				kfd->device_info.no_atomic_fw_version =3D 14;
> +			else if (gc_version =3D=3D IP_VERSION(10, 3, 7))
> +				kfd->device_info.no_atomic_fw_version =3D 3;
>  			else if (gc_version >=3D IP_VERSION(10, 3, 0))
>  				kfd->device_info.no_atomic_fw_version =3D 92;
>  			else if (gc_version >=3D IP_VERSION(10, 1, 1))
> --
> 2.25.1
