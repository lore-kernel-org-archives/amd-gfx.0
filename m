Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5777710E59E;
	Thu,  9 Dec 2021 16:53:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F5410E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdeWEDUtzL8R8k59TQtRnsdEX+kEi5ENKjRRGFMHt5+0xw31YWrg+sHGegC6/5zIAUwl2zTZejmlzX99zH2YZMdycRwR+vsniaflnCxFi9NICETWsME3Q793UpKu8DVrf4I2ZBMPtLIju26uwLGORnLFK0muYLiPJhXfa1/25RY8vsWGUg6hCYWd5jJSwz4pd0JNg/nRIhNO77/msizqtFBb5jAmKDf0r9SuKGfVw7/QQh0Dzs7GvDvrMdkKvv+XEHrfrAT2IeWjekjZlrKKWDYo6wyYkA0p+Y4HfTdHz8btFsLREOyWJBbsLKQ4fOzx4dxCB2iR5mv6iXODhB3n0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WRWbjgF2yOPGq0WZ9vPD1vhyNI+dfrRjHpERTs+AAM=;
 b=fE7Y3zVxRNy7lBNKQ9kZGFI6WMsqJFvy8FwzQIm71O3sqRyqwYcvK/pxUM2WFb2Y+8k2kmK7lEKWCBzTl64CIoG0dfUaXGc3bNjFdyZtgmbS1C/bsfDtt7xnKZJismt4zoGU4+1/C3qDEQVpemYageNHaQYHdTTCwXhLh8srWZ9OBwHXhyGstg/2dlEYRaQ7xrDGKeTcOLjXnIoguqof0cL0aedF7VD0jWgMLKlR/NcVfoDIin0nhjdQ6FFxfN6+LuDCwMOCDM3GJXPc13WQR0uutG8nb+3lbTZfIXTt9A7Y+dOPuPUa+54w+nOA4tyiBSvIuV5Y9SgWBmGq+H2kPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WRWbjgF2yOPGq0WZ9vPD1vhyNI+dfrRjHpERTs+AAM=;
 b=d0nmQIIKY0zoXvNoMr5sVWX/8VtjEJ9wA6FqiwISgDhj+7OK9PDEdxTIBlJFyuEz5VWgRH/XtnL+qHY2UEW1EwL18H1igD0e7VcieMDCRr5sQtMGD/4A2WI/dLcSWKhlAlUNac4t01BVQ799bp1diAFNSfBYFNzHGRLK8OZH6zk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 02:52:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7%4]) with mapi id 15.20.4755.021; Thu, 9 Dec 2021
 02:52:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()
Thread-Topic: [PATCH] drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()
Thread-Index: AQHX7BTRh+kAL7dAdEOkx2ybvcCXyawpdzew
Date: Thu, 9 Dec 2021 02:52:05 +0000
Message-ID: <DM5PR12MB246974D7D97A9A4BD3FF2C5FF1709@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211208084615.437375-1-Yuliang.Shi@amd.com>
 <20211208084615.437375-2-Yuliang.Shi@amd.com>
In-Reply-To: <20211208084615.437375-2-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-09T02:51:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cd4ca74e-e628-4470-9ffc-3244f2aba99d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-09T02:52:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 59ad2c47-d164-485f-8da9-2a52c56c314e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b12aa7b7-e8cb-45aa-0228-08d9babee272
x-ms-traffictypediagnostic: DM6PR12MB4828:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4828BDDD494125C32E9D4CFBF1709@DM6PR12MB4828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwtwDqYQUU5eO+0UAYFRlT3gwwzzC9yYnJy2fIMgS3jNM3WzWrQEiVm0TO2SNB6AtkpUD96jd6EtIijDWfb7DuLoPQj9PHFIXxW9zmFmw0hXv6lwmyaZcgAZ6YQInjuOOkzeo67iWDUHx5UufuFa8Q3AObMbzAsdcGO9WKXDy3pu4FgFmQcXczcpITWooDu3qU7cBM2HNw9yaZqsDeY1CFdCtGklOVUQ5VAWQjo1DPWnpiVmW8salP+r5jxaL3SELdhd3+8NdIE/YtwRoMvRHdFkIuu2urCWNxO1Ozp3c+Env8GSqlJgkA4Ok8u6W4fcBWYnC6Bc2zdVpj+kqI+C2LACE5gK54pFNgDkGnIykRDOggiIY1zaoenaS1B0hwXrSDHj1HcFDQeR1oJ3A+IV916F0EhyctczvJ2lo2uEYwrgJARbM+1j7mn/6+fNWAZwBVuMf6NiK8ajzq+AXkUpoN1cmpjJPjJJElic1vG3y95RIIssocKdt9ZA5k8A1VUYUeCnQ2rx0h5Bjt2gTYNOLKVeZbJJ3qcRZLzc4JFYfFNDnVTSBqM6ACFX9Bo6jjfYX9sivLIroBJ/GzDg6nGDjOcgjcVIRy8iIumueG+MWyX0R2k5USpamk6X4RP0UrT19lh4mS1qYH1QUNMAz9Um5PLyc3A1P0658DB/dg27KM+lxLC59BaFibnfTHTG/nLaQVX15c0QNBsW5za8PV59Ww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(66946007)(86362001)(76116006)(83380400001)(122000001)(55016003)(52536014)(64756008)(66556008)(66476007)(66446008)(8676002)(38070700005)(38100700002)(7696005)(5660300002)(508600001)(8936002)(316002)(9686003)(2906002)(110136005)(71200400001)(26005)(186003)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DVAfWmwXM5jhQxhckYSJ5TO9Oazpj7sHHu8kN9lupwbFuR7rSTcy9QqlUzAI?=
 =?us-ascii?Q?RYja50v37XlCBx9+u5SbZX7abxycOKZStPgS0TJlI1Nj45rTKpVqy2ZtcI1X?=
 =?us-ascii?Q?n+A2yIVNdmvupzYT8oLwQdkjjIp8rLydwf/BeXlsVY8vldNP9XyOJ2opdXAQ?=
 =?us-ascii?Q?pjqhzHwkdEDDuSPRKJFa7KA6x5Gp6rxH2eORJsEimKRA7t+MOLE2LF5ueLeo?=
 =?us-ascii?Q?W8WZRxG9AU5QGEdLAfTJYS9UvzlxxDH7pG/xmksli1yNKjWxHvAosB5rr8yp?=
 =?us-ascii?Q?s4ZCw5RhiS4tRTtdXnxpGhk7YizTZsHRDcfbaGrjk7eOadtSFionBJeWtBou?=
 =?us-ascii?Q?5FCjWQMoc2KpJy/OELwdDfND6jUa5GTHfCCVsDxCYuSAPmiHrKzclWpvi1st?=
 =?us-ascii?Q?wppyjzvsoq0NJQwiXmScMxU9tZXau0uJo1/tqoICHz0+KMlQYqY6BKKIJx92?=
 =?us-ascii?Q?Awj8v7J0NyB5quwjhMsBn57cZ82czSX4W3BJ2lstxhTrEd31mlGeyVj85wyT?=
 =?us-ascii?Q?E14bfspPq4PjA/oGtpeCRA9bz7UiOlcxqwM9ZmjPrspWBQ8YkY0W3zw453NE?=
 =?us-ascii?Q?puPWUAmsk8q3B6UvHRDdc8gQF02dM7SMP6Tdp3zphaGK16ibb6eedomCidFM?=
 =?us-ascii?Q?yOg2jmZpenVZGLiQdITJOe1KbBqW2sLcshz4yF33RBr8SdpKUgUQTgWu3W+e?=
 =?us-ascii?Q?X+CVpsH3RxdwE00bkaJS/DBT+NWH7kkFiCfvylrptmVdfn0dB0+gqhc1KbDs?=
 =?us-ascii?Q?MeJq4/239diXFhDGzG6SGqSt+PPEyxuDcRZiGfbhN/7CSAwUlJ63FmA67fb8?=
 =?us-ascii?Q?6XhXYw1+PSbBcRJ6uqGUEPlBA9rbiaaQunFbLzqvpFkS8XIrXMJ1+TiJjviR?=
 =?us-ascii?Q?SxRmlvZs1ZYWbmnAEYUbyfplFsWxpARP9wR+3qXOC1Cfkzjxtp43kkD229hI?=
 =?us-ascii?Q?tCbn4l62qKWnlnTQ2o7Csb28i9nFb5fzBhk1GE0imJFCbcN6gljE56cMMwjw?=
 =?us-ascii?Q?w5PjgeGdk05kShqAyKksCy6ewGgV5gaCe0PoYrrFuwH+Qv/uMP6PpJeTZyIu?=
 =?us-ascii?Q?d08I7jzSk2jI5/GfLVsAtokBw1bh0BUGLRxSPuc8y4AygvbWpCi6l7y6UQUr?=
 =?us-ascii?Q?PjtNxhz+AhXNFkNKd7R6ryKo6/pcYV/VW3zlDtPuZy4jdllyrgs7jYQ9tbPI?=
 =?us-ascii?Q?i0gvj+t9CA4E6JkZOpP0IEFOCRE7SzxIhHt/mZfGCbCqW+TRCDO0Oru7T0kl?=
 =?us-ascii?Q?SynWEmL9eNLnt4Vs2On9gHdaR9oFznz8B0AeFKKH6Vsn/qka4LIZBFaMXurP?=
 =?us-ascii?Q?ouNTWif+muVujI7bXwu9eUhGVO2WOE7dnQ3bWl1ewbkpBy10p1ZnyjTl2NdQ?=
 =?us-ascii?Q?PrihUe7fhbr2yPZ6csoHX+xlpAiGKbRmuA+3ytX0WcHsLNoAwSjtdkf8Xw1f?=
 =?us-ascii?Q?uJ9MwF24y1h05ALyFK3wY+pfMN9DqhSGkxBQLreJI6LErwKZ7CCYFD5nDXLM?=
 =?us-ascii?Q?J6Pizo1WNl4Xe8IW31f1AsQjcrsv+2gKMBxTK+Tns9eDDezRZIr/VySdbfM8?=
 =?us-ascii?Q?25EfJQvdD4LAGsEthlt649nvVOGONobPbKGayPMskvOIxL6x/e/dsPhy5jAf?=
 =?us-ascii?Q?vBpD/pgea9/UsQVvio1qDZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12aa7b7-e8cb-45aa-0228-08d9babee272
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 02:52:05.4373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHIw7HVhinwHLtVrCViwcp/ZdvshhJE22e/jmvnKSOeaYu8UWZwzA9g/YPUiCfAvvc540eoprBTHCFPDPQVQUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4828
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie S=
hi
Sent: Wednesday, December 8, 2021 4:46 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()

Fix following warning in SRIOV during modprobe:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:11=
50 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index af3a2f8c12b4..03a13771a9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -390,6 +390,7 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct =
drm_device *dev,
 						int index)
 {
 	struct drm_plane *plane;
+	uint64_t modifiers[] =3D {DRM_FORMAT_MOD_LINEAR,=20
+DRM_FORMAT_MOD_INVALID};
 	int ret;
=20
 	plane =3D kzalloc(sizeof(*plane), GFP_KERNEL); @@ -400,7 +401,7 @@ static=
 struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
 				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       NULL, type, NULL);
+				       modifiers, type, NULL);
 	if (ret) {
 		kfree(plane);
 		return ERR_PTR(ret);
--
2.25.1
