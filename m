Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B5EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 11:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE81210E567;
	Fri,  7 Jul 2023 11:49:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0180010E567
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 11:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYD46hFLkF4ZSlf1L0EsQtiEONQaabZ6wqEoJof1IOpHJVOo9fpuusehgHxEplFKyRbIC53MQOxiT2mXTTWMJu4Ep+XOpSmqcFW2XG7Wab4IafKMC6hhF1s/UqKSSWZEv3o0NGAhywkzf9+3PtRN5Vb+1nFOJBY4Em/FP7mn4mqyqc908lktM4l0VCAfbQnC+m4JjpHvb+HPfqaMWdF8X9i5tvDUhmkjFKJc12enN4bLvafnao04VwaviMcW4a9nz4gUh1kJ6EvQkja7fygbrc/pR5eEReItG0QZeJNCIiEf7PWIKCG1DjetDMaPc31S60EkBMOLURbABBNRo3Y15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmWiMX/HZ0PX00LUgLOhmtqAMb5E6YtuR4hFXqc30wg=;
 b=kQFMYhHohGZrMAgdV+aksdpuXv89LW6WXzVHitjELDytwCr13bPTEDc70PtGhvTjiJTrcYXl+XByfKqr20JITM+yjmgH4k75dCaybzFwScEMASLuGvK2X7fd6IRPVd4lcJFneUfaYHNGBdOk3opNdEcpLt30ltdXvE/WGgCt1NN+onyTwa79ltyfuJFUcTNhFjjUjNuEo54JKZZunZAyne1pMCIojuA03B+wAm6/nmN6dSWZIqDhVrET4Gm8dZExGzcbxRuU8mOgYSFpzE9RwVxCXzjRDzm6ppjgR2f1mVDnzjLSB0agV96gLQDVXvh93iUgV8fr4/Z4xIgxYPy50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmWiMX/HZ0PX00LUgLOhmtqAMb5E6YtuR4hFXqc30wg=;
 b=DkgAuA8jEZizv6K/tm9mQx9cyXY1dZAjQNwW1VKhZGzN00qfXtENCiQfpLJi2XwWGZbL+beAwVZ15kBYS2z5fdcT4jxuLxsVFMyihq5WX+G9cD5tgH4IPJzdBTStPM2h4AxFmQfp1ZKEzIb7I/2USUtD8gS6zzF4UwqLBSTg1HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:49:11 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:49:10 +0000
Date: Fri, 7 Jul 2023 19:49:00 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: correct the UCODE ID used for VCN 4.0.3 SRAM
 update
Message-ID: <ZKf7rMHFKWOwwHME@lang-desktop>
References: <20230707113144.536043-1-Lang.Yu@amd.com>
 <cb85f638-50dc-e921-d7e1-726df48e5357@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb85f638-50dc-e921-d7e1-726df48e5357@amd.com>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bde4d0-e7b4-484a-0022-08db7ee02d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWdfvE9MYoGz1C1IxwNHciGr00FEHqOYOThEtOL1sc/VXTnXs1sihzXHMGveqvqTa9hAnhkMra2hdDHwoK66BzoZdl5cCcUqfqxjEItEvSxemD9VEPp8loQTIMIgOQ+mTFuEAf9cvtDoEFimtpTBjiq82sOQlMMFtksHZW+Py1aAyhDSey87o9a8e7XIegNIoK+JdQLYASWx7CrMkMCjZVsAY4YIX4nnPTO80iSoVKzhnSF359n2CCiCnaTy78jgkKh4l6Q+Vl1ho2og/rUsMeeV6tT4Q89giGMMTQJ2rYzZyCw+tnOBVjKxaGN3wzRv1TcYJEDkmkssBhSJMXuJRPRjadQgxThjv3+/9xtHhQOs90lS2NqoIxehgjEqjewh5bAvE+Qn4Ai7t+/6/Rs8PcQFC/fxr7hxEbfU9jSx0J7QQc0BSF6BVnTLblb7TWQvRBfhsX4BFejB+arKMw8UqeGl3BIB4pn+rvMFvYfWsg7R7bO+JzURfiXnN6lxDIzaHi2b52tYZPD1FA07b09fdSPaunzgwP+uncEu8UtejoXaJuzgdbTjzicM8z1uY70D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(66556008)(4326008)(6486002)(41300700001)(6666004)(6636002)(66946007)(8936002)(8676002)(38100700002)(66476007)(316002)(478600001)(83380400001)(186003)(6862004)(9686003)(6512007)(26005)(53546011)(6506007)(2906002)(33716001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tnm6G0kvbEBIdLC/Q4Awk/5VQwOLl5XxK87RjNjTczchBJyAViENV+LBYUrr?=
 =?us-ascii?Q?7Muh+PP5n34eLDd3/pyiG8LS+CQFcjCw4puRCStqfSi5eWUO0Bez6fMkm/Ct?=
 =?us-ascii?Q?XZ9tkFCzCTgVVD7kHBvXOdwW6VXZZw2rWgR0BHA3WTCGgomvPyjG0Z4N9258?=
 =?us-ascii?Q?2sjGjAF95DewI5BgInpxvnGjaIPPfL5aDU/gO3P8dt/EUt1cKofGmNFi6Zg0?=
 =?us-ascii?Q?E/VJ4tsjOT0mua1i1xpn5OrAyWWWcwJCMaIHlv84590/a67v5f4OA/l/zPBU?=
 =?us-ascii?Q?BaGUAP2NfzyPIilyW5xSwHYOwd83L7ENLuW+p+o2ddnE076hXFtNXufzqIhW?=
 =?us-ascii?Q?e6LFk5j3o/QYGdPjxASc5jOuF5k42wDlwcSPbN8FYnH0wuTQYW8daW9Lf6/a?=
 =?us-ascii?Q?igVG4ayZk29WCBc5Zgu3WQ+oOgvo1jDgVX1JZ5seSnJPE0/E3NFvQmQAfESU?=
 =?us-ascii?Q?R9EwT62YPk3ag3nfjaxb6SQDjOX1T2afMU4/WYp2jdMrnE1Hy0VALhxkl1oX?=
 =?us-ascii?Q?/YdZcyh2mNVkxfptxNcvpheANaGWmZ9dJk/kEP6jl4M+q7zOCiOgDCnVtWMn?=
 =?us-ascii?Q?7Y/wKyuWqXCPpBUHKJrg6qSSaMXqN2qg1qPzLUGLWTSxVPrDYQ+CQOcelCG/?=
 =?us-ascii?Q?64nAzOaRt8m4QNI0r1rAOIvySq2wV6Cs8EoQxqEEBwSrjQsjWs6e+Z603dbv?=
 =?us-ascii?Q?w2hgLJR2Ea+5Ydivo7/LyUcA/eCEZ15DI2cEYh2UftGUVKq0ctor7COtmant?=
 =?us-ascii?Q?5wRp7FggKAyH7oU88IFg6iSk7zwpr7+EaOfjhUVSgdT7tWhqMVmCtdbgxWwQ?=
 =?us-ascii?Q?dmRmvi7JOXJV3LEt+OZPfMRcOstGZE9dM9Z+JadBkKlO8ys10iOylxiZvp76?=
 =?us-ascii?Q?T5VyVnI5SYze/2PciQHy/OUiLDMohZH62VakVUXE0DSdJe6bkmgmYjrj4yN1?=
 =?us-ascii?Q?ERs9vJC9pJrLr7p5X/nZ0Psqv1wdDSXQirxYuJ2A3oFHWNGtq4WdplVqfzvP?=
 =?us-ascii?Q?vUDceLWv4LJAIloINYcfQ3xJSWmEEcR8IsBkz1UEeGqdswu/JduqMlmjX/zG?=
 =?us-ascii?Q?fj1aTRYXGrAZ3sEAzWcg/Eq0v9dYmniA6Z18OvpJG9CALjRCpwNbF4H/MZzn?=
 =?us-ascii?Q?mHjOgh94MzcMamp5Cac3K9wAJS8bFkYG5WoC9t9EHQI1/ahlHieEw2HNoCzG?=
 =?us-ascii?Q?IByjS90dVRR8KeU6pIUE0JLaEElHLCMiGwBO0Wun72ji+rCNQEoiWVI15wV/?=
 =?us-ascii?Q?dIPTNTHclSw8MqflQgeiOuoS0CrHLQrzyRllRadeKxeBxnJbem5yfyA/Xbfm?=
 =?us-ascii?Q?jGCBI60Q2DYZXMcEcXNnoJVruQXMukjtppZgBiXz9jvO2576IHXU3qdDFT0K?=
 =?us-ascii?Q?QXZ3toH0BhFwGKdhmWQ2fODYvQwyqgsUE26KLHJZTm9E9pOQhjnhBUyaZO5s?=
 =?us-ascii?Q?3sPbjd9OvjBEE3sWyNknPEcxsRuI3RxxD6+10TRR4jiI+Uc/D8n5WceJKEeV?=
 =?us-ascii?Q?HN7+JO57KxGizIpProM3cGk1RjSIn4jL1bo6pLmn8iENwtW7BE/TTJJM3Z2a?=
 =?us-ascii?Q?DqgcLlY7R2wiKwxtn2wrpHwQaRl2zPGNHz1mS/BN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bde4d0-e7b4-484a-0022-08db7ee02d50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:49:10.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUHh34F3+jzYIUV2sAKuWOcPnwmV2okd1s7ocFEJVuvTtc0NhzOpwfPyB7USPUQcFPLuR/SICZre5+4ZGRcuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/07/ , Lazar, Lijo wrote:
> 
> 
> On 7/7/2023 5:01 PM, Lang Yu wrote:
> > It uses the same UCODE ID(VCN0_RAM) but differnet cmd buffers
> > for all instances.
> > 
> > Fixes: e928b52c58dd ("drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead")
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > index ce8c766dcc73..8ff814b6b656 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -778,7 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
> >   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
> >   	if (indirect)
> > -		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> > +		amdgpu_vcn_psp_update_sram(adev, 0);
> 
> This doesn't work either for passing the right buffer. Could you revert the
> two patches? Not seeing any simplification with those. Previously it was one
> psp API to be called.

Oh, thanks. I got it ...

The purpose of psp_execute_load_ip_fw_cmd_buf is to serve other IPs,
they have same use cases like what psp_update_vcn_sram does.

How about just call psp_execute_load_ip_fw_cmd_buf in VCN directly?

Or revert the two patches and add some functions
like psp_update_AAA, psp_update_BBB, ... for Other IPs.

Regards,
Lang


> Thanks,
> Lijo
> 
> > >   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
