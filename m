Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C98BC54E76
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 01:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BA410E2EA;
	Fri, 17 Nov 2023 01:43:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDC210E2EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 01:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB9kbnsqThDv3L69erYL6ACRnkLxYFYRX12wGu+AVuVgvL73/Knou5JMGaQMFGJ2xMSGusyh7ZwQHUSnqpWdOxBvNyQ6SNHeCtM1zPZ3AsB+caxrkdEfQw8s+4jin4jH3cVN4LC34d9HFBX3Lx+v8E/MG35D5NfFAKeBVFRpXwNZH4HCAdnXe0mzOZClaSln4QmQKNz4uODUVEwSDCp0Fesl8xnxNzk3Ud99APFv5VNyTN1pq29qq1q4VBAt4qPqCbyNOq1y10VikXh2U2KQ7BXLJ76mvWRtDjAriP2apjiABVQ/JCtWuSTqWe9ht9CpJTW+vwiJYbXpqqMkja3j5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o9QhNLnJdW9dwikfHoUZiMbSxmUkii02YvC//J1DDY=;
 b=CRCBI8IA5v920yn17NukfRRZrz83KUIcnkFb5awjF4yf6bZ5larvrHiAKvRl5UhL7Uu+GstnQwtw0qCoocpJdUdL6ZTivnWPZQHVHpofxtt2+iiugNDqaRcWKHzm/lfTZ8Ok+3xGkJi4MupAIVfTtJye6oO2a+mLWs6gENTctetp0CyzDc4O4lkpm9ZRdpoZ+2DnJ8fDmLTdXpKao3x18g/v8NgoIdPWYyUrEaoS8GQEnVmTDHSyXcwEjlHKLAyxbjm19sL9/3LKQODdXK4p5I9VeEN9xD1Wm9RS273G6xLfzpVcPoKGbnazXyFXTeJVifRYKfJEYp35Vih0eKBfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o9QhNLnJdW9dwikfHoUZiMbSxmUkii02YvC//J1DDY=;
 b=XSkGzWfXk8Xj2xOBs6VlXVW8dHslZUs+CYti5Hc2tzjhk6TIMzXpx2szf2HVc4QD6dm9+/hFbPaEc4iLVH0Qt24i5pZVcwjtDtFekqgfHCPYzClQWGg3HEYa5ByX9JSdzflC+qVX9HRd4vEYDnkkbCmM7+fJ9OOfD5rX0Xpw7PY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.21; Fri, 17 Nov 2023 01:43:48 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f%6]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:43:48 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Thread-Topic: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Thread-Index: AQHaFqQGpxMMZoMu7UapJ+axNRAHv7B9v8OAgAAB2HA=
Date: Fri, 17 Nov 2023 01:43:48 +0000
Message-ID: <DM4PR12MB51652C0DF36142C1E67CE0B88EB7A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231114024043.1773120-1-Prike.Liang@amd.com>
 <DS7PR12MB60056B2D3B2562CFBC6DA98AFBB7A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60056B2D3B2562CFBC6DA98AFBB7A@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66a07dce-7f10-4d2a-a7a2-3e045978f684;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-17T01:35:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB6921:EE_
x-ms-office365-filtering-correlation-id: ae38d485-a3cb-4b4f-0130-08dbe70ea4d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jne4Fnbb0WjVgU9iuFhoad+seGrGHzCXbqjivWTzY+VMu5DDl7y6Yd0fxUXNcSAioPHaxlJSP8jPZx6S8nIxbRj2gxFmea596OAyj68iy+GX2CIsY+f1sl/pg7n/FbIpeoiDS8b1ISrAIMm/cxshG7wzuii3c6ZkL8pDwyABo4fQjuNowXUQtmGr6ksNv47v6hq5/tIGSX6AlP3dYpZNwFI+9i0dPrqoEdtSNaPzC2f807yuTsVr4BuwoQVdBF4GidWlyCHpJlGFdhC2YivgEOwEWPfJwk+ujsd4b9X7OaYx4tdljUFRJhprLGflR1xxLsOXjlbcIT1yD82126h2VgGnXNbXCuDxlPY3P3sXhtZoc0cS1IGa6j0KfT5s5caSbSZk5Rjb32J5q6RP98CYxD7iB4/OytbxpBwd3ZpGW1wCuShHk8JsolYDoX5LhYOiyQjet5PGSNV2e+npKqk0KJRVfXhqkOeZeuZdzfYrrm6z/jXPF+Z8VCFmGY/div9oSF4hK4WiQDN94SWxonQbnbd1LCaBaOJ4JDfb3Pho2Kb37f9KyOyEQLwVHjnPeiTG4IZcD35q3wx2HAoPE6CtM/OLwaf6dL4gZtYjyA5//i3Uw/6G8bkDikeCHhtUZWbYiTqlk7ppcl95G10jO0UtLCrLHGVKcL5h1IxFYMCdY/E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(478600001)(38070700009)(9686003)(6506007)(53546011)(7696005)(2906002)(316002)(110136005)(64756008)(54906003)(66556008)(66446008)(66946007)(86362001)(76116006)(5660300002)(66476007)(41300700001)(52536014)(55016003)(38100700002)(26005)(122000001)(83380400001)(33656002)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OBDzK9chzotuG3tC7kW8iG8j7E8y7KEuuh6Pz3qOEQm452/Cv4z6M0lksMmp?=
 =?us-ascii?Q?/wV6r8Y+F3fxlQtMKCbfbRsJTuCbw6jzb1PaeuI3aAf0OBRnOg+nGof0gZh7?=
 =?us-ascii?Q?7Unhz51i4rELfcQmkYhoE2PDPIQrssAZSBg+lUYe38pVqPnBzgngYdX7iFM9?=
 =?us-ascii?Q?OrnZwx2IwU20CSh0rqS0b5qjxwRMTIurum9bbM31NpGwX/1wPKS9Me1jzBrk?=
 =?us-ascii?Q?r5jMQBQ6Mt3Bs7jKFfV2/B2G3xwbw0AjRksJ8LPHE5Jezcxxr7ZlCgitHey1?=
 =?us-ascii?Q?/bCLjBqClGgfylSV+sIpJF6jRG8VKJQ2cwscopaqics8ucHVblkBIeU96iBI?=
 =?us-ascii?Q?aymF4WRofHlP6Ez64ZLbTGyyWzCkYso90GHBV8TpcB8RMPshdYDmmrsf2fIB?=
 =?us-ascii?Q?buIoOYBYb/ApvZYQbFT/f58HHnCCunGyDGo4BkjZXw87Ef1rkdXlqFJhKVeG?=
 =?us-ascii?Q?MNYhL5qIZFIQjeTFo3UFhArVIXsB6ppY0O8vPKMTD7AL11AqMqibE2cZTL4h?=
 =?us-ascii?Q?YDZP20zaVpxipfXNpqARzKypsJXK1SVm/PeUR2RQa4ypCynNnceM/DCxEzDU?=
 =?us-ascii?Q?aj+wyG1IR+wWJAbAe5jTHzVa1841mVSzIVayz9y5gPMr9L2cyOG/qeHKJvoV?=
 =?us-ascii?Q?BQV/hOy78xs2N1qSKgB/EZUQ7bhl+QtxMtDaq1V/Hv/BOBBwaoYFG4BlF2Cx?=
 =?us-ascii?Q?P3FyyJ626u50rHFhn1V82RIxVcdN+9pI4RR/r5ok04OAZOulhR9UoYfQ/dZy?=
 =?us-ascii?Q?ymp4veL66u2X8SbbCPQhi+PcTPgNLb5H5Mz+eKMmnkYSOJ9zudd6l7d/B9rB?=
 =?us-ascii?Q?0Oc0ndQVvKlosxduLSDcuDZ3MkCeIzYuTubP0wckrOOj0NcdO3g4HX7ZSun1?=
 =?us-ascii?Q?K5H69bYJHTtm3zMqnhjOhaXnv66zPPbYH1L0Lrfjh9SwU0RF6A3CAI+/dcLL?=
 =?us-ascii?Q?J59nM9Nug38pcHolwtOEGuqPVLS9SkJ/PGPGTfItCFmK3RxtvXFToHJH2jDh?=
 =?us-ascii?Q?KMvGD+2LKTFDpds8wbogzRr+W/zXZLICzMcbusGsDdEvDHEBn3K8TNdGgWfN?=
 =?us-ascii?Q?eemgCNUooP1/EqHIzi21xb5s0x9iPVfJpAFxrCB/KBC4LEU2z8vjwrUJfF0+?=
 =?us-ascii?Q?7JJFgg0pxAhYRBihbtD5pOsk44HreWnDO1Tu19aaKeqIHaT6VmEgL22dcU8V?=
 =?us-ascii?Q?JLh1aDCKZJn7Mm71YLflVPUtLtmNDliFzl1CKc6FaufuJHkSbhyb5hEN2X9W?=
 =?us-ascii?Q?mvB9ySASI+FODnxgMixbsgzQKrWPQeWCfEe0WobGxaoJe/UJOL9eVXBaD/dy?=
 =?us-ascii?Q?kGmUdDLILzNd6/2OBv23cXNDkyKiQ6T3JPhc8OdCMa7fdSIXFKlw9uq8ahwE?=
 =?us-ascii?Q?QkZquqeV2xbBaAy+wbIL14CEZUnHtcs+J8dMNU4UTbSpfAmoigUGpW+Fo+nX?=
 =?us-ascii?Q?P/QqJ7LzuX2uov45675yL4N0QWXU/bzHgXPZ+bLA0I5B39KrTlcIgRi5xh9T?=
 =?us-ascii?Q?uSRmwtuC7ajapkbhmuVme45UeI3K/tAsnd+vfqvcZFV0aPfAdYMo/lmdu/l6?=
 =?us-ascii?Q?SXhxTQ905mT51i2BTOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae38d485-a3cb-4b4f-0130-08dbe70ea4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:43:48.4159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bscyCE2bqpV/awe13GcQPPvkYbCX/5s7tse7CCSC8EZbItC2KwFhy2Lfj9rWzATo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, P=
rike
Sent: Friday, November 17, 2023 9:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sun=
peng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usa=
ge count

[AMD Official Use Only - General]

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


[AMD Official Use Only - General]

Ping for the review.

Regards,
--Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 14, 2023 10:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference
> usage count
>
> Fix the amdgpu runpm dereference usage count.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 0cacd0b9f8be..4737ada467cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -340,12 +340,12 @@ int amdgpu_display_crtc_set_config(struct
> drm_mode_set *set,
>               adev->have_disp_power_ref =3D true;
>               return ret;
>       }
> -     /* if we have no active crtcs, then drop the power ref
> -      * we got before
> +     /* if we have no active crtcs, then go to
> +      * drop the power ref we got before
>        */
>       if (!active && adev->have_disp_power_ref) {
> -             pm_runtime_put_autosuspend(dev->dev);
>               adev->have_disp_power_ref =3D false;
> +             goto out;
>       }
>
>  out:
> --
> 2.34.1

