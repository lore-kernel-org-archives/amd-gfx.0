Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485A606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F9WQ6ZKs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B2F1124E6;
	Thu, 22 Oct 2026 11:01:50 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C651124F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 11:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPcCgCoGisi9fl+2/flgd71g7/ISwgal7zBCuIoPoYipIiEGaRKfDQvW/SKO7Hggkp3TdkNV7V0anAWlzv/AFJlvP1Qp4QsbTUWbQ4E/zhW9jB8MQ6tB7hqyv/z9IkRYzwpQcp+oYvvthh9w7GV0VYFVYazshCnyxhiwGxpdo5zdyTdNWIg2vw/V9hXOE2umXGd2j50i0IytoV6vp/pGtgBThHTBb+yh9f5NShJjU5tQe8xYMqQrxTp7JCH+yYp9eprM5KEYukhKJ+y//v8R1bZHVhfMt7pCdHWP3cNj6kZDoSx44GTE3yjaBcsLQyPfaq7+eDGhRSmo/I474lPh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGudv0Kn8uAVn56qI1vgjAEGFl8k72IX/GDknR8bi/8=;
 b=xWCPQ/SusxdmtOEzj2yiG4RvZrlOJn5G/zIOFQWnQp1odLTrvcGpZLLSEnu6cNzVT2cQD5bG4GuOXiPK90sI74ikOJUju9MpQj5aR6bieOUv4F8/uc8dXkbhZytKGf5s9H/P5UhXjEcozs2KOhU6bCJS2P7HTzIE2x0StswD9oW+AFBQV8vIgCGU4C6BKnPbOTWIS2LCcmPBSMw4g4GL/9VcJ9CCdv06k9finmtyCht/QqRkt/9tlQritJV02WbQI9IR2Nlx/aIm144TDBuHF2pr1068Cp/lFu21S59VWvcs6gBIIA/x8Qq7tfT+KKwj+xxdJ99dKTfe1Ndc3kMXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGudv0Kn8uAVn56qI1vgjAEGFl8k72IX/GDknR8bi/8=;
 b=F9WQ6ZKs1ZDAkzvFMQoU/QLl3WYew4q4lYTXHqAIOueSMXG6bkBDu3B9fZizBF1byX/YmLdiTjS0Eo7uWDt1tje38uXb6b/SrETq8rTmd9ClR/e4VsJVw4XB9kVbEM9OZFBnViB413TwU7frfiwz/BKY3BQJoP4WXEJRiTi21do=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS4PR12MB999101.namprd12.prod.outlook.com (2603:10b6:8:2fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 11:01:42 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 11:01:40 +0000
Message-ID: <db52eac7-d3c2-45fe-ad95-ec7e0dda6a1a@amd.com>
Date: Thu, 22 Oct 2026 16:31:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20261001182410.1525285-1-superm1@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261001182410.1525285-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0356.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::12) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS4PR12MB999101:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f94f96-bb88-4c8d-602e-08df302bd965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: c9j5YOQnS5lVIxFB8wjNG4dXpS5vQksqTSAw8/8DSzJyQkzUxoAdcTvqqCvEDJgg4kigp3og4OBam6eS/mfvzTcVtaqU1y3GDKcJtHeIc5Hz9Z57wMp7Ju61toYNE5tQhX+6ey9rMEo0SrZkEGjEl7zIwJD6L24TpDRVQsLJEdEwe7oGthr36EVGuz8IHUPPrGpbxb7eFhNHfdSxsCSK1PlFV2RnTk/yBCFdOJNMo6yCevEToCTlhnkA+Iv0EkSjmWQuCyXJCHmrvKGgVs8HmsCRVBNDl7v85z9qrK10BVCtl2Tz/Hc+Pvn9Orh5v5AVDsbyUOQxDsHwLxsqHxo48QfwncJGI8d+UTX0JhXqdZEIEwl1zpj0QDdjY1t1I9+ihHUc4L8MJVRbWWXO0BJ2CnlNFj4Te8Cm3Ja9PRyyZ4El1+s/E2br6py+vlMERn85AqCUaEja2e0NUdxuePf7AN2JyHgvq4QZC8oHHmUbhnRKFEhBUb9+C5bFBDgWXY2wKU3lgm5qzKge0UXoGdSaI6zXaXZb21nKG7yNHLGcZVgniY5pb/NjE3Oj3CzCDzJoJP2ES15q5pP88Jr2un1nZorYuq0yD9JgIbvf1l6n0qa3kfLaUM5dqAg7leLUQQGw9xk5jo6kfwLHJVvw/4/sTNaCCQC8e7koXEZrr8mZIqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL4PR12MB9505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGplVm9ML0VhU0hWRXM0YjBpTUdxT2dHWE0rZlBqb0lLZXQySnVxNGVoRml0?=
 =?utf-8?B?ZE40N1dsSmcwK0NGOGVTY3NZSWZ5UHByNk5XVUIwTWxCcWFGRTY1Ujd2Q2Nz?=
 =?utf-8?B?Z2wyZG5HTmJlb2lIWlBVQ0k1Nkd4aXNiZGhtSFhBTSs3NDlNZklsbFByazZN?=
 =?utf-8?B?YnN1b245dnJ2OUxHNzZ3cHo1SVBBNUVhcEs5OXZoM3Z4dlUrWnBITjIzdmJC?=
 =?utf-8?B?cXJzUkdBVUVMbG1jZlVaZ3E2YVNhaktnbjI5MmRXczAwVXRleDJQWHJZcC9M?=
 =?utf-8?B?dUlCbTNPK1NFUmZPM3gxdWUwRCs2Z2MrYkphRW5qbnVtVThZQ0VmbjN3dFNw?=
 =?utf-8?B?RHpmNVVTMUQxa0hZNktvbFBCaWwzN0NLU3dRU21aYjczM0p5ZXZuMkhhNU5r?=
 =?utf-8?B?V0FMaHNCTmY4MXNuTlBVTStFMkRvRmVNbFdURTJlSlVwK2tFWFBrQll6ei9W?=
 =?utf-8?B?SDN5VnVjSVNBd3poQUFreDRrTWpjNHhPWEpOL3Y0dGpWd2N2OGdSWkhwRnhO?=
 =?utf-8?B?NWQxSGlxZEJLU2lZOWY5NE96TGZzWFFyQi8wN3A5cWdCd3JGMnExYklPc0di?=
 =?utf-8?B?R2lsL1p4TzNEZ3Rja3A3am9LYi96aGFuOVdIVndrTjRzdjNjWnNEVCtYSzFL?=
 =?utf-8?B?aFQxVlZVSDJmQUlmdFBXZEhXUWFCemo1Mnp0SWtDVmpnYTF0by8xcTlqdzc4?=
 =?utf-8?B?K0FRTnI1ZjVheTI0aU5VcE9LOUNkcWlHbm1XRXZXNVlXSEFZTE5sQVVHM3VC?=
 =?utf-8?B?d3gwcGNIQkowaHJjZEwzZlpFemVURldldmlvaVpEUVU3MERDMkRuVk9SSGtj?=
 =?utf-8?B?a2dCRDhrN2ZRNVo2RDZxSHhRM2xSUnpzN09HMUxpZldPVGJRRU5MZWlDTkRL?=
 =?utf-8?B?Yy93TGdWUVo2V3ZtNWFobHpVNEtkNjhFeXZZaDE5QmY0b3BneFZpNFVwazRy?=
 =?utf-8?B?M0Z4R3l5S2tIMXQ4YXhxdCtqL2paTHpPQS9NRHB1WDlNQWhLa2dKaVVNRGIx?=
 =?utf-8?B?ZHhaNkhzM1Rvekc2WEFOWFFTQm9Pa2k0NUYrc2NZM2EvMnlYbFZsU0RXSnBJ?=
 =?utf-8?B?eDRUbFFOVTM2TFFJY2xYMHlYcVdqa2tLUE01aS9iM2FiejA1azU4U3RwVmhO?=
 =?utf-8?B?Y1g3SjZJaDYzcFQzU0lERkRXc2owMjJEb0NKOVJaNmt3ZmIxQ3NVZkVYRExy?=
 =?utf-8?B?R2VrNHF6SDBrTjFjdVdDL3JUY1ZiaEZIQmcyZ3hlaExtcWdwdmFJMktRelZY?=
 =?utf-8?B?aGJMZTc3M0FzNk0vOFNIdEZGSmJMUStkK1EyWjE2eXNlRmo3dUN0bzZNTU5S?=
 =?utf-8?B?eVcwWjQyOUJpdDJCaFFsT3NIVFZjRkFrV09IdmQraFFKSWQyUmlSQWZCTExk?=
 =?utf-8?B?VDNUL0VyaXRrc3FPYWxzOE5vZWFWT0QyZHdGczJ1b3JGQkJTRkFTNzVSQ1pE?=
 =?utf-8?B?bU43bk5tTzVTc1A1cGdWb2ZRanNmb3BEbEJFMndIY3J2TmVscVRncmNaNmV3?=
 =?utf-8?B?RTR4ZlBjOW9tK1hmUXdQQXVINVNUc3N0cFFJb0Myb1czNlpodTdwNnhIZjh5?=
 =?utf-8?B?VUlIUzBKUmU2b2h1Tit6bmpRbmVlcG8xbmJrckdTOER5dVJMWXVpSjhraldG?=
 =?utf-8?B?bnJrNDFZNUxwM1NjTm9UbGlFVjl4U2J5TG5UWUZjUnZZejQza1U2eUJxT09B?=
 =?utf-8?B?Ri9nQ25iMUx4d0IrTzF3Z3QrNmdFUW9yWkRsMU9tYWxWVzJqdHRBNFhrYlZI?=
 =?utf-8?B?RnIzY243REtWZStYdkpqcndTVE9TUXlzQVYxSXU1eEQ1dWJBQWNLUVpDUk9y?=
 =?utf-8?B?RmhrNm1rOHZnZFJUM0F2bEtqY3E2d01sYTY3VGFSenowSDRsdVdJbmdSZ0xT?=
 =?utf-8?B?OU50d2o2Zm85clE5a3ZQUVM1Q1BuZUNDUlFlY1c4Qm1VUWtVLzhHY2drckND?=
 =?utf-8?B?SHpVWXZLZVlxb3I5d25pdTYzYXhVV0lLM25tYVBkaVI1TldLSjgrWTh2WHQw?=
 =?utf-8?B?TFY1Y0R6TTRpSkFaMnl4bDRMaWtwUlRiU2NxbitaZXE5RDYyYjZhVEJ1dWZq?=
 =?utf-8?B?VTRmY1Z5RDZSTGdETTFpeUpFcHdISjg4ZU1QVS9jZ2RQS0JZUmVmYnJHQXlQ?=
 =?utf-8?B?TS8rL0NiWGdwaVBKb3grVlJlMWZaYUFBTjVkNVhQckw4cUhwcVQ4ZCtpOFJF?=
 =?utf-8?B?emg5T1JCb0dLS1JOeEtUZitDa3ZFdXhLWmhrSW8rampSY0ZpWThVTTZ5Q3lC?=
 =?utf-8?B?MjBod0RYL0t2b09DR0JXMGx5VTRyeVdTMjA0T0hmRWFCRG92SmtMSVAzRTF1?=
 =?utf-8?Q?Tya1rJeAhC7GoCZjiM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f94f96-bb88-4c8d-602e-08df302bd965
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:01:40.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0YFpcxoO8BNo3Pjjfjl947/mGK/taNiBkKIKG99kgWX3pgpvn3cxrUB9ay2TWKJza59I8RnIchj+s6HwzjEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999101
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mario,


On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
> PerfOpt is only a feature usable by integrated GPUs and only in identity
> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> an integrated GPU is in identity.
> 
> PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
> it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
> table in the fast path).
> 
> This drops quite a bit of compatibility glue.  There was a refcounting
> system, exported symbols, and device attach/detach logic.  By just setting
> it immediately it's a lot more straightforward.

I believe its good to get this merged in this cycle itself so that we can get
rid of the command line options introduced earlier.

I have looked into this patch again. How about somthing like below:

  - Do not call amd_iommu_perfopt_set() in early_enable_iommu() path
    Because it enables feature on all IOMMUs even though it may not have iGPUs

  - amd_iommu_def_domain_type:
    mark device PerfOpt-eligible
    select identity

  - identity attach:
    Enable IOMMU perfOpt feature

  - DMA / Blocked domain
    Disable IOMMU perfOpt feature

  - resume:
    restore hardware bit


-Vasant

