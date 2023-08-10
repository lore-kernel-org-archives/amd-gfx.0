Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE80C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 01:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B9810E144;
	Thu, 10 Aug 2023 01:29:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C721210E144
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 01:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg6tiH3YgnOnfvnvIXI4dWRMgqAy8y181y1q/ThUia+v1NHNu9L8PWkKrowPP91bGtJe3+QzNWpOPBPuaN+k0IL/yM6HltOyeIw1I6gtFKZxiFH+ynJ0PWL6RWnk9PDOxgEwwcIFzJxcDz2dxjWB/avBzvTMGhK868DJjMvMaTuVxFNUvuKKb/Tkv9gom29h23Hd6YbkNGl0/rK3G1lWZNh51ozogDsSFLp3pmd1fKdpTC4OO0dTlEnqYM+W/2mKA/JkNqAmJCWUZ6q9fGmlzoVK23dueUbRWTqiaWtl9UqjpdWVv93Eh2UWQQxqU8hKB0AlUC52EaUvhtVpsDIdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOi6omy6MK46zA4HOkaaKLrcoCLHlOdLEtvlAeanUhg=;
 b=mLE2p2NG25DssAQSs+MGJUmYz3LpZL9uHVbgSzWlW3A0npvalW+F6WrEmJqPoY2PwwDakDsu5u2R/WUneKQ1QQSCWGNFQwEGlH9aV3d8xrlnUkCw95GzqoE9gxnBDgu4NV247nbDZTpW4MO6Cdsp5vZlPTprPdTMD2k9Ul9iH6tEHu5YJOGoVgMqIuVocl8mP9uWeqaKsR/yXHsB89yjG7UG59felNtqY3UeILvNZoPgkhqkz1IerFdDz3N7lOPvC74EGx8rhcT8OFX55nJQ8+BKYcs0pOca2jhtlLpKQFs8z6YnhltWcZ6dCvYgrXsgANA/HJ4Juw/CA9aCWlajsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOi6omy6MK46zA4HOkaaKLrcoCLHlOdLEtvlAeanUhg=;
 b=K3peSjE33FIEaC3/M5qjkAUwCrMWLvfPDowZVxqaQd3QumlDN69kDBSioiug4qYEpjnfI5DSz38UubaPZ3n77fcVd7QLTZNpK6eWOhD77Qg8cdMYr4SEuDOni1f5gZ+yaeJo8e/wnj7g1BIR7bboCcK2IfIE3aYWHfSAWRPVZRA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 01:29:16 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 01:29:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: expand runpm parameter
Thread-Topic: [PATCH] drm/amdgpu: expand runpm parameter
Thread-Index: AQHZtNj11S8X5qZjeUCmOrppOy/VMK/i6jKw
Date: Thu, 10 Aug 2023 01:29:15 +0000
Message-ID: <DM5PR12MB2469ACC238872A654D1A1BCEF113A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230712155245.2940715-1-alexander.deucher@amd.com>
In-Reply-To: <20230712155245.2940715-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=00cecbfe-8c04-4e90-a54e-f3ccaff36a39;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-10T01:28:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH3PR12MB8457:EE_
x-ms-office365-filtering-correlation-id: f6bddec6-9c48-4dcf-a003-08db994135b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LcvJY1Kp2d2gdNvFxINCMqHgsE9T+kitS1wDnFC6hUxzCtnaRrHSwt5cgWwj6BZ9lXKvIvqgjQBHbzn74CI1kM7HZZ3+EcNZvjkfnmH1GvXJ6clmzZrDg4wM+toMG6po+yVmI3+cIdyU+93HBaJJdQUwQQJ/gDhekK9uu9NMPt5p7DtficLuNuW2UAe51dz0/7Jb38q7WqT96BhQF/Hvzyp4c4KZ9TYsvH17pDv4aCWfzLI1qP9CrCPaR7iW+vzDw5sIMy5P5jGiGjIUbbqs77CLl9O2MJX8y9T6OOy4OkutAinzCgzRFCmqy4vfuVZT5DUZe3YhWsFJjfw+rrA1zWG9F382Lw8060MQS70M3hzUJ5rY/8cWvq0Z69KpRewGXeCx0y8rjmUh3AXYx/hZrZ7MnkLARaQIsDA9jD1vpsgr/ppyCHicIPWHVbf3nnEz8LlT6CUxHHFUnJbMV0SJArvCoOOydRQMICSDD+K4ibPFuvZesypT3o5OQfxAngLAKE365J+sUlqXE0armwXo3/fV7kqBHruadvXtFQvs0Isd1Gl2IHKHXwJqS3Jzs1EyxCc6H5G+OQaMmjtV2fOnXdai3ArlcIN8sjeaZVJSYCi08BabXMw7Eu+vIas02tF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(1800799006)(186006)(66556008)(41300700001)(66946007)(316002)(8676002)(8936002)(86362001)(4326008)(76116006)(66476007)(55016003)(66446008)(64756008)(2906002)(5660300002)(38070700005)(52536014)(26005)(6506007)(53546011)(33656002)(966005)(7696005)(9686003)(83380400001)(478600001)(122000001)(38100700002)(110136005)(71200400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QgTqQR70dNtP3/x+mQYLBpG6QTgRVAeA/qu+q1hjMjkgY/tPJulxi8wpVTZL?=
 =?us-ascii?Q?REECGuOJh0aDKtdsXZbm4v840ptc9V1Rycc7BNZf1XMGWuGGQEAwdKSWKipn?=
 =?us-ascii?Q?NTvH1bjpo9z1yFLBaVMx0xNNinHiL2HwZhcSLAhY1YBgioTCOgBiVbSZwGQ7?=
 =?us-ascii?Q?jImghI6QpWobEb5y0VIjJylLYE9o9+D4VvmSxp7yRkaYvTevfqTQ1rlZYH7E?=
 =?us-ascii?Q?vlOGgP8CjVJhsunTnQ8YIRwa9Xpy/Mz+BR/fpT4Qc7kUvhUkgudJI1lsr8bV?=
 =?us-ascii?Q?rZQqp6KpZm7cMRD1y5LmZ4XBc+08qZJs1ZTF7gMJ/R1h/pboxZzHfAYjG6ju?=
 =?us-ascii?Q?89/Nea/eRX7AqHcgIlT4cL8RhWOSVS5NDQ9RYxAaw8+oPt8paIZgMqY9dgA6?=
 =?us-ascii?Q?6+gBsE0jvyoh81kiqBO6Xu+meWYHQvgkmvtxOj59r7VMtwUMygfNrFmZlHDJ?=
 =?us-ascii?Q?hD+FoYL/YGyh0R581qkqoDE4tU3z0BbAxP+676SaPMqgMB0bbJADqcetwh/h?=
 =?us-ascii?Q?stuYFnvncXlIG4OVGvjp1lXX1beijyLmGxrhFexgSN1gRFK1ovwraCBcfd8z?=
 =?us-ascii?Q?39XcKs36Rpx/LfoG6QmOnzsUYfolsE0nVbgk4xYa1X4Q4reVDqlcV35OPzmr?=
 =?us-ascii?Q?wiCaZR8zUN9QcZPIrCE4Itc9ggwlkQ62gwjfY1WV0m0eTbiK70VkLz+L29kQ?=
 =?us-ascii?Q?eXSNM8ng1E/4oNzCril/dlUIhvJgHgi2zr5RD9M2vI8X0OfQqxnV8rYmxa+t?=
 =?us-ascii?Q?5vRK1z72KAFOXSDEHhg51vSrwBH0bwgcxXAwLGC/MqS/e4RZ4UQ9HXZk8i7R?=
 =?us-ascii?Q?CvyhprVN61oGHdHlpRYoR+rfv2aGQN0dBMouoUaviW448kDcABSjsml51kYK?=
 =?us-ascii?Q?Wz0rPaGOVmNgW2R7O6DnB6xgmF6O8wi5NDP0heEcx7ORf63BN//ZpUjVciZQ?=
 =?us-ascii?Q?APzAtxs3wYXBWTWccxREkYhLDU8HQQ1iJnsolu61+RglWEsKaN8ImL404EK2?=
 =?us-ascii?Q?1zl67oOZE446GYsf3VnSRX7wtHNNWIYjAqJxGAziHP17UCAkT1ZUtiZBnKpd?=
 =?us-ascii?Q?Form7T72p5pUvvNrJLV6FAd6PbmoBrHSXsURmLsTTCkoa1RMj+j5Zg9LhHow?=
 =?us-ascii?Q?HDzFIMQgqQkS3D0NDzqwRtAGxUS0vDoB2aG+XSWogkHMe2Qn9kM2uQ1pqRi8?=
 =?us-ascii?Q?WBApRcRD06wt5x3Yhn8Vg0CZCPSnuE4lDhBKht4SkCpHjsehoswMafMdqjzZ?=
 =?us-ascii?Q?lKASuTaCe0rMDRLbNSIfjU1F8fEYhQq5bj+93i+P1JCquUu2+c7D+PdOo+Em?=
 =?us-ascii?Q?sNHseEtcNZ/2WBRD4GGMdVKxDSClNSSc7MarZHK62jCQqwqnkHAFH2BwsMCC?=
 =?us-ascii?Q?dTyd0HplS8HgJWejjaUoOXuBpAvXm9aORGEWIWyzvdo+cIqOlM74quVl+/8R?=
 =?us-ascii?Q?6dbGt77MZHLbLXWJKvQvNWtAe36FTfxP8qdzGoGDVwuYtsPPrG6Vu7YIJv+h?=
 =?us-ascii?Q?/GLQai//ESBtMTHJbl/Ek8aCunEMJqC8S2b30UIkODoGCnj+9MPPwcz4Ew9d?=
 =?us-ascii?Q?l3nJxrW6svjdiOuRtG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bddec6-9c48-4dcf-a003-08db994135b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 01:29:15.5709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnEx3FRzxkqhVyV1LiZ6y7OwAjaQx9u9Wysv0FOw4ahikoToa3RLbG+xRxohVgJ1qCdH3hr+fXbkvxM5QnA5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, July 12, 2023 11:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: expand runpm parameter
>
> Allow the user to specify -2 as auto enabled with displays.
>
> By default we don't enter runtime suspend when there are displays attache=
d
> because it does not work well in some desktop environments due to the
> driver sending hotplug events on resume in case any new displays were
> attached while the GPU was powered down.  Some users still want this
> functionality though, so this lets you enable it.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2428
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 37 +++++++++++++-----------
> -
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 721f3c6160bcb..33e370d998a87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -350,8 +350,9 @@ module_param_named(aspm, amdgpu_aspm, int,
> 0444);
>   * Override for runtime power management control for dGPUs. The amdgpu
> driver can dynamically power down
>   * the dGPUs when they are idle if supported. The default is -1 (auto en=
able).
>   * Setting the value to 0 disables this functionality.
> + * Setting the value to -2 is auto enabled with power down when displays
> are attached.
>   */
> -MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with
> BAMACO, 1 =3D force enable with BACO, 0 =3D disable, -1 =3D auto)");
> +MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with
> BAMACO, 1
> +=3D force enable with BACO, 0 =3D disable, -1 =3D auto, -2 =3D autowith
> +displays)");
>  module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>
>  /**
> @@ -2657,24 +2658,26 @@ static int
> amdgpu_runtime_idle_check_display(struct device *dev)
>               struct drm_connector_list_iter iter;
>               int ret =3D 0;
>
> -             /* XXX: Return busy if any displays are connected to avoid
> -              * possible display wakeups after runtime resume due to
> -              * hotplug events in case any displays were connected while
> -              * the GPU was in suspend.  Remove this once that is fixed.
> -              */
> -             mutex_lock(&drm_dev->mode_config.mutex);
> -             drm_connector_list_iter_begin(drm_dev, &iter);
> -             drm_for_each_connector_iter(list_connector, &iter) {
> -                     if (list_connector->status =3D=3D
> connector_status_connected) {
> -                             ret =3D -EBUSY;
> -                             break;
> +             if (amdgpu_runtime_pm !=3D -2) {
> +                     /* XXX: Return busy if any displays are connected t=
o
> avoid
> +                      * possible display wakeups after runtime resume
> due to
> +                      * hotplug events in case any displays were
> connected while
> +                      * the GPU was in suspend.  Remove this once that i=
s
> fixed.
> +                      */
> +                     mutex_lock(&drm_dev->mode_config.mutex);
> +                     drm_connector_list_iter_begin(drm_dev, &iter);
> +                     drm_for_each_connector_iter(list_connector, &iter) =
{
> +                             if (list_connector->status =3D=3D
> connector_status_connected) {
> +                                     ret =3D -EBUSY;
> +                                     break;
> +                             }
>                       }
> -             }
> -             drm_connector_list_iter_end(&iter);
> -             mutex_unlock(&drm_dev->mode_config.mutex);
> +                     drm_connector_list_iter_end(&iter);
> +                     mutex_unlock(&drm_dev->mode_config.mutex);
>
> -             if (ret)
> -                     return ret;
> +                     if (ret)
> +                             return ret;
> +             }
>
>               if (adev->dc_enabled) {
>                       struct drm_crtc *crtc;
> --
> 2.41.0

