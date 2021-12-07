Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3BEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 19:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4B46E174;
	Tue,  7 Dec 2021 19:14:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC30D6E8C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 19:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+4mUBEI7CS8wfBCMWkM31Js1Wv8ys2IXoZs/t/erOf+okOj6FEU/c28p2+MyF+wQT0BYx7q/NVHeF8CD7sSf9UOEMW/m7zPGGbbOPuEtlWHSa/sNwDxBX0qRV0FvSUnk3KMjd81dXKDuP3ac0ojXIH9j6iFmAIfzaNT015HJEUVEfiMj1de2LN9kfE15wpjZ4g4QRdAtOwXwqdPWLU/V9AhIAw6/YpK6Cc3WMGpsCKud3VWHwxVFszQAemBD7svargCGaNXy8+KeA0Er1n3+dhOM+RJffY1dgvpm+LA32aeTEB590mz85ne9bkDBb8uIUgfxrZNjjXrxaBY/nrp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9elryVlSLCf4dYGSM/kEDKxIL4eKZCfrISV6L28uqc=;
 b=fjJXr6/NBJGRLv8f8/kTdtyxIt4WYHpnidDQi+mdgFDTnhymQKueQeJ7fe+3hUMPnYuzhTnUn3Btw+xoasRnKgi3z50c1FKFBqpeHRPWUG9e6VxqB8UnIAJIM/VgJM4IqD0+XvANTPukfJdyr+iZ9m5MH/ofpJnQjPhiDV7lAfR6mKWUyfmLDiAuyXneGGyKpZ8+cGvH+TYYeoqT7fSuEv4Ujxc8lrlS0emDKxzZ55GZ5E/Ehb4D+fXcWoZ8FpJnaKf/GwN7JMxKK+A0O3fYpn3E7DhP8Yk0sML4JRPYEoBGFTsPAsXkvP4hr1qg+S1f81rjPEFSc6cHrFjWTQCv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9elryVlSLCf4dYGSM/kEDKxIL4eKZCfrISV6L28uqc=;
 b=Jm6ZOVwGnMJWj8EBuTf6RdtoIyAXes13wyP0HfSxxmJm2EAMxq548atWCckO6Vcp3xwkhk88T03ifqLKpB1uDnAS1d1AhKmLTz6+G9La0Hcip5ndJQB5IwActdwcTccIwBhq5PM/83DFMW9Gq/5sT12/b/8LVvY8PHBt5e+26RY=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 7 Dec
 2021 19:14:31 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%6]) with mapi id 15.20.4734.024; Tue, 7 Dec 2021
 19:14:31 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Topic: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Index: AQHX64uST+qR/VKOAEysRSmrf3ADF6wnY1Tw
Date: Tue, 7 Dec 2021 19:14:31 +0000
Message-ID: <CH0PR12MB5372D0C6177E573CA38940BDF46E9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
In-Reply-To: <20211207165727.25109-1-zhigang.luo@amd.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-07T19:14:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 1c93349f-4eb4-4939-94a1-3671a4a3be81
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 616f5f3d-7f8b-4870-d64c-08d9b9b5cc11
x-ms-traffictypediagnostic: CH0PR12MB5107:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5107C0493867973F27825DCBF46E9@CH0PR12MB5107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5868woQvyQWk62tlZDPUkBQAHqw61ZXWmrlbSzTJjlUv/K+KD6hnlxKGDi8s1gBbAC5bz7bK7yXF7jtrAqwWxiJOIimW7275x9hHKI8vlmQm7MFXNq8Y6sIIKAdG7RoFJWpx78hbuocFQHz4Rv1uK/M0yldZQy/BkNnJlinqZFaQl5S4EngX1qJ3UlF3laZozEP9CFXFtO6PMPf71/8tCGGH4DMC4gGGIRemKjVTKcDUFJGh4pxydL4GrWDl0bppLZ9p5dbypQbfbTdGWHAE3cWGFQeOaS3sC9avdqMCLNjjO8k+jRNV9WOk/sjkGbZmuVylmlVTjon1GkW9PKltf1Yi0PuC/VBtyR0jz66xqBw8VFc0FNQBsFZvfmwnUivSZKRdD0J2X9JAojAszqYjE5p6pY3pWVe/gvFaql44LIdtjEUbpQ2QK5z1XBM/Zh7xvIVCeWbgepxSB+ox4C+OB/W1mSIRJ4yuS4Q2kD5xwwXC55Oax7CFJn0VJvXAMMNYwvG56sfiZEaa5SBxMhq+muM8RptDHRVCtbNddaSvNA0rAk1wls1b/tbOKSQAKDer9jwANHk3W3g3KcdLE0Hpz5ay00Y1hcg2xwYj/9wBfzjZqrM4YTxYFW2DVH7fNnNXkQL5qE1ixabMUNomrU6jC4pWdTg/mUva55d6dTieYgy8INq/e9LfbQOi0qYy3WgYgKj3awj9mn+jEM19Kjf1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(53546011)(5660300002)(8676002)(33656002)(86362001)(508600001)(8936002)(6506007)(4326008)(26005)(316002)(64756008)(66446008)(66476007)(76116006)(66946007)(83380400001)(9686003)(66556008)(38070700005)(7696005)(38100700002)(52536014)(110136005)(122000001)(71200400001)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYnJY+mBEw9mQTnOU3w3QU46//ezHerAA4m/gDMlaKO7Dipv6ZtTprzP+d1J?=
 =?us-ascii?Q?sw2lx6vlwBhSK5pXNQ6iFvxHP0norkmKTe3Q5uaCVwtHEh31quXVc830uD3n?=
 =?us-ascii?Q?+qGKgobcDOkCn+13K4CQgZX4fxALSB/27WFK+Fzg6fsR7ISti8jV9sOW+E0I?=
 =?us-ascii?Q?CaSdMudGOuLWYWmb1Yjhjy/EsuFKKOnuidGWeFrz5VbeCT3JNrgvVqh/5MNH?=
 =?us-ascii?Q?1qP5owGL1F6GwjiRBF5kKNpny3hojj6G/fw1QmsxpezmoEGy3SR9tXhn/y1w?=
 =?us-ascii?Q?knCnbrLYUvUo8e+Po/Axtv42Id+OD+bvISXx+HR4WyBmob/ilOphjtOsZOP3?=
 =?us-ascii?Q?Ehsux5ih4AFT6MHyYYEQgvv6Zo2gvaHXnWoCtHD+ooAs7W3YZTPkBkOtB8lX?=
 =?us-ascii?Q?ETibfy1EBo1dHqlZFYY6uBi6bkdlHkhMLV9RAK0uHcZtYcwAZqI7Pzt+ciS8?=
 =?us-ascii?Q?MPIaPloAstJmIpjXG4NL9HKlXosuHGmubGjBY2MWdGXeRzn5hqXn5NLrCt3a?=
 =?us-ascii?Q?+upOSRBJMalx7m1AAzjNCpwSQPLswHxyw+PAnMlV5aNDyqXZZg5rJQrfaFRt?=
 =?us-ascii?Q?AHNUUorYV20RLHCmxpHC3Mrd9vcIQxnMc7TTWG+W3SfwZpZUbFTt6mbYY7Uy?=
 =?us-ascii?Q?Uz3QBcgfm/JfR1GPfOAXtpkinw0BlfnFFNkUp1nFy6CeHVuRcJe7F0nnFcZy?=
 =?us-ascii?Q?z5TChfJlFLNde0lmnbuIvphl56yv+fK4T/AYAmL+crPHlffMVMC5Lr24Hp+Q?=
 =?us-ascii?Q?pqeRgWHhGamM2aFpZm0vHeY48bQUFPh20csNR2I+4AZzIfEg2XOK05OEpYIA?=
 =?us-ascii?Q?SPSFVmFIfPMHDrkgQ7hHt6CRKZfEgq5v6is5kgskAUpkYbiXuizpHc6MlKLz?=
 =?us-ascii?Q?mLk2uQB73hXZTC0/1W0+nkkDY8OVlewXVHlPLUlTSHf0tvCa7H6R+/x8V17W?=
 =?us-ascii?Q?Kgy2PSxIksxlcbhIqE1HM7GsIFEJ/nFCWHRgy3HRS3X8h7jghck3ChexRTgU?=
 =?us-ascii?Q?Wb1MsFmexYqX7es72yshMvGy9vi+ziCOLT/Ukz82a843x/PtZ63bxgK8qeMf?=
 =?us-ascii?Q?Q+ie5I9zViWbEAO7fsx++GkIlnsohxk6MXAEObHa8vrGhITGXp+7Z4hoE34q?=
 =?us-ascii?Q?93jyDtoLsn8kR0wkP6qqKqgBFY8Dhx+IBkpetO5pRkD9GCAUoc+A/rhqr8HH?=
 =?us-ascii?Q?v2H2SGFS41w70Xe8KMTrkcfIn8hkKyewDRE61ERFo5Juy3hW0/IyfzB9p3Ck?=
 =?us-ascii?Q?QV10Jab13ijDgrIG95ffBYccDTi0jSXh1RJi6LKGpVTlj12gPbsERkeORjMS?=
 =?us-ascii?Q?y3/1kcm6Danj+LSD6jW/60Whvq3Dik6+Dj6zEvKJcvlU9Hd4aAe+sCLlmvp8?=
 =?us-ascii?Q?DgsjyCIBqNl5/P78u49LvQ2zK1MZ93XU4xGnmFjHxc/xERGPqkJqpR8pFlYI?=
 =?us-ascii?Q?GxjnDzORDH2dqfqfKvAnQsJARM4XspJZA/Js36KOHB2c7Qo97xX1RyXJikX2?=
 =?us-ascii?Q?4gTrdRNX2iFbRwL7TYRgAqqH2tnlfKteita5WHih9nXYZgVSMDdC2lNCfWM3?=
 =?us-ascii?Q?eMojWxq6Utx/5pAQD7e/tKcMk4XnLYw4iwsjI4GoMd+21mouI23miWjbZsnS?=
 =?us-ascii?Q?aA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616f5f3d-7f8b-4870-d64c-08d9b9b5cc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 19:14:31.2202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbEyRUAJwzDRyFkq2HFAZ3sP7tpxsQr5Ao5sprgKl0PT5df1eHoqLTFklW3Bz4Le32hNbk6KxDgllPb7K7d6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This   patch looks ok  to me .=20
Patch 2 is  actually add the PSP xgmi init  not the whole XGMI  init, can  =
you change the description according  to this ?=20
Patch 3,  You take the hive lock inside the reset sriov function , but the =
 hive lock already be took  before this function is called  in gpu_recovery=
 function,  so is it real necessary to get hive  inside the reset sriov fun=
ction , can  you try remove the code to check hive ?  Or maybe pass the  hi=
ve as a parameter into this function if the hive is needed?=20
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
