Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11092C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 05:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0E610E030;
	Mon,  3 Apr 2023 05:42:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EF510E030
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 05:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNRmvgUqLsC62AdUBmKuVQAR31FP6EJra8MEA1vRaNnXoT7SlfPcQG1ybtRcmK9/laJLhl5IZ1TkMNl6HQo4weKvzwicExhMKin5ztPM5P8Qno2s0QY/oWRwP+kGw9OlidzlGoiLb+cxd/DMrxWha+tgLY9uaI8xDqbf+wj7DKFK9lC3m6xi4ZSi7d+tecCheY9TgQRvV1h2LSxdWGpC1rtO8Do6xCgipODeF7R9EB5TcO1hRmPC/WC82EBoCB+DVUfIu1BY0zJNy8aBWrG+66FAv2UrwSRn8YSc1XB2IF+uPiv0o1Wpwp/WRfp/FvIr4yIZtWzbvtBY/nFGYt3/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbTtz8wrQuYkyiiDvxI+n4lyuP4i6BmmhaxLn0iIsvg=;
 b=H3chTEhIFsLWIssQbsBYYmOabKz3JJi+ew3u28AtfPjD4t0VB8T1N/oPNhOG9p7cYsjmSgYZo0WjbVvVuti6xasvVwBzOW8QQdtu9PSZkiTOHlCGdN5AkONEr8g4bRhXxKjh7ENtKppSGwpfQoJaAbl59TgIVGhLK8ACCY9EtrG+kgEGmlcLs/449c1B856P9BxHDaOZW0HBnL2bKi6waicXMtwTaEzCJLw94+Z7CO637AbIAAar5vYvEyHahCQeLHwmfWn5enMlQcO3qLox+wuwTDb2DxHwKqNrYSwNhZihWyCa3uz356gqIQ2eF4cB5q/mhW23IGg13DxsZJu/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbTtz8wrQuYkyiiDvxI+n4lyuP4i6BmmhaxLn0iIsvg=;
 b=aCuxS7RtI/lZOSucudP/JfWDnjWyZy5qNKV2GlKkY4IvZAm29JEUsoTz5SiYOUlqCOxrkSsdtkgmXLrsbbKQdYWeoGlYYIi7g0oqsjISjl8naZyNJZahKbjhL0nPjz1gw9r5segcS0Xe8JuJjD/DO9g5BE5pdZuC3C38U1Pp2Lc=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:42:14 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997%7]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 05:42:14 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add MES KIQ dequeue in MES hw fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add MES KIQ dequeue in MES hw fini
Thread-Index: AQHZYiPec0PdyIL39kqR0loD8CoiQ68ZFx1w
Date: Mon, 3 Apr 2023 05:42:14 +0000
Message-ID: <DM4PR12MB507287BF495FE38A7547262FE1929@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230329094939.3417283-1-Yifan.Zha@amd.com>
In-Reply-To: <20230329094939.3417283-1-Yifan.Zha@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a5a57b79-9668-4630-92b6-fb19c32fc2e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-03T05:32:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|DM6PR12MB4877:EE_
x-ms-office365-filtering-correlation-id: 7b59caf5-3465-4437-39b7-08db34062dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8iCGFS+snyJIfT1wa1PLXIk9IZtWGe0owjiP5LpBjsH6DirPhbOvan27GrzyzaX+cy3Zhp86kPqle/8Xbq4wEprN73YkC06KtQegrvdIgXFob5zgrOKzOC8d8O1/N2ogRZ3/u50/tOtoEXsMunf9Pc/UjxK66sFecgURAbiFZNThe+Li/yHA5WZF6x0lPLEaBfMiqELMHDCQpRuoN/VfgW27iQlMe1tajrAHYfZVfOBHtGG3UIx2XPo1t/U7L/s0pkxqGbOzpxnZ5dCW8xSzHypLEBy5QNkBdAK90nUWjLdTYfbeQX1gOU4Yt7fzJDy3u0R7XYgF9rN6/IpCaWXxPooou3JMypRq90l5kp/zjowsfw9tpqMCOQjwd40QhzNX4bqyWFPilHAYbAYAojgWFAMC6rkR/XK9sECIXi93OnoQprvnKu6a5Gu51a8I3WQK7tJFtjmWNsvMoVQl9W9FYETsuFXLji50W1DXmRRd0C+4zfyOAwkE06+IWs3ooKQ+hTxaUv5VYwOgSU/ZVk2FcxKlknEEuwvkMhB/IT5VuJvanJeF0cN4V4O4iWjo5e04LLGjLQE+7q464fcQX874QfIVoRzw9ovfEKB4TXV/2RsuPEt9oFmC0gRWAjtNfpFv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(53546011)(83380400001)(186003)(9686003)(6506007)(26005)(4326008)(478600001)(76116006)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(41300700001)(122000001)(5660300002)(38100700002)(110136005)(316002)(54906003)(6636002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3XZq2xs11yxyQ4RjWtsbKnEKO4P8ICplD+I3R7KsK3ZqPbmnEu20T3J5RVd2?=
 =?us-ascii?Q?/hgdLy9RBv1yGF/pvZBM+2xGZQr63QAac8BXmrYt7R37PMw6Gse50gHJY8gk?=
 =?us-ascii?Q?ow/Bg7S0gDqS+EUbuTADrDDNEq0gU0OZtxFfdN0J4xsWY3xnOxZ8zAeGCplB?=
 =?us-ascii?Q?TkVdGborzaW1+PB1x8/ZYPkMWfP31KWrZ3/r4tCw5taFb4RuXY900k5Yiu+c?=
 =?us-ascii?Q?/yKVuLKwvIO+grtorEIRYezTZomP9p2jWNcU6LmSD+DTtVrTadCZ7YXOupTC?=
 =?us-ascii?Q?YSMOdSF64heyaBe/y+eMiZ9U2rgX6lzm9gOz3cpJ+bNYEpF37TJLOVTwxgiR?=
 =?us-ascii?Q?o6rlKFGf31rXo/VLgy+wfx2BSfWmiPe94k+oKNW52YI88LyWWd2e2CpbVLl/?=
 =?us-ascii?Q?ITKwLBEKvAxvgrEb1E/6M0tw71TQ/zPGNoqDy/9lTkLUP82VvGVwzj2vXHbv?=
 =?us-ascii?Q?BFnqJVWdC/0ZZivEM+C7AMpq7smHQHlMdgahBXXtqVzQv2cuO1zx8QyJhTHd?=
 =?us-ascii?Q?p3RoR1WJlt8NwQc2KH+bOif5M8jQq3JpQVcAHknt9FG8Gf23ZPWR2qKmAiwH?=
 =?us-ascii?Q?mllLxwTKvuWhHbYYpSv6ADZbL4jPwlFXA6bAcetb8rk31xPxGkYpFpUo/H2x?=
 =?us-ascii?Q?tSmL5laTuQuaSndAoC+es+hKuTnLesCeBkw6s9weC1vkkHQNWbMW98xnejLe?=
 =?us-ascii?Q?k1cn+VgfaMYYZmKX5K+RO5rszqpCo7KroYfruyddSHwIZaGxZTqqf8ainWBN?=
 =?us-ascii?Q?F8ApAhZvUBT7OKEZ15FwfEXCjojp/E8/wYDLKq+aEISMkkFb1S41dWfM7bEe?=
 =?us-ascii?Q?ammmqFsrLwqDglELY/wuSK1GAMs/w7VYJuKQiD3R61ghsH5zlbKd0xa4IJIo?=
 =?us-ascii?Q?EKx92Xz0Qtpz30Z5NQ1k4uTMGs7CnAZNbFJaPRiKcgwuFZjm7b57Zr2fL/IT?=
 =?us-ascii?Q?on6zNrM19dLPBT1skcN2r+6aqa0Bx/bwmqOB+JT/qbxiM1rXZwtAIeI148/B?=
 =?us-ascii?Q?FCTchZ3z6H7vnNmRvoJ0OPtqosBpV2lz0AGeAeWANNcQiCvRbE6R64PNofxO?=
 =?us-ascii?Q?rDN7q+cEsWZJdtiJBkKiRTXUoZ5wztab+Riv7C364auEomiy3TDjIU0x07+I?=
 =?us-ascii?Q?gJBqKjDKRc/wv8ekeqxOUgyV1lbyHGGSvWWvK8G9E+umbPF7JpqH/7Y/OE7W?=
 =?us-ascii?Q?TWI49toHyiIJZk3URa/OA257qxk2qpjAQs5DE2Dg/OR/UfKRh9pR2HGjclgf?=
 =?us-ascii?Q?6Byw7DQ6RzDItpr9uqePRKGOpd3zLo+7cgMc3RBiBhE0HCdVfASKw9LAoey0?=
 =?us-ascii?Q?r1Y0xNywWCI8FtBsKx+IoPyKIJ4bNJ5Oz7ziaMzfceHXZHUoO8CjTkpAtib0?=
 =?us-ascii?Q?haxrcBwtmWq2iHepU8FehsM3FmcAaFUl0keFq4fRuQ6Z8ml9fV9+RzZ9PDpl?=
 =?us-ascii?Q?aC9+3NbDVR2hjz8QA2RIGx/W6ULxaL1URylnUyCcJjuVLWW6M2tL6uxQSJ70?=
 =?us-ascii?Q?NJfJJymzJpnqmmcuhZkpjCrzkWSItik5YEQHccmjOIm3FaogR6NA8SajNaY7?=
 =?us-ascii?Q?jVtp2rWIjlCbATSJoP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b59caf5-3465-4437-39b7-08db34062dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 05:42:14.4564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLOOm91sSzf7cXJNA/rFG68c28oYg1RQ2SHPIOGMFk4Sv9I9goeaqr7gaTnLja9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-By: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Wednesday, March 29, 2023 5:50 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add MES KIQ dequeue in MES hw fini

[Why]
Need dequeue MES KIQ under SRIOV when unloading driver

[How]
Modify mes_v11_0_kiq_dequeue_sched which was used to dequeue MES SCHED to s=
upport veriable pipe.
Add MES KIQ dequeue in hw fini

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 5826eac270d7..6e97c28e3162 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1089,13 +1089,14 @@ static int mes_v11_0_sw_fini(void *handle)
        return 0;
 }

-static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+static void mes_v11_0_kiq_dequeue(struct amdgpu_ring *ring)
 {
        uint32_t data;
        int i;
+       struct amdgpu_device *adev =3D ring->adev;

        mutex_lock(&adev->srbm_mutex);
-       soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+       soc21_grbm_select(adev, 3, ring->pipe, 0, 0);

        /* disable the queue if it's active */
        if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) { @@ -1121,8 +1122,6=
 @@ static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)

        soc21_grbm_select(adev, 0, 0, 0, 0);
        mutex_unlock(&adev->srbm_mutex);
-
-       adev->mes.ring.sched.ready =3D false;
 }

 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring) @@ -1176,8 +11=
75,14 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)

 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)  {
-       if (adev->mes.ring.sched.ready)
-               mes_v11_0_kiq_dequeue_sched(adev);
+       if (adev->mes.ring.sched.ready) {
+               mes_v11_0_kiq_dequeue(&adev->mes.ring);
+               adev->mes.ring.sched.ready =3D false;
+       }
+
+       if (amdgpu_sriov_vf(adev)) {
+               mes_v11_0_kiq_dequeue(&adev->gfx.kiq.ring);
+       }

        if (!amdgpu_sriov_vf(adev))
                mes_v11_0_enable(adev, false);
--
2.25.1

