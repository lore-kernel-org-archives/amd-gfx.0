Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B578C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 12:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41275206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 12:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41275206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54B4897C8;
	Wed, 20 Jan 2021 12:15:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7B8897C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 12:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuSmNaVsGfuVE6+lLbg/7dRXChgou8SO9j4EELtsV3F55BljSqr3vIgXbEdrwCz6a8zv8/kHinnYL+TQsfK5ho8usnMAgUfq6JbdZv//dRuppxMlsV1PkxF6ru42H/scxO/CyW07b3RgVK9ml2wfvZex7SgewOzeDl/NJQeRfvQ+BeATvzrKvgzIo9VWlLhjdCmKdopFNtREMJTqmhXLhqOKvAheMKvFk0FvSvq6Kmv/FBJ2ln6LjSd++RWjF7XUsR2y2ezKEnzgBsp25gbMKlP3j2GrIAe86yi+jxLdnsVm0HO692fpe1wW+4p67n1l11dcxVF3aLUCwBJQK5R3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kORywbUpBtOKwNwKb6efcxNzJV1KDon99QhdJkBRb1E=;
 b=hkoY6xMt0Blyx3tnmhdMTDQVo/F9lhonz+EIWrbEr03+cSOCvyZVNwwTMxVRcmKvqhB3PorbR6J39zW9LbPUieMGJpFzsvOIX365g7TWTbCv+WcO2Y93po/rBto+iETZBR8cisBquDF44DQhaF7bgBFX+5UNVV0I29qZz5x6EArXaVdmajgqiTX/dUp+3SvrokM2KrifES/Y9WgOo35Q8+ucazkvuJdNRMtxiSVBecWp7xBnqtlGXV/tH/Sn+9dLMv6jbdwXM3X2F6eBCq89H03s0+bJvT3UZOLI1x/vpqyO2vXvossb4VaY8HXevCnirld8Gy4v7rV3ELDBbskBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kORywbUpBtOKwNwKb6efcxNzJV1KDon99QhdJkBRb1E=;
 b=Q3aNpNu8mgYqBt6kbhgIHX95lBLIOsn36VMyQgbkwIhTNeUubjkcjdLzuPw3KEoEOFyyYmZHwfXVyPsYCF99FtFYfuZyMbsd3j5E4aKOBK45oVr0mC3lH9TfzDpjPqoxOVfyupiAzATNQhkeyz0avmnqU/ivmo81XVso6BTZ1po=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 12:15:06 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 12:15:06 +0000
Date: Wed, 20 Jan 2021 20:14:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Message-ID: <20210120121458.GA657205@hr-amd>
References: <20210119055135.70134-1-ray.huang@amd.com>
 <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210119065729.GD22628@hr-amd>
 <BYAPR12MB3238D59E095B5A473363325DFBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
 <CADnq5_MJn4xPpDBbQvADN1nM9MKwv+9kk4a3HvxWy8b1GZNqKQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CADnq5_MJn4xPpDBbQvADN1nM9MKwv+9kk4a3HvxWy8b1GZNqKQ@mail.gmail.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0222.apcprd02.prod.outlook.com
 (2603:1096:201:20::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0222.apcprd02.prod.outlook.com (2603:1096:201:20::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11 via Frontend Transport; Wed, 20 Jan 2021 12:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f8ae661-45de-4054-aab0-08d8bd3d0605
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43643A6A8C437F1EF2D002FDECA29@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcSvTz09U413A/647k+WLCk5Y4m5vs0gpg+7bPiTekinEum3+tjR/2ZeYRNNprxM2LKxC1d9GKfwG1tZZsqiCaNJQNd8uLoGVxWwhTGBsg9TftmAH2HOd2h5Hbyc4PVsZnxLz7K5dB8mY2vtaJIZ+JMezBzeI7xCO2rEMwvIh2k8OaaMc1ux+IZFthFyp4r+u6ic4B9vBM325UQiRT4FtUGe3J0oSdrjFi2tDJYtmzdFLLLH/JFhyOc/OZ5xE64KR8SORKpcNtKwxPVnNW3+K4JAj7yBmnNnt5YJb+w+Wzs3KLiqpt76euirKgdiFl08qE/9LPFQTWMoZ/aVi3Gtvohe95YR1FZmFYjz7LOUk2Kb9L5pBqvKuqrb47Pu4eGoPb4BeXm3Kq4fxV4t0O4BoDEbAUUyIHpHYNXv7CUMUdADY+i11yLIQ0GirNjaSXPeFo/8FK9YiCrnJZollMdAcf9CA3EuaHaUaela4Fe3bdXrMhzGNyL5+YFZNZ+gThmZ3X/cNstBWntJgRRVkIpUoMuYVSCXsNPRzorHvttPSUfLUogpC516o2v+UdriAPGb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(2906002)(6666004)(9686003)(316002)(5660300002)(966005)(478600001)(45080400002)(6916009)(186003)(16526019)(52116002)(6496006)(33716001)(26005)(55016002)(33656002)(8936002)(66946007)(66556008)(1076003)(54906003)(956004)(83380400001)(66476007)(86362001)(53546011)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pq0Ywde8BPUjQPbmiAZHIwE34IzS6+VVKJW6xJcz/wtTrJqJ1xTA7uOfAU/Q?=
 =?us-ascii?Q?/xhNSw+Rk6SycSLQgEP4hyXKrNZB7oNeJ0KPXsopSpyHNb/Y019A9yIp5wsv?=
 =?us-ascii?Q?uAYjNN0QgsqWEhO1mriPdcQDwAHGgzIcCPS/+8qGNZDV5Z5iKFI1bWWVk6yP?=
 =?us-ascii?Q?0hpk7CMDCgh2xGf0HYpj5tGS7zzoop707mapTvonLePZ0JzxDQeZgaV4iB58?=
 =?us-ascii?Q?a+bMx2ofoAmH7Ax4o/atfXTXF0xoepIT9i9ExLGsxizgFc91Bp+eGW7ZR3tu?=
 =?us-ascii?Q?R/+pMjvOD1mISYxqMR3FUggbQ4kyqZUuijGyAjRHsgjdQz4vkMocYnNbrw2k?=
 =?us-ascii?Q?s9pDvkvMpuhLf2eh0+8rIPAuWAZpD/fl3m8YnZlbKEzDLYnoyJGKHBg+Zung?=
 =?us-ascii?Q?5mHnsBZrdCCn+829NqWVCUcl3NO4GJF7uh/w3+h11OF3HEcXfZytZ5x6RMxI?=
 =?us-ascii?Q?DnmIBBqKHFLDCoFi4OC2DVuAtuEbr6XAxveKoIMDzY0GGfxC5i0ekwERqCrO?=
 =?us-ascii?Q?3+a/nO2Dfo0Mo++9PaNkl0YhW1JXIvES4fjsqu1txGx4AU17l8uZwUfP0qwj?=
 =?us-ascii?Q?qnvWRxvpTV1h3cPRSbr8X5fZTl5bPYYoV0hR1tC1m6qUWsaDsd3HOS6gLJAV?=
 =?us-ascii?Q?ah0MGlhK0XxJQ6UniZnl0vbNDZxMR9GJcOYXxAq/YMVn62TKgbNuZJEO/3SK?=
 =?us-ascii?Q?3JAKsZynsripSckZUR4Uw2zR64KUBSXqWpXuV4GAXiPnoRWLHLGI+EVY3T3U?=
 =?us-ascii?Q?uGk0tlZXxOAkA5ZA5xJK6EEq2rEb6RnaVX2rL3dr42FdgvnO+GSLZyiCY2kX?=
 =?us-ascii?Q?0OCTmC+8T6CDdAl69ZjcTlHjrDfdOSzhE/4DaVii7Agp0eZHgu3U7HXikKeb?=
 =?us-ascii?Q?Luuz4cQ8MpRszyYm2K98/sAZ/3WJWw2SdpcC8ZC6HrFIvBn7LnYiwbuEF7Pc?=
 =?us-ascii?Q?NxOhoyws3tagwD+RdJxHUMD2R2WNBgBJ2YBRJ0c4aZW4hpsjEYPbPXWAM20L?=
 =?us-ascii?Q?R85V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8ae661-45de-4054-aab0-08d8bd3d0605
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 12:15:06.7883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqhZr7Z0VXJNdeScYYZfudTpeIbRTN/jZer69mrDadDrsCAxPkdyI6SfLitNlN8YHdL3Vv5zWmzcUGuUCXKI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 10:11:54PM +0800, Alex Deucher wrote:
> On Tue, Jan 19, 2021 at 2:20 AM Liang, Prike <Prike.Liang@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Tuesday, January 19, 2021 2:57 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green
> > > sardine
> > >
> > > On Tue, Jan 19, 2021 at 02:25:36PM +0800, Liang, Prike wrote:
> > > > [AMD Official Use Only - Internal Distribution Only]
> > > >
> > > > Thanks help clean up. Generally that seems fine but could we keep the
> > > green sardine chip name to retrieve the GPU info FW when the IP discovery
> > > fail back to legacy mode?
> > >
> > > Do you want to only clean MODULE_FIRMWARE(gpu_info.bin)? That's fine
> > > for me.
> > [Prike]  Yeah, that seems enough just remove the green sardine GPU info FW declared for amdgpu driver module.
> > >
> 
> We can probably remove the renoir gpu_info firmware as well.  We use
> the IP discovery table there as well at this point.

I will check the renoir platform later.

Thanks,
Ray

> 
> Alex
> 
> 
> > > Thanks,
> > > Ray
> > >
> > > >
> > > > Anyway this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> > > >
> > > > Thanks,
> > > > Prike
> > > > > -----Original Message-----
> > > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > > Sent: Tuesday, January 19, 2021 1:52 PM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > > > > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > > > > Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green
> > > > > sardine
> > > > >
> > > > > The ip discovery is supported on green sardine, it doesn't need gpu
> > > > > info firmware anymore.
> > > > >
> > > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > index 4d434803fb49..f1a426d8861d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > @@ -81,7 +81,6 @@
> > > MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
> > > > >  MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
> > > > >  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> > > > >  MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> > > > > -MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
> > > > >
> > > > >  #define AMDGPU_RESUME_MS2000
> > > > >
> > > > > @@ -1825,7 +1824,7 @@ static int
> > > > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  if
> > > > > (adev->apu_flags & AMD_APU_IS_RENOIR)  chip_name = "renoir";  else
> > > > > -chip_name = "green_sardine";
> > > > > +return 0;
> > > > >  break;
> > > > >  case CHIP_NAVI10:
> > > > >  chip_name = "navi10";
> > > > > --
> > > > > 2.25.1
> > > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRay.Huang%40amd.com%7C357c1e62ea18494c455e08d8bc84345c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637466623291655763%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qno95OlwKt81eiajh%2BDStj136Hx3%2BWKe8gai4MA4okA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
