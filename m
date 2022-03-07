Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABDAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 01:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB1310E08E;
	Mon,  7 Mar 2022 01:58:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A035010E08E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 01:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJyBGVphI1E1SSXMVuvvPa9MiAcktgBbXtOE9lEi65yCULDglI6829X9T7RYF9CwuEdOPKo1PtgjQf8blLocpIl1Psu4WlurT8mWGVR9Nxg8h5QP974pKSa/73q04Zou7GMvIAaCR47NMuOV4UD69/dWc2PDtw0/0YaIYEN2I7Q2GLgHr1hWzSDEGXoxi7fXgNbXkUC5kUMSAovI/snbs19wnPvRjpYxBrSWRuNkXRVxXO6z6z9lfjs5PepK0iSZJwVORe3NTeYzrWw6i/op10qmLBEFOteFVHIok/DVGouz1M5gLnNbwoUnHzICPRLTwEBQ4Lh/mDArx5+u70lRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgkfGNbGx//3WBw7UxNTEbivoUfCXvduilAdfy3SWlc=;
 b=FRcMArNU1+H6h0EtO+t7bs51xtAQ1chWbC/Xeti4uRE2w0SyzJ7SRalqCgs7Ou3ThlPGbVOhygevNxA8cJeW+vH9tuqmIpqTH8JJprcVkN41ZzJiOXsu55Lz4gJU+VVYRMluzNar2LF0Kt40lvWkgiyzZImZXQDXzlx/CIlEbA4Ox6QBOL7aP0zJ1x8a3r+3bhtVI2JPEFFUVendp67CfbWC8JJMlxSx2osTJLVYtJ07k9BgWejuen6rjjPBCPnkmWSb4/w/tpFuGO0izpFmTZJoxj6WBbBkUgaXBZfX2k1InKT4WtdHOsse8oA+B6Zeo09JgVz2PwV27hBfDLtR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgkfGNbGx//3WBw7UxNTEbivoUfCXvduilAdfy3SWlc=;
 b=BSY50ZEJ8crhXuwlgmljIn6FHUK/CQnq7OXAsPMGJaskOT9PHc8vweO8TEFv6bGaIcjNvrVUJ3d9jg5fjNUc/JHdCV+rmrHeapgx6i6g1X38AWo/qC1dd9ZoeC/Exjk5ag/tbEYdJtctDaSEvw2rsRpzPpAAlQDY68vQdKcGoZk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 01:58:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 01:58:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Topic: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Index: AQHYLImh5x0m0QviAkSU532f7tBtJqytBb2AgAYuo3A=
Date: Mon, 7 Mar 2022 01:58:02 +0000
Message-ID: <BN9PR12MB52577C416F9F1CA54C030533FC089@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220228095723.721786-1-lijo.lazar@amd.com>
 <BYAPR12MB4614485194DEB2361556B60C97049@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614485194DEB2361556B60C97049@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-07T01:58:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d1fe6b42-0ecc-46d0-aecd-3d383d99d3ef;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa457c3-0b70-4bbf-f59a-08d9ffddea0b
x-ms-traffictypediagnostic: DM6PR12MB3739:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3739510BC05AB004E486C38BFC089@DM6PR12MB3739.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WajF3a9ApX1XqQ8coVXisw/YmqfnEcdt8JNPsL9u6O1r81ZhnDNtv92Lrw4L+OI3a3dCJxA+VTUnoqldO9EDnZdGPi7lq0OrzJFknuevgtDWEnDkXjdbfSX1zxmxobsQx+yUEgfDHA6VGUyM+tvUWzbuWoKisOr4Kqq2l4LZ3gGJLq/KyI/evt2zS6EcYgr3YM90ZfqmtismF11RmRqvSefKnFKx2Vw4nI/sWSLOCsTRP5HTxG6Jmf49piXcTyRM7BEc4hTVGfjZSV5lD4lzTdQSkZjf3OT4MtNPcg1crFr8xvbfcydI9dgVXKRogqat13HZSHu7klIN+c3tpZonk04yNw6iU+1wBjbx5+kPjHO7NkUCI6HSiXYo6WVLGfw5PLq2rGxBXW69Poe7KRn0L0sWIsgFruYTRmvF5qXs020EQ4pmEKJChpzaTvyY8M/Pwlbe0BmR5gjOjwELDEuvtHBxQaEITEGJRP5zArsfj/c5tGa3+EuAiBi6vVwQNYN3/GwwjPKUjHqIMY6aRc4iK/gauaJ7xMoPSYEr5MOQndDtdMdEK/fa9ECUUW+B89ofvqRz75RPv5WlAYeD6takYydslRVz2LTzyr/dZOESdcl9/I5103+XTXLm9GRQUImw+nccU0N/XZAun4xxq6Ag72KZDgIDQnPnuPK6F2CxNCHivKaxQZtzzwgBUwKQpL9IwIUqX5HzlycrBWiW5b5QrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66476007)(55016003)(8676002)(4326008)(66556008)(66946007)(83380400001)(66446008)(76116006)(8936002)(508600001)(52536014)(316002)(38070700005)(71200400001)(110136005)(7696005)(38100700002)(53546011)(86362001)(186003)(9686003)(26005)(6506007)(2906002)(122000001)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6GTJSPKqMXWhm8+PXNNVEXwKHQfppWnPzxIJQjCIUYuHTRpDDdzBx4PaY0e3?=
 =?us-ascii?Q?cneJx14FrYuV/rnFMvE9FT+3Z3bYB8uPqqCQy/iV0l61RdI7zmqMxRzLOqCU?=
 =?us-ascii?Q?vKkffGbQfGQsSNaJNkTXzBL1AfKk5goLEkjNZPNkAfYH12AiGkBRsuudxtau?=
 =?us-ascii?Q?fNGz2ygVi3aQ0Fenbk+F8+E9I/Fq3yD4WoTMfUDU4mZnIPzK9nNfl8wQOcVu?=
 =?us-ascii?Q?huOZKieFUZAuC00xIPntbBkLgvRXMGRdAL07gTmHwoXZXDk8i+oCpikoMUpd?=
 =?us-ascii?Q?mA9m4TYo3bpHOljSHopfnv6IMN4nuKfzssX/fC87ZFx5B0kjs8iKEpqFnIR7?=
 =?us-ascii?Q?bLuZLnmLrea5o5fJ9yLdsThxP/NpVzaX255sZYxNgFQtG5zkFaMZfiU8xv3m?=
 =?us-ascii?Q?16UFLqBj2uS5esDZ4NOD5a4PgtBMyBf98uqsGaUKWbc5akx6c0TjqCiqVvGp?=
 =?us-ascii?Q?cV8+BfS2vVUp4U3w8DbPREHaguTnxzm9r0Z8Kkt7/Z61qTPaitVZAsYqEatx?=
 =?us-ascii?Q?PmDDPfv52Qa+A3FJybjvdgnrFgXgrsmInF+cKcrYPNrOmp84mNSrc9rOAhN2?=
 =?us-ascii?Q?5GqsO5lcEvoR0x6A5/Hu2U9lIelF6T+U8AsP7uoK3cPQqjqA0sHzR5eMChbR?=
 =?us-ascii?Q?dT3DRLELE/UwyMoOD797aO50WL/6fD3rcEBc0sB8+ef1GS9YcMNvOleXWgI6?=
 =?us-ascii?Q?vCHsCZSeDY5tgWgdTaEsIe4/xAmaO2p9CbCzrPoavl8cI6FkcdG5OxujGmaK?=
 =?us-ascii?Q?kFH7/6YULsMgmMMFzz7hBDnKxUkMViFusJO/4snXdKBhDzVcQP+G9XTFGj8t?=
 =?us-ascii?Q?e+deAiK5v0qR1nC/X8iy7lCwZNhisgUCd/4UwCPo142LqQ/qjFJLLF6mlLUT?=
 =?us-ascii?Q?IVLHkZo6fvO/8dfB1TpnY/Ygfr8nVQh2HOTWcN0dNl4qucnr3tlnM8XM7CAD?=
 =?us-ascii?Q?R9pPVZJUxIvNvBVYUbVcHuknVb95wVvhclxRSAI04ALQ3krCFfIHmsRF/F3h?=
 =?us-ascii?Q?41L+qqcGwlutYF7jVWf50rwgKnpGSUEwMLhNxYtebVBpytRbvNkO97RE/9C7?=
 =?us-ascii?Q?r9sM4Y6RbY7xdzCJSgfJw0qc3ppfak105Jy63Ie3m8e5iQiw8kcBZtQIXldU?=
 =?us-ascii?Q?n/bnLsdmECL8PhQe2B+g6k37I8MRDyELXUGTbmzlwOuBTMTtHqm6ixXJvodi?=
 =?us-ascii?Q?c5Uhpb45t69L5R8I24x4dD30jpR5wdXdxX2eQ1h2RSvuNmU917UOFxEQ9KkH?=
 =?us-ascii?Q?ezsd5D2bqpz5/pxfqipRYCQT9qLK9ITVJFiu1g07oHmlQrV56+CMft3IWLeJ?=
 =?us-ascii?Q?/i+QBPXZv7lE5kaKTOlQVl14hE5spXfNErMitXYqjyH/I0PX8qAEAdex8714?=
 =?us-ascii?Q?56GsBSeIX59UHhJFDMUp4kyoVnFfPT9JwRMTbIucRpderUoF7CbE77clGWn8?=
 =?us-ascii?Q?fvBf1N/Qyqmjp+gkEJfs5gXB87SdQnDNFp1NLKJqUsY5k294wyyvNIPry1S1?=
 =?us-ascii?Q?die+uhqZeNQsMbn8O0O8NvnYPd1VdKUg9FaPhnd8/vTmQvEo0lMcXpSZmYSr?=
 =?us-ascii?Q?lEeEE/PrFNxUY5GWXwkD/t83r/2GAmXe0dy266/54wvuZy6GX9VNEOYSRlMG?=
 =?us-ascii?Q?FsFotN+NBT2KLOm6BGr7f8U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa457c3-0b70-4bbf-f59a-08d9ffddea0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 01:58:02.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oA6Z6HDlHZeRQORiUXKbb+ssKQWFHNkP56gWMPSKO2bkS123KjjK0JkPcuL3TPXb97ayQZJ33UgTV1axfu+gqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Thursday, March 3, 2022 11:33
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2

[Public]

<Ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, February 28, 2022 3:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2

Use IP version and refactor reset logic to apply to a list of devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c    | 66 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  8 +--
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index a545df4efce1..c6cc493a5486 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -31,6 +31,17 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
=20
+static bool aldebaran_is_mode2_default(struct amdgpu_reset_control
+*reset_ctl) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device=20
+*)reset_ctl->handle;
+
+	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+	     adev->gmc.xgmi.connected_to_cpu))
+		return true;
+
+	return false;
+}
+
 static struct amdgpu_reset_handler *
 aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context) @@ -48,7 +59,7 @@ aldeb=
aran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
=20
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (aldebaran_is_mode2_default(reset_ctl)) {
 		list_for_each_entry(handler, &reset_ctl->reset_handlers,
 				     handler_list) {
 			if (handler->reset_method =3D=3D AMD_RESET_METHOD_MODE2) { @@ -136,18 +=
147,31 @@ static int  aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,
 			      struct amdgpu_reset_context *reset_context)  {
-	struct amdgpu_device *tmp_adev =3D NULL;
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->handle;
+	struct amdgpu_device *tmp_adev =3D NULL;
+	struct list_head reset_device_list;
 	int r =3D 0;
=20
 	dev_dbg(adev->dev, "aldebaran perform hw reset\n");
-	if (reset_context->hive =3D=3D NULL) {
+	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+	    reset_context->hive =3D=3D NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_MODE2;
 	}
@@ -155,8 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
 	 * Mode2 reset doesn't need any sync between nodes in XGMI hive, instead =
launch
 	 * them together so that they can be completed asynchronously on multiple=
 nodes
 	 */
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 			if (!queue_work(system_unbound_wq,
@@ -174,9 +197,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
=20
 	/* For XGMI wait for all resets to complete before proceed */
 	if (!r) {
-		list_for_each_entry(tmp_adev,
-				     &reset_context->hive->device_list,
-				     gmc.xgmi.head) {
+		list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 				flush_work(&tmp_adev->reset_cntl->reset_work);
 				r =3D tmp_adev->asic_reset_res;
@@ -186,8 +207,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
 		}
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_NONE;
 	}
@@ -319,16 +339,30 @@ static int
 aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 				  struct amdgpu_reset_context *reset_context)  {
-	int r;
 	struct amdgpu_device *tmp_adev =3D NULL;
+	struct list_head reset_device_list;
+	int r;
=20
-	if (reset_context->hive =3D=3D NULL) {
+	if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] =3D=3D
+		    IP_VERSION(13, 0, 2) &&
+	    reset_context->hive =3D=3D NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
 		r =3D aldebaran_mode2_restore_ip(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 02afd4115675..e9b9ce80f7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -36,8 +36,8 @@ int amdgpu_reset_init(struct amdgpu_device *adev)  {
 	int ret =3D 0;
=20
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret =3D aldebaran_reset_init(adev);
 		break;
 	default:
@@ -51,8 +51,8 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)  {
 	int ret =3D 0;
=20
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret =3D aldebaran_reset_fini(adev);
 		break;
 	default:
--
2.25.1
