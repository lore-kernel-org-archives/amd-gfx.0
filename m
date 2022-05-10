Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA04C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 22:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D2110EB9E;
	Tue, 10 May 2022 22:07:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A92110EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 22:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTT5iz1Ud2eTpUwTQFi1HyykU4BENbxvVRWokiAnujdwMibq8Ydgmilyyj9NzJgDSQ+C/bHAU6aUM6FG/tM46vjbvZl/Dguye6TplGwoe71LScnrCpaYca8IRKeoImlEVPcJoRkI41Emz2KYlO5cWx55Ic/kaMtTGenxMzvCXL34TzENHIQpKbtgfpsVljfMVwL9xfENBuTkmYSFADpeTqZjgCV5iWTMXymut3ouNciZtdi4rJhbSAgKxFtTgURIsFY/f6acwnc3TROLxsuams0NTfx5lXrbpO4H8pCkgj+sPUGWdA6CbNK2M7tUyAXyjxzbwuR0cCz+9nV2o0Sjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckIAa2JSfFZM7xgdw29zoey9e7Ogew8zwIlmT4pz3C0=;
 b=jG7k051Er+15MSlyuKgZoU2zqP9msWn3q6mjXgb2VmLIZQJmoD9ULeZdFcqUPLN9RBzOL7b85GbOylrko7VuoLmCy+tMxhsJXi8szyaH8QnEmv/AJQ5jCKSLKO6yu7NqNO2gzTTIqDBNirgntHndpU+5gFhXblQuPo3PMrqg6Cyjd9uugfMMSXtr5Qq6kqEdfTqbYg55LHxlTdA74k5RD7TSlKWRYdb60bPU+0ZpO2VnWYqB7ihHN4Gphf/c/awZhWzJh8GpHjdn5hrPT4348gFAMO/EewPE6OQA9nXV3jR9rV6HlqIlUlYElTnPotzXnhF9WE34alw71hzI0ygf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckIAa2JSfFZM7xgdw29zoey9e7Ogew8zwIlmT4pz3C0=;
 b=n0sKmCUUU7Bsf6pzGObD7SiXqKPlk9n4porSOWwR3gyNHt/9pkl9d0AZZ9fsJU0eCBca3ndMuAXT1LhQl6FnlOfVJpcRVCnCTwm2gl4MVYpHB2A+719hYtdZV1VONotWNCTYvKPkjwcbDxIWZzyW8QAnBrbYZog9YdWKi5ueC+Y=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:07:17 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::85f1:3b8f:232e:9536]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::85f1:3b8f:232e:9536%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 22:07:16 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bounds if
 SCLK levels != 2
Thread-Topic: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bounds if
 SCLK levels != 2
Thread-Index: AQHYY1kaf0GHXUde4USzDaxPMpaSMq0V+gEAgAKy0nU=
Date: Tue, 10 May 2022 22:07:16 +0000
Message-ID: <CH0PR12MB538764FE353BF4535C25B817F0C99@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220509035838.17410-1-darren.powell@amd.com>
 <20220509035838.17410-2-darren.powell@amd.com>
 <8125e521-2319-a74f-481c-ac0effd060f0@amd.com>
In-Reply-To: <8125e521-2319-a74f-481c-ac0effd060f0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T22:07:16.263Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: 248c9e3b-8dd7-6627-6831-cdabf8923ca7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f05c2436-133c-4c79-4555-08da32d17201
x-ms-traffictypediagnostic: CY4PR12MB1159:EE_
x-microsoft-antispam-prvs: <CY4PR12MB115963551398E0F901947032F0C99@CY4PR12MB1159.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xb2ed30N8xKrcNiDhRKGqP5Rw720aRcbCuVO+Z2cwQYNQXL5tN/vjy3AJNgOo+hpzXbGSPQ25zDYGmJDEe7290363SzpqZHbaiT8JKbeGMY05VqCqXnDIwDykv6NQXXQnLDC4tiC1mvVG70SU/KBEvgVCRi9DdiEz7kWl0nsaG6Bhwf6Q5yeAbwLIUk1hDtHNZWSllmpO56cAlUffFkWByRM0D9aF/e75gMlceKgUeMC1VzQGSqM0x/ckonmaXQIIxwVtEIx+p/YsIVWKSHoY0KCwn5j5Ier3aqcUzkxQzptc/rCVBV4W9bL9XB6MMuXkmF0mk6tOnQFoqZVbIAH8KLEpxAJDtg0DPbJ4v9uv8+ThB+uqKOpHNVW8pRY3pV2svVDOmRg0zH4Hn2v9onabpkdBygKn8vmtd7BtnnYg1htFhY4rZV4qgxlDkASbs/YJVS3IKSEALvzHhtuLfWrKG9RqYrpn5My2r23YyJSzuIbZQFIrN4/z0v7fZyXjAoKPwEmiT4C2v1tbkWpaIXT5KbvDmz5DID+gNX+wnCQgGvVSvSFstd9cltWSQ5hwquTZIBJ8KCzWLFY745qqu6gk8jUfWhTCq49csWodQlwmct4Z9d6l/vAHru9M1Y9TG6VnpgxGCwuv7kJQthgWvZEnGlyfxO6jU95KsWZjR1C8zaRklVQZegqScpY8K7AFWOIsMtQKgSa7B/G5lJprWDoaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(110136005)(5660300002)(71200400001)(26005)(9686003)(508600001)(52536014)(55016003)(316002)(54906003)(2906002)(8936002)(122000001)(186003)(33656002)(4326008)(19627405001)(7696005)(64756008)(66446008)(76116006)(66556008)(66946007)(91956017)(8676002)(6506007)(38070700005)(53546011)(83380400001)(66476007)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wtUhGXQMr9kZHV4H7v2OUS+rTXyrPOrBNFQdl5ghc0uLJj1/yiWkHjziCI?=
 =?iso-8859-1?Q?sEYV/jshyeVhFNkxcKtSVH5EDdVC7MnG1fKTk1mFt50dgtD6mGdqzRlNbE?=
 =?iso-8859-1?Q?cGjiCqjJFcyNe7Qjlb2/ewSt8OkWaJbFaOmRm464eCoBDYBESkqarw/omr?=
 =?iso-8859-1?Q?JJPDKPSFX7aANwQRFw6zwoRsUFNHiovW3AywvSuznT61T7Ft0e3nJpGSzF?=
 =?iso-8859-1?Q?Ap8+d/5wM64c6DicgZObLOAOTnz2ZrljCGTSs2tiKEwXDkCvUFUh+4zYUW?=
 =?iso-8859-1?Q?XLOwDRHJQBJSsmfZqZptFKAGTRXS3EsHlO+Nbtv41cNu8lMBqhGgvSHoWa?=
 =?iso-8859-1?Q?1gzIfHamoP3X75YO3EAtXLbKK5G1hi4o4mMBQeazt2aM73LcpkxOzPveE9?=
 =?iso-8859-1?Q?nE6oNjJnbFRFmTMpDgC1kMBXPbpVG3KjvqFhd+tRCHG+MVUtH6kSEa/iCZ?=
 =?iso-8859-1?Q?kaOzbQo/wFnsthArRn3Iyu50zgdpZ8i32qknWnmxngEK3m7SGRYqvHCLYW?=
 =?iso-8859-1?Q?MpkxJIFj8MMtrJBPqQj0fiuWvrwwTZualyWp888HP8GFotIXsDjuNpAXSN?=
 =?iso-8859-1?Q?YrZkxcuKLbfsihzC4OznRTX8p8p8QgGJKdoQkpHjR4BNMFWmHZylNIjFE+?=
 =?iso-8859-1?Q?pbg1aeeaDN5obltM5xmLjWlgTaTqdfYGH7QaDMPokw44zWoDjlAA2LrtYE?=
 =?iso-8859-1?Q?PULtANjjeZfORQU3ViXW+qrb4aj3XLZsHyNHRFU5Z1RXNwAixkwQKuU6Rm?=
 =?iso-8859-1?Q?w6Spy24pSh6htB6lRPc8gbwDC8unH+urbACdE+tTaZ0DNFRVC7/Zlwhcn/?=
 =?iso-8859-1?Q?YiHZ2bEDim3FnlwCDg2Yt9UaEVsRmY8LDPHCFcPUgjDFk5Tue4aK8Ly+zH?=
 =?iso-8859-1?Q?uOWMw9k0Va3+//Qs5RIXtUKk2nxXb1fPDz7uVX/nX1FA3dr5N7l5AkG9+8?=
 =?iso-8859-1?Q?KKXzVw0q9XHVhRC45vJipya0kbw8Lz25NAiHZGJBLs3NHqfOBtF5Xi3sMZ?=
 =?iso-8859-1?Q?81x2rYzZXuTKF5oDuepy2itLyzH7b+o86tPjlOTJlvjxTWstpVON0kAqa2?=
 =?iso-8859-1?Q?dfzAX8Lc+lRvc1CN2GKoJd6QO8WnyXNeBX+YaEyYNw5AHue5mI3KP8dZhD?=
 =?iso-8859-1?Q?cfIgds6u/xCxVb1w9dSLRiS2bdIrg+tOySly817RpifsNSmMegqS9JslhL?=
 =?iso-8859-1?Q?tVRQETwIUD3aV8qUdAL5mTU76iU+VB4V61J4bQyciOZGeeQTXeEbWw0umv?=
 =?iso-8859-1?Q?BsXyKwGR3siqFiRDA/w00xULTABcGEF9G81Pixj1mMHuNeKR0riycLFJnZ?=
 =?iso-8859-1?Q?HPiT7kkFvLBw+1h00mJvAgbNWxRRjIRI/x2EorQYJPTQgQqLN2FOFGl7hc?=
 =?iso-8859-1?Q?ANY83OYgsloiup7B5KqMqMui6yzw4xhv3XwqQzqHTpx0GM3lwkYSZogZDB?=
 =?iso-8859-1?Q?rsvoUHjuR1spKhtWcND7t/38uXbmS+Q2Mass578NZgu67iqs5urVGbThtd?=
 =?iso-8859-1?Q?S44vu1x+cfz+WuwLj2xO5ppmq26E3YHfLLdu3r7rqkrx9taqDND9aPwM5D?=
 =?iso-8859-1?Q?JxLM6UiekP56CH0/EA5suoZuYHWb0c10kTv0suve0xZB4wn6cvbp3CZC2K?=
 =?iso-8859-1?Q?fwAR+z4QY4ZJvdJuNaBAygVO9HQfJewApsHBj9JzPTZiErV+7S2PQxKmT3?=
 =?iso-8859-1?Q?/amUhH/U9yDb3entRU0KSB7SuE5KYNqf95kJOoO99rjrlNVd4/AfZ8Z9Q6?=
 =?iso-8859-1?Q?LSDSy/HLCcR1tFEA892mRnLwSh0kNrIftT0DIzjeqwCRpL?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB538764FE353BF4535C25B817F0C99CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05c2436-133c-4c79-4555-08da32d17201
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 22:07:16.8401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFioZWGN39Hj0AKKPJEWNu7656F/oJWqugdZpGzC4lRfKfDRRTv78ZaUTeGYdjcCjvJWQ+feHytlOblzYlMUsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB538764FE353BF4535C25B817F0C99CH0PR12MB5387namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, May 9, 2022 12:50 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: Re: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bounds if =
SCLK levels !=3D 2



On 5/9/2022 9:28 AM, Darren Powell wrote:
>   added a check to populate and use SCLK shim table freq_values only
>     if using dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL or
>                           AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM
>   removed clocks.num_levels from calculation of shim table size
>   removed unsafe accesses to shim table freq_values
>     output gfx_table values if using other dpm levels
>   added check for freq_match when using freq_values for when now =3D=3D m=
in_clk
>
> =3D=3D Test =3D=3D
> LOGFILE=3Daldebaran-sclk.test.log
> AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{p=
rint $9}'`
> HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES=3D"pp_od_clk_voltage
> pp_dpm_sclk"
>
> for f in $FILES
> do
>    echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 60 +++++++++----------
>   1 file changed, 29 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6a4fca47ae53..a653668e8402 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -740,9 +740,8 @@ static int aldebaran_print_clk_levels(struct smu_cont=
ext *smu,
>        struct smu_13_0_dpm_table *single_dpm_table;
>        struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>        struct smu_13_0_dpm_context *dpm_context =3D NULL;
> -     uint32_t display_levels;
>        uint32_t freq_values[3] =3D {0};
> -     uint32_t min_clk, max_clk;
> +     uint32_t min_clk, max_clk, display_levels =3D 0;
>
>        smu_cmn_get_sysfs_buf(&buf, &size);
>
> @@ -765,46 +764,45 @@ static int aldebaran_print_clk_levels(struct smu_co=
ntext *smu,
>                        return ret;
>                }
>
> -             single_dpm_table =3D &(dpm_context->dpm_tables.gfx_table);
> -             ret =3D aldebaran_get_clk_table(smu, &clocks, single_dpm_ta=
ble);
> -             if (ret) {
> -                     dev_err(smu->adev->dev, "Attempt to get gfx clk lev=
els Failed!");
> -                     return ret;
> -             }
> -
> -             display_levels =3D clocks.num_levels;
> -
> -             min_clk =3D pstate_table->gfxclk_pstate.curr.min;
> -             max_clk =3D pstate_table->gfxclk_pstate.curr.max;
> -
> -             freq_values[0] =3D min_clk;
> -             freq_values[1] =3D max_clk;
> -
> -             /* fine-grained dpm has only 2 levels */
> -             if (now > min_clk && now < max_clk) {
> -                     display_levels =3D clocks.num_levels + 1;
> -                     freq_values[2] =3D max_clk;
> -                     freq_values[1] =3D now;
> -             }
> +             if ((smu_dpm->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> +                  smu_dpm->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETE=
RMINISM)) {
> +                     single_dpm_table =3D &(dpm_context->dpm_tables.gfx_=
table);
> +                     ret =3D aldebaran_get_clk_table(smu, &clocks, singl=
e_dpm_table);
> +                     if (ret) {
> +                             dev_err(smu->adev->dev, "Attempt to get gfx=
 clk levels Failed!");
> +                             return ret;
> +                     }

There are only two levels for GFX clock in aldebaran - min and max.
Regardless of the mode, gfxclk_pstate.curr.min/max should reflect the
current min/max level.

Could you explain the issue you are seeing? It's not so clear from the
commit message.

Thanks,
Lijo
[DP] I was concerned by the initialization of display_levels from clocks.nu=
m_levels and how it is used as the loop iterator
while accessing the freq_values array. My mistake was that I assumed that m=
eant you intended to access clocks.data array.
If aldebaran only uses the curr.min and curr.max values that simplifies thi=
s greatly,
I'll respin this to initialize display_levels to 2 , and then output from f=
req_values array.

>
> -             /*
> -              * For DPM disabled case, there will be only one clock leve=
l.
> -              * And it's safe to assume that is always the current clock=
.
> -              */
> -             if (display_levels =3D=3D clocks.num_levels) {
>                        for (i =3D 0; i < clocks.num_levels; i++)
>                                size +=3D sysfs_emit_at(buf, size, "%d: %u=
Mhz %s\n", i,
> -                                     freq_values[i],
> +                                     clocks.data[i].clocks_in_khz / 1000=
,
>                                        (clocks.num_levels =3D=3D 1) ?
>                                                "*" :
>                                                (aldebaran_freqs_in_same_l=
evel(
> -                                                      freq_values[i], no=
w) ?
> +                                                      clocks.data[i].clo=
cks_in_khz / 1000, now) ?
>                                                         "*" :
>                                                         ""));
>                } else {
> +                     /* fine-grained dpm has only 2 levels */
> +                     display_levels =3D 2;
> +
> +                     min_clk =3D pstate_table->gfxclk_pstate.curr.min;
> +                     max_clk =3D pstate_table->gfxclk_pstate.curr.max;
> +
> +                     freq_values[0] =3D min_clk;
> +                     freq_values[1] =3D max_clk;
> +
> +                     if (now > min_clk && now < max_clk) {
> +                             display_levels++;
> +                             freq_values[2] =3D max_clk;
> +                             freq_values[1] =3D now;
> +                     }
> +
>                        for (i =3D 0; i < display_levels; i++)
>                                size +=3D sysfs_emit_at(buf, size, "%d: %u=
Mhz %s\n", i,
> -                                             freq_values[i], i =3D=3D 1 =
? "*" : "");
> +                                             freq_values[i],
> +                                             aldebaran_freqs_in_same_lev=
el(freq_values[i], now) ?
> +                                                     "*" : "");
>                }
>
>                break;
>

--_000_CH0PR12MB538764FE353BF4535C25B817F0C99CH0PR12MB5387namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, May 9, 2022 12:50 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Feng, Kenneth =
&lt;Kenneth.Feng@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Ma, Le =
&lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bou=
nds if SCLK levels !=3D 2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof"><br>
<br>
On 5/9/2022 9:28 AM, Darren Powell wrote:<br>
&gt;&nbsp;&nbsp; added a check to populate and use SCLK shim table freq_val=
ues only<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if using dpm_level =3D=3D AMD_DPM_FORCED_LEVEL=
_MANUAL or<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM<br>
&gt;&nbsp;&nbsp; removed clocks.num_levels from calculation of shim table s=
ize<br>
&gt;&nbsp;&nbsp; removed unsafe accesses to shim table freq_values<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; output gfx_table values if using other dpm lev=
els<br>
&gt;&nbsp;&nbsp; added check for freq_match when using freq_values for when=
 now =3D=3D min_clk<br>
&gt; <br>
&gt; =3D=3D Test =3D=3D<br>
&gt; LOGFILE=3Daldebaran-sclk.test.log<br>
&gt; AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d =
&quot; &quot; -f 1`<br>
&gt; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk =
'{print $9}'`<br>
&gt; HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
&gt; <br>
&gt; lspci -nn | grep &quot;VGA\|Display&quot;&nbsp; &gt; $LOGFILE<br>
&gt; FILES=3D&quot;pp_od_clk_voltage<br>
&gt; pp_dpm_sclk&quot;<br>
&gt; <br>
&gt; for f in $FILES<br>
&gt; do<br>
&gt;&nbsp;&nbsp;&nbsp; echo =3D=3D=3D $f =3D=3D=3D &gt;&gt; $LOGFILE<br>
&gt;&nbsp;&nbsp;&nbsp; cat $HWMON_DIR/device/$f &gt;&gt; $LOGFILE<br>
&gt; done<br>
&gt; cat $LOGFILE<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbs=
p; | 60 +++++++++----------<br>
&gt;&nbsp;&nbsp; 1 file changed, 29 insertions(+), 31 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 6a4fca47ae53..a653668e8402 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -740,9 +740,8 @@ static int aldebaran_print_clk_levels(struct smu_c=
ontext *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_table *s=
ingle_dpm_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_=
dpm =3D &amp;smu-&gt;smu_dpm;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_context =
*dpm_context =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t display_levels;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t freq_values[3] =3D =
{0};<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk, max_clk;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_clk, max_clk, display_levels =
=3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_get_sysfs_buf(&amp;b=
uf, &amp;size);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -765,46 +764,45 @@ static int aldebaran_print_clk_levels(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; single_dpm_table =3D &amp;(dpm_context-&gt;dpm_tables.gfx_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D aldebaran_get_clk_table(smu, &amp;clocks, single_dpm_table);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Attempt to get gfx clk levels Failed!&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; display_levels =3D clocks.num_levels;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; min_clk =3D pstate_table-&gt;gfxclk_pstate.curr.min;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max_clk =3D pstate_table-&gt;gfxclk_pstate.curr.max;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; freq_values[0] =3D min_clk;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; freq_values[1] =3D max_clk;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* fine-grained dpm has only 2 levels */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (now &gt; min_clk &amp;&amp; now &lt; max_clk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_levels =3D cloc=
ks.num_levels + 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[2] =3D max_=
clk;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D now;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((smu_dpm-&gt;dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &amp;&amp;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_dpm-&gt;dpm_level !=3D AMD_DPM_FORCED=
_LEVEL_PERF_DETERMINISM)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_dpm_table =3D &a=
mp;(dpm_context-&gt;dpm_tables.gfx_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_get_c=
lk_table(smu, &amp;clocks, single_dpm_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Attempt to get=
 gfx clk levels Failed!&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
There are only two levels for GFX clock in aldebaran - min and max. <br>
Regardless of the mode, gfxclk_pstate.curr.min/max should reflect the <br>
current min/max level.<br>
<br>
Could you explain the issue you are seeing? It's not so clear from the <br>
commit message.<br>
<br>
Thanks,<br>
Lijo<br>
[DP]&nbsp;I was concerned by the initialization of display_levels from cloc=
ks.num_levels and how it is used as the loop iterator
<div>while accessing the freq_values array. My mistake was that I assumed t=
hat meant you intended to access clocks.data array.</div>
<div>If aldebaran only uses the curr.min and curr.max values that simplifie=
s this greatly,&nbsp;</div>
<div>I'll respin this to initialize display_levels to 2 , and then output f=
rom freq_values array.</div>
<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * For DPM disabled case, there will be only one clock level.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * And it's safe to assume that is always the current clock.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (display_levels =3D=3D clocks.num_levels) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; clocks.num_levels; i++)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size,=
 &quot;%d: %uMhz %s\n&quot;, i,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fr=
eq_values[i],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cl=
ocks.data[i].clocks_in_khz / 1000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (clocks.num_levels =3D=3D 1) ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;*&quot;=
 :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (aldebaran_fr=
eqs_in_same_level(<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq_values[i], now) ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; clocks.data[i].clocks_in_khz / 1000, now) ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;*&quot; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fine-grained dpm has=
 only 2 levels */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_levels =3D 2;<b=
r>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D pstate_tabl=
e-&gt;gfxclk_pstate.curr.min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D pstate_tabl=
e-&gt;gfxclk_pstate.curr.max;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[0] =3D min_=
clk;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D max_=
clk;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (now &gt; min_clk &a=
mp;&amp; now &lt; max_clk) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; display_levels++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq_values[2] =3D max_clk;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D now;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; display_levels; i++)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size,=
 &quot;%d: %uMhz %s\n&quot;, i,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[i], i =3D=3D 1 ? =
&quot;*&quot; : &quot;&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[i],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aldebaran_freqs_in_same_level=
(freq_values[i], now) ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &quot;*&quot; : &quot;&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB538764FE353BF4535C25B817F0C99CH0PR12MB5387namp_--
