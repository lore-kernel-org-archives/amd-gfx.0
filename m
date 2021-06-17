Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A7C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC4C610A3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC4C610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611216E8B7;
	Thu, 17 Jun 2021 08:27:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F06A6E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGmDy62uf7NVs5w+fdwbvLp1z04BLMr+Ii9mc0NiMYZ96IizeYENTjOEE/JK8BrR/esWLXMH8gTUiky1NC6o3zB2ys+VSuAiuvmml8HXRuh0YoYPITyxj/+ILyJZnsTrneWbB1Gy47AX3RrZt2raZlXqe85mSXCXW7HhLI9cn/hoirKWZWmFGUiC05HTB0hUqGA5cnZi3EXGwJ3Qi7df4RheWifwkeFUiyHm3aMuX8lBPDP/5kS9J0Kvd7aioTSTSB1bKkNEEvXZf7GwXngv72NczoRG/sE2JLoGIozFpsSCH3MDNn1H46hNwLdsC1nt3YIpqpJVTiJZl1cMVH3gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oxalSPMfCFqKqu8M/F5AAPKyfKUb6cqfueh6/p9d2Y=;
 b=FNpxSrkB2xOv9je4ghDXH5zEHykgjwKGXBPo3OFE/lUXRCnFA1PlFA5C7Aali1l0gddWuZkaQKWXqa/9Bn7GYZhDIb21RMd/bMTnwum5DcRlWg8vjEpI9bK0vdSAeG643IX3ryAzYTdLGDAO/g3JZk5nMHC1SbeTh68uikGYLnbQXBHePgTIVpyoOPuf7SwcpGYq5U6i8BfWVYXrEKOekTGJf3UWhuGUmCA/Bvk3dXsPbJIbRjxDqgp85yuLgiz1Zk8mvL8fVyqFXYv400RL8WrXu+H+p5aGyrUIeMnK28ePkfSui7MPgcNSzRdIOfyq83XCyG3Xjo7eL0v48SJTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oxalSPMfCFqKqu8M/F5AAPKyfKUb6cqfueh6/p9d2Y=;
 b=bCJYwM/vNjvHvbIwHbZLo3D2etBryShO6a8k5fco4+lb+zdMtIvnwuwjvuazc/EMkwyMXXRoDpFfIwSXAJuN6FlKBWAdf9cvWZQrF/v31A8r8jnI0i4EVL6CUI00ybFKxFk3INSQ9IzGT4PqAJxpkSgkPIUY23Uu8XPAMLYWHuM=
Received: from BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 08:27:13 +0000
Received: from BL1PR12MB5109.namprd12.prod.outlook.com
 ([fe80::1c7b:e1ef:3b40:1f2e]) by BL1PR12MB5109.namprd12.prod.outlook.com
 ([fe80::1c7b:e1ef:3b40:1f2e%8]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 08:27:13 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Zha, YiFan(Even)"
 <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Topic: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Thread-Index: AQHXXq+b7Jar5Vd6Pk+bN9IN0p8euKsOojAAgAlE0qA=
Date: Thu, 17 Jun 2021 08:27:12 +0000
Message-ID: <BL1PR12MB510987B9A55B85CDC01AF11DBB0E9@BL1PR12MB5109.namprd12.prod.outlook.com>
References: <20210611104911.121779-1-Yifan.Zha@amd.com>
 <BN6PR12MB12678718C338B8926AE98503B7349@BN6PR12MB1267.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB12678718C338B8926AE98503B7349@BN6PR12MB1267.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3f1c902c-e6fd-4d8b-bae5-8b3b220e85cc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-11T10:50:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d70e584-049f-4f94-3a11-08d93169b547
x-ms-traffictypediagnostic: BL1PR12MB5191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB519169A64868BF140192B3BDBB0E9@BL1PR12MB5191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RoUAfE2bdBGxb47K5lTfzZWsIjDL7m9pg+8FkPmuPBHLTC9tcAvokU6DEy807S9qs5agJboNclHniBYQwFZ/s6+ZvJBXO+VhFKgTPKzZ3BvvlvuDoMWSSVUM1TpqHhHxv4lL+5TzshzbTeF95Jd8OMBCPz7ocgTzh1V8mG6G96drNYRp1pmT/sXzHKXDZej9Ci4WQTyHOHWd06tY1HkXmYTY6x0o+TnCIJjosyIjac02MjuXGA45oVGW2KNRn4U+7S8lpmRz7F9pHJGOI7AGtYDbjqMBLX3kSmisNTmiA2uKFTXSokjviqf7VCX597LUUg5wseoRN/rMVsD2EoP6oxJE4nhlyLtHbLElHSk09JnM8JdKX5Q9a9wZsw6ybNU/BRC8JxdraixzLEXu09mIZnfhAnKQ7DbNMc6P6F0pF5o2XjWlABEYtqdh3cg5zNKBcUqQyHTnsvf2+qvnlSJdq85iUqVlU2PfMDg7IKvizSmPQcsleqjPa0D72PxHFQn9Xs5QhQyhj1LMTaXUcFbdu9bAw6ZLlmBdu6btJ7KwmyEWkQ3Gqipmfe+CupycqJmpEg1EZ/OyaYCr0vGVTrE5Bev+DbJuYvgiVzrAL6VAAhF5cnuC5VNCFchDde5VxD/AJYoH0e+xYETvbBTxx9KVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(9686003)(38100700002)(71200400001)(64756008)(6506007)(76116006)(66476007)(66446008)(45080400002)(966005)(66556008)(66946007)(316002)(110136005)(7696005)(2906002)(4326008)(86362001)(5660300002)(52536014)(53546011)(8936002)(54906003)(8676002)(55016002)(83380400001)(186003)(26005)(15650500001)(478600001)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdESkEzeUVEYXdrYmJUMzdoLzVGZlBiNmxKWXU3K1R6dWhLMUFEcmpSR1NL?=
 =?utf-8?B?ZUdlVTZHZTNCeVZ4SUx5VjZKRWR2eW41V2ppRlZBMVVQRGsxRXNTRnI1TnBB?=
 =?utf-8?B?ZzJNakVFQzRPTDVaY0pDSFpodEJBOXAraDQwcHFUK3dEVDQ1ZmcxM2ZhbTdl?=
 =?utf-8?B?L0FWdTQ0aHlOMk03aUVTdnhGMTkvdFVsRGpXWElyS0Q3cHVBazZGaUE3THEy?=
 =?utf-8?B?SktIQnhjOGN2QUFYV01uWHF5c2M2aFJoU2psMitLZG01NlpyaTJlaFMzUW1m?=
 =?utf-8?B?ZktFK05hNkRTODljSVJtSXhEa3h6Z0w2RUpyNElsL3k0WDJRbzZBNHR1aHZ4?=
 =?utf-8?B?OFZHVFF2YnFYeWNkaVFJR3hBV2hpNHN2Vm5tYk4zc2lIR20wN3B3ZlZHVzVi?=
 =?utf-8?B?YVBzUzI0eVh1ZVQvUFBrQjNHY1hRZlhqUmdJb3QrZ0ZGMlhkZWZ2cU1VZFRx?=
 =?utf-8?B?WVRreDJZd2krSVY3M1ZyMW9KeVFIZFhGVUVyT3kxeVkxSktpSlJoM2txZ241?=
 =?utf-8?B?RjRxeVVSbWE4Wi9LRFZRYVFwdVowKzMwT1Q3VXBEOFFEM3ljSHJTQ0E2OGZu?=
 =?utf-8?B?SnROak9ra1g5K0x3cThnd2lYamhvQW5tczM0Mmc5R29JUWM5VkxhR0tLSnhn?=
 =?utf-8?B?UW1BMHl3Tlh1YlFXN2E3ZktNYitDYXpTczJ3MFZISjFzeU5xYWtjcHVzcGpD?=
 =?utf-8?B?YXhab0taY095cVZXL2tvNWNtc3ZRcUN4cS9mRWJEcUJZNlQ5S1Z0dFBYYUox?=
 =?utf-8?B?TlFkdHk3RXQ2cVlmMTV5RnhjYnN3dlNzK2QzdERRZjFJRTJiZmJqb2hIOThI?=
 =?utf-8?B?a1lYcW1tbFhkSXBUeVdqUzRiQXN4cW80djUzQTJvMkNlUUJWdExCTngxR29I?=
 =?utf-8?B?R1VOdk51V1NPc0pLR2hMa3N1ODV2NUxqUHRrSHRMQk5tQnpEYlg4MXAyTWhE?=
 =?utf-8?B?M1REdjRoUHNwbHVJaVo4SnFqZWcxNlJkamhtbmRXemRzZzJTazhnaW8rMmhE?=
 =?utf-8?B?encxNFI5UE94OTl3WTkraUt4ZWVtZzRXVHA4T2htUU81eU11Qmgyc3RjVW5Z?=
 =?utf-8?B?UkdoaWtXeWtJblZSZmxGVzdpdmh1b2pkM3Q2bEt4bDR2MWhVQ1ppQXdkOUds?=
 =?utf-8?B?RG5IdDBpK2RjUEdkQlZoNGZoUm52SC8rZUN1azNVTVJKYnlNMGptbWxnempo?=
 =?utf-8?B?cVRzN0dCZWVoRWhQSElpTnAxeUhDQjU4UEY1WlNXWUw2RkJYbjlhYlhBUkdD?=
 =?utf-8?B?SnFmTXY2MzVCcjFVMFBsZzNXd1JNcUFjWVJacGdmemVxM3BRNmJmWUtZbUla?=
 =?utf-8?B?YmtJblAzVUtJK1JiSlh0OVUwV09CbmxZeW9kVzVOeVNZd0dlYjRLOUJ1aVRk?=
 =?utf-8?B?a3VGT0E5M1RZeUFJMittWWlISFVzQVVrNFRUbVI5bzhZcWJuQXFMVnR4WHVJ?=
 =?utf-8?B?a2RQRlFCT0pVaTk4Um0xS2pCenM1ZFdaK1FaakdraDR5eTQ1K2pUZjBIUWlt?=
 =?utf-8?B?TWZkQTFIczBsOUJBTzE0eUphK1U4NHZPb2dDTTZNUmRZU1g4OWdjOVE0SHI4?=
 =?utf-8?B?R2FSNlRnYlFncjNhckZDbFhJTTZSM1p5bTUvWE1CZjE3TVJzd0hhTFU3ajhn?=
 =?utf-8?B?QWF0djVBamdKRU5DbW8yRFVKVmVzZFpPcFIwOGhHdXY2bk5TQjV3dmxZV1h4?=
 =?utf-8?B?SFIvTVhPQ2ZKS1JhUU5UMENnV3JWVHRhV2RqQjlPNlFxbkkvZmNKNmZSeEFr?=
 =?utf-8?Q?Rl+PJ+uDHHSydtN+mYPz3hW+7CrZ09mHqAFvjOy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d70e584-049f-4f94-3a11-08d93169b547
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 08:27:12.9270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdmp+KsgFs8LvXduepi7H4jqlNqg75IfZwUle/dSlCAlGCeUZHUMI5dkIGifEZrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Jack Zhang <Jack.Zhang1@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, JingWen
Sent: Friday, June 11, 2021 6:52 PM
To: Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zha, YiFan(Even) <Yifan.Zha@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov

[AMD Official Use Only]

[AMD Official Use Only]

Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Best Regards,
JingWen Chen

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Friday, June 11, 2021 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov

[Why]
sriov vf send unsupported SMU message lead to fail.

[How]
disable related messages in sriov.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..e1b019115e92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -80,10 +80,10 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
        MSG_MAP(SetAllowedFeaturesMaskHigh,     PPSMC_MSG_SetAllowedFeaturesMaskHigh,   0),
        MSG_MAP(EnableAllSmuFeatures,           PPSMC_MSG_EnableAllSmuFeatures,         0),
        MSG_MAP(DisableAllSmuFeatures,          PPSMC_MSG_DisableAllSmuFeatures,        0),
-       MSG_MAP(EnableSmuFeaturesLow,           PPSMC_MSG_EnableSmuFeaturesLow,         1),
-       MSG_MAP(EnableSmuFeaturesHigh,          PPSMC_MSG_EnableSmuFeaturesHigh,        1),
-       MSG_MAP(DisableSmuFeaturesLow,          PPSMC_MSG_DisableSmuFeaturesLow,        1),
-       MSG_MAP(DisableSmuFeaturesHigh,         PPSMC_MSG_DisableSmuFeaturesHigh,       1),
+       MSG_MAP(EnableSmuFeaturesLow,           PPSMC_MSG_EnableSmuFeaturesLow,         0),
+       MSG_MAP(EnableSmuFeaturesHigh,          PPSMC_MSG_EnableSmuFeaturesHigh,        0),
+       MSG_MAP(DisableSmuFeaturesLow,          PPSMC_MSG_DisableSmuFeaturesLow,        0),
+       MSG_MAP(DisableSmuFeaturesHigh,         PPSMC_MSG_DisableSmuFeaturesHigh,       0),
        MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetEnabledSmuFeaturesLow,     1),
        MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetEnabledSmuFeaturesHigh,    1),
        MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,              1),
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJack.Zhang1%40amd.com%7C217fd989e7324c61c37f08d92cc6eda6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637590055175617495%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BZQrUILQlHA3VmkwytrLKFP05FW8UUDFLR4XQFjxELs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
