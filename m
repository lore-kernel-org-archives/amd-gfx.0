Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE10C7618E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 02:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7AE10E409;
	Tue, 25 Apr 2023 02:15:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9373A10E0C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 02:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsH8DMjcJvfkR/bfmAi/q/RB8cghz94o+JOOWDOFiLaHOFpUNLiPlclYWUPVC8enJWu39VeQZZ8Bj096e3zmarQTkLMWJv79MPbBy28k0OkHt48K92MkZYguZTGX67bm4V1JElNEfs8fobGLXQYBDCka08UF4I8Jun6Rj4ICUGeMqd/Pm3VsinPtY614nsQoCC/7rHoTxJ8O/eYNUts1HuwWxYgmnmOs7j20VbNn8N5PtDX3TYBvf8+SUmss2g7lHBGh8owx6MfEu2T70S4Ym5Dqvo3Lv4TrQsEFCo82vMq9yuIIjfhB1+lOkY0mlylUIYXLecJmQP4Gy25Wuqq5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TyCYV4Sg4F2MACEKSCJpBZisoxYiqI6bL2G6wi0v2U=;
 b=Jfy8AD+Otp8juVb62KZC0MktCKgO8L3lkVX/0O2DbGhT417Hnk+2fHhNumVsORSEkK4TVCOcDqHvIiWn4lSkrqsrVkOwzAJQPsPcQVzH0KHBNsLef1Ih/6BiQUlDiox/7X4RHPYSUdrUcJZ1NDTLgkGGKCNSMmWAaGXHesXyisbKmo+ougsc70FiCfPU76dkvLjqii+K6c6aXNJoED7U5npcDrDv3wUNpKnbGjB/rDlYCMnXZ+tv8stQ98FwK1TCuNP5yx6TiPcWez4T8XvGnc8+hHVZKkX4jgHbhA+S56CoboboxA1kfMErVGNeA7NLsSrtYNakYZXy18HCfVl/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TyCYV4Sg4F2MACEKSCJpBZisoxYiqI6bL2G6wi0v2U=;
 b=CItCHAytB3qqDcUbXfKdfDCvL2VafxxnBrXrLh5XUbxw84iMdLPdbgEhwKIpjBCRYWVjZXDRVlibm8D5b9PjBRgLAuKGl7DNglvzk7YZmLc4mdx8yizhYS1t1D+OAODZt1R1/2fgDDTvJm/s0cu2y6dMZ47ZQuE1tV+q68plN3I=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 02:15:11 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc%9]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 02:15:10 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon (SST
 pcon).
Thread-Topic: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon
 (SST pcon).
Thread-Index: AQHZdLraycfYKDfIJ0Cd2G3uFr/xBq86uRqAgACUarA=
Date: Tue, 25 Apr 2023 02:15:10 +0000
Message-ID: <MN2PR12MB41280B11125AD440C131A85D90649@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230422013600.553498-1-srinivasan.shanmugam@amd.com>
 <BN8PR12MB334883191EE89FC13D4921ACE5679@BN8PR12MB3348.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB334883191EE89FC13D4921ACE5679@BN8PR12MB3348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-25T02:15:06Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c433b01-e764-4526-b9a6-926b52b2e775;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB8841:EE_
x-ms-office365-filtering-correlation-id: ce8b73ad-b2f9-4cba-5b5f-08db4532e575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKrJE13e9Gt2nim5+Hd94Wj7fk8RzrK5WsPrKgYTgnpStEHL53eXuHHD08QHh4J8GGge7II5jq2GC034LbsSj/LkuySsca4BEsC1qzjoUVa4bc8lodz6VeJykHzo6RBmgMkdyVdPug3P2Fd9eQgVm7ZDKaK15HBln7jkkKxr0qBZZKUI+/0rVFTPyiCAFH7dWLmIJyE93jErvVXtdnhs5qBByLL03j8ifGG9PZ6eX9PqHK2C1mnBYYsUwRS1EXYvwyW3auYjq4awVAxgAHUirUmdJCsDne5t+iCeIsT2FTFOgJ4feqnu/You640ZtAvtjh956CmQIYIwd+GoQBZSf4iWU7BO0wRSYYvBKFY/hN53ItL7juT7n4CLZwxx9eW7cfmJTcXZZGe80Rmq+Q+4OrvzYh7rYyTJSIlrBnAjf94JyHRJ2TJb/Zuzb5mHjvy7bClan/Mbd/GO2fLHxOsSE8sRfqQiy7ftNTfjcWEDzNllcNSomXex+RwI8oeYO9Ac4/70qXuIEYKuZAPnp3VNT0tUjmyCfzq5XGWR9iAHWvsaGNOS7HeIdDTGX4b1LrgVVtO3IfYeSeQ7IGx9ki/GDyJ/6xpCbzWItr2SWm1SyJHkv/FOdpixCI83WDFtt1GS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(9686003)(53546011)(6506007)(26005)(55236004)(38070700005)(55016003)(83380400001)(186003)(122000001)(38100700002)(66946007)(478600001)(76116006)(86362001)(66556008)(66476007)(66446008)(8676002)(8936002)(6636002)(64756008)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h6mcVqRrE6irVsYWnNy8OV20pNmAYbMqY1b1Wnr3JGTyrfahc4/+VuXnbBsK?=
 =?us-ascii?Q?nm1PiFF3wBLPF3zkSqOKSeF76kho+ACH8YBZdS5Mr3aTdE5N+IQVhrVy7PL8?=
 =?us-ascii?Q?N3yIdUE8rwYgYX746XmJfY7vqozheEVE8UZhAKgLA82vjYxFIBSwPA1gb4aZ?=
 =?us-ascii?Q?/iIivS+aW0hOvzZIc+CvU7raTuxjhC0q7EpScua0PGKiVFjF7BKmfH0KXtDo?=
 =?us-ascii?Q?KzFvDobRtpxdWVmsNrafLuyiIKucCRP/pKc/JmIgWZNSa0RPwmjmJu/Z+VsJ?=
 =?us-ascii?Q?FBMBmkZnggoepDVgz8lUBETwvEqTfQ1YGUzHyzWs8e3YBphYUGdO/chuNV1c?=
 =?us-ascii?Q?8laGTEU1EO2BQ+vmRR6SBhn+dHcZLVBRrvkmkHWwSQ3OGIfljaj64gNPQ/Ma?=
 =?us-ascii?Q?VTV8/+TK9eJNaYqJZElKZY91kgnG0AnE07B6yfmXzkVZfjfgw4ySx9uPS0vO?=
 =?us-ascii?Q?mH27/orUcmqxt5RsMISWrRpOavLehVU66/IyMFmRG4rfqLdwBH8FbdWUayyC?=
 =?us-ascii?Q?HXOzza0P3dSwBkw0k/7233O9y2ilg5PsLEXUL744UUsohe7UQDXkpPxZZh8P?=
 =?us-ascii?Q?Fd4XYTK9mVue7RTzuj4E09BjZ5sxU9ev3mzFxaHzGet9K+qs98+Cddv7ELOm?=
 =?us-ascii?Q?ALOKY2X/5BlcOqHSN8Kj2327bRr4mlLO45FcO7mvhl3om67Zuhb1a+r0eWGw?=
 =?us-ascii?Q?EvkjrQbcJLYOQ8Dd0YG0qYeK3Dn6tEByaA8uymM15no7YAE80YL4ISUYscfg?=
 =?us-ascii?Q?DF+srwU/HbPDMQx+YRyNU8K57+zlKcNkBeCmyp121A79bE16cenIR+Y/n1E5?=
 =?us-ascii?Q?SVSJHLcyWSsOln4m0bNeYDiKJYVYE9hs+HIKRnycbiJEHPIK+/hhTZ1LPFPW?=
 =?us-ascii?Q?4n/0srAN6ULCnpRnpACgbPwOUWqFbeAqE9mSg4iE9LYwvc/yUIW8ankuNHYp?=
 =?us-ascii?Q?DeSHpLhJCot8v2jIoUGKRLpOUhW22/3iCvZmoRp1qKmfOPvgAy5LV10Wxzj3?=
 =?us-ascii?Q?dztDZVnoT5dtDK8sjni7sy29S4OvpUh9hLPUS/TqBGnW9YY8VT/Bqht3yiOI?=
 =?us-ascii?Q?dwhr1H6oEnnd9HzN5mJpk7cwZN+X9ngqtgOVbxdnigCo/qdfuiX0LIUAFOeo?=
 =?us-ascii?Q?yc0Zw8GHTI18AJzvgIVbntS0hZ7WW1fC1KJDCqAoqMRSgmrS5lqv1GK0/LfR?=
 =?us-ascii?Q?cqWSKl2WHTT+ddv3EmvkP3MlIP2u953x0uT5Yh20CSME3dEHxrlFSxTvjdzP?=
 =?us-ascii?Q?6LFQORUWtKS5jlTrla9tBX1dCtrK0pO5QP1HVOY5CzB49aKXRP0kBuj+QAls?=
 =?us-ascii?Q?I5VJNesDbS+f8HdhXDJvrKFkewaAq6J5TYHTHepxqi1jkQzv+w4Gw4b5RmhT?=
 =?us-ascii?Q?Qb5qHJ3GBHLeey/S4MNY7veF1RiRzk2TQA4Ib9Ke529VEKae4IX0J2GIQEh1?=
 =?us-ascii?Q?K1nhTJeQ/1gVAyS0sGFp1q0rmbs4lG7e8CidI3G2xwPbA+F1F8NPoJlKCnq1?=
 =?us-ascii?Q?I5TRPkl31CFdi22sA4oefwZbskgMo7d6LzHlBzyKj9xvFQtpzSjbDS5FHLSd?=
 =?us-ascii?Q?sg4dQzfSxnFYajk8fN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b73ad-b2f9-4cba-5b5f-08db4532e575
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 02:15:10.2891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aE9Eq2YnMFEoAH+EY7JfVlM26MGfxJPpjPqyVfH2OQ69bsY1iyTBUCnJOHkEsELqkp7xCBKTN1gP7qiAE7OQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks a lot Jerry! and Aurabindo!, much appreciate for your help in review=
ing this patch.

-----Original Message-----
From: Zuo, Jerry <Jerry.Zuo@amd.com>=20
Sent: Monday, April 24, 2023 10:52 PM
To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon (=
SST pcon).

[AMD Official Use Only - General]

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Friday, April 21, 2023 9:36 PM
> To: Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo=20
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN=20
> <SRINIVASAN.SHANMUGAM@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
> Subject: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon=20
> (SST pcon).
>=20
> if check over DSC passthrough is removed, as this is not for MST use=20
> case. It is for DP-HDMI pcon use case. sst pcon is detected as sst not=20
> mst. In sst pcon dsc passthrough message will not get below log=20
> printed
>=20
> 'Fixes: 8dc5bfdab0ecf ("drm/amd/display: Check & log if receiver=20
> supports MST, DSC & FEC.")'
> Suggested-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_dp_capability.c   | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 84265dc66bba..577f74cc50fb 100644
> ---=20
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability
> +++ .c
> @@ -1820,9 +1820,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>  				  str_yes_no(is_fec_supported));
>  			DC_LOG_DC("%s: DSC_Basic_Sink_Support: %s\n", __func__,
>  				  str_yes_no(is_dsc_basic_supported));
> -			if (link->dpcd_caps.is_mst_capable)
> -				DC_LOG_DC("%s:
> DSC_Passthrough_Sink_Support: %s\n", __func__,
> -
> str_yes_no(is_dsc_passthrough_supported));
> +			DC_LOG_DC("%s:
> DSC_Passthrough_Sink_Support: %s\n", __func__,
> +				  str_yes_no(is_dsc_passthrough_supported));
>  		}
>  		if (link->dpcd_caps.dongle_type !=3D DISPLAY_DONGLE_NONE) {
>  			status =3D core_link_read_dpcd(
> --
> 2.25.1
