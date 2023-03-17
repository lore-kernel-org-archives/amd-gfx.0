Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61296C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 10:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB77C10EECB;
	Fri, 17 Mar 2023 10:50:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAFF10EECB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 10:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDu9ijX22925wWx/lmfEOfEp2FnlACSWYF/l8QM77XkF6P1r0rKeAlsKf/DiM/3szAlFwHHaSV/bRJSN+wTwdYih4Qvq9/E/qS/NuRpRTV/1SyhZYzX1Dp2Jb++uftodgqm+4B/h6ONqTMis8fgsRkCQVMmvwNC/i0A78Cyl5u87Y077bSx7whGQgWadurtG3Xn5WY/k+UR5yj6mep10sQvvXRG4mpOWVkObBfOSZLOysCbgS8yTZHe/xZ70e4ziJ6gl9yUwzE8n3MdAnoag19MHqOR6FVKFKDnZly47boCNJfFCHAemQ+w8Pr6cN8oRKM2515Eor+2LYCcPpfTcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/MimAXFsMj9ZGH5yZ7bZdCEyg/MMHGMPjMAoK7oO6w=;
 b=MkOnJLKNQEH2Zqf6jRtmTAnW9layybFPIgOOnNqpccA0kwqItC/8VtoZj5/iTcrwojrV+z/0CN6Q7EuAz7hlNazsj7NRlYKrpEOGUM8A7Cb2OKRX6K/9l4IYDXQonZtN8lUlOQG9cHsIuUIA9tptoCH9iTDV1olGWANtsl7NCn5y6eUCoNI1s1sBBl/vksSMENecVhU7f/LmNr+GSZosE0uyvwdDD7Gu6Zbk4xZxFlUr2rkHgvQLQQzik0i+e+hlwWa1ItXCfP9HTuz23TGwl+4hpS4292ZtDknHi/F/lCNg0C4MpGl6jd/cQSz4h2O9es8YlKYXRoxVXSZIGlqn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/MimAXFsMj9ZGH5yZ7bZdCEyg/MMHGMPjMAoK7oO6w=;
 b=yTmviUjxNO9Qrj0CHrjCuQECVr35QJu3/AH6SePe5s7Zz22vdpm9IjRxxczxJdNoxV8/5goEWG7YJMOjyy1hdmMLwI2WLeKkI9uzYMPXOa41MSIXWv5q2GqSAU4bXatDaC2klWto5cJTuL1sOedKSyhrbiPiQbPvcgw3LsfK5KA=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 10:49:55 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::b043:d740:d48e:26d3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::b043:d740:d48e:26d3%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:49:54 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Bill" <Bill.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Adding CAP firmware initialization
Thread-Topic: [PATCH] drm/amdgpu: Adding CAP firmware initialization
Thread-Index: AQHZV+J5d4+hdjvqt0yNHDDcOZU5+a7+zJCg
Date: Fri, 17 Mar 2023 10:49:54 +0000
Message-ID: <BL1PR12MB5269ADB0CB495EC7CE70E34484BD9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20230316083626.248647-1-Bill.Liu@amd.com>
In-Reply-To: <20230316083626.248647-1-Bill.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-17T10:49:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=089c1e9f-1d90-4531-9998-e0ff27f74ac3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-17T10:49:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8f54db37-0d4a-47e4-9b82-45b193db9705
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|CH3PR12MB9025:EE_
x-ms-office365-filtering-correlation-id: 5fbbfd95-03a9-43ae-2a6c-08db26d557e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUC3fxGJ4mR2w2++kRL6YEkGYV3SfT+00tVWHPt8Xi2LfcEcqbh/iK/xVLoFZTXotnKleyS4k7nVMUkcAjkE/pt42ouThZvVs76rjeDKxrGvn6VWAteLcJvL7ZPggS6v8ACMRbFWsr6ciWEDTW4Myk9jxU0IZ/GtE/5AiLycTAXKm8+1aJSJL4hczGKRofAu12Pjfr+xfS+WiuC0gltemezE/xrF2rBFTu8+3DVuNsOtokq+qKysT18JnguvOVwL1GsqTsVa5LpTD0m6oROdy3AGYoAkO1/AiTpE8nocnqZ2Ph4VyECkKScz/fo0vtG3w0enmNitFlLNrgy4ocOxRA8VKaiVJ5WkFoHXLEV8Ao9C3vTzLaCcO37tmnRk7frYcXX5h1b7omNf2HeF7xx3fVhwg0efiVkTq8ge+mlsQnjTqD1upwgYA3q9il3mEmjpQNsU/buXZtyuNKJz9/JO0SiuwSbpkJW7B1kp+Wgke1JF2PCXDPE50iMI+exsV+zkSq+uM/JdZMmjSSqwzuXZPVM5kBfQjXm1DzrDSqcwQo+iPhXjqy5vfaCHho3WTiwnYm1FYeVSRkTs65lKVSCwzokkex7yu+at0MSBUrW1N3Io4AfG0GEGM6RalzvIL3exp2rpMPqNPgAe5aP/YWoXq7FLflcO97oQTLVcRb57v3AJEKOJHTFDrc2DhmcBWWKR2ci+7WdYhFvcqDPPPVYMjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199018)(38070700005)(7696005)(71200400001)(316002)(478600001)(86362001)(41300700001)(52536014)(5660300002)(66556008)(110136005)(2906002)(8936002)(54906003)(66946007)(64756008)(66446008)(4326008)(8676002)(76116006)(6636002)(6506007)(122000001)(55016003)(33656002)(66476007)(38100700002)(26005)(53546011)(186003)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eWtyalpEUmdIMWZoWFV4SUFiczM1a2cxVHVuZ3RjOXc0MTBRTmc1ZXc3?=
 =?iso-2022-jp?B?Zm5paU5ucjJCb0JmK0FIOFA0N3pNT21Fa2E2MFV4LzFsVnBoNjUveUh3?=
 =?iso-2022-jp?B?YVIrMFBWdDJrbmh5SlRyK1ZDZXB2b2xqcVZMSC9McEg3amFhTXFvQ1RJ?=
 =?iso-2022-jp?B?UG0wTnlMOXBndjZUOStkUnI2VXpWY1hEM0gxVzBUdERaTUY2MzArbUNS?=
 =?iso-2022-jp?B?N1RiRGR5ejV2aUZqRzF4ZGEyUzFiNGV1VHhtcmgxV0dvQmlmbEw1OUE1?=
 =?iso-2022-jp?B?a1RvRjd1RkcxSWpQejNwc3VkSm9ZQjRXckRwS29QTDBXM0lCQ1cxa3dt?=
 =?iso-2022-jp?B?Q3c0RW5rWk51aUZCVmU2Y3BBZlBPQzZ0VVpoc2RVdk9GOE9NdlNIMjRp?=
 =?iso-2022-jp?B?ek1IQVpMOHJHTXJlYlFad29iUzUwcUx2NFFFbnRVV09DRWNEUnNSdHMz?=
 =?iso-2022-jp?B?WHVSYnA3NnJLV1JXNTBHUzRVRVAwMXhkbW51M29sVktSVzAyU3NoQmdN?=
 =?iso-2022-jp?B?VENWaWV2OEhNaDVTaXJRR0pwWDlDZFB5djZBYldSdlBidGJPRU5uUThU?=
 =?iso-2022-jp?B?YU1yS0xZV3hiWWRMa1ZSUEdRWWgwSy9RLy9ZVU55cjZCeG56YURlSHQ2?=
 =?iso-2022-jp?B?bmZ3QkJoYmNWS2QrRTdINUlOYVU3Q29lcWFnQjZ5cFloZWRuZFNsaVk1?=
 =?iso-2022-jp?B?aHo4dUtxRWZ3eWZOeUo2QkpYcjFkS0FyZWd3SFFCUjZRdE5RM3FVVW04?=
 =?iso-2022-jp?B?aW1xRk1JWEtuSjIraXpVdlpOczBic2JMM0tZSlZGNTBxSnZKeTJvbDNr?=
 =?iso-2022-jp?B?ZUFTTGs4dHVXeHhWRXN2bmNCM3hrWmZFSUhWNzVqQmIrRVhQYWhQSmVh?=
 =?iso-2022-jp?B?MVRNdTcvRWdENGVxVTlCdWVxakVrSU9LQjRqNjRpY3RwSWJjRnBYRVQ1?=
 =?iso-2022-jp?B?bVJxTkxGdGZOOXQ2elgvTVN1N244N2JET0NyODV2MnRwZjNRU2dESitt?=
 =?iso-2022-jp?B?ZmRiZEVvcHdSRFVDZW90V2ZhWWlvY3FBa01ZdEZhdmY5eDk1c3dacEZ1?=
 =?iso-2022-jp?B?SWkvNWpqS2l5ZGRFV1lMOFc5T2JlYmFOa0hiNXV3b1F3elUzTjdmaWFJ?=
 =?iso-2022-jp?B?blh5SWtMcFZRcm9QUmR5V2U2NDZCWW5uNkg1N3cwT3VycmprUElaaGps?=
 =?iso-2022-jp?B?YU1wS0RZZ21aVGRCMS9ZZmhnZVd0TjEwM2JqYktOVW85MWMvdWlBUWtZ?=
 =?iso-2022-jp?B?bVZCdVI5eHovdGkycGZTc1J0MEFISktLR0srVXRKeXZYNnhSTVUzRHVH?=
 =?iso-2022-jp?B?L0syM2Z1ZGxiWVhoa2psUVQrQzNSRXFxUlowT2MrdVBRc3dmUk0wRHFP?=
 =?iso-2022-jp?B?N2xjWXhVUk1hemtrTS9TMzJXSGJycnZoYW42KzlpdDNEblA4bWNEY09S?=
 =?iso-2022-jp?B?VjVEVFk1WDNtOXpyeVdkR0ozdVVTc2g0WXBMQTQvTzV5OG1RQnNHNis4?=
 =?iso-2022-jp?B?SERmR3RFSy9HSEhOTThtTDMweFFDU3hsOHZ5dDM4SzZjU2t1RVpoZHhB?=
 =?iso-2022-jp?B?bjhTdkJVVnFrbDN4czFjcUNRQUovSkw5QzdTMlkwU0JQVUFscmRnd0U0?=
 =?iso-2022-jp?B?T3BVQTFaa2lTajI4VFdDSzJXZlNhWXZrcHlOYXZsVy93QXZtZVpJTTQw?=
 =?iso-2022-jp?B?emRjNm1ENGFnZ0t2V1IreWxUYXRxbld6UExpblBmYnRzRklFa0c5Yis4?=
 =?iso-2022-jp?B?RG91SWQ1dFBUVk0zSi9rdEhxYXQ1aFVtejNkRmlPRnJPVjJVR3hKU2sy?=
 =?iso-2022-jp?B?Q0VRRUNYZEVETmFzT0dTdGJqMDgrTFc0d1dPbE9sTFhJTllrQlVpaTMw?=
 =?iso-2022-jp?B?bExtTFRGWGdNK2ozMm43ZEFEcWd5aGZxQkY4VjZVdlY4RHlacVRHemJW?=
 =?iso-2022-jp?B?NVZuYVVwZWRmKzNRMmJTTkdKdjV0R1FycDFCSm10cHhpTW9HUzVST0lS?=
 =?iso-2022-jp?B?VFo0QVc5Q2k5VXNlR2xiQkhCYnk1a3Z5RkVoSXJ0MG1KbGx1dmtCRm05?=
 =?iso-2022-jp?B?TEhvVVVEM0U3Q3JicitpTUJIbWlWeGhlcHhmNTVQUGVGVVJsNDgxblVP?=
 =?iso-2022-jp?B?SERGM1lMTytNdHBUTGNTOFE0Y3N3emlwRFJqakIrTjZRNGcycDlCd2Vw?=
 =?iso-2022-jp?B?WlVZQXgwOHU0dnN3SFQ5UmZCTzdUckIrMjlqb0VNOUJWQU9iNVRGYk10?=
 =?iso-2022-jp?B?S1doSThPakgxa3g3Sm82aTBTTDlpT0ptRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbbfd95-03a9-43ae-2a6c-08db26d557e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:49:54.7557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlsJ7PkXadbP6zMCXX706n51jlx29Lh2LMjnUm7rMsUamsejbf4bSWKieXaQF87k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Liu, Bill" <Bill.Liu@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks=20
-------------------------------------------------------------------
Monk Liu | Cloud GPU & Virtualization Software | AMD
-------------------------------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bill Liu
Sent: 2023=1B$BG/=1B(B3=1B$B7n=1B(B16=1B$BF|=1B(B 16:36
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Liu, Bill <Bill.Liu@amd.com>; Chang=
, HaiJun <HaiJun.Chang@amd.com>
Subject: [PATCH] drm/amdgpu: Adding CAP firmware initialization

Added CAP firmware initialization for PSP v13.0.10 under psp_init_sriov_mic=
rocode

Signed-off-by: Bill Liu <Bill.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 02f948adae72..0b9e99c35a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -148,6 +148,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
 		break;
 	case IP_VERSION(13, 0, 10):
 		adev->virt.autoload_ucode_id =3D AMDGPU_UCODE_ID_CP_MES1_DATA;
+		ret =3D psp_init_cap_microcode(psp, ucode_prefix);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 380b89114341..b59c92037375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -669,6 +669,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucod=
e_id)
 		return "VCN1_RAM";
 	case AMDGPU_UCODE_ID_DMCUB:
 		return "DMCUB";
+	case AMDGPU_UCODE_ID_CAP:
+		return "CAP";
 	default:
 		return "UNKNOWN UCODE";
 	}
--=20
2.34.1
