Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C6C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3A923888
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 02:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3A923888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC59B6E0E3;
	Wed,  9 Dec 2020 02:50:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7586E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 02:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awaxJDEBL/THVpVasM5Rw/AiyY+418iJ6Ya3xTJRTbNTLMYegg3FbGXrZ6UR60Af1qbENDLE3rHo3EVQOwTRhAWTBhf7Hfd4wduJGquDnCupzs5m8O/m22SnpDfXaoOiyao9VHyiuZJIPxQ03JPO42bK0a1bcGlqIiRnpd663SdDUUSPWWD5L9UYZ1cksGCVHrCqiXndsfpT+oBNfQ+p0XdjDNKkdi62aK+q5aNq48+1rBArZFj1NPXR5IogeDsfw5gGDv+M1vj5nJh1VpNBeFm0tiKuw0/pCDlaD+ucaO3Db2JBI0Qhu20ebZ0KL3RcoAY256NVraLQj/Y5XPLICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2MH2nOtHJDHDVk7PgQeVVfd8CRZPXuz/2jCEVTlbhk=;
 b=cNROv/5/NfkUFPVMngnXWhte1RKfrB0xidkglb1o8ZtUtUMFxFBWApOS2Kw/08OadKhy6VDJ7M6z+/9nDfyz/JRXmKgSB8mBPobq9q+UBNAzUMIE43IuePT0/SjbpwLQVfSCeHoe52KowzAR0N/V/WFqDqK+gm9ogHjqbLUh7uo7kN6t11FsmCF2p+rrfm6hIfiPHtvjA3TLS9m7hqtxNiwLqFapcV46qmRrs8s5T3ulLjY33qi0zSIkvdp+mHF4zVhCtzyO2xIrZ8b17pp3NvzLOn9qVq71+vcm1pHcjoIomfrpU0T9Uy7gASXEEd8e1EQlwyLchmkI/GGWsHUhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2MH2nOtHJDHDVk7PgQeVVfd8CRZPXuz/2jCEVTlbhk=;
 b=CTAhgDdZ9k1Jy5TKBIFWCXJHssQcGMLulh05Dm6DIsgEjOcPqxj/z+6kpwcGOsnM2UaQ44RlhX4dvELIeTi/i0UQYCHxX33TvSWmyHHKmSaglUCVYurxOqE5j2Yc7mDvg/6qyM8jM8H0vZhYlAWXB89RnjdlO5fEb93hXTh9FUE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1856.namprd12.prod.outlook.com (2603:10b6:300:108::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 02:49:59 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 02:49:59 +0000
Date: Wed, 9 Dec 2020 10:49:49 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for
 raven
Message-ID: <20201209024949.GB1205886@hr-amd>
References: <20201209020656.7285-1-changfeng.zhu@amd.com>
 <MN2PR12MB4488A42C699D71E4578E42E0F7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488A42C699D71E4578E42E0F7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0218.apcprd02.prod.outlook.com (2603:1096:201:20::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:49:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e90b949-d2e8-4923-f787-08d89bed1ea5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1856C04C12FECAB4F3D826EEECCC0@MWHPR12MB1856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXz/NOF6y/C01vB3y2dniklhudmmIxIZ4NR/VTQGXdeOWmPUzpEUu1DTV7eDPX41ymnXZJTjURWZbyySaMii2Tqn4DZxiW1uuMlJ6o0CErSeZEAG7CBiw/k8yQjT8cJpvzBVDfylIZOEQGMNuwHoY5XuLQoSh+8g8o286aCDBQrXbN2gGbQDAYwehU9Q+rbJV2bsoqn7LZJt6JEijYpLJF88Aud32xPNi2Ffoi9QUPK9aK4Rzn13cPE73b9qJi0BundL7w7X0KK70TmSnJMYG8Qf1fzNFIMD5Hu2N9mbQHrmFN7ShBeOoZX2LBa9HCiZOw75A/jIcTPd6FikgkdlcVsRjwB+QWNIrkK5iHHaKlFKaejT4hh6Hp7GjPcFrbFbdVqGLDzqtbnMtYtqTZHkU1bzFZtyCkQrG3nryY4rXS3Iy8de1KFCWSePitrq3b/+jETFBT4v6iwgaqIrgvLXAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(8676002)(66946007)(4326008)(15650500001)(6862004)(6666004)(2906002)(83380400001)(16526019)(508600001)(86362001)(55016002)(6636002)(9686003)(956004)(53546011)(45080400002)(26005)(33716001)(8936002)(34490700003)(66556008)(5660300002)(66476007)(6496006)(1076003)(186003)(54906003)(33656002)(966005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2xvz9++AeuWXZAxnpRE2WCpOQ4N2o9zMqZixrEIF2BRhJJBLaVaq2UvN7sQv?=
 =?us-ascii?Q?ryGZsoj8rzvRTcMhX5oMORmaOZHEJL920cQ0G6Y1eG8mWH3/0nK9ONzByzsL?=
 =?us-ascii?Q?VgrVsUoEckRHSSATHUxmWDyCJxNk9PsG9MzJTZiSETNvGAtfOKYtQWgRIsiW?=
 =?us-ascii?Q?RfY33SDJdY9/HE37wVHx6a2hiI06dz/hJr6deuX9ZIpKDWq/MrCGy7V/yzM0?=
 =?us-ascii?Q?H+I5otNNDHpifBydj433AvDkxF/7tNnZITZMYy8R0vlARL4KEFlyhnOR9xrk?=
 =?us-ascii?Q?H7LyoQXHtlIle8d6v0COg+6ByO2w54nO5f1/7HlE40BeZay0bV54OpeLdyQg?=
 =?us-ascii?Q?tWzy2SxV+GsSFoZizoW572hSgR7ENHRxbFIOWxDX0l+KtbTT4mA2Z+e9vVWE?=
 =?us-ascii?Q?LcoGUlzBLtByTJpdHim2C/rjcjJgsBdA24ztG0AiCVoKlVZgl68NaXUU069i?=
 =?us-ascii?Q?iIzFdJ9U07yoxHZ7DDR+jLLTt188h5t7UIc2tG03hIHXhT9bjoLD2kehgHvv?=
 =?us-ascii?Q?ankPK2cjtmCiKAj9ougM2EwXfXadZUoame2AFuA6BGPDc+dyhXUgeXjNENZR?=
 =?us-ascii?Q?U6ae8vGXcWsVtVgAq+Jahw1G+VlnBDdf+zgu/rGtt/edXxDUlh5dt5HWxkgI?=
 =?us-ascii?Q?zryehVK0iFl3gmBsztwli8OqolVQA2Qz6qhuWUCVusT1FZhOu5V0tkzsRhWy?=
 =?us-ascii?Q?FXL4prrxDbLlG7lvAQLA6ytMO/bd29DrF26EIGI3qrgEIGOU3dE5sZ/NTU0X?=
 =?us-ascii?Q?37Xk9b9zWRCV/NlNT1LSCg/vtYEP9miD+/cJTzQ4KevK533SacTlO5BzINlw?=
 =?us-ascii?Q?9wYfIgm9I7TK7uGGsm5g8HPWTGv3W9VKKulL0BGGWMCd1Bwc9zU4ED7zs1Yu?=
 =?us-ascii?Q?kjzWkEWSDhhEWAmJCF2QxnFbnyotgImmayZv5/bwFTTp3cG4hs8OVzmDIGAS?=
 =?us-ascii?Q?fIOzCgfU7fdLBblE471UyciAmH/x4X24p3B+fQnzzMOTxcmQH4ACy82/DjI6?=
 =?us-ascii?Q?g64H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:49:59.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90b949-d2e8-4923-f787-08d89bed1ea5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywlHlxak0wNGFkc3G3M6IAypC18j1c44dNY/w6XnnFOpYRUnD09bLaqNPClFrB7ygZOpGNz0wgCedhtL4dOPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1856
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Huang Rui <ray.huang@amd.com>

On Wed, Dec 09, 2020 at 10:19:24AM +0800, Deucher, Alexander wrote:
>    [AMD Official Use Only - Internal Distribution Only]
> 
>    Acked-by: Alex Deucher <alexander.deucher@amd.com>
>      __________________________________________________________________
> 
>    From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
>    Changfeng.Zhu <changfeng.zhu@amd.com>
>    Sent: Tuesday, December 8, 2020 9:06 PM
>    To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
>    Huang, Ray <Ray.Huang@amd.com>
>    Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
>    Subject: [PATCH] drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for
>    raven
> 
>    From: changzhu <Changfeng.Zhu@amd.com>
>    From: Changfeng <Changfeng.Zhu@amd.com>
>    When using old WORKLOAD_PPLIB setting in smu10.h, there is problem that
>    it can't be able to switch to mak gpu clk during compute workload.
>    It needs to update WORKLOAD_PPLIB setting to fix this issue.
>    Change-Id: Id2160a7b4a6cb8808d100de25e999714a7ccaebd
>    Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
>    ---
>     drivers/gpu/drm/amd/pm/inc/smu10.h                 | 14 ++++++--------
>     .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +++------
>     2 files changed, 9 insertions(+), 14 deletions(-)
>    diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h
>    b/drivers/gpu/drm/amd/pm/inc/smu10.h
>    index b96520528240..9e837a5014c5 100644
>    --- a/drivers/gpu/drm/amd/pm/inc/smu10.h
>    +++ b/drivers/gpu/drm/amd/pm/inc/smu10.h
>    @@ -136,14 +136,12 @@
>     #define FEATURE_CORE_CSTATES_MASK     (1 << FEATURE_CORE_CSTATES_BIT)
> 
>     /* Workload bits */
>    -#define WORKLOAD_DEFAULT_BIT              0
>    -#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
>    -#define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
>    -#define WORKLOAD_PPLIB_VIDEO_BIT          3
>    -#define WORKLOAD_PPLIB_VR_BIT             4
>    -#define WORKLOAD_PPLIB_COMPUTE_BIT        5
>    -#define WORKLOAD_PPLIB_CUSTOM_BIT         6
>    -#define WORKLOAD_PPLIB_COUNT              7
>    +#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
>    +#define WORKLOAD_PPLIB_VIDEO_BIT          2
>    +#define WORKLOAD_PPLIB_VR_BIT             3
>    +#define WORKLOAD_PPLIB_COMPUTE_BIT        4
>    +#define WORKLOAD_PPLIB_CUSTOM_BIT         5
>    +#define WORKLOAD_PPLIB_COUNT              6
> 
>     typedef struct {
>             /* MP1_EXT_SCRATCH0 */
>    diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>    b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>    index 04226b1544e4..e57e64bbacdc 100644
>    --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>    +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>    @@ -1298,15 +1298,9 @@ static int
>    conv_power_profile_to_pplib_workload(int power_profile)
>             int pplib_workload = 0;
> 
>             switch (power_profile) {
>    -       case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
>    -               pplib_workload = WORKLOAD_DEFAULT_BIT;
>    -               break;
>             case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
>                     pplib_workload = WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
>                     break;
>    -       case PP_SMC_POWER_PROFILE_POWERSAVING:
>    -               pplib_workload = WORKLOAD_PPLIB_POWER_SAVING_BIT;
>    -               break;
>             case PP_SMC_POWER_PROFILE_VIDEO:
>                     pplib_workload = WORKLOAD_PPLIB_VIDEO_BIT;
>                     break;
>    @@ -1316,6 +1310,9 @@ static int
>    conv_power_profile_to_pplib_workload(int power_profile)
>             case PP_SMC_POWER_PROFILE_COMPUTE:
>                     pplib_workload = WORKLOAD_PPLIB_COMPUTE_BIT;
>                     break;
>    +       case PP_SMC_POWER_PROFILE_CUSTOM:
>    +               pplib_workload = WORKLOAD_PPLIB_CUSTOM_BIT;
>    +               break;
>             }
> 
>             return pplib_workload;
>    --
>    2.17.1
>    _______________________________________________
>    amd-gfx mailing list
>    amd-gfx@lists.freedesktop.org
>    [1]https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
>    sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Ca
>    lexander.deucher%40amd.com%7C2f57b9a4012a424d574908d89be7299b%7C3dd8961
>    fe4884e608e11a82d994e183d%7C0%7C0%7C637430764514589029%7CUnknown%7CTWFp
>    bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>    %3D%7C1000&amp;sdata=OWntFjcijTjJa0Qrsi7YTvrEWQcIXM8dHsXxhOaKsng%3D&amp
>    ;reserved=0
> 
> References
> 
>    1. https://nam11.safelinks.protection.outlook.com/?url=https://lists.freedesktop.org/mailman/listinfo/amd-gfx&amp;data=04|01|alexander.deucher@amd.com|2f57b9a4012a424d574908d89be7299b|3dd8961fe4884e608e11a82d994e183d|0|0|637430764514589029|Unknown|TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=|1000&amp;sdata=OWntFjcijTjJa0Qrsi7YTvrEWQcIXM8dHsXxhOaKsng=&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
