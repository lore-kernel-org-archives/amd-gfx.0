Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6383BC38150
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 02:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB66410E212;
	Mon,  8 Jul 2024 02:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LRcyCuI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0B410E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 02:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izOxJYViljfA5dLDW4QrHEZ2373N5Rf/CK331gxgYSPiqP80HEtZnMG/lFipWAKFBTUP0TLSJT/qw8pd41/PvsF+rUGez/VEnQLQlu4HeipsK5DOFhijuL7xhZG4C1slSF5OzQj1XiaH1filNWjDOoRJLqvwNddTs7KvIGzRZMVj3uTTRNuvu0OdZEGuRgbPq8jvWBt1a1yF7wCe44W9q4VJ3OMGRoEAO1ZA0Hfd+XHyGVXl0MEqJzlDUiDSwjRoZVGh5DSswrltiYtQzlNPHeJgDjT7YOfVrM/3p2afbDOfr6MPuaof6/YbvglYlsaxNPbSCAn1jpdzJvUDE5PbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S3BU4GexNimlMdjM1BpaJ6+kNvdEEfzIAFk/iPsAV8=;
 b=IuypYqCgK70n/dc5SGaLvH+jvlp8TW5CEyRQ7h+gqPPUKTT7fpcKreaLWtni3yLnRIp0MVC0uZN/b5YUg+YmpLFt8nxJLj0eB0xVgC54BDOuoXocD14ItEZccjfzYz0W8/GNl43p1f5qV5xINND019u2yBXQbeRnXO4roidhbIeZvGlNXjc+h8iJrBARCvH8WLUvQn5vlv0XoXZ7UdoUSdcv41x3sAxUUMRcGsMx8EmLY7jqGzJBREgClSbCiLfXtbYUolwKA4OgwufrkRl7WKiRf+9NK63yYB6U3Z1IGEBzaGgs4pmGuTDDkUVaI5WzvZd2IBm/rYuwjU2T0SSpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S3BU4GexNimlMdjM1BpaJ6+kNvdEEfzIAFk/iPsAV8=;
 b=0LRcyCuIcvKZnq3mxnInfRdF5MOMvAL5MMZcvyPwhny6PLFnfrnYnaESv6bMwaF4GLSGcGSjB2aF88yWgE6DouuLFY51CRyqBXo4m8UCW22l9fgnl2+yAub8Qe4lxtJ40xm23OxGlKWFauwm2Me/KXlvD0kk46bS7pSUJ/njp/o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 02:54:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 02:54:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: refine amdgpu ras event id core code
Thread-Topic: [PATCH 1/4] drm/amdgpu: refine amdgpu ras event id core code
Thread-Index: AQHazQ0nDJGc5wMZF0KyT4eFBvBhBbHsKVXw
Date: Mon, 8 Jul 2024 02:54:11 +0000
Message-ID: <BN9PR12MB5257B8DD9285E8CBB0063EE2FCDA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
In-Reply-To: <20240703055200.1610956-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bf7ae898-6896-43c9-a7be-9131c7abe361;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-08T02:51:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8281:EE_
x-ms-office365-filtering-correlation-id: 6e5dfd70-a6f9-47ae-657d-08dc9ef93e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?J8qXq+Kq1YPQzjhgqECOFdPNRUg0atkQoTKuU3NER4Rm5F+ccq6WSROZnVUc?=
 =?us-ascii?Q?q/VWs5kLYCe3rXTzAukIYz20HuSsFyGrGdcVup5ZDnvQXhCKBV49jySqOXD0?=
 =?us-ascii?Q?swmZGF7u9xFswBB4fy53dIlNGM4VjEccBgI2q7O7cedlE2jlDyDobZ5Dpzrt?=
 =?us-ascii?Q?t3TYrmu+by65zDVpCePwoYreHh9H+bYEZfmSbg+1Xmv2y1p214vrLuG6KLsQ?=
 =?us-ascii?Q?hwgtZM6QYRlR2LBrq+8QDezoNwygUT6fn1FUKqisDTfbfIYaOtsrAyLXgs2O?=
 =?us-ascii?Q?WCDhDq93VkzWJW7aGftLIYEL+duI+nvdjVF3JgyQ3yFlngPrh9mWE0fkrEtW?=
 =?us-ascii?Q?Bj2wasXK8JnoeABM+MAbxdO6I2pbOg3a1scBkTpwBj6mW02pAny4830HDCHZ?=
 =?us-ascii?Q?7ywSik4pJ/24BWOypkxiiEbcTuuvAMr+Tf+iRV5vIvSzN2fRo+32mv7HixyR?=
 =?us-ascii?Q?eFRzZBjXCzh3Lnr9bkUbNti2GhI5axtmvzQdXMqFEzo0/WxxwKB9hiqwcW6h?=
 =?us-ascii?Q?K46X4tc0I2RdGdKhY5mLxZwgonvb6v4p516ZIs+OYQsuu2jIMDue0zGD4PsD?=
 =?us-ascii?Q?8/HCfkhqxHcHbIXPz8HlETczONDdPIS2Xol2ok4/o13WSywANaygIvtA2ZCr?=
 =?us-ascii?Q?U+HT9+yrbIYS/NM6C2WEQrbey2sepSu49fZJI47AxOrn8V5aU1tkfa+comt4?=
 =?us-ascii?Q?vXaKZCiK2fOsXH0LTtZlYV5l047vW44XZcfa4xnCE9h9KV+x7gCY7JqluhiH?=
 =?us-ascii?Q?1WNsxCT5MUpeCKPvPmraRy9zQ5vb8gPw9ecHTYNaJabHfOXOwuY2PN/+eDmQ?=
 =?us-ascii?Q?E09RaFBd4dV6pJEku34RjBZLD/XtQgl0bqO3pi+FNNu5MeZiBxX7ILgiR3dg?=
 =?us-ascii?Q?8AstGtVH1q8wg1nsx+Y7t1yOxczw/GWl9dkWpiJvQc3I2XbbBnxL3VnMCK4+?=
 =?us-ascii?Q?fY0e3AOYynmLKwW7udcu9Y4vGtB1MWP4Jj5Swix8nxhxNIcprmdz4UW2mr8Y?=
 =?us-ascii?Q?h/2RN6fUl97+WyxRy/4TlAsg/a1esLc/W8xn9M/9Conql7VA4lp6+OyEOCwj?=
 =?us-ascii?Q?fEtb8cAg/ByTshXvctoKmihNeRMWlpdEmDxXtDkcfE1ik72BcghmLtZKaEuX?=
 =?us-ascii?Q?RmvRMxhORu422PwUCI2tU6qDP6ycI1lgeUfeq0C0r4f0zzmfQnR7A6sOY5zX?=
 =?us-ascii?Q?e1k0alfp6y7ZJjBzaqS3AvU1Mc66hsLqOoN8wCSLShj/XfwufRXdUu/xc+yv?=
 =?us-ascii?Q?9cC9k6fBFsfsBHuSJMaogPbAQhzFC7v6ACyKlSZ+NpZSv/8hredlqlaZ93st?=
 =?us-ascii?Q?iPawRojCIGqKVDzDLX7F3eDrSUGiCNgvqfU82ccjchWYQ/D74jkqnQXiVq8w?=
 =?us-ascii?Q?Hz4F/Bduczf1b6wMOwk38BX8u6ff66cdCK8XbkPaeyD7GyqmMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w+7DRfrqvKkV/Hwf6CK0DrFwJ1ihLceMHTsNW8qQ/+cmoiQrTdOb33QRQTd5?=
 =?us-ascii?Q?pJVXaNoO6m9IF/brmizKiFC2GC+4+c+qden2s10Q1YxFZ1xJtvQ+h2ag228j?=
 =?us-ascii?Q?JuBJ19JpkBO2XvmNFKlQuDQN9CV7Va4mTbJm+VPb8JjgnpBjzu1r6HnFC7Rx?=
 =?us-ascii?Q?S6uuVe8PyCliY24mEdJUkq5H3uDqvb+I35Y3k5hKv7pA44xa3W8uMN25mGb7?=
 =?us-ascii?Q?nAYZe8Io92xWlDcFiJLVhob1+4Y8Go+hT1DxHGgmDv38dPfyvwA1lZ5Zwdls?=
 =?us-ascii?Q?e7gE5ouwnPFw9thnAt1z7BsB/qVr1jAmbT27fo98g6YLP/DSXKkhfbJ8s4Mh?=
 =?us-ascii?Q?U1oXVv4Z1aCgAnsFjv0NKU5y7Q8lpoxzOkGYhk4Q/FBrc4KElOiilNaPzfT/?=
 =?us-ascii?Q?g6MNNCXqqE1A4HXpPNC9vIao5zpeK2AyYB6N3oirkA7IcA4Hi1NIBgaDJ5y5?=
 =?us-ascii?Q?qSY9CpK8H4uvlna0uRLSNhPe/jKR7Z22LH36jBQ3SCOc5h0Kiwzq5ldceFns?=
 =?us-ascii?Q?7pxdyuPW9S1QoahTgY0ZHP2pvXeSp4r0hek9fm0pzny9lf7ATdunj4ftNwO8?=
 =?us-ascii?Q?GL4+F/kdUgGxEWAmrpZPgGN5HFE5+lSRpZdDVMIzErkWnoSqWK8do4P4cNFf?=
 =?us-ascii?Q?c4bO21Uvqf82kaM7pBeFF+LwdrRIULyuQvOfKiOz3md7Lb86T2fTnTA5WV7p?=
 =?us-ascii?Q?GB6/1CKAn532o3x1qf/Rtn34BUWS6IUd+GsEeEGB8RP51DTBXU8SfpZZMAIF?=
 =?us-ascii?Q?U4CBx+JbyhNkYQ5+qQ5LDq29E5beC39jDSj1fgJq0zNXZupPGYUXMaGTaKHq?=
 =?us-ascii?Q?YdErm8sitQAnfggpsm1OcO3zIGVX6ldfyKve8340aAoVkjQ2A3esuDSBLM9b?=
 =?us-ascii?Q?89G52bk065GVphCCNyAbNnitkxQkbKTYDCBaxiGYcV2SZ8hjvNXYZHg7f5ni?=
 =?us-ascii?Q?7BCGzzSFkGjXuuVcf7fqAqHo5vPsJ9UxbwCUFj3RVW2la7/XYkCa8B74JZyX?=
 =?us-ascii?Q?NrmlDO9expiPDTIlWhk+5nAEdZqx22TDkch803KNt8LI3tVJvUFtLdNOtyjL?=
 =?us-ascii?Q?UfJNU9BTqK19rzAcc+zlrJ9M56vBJBTUAZRxlcXVZ3t4rqpL/RHxnFY6hYPk?=
 =?us-ascii?Q?FdnovA3iud8gjDsQFUtKBk/yECdnkCBXmkhkNYui/07k5P2+clN630tnz5Or?=
 =?us-ascii?Q?gjoAhj6IcyDckr8nDgVlgjkQQIqBaeIfnh7dHnc9PjbOSHVDjUT59j0Ng4b+?=
 =?us-ascii?Q?yL9RqxlW3KtkG88100+NOocja8uNlF18CEmjX++hrntSxHiA94rM/qVmA96b?=
 =?us-ascii?Q?980x8GtlE420y7sFrDa1xHuv15zI9JY5Cr+oznmvZdpybCTiqYAxrnJ+ELk5?=
 =?us-ascii?Q?RYfSu84Seq6wZYlaj7vhnmiNBAAZ2Gu7yh0Ac1a2JTzwo/HE6GBIFCzR4bZu?=
 =?us-ascii?Q?lkUlYpYLNwmE4LuQ6g3Eg2Thk5+AP3NfVGFNYFkjQVawNiGWh9kOJMd93/VH?=
 =?us-ascii?Q?Ja7+mXSrwsJuHWOty2GWyi6e2Rmn7wkvEOY6XejpDQekX/jyvpMNft8suBE8?=
 =?us-ascii?Q?bsTQpmssAPteOdfiz10=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5dfd70-a6f9-47ae-657d-08dc9ef93e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 02:54:11.0974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZDAB5jWVX/YxO792pEV03MbB9OqoyV3YR4BTM/g3dWm8lHwoUw76sJKasOEy/REx/Dk2itajUfsFzkOqXui2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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

We will need to change RAS_EVENT_TYPE_ISR to RAS_EVENT_TYPE_FATAL to differ=
entiate the upcoming correctable error ISR event.

And please also align the terminology in code to change recovery_event to f=
atal_error_event, i.e., amdgpu_ras_get_recovery_event -> amdgpu_ras_get_fat=
al_error_event.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, July 3, 2024 13:52
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: refine amdgpu ras event id core code

- use unified event id to manage ras events
- add a new function amdgpu_ras_query_error_status_with_event() to accept
  event type as parameter.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_mca.c |  4 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 89 ++++++=
++++++++++++++-----  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 18 +++--
 drivers/gpu/drm/amd/amdgpu_ras.c        |  0
 5 files changed, 88 insertions(+), 25 deletions(-)  create mode 100644 dri=
vers/gpu/drm/amd/amdgpu_ras.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 7945173321a2..19158cc30f31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -119,7 +119,7 @@ static struct aca_regs_dump {  static void aca_smu_bank=
_dump(struct amdgpu_device *adev, int idx, int total, struct aca_bank *bank=
,
                              struct ras_query_context *qctx)  {
-       u64 event_id =3D qctx ? qctx->event_id : 0ULL;
+       u64 event_id =3D qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
        int i;

        RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architectur=
e events logged\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b=
/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 9d3a3c778504..2542bd7aa7c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -274,7 +274,7 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device =
*adev, bool enable)  static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu=
_device *adev, int idx, struct mca_bank_entry *entry,
                                         struct ras_query_context *qctx)
 {
-       u64 event_id =3D qctx->event_id;
+       u64 event_id =3D qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;

        RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architectur=
e events logged\n");
        RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].STATUS=3D0x%0=
16llx\n", @@ -543,7 +543,7 @@ static int mca_dump_show(struct seq_file *m, =
enum amdgpu_mca_error_type type)

        amdgpu_mca_bank_set_init(&mca_set);

-       qctx.event_id =3D 0ULL;
+       qctx.evid.event_id =3D RAS_EVENT_INVALID_ID;
        ret =3D amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, &qctx);
        if (ret)
                goto err_free_mca_set;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 53b5ac2d7bed..45ac82a34d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1055,7 +1055,7 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
        struct amdgpu_smuio_mcm_config_info *mcm_info;
        struct ras_err_node *err_node;
        struct ras_err_info *err_info;
-       u64 event_id =3D qctx->event_id;
+       u64 event_id =3D qctx->evid.event_id;

        if (is_ue) {
                for_each_ras_error(err_node, err_data) { @@ -1140,7 +1140,7=
 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev=
,  {
        struct ras_manager *ras_mgr =3D amdgpu_ras_find_obj(adev, &query_if=
->head);
        const char *blk_name =3D get_ras_block_str(&query_if->head);
-       u64 event_id =3D qctx->event_id;
+       u64 event_id =3D qctx->evid.event_id;

        if (err_data->ce_count) {
                if (err_data_has_source_info(err_data)) { @@ -1366,7 +1366,=
9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *=
adev,  }

 /* query/inject/cure begin */
-int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_q=
uery_if *info)
+static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *=
adev,
+                                                   struct ras_query_if *in=
fo,
+                                                   enum ras_event_type typ=
e)
 {
        struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
        struct ras_err_data err_data;
@@ -1385,8 +1387,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev, struct ras_query_i
                return -EINVAL;

        memset(&qctx, 0, sizeof(qctx));
-       qctx.event_id =3D amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr=
_triggered() ?
-                                                  RAS_EVENT_TYPE_ISR : RAS=
_EVENT_TYPE_INVALID);
+       qctx.evid.type =3D type;
+       qctx.evid.event_id =3D amdgpu_ras_acquire_event_id(adev, type);

        if (!down_read_trylock(&adev->reset_domain->sem)) {
                ret =3D -EIO;
@@ -1415,6 +1417,11 @@ int amdgpu_ras_query_error_status(struct amdgpu_devi=
ce *adev, struct ras_query_i
        return ret;
 }

+int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct
+ras_query_if *info) {
+       return amdgpu_ras_query_error_status_with_event(adev, info,
+RAS_EVENT_TYPE_INVALID); }
+
 int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
                enum amdgpu_ras_block block)
 {
@@ -2305,7 +2312,7 @@ static int amdgpu_ras_interrupt_remove_all(struct amd=
gpu_device *adev)
 /* ih end */

 /* traversal all IPs except NBIO to query error counter */ -static void am=
dgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
+static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev,
+enum ras_event_type type)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct ras_manager *obj;
@@ -2338,7 +2345,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdg=
pu_device *adev)
                     IP_VERSION(13, 0, 2)))
                        continue;

-               amdgpu_ras_query_error_status(adev, &info);
+               amdgpu_ras_query_error_status_with_event(adev, &info, type)=
;

                if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D
                            IP_VERSION(11, 0, 2) &&
@@ -2477,6 +2484,14 @@ bool amdgpu_ras_in_recovery(struct amdgpu_device *ad=
ev)
        return false;
 }

+static enum ras_event_type amdgpu_ras_get_recovery_event(struct
+amdgpu_device *adev) {
+       if (amdgpu_ras_intr_triggered())
+               return RAS_EVENT_TYPE_ISR;
+       else
+               return RAS_EVENT_TYPE_INVALID;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)  {
        struct amdgpu_ras *ras =3D
@@ -2485,6 +2500,7 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
        struct amdgpu_device *adev =3D ras->adev;
        struct list_head device_list, *device_list_handle =3D  NULL;
        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       enum ras_event_type type;

        if (hive) {
                atomic_set(&hive->ras_recovery, 1);
@@ -2512,10 +2528,11 @@ static void amdgpu_ras_do_recovery(struct work_stru=
ct *work)
                        device_list_handle =3D &device_list;
                }

+               type =3D amdgpu_ras_get_recovery_event(adev);
                list_for_each_entry(remote_adev,
                                device_list_handle, gmc.xgmi.head) {
                        amdgpu_ras_query_err_status(remote_adev);
-                       amdgpu_ras_log_on_err_counter(remote_adev);
+                       amdgpu_ras_log_on_err_counter(remote_adev, type);
                }

        }
@@ -3406,8 +3423,11 @@ static void ras_event_mgr_init(struct ras_event_mana=
ger *mgr)  {
        int i;

-       for (i =3D 0; i < ARRAY_SIZE(mgr->seqnos); i++)
-               atomic64_set(&mgr->seqnos[i], 0);
+       memset(mgr, 0, sizeof(*mgr));
+       atomic64_set(&mgr->seqno, 0);
+
+       for (i =3D 0; i < ARRAY_SIZE(mgr->last_seqno); i++)
+               mgr->last_seqno[i] =3D RAS_EVENT_INVALID_ID;
 }

 static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev) @@ -3907=
,23 +3927,52 @@ void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool st=
atus)
                atomic_set(&ras->fed, !!status);
 }

-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id)
+static struct ras_event_manager* __get_ras_event_mgr(struct
+amdgpu_device *adev) {
+       struct amdgpu_ras *ras;
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if (!ras)
+               return NULL;
+
+       return ras->event_mgr;
+}
+
+int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum
+ras_event_type type)
 {
-       return !(id & BIT_ULL(63));
+       struct ras_event_manager *event_mgr;
+
+       if (type >=3D RAS_EVENT_TYPE_COUNT)
+               return -EINVAL;
+
+       event_mgr =3D __get_ras_event_mgr(adev);
+       if (!event_mgr)
+               return -EINVAL;
+
+       event_mgr->last_seqno[type] =3D atomic64_inc_return(&event_mgr->seq=
no);
+
+       return 0;
 }

 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event=
_type type)  {
-       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       struct ras_event_manager *event_mgr;
        u64 id;

+       if (type >=3D RAS_EVENT_TYPE_COUNT)
+               return RAS_EVENT_INVALID_ID;
+
        switch (type) {
        case RAS_EVENT_TYPE_ISR:
-               id =3D (u64)atomic64_read(&ras->event_mgr->seqnos[type]);
+               event_mgr =3D __get_ras_event_mgr(adev);
+               if (!event_mgr)
+                       return RAS_EVENT_INVALID_ID;
+
+               id =3D event_mgr->last_seqno[type];
                break;
        case RAS_EVENT_TYPE_INVALID:
        default:
-               id =3D BIT_ULL(63) | 0ULL;
+               id =3D RAS_EVENT_INVALID_ID;
                break;
        }

@@ -3934,7 +3983,13 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device =
*adev)  {
        if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) {
                struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-               u64 event_id =3D (u64)atomic64_inc_return(&ras->event_mgr->=
seqnos[RAS_EVENT_TYPE_ISR]);
+               enum ras_event_type type =3D RAS_EVENT_TYPE_ISR;
+               u64 event_id;
+
+               if (amdgpu_ras_mark_ras_event(adev, type))
+                       return;
+
+               event_id =3D amdgpu_ras_acquire_event_id(adev, type);

                RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error=
"
                              "(ERREVENT_ATHUB_INTERRUPT) detected!\n"); @@=
 -4668,7 +4723,7 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *a=
dev, u64 event_id,
        vaf.fmt =3D fmt;
        vaf.va =3D &args;

-       if (amdgpu_ras_event_id_is_valid(adev, event_id))
+       if (RAS_EVENT_ID_IS_VALID(event_id))
                dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &va=
f);
        else
                dev_printk(KERN_INFO, adev->dev, "%pV", &vaf); diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_ras.h
index 0fa1148e6642..88df4be5d122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -68,6 +68,9 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */  #define AMDGPU_RAS_GET_FEATU=
RES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)

+#define RAS_EVENT_INVALID_ID           (BIT_ULL(63))
+#define RAS_EVENT_ID_IS_VALID(x)       (!((x) & BIT_ULL(63)))
+
 #define RAS_EVENT_LOG(adev, id, fmt, ...)      \
        amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);

@@ -427,20 +430,25 @@ struct umc_ecc_info {  };

 enum ras_event_type {
-       RAS_EVENT_TYPE_INVALID =3D -1,
-       RAS_EVENT_TYPE_ISR =3D 0,
+       RAS_EVENT_TYPE_INVALID =3D 0,
+       RAS_EVENT_TYPE_ISR,
        RAS_EVENT_TYPE_COUNT,
 };

 struct ras_event_manager {
-       atomic64_t seqnos[RAS_EVENT_TYPE_COUNT];
+       atomic64_t seqno;
+       u64 last_seqno[RAS_EVENT_TYPE_COUNT];
 };

-struct ras_query_context {
+struct ras_event_id {
        enum ras_event_type type;
        u64 event_id;
 };

+struct ras_query_context {
+       struct ras_event_id evid;
+};
+
 typedef int (*pasid_notify)(struct amdgpu_device *adev,
                uint16_t pasid, void *data);

@@ -947,8 +955,8 @@ void amdgpu_ras_del_mca_err_addr(struct ras_err_info *e=
rr_info,  void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);=
  bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);

-bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event=
_type type);
+int amdgpu_ras_mark_ras_event(struct amdgpu_device *adev, enum
+ras_event_type type);

 int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);

diff --git a/drivers/gpu/drm/amd/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu_=
ras.c
new file mode 100644
index 000000000000..e69de29bb2d1
--
2.34.1

