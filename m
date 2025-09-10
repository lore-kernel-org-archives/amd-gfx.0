Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF540CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 02:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C2010E827;
	Wed, 10 Sep 2025 02:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BuVFXMpw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFA310E827
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 02:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZFmrb6dYcpFYDi8ukejALksYoPTHBrHFiAGhoXMnvwRhOYFl13zsynvezmNwTtzDerezOOYyRzY3nNgptgd/XvVFF3mvUnYq6EPb57UAZGYFRKTLqJ4i9xNfCjKRShTDTxyNfFOQGZvxbxNZDLF/tIRH9n9yiwuH3v9qdwkCiELsfzRVkPQUWV1DA33djQKa6SfMzTNG1noM8/W36FEZ1LhPEbVhJxdqLpCjb2yADoRkD2B2GwZz4ZZsoqctiG93CKHR4+bBVN0EhKTCd5LWLY+/0i4TXlmCLeww9ydSAb7+nqLDsdTQYmeVHDg9KDDX/pU7rnAimQKiigdbVca9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWXKhKIyV5zBUni+LXuFFZJuftINBSQ0zQUvG/VEO/Q=;
 b=Ril77Kn/BMZ7MYVGEbNgdZULdPFDt/vQPHwA9wZO9rKWhyviJUTmF97WCTfWvXWjBMdqJULZoIpUduNno+zt5oQUzKFH5JK8DiJYYZj14bmBo41poK6z+F8jODVKCmBCYi/f6pbZfkt+lTYsLDW4IjFzOiy+jksTieKST4M6+I/vOXTdzxIiB9uG2qzvDQtUz7vgebTfud3NWethLuxF2JllC3hlgorKmgnsV5lmZQNphH5ADW2DJU+FZHp1jyxGtCvNwEblYFC79W5S1tR/DhvNJpJvfh4EXuYC/2xvJnrRhuqVcgdrs0WpUrjoUnnedNr1q/VMR6bazitLysMtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWXKhKIyV5zBUni+LXuFFZJuftINBSQ0zQUvG/VEO/Q=;
 b=BuVFXMpwjqkbjLh1BTpOQSqT8n3txLXtqAzIr+cU14GJceJbY+Am5fVi2IX0HsCytxNcZZeyjVFNWhaeAnReafpwcVEKk/fk2lPRWyW9BkWEEA2jL7MIdPbuP/q/h2bcxZ+zerWKJ1e5a9HUvjRSafjHBslUBtMG/5u2yGDrVBg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 02:43:40 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 02:43:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Thread-Topic: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Thread-Index: AQHcIU2fqtsiZuKP+UyZManppdXRxrSLtWqA
Date: Wed, 10 Sep 2025 02:43:32 +0000
Message-ID: <PH7PR12MB59970D21801A6A191C451CE6820EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
 <20250909054933.2911159-2-lijo.lazar@amd.com>
In-Reply-To: <20250909054933.2911159-2-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-10T02:38:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PPF44635DB8D:EE_
x-ms-office365-filtering-correlation-id: 2d7514c7-4758-414e-1058-08ddf013d55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BiGAb9wLIijAYqkq6RBM6tyhHYsSLyEG2OJ21Y+jbs6DoVB88eROjGgWGO7T?=
 =?us-ascii?Q?G/oU/39vm/+miQcrvJD6uNcmc0eRWqWZQf8vv+DrKUKcuSI+w8VpQDenl8SA?=
 =?us-ascii?Q?h5JgaG94EQda1B8r2Fh+EYIqa0VqYfShOIyPkCAs7zg/WikTAUzihDwSXzgI?=
 =?us-ascii?Q?9+ld1oyECGCI+T+UL/fNu8El1fLBzopHT2QeW6CFynXr54saO8QLHRFD8s28?=
 =?us-ascii?Q?djKnHtrpM+KYHeHPWbY2KF/0G9cXYblVinai0rf6knIpr46OH2g6Axhoq/Z1?=
 =?us-ascii?Q?pC3KXFgaupo3ystZndrpSqg3IW+GZDwxoxmeWd9ByHK4ltY80SabYzceyUSW?=
 =?us-ascii?Q?r6faDrPnHXL5DZq+9gBZiVNMidu/9ZYwTM1YsQ2AoLnNfS4JgrngvSAWVap8?=
 =?us-ascii?Q?Uv1eyH7QOWz4pKqxfp0PDRVmWKEaHtnlS+gndUsJK+tbZ2qJg15JEvjWD6wZ?=
 =?us-ascii?Q?J2xBEgP4H0AMx8kUTi1qQyYcdmxFNbtZ4B8raXNg/Wsbdkx8bQXeV1BOc4jx?=
 =?us-ascii?Q?1DO9haS4rGs5a/BlYMxRCvVCd/UfKx4Eqt+G0n7dtAe0gLqf1Vzih7lNNrq9?=
 =?us-ascii?Q?0YHVw7Oip+nDQh68VUVOmOBqfqKNbAjQtr0GAK8jQrA3VWqHjaxPQcAyimHn?=
 =?us-ascii?Q?nvtLdurEI4VhTPUnmi0hbdKWtJl0J5jA/1/74LrdgYw12rTNNE4yhBZXqGZz?=
 =?us-ascii?Q?3nrVwblLf5R4bAvpHqtEEq3e9FXiNSEd+WFMul2obQ9mhd2IWQoe1EVKMmCI?=
 =?us-ascii?Q?u2nzqU1J/zGBUxV+At/Y4R2ne2++mu615vsNDMNHGthxU+3iOPu8yMJDW19+?=
 =?us-ascii?Q?33XEreK6O2HCLYLV6JJToNtzpO4sj2TDC8torfvVL9RV2C486HO9rRpXqENN?=
 =?us-ascii?Q?w5jWy1sgZ/kgKevL4NOXYL7qTtUOT9mcbktJMOQOHbzEe3YzxSbfAIRc1B60?=
 =?us-ascii?Q?8SkH0ipRXZo1RTCyoPqiUunuUDlrlCH2uR0sAqSJBkO5XxeYWfQniUp2PBGV?=
 =?us-ascii?Q?DoF6zuK/JBYZcpsEQ0U7qHAsceZQbSF/y2cARW3RU0f9URJ/MroXzsf3Pkm4?=
 =?us-ascii?Q?ZhSG0QJX2rB4pCTaA9rTvUvTmKl1U6wm3BT/qBjV6u1ynECrw/tOSbCnyivf?=
 =?us-ascii?Q?19t7Nu6raKLO79v1sFg0OqiNd/WMKLqfHXVPkBvgiH82mOyGZYlYIkS01SZK?=
 =?us-ascii?Q?N9LjUO3WYfHvEL8e9D4swSJMMCLn6rPE5sLPYxroyPfQs4LXT63YWwQqQV2r?=
 =?us-ascii?Q?VpVKOmLV6Hk+f4QFEy0CoNrc3bPb2VNTgp85mWH/DzFE9Yaj22E5z+gn8Wqj?=
 =?us-ascii?Q?UbAYkF3PHYpk42DZoRfmSeBP4pM3x9ArHLDrbGqMo31lomZicxC78wgbg1C1?=
 =?us-ascii?Q?E333DtrHqq9MGLug8ksv92JDPt1F1zuww78TU+2KRngkLjtll7/F0iyqQ5Za?=
 =?us-ascii?Q?Wl4T8JRtNI0sPRnIYpROiAGlxbggco4Nm4zqzksycr6eZWbGIN2YZ18irRN3?=
 =?us-ascii?Q?ktHWYWdXPl1hJec=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zc4O8jVasd56NcVkSzLerCrfqrF1yDRwr2mEjpZL9+k1PbVYaFdb6knP2xy4?=
 =?us-ascii?Q?4rRTVYQxiRS/FltOK/L2LaJ1ehzsKH4NiDzyFNAOf51Llb0psANHFuvxzEIt?=
 =?us-ascii?Q?KPdjAsjvXT69/BhNYjYQEgPjN41dqOl47ArgEa7/zM90hvA+Y8qN2HyG7rkA?=
 =?us-ascii?Q?AHM9qWVRNHS0zKECchfRtoua28nrxQm1dGFeTEN9TYDKnnD3jAZMV1K0k0Bg?=
 =?us-ascii?Q?cs3PV03x5BxmRILc0hHolV1Ea09nVJM6K94j6tqB5GWmA6r3EoZstq9fhYj1?=
 =?us-ascii?Q?JiuAYxCILisU12szdFs/2tYiXqnfTGpEEE/bp2Y3Ot6pa9S3diKphGegvSaJ?=
 =?us-ascii?Q?5Te9JA3u03PCTzbRdENcpfuz76DHU9n/JpSNgLKX4SJdngC+JnAicbOQYBMe?=
 =?us-ascii?Q?aM6Hnwo0lizVpeMTAySvT7iGpY+OU+a+6qsXMOaGwxZO14DVyqoBHlsQQuAv?=
 =?us-ascii?Q?M0g7TJp9amqWBLNINcYFNHs59WK4KJAam63MQgyDDHJQW5Ghg+3gLndEDDdT?=
 =?us-ascii?Q?SxynRF7lRwhpAdwx+osJ8UPUBJqPNKd4hdAx37NfuDOjsokSi5Fsf6b4WrY7?=
 =?us-ascii?Q?TKyfx59PPW0J9MGWdxvLkp1VBh7m1hBEZci5mMRTtWRqFDbD5teWeefjaOAQ?=
 =?us-ascii?Q?+PMY/EhXYsSeF+SFsZQUfNQ3ejNjXmfso4MWSHqgOzhceGErICqjArbBnbq4?=
 =?us-ascii?Q?yKVtmHwz89Yff8pkYHI0k//8xIiE1MqUxb+phMPzlaPahGwmNPTMuP38Na8F?=
 =?us-ascii?Q?y/MJ2eRwn7yY/gdMqhu8adyIPcOxLDi4gtW8TcH92SIW/ibjiQFn2rQ1WAww?=
 =?us-ascii?Q?coz3/ZryPSi4EXOXE7+YPFQN3Ms6YQOqLOC/Iun1IZGdca8OTge+vKASA7J/?=
 =?us-ascii?Q?TZXFU8cHYApUEBi6mXurZ7Dkq6BRl19JLlo1MZkrwbGDzmEG5IJrBnUKyduY?=
 =?us-ascii?Q?RapsoedE7cvtMBg2vhwF2tEjgPJjJMA7oU0OU4xTbYmUut5l3hBTETQYhma9?=
 =?us-ascii?Q?6OvQNYUgGunej8Ib6gm9uepsAUYQG5nT8FYbdmLVtHGL2h8l6KuZ5da3MI8r?=
 =?us-ascii?Q?GprNC7cOlKvwYWVbO33QhHRPJTkKQ7qrSINTRh8GBohJVCGngKnOyIhVysp+?=
 =?us-ascii?Q?Y3/0POqZADab4jCEpUhBUcT1GfJ5jjmvyowqJyPeqhx1QnGv2MzjOVXEapUH?=
 =?us-ascii?Q?2RGjOW63aih+MyLg5LmM0PUGdZWKN3g4b1J6K5PCgbujmvqqbkM+9XFCyQBr?=
 =?us-ascii?Q?NY4ozUoxm7pl5dZ0KiDPE+YI8bE3rajHRd6yUAM9zYiSXNqorr1tRW+mOfn1?=
 =?us-ascii?Q?YIKmfFhqC3cJQpvCa8/4zI6AnsJkL2+DxCuXdb8hqgnJzM4jVgabNV2REuXM?=
 =?us-ascii?Q?LSBsgXHfr+og4WdqAyHJ7KjSAbl3Ow+5/5iL9t2ozIXIx7Yt06Mb9ToLEsKN?=
 =?us-ascii?Q?86rNcofveMfb+MECyeMFMWjQArJEKyjd7bEKE+vz+VIa6PHJiMgD0MZGoCmp?=
 =?us-ascii?Q?YOxP5/UyV7B8rACT6ro71Xix88EhdhRvaheEp6l1HQl9djYckPNv3LQmIJ0+?=
 =?us-ascii?Q?+/cl9nuBwhhzI7fqaBY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7514c7-4758-414e-1058-08ddf013d55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 02:43:33.0705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+6p5MAUad3OcF5KLHbb8SWwVRS5TMMUkqlnYvaxbeK+xEVBtAxPihaGPKMY3P2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 9, 2025 13:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9

Add gpu metrics definition which is only a set of gpu metrics attributes. A=
 field is encoded by its id, type and number of instances.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Add unit field and change encoding to 64-bit.
v3: Fix unit encoding

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..5538c7c671d3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -528,6 +528,110 @@ struct metrics_table_header {
        uint8_t                         content_revision;
 };

+enum amdgpu_metrics_attr_id {
+       AMDGPU_METRICS_ATTR_TEMPERATURE_HOTSPOT,
+       AMDGPU_METRICS_ATTR_TEMPERATURE_MEM,
+       AMDGPU_METRICS_ATTR_TEMPERATURE_VRSOC,
+       AMDGPU_METRICS_ATTR_CURR_SOCKET_POWER,
+       AMDGPU_METRICS_ATTR_AVERAGE_GFX_ACTIVITY,
+       AMDGPU_METRICS_ATTR_AVERAGE_UMC_ACTIVITY,
+       AMDGPU_METRICS_ATTR_MEM_MAX_BANDWIDTH,
+       AMDGPU_METRICS_ATTR_ENERGY_ACCUMULATOR,
+       AMDGPU_METRICS_ATTR_SYSTEM_CLOCK_COUNTER,
+       AMDGPU_METRICS_ATTR_ACCUMULATION_COUNTER,
+       AMDGPU_METRICS_ATTR_PROCHOT_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_PPT_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_SOCKET_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_VR_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_HBM_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_GFXCLK_LOCK_STATUS,
+       AMDGPU_METRICS_ATTR_PCIE_LINK_WIDTH,
+       AMDGPU_METRICS_ATTR_PCIE_LINK_SPEED,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_WIDTH,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_SPEED,
+       AMDGPU_METRICS_ATTR_GFX_ACTIVITY_ACC,
+       AMDGPU_METRICS_ATTR_MEM_ACTIVITY_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_INST,
+       AMDGPU_METRICS_ATTR_PCIE_L0_TO_RECOV_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_REPLAY_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_REPLAY_ROVER_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_NAK_SENT_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_NAK_RCVD_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_READ_DATA_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_WRITE_DATA_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_STATUS,
+       AMDGPU_METRICS_ATTR_FIRMWARE_TIMESTAMP,
+       AMDGPU_METRICS_ATTR_CURRENT_GFXCLK,
+       AMDGPU_METRICS_ATTR_CURRENT_SOCCLK,
+       AMDGPU_METRICS_ATTR_CURRENT_VCLK0,
+       AMDGPU_METRICS_ATTR_CURRENT_DCLK0,
+       AMDGPU_METRICS_ATTR_CURRENT_UCLK,
+       AMDGPU_METRICS_ATTR_NUM_PARTITION,
+       AMDGPU_METRICS_ATTR_PCIE_LC_PERF_OTHER_END_RECOVERY,
+       AMDGPU_METRICS_ATTR_GFX_BUSY_INST,
+       AMDGPU_METRICS_ATTR_JPEG_BUSY,
+       AMDGPU_METRICS_ATTR_VCN_BUSY,
+       AMDGPU_METRICS_ATTR_GFX_BUSY_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_PPT_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_THM_ACC,
+       AMDGPU_METRICS_ATTR_GFX_LOW_UTILIZATION_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+       AMDGPU_METRICS_ATTR_MAX,
+};

[kevin]:
How about modify the name prefix to "AMDGPU_METRICS_ID" or "AMDGPU_METRICS_=
ATTR_ID" ?
+
+enum amdgpu_metrics_attr_type {
+       AMDGPU_METRICS_TYPE_U8,
+       AMDGPU_METRICS_TYPE_S8,
+       AMDGPU_METRICS_TYPE_U16,
+       AMDGPU_METRICS_TYPE_S16,
+       AMDGPU_METRICS_TYPE_U32,
+       AMDGPU_METRICS_TYPE_S32,
+       AMDGPU_METRICS_TYPE_U64,
+       AMDGPU_METRICS_TYPE_S64,
+       AMDGPU_METRICS_TYPE_MAX,
+};
+
+enum amdgpu_metrics_attr_unit {
+       /* None */
+       AMDGPU_METRICS_UNIT_NONE,
+       /* MHz*/
+       AMDGPU_METRICS_UNIT_CLOCK_1,
+       /* Degree Celsius*/
+       AMDGPU_METRICS_UNIT_TEMP_1,
+       /* Watts*/
+       AMDGPU_METRICS_UNIT_POWER_1,
+       /* In nanoseconds*/
+       AMDGPU_METRICS_UNIT_TIME_1,
+       /* In 10 nanoseconds*/
+       AMDGPU_METRICS_UNIT_TIME_2,
+       /* Speed in GT/s */
+       AMDGPU_METRICS_UNIT_SPEED_1,
+       /* Speed in 0.1 GT/s */
+       AMDGPU_METRICS_UNIT_SPEED_2,
+       /* Bandwidth GB/s */
+       AMDGPU_METRICS_UNIT_BW_1,
+       /* Data in KB */
+       AMDGPU_METRICS_UNIT_DATA_1,
+       /* Percentage */
+       AMDGPU_METRICS_UNIT_PERCENT,
+       AMDGPU_METRICS_UNIT_MAX,
+};
+
+#define AMDGPU_METRICS_ATTR_UNIT_MASK 0xFF000000 #define
+AMDGPU_METRICS_ATTR_UNIT_SHIFT 24 #define AMDGPU_METRICS_ATTR_TYPE_MASK
+0x00F00000 #define AMDGPU_METRICS_ATTR_TYPE_SHIFT 20 #define
+AMDGPU_METRICS_ATTR_ID_MASK 0x000FFC00 #define
+AMDGPU_METRICS_ATTR_ID_SHIFT 10 #define AMDGPU_METRICS_ATTR_INST_MASK
+0x000003FF #define AMDGPU_METRICS_ATTR_INST_SHIFT 0
+
+#define AMDGPU_METRICS_ENC_ATTR(unit, type, id, inst)      \
+       (((u64)(unit) << AMDGPU_METRICS_ATTR_UNIT_SHIFT) | \
+        ((u64)(type) << AMDGPU_METRICS_ATTR_TYPE_SHIFT) | \
+        ((u64)(id) << AMDGPU_METRICS_ATTR_ID_SHIFT) | (inst))
+
 /*
  * gpu_metrics_v1_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v1_1 or later instead.
@@ -1217,6 +1321,19 @@ struct gpu_metrics_v1_8 {
        uint32_t                        pcie_lc_perf_other_end_recovery;
 };

+struct gpu_metrics_attr {
+       /* Field type encoded with AMDGPU_METRICS_ENC_ATTR */
+       uint64_t attr_encoding;
+       /* Attribute value, depends on attr_encoding */
+       void *attr_value;
+};
[kevin]:

I think the "void *" is not good idea to export data as an interface, and t=
his pointer width is dependent on OS/CPU width (4 bytes on 32bit system but=
 8 bytes on 64bit system )?
so, it is better to change it to uint64_t type.

Best Regards,
Kevin
+
+struct gpu_metrics_v1_9 {
+       struct metrics_table_header common_header;
+       int attr_count;
+       struct gpu_metrics_attr metrics_attrs[]; };
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
--
2.49.0

