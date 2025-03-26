Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9213C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7CA10E14B;
	Wed, 26 Mar 2025 15:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QkY6RHDI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C1E10E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxzY44Y77XTVbn9U+tIy0+hCmikfjWpLuar/c0PC0egVHwJkQBVixTWCeZlS2D8ESTSvr3MeUHBwZRcw5Gt/Kw+ZDDnQLlT2dWgU+KAk50hXOD3RfF5HKk8HGuNYyvZbSa52BSIeZCHe+Zzz3RNk4phj4omvWR+pV2XP6hdNmHwFk4+dG2ZtL+/LBXl7ztom6zcNM7CKZZSBS6z/m9UUa1k2H5oTqOlyydLECaEVXvg0hAFOmhHnucOZfljN67+zT/XCevhRg8k+vh4RUc36BhrNXlpK/rxH+ZjK4rikT5gpp24nfNtv0fOWO0GRdLwufQJOl1fmCZe96etwXAOoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUXST6FNjrCDnjLjTofdVWE5oV8+ebkgEVM1gzErAts=;
 b=mSjpxldY5Mze6JqcmAWDNsrUxIlnbvA0RktnOYiLJTzjTWkkN4BZyMQV94RydcRap9uqRb/EnSZHsWNXfSfo5KWCztSsd9rmZmknh6sIn4g7zPBAgzcZEXXikeqJWS9CtHQIkvpp0K1PLeHBHO37Ya1KMncqA1pMeMQ9CDaAbKY85c/DuhivalrNUxlYoO/9/MULAyJQ+c/e09mO0VrUIQhLwo72g1aPDB8IUNDT1c2pvMoGwIuY3q5R9gCS1eArmsuqUZATSo7I8fkGpKQ1RR7DBPRELiWHLzVLwCq1uUq3lKdEvOtXItrS6k7t7SfsjUe5FH78b8g0FaGGlsnn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUXST6FNjrCDnjLjTofdVWE5oV8+ebkgEVM1gzErAts=;
 b=QkY6RHDIXPyffWMf9ruWCiILUvy/grkoAOk4Qr4ncyVBoiXU6AOdEQ+6I6G2nWT71gtwerf/Z2Pqwm/7g2D7q0YpzySimtwOwK3QSw3vM/gq2EQLhIiUEO2q38fCpCRJ1daLJ3gSwMrktbAFPMRI2jlKPq7lQfdk97AFf7v1mW0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:51:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:51:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Index: AQHbnlUHwKtc3usqWU67TvlwT+v3hrOFjPuAgAADsVs=
Date: Wed, 26 Mar 2025 15:51:00 +0000
Message-ID: <BL1PR12MB514411189697D187AA4E8DD7F7A62@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250326134301.1012270-1-alexander.deucher@amd.com>
 <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T15:51:00.312Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA0PR12MB7477:EE_
x-ms-office365-filtering-correlation-id: 1824a5ac-da76-4157-1d79-08dd6c7e01a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?QGx4OrRzF3OtFuTXt2IiMFw0Ek0Bb2r92J4u22AK2WJoXgJLIM8G7nXf?=
 =?Windows-1252?Q?xqwgFRdK3XWScbzPryXkOKRCBTCtVOpY+mMKjvW0FVHOrNiZZIAi8MpE?=
 =?Windows-1252?Q?KzA/fZibdc1XPx0Yyx+cfwZLGWWUXuoN0BQ3IGCnNzTSjtW0hgrCBmqj?=
 =?Windows-1252?Q?jMgLli0EtiOv1YB+HyjUrsuSE6sh0I5HDPeAuTmtA0V0F0BN+uuePNaR?=
 =?Windows-1252?Q?PxuUW/8za2laxEaioyRjAkXw0tFrb8+y/ryNxOHeR/bGJHIIPoBWDjKP?=
 =?Windows-1252?Q?NKLYNkPlUzQmGxtjbNhBsLfBYXe8UYvQXsVzvc6FLFf743VEWNduTouA?=
 =?Windows-1252?Q?ZvtNxvW5W7Sx5YQMJa8laY7d7xrKcbbMzs+hDke7ZZENpYZqCq6+1grY?=
 =?Windows-1252?Q?nQ61kllzmzBXpXhHNDOH9N1cqzuMmH1GmLY9OSIxF6FCxLBNu7EKiGUJ?=
 =?Windows-1252?Q?0iLm39wxd/B/QQUfuWm6wKLcwZo8kkd4ghE7QeUcIr4p0je5Nn3882Dd?=
 =?Windows-1252?Q?7IyvuDCkzTbhQSej8uD24bvzm+vpDBxAfPR4emS20IdaYjMQixUl76jW?=
 =?Windows-1252?Q?ktYBKMcwxOj0lUSTQnebhfhhS/D3IeYPFOKVhSjMkoXLjEVHLD6qPiJ4?=
 =?Windows-1252?Q?sFCHtJyDQvd3zSAJbTigYuarIIx/RzD3Jlq5kfgMFC+WyHe2uNKuz12R?=
 =?Windows-1252?Q?i/CcW4WSJeMPZQbw48cYbv3n/T6Do0/lRhCe1pUsVmW8mon4Vl0QzF8z?=
 =?Windows-1252?Q?63+QPcpc5t6bd4oG0aDn3dm1T/x3MIDdfGcqNtVXJglU0E2A2ZL+OhvU?=
 =?Windows-1252?Q?vgg97lbV8wdOtUnQ+0p2YSbGMm66q43ixp/sgU7t3c2VLB9NUHliQ5J3?=
 =?Windows-1252?Q?vkbGdrMrsI56AMaLRhyNT7XFoii7h5P6XhcjNmuxrS+Ko0ErRH+KUqNw?=
 =?Windows-1252?Q?5fPGeOEJOpg8VAVBVA2Vva/iQJQCpyWt9m35jRY5UtAy4U3fkWv1AOIc?=
 =?Windows-1252?Q?1oAZdAv2QaASfnWQkGg+lC/7Z6Q9SXDKmlQqxYgAYEZa1pzAU6mpVet2?=
 =?Windows-1252?Q?VZY4zRbSmbRWjafYT9LnlRpj0hNH0zxkKwEPUNy5AEYKAlFudttCBWnG?=
 =?Windows-1252?Q?7gYEgNyqz5+xfVDups+cnTAhWrFxH/tWmFWigHS1aHVXEs0WUD815XEM?=
 =?Windows-1252?Q?PEtQaMakspVZsjgIvu/LaVZxVPDG81U6qI2r+7mRnXgpnYg0zvIH1fqO?=
 =?Windows-1252?Q?VGj8UTs7GcrhNk0FZC4j6BB8kvRc/dzBzzwXxW6WBVruToIay87wD9ag?=
 =?Windows-1252?Q?OncghaEr/NHs5sjbizzG1uaO72DC259p9Rr//Pvp5LyDYMJ9c1ZfM0pt?=
 =?Windows-1252?Q?sagkMEsNhuYFKy1EQAJKwQr7hXBCIwhZyF7kFDO/nhtdo2iVqsfrpIxf?=
 =?Windows-1252?Q?8xU1H73YXGcwvfZwFbqosDDsfJJkJVavysCxBWcFJXMB+5NBuCPUSEO2?=
 =?Windows-1252?Q?aD9XQ5BtPgJaM6050OSgBvC6E4cR0k0gjdGF2XGVOeoCrd9TVToIobU0?=
 =?Windows-1252?Q?UHw7Ie2cXqRnteSuC8Qo8dJ8KfCZEBsWZmMy6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XGbvaATrXwI6w0YRTGCMFWmp4KwzJWeKbya1ilLqg6mBwierKq1BGXFL?=
 =?Windows-1252?Q?7+CTBzcAE7hc4+FpWrjg6ZsLc6yqXMnbdQx18XVkyz9OsNWCvgRj41OB?=
 =?Windows-1252?Q?iqYWMNqYvlUQeXdF2yrpe9LpuAS0EKclrLnbulnSA2hlxGsn6maqbK83?=
 =?Windows-1252?Q?1AjeuwY0psYyFU2oLeSe6XqUO9tshbUZmLgkh1jgYQTR6CcQJxKVpJf1?=
 =?Windows-1252?Q?MWPkK2qwi5UFL0cReKxmZakp4qlD3oeLZqjP/vhzUSLdrppMGT1L5aXr?=
 =?Windows-1252?Q?yHUPH9wXwV1MZnzkGaTr4cCx+NaE/rZvy3+RtFJtZZRL89KKAepaGNzm?=
 =?Windows-1252?Q?iHS4x3zFOmylKoYVXhfmkUQug6PKN2V5xl33wZECyYDcmYUYeer99+PI?=
 =?Windows-1252?Q?AQD7U+EvOn0c1UjZ2RLecSx6wvtGO1iwnG9557cM2n4aZEkM7+6uopdX?=
 =?Windows-1252?Q?yv/eMOmIyOZoOU+l/NopHdSkgYI/5xBizp58w94k5mCO/ksdxCp9+2Tj?=
 =?Windows-1252?Q?p75qFiTzsksHDRARh3pHYuVqVpBRRYGWWjuco2n4M5VeL2lSRpqaCKjb?=
 =?Windows-1252?Q?P+T8ZcpyBDMdlaB5epRobvzKjQVOczmZSEV8T9Q488z9453Pb1j5cC3T?=
 =?Windows-1252?Q?HuuEfkO6+Eg6X23vX81gTpGEWSQM/HJbUKeH1W+rXIqzxbvJjbZxf+dB?=
 =?Windows-1252?Q?eI+W2Pxz8XR5HaCKLzD+2gTWNFPsxrQvvRXoKlSnMJzbKJiLubXANr33?=
 =?Windows-1252?Q?r+E7YUw2bg7bzLpbr/hwkJ8iFnSvT1vDACaXUc9rzOSt8btKzxTQNxEr?=
 =?Windows-1252?Q?JSUuxSm0qga6rdTwAHE/SLBLSh/r3KXZ2LWu23GdzGsjkOaVvlYfTZA0?=
 =?Windows-1252?Q?zNc2+iGbgm0gbyNv5TD0AjtNbe/UqiPmceYETFwVmdLykCzLS0OAplat?=
 =?Windows-1252?Q?0IfGXOeG2VouSCD22V63Uj7peoe/of3idm6t5n72BD/45jgQFDyllV3F?=
 =?Windows-1252?Q?D06WrHYtz+swgckjsmOoTTO1Pli1jmCQYYlZu9WAzkr7Yj2PzlZhxDJs?=
 =?Windows-1252?Q?sxkdKxd3xKdSY/0tslkUhg06srQMQ40fQ00cL7oipOLfTIWedqBEFWI8?=
 =?Windows-1252?Q?kUdrffNUwVZq2PRvGyQj9ffII+4rxKOCpdDyom/aDrktygNC5eJWAvWh?=
 =?Windows-1252?Q?nbDteljAN4XC7AOQOcJbwCnkx7HfsCgaD2jKW25daNor47oUKwaz72B7?=
 =?Windows-1252?Q?YrAUvh0UqXaBdWYgiSHCpoqvXkT1qKTGynV5WYXRvf6jmplCE4fzlk+c?=
 =?Windows-1252?Q?V0utvhI0GY8N6j2wwDOKRH6IswCFPACWBPxXTr9HVuUhsIzVu0W9bxyk?=
 =?Windows-1252?Q?reQJFN1V/haJszf3OZ7sG9Iva/bVSUj9yXmBgR/CxBTLiKb8HHdfdL9m?=
 =?Windows-1252?Q?0okwMbrYchg4IAHliMeDgyx4U1FJJuOvmbMvmFGdP8e52qDLoX4p0JD2?=
 =?Windows-1252?Q?Fd/NQVX7Nph18H9lefrsh1ODMqVtPpMW81mrRBzXrGbEbb4K+I4F5Mat?=
 =?Windows-1252?Q?x5aOER3gvjQFc22hmP8iLXjJ2iC9BZlRbCU00vtjajaNwwbupfNy2NhV?=
 =?Windows-1252?Q?rieQgigQy4C2TXulZ+Yz1clMw4og+1U/u4cwTJ2dJEug3LuljWIGZsrY?=
 =?Windows-1252?Q?77orWeUzyFs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514411189697D187AA4E8DD7F7A62BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1824a5ac-da76-4157-1d79-08dd6c7e01a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:51:00.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEEnJpP2pMS1KQ+F5RZ0GysiKa4S0yxPFBx3ZlfSJ/HkUw2xQZypxZ72dRttigr7PlvtZcKGUzWAHEB0YxEdnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514411189697D187AA4E8DD7F7A62BL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

We could clean that up, but if we did so, we should add a second switch sta=
tement for the userq_funcs assignments so we can enable them selectively as=
 the firmwares become available.

Alex

________________________________
From: Khatri, Sunil <Sunil.Khatri@amd.com>
Sent: Wednesday, March 26, 2025 11:36 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec

[AMD Official Use Only - AMD Internal Distribution Only]

Gfx11 now we have same values, hence we don=92t need to differentiate betwe=
en two sets , only one set is needed like below.

As below
case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 2):
        case IP_VERSION(11, 0, 3):
        case IP_VERSION(11, 0, 1):
        case IP_VERSION(11, 0, 4):
        case IP_VERSION(11, 5, 0):
        case IP_VERSION(11, 5, 1):
        case IP_VERSION(11, 5, 2):
        case IP_VERSION(11, 5, 3):
                adev->gfx.me.num_me =3D 1;
                adev->gfx.me.num_pipe_per_me =3D 1;
                adev->gfx.me.num_queue_per_pipe =3D 1;
                adev->gfx.mec.num_mec =3D 1;
                adev->gfx.mec.num_pipe_per_mec =3D 4;
                adev->gfx.mec.num_queue_per_pipe =3D 4;
#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
                adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_funcs;
                adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_func=
s;
#endif
                        break;

Regards
Sunil Khatri

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, March 26, 2025 7:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec

GC11 only has 1 mec.

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e0a9b10d645c6..a9ef33205c541 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1573,7 +1573,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                adev->gfx.me.num_me =3D 1;
                adev->gfx.me.num_pipe_per_me =3D 1;
                adev->gfx.me.num_queue_per_pipe =3D 1;
-               adev->gfx.mec.num_mec =3D 2;
+               adev->gfx.mec.num_mec =3D 1;
                adev->gfx.mec.num_pipe_per_mec =3D 4;
                adev->gfx.mec.num_queue_per_pipe =3D 4;  #ifdef CONFIG_DRM_=
AMDGPU_NAVI3X_USERQ
--
2.49.0


--_000_BL1PR12MB514411189697D187AA4E8DD7F7A62BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We could clean that up, but if we did so, we should add a second switch sta=
tement for the userq_funcs assignments so we can enable them selectively as=
 the firmwares become available.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Khatri=
, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, March 26, 2025 11:36 AM<br>
<b>To:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-g=
fx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">[=
AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Gfx11 now we have same values, hence we don=92t need to differentiate betwe=
en two sets , only one set is needed like below.<br>
<br>
As below<br>
case IP_VERSION(11, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_queue_per_pipe =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_mec =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_queue_per_pipe =3D 4;<br>
#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX] =3D &amp;userq_mes_f=
uncs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &amp;userq_m=
es_funcs;<br>
#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
<br>
Regards<br>
Sunil Khatri<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Wednesday, March 26, 2025 7:13 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec<br>
<br>
GC11 only has 1 mec.<br>
<br>
Fixes: 3d879e81f0f9 (&quot;drm/amdgpu: add init support for GFX11 (v2)&quot=
;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index e0a9b10d645c6..a9ef33205c541 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1573,7 +1573,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.me.num_queue_per_pipe =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.mec.num_mec =3D 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.mec.num_mec =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_per_mec =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_queue_per_pipe =3D 4;&nbsp; #ifdef CON=
FIG_DRM_AMDGPU_NAVI3X_USERQ<br>
--<br>
2.49.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB514411189697D187AA4E8DD7F7A62BL1PR12MB5144namp_--
