Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC06C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 14:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A2110E210;
	Mon, 20 Jun 2022 14:00:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4CE10E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 14:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtHnI4lf3Vf7WLxnjRzIVtE8dh03uMPyjKi+Gz8WaKJMR4AYP7g+zpjHznlDdAD5Ryhz6pqgDqd1oG7LcH4jha1ToQS7Z5Ga0U4nN7EJbyNqYmCEgse4wx9b499MlUAytUNa3VLEFsISlaNh6zmA3Mi2gFXr8bIFipq1deX00AkOZ434yEGPBZxNT/clFhxlLacJePBBPPB5pJkMk93/WqPEuRDVW4Mo6aXTRAkEu53d10i6SYY5Uzi4jdIUwPg9o25oWMM4ESRuLEXC6aKgquzFjPg9u8DFfGbg0FndZoaRPbeUh8uZ9HVfcBCinm3rZANnzMJKm9ZSpkrOCjHjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z0ywIy8TCrtsdvUA8h9mftrdS2n3NfzGfkS7IpczqY=;
 b=R3oI1EQ6c7PHnhGKQ0HEWN0c/r+lVXs2we8VEoVW6WfqptEIolV3ZYmfLkQoxuwP4PAWlKlNXAQLoaCGL7O0u4TRDaaUi0S1ygwUk1vfVCM1E0MYU/LIEFiv7rIbUBiQj0FLlvVHpMtBNtoLYkHGiluc00kfaaBaHIf42w4rkwLWZ6UshGH3JpvIM6CP59ewCQeuyo8mjuymPw/iYv83dj7pQ9e8JZbLHV2/4G5J76Sw2woWFvEkfe2Rf60DYORB1TY6tltVs3kEQXslOLMa/ELzv00Ote7qNErzzTri1Et/7qmiB8H7OeczbWtBXFrM84DwFI/wDHyJeOwCtAj2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z0ywIy8TCrtsdvUA8h9mftrdS2n3NfzGfkS7IpczqY=;
 b=sLPlkfzcgrFiLNoclxmiA5thXJcD8OelkU/vOb97fSzwJJ9rHO5ujXtAgYEWEs13kcnz04R6HbqVpqpqnTh+QSucHaROS9b35v9hUSrnNi96eHDrsAz5RgIXNj1HYp666Kqv6rjXDeIaTseft3ARzG9wXC0En6Af/EmU8y6cHKw=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 14:00:46 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16%6]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:00:46 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amdkfd: Add queue to MES if it becomes active
Thread-Topic: [PATCH v2 1/2] drm/amdkfd: Add queue to MES if it becomes active
Thread-Index: AQHYgoRM628mglvmVEKVEYfiUdnb7q1YVksg
Date: Mon, 20 Jun 2022 14:00:45 +0000
Message-ID: <DM6PR12MB306767F9C51C517B6EBA0AE08AB09@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220617195528.20894-1-Philip.Yang@amd.com>
In-Reply-To: <20220617195528.20894-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-20T13:57:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2e87a7b3-0a0a-4939-885d-f971a79d509d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-20T14:00:43Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4793c90f-71e3-488c-9b01-3f1cbadafaec
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b89d25e3-8f4f-43d2-580f-08da52c545d4
x-ms-traffictypediagnostic: DM6PR12MB4121:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4121A1DE0C561FC137FBA6968AB09@DM6PR12MB4121.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sw/ZJrZN2lVECG0U5nAvYp5VBto5QZ5xS2MMS/vswdtkIwHln3X1YKsZ9rkKkGo2W3Du5uVg2TvvNwWgTjV2waRHnoYq3QUBtdoEyXo4BwzRgmmf61+1ODeiq+GOCSHeBhqvxikSNSeecZtSKkTRC1mHKIb11FtIdWf9H6EU0zL1cuqakAjeXfuu/ICUNHJrbLxr4mD74+iRnmBDbWXqspTlUxZ9EoqUtbTO0ZI2kiPi4IX3FuhqtCSq/78nAZ2mlx4x0elLyEEVfvi8Ks7B2rjyH1DlZHPE8YWT6CJDcdmnH4e3ReJFdhpxnjZxblD7MoxNIpF5UahnY0cNIfo1I46yk6DfoPDSC07EXzxvruwm3AaGGDlSqrDsL/i3wyhhbm3MHEk7VUszYrbMD6qPtMjvv8d1XN0c45QG0C9+nxA8jJxWCd7+5PVdepyz9Vm+hBGDj9tYmWbOnDd6P0W3RlfLENARW0UPVnTWTw6zuM+A+xrbDzj7JKwtzo+GE7bQiI5F3iA9XDPb/RHhJV2ThGXGwXueu8RBkIPaxqKapJ3m7ulCMmFowrvWDric8Z2LI5t6zdFfFm6X65q12Ghxd72oE1+Yb9W6CNE2e/SFXxtUnFxFbEWgjQj7LDlVGJ/73T5tPs62DMQtC7Z8USlJel76sOkoPWe1EpW2mHbl23z93RQNX6njE+rE15pZaIrulK9eOZ4jaCVLvVvbrollYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(186003)(122000001)(83380400001)(5660300002)(55016003)(7696005)(38100700002)(6506007)(2906002)(38070700005)(53546011)(9686003)(316002)(478600001)(110136005)(71200400001)(66476007)(41300700001)(66556008)(76116006)(66446008)(33656002)(66946007)(64756008)(8676002)(8936002)(86362001)(52536014)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ME323nTvIXKRkgQo8dXs9HCKaFnXwS0Zmfy/i4fAiphXKRXDA9hfK5rZ4Odg?=
 =?us-ascii?Q?njMnKyUJcgVBlg4pvwG0ZguRJ60ptzWMKtyw3bMzNg1EtlQ5n2yxcW91rRSO?=
 =?us-ascii?Q?Sy+/+TS02j/6J0CfUlyNOPvOLByNOCLaXYhRj/LMI546lQTMLp7qAR5+quEU?=
 =?us-ascii?Q?hxHNGe9XUgHnEVFgP7ukDpN6wOWdzSaMdWwK7FE0DJdAA6KpEJPsDf8SxvO/?=
 =?us-ascii?Q?OfHxTOImKLrwiJyyStst+upDeH3Ir43eGQ9LJGXlp9WuyM2/G+QzBb33GXM7?=
 =?us-ascii?Q?rrdlYFp/CF24lqJlM8Ev4qKJfB2cRI7U6DtjR30kdxsYjlMkh4XNHNfT5oua?=
 =?us-ascii?Q?mkoKKkuWu7s1tis/zLZETgGOgtpVIYfn9JfED+x1ZOLebovhIAJpQUZzJm03?=
 =?us-ascii?Q?JSjNaRDU2O5xbvdlfIJSZK0xz51KhW/CA/LqASmhEV5Dj1l9X3e76xme5yuS?=
 =?us-ascii?Q?msLyGoYBSaLNTP+/jltQ0LmreBD7K7rntak/s7jwSaPlwmfOHI9e641gDKXY?=
 =?us-ascii?Q?9bbTcnE2XE3cR3h2wdz0agnefl68MA86ChBiFjn1NatFVEiOexzgGKGDPat1?=
 =?us-ascii?Q?mtT4wg8aXAjYYKWfhyarfcb98qIaTJXie6EjE5ZDUd8ZnXp0ggsRtm3Udds5?=
 =?us-ascii?Q?/JBt/C3jUmZDsWCFfOkLG1taeoq6MFeENejuYbCsIC/WCnIu7Feex9IbBTpF?=
 =?us-ascii?Q?00Gkh9usC8KUlYSwPQDJ4nWO9L7plBut4r/AHT6LLTsDNOSk0Njb0C0ZJWXG?=
 =?us-ascii?Q?jagRe9TYQz46XSkQ5x2r13GwqeJXP0tVxznlKL2CKJZ92LukgW3YcTNgdOxY?=
 =?us-ascii?Q?BimxXQohE7qBCxfftHTIsVZRNI0IUXVin+ReDoc4fc/enzoA9hoy8HAw8iIb?=
 =?us-ascii?Q?+oQLj2FIt0Kau24N8i9Ei7KckbDmrq6rpDfuxwnXFegh8+j9bk+Thakzp9Py?=
 =?us-ascii?Q?spJEiZzvHIHhxAqCrTUiFvipjxaMDAjQdbbCm6b6v/tk0zjeC3KEWkxsx0m4?=
 =?us-ascii?Q?pPp9CXQxXF0DrCOEqa1k92csQl00HCdakF6NnrvQEwjR2IloFw/bZsafYUt6?=
 =?us-ascii?Q?mTtIiIUU/9ItAXijfXksSrN+Rf1kyqNPodqD9fu2+J4xKlCrt5O1EpKaMjBB?=
 =?us-ascii?Q?T/IkJTkWtB6lWVoXEvL+XQfNV0yRLeq+jTtzASV5dkUpq1VGPpkuFRmtpMGX?=
 =?us-ascii?Q?4k9K8Vfa22OXXipFXMNNp2v0O6wC1PUR1MeLYzt74Kb5PtR0a9VVNsh6jbW4?=
 =?us-ascii?Q?5MRgtrgXDa+DYcZGCSH/h2ZJo8PhGpIZ40XiyGvgQjXLG4SS6z5RIpuLco2L?=
 =?us-ascii?Q?tYeAr9eicpmoPoMeH0ICDD8Y4lTTQTJmSI3om4mQbQ5C8lv4OZYE/JYRqDme?=
 =?us-ascii?Q?bMOdygRDIdx7kcKhJsRdU9wU60CqdByhe0tVmptValVpol+2PNPgEjmPxlBu?=
 =?us-ascii?Q?+2Pcr1AsowHRXvu9toOUYNiAc0RUgzV2xYUXt5bwWXpdq57b2qGV+ylnm/SL?=
 =?us-ascii?Q?+Jojbfj5GavfxSGGdOdczItfsOhJcTUNQDMtc0ofSc5cZ2/kdPexHGY79SXH?=
 =?us-ascii?Q?JYJN6+BizcXJ1pvyPZvi/NoqmvIN6FHS/GpzOmrufml/zv0NxTVSQ3iun5XF?=
 =?us-ascii?Q?UJ5QLHk01ptZ31JVOLUEmH0xn1Lv4iVdNMVH2eW99vyHoYTqUy+g0C7jztEw?=
 =?us-ascii?Q?G2oilP8yCh6MIGTTG+0OF05icDBmv5h0xDepnxoOwA9z87QM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d25e3-8f4f-43d2-580f-08da52c545d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:00:45.9456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDHHnldinqA6C2yEKWMSn8juABurcmg0IGydSxEjVKKilHZuYOr4F5e13UV7YXYMKDBFKvz8EFogxiQiuY6Uzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

[Public]

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>=20
Sent: Friday, June 17, 2022 3:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sider, Graham <Graham.Sider@amd.com>; Yang, Philip <Philip.Yang@amd.com=
>
Subject: [PATCH v2 1/2] drm/amdkfd: Add queue to MES if it becomes active

We remove the user queue from MES scheduler to update queue properties.
If the queue becomes active after updating, add the user queue to MES sched=
uler, to be able to handle command packet submission.

v2: don't break pqm_set_gws

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e1797657b04c..21aeb05b17db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -811,7 +811,6 @@ static int update_queue(struct device_queue_manager *dq=
m, struct queue *q,
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
 	bool prev_active =3D false;
-	bool add_queue =3D false;
=20
 	dqm_lock(dqm);
 	pdd =3D kfd_get_process_device_data(q->device, q->process); @@ -887,7 +88=
6,7 @@ static int update_queue(struct device_queue_manager *dqm, struct que=
ue *q,
 	if (dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->shared_resources.enable_mes)
 			retval =3D map_queues_cpsch(dqm);
-		else if (add_queue)
+		else if (q->properties.is_active)
 			retval =3D add_queue_mes(dqm, q, &pdd->qpd);
 	} else if (q->properties.is_active &&
 		 (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE ||
--
2.35.1
