Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779DAD591D4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2064C10E5D9;
	Tue, 19 Nov 2024 06:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSIx4yAi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9299E10E5D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBNV6SC06Jlb9IN9TAAN50q52QcxD8RzE64q9rRv+IickP6hXucwJc8Ej8s1sYI8/9QPZ4WTSYVcSV3GC70lOPJapX9eltGXJwrVrxe4YAa2E8JsadymM37yZG/NEMRAb9jeI6X6GiFivFNn1ARA4170YXfsEgwM0xjcEWf09MMArpq8cTBftBzN1i1x9XpEacXJaBc1VKQ6rfLtBm9eUCbn+HQ/Rzl9deknCQw5lrYwaQQsAR4auaxqWuzkMAbsrbzz/j821A6vxHvA9/n3RwGHOSk+ms7ENTLGp+8HA2/ZvGqfOF4Ti6MUr76rQ+bI07rclrAFK4+3s1e9RCfFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LQJVxTY5YA92stR6yqg5UutqLIsAeFG9+tX6sN7CXU=;
 b=kHdMqoVF6jRfO++2NdtNHjRBlObeYekSgxAW3imswWUI/hZ4HwJRSwHDeWvbDDztl+vAKiycApRZidQAGYGBhwAlnYcYhmq2vxemq1/cp3aNk+12Q1InQ8K0qHMn5oOFNGpHg1M7Wgdv6cEdnkP8kJlXcfJB75HLV4FHHQrz0z+X4jLI5OMfoY1dmorh6FDTAv0yyqtrUFcn9u9FYQppWDUNIqOaXS1eCFHf8veYdI2rMe9oEpBVZaFLJjxrib+lMd2lTy6h/thmn5W2yBsMGUpqQz5Jh1OUIsMGn3cEBfhyI8bSyuPSrbUGLZ2dHuf4+0RkTHO7p91pF2hGskIWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LQJVxTY5YA92stR6yqg5UutqLIsAeFG9+tX6sN7CXU=;
 b=LSIx4yAiSMZYudb2yNdiRzSOM22lvldm1EjJXo4KDA0ye0sDG7ckWe3OXGCP94kwz52RHMDkpjvYkqfKOeT1l2iDbR5AxQhPtiZtxNhROHpYQq6GWUHS0sLMD4knDG4F8pcB3wQpHBwhj2Q+j9UfimAuJNIclSPhLDp+m3sb+vY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 06:49:39 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:49:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add init level for post reset reinit
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add init level for post reset reinit
Thread-Index: AQHbNzTqd0zg/4p77EyFbG1i8qp/L7K+L7bg
Date: Tue, 19 Nov 2024 06:49:39 +0000
Message-ID: <PH7PR12MB87967F8ECCF7EFEC971CB7D0B0202@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241115080332.3373091-1-lijo.lazar@amd.com>
In-Reply-To: <20241115080332.3373091-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=96ecaa12-e1ea-4179-856e-c286d61e1a89;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T06:48:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: 3913af21-7a08-4765-276a-08dd086656ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P/tEfLNLxGdDAW3FlIftSnVylMZae5XKIxNEkGiVLI8qnm++u/OioNJS1QGC?=
 =?us-ascii?Q?PMS/rTSALy3H9g8u7f+/nTOEeYXckupf1K5wKakzl1Vgf7S7OFsamogqsIj9?=
 =?us-ascii?Q?C5ogH5TgsV30mj+hPgCCTkBPim37rdEE8BcoYnsb77BH2bCPRPpQUli/Ni1V?=
 =?us-ascii?Q?AXsYv1qepET2zsxWGLAqna4kacZ6uhz6G7fUWJIozzriEwOVME4jaF1E8az4?=
 =?us-ascii?Q?thq/aZoNzAFrt5RDzdPgoja7VK1L3ufTzYrgI+8GxO9ivQCkrnrm207nUsIT?=
 =?us-ascii?Q?+gom/zazY4sdwmojPeN0t4WCw6e2VttwzQ/15GjD8YaEJkG5di9sz733SrdB?=
 =?us-ascii?Q?jCZgwrm4ek4fGPbZtc0B1X+y5WAqCQ5XZ2qxbBnFAmeWLQskffL/WsB7qruB?=
 =?us-ascii?Q?Uojaa3s9354M9iITN7PlfhBUlw9TJWLOpjvTXPywwoPUVcr5LcIYaszZEtmG?=
 =?us-ascii?Q?kINln5HFTaPeyO2ZFh9xQXgLSLLBTEhhJMidXJ6E3NKk1cLCjBVYuS/FW/D1?=
 =?us-ascii?Q?JjqNXjQFr/Fzhwo8GsSApxY0BDlIaLqXmmeEWf2MsjfmH5PKmjOcrPdLTWyD?=
 =?us-ascii?Q?fSCsbmF5gaim0gsFu1hBPtoTHzLUEFJuxutspsjgeI0BLkfdcPaZtWGC8zQh?=
 =?us-ascii?Q?4iJbx08s/sNPVu9sK1kIFi/OAZR48a6g+rFdgQVav/HipkdbzelIzb8s9iRl?=
 =?us-ascii?Q?Vqpp6HJPvxnUFvKfQUJmA7T5jIWlT4dezlUh9sm5ffUsVsArhP0tZNSwe0Bm?=
 =?us-ascii?Q?6y8s2rSK0PGKaRQ5ppYsVcvSakrDK8z5BQgcJJNZo9mXOu1R72XLJ4wHjUMK?=
 =?us-ascii?Q?q/jxhoKFR6OD1BBWTk+NbNV4Ba4KIev5N763kut4COmK9X/vsbzaWjZJFox2?=
 =?us-ascii?Q?w+Z8K9mefC4rD7MWqu/G2NaWyRg9mr/gCdKBzJsS1uC7cg+urwvbXS0VsXiW?=
 =?us-ascii?Q?jwCj3SQY52W7ZE2z07R/BKGjhLeLsRDxuxMz1j+lN3wh0hnWrE7i5YbJGWYe?=
 =?us-ascii?Q?VfDe2JsucNEZaycGzSyPMizgH1BFzMgDtkOuZxLzDAmacCCn98QYTKiNPEpV?=
 =?us-ascii?Q?JinqrBVUorN9FwD9HU+3IyxPPdqsvF8FmksvasZaYK5AbSDb4n0HBKF0I/ae?=
 =?us-ascii?Q?sowHCABCWRJbjdlfg7k2t+P7AcMP1cQemDG14TkJkGQNWwtKyDc8gvCq5Xoa?=
 =?us-ascii?Q?PdOSTy5PyIn7j4pOUf0e6gklo5oEqyuzUrdAENz4vQfaYtfhyPq903JvQF9d?=
 =?us-ascii?Q?EKg7n01Fn4h8vVwaLpdtzdmFb3FiZRVMjJ4vFbZ0bQjgK3bXixl+nIYZUOvr?=
 =?us-ascii?Q?ORnIAy8bbbesxqCWnpkEKR3Iyv0ZAG3W/tL8yVQqQpx9MRZzFBOHN2raz28A?=
 =?us-ascii?Q?90bWKxM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BGmnQJBjxuTwhQeXSO4jczH4Tpd6oXXItaV/pK7QQWztiYKv/04cWoqcPQAa?=
 =?us-ascii?Q?CKiF9cwefbS8PVHbOPIhlDYYn1xTSyNuUtU65jwRGfh80xP/uh8rmfZmHrqW?=
 =?us-ascii?Q?PNcUxLiZPhSmQ2doeXnr5TmjGTUfjvc8nzyPoo4w3Qd2Katgp7jJPoB6hyz0?=
 =?us-ascii?Q?KPQ2MHz8L56b7p6/g4pAm4NBDq56+9JFIvA90vcp7y8bypslNqVbUvIxzFi2?=
 =?us-ascii?Q?uwSCg0NKaVTnUpaB6f/A2MS5QbxP0vbHOeOzZ/tCubT08p2ixVuv66GNUfkY?=
 =?us-ascii?Q?mQg39m2yXH/Uve+z4cB/GSPk57PQwV7ATHsJ65HUxq4l8jadGyU4+FcJU7Gr?=
 =?us-ascii?Q?zYFIskMzEqmL00VJBV8/p48yqynzK4b+bvMM9Qu4cWoQheAHDC3RYFOVDev9?=
 =?us-ascii?Q?FbQ+Te3GEM0N1AX2Zsea9a41/QP6ZIsGtni14KFZ0A1d/gpu9u/Gk7KyBCHo?=
 =?us-ascii?Q?Kq69yzhTycaRMhE4MWFD2QycmPfEnRf9U3qkePpMngS2zPZpqtmMLJ8f3230?=
 =?us-ascii?Q?3990JorEPzyAo0JGBpxjA/j9tqMEBJr9/gLBtYo/stVF1i3ITWOaaYtautlE?=
 =?us-ascii?Q?oVRGO2pUpJvF1/fPfVkKOedsEKU7FWU3hpXc58iL1c77MTpsuRj/5Ii8B+f0?=
 =?us-ascii?Q?JXUQHaP0zlhOC0lsjD99vU4MqlQJ1mp1Eqa/WaMg3x8uKDmVzGyGEnsk2/Ur?=
 =?us-ascii?Q?LNVRbUoE+Fn6aA7LoqT9XIoyO7KXMaPM77yU/Z9WRcXEdFFdIK2Gm1t4yuCQ?=
 =?us-ascii?Q?xGVt0QNwienNVReWsjFERt9ql43jui5qzGvpIfe4LqzSZHKoESBRFbFNuhOV?=
 =?us-ascii?Q?JFfZ/B8u9XImCQ1c9Vx97SW5hKnqApWDbWFT+JgswHC+uy5XT4yVMJUghU+h?=
 =?us-ascii?Q?NwcuudExFri7iLepoj+8M7V4TW7hzzRPJJ7msyRREDwq4vTMJxouqqIQ775Y?=
 =?us-ascii?Q?YuBL41XmZUrC4yO1Ut3aan0y8m3DqMTEiBD1u2MWgbk0ct0iRAhbt0N8Ix3R?=
 =?us-ascii?Q?dS9KOjcLg+g13YJVhYvOhzDst7bTkh5scVb1wAp7CHsVR9yzXVsXBPFh+hJ0?=
 =?us-ascii?Q?DrjjmlnpHC992GMBCceG8YJf/EfyxghNfbsSTUgVC/WpPFkQel1iTsBrwuFk?=
 =?us-ascii?Q?W8lay4HKigrdygccDNBfzKPy5Xpmn3ugzjB51RthI4eqXwe6YoS3poz5BG1/?=
 =?us-ascii?Q?Km4O6YUe0gvNiTAaNcZMDExflR2OnocY33HIw6zECRJmX9/lRea08WrLEOLw?=
 =?us-ascii?Q?0qg0wOC/tUX/Dm3v1iLr9zxuJU6r5/YjpL7fN/QGvOx/PSHvYrfT3m/ze3LZ?=
 =?us-ascii?Q?IfvrfQ4gK8XA9V8LjD7uL1DDxp8Yk/6XG+zJsxUfLjlr20v2VQ6cBmqfYoqy?=
 =?us-ascii?Q?mXmvZqezV5/bqFpvrMI/ZY9HjMk/VemxqRtnRDZ9jqykzT2CItYDeMzM5D0x?=
 =?us-ascii?Q?0+apPd/h/hF9zTPZBmGWqnUa1QQZgwQR7IHAtpTnKlONTk2ze1lsPfkmQcjL?=
 =?us-ascii?Q?TrJaa+mqmH+bex7KoiUp6a0A4nJe6MuG+2smrbQPeVOC9zWnqdYR3BiE3fpq?=
 =?us-ascii?Q?pQ+idI4eohDZOuXLJS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3913af21-7a08-4765-276a-08dd086656ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 06:49:39.4085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaK63CujcdJnJZd4iBlihlKebaHjRbx8DtWkR9skn3gIWLeTN3M8MpPjolMwyVgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series is: Acked-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, November 15, 2024 4:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Add init level for post reset reinit
>
> When device needs to be reset before initialization, it's not required fo=
r all IPs to be
> initialized before a reset. In such cases, it needs to identify whether t=
he IP/feature is
> initialized for the first time or whether it's reinitialized after a rese=
t.
>
> Add RESET_RECOVERY init level to identify post reset reinitialization pha=
se. This
> only provides a device level identification, IP/features may choose to tr=
ack their state
> independently also.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c      |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 ++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   |  2 ++
>  7 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 6a2fd9e4f470..57c1ca055388 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -330,6 +330,8 @@ aldebaran_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>       }
>
>       list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> +             amdgpu_set_init_level(tmp_adev,
> +                                   AMDGPU_INIT_LEVEL_RESET_RECOVERY);
>               dev_info(tmp_adev->dev,
>                        "GPU reset succeeded, trying to resume\n");
>               /*TBD: Ideally should clear only GFX, SDMA blocks*/ @@ -377=
,6
> +379,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control
> *reset_ctl,
>                                                       tmp_adev);
>
>               if (!r) {
> +                     amdgpu_set_init_level(tmp_adev,
> +                                           AMDGPU_INIT_LEVEL_DEFAULT);
>                       amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
>
>                       r =3D amdgpu_ib_ring_tests(tmp_adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4f72ad4e843f..b8ef89d64704 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -846,6 +846,7 @@ struct amdgpu_mqd {
>  enum amdgpu_init_lvl_id {
>       AMDGPU_INIT_LEVEL_DEFAULT,
>       AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
> +     AMDGPU_INIT_LEVEL_RESET_RECOVERY,
>  };
>
>  struct amdgpu_init_level {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0419b37e75a8..415c469c2d80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -155,6 +155,11 @@ struct amdgpu_init_level amdgpu_init_default =3D {
>       .hwini_ip_block_mask =3D AMDGPU_IP_BLK_MASK_ALL,  };
>
> +struct amdgpu_init_level amdgpu_init_recovery =3D {
> +     .level =3D AMDGPU_INIT_LEVEL_RESET_RECOVERY,
> +     .hwini_ip_block_mask =3D AMDGPU_IP_BLK_MASK_ALL, };
> +
>  /*
>   * Minimal blocks needed to be initialized before a XGMI hive can be res=
et. This
>   * is used for cases like reset on initialization where the entire hive =
needs to @@ -
> 181,6 +186,9 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>       case AMDGPU_INIT_LEVEL_MINIMAL_XGMI:
>               adev->init_lvl =3D &amdgpu_init_minimal_xgmi;
>               break;
> +     case AMDGPU_INIT_LEVEL_RESET_RECOVERY:
> +             adev->init_lvl =3D &amdgpu_init_recovery;
> +             break;
>       case AMDGPU_INIT_LEVEL_DEFAULT:
>               fallthrough;
>       default:
> @@ -5445,7 +5453,7 @@ int amdgpu_device_reinit_after_reset(struct
> amdgpu_reset_context *reset_context)
>       struct list_head *device_list_handle;
>       bool full_reset, vram_lost =3D false;
>       struct amdgpu_device *tmp_adev;
> -     int r;
> +     int r, init_level;
>
>       device_list_handle =3D reset_context->reset_device_list;
>
> @@ -5454,10 +5462,17 @@ int amdgpu_device_reinit_after_reset(struct
> amdgpu_reset_context *reset_context)
>
>       full_reset =3D test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->fla=
gs);
>
> +     /**
> +      * If it's reset on init, it's default init level, otherwise keep l=
evel
> +      * as recovery level.
> +      */
> +     if (reset_context->method =3D=3D AMD_RESET_METHOD_ON_INIT)
> +             init_level =3D AMDGPU_INIT_LEVEL_DEFAULT;
> +     else
> +             init_level =3D AMDGPU_INIT_LEVEL_RESET_RECOVERY;
>       r =3D 0;
>       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> -             /* After reset, it's default init level */
> -             amdgpu_set_init_level(tmp_adev,
> AMDGPU_INIT_LEVEL_DEFAULT);
> +             amdgpu_set_init_level(tmp_adev, init_level);
>               if (full_reset) {
>                       /* post card */
>                       amdgpu_ras_clear_err_state(tmp_adev);
> @@ -5544,6 +5559,9 @@ int amdgpu_device_reinit_after_reset(struct
> amdgpu_reset_context *reset_context)
>
>  out:
>               if (!r) {
> +                     /* IP init is complete now, set level as default */
> +                     amdgpu_set_init_level(tmp_adev,
> +                                           AMDGPU_INIT_LEVEL_DEFAULT);
>                       amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
>                       r =3D amdgpu_ib_ring_tests(tmp_adev);
>                       if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4fc0ee01d56b..59a29fa12db3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -343,3 +343,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_contex=
t
> *rst_ctxt, char *buf,
>               strscpy(buf, "unknown", len);
>       }
>  }
> +
> +bool amdgpu_reset_in_recovery(struct amdgpu_device *adev) {
> +     return (adev->init_lvl->level =3D=3D
> AMDGPU_INIT_LEVEL_RESET_RECOVERY);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index f8628bc898df..4d9b9701139b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -158,4 +158,6 @@ extern struct amdgpu_reset_handler
> xgmi_reset_on_init_handler;  int amdgpu_reset_do_xgmi_reset_on_init(
>       struct amdgpu_reset_context *reset_context);
>
> +bool amdgpu_reset_in_recovery(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 9b01e074af47..2594467bdd87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -220,6 +220,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>       int r;
>       struct amdgpu_device *tmp_adev =3D (struct amdgpu_device *)reset_ct=
l-
> >handle;
>
> +     amdgpu_set_init_level(tmp_adev,
> AMDGPU_INIT_LEVEL_RESET_RECOVERY);
>       dev_info(tmp_adev->dev,
>                       "GPU reset succeeded, trying to resume\n");
>       r =3D sienna_cichlid_mode2_restore_ip(tmp_adev);
> @@ -237,6 +238,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>
>       amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
>
> +     amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
>       r =3D amdgpu_ib_ring_tests(tmp_adev);
>       if (r) {
>               dev_err(tmp_adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index e70ebad3f9fa..70569ea906bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -221,6 +221,7 @@ smu_v13_0_10_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>       int r;
>       struct amdgpu_device *tmp_adev =3D (struct amdgpu_device *)reset_ct=
l-
> >handle;
>
> +     amdgpu_set_init_level(tmp_adev,
> AMDGPU_INIT_LEVEL_RESET_RECOVERY);
>       dev_info(tmp_adev->dev,
>                       "GPU reset succeeded, trying to resume\n");
>       r =3D smu_v13_0_10_mode2_restore_ip(tmp_adev);
> @@ -234,6 +235,7 @@ smu_v13_0_10_mode2_restore_hwcontext(struct
> amdgpu_reset_control *reset_ctl,
>
>       amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
>
> +     amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
>       r =3D amdgpu_ib_ring_tests(tmp_adev);
>       if (r) {
>               dev_err(tmp_adev->dev,
> --
> 2.25.1

