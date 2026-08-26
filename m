Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79A8C61DC2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 07:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D1210EC14;
	Wed, 26 Aug 2026 07:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4U6HMkOL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B786E10EC09
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 07:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mb3qc33+43KCEgIqCcPFif1yodkyCWsybkSAKKNwIzTWRIXHsR+8DI++K3HEKJQ2Tc80zN4hozXV1yVsvaU8ZMhQPuWZh45nh3SnYzZYOOYc7yUZQS1F3bcqoTqu/HXAW7o4+/2pRb/dgG+krdNDQbw7mWzsOujt54CbVmAKKVFj6P/Z1wTeGQQueIRQo7/ocJhlv14lwEWh0P173Vt2qG7RPGNZzAWnC81FjllFTQP2cMqyTF80xK8s3v3XRKuDLHYPBbEJav+h0aD0frCx/IP6CeQqBwKKOz/O/Mjn6H6KcCnni/mG5BWRsnZpQoRvm09xoGK6sdh1iKIVdf/FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBF061uKIS0dMlspfwhSNdaiYF/wmeW29l8Gg6LKoIg=;
 b=ybNcidkgsgA6hfm7a9lS+1Y0fp43bx3O+9GujN7de5vvHctotp+T4tHSXDOuhJhEXAz6FEd+T52a2MusGK8MwwX0OaeZuJ2pDy+096lZ3HdOW3iEWj1ScZMm1YJaiN+ZlIn+TxM3h8w7D8f+UlXZ0JWbRL47F5i+NT/4AbYGjUX2vq+pkCVU5ymr9+OVFZfq1/kbY4hLBF08nDvG18N8wlIDES046XKrPj8CMmpf8BYvokWrRcuR5O06ToZHng4L+uTExlOzKNke+M4hADU4tU9w8vNfZeRkF3IjocWFCs3IKaFz1Uk/ewgj/hCJsWdRf5Ud2ozFnn9DN6G/r3F0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBF061uKIS0dMlspfwhSNdaiYF/wmeW29l8Gg6LKoIg=;
 b=4U6HMkOLCb28/vwo+FKBTHJ6cQaGsK1ffUYGvd8F0z3Zf4U9L7trrvnNe8czGrLImGcmTEJU8IHCJQFlGbsATxf1gRZHB6uCFKpWpHlwrj3nP8YDVMFoX5czNkEUue/4j0VlnDutvxID5BgCXbkwUu/E370diryfAuSm2tMONR4=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 07:38:32 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d%7]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 07:38:31 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Topic: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Index: AQHdMJJ6sAp4+FJoG0WIyvpypN/0+rasxHgwgAM1yKA=
Date: Wed, 26 Aug 2026 07:38:31 +0000
Message-ID: <PH0PR12MB5420C1220169411AFF1864BFE0AE2@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420452B1526CEBBF8EFF704E0A02@PH0PR12MB5420.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5420452B1526CEBBF8EFF704E0A02@PH0PR12MB5420.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T06:35:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|BL1PR12MB5777:EE_
x-ms-office365-filtering-correlation-id: a346afe5-434d-4cf4-f091-08df03450726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|8096899003|22082099003|18002099003;
x-microsoft-antispam-message-info: qOIRZKFYEWbjceNY49U3SosCatPNVclrgYiQ4UjttkqS8q0IWEtoK7Qf1y+QJj/7UZDOZobqdZv5d+27i23V1H2+lI9sqZkXpHH/IqccoGRdBnTbLOmtXpeqdem2qnjbQnKXTA3ra55YTtIEtFzxSYGyTR4tmKvKC5ZLInsXiDmY77z8hq2gn87RESI2vJ+e0AvWf/+6ZJGxaqTIgsPMS3gwBuZL/QqJ8VIiUod3Qb0Pg9L5MNoWkhniuLsXRxsvj0ob9YgOoKg+fVQLW9ZHilW8t5HjwUFtTWVXlqNjJg0USrY8iWbDW0QFHObqpFL5lHJKBgxp3PLHXHfoo2LBFMXkQq2oPgflvAw1poaSimxvIjAI9cZRkCsY/P3YTp4SAYghDxuC/NogJqEEmEVwizigpzXRnP4Lo8GoiS4etXK3eyqup8TMt0BcxNHNviHij44jWbRMihui90Kt7+igIQrxTsbb6oC/sM47b/WscmVMV9Vkx5y3TPC8qtFwN3Bz0MVZFfl5XOugPjMEbMe9GBXgimXdmhf9dGwsNCc/MegwHcynw+1chZMaqDz5UiD5LeQVOC5dAPEAYt9oQMd8If3BV9+xLYECOfXpkC2FWAzBk70NPJ6rvP5E8H7A4t/QAKwvrNeavI4fEEScws+TdON8CvPVlov5uh9n2EK31JAGfclFwpcbHJ4cFeoEEK+Wlxt6sRrSvaowQHI9/KbDgzJ7UXtvmienjzLOMBT33uM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvLi7rBf+MVjwy5/VcNgdcLDxrThy9sp7qG48lUgjDvo1l/d1b0TPk6Wbo4S?=
 =?us-ascii?Q?B+SseWi+WYCFTGukZSTCFTcBQpNpocyJLXcD1ArSXZaezbRzTuaNuZoM6rVA?=
 =?us-ascii?Q?2289tyaoQF9LOqvDOeVenPMRZSbUl/p3U0GgD4Vqf493M8oA0qm4u0Awk/1k?=
 =?us-ascii?Q?B8Q1F+MkGE1EYQew7Cb/HGIhce6rbTUorgBCeeyJ5+hcTzobjxhusxzZLcUN?=
 =?us-ascii?Q?3RFPJJ6J7VYNDbdm81vt/9suwmBN8wdZA/cS82JsSjcxkYT6SEN4lL+J/j1Q?=
 =?us-ascii?Q?m8DLvx9seU9om40pw27oKygcK+lUmvd7bGHy6Y4d6RBcf4HWRoKOvk9aFrLH?=
 =?us-ascii?Q?vbZ+LXNjh8Sd0FUI19eRV+Oc+JehrE441+U/3AgzlospFYGmbw0JeeYGv2zx?=
 =?us-ascii?Q?hZOoyMPGfeIrLjr9H4grc4UjhXvnZxKxBN1uyCfrPkkQjUblTfHI5rOhTTBe?=
 =?us-ascii?Q?vjUqL5pRj95UKJ9/UcwYsRUpPGFvgL97U02T9kjXrfXYAjrvDHBU4CJb62be?=
 =?us-ascii?Q?5/buOEMyCRA1ZqrG0wOoDp/0xTDnnH2Tru5e7YgL3arzP1qVj0CJFkbEZ48L?=
 =?us-ascii?Q?GpPXuhJld+9foDFyMJY55GR2zcRjpOToLQzvAzaixf4/IKKFJmOVlFEBQ0XP?=
 =?us-ascii?Q?F1D9OrV7zOSN69BBV+GexeWnYc66BgAkmgsXMp/vq/VY0emqVpm/yDrrrepI?=
 =?us-ascii?Q?cPZDj85m/jLhzIpKG5i0W2Xq8ucKUNr3DPzsxKdifxAAppGlgOvCJhaURe0M?=
 =?us-ascii?Q?76BF8j/hxv6faP89sLjajFnpavBjgKF9XYS/S5prhRn6BaXAs5UZ4XOup/4H?=
 =?us-ascii?Q?qkX6TT+00OkCqLLz29Ah+OdkKEZSJ8xcNa3sKl0Ykq9RNwCVT+H3AFHUxfcO?=
 =?us-ascii?Q?SNkPc5f06SXj+HFqo/4Hi+d5sBN1gppjfBCQLmQB7k3D21PqXQltPjs/o/tg?=
 =?us-ascii?Q?bGeTd+Pu3Vq8BnMQZumSJQVYFtA7pddHBPrTJK8Kf7M9yWNTikQxtcc4O5+R?=
 =?us-ascii?Q?Mmpznj8EZtLrJjPnwPfHaBZeI2l7fo6ax49iD+u1Z/Bb0nK/niaIU2/rwPLr?=
 =?us-ascii?Q?stNBlDsgl9MZC29O7jgob+j7Go1nzGAuvN2EmOfpE/caKzetQGB+BUBIR1Vw?=
 =?us-ascii?Q?/xL9oUtjpPXxaO5PkJg+jgTokCe7Ouk7/eDifjNQzfWNKrQwDI1gpFOsa9I8?=
 =?us-ascii?Q?T+QQv1tljiSRcm311LSmYuRBKN85SEHrqhmdpOpv+4Cv4UubBTjTJqdDLwXP?=
 =?us-ascii?Q?yOzvllSfrZReJY/VIOnCNf26z6wc3UjsZ0NCbhGC/nvWH/QkdEyZi1xn4qTG?=
 =?us-ascii?Q?pAeM8ohBh44xqNoqpOdp24yFZtt/JfhqB2pSAADCb9AWNNl06ZJsc4orwMIk?=
 =?us-ascii?Q?IB7+TAnCwf/gmIXbG4dNMIIxZNlowQgx9TvaDzWGjD2Dbq1jhdEbITmV16T+?=
 =?us-ascii?Q?8OW0rXqg9RZc+tx6aBA7xtodHpAiPo9X135S0FigwdRWYgbB6E8TvQdPiPHj?=
 =?us-ascii?Q?wkqwuPkSlovOI6liSDgXf2G817Gwv1S+bYQR/Eg2/XLZD/k1jl6GrAHZw9km?=
 =?us-ascii?Q?YAAWhIQHAabaC0SghoGafdMxkpDbthzPBpsGACZPDKf96gf+4TVPQ8FykCxO?=
 =?us-ascii?Q?UEo9bjVy6NargCvP2l5uvckV0ae58PYU1K2OiirMLoTvsk6xg5Qk6UkBwClK?=
 =?us-ascii?Q?1oxhUlj7A7pNnj3TTVlUUzADFDm/AMUSaqWL1g/G/9Xy7NDQ?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR12MB5420C1220169411AFF1864BFE0AE2PH0PR12MB5420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a346afe5-434d-4cf4-f091-08df03450726
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 07:38:31.7229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSqcJ6WfqkuK2tUEtH6rJyU+alymwYJZNUzOyzIiiURC6oeMMvPIXXtCka5WapPm/p6/ssfkfknjdOSMT4cwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

--_000_PH0PR12MB5420C1220169411AFF1864BFE0AE2PH0PR12MB5420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


@Deucher, Alexander<mailto:Alexander.Deucher@amd.com>  @Lazar, Lijo<mailto:=
Lijo.Lazar@amd.com>

Could you help review this patch?



Thanks

River


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g Mao (River)
Sent: Monday, August 24, 2026 2:40 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>; amd-gfx@lists.freede=
sktop.org
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU rese=
t



AMD General



@Deucher, Alexander Could you help review this patch?



Thanks

River



-----Original Message-----

From: YuanShang Mao (River) <YuanShang.Mao@amd.com<mailto:YuanShang.Mao@amd=
.com>>

Sent: Thursday, August 20, 2026 6:56 PM

To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com<mailto:YuanShang.Mao@amd.c=
om>>

Subject: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset



From: Yuansheng Mao <yuansmao@amd.com<mailto:yuansmao@amd.com>>



A full GPU reset reloads the MES firmware and wipes its queue table, but KF=
D keeps the queue objects with is_reset left false.

Pre-reset cleanup cannot fix this: it runs with the reset domain write lock=
 held, so remove_queue_mes() fails with -EIO and the cleanup loops bail out=
 early.



When the process later exits, process_termination_cpsch() sends REMOVE_QUEU=
E for doorbells MES no longer knows about. MES rejects them, remove_queue_m=
es_on_reset_option() mistakes the rejection for a hung queue and ends up in=
 kfd_hws_hang(), requesting another GPU reset. On SR-IOV that resets the wh=
ole card, so one injected hang costs two resets and disturbs the other VFs.



Observed on Navi32 SR-IOV with a compute workload running:



  ring sdma1 timeout, signaled seq=3D239, emitted seq=3D240

  GPU reset begin!. Source:  1

  Failed to evict queue 2

  GPU reset(1) succeeded!

  [ ~34s later, when the killed process is reaped ]

  failed to remove queue from MES, doorbell=3D0x1002

  MES might be in unrecoverable state, issue a GPU reset

  GPU reset begin!. Source:  3



remove_queue_mes_on_reset_option() already skips queues with is_reset set, =
but only the per-queue reset paths ever set it. Set it in kgd2kfd_post_rese=
t() as well. Suspend/resume is unaffected:

it goes through kgd2kfd_resume(), where queues are re-added to MES.



Signed-off-by: Yuansheng Mao <yuansmao@amd.com<mailto:yuansmao@amd.com>>

---

drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 +++++++++++++++++++++

1 file changed, 21 insertions(+)



diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c

index 586e640f13dc..d326e41a8656 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c

@@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)

        if (!kfd->init_complete)

                return 0;



+       /*

+        * The reset wiped the MES queue table. Mark the queues as reset so

+        * that teardown does not try to remove them from MES again.

+        */

+       if (kfd->shared_resources.enable_mes) {

+               for (i =3D 0; i < kfd->num_nodes; i++) {

+                       struct device_queue_manager *dqm =3D kfd->nodes[i]-=
>dqm;

+                       struct device_process_node *cur;

+                       struct qcm_process_device *qpd;

+                       struct queue *q;

+

+                       dqm_lock(dqm);

+                       list_for_each_entry(cur, &dqm->queues, list) {

+                               qpd =3D cur->qpd;

+                               list_for_each_entry(q, &qpd->queues_list, l=
ist)

+                                       q->properties.is_reset =3D true;

+                       }

+                       dqm_unlock(dqm);

+               }

+       }

+

        for (i =3D 0; i < kfd->num_nodes; i++) {

                ret =3D kfd_resume(kfd->nodes[i]);

                if (ret)

--

2.25.1



--_000_PH0PR12MB5420C1220169411AFF1864BFE0AE2PH0PR12MB5420namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><a id=3D"OWAAMBD399714DBB34B3B8A349DD2BAD818CD" h=
ref=3D"mailto:Alexander.Deucher@amd.com"><span style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;text-decoration:none">@Deucher, Alexander</span></a=
> &nbsp;<a id=3D"OWAAM7DBFBF255D864CA78D743A3ACA7C6A6D" href=3D"mailto:Lijo=
.Lazar@amd.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;t=
ext-decoration:none">@Lazar,
 Lijo</span></a><br>
<br>
Could you help review this patch?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks<o:p></o:p></p>
<p class=3D"MsoPlainText">River<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Yu=
anShang Mao (River)<br>
Sent: Monday, August 24, 2026 2:40 PM<br>
To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Zhang, Tiantian (Celine) &lt;Tiantian.Zhang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org<br>
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU rese=
t</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">AMD General<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">@Deucher, Alexander Could you help review this pa=
tch?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks<o:p></o:p></p>
<p class=3D"MsoPlainText">River<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: YuanShang Mao (River) &lt;<a href=3D"mailto=
:YuanShang.Mao@amd.com"><span style=3D"color:windowtext;text-decoration:non=
e">YuanShang.Mao@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: Thursday, August 20, 2026 6:56 PM<o:p></o:p=
></p>
<p class=3D"MsoPlainText">To: <a href=3D"mailto:amd-gfx@lists.freedesktop.o=
rg"><span style=3D"color:windowtext;text-decoration:none">amd-gfx@lists.fre=
edesktop.org</span></a><o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: YuanShang Mao (River) &lt;<a href=3D"mailto:Y=
uanShang.Mao@amd.com"><span style=3D"color:windowtext;text-decoration:none"=
>YuanShang.Mao@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Subject: [PATCH] drm/amdkfd: mark queues as reset=
 after a full GPU reset<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">From: Yuansheng Mao &lt;<a href=3D"mailto:yuansma=
o@amd.com"><span style=3D"color:windowtext;text-decoration:none">yuansmao@a=
md.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">A full GPU reset reloads the MES firmware and wip=
es its queue table, but KFD keeps the queue objects with is_reset left fals=
e.<o:p></o:p></p>
<p class=3D"MsoPlainText">Pre-reset cleanup cannot fix this: it runs with t=
he reset domain write lock held, so remove_queue_mes() fails with -EIO and =
the cleanup loops bail out early.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">When the process later exits, process_termination=
_cpsch() sends REMOVE_QUEUE for doorbells MES no longer knows about. MES re=
jects them, remove_queue_mes_on_reset_option() mistakes the rejection for a=
 hung queue and ends up in kfd_hws_hang(),
 requesting another GPU reset. On SR-IOV that resets the whole card, so one=
 injected hang costs two resets and disturbs the other VFs.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Observed on Navi32 SR-IOV with a compute workload=
 running:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp; ring sdma1 timeout, signaled seq=3D239, em=
itted seq=3D240<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; GPU reset begin!. Source:&nbsp; 1<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&nbsp; Failed to evict queue 2<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; GPU reset(1) succeeded!<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; [ ~34s later, when the killed process is r=
eaped ]<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; failed to remove queue from MES, doorbell=
=3D0x1002<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; MES might be in unrecoverable state, issue=
 a GPU reset<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; GPU reset begin!. Source:&nbsp; 3<o:p></o:=
p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">remove_queue_mes_on_reset_option() already skips =
queues with is_reset set, but only the per-queue reset paths ever set it. S=
et it in kgd2kfd_post_reset() as well. Suspend/resume is unaffected:<o:p></=
o:p></p>
<p class=3D"MsoPlainText">it goes through kgd2kfd_resume(), where queues ar=
e re-added to MES.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Yuansheng Mao &lt;<a href=3D"mailt=
o:yuansmao@amd.com"><span style=3D"color:windowtext;text-decoration:none">y=
uansmao@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 ++++=
+++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 21 insertions(+)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_devic=
e.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 586e640f13dc..d326e41a8656 100644<o:p></o:p=
></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p=
></o:p></p>
<p class=3D"MsoPlainText">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<o:p=
></o:p></p>
<p class=3D"MsoPlainText">@@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(str=
uct kfd_dev *kfd)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!k=
fd-&gt;init_complete)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:=
p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The=
 reset wiped the MES queue table. Mark the queues as reset so<o:p></o:p></p=
>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * tha=
t teardown does not try to remove them from MES again.<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:=
p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt=
;shared_resources.enable_mes) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; kfd-&gt;num_nodes=
; i++) {<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct device_queue_manager *dqm =3D kfd-&gt;nodes[i]-&gt;dqm;<o:=
p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct device_process_node *cur;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct qcm_process_device *qpd;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct queue *q;<o:p></o:p></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dqm_lock(dqm);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd =3D cur-&gt;q=
pd;<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_ent=
ry(q, &amp;qpd-&gt;queues_list, list)<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_reset =3D true;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dqm_unlock(dqm);<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoPlainText">+<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i=
 =3D 0; i &lt; kfd-&gt;num_nodes; i++) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfd_resume(kfd-&gt;nodes[=
i]);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.25.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_PH0PR12MB5420C1220169411AFF1864BFE0AE2PH0PR12MB5420namp_--
