Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCBAC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE782083E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MPgrUZmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE782083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862D6896B0;
	Mon, 31 Aug 2020 16:42:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480BE896B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 16:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj7PcRMTRerB8kSXgRXgaRn+s5VWQ2BSUaI19H3ROBNRwpAateWN2b00ZdfhEEOom+UheAXxoCnIJavkw1/H6XPjKqWDHacV789OjPV44VWTRe2IPdBelfTPN16hDNRrWyu40RqIGH1GU6GmryqNBICOR9RaAeDo4U3UmA9aTvPo/IPt2FjxHGGNThKuctuOqEJXnKP3H9WWYUMt5b6/qBWYWoOmQ6Koabt+++Cx+vNDCm0/meDdrKKr0zM7KfeC7UZzLX7kmkMoFV6XiYehYe8GMOU8VSRrvt18btCzxr0BFrPosyh22IY0FIVa2jfwPqM7dnS4cNnMsDnd//uktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bMqs4AqfrGhGN8rP24/eShICaN+fEGine8LDFZ7opk=;
 b=SUq6u5jGkAnYnyo04BsFMS+aQAKmXz5ZFjzXDJHD9jogCgLXGsEI0wO7FXN8+vQ9ThuGWr0hl4kgEKznU3hg/VgkAyLhyRNuLl8+QghAUOrpHPD8kWs4TUs4QwVd3Ul9wLHaI+sst9yg+TyoA/hoNrSzZ+QIqEy+JT/flYSIc1aeo0AEcihKzDuohwaXxfagMo3h7i6JO3QYXbI66yH/Jc00XCNjb9+DplmgAz6sxgwu6fVYIFaxTA4h8Z0A2DZUON9M4kVKodLsaET0HbFkpcFnK5x+Ajy+XenzWtYqzVyg6Gmg+BC8EGZtxIFpE+26K6n2wxD0eHWzTabN3zHxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bMqs4AqfrGhGN8rP24/eShICaN+fEGine8LDFZ7opk=;
 b=MPgrUZmrdIOo8JlYPhqULCqmtzcjQEDfVa1glz0oi9Ab3CPxPbB+SlEPWnBvXkWoDvJxQG+RcZaXWFzKU0tbeFUs4DJ1LXjTIR5UH38JYQXhuz4EoRFgnk8BvDgCZGXWzpdeJtL+ENXrNeTQXFlnZbPhvFrQKBy+A2dbV1J1/Ec=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 16:42:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 16:42:50 +0000
Subject: Re: [PATCH v3 0/8] Implement PCI Error Recovery on Navi12
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <aa2c0c00-f505-b7b6-7bf7-8829a7b2e136@amd.com>
Date: Mon, 31 Aug 2020 18:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM4P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 16:42:49 +0000
X-Originating-IP: [217.86.113.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59d713c9-0b8c-4b5c-c6f9-08d84dcce66a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3068E4D195A5C2657E87204D8B510@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2Z34rBFtuqVDPOH7CWKTfZdUfpGbNB9kkECJ8yZ9CGI+Lb+fW5PdPNLja/sGaaUuDDePCSle12aH+o3kxrw4cdUF5LJdXkTras5RTPHZHZVc+czo/u7CzbQzq1G9sumN205Kqez//svzC9cVYEauyMUmw9HW3sL41FhNmqcxAZrgfFyRQA+eNpGmRda/2RH1/vid5TV1vW7FzaWpVKvRSnbcAzjpJSNUg9upv+nWdnD3MkfEyMNXF7rLpDC7LUVTN332/u7q6pqWv16nC+tIjsfzDFTjw+TuiLC92MxVfFiU5H5hTsCTLFfxY2F/ZxJgFfGlZQSTMKjreinKBi+/WxAaDS17H7J7C6aVpkTWsuFUi1mfnrsxdvFQvH4zLgK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(26005)(6486002)(31696002)(2616005)(956004)(186003)(6666004)(478600001)(53546011)(31686004)(2906002)(36756003)(83380400001)(4326008)(316002)(16576012)(8676002)(52116002)(66476007)(66556008)(66946007)(8936002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kOxJXqGoH4CWFb9NqGok9ntXAo7o+rf36JXwwqzMe9REOt2rR1/K4q7ust13a5uFxdBypUkjVtIhucqaGtR7dK0hli9NPcUqEMQkDJC7p7MAgdJG/r7fwC5pVRVZYstVF+EgI30FiOneloTn+sHRbtgOI7UvySxs03a9iZFU6ig1lDbDtOCyXO/qARCOX+ZqzSbcmw/91v7xNQAemD889J3BFAw+ITi2SG0X7Rwx6rArCfS8D9x05M/SPvDUq8gxOAB3DBQJBCZQJYvuRmM6j+fOtmpwA1b9jq9ukXKZb+XJ4gzM2wzss0ksySZ1UnLfKhWjy0q8PFMRUYPvLxjyZLst5Kk1LDhvehzyRGrDpJ6ZTaXBWygdneyY/xJ+XznWN7nCsd4Atg2ZyRuSrnAcu06tMSEIdWaQ+gpQmde+31tOoSuA2JYedNdg+ZH+5GUItENpAUjyZTbCo9Ot9uE2idlO048DPCvS0PjSq47UIvS0GxiFc0i5SANmX0voESUIYUHjf+Lv6qiP6EgBqbdq7aUIkqdSlVTNl3/LpjJXUT9jljy/SOOAfsWEZbNezAhwqLi+z/lr7lQ2Iz2wXKvtWNcJsPiW3IX51vuqHjQ2nEydskyGxH9qZbUEjvo3xFkdPXVcs3arPz6uEHEN8DaDoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d713c9-0b8c-4b5c-c6f9-08d84dcce66a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 16:42:50.8748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mw/HVXpxwgRnB+UhG1qEklR6qN8W7WHpXcrfG8DV712TBucrdCKpjXZ9fy8a+8HaMkkEFYVzBDLGQaJlRINhOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Andrey,


I need to understand more about pci saved state. So excluding patch 5 
the series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>.



Regards,

Nirmoy


On 8/31/20 5:50 PM, Andrey Grodzovsky wrote:
> Many PCI bus controllers are able to detect a variety of hardware PCI errors on the bus,
> such as parity errors on the data and address buses,  A typical action taken is to disconnect
> the affected device, halting all I/O to it. Typically, a reconnection mechanism is also offered,
> so that the affected PCI device(s) are reset and put back into working condition.
> In our case the reconnection mechanism is facilitated by kernel Downstream Port Containment (DPC)
> driver which will intercept the PCIe error, remove (isolate) the faulting device after which it
> will call into PCIe recovery code of the PCI core.
> This code will call hooks which are implemented in this patchset where the error is
> first reported at which point we block the GPU scheduler, next DPC resets the
> PCI link which generates HW interrupt which is intercepted by SMU/PSP who
> start executing mode1 reset of the ASIC, next step is slot reset hook is called
> at which point we wait for ASIC reset to complete, restore PCI config space and run
> HW suspend/resume sequence to resinit the ASIC.
> Last hook called is resume normal operation at which point we will restart the GPU scheduler.
>
> Andrey Grodzovsky (8):
>    drm/amdgpu: Implement DPC recovery
>    drm/amdgpu: Avoid accessing HW when suspending SW state
>    drm/amdgpu: Block all job scheduling activity during DPC recovery
>    drm/amdgpu: Fix SMU error failure
>    drm/amdgpu: Fix consecutive DPC recovery failures.
>    drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
>    drm/amdgpu: Disable DPC for XGMI for now.
>    drm/amdgpu: Minor checkpatch fix
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  16 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 298 ++++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
>   9 files changed, 346 insertions(+), 22 deletions(-)
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
