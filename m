Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AB1C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 01:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1443A10E027;
	Fri, 19 May 2023 01:07:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC1310E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 01:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2j8DmPz3/gyWSEPuFGdX28vgKUHQuVJj0ZEoWqr+ayPykPsgR8NDQ4i6XIGSs8QoFMfVPf8B29fErWgWAYeX3LWWPd7BogYqG9AIRnaIu/U6uJaSn7+DtSzweDPpL1Z2jQvR29zfxisP7+xwiYbN4Wmo5Ps6JEuvSW6Gpdg04EwSKXMAQE1pnWmS/aJ8U9cgiyWQ3sKAn4/M+QlQbpG4X8HSMZ6SlmDhT4s/4WohGiNjouPrMgqd8pQdanmkrR4wZDKcXY84tY2u8QJZZY6cuiAlmeWBV79JOwZFsBrcHcXfVQclM9vGg/YU1Ii4k4rpUcO1vB/jGdomjieAUe8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AxlXwqBm4v/+NlvJft5QjtyER5+k+iwJSXRt941fvE=;
 b=Ft2dfgijSLPXewhoLcpj5p7UrC0NQWdKAUqRyBZudbvyZtxeDgwgxEx3fCQH/eEIw4L2PxFzlwzhDzX/Evej88hSNkzbtr+N+bDPdt80rORMJ5vWUkwlGkJsWPXcm485xr3IgKBtqALh8wK+RQT1YZwgvo1bVvLOZ7aZf0ZVFM0dWxLYLH70FbsW/VBjbbZ2U7FOnu/7T3YSYomYRExHs4xj+dPFMth3x7Xbd/UYZsbvdpYekd3F2iBxkoOtWBxgk72BP8ykmo3DedOmpsGKe4uD3VfCw70wqFjTRPovuiRJXCDCorkiYibxzgt+NjL2UnGScRGDH96t0d4wwM0AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AxlXwqBm4v/+NlvJft5QjtyER5+k+iwJSXRt941fvE=;
 b=gpOOWo1i1suJg+ieEv9Mdd4gTe/DUP9fzQ16sX9kYM2gp+1UGR6hWG0AXzOcrtfijikdnRXZEutUWjpZMd5f3uFGmUu97ngy216yiFN/9qWIcW8++1eq924wVDDtZEY9HNxVP4uwwKx2WcX4JQBqL7RQLQ0TyLVgbGa9ux4PZi8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 01:06:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6411.020; Fri, 19 May 2023
 01:06:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH 0/3] cleanup abuse of sched.ready in each ring init
Thread-Topic: [PATCH 0/3] cleanup abuse of sched.ready in each ring init
Thread-Index: AQHZiVa5TpZeBzp3TE+2D1+Enmnga69gHJsAgACsG1A=
Date: Fri, 19 May 2023 01:06:58 +0000
Message-ID: <DM5PR12MB246930870A68C45FEBC585B3F17C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
 <BL1PR12MB514476AAFB76CFD21C81BFD3F77F9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514476AAFB76CFD21C81BFD3F77F9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4c7f0d95-7093-4c19-a02f-ae14fc73afe9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-19T01:03:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4435:EE_
x-ms-office365-filtering-correlation-id: 94f0d54c-1d66-485e-e2a8-08db58055836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSk/ljRoxPCpHctp6h9M86kaEuBr0AuG3SuvRLNAH84yoRYxUnn/L6KnPIyccU2gdAH9zyMoDJC79fkNO3S0URXhwUIc7HOWcjQLjQpBlqwIqTEFRqub7T7UVOKkmA2iM/RQHg/qb+6RjHBtVx7MVtI0gmFgD9H9hlFAQ0I+cpZU4+aejTiwPSzKklVXhDJvaxSF61qAjj/ubukfocFjBxIGy9RhOsluKb35s3S1wIezvYr1Dkz735xywvy3E2Ca5bS4m0yNbVVS7zkNJlwqGXGVOHsulWUtxfrZiQg+pK9kQbrT0hcMyAWTWe2l+XSsAutDdIQP1L86OOolW76++wvFTptngBgIA2AfUVhtF+4HkfxsnyhHpX1pEgSLjUJd2vvwiyvz4Ie++gNpzHX1NRA8Lrv5mgKp+VPX01Sfk3MUI3tJDSu9gRLXJjuc28+71sVoOg9fbFSUwTamUXEitKevuufSldytTM4PZUvgwCZG8tBRdUYsBf/CluUO7aQgTFeO7t5wQX4eMsULAnprlVmvMQ40cdJiLI93YzRqsMZUP23kZa3Ua0C7rj5tL8YqSlVT/aBK90EN8PeqbDxsMxLseykoD9Pmql0GYJYPUzYkOuYvv5KQr5V4TETogp+6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(53546011)(6506007)(26005)(9686003)(7696005)(38070700005)(33656002)(122000001)(86362001)(83380400001)(38100700002)(55016003)(186003)(110136005)(478600001)(316002)(2906002)(6636002)(8676002)(8936002)(41300700001)(52536014)(5660300002)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KQTfyF1dq56DkHSLNcqLX1o3fg7cg+5+L1mUuCFwl585aUgByOk+7yZIcuML?=
 =?us-ascii?Q?F/gzm0CJ2qZd94O0TPmFn+BMoR1im1kgjNWJW5HmB37Y6IoHwmpvfX94LI/G?=
 =?us-ascii?Q?4ByH/oe7cFoTZlPBEozmUlWaAvwxjfmI9hMe/fRy4vjkO6W1uTRihwMjCYwV?=
 =?us-ascii?Q?AKpFuML3f5xt83bDdKP6k6h9VESvChYJjZnJjpdZdsZyUto85s35zouL/BY0?=
 =?us-ascii?Q?yeRMxLQeleHO6YhCB+YPvaO4VZwBL9DNAnMSg3iaU0dQkoe37LYOaugqQ4ig?=
 =?us-ascii?Q?RK25ctb+8sgFinw3WXmxhJf5jmF8HMyHcXBLmpPcYGztoJgIBPxIo8QtIoov?=
 =?us-ascii?Q?eVf/BUsYwkuXBH0T9stIjPMg+eJPIQINkVFN7xBYUIgaCcYaWHeH8VUWBKnq?=
 =?us-ascii?Q?el5mFrYFvj5vUjTIK+4N61PXgzVV8azdC2J5QU5rZ80BBCAsfhbjncoHxCVN?=
 =?us-ascii?Q?KuYnNrZLIl0SkQURSWmJR1YlVv8AwG+NVjWmoAPQDmrvCoB9lRchHYVSjD9v?=
 =?us-ascii?Q?y08K1CCK8L+IE/2IxRImPxswEuZKO930scY1zs8fat+mSxLRy6ar56ixP/LP?=
 =?us-ascii?Q?sQXAiLEQ5XNGeUn+5XS4cwVKIi+IFcHT5rczTHSER1hJkmhiDGeraIwH3cp1?=
 =?us-ascii?Q?hzNMadD/6PHxrnUMkyZT382iwXcshnN7/n2nCWMQ6ihKgQZBLUaiy9VH8wXX?=
 =?us-ascii?Q?Lu5cDTGPboxrQg2wbm9wcYpmZDurvsEoiDUQ6qE9Wij61LYpsSm8Jn4qHRIq?=
 =?us-ascii?Q?V60bqQLQw96NITdH5LzIFWIP/1o5TFLeZpBt37Uepphva9MJYao4ZcxuTZ4/?=
 =?us-ascii?Q?2u8ZmkocGWskJPTEjMDg8g1sEzodXGK6aC7XQQLIZlpYIzuEKCks93X01cNw?=
 =?us-ascii?Q?mzHVvXUf9ilAXzrcEAK0zUXR7S/vlcJAO3Rl5ewl+HOCHgTK024RGxXrGkxR?=
 =?us-ascii?Q?egSTVaBSxlHWUBWCo65xAD/uZFC9IZjXzYg0nmCBT7ZcAyV1IWDQC4A0uRNQ?=
 =?us-ascii?Q?VGFLnOCDyO59jrxUATZzG9ZEytBm0of6FgToMTGrMdOpR3VBLNs0Z03F+sM5?=
 =?us-ascii?Q?dKpaKPQOrGaxYa47xbOIJe1/GRJsU97bMZ7rC6qEXYYHEoynuYlPWXSblovR?=
 =?us-ascii?Q?lPkyiRdddztNnxzcmItqPaetGltKVFidIRzAsmTmCCVN5jKxxT2ZWeOSHN+B?=
 =?us-ascii?Q?7cFpHkdwFgW3oQq4jyyBDbdRC/wUBFTqg9y/gn1mCCvNL8fMi0mGPkvy/asz?=
 =?us-ascii?Q?DYRhDz/a4TYHhzbeYDUckg4aSGyWIYmtQGfpyqfhqDjnqzUa1UW2JujQ2q0z?=
 =?us-ascii?Q?YvkC5EzANzXFDSUJJfjYkdiExbKuM4qp52ntpxiEfAM5F/nsjDX2ufAcFfbw?=
 =?us-ascii?Q?LEzGmNDrKEsiaOueaqDBiUE3uG+1BufnHAim3XPZuWJJd8As0v7Xz3iKq+96?=
 =?us-ascii?Q?3YdUTinVSxrTPMfsr3On4FuEFG2iVgzXRjtre+cXjIhFs0tVILBVxHlcmMqf?=
 =?us-ascii?Q?ykEWU9Cihf2b2tGyJ9kKEHysrLr1AUhvn7dtN5zYbNMDpN5/+y5hfKPbdOWV?=
 =?us-ascii?Q?wnZlzFWIEixeBDwBRRQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB246930870A68C45FEBC585B3F17C9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f0d54c-1d66-485e-e2a8-08db58055836
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 01:06:58.1073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f86cYZheXlKdjT3uv2K2KUyW6MiESBVykIeEn7cagYALMA8h61SMGJXHf3vxvl95ZQj7diZUYfPTZ9ISa5M2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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

--_000_DM5PR12MB246930870A68C45FEBC585B3F17C9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hello Alex,

Should not. Almost original codes set sched.ready before amdgpu_ring_test_h=
elper in each ring initialization. The new codes drop that and leave sched.=
ready set in amdgpu_ring_test_helper.
I tested it both on gfx10 and gfx11 chip.

Regards,
Guchun

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, May 18, 2023 10:47 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhan=
g, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 0/3] cleanup abuse of sched.ready in each ring init


[AMD Official Use Only - General]

Threre are a lot of places in the code where we check sched.ready.  Will th=
is break any of those?

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Thursday, May 18, 2023 3:02 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Koeni=
g, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; P=
an, Xinhui <Xinhui.Pan@amd.com<mailto:Xinhui.Pan@amd.com>>
Cc: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH 0/3] cleanup abuse of sched.ready in each ring init

This series intend to fix the abuse of flag sched.ready in
each ring init process. Its status needs to be updated only after
respective ring/IB test in init/resume.

Guchun Chen (3):
  drm/amdgpu/sdma: set sched.ready status after ring/IB test in sdma
  drm/amdgpu/gfx: set sched.ready status after ring/IB test in gfx
  drm/amdgpu: switch to unified amdgpu_ring_test_helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 24 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 25 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |  8 +-------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  6 +-----
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 --
 17 files changed, 15 insertions(+), 95 deletions(-)

--
2.25.1

--_000_DM5PR12MB246930870A68C45FEBC585B3F17C9DM5PR12MB2469namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Should not. Almost original codes set sched.ready be=
fore amdgpu_ring_test_helper in each ring initialization. The new codes dro=
p that and leave sched.ready set in amdgpu_ring_test_helper.<o:p></o:p></p>
<p class=3D"MsoNormal">I tested it both on gfx10 and gfx11 chip.<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, May 18, 2023 10:47 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/3] cleanup abuse of sched.ready in each ring i=
nit<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Threre =
are a lot of places in the code where we check sched.ready.&nbsp; Will this=
 break any of those?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, May 18, 2023 3:02 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@a=
md.com">Christian.Koenig@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto=
:Xinhui.Pan@amd.com">Xinhui.Pan@amd.com</a>&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 0/3] cleanup abuse of sched.ready in each ring init<=
/span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">This series intend to=
 fix the abuse of flag sched.ready in<br>
each ring init process. Its status needs to be updated only after<br>
respective ring/IB test in init/resume.<br>
<br>
Guchun Chen (3):<br>
&nbsp; drm/amdgpu/sdma: set sched.ready status after ring/IB test in sdma<b=
r>
&nbsp; drm/amdgpu/gfx: set sched.ready status after ring/IB test in gfx<br>
&nbsp; drm/amdgpu: switch to unified amdgpu_ring_test_helper<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp; |&nbsp; 9 ++-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp; | 24 ++++---------=
----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp; | 25 ++++---------=
-----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v10_1.c&nbsp;&nbsp; |&nbsp; 8 +-------=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp;&nbsp; |&nbsp; 7 +------<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp; |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp; |&nbsp; 8 ++------=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c&nbsp;&nbsp; |&nbsp; 6 +-----<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 --<br>
&nbsp;17 files changed, 15 insertions(+), 95 deletions(-)<br>
<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB246930870A68C45FEBC585B3F17C9DM5PR12MB2469namp_--
