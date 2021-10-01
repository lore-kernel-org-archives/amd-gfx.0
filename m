Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 18:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729E16128E
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 729E16128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E32D6EE76;
	Fri,  1 Oct 2021 18:16:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7147F6EE76
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 18:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoDQReX8nfEFt4IekmSKJ1tqmxgtvbu1tM7L4zmk2zTzwV6gNmbc36EXI6orZcNl3/vLxHUOHMJgyTs+BBPkqjEk8mdFXsZHhsVAERs3n2fyeVnNTRT5igk9NwCsg0qTmrXgmj9bcRpi1O7CtmjbdpqYr1DPFFtM2imMrzSMfcm/uiEo36pkWmDo3VIyWX5E4wv87K3Ds72UJn8inXvydkY581u7f9AEze+qOfHqUJS0NxsYc8qg/qVP15V+xDUlL2vKKITKxZxxH+kn5DxUeHi7/jxGlWriKHuEdb/VdJ+MdSiQv0Ak0NJZ/RfF59gWuNuAc7psUii/s1PsBV1ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8Oye7HR1ZAly/7J5s8etIgxojzyYawApS16BIUO6Y0=;
 b=jyViJyYI0cCZeLH7/VMs7kyX6TzYNsWJygnJq8gmuDzQA9P0WcX8v+uMNXwQAyHdZXhV7kTc5c2AFy2wpkY7wZPaPCGj4maTo4R1vpwmA/UjitPfxNG1f8SjJq4/ICgOhgPh/7T54lrXZCNX5iGsZ6CGRcWzXTsr/yi/hOoqkySpVXabwRbefNk0IrwANa6Ip/8F7ytq1mLUUuJUuSXr/S9PmAcO2cLN8EMqDsNBfELeyEkG3cjn4GV/Pbv7u69NDwkws/V8GC7AWRL1BCIecXsqZAmk3Eke3+WfKcuJF7W7tRJLMevdETUqtm/B+LFR+3NAtxyFGC0PqPJDnmI/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8Oye7HR1ZAly/7J5s8etIgxojzyYawApS16BIUO6Y0=;
 b=wZly6iR6lX7o00if1TbcGepj4bUgpXD2KigsxiHPKce7VGiuKnQh48VNTvAWuwAhb+lhKB6UAoh9XSc0leAZKLZ/I1ci4u44cbe3QECQfRYW2wjk+sEYE+/YMla4qi5gK1ph4Sd2UoF3M/15w0iEp0lZJYBMavax9CAUrt3PYeE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5268.namprd12.prod.outlook.com (2603:10b6:610:d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 18:16:38 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%4]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 18:16:37 +0000
Date: Fri, 1 Oct 2021 14:16:33 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Nicholas Choi <nicholas.choi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add missing case for HDP for renoir
Message-ID: <20211001181633.6sbvs2py4lmvcde6@outlook.office365.com>
References: <20211001172413.1014287-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001172413.1014287-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from outlook.office365.com (2607:fea8:56e0:6d60:9e2d:2541:1dfa:4fd1)
 by YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Fri, 1 Oct 2021 18:16:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4edc4dc-9807-434d-b3fa-08d985079bc1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52689B4330FB9B8F97251DB698AB9@CH0PR12MB5268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqAl0n22zuuvegZcftGWMG6chmVzykXHfVOl8Gv8sh/WkeF/HePTiBSi/aVhLINnrxjKC6vtR4w9W0IFwzrkrbcLFihtuZvHzUByILxCDvx0VBZVpswQuL3/ayO1u+6N6VqYBB3GM8D79s9WGlX+wNmzR2IiVndoCtd1lDdwe8nwvWt9OJ13EmG3vmhhP1FMk+VV2mp/HnKu+0jjW0YZr02WL7EXip8Ivr6u9ewn+Sgz/+gYdx3IVo5z23ImdU2FDJhu3mfZpD2om75d/T41DTjjtM6JpqOcPci9Ch0oe7AxQrxJVGdAyY4lZxbc+2fEUN38vEtH/o5WfP6/Ej4nEMvtGNz4e8kf60n0YPs3cf1eKZgT2m3OFjGjRwxUNmdzYrdFVqtm/VjTST/tixh4kPXjZGBWD6BKmXTJwOZD3swVWRHek+6zVtb5Ta5IoQSW/wRIjmAWJI9La39WeNiWAN7MCRSHFpyI3Z1uQ73IdFa0f9RZuHc3OEmjtlCB8lOmcx2RVZHNIc9ppldUUjB1fwRPhtbsqh4Ms1NRpwqX8XF4GqFO5rYfT8pMS8HJBBx70bskQsEar/waBqyWhlGbQ5Nu6fTipSDts82C5tvnNnd+gjX9WyoRbhcyp3RCngibzQC/qPhYuRazWFLG27WN5gyqV4ZWEu/NSk4Gqw4zEnMngigWWwTL5vshaL6VRsQnWOHLZHr29kTWRGqX22vomLWWxLbeh32rwq5J43MUT6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(508600001)(966005)(38100700002)(83380400001)(66556008)(66476007)(8676002)(5660300002)(66946007)(1076003)(9686003)(86362001)(4326008)(6862004)(2906002)(6666004)(7696005)(52116002)(6506007)(186003)(8936002)(55016002)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDyOrH0X/xT8W4ywwg0rT2hCDjdRtY3vrD+YsM4bFbWzYel8tR5j69G7oSBT?=
 =?us-ascii?Q?hWdAfz2o5z179Q+O88lC6F1j2TL2+YNMHCX6H7u7jah+2FraSYpqIx2N8+sl?=
 =?us-ascii?Q?lxrXCJPipMf41RhJCZ45D/zeBvaU5pXRqJAqSyZav+wC1L1aa4hkrZbtqtar?=
 =?us-ascii?Q?6yfQfjeCTof6SdExiymZCBxEPPsQ+YMy3q0tWg2QTNVf8WfcJ4SGBVuZJ52A?=
 =?us-ascii?Q?ARxzeMKmV0N3ibxnY5kh/tqT4P+po5rUKY8wtpurBYPqlK3aGSmxiETlTsdb?=
 =?us-ascii?Q?NwiHYTd1TqBnSlr2px1r23rpunq5EmlMJ6mPjoEGOuzd84KCLtjnUkTJ28Wo?=
 =?us-ascii?Q?yXJmPZ8fjT4/kctcax1w+ERkEuWZpbR0dPc+m2s/0Abg1DjDlxT3NEVbSxbr?=
 =?us-ascii?Q?xUpBjQ47GqT3xaK0liKwp1L2cIJLXK+AupQRofx4ZGrudpAdarJ0EnnXrYkj?=
 =?us-ascii?Q?bbvG5PX/Y9FtYn2gCtTo5r7VH6gphiPuFaqbtVDYXF2Hf5Dix2TtskLg5C/p?=
 =?us-ascii?Q?/xslou5o7B4Sys5xbAZGBX8yFhKcRovRK8KtYttnsgHc5I48gJ1ucQ7m2IYH?=
 =?us-ascii?Q?Iu87SqZo8QSDHUee6qiF2lSbSc8VwVJdz3mOXpmmI5jFMc1ETbjysF/I5hyj?=
 =?us-ascii?Q?tBDalWdNaRDcDfyYud/Y9PdeEVPXfZVNQ1jnicWrRQEnacT40vNlYoYvtalV?=
 =?us-ascii?Q?RFCi6nRw9FfJPKeeXfEHB56hIAHOu+Si5+aoit4c7CmO+acCMoLXpWTg28Nf?=
 =?us-ascii?Q?gBKGa3bJhLxuEvfjEyyfNKVFbVTRhcfS82JoL8Hs0gYclG2Zs8n2TAP8WSfR?=
 =?us-ascii?Q?qefI5ZvIGdDowy1TmfQ/X0Ifk3h/zFXLcRLhOhm8nPsCW1Ms3xn9dLNu6x+n?=
 =?us-ascii?Q?6n6qT85YSIvywwu1WAx7FPpmmDwX6mD0hARLLI4YDsEv4z3f30eMuVwKzAgf?=
 =?us-ascii?Q?lSAsuaUUaqpr7Yw6T2eoGTyz1WdkRSOqZ/DuGCiPcmzU4ZUvK8pVwVIoUiFv?=
 =?us-ascii?Q?/Qr4kcx7Zl4B/wjXjVcOqcg7QfiWPI+uCfW8wEf1NDJIdeTc5nz7q2i6Pfl2?=
 =?us-ascii?Q?rPVeL8RGE85cfoRcTsiV9XOGLRzGhAAKQMtQWvMEfngrOO/lxVoBCH8vipY7?=
 =?us-ascii?Q?nGatD5kwS0sJNJUqGgEZQUlAzDgGh2XK80NLPYSVweclDDr5l/jJOIosF9RG?=
 =?us-ascii?Q?IaKaOfdWZ8L+lW8XdAzC8+h3p1m58hbbCtHyTuAU5cPveqQ6I4W+LpHY5NB8?=
 =?us-ascii?Q?5i4BT+laIYuxFX8+3mh6KBSZZeFBw2w2KWnqbwqKchFPVqwSxbc2qB48l7oV?=
 =?us-ascii?Q?uEN4UIMNoj0Tydww5ZIvs5Zzmpn2gLqJt6KakKZ5U30IUpz/B4uKB1xmU3oG?=
 =?us-ascii?Q?YZ0GFTQOFP+wyQpH20edGKzj0SQs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4edc4dc-9807-434d-b3fa-08d985079bc1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 18:16:37.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU7ypOtJBprpfFoEoNtfhkbIoqC5M+0AzkcA/b/oWfookaShSzttVzBQGk299WElDefucQNRAOA5aiq2XIPM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5268
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

It looks like Nicholas Choi tested your patch, and it fixed the issue.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks

On 10/01, Alex Deucher wrote:
> Missing 4.1.2.
> 
> Fixes: 30bce8c7213829 ("drm/amdgpu: add initial IP discovery support for vega based parts")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 291a47f7992a..eca5515c34b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1151,6 +1151,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  	case IP_VERSION(4, 0, 1):
>  	case IP_VERSION(4, 1, 0):
>  	case IP_VERSION(4, 1, 1):
> +	case IP_VERSION(4, 1, 2):
>  	case IP_VERSION(4, 2, 0):
>  	case IP_VERSION(4, 2, 1):
>  	case IP_VERSION(4, 4, 0):
> -- 
> 2.31.1
> 

-- 
Rodrigo Siqueira
https://siqueira.tech
