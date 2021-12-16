Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B9BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 12:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D1810E508;
	Thu, 16 Dec 2021 12:21:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029F310F238
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 12:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9WOY6nMkWh9/WtCUA2K9FEMKirseSul/kG/yD1kYyWeJXkUvZ4jL5XYH6Lxy+jPPtus2Cq0svqmnMA6xRG1yKhb48HS7yscBb4dhwxBR68cJ/0HeAh/wYtf7ogINKx1LlkfSrfLbOid6hOMPtmpoWOwy208WMT1l+he1EAvfFzfifOOWO3m7kc1NkzYumw6dihUgFNubwSez6TOiz5aPRpJtRHExCWV/Qu1l+y8cNti130Z20kTiwleEvgcz92/iQqIU0y+mm8t9dD71Z1pVzalmtW3712S3KmUa7OvYYhHCgnsCMRvLwLczNOSiVicOV9WbqwGVXiqD4tt/LwWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xnb0+El8JhWoEK6Xpr8rSehNUNfzGVEoBe7GNfyW8c=;
 b=cE+U9Cs1g7VPwFPfpNmwX10W5LudHDIJLBeoq5mTBSZBwVTEe9kQtCDwrd5Sql63AN3RW8+NkOr/v+PYTkLjkqbYhJ3uYWChdokWU4MGmvhBVvbUmcnIVlNLHhgEuTIipB3HATVhIjZZJ5BWgXnaApub1JNSC7ofT8WJmg0ir13vAjg2IY4a1mDJ3PubRMP/tgyih7lpJBJNRVFdlJPs7aB5UQ7cy+fIxUno/7ti8nBExoq/w+p5D7YNezRsnQvvbKd2hM2F67w6NfgjYUUN75TiokEBtLvaYJDO6Q0TsGunqkGTWhreg0kAQSymX2VjjnT3Pe0PWapayziBFg4VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xnb0+El8JhWoEK6Xpr8rSehNUNfzGVEoBe7GNfyW8c=;
 b=ffRGzRP7ywOqF7/A4WwgkIn3YJScAq4y1JI7JTUrbjCRy2xSnr8Idx2oEUYuFtK5ME7Oftw2X2SgancExJyS7FyhDc0MjmueCxtaVWfZ9Mla9Sz7IrAFc3IIwsDVpgB3l+NVlBSV70FoUmyHKPXmoEBhJoEd+cSiKfQxLdvC0Qo=
Received: from BL1SPR01MB0002.namprd12.prod.outlook.com (2603:10b6:208:308::6)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 12:21:32 +0000
Received: from BL1SPR01MB0002.namprd12.prod.outlook.com
 ([fe80::89cf:cc51:ece:74d0]) by BL1SPR01MB0002.namprd12.prod.outlook.com
 ([fe80::89cf:cc51:ece:74d0%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:21:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
Thread-Topic: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
Thread-Index: AQHX8nEVFP+xiYYYxkutVFWmA/fRE6w1CXzQ
Date: Thu, 16 Dec 2021 12:21:31 +0000
Message-ID: <BL1SPR01MB00021E27716174BE8B8544C9FC779@BL1SPR01MB0002.namprd12.prod.outlook.com>
References: <20211216113532.12369-1-tao.zhou1@amd.com>
 <20211216113532.12369-3-tao.zhou1@amd.com>
In-Reply-To: <20211216113532.12369-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 109e931d-01c2-4f24-9e93-08d9c08e982f
x-ms-traffictypediagnostic: BL1PR12MB5303:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53034EB4AE3B53C47D6CC060FC779@BL1PR12MB5303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49AX5sdzirj/YkOUjLDxUEdBe5wrFTKhudYvuSc/qifUQmowF9DQXt3CeeaAfl/yO180c8IOgF56XqMFfYUxsRbacX9AsdROdBW4YmHM4EXcBTJ3EAFztYfD3YkTTSC+o1ZZi47wmQWO2WtQhrIZLj2+P+5YyY/pmVm5pC6WVAgb0UZsvwJv6j/b8cLgZKzlA+cck2BKuGOAAV7m1OTO9uukrnZaUMtdJZZon0Y+0Mn1Pgz5a+/g/VUokEBDsS6nEoz/QEzU6scVNIUcOB9JOOfM18ecWHvQt6KnTLj3RndtWYigRshMxeRcTQCZegDPcaba6ecnLPuhrdD+VC6AyHm9UBfL7KMmfC4pSAI7PKyMZGpt24SBG8AKsLGM8IubRjZ5PaTao4ANDKUdCcY4BA5L498AhYMQhR+RYLgFMa537AHtlBYsZ43D8Soaz60WNdkk6WdMevZH7RrZLngwN8I3JlByR+YnFSRBvluOIdMIukZXKIupnu6y0JO3ylP6PvxNfD61xjnO8y4JBgPw4MANfeUSMeEW1argXhvjneWeYysSTQk6jr+jNW4ChSYB6Ak+7hmEjx2A+gnKE5FvCvZXqHL4ds1PM4s++slHIZwaSOjVchNXkRR8aJ/HIW1wr10PtaDADqzSTWucdRppZQVK3BHR2TemsSA3B6qqKpE0D0/c5wRp727rpgeaoaKZS6208bZ7DGABW1AV9E0VEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1SPR01MB0002.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(2906002)(66476007)(66556008)(186003)(53546011)(8676002)(52536014)(508600001)(7696005)(83380400001)(6506007)(66446008)(26005)(6636002)(5660300002)(71200400001)(9686003)(38070700005)(33656002)(64756008)(76116006)(55016003)(316002)(122000001)(8936002)(86362001)(38100700002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G4WkwMl383WcecS48ZNDf2beicZaMBJWIeXlzSGrKOHGbN7fUgHiPR614rML?=
 =?us-ascii?Q?keMMirRZ5SAV0bWpxEcqttSSbQNbMd8bO5l9pPsfU6yPXgtKzqgAdxZCDBmc?=
 =?us-ascii?Q?LVMXGdwWixmBXLlG85oUTT83J7PUBAi9I9AawrhLnSLnNLGuA0CHtXMfMrta?=
 =?us-ascii?Q?woFFGsQECgZ3XagVTSlpfTdiGoCkOGm7qaBU5ymN8FjrNfILkNc7jIrjU2ZH?=
 =?us-ascii?Q?QFqbEAdB9qi2TzFZKmmgtSofEy71GoQME+ymyqrAnBvEaAOgdP1c/CwByNgj?=
 =?us-ascii?Q?yEDIGPYZwMCN8ld69d2K7Oyw+HJ2YItH4zkOLInmQ1P8AsuLl7CeRCzsD+8d?=
 =?us-ascii?Q?/m1ZpMmElrj95AlWfptjuTZnOfyW1c2NEdMYxBifHAGLc1M1vTEDo0+wJTDb?=
 =?us-ascii?Q?MJqo3pMfzlR9j2WrMwulHwdLvyfdvhyQlwFSAhlrxLXMmfK6qFbIs8ldx2MF?=
 =?us-ascii?Q?LkYd2Rh8EJUpopkLRXw4wCIXQ/FCGJjlR7YgjCiIwzHCuf4pEWcEGXhgFEPU?=
 =?us-ascii?Q?WsCQawDSG+JplDvN1EVE/fLROZF0kItT/ij9I16ADBKHpIqM3nS59XxS8Cnj?=
 =?us-ascii?Q?fSEFqpIKf9DauHn7vtWZjGcG/RoUqbAGS03U6rLbDd7pphzesHoXd7dXmXYr?=
 =?us-ascii?Q?CB101giRNXixR7RQA0W6dG6AzJw6dr2u9TaZP3Z1uL5FTh6fo6jnGqSNBd4X?=
 =?us-ascii?Q?Rkwvd6bQ5Bzk392+Ync5xcXFOvpTkewZGzm6DWE7y+Ihxnel6d9dWjwk3pyV?=
 =?us-ascii?Q?eJO6IRcEOzGNMaZZVAEMlqOznCuHhncSRtjUP+wbxgeBYlEN8PXo6cc3wY1I?=
 =?us-ascii?Q?xhiCQMWTfpnSnTs5wE6vBz7yHQ1xn+yZifKSPSp58nYY0N2sWtl1+dUXs/uF?=
 =?us-ascii?Q?cCQzLNqCILKKJFrSKdbeS29iCkUcGAs/p2QU4wTiz1vxgseylNTpaS4EghBU?=
 =?us-ascii?Q?TQbAzGOXHYZRdb8pbXvdw7nouaV9seh+KWxka1o/8XElv+obg/u0JiqDIM9z?=
 =?us-ascii?Q?/EQU4z7x6LAaNoZ0yLd9tIKvMecp2aOBmo+i/Kx2QEGoKm5sIdF+tybQ/PNB?=
 =?us-ascii?Q?qXoewM09WSBWtUeTFHGUMRf4XbkbMEIHocUBp67h2BTHPOmddi4UrB+GKIdu?=
 =?us-ascii?Q?OHrmpYqdsgZtaRt0m2guBorIj9Mhu40k+o4EZJztzAUz8qmArYOg6tdaf+UD?=
 =?us-ascii?Q?6CGS+vO/rtVlqwmyyOKiedq3rZiq2kycFtmc0pAKebYukhO7QEjZJgqfMHwd?=
 =?us-ascii?Q?GPp8ws8NyjTwuFix/ztxvQE6k0JzoH0F9oRdR+eO4y8zvVh5zGMs49KobgMO?=
 =?us-ascii?Q?IRtJmnglXPqgq6sixb/0LcDgqvFKALDFE5DCzdNohSTBe5c3YFemUK9Fythu?=
 =?us-ascii?Q?1ckDm1ySNf6QXiGv7kYyJMGRaWTKH38A6Y/GqSEVBbebzwo5EMKjZhzkQ1BD?=
 =?us-ascii?Q?REEQuyf2swv2sLPAHw/zTMcPGVjN1J470RnyG4wPX15pzTLTXPJY2PTpMNSQ?=
 =?us-ascii?Q?kLt4Trz6g3AaRssbFr0vwXnJ3Cxu6t85QOsNEjyqafQShrNunmRDh8/AnKqs?=
 =?us-ascii?Q?2fjP7ZXIXH0cj26LoipBAuQd+TbuRjH9xbqybbNpLaMcbCvYldz7ZGwM7r0D?=
 =?us-ascii?Q?ZTUwcOuqH9BlxegVDugLRAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1SPR01MB0002.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e931d-01c2-4f24-9e93-08d9c08e982f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 12:21:31.8134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25DxhpkyNZj809WuGeiT2T6BYg5g/Yjmp8czv3+nWoGbmMlEhQwqlF1rY/j/8f3zFiYfJUJOaVJjk554M1OcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
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

+
+	int (*unmap_queues_cpsch_poison)(struct device_queue_manager *dqm,
+					uint16_t pasid);
 };

Might be better call it reset_queue directly (match with update_queue, crea=
te_queue, .etc.,)

Others look good to me

The series (4 patches) is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Thursday, December 16, 2021 19:36
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; K=
uehling, Felix <Felix.Kuehling@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison

The new interface unmaps queues with reset mode for the process consumes RA=
S poison, it's only for compute queue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 16 ++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h    |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 01a2cc3928ac..b4b0495c7024 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1476,6 +1476,21 @@ static int unmap_queues_cpsch(struct device_queue_ma=
nager *dqm,
 	return retval;
 }
=20
+/* only for compute queue */
+static int unmap_queues_cpsch_poison(struct device_queue_manager *dqm,
+			uint16_t pasid)
+{
+	int retval;
+
+	dqm_lock(dqm);
+
+	retval =3D unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
+			pasid, true);
+
+	dqm_unlock(dqm);
+	return retval;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */  stati=
c int execute_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter, @@ -1896,6 +1911,7 @@ struct devi=
ce_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.evict_process_queues =3D evict_process_queues_cpsch;
 		dqm->ops.restore_process_queues =3D restore_process_queues_cpsch;
 		dqm->ops.get_wave_state =3D get_wave_state;
+		dqm->ops.unmap_queues_cpsch_poison =3D unmap_queues_cpsch_poison;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */ diff --git a/drivers/gpu/drm/a=
md/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_devic=
e_queue_manager.h
index 499fc0ea387f..19ec3e8859e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -81,6 +81,8 @@ struct device_process_node {
  *
  * @get_wave_state: Retrieves context save state and optionally copies the
  * control stack, if kept in the MQD, to the given userspace address.
+ *
+ * @unmap_queues_cpsch_poison: reset queue which consumes RAS poison
  */
=20
 struct device_queue_manager_ops {
@@ -134,6 +136,9 @@ struct device_queue_manager_ops {
 				  void __user *ctl_stack,
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
+
+	int (*unmap_queues_cpsch_poison)(struct device_queue_manager *dqm,
+					uint16_t pasid);
 };
=20
 struct device_queue_manager_asic_ops {
--
2.17.1

