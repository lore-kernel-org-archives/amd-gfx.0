Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E20C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 13:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD33D8F248;
	Fri,  5 Aug 2022 13:04:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251A29B31A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 13:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2dhZeEP1rALC6pQA57dXWpLRuG4homQvrb+t3njqqHLeSlxZRqaY9UyMAHd1GpWnCtjf0CW0/kiWYzHPSIM72aT89WjaswgMuMW7P5xPj17D18q3aOkBc9ojTaWs6YCo7aVnr5vliETDFoa1pWEzcuUnJPG5rsFrs1c5FfMWFxnc67wROI/wL8H0uftSFzOgFdq4jn81QUKYDCEZc5djg1a8iQDR27ubLX5XySdArbC4djPELAPiLfAEyZDwJb956Fnddmhg7LD9MYKXMXpqI+2lbgRckbV3+yZky/V3t2ZNl69yzDGbkbS+4GewotwKpsRV5A7Af5uUXn/xYOk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCqfHdB5inuiZ2d+yy9gRbkt9L+w1/L8vXap4iaU0Ng=;
 b=RxJmCID/MPlYsreDuQUetQRUseEwrP7Ry3u/cC0yKEkSbiaqmhyljjfPtFOtsDSrg9azASnacs3+GfoejqJoZM59T34/PJs//TVGMkVdFp8ALxCDJivdkzLf88kReVHpq2pCtO1URHqOXr68PWxilfRMdX5qeJs2m039zy/qcW4ZEJ8QQhpAHwbixWZrXuSqhf03P70eEemdwNb/r7sGjFb5PtZSle8QVakF//IwW2gqKaWaWf70cP8YekHSu//IOa7r0647ZtxI2JQKmxTcAChQpeOFNZyrR30CWNF6W2axho4kCqm0t0USXK/xFtpA97nOD/bTKLMLi32ITl4lsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCqfHdB5inuiZ2d+yy9gRbkt9L+w1/L8vXap4iaU0Ng=;
 b=EoI+cXmIhf6gklWZfwkH9/vb6Ncx4VPW7Dtef/PR1s/spQKf/suxz/z6FXyUFnwuVorwwgymP8URHf9wpiA9ftikjTpNZfEpFGWisJ19S8OdtCf1//l4Gyj/uTHrJCX4keNPFx/0tNw/7axNOP9Utzca2F+tDolGKQrfBHl5p9o=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 13:04:26 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%5]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 13:04:26 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable GFX Clock Gating control for GC IP
 v11.0.1
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable GFX Clock Gating control for GC
 IP v11.0.1
Thread-Index: AQHYqIHZMdZM3gS6d02YkZM9dTlVSq2gRpxQ
Date: Fri, 5 Aug 2022 13:04:26 +0000
Message-ID: <CY5PR12MB636900FEF20E50022AB62CC3C19E9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220805041327.2621649-1-tim.huang@amd.com>
 <20220805041327.2621649-2-tim.huang@amd.com>
In-Reply-To: <20220805041327.2621649-2-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-05T13:04:05Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db57fa4c-fae4-4317-ac27-62e5bb8a4b5e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-05T13:04:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3ae56cf5-9046-46ac-a9ff-d11204eb67b0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77353ccd-38a8-4aa0-c5bb-08da76e30657
x-ms-traffictypediagnostic: DM5PR12MB1244:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jTsBxrXl/V4+XFNIrlxA1gP3Qw9JWPjRxSpM6tSaV3lb36hkjkm42XB/qURcm0Tq0wFZWwzU51yjirO6zxZ7KnCZc+2vOLGoS9bK6u+YfcB3y1KPsghMN587qoIDxh7tJmZah5BVG08Y1yhiBVTHlty26fIuhhRSXh23BxNuU8rOIeXh9mr9EmE+e3CHxg1HthVndmCSVrH306JpbwD8yTjhQth5sFl7fG2h0iRno2nQdCIWreG0MyBS1RLD6jQX50Z82YVNdeswMspyU/UvZRzpTdN8DLo7o8ZsttAB8k84SAVZybn+ftk2++g8r52yUsHcPyH0hmzAekCDdfemSVLObQAeGZPCrFbzMgrdYQ7sEJwQ4boSWTcXNZNyiVXzr135nPfzvxFhP9vbFRZPDV9TyvhykZ9XsOmpSPEo2WEOkhjQ0jJeaMFaYIsig6/O1XcIaVAYkd1hS0ouPpeCyKDnOaEu5TjudaGDJ13UKTbq2P1u1d20HlOAQZ93CQ1PsU1t3g2wshYzK/tS/v9vyLCn3W5OumBEohIqGgxLxTHrfX1EzagcjWFEhW0kRT6RR0NjesZXRlavdJpRIyQT7aw0t3d1BkTM9aAgLloAGxRAOgPWTUroPu6lqrRQjVqmftiqUgULTnrsmWtFDzKD0dQkv4iktwGsJU80nReKH1A3Nregtiy33nSeMhTqxdHp8EfE6SYzi2sUoxltV39okN9bVHJuO0IwsErNPn6cBt7Cxu7AHJBWVI0P23F/6S7zeG+z0OqZ8uPZimvVrJdWP3X17WABKWDmR32xLEU2MZgRhCFzF1KabENZ5uol6R6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(53546011)(7696005)(6506007)(2906002)(86362001)(122000001)(9686003)(41300700001)(38070700005)(33656002)(26005)(55016003)(38100700002)(186003)(83380400001)(5660300002)(76116006)(66946007)(52536014)(478600001)(71200400001)(8676002)(4326008)(8936002)(66556008)(64756008)(54906003)(110136005)(66476007)(4744005)(66446008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kdcnz7upIbTPuOni1DnyM4J/8ceBcurUDVsr/vJhM77V4S5Fg1qu34YGy2Kf?=
 =?us-ascii?Q?i/sQnzApDdurTN/cWHQtGJr4Pkb1K0RMzXCQIEHBbrp7DZn7zjPQXLhZYsX9?=
 =?us-ascii?Q?d76Ex19/zkZ46NVMPGr0yHqmBkXMdoFZvlQprNt5HKDDpGXd6h2ROCOW3nS8?=
 =?us-ascii?Q?c6uIkFQSvnBw1xQBJrjL4y/q7w7zQx8VapETf1ttFn0gN1GyLJHp291j/v/s?=
 =?us-ascii?Q?x4Cqx9ae5cdTZTnbty5I3lWI1F4PD1jan96R1bd5laadAgYzmCXBVJoFNanB?=
 =?us-ascii?Q?2DlxUR/jL4UAyrB6GVFoKxghsCpf2JygeJH5bRsAc1GFg5tczVXJV3zTTvRU?=
 =?us-ascii?Q?patK+EGsfOp3NwmELwgy8YhJ4Z9e/0h6PEd8T77fuvEfQ3NoB9mCSIhmc1c3?=
 =?us-ascii?Q?2T08eun2N7G+m1wGlArjR/RCFpY5dfyy5jAE/p121m/+D0Y3TY6d9e1C4Ij2?=
 =?us-ascii?Q?/SjHr6aw81IjYDMrpiUiPhwWJZofzcHAWvgQft1aX6z9kElmlDXvGGFo2lOq?=
 =?us-ascii?Q?xIXpKO/o7EH2ChPwuIAuXtmi4zB57XlylKvRWYPEraGqsGs7X8j3LbHw2Z21?=
 =?us-ascii?Q?uwCC0tyycK1kPKaqXUituAg1KSpbMW3NRRwwCqiyibdyH2xTNXAwScveRd5w?=
 =?us-ascii?Q?DOqivs3IrJa6Mp6NIaKINeuHTSDSK3KAgHtQkGwkVtO9X96FgHdc/BM9xllJ?=
 =?us-ascii?Q?X+uMR6mS6E7MuM8x1LtwrG3CFSvwAHSvJaL4pBqz63Qa1YAmWX3bdB/1UH4P?=
 =?us-ascii?Q?H1W4xq3LR6LRz/fqxCNDuqs3rnfwEyIt2qqe832FR6hGkrTHt4DVmoo4uXuR?=
 =?us-ascii?Q?91MfK66tvIf31Vc5AZUqmB/J9lj/41RURuG9nDsgkHpmSYbFgHcXzd8Xi5Mg?=
 =?us-ascii?Q?go0TAH7rhsHh+N7z2JhwKwaoLyde1dydAR2LEyZd2dZY2OdWwJo14FF5peda?=
 =?us-ascii?Q?cqg1jaP8T6nnHy69CLB3WntpD6ESsepx9SHnGWOdVjrqyar+o/9gFPD1Mm9O?=
 =?us-ascii?Q?1M7YmqQYTyncZQC8ra/YUWqxczeHcbPFM/K64NBdtvrxfLts6KSFyuqed38j?=
 =?us-ascii?Q?yt+bL08+E8W/BF+B6YvxXR02fzc7lk+XvEQVghbbz3v0peGAvV+lhXNvSPlt?=
 =?us-ascii?Q?t9r75rxmZ+pCfCAE4QQ2LBvVLkEPgGIfZZZZrnOyp30TOktQ1tBMNpUPYZsP?=
 =?us-ascii?Q?HVLsynAFFjIE1L9g2i7X6GI6NBjZI7FupNxTdnDZEm2e3x+m/WtSRPUb6lW3?=
 =?us-ascii?Q?6VFKC/WbUoh+kOPKwa3S5NiXJX7yHNchIe90Tl0sueBY4y7URoLPxY7+Gvur?=
 =?us-ascii?Q?jGzumgnRXLsOS2Xgj4yMhlshgzPG5IulwaAVOvJqbDSWlI5jroKFJL/0+jyB?=
 =?us-ascii?Q?xVz0xQJgEvZSxnHjilfXShIsFIkLrNrxqhmKOUfab1oqBxpUrgW4lAmyliJg?=
 =?us-ascii?Q?aje0W9lWl2G8eKeGDGJgR7RMs5ASnBP9QOq8SYVDGLhjF17zYOnlpVKuTXDw?=
 =?us-ascii?Q?O0gbQ27dQL+gcpieLqwXBl5cJUF3vX1G+aBBAlivGmwl9Rs2n1Q08q8u3x9+?=
 =?us-ascii?Q?Kk2LwrUx7cOt37z1yWU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77353ccd-38a8-4aa0-c5bb-08da76e30657
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 13:04:26.1789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zrraZA7WqGjcOctWIu4OjcqJ2C3jYMA70kphCskr9z3TAGQDt//Cg/0nPMzT7S/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This series is=20

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Friday, August 5, 2022 12:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd=
.com>
Subject: [PATCH 2/2] drm/amdgpu: enable GFX Clock Gating control for GC IP =
v11.0.1

Enable GFX CG gate/ungate control.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 6fd71cb10e54..e03618803a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5310,6 +5310,7 @@ static int gfx_v11_0_set_clockgating_state(void *hand=
le,
=20
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state =3D=3D  AMD_CG_STATE_GATE);
--=20
2.25.1
