Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6057EC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 11:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B9110E8A1;
	Wed, 26 Jan 2022 11:02:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3869E10E8A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQLbHwyVySEN4p5q8xqij37DC8ydOK96yH0G84gi0rtoQsOiqLUUHA+p55k+V/ZmPFEp8hAsSF00g9t+n7qsBB4yY4LcssCnT0nOIoUdE+yEeRKauECkHtLjYEJewmpfkeWNovgWRAmMEWGrMvN5QqQ/TzmN+MW8gjOIt9m3Yptmtv3EFYOgLTKBvaufDGcQly1sQm83nk5u18TgZivK9IakNBwQlcbUN4fSikgi2K+Sc/uNW2Rn/gavHijAh1hPGfWFznnvvxy7nfmHSdfHZ27xuAj/aimnOSdHkANi4g05JdCBFM7cFxjTM6f26z9dgEkT+pdUFz0iwKzfifexFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UVcl54U3y1PDAJ4uvzUCnDmrGGBXvPk3YAcsgUKbxA=;
 b=G6rX2996ns7MUB59iCuOkMACUP06SsZQpSCps4p/2pIomM8j9eMtof68OQUPNgJtQw/Zss7om36Cgq+VR/IGmOcEtoET65yvZATgqjuWSh8dovvUXaBV4Xxa3DlpmW5LcuD1ZyW5tsGaRr0CKqDEpV52RMp29ZvJEqsLuJ8yk8N7DzXe0xNV+TblPVYNHYeKC6+giDxhP86NUhI+ICxRZAdjDjuZXjzdsDXLQlEc9OsA7Dgl6CxVWlVGKAlvPFjiPxoYvnIXqoO7raGzUa84ELoPJrf5F0Ed5M/eGVBgSywpv4lbXc4VO8cIgRqFQJMmwJm6uOprvfdIKc7s75PaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UVcl54U3y1PDAJ4uvzUCnDmrGGBXvPk3YAcsgUKbxA=;
 b=w9RFtHDE9AkT+0hHwVBwoH6aUSA08pny61wJ+AB33vMydtune+9cGxNa/mFUl0PoMlbb2C/RWElr8cGLbEBgZFgZREKLzQBHMnyindxgeXWkfiRvZ/chvIKLdHQNDn08A57hvPwRBg4jtl+HMb6kKvbwd3OSUs/t+qjjfqWL/Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN8PR12MB2978.namprd12.prod.outlook.com (2603:10b6:408:42::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.13; Wed, 26 Jan 2022 11:02:34 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 11:02:33 +0000
Date: Wed, 26 Jan 2022 19:02:24 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Message-ID: <YfEqQHHo3SGxDJUW@lang-desktop>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
 <fd878564-3f15-ba76-83f1-42284782e7d5@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd878564-3f15-ba76-83f1-42284782e7d5@gmail.com>
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9021fbc-bc41-4627-1af1-08d9e0bb5a9c
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB297884A65648A2EC7DA0908CFB209@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEYR2BCQDkl/HEhEXKtBomNj3q4Qg92Ik2veqneB9pl5b0lu46pcTkxDjLgdlrSrRa3GQoO4WCN5FLUlTbSJrRnkFCbJeKhYsV2okAFVBHIugCxuocVasM5qxtcXD1c3jOdnURnMXgdKMCEKM3Y5M5aGNMj9CZB6dJoYuYPcXireRqpO9kEsu91lnTciMD6X7zMs3nVwn2idoIrRJQBXRcnmXLpY59vbrJLzJy/SDxp1SAAvu6bJoEP/rLOKj5Pjbw0RM2PiuXnhNoFpNnf++YbWXK2iXTLjQciqRYvoelc3EKjGi7cKw4JwkvCL0ay7afQ4f4x6WN3DNNuMoy2wa+ol9jpCkmKoJ1OhuTzwZba5ngg410dRY00/R3Kjzm2KpcuUOY+r+v7tEaJ4XuQJUGp8MgaWcg77k9OXV9MXACylRK/xTGyFfF8XZ+HXeIL2IlHoIKprQRJllZ6jakjyhePxzvCcojvTeHY6Lu0479taQYtjg0D0POj5XO2d6RiW6FGx+2V7sO/vyBuDZ6WB73DvAQuWYe002y8Y0Lpkghze6VqqL50XbQ3EoGvIRLTtEpHRaZ8v/xFP2r/a0lc2rbUVLN7C0OOQbCdcsBC18zRkgswHQouBQRx7x+fQN0iVqTgRWjSIbnbDL+Ufpf8SZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(508600001)(66476007)(66556008)(38100700002)(86362001)(66946007)(26005)(6512007)(6916009)(6506007)(4326008)(33716001)(6666004)(9686003)(186003)(83380400001)(8936002)(54906003)(5660300002)(316002)(6486002)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y6hQfMQHDwZ8lCMszkclgjNvQ9+XqSNv0zFrtALLWi2Lql1bWkJTk1Ym9Q?=
 =?iso-8859-1?Q?4UfFMmBLg74+ZtolnRWcZ0SsuqMXqgpP3K04B8t/EHQNjSuMUmwEsOphXv?=
 =?iso-8859-1?Q?+fBFXt35DA+i2F8yaG4d2fWgyI9bzfhVLo4AgofUWPW1IJ+Kha87qPS4yL?=
 =?iso-8859-1?Q?LJC6/6HTm+HNBRy/zHJUoyIM9RJVfOjTJiR8F2MxkMFQhU6rp8yItPFAy5?=
 =?iso-8859-1?Q?gNVoFQh1IOev2oKWTzy/D+fxdWRjshn6TfDVGtoijMbo4G4yi8xvwWuogn?=
 =?iso-8859-1?Q?1MDxDvgIpZ+sju1gTwpdl9FX5wQbjfQRWM+o5l+7l1Yo2l9oJ9ktne6WgB?=
 =?iso-8859-1?Q?EU8AQPWlXzBcxAiTKAnNhfDaTf/M3F3PkPNxgxDIDZQTlATtJ2YxnTM6EP?=
 =?iso-8859-1?Q?0GB69N0IFSPCycu/pTFRr49LsYEwW/Gmwn5fVYJ5zeI6KHFm88iYt3FeGv?=
 =?iso-8859-1?Q?fCllnMbq35edJZm9sONdmGGKQYIY2GCRtPkbU3273K+jwo6dN1l4MD+NDs?=
 =?iso-8859-1?Q?ByJMMZgE/t/kEI8hTelJqgyKwVkTyojSxOhhZDKOtm4kzHJPhHvew0Izpx?=
 =?iso-8859-1?Q?/A5tM0z26p78emt0hMy5gDFhkf6N95RPa/QhlCJWoY0xArtnIZiU3VRfSf?=
 =?iso-8859-1?Q?uMv4syCXcn5MeLItvY9fyD8LiMCyyRjKcEsVT+gDtqtpV+iNlK2WaFGO3v?=
 =?iso-8859-1?Q?G4lURWB5pOvuuzKv1UvgoHgtQjvWdtxKxfr2FUhVozJAG3yqJcKdNEi9cn?=
 =?iso-8859-1?Q?IMuwRWsW/EuebAI30A5m0sXR0MupYXA62UWlXNosgR0W1oaReA7WA64TZ5?=
 =?iso-8859-1?Q?MVft2sTXj6eVWU/IljYrdKiv/K+Nc3o4endqSRI0jQtzFz2gNCZasH3MxD?=
 =?iso-8859-1?Q?UPhCFHSMukadXQ2aefXW/BrybPRQYdbeDg6ppfNBZBV6IpV5h+U1qwDF2K?=
 =?iso-8859-1?Q?XPaztNyOGi0utsdH1vsqt+fCBsEP78Ae6SumFkW4YVPBkUbHc6T7w9W9Dp?=
 =?iso-8859-1?Q?ALoxvWbW1PRB7t242vX/FQfq8j6YBohCR04qGWYjarca76/So2wy8xKjEA?=
 =?iso-8859-1?Q?3xlfVEPkEfdFRDcZik55J70xMwL4YKxGKr1YGvtxf3dMFfrhajEHpsQPdb?=
 =?iso-8859-1?Q?4EEt/JdO+MxGtrH683T0nLkbv02VBLVj/YW4N1rOfsCJdpBN+58yAKortm?=
 =?iso-8859-1?Q?KYYtihvFu3C84Znkk7RX3eFWICpDJqDflRzdNoaE/GdCf/VVyFhc0ZXGEF?=
 =?iso-8859-1?Q?Q5wAaq3U4geWLZkfibEpdqMqhE1nTwQl9ZZooQwahPypX7UswMdPtEf3/+?=
 =?iso-8859-1?Q?s8cvKpmJxMvb1JaHhUbg84ma99v3VInVyUBf+xxc5SOSLabasHFJMKqlis?=
 =?iso-8859-1?Q?rXgDOQMFqRSNRtyXl37tl0wnOZIbDeQMRoH7s78bitcdi5Yd3HECm05hOE?=
 =?iso-8859-1?Q?7OvqDPQUXSh/GFqnG/YsHri2fAUM4co6vku4j+mdEWC7bLZFCbS4C7RrOd?=
 =?iso-8859-1?Q?nbzhzwQkhRh5HYQn0XZgnyB7imC99WOsJAzmqx+t2d8zv33kbAZCwq4mg9?=
 =?iso-8859-1?Q?CkTcZ3et6S9waluflTc9ms187jsMwRJSpu3IYZ5OTfuYHMgPXpVbr0req0?=
 =?iso-8859-1?Q?fO/CFGxhOyJ14riJEuOiEZ36niVuV7Li2VIbLZmUb61OGq7zvqkbvZhA9r?=
 =?iso-8859-1?Q?Bkvn2sKV/fqQ6P+v1jE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9021fbc-bc41-4627-1af1-08d9e0bb5a9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 11:02:33.7866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwFgwGXZrsuUh69NUYORDN9sVhQefVwBIA+IY9ji0L8gqK7UVTs8NcXzggz3c83SR7MARt7Gkyi6DXecqNgX1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/26/ , Christian König wrote:
> Am 26.01.22 um 08:53 schrieb Lang Yu:
> > We observed a gpu hang when querying mmhub CG status(i.e.,
> > cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> > skillfish doesn't support any CG features.
> > 
> > Only allow asics which support CG features accessing related
> > registers. Will add similar safeguards for other IPs in the
> > furture.
> 
> I think you should probably add a macro or function for this check, apart
> from that looks good to me.

Thanks for you advice. Is it fine to use such a macro? 

#define amdgpu_device_cg_flag_isset(flag) ((adev->cg_flags) & (flag))

Regards,
Lang

> Christian.
> 
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
> >   5 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > index 4c9f0c0f3116..1869e2019461 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> > @@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
> >   {
> >   	int data, data1;
> > +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> > index 3b901f941627..f7b9843b36e6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> > @@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
> >   {
> >   	int data, data1;
> > +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > index 3718ff610ab2..3f5f326379b7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > @@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
> >   {
> >   	int data, data1;
> > +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > index 9e16da28505a..b23dd9ddfb5c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > @@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
> >   {
> >   	int data, data1, data2, data3;
> > +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > index 619106f7d23d..a2d5c8424e2b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > @@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags)
> >   {
> >   	int data, data1;
> > +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> > +		return;
> > +
> >   	if (amdgpu_sriov_vf(adev))
> >   		*flags = 0;
> 
