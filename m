Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D51CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 12:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4C010E0E7;
	Wed, 18 Oct 2023 12:31:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9827310E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYf5Cw6h+TNa/miPE1EXdWN/x4yStIwcOGflB5tMCdWv2G4yiVGMU4xq/JllEkZvbMoW++0EhP8DBL1ZdC62P2/9Bdt8RZ7wE+l/otaulVJfxL/I9/uOzvG4QwvlHXF5biZ999bP7vvDusO4wv4Wc7J6iU28q1WBurt+f0gziWVdWlf7yBb95VXE3v78zQjTzXyHIY6QXKhHqNb57SzxgFQ2mes1jKWvyJg0k7zP2WuVmYk6BKq3yt1qdL5HBfcpptKEY3qIPPWMeSzE1I2J03ISjHm5oG3BiIoYauuYsjmFXbJjMk3XUU01IENX3vq31BUg7EAHe3gWl0G5kPHqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qprf08Z1UY2NioQO3hBb6IiA7cg5ZUPDKwWN/FRqCLI=;
 b=UfmWzjJQyO2oH7u9bDzSh9pYIVd1adHCD5RoAoLmGaWBTkteeO8fKMkJpzt56bfJZNYM9jskeEuZQ33k1pqQ6E8PsyuVauiSZHTl2VMpq2J4v4DlQ9r4zRYqhKU1O9KbPPrha2KwVwxeU1LOA9tFQT9sYimW2uHhrG77pmmLSHGf75wK2Un1gG1F99y20khmB3Cci2XeRB0zmxThc0T6n6+W956cB7+xNPiOtEwdBe0EiiVFHywsPzsuBqVlOKnumBvqcPB4yow/V3MarSMPp7AH+EqY0bkU5Zpq0tl0m7JutZnf4qOogW/tOlM8GOm7DvqYi2OY7MXhwpDb9oKlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qprf08Z1UY2NioQO3hBb6IiA7cg5ZUPDKwWN/FRqCLI=;
 b=csmV3D65OqUz7dnQKIqSYFAMlJyb8GQR2hZWZbKWVo7WrHaxhga8OTaU9JY0FcoL2VShDf+dWApzOcU8sRQT0GWYDrqgiHoN3DwmLx3CcYBGoNbp7NRU496DnOpiBqiYBqmWxKIntR4C+/2zStglftu9aGRNYxUEKZBlUhrCyQo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 18 Oct
 2023 12:31:18 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:31:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for apu
Thread-Index: AQHaAb2sHAtjIy80x0eGWH2mT8J8jbBPee/g
Date: Wed, 18 Oct 2023 12:31:17 +0000
Message-ID: <PH7PR12MB879651112EECEFF70416DFCFB0D5A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20231018122134.3280090-1-Stanley.Yang@amd.com>
In-Reply-To: <20231018122134.3280090-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ebaf59bd-d474-4007-89da-bada6be1502f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T12:29:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4281:EE_
x-ms-office365-filtering-correlation-id: e7db0985-0531-42ce-0297-08dbcfd6209e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuuJ9egyEkxZjdy50oGq1bhliT3675f49QV7etZD24DTMFd576DStGs/gUlEHVWXRBy09xmVwL42xokluwtk/BOaah4yxTUWWatftu/3tPaOOkmOARkgN7eDLf+9UJoLMPNnvQtYu97O6k4E51KyxbIXZQOIuFahGnX9cw6tLGpJ4jdm0ovJI/6CXBgMsDXfd3kNJkXbR2UinmIdPY3vTlxosNFe/BKKhHQlk7ALqdbCrGR7JrthYE8u66+5H42lfU88tRmwd+UBzjTkxVNkHSDC+sRbCzZT8JJnODsH+OVLfj+KUcvAa9NB3epCevbz9d+nT/kiCpxMF0LaL2qNZQ2qLJ5PaJ1y979BjWXBVGNf1paNuK/zaedACB4vPg31f4KSuKs9c7auZ02pDHgV1yqdU0xQn7+Qcx8Y6BihB1MeswNUA3tq45bw6w9zuuDMyJuGaSIPK/4UzpWPXtTFegSRdhvj4ta3ycWwlmIr2+SM5G785CLnqmq2m5KzbNBhmPQuNdn+Gd66faQNKqTR8Jd/ML857shqRefh+/uUVF3+0rDAmUhNqAYXQq6Qb/9G04fxMZKO1XiWcWIiZszMffGNNYwX8eUnlIhAIkYw9v70Krdi0/7zl5vBXZuqtuT6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(316002)(478600001)(8676002)(8936002)(4326008)(52536014)(5660300002)(71200400001)(64756008)(66476007)(83380400001)(66946007)(76116006)(110136005)(66446008)(66556008)(6506007)(2906002)(9686003)(33656002)(26005)(53546011)(86362001)(122000001)(7696005)(38100700002)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j5FEZn1/rZEZK+UNJBkwSV++YkuwwMuNxHPm//hEz6YYpgD6MxjeQaY+WKA/?=
 =?us-ascii?Q?6qtITMWdbfOntZP9JWgSJgmFXoCkUzEK2VLPKSelrm9Ypkhahx7RKnZBo9yH?=
 =?us-ascii?Q?O2ycr0p6Y+2zaKOhecHrjwpsiE4/UorwosJdqXC5v9HWnSAdAICRlnCqYzFP?=
 =?us-ascii?Q?N1UbPbUDUu0PfarGoOMxvlA78HRF7hKr+fDsxsCR+ypZNzp73wBl4oYAZLqI?=
 =?us-ascii?Q?sQBXyGsC1gcP/oTVgukZEh11PkS6FG8pGc2Ms8jnatJhiuyJcGkvJe6p2J3T?=
 =?us-ascii?Q?J7nbeRTdCr8TG0/spA/pVQkUS7jFf7aAofgdN0KoETexNC9RTD2PVfJXoZVY?=
 =?us-ascii?Q?UTG0Z0Oa0y0eE3reJXhVXOT4EUQ/yGjOExSi995MCNWfUZ9cRwIoggkEvD41?=
 =?us-ascii?Q?i9bF18/uNnlu40xOxqRXWhEt5UXdRfBRFjKVJLna0uLnBVuYnI8PiCjTnuOU?=
 =?us-ascii?Q?GVnhWkphIt3Lah9BBfZQBgyR/GGQuGlQvGRU0bPI8DfwvGSVuo7Gc0nuZpEu?=
 =?us-ascii?Q?tSRFsilUHXR4FjYlj5e4spt4mhIWwscSjsHVgDisFM6iTUjo9vbLhgzrNeXi?=
 =?us-ascii?Q?KDStS0Qb75zgEZyMZksw6oA2Z9pUGynfKW7mn6TIK7907nkDBa+/LR1+iHgN?=
 =?us-ascii?Q?VY2I44t2BYpEk2WawEGfclUVhJkexz5dAIl9ZtVTBUTTIGHqg3OsoJGHF0Po?=
 =?us-ascii?Q?jDT3K83JMxWf4ceO0L4BBI2fmhjhu35xyMz2JpOsHkVZUYwHUS2E0qxG+nmU?=
 =?us-ascii?Q?1Vfzu/4q4Ij+0hl2alwNeq61td0y+CvZK3Cb36yKfWSZJ815y4jWJQgTGSqy?=
 =?us-ascii?Q?FPjTjUrZIiFD6uQMMGiNVdsrZGo3da0KPuatfrStAHWwd8mSJ6JBd7qnNnOR?=
 =?us-ascii?Q?3dAQezeKfAhL2jfEI2xOC+TsJJK19PW4uCCM5qHCaGu4ownYEcioXTPyfynG?=
 =?us-ascii?Q?SxwW2ZZvbQZ8ZUW77lvTXDeUeG2+98EHU8YpHD0G72Egt/1v9npeZNurQ3xH?=
 =?us-ascii?Q?PNVGM8zumY5MHr81bun8R5qdwJqF9qKCc7+Yvtoj9nA8DEpr/8EahgdIUl6O?=
 =?us-ascii?Q?3uqEjUB7jlCxNQMzrB1ilrDikp0FZEx3dhNN3dn0tJx1eUOs7J5wDEYQ+DJ9?=
 =?us-ascii?Q?ABGDfrZB9eO+j/PgZad/8nbxyqI1Eh8Lk6govLfbtL8Eh1xEMCku1C5+a95Z?=
 =?us-ascii?Q?l/AhIepBXahLxvknDjyKXPgGq8OBh6e8nrL4iS3uURGmyXyOcKZSF9OhZBYq?=
 =?us-ascii?Q?7+Qu6btUleT959HfPJmO4AmJaYAMn/VEQ+wk5NN5Skg48LuXLTvae+53ntNI?=
 =?us-ascii?Q?4t6DVAGvEufjhkNxi4OC5UeoKU/fuWPuwnLhhBGsuFcDOUyY0tPgWPMreABB?=
 =?us-ascii?Q?RAkprTPSzjT7aGaPF3Vh8+xZ/xNyu9KZGJ6SdLTd8CyeV18YFwJXr279oVZ8?=
 =?us-ascii?Q?lT5MhzmrHrKaWNNMyci8JStOnv6F+T72fb9tN1V8SbAJNi4Qp1Fmkq/gyFIx?=
 =?us-ascii?Q?bJowJlX9KXFRxwAAKVpMNdTLdnzPoVkcuFRRiCFSfeKo1dzTEbCethwseer/?=
 =?us-ascii?Q?TwSGECrzKto6P4oc0uA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db0985-0531-42ce-0297-08dbcfd6209e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 12:31:17.9979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpsHI3xJyMmc7ItW8UYSD2nKeuWwJGBHkSKku8+T90WWwgivIfK2MHJlb4nrLs/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Wednesday, October 18, 2023 8:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Enable mca debug mode mode for ap=
u
[Tao] the "mode" is duplicated.

>
> Enable smu_v13_0_6 mca debug mode when GFX RAS feature is enabled on APU.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index cab5a5569bc6..62589ba3c4a5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2298,7 +2298,8 @@ static int smu_v13_0_6_post_init(struct smu_context
> *smu)  {
>       struct amdgpu_device *adev =3D smu->adev;
>
> -     if (!amdgpu_sriov_vf(adev) && amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__UMC))
> +     if (!amdgpu_sriov_vf(adev) && (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__UMC) ||
> +             (adev->is_app_apu && amdgpu_ras_is_supported(adev,
> +AMDGPU_RAS_BLOCK__GFX))))
[Tao] Can "adev->is_app_apu" be dropped?

>               return smu_v13_0_6_mca_set_debug_mode(smu, true);
>
>       return 0;
> --
> 2.25.1

