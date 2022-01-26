Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2BC28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 06:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E4D10E53B;
	Wed, 26 Jan 2022 06:26:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51B310E53B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 06:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIu/PYelHMg0513vrZzM/zeeiFh7zHjb7OCjdm1xHKlld8wyab6v7I6jY1ASYJTl/EYtXJo7aL9MKhIaDokjLvt+CKrxjZtMDskiR/SVvSyILTkH8g/qZ9kYDcd6CFVTxvamr79bXcr0Qo5YzNyfRXVjupRMGKIRggSOsxkgE2m0vx9DH+xR8GTFvEPawX6hH3sEaPGtPG2egahPyItkKvdffQb+p7nPy9v2alCem69firv0+F3tRiwiY+TMz8IkKRcBlkfBNvNgjYGlE3aMB+0CIBDphG9dfZy7XMsdoYGzmhtABHl/ck1W65gApxKasTZ6rbWv68C3udcRjq9SkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYKKCFkGSh48fyvz4PCQYKDixRLg8WY81ZBmtUMzVD0=;
 b=FRb7vzws2VJu9+q+OJHGkAT83/a3qfXL6i47K7p79ARGF9vZ2ytzFl0fS6gWS6YI4uELnWWg4E35arJCZ8kpX3DjiNLUuKisdASpT5dIskTmE7t+aarlau9TzhGa9vjB92OD2Ih2u6nszjIugz6N98zm7g6c5fH+TCMLZIL8jFk8pXOC5PnJOkGi4OVpKXjTmkKrGXtvGeXAOCNll7n8BSRf9/mEJN5c98o2rFbX42fkLdclzfw55+m7Q/WP6OUAFXTvpzCSHt62DsHxb2H0kPPciRTNvdmhYLGXKcqg3Gif5ocySf9OHzAXs8576yVYTlTVAk1/LlA+Bq24Ztbnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYKKCFkGSh48fyvz4PCQYKDixRLg8WY81ZBmtUMzVD0=;
 b=fk6h7M4Oq7SUdFh8yH9sL1TObdEQwkhzI0/3t7lUFjRTkcrSSUnXQBe+nbHTBSRdsLjS4S4RNZukwBB+Qp/aXSZ/9rSABCjjWpkkVWBbae0Hxd4MJvSEKJTewAfzfvgTKpEFnucCx2xfQIqrIsGixlEiJKFwlBP9yeFNZah8tUk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Wed, 26 Jan 2022 06:26:34 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 06:26:33 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Don't take process mutex for svm ioctls
Thread-Topic: [PATCH 1/1] drm/amdkfd: Don't take process mutex for svm ioctls
Thread-Index: AQHYEhYQYVlR7MU56kK9R/ERw/OL46x01qUA
Date: Wed, 26 Jan 2022 06:26:33 +0000
Message-ID: <DM5PR12MB24691B2DF9502069ECD115BDF1209@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220125180420.3022-1-Philip.Yang@amd.com>
In-Reply-To: <20220125180420.3022-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T06:24:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=25365b02-aa35-409b-9ecc-ad6aabfaee84;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-26T06:26:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: de4844a7-444d-4d94-80d6-8d7a949b2a48
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cd45880-a760-4b62-375c-08d9e094cc63
x-ms-traffictypediagnostic: DM6PR12MB4896:EE_
x-microsoft-antispam-prvs: <DM6PR12MB48962488B1EAA533B588195FF1209@DM6PR12MB4896.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pbu39J2pZL30Gu99Su4HNDYuYoPOW91piFpOXQxEL7IJ8I5NE6J7GywkaCx10ErN86iVYwEIxt55Uq52il2n6accvq7OpJfcbuWqzb/shlG05lZguGaIYEatrSdch4+S2kcoEymYpmAL4hCJtb9zOs5shLrKwCowmCowK6qCJDPhBKEgBQXdCkScHTNubZjM4AYexeFRWazZRrsj8WCe/4tVNHAeyIVyvJysjCJbsIzdHnAqf5S5J5eZ7sBeOU2Hujdc5Y8jmz1soRZm7vNEiQOGyrbTiCMIArhwLXnbvwGBzf+OZUAh/hpcNBUKQLMlZ1vXKYTKfQxdXG60ZE8Rx2SKfninQMriDCZVt1xbx4DbZAD59krLDex94hC9ivWBOImZoWWwrlxI+6+CJJHbeCbUXDUYOHberIvY7+M3TSL/7sOPaM4h5AssL+ZFmIstxFpZoVd5A9HqdF49jcL9fb70hHBVeJ6IJV2WqhpCmNgn60Tg42Woc4w9Ffr1NpEcR0gG8M9GdEgeSodv6dFJLd4ezihWueigSexev2ybyzY1dkSSZK8tvBv7aSf8iwhUTUUPafH0oTEFAT4MTuUQfWumImCdwa7wc9lOQSCHMpmUvKANObfd0vGV3syKdmCHmgtYeWOajt3L92zc8eXzYMnOS9bUBn3NnQRu0RWqvIsvHCSPgZI8anGfj42EKJ4qYkigv5AyDzbshAoW7Ys9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(9686003)(76116006)(66556008)(2906002)(66946007)(7696005)(6506007)(508600001)(53546011)(71200400001)(55016003)(5660300002)(26005)(38070700005)(33656002)(110136005)(54906003)(316002)(66476007)(66446008)(64756008)(83380400001)(4326008)(8936002)(8676002)(38100700002)(186003)(122000001)(86362001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XkTTtSPNul/deNkINq/zzQscLTHSzKoAMnGX+CngGyf2i16/dTQHbS8X+Ap4?=
 =?us-ascii?Q?S0UZEpz2bnGtxYJSuyl/iDAfikfPhnzb31kfYd05HEpcbFMFZB7nA+ufffjM?=
 =?us-ascii?Q?ebmDpuy9wKWd7/tsGKoEkKLRnYojWiB1VX3hRddBilwr1qKTcNUkHjn5I3f6?=
 =?us-ascii?Q?bu76Uwz5AkPDuCZXupbAI11lP6+Luzrz9Uf2MrIt6Ac60nIIt05ge+HMivik?=
 =?us-ascii?Q?1aIsG/pHiEq0ZuwvZrXI/HBjkHS4Hp1WjmdSxlREkaFKtsMD/yirGwlVYQjG?=
 =?us-ascii?Q?+ygIHbiArNM2zvGM9hBbm0iN56J4b3nyUBxVC5AppefVJ6SMZ2swoGQPidmp?=
 =?us-ascii?Q?ZXM0m7kjb16xdC14Ry3g0mzXJZcm+nzz+c9Fwbl1fsB8M9Hkw7ZhL0ZgSoi0?=
 =?us-ascii?Q?C2TeOVcPEjTIFOe5F3G3cFWyFrUmE/aRdbxwPeEtDHRLUCcAGp+WtAdTOewW?=
 =?us-ascii?Q?bM3UV+UefULoVF395ihk5yQ/pirN7tDOsNy+EJCd49XSUmXC0PrlzFD2+T/c?=
 =?us-ascii?Q?7tFPgtdvLUA9YhbavgK7+Odfu7liGcms+sMWG2lddMMtibGlCLRBVSITxdZ1?=
 =?us-ascii?Q?gswIbH8rmlgMTmffrZYn9WcARHoYKKHt1L1sjKVT+gqy3ApDqA6pbijwqi3B?=
 =?us-ascii?Q?s6InmXL70WP5X/MKFr5lDa3UFOMa2TW+IeuvlP+KFPdUkqGoBSe5M7ZSiRVi?=
 =?us-ascii?Q?SaZHFgk8c6B1kSQ/nNv55mQ1kSJG3Hz5eqAFXzuC4skIRRLTmQt9GJbYf6DK?=
 =?us-ascii?Q?HKt1WkJMA97WYMW8xIx+12cE12UxciGw6ys9rsWFcpyQP7NDPpcjPb/XSTwQ?=
 =?us-ascii?Q?tEjmN0i7k9P3dfd2to6ZgGuG83Yl5eA4gsWebahX+wArZnmsUmValdYKnD/d?=
 =?us-ascii?Q?rghNpFSU2ew3enaJsCkcPlJ/R5MKF5YB6y/EQqK2H9r7gCIiiuR/hb78rdzV?=
 =?us-ascii?Q?A3GKEyb7NmhRsKA1wLSYoJyu7HlfLqR0gaVEmRlhAwMznnYgbtzctDkWa9Dy?=
 =?us-ascii?Q?lYnYo8aiW0bMGORiBQm8cmI1snNQvp0C6/bmuUvwZz3KREcmDlOa3zyAX7/n?=
 =?us-ascii?Q?iK34EODXpFYs3MPUrNQc9z5LxmCs0P984UnxOjJol/rqoYDu9x46P8rDeGlF?=
 =?us-ascii?Q?eLhJAmQDXPYV0UVcQjCWb6D7qzE6ZSg/dNgswHUESn5H/YRnJOjLMgNdAVNp?=
 =?us-ascii?Q?4tlJcxrrMCPQmjKbdUTyieME9al+vGxad+T6sUQ7EWF82/x7TcykUKkGesWa?=
 =?us-ascii?Q?A4fddAaTWvu0FPVA6V2acQfZT8E99nxgDGWEaipCj5y9nMoJ4xGQ+y0LZwV3?=
 =?us-ascii?Q?AlcpNeVRGpct2lczmquB75w+Yd5Wq3u59TWM080tx9m8tyTw3s18/niSBxKH?=
 =?us-ascii?Q?B0dV6P4RaQ7tkoBGkMVZZPGlgv2IUY2uBovjQIpTICyw9GCibp1YQejDEn4L?=
 =?us-ascii?Q?ifuuRRbKB4FA4zIqKGjPoYiy5gy9zT20VFBi/TM0rn/cW1n/7d9a9sHpkw+H?=
 =?us-ascii?Q?4ItrxyhFCdYk0bCYS/LfG6vYurRzSvkad00ZRljBk7C3+TjslNXvvEA3ZAiR?=
 =?us-ascii?Q?LOP5akg4T17bqcLCI86H3P+YiyFgLGMs2Foqp1MTMC2591rV+46yC1WYEcnR?=
 =?us-ascii?Q?iVz43XFtmOMtD/ja+uhGxHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd45880-a760-4b62-375c-08d9e094cc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 06:26:33.6909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdVrJej+5IAIMynSn6yrWNLH2x4Cl224w9g5b8ueiEjs/g9SCNLW1bqIw+vsWKOFSY+jvQsg/cEbJx89igxBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

To simply code lines, I guess we can drop variable 'r'. And use 'return svm=
_ioctl(p, args->op.... ' directly.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Wednesday, January 26, 2022 2:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH 1/1] drm/amdkfd: Don't take process mutex for svm ioctls

SVM ioctls take proper svms->lock to handle race conditions, don't need tak=
e process mutex to serialize ioctls. This also fixes circular locking
warning:

WARNING: possible circular locking dependency detected

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&svms->deferred_list_work));
                                lock(&process->mutex);
                     lock((work_completion)(&svms->deferred_list_work));
   lock(&process->mutex);

   *** DEADLOCK ***

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 337953af7c2f..70122978bdd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1846,13 +1846,9 @@ static int kfd_ioctl_svm(struct file *filep, struct =
kfd_process *p, void *data)
 	if (!args->start_addr || !args->size)
 		return -EINVAL;
=20
-	mutex_lock(&p->mutex);
-
 	r =3D svm_ioctl(p, args->op, args->start_addr, args->size, args->nattr,
 		      args->attrs);
=20
-	mutex_unlock(&p->mutex);
-
 	return r;
 }
 #else
--
2.17.1
