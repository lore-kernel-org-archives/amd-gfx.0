Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FACC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BDA61209
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BDA61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06526E145;
	Mon, 17 May 2021 06:27:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95A76E145
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLffwXw14TOb/QebTwnpcNlPb0Pyeo0OvFxvuKO7OOQkEj+a8Or+KI1b3FOU/cNop74uwxkZ8EHBB1yMJeo2y7BPXyPHBcahwdCubApazbIizmGH2qZPVODs2YFZkE6xSYEufDhrwFVG1JdYRGV7bJSbdWIpTZHtaM/ljNa4PM8vYBCTEd+g3bTMI+Sijn0W075yn4MF2jtSRxKks9MJdWGprKEpi7nu99fsPuwq14gsYEt/fNv6VRNAjfQqFvNbT1wud/I7BulzPOgH7u2zK6+2v6VVMkt4XhtVKpK+V/2oC6zEf8bDtTRT2Fq5GJY2AfsSRMVzgGhdqtSNgSGCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+dhuHKg4Xzofq5vRvytFvNYA32O5QsoKHBntSFCyBA=;
 b=UZ9AadtmDqzZn0CP39w8tY849lwcHdw5ipcGanLv8kFRZaG8joiNFtrypGEFkFf7KjIjtqD5oqRj4DEVLrhy3pwXPlVn4WecVCZK6sY6REQ4pkcoiB90D788X01CQoQwnwP5Q5IPQEADEG3HMLvCOllIF0HhjP0YRem3NOyq24O5QoCguy4wjgnMy1sDCKVaEr3DnGF8Xu5677vbEqXYi/Nk+6zeQSRtKWR7vEmrvf+BIcX+IBo6Z5wkwYGKZNnGZ+bafo1DSfXE2dxRVWG+hOITzo9Mbl0xOmjaYUdw0DB44G5OgI9Aey7puDcUVibnOKJ1JrKlezDIw0W6zyX6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+dhuHKg4Xzofq5vRvytFvNYA32O5QsoKHBntSFCyBA=;
 b=i4AVjO9ZW1pLVsgQOFPJKqrFHUBfhqy63kGbpMlpRU9Gkhho9XMCd/rDJzQJZtMrYLiFm5KpUy1OpWJ7QL5OXzbW55spDAqChImfHbv8YVcGo2E5nyEU2P7LJLhxEAhobikmMRDXbRNLCJ80tairlw/kzmRpOCZQ8Isz6+dJfbM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 06:27:34 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 06:27:33 +0000
Date: Mon, 17 May 2021 14:27:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Message-ID: <20210517062724.GA1853590@hr-amd>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (165.204.134.251) by
 HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 06:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ceac541-8dc3-4343-708e-08d918fcdb0a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4522F5DC3EC8BAEE8922E535EC2D9@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4nMg60rBeiJ0CpL1OC0k2gi7rHf0fUbkykwLSGMEGcF9lYs0XJreUovefaQIb2aCwZnIu9ZlV8KL5pUPXobE3u8Q7ZpTqHKEW0K8boJXRnO3tELa+C9culRCqp+XHYTUDR0Lz8vUBEKi/DlvehVm+K3B+QnVZB+ttXpUkA0syjdJufYzBdYD37Bi4jd8nmQcl/CGQmVg8TKT41v7KoqhBpqfQcp4fLbV/zddVUZmvIisYGytoo0Mni6chhmPTjIxl/4kk2uujNGWeT0qcnTLvBBPxkH8vCibDBwIox28uSmpAQKJXoQqshc7/fBcR9dfweMmuyjBePKSOuWgY6Au08zjjeYpDTqp5Wd6rOtyOTP6p0C1f1BGKv0KqNyT6xSwBhnOeo4eg5dUNN1uo6tFkdAb+/9J9TSU49o0M+TwL6CQq2yMFe73H7EYRAC+N13if4quC/P4H7H1f/9lbYoqzz7r96ytPZ3LJpTfdNz7RJqZe+fJf/g73bC8e3iQTg3BdS7m1NIy/GYFSF0zGvZ9XH5bXc7dGYHJW4UPwOFAdyO9zBTNbDp1oL1TKUwTho5Gc/uoNaoPb4zIzeNFSpbsLc6bFBE0kakDxM18EN/HoXOwgJFz2+RfQVZ3vv9eEsDKulHzAcuApET/N2YYd3G2a6lKK9SAzqnK8HccEYCxtk2BppIgKgpEF9RFRiVzbxs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(6636002)(956004)(316002)(66556008)(83380400001)(86362001)(33656002)(1076003)(6666004)(66476007)(8936002)(33716001)(8676002)(966005)(6496006)(16526019)(478600001)(52116002)(5660300002)(55016002)(9686003)(66946007)(38100700002)(4326008)(26005)(38350700002)(110136005)(186003)(45080400002)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/29TDF7TJN9eskf6kYA6n1gEzWJurP9TCpDSM0zZs2B1Ti6f+jlSC6R+Wa2H?=
 =?us-ascii?Q?tPkEkLE5pNu+LjLPHICiv4zvml3CyN3uioDSiOcXZEL7tIMZrJ0sJR88XAQX?=
 =?us-ascii?Q?DXRScTFP9bL5KwAo1lj9BjgKd5jd+A9KI/bZ5s1tB0wEcWShB3P04hqRueuA?=
 =?us-ascii?Q?pvUrhMW4l9UdWGFr+obe0RKqGUEyL71FOrfXbVewclvFQPNNVAb5Ry3w+agU?=
 =?us-ascii?Q?61ZD55NJqIFx7RPPFCE9/D608Gqksxa05SohyjF5wrXvGECNWSqd3apbHQhk?=
 =?us-ascii?Q?/KNb1A0bVH7OlM47/ZzN+rIPnqldhyefpQlbEonQhJ6VULr3AJ0arxiiLle+?=
 =?us-ascii?Q?ph1YNCInS0l2tVthWKofgSSENZ3CIXIbEy0wn9pu/4s8dz9vduvcszWt8VcZ?=
 =?us-ascii?Q?j+KtwwV4NL4K3Zfx1dD8PjBi/PRWKpXZ+a0LDVcTJn3ayKvrRdNWiWalPfEW?=
 =?us-ascii?Q?d94Xgf39tIygdGmAgNLkpbFZvkp4/1V+bF0o0YjsbvVIv9KVIVde9uJ0H9HX?=
 =?us-ascii?Q?lpzFfDGRSwZhBFtvav9H9y0jb/cmN9pOE6kWEXESHAjblNx9l0+g5/jpJfb8?=
 =?us-ascii?Q?N3c6OO7hquUISCFBVbecANl/y6W/1I6akN8H4hMFiLFBX1Ab6DRp/qoLGOgb?=
 =?us-ascii?Q?sOxMUoPISylNwk4VUye2+OBuiiNBOhS6BsVp7M5J778X84d+uJxRJIXbm2Ma?=
 =?us-ascii?Q?sCtc6Bvy9EksKyeAc8JHL2bvVD/XdLkwQWJBNqf/f7O03zzvc5wFF+9sKB1d?=
 =?us-ascii?Q?2WJ91XJmzuZNaSiPoZt006VdODsVo0JC4PX2BvfoExmXWuVMpQaaFi5CvEL9?=
 =?us-ascii?Q?PolyA5ZkqV6JAe5qj6GjCoIHzWjDUFbCgkzi7d+tpMBBXtpB410Sinj0mEuI?=
 =?us-ascii?Q?DHj0hby6R4sQiHFrZkxcVTs8fxk6bpZrpkI1dsxP0ZpipBseb1YxSh8xSmUf?=
 =?us-ascii?Q?eLmxMYreO3xM2DAxiN0gGOtiI1Z9UJGLEOG+HQ/cLmpLvqDQUNWigpWklGke?=
 =?us-ascii?Q?SSGBqfLaGMKcKk9p8MgKPC9eijq8/J7mOt0g9oTOFy/GcncWuA3Ya2HGmqyO?=
 =?us-ascii?Q?9nXUkNiPzfvVEX8RCQy+zwK8KbX1iXU08iury0spk+LchSZURroSTVcpChwm?=
 =?us-ascii?Q?3f9tHMEik4lZIN9rKD9fguj3BgLilWtiYAPfkfshXduDpzKVa51KV21yZOqM?=
 =?us-ascii?Q?W6xHB1AO0l1jwUwra18DRDR4G2VrmVlXipUCVqlliQYQfgxqk74oHAaQK09J?=
 =?us-ascii?Q?ktoqaGzYj6sAvZyF4QoH4WRw+1RLDHYcd4u8luyeyqdfbP7J597lKD88390y?=
 =?us-ascii?Q?QqXfFE5zuUZ1NGOQhPo4JuRN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceac541-8dc3-4343-708e-08d918fcdb0a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 06:27:33.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko0cT7+vLrTsrdHeQBfr7er9hDhgZZFCChIIYz5YocoHILP5jd94yx8rnEBXZkOx4aIgs0k49gwdCiG+m0umQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
> >
> > From: changzhu <Changfeng.Zhu@amd.com>
> >
> > From: Changfeng <Changfeng.Zhu@amd.com>
> >
> > There is problem with 3DCGCG firmware and it will cause compute test
> > hang on picasso/raven1. It needs to disable 3DCGCG in driver to avoid
> > compute hang.
> >
> > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> WIth this applied, can we re-enable the additional compute queues?
> 

I think so.

Changfeng, could you please confirm this on all raven series?

Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> Alex
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 22608c45f07c..feaa5e4a5538 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> >
> >         /* Enable 3D CGCG/CGLS */
> > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> > +       if (enable) {
> >                 /* write cmd to clear cgcg/cgls ov */
> >                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> >                 /* unset CGCG override */
> > @@ -4959,8 +4959,12 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> >                 /* enable 3Dcgcg FSM(0x0000363f) */
> >                 def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> >
> > -               data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > +                       data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > +               else
> > +                       data = 0x0 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > +
> >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> >                         data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
> >                                 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 4b660b2d1c22..080e715799d4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
> >                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                                 AMD_CG_SUPPORT_GFX_MGLS |
> >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> >                                 AMD_CG_SUPPORT_GFX_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > @@ -1413,7 +1412,6 @@ static int soc15_common_early_init(void *handle)
> >                                 AMD_CG_SUPPORT_GFX_MGLS |
> >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> >                                 AMD_CG_SUPPORT_GFX_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2BV7pSY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
