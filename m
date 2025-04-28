Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EB5C36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 06:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DCA10E37B;
	Mon, 28 Apr 2025 06:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b5PUyBxr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7851810E37B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 06:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyJ86TBHe3WyTqlTE/8IEU0rFjt3HzA6NM+81yQbG2R9COUbTMfH1DvWSPgWJ746/8gM1M+onnWPbc7/bvg0xcFBeJswEYxnVk/sJAKmPHAszDmOFhHLQ93mpBBUbZg0ESmK4GFfl19pILajdC+AQOYTzeLVsHWliVa4XNYnS2xmm+fI6cvONsL/OaiX6MyrPHMoGoGumN9TmYWILCoOEvolDDvTkoT9J0S+S+z799tc4gfiFBwF9KsfBAvn7tpa2/kcBseqT1noE7XhPx9tM9DOq3+SSGGddPIWMIfps2/qAAKD4qCPC0EwjkAHOWrTFfK3KPGZQ4kfQXCOEwbzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbWXqkyPbDmVLDNp9KX4Ji0pmfwsbmFw4nwUQZYxI1g=;
 b=FVBveGxBWMPvDSSOfY4ohLuWmT4Ez0d1UzuQL8Md5IX3XCA6O8997qJqJKDMLMbcnKJvv62h/b8OezqxqE+sPPz9CWMV2yXZE4e7oufwyg3TEDGyvEuQx4aQG8eAf/mPOn8SttcUP52ADte45SKrHJGV33kyUOdDZJ/785Vv83bxkQcWn9/XabP4RqfzYmrzmW3sJlANz1kHy/x8pkbwGxZhmiNZzzxQnjhFAX22f4Uw+kV2E/jJcPCu86sZtl73tDqGnnzh+Yi5facKtLud6G1JAR79a8PyZ3hkXuKN00Exnuun4AhBf8Ouu53k/V8Zml48BChzv6LX4vS3OAOpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbWXqkyPbDmVLDNp9KX4Ji0pmfwsbmFw4nwUQZYxI1g=;
 b=b5PUyBxr3M/sWq4BHt0vXmS8gizQsaV2T61bK9P5UN/lKDR4plaJWUADHFLnBFegI/qJ3YH9K2gWwHVHZr+WtpbGrvvzv3llJWiF+rsfOOrff7RRxLHVvwDDC9u+KsQu1wPOLbf+b9HL21xTnHa/d0ku0Dsc9xEUN/eMABstFHI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 06:35:41 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 06:35:41 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Fix comment style
Thread-Topic: [PATCH] drm/amdgpu: Fix comment style
Thread-Index: AQHbt/uR7BgCtSOYSE6cbF8rB2bvnrO4n18Q
Date: Mon, 28 Apr 2025 06:35:41 +0000
Message-ID: <DS7PR12MB6071B0782D8F766BB241A3328E812@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250428050759.946910-1-lijo.lazar@amd.com>
In-Reply-To: <20250428050759.946910-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ae7a172c-ef76-4c74-93c7-55e227843cba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T06:35:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: df53d654-f1c0-40f9-c010-08dd861ee5af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dAsXaZGRh8HmDyMhRYOO4FuGxPqnRRQx4goYnNyYWGDdAnxSd79OIlPoWTsR?=
 =?us-ascii?Q?WLzSq7+5Y5PqJSJoNa/rjOAz/igdQsmw/9rNS1sDWVx4pyFbb18S49sdxKX9?=
 =?us-ascii?Q?O+GeDBb9wyALcCV6lRS/GSya1Ouz+q2HIYK5+bv78jORLbQcsF+qfONl2FtZ?=
 =?us-ascii?Q?235qOE1OhSklmdpVTj+lVLolpdPyUgD88+3SDQ76soL80/f6+2gpBGDtjSZB?=
 =?us-ascii?Q?K+auPVhXwBb9Wpmt3eQfOr38BS7Nhdc7rQQFRKl57b8Xigq4b+niRjqMVvs5?=
 =?us-ascii?Q?Ee/STTM19qd8lQI1R0J+9psN75kPrku2LBxE76kakTmKmp7q25vPc6YfyhFu?=
 =?us-ascii?Q?u3evSJaJQKvs4cujrsVaAWYw3RTo2Wd+UvMZw95L7KwztE6HbgZ/8RjmDSr0?=
 =?us-ascii?Q?LVtDUhilZvCrbKey6c4rUpoD6eH4lKLyqZyWZ1gJpWsC3y8LiGODLa2RVBGY?=
 =?us-ascii?Q?Ij4y2h+ADBtPt4wJGI/NKD0pp4I0iRGjTsy9rkly5zc94qrfkyU+lJsEFzET?=
 =?us-ascii?Q?4ftgJDfC3zi8e5lY2xEi0271HjC9Ux6or8webqTEfNMICK3RDx3DxcXdLpRV?=
 =?us-ascii?Q?SoyBYXylQK5VARK2m5eS22/dn5lyNENs4/zgrdrOghDHNJeU/iJ/EUEq5ckN?=
 =?us-ascii?Q?Z+9PAQOfk36Cos43t+5sBDhpwVR9kQNmsKkYRI9hiaSeofCfB2KrE6PUPngc?=
 =?us-ascii?Q?xyfSBwx06g1XYOwNKveHkXDqZSFtasl0UJubZ+p3nlv5TM1p1povJTnaY1Cz?=
 =?us-ascii?Q?1CIK8eB1mndUMpzPa887LWSgyoX5/k0ouRabr3foK664APExuIRC0PZCbIfm?=
 =?us-ascii?Q?SAgB11LY97XW4m04A2rP0Kr60XSNkjtwENNInNpnd54A5NhCo+M+y1QYgcxP?=
 =?us-ascii?Q?eq0gwViTz9eVeDbVl9jFVWj+RU0d5UFgE1AWUbasWdz6f2fI2oIkOahui98U?=
 =?us-ascii?Q?S2EtlRKUgTi6bPjHp+OTQSdSQvViAbBCMGDUyxOZDkGPMNddrjrEELFnhK2u?=
 =?us-ascii?Q?0fhtt2L3297W7J6xjGFfe/9zQPJvb5ngh746NlU+VzHO5+NTZ++dP8zcZaef?=
 =?us-ascii?Q?xFxV24k/yNwtSZCD6G0t07maPtEJZw80/6H7BRjk4aHWN1xPXHnaItJgY0ku?=
 =?us-ascii?Q?jQ9izsJseboynDBmvF1megVk/PIf3Qwwuzt/vIUmOLIgW/JUoQKFET+e5iQ6?=
 =?us-ascii?Q?h5DJMO2xKjb+DTZQxFiRsTOB299PcH1pIg+ODh9efTjB39LM8pzis5qKPDpP?=
 =?us-ascii?Q?HERZZleoKyGtK1Ahv5lPaYKw4O+5uZqeeGNuOTPGpY4UvIJhzE1fstYbHTjL?=
 =?us-ascii?Q?ccjbBESsPVU5f0am4KmVlp+Eiuys9/mkPpIoE+OsnmJ39ZezFUlAcQUi+i6H?=
 =?us-ascii?Q?LJwZnIHASvgj5MhN1GwihtHxfS1uJ02zMxT77bqP63avPQn8jJwwj/h2XuEa?=
 =?us-ascii?Q?n3kmMqJ+nm49aMF5zEDldHU0swERrftNCJpkBhiKyiy1OLO3QJwW+qQ6jdhO?=
 =?us-ascii?Q?7loFAWaHAp0UVd4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LO2dNpgKb1R4Z7xhgqBpyitwkxqzmM/gKo/O/jjyWg4y03zeE4Esq+U3jSD5?=
 =?us-ascii?Q?4dZzEMYIWoR8pmClROZI57qNoVvnFSSZizGovOZlb/gvzKouYEfGhZZ+96yF?=
 =?us-ascii?Q?DSVCOhgpnj9KJ3C/7wlabg6IFVdqORNE3b8cwNo4l2uzMtec32XZvnLrzQXL?=
 =?us-ascii?Q?Adj2Q5gnagifLf6ex+DlM/deZz2DR9LVHQMZ2jWY2VfhzwDRogp68N7IOIZA?=
 =?us-ascii?Q?jZobXU27Uftpj+PluYrrncOgz1fWF9jdfJIER4pKZixerObSo1hFiLt/8xPa?=
 =?us-ascii?Q?hBHQ2yCsDwAo6PM1BIQ7cTLwV3wm1QkDtFNpW1tyFIlgUhDzLqE0ssP2aUL9?=
 =?us-ascii?Q?i1HOO5wPnz3xJYITrVpIy5ukNuUEHJCskE2Bzeb4vwl6uwZ9aEKsQbCqvy4Y?=
 =?us-ascii?Q?vSerrLIrp1Y1u3cgazkk7IwSXW1nEAvp/zbMpNoHpeDFAgGzARtkyM7VuK15?=
 =?us-ascii?Q?MvHRuBQaMw1Yqh7kTNoSGgI+j+NV1cHdS79mBd66m5dMs6/qjf2bhaNPvx+J?=
 =?us-ascii?Q?wecRNpv1QXUb6bXGAB/kANbBoHHnPUww4jThp2nYZ6Q6WZynh65pQCDJZ65D?=
 =?us-ascii?Q?U4ijzbyyCqBFId9zskr1Hx7RutJABGlSbyiSqOoJzmrcjzIDSGhp2J/uB3pG?=
 =?us-ascii?Q?+wJXoGfAZVK7+BWcqvvPyvOrD2rFxmh7cK50ZBJEyIClcf+PoCSQCjFlUx4t?=
 =?us-ascii?Q?NV+dMKogjFqbmw79f8f3sOE/Or6oI8iCPLRIOc6fu0sBL2TcKah+DTu24kN8?=
 =?us-ascii?Q?qNMWV5jQUySZH2CdISftq0AKQ7DNX0CNstfzm2UWLBYK7Ag4n5A/O5t6nLYz?=
 =?us-ascii?Q?tMRxZZHSPCXtfEyq5LrUpXt7wCV5as1+IhKSTtaHDzuUPt1J4Zyrp0W0nP3B?=
 =?us-ascii?Q?knvgLbKkcp+lQoyrtf0I5qqRLUWeRf1sYdu3PAbVk4e9Qp3f9hwnJUjVhN02?=
 =?us-ascii?Q?BiGEgoK3T9pw1x/TSRQm5g64+2aFdizzuWbaqo5k8TUEHGoikutAZXwVsx6c?=
 =?us-ascii?Q?W/byC9fpBXyV/xixIbJGtuKFRKevEZZKGVxBJWlFZzmM86Vesvc34sXKnpiw?=
 =?us-ascii?Q?cDJeLubluk5TLKuRmYpZZVMNDS2U4AJKRwGIvMfNXhzpMz0Co92d9qx1J/il?=
 =?us-ascii?Q?JxwvstC9eBC+AixkCz04fxcCMWh9wIvEsSEbvtbYlfILYuAXuXDxZvgebjqM?=
 =?us-ascii?Q?u3lCFaAnGGnjTLfO1JCpbo5ESxYmrzptfXn1Bl3Ca5Hb9PVD/+A13yCxrlJf?=
 =?us-ascii?Q?Q1s+Wm+gmWhttfDLVKCync9co32JQ1UjvxKbh18iOUAjEJiNdk3xSRId4n3t?=
 =?us-ascii?Q?DV4Dp0RHYkPJcreV6OjQ/ER11W+5ZUYbD4WaF67Zkgb3t7mNFwXXAm0UdUQH?=
 =?us-ascii?Q?vIY+JIDoNGaU7iyBlJ4jT7dnhE5z2kgKSZ68bBXcSzCnBt+Ozoybb8GPrVSs?=
 =?us-ascii?Q?7umLtZcfPnNZlkc94HdBowJMx5j8+zfs9IkTmFsD+v1bxs4RzhNZsyrR4Zma?=
 =?us-ascii?Q?qfqBJT26pjgi/rk0zaPytU+QE0Z34t32Ppx3WdvmgHNeVb5ZBsL+iIc2NUKX?=
 =?us-ascii?Q?yPZqeVFnVjynazTpMXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df53d654-f1c0-40f9-c010-08dd861ee5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 06:35:41.6664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZrOc+eeQk6mTSetC6rdir7DNQNdxtgaSraK9eIp0uUNj0IFJlmtg4DejNMa3HMUgmo2cwmgS5NBA+iuPwiNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 28, 2025 10:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; kernel test robot <lkp@i=
ntel.com>
Subject: [PATCH] drm/amdgpu: Fix comment style

Fix code comment style

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504271826.xy2fFO28-lkp@int=
el.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 17f0911ee7e9..82013b495436 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2165,7 +2165,7 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct =
amdgpu_device *adev)
        /* Fatal error events are handled on host side */
        if (amdgpu_sriov_vf(adev))
                return;
-       /**
+       /*
         * If the current interrupt is caused by a non-fatal RAS error, ski=
p
         * check for fatal error. For fatal errors, FED status of all devic=
es
         * in XGMI hive gets set when the first device gets fatal error
--
2.25.1

