Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7473650EC
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7473650EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DB96E47B;
	Tue,  9 Mar 2021 06:16:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495136E47B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 06:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5Y2N+Ux+1/jmyBID/oujA2i3zsEvfRrTbzBDk2XvZtt86olJ2KMvqtpjhYSQUa0DzrTsMEY6Fo2gv/rTtb57EYnzoStd+JYdnfAn7qRGPeAbVu5fvsxWsojj/vy7IFj9oKRxf0lrpXk1CJ51bVNeDqPS0ekYb4lW3RGd07ZRu9EAjHcpU+AaoeZCdceODBnWFBuRa/lnf0ggonPV21FwpNytcJL1iG5NsvJWJmbAIqKTR3KFX9LRStRmdUlJmOVSVoJpUeftSpMWl5i4NGY5NKJ4B+gKLwFlGLXGFhA8vwGu8k5cTTR2aZSMxQD++r4Vgxll0Dd1WUQAEJAMXQTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81i0jRL9k0kNCMLuf44lBPM8XigmHuIplsbv2rbxn9o=;
 b=X2cH7ZoozlThby036HKvH6fe1elPw3fo4VKQownXSVTALFwZuvdR0qj5W/PMchAEtRk/MD0pq8F4nNsFZ5JfRwsBueNbFLOPtWYeEnAGHktILzOIoqB1sqDDCfJSh8mEn+NzeNob+lqtVrYeuxfcyOJKNayFrn+DYguGrwBQToETdWEYwfgntl9QADgnpJfXpqXo+RSclxhkbaNuJwqDwoE2VjCkmJ0fTi6dz23fnEcTN6uwIzHFB4lO3YWRSyOrvPh8J71QWr5gxBiOXj+pW4cxMSGBG4HB6YheAsR1sQmnvsAhuYdj9IlwBEjv8dsBx30bYeWbXQPBZwM4LR7Yeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81i0jRL9k0kNCMLuf44lBPM8XigmHuIplsbv2rbxn9o=;
 b=EtTBNTVklAT73NjxxFhq7XrUFNEWPPDQtYyp3+e30G38qJC+dntO1S1/PwgoWWZTtxTfVM8LnvpwbLmt5Up0N+9Bl3W+k8FST42lWXmu/cBeVRNyYBgFuPySYjupC/ooSTpJ0bnI0+cM9uhJXWDHBVo+9FheAWhFyNjKQjf12pM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2395.namprd12.prod.outlook.com (2603:10b6:907:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 06:16:20 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3912.028; Tue, 9 Mar 2021
 06:16:20 +0000
Date: Tue, 9 Mar 2021 14:16:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
Message-ID: <20210309061615.GB1582145@hr-amd>
References: <1615261905-10482-1-git-send-email-Prike.Liang@amd.com>
 <CADnq5_MWkxBLBX-U0rv7NMSX-vmt+2aKO1dNYDTv2sVhyx6bzg@mail.gmail.com>
 <BYAPR12MB3238314A7550F5A2C1AE846DFB929@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238314A7550F5A2C1AE846DFB929@BYAPR12MB3238.namprd12.prod.outlook.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.23 via Frontend Transport; Tue, 9 Mar 2021 06:16:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c81ac258-fb9f-4b20-fba8-08d8e2c2db02
X-MS-TrafficTypeDiagnostic: MW2PR12MB2395:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23957923DF5A84F9CEECD85FEC929@MW2PR12MB2395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+cWP2OOA5jxJyx38nlayUfT67v4KT6x4nWt5pcI5NaBSrKS8a/bMvMKwx0lmt5tKTRGNOlgAI+M2ZtELvUdEho4Ot88cfOpgC+vfTsBZj4biZNkKvHSNrQdfCVrmuAuWD2loHhYd2nJDiPW9EMgTeQ5pj+u7QBUye19t1ndu1IEk5aDkWT10NZNmmPaNyw6Pttp8sIj2/r7dMZI/dD6HsOLniJWAcrbV9yKhtKhBVq16B8R6wG2H9p2Ar8fdq1Yy9SBBxX503FNYNSZS5lxMzlmEeWUgPGPhprfhsWYHe3qCJSFkmwIe5CKshpKiyYG2LUeMiCDBdd5YNDiMsc8gCni+OY+ut0zGv52ryn8w23lrcryH3QbYfP1u07xwt9JFKC+K0eXeqi1eF0ezwLElaKLctVbgSn6OrO62nJFRgf+EfBtI3Dm+EUyw9b+drwSXC2bcCe6P+GLj8LV/d252dpIk+EOd5Xk3V/LS0094mZNQCjUUl3qCVRj8kvWugQQKrwXvdPUEqyXOVU5lmMLM9qQENL0vIlJQWUqxiuAX+GLz/IEaQEMLU0PryLX0q6WV6Q/S8MjWAQZDZ8Duoj1bV4lH3TVBVu3ZgMIBUDuYCI0Elaqe+XFWRJ24PuEck01hBYtKiehNmvHPzqtvIn7Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(15650500001)(54906003)(33656002)(1076003)(5660300002)(6862004)(6636002)(4326008)(52116002)(53546011)(55016002)(6496006)(316002)(8676002)(26005)(8936002)(6666004)(2906002)(83380400001)(86362001)(956004)(45080400002)(16526019)(33716001)(186003)(9686003)(66556008)(66476007)(66946007)(478600001)(966005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9aOaQ5TRs5aelwgNqpSXn7I58uF0F9QxHXeQtFO+iDMVHZFNF4CPJHr1zFkl?=
 =?us-ascii?Q?G1nJQbdmsduo8/9GsxPhxO3u116L/E0eITN5Hx2TdJU4oUSiUZytwKULVzML?=
 =?us-ascii?Q?IlHN/vIV0OWxKX1OSkldiMoxL4HKmHy/cvYJp/ClaUi+jm4woWHuiKoG/8Q0?=
 =?us-ascii?Q?eFZUwoNovMksUporB1Jrn94cViJ5eWKL0tgTdh5vzAQMV9xIOwzb6iaUwLRW?=
 =?us-ascii?Q?yeB5kH0OXUebkPV+bxM8UDNrJgLQr5ikm8mJnwYQatGAEI7w0DnHViz7pGVV?=
 =?us-ascii?Q?bqdoY+rQDpCiu0knBJoVTTUmdnJZBRUikBshwVvcAVwEm4hRSvEiGU4AB7EI?=
 =?us-ascii?Q?tCzaKZkcPH+paP65H3pFv4IYOBUS2H/pf5GP+NayCix9g72mFsqkXPF7vAif?=
 =?us-ascii?Q?2AppX3lYfZ6nelqw4rOpiYa+qwQpEyehPXkqHg8B+ZYohu4+ZRvCq0Gy2ND5?=
 =?us-ascii?Q?RR2SSQk8SXaAt4dBbYUKreIxlBjH9QPPvGJ9A5c9xXmVznGHJZk4CFPTdh/k?=
 =?us-ascii?Q?7CZEWbRsPtN1F22oh6QEc7DB3yrfIJ/VPTIwZdjVaa2LEdDHThswUbq6A+8n?=
 =?us-ascii?Q?/cFVHF2k2F0GYnC5uZ6kvw8RLhRCAbt2C0Usj1bNlFmViH41MIe/5b88wM6a?=
 =?us-ascii?Q?ljAydoDRgzYq5wZnzOfCsY7D5CO2rXTP81Bjekc1iCI+N4kLEmcMHYVpEOU0?=
 =?us-ascii?Q?CrcVuEdR0IdStYKILlbLjtBs++2cG9XrnfaU+fuY11kNAfVoY6ZfitTAYVTP?=
 =?us-ascii?Q?8WpUFyDMGH33bNW9UbLrVzTfLOWYxA0Sd4cUVUTuH787K8zC42vXXgkYPOmJ?=
 =?us-ascii?Q?iHll1wdgVsu0CbNa3/fghcKWldJ97DOFuhKlh08pTghOlTHubRRLBK32hq99?=
 =?us-ascii?Q?Q6ngTw6BV9r+R6KOJLcv/ULPuKkFsq92pMrdjF2beukb4QCqIuvCl9wXCSw8?=
 =?us-ascii?Q?8yGycFeUxJGghNhKigwAKWNj6auSYr22AHQPiTb+oqCzbZRuRK6WKG0RKV3W?=
 =?us-ascii?Q?kni1+zr4didSrdFkr/cDJBfIglPlA5sDBeeCS+KKf1QSKAreQBE3gNtua/Ju?=
 =?us-ascii?Q?pkLlu6Z+3y4QIP7MiG7BDhxGbsxDYzOo+pPadmuSTetZRRDwB0qPOwiJd+il?=
 =?us-ascii?Q?GdWUj3zmDoQlZz1Oo7RR2RnWYHfI87CRJ5za8RGUrxOz/lP8ZXH51NXvLHmD?=
 =?us-ascii?Q?UCraB9Ydzm9A7bsMiKPZGuTyzJx7b8OWd0KkDeIiNDeO6H/sFYBXeyw8oC2k?=
 =?us-ascii?Q?6gBZFNCDMARwFYgGcmcPsC+hdZkGck8dSsSqRcvulW84e5sc2Bzv3t+k1K0V?=
 =?us-ascii?Q?gc5X/mZKYlOaUa2onskdOBll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81ac258-fb9f-4b20-fba8-08d8e2c2db02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 06:16:20.3491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8z/SA5ygPyEpPcaJtQO+oIPpt45wbpslDHGEqV6IaQtUYsxYRqPS62qY2nER1uz4LWaAnCuu/iq2IcgNtuyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2395
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 09, 2021 at 12:45:44PM +0800, Liang, Prike wrote:
> 
> 
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, March 9, 2021 12:07 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
> > 
> > On Mon, Mar 8, 2021 at 10:52 PM Prike Liang <Prike.Liang@amd.com> wrote:
> > >
> > > During system hibernation suspend still need un-gate gfx CG/PG firstly
> > > to handle HW status check before HW resource destory.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > 
> > This is fine for stable, but we should work on cleaning this up.  I have a patch
> > set to improve this, but it's more invasive.  We really need to sort out what
> > specific parts of
> > amdgpu_device_ip_suspend_phase2() are problematic and special case
> > them.  We shouldn't just be skipping that function.
> [Prike] Yeah in this stage we're just try make the s0ix been functional and stable. The AMDGPU work mode is aligning  with windows KMD s0ix sequence and only suspend the DCE and IH for s0i3 entry . Will try figure out the each GNB IP idle off dependency and then improve the AMDGPU suspend/resume sequence for system-wide Sx  entry/exit.  
> 

Maybe we need a comment before amdgpu_device_ip_suspend_phase2() to mark it
as TODO. For this moment, it's ok for me as well.

Acked-by: Huang Rui <ray.huang@amd.com>

> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > 
> > Alex
> > 
> > 
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index e247c3a..7079bfc 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -2683,7 +2683,7 @@ static int
> > > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> > >         int i, r;
> > >
> > > -       if (adev->in_poweroff_reboot_com ||
> > > +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
> > >             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> > {
> > >                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > >                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > > @@ -3750,7 +3750,7 @@ int amdgpu_device_suspend(struct drm_device
> > > *dev, bool fbcon)
> > >
> > >         amdgpu_fence_driver_suspend(adev);
> > >
> > > -       if (adev->in_poweroff_reboot_com ||
> > > +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
> > >             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
> > >                 r = amdgpu_device_ip_suspend_phase2(adev);
> > >         else
> > > --
> > > 2.7.4
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=04%7C01%7CPr
> > >
> > ike.Liang%40amd.com%7C641ed997755644a7c30a08d8e2b0d7bf%7C3dd896
> > 1fe4884
> > >
> > e608e11a82d994e183d%7C0%7C0%7C637508596461291719%7CUnknown%7
> > CTWFpbGZsb
> > >
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%
> > >
> > 7C1000&amp;sdata=J%2Figj9QUO6Vk74BeE3udM5yVgloUanpXtJUue3pJoFI%
> > 3D&amp;
> > > reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
