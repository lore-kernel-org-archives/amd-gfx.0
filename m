Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC3C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 17:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA3E10ED29;
	Fri, 14 Feb 2025 17:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="quY6a+Jt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F302610ED29
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 17:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+QyyI1d0nJtH9biJKSW3nvKRWJx9MsY53mbCIkk1Xe86uvXLcRZX4QAOZZTmhmtc781I6zcfk7hgBY4Rlx9yFQbD+tus1+tVVWPxxk2bxEVai95p69/l2KALPPFyDMjR1fIu7jk9gpAgYPanRs/5IYUxJm8ylvV0LwuwcMGqB3gX0sBXvU5U+5d5ly8ERhAWg5Gow7/yAWzaKfKrbrMHDy+pPwizZb4UI6HUC+vvlRdh00aYJqIVsnw1V2o5PcfFHYgqs+rhv6j/CRjvgqoGRWKpFnVrfKDvQk2CkxU8pDDErZJVmW6eAYsu0ynjSJOP6YaQHadbfdWdiC4Z5UQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FooyMq+uWnxgEzVehlMLUyfqKYlcaGodowbLdErM9ws=;
 b=W2j51FI4H6sUwYKrgTcYMWoNeaoP5acx1HGXYelfv4UKZmebgnyYlfkhfbDZR9Jlbm0Gv9lgIaM33SeWA2CyvzBJXETvuZ+ig5S/ddSZlYeIYD8bUTVjuwFwETqdhmD3su1UWFMoD33GrGr3qb4vBrtE/qReMHvFYuRoolvvjUXehrcOwPJyJlv+OMXgLYdwtskz0StU435Tda98UZPWmx2x8bzKkUvP2ElpIZcRtIaGqWwc9rL8z1/18vcUHe84g5d2MSTYC4eHJ7gIUWkub+WuAHh0HmhwPc3qfmD6WbLlRawNeNrLywdSzuP8D8QFn8/tJ+B4Nj+zF3Vke3GW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FooyMq+uWnxgEzVehlMLUyfqKYlcaGodowbLdErM9ws=;
 b=quY6a+JtcxKXxcT0n4Hm9fURID+B/UyNT0Y3tYeR3cPDi1kMGnsrlmdPIlcAmfiJhhGurnXzv0dAjSomtl3vEUFgB5XCo//t17NOamYubhoEG6uKmEJaKUgAxWbNDCE02ovInYT6aSG4jOBHaajAC+CF2hRPOqNIcOk1sOA9B2w=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 17:46:27 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:46:27 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPVkRimjnZ/jEuMrl0aS+yjm7NHARBAgAAC8QCAAAuhkIAAAdiAgAAAZxA=
Date: Fri, 14 Feb 2025 17:46:27 +0000
Message-ID: <CH0PR12MB5372F19D2E025DD5FB23A824F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
 <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CH0PR12MB53727651D93D9CE233CB86CFF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F2DD16616390864C9B72F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144F2DD16616390864C9B72F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T17:41:34.850Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM4PR12MB6157:EE_
x-ms-office365-filtering-correlation-id: fd3c63df-f0cc-4c66-5bdf-08dd4d1f81cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A/k4KBPnL5VjlnRODBhfDFbBdzijpmBtz2m+Ydi7WXqJcPuRKKA5a5Ez+l3Q?=
 =?us-ascii?Q?PFyEdAEf5kDBIQ6zyPU8R0AFfz7cYhLtks1xVvRvk4OwlB/jEX4inN/qh107?=
 =?us-ascii?Q?8pOTrQ+cgLjw6Vlt9gvQdBnwNDHwrSjtbisXxAtGg6NAu3FaBPrtKrpAcb+j?=
 =?us-ascii?Q?Q5HkTlyVz0uD+hd+bDdJjsFCuKa4nl25qZsqI3oYWwQuM/KY42H3isbUtbry?=
 =?us-ascii?Q?NDULQFD9734uo/0yJ4UKj8hLlixN2itca/qJn5EDNu8IlkXtd4Gno40fiT0k?=
 =?us-ascii?Q?1/riqViM3AgZwh8/OvDpvai9hoUpVYMVRG0QnWhuCYpkVAuiB4Iv1JOxur+p?=
 =?us-ascii?Q?6jVCbfa04Z178pAMcSOIe4XSr15v7usnOr6VkKz1OoP1KzpWM9QdN2a+vXgC?=
 =?us-ascii?Q?/YYDQYYmrGYB5/QkirI5R/YjER6a2sybDHPrvlbLewdYmcqg2Iw5Bek1hN7O?=
 =?us-ascii?Q?Jy7oVC9Io0ETzviX+KXEDcnYY781RIR/uEi1Lpc42GAdojR1DWZ/4Lgd3kW8?=
 =?us-ascii?Q?sbX6/QaIQ03/OFEe5FdrujKo48Y9PuasoawnHK8fJ1Z00bk1qmPJ3Ppr8XGG?=
 =?us-ascii?Q?+EORi/X2XU93As3cmBf6ncG0dtZBW/HEOmcaQkGgAi7Qqy2R0OCMoQau0L/V?=
 =?us-ascii?Q?vtOy6AFUVMp2L7s188dTl/9/pedpGfxg0DCHw1CLuNTKdCyNKg+W1W5WIPH9?=
 =?us-ascii?Q?VH1MDLkzFbgb4O2mPK83JhjQ7Cb+vwmXo1fwlOYsqzP32d5VzETt9z1JBTtE?=
 =?us-ascii?Q?mUzIJGSG6FusEQlgo+FFEe6o5D+QGb4HLhTmoF9tknrdOVwjAESTUM9cP+ZV?=
 =?us-ascii?Q?Aj9nnloektEjpn6cNCGk5y8R7HD46Q6N3TGYv1cWJ+sXxMY+R4GWct5Uic1a?=
 =?us-ascii?Q?TUD8bKcFJPoGyiUwbyRJUtwKuA3xp7qsDqDchrgBMuF1mXnStIZLU3BaQkSA?=
 =?us-ascii?Q?QiqtSmX8PfhtaVcRPk6iBEj8ntGCqTpSoaIQu6+m5Nx16yzvD8vVfU78Wle3?=
 =?us-ascii?Q?GSEU7Umq2QXP8SQyWhszCN4SRohwC+FCIff+INwXmHsbY50Oylq8uFtUYU8s?=
 =?us-ascii?Q?Vtw/6t4375YlLG2TogaE4FWOWRB5niGhalemTzpamqC0hX5Oq7u5P//oQVUa?=
 =?us-ascii?Q?xSrbRtNEv6wElXiZUFGbnaLiTbeidF432CvK0dzLkVHQH6ASMdOh3HpDVSmD?=
 =?us-ascii?Q?zD+y5kJ+2Y3hsII3NoVpQxipq63PWhgmabL6lqsxD12SOj9lGf58EBENu2yB?=
 =?us-ascii?Q?954q9cmWnVV64NzSOQApsXiHVRYkDjaZWyQl2Jhfe7Kik9BC1z6C8wda4Hok?=
 =?us-ascii?Q?83ghc8VEfQpvnslVAKlB7zLtz6nQSAuguVg8rACZzlYchu/szh/BlvtninSV?=
 =?us-ascii?Q?xOX6C/JuLTQv0NEPrpZSBfb+R1yuVv6TmkjoEEnjlacOzLxFrCQ6oTtnGP+I?=
 =?us-ascii?Q?5VdHNVQYLWHukYJIlDysG2rY8iOA5jzg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ab4wMPCTuZxIE1np1nK4nmwG0kqEO4ZYTqFGyeDTDSWnujMEspIpaM9Rx/9F?=
 =?us-ascii?Q?58Lnqx684B3QKCqGBxxC3TlAhuJaZBieciaDicjmhTwfYpg62qBzbqHFlpsq?=
 =?us-ascii?Q?uW8zr7IfAjinbPz8Av0YHs18lLU7vLI+CGZQ9X0zzH+15bbqaV10lzpSOPUY?=
 =?us-ascii?Q?VhayZhfDX2WZRZyvNhOj6r9YpZFT6AsiU6reEpWYwGEiVZ0pBXmfyOQfn5Bb?=
 =?us-ascii?Q?0OsAvh9ujD8kQLU1wOCr3btHtlq5P/QcrVus+3xzA0UU5HLZUDzfIVI5yn+L?=
 =?us-ascii?Q?mvbGD5hpFWC83jCum4XQtgQtpbNqdWh90At4mDJ+Fqkxcad8+xsTv6eQxGE0?=
 =?us-ascii?Q?OTsury/jy+6MtR8E8m8xxwGDoval1G8qLO3p8AfhT13h/knqGl+jhekmxjG2?=
 =?us-ascii?Q?GYfnPIR8hAfWHhIjWL8FUvvq4G7vum8RugvSq393qA0QidAQxENuwhvZldLK?=
 =?us-ascii?Q?9Annk0UgaAmqCthC0S2E3o4vPPpZlts6hi13ZMajfaV0P7ZJ8vYoxoQ/BpyJ?=
 =?us-ascii?Q?e17fEBiurGK2QQgJ2jgYilxgHlTJt910daEdB6eswJx7zmG7HiCr7ZcT4tuq?=
 =?us-ascii?Q?GoBXpx9XsoDYjab+Xt9vs64BO34N22QtHfZACd6AjRmvaIRgkOg4XI37TDoL?=
 =?us-ascii?Q?YZ4A8u/YdErFfd4/OrmtIOL6ohghqdx9ADTJWzDw1Mq55QZOSSPjXcvcM4Mx?=
 =?us-ascii?Q?CJu7chN1SscpPTqkDAJYs8TeUriclRwxpAmaWkuRbf1frCrItE+DFmj1pNSf?=
 =?us-ascii?Q?6MO0Co89f38hl6Pc964IyfZOZSmiYMcW5x3Vb6W7EPMm6g7PHD8XubcvC+jw?=
 =?us-ascii?Q?SpPZgIlD0oIiHQHclNRKq3efTNfLmlnsFnShMdeCtnvy+R72qQiEDI59V27d?=
 =?us-ascii?Q?R0kfAsMZx/426yEoUbbPuHUBjYgxBdHRY2JY6YMH1ezfVx1I7+12SooM5Vx/?=
 =?us-ascii?Q?srCeE5aWfRfU6d2o+3FpZdYHWZ1Vwk9S6vr8nKt8CU7z5J9kDLccFbIhsqub?=
 =?us-ascii?Q?wPGiQdbpLZthNU9XC/RakutQGn0+VAkx9oP2/33NWBH/vrVCEjbBOhhW0NWX?=
 =?us-ascii?Q?rzwJPJqESU+zyOZfm5fqOXMP1DmOaW6W+FqCl80tfyEZf6EX4PrEurNnjkHm?=
 =?us-ascii?Q?v5+MAucYomCMcqxmL1pHc+YYJgXJYjJ8OgqL331Umw4JNpGnMQqZuw2QME1k?=
 =?us-ascii?Q?mqjlKowuvOEVnsaYSOp8swAd8Gl6SlD/eb3RCqpBGNbGjVOGL27SJJlLWFKB?=
 =?us-ascii?Q?n3UlBO9sAJzX0C+qrcoDB4Q3w62j3f3Gsu/52tvOZq7EZnrBFqQFOfPqqhxj?=
 =?us-ascii?Q?kR6ohTZgQTKmzfDp1INxgVplHgWQ6s0vZn1TlU1gpSP4eAE6xBwO56kI/KC8?=
 =?us-ascii?Q?wXeyhOmaUw4tmmTriCTE94GE0ydpe67wOnaSfr/rVVdZhZKnu/f55gqsxsI8?=
 =?us-ascii?Q?GgKMOSwBc7yTrZ+vY/lmMf3jCoiwGOJHGiH2eq+3qVWWv8xvnug5eyQB38tS?=
 =?us-ascii?Q?DVA68s6sSuZxO+NscbwAPynga/1MN4T3bCNgdIDLyG7BVlwYiDe4EZi3SBqr?=
 =?us-ascii?Q?j71yYnN390yHdYcI0C4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372F19D2E025DD5FB23A824F4FE2CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3c63df-f0cc-4c66-5bdf-08dd4d1f81cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:46:27.2925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5oSEs0tBoUU+X0EGDZBDpcAA72dDLXXUl3MMn26mREt0Cxt/DtNfGQdZVgtIgnNBOnLcfsdjNExkyICjF+LCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

--_000_CH0PR12MB5372F19D2E025DD5FB23A824F4FE2CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Oh,  you right.  It's only for unified MES , for none-unified , it will sti=
ll use the kiq from CP directly on pipe1 . So there is no MES API for it at=
 all . It's my fault . please ignore my previous comments . Your current ch=
ange for this serials is good enough.

Regards
Shaoyun.liu

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 14, 2025 12:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce


[AMD Official Use Only - AMD Internal Distribution Only]

Does it matter which pipe we use for these packets?

Alex

________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 12:36 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce


[AMD Official Use Only - AMD Internal Distribution Only]


Ok .  From MES point of view , we expecting  both set_hw_resource and set_h=
w_resource_1 been called all the time.



Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com<mailto:Shaoyun.liu@amd.com>>



From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Friday, February 14, 2025 11:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]



I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.  Should we submit both the resourc=
e and resource_1 packets all the time?



Thanks,



Alex



________________________________

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 11:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

--_000_CH0PR12MB5372F19D2E025DD5FB23A824F4FE2CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Oh, &nbsp;you right. &nbsp;It&#8217;s only for unifie=
d MES , for none-unified , it will still use the kiq from CP directly on pi=
pe1 . So there is no MES API for it at all . It&#8217;s my fault . please
 ignore my previous comments . Your current change for this serials is good=
 enough.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Shaoyun.liu &nbsp;&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 12:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Does it matter which pip=
e we use for these packets?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Alex<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liu, S=
haoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&g=
t;<br>
<b>Sent:</b> Friday, February 14, 2025 12:36 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">Ok .&nbsp; From MES point of view , we expecting &nb=
sp;both set_hw_resource and set_hw_resource_1 been called all the time.
</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">Reviewed-by: Shaoyun.liu &lt;<a href=3D"mailto:Shaoy=
un.liu@amd.com">Shaoyun.liu@amd.com</a>&gt;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;<a hre=
f=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 11:53 AM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span><o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">I can add that as a fol=
low up patch as I don't want to change the current behavior to avoid a pote=
ntial regression.&nbsp; Should we submit both the resource and resource_1 p=
ackets all the time?</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">Thanks,</span><o:p></o:=
p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">Alex</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"color:black">&nbsp;</span><o:p></o:p=
></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liu, =
Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&=
gt;<br>
<b>Sent:</b> Friday, February 14, 2025 11:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEGI=
N"></a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&qu=
ot;,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
I'd suggest remove the&nbsp; enable_uni_mes check, set_hw_resource_1 is alw=
ays required for gfx12 and&nbsp; up. Especially after add the&nbsp; cleaner=
_shader_fence_addr there.<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, February 14, 2025 10:19 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once<b=
r>
<br>
Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 8dbab3834d82d..6db88584dd529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,<br=
>
<br>
&nbsp;static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int p=
ipe)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alloc_size =3D AMDGPU_GP=
U_PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D mes-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI_SET_HW_RESOURCES_1 =
mes_set_hw_res_1_pkt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_set_hw_res_1_pkt=
, 0, sizeof(mes_set_hw_res_1_pkt)); @@ -689,17 +686,6 @@ static int mes_v12=
_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.opco=
de =3D MES_SCH_API_SET_HW_RSRC_1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.dwsi=
ze =3D API_FRAME_SIZE_IN_DWORDS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.mes_kiq_unm=
ap_timeout =3D 0xa;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,=
 alloc_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to create mes resource_1=
 bo\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.cleaner_sha=
der_fence_mc_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mes-&gt;resource_1_gpu_addr;<br>
<br>
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE=
_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_gpu_a=
ddr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_addr)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;(%d) failed to create mes resource_1 bo\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGP=
U_MAX_MES_PIPES; pipe++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;mes.mqd_backup[pipe]);<br>
<br>
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
<br>
&nbsp;static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
2.48.1</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB5372F19D2E025DD5FB23A824F4FE2CH0PR12MB5372namp_--
