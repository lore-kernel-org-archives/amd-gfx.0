Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE7FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE35723120
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35723120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEF76E826;
	Tue, 19 Jan 2021 06:57:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B6F6E826
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 06:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaLro3OVyrRDtEz0HsmUnMMemz2L+VIFFMXn0abyBtqWTlW2R7uOQkOPEDUZUfWgXapitB/hePW/myoY9AcqHtDAGr4jC5MbXEzGLMkBOmCAYCFjo+LaMEzAVAAe+NquB+0Pf+EIlvCdGGRgon987GZlO/15rFNX97pTI6zIu9mjBrQPmIeXa160jEr74pQDPMbAXI6aDE50xvNrHLTqlbDtsc80bJnDL61ejAyUVfZ+CPU3SY0HR41k1qGN8X+g7jF4Jsxm7syKemGUwtylSFO4apyqGsC8VDB3UkQHErMnr3uYaGyA6fAciOd31ZP6u7DACEz3/Cr+31eGFwKH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHXR89yeHvcCuJuSdVuAn/xG6dyZuXIYP7UHqxihi3w=;
 b=NBseBn9MVQJS5qmcPeigSf11PLlcRzeTaNxuCzZq7lCJ8jbCQNrNsPJrQoNLf+r1USaEOSAAhonmhk6AmJNSHQdY+Mo3OuDyl8qlCnxBiE3XqDnRe1jRTfey2LKNbrG9eqRHPDmK9pWsEsFirffR6OBf5IPp9in2esWDNQnxiSB7U5naz+/FB2dabiwBm7efmU5uv4np94mGHJEY5y85KAFci8X+BNteH7gcuCqicZIObNm+gFI8r51ceeOCN3TU/GKsljn0fmg138qO+jBEXwWxxm6IKHTCq2XbiSc/ACJcGqfDDiRDJEtuuiyZVX6rO0Ennd0O/8QUAasjBFgMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHXR89yeHvcCuJuSdVuAn/xG6dyZuXIYP7UHqxihi3w=;
 b=MzfEYScoJuP+u7leocxkMCxkmZ3+YJ3rdIG4fRZg7I/FMdtF6DnD51YfN0Oo0sqYPw3hCfT2OR5SREvneKBUIMkYFASVoJ1Kii+HIRJczYA7bJgD09Ftg6RRldXqGHe83ScNet5osIKIQXPZy8bpZqRwXTg7hoEiGLCzm6UtwkQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1247.namprd12.prod.outlook.com (2603:10b6:300:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 06:57:37 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:57:37 +0000
Date: Tue, 19 Jan 2021 14:57:29 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Message-ID: <20210119065729.GD22628@hr-amd>
References: <20210119055135.70134-1-ray.huang@amd.com>
 <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6 via Frontend Transport; Tue, 19 Jan 2021 06:57:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b51e6399-8681-49fb-0f35-08d8bc4780b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1247564336C032F85F9AA83DECA30@MWHPR12MB1247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYVVovDhiqLsFBZz1bzs/GTMyStpdVMUifoL0PRKnAq3fJoQ1fdqGROOv9QNizG6PxTa1h+SMfsVx0gMdijN8pcLl8IVIVPRbYkT1EIrUt6NwwqzWhB9jJzlFfLB4w3UI5KP6oDSLGJ1/K/SEyt9J4esXgKXrasJF+SGEaY7kP3utCZo5U/9oNQgQr74yZuyem6kCZtKaYxPTQ7QaVbeyS96E1nwLBItTBA7zgUD1kJwHxaWmdWeK7tnn7GMAUnNDXMdkH9w7jIQto7s4Q9ox0YhB/zfj1vc2pnENFCbugAueFMiZPJnXClKO7n3clmCCL+prDdwzz2hzM6zt73dCRkY3aWaOuldXIsRuM+PxtmkT8OP2zsmMhRSdKYXziJdp4WNoo7LCarvtLzxQfeFCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(6636002)(55016002)(9686003)(33716001)(2906002)(26005)(6666004)(52116002)(6496006)(54906003)(53546011)(478600001)(186003)(33656002)(83380400001)(1076003)(16526019)(316002)(8936002)(4326008)(8676002)(66946007)(66476007)(6862004)(86362001)(66556008)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hHViv01tkqlh3ODWsA7+Ul5Bd7TsxVIPQLKFCS4oAkzXsqnHl4Nhy3IEOyUp?=
 =?us-ascii?Q?Mwz+tlrA2GqeBRxGmpkD/aLq9c7YtzOJHjT5O3JXycWDBC9tk+B0NA/HgVeu?=
 =?us-ascii?Q?NZro18w4uOy2mqVjKTFEwuYBrklyPsxGBC13iw6/oNSxq/AHfnFkpCCeK5+D?=
 =?us-ascii?Q?iI6J6Kxfdg4ByV3MMpxQC+WjqxyBziA/s9sHXb81BRjc0brAIydk/9fBacwy?=
 =?us-ascii?Q?QjbbEMsppwzmqmZm6P6ix/Bms6/jU6kRSIKCdcJxs1OMvJljViUCnpg4T8Rn?=
 =?us-ascii?Q?uuwcuk0fmxNGiprQdqfNVESWRz/aKc/3TVBHiURf0dqYBY1q+wGPiLhp+KdK?=
 =?us-ascii?Q?142NUfZ4BkM3ROlLP9i4c1Z+b0sv94bdH6JSjaFDz9cYxJ0Q8kKF1LH4GWlb?=
 =?us-ascii?Q?TbByGozm1nSNiDqSo9uo2fqvgc2goLVLfUB2S9jU3weVL+8TPfBhmXM1HxIe?=
 =?us-ascii?Q?fnOzFYJBbvWm7pfP8teLz9NQ5GvgcA/5gO8oefa46Uw4rD1dE/EugSyxBBhn?=
 =?us-ascii?Q?ox4XN8X3z2KkaPqSgoeJPhst2mV5CJSSRobMRB6VYYLEv246HfASxyazjlGy?=
 =?us-ascii?Q?cJpqkZKpY9txZuthXBUZqIohAXN2D4odTmzpq7Vnzel9+cSCrxcQL0cxKfgT?=
 =?us-ascii?Q?5IF9RbicNsbuCdwGK1QU4iSpHNO3dpxmjeR1T1+D2eTbgRDo/5/zyBygkhsc?=
 =?us-ascii?Q?ns6l9iFCRaZezfRzJVR68bFbdZ/1Szj3VNYOWwKnHRRxBGRisOrpqxVjsP4e?=
 =?us-ascii?Q?aovrVTeiTEYRMQXyioSXpOtucTfi3TdhGLnBEl2z7lTM8bgQnXvvAgFs8iwo?=
 =?us-ascii?Q?vkpIbpY2xEvA3+FezIP+hvHZ0HLN1jzu/rOrr0UxErtgZvZoFnvG9AYRUcBz?=
 =?us-ascii?Q?dYxFJHFL9kXO+BX8QJD7f4LNb/5o67kXGYTW7imbvdrxWoPkjKz24Pu25Dly?=
 =?us-ascii?Q?USinMctx7pE2vexcmCeXaY3RhtDdHQN4tYp8BF13YinUwwn1rrIKSS+0gMhS?=
 =?us-ascii?Q?RVw8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51e6399-8681-49fb-0f35-08d8bc4780b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 06:57:37.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDWF6rgz833WLBbsX+PTFSqwQyR5Wag3Aqh9FyxphgA6uYF+lFDZ72aCTitkLrU0sclt+Dpq4v0AudGJclGZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1247
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 02:25:36PM +0800, Liang, Prike wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Thanks help clean up. Generally that seems fine but could we keep the green sardine chip name to retrieve the GPU info FW when the IP discovery fail back to legacy mode?

Do you want to only clean MODULE_FIRMWARE(gpu_info.bin)? That's fine for
me.

Thanks,
Ray

> 
> Anyway this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> 
> Thanks,
> Prike
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Tuesday, January 19, 2021 1:52 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
> >
> > The ip discovery is supported on green sardine, it doesn't need gpu info
> > firmware anymore.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 4d434803fb49..f1a426d8861d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -81,7 +81,6 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> >  MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> > -MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
> >
> >  #define AMDGPU_RESUME_MS2000
> >
> > @@ -1825,7 +1824,7 @@ static int
> > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
> >  if (adev->apu_flags & AMD_APU_IS_RENOIR)
> >  chip_name = "renoir";
> >  else
> > -chip_name = "green_sardine";
> > +return 0;
> >  break;
> >  case CHIP_NAVI10:
> >  chip_name = "navi10";
> > --
> > 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
