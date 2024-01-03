Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CEDC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 12:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EEB10E2A1;
	Wed,  3 Jan 2024 12:28:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF10510E280
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 12:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUCPhtEy4H9pXd/wkmnLGMOwTgETZi4Q1cn8RohYtEkHdBgOtJZJ4VmTRG+Oql3t/i9nL7jXMw4KUCMtQ0jxF2n5isIQeaqZ/UZZjpRlDKH7FL7QHxagvPHFOo93LJWh/nK9jAuBpBagynDspWVzcpEAuq4lB9e3pfpLFdDgEw5KhyF8n8z3h97N1OmcYNSqCEEgyIAFStH9CiFnlieicxf7BOkB1eaITi9CmfmaZPvTcq4H8KExYJ4KIXr+dLrB/oMCsVNDCxo6MH/kai+Usz6zWYzCUJ4QnxKgSio+TyBJg0k2jUzLLr4NFivoILSEmOEQNiWRjhj5VXEbPgO/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znL6uQ8KlmT08KIJ476/IzmzThV1S+XmdWA61DGiUNk=;
 b=m2NG6QmemuPjp28+K9xfDJCmChLampmFSJXQs3uCj6K6FxuRRWrV/y9qJkaZZZnt12+ViHKy9cSmB6NSLC1jK1se9qWjn4NyFvUohQNNsKBIzk0BBMwcHgfctM+VnbMjV998Njq/QAZa2i1QXJbUzJqDN1sCysUveOAZ/GW81um5+8ccysGq0JtEWvNetlPMDVW0hfB9oIAVENonHYjNBqPOfoG7ZDqnqHcT1igg0ZlDI3DmYub/2l/usKM2OIcDeV7SyXzdomcY4rLUMi7kwVw6GyUYHzhmAEb6Y/AlnxKVtHpxi8DZRmmHnxHmj3Sar6zvjmarz/bRTbwaaCAtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znL6uQ8KlmT08KIJ476/IzmzThV1S+XmdWA61DGiUNk=;
 b=P6wUpJRZQ+fdY9gdswKY1v79EDzoKYAUp/XK4W5yHs780kcsscRVbFuADx/6DtGPh04habt7uvb9EX4ZvauzNv3b+VzyR7bmJBXKZzM+UL5RqKyjnKI+ijX0y3Csk1dW692iSylSqwHhm6GMMns/ljiQAFqcJ7yMpvpWAPcdNwY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 12:27:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 12:27:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework
Thread-Topic: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework
Thread-Index: AQHaPhtLgSrrHjiUrU+miRaE+NmfMrDH0lmAgAAslYCAAAE3wA==
Date: Wed, 3 Jan 2024 12:27:52 +0000
Message-ID: <PH7PR12MB59975D1C119B26AB2C51C0A28260A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-2-kevinyang.wang@amd.com>
 <BL1PR12MB52541DF0F27B2BD258A9FB79FC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
 <BN9PR12MB525798EAC8D30A4F6B39DC7BFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525798EAC8D30A4F6B39DC7BFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c75913d1-84e2-4042-836e-9a5fefd2b5d1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:39:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BN9PR12MB5340:EE_
x-ms-office365-filtering-correlation-id: f0342053-a228-46dd-4fa8-08dc0c57681f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jK7VzMScWdPS26IMksWWl5r7JDYQmW5UmT60IlgF+xnEXizoMpdeqSuBRr5NeFxx8UYPzvWsdV9FvIAk1ce9PKvKeNr0yFkSba3UsLXywPwiKIDjv0XQeiXa9n6SlgEgxGItQW+hjwOhYCPtmlSCYQLxBxgiElWkCXohq0JpA+lJmijkLWSoWw3rd4VFUGLpxg6GgIHhnKt3A+V3LLdq5ToPydOuyqP2GV3/bdkp6QOM/jjZm/id3ACtmr0LlO8hWotMU2eEs0VlOHmELoXlWJ1AYilEIU2Cq/RAZQJ3ezmvgDDIB4/n5e8AyqIdQzniE4omQIjC1+E2VKsOIoS3srwP3pyODghaVrIc/i7uLQICRdFCmiBcaCkqItCed5hqoa2P/5hSK88+ljhLQwvG5cWScoxOkgMS0nN64s92XjQZ4FOr+C6yAUhjZTYbUo4FGxZgO6Hdtv6S1CGIuIMPwPfwO27WFS1/A4Mmt1qM/2TNaKJgDP6rhSUvdrg+mCbVLn8+AY5pF+0TlNR7FOGkW6SdO3X7Yqn9YTeoOmFrLYp4CoZJPau+Yg/oNHQ5YHUB1xGd1HGpm8FGLla4rLR/qUDyaknXsJ51s1p6vAgQfzfqA67OlRy6+MyS6XA1ytGscNGPmBUXFH7/SoX7mhPtFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(7696005)(9686003)(6506007)(71200400001)(53546011)(30864003)(83380400001)(26005)(41300700001)(2906002)(64756008)(54906003)(4326008)(110136005)(5660300002)(76116006)(316002)(66476007)(8936002)(66946007)(66556008)(8676002)(66446008)(52536014)(38070700009)(38100700002)(122000001)(86362001)(33656002)(66899024)(55016003)(21314003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K1wtaXpvcCRpTLPcFJbmTBoKSL7EOSVTW76BzakS3pwapnHKDcu1aZsdwPvq?=
 =?us-ascii?Q?4Yshu6crcQEmnkD0LY5tLcwoqNWfMOcOzEy7lm1HF97duf+3CC4aOJc/6pFn?=
 =?us-ascii?Q?MyJmJMoAoPAr2Q68paQXEYivN5DYe4zAyUEbHxRTJQZsJgbfe1YiPS/3i6Sf?=
 =?us-ascii?Q?aksNCxqylac8i41OK2L845xV9MiaGfiXEQDPpmdab7BQqQLzTSShPpM19dwH?=
 =?us-ascii?Q?nIXXAYRsr2e94H1/7sELySlDKY0LmTSLJxsBuMpYubfTCBGg7b/XK2cJrZCc?=
 =?us-ascii?Q?EcO5rhgG7ovK7xyLt3tjMOvBYlL6QliEEbCxdTG0s7lGZ4tR/+I0KxazcDlZ?=
 =?us-ascii?Q?Qtvh462Z6cvIczGS0LRGxCpUEKcUZ8Jv78Gm+mlbySnIgaVh2zCd2pOaZ4bz?=
 =?us-ascii?Q?vIEzcjf4BP2VoGXz8JXam6wwAFF+IaLBznmsTBuFcqtRrPcIAhq52cd2WWdG?=
 =?us-ascii?Q?XV7JgfxMdu6FrcjffsLdJREs7WOx60mZmz9wcIujRGt7uY/CF8KZHvqcGwb7?=
 =?us-ascii?Q?UkBnplegmuqzRLnlAbvTWv/5DrU5NYlq2EGuwtKCZgmEykxAPMaPxEKtJScn?=
 =?us-ascii?Q?UVEgon6giui3+ZSWgNn0IaNatqBxcoxyN9WLUi2cWo4TZeLdTpHJ6DVUKfdh?=
 =?us-ascii?Q?OvKdBwnnzhYKdLRPR0E9wFDsbzDxf6MJJzpsD+9aNpmwigOfOF81xdRRUy9F?=
 =?us-ascii?Q?84cCrvExVDhNVLdphaSZdkJHcAXCVRYu4NDBZ+/NzNkjUKeiwIGsMXFkEyje?=
 =?us-ascii?Q?Ef/vJZN8K5mGCVS4+lS5UPxUR/7LedfaCxROnkgqpvhMu+UtSLdil0g/xMuk?=
 =?us-ascii?Q?dDNezhBvB2LBPiT+Fc97xrmtgSgRMcxckZyI1dvJX/kh2EXJYQIi9mR8Xidf?=
 =?us-ascii?Q?RFYzojAona1Yk2uYUpGw9qnbbeC7T9RTWRoMkkN+n0yKB/fMUbQOxwBg9Q5X?=
 =?us-ascii?Q?IjB9UgYmgVUlbHVTNHydptf1BhNBRClSDw+c8biEBT2p8F2lbUtPeRXOY6xq?=
 =?us-ascii?Q?r1I7KrGw9/dAF6+T26jiV6xcbbm2v0gZ3CLIm419YBerkTvwJfgsyH1eH7Ll?=
 =?us-ascii?Q?3izy5oDs0L3EvQnzgwvAuCU0YotPAzxjNE81bGrSIGBkGlSYTfofUlehCP9I?=
 =?us-ascii?Q?Yw5u26iVZt5Nc4GK9vcbGQukf6kCNacWNZlEGNjo2LgEwVfQW0vh4upS5cMA?=
 =?us-ascii?Q?kqF/vLk01aj1gQvE7gxqkZelCrPJkME2hZ560NTnGHOtboxIAIvJQP1SY/f+?=
 =?us-ascii?Q?H7kncn8kA7sdg9wqoBr28ogZvX0IeMaiL2UKFdWwNJbxCXeXqvi8tAPpKidX?=
 =?us-ascii?Q?WM9PyZjzlJE3Y6y5laNoFUdS90xcaRkBLDyYfrb5mfr69ZbfwB0OlLNIYPNS?=
 =?us-ascii?Q?+SLM5dsfje61MXEgAUCzDSHyaSj2cYYFgGNwJEF08LDwDPSUQvlTdhoHiYBe?=
 =?us-ascii?Q?CTtFfmw9AE2Eiwsn+ipcRgYTb/dhZUPGMtnaTz0M8mIBpCiajjhyS1s/Itnb?=
 =?us-ascii?Q?TK9KYKVW39+eSe/3C5mRQk2JtaTSIfcMQ0aeHd+G8xdQ9ACpxurzm5MWSBqe?=
 =?us-ascii?Q?PCM0edLBu36qXDEEcbk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59975D1C119B26AB2C51C0A28260APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0342053-a228-46dd-4fa8-08dc0c57681f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 12:27:52.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeqKDTDYYf+M56inPsVc2qnl4G1Lmb7YPM4ye0yYDoJ5uaH4NBFNjohodyUvejJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59975D1C119B26AB2C51C0A28260APH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Hawking,

+               if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D=
 0x00555600) {

It needs to be clarified that the above code is not used to distinguish bet=
ween APU and DGPU.
The real reason is that PMFW uses different versions in APU and DGPU althou=
gh its share the same smu ip version 13.0.6, and adding a version check is =
because the new PMFW uses another mca register to store error codes.

Best Regards,
Kevin

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 8:09 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework


[AMD Official Use Only - General]

+       case IP_VERSION(13, 0, 6):
+               if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D=
 0x00555600) {
+                       error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank=
->regs[ACA_REG_IDX_SYND]);
+                       return error_code & 0xff;

Btw, we will switch to ACA for APU as well, although it only covers a few d=
river managed IP blocks. This also reminds me that we really need a flag (i=
s_supported) in aca structure that gives us a chance to restrict the transi=
tion to discrete gpu first.

Regards,
Hawking

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Zhang, Hawking
Sent: Wednesday, January 3, 2024 17:29
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhou1, =
Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework


[AMD Official Use Only - General]

[AMD Official Use Only - General]

Please check my comments inline. I added index for each comment (9 in total=
) since it is a long thread...

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Chai, Thomas <YiPe=
ng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework

v1:
implement new RAS ACA driver code framework.

v2:
- rename aca_bank_set to aca_banks.
- rename aca_source_xxx to aca_handle_xxx

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    | 679 +++++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    | 196 ++++++
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
6 files changed, 887 insertions(+), 1 deletion(-)  create mode 100644 drive=
rs/gpu/drm/amd/amdgpu/amdgpu_aca.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 260e32ef7bae..4c989da4d2f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
+       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o

amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 616b6c911767..9fa6f69a58a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -107,6 +107,7 @@
#include "amdgpu_smuio.h"
#include "amdgpu_fdinfo.h"
#include "amdgpu_mca.h"
+#include "amdgpu_aca.h"
#include "amdgpu_ras.h"
#include "amdgpu_xcp.h"
#include "amdgpu_seq64.h"
@@ -1045,6 +1046,9 @@ struct amdgpu_device {
         /* MCA */
         struct amdgpu_mca               mca;

+       /* ACA */
+       struct amdgpu_aca               aca;
+
         struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
         uint32_t                        harvest_ip_mask;
         int                             num_ip_blocks;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
new file mode 100644
index 000000000000..6a6f167b5380
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -0,0 +1,679 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/list.h>
+#include "amdgpu.h"
+#include "amdgpu_aca.h"
+#include "amdgpu_ras.h"
+
+#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWIP_TYPE_##type] =3D
+{hwid, mcatype}
+
+typedef int bank_handler_t(struct aca_handle *handle, struct aca_bank
+*bank, enum aca_error_type type, void *data);
+
+struct aca_banks {
+       int nr_banks;
+       struct list_head list;
+};
+
+struct aca_hwip {
+       int hwid;
+       int mcatype;
+};
+
+static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_TYPE_COUNT] =3D {
+       ACA_BANK_HWID(SMU,      0x01,   0x01),
+       ACA_BANK_HWID(PCS_XGMI, 0x50,   0x00),
+       ACA_BANK_HWID(UMC,      0x96,   0x00),
+};
+
+static void aca_banks_init(struct aca_banks *banks) {
+       if (!banks)
+               return;
+
+       memset(banks, 0, sizeof(*banks));
+       INIT_LIST_HEAD(&banks->list);
+}
+
+static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank
+*bank) {
+       struct aca_bank_node *node;
+
+       if (!bank)
+               return -EINVAL;
+
+       node =3D kvzalloc(sizeof(*node), GFP_KERNEL);
+       if (!node)
+               return -ENOMEM;
+
+       memcpy(&node->bank, bank, sizeof(*bank));
+
+       INIT_LIST_HEAD(&node->node);
+       list_add_tail(&node->node, &banks->list);
+
+       banks->nr_banks++;
+
+       return 0;
+}
+
+static void aca_banks_release(struct aca_banks *banks) {
+       struct aca_bank_node *node, *tmp;
+
+       list_for_each_entry_safe(node, tmp, &banks->list, node) {
+               list_del(&node->node);
+               kvfree(node);
+       }
+}
+
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum
+aca_error_type type, u32 *count) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+
+       if (!count)
+               return -EINVAL;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_count)
+               return -EOPNOTSUPP;
+
+       return smu_funcs->get_valid_aca_count(adev, type, count); }
+
+static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
+                                      int start, int count,
+                                      struct aca_banks *banks)
+{
+       struct amdgpu_aca *aca =3D &adev->aca;
+       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
+       struct aca_bank bank;
+       int i, max_count, ret;
+
+       if (!count)
+               return 0;
+
+       if (!smu_funcs || !smu_funcs->get_valid_aca_bank)
+               return -EOPNOTSUPP;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               max_count =3D smu_funcs->max_ue_aca_count;

  1.  [Hawking]: %s/max_ue_aca_count/max_ue_count


+               break;
+       case ACA_ERROR_TYPE_CE:
+       case ACA_ERROR_TYPE_DEFERRED:
+               max_count =3D smu_funcs->max_ce_aca_count;

  1.  [Hawking]: %s/max_ce_aca_count/max_ce_count
  2.  [Hawking]: I'll suggest treating DEFERRED as default for now. (i.e., =
not supported yet)

+               break;
+       default:
+               return -EINVAL;
+       }
+
+       if (start + count >=3D max_count)
+               return -EINVAL;
+
+       count =3D min_t(int, count, max_count);
+       for (i =3D 0; i < count; i++) {
+               memset(&bank, 0, sizeof(bank));
+               ret =3D smu_funcs->get_valid_aca_bank(adev, type, start + i=
, &bank);
+               if (ret)
+                       return ret;
+
+               ret =3D aca_banks_add_bank(banks, &bank);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
+aca_hwip_type type) {
+
+       struct aca_hwip *hwip;
+       int hwid, mcatype;
+       u64 ipid;
+
+       if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
+               return -EINVAL;
+
+       hwip =3D &aca_hwid_mcatypes[type];
+       if (!hwip->hwid)
+               return false;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+
+       return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype; }
+
+static bool aca_bank_is_valid(struct aca_handle *handle, struct
+aca_bank *bank, enum aca_error_type type) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!aca_bank_hwip_is_matched(bank, handle->hwip))
+               return false;
+
+       if (!bank_ops->aca_bank_is_valid)
+               return true;

  1.  [Hawking]: does it apply to the case where the valid field is not ava=
ilable? Can you please elaborate why return true in such case?

+
+       return bank_ops->aca_bank_is_valid(handle, bank, type, handle->data=
);
+}
+
+static struct aca_bank_error *new_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       bank_error =3D kvzalloc(sizeof(*bank_error), GFP_KERNEL);
+       if (!bank_error)
+               return NULL;
+
+       INIT_LIST_HEAD(&bank_error->node);
+       memcpy(&bank_error->info, info, sizeof(*info));
+
+       mutex_lock(&aerr->lock);
+       list_add_tail(&bank_error->node, &aerr->list);
+       mutex_unlock(&aerr->lock);
+
+       return bank_error;
+}
+
+static struct aca_bank_error *find_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error =3D NULL;
+       struct aca_bank_info *tmp_info;
+       bool found =3D false;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry(bank_error, &aerr->list, node) {
+               tmp_info =3D &bank_error->info;
+               if (tmp_info->socket_id =3D=3D info->socket_id &&
+                   tmp_info->die_id =3D=3D info->die_id) {
+                       found =3D true;
+                       goto out_unlock;
+               }
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return found ? bank_error : NULL;
+}
+
+static void aca_bank_error_remove(struct aca_error *aerr, struct
+aca_bank_error *bank_error) {
+       if (!aerr || !bank_error)
+               return;
+
+       list_del(&bank_error->node);
+       aerr->nr_errors--;
+
+       kvfree(bank_error);
+}
+
+static struct aca_bank_error *get_bank_error(struct aca_error *aerr,
+struct aca_bank_info *info) {
+       struct aca_bank_error *bank_error;
+
+       if (!aerr || !info)
+               return NULL;
+
+       bank_error =3D find_bank_error(aerr, info);
+       if (bank_error)
+               return bank_error;
+
+       return new_bank_error(aerr, info);
+}
+
+static int aca_error_inc_count(struct aca_error *aerr, struct
+aca_bank_info *info, u64 count) {
+       struct aca_bank_error *bank_error;
+
+       if (!info)
+               return -EINVAL;
+
+       if (!count)
+               return 0;
+
+       bank_error =3D get_bank_error(aerr, info);
+       if (!bank_error)
+               return -ENOMEM;
+
+       bank_error->count +=3D count;
+
+       return 0;
+}
+
+static int aca_log_error_report(struct aca_handle *handle, enum aca_error_=
type type,
+                               struct aca_bank_report *report)
+{
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error *aerr;
+
+       if (!handle || !report)
+               return -EINVAL;
+
+       aerr =3D &error_cache->errors[type];
+       return aca_error_inc_count(aerr, &report->info, report->count); }
+

  1.  [Hawking]: Shall we merge the aca_error_inc_count with aca_log_error_=
report? if you haven't name any function as aca_log_error, then just rename=
 aca_log_error_report to aca_log_errors.

+static int aca_generate_bank_report(struct aca_handle *handle, struct aca_=
bank *bank,
+                                   enum aca_error_type type, struct aca_ba=
nk_report *report) {
+       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
+
+       if (!bank || !report)
+               return -EINVAL;
+
+       if (!bank_ops->aca_bank_generate_report)
+               return -EOPNOTSUPP;
+
+       memset(report, 0, sizeof(*report));
+       return bank_ops->aca_bank_generate_report(handle, bank, type,
+                                                 report, handle->data);
+}
+
+static int handler_aca_log_bank_error(struct aca_handle *handle, struct ac=
a_bank *bank,
+                                     enum aca_error_type type, void *data)=
 {
+       struct aca_bank_report report;
+       int ret;
+
+       ret =3D aca_generate_bank_report(handle, bank, type, &report);
+       if (ret)
+               return ret;
+
+       if (!report.count)
+               return 0;
+
+       ret =3D aca_log_error_report(handle, type, &report);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_ba=
nk *bank,
+                            enum aca_error_type type, bank_handler_t handl=
er, void *data) {
+       struct aca_handle *handle;
+       int ret;
+
+       if (list_empty(&mgr->list))
+               return 0;
+
+       list_for_each_entry(handle, &mgr->list, node) {
+               if (!aca_bank_is_valid(handle, bank, type))
+                       continue;
+
+               ret =3D handler(handle, bank, type, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_b=
anks *banks,
+                             enum aca_error_type type, bank_handler_t hand=
ler, void *data)
+{
+       struct aca_bank_node *node;
+       struct aca_bank *bank;
+       int ret;
+
+       if (!mgr || !banks)
+               return -EINVAL;
+
+       /* pre check to avoid unnecessary operations */
+       if (list_empty(&mgr->list) || list_empty(&banks->list))
+               return 0;
+
+       list_for_each_entry(node, &banks->list, node) {
+               bank =3D &node->bank;
+
+               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}

  1.  [Hawking]: Can we merge aca_dispatch_bank with aca_dispatch_banks?

+
+static int aca_bank_update(struct amdgpu_device *adev, enum aca_error_type=
 type,

  1.  [Hawking]: let's name it aca_update_banks

+                          bank_handler_t handler, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       struct aca_banks banks;
+       u32 count =3D 0;
+       int ret;
+
+       if (list_empty(&aca->mgr.list))
+               return 0;
+
+       ret =3D aca_smu_get_valid_aca_count(adev, type, &count);
+       if (ret)
+               return ret;
+
+       if (!count)
+               return 0;
+
+       aca_banks_init(&banks);
+
+       ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+       if (ret)
+               goto err_release_banks;
+
+       if (list_empty(&banks.list)) {
+               ret =3D 0;
+               goto err_release_banks;
+       }
+
+       ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
+                                handler, data);
+       if (ret)
+               goto err_release_banks;
+
+err_release_banks:
+       aca_banks_release(&banks);
+
+       return ret;
+}
+
+static int aca_error_update(struct amdgpu_device *adev, enum
+aca_error_type type) {
+       return aca_bank_update(adev, type, handler_aca_log_bank_error, NULL=
);
+}

  1.  [Hawking]: Shall we drop this function since it's just a wraper. It s=
eems to the caller __aca_get_error_data does have all the input parameters =
that can feed into aca_update_banks.

+
+static int aca_log_aca_error_data(struct aca_bank_error *bank_error,
+enum aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_bank_info *info;
+       struct amdgpu_smuio_mcm_config_info mcm_info;
+
+       if (!bank_error->count)
+               return 0;
+
+       info =3D &bank_error->info;
+       mcm_info.die_id =3D info->die_id;
+       mcm_info.socket_id =3D info->socket_id;
+
+       switch (type) {
+       case ACA_ERROR_TYPE_UE:
+               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_CE:
+               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NU=
LL, bank_error->count);
+               break;
+       case ACA_ERROR_TYPE_DEFERRED:
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int aca_log_aca_error(struct aca_handle *handle, enum
+aca_error_type type, struct ras_err_data *err_data) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       struct aca_error *aerr =3D &error_cache->errors[type];
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+
+       if (list_empty(&aerr->list))
+               goto out_unlock;
+
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node) {
+               aca_log_aca_error_data(bank_error, type, err_data);
+               aca_bank_error_remove(aerr, bank_error);
+       }
+
+out_unlock:
+       mutex_unlock(&aerr->lock);
+
+       return 0;
+}
+
+static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle *handle, enum aca_error_type type,
+                               struct ras_err_data *err_data)
+{
+       int ret;
+
+       /* udpate aca bank to aca source error_cache first */
+       ret =3D aca_error_update(adev, type);
+       if (ret)
+               return ret;
+
+       return aca_log_aca_error(handle, type, err_data); }
+
+static bool aca_handle_is_valid(struct aca_handle *handle) {
+       if (!handle->mask || !list_empty(&handle->node))
+               return false;
+
+       return true;
+}
+
+int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handl=
e *handle,
+                             enum aca_error_type type, void *data) {
+       struct ras_err_data *err_data =3D (struct ras_err_data *)data;
+
+       if (!handle || !err_data)
+               return -EINVAL;
+
+       if (aca_handle_is_valid(handle))
+               return -EOPNOTSUPP;
+
+       if (!(BIT(type) & handle->mask))
+               return  0;
+
+       return __aca_get_error_data(adev, handle, type, err_data); }
+
+static void aca_error_init(struct aca_error *aerr, enum aca_error_type
+type) {
+       mutex_init(&aerr->lock);
+       INIT_LIST_HEAD(&aerr->list);
+       aerr->type =3D type;
+       aerr->nr_errors =3D 0;
+}
+
+static void aca_init_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_init(&error_cache->errors[type], type); }
+
+static void aca_error_fini(struct aca_error *aerr) {
+       struct aca_bank_error *bank_error, *tmp;
+
+       mutex_lock(&aerr->lock);
+       list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
+               aca_bank_error_remove(aerr, bank_error);
+
+       mutex_destroy(&aerr->lock);
+}
+
+static void aca_fini_error_cache(struct aca_handle *handle) {
+       struct aca_error_cache *error_cache =3D &handle->error_cache;
+       int type;
+
+       for (type =3D ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type+=
+)
+               aca_error_fini(&error_cache->errors[type]);
+}
+
+static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_ma=
nager *mgr, struct aca_handle *handle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       memset(handle, 0, sizeof(*handle));
+
+       handle->adev =3D adev;
+       handle->mgr =3D mgr;
+       handle->name =3D name;
+       handle->hwip =3D ras_info->hwip;
+       handle->mask =3D ras_info->mask;
+       handle->bank_ops =3D ras_info->bank_ops;
+       handle->data =3D data;
+       aca_init_error_cache(handle);
+
+       INIT_LIST_HEAD(&handle->node);
+       list_add_tail(&handle->node, &mgr->list);
+       mgr->nr_handles++;
+
+       return 0;
+}
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *ras_info=
, void *data) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       return add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data=
);
+}
+
+static void remove_aca(struct aca_handle *handle) {
+       struct aca_handle_manager *mgr =3D handle->mgr;
+
+       aca_fini_error_cache(handle);
+       list_del(&handle->node);
+       mgr->nr_handles--;
+}
+
+void amdgpu_aca_remove_handle(struct aca_handle *handle) {
+       if (!handle || list_empty(&handle->node))
+               return;
+
+       remove_aca(handle);
+}
+
+static int aca_manager_init(struct aca_handle_manager *mgr) {
+       INIT_LIST_HEAD(&mgr->list);
+       mgr->nr_handles =3D 0;
+
+       return 0;
+}
+
+static void aca_manager_fini(struct aca_handle_manager *mgr) {
+       struct aca_handle *handle, *tmp;
+
+       list_for_each_entry_safe(handle, tmp, &mgr->list, node)
+               remove_aca(handle);
+}
+
+int amdgpu_aca_init(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       int ret;
+
+       ret =3D aca_manager_init(&aca->mgr);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+void amdgpu_aca_fini(struct amdgpu_device *adev) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       aca_manager_fini(&aca->mgr);
+}
+
+void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+
+       WARN_ON(aca->smu_funcs);
+       aca->smu_funcs =3D smu_funcs;
+}
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info) {
+       u64 ipid;
+       u32 instidhi, instidlo;
+
+       if (!bank || !info)
+               return -EINVAL;
+
+       ipid =3D bank->regs[ACA_REG_IDX_IPID];
+       info->hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
+       info->mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
+       /*
+        * Unfied DieID Format: SAASS. A:AID, S:Socket.
+        * Unfied DieID[4:4] =3D InstanceId[0:0]
+        * Unfied DieID[0:3] =3D InstanceIdHi[0:3]
+        */
+       instidhi =3D ACA_REG__IPID__INSTANCEIDHI(ipid);
+       instidlo =3D ACA_REG__IPID__INSTANCEIDLO(ipid);
+       info->die_id =3D ((instidhi >> 2) & 0x03);
+       info->socket_id =3D ((instidlo & 0x1) << 2) | (instidhi & 0x03);
+
+       return 0;
+}
+
+static int aca_bank_get_error_code(struct amdgpu_device *adev, struct
+aca_bank *bank) {
+       int error_code;
+
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+               if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >=3D=
 0x00555600) {
+                       error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank=
->regs[ACA_REG_IDX_SYND]);
+                       return error_code & 0xff;
+               }
+               break;
+       default:
+               break;
+       }
+
+       /* NOTE: the true error code is encoded in status.errorcode[0:7] */
+       error_code =3D
+ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
+
+       return error_code & 0xff;
+}
+
+int aca_bank_check_error_codes(struct amdgpu_device *adev, struct
+aca_bank *bank, int *err_codes, int size) {
+       int i, error_code;
+
+       if (!bank || !err_codes)
+               return -EINVAL;
+
+       error_code =3D aca_bank_get_error_code(adev, bank);
+       for (i =3D 0; i < size; i++) {
+               if (err_codes[i] =3D=3D error_code)
+                       return 0;
+       }
+
+       return -EINVAL;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
new file mode 100644
index 000000000000..688907270ff7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_ACA_H__
+#define __AMDGPU_ACA_H__
+
+#include <linux/list.h>
+
+#define ACA_MAX_REGS_COUNT     (16)
+
+#define ACA_REG_FIELD(x, h, l)                 (((x) & GENMASK_ULL(h, l)) =
>> l)
+#define ACA_REG__STATUS__VAL(x)                        ACA_REG_FIELD(x, 63=
, 63)
+#define ACA_REG__STATUS__OVERFLOW(x)           ACA_REG_FIELD(x, 62, 62)
+#define ACA_REG__STATUS__UC(x)                 ACA_REG_FIELD(x, 61, 61)
+#define ACA_REG__STATUS__EN(x)                 ACA_REG_FIELD(x, 60, 60)
+#define ACA_REG__STATUS__MISCV(x)              ACA_REG_FIELD(x, 59, 59)
+#define ACA_REG__STATUS__ADDRV(x)              ACA_REG_FIELD(x, 58, 58)
+#define ACA_REG__STATUS__PCC(x)                        ACA_REG_FIELD(x, 57=
, 57)
+#define ACA_REG__STATUS__ERRCOREIDVAL(x)       ACA_REG_FIELD(x, 56, 56)
+#define ACA_REG__STATUS__TCC(x)                        ACA_REG_FIELD(x, 55=
, 55)
+#define ACA_REG__STATUS__SYNDV(x)              ACA_REG_FIELD(x, 53, 53)
+#define ACA_REG__STATUS__CECC(x)               ACA_REG_FIELD(x, 46, 46)
+#define ACA_REG__STATUS__UECC(x)               ACA_REG_FIELD(x, 45, 45)
+#define ACA_REG__STATUS__DEFERRED(x)           ACA_REG_FIELD(x, 44, 44)
+#define ACA_REG__STATUS__POISON(x)             ACA_REG_FIELD(x, 43, 43)
+#define ACA_REG__STATUS__SCRUB(x)              ACA_REG_FIELD(x, 40, 40)
+#define ACA_REG__STATUS__ERRCOREID(x)          ACA_REG_FIELD(x, 37, 32)
+#define ACA_REG__STATUS__ADDRLSB(x)            ACA_REG_FIELD(x, 29, 24)
+#define ACA_REG__STATUS__ERRORCODEEXT(x)       ACA_REG_FIELD(x, 21, 16)
+#define ACA_REG__STATUS__ERRORCODE(x)          ACA_REG_FIELD(x, 15, 0)
+
+#define ACA_REG__IPID__MCATYPE(x)              ACA_REG_FIELD(x, 63, 48)
+#define ACA_REG__IPID__INSTANCEIDHI(x)         ACA_REG_FIELD(x, 47, 44)
+#define ACA_REG__IPID__HARDWAREID(x)           ACA_REG_FIELD(x, 43, 32)
+#define ACA_REG__IPID__INSTANCEIDLO(x)         ACA_REG_FIELD(x, 31, 0)
+
+#define ACA_REG__MISC0__VALID(x)               ACA_REG_FIELD(x, 63, 63)
+#define ACA_REG__MISC0__OVRFLW(x)              ACA_REG_FIELD(x, 48, 48)
+#define ACA_REG__MISC0__ERRCNT(x)              ACA_REG_FIELD(x, 43, 32)
+
+#define ACA_REG__SYND__ERRORINFORMATION(x)     ACA_REG_FIELD(x, 17, 0)
+
+/* NOTE: The following codes refers to the smu header file */
+#define ACA_EXTERROR_CODE_CE                   0x3a
+#define ACA_EXTERROR_CODE_FAULT                        0x3b
+
+#define ACA_ERROR_UE_MASK              BIT_MASK(ACA_ERROR_TYPE_UE)
+#define ACA_ERROR_CE_MASK              BIT_MASK(ACA_ERROR_TYPE_CE)
+#define ACA_ERROR_DEFERRED_MASK                BIT_MASK(ACA_ERROR_TYPE_DEF=
ERRED)
+
+enum aca_reg_idx {
+       ACA_REG_IDX_CTL                 =3D 0,
+       ACA_REG_IDX_STATUS              =3D 1,
+       ACA_REG_IDX_ADDR                =3D 2,
+       ACA_REG_IDX_MISC0               =3D 3,
+       ACA_REG_IDX_CONFG               =3D 4,
+       ACA_REG_IDX_IPID                =3D 5,
+       ACA_REG_IDX_SYND                =3D 6,
+       ACA_REG_IDX_DESTAT              =3D 8,
+       ACA_REG_IDX_DEADDR              =3D 9,
+       ACA_REG_IDX_CTL_MASK            =3D 10,
+       ACA_REG_IDX_COUNT               =3D 16,
+};
+
+enum aca_hwip_type {
+       ACA_HWIP_TYPE_UNKNOW =3D -1,
+       ACA_HWIP_TYPE_PSP =3D 0,
+       ACA_HWIP_TYPE_UMC,
+       ACA_HWIP_TYPE_SMU,
+       ACA_HWIP_TYPE_PCS_XGMI,
+       ACA_HWIP_TYPE_COUNT,
+};
+
+enum aca_error_type {
+       ACA_ERROR_TYPE_INVALID =3D -1,
+       ACA_ERROR_TYPE_UE =3D 0,
+       ACA_ERROR_TYPE_CE,
+       ACA_ERROR_TYPE_DEFERRED,
+       ACA_ERROR_TYPE_COUNT
+};
+
+struct aca_bank {
+       u64 regs[ACA_MAX_REGS_COUNT];
+};
+
+struct aca_bank_node {
+       struct aca_bank bank;
+       struct list_head node;
+};
+
+struct aca_bank_info {
+       int die_id;
+       int socket_id;
+       int hwid;
+       int mcatype;
+};
+
+struct aca_bank_report {
+       enum aca_error_type type;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_bank_error {
+       struct list_head node;
+       struct aca_bank_info info;
+       u64 count;
+};
+
+struct aca_error {
+       struct list_head list;
+       struct mutex lock;
+       enum aca_error_type type;
+       int nr_errors;
+};
+
+struct aca_handle_manager {
+       struct list_head list;
+       int nr_handles;
+};
+
+struct aca_error_cache {
+       struct aca_error errors[ACA_ERROR_TYPE_COUNT]; };
+
+struct aca_handle {
+       struct list_head node;
+       enum aca_hwip_type hwip;
+       struct amdgpu_device *adev;
+       struct aca_handle_manager *mgr;
+       struct aca_error_cache error_cache;
+       const struct aca_bank_ops *bank_ops;
+       const char *name;
+       u32 mask;
+       void *data;
+};
+
+struct aca_bank_ops {
+       int (*aca_bank_generate_report)(struct aca_handle *handle, struct a=
ca_bank *bank, enum aca_error_type type,
+                                       struct aca_bank_report *report, voi=
d *data);
+       bool (*aca_bank_is_valid)(struct aca_handle *handle, struct aca_ban=
k *bank, enum aca_error_type type,
+                                 void *data);
+};
+
+struct aca_smu_funcs {
+       int max_ue_aca_count;
+       int max_ce_aca_count;

  1.  [Hawking] rename them to max_ue_count, and max_ce_count respectively

+       int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
+       int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_err=
or_type type, u32 *count);
+       int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum
+aca_error_type type, int idx, struct aca_bank *bank); };
+
+struct amdgpu_aca {
+       struct aca_handle_manager mgr;
+       const struct aca_smu_funcs *smu_funcs; };
+
+struct aca_info {
+       enum aca_hwip_type hwip;
+       const struct aca_bank_ops *bank_ops;
+       u32 mask;
+};
+
+int amdgpu_aca_init(struct amdgpu_device *adev); void
+amdgpu_aca_fini(struct amdgpu_device *adev); void
+amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
+aca_smu_funcs *smu_funcs);
+
+int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info
+*info); int aca_bank_check_error_codes(struct amdgpu_device *adev,
+struct aca_bank *bank, int *err_codes, int size);
+
+int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                         const char *name, const struct aca_info *aca_info=
, void *data);
+void amdgpu_aca_remove_handle(struct aca_handle *handle); int
+amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h=
andle,
+                                    enum aca_error_type type, void *data);=
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4b694696930e..dc03643a985e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4030,6 +4030,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,

         amdgpu_device_get_pcie_info(adev);

+       r =3D amdgpu_aca_init(adev);
+       if (r)
+               return r;
+
         r =3D amdgpu_device_get_job_timeout_settings(adev);
         if (r) {
                 dev_err(adev->dev, "invalid lockup_timeout parameter synta=
x\n"); @@ -4434,6 +4438,8 @@ void amdgpu_device_fini_sw(struct amdgpu_devic=
e *adev)

         amdgpu_reset_fini(adev);

+       amdgpu_aca_fini(adev);
+
         /* free i2c buses */
         if (!amdgpu_device_has_dc_support(adev))
                 amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 76fb85628716..c36faf353b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -29,6 +29,7 @@
#include "ta_ras_if.h"
#include "amdgpu_ras_eeprom.h"
#include "amdgpu_smuio.h"
+#include "amdgpu_aca.h"

struct amdgpu_iv_entry;

--
2.34.1


--_000_PH7PR12MB59975D1C119B26AB2C51C0A28260APH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:651980197;
	mso-list-template-ids:1136452014;}
@list l0:level1
	{mso-level-start-at:4;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:780992867;
	mso-list-template-ids:-1143420844;}
@list l1:level1
	{mso-level-start-at:9;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2
	{mso-list-id:804741151;
	mso-list-template-ids:-1745703304;}
@list l2:level1
	{mso-level-start-at:6;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3
	{mso-list-id:1025326483;
	mso-list-template-ids:-184360686;}
@list l3:level1
	{mso-level-start-at:5;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4
	{mso-list-id:1146700725;
	mso-list-template-ids:-1892932566;}
@list l4:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5
	{mso-list-id:1318218378;
	mso-list-template-ids:344769326;}
@list l5:level1
	{mso-level-start-at:7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l5:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6
	{mso-list-id:1390181331;
	mso-list-template-ids:775454602;}
@list l6:level1
	{mso-level-start-at:8;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7
	{mso-list-id:1596326246;
	mso-list-template-ids:-1426548998;}
@list l7:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; <b>AMD_IS_APU<=
/b>) &amp;&amp; adev-&gt;pm.fw_version &gt;=3D
<b>0x00555600</b>) {<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It needs to be clarified that the above code is not =
used to distinguish between APU and DGPU.<o:p></o:p></p>
<p class=3D"MsoNormal">The real reason is that PMFW uses different versions=
 in APU and DGPU although its share the same smu ip version 13.0.6, and add=
ing a version check is because the new PMFW uses another mca register to st=
ore error codes.
<span style=3D"font-size:10.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Kevin<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, January 3, 2024 8:09 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver fram=
ework<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSIO=
N(13, 0, 6):<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) &a=
mp;&amp; adev-&gt;pm.fw_version &gt;=3D 0x00555600) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank-&gt;regs[ACA_REG=
_IDX_SYND]);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return error_code &amp; 0xff;<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Btw, we will switch to ACA for APU as well, although=
 it only covers a few driver managed IP blocks. This also reminds me that w=
e really need a flag (is_supported) in aca structure that gives us a chance=
 to restrict the transition to discrete
 gpu first.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Zhang, Hawking<br>
<b>Sent:</b> Wednesday, January 3, 2024 17:29<br>
<b>To:</b> Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">=
KevinYang.Wang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Ta=
o.Zhou1@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver fram=
ework<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]</span><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div style=3D"margin-top:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">Please check my commen=
ts inline. I added index for each comment (9 in total) since it is a long t=
hread&#8230;</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">Regards,</span><span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">Hawking</span><span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">-----Original Message-----<br>
From: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">Kevin=
Yang.Wang@amd.com</a>&gt;
<br>
Sent: Wednesday, January 3, 2024 16:02<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao=
.Zhou1@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.=
com">YiPeng.Chai@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:K=
evinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&gt;<br>
Subject: [PATCH 01/14] drm/amdgpu: implement RAS ACA driver framework<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">v1:<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">implement new RAS ACA driver code framework.<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">v2:<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">- rename aca_bank_set to aca_banks.<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">- rename aca_source_xxx to aca_handle_xxx<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Signed-off-by: Yang Wang &lt;<a href=3D"mailto:kevin=
yang.wang@amd.com">kevinyang.wang@amd.com</a>&gt;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">---<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c&nbsp;&nbsp;&=
nbsp; | 679 +++++++++++++++++++++<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h&nbsp;&nbsp;&=
nbsp; | 196 ++++++<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp;&n=
bsp; 6 +<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 1 +<span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">6 files changed, 887 insertions(+), 1 deletion(-)&nb=
sp; create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_aca.h<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-se=
rif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/d=
rivers/gpu/drm/amd/amdgpu/Makefile<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 260e32ef7bae..4c989da4d2f3 100644<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/Makefile<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -80,7 +80,7 @@ amdgpu-y +=3D amdgpu_device.o amdg=
pu_doorbell_mgr.o amdgpu_kms.o \<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \<span style=3D"=
font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_fw_attestation.o amdgpu_securedisplay.o \<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mu=
x.o amdgpu_xcp.o amdgpu_seq64.o<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mu=
x.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o<span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu.h<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 616b6c911767..9fa6f69a58a7 100644<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -107,6 +107,7 @@<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_smuio.h&quot;<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_fdinfo.h&quot;<span style=3D"f=
ont-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_mca.h&quot;<span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal">+#include &quot;amdgpu_aca.h&quot;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_ras.h&quot;<span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_xcp.h&quot;<span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_seq64.h&quot;<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">@@ -1045,6 +1046,9 @@ struct amdgpu_device {<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
MCA */<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-se=
rif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_mca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mca;<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ACA */<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; aca;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ip_block&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
p_blocks[AMDGPU_MAX_IP_NUM];<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harves=
t_ip_mask;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; num_ip_blocks;<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">new file mode 100644<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 000000000000..6a6f167b5380<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">--- /dev/null<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -0,0 +1,679 @@<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+/*<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Copyright 2023 Advanced Micro Devices, Inc.<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Permission is hereby granted, free of charge, to=
 any person
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+obtaining a<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * copy of this software and associated documentati=
on files (the
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&quot;Software&quot;),<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * to deal in the Software without restriction, inc=
luding without
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+limitation<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * the rights to use, copy, modify, merge, publish,=
 distribute,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+sublicense,<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * and/or sell copies of the Software, and to permi=
t persons to whom
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+the<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Software is furnished to do so, subject to the f=
ollowing conditions:<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * The above copyright notice and this permission n=
otice shall be
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+included in<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * all copies or substantial portions of the Softwa=
re.<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITH=
OUT WARRANTY OF ANY KIND,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+EXPRESS OR<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRAN=
TIES OF <span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif">
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+MERCHANTABILITY,<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE=
MENT.&nbsp; IN NO EVENT
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+SHALL<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE F=
OR ANY CLAIM,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+DAMAGES OR<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRAC=
T, TORT OR
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+OTHERWISE,<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE S=
OFTWARE OR THE USE
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+OR<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * OTHER DEALINGS IN THE SOFTWARE.<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ */<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#include &lt;linux/list.h&gt;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#include &quot;amdgpu.h&quot;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#include &quot;amdgpu_aca.h&quot;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+#include &quot;amdgpu_ras.h&quot;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_BANK_HWID(type, hwid, mcatype) [ACA_HWI=
P_TYPE_##type] =3D
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+{hwid, mcatype}<span style=3D"font-size:10.0pt;font=
-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+typedef int bank_handler_t(struct aca_handle *handl=
e, struct aca_bank
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+*bank, enum aca_error_type type, void *data);<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_banks {<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_banks;<=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad list;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_hwip {<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mcatype;<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static struct aca_hwip aca_hwid_mcatypes[ACA_HWIP_T=
YPE_COUNT] =3D {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(=
SMU,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01,&nbsp;&nbsp; 0x01),<span style=3D"f=
ont-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(=
PCS_XGMI, 0x50,&nbsp;&nbsp; 0x00),<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_BANK_HWID(=
UMC,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x96,&nbsp;&nbsp; 0x00),<span style=3D"f=
ont-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_banks_init(struct aca_banks *banks)=
 {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!banks)<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(banks, =
0, sizeof(*banks));<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;banks-&gt;list);<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_banks_add_bank(struct aca_banks *ban=
ks, struct aca_bank
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+*bank) {<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_node *node;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank)<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =3D kvzal=
loc(sizeof(*node), GFP_KERNEL);<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node)<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;no=
de-&gt;bank, bank, sizeof(*bank));<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;node-&gt;node);<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(=
&amp;node-&gt;node, &amp;banks-&gt;list);<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; banks-&gt;nr_b=
anks++;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_banks_release(struct aca_banks *ban=
ks) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_node *node, *tmp;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry_safe(node, tmp, &amp;banks-&gt;list, node) {<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;node-&gt;node);<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(node);<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_smu_get_valid_aca_count(struct amdgp=
u_device *adev, enum
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_error_type type, u32 *count) {<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_smu_funcs *smu_funcs =3D aca-&gt;smu_funcs;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_funcs=
 || !smu_funcs-&gt;get_valid_aca_count)<span style=3D"font-size:10.0pt;font=
-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_fun=
cs-&gt;get_valid_aca_count(adev, type, count); }<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_smu_get_valid_aca_banks(struct amdgp=
u_device *adev, enum aca_error_type type,<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int start, int count,<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct aca_banks *banks)<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+{<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_smu_funcs *smu_funcs =3D aca-&gt;smu_funcs;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k bank;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, max_cou=
nt, ret;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_funcs=
 || !smu_funcs-&gt;get_valid_aca_bank)<span style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) =
{<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_UE:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_count =3D smu_funcs-&gt;max_ue_aca_co=
unt;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<ol start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l7 level1 lfo1">
<b>[Hawking]: %s/max_ue_aca_count/max_ue_count</b><o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_CE:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_DEFERRED:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_count =3D smu_funcs-&gt;max_ce_aca_co=
unt;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<ol start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l4 level1 lfo2">
<b>[Hawking]: %s/max_ce_aca_count/max_ce_count</b><o:p></o:p></li><li class=
=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-margin-bo=
ttom-alt:auto;mso-list:l4 level1 lfo2">
<b>[Hawking]: I&#8217;ll suggest treating DEFERRED as default for now. (i.e=
., not supported yet)</b><o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (start + co=
unt &gt;=3D max_count)<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D min_=
t(int, count, max_count);<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; =
i &lt; count; i++) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bank, 0, sizeof(bank));<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_funcs-&gt;get_valid_aca_bank(=
adev, type, start + i, &amp;bank);<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;ba=
nk);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static bool aca_bank_hwip_is_matched(struct aca_ban=
k *bank, enum
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_hwip_type type) {<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_hwi=
p *hwip;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid, mcat=
ype;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || t=
ype =3D=3D ACA_HWIP_TYPE_UNKNOW)<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwip =3D &amp;=
aca_hwid_mcatypes[type];<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwip-&gt;=
hwid)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-=
&gt;regs[ACA_REG_IDX_IPID];<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwid =3D ACA_R=
EG__IPID__HARDWAREID(ipid);<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcatype =3D AC=
A_REG__IPID__MCATYPE(ipid);<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwip-&g=
t;hwid =3D=3D hwid &amp;&amp; hwip-&gt;mcatype =3D=3D mcatype; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static bool aca_bank_is_valid(struct aca_handle *ha=
ndle, struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_bank *bank, enum aca_error_type type) {<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_bank_ops *bank_ops =3D handle-&gt;bank_ops;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aca_bank_=
hwip_is_matched(bank, handle-&gt;hwip))<span style=3D"font-size:10.0pt;font=
-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_ops-=
&gt;aca_bank_is_valid)<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<ol start=3D"4" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l0 level1 lfo3">
<b>[Hawking]: does it apply to the case where the valid field is not availa=
ble? Can you please elaborate why return true in such case?</b><o:p></o:p><=
/li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_op=
s-&gt;aca_bank_is_valid(handle, bank, type, handle-&gt;data);
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static struct aca_bank_error *new_bank_error(struct=
 aca_error *aerr,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_info *info) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error;<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D=
 kvzalloc(sizeof(*bank_error), GFP_KERNEL);<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_erro=
r)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;bank_error-&gt;node);<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;ba=
nk_error-&gt;info, info, sizeof(*info));<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(=
&amp;bank_error-&gt;node, &amp;aerr-&gt;list);<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_er=
ror;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static struct aca_bank_error *find_bank_error(struc=
t aca_error *aerr,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_info *info) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error =3D NULL;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_info *tmp_info;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool found =3D=
 false;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry(bank_error, &amp;aerr-&gt;list, node) {<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_info =3D &amp;bank_error-&gt;info;<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_info-&gt;socket_id =3D=3D info-&g=
t;socket_id &amp;&amp;<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_info-&gt;die_=
id =3D=3D info-&gt;die_id) {<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; found =3D true;<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto out_unlock;<span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+out_unlock:<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return found ?=
 bank_error : NULL;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_bank_error_remove(struct aca_error =
*aerr, struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_bank_error *bank_error) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aerr || !=
bank_error)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;=
bank_error-&gt;node);<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;nr_er=
rors--;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(bank_er=
ror);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static struct aca_bank_error *get_bank_error(struct=
 aca_error *aerr,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_info *info) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error;<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aerr || !=
info)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D=
 find_bank_error(aerr, info);<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bank_error=
)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_error;<span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return new_ban=
k_error(aerr, info);<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_error_inc_count(struct aca_error *ae=
rr, struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_bank_info *info, u64 count) {<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error;<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!info)<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error =3D=
 get_bank_error(aerr, info);<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_erro=
r)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank_error-&gt=
;count +=3D count;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_log_error_report(struct aca_handle *=
handle, enum aca_error_type type,<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_repo=
rt *report)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+{<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or_cache *error_cache =3D &amp;handle-&gt;error_cache;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or *aerr;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle ||=
 !report)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr =3D &amp;=
error_cache-&gt;errors[type];<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_err=
or_inc_count(aerr, &amp;report-&gt;info, report-&gt;count); }<span style=3D=
"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<ol start=3D"5" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l3 level1 lfo4">
<b>[Hawking]: Shall we merge the aca_error_inc_count with aca_log_error_rep=
ort? if you haven&#8217;t name any function as aca_log_error, then just ren=
ame aca_log_error_report to aca_log_errors.
</b><o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_generate_bank_report(struct aca_hand=
le *handle, struct aca_bank *bank,<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum aca_error_type type, struct aca_bank_report *report) {<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_bank_ops *bank_ops =3D handle-&gt;bank_ops;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !=
report)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_ops-=
&gt;aca_bank_generate_report)<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(report,=
 0, sizeof(*report));<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bank_op=
s-&gt;aca_bank_generate_report(handle, bank, type,<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; report, handle-&gt;data);<span style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int handler_aca_log_bank_error(struct aca_ha=
ndle *handle, struct aca_bank *bank,<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum aca_error_type type, void *data) {<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_report report;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_ge=
nerate_bank_report(handle, bank, type, &amp;report);<span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!report.co=
unt)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_lo=
g_error_report(handle, type, &amp;report);<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_dispatch_bank(struct aca_handle_mana=
ger *mgr, struct aca_bank *bank,<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type type, bank_handler=
_t handler, void *data) {<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_han=
dle *handle;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty=
(&amp;mgr-&gt;list))<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry(handle, &amp;mgr-&gt;list, node) {<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aca_bank_is_valid(handle, bank, type=
))<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; continue;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D handler(handle, bank, type, data)=
;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_dispatch_banks(struct aca_handle_man=
ager *mgr, struct aca_banks *banks,<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type type, bank_h=
andler_t handler, void *data)
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+{<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_node *node;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k *bank;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mgr || !b=
anks)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pre check t=
o avoid unnecessary operations */<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty=
(&amp;mgr-&gt;list) || list_empty(&amp;banks-&gt;list))<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry(node, &amp;banks-&gt;list, node) {<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank =3D &amp;node-&gt;bank;<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_bank(mgr, bank, type=
, handler, data);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<ol start=3D"6" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l2 level1 lfo5">
<b>[Hawking]: Can we merge aca_dispatch_bank with aca_dispatch_banks?</b><o=
:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_bank_update(struct amdgpu_device *ad=
ev, enum aca_error_type type,<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<ol start=3D"7" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l5 level1 lfo6">
<b>[Hawking]: let&#8217;s name it aca_update_banks</b><o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bank_handler_t handler, void *data) {<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
ks banks;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 count =3D =
0;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty=
(&amp;aca-&gt;mgr.list))<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_sm=
u_get_valid_aca_count(adev, type, &amp;count);<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_banks_init=
(&amp;banks);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_sm=
u_get_valid_aca_banks(adev, type, 0, count, &amp;banks);<span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_banks;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty=
(&amp;banks.list)) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;<span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_banks;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_di=
spatch_banks(&amp;aca-&gt;mgr, &amp;banks, type,<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler, data)=
;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_release_banks;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+err_release_banks:<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_banks_rele=
ase(&amp;banks);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_error_update(struct amdgpu_device *a=
dev, enum
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_error_type type) {<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_ban=
k_update(adev, type, handler_aca_log_bank_error, NULL);
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<ol start=3D"8" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l6 level1 lfo7">
<b>[Hawking]: Shall we drop this function since it&#8217;s just a wraper. I=
t seems to the caller __aca_get_error_data does have all the input paramete=
rs that can feed into aca_update_banks.</b><o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_log_aca_error_data(struct aca_bank_e=
rror *bank_error,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+enum aca_error_type type, struct ras_err_data *err_=
data) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_info *info;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
smuio_mcm_config_info mcm_info;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank_erro=
r-&gt;count)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;=
bank_error-&gt;info;<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcm_info.die_i=
d =3D info-&gt;die_id;<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcm_info.socke=
t_id =3D info-&gt;socket_id;<span style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) =
{<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_UE:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_statistic_ue_count(err_d=
ata, &amp;mcm_info, NULL, bank_error-&gt;count);<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_CE:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_statistic_ce_count(err_d=
ata, &amp;mcm_info, NULL, bank_error-&gt;count);<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_ERROR=
_TYPE_DEFERRED:<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_log_aca_error(struct aca_handle *han=
dle, enum
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_error_type type, struct ras_err_data *err_data)=
 {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or_cache *error_cache =3D &amp;handle-&gt;error_cache;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or *aerr =3D &amp;error_cache-&gt;errors[type];<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error, *tmp;<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty=
(&amp;aerr-&gt;list))<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry_safe(bank_error, tmp, &amp;aerr-&gt;list, node) {<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_log_aca_error_data(bank_error, type, =
err_data);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_bank_error_remove(aerr, bank_error);<=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+out_unlock:<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int __aca_get_error_data(struct amdgpu_devic=
e *adev, struct aca_handle *handle, enum aca_error_type type,<span style=3D=
"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data =
*err_data)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+{<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* udpate aca =
bank to aca source error_cache first */<span style=3D"font-size:10.0pt;font=
-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_er=
ror_update(adev, type);<span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_log=
_aca_error(handle, type, err_data); }<span style=3D"font-size:10.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static bool aca_handle_is_valid(struct aca_handle *=
handle) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle-&g=
t;mask || !list_empty(&amp;handle-&gt;node))<span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int amdgpu_aca_get_error_data(struct amdgpu_device =
*adev, struct aca_handle *handle,<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error_type type, void *=
data) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err=
_data *err_data =3D (struct ras_err_data *)data;<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle ||=
 !err_data)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aca_handle=
_is_valid(handle))<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(BIT(type=
) &amp; handle-&gt;mask))<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; 0;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __aca_g=
et_error_data(adev, handle, type, err_data); }<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_error_init(struct aca_error *aerr, =
enum aca_error_type
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+type) {<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&am=
p;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;aerr-&gt;list);<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;type =
=3D type;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aerr-&gt;nr_er=
rors =3D 0;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_init_error_cache(struct aca_handle =
*handle) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or_cache *error_cache =3D &amp;handle-&gt;error_cache;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (type =3D =
ACA_ERROR_TYPE_UE; type &lt; ACA_ERROR_TYPE_COUNT; type++)<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_error_init(&amp;error_cache-&gt;error=
s[type], type); }<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_error_fini(struct aca_error *aerr) =
{<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_error *bank_error, *tmp;<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry_safe(bank_error, tmp, &amp;aerr-&gt;list, node)<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_bank_error_remove(aerr, bank_error);<=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(=
&amp;aerr-&gt;lock);<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_fini_error_cache(struct aca_handle =
*handle) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or_cache *error_cache =3D &amp;handle-&gt;error_cache;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (type =3D =
ACA_ERROR_TYPE_UE; type &lt; ACA_ERROR_TYPE_COUNT; type++)<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_error_fini(&amp;error_cache-&gt;error=
s[type]);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int add_aca_handle(struct amdgpu_device *ade=
v, struct aca_handle_manager *mgr, struct aca_handle *handle,<span style=3D=
"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const char *name, const struct aca_info *ras_info, void =
*data) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(handle,=
 0, sizeof(*handle));<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;ade=
v =3D adev;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;mgr=
 =3D mgr;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;nam=
e =3D name;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;hwi=
p =3D ras_info-&gt;hwip;<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;mas=
k =3D ras_info-&gt;mask;<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;ban=
k_ops =3D ras_info-&gt;bank_ops;<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle-&gt;dat=
a =3D data;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_init_error=
_cache(handle);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;handle-&gt;node);<span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(=
&amp;handle-&gt;node, &amp;mgr-&gt;list);<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_han=
dles++;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int amdgpu_aca_add_handle(struct amdgpu_device *ade=
v, struct aca_handle *handle,<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const char *name, const struct aca_info *ras_info, void =
*data) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return add_aca=
_handle(adev, &amp;aca-&gt;mgr, handle, name, ras_info, data);
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void remove_aca(struct aca_handle *handle) {=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_han=
dle_manager *mgr =3D handle-&gt;mgr;<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_fini_error=
_cache(handle);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;=
handle-&gt;node);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_han=
dles--;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+void amdgpu_aca_remove_handle(struct aca_handle *ha=
ndle) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle ||=
 list_empty(&amp;handle-&gt;node))<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove_aca(han=
dle);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_manager_init(struct aca_handle_manag=
er *mgr) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD=
(&amp;mgr-&gt;list);<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mgr-&gt;nr_han=
dles =3D 0;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static void aca_manager_fini(struct aca_handle_mana=
ger *mgr) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_han=
dle *handle, *tmp;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_=
entry_safe(handle, tmp, &amp;mgr-&gt;list, node)<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remove_aca(handle);<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int amdgpu_aca_init(struct amdgpu_device *adev) {<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_ma=
nager_init(&amp;aca-&gt;mgr);<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+void amdgpu_aca_fini(struct amdgpu_device *adev) {<=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_manager_fi=
ni(&amp;aca-&gt;mgr);<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+void amdgpu_aca_set_smu_funcs(struct amdgpu_device =
*adev, const struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_smu_funcs *smu_funcs) {<span style=3D"font-size=
:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
aca *aca =3D &amp;adev-&gt;aca;<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(aca-&g=
t;smu_funcs);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca-&gt;smu_fu=
ncs =3D smu_funcs;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int aca_bank_info_decode(struct aca_bank *bank, str=
uct aca_bank_info
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+*info) {<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ipid;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instidhi, =
instidlo;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !=
info)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipid =3D bank-=
&gt;regs[ACA_REG_IDX_IPID];<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;hwid =
=3D ACA_REG__IPID__HARDWAREID(ipid);<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;mcaty=
pe =3D ACA_REG__IPID__MCATYPE(ipid);<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied=
 DieID Format: SAASS. A:AID, S:Socket.<span style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied=
 DieID[4:4] =3D InstanceId[0:0]<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unfied=
 DieID[0:3] =3D InstanceIdHi[0:3]<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instidhi =3D A=
CA_REG__IPID__INSTANCEIDHI(ipid);<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instidlo =3D A=
CA_REG__IPID__INSTANCEIDLO(ipid);<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;die_i=
d =3D ((instidhi &gt;&gt; 2) &amp; 0x03);<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;socke=
t_id =3D ((instidlo &amp; 0x1) &lt;&lt; 2) | (instidhi &amp; 0x03);<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+static int aca_bank_get_error_code(struct amdgpu_de=
vice *adev, struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_bank *bank) {<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int error_code=
;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu=
_ip_version(adev, MP1_HWIP, 0)) {<span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSIO=
N(13, 0, 6):<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) &a=
mp;&amp; adev-&gt;pm.fw_version &gt;=3D 0x00555600) {<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank-&gt;regs[ACA_REG=
_IDX_SYND]);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return error_code &amp; 0xff;<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* NOTE: the t=
rue error code is encoded in status.errorcode[0:7] */<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_code =3D=
 <span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ACA_REG__STATUS__ERRORCODE(bank-&gt;regs[ACA_REG_ID=
X_STATUS]);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return error_c=
ode &amp; 0xff;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int aca_bank_check_error_codes(struct amdgpu_device=
 *adev, struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_bank *bank, int *err_codes, int size) {<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, error_c=
ode;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bank || !=
err_codes)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_code =3D=
 aca_bank_get_error_code(adev, bank);<span style=3D"font-size:10.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; =
i &lt; size; i++) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_codes[i] =3D=3D error_code)<span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></=
o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL=
;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+}<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">new file mode 100644<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 000000000000..688907270ff7<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">--- /dev/null<span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -0,0 +1,196 @@<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+/*<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Copyright 2023 Advanced Micro Devices, Inc.<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Permission is hereby granted, free of charge, to=
 any person
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+obtaining a<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * copy of this software and associated documentati=
on files (the
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&quot;Software&quot;),<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * to deal in the Software without restriction, inc=
luding without
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+limitation<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * the rights to use, copy, modify, merge, publish,=
 distribute,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+sublicense,<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * and/or sell copies of the Software, and to permi=
t persons to whom
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+the<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * Software is furnished to do so, subject to the f=
ollowing conditions:<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * The above copyright notice and this permission n=
otice shall be
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+included in<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * all copies or substantial portions of the Softwa=
re.<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITH=
OUT WARRANTY OF ANY KIND,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+EXPRESS OR<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRAN=
TIES OF <span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif">
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+MERCHANTABILITY,<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE=
MENT.&nbsp; IN NO EVENT
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+SHALL<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE F=
OR ANY CLAIM,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+DAMAGES OR<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRAC=
T, TORT OR
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+OTHERWISE,<span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE S=
OFTWARE OR THE USE
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+OR<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ * OTHER DEALINGS IN THE SOFTWARE.<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+ *<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+ */<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#ifndef __AMDGPU_ACA_H__<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define __AMDGPU_ACA_H__<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#include &lt;linux/list.h&gt;<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_MAX_REGS_COUNT&nbsp;&nbsp;&nbsp;&nbsp; =
(16)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG_FIELD(x, h, l)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (((x) &amp; GENMASK_ULL(h, l)) &gt;&gt; l)<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__VAL(x)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 63, 63)<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__OVERFLOW(x)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 62, 62)<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__UC(x)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ACA_REG_FIELD(x, 61, 61)<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__EN(x)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ACA_REG_FIELD(x, 60, 60)<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__MISCV(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 59, 59)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ADDRV(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 58, 58)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__PCC(x)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 57, 57)<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ERRCOREIDVAL(x)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 56, 56)<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__TCC(x)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 55, 55)<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__SYNDV(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 53, 53)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__CECC(x)&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_F=
IELD(x, 46, 46)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__UECC(x)&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_F=
IELD(x, 45, 45)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__DEFERRED(x)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 44, 44)<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__POISON(x)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 43=
, 43)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__SCRUB(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 40, 40)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ERRCOREID(x)&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 37, 32)<span styl=
e=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ADDRLSB(x)&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 29, 24)=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ERRORCODEEXT(x)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 21, 16)<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__STATUS__ERRORCODE(x)&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 15, 0)<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__IPID__MCATYPE(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 63, 48)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__IPID__INSTANCEIDHI(x)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 47, 44)<span style=3D"=
font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__IPID__HARDWAREID(x)&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 43, 32)<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__IPID__INSTANCEIDLO(x)&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(x, 31, 0)<span style=3D"f=
ont-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__MISC0__VALID(x)&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_F=
IELD(x, 63, 63)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__MISC0__OVRFLW(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 48, 48)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__MISC0__ERRCNT(x)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_FIELD(=
x, 43, 32)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_REG__SYND__ERRORINFORMATION(x)&nbsp;&nb=
sp;&nbsp;&nbsp; ACA_REG_FIELD(x, 17, 0)<span style=3D"font-size:10.0pt;font=
-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+/* NOTE: The following codes refers to the smu head=
er file */<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_EXTERROR_CODE_CE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x3a<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_EXTERROR_CODE_FAULT&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3b<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_ERROR_UE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT_MASK(ACA_ERROR_TYP=
E_UE)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_ERROR_CE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT_MASK(ACA_ERROR_TYP=
E_CE)<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+#define ACA_ERROR_DEFERRED_MASK&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT_=
MASK(ACA_ERROR_TYPE_DEFERRED)<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+enum aca_reg_idx {<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CT=
L&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 0,<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_ST=
ATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 1,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_AD=
DR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D 2,<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_MI=
SC0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 3,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CO=
NFG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 4,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_IP=
ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D 5,<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_SY=
ND&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D 6,<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DE=
STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 8,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DE=
ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D 9,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CT=
L_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 10,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CO=
UNT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D 16,<span style=3D"font-size:10.0pt;font-family:&quot;Arial=
&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+enum aca_hwip_type {<span style=3D"font-size:10.0pt=
;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
UNKNOW =3D -1,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
PSP =3D 0,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
UMC,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
SMU,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
PCS_XGMI,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_HWIP_TYPE_=
COUNT,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-se=
rif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+enum aca_error_type {<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE=
_INVALID =3D -1,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE=
_UE =3D 0,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE=
_CE,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE=
_DEFERRED,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE=
_COUNT<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-se=
rif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank {<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 regs[ACA_M=
AX_REGS_COUNT];<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot=
;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_node {<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k bank;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad node;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_info {<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int die_id;<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int socket_id;=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hwid;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mcatype;<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_report {<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error=
_type type;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_info info;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 count;<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_error {<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad node;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_ban=
k_info info;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 count;<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_error {<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad list;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex l=
ock;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_error=
_type type;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_errors;=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_handle_manager {<span style=3D"font-size=
:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad list;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int nr_handles=
;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_error_cache {<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or errors[ACA_ERROR_TYPE_COUNT]; };<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_handle {<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_he=
ad node;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_hwip_=
type hwip;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_han=
dle_manager *mgr;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_err=
or_cache error_cache;<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_bank_ops *bank_ops;<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *na=
me;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data;<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank_ops {<span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*aca_bank=
_generate_report)(struct aca_handle *handle, struct aca_bank *bank, enum ac=
a_error_type type,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_report *report, void *data);<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*aca_ban=
k_is_valid)(struct aca_handle *handle, struct aca_bank *bank, enum aca_erro=
r_type type,<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *da=
ta);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_smu_funcs {<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ue_aca=
_count;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_ce_aca=
_count;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<ol start=3D"9" type=3D"1">
<li class=3D"MsoNormal" style=3D"color:#2F5496;mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto;mso-list:l1 level1 lfo8">
<b>[Hawking] rename them to max_ue_count, and max_ce_count respectively</b>=
<o:p></o:p></li></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#2F5496">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_debu=
g_mode)(struct amdgpu_device *adev, bool enable);<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_vali=
d_aca_count)(struct amdgpu_device *adev, enum aca_error_type type, u32 *cou=
nt);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-seri=
f"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_vali=
d_aca_bank)(struct amdgpu_device *adev, enum
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_error_type type, int idx, struct aca_bank *bank=
); };<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct amdgpu_aca {<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_han=
dle_manager mgr;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_smu_funcs *smu_funcs; };<span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_info {<span style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_hwip_=
type hwip;<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,san=
s-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
ca_bank_ops *bank_ops;<span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mask;<span=
 style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+};<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int amdgpu_aca_init(struct amdgpu_device *adev); vo=
id <span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif=
">
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+amdgpu_aca_fini(struct amdgpu_device *adev); void <=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev=
, const struct
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+aca_smu_funcs *smu_funcs);<span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int aca_bank_info_decode(struct aca_bank *bank, str=
uct aca_bank_info
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+*info); int aca_bank_check_error_codes(struct amdgp=
u_device *adev,
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+struct aca_bank *bank, int *err_codes, int size);<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+int amdgpu_aca_add_handle(struct amdgpu_device *ade=
v, struct aca_handle *handle,<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; const char *name, const struct aca_info *aca_info, void =
*data);
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+void amdgpu_aca_remove_handle(struct aca_handle *ha=
ndle); int
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+amdgpu_aca_get_error_data(struct amdgpu_device *ade=
v, struct aca_handle *handle,<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum aca_error_type type, void *data); #endif<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<span style=3D"font-size:10=
.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 4b694696930e..dc03643a985e 100644<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -4030,6 +4030,10 @@ int amdgpu_device_init(struct=
 amdgpu_device *adev,<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_device_get_pcie_info(adev);<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_a=
ca_init(adev);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_device_get_job_timeout_settings(adev);<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;in=
valid lockup_timeout parameter syntax\n&quot;); @@ -4434,6 +4438,8 @@ void =
amdgpu_device_fini_sw(struct amdgpu_device *adev)<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_reset_fini(adev);<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_fin=
i(adev);<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-=
serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
free i2c buses */<span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!amdgpu_device_has_dc_support(adev))<span style=3D"font-size:10.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_i2c_fini(adev);<span st=
yle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 76fb85628716..c36faf353b46 100644<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -29,6 +29,7 @@<span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;ta_ras_if.h&quot;<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_ras_eeprom.h&quot;<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">#include &quot;amdgpu_smuio.h&quot;<span style=3D"fo=
nt-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal">+#include &quot;amdgpu_aca.h&quot;<span style=3D"fon=
t-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">struct amdgpu_iv_entry;<span style=3D"font-size:10.0=
pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">--<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">2.34.1<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59975D1C119B26AB2C51C0A28260APH7PR12MB5997namp_--
