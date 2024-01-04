Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19CCC4707B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 06:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D3F10E3A4;
	Thu,  4 Jan 2024 06:15:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B492F10E3A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 06:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/NMgiDo+vGZ6H/khf3TlwckH2Ywo0ECGOqd8WOD4r00PaOp31hkyjIlDJksgCs5HkMhJ1foZw4ZoKvPkP1Bebb4qlrwwx8nlNrzuSwlplUjYjqgKZkBWTv+kRyoFxphIZnVmcbHxvXo6EvhJM2W1poNLVE9/Ey0hPGjnZ8DRmQQrI6uYbEJpS0E79hv2bVNzqiXIKC6RiyswhN4wTr9n3IsqJkWaZvXTgYv/NyAVa9Em4Z0Vmlh3Ldfu9DWdurTpSooVb1zHadTHYIpVVGLh2gXNpTh8t+2C7ZI7PevQN+RBvZHtGyVoRKhIjBlTL7l5nJ5P7lM26q/6nHOl3OhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1UMD+d3YmWPpGzisadNqL+HHDU7184Avv4TC4ku51Q=;
 b=T137eMyQ1pehP7eovGgtSHHUQ1wmn/w52L91CGAHNGFRKOMXkBxTRzjcv12NqvOQknjKQSaVmd4ptV+GkHHFdIeI5E9Sf/mHvQI5JYDIxgD8S6IPemHrUtWUlXwHthaqrtY6Js5HFpRUX+R7N5z9Y+OCCi3Vh/VKLQ0L1iilKE7LZ8ESy/mDS7CGSqHGqi9go5Yd7yS8nr5aAByE8Vsdr2BOdqT01i8q3NsnpERd95sZ/13BgjMf4N5RaXIIw5UIdyRJClMDUFzK0rrY3uFbNv8wUQASbOPAZBMkEMAOscY+zYqYCg/dM/Bt+OgY62bMdLf7QHnOpv3oeWEnxo57fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UMD+d3YmWPpGzisadNqL+HHDU7184Avv4TC4ku51Q=;
 b=AR+G/yYU2pd/t5OtcJeYFgXOEwFrbfXUxXZuPmEhTkXKh0bSbAUCbDoBK4CSgwy5kNxqcrqNbhLWuZbflwPsf07Ryu1rKkSMUAD4nQWXm6Vb/6BYapvHzZkxn0vw9ZBmqvEXP7zQ8C6TrlvAzPPkW2vIsj2WQxT/ujKs0+JEScc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 06:15:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:15:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and
 deferred error.
Thread-Topic: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and
 deferred error.
Thread-Index: AQHaPs52HBopicJRaEy/dBYYL41+QbDJLTNA
Date: Thu, 4 Jan 2024 06:15:48 +0000
Message-ID: <BN9PR12MB52573F61FAB2A06D4FE207BFFC67A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240104052509.3771116-1-candice.li@amd.com>
In-Reply-To: <20240104052509.3771116-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90394c0c-e974-449a-8cec-0dad8f14f7e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T06:15:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW3PR12MB4491:EE_
x-ms-office365-filtering-correlation-id: 0a9c9cb9-4f93-426d-1e94-08dc0cec9818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iPyDGXc4DrpdKsPAhmNV4YfrRCLqlWH0KecL2I9ItXIVG/Wsb/fKFZNbcKKf6Phade82GS5ketfcgVfLjQfsg5pX8bdcyrnGbfSKpyl5tSI3t6EvwZIQdgrx+j3QQlFPldEgdrzosFo7RIKse6JRUok+3L1ECye4eFJ6SNaeFArfrl9zJIcTneB7wDzbKRZsCLgUK8kGzdmgiVCpaSji2q3JGkGcIhX0bvzhrqbVj2jfnso8Y8+np+QMZVQVwleWNDiX+ucv3ddxKPiuhiJXJ01chgsph8YT87X5NwnFs9QJNtaApP8i/5dOO5xG163FZdGWre4TdAcPJ/0uarN4uw6Ak82V2gluIuqRsSxs3eoHWnFW6E0+LadN5jyPxchNr1IU26eoX0vKr/5zSm5OghDWnn97BwrHtrtg/MQhiTt12QlFKTqwP4ukaZWRd27oXhSi6RhK9RsDT29CAzZK2+uAP8WIcVFSHcQMVmwWPRAjI0/uplt2KLawu+txTDYsKK2HcSRmKApisNtbnJyEOeoTzCCJzTAbNEmIBhnnBf56fB+w9gezTDi+B7iaJSRv9tSzpwhYABiRLO3wgSg6UpGsVqgZZxig02zEN1anjiIaJyAc00zvuKRtSC6Y0UsL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(71200400001)(26005)(6506007)(9686003)(7696005)(53546011)(5660300002)(4326008)(8936002)(52536014)(41300700001)(83380400001)(2906002)(110136005)(478600001)(66476007)(66946007)(66556008)(64756008)(122000001)(76116006)(316002)(66446008)(8676002)(86362001)(38100700002)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uHykzUCkBAskd3JckzfnpWafSyBLTdYGTN2FOGnJ3iNmrSYf7KSFIsFXtj2s?=
 =?us-ascii?Q?BmbXmXBWPmf9d2MZhmVQ1LzfEcMy8BocoAc+QutHG42DfD0ai8SQ+p1HKSv8?=
 =?us-ascii?Q?pDLQVdi1MPk84/g8RSl8uE3tbaZ26/9MSo9rs7sLBiXqFYF2bQRwJEKbh8Cg?=
 =?us-ascii?Q?vPDM+6frRHJd1vAQ+oOJlqAcg7HDlvegt3DlfTye/EqgAeqtlMKwh1bua0RY?=
 =?us-ascii?Q?198X+fLIEEobD9R1yUwfTtOI+P7w4YdC6ia+3zhodOCmK/YbYxpl3a3fR5dv?=
 =?us-ascii?Q?qzKu6/EmtET1QFOFtyix80eh8I1H3mjWEYP9S1gTHMEMdeVAtCu8blQ/txc1?=
 =?us-ascii?Q?KeUDkUAZ3mKD/iCIS0Czbr1Q+09hKExYMMYDRkh3USrTFpJU+vvvir6XuLjJ?=
 =?us-ascii?Q?H9gqrqwweIejq4CQ3cBSxMQakvqHgc664JYD9e6JYpSE2S6SXWpWN16zGhpF?=
 =?us-ascii?Q?6n7gcMHW7DaydYHMjNNwXKdzUan6CZd7vc1/TPM8dxG9XhcvWq2Arkw/Lrp0?=
 =?us-ascii?Q?2yx8e+zFrggeNR+C6frJWFT+PnGVKIkT8td6KPY5GJ2dyxi4LrQmrxe8ikOa?=
 =?us-ascii?Q?aprqO2MSbM/03iKVGzlrW5OEIxmXsT5C4FriKt69oJ8I+RIZxnuuT6AGvP00?=
 =?us-ascii?Q?7Qe4ZgAKF1D7O326xNEJaDBSVP3dnD+MkN6dLcNGSRDxm0kndZn+bZN+XAiv?=
 =?us-ascii?Q?yAd0Enr1Ryl0M7DPgKizIYS9zeIHbqAxnEHYU7K70WjrZMkJPxdjhPzQPq7y?=
 =?us-ascii?Q?9PcN5f4NbB9nATbV6fKE+VXdolfx5vQ6cx25y0aUe0Z4LX1hHc/cw5Pl6qto?=
 =?us-ascii?Q?4aIZgEkgO80sO/wDw9qoBuAgtPt8NwNy+b8A/tq/uptSMCUv/YjpmXFaXbru?=
 =?us-ascii?Q?BS6DouNocqFdH3OXElDV6izY/cf8f/UrhTJCdSUXXunIeiMVVxrfVRSHQpGa?=
 =?us-ascii?Q?VQ+dqg9jMP1XZLMbv0F+MJQ84kgkMA5GokuWa/m+2yb2H5qmUgkNHQdpXxpx?=
 =?us-ascii?Q?ASTY8ACrdn1G6cpRJv4AX7/56H9t0aY0ZB99pUINA5GGwH4NK5pYx9LGFft7?=
 =?us-ascii?Q?tobWJEmtTuHFOGjjOINdvnj2IObJ7HKLghpUREPHIuWPvIWcGoXvHR+ANQat?=
 =?us-ascii?Q?D+M82ynCvQmM6lpLTC/DBaduHCQTwtbybDFp1/YO/tDsKb7oS3algoYzI+26?=
 =?us-ascii?Q?9qc+IdfxEDjmcRBO2u8NrZdG8WFS/Qef+BpRPTjMx6wBwLL1bMQEZvC4SFmh?=
 =?us-ascii?Q?fFRX6SRpi563z2cZ91SePipMz8Z40LqKONNxE04zBScjVrJTsSgWI9oK62Z+?=
 =?us-ascii?Q?HC5NdQJOzpFlz5Q3Qx8LA8iU1CuoR+weWnj5dpJ/Jmp1XgMWkAPxqACLVU9r?=
 =?us-ascii?Q?VtJyxXhK0cMCefuhEVwJ2tRxD472VXVqrxyvvlLIENCfs4X0hpJmZ//+/jiQ?=
 =?us-ascii?Q?44gZpKl4dm3bR/Vvwvxr3aKx+hU5dp0APWg+PUh/ktF4OjAz8+/8AavWidLT?=
 =?us-ascii?Q?SNivTh6tIfIO1N6q6bXP7DfvUze7FoJNU/MUmnpOjDIKcX8vHIE1FQLJdKdd?=
 =?us-ascii?Q?wHyby/0iGdBzNxEOYP71K7Ge3D0eL2XuawsjdVTE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c9cb9-4f93-426d-1e94-08dc0cec9818
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 06:15:48.3258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBZDDc9ZKxxqb/w06XuzeXFRqs0zumeMwNqWcekj7pd1ZngR/VMUek6SSdormMI26CGGdIJP3OAbw3UGve/HyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, January 4, 2024 13:25
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and deferr=
ed error.

Remove "no user action is needed" for correctable and deferred error to avo=
id confusion.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++---------  drivers/gpu/d=
rm/amd/amdgpu/nbio_v7_4.c  |  3 +--  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c=
  |  3 +--
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b21eadd7c975df..caf00df669bf7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1069,8 +1069,7 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
                        mcm_info =3D &err_info->mcm_info;
                        if (err_info->ce_count) {
                                dev_info(adev->dev, "socket: %d, die: %d, "
-                                        "%lld new correctable hardware err=
ors detected in %s block, "
-                                        "no user action is needed\n",
+                                        "%lld new correctable hardware err=
ors detected in %s block\n",
                                         mcm_info->socket_id,
                                         mcm_info->die_id,
                                         err_info->ce_count,
@@ -1082,8 +1081,7 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
                        err_info =3D &err_node->err_info;
                        mcm_info =3D &err_info->mcm_info;
                        dev_info(adev->dev, "socket: %d, die: %d, "
-                                "%lld correctable hardware errors detected=
 in total in %s block, "
-                                "no user action is needed\n",
+                                "%lld correctable hardware errors detected=
 in total in %s
+block\n",
                                 mcm_info->socket_id, mcm_info->die_id, err=
_info->ce_count, blk_name);
                }
                break;
@@ -1139,16 +1137,14 @@ static void amdgpu_ras_error_generate_report(struct=
 amdgpu_device *adev,
                           adev->smuio.funcs->get_die_id) {
                        dev_info(adev->dev, "socket: %d, die: %d "
                                 "%ld correctable hardware errors "
-                                "detected in %s block, no user "
-                                "action is needed.\n",
+                                "detected in %s block\n",
                                 adev->smuio.funcs->get_socket_id(adev),
                                 adev->smuio.funcs->get_die_id(adev),
                                 ras_mgr->err_data.ce_count,
                                 blk_name);
                } else {
                        dev_info(adev->dev, "%ld correctable hardware error=
s "
-                                "detected in %s block, no user "
-                                "action is needed.\n",
+                                "detected in %s block\n",
                                 ras_mgr->err_data.ce_count,
                                 blk_name);
                }
@@ -1978,7 +1974,7 @@ static void amdgpu_ras_interrupt_poison_creation_hand=
ler(struct ras_manager *obj
                                struct amdgpu_iv_entry *entry)
 {
        dev_info(obj->adev->dev,
-               "Poison is created, no user action is needed.\n");
+               "Poison is created\n");
 }

 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj, diff=
 --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgp=
u/nbio_v7_4.c
index 6d24c84924cb5d..19986ff6a48d7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -401,8 +401,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device

                        if (err_data.ce_count)
                                dev_info(adev->dev, "%ld correctable hardwa=
re "
-                                               "errors detected in %s bloc=
k, "
-                                               "no user action is needed.\=
n",
+                                               "errors detected in %s bloc=
k\n",
                                                obj->err_data.ce_count,
                                                get_ras_block_str(adev->nbi=
o.ras_if));

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index 25a3da83e0fb97..e90f3378080345 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -597,8 +597,7 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device

                        if (err_data.ce_count)
                                dev_info(adev->dev, "%ld correctable hardwa=
re "
-                                               "errors detected in %s bloc=
k, "
-                                               "no user action is needed.\=
n",
+                                               "errors detected in %s bloc=
k\n",
                                                obj->err_data.ce_count,
                                                get_ras_block_str(adev->nbi=
o.ras_if));

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 530549314ce46c..a3ee3c4c650feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -64,7 +64,7 @@ static void umc_v6_7_query_error_status_helper(struct amd=
gpu_device *adev,
        uint64_t reg_value;

        if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Defer=
red) =3D=3D 1)
-               dev_info(adev->dev, "Deferred error, no user action is need=
ed.\n");
+               dev_info(adev->dev, "Deferred error\n");

        if (mc_umc_status)
                dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x=
\n", mc_umc_status, umc_reg_offset);
--
2.25.1

