Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F208C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9552310B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9552310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB2489F6B;
	Wed, 20 Jan 2021 03:13:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690085.outbound.protection.outlook.com [40.107.69.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B683D89F6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 03:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnWvPpb44GHpjM6uDHQXz0ysA67/ovG97y3WogKW7zXwzbmzmgUp2phH5gpGQge+VUyuXY3J72XjmgWpHyI9lJQ1SeBjkTy73Vx/dBV4ZJMM9883w7Kp4WrL2b3FDxpmsONwd4IVlhUGcFDZokDfFXQhcPn1/IUwXDW3ROsbNgOFAM14eb1G1SF4WIqvZm0ADgANxSw0PDs76w6BQAp/LjG4DAsjJtQ956fwSdZvUgTNR+DC2U3JnzElFdw6/l+lhZzAcDmZrPIu+bu8Cf99CRpm0JCc1KDRm7c9hwQ4jwbO7Ydy3OC4XnSHBRFL9IN60EHFyCnplOg1ln5nR1+ZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYpaSYU0kMxnyNEzinu//oVmzgHxGN+f7Y7Rx+hTZ6A=;
 b=eZlKlj1Kf9FDBof+uh9uSO4lX+eF/dvlXZCqKQqgbFw0XX7FxFdMtHxa3kw7yU/VC6gLHbTcdcV167yudh2JnzQEDpO6k5xD5ikCp++7W9gPEM35ZZuj8QF8DjBCRJe8OXtvSpEvIQyIYRyNk+DED3FwlOcZjen3z/0KqKS9sM1bxl4GT6pHk17BBziSOaQjwzUK72hdEZv6ygasKlCN3fErPeDF2w15d47Fz3FsdGYOhT0BLmUHYdW71oCkxw7DSgST3PKP/NDiTv4hl5aUQc7zyVB1jmZ3UgMTx4ZmoPaM/sn3ZXGAxUUdM4ROVDIdVc9irvgzpvAepxuybop5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYpaSYU0kMxnyNEzinu//oVmzgHxGN+f7Y7Rx+hTZ6A=;
 b=tuSDZYlnzjdDEYwsNomDjln7nfrJnQIUP1QQRk8d4Nv+bueBswXbZrO0KLrXrpCIR3gROrE5lfW1h+OalcxRpC1aSoT8jK3F6lietofcPvPzXpnYCtts9F+2qSsW0Ib/dBrzn75CAfCjsw2BShGnDiCZuWrQeRF7RBuZlYARIrY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0175.namprd12.prod.outlook.com (2603:10b6:301:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 03:12:58 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:12:58 +0000
Date: Wed, 20 Jan 2021 11:12:51 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3
Message-ID: <20210120031251.GA611756@hr-amd>
References: <20210120015732.3986339-1-aaron.liu@amd.com>
 <20210120020619.GA610615@hr-amd>
 <CY4PR12MB1159CB448D9D51F7D09F15CAF0A20@CY4PR12MB1159.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <CY4PR12MB1159CB448D9D51F7D09F15CAF0A20@CY4PR12MB1159.namprd12.prod.outlook.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend
 Transport; Wed, 20 Jan 2021 03:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6334fa05-230a-4b0c-fa01-08d8bcf14970
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01750FF0126541A2BCC4F0C4ECA20@MWHPR1201MB0175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WG0uzg8rDKjWLLqFW+BjTtZjrJ4c/IYUYzPqVh6K54/HBCicVKncF0tqvMqIzKfQejAhmqylMHsNaSSbqxNXVHJly/vt2Erj3jvG161f9JOh9ypQ9B1HZC/CGo26170rmHvSJmRRTejb6S1Jy2CQHMT8lbJErFY72Ilxtnl3XBRnNRTctdSmQz22y2tyMCY2ybRJiv4rDp/cNjPJzl+vh9drEpTDphIHFPWMBR0Iv43mEqhPSsludb8HxGvbZl7rQ3sqTKQz2ApYOFhx4KmFVvwMSTXsUTuz9ksMgzYF+HCsEOwxwPfW64ZDi3WFizj0sLSLGpD9htJKGPZWLHg1jyGq7BwEPo6yIXeji7pUE8A+0oxEz46rWICTKuv8iCeft66QNAqZl68VYbdupxukmbws/0DygmXpsKq3OaFjnSkfA/nGWi+q45MxYwkV0PUd+hsaY+0PuHGvyf6QkCCvzs40eYruTMZJ9G8f1JaHFbTVZptJVPFGaIcjhMQmcDdntnfkZPOgRHJGv5OEbaAWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(83380400001)(6862004)(16526019)(33656002)(33716001)(86362001)(66556008)(66946007)(6496006)(66476007)(478600001)(55016002)(5660300002)(53546011)(52116002)(6636002)(8936002)(8676002)(54906003)(6666004)(2906002)(956004)(186003)(316002)(26005)(15650500001)(9686003)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0GlXzSvJsnns7Dn5AKmVS8f/CfQGjxRlbl4mU9m3K344YRpTN3UzQ2DQrcVi?=
 =?us-ascii?Q?qTjGmoIU3eTC7ueLqh/MTfL5XxaTSbWLgLk7F+df9CrFKhf2icdlV8Des+7d?=
 =?us-ascii?Q?G4oruWe5HoUJ22zyd8mWlpifwjN+VC+c2Se/zRsKdxlMxm0EkBhXlfLVofk8?=
 =?us-ascii?Q?GgL11YFPtLm3CDGhOv5Vke9YdscVgl3FI0RGRfGl8uzRmLAE3RJQvTUJxq+G?=
 =?us-ascii?Q?/4waDNLXp6GcsJg8r6UQVjNiHpwR4n3W4PaikPBnsQgNx8YVD6AD9C8H/S3Z?=
 =?us-ascii?Q?Q1CSXrdyA1IY0Oyp4YYVMGVprufg6o8gZVIPTQHg2rLC3zCQS6wPU1HKzPm4?=
 =?us-ascii?Q?z+ZVF9UyVj7KI6KP/5eBm1hmZvntCUMcUId78FAawKMJYfpqbMENltbBL6dF?=
 =?us-ascii?Q?YqgCjBrqBtOPVHb98vQSSmQuFdvbEl7Y61crIXfnQSp13VJtJva4Fe2MQLN7?=
 =?us-ascii?Q?AidjovuB+EDFzhHqo1qY9/6/AEekxXN8up8n0H94HXhpxTQ+D/CJJk19e7wf?=
 =?us-ascii?Q?BOnGCgvG5ksYskKO7LSiiWXl6M+OcB4CDiwmfp0lIezQUf+LohDL7eaSUR9A?=
 =?us-ascii?Q?fajl9+94aDYXVblWScxN92iuU5Y0Z2M+nVm5IEolPexLb1Hd/+kDJ/+a9s1T?=
 =?us-ascii?Q?OKNaXGQbUmph0rNsvbC0W0VtJVBl+1C6h/omI6nSN/RQq+BNrEiLegRaxzyk?=
 =?us-ascii?Q?o+zMlIAB6NWlw6lOof+XrSwt/yHwFSdHdHkTFagPSdSRLFa4qkTFHoELbTkr?=
 =?us-ascii?Q?O8/mX987pS4QMgJ4j9CQdLEyRcbk7Tyts9Rnh/j9qAviGHukIsLV/fGCLU+G?=
 =?us-ascii?Q?DlRE3Ie+fagzXyPU+Giq5GEucHz2mIN+/nFvJQdjI6HwO8mQJVkaBLSCy8tg?=
 =?us-ascii?Q?qp0zjh/AqUAMp9YyqbzBD5VQibi8RVTJpVblUU3Qw5V3c+y2SrARwUYHZs1Z?=
 =?us-ascii?Q?05E9q3o5jf7nXUpdAMqn7gVIyyTCpsLlsR7K99mANv/PzPlPM1z+lD1dQ0wT?=
 =?us-ascii?Q?EnYH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6334fa05-230a-4b0c-fa01-08d8bcf14970
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 03:12:58.1564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7vrXV6zvHiYbAJKsI9EAlnydfAT/zApymVc8CEvEVcUpRWkFMYu7OhzSS0pYi4Ozq7joLlbX83Q3NAaS2w4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0175
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

On Wed, Jan 20, 2021 at 11:11:26AM +0800, Liu, Aaron wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> This patch has been Verfied on Van Gogh.
> 

Thanks.

Reviewed-by: Huang Rui <ray.huang@amd.com>

> --
> Best Regards
> Aaron Liu
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Wednesday, January 20, 2021 10:06 AM
> > To: Liu, Aaron <Aaron.Liu@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: update mmhub mgcg&ls for
> > mmhub_v2_3
> > 
> > On Wed, Jan 20, 2021 at 09:57:32AM +0800, Liu, Aaron wrote:
> > > Starting from vangogh, the ATCL2 and DAGB0 registers relative to
> > > mgcg/ls has changed.
> > >
> > > For MGCG:
> > > Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> > >
> > > For MGLS:
> > > Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> > > Add DAGB0_(WR/RD)_CGTT_CLK_CTRL registers.
> > >
> > > Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> > 
> > Could you double verify it on vangogh as well?
> > 
> > After that, patch is
> > 
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > 
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 84
> > > ++++++++++++++++++-------
> > >  1 file changed, 61 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > > b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > > index 92f02883daa3..8f2edba5bc9e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > > @@ -492,12 +492,11 @@
> > > mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device
> > *adev,  {
> > >  	uint32_t def, data, def1, data1;
> > >
> > > -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > > +	def  = data  = RREG32_SOC15(MMHUB, 0,
> > mmMM_ATC_L2_CGTT_CLK_CTRL);
> > >  	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> > >
> > >  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
> > > -		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
> > > -
> > > +		data &=
> > ~MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
> > >  		data1 &=
> > ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> > >  		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> > >  		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> > @@ -506,8
> > > +505,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct
> > amdgpu_device *adev,
> > >  		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
> > >
> > >  	} else {
> > > -		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
> > > -
> > > +		data |=
> > MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
> > >  		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> > >  			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> > >  			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> > @@ -517,7 +515,7 @@
> > > mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device
> > *adev,
> > >  	}
> > >
> > >  	if (def != data)
> > > -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> > > +		WREG32_SOC15(MMHUB, 0,
> > mmMM_ATC_L2_CGTT_CLK_CTRL, data);
> > >  	if (def1 != data1)
> > >  		WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2,
> > data1);  } @@ -526,17
> > > +524,44 @@ static void
> > > mmhub_v2_3_update_medium_grain_light_sleep(struct amdgpu_device
> > *adev,
> > >  					   bool enable)
> > >  {
> > > -	uint32_t def, data;
> > > -
> > > -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > > -
> > > -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
> > > -		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> > > -	else
> > > -		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> > > +	uint32_t def, data, def1, data1, def2, data2;
> > > +
> > > +	def  = data  = RREG32_SOC15(MMHUB, 0,
> > mmMM_ATC_L2_CGTT_CLK_CTRL);
> > > +	def1 = data1 = RREG32_SOC15(MMHUB, 0,
> > mmDAGB0_WR_CGTT_CLK_CTRL);
> > > +	def2 = data2 = RREG32_SOC15(MMHUB, 0,
> > mmDAGB0_RD_CGTT_CLK_CTRL);
> > > +
> > > +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)) {
> > > +		data &=
> > ~MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> > > +		data1
> > &= !(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > > +		data2 &= !(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK
> > |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > > +	} else {
> > > +		data |=
> > MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> > > +		data1 |= (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK
> > |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > > +		data2 |= (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > > +	}
> > >
> > >  	if (def != data)
> > > -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> > > +		WREG32_SOC15(MMHUB, 0,
> > mmMM_ATC_L2_CGTT_CLK_CTRL, data);
> > > +	if (def1 != data1)
> > > +		WREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL,
> > data1);
> > > +	if (def2 != data2)
> > > +		WREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL,
> > data2);
> > >  }
> > >
> > >  static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev, @@
> > > -555,26 +580,39 @@ static int mmhub_v2_3_set_clockgating(struct
> > > amdgpu_device *adev,
> > >
> > >  static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev,
> > > u32 *flags)  {
> > > -	int data, data1;
> > > +	int data, data1, data2, data3;
> > >
> > >  	if (amdgpu_sriov_vf(adev))
> > >  		*flags = 0;
> > >
> > > -	data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > > -	data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> > > +	data = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> > > +	data1  = RREG32_SOC15(MMHUB, 0,
> > mmMM_ATC_L2_CGTT_CLK_CTRL);
> > > +	data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
> > > +	data3 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
> > >
> > >  	/* AMD_CG_SUPPORT_MC_MGCG */
> > > -	if ((data & MM_ATC_L2_MISC_CG__ENABLE_MASK) &&
> > > -	    !(data1 & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> > > +	if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> > >  		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> > >  		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> > >  		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
> > >  		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
> > > -		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK)))
> > > -		*flags |= AMD_CG_SUPPORT_MC_MGCG;
> > > +		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
> > > +		&& !(data1 &
> > MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK)) {
> > > +			*flags |= AMD_CG_SUPPORT_MC_MGCG;
> > > +	}
> > >
> > >  	/* AMD_CG_SUPPORT_MC_LS */
> > > -	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
> > > +	if (!(data1 & MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK)
> > > +		&& !(data2 &
> > (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK))
> > > +		&& !(data3 &
> > (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > > +
> > 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK)))
> > >  		*flags |= AMD_CG_SUPPORT_MC_LS;
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
