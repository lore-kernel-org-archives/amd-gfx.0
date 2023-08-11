Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7C1C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 13:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8828110E102;
	Fri, 11 Aug 2023 13:45:04 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3604710E0E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 13:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCohLkbg5yucQ7bL+R5kGoDhcEQ0VV8JEp5+JwMBhnu1xHCzqVsfYMKX1TluizGgG1LlObyMunjhqbRR6blf5zbPJTHKWvvG7efL3SYc1FtT+XZWbFlD5J3lAjNhbgXVHA89HDaXP40q9u8JBnZv06II6NhRtfCxJB6gP0S8n9XmXt3pprtlAGkpZNMnQI9O1N869ecWyLiQX1Y3wLBIHJPXSXnDC4/vDsHfUD+oAo1CD5lB20cVnU7OtFkPDi1Wyy0ugb+nXC+pgtVhukNg8CLzas9Dgt4qzlYARsaS89WMbh9N8LqIXmusMN9yGJfj9xROqF2VDKGmx3OwWSUwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFZ1kKaUrF7A627QsF5FOzottD8kmfIGrXpQ+bS44H4=;
 b=QvmaxoLxEg9XsPpJMYkrvYcwKMwesQdgPcjYmKu3+hmWUqnnkhysCCdlqu/yDmA8PbVrxSu01N2Sg/5Gqr5kivg2lEymHbAefe2AhcJvw+50L8SgqzJwSLxvNPR/eLLhH0RRz1yJpAK8TESdYRrGovMoNYFhgOOja/VlcsYPPJxDaHFHSZpm6MjKh3l1Y/AZFTBSenbbzfOotmm/Xzvv/K9ZFxhVyykbPQTIOHdt3l534+rvWRKkgM0ehbypWLTcpPvY2FUWQGqx2xWkyGfpHQY6/xSsl0+ihyU4OH0CkRhhvZPLMPC0oDTHGwFvRDQXkudMKgUg85O76PDkBLbSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFZ1kKaUrF7A627QsF5FOzottD8kmfIGrXpQ+bS44H4=;
 b=pq1dsKufU8gc0QFek8BbYW07q+A6H0OFz+Y8glt1K7tWa/aUyZBdQjd5HM7k23ElYBfoyYV6ezlfXEtsCLIKZRTn/tiNw56pgZkA73AMT9JGIdrlW1ZKMczx6tFSdrFM6x/Ct/9VYW+TCOnf9ZDtxwAsCDA3fKy2efvATeTlZ07U9dYF0jzDu9E/u9tiUu2knnow9h60e43GSbQyn3t1MjZ63LeLE1EqAFhowNN83yiW/hfe17y/KaKSpCKAxLxez3+Q+FlkuHIr7rd5h4r0Dq1ZvK647bAaXxFjvMw2xX4QyEGjNS7sNaBo/pAVJoyW5MZCiGtudtvYaRmMjQIExQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:41:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 13:41:22 +0000
Date: Fri, 11 Aug 2023 10:41:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
Message-ID: <ZNY6f7gUuxw7jXSK@nvidia.com>
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: acdba052-b474-4682-d8f1-08db9a70a62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv0dYeiIJlREOnrsUTv6DwZsfbMHxC9+v0ICozUqqMvZ3DkZAFvevHq4Qy41fLl28B7fvIrLbsMRdjDZrrHQvbIVZ2C6Yo6orkxKC6Ml5J6zisyDlqknXx49RwMshlAC7OFIHEAf4s0y7UxenbEut4BOGgzzIst4I05RV1X3jSdGgH4Td+o1A7e3CvOhxjt0gFbfgQMmVrxsM5XLpQxbto1P1X6aKYHAYNuofYzhfd3abEW7KGdxnpDQtDHfw66Ve/866W74c5w9ntFsWCe9Q/ECUZBTzQp+0n7HAUUf/Ke+lEAF0CwRczIv+y+wA+C3QZpsPbv+r7uzHaKUr4IDuii6j85pZvWjOPh+n6T4wQsoicqjgZ55nZKqIbQ9ZJEjYgH3D3PFfb3CeLB/bI/j0q3qEAYXD8uIEvbbGFgT81ftvr6j1tQKSGzF5Gf2Kuz9LuPT7JJPLsn/H16Wa2Oa+XmT+txWnOKawiVbqONUROav2bY9R5YcQH71HtmYgG8gqp/tEiQbLeGB/VeZ0V/G6FHk5mNE85eLsVTrgwPseX8G+L6LGNATj1rgaLl5lzM/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(1800799006)(186006)(316002)(6512007)(478600001)(2616005)(6666004)(5660300002)(6486002)(66556008)(66946007)(66476007)(86362001)(8936002)(41300700001)(8676002)(6916009)(4326008)(4744005)(83380400001)(36756003)(2906002)(6506007)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cYWpmNSbnB9iGP4ZmaZmgXCnIitU4DXMtaFwPabN5/o7wkKg3g6EPwr69Wc?=
 =?us-ascii?Q?B9ENDHJ5uNxNuyj/m1rdvJ/oedonH0AVNOYZDLLvJP7fsxcoQ6uemMEyDn9T?=
 =?us-ascii?Q?EpeM+o8hMm0EFTda8yj8rByVY10qz61VQIY1ke9O4Xdspz8l5G0yIxMRVBRm?=
 =?us-ascii?Q?Tya0yLJcmvK86QovdZn585Q+E7Vae4fsxRZ3wQOj9c73GH10kqFjpq9VHHUC?=
 =?us-ascii?Q?3daBfHgRuURYw/T6r/ZEkuXJA5gEquqZW6rcQ7e17F2r6fobw2H9O/Slir49?=
 =?us-ascii?Q?hPWyG16RCQTkJzeaJ2MF2vSZiWsTWJe28vpRa+yDAJIl5A4Gbs1QGwXpE27Z?=
 =?us-ascii?Q?yAg7oadBdmK6EE6fLcfJZJTZ3zqBqz0Hym0kkGJS4Vnoop1NspE+w43BJpV2?=
 =?us-ascii?Q?fXZYYxUpHZGrJXSrCURnGrvxWGhh/8oDQeWBrd3mp8kPKbGDBNyKqhFwSe+f?=
 =?us-ascii?Q?dY3WRnYBhwSeqssHKiAscC8IZhS7eGNK7+3ElVquKSIz2+j4PcVhQ4X/pwUT?=
 =?us-ascii?Q?Bmz0RH9cJCEFSAjkW/tm8SsoJwV5xlCSmObvYsiwV5qq7qeDb35qxsYJ7HH/?=
 =?us-ascii?Q?AIxbSKs33H2MvKBok0PFmjITmJOnVcofOq8x9Chff2kB/xUlCAWeJ4Ol86Ue?=
 =?us-ascii?Q?2uY/QcEbMF4bXaSH9L8M7KQg0XT2KN8dOpwPVBQAiIN6pOXfKbuYD8hY8gzG?=
 =?us-ascii?Q?sGy5vcp1qA2NsO8fxEvhrucDLbCYg/F9/QrMUb/hWc+pUml6FIYjeDHykiSK?=
 =?us-ascii?Q?a1iu7JVFM/rzF7sy/nAOHlffPjx6hLiyo/jWdkKswIUlPilJjC4GYiHJnmww?=
 =?us-ascii?Q?esqvSTE01StcIaDYKCDAiWJlDzvxeE3qFhtdUNn+Jdt+iRgpbJKfOHdxR+KA?=
 =?us-ascii?Q?wpOxUcFmsI+7+5ZtzZPtRyoiJy42d/zvwgbiavvCYgnanOnOUv3LVPJpoyzK?=
 =?us-ascii?Q?H9vGDaxxg3TBNALZn+NfST5T4wdAb2sejfGcUWWAOitujbYckNBqF6Py5kxv?=
 =?us-ascii?Q?EOP1xL8+ifdy9lVA84iVMvsMgI/WCMmFGdplhHAZc2BxzYrjpik6tJa+vhoG?=
 =?us-ascii?Q?aQXJ0kBrKbPSqvC5SVsTyqUYNfq7iqghT+q/MIG3hia7Oicm3l2rkAL7ZYUs?=
 =?us-ascii?Q?FhdIfKj3XjmPl9y+G5YMlLBFMJFM44liirgc5QHJDqJCbnM0XzxLnbL3NNvO?=
 =?us-ascii?Q?RO6f9GrNDXY0Dg3SFEZB6Z4hQ85K3A7+Blt1M7f0pfW/oLKSht+gCMqn7/Is?=
 =?us-ascii?Q?MbyNtgzNtPo+nRGWtMMhei+hkg1sI/Ppr355j1YU2KnT761UY7zxzvRzqEgG?=
 =?us-ascii?Q?g4Pzmy4rn5l71FuxmlR9s5JqHAWiZjClbE6wODIymU7vqIL4JeaMUVmHaNpO?=
 =?us-ascii?Q?5ryDSjT7VxFclDxMC2vJeTsKutpaTApD65eAeI03Gdf46OWmTJtPq341nPyR?=
 =?us-ascii?Q?GsB+wgrBscaRJWlWhLhO0+vEpvJ7MPUTis69LrydFhUa1IDIMiCtQ4t0Rgna?=
 =?us-ascii?Q?LPTOw1HPoeVykGPJRosJl2y92ql7+FhmA+lPeTy1GnTEzmjeLopNvCJl4WZr?=
 =?us-ascii?Q?5Fd+jDPci55PVCymIOhVOdY7M7Bu1v0jHd7hh9JS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdba052-b474-4682-d8f1-08db9a70a62d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 13:41:22.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlnM41ZHFVEevxVLpfvixFYC3ZM2jy/FcAFxpWrD+NnHGUZqB/AwbCV1FE2GFjdH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-Mailman-Approved-At: Fri, 11 Aug 2023 13:45:00 +0000
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
Cc: Christian Konig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 07, 2023 at 06:05:41PM -0400, Alex Deucher wrote:
> We are dropping the IOMMUv2 path, so no need to enable this.
> It's often buggy on consumer platforms anyway.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
>  1 file changed, 4 deletions(-)

For the series, please can we go ahead with this ASAP?

The iommu side desperately needs the removal of the iommu_v2 private
interface to the GPU.

I'm really glad to see we can just delete the whole thing!

Thanks,
Jason
