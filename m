Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E321C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DA810E040;
	Wed,  5 Jun 2024 08:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0S9vOUL";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20EFD10E040
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Lf6tpG390PdphzUgCpZdq+B4mCtrtj/5C+tvwwULSlj7bABBViyTiJsL5ov8BfKWqirRq0Pb2OueMcuVh1NbZKyC7U5FFt2YcqC0/D/us9ZUxeLHEHC0i5m+8htorSr9XSzL9CtrPyzBmD7Al6kZgZRrERaHQ5PYfUTR5FCgC76KW27y0NoOSfUNKPsJZN3vkgdya1KI9iMBMH93t9TcWBLTVKpTloBB/88X8qRjQ+zqkrVgt5w3+nyjVU75yTix6GheB52KVPNABZ0m1I+jBrgHgwe4dYo3jjaq+4Ml/ip/1It878IQKmLGTYQ/Hhww1l9CV5m3MKweCn3JuWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPAcbunxe29ChhjW4MHI1slATmTNP0MaIGqwH/JOggE=;
 b=lNn9lbCkcPtJWNtzkee+O3wCQA2Zic84EccyvPDRi8xnufBnsnQXfWDE5A4Ojq4+Tqsa+7X5UymVo4VbBtwBxg93HK9Pfk0J1Msq+SRYWlDeHKO38JBx50I1wNbVupCiD9ed8tuJMAvLGgkqjqYoNqrATAQW+MAYkFg8ambljgX1gFCiXBO8eyv9g3qq3Va7NJGUT4c7EIcqDOqDZdpb8P1kZdNdWqOoHvN1kjP4cBPBcG7pqQvZt4Iuh9z9avTz0m6L78+T8dr5JdNCVN9yYqzHQyj1lmXEsKEuqUQc05bNb4hDOTysLs2GlHKf9TZtH+0d8EDNCnAM9rBgtA9MMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPAcbunxe29ChhjW4MHI1slATmTNP0MaIGqwH/JOggE=;
 b=f0S9vOULo9eNgakHJRzoDnH0s+GCRxdH9tgukCb4tl5t5ubGaIPKQGrWJYiOX6BBJYLcOKC3mEzsDOCBvGqilTBQkSzQDMvtazfZ8z3D8QHFUC+tqgxXV+pL6gjRx0NVAlvahchIJiZc4qq9TF0roCEz3uRYVMofRNFWo+chC2k=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 08:21:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:21:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: add ras fatal flag to distingush fatal
 error reset
Thread-Topic: [PATCH 5/5] drm/amdgpu: add ras fatal flag to distingush fatal
 error reset
Thread-Index: AQHas0hAfjvVt1shH065s90KzkHs2LG428aQ
Date: Wed, 5 Jun 2024 08:21:50 +0000
Message-ID: <BN9PR12MB5257309F2EAEDCA6504B2CAAFCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
 <20240531104911.14748-5-tao.zhou1@amd.com>
In-Reply-To: <20240531104911.14748-5-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e37831a8-d7fa-460d-b209-216ba549e974;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T08:20:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB8090:EE_
x-ms-office365-filtering-correlation-id: 25c26866-a8ef-4d0a-6da7-08dc85388c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?sjOZjene4RyVVIRoGirXDz58EgH07uxEyVbGX2l/FEhS1KIX4n+Du0X72iz3?=
 =?us-ascii?Q?OyCgijm3M5sn5weOwl90GM4DKsGDpAW4qdehMvLIffnRb4ALOvvhBKH7wrRP?=
 =?us-ascii?Q?NtQ8T3tM1laOsTtLe4C7s4o0xPld7mMh5nVH9dbD8OHaxCxYThjooPDSeQTz?=
 =?us-ascii?Q?IjZgejbL6SRwJ+lvUkCHi22efMFWqUHgcrnicXDQyRshzl1PS99Wbbf1EvkC?=
 =?us-ascii?Q?pQtwg34r5tS7Uwr/NvQDkpd69Jea32ldd5vXlBY3s1RNFt29u8Or0M33Rh/W?=
 =?us-ascii?Q?VT8cyUtXjIvezwNoJolW/XIK2m4F9tDxSMePT2nOpgkAENGsdG/L2ErW+qYY?=
 =?us-ascii?Q?65vbDylzijocJqnsfx4h9bM+dx5y2Wlo8H9tXloD1Jzwaokhnnp1qpqN12cx?=
 =?us-ascii?Q?4mvs5IEKJEvpkOpDgyenPPrjoWNkKHTh423NquhWD/Nys4eqm4Imj1C0tClJ?=
 =?us-ascii?Q?w/QkRKCXWWTGB3oB0FDCVCQcDcdNo6Ri0AOilucQC4wZWpaSFDyp8DWITQML?=
 =?us-ascii?Q?TAlMecne+iXvrpKAffOfe6PUx9qxDqPTydvFdwH7kzEuaqU0i1GoIde/QBFF?=
 =?us-ascii?Q?vWPb512ewnhayEx84OD1arC84gLe9XjIRmwYr4tMLzA8XjEqIOrAhD0yQixa?=
 =?us-ascii?Q?9cq3+yzsHOrRMxH2SmGaiR+/89tb/vwOdowyx8AJTrBhP8/2ij+5BEskxQZo?=
 =?us-ascii?Q?xJ8YiUvR9IiNf6BXEphCSi2yyrqpnUX4t4jVj05MYQMlIP91RYfiaGWHIrpI?=
 =?us-ascii?Q?H9JOvRHQeu8WRcXmSrx+mt9f+ZkfGFCPKv3wC8ar7IZ8KVCqnzwCV/xBHuIY?=
 =?us-ascii?Q?LFjSAiIzGTBCdGrOrlM/5xHH8OTgFlGr1KGNrcfxv/elVyOWBfuxJXpEOndV?=
 =?us-ascii?Q?UXZgfr3fPhhJOhkiSTQum1aq15JhPkjgUKV6L0akW7RrzKGUHXLd+EQCcI0Y?=
 =?us-ascii?Q?LC1a0/dPAnbq9p5PRsW3Fpgx/qdEZ+UKD1q6ZkqfoQyAnJRjDsvZIT8pvTlL?=
 =?us-ascii?Q?otW6tDCnkVsaRwfcDyTJVz+SCaqAQFyLoz7ryRUWzJ8z/hdNYwTdKNo6tGrY?=
 =?us-ascii?Q?0fROPayncr1EdoMaOEblShFcy2e1xac/oswMW/gnP05TSbiJbDgG1KkAGbY5?=
 =?us-ascii?Q?+OOi63rmb0c8k/YQeT/C/Qdg8CJdj6YixjpcFSDCZpdA7eilBBUAbhB0TxoC?=
 =?us-ascii?Q?emGkEpURnGsnpBzlPiX03AYlQv4FeET+fG/9Cb4jdy6uSuT61Urrdm7gGYZB?=
 =?us-ascii?Q?NxOT3xt4yPv7jwNrnnyWKDDsTfNkwhWJEIK0zM1sT6fFh+jbbU48QIuQgA65?=
 =?us-ascii?Q?CfJCsoYPjLjaBUSyU6F3XZS9e+Zsf0X0RWsAOSU7GIaQ+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyLxbAdjuMT5FjenZpH0pL1FSehiFWcmdtxX5HIQA39viqTMgI1kqZscn9Yb?=
 =?us-ascii?Q?Je52fvz7b+xw8rH/EYGR7wJyOFW5uu6BDe/7B3zcTmvsZHxB7I5bz4vC0rZe?=
 =?us-ascii?Q?W9foMbQK9adJ3ZLH1wtRjuuo4YI5fDyQMfYrXTCQCRSNXS+dJQNlGtnwjw/e?=
 =?us-ascii?Q?1ur5INdR9946KWVu8k6uR2TGeuZnziKZzuxauCLeJfH8Ih+o9pYSBKDMNXxi?=
 =?us-ascii?Q?wgb6j+quPJb/XDo0ZV4pWozmu37c+I/NVOiziKx8q/dkmXHY6VJ8bFs18GY0?=
 =?us-ascii?Q?QtvICoZ9yC5UnHS9DcxARdHj7GWuFVXiPDIkdSlDScnlA1Rd4W8HIkhtMJbQ?=
 =?us-ascii?Q?xqYFc4H7OgkzHFS0t3iLFYjGTp3mRSNijNxZBG0Sw6TKkEYha5oMLLr3eyrK?=
 =?us-ascii?Q?htKseNOOyZdJXJAgkc+uKkzyzyUqiNnQFtkewegVOWyz4Xl8bJT2P59ihUUY?=
 =?us-ascii?Q?EGfSWeRP8Xg2bFEqH/bz+5Syuj/9sx2BDUxyX8X1n7z4lmUkzVZvbuWtt1re?=
 =?us-ascii?Q?lulHMPjPMVnMLvMoT3DAcHaaNGRigoqqw2TRuNLFFea76gLa7xBEtiuK9qDY?=
 =?us-ascii?Q?n8TEglINEEQhzYT+PJqjSOGXLv38swn7sh4yFc4w1CFZ2MZF0+0e8xsSbUmB?=
 =?us-ascii?Q?vrFdXjmiPkJpbX6TCQ9I4ErZrvpCwO7TLfpVDwJ7M95Cvo0phlGZOvuVg3sb?=
 =?us-ascii?Q?cQwNfn0SgW8CXivdTOUPfvtsqJR1zkOBah+B7+td4uw88e5igX9PTPMch0br?=
 =?us-ascii?Q?7R8apir9liPLA7xjzM9k7Sn2Mgin9vzkQCr3jyzZsvHSb3A0ss8gPAb8GoRz?=
 =?us-ascii?Q?pqsp7Co+OCeqDxN9eTixa32L4IO4NSpW/yfZ9TsnUpAmA977Dq6WKhOtHF6i?=
 =?us-ascii?Q?pMV+TOYEh1horyVahYIupCmPmhD1WPvaKy92J/q1a3/5mXFU3WdmvopNlnL/?=
 =?us-ascii?Q?3n8wSiYWWjOPlUuvYrijh3ajXRoBefHB3CNbRk8oLzzAK/qI8Kqvv6qEmoDd?=
 =?us-ascii?Q?vckGITuOnWMpGymQgOC1b3VDEyF8lYeXv0k4nuIQloxPzncZler3CeoWCL80?=
 =?us-ascii?Q?HGOYSPTeKR3Y7bnEe5WMCGSHWQuE15WmM0IAaskx2ODBAvR4dj11Pjr5nGoE?=
 =?us-ascii?Q?VGf0C2PZibja1MAHisjeLvhkTg78X+an0y1YUbC2QdXxAgimkKQ4I25SXRf3?=
 =?us-ascii?Q?r/iwuuWC2r/4STdzgUwP87BvvIS1FnXrkSWXyYlQWAGdvuyU46Zdr0TJ/86W?=
 =?us-ascii?Q?8EHFztX4lgkqGR9WHL0JtNhQDTw8Jt1mis6N7cNbWJYdWp70qFVhRLkGjj8G?=
 =?us-ascii?Q?JQI4F4DMa+Xy2sW3dp29CLXzOpEnmViSgrqtwDN5yE5Hh/8tOQg42X/HVXkC?=
 =?us-ascii?Q?nsYyNtFs0hKJ2PWWFQpGZ2xIxL/zh2Du/Dmc6e7xkvEwTuq6DlQ6/MkExp2F?=
 =?us-ascii?Q?wdn1S3HUs6jfn7HGKvs8j8K9FWu1zCT2125IctKvwaBz3LYQgIUPuQTL2Gzq?=
 =?us-ascii?Q?EVk12svmh9QAvfA1TSVuiBqyBcANziBMCXqe4ZgsxB8VVDssgpU2uacllAMH?=
 =?us-ascii?Q?ZMzP5C3EYqfNJRx1ZDLKMNa3Gt5tQmpqxdGTzW8h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c26866-a8ef-4d0a-6da7-08dc85388c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:21:50.1752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWMLNQjfRReQmFfyU4vIGrpLMUgeFOlKmfNmEGec9p69NMlqVokOqnn5AqMnckmCV3QI9SgRh+lMh5lhejcpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, May 31, 2024 18:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add ras fatal flag to distingush fatal err=
or reset

Check it in mode1 reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 32 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |  1 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_6_ppt.c  |  2 +-
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 2071e30d7e56..97b770ba6424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2451,6 +2451,26 @@ bool amdgpu_ras_in_recovery(struct amdgpu_device *ad=
ev)
        return false;
 }

+bool amdgpu_ras_in_fatal(struct amdgpu_device *adev) {
+       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       int hive_ras_fatal =3D 0;
+
+       if (!amdgpu_ras_in_recovery(adev))
+               return false;
+
+       if (hive) {
+               hive_ras_fatal =3D atomic_read(&hive->ras_fatal);
+               amdgpu_put_xgmi_hive(hive);
+       }
+
+       if (ras && (atomic_read(&ras->in_fatal) || hive_ras_fatal))
+               return true;
+
+       return false;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)  {
        struct amdgpu_ras *ras =3D
@@ -2462,6 +2482,8 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)

        if (hive) {
                atomic_set(&hive->ras_recovery, 1);
+               if (atomic_read(&ras->in_fatal))
+                       atomic_set(&hive->ras_fatal, 1);

                /* If any device which is part of the hive received RAS fat=
al
                 * error interrupt, set fatal error status on all. This @@ =
-2526,8 +2548,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *=
work)
                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
        }
        atomic_set(&ras->in_recovery, 0);
+       atomic_set(&ras->in_fatal, 0);
        if (hive) {
                atomic_set(&hive->ras_recovery, 0);
+               atomic_set(&hive->ras_fatal, 0);
                amdgpu_put_xgmi_hive(hive);
        }
 }
@@ -2982,6 +3006,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *ad=
ev)
        mutex_init(&con->recovery_lock);
        INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
        atomic_set(&con->in_recovery, 0);
+       atomic_set(&con->in_fatal, 0);
        con->eeprom_control.bad_channel_bitmap =3D 0;

        max_eeprom_records_count =3D amdgpu_ras_eeprom_max_record_count(&co=
n->eeprom_control);
@@ -4006,8 +4031,13 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,=
 bool fatal)
                ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
        }

-       if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
+       if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0) {
+               if (fatal)
+                       atomic_set(&ras->in_fatal, 1);
+
                amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras-=
>recovery_work);
+       }
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index ed5793458a70..444a7fb7fbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -489,6 +489,7 @@ struct amdgpu_ras {
        /* gpu recovery */
        struct work_struct recovery_work;
        atomic_t in_recovery;
+       atomic_t in_fatal;
        struct amdgpu_device *adev;
        /* error handler data */
        struct ras_err_handler_data *eh_data;
@@ -953,6 +954,7 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *ade=
v,
                pasid_notify pasid_fn, void *data, uint32_t reset);

 bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);
+bool amdgpu_ras_in_fatal(struct amdgpu_device *adev);

 __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id, =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index a3bfc16de6d4..a6d6272a4ec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -44,6 +44,7 @@ struct amdgpu_hive_info {

        struct amdgpu_reset_domain *reset_domain;
        atomic_t ras_recovery;
+       atomic_t ras_fatal;
        struct ras_event_manager event_mgr;
 };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 04533f99f1e3..a850e7b29d9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1876,7 +1876,7 @@ static int aldebaran_mode1_reset(struct smu_context *=
smu)
                /* fatal error triggered by ras, PMFW supports the flag
                   from 68.44.0 */
                if ((smu->smc_fw_version >=3D 0x00442c00) &&
-                   amdgpu_ras_in_recovery(adev))
+                   amdgpu_ras_in_fatal(adev))
                        fatal_err =3D 1;

                param |=3D (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d1766a603bb9..d6c6c9a08e9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2788,7 +2788,7 @@ static void smu_v13_0_0_set_mode1_reset_param(struct =
smu_context *smu,
        struct amdgpu_device *adev =3D smu->adev;

        if ((smu->smc_fw_version >=3D supported_version) &&
-           amdgpu_ras_in_recovery(adev))
+           amdgpu_ras_in_fatal(adev))
                /* Set RAS fatal error reset flag */
                *param =3D 1 << 16;
        else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c1d7528a6dc8..4434872bbe2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2580,7 +2580,7 @@ static int smu_v13_0_6_mode1_reset(struct smu_context=
 *smu)
        param =3D SMU_RESET_MODE_1;

        /* fatal error triggered by ras, PMFW supports the flag */
-       if (amdgpu_ras_in_recovery(adev))
+       if (amdgpu_ras_in_fatal(adev))
                fatal_err =3D 1;

        param |=3D (fatal_err << 16);
--
2.34.1

