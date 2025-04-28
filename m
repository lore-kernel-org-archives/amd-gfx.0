Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6102CC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 05:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CF310E0D1;
	Mon, 28 Apr 2025 05:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="skj/YomB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C8E10E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 05:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSFj+50b+UX4UQZ3kDvy+FhaSntkHX6EJ34dvVLxmBqDOQfelP05WVfrYztAY/uJGX/lvr5C92bMaHIFJQbhxbyelUfTgGsn6nqDU+DvSDqWaeczrnOFtYGh1VMfuSDOrwfnrHj0n04zCWcH7VfVe6W0t5QXyQpDCElKftRG0Nlie5Ocez3VIX5fl4V+yXvNBgKeZXxB+rSWbMdla26T12EGrK+OFnWMtt0HlfLPsRwX1kcyykMGhf3A3H8nJZ8U0ZVL7ulaCMWLwGm+rMQQmlHYx+8+JtiApVaA8EyUV4wS6Qnu+3cCUboh65CxLoDyj4Owapdo4KqcewtL8n6WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGJ37+69JpW6WWTTgjlv8xEWm7WGllkXmc/dIFhXwIo=;
 b=s8gPUGlAfCn38KTxFQ39crEEv4dSCsZKwLgTpEr4R+7ewGoq3yIGDlBjxhjxtXlrveBYMXrrGnQvaIfDG9E9ckIuSSApiDUmIYFws7sVl8U9/Gmci0LFkMc5IoS3pvWl44JJaULvuNYutpVWBfw8qjrJN5VECQJIbMBrLwXwW7G8JIMTGpCOKfMvAL6XuR/CS7y061vDuGR/oAis4EPeoNxWFcIGx/OKeUM0DjNHFXM1BKzd6pvmxXUppwB1eqb3Y7QBwTO72Rju2KVVCxphpvWWLyfbH7TMHYfiR10wcLS9imTsy/MJHvjchCglpghOFuY5PEZ2M/auo3YQscZytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGJ37+69JpW6WWTTgjlv8xEWm7WGllkXmc/dIFhXwIo=;
 b=skj/YomBkDFBJrIAoqhqu5b19apE2CuXDB5AhmpKn9v/uO48+QZcVBAiz+CBFBGZD6Tyf644hFTOtwZya1v1UwVQtV0YHUhZNBr2CZ/0WD/T1/HBhtctOaHTiOqpupXRadeFHDVIQ/JaK2FeLEbyKERaU2DK20aeNlZZqoqsOLc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 05:58:21 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 05:58:21 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amd/pm: Fix comment style
Thread-Topic: [PATCH] drm/amd/pm: Fix comment style
Thread-Index: AQHbt/rswBddHrXfc0KtgFLM0MMVErO4lQ6w
Date: Mon, 28 Apr 2025 05:58:21 +0000
Message-ID: <PH7PR12MB5997A97449A510134F073A0E82812@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250428050311.946659-1-lijo.lazar@amd.com>
In-Reply-To: <20250428050311.946659-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a49fe361-844c-440a-ad58-8a43bc3c7ab5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T05:58:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB5961:EE_
x-ms-office365-filtering-correlation-id: c1da42cd-ebdb-4c84-5383-08dd8619ae7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?m+WXrYtHf/gxIseKZExoeMU1hETSjCo3GsmjyOLlo8DwT7Pzw/44Vzo5Yg88?=
 =?us-ascii?Q?aAdkhArTkAeIpl0lPF1g7mkp7h2wPBwm+wzzNCwHndirdGkIGaU6mq+75h4F?=
 =?us-ascii?Q?nQfPL/TzgUJku5Ka5xNFSu2feUIfVMa5jskNRpJcAqDuQ3PrjKdfqcP8LVlf?=
 =?us-ascii?Q?/Wp4N5TGFr7MnNWnq+31SvDaaxIewRt907RsqeKw/Iiq1nH/Hv375c+k6/km?=
 =?us-ascii?Q?NEDfOZY2yG7pPMhJj/FdgzTH2ItG5x9ixBp8lGvUVbyJDs/EsyJMujol12cR?=
 =?us-ascii?Q?556nsbqa59C7Emz0Orgqc7bx1LX8vbBvx2vnHPc4bpTKAbROEcyKFc1NQklO?=
 =?us-ascii?Q?+F5GPfwncwU2EgtZTxKaki55ZuETVxlcZ8ObIUrMdo1h9YLmjrke7CMmj9a/?=
 =?us-ascii?Q?IYgD6wSSv0mL5N/Q3QhTD+FNjdgegt5zf8q5MSBtjy7VfqKigce0IwHZz1j9?=
 =?us-ascii?Q?blZjuZhVHRCO04O7D84ZuY8T6O4dfA68R6ynvBXHitCGDttIsFiTwnzYO+Mn?=
 =?us-ascii?Q?yB5thHLGjKdaXiJpm19I2Q4iUDEBi6ZhYio8A2Qb0r/5AM23jyUw29V9wo09?=
 =?us-ascii?Q?v92YcMu9/Tv8Z/9ArcLc+9u9mGNV2j1La9F8yLqIA6jrDJNDPM9FBB//N9dw?=
 =?us-ascii?Q?d02KnyyDTnfvzNXECZYy+BM+jt4R/zIoNP92dqmGS5aEkf6V2tozb0DPf81G?=
 =?us-ascii?Q?ehh7pAZc3PDKTe12KKYWIE2rqeQbNUseheknUbJnvekgT+vbObvNogkxCSIU?=
 =?us-ascii?Q?2VMqDCdmQOp+/tKDbNLl+ySPN6jHrwxLN1B82m20Lew20m4QPa/f11Uxnzxb?=
 =?us-ascii?Q?3nawuzH1ySmPq3K2TCFBazkEO3zKUNxkYFfyfRgsOSNX21XhjWJyKqstXYKW?=
 =?us-ascii?Q?5MJvq3RBen/byxR5UyZadiyVvMbEEhs2131viRm4Aq2c++IUWFUJEQjyqSL6?=
 =?us-ascii?Q?jI/4GoUgIPxskKOi9GW1cS3P32nvNjMmhjXkbIHdMWsRCfZ7Wzc16b3C0joZ?=
 =?us-ascii?Q?0vURNJCCkXnN9X5O1s6CGokJI32qFjY64kC3vF/3OiEfgTN5Pi0gpiwxJCW1?=
 =?us-ascii?Q?9jbnnoHmbg9bY0/LNpk6osSiqv2jYKxIB/07jO3l8TzOhbf0MyEMOUAuLT8N?=
 =?us-ascii?Q?IT/xNBvY+3GGI7QiJ2PMrtaF/wPuQPlwQ+CowrrlBoZOSkrumoQs3UACziRU?=
 =?us-ascii?Q?k++F+lXRBKadmlrbJDyGGnhIf4cUyNZpseh6+SMY+z7ZLL3Cv4Vgjzt+KNyN?=
 =?us-ascii?Q?9gUS+0skSqQGB+0yw99EG7KvSjlOGSADO4eOH/RzkNKXPTFJM5l4tQNRQDEW?=
 =?us-ascii?Q?4cFUAYe6ZIjZaZWUKWV9S8NsdY3glmPc0Jp2YenYL5mB8Ysqhd3Zkv1Yo6Og?=
 =?us-ascii?Q?eq6QTmSfJHXwfzMnj1WpyzzYwfxsHe+4ZGwJ3NPEMkcaVZs29juk1SlTfDX7?=
 =?us-ascii?Q?h7ziT/hc7UJwGUPZwSG8FBXU7eKomi8iRyWE9TFw1OxsftfWnEgTEXtN27c8?=
 =?us-ascii?Q?2ToRlNVSpXd4ycc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yg+V4ERmPjqkR3xk3iECSXsITKzMfVsbo6jB2K9XIk/UY+jUYxzQbb0qg0Px?=
 =?us-ascii?Q?B/QVzLYdOp4//jNrEdugFRrC3iEtQg72f/aNriEJ773Uut7BQ7/DUaaQtdPb?=
 =?us-ascii?Q?PVQl/5NIAL8/m820Hypl2MEzrmwu67p8tbjAtLrjTbGNyWUywPdOR9q4273d?=
 =?us-ascii?Q?gI0787Y44NLhhzZ5Y8Sci+F3a3BKdhZYkTyhPDfJoIiz6jIHJ9W6tv6Q5x37?=
 =?us-ascii?Q?x/Qseq0fD5T6LjYGaekjrg2iIbUOxfE7HA0QgifEKretLP4Pus2bP5BDPsl5?=
 =?us-ascii?Q?CHeSjZiNJPyx6VRHJcDQpkUr6q8GFc+MGHSfpj7zBF3rXpAyU0LNYP3JO9rp?=
 =?us-ascii?Q?rpIdmVvzqySuo6ktpwQrr1cnu1JIG2ODa3o45IYyndBBNBYeLqCfrUQcoyYt?=
 =?us-ascii?Q?/Btq4pNvzTkxM1/xoCjo71reBbuvqYeBRYkUC62iLhUrsDJ8OKfOgbLdZIwx?=
 =?us-ascii?Q?stzutIaDS3CwD3Wtlv68QYbBef1/pc6fVMdY/Z22Dn4aP8zyILV0s8yILPm+?=
 =?us-ascii?Q?HWJuhTXVDU85v/4+vMjE64vtDDTQhTxzt9EPpI9gmAihWBg844nDZakGoOsh?=
 =?us-ascii?Q?wznAAntf3ZhT4hFDr15QTj+1PyIrEhWqnkc8R7FmPSWoYEps3ig7ETWWPsGS?=
 =?us-ascii?Q?S1K5pZyAj1mIs1rdkx53tAeYWDyjY58xQURpJ9xUFYE42ATDhFRRr+IWM95G?=
 =?us-ascii?Q?12fNOpiuIn76pKSV9MOAGRbTqNP83yF4JP4AZtWw5OARUMkOBK0TVnDIYdMh?=
 =?us-ascii?Q?IvJ4054jvlTJVbUCtE0Sz/gMUe4zWPiasI8pnrqVlBMi1FNMrwA7UKulxpgE?=
 =?us-ascii?Q?G8W9xdzolprUeK9BDPSfairjQ33F1h7a27TmjuthZC5kjdJrNnQVrjKhQ8sF?=
 =?us-ascii?Q?BgNSj1FLq5isAZTuMAQzwHq1IvTQ5rZzgiXK9Ouf5GfZAwMEFScOWFiY05L5?=
 =?us-ascii?Q?a0dgkLsHRYdCLGc/Mb190F+QuhzBveOd/kgQLoydiyL0Jj1HIdN8z01wRFI8?=
 =?us-ascii?Q?10P2pC0lw5y2i6mEVxtRlGMawIFPLn8Vctr0KXgtsJWywcIzEb9go57EBLVU?=
 =?us-ascii?Q?l46+yzaRI0H3YgVI/t2lVg/CUHN0+Vq6vdyi1zYLDzvLYfI287H/y48YMr0Z?=
 =?us-ascii?Q?8RLFDq3sDEDWIoh3vJ8+XlrD/y1PKrU5QAsdyZl8Yovp92KRMjuSmPCYOkS/?=
 =?us-ascii?Q?9sCSKuFcR5bDpPJrhSeE6il7zHfNNyD3XdzD0HJ8dbtPYhatFk7Iu+K91Sa9?=
 =?us-ascii?Q?GQE2AzUgLPkLa3VOFBhjfKnOwSzWNk/4wBM8ldFr6TXnB2rCELPaV7qV3iV0?=
 =?us-ascii?Q?VbEuBzP6/244J7ljA1RSZeVKqxQVRPT4NsGv/Nc6b0oRuwLWrG+9ILq3lYq7?=
 =?us-ascii?Q?c2KXrwb75M/2srLjU1cULJz1CMtNPkSwPJ09wCKq9EfCzluXmOJTYm8bZCtI?=
 =?us-ascii?Q?ib7Xtvzz+3CNC38keHz9SccOPmp8tXBGhX6E13SHbJ1tdtwBi4z+jbKPgBom?=
 =?us-ascii?Q?0f/sUgVpZiPI7f4I/nxILkW3MzRvkB83CaYIT0Uj+yQr1/BRoBc/cspPeu8m?=
 =?us-ascii?Q?QdUG9gNU54QLTybD4dk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1da42cd-ebdb-4c84-5383-08dd8619ae7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 05:58:21.5717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4sT2RGBdkc6+l5zzGjgvNUtMXgQ0xN5rAdHfysutg+FI+H/M15h0OanW3koP5j0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, April 28, 2025 13:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; kernel test robot <lkp@i=
ntel.com>
Subject: [PATCH] drm/amd/pm: Fix comment style

Fix code comment style

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504271422.D6cqMlZ0-lkp@int=
el.com/
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 453952cdc353..9ad46f545d15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1347,7 +1347,7 @@ static int arcturus_get_power_limit(struct smu_contex=
t *smu,
                *default_power_limit =3D power_limit;
        if (max_power_limit)
                *max_power_limit =3D power_limit;
-       /**
+       /*
         * No lower bound is imposed on the limit. Any unreasonable limit s=
et
         * will result in frequent throttling.
         */
--
2.25.1

