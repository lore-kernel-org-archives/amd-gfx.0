Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CDEC021A4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 01:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C120D10E37C;
	Tue, 25 Feb 2025 01:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tQTeJ0iE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533BA10E37C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 01:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AINCwAFjiM1+3oZtD/n8eclRBCt4FwbtZQmXNi8HKDYsLKi1W1Z+Gke/aftl+RxAw7wRXJqg3s3VBWB19WYpUmf8+FPcrUI/NMC0G0DlRqYdTGEokvjwl6mq9GpjUjnt/wIZEKKsFHbJHGc2fuK8p07KJ8QK3HhFllQsuXFUkKyh+yPIEY346OOBXXH7MCEDbYNJpRxADfspXlLKNyR+ymL4U/vLCLnVoOIf42ULHV3Na+KGFKGqMxE4emnk85DCSKBjzP6hV72Z9RLQTqiz08OWyTXcNcIFw9TDW/MiNSmRCYesRMod1OwsN9XlFuLDLJmmI/p6SI6eU/ZbvmLu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2KWtfXRaB5oWPVoDmG1iK27RwOHPg6Nmu/Zb8QIuLk=;
 b=XWTE1Dpc31UaM3UHGNcbZxMc2544z4xr6G5HWRDOOJVbbT/0zU1stFxvL2DsZNuVvP7BddzzsObbZbvSMzOAG0sUflLU5Y50tCsEp7RPKmWZJfScWDdlea7o2OpVvrBjN90a/fac5YAiTXBdRKSF3QPhFdad8/D9o+Wsrxnv5CSY+WpBJ7enC782bRGS15XuYBdkfqmCD12ZQ2VDDyPgomxvH0FBxIneTy2EApy3jj+g85SYq5afZR6EGPoKxP6ADKWozD8Q1Bjacjr3mnF1SqtL9QlhunQfsEV1yCJB/sRIiS2swKDNw8ARUp2pb10nr/e8knWWoNtAoeTMXL1udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2KWtfXRaB5oWPVoDmG1iK27RwOHPg6Nmu/Zb8QIuLk=;
 b=tQTeJ0iEWEdUPrWfKgffSfnDz0Q+ew0XBVptWA0Bm387y1DI3sWvTEfGR9REhfBGB+lfIizEHauDCwj08vDsakT5bzXbxaquAPsx4URfuUWugT6oyBH52MDWvu6SjIhFHo0D01ScEuZr38fGIWRN696et+Xk2jDr8N6Vzi927iM=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 01:05:23 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:05:23 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Topic: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Index: AQHbg2A83gtUpFkbEU2j4DQWnCY1sLNQ/U8QgAS5RlCAAYVP0A==
Date: Tue, 25 Feb 2025 01:05:23 +0000
Message-ID: <PH0PR12MB5417843C44D1FFBD8FC8DAD58FC32@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
 <20250220062515.2050499-3-Emily.Deng@amd.com>
 <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54179719DAD3729506B19EC28FC02@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54179719DAD3729506B19EC28FC02@PH0PR12MB5417.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH7PR12MB7454:EE_
x-ms-office365-filtering-correlation-id: 0a6259a8-80a6-4767-8923-08dd55387ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/MBn4JbcqRh1SG8FC54mm0HC4QQNAqclhsAtNJjtrbwzThZIDtEoDKuiL6kx?=
 =?us-ascii?Q?r2tbc+9j0Zp6xZXd9UzUto3IpME42xITDeRa8PNnx1CAK9xcWFA1wmd7TjuI?=
 =?us-ascii?Q?DyB2Z3KiEJwnafbhoK/3RYeXxF+gY+ZbU5z/sOaImZENdEOzht3clo5t3RVK?=
 =?us-ascii?Q?Bq/leDfV/SXhl6oZmpkiJMbyqPnUUvRAiRt+SHMVcgO3T6Z6sLsVq2UKFQvH?=
 =?us-ascii?Q?EpWXSXugdrbrilA2PX3Crg3gFu/uXJkyRD0WXPiMf0DueomOZGAm62JsGE8h?=
 =?us-ascii?Q?MnacBwJzYDs9Mll3QiQIxtMCKF3rk4WbqYUfIH1wpT83bZH6M5m4RDTwM4So?=
 =?us-ascii?Q?1lpfgu16NTB/jNyMWajc/o9gBnhQ6GXgtxdhXRh3BFjx0URQXtubNP2rTkSR?=
 =?us-ascii?Q?gZVibac237KP/nj4CsMjqPKi1NVv8ZkNYs+E4sMIAcCQ8YPIcN+VG8JO0Fmv?=
 =?us-ascii?Q?ETVnFtd5fVTIfftnaFYXe/Vzvg3mwxIbDtjhumQuWoS5NyUqawl+EKw1iLoK?=
 =?us-ascii?Q?KJm6GYaVbrCGq7EupQJy0lTEEggNliJLEcNP0oR6XyyfvUyA4Hv4h5Nv6YY5?=
 =?us-ascii?Q?eiRlLYWApzOUQ99mAgoyLEamTCTrq0AMXRQC2gnJf5esLCd5NJERXL7sGOVK?=
 =?us-ascii?Q?/hioWZ4PoacfhLAEih8N2GhYWOyj+yWXTATuJIXTheInCA19V9RhM6H6Ewh3?=
 =?us-ascii?Q?da9a1iq1gOc7d5kCtprQh7/2Idy5KmsXyaMRBbhwNGVNa88KLZdCCXLElj9X?=
 =?us-ascii?Q?DlTvgwv6rTKMoNAtM31syyxC8Zf2JCVB+CXh5iVXxyzFOO2sCrg8YuuGFLK8?=
 =?us-ascii?Q?VXk4QeMkWtOQ2gOjck7Vs8UaYSzZYjefKqGvTIHu6Jgavuatj51k1xIygCfY?=
 =?us-ascii?Q?cbAWOYqHZPtI9Qs22R2Z1Zno2oigjKS2nm2xPXU1TudhTf1z3Pw8P1E0HkeD?=
 =?us-ascii?Q?Cxp+DDZfb9Bo4lYnquycy39gnT9B5gvWEG1H1cFzPYuuN2rMHMazEThzvED2?=
 =?us-ascii?Q?obMUXbtS7g+Hd5wCLVzG97tFqCMFydk5HnIrjL1JYl1IRdPg2cTz/l36yYK1?=
 =?us-ascii?Q?kHra1ZnMpRuqZa0U5ZQar8MM7tXmO6l4F9hgdEv93tYS9moFB+qv/YbqGCLy?=
 =?us-ascii?Q?V3NkwMKUwJjVwxInY3P8QSy6mSjl87YI4tQt18VQsTvnEw+5qLjkJjeQe49l?=
 =?us-ascii?Q?3ZIFNGlEoTPx9cZWPdi4wncdgZKomzdygcp9c0oNVp/7s0zwNR4BlM1upv8N?=
 =?us-ascii?Q?KkH6pPAKvW15Q3yisVu0UANKxtVYfKV1HjQSwnbqI2jO58FO4XTg42/AyB7t?=
 =?us-ascii?Q?urvjS7N7KnyhBg3QiCiAbCPBOj2r1WSAOqKj+kTwmjzBtfXDDuxd+ZL8js/n?=
 =?us-ascii?Q?/jrzYAED74QJWu9L51xCbIwjhq/CM4XdtEqL8MNWrc4jHK80riPb8Ro/VDN6?=
 =?us-ascii?Q?xg+CyHd8luz3johVhHETufJx8sjkbA3s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fJ+/soqJAOS+bsQ5lMfnHMIRvgveQDAFch8oD/Z+PD+jT/wmP/MCyeCvYqj?=
 =?us-ascii?Q?qDr/ZwoBVDcG9k+jMyf5pOnHT8oZ2wioi0p98G+Pv7FFPNqtCmargGSsKQFT?=
 =?us-ascii?Q?LNtEa9E7ielwCjivsWMxR4x8HQMM7iTs62DR3NULVxnnzwkJgENi0NJdoBBh?=
 =?us-ascii?Q?uE/5sXP9oo/TpimbKyqpuHx0lSpwSV0m4YxglP9LGmOHNsGRjaI+mdcqpeSr?=
 =?us-ascii?Q?ngr9K47TohhH79UMLv+bIDXX+2aqWmgRxz1T3ACRTnIjogEUn129fTcSX4/b?=
 =?us-ascii?Q?eobBzIAi1B+jgFaELTCUeE90Dgx9qFc8OouDjOkDd6iXmrQhoLNWyzFhe03Q?=
 =?us-ascii?Q?JlXwfgwVpy3m4BftTRGRd6bR4JxxxpF+FMxEcofs8WR9eddT1p2/Slp3m7Tw?=
 =?us-ascii?Q?j0mFNyzjoJXuP0ej6iMJjJ57WN7vCDOMOZ56gwCZsSdRF9GDD9nXqiSEzEyc?=
 =?us-ascii?Q?9/fXf19OOSv977QuqGS3LD8C9c7Nf/Lmj3rhFV/1tDfUv3KJcz5Uz0xMKCGS?=
 =?us-ascii?Q?zQcoHIGxv7fPeS0RffNAhP8BZAW48NQwzj6Hfh2PpIxYc8SY0DHvJ/UaSVUN?=
 =?us-ascii?Q?1VSULNGztrPE3IfV8+v8uuCdbVDL1t0T4bhwTAZyRd0RiJIeZjQ1fbMvpqtG?=
 =?us-ascii?Q?VgkEIb7Vp9cqqL2rSjjFe87SIJV8rqAsViIQHUpnT3iU2Z1aPPZKYVJD96yw?=
 =?us-ascii?Q?VGqpQSM3lQYqKRpLq9sBZqarFUhnsWg1a+Qhmlm4D1cPfIu683Z1Wd2EkTkM?=
 =?us-ascii?Q?zFfEoKuT4t6w4C7n9DIIznjcIUCpnrtbFUUbPjui/9WwL/JMLHS84drr3l9v?=
 =?us-ascii?Q?1fEbRQn2sPtAvoZx96ofkODavGRq0/dLKbLGOFi2qiFWRTG2IQKj5bYGxqo3?=
 =?us-ascii?Q?6hbfkyP22a1Pda9DRp6Mu7yf03/ylxxwurvbUNkDJllFq5LgJ/jNE8kCRbY8?=
 =?us-ascii?Q?xtX6bjX7C+JRFP2jKVom8WHuznGKuiXdXHEMPwJxTMPaMe/ibp95P+0tUbrN?=
 =?us-ascii?Q?V4Erif32I0bvxZ+VgQWSXIul0j4LGKY5sZA2JPjBjmzHfOzLpbV8snTLDI79?=
 =?us-ascii?Q?8chQRIDpY7gaX8t7mMgYs++5QZl2h7IBtQnQH3oT3OUO35z+v5LTqazCJnfg?=
 =?us-ascii?Q?tJM0iFcZRZBKGNzyAHcNmdbKediJGryb1R38Wnri4FKSxSd3xPvtY1fNrqN4?=
 =?us-ascii?Q?Nf8yJ6YffxmX80L/sIlMS/YdmfTTDn8BXCw/SUwkE+9D86u2yi2zygFIfOMl?=
 =?us-ascii?Q?kYxMHRbmR6j9cfRwk2q3wipgSbyr2VQDqzvYOvi8DeaYMFsqzg0djRVJhd9k?=
 =?us-ascii?Q?hJH4/XOKx4SsWHB/Nkb+PDh7WnAHak9Pc9+orpuLyGDuQ9E9pHN8lcnt0Gfu?=
 =?us-ascii?Q?UKpTc5aHPw8TitxP3WeImzGJthOnaRpKg3wZVCnb5rx3JBpyXfKS67veSuBG?=
 =?us-ascii?Q?ZW3N7mIlwP+Gns8hGPS2jceMxEz8K4GO4IpTL/e8y8WQh6daktfDqKHDLXRJ?=
 =?us-ascii?Q?GMVSTr+s/gdh7IqPObSySnvS9bBFYFeulPfzKnPSDhcQGBSf6g/nDBNQ3tFK?=
 =?us-ascii?Q?Gmr1z5Th51Lhos4bPVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6259a8-80a6-4767-8923-08dd55387ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 01:05:23.7376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxVNyPpcdlyLStJECFBhpNhxMIdBu6wyN6+hqNnNTGWOa0KDAjV5ndWMprRgqrcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deng, E=
mily
>Sent: Monday, February 24, 2025 9:53 AM
>To: Kuehling, Felix <Felix.Kuehling@amd.com>
>Cc: amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queu=
e
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>Hi Felix,
>    Could you help review this? Thanks.
>
>Emily Deng
>Best Wishes
>
>
>
>>-----Original Message-----
>>From: Deng, Emily <Emily.Deng@amd.com>
>>Sent: Friday, February 21, 2025 9:44 AM
>>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
>>queue
>>
>>[AMD Official Use Only - AMD Internal Distribution Only]
>>
>>Ping......
>>
>>Emily Deng
>>Best Wishes
>>
>>
>>
>>>-----Original Message-----
>>>From: Emily Deng <Emily.Deng@amd.com>
>>>Sent: Thursday, February 20, 2025 2:25 PM
>>>To: amd-gfx@lists.freedesktop.org
>>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>>Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
>>>queue
>>>
>>>Avoid updating the vmid to 0 during the queue update process, as this
>>>may trigger a wptr poll address page fault when a ring doorbell is
>>>activated  in
>>doorbell_mode=3D1.
>>>
>>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>---
>>> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>index 6b38967d5631..3028c16264b2 100644
>>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm, void
>**mqd,
>>>               m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>>>       }
>>>
>>>+      m->cp_hqd_vmid =3D q->vmid;
>>>+
>>>       *mqd =3D m;
>>>       if (gart_addr)
>>>               *gart_addr =3D addr;
>>>@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager *mm,
>>>void *mqd,
>>>
>>>       m->cp_hqd_iq_timer =3D 0;
>>>
>>>-      m->cp_hqd_vmid =3D q->vmid;
>>>-
>>>       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>>>               m->cp_hqd_pq_control |=3D
>>>CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>>>                               2 <<
>>>CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
>>>--
>>>2.36.1
>>

