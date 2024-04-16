Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB7FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 06:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D25112A58;
	Tue, 16 Apr 2024 06:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mL3Oe0Rx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320D3112A58
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib+oj6wzaOlAmt+kqpoKD7oIb2nip0wMRY4sl8IdKpbJdD1xPrUr6P5P8yQl+G0x8+gRsOmCR9XCWin5w6R8cL8aEr9IS0ZgOnSs7AXCx37HQI8wrob74YwA/3ZsHwZpfKsAbyls8XcWVua2DD7yBdcxQWQizqwL8BV+mKn0FgKHDehUAcZ0drwtbi55x2qL73qZjl2BKv4NNQyHQ/jVxiAn0GwQ0AWY61W28e1UuOm4Optq5BbU49d6Xu1Cg+JcG3DE3BoZ3unUOiWhI517pN/eV4sPUXjkhMNORmcqHnWcEmlR3igct3hdOa33o7Emnfkh4pvsI10iZibaZCnP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q15pZcqIQy5oCZQgkSez861AWuX61oLOxWDIZAo2fWY=;
 b=T2q/PrVXRCKL8kxlxWf4kk3cLn/v4Ft/njFHLrjbNZkprv5P/cZx22WkOWDE2DJAFgJs0j0PAJkjHeiVbMae5mesEoCBxZgPq2ekA9twSn1K55lWmUMpRQgCCwHPa0/GxGJjTMsEoaWepvuLuuRgeaQUFi7T0kwZDdLVZKhxqrhVTe9Z6wBo8sTe428YRpcL4a4Wsj3NGaANePSTFJDy3wEw0i8foL8Yefd9hsFWo0RxbMZ7Fzm+XGvD0y8dskwJ7Zpv0Kc0h6fUYQ5dLKLPY5ongoC969pp81Sa2hbosz++UmKE7OIcWyXE1WmRd+C1fWQCyHhjIYfZ0wy2RTXLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q15pZcqIQy5oCZQgkSez861AWuX61oLOxWDIZAo2fWY=;
 b=mL3Oe0RxmhbsV/ZiVgMwDE5GisQPmwcPtSmvKRz6wy/62G7vYoP9XNRX0IQXWlbeYeRDQ6jJkoX4sFa09armuOA22xWoXl0eQV0tfl6ZjW3dGTJfp5Q4+B6swq2Nk7qM82y6dnpA+pu6Ce49pSqcz5w4Y4wUyE4Zj+sfgFab/hU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 06:24:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:24:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Index: AQHaj8Wmxj6W3LaZ00uZHqibIoQNdLFqbb7A
Date: Tue, 16 Apr 2024 06:24:15 +0000
Message-ID: <DS0PR12MB7804392670933AF4F1AEDB6297082@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240416061625.2557-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240416061625.2557-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cd8467a2-65be-4eec-a9b4-34611cedf248;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-16T06:24:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB9147:EE_
x-ms-office365-filtering-correlation-id: 527c4e95-4ed2-4f17-0a28-08dc5dddd71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMUEYpWpRPJ7a/pPsS/jV8TxzM+kMXmg0NSHjWIQif4IE1/BqDbZMRmMDORVnAmYdWeNd/31eq8oyTSI9lgIXKs0jpGE2B6zl//zK6lV4toLyHUjHWoxS6aufLbCDSahpEgv+DkEqubBwm8JrUbfEDuMEuu6gVxfb0E/7vk2KAR597vlv21u02/eQaNRO4knJR2d8Td+zayRXHJQqt78LKzAVbGHivISRnzHTaMOmV4gYC2WLRtzTwLJXYa22wWIPWwaPAvjG0wudNOLtmJp0cmMafc3YEUwjpJgJrVggh5lqJKEM17Dmz8eFvYGDbs6v9N5j7c7/Xa+LhmSI0WWJRtobc1Xxz9ac+/3osghKom+FnPN7/1Whqmhke3Gsemar2s1znInyeEIyaVOaBDFvcRrfv/fIA3tN+SBUY/xsCYWovmY02NkRbfsxISZMLVkvSu0kjlvjYgHrJezcwnJhLTyU+4REp3Q/KdS+SB3N6nq/ochzU14hkGvhQhgQnFFWJKZdF8PQBkc3g9KtRe0NAxU6mYO4mugOavyRGQmnW/vGp5I5Nbhv4+iJcCUxIS4RUYoHeu55qEYumURqLX1Va2VyDRIwwwTp5zRMcXBkWx1MxBUxKhOLLnAkzwmigqTS1wuuju5DI/czan2MAjvfXvlyu9d7s3S0opYeqgDWJK9z2Gj96A4f+eCmWXktf45OI0lkC25pNdRg3Qg43t+TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DbE3DFqBdv3C8ILrozUEKv1e0KvvPtQv4mzytiVrhc1kWpWwOR+YWNTttC0j?=
 =?us-ascii?Q?MEnhr6yeXN/StJ8iHjYEAD15oPrFCEP4gQPLyB88SbqINwLoh2+VSaNjQeyi?=
 =?us-ascii?Q?Mi9YGO60V6B+etYwbHvErjsJCdc2UtMgDA9qqRq/7gS4FJm0SkazbWDSk0fD?=
 =?us-ascii?Q?FlI/wrEm+irkJ8Dda66b0Zk1bAxoWIMM3Ia0XcxoqS8FK0ogFRv4gU7/kFdE?=
 =?us-ascii?Q?vmNNZCKRGuSarObO2SCgbNcK6rddnwUvu2TMc8zh/tX4NpBTRK4rbM6Xgwhl?=
 =?us-ascii?Q?ivien4psUbeH8fOHTbRisTnWwk0sINjBJqV9xG7Ttx4EV3/QBnK58FpHjowo?=
 =?us-ascii?Q?Ais5xH8Oea6tnsleuPd9L5JMbohK/+qzhouyVteUL6XYIYj3rdzBgg14n/3I?=
 =?us-ascii?Q?me+Uc0+Acoxf3tsoanL/oO8S04Qj97pSLME931+lCMcJ42v0GVhCXWUJ3bnT?=
 =?us-ascii?Q?1u/5VTU025me75K4we3UFwQV75AxPQwpiooh+IGxmb+YFxiBoB7Vos10+00A?=
 =?us-ascii?Q?dkQtpQMvpWPxQLaDKl/ebRC7xcUN7qmuTD4xQLy6EdHhHcvViAQSvp/mJuay?=
 =?us-ascii?Q?C9OLjopxR3ELzQAcwCjJD1hyvGPDqXSr45FGMDKQOdtFS5cUVU5XqpJD3UFh?=
 =?us-ascii?Q?Dkn8DgWAUF9cvbGzmfig+rOOjIUILTqVXy3rvZyK+cyGkCF3vC9NVBnNhMQd?=
 =?us-ascii?Q?31QWnP4FhKAp+2Rd7tu+DWBvcf5UWKxi3UX1WgXGCNCYD7qpIiaBxhMiFlFE?=
 =?us-ascii?Q?4HYfWyf4MD/DghBKusAiU/HLApUPjNkLdl5N7y42ZxD51ntVIb6//6ZF1ft0?=
 =?us-ascii?Q?qKi/QWyEYnhJ374reoXtKRiATnHRzblWIATfS0uMciuo93sDt5c1vhyyfdyO?=
 =?us-ascii?Q?EoTqj/tVNGElMrN3P8M2gEzWIP5H6rpKLfGmSknVTsEX/SaIJ05fb6ZkpHhl?=
 =?us-ascii?Q?TSCQAySpsod4hTbgFrXZ2U0CbBHdxXicdFc15FNN7DplN52+CDAzg9cdaBQy?=
 =?us-ascii?Q?Wy6GEJtHAfz4iiC7qymdaURb+uHBtGPdq8VG1ejBgDrSRUNtCLFzez55GKlC?=
 =?us-ascii?Q?4eZwrZ2huIO9OInipVwtIfL1Tj/jxNDNIpVHZrj9clFWOLYMDZcTbKom/UkJ?=
 =?us-ascii?Q?lLvolJSzruuNjdehZ2i4wwXuoo5hGqIe65A+LyJ+8xz2ftlwbQHos5kYYU6Q?=
 =?us-ascii?Q?Dp85DzICYkJYAWQhLz1ZiXQ7dgOc5y25dgRtZRVgsImk+YlC56kMOAdyFpL8?=
 =?us-ascii?Q?cTEECYwLXWtz/XCiSyjFkROqnyxiPdPnaPWJIrSwBEWoq7rwAVy9q67+HhIQ?=
 =?us-ascii?Q?NYGCHfqF92KAjt01JBA8tfqmdw2wj/ziBbf9sL0a2ToJSSC+wmSEFSLj48cG?=
 =?us-ascii?Q?3AfbNjk1+gbZJY2Q2CDEJ9E+GziWmivu/JylxIb0+NqjygTADk5dkjuZ8OQG?=
 =?us-ascii?Q?CiDkucZYFLen+hRj1JgEE6sheZpoG8LnHMhMwlQPwfRHNIuCqfyOJ9N2Ll4B?=
 =?us-ascii?Q?gLbV6XVNuvXAejg4a0QCPdh7KxbdtBvoAAFbwb7Fx/6K2qVRbTlAXk209eEx?=
 =?us-ascii?Q?P2NTugXWz9hJM0jY+s4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527c4e95-4ed2-4f17-0a28-08dc5dddd71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:24:15.7567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiDdXM1JROS3It/PyayXpbwyE6w3BewWo3hpMRXyxSzs4Ba/+khgsIZUZyfQ5Asp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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

[Public]

Is this applicable for aldebaran also?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Tuesday, April 16, 2024 11:46 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison

mode-2 reset is the only reliable method that can get GC/SDMA back when poi=
son is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..c3beb872adf8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
        enum amdgpu_ras_block block =3D 0;
-       int old_poison, ret =3D -EINVAL;
+       int old_poison;
        uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
        case SOC15_IH_CLIENTID_SE2SH:
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        case SOC15_IH_CLIENTID_VMC:
        case SOC15_IH_CLIENTID_VMC1:
-               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__MMHUB;
-               if (ret)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -184,22 +180,15 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
                reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
-               break;
+               dev_warn(dev->adev->dev,
+                        "client %d does not support poison consumption\n",=
 client_id);
+               return;
        }

        kfd_signal_poison_consumed_event(dev, pasid);

-       /* resetting queue passes, do page retirement without gpu reset
-        * resetting queue fails, fallback to gpu reset solution
-        */
-       if (!ret)
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
-                       client_id);
-       else
-               dev_warn(dev->adev->dev,
-                       "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
-                       client_id);
+       dev_warn(dev->adev->dev,
+                "poison is consumed by client %d, kick off gpu reset flow\=
n",
+client_id);

        amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);  }
--
2.17.1

