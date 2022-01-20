Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F308C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 13:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A086E10E7BC;
	Thu, 20 Jan 2022 13:23:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A940B10E7B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 13:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHYShYcd2cmC8Rl9s+DVjKFSCAN4qaePuNsK0h7WTKFSOVgAsrG11WBnlmMokc+qQmZyYeAhlCAjgpIeq6wvA0ZSJuRaj1Vzg4nzjV0C8Rbk/R0pqboY63qEbSYL4xIwPOxDNNGnsh+ae8NSdSSttF0HRG1qOtdU0rR+grJk0ZmmfXG9f6nHeg/jC887tcyAl0orhJnnTM47DcAt09Y8Jgci5Kl4lsPiXJ6gpKVPvQXj4juvQ4mVAZnrFl+Kfocf3H2eEwVQyIR7iE+7stBpijQsbWHG6N8RdqWVeUoKGWmxV+/KWpo9Seekv5UX7y+exQOY4G0sVOCl8BaxFucIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTbiuvnj166xX0aMnNzOvfb8b8V8qR0tFggD7d9G9Rk=;
 b=hz9tzUijzGcWIsuQ9XluAEYUmbwq+mHLko3FK6turSDlU5ZpC146XUmEaTorIvalrOAfdMefGXblYlSPREiiyTVYxCdv7FZoCYaRaLIrpkH65/1IZu5EHyAdkYWagaTfolyJFjNCN2bdjaPhQqYvLoSpYwNIgzfQn+8E3+2o1HSQTG3VljgJB0szID04DOBk85WBK+vUITvsEn/4rprEZNYOLH7tZmeM4Zw3jQXcq1hYVOIDJ4V/OBr48++/tajXieSTHxBOXlK4tJIh6LUESurDxk0qdjjbVSb0pOxKD4vHOFjjOzSRG383jmsqKe+9gEONCUlOsIvf+wZqvWOtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTbiuvnj166xX0aMnNzOvfb8b8V8qR0tFggD7d9G9Rk=;
 b=CfdBkl68OLWsw42KmIprBHe1t+u2/D324k88TxE8VV9IW74bNz4uwYbydbD8V8EB+NsYQj1bTYrKzhgf+LjP0ADQYa6WtS2YvUnzLiYdFkZn5bF8vZX5OgW/5hO2su31QgrLcOKi6U7Ca+T7r3kuy7PA0dSgI162NY5/NMhDsLo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Thu, 20 Jan 2022 13:23:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 13:23:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/admgpu: fix the page fault caused by uninitialized
 variables
Thread-Topic: [PATCH] drm/admgpu: fix the page fault caused by uninitialized
 variables
Thread-Index: AQHYDdQcUonaMo0NX0CENdi6MhVDUaxr5gHg
Date: Thu, 20 Jan 2022 13:23:53 +0000
Message-ID: <DM5PR12MB24694B184B5DB9E00B86C98AF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120080220.27663-1-Xiaojian.Du@amd.com>
In-Reply-To: <20220120080220.27663-1-Xiaojian.Du@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T13:22:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6c24ebbb-4eea-46f1-b79d-fc7d5f21306e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-20T13:23:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 666525d6-158e-4035-abae-1c8326d983b1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c43e389-bb2f-4267-67d0-08d9dc181a96
x-ms-traffictypediagnostic: DM6PR12MB4878:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4878182177D75E1FF1920E3AF15A9@DM6PR12MB4878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:136;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/q0eFIWxhrqyppJZCnn0bFwg9YYJgGC10+pH+1Fn7jiN8aLxuyZLJ5LwlTUziHKZrrBLalqAR5jqe3+dH2T1vvlSz9y5W5F+FPC4Z62TFpWTUweyDAcDau7E6Jwgu6IZYHS7R3H068evmYr+8mgRNX27/HvflI4WUVxzb08hAN0gUqUSSJiJML8+Oq1/6qubcDXchOVejAui7sb8goKEqJFSzjtHQ2DnkXCspEWPfSFwHOnO6eJ9VwRWXHVprvvu23bwbMBvjVaL7g1HaRgTyqg1GLBqcVZzLOWuqwXQU24zuqAQmmZHmfuj3M+WXKp2ahfaJj9xsf1J4KpV/6lsVgl1fNSIp/JQWIEUhwVZcp24IvmpHhNks0eiRltJ2TTEMvi7DAtUZnlLDnx4YQpXysCcIZJr+zMR7pH5TRPbwB5IuOePQfP7hbfRFbCraf5e/C+ylZPdc+PrVNU+IApm7aQkCbKUaDr4T4PPaFQQ9I2fQgQmSwItQ0SDaNspnOYv3UifwvbqI/ErRoh1xMxYlj3ehMXhnNHgEZ95lhYkv+AMyIhMYtFSpPwu0u0iujiog0wZBrN7Zn7idJgdIrBrHEtoV6gEFEVG1LbxHjAyh0GZFfZfsRoF18DKF8Rj6eQvM6M47lc9lrpSvvRqNxHaryn1PCKLUwR/7YCP+VbYn5l1MuRIIpZCCdrJeQNZn/RRvvmbAy1TPsJh+bqLt6P3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(2906002)(38070700005)(38100700002)(8676002)(55016003)(8936002)(6506007)(86362001)(53546011)(4326008)(316002)(5660300002)(26005)(52536014)(110136005)(33656002)(83380400001)(76116006)(66556008)(9686003)(66946007)(66476007)(508600001)(7696005)(186003)(66446008)(64756008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BM9dLCrDYVJjzWQw3ADL7dXnZMGBkfay9JzkZLo725YB/Y0q1iFYsImSlWxB?=
 =?us-ascii?Q?I7JCX8kvtM2FY/Tc8H/r0Uh5KAw7JujYpoU+EgKcCvkQ99qYcQ6lejHd0LXt?=
 =?us-ascii?Q?OHI+sI0JBoDf5TRW72iZ6afEsCMhSh2UTPBsRgD2k0fsr3AbimZWNt7riHfr?=
 =?us-ascii?Q?2UCeVoZzLvHG2ipSg40Sikhh+FgarUW69pxTFi911L6R1iSsMMcxXrZ2XuOP?=
 =?us-ascii?Q?habsfd4oiL2Ast0syxqfco/F4AnPFFGxCyC+xMmRsXUD4QEuXz5NZUKdTyIj?=
 =?us-ascii?Q?1tbcVV9t3+ND8EY7P/Zu3B44KtfNLXlH3/VGlPUzKFf9smkoZmp3dcA/X9c6?=
 =?us-ascii?Q?GVYfEXYNEgICCEipBowUb7R/Iv6Xxr+/un83kXlrZKcSy9NOseD0DuFaAvD4?=
 =?us-ascii?Q?kRyDIdbBykTFNfsoeM1i3ZzXFOPvumJWQA9e+sGSD9qlFtT784r33hObakIC?=
 =?us-ascii?Q?+yIJHNFptG1JIOlG7CajH9NE4mM9DKWQbyBBMs7eeUVfgoXJkBz+HtRACqcq?=
 =?us-ascii?Q?v8reCQDpofXGiFJXSGQfQNRFLfvMqquaH5icM4DSP0Ux5OJAyX9MaVeo86yA?=
 =?us-ascii?Q?j6IH25tVRu8bfKD/ihl8Pkc3A5gS2PwFhQ0jFZuRcKjLB6xWpJlkXLLw34M/?=
 =?us-ascii?Q?8C5cdApyoB7C1/b0sGTDPJLG8XD+f+OrPbQkS0YsrS3Yv6nFhnR6Qjx5wUZN?=
 =?us-ascii?Q?jDjCmo3sJhS3KRrlOh1bCliO+ADkC6kKU9Zp7RWmc28wkogtGSBFW5uQQxfm?=
 =?us-ascii?Q?2BT3thoHYR8VkMdz0ha3wKJhTR6XPGqdN7QyDThax19bAZvvkqGZHiXi8UK6?=
 =?us-ascii?Q?GwS+pwjYAPAH8dYfu6dmCV4Q1YYIITQJOOJowIJlp5TQCgb5iDS1B3slQb/A?=
 =?us-ascii?Q?zDOZ7uOGaaJeuaLPHW1re/oJQeF6Xgia24JTl02GVDMU33shfGnT/Uhzz/49?=
 =?us-ascii?Q?/Hz4z14Go5eP5jc/Ivt9LbVVJm8mhBERo7+1S8jhwmgFe8AsiKlMzFSUoUKi?=
 =?us-ascii?Q?SxCWLSmUiLN+aCyT1dMcn69Zo8qG8qalkOaP55F4Y1rxA3zztaP8GsEtlv2j?=
 =?us-ascii?Q?5FQpgUrOXfWc7fC1viu6Ncx3QJWUPIEYq/sEjzEIBZrY+iqyKqy0VZA3ZnQ1?=
 =?us-ascii?Q?dU2fkemYwJgnFXC+4lQ0gM5RratCtmbz01oGdfTHPDsqEweGlMmwfDZzVMyp?=
 =?us-ascii?Q?4tUpCKvXheEJaXH7sAE1hsWxGjxg3tx/UzWRG2SW/TNRXzD0SjKFKSZZv+Ik?=
 =?us-ascii?Q?jik+NjdXyXbdkm5nh6jDEcVmSNahFMIV9c9fPs4NQq3lvBpM5If/GpCRg6w1?=
 =?us-ascii?Q?GIiSTVE4iVo/FRpTd4+iqzGSA0ac+Eq+++197vcbGOV+RbX7C1x6Bd/A6gbb?=
 =?us-ascii?Q?8itEXcwmaMrzF5m99cHYvv/8RLQ1YBKWyrhdDKCm1GiBvZ9lJeNJsoCpJtR3?=
 =?us-ascii?Q?9YCX82qoqLGTxV2ExCrFekYwt88cn0ZVolfFYPLX7/VLVdbMSrenscf3pj9G?=
 =?us-ascii?Q?GqNPcuHAAOcHVTn67f5WO5BNlrjKLad8aYey454Wiu4UH3yE8kgUJX4fji+S?=
 =?us-ascii?Q?5WFQSf7GBtu+g58XyvoAmzM/zlHyGTNPuoXsEWjTu45HN8FFNN28+Vmb4h5+?=
 =?us-ascii?Q?FAro1trrjR/hs2zhX931tik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43e389-bb2f-4267-67d0-08d9dc181a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 13:23:53.2401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSubb9roVeMH0mbKRg13p5NBVZZkn21Vhxbgs4GlZ8BiAv6fHDEtVyYPXSX3vhn4NiSzb8Ubaj+EGo4/yFINRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

If you add the page fault info in your commit message, that's better.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiaojian=
 Du
Sent: Thursday, January 20, 2022 4:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/admgpu: fix the page fault caused by uninitialized var=
iables

This patch will fix the page fault caused by uninitialized variables.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index c65d82301bca..09780a0f874a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -828,9 +828,9 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_d=
evice *adev)
=20
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)  {
-	struct amdgpu_bo *vram_bo;
-	uint64_t vram_gpu;
-	void *vram_ptr;
+	struct amdgpu_bo *vram_bo =3D NULL;
+	uint64_t vram_gpu =3D 0;
+	void *vram_ptr =3D NULL;
=20
 	int ret, size =3D 0x100000;
 	uint8_t cptr[10];
--
2.17.1
