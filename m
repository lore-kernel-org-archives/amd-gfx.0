Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21013C001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 01:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8071E10E1E5;
	Fri, 28 Jul 2023 01:46:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894A810E1E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 01:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5oGP8+BKJZS8LHpg+qmJa2gwiKdthKEEKXt6BW6sbRmE6+22fDoqVR9j7qLZi/gRmcSEDgPNDhJj5XZbazlCKxG5cWdz4Xf9ZBBC0B/Ti3QrGgI39ib4WItitMNmUds2gGFsiBGkip/WBnEoZcDNaioBUdqG3jTjIjtiav7h+LkJQQCUZM7aPxqrlizPNvXF8Uh3LBg+YuQ9Oy/IOi20qOLMNCiWSGXThyrZ7COlGYhhQjVHzKBuMz7dAvVvTefb10egQ58TLYNlhp5bPxw6YNByN2lmKRYVmEZ8UzjxPQxQNGD3IWqYDdxtEv9MSv0cIuDQAkUpI/LNaN3x95IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MXeSulIK7WRMFXDqH9lAzoRMF6YQjiIv3QkK1690hA=;
 b=Sb9THhewoRg5RUtZeGTU0fPAbW7h5cCN1BdRv6GHfFTxZVzXP7dfwMhq6vIkKQMsif8sAWsXsCDDNOGCWnPUdO4srXkU4Sk2fStywZUbfTraeLehxYBoCt1JW1fqKxVMCeAuLZ1mT3eYzdmCD4IRTC1ojTbfxUv0nl0wXzlWWt6/cy4h69UYVbUhmX71NFwsHkSeLjclfQcjgdX+t4ZRFC+YBcyXJOguUIec5GJnYM/E2awHtm1GGu1WCBftmzwGK6FevfrZXXM8Kei7sLhAxZyTZpFm2nbp4FA+azkJA0RGzOdmGPCtq2zrMEUolpyx8PCJXPUUtTO9IHbJSC9PYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MXeSulIK7WRMFXDqH9lAzoRMF6YQjiIv3QkK1690hA=;
 b=ILWbhgio4rZmTvDCisuc0VLaYncKj0fpNxh87FfEMZnAEpU7zIl3mwbyeptrSiwOhqccEAcv0O0wtrcE4P6q1V1pfqXynjz9Jfg5P8OnsqMHOqyWivzM5TTgwhMcXueeOWcvWsSukWZErecOT5OYCBz8+ezlaHk97woK91jlBXc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 01:46:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:46:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Index: AQHZwH9O6VrFqVZBkkKPdo52VtIuWq/OaYNQ
Date: Fri, 28 Jul 2023 01:46:20 +0000
Message-ID: <DM6PR12MB2619440125B53ED54D69A868E406A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230727114125.3891244-1-kenneth.feng@amd.com>
In-Reply-To: <20230727114125.3891244-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c593c722-8597-4d42-9da7-3fe50f217d74;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-28T01:45:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MN6PR12MB8543:EE_
x-ms-office365-filtering-correlation-id: 438cc7ca-07db-4d76-da9f-08db8f0c7105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO76fsi4KgLn92xqR0CS9/zNfa3QTNuP/N81+xQs6RTYcnYXRIOl4NLkeUgNZB/5JmpaMX9gX8cQ0HPKz/PiKFPOHZJ+xvO3x6ChsWsldUo7H2Uu5LA9FQXw8h6aKgp+Mw4HtC4gIzL3r+28n1UDvdRmB7W6zpbSnFRCBxGfaTk5Ug5gghOg3iegvOiT5EpAJ8IWWgmu1MBpmQzwtxMMl0HXwH8XDfSn++cR3WHtpmBJCa8JwWCaXbvpyJ6Qodjw5A9XRskB7Nimo59fqKkHMnN7Be3YORxm2iMHKaRdnk46AutJ0MS8oE4Y2Ln7mJWTNAJGi1fIfoLi8/y2bETb53cWKDQcRYlccsQHdztlHphNTyBnu1oJywArCQjM06IvytiNzqjhaP9IqgqS/DqZOP/bk84Thi+SBMg7Y3A3fiP0f7IOtKFvLSU8ty98tahgkV1Ehp+4l33wzbpPKSuS6hLCmW1XNvCx61ResyRskzhOgAXpQ8r0gUqiiTpp9gJEDRIpjIiH3AKjfAicpN9povGuvPHWIr8u4bkfoBSfzoG0plfixhdYGq4W7jSzDchOx+ZJcM9/UnQdDOGmXWb9VrWQlMSHwpixrxEUG17V+3A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(55016003)(316002)(110136005)(7696005)(9686003)(122000001)(38100700002)(478600001)(52536014)(5660300002)(41300700001)(66556008)(4326008)(8676002)(66446008)(66476007)(71200400001)(64756008)(66946007)(8936002)(76116006)(83380400001)(26005)(6506007)(186003)(53546011)(86362001)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?972RQLvez1UKISqIWP18gldLJ29WM5OUXzvAtH4zQnxT14JSU+7aAS51toOR?=
 =?us-ascii?Q?+wp1S/6Sns9DFINxEvqPE3z1X7ruaUGW3mF//rnmkWRhDhXsT2xBJ7tH9NPy?=
 =?us-ascii?Q?Yu66P/J17ZNJHgYDM05xJic6xR+Iw0e2bjAakasysAivGbAMp5jt9ZIIAPmI?=
 =?us-ascii?Q?tzsaze6ZLPdnlAgVnp1jU5UlOzaVp8DFmBIMSr7wDqEuQ0mZ4MACEEXa9f4K?=
 =?us-ascii?Q?xnlUAU7OGUFcl6ZEdJV4hypwv2GY2szyvKztNiE2sdG6DNSomBfySeUaECFz?=
 =?us-ascii?Q?0KXeFyInQOzx7pNyuWBQ0Y1lox9FfIzIFfnDr1k+3W+mv0viYJsFUWsxZAnU?=
 =?us-ascii?Q?f2bIeO5mVsuQ0kewNIexBhCqFTs1jX0J6z2Kj+YNDLhiFp2+AZLAI92wIH0t?=
 =?us-ascii?Q?zXgIPbmYKjoYTdIi0MkZVCqUpdwjUzwlNxtHqw/QCoAoC9MG5LTXtM3pHmjB?=
 =?us-ascii?Q?492NoY4maJ7OeCbqSgoL0OJMlb/VUGS5lmnkLB/7GbNiPUMv2ty+MeYHNa1S?=
 =?us-ascii?Q?GsvHx4HyO4JbmQtn1RO5ZXAPaF/7fc/WfFWyxN6CXSCPFyvHqMRziM8Gvnpz?=
 =?us-ascii?Q?14lL6Ia229eDFKX+v4WmjQnNF3xHT5w+SJ/1n21DH0RS25J2eJQ8Td6yTfDw?=
 =?us-ascii?Q?VDe9XbMc2Lq+NHf7ZoDt5HCJ+wzkW2lDG7aBGYP71v2eHCIlQugzInSxppl9?=
 =?us-ascii?Q?8+jmWuChbUkQJUlXwHJ9Bbv2Ys22yLa/K/SC8vOHKyHgVZ2jqeASARK9tcva?=
 =?us-ascii?Q?MoqdYdlSHH5ZmoZlurv0S4Ctz1eU/B4qCeuzQNZ4U909WXVk7cqh+5Zk4h1M?=
 =?us-ascii?Q?HK+PUx9gr/C5oZC20d2cnxTG3upIBJtXdSr2iv7F0AYbxI/vax5e//NVJV7V?=
 =?us-ascii?Q?1Pl6p4YsJvgzmjVkdcPlJpArhJuuVQ6dh462aI7xZhP0a3Ir4WwaWI1DJc55?=
 =?us-ascii?Q?O866uGsfUxLwsVeaJXw5p3ta0yGeazWv3NBvPJCa9Ccj0cQ0HP576c05z+PF?=
 =?us-ascii?Q?dPxvm3g7havYb1Wxd9fLk6Lu6lKXzreI71T4coIuPGcZwiwTWv6tubHRPujA?=
 =?us-ascii?Q?6K/b4BFosWKHqboOYvcDpuP4iaT3gW9OsivGs/bLKN8Wd24Q90zdACRfzO1x?=
 =?us-ascii?Q?4nUcqlM1E9ew/fc8JPoAM4fjbyzCPVUWmuszZtdS1Dm5+4VKEiuxuVZRZzUS?=
 =?us-ascii?Q?MhPD9+xyKE/fQzp7qKJriVfvZE+PjKzd0k5Fs+fa/MIvLx6gAS0tEdCffEyu?=
 =?us-ascii?Q?q/63ueIHwECFaAP3xrWoQIQjDyH9+5C84ax1u47wAELOtU/d4GgbvUuS2NT2?=
 =?us-ascii?Q?v0VeOBdn07jlwvkn3tuVmwoyGUbhGPpw3xQ7AHCKOHUIIvuFTmVDR49oZjXV?=
 =?us-ascii?Q?Flbz9JCj3F3PatpBMJpf35FQNJQAmEf9mVGzKqM3JStZKSR5cd8lRhoiuVCa?=
 =?us-ascii?Q?Z5IcRbBKcBaGAAC5f7nmHjzTj4f889vygSi6IVMSH8wBbkVSQvfuXE/37Sv2?=
 =?us-ascii?Q?Y8u1z8wVTYoxZKgoZ/FgTky/D2PvePi9T7oLH9KILOBlvecZ9Rj2ybCxwUVQ?=
 =?us-ascii?Q?bdLB1EP4zVYOZMZYrdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438cc7ca-07db-4d76-da9f-08db8f0c7105
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 01:46:20.1375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJFIqZicxXFe67egUJP0FiAb2w/Ev82qltzq21FgBaJFx2Nof6PsWwlTgCa3/vOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Thursday, July 27, 2023 7:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
>
> correct the pcie width value in pp_dpm_pcie for smu 13.0.0
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 232274423f9e..4bdbd3910e1f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct
> smu_context *smu,
>               (OverDriveTableExternal_t *)smu-
> >smu_table.overdrive_table;
>       struct smu_13_0_dpm_table *single_dpm_table;
>       struct smu_13_0_pcie_table *pcie_table;
> -     const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};
>       uint32_t gen_speed, lane_width;
>       int i, curr_freq, size =3D 0;
>       int32_t min_value, max_value;
> @@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct
> smu_context *smu,
>                                       (pcie_table->pcie_lane[i] =3D=3D 6)=
 ?
> "x16" : "",
>                                       pcie_table->clk_freq[i],
>                                       (gen_speed =3D=3D
> DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
> -                                     (lane_width =3D=3D
> DECODE_LANE_WIDTH(link_width[pcie_table->pcie_lane[i]])) ?
> +                                     (lane_width =3D=3D
> DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
>                                       "*" : "");
>               break;
>
> --
> 2.34.1

