Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED77C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 01:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DFE10E6D3;
	Fri, 18 Nov 2022 01:55:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548D410E6D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 01:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4cUsDUhU9f/qSJolZVXhmwOAxDkb7S06DFGcFSq2enF3lrXWP0JoOdTtQDIz/8aEyYkyAjxKJTPljIK7ppAdOPclXjmnvw03dlEZDtV3jSDvPX2Uuc9VuK0N2q0Vaa8olmav6R5oZTTSJmshgpTJHOOP+EMMUHRTQglBGtl9rrYwI6E1faDOJkTu5Cy9jeDa17ygxqtaBPvHW922mabON5962rJlw2MstW2c2kVT9VUe8yLCnxmxvWRN72a3kztVB3vdcHxZmyxLWXtVOzg7niX/ClJMJeQCdWBbm7/UqJabnxNUNH4dwIQGg2w8mm0+bW0VpICn8tO9dBpzBit3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UFVEimsS7BXOvjG0nB5Q5k7L3JK/C1/DABB3qjIXWM=;
 b=jBZisMi7Kz38ww9BIPOxXqXBzXjJPyZaDIj2GPaR4sdRtYtS675wMQI6RsA3XfPY4vnfF+tvQKj5rlTGRRYGRRCjSobUy9aUGXWk7UdphtoguljUouWKRNGOZLN5zLDarzNJBU2S48kCc7k2/Sa7/9G+YJd+uLk0Lo5uD+JjhEG0f+MYyqCmBkIexxPM+0CAlm3W8N5okQdUyzFLabZwAZtHw2HYP4ld80NgnlteAoIw4h7He5DfYSjZExjAztYuClg0VwKgriceHtdS4e2E9InoahUo7zU0CEf/xwVxH4GBanaFElovo/4yq+RHBIrmAs8yEc7oN6IEOXuqPv8OOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UFVEimsS7BXOvjG0nB5Q5k7L3JK/C1/DABB3qjIXWM=;
 b=PjyEVY9u6F6F3u2/KIW212Pnc00sbbQID0UXvbO77FrZrIRS1oa6C8N7KzbmNbHqWrQQzcWIam9kYDUGbU6NNVfLijGg8ZHAYJUH+nB5vWf7PWrjit0+OxdIpAr7zXMj3iB7DrNJYrHd/IJ82rpCgeM8SPpSEcIol2YObefujMI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Fri, 18 Nov 2022 01:54:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 01:54:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Yang Yingliang <yangyingliang@huawei.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix pci device refcount leak
Thread-Topic: [PATCH] drm/amdgpu: fix pci device refcount leak
Thread-Index: AQHY+pWAaAvO6m6cBkSTLUDp8w0+H65D7C4A
Date: Fri, 18 Nov 2022 01:54:58 +0000
Message-ID: <DM6PR12MB26199CD7A4AE5856B753FCF9E4099@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221117150003.397385-1-yangyingliang@huawei.com>
In-Reply-To: <20221117150003.397385-1-yangyingliang@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-18T01:54:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=595295f9-1670-403f-abbd-a720e52eebff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SN7PR12MB7275:EE_
x-ms-office365-filtering-correlation-id: 1ff8f0f3-7ce3-4612-7b38-08dac907e61f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UmQgOWRiXT+HTqIeH14enYUapQ1dfg83riI9+6ClHAyj05MVeY+Xs/j9ZuLW+QpoUotlvhOTSKTzTpq7tsNc+WtiksTrz/Dr0m3WtpwI9XonU4529/73Cy1+JbhBPALXjTVrkhqjCOW9ETrd9X2PnupTxqC0uA29S3jDk/iEqgOv3VxZvN2dWEVen2q1WdB73nmsT7D82pa1R/QV87RGzwMzJwuc99ngMhkdQTUpL67sfWI7OhhTJ6aDvtbYU8E/o75kA9QxxRGd+xUW9ubwTMCBUNhGoCfTFjHT2SoKAVt72wLkccngf3BUVeaSp4bSe7VeJovq6zbBdWm4LkaWHVMrpCnUwjoiTTw5LeMO9pFp/u4Bn9Gc2M7jn6WI0jiexJ126/YhCA5WOJjNEgWb5cTw+lmpXx9Xa+JXg1br+4BkcpnCJ9y5pvEwb5DgMaRmxVQfaLT4MDa4Wa49ILJ84/DyOrsN+W0KZINNgAPtke81A8EnfRp3FQZ4UKHHIxcuCjXXleDl7MurL4+1rfX+TAiABcZioyG81IP8dIOCAqyfa6y5Qq5sY/XSSPeHwXoh4fS5WjxdxXbb9A0vNowNaPs3D72uMNORcu99kcwGEgP43fIqb0A72wsQBWG7uPTBBYEvyftJ3EVMCPU1G0+9/HnCIqL/8Jx/Y+ZlgYCAQ8CSmgX7mFtQFLmeDmv0OCXoAekwWki8b9LJAGDGqzACeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(66946007)(83380400001)(76116006)(8676002)(41300700001)(66476007)(66556008)(64756008)(66446008)(33656002)(4326008)(478600001)(9686003)(6506007)(26005)(7696005)(71200400001)(110136005)(53546011)(316002)(86362001)(186003)(38100700002)(38070700005)(8936002)(2906002)(5660300002)(52536014)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IbIIvSNHVXi3ls91mxCMJnIDoKdUmXpKuSw9DOozx3YrPF+Bcsny19a2jfnH?=
 =?us-ascii?Q?1YlolaPaDqATiRQpZthXYD73A1XWgvwvGU2Y2XoAl70P9Sp3CJz2f/IiPdJZ?=
 =?us-ascii?Q?UsPX6isqMONwK+3aKRrA7iEKpFGsViwQBBmGDeOvbrJmlptYSBRtS3if7aYv?=
 =?us-ascii?Q?5lklMELCCVkk0ca3v387AwrbjPOZOaQ1HzmD6164H9GH+kOeokx4Yl1jGqBi?=
 =?us-ascii?Q?AWXUsgS53BIphPAJqbZV5at+OoZsQpj2jlng6mTR52+sVtP/YILs6IKmVOWq?=
 =?us-ascii?Q?VgDG9qT1LRSMKQEeX/PpF9OgqmKjD/6IRuR7e2GqMvw/6/fDdZonH6Bo9tas?=
 =?us-ascii?Q?OG+Sz/OLR228UZ2dYJBFvZNcYGF65fwSYtuvYo4BSQggIGtbSBpyQ9lgUKLy?=
 =?us-ascii?Q?PRWfcyTkMPfzT9DOPT59QxQ0wbYOta37SkjX0jzgtCc+oHUOpF2U6cQQW4cF?=
 =?us-ascii?Q?qBnhsKtujgQpVJ6FFXrzjUbmsno3H4GMYI08J+jKptwByb0BZi8MjyVB17rs?=
 =?us-ascii?Q?NyknMCkm4JcwUnPxntHKWr35l7KntG4z0TQhv1uX4UxaGnpARcGs8AvIxmzd?=
 =?us-ascii?Q?PQZyYup0sIuaoRyfOi0AMygRwVR1lKx0lJBy2glnjqwy2mdG3iS28X4wEl7M?=
 =?us-ascii?Q?c59xb8p19WyALlcaD0uF7fUJH+5bSF1BhzmpRaelRQoqI4lSptcAu5hejttM?=
 =?us-ascii?Q?u/QpY+2sRD2qhMas0LMpvEqLOUCbqxuQXlYF/8CjC8g0+Lp7dZCBxOAH5Hok?=
 =?us-ascii?Q?fpa1hzsQYKXUbFqHU/KLxIQBnk9H/ZVt8q6fJEaH2YbR9dZ7iu+aZztKDxBg?=
 =?us-ascii?Q?2CmxGPovQLigwppNxrQcFBTmddBpivM3VQlk+RjtYmgRYIwFp9wW0GRzQsEL?=
 =?us-ascii?Q?KXbt8WlnT3+u8GwF/DXyqfYGRBk3Qym+7QbtpODRCDMMPYM5/jVFcDbATY5T?=
 =?us-ascii?Q?yjSGqMG2WDbgRq97dpJIThJ8Je8GUSYNXNU1VUmMi6myAnV6IJFHXT7lED8I?=
 =?us-ascii?Q?qvWC53rOBcZNyiA1Af0BVW6JOU+/mJabUFnA4805Es7UxmWAcqjbFCEJgP8j?=
 =?us-ascii?Q?xYZfxkevsfDTXT33AMxwvu2Cc1pCuETrKTrmrEkYG4sffauOmK3uCSaq1OeJ?=
 =?us-ascii?Q?D/NNGBmKPCqBakXF7wAdaaprLuJbLgtmngwyWJjfh2Py5VPR21zZg99Lxf7B?=
 =?us-ascii?Q?Z30ALJLM5h0XBqlYBi095ul266ZPjm6VzsIak1RFcQFl/55srf0V07oCeyVd?=
 =?us-ascii?Q?jbUV6ehjVeo92w/c8cKcvm2n+02tmP5+T2fxHdkaHvUdpQ1PkW0wFXbCS/jS?=
 =?us-ascii?Q?Md2Mj5VFN4AEvlHADejo2EOAPmpd6jAuCSTJ1QzQ/WufQ9tBIQkU7wSMAeNi?=
 =?us-ascii?Q?TZf5NtlfcGFgSk3OGYbSFwEDWmVqnFFnvKVh6jhzGXmuQ/YPitpaC5C5Lbai?=
 =?us-ascii?Q?aqL5C7puVGqAexINIjEQr85DvjVceNKNPUwB8v75SZd2+7QQ9dLE7Va4PmWE?=
 =?us-ascii?Q?s13sGQU0W3KlgfQiorRVovbIllFHuYKprPGZSmz0sCdivYscfdJ8C2/WDjAq?=
 =?us-ascii?Q?eyaMQGcGqljOamtyQy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff8f0f3-7ce3-4612-7b38-08dac907e61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 01:54:58.8498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3K5ID+v1x6CKsrQbJHYOkM2bcHCWQo5NNh4aefDwjJQI12fsAqMLDlWb8/oX509
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Thursday, November 17, 2022 11:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; yangyingliang@huawei.com
> Subject: [PATCH] drm/amdgpu: fix pci device refcount leak
>=20
> As comment of pci_get_domain_bus_and_slot() says, it returns
> a pci device with refcount increment, when finish using it,
> the caller must decrement the reference count by calling
> pci_dev_put().
>=20
> So before returning from amdgpu_device_resume|suspend_display_audio(),
> pci_dev_put() is called to avoid refcount leak.
>=20
> Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state
> before gpu reset V3")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 64510898eedd..69e73fef1ab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5027,6 +5027,8 @@ static void
> amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
>  		pm_runtime_enable(&(p->dev));
>  		pm_runtime_resume(&(p->dev));
>  	}
> +
> +	pci_dev_put(p);
>  }
>=20
>  static int amdgpu_device_suspend_display_audio(struct amdgpu_device
> *adev)
> @@ -5065,6 +5067,7 @@ static int
> amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>=20
>  		if (expires < ktime_get_mono_fast_ns()) {
>  			dev_warn(adev->dev, "failed to suspend display
> audio\n");
> +			pci_dev_put(p);
>  			/* TODO: abort the succeeding gpu reset? */
>  			return -ETIMEDOUT;
>  		}
> @@ -5072,6 +5075,7 @@ static int
> amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>=20
>  	pm_runtime_disable(&(p->dev));
>=20
> +	pci_dev_put(p);
>  	return 0;
>  }
>=20
> --
> 2.25.1
