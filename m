Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 02:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0247510E20B;
	Wed,  9 Mar 2022 02:18:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDA210E20B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 02:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp0EgXQmmxhbEN2WCibONmUTGlR+IxS1l0iNYg2uSJNCk0ahLvFh4Roox7Db+r3CuiruZnfQPE8vp5NAyWptUYcq7h1ZWNyJgLQqghLOtnJ/lQ1Y8ANHHP8bofOX9/rxdSWaPI5p+Q7DCyYd10OVUPyH0SLksbEQsMLhF/2pidrmuwPLioxjwMVyvyjrkBG7zErR9OgBqkvJ84CU0FuiClkVp42JepfFre4LeOxXADQFfy49tnICOPwqAPzREvwiJPn9nm5r29fXhIiwYLx83HVYPO4Xsgqvva7qhtUsP0v71NoLncLRQzX2H3LXxHU2g3VFznOv4q3csowwQTnshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWhefV+k4gpeq7qW4P7TQ5vnjisUCkZABRj+0Ae5DK4=;
 b=DrfRuwQBs2wdw9+3ACh6tMP+A1VYB81ktkvvjtWLV5BY06BnReCegMUMhkPZrEqxB3taHrhsHozE5+4xf5L/kJF3V2mZP8YR4YVBa3rNmG7mD1ayzPhJRrUDhVBs1kZziILrvJeZyxmSYxTFZAYXkPPWij0hDVyELUEFsp4obmQ5TbjyBHBRs2RektPvQrcJZMfT0YSFkbTkP8L9F2M0U5SLzh74/eNANBaqKyUqqzkWdPTOKfW6RbOIVhzHwgiES9mAOoACXvm7oEVR6UNbUQa4rP16JbrWBytL18mqE2QvrGZnUpWitf0wQvl20GwDF3ZxeAGAta0hBcD/gpzFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWhefV+k4gpeq7qW4P7TQ5vnjisUCkZABRj+0Ae5DK4=;
 b=fRV8S/F45mw8c1JDPHPPvgfUCzgzaUxuq2VYTJ0qSNK98ZY1sp8sT7LUjaOdyTZptFGXG9d9olISDQJEAm+CvynXwAzpEERHEItZ7JIn4gGYBpxUqPfHe3NXjI69DsLuy7d4g88n+cvkR8KpHqF++PmQvxoGiI+2ywUWKve09H8=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by MWHPR1201MB2477.namprd12.prod.outlook.com (2603:10b6:300:e6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 02:18:30 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::a835:e834:a28c:b9b8]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::a835:e834:a28c:b9b8%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 02:18:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Thread-Topic: [PATCH] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Thread-Index: AQHYM1rTpIgM+folxEynVXTnRUUP2qy2URrA
Date: Wed, 9 Mar 2022 02:18:29 +0000
Message-ID: <BL0PR12MB24656CEEC72BD20AFD73DE96F10A9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220309020937.2625238-1-yifan1.zhang@amd.com>
In-Reply-To: <20220309020937.2625238-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f7140c0-d2ab-4d2e-fe6e-08da01731a44
x-ms-traffictypediagnostic: MWHPR1201MB2477:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB2477E1F56A5B62E58AF9D6E1F10A9@MWHPR1201MB2477.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akBZEb0ahD3RDtjU7SO0E6QiQeNDGLzCI7PwsOOXW1aoBFp6/8CH6lDTo+qa/LvYGD5g0/REmcUv8pXY969WteTv7FCTaVMYkG3wmwxS5j0SJzHjOdt76b8iIJU7hu+eHgB9fXG88gEbjFesDo1UmFd7WSpMq37npo/+as4zBxd6HGUidtuz6a3s9YTYJtPf8klTHK2BruA3fJPLJ0S+lkmSwqNmCk4EOWFaiZCJomiD6E/8j//Ktio3hDjpAaI4r7QR/bbuRrih5/8BJ6UV87nJUH536SCdYEkkV8JaoupNvDrGOQxDLZhBywxEjFnbdZoQS0JvXhNV/ileic4UPl1UoF1i3yB8aFFsv8ETiZnBPjtEutKX2ZC3ALeD5I4Yifj0992kzGNKYb/nx+PyhgHCi/vgrOahEjGNkdHSaA0HSB9ScHPx7SYKxSIDkulLhEf01GqcXa7VEjRlbPB6Ex131w3xS/rdjaz38vfSyabYBroA6B891a0vCn1B9aBmXEXmGPgUOcndz4x9gOPkxuOWeVcj0N15rUvF7d5lS9WuCJOrP8j8fFIMxIuGfDS7WWPQOUCjnKvaiqvsZE6G6fKRNQGCvRN6h5f66XW62OgIA9UxhVOY1uaCyZ4IArAnDee16nQk17n4IQj50mUjr3YUOU1LR1k2M++SKH+6FRJcZppMGAgzX5zpF4bv2r5iRnjFTagYYqsXX7R50QJ5MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(9686003)(54906003)(71200400001)(316002)(33656002)(26005)(186003)(508600001)(6506007)(7696005)(83380400001)(2906002)(8936002)(55016003)(5660300002)(122000001)(64756008)(66476007)(66556008)(66446008)(8676002)(76116006)(4326008)(66946007)(52536014)(86362001)(53546011)(110136005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5dD3Vbxfa9Gl1Jw8nqGZhvXG+Xk/ShmaqzDK+3XJ/k2Q7l1wG/5fY7CdfXMc?=
 =?us-ascii?Q?bK2HNDhUhpbuPjL8LSiQ0/EX2iQhx26wbpYcMq+/30WxWngtbnUZ9PIgR+tD?=
 =?us-ascii?Q?H9XVdUod/kmPSVKEvdYuu4vHx7RxAcW2aceWHZgsmbncDojRXGWcZqOdlOWM?=
 =?us-ascii?Q?8zbQ1QvAJXjeZtthBLANNXzx/ou5dxSQ6Xb+5R6Cy41cgqA84lVYObdhehOP?=
 =?us-ascii?Q?xqgoi5f3T+E0214z0EZeD6/YkRPbcPpg8MlppAazK2fhNMswuk54YyS29b8z?=
 =?us-ascii?Q?+A4ayNsBBWqtA8wOfcYC1dLAjlLQWOur0xCXpFyCx+Y4CJm3KO0Mi+iS9zYD?=
 =?us-ascii?Q?hwpciOOUqSqcRWCNYpyyOoTpvPkzt7wCBMi9tPBZOF+f4GAcR09JM9CAgId4?=
 =?us-ascii?Q?+9QI8zmfRwqYlB156TniVpOyXlu2oNI1Iqfn8zmNqeeShn//b7Qmk/QsrEZQ?=
 =?us-ascii?Q?0ZPd5g6pkZopjNEySxtuDCqCRREizxpmmPx8uuoOgNZL3In9HRpiJKgDWaOu?=
 =?us-ascii?Q?+kD9llqzHAvhkQGbcKqrwgyJeB9aOrXcLodoE4PzsO9Xv1M1u0AR9B+M75Nn?=
 =?us-ascii?Q?vWXTvfMT/ZVdXLD4Jd8axIMzSgB4QS8Pj7S5XUaIg6FmBdVel6iBqcMkpGHz?=
 =?us-ascii?Q?yfPv/t2bbYULL/G3BnzTgwE+zYE0zQwDm1jRTe4ooIHsy4/w19aBv7iq1RYI?=
 =?us-ascii?Q?4m/9aQzCnhNbPZz95Y8WGh7ToiwxPRRwopncYETT4Ce4agCvGpBZGp6KooyE?=
 =?us-ascii?Q?o/xIV/rcRLxNt8dKUP6dMjEzUujuB6y+vRrAX5+BW2bUetKOj+mzqjk5OkMg?=
 =?us-ascii?Q?OtBRL1X+HAL/ul+8szhfPg75eetiycQVsi4OCXT4GsO29/JKyO9RRyYpKG5Q?=
 =?us-ascii?Q?I06kU1/YjEr6TaObX9eXuhnjaDDIsAhHSR0q1GQj6eKIeXPpqOU4kPzPKV9u?=
 =?us-ascii?Q?VXupLYB6suc0E9999CbG4D6cmwhRzvJ22mKCVDCylJJDgP6U2vni90OgzTDx?=
 =?us-ascii?Q?uNcUdEjzvYePcS4Sp9iK/hWgXWt/098FYoU1ixlN/OtERVyiS7iuENBDK7zK?=
 =?us-ascii?Q?mGrgoQnDXN574J8moMh+muyDr9AthkS0mTodgodCFFwiW4dtIzsjNbYmLPT0?=
 =?us-ascii?Q?fu2mNJUar7t62P8l2Z+nbwkXkIFYPelkLdpYuiWj7DbZSTWzFUP/RR1HYxjS?=
 =?us-ascii?Q?g9dSB9bFB8asgq6pxXu3AiTIfZrQAX39eN2jciXMKOgPfFHQtSPip51d5aa4?=
 =?us-ascii?Q?EkcEGFREvr1m8OtT/zb72QcionoY5HmnXpsgDxiPP9oU2CJLd95wR8ZHZYWt?=
 =?us-ascii?Q?aVcNrohU1Djb/XNblXxGwVaOV8R8bHpJb9vCjs79djz5jnbrJ3EqvXf56At8?=
 =?us-ascii?Q?vtJ2nRnCe0NizlMqdVs8wJ5RwDDRf3nqVN6wRpmLeulnOeu1rtAXLqw8xcgL?=
 =?us-ascii?Q?xsc+fOEXZfPCEpekAmoNitj1HEG4dJ6g7rfi1wf6+pn+MPX7PmkqufGmAJKy?=
 =?us-ascii?Q?BcBICZCY0HALDXcGTxxzOVyWGI++anbWPjGTLs8SU7UGTfm3YXGMdwMqL9IE?=
 =?us-ascii?Q?EHpX717jgXg5B0IvPrmkfzX33E7pqk/7M4Nhu6u26TayuC0N1skE9SG0QP2h?=
 =?us-ascii?Q?maOIzjdTCm6WI/66f5KinLM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7140c0-d2ab-4d2e-fe6e-08da01731a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 02:18:29.7911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8Yj+eHxiXUhP8vfjOTuGTS6kFtXmQtInoRhg4YL4QaybWGZZ1ptPyOAPNUFdZlF0cvPDssZvhSCcgicITCIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
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
Cc: "nathan@kernel.org" <nathan@kernel.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think you need to add a "Fixes" tag in this patch.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Wednesday, March 9, 2022 10:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: nathan@kernel.org; Zhang, Yifan <Yifan1.Zhang@amd.com>; Kuehling, Felix=
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amkfd: bail out early if no get_atc_vmid_pasid_mapping=
_info

it makes no sense to continue with an undefined vmid.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 77364afdc606..acf4f7975850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -500,21 +500,24 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_de=
v *dev, struct kfd_process
=20
 	pr_debug("Killing all process wavefronts\n");
=20
+	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
+		pr_err("no vmid pasid mapping supported \n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
 	 * ATC_VMID15_PASID_MAPPING
 	 * to check which VMID the current process is mapped to.
 	 */
=20
-	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
-		for (vmid =3D first_vmid_to_scan; vmid <=3D last_vmid_to_scan; vmid++) {
-			status =3D dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
-					(dev->adev, vmid, &queried_pasid);
+	for (vmid =3D first_vmid_to_scan; vmid <=3D last_vmid_to_scan; vmid++) {
+		status =3D dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
+				(dev->adev, vmid, &queried_pasid);
=20
-			if (status && queried_pasid =3D=3D p->pasid) {
-				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
-						vmid, p->pasid);
-				break;
-			}
+		if (status && queried_pasid =3D=3D p->pasid) {
+			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
+					vmid, p->pasid);
+			break;
 		}
 	}
=20
--=20
2.25.1

