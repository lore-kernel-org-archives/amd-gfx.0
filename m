Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F221BC05052
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA9610E4FD;
	Fri, 18 Aug 2023 11:41:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6A10E4FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz+uCgCCqu756q3BGyf+r26rD/J8Gm8xsuiS3kZmwrfvNm/YKt5DjppDdYyPeIjUC64AjY6mij41kSXAQwTCjSRo9txkcvEkDs6gI/8TpMXDIpC1xrDIrEGQ+x2tiXJEtiiyZTKQcYJCQe5m7jBCMwNFauR12qaLwJE4Z0wgtO5HpD8P9bPtkCoCUJuKEni8O0MFXcPm6JhWchgOPDk36trI8VBIR1v3+ocMwC6lwTbsJGemadIyzpq4ucaS2shQDxqwHjMUkzDbU+y6n3KUHaGYKoUw1/uZMNigrKG834AbdhGaLitwhzKmHesbIFhk0fJcUofjLP/ejRsTOFIowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khkLHBPFpEHyNBgDBTyE8XeYoFkIiXTiJP4bgovve6E=;
 b=Em1lvpuJJ5twkrDYO3aZuzFR1NWN7ctl+I5aQA0E98FbEHUn2itajBy/QwYK6atAFo4ymxnep9g4B+1U8iOd0e0Z8xzUgiV5FHNuGh1jRHCJVVAsU+p9VvBVT69bH9xpOYLYJkK2U1PmkZK4cc80P1EjtPloKRquielpkkHVgVjqwyYN+bWuZrTr4JoBnFHXLm52vyg1emPJIs+gTxVV5dcmgFsC8qL4NUUstrlTy18VLiLFT6eNy6KZCcSzNs1Bjyx9oIIcOKLOf+90m9u76hzG0Om3Mxez3v3zcEL7BUcPeoZZ3GaIoiH+ZEARMUEsx9BVigwIM1zO5jMDdcwsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khkLHBPFpEHyNBgDBTyE8XeYoFkIiXTiJP4bgovve6E=;
 b=WNNRfnoawtaNL5mt+s7OZ3Qcz1KA+A2fgOJc/qiYczKESXBPw6/TAQb0yKGc+o1RA2BVqS0n65Yz9MFYuXMHaQU4Xl8sMiDPPEAe6jG9P5/UL1rPIt7XHN6mNbtzLuMmQeRsZpyfIKd//E695dH0d8IQS6b9pFOHcKXorl4YHqI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:41:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:41:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove SRAM clock gater override by driver
Thread-Topic: [PATCH] drm/amdgpu: Remove SRAM clock gater override by driver
Thread-Index: AQHZ0cjQqQ383+54OkWi0BDwfVc0sq/v7kCQ
Date: Fri, 18 Aug 2023 11:41:44 +0000
Message-ID: <BN9PR12MB5257D8C71082C74228159681FC1BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230818114014.3307151-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20230818114014.3307151-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=230f4fc8-d70b-4ac7-b59e-6e19947c310e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-18T11:41:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7345:EE_
x-ms-office365-filtering-correlation-id: 68abf17e-3d18-4343-00ac-08db9fe01963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlVJGTDQevj1Kyw4Z93lN22G3OobK58vKPY0l7ZgsHW0lN15LP24u6ZjOQ9e5Kbk1t7gFIu0X9GItt3iSegqq+b1Fqo8l1fd+Mys5eaozg8Mw0ccEOoHs84CDdNadvWF3dhR5EZL6bXunkyC6M4HQCC3Z/19zBaX9tl6PzTcRNKQC1k6hIp/Ayln46J0+KKV7YbizI2EuVd0NwYcMjEjq6ND0IAu+lBQmIxxryWViIoOLLZGN8EbhpvjwsI0/h1LHNHnQX0ORF4jnzDtRKmrs0K6gl1s947s45GchJCOUed0qTnFQqulJ2W34Quz5B7FemA2YUKvlGGzps5Og6kCM9A0gT8TVNysmm2us20HcilJ1TFRJEx5e+ie41VMBqSDqziPoWp7BkPF6MLdDGs+IZ4RsxvEShWJ4SFqeWhp4tFmbpqRXtIP8wW0WCY+wClblAH2FTIdG/UaLWfUN4VHElr9sEt/5yZUMr5pPJWVeHsmIbFLO5/xaXqps0zLAHvV2k6tLEdYV8/QJZHtk6RsTEuiIof1x5bvvrBeFPL12jmB9vakie5y2nRy4hkE6/W+3lfEaynI7tsaUI5SBFpyAEde4RWmoyibxDqgZQXdsz2ez6Ko0VAYCsgCx+4kh+VT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(55016003)(5660300002)(83380400001)(66476007)(38070700005)(38100700002)(316002)(64756008)(66946007)(66556008)(66446008)(6636002)(76116006)(478600001)(110136005)(122000001)(2906002)(41300700001)(8936002)(8676002)(52536014)(53546011)(9686003)(7696005)(71200400001)(6506007)(26005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHekhd0mG+hr2s8my863lQMwJ49IkegkadFidXJfmaAJuW0z82rSeMuubhph?=
 =?us-ascii?Q?YKZ0RcprK78E0lKz6cbnca8601LxhWo25ddI+mYTvpzAUyl/xGrh0zlgjzCO?=
 =?us-ascii?Q?CVSbVsjGhf66fM88mtaXT9hfk4dQAvQJ21Nsvb+uIgdBCbtMqelYXeJj6vDY?=
 =?us-ascii?Q?2yli1k/iiu0WbpB5VOlUnwuRKj06sVxtAoyt6PKzk3Nq2PSwQyh6nKQ6vmdB?=
 =?us-ascii?Q?d4Ao7j83GYGW0jZMlRxCHTzSbW4hdzSAiHmOHL5QXhCPq+MrBqaghLp/fpSn?=
 =?us-ascii?Q?42pLh50vt28y9y1TAOGwyrrGqQbx5NPVXkosUMxoXnzrD3Q9AYOw95Djh2Od?=
 =?us-ascii?Q?xrPyGTjFAV80r4puaqmeLqFE0APIOopglSr+g9tOsARzP2/+2mzl5HSfC3wt?=
 =?us-ascii?Q?8vNn0kGQcN//3uj7QoSamkOgtfUha3PCLoOj4BV2T4bSPVBV2eEJ3vTV6fOV?=
 =?us-ascii?Q?nVk/F7YJELIAAAAmwWRpcFaYFHp5PW5UvlqlKf+HAaARyyDMzNY03QmJpHKQ?=
 =?us-ascii?Q?pF8Fkav/q6fwHJE/wVXFAJLlasmRubUsIXUvlgw5wicRLsl8A+Ty1fjc3DrG?=
 =?us-ascii?Q?ZllKiIGKY0MK1Jw5Czub4pXKr065cKTscelaXFEaOltsfDvR6k7R6EG/C+Nt?=
 =?us-ascii?Q?6K+r70Gx4aW8fawIssGIyqqWAepFvRxdz4kzPJRjplcbNCG2YyxsfpopGAYV?=
 =?us-ascii?Q?0FqwbqYUY/2OjOvUirsCpfG7PpkQEqdt6v//RDcU9RKPg03jH1+dDpV5Xtzm?=
 =?us-ascii?Q?pevowr0qiaQssXQo83qT1EIEbAaT3bo6inEGLmBFZThfRBarOfIb5MHcd/Pc?=
 =?us-ascii?Q?2PDxoF0z1Yw0FVtKKMpTU6KOQamv+qs4C9dPf49D/fSn4tjKCWEj8w0Fhqm2?=
 =?us-ascii?Q?0C8oHWjarsv35f/riNQPLnOQDsoJte30xM35y0eaLjSDzuYFHRk94sqxfoLr?=
 =?us-ascii?Q?SUYWDphisiF5lUpTfWhcmxSHLk3uiMTrs8NCRurPxkYnltBpRQt4nXZgg67S?=
 =?us-ascii?Q?j2ZYgwPAb+RcdlIE8XHNf4YVVP/fCK1KPHCzfsrw8PyC9EENZUHFA8N3I/XA?=
 =?us-ascii?Q?/C8fO58wrA7oMa1fdxP+LUyEEUen6lNC0jIwr+lpkX85JI2Fs04e/9kKi7b7?=
 =?us-ascii?Q?Bd46cYs44XjfT+UuKQDakQZkz4mc1bPsJcNWEeOW2hWTkWNCbAN61NmlJWx+?=
 =?us-ascii?Q?K0z4RV3OuShLzRMWIut2rah6R4wWZHTChrLTGvPmhtCjbR3pbBfu6zt/UE7L?=
 =?us-ascii?Q?htfRTMWONFdGfnmwbt/pgVS2N31NLzTg06UNtQCcplEMaMcSOOi/M7GogeHW?=
 =?us-ascii?Q?+VmvgXz26yjZTYVtrHx83JjMotZQeGtEyW4Ca+2l9STspWskbIQBZ0pogE4m?=
 =?us-ascii?Q?SynUodozKMbdNb0vvCb50Zc4JdcYUbTcw3m7QaGD+cWjD/Eye9UxX/zeFLRe?=
 =?us-ascii?Q?nZ9zguGsUJKUQx0DbbEAeJO/tVwb8A5RboBI7I+ZDHCfKJPW1LPFBbobmj5b?=
 =?us-ascii?Q?I613k6CkmfivXsdhGY9PKT4qRYv8AwrEt5DPEaQPAi7vP2W1BCGC/SoIPJe5?=
 =?us-ascii?Q?ly+G/sOKU8whp2BeX9g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68abf17e-3d18-4343-00ac-08db9fe01963
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:41:44.9955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HJ/z2lUlgnhc1i6rvHdisb4BnMRrPqUYRaausnO0Sh7c2Pl3SnUB1btVE+Zsi8kb9WPe0NKN0M31ZG5J+ccew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Sent: Friday, August 18, 2023 19:40
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,=
 Hawking <Hawking.Zhang@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Remove SRAM clock gater override by driver

rlc firmware does required setting ,driver need not do it.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index d8d6807e7b96..93590adf2b04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2221,15 +2221,6 @@ static void gfx_v9_4_3_xcc_update_sram_fgcg(struct a=
mdgpu_device *adev,
                WREG32_SOC15(GC, GET_INST(GC, xcc_id),
                             regRLC_CGTT_MGCG_OVERRIDE, data);

-       def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_=
CNTL);
-
-       if (enable)
-               data &=3D ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
-       else
-               data |=3D RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
-
-       if (def !=3D data)
-               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, dat=
a);
 }

 static void gfx_v9_4_3_xcc_update_repeater_fgcg(struct amdgpu_device *adev=
,
--
2.34.1

