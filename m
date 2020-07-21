Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C557C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE06020717
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 17:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1GRfDdX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE06020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA596E040;
	Tue, 21 Jul 2020 17:59:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA2B6E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 17:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrcxUoIEhp+ayOYgJNORWLV8GO4QUF4Ehs/sOZQM5EtESlleaiTpa4ef+Zpv0sam4D6gZX71nQZinf1b3fvrxTBxOheO0i1ioNG0feaadw0YumEhUYn2fLsLFIyldWr2yHeQfgNtbhhpsDIY9DHzQtD/OPvK6m7+MSgeQG4f9CfJCB/A7O939smv4YmvE1970MaZmtjy6QVj/JDnVCFJseEU7tT14pKOhlZjBG2q+XfOquzEaJHT2Ezy411SqClF+sBKIkQzcvNApl5hhbxAgR33E0UyJEue56lL5vQ+cz/bZn8xursAcNatlkMiZYLxR914BV6xGsAxnxLtZPwcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoFIhdbwhPfILnNTK7HcTb8wN9M5PPLInZNhelATnXM=;
 b=CtYG4J32l+Wf4FUiGi/57ioEilj6CQD8zgunK14t3Jap6M10XpGsaoa+IEhdwXQPR9hNvnEkYVzTpiES65BhIFNFoWBCVWHmDKbGPadYO0AjyG4Sqs41DomWUUH7KcFjUu7uu0iixH5fNivXwqE1bGDT2VTh9eJJKs3I3l7CwUaeSSgRhZMwIgSeHwYFRED85sixwqPIDZaZwB5F/pr5ZyqGuy1JJmduk4OOrxrJfooqaks2Q9QW6xwoEPXumIWs9Ti8e+Rgw5WkQjjYB6lg/BrjcUbltK1sZE5aZ1t1AMFHXW4gT2aOdnD9C2YKQfCRhAZOqO9x3XfAw/IsQlUiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoFIhdbwhPfILnNTK7HcTb8wN9M5PPLInZNhelATnXM=;
 b=1GRfDdX0qewC1oMPAThlS+Gs9pzM5JfVrcqnurFpQcJKqGiy+ZEomDS5E4Ubc1TMx7pD6tdzYMP5fgN38SKiTYlHXwIO/sDSm1TUGUCMS93xPE7k+YpKbenrZemYKGJTAemaaL4Vk6ZJgjKzpi7byvVJRbUdz/VN8CCWWxbwlpE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Tue, 21 Jul 2020 17:59:29 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%4]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 17:59:29 +0000
Subject: Re: [PATCH] drm/amdgpu: fix warning in navi10_ih.c
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200721172224.570061-1-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <09fe6fec-4f17-cae8-80f8-f178940fb374@amd.com>
Date: Tue, 21 Jul 2020 13:59:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200721172224.570061-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:404:ca::32) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
 (2607:fea8:3edf:49b0:646c:e41c:908f:f19b) by
 BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 17:59:28 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:646c:e41c:908f:f19b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5e4ac1a-9f14-48b5-786f-08d82d9fd049
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212EC679649FCC13E60149AEA780@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrpC/eU4KGnurjyFRYYRKmhwtLMfop9DMQ/H6cJ/O8NiJ8KxbN5QG31guP5KvfJhCs1R5X2C9kszUXDVMmMXs1wrmstAB51VNNHOxBGBx6nsL3xR3rB8OowNQFsBW6z5ccZst0MAfRcc1e6zCm3RRpq11xK4n1+XkKxHuPtoEyo9r8sq7RmJ/UKFdLfCP0jcrPCxrvhVDXxLtVJPrv1SGt3yapstZhLFshukao22dCreaexOJgLDG7bIT0/Zm+FzuVaNymRv5MLf9E7CvJ1Np6qS8zt3hPEwswHm1nnqkNlw0YXRRxpm07WB744nEgmNSmZhCZsZqcAQpKygh5w7WZTNKJIw6p8IB/6Sa+K5t3WkFAyvn/LnrFekcYf5VB34
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(8936002)(6486002)(31696002)(53546011)(8676002)(31686004)(16526019)(186003)(316002)(86362001)(52116002)(4326008)(36756003)(66946007)(66476007)(66556008)(5660300002)(83380400001)(2906002)(2616005)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lNle2HpSwOPOBu9WYUcm1319WYcpFPYjuePIWoDvokipa5qQWAlN+LnXeLswwU6Q24kW8uNaIK9EidUBXdGPQ3GGxtTmKoytAOXIQScNG2v/XCBuMrUzB/3uWrVEjXeXEQ3a7KFSjdMoDmw7BbS+Rl92T4FSC0VcSTWZtd+CEk176LctJajMcViUxTGAzduQ2BjEc3lfpKf2Qj8PvgJ/6Z0auJQ47yQIiLVGwIDmD/QsWARal98JgPE05ovtOrgfALpcNHfNBVp66IGplMuxHqWGRb0b2pi66GQc87SrTTu01DyTflO947HqwNMVahChnP5cpBctBdBQCKI4uuXd2N5C2h7SUM9+gZHt2ocKT+ZaQsMx/mzzpHA8TBCjoGWlUQohz0d5zo/vZVJU18CuDgwblHPiexB3qTK8ApG8KxjL77U5Qj9hX0kAvwi04heEI6rKnxmc8iXksJdeHnXQ+lzhByYhBoLfArGZtuX7xUxfn/xdFDVDaCPpaTP0h5El1YpDQs8V/P759UUJJsL/NRHHOMKJ2voNv3GXLJXxMGDY73mLWJU1AFyqDf1WJ5vN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e4ac1a-9f14-48b5-786f-08d82d9fd049
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 17:59:29.1456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh+r4qp2IizLQgmrW1VFOXNbBUb+fRAxV5mMfYAq9B0KsxcDe490pihZumvksPy0Mp45ai97HwqrbHONh0+IUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 7/21/20 1:22 PM, Alex Deucher wrote:
> declarations after statements.  Trivial.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index f16909989c0d..350f1bf063c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -58,11 +58,13 @@ static void
>   force_update_wptr_for_self_int(struct amdgpu_device *adev,
>   			       u32 threshold, u32 timeout, bool enabled)
>   {
> +	u32 ih_cntl, ih_rb_cntl;
> +
>   	if (adev->asic_type < CHIP_SIENNA_CICHLID)
>   		return;
>   
> -	u32 ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
> -	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
> +	ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
> +	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
>   
>   	ih_cntl = REG_SET_FIELD(ih_cntl, IH_CNTL2,
>   				SELF_IV_FORCE_WPTR_UPDATE_TIMEOUT, timeout);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
