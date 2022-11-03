Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E37C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8037910E5A8;
	Thu,  3 Nov 2022 06:39:11 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A9B10E5A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW8A3f5FmE/xeSHC+JdqxFT71ZUFRnnO5kAy42ESvJyQC1fYrzTTyTS9X+4RVyrzyhmjsHr2Lm441Rm3RKuT0WEJbpVDJGZWSi9L3p42+AcqHXijwPIQ3ZzQXnZ6SC58aOXnkUVw4Y7SEdCyoQhbkDtyQNg/FaJ7qWj0KpiZgSssxF4t8kmdDeKtrp7ouVpf3x1OuKbIoYgrwD7vVU3uss46e1JwPRt5Htzzzyl4tF0PQw2eLGqwpEsxWoWUtki9NQ/RR0JKkrY7Vk0bFgFyUacJQt4ewG16WXgz3iLw8Dk6Rm6391LqMPxl1njDpnckT9GS2R1eJTt8lqm9Ed4uCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x9z+ej0ip69Z+LaR8kMaijApNgZSy9OeAXK/11dEwo=;
 b=Xu6wltoSbfkZ34SzeTSbO1900C/X8uEJ8Vp12i0M9cXawSkxROcD/8c6SfDPYmO13ALPgfLkHbPF91NwaI8yK8GkVgOGUAAIoYv0dvHT9Wl6CJ35xJpJcLJLwWs9/bzjtOFdwY72S1/CcU6vPe9JYhGxXHW+V7S+9xD2vnbfxL68WMBdqHa7hA5P40UQ8qAjTIxO6EJkkzUeEmhJckUYxdGsSEBNEE3k6FygdbyCibeKi8nvoZ2fBr98P+hCViKrUxNqFkR9w3N41VgRI3Md7rsOT4VXxcNXGccxhMvtfRKuXz1oOGeN1GkIsXpcGyHyKTzWyqUEudfw7ie6GgXg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x9z+ej0ip69Z+LaR8kMaijApNgZSy9OeAXK/11dEwo=;
 b=tjWnuWEdIFLovC8xB+UIijaD3n6KZdRUA5BRXolkN9CFp3XrWJAH2xXmEBmhJ9l8/XPZ8aDXjLhHUOMlPz76is4XIehc/kaE3Fq0zSEb6ovw1r6YG7zg3rdVqSbeWDv1ZXNk6M1waEcdtRTyPvUUfF2nx1lE0bfBA2t/2DFtuPA=
Received: from BN8PR12MB3027.namprd12.prod.outlook.com (2603:10b6:408:64::29)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 06:39:05 +0000
Received: from BN8PR12MB3027.namprd12.prod.outlook.com
 ([fe80::cecd:f488:32ef:58f1]) by BN8PR12MB3027.namprd12.prod.outlook.com
 ([fe80::cecd:f488:32ef:58f1%6]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:39:03 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Thread-Index: AQHY7zImzMfN7osu70271KM7JDmi1K4svyYA
Date: Thu, 3 Nov 2022 06:39:02 +0000
Message-ID: <BN8PR12MB302734B21648B3CD0C6D0039E5389@BN8PR12MB3027.namprd12.prod.outlook.com>
References: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
In-Reply-To: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB3027:EE_|BL1PR12MB5205:EE_
x-ms-office365-filtering-correlation-id: 31b155eb-dc9c-488b-c590-08dabd6618ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXKZO+5k3BPr+yOh6F6OtX1G2cAf4ml8gvE65+g5naha/QCZqm+cQnJECP3H7CG8sMfLWFEynP8/P+n9vn0kc4FjnKlfu20Szu7Vr1hlQgksfy48z8WPZTkW/gS9/XFqnfrT8YAKSB8KvlR++4LqItMRbWTazrA+6m0nI3RZYY5BmBclSdWR9iLsqqkKcs6KQXLq7dR/aEtFHWjr6x/pM79dmIlH5d84esNG+zSJpyWVc2fqkpSzzovx+6XmjAdmAqwEw74tfmx0/bQE7jPchCEAUjycSWDkO7rd2GS5Pa5yNRzVqQXTrQbHx7P81rrNtuzcDlGnjcFlHTLV3HDsUA99GOzeLt+/VGL7DsmVtPPxjq+5HDzqnwDfTWJaeszxNaApz1OYlwoZBzo6VhEcEugAB6VP2r7ayvboHqkqufObcK9hO+Hil0eNOp3jwX3kFm3k+aRX45R2K+8voTYIZTR2yMydBPFaLO06MxE7zuD1/j6F2wyfrLrReqwMHaL83ADf19IPP0olHYByMRwbhgOLHD6uplRSg3+t2d+CixkCw8xVxi/EMpYc8crAFATvLHxIDxdJwCB+dCazDWIYKE/WgpgCT0TqU2/hzYCiHdVc3dwA4kMmxSk6MEnzxrO46bB/ZkXBK++N/jyaei0JksNNZ40wZqO35K7m6PjAjCtbq1paOY0/o3Zx8BaUz+tQgmhzRVCDBAdU+e/YILWE6XkojClz/oGRWgPRzUZ/oGh9ebULKPCFVtS0iXjWeILE+WZWtRi/3VEDSZUdjdwxsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3027.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(6506007)(33656002)(186003)(52536014)(41300700001)(5660300002)(8936002)(316002)(478600001)(54906003)(110136005)(7696005)(86362001)(9686003)(122000001)(6636002)(26005)(38100700002)(38070700005)(4326008)(66946007)(66446008)(76116006)(64756008)(8676002)(66476007)(66556008)(71200400001)(55016003)(53546011)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gh6GUyuJSr0JQ6qDfuLYncMpUF5E19GEZV55E7QSd4MfXoW8e4rxTsmh6N7o?=
 =?us-ascii?Q?U6eAxkWTk7EDsbrQ7twYEVTNvnW8sTI15Oomis5L0Q+qmoVwunI2OlSStal8?=
 =?us-ascii?Q?w/IGSSPjnBh+V3mjvmw6WkGbs6MbTHkAG0MM6oMGWW+W5/1aggdheYgQvBXX?=
 =?us-ascii?Q?Lql2Thja2F8a9IOCh+9ilYl6kuGn88GfWz+NQNU12X0YF0NA9vK12GOYA7WZ?=
 =?us-ascii?Q?d1slbaZ6GydkXi0VVupVqu4PoPNFQY1skvNh435+jj2r/JJbLp0aWwJ+utYQ?=
 =?us-ascii?Q?t+uCNtFcIOqrRB/NjVA+xJk8mRN0gvGaCQBg1yy+7cTAzwG6H9ep2HUp118u?=
 =?us-ascii?Q?ehi0hVAIelbfl05nDTnBtYuVHi60Chid5AExyNHYB+AeiYNgnAoIMHQ5gjG6?=
 =?us-ascii?Q?tniVMHAEqsQOb/IWUk0J/KjsxpZ5RC71SVkY9WXpuWsayN7L/tWyqYj/+qCS?=
 =?us-ascii?Q?3WH9wFftqjZ8+U0EgJDI5VyPtpbe9qmm04WZfWyfbVu3CMtVxHb/2j4sLFxH?=
 =?us-ascii?Q?/b1sZuJvWUk+iDh/w7MGbA/62V0QGgDImXvhteVcTUGAvul7/4+cV7Fci8ZD?=
 =?us-ascii?Q?XYG8XtqWP5buj0PNkzwKg4isQMH9tyoEBS0xTf7pZ/8MnedMaNSD9Lug5m/z?=
 =?us-ascii?Q?fNdFYSZHcuBJuZp7uVcLJxtE+bCWjJ7HG+aj2vHflFpfuPJhaoRt2Z2V66Ex?=
 =?us-ascii?Q?OT1hWTwj0C4LcC0XglxEnq0fAxgIPMIAgaKK1c8+Z9XuqtdKleJssg1cLWZX?=
 =?us-ascii?Q?5KLv2GD9ljuW++Eqdggc/nC5qLS5c+nv2M9jAKQBKPRbusTTcllS5MueyNYN?=
 =?us-ascii?Q?YfjYBr/WQmSWQYtUPNU4mCwqQBeniBGFebKuOqQI0voxH/0VkFVep4vCoCR3?=
 =?us-ascii?Q?KWnMx2p1tdTIYRDTolvxya/jAT9W+p4ojl9tGIBVyVH/Uw5nnsaL15yRbEfT?=
 =?us-ascii?Q?mLjOjHuDR3PUUBbLlM5bZAlDnbmngYDERHnXKL/f2ijp4qKZYXf7yXLPLu4/?=
 =?us-ascii?Q?lFtEQm9vjWhdu7QmpMWUwRN3qZh15xvrFLdzsMYYGsYyHOeWSEvVdHDSvJla?=
 =?us-ascii?Q?CgXhl84PtsfQhHK+OeIDjxqV64w4zYLH0OKEZQKwKs+2/ov83mfKiAzBRgEZ?=
 =?us-ascii?Q?V5ukR5YuV6qUSs8jpRHG2uVlBra/0ueFono3K2ocNpnpG3N9YoQL2OLVMx9g?=
 =?us-ascii?Q?APEhBYZ6jjHLUCyTFtiuuWgH6RDFlbmznX415vS0WLYtdxcu89+8fIf0lBg2?=
 =?us-ascii?Q?ePUziGSKqT0j1oG9FgGN1ht6nOctXdfp1CIqHkyD2BaP0jwMyAGfsvuOc8xb?=
 =?us-ascii?Q?WEjyeNhtwylMiWIX/K927Gmsubk6J/R7XK/tC5/XUj2oCn9VbDdt6ECyMQck?=
 =?us-ascii?Q?gKIRqOtgh+K10Ht3Ct6zdlx+77iZewTiGsgB7nnLs0/TzRS0DEJ/6dSkWyZ2?=
 =?us-ascii?Q?kqT7TXvi43tXUCILmo5e1RygcKTdyUWeQ3UH3T9l1DwsDzk2MnCaePbP8J4b?=
 =?us-ascii?Q?IxU3Lbs4Nv1eb1fp2/qZVzo5uOxc4BolTqEn2x+RbOF8MpRCt6qMsBcPh28G?=
 =?us-ascii?Q?Dr6K7EfttZKQNI2GP6sOSLUiDFeW7fX+iSbO1K6j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3027.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b155eb-dc9c-488b-c590-08dabd6618ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:39:02.9450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+Cf7TSsRW/2hV7BrrDg9btNXzVUd8fHDUs1i7VtOGjDerN5T95gGZtePnF/fXRIIfEWLZHxql90P1nxvA2Rew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Hawking,

This patch is to skip ras init in sriov case. Please help review.

Thanks,
Yubiao

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com>=20
Sent: Thursday, November 3, 2022 11:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@am=
d.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <H=
awking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@=
amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Wang, YuBiao <YuBiao.=
Wang@amd.com>
Subject: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case

In sriov guest side doesn't need init ras feature, so skip it.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 84a76c36d9a7..be8ed617e269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
=20
-	if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
+	if (!amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(11, 0, 3)) {
 		r =3D gfx_v11_0_ras_late_init(handle);
 		if (r)
 			return r;
--=20
2.25.1

