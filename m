Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAA1C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4309A23AFB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4309A23AFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA31689C05;
	Tue,  8 Dec 2020 14:10:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C8D89BB3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 14:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBMzBrt2Wwf4nz9JfrkrzFZATjrYGEhfJxKXsgnHJJ/+ji4KH+yiOmWxAKSCzWbduLgtaRvpG7tTOJc5TSHd36MovvifivtH1mu8tXQxrStCMJEQ0r7hb6ozVECFt0rP0YF2ibwO5sxwRP26i+lXdcqTuOF1+xZSEkMt1tU2sbB5/wfIC4Ufo+kwzecodoKKi0PQy56fxqgmCGMAeAYNNK9O+4VJJKPYJlO7kic+ZWIaWY2HI9xRKVtOMnOtCa/Xu0MdCnx2yh14WnYRzc6JejGjmG+gHBhS0Bq+ijtTCRQiReUgqiGKQVZ44wN6QMXsjY7uu918E423khhDnw2/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRZd9/3F8e+JdS7hVvcpwdQiYqIAnI/f1C2l2ZC9UfY=;
 b=kx0u1LRDOmINm9P/vvvEbcfor8yMqdKisWCxSOm5GiGaixI304SF85FyiiBUzXYS0YBH36Gr8smdGDIRuxxkuv7MqGPp2sncTqbcbfE2KnHRV5QNzdtzcxWiTQMlxD4JqeoR/nWioyj3RCeI0JnnjSTWLC8WNohgEg/j3vmlciMv/JFcmlLYulLjG03T/BgPp3te1nwQt9Gr/ouNHUGSd97sWMjfIXw/prhASn8be5Ox8LGJvjv9gJHm+w9RAGquyI/eE1lIHNgvLRkPEJDTLHG91a/KRmCPJe7nBSqIaGbp6y2aCM18VX1dzoyse7m97xbTH21ygE0cxjGoYZYzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRZd9/3F8e+JdS7hVvcpwdQiYqIAnI/f1C2l2ZC9UfY=;
 b=e8wFg4Z5HpjTP61iwhr5k1rWlpN/yFU3EFzmHUkEW78BpIFnwUfO18N+RFlUxHy1xg9NpbhUtlaxEDnICUQYgmOQgpyKO9ZQWbzRUuCfGWaUh9DQrPqVlV84HFM3vnT/5p7elH2ai/yYZFD8XN3ebKc5y287ebNVMiAgJoKgtTo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 14:10:10 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 14:10:10 +0000
Date: Tue, 8 Dec 2020 22:10:05 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Message-ID: <20201208141005.GA1205886@hr-amd>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
 <20201208111942.6292-3-Xiaomeng.Hou@amd.com>
 <20201208130847.GD661395@hr-amd>
 <BL0PR12MB4913E8D83717DDD2B23DAAF997CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BL0PR12MB4913E8D83717DDD2B23DAAF997CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:202::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Tue, 8 Dec 2020 14:10:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1addfea1-1d11-47ce-f5c3-08d89b82f92f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252357D1B3D8F840CE8D16E8ECCD0@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfNzDl1g3CWVdBKv9TCYN4mKDY1F4TnURxNaqpmPhAdl6KrZb/O0SpRJaPVUr1Bu5J5rXkpmX1+0mPineMw5nRdKPYr9Iqd50grufitoesM4BZuPJOvw1k+BWu7m2epn7AvWo8vpGojUlubgo9nYbVRrRkDxGe+rCsmRHSUOK40+hfeF4eo47spqCB8TSzlRIDT8A6INFxN/TfRy43WCrJNML48tU3yxUx4T8NDWuj1NwLbP1lcdF/HSz31Wil0r5xvZ1FUbbNuv+DsUdUlLYo0lKLQo/pqW9MRb2kMO8HAnb10obwablvQ9AeiION/L9toMNdVWEQPPDA6UYQpSbiTZ2x1rxsIArNyZnwTmDsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(55016002)(6496006)(186003)(54906003)(66476007)(33716001)(52116002)(316002)(66556008)(66946007)(2906002)(478600001)(33656002)(83380400001)(4326008)(956004)(26005)(9686003)(5660300002)(86362001)(16526019)(6636002)(1076003)(6862004)(45080400002)(966005)(8676002)(6666004)(53546011)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GTj6omgBsyFFq0iOnS5naW9aTCKBnxxurbqyw+/EMvQSaUDm37+Ci1gP+nWQ?=
 =?us-ascii?Q?DNSNKNK9jLzzowLE1IZ6jcbS0giyLcTNdR9ySRCdA5V3rS66XfoujKMqMzbf?=
 =?us-ascii?Q?dr3EkSsF8wGwqmOxLej65IXlSB/Km2e25totaG90p8bMDGOjxQUM2qS8WkRq?=
 =?us-ascii?Q?o8lOcMtkVVMdOeH0tX4P0mFHvNDLCuhoDjKD10zPbYOgZelGa19ZiCoZTRne?=
 =?us-ascii?Q?vPH+neaFq4LJnjewPou7JZrQ6sRZ6vWsaIrM4MJNqeOuLMzuNzdndl7tEJ5Y?=
 =?us-ascii?Q?qg6KdiuhSMmNQZc+0EI4pTroJZsroWQzHm363NEE+DE5jcNjNnDDrgodIorv?=
 =?us-ascii?Q?Fl8rlUIbr0PoqGXyfPywibWJmjttQhGvrKh6ed1/5Wf6t3idEyRq+LDUZWjo?=
 =?us-ascii?Q?/xnQ9sovMK5AJ1eWiYAJNX1TIxhqWpkeU9/a6J9/UA9LZVaKqLKyWT4YKgqe?=
 =?us-ascii?Q?zz4bCf0Xb5KHvgaZw2WgvLzqVrUktG7ATOabfgBwxbbmJQHYcjwqqc+VjL3M?=
 =?us-ascii?Q?Zf59/n7+R2efVqD5hXlavLVS/FD4W4HOLz0CBAyP79ptQU4UA8KZrcMFFJXA?=
 =?us-ascii?Q?R+hHMZHYU+xWtESvMtJSm54nxJmVkj6kB0m90BG8N2lwnD5eoR1aSrIYBbjX?=
 =?us-ascii?Q?hAkjfTGCPMI00ObA7X0CpPmmIjQ/mM5w1S9b/NSKNKuwuPQ3K59y41Bug4yQ?=
 =?us-ascii?Q?Jv7oGF+dTGhGkoKOZFQj7jFpcUAHRpJlrdidObFDjtI0TH0mBtZQUghcbiIy?=
 =?us-ascii?Q?7T6h3fDploswWjyUHTyAjFug8pJBfLA2l5HEzpym2283i+uQxuGwzj8S87OL?=
 =?us-ascii?Q?60ibLTH/FCnTkhbbi1c55r/BoSvYT359dv54MVz/h4eWlxH7aWAP7+eP58k0?=
 =?us-ascii?Q?T4PZMHhGpuNskkXJ6rkXcYhgmnaEMPzZ5mPWreSrI9B+asVe9ImXDAEYfwnj?=
 =?us-ascii?Q?ZKcqYmDQQXwYHUL9exU3cHRBWzI63nwlm8TW+usIXLCE/FwXyka9Bv4NxDUL?=
 =?us-ascii?Q?P+RA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 14:10:10.0619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1addfea1-1d11-47ce-f5c3-08d89b82f92f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwfTBHBi+dqiY5z3UWdzf0gzjp/HsPCqae/Bt2viIChqcf8vxnsv60dxnbCDc3H6oqDxV5H/MUIn0VBEmT/EZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 08, 2020 at 09:39:18PM +0800, Lazar, Lijo wrote:
> [AMD Public Use]
> 
> > You can create two new callbacks in ppt_funcs->inform_rlc(smu, on), and set on as bool type
> 
> We can't keep adding ASIC specific workarounds as ppt_funcs. We should make use of the existing ones or have something generic to handle these quirks. System features control is one generic place in the logic which is used to control features. It's used in dGPU context only now, but it may be repurposed for FW notifications.

Actually, it's the new API for all future APUs (gfx10 and later). So we
want to add the callbacks. APU don't have the API to disable/enable DPM
like dGPU because it's handled by sbios. Once we do suspend, before we stop
RLC, we have to inform SMU to stop issuing the DPM request with this
message.

And yes, I am fine to move it into system feature control. Because it
noifies SMU to re-enable RLC again.

> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
> Sent: Tuesday, December 8, 2020 6:39 PM
> To: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before start/stop rlc for vangogh
> 
> [CAUTION: External Email]
> 
> On Tue, Dec 08, 2020 at 07:19:42PM +0800, Hou, Xiaomeng (Matthew) wrote:
> > RLC is halted when system suspend/shutdown. However, due to DPM 
> > enabled, PMFM is unaware of RLC being halted and will continue sending 
> > messages, which would eventually caused ACPI related hang. So send 
> > message to inform PMFM the rlc status before start/stop rlc.
> >
> > Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> > Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index cf999b7a2164..42a32c0e5bab 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
> >       uint32_t pcie_gen = 0, pcie_width = 0;
> >       int ret = 0;
> >
> > +     if (adev->in_suspend && smu->is_apu) {
> > +             ret = smu_notify_rlc_status(smu, 1);
> 
> You can create two new callbacks in ppt_funcs->inform_rlc(smu, on), and set on as bool type.
> 
> Then you can use below macros to implement this callback with RLC notify SMC message.
> 
> /* RLC Power Status */
> #define RLC_STATUS_OFF          0
> #define RLC_STATUS_NORMAL       1
> 
> Others look good for me.
> 
> Thanks,
> Ray
> 
> > +             if (ret) {
> > +                     dev_info(adev->dev, "Failed to notify rlc status!\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> >       if (adev->in_suspend && smu_is_dpm_running(smu)) {
> >               dev_info(adev->dev, "dpm has been enabled\n");
> >               /* this is needed specifically */ @@ -1213,6 +1221,14 @@ 
> > static int smu_disable_dpms(struct smu_context *smu)
> >                       dev_err(adev->dev, "Failed to disable smu features.\n");
> >       }
> >
> > +     if (smu->is_apu) {
> > +             ret = smu_notify_rlc_status(smu, 0);
> > +             if (ret) {
> > +                     dev_info(adev->dev, "Failed to notify rlc status!\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> >       if (adev->asic_type >= CHIP_NAVI10 &&
> >           adev->gfx.rlc.funcs->stop)
> >               adev->gfx.rlc.funcs->stop(adev);
> > --
> > 2.17.1
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C346c5521a1e848a40efe08d89b7a6ca7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430297401242320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6t589ueoS0x26%2FdpzSdtQmjkRygo4ez11t0GuBMacyg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
