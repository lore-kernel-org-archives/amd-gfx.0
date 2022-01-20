Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C86010E491;
	Thu, 20 Jan 2022 09:17:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6DA10E491
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4YU6ZGGxUJd7XdBxzkmb6cYTPqA2tUuX1Lwx1xkndwCL7WvC1qXWeYgxS8C4U5U+4AZ3iwvliDTzwc9VyGjrL/s+FcdMDKhirTFLYrrLSH6YRsmSjUR4TkTh/aM2xQ4MRVmYh33IbYsRe2XZSN/B5AiWz6de9o8nO7vID+WsgRIxz9TPcRS5y0nN2rmBjAd6haS4CPDKpAHFUmrrm2MLwGzNRF9ivYdwzY7MLK1kFLmikVQSVEh9+Tw8ogxbs5+qXcluZKaHcuRnNpfocC3FNkVpz91RoLH55bGaa+d9x3sMLc9CGKWdrtTMWvfTFVBYi8opODwT/jwgYL8fBDj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8DqnDHGVVnsNqDaIe4R6wOJeK1IooTGFrNzl8YaM8c=;
 b=ljpNGhRI1hr6JOFRcb7XcPJN8sGiuodg71MLFMlc56ztlnIoRjkY5/KCiXqsiuHdLD4umCL8SEKU6aBmcgRQGSevlUpjgvnEXneKAuGt/+QYCKJvw8pWbmqXRIggeebGBoAvalspIa7Kh2x5JZIOUdCJcmaloIPH2DGxiZunsAa7B+A2VU8Cp3g02iWgEMlOEszlo0pbUMS5iD+UGSi7VmFYRKbuNnEphTyOVV9czg0ZKLZ5S1V+oXrlyLRSHDLPL9T5FDOo/n4YcIVMolbo6zZgEQMrYESp98k/Hb2VI/LdB29PiO/Aq4IA2UNQ0GAi/56Eh1Vhpf0+HpLUX1+ZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8DqnDHGVVnsNqDaIe4R6wOJeK1IooTGFrNzl8YaM8c=;
 b=qTrSLtdoCtSkLvSuFZKsjmN4uGzvYR+gtnid+M3Ub2GHWh/zQwLT2Nb/ZXVB249sj6p6MNQY8Vxxt8TlDifbnRANlWT162E7A2lbPXS3PAXuw4DQ6MjMxc1xjJZFj9bxLbVmU4z8CeY3NCk2UxLu2Rg51lHKSirs86Ed3UEk28o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Thu, 20 Jan 2022 09:17:32 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 09:17:32 +0000
Date: Thu, 20 Jan 2022 17:17:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amdgpu: modify a pair of functions for the pcie port
 wreg/rreg
Message-ID: <Yekol31Q+wvi9ymv@amd.com>
References: <20220118112618.16000-1-Xiaojian.Du@amd.com>
 <381f44c6-97d6-7717-6063-6a2cd3d21174@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381f44c6-97d6-7717-6063-6a2cd3d21174@amd.com>
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0026ea7f-8ab0-4794-984a-08d9dbf5b01c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB489270A446737B6D302AAC7EEC5A9@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0f0RoTPFWBXQZ9Ll3tKQWuM8izQ/rQE3ST2InmKliS5uC76xbgKASA6O9IxpRjqPKwLlrBoP+7WZZEYXZWjBeOwVAn/aWg+E/VwIPHaAG+VmK5fjebBVgWMIP0MLerl1YvTz1JqqnKIuJV82f2OltFNKC8BXvb54ff2VCD0ABlUqYo/K3QdVmJ0JvKJk4DaKhIo6mCS1L+OzTEnuAyf3f0VVu8H8bIImFFjyYUQlMZ3yYCbT8fTFHgmr8bANvhkP2AVwwr3N4ApJTVoJrJY3qJHTJabyQ1wb0mRF5LZzWVOCiBZV8sjc9FNVFoC3H96iwFMiKXO1BGniz/U8dC3L0SHdERYP1Fv1mj2Cuh/1yjRRfxvUgjwtG1xoq/wutmEWNI8+Y+TIVqQ2lll9W4Y7bzCFzjGV/mBmGTibiJj7/FFI9GTjpQhOOD7Iilz75PHbBHbxnFhnf4tgF0g126QquhCNho5uXk6AQJGUh1Wkqr5Tz31jEamQY7rb+VYMz2iTKsyf+A5VZgEs1EnKqqM8haTz4PkBwVZYY1kYxK/OFofie40Z9WmgGjPniLbux803h1PhHuPSbYr0LM4jw90RDJZYSYjhr3owghHE39Zh7wN6hcbCKytz8o6C2tI8m/TgPPy1Jnda8mXZkTYhHPsCdnsG7N/h01z2VqexC/N+IEQSwlSedxDeO0dhzNPJb+V7Ng2VSurGckrgd1/JKk3Vlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6512007)(6666004)(316002)(38100700002)(4326008)(5660300002)(54906003)(110136005)(86362001)(66476007)(66556008)(66946007)(6506007)(53546011)(2906002)(508600001)(8936002)(36756003)(8676002)(6636002)(186003)(26005)(83380400001)(6486002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42iPgMAZq9+/10cZBmw5nvcCcQ6I0cyhUO5plBn2nBO7CK/8B9tOhNQrNDxS?=
 =?us-ascii?Q?s3ju2lyqSgEsJoIbqbLl/RsPwrI0+g7uQ3D7JFue+yhTjejSyyiFBHQOrxlY?=
 =?us-ascii?Q?2Lae0XQwl2FFm7JSIW0bwAP7IF4P7VRIU19DBFenOBSsyh+B+MJb8mMH6JHB?=
 =?us-ascii?Q?uy8Mh1vqZx1H2qS2c+HmqTpBqR6MyFo/nNTh309+laqY/stmG/4bVXgC5R0a?=
 =?us-ascii?Q?b82gHXZ9m9NOqTGwQKybh1jyzz+MR0g+KUDosI6UXgB2KPf0fpWCiWSql/qW?=
 =?us-ascii?Q?vRE1xdmMY76x+ccoDYgOkM6C3eOJLZcsXmd1m/Yz9gp9dxZJyVLGGTKlw9Mf?=
 =?us-ascii?Q?HXYkrBa1nmciVWFwejAoc1QGOZxp2Pg0w9LSHcGK6tz/Q2hnXXpsp1ln+8ZG?=
 =?us-ascii?Q?/sIrZWIDcUYTOBisrAH67aWH8UtLuUNNyJklDtvwma/br9S9NqyQuBQTnJ14?=
 =?us-ascii?Q?DJZnf073dM7xycetXysRRqOqTDg4We5AccXihamN918p7tysoZV2oamzht7V?=
 =?us-ascii?Q?bwWT9HYdFGe4Y9pI+fYaDyzGgX/ZycejP0jwCvjb9CFgdJGiWyzpjykQw3bL?=
 =?us-ascii?Q?+G+9qYXQChEsHRmEzCigGngz0DhTsfCA/94ppgwNUSfC4X8sorzMPc30ER61?=
 =?us-ascii?Q?YNBcNtaBYdTpQjnEkvWGoUPupg1CBp8AcPBKZjERhT70oEKNnztS5C81TqiJ?=
 =?us-ascii?Q?oHtwlE8ks+QiHikWjQgCt8pWTsSOaKKRoKEUVdR5mYAHsnB8922PXLGlVOfp?=
 =?us-ascii?Q?6PEpa+znSCrI26cN/6I6zVbgOfIo7wijuTA1KqT0Z81G4NXHnjv4yMFa7IfK?=
 =?us-ascii?Q?1F7UeKhzvBgnBNwjGe77jOkqRce+buB0q2lg4hS/5G2broQ1ONzcSFWIpoOY?=
 =?us-ascii?Q?g6L7L9jh+nn9+UD5qt3Tf2o+H829Kmlt0Qm/+Rrh/TAiNBsp0bkTshWOkpZ/?=
 =?us-ascii?Q?5eZ37lMWOFlve7j0C7uHwUPYayt/9vVFJeMsIL1dFh/kH3+ZLBoF5DFZI/19?=
 =?us-ascii?Q?VD0q6DB8fOQtQwLt9Ltt4kreIhiBGMWLJsoO66RAns0PESEMQnBjkxglLF25?=
 =?us-ascii?Q?L6+BOF7ofxW4DG8Vz3I5s1OXYRBXoBzkbVbPwHal2dxVpgSsoypztm86SDEU?=
 =?us-ascii?Q?BgW0EHCj5PMQMwaWanAJ5sIuwKXdQrzVNmMdxCR+uGey/CNs7hBFte3Ri6mM?=
 =?us-ascii?Q?uxBqG7sOMjppzBErKTJR15G5J+mX+ytxnPsv2yUbjDGrVVDTP2NXT8j/l7no?=
 =?us-ascii?Q?o4XiVGgruFU4YRHKPhqDqPAWX52Xt/DYfVAegUxfov1xXHKUvQJ5/GuhsIFh?=
 =?us-ascii?Q?SHUTfeTWT1kcVCgFzPS4awOM7xLnNGAnwaRJEFrccGRoVh4e7SIjTf7EIaiJ?=
 =?us-ascii?Q?JQbiBMehxKqNsE+mYYZjQHImxPcQ4TqcWNdiniZFEhc2C5nbGIooWU250RoM?=
 =?us-ascii?Q?Z5gsG5A6gYWx96QbFN/w0hTKzPwBBpNXadqeQh1BypFO5Ex4jAk0ZKJr012q?=
 =?us-ascii?Q?E6aYSwL6M33QbAvgg9PUlxqzfd8+wVZYndoSXl+nKGGbvoYrTWrpIasGQPsk?=
 =?us-ascii?Q?6v6yskcBB5bpX0qb72MeNMeGxW5hRw9ETBUCZ/qxeP7TSMcAFB+cKm8Yqosb?=
 =?us-ascii?Q?uJ0KDGkr7zhHBOGnY/vWVQg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0026ea7f-8ab0-4794-984a-08d9dbf5b01c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 09:17:32.2457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIZgP5W0svlSEvdCi7l55bMCfwRLtwU/lt8Y+0nXRuV9tNtdrK6rgZm0oe4yt2hiraKkVDyFymd7yXfRN2agcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 18, 2022 at 09:36:56PM +0800, Lazar, Lijo wrote:
> 
> 
> On 1/18/2022 4:56 PM, Xiaojian Du wrote:
> > This patch will modify a pair of functions for pcie port wreg/rreg.
> > AMD GPU have had an independent NBIO block from SOC15 arch.
> > If the dirver wants to read/write the address space of the pcie devices,
> > it has to go through the NBIO block.
> > This patch will move the pcie port wreg/rreg functions to
> > "amdgpu_device.c", so that to make the functions can be used on the
> > future GPU ASICs.
> > 
> > Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 +++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/nv.c            | 34 ++--------------------
> >   3 files changed, 39 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index b2da840f4718..691d7868d64d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1421,6 +1421,10 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> >   		struct amdgpu_ring *ring);
> >   
> >   void amdgpu_device_halt(struct amdgpu_device *adev);
> > +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> > +				u32 reg);
> > +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> > +				u32 reg, u32 v);
> >   
> >   /* atpx handler */
> >   #if defined(CONFIG_VGA_SWITCHEROO)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index ff4cf0e2a01f..10f2b7cbb49d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6023,3 +6023,36 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
> >   	pci_disable_device(pdev);
> >   	pci_wait_for_pending_transaction(pdev);
> >   }
> > +
> > +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> > +				u32 reg)
> > +{
> > +	unsigned long flags, address, data;
> > +	u32 r;
> > +
> > +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> > +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> > +
> > +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> > +	WREG32(address, reg * 4);
> > +	(void)RREG32(address);
> > +	r = RREG32(data);
> > +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> > +	return r;
> > +}
> > +
> > +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> > +				u32 reg, u32 v)
> > +{
> > +	unsigned long flags, address, data;
> > +
> > +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> > +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> > +
> > +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> > +	WREG32(address, reg * 4);
> > +	(void)RREG32(address);
> > +	WREG32(data, v);
> > +	(void)RREG32(data);
> > +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index e52d1114501c..17480c1eeae8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -256,21 +256,6 @@ static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
> >   	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
> >   }
> >   
> > -static u32 nv_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
> > -{
> > -	unsigned long flags, address, data;
> > -	u32 r;
> > -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> > -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> > -
> > -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> > -	WREG32(address, reg * 4);
> > -	(void)RREG32(address);
> > -	r = RREG32(data);
> > -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> > -	return r;
> > -}
> > -
> >   static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
> >   {
> >   	unsigned long address, data;
> > @@ -281,21 +266,6 @@ static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
> >   	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
> >   }
> >   
> > -static void nv_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> > -{
> > -	unsigned long flags, address, data;
> > -
> > -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> > -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> > -
> > -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> > -	WREG32(address, reg * 4);
> > -	(void)RREG32(address);
> > -	WREG32(data, v);
> > -	(void)RREG32(data);
> > -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> > -}
> > -
> >   static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
> >   {
> >   	unsigned long flags, address, data;
> > @@ -709,8 +679,8 @@ static int nv_common_early_init(void *handle)
> >   	adev->pcie_wreg = &nv_pcie_wreg;
> >   	adev->pcie_rreg64 = &nv_pcie_rreg64;
> >   	adev->pcie_wreg64 = &nv_pcie_wreg64;
> 
> Looks good, would be better if the above ones also are changed to common 
> implementation.

Agree with Lijo. Xiaojian, let's make a patch to move this part to
amdgpu_device.c as well.

Thanks,
Ray

> 
> Thanks,
> Lijo
> 
> > -	adev->pciep_rreg = &nv_pcie_port_rreg;
> > -	adev->pciep_wreg = &nv_pcie_port_wreg;
> > +	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
> > +	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
> >   
> >   	/* TODO: will add them during VCN v2 implementation */
> >   	adev->uvd_ctx_rreg = NULL;
> > 
