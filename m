Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF19C02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3927110E327;
	Fri,  7 Feb 2025 14:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mv3iAcE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A6710E327
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAdEO4fajXKzty4CN61tUe1pkLhiYSTNrXJHydf+GrxR/Z35bZpeND4iXqXMDNG703aNXWguv1es7swIEfPK5kCu9NcZpMIoTW1lwaJ6ax47wkKDZWLY8iPdSLsPybTBAjSTNTo8YkJZ+uVnKAvsa7sw6v56uORaF2o+wkqwp2OpIdLEHbAD6cW5KEX83eOgUbyBMiH5O6kpoKCd6e21cOr/gZxfccaxxjwupYt10PpF4mRA5kzehv3VTWcNwe2NhBezVbBzAZXFee+aSxTBXcFz/CGDmIJI02xy2TRKmSr4eaFPPUcHpRE36Cu/FE5Lzc1ZcfJ5GM8d5YTmsJIb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRFrw/iCD6mvoCn3Lc2hgSXjoBEkGhru9E4wHdm5oVQ=;
 b=Lc+K/Oz/zVeYFGcqV/Sb/sVKMiFn7W6PyPnO1RbwbKybplpKpRfmLk+QRBcVic2Oqw1Jsuq+WFMbE9ACGBHGeUuQ/XVnieFYeQfPbPJPfdiKMyNx9akORYJASX/uLQ7XDu+B+ydXiZfV9LJoUQxSOo4T378XkhDcIN2wCR0pgDlm19palurc99eqenPjYdZShRiHnbGFpdLjgGcWRlAYsfagdYBML0HDA1jB1WnM0SQOZf9zHGBUGiKabXnTqW0iJDxHeOLwnCIIr6VG9DEVRfcjOWMTM6jiYz8lKfoxI/h+jXyMk66JqgwausZytvsTZFrvVEbzgJK9wPChrPl0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRFrw/iCD6mvoCn3Lc2hgSXjoBEkGhru9E4wHdm5oVQ=;
 b=5mv3iAcE/FY474Q2qFtHbVTwTWQH9m+dmbkoe3p63oF++dQxj1rORSGT78Y4Sft5aXKpueVi10cP97to+f2wqgNwxVE3L0oDvi7OjfAs9XRsE+U/gaTwCLLuCCM+zsX1a5Lk1pwkGz4eFTzSOELM/AeuQtLuYAvCaXB4gzb8pY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 14:53:37 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:53:37 +0000
Message-ID: <4b2b5d62-5456-6695-f4a2-4414e6c42458@amd.com>
Date: Fri, 7 Feb 2025 09:53:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250123203931.18867-1-Philip.Yang@amd.com>
 <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
 <2cff3ac0-9f56-aaf9-6c6f-59c69606efec@amd.com>
 <328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e52e88-1074-403a-d2a4-08dd478733a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWVlOTBIVUorT1JBS2F6bUFqS2g0Z0lRdndBdm00NG9lVjVFaFQ4dlBzc2Vn?=
 =?utf-8?B?Y3FkU05rTEM2czdaZWMxODVGaWtnN1U4NEd6cDl2L0Jlek1YUlBIRCs4WDlR?=
 =?utf-8?B?NEtqc0c3WGNNdU9WSHlrSHZJT2NZT3B0Y2VRdEtHZ2JMSWhHYjBiSEJ4MXQw?=
 =?utf-8?B?SEJBOHB2S3R6cC9DRmVkbGpXNEVDNzErUExNR2VXY05VUFI5V2I3TzkraG1k?=
 =?utf-8?B?S0VSTWlKa3dYbUJGVWFZd0ZFL2ZwNnFjZ3M2K0l4N285RlUvalZTQ3EzbWJQ?=
 =?utf-8?B?SXh6VXc4RjhobWw1MG9GenBJMVZucTVqOVlUQTZ5bjBSaTNyV2F2RnViMnBR?=
 =?utf-8?B?Q2ppVlFlVW9laHhTM1Y0UVBaT3NUeFZFN0ZYQjNZVkV4d0E4UGhUWUQ1anpH?=
 =?utf-8?B?VU5hSWxrL0pWdmJDS1RxNGZ3MDQ4aVlyR0lEV1ZwSksvZEFtazU4dnFRK0tV?=
 =?utf-8?B?U1daMVFtU1RiVjQvaHJMTDFVSDY1WUxDM3IzRzJkWGNpVmlMdGVtS01EL1Aw?=
 =?utf-8?B?azlhclMxZzJCdWlkM3ZrbmlKYkpQWlc2d1MrVzZjQmI4S3V5RkNGNEN0d0c0?=
 =?utf-8?B?YVlHVVY5dVUxa0tyRk1Ra3U0VVBhQmpLckdrY0tQdWd4WG5GZHo1VWM4Tmxz?=
 =?utf-8?B?OEVuRWxzMjFlRUh4aDRlMXFDMFNxMG1OSzVXK1BYVGVIWG9XQ2tkNVVidlEz?=
 =?utf-8?B?Nk9nM3BoQk1UVzZndE9nMTU3clVNa0FUVmF4TzIrQlphdE1obXVleTBmeVJM?=
 =?utf-8?B?N3h0UnRSbmc4enJHZWxQL3Z2VUpTVnRLZno5cFRlaVpxbFI3NDFFL0dDeWlL?=
 =?utf-8?B?eHhYRTJVVzhRbnhlVzh6a2VLaUxQZEppQ0ZaTWYyYXFnRENFVEVleDRRendU?=
 =?utf-8?B?cjcrVW40VGJKcVV4ZU52YUQrT1YxS0kreVY4NnFJakVRMHdCdEE2N0JCT0dU?=
 =?utf-8?B?aUJrVStSM1NRK3JmMVduQjdta3R5cEF4cmdwWE0vSEI1a0dqa0FRSkZSMXk5?=
 =?utf-8?B?RExTOXR5aStDRzZyTTV5d1h0dlMvcXc5NG9jdkg5ck1rMGdWRmJjUnJoUFFC?=
 =?utf-8?B?K0w4TVcrU01vUVlCUkw3ZERoS01jcVFJOTFzdXdZZFIzTnJTTUFaNENqWmRo?=
 =?utf-8?B?aDB3NkNjZ0ZZT09YUlJ3UHF6MTJKemZLVUVYT2ttOXlpa0Zndk5NcXc3MzFy?=
 =?utf-8?B?Q2FJZW12Zm12V0VDRUdvNlJudTkvVzdRcEkzdGduRlVxMDFRSkZYR2pKcmVU?=
 =?utf-8?B?VHNUZkN6WHFqZ3k2VUVVNTE2RnFaZGo2SmExRUpPbUUxUGpZbS9BMDhHczFV?=
 =?utf-8?B?RXR4aFRuOWF1WUE2cERvWURMLzRpMlY0bXFRU0dpYy9IWXczSmJWUi9ESENK?=
 =?utf-8?B?UlZIVUJiamdRMnNjSEowOENlRVlxdnBrMkljUG1CM1JrYU5mWExCYzRyY0dC?=
 =?utf-8?B?bUxqTXJXOTVUSFlDanplbTFVb1ZTenBkV1p1V2dMVXFVVGhielVYYzJUOE54?=
 =?utf-8?B?Y0ZrM0doL3o3L0p4N1B1dnZDY2dLSmpUckhvZ052V2x4bWtzR0xZMmQyRXA2?=
 =?utf-8?B?ZC83QzNXWVc1YzFhcGE2QkpnNm8zYzNqVXhuWjkwTUhIQmNVaGRkdVM2clJt?=
 =?utf-8?B?b24xSmdINmlqQkxQWmZaVmNZL1FCbXZUaHExclRjMVA0dkRNSzRrTUJpVWxm?=
 =?utf-8?B?VEJWKzZ1d2NPK04yT04zU3ZUMDBQUTdKRlNWWmUvL2djRnVuTXEzN0Z3YVRQ?=
 =?utf-8?B?bDlISklmSlJCMXAzOVZabTlkQWlub2ZNM0k1Tk5TUHl0bTFEWCs0R1Y0V3VG?=
 =?utf-8?B?d0tIVHpuZFpidXZzcUFyaFc4Wmp1ajlpOGpVM3BMOW1KcVF0S0FkM1lQT3ZM?=
 =?utf-8?Q?JN2V/wwnkMKQD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFUWjBjTjlDMXM3K2ZENE5EVFYvTGlDWFFYSTdYRFJIL2hLSkd2VnpEV1BB?=
 =?utf-8?B?T2YwejhYNUwxeHlaOUkranF6eVpyb2F6U0JoSnVyUU9UMEo0eW9xc3l1dXFV?=
 =?utf-8?B?UGVoS0p3VTFXSC81NmFLQzQxdytXSUlXV2N2MTI1RHo3RDJuSHZJVFB4dkdp?=
 =?utf-8?B?eWJBeFN2Um0yaERCUUlXVDRQUUYxdVlTSDlLVExsLzJCOFVXMytzVG4xZElo?=
 =?utf-8?B?SThuUzFqQTJZZTl1ZVZGRXE3SGRrN0dTNGwrZWRyUGhFYUpkUElaaUFqaHBR?=
 =?utf-8?B?ZkNiOENsVzIwWkVsTk1pU2pMWDh3cGVXUWxUUUM1OFEyVnN6ZVJrZStBU2I4?=
 =?utf-8?B?bzl5ZGc2L25ZdEg5TUZXUjA0VnRIUjhtU0FNYktZZ3UvQkJ6Uk53bHNkZkxj?=
 =?utf-8?B?Nkx1bHJlOWZXRVRhSFVKSThBei8yRXhhdFZsdDV1UkhuYmdwalR5blV3YVlo?=
 =?utf-8?B?ODlpOTNmR09QWWI5TkhOZnVWSFUxSWp5TjNQZE5saDVzSjl1YjJHYlZBUEh2?=
 =?utf-8?B?YkF4Q1QxUnZyNFoyVHQ3UkEvNEI2cGZnSGF6Z2RMU0lUN3ZNd2pFZFRpZWo3?=
 =?utf-8?B?WThsYzF3L3gwMmpmN2ZqS0JoejFWVHpMZkVXVFI3dnZoQzE0Y1FjNVdkTkZK?=
 =?utf-8?B?blhQQmJBWmJvaUtSR0tRcWZUeFJudVdGSnlIeGd4bkRtWVUxWG9paXROd3Bz?=
 =?utf-8?B?cmIxYjdMc1o3RUtuaTZQZUJ2eUJERS9hZWhsdkliQmNESVVqd2orNGJlWnlR?=
 =?utf-8?B?alo4dXJDZmZwZVE0S0MrM1BXeGZ6S0g5RWFWd0tSQWZneHFXOXNOSHorM0hv?=
 =?utf-8?B?bjR1M2JmckNXNXBCVzB3VnFWVC9KMWYyb3JQd2lpMzlsUE9kcWpOTkdTcVBW?=
 =?utf-8?B?QVJyWllxRm10NmtwOWFwMEwvNTlMSEFRaU1rN2piQjJwaS9tL2o2TkNBQ1l6?=
 =?utf-8?B?cFgyY21UWnRtMWgxSlVoTDczR2lGMDA4Ky9xMzY3eENGNndSM3p4SGh4Vis4?=
 =?utf-8?B?c2JjbUhzSitZOHpEc212d0IvMlp4YmhObUw0b2tzdHEzdHphMENSelYraHpO?=
 =?utf-8?B?YXRkUDNqdHZBdW91ajM4RlV2MDBMNWFIakxIL0FycWdHQm9taXZ4RkR4eGhQ?=
 =?utf-8?B?Q1M3YVZualk3a1NBM0pILzFvZFNmRHBjSHljMExIN3BoQktCNmFmalRLUXNr?=
 =?utf-8?B?SUcxRU94V1MzUVNZYU0yNTZKYW1Sa0pocHJVME41NmMzWjZGUlpTYTFUejM3?=
 =?utf-8?B?MHIvSmRURVhWNjBScmEwQnoxeG5ObjFhK29ka0NzSDdGWUNjbjd2QWFtUjMv?=
 =?utf-8?B?NStGRTlXcFRuRHJlelhjT1IvS1ZHUWw1VUwrbDNXNGxmc1BxbE1KU3Q3ZFBD?=
 =?utf-8?B?QVUwM2NrYStRS094aTBnTEhqYXFZQk9yZWt3ZGtSZXhSeWdaSmp3bDdDN3RI?=
 =?utf-8?B?NFR0WHMxaHNjN1VxTTB5dGN0R0ZPZitVekNsTHZZWlNuTnhiMWN0WWRqUGVy?=
 =?utf-8?B?b2pHaEV6a1dGalhMOThiMExBZkt6dGtJUEtMQVBxSXBKSmpTRFVBVTJJZnBr?=
 =?utf-8?B?akdvY2c1ZGpoOFBxV0NuS2FGU2dIOHo3TXQ2ZGd4UmVxWEs1bnp0b0wwK0ZL?=
 =?utf-8?B?ZVJPUUNyL3RWNDJpam5Uc3J0aWpxSlNhYXkxZll4U2dwVlUxNytrZ1lFR3oz?=
 =?utf-8?B?djNLOUtNTFlTMEFuTDB4K1JMY095VU1oa09BbmF0eXpRc0w3Y1NNZy9JWXkv?=
 =?utf-8?B?NW1RVUtIL0hSMmsyRU1zOHRMaFN0Sjd2ZFRuR0ZZbjEyeUJkU1FUT3llVGlV?=
 =?utf-8?B?Zit1Q09aZ2VKWWRwMjJWVlU1MGNwMkVoNExDUmNTSXFZOFhZNWNuRWJZU3lo?=
 =?utf-8?B?L3BFMXV2dDdUKzQxNTBnOC9DMVlLVk1IMG1zd0UyMWgycEovcEo0V1k5V1lw?=
 =?utf-8?B?SDcwa3d1QlIySnJ2WXVqZUxlWitsZ1JPYzBpVTlabG8zcTREaVU2dFZjTzda?=
 =?utf-8?B?MHFPZUlkOGNZbWtjNWlrSzI5ck90eTFXN281REFrRHFNbzRZUmpUQ0pMd1Bu?=
 =?utf-8?B?MFRTdlBkdVdHWWdhWnYzMTRLczZ3OUJnVllreFpVNUExalpPbEgxOERKYkFI?=
 =?utf-8?Q?2II8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e52e88-1074-403a-d2a4-08dd478733a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:53:37.0706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdFUeiQO2koPm61xjcS0YrrsQHSYaIEaxGxkawXrw8EgEEftyPktAfRz4MCFxrd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-02-07 05:17, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com">Am
      30.01.25 um 17:19 schrieb Philip Yang:
      <br>
      <blockquote type="cite">On 2025-01-29 11:40, Christian König
        wrote:
        <br>
        <blockquote type="cite">Am 23.01.25 um 21:39 schrieb Philip
          Yang:
          <br>
          <blockquote type="cite">SVM migration unmap pages from GPU and
            then update mapping to GPU to
            <br>
            recover page fault. Currently unmap clears the PDE entry for
            range
            <br>
            length &gt;= huge page and may free PTB bo. Then update
            mapping should
            <br>
            alloc new PT bo, but there is race bug that the freed entry
            bo maybe
            <br>
            still on the pt_free list, reused when updating mapping and
            then freed,
            <br>
            leave invalid PDE entry and cause GPU page fault.
            <br>
            <br>
            By setting the update fragment size to 2MB or 1GB, update
            will clear
            <br>
            only one PDE entry or clear PTB, to avoid unmap to free PTE
            bo. This
            <br>
            fixes the race bug and also improve the unmap and map to GPU
            <br>
            performance. Update mapping to huge page will still free the
            PTB bo.
            <br>
            <br>
            With this change, the vm-&gt;pt_freed list and work is not
            needed. Add
            <br>
            WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap
            to free the
            <br>
            PTB.
            <br>
            <br>
            v2: Limit update fragment size, not hack entry_end
            (Christian)
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 --
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 --
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54
            +++++++++--------------
            <br>
            &nbsp; 3 files changed, 21 insertions(+), 41 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index c9c48b782ec1..48b2c0b3b315 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;vm-&gt;status_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;freed);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;done);
            <br>
            -&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;vm-&gt;pt_free_work,
            amdgpu_vm_pt_free_work);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_init_entities(adev, vm);
            <br>
            @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct
            amdgpu_device *adev, struct amdgpu_vm *vm)
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; flush_work(&amp;vm-&gt;pt_free_work);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(vm-&gt;task_info);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index 5d119ac26c4f..160889e5e64d 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -369,10 +369,6 @@ struct amdgpu_vm {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BOs which are invalidated, has been updated in the
            PTs */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; /* PT BOs scheduled to free and fill with zero if
            vm_resv is not hold */
            <br>
            -&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp; pt_freed;
            <br>
            -&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp; pt_free_work;
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* contains the page directory */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base&nbsp;&nbsp;&nbsp;&nbsp; root;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *last_update;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            index f78a0434a48f..063d0e0a9f29 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct
            amdgpu_vm_bo_base *entry)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;entry-&gt;bo);
            <br>
            &nbsp; }
            <br>
            &nbsp; -void amdgpu_vm_pt_free_work(struct work_struct *work)
            <br>
            -{
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
            <br>
            -&nbsp;&nbsp;&nbsp; LIST_HEAD(pt_freed);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; vm = container_of(work, struct amdgpu_vm,
            pt_free_work);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo
            is valid. */
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo, true);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next, &amp;pt_freed,
            vm_status)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
            <br>
            -}
            <br>
            -
            <br>
            &nbsp; /**
            <br>
            &nbsp;&nbsp; * amdgpu_vm_pt_free_list - free PD/PT levels
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
            <br>
            -&nbsp;&nbsp;&nbsp; bool unlocked = params-&gt;unlocked;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;params-&gt;tlb_flush_waitlist))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; if (unlocked) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_splice_init(&amp;params-&gt;tlb_flush_waitlist,
            &amp;vm-&gt;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next,
            &amp;params-&gt;tlb_flush_waitlist, vm_status)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            &nbsp; }
            <br>
            @@ -611,6 +579,11 @@ static void
            amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor seek;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry;
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * unlocked unmap only clear page table leaves, warning
            to free the page table entry.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; WARN_ON(params-&gt;unlocked);
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;params-&gt;vm-&gt;status_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(params-&gt;adev,
            params-&gt;vm, cursor, seek, entry) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry &amp;&amp; entry-&gt;bo)
            <br>
            @@ -794,6 +767,21 @@ static void
            amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This intentionally wraps around if no bit is set
            */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = min_t(unsigned int, ffs(start) - 1, fls64(end
            - start) - 1);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * MMU notifier callback unlocked unmap only clear PDE
            or PTE leaves by setting fragment
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * size to 2MB, 1GB, 512GB. If leave is PDE entry, only
            clear one entry, next fragment entry
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * will search again for PDE or PTE leaves.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; if (params-&gt;unlocked) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*frag &gt; 9 &amp;&amp; *frag &lt; 18)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 9;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*frag &gt; 18 &amp;&amp; *frag &lt; 27)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 18;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*frag &gt; 27)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 27;
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
          </blockquote>
          <br>
          That here looks unnecessary, the higher level handling is able
          to pick the right PD/PT level based on the fragment anyway.
          <br>
        </blockquote>
        <br>
        Thanks for the review, it is very hard to image this case,
        update PDE0 entries, then free PTB bos, as this works fine for
        locked mapping.
        <br>
        <br>
      </blockquote>
      <br>
      Yeah, I also need up to an hour to swap that logic back into my
      head every time I need to take a look at it. Understanding the VM
      stuff in both HW and SW is really not easy.
      <br>
      <br>
      <blockquote type="cite">For unlocked unmapping,&nbsp; after updating
        multiple PDE0 entries, it is incorrect to free PTB bo if there
        is non-huge page mapping,
        <br>
        <br>
        <br>
        For example, below is debug log to unmap d4000 to d4806, address
        d4000, d4200 huge page mapping, d4400 not huge page mapping.
        <br>
        <br>
        If using fragment 11, it trigger the bug. No issue if we limit
        the fragment to 9
        <br>
        <br>
      </blockquote>
      <br>
      Ah! Ok, I see what you try to solve here.
      <br>
      <br>
      In that case we should probably indeed use a separate function.
      Since using the level to determine where to update stuff is then
      fundamentally wrong.
      <br>
    </blockquote>
    <p>yes, fragment size is not needed for unmap, we could optimize the
      unmap using a separate function for both unlocked unmapping and
      locked unmapping case, for example 7 pages unmap with address
      aligned to 4 pages, currently we unmap 4 pages, 2 pages, then 1
      page, instead we could unmap 7 pages together. But this cannot
      solve this race condition issue, with unlocked mapping we still
      need only update leaves.<br>
    </p>
    <p>I think same function for map and unmap is easy to maintain and
      understand as unmap is just map update with zero PTE.</p>
    <blockquote type="cite" cite="mid:328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com">
      <br>
      In other words even if your round down the fragment size to a
      multiple of 9 you can still run into issues when the range which
      is unmapped is larger than 1GiB.
      <br>
      <br>
      E.g. you then have frag=18, but would eventually need frag=9 to
      not start freeing the 2MiB page tables.
      <br>
    </blockquote>
    <p>rescan page table after each fragment handling can get correct
      frag with correct PDE leave or PTB leave, for example, unmap 4GB
      range, address aligned to 1GB, with first 1GB physical contiguous
      mapping on PDE1, then 4KB pages on PTE, first we get frag=18 (not
      frag=20 for 4GB), then the unmap steps:</p>
    <p>a. level 1, shift 18, frag 18, update one entry on PDE1</p>
    <p>b. rescan and amdgpu_vm_pt_descendant will stop with level 3,
      shift 0, PTE (frag is still 18, but not used)<br>
    </p>
    <p>c. entry_end is 2MB, clean 512 entries on PTE,</p>
    <p>d, next frag is updated to 9, and go to step b to rescan, found
      PDE0 entry if huge page 2MB mapping, or PTE for 4KB mapping</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        [&nbsp; 192.084456] amdgpu: 4 cursor pfn 0x7f87d4000 level 3 shift 0
        frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
        <br>
        <br>
        move cursor up to walk parent node, as this is huge page
        mapping, no PTB bo
        <br>
        <br>
        [&nbsp; 192.084463] amdgpu: 5 cursor pfn 0x7f87d4000 level 2 shift 9
        frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
        <br>
        <br>
        clean mapping on PDE0, d4000, d4200, d4400, d4600
        <br>
        <br>
        [&nbsp; 192.084480] amdgpu: 7 cursor pfn 0x7f87d4000 level 2 shift 9
        frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
        <br>
        <br>
        Then if (amdgpu_vm_pt_descendant(adev, &amp;cursor)) is true,
        <br>
        <br>
        [&nbsp; 192.084487] amdgpu: 8 cursor pfn 0x7f87d4000 level 3 shift 9
        frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
        <br>
        <br>
        This is fine, no PTB bo
        <br>
        <br>
        [&nbsp; 192.084494] amdgpu: 9 cursor pfn 0x7f87d4200 level 3 shift 9
        frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
        <br>
        <br>
        This is fine, no PTB bo
        <br>
        <br>
        [&nbsp; 192.084501] amdgpu: 9 cursor pfn 0x7f87d4400 level 3 shift 9
        frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
        <br>
        <br>
        PTB bo found, trigger the WARNING in this patch, to free PTB bo.
        <br>
        <br>
        <br>
        [&nbsp; 192.084525] ------------[ cut here ]------------
        <br>
        [&nbsp; 192.084531] WARNING: CPU: 9 PID: 3249 at
        drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:585
        amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
        <br>
        [&nbsp; 192.084854] Modules linked in: nf_tables nfnetlink ast
        drm_shmem_helper k10temp msr fuse ip_tables x_tables amdgpu
        amdxcp drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched
        drm_suballoc_helper video wmi cec drm_buddy drm_display_helper
        drm_kms_helper drm drm_panel_orientation_quirks i2c_piix4
        <br>
        [&nbsp; 192.084987] CPU: 9 UID: 1000 PID: 3249 Comm: kfdtest Tainted:
        G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.12.0-kfd-yangp #146
        <br>
        [&nbsp; 192.084997] Tainted: [W]=WARN
        <br>
        [&nbsp; 192.085004] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00,
        BIOS F12 08/05/2019
        <br>
        [&nbsp; 192.085011] RIP: 0010:amdgpu_vm_ptes_update+0xa2c/0xbd0
        [amdgpu]
        <br>
        [&nbsp; 192.085316] Code: 24 4c 8b 54 24 78 4d 89 f8 48 c7 c7 b0 83
        0a c1 4c 8b 4c 24 50 50 8b 4c 24 10 e8 8f bc b9 d2 48 8b 74 24
        68 5a e9 70 fe ff ff &lt;0f&gt; 0b e9 92 fe ff ff 48 bd 00 00 00
        00 01 00 00 00 ba ff ff ff ff
        <br>
        [&nbsp; 192.085325] RSP: 0018:ffffbed102bf78b8 EFLAGS: 00010202
        <br>
        [&nbsp; 192.085336] RAX: ffff9f04b654a1f8 RBX: 0000000000000009 RCX:
        0000000000000000
        <br>
        [&nbsp; 192.085344] RDX: 0000000000000002 RSI: 00000007f87d4400 RDI:
        ffff9f0af6f9cac8
        <br>
        [&nbsp; 192.085351] RBP: 00000007f87d4806 R08: 0000000000000000 R09:
        c0000000ff7fffff
        <br>
        [&nbsp; 192.085357] R10: 0000000000000001 R11: ffffbed102bf76e0 R12:
        ffff9f046b100000
        <br>
        [&nbsp; 192.085364] R13: 0000000000bf4000 R14: ffffbed102bf79e0 R15:
        00000007f87d4800
        <br>
        [&nbsp; 192.085371] FS:&nbsp; 00007f87d5a515c0(0000)
        GS:ffff9f0af6f80000(0000) knlGS:0000000000000000
        <br>
        [&nbsp; 192.085379] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        <br>
        [&nbsp; 192.085386] CR2: 000055a190964b78 CR3: 0000000163fca000 CR4:
        00000000003506f0
        <br>
        [&nbsp; 192.085393] Call Trace:
        <br>
        [&nbsp; 192.085400]&nbsp; &lt;TASK&gt;
        <br>
        [&nbsp; 192.085408]&nbsp; ? __warn+0x90/0x190
        <br>
        [&nbsp; 192.085422]&nbsp; ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
        <br>
        [&nbsp; 192.085832]&nbsp; ? report_bug+0xfc/0x1e0
        <br>
        [&nbsp; 192.085849]&nbsp; ? handle_bug+0x55/0x90
        <br>
        [&nbsp; 192.085860]&nbsp; ? exc_invalid_op+0x17/0x70
        <br>
        [&nbsp; 192.085871]&nbsp; ? asm_exc_invalid_op+0x1a/0x20
        <br>
        [&nbsp; 192.085892]&nbsp; ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
        <br>
        [&nbsp; 192.086199]&nbsp; ? srso_return_thunk+0x5/0x5f
        <br>
        [&nbsp; 192.086216]&nbsp; amdgpu_vm_update_range+0x242/0x850 [amdgpu]
        <br>
        [&nbsp; 192.086537]&nbsp; svm_range_unmap_from_gpus+0x117/0x300 [amdgpu]
        <br>
        [&nbsp; 192.086906]&nbsp; svm_range_cpu_invalidate_pagetables+0x426/0x7a0
        [amdgpu]
        <br>
        [&nbsp; 192.087259]&nbsp; ? lock_release+0xc8/0x290
        <br>
        [&nbsp; 192.087276] __mmu_notifier_invalidate_range_start+0x233/0x2a0
        <br>
        [&nbsp; 192.087292]&nbsp; migrate_vma_setup+0x1a3/0x250
        <br>
        [&nbsp; 192.087307]&nbsp; svm_migrate_ram_to_vram+0x260/0x710 [amdgpu]
        <br>
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Apart from that the patch looks good to me.
          <br>
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = max_frag;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = end &amp; ~((1ULL &lt;&lt; max_frag) -
            1);
            <br>
            @@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next fragment */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start,
            end,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag,
            &amp;frag_end);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift || (params-&gt;unlocked
            &amp;&amp; shift))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (frag_start &lt; entry_end);
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
