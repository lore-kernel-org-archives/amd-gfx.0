Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFADC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D6F208A9
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D6F208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026026E3E3;
	Thu,  7 Jan 2021 06:38:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A226E3E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 06:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvKXt1/J/VTW4WYtwccI0dLFSn9fcc/Lbx33X98UsLH5s2z/bXmLcN/3sc7fwxZb3gxdnxaFg0dK9P646IkdU6/n1dSdi5Bctdw7vfnZJUsXgU7s3NySKWsfqmIY6qRaINqWQGdphEGylKiyZ3g2+0cKm2/OAj6bRxkgaiyRucjdmGlwJ9fqdGzNfGsTpCYzaYYpTOYquYcmp0p/dPPJiyxqVRR49OTxDmaILks4DR78m+9srgVKyt42EUI1PWMqy8+CqSL88wkosrLeyI4bh0ZuRoKgGNrTp0c1L/tKiJuZqqNqS4xA16N6GmcITCCvvzA6fgne28DhRJbegXjIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrktf92E/TJ1rVKjFlxzVdkhR/VCPIs6Jqmukl8SVqs=;
 b=nzyNq2INa7zJrm7z+Yy757uVhcVAL1UrK3Hwr5aIA4MAY1wAC7wPCE5kb6OXJF8uQie0ZLNb3FYdoAzGDnjNAYbRb53KD2+fwJYx8uQLU4FKAodMRZIrm+jaO9IB24OQHUuIBOgWrZVih94qxt58u4LoQePglarHAEsf+1yIzeUPD8pjf2BGKSRPLXuh47bj38mCoXuXOV2TczU6c1HeYm3T75luw3LrKHGglvjSLd+9XvBNi5xrKbV6WDqu2As15mwJNE7yp62bx57EkJO9A5nr6zeVqkcQjikuyeHdvXBm2QheLH25xQ+tXv6eHw8QJmiOJwBx95lwqGj/KLo9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrktf92E/TJ1rVKjFlxzVdkhR/VCPIs6Jqmukl8SVqs=;
 b=REx+6vb4QikPpuBhTZ2mKPi3DRhR7L5SB1TNsVAM3qQYhzpdA2SWNebvPsHiq3L3q/PKnzIaVCndVdSvCCJN5w8EiFEvqOlWtWTucCKf4SzoIMPeRrvdQhve0vnKPjBolwvryGItWDqVMGw/yEsGeigS23aJH+IgOexSt7zZw1k=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 06:38:38 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 06:38:38 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
Thread-Topic: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
Thread-Index: AQHW4zeYvUEcEqMmtEyRCyWEaOllCaobtTYggAADg7A=
Date: Thu, 7 Jan 2021 06:38:38 +0000
Message-ID: <BY5PR12MB4115A1703FCF2E86513C97C38FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105075053.4986-1-Victor.Zhao@amd.com>
 <BY5PR12MB4115781E7D76AF8FC201AC7F8FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115781E7D76AF8FC201AC7F8FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8b64c91e-1fe1-49a2-b790-208bd45e1090;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T06:24:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d502186-c3da-4cca-d10c-08d8b2d6ddba
x-ms-traffictypediagnostic: BYAPR12MB3285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3285827F0C138B15F15DB06F8FAF0@BYAPR12MB3285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3U0SHrtxODwkqpVuQyR/HiNSTcxqmux7jgO6895JBofNhl87fDK/VIBUkaQ/h/tI0ciyTUo3wD/GNlfrkF16BoQfiVR2cuE2V3F16530FJvWGw8bz9IyBJCCbfoa0RvxrZG1a6DxW9dnaYWrmrxpee8ioBdsQ5ZMsuxKWK1ks9HaPVJCL+mA6Yg2LO8vP10ZaFpzPD94mkbJ51k3pisRnPsrl+2Uar2QcFPrS55o/HbJt7QL/mQCcwIL3Io4vJOr3xjGuL9mXyh5adC7l+2voziAe31DHZdXsQlM5tu5QMQMTVelC+rwUPI9Ln9FdHiqwJ737uSj0h41OHDZAAef/IhrDkPFg0x/tIM/FIG24DDCscPzoYUMtKLn+W+w3+MED6G8ahRDxFCO1RmPEli8W8tozKmgfLqypL/mg96nmDHP+Ea38eVV2a7CLccvHMPh/fZK3mABVcTBQwiIEKmzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(110136005)(86362001)(71200400001)(2906002)(6506007)(316002)(66946007)(66476007)(66446008)(66556008)(7696005)(2940100002)(64756008)(8676002)(5660300002)(52536014)(83380400001)(76116006)(55016002)(33656002)(26005)(186003)(45080400002)(8936002)(9686003)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6x1ZyG0c4OUGAQ5X2D23+kgHmVtLDoK36LA94n8rngcVf1gLY533ABkNJHAS?=
 =?us-ascii?Q?K0tsXIRDdOFpzDqIsL5bAoxWYHWVt9vTM32q0Au98e8Xv5Jp4fEzyiZiOuaW?=
 =?us-ascii?Q?HJIAYASP7+dGYCaxopccD+nCWcNHYa0MYm892cmoThAi3K6guhpsECn1WuXp?=
 =?us-ascii?Q?Sv7DBOsajydyIo0a4dqE7+2o4TgEjw4racAlOiMJG7GcDyNfgUEDVzOyxbwE?=
 =?us-ascii?Q?wRAxm/FycDd4WxlRda/iTYM8CzGuLXjezpj06REJChuZm+3CD7J1Fn7Yueag?=
 =?us-ascii?Q?9/W5cDlGuVkTVesbmLR5QYgtB65Rpv0Hmd9/fdJOs0vDPQiOMICzg/hbOQJt?=
 =?us-ascii?Q?5fTdiRmNhfgM5bj/+dYPSHOoTdv+j583n6D92BvgYhn7u4/z8i+oojlkMwT4?=
 =?us-ascii?Q?/HPgSkmyLNpFd0/bxF5zMy5TBGsYHFGDD+syr8hjy1ft+Q/AYIZqAP94oiv3?=
 =?us-ascii?Q?tyPAqzBSORBScGIXfTFeLWQIg0vAw3HtHYDc/pCXRHMZ4DunVMrftX3g5mc/?=
 =?us-ascii?Q?LSG17RnDZdMmtbq4I6CtGLwR0vMg8OPDhPiIK2RztnVzEkzKZ8ifdlre8bM3?=
 =?us-ascii?Q?g/T1sXTysKhAlx+jaMeuYksssAbn711QfaSb4IcLqBs1I9YbPPwe4qPuk5LG?=
 =?us-ascii?Q?xFxyosN/5BvtcNNfniX1cvdieE63Onue0V0XdVMRm3IuNfOwk7zTG7QfyjCx?=
 =?us-ascii?Q?qgthZfefxq8BND58rGy2nn1tJOjBAlzwv8i7FSqj4O9wwhZ35olrVs19hoCp?=
 =?us-ascii?Q?50QauTEJQtJiWfZhX1lofyIFUKxdjRWS9l5u/rM0DZQvY/rCkUwmj96MHj+2?=
 =?us-ascii?Q?fhkyOUPX6a0Os8A2LzwdlVmjL3FqNyB/sAAuwi5kG06eI3tqHk2/G80y6zfV?=
 =?us-ascii?Q?VNQVy8f1+RAH/ASDZLDmRCoK3xqmzY434eYZvp1KOn8AM3payVumesFFvXfE?=
 =?us-ascii?Q?GCzslTWnOL9qIQ08jbaiFLAIlqV8XPmEPPtH85OC2lQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d502186-c3da-4cca-d10c-08d8b2d6ddba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 06:38:38.4603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqa6mg9cAZfz64ZC+IsB1oq/7g0Fb0fvazM+6Ap+NTQhbjZAatAOH8ggTQ6ACOuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sorry, reply the wrong message.
Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deng,
>Emily
>Sent: Thursday, January 7, 2021 2:26 PM
>To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhao, Victor <Victor.Zhao@amd.com>
>Subject: RE: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
>
>[AMD Official Use Only - Internal Distribution Only]
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Reviewed-by: Evan Quan <evan.quan@amd.com>
>
>>-----Original Message-----
>>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>Victor Zhao
>>Sent: Tuesday, January 5, 2021 3:51 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Zhao, Victor <Victor.Zhao@amd.com>
>>Subject: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
>>
>>psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
>>according to psp, linux cmds are not correct.
>>
>>v2: only correct GFX_CTRL_CMD_ID_CONSUME_CMD.
>>
>>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>index d65a5339d354..3ba7bdfde65d 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>>@@ -47,7 +47,7 @@ enum psp_gfx_crtl_cmd_id
>>     GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx
>>interrupt */
>>     GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode
>1
>>reset */
>>     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr
>>IH_RB_CNTL registers */
>>-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt
>>to psp for updating write pointer of vf */
>>+    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt
>>to psp for updating write pointer of vf */
>>     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy
>GPCOM
>>ring */
>>
>>     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
>>--
>>2.25.1
>>
>>_______________________________________________
>>amd-gfx mailing list
>>amd-gfx@lists.freedesktop.org
>>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists
>>.f
>>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cb32008e7e8e144
>7
>>797ab08d8b14eb089%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
>>7C637454298972763193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>>wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;
>s
>>data=2HlggVF4%2B20Ceom5OBfyr0MXYdiLMblwgUbl%2FVEeqII%3D&amp;r
>e
>>served=0
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cdbe3378304364ec2
>161208d8b2d51127%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637455975520611398%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=lmtZ%2BZjKZEq73CsfCX%2FxEcM7rzWB7%2FuKDzuJ7j3Nx8k%3D&amp;res
>erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
