Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA0C60C41
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAA0C60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E2F897BC;
	Mon, 25 Oct 2021 16:07:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E1A897BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 16:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB884s6rGtF72swOIC2pwv43fNzp7Lhojpoor80BOmgwjGqoX/+ZyfxPspY6QCt0ldcLo7XowRaZ1UzMZce1Lp2+ohYIYnCtxnL/lMqdSkM5swYQU1MPTtyIeH13nmXgKGyHc+4hyIWpQz9t+7gd97mmFslCQe/iSDglIM8/muPUNldFYQfKHOQ2HJt9gMewnzIQwo1R1ixnjNDAVEb30ELIRdkNRTOV5Amh+NivwB4JuXf/iXXKLpdHLOEtP3btEY6lK+UFX02xfWzyanLHpi4QHsIUfstGj3N0XJRF3n9FGvkiwov6mxh6Yp5vwUf7K7d15G05hyT+8GlJr2gSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCJxWq1Kg15vtsoHhj0w9HqpAcF8UDPNbNMMOUSnhcI=;
 b=P1zjJQmlsuIHfIvOia/bfV6pDQPpXTkT3yXRQWoPYnLDHGb8QrYbANv+/Rx8caeRrw+C3jTm51fbVqXQfC+oMIgulR76PAfRH4wghEZk68wjkVSdIaRjSAXOr4h2TohIogAXks2ICxSuREqKsqfhJ+sLzru0w3x/VtStZW4dU9K8Yr5jbm0zytAyXY5a9xh5WQn+jYZfC00j6dz6f3htijGZCT0Bgtbjz4mv5zOWSAQjgsbDGA53OLXCwuyLDKRbaOa8r5UUywRT3QDJ3UfXYr9bYzcdvQs09LO8ReK5Zn0J+P8rzFYrd6rg/HIBeGHmgorNgMrzryw5JMfQDLlP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCJxWq1Kg15vtsoHhj0w9HqpAcF8UDPNbNMMOUSnhcI=;
 b=oPqo7Wb/TlLRurUh8HhVaPugeQaLvjKMA9Fo3bqEijvB1rB1++9iRA+xIqpI3OPjFS1es8ZNRPOjx3LdeOKFRyMkwhUCQpj9yVFkKQUQQl7gxzwKvQ3kIU0baxuyf7uwty9bgFxKZqQ0jrGMEaV4cEJqmKtUFonHfszh3u8l/58=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR1201MB0268.namprd12.prod.outlook.com (2603:10b6:4:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 16:07:31 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 16:07:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Topic: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Index: AQHXybm6w0FUBYuh0EeMCA5cnaCIdKvj4Ukg
Date: Mon, 25 Oct 2021 16:07:31 +0000
Message-ID: <DM6PR12MB33240AE46BA6992DEA46E4BF85839@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211025160220.51401-1-luben.tuikov@amd.com>
In-Reply-To: <20211025160220.51401-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T16:07:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ad79b00e-91c1-46de-b134-2321e0857d83;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b1bb40-f9b6-4ff5-7e8e-08d997d18cc6
x-ms-traffictypediagnostic: DM5PR1201MB0268:
x-microsoft-antispam-prvs: <DM5PR1201MB026816E3D47C3CF5FBE6827B85839@DM5PR1201MB0268.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7LvBaNxPGpX6B9O2g9wcFCjCEvJ9TJC/OmjVNncYGOmJLjBfliQ6Lu2BjdfvZyPzpWjsvpmQWaAUo96+iNP4/G9zf1FfgvMsou9zdvJh3bjATjFpdwMf91mUKemkc+K4Xuku9DK9VrT8/jS+WZaXSrGIJquNHC+eA7/jbr/pKg5UzXsmuiUCbwkLm6EOQV1ylwllj67qofLXKU0UmZZ8n+3ivqu6zEMN5seYwUBFKBNPmaSYET+FU3/oOS04/xxAiLUSrQSOBbdnSQiIWsVsUn5S2WoKOtJZ+5WaSaQHgOlgK7LDj2m0Lg7o9rXUQfTUHmLIWdp5yStaLc7AaCDJsN2At3ZtUQEhJopFzaVqcwqFeUX8NzLweg4dclV3c33wt/LswhNV6Sx7HBLQpbv2QwuLFDMQGMmYvZ8tTMipAvJl7kyVhAbpJ71AE8U3DuGjrVR0R3iLw+zGKTtBBYkB7Hgc8COOPkeYgycLEfvsqJPcZiFFYB9hmUTsgcPHMQK/z5wfleTDc+G3ss8yY2mTXbFFTGaNuIwhXs4mDgblp2F6JXQRMYHPNEo4xNLwdYpK/ZSCH4uCwisIX33Cf2IvdGQhotNfuAWsmxYgl4umhy+xihb0W2K32rG+rRZCJ9AdkVqUa7P5hFkr10l6IiGh6j01PcImiR2fWooAT2s5DkAhBTNdy5AzKOtBwUX1HRnUAU1Jbnsw54H5HB33+y8Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(66556008)(7696005)(86362001)(316002)(53546011)(76116006)(64756008)(38100700002)(110136005)(66446008)(66476007)(4326008)(2906002)(6506007)(66946007)(9686003)(508600001)(122000001)(71200400001)(186003)(33656002)(8676002)(8936002)(52536014)(5660300002)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?allavG1Dk6TPWKxW+s+j0UVFzbRS8KMHyd4bAhgMByhQ/es5WezPO4E8lU63?=
 =?us-ascii?Q?lBtUzbBFjjSWS1OcmTpNAuUGI/SjcTX4z+LPuCjqv1dXuhjPQmjACXVtv2Rw?=
 =?us-ascii?Q?qDuLqeSxYeXLXZFFoLPdyv0eF//qvzfLrtH21mNVkiA9BEVRCOGnnHohdQIe?=
 =?us-ascii?Q?9192rrKFn887e740+Yo7B/nA+C2ken87k8nXBrkusMA6HxcOWsjWHI5DoNl6?=
 =?us-ascii?Q?6EPr6h5x/u7jXIvkWZ5bJQyQZG6NTGfbtFW0ZPh1yR5mkCTopGWc5IBVab+t?=
 =?us-ascii?Q?065604kjDQoeZn8p+BPCsdgOTOIcJX8cv9whgPj00QviDS+6HHGhCnqFTBHX?=
 =?us-ascii?Q?G1TtABYaCxZV4LXn+S2mtPiCqC5HXtnr+vvSqToO0VpgnueDBQBY7D7La1XO?=
 =?us-ascii?Q?7+GCv8fbBzmbL9LjvUXXrwgVj+4Bo76WN4t9LIHTPNh0JOboj9LFiik6WA9k?=
 =?us-ascii?Q?3FvbfUsHC//pJJ1L2ARPI5tblnUA/9cBJJCrdeidaO3iMmbQYz117bTFet8p?=
 =?us-ascii?Q?baXpKq+LAIFIVHO2g/aM/VaX9SFkKHQbBHRp9k9oBwRKZOfBUSuwavP2UBdi?=
 =?us-ascii?Q?GGSfdWXDaYDxDEHQLwF5MOFxp+lpIoBvUvzr7lnrGCO03BxWYrl30dfdnw4K?=
 =?us-ascii?Q?MpJiDDSce75SP5jg9bCPl7bFhSIRXbBjXwWOoxiwmL0yEuxxbhvqEufR2ff2?=
 =?us-ascii?Q?UVhXIqdORVBGGW+odoelcJu7OfCZCrGHDR93UQNmetj2kJqrOFxBqAt18C9y?=
 =?us-ascii?Q?/09+lH48LmtPCIdEHvaNQQqueR+Z7DRv2586mqQHAwXSqfYYR91P5z1fNaBb?=
 =?us-ascii?Q?243x/+eL2HDAx7xTCMrXz52B5DX0bEI/8KRBT3nNu0m0wBselYRDk8r9EcY6?=
 =?us-ascii?Q?8/EdVB+V2KG1CYwoRQI8C9QbiXHzGrZ6CwG5yfG4kZJ+hAZZYjm1yom82MQZ?=
 =?us-ascii?Q?k2PMgVVetdtLo2NgCaK1bpO0jl50dzu5Un7+mbV4fBjcYxrdL/hov7nVkrs8?=
 =?us-ascii?Q?ZsTvg6UDanuEgcqe9Pif10IGCmTD3H9Y/US5He4jwihn3Bcq+Dy1Pc61oqr1?=
 =?us-ascii?Q?ZQCQ8zlCGoiiKGfM0sKUYdvAC7JEy9/Td8y7DuEyjaTMnQRvqItA989mWkAt?=
 =?us-ascii?Q?B4rtcpSl90GAdO8q9FfJ5xaqBv88073XhJ7r8Dad81KD8VZtlNiF/6AYhqFv?=
 =?us-ascii?Q?d9qQTK0JF6gP97hR5kqbji6PvVB51CwUvuNX108hEgWkyS5mMWkcf8JWfgSU?=
 =?us-ascii?Q?MOyUQmqnvGw2J4LDY2uZ2/3zZ5xsbWN/gbtDJ9hGIuIeNfh2bdO461KnY9RR?=
 =?us-ascii?Q?p0kspyxTmGvk03BNucs7mLH/WJO+Z1fPnlXy2IKVy0LoqCUGInRjXIwUSBfj?=
 =?us-ascii?Q?MtLieuO3qI+ZrtJhepa8nfPf0F7OCb+0ZS8Kj49O5DH6gXxMni8GGMKOGPzx?=
 =?us-ascii?Q?GzfNWGI+ynbzsDLI2SGoLTsPCkENSt9Zv6mVI7ibaymiQUD3BLx6w2kqtUww?=
 =?us-ascii?Q?rdw+N4ETlfidC7B3JK9B4ZmF/0Vie1As7CG783BT1nmZQrSMvoWO/ZSXGrMk?=
 =?us-ascii?Q?H0WD4/v2fmEiQvzkZB5tBK8N61KJl/5i/qx7J0/hGl1eJg6BDjWrrRXivr3b?=
 =?us-ascii?Q?bb7k07ljBsccmCOMlR492DNbY5Y7IekXR/ZeWQ49guYvJLsMGrbC2qRc0shG?=
 =?us-ascii?Q?YOog+uoQnOAWBE4BUi2Hx4qzeM0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b1bb40-f9b6-4ff5-7e8e-08d997d18cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 16:07:31.4154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3XzQErNrjF7m7uVXJYybqw0ut/ELeLE5u6LK8fAQseXJBVum/83OE6FbWOHfrgrVrWUxMyGo+u/5RB+JLsBxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0268
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

[AMD Official Use Only]

Thanks Luben

Reviewed-by: Kent Russell <kent.russell@amd.com>

 Kent

> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Monday, October 25, 2021 12:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Russell, Kent <Kent.Russell@amd=
.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Restore information reporting in RAS
>=20
> A recent patch took away the reporting of number of RAS records and
> the threshold due to the way it was edited/spliced on top of the code.
> This patch restores this reporting.
>=20
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Fixes: 07df2fb092d09e ("drm/amdgpu: Add kernel parameter support for igno=
ring bad page
> threshold")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ae64ca02ccc4f8..05117eda105b55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control,
>  				res =3D 0;
>  			} else {
>  				*exceed_err_limit =3D true;
> -				dev_err(adev->dev, "GPU will not be initialized. Replace this
> GPU or increase the threshold.");
> +				dev_err(adev->dev,
> +					"RAS records:%d exceed threshold:%d, "
> +					"GPU will not be initialized. Replace this GPU or
> increase the threshold",
> +					control->ras_num_recs, ras-
> >bad_page_cnt_threshold);
>  			}
>  		}
>  	} else {
>=20
> base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d
> --
> 2.33.1.558.g2bd2f258f4
