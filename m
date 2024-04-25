Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF49BC10F16
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7209C10F1C9;
	Thu, 25 Apr 2024 03:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOZ9MdpM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0610F1C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQB/RDPjpnTASnxP0fYjmX2f018K9sINYDgcEUsFJo/Du+O9ZRhEL42TZagqNGTiHBDcGK/QMOdlQpC2wzSTqUJXwfj9hEDLgjWV08QRmzkcMALCSKpuyqfKH7Zofp8/BkeCpZVNXl52OCPNAleB1WRTuj0EqAY63Ni70mJpdxjCdPCdQ6XJT2ZwAjSSFWU/Ay57n/pMUCJ/2+/CHLN04ysKwCCdKOJ5S8kWUS8X29Ep/IEr++ODOeTuqBSHZXl96oMbPR9BOAXLBF3dXV2N1KWQCdIG1++tfLk658SiwVizEJk1xoj3GkeWRl+fFTqwAMSVFt+NnZWRqOhyA43WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/uiaLPKXhwvY+GSegb4VKPxZChfPQDm6+YXk6iX3eA=;
 b=IfcP5akzJ6TTqFzZOkQ6YSGzKnuLwoE1OYzuK/KDBvxca/hshgDiMfinuM2M4QqRSHSiKnhFC0cwuebFKFgNUgPYmpOdM9LbjTiAiD4Hg/HH+/731Ia0TFhFKKfy91ERHsvywbL3+9CwLExBlOKRbiebjQ985rEzuTYmpd0cRRqpwkYh4PwtyrU28M8RXIo6JL+15kSvEqyE+TX59syKQMG4kB4BuhshCHy4MMS5AocW0/Dk+sCROfGFeAD7JVCmsdQEssz6vxh/kyrNAjlFsajnmLKNN8HFgX2wJO1B5IzppiZwikCGVMY0nNeOK5qWwYk9iBMhDcljzbaG71rxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/uiaLPKXhwvY+GSegb4VKPxZChfPQDm6+YXk6iX3eA=;
 b=JOZ9MdpM4nPBkapfq+hopC2hfTVEWl7Oz5YnRupcmB/25if+2AWlkE4ksNunhs5pcClwrWr11GWr0ZinRRG9pDURj9d0igU5riD5Kes5Baq0DvHjfngF0vZSFP5lE4FmFlWKcn7hdc5eJFGJLOEu0i7qewhUQbfNfv/c2G931es=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:00:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 03:00:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison
 consumption
Thread-Topic: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison
 consumption
Thread-Index: AQHakTzJYu9gDYefpkeYSTvT4EL1mLF4VhsQ
Date: Thu, 25 Apr 2024 03:00:53 +0000
Message-ID: <BN9PR12MB5257A920AAC995AC06E4881DFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-11-YiPeng.Chai@amd.com>
In-Reply-To: <20240418025836.170106-11-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0884a2fe-8143-43fa-8f4d-6fafe16cc07e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T02:57:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: 5c7f5f93-e67e-4d60-c9f7-08dc64d3ebd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?38YLSM9akqn4c2drBp+F88njTMQyib/qHqBDgpmgysc7yfU7ijPoV5m2UZHF?=
 =?us-ascii?Q?WONYxTgdMBhKHOkbhF4un5SPGvCVkUVZzbtgDiFrIzG8lq3EzE2JuSW/HrpR?=
 =?us-ascii?Q?RFdsxhupG/K0Gbi5klGK96xZ7pM/3ZDx0g7+DUbIxMndrHUcYt5GuG8BO3sh?=
 =?us-ascii?Q?BHGJL9JCeeDBJpOAt29aVjHVcr3BcSMyY+l58l/cq1LEZaA2EnDG4Ia1rwOe?=
 =?us-ascii?Q?RTMVN4aDP/GzXvGs/ifNs3pZ33WVk2JCYCKVY+BCi6moZQq7E18jJPGeq5qk?=
 =?us-ascii?Q?2dJn/h2SgvmheiZFRxhJgXjhfuqbfrlY+wSxabHtpmQMavlO+OZVtXhq65ab?=
 =?us-ascii?Q?6stiXHSflusmr0JhpDCLwH5oO6ODp5dNzkSqnqyGhdttunMztMCn0x5SUgoU?=
 =?us-ascii?Q?Z6XqLNUWU77w4LimHb63jjaU4n7B/fC45A4lKXiHHeWvQPQmKWo2PRMeR0LZ?=
 =?us-ascii?Q?I5sYk6GAT9HjTE+IeGqIGgxiGEBgaIVg2qgbDiPFYGu1vyqkRZkxPVuztxKR?=
 =?us-ascii?Q?hdDNbFIIDwHecQKbioK+i//LLpmWCCnef1j6UMsudDrTG/GBu2O9ASZOWbNW?=
 =?us-ascii?Q?u4b1noKdSs3Re/KYdw7/IDfPjB41FMYzS9UTWfoAR4KtmRwzc2wqKs7J4gvR?=
 =?us-ascii?Q?PmWbwPJUkEIxg1ndnx5LyKyTX4eiU0ujRlMv7SQzt2t48lCb/gmH0O7DV4uY?=
 =?us-ascii?Q?mRx+HDLbupPPoHthJRTIKBRz4gvk+TePNgUjpN+I6qRzSgGUY7L4NwX9cxRB?=
 =?us-ascii?Q?+I4J/CDMk/ksuL9Xu5OT5CUYlolqG/iRyNpqKTzG0lwtheStP/fjmBFs52ZG?=
 =?us-ascii?Q?ywxoh6VxBVf1IDHauSXgdqBtf5Q3oEUvX7pHemijd1jEuOXWN3pfrC+VG2oN?=
 =?us-ascii?Q?4Xc515SD4K6Kq4x/Jo/m1DHpML3B+slstUUAl+8mQBKIR7z4CRCwbLVqTrdd?=
 =?us-ascii?Q?yYFmhTJR9PLr1PIA4rczJRg0d4ByFcnrxo48gfqIsbtQjRD17Jfq9vNWEvxd?=
 =?us-ascii?Q?WeY3QDAzAvGczZQ9hUMsoThU4jzkmW0T78iGMgvdmtaE7QKZLIAToLbXcWbb?=
 =?us-ascii?Q?0g+XiSmOYQNPsSCMaH2XPnqn21fA0fDuzSXAbixBbCAftwiraMMKI2vIERT4?=
 =?us-ascii?Q?NoqQaRfhndFvp0RXuIW68wPp5dp7r0zN/Udfmkqgi6ilIT1WoZVDbeWzXbAj?=
 =?us-ascii?Q?pWxM+Mk/rQ2ZDee7ZGqPc6Am22xL0Mo0ZtozMQcJxqCaJFmCggI2MWQUI0Zq?=
 =?us-ascii?Q?4kx/FzO/GR/C4oHs2/jtglJFDj0+Sw7Ge+LxiAD8+ne8eSNRDD2sks/Zme6u?=
 =?us-ascii?Q?BoPilrtAXoxhor5SaGDIlUHGInfftYJiEdZr18/X0Ri2HQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ihwqxzRrhhImZdm6FefJ3yOZTbbFk7Jtjh4Y041akNmtO5SN0q4WlXpq9xG?=
 =?us-ascii?Q?7cNWXqLKfvP0B3xWxRdvt825rF399Xq7uIj/fq4cvsbGVfbwgM45m1N0Ae0O?=
 =?us-ascii?Q?eNU5MaoKvTaMIL1s2Hi2oQa5J6zoTjsAXR0oCsTZIqR+qvD8Lu4l+/3KrNLs?=
 =?us-ascii?Q?n+komXKeP8DG4URIxrOvTXgMuUb6b9Aq5c84OmelQ+tc7NLVp6be1HS/J93k?=
 =?us-ascii?Q?vnNyfZTRSgIVCoVzcL9rd7Rj3PMt0US99BWOuyN3/D8dNLLNOQx+6QwwxCGC?=
 =?us-ascii?Q?TIT9vRgHbsfHOkcsNOyVZmDGZAdz7MJFo8SfdbW+n224/4xZGBdPxKGp7dLj?=
 =?us-ascii?Q?+z0JTBPwP/fz6iJ1n5AQkwQ7VxqM76MfPQE+vhmhF64OPhfAtl845TKsP2sj?=
 =?us-ascii?Q?u01/DDfplwTksWpjG2RtbIbdV+kUi1577m2M2xgoYgf69Fptwjkt4S8+XtZY?=
 =?us-ascii?Q?tXBHe3HBYxEXny8FJskXfHM5oPZ57PXxg7Hc5FHy/bg8wQd0H0+VhpZkiYJC?=
 =?us-ascii?Q?CIuGd8FETGE8n2Rabbl3/wrRQ5XBkuHM2lqMWNWYo5GReoAJiwtSqmhbKCHa?=
 =?us-ascii?Q?yLqAJjzIROQ4AO37LzbrMLgCiAJZtedVjMmoAXW6xpdR3ncJy7kQy8B/SSHk?=
 =?us-ascii?Q?4Clwxc/k6wm+XfmmW/YKFP1QbT3Qdr4kfAEEn+OSvR7iWbk4kywg/9N7xMYb?=
 =?us-ascii?Q?udBprGehTfrtTm2jZLIMvylU711gY5DPqepCfvbO8vctFLdAaK08KNOU/kWQ?=
 =?us-ascii?Q?gHwSSufUWRdSlBmTysnrMqPSgSP5jgdudVcVQd/IS8DdzxGvry3Hmht/+Y9c?=
 =?us-ascii?Q?8u2lDBxb66kcaGjjlzf9ARTjwXz8u0HzDr5GOtc7livwUHd847NtTIDXHsVk?=
 =?us-ascii?Q?gK2tatjEAQV5Z5HqHh+fXH1O/l7Im2qQ+CiwnVVJoQWOn6KaCSXj3kCEDBrX?=
 =?us-ascii?Q?rfr4PCqD/dg1XAfzV4467IvrkbqTMCS6I40bt56ARsZQzNh31jp1E29Mj+BN?=
 =?us-ascii?Q?gngMLAnqROCEoFOG9eres7Za0LziyplPVQf3rhKS9aylFkMQ6V/jJZRD2LgJ?=
 =?us-ascii?Q?Una7szcTwXAhGNuTHEMPsOTZu2Ih5Reu69lrCnkyyshFG03Qm4l88OARmsVG?=
 =?us-ascii?Q?gZfIBDvLV0VIbOpH8QGQbTEC9GiH3LDUrwDSrKcTOPxYALK4dK+h/NBBiwMF?=
 =?us-ascii?Q?EUl3ycZlV5BgoZobOgbO6D781DFXzim+hOSezOcBQZgRwdd059GBPG0AMm50?=
 =?us-ascii?Q?9zmApeQFpwYFGDElIyIn8tOC59+oXOLOj2hNGb/kTzlQPZQ3DYYa2RYZ4Sjk?=
 =?us-ascii?Q?xueBD83lX28KgAoBNTJwG+lX6mZF8bRkUCynZR5CCPUg2jYeOmnkRN9pM1tm?=
 =?us-ascii?Q?YiLBQK4dKlb8eeLdNCRDeEDT/cJFKsJqOXbh6pW6qHu948cbtS9+WKg4QIGz?=
 =?us-ascii?Q?xMSWKPdHDREoLg00EC1OB49ygKdR2pDdTgsdPEiMCyzpXqIlUnmYmIlAaWP4?=
 =?us-ascii?Q?n/WyEMfijNdBiyAQ6CdYl5OOBDQtg1vOP557Er8aap7W4vHYgV0KfgmEshBT?=
 =?us-ascii?Q?AND7ixf5EKjMKxZGWWxjjj3AA7t1hkh1ZQ9m8DMo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7f5f93-e67e-4d60-c9f7-08dc64d3ebd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:00:53.6350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SfapVpc9IC1/9rfybRtC8ds6ZPFUQ0rx3hEv8eQ7W191vBx8ICEVb3fO7jdAOD3Bz+RXljfFJ/f7tA/FmwQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_devi=
ce *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t reset);

So we ultimately switch to above poison consumption handler for all the exi=
sting v9 adapters, right? If so, we shall be able to make this function bac=
kwards compatible. I'm wondering if we can just change the existing amdgpu_=
amdkfd_ras_poison_consumption_handler.

Pasid_poison_consumption_handler is a little bit confusing.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, April 18, 2024 10:59
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison consumpti=
on

Prepare to handle pasid poison consumption.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 20 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  3 +++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  3 ++-
 5 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 66753940bb4d..287ce431901c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -759,10 +759,17 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
        return amdgpu_ras_get_fed_status(adev);  }

+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_devi=
ce *adev,
+                               enum amdgpu_ras_block block, uint16_t pasid=
,
+                               pasid_notify pasid_fn, void *data, uint32_t=
 reset) {
+       amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn, data,
+reset); }
+
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
        enum amdgpu_ras_block block, uint32_t reset)  {
-       amdgpu_umc_poison_handler(adev, block, reset);
+       amdgpu_umc_pasid_poison_handler(adev, block, 0, NULL, NULL, reset);
 }

 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_amdkfd.h
index ad50c7bbc326..54e15994d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -401,6 +401,11 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device=
 *adev,
                                struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
                        enum amdgpu_ras_block block, uint32_t reset);
+
+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_devi=
ce *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t reset);
+
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);  bool amdgpu_amdkfd=
_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);  void a=
mdgpu_amdkfd_block_mmu_notifications(void *p); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index dcda3d24bee3..8ebbca9e2e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -252,8 +252,9 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,
        return 0;
 }

-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block block, uint32_t reset)
+int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t reset)
 {
        int ret =3D AMDGPU_RAS_SUCCESS;

@@ -291,16 +292,14 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *a=
dev,

                        amdgpu_ras_error_data_fini(&err_data);
                } else {
-                       if (reset) {
-                               amdgpu_umc_bad_page_polling_timeout(adev,
-                                                       reset, MAX_UMC_POIS=
ON_POLLING_TIME_SYNC);
-                       } else {
                                struct amdgpu_ras *con =3D amdgpu_ras_get_c=
ontext(adev);

+                               amdgpu_ras_put_poison_req(adev,
+                                       block, pasid, pasid_fn, data, reset=
);
+
                                atomic_inc(&con->page_retirement_req_cnt);

                                wake_up(&con->page_retirement_wq);
-                       }
                }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
@@ -313,6 +312,13 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *ad=
ev,
        return ret;
 }

+int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block block, uint32_t reset) {
+       return amdgpu_umc_pasid_poison_handler(adev,
+                               block, 0, NULL, NULL, reset);
+}
+
 int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
                void *ras_error_status,
                struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 9e77e6d48e3b..5f50c69c3cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -106,6 +106,9 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);=
  int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_commo=
n_if *ras_block);  int amdgpu_umc_poison_handler(struct amdgpu_device *adev=
,
                        enum amdgpu_ras_block block, uint32_t reset);
+int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
                struct amdgpu_irq_src *source,
                struct amdgpu_iv_entry *entry);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4..6bf4bbc3cffa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -201,7 +201,8 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);

-       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
+       amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
+               block, pasid, NULL, NULL, reset);
 }

 static bool context_id_expected(struct kfd_dev *dev)
--
2.34.1

