Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA63C25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 21:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD5810E0AA;
	Sun, 19 May 2024 21:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5Cy4zc0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6360310E0AA
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 May 2024 21:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCAA90z40Q7p+4+oD/Wbt90//lKwCXlGy+fu4NpLJ2nJzO3a0ObMVITPYX7uOu0cVy/nhU/PiAv+zYIiTP0gZs9AEyMqZ0B73apmuS2Jv5UEb9CgT+oNdrBJ5efkaLSyqon4LH4ZuYm5pwqszk8DER4/w57frImYWSGAs2FVi7J5Znzi0Hh1FPzGNpm5wqvWJSyQ/RswvEnrwTWCnRlH4QRjX2tXV+5zLoHSCYyxbCr6WT1OUxN6yCgcyPudGYyeOV6AYbYFZeY+Mtq54pNXVKjFvUE+vT8xW2SrsGeUWARlp/aA4ZnDisFZ8r0TxKwfRpokVxhm5noOsoXhWvbzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4oziPkxOJ2p1jDVDfbJo0VDvJZe6Uszv895Y90Yb14=;
 b=SjGBZDQVhTEZAGvpZRGDbSrbh4pIYYVtpAVJ1SBGxe/hThHg5btIZxptdvj0w1/hNC18SGuGftnG1LmDtuAFuvVLK7AfUbVFlynup4FjiVSSvRHkkFu1MgYh4X/OE68na41CGokJ2n5MwjHti/qX2sdfl6G5JEJgwz0qjDrKzeh86qy2VTVdVWPZUftelB2vao4i3HM13aZ+RZRAfYZ6Psqc7BtsZDXQABu1Ej91jkECkn2+jv3z+Gg96IrmvBlpAyp9Yn9ulZo4EckC4PPaXek8Yd4x3onIolPoUZVyiQTb52q5CopU6GOeE1e0eOa0dgoM+VFk9woV6ORJ+X/irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4oziPkxOJ2p1jDVDfbJo0VDvJZe6Uszv895Y90Yb14=;
 b=F5Cy4zc0jGryvaQDEot8NJWC7xdwHBfAMdhBCIUxs1Cjk0cvVVT4nobG68Y3A0O8HV7+ELiQNeALczzrGcmWu+Ubv2k8AxJyiZkP3PI9HorjfEIfBo7gom798kOiYs63nLJ/rK6PWrzYEn4uzFVBt6U4KcQ9/+3e+khb54qWdAA=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 21:54:22 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::1da0:d5f:3177:1fb9]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::1da0:d5f:3177:1fb9%5]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 21:54:22 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Queue KFD reset workitem in VF FED
Thread-Topic: [PATCH 2/2] drm/amdgpu: Queue KFD reset workitem in VF FED
Thread-Index: AQHaqfw+9DJd5GWlakmQF9/2cpIh7rGfGjPw
Date: Sun, 19 May 2024 21:54:22 +0000
Message-ID: <DM4PR12MB532897EFE17D3541E4899B9CF1E82@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240519145221.623701-1-victor.skvortsov@amd.com>
 <20240519145221.623701-2-victor.skvortsov@amd.com>
In-Reply-To: <20240519145221.623701-2-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3a40233f-374d-405d-8c75-b20b343cb7fa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-19T21:54:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|BY5PR12MB4145:EE_
x-ms-office365-filtering-correlation-id: d79ceb13-0c4b-4ed3-c581-08dc784e3e04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?NDq8K6bZ4vC/aRFJnStEuG8pSduF06HX3SY8tB+rh+ls3iQX4bYxlzP/H8wk?=
 =?us-ascii?Q?gIQKh5UOsMUGm7hAYtpJmqg9rJ8OHmaSMquxja+U5Eocq4GDp/h5sU6jvmuL?=
 =?us-ascii?Q?odN8KWBbskKv8VrOq7H7TvTEXzL0CM1qJr4BLiOigC8YA3RojkaQssXeKs4Z?=
 =?us-ascii?Q?E2L0+IXJu8gM3TK006Eh4ED6zwOgfrpsw7jbv/vIEh5+FL9KJCYvhgMlP6vv?=
 =?us-ascii?Q?uKyIdKh88690muWduLWrAUGt1cx/CcyabXqRKEhHpLihsARCNiCRYIGK4hAb?=
 =?us-ascii?Q?7zv4q69s6qYp2DrNloqlTRxkX24f4/3JPtP/ycP+KvtKzI1vqPd4zoJpP/nZ?=
 =?us-ascii?Q?bNxNfyKpJfJ7ZyY9JOLXndJ04ibLTDLvhovdKYVbQpemlwfG+Ber39L8SBH9?=
 =?us-ascii?Q?fbSSKWEvtBAlyIOOUUde1IZ58XPEgKD/lCIawTG94UUn/4Y597kbp2vbi+fh?=
 =?us-ascii?Q?aOCFzhS069lZ/CacKrt8dxJy89UQ5BQ8zz+GgeXSOmATFXxhJXhdoPj719R+?=
 =?us-ascii?Q?Ndagdkf6Z+x1N49fCPHfZCk3mg/4pwNsiOUNNvZJvbSJ2UE7ZySMx15JcOn3?=
 =?us-ascii?Q?bYL3TMU5NWJXQnBqaW8DKmTY53JjjSgEB5mPzC+fJwgCnG7vh9/vpVXOerzk?=
 =?us-ascii?Q?oakA01D5TBc3tNlRT4OmHtLfuFRHp0NMpjobe0VqXORaNc9N7NQMC82V5H0y?=
 =?us-ascii?Q?vSGI6OhHyass2xKvdvIjq19gjhjlxRGeGwRKf3remWKLWqMW8TtsXp8R/QJO?=
 =?us-ascii?Q?1lf9D6yvtK+Uarh8ZhXkahQrRZ0LIIddbOlog5YjmDAdNqzJzM9mcQmhfosy?=
 =?us-ascii?Q?AKgsDI3QPbboiGGWT4gAlnzlYWtHrrNzuROQLrWdPBWkDPRPgFuDsgHChYML?=
 =?us-ascii?Q?B9I5tmdJs56sjnUquFo31Mgv6Kcs7o3qk2QhkEwQt2vW86wJ/LaezmJfoaNP?=
 =?us-ascii?Q?r8CdLth0j+U4v/v1ipPvbB9+jYNobpOq1GR4TZ8q2axllZKUSnIwlzIqP0ve?=
 =?us-ascii?Q?MJXPmZLoZoGVR/fcVU5EYe5K3//sxUKDrb48/uSNG9FJAC9NeW/8142YEDgg?=
 =?us-ascii?Q?0Z2eLo/Z7I3/kus9RgHcecPRioqUzaaPAAR9asSup3HOzGHjL954CoUZCgwA?=
 =?us-ascii?Q?/hV9KNRl8Yk25GYFwGFEQj1PAe3IegTA4YfuLVXKggjR9pgrW68jRzgPMVmO?=
 =?us-ascii?Q?2YyRC3RTDPmbRnkZ0LlflaWi2IHPRuX2ywIRj58MyuigNGbFkh1SsClHeVSS?=
 =?us-ascii?Q?y+dkK9xQ2EAtEmM7QKRdvbfGu5v5T4w6cb3uikcoCvKlMsBFo7f8zACmH7EG?=
 =?us-ascii?Q?0DW88P5OVXcbYrdECwF5ibG4A6yVxsU8NJznzooq7CnqhA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ExPOn5h80H5vVTJ9VQyJ1ubdaaH8edNJ58NlcKATbX4iDFlqzquG+uwHHNcq?=
 =?us-ascii?Q?GPsMUBP7Js5QZbqz1GzzfVOJSPK9+qaOpNljtF3Qce84Vf2/2OjRL2OyNMZl?=
 =?us-ascii?Q?7O7BirYRauS4XMR0W9Bi5zuCCkCAa+7BOlY1SpoXWiGdsyT29yYQyTm8ff2i?=
 =?us-ascii?Q?y5cVfKEbywlb7P+q9x0jqDpAbjWIPbt2vHkNtIy6XnM2enicIS+3v0ZUkVgM?=
 =?us-ascii?Q?hafeY+KVGkUxRSq2F5aBw4Lw1ByCriFJbix91aqcvNSZwNW7vjY2SRkSENe/?=
 =?us-ascii?Q?n0oPvDR1HmQq4Xf/FxM6aRbZEQdygPmUXrTZG5gdhZWo1WtzAc65rQW0v6Ke?=
 =?us-ascii?Q?sM4lNXuQD8qDxhJhKXjoSlGs2qpqtehcSXm5fSxPRLq0XAz4kIVhGyeytyom?=
 =?us-ascii?Q?K0GBAd1J1+nyaB1xlrimGPThVex4aGE+DakP7ih1wY1MWBD+i5Ed6TomWp34?=
 =?us-ascii?Q?DL9+sA/5SjBfU4WhsxFbsd6rIGnBtZA1hgvb+PkapDAwL8Kg+q1KLIeUrR7Q?=
 =?us-ascii?Q?9QmlYqHXMOWvHNyN5r1f2IrYr8KU6um6+pFznsj/Ji2Xyz+geFv7Iw4aqzhj?=
 =?us-ascii?Q?Bk6PxCrNyMGdK7RbKIjawD56eVCxgR3rRKg/w61aWqN1VG1CqKIWW36iMbn9?=
 =?us-ascii?Q?ZCVHsEcB6vYSvbgRQgwc2kK4gox3EgJgq9XiG0LyZCiV88ZIR2BaVlEqnvUp?=
 =?us-ascii?Q?Lq8M6+ySnnqh3be+BJ2RukkejXJ6PXY24WmenA+VNM0EE4ELan6w8AMJP8Nb?=
 =?us-ascii?Q?C6DHjufXMjwXrxhfYNisBWrLw/qHTGXUECSDewUHtgDxQci5ysMX0DztETIC?=
 =?us-ascii?Q?u9MdVnreBUKJKg8Y4cPKYsWBQK2tQJnfbI8v3knAS+ULlhc6Su0B+BKEBZen?=
 =?us-ascii?Q?8J9cUDJLLsQijUH/63bSinXO7Lw6LvVoDHCdBO5dQ67Zk/uVY0+qdyKVMkYH?=
 =?us-ascii?Q?8ykPg8BQW3QXEFtYVdWzHxDA/ESVSuj4jzfcL3HbxOnyxKRWBnKl3hHltXUP?=
 =?us-ascii?Q?lzzZZ+gz+j43VJzKrcevIWGH7gb4yNn5BzzgyCQp8YKdRpLxo0Ps39JeZVfL?=
 =?us-ascii?Q?QplOreCbdlhiN2+1+cA3Pc9o4JZA+6LwO5oZ89Z7Uphz+iRuS8y7YkCOosXK?=
 =?us-ascii?Q?lD4yHBCkQTr7L1U6lq1rvN9zwcWVknTl4U1zkIxr12x1U5z777xNTtE6EPbE?=
 =?us-ascii?Q?2SnMriE1u1d9wsHuELOFmYgWL/NrL89tQtaffjFMi9nlHLljkutjRhTfNJ/2?=
 =?us-ascii?Q?hr1fG/g5yN4KgzuwdbYG/IgK+hwLy8ro5hXaMmCPOf0FL7PzFXGHboUHcO2r?=
 =?us-ascii?Q?4814hWBnN4FoN4UgSicFLfL+Sp91M4kFyK6GdihzUoz4kHCdlxKPCHP5nZ0D?=
 =?us-ascii?Q?NW+RL4rLcadSehYmUuiEW4pz+F4v1/8Zfx6LqZK49lHE+7I984aQmdJabGBu?=
 =?us-ascii?Q?ZVvsZDd8klVGIFZddObWYlGfDUWLKRHU7r9sPzuAQEz4HCA/O+7nC1pMZ6jC?=
 =?us-ascii?Q?pCqCLkHyYrNmsDdeKWcicgCmFV9GjDwcVBaZFDFBkrEL6GvDkY1mYAD9rIpx?=
 =?us-ascii?Q?tNUgSi+Yot5yDnOFdgE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ceb13-0c4b-4ed3-c581-08dc784e3e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 21:54:22.2884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGgzrCMeYGM+ctOXr9OcFLr/5u5YR2alA1iqtCsjuwmMSQSsKEZtHHWikDamBEdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Sunday, May 19, 2024 10:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Queue KFD reset workitem in VF FED

The guest recovery sequence is buggy in Fatal Error when both FLR & KFD res=
et workitems are queued at the same time. In addition, FLR guest recovery s=
equence is out of order when PF/VF communication breaks due to a GPU fatal =
error

As a temporary work around, perform a KFD style reset (Initiate reset reque=
st from the guest) inside the pf2vf thread on FED.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index d98d619fba97..3d5f58e76f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -602,7 +602,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct w=
ork_struct *work)
                    amdgpu_sriov_runtime(adev)) {
                        amdgpu_ras_set_fed(adev, true);
                        if (amdgpu_reset_domain_schedule(adev->reset_domain=
,
-                                                         &adev->virt.flr_w=
ork))
+                                                         &adev->kfd.reset_=
work))
                                return;
                        else
                                dev_err(adev->dev, "Failed to queue work! a=
t %s", __func__);
--
2.34.1

