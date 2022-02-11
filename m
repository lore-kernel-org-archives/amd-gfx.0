Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196B3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 14:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB1110EAF2;
	Fri, 11 Feb 2022 14:45:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C360310EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 14:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAqEXf1Q3gOeqETdFJvOTmBS8CJcJt2wIjEapS/fHsF53OhV7eh+eAv87UvSaK9kBAkwAk9G8SMb6P+asy60necUN0azqwB/RXW475AK+uQ2/LEdyJjYd8X1WofaZ3m9W1vltMlnFTy90EUK6ae9hI/zKD99gDvikv313zdaCt9/dl/9hBmzJJPYW3adDXBm6ymDqmNC4CXw1zXi0kFSeXvGghxZqyiDwr5txS+u9fLYuwh37dsgAKQBsERtwR1DCZ/2PUoepj7Dp62tW4W1aR8SmeUQ46ARdGQhbxK8offUY0bfdIZvvZtP5t0Xcz2Hg2MrqXIdGzX+HYs3vehFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8aPismaqM39zNuQSK4F5GQPPsREoqMay11aixJdNJU=;
 b=QzdEbFcvbpzilENpEkRAIGPR9ZKH1Nnaygbf56C4xB/Pkcb9Ihz39S0w8BxAot5cn6Bk9fbqAitEzMd9VmV7x5hWW7qxDZKOY/b/fKXYm9cQJk6Ui3QrQts1JwHuBvhPpEhThjn2E66s5K7MsL9toiPPtvmNdmBkUhgAAfgEmBelo2wzR8rE5l8Hv+RXA/Ysp1LngAxtF3Nh+jwiK9+OdpH7U/0kCq6lE3JDnSlZFU1zdGlvJfpo/PrlQB7OFh4Hs7U04xPqJQZXUlBJecpI7QtvYEsbxzgFAlV4om3ku3tFijfUCmHA4tTBv4+l7J8vxn9UOZB03YlIyCtB4Sr0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8aPismaqM39zNuQSK4F5GQPPsREoqMay11aixJdNJU=;
 b=BhexA7l46/5HwhMmDZRa59YyXwO/eWi27X37pS6G2iWKt6nsk5eejND05FNUakemDs7IIxybAnAOGYnwkdTnc4eJhzd/rzfQoJf0FlopUMSPSN+AaS5cvnnOiwpq6PZb6MN0X9H3sCQm7laWFXai+8wXa+0Q9xr/OdjpAWuR9tY=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 DM6PR12MB4793.namprd12.prod.outlook.com (2603:10b6:5:169::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 14:45:48 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::ed8d:39ad:d95b:6ad6]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::ed8d:39ad:d95b:6ad6%9]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 14:45:48 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Index: AQHYHpTl27KNzDuQPUu35WF6KFElbqyNx38AgACnOrA=
Date: Fri, 11 Feb 2022 14:45:47 +0000
Message-ID: <DM5PR12MB130898AB9986FBDFCDC2706685309@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220210154247.742942-1-kent.russell@amd.com>
 <DM6PR12MB26191EB91053235076F876B0E4309@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26191EB91053235076F876B0E4309@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T04:46:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3005ca88-d790-4123-80bd-8e0245f5a1de;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c12112d1-f377-46bc-ec84-08d9ed6d3120
x-ms-traffictypediagnostic: DM6PR12MB4793:EE_
x-microsoft-antispam-prvs: <DM6PR12MB47934932DA21216ACE25174485309@DM6PR12MB4793.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wDW9Nml/SKrUm4BYR9U+/KQsXHCIQ6VbuDML+S7JjTXv1NvkT8YUxFDvzjnXj4lUKHqDCmwisfWShsg2qRFee2qardyWuu9tu863LQ3RnAoR41fCE/2cRNxTLBHzwGmha/VS99kPem8zfLjZrrn29iBgyfY9IPgZXrK/+Pz4k/pZ7G6O7NKgvJdqqi/N8aVgmKJmXdXwiNAhvmBVGG9TBBX0lGbejODeRN7TEQ3bNykhoOMwpIpgnZ6/j8pOUCMbWV5wkmtm8RO1wnaZ4NpjjPVDYLO7CYqqhuEjf6EtjmG8VXAHK5qaQddpyJUnufIR3v4M32YPj4poeUvsuZQDfCgoUXabgVIOuueWSs71Z0Ghm2cxcFfi5uyauGS7ZzOVFP6KBL9Gk42/KBw2wn6Gq70fhktF07QB1jgBhkrF1vfbnFgdVLbyNJgHQYPaIG8Yek+rzLisQGmWAPzxUen1VOTxS5cTNYxN47zxJNOfF9soGc2YgHcDXUO73tzAa5OBcxqx0s1WCCxaqagtJ1a+9lYfjg8SJA4ZIwCmHGR6Li7XW8jjD6tiwOSuiK+gf3DVsWDmgjed5QpNqXmEi4bBycAvJt3UFgeHagikooxnooGFACwnSxZcr4RBxRnNLpgwec7i9qPMDBz7qBQy/4biT8A5SK36WaJSKgPpYcZMyQ1KKJW+lt9NHVXH/jxgn+WKi8bBL8TuNzkgH/lPK6joQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(122000001)(52536014)(76116006)(186003)(66946007)(110136005)(26005)(66446008)(8676002)(316002)(38100700002)(5660300002)(38070700005)(2906002)(66476007)(64756008)(66556008)(86362001)(9686003)(83380400001)(508600001)(71200400001)(7696005)(6506007)(55016003)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GARvsBn4galJl9AYiQaRbUAxgVzPHg0VjLsIEyDGHp8ECAPLC5cGU3sqofBy?=
 =?us-ascii?Q?K5gVwkRsuTPi2fH1lDDqutaZpa3Q0Q8xNDA0EHEipU+0AkXAz9mfGQYHy7FY?=
 =?us-ascii?Q?neb5/8r7GQHfqCX9rlQPp37f6OjDpLMe3FpMVliAS/oei1L7FfMufL0Vu1Je?=
 =?us-ascii?Q?+bDuvCa6BaDG3REmkfPg4WtpMD2tT2TGtECtmUXK/rKeDnpfk+4O8DoXHJmK?=
 =?us-ascii?Q?0f6yT1dlaFzQuI6SFh2Aoyr5k2rpnvVhmON/etU6QMEruvT1MKxbNb4JeIv9?=
 =?us-ascii?Q?VZFG2BfsbH8N45OlxekY01B5ncz1cTTfGJIhjEwqoUApJusYvlJfK4uOQPr/?=
 =?us-ascii?Q?xLPeaChrr1o8C7/hdXcfiTGEwMvvtCYyre6N+eisHSoEawAwDykJzeQsY2F7?=
 =?us-ascii?Q?0NraG2iqvWyWHQ5Up10U6anQlqVMI//aZI3KdkOP9VeecwbAuurrGU9fIsUg?=
 =?us-ascii?Q?JgG/dW9FwFnVSBOBdpT8VgaO6s6yfS8bjmXW6JTiyRJpUlao3pdzOUh3riDP?=
 =?us-ascii?Q?duu2JKsS7N7s+Jt/SgszaZ0e+VFGxWW20i4h5jLOcpdW914ANkrfxqmsmT2k?=
 =?us-ascii?Q?Zqnjho9H6ufTWmSoZWCkpMDTJ0pNXll2E3zZ4s2kb5FTN5TiwmzSG7Ztk1kd?=
 =?us-ascii?Q?JjqA2vnyiOG90yJQK86NmtF6LM/m/pijw2Eo6flLKCgpyUCuZuuAocUjYdEj?=
 =?us-ascii?Q?KJuHtvBROfAA4dzD/f7rmsYJfuknMJ5E9+zMArd1z/L/+o6jjLx1+ug+KQaZ?=
 =?us-ascii?Q?HXd2Gy1tK5vbnwcAX/9ie3Aln88CIWDQ7e03zk7AHZTztb7FuOnCIGKZJf3b?=
 =?us-ascii?Q?z1cCrRpjKIGgs8vj/wXgqbCfAAxmvkw8D1b1gte6xHepu1NKfG+2JL0Ta7kH?=
 =?us-ascii?Q?ex+XB9rtU0uY3tXiUq7UgKbox2x6+1j4gOufvCW5HEiT7DSJaOgulmryRE+2?=
 =?us-ascii?Q?hS63VLi7ZYr85wogGdL8vHT0zO5/QUOJ24/6jqpVs7CsnXxOd7GHA6XNP4Vw?=
 =?us-ascii?Q?eJno2QvhWV2tkQwYO55nkmOBxgoaOPSFv0Y71rbei03u7upKUf0ldGSq2gEF?=
 =?us-ascii?Q?k933v5WtK+FX9phKllUyzVw9ysYY9gVJ7BcBFn/3h9MD/74ibpZc93VCWl/b?=
 =?us-ascii?Q?etSAE4hQOoiZ49OThp3p5UdnzMCvvHBXFlatynxtYGgpgWRi7uqdGchXb2ZE?=
 =?us-ascii?Q?13uoqFC+1c8yqakue4jRROagQi8V/icwHRYi6Abn1dBqKSUNoD6LneWWCJNb?=
 =?us-ascii?Q?wwjBqgobKVdmdum35w9soFdduhrIXe9K1m0hLPY17n2D9fZbo4e5YsaSuxG2?=
 =?us-ascii?Q?IfLEspbhK1XklAsAB8Pqo66JcMfXfkOAzw1IF+yop7pGtfjpEpVCaTzGruge?=
 =?us-ascii?Q?wKHwW1f9GQIODocp4LfLvOBPkKyC16Af+tlc+qoH2ysTfCYXSaCKeUWKTbTL?=
 =?us-ascii?Q?xW/Tuu+XL5YgBAKfz81LSDWE8af+d+En17IXoAbOHS6IAaA/vbA9KQIEzGWv?=
 =?us-ascii?Q?ALcWFQ/OaVO22rn0t8T03/xeBnJS9xBQaek7M+HLWsoCjVMwpW9M/HxiF7YO?=
 =?us-ascii?Q?QKwV7I5ZRh5ZuUOl69nfTx3GJDRuM8bMXr6bMfxWXbQkGBzrLnRACMT2mshL?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12112d1-f377-46bc-ec84-08d9ed6d3120
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:45:47.9689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G631FuNyNMff4TcJfY/k/GroyZrxTVInjbY2XGP044EE55tG6yiq3kVGCill7iB85YgBBa5/ZqkEtC2uG3N4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4793
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

I can add a guard to be safe. When I checked previously it just returned ze=
roes, but that might have just been good luck. And I'll remove the mutex to=
o. Thanks!

 Kent

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Thursday, February 10, 2022 11:46 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
>=20
> [AMD Official Use Only]
>=20
> If this is only available with the latest pmfw, you might need to add som=
e version guard
> there.
> Otherwise, garbage data might be got with latest driver + old pmfw.
>=20
> Also, the "metrics_lock" was already dropped from latest drm-next. So, it=
 seems you
> worked with an outdated kernel.
>=20
> BR
> Evan
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> > Russell
> > Sent: Thursday, February 10, 2022 11:43 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Russell, Kent <Kent.Russell@amd.com>
> > Subject: [PATCH] drm/amdgpu: Add unique_id support for sienna cichlid
> >
> > This is being added to SMU Metrics, so add the required tie-ins in the =
kernel.
> > Also create the corresponding unique_id sysfs file.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
> >  .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 33
> > +++++++++++++++++++
> >  3 files changed, 45 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index ad5da252228b..f638bcfc3faa 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1969,7 +1969,8 @@ static int default_attr_update(struct
> > amdgpu_device *adev, struct amdgpu_device_
> >  		if (asic_type !=3D CHIP_VEGA10 &&
> >  		    asic_type !=3D CHIP_VEGA20 &&
> >  		    asic_type !=3D CHIP_ARCTURUS &&
> > -		    asic_type !=3D CHIP_ALDEBARAN)
> > +		    asic_type !=3D CHIP_ALDEBARAN &&
> > +		    asic_type !=3D CHIP_SIENNA_CICHLID)
> >  			*states =3D ATTR_STATE_UNSUPPORTED;
> >  	} else if (DEVICE_ATTR_IS(pp_features)) {
> >  		if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> > diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > index b253be602cc2..c09dec2c4e1e 100644
> > ---
> > a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > cichlid.h
> > +++
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_
> > ci
> > +++ chlid.h
> > @@ -1419,8 +1419,12 @@ typedef struct {
> >    uint8_t  PcieRate               ;
> >    uint8_t  PcieWidth              ;
> >    uint16_t AverageGfxclkFrequencyTarget;
> > -  uint16_t Padding16_2;
> >
> > +  //PMFW-8711
> > +  uint32_t PublicSerialNumLower32;
> > +  uint32_t PublicSerialNumUpper32;
> > +
> > +  uint16_t Padding16_2;
> >  } SmuMetrics_t;
> >
> >  typedef struct {
> > @@ -1476,8 +1480,12 @@ typedef struct {
> >    uint8_t  PcieRate               ;
> >    uint8_t  PcieWidth              ;
> >    uint16_t AverageGfxclkFrequencyTarget;
> > -  uint16_t Padding16_2;
> >
> > +  //PMFW-8711
> > +  uint32_t PublicSerialNumLower32;
> > +  uint32_t PublicSerialNumUpper32;
> > +
> > +  uint16_t Padding16_2;
> >  } SmuMetrics_V2_t;
> >
> >  typedef struct {
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 2a7da2bad96a..048014f05b35 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -451,6 +451,38 @@ static int sienna_cichlid_setup_pptable(struct
> > smu_context *smu)
> >  	return ret;
> >  }
> >
> > +static void sienna_cichlid_get_unique_id(struct smu_context *smu) {
> > +	struct amdgpu_device *adev =3D smu->adev;
> > +	struct smu_table_context *smu_table =3D &smu->smu_table;
> > +	SmuMetrics_t *metrics =3D
> > +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> > >SmuMetrics);
> > +	SmuMetrics_V2_t *metrics_v2 =3D
> > +		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> > >SmuMetrics_V2);
> > +	uint32_t upper32 =3D 0, lower32 =3D 0;
> > +	int ret;
> > +
> > +	mutex_lock(&smu->metrics_lock);
> > +	ret =3D smu_cmn_get_metrics_table_locked(smu, NULL, false);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	bool use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D
> > IP_VERSION(11, 0, 7)) &&
> > +		(smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> > +
> > +	upper32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> > +				   metrics->PublicSerialNumUpper32;
> > +	lower32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> > +				   metrics->PublicSerialNumLower32;
> > +
> > +out_unlock:
> > +	mutex_unlock(&smu->metrics_lock);
> > +
> > +	adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;
> > +	if (adev->serial[0] =3D=3D '\0')
> > +		sprintf(adev->serial, "%016llx", adev->unique_id); }
> > +
> >  static int sienna_cichlid_tables_init(struct smu_context *smu)  {
> >  	struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> > 4012,6 +4044,7 @@ static const struct pptable_funcs
> > sienna_cichlid_ppt_funcs =3D {
> >  	.set_mp1_state =3D sienna_cichlid_set_mp1_state,
> >  	.stb_collect_info =3D sienna_cichlid_stb_get_data_direct,
> >  	.get_ecc_info =3D sienna_cichlid_get_ecc_info,
> > +	.get_unique_id =3D sienna_cichlid_get_unique_id,
> >  };
> >
> >  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> > --
> > 2.25.1
