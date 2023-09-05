Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AF3CA1001
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 20:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738EB10E111;
	Tue,  5 Sep 2023 20:07:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5671E10E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 20:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBVErAHbDTwQMtBmNRd/x9vInSigNESeSI3+GIjlvIoW7KKMPbBqJqf785ECw6sINCLCN2o2PySVUb7Su23y5xTREqDTQcPeNWeTdvx5fu9TEtRPj0VSQZtdp/3l0op2aUNoORTVfIEQqGRRIfEmSWxZAvDe8Bh0XxKkMVOIGTrdNA1U22/aOl1McS/TA+CoFbIM84Bu+YGPLSOq77D6G04FencAvVbfHwFEIlp5nYi2AQ4TRlCCjHDO8GpbZmn9PsWi1IM5K98mXXN5v3lrQ5EHQVXplcgQ4Fq02Dwwb30fQJ9CFR8SjqJeSDhbHd8vEwNZiEqvvXnUsul0N9X8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTU1NzlQqRfsf1aesDnw+7GuGYhYyneSY0cSNwfuISg=;
 b=MNdfR/lmgUGOvP8K8WmkZYwl6PiVBkmE4anaqR22jHhp88JRY4wXCibxbB9JkyBwnP12IYtb5m0TYM8HiJYJyp7mUbBsd6D/QEYHN+dS0nDhJ/EbG2vqSD6bU7wbKVodyRc3YKVUeRv8TD6t896uuW9STfw9Lh/jmCE+CFQv8k2J3G+ep7Ms4X6gtaBi6cCtulhXyyVDw1wLH178roOEHNe7xt7ebVakJxAvCRKEAnnEoFRlUf5Y20m26I/3Qo8/BxmJIOjhHqeBIzVf5pm1beJN3gQ0s7b9X8wVUAvenonZrwFxBihe8/0daMNQOCYDqZLBCQLOLcDYYuianR8tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTU1NzlQqRfsf1aesDnw+7GuGYhYyneSY0cSNwfuISg=;
 b=06FLE+V15ICqTpvQEN10v3NTCZKrtaztGX+2auybibVwNVXtSZKdmAaBlXye/AA8Jt3yczLRbJjr1Kkv6QSHoK7FWOlx1fGtS/5CXIpD7x/SIyq9iRtxC9/vc2Iq1twUih/34jEZqXskwFcTgWhWfNJUNDo1hfSVU2R6ylCMOZE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 20:07:08 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6208:cab6:bc19:7aa3%2]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 20:07:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer APUs
Thread-Topic: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer
 APUs
Thread-Index: AQHZ4DBS3oM0NO/Knkeh/3RPs1MEPLAMp0wA
Date: Tue, 5 Sep 2023 20:07:08 +0000
Message-ID: <BL1PR12MB51442B9145F7143B49458E78F7E8A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
 <20230905192600.32449-5-mario.limonciello@amd.com>
In-Reply-To: <20230905192600.32449-5-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=19983611-40f8-4daf-9e9e-f5deba441620;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-05T20:02:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB8436:EE_
x-ms-office365-filtering-correlation-id: 893d544a-17e9-4211-fedf-08dbae4baec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VF2ctestnErZJh2DiBhKPBib6ZOD2vBSB6YPx9tNaDaoCP3gBIN3haj9vd9zhbQoEH2BC92hhDWW/Yf7ZyDOV1liIHGGE6aDnMCofH598E+7vsyEd+TPKAqcvb1/UP695zX3lzENFFkW5ieXIlIwFNJCmDesJr9JQQESoPD825l2ViepDBeJJUbRxDFbXj0XxGlJux2grEnmbTUVnDp68Dpzo6KxDmiFDWbJKtkukYWPTsRfTesKc4lGQ3PeeaxPz9nF82Z9GLRuxziZWUkP3SsjBEktdwkQFgXsSq19mkYuEchF2uEV3YvjVNH5FecNyaPmA9MTj/Cf36xpXPbsjR/u3SbENVjDSa3T3MCRKRONRTi9h57DSGloTI4kw0Q25EgWTT6d26RzTOVTv/TmoeIWn3pfoyYQfTRXa36QZ9xlSC0HdWRRGlD/qBn/VSlLySuc6O52KdrTrg4ADgF97obQUNC9CaWuRyzzEXPu6AoPsB2F+6xWzmAqcsBtZbbfHBIdF9REGt+vMOfZR8FQKn0u83eOW4mlau7dxE5pE7i715++oX4/siSpAIYV543mj0d0Dg2kBLDYoNe6zH/wOvB2UlrAjKLvv8oe/CcyjWw0Tq4Mpoh89g+ROdVv/+BN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(1800799009)(451199024)(186009)(8936002)(5660300002)(316002)(110136005)(66476007)(66446008)(64756008)(2906002)(66556008)(66946007)(76116006)(4326008)(8676002)(52536014)(41300700001)(53546011)(55016003)(6506007)(7696005)(26005)(9686003)(71200400001)(122000001)(38070700005)(478600001)(83380400001)(33656002)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lUsiF9zHzypbg6yfpd099lxVLAB4QDtfi4Fr20AxJQvXdjADz1MvapMHZe1D?=
 =?us-ascii?Q?GwVkCQTysVGAkeKcpVbr0HTq7KZBaWpxr34YDoWmenVeFGdr3BfadLEuNlLp?=
 =?us-ascii?Q?k72PuacPwBd5TY6IyBjGm28OtvMQGdy/su6MtICALICwIFB7zOAaCxPXeAUl?=
 =?us-ascii?Q?LQUC2GV/f0NrzgNYCrfiyaH6F19BtfSsOnCjq8+yCzuc197snoO+C3Cbo/8g?=
 =?us-ascii?Q?ul3imdGnENDv6A17EiqnAezm1kEY4FN6NcAiLTZbnXJwJVuzC0NftAp2fng7?=
 =?us-ascii?Q?3cGzETNY5dgKmZn9VHcKdLdsBNxZ2Nu2DpZt49SRET+VTZc9wikWjewU+nB6?=
 =?us-ascii?Q?Bmw/Jdlb5940kO9f3896NUbNPvAX1MYrsU2QVdyE14MsKZzgN4+cxo9GqvnH?=
 =?us-ascii?Q?OuQrlSZFN4VvBPahDWfnNMcB/4us3RyOZn2wkineSRFDKYrp2bRHJu2V9lmE?=
 =?us-ascii?Q?k3Rf184LPCIkND20TgrahrBLXMnCGv78rUyk9nWWJMwZMpHMMSyGC2TYRPgb?=
 =?us-ascii?Q?uJyx1X39276ojKInVLK18vOCj9e7je5BssSFbbsGZ5jq5ZSjN5Hp4YB68CQS?=
 =?us-ascii?Q?HReu/66gWAkFT0f+9DoPvHfD1rRzAGWyvbOV8mPYuJPVW5XW5IVJaY64B8ZU?=
 =?us-ascii?Q?6oC2PwOjI8mX/gQl9rp5evJ/0TgIXxLdmmljQRC9Ky5oebxEAhjSQASpLR8I?=
 =?us-ascii?Q?n9x+KkQ+qeYN4WUs1Mn1VYREPlh+UKBc5LoLXoFkfS1/TtXW0IFh/T/B8zrq?=
 =?us-ascii?Q?oWCn+OGdN+L6F+BhfgQFCqEdyIX7FylF15Lqq956mX0SyhZGyjkZ1y5ch2Sj?=
 =?us-ascii?Q?gSXK/UQmNeSUCIJdIWwy7hABMaNL8SDcpde1CZOMs6HvW1dTsmiF4gUIv7eG?=
 =?us-ascii?Q?bJTNnIB+koUR1+gLazeewRlwGdhcQFlowZPC+cbwzqCJE2PKf/hUsa40wl8q?=
 =?us-ascii?Q?X0SvCQkSRzlDDmB4mDew+yGt/EWJ8pupr+TIpNR4gdJMvQIbOvkLijLoUxkp?=
 =?us-ascii?Q?9VNKTdZwwJ7jdqAfNCi4g2tiAdLSYOt6lonFHiynuzKpjO31UPmdi+m1Iurw?=
 =?us-ascii?Q?zoRmB/ELDARwP8iosiRK1J0u6RhdVhMQS03tJsUCqNiOc84hB/P0Lu4uX7yM?=
 =?us-ascii?Q?HYbe9lEGX8GUBiwekdmJHHCffb+1tbaasDMwpFSo5ej/IowpcY6g7Ki4WnzG?=
 =?us-ascii?Q?3otRloflUTsQv0ls0+nc1jLXsW4U5olUx95AWh+80jtG2ucIPJ1EpSXfXDIy?=
 =?us-ascii?Q?bUftgqbDe7kB/I3hMYipvS44/Wd3h6IGIAhaIgrBE507y64urxEyovkLUy4K?=
 =?us-ascii?Q?5nCoafl5+gop9F023GGuxQTtR2zj4oZ2Fus0y9gFA+tq+bXvRKFwNQ90q+4F?=
 =?us-ascii?Q?FbEx+jA6jPWddKfExoeO+0Eif07+8m4BgDWrvTHzatJDnWOqR9f6aQMCl1wV?=
 =?us-ascii?Q?lODZRfr6kuTCQqsdMjUcJM5Wg52x6j6oyVjRQbBtFYKZjlTPWYCdFqTmThGS?=
 =?us-ascii?Q?U6Pc+lUuwgfVcjabvgJ6Z/0xJeytrQBnzRu9xw6STjIvPemUviEGrY6SKkBc?=
 =?us-ascii?Q?4S5M59G5nr79EImWuDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893d544a-17e9-4211-fedf-08dbae4baec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 20:07:08.0508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lg4fewfQivzGX7NkC/icRxCM/0/d2df/QzqT7+yWg+kqJTIgfdh1Mbd69xmklb1RFWorWxBJC3jqEZnSJY3WOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Tuesday, September 5, 2023 3:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer
> APUs
>
> IP discovery is a good line in the sand to expand seamless boot to more A=
SICs.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9159a7b993ab..19265dbe592e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1296,14 +1296,10 @@ bool amdgpu_seamless_boot_supported(struct
> amdgpu_device *adev)
>       if (adev->mman.keep_stolen_vga_memory)
>               return false;

This probably needs to be revisited too.  I don't know why this is an issue=
.  This flag just means the kernel driver keeps the stolen VGA region as re=
served rather than releasing it back into the pool of available memory.  I =
don't think it should directly affect this feature.

>
> -     switch (adev->ip_versions[DCE_HWIP][0]) {
> -     case IP_VERSION(3, 0, 1):
> -             return true;
> -     default:
> -             break;
> -     }
> +     if (adev->asic_type !=3D CHIP_IP_DISCOVERY)
> +             return false;

Probably need input from the display team, but I think a number of the olde=
r chips we'd probably want this too.  Maybe base it on the DCE_HWIP version=
?  DCN 1.0.0 or newer?  Or maybe  DCN 3.0.0 or newer?

>
> -     return false;
> +     return adev->flags & AMD_IS_APU;
>  }
>
>  /*
> --
> 2.34.1

