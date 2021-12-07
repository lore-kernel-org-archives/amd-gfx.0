Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39632C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 21:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8AA6E4F9;
	Tue,  7 Dec 2021 21:55:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CEE6E4F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 21:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSk/iNIpZdWn1uzROJbVlxtvXDwpamew7x+B+1/7RLQq9UxJWEKVHVx+Qhnh0ZMG3abL6mK/qr5Acii1AnKb7dvStdJ4b6adievfuJFwu5jnGhMpIMp6TDIeCTN3B+fET0NnMPafgp1TFEnAyNcAH/FoP4vUZBrZHUEOn9OaTVRU2ja+Fn5qglRT/TH2SLBUv2xRAnXXEFQVLbp8F5ewxfyAaBUidUb06oX0OpfLVqdOC5V1U9evuwhSDzLy+0JdywVIIXhDyiAEV59iQn8z8OcBhUA/Y+zSTLLlt25LgsbKhzInsChWx9QEJiQcrwTtZ6p8HA+FjkYB5kCcZyJgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WChU24C80FFDJKMotjr6Z3/MzHKRF6ug5/br9FRFtng=;
 b=HJJ7qHkG1IGP+J3V6r6oPw4l0kjbbtKZ+dLwM1uLKqrdd031TsZlHBe/Krko8NldSXZZRtQEg9WwUQbWJc6a3AH2pJMnfS8v232N4igYyoYTnWrVdaAiKyVX4z6UGH9rB3gGWWbE5yWlz9sKjUFM3bHMrMb3owo5fuFGm0qpITQ+8Fo8kYKaEcW1pdB/wCD43Fxi72Yq/9zqEkWFZb/M6Pi4OlRZijZuX2g2/c9xmdzm2dJCnUCaKPEKi1k/APAuW3x4PTCIE6lkREuqNUUJ4LYdtmFU3YIX+4SbdhMenRthKG3a+PmWnSuiTKWHsdoWVg4TeFSyqPuZ9fMTjFzosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WChU24C80FFDJKMotjr6Z3/MzHKRF6ug5/br9FRFtng=;
 b=F90XAhvMVIc1oGtCSZidiAhyMuZ2S1O+FqGyH0AK9qbaIAApbqYbDJ+6y1iXBL6v6lgc3rtOjbUPjy0gC8QaLtsCNlwc2QaoHVCWeIx4f9ui1slKtKhcArcXHHLWBq6XN7tyDJ/Zc02VnEFwev0umfgelenkb9j9mh7zwG3V/94=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 21:55:11 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::39c9:52c9:4bfe:14bd]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::39c9:52c9:4bfe:14bd%5]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 21:55:11 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Topic: [PATCH 1/4] drm/amdgpu: skip reset other device in the same hive
 if it's SRIOV VF
Thread-Index: AQHX64uPmcB3S5BJkki7rqQwrWGovawnZjuAgAArKFA=
Date: Tue, 7 Dec 2021 21:55:11 +0000
Message-ID: <BL1PR12MB5317C7ECDBBDAD33CA695102F16E9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
 <CH0PR12MB5372D0C6177E573CA38940BDF46E9@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372D0C6177E573CA38940BDF46E9@CH0PR12MB5372.namprd12.prod.outlook.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-07T21:55:08Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: a84daad4-1d95-46c9-a393-36a8b1474329
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82c70ff4-9497-4340-260f-08d9b9cc3e13
x-ms-traffictypediagnostic: BL0PR12MB5505:EE_
x-microsoft-antispam-prvs: <BL0PR12MB55055CC4DBCF5D9DDCAEF19BF16E9@BL0PR12MB5505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YDqjkVCPpT1suH91b3a+4avb2b7ua6TstTGoYq9OZNTS6QSlAanm4TWA5e9EWaQ437lbzxvw9MpvuXqBWv+F4ZUdTtqZjMxAk1rLs4r4Em5Rwk8Ct+u/WvecWZfQM9+TCLCPVKBus2Pw54b74MX/d+fQoYApUManRODGfT0c79tL3IFeubSwC6G08v7Jk9nUfpfeC5svO2Z77g04pyyK6TQClNy8Fhja0dfosX0Ax2sQkkhSxadTTVTeuGlki2K2cM7/9Kts9frKMEYyIqbutEzO9sKFNz06wxqmw7YgvcG1GSoV8gY7o7oSyRJFquFvloQFMGnvpZyIXig5jjJCVMgXDskF+oqx+axozvndt92Sk7C9bUj8JHPGWq0JDPgKHi13knLjbUzCvIK+ZTfg/lUfBWGZPVznWlCFbfwaEilx4QHVgVmBFIIFgoFtmAIUJkseSIiLMPLjvZK4YSw86tEtD/iqNMaFR1woY4CCR9cjVtT3CCBoDbjR44C4FXBx4rphfdJ4BA7nb0KOwjlaZP4gx8h7yOfmFneyi4cUwthbwQftmXrQvj/g6g2VFKh2vTmNYHDW4e3In4qTO2VB93K2IUsNBZqlm/UFDAL/yqxEgsTDdB+yrTGBCm7GZeUDtrTiYKZFi+Racgsl4/pJkgvA3pR8HWdn6JZrSOxwUOxxY5sF2lKTMv5nwfNd4fVapUm8KmKf2l6zuipaAqXqVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(38070700005)(8936002)(316002)(110136005)(66556008)(52536014)(66476007)(76116006)(55016003)(2906002)(64756008)(66946007)(186003)(86362001)(9686003)(26005)(7696005)(83380400001)(5660300002)(6506007)(53546011)(71200400001)(38100700002)(122000001)(8676002)(33656002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWc8HpJago+S0FSYdsXbC73j0JDOA97n5z8501VxoIquB1vgdPgqatFdVvqT?=
 =?us-ascii?Q?gL46HE9mocaNZr1pUuOxUzzqnNqm6sNtIHS67HZxPc18iMaveQ6/ZpdPvMD5?=
 =?us-ascii?Q?SVrTi2apXfW+DqsAYSF2TeXEqSWZ04TrTBkBsQIFiFrdUL8lx89ZRy8ruwrR?=
 =?us-ascii?Q?zbK/3aAPTE/VtNpmVEgJ21PZsj/5cA4+cQcDhQa+VanIBMwpzsIQ29z+fNYp?=
 =?us-ascii?Q?jqrppQoiKvu2VMeP2KWceQ9VoCVvxbPhVACETjV2YtnoQMmtuQbbplb/KhmQ?=
 =?us-ascii?Q?mD3LyDmkB1PKnpjNNtDlrtd0ocC/bZ/QwrPYXdfhUJkd/XzQVN8wYY01kcFU?=
 =?us-ascii?Q?xE89AGMfktGtV+OYwm0YJ4xD8pX5amKHIyXfK7iJDHQwSAzojtJNqH1amFoM?=
 =?us-ascii?Q?ZAsSHVGmaJ48yyiTZ/BCDhHhlEZAv+26riACEahq5LBizDnwxQa1GqyGZSUQ?=
 =?us-ascii?Q?Bng/iWMpILD8esAZpSpMLR6S2FgzgJkFPEJdiv4pDpmiAezKdFfGFSTQCoSx?=
 =?us-ascii?Q?F4t1wyKyPJqFzjCyeGQDOv49Jk2P3+MBFLBf49hlDN/gTAksTAzu+zz9DXp2?=
 =?us-ascii?Q?3BYUASxJcmrdhS9okbi1AkGVt9qqoV61xFIPn1CDoXK9YRrlE5q7pWb8S4lQ?=
 =?us-ascii?Q?W19iE0qNLJ5/OXmnmcpKz2n2O6imo4cG32vCGVepElnoYE+jVznIoULpiDl6?=
 =?us-ascii?Q?pPZT5gRlgLd4BAry8m2mAN6yrLdmtuoIWuoUgsZHVcFNjyYL9JIAcIB+jF5Z?=
 =?us-ascii?Q?gsZ4S6uJu6qWXOq6yfH0/R1JPgJQ85J54Hyo001D7Q3Da+quwhL32Yg5Flct?=
 =?us-ascii?Q?Mydi1afogcPHbS0pxQvJdEakGZModObvaK6TehGHxkz/4RqZTs7p5nRI7YQp?=
 =?us-ascii?Q?D8pSUGz+PHhjVkqogBajngTOwxii9GpByFJEaIcaVWXVh3qqkBPRNPv+SYa3?=
 =?us-ascii?Q?O70eRYCikznzCup9I5J7wfBwZ8MnlvDl8uY5+zXBIh9yBD6QbeF5XwD8VIVH?=
 =?us-ascii?Q?Ch1v2pvrO9RRULbXcP3OgfLybRJkiveNIYNIXmpCJGOm5I5bMmOPd09bTz97?=
 =?us-ascii?Q?Sa8CxGz9u2oFZtJijBFOrVq9Q8Ca0dnfud2m63bO/Z7m1NMsqEJvdZJoF6kq?=
 =?us-ascii?Q?8K1npq6yAFB3layXztE2H5FQfwHy+Zv/KaRN6ABEOFfLt6o5YUACX5iVxS+2?=
 =?us-ascii?Q?7dgkWX77MQ1IZj+mhd5oONbp2Kt1TvsKs722yOBCiSpHtcGpJJ8Uah9Rg0gN?=
 =?us-ascii?Q?26szEdUuzNRKWJ96hTdiZenYfR2yXoJZXowgvwUXWltyfk5vq/oGy3J4kTdc?=
 =?us-ascii?Q?9RUjRTeDZo80Mq3niDZqXoVylRqp/vECo7a7139UcWwtlnr+RLHxzcHH/xyR?=
 =?us-ascii?Q?CAEFnuf9QuuhoylHa5g9vEJvdA1V2qi7KP59sQm1JSPBtDLFfXnTLV9s5RGV?=
 =?us-ascii?Q?130ZPySI8qJdwji4rLFPYNUxWyBMT24AnvKTRksWu9oXKaeLu55fpsgYBHGr?=
 =?us-ascii?Q?i/iBAp28nbHzGEqA1VNITbqT+wg2+gWDFai+3lojUQuXgO+t/Fq3DyG90OdH?=
 =?us-ascii?Q?dtU7frnTHiNK2fb4qzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c70ff4-9497-4340-260f-08d9b9cc3e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 21:55:11.4340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtvKgu+4U+1pvdjhQaHAZJ2tVTW7Qf6/K1gee5i2/HqOV9XgCPKPA9juI7kZyvIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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

Shaoyun, please see my comments inline.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
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
2.17.1=
