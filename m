Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9605C021B2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 01:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913BE10EA0B;
	Fri, 21 Feb 2025 01:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jY8lD6CS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B8210EA0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 01:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeC0gwA9p/4phqEoHHT/G63rT/DpaF4OdvXJqprfAwoqqVykNGc3B19U7ObyorM2y1K6DNkK3d+TWKeKL/eMjUlXC6YVG9ciYZfPDfbgCtxP5UtRfD1/KjJH9QfGrXqPOYwMyl22OS3fZ8oa4SJdb4cFQvmzzlXcnmd0FdD/C3vFtJEujJa+zcntNPG3MNO16ikQ9a3AoDK7yycX58hX0maSebh2r+eL+oQdFttTvH+n3JWzREAvJ1I7x2ALZngrLePh29hDysZMwd2k+QNgqka8u9CuNPef75LqOk2XbamkqwyurpzhHoxqhLYXWvmtwl/kraV0IgtyVSUfu+mrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GHyHasp4iwdua+e+8B4dGHawrfR6kzFESibkEW9lck=;
 b=WAsJPQXuH2V2UisC9JvJSPS8I7xXnpxoAKZZqLSprvPrFyQI3AxR3pos8c1vLejLnJNreFNarbS3N8Xxvz0qbhbLsnvXi0n8Xb0uMczk2pTO7ALIahzcuhVkHPGtcTciKzNitB2ZBc/+sErVPV1U8pA81PsoBfB2dOoBWQJxuqfFNJoEtZO8vVMAO+2yeSc4FbAbx8TYG8a+DJaLf4VDwUTWoaIwpV2Zk66EEKxhatUBnzCmmelSBUH7IDUx/pLKXlZllVkNhYxDrMG4SQ3uMGMRJk/1YQD/SLEXzFDsnnOEkGuE63He1JVCYwqAKrGILORfQV3k8cmQ7JY5oRQeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GHyHasp4iwdua+e+8B4dGHawrfR6kzFESibkEW9lck=;
 b=jY8lD6CSKhpIB6ZzkT5sqv327SWgGXqOv23JY+ftDspqNaS9JJLPegtG0LOu10fmExdlTWCSZm6GGyObQr/k9cpf1OvTDwQ/+IEU40ygRzVipKP8kCs5V1jCsR5887c1dzc8mD/d72UqGAhwPIeb7wcDH+QF8amUFuzglR3lmls=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 01:43:50 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 01:43:50 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Topic: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Index: AQHbg2A83gtUpFkbEU2j4DQWnCY1sLNQ/U8Q
Date: Fri, 21 Feb 2025 01:43:50 +0000
Message-ID: <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
 <20250220062515.2050499-3-Emily.Deng@amd.com>
In-Reply-To: <20250220062515.2050499-3-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20eea709-1c3c-4ab6-a31b-da2884a9d2e2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T01:43:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: 1ffac552-ad85-45da-da5f-08dd521930e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?leR9zq20lELNMO1wUboMfCrfE8AWIl52Cijj2bUCs84OxFQZvp2Oft23DUgU?=
 =?us-ascii?Q?pEkJdbEHmTyeEJBSRoGS/zuC53u+waEX1KoSNmclpMK7CtVBpaDnOoGz8lxw?=
 =?us-ascii?Q?4kWozWHocWij4MjWXtou0P16K6RLACt5cSbxTxDBSjdnFKigAO+PF9McVhds?=
 =?us-ascii?Q?GapcwkxbuBhsLERvm2TBzrVAWyT2yvpimtObJU5MpJrf3sVvKWZf/7ocXjmj?=
 =?us-ascii?Q?Aoioz/KecTxNL3S2MlO/5+fSXwVciUCMu8MlVQ5GywFlZ2ARlVVYrcdv5Mlq?=
 =?us-ascii?Q?aymsANPHtgXCzO7MsfNEyc0zZoh5h7I3BoWjrfXX7SENngONELFyOC7eMjl9?=
 =?us-ascii?Q?4ErfM82mH3IV+r8c0nkbQnVAwbN5B+LZGKEPslZ4gKP2mME7C9vHt9mgbOon?=
 =?us-ascii?Q?LhxcsFcOBK5FNlmUKvXsovv23S6TLej9jSJZxUCOATM08r2f+MnBmvkPBuAm?=
 =?us-ascii?Q?526PM0T9xXeWmTr+pVCSoN8dI99MLcrLyBEKnp2/d++G9UCocQZs2a1ZUqmu?=
 =?us-ascii?Q?uzdJ557lPwBWGbPmu+EceDA9vDu1YINF5girLFSxxna5JHP8Hb6Ox3MLyGoj?=
 =?us-ascii?Q?2rdQiMlYC5j/63pFJyXRSc5+iU7ZMaq334u8Kr8lrb2/mc1gX+UO+UzgEHnW?=
 =?us-ascii?Q?rtqqzOGpBHD0pkyoibHaFV0UUNBYGxWClkw6WY5ZBYi+jswHs3wMbsy/NaK1?=
 =?us-ascii?Q?hnfytFRZCkjgankLYeVN4tdMnDHbYw8l09yBAdrW+JhTa3VNJ2waywstMn0F?=
 =?us-ascii?Q?5c18huOQRJ+qFhDd5k9UEM16VihwR0A8QkX9xYi4nb31g5k0pYgkVs7tnJQh?=
 =?us-ascii?Q?VY8E6dFZ4srftj9aMsyuX2uxqME4tYw8Lt2B06JEbpw1cMhHFck93vtny8zM?=
 =?us-ascii?Q?6UIE9RFcYHkroON5ZHnlAtt+QCZMagOnrgIwUt6ZtRXzj1SZ6T767KnCUhE5?=
 =?us-ascii?Q?7KqfH8rd8rJPqyoP11fvHHU25EKeRdu2IBs2H6Unv0bwVzL7bLqKb6UGKcEC?=
 =?us-ascii?Q?Kw7nbwidv0H68goR5SfuHW7nt8VxbGvtPNsnITyeKN2fiIE1N9Wz7FFIN2cF?=
 =?us-ascii?Q?J7qShULwRXiuABiHfLIMAPPMGh1biOtnpmXtQsAFD9Pn8YC2dV66g+E2gYwp?=
 =?us-ascii?Q?B97Uubf9g4mkdLZX+wy7hinWDybZh4HqgmyNIOHrfgVnw37+YJBKeMPYJeDl?=
 =?us-ascii?Q?lle/6YMLHJCG1FhhZN6HrUdtU8tpki/+tquBAMp1QW6YNzInh+d+17sHQv8N?=
 =?us-ascii?Q?Tzk6ov1pqWi7pK6YrlvcFDlDxiMFr+Kt3suvDWtX2Mj452SeeG5I7NBT51tA?=
 =?us-ascii?Q?zRxIEbwUr4COQoHRnHyBVN4Um9aW8ar+vV3oKFyw3IMgPyeKebMW7gb7mLaY?=
 =?us-ascii?Q?UL0TY8uQtc9glon8jPTFW9c6G4ybBj5A6WoUtR9EMLM9kb3j3R8/uP3UiT5Q?=
 =?us-ascii?Q?vCmwacoQy3vksxegYkPXDRU60apgSOc4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qO0uuHI53/7pfsTolRATODJ60KOaVHP5w5G2pK19cuhPkstbuemudbIGkdaj?=
 =?us-ascii?Q?CwmYD55TWe+uIK4NJwq5hGnRNvsdcnagjYhujgzTp6Cf3j1nArpvRccL8sUr?=
 =?us-ascii?Q?uKot0TEBlcghtaCHOzcoFnQysaQfo8//EzgBktfGPBJpvF4Y714Ls335toxc?=
 =?us-ascii?Q?+eVKjBzZ/8CqV0ys4ZaQoyOOh+GOSmr0h6aKps/oT2HzQFSBBNPU3zrstiLi?=
 =?us-ascii?Q?SjKLZCKrwhB6KWlK3KL3T/gKGW1U35A/pnFIpgaZZ6UsLnRfh+dUKfJQjDyG?=
 =?us-ascii?Q?y5EI00B/omBVkRVtr+0cUyWoR+P1T4b19sUuHPDLsarFOSbEkw2QVr8DGNg2?=
 =?us-ascii?Q?uvy28FWQW2DNHSepkehci0qHIPx164BDl0nbI/EsFbRlbrzQU9N6Zb+qt0Uy?=
 =?us-ascii?Q?CYJiTLNdbYEqw7zdzMe+v2NuzpknGQ0+i3VkrloHJ3qeqECD8LAjnaFUfSGI?=
 =?us-ascii?Q?LJKRFuthf04kAR1Qg6d6aw8Pi27tGO+pf0O9F2ypgPJFWM5/TzbxK/yodpCW?=
 =?us-ascii?Q?wqsitOX4sjSBJ4Sf5HBMV4EEfgwvVXhz/tWdEo0r9N1I8CEI7roSkwmNyUWo?=
 =?us-ascii?Q?PVcTYRmX3TTH0Bjv0wW49Y5gpwsk1Z50OHvt/MnrNeEeaaQOKFPwgDQ/Q77w?=
 =?us-ascii?Q?D8Val0W4dCWkop1mb933QWyxxACklN/NrXqUXHa0Msq9Vuh2LEXvr4RskdOe?=
 =?us-ascii?Q?Q5+weFBDKcLoNEHPmTxyqhx75BMVMfMMdDRUA+6tYIirs4DuOFyu63bVZn+U?=
 =?us-ascii?Q?nRLwJJkv3S1q34vTZcj4mUbS+pvWItsKe1eEKWXIkafq7p4FfuDhdvIG1xUU?=
 =?us-ascii?Q?MMexbVZ8K0CPb5hQJ3voY3quGj0RFhNv3yQ3HQ9BGAgYuIs7FywzUfBO5rRu?=
 =?us-ascii?Q?rQlHe6XO5kNTaKVFSxIasB+cdce9gWxpH5iCSBVoHMC7PpQ+dnt0jdRWSg04?=
 =?us-ascii?Q?do8Naw4UJ4KJ5FdE6MfqvV6ln9pOYw+I6gGZ+wxmpUPTyLxzH/acCVFpHmDe?=
 =?us-ascii?Q?OwiLvM4azIgR/9hUKm6/2cYcSIrhcNgqYO8A5P7d68o9A/pNo5+ShdGRjcN3?=
 =?us-ascii?Q?msxzlh3w20fNGcq/dkwPFAMzVsiBFbYs+VqQ/54IcNGHdgovhutQMgYbIZvP?=
 =?us-ascii?Q?G4u1jIJIkJC6Qg1Dl8UEMH8YMLgz/JniipxhUxmZU4+z/EKYI5qy1QXGznLL?=
 =?us-ascii?Q?Z2oi2jqMq0jQbjsIaPmoyawJzlESwv9N+2VOCFjH+YMmxz1kskE96qR9QL4O?=
 =?us-ascii?Q?wHHAzhQKRlf0HPOc2FdtZHi2qJGX3mSBAoquCTXZbShP4UhUESsq5gLKh7x4?=
 =?us-ascii?Q?QaRYYTgCYnPQzbbvXXSmmORYMW5TvHXzoety4MJ+mxjBRsVqJS0W7LMJ7IYx?=
 =?us-ascii?Q?+koW4c4sNNMH1Fq8rkdWaHQ6YbK9qtYgStia6bpt1gcKlZYK+R3y6F32Wf1z?=
 =?us-ascii?Q?UmBIUj+YxgCJu9ntCG9e/40ECTzGiB3ahIAqOgOiuZdBCXH9jjHF6GFI5vgv?=
 =?us-ascii?Q?G4yzst+9PszSkEYdGFuEZ1dQcPD4C5B9+QGzpR6DY3AaxS8xw8xGO2oiLIF4?=
 =?us-ascii?Q?HcVEjeuTIbq0YPTxMvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffac552-ad85-45da-da5f-08dd521930e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:43:50.4002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5p6+L7OHw4JBG9T3cqP6wTVrwKLz1w2Aip/5Tfk4MON6YKMEHfXa5NGoG8xFqIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Thursday, February 20, 2025 2:25 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
>
>Avoid updating the vmid to 0 during the queue update process, as this may =
trigger a
>wptr poll address page fault when a ring doorbell is activated  in doorbel=
l_mode=3D1.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>index 6b38967d5631..3028c16264b2 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm, void **mq=
d,
>               m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>       }
>
>+      m->cp_hqd_vmid =3D q->vmid;
>+
>       *mqd =3D m;
>       if (gart_addr)
>               *gart_addr =3D addr;
>@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager *mm, void
>*mqd,
>
>       m->cp_hqd_iq_timer =3D 0;
>
>-      m->cp_hqd_vmid =3D q->vmid;
>-
>       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>               m->cp_hqd_pq_control |=3D
>CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>                               2 <<
>CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
>--
>2.36.1

