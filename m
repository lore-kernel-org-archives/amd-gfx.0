Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D4FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 02:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD0960EBC
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 02:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBD0960EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861646E50D;
	Tue,  2 Nov 2021 02:17:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F076E50D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 02:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZBA2j1xBv//1hAUIjLpeyGpv0p1pfypgK8wGSZwxOAGkqpm1h1/AfixcxSXMprT9fw2NqpBhDYAlBhbHn5JxB265WUKYwty6KbnzSn8Is6EVKLcFtBlSNKyXzzAQDYpj2fmjEUYVEW3OltS28XzfkXeI4O/e5UcMLCICiSQo5gqm9WzWAqQ/phWa4YRPaOqQoDswgK6RDqqbYj4avr7xjwxVXZxx69D9VS/LeoZ/qyud9pTMnm/QXmj+sCizd9Cixl26phlASCY/+ac+LlAIMWslc/7DUShh4+wRiJkow059oZ+khY1oQeVeY4TdbFgR8o+E6GeQYxhkiue3kriGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlB9hCAUL/qEMRcWHepw1jYjoRjhqvo43ITEOIIlkQ4=;
 b=knjhbc8SjMXVVSTcw+r4TsXGbWacNg+PfyTEycreDS6cvdiKU0u1UIKwcPwh9oMQO90AyqQaUQ2/tzMZ+XTro6TOCNUbg6BJRPK4zXxz2A3uqvUyTaftnfAzjGwLKkeQmS+XpZdftXt1QV4XQUMbX1iBl610WEEwm+kf2RN7oOQR4myjEKnLk3rD96boQf42Is6fkFRS5nXCrZnOMIrUIXBWhQ0xvXa+QVxirXCNyvistQygGU3ilbbbK1aGafVvyZBvZA2AtB4SsjIO8sgZRBNW8v9hPujUEOVvD3ieoXNUU0dSETlmZnsOJWvlveuc3D0FEMYodrcMOgTZ1LGzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlB9hCAUL/qEMRcWHepw1jYjoRjhqvo43ITEOIIlkQ4=;
 b=hmwSkJ8bNQ2s6SOtVy7a72FyME9PSZsr1KojyMamjkV9HodCxdy1zmKJnQzoTXNzlJkns6U803oxcO/DTyKLx44lij1d7+ENVt8O4YTmmJcMilpMHSlpTvX5rK2W3ShsgEO9fv4o5qm0ZWKOVkFWPAvs2AqtK/f5ExWsjNdFaOU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1765.namprd12.prod.outlook.com
 (2603:10b6:903:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 02:17:32 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 02:17:31 +0000
Date: Tue, 2 Nov 2021 10:17:10 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>
Subject: Re: [PATCH] drm/amdkfd: update gfx target version for Renoir
Message-ID: <YYCfpuiT0/uWoIl8@hr-amd>
References: <20211101180117.144165-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101180117.144165-1-Graham.Sider@amd.com>
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by
 HK2PR02CA0165.apcprd02.prod.outlook.com (2603:1096:201:1f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.13 via Frontend Transport; Tue, 2 Nov 2021 02:17:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c33da6-21d8-4637-a8c2-08d99da6ecff
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17659030E427AD1B9281A62FEC8B9@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NywgKSfaEX/O7Rb+n5Zd/4diWvkfMhpL00bgjEblsMpi+GVzuojciYjxK+1A0x8hER6BQ9WnjRWjWHFAKWCQ+LTcVrYUyi5TvOmt1kQCkrsutOn399gBnt69QiTWtC3YRLEWVzdTFJegr9GpWLfDPYHjhHdlfyDbkfLGMyhcEmY1TnbVj31g7vImrS7WryHYSsOk3+Cog89n+nNhsDObaS/P3jbMu76PXB//QdrY9PDJOzRMbU7cO5vRzcmtUjw4SnfLxTHMNbSDit6e+9+FpPXNHQaomN3S4Hz6s7TRyUzJ/v/Ky6/lXj4vaPCijAFCm9dgMByoamv22XwlfXcl7TdyNDZA5mWC0BzWOp87zxyaQzm0S192QxU6qlHmqS875Yo4hcSu0njO+bI1iY3BxFUHr/KcLWhbTt7IWPY2dwW82fDwqxYDjUJcmPLIEx3/XO0Wwp5gEHk3kbTOhmgzKALUQaisOr2y4PQeaqA5oAk7McC0fudyB4+R9BvBc116XBJ7U0+KvEM+UJ0KbJyWqskEKVbbYOj9YLofkxC5E9LQcBpopo+G+r1xcbD7q5ory/WvC5IRbQDpAHb6xRkxnvKe6+UoWwIYiPWtJ9KVlz13IM+zI4xV36pp4IKLWwOEPDOPtce4FYDwas5ANTS1/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(5660300002)(55016002)(66556008)(86362001)(316002)(66476007)(66946007)(26005)(4326008)(8676002)(2906002)(186003)(6496006)(38100700002)(15650500001)(508600001)(6666004)(6636002)(6862004)(83380400001)(9686003)(33716001)(4744005)(956004)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cm8jI6x+MgcRXEbFd7K4Bx3GMkeh+ILvRCT/rNGUiZW42SE1yEJeyB5DOyRo?=
 =?us-ascii?Q?8ZBdpF0AcShkiDQZ/11CTxHU6ru5uMoK4pSw3AP4vJSm/BOpjglVcZBKaVlt?=
 =?us-ascii?Q?zK/UAWRuORKgWoKzVyrJCRHld1fCX47SIFeuG/9RF6SQrStdBnXQBFLlxBlu?=
 =?us-ascii?Q?JjJXDBUewXtywClUBbrl9yWMFGaADrhYhhjpfOZo6KqOjckKnzBpGpJ86wFE?=
 =?us-ascii?Q?SzdvgsxaibvIqkIpAGcc33eYNX/nwbXYohkU1iYldWPC32uxIBYgyz5QnfXB?=
 =?us-ascii?Q?xf5B9yvqaY+BNWu3mz4p+cPmRuogQzTaGs5ORxSvH3KYj41z94IRz9leNn6M?=
 =?us-ascii?Q?XeJn7t6f9Fstk8TYd0u/jDXPdWRwm8ka6xvDqCobkYwOQu8GsWJHU1T8KoV1?=
 =?us-ascii?Q?1k3UTkkV41CQfvFHCApBFCvEjZx+A0BsIsCx2dpkXHhjINDWBvuhycqQUuyk?=
 =?us-ascii?Q?vAeFRZt00tDlVrEE31eTbu5Y+CjOguWur4GrN1ubpcVfcpcOJY4zkIgsBHg6?=
 =?us-ascii?Q?46qkp6grxT58Fe5uaUeYTtCEb/OebBZo8PvcsdxrAgGQ4ueRNzxDdxHddZTK?=
 =?us-ascii?Q?mSz9ZI+yrQyAuNquHmADCndiHKOBw/JrKQCrzTUZQxBpMynaLT52UtqwMTCP?=
 =?us-ascii?Q?7Xym30NWDh/80LCeG0xmH0BwNs1wZf+L/JumK7VWa6Npdk/usNbrK8KlwgYn?=
 =?us-ascii?Q?MP+DSXnVp95ESV5jTBT634ngxQAncoqD+2TkAkrG3EXhQykr42GZP/ePEiqL?=
 =?us-ascii?Q?s/aMDgJZcWnYemkW+073T8efOTZ8p50qGWqL6I5AvCYsW3fW/W3n0nX+Ilmg?=
 =?us-ascii?Q?6PR25V2sBpMwpH32xshG7+P8otU/BZRE8IxPpAL45Rpijnx7mjL++p/u7GAt?=
 =?us-ascii?Q?3L9nGmXRvTeaGGjcSxO4hws9WDb17kk+9IHzlerMTCuybiLeU2LK3YzvzJWz?=
 =?us-ascii?Q?O//04ltNtBPe5V9MSpiV70Q/XV+9j0nlOlTqW+HNqAGW0stWURqJ/x19J4es?=
 =?us-ascii?Q?0wIIcT+Ot+s47XkyGoUNNn0+VjvMYimO3LKkwSqG8TLCBd0v30HHXiMvJd0O?=
 =?us-ascii?Q?8m1uyjlc1K5QJ7aH4FbkmRvk/Chk+9nmlxa3viRaRtG0PElJ+RUYB04qbpuD?=
 =?us-ascii?Q?nlG2/JkI/qmoxUbYjAoHoapLEIAyDBNwAK+0yfEFW1gWmdZ3Z6CdVLV3vxpM?=
 =?us-ascii?Q?c6fSdnqUZ7e4gCPwy3PA8FkdcVi79w+GxooCw0DMmbsWYVNxMaVRy363UDgT?=
 =?us-ascii?Q?CGDhZK8G9KvWyAwzs7t8hdFZ8YKixDBHGJvdc5F9IWw+8MjR00+FL9G2BkC7?=
 =?us-ascii?Q?s0wNmbbVl5kYstc+19EbL6uFlLr/WvFGi1wscl9s1trlt8+zWDa3efGZT0HG?=
 =?us-ascii?Q?cbT6a97JFgz7vL+2MnoZ3mhtRnRUL4gGDj6+klpccdOzsbJUWuwY6xk40bIK?=
 =?us-ascii?Q?xLQQEl4Qmc/+iyET9psGPYtLygLffwDYucseGNj70SCBGQge0jZssWokQYcq?=
 =?us-ascii?Q?z2cN52pGdAlEyREfVKd76baXnTFXMMESmk0F3dhfTAoadRkocC8JtpAx/9KR?=
 =?us-ascii?Q?cux4byQF3RamZwMNYedIdtO0gDW7GaYX2bAbjmbVLJvh7YmAjhcOIFeTzcaV?=
 =?us-ascii?Q?/N5yR32oyz4nqaHDc7ctTI4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c33da6-21d8-4637-a8c2-08d99da6ecff
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 02:17:31.8154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYi1CkXsIXcZZTxGXHVRQQQi7s5PJ4hAA2GPKjBy/PUi+BwrJDV2lU0zrNhs7eG8Qq+aZqfrTMEEvrbUnP7ePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 02, 2021 at 02:01:17AM +0800, Sider, Graham wrote:
> Previously Renoir compiler gfx target version was forced to Raven.
> Update driver side for completeness.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7677ced16a27..c8aade17efef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -406,7 +406,7 @@ static const struct kfd_device_info aldebaran_device_info = {
>  static const struct kfd_device_info renoir_device_info = {
>  	.asic_family = CHIP_RENOIR,
>  	.asic_name = "renoir",
> -	.gfx_target_version = 90002,
> +	.gfx_target_version = 90012,
>  	.max_pasid_bits = 16,
>  	.max_no_of_hqd  = 24,
>  	.doorbell_size  = 8,
> -- 
> 2.25.1
> 
