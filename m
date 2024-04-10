Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D6CD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 20:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003C510E6B0;
	Wed, 10 Apr 2024 20:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CFJ41zCV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2106.outbound.protection.outlook.com [40.107.243.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6007C10E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 20:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOjd8WGw5aEfA+WI6L2LgFdsnd7q1tIfUlW0ANXiahL62g7fo1G3pqeNB8Jfp3HG9tigQ9IYSKG9pproCcz100ArWHgyY3S2ZGKlH5W3x3DOo3mgLFo+tzEVAjhEQFKybPzqZJmCPU1ZaUIMQ8TFuWNwFDQRDeW+oEbeAmw2yWN1Q9LL0mR46Ysm6b+E1UO7uDzUeh/ktybTxGYPV0YYDD1/pBLxfT0sNfYh+tzHNHvTQjps8lM1wkIkAb0JYEOpzrr6PXb81a+8nM6Tvwubiyhx5YQpqQYEke8Ueai7TkaqQNKLwTlpBSz8jsbqdiu+cOgsMUV+ghSFte02ipxRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj5jK89DhZjRg+VvIwH1ZHHVKZCJJyBv88qgxLoc40w=;
 b=fE+NukFp6oBVlP6B2Up5T2mKkdL7wCEljNr9fgcpuJpK/rnWxt08y44GFBJSrtWXURqCRpGQ5r1TGcFbw2ZJmYP5hUMBNOMF5gSqXDN7/R9TO2j95ceyoHVGnTNu+zYGu1YfxzdmCnCWBK/QZcoKtUDoyCTCdZA4bizguI9CqSxlsE2ciDFrG4rSJdGI/GJth7ImCKQBkSl0PA7GgQqHt60KtfzS5oO3SWFOWTuCMTangvzDigsux+lPBSM5rEE3fW7Cadue0h707DCUM91zf5AM58vqONxocCnt09KsY1cUmI6fPUa5SSL9ap8l1gqXri6A8zAfHrte4CYl4QPk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj5jK89DhZjRg+VvIwH1ZHHVKZCJJyBv88qgxLoc40w=;
 b=CFJ41zCVu6WFCoM7OwZ6nCPQWWB+Qa5ftZXueVlYTR5N7vdYjN7p1zo5iZNWWVFyUIwz73y1NnyrJoMqBtyrRI1TA9b97BCO2Tvt6aKpP70necH/rrpOBo68P6j1lSLH3JbtTpFu15h6WlPInkb0mdnX9WDqjxb1eaktvqjIwSc=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 20:09:16 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 20:09:16 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
Thread-Topic: [PATCH] drm/amdkfd: Fix memory leak in create_process failure
Thread-Index: AQHai4JzDG+Ic2owH0yMuZNT80eAqLFh7siQ
Date: Wed, 10 Apr 2024 20:09:16 +0000
Message-ID: <CY8PR12MB7099176914BEABBE61AED17F8C062@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240410200432.1578125-1-felix.kuehling@amd.com>
In-Reply-To: <20240410200432.1578125-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ac997f57-4828-4793-99e8-4f012d0a7e85;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-10T20:08:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CY5PR12MB6204:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21qy1lH6+EVnzsxgbBAs4FsVAlF2S2UMwMHBRw1T/Nr4NZuz8lfMgYmRllE1FUv6msorxjzlKT9FkaycZ/EjaupmpheCwIL1NVyo4D8vSfx3oMmYHgUzxSDgyTJa41DykYLGLLa8biQa0ezULDJnj2HRtjTXFMsFkAZlMzy+zpgfAA8IKEnASGJgYnba5nlOGOrBgOC2RjxMw3afSiXndEWoSY1SvoudiaXU2ANLXgkSJ25f9Ay3zJCKK+c9TZd069wNt/aq2+ldLUGKlyn+h7jzHipDCl3lmv7TS7Isk2T+sHrC8mYdRjco8jZn3fnsAHR4kj3TWvlKZH/cvvjvVeOISdA6/7DowJSOvXB0vS58Llwf2+RGeyMJokNFFhhCLA9qYckIeZN4HHu06OKxLHsnJjvwDrvhrQoQwa868+uz1ibvh6xvJF1K9i0NS2HBZLSeO1VDGwGNP+czvak9k1/faZL+ahA+9ZvNdZsEJbgq2NcP59Jp/BstdO2ihWlJbn96FESj9htG8NDOP8S/AZqMLpwmwx9iwGSdtyHDZzeUhhO60BN4FTOyBi+QILS0pP7VPHJb5wE5r38CoUojEe/vmAcdbw4djBi921G5ySLhgTC7klQVBUznPY0GYQAAZWVGNJjOLS8pevqEBijTP67rfz213dYQjR4n21nd1HM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHpSOpKPvp26Y1GF9RsMtO1Vu7CO5M6cQQY74917YDE4QFkpYiL7kdQP7lFr?=
 =?us-ascii?Q?W32uh9/DzwSXOHZHTdjJ/KMXbI/pZPe0mXTTRBt7jxxvh+Ru7XCIj7L9S6TP?=
 =?us-ascii?Q?QtdptTMYWFhb0NGXZrpuPvbRTo70tzX2Q1bmaf8hbPwGyFlLwD5N89CP5XZE?=
 =?us-ascii?Q?uyn+gG4eWBOgOIw99Y0eegftrVVzoEpW7QEwr0PfgeUNIvFsWYqMFWMdizaW?=
 =?us-ascii?Q?18194YTUEKGSRw8vOvUhOhA334S2U+vYGtm6qYNJtOFN5XZktwQ28HNJ13pr?=
 =?us-ascii?Q?DxvgEpD/LjfJbiTD52elJtW2SyQrlO7spyTwZPghNQv5eMPZWxNF96E5W68x?=
 =?us-ascii?Q?7hkoWKKirGmPqyJg4HZa5hagcGtodysNIFbBcQHO872JX++ZeeqmpSgpUnrg?=
 =?us-ascii?Q?EE35mzlCdY47QgB1fuGPqVcNAMAgagy7exsZTSLILCfO7wBnf9dBJ+ERyA6V?=
 =?us-ascii?Q?YtxM90RTKGeKCt4KFXB2A9FLCpwOzME8zu9hthh5HOI3wqaM3UEzhpqlNhGj?=
 =?us-ascii?Q?/0+Ana64Y0JUK8sTTwFUUETjrR6lqSGEbdvNe45N3hy0iKCfYOMSPmTOG1gh?=
 =?us-ascii?Q?JIgp3n2Nf4QNsAs/wcDHON9q/8pNZ0Kl9aiebZsPwbZCLgPa/n+CnWEsKcVn?=
 =?us-ascii?Q?2aHlf1hpzF3XsZWH8K1RBNjrTXq6BxQUMoIA7KwhCnUD7XZ4APLKjWd3h9JO?=
 =?us-ascii?Q?qdLURP+DVLrLkwXzTCPLUXkJXvszKQfbvxw/RDl7UatUoZr6rm7ep8sMRaHh?=
 =?us-ascii?Q?VOIwpCzF+SLI63ON2Ap4zUjDSXk+nojRwJsnPUlx4Q0hM7OdOoZt1lyawgej?=
 =?us-ascii?Q?vsDP4sv2QCIomw6LPAzQFqeLWmuc3Rds7AILVv4kBom8YlWZYyK6C/3a5RrO?=
 =?us-ascii?Q?TDWukeH41u947pltETn7DnaxwRCsCfbIOfayntryc4UD2iwVtLOVSvkfRZlR?=
 =?us-ascii?Q?Z3aCYrNmIJIRi3UG1nTSNfrpy88HR3mvrNPgZPRAFlX779GE9hV/j7mHliGS?=
 =?us-ascii?Q?3nIM7zxONw+wGfjjqkLNuT1/pd12fZtUP4+cen5LbHgMqSRFkozS9GTqngM9?=
 =?us-ascii?Q?jdENLD1FEHaZ9YfqH4oMTwEaXTVXAJ0kpjtG41kXnIZavT8kcDUVs+SJHnIZ?=
 =?us-ascii?Q?yK0JF5MUdScEbRa5Njggb6gu8os9yZS9fZ7DXuXwlFCsTOyTrXMwjIqCn9qs?=
 =?us-ascii?Q?bHX8YRT5MYMl6TtJct7dhW/pSGCvc9W+F2Tyg9LJGX+nzuO622m0qdjoL78y?=
 =?us-ascii?Q?EDml+H2fbm0goi55k4ODmiknk7KbGcTGyznNKnUkGyPlhTT4ng/P0a4hJNsi?=
 =?us-ascii?Q?U75UqNhw97xSOkHE4NfAha5hG1dzNOWoiYnUX6cMSAjrpZT67FLyIhIfIBaH?=
 =?us-ascii?Q?9PyCrV1ITYPAuiNCQGbeWLvO4rwNyb/Ia+W4LpmjH3l6ZYlCvRNXsvMDLrf2?=
 =?us-ascii?Q?FnDvR5tBlllbItvMe3HvkaIsezqsICL+RgfR+VjnSmk70MDjlty013a0GZxP?=
 =?us-ascii?Q?3dbdB9zq2TsFp3NK8iq2BpIPmH7PJ6k+VIRb1gdOoo+Z/Z4IbkrOcbZTznka?=
 =?us-ascii?Q?yjAC014iJtbM46Mf5BU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9228fb5-5481-4ef7-2cf4-08dc599a192a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 20:09:16.1621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZSSTwS85DARy7NzVxRL52dHczaWsO5WJ6636hOJ2FbSnDgR8XAxqUd7yC2zwCdn08YVCF6Ak9mxha5XgU8kkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

[AMD Official Use Only - General]

Tested-by: Harish Kasiviswanthan <Harish.Kasiviswanthan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Ku=
ehling
Sent: Wednesday, April 10, 2024 4:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Fix memory leak in create_process failure

Fix memory leak due to a leaked mmget reference on an error handling
code path that is triggered when attempting to create KFD processes
while a GPU reset is in progress.

Fixes: 0ab2d7532b05 ("drm/amdkfd: prepare per-process debug enable and disa=
ble")
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 717a60d7a4ea..b79986412cd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -819,9 +819,9 @@ struct kfd_process *kfd_create_process(struct task_stru=
ct *thread)
        mutex_lock(&kfd_processes_mutex);

        if (kfd_is_locked()) {
-               mutex_unlock(&kfd_processes_mutex);
                pr_debug("KFD is locked! Cannot create process");
-               return ERR_PTR(-EINVAL);
+               process =3D ERR_PTR(-EINVAL);
+               goto out;
        }

        /* A prior open of /dev/kfd could have already created the process.=
 */
--
2.34.1

