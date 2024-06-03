Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CDC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2303E10E306;
	Mon,  3 Jun 2024 08:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvMZM6vC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348DA10E306
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eipQmiDnLHsrRsSpdRz7gDAAo0Dzblt9jCtDqU3oJXIUS8fG+Ib1g/gFdoquC39nSFdfClFDAU4KWsimqiZwFDCi89Dv3mFmquCS/efOPkTf+Usr+vMwi26tQlCzx/r1G+aUYFVRME6CZTIwl4U5dD1MckflatkS8nvYlp1R55uRP6U6Pj5dbXcMjIsnGsMSb/Rb0b4w965M6HsdMcDGYpGLEVPNT+YiFr78hWVXTQ0wuhiGlETq3vY/8oDYLhTdl7PFz9XV/2RkEUhONzLP5V2ZE49W0qO2geBaNHUt+mN1cNjwGBhyRhiSUdvMUot2MbVYVmxB7fDOawSsdoU6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g2ddJYhPAYE1N51D+Jsty+YtW+7h2FMDfi6kwVQCFM=;
 b=Q6i4z9+SQ155h/pQhSxZTUoOQsA9X73O35M1upK/CSSRmRh1Wz2fty8ddkZhVyPI0XKRzoCVhOsEW6Eb9aPRjWHL7El9wPRR3G09Gv3VY34lmjZh6aiZ8Yfy2WVGTbCuPSi+ph9jYU65/n7eU5xv2FN4NB6omKEgDKqevN3vWEH6rchcI61aQBsYM7FHD4WOVy1eG0cS0vLVE704WdkHrpQ+l2TqlkHj9uBb+TtExAkKNEAgg+rzl0wxP/5n0bzMOdw8Sbip+XefGg8dA0qA7gJZLSoPEFVfsqNmyoQF1ajdTfox5DDPcHIXKPyzZo7Pc6r+6FkGs78EorD0HkP/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g2ddJYhPAYE1N51D+Jsty+YtW+7h2FMDfi6kwVQCFM=;
 b=MvMZM6vCZ0TYSW4MdgVSyTD9ooKcy1oRQdM1Pq5Y4lFmqlLqORjSdxlY7FkKnY7ePAlqEgpVsmkESnIBoU3nSMp2Eu9fUZsCl6YwX5tpy1DJLHk0PqqXfDq6p/IiTIUyuEL96vrb0v62Y7fnMGoIzKLrN7aZApNimd59rIg2z84=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Mon, 3 Jun 2024 08:03:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 08:03:50 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Huang,
 JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event
Thread-Topic: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event
Thread-Index: AQHas2x8Imeryv+y1U2h+74OvFPJULG1sHBA
Date: Mon, 3 Jun 2024 08:03:50 +0000
Message-ID: <DS0PR12MB78046739F480CF153C36FB6697FF2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240531150818.119896-1-jinhuieric.huang@amd.com>
In-Reply-To: <20240531150818.119896-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3c309847-068f-4c1b-80a3-e2116d8fb0cb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T07:57:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6855:EE_
x-ms-office365-filtering-correlation-id: 28a892fb-9919-4d1b-8a78-08dc83a3b41f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HVFoadTykjz+8la8KzjpWmO1wLPWHl7x2gMnnM+QPjkuYJ9fDh5V7/fgkK/B?=
 =?us-ascii?Q?KkMR0yEIUPy5gFD829ZTxNfGvgBdVXwciJDRa+GSJXEfVgbH9luj7V7RfZBI?=
 =?us-ascii?Q?UqNRYbObcXtKvRgMM6ANbtegUNaN3e9BY5FPBBrnqpJuWKtkm8A762cOnXIZ?=
 =?us-ascii?Q?lZRkIthe/6wnRPECBJuzrFq6q8MHgZiNZlbIWEnj6aqjQDF34NfHowcLqRR8?=
 =?us-ascii?Q?Qi6deDIEJz4wtX0WTeOn8WoDTzmxaM9F/sBUMO5cW0yylzUUEpigTKdfhXTI?=
 =?us-ascii?Q?bTM3R8ubp/WQfXQwmAbpY7F5pQ5hP51ZVYwpgZfihN++6E0jT8WcYa5PsSpr?=
 =?us-ascii?Q?9x27S+XVOaSd5rnCOnX2zmqEJHtE9E6oEw8GA6jT4Pg8Y+3kIpPGdBVj8UvP?=
 =?us-ascii?Q?ZoiHTV35tTEGg+LniWhhQ5Oej90dVKg66lOFE5PWOGZh6kAwZX5MWyz9to2x?=
 =?us-ascii?Q?s0dp4un/Yh6wWuxdiiNX4UHcRHlgA2DWPn0mlYWx3fxX9wtFzmUy4TejtpnH?=
 =?us-ascii?Q?7cmpTfSPr2YCZzuZCRKAld7ITxub1bjvl75BuL24FDfcWtqHXIU+T3wjFeaK?=
 =?us-ascii?Q?zhBNENrVD3z1iB3O55uagEMx0KFKESzmCahgsJNIeVqylY15YBeLCjpyKbVS?=
 =?us-ascii?Q?G2MIQyDbBFC2EAXdjO4MqVST97unjh7NWcYeM1sns5QUjFtLK2Vo1rNOtB0i?=
 =?us-ascii?Q?VWhTInCWG0yaTv3dhjXfn8pob5E0sk8wIdGOaFxfkeND641FjX2QXeRqp0T0?=
 =?us-ascii?Q?OZbNpoqTrBurgNOEbav+/hsXS9kiFT5r1zt4Gbl98usCPy3+xN0OMLZbNKgt?=
 =?us-ascii?Q?HCCiniL2R0r4s6GqLAmG6gEbji6Py0D37rJcTRsZ7N0DnATiz1hCrpXbP8M4?=
 =?us-ascii?Q?UHFXmvNul93sK/EQRbpGGyFP/LGd7X18ZwngM3dnNbYP+V8a2A+a/mBA4JHA?=
 =?us-ascii?Q?UtrHBZJXPErvL1oZcriAd7fS0vGzLxhl8s0O1czR4OSPdcTRcKYLWHaGdki7?=
 =?us-ascii?Q?9n9nMSX8S3q2eIYXcgo8zS8PcQlj045OlzZQbIADeROorPfq1dY7hohkgFjF?=
 =?us-ascii?Q?U6nXsM2wrwtWa8qt7aWEfgmdbPQp/wL4SmNDmgFv/xFGeMkMOnro2V77Z05y?=
 =?us-ascii?Q?zlgZnBEEyNZX3ewpaBcjUZX4LpfNZ/bd5x1DwBQ/oPxvSW6LzR+FJmn4w3dk?=
 =?us-ascii?Q?sBIZM1nOJepmZT00GlWSOz20XjMlsHEST656YNW9/5NWe5BjaxQNH4ORmAOF?=
 =?us-ascii?Q?WvDAnbFLJ9WXAqWB6hRFvSW8gJykvPvJxzeOIJiEC4rIW8DbePW+GICvfn1S?=
 =?us-ascii?Q?PuERP2ac+g92reK0yTiLqcqAdl77XzP20lznt/ESFaHREw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AwThtU+KOrrN26QoV3O9CqAAD7sq8ozSUp5S/hFpOa5nn/kEuxPy1Fy+KQwP?=
 =?us-ascii?Q?r5oIaz/bf109c6aNbSO3cIGGSQEZtxr20qCu1Pg/x4lG9G3CYgUY9e1j3sVf?=
 =?us-ascii?Q?h3EphXKAiYC1qJp1lnoB6hT2rNP+adq3H7y3AzE3VuV7ufK2zRqT7GUQyqeX?=
 =?us-ascii?Q?OMXbMJJ4QNz9fd8VMqrIi4NvPMIhn3ztPxLa+0bHL5il5q3nDBqOT7MGm85w?=
 =?us-ascii?Q?89iXynnT3Bga1uL8aG2Hk84lXlMz3RXKJ4X55BQFRrvc+cTHNvApO5N/KxW4?=
 =?us-ascii?Q?M5855pz84jm9kiZgijDgQOoeTT5kPr9MjTrafFK/5ms/mr3OVjUgJlwcElEB?=
 =?us-ascii?Q?vHRUL0nyIRSWWAE6BZujd3E83uKoLk0kkkp90fO4zwHFBuxWYB4JcMrnEGYG?=
 =?us-ascii?Q?b9T33luqqgsb0WOwcZ/dWdygPGECcB30n8Uk5NucgqBRUCyG3hc1fG7K31SK?=
 =?us-ascii?Q?l4za6Qo8Zsq9nJvm3iGW1yjPQ/6JqWqxwp5e8+Pn4vj9EHZeu97+vVxuPmYl?=
 =?us-ascii?Q?bxlTn0uOlOKYDpbGE2gnGrgXOjg+hnZQzHiizHnMWl9bKnDlwvaMG709KhyX?=
 =?us-ascii?Q?Qp/9PnD/Jj20l/1epDYjsrUY8CYJNbgNh+RI/X2yQGyjwkPjncU8N/qqaZ7b?=
 =?us-ascii?Q?d+Uv4BBkyiRgiCtwXIoi5X3ULf8GyepwP/1Erg9wdEoizcOOTN9Sqb4bx0VN?=
 =?us-ascii?Q?+icQ9hORH4fLynWOWEUeGfwFIEj3/1ZtJy5bj2offXpKN+SPVOeeqGR0mMQo?=
 =?us-ascii?Q?fVugvTtM+5ccH+nZYp9GFGY9Y5lQ0xXsXLmqsP1KKXMiDBU7OlX6fAXWLVEK?=
 =?us-ascii?Q?/HWxhc1DeIybompwikPbUzXySSYTWJp5LdtDDqCPawbaS48xIrosugYfU0Vt?=
 =?us-ascii?Q?sDsTvbRiOZb+CqsbblvVZeYUO1WEpyjyCuuiOv+lfRA2k7T2w6ksXUTAgafW?=
 =?us-ascii?Q?XzlljWYtvxAkl3rZlETbS3w8Ug3CZt/gbRfPM7h9BEO/VeZF3M6q706/nFJ2?=
 =?us-ascii?Q?cBzWG3m4cCHrYddSzmobpiYBY5/9DXfV84PAw0Sa3IR9taMsYucYPb8C9hNI?=
 =?us-ascii?Q?UdCIrizTRFWdXYquFDLFsLz8GtkSTrA/GfUjwWORs/vH/pzKT4hH8dpXYb4R?=
 =?us-ascii?Q?YAHE0bnPOAfYEgOpCEByTEuglesQNmnNod6MLjN8OO7b3el4BK8XEP0A2Qai?=
 =?us-ascii?Q?IX4LfyoZxSNkWWonar5YWfiWJvgXadGdi1LA9a4eP5gvheNIhNm/JXSNEF8X?=
 =?us-ascii?Q?Q9JPu2hU2ipVaTRR/CnGbmhX4jlR1G2KXKU3D+Kkc2Lhyu+kCZg17NloT5pS?=
 =?us-ascii?Q?lHuKGy75UJtbGst1P6zqbQ//XOWt6EKABBsK4Jvf9ZsCDtBTp3b3ocJJv/U1?=
 =?us-ascii?Q?kcqlnu5XKuQTRkzlHyLkVjbfjAd4FFbjBwZPmLIqDbFgvLAPHOYMa55YmUqS?=
 =?us-ascii?Q?+VEHOeINCVfCzbhcfSGWaT+GARbQqtzFxXd6+w2U4khsXD0JVRY4eYWTocH6?=
 =?us-ascii?Q?JrvNqrs36tuM88FA83X4D0a2jaa4zApr/1NAjugROdObKKJYiAkw7uVSJrVO?=
 =?us-ascii?Q?TJRjlq8536Rk1uQeK9Y=3D?=
Content-Type: multipart/mixed;
 boundary="_002_DS0PR12MB78046739F480CF153C36FB6697FF2DS0PR12MB7804namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a892fb-9919-4d1b-8a78-08dc83a3b41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 08:03:50.4096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLZ/NPonoLmCNooq7ADnAnnU1DsIH73CWAEzGJ9TrhTp7d6cCwx3HWZJZow36WfN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

--_002_DS0PR12MB78046739F480CF153C36FB6697FF2DS0PR12MB7804namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Eric,

To consider other reset cases also, you may have something like attached.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Hua=
ng
Sent: Friday, May 31, 2024 8:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Huang, JinHui=
Eric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: add reset cause in gpu pre-reset smi event

reset cause is requested by customer as additional info for gpu reset smi e=
vent.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 34 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  7 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 13 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  5 +-
 9 files changed, 133 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index e3738d417245..3588c912214a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -125,17 +125,26 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgp=
u_device *adev,  static void amdgpu_amdkfd_reset_work(struct work_struct *w=
ork)  {
        struct amdgpu_device *adev =3D container_of(work, struct amdgpu_dev=
ice,
-                                                 kfd.reset_work);
-
-       struct amdgpu_reset_context reset_context;
+                                                 kfd.reset_work.work);
+
+       if (adev->kfd.reset_work.reset_context) {
+               amdgpu_device_gpu_recover(
+                               adev, NULL,
+                               (struct amdgpu_reset_context *)
+                               adev->kfd.reset_work.reset_context);
+               kfree(adev->kfd.reset_work.reset_context);
+               adev->kfd.reset_work.reset_context =3D NULL;
+       } else {
+               struct amdgpu_reset_context reset_context;

-       memset(&reset_context, 0, sizeof(reset_context));
+               memset(&reset_context, 0, sizeof(reset_context));

-       reset_context.method =3D AMD_RESET_METHOD_NONE;
-       reset_context.reset_req_dev =3D adev;
-       clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+               reset_context.method =3D AMD_RESET_METHOD_NONE;
+               reset_context.reset_req_dev =3D adev;
+               clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);

-       amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+               amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+       }
 }

 static const struct drm_client_funcs kfd_client_funcs =3D { @@ -225,7 +234=
,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)

                amdgpu_amdkfd_total_mem_size +=3D adev->gmc.real_vram_size;

-               INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
+               INIT_WORK(&adev->kfd.reset_work.work, amdgpu_amdkfd_reset_w=
ork);
        }
 }

@@ -261,12 +270,13 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, =
bool run_pm)
        return r;
 }

-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+                           struct amdgpu_reset_context *reset_context)
 {
        int r =3D 0;

        if (adev->kfd.dev)
-               r =3D kgd2kfd_pre_reset(adev->kfd.dev);
+               r =3D kgd2kfd_pre_reset(adev->kfd.dev, reset_context);

        return r;
 }
@@ -285,7 +295,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev=
)  {
        if (amdgpu_device_should_recover_gpu(adev))
                amdgpu_reset_domain_schedule(adev->reset_domain,
-                                            &adev->kfd.reset_work);
+                                            &adev->kfd.reset_work.work);
 }

 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..1fc9ed33a1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };

 struct amdgpu_device;
+struct amdgpu_reset_context;

 enum kfd_mem_attachment_type {
        KFD_MEM_ATT_SHARED,     /* Share kgd_mem->bo or another attachment'=
s */
@@ -98,12 +99,17 @@ struct amdgpu_amdkfd_fence {
        struct svm_range_bo *svm_bo;
 };

+struct kfd_reset_work {
+       struct work_struct work;
+       void *reset_context;
+};
+
 struct amdgpu_kfd_dev {
        struct kfd_dev *dev;
        int64_t vram_used[MAX_XCP];
        uint64_t vram_used_aligned[MAX_XCP];
        bool init_complete;
-       struct work_struct reset_work;
+       struct kfd_reset_work reset_work;

        /* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
        struct dev_pagemap pgmap;
@@ -170,7 +176,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_d=
evice *adev);

 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);

-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+                           struct amdgpu_reset_context *reset_context);

 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);

@@ -416,7 +423,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void kgd=
2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct kfd_dev=
 *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);=
 -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+                     struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);  void kgd2kfd_interrupt(struc=
t kfd_dev *kfd, const void *ih_ring_entry);  void kgd2kfd_set_sram_ecc_flag=
(struct kfd_dev *kfd); @@ -459,7 +467,8 @@ static inline int kgd2kfd_resume=
(struct kfd_dev *kfd, bool run_pm)
        return 0;
 }

-static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+                               struct amdgpu_reset_context *reset_context)
 {
        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6711836054f9..a9fb9b181584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5642,8 +5642,11 @@ static inline void amdgpu_device_stop_pending_resets=
(struct amdgpu_device *adev)
                cancel_work(&adev->reset_work);
 #endif

-       if (adev->kfd.dev)
-               cancel_work(&adev->kfd.reset_work);
+       if (adev->kfd.dev) {
+               kfree(adev->kfd.reset_work.reset_context);
+               adev->kfd.reset_work.reset_context =3D NULL;
+               cancel_work(&adev->kfd.reset_work.work);
+       }

        if (amdgpu_sriov_vf(adev))
                cancel_work(&adev->virt.flr_work);
@@ -5775,7 +5778,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,

                cancel_delayed_work_sync(&tmp_adev->delayed_init_work);

-               amdgpu_amdkfd_pre_reset(tmp_adev);
+               amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);

                /*
                 * Mark these ASICs to be reseted as untracked first diff -=
-git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_reset.h
index 5a9cc043b858..7ef500992f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ struct amdgpu_reset_context {
        struct amdgpu_hive_info *hive;
        struct list_head *reset_device_list;
        unsigned long flags;
+       char reset_cause[32];
 };

 struct amdgpu_reset_handler {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index a72683f83390..cf0908996765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct w=
ork_struct *work)
                    amdgpu_sriov_runtime(adev)) {
                        amdgpu_ras_set_fed(adev, true);
                        if (amdgpu_reset_domain_schedule(adev->reset_domain=
,
-                                                         &adev->kfd.reset_=
work))
+                                                         &adev->kfd.reset_=
work.work))
                                return;
                        else
                                dev_err(adev->dev, "Failed to queue work! a=
t %s", __func__); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_device.c
index fba9b9a258a5..52be4e340fb1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
        kfree(kfd);
 }

-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+                     struct amdgpu_reset_context *reset_context)
 {
        struct kfd_node *node;
        int i;
@@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)

        for (i =3D 0; i < kfd->num_nodes; i++) {
                node =3D kfd->nodes[i];
-               kfd_smi_event_update_gpu_reset(node, false);
+               kfd_smi_event_update_gpu_reset(node, false, reset_context);
                node->dqm->ops.pre_reset(node->dqm);
        }

@@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
        for (i =3D 0; i < kfd->num_nodes; i++) {
                node =3D kfd->nodes[i];
                atomic_set(&node->sram_ecc_flag, 0);
-               kfd_smi_event_update_gpu_reset(node, true);
+               kfd_smi_event_update_gpu_reset(node, true, NULL);
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 485e26abc619..b6473110514f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -37,6 +37,7 @@
 #include "amdgpu_amdkfd.h"
 #include "mes_v11_api_def.h"
 #include "kfd_debug.h"
+#include "amdgpu_reset.h"

 /* Size of the per-pipe EOP queue */
 #define CIK_HPD_EOP_BYTES_LOG2 11
@@ -246,6 +247,23 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
        r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
        amdgpu_mes_unlock(&adev->mes);
        if (r) {
+               struct amdgpu_reset_context *reset_context =3D
+                               kzalloc(sizeof(struct amdgpu_reset_context)=
,
+                                       GFP_KERNEL);
+
+               if (!reset_context) {
+                       pr_err("No memory to allocate reset context!\n");
+               } else {
+                       reset_context->method =3D AMD_RESET_METHOD_NONE;
+                       reset_context->reset_req_dev =3D dqm->dev->adev;
+                       clear_bit(AMDGPU_NEED_FULL_RESET,
+                                 &reset_context->flags);
+                       strscpy(reset_context->reset_cause, "MES_hang",
+                               sizeof(reset_context->reset_cause));
+                       dqm->dev->adev->kfd.reset_work.reset_context =3D
+                                       (void *)reset_context;
+               }
+
                dev_err(adev->dev, "failed to add hardware queue to MES, do=
orbell=3D0x%x\n",
                        q->properties.doorbell_off);
                dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n"); @@ -274,6 +292,23 @@ static int remove_queue_mes(struc=
t device_queue_manager *dqm, struct queue *q,
        amdgpu_mes_unlock(&adev->mes);

        if (r) {
+               struct amdgpu_reset_context *reset_context =3D
+                               kzalloc(sizeof(struct amdgpu_reset_context)=
,
+                                       GFP_KERNEL);
+
+               if (!reset_context) {
+                       pr_err("No memory to allocate reset context!\n");
+               } else {
+                       reset_context->method =3D AMD_RESET_METHOD_NONE;
+                       reset_context->reset_req_dev =3D dqm->dev->adev;
+                       clear_bit(AMDGPU_NEED_FULL_RESET,
+                                 &reset_context->flags);
+                       strscpy(reset_context->reset_cause, "MES_hang",
+                               sizeof(reset_context->reset_cause));
+                       dqm->dev->adev->kfd.reset_work.reset_context =3D
+                                       (void *)reset_context;
+               }
+
                dev_err(adev->dev, "failed to remove hardware queue from ME=
S, doorbell=3D0x%x\n",
                        q->properties.doorbell_off);
                dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n"); @@ -1983,6 +2018,23 @@ static int unmap_queues_cpsch(s=
truct device_queue_manager *dqm,
        retval =3D amdkfd_fence_wait_timeout(dqm, KFD_FENCE_COMPLETED,
                                           queue_preemption_timeout_ms);
        if (retval) {
+               struct amdgpu_reset_context *reset_context =3D
+                               kzalloc(sizeof(struct amdgpu_reset_context)=
,
+                                       GFP_KERNEL);
+
+               if (!reset_context) {
+                       pr_err("No memory to allocate reset context!\n");
+               } else {
+                       reset_context->method =3D AMD_RESET_METHOD_NONE;
+                       reset_context->reset_req_dev =3D dqm->dev->adev;
+                       clear_bit(AMDGPU_NEED_FULL_RESET,
+                                 &reset_context->flags);
+                       strscpy(reset_context->reset_cause, "HWS_hang",
+                               sizeof(reset_context->reset_cause));
+                       dqm->dev->adev->kfd.reset_work.reset_context =3D
+                                       (void *)reset_context;
+               }
+
                dev_err(dev, "The cp might be in an unrecoverable state due=
 to an unsuccessful queues preemption\n");
                kfd_hws_hang(dqm);
                return retval;
@@ -1998,8 +2050,27 @@ static int unmap_queues_cpsch(struct device_queue_ma=
nager *dqm,
         */
        mqd_mgr =3D dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
        if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_=
queue->queue->mqd)) {
+               struct amdgpu_reset_context *reset_context;
+
                while (halt_if_hws_hang)
                        schedule();
+
+               reset_context =3D kzalloc(sizeof(struct amdgpu_reset_contex=
t),
+                                       GFP_KERNEL);
+
+               if (!reset_context) {
+                       pr_err("No memory to allocate reset context!\n");
+               } else {
+                       reset_context->method =3D AMD_RESET_METHOD_NONE;
+                       reset_context->reset_req_dev =3D dqm->dev->adev;
+                       clear_bit(AMDGPU_NEED_FULL_RESET,
+                                 &reset_context->flags);
+                       strscpy(reset_context->reset_cause, "HWS_hang",
+                               sizeof(reset_context->reset_cause));
+                       dqm->dev->adev->kfd.reset_work.reset_context =3D
+                                       (void *)reset_context;
+               }
+
                kfd_hws_hang(dqm);
                return -ETIME;
        }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..569a17be8387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -29,6 +29,7 @@
 #include "amdgpu_vm.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_reset.h"

 struct kfd_smi_client {
        struct list_head list;
@@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_nod=
e *dev,
        add_event_to_kfifo(pid, dev, event, fifo_in, len);  }

-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+                                   struct amdgpu_reset_context *reset_cont=
ext)
 {
        unsigned int event;

@@ -225,7 +227,14 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *d=
ev, bool post_reset)
                event =3D KFD_SMI_EVENT_GPU_PRE_RESET;
                ++(dev->reset_seq_num);
        }
-       kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
+
+       if (reset_context)
+               kfd_smi_event_add(0, dev, event, "%x %s\n",
+                                 dev->reset_seq_num,
+                                 reset_context->reset_cause);
+       else
+               kfd_smi_event_add(0, dev, event, "%x\n",
+                                 dev->reset_seq_num);
 }

 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev, diff --=
git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amd=
kfd/kfd_smi_events.h
index fa95c2dfd587..85010b8307f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -24,11 +24,14 @@
 #ifndef KFD_SMI_EVENTS_H_INCLUDED
 #define KFD_SMI_EVENTS_H_INCLUDED

+struct amdgpu_reset_context;
+
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);  void kfd_smi_=
event_update_vmfault(struct kfd_node *dev, uint16_t pasid);  void kfd_smi_e=
vent_update_thermal_throttling(struct kfd_node *dev,
                                             uint64_t throttle_bitmask);
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)=
;
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+                                   struct amdgpu_reset_context *reset_cont=
ext);
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
                                    unsigned long address, bool write_fault=
,
                                    ktime_t ts);
--
2.34.1


--_002_DS0PR12MB78046739F480CF153C36FB6697FF2DS0PR12MB7804namp_
Content-Type: application/octet-stream; name="reset_desc.patch"
Content-Description: reset_desc.patch
Content-Disposition: attachment; filename="reset_desc.patch"; size=4857;
	creation-date="Mon, 03 Jun 2024 08:02:58 GMT";
	modification-date="Mon, 03 Jun 2024 08:03:49 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwppbmRleCBlMzczOGQ0
MTcyNDUuLjlkMDRiNTk3NWJhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmQuYwpAQCAtMTMzLDYgKzEzMyw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9hbWRrZmRf
cmVzZXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAlyZXNldF9jb250ZXh0Lm1l
dGhvZCA9IEFNRF9SRVNFVF9NRVRIT0RfTk9ORTsKIAlyZXNldF9jb250ZXh0LnJlc2V0X3JlcV9k
ZXYgPSBhZGV2OworCXJlc2V0X2NvbnRleHQuc3JjID0gYWRldi0+ZW5hYmxlX21lcyA/IEFNREdQ
VV9SRVNFVF9TUkNfTUVTIDoKKwkJCQkJICAgICAgIEFNREdQVV9SRVNFVF9TUkNfSFdTOwogCWNs
ZWFyX2JpdChBTURHUFVfTkVFRF9GVUxMX1JFU0VULCAmcmVzZXRfY29udGV4dC5mbGFncyk7CiAK
IAlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwsICZyZXNldF9jb250ZXh0KTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKaW5kZXggMWE5ZmRhMWQy
MGZiLi4zZjQ5MjI3N2Q3ZDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9m
ZW5jZS5jCkBAIC05ODAsNiArOTgwLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RlYnVnZnNfcmVz
ZXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAlyZXNldF9jb250ZXh0Lm1ldGhv
ZCA9IEFNRF9SRVNFVF9NRVRIT0RfTk9ORTsKIAlyZXNldF9jb250ZXh0LnJlc2V0X3JlcV9kZXYg
PSBhZGV2OworCXJlc2V0X2NvbnRleHQuc3JjID0gQU1ER1BVX1JFU0VUX1NSQ19VU0VSOwogCXNl
dF9iaXQoQU1ER1BVX05FRURfRlVMTF9SRVNFVCwgJnJlc2V0X2NvbnRleHQuZmxhZ3MpOwogCXNl
dF9iaXQoQU1ER1BVX1NLSVBfQ09SRURVTVAsICZyZXNldF9jb250ZXh0LmZsYWdzKTsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCmluZGV4IGU0NzQyYjY1MDMyZC4uY2Yw
YzQ0NzBhYjljIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
am9iLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCkBAIC03
Nyw2ICs3Nyw3IEBAIHN0YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRfc3RhdCBhbWRncHVfam9iX3Rp
bWVkb3V0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpzX2pvYikKIAogCQlyZXNldF9jb250ZXh0Lm1l
dGhvZCA9IEFNRF9SRVNFVF9NRVRIT0RfTk9ORTsKIAkJcmVzZXRfY29udGV4dC5yZXNldF9yZXFf
ZGV2ID0gYWRldjsKKwkJcmVzZXRfY29udGV4dC5zcmMgPSBBTURHUFVfUkVTRVRfU1JDX0pPQjsK
IAkJY2xlYXJfYml0KEFNREdQVV9ORUVEX0ZVTExfUkVTRVQsICZyZXNldF9jb250ZXh0LmZsYWdz
KTsKIAogCQlyID0gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihyaW5nLT5hZGV2LCBqb2IsICZy
ZXNldF9jb250ZXh0KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRl
eCA4MDczNzE2YmM1YWMuLjEyYTk4Zjg0YzY3NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwpAQCAtMjQ4Nyw2ICsyNDg3LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jh
c19kb19yZWNvdmVyeShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAkJcmVzZXRfY29udGV4
dC5tZXRob2QgPSBBTURfUkVTRVRfTUVUSE9EX05PTkU7CiAJCXJlc2V0X2NvbnRleHQucmVzZXRf
cmVxX2RldiA9IGFkZXY7CisJCXJlc2V0X2NvbnRleHQuc3JjID0gQU1ER1BVX1JFU0VUX1NSQ19S
QVM7CiAKIAkJLyogUGVyZm9ybSBmdWxsIHJlc2V0IGluIGZhdGFsIGVycm9yIG1vZGUgKi8KIAkJ
aWYgKCFhbWRncHVfcmFzX2lzX3BvaXNvbl9tb2RlX3N1cHBvcnRlZChyYXMtPmFkZXYpKQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYwppbmRleCBiZmRkZTc3MmI3ZWUu
LjlhY2UwMDUyNDM1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jlc2V0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmMKQEAgLTE2MCwzICsxNjAsMzkgQEAgdm9pZCBhbWRncHVfZGV2aWNlX3VubG9ja19yZXNldF9k
b21haW4oc3RydWN0IGFtZGdwdV9yZXNldF9kb21haW4gKnJlc2V0X2RvbWFpbikKIAlhdG9taWNf
c2V0KCZyZXNldF9kb21haW4tPmluX2dwdV9yZXNldCwgMCk7CiAJdXBfd3JpdGUoJnJlc2V0X2Rv
bWFpbi0+c2VtKTsKIH0KKwordm9pZCBhbWRncHVfcmVzZXRfZ2V0X2Rlc2Moc3RydWN0IGFtZGdw
dV9yZXNldF9jb250ZXh0ICpyc3RfY3R4dCwgY2hhciAqYnVmLAorCQkJICAgc2l6ZV90IGxlbikK
K3sKKwlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7CisKKwlpZiAoIWJ1ZiB8fCAhbGVuKQorCQly
ZXR1cm47CisKKwlzd2l0Y2ggKHJzdF9jdHh0LT5zcmMpIHsKKwljYXNlIEFNREdQVV9SRVNFVF9T
UkNfSk9COgorCQlpZiAocnN0X2N0eHQtPmpvYikgeworCQkJcmluZyA9IGFtZGdwdV9qb2Jfcmlu
Zyhyc3RfY3R4dC0+am9iKTsKKwkJCXNucHJpbnRmKGJ1ZiwgbGVuLCAiUmVzZXQgZHVlIHRvIGpv
YiBoYW5nIG9uIHJpbmc6JXMiLAorCQkJCSByaW5nLT5uYW1lKTsKKwkJfSBlbHNlIHsKKwkJCXNu
cHJpbnRmKGJ1ZiwgbGVuLCAiUmVzZXQgZHVlIHRvIGpvYiBoYW5nIik7CisJCX0KKwkJYnJlYWs7
CisJY2FzZSBBTURHUFVfUkVTRVRfU1JDX1JBUzoKKwkJc3RybmNweShidWYsICJSZXNldCBkdWUg
dG8gcmFzIGVycm9yIiwgbGVuKTsKKwkJYnJlYWs7CisJY2FzZSBBTURHUFVfUkVTRVRfU1JDX01F
UzoKKwkJc3RybmNweShidWYsICJSZXNldCBkdWUgdG8gTUVTIGhhbmciLCBsZW4pOworCQlicmVh
azsKKwljYXNlIEFNREdQVV9SRVNFVF9TUkNfSFdTOgorCQlzdHJuY3B5KGJ1ZiwgIlJlc2V0IGR1
ZSB0byBIV1MgaGFuZyIsIGxlbik7CisJCWJyZWFrOworCWNhc2UgQU1ER1BVX1JFU0VUX1NSQ19V
U0VSOgorCQlzdHJuY3B5KGJ1ZiwgIlJlc2V0IGR1ZSB0byBIV1MgaGFuZyIsIGxlbik7CisJCWJy
ZWFrOworCWRlZmF1bHQ6CisJCXN0cm5jcHkoYnVmLCAiUmVzZXQgc291cmNlIHVua25vd24iLCBs
ZW4pOworCQlicmVhazsKKwl9Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmVzZXQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
ZXNldC5oCmluZGV4IDVhOWNjMDQzYjg1OC4uZjY2NzAzNDA4YmQ2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaApAQCAtMzYsNiArMzYsMTQgQEAgZW51bSBBTURH
UFVfUkVTRVRfRkxBR1MgewogCUFNREdQVV9IT1NUX0ZMUiA9IDMsCiB9OwogCitlbnVtIEFNREdQ
VV9SRVNFVF9TUkNTIHsKKwlBTURHUFVfUkVTRVRfU1JDX0pPQiwKKwlBTURHUFVfUkVTRVRfU1JD
X1JBUywKKwlBTURHUFVfUkVTRVRfU1JDX01FUywKKwlBTURHUFVfUkVTRVRfU1JDX0hXUywKKwlB
TURHUFVfUkVTRVRfU1JDX1VTRVIsCit9OworCiBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRleHQg
ewogCWVudW0gYW1kX3Jlc2V0X21ldGhvZCBtZXRob2Q7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KnJlc2V0X3JlcV9kZXY7CkBAIC00Myw2ICs1MSw3IEBAIHN0cnVjdCBhbWRncHVfcmVzZXRfY29u
dGV4dCB7CiAJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmU7CiAJc3RydWN0IGxpc3RfaGVh
ZCAqcmVzZXRfZGV2aWNlX2xpc3Q7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKKwllbnVtIEFNREdQ
VV9SRVNFVF9TUkNTIHNyYzsKIH07CiAKIHN0cnVjdCBhbWRncHVfcmVzZXRfaGFuZGxlciB7CkBA
IC0xMzAsNiArMTM5LDkgQEAgdm9pZCBhbWRncHVfZGV2aWNlX2xvY2tfcmVzZXRfZG9tYWluKHN0
cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluICpyZXNldF9kb21haW4pOwogCiB2b2lkIGFtZGdwdV9k
ZXZpY2VfdW5sb2NrX3Jlc2V0X2RvbWFpbihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqcmVz
ZXRfZG9tYWluKTsKIAordm9pZCBhbWRncHVfcmVzZXRfZ2V0X2Rlc2Moc3RydWN0IGFtZGdwdV9y
ZXNldF9jb250ZXh0ICpyc3RfY3R4dCwgY2hhciAqYnVmLAorCQkJICAgc2l6ZV90IGxlbik7CisK
ICNkZWZpbmUgZm9yX2VhY2hfaGFuZGxlcihpLCBoYW5kbGVyLCByZXNldF9jdGwpICAgICAgICAg
ICAgICAgICAgXAogCWZvciAoaSA9IDA7IChpIDwgQU1ER1BVX1JFU0VUX01BWF9IQU5ETEVSUykg
JiYgICAgICAgICAgIFwKIAkJICAgIChoYW5kbGVyID0gKCpyZXNldF9jdGwtPnJlc2V0X2hhbmRs
ZXJzKVtpXSk7IFwK

--_002_DS0PR12MB78046739F480CF153C36FB6697FF2DS0PR12MB7804namp_--
