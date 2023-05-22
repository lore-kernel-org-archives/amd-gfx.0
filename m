Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD9FC7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 01:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBAF10E237;
	Mon, 22 May 2023 01:58:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D3310E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 01:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npui66J5aOr8g6zdKmdRpaB/PorbqwipfeisjwWnhyia+Lz/MEYrrNwFfxHPLg0QVBhw3gHFv3MR2R/dOWGwbLYLibq3oVlo+YAWxUV8mQdT+v8Xe/16+CMvr1OgQWTGTf/OfyTW/oW+7eM5d+YNBfOEBvaVCDvOHe88nkUHoEMzKFhhGMBMN4cfdsfkqMnRqDAXF2YGWX5gYmlttevx8xXpmgWgPuqwzfn7xNd0KKhjvKEWG1AQJNjB8Sr2joeauJZjWamo4mUSN7oNE8t2qPzm/lx23SPUxw5mHEnacnro7Cbc5hOyJPn0Oew8Toai6Gqq7Uy2tgJJnXkbKv6yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTDX336uwoJPL56mQE0sX90A+C0FXRRi57slGcxsS6w=;
 b=P2h61j8V+RJ8eYPnQzJxLTmZOP6+VRew5LnLJ7VdtaDEtvx5xmD0K7sksVw9igVkMrKG8xSgHCePm2SWARV4T0fnI0/uD22Fj4QwLr9J/jYurOxtR4bUeen1nspqDAC8GbfIO6aUQgI9+7JLdVrAfUH2621Bkf6lGTu6it25hujd9n3pc0uSYppipYva7DLeRp0YSYKNVTDuJW9V+v5AKN2yyw7nbZiAwOwF7ksBfYmkV6xb3qg7mbHQ77+Ep62ze15FDIaWMIlU6FG6sHYyQAC+hsfKC19ANkIZgfnscPoJwHGpA5mp0i4mwYlHET5+IZlSul5CyjgQJSR9alCyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTDX336uwoJPL56mQE0sX90A+C0FXRRi57slGcxsS6w=;
 b=ANWrGmtTYZ+IQLEYq9oKZOmr1ASD/5CAfpyBbCnr5/hVSW1an1Ej4Zb0flx4CtoqhNVSm4PJ//BlvOCYKua2/i7ItOKB/DFV3pPFr+UdSUDTb/odL9rb9SUzt7soz6kHK1dmP/I/K9ciOiPLqI3myYUcHdFHsxp10pkvM7m4+Yg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 01:58:23 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 01:58:23 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amd/pm: add missing NotifyPowerSource message
 mapping for SMU13.0.7
Thread-Topic: [PATCH V2] drm/amd/pm: add missing NotifyPowerSource message
 mapping for SMU13.0.7
Thread-Index: AQHZjFBIgGkqFgqeA0uhHmOguosytq9liQWw
Date: Mon, 22 May 2023 01:58:22 +0000
Message-ID: <DM5PR12MB2469288B68FDFD7B4AC8DF79F1439@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230522015329.1664855-1-evan.quan@amd.com>
In-Reply-To: <20230522015329.1664855-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f3e649dc-7fe7-4d1d-9ccb-1afc445bf17d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-22T01:58:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SJ2PR12MB9113:EE_
x-ms-office365-filtering-correlation-id: 97c53698-121c-4b90-b253-08db5a68062e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJLAV/msnWwFDUTGjPKTx9q5FVZtdgoGeHqbFDDfhsVGo4osoTs0ZdJENJHiyU6XrFf9I5qlOxCI8hdYRs8M1pG9Ex6eMRzzcvtSSe85iNcnTo7X47Jb+rxOs0cB3B3C+zK4PJs9SS2N4uoLARbxEXldlGTgruicnB4DumBwbrbMzPHz5BKXrRiZPL23RMSefdEHduD2gFfHf/TzYnaJip/raJ39G4wuaBWNcVy3TQLPZua/+/mDRvq6hGSuFkhExvYfqZjZOKivLsr4RprqQe4vAATCOpwwwVLZ4si4BNjnRl7DbkRPqOryZwxsWyXJ8jWU8pTsgN35mquzF14Z/k1ExyArxrDNF1N4g/lZnBc7VPObzEnnrxNX5l2wjkMfe9bEdISvX3xHGcCC6yFekbjwoCSLoYmTnI7lzH+ueFys9E4pEMNsZ2QBnlVR3vsA9P+/YiiWyV1fK7y6PHGd3PcPo6ShArIQazsD3QwEu9/ZKkcAyu7MGvrASKmeA+zFUgZABHT1R22eas5apsi8DmEHh/OcMHIxVrblPAwX3GcI4WnHqNFbu1MKcneN2jw6MYEu7RkfdgPOYyL74dlCrHEGlbenzT9pCloiGdJhyxhpzr5utsZFuPsPlwZeWOtX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(38070700005)(122000001)(38100700002)(33656002)(86362001)(55016003)(53546011)(9686003)(52536014)(6506007)(8676002)(8936002)(15650500001)(2906002)(478600001)(110136005)(186003)(64756008)(316002)(4326008)(26005)(41300700001)(71200400001)(5660300002)(66446008)(66476007)(7696005)(76116006)(66556008)(66946007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kcCtQBCKrJZeI7ReL4MxT8Hi9nYXooF9hRiZ4PqSWkaMZ3HAB2nDGfvzOPAo?=
 =?us-ascii?Q?r/HD1dd0gkhkG77ql6oKlTVNgUIsYYnW4V/QOVBHPCyXk+vMvIEHGakIYkhB?=
 =?us-ascii?Q?qJrclQbEZv7GY8H95nVacCHzO+ijrjqtibXfNoqJeKvTdxlBy3JP7S4UN2dd?=
 =?us-ascii?Q?a7xKUzSR+BqoifJMgT9FLOWAalmHPrAaqECTw95vpjvtUyL7irAkIfsNMVEs?=
 =?us-ascii?Q?U5NL54N2qIo6ZpZl6RXxjDTjpxymFa1+gJX9IKvbaZznDWxh6/SR/Z009QGs?=
 =?us-ascii?Q?qPd7StpKxZWp3sQG93jGq/JwJZWy5SitbI/diHSTaChQO18HsInkrlxaFqk0?=
 =?us-ascii?Q?TyKw9J8Guc0UnH3yIeuPY1EuMHCloZfI3o7hVCiUE5zTa3zlON6i+v+vK0vw?=
 =?us-ascii?Q?3wSdE0h0krxwGxXnXsdJp7u2ejh9PMSWOnY4J1TRtFwhrs+T5hCsGfET6DHI?=
 =?us-ascii?Q?HmiHZPeDgZNwFpBRy271tbKW1Fp4P3J46EXInDnRfMzKktAZaBKP20+gKIaE?=
 =?us-ascii?Q?EVF3JickQpdqwF2L1cYs7zmYBsjpG16jGICkhULFr2OvX2omtuPanDQb1ga2?=
 =?us-ascii?Q?MTwEksR8efyKppD5MTQwaGTFBhBJDl1onk5sZpuFfEjaMlVan003GcXd9IFd?=
 =?us-ascii?Q?tm2McYQRsgt6Ee2Vrgjgjfzx7t63cUANin5FEHaAT6CXFSOc/rqkGLYk5rqb?=
 =?us-ascii?Q?zYxSBlp9fjtcOUOoMgXrM5tXxpsQEVCj2oda/VCy8W1cnxvAt1hvVLOsEqjT?=
 =?us-ascii?Q?K06A/oI4MZUxwkYLKPHfhPsGnCdyZ0AATjEnOuAnoBpBFTQkSzHjgq7ZBftL?=
 =?us-ascii?Q?CaLvSJgJAkcW6Af+vKP+NHQcTn6OX+ctd8+uVfEE2CDaNjslxZOU83xBupSr?=
 =?us-ascii?Q?7fDj1875mr7Ctw18suN7r2IUz1E5kBIUvWBbX9sCj78guUBZIyzQLcht79W9?=
 =?us-ascii?Q?I/+dUED9tu80NjX2M1qPfwPEpr9w0AK5bm271yhKPUN5XpN4jxjbXJTBhLL/?=
 =?us-ascii?Q?rYBnllUNjq0MYHuOL42vhTZUwzrKj7DcRsMjfumbWHQRxS6SmAu58E3LCh1l?=
 =?us-ascii?Q?pxwEDcQO+mJWARfEn0Usgbys5KuoSQvr51IKmIH0l0HWptWLFKuATzFeme0h?=
 =?us-ascii?Q?m+J9mb9VvwD5xPoTzOUE/ZTDIZSRRtgwq/PHuv+s5NtPxiXs3wZGRt6BOmAy?=
 =?us-ascii?Q?tEqfFehPlMOV/NKeUyVXlaBNfq8cbCj7WLXgc5R6X7sUmyhnDaAYDH5vhWBm?=
 =?us-ascii?Q?Dz5I//SXoMJ6HubFEiNSy390zPbSkrLhpr7sBB4k+4O55I6bnC5jgviGQnet?=
 =?us-ascii?Q?ifiwJ9l9/CzRqXxA15wXiVlziSUdjvpny+LqFvs930x9j8aDxJ22LujZex3r?=
 =?us-ascii?Q?m33CzvH8V4/QTRqFbazantaFLITtCpyBiTpeM4TLNf+AysvDaGkgFrWJ5qCN?=
 =?us-ascii?Q?7qWvcRWr6jDcSxDt5mRuHcDo3r0vs5Fb0dzjuPBgFDC8lM/PZ8eSWSpwvrlu?=
 =?us-ascii?Q?7LXB469qSFBz5fUZ9RRZ8kQnyVuqiWPtFYw8YGEy6svljpQNKist6opHcoke?=
 =?us-ascii?Q?ETFzmJzAWQ9WN4kaq+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c53698-121c-4b90-b253-08db5a68062e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 01:58:22.9299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKt9umD1Mvwroo9eH3tHjAiJ837bQJPL0mK/v6EIrhU7x3CcYHKDByZZXCoRXwZs3ypSrwk2jQMilY8fElo03g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, May 22, 2023 9:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V2] drm/amd/pm: add missing NotifyPowerSource message
> mapping for SMU13.0.7
>
> Otherwise, the power source switching will fail due to message unavailabl=
e.
>
> Fixes: 4dd9b5392c57 ("drm/amd/pm: fix possible power mode mismatch
> between driver and PMFW")
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 1b6116cf8b4c..cf6827179fd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,
> 0),
>       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> 0),
>       MSG_MAP(GetPptLimit,
>       PPSMC_MSG_GetPptLimit,                 0),
> +     MSG_MAP(NotifyPowerSource,
>       PPSMC_MSG_NotifyPowerSource,           0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] =3D
> {
> --
> 2.34.1

