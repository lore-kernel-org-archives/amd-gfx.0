Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC1C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 18:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FDF21D81
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PazfF22P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FDF21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63446EB26;
	Wed, 14 Oct 2020 18:18:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36E96EB26
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 18:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSGEhDXILjj4WEI0ALEM6A4lkJCm6x0MNkCP1SaxpGQRQanFCrvkDWsn46Wdo8h9WglTiyxvIMY9LGoFSVf2xaHwzyMDuDYNKOQOYlPYFWhCS/utMyV4KkIAoeaOGXPfbl9XFv06QtARLk/+86RvlDvsGiQtTsSUExRjEDG80iBUIUGbYD8Kgm2OgJf0VlBJfkIdkcH6O2fWcBOPxG3nF0JO5+7MIo/VDwYttKUTppPUrhtoClFIsmUop890bjsSMf04iHo645AMxrxrhbcab8GTmjFajaCbo4x5rd7C2Wh1gNDuxVHUUFQuoAtxBcZ9YSsAGjfURB9+fhr/40vq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07IEKQ1l+iiI44x/a3kZETOVgyeGbHu5fSUC/v4k1PU=;
 b=XDu6UkvzlPH2rdy8/cPxT4HGQluM8Mu60DcqsWIIGQSEYN8mgAd39JMz9a7PeOQk4GNPeNk5qvcEleqZxSMvlel7uHMPQSvDCo/rx6I5GsLJ81rinbATItJ39BW2qK+x/l6otUkZP3wMvznJOVXXnL0KqJ69RVSyjvD6XQQM9O8jR/n13S7f/2wuBS/9bZrCjl+Y3JlPzagsDbqm6NVFWhOm+LNPEXul32Z6oayNnJ+zxrHNZ536Ag64UCbtkT2sP5k9lb9LLGRDbz+OYrXlpcmoAmH+327HoRA6eISJF4zdvgioSqAQojCyeCRtdfStgLyI5mhSIbTsbxJ6t5cnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07IEKQ1l+iiI44x/a3kZETOVgyeGbHu5fSUC/v4k1PU=;
 b=PazfF22Po967vMHfdazTI6BoMD6fPcRy5rs6j/xI8VvQ96HBjM77sBUTuegbFJBSEFzpa9/xTWMex2hIAujH0AI11hEXxfPMCyGAT3cEw+IzoIe541Oas8QJ1o3dnBK32x48l7cqKo4GAash/GdBVerAareUx9TlCk1xAJmlSEA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1420.namprd12.prod.outlook.com (2603:10b6:3:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 18:18:18 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 18:18:18 +0000
Subject: Re: [PATCH] drm/amdgpu/display: DRM_AMD_DC_DCN3_02 depends on
 DRM_AMD_DC_DCN3_01
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201014175507.973772-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0fce64ec-c428-1eeb-940c-fa3d218b18cf@amd.com>
Date: Wed, 14 Oct 2020 20:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201014175507.973772-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.243]
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.243) by
 AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 18:18:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 617571aa-f8bf-4f39-9ac3-08d8706d8614
X-MS-TrafficTypeDiagnostic: DM5PR12MB1420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14209EEFF0D9F075A8E54C3B8B050@DM5PR12MB1420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xOI0wcEZNUmJHcD2X5TRelPVgcwhyL8sYwoMpwtTS1BkUWsWA9t6mYo2U6djrK0v4PVl1OCnOowS4UIXOG6poQkfvcZHy0mmcR+NVQjY62WgYVZxanVyfDZs+Xuv5VFRKPQf/0gDzuf1FKSNwx0OztrXEY8WvVHdBkGNuecd+0nkbIO0XIkt6shZfR1fPzGGoh9njCPmTEVyE98QL3kANcgEBsbrifVRDsa+0NjHCa49z30KpgsEZffvDpbkU2qwoDejQLoLNKmStdHOzGh/WwxS+d8j6FFlk+LpNBDGbv1HF2DEcFawWhGgGx9DGcILtol2monDNSA5Y+midUdj4UvmSbY36eG6Hs4shzlDt6b0EtUtwr4NJqvbtZ5NNvE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(31696002)(478600001)(53546011)(36756003)(31686004)(52116002)(6666004)(16526019)(186003)(26005)(6486002)(2616005)(4326008)(2906002)(66556008)(5660300002)(8936002)(16576012)(316002)(66476007)(66946007)(956004)(8676002)(4744005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WYCeCJ80L5pij1gXupjnn51tSXOeVu9xuHw1z9qQ+RhNXRYYMc4gt15HFSsERoiJXG7cQGF9e38QhBab7seqgTLddkhBMSywY/XRe0D30XIoxXOCfeRY3HU/Wvn/4XlTQAfp+K4jTcZEXnufXbyWaMGSlncaSPL0ZsAJfEjnSQPA+wnHLxkljTEe2xnreQzb+tgm+gUfRFm0gbqGWVE9KWETEGLGmDCJ+s9X50Cld+6m/0KB8B/b4xw7G1lag37HHJ9PgAO4mxGXHTcQ816Yx/J2Lk8rD8fpherNBUW3qeeLm38mmmfqMUqNpAmzL7P/bo3rWK+1+UHH2GtPNOUZvBxGsaGxqo+Imwgj5gwcse3V0BKnL6PLOvbY7HdBPE1gMgN+zNzW02WHSPeXo9Qej2iqaorX2QikDMOQGcK2nz5vozBwyMdO/axw3dd3H1+PdIARhrOM4qyJXgdpjctEy174a/664+EgVGU4wKDy4I0IjF/en8Tqo9bv80fj7oyKuUp/TGbp8b3i5ggv28eE3tXIa2rMrUhB566DRQue2xGlrrXYXvDswk6oLSnYhv//x5BTAGwYAs0pPMaDOjo0TDwWcLdsVVcr5XNN+wIx2AClmLv3F1VKwtMwYkJFqo9/n6qx7xU/+CCyZpy/LGTzAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617571aa-f8bf-4f39-9ac3-08d8706d8614
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 18:18:18.0456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypk+ZbU6lnV85ewPAj8K2zOWjpy0yaSY9rEdCUAC7k5WTtowjXjrwgBH7QStUIQ7Ny1OArwdFfgRX8WVpmFG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
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
Cc: Alex Deucher <alexander.deucher@amd.com>, rdunlap@infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 10/14/20 7:55 PM, Alex Deucher wrote:
> Fix this to avoid build problems if DRM_AMD_DC_DCN3_02 is defined, but
> DRM_AMD_DC_DCN3_01 is not.
>
> Fixes: 36d26912e8d854 ("drm/amd/display: Add support for DCN302 (v2)")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 5906778627f0..93cdcd1ee9ff 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -45,6 +45,7 @@ config DRM_AMD_DC_DCN3_01
>   config DRM_AMD_DC_DCN3_02
>           bool "DCN 3.02 family"
>           depends on DRM_AMD_DC_DCN3_0
> +        depends on DRM_AMD_DC_DCN3_01
>           help
>               Choose this option if you want to have
>               Dimgrey_cavefish support for display engine
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
