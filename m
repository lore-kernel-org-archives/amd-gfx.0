Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A80C636C9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2016610A0
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2016610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5086E508;
	Wed, 21 Jul 2021 03:07:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B138A6E508
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In0nREBrGbvbZWWrzxjlg8XtSLLGTENco3rqRTSw8TFBCn3C3/uB+f/wCOcbiyj4hvLBPOIu0g3BH9OhWXDzrYNKASXW0nHZtcLx2jO21hK3cofjg6jQJr3Hzr23vFPDNxvr01myGXCkFimNUHmKAJzuQbC/kZQE5gbj80+tARHxPGgp9fRV/BqpZV5pMYuMmsskGuRdYiw9zZQuqX14G5bybYRXRFOX0MRGe8vx9jzXmB3AbqKcXLdZJraHHxnYU6xYFFji7YgxhLpeeu89r1uFfKatKMFemuewgq60eDLM+LzCi3evyA6Nw3GoWYZRunIl2vHAbJuQw5kFprVAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0drNMEZuaNMpnOiPCla/rYfU4c6EOMjPvySdL3UVmA=;
 b=afbFbpD2O/D1VrYtHSpV+tYp74yq0ceoa4PSmStjdNpSjIRRFwPwej4hFXhZxZLBjE2ptwOsa5scA1mCb+SSaDwDSrx2p9ZhsXNFQOx/obr57XvoiumFtlumFkAhr/rCWglCVFZ/x1mHhPoPYzuLfrHwwxDD1TdLU+S+C0QIsDBTzo/gHYt6Dk31HSOPTdCIW4s+GqvHaN/G0XUFDnIRFHK3dDVaR9V1JCesQkgUNc6jnkgbLIvvGcAIMBFbeyRqrrC1VeAD7yhnuDZmxCHxhjdBvI7UCVuAw2e3b3pd4UMdxE7+Zi/sVoLMrShaZrCg57WbkuOw9AtIiwPtdSHNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0drNMEZuaNMpnOiPCla/rYfU4c6EOMjPvySdL3UVmA=;
 b=M+YYz9W/nwe5sASr3KSZaHlZ7sN0wU2FcViShEjspZgYT6spS+RHYsKBvHO6hHbli02e6a5R7hAjUoxMhh6GMa0I7hlPzPTPPHKY0stzkIchUEoBH5ufXB+RTJhHwnTBHQCAGLUOaQk16xZoWaiaXq1KlvgtIAKscS10Ug0nEBA=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 03:07:39 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::a1a7:610:55c6:fca9%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 03:07:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
 version
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
 version
Thread-Index: AQHXfYL5I301kMVnxkusPD2sGopvv6tMuRiA
Date: Wed, 21 Jul 2021 03:07:39 +0000
Message-ID: <BYAPR12MB323804F0C5D873A19E7BC36CFBE39@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210720161808.18690-1-mario.limonciello@amd.com>
In-Reply-To: <20210720161808.18690-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d4a5a8e7-ec95-41a2-927c-b679b33afa28;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-21T02:42:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d75bcced-4066-45d3-da9b-08d94bf4b2f2
x-ms-traffictypediagnostic: BYAPR12MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3605CC7CA60C5AB973F30DA2FBE39@BYAPR12MB3605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7LErGWpSzmoYk3V0cCraQDq8hzY3/fBHisyd+X8HCGDlrt2muInTskRqBsBGSk5f9GjdE7h4/5MUvxGyb6QzLCh7+KjbXhxMW/lLIyO+x5lWRTwIeEet8YhWGmKQ8yUIaxGReeIKgoM5qnMu6uA26iGPxILvD277AmtigcIJFgdJkFGEwKSgw+PlmMr0Q/yJHCjJInfJ2DsguE95KW1tkwXClWxDx13c9TbSQuxeKljnSqiUuJJ9Zqk/CTus2xL0diOTGuvfqjB2JZaBmNdLWmIkqq2JG6z88USi9SWrbG9xZ5qBAACn3uWr59PIeIpH4RUOD3ZcARcAb4LT2twkgFo/uwjEFzcsgSCac3rNzw0/TwfGgIQnmtobHPB6vxf5+33KrJSZ3+siIx6uEyRfmdiTqwJZuj8LWTyjPyT49FhGbnSK4sSkmb1LRJ/W37bBYcncl1QOUCDbl3Njr3vj3kKsT3wByBQVXP5jVl2yqFy5S6q/xHmyYLxPGQjg2xd1obDDbpZSKtUMYxpRVPCmoHQy8LPXxRFkkeEfIjWq9znCKwf5WfpFXye6cbVvYj+1mIUznS4kLDXqAn/8rFBdEi2sr+Vp9XJTM3U/rug5UQdRq1FfDMl9BHQHsIwBhQfZu2ap3AR+T76ZMXs3dn1nq8CDk2fSUBUe5kEBJrKAR8etRi8Ezdrfpl9UJg4wu08+/8yu3vFuCVVm58JJ8oVeArmECKlfcn0JXt41iABZThFmCGxuUuwuIxg2Mdcfgrb+MDKl91Qw2RT95kxD3nHGrk2vheKJ4Rfh4q/6hVT0Em7+NXt6p6hXaZZBCrw0qi/x1ynzrtHDa5VSK6nJzRyGdwsjl4er6+JC9NSCAUpFf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(71200400001)(52536014)(83380400001)(6506007)(86362001)(53546011)(64756008)(316002)(66446008)(9686003)(45080400002)(76116006)(66556008)(966005)(38100700002)(110136005)(8936002)(66476007)(66946007)(2906002)(8676002)(186003)(26005)(122000001)(4326008)(33656002)(7696005)(55016002)(5660300002)(478600001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAr0Bx+W5FGDgkoxru8MyiYR7qgswQY5dFDrbKebeT2aqPwyTouut+8hy14d?=
 =?us-ascii?Q?FWg9O8eyLfMz+Egjilfh+pDwOntEmlLIOwDNlYqFICaO2kNbRUuQGaHK5NwZ?=
 =?us-ascii?Q?0ZznD/lGUFHX9Z2A4CmawApjLsnvMKuNIbW2YEzXltJPueRtkRhKCrcFLyMC?=
 =?us-ascii?Q?LWLBb/JVS3KVdgUsdzUwW89KDflQUvrfgCiqhbexs0JFDSosfmhN6wh+ibqI?=
 =?us-ascii?Q?vbqkvzj+jiMSQI5SPWzsn0ue/6q7BCNbrJvBxAzxIXUv2wJZ8Kf0QXKyg0pS?=
 =?us-ascii?Q?iz3FN16/t5fi7q4RoJEh2wQcci0jwOZBXgl9iJpJiatM1JzRhJsBl6jIgkcU?=
 =?us-ascii?Q?QXgK70YXNW8HSHyhKG9oHHByi6mK+Esdpzws5G7d+7qw3HzpUREnJHVauTjI?=
 =?us-ascii?Q?XLYUTGzdVCLHkOjuXAymoRC5QZsjFDNmvNrO6AV5IpqUeZUqCbYLfqKlovBZ?=
 =?us-ascii?Q?VFExL31dh7qjXCWU/9NFlPPLKsL7PX9mIJFqNeqvF6AavfdgF4VSi4ZS7+FG?=
 =?us-ascii?Q?oU20SdtGH0UtN2JjxsCm7gFl2NJ0La8iDSoRWoBAMiKXAKa2KYLR7ELKMDBh?=
 =?us-ascii?Q?T1/Js9CrClq1OinR7bxCRbuf7dXtlUPOoAjckWM7MA0/gPQgtwY2XwSQC2rZ?=
 =?us-ascii?Q?KtEJevl+2z+lgBff1MdHh0Uojqu4JL5n3iY6h+EdOfbUTut84gEXctz3bZix?=
 =?us-ascii?Q?CzKBvNZ9UdqrqHSBFFk/3EG6hxDVC2rN0iy/CIpqFXVqPMXZcE3Z56s0eMuf?=
 =?us-ascii?Q?oEdDbKx2f9cDUOFNmV+ae6vwYV7G1PvzWXQ+LLqqcF8xhp07m7C5Lt+G7gca?=
 =?us-ascii?Q?WCSADbLY0KZadX4rne0vIr3dVp56zuX7HurF4uAYKXUPx4wT3CeVrVLJSUBW?=
 =?us-ascii?Q?touq09nEEE0z5WSzvjiCFqtv6VLePL20i+MFFh6R1rh/YM8aPpbmz6mYQUzL?=
 =?us-ascii?Q?p5Ggcr36FYM8XfFVV4sXl+meam0WhkSD+W8EBl9gB5QevWIhwt8n/CceYlI3?=
 =?us-ascii?Q?sOF7WSQO4mibK5BlaV0eW4fd6uOizHmUYFwc4nlC6zLR3qxzJX+NPIQUI9ii?=
 =?us-ascii?Q?nkEwJaaBO+KhEMuNzIK5nylORCFcZELiHuHs9ik+xlse4aX7mtpKl490rYGS?=
 =?us-ascii?Q?8aY1dL3IcWOSx/IeTkHQCj3VwKnvA6jCHKKy8fnEXZcSoixDVF4CpuTUidcg?=
 =?us-ascii?Q?lbsmHfJL0r5mogW731JevpHlBS3Uy2Lr9gzgqcy/yMQGZ8OqUnPETph56tXh?=
 =?us-ascii?Q?w6dI666Fgl3Kuh5MLm+ix75MEPcu8ZB09FMgIVIPb6nKl9XXEIHemfKcuAlk?=
 =?us-ascii?Q?9P2WCpHOBAcwZElR4A69j5Ap?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75bcced-4066-45d3-da9b-08d94bf4b2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 03:07:39.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JZy0NXwlXan7c5+bKKDBU+y7RIk8xiqXpvAJ+qfSTgPeKk9aUqWJWdqGMt3jtAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

In the SMU issue troubleshooting process we also can check the SMU version by reading MP1 scratch register and  from long term we may need put the SMC version collection in the debug sysfs amdgpu_firmware_info.

In this patch fashion, we better use dev_dbg instead of dev_info for only debug purpose.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Wednesday, July 21, 2021 12:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
> version
>
> This information is useful for root causing issues with S0ix.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..626d7c2bdf66 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -272,6 +272,9 @@ int smu_v11_0_check_fw_version(struct
> smu_context *smu)
>               break;
>       }
>
> +     dev_info(smu->adev->dev, "smu fw reported version = 0x%08x
> (%d.%d.%d)\n",
> +                      smu_version, smu_major, smu_minor, smu_debug);
> +
>       /*
>        * 1. if_version mismatch is not critical as our fw is designed
>        * to be backward compatible.
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C62180964b7d24208
> b59908d94b99f971%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637623947521949203%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdat
> a=ACcymqjRA5e1wmQmBCPW5cwsM1tF5QXOXQRukuAgkeg%3D&amp;reser
> ved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
