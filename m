Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA22C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 05:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB5810E67B;
	Tue,  8 Feb 2022 05:42:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A35210E67B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 05:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmaOBasRl+4rRTfZ+FatMjrM8AZ1jOpKOAVvI+ziXHT15TBFNSijvtmhlLpp8X9McL6SEOex5nJfUIkGg3vbK0FYQxs+qQVew4cPn9O8YlMZysIozQe45S0mvlq7S0izZ80/KnATj5n6C3vjagmHK96ZprP0aVIeeL87GT22GJMxRDH8rUiBkx4XdSmqpVbLD6wdw2n7QlGahJ5fKq5zbA3Wts1oIS+1tMa9QdsSmzYVCBoAn88XwfVDJx6qAwjqEFlA6T0mwxafSnYN5DhjLGvmiHia+5w2NYcwvEZHb/Y8jsobxs+PG/Bj89lBuPqTFIA29izNhhQHBrBkw4PTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+bO9nufi3spslb19r18S2yl04yg0ypJI5hNonooAoo=;
 b=Y/KIwdeHboV6rx5a6ArEZlZFtE+8yzp51cYIj1xweMNwBU9B6Cv7Y5J6XHL27jFO/exYII9R5CU6tG2yYiWZHw9l9+RenLcnGde/qxpjkTxr5iojPeX2okMGGxeXku707NfUNL4ZZMbdwBjvXfBtUfkZVpVwW5+iO2gESm3HSYSmUVoEr+UFxudFdf2nB01NDE4ILHHvXxGfGSLHeHpARB9zsjYcnzP9UsjL0wbC0xQuR7aEkN71OkoZctxuZ9F8OekXrX8lDSp5vYxkq9GvehDHvgs+KL9tPKMLbRWXACgvgCxMb5BWIuQKYj28DnRJ4C15R2OkjogagwTppGD01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bO9nufi3spslb19r18S2yl04yg0ypJI5hNonooAoo=;
 b=jN+zPtUTb5hydy2NN0crLM30XLQu0vB0kzRD6fjkg60n/3QVsTUGhwHt1hM1lFTcyl68p3QdxeDqlkYn7FH3IIl9OK3X8Z328V8i30hk5TsS18zGdzNPk9DJ6r7oN4nDXRu1mOi53DUXDBkrZp9VAL43BmCgAeCmCDchSdogq2s=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 05:42:05 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::68d5:cffb:98f4:c945]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::68d5:cffb:98f4:c945%6]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:42:04 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: disable GetPptLimit message in sriov mode
Thread-Topic: [PATCH] drm/amd/pm: disable GetPptLimit message in sriov mode
Thread-Index: AQHYHKSjnut+48HjpUmOzDDp3Tg04qyJI6Aw
Date: Tue, 8 Feb 2022 05:42:04 +0000
Message-ID: <DM4PR12MB516593BB1A9229FF95090B4D8E2D9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220208043027.127195-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220208043027.127195-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59715c78-b0c6-49a9-727f-08d9eac5bca3
x-ms-traffictypediagnostic: MW5PR12MB5599:EE_
x-microsoft-antispam-prvs: <MW5PR12MB5599F5CF7D72984CF61AF17E8E2D9@MW5PR12MB5599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jf51QOulaQK75eRMz+HSrO13ce1STPf0f45CltfKlCmDY2b26ZZ7Mj4WCytrBcPsih4n0Skj8qewZnnq8/0ROa/9bxfAqhZiS1ZySC9gMZXTZEfKujZeyriVTnl3i+XqdAHCXiOJRgi3UmBcjGZ0UnHuEvkL0hFahWW+acNknT/mko8bVKo5WJzSu1uHpNvjGetXrOdotyrFhEfqwx84rIYrecQiitygPa0F1voy8qKXVxtlfTt5NXboh+I5Gc8r+kZOb10EHrJCPKGZgR7GA3E/d6plCoO/cwZXFbV9KMfgwCucQSp1b46b7ZJPskw1Y8EgCy/wCKlQki7bSU7lrEEm1R0Vcas7ZJjDsQKmZje7Zo/XI8ck9yOEk9Mqs0HjEeFV352LpySA2jPcBMOqwkK2KU2333IOYDTLKyO3w2aXL4IWB3ZjU78Lts2kUJ8WNCmP+R8jsnmX+HSvd8ny87dozteNlVNiSD9yeaC18MAe9F7Pcr8wXuTtinkAoiC6QPBY0xt9bMrWYv/oK+HHLo9OANKI0tYGg9KyZA8ggH0H9AzYSeAkyWkGnXzRp4kLxdA3MBtFAAhh/aQs5EDX21tyPK62Z+epZyqlfNhTZPkKRUQfdGjUMs6KD8HUehM/FfEZZKuM4GVtQOchq71PoEoq9Wurel5R/tB/ptZJMde0JfBnEc2uV5Cv/WVAt7psopvcZuHf/BZCfAENkfx3/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(7696005)(55016003)(9686003)(508600001)(8676002)(110136005)(6506007)(38100700002)(71200400001)(86362001)(83380400001)(122000001)(54906003)(186003)(8936002)(52536014)(33656002)(5660300002)(66556008)(76116006)(4326008)(66946007)(64756008)(316002)(53546011)(66476007)(26005)(66446008)(15650500001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EK4yEoo2RFFMyQNIakiOq5J++0jY4r1j0Q5yUaUbsTuJpME54//RdUug17UO?=
 =?us-ascii?Q?l+WucGwSJZIGh+EQIir2nZ9KtZ7pEGM7UUCfCeBaYGvcnHpAGkPYFziKSyHP?=
 =?us-ascii?Q?rThof6vmgADm4iiV+5C4H/3hk0ut69F0bipY9StrKFqnFz4eMQHJVdQP0Vnz?=
 =?us-ascii?Q?X11WsJg9wlsWbyfTJWxCBWwI9VqRRQhgkxP1d0JddGdB+MGqUUgVbJWE9y/J?=
 =?us-ascii?Q?S2Ei1HKilSFLcY3+Znr/jBtM65bELcZvqVgLjnL+OXKiVdGhRab+bS3UnNF3?=
 =?us-ascii?Q?OdTB9diqSjHCO4Ji5cQ+hwdYlTekEhsZ7E6f0r7JTgYZkssMklOAnQd2TqKZ?=
 =?us-ascii?Q?CDO0CfIkDTJOMOZCeWJQpcw5xmB5GS8QOH0LAEBu2ZuxOZRoA3Rfa6OTocxO?=
 =?us-ascii?Q?B0N1zKpPsayNzuaUpcfT4tRWYbYy2Bi24MX+0kzwKMRJ1k4kADy7rItZSooE?=
 =?us-ascii?Q?UzZ9jCVaWnnsOGgWllYyO1u4aS/2er+SfPTGmXPcvKSywSZV5mQIR/iMYnTz?=
 =?us-ascii?Q?0Z6YqSGn96Ex8pYm8nDSom9V6xonFyEmsFq0BSMZGWLFTBr8Hdbv2mlMaQ0i?=
 =?us-ascii?Q?smCThVvrQlSJ4oNlV7in0sFxfFFIlwbUS/SjNj12QnMMgLObG4juttsX3gZS?=
 =?us-ascii?Q?qPCpppdjDbTtLX+haX5N9FZypgMS18hHFMwvQyLdsInHrAn+vXU3XiDOTojR?=
 =?us-ascii?Q?8GtIjd3Ge/uOoV8VoSAnZLSD3FM1lnLyEKjAUsXDsmtipXt16LeC+LW91m4A?=
 =?us-ascii?Q?uYtYqhICFkrR1hZVwrBdE2nsKk2KNGeuVEwCIVuEtcwrlNAYzDsm2H0Ffi6L?=
 =?us-ascii?Q?0QQftuQj6MfSqub+VWGVENiIXc5UDBcJIpxemB2W2yB5J8nih6c5LhW8yqNB?=
 =?us-ascii?Q?AjP5WxQ3QJvbGUbvGijDT4dcu1PmrXQIRz7rs7eKZr7UeGBBeSGeT9nzFQGr?=
 =?us-ascii?Q?O7ld7n37wXcannt0105MpH1+fCg3WPiBC0q+RwxJG7dvSIaOYhuA8ldpQJ7O?=
 =?us-ascii?Q?5mRRwetcT54PqDPvrTRklWTJKm8XlYJ3t+mxrC9Ke6ffI8Drnap3Sal5PmYG?=
 =?us-ascii?Q?xkkPsK6AZT9qGMoVQA93R3Q56z7RsnK6j9mQ+6TYoHzyBM/nwg57X9AU94eN?=
 =?us-ascii?Q?8vwhXzDMEdubUwy0AKxbBgleBEz+6ykhIMm7aaF0sisL8O/QI7zsBdiRWUnq?=
 =?us-ascii?Q?OyKPQhodTxTskNkSbx9PPLvZfeQKAeiDFb3JisjRoN2pQ3adU8eJpjL6AShV?=
 =?us-ascii?Q?AYt4tjJ1FNm//o6GTifYo+40e5gayY9a0Pv6PumaVchwPtOXVs1g6hwi1p9C?=
 =?us-ascii?Q?M0LLCWQkZgjqrwGsSsbg9/1ZyNp7Hy67gYQOhlCi59W/vm4N4cRmdinkCUfo?=
 =?us-ascii?Q?cu5pohykO2XYvH59QhubqCp3fnhmE/w/E7ouqnzsbI+SwKOdQHY72jd8ZmsJ?=
 =?us-ascii?Q?JbUfzCug37NmVgKj/opM3o5owGvebB0wO0sGVY0qjQruwLJLUZ95H65OE9vF?=
 =?us-ascii?Q?cYO4m6A30n4xZat9HY8WViNM02VIOdbWtSboE+Or79diLLVoeeKTPHFnS2vr?=
 =?us-ascii?Q?BXKMb9VVSzpXnGVlPcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59715c78-b0c6-49a9-727f-08d9eac5bca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 05:42:04.2046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4hNetZeVOUwOvX4xUduDP7s4sxU6OFDqJPypZpshybZ6Fo55ZdxTd6ejahs6xyJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Nikolic,
 Marina" <Marina.Nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>=20
Sent: Tuesday, February 8, 2022 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;=
 Nikolic, Marina <Marina.Nikolic@amd.com>; Wang, Yang(Kevin) <KevinYang.Wan=
g@amd.com>
Subject: [PATCH] drm/amd/pm: disable GetPptLimit message in sriov mode

the pmfw is not allowed GetPptLimit message in virtualzation mode.

Fixes: 3e4a01689daa ("drm/amd/pm: Enable sysfs required by rocm-smi toolfor=
 One VF mode")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 804e1c98238d..2a7da2bad96a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
 	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
 	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
--=20
2.25.1

