Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303EFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 10:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C960910E028;
	Mon, 21 Mar 2022 10:50:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8980310E028
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 10:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkFCavpQzTrbPXy2Lg4iOucBesRRmeDb3/a1kkiwB6U0kqQdnPN9yRsWWnp6oiAhSydZXglRgyl+c4T59zzgVpzU9KlWYr6dqEhBXwacpk52lTFt4nwqq4AF9xbp7aJyNntqu1mgdC9Y3VeCxpzvuLO0eSAzapkgqqA+RVKFjy6Y3OTy6w30uv6I2FwG2XyLJzXFiDW9hqrOALKMqDpxFTpQkTd3RWusJbvF+cLyhW7gMOIQmuw2M01l7sGT9b5hX+vJvOq+VFyZUl01e8LDehcsZGWFJwRL9OVskJp+0V1cgi8b4oPr4kkshTzb5Mj1sL2JWU7lUX7Tlsk663Sa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWVT5EKg68O4YESxrhVyu6aH35iOQZFwHWXRGP7G7F0=;
 b=LL3uwVznnhGo1rfNbsXFX26LxYPPhm7PA/I2RjaDVSXXigJ0sC7CqCF19TeebRLcB1KyvOwd6FJ62RiKQungpNzBoMGbFsv/r7SBSGrpU7A/WVJsA6SioC+oBcAArVJyJcbshxD1RAu1JzKaP6NQYGq/snvfGkJcRz5nFmwYFBkkteadmXfqjqtNRrC2JwAkRirzhiPQtfB9UkEUR8ThHdmgGBl5kyAc3lJWVCVsTGXtpU1Kb5L5FL82Vku1auLyW/NLbbgwC4FsOkDjssGyHwUKowc6rD4AsetGsKcIHgltmPZyi3QAaGriR/Ljofe7J919qFLDVxBil4wj2LKEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWVT5EKg68O4YESxrhVyu6aH35iOQZFwHWXRGP7G7F0=;
 b=YyCRM6t8VCrCIqCVcv7Q/cZHk0Fen0zMtOunzCRZiXl6aXFNETtBqmcsMF/cqfP69rSsXiv1wmB3WVf33vPnGu7yleBCgd5jJGoxNA5pw2gCMab0Noxba9+Qq/XzXdEWldOMnOyPUE6fhj/7aLQDwfjn5lwG4QZHC7/zrZsuoLU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Mon, 21 Mar
 2022 10:50:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 10:50:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Topic: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Index: AQHYPQdurtrmw3iN40e5+e/vweI3TqzJqNDg
Date: Mon, 21 Mar 2022 10:50:37 +0000
Message-ID: <BN9PR12MB52576F13B94D3960E4EF1056FC169@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220321093818.24270-1-tao.zhou1@amd.com>
In-Reply-To: <20220321093818.24270-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=daaaeb29-d34b-4bb5-b7c2-d42da72eb5ee;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-21T10:50:10Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 452cf486-0eaf-4d38-02e8-08da0b28a270
x-ms-traffictypediagnostic: DM6PR12MB4580:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4580A606B9D45228CE0C4B1DFC169@DM6PR12MB4580.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfrfPGqqrp40cQkQt311Cje76S6iLy50wyfY0yzWnqAoXUKdzbFk8CZP84mmdG4m6O5c7iobOTx5dFJ6Gip9PTeLO2jhA/zuNP37VmHi/a8lR/NSQ6xLfU9xsGztnHoPpVKpvcLqLsLv3nIDm0lzp96s+zHzIwMTkP6e7Nm2Drgn2P9biUuQcai0T/Rqopn46hVGoDGofOUd/cIUicVPp4vtow6EXVdtpcr5W6LSxse3LjKwq8wpOkDkYLxI2Y2HRU2sW0BYEhok3TelRx2mm393FQH7nJp0k0m4N7J3c19CTDkHmPeOYOjjeU3GsOraBQziDs6ZAxd9EFJY1KyPh4L9ZPMsPiNSYtALK+6IwPt4P0SV6qgPG1CjKFyTdYU8O2bAkUIg+6q1KRJaC1aywhb/1a4FEEzZfbhiv7FVe1Cpzclt2aYzG++6JNqJAUyG7HkQ58xHBVQBVrlDyvT5DsQfVFKziqZWHufs/mWNLhLA479/iVTUWHUGT48tWLLdY85iZaueQXW4G6Hvny2iHZ2dSQ6PhgkAai0A+s8ilY4CVndydhONVPzmxK+eGv24Uk71XeyjJqBKYDCOz+sKn0dqQEapPT0RVEUA2Xm92Z6TwR6SZWk6J9xiGW9vSGte5YZGTdEXVIHOXzGUIV2o0norTsg/OfY0Q20Mzhs5ZtQeEofpDA6PbTbbaQ6c/1Kci9m3+EHXlAA/FYL4OqE7sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38070700005)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(316002)(122000001)(9686003)(110136005)(26005)(6636002)(186003)(6506007)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(53546011)(7696005)(508600001)(55016003)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GvUOxgM1mMnzu51KgVrSFYE3ckvWcEiDSWV5BQ2qqHvQz0vgqhHgUr+4mE0O?=
 =?us-ascii?Q?O2r4UMNN29eEomScWK20ZCglxGn4Qta1h1wOVaPciLFF3qGI+Cf7DPxVEgmN?=
 =?us-ascii?Q?uh2WZ60dYuOqiuIZzW42Kc13Ed/kK/cmr3tdjKQZ8Mu86yonHRKhBtGwB0rU?=
 =?us-ascii?Q?VtDAFb6pqnOfEHzyfn9rsgknXaZLLJvkgkpmFFRQaLbcM+WTBJjncGR7c/Zh?=
 =?us-ascii?Q?C7lCeu40yAt5AiCJqO4cDejXs3yAivbHXW3z0c6t188J4orqFBxX9XmPjA48?=
 =?us-ascii?Q?/gcylF7mtupHVDnb1vzEUllLeZ6fhdZg0Ug8mHE3kc3+axhxtYXNRNAfcFU2?=
 =?us-ascii?Q?/k/ysvgy+7hhXSuz8Pl/nNzYe2RvkHOZvmCVvmb+6ZKffMwXK8OXg/B9r9zw?=
 =?us-ascii?Q?P3yS+RPghDYvkLS6ynqvMNjgj/Nw3LkUM4QqBeYOnq4nnUYSHf7ZUUc11a20?=
 =?us-ascii?Q?x8XwRahcyxqYpV7nQaE0mpfQyOx3jyQZ2/xHXE6o67hVwJZyOWNiMvzpdrGs?=
 =?us-ascii?Q?W/RgwsGh1KIwSNAIAPUXTVk7syW/Kza0mrnFzploxt6bmypbyGjCogVWkjD3?=
 =?us-ascii?Q?BoH5eOdrrWixSgk8scWpoWTM+fIWYuoArY+JZZgYyQ3ypb24acdVCyCPFhT+?=
 =?us-ascii?Q?M68RuWyvgo+sQ201jBwJbCv6m+fFyeXJjkPGv2i3tnTKdMq+AE3G4Le3fpkL?=
 =?us-ascii?Q?w8K6C7c1tp3VcsK2Hq8vWs8Ey34Xy3uKmsk1QXGtvESQOVl+nfNEbxsXFKNP?=
 =?us-ascii?Q?1y8H8T1LRfoXQONUBooPOdQTMvRajpVOy5sJKxyLj6yBlPrRI+CR+4e7bsbA?=
 =?us-ascii?Q?o+veJGv1md7IP+H2i9HkJ3WzEqmp0dtubRm+Jw2hJfvdQSqL+5sFDVoGFWPP?=
 =?us-ascii?Q?fQBnSU1MuUkL3XVs6FtNxvvqq0icZ2mYIFmysKhcNMFqkoOl2mNNcAJmAjS/?=
 =?us-ascii?Q?Z0Ix77S2cvT53YwZSXwbob+/iLYm6Fp3u9ZifOWAEXgoULACEypUhUzEqBn5?=
 =?us-ascii?Q?Dnumy9iI9RIP+H6JmQdIe+E++2KN5tmNzGbB4nS8UFbtkRiJbgJ7Pv2Bi8mR?=
 =?us-ascii?Q?UPZjoRnTMFe9n9pO2OPEvvpymdX1RRPs3DgrwnNYNPu+ZS3Imnp2md4qDHM1?=
 =?us-ascii?Q?4sFbP4ZdbhpglWZIolxlhkbT3AQ/V73ETm3ZAxq/udZcrJktFgfU2Vhwe2K1?=
 =?us-ascii?Q?iJ/zeBsDd1se3EPsnhT0ZkhvxmZoeot0ZiDxw/WaakRRLvUsl+ZlPd+bTX/1?=
 =?us-ascii?Q?LLZUhVabGl0Zv3TNuLnRnb+XGHBWe+DdPlM31RzdycvK9PlasSpdqKJp9SAo?=
 =?us-ascii?Q?kBqq39XP26rPuNf4y/QNKzENqPCrjeIjqT8LUQ/rz9rw1BfJx1o2vrZzqhj7?=
 =?us-ascii?Q?ftruKu5E+070jaw8eb20JJjgV7e7C3VDjFuwZSL7f9QImG/itOBTmNayzWJx?=
 =?us-ascii?Q?rcw6LtDgECGgK9ax+ivMGQN42Up8zXTd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452cf486-0eaf-4d38-02e8-08da0b28a270
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 10:50:37.6631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWx3SJgygkShWLjFKezXOXm6vw9/fUf4DIbiobSfFQCKJqaiACt33VSH8ktP2vV6YeYgk0PYOLoDLEDQQ+8GOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, March 21, 2022 17:38
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison consum=
ption (v2)

Print the status out when it passes, and also tell user gpu reset is trigge=
red when we fallback to legacy way.

v2: make the message more explicitly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..32c451f21db7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct k=
fd_dev *dev,
        if (old_poison)
                return;

-       pr_warn("RAS poison consumption handling: client id %d\n", client_i=
d);
-
        switch (client_id) {
        case SOC15_IH_CLIENTID_SE0SH:
        case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,15 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret)
+       if (!ret) {
+               pr_warn("RAS poison consumption, unmap queue flow succeeds:=
 client id %d\n",
+                               client_id);
                amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
-       else
+       } else {
+               pr_warn("RAS poison consumption, fallback to gpu reset flow=
: client id %d\n",
+                               client_id);
                amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e);
+       }
 }

 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
--
2.35.1

