Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D884C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 16:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E4910E92D;
	Thu,  2 Nov 2023 16:10:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B5910E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 16:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEcH4A5dvYO7weoFk3QpyQjptaQt56oE1Hbeoa6CJRtnXbXxWwrWq81ANX4qGZRf3UI+Db6UKlJmMrSkXoQNrZIVvWUXvZMXbaHI61BCf+c3SxGXcGz9sYEb0Zr7bdT6hLywK2SeoXnvHvyVLM0uLTi6qhCk/bkobmKwnTBvsp5zYdEW3buVJ6vizUI5okA10PFI02gy0jywItaZy33tD+8/5RNCR53P1Lu0dtdLiyzXRZ4gmxrEelZEQQAJOEP0YV6mhQmNHulaR1RnqgX+6He/pw+DdC0cgD0DnS4T5c09piBUkvC9qDirK1MSMEfEjlMOa4/N0y2469jd3eT/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nuN4W/YX9qloZYCf23v4/AKEenT+v73+Q7mUuK3cLQ=;
 b=TYeKm6lfl+9X5AVVWucONwXNM6By3Tj+Y3pC5C8GxxE/HGyhedXglAPM6mH5eMc74MvDZ0t74OpZ1btKc6/cp6stWaCpFV6f6/+cDmNV5BYoTes48skOAaaQ143kLY+NoLkRPobTTpzSIrN2HXj+EQ2NzhIR57heiI+cXD5x40aN4EOsZyZ/JILKFMHUuaNJ63vYN4Qmlmrxc46C2ooAnbMF6qFR0GkDjyObaCHThXZunXkXo4DRd8Ax4BwjyojNBhnphAzJilrQqqACOPJ/hbNsSIBdV4H6QXCNUOINYHLnLR3N/RB0bThw044XafOGR7LRYNVh3ByRhR/WKayDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nuN4W/YX9qloZYCf23v4/AKEenT+v73+Q7mUuK3cLQ=;
 b=B0W2erUMi7exMVJecmO7Mlwmc2erKU9uIunbQO5A6FrzbyuIQi5jRfZjSLAA03lrgo/j+sYY+hB2p79NL/SlRnkcTT/WWRYHf5Qzx67nHNp0QRA+JY1MbXCtANwE/RSPcewEjyqnpEQM+PSwV5c8yaSmRhSNS7YI3x+UDCH/4vk=
Received: from DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 16:09:56 +0000
Received: from DM6PR12MB3929.namprd12.prod.outlook.com
 ([fe80::663d:4859:e247:57bb]) by DM6PR12MB3929.namprd12.prod.outlook.com
 ([fe80::663d:4859:e247:57bb%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 16:09:56 +0000
From: "Kakarya, Surbhi" <Surbhi.Kakarya@amd.com>
To: "Kakarya, Surbhi" <Surbhi.Kakarya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm: Disable XNACK on SRIOV environment
Thread-Topic: [PATCH] drm: Disable XNACK on SRIOV environment
Thread-Index: AQHaC502TfatEjLaSU6YPcmZrGYslbBnNo0w
Date: Thu, 2 Nov 2023 16:09:56 +0000
Message-ID: <DM6PR12MB3929ACBF76BDA302BBFFA47A8EA6A@DM6PR12MB3929.namprd12.prod.outlook.com>
References: <20231031015404.14410-1-surbhi.kakarya@amd.com>
In-Reply-To: <20231031015404.14410-1-surbhi.kakarya@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=306c06ff-db37-4871-ae70-eaab253e5847;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T16:09:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3929:EE_|BN9PR12MB5274:EE_
x-ms-office365-filtering-correlation-id: 94d8398e-fbbd-45de-d030-08dbdbbe27de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ZpvIyVJMFM4xl91HRUQ+JjuDJ4LbPvoxGWQHpDPm1i5VEDqRj+JYYdWojhqQW0YkCzHG+L55uw+KPmdW/IKvacI/44Rgt10uCzNdIvbC6jGohBWlQYKa4Arbeu1HDFxJ9kDuqtkJfqX1LpkKG7FXWK2VH6lMeBthD8tCdbAYOiI2KTFoFxRVb0HhKVxJgA2zXNYs0uEzS3mdrweDf2PRMsjI2n5t7zzZx98b+oObSTnJjjYK5EmsFFCLv2pqUnP++U0o69j927p+Lg5Y+HQdIYXTVoALusIMAM20bbEdNlwaNbeTxUYnU0PibA/7B9CpZSllxCVs6MXIZNUY8xEEtSKqJSSAsza8zPwhcHNJRSwgl6OZUCYhoo/ncwCz4ASclexMXQBTYaYfHD4vmBOnxLGqL4VHv5sEQV3srik9zLmJP+74v8bXHtYrvnHLrwJUsNGl12f5NYidlA9kmwGhB6qhZHeIf4e6ox/3O9hjvhH5HaYXbqnM+glhKXKXRuYyGcHreeXhVu8GU2Jo0Ev6xAXVAZacK3QRPr6q1D11F5xFxkgfWw5d1ZMBgTRI/TssuWpJvXak02r0lTOmMy2dYVwosKWnKI/hPRKtQF+fM3wqU13ROxjeS7/zRlhdkYe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3929.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8676002)(64756008)(6636002)(316002)(110136005)(66556008)(66446008)(66476007)(76116006)(66946007)(52536014)(5660300002)(8936002)(55016003)(2906002)(122000001)(83380400001)(478600001)(71200400001)(86362001)(53546011)(33656002)(6506007)(7696005)(9686003)(26005)(41300700001)(38100700002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nJ6RL4BsuT76r5dwmEny/S3mLU75OFV5pMVb9mBZJhxyd6PwVZ7dy949/a04?=
 =?us-ascii?Q?F2V7aIFVtMJflRnM2z3m6ZWLvR8L5Nh6cU/nFU7hlDImAF0vtH1aBd7BE3bl?=
 =?us-ascii?Q?7fBEBhVEQhKVPk1dn+iqXXYy/XNFodKF7zBqiKDI0OjiMl9h7XMmxPgd6mSz?=
 =?us-ascii?Q?3/heAi97eiTbmgXnf4OXkvgYh0lHCRwWayI1oW53+jXlzJD6nt4F4s/Cm2S7?=
 =?us-ascii?Q?LgqeywJ1TbFZf/bpG9gU60zk0jAGiBMJRfpk9CINy78FUillTXYlN5RzCLYU?=
 =?us-ascii?Q?oq5We7FFOLMp/s/yML97Fb2DIXxi5Nq4tH9wWv33rAQb4wA+PoukRoE6W1+m?=
 =?us-ascii?Q?Twz7CyZIjj+OGSQC+tTbYUUKmueuSoFgjfHbV4dkagxabmqhz5L10t+W+HC2?=
 =?us-ascii?Q?DrQnFz6X8n6iIN13fB6e4caT7KHgOM57gQogOrFGR0b4jfQoIXY8oBUqVgj1?=
 =?us-ascii?Q?jmFbhHkYeHkGqJ2UzoXw00myNNXnILXx7UYKwTKGTC/5yVjA6J9VioxwNrw5?=
 =?us-ascii?Q?xCEw7Nl5hM2g4l056mQbvt7BCFtn8h0e0EH0n5vnchKJ/iFFNi+2Zmy9X4Oi?=
 =?us-ascii?Q?aSqpS1XKxEKeFm09893A7CjUX9lUhkGQU2VywwX9U60fRZa3d20Wu+lDa3T3?=
 =?us-ascii?Q?fbf657mccWBnPSa52nC6OmqIwT9oSDeV4tKQX3JhvEXYJqvfXUmetrL651wh?=
 =?us-ascii?Q?qTQFprBtJL2P1KFlzp8dCTXifdQb3eXfO1rLIPa/NnhPXnZ/CbilDghy2BF0?=
 =?us-ascii?Q?mm2ZtR/YNTPcKlNKUvSwfWcPUZdvF+JQXQCXoEivi0qOiQMk5tNxmpi3Ui+m?=
 =?us-ascii?Q?I0X6tuqaOvfyLfyUnSSl9Pc7XtFoS6ZT58BD/XWr44yoGx9qbAJW/BsjOiBn?=
 =?us-ascii?Q?+BYzDlK/jimKGuTmHpmdL8/aljvEKYWvdI0UzCWLEV5bYOGT1UTJonL8I5uj?=
 =?us-ascii?Q?b5TwNh+zpoevv4ZQI6X+yzk9bCcoUVD/WV9y4KAZldrgDLVWnvkwFK9NxJVO?=
 =?us-ascii?Q?sJAienX6EEagJRy9cGjYTn04DpopEIFqXit4aWHnvI9OsQ9Tf3MaKbie2J4x?=
 =?us-ascii?Q?ov1Rs9jExRNlIWUqdYQhpCmqYnWDoo9A/HQZsaWIlJrUQzMompHNd060um5s?=
 =?us-ascii?Q?P2XWBBH7GHy2GDqGGYx1ZzRAkfFk572K3/lbF6obJcX2b7nmTY8LiCapoj+M?=
 =?us-ascii?Q?GUaUqNPlycxGv2dUbHgQQLRz74NfdloUr/LKJujJ3Tz/+9zVUv1tJQLoKZDx?=
 =?us-ascii?Q?I6PvSvUjlW2BgykRx13BGzXCRyEKS3uGdOSyAOFPc58usxAk78BA+eCVN9ar?=
 =?us-ascii?Q?pmbcJ5fgVLsjfcaLnUjREKjF/gNUiw1tEDFIXW4+MerYhXbtpZdhV8b2yBbc?=
 =?us-ascii?Q?bpL25ly+fXj/jzrdbJOcRq6hBT8TjDXYV3tV+7zPTxluOAK2JWWsdMMlGQRS?=
 =?us-ascii?Q?73kBQlvNU0hQlsHt3jpok2V6KijbrALV2VDf6K7UaFPsQ+fDawLDuIezLJy7?=
 =?us-ascii?Q?5A4WRazIS/ms5kfpa9C42qk5L2AOWenM9qWLvADa+sQJiXlHPp13ZNaL1ju+?=
 =?us-ascii?Q?Hh22//uxl2DOmH4ly+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3929.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d8398e-fbbd-45de-d030-08dbdbbe27de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 16:09:56.1761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfejJh+ONXQjg2MLPTly1aP9EVm+Y9JlFcRnuirGrP5Dy2gLVJGQppZdGQsfKG7LzEouVdEeBACBllchGH9buA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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

[AMD Official Use Only - General]

Ping..

-----Original Message-----
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
Sent: Monday, October 30, 2023 9:54 PM
To: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>
Cc: Kakarya, Surbhi <Surbhi.Kakarya@amd.com>
Subject: [PATCH] drm: Disable XNACK on SRIOV environment

The purpose of this patch is to disable XNACK or set XNACK OFF mode on SRIO=
V platform which doesn't support it.

This will prevent user-space application to fail or result into unexpected =
behaviour whenever the application need to run test-case in XNACK ON mode.

Signed-off-by: Surbhi Kakarya <surbhi.kakarya@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  5 ++++-  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_virt.c |  9 +++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.=
h |  1 +  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++++++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2dce338b0f1e..d582b240f919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -826,7 +826,10 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev=
)
                                gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
                                gc_ver >=3D IP_VERSION(10, 3, 0));

-       gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_default : amd=
gpu_noretry;
+       if (!amdgpu_sriov_xnack_support(adev))
+               gmc->norety =3D 1;
+       else
+               gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_defau=
lt :
+amdgpu_noretry;
 }

 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_typ=
e, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_virt.c
index a0aa624f5a92..41c77d5c5a79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1093,3 +1093,12 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        else
                return RREG32(offset);
 }
+bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev) {
+       bool xnack_mode =3D 1;
+
+       if (amdgpu_sriov_vf(adev) && (adev->ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(9, 4, 2)))
+               xnack_mode =3D 0;
+
+       return xnack_mode;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 858ef21ae515..935ca736300e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -365,4 +365,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,  bool=
 amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
                        uint32_t ucode_id);
 void amdgpu_virt_post_reset(struct amdgpu_device *adev);
+bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index fbf053001af9..69954a2a8503 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1416,8 +1416,14 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)
                 * per-process XNACK mode selection. But let the dev->noret=
ry
                 * setting still influence the default XNACK mode.
                 */
-               if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev))
-                       continue;
+               if (supported && KFD_SUPPORT_XNACK_PER_PROCESS(dev)) {
+                       if (!amdgpu_sriov_xnack_support(dev->kfd->adev)) {
+                               pr_debug("SRIOV platform xnack not supporte=
d\n");
+                               return false;
+                       }
+                       else
+                               continue;
+               }

                /* GFXv10 and later GPUs do not support shader preemption
                 * during page faults. This can lead to poor QoS for queue
--
2.25.1

