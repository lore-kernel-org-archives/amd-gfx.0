Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA688610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA688610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB7E6EC74;
	Thu, 21 Oct 2021 14:09:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56236EC74
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf+51e9DjpOf2oaJTQsdL9K8TxAtHxL6ciD7LWDR3yOQ5rVZRLLJR4k32CM/egn3bBAYMPY+Fa6wNboh2/8UV9V9IZ0KyuRZHFMFCMZTJTL/fmL4Xi9Md+9w/vXvjw9Z5pcxTJlRp+J0Juvx6RyE2axQgxc+eQvTcTxPLrHuPrjDLtHTcul1hVvBsTCvY/OjhfDfNk2D9SI8qVKvwwUQRWoatvwcsrE52or4ocJcRHvPLHYdZNiJ2qVMGwtJpTgeTZNy0PshO/hOqbaFwBRA/B8buNArFvrj9PNbTPk/rn/qN7yqVhRcgsI9p/FfmFJzRXZjORkZsDHsXgd7EXGfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkZnZ5zDjptfRghRdilSkfITWxPyrYOXy0yZOL1y3LU=;
 b=SrXb8nMiPbR+bIrrz6U8JL5yDV+SZuGdLMqpGiOxNk1xZ2kahIBKoYDdqOPYlRcsYwvbSPHFSifal0xEYSvULb7vcYElULKrTTrKYiM5o8PFgAibAG7dFdouCuGSAks9xubECJBBH7AS2O4SdXWjAOQPR37xLbVArvZbSloBN9z/KCEMHYYPI1W/p4q8w6F9/5SWfY76wzo9XLOOTNpxas2XgsXvQrtA+/O1quq/fRfpPp/MLRTSjZ+/pq7PkccBczwYQvErgwMurhAO0lSwTsTwSX9z7kwIwgoNit9Tm1cpKKJ5u1JfTNz4/xJHQt5iey0drY6dVoitEIkzQbvGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkZnZ5zDjptfRghRdilSkfITWxPyrYOXy0yZOL1y3LU=;
 b=v80pWpLllzG2VVJo2DbZDkMKOnq2cN8eWnFOUdjxHO3gmkrj/W3/1gXGeoB+UXd58ZrGQHmfcjs6WAQRVKIp2lQArgDPBMSBT6r/RsOP7Ys04O8atBVb2mUL40geZ1acJ+AyrrHlWAC6OcjFNN/HzU7+6gd4rcwFlHwWR/+HpgA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 14:09:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 14:09:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Topic: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Index: AQHXxktx1DjGstD6vkidsjU3klQZCqvdbB6AgAAATzCAAAWU4IAACbuAgAABfrA=
Date: Thu, 21 Oct 2021 14:09:53 +0000
Message-ID: <DM5PR12MB24692E27B53093D3AF3DC453F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <CADnq5_PJZDfNJOrFLsn5+FeWPm=eS4CE2d4FTdTSUKkDkDZg6g@mail.gmail.com>
 <DM5PR12MB2469DF82D13B3FE947FCCC82F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB2469B136862C34B770761404F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CADnq5_MgRY6WpyhD57zQZtJjpFqg0WTTH3=f1b2crGYK7n7Y0A@mail.gmail.com>
In-Reply-To: <CADnq5_MgRY6WpyhD57zQZtJjpFqg0WTTH3=f1b2crGYK7n7Y0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d68e167-9d93-4b2c-6ca0-08d9949c746b
x-ms-traffictypediagnostic: DM5PR1201MB0121:
x-microsoft-antispam-prvs: <DM5PR1201MB0121C3323DEF343DD8249F2BF1BF9@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgJj0mZ6UxBrI1duIEUFEdaR9YxoAe44KVTuq+yM9GyyahZCQ07uBMCGZ79C0XCEtS30FzaAWDzTl4OT654juXtC4cJf0Frste99mqyoORdiX51ndbpescfRvPddZLosvxirSpvI6WN5cmFxWY4+7GOy/tNgonCacICAEecJEfg4v/4ss92ORIRtKeSnSGB+gLp1WKot5NAKVGOtKrQrdpFUnjOjyxvwWduWhq+b+Jp0JaZ9lK9XwKoEW70PTeYwDUJt71BJcihu5J56PQR6W5UQZiZPQac0oFaRlRCpv5b4AchtYW+Jarh6jbu86TZlTCARCfAq6m0IKek+W/YnI7P9xzagGsXUqu+gCI0z3doZHXCwwwSZx8/Cf1/HVfhGAAaRiRDYfhIZL4rJ0BTiC3wFQkUDLDKBatvVBQG4aQwdYwd6nP6UPbkyEpdOk6QYY31v+dIJSTzKHLNjL9WtIKPFQ57JIaJtCQgVN3Fs85ZJbXHbAdTE5gza7i7NXEgZcvR6H7VTqxY5PIdh0lrYBaJ3RnbRxJv/iJbtJJTwJcQlH3kYZWaRrSDaZyIoipULQEH8asF5qme9Uk+yHkKUKV63ynlGrax+RgNrKhO1pGVjW7mJJPCtO0Fpms3I2OxuoE6vMl9YTSS9jIUd4UI0wKPy3VgeMNqZs1+5q9y4Xls/bJsTnv9zFOHKf/4n54K7MeUH/Tgtq2aglixktJLgCmhG1eC8cwPHg3riItLKWZ2lqoAV5Xz5I3N8alTYPwuHpchpohgB5Q+aW6XQFZPBoAZ/5GOY0e++W7u46HzWWtoJzdHUS/0Z8WWLGwxdnu8bpZDXAAolsbj9p83Dxziqmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(122000001)(6916009)(9686003)(186003)(53546011)(5660300002)(55016002)(4326008)(6506007)(54906003)(86362001)(66476007)(66556008)(966005)(64756008)(316002)(2906002)(66946007)(26005)(38070700005)(33656002)(76116006)(508600001)(66446008)(7696005)(45080400002)(52536014)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bil4fet5pRC3d8hUSEsa6nc/3I12BT0/TyMuKjUWDCVtecT/nYBit53HUQA8?=
 =?us-ascii?Q?rqWTptj7AbPzWgiubFRvI4BwfZret8RO20cBPMk8vWc9hK/q11ZpE2sd0BYL?=
 =?us-ascii?Q?+rT7KJ6G67PP8loFtkRRcSt4catkI5y01Cna2/5gvt/XsdPaW6Qm+ftEZ/xs?=
 =?us-ascii?Q?UTiZnLtaNZjNJSAgy7UE5Ajx7HoQxvPiTrWqvT37cysQQW6dEt/51Sh0dhxB?=
 =?us-ascii?Q?Bu7tLrpQWV8imRIsfUhoq3/rzGaF4HUtiOhc4De+i6XEe4i7kBxlAhEKlAWM?=
 =?us-ascii?Q?864CBSsNHqJ0MhaQ412sRuz8yOBqH5/VrBTuj0EYY1wx2P49K6Yir21XcOY7?=
 =?us-ascii?Q?9BiJb8LWmcpXGIsdH1RiRDlBUfL5Aji4BA9YaQWfTlmYNMBTLtTCn4sWAqWE?=
 =?us-ascii?Q?sig6q5PzJdg20++0X5qicPlpJ27bbCQoGMJ292NXqcMkBcEeArx3fn7uLqYj?=
 =?us-ascii?Q?HHlwlz6c423zHsYy6shhRODNEJk+4zqrMXJSpf4MDk31qJQVkwH3wZwhfWz8?=
 =?us-ascii?Q?2OIb5xU/VrJKlGgMJtAe2F9B8blPRsovUtUNPxO5V4gBbggrBFd1kUA/fB2R?=
 =?us-ascii?Q?fmm0JHd5gmkncGYt7OSWG5M6vTcMu5i6+BPiK/wwQXzIJmgaOeK1jridmuhI?=
 =?us-ascii?Q?7KTiLvbr23FU18TKRoixpfY5hQISas7VMt5HyooRLF9rmBQOThjYpv7sm3uZ?=
 =?us-ascii?Q?/2A4IueQV07uaL5ptX4EfCuyg4f/nuWaIsMBTFX4NcHhcccGJLZVqnUXMrqT?=
 =?us-ascii?Q?BCUTyW30CDuj+xKl32zmh/CjsbKeHHhOz9UcpNeJCt9a6sx8eqMKUPxbp82/?=
 =?us-ascii?Q?SuIP2ZojJV186mqEYKlMr0p/i2bWc9V3nAOJGORM9KILeonR1SgK+5tCBLcM?=
 =?us-ascii?Q?aIngNENwi4007+s0cxYnUYV+2rMty3q/lN1I1K4jIkiXnQrJObn7o/FIAkd3?=
 =?us-ascii?Q?s7NSzfIxsoLr1Rj7naOV+Y5WgOvFX63pHK5a4lYpEko+wVkwdbo4rkkSCYJg?=
 =?us-ascii?Q?2z0GJQX+cXiUFniGA3IHeOJoTc4AQdE2VW8z98zQPYrqzmZ7772m/njEoe2+?=
 =?us-ascii?Q?kMmeXG+kKLZQpIkoDLqnSipoxEglAvEgtBckHqwM3dfER2ta8S5/tgoEqNJG?=
 =?us-ascii?Q?NARBlOFFeBp97RXd1iSEEMfbszUhUAIu8yUP/ErrJxVa6RwxDJDvhxwxQVRX?=
 =?us-ascii?Q?FTvH+ChLlZMW1H1Q6nBPxq+iUhaEZXtQiFjA74R/SvKpiUnROO+L+jEMZgak?=
 =?us-ascii?Q?tj8hI57pexRDrCnNIQWkntozYry746+zhYF44pYuBB9yJ4ffAIc530lwMoIO?=
 =?us-ascii?Q?Taa7y/JWccXTUPq8BqVTzbLnmhCP9rxLdeIkZfnltzqXElcnp3uWaJyYRVUQ?=
 =?us-ascii?Q?QfPF3e3JIeTZVSi80YBAxOXTpUh62Z8cDZ9L2FgsBWSwjQsBnbZyoYOEUUoC?=
 =?us-ascii?Q?YyOrx3dsECY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d68e167-9d93-4b2c-6ca0-08d9949c746b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 14:09:53.7342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

Why using asic_type to check this? The issue is caused by the ip discovery =
series, and I thought that series' goal is to remove DID/asic_type as much =
as possible in kernel driver.

+	/* some IP discovery tables on NF don't have this set correctly */
+	if (adev->asic_type =3D=3D CHIP_NAVY_FLOUNDER)
+		adev->vcn.harvest_config |=3D AMDGPU_VCN_HARVEST_VCN1;

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Thursday, October 21, 2021 10:02 PM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FL=
OUNDER

Thanks.  I think this patch set fixes it in a bit more future proof way:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F96132%2F&amp;data=3D04%7C01%7CGuchun.Chen%40a=
md.com%7C52fab5ccf8f64b6eb09b08d9949b548f%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637704217145304873%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2KMrUDLZZ=
1s3colyVy1WwY4Yz6GbyI9z53qixn%2BuUwQ%3D&amp;reserved=3D0

Alex

On Thu, Oct 21, 2021 at 9:34 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Additionally, in sienna_cichlid_dpm_set_vcn_enable, we also use num_vcn_i=
nst to set dpm for VCN1 if it's > 1.
> The main problem here is VCN harvest info is not set correctly, so vcn.ha=
rvest_config is not reliable in this case.
>
> if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_=
MSG_PowerUpVcn, 0, NULL);
>                         if (ret)
>                                 return ret;
>                         if (adev->vcn.num_vcn_inst > 1) {
>                                 ret =3D smu_cmn_send_smc_msg_with_param(s=
mu, SMU_MSG_PowerUpVcn,
>                                                                   0x10000=
, NULL);
>                                 if (ret)
>                                         return ret;
>                         }
>                 }
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Chen, Guchun
> Sent: Thursday, October 21, 2021 9:14 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian=20
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher,=20
> Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for=20
> NAVY_FLOUNDER
>
> Hi Alex,
>
> No, it does not help.
>
> adev->vcn.harvest_config is 0 after retrieving harvest info from VBIOS. L=
ooks that harvest info in VBIOs does not reflect the case that VCN1 is powe=
r gated.
>
> I checked several navy flounders SKUs, the observation is the same, so th=
is is likely a common case. Perhaps we need to check with VBIOS/SMU guys.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 21, 2021 9:06 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Koenig, Christian=20
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher,=20
> Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for=20
> NAVY_FLOUNDER
>
> On Thu, Oct 21, 2021 at 3:15 AM Guchun Chen <guchun.chen@amd.com> wrote:
> >
> > VCN instance 1 is power gated permanently by SMU.
> >
> > Bug:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> > tl=20
> > ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%
> > 7C
> > guchun.chen%40amd.com%7Cda80a308a28049d543ad08d99493847d%7C3dd8961fe
> > 48=20
> > 84e608e11a82d994e183d%7C0%7C0%7C637704183581593964%7CUnknown%7CTWFpb
> > GZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3=20
> > D%7C1000&amp;sdata=3D2vNLj9bXE2oV97rxBiUOiaFNpKopVSJefL%2BMcQE%2BSfo%3
> > D&
> > amp;reserved=3D0
> >
> > Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance=20
> > setting")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>
> Doesn't this patch effectively do the same thing?
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.freedesktop.org%2Fpatch%2F460329%2F&amp;data=3D04%7C01%7CGuchun.Ch
> en%40amd.com%7C52fab5ccf8f64b6eb09b08d9949b548f%7C3dd8961fe4884e608e11
> a82d994e183d%7C0%7C0%7C637704217145304873%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&
> amp;sdata=3DEmyT%2BNBnV8rIhJSqncnyFwR94smOvu2AGeb4vESFhdE%3D&amp;reserve
> d=3D0 Where else is num_vcn_inst used that it causes a problem?  Or is=20
> the VCN harvesting not set correctly on some navy flounders?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index dbfd92984655..4848922667f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
> >                         adev->vcn.num_enc_rings =3D 0;
> >                 else
> >                         adev->vcn.num_enc_rings =3D 2;
> > +
> > +               /*
> > +                * Fix ME.
> > +                * VCN instance number is limited to 1 for below ASIC d=
ue to
> > +                * VCN instnace 1 is permanently power gated.
> > +                */
> > +               if ((adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3=
, 0, 0)) &&
> > +                       (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSIO=
N(10, 3, 2)))
> > +                       adev->vcn.num_vcn_inst =3D 1;
> >         }
> >
> >         vcn_v3_0_set_dec_ring_funcs(adev);
> > --
> > 2.17.1
> >
