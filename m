Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D5C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 09:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B73A10E744;
	Tue, 14 Mar 2023 09:06:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AB810E744
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 09:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeQy8fCpcU0uSBkL+sQiMmjFHdKHPdKB4/KLotHOhZ/E5lws0N1NEBz8+zK7FOrW6LJNg7aMPQU1XNgusNv5TxAdxl6k3pfWNDpk/HGHiP0dbFXEc6XSCD+vE+ysh8D0ppMl63boSZUhUfGj+emNy6P5run3EQSPBHqWx+5SwTyp6QDttUofh3CFCiERfGZt7+cTFAbz/sEAg/G+oGZIGqgzu1gAwFvKaK8ogtlLMip+TP+ygG1mWuqDzMTzP1/cbNhgfLf7tsQxCRripMOJHdSmp7ipSm3k4pvCtSHdTvPhUmMBa/nTaet42Pk9OsTkTMrR7v/q1cHaLU8gUfcBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ZAVFbAZP9iTtHLTg2MqnlC9v73Y1ix1CqXc8rW1yU=;
 b=FYXGTlEA+mESRermeNxckikp1b8OhvmYxQFWmr4H1Y+fJ3YHlXBbw2QGBHw02AMFQcRDqwbUlQkmeJ0ty//fV1bQhU4q7PyLsYB8p+jZwSVJstfB7z3algysLAjdTSGRhNwlvjVYneIwyTuEaOJbxvKkJLiDENdXziLgrBz5HSUGh5vvFgoeVMtPE2RND8LGM7uuLcOl6a6oo5QOKBSPG8J7acTRCl/YS5ggm1ORaVaAt5+vUSFR+Ydc0eoYXNkq7hLRZIeDSAHsbQbQgJw5Oga1MCm9qhzwdH9xF/he/1o/eje153s9k2qo3QpiuhN9fsY9BFg2SW3clHzg/18QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZAVFbAZP9iTtHLTg2MqnlC9v73Y1ix1CqXc8rW1yU=;
 b=xGyUfKkJPj/KZjCMvigFgslhwakdI5PhrjgOXcRRWk+e6iV3j4iWJZnPMO042jhOJ6YFPsqOA6bYVeIU68OmaaZ6AnV8/71FSp/jAhAQXJt3qO4wYvElgj0BSxEbjJXlzHNsPGnJXMJ4HJebocjU1wP+Y1pBEcKOw+S8CPTBKO0=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 09:06:31 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 09:06:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Zhenneng Li <lizhenneng@kylinos.cn>
Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZVYRm6Gc/WARhgEq/8+wnG0sTdK75dueAgACGBzA=
Date: Tue, 14 Mar 2023 09:06:30 +0000
Message-ID: <BYAPR12MB46140D57681AA4BC9E42E3DA97BE9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
 <20230313025648.3103971-2-lizhenneng@kylinos.cn>
 <DM5PR12MB2469106B445537FF8F7EBA19F1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469106B445537FF8F7EBA19F1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-14T09:06:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79413af5-bef3-4aa1-82fd-6149d86e86c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-14T09:06:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f6eec745-b90e-45bc-8a67-ba302a613b12
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SJ0PR12MB5437:EE_
x-ms-office365-filtering-correlation-id: 7ef00035-6ca6-4f1c-a559-08db246b666a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMAhJQ2NMPLGbcFmiIyURgWLKOJUeNeh3F61nZTyOOhJAfepoBNhRhMdbwdBlVaUywzgmIX5Iiu1OElZwdLJjmkiLkWzPQoPKtR5h1jLDal3jP/ZhkuoTQwIY+DnELETcCY0FWIHww8G5bcdPU/QGo2VMPut+tBm/jxZbiPHBLxMwEMpWX3L77mL0mhiB8tc0RVGv1cquS1zECAI0C2Tdt1RBTCxDXzT/PyX7w9qOAd27oQc3ls9G3vXQ+F/930Rq0UFMCUFZyCSAd8/1QojvWj1lCRs66owDGHKDxdsntnOOULf27TPEFX/vJNBjDUzOB3rtpp4G0qh/EAGUOA7JfDheXROySYjV6w+dql4HxBzxcQI6Hwe6n5dRJ5uuuF3/w54R89HMMUGskjnSiHzuyxqVNaGBEst353vfPF6MNakRQYTfXy98ZygCxoZhGbVCWVeLxAWWjLfI6p4ZfDQBE/9LZhD0tXx7ulwPY7rqH49mvsDYPimInNDVV8SnsHXknDjk7IIASq7XJ3uGMtedWNdfbOf8eZIFRGA8/yYcWfu/qgEpBmUSC9bJKFMz0KiJMRuvTK7aTh41NOGGGk4j4+kaCTglo7ye9i0YA711WQUBQZTYk96uApvT7urt+IVXcwCpdguflICDPZVq+vuzid9guNuhnkeo9qx7tdgqVBt76osciVXX9vS/QBdSMVxY+5dbjaDf3sr2faUVVkD/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199018)(2906002)(122000001)(83380400001)(5660300002)(8676002)(64756008)(55016003)(52536014)(66946007)(66446008)(66556008)(33656002)(41300700001)(8936002)(4326008)(76116006)(38070700005)(316002)(38100700002)(66476007)(110136005)(86362001)(54906003)(478600001)(7696005)(9686003)(186003)(71200400001)(6506007)(26005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K963hYGBt568TJN58SzlN/W7A1Z8xLZeo6t86vEDamjN9rGm0wqrt05ZpE8L?=
 =?us-ascii?Q?QoI21CH28cQHK16h9799tIRSIYNFUx1+Z3dzoYjmttufJcJxnqc5H6udlmXB?=
 =?us-ascii?Q?rI2hVt7SDuV0w5VnwZ5r9UnNo/ne5/y18WVX9adcA2t6SiUgly3nJNs0OSgF?=
 =?us-ascii?Q?QEtOgqCcxMQgG2jdAe9PrMxVAEqiai9AqqNcdFPbBHWCToYH/4P7EYPz6TzI?=
 =?us-ascii?Q?0G3qEuHSUEeppnie4XWj6zPTt0/R17u7OS8LXbTYWOq3CBgaVdY4yU6IqLpa?=
 =?us-ascii?Q?/cpO2i8V20C4zhy/1eUuviApMhHhKq3EV3/779kXIduDozRbBPkNjjUd/wPv?=
 =?us-ascii?Q?xlqAVLuA6YZci1y+jhqxrM9hy4Ase3m3rma+mcFWPgZtpS1eTI0oOKHcnfOS?=
 =?us-ascii?Q?YieLmboqenvvQk6XzVB1jiPkUZUPGgZY94SSrbwBTAcA1MV9jk9vYSCW+7Dd?=
 =?us-ascii?Q?cu5TRPwRQDSB82XBTrq1UF5P6PFNO9B2FkAZv7NSFpkD/rdzigHlFNdK/Akk?=
 =?us-ascii?Q?8wrVm7a7P8IqA+/rjSOn90d41ohHA1fnvJEMN6QyZmZ/2rg8O3aUJcNYIXAx?=
 =?us-ascii?Q?lrCR82bWRiE4Xo++9Gv7IqEwecw+RKQ+lBj7qK46SRAV7Lms6HpKNZHpCn5+?=
 =?us-ascii?Q?iif4H/UWSNZSm8sS070AUHjg+pb210MM1tbUyH1PfeK5rdf/Cgk8mY40ByXo?=
 =?us-ascii?Q?1fqiWVJh5jTSmcuv/dRVUL9xdWApQgm/b5SOHveJ5E7yTgTBcM8TA9OIpIDg?=
 =?us-ascii?Q?lcYDX0n8OVF95D8Vhg2HEnX/VFXu9mpudY/awAfl71Lc0OpBdnv7rrygDQy9?=
 =?us-ascii?Q?wsDSl5PNiSgDY3c8y20pugVF47AkoT4h4qN/hOFACUvrgwWebRCCB2EYQPdS?=
 =?us-ascii?Q?3bDWygk1ztdikVFfYhHw9TaiH9EbZlw2BTZwsdn/+Ifq45I8KOCDitDkXUDy?=
 =?us-ascii?Q?U4mndN4eL8sRwQFKOsucIFQ2dvgCjlolNw7QxCh9bcrOgceX0oxnQv4MaevE?=
 =?us-ascii?Q?v0AOQY64/yI45TnlsDNOpf9zOgxWmLcXoRZRh7jw1fFqmTB3NIXd0M3jn1Yc?=
 =?us-ascii?Q?lELyEugGju3POXfnA7S+Am5o9dMTnufodA+ancR46xsuh+wddZrJSQiP3MjS?=
 =?us-ascii?Q?qMSkOHonloXX8w5YTAKVt7jn2E8DpAXoMBXx1NFZsea0Ut8d2WymWxV4OpR8?=
 =?us-ascii?Q?7Nz0Y09jUTKdt0qMH4OIxG35ZnBeD2Fn1U/2eVj4hd1qLr4Sk5O6i9Hk3sRG?=
 =?us-ascii?Q?jVN2ns+CHHgVq1Z765SDqs9xJmxMju7MMxVhfAnUcz/2FWbYRMCgzM2r2luE?=
 =?us-ascii?Q?JiX+ZmrzS4wBvThLh3oSmBYnzE6cqMX1vs04dDEP7KQdVatsyMTgKKS4gN02?=
 =?us-ascii?Q?0XsoPbUcwmRl34RqT4Zsdsx1TPoSgK4r8T/QafHVuC1z9ouk4CNB64gmD6d3?=
 =?us-ascii?Q?5KXD8qJxbFgHT1eVwKkNaO9NtheuuysOwmhR+yzdMo4eRr4yrZGDRvD7eYIz?=
 =?us-ascii?Q?Afeyx/My201pHBkU2dY8sWfoMVnCumOkfCqYHFGyIsN7CgiWh2V5WE+KMt+s?=
 =?us-ascii?Q?/ujWF0Jenao8e8G2tNc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef00035-6ca6-4f1c-a559-08db246b666a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 09:06:30.1266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnJxlDIUkWSwrNliKEizCK5ParNt0awBHeRdmf3cTsms4txAIGmFDO20fjEM7skk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
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

Hi Guchun,

This patch doesn't look correct. Without dpm enabled, temperature range sho=
uldn't be set at all. The patch posted by Zhenneng is good enough or better=
 to skip late init altogether as it remains an empty function with that pat=
ch.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Tuesday, March 14, 2023 6:35 AM
To: Zhenneng Li <lizhenneng@kylinos.cn>
Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>; amd-=
gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; Deucher, Alexan=
der <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland

Will attached patch help?

Regards,
Guchun

> -----Original Message-----
> From: Zhenneng Li <lizhenneng@kylinos.cn>
> Sent: Monday, March 13, 2023 10:57 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian=20
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David=20
> Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-=20
> gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
> Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>=20
> During reboot test on arm64 platform, it may failure on boot.
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
> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct=20
> amdgpu_device *adev,
>=20
>  static int si_dpm_late_init(void *handle)  {
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
