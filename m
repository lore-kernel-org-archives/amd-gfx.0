Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C85BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893286E03D;
	Wed,  8 Dec 2021 02:23:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C636E03D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqO5gUQlR1deUiHeTOr+rFRvkwwgWIxWBtuzzdCGG+Q+jmb+WbLtx11umv2JqmGtlsugAZCHMQR7Q2IcZMemio7zfqnx/ecBib0CVLQK2KXrVbCUtYCFeNbtcoRCcUIcvjI8x2zIDBQvNNMnfMsTlSQ8CQJGB7yHM1gbNdQnlNROigWUL9B7+GVWhc4p6v+vM4bKKeBfefIF3mR73vCMSOW6/7dUeLam00vycT0/s2Q9mL9ihlQbQtgQn14i4+heIKq93UQ+vLR4z9Hn3yw8IDg6IVHHGZ9dWTFGSyPgJ6nYdQkh30myjmYgHFXfKbEdjC6z9gcNA1Kxe90z7pUqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V9+buvTUeUxqCAKuT4lXFat2NSKsi0bHUDJhjabIPc=;
 b=IrtmrigKhyO67mm3JizJAeL52Dd72FR53/HVxoAbl+Bv8ustAApvA2gyetqfnrn7vy/EaZd1wDcIETxkT0Ncn5iPSUGXtmnVdBoFbAI8p5Qz6lv4DFTPIi+zftOEWsFTdSrIEaYjAiW0Jej75OXkvLd0VJ9ylmJGxUA3lxiTp05IUrmgq7Sod+0YmIXXD6zr/fediHUfogz99HgOIq5gfqMSDtGcalqX5pF7QbqKZCbE0bhu2h6ov70UUek0pg9t9YRXXokKGx+bV4jrDD/u3Vl+rlo8xcNEIHsF+z2823INub33DBr7vOPJNKkmepN4wN24TJJbjt2aPvmo+I8ROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V9+buvTUeUxqCAKuT4lXFat2NSKsi0bHUDJhjabIPc=;
 b=NiZcyzmW07NjRg2qKk0dSsYdh7l6TWeSVIXtihaLvfYu5tdp8ux3b9cF0FfQR9Cjh4aU/bJh0xiEWAhvkg2QO84zlKHqALGV553+9LnmJxi+qGd7xjhwadPx6Jy/VRTddWCbH3OwG+VlpRaSqsIbQa1u3EVkz3eyGKOQSJO+p9g=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 02:23:20 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%6]) with mapi id 15.20.4734.024; Wed, 8 Dec 2021
 02:23:20 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Topic: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Index: AQHX64uST+qR/VKOAEysRSmrf3ADF6wnY1TwgAAvy4CAAEmicA==
Date: Wed, 8 Dec 2021 02:23:20 +0000
Message-ID: <CH0PR12MB537257DE511819D498FFA7EAF46F9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
 <CH0PR12MB5372D0C6177E573CA38940BDF46E9@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5317C7ECDBBDAD33CA695102F16E9@BL1PR12MB5317.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5317C7ECDBBDAD33CA695102F16E9@BL1PR12MB5317.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-07T19:14:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ba1bd4e7-39e5-44af-aa7f-e2d9f9e627bc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-08T02:23:18Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3a5bc9e9-f2d2-48da-8379-51a80a1dbc45
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27575fa4-0e81-41eb-d7b7-08d9b9f1b3cd
x-ms-traffictypediagnostic: CH0PR12MB5330:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5330C16C902BBF915F84AEADF46F9@CH0PR12MB5330.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJWD66cFuiBF39hVUZQYCVstcPqqrkyfuFCrBY1/WcK92nX2rcE39who/XQOhZmLbDe5fanc9xh/oPjIS+MEtSxY7FtaipIGm3Fvf7b87BdlKSm5BDAsPtK6xyvsdZyTdzgQlZprXFoXPIMxi1VT0FFbNgRSGNa8hqQGuVDjObkBnAM/p/6KmT+xOmtaDKmqDaLL4T/0GU4vCaQmSORJCUyl0UoJLmUhA1qtM1HGTI6BJTLIT7aj8NieKh+nCkina000vGtmwphE4h/5imC4vAoveeZ2bXqCgBbgmvCj7bsdYWVZiallQEKdK2eZ7U3oCRGxIhp+4WBxP9Gtg4JzcrjE7bcQf1XuxSE1QBx7EgTIaLDUHkFHOtQgDP5eS8e7ag2lfJOU8FR+AgrWhbvsu1Hu/qx/GbC51OjyTPNT2pNpUNXMgrITrjB2ghOAp26op34KPAysab+n/NM8ZWbArwkMN8stOk0Fdh5Y787qVAUJn9uwGK/lN24LfW/SE8mYAT+4mW28avJ5Dtd8tXfaY+59hCphsU+Le2ioQwEZkyYaRL3uWpcD708zL9V3en9sGbnW+1daP9hxV34EwM9WTnwXqJ+GcVRv3+Ee2xKk3iFyofUvdUM4uiLh7W0Gnfusu2rX24I5EiyM5ouYBfqE+f414qKM+h+yQiYoTvmjxOhn9YjOckQ5Vf3H++s9cS0CcTFGOociaw2XFMxjlRrvzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(9686003)(71200400001)(38070700005)(8936002)(64756008)(316002)(66446008)(33656002)(66556008)(8676002)(52536014)(508600001)(6506007)(122000001)(38100700002)(110136005)(66946007)(26005)(2906002)(5660300002)(66476007)(53546011)(76116006)(83380400001)(186003)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mz4A+jyq2FLEzELqINtGkYnMtQuRmKWNOSmmmmv3rU16ri+bwlQH1M2lNC87?=
 =?us-ascii?Q?NjL7Ka9Q+N7yS1/Cu0Vw9QA4LJ/YFiClztZNUSBJ4sc2Vd2CmXRxkgJitol0?=
 =?us-ascii?Q?7/25xP8kbX7ckqYJX5OfJKVMytI9i6TKo7HpVPsCjAunpaED5FkYf33JX2J6?=
 =?us-ascii?Q?nnmMA10mmxSU0YJMZYlg7tvgLgKlgJwyHc7uLt6DjAQKMWzBOwh0Kyk09IpG?=
 =?us-ascii?Q?2nUpSepLqwdXG3HbQsgfNA2D7DOTUAxyk718Ogrkqo/riNVeo5CPPTRl7m+E?=
 =?us-ascii?Q?vjtu6LoMN11qb1DLNoBdKgULIgkeiSGl6cdS0GXThqKbwlxjIvqI8IkJg0fk?=
 =?us-ascii?Q?4Xz0zgNrib7jNUGitkwgFqfGRHAS6DQoGh6x2pgxF59gAx8x/9hiTX55nmbK?=
 =?us-ascii?Q?BevgA1T3HzS14qiaFNI4OYOvBmzmsC2d53odX7Nof64cmTGdKLLI1CACcKC9?=
 =?us-ascii?Q?wlfrDKCEuz8CMLoVQWOT+axbUJah+q0RrNMoiAgAExBSBPXKBHhPavZb6/bU?=
 =?us-ascii?Q?Tmzn8lVPqekZdOUqQDb9UMCtxwtD12n0WVHRJ3P+oFj7xb58nESHZ87T2M4U?=
 =?us-ascii?Q?QcDCR0dTSM7h/59PzeCenQCsOz1gW4ORmFz1bBov3KHot0WQqWkWPeX+tsDR?=
 =?us-ascii?Q?1fMD4hAjg0WzP2KD8tOIfnOGmabfQv43ud8I+Wslj1ufaIivQA17GzTdWeD7?=
 =?us-ascii?Q?KtwTOGJHfCuIAt8oyKzOfWX5reKlpkiKrjve/lUcOfc3/dvAfK8MXFVLJxm7?=
 =?us-ascii?Q?4oOUWSrfZnRegsWQEsDrf4aZk3RwCCEm11/JxEncnugtmm+waKbDafY8aOEL?=
 =?us-ascii?Q?kJ1VQg/+n1CJ1B65roslFffRyP3XomI3Rirc0ZYfPt1JSIgmv2d96pqPvvQ4?=
 =?us-ascii?Q?RGB3P2hT8cN3OQA4ef8hDPdDYBbmhrj+s9yFXkBdIZFHSuNWO1xzkWO/526z?=
 =?us-ascii?Q?sQz/aDtG56ECZhqGxtcWiWpwBiSF42tv6nX44FGafX3XKFZGJY+nNL2dAsjC?=
 =?us-ascii?Q?pO8JWxSyT+bJMRdCDTXuDgcTUYFP9bZ0sLrNQEOPvHo1zze1mUx5ivZ9neQ3?=
 =?us-ascii?Q?KKhnK8ny7vGzXMiP3+WNKlWV3iKHlaBfpdlWO5ZCU/x/khAbQFx3AN3Lmk6e?=
 =?us-ascii?Q?e0DUCr6i5iIbigD8Ztrf3cJv+4xvsC4n9xt9ySzSiqSabHpFJlQJy4TxNL/B?=
 =?us-ascii?Q?FafTs4f4qToRWGlhvWlhloVDArApUEFZzmtmqQ9PEc4giCsAhikptUrmw7ax?=
 =?us-ascii?Q?2gtcL0M6iEG4lim/xebTAqNZi+dtDosorVvrLV4X++k69JMELqowAUDc9yFi?=
 =?us-ascii?Q?voKqEHzezEBL0ZYeDscQEfYpNv7FXVRqEpIcmiYOn78gadn2dNfch1FJeATv?=
 =?us-ascii?Q?mHkZx35uFNHu78MVu63KSluJ0YWUxPfzDDQkjwktvFO0E3lDnihbM3gDn1zh?=
 =?us-ascii?Q?BNrwK83GN3RkSmOY38/LtoPP0Xt2AAvIAE5GQNEio1GlXe/fXEpeN+zdylZs?=
 =?us-ascii?Q?NgT0o4D6iJ6N7k1IndxazxSL0f0qs1K+Mi0GZ34HmbjclGPLc8c2+A3rTK/a?=
 =?us-ascii?Q?hONELLv6cP3P+y3Oh3kGjY2cZh141FhoJRjx5Mv9Ysr91ZamA4zou7+CPoVE?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27575fa4-0e81-41eb-d7b7-08d9b9f1b3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 02:23:20.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2GEn6dbsxdngH4U/Mj+eJrobMWPcJr/fo0DJhTn5MIfCUgS2wmqkk1sKOffi12Qy7njB2UuTOOtcL9tEnFJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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

Ok , sounds reasonable.  With the suggested modification=20
Patch 1, 2, 3, are Reviewed by : Shaoyun.liu <Shaoyun.liu@amd.com>. Patch4 =
is Acked by  : Shaoyun.liu <Shaoyun.liu@amd.com>.

Regards
Shaoyun.liu

-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com>=20
Sent: Tuesday, December 7, 2021 4:55 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hi=
ve if it's SRIOV VF

[AMD Official Use Only]

Shaoyun, please see my comments inline.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: December 7, 2021 2:15 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hi=
ve if it's SRIOV VF

[AMD Official Use Only]

This   patch looks ok  to me .=20
Patch 2 is  actually add the PSP xgmi init  not the whole XGMI  init, can  =
you change the description according  to this ?=20
[Zhigang] Ok. Will change it.
Patch 3,  You take the hive lock inside the reset sriov function , but the =
 hive lock already be took  before this function is called  in gpu_recovery=
 function,  so is it real necessary to get hive  inside the reset sriov fun=
ction , can  you try remove the code to check hive ?  Or maybe pass the  hi=
ve as a parameter into this function if the hive is needed?=20
[Zhigang] in patch 1, we made change in gpu_recovery to skip getting xgmi h=
ive if it's sriov vf as we don't want to reset other VF in the same hive.
Patch 4 looks ok to me , but may need  SRDC engineer confirm it won't have =
 side effect on other AI  asic .=20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang =
Luo
Sent: Tuesday, December 7, 2021 11:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive i=
f it's SRIOV VF

On SRIOV, host driver can support FLR(function level reset) on individual V=
F within the hive which might bring the individual device back to normal wi=
thout the necessary to execute the hive reset. If the FLR failed , host dri=
ver will trigger the hive reset, each guest VF will get reset notification =
before the real hive reset been executed. The VF device can handle the rese=
t request individually in it's reset work handler.

This change updated gpu recover sequence to skip reset other device in the =
same hive for SRIOV VF.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3c5afa45173c..474f8ea58aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4746,7 +4746,7 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu=
_device *adev, struct amdgp  {
 	struct amdgpu_device *tmp_adev =3D NULL;
=20
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1))=20
+{
 		if (!hive) {
 			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes")=
;
 			return -ENODEV;
@@ -4958,7 +4958,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive =3D amdgpu_get_xgmi_hive(adev);
+	if (!amdgpu_sriov_vf(adev))
+		hive =3D amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) !=3D 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already =
in progress", @@ -4999,7 +5000,7 @@ int amdgpu_device_gpu_recover(struct am=
dgpu_device *adev,
 	 * to put adev in the 1st position.
 	 */
 	INIT_LIST_HEAD(&device_list);
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1))=20
+{
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		if (!list_is_first(&adev->reset_list, &device_list))
--
2.17.1
