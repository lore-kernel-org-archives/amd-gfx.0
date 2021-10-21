Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02564C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFC160F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFFC160F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B016EB7B;
	Thu, 21 Oct 2021 07:20:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE9F6EB7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVKHTBsvKkY4Og2WyZ1Vg3pxc13/1g13/Ryp24lRfMvbXTGFxWtTFyXlZGW9n+D82p5SLQvPwVx8qtLQke+imeWZ/T7BZj+kssGcfmpyBMPnzpj8lU6YYGHnFVDUN5FBl4uoGZHrSpTaVGpAx8maezKKp1GBDZN9L7kbVsYyFVc1WenWDT77P/tq7x+I8xa+R1A/y2hGm5KwzoXTPSeHxOGIUJOmeLRn44AF3iTY5H8/7dTAHicnTaN+yu/dil6Jd1yOsHYND/F/JqxtJ9IM3k1P2vP6ysJiw2h+Y7gbNCuc8Wo4PV/22eT5mzj0b/HIQxvAS8vYNnQK81EH134sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2qxOlgaNsJ5PMqOrzX6RwF5XTiF0qYMS2XogJEySLo=;
 b=niOjjDhPBNaZOOFDsmWLcTKJwKsFMHp8k6/MENMlBTNdsekVssN77j3F82l1zw367dNHnNhveK03WHw6sXfUqc9+2l/vIRClMxxngFUGEOH48Uc4x2tGhg0i81/xQvQlw9vEq+ipqL/THdRW394TBC4oV8D+M6PdrpwpRaxg46Nsaq5DCNAaf1RMu9SazNGEcZnY9hHY/qua9+PnS6wr/t8Hjmm2Rus4yCujwc8sQVTe2p/8oihWWAWOzDYN8uxw4fzmIxESebhd6/pt4VEhSQYCV6Jsh+5K8xIDhjJtr4DU4S6qHCRmTI9/xyldZcUe6Sh9puYjpVxVhxhDs9dGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2qxOlgaNsJ5PMqOrzX6RwF5XTiF0qYMS2XogJEySLo=;
 b=qzEnehGoE+o3mLsihqQ1v6O2pcVQofTECkKgUgqK0OjK8KYBQcVZx6CqfZB2YYpooDI2UCfi6yiSzF8hjvQpb7bNGlaVbXc1TMaeZwjnEuZo8uPsoyz8D/pWF5xGXWqUez9md8cTzk6Snk795A8aUIAzXp22LIpjUPKr5s00A94=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 07:20:01 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:20:01 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH 3/3] drm/amdgpu: remove unnecessary NULL check in
 amdgpu_device.c
Thread-Topic: [PATCH 3/3] drm/amdgpu: remove unnecessary NULL check in
 amdgpu_device.c
Thread-Index: AQHXxkvPoFACMMrkrEibrmj4dmqMcqvdC3uA
Date: Thu, 21 Oct 2021 07:20:01 +0000
Message-ID: <DM6PR12MB4250696A997F2EFF91682E2BFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <20211021071750.2912140-3-lang.yu@amd.com>
In-Reply-To: <20211021071750.2912140-3-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T07:19:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=223e77ad-1150-450b-9dba-8a4c43524ab8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84806d50-472e-456f-c090-08d994633250
x-ms-traffictypediagnostic: DM5PR12MB1516:
x-microsoft-antispam-prvs: <DM5PR12MB1516D4FA9153318B21EE3D91FBBF9@DM5PR12MB1516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sPI6MF15U1ClpGz2v4P8ztt26MqGoaWtsi0qT2X9osDS8CPkovxT+F6E1zIEnUVv61Fm/rZORu4xj5ssXDqcNCVPAumXVscE5tVqXkzw3lK7UsBXN9kjVfaL31yIIcI8C9aPYgW9Fk38a7P8fTvdVC+nGk6mWha83kCu/RN2I9RrB23fL5ZiHdpa6Sn0h05wo51sW0ThLTXfRqirEZZAjX5BnEmiM9go7aR/5zw5KnYhYxAT1MSDVU/o24jHOhvE6wSTi9nNQAHw7+FCLHHSUIv0qksrrrYnoydCj19iZyGcUtBfc02DtK1d5gt9QZ4evTE93Z0kmgATV2qyBv7FQ+/F8V1HTDsWtskaZrg2+uMEaO6lSuGNK3mbZpJjBYxl7W7Y4Djw+aqyOFXLJ26Xz2p9huMEJpNe5VsyOR1+8ZcJqF3Al7jlfMcSpljmuzlO4qF5pH/MUrKhrggAciVsJHdCIUouRPAbfIFtmMnmkvLz3bMsiqKFPjzZrgPRwZ93Ttka1R8KNFMuy7ckTKaJATzARhyCI4JPTBgzlG8hiygjwkcnnsVMgPppAQvGmia0T+/ecSE/uf8qTTM9nZlggvK47D+V7MHgnS6Zy//n/CJZmFMQ9+abvgsbTmnNgOjhZH0HnsDOYUu4HtkHP5hX0gEkJj0rc65iJQTj8Jq/wXtRg6Fe9lRRPl3CchxD2Hcx7IQRUPHyXBBsAQCZkuSHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(86362001)(38100700002)(83380400001)(8676002)(76116006)(5660300002)(71200400001)(6916009)(8936002)(26005)(7696005)(2906002)(66476007)(66446008)(64756008)(66556008)(66946007)(33656002)(186003)(122000001)(6506007)(38070700005)(52536014)(508600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gXvW+wklsAjTYXcxVs0/G2Z3wSFmWpGfrd1l3kXfp3xH/XRzkOZH6+1qYhEK?=
 =?us-ascii?Q?3+spdECxJb/aNp2H+QxrKWffT5Mj5WObbMDFVE+7r3KAWbOnD9Z+zYbFlG3f?=
 =?us-ascii?Q?JxVQaENfmQ7gOvipZheZdvunS0FyLfdAnRebf/JkblWaWUMNMmQG5a2W4JEW?=
 =?us-ascii?Q?Xfz2oSHBaVQuU+EZeWKQD5NiS/JcKcE2iOJhUIEbdQJffJTxFm5XZ99DgDH9?=
 =?us-ascii?Q?7D/VYGGpFbVTnzWRWOgoPEMJFzlGI/4P5JAegOnP+EhdGDUwFuT5/Mu8gpiU?=
 =?us-ascii?Q?F1HH2hVEM5CZ8xy92gCsw/5sDoaJkxdDKWjQ7/zmqLgxaTkl4SJ98bi7AQCJ?=
 =?us-ascii?Q?ySdnzQTVHG2vzenTLlcFFwfhwlgplxLOtkdXdenqXnU0kBnQB/yCLNlnPsSq?=
 =?us-ascii?Q?6KVeB7kCrDyLic0LLJKMYDRcKTwTpAjE2Os+DR05LZWksR6ERuGPpqz9PZVA?=
 =?us-ascii?Q?aG7D0vpiEofjoJPxSEK62ynjfgJSroyGHBdq/W9/S5NKuYZs9cBZVDPGOX7k?=
 =?us-ascii?Q?hF85d4EYfTwcMtUXJuXd9Sg8bOWImJ0awt06OpD2t4cooPsv4nt2Sf3LslZ9?=
 =?us-ascii?Q?1uNOGWTzBZSO5u10bqt7NAaWAYGxBLTXpESdRZqdRFmVS+xh8BKCLahh7uiY?=
 =?us-ascii?Q?WOODC8l+UzG0BF0DlW3UFmf0VMcgvoAwo0hqOowAAyj2ffGMB9KqxW+GfxeQ?=
 =?us-ascii?Q?2eNKFFQKlHAJCPj+Wq46B9XlN+s0QI51LB7z99HSE4XW8M601xN5pdXqUVa7?=
 =?us-ascii?Q?SErVZjVmljqEkfVdKPH4mtIlMsd8ZNkskyEPedB2JwDomEzS7khf3mLKoVqt?=
 =?us-ascii?Q?tG2NeBeF9hqpaAy0i9mVkHRx8hzDHUTFG1oKrek/JurmgXFStnCxqmUkn4M8?=
 =?us-ascii?Q?80NoGNgF0TOiZUG2CSzPoC0BoHqjSV8M7nhAOWrkeBLLUbisFwcaqJYpaUlu?=
 =?us-ascii?Q?H4hi2LmxM2ippzhcuSc5OiTkevk9V0tqVk6UBWLSybDrJZM7hihzJQ7VgKvx?=
 =?us-ascii?Q?VOyAsUHnT35Z+eOjxKoMbCF984Zz7tyBbYyyEP23m8ofLFYWmrdr3Hs45pVk?=
 =?us-ascii?Q?vPv+UBRzEAq8p2Sv4xgHXRxznj/io2a/w/xbejfWz9gNERd2kEj8fzfofza+?=
 =?us-ascii?Q?sBq7hQc6a6CbmcZMp/5cY6IhN3r1HPgpaBwjLFVRNmorBt5Xhb+jWOSST4si?=
 =?us-ascii?Q?q8vERWc5iTuVCiRdh5TsMfQO2o3ctmTexzKq47SA4asXcq9F+aLrB8oyRn7n?=
 =?us-ascii?Q?Ch1pkWYOJLiQs5edfk6ngJzxUrILeD/1NzVmT6JMupBInhXW8bWnyLXDhH6H?=
 =?us-ascii?Q?pH1gZJQc2VqWT/ETs+oL7wVU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84806d50-472e-456f-c090-08d994633250
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:20:01.5695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: langyu12@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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



>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, October 21, 2021 3:18 PM
>To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>
>Subject: [PATCH 3/3] drm/amdgpu: remove unnecessary NULL check in
>amdgpu_device.c
>
>NULL is safe for these functions.
>
>Signed-off-by: Lang Yu <lang.yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++----------
> 1 file changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index be64861ed19a..dd979db93399 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -1091,12 +1091,9 @@ static void amdgpu_device_doorbell_fini(struct
>amdgpu_device *adev)
>  */
> static void amdgpu_device_wb_fini(struct amdgpu_device *adev)  {
>-	if (adev->wb.wb_obj) {
>-		amdgpu_bo_free_kernel(&adev->wb.wb_obj,
>-				      &adev->wb.gpu_addr,
>-				      (void **)&adev->wb.wb);
>-		adev->wb.wb_obj =3D NULL;
>-	}
>+	amdgpu_bo_free_kernel(&adev->wb.wb_obj,
>+			      &adev->wb.gpu_addr,
>+			      (void **)&adev->wb.wb);
> }
>
> /**
>@@ -3794,8 +3791,8 @@ static void amdgpu_device_unmap_mmio(struct
>amdgpu_device *adev)
>
> 	iounmap(adev->rmmio);
> 	adev->rmmio =3D NULL;
>-	if (adev->mman.aper_base_kaddr)
>-		iounmap(adev->mman.aper_base_kaddr);
>+
>+	iounmap(adev->mman.aper_base_kaddr);
> 	adev->mman.aper_base_kaddr =3D NULL;
>
> 	/* Memory manager related */
>@@ -3886,8 +3883,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device
>*adev)
>
> 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
> 		amdgpu_pmu_fini(adev);
>-	if (adev->mman.discovery_bin)
>-		amdgpu_discovery_fini(adev);
>+
>+	amdgpu_discovery_fini(adev);
>
> 	amdgpu_device_free_pci_state(adev);
> }
>--
>2.25.1
