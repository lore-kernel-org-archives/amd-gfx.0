Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31FEC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 06:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BA910F35E;
	Mon, 18 Mar 2024 06:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXLWmdcX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3066E10F35E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 06:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPwFVcXr+W/xEN16/yh8Xmg4p42axSzzFjepIBtMgaTWbovFBuUAFWnj3AHAc9xVp2JUJ4pK2uWvZNj6gSMkkpAO86VFZ1moLETs/wSVnqXx7sA1bFdWwP2ZHpA7T1NwBqd4gX/+KTRBBsyDQwhBHf2Z1tJPSuDpYRoUm1Mv4mF5THdZk7+LQg4wmrOSl6q2P/syGsnOem2aEF8/tw8l2RFQ6Gu67+IXEON19sC8bmDk3UTNbdlfmQAkNqcGNf23wcCsn7loBl5EtNq0a219vcZEYBodLkAP3uMYeUkm/UNg+dWa6Iv09e7yvU8DdvfWqg5VXeruuXHGQHNSruRj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxucpLofNl2MxY6cpv1OKmPKrJVAFQyA1n+QuOrSmFc=;
 b=Kwg7GGpkS4ep8j15Wmh1NnO08SdnRfgCoV8jjnzdrhqb3SNanAJp9zPetZSIXsh1sfbA2I6Qr15t+S9vjNqzLfrVeMzehmTAcsOq6GCQsa/nZWXYI6KsA4A79jTj7nhc8+eCLa93qCRbXGlhfZTS9gvj/D+jDQ0YbfvmBYSQx89ps2Kp/FBb6Hdc43vFhJeLxLRkKpp95v+Dr2gtU6Y5HEZOuoiaj8p92/nyNYyWFXYYq25AcHaR7PBqO/IoRF+zKtGoXztmltxEPThR0kvCW/hoFlluUITAEpDZ11l6vcnuAO2dLX8aLLUSwTlhHlasIt55V1JcdzFVuRZUDEuRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxucpLofNl2MxY6cpv1OKmPKrJVAFQyA1n+QuOrSmFc=;
 b=sXLWmdcXY8MPpmzptND6AiZXbQPb3CHYkDitwMQISXA9CpoUj21HjcgOG7mJJFOXT5qrT3xw1oB8xN7n6zdBdgwo4gPB+cXv99JQj1DchHy5EOuDRXxo+WUKNVrLxWXg1lQ1CMVizVpISzbt7G6zWwVObiOM4woffonpTx0gJj0=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 06:00:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 06:00:34 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [bug report] drm/amdgpu: add ring buffer information in
 devcoredump
Thread-Topic: [bug report] drm/amdgpu: add ring buffer information in
 devcoredump
Thread-Index: AQHaduu5l6yhZwyw0EGPdYEL8Yx75LE5KqCAgADrnYCAAu750A==
Date: Mon, 18 Mar 2024 06:00:34 +0000
Message-ID: <PH7PR12MB5596974A7C40AB4BB6350E7E932D2@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
 <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
 <9950abd8-55c3-4c53-89d5-a9c4d0c33b0f@moroto.mountain>
In-Reply-To: <9950abd8-55c3-4c53-89d5-a9c4d0c33b0f@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c20f0364-4b7f-4c09-b919-534337d544b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T06:00:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|LV3PR12MB9437:EE_
x-ms-office365-filtering-correlation-id: 324e2088-3b0e-4cb9-ae03-08dc4710ba0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Pud9UsEW0hex2sC2EvkXoEAPN4KCzMq6U2NBQ7hYh+ht2tK1p6ZICgUDjah/EUrzXbu6Evezy09RZwCbXggBMPlfN3eael4miJMIQIx3VA/iJlkszIs3byxfidvkbPOI4VC8tBsyAaFxvIIloveklIeJdnqcAAtcTF3PT18u1Ge8czUcldZqsRsBsR0vuL1HLElg5iRbm8rOqlEAZ8GwYpGwhWHV98Xn4wrkmSKJQNk1Dcfx/MXDyThz8htg9RrEAOvVv80FCD5/KSRYWF8s/ndrAro0FK+DlZVNSBPDYljq0BPsX809eoeUiO0OqK0zRBf9izcU3VH9eDuOVvVTtXp/7pcRAqmokxJpZKpURDJfq3POpMR8yAVP21xsFw+SMX2lz7ZzQ/VUsSvc6BhsNmoLI5DCdMiZNeCOMq+rtqN5KYI9hPoQv6XA7heGgKgCSJzzslZoIzUpiKaq1hlmz/v54pkgMpvudGt/mAPP2O1O6mYXJHh02QHOQQBBbuvyY390dNeA3HWnMrybCfo+nzXWWHYvp9dK2HpXppls13y+4mJ8KjIlPvVBJTZ+i15LQj+AiDSq8Uuj9sfEKo1LI5WUwVipJ8NJza5pXYAzuVKe/dP8XxFtMAR4eS94vZTMDH+8UNmkh3o2S46E8t52a6YDlfIx78j1/mizgQ26GOvOb1hpWvivXn5o3z+cUJ0+0glwg/Wxh6l5u81Vbmmdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WldIHuuWi9EqO1EN53qtNc93NtCCTflvf0no8QGeL0yc/L0dh549vmKJa2mg?=
 =?us-ascii?Q?5oKMiBW1kRlUFAfOqqzPnaO5GZT8l6Y/52BIA2BjTXT85z4SW/59zC24EJXE?=
 =?us-ascii?Q?CTy3ML+lWi5zKNZfteBYNwhXEeisJCZ0Q8Q1LnYo4xMdc3vfQr8tzc6Y41xo?=
 =?us-ascii?Q?uP326Fyet72Timg5WKB3R5Y/WN54ikWzf9lzId5Vz/a5KLxVFN+RlXFrwSI6?=
 =?us-ascii?Q?kOXOw551ijkyQxA1W7KwxnfMxpNwsMbUHGvHrnyGWqovAahdanSuJXyALwwh?=
 =?us-ascii?Q?VjeHxCd7XbAY6nrAvgVYTk/dvNBUnDqOkDexGWHi2wdcskKo7tMrjO8NEk6e?=
 =?us-ascii?Q?i0LwMue3tfo4Xde1bXYuFmplWZ/TyYs+RolpFSdPOXgq2yFbQujLfxzktGGI?=
 =?us-ascii?Q?w2mXKM5vKYfQxw7q2V1idURsuoRIq66PineCwKKc7b+P0SrloE08tlwVhuQJ?=
 =?us-ascii?Q?85GoVMLVfJyvUzIMtuz4nAoI3q0aWhny6b8aNWiIR7InejM+0fPxuHW5i1mg?=
 =?us-ascii?Q?MvBfbANhI5qLwugR/Su6LNB4Gl/5HIpzId/QjopoSG9jr39p7Y4oeX2i4Ikr?=
 =?us-ascii?Q?E6k5o4BkGQEqZgaV3J/kLATzCEcOe9Uaj0mbmTcsXwxDnzZPvWevNvZ+Y7nL?=
 =?us-ascii?Q?ssWoKUH3MPIP7PlxH37HV/lReXMzHJy7hf08JWwQ29oDdxTnmmb1glis8Q3/?=
 =?us-ascii?Q?P8rBAKbuM/yLXYG991A0HBJD5KUsdl1xnf5xo/9pkA2DKxudA5d97JTJB1uM?=
 =?us-ascii?Q?5u74zAtAKRTx/75aMbYVuQBvUghHhxPsFMHbejnqTm+hs5+TY8qCfcdHhmvl?=
 =?us-ascii?Q?PQqgFV3ouFUL8SIfQKInE4kaKqNYJMrYr0soN8AXldhgr8ABu/rAusNjxGNv?=
 =?us-ascii?Q?q8lxBNMV2PDUHPEAj3OaKQ0EUPle/+UoeJmmkSPunVQc+kmGuqkHvawpe77w?=
 =?us-ascii?Q?uqgjgo3PoEg2FnfMGsWcewb0X2PQtzNiKzvel074pHpke5k++VinWN2oMZfJ?=
 =?us-ascii?Q?vHt5xRkBjQ0TKDN6J8Ic987zhHdunQAzR7lG9fiITJt8JS8n7VmVSg5uJYTV?=
 =?us-ascii?Q?aHja0uayd5h4sWK7qWyalE+JedHyFbhS2nR/o8vflz7hKneZyhYojsTxsMCi?=
 =?us-ascii?Q?7VVz1aO79CwRMaQQVic6mO7thO2bIL/pqoXUVFeQGhuSXJaunILMsfoWIHgt?=
 =?us-ascii?Q?8BIfFNKzwbUe5s+OPWQH01hjD0VX3ZCNRaiDgfa1SxMupYB2n+ap/YGCUYDn?=
 =?us-ascii?Q?F04+OZffn+A0lJy16bRG3aEgyf6c+WTECQFiBBVJ+gTLHM0S2s7P+XRssun5?=
 =?us-ascii?Q?GYXpZdnF+WK17qaid2ORE4gtSqt9+sG5F5j3a468rpPQ6hUmPMlTRFDfOlza?=
 =?us-ascii?Q?XPtTw0279XolXbWJOBu8JYA0ER03Qphtx/qGCVrY/+SsCIIYTiRufVUWCId3?=
 =?us-ascii?Q?670Npk4RngElK03ONk4+1cHEkk0gG/GNQgvN5NyfJohD3n8vXOZvAmy4kDwq?=
 =?us-ascii?Q?nIV9zsP/Dy3EHk8CBIY/Ixo/80wW6VEPjACx2i1SLVlEUdSGEzjx/Nq9rZYS?=
 =?us-ascii?Q?K6dmKsU9WPNpfVqUXbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e2088-3b0e-4cb9-ae03-08dc4710ba0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 06:00:34.5779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OMu0P2MndFl5SQ9pB9LBt9j34ZDvCAmbC2bUA0YamV3OrusF1PDaO7fDKPkKa9mU8sTZLwSUBBenmJ8nJR+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

Got it. Thanks for reported that. Sent the patch for review.

Regards
Sunil khatri

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: Saturday, March 16, 2024 2:42 PM
To: Khatri, Sunil <Sunil.Khatri@amd.com>
Cc: Khatri, Sunil <Sunil.Khatri@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.=
freedesktop.org
Subject: Re: [bug report] drm/amdgpu: add ring buffer information in devcor=
edump

The static checker is just complaining about NULL checking that doesn't mak=
e sense.  It raises the question, can the pointer be NULL or not?

Based on your comments and from reviewing the code, I do not think it can b=
e NULL.  Thus the correct thing is to remove the unnecessary NULL check.

regards,
dan carpenter

