Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06614C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A45060E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A45060E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9F58972D;
	Wed, 11 Aug 2021 13:31:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7487589739
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 13:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxVatvVpXBz5UTDM8u7UTUXM/Jvvl3B/+wO0Yv4enkTQ3sujWnSk1SldAWpv1/hHLp9wi6voTSHEHxv5+1mH9sS6MDHu86YFyyi1WNB6iykdQ9LMAReAMWBjJtX20w3DykLRfMrV0dwtODBjio7bpvvduRBTsXSzT6q+zJrBs2sV8VOUolKqsouhuvfC1mISGW+VI4qU97BjLlyhsjuQAUzzWzRuQG3/wjvjI77DQ5S3Zyl1C2WP1w9WV0f1138exSQOw0BkRLaXHpazw5U4wFAKgiLFKAtnCfWQzBkLhuXQ4Q32ETBh2MUFqONzAHCcf41GYI5BZo94b//0XYMLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKO7E7aKKiAjglkQVJJrtuofCHQqcmyVlnXipS4L/uc=;
 b=n3Ep5rPDNqWvDjKi1gXayUuTtVwvTzI/d/XBvvyO8pOfherLm+trnjHG7KJ9uHlEncp8Sbfxzg3lbDTS3HQFk7E060jdt+qbqmEfe/2Cv9WjEaBgI/G3F/TWFqky58eUJu+UNmE56M25HwmieLNptPL/bTOj/h0EDJwKN9PLgAkmptxdQb42J+KQxFQT/SXBjvOJM2ZsjtTlREfg4lmmPlRMOxzC/h4r3FpsusYDslDXo5GxCsDUZJe7SzKxmlY7jPz+L7uxxWpPsf2daPDv0UxZyhrytvctP5wk1S3qUkstbdiRj2w59big8sgl0AS5mRQtgB54gPYsHChyXsyBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKO7E7aKKiAjglkQVJJrtuofCHQqcmyVlnXipS4L/uc=;
 b=J5CaK67dBdIE665cvx88CFJycpXnakVLh5DlXw4jp91ai840LBF5qJDD57gKquwfJ/5uUZYF8gB3FDUtx7MTvgh/KcQn2G76EF2b6GkaaXqKXZfaPigRmNvejfNJpGNPXimlZu1eQ9r5niTdCsmzdK+1S8YX+dqZHq/zx2mkUnM=
Received: from BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 11 Aug
 2021 13:31:40 +0000
Received: from BN9PR12MB5274.namprd12.prod.outlook.com
 ([fe80::9551:1f28:4224:ccbe]) by BN9PR12MB5274.namprd12.prod.outlook.com
 ([fe80::9551:1f28:4224:ccbe%8]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 13:31:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, Jack Zhang <Jack.Zhang1@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH v5] drm/amd/amdgpu embed hw_fence into amdgpu_job
Thread-Topic: [PATCH v5] drm/amd/amdgpu embed hw_fence into amdgpu_job
Thread-Index: AQHXjrGGReGMb2A6LkO4l+RbJGeQ3KtuTO+A
Date: Wed, 11 Aug 2021 13:31:40 +0000
Message-ID: <BN9PR12MB5274C6BA9856DF0B9F6201BF84F89@BN9PR12MB5274.namprd12.prod.outlook.com>
References: <20210811130156.375416-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210811130156.375416-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-11T13:31:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=209e73b3-9727-4644-b941-74d7ddb7d941;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86ca3427-e628-485c-03d2-08d95ccc5a09
x-ms-traffictypediagnostic: BN9PR12MB5049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5049A9DED7E1796E34F125A384F89@BN9PR12MB5049.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UJtgdvc/hFoSmQQG2W+8VpKiiEiehAIWmDo7EG/JiWICOZulsLtj/xOVYIpPTwQp3U8Atkt8/BA3TyDTRqHQxT4v8SOhJWofY+wpcfJEn6rGcTjTFkQ7/asTBC0+877LUKQlWc5+VbCgJM4RTlNed06AqJCE02sT9ihtpfWZ6nKqwHi8EnVOehT+h1mR4VofVljhRpOJO0dxFivFEterxkIOiL+HnJ0CWNGkTrXYneC1DTFsUY/+s3VME5xOGV1HXMjBj3JJly0NfB5LDkLxSLk6sCxsciX74Ua5+d+nKGZ/wheSsT5FmxcayOJh8IU0cgSZP2nHRPrijPFrjaEekMjy2Wtnq5x9wLNwgjSVEFBx91EQ0K7O88SOJjHke80K6QekSiS7qZxwDKrPsCtUvwRJr5oE+Vr0bwggtxVOyL02UFA2LF8goDr8Uq2mhPM/DrpwiA8Vykc0mwbHH9c3X+DL99ZY1NdrgLDPWVRRNILWWHtxz6iPYaSUMidlGQ7yrdMN4T7umt0L7ZvbzSv7Nxjtp9ku2SYA+GXJtbnDe+yIwI9MLViH392rYorI2ibMek463wwa2aWsAtSwQERpSBJYE1pW2+ZtG91h+woEIF0TkAqX+Jzf1EDuhkzSNtFx/izo4sw4o25ujAigo+EcXW6V43S5Yv3LYq0G4XhCx5vkTcq3Yy5o1poyd/PA8jaO5UuGC31ByI7kThogeC6mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5274.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(26005)(76116006)(66946007)(8936002)(66446008)(64756008)(66476007)(5660300002)(33656002)(66556008)(71200400001)(52536014)(2906002)(86362001)(186003)(478600001)(122000001)(30864003)(53546011)(6506007)(38100700002)(8676002)(7696005)(54906003)(316002)(9686003)(110136005)(55016002)(83380400001)(4326008)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dPuQUqHzHPwz5l5A2J+pZjkcg+rzMXzRackKlmk1JukwrIcOgL0bqlBKCcLK?=
 =?us-ascii?Q?M0pb4eVRsMsm/0xApnKqI1JAi2AnPlUCvO5ho7xJdUpxqO1Cu/n77j4LN+J0?=
 =?us-ascii?Q?cXlOVTICAa8SKWt7TrIgViIM+uCST/2sBue9oGBzXn+AYa1xSmZciEYllnkK?=
 =?us-ascii?Q?6GH15UavYVio5i+b+yaQl3AElx1AuaIyCI4JxO6RSeBKTerAXdXpVjOAnMbt?=
 =?us-ascii?Q?Y3/vnwCHW4TGY2N2ipPsGEbR4dbQLC2oqOpv7/1SxgnSjRi9EiWjWmistp0e?=
 =?us-ascii?Q?6aYsgaWSwSlRloYbnwM3B7Aksy1ZcO5yNlfiJQ4Q7jAktGDZcYQP0OUrEFDm?=
 =?us-ascii?Q?L/APvdLTygwZTM6FCjk7LMuvpDwn+EMqRuYtf6LSE7WGE6Obx6YsNw1Gxn/r?=
 =?us-ascii?Q?YUDI7o2/SG5DIuucGb+a8B8F5VHgeVIYUS3xh3ZyBaQ8F8+XUFgz/EXgizqL?=
 =?us-ascii?Q?EOZReI8QvgEyMU/XfTw8bZNZdkbT2mrTRamnyL1OPMnG9c3cnkDqPU0/tpxj?=
 =?us-ascii?Q?2VXaO/wtsd2YU2+j9VFq+6jr41RI5a7A9Di8siPutLqsW2hJLeJ5BBoA+Vee?=
 =?us-ascii?Q?HKnLC9hjJyXyOGP4j0hu7aDiShL8NFFigyf3080ZmTnDqm7ChnMSRg8sQtZv?=
 =?us-ascii?Q?8YHuwUAJXU4oicXRaU4Uxd9U7M9giJdLKrxwJ5J/rCdm1Ot8vdMwFtTfQqGr?=
 =?us-ascii?Q?zy3FDl0xNVXk+w1uncLEcJl0okL2ccw9wsbqhyZsjBQ44AMUEuNhTv72yI28?=
 =?us-ascii?Q?igADEIA1EJacuB5+XmRVwMXLjtUjeZU6DgLFlbHLifIef3IfIqLbHRPCxcqW?=
 =?us-ascii?Q?Z3VUknkMO8FVUnUgRAgertQjIUo8nrNkyxkWBMmnSBU8ELpeRjnotCI98M/T?=
 =?us-ascii?Q?bKF3JkJvaHFYlWTe5mfoVDkQuauwezPlT7qkciXLAfypT8xZ77F1JqffJExJ?=
 =?us-ascii?Q?9sDakdEDvVGknE3fASmb+3RpeTKcpGkgy7aYwWZYBAUvEzwDb5yQuLY0IRO+?=
 =?us-ascii?Q?GAMjDTDn/xzcwWsZe39EiTnrXlhoTB21cGFG/NaFJuv9QxDBean8qgxTnSJs?=
 =?us-ascii?Q?rFaIcaCFQPIRIstCTpJ0OIPHH+A1AWnI2STfBlXKl6/o46m8m4uBxg2oU4bz?=
 =?us-ascii?Q?OO0opBa3SXKjh1bWBN30grstk3RMJGaJoZd6uhfYOxrypGZ9A4gxA2y8U+j1?=
 =?us-ascii?Q?Yy3id0jQOlniB5LXWBsjmrdPQh09hQgHZugZ8C2PPq4NTUdlv6CYa6T2DTNB?=
 =?us-ascii?Q?ZX9unUBrmnButF6hAEeNX1RcYNupSMhIyAXAkD/+8AWMoZSUFVigXcN4XI5s?=
 =?us-ascii?Q?dVXSymg1RSpYwy3jxyPhSypd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5274.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca3427-e628-485c-03d2-08d95ccc5a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 13:31:40.1706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0etD+Pat0mEaJZqUMgrSTrTX+6z+AAq+UdbmfJdaYqwzQ+iTJJTm0PKNzkSkvaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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

[AMD Official Use Only]

Reviewed by: Monk Liu <monk.liu@amd.com>

Thanks=20

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com>=20
Sent: Wednesday, August 11, 2021 9:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.c=
om>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Jack Zhang <Jack.Zhang=
1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Jack Zhang <Jack.Zhang7@=
hotmail.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Subject: [PATCH v5] drm/amd/amdgpu embed hw_fence into amdgpu_job

From: Jack Zhang <Jack.Zhang1@amd.com>

Why: Previously hw fence is alloced separately with job.
It caused historical lifetime issues and corner cases.
The ideal situation is to take fence to manage both job and fence's lifetim=
e, and simplify the design of gpu-scheduler.

How:
We propose to embed hw_fence into amdgpu_job.
1. We cover the normal job submission by this method.
2. For ib_test, and submit without a parent job keep the legacy way to crea=
te a hw fence separately.
v2:
use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is embedded i=
n a job.
v3:
remove redundant variable ring in amdgpu_job
v4:
add tdr sequence support for this feature. Add a job_run_counter to indicat=
e whether this job is a resubmit job.
v5
add missing handling in amdgpu_fence_enable_signaling

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -  drivers/gpu/drm/amd/am=
dgpu/amdgpu_debugfs.c |  2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  =
| 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 86 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 39 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 9 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 7b46ba551cb2..3003ee1c9487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum k=
gd_engine_type engine,
 	ret =3D dma_fence_wait(f, false);
=20
 err_ib_sched:
-	dma_fence_put(f);
 	amdgpu_job_free(job);
 err:
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 536005bff24a..277128846dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct=
 amdgpu_ring *ring)
 			continue;
 		}
 		job =3D to_amdgpu_job(s_job);
-		if (preempted && job->fence =3D=3D fence)
+		if (preempted && (&job->hw_fence) =3D=3D fence)
 			/* mark the job as preempted */
 			job->preemption_status |=3D AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4c33985542ed..04a6bed4e5f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4448,7 +4448,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *a=
dev)  int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)  {
-	int i, r =3D 0;
+	int i, j, r =3D 0;
 	struct amdgpu_job *job =3D NULL;
 	bool need_full_reset =3D
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags); @@ -4472,6 +447=
2,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!ring || !ring->sched.thread)
 			continue;
=20
+		/*clear job fence from fence drv to avoid force_completion
+		 *leave NULL and vm flush fence in fence drv */
+		for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; j++) {
+			struct dma_fence *old, **ptr;
+
+			ptr =3D &ring->fence_drv.fences[j];
+			old =3D rcu_dereference_protected(*ptr, 1);
+			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
+				RCU_INIT_POINTER(*ptr, NULL);
+			}
+		}
 		/* after all hw jobs are reset, hw fence is meaningless, so force_comple=
tion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 7495911516c2..b439eb7d4177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -129,30 +129,50 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring=
)
  *
  * @ring: ring the fence is associated with
  * @f: resulting fence object
+ * @job: job the fence is embedded in
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,=20
+struct amdgpu_job *job,
 		      unsigned flags)
 {
 	struct amdgpu_device *adev =3D ring->adev;
-	struct amdgpu_fence *fence;
+	struct dma_fence *fence;
+	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
=20
-	fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
-	if (fence =3D=3D NULL)
-		return -ENOMEM;
+	if (job =3D=3D NULL) {
+		/* create a sperate hw fence */
+		am_fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
+		if (am_fence =3D=3D NULL)
+			return -ENOMEM;
+		fence =3D &am_fence->base;
+		am_fence->ring =3D ring;
+	} else {
+		/* take use of job-embedded fence */
+		fence =3D &job->hw_fence;
+	}
=20
 	seq =3D ++ring->fence_drv.sync_seq;
-	fence->ring =3D ring;
-	dma_fence_init(&fence->base, &amdgpu_fence_ops,
-		       &ring->fence_drv.lock,
-		       adev->fence_context + ring->idx,
-		       seq);
+	if (job !=3D NULL && job->job_run_counter) {
+		/* reinit seq for resubmitted jobs */
+		fence->seqno =3D seq;
+	} else {
+		dma_fence_init(fence, &amdgpu_fence_ops,
+				&ring->fence_drv.lock,
+				adev->fence_context + ring->idx,
+				seq);
+	}
+
+	if (job !=3D NULL) {
+		/* mark this fence has a parent job */
+		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
+	}
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
@@ -175,9 +195,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct =
dma_fence **f,
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
+	rcu_assign_pointer(*ptr, dma_fence_get(fence));
=20
-	*f =3D &fence->base;
+	*f =3D fence;
=20
 	return 0;
 }
@@ -621,8 +641,16 @@ static const char *amdgpu_fence_get_driver_name(struct=
 dma_fence *fence)
=20
 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)  {
-	struct amdgpu_fence *fence =3D to_amdgpu_fence(f);
-	return (const char *)fence->ring->name;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+		struct amdgpu_job *job =3D container_of(f, struct amdgpu_job,=20
+hw_fence);
+
+		ring =3D to_amdgpu_ring(job->base.sched);
+	} else {
+		ring =3D to_amdgpu_fence(f)->ring;
+	}
+	return (const char *)ring->name;
 }
=20
 /**
@@ -635,13 +663,20 @@ static const char *amdgpu_fence_get_timeline_name(str=
uct dma_fence *f)
  */
 static bool amdgpu_fence_enable_signaling(struct dma_fence *f)  {
-	struct amdgpu_fence *fence =3D to_amdgpu_fence(f);
-	struct amdgpu_ring *ring =3D fence->ring;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+		struct amdgpu_job *job =3D container_of(f, struct amdgpu_job,=20
+hw_fence);
+
+		ring =3D to_amdgpu_ring(job->base.sched);
+	} else {
+		ring =3D to_amdgpu_fence(f)->ring;
+	}
=20
 	if (!timer_pending(&ring->fence_drv.fallback_timer))
 		amdgpu_fence_schedule_fallback(ring);
=20
-	DMA_FENCE_TRACE(&fence->base, "armed on ring %i!\n", ring->idx);
+	DMA_FENCE_TRACE(f, "armed on ring %i!\n", ring->idx);
=20
 	return true;
 }
@@ -656,8 +691,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_f=
ence *f)  static void amdgpu_fence_free(struct rcu_head *rcu)  {
 	struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_fence *fence =3D to_amdgpu_fence(f);
-	kmem_cache_free(amdgpu_fence_slab, fence);
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+	/* free job if fence has a parent job */
+		struct amdgpu_job *job;
+
+		job =3D container_of(f, struct amdgpu_job, hw_fence);
+		kfree(job);
+	} else {
+	/* free fence_slab if it's separated fence*/
+		struct amdgpu_fence *fence;
+
+		fence =3D to_amdgpu_fence(f);
+		kmem_cache_free(amdgpu_fence_slab, fence);
+	}
 }
=20
 /**
@@ -680,6 +727,7 @@ static const struct dma_fence_ops amdgpu_fence_ops =3D =
{
 	.release =3D amdgpu_fence_release,
 };
=20
+
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index ec65ab0ddf89..c076a6b9a5a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
=20
-	r =3D amdgpu_fence_emit(ring, f, fence_flags);
+	r =3D amdgpu_fence_emit(ring, f, job, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index d33e6d97cc89..de29518673dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job=
)  {
 	struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
+	struct dma_fence *hw_fence;
 	unsigned i;
=20
-	/* use sched fence if available */
-	f =3D job->base.s_fence ? &job->base.s_fence->finished : job->fence;
+	if (job->hw_fence.ops =3D=3D NULL)
+		hw_fence =3D job->external_hw_fence;
+	else
+		hw_fence =3D &job->hw_fence;
=20
+	/* use sched fence if available */
+	f =3D job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
 	for (i =3D 0; i < job->num_ibs; ++i)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);  } @@ -142,20 +147,27 @@ st=
atic void amdgpu_job_free_cb(struct drm_sched_job *s_job)
=20
 	drm_sched_job_cleanup(s_job);
=20
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+    /* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops !=3D NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
=20
 void amdgpu_job_free(struct amdgpu_job *job)  {
 	amdgpu_job_free_resources(job);
-
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+	/* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops !=3D NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
=20
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *ent=
ity, @@ -184,11 +196,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *=
job, struct amdgpu_ring *ring,
=20
 	job->base.sched =3D &ring->sched;
 	r =3D amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
-	job->fence =3D dma_fence_get(*fence);
+	/* record external_hw_fence for direct submit */
+	job->external_hw_fence =3D dma_fence_get(*fence);
 	if (r)
 		return r;
=20
 	amdgpu_job_free(job);
+	dma_fence_put(*fence);
+
 	return 0;
 }
=20
@@ -246,10 +261,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sc=
hed_job *sched_job)
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
-	/* if gpu reset, hw fence will be replaced here */
-	dma_fence_put(job->fence);
-	job->fence =3D dma_fence_get(fence);
=20
+	if (!job->job_run_counter)
+		dma_fence_get(fence);
+	else if (finished->error < 0)
+		dma_fence_put(&job->hw_fence);
+	job->job_run_counter++;
 	amdgpu_job_free_resources(job);
=20
 	fence =3D r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h
index 81caac9b958a..9e65730193b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -46,7 +46,8 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct amdgpu_ib	*ibs;
-	struct dma_fence	*fence; /* the hw fence */
+	struct dma_fence	hw_fence;
+	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	uint32_t		num_ibs;
@@ -62,6 +63,9 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
+
+	/* job_run_counter >=3D 1 means a resubmit job */
+	uint32_t		job_run_counter;
 };
=20
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs, diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu=
/amdgpu_ring.h
index 9c11ced4312c..e713d31619fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -48,6 +48,9 @@
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
=20
+/* fence flag bit to indicate the face is embedded in job*/
+#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
+
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
=20
 #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
@@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *=
adev);  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);  int =
amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);  void amdgpu_fence=
_driver_sw_fini(struct amdgpu_device *adev); -int amdgpu_fence_emit(struct =
amdgpu_ring *ring, struct dma_fence **fence,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence=20
+**fence, struct amdgpu_job *job,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 2a88ed5d983b..2af8860d74cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
=20
 	if (vm_flush_needed || pasid_mapping_needed) {
-		r =3D amdgpu_fence_emit(ring, &fence, 0);
+		r =3D amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
 	}
--
2.25.1
