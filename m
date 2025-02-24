Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC8DC021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3690B10E3AD;
	Mon, 24 Feb 2025 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jq0zfwTG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319D410E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 03:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIdV7YmZRI0XkKukuburEes5ZKDE2EVGbCX0NdPNe35YsePeq+fwHEl72tDwyNXQ0WoWL2VGTOEjZHylzEPCHR7tszrfZDWyDUhdwMunXWBVKvnBy0fHxzSx5dO92r7MPp8EwMdQcoPPG50VIPdicxGUWYbkFLJlWFKXV/NrIwUZau0IBFvEzhNySh+mTFJagHfjA+YsqLb5Sspg92CM3ULfXkF3QglDFdjcGuv6FkBtbD9iyiw7dQvW/gfWU7X7bpJAXwwU61wkMrm8qHEG5KUEnZk9ZoBaJJlOUiBJMyXr/NjIgoqnLHPreVO5tAaj4Bv7dg1OCAGz2/zUom0H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHQpQOcgz0ed0IZE1SnP62qrDreVAQZOjRMUqGkYiUs=;
 b=EJC9l84s9u/Pv7hcpDlVe29hgZKdnHEHjtvt8SYAja6VHvLRIG1JIZ/wixhKoa/ZBWozGwwC2cpxkPY1k6wOP5GJAUFoUmhpY16aa9QpmhgpvzHIjIYQE2O47N41at1mNLkpKm3PjCQzG3CqHwVfaJ99WvnW/kJhx93MXj/IRqSBiyZDB+95jSWMkBqnSoEir8sUm9udbRS+OXI/7NRdunCKdScz5Ugufmg/uVlCSrOpjMtELmCgn4hK/uQvPglutASqOLiyf3SlneMuvovu3bFSn+uD6XBlfx1ZDScyOsTOviVxLwnlH3ReKpza5MtVEEe1n6zqLy9JLm11Xz3O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHQpQOcgz0ed0IZE1SnP62qrDreVAQZOjRMUqGkYiUs=;
 b=jq0zfwTG7asB6AKhaprzSDti6RpXQOy7NV4rq8a9ZjBG5L2e69w5q3VWT0kbQUjp0sadmxU4GGudZM/Xium2jG9+vl2+vw04eck2MQ1TmTQj3Z0rNeKmyPMSNSaen7Of/5ByCPat6CuCke1RUYdh0GPEcKEoZ6twUM/z4fO81+g=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 03:33:16 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 03:33:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Topic: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Index: AQHbhHbEC0IX1EOjt0SwgkhpAnXPtrNV0JdA
Date: Mon, 24 Feb 2025 03:33:16 +0000
Message-ID: <DM4PR12MB5152FD84A3B0FF437EA5C382E3C02@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250221153901.3508931-1-alexander.deucher@amd.com>
In-Reply-To: <20250221153901.3508931-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2c0ae382-b034-497e-afa8-ee66c4ff4a8a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T03:32:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB6998:EE_
x-ms-office365-filtering-correlation-id: d7af75a0-8e5c-4006-ae75-08dd5483f9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o8yrgFGZMlSO+zlTChlCiinfW3qNxiGjpQqJ2XW04H/e4IoXiZB8PIbxNtEP?=
 =?us-ascii?Q?YnByvSFbDd9moaWuf9tQBnnqsDvEP6r32YfGg6YS9c5jZZ+3bHTlDYAXA2O7?=
 =?us-ascii?Q?mzyoULIeJ0vGcYWSgZQW2WYlNnensj4Tvo8+A55Qu661fJp+scNcLOViTOPj?=
 =?us-ascii?Q?MGmFobFku65dGuFJGw31k88ABVnqbKYdbIWv6O+edIJfI1yMUZgkevmt1LTm?=
 =?us-ascii?Q?VtUj8ajeqiVhwGtOs2JQTYuks1qfDuld34X84FFKoPUo2xB4PuojjdRE+d55?=
 =?us-ascii?Q?AQYmhcDTjp/2HvRgnN/7j9MCh0qj3X0K2huKnHGd/KcF3qj5mqaCqyrlqTTH?=
 =?us-ascii?Q?nlpm0hj+6mnvh0JLXKpRK4ACYAMttsrdIZ5hAd3ns/ScvMIzenLGPNDdVnea?=
 =?us-ascii?Q?fwC2Ylqwk+dcBx03SNFhIUqFXcFpeTkHzsZ1WLbqRJcBOV1zm3MCFC2wwREC?=
 =?us-ascii?Q?Nq7cWEd8zglBLRpAp9ChVVKH6xrgVD7oeVMZu0Q4D0APsizMtBk0S7Jd9a5y?=
 =?us-ascii?Q?T19jP3Peek3RmrvXJchlqxHuhWJX1fTL63liRH1njT4//PtKwLhBDafjGxfQ?=
 =?us-ascii?Q?Vd1InO4zo2P9t56aTnP5b94PAZUWrut+uRh21zCSiyuce97HpZvf23eheAzR?=
 =?us-ascii?Q?8Qr66LwovEmJIuv9r360zbNf9gYpcDAyG6z0fdErd4v8fPbkzeIc8PjuWF0r?=
 =?us-ascii?Q?IU4XqCSE0XR910oO4CdyoJ8og3G5trzXX+khjMWixolqsZ22tJlBBygSRf3d?=
 =?us-ascii?Q?bQ8CHJucw/qNOjYYwjdegpQ07TCB7eOEAQdaeDbd+d6xQm9wIsiJR5emHBnj?=
 =?us-ascii?Q?jbh4HyV8mJbl/bzpLNTRX0TeeE8ndEJE5Bsy3T72w5kLhcy1gjV9qP6ls0XO?=
 =?us-ascii?Q?Ml8C2bC+RZ61lFzoCs8amqy4GY83tsYXwce1SMUm6kFjxmR7JpxQJTIMBlOT?=
 =?us-ascii?Q?fWC+jeDwy++6mxRhLFHNX1O4t36/1fJc8z22c82DQsCk2NuBZc0BDs3B1DA2?=
 =?us-ascii?Q?M8TN9A9hjNC4z56rvbVFVaFHNKBoV4qYvd9GRjzp8YSVzF+8Vi76MKFvP4wb?=
 =?us-ascii?Q?fqS7YyfqI16Ec+KOcgeCwUQ/76m5CbbrscBbKRA2szDIqWJlBoRP4aLZOEIl?=
 =?us-ascii?Q?/DB8Xl7jaop1PgFRV1Hcz3VzLgSf5g90dHmybeXCCNkiXpny4ecQEgaaNpHR?=
 =?us-ascii?Q?/CjRelQoKENM+7vFB51dWQnl256baxXX7cYaxWT6b2kYreHpRmlz3ueFZmxw?=
 =?us-ascii?Q?NhjaZxZua5YUTaBVWiQZGDOcy4Q8H+NYgix+avTomGaYExvvgwtZv1Y7IDOL?=
 =?us-ascii?Q?CUArqxUOHLsOQAK4wMqQ/ALHRlGFMWO1I9apse9bfu7LeknYr5LwDwKalxkf?=
 =?us-ascii?Q?NE+Nx/mvX+JgC08pwjZfTGw1/iRj8/gLEBJxxFa/o2vgUX0myi/CDADBn/Oj?=
 =?us-ascii?Q?2yweXxoC4TM9iGrU2kjpucBLvOrFA3+S?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yop9wR9QTbnExSdWbalzP2UxtvJXKa8k6wK6Hz7hoLaRDMyDaIPRRJvCHNVt?=
 =?us-ascii?Q?QxGLgxoNhE7DvUMmj1SaS+aoEFk2Nx6dtIdRr2K25bNUqkB9UE9+cRLwZjRf?=
 =?us-ascii?Q?htkizRWJpFzY37UoOjNxkihJTRIABp6jfg+J6N5mAUPe3ZvBCJ3tq/HxTQiw?=
 =?us-ascii?Q?pJHBxIvYoZXWrk6QJbi0I8tHQcvQWGyxBl+gR1RI/OpDotbaegc8W6gS1ZlF?=
 =?us-ascii?Q?nuW0m2e5kHer+7aSXmZ+O1ztkz8ce6zA5wOyNwNwq21EyFyceXJLeUPxEYPa?=
 =?us-ascii?Q?mQcdgQgQz7cZCvxumXKr6IK5t9/zPlxhgMCrUDWhyD7/ZikzBsmbYHpePkQM?=
 =?us-ascii?Q?x1YQsUApBXnsY9W9Xm79Y8qL95xnshJckgD2BNij7XOT6dc4Bk6oYt/f4Vbp?=
 =?us-ascii?Q?rWnpvEUS/GcdXtMl+PHHl8/oS6YPfI4NjXdmMBjIEAl/3Xs2k4jyQVvT26m8?=
 =?us-ascii?Q?xhuLNtm0XDafKMAi9edmGerNS2oSn9LpTHZDSAIJ9Wu2jWQzKbzgL4vsuAC+?=
 =?us-ascii?Q?1tImSTMSw2ErFaLPCFbfDWhNyi8nHWNoL8k5eJygZstpXEL9LBkhM0tyNGVu?=
 =?us-ascii?Q?fvf1bsrAx++y58QpxUYJ7LTjog0/JuSVkbBIUebeXG0AZ+T8oYoxVJYwU1Gi?=
 =?us-ascii?Q?KZR9yuQkjoiqqwVh7sIH/D6qM7ccaKUxfVz8z0e7RXFArK0WXXDrR03XCL4r?=
 =?us-ascii?Q?CNZZObIpHv9JxrF15IYlCl38YsMWBTfntwOYPmpwtWnaeaPYZuKQgftKCbZq?=
 =?us-ascii?Q?MWoBZGzth9WPYBaAvP5C6nkw0H9eKvXWGcILmPQ2CfBPh/RiBvBsis11iVxz?=
 =?us-ascii?Q?zTb2vqKD4rXB1wwVo33C1UfX8YU5zmGeoCQcxMSHdqz764URu5c/DztbUfK1?=
 =?us-ascii?Q?R5hVy7wEktMTqh5T1hsKfM9k915H1PCEkjuKYSh1peAtCcwSfzxqeVsRr5aN?=
 =?us-ascii?Q?Wj3y7RKy3UtYMSoeL3ECjmuYvcn+wsY2cikovltBTAND/7mgO3XtnXRvtG+9?=
 =?us-ascii?Q?GMWH/vHpQzk56MKE5focoTNtGifuj9yWtBQX1lN1vnuR7FVXLllgnchv+0b5?=
 =?us-ascii?Q?8MhduBIR9E0w9Iso3DKVwCXUHj0raW5aD7MqWqnWIeMS32RKpIlEdYOcBbcS?=
 =?us-ascii?Q?1rjsWAxkCetQN0MOmOIkTqA5QWhR+GL2++pYvjBSbs730PdJNggYBo295zUs?=
 =?us-ascii?Q?XtAQOZqlUkopivar9StTTmhE2n4eKOFc5GrnPZFMQ11vBP/FP1EWmDrKn48H?=
 =?us-ascii?Q?ZHaeBh5huXIHEHheMqJGsRk9X9KK3lM4HbuZCOXuKbRiCOGaR0qhBu2Lvc63?=
 =?us-ascii?Q?td8f+EBJTRC46RfHlEhjwwKPQQuMfFZ4xM8Yi4STKq+g932R6y+NW2kcS6bP?=
 =?us-ascii?Q?Vwkm6ri1e/5C/LRdj11XOpBJT4ChoFVMRTkxMxo5AZNNuX0dM7CW2qqlQiV7?=
 =?us-ascii?Q?NKnxN24dws0keO8XhIPKaer5THQM5FDEn0Ik796e6PTyYCBT8HncH88nXdfj?=
 =?us-ascii?Q?gC2XHJGxxc7vYVkV+FMnOm4Drt8PSlclr72FeXSkq/Sm5FIzR57y1rCtvTGm?=
 =?us-ascii?Q?O6gxxMds3Uh0I/dwooo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7af75a0-8e5c-4006-ae75-08dd5483f9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 03:33:16.5148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPQ0rJzdL5UtwqP5aNzJhsA+COXxOJ69ElzuxKGCMt+mafysxxgqO87bxwI7fb+A7gkwlyxgDnUCrzJ4IAtz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
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

The is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 21, 2025 11:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)

Incrementing the gpu_reset counter needs to be in the is_guilty block.  Alo=
s move the fence error before the reset to keep the original ordering.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if th=
e ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index efba509e2b5d1..c37bc683253a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,14 +151,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
                else
                        is_guilty =3D true;

+               if (is_guilty)
+                       dma_fence_set_error(&s_job->s_fence->finished, -ETI=
ME);
+
                r =3D amdgpu_ring_reset(ring, job->vmid);
                if (!r) {
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_stop(&ring->sched, s_job);
-                       atomic_inc(&ring->adev->gpu_reset_counter);
                        if (is_guilty) {
+                               atomic_inc(&ring->adev->gpu_reset_counter);
                                amdgpu_fence_driver_force_completion(ring);
-                               dma_fence_set_error(&s_job->s_fence->finish=
ed, -ETIME);
                        }
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_start(&ring->sched, 0);
--
2.48.1

