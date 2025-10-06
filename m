Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F95CAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 07:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EF310E573;
	Tue,  7 Oct 2025 07:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e++kc5LP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81710E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 18:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIwZysGN6IRpfRNF5lPWyKO29OiNGEoB9WG04s3rlr0biykq47Q4QJCEHzobuu9aT69tFvDGgxct1jRt813F1cEXb/hhUkrhDBZTm54OPQzueFzxsfDlYm0qMhrSnrD0ZiHhTb5IXKWl/dRL7z82CtXQ01XHUDCAxc8pLRs9E8Xq/IsP4HglGUn6E5rqdB2VfUp7e32WFQv2nFIdfnfqwMLyGDfY8NOgEnmAZD0BECwpaemuuP1gUjukIspvvTnsNPdIrSsq+cF5FYrLKZfZODhGXfzkRML0tcITJZtQRUGdmJnyfxQVpR9FcgmIpHHKhwwYs+N5XFV0LUcM4pknrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYabNuJbo0CN8QFPYeIwIu0xtwvt+mwKeOzw8Z3XWAw=;
 b=enjBFq7Y+WzscxCV+NJP0HyE/vtpsUkNdi/EmUI5tmBURHPRDEtHqSw8OFgJWLDfTp1KXugMoDR/4aDDZ0wYqv8a+7wbKWg3VfcpKsMhgOV7Ttms7KVIWhRqraSRRxbaZpHdsvYJO7F58lBcnc08qO+kVthavQePkkgxRjZZpmyxmqAMpRU3vmgcfObXwiv9sAehEI4UfjngE6L2VA+7gfZVZYurRyiNesFSSU9bd92OxiOd07JpyDcwEQmnfrTqSxFcovCtJsCZC9VJlXJmwar9SMuaDpl+ZP7CPLHFdeWe0qx022HO0Bx2ShnZEZLdLJfV5GuNSPAR6shKUa96Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYabNuJbo0CN8QFPYeIwIu0xtwvt+mwKeOzw8Z3XWAw=;
 b=e++kc5LPG8xFh8FpvJlrtNjf2YGtGdakGzlihgTyPbu076/gzl14lxkU7nf2V3idFaGLoKBQRSGZ5jHiQLazyE8F2tDJavM+a9VlCO1YhzdFbtXhCsAP1yv4zHdPCuwd2djF6puvnv6HUVpkC1161NYyg0uEWWa1Xr6j7qjrZjKiIhjp7JHBOSfrZqbJAR/EP1C0Q44ciLqqYCnYoNDEK3LDbilln0t8LoRjNXV0nNPAOY1Y7RH4Pb/Tr8+ZY2FKBqgXoYb0+o3hgDfCat+tRRQmykhOnc9B4Tbb+iNCJsLi/0wQQa0twQ45tEoEECv2ndDGPU2Gy9J9glx9kbRlWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 18:35:03 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 18:35:03 +0000
Date: Mon, 6 Oct 2025 15:35:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>, Philip Yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Linux MM <linux-mm@kvack.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Message-ID: <20251006183502.GV3360665@nvidia.com>
References: <20250926210331.17401-1-Philip.Yang@amd.com>
 <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
 <f3349a43-446f-f712-ac61-fa867cd74242@amd.com>
 <674f455e-434d-43d2-8f4f-18f577479ac9@amd.com>
 <aa910171-bc96-d8b1-1bee-65f3ef5d1f46@amd.com>
 <17ee1a4d-69cd-4be9-bd6a-2924e8731db8@amd.com>
 <20251006132144.GM3360665@nvidia.com>
 <b81d7333-192d-4b67-b270-ab9736a48589@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81d7333-192d-4b67-b270-ab9736a48589@amd.com>
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2721527b-fa9f-4f5c-d319-08de05071071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1atwngrBMWbMtHGHsAjKOmUxwhIh8+HW7gbMRmceJUycNO3m4kDR3guhvlBi?=
 =?us-ascii?Q?Edk2o398D79+VgP8qvKKnRE594KRe+HykpLdYBPIv2KsuhhnublLpp79oU+0?=
 =?us-ascii?Q?xKWYEG3IP+ybH8p+Cu1k5VTXv+b2nOo9ddvH0O2vJ9eeLu4BprEAXJRPq5Tb?=
 =?us-ascii?Q?cXEBaOfdxbE/sbdXLajBRoJNsKxwSxz7dqevxZUZQvWkXaERTfxbnRs3hwn1?=
 =?us-ascii?Q?L4MXcb3JADAtPycg9bbLiRPVONvmC6ZMEdBPxJbgInrS+YCk66t9gt8CGk4x?=
 =?us-ascii?Q?apri6qaAnnDP8Cl4njZFPZYmGkg0bidBXvao/fkDuYDSybxgdIIpQdc+961O?=
 =?us-ascii?Q?shn/TE3CvXkl053764lDbHcGXJm3bMCHU+ncTGw0/xzZKr5YNgYCJmu/ufWO?=
 =?us-ascii?Q?IpzYP6d1AXgl0u7mpmH23yPp5clZouDjrMRWspJVAzFeOdU0L+ZaF8x+6zSk?=
 =?us-ascii?Q?JhNUraRu3VHf8RiB9P6CraNu3rr9m1zMlsehNA/OsmWiIjZ9WlHXz1apAZv4?=
 =?us-ascii?Q?OUR2+P3ojVo6UOmSlu1V+UWLi7vexU7P2fMwlz249inKhLI2e7P/1W+bRoVy?=
 =?us-ascii?Q?HkpMbofLu1oGUu90LR1wvDzjC8DwbPR4ztBxizW3lHH94IWev20H9WagCNTZ?=
 =?us-ascii?Q?g3+9/ncekQ4iGUfD3fj65Y47n/wYPuaXaZRRA34QN3r8G3WloLSDuJO1wKy8?=
 =?us-ascii?Q?W1GI5DHsV+EyzD6xbjFGjGXtJxDr33MNGqd18LFWH2VV8+hRsnC4g1NVEH3d?=
 =?us-ascii?Q?JEEIp2c1TWD4QdzQq/4qWZ7EtfJI4sF3mTtFcsvXOabo+Txu5+hHJAtFOPst?=
 =?us-ascii?Q?fBG5S0SYXT4w2AsxnELfmbH4CnRHRCGWhYoHsOq/X0P1yDJOLFYOXE3G+Yce?=
 =?us-ascii?Q?cWKCeImCswDwrQHBi0fziUpD8z/Lb78wW3n+bI/jMFQJRkjWGQvo+b/cfRve?=
 =?us-ascii?Q?WwSGTv54yzu9jiyy5PlX5cKwjWox5bQ31RiX38kpU+cgetuyUp08zHG8NAn+?=
 =?us-ascii?Q?i0akO1RgcEopv4B97gnlr6bnyJkvFBWU+tqJRgx23KZhc11vyrrezMjINdEq?=
 =?us-ascii?Q?Lwlom5maQPAhKRwhyLsH7ZoGbjr2+YFZjaQPWkCGIpDfdfljNPgbM8rOx2KB?=
 =?us-ascii?Q?lgEWIiYRRdJdTYz343T8dYCjVokjFj+WcnHnnmlIjnRGhh+Z3YVVzvheVdqS?=
 =?us-ascii?Q?JBWEGWwmvYV5Zz6f/+xiL5f2rtK5GdqNo/jp2vlwpnoOWe/0xsAgOJVB2oQj?=
 =?us-ascii?Q?pbGRoE7W8OTRTy0eDML0iQWHs/cOxzAIRQZlSpgOIpB3/OZMMTVWA93QPBxs?=
 =?us-ascii?Q?WSgTRs7TYTxgTyAIcmMAdeNcMgWwci9JogUdq23wJDIUOme2qEQXCr19LwRN?=
 =?us-ascii?Q?Bszc9FHXXeEiygjo3zkc78gq6VVH2SzipGXsO56FCGqXnMnQ6Tnjy9mBtFAh?=
 =?us-ascii?Q?qDOr6QmvCysgiiCiGS2H3gnW9WWdq4+j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hoVm/JE39AFxZOfcOKA9BvEi3yiOSVX/7QEaGg7aVl1NR6zxvxUJJqfYy6VT?=
 =?us-ascii?Q?FfBzMOy4qqqSgweNQbZhSa7cwqdjFU4kSZT852jw0oOwkMWujbCyLdqLhPd0?=
 =?us-ascii?Q?GizpESCe8KKfVprzWS5A942WtsM6cLvMgJ3hPnzglY5/hVv8V7uqYek5wB3/?=
 =?us-ascii?Q?S8fDCfOrxbJjGIrxC32fexQw//+bHG6ppg09cavBeV+RNU+wedvqiqZjkFkQ?=
 =?us-ascii?Q?vsSeJwZD+Sb+WKbaN4ZBw6C9kDjI4aS8EbDYpw6SJN+s53eL61eqGRdh3qf+?=
 =?us-ascii?Q?+kiDGEtKnXJ2OUFrbe2IrxJQ9PAILkcLicmICULkPaNqD8r0xsUoREjPeTOC?=
 =?us-ascii?Q?suvvKImzCVwQ6YjTZ311cxNwJj6Os4Rv/HAMKfMdESNZN8KTun3OXTQaQBkt?=
 =?us-ascii?Q?x4C6wVEG8X/m56qoDoiu/JBNAyq48P0T4AoBuTXqLnM2s2qmVGo71KB742hI?=
 =?us-ascii?Q?6MeaMywm07xR8yt+v5CIe8Kp53mFlhbHeq6Ao3SbCgyuClSK3KQXhbK/VyZm?=
 =?us-ascii?Q?zsg1btm+9ge9NQGhf316fWtRYjA+kju/YgFPkondDCSMcl8bVk1CxsNGeX28?=
 =?us-ascii?Q?Aoa0rMC4AKDr5Rkx98xBX7zuZGnaD70EgUH1pEaxjJ1tIwnSWPrfWwKY20aC?=
 =?us-ascii?Q?fDoZeeEoHr7+uTa8viem7xFZh0Jk4LdJi3vRySyXkVLlJh1AvX9RXDewc/v4?=
 =?us-ascii?Q?e4f1db90bf+YEskPsS1bD721oSNPnk2uf4kySq7myXditL/DMAIELF6v9XK5?=
 =?us-ascii?Q?CpU7MEQLOZbsDxuuvmFjs2TPgNixPNPeV6wpS8mon3dNKxtTuuDr+QAKLrNC?=
 =?us-ascii?Q?SQqRmrd4MPTnJVItdQRemhb0xSKWqaDk/lg6DTobJ917KE84y4+Je/mDmks9?=
 =?us-ascii?Q?r8rIPsfpWA3jckgnTp9T1g0A9MYw1qFVttekHACg1Lea5D5+f7ulHvjNTWz8?=
 =?us-ascii?Q?CWYTde9OB5hf9Z5U1yx0cqSLP3/LuVUXemu3Fj/w6UxPPaaX6VRwM7BDSWCO?=
 =?us-ascii?Q?M3MSmjtSueFDulgrVDHDGE530znWpOjQi2jMIvbqmEqweppfzW+XremDpkLX?=
 =?us-ascii?Q?Y8lycjpSkXYNCDhbg/w/8Bij+yJywxW2cuJU2fhTWK2zkQjeW+OXbo8vLG9i?=
 =?us-ascii?Q?iSTKWSXtWtuyG4Vq0fVrw1zddVwi0CPx7PP7PsayGmAxbmk9R5WEwiipxdhX?=
 =?us-ascii?Q?LbWk6/g8mf9qDokLK+/FFsoI/r4SCY9xz7asQcgEQ7EkxiDvsUmhV0QA23cL?=
 =?us-ascii?Q?bMXM2uHaxnkOen5eoy5WmOmM8AqsKyjGxmNBQmrw7lf82AUIZ6TznDmlk2lm?=
 =?us-ascii?Q?6LesY6x0jP1smwjHffqQ/yD7GzQymZ+OokHOlJss11ugBF/91mTtFaCPcw7W?=
 =?us-ascii?Q?wtr9INoK5YUVTc8PrqrcCGDceO77Oc4+Uvjclh7DkbL8lomE2iBUVZWufFBy?=
 =?us-ascii?Q?KbX9zqHKVy/42vljuROTxFnGynRKSQUmM/Hg0D9InW7BE4N/k1aYlsIs5CSw?=
 =?us-ascii?Q?/2aLUzUrupFZWqPwSKnVMFCQ5ih703i1RkzVos23io4uuOrBEldxo4A9Ct2L?=
 =?us-ascii?Q?oQ/OAt9UWVusnPD2040=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2721527b-fa9f-4f5c-d319-08de05071071
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:35:03.3457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiNjI3LzBakUWIXPI+L+i27ACUgMpFma53WOhbn9UTtcapSApb0b4sfs1EqJkCio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
X-Mailman-Approved-At: Tue, 07 Oct 2025 07:16:13 +0000
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

On Mon, Oct 06, 2025 at 01:51:37PM -0400, Felix Kuehling wrote:

>    OK. We made an incorrect assumption that we can reuse a page if the
>    driver isn't tracking it as allocated to any of our SVM ranges (i.e.,
>    after dev_pagemap_ops.migrate_to_ram() migrated all data out of the
>    page). However, we neglected that other parts of the kernel can still
>    hold references to a page even after that.

Yes, that sounds completely incorrect.

>    As I understand it, it's a race condition. The driver is done with the
>    page and its migrate_to_ram() call has completed. But do_swap_page
>    hasn't called put_page yet. At the same time, another thread is trying
>    to reuse the page, migrating data back to VRAM.

Which means the driver is not properly tracking freed pages.

I don't think the code you showed makes alot of sense, if someone else
has a reference on the page it could be for many reasons. If you take
a non-free page and treat it as free and safe to use you probably are
adding a security bug.

Jason
