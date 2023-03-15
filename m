Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD58C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 02:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEDC10E3D6;
	Wed, 15 Mar 2023 02:32:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46E910E3D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 02:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EalhFRSjQ504aed7VGil418Vs3Q3wlftI9yeiwIP37g9dPdOUoPUkhEy9No3J027adgu/66++nw0wCSXDHygi5mVKNnixXmPxfm4LDuzvS/PnvUoMDtM5ZBlcL/kQ5Ivt15GUjZdiH+ZhEk7VAyy6XPJVQfFqQU0xFquH0GlHhoVJlkLH/Myl2tvFS9Mds7eQitx5JEGJda4HQFWsdeM95FBUVeVSGa01og5zKzOpdS1jXvM49jbtqvoIyKj9nxTZ9EQmMIsqY/iEO7BpI6dv0Q3T1ZJbxcY5t8RICkK/Mi+pQ5zfErbZuMD5pgqV9hruX9JBweQgZuT/Q6dkzeUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecJ8vwq7W6NmmAmlmkrXMZVwGYNOJ5amafifzjlvwzw=;
 b=nNGgm0akXyVqnxYeA1AsrUB9h2XxIkd7Ql9U7TqPGj6YV8usWdKQ534FAzyd1wsdHrXnl6rEut3W5mUDpIZtwEpxOsoK9OTmj8ipDT9jWblsUEIQuoHca6SPU5cuJiLMqzz/mw/h61/ozUFthvb2r6gn/bVTPXr9tZVo7iCg+uCqSxrVcVSQIgagjzIKCAAH487cuL4uqG6OOEBebQ4fN4gtPyuterq8Gw3YbRK6pWJocdpQCpQhOEb73y2qHJ94hjjFg4e0IQpah/8ENPR1tpsJa/MwYe4Y8/HRsR5QnWWF5/efX4wjnEhxbSxRP3mM1nQawsVR5b7qGWJrI5L7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecJ8vwq7W6NmmAmlmkrXMZVwGYNOJ5amafifzjlvwzw=;
 b=kuX41TwOdwHUBNSMMV3gLNXXpLyIEuye15DVzf0Iz0Fkw/GyrxjA7qM1fM70CNi/1/SL98xzMCi5XkoNkUXFtEyZ2C7i+hP2Rc63Gn7rSj0EaRtEGq1H2hIl1kNiZgC6X6Npqi+hEcvyUa3sWhv0VztVpTtSqQgUMWEaRMbKx2w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Wed, 15 Mar 2023 02:32:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 02:32:35 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Zhenneng Li <lizhenneng@kylinos.cn>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZVYRmP2HN1EfFdEyDSyDF2YFadK77IBMQ
Date: Wed, 15 Mar 2023 02:32:35 +0000
Message-ID: <DM6PR12MB26191948BB6624BE4788A12CE4BF9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
 <20230313025648.3103971-2-lizhenneng@kylinos.cn>
In-Reply-To: <20230313025648.3103971-2-lizhenneng@kylinos.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-15T02:32:32Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3301ecf1-f25d-4ad4-bf37-a4e7254eb149;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS0PR12MB8454:EE_
x-ms-office365-filtering-correlation-id: 15457c69-768c-49b6-c473-08db24fd8946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epLpkg7KDorGP1FhUgFwGFaU4KWssDpqBXB+cbmuC3kwIlo3NPTTz681e4OCUzjnHRjYz1Ba1Rh5YBrjGr9/37rCM0t6guEHL1CngcnINzblzHZwLYrluhh0ifGvKa5nIO6C4QwpDumzAq66TlLBSMUMuJcL2Zqot2IL75cP6EU0tsWRac7/53evNWzQP4cI6yFGh4q+VtjH7JNYhDup+PfEWApEZrB9Q7U9r5mN5MbhS3SqPOTJRnuPQiamlOXRkzNoLMUXEomm8mrLo1v0LkZnyzZepP6wJvUP49kFE89JMrKDAVcEyRQxNcxu7KsVpOLKkkPrPa8q81pjixn0Np2el9c99zuSK9vMUKJh2mvrcqCIz2l/rH8QSH6f4tV03eYgUQkJ4DFjnfeRQeUQuaK3+1eB3O2HjUOQfQj9BXEfoo5fUdwYtpzEtTZoT6NBTC/xhGGfiR1HHMTXv47Yz9FNOB871UwDD5PSjrnhMDcSywcU9cMDoQ1a/pz2hl62uKxCdWFA4D8COkB6owQctRBrgt/3H2Q8SHAnJrSVNpj8i4WjOUJRhrATSkYUYy4hAKenHCwZ1GqbEFdo5BT6orj5QsBepf3cORG7I8vGRtunz/ISM/bod7qfpiNf8/Sa9YH1Vbbcc8aMizHmgK9j40ogtG0u2JCSwXgp8gUGwIJCOjKU4G5c715dmUbhSjoQGFjqh9b4hHzjXo54mkYA5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(2906002)(122000001)(41300700001)(316002)(83380400001)(5660300002)(66946007)(64756008)(52536014)(66556008)(38070700005)(55016003)(86362001)(33656002)(66476007)(76116006)(38100700002)(8676002)(4326008)(71200400001)(8936002)(66446008)(9686003)(6636002)(110136005)(54906003)(186003)(478600001)(6506007)(26005)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2blH3u+CrjQEoN7cOf4ML9JQYtRphL0VREArUfuW9NI3kwfrG0lF2TvE7hr?=
 =?us-ascii?Q?GFTMx8wydjrV+4thQjFO1tHRa+OPChR3qBUGj9QgMCbDrCIex47wvWa2UXPF?=
 =?us-ascii?Q?HxK6WWjVqq6Db4FZwu65x4NDPw14TKX6FvEMJ2LuEWdUtVx9I8lKZr5l658q?=
 =?us-ascii?Q?ZdnsMHoLnNve8hNKrllI0jVqg7Agg6LlQxQykjYgUVTOGmxFvCVf4dfkFZjQ?=
 =?us-ascii?Q?dHw10Ub5oyT10rmdd75WoK6Rp6gDAiBZvPlFMcWCytKvSEDAqgRXoJd7F7b1?=
 =?us-ascii?Q?6IqLIoetOUq5WYadVDL+uVAM1bxL6tUjW1PETYV0p019/IhwyJCOl+Z6SZzj?=
 =?us-ascii?Q?28k+uWlPdxsOLvjGnn/BtHRhkgtxEkQOLtq2c8AVuhwISS2aS/BrA590LkeK?=
 =?us-ascii?Q?MNTaf5LDDi+62mEuzNQx/ywsX3lZfL4IW5nu87TiiXFOWi9f+FLkGQU+fjAH?=
 =?us-ascii?Q?H0f4J8LABEO1nrR1xc7sthWOsYjt5ghLNUHO5X/hG0v9RlMKAxuidz0kTTrE?=
 =?us-ascii?Q?n6Yi4Bf9BOz6yjR48vbWcC+zw3RktTrJwcHcPfIW4nzke+APNy6sZVYuBchm?=
 =?us-ascii?Q?aRQGvbxzApFMkZXLshGLtGYoS2rjFAljfhl4pxkPFgVZlVuE0woJcHfYqKhO?=
 =?us-ascii?Q?FEe0VhACagyM3WAvu1giSghEQnMSs2Hd39rDZHJ9QIWrbhU496alrC6It3Cd?=
 =?us-ascii?Q?ReThosWPYm6YkijRvH0S9JpNXNFrY2p42mfJf4+Sozjf4LCQr0VT/loKNi8u?=
 =?us-ascii?Q?dVqGkEaCm9BfEK2x1GSrYIPR7nO/ATmOOTjhOpHGB1iMw5glEId5DIJ/sKKb?=
 =?us-ascii?Q?VySGeV2YOVK2tkSvbk1mnSsz7zgbZw5uB5FK3uN2sFE+MiRSEqfO89BF3ICl?=
 =?us-ascii?Q?qTde+1eZXczbLih9+va850kbdgD38nrq2EGJTR25du68z0fhlgs6F91HsTuB?=
 =?us-ascii?Q?2F7V+WwuxqRhk3T6oSnLP93uI7V19l6V3B/BZkYDpWfD1ONmBX8+w7XNhSHt?=
 =?us-ascii?Q?AiVOvlQfgZhZy7Zm4EOj7w7jDAg0U+5YV7K89GeIY0PeyMRJqpMBR6idEG+d?=
 =?us-ascii?Q?G+X0tjgVfJP3mppJBxWVpotNw2oz+jPRQH2hbJ//BhxJr781yBxkyPaOZJip?=
 =?us-ascii?Q?GsZBApWcdNMo3cfQHGykeF7CHsxS2QQI/zMpHGXjxwjb1NaCmH5vr/gT74ok?=
 =?us-ascii?Q?7bCMjg0OKsLJlLW21hWtQtO9f5NK/kkx08VtcksOrRI9wW6EfhafHRQEeYJE?=
 =?us-ascii?Q?r/K9vj2ntOfReMg5DXAzz4B7IXygDfhM1xbv3s8iAVNoF61PBkhqEO7Zgl+h?=
 =?us-ascii?Q?LOstdhd6YqGbcXDamhJ+aXdjtUigH9EiGCGANhH/gmLYoz/9zxw35E2RkGoW?=
 =?us-ascii?Q?g6ak2DquCtErDvHYOxLzxFHtc6uvYjSuYpe4Z2gb99wYyrHeSZQwsxBuqo+1?=
 =?us-ascii?Q?BWQKJyVMNwghbYuKdABQFEu0RAe4Ojo0E5aY8+TyfMejSlPGkBOm0ku6z6rb?=
 =?us-ascii?Q?ZtI5TxJ27222pG+xXc9LrwGOLt9LOMovFYSjyLinczz9RYfowuqrnuUH1VKQ?=
 =?us-ascii?Q?kReQhpuTIchy8QyJUc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15457c69-768c-49b6-c473-08db24fd8946
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 02:32:35.1186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7tVtqjpLmZ4gDDtQ9JURyjVX0dBHhBDLSLPN0ywrsRxvAqVzV0vOu7Mhr53X5e6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I'm OK with the drop of si_set_temperature_range() in late_init.
Meanwhile, it's still not clear to me how this could lead reboot exception.
Can you dig this a little bit further?
For example, can you check whether the operation(si_thermal_start_thermal_c=
ontroller()) actually already failed in hw_init(si_dpm_enable more specific=
ally)?

@@ -6918,7 +6918,11 @@ static int si_dpm_enable(struct amdgpu_device *adev)
        si_start_dpm(adev);

        si_enable_auto_throttle_source(adev, SI_DPM_AUTO_THROTTLE_SRC_THERM=
AL, true);
-       si_thermal_start_thermal_controller(adev);
+       ret =3D si_thermal_start_thermal_controller(adev);
+       if (ret) {
+               DRM_ERROR("si_thermal_start_thermal_controller failed\n");
+               return ret;
+       }

        ni_update_current_ps(adev, boot_ps);

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Zhenneng Li
> Sent: Monday, March 13, 2023 10:57 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> Zhenneng Li <lizhenneng@kylinos.cn>; amd-gfx@lists.freedesktop.org;
> Daniel Vetter <daniel@ffwll.ch>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>=20
> During reboot test on arm64 platform, it may failure
> on boot.
>=20
> The error message are as follows:
> [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
> *ERROR*
> 			    late_init of IP block <si_dpm> failed -22
> [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_in=
it
> failed
> [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU i=
nit
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index d6d9e3b1b2c0..ca9bce895dbe 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
> amdgpu_device *adev,
>=20
>  static int si_dpm_late_init(void *handle)
>  {
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	if (!adev->pm.dpm_enabled)
> -		return 0;
> -
> -	ret =3D si_set_temperature_range(adev);
> -	if (ret)
> -		return ret;
> -#if 0 //TODO ?
> -	si_dpm_powergate_uvd(adev, true);
> -#endif
>  	return 0;
>  }
>=20
> --
> 2.25.1
