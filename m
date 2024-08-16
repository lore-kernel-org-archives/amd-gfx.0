Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 20:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F31910E83F;
	Fri, 16 Aug 2024 20:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oDafG2O2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E51410E83F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 20:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMA1rhD6U22wH8ZUNdAL11MD3X8EfCtgFTCFoXpp+V+JUyn0XSFM6QMEEBfkVzJt0RIYS4jN/JtIcAQT2YkxZFa4GObCtbttNJN7dpREEA8f1M6bTsr0DP1/bmqWLcAXV1nnyA9j7eFrz6l+2YSPo5UralswsguEp/iF/rvSB7PpJznwbG+pxU+boEjkRNR9S9cPZRNmkQB5+XUd4QTZZN9J714lDgCwXzeIL4jy9IOgdnXMiaWzAzazFYWapsOfIzNjIFk4lc9gF2wyFSF5J4aC+ld5LXCn+CHCDsI8qx+VKQuYLrcQPc8zyzuk3kXx01TYP7L4UKoOMrnOngDalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/c5ap9JSXIWcU2yESu3HXe5NG6odg7V9j0dOGtKkaY=;
 b=gO6tM2RiA/PJYTDGEUdyJ8vkaeXlwWy6QXh/s84EZrSJA2i98cKriTDJ6zRv05YgNTPhHEgOjnOB5R/Qdq5GgEA8qaTJlc2Wtk4xeUYO7r+K5/WGzABYfQdbZKOTSQawYmYX6i9L7FGXI/ShlrSXlKaZbW2u+RbxIrl+YpQ+9rQOr/2H5T51Tkk26FspgNgGtSKs7fcvICkzKT+0Z9vFzabGmVu0DAZrN6BjJv9jG8p7s0zSjR2BJ8DasJy0qBQhQFqLwzpOeHhndJMNs05VKFOUFu6yzzB/mr5obpENNZ8GitnIhCJBaRkwbG0+GqkfQvb3YF9+DIwdXflo20QPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/c5ap9JSXIWcU2yESu3HXe5NG6odg7V9j0dOGtKkaY=;
 b=oDafG2O2xYMpf9oA+d7yMOrA5cvRD6J4XT/VHHjKQSSx6FezZ0Ey0xAQTFKuiTVXxz/flVpC7tBcJ6vX/YsTT1ELqPFhOVN5dDvz0dEJXCscQGYx566aX9rTBW2vfW8j2jkfwl9dHSOQiDVqr6dtK9o9L+NquePjLh9NiohQa+M=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 20:04:03 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.7784.017; Fri, 16 Aug 2024
 20:04:03 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCHv3 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Topic: [PATCHv3 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Index: AQHa8AZrOXZ6SHzWA0OwYRJRgYwT5bIqTr7A
Date: Fri, 16 Aug 2024 20:04:03 +0000
Message-ID: <CY8PR12MB7099D5917FB47DEEC9C2F7C98C812@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240816180138.1171558-1-mukul.joshi@amd.com>
 <20240816180138.1171558-2-mukul.joshi@amd.com>
In-Reply-To: <20240816180138.1171558-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cd067875-4eb4-445a-9477-f00c4b8ce4be;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-16T20:03:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA3PR12MB7807:EE_
x-ms-office365-filtering-correlation-id: 461f0d82-998e-4e89-5638-08dcbe2e9373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s+pZhac8SRZlMFkqIlFfhhYGGKk8Cxd+4anP2bfYITqblQbTeGQL7CS9Pr7U?=
 =?us-ascii?Q?3qhn4qqO89JuENcrWhx2czl1Ov1ho6qb9qvQqIxc3jIg8bRgGnIkJUw1Oe5T?=
 =?us-ascii?Q?UKZKzcHC3oD8MUSS0hib9YDWvTYFiEB2YGI49+8mSURKA7t9voa7IttgFmA/?=
 =?us-ascii?Q?BZq9CBshV/0bKgU4RvDYEzW3Wj+5A/6nSAyeDwrAdTowYldHb4C0oteXuBx3?=
 =?us-ascii?Q?VYkfIGKyMsPnet/qd+5sj2fSMA9YR4jxHGIcxfLABr6YPE2wZmoZvVc25ZUC?=
 =?us-ascii?Q?3AxCqB478wnKBSapgV6Uu8Pn7h801kE0g+2vOdeoeBOvPAXrETK4Zn+owWF5?=
 =?us-ascii?Q?CTFjW9ofJlUsvHqmYNnUm3X9ISI+Fjhb5Yooz10mYDHb0wklsjJiXu23OkYp?=
 =?us-ascii?Q?YBRCDDdf8nojro5Vt2ZT5//GOYY2S/ZtT71C9olY+A31yWPAZApormqb50dU?=
 =?us-ascii?Q?80UOgpvg3uNnrAAAJKH1mqluvbHyGlnpnUCr6nto4G9omHFC6EVuAKSYvPsQ?=
 =?us-ascii?Q?5QT0uoqS2+FxS1V5vQ89HdsDrD0dTfQtm82+s5hc9i3WCaArAxeiX+iPhadZ?=
 =?us-ascii?Q?/7mpgOPCxJWqB9ywbuRbLDy3VNFYqpIqVWBAv00h0N/UrDBz4he6OVsWYx9v?=
 =?us-ascii?Q?9AGHn3MItI09O6F3v8wl/cFzrpa3EhFFlT+2yM8ltHT7/zb0cRrjRSYqv7R+?=
 =?us-ascii?Q?s9g7cn0k5FNVhfEX1eDvFT6hG1e5gEAIMGnAphyR8R6oNZL3mNisF1sYqXKC?=
 =?us-ascii?Q?Ml/TZixZGBj7Xb2iLyoa4EJyZJtulaIXVRdF4u9Z+8G38Hogw0pYkoD5rRRN?=
 =?us-ascii?Q?JOfQZ+ubxeKpcApT/JAiuWSKbKsH9gdtIbUexqWyG5QcB8y/b/sBFw3535WZ?=
 =?us-ascii?Q?gY85GCLFi8vBRHi2lUTRBn4w9niMUUqKKZWfG28jihy/u+lnGrZaCDiaUnPX?=
 =?us-ascii?Q?owi8mZN7BEnt6WYlxzfAvM7UuD+KuiWNBFQThch420mhWDUIlwSsyvNnDE6G?=
 =?us-ascii?Q?SLZ/TEX4LGx4Rq6x9YYQamOCMgLySV2A5vLjVCrthSK12kAMzbxi1lNgGA3Z?=
 =?us-ascii?Q?+4xAKT/XcbVawK7/J6iOr+CG3HrhltWIUZTSKFHez4WqOo9MxGRdavtA3tnb?=
 =?us-ascii?Q?OYptd2wcnFzgEs6s9zw1+O8Ib/yIwMwMasX2FU/1Kvgmw7cB6Z7sFv2Qr7R7?=
 =?us-ascii?Q?p2dArSFFopvG0+0DlCEJQsfUiRsn8mo2j4nSJ0xneBEoBuSDi6hrpfI++bRs?=
 =?us-ascii?Q?3qgMlyRzfnTMfiDCurL03jTNEQe9DxIvLiwuUwIWB9C5MmegpZjg/4DwYO3O?=
 =?us-ascii?Q?OYBlXpdDdNN1G4oV6lVvo9UlmWJk70xEANCB+CniDNL5SCoYdaAWbWirokHm?=
 =?us-ascii?Q?HtPgOxH0VkMUGobeqvi4hLSqpKXUwn2pKg/afmgF6TiVFGfUtQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QN4+5u/PqVnPx9BDfMlPQcm6slv8YyJriGoTevGEAKvS1kNEP9zNXN64biYq?=
 =?us-ascii?Q?GN2a1Ko54E8K4DaRfn6jGvsQvLvDhnhiDOvGiCm+7xEhn8qFAR/EQXhqL8wI?=
 =?us-ascii?Q?3q/IQ0XPDBEN0vS7rPgZXE+8cAU0jr8CpVtXILoOLqE22t18Cr99YPrbuOv7?=
 =?us-ascii?Q?sRvfFmkBaMRewLNPDb84isdu1cD0s4RyM5FZrV2KwBiaIbeNfV7mf2622QGZ?=
 =?us-ascii?Q?DTNyuUI4cgF2xy1AlsidH9ysyAJPQtBbMhfl8CJbUaHnU/BWNp4lq2rpdJ/8?=
 =?us-ascii?Q?jreHsRVBOkXdy9AQ6H6bfLckljXvI36udjw2uvcRU1EjB+gtd/O4S7BDxd6o?=
 =?us-ascii?Q?JBiRZVJg9Oq/x4qdxb1buGKUJFMezjYn1MyY+XgPg5MutNLyysW1DrD6to98?=
 =?us-ascii?Q?ZEN9lVzUfUOGgSpCt4v1jjD+qX4tRrN4wzTTfouLaaqe89ReOPZvD+oA5taR?=
 =?us-ascii?Q?iGprSEoxeLZKA06d4ubpgKBvuQAQPjbZ8oEmqSprTnuvj2qKwrqsLn5UKF6n?=
 =?us-ascii?Q?I96np0u75EUg4qnw7IdmxKUsz29DHJzIzPc+f0QYhX3J6abquUm+CnwImQcm?=
 =?us-ascii?Q?GwNpQUoWi4pXHq3HzQphtewDeSSTEvMB1bvcZ6mgRnijeHRYdZGJkbF6Ajhs?=
 =?us-ascii?Q?7TsTjfcWaACjYwhIU1l4PaSM/+iAu+fDMV4RoypOZGok7vl83TCz7RuIUyh0?=
 =?us-ascii?Q?cxrP+ixVkHBYq8IwrD14nrbACzsDpq/ryUsYsXobPLEDYnb0c4hGC02ddm0B?=
 =?us-ascii?Q?MHqtQ7leUjsVsXG5ErF5f3smQXGYcvgHRWNWboT+/sz8pFi4z4E/Zp/PJKEO?=
 =?us-ascii?Q?tqNC3UDLhLd+cfmL7uHRoXVCV6iGbUPlVHX9OjRkDvo9ck+Y3bUeRFL/ZhTm?=
 =?us-ascii?Q?dAWC+pdqkoOYDMj6K/YBOxzGL6N3MrPGrKPwpASrTdr7UjK1A9R1yF9h//16?=
 =?us-ascii?Q?L6ykb0D/d/laTj5+GoDEkc3c5VwsQeNRI/SBAbq9E7iER/f/1x0Oe2Xwlom9?=
 =?us-ascii?Q?SN7hlqcQLCsJ7JyWPkR8grozECfZPA3dJIBZZPfMa4916VbTEGQO5GtnM6nd?=
 =?us-ascii?Q?STm/FK2fcZyGtKowivbNzuv9Qs+/IeqWCUvGGDvM1N2DI4IGkjYl9MpY4m28?=
 =?us-ascii?Q?NGyb+XlXVlqZiPpET49jVJVhAhUXzt1VOdx/ZL95Ffq91qNSlJAEpjHVCi4n?=
 =?us-ascii?Q?dKIZf3QqK1jilFEGPIn4P+jOgiTTPxhqx7oUJ6TzRsG2LGxaO7pJeOyvUg3f?=
 =?us-ascii?Q?t4d8p8tN3SVzL3tH80kgqIIA95T9TeM1PNqlXbT8WA171noOEdrfS3DvVtTA?=
 =?us-ascii?Q?QUro/nhVLsM3tz+PIMm+0EU0/u0soc0FKPU73Mt+5UkG1j2cIP7XcPvMhb65?=
 =?us-ascii?Q?WxsaNd8MxWBesBtm1AfBDCIjpP9H3Z7+aLbvU1lTzn1paVxhLDQqQTcdlt0/?=
 =?us-ascii?Q?RjmAO1vtYuks5OL7VLNkn0bWAziQ6lPIm3xSu7rAsWAdgud2+hoMJMZip4Yk?=
 =?us-ascii?Q?4dRdBTKXv+RNETiMbJ3Q6E1IEI7hakOEeAsof7o9RZ9gbhXEGXcfBdjPapPh?=
 =?us-ascii?Q?8pvr4LSGi6YNG9k8Sic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461f0d82-998e-4e89-5638-08dcbe2e9373
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 20:04:03.0829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXvVvMq4AhomOI2XpePay2QmiGXeOOiuGGKDyk58bCT1PXR1Eru7Q/Z0ySp+bZ0p/fSq2lWKbj1vToSBwxBQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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

This series reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Friday, August 16, 2024 2:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCHv3 2/3] drm/amdkfd: Update queue unmap after VM fault with M=
ES

MEC FW expects MES to unmap all queues when a VM fault is observed
on a queue and then resumed once the affected process is terminated.
Use the MES Suspend and Resume APIs to achieve this.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
v1->v2:
- Add MES FW version check.
- Separate out the kfd_dqm_evict_pasid into another function.
- Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.

v2->v3:
- Use down_read_trylock/up_read instead of dqm->is_hws_hang.
- Increase eviction count if the process is already evicted in
  kfd_dqm_evict_pasid_mes to make sure the process stays evicted.

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 87 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..0ca933d2099c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,6 +319,46 @@ static int remove_all_queues_mes(struct device_queue_m=
anager *dqm)
        return retval;
 }

+static int suspend_all_queues_mes(struct device_queue_manager *dqm)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
+       int r =3D 0;
+
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EIO;
+
+       r =3D amdgpu_mes_suspend(adev);
+       up_read(&adev->reset_domain->sem);
+
+       if (r) {
+               dev_err(adev->dev, "failed to suspend gangs from MES\n");
+               dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n");
+               kfd_hws_hang(dqm);
+       }
+
+       return r;
+}
+
+static int resume_all_queues_mes(struct device_queue_manager *dqm)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
+       int r =3D 0;
+
+       if (!down_read_trylock(&adev->reset_domain->sem))
+               return -EIO;
+
+       r =3D amdgpu_mes_resume(adev);
+       up_read(&adev->reset_domain->sem);
+
+       if (r) {
+               dev_err(adev->dev, "failed to resume gangs from MES\n");
+               dev_err(adev->dev, "MES might be in unrecoverable state, is=
sue a GPU reset\n");
+               kfd_hws_hang(dqm);
+       }
+
+       return r;
+}
+
 static void increment_queue_count(struct device_queue_manager *dqm,
                                  struct qcm_process_device *qpd,
                                  struct queue *q)
@@ -2835,6 +2875,44 @@ void device_queue_manager_uninit(struct device_queue=
_manager *dqm)
        kfree(dqm);
 }

+static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
+                                  struct qcm_process_device *qpd)
+{
+       struct device *dev =3D dqm->dev->adev->dev;
+       int ret =3D 0;
+
+       /* Check if process is already evicted */
+       dqm_lock(dqm);
+       if (qpd->evicted) {
+               /* Increment the evicted count to make sure the
+                * process stays evicted before its terminated.
+                */
+               qpd->evicted++;
+               dqm_unlock(dqm);
+               goto out;
+       }
+       dqm_unlock(dqm);
+
+       ret =3D suspend_all_queues_mes(dqm);
+       if (ret) {
+               dev_err(dev, "Suspending all queues failed");
+               goto out;
+       }
+
+       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
+       if (ret) {
+               dev_err(dev, "Evicting process queues failed");
+               goto out;
+       }
+
+       ret =3D resume_all_queues_mes(dqm);
+       if (ret)
+               dev_err(dev, "Resuming all queues failed");
+
+out:
+       return ret;
+}
+
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
        struct kfd_process_device *pdd;
@@ -2845,8 +2923,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manager =
*dqm, u32 pasid)
                return -EINVAL;
        WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
        pdd =3D kfd_get_process_device_data(dqm->dev, p);
-       if (pdd)
-               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+       if (pdd) {
+               if (dqm->dev->kfd->shared_resources.enable_mes)
+                       ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
+               else
+                       ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qp=
d);
+       }
+
        kfd_unref_process(p);

        return ret;
--
2.35.1

