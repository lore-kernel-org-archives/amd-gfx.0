Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA5F94CA8
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 19:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67EC010E219;
	Tue, 21 Apr 2026 19:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cxspuWZZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551D210E214
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 19:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeyCBaDCxPuJsRfHyulL/l9/9rWyFT67TuQNeby9nFjTr/a5HOaD7a819HbUKyXVwWFDkDMzp52IjZJ00ujI0WIUmTDoxOgOAxyAi+BWaub0ub0xq/5RUje2m4KEAcNLCqIrZ0aMzzKwiugr6GUaYYiqIMeXyz01Jbhq2pewHZj2U9G2cl8tKh/JTBSt4jplA+0+Zy79HtoGoXPHqYZ7BPuqnQoVWhx2Hj2Ob/oCZs/qUC9LqdP+MHHz0d6mceIrAMoxyuScB3Q4k0NvGUYHVhdW7tFBQGRfBPaoErQ5LpQta20DYHuThTPmmIr8iY8K0iDOVKI6gMF7KXug7Js5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CONGCNRXzQKMMEiHTkVMdxr7wqwHH/uFqi0KVuWNAlo=;
 b=U4c5lxm9883+0tZopqPX72YoXbSBrRsYiLrBEU2WBU6RSiqBZdZZcEC2iWDPDUNgzK6PunYVLP4uLzbKzwuPFj8r9MHMvg4g6lkpghMOwrGDx35NP8Y7PQzokuHYmSwl+ofh4YQAFguYnzKxR82Kp3AnNYzUboFLOynmRM6wyATj1g7CSCjD78khv6OxNrbbwTsLjNTwp1mzRrec34mvAkQAtd2yOg0Sugg4/uX+yhjKj6nqEmCKEKrnbFMdX0rqdZdNFQtKU19oE0c4E/LullSy6/n+sWOB/4K068ohbEoCY/8r1HlQhQk7I2+cNmWsh5qlPMyjKIhS2MCOQGcXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CONGCNRXzQKMMEiHTkVMdxr7wqwHH/uFqi0KVuWNAlo=;
 b=cxspuWZZzQfvHpLju1Sequr3MXoqUfQDEtjiHm1yLfm9ID/LhKNS9/Qnf/hpBR0jmjECraRp7HIaR0tfMN9NP7tpex19QOdB3x2o04nSAZ06J6M3wE/quZKJt442boPmjv1plzJe5kDSsOqyExlvkkBO+UPaoYGDpXxMwLggXs8=
Received: from PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:33:00 +0000
Received: from PH8PR12MB6889.namprd12.prod.outlook.com
 ([fe80::b54:7ede:53fd:76b4]) by PH8PR12MB6889.namprd12.prod.outlook.com
 ([fe80::b54:7ede:53fd:76b4%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 19:33:00 +0000
From: "Shetaia, Amir" <Amir.Shetaia@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: validate SVM ioctl nattr against buffer
 size
Thread-Topic: [PATCH v3] drm/amdkfd: validate SVM ioctl nattr against buffer
 size
Thread-Index: AQHc0cR2A6d6ACncKECNFAHzDHA5NrXp53yg
Date: Tue, 21 Apr 2026 19:33:00 +0000
Message-ID: <PH8PR12MB6889D4CFAB41089AF22D3EFC872C2@PH8PR12MB6889.namprd12.prod.outlook.com>
References: <20260421192406.25128-1-Alysa.Liu@amd.com>
In-Reply-To: <20260421192406.25128-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-21T19:31:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6889:EE_|SJ2PR12MB9086:EE_
x-ms-office365-filtering-correlation-id: 8664204a-51f7-4f5f-5353-08de9fdccc8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: jnq83+oi28un33j4KZaX57ufY7qwK6kn4osXrkluZ+J47SA0JcY5EMD8fZKxQPo3YyfSrsTzqP2nwmCq/Jy3uez+VylhSJRg3BSGl6icZWmMx32mqwN6NYUcdcrOpPgKTIUKMTQS/wLRwisiGIt7TRi6AgjYwGrdhXxAHeTQ3wRQKHZwgfqg3Td6gJHNgLjyuzKCeHAu6G3shUvEb8XhoPUdi1gUxpIyhEo3iVhuj9At8S6i3olnabDEoyECNPq2fvR8xtH2580FziqmuL120sHJLjle1y/0kdy8hZjkWoCdWVQyT5Mlnz1S28vsI0Oodk4hxQjaFpqN19GesIqszEvp1RrGE1OUMnYeaw6z7NmErTGR2wGpbpQUeawEA25Z2bDJCvgjZw+ET33II1kWdGegEV6rYAvyf9V8qbzgv1IeriXmNsv3xeH76uofPLpOE9thU6aJiUux6hm7LYWMAFSs8dG7bTnvEWbHfOPBY7A+Y2r/ZgFS0GI8k3HCmEpNhuuvfBFFRghI8pposLRXiu5BRNXY/Z7ApHSIP9yEgMpZ3dawlnm/E/RE0oARxhsO9MlKbjc7XW/zdliA4hr+JDKeF77E4U+SZgia8/AFFy6WawxXL1fnpJdswmf8ur1VqL09XVNbz038xf+FIo8+KqhvFUSMhhWy5qCconXz7njPwo4fmgbZxqZFixk5YsX5nJUwr6677iQi9VVouMnOh8dqF9yZ1aiWqo9WJkH0Bo7AShNPf6ga0Qt9q2rkeQBCcsIOxdk/oQhFdP+gHUcTW6Ne3RJR5KXdyeYATYZlxK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6889.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQ1HA8Si5jjJcfuyNlYWVf6uNc9YBefqz9cUgtECt+XWb/JeIQ+0tfWII/6F?=
 =?us-ascii?Q?Zs662ti4GeO/Yt+4I9c4YZh2gxEmf+kj9WesDVwFX9iNdCafjtjrJd6f6bcq?=
 =?us-ascii?Q?GK3iKxP7nx4uq69RHGuFcuByjf8Hi2/pgE19uQNrUTfP7zx+BWZaZQBIlxP2?=
 =?us-ascii?Q?3ZKCrsJdoESkCSEmJrHmf3p1z3qPePgSMLMp2FSqXa6NiFUOJ0fnjQcDyjGS?=
 =?us-ascii?Q?P+qQ5QKqzBwRZWV72B8IKFTsJUjqCbfOb6H2pZMl1NDgU0Ac+l8VjF6i3xM/?=
 =?us-ascii?Q?gQpJW6QDPWx1p12LOnpRQ3ipGcJaV7UbxaKEngsviqqSaA47EBOa+Q5nalgR?=
 =?us-ascii?Q?3wXKGp5LpJrhq/CZdMqLJZ+KyRExNqeCoiAzfh+Sq/Fa3FTyicp2gn6vpmIw?=
 =?us-ascii?Q?uFFF0Z2aVzgAUJa7Nxt/v4FaN9SndGMp+9GWRsAZzt8Ol6c+S1/rqTNvPzRZ?=
 =?us-ascii?Q?hwZpaPPaKOc5qLS1rCeMM8G2WGv3o5RnnqhZA4Jzm7CDyhodQLdVYNbNY757?=
 =?us-ascii?Q?Xexgb1KZEPmXoqnmg3Lpm4n5XqGi2/kg+rkyEksIMumcL6HaEhqyZMr2bTR/?=
 =?us-ascii?Q?kpjFTT+huAitOgaMpUxZ2KUyaZFVnEGXSuAv5HSROVMiMvmeajasqPOZpMZy?=
 =?us-ascii?Q?bEQqGwgiM/6XfVYtgDt59uEOV+5/ZdFryqH+R/o2gfo4g7nE0JKm1lOcEBzY?=
 =?us-ascii?Q?7qOag6sljEcMzwbcpdj8OYGgtDZEG++b/yYqRQO9RCPBoDdaX1sbXQTjOFk9?=
 =?us-ascii?Q?TMDAnVRl5hgLVK/jX+Vmmlcod990ADVqZJGJDXVTU6ThGt88S0kGPZ/rXvks?=
 =?us-ascii?Q?06gGYL+pE0dDAfbsggFQokKsnDgrb9klMFds6HHt4yv6/arYmP0FceRJjJai?=
 =?us-ascii?Q?jDrZtakri5J4GTa93iBmQuFCNWBof+xaqgQMyRtZo7HQw2nJFh+tD6qBOidh?=
 =?us-ascii?Q?EjtFWezcb2jQ6q/rC3XmZ9qaKRb9LuGHS6T2m0BrG5xKcrqSQcPfRhASyAJN?=
 =?us-ascii?Q?KIM77985//KnK5+6uovS1+nW/NyeDcH20UPRRr9ZFlIVrfbocPetzPlJPaQX?=
 =?us-ascii?Q?XsNa/fLpoQxTa2XeUHemC1dAZMbzH0dK7/UgP52fkTqeIqxN6uVWqGaTs91A?=
 =?us-ascii?Q?BB5ThCXjHQCVPnXuobYikLp9tyI0oJ/NoLEXJ8x9+Dh6uwuYXypFhh9Guebk?=
 =?us-ascii?Q?pDOjJEY+1LwqDY1ca8xNtb+HgExOmV7fdHjLw33WWfkQIZa6xIQoILxqjjmx?=
 =?us-ascii?Q?sSpiPngNXQKwDQ5MkGJ9ZfFjyTWYipHzsQ0oup16qly/hC34AXGgrb3ZiGsS?=
 =?us-ascii?Q?IttKMEz5e7kQFOIBINaLNlFM39Oki+yVCrZvRRqzsQy0hnR5/9yboCn9AP/K?=
 =?us-ascii?Q?SLxJsjpaejjG4qrXrHy7pna3+WCshvfvRXNYXHNLRqvOgjZbTC/YqvxDOcTd?=
 =?us-ascii?Q?Hj/kKBTVxyofCUJKhT8F5wywJD4kTBfRP0DdTi7zWU6w3943hciNWhs+WRhl?=
 =?us-ascii?Q?TqIAWaYKPPeE4A7B1n8hn4PwpoQPBKWMp1t8lKNf3Q+oc4MzW5oJ6+Fw6yAI?=
 =?us-ascii?Q?cz5GxqTC6HqcnKUhzyhJZSjtdE2RRCq5XdMWWEI50sufHKzohOFycfW7O0ji?=
 =?us-ascii?Q?Bw1Owp/nUaYhAqEWzHQKENYXRZbdEnGY2HMfi5na6cR+MRnFwBeUwtobEmyc?=
 =?us-ascii?Q?xwQOGGKwNEA4XtPDcaDaDgNumHzvYqHFxOzu2XQ8hDLzhPC1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6889.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8664204a-51f7-4f5f-5353-08de9fdccc8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 19:33:00.6217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TogCgvyPOb9/J4L0VBiopWonX1lzoDNgR6QeKbh1N3T3PPqrJP7k7L3x9gEBa6NFyP2a7ozknIdoqlVa5IqeGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

LGTM
Reviewed-by: Amir Shetaia <Amir.Shetaia@amd.com>
-----Original Message-----
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Tuesday, April 21, 2026 3:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Shetaia, Amir <Amir.Shetaia@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>
Subject: [PATCH v3] drm/amdkfd: validate SVM ioctl nattr against buffer siz=
e

Validate nattr field against the buffer size, preventing out-of-bounds buff=
er access via user-controlled attribute count.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 16fb39259911..7cb39a8d40c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -1694,6 +1695,16 @@ static int kfd_ioctl_smi_events(struct file *filep,
        return kfd_smi_event_open(pdd->dev, &args->anon_fd);  }

+static int kfd_ioctl_svm_validate(void *kdata, unsigned int usize) {
+       struct kfd_ioctl_svm_args *args =3D kdata;
+       size_t expected =3D struct_size(args, attrs, args->nattr);
+
+       if (expected =3D=3D SIZE_MAX || usize < expected)
+               return -EINVAL;
+       return 0;
+}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)

 static int kfd_ioctl_set_xnack_mode(struct file *filep, @@ -3411,7 +3422,1=
1 @@ static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *=
p, void *d

 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
        [_IOC_NR(ioctl)] =3D {.cmd =3D ioctl, .func =3D _func, .flags =3D _=
flags, \
-                           .cmd_drv =3D 0, .name =3D #ioctl}
+                           .validate =3D NULL, .cmd_drv =3D 0, .name =3D #=
ioctl}
+
+#define AMDKFD_IOCTL_DEF_V(ioctl, _func, _validate, _flags) \
+       [_IOC_NR(ioctl)] =3D {.cmd =3D ioctl, .func =3D _func, .flags =3D _=
flags, \
+                           .validate =3D _validate, .cmd_drv =3D 0, .name =
=3D #ioctl}

 /** Ioctl table */
 static const struct amdkfd_ioctl_desc amdkfd_ioctls[] =3D { @@ -3508,7 +35=
23,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] =3D {
        AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
                        kfd_ioctl_smi_events, 0),

-       AMDKFD_IOCTL_DEF(AMDKFD_IOC_SVM, kfd_ioctl_svm, 0),
+       AMDKFD_IOCTL_DEF_V(AMDKFD_IOC_SVM, kfd_ioctl_svm,
+                          kfd_ioctl_svm_validate, 0),

        AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
                        kfd_ioctl_set_xnack_mode, 0),
@@ -3636,6 +3652,12 @@ static long kfd_ioctl(struct file *filep, unsigned i=
nt cmd, unsigned long arg)
                memset(kdata, 0, usize);
        }

+       if (ioctl->validate) {
+               retcode =3D ioctl->validate(kdata, usize);
+               if (retcode)
+                       goto err_i1;
+       }
+
        retcode =3D func(filep, process, kdata);

        if (cmd & IOC_OUT)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 53c26b1a25ca..ae327611f20c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1056,10 +1056,13 @@ extern struct srcu_struct kfd_processes_srcu;  type=
def int amdkfd_ioctl_t(struct file *filep, struct kfd_process *p,
                                void *data);

+typedef int amdkfd_ioctl_validate_t(void *kdata, unsigned int usize);
+
 struct amdkfd_ioctl_desc {
        unsigned int cmd;
        int flags;
        amdkfd_ioctl_t *func;
+       amdkfd_ioctl_validate_t *validate;
        unsigned int cmd_drv;
        const char *name;
 };
--
2.34.1

