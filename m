Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E514C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 10:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1F76FE9E;
	Wed,  8 Dec 2021 10:58:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99116FE94
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 10:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjyzLYeoQb7H2kOLxBsQZ5HsZSWh4OLHZ+bPmATx0qRzeb8k+yCgkXkc4+lOSy3PqRcc9DK02gC7EeSs6k29vBYKVyCSiWPhVpWG8pyQTUKniT8D1WpWVorqiSHwgGrzILH+7b5klWXYI5CuXb/ZVYFlph/oKKpdMbiZMqtnTAHr08P/072kz4sXwxdAdeKBy/9zHTEK7nqQ7p/f1I1G7OjjlO50RmhFNQo0bkRg9343tYgChbdAYjS5u5XEYj1ygPCDSjBiCDzVKvWkTzx47QTyDStTvWjIR1E5S4j8DfPZ/vuTncZFWcQNVEpdpsuyqGfpk8fbividLgudBPBKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hVPITogF4E/L48xif7MRS2Dl7Dc2i+wkP8EkrRZZQE=;
 b=Ibt9jVmrA9me4O6Slm3KCPlWSLMCJykExAi9Gcpbcs9fIhK497p/9n02owRsv3wexcwA7NGEgt922LAtO2rtaoIP//XhLAJJRAMeasvvdmcYGPClnH9b1xj+Lms/ITEvlbBC5pupAIsngFuLktLnMXJ46YDGnfvppGif1oORqp7FhEdHe1CAa2NztufFZG6DXSVVE5yabIGUazeweJD0Vo9/kvoRTZ02Oh4DhCb7YdsQVqzqGtZPf5Ic8jrV4KtHEEvfI4zLE8MZmSslHL8WxeVsq/V73Y31V82ba72T6u7HfbIdH7tVGKF6hPw2x4laQ0kWq9H1OZw6uQiwBNsukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hVPITogF4E/L48xif7MRS2Dl7Dc2i+wkP8EkrRZZQE=;
 b=G4ZOSJV7PJqrvZZvEvpLq1ftUFtFnaOCNwFk/jhz04uc92pIfNYQlz7ZkXq95SG2CTNlyhxwyAb7zGE7IrFL8QHfQTt/ZCu7XAFrwEGUx3LvBbsPHf7u8400jxKT5mbjYMWtlUuErfpNw013H+ly1RV1dApIhJlGVzEPQSU5dxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 10:58:42 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 10:58:42 +0000
Date: Wed, 8 Dec 2021 18:58:32 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
Message-ID: <YbCP2DWgO207Uqjr@lang-desktop>
References: <20211208092642.173385-1-lang.yu@amd.com>
 <CO6PR12MB547373A8EA694763B14A431A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR12MB547373A8EA694763B14A431A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 920f7852-d557-47b8-d34b-08d9ba39b257
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14367F23394343AAAF39E64CFB6F9@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B68TCyx98T2aJmyQsplS8wwRmYhkT8+ZSKtStUhjxWwk8/R+5It8wNY4rJ+fRW4rUjfnFXcYTEMB/9djU9GrE3QyvEjmfK+IJjYiHSHo8yqbcqIHv2UmiHqjoZy4iacj4K5PTtvnB7qTG5BEmrheCsudStoxdH9Ax6x1Bekp3wkVLeiYYdb0DwIDGYHhlrO8dYL5MLASZoPAOUPFi7rx3u1yqiAPxw612cvbeySpwrGryVI1RApOKF9oXE+2l99cTMDJXTxt4EcWh7hwTP+aRqlezFjhRdrjfMmA1A8TGtec9BRGFNL41HC/SCncZYh+AH77/u627h/pyxA0x7n06N+X5f2l6xJkkklxHaWrpTw7gUfHI7rS7hChBk1AXzDNL74QXDSRREdKlh31j1XdbdAxB+d3um+dFzwvNJgAKkqi4H50DKZ4lUXrECilJD2HbbRZqJVcuaqPiaXDRhRdhW42KX+7ep/nb4MpiyvKZAtaICcJycqo4nVBHWs9aJ5oPnXYwn8VsfGis94KZm19ikJGY+c2Am7pHiCm6v2YvajoA8+yB9nvnuyBP+ldSd6kEvZhKW1N/TRjD+C5gvyxD2oGBjyFHGKn3aNxI7wzLsCi4++52I0mg7zMAfPnK+0Ao1TQnxqhSuFN52bOWxu+NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(53546011)(66476007)(33716001)(66556008)(86362001)(8936002)(8676002)(186003)(4326008)(83380400001)(6506007)(26005)(5660300002)(66946007)(6862004)(38100700002)(2906002)(6636002)(54906003)(316002)(9686003)(508600001)(6666004)(6486002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nngqV/XlI3fvIZvc6KFN3FfVyg+iarp+j3lvoiLsMVawmMxQliEPbJaVI3Gj?=
 =?us-ascii?Q?Wf70GpHZpV5erQvr+HL/zoDRem6vo4j9z8t4Hx05epVMXTL3zF+mAQzUO0RV?=
 =?us-ascii?Q?WaJ9WjafCgBkc/L0soY+iev0WfsoCKcjDS1JTDClp95MkD0zHyszWtP4b6k9?=
 =?us-ascii?Q?0LU2+qjxx0N0nDofI1EFSLadaVeA4G7D4iyeXW8kgKB6ODAxsUJLCOpa4Ppq?=
 =?us-ascii?Q?Xd2vtgKfDzUCkeOaseq25JNJOU1IgqvwrGhf+yo2pkXlXyFAMaSWc/8hzegV?=
 =?us-ascii?Q?nwGEvVWWfETgw16d81W9eMdPjOkBUR0OYOi6rO01a8W0hVP0e28sDrSYOQee?=
 =?us-ascii?Q?IyU1htZsCObmpgOC1lBK7jPkOn36oLeitouuYLrLLBlQI0vT82aabvcCAp4E?=
 =?us-ascii?Q?QPopqQILMvke5dvqRxkUtPKVPDx3RBrdkbke7eqJ6r8mtf7j7dYoHCL5UMD1?=
 =?us-ascii?Q?ABKTparxcajt7NU4tXyXvaGaI7PbJ4vmSg3qYD4PRGYjNp5hFyeJnjVVyWoV?=
 =?us-ascii?Q?+M6K+gbU/5dWfMgN4jqXvQR+7Y3O+BwXHsX53WMvtWzLHKlrvlpSXj9jY7aU?=
 =?us-ascii?Q?zZMVnkYqhnW8eCNTG1bTBQLnXHBsDhy+G/DP37B41cN5HkGNz0p0qEd2vEvF?=
 =?us-ascii?Q?VP8ZHgbj9KbeMsfZKwt6fSA5Ii63pKPXvYZiuHi+Q8fQXE4di0q+hHwnoVrx?=
 =?us-ascii?Q?eYyoycRNkYbQ0YiAtsqY0YHpRdxJzs1AWT9WFLggkksdUDDjA+szl5gD2OWS?=
 =?us-ascii?Q?/ACiG8g2EdV8Svd1x7q2NVCcPjAvdLfp2TtbCNc5T4Bd20qDpdPKspxSjoMX?=
 =?us-ascii?Q?XQwPenfNdTd+x+pGEuIzKg3Afs/jFdJfcyL4FsYXvJXBKcbbUKZL2IzQv9+g?=
 =?us-ascii?Q?f5KMxmEhg7fheNYTH218bLXW6md70yCe5kKpuHnAOFyZrYZvZ3sFfki4rIM0?=
 =?us-ascii?Q?PlslUfyaZW2lJjCuALWGaTreJ7na073/bSnmBNetIqs9fBr3bINh+6TmbYND?=
 =?us-ascii?Q?LCH2HvCM1nIR5HfS1vLBAT50aMRj+BeYDYAeuJ/TVmQ/aobUzLTDal63U2EX?=
 =?us-ascii?Q?4vC93l15g7olBr5+Pbsb52MiU4ZoEQc6VYLNaUEjY4boQ+Jdk2/a3uoZ3fLc?=
 =?us-ascii?Q?NfdYAsoUJR26CU1ovx9MUE0WtwlF6z62uY1N5u2arPv8xibXaVL9m5rbTvv9?=
 =?us-ascii?Q?CkxUINktZH7aKn2iBCkZcu2V3Q+j5nj80RPx5LR9wz/0Sq/yA5Gul7TWpONc?=
 =?us-ascii?Q?R+b7I+fA5MxOlFjE9J2MSxywsYqVlZUPWkATvloEgFjgWhPgRau+Lw7tN8bl?=
 =?us-ascii?Q?j5LJM4pMPUqckKQS85SjLhT0zb71p3+QHRMeSoYwZ2VRMRzaTEVaOXfQK8MW?=
 =?us-ascii?Q?vvpinLygzBpk1QFCrWW3AMJK7yFHdERZPPWT9Drss52zpBMAaMZcEDToFO6S?=
 =?us-ascii?Q?DI7r8J3yGF3P14tHmDUlNd3iL7MOWvB2GhefT/6A3HRr8MK8oAbHX7btmUKQ?=
 =?us-ascii?Q?Yg0jnfEgux/ppjnUpbMU4BNIg/nod8GSNt17seUmBWLfKTTX5OI2Ot95WF97?=
 =?us-ascii?Q?VvQgxJvblYjIYYjtnp1AVTMKsxX4jGzpDygzI02sofOhCPoa0dBvJ4byTiDw?=
 =?us-ascii?Q?YeRJOUX7LCTjeLVN0zvS/hI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920f7852-d557-47b8-d34b-08d9ba39b257
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 10:58:41.8902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YalujOUEWtQCD4yAjAQFi97ZoqmgOTmcX92NRXEWq6AV1KbcgjCgiOMVVScPEG8m54yi/44sou+ShuVcW0xI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/08/ , Wang, Yang(Kevin) wrote:
>    [AMD Official Use Only]
> 
>    Hi Lang,
>    the function of smu_powergate_sdma() is only valid on renoir chip.
>    if you want to remove it, please also remove following callback pointer
>    in struct pptable_funcs{}.
>    related macro definitions also need to be cleaned up.
>    int (*powergate_sdma)(struct smu_context *smu, bool gate);

     It will be still called by amdgpu_dpm_set_powergating_by_smu()
     in sdma_v4_0_hw_init/fini().
	
     Regards,
     Lang

>    Best Regards,
>    Kevin
>      __________________________________________________________________
> 
>    From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lang
>    Yu <lang.yu@amd.com>
>    Sent: Wednesday, December 8, 2021 5:26 PM
>    To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>    Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
>    <Lang.Yu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray
>    <Ray.Huang@amd.com>
>    Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
>    hw_init/fini()
> 
>    Currently, we don't find some neccesities to power on/off
>    SDMA in SMU hw_init/fini(). It makes more sense in SDMA
>    hw_init/fini().
>    Signed-off-by: Lang Yu <lang.yu@amd.com>
>    ---
>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
>     1 file changed, 5 deletions(-)
>    diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    index 5839918cb574..2d718c30c8eb 100644
>    --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>    @@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
>             }
> 
>             if (smu->is_apu) {
>    -               smu_powergate_sdma(&adev->smu, false);
>                     smu_dpm_set_vcn_enable(smu, true);
>                     smu_dpm_set_jpeg_enable(smu, true);
>                     smu_set_gfx_cgpg(&adev->smu, true);
>    @@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
>             if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>                     return 0;
> 
>    -       if (smu->is_apu) {
>    -               smu_powergate_sdma(&adev->smu, true);
>    -       }
>    -
>             smu_dpm_set_vcn_enable(smu, false);
>             smu_dpm_set_jpeg_enable(smu, false);
> 
>    --
>    2.25.1
