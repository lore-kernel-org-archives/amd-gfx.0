Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D60BC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB6A206F8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WflYnhAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB6A206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766416E15D;
	Wed, 25 Mar 2020 15:33:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7956E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRDTt7l0oVX4I9bCit8BdgUFhbFhCbDUKMYAeiT5lqRivXyglnQcFLEBvMyEU/ofbxFvyZHuix0pYB/v2EOaZq47KzdwzZJ6LZvgHuJZiLvA7kaLMVcYNw6PIhzTQTop+27WSHt2dGBWwraR4whMXQ/C+QN58Lc1HyJ4XTnGWrhI5yVS+dUqhYccbpP76ml1VBm+a3yS2/uVm9BWftZc5jOgPlLPHrHbYXWP1/9MGtJ+7dBg9nxI9CjpiivfS0eFwYaXSYT2GOVFnHfEznREy1wcpNNeOSn+tIEVAvZZ9Gwkq+eN5eutlUY0IiOjFgqZ0HG/sgeRLwUTgiPQWJZjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7deMKCdWPzVC/hopHX82SabWrx+6YL5u29aD7ABJMM=;
 b=cUaONkx4bJ9CKAktls4bbSTmpXJor5+kvgibaZGPyEkgczaH7D7Uvxqwu+yo4Wn01QGac7tHQlHP3bVSIgYNNAdNwX+TBLc0LrYZKKRFkNpEvQe20vmx756ppTxhIBW10SQbqBM2UwD9SuXRhpAn728/wh500Zpad2gv64Y3RS1/cOWyfXnGOn+7I+ZGEkEfmK4TF+03p58jKLPtjvdRq8cafSn0ik5idi7tMwi6dgpCpo59dSCTOr6cwIeQ6XYALGElH6ma6uIZMyRyHolSWVY9riz+CiBRLOuaCKSrp5uiXObiCpkAjUbMSpOSp39TsIxOzT618szJeQruM9BpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7deMKCdWPzVC/hopHX82SabWrx+6YL5u29aD7ABJMM=;
 b=WflYnhApqLKyYiJLixYeSIkwtjGzBfvRiNPUmxqG/XEAID3CsUXnz7a/tsaQTy8iOCPdDvCbxzHx97ca+Mch0aaf4LGfhjQLuIAGTPsNOIeDd4eKmBxMk+FaL3r2umioHwDivw1+k91aSiZz5elH8A3YFDcHo56Esb9jBSbvORg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3162.namprd12.prod.outlook.com (2603:10b6:5:15c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 25 Mar
 2020 15:33:39 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 15:33:39 +0000
Subject: Re: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
To: Emily Deng <Emily.Deng@amd.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <b71027e4-4e0d-d577-fb07-11b471a7c977@amd.com>
Date: Wed, 25 Mar 2020 11:33:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Wed, 25 Mar 2020 15:33:38 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45389c87-5796-4cba-bebd-08d7d0d1e401
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:|DM6PR12MB3162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31623ECE365AA621B63A8D7D99CE0@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(6862004)(186003)(6486002)(31696002)(5660300002)(8676002)(6666004)(16526019)(4744005)(31686004)(86362001)(2906002)(81166006)(81156014)(26005)(8936002)(66946007)(36756003)(956004)(4326008)(16576012)(37006003)(66476007)(66556008)(316002)(2616005)(52116002)(6636002)(53546011)(44832011)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3162;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYJRVl6xOBo5yJAkT9npSZq5T57SsRtphKvFW5YuUrq6INotN+rNPqci0LygyzMux4h/Lsmlrw+eX/rwQI6cE56FudMHuNjvzeAeJuREswtxf+ydNPNbl5dbKBgln1HVGh6PoF5vnyYXHr+gFpgCo/sHPDLVsf/KmggapKWKOuevNPhdlqZkliw8KB7bg0to7/5SfGSHHOI2oNQyzyTSAX+fM1oGmcRwZDRZZC1qtmV6XNxtqSRFNWo+7bIjOlj0MNZkMCg67XcB/FiX5JjB7C/9e6sB1h/N6O7vGXezrOtStXHYOsjRuIILz2ZP3P/28XHPCjff/8zLYkc8YwfHY0GxnjJuuW+kodxptV9vYwYn3wnUYoPxkNyXBNb+HX58gbQwP9g99dNR3BymMIfkbZMoJaBkNNMj1LcP0clr+Ek91EppjLpAiYGXIQcAFGqQ
X-MS-Exchange-AntiSpam-MessageData: QUxXpaNtqVotEVjNintZgtXtkk5TNSbH6s3CEf0t3z2BrRWN0OCpoUmi3DewR7hrXygI7SaYudXG8+JClasEQGjlo6NW8ZOk4Ik11fBk3/+zRqdiNSkws+vpcsjD9HJtS+dZSqR/gfBfTM6Xee4Kxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45389c87-5796-4cba-bebd-08d7d0d1e401
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 15:33:38.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qObthObcln5K+z+k2DQnAzALB/6hA6dKhm5d5iY2UXm2BpozV6tk8LxhUEc7QzZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-25 04:32, Emily Deng wrote:
> As no need to support vcn decode feature, so diable the
> ring.

"diable" --> "disable"

> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index ec8091a..febd4c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -223,6 +223,10 @@ static int vcn_v2_0_hw_init(void *handle)
>  	if (r)
>  		goto done;
>  
> +	//Disable vcn decode for sriov
> +	if (amdgpu_sriov_vf(adev))
> +		ring->sched.ready = false;
> +

This is really just,

ring->sched.ready = !amdgpu_sriov_vf(adev);

But I think the compiler is already optimizing it.

Regards,
Luben

>  	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>  		ring = &adev->vcn.inst->ring_enc[i];
>  		r = amdgpu_ring_test_helper(ring);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
