Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4872C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E4310E2D4;
	Mon, 16 Jun 2025 08:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgZ++EfV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4743110E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 08:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fW9Zq0lOW1/4Q2Os3SN2tOqxwApZkEBsqnEn7Y/EMKAQCSQcvttascbKThDHr6wzlaYwuTcTj55MFU6xu8iCbT9bs4ddJk0uob1gOlknf3yOZ0u3bNcUCsg4kKw6rqGOCCjEPK3eo3kf/BZj0dc+lq4O2eu/4hRjaGqb4Q18gSPwVpAwJPDobZcNUsDCjNYaWW6Zet8z5LDearzfoowtA+tE+YJweXC/DkymBs5iJY4wSvsIypuW50OHzCdo19d0vAzSGqQRZWgMPWLgp+ncHP/4Nrp6Mf1IdDGZfsqjI27/NTzjuhXlFqhenoNt1+APffsN+4GyZaTMa7KhxCNqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY4O1JtJf58VNFnK0sew4HexBK6fw1tkPUM7eaCDNfE=;
 b=MbtV+jI2p7en82Kzv775JE7U9FjBtuxYAy/1jN3y2q3/cabWnZq85kbfVfJZAwAPvAMuDM3IEC5YYEBjS6+ZXr+lrXo/6qNkFrt957umUhM1yfn8GBFH4VLXopd0kxj3wcGCfUvFJ6PDXMuS0bp3EJRV8S8GHVIJRPxhVLoeO5hPYkptd6WJ5pyDGPZG6mbsSMNEMEJfzgE/M1sqjYmmCH/2vdN2IjyClEwUovm1oO8Yec2SHuBF27ttbmES6MtscmCoNayxxNLIC1IYEph+o+wXWk91B1J1XsnKqYyV73MW6untruGDvTnW5Gr77XhugV4UFuovAfePAtW60Dnr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY4O1JtJf58VNFnK0sew4HexBK6fw1tkPUM7eaCDNfE=;
 b=FgZ++EfVzIRN3/xvylwuXIM5zcJ966u6pyccQGXqvAHT07etawed5mzNtl1QyHclkYTb3LYhagnLGQfS9jKQ3PQ4qA6/KiMfgcw1/Gn8GhBe1fEQZrIpbGjt5wqH8W3s9bfj7RaBegtoFEzCJ/riuoZRAQ6b0KbaYcOJ5OeN9jE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Mon, 16 Jun
 2025 08:05:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 08:05:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Release reset locks during failures
Thread-Topic: [PATCH] drm/amdgpu: Release reset locks during failures
Thread-Index: AQHb1rJolSHGAHVuzUay0LNl8cItkbQFfW7A
Date: Mon, 16 Jun 2025 08:05:45 +0000
Message-ID: <BN9PR12MB52571BE3C0AA9BF1A85AFD77FC70A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250606071234.146175-1-cesun102@amd.com>
In-Reply-To: <20250606071234.146175-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T08:05:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5876:EE_
x-ms-office365-filtering-correlation-id: d58c9bfb-a2aa-42cd-a5aa-08ddacac98df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kOxNSZZbaFcvHSbj+n1hXuFkMV7jkr56L976GiDfLb4zLnR3sDUD4/UAP52g?=
 =?us-ascii?Q?7waWN3EdmTiehV1vBYeeRj5onFN38XEp+0kR6IhVjfLs8LHFQHHLMMsFoyCg?=
 =?us-ascii?Q?Tyy9m5rxrajVwO5ukdlPaKJeO/J3rZI9YWiplW+e2KRgHo1wFkfec15XVAfA?=
 =?us-ascii?Q?xN1YmqZ/qn1WbncbG4EnR97artAzUk7ihgh2UvA3wR9zBxZjUjOfMNfbsEFr?=
 =?us-ascii?Q?iYJdODF7qnt/kfDA6NkmDbzjVdzozBcNDr6TK5vL5F1Z1wXWwVeGiN9k4iku?=
 =?us-ascii?Q?beaPoFKaPrDqBKIjND9vmHqgfmmRV8RgTf6IOVT98mx8e5Hvt0ejZAxHDgqh?=
 =?us-ascii?Q?fwdyO8ArvO299UTDZq6jXDhd8esTfPVYQDxqdbpwJIXiH5HAqk1sfkcLZ71x?=
 =?us-ascii?Q?xJK3I2irkvoRY6ZmoLmsxp87qA15GEEvdN4fNusW7/okfDf3mkA7/AXquors?=
 =?us-ascii?Q?YmXgFcgex4uX4SOpg8VzhKdoQ0zLB8AMUAvUJ1b3nnT25FA1q0jX1O4SaVFY?=
 =?us-ascii?Q?wLK3DjskX0abEqjE3va9vrfEZ7UfN8jTq+DY+iVZKhSgR99uUT9ur/AI841v?=
 =?us-ascii?Q?kmYbWTw6x4+Yf4HQV6tJJ194CbmDHKDm9NctAjXRvL/gUSBWPTvHMrsjtRMb?=
 =?us-ascii?Q?wITL0Nxlycjn1CCvLW4/LXJv5jFqv+KNCUMzz64cx0mulwI4BPRBVL1IShzG?=
 =?us-ascii?Q?qedNLLMMGzPivfTHXS/p7+sqX/BxLfzRAVmAaCyYkjFdhQ0+72bA7MdYR85X?=
 =?us-ascii?Q?DT1h8LFxni4Kg46IfmHSTA12Szix1FTnNAgkBjcADrHA6YTS/IPSmlldxuJt?=
 =?us-ascii?Q?Iucru6SG/sJRizmtsuP0LaEVFErsri4FJ4GZJNwQZXZbtX2oLb4KjIxVreor?=
 =?us-ascii?Q?oKOnSZ4T6HMMAq0vNXhCHpXOpqPRzBMMZhlMGb9+d3Hvcqr0vIFM7WUZUF5t?=
 =?us-ascii?Q?l5M6O+j72PCrw36tomPE8RNarF1nnu3er6tWte9sr2Zgb7kUlDP4xiUGoIh9?=
 =?us-ascii?Q?+MZLkHe2QmBDos60Lc/Eo0DfvmbgC9r6Vt1MM8pMR+LPFLAMKBYkX/JVvYzU?=
 =?us-ascii?Q?VagHhIPNIuk8loG6eS3vQ6r4ZLsrYLcanB6tXjbYHMph182M0KPrdBTFoPKY?=
 =?us-ascii?Q?e9LJlJ6AlKl6kW0s6z6dm+p8KgCYwaoupPukWkpWDN7ThHQMJGbEkCORkowa?=
 =?us-ascii?Q?UnpH11S9Jw2eiHxVt+2JdZr9b0YBYtU5rDItsmwkcqyQtNVy9DUJRYLU/Uxv?=
 =?us-ascii?Q?xTYBEb1sV4KWhd0Fmnr3z+jfD5nOowSVqL+JBv3J2mff+79NZqCHQu04QIgr?=
 =?us-ascii?Q?ub0Bx82kCCbntlyui7hd0pbgSTZaosha1q/dXKp8qInNZuL97mpdGLeahRaI?=
 =?us-ascii?Q?/p7yks6+692+p02/ie6mTVOYQMedrv0dYUhY0WLBsSf8RAL9sxLidyrvgGl4?=
 =?us-ascii?Q?XelTWJATOOkktV2TxqcZMsRcv1NmYhP7y9ZIqJ+cM/uo23QGUz572g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Itb6iJqBKCvESfEunob2YrCRmRBC6vwnwhbrhID1rMtVLx2/L9BdrtBakUrE?=
 =?us-ascii?Q?ySxUBotHtE1miqv07FUpAKzsCk3eMzKM0LrMEaP46QYE0je6Bhpo2eYGLtN/?=
 =?us-ascii?Q?08l6XwQz/89tcrK3KNzgKfGaWQzmqnWbp1V914Yb32Aadw3CfJx8H9zR8sVd?=
 =?us-ascii?Q?YEmWRobqeMV50RkAeZckR4pIndvShhvXNyGog1e0HMJnNNruxTiX7V5bzCRb?=
 =?us-ascii?Q?oD3BCLT88Kg0CVywNrIS3aZN4SdVymgC7I0JMXvgw2+1R0LAjVGB2cvGqzBh?=
 =?us-ascii?Q?dMcaxbHxL7Gt8UX7iDy29WtpFudUy9+ild5bjgaRAYhVgIDCjebkwyUDnC0N?=
 =?us-ascii?Q?PBeVl+g3TkfrVxImZ7mmqP7f3Oscz4nbuGNtcu+p+NGcE5FmuY4TTAOBnd8u?=
 =?us-ascii?Q?SV2u0qV6rAAssVi02rj+i/Pxu0qACi20w838f69KQHEG43Y3LvDpEp1yUZvd?=
 =?us-ascii?Q?/YS29rNvaQXJBUZhEzFLOGrnxZNpGJhj7uTOV5cfCOrZEoBlF1GUPyrMHihI?=
 =?us-ascii?Q?/CT3rnMpHxkxjLgQU2kynsqAMktdr4v4K67I3HdkUdeOEXdrIhDN1+wi9yEi?=
 =?us-ascii?Q?bcO4utSywK4v+Lt3RM3SPlEZkMbkvf/jrjmNu0qy+zbqb8+n2x48QykpZFSm?=
 =?us-ascii?Q?DjEwbP7ye513qM8/L/qNvRyWzeZT6BchrKOG+jUZDZ+MCxxl6dVI1zmT0Thu?=
 =?us-ascii?Q?rZqedL5KndnNrpJD6kw6HiyIDmHxMD4xnUUPdq6dJptXdYJL9ErxjMi7SvIk?=
 =?us-ascii?Q?7HnMigP9zEoIUpFYUdKFl3KIZyxEPSDzi4TubVHZM0jSBDFTqlTj/WUivHG9?=
 =?us-ascii?Q?0q4G4C0ihDRQs6Udc8phniVDFRHp6J/RSlFU1SVh0aD+UoEzOAlhZNC4JrWc?=
 =?us-ascii?Q?Jt75f9fGjnxtEsqzDcxJz+IkT7be2IHMwOGiGEqqcN88u7hHAFBlFP5XuvoC?=
 =?us-ascii?Q?T6vcp2IB+8dIdvwZb5LuBqlgtTNsuKgS6Zvnrw6NidMvhKph55bALjCPHu/9?=
 =?us-ascii?Q?ZeULJmJXAqZ6qBYJ0EIopTWY6KU8MIZiFx1xqKhMv4V0TPbcjb2zZ9doeqyN?=
 =?us-ascii?Q?xnoW/ZQRsP4J/crnALVUDs7n1nEH75ufM/QhU4F5rlzW8gUDr4iUOYmz/UP9?=
 =?us-ascii?Q?vUVi/wNPeGKZFx7a70habdwmD9lX2Wm41YEpyVlZ0SH2t6dojbUzogM0/oeA?=
 =?us-ascii?Q?KFoGUpXcE9qVRDxCBTNOY7AZQ7dfEZV1Zmw88kIK4A9qDdsTtXNrNi7KsUgZ?=
 =?us-ascii?Q?WJWM7ump4sE+Pwp3Pu2TbkNq8ArqKI4JZfbXABhkdicT4kLrWoltazOjPh3U?=
 =?us-ascii?Q?aDojm8nBLHWZhNIqzmHaCpEnqFVI15qutN+yInQe9UadyegZarCE/tQfAPkU?=
 =?us-ascii?Q?CLXc+3dgiIRaKLThOzQTX3eo6DoxUsYWVYWeT/BtQyvsfCSxoCAm2cq7r5tb?=
 =?us-ascii?Q?KzKXrwu2LIqRNMJeUwog2W1Kdzx87CtZh2xaKlK9MFIXkAcXozP2pNtEBYBr?=
 =?us-ascii?Q?sEUE9GJUII2PXw8v7Y06Z88CFysQXiWJxb66GkJlGHPvDEMMhSg69ZRBjQ8M?=
 =?us-ascii?Q?eZs5mq79qBgbCdHbR7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c9bfb-a2aa-42cd-a5aa-08ddacac98df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:05:45.5315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbVME9HiLZdtccYmtfwdrKqeedD+5K5VN/7N643t1DyE4Ct+G6Nj4rS4oJllcTSG2Vc+eW3BHwpeuwqAW+91hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, June 6, 2025 15:13
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Sun,=
 Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Release reset locks during failures

From: Lijo Lazar <lijo.lazar@amd.com>

Make sure to release reset domain lock in case of failures.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ce Sun <cesun102@amd.com>

Fixes: 0f936e23cf9d ("drm/amdgpu: refactor amdgpu_device_gpu_recover")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++-------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2b84df8da61a..85509cd4cab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6068,16 +6068,12 @@ static int amdgpu_device_health_check(struct list_h=
ead *device_list_handle)
        return ret;
 }

-static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
-                             struct amdgpu_job *job,
-                             struct amdgpu_reset_context *reset_context,
-                             struct list_head *device_list,
-                             struct amdgpu_hive_info *hive,
-                             bool need_emergency_restart)
+static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
+                                         struct list_head *device_list,
+                                         struct amdgpu_hive_info *hive)
 {
-       struct list_head *device_list_handle =3D  NULL;
        struct amdgpu_device *tmp_adev =3D NULL;
-       int i, r =3D 0;
+       int r;

        /*
         * Build list of devices to reset.
@@ -6094,26 +6090,54 @@ static int amdgpu_device_halt_activities(struct amd=
gpu_device *adev,
                }
                if (!list_is_first(&adev->reset_list, device_list))
                        list_rotate_to_front(&adev->reset_list, device_list=
);
-               device_list_handle =3D device_list;
        } else {
                list_add_tail(&adev->reset_list, device_list);
-               device_list_handle =3D device_list;
        }

        if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
-               r =3D amdgpu_device_health_check(device_list_handle);
+               r =3D amdgpu_device_health_check(device_list);
                if (r)
                        return r;
        }

-       /* We need to lock reset domain only once both for XGMI and single =
device */
-       tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_dev=
ice,
-                                   reset_list);
+       return 0;
+}
+
+static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *ad=
ev,
+                                                 struct list_head *device_=
list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+
+       if (list_empty(device_list))
+               return;
+       tmp_adev =3D
+               list_first_entry(device_list, struct amdgpu_device, reset_l=
ist);
        amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
+}

-       /* block all schedulers and reset given job's ring */
-       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *ad=
ev,
+                                                 struct list_head *device_=
list)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;

+       if (list_empty(device_list))
+               return;
+       tmp_adev =3D
+               list_first_entry(device_list, struct amdgpu_device, reset_l=
ist);
+       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
+}
+
+static int amdgpu_device_halt_activities(
+       struct amdgpu_device *adev, struct amdgpu_job *job,
+       struct amdgpu_reset_context *reset_context,
+       struct list_head *device_list, struct amdgpu_hive_info *hive,
+       bool need_emergency_restart)
+{
+       struct amdgpu_device *tmp_adev =3D NULL;
+       int i, r =3D 0;
+
+       /* block all schedulers and reset given job's ring */
+       list_for_each_entry(tmp_adev, device_list, reset_list) {
                amdgpu_device_set_mp1_state(tmp_adev);

                /*
@@ -6301,11 +6325,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_d=
evice *adev,
                amdgpu_ras_set_error_query_ready(tmp_adev, true);

        }
-
-       tmp_adev =3D list_first_entry(device_list, struct amdgpu_device,
-                                           reset_list);
-       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
-
 }


@@ -6376,10 +6395,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
        reset_context->hive =3D hive;
        INIT_LIST_HEAD(&device_list);

+       if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
+               goto end_reset;
+
+       /* We need to lock reset domain only once both for XGMI and single =
device */
+       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
+
        r =3D amdgpu_device_halt_activities(adev, job, reset_context, &devi=
ce_list,
                                         hive, need_emergency_restart);
        if (r)
-               goto end_reset;
+               goto reset_unlock;

        if (need_emergency_restart)
                goto skip_sched_resume;
@@ -6397,13 +6422,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,

        r =3D amdgpu_device_asic_reset(adev, &device_list, reset_context);
        if (r)
-               goto end_reset;
+               goto reset_unlock;
 skip_hw_reset:
        r =3D amdgpu_device_sched_resume(&device_list, reset_context, job_s=
ignaled);
        if (r)
-               goto end_reset;
+               goto reset_unlock;
 skip_sched_resume:
        amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
+reset_unlock:
+       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 end_reset:
        if (hive) {
                mutex_unlock(&hive->hive_lock);
@@ -6821,6 +6848,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta
                memset(&reset_context, 0, sizeof(reset_context));
                INIT_LIST_HEAD(&device_list);

+               amdgpu_device_recovery_prepare(adev, &device_list, hive);
+               amdgpu_device_recovery_get_reset_lock(adev, &device_list);
                r =3D amdgpu_device_halt_activities(adev, NULL, &reset_cont=
ext, &device_list,
                                         hive, false);
                if (hive) {
@@ -6938,8 +6967,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)
                if (hive) {
                        list_for_each_entry(tmp_adev, &device_list, reset_l=
ist)
                                amdgpu_device_unset_mp1_state(tmp_adev);
-                       amdgpu_device_unlock_reset_domain(adev->reset_domai=
n);
                }
+               amdgpu_device_recovery_put_reset_lock(adev, &device_list);
        }

        if (hive) {
@@ -6985,6 +7014,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)

        amdgpu_device_sched_resume(&device_list, NULL, NULL);
        amdgpu_device_gpu_resume(adev, &device_list, false);
+       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
        adev->pcie_reset_ctx.occurs_dpc =3D false;

        if (hive) {
--
2.34.1

