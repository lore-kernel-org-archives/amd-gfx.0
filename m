Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD23C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74F410E02B;
	Wed, 21 Dec 2022 06:46:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A65710E02B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 06:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPpM/pY9qquN2rUh7ojS2FhzOvLHZOeFi6HW2/FE8KT5yXlinVMeQhkPje0esZpFPcuTk/gDQf0iPjgPqopTWami1oUB5LV4bO8mjfL3l99g9fAsnet3V5HlWNBd6p8VvPlVaCSYcfcxErmKsUZE2x4RKfDDGugf7Qa8XTKQgBK6jJDX6zIEmQw95YuisW0J1hnCGKTTFcENSoVUReeuB7oNENG+BvHVfHA59Puy9Gpb/m5iJm5ZKuweBdlfqxfxPuvkOEGAOmmc6QPj+r5aTynjfDmMQWUBh/HBF3PC3sEp1H8SJh+UNnSdZmio2BOqcN/UYbgY+8Y/SrvS6N8UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAUuDU25pPgW8L0Y9nXrcZog8Mmi1YkT28lnB+b4U9o=;
 b=XWG4R3x4rDKIZKDyrwnL80q0y5EHu3lNuqeeLhm8ndwLYBCB9IAXI9aPY+7xNC5+AW/+9kfCH8y+3gHs0UlRQOoT23EMXmE016TTPVIszxPP/J1EtHDqV7fL+HZJl5m8ev+CylPCEwztVheLh1ui172dqJdYRi7y3StFTA3x3tPO/zqxVrkKSuVExzcQMoTDWyTqraAdyy4GAv52duZKs4BJwcgykBqQfAtbmsZG4Xj876sGGVQ/mhW7Bx8JZE/ecwBDxjE6zuwCBWh26PSvS5LwP47Z7fMfinv09FiNhOQfH3roa3UFkA7w3ZcGyjhM2st8Veg2P1YvVAhdvotEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAUuDU25pPgW8L0Y9nXrcZog8Mmi1YkT28lnB+b4U9o=;
 b=WVvSZtnYsW4RfkBIL7abpYc57A9IAWIgyrQFGLxIJC3ZUCif418daG/wf+mJP3Us1UKKo4XWHy5LYOauSqxFrPfZRShDRRu6lU6ynrzOUnfc/YmN4LgpALZ3M/OjjhVtbvS3n9dF854h0v4094aLGtGhWEVCQ2TZHSqNL6O9SxY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 06:46:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c0:17ff:6e58:b1cd]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c0:17ff:6e58:b1cd%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 06:46:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: adjust the sequence to check soft reset
Thread-Topic: [PATCH] drm/amdgpu: adjust the sequence to check soft reset
Thread-Index: AQHZFQZ28B6wwFg2wEqeMJ+HxUe2b6534vyggAACqoA=
Date: Wed, 21 Dec 2022 06:46:04 +0000
Message-ID: <BN9PR12MB52575F3E46D5DEE8B5F4ED8DFCEB9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221221063505.3597628-1-likun.gao@amd.com>
 <DM4PR12MB5181D466045603CAD77A631EEFEB9@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181D466045603CAD77A631EEFEB9@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-21T06:36:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3d61b2a4-d059-4cd1-85c0-ab796096655c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6365:EE_
x-ms-office365-filtering-correlation-id: 434b6e11-7296-439d-7dc9-08dae31f07cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKD7hLvBhu5zsceW7b5J9Mxcff1nAICbO9coPFC3aDZBO9Zuho0heJCa/X5ZcGMJ9IrfcdGbUacnwXELXFwYUidX1X7nwQ7I7NSunDveRgWxNYMgyHubX/8CvPi8IzhE7OCeUkQ8rBK3TuUUw1gvWPcnryp7nUo15GwhEMhn2UqBk280kPQQFZPy7QNPaq9QgF3FVadJEndVh8sqXFPNv3rzTdzwABbsOOcHwoLigTASYziRK5HLjYNp1n/RRvJadELwWlL8Hv0KSN7u0C7NUQfhvmZdZNdxcnclikPkbbMRmMekLipRC3UjImf+xqmBv5uYf3TfRyBqlFZ4bxEtibSLzosC1LsCtbdYD7xrn13/kEWXtH+KICTkRAQ0Wdy/F9r6J8AmL4pFKqblmhG/8jVIRwT2uIoLiTVvDm9R1gXrvFx8o0kTyDWDGRxmtnAkwwWP+nmE1kwKGI7cL6hVIsCuZDsxfjrvui2y8Yy+IAtVSPMVzeiW0fCe/+zUxJ4IxIRKaQ019At89wgX0jfgqWtwJd4Lc6NVKcgo1IdJQNAI8bPeGgRRMFHFvjv6miLYVkRibihPuIq+CrqVf1oLXyYesjCe5eqjIRUbv7EAH01P2m7+u05CC0e43wkfbizNwzHAePpof0+ei3MEuH5CV4J7D13L6ge2CNiDQzvE86oJigZv6bBIhyrTnA75YKE+EQzhCzBWweALCv+ABw9TKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(5660300002)(478600001)(71200400001)(316002)(83380400001)(186003)(66946007)(8676002)(66556008)(76116006)(66476007)(66446008)(8936002)(53546011)(6506007)(7696005)(64756008)(41300700001)(52536014)(110136005)(26005)(9686003)(33656002)(2906002)(86362001)(38100700002)(38070700005)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TCFjP8j+SeOwyiGToEJ6zY8x3yIH4I0NQzkunHzE7Gxe483UrLX063zQVyk?=
 =?us-ascii?Q?nu3JIPLu38VCj4PxfoLdajlbL9yWnThYl6McWQ1lynxfTUVJXiqYGyMY1sm3?=
 =?us-ascii?Q?sombkj+NVBIwpyf7csKNZqtB4v/3u41HePwX1rf63b43E5IIFnOGGTVufjm3?=
 =?us-ascii?Q?Ky1nUtUlu+pEM/rncSfmZ3NKpdlsA8vJ32CHI3LMJXncrkx6NR+gPZBXuQ5K?=
 =?us-ascii?Q?Ki3nIGZ1S+O/pNe8EfwvHD7HfmVX+x2w4Fn9tzzaTFgUTB9JC6WlDicWTeBp?=
 =?us-ascii?Q?XuL6/E7ivqqIeJFeRvLTjNWx42EKA+5MtI5Hx32in0kV+2mOLxHMM0JQgV6a?=
 =?us-ascii?Q?0dMW3qfkqXHkhes0OusxEXfwfzslrPTtha19MLqz3bcgNybm9g/2bx2EhYL4?=
 =?us-ascii?Q?MzTQvVzKbNHvMghK27e00zongUWiet0mFcJRYrGsswPYvoKhx+F8Nk/trnac?=
 =?us-ascii?Q?6SmB/gJLg2sVP4SC+AK4m54kfw898aC8qBF0rH7P/5SdIXhFWHuICbkxU085?=
 =?us-ascii?Q?Bu+v2GTqT4Qk3BKmWpyWrN+SjZVvrVclpWCYFRSzLP1U2r0H5vEwIcVYZwKq?=
 =?us-ascii?Q?GMlX8A4OzHe2xPef1jXB61sHFK1sa7WWLfoF244vQHu6lew3CZOEmTgWyR4f?=
 =?us-ascii?Q?rY+yyvWRqNXYJrAgUgMlOYwAM8Isaj7EcEjWf7txBkLB49JwFBfWQGtBj0cK?=
 =?us-ascii?Q?9WQMl4AsHvUJjtBHzyRUyYytK7Lu2Gw5+1zT6Suz/CPhxXVifcXr3u1QTq5+?=
 =?us-ascii?Q?X3yyoJLRRwyb/Z45t6PIf68a6KsqG5B1NP8OCVN1Bj3mv/BwHvvM1bwtiXqi?=
 =?us-ascii?Q?7YI8V954K4RdQAWGZrAUMjvkWh3Pe2ssL3nbztTgAXmYs9l2sd+v5CdUyj5H?=
 =?us-ascii?Q?aZ5p2QZL4KGY9zlsft0NhovZA+TdIhQwubxV0RMGpqvRcMoZVmpr4aeYrAM9?=
 =?us-ascii?Q?OLBdTIUD+bjGs3oKDhDaRsKaqm8MkMEoSC+LYHZCEFsPBeitRjhcSMBB4Al7?=
 =?us-ascii?Q?RjZpsFKUhCKJe3uDB+4tU8FZ3kdE3icYTJUafyBt4AJdklRoG/7XzaOG8KrF?=
 =?us-ascii?Q?MkWq+iHTHQ459bXD4FkotVxevZHAkLQ+YZGyyYoqWagxhhQuS1pEnPz0UUxd?=
 =?us-ascii?Q?GwRmhN58v+v4N1bEFidZQmGOOAaJ9DGaM1njuLcyKm28739hQn+V8hbRZEwW?=
 =?us-ascii?Q?Be9gEOquEPPPWzddX9FiJhIi6IXPdjG0ajke33VBqzJ43kdFXgj9qBU0ATiQ?=
 =?us-ascii?Q?AB4LwWyTFt01gxPoug0hd7PRgQtNC4eKAv1CukTv81p0I+YlUO+2uU5wt0ni?=
 =?us-ascii?Q?cSGdFOmZBkyve3mJ1gHrxdBAzEGzc+Kgd7ApHfBTgDJFJkHN74gov6QBrs/j?=
 =?us-ascii?Q?ViOO0DnkWQBDv0atWNeqtzKd6U8A69Z0I4MiwM+OgJt6OJL6nXjSfQR37Zq1?=
 =?us-ascii?Q?2JZY42w6T6wGLwrhT5c6WKSZEddcB7DsM2dN2QSFrwHM6wVAkeHF7yBhnAH4?=
 =?us-ascii?Q?Rf1Rso2gU56xwn7EHSfAzInb+4dmW3mWd4Q2mt2V2s8LEuEZb/MDJuPIHcUk?=
 =?us-ascii?Q?nb8AboszfRPy4C2Sa2FT13KV6D1jwkd7kR1lxBjO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b6e11-7296-439d-7dc9-08dae31f07cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 06:46:04.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl6BpsAEJZkE+gvllIkMsfQELW1Vr7cH1M4huy3JdEJP9hlcPWZjhX4h6TnDaADJEBkpTMRoT0ngarwgxsKrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Wednesday, December 21, 2022 14:37
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: adjust the sequence to check soft reset

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

1.Drop soft reset check when do should recover gpu check.
  (As it will skip gpu reset operation if some ip is hang but
   not support soft reset)
2.Check soft reset status before do soft reset when pre asic reset.
  a. If check soft reset return true, it means: some ip is hang and
     it also support soft reset, will try soft reset first.
  b. If check soft reset return false, it means:
       I.  All the ip are not hang, will skip gpu reset.
       II. Some ip is hang but not support soft reset, will skip soft
           reset and will retry with full reset later.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9a1a5c2864a0..c8603bca3ba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4601,11 +4601,6 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_=
device *adev)
 	if (!amdgpu_ras_is_poison_mode_supported(adev))
 		return true;
=20
-	if (!amdgpu_device_ip_check_soft_reset(adev)) {
-		dev_info(adev->dev,"Timeout, but no hardware hang detected.\n");
-		return false;
-	}
-
 	if (amdgpu_sriov_vf(adev))
 		return true;
=20
@@ -4730,7 +4725,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
 		if (!need_full_reset)
 			need_full_reset =3D amdgpu_device_ip_need_full_reset(adev);
=20
-		if (!need_full_reset && amdgpu_gpu_recovery) {
+		if (!need_full_reset && amdgpu_gpu_recovery &&
+		    amdgpu_device_ip_check_soft_reset(adev)) {
 			amdgpu_device_ip_pre_soft_reset(adev);
 			r =3D amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
--=20
2.25.1
