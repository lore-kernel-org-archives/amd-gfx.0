Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CAB60F22
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0CAB60F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F9289DB8;
	Thu, 21 Oct 2021 02:32:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C7989DB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 02:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU3CnHmLxIb1lwbkN+6Xj0y5bzKxW3yRdjsVXv6a4MZI5DpOyBeiCjylMFY2wO+ZyNsW10pcFhJCwFmpqnspfzYnGMNC4pnUbGSq3HCcMnszoiVGanauzfx9fIhSDMCAW+GSmt6RMOneLyLaDMT3srepi+HZoF2KVlwwLkQhhWpnWoYy94VO7oCK6at1WB8yXe63cX70SkdHoEaJBPPbsb7aSUls1n9XLwP3CTm7KP+JT4TxyIPaBPkqAS5C8aCMaz3lyLPaxg+Q5YD/zoK90V7VfpaVVSI9V35WisReSGpFC1aUX+FmqEL2jbQ01WrvLqacTcR1ao+amtulOeRqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CcfDZ+/21LBErfN0/R7eV3Ka2BtyGJl8jYWZNFY1Xk=;
 b=gjcbc7yhir679E7buTIfEiBQRKpTEFH9gRv9Cm8xqbMvLPDWGLIJGWQWlV278f2s5fcQcFgaad0xS5YQKOikEnEm6zz5XsmlgHrGYe51VyqyAELRFQlLENDRbAODwIPB93/UUlEZPfVgMEbc6wNR91eoL+bZ9RoCHcLcDY4KhVLHUysTDqNA/5O6Sy5g6799IKMsF5d6YXJF7431x0m6QWAGa3DVknwlu+fFF8Y66Ga0bLV+9MvykXKvyhPcBIbbuDxq/vKbpKseWzySMhJ0e30FBxhVelqHYjmzAFepHffINrnRwtBxfOWWptgLI7N1xHrSSkEWk9KIigoOeI0V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CcfDZ+/21LBErfN0/R7eV3Ka2BtyGJl8jYWZNFY1Xk=;
 b=yEEzpehUVjftAu2s23GL4D9opA50dDyZVlDXsE7RrS3dgKWs7rYqmVLCbz6g/PHCGwilnGl1vmnYZmjhjwkejlTlwOPtUf0LqVDyRSqvWbnW3VqJv4B6cHHw9cvN35ZHLSQKTnkieTJypJqveco4LQxZLtgSrb49bMlJMmDmtTI=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 02:32:29 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0%7]) with mapi id 15.20.4628.016; Thu, 21 Oct 2021
 02:32:29 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of driver
Thread-Topic: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of
 driver
Thread-Index: AQHXxbnolwHJt6nOdEGy6XLZAi8nW6vcvAmA
Date: Thu, 21 Oct 2021 02:32:29 +0000
Message-ID: <BL1PR12MB52370188D50242A2E68C1D3EF0BF9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20211020135321.1011977-1-alexander.deucher@amd.com>
In-Reply-To: <20211020135321.1011977-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T02:32:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bfde6414-4198-40a8-a477-30e09496c6aa;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92df1190-7a30-4e94-0d71-08d9943b076a
x-ms-traffictypediagnostic: BL1PR12MB5160:
x-microsoft-antispam-prvs: <BL1PR12MB51609B8028C51A958A006501F0BF9@BL1PR12MB5160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHLl54RVpkEoe9bMbvAJaVuCCjic4Lr5Pwbllt7gX5BD2KXQCCAy9bg5DoomPpMocW3Wuba6amwG8VBsNls0Gb1hG86FER7TTG7MyEeDUxP6Oy9yfsOD7oo3TSBKoa+5k8lHco/z383l2FToRIPlOewKmXV5wXQbDa2zDuJKI5dHlMCzs3UFBEzNkslGg09huCKKsJ0C4kcaN0IVlDnxnRvcqHsnZdNLIic/GGnrXMev7UZibA/vqZJaXlveJxf3ve+WL4zHc4rJWqOyd9oei5HNZCOHhkH+VY6TeUlq4pLhbVUwQTHhu1hluUF80RBCvPe9xCMH0/91DIPvaGPKzcegKe8/TQUI/avjgqYQolx/yAaSauBDt/2gJfWbf0DGee7ZfcQcRPo1+CKf+WovJWKaBK8HmRqAjquSTdgFYYg9zbXHMB5ZOvhizQ5FNdKf8dosnpjvQKoFNJWCibwOgERf4YsAlkOSAd0PDhjuyKuZgCSGnwNFH5iefU/CoZGFJNGV+mAUYRYNuQUL+lmkDvEZdTsM4QtW7cbPZhrEyJBppzNH6yq3jca169C5bS5VuYZ3jDFsPuAn/Yj0X3e+q5ks7zkxeHdJDxhWVQb7GCFsL3BU+QCPl38+oULytBvrioysDWuGD0QUTXf2LHEr5wI9zrS0WDZph1j2xZoi3sRFdIiQZ31jcIBgTk1XMCdWSVKIHwl1x2m2sTJ+NfZaSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(66446008)(8676002)(76116006)(66946007)(8936002)(53546011)(6506007)(66556008)(64756008)(26005)(66476007)(2906002)(52536014)(5660300002)(83380400001)(508600001)(110136005)(33656002)(316002)(38100700002)(38070700005)(86362001)(4326008)(186003)(71200400001)(7696005)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Gig6nmIn9ICrFjbQFlU0QSoHFMPbaK4obNBSDFpjt1jUbyMJ9+coZkPrIQ4?=
 =?us-ascii?Q?m5jAkIJXyvsDIrbunBpHxymKMcYOwIThvojZ//vohWQQm/5wGWyFU4YVJUMo?=
 =?us-ascii?Q?TF9VfM3zK+GVGSzSaJ43a1na2VU4k6wwnzi8twRnesk8utzDDAeHL2aQwoQ4?=
 =?us-ascii?Q?wAWg9R+VAR8HhLSfCU3rQ84Vy4ysfGMqlMArjBYKFsJo/bXwqJ0dCyWSt9nj?=
 =?us-ascii?Q?OSSRHKB5M8dR/0DvFLyzNtsySQw+k9Y8A2sfsNDbxqM8ED2wmA+Lg99a6fED?=
 =?us-ascii?Q?ENmFjNbJhQS7UWMII3u1w2iQXiFh9Pp4yETbssN9rCujmC+j8QFLw9cTjqft?=
 =?us-ascii?Q?dx4cMmyn7ZbY5DkldeffvU7fE+nDjgPnAKT6jPfjYbo90rrgDt1xLgqUUgqj?=
 =?us-ascii?Q?CwDTW7IHGtT6EbXNDwDCWBPMyUGPpRIPQkSPDhcZWrWuKLb+/UIyLBKW092v?=
 =?us-ascii?Q?x+LVDbkqaV5kjo6updifjgbUrFlyiX+cqUcPgBYpkv9eGdgqoZKWDYYXXT2b?=
 =?us-ascii?Q?lN6KN486EXz4JfzrD3y2N+qXE1ToiHT6ZE5PsR3BbswoorLeXVThdmd7LrTR?=
 =?us-ascii?Q?7F1dyA9QQcbRDsG1Z+RRiPhd+V7bW88oGJj0fLmoW+zBbfKGSogYDj28v58x?=
 =?us-ascii?Q?8gPf0HuMkl1tNkLefCWsx1ignbZ310d6EUKkjZwA2RYlujtOkdADqY7WHeGA?=
 =?us-ascii?Q?qAxR1IzDak8fih0Lh1UWVQRU5c+ml3mdAzyHn1HdZTBegYf3nnOa609w6LGy?=
 =?us-ascii?Q?9ioTIBoe5gzvfaYwleEmxPz7aG0Uw28y8GKU2ICRFUDtJKqXTfeOznQorhvW?=
 =?us-ascii?Q?lQlD7u0xGHZqon3nDx7IlXgQcRpNfTusqIlKrQF4KqXQr0KFHaCpHRB+PH9j?=
 =?us-ascii?Q?JsuaSTZxGEhkAdq4ySewmRLImhxN/81s71yafspnBMo0Nc1w4+EKewIKMHhJ?=
 =?us-ascii?Q?Au/gfcDAEClhjEdKR557FzYuBKZrI742Gs9vrZy6/sOk/7wQkngSmIHTuA/s?=
 =?us-ascii?Q?6uBOv4cYQV1ii/UVQPoXpsyblbH+A2TffZBtom+LBNIQ1JJgpqzk6eGr5dvv?=
 =?us-ascii?Q?AiJ9LCbyA65JjNvxMF6xh3QU5/9YquZxNQgvnd7jotTi6tRmLNWsiXAlC2Nh?=
 =?us-ascii?Q?RFwKPqDknvwiNhL4ZkYD3qd49ly2g7A1Qtf2oCpsNte7Wm/3Y6dURYtvmASn?=
 =?us-ascii?Q?d92s0jWiavomTPEo0u0OMKpv18oqpYaKF9iYiWxziBwWSUJmaepP8Cu3P94s?=
 =?us-ascii?Q?08fh7Vv6B4JLmuYyWSl2YZ/ObXhqWK2qoD7fScFpBaH9N0fpjlisOwZyazG5?=
 =?us-ascii?Q?1/gf391ANx+VVl+RDQD+2MpBdTh9DAeFXG4FD5hDA/ekx8cw9PqKJ12ZPzl5?=
 =?us-ascii?Q?97+VhQ5dOMkQcz6f+FDXlG1Ps7JW8t+P6E7glCLYIv2u8tTdoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92df1190-7a30-4e94-0d71-08d9943b076a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 02:32:29.6345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaliu@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, October 20, 2021 9:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of
> driver
>=20
> Fix revision id.
>=20
> Fixes: 626cbb641f1052 ("drm/amdgpu: support B0&B1 external revision id
> for yellow carp")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index a9974f12f7fb..e4a2dfacab4c 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -228,7 +228,7 @@ enum {
>  #define FAMILY_YELLOW_CARP                     146
>=20
>  #define YELLOW_CARP_A0 0x01
> -#define YELLOW_CARP_B0 0x1A
> +#define YELLOW_CARP_B0 0x20
>  #define YELLOW_CARP_UNKNOWN 0xFF
>=20
>  #ifndef ASICREV_IS_YELLOW_CARP
> --
> 2.31.1
