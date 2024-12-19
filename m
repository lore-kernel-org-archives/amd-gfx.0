Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC40E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C191210E175;
	Thu, 19 Dec 2024 14:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oOuhDOda";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4B810E175
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 14:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKnro9Z02v2suRCvSMNRhXHQRGMsAmTeaA6pQ1S7CmvysNAiZQlgROKn0KHQX3q3C4MFYtiZzG5Ab37af3TEn+wJ8B2ighFvbBc51BRHajClaWFN304f+6quaAlT3GwvgWzUFZwlh18aT2hFyZUXv94gl+tBjid3IMiG7l1TeOtH8kP2Jz1/Q3IKn3Eh3WDAtcIV8R/wP9E4xTEoSuFMf1ivx5G8HMBQDN8Rfuigh7WkwEiBkFEQ0S3oGwEBQ5mpd1MxpmJ/r+plfpJrRLS2xYu/6RU5KgQnOeiBKEICospvZFJRyDEgZgvqPlPuRofNJfZYyPiiB1zfLKcSfw3iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2xMEL7Z1wW+Ybqs9ffhJxRZlYYDk/QahOWEcODUHSo=;
 b=tqJzL0zd9vSiI4OfmBHuWvuZ+iEhcH3xGlS2TYKnJ2AvUbTnJIL9E/Jp0USA8YDBonvDQIoI6szp9yUaeHqXiu5d80WZy5vGLj3Qq0Nba4vdeiiNWADk2pUm1WSMhmdBMXsAqseVZI4ksNDdbH+QRHfRMcBCApUAZYjGnOWuWERlQSmb8Q/5k2BSmX57BxwFaOVV2A6BisaDApmsZJTPNLs1wucFcBUX+yPayzKsTHE8veuMmmjQqA8TmoPpGuBggjkLL74GBA/cOFoFYMYkzufeS54Kvx8ETlDGGgc6vukGojaEGIdd+Xd9mrO8inBx1WNRycD4mDfWvRHG5StAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2xMEL7Z1wW+Ybqs9ffhJxRZlYYDk/QahOWEcODUHSo=;
 b=oOuhDOdaNtZRogjRQnWsadxg/zlXsVx+kbaLeNsCCIpcuxUozqIweJmh5bD3ue3IgP2vxmYyDZItzA8pbHCmYEOD83KxHQipGGoXZiUeRpuNkJcrI6DYlq1gqzLo/+JUwdxMxGXNWZEgaAlxShbh8jOH60xpNJsh5Xl2FNd4Nrg=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 14:25:30 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186%7]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 14:25:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Topic: [PATCH] drm/amdkfd: fixed page fault when enable MES shader
 debugger
Thread-Index: AQHbUTc0Xwz232O9806e4gAbf589wrLtoJyg
Date: Thu, 19 Dec 2024 14:25:30 +0000
Message-ID: <BN9PR12MB5146344DB6935B387ACEB8B6F7062@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20241218102541.812627-1-jesse.zhang@amd.com>
In-Reply-To: <20241218102541.812627-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0aeeab81-2b21-4091-a146-871843e8b489;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-19T14:23:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA0PR12MB8983:EE_
x-ms-office365-filtering-correlation-id: 116f51cd-0024-4c0e-5a91-08dd2038fdae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Lklr/e3th9V3btZeCqswmmUQgUiVQJwDoU7BZ4QkZrgpxaR3uSzbhjtiAFgc?=
 =?us-ascii?Q?nB9Ls3Kp9UDVPbAp8q68mNNeHhzsHJKqn3176zz08Bf3DnXmYVF9TTNdYwPl?=
 =?us-ascii?Q?m69LflcTaXyyHiMBBp7se+BlDfwXxAWoLpaQfpmtIpAYMNVs6GVACnP6iTWJ?=
 =?us-ascii?Q?oywneep/PTuVQDEL0556thEF5oVmp8FzKidSeXI8vAtypChu5+8tstdOyUX/?=
 =?us-ascii?Q?1kTun05gtFnsR5+8czYNQUz/ovf6thjemexN+uqmW8V6lD6fKlKKMSYJVDJ6?=
 =?us-ascii?Q?8k2SBa+PLIchLDHi+fBA/M/85CCyBY8quKOp08StWWZ8O9WqdeIfMbNhdz3N?=
 =?us-ascii?Q?GcswnORBnSxVSHi+8NmYSGrfZNo+0TP8a/9oLlL4Ix+EA8KIejodk0jH1ntZ?=
 =?us-ascii?Q?53seEQkBbjUK69oM2ZUkcwAmEkYI4HcAPML3f/l6D+qlu/ADG9Q+DfT+meFO?=
 =?us-ascii?Q?5Dhx9werAaFsYpv4MJAD8Fj6MQT53jE4CTNjNcYmP1QeMee0EVQfEqC4pxrS?=
 =?us-ascii?Q?crxonJ0p8Wme+XqCGFq2Csy1iTKvwSnoNntYk4AqQyLw/48JoVBsHgdm+5bL?=
 =?us-ascii?Q?myZUryyFH6jHUpgEHgX96w2XFQB3Lz2vPX56UTn3mLaiHLaN1zX/CFqU2VMP?=
 =?us-ascii?Q?i2hvKtFVoZRM8RICLgDiIxAwJlk4ZCVkJ/yXNcYehJw2I7XENZ2Y2t3hsVpv?=
 =?us-ascii?Q?SOBmASMGT32nWHSfFLoYmx1+69rE15u+9gTwxaCrUs6zgYttKFyW1yv+Z97X?=
 =?us-ascii?Q?4hn3oNB/qXEyTHNVsjqp1V5NKmjjZtec+JHv5xuY10dtUgD82MH7/s8aHN46?=
 =?us-ascii?Q?WDUXEzo+6J0ngbXOublGsXVatvehrSGfnE6F2T3NwVUQ52RjDVI5IjcfjJSS?=
 =?us-ascii?Q?pFIF0RVWLQ6c8UBXX542a/gOjbxdnl08PUvvluIvfshEjHpiXRCF3D1rCFey?=
 =?us-ascii?Q?IxT73Fr5OCP9+LA2956U54eYVg7o5c6aYw9KIKGxmsMs+hYzb6T7Y1eo6ef7?=
 =?us-ascii?Q?dCAHA+4RIpKL0yxRSYXS/nYOSceGd0ONOyRb4aJ1mP1I1mRldbCruOif+SQM?=
 =?us-ascii?Q?oNKW2USnzEXYRrHIVxjAvKzblunsvPEWP0zDJDW2ljCTDDlxWAKpuTN8Jg+H?=
 =?us-ascii?Q?KAu1Refh35bahqKKFVOCeIygd+Rp2xlBo6MDaW4k6fAO7RF0Dp8DumfoECNL?=
 =?us-ascii?Q?43Wkk4CLndPzuZfJY8f+/SAN51wF1G5N9VyCEXWpDhDf9+ADsT+LcH2+/REc?=
 =?us-ascii?Q?PhcXeo73zBtqxxgtQpqGV0zsOMvGpoLjpQ4BXFm9hk01ldOkafPpv4tYqTFu?=
 =?us-ascii?Q?eJzTuUS1+FQs1tiAHU7oYIq77RvjaDw04VlySCaTIzvQxMgb8uDEJYmdDZOG?=
 =?us-ascii?Q?d2YVy39x//cf9+881KIbi5r0IhfCjlatSXZphyN9yaoIYrGnk2Gppvznk4Go?=
 =?us-ascii?Q?qOzdy04IPAKz05FknHddEnsIAL0j484R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iwb7qTyYpXK8T0RCPbyRyuAeetzIJblmGYtle4794Ke6g281EAEzVQmhiE4B?=
 =?us-ascii?Q?7hmrTdXwKkG3LRBoJrMM7o6KDzPIEcv+FygE64V63GbkyhkzczxYjidYKNXg?=
 =?us-ascii?Q?1y/TIxzIJz91GvR5Y9sMr0QGp7FXeZO6JyD2rSQnvrw0Xwn9EZT7IqW0XlXo?=
 =?us-ascii?Q?25JXsQj7/ledtQa2xEVYcl00qiZN0/eNEjfaTywgrWGZXw8ALR9YpaXwGHky?=
 =?us-ascii?Q?D59QqICROprQNu72abAbzpes8WPPcQ3rC9WNIhyZZnyQsYuCeMJdFxtYIXJG?=
 =?us-ascii?Q?esxe/RKksynwhnYd3jOdRnYqasKGz2ofKh/KvwA+pG5bQhbfcmgBy8LQa3O5?=
 =?us-ascii?Q?awcMccOwUuKDHv5Rsu7wXuPwFbWcqQUE1eP6XDimN0c10xOAXwhiGHx8t1Hc?=
 =?us-ascii?Q?vnFJCx2a9obmT2WFqGBhphwh/lVxSPv8TMH/ogCFL+KSFlx3xMGpNf6YNhtq?=
 =?us-ascii?Q?hGXY4i7Nfd6owBDo98LSJvb9nWfCC4cScSiJy+/QDMXV5GvzxxkYLr4LmbO0?=
 =?us-ascii?Q?cSfhA9uU91XnkellAhC6405gsajbCk3Nv2xKDhWy8qIgS8Q99fEUttdl0Wes?=
 =?us-ascii?Q?WKM0ZLue1/tZGSQ69dvKqh3VXmtO7cYsk1UaQfM2+4tjqCkM8QbnxQEs9Fs6?=
 =?us-ascii?Q?TNuM2rGpdjpZO/z1xnxhkciYpzFJGoTfUCKhCmQlPiqk3jsnK/MkWApkgkH3?=
 =?us-ascii?Q?qsr1vhpKbJ30AxGYWOnAirDPnQOqRN1TK2VX6Uje8JC0uLY+dvEL/cxrkX9s?=
 =?us-ascii?Q?x7SxoF+zcwVdmpqM+beD7t6e+/tjkHcXNW8Sew17XbNXZcL3LQBIGCIHlcFf?=
 =?us-ascii?Q?EokHNzizV2sqAiMXjwY9xyWggHpYv4lGwkrsrK801f5DBSORoLySPjXOD7qp?=
 =?us-ascii?Q?PYAlTlVet6YugsrApWHZgGRW5EI/0uiKGeC2g83ad1xKMdsWGuR7cWHo5icw?=
 =?us-ascii?Q?YdJ2dJv4tShr8yjjl5NcjGh5BrzvsELfd7fV/tLGrHB0HTqy4L+CSDyj31XX?=
 =?us-ascii?Q?1J02dxxSIKUBrNE4Xb1duPHGrEOLWnrN141KQs9+qfyqVdFyFAM2gJLwC4eh?=
 =?us-ascii?Q?0NOf0sO3PsTZ/l/iaKmaWwdjjxln5zZViewAzYIaWyUdvh9g6+MIDEPO+fC1?=
 =?us-ascii?Q?UmPvYtximDjnq+TEmbjUnRc29PZrqH+TXk1kq8OuVQVb+VuQ8/WBUSlHuxwm?=
 =?us-ascii?Q?BLixTw3hIr3QL18B6yrREJ9tuYetpUPlyWnWfjsE1zQxtfZPggI1YE9hCJxI?=
 =?us-ascii?Q?+gW1QdolSm5Yb70eJTLfmguHLxz8PnqxaT1nSfaM44puhcjjxaKsqsloQGvK?=
 =?us-ascii?Q?OiA7FdXtnLnaFYg78zLtUs0v7nwa39p1zpD2PDnDQBzBXpDtIXxws48rmfwJ?=
 =?us-ascii?Q?D4yV2CffMikd1DALwz5dOQPG6s9rpoSSW+BeJoq0W+k23h2yJ6ocnkiI7pj5?=
 =?us-ascii?Q?YcAiFW9C9DhGXzAFvfEKHY/G+8GwRTU5u7UWppoKlb31d8BbYOHCf2Jb1onw?=
 =?us-ascii?Q?xSkDN/SWsEG+nLjS9sg3dlKzxfnS5bHKSrL5P5ehajeBWM3epl2pO+DxGl7z?=
 =?us-ascii?Q?6mKM8pEf/dv8e1L5qxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116f51cd-0024-4c0e-5a91-08dd2038fdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 14:25:30.2540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGS9LmovIr0DqB1R9fr4MbONEGj1t9Lyi1b4MP1kIWv5CYyxBCCg+Fa5E1bUa+bFvriNG6Us+NOUZz3QDwPV0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

[Public]

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Wednesday, December 18, 2024 5:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: fixed page fault when enable MES shader debu=
gger
>
> Initialize the process context address before setting the shader debugger=
.
>
> [  260.781212] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.781236] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
> [  260.781255] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A40
> [  260.781270] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: =
CPC
> (0x5)
> [  260.781284] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x0
> [  260.781296] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
> [  260.781308] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
> [  260.781320] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [  260.781332] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
> [  260.782017] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.782039] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
> [  260.782058] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A41
> [  260.782073] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: =
CPC
> (0x5)
> [  260.782087] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x1
> [  260.782098] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
> [  260.782110] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
> [  260.782122] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [  260.782137] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
> [  260.782155] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:32
> vmid:0 pasid:0)
> [  260.782166] amdgpu 0000:03:00.0: amdgpu:   in page starting at address
> 0x0000000000000000 from client 10
>

Fixes: 438b39ac74e2 ("drm/amdkfd: pause autosuspend when creating pdd")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 312dfa84f29f..a8abc3091801 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -350,10 +350,27 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)  {
>       uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd-
> >spi_dbg_launch_mode;
>       uint32_t flags =3D pdd->process->dbg_flags;
> +     struct amdgpu_device *adev =3D pdd->dev->adev;
> +     int r;
>
>       if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>               return 0;
>
> +     if (!pdd->proc_ctx_cpu_ptr) {
> +                     r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
> +                             AMDGPU_MES_PROC_CTX_SIZE,
> +                             &pdd->proc_ctx_bo,
> +                             &pdd->proc_ctx_gpu_addr,
> +                             &pdd->proc_ctx_cpu_ptr,
> +                             false);
> +             if (r) {
> +                     dev_err(adev->dev,
> +                     "failed to allocate process context bo\n");
> +                     return r;
> +             }
> +             memset(pdd->proc_ctx_cpu_ptr, 0,
> AMDGPU_MES_PROC_CTX_SIZE);
> +     }
> +
>       return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd-
> >proc_ctx_gpu_addr, spi_dbg_cntl,
>                                               pdd->watch_points, flags, s=
q_trap_en);
> }
> --
> 2.25.1

