Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB44ECAAA1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 02:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3330710E155;
	Wed, 31 Aug 2022 02:20:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B9010E155
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 02:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1J5AsJGwQTDcBO5mDbl/6tJ8A6MdZuaJpfu9XfMv62fqnGiWVEZg4Shso9qEz7aY/AmUpP5u5gPO30Kyn8PBsaZP/6bimz2tLna3tZA58MNkvVmFjKahP/Fk/OOu/4GTB8y41GCEjVxzzDEW/gh9tmkCefz7PfWwY/4iQlzAuF9WPsVwj+OVFt1PPt9eGF1JvNfuO9iM8EVTUeIsSPJSya/NJkhSG4swQpvyGu7kU6ec1wp3NknC0hCnzo6GayVMfwBqjeFwsLjCXbZ8a1ZtTTveM5wq4OymboxWSAo8s0wOGOyAGgg1i5u5lO7u50wh2BPu2lOh8HeleAVBIBmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qav+WeCJaKHc7JveOg6bC7qYRyQ2xYsCgnMy9D/kdCs=;
 b=f2OJhQ0dsEkg7sZKchtK2VlJwCluOW7KKx1igxQ6oe3ZlkQ1HaAjgx3HmqhqWKsX+GcW9J7opoQ/kbo+cPJD0eS0yww5OIYs5uZgCg6iNa918n7t6fSqufGcedqOGFAzW3QCTZgcuPIsgRfBjG6kXsxbRAXHr/p0/iKInZbNt3KFBKFz/W/BPH6Z5gOiNhnI8KA+iUn//zdhrwTRfyjuoJopS+3D7KK/A02HjFcVAPxziyw/t91/ZDR9weZhTvnSFS2dOapEmeRyUKreq/nU15x2CJH4Vnmme5KOzpD1x22JQydtnt/5CvA3+072heyQ3qUAH9UFZ/Y8gD0tm+RgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qav+WeCJaKHc7JveOg6bC7qYRyQ2xYsCgnMy9D/kdCs=;
 b=sGXxdzwhq/B+UC4DhuDne2FY8D1BmNjD58qSiH8g9LhNAaP6OZ23Jb3OrbK+M71LcP/Bw0d0DHVoucDHmVyNn2XoaeVbOyWcElnhm10mDqfLG5xqYg0OeJGxGvurO4a1Vit8UjmeYQ+hi5QJXxehM1NjNYbHfomqpuaydjuCrzk=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 02:20:53 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 02:20:53 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA
 engine for SDMA 6.0.1
Thread-Topic: [PATCH v2] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA
 engine for SDMA 6.0.1
Thread-Index: AQHYvNSFc0E/MTgZbUGPBcwBU+Ae0K3IRo6w
Date: Wed, 31 Aug 2022 02:20:53 +0000
Message-ID: <BY5PR12MB38736B39A3A113793850198EF6789@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220831005601.3567776-1-yifan1.zhang@amd.com>
In-Reply-To: <20220831005601.3567776-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8dd10e22-c648-41bb-9d09-b8bbdfdb161a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-31T02:19:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6525af7a-3f0f-47ef-2d40-08da8af76e39
x-ms-traffictypediagnostic: CY5PR12MB6204:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/vgH6ksvEC0PayPL7QLihHtg6GK9fHoTodgdqHiKAv6NuBvmWB5JRbbbym4fcuM3KxxiNzX5ICtWSt6WbF7P8yEITLxhAgdEifVkSbJSNLshm2vEkX1IWmfJfAyVjIxQsOCJm+YjNXKAdyEEfs5koasQGOWpjkxCtFTHrkGfxcwC3Gq6AYRs+rGKmkgg48gOycAeleFmC6CoFlEVeRUMXu+ku/EH3kgnot1psw+t0bd7jMvhFca6WOowQVMryBVqzBPNd5/LreqHDu1R51Ma7wLkLB6apHbsWhkNlARpkXD7Gnr3ywMNc5c62b8m5iOfQ/ra1WAquKIZYX/Q+of1MdW0fl+aH25qqmcYJgCvJ3h11qksCkKuuzcZzXfdc7TxX8eVRjYJeRed9P1j4oN05+qadVoBKVeZCGrIZGaB2HoLGorN3qu8wGBh1wVRRMxNQH9jTkWSIRs+PA60D67KlPQqC/iw246xgkrS3my11geOzS41+hpXWfHAql3bqhA7h/N0Qpl4jscomrjfadGBFKOfqF+a7GYTDWv5sT8dF2ubrdFULJ/vAJd5ccesS+y34iw9pm+qT0qvt7DDiBZieRv2CUxjivzRR5BUhliZY3uHzW+GwiyLUz15W3txzK1RR8hzBDO7f+Hgi1u+4b042KTFc/UDPKp0YIRrzbrOiZ2MSqA5MQXUPSn6kTgtLdV0TBR/KaZYrlmUTKNTRI/q7quw+ReusYQTS5VYE7O2+gt63rTh0ud0xgTIOoZOQekllzpb2nYSDwvGNZU90PHjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(54906003)(38070700005)(38100700002)(122000001)(4326008)(110136005)(64756008)(8676002)(66946007)(66556008)(66476007)(66446008)(76116006)(316002)(2906002)(5660300002)(52536014)(55016003)(26005)(53546011)(9686003)(83380400001)(8936002)(186003)(71200400001)(7696005)(478600001)(6506007)(41300700001)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+WJdB0iylycq8IjM+RfUkVC2Pfnipgl1butwjLjzOo3s1Q7jT9NYC0bWv+qw?=
 =?us-ascii?Q?B5RbdtcyKxN9v/VpShVmofrKCMs20w5zh6GF8EGmvWg9xhszpheBM6SIPXql?=
 =?us-ascii?Q?QNOW2kdvzeXzowm2/sR/WMKvBCFWosnx+YwjFJlUzWOO2fO8ZnAaWCtGFFbE?=
 =?us-ascii?Q?qHV7/7m/2QJsZGVyqosC+rOgHlBHuxDUyuUHQKIDCcJx39YDSNO8n5xay2EF?=
 =?us-ascii?Q?MkZppwAN3PpmBg7r6Vu89Prp0RCXKOnHFa1+smuhia28eOvgQ7XNFX2T5zjx?=
 =?us-ascii?Q?NgkVBYH9PJYIxay+p6mamyIUSbBFDuaTc9bnMBgWfT8BgEqErjYzLiuYSe/4?=
 =?us-ascii?Q?2QpAaGL/XJxpbiwrmKQs1GwKeSa5/S49P7uKjRVNAll6wNNUEwEPD32JtBfQ?=
 =?us-ascii?Q?/uNozAjsriBobQnQrF162eUdlZXB2B3zF+8MUsKOk4PmAwUvYYJdVxWBLV1U?=
 =?us-ascii?Q?Tm18ah83eXy9+HvGUSOOH+JT9Z6LCxk+0PMwjDiWlLjaCNpluprXhbYjxB+P?=
 =?us-ascii?Q?Yv9eTySa0oCUbgeyJPiFpn/L6c9IwaIhhFrsPq1vEK7DEG5xPk1zYT7/X8ox?=
 =?us-ascii?Q?+u+VdeojVlyRwPSCnUW1PZFfUP1as/z8fPM+KVZ99NkyXFYMAcIzR+gj1/1D?=
 =?us-ascii?Q?5KHPlImQjvFjLkGshmxK6BxSM1WWgRtrzpM4IYW+kW2tEPw9MJgLEsz8Lgg2?=
 =?us-ascii?Q?gaYiKIL7uy3fR4+0JH5yLxjih47i3IoSoWF8g3AReV0PZCZj9gjc+Og1zVmz?=
 =?us-ascii?Q?g6EsXG9Yv8P/MNwQY2Gc1rch3a091JLEhsaWowMh0BOTSzjY7xUb6pAA2S9R?=
 =?us-ascii?Q?fVxUfneF+1YTKazd5mQIlzvybOuWc7Z5/47CmbYTMNbtJDYYfdtIfT5xqGGs?=
 =?us-ascii?Q?DZkS4wBic8BH7A9rAK5YbinI3cuz+9ahwcccstKJE4HKLG2r3T/FA64XHxAn?=
 =?us-ascii?Q?mKPH/bYzYt8sOseDxC/OJAXsTWo7IhJR9NbLhKIIxSyWIfzoWAKBzKBzPvam?=
 =?us-ascii?Q?DBk8jgtMM6nkfMhj9LiAKDV6gB6s/XXE6G1oOZ4Bw2GnG/x+NnrGNmLXrjku?=
 =?us-ascii?Q?LkhIDJsaMzD3NFGJQJH1K05I9h/RGO1fHqJxxLjlWiKHramrcRWMy2Irk2hB?=
 =?us-ascii?Q?HXhyH6pTltvkXFkVBHI9UbMHjzTL7E2n4x5Qp8bdud35yXOA5AZHbcvu0OqQ?=
 =?us-ascii?Q?MhGvM9zq2biW+o8i2D+BEqovNeqGws1cyowpQZN9V/y1scj7RUK4EBE3uIa7?=
 =?us-ascii?Q?KZj7T+j+jlfWPL7+C10JaneCIGco87a9CeZMaTujJYsnWKT4n8m4iGGCoV0j?=
 =?us-ascii?Q?GOIiu6TTEM7TuLSN6HaLM9vmg2UZljmnIygHuVF1QEI3jayxIaxirPYsd859?=
 =?us-ascii?Q?R2OCun2esG7CGBCJDcEVl6F3QgofpFztCN838DdDKnU52spPitk019CD4NwG?=
 =?us-ascii?Q?NE0WlNuev+6rHGfNjKGZJ53za5ARmvl7oXRTq98gcGHXQReZxB9q5M0IFiM4?=
 =?us-ascii?Q?8QKdK+3fDhG32I6oB6JUhL2ErBEpbCiIDw3/o21yUtxq3BN0VTOpzXynhWvB?=
 =?us-ascii?Q?b8jCrEPnMzstGZ5CTlnY4eCCdXLs/qYmU0F7lwwW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6525af7a-3f0f-47ef-2d40-08da8af76e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 02:20:53.6830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmsq0ZfkO9SkQeyPJnWP/j5C7X/z1kzoDtcuj+zh7/HRnMrbJqvK8LN4MyhFuxLwuvvgOcvh9RZVg1tRcZzjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


Best Regards,
Tim Huang

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, August 31, 2022 8:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Tim <Tim.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>=
; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engi=
ne for SDMA 6.0.1

there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask has to be ze=
roed for the 2nd engine, otherwise MES scheduler will consider 2nd engine e=
xists and map/unmap SDMA queues to the non-existent engine.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index fe82b8b19a4e..0c546245793b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -181,6 +181,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
        for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
                if (adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(6, 0, 0))
                        adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0x3fc;
+               /* zero sdma_hqd_mask for non-existent engine */
+               else if (adev->sdma.num_instances =3D=3D 1)
+                       adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0xfc;
                else
                        adev->mes.sdma_hqd_mask[i] =3D 0xfc;
        }
--
2.37.1

