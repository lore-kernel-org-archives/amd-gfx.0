Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B2AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 08:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149B810E5CB;
	Tue, 18 Jan 2022 08:28:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7171C10E5CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 08:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUurmptLUfpHx+4jO7105tzrYDpmltkNjSEyR7hihUk6MQzcLdZZfrFtweMGgNxEuuxlczsru+2F5LS2FasEISTG3qYiQLzIEkJGsBZQT40VrKKcc6uY3fL8U0m6ibraVEAuUBrVpivW+eh+pRu0VZ9d76M4e93eS7WEnpVqeorKazNtaaGcFMflZdifJl44GY5WQbV3esLmk4Cqa1y+iKRcV1hmq4ALDWqQhf+s6UFCIxTnFCRXRguGJnLScojNOiDUUsri/g2AXFl8TUJWAy2VNZkL3mbUSTx1jBSm8NYpuMYB12IuRkUoQkBlBM8/PVop2lIpNM449dgV0So6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWwPaL58waQYaIdmzrF7Zb+pkVyQ1pvCc0r63DlLpLI=;
 b=kIeUIsxpXf9yOAEqcVnsonUXdukxRnRIuP5IkKkgQe/UuOMTg91E+O7fQaDJxAFkaU8wmGbZ3Mprmr5I8jz0oKptJL07Tp21ru9RL9aFDON5ZyPQJKk8JT09+V9Mx0itvenMTemb6U9egeRlwQBK0MqLJmiMLri0kKO7xDy8MicUSeyvmezMMOuo4XlidXUb5ZtD6zYlaczfKwzEekyZKfwCX6Ab91svHb24td+kPkrHcFxmbDxXsGrRwRQhCUjEcndl5qehFukBRIHsFMcdvo0DAQbYVw5wzp7LE/mAz11v1uMhq1+dEmGIyATdmR7/ef4cXiDmVTYw2ygaQzPwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWwPaL58waQYaIdmzrF7Zb+pkVyQ1pvCc0r63DlLpLI=;
 b=AemvKPJJF6la/ucvRXEASUPIBF8NeiPf10+TyIfv7FrMK3DnEOOpJiOopbanz+mN8V5zeJkPT+T5xnLTdnrJQXn+nd37pxE1INp1GbJmkOAyiga5K3ru8PNL5lzzksxjwOlAZ4WxXOGy6NN4eQRjlEnxwDFQe1mL6ETaKKFktVs=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 08:28:07 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9cb7:c0e7:1329:e857]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9cb7:c0e7:1329:e857%2]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:28:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYByXoLb8o2cF6Xk2b5VvhdyfVc6xnfWwAgAABEgCAAAHVgIAAjX5g
Date: Tue, 18 Jan 2022 08:28:07 +0000
Message-ID: <BYAPR12MB32382789E82932190C6B1048FB589@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20220111200026.15855-1-mario.limonciello@amd.com>
 <BL1PR12MB5157190D878C197F8EBEAE78E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB4614363B37C7FCEB7150C29E97579@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB51576008119B2DDC0ED29904E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51576008119B2DDC0ED29904E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-17T17:15:10.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6781c0ad-fc5f-4c1b-4b25-08d9da5c7454
x-ms-traffictypediagnostic: DM5PR12MB1771:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1771CA9727F0292AD8C0E042FB589@DM5PR12MB1771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/pabfZ+z4Ty9kW5G8KYgnN3NZShAOI6iUpeM5JRS/6+E94kEGDtBmX0vxUWUnetOFLK46LqEGTyE+d6/3Gqfj+02jZYM6zXI4ka7I8a5LLK49kGhqPPy/9WNuuMKnSjzI0zR5bbgHGe/Yh7pbgP8vGljDs81ACelgtR/CBT7DohPS6+9Tx458NX8o5vKq/OkKG09ZeF789VmkCtZomGP4Dhn4IPtHiibAoQgCXpkyqg/TD6bARk8f9G3BfHw3kuJzP79LwJAc4sDX5ZS20lUuIOANRNlfcW+QTKkl9zQM7OhUSZEMjdNwpa+CZwOxIziEm3irvblAiC9pST2HMixLGHtjiQjibwAPutXdrWkDfZXRa6lpdnV78fmlJeI9sRzz4FMaMrOVGNVzHrMqwo9uqcnAtvMANpDIT4V917gSEewrJ1MTbjPMKwS5/sin8kahOYLCpsjFIGj6/gWaxwQthRUYaoMVzBZP9EJ0/43PbOhiJCyc7EgyEFSROLM2Q80Gi3YHbcWbdHegafJ9e30+tEq+By+yA8oGAxtyYMq19LuHlroC2IWxC9MuaXgeMWNB8oKvneg9GhPIahQaJsYFEXI0xzOddNH6yl//qcAekwZQX9I5hiSQxcrjnoWemIhcYBTXyNDV7qj07+i6kkAt+YXZC6i7oxmhnfxlUGkf24OvaalrTYUT1OfvEpEM9lH4fZKUvi6UubKS/rSU2QxUIrCg1iMnYmEZrYV4UYsv4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(166002)(86362001)(38100700002)(5660300002)(26005)(508600001)(4326008)(52536014)(53546011)(38070700005)(83380400001)(55016003)(6506007)(186003)(966005)(8676002)(66476007)(66946007)(64756008)(76116006)(66556008)(8936002)(9686003)(2906002)(33656002)(316002)(122000001)(110136005)(66446008)(7696005)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O7CSOo3Ez+TalGVv5JDk3Sl8OPqY7uC4NY/86/9tBfBBKUXA8hdFHS4pwQmf?=
 =?us-ascii?Q?II2ZOwLOVVlWKXiM2m2cHo2WbZs4M1cNgICqww/jUD7Ww+zomd6nCDNWg20l?=
 =?us-ascii?Q?uFumYB4ap9T5PlBdbBy84OK6q+D0B71uriQVNn9echCOyJHmKqad/RRdzQwU?=
 =?us-ascii?Q?vy3AJ+1zeSTGF0m691WBSrpKopmYEuaJ+yjM/u9+BEIYmEUKF1MDeeQFEmFI?=
 =?us-ascii?Q?gchV/hH26UeVfFdSkm/Xkyrk3YcSz2iwbjss6GhHyAWaAaPo5gBQaLecdbCS?=
 =?us-ascii?Q?FdLsP0IFYFlA1534linP9SuHsu8CMQe3eul+chDZT4eMfUtcbpRW3e8EYdBQ?=
 =?us-ascii?Q?HaTDQUqyxgEVz/4uwEwjTDVxMrI3qBBI9ezY4oj6N1SoIfRo+PsR1HymSqad?=
 =?us-ascii?Q?SJr2l2dzFe1ZEiKJETjY4rOQipcP7+PcwuTwm9UBvCBxG6HWKZT1BFVRcyVh?=
 =?us-ascii?Q?DNhvKB/NJas1LOtlLFBRTEftYEjWnnSW6E/8UHT5zNM0i1jWGez3mL6lAVGI?=
 =?us-ascii?Q?p3RBCiDVj7kPh38OU1I6bRHpwyVh9A6QTAypvES4wpH0IT90eEF1FoNPplxw?=
 =?us-ascii?Q?jUzc4C3HCnT7suYYH1a+6p4srriBhy8PGPb2P0EH6Ox6Bpa+2YwWli0/Firj?=
 =?us-ascii?Q?IiTnSDUy8MPWgqMDYiJx+9fTi0XxfmuxxAjSMIk4+ooDbwWTPDpIrPZlkrSO?=
 =?us-ascii?Q?fbZOhvLtqUuKxladf08bVruY5uKFwdOnmYWBDWsCsqqIOrE2TZ+NL/8CCdjf?=
 =?us-ascii?Q?o5Go8sXjkJO2ogcD2weEiYzU/SEYSVWmJu9MWvstYBmLw/zq1x3qF40NPIJw?=
 =?us-ascii?Q?wRU7mqg5K/2JnbLP21JyplJIWMpfrDwToOmFFMQmlRFAsm4JEyteZM43+ZtR?=
 =?us-ascii?Q?4NUX2oiCkva8/2c/qi85IcZPLCrtPBDS5UEdV1vgRIrp2SusJuZT+Ltg9g1y?=
 =?us-ascii?Q?MRnugYy0du8a/R8yKhEK2O+DQ8R2zh2MirfS/Dwd8NYlVClTKyMr7CgxMyJ8?=
 =?us-ascii?Q?mk2jFmuo1G6iByJewKpZBgKf3kQMGBmfabX7jKWB/FO4+Lv0q+TfbOiqSPWN?=
 =?us-ascii?Q?rj+Z6Yjp2qwHBY/SFFq0rY3n5bxXNr8MOhMrVKIz5GDXjMBA5ndyU/9o5jvZ?=
 =?us-ascii?Q?gun/xMfuFyAddRWexyDimP8ECh5512BIpAbOq71Wmq4zE/RdFrjW+ubVj6lc?=
 =?us-ascii?Q?K2ebpby75c/Cim0Gglt3FlGULcvzDrAHDi7KM0AZlz4FpTWa9ose/MsJlxXt?=
 =?us-ascii?Q?t9WHDkHcWjvWpHGnWoVeEPScs5vHQ7tWnKerhuO+x+eOfmVn9i0jRo5+zlzl?=
 =?us-ascii?Q?DSkNSvqUc5dN0huZufgKPL4HNzJx1aaSuo/gUMHrxvFYXFcGyYBywn8BaQOV?=
 =?us-ascii?Q?btnxsGStoN3SrTitdCsbVckhtDS/mqylfxCD8sL/FDh1sxJbPNf4aY9LMgJO?=
 =?us-ascii?Q?5w1VSH9RjvI9ATURJJ2afcvpoaYKMW316OqtyjK4qCBh5M/Fh+237wI7POtm?=
 =?us-ascii?Q?gg5734qc8Y7Hi39+DB46U22Yuz09j960vawPZKsXHGE2yR7rBUSsF5JLbyMX?=
 =?us-ascii?Q?e09L0QPMwKAzvKBYnSg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB32382789E82932190C6B1048FB589BYAPR12MB3238namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6781c0ad-fc5f-4c1b-4b25-08d9da5c7454
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:28:07.1757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THiTnHZEJYzMrO0TszAERkcbejh0JEut426R6OfeznAikCiPDJIr/rKWmZ6aPjBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB32382789E82932190C6B1048FB589BYAPR12MB3238namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If the flag ACPI_FADT_LOW_POWER_S0 not set or AMDPMC driver not build, then=
 that seems will mess up the suspend entry and unable to enter either S3 no=
r S2idle properly. In this S2idle configuration issue case, how about add s=
ome message to notify end user how to configure S2idle correctly?

Thanks,
Prike
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Limoncie=
llo, Mario
Sent: Tuesday, January 18, 2022 1:26 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems


[Public]

Yes, that's part of why I want to make sure there are explicit warnings to =
users about using this flow.
When not enabled in ACPI then also the LPS0 device is not exported and AMD_=
PMC won't load or be used.

I think from amdgpu perspective it should behave relatively similar to an a=
borted suspend.

From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Monday, January 17, 2022 11:20
To: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg>
Cc: Bjoren Dasse <bjoern.daase@gmail.com<mailto:bjoern.daase@gmail.com>>
Subject: Re: [PATCH v2] drm/amd: Warn users about potential s0ix problems

Any problem with PMFW sequence in the way Linux handles s2idle when it's no=
t enabled in ACPI?

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>
Sent: Monday, January 17, 2022 10:45:44 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Lazar, =
Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Cc: Bjoren Dasse <bjoern.daase@gmail.com<mailto:bjoern.daase@gmail.com>>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems

[Public]

This has been sitting a week or so.
Bump on review for this patch.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limoncie=
llo@amd.com>>
> Sent: Tuesday, January 11, 2022 14:00
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>; Bjoren Dasse
> <bjoern.daase@gmail.com<mailto:bjoern.daase@gmail.com>>
> Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems
>
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel by
> using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> ("drm/amdgpu:
> always reset the asic in suspend (v2)"), the GPU would crash.  Now when
> configured this way, the system should resume but will use more power.
>
> As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> potential power consumption issues during their first attempt at
> suspending.
>
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com<mailto:bjoern.daase@gma=
il.com>>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824<https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.or=
g%2Fdrm%2Famd%2F-%2Fissues%2F1824&data=3D04%7C01%7CPrike.Liang%40amd.com%7C=
925d02acbde94f61cb2b08d9d9de74bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637780371747154944%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3DfO8dU9u204YesBNjoI99%2=
BAkngggcEgkQhet2mnkCRls%3D&reserved=3D0>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.=
limonciello@amd.com>>
> ---
> v1->v2:
>  * Only show messages in s2idle cases
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..1295de6d6c30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> -     if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -             if (adev->flags & AMD_IS_APU)
> -                     return pm_suspend_target_state =3D=3D
> PM_SUSPEND_TO_IDLE;
> -     }
> +     if (!(adev->flags & AMD_IS_APU) ||
> +         pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> +             return false;
> +     if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +             dev_warn_once(adev->dev,
> +                           "BIOS is not configured for suspend-to-idle, =
power
> consumption will be higher\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +     dev_warn_once(adev->dev,
> +                   "amd-pmc is not enabled in the kernel, power
> consumption will be higher\n");
>  #endif
> -     return false;
> +     return true;
>  }
> --
> 2.25.1

--_000_BYAPR12MB32382789E82932190C6B1048FB589BYAPR12MB3238namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">If the flag ACPI_FADT_LOW_POWER_S0 not set or AMDPMC=
 driver not build, then that seems will mess up the suspend entry and unabl=
e to enter either S3 nor S2idle properly. In this S2idle configuration issu=
e case, how about add some message
 to notify end user how to configure S2idle correctly?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Prike<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Limonciello, Mario<br>
<b>Sent:</b> Tuesday, January 18, 2022 1:26 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Bjoren Dasse &lt;bjoern.daase@gmail.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes, that&#8217;s part of why I want to make sure th=
ere are explicit warnings to users about using this flow.<o:p></o:p></p>
<p class=3D"MsoNormal">When not enabled in ACPI then also the LPS0 device i=
s not exported and AMD_PMC won&#8217;t load or be used.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think from amdgpu perspective it should behave rel=
atively similar to an aborted suspend.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Monday, January 17, 2022 11:20<br>
<b>To:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Bjoren Dasse &lt;<a href=3D"mailto:bjoern.daase@gmail.com">bjoer=
n.daase@gmail.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Any problem with PMFW sequence in the way Linux handles s2idle when it=
's not enabled in ACPI?<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Limonciello, Mario &lt;</span><a href=3D"mailto:Mar=
io.Limonciello@amd.com">Mario.Limonciello@amd.com</a><span style=3D"color:b=
lack">&gt;<br>
<b>Sent:</b> Monday, January 17, 2022 10:45:44 PM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;; Lazar, Lijo &lt;</span><a href=3D"mailto:Lij=
o.Lazar@amd.com">Lijo.Lazar@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Bjoren Dasse &lt;</span><a href=3D"mailto:bjoern.daase@gmail.com=
">bjoern.daase@gmail.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Public]<br>
<br>
This has been sitting a week or so.<br>
Bump on review for this patch.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;<br>
&gt; Sent: Tuesday, January 11, 2022 14:00<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.com=
">Mario.Limonciello@amd.com</a>&gt;; Bjoren Dasse<br>
&gt; &lt;<a href=3D"mailto:bjoern.daase@gmail.com">bjoern.daase@gmail.com</=
a>&gt;<br>
&gt; Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems<=
br>
&gt; <br>
&gt; On some OEM setups users can configure the BIOS for S3 or S2idle.<br>
&gt; When configured to S3 users can still choose 's2idle' in the kernel by=
<br>
&gt; using `/sys/power/mem_sleep`.&nbsp; Before commit 6dc8265f9803<br>
&gt; (&quot;drm/amdgpu:<br>
&gt; always reset the asic in suspend (v2)&quot;), the GPU would crash.&nbs=
p; Now when<br>
&gt; configured this way, the system should resume but will use more power.=
<br>
&gt; <br>
&gt; As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about<=
br>
&gt; potential power consumption issues during their first attempt at<br>
&gt; suspending.<br>
&gt; <br>
&gt; Reported-by: Bjoren Dasse &lt;<a href=3D"mailto:bjoern.daase@gmail.com=
">bjoern.daase@gmail.com</a>&gt;<br>
&gt; Link: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1824&amp=
;data=3D04%7C01%7CPrike.Liang%40amd.com%7C925d02acbde94f61cb2b08d9d9de74bc%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637780371747154944%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C3000&amp;sdata=3DfO8dU9u204YesBNjoI99%2BAkngggcEgkQhet2mnkCRls%3D&am=
p;reserved=3D0">
https://gitlab.freedesktop.org/drm/amd/-/issues/1824</a><br>
&gt; Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciel=
lo@amd.com">mario.limonciello@amd.com</a>&gt;<br>
&gt; ---<br>
&gt; v1-&gt;v2:<br>
&gt;&nbsp; * Only show messages in s2idle cases<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------<b=
r>
&gt;&nbsp; 1 file changed, 10 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; index 4811b0faafd9..1295de6d6c30 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt; -#if IS_ENABLED(CONFIG_AMD_PMC) &amp;&amp; IS_ENABLED(CONFIG_SUSPEND)<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &amp; ACPI_FADT_LOW_=
POWER_S0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pm_suspend_targe=
t_state =3D=3D<br>
&gt; PM_SUSPEND_TO_IDLE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) ||<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_suspend_target_st=
ate !=3D PM_SUSPEND_TO_IDLE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(acpi_gbl_FADT.flags &amp; ACPI_FADT_LO=
W_POWER_S0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;BIOS is not configured for suspend-to-idle, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt; +#if !IS_ENABLED(CONFIG_AMD_PMC)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amd-pmc is not enabled in the=
 kernel, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt;&nbsp; #endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB32382789E82932190C6B1048FB589BYAPR12MB3238namp_--
