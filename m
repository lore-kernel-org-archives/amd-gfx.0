Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD62C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6E910E74D;
	Thu, 25 Apr 2024 03:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zTwoK3NJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70A410EA7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRAggYa80ZTgfo6FwQbIZKBp9oxWfnaDksBz7NHeuHjGrhfezAibFmj7WX/VlwDIf3UUERNJ0qITuyOLNQy39XOz6Aj25gFRnT6pIogw7QJuKuNI5NdC0c9TYm4norxJVNVhJ9PBagAy+0iOsIuS1HnsDsb2JpXbPO9XHlrXvX4+9CSQ7uxpPSDcMhsXBdzwHpvlK3mch016knwXdmD6YDUuY5vQAU3FUa2H3f9+NgzEnt4uPwsttm8Nboam2MUy6NLYjje5SVBmVzogzSVCliccyqUo8Ba/nLl3f9buxMkgSZm4sSfCeT0Y3UdFcNbps4j+8gILUeHMtBUUUvBzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfrhH0Q1sM4UQaVhf7FFu8wr4vc70kDgNi9ezEItGM0=;
 b=Vt255+2GUi8LWTkTgRUWOMzr5qLIcVRHVuFvwyaeA/yiQ+Sbh+wylCy/dEHVG2Rgypbee6zZ9zbq0hX7iA6VPI4d+ssITyHVghT1iXzmwkdnJU0eKcbk4htF06ScVZfg9Nk99lNPq0h+ZGPRYWfaQ2d6lByxdFNZMwO0J3gFqHk15x8mE1KZXBTGQRd52m+EyyOVv7YDzmbZFRcz5QuIWKMZId+5r0MVTKSB0XnXadBq11KF6qygZToF5CEOOuoFI1sQ9h6a/C/EQejlCq3xn2xv+i3e9s43WJiWu4XoMI/u9XoM6tIdq0L3ty9ZUrar8s5m5F93OmzQiZtQTSsnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfrhH0Q1sM4UQaVhf7FFu8wr4vc70kDgNi9ezEItGM0=;
 b=zTwoK3NJF/AB5UVrQsSJQyh7uyTRQ3wnZ+q71OWAspFtHNwaoWIOC7ROjcLnj4KmVRayhhHodFAxVa2HbVtY4fhWDM4RuM8/DnsJwPqrB6wg5KhY9rZxUElJQnwGHPXvI9AaapO5JAaCcKlAHZiz+9GmrAVd2pN4aSz+f6sGrkk=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:17:56 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 03:17:56 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison
 consumption
Thread-Topic: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison
 consumption
Thread-Index: AQHakTzJfdPL/onk6ky/CbDN9a7hfrF4VxiAgAACf6A=
Date: Thu, 25 Apr 2024 03:17:56 +0000
Message-ID: <CH2PR12MB4215182F2D8DC45904290134FC172@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-11-YiPeng.Chai@amd.com>
 <BN9PR12MB5257A920AAC995AC06E4881DFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257A920AAC995AC06E4881DFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: beba98d2-ecea-4f27-27ae-08dc64d64d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?wI+XNNaRiSEM6S7v7Q8wAdSgxkfSt2jKuAjEvBQLw1Oy+22zqeS2o9XoCOnN?=
 =?us-ascii?Q?D4UWF29MF+LyDY7U013dxHVUVmlbbh9MvWlwowMR0w23K8R/DndQ8etGoIMO?=
 =?us-ascii?Q?AquYLGZvArDVuKUGlKKdafExOTwkjBwSSIgM9Z3w/UDs5e1KgJUDms+X/NRM?=
 =?us-ascii?Q?GKjzbplL71Z4CvCokmhDIhEbYJD1ZQYkxajjL7jSqrJfW3DB/rhXLvmqaXnw?=
 =?us-ascii?Q?kpC+Fu4/TsV8vwuTH57dePBE0+/UGlEJ8G1jPRag+H6iubVU2jxs71ghppvS?=
 =?us-ascii?Q?7zTdF3mY2F7Ohk5lB8Nfg5vI09bO+N/Q9C9QY8h2Ih+pVHdBQ4eMEt4jjUz1?=
 =?us-ascii?Q?6clJS4ELUXE/gac0RuB0eZ3l4L72J4ePWWssEJjXnbBlBVTHWXm6F9ip+hgW?=
 =?us-ascii?Q?9b/JfNLBDY0kMtyrZFzidczHxBCPcOafZsy7xfKFbnyLG83rx3cRZ7SVmRh8?=
 =?us-ascii?Q?DX5ymAjDG3ut3dQnD+ODvcpx7d085+HwLiaqBtT3p3zRO427HrniHiOEH1e5?=
 =?us-ascii?Q?4CNl918kvy3PIgKVY9U3CCrdhoDhzij71SrYBjk+DgN0qOS8GshteSRXiEDY?=
 =?us-ascii?Q?ve5hW/NlHk8LSu5B/x28jy2IIX1zyznUUeJ3+Q7m67hagCeErCMyTR+7SprW?=
 =?us-ascii?Q?ODYLgROwG8ix3g/WH+0qJ5v0NkE7iMXxcuFUM9KP6FM5+XkIVKwyzpa2RRky?=
 =?us-ascii?Q?mEykneCXwnuYMMNNqGWdDyFNDhWJeF/1dyjODH/lmTyBlqPNuy9pwv26td36?=
 =?us-ascii?Q?iuVC67qg32lKPpCiko30+/Owukq8uNA6nILbdk97Mhy4902bqZaafmAy5qMU?=
 =?us-ascii?Q?Goq40jqsz8Ok74IIIMx1/u/dwmhv9PA3dpvRA1lI82V4ZVDQxVohnsMbh5xG?=
 =?us-ascii?Q?EPujsX94EKQOeOruytUNqCHfMdL2GV7G5aKhm1c/2jkfPYdHnIhQ7SJA25+3?=
 =?us-ascii?Q?UH4mLcAnO9w/pwrrQ5+UTbBxv/I4eW/LMbPX2FzsIumY4ZXcFRQACXU+CVha?=
 =?us-ascii?Q?y5RUN2GPoNRhocxyuJ1rFtFfUL2Gt7DjOEKJuEFrhn/yLzxfdtdCatqO6iPx?=
 =?us-ascii?Q?q36v+FS7mQBaOcG34vDSR9Z0yX42L/CA0F5a8ZmZWtQvjYYmHjZt4pe4ri1g?=
 =?us-ascii?Q?6jTmXH0yfAUc5ZTs8Sm05ZNec0Nw307SEhIZuMrbAh4IETJE+5v/1i0kPwJJ?=
 =?us-ascii?Q?wmGo4oZtusqr/mejErl6u7BnUTGzIL6/JWTVk6h9FcGeGKEZtDTqiOTBhKsD?=
 =?us-ascii?Q?Xm3iYKG67N2Amr46LmfdaEhz2crKnRK+G5xHUxr9+mhXX+/u693odM/nIPw5?=
 =?us-ascii?Q?utK4vc+B5sVvpCeWfvvRI0dqZTQbiNGMBDEw+V2pXRImUA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8U5M0SgKPCmz6nQA5+tiUTTlMg/H4awh9lgAddkTnS//0upkUeWGID+grGJG?=
 =?us-ascii?Q?ZL4dtqCo9Rpf7jYcO0WiHVhUUwydeu+UCWNSnnZqHyX/Fd98Avo/PO1SyG+O?=
 =?us-ascii?Q?wjCOhpxFOVt5W2KmG1LQQGMNPpsdekvSBSx2A1Xrr5TwhjVzhAzajJvWVgm8?=
 =?us-ascii?Q?gO+4wEjdcNul8g0lpQaY/P4J1hTHpIRBYsgnd0KMhRxUP1aGCtjWOhfivNmi?=
 =?us-ascii?Q?fkcdjumfRF2qmJgjd/hETpVrB1Vzd3WaYtIslAPjzXEB9oqPU3oOaNjcfQ9B?=
 =?us-ascii?Q?XWbV3Lwu0z623nvfdgC0BAGLDbJnGqTH1XiFt+5jtAklxpqwZU3rN2VHZsd/?=
 =?us-ascii?Q?8mT/0i76RR/T8UMOzsiT46YT3pB55xJhVA1u7grpYDH9oArL0lxKqqc3qdZh?=
 =?us-ascii?Q?dsKvuwJaO13qLyCqa+aWpVAsnc2VPJYQ+tw4gZv3a6tytWvZ0CaRtwYxJvuP?=
 =?us-ascii?Q?nLg1hHiBp/+gmDlTUblI+4z58HqDXxZ72dpWN2Vf2O7s1xcoXdClv3IIQNS5?=
 =?us-ascii?Q?dO+oP/2Fo0HOKFVNts9XRFO/6nm8J9J8pTSRkXHisI85DAWSqQJpVIW6Cz6l?=
 =?us-ascii?Q?C0HDZpYqTkZK1DaZYAQcYpNXsllGX2Qo+Yo2LvXEzBYNP6FgOtc1//4FDXGT?=
 =?us-ascii?Q?hBBo5wppH2hdQZf2XrnMUslEZGdAglTaXOwoYSvb5HCpKT68Cct2C+duftFz?=
 =?us-ascii?Q?JHJ4qtfV6AP2C675E4c/P+uNq7oRs+v9Huu2ebVNbP3LO22DqeCBHduIBNiu?=
 =?us-ascii?Q?Cgongz32Q0jvLkxaOOq4EPHzehIuvWjWEHVuttbWM9wC+hz+2OezhDgMIi8V?=
 =?us-ascii?Q?bYbLm7XO6rw7Q0TzssYDjnyAYYRhna/7FH3HGSQqKmI0LZYyS8oUyGzJgBP3?=
 =?us-ascii?Q?iwyN3NKOgmRYIEMf3xagkPzBPY7MCH93vn/G9ksyyTgUR3cNwrgkog0vlASs?=
 =?us-ascii?Q?jeTnER4CQ0vLTWtglQiok/FNb7Z9CTE3sX2d2MK51B2WJpZrxACodQKOUVo3?=
 =?us-ascii?Q?3vV3inj6PSXseJs8bLQpgtSG3upoOLlWQcBFEMG59kJCb6Yo5zgxHMV4rmsk?=
 =?us-ascii?Q?eezL6YHnMT6z0VzodrzHCtxXeJWkPBjJtXkS7yorkFrf/L3lS/rYpvKOnT4Y?=
 =?us-ascii?Q?VqdId/ENIorDrE0V3/F7UI3XOA8ku2lGKcGfFJiSywEXFx8hARgxO9fz/fta?=
 =?us-ascii?Q?05M88xPHvUakmWogoZ4yHEDqrr5Q0wmzt/NCDUkWni22E/DUKiGqNMHcr3Uf?=
 =?us-ascii?Q?M4/b1EozxMKOIk3a1UcOC0rtIx7TKRo7bKnDYutUko7yJ7NZx9DtVNjs/Fz+?=
 =?us-ascii?Q?1BaXn/kGa8jSenLCUyDy0c/rDwjVNqZpASTh+JXTMVG6WLxx1XS0yOJEwbv1?=
 =?us-ascii?Q?1A3H1h4eNHlD3pnujfqZMLEgncImNY6pyjp6823HaDdGUgOgzSwRf+TaR02/?=
 =?us-ascii?Q?93u4gWIVdWCRJSFQRLp/419Wx/Mf7O3l/V+F2pCrPaawF1cCPn+QerBSuDgg?=
 =?us-ascii?Q?kehkcnGEVYThWmhxkKkPkD8WeNBFdTYjme6hCFwQaz5ACwVcVjTYRz85o4lq?=
 =?us-ascii?Q?BkIztwFOacZyPyjL/UM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba98d2-ecea-4f27-27ae-08dc64d64d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:17:56.4630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exdKzbFayy0KJJg5jdjKnY8tcc0PMb8RdO/4CjdT2+8DIftKbDWuKcOZABVRi3+ErXbobwbV0kNEf8c0IfT1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, April 25, 2024 11:01 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 11/15] drm/amdgpu: prepare to handle pasid poison consu=
mption

[AMD Official Use Only - General]

+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_devi=
ce *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t
+reset);

> So we ultimately switch to above poison consumption handler for all the e=
xisting v9 adapters, right? If so, we shall be able to make this function b=
ackwards compatible. I'm wondering if we can just change the existing amdgp=
u_amdkfd_ras_poison_consumption_handler.

> Pasid_poison_consumption_handler is a little bit confusing.

[Thomas] No,  Only  UMC_HWIP  greater or equal to IP_VERSION(12, 0, 0)),  i=
t works on  the new path.  The IP check is in amdgpu_umc_pasid_poison_handl=
er function.



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
+       amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn,
+data, reset); }
+
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
        enum amdgpu_ras_block block, uint32_t reset)  {
-       amdgpu_umc_poison_handler(adev, block, reset);
+       amdgpu_umc_pasid_poison_handler(adev, block, 0, NULL, NULL,
+ reset);
 }

 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_amdkfd.h
index ad50c7bbc326..54e15994d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -401,6 +401,11 @@ int amdgpu_amdkfd_get_tile_config(struct amdgpu_device=
 *adev,
                                struct tile_config *config);  void amdgpu_a=
mdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
                        enum amdgpu_ras_block block, uint32_t reset);
+
+void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_devi=
ce *adev,
+                       enum amdgpu_ras_block block, uint16_t pasid,
+                       pasid_notify pasid_fn, void *data, uint32_t
+reset);
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
+                       pasid_notify pasid_fn, void *data, uint32_t
+reset)
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
+                                       block, pasid, pasid_fn, data,
+ reset);
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
+                               block, 0, NULL, NULL, reset); }
+
 int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
                void *ras_error_status,
                struct amdgpu_iv_entry *entry) diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
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
+                       pasid_notify pasid_fn, void *data, uint32_t
+reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
                struct amdgpu_irq_src *source,
                struct amdgpu_iv_entry *entry); diff --git a/drivers/gpu/dr=
m/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_proc=
ess_v9.c
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


