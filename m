Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1CCC4708F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 02:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B7561027
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 02:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B7561027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFC26EF2E;
	Thu,  3 Jun 2021 02:47:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFF26EF2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 02:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=honjTWgsqgWue6hUELKzRuapjTgu8PXsQA8bRVFx2mPfLfsLKSHFeOR+GtrGFmIEL7EcRbi/J6ldiNgeHHjArcmIFCqt9fr3lRtzssdiEAcwxPNvhbs5GRmrG6xXn6XpCxIiFMYRO5cx3e5Susi9C4Y73637Dp3+i4D5B7gma17XLChp/DIem5CJ/jxSfdXB/p/jIK08ht61gpX0i0mPD9D7PG+Bjmsn1RyktA/VQ9Oxon6A3ROyL0vaMNnz3tKvmLpdOX4aDW4RBq8fbFd2TXufEjqmTn89k1KPA0uz3GPgsIJ89K/Q29D+QMbDHD0mCgfXIs4TxQ6Phej55UZLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uWLPtgQsoXw/35o0J7Lt2vm8RwGrCihM4zWodFbV7Q=;
 b=fEKQAJPJrzuvruBKfzXZDE0EVsaw4PvbH8B5TMtqqvpi/isGXI09FvjKyT5Z+TELPodUAzKvnOoHWXBk/hNEh7hTnuLePaxDNNjNzF8+DVvBQ8mEC9UbG7ijwc70ndBt+B8PnZ+OKqHHWU3tzx9OLr7ahoe+O9rdV4m7KH5O6/7o6hvkOHHGiP4YvOEWfiqfAqhNFQa+fuN+pI4xZX9q563cB80+tsTUIAbeRC/FJf144czjRnJE/KP6npRrzEMw/rFc05uXEdeVpQS9R0dCXZQCMIqvZrek82HLRSO4KteQf4ueyinDwo3b7U6+UXHiaNoxLkFkQslBpmv92ebD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uWLPtgQsoXw/35o0J7Lt2vm8RwGrCihM4zWodFbV7Q=;
 b=0ZbaBa4FBsrTEL5N+W1EJZed0EASbwd+I5f04+0pFbO/++Y1gZbvQdXkzjIJifw4vEL0eRtDYvBMu4QdiRQj8v8N/Kvr0REi+p7ptk81iDvk8A2Dr2iAQDXaAf2UIJKUePQVwL8u6/CWaIzRQqLBJ+Zocg79BLqhhKo7i2ISLHE=
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 02:47:40 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 02:47:40 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Topic: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Index: AQHXVBYeoepHF8dB0UqdYhF2bLZulqr9HXOAgAEghkWAAF7DgIABevFygAAQngCAAXRQLA==
Date: Thu, 3 Jun 2021 02:47:40 +0000
Message-ID: <DM6PR12MB29540334678B98C0A7B10C32F03C9@DM6PR12MB2954.namprd12.prod.outlook.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
 <20210528230621.16468-3-darren.powell@amd.com>,
 <CH0PR12MB5348CD424C6F4A5E0A064598973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <DM6PR12MB2954B3E943CD476445C945E9F03F9@DM6PR12MB2954.namprd12.prod.outlook.com>,
 <CH0PR12MB5348DB50C9C32FB21586F41C973E9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <DM6PR12MB2954060EE8BA02E3E048FECEF03D9@DM6PR12MB2954.namprd12.prod.outlook.com>,
 <CH0PR12MB5348672703366A7EDE22BE8B973D9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348672703366A7EDE22BE8B973D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-03T02:47:39.771Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [142.126.184.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e189dacb-749e-47fc-d841-08d92639f45e
x-ms-traffictypediagnostic: DM6PR12MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35476B986E3BC2B694FC14C4F03C9@DM6PR12MB3547.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFXGz3C89FHVheXrz65zGS6u5uXsRguR8wJZYlkIIkPzoeYzvAjaSF8N9/v4ymyaPT2TWIDKfqUlSgCcggkU7qjWvg4UMAs13m+mPEsa+lan5nBxeD2f1bkkErj5sPvkdcx8Wj8uhOL+ft1rEQghflprLNoKzkHXMti6Z3nnGXyEypBEf0gXgxtLXlelU3ISbmGSu9eVUyBkeuoK+D5QECK0J9D2x9gTeeVq4mKvP0fzueRUJhboKc4jtZo26UzNEC+CfqMV7UcpcOmBqNM7cyp4u5gSw2mk9RQNYKISFyu/1clANcjl3Czb6W92buJTMQxNCTDWPMAr2zIVdv3/azb+kUJIcygq0p/h+gMyK+XAxVXDTG4bO/DK1wIkxzJTBSkXVR3UbYfITIKE9BcyGDYvhsgS9615A8dO7wzRXS0KWFSzX8o+uvDOYJ51z9qNNcniN51QAbDg2cTaWArxK1kzVNdibIpD4bz4mF4A+e8vkX7hP08U0Ttza3OkfrzHSDXl+mGF92VTonAMQM5kFgVz+9gSHLjdgmdIMvTFA/PmbqZ3JPXjNN4llX7IAWZ/rCEs14YF4hJoEgxHlNfuPQx7f6X1NBFRe29Af0C/I0I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(5660300002)(19627405001)(91956017)(76116006)(86362001)(52536014)(4326008)(19627235002)(66476007)(66556008)(66946007)(33656002)(66446008)(64756008)(110136005)(122000001)(8936002)(38100700002)(83380400001)(9686003)(55016002)(8676002)(478600001)(26005)(186003)(6506007)(2906002)(316002)(71200400001)(7696005)(53546011)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?OlIdG7foeRg3+SrOgblggQ8VAthaQBmOS6q8ROgVwIWmSO1byRjaekzu?=
 =?Windows-1252?Q?iuzRqSp3XDMXSttb689H3Ac2FPL2BKb3SFPX4gVsoK3pDz/iKv87Y+a+?=
 =?Windows-1252?Q?2i3IyuSq0qPmKdnacaPU2D9pEnwBLY4DmTUSXoZ9u8LMMSfNL+r8Q+b6?=
 =?Windows-1252?Q?T6dI1q/y4XxMQOMPnEaedX7ULfhONhW3A2lYRtW62mJ8I1QMIM4rjmu4?=
 =?Windows-1252?Q?vRBHypT7fDpab/7IxekSLi+YhO3RAc3q+iLUR+SLp1EaeHiN14T1t6x1?=
 =?Windows-1252?Q?qgquwS3r2WWtDhJc6tAv65iNG/l3RTl8sw995zFpynbFsIUZq1ioslJj?=
 =?Windows-1252?Q?1EJ3t3rWuLHKpejpCYBKxmnngIFQx511QP6/Lmp+Hod0J2SjtOmxbYEt?=
 =?Windows-1252?Q?jT3Wf54GrAt4XpvAmLvcy1ywx1/zM/388bLDEZUqcF2tQwajALWNpdin?=
 =?Windows-1252?Q?0YMDF7R522lzO4sz1vSi23EfvETZrPEb+zRWwBwcW10m17MM5urbHnv0?=
 =?Windows-1252?Q?v1TnGDo3+JdkURL4IkDZYyXFL1KZss7g7Y8b0ZoGLEvJKN0OaGeP+s3o?=
 =?Windows-1252?Q?gAFz4KhnE4lwGl7qFBE5upFW3EWH45+WV13G8R68zN0rcmblbD2wUs4n?=
 =?Windows-1252?Q?GDWJ0G/SqO9QTJEf0O4KfUfd49hDwdsb2n2tM+naM7Kcy4STjxmAzvmF?=
 =?Windows-1252?Q?EQWqRaPmIBC4mdFSaz3HLZy54nHB22vcBSQ8QjbadpKU4cLqICQsem5/?=
 =?Windows-1252?Q?8WD9K6i5vr2d5995B3+lFWSAYjWys7AZ9G0JTLOaXFJaJBYO320ftgDQ?=
 =?Windows-1252?Q?6PrBPMxBKvbqZGz/5sSwifF+gJ/tDo+3FWxkQGmxr7cf7oqnPI4xo0wZ?=
 =?Windows-1252?Q?w7rgWM4vHBj8pZg1AnlAZ8z9ko6v0bW5V9/NWVWqsbLYLbboxLQoEj0w?=
 =?Windows-1252?Q?zfGzjoAZcKaCyCZQ3E0FL45CJ+08sSovyhHoB2ji0Kpl8ZKrNBFWbVGH?=
 =?Windows-1252?Q?J9nWYMfY02+XtvKvL7ueYEQ2noMsoRbGPaFaxgEIEVlYsXAvS64l6kSr?=
 =?Windows-1252?Q?FWRGa24vqXKQk1fn/e5fzE5mrgi2fvSdhkZ0P1ng8yNBV58V4junHadO?=
 =?Windows-1252?Q?bKclTiUiUZ84wQt0ho1Hz+iGqofA7z7VonKxOukXWaqtKcbphwbwjPQN?=
 =?Windows-1252?Q?nhGY+gzyfG+DBhiZbuESg5Y6VWND5carux4WXrECMYK1prbCo6CYQcxl?=
 =?Windows-1252?Q?7wkyh61Zam/m7+bKFoQc6pLyWfvF5jLsOczQOqEpJkmKPTFk6xFmjSl/?=
 =?Windows-1252?Q?6ZLlbm4p9hRNJ5lEM6QJ2vAWu5nJfpN5glBMH0PrnB9JBxaE05+HMuEC?=
 =?Windows-1252?Q?G9Fp61wT/4cssbbhSxldohDPDTmBIy0g4Fz5eLww54Cbxwtq5zL3kMpy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e189dacb-749e-47fc-d841-08d92639f45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 02:47:40.2864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erzkBemIjW+8Y+x/lOV+qJIjTHw7YbVEF2kos/qCS5hnn6uYLaZInKQvVCZnMv0Cna5MNXp+yJVDxnSch07Bvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3547
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1669701938=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1669701938==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB29540334678B98C0A7B10C32F03C9DM6PR12MB2954namp_"

--_000_DM6PR12MB29540334678B98C0A7B10C32F03C9DM6PR12MB2954namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

I think both of those candidates have drawbacks
** option #1 has a clash with the limit_level
 eg.
 enum pp_power_limit_level limit_level;
 enum pp_power_limit power_limit;

 power_limit =3D PP_PWR_LIMIT_DEFAULT; // name clash

** option #2 doesn't describe the usage, and might as well just be a uint
 power_limit =3D PP_PWR_LIMIT_0; // no use in reading code later

Would you accept "category" as a suitable solution?
 eg.
 enum pp_power_category
 {
                PP_PWR_CATEGORY_DEFAULT,
                PP_PWR_CATEGORY_FAST,
                PP_PWR_CATEGORY_APU,
                PP_PWR_CATEGORY_PLATFORM,
 };

Other possibilities may be
** class
** subsystem
** type
** element

Thanks
Darren
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, June 2, 2021 12:32 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature


[Public]



I=92m looking for an appropriate name that can accommodate more limits like



enum pp_power_limit

{

                PP_PWR_LIMIT_DEFAULT,

                PP_PWR_LIMIT_FAST,

PP_PWR_LIMIT_APU,

                PP_PWR_LIMIT_PLATFORM,

};



Or simply different limits where the meaning may change based on ASIC - LIM=
IT2 could be platform power limit for ASIC1 or LIMIT2 could be max power al=
location for a domain (say memory) for ASIC2



enum pp_power_limit

{

                PP_PWR_LIMIT_0,

                PP_PWR_LIMIT_1,

                PP_PWR_LIMIT_2,

                PP_PWR_LIMIT_3,

};



Thanks,

Lijo



From: Powell, Darren <Darren.Powell@amd.com>
Sent: Wednesday, June 2, 2021 9:25 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



I'm not sure exactly what you are looking for. The enums sample_window and =
limit_level map to power{1,2} and cap{min,max,default,current} respectively=
. I added the enums to make the function signatures more readable and stop =
the use of value as an input and output variable.

Please give more specific example?

Darren



=3D HWMON Mapping =3D

=3D=3D Read =3D=3D

SENSOR(power1_average)     amdgpu_hwmon_show_power_avg(0)           amdgpu_=
dpm_read_sensor(AMDGPU_PP_SENSOR_GPU_POWER)

SENSOR(power1_cap_max)     amdgpu_hwmon_show_power_cap_max(0)       get_pow=
er_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_DEFAULT)

SENSOR(power1_cap_min)     amdgpu_hwmon_show_power_cap_min(0)       0

SENSOR(power1_cap)         amdgpu_hwmon_show_power_cap(0)           get_pow=
er_limit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_DEFAULT)

SENSOR(power1_cap_default) amdgpu_hwmon_show_power_cap_default(0)   get_pow=
er_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_DEFAULT)

SENSOR(power1_label)       amdgpu_hwmon_show_power_label(0)         "slowPP=
T"

SENSOR(power2_average)     amdgpu_hwmon_show_power_avg(1)           amdgpu_=
dpm_read_sensor(AMDGPU_PP_SENSOR_GPU_POWER)

SENSOR(power2_cap_max)     amdgpu_hwmon_show_power_cap_max(1)       get_pow=
er_limit(PP_PWR_LIMIT_MAX, PP_PWR_WINDOW_FAST)

SENSOR(power2_cap_min)     amdgpu_hwmon_show_power_cap_min(1)       0

SENSOR(power2_cap)         amdgpu_hwmon_show_power_cap(1)           get_pow=
er_limit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_FAST)

SENSOR(power2_cap_default) amdgpu_hwmon_show_power_cap_default(1)   get_pow=
er_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_FAST)

SENSOR(power2_label)       amdgpu_hwmon_show_power_label(1)         "fastPP=
T"

=3D=3D Write =3D=3D

SENSOR(power1_cap)         amdgpu_hwmon_set_power_cap(0,value)      set_pow=
er_limit( (0<<24) || value )

SENSOR(power2_cap)         amdgpu_hwmon_set_power_cap(1,value)      set_pow=
er_limit( (1<<24) || value )



=3D Summary =3D

power1 =3D> PP_PWR_WINDOW_DEFAULT   ( label ("slowPPT"))

power2 =3D> PP_PWR_WINDOW_FAST      ( label ("fastPPT"))

power_avg         =3D> AMDGPU_PP_SENSOR_GPU_POWER

power_cap_max     =3D> PP_PWR_LIMIT_MAX

power_cap_min     =3D> PP_PWR_LIMIT_MIN (optimized to 0)

power_cap         =3D> PP_PWR_LIMIT_CURRENT

power_cap_default =3D> PP_PWR_LIMIT_DEFAULT







________________________________

From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Tuesday, June 1, 2021 12:56 AM
To: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



May be just call it power_limit or power_cap similar to hwmon. The various =
limits correspond to hwmon power[1-*]_cap and levels correspond to min/ max=
 etc.



Thanks,

Lijo



From: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Sent: Tuesday, June 1, 2021 4:50 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



>< > The limits are not limited to sample window. There are limits like APU=
 only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
>It's better that the new enum takes care of those as well in case there is=
 a need to make them available through sysfs.



I think you mean something more like this?

+ enum pp_power_constraints
+{
+       PP_PWR_CONSTRAINT_DEFAULT,
+       PP_PWR_CONSTRAINT_FASTWINDOW,
+};
+





________________________________

From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Monday, May 31, 2021 2:04 AM
To: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature



[Public]



-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Sent: Saturday, May 29, 2021 4:36 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture

 add two new powerplay enums (limit_level, sample_window)  add enums to smu=
_get_power_limit signature  remove input bitfield stuffing of output variab=
le limit  update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`  AMD=
GPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -=
f 10`  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=3D=3D=3D power1 cap =3D=3D=3D" ; cat $HWMON_DIR/power1_cap ;       =
    \
 echo "=3D=3D=3D power1 cap max =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_max =
;   \
 echo "=3D=3D=3D power1 cap def =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_defa=
ult

Signed-off-by: Darren Powell <darren.powell@amd.com<mailto:darren.powell@am=
d.com>>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 14 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++--
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..ddbf802ea8ad 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,20 @@ enum pp_df_cstate {
         DF_CSTATE_ALLOW,
 };

+enum pp_power_limit_level
+{
+       PP_PWR_LIMIT_MIN =3D -1,
+       PP_PWR_LIMIT_CURRENT,
+       PP_PWR_LIMIT_DEFAULT,
+       PP_PWR_LIMIT_MAX,
+};
+
+ enum pp_power_sample_window
+{
+       PP_PWR_WINDOW_DEFAULT,
+       PP_PWR_WINDOW_FAST,
+};
+

< > The limits are not limited to sample window. There are limits like APU =
only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.

Thanks,
Lijo

 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 13da377888d2..f7b45803431d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         uint32_t max_limit =3D 0;
         ssize_t size;
         int r;
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRE=
NT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURREN=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAU=
LT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAUL=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 523f9d2982e9..b97b960c2eac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {  #if !defined(SWSMU_=
CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYE=
R_L4)  int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level);
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window);

 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_=
reset_is_support(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd=
/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..44c1baa2748d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)

 int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level)
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window)
 {
-       uint32_t limit_type =3D *limit >> 24;
+       enum smu_ppt_limit_level limit_level;
+       uint32_t limit_type;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;

+       switch(sample_window) {
+       case PP_PWR_WINDOW_DEFAULT:
+               limit_type =3D SMU_DEFAULT_PPT_LIMIT;
+               break;
+       case PP_PWR_WINDOW_FAST:
+               limit_type =3D SMU_FAST_PPT_LIMIT;
+               break;
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
+       switch(pp_limit_level){
+       case PP_PWR_LIMIT_CURRENT:
+               limit_level =3D SMU_PPT_LIMIT_CURRENT;
+               break;
+       case PP_PWR_LIMIT_DEFAULT:
+               limit_level =3D SMU_PPT_LIMIT_DEFAULT;
+               break;
+       case PP_PWR_LIMIT_MAX:
+               limit_level =3D SMU_PPT_LIMIT_MAX;
+               break;
+       case PP_PWR_LIMIT_MIN:
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
         mutex_lock(&smu->mutex);

         if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) {
--
2.25.1

--_000_DM6PR12MB29540334678B98C0A7B10C32F03C9DM6PR12MB2954namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think both of those candidates have drawbacks
<div>** option #1 has a clash with the limit_level</div>
<div>&nbsp;eg.</div>
<div>&nbsp;enum pp_power_limit_level limit_level;</div>
<div>&nbsp;enum pp_power_limit power_limit;</div>
<div>&nbsp;</div>
<div>&nbsp;power_limit =3D PP_PWR_LIMIT_DEFAULT; // name clash</div>
<div><br>
</div>
<div>** option #2 doesn't describe the usage, and might as well just be a u=
int</div>
<div>&nbsp;power_limit =3D PP_PWR_LIMIT_0; // no use in reading code later<=
/div>
<div><br>
</div>
<div>Would you accept &quot;category&quot; as a suitable solution?</div>
<div>&nbsp;eg.</div>
<div>&nbsp;enum pp_power_category</div>
<div>&nbsp;{</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PP_PWR_CATEGOR=
Y_DEFAULT,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PP_PWR_CATEGOR=
Y_FAST,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PP_PWR_CATEGOR=
Y_APU,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PP_PWR_CATEGOR=
Y_PLATFORM,</div>
<div>&nbsp;};</div>
<div><br>
</div>
<div>Other possibilities may be</div>
<div>** class</div>
<div>** subsystem</div>
<div>** type</div>
<div>** element</div>
<div><br>
</div>
<div>Thanks</div>
<span>Darren</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 2, 2021 12:32 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
@font-face
	{font-family:"Segoe UI"}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
pre
	{margin:0in;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_HTMLPreformattedChar
	{font-family:Consolas}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_xmsipheaderc10f11a2, li.x_xmsipheaderc10f11a2, div.x_xmsipheaderc10f11a=
2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle22
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheaderc10f11a2, li.x_msipheaderc10f11a2, div.x_msipheaderc10f11a2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:br=
eak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Public=
]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">I=92m looking for an appropriate name that can acc=
ommodate more limits like
</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">enum pp_power_limit</p>
<p class=3D"x_MsoNormal">{</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_DEFAULT,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_FAST, </p>
<p class=3D"x_MsoNormal" style=3D"text-indent:.5in">PP_PWR_LIMIT_APU,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_PLATFORM,</p>
<p class=3D"x_MsoNormal">};</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Or simply different limits where the meaning may c=
hange based on ASIC - LIMIT2 could be platform power limit for ASIC1 or LIM=
IT2 could be max power allocation for a domain (say memory) for ASIC2</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">enum pp_power_limit</p>
<p class=3D"x_MsoNormal">{</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_0,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_1,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_2,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_3,</p>
<p class=3D"x_MsoNormal">};</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">Lijo</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Powell, Darren &lt;Darren.Powell@amd.=
com&gt; <br>
<b>Sent:</b> Wednesday, June 2, 2021 9:25 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Subject:</b> Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">I'm =
not sure exactly what you are looking for. The enums sample_window and limi=
t_level map to power{1,2} and cap{min,max,default,current} respectively. I =
added the enums to make the function
 signatures more readable and stop the use of value as an input and output =
variable.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Plea=
se give more specific example?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Darr=
en&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">=3D =
HWMON Mapping =3D</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">=3D=
=3D Read =3D=3D</span></p>
</div>
</div>
<div style=3D"border:solid #EAECF0 1.0pt; padding:12.0pt 12.0pt 12.0pt 12.0=
pt">
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_average) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_avg(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dpm_read_sensor=
(AMDGPU_PP_SENSOR_GPU_POWER)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_cap_max) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_cap_max(0) &nbsp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_MAX=
, PP_PWR_WINDOW_DEFAULT)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_cap_min) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_cap_min(0) &nbsp; &nbsp; &nbsp; 0</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_cap) &nbsp; &nbsp; &nbsp; &nbsp; amd=
gpu_hwmon_show_power_cap(0) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_power_li=
mit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_DEFAULT)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_cap_default) amdgpu_hwmon_show_power=
_cap_default(0) &nbsp; get_power_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_=
DEFAULT)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_label) &nbsp; &nbsp; &nbsp; amdgpu_h=
wmon_show_power_label(0) &nbsp; &nbsp; &nbsp; &nbsp; &quot;slowPPT&quot;</s=
pan></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_average) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_avg(1) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dpm_read_sensor=
(AMDGPU_PP_SENSOR_GPU_POWER)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_cap_max) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_cap_max(1) &nbsp; &nbsp; &nbsp; get_power_limit(PP_PWR_LIMIT_MAX=
, PP_PWR_WINDOW_FAST)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_cap_min) &nbsp; &nbsp; amdgpu_hwmon_=
show_power_cap_min(1) &nbsp; &nbsp; &nbsp; 0</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_cap) &nbsp; &nbsp; &nbsp; &nbsp; amd=
gpu_hwmon_show_power_cap(1) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_power_li=
mit(PP_PWR_LIMIT_CURRENT, PP_PWR_WINDOW_FAST)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_cap_default) amdgpu_hwmon_show_power=
_cap_default(1) &nbsp; get_power_limit(PP_PWR_LIMIT_DEFAULT, PP_PWR_WINDOW_=
FAST)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_label) &nbsp; &nbsp; &nbsp; amdgpu_h=
wmon_show_power_label(1) &nbsp; &nbsp; &nbsp; &nbsp; &quot;fastPPT&quot;</s=
pan></pre>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">=3D=
=3D Write =3D=3D</span></p>
</div>
</div>
<div style=3D"border:solid #EAECF0 1.0pt; padding:12.0pt 12.0pt 12.0pt 12.0=
pt">
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power1_cap) &nbsp; &nbsp; &nbsp; &nbsp; amd=
gpu_hwmon_set_power_cap(0,value) &nbsp; &nbsp; &nbsp;set_power_limit( (0&lt=
;&lt;24) || value )</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">SENSOR(power2_cap) &nbsp; &nbsp; &nbsp; &nbsp; amd=
gpu_hwmon_set_power_cap(1,value) &nbsp; &nbsp; &nbsp;set_power_limit( (1&lt=
;&lt;24) || value )</span></pre>
</div>
<p style=3D"margin-right:0in; margin-bottom:6.0pt; margin-left:0in; backgro=
und:white">
<span style=3D"font-size:10.5pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#222222">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">=3D =
Summary =3D</span></p>
</div>
<div style=3D"border:solid #EAECF0 1.0pt; padding:12.0pt 12.0pt 12.0pt 12.0=
pt">
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power1 =3D&gt; PP_PWR_WINDOW_DEFAULT &nbsp; ( labe=
l (&quot;slowPPT&quot;))</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power2 =3D&gt; PP_PWR_WINDOW_FAST &nbsp; &nbsp; &n=
bsp;( label (&quot;fastPPT&quot;))</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power_avg &nbsp; &nbsp; &nbsp; &nbsp; =3D&gt; AMDG=
PU_PP_SENSOR_GPU_POWER</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power_cap_max &nbsp; &nbsp; =3D&gt; PP_PWR_LIMIT_M=
AX</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power_cap_min &nbsp; &nbsp; =3D&gt; PP_PWR_LIMIT_M=
IN (optimized to 0)</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power_cap &nbsp; &nbsp; &nbsp; &nbsp; =3D&gt; PP_P=
WR_LIMIT_CURRENT</span></pre>
<pre style=3D"line-height:15.6pt; background:#F8F9FA"><span style=3D"font-s=
ize:10.5pt; color:black">power_cap_default =3D&gt; PP_PWR_LIMIT_DEFAULT</sp=
an></pre>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.=
com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, June 1, 2021 12:56 AM<br>
<b>To:</b> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darr=
en.Powell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font=
-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Publi=
c]</span></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">May be just call it power_limit or power_cap simi=
lar to hwmon. The various limits correspond to hwmon power[1-*]_cap and lev=
els correspond to min/ max etc.</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal">Thanks,</p>
<p class=3D"x_xmsonormal">Lijo</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_xmsonormal"><b>From:</b> Powell, Darren &lt;<a href=3D"mailto=
:Darren.Powell@amd.com">Darren.Powell@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, June 1, 2021 4:50 AM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</p>
</div>
</div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-family:&quot;Segoe UI&quot;,s=
ans-serif; color:black"><br>
<span style=3D"background:white">&gt;&lt; &gt; The limits are not limited t=
o sample window. There are limits like APU only limit, platform limit and t=
otally obscure ones like PPT0/PPT1 etc.</span><br>
<span style=3D"background:white">&gt;It's better that the new enum takes ca=
re of those as well in case there is a need to make them available through =
sysfs.</span></span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:12.0pt; color:black">&nb=
sp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:12.0pt; color:black">I t=
hink you mean something more like this?</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-family:&quot;Segoe UI&quot;,s=
ans-serif; color:black; background:white">+ enum pp_power_constraints</span=
><span style=3D"font-size:12.0pt; color:black"><br>
</span><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif; color:bl=
ack; background:white">+{</span><span style=3D"font-family:&quot;Segoe UI&q=
uot;,sans-serif; color:black"><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_P=
WR_CONSTRAINT_DEFAULT,</span><br>
<span style=3D"background:white">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_P=
WR_CONSTRAINT_FASTWINDOW,</span><br>
<span style=3D"background:white">+};</span><br>
<span style=3D"background:white">+</span></span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:12.0pt; color:black">&nb=
sp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:12.0pt; color:black">&nb=
sp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_xmsonormal"><b><span style=3D"color:black">From:</span></b><s=
pan style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd=
.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, May 31, 2021 2:04 AM<br>
<b>To:</b> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darr=
en.Powell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</span>
</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsonormal">[Public]<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Po=
well@amd.com</a>&gt;
<br>
Sent: Saturday, May 29, 2021 4:36 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Powe=
ll@amd.com</a>&gt;<br>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture<br>
<br>
&nbsp;add two new powerplay enums (limit_level, sample_window)&nbsp; add en=
ums to smu_get_power_limit signature&nbsp; remove input bitfield stuffing o=
f output variable limit&nbsp; update calls to smu_get_power_limit<br>
<br>
* Test<br>
&nbsp;AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d=
 &quot; &quot; -f 1`&nbsp; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $=
AMDGPU_PCI_ADDR | cut -d &quot; &quot; -f 10`&nbsp; HWMON_DIR=3D/sys/class/=
hwmon/${AMDGPU_HWMON}<br>
<br>
&nbsp;lspci -nn | grep &quot;VGA\|Display&quot; ; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap =3D=3D=3D&quot; ; cat $HWMON_DIR/powe=
r1_cap ;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap max =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_max ;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap def =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_default<br>
<br>
Signed-off-by: Darren Powell &lt;<a href=3D"mailto:darren.powell@amd.com">d=
arren.powell@amd.com</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; | 14 +++=
+++++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 18 +++++-----<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
4 +++++++++++++++++--<br>
&nbsp;4 files changed, 57 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index b1cd52a9d684..ddbf802ea8ad 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -192,6 +192,20 @@ enum pp_df_cstate {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF_CSTATE_ALLOW,<br>
&nbsp;};<br>
&nbsp;<br>
+enum pp_power_limit_level<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MIN =3D -1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_CURRENT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MAX,<br>
+};<br>
+<br>
+ enum pp_power_sample_window<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_FAST,<br>
+};<br>
+<br>
<br>
&lt; &gt; The limits are not limited to sample window. There are limits lik=
e APU only limit, platform limit and totally obscure ones like PPT0/PPT1 et=
c.
<br>
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&nbsp;#define PP_GROUP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF00=
00000<br>
&nbsp;#define PP_GROUP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 13da377888d2..f7b45803431d 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_limit =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_MAX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
MAX, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_CURRENT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
CURRENT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_DEFAULT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
DEFAULT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 523f9d2982e9..b97b960c2eac 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {&nbsp; #if !defined(S=
WSMU_CODE_LAYER_L2) &amp;&amp; !defined(SWSMU_CODE_LAYER_L3) &amp;&amp; !de=
fined(SWSMU_CODE_LAYER_L4)&nbsp; int smu_get_power_limit(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window);<br>
&nbsp;<br>
&nbsp;bool smu_mode1_reset_is_support(struct smu_context *smu);&nbsp; bool =
smu_mode2_reset_is_support(struct smu_context *smu); diff --git a/drivers/g=
pu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.=
c<br>
index 8aff67a667fa..44c1baa2748d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)<br>
&nbsp;<br>
&nbsp;int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type =3D *limit &gt;&g=
t; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_limit_level limit_level;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(sample_window) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_DEFAULT_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_FAST:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_FAST_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(pp_limit_level){<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_CURRENT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_CURRENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_DEFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MAX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_MAX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit_type !=3D SMU_DE=
FAULT_PPT_LIMIT) {<br>
--<br>
2.25.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB29540334678B98C0A7B10C32F03C9DM6PR12MB2954namp_--

--===============1669701938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1669701938==--
