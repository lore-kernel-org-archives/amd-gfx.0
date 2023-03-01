Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA75C64EC7
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 03:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CFC10E09B;
	Wed,  1 Mar 2023 03:06:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CDA10E09B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 03:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYvkNX441//iBoiIFaw9ioJ75O+lYsErQfX8jefuxwulDiYYeD4/6tAMkgtIy4d1jKiFHIMozmqULv8OC+tx9A8w+fEgn9N2Rq94XMQYeh/1iC7Gbme90aEEcu2XqxnGdLkSVt1uxkg/8FemTMHmahT4HHZ+krfGDU+WI9BNHwoZTN67vPjNXg/YkRnhnwaMjJPssOlAqNB97fdj9y4uMCgidAYwdIezSai3iVE3SoEoZPzx7b1UfqGFQu4lnIg8Kv04TLSIrCwVbFp0RFOlStdXO7hVyQyk3gjfBspolzioQHcRO91Qy5WjmCnDoXCJaSGQAiggdiiE1Giqc37nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXN6ThwHBBsDNga7YptHfo6BVBhktMpZ2IYCJikPiVI=;
 b=lVsAkvcX1HqKUJh20V8Ir/3fRcMGVzRGnxPTQ0YUC8Sge3ujfgfHPFbRLfI5R4/i5mIj02J6SMY23860P8fGtgCVTD3vYhjUzRJaIr0Q3NjLkxGl4fCKn+b7QBxTqPGq1SB2mMqUSlFOTNVt1P3LToSuTEGAKADSr5P0uIisb2oaiPkmMgg5vMPpzxJt3ztSri6JmWf+di23IbGNf9bW2bMEmEpnKDcnu9A9B20ZVv2HZT++QERdqj3GnwW/MjYCeCl1G2pBbIMuhFHOgac6zI/qDTdGL/LQ7Y28Zv0mOJOLES/ljvUzCwAo0iE6kQsE+Dz7+TsQYeM6WzMLrAttKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXN6ThwHBBsDNga7YptHfo6BVBhktMpZ2IYCJikPiVI=;
 b=Hewa8DZ+XlgTuI1kiHuYwice22mcjDfy0j4st2WSVk+FaR0hBak+JmMFq6AI7b0HtHR/mFbmcHJr2Wxxg8YQ3vGgf6bo239/g63DiwLOdV+SJd3LOxJ1XyzanMytd2wv2WXdrXyj80ienDo95AGxHx8MHUiF6dZGkujWdf9Zh/4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 03:06:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6134.026; Wed, 1 Mar 2023
 03:06:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Kun" <Kun.Liu2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix no previous prototype warning
Thread-Topic: [PATCH] drm/amdgpu: fix no previous prototype warning
Thread-Index: AQHZS+dli/MKox+q1UmKrk1jYfs9Da7lPXsg
Date: Wed, 1 Mar 2023 03:06:21 +0000
Message-ID: <DM6PR12MB2619E66AB02A0E20685E7D93E4AD9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230301024152.1351060-1-Kun.Liu2@amd.com>
In-Reply-To: <20230301024152.1351060-1-Kun.Liu2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-01T03:06:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=34bf93a3-3b3a-4856-91d8-0d18f8b4cb9c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BL1PR12MB5046:EE_
x-ms-office365-filtering-correlation-id: 52492dec-2d0c-4e2e-dc4a-08db1a01ef4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/DCMb1s9aq2Z7yTxgul0PCV+unvIc+nD4Btxej1BYovUib/OZ2tYTtHreDKKDyV+716YFP5mk4WvvSR7RFVScK0NNQp7WNXHVvPOpW7YCwcTmLGNi8+JkxDrKavKISCxvnq2ccwZfjhpQAhYfiuem0vgGxeFi6xLXMcAtMfF5isQf+ZKzUgr7OC5OEBhOzQpXJK7rnHbBQFu3riJ3pIUKPuhzi8p/0JGUjKSb14LO0GwrUNJuFMTn0CzdRQOlRdH4/H+Qyukrmzg67eoceD/3aCOMiHrVegkaw1alzlJfVPJXJ0qU8Sfalymov4wW4TtkAWZNiYSJW3dmldh9PO+Z9i1duNh1coyEsxbpt8iPj8s/RKfCHktok+VM4ISLhRp5Ue7eZGiT/RUXbR93TPqu13sgBHK0R+++8/EW2sjFvd0769sWcrBfLgj424c7c5sFDgodSxcCoVp8TQAucs6mIWxzTR2eEQhzdhgY4Rw8HViAWtlmg9kVdq2KeYWWuLOz8gdPfa+3hCIOxeXreAR7+wfH1yLFsnTyHF/xrCFU+fyYL4apbB4W4JAl+OEIdtg84HjfmpLOhtiE3/dGO5firfmdzqW1ABpJ7CcgPd2K8y/jB2/kppzDonCOWAkt2L37gbxVPuIxyvpVWhCU6/dUwnerK/mehIiZlOOAyFQ8jZ03gWxaD94nk57dfL9BuU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(8936002)(316002)(2906002)(478600001)(83380400001)(33656002)(5660300002)(86362001)(55016003)(110136005)(71200400001)(38070700005)(4326008)(8676002)(64756008)(76116006)(66556008)(66446008)(66476007)(66946007)(54906003)(122000001)(38100700002)(41300700001)(7696005)(52536014)(53546011)(9686003)(186003)(26005)(6506007)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m2IqYXwoEaBktKnGVpTU20fxTdJpNUkjxwNLKM3vsDfIF3Z04yuPHjBQGySL?=
 =?us-ascii?Q?cBFd77hK8tOGEc/9+t1FLTCcUJig1+VRioFlz/LUxDIjoh0CD9RFSsU/T4tR?=
 =?us-ascii?Q?DHEBtxht4gfuhVSgIRBI2BuQBPObDMHHk6k430LTpBV28Fnj2cTF+bXmUvgD?=
 =?us-ascii?Q?dIqmsxNDsZ6vF6xJjdjZeKBbBq11stVYWvm1UWZsqmebfEEypCBxD8PHtpwH?=
 =?us-ascii?Q?KO8SGY7q7sJlbqJkrUTfp4KqqLk1bMVrjfCGHhqea9akDkdQLd7JiOlnbPEZ?=
 =?us-ascii?Q?jcAiyCHULePP934QWiRel271302lR0XfI1WQXlagiPVDR3Kmf6Dq9/3zGILG?=
 =?us-ascii?Q?8t8HUNmglQMMQAGZXMViYjRTGFR789nwrbEKz95rmS0NCyTNZWtAbv8SQ28B?=
 =?us-ascii?Q?c03R2KwbTc4FHeENR45UlPyN8nQfTzA1J41m68iYqVWq3lyzxV1Jrt1seG94?=
 =?us-ascii?Q?EfBJGKQlIWniBc7p8ji8ptg185Tv+tzI5wrhSf3VffWeUbW6Q+ymBARGiy+Q?=
 =?us-ascii?Q?WZl7caccphGtgkc8bWRensqtrWjdX2B/gBgrHeOruLmeOgkyAiEyBGzgA2XR?=
 =?us-ascii?Q?yWiKfkSnjV7houNMd+GvICK376flHdPyvnXyXWskU3jT/NxxqAwbVyNedn64?=
 =?us-ascii?Q?qSmTEHSxcDPJIjWWG0lyN5UUfSATOPgbm+6nZ+RgsHZgA6nAQtM83CCyP2sX?=
 =?us-ascii?Q?5NLQkh4BHIjPilfW5OHgrI6O4Rdy+OjQoA5YPx1jiJRbFDpZBNGT2AeJVlAS?=
 =?us-ascii?Q?o4Ri14QyPUmfYk7VM8HHNmOHzqZRnRr5N9pR5DJ86603Bz6Ep7CHS6mVOhJC?=
 =?us-ascii?Q?0TWiOhDP+20Cyw0JlR2Kf4XmojcOz8jYtifjJuGIOmzmO6zD+m2T49Gl3AyN?=
 =?us-ascii?Q?jBkmPAk+4m6RwLTVMD1y0nizl8JExqHMea+75p1RSdZLogQTQaAJZdFxbmpY?=
 =?us-ascii?Q?E8n4gVyOBrGcsCZIXXT+gopV6dzayb6NoHHaf9ZuxoqWHAt1kmQ2hsvb3uzt?=
 =?us-ascii?Q?Y1D3ujEsx2GOBLZf+i0vSKFrHJtrXYK9Ym4U7tyB3J1f85JNqTokT25dJJ9J?=
 =?us-ascii?Q?v5ZOcn2PGOyFNyS+3YoB2VHJ/bplk2zbDrv68YkpgWWHJBtXjxppeNKawETU?=
 =?us-ascii?Q?wgunP0OAWzDTpyYkCLliPa2cHPokg1lkzM62WC1b9+qtM49SEb707CNrspZS?=
 =?us-ascii?Q?uY/gUYEFpw9MC1R3ajIYsBAcK6Od/MKpBvIBB744PaItY23Qjj5SfQIbJ/uC?=
 =?us-ascii?Q?IyGtmrh/yvIrpWbQVwKyLHUHh4areKBTQIZnRq34pg5E64IjSLJOr1kGZyVg?=
 =?us-ascii?Q?WNhsqLzaJMoO7cuer5+5QqJyTUb5hAJIKywK4Pe82S3RgBMtJ2vDjMrPaPmZ?=
 =?us-ascii?Q?hbv6aTG08PTgeuqf8MIx73EWzKJ5VIgBcSYcvjsMV19SsL4J2XX4lgunMqZK?=
 =?us-ascii?Q?mk+1AuD5R7oYWktocVYhR7RU6XLfc32F+Tj7SB8m2utOKQzEiOs3hOUcvMFs?=
 =?us-ascii?Q?O04i+sB2EioBDywvXJws+43MHz7hc3MSdc5Sl17IUZEx/mLt5IiY5GS0+s22?=
 =?us-ascii?Q?azZxzEjk9LphUMFXrxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52492dec-2d0c-4e2e-dc4a-08db1a01ef4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:06:21.5113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTJ6bkCXY9kxqhTjv0p0pYPnW+kYF6fKIIM0RgxTe+5TgPYVI2m0UHP6GWO5jME9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please add proper tag as instructed. Other than this , the patch is Reviewe=
d-by: Evan Quan <evan.quan@amd.com>
"If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010827.c2N0yBGT-lkp@int=
el.com/"

BR
Evan
> -----Original Message-----
> From: Kun Liu <Kun.Liu2@amd.com>
> Sent: Wednesday, March 1, 2023 10:42 AM
> To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>
> Cc: Liang, Richard qi <Richardqi.Liang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@amd.com>
> Subject: [PATCH] drm/amdgpu: fix no previous prototype warning
>=20
> add static prefix for vangogh_set_apu_thermal_limit function
>=20
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 016d5621e0b3..24046af60933 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1597,7 +1597,7 @@ static int vangogh_get_apu_thermal_limit(struct
> smu_context *smu, uint32_t *limi
>  					      0, limit);
>  }
>=20
> -int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t
> limit)
> +static int vangogh_set_apu_thermal_limit(struct smu_context *smu,
> uint32_t limit)
>  {
>  	return smu_cmn_send_smc_msg_with_param(smu,
>=20
> SMU_MSG_SetReducedThermalLimit,
> --
> 2.25.1
