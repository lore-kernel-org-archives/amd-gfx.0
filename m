Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ACBC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 12:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD4B10EE65;
	Tue,  5 Jul 2022 12:34:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711FB1131F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 12:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWDbcIowgP5CtdcUcm68sTjB8zXyserpoU/c9n5iccZPHRRn/LdXV4IgtULT1obbHFkP7r6QLjRlOAW8RmBgIGOBwOOaWcOQWAZFGhidyI0dgbTERFs6CT3OeLisegvDugmqcqJv2n4FYEAQJHZxq8R344Df+B7SFVwCRXHUF6OIF+vzhC3Y6sUwJPz2pQqJlLhps9ODDji2VRmUc2sEN8gwsHRJ9pJekbjqqKLpiQ6h/9kT6dg5Udd6PU0GuAyLScEhcjXuWm/WIORw/fo6778IGWukgFF0Pmv10EgzVaqzUnHNv79owRk1ZpEdM6Dn57iuExND0JXLkaHoeQ1XlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZHXQ7drWnMGthNHP1FvsPl6wwEtYTynEN3t9wGehSE=;
 b=R1Zmw2Sj+b1ZcmtB/gx3kkm9Uzly4rppCZh2U3+A65L0OVDh4uSjQ6IFDu77U5RI7ICGEK0tKW/+WJA6pCDTLw96yTTF4O2PonTK9b+JNbg/cVWML/UC3qKB+ICoIW5R8JKzogdmWdMmDv6H+HY7SkqgPnEVyBnpAkM7tGO4k2xjSSgFIICIUh3OanZjhfZkcY7WlHhld4b0MoWLOtuusDqAxsdjlLgRsRcnt1uoqh98Vw9e1je4viw8Zbg4UXYPYQynI8nikKFAf8yGiwQpgitDDpYxbb6bZ5i8YfZ8gvY1x4VU/5PKeK64hrcRv2HW0dWRnL1z84nckDz9srTO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZHXQ7drWnMGthNHP1FvsPl6wwEtYTynEN3t9wGehSE=;
 b=d3dHgYjEKFG3h05OT7XJVh+froqXMBDcuvYDmtfeRpAWdX7jMRz9yuyOByE1TlSjk8Pyn7oBVLLS9jZ0hyvmAvM+CZXcBF0qIjHFp5GtMReDI3v1sDt4YP0qE4P4yF2AS6+2lS3phNiPXvhyUcuvzhIIiNjc8GREfnDx1LqwGYY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Tue, 5 Jul
 2022 12:34:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 12:34:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes11: fix to unmap legacy queue
Thread-Topic: [PATCH] drm/amdgpu/mes11: fix to unmap legacy queue
Thread-Index: AQHYkGKf750mSQYyVEaVhdnd5XSVJ61vtlGw
Date: Tue, 5 Jul 2022 12:34:41 +0000
Message-ID: <BN9PR12MB52578EDD81778206F8929DB3FC819@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220705032354.978153-1-Jack.Xiao@amd.com>
In-Reply-To: <20220705032354.978153-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-05T12:34:37Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7fadb4d5-4d93-40e9-9cd3-5a72749212ad;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a3a0099-c3e0-4126-84be-08da5e82bb84
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vl0xQCxrqXnNbImg+BhSJkyOivrHnvcTsGD7g27AY3ykHQ3IdznsF7XtB7dtC4hI1bEUNS0q17DCfDPFUb5IJooE6y2UDjiWCt8ugm3GrTqfrWHbdQwArAd8gQwHSFmWqIjsooNrlbxlVesoH8f3Vovfya5vGweq66dp0ItdWEaonb4o9aBYe5Vrz1TA6kkbrS5L2HvR+tECziKoxke7PqZdAl7pP5ugAszu6GHkOgINlq/EpP9OIU/WG+PJMpESR7NaaOgm4PKi5hAk+5S2KaptviAnOKJSuHVrbwPxjhTFXxbu3FF89jq2fo4jlJESQzd6Iq5qvRnaF9htVdOgk0d85l4pk0u21fvDeMHODKcBfATMD1wHAenHTId0RFaEXt5Xos3Yxv3UcWU3nNtMIxkTccpbyKurrl5wdAUICYN2NcwAsABaWPkeTFuYFaYUZWp0c/WDmcwp00mg0uq9oPMT8F9EBQ7ORbRB/EqVqX0KRiIaHEQSPeeK/z8N7PL2VUeNP7ul8qlDvkLUdjjHHkaKqWnH4Ld8gCHDi1yFVrVGg+H2CPLzvHLV94KPBTCbD1rshV/tu+WaBhgEswzxI17mqEQgzq9g2vBsBm5V9438oj/areFnE2kGZxveVsKGf/Rteh7jngrDNwkUPCGRPv1EqrWhVFG747XYy1z9B887mYVwE8+7B63J/MW6Xk7e9+SovIVORiriGPrxF+4Ad1sWA5QN+sFiao4Ue4jnoLqwwj4Bn9SB9JoGIDyXpD2bjJzDuYuk1nTUZbbSVV9urzQrLjzY/YgFyrBhQV6R7QnhPPwQA3VE3ZQ118LKC7+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(76116006)(66556008)(66476007)(66946007)(41300700001)(66446008)(8676002)(53546011)(38070700005)(6506007)(7696005)(33656002)(38100700002)(4326008)(64756008)(122000001)(52536014)(186003)(86362001)(8936002)(71200400001)(5660300002)(316002)(2906002)(9686003)(478600001)(26005)(55016003)(83380400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7hW6+lWqftyt3p9IhibJW66ZhDVAKLg7vHRNNIUvukvTvscq/r3K2BBna1P?=
 =?us-ascii?Q?TMfLZ2fw24FG7a/eJxPBAjpIaou6sEg4LDAYN9JdQtB8rONJkhb+V3i/CLp9?=
 =?us-ascii?Q?WOw2rnX5Cnbjo9ZY3sb4gu0BYTcIQPb+pXlpfO2FCQK/cMbsE7JEbLN5tcDl?=
 =?us-ascii?Q?OGU5pYKQHES6rhfcH9NEnGa2hR1HipPap57XndYBovodoxh2s1ZSSD7pL+gm?=
 =?us-ascii?Q?9xGjnWJMg/Ts1n24gT9INOYtgcI3YG64GslM/mkOtOQe+D8Fy47J3uDuM+zg?=
 =?us-ascii?Q?Ymqt7U+LHvsQoWNVI157HkPpWnGJJVBDJvJkBvy0p+D1ib4lPBecNt6r2HuC?=
 =?us-ascii?Q?Vx5IjzgFcNqmuCdbSuve41kpszJBLv9TsHpHk9qzb9OF4MZMi0AOr/LrZTWI?=
 =?us-ascii?Q?NhRtuHXXfCJTUUOJJFC6DTt4c7OLIXkHbiGpDvMyWhoZlU1hiIiik/BCl0RU?=
 =?us-ascii?Q?zrkAzNBqSBjyVtOWoj1N4eqKmnwCta3oA5JscY08F2pYk0djwi+J3CN5339u?=
 =?us-ascii?Q?KiOTtskjezOPGFUOhY/Ic+2a015ZLixofGKtv/oIK6nVhGQQoD7OsuJGS2JE?=
 =?us-ascii?Q?W7sBYDx/bBaTskqv+Md/52puIrjmQ5QAQOr/mTVWn769yBipOPIqWIikbpDz?=
 =?us-ascii?Q?Q3kEvz4wVDekS81qafH7/NHWa+PzffK4TzoWLLqTK8+kiXldsF3iiohL2RQQ?=
 =?us-ascii?Q?5upODka9aCf4CkgEkGFUr93cue0cJBHESQKX2iviQRzdZwbpZpq6i5/YgwsZ?=
 =?us-ascii?Q?yPuvroZAno1uARlrTAw/lpOpMfykPPeFmOyIsPXca2PHfrD3ldR9pmuUdbeB?=
 =?us-ascii?Q?ezgPivOszK4FKA7JKCgPmesZwVdU4FytMoGJr1v/tfgRRu2VY/y74jUteoZ9?=
 =?us-ascii?Q?M8ESJnct3B5AJCuW/ms6OmXWWD2f4u2NdBG7xXZGschTAaSk5kOTSbWEX6K+?=
 =?us-ascii?Q?GddDTlYWWRgd8KHqtl+UXgXfCkmToA6KcsNgpIVrom5LajZ5vDlPnE8N2iaO?=
 =?us-ascii?Q?RSWFY/Wbd6guaAUh9xh7QSPlUhNcwg3R3c7BlT+uRaOXye0Io46EWMBeXKz/?=
 =?us-ascii?Q?eDnOcLnkTk5B8LATggWAhVk+2LNmgL2pXXpKw6E3G9fTuNO+A1p6Hijalcqq?=
 =?us-ascii?Q?iAvzv1WG0OnxL9YaxwrCCnaiAxiXVIvNhAJo01MbkGoOCivK1ZoOsde8XtXW?=
 =?us-ascii?Q?1RB9FFCpkSIzjJ8fRxqgeex63bKSZjYxdB/o56aTdp7/KBrpTEF9Wvo4mbH+?=
 =?us-ascii?Q?TB2l49audfv3/PmWnAFDZuEd+Ajm44K+fWgG0mUlMVuKDLz8S7XYTrt2B/FI?=
 =?us-ascii?Q?4ubRaeQl0syhALnMTjf80+MaxbgYy6W8TKSvuF1FSryZ46GDXW7ztIJpYfif?=
 =?us-ascii?Q?HVXvsUeAQwfGzGm9zSTgpAUqpdZuzFXYtCEB1SyhfntJrSKECVoYt7OzhWsu?=
 =?us-ascii?Q?cbifM000CW5GvRo2ZpIOITkDO3Q9G4uRy8380zoYEML3ufchuWMnAXfrOqZt?=
 =?us-ascii?Q?20KwxRXV9yp07/0Ca94ToZWQLpYEV84w9i08mMMtOnuxyxx1IMPxrnDTE0JX?=
 =?us-ascii?Q?fltAzwCntuH1A9ap6X9BdKwUlMGz5n1ys8Yy/XV5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3a0099-c3e0-4126-84be-08da5e82bb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 12:34:41.0504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3AV1Pldnx4oTUBuGsbZLfIyUgEt67D2Qe6QfMfREsREG+km7ksKVNHr8Q7fb44lBU2HKcB4q6sM+b4xzxQKGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Tuesday, July 5, 2022 11:24
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: fix to unmap legacy queue

MES fw updated to support unmapping legacy gfx/compute queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 9 ++++-----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 6 +++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 5bdc2babb070..6b07a8b23d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -216,7 +216,7 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_m=
es *mes,
 	mes_remove_queue_pkt.header.opcode =3D MES_SCH_API_REMOVE_QUEUE;
 	mes_remove_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
=20
-	mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset << 2;
+	mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr =3D 0;
=20
 	mes_remove_queue_pkt.pipe_id =3D input->pipe_id; @@ -228,10 +228,9 @@ sta=
tic int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 		mes_remove_queue_pkt.tf_data =3D
 			lower_32_bits(input->trail_fence_data);
 	} else {
-		if (input->queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
-			mes_remove_queue_pkt.unmap_legacy_gfx_queue =3D 1;
-		else
-			mes_remove_queue_pkt.unmap_kiq_utility_queue =3D 1;
+		mes_remove_queue_pkt.unmap_legacy_queue =3D 1;
+		mes_remove_queue_pkt.queue_type =3D
+			convert_to_mes_queue_type(input->queue_type);
 	}
=20
 	mes_remove_queue_pkt.api_status.api_completion_fence_addr =3D diff --git =
a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/inclu=
de/mes_v11_api_def.h
index 1d37ec2cd737..80dab1146439 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -227,6 +227,7 @@ union MESAPI_SET_HW_RESOURCES {
 			uint32_t	uint32_t_all;
 		};
 		uint32_t	oversubscription_timer;
+		uint64_t        doorbell_info;
 	};
=20
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -286,7 +287,8 @@ union MESAPI__REMOVE_QUEUE {
 			uint32_t unmap_legacy_gfx_queue   : 1;
 			uint32_t unmap_kiq_utility_queue  : 1;
 			uint32_t preempt_legacy_gfx_queue : 1;
-			uint32_t reserved                 : 29;
+			uint32_t unmap_legacy_queue       : 1;
+			uint32_t reserved                 : 28;
 		};
 		struct MES_API_STATUS	    api_status;
=20
@@ -295,6 +297,8 @@ union MESAPI__REMOVE_QUEUE {
=20
 		uint64_t                    tf_addr;
 		uint32_t                    tf_data;
+
+		enum MES_QUEUE_TYPE         queue_type;
 	};
=20
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
--
2.35.1
