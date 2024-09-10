Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B8FEDE99A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 15:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439D110E7B8;
	Tue, 10 Sep 2024 15:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28xzWheg";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3255510E7B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 15:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMLL+Y5B+Qp9krh4onz3wFeQUqD5yHJ6zan/5/1G2VZfPKJOIkh+sYiJTmLh8pm821IflNiaJb4C6UZHWVccmbyDaJ6gqOqZf1hX826I27CKyK+oaGP22BJCKJbx9JPulMNC9Fq413CvGHCpS4E15WOfaYICSbHa57ziUlMhw7z12D9kmcUnFfdR/vaD5v05Ol4w0ac/CnpD+w3JxCZZmUEWtHwQk3e+BaS70jRtLjrWEq1n8h91nG6+1sZvdfGIS/YqTcFLV9+tWTC+nAt+0Msh8MKVL9rfVj1hHSTqTbJFhvorHCIdp7iV0hh0tvZZLSlKnS3xw3hToC06C67z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lm2NQbW945rTVO+KKWWURLZP4eNZbQ+S1OUfO9QBgU=;
 b=P6w+qIAMJY4S4g1G2tKal0WlPxUa64LT8jRSzUEbQpbA4f1pnGofunDqO+zfKph7zq+Mjzk3hT6PyqQ7l/xfse5YSeKI+jkV+eb6QED7Lvl9Dw5VvUEJAyQMxVHl9O+ShlpeFoW9P2jXAy9DCyXoWHHQyzwkjMxiIj8f41LWfKrgpijhoqC4vFEVbrtFq63nIrysaunjGGd5EQ8HtSGHAakPdEq3Nnq39bBmPXtDdf82zjtcNvL5t8mXxQ7ImnxW3QvJUN6WH9plCv5dadocuMnPi/Jo82THXT6t586EmcBK48C+3eGZAIQzhc+XxmGMT5s2F3rtUAJD74DPQbfEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lm2NQbW945rTVO+KKWWURLZP4eNZbQ+S1OUfO9QBgU=;
 b=28xzWhegtQhNqsNEyIlv1osvmDId8fa51ryf94F1jKpgcln5c29xbnAdm2gJ4Kd5d0VM4EuuoYM7i2+KzFFzNNO+5pZ2TRwZU6asJTwbXICBx6k5lPGHqBbMkTtBbKOdn5Gx8TtHh4NZMzKU4mxJc6wphvjis3OUR5j6sgicwC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 15:23:38 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:23:38 +0000
Message-ID: <ca0aa805-afca-1758-cf6f-718111f87cd6@amd.com>
Date: Tue, 10 Sep 2024 11:23:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20240819175935.4014241-1-Jonathan.Kim@amd.com>
 <0de27442-9271-44ad-9e99-0c719836bad8@gmail.com>
 <CY8PR12MB7435D74AA7571BCFF433369F85992@CY8PR12MB7435.namprd12.prod.outlook.com>
 <5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ed7015-7630-42b9-02b6-08dcd1ac8b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aktLclAvblZ6TWxyT0VOYjZqbWU1bUJFb1dlRjRQU1NFMWRzZHdKYXhDR0V3?=
 =?utf-8?B?K2tlUEV4Z1VBUjRBLzMxS3JHUU1xMHFmL1FhY3dvSmRMVUszSkFwMlJoU2xF?=
 =?utf-8?B?VW5nUGlNY0FTS2lpbVBGNHE1enlwYUtQamlmeUNIa0EyRHRkUjhXU2wyR1hS?=
 =?utf-8?B?Sm9tVWd4eEE1cUw0T1BNMmFIVE9RcE9WblJOYk0zSnJyOURrbGhHZmpNNlFT?=
 =?utf-8?B?ZkdEdzM5bm5PRStQWDZkQkhGYU9xaHpKcWpiZnhjZ3RuK25vNnQvaVVyYTMr?=
 =?utf-8?B?U2hhb1hyVVR1OXQrUUxQSnJiZUxlWG50Ym9wK0RudmVvUXJ1TlVJdmdheTY1?=
 =?utf-8?B?U0F2Y3kxbVpMZnVmZ01SMmEwRHRmelkrOUJLZDJ1bHdPaC9VbHZEMkMzQ21i?=
 =?utf-8?B?eFQyWXJwT2JNeFQxdm9yR0J1Z2h2QnlOclp0eEdOREV3RkNJa0xzS1lXRmxE?=
 =?utf-8?B?bE4zYkpTbXBXK0NnMW9jalZLd0g3ODJodjBDamRVV0ZDZWVIb2JKUzFobEF4?=
 =?utf-8?B?RlgxUVBwS3Jzd2tRYTUwc2RNMzR3aFVuWW9OZ3hrcm4zbnFORUxGVmtTcXli?=
 =?utf-8?B?YlpTOVdMd3h6emRPa3l2aEdMZkM3dnF5S2NlT2lRM05hK3crMDBiOU1wRHhE?=
 =?utf-8?B?V3VydnJkQUxUZU5rcy9PK0VUY2dkRWdmNzYrVDQrS2dMTVkxSlpISWRwTFBH?=
 =?utf-8?B?V2htUXdBSEpKc1hZMUl2SFJ4OW5mWE0vOFp6RC9kUzd2dndXUGpKNjExa3hw?=
 =?utf-8?B?SnIrbTBGUlNkNFc2RklTTlVsbys4UFY5RlBIQzROdUJvWkRUQmd5YllrNnJh?=
 =?utf-8?B?MDgybk1HOC9ENkxZaTB2aTUyMUpqS1Q0c3Z4dE00RXMxT0xTa0dRRU81TVBF?=
 =?utf-8?B?c0FGSGo4WjdJY1pCcjZRMmFLN05FRjRJR2RiSmZUTmZ5ek94am1lMi9lSUZW?=
 =?utf-8?B?TlcyekxwZ0l1WFRLZEMxeGwxZWtoSVU2bWV1d1NOR2tJdjF1bXc0ekhEOHRs?=
 =?utf-8?B?NUI3a0lmd0FXWDIyc0xFeW1QRk9TYmZUQVZ3WEF1N0wzQnozWWlwK0lEekdo?=
 =?utf-8?B?VkFLeTRjTlhTZjNxS1JHUEMvRlVpaVdSY0tGc1JzUHhoeTJJZW1tSGlhMG1P?=
 =?utf-8?B?RU8rK2dVVlJ4cU1KUWI1V0NkZm1EcWhpVVhmUVAzTk5RVE5DZDJRTnlEVzQ3?=
 =?utf-8?B?TzN0UUNjOEpTbEI3eGo4VkNtbGtzTFMxS04vOUlvQVNXcjFhYTMrU2RRUnJC?=
 =?utf-8?B?WmtwRkdKV1hpbXkyRFpkaGozUGc2QTRiWlZ0Ry9Fakt5cXBFYlRUR0Q0V29D?=
 =?utf-8?B?ZDR5bkhyQStRbVM0UHZiNjgxK0JjRnprQ2dnUzN4NVIyRWprVVRmY0VjTGxk?=
 =?utf-8?B?d05SRktXVWZ6ejVWTWQ4U3JTU0dJV3F5ajIvOGZWZkRMM05QdzVKNGhBOHl0?=
 =?utf-8?B?Tm5ISE9xYWJLcmhwcG1QTjBWOTVzcVAzbGhqNHduK29tQWNHT0kySVFxV1U5?=
 =?utf-8?B?dGllZDNwQ09lVFMzcDhzS2VrL3gvbEpCTm1zN3E0MGltSTd0ZkpFUWRHOGdM?=
 =?utf-8?B?TE9tYUw1Ui9HUm4zd1RtYm44dWs4UmVrM040UTY4UzBMRW1URzl3YzZaTlM0?=
 =?utf-8?B?U0dqU2RuRjdNalR0SFVqcnM2RnZPYWhsT0hZTlRHUkRsQ2xaZnc4cWJYK2Zn?=
 =?utf-8?B?TXhCZVFKSUYxeklWMlErY1NkYmt4QnIzWGUzbXQxSTJEbGZod3hnZjBZNkF3?=
 =?utf-8?B?TUZJZUZwL0M1aHNzMzlGSDdPakRsYUg0cVhrbkdabVVleXdRUHhsOHUwRVRp?=
 =?utf-8?B?SVFYV0ZzdzFObUNtU084Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3EyMEZDQnI5aFBUamNRMFlOT2RGYncvQ0pJT3pMNEZCaXMvVmhBTmNGK2hl?=
 =?utf-8?B?WTFIS3BtWENDUlhvWTZTUmhvVk12cmtodjlieU55N1BpT1JOYVp5Q3VteUJQ?=
 =?utf-8?B?dk5nQm9TMjViVWV2L243cGN0blNleWpkaG9neDY3WU1SeVgvTDRKTHJoaU9T?=
 =?utf-8?B?dkU3bHhLVUpFTzAzWmM1bk1SWVZSNnEybkUvV0hyRVgrS2ppOHFRS2p4cXdj?=
 =?utf-8?B?UUlMMjZ6MSt3RE9Sb3Q5Y21Sdm9GU2lHZDA4eVNNanBLK1E2WVZYNDBBQlpl?=
 =?utf-8?B?MGpaVmVvZ1JaVVlxQ0tjdE14ZjFyVHEraHZURHhzaENZbEJYMTB1bmdNWVpO?=
 =?utf-8?B?SjlMZG44OUNiLzJUYmVIaUx0d2F6ZDU3SnJkUlFaZmMweVBrb0lBU2lNOGl3?=
 =?utf-8?B?SjNkM0wvbFNvZkVIOXRkSWN1Nnl4bEtIbmp6TmVYVTNLNkh3Z2hTVUJkK2xX?=
 =?utf-8?B?Tjl3YnhCSlNZWnRjZlExR3h5RzZZQVVEUmVVek5SL1R1VWpQbGlvSzNnNGJp?=
 =?utf-8?B?YkNEZDJtdElMdkRMd1NzcDBtTng0anRJbitIZGtWWHVpcHNRYlZTNWRIWExM?=
 =?utf-8?B?dEpLaEpFMzQwWUVmSTE4TlY3WnVYWmpucVdmbXo4VjVNNTJSVDR5d0xRTzBw?=
 =?utf-8?B?ejZJeDR1TjVIUFNXSWRIakgvbkdPa2pteU84WTZBZkJYNlBTZkhIQlhoSmF1?=
 =?utf-8?B?a1QvckJQL2hnOTJqZ2VUWVNLSGN5aWVBTUJIZThHN1VKcmpRZy9uQ2tsZ056?=
 =?utf-8?B?bGd1OCsvWmx4M0doOWphQ043Z1dlVmswbWFOTUpVYWVNMG1hTWNxMjBXc2o2?=
 =?utf-8?B?NUYzMmQ1QXZEV2ZHRUl0bnNSU3pFS3E0WUtNcFpnTlZ6V0dDYmY1TFJ5N3ZQ?=
 =?utf-8?B?ZEVsWDcyL0YyY3ZISVlLM2RiUkFPZmhBRzlIc2dOMDhSOXUvWUVQUEtFSFVI?=
 =?utf-8?B?eTlYYnlCWTlHVy9oZkFFMThuci9ObmlWemVYTEhmWWZ4RFAvcXBJZldER3hW?=
 =?utf-8?B?WmNjTkc1MUtjanR1K0RjSzladE1UUEtCS3V0a3Y4SnlRaGkyTzdCMS84TENv?=
 =?utf-8?B?OVNkenBnY0pobWJKbU1hKzFmdVNhY0ZKS21zVS9HR0I5N0RSaVBmb2hUR3hM?=
 =?utf-8?B?QnlIZjQ0Tzk2UzZLKzF4ZDdTb045azBaa0Z3WCsyTkZRYXhIWXZhSjRPV29z?=
 =?utf-8?B?bFVrSCtabTk2UmFIWGw4UUJqeDVybWhZL2lXdHRVU0tWZVhEUEg5T2dBU0d0?=
 =?utf-8?B?bU40L1BLbUx4Nm0zUWI2aFBZTlgyY2N1YjFnajVGWEZWZkM4RFhvWWNqckx4?=
 =?utf-8?B?WjZrTkQ0Rzk5WkE5NHpuYk0vTnNkRTVwdnNaS2RzUTNJNnI0bk42YlZwMW9K?=
 =?utf-8?B?TDVtTW04M0J1OHhJN013c2lXSDRQYm45eWJ2UkNUYmJBbmtXRUFOKzVwM3p5?=
 =?utf-8?B?c2dsRlRsV3l3UVB0b1krMzNQTlEwUXNCeU5TZ2hnMzN4SGdaRklwNU9ENXJY?=
 =?utf-8?B?cDdrWk9tbmtnK3JVTE80dnF6dnRkRFNDQThzTHJaWThqSDBRZlpGbkgrOE05?=
 =?utf-8?B?TXVqZUNoSzVtQ0EwcG1DQURMN0JjeXhRZURuTWxOSksrd1Y1L09YaTJVcDZQ?=
 =?utf-8?B?a0lVWjNhNFdPMEtiWkZQNVBScTNqckFEWlZmY3pSY0wwYWsreVBXYWhWdVlJ?=
 =?utf-8?B?b1NwL0RhbnBnclZRVnAwSzl6dWYrL3BoQmNrdmhZejMzb3dhOEE4SWhqQTFM?=
 =?utf-8?B?aXQ3WVVzR1VHQXpPV3B0NnMzdllQUjl5MFRpMmx1V3NzekFIMk14bE5vbEla?=
 =?utf-8?B?YUswWUNJdVZDYnM5TEwrcE4ybU9Kc1czbzBoUjluODl6OTFIRjdrQ2tBaXVS?=
 =?utf-8?B?VmcrZVlzRGQ4Vy9paW83Sk8xelN4ZWFnMGxsSEs3RCtER3R2K0k0OXdTUmlZ?=
 =?utf-8?B?VjlyVTNnSUlxbnVSL3IxV21RbE9QaC9NSVRmdzY5QjViVThCQnc1K0ViUU8v?=
 =?utf-8?B?dE1VamhZQWJPeUpIS3M2R2dmZFJVYUVGUmUyR0hEZ0VxMHF6NjB2UERhQUQ2?=
 =?utf-8?B?M25GUjZUMjdRNzFaUXljYWhNc090ZzVodFBhMnA4WjkxVjdNMjdWSzMwOTdy?=
 =?utf-8?Q?rNrI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed7015-7630-42b9-02b6-08dcd1ac8b53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:23:38.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1OZB6FQSM1O/V5rkZd0huBZDQrJd5y+IG9x97munR8+pw7djGKiqUj76QhfyMdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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
    <div class="moz-cite-prefix">On 2024-09-09 14:46, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com">Am
      09.09.24 um 18:02 schrieb Kim, Jonathan:
      <br>
      <blockquote type="cite">[Public]
        <br>
        <br>
        <blockquote type="cite">-----Original Message-----
          <br>
          From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
          <br>
          Sent: Thursday, September 5, 2024 10:24 AM
          <br>
          To: Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <br>
          Cc: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Deucher,
          Alexander
          <br>
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Joshi, Mukul
          <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
          <br>
          Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for
          multiple partitions
          <br>
          <br>
          Caution: This message originated from an External Source. Use
          proper caution
          <br>
          when opening attachments, clicking links, or responding.
          <br>
          <br>
          <br>
          Am 19.08.24 um 19:59 schrieb Jonathan Kim:
          <br>
          <blockquote type="cite">Currently multiple partitions will
            incorrectly overwrite the VM lookup
            <br>
            table since the table is indexed by PASID and multiple
            partitions can
            <br>
            register different VM objects on the same PASID.
            <br>
          </blockquote>
          That's a rather bad idea. Why do we have the same PASID for
          different VM
          <br>
          objects in the first place?
          <br>
        </blockquote>
        Alex can probably elaborate on the KGD side, but from what I can
        see, the KMS driver open call has always assigned a new VM
        object per PASID on an open call.
        <br>
        The KFD acquires and replaces the KGD PASID-VMID registration on
        its own compute process open/creation call.
        <br>
        If this is the bad_idea you're referring to, then someone else
        will have to chime in.&nbsp; I don't have much history on this
        unfortunately.
        <br>
      </blockquote>
      <br>
      Yeah, Felix and I designed that.
      <br>
    </blockquote>
    <p>app opens drm node to create vm for each partition, with
      different vm-&gt;pasid for each vm, issue is from
      kfd_ioctl_acquire_vm -&gt; kfd_process_device_init_vm -&gt;&nbsp;
      amdgpu_amdkfd_gpuvm_set_vm_pasid, to replace all vm-&gt;pasid with
      kfd process-&gt;pasid, which is from open kfd node. This ends up
      to store only one vm to adev-&gt;vm_manager.pasids with KFD
      process pasid, so we cannot retrieve correct vm from
      adev-&gt;vm_manager.pasids on mGPUs or multiple partitions.<br>
    </p>
    <blockquote type="cite" cite="mid:5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com">
      <br>
      <blockquote type="cite">That aside, the current problem is, is
        that all KFD device structures are logical partitions and
        register their PASID-VM binding using this concept of a device.
        <br>
      </blockquote>
      <br>
      As far as I can see that is the fundamental problem. This needs to
      be fixed instead.
      <br>
      <br>
      <blockquote type="cite">On the KGD side however, the registration
        table is maintained in the adev struct, which is a physical
        socket.
        <br>
        So there's a mismatch in understanding of what a device is
        between the KFD &amp; KGD with regard to the look up table that
        results in bad bindings.
        <br>
        <br>
        Adding a per-partition dimension to the existing lookup table
        resolves issues where seeing, for example, with memory violation
        interception and XNACK i.e bad bindings result in wrong vm
        object found to set no-retry flags on memory violations.
        <br>
      </blockquote>
    </blockquote>
    <p>svm_range_restore_pages retry fault recover uses fault pasid to
      get kfd process, and use the fault node_id to get pdd-&gt;vm,
      maybe you can use this way to fix the debugger issue.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com">
      <br>
      Yeah that is pretty much a no-go.
      <br>
      <br>
      The PASID and how it is used is defined by the PCIe
      specifications. If we now start to assign multiple VMs to the same
      PASID then we are violating the PCIe specification.
      <br>
      <br>
      The problems you see are most likely just the tip of the iceberg
      here.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Jon
        <br>
        <br>
        <blockquote type="cite">Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">This results in loading the wrong VM
            object on PASID query.
            <br>
            <br>
            To correct this, setup the lookup table to be
            per-partition-per-PASID
            <br>
            instead.
            <br>
            <br>
            Signed-off-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp; | 12 ++++
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 55
            +++++++++++------
            <br>
          </blockquote>
          --
          <br>
          <blockquote type="cite">&nbsp;&nbsp;
            drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 +++-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 ++----
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-
            <br>
            &nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c&nbsp; |&nbsp; 8 +--
            <br>
            &nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp; |&nbsp; 8 +--
            <br>
            &nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c&nbsp;&nbsp; |&nbsp; 3 +-
            <br>
            &nbsp;&nbsp; 18 files changed, 92 insertions(+), 65 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
          <br>
          <blockquote type="cite">index c272461d70a9..28db789610e1
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
            <br>
            @@ -887,3 +887,15 @@ int amdgpu_amdkfd_unmap_hiq(struct
            <br>
          </blockquote>
          amdgpu_device *adev, u32 doorbell_off,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp; }
            <br>
            +
            <br>
            +int amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device
            *adev,
            <br>
          </blockquote>
          uint32_t node_id)
          <br>
          <blockquote type="cite">+{
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id =
            adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(adev,
            node_id);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcc_id &gt;= 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xcc_id;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          <br>
          <blockquote type="cite">index 4ed49265c764..bf8bb45d8ab6
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
            <br>
            @@ -356,6 +356,7 @@ void
            amdgpu_amdkfd_unreserve_mem_limit(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32
            alloc_flag, int8_t xcp_id);
            <br>
            <br>
            &nbsp;&nbsp; u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device
            *adev, int
            <br>
          </blockquote>
          xcp_id);
          <br>
          <blockquote type="cite">+int
            amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device *adev,
            <br>
          </blockquote>
          uint32_t node_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp; #define KFD_XCP_MEM_ID(adev,
            xcp_id) \
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;xcp_mgr &amp;&amp; (xcp_id) &gt;=
            0 ?\
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          <br>
          <blockquote type="cite">index c6a1783fc9ef..bf9f8802e18d
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
            <br>
            @@ -37,7 +37,7 @@ static enum drm_gpu_sched_stat
            <br>
          </blockquote>
          amdgpu_job_timedout(struct drm_sched_job *s_job)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job =
            to_amdgpu_job(s_job);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *ti;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = ring-&gt;adev;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; int idx;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; int idx, xcp_id = !job-&gt;vm ? 0 :
            job-&gt;vm-&gt;xcp_id;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
            <br>
            @@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat
            <br>
          </blockquote>
          amdgpu_job_timedout(struct drm_sched_job *s_job)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            job-&gt;base.sched-&gt;name,
            atomic_read(&amp;ring-&gt;fence_drv.last_seq),
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.sync_seq);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; ti = amdgpu_vm_get_task_info_pasid(ring-&gt;adev,
            job-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; ti = amdgpu_vm_get_task_info_pasid(ring-&gt;adev,
            job-&gt;pasid, xcp_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ti) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Process information: process %s pid
            %d thread %s pid %d\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
          <br>
          <blockquote type="cite">index d9fde38f6ee2..e413bf4a3e84
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
            <br>
            @@ -1275,17 +1275,20 @@ int amdgpu_info_ioctl(struct
            drm_device *dev,
            <br>
          </blockquote>
          void *data, struct drm_file *filp)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm =
            &amp;fpriv-&gt;vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_gpuvm_fault
            gpuvm_fault;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;gpuvm_fault, 0,
            sizeof(gpuvm_fault));
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids, flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
            adev-&gt;xcp_mgr-&gt;num_xcps; i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[i], flags);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.addr = vm-&gt;fault_info.addr;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.status =
            vm-&gt;fault_info.status;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuvm_fault.vmhub = vm-&gt;fault_info.vmhub;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
            adev-&gt;xcp_mgr-&gt;num_xcps; i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[i],
            flags);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;gpuvm_fault,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t)size,
            sizeof(gpuvm_fault))) ? -EFAULT : 0;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          <br>
          <blockquote type="cite">index bcb729094521..f43e1c15f423
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -146,7 +146,7 @@ int amdgpu_vm_set_pasid(struct
            amdgpu_device
            <br>
          </blockquote>
          *adev, struct amdgpu_vm *vm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            xa_err(xa_erase_irq(&amp;adev-&gt;vm_manager.pasids,
            vm-&gt;pasid));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            xa_err(xa_erase_irq(&amp;adev-&gt;vm_manager.pasids[vm-&gt;xcp_id],
            <br>
          </blockquote>
          vm-&gt;pasid));
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            <br>
            @@ -154,7 +154,7 @@ int amdgpu_vm_set_pasid(struct
            amdgpu_device
            <br>
          </blockquote>
          *adev, struct amdgpu_vm *vm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            xa_err(xa_store_irq(&amp;adev-&gt;vm_manager.pasids, pasid,
            vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            xa_err(xa_store_irq(&amp;adev-&gt;vm_manager.pasids[vm-&gt;xcp_id],
            <br>
          </blockquote>
          pasid, vm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            GFP_KERNEL));
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            @@ -2288,14 +2288,14 @@ static void
            <br>
          </blockquote>
          amdgpu_vm_destroy_task_info(struct kref *kref)
          <br>
          <blockquote type="cite">&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp; static inline struct amdgpu_vm *
            <br>
            -amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32
            pasid)
            <br>
            +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32
            pasid,
            <br>
          </blockquote>
          u32 xcp_id)
          <br>
          <blockquote type="cite">&nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            flags);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vm;
            <br>
            &nbsp;&nbsp; }
            <br>
            @@ -2343,10 +2343,10 @@ amdgpu_vm_get_task_info_vm(struct
            <br>
          </blockquote>
          amdgpu_vm *vm)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp; * referenced down with
            amdgpu_vm_put_task_info.
            <br>
            &nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp; struct amdgpu_task_info *
            <br>
            -amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev,
            u32 pasid)
            <br>
            +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev,
            u32 pasid,
            <br>
          </blockquote>
          u32 xcp_id)
          <br>
          <blockquote type="cite">&nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_get_task_info_vm(
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_vm_from_pasid(adev,
            pasid));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_vm_from_pasid(adev,
            pasid, xcp_id));
            <br>
            &nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp; static int amdgpu_vm_create_task_info(struct amdgpu_vm
            *vm)
            <br>
            @@ -2481,6 +2481,8 @@ int amdgpu_vm_init(struct
            amdgpu_device
            <br>
          </blockquote>
          *adev, struct amdgpu_vm *vm,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            amdgpu_bo_unreserve(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;root_bo);
            <br>
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;xcp_id = xcp_id &lt; 0 ? 0 : xcp_id;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            <br>
            &nbsp;&nbsp; error_free_root:
            <br>
            @@ -2695,8 +2697,8 @@ void amdgpu_vm_manager_init(struct
            <br>
          </blockquote>
          amdgpu_device *adev)
          <br>
          <blockquote type="cite">&nbsp;&nbsp; #else
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.vm_update_mode = 0;
            <br>
            &nbsp;&nbsp; #endif
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_init_flags(&amp;adev-&gt;vm_manager.pasids,
            XA_FLAGS_LOCK_IRQ);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; MAX_XCP; i++)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_init_flags(&amp;(adev-&gt;vm_manager.pasids[i]),
            <br>
          </blockquote>
          XA_FLAGS_LOCK_IRQ);
          <br>
          <blockquote type="cite">&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp; /**
            <br>
            @@ -2708,10 +2710,15 @@ void amdgpu_vm_manager_init(struct
            <br>
          </blockquote>
          amdgpu_device *adev)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp; void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
            <br>
            &nbsp;&nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids));
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_destroy(&amp;adev-&gt;vm_manager.pasids);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; int i;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; MAX_XCP; i++) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids[i]));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            xa_destroy(&amp;adev-&gt;vm_manager.pasids[i]);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vmid_mgr_fini(adev);
            <br>
            +
            <br>
            &nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp; /**
            <br>
            @@ -2778,17 +2785,18 @@ bool amdgpu_vm_handle_fault(struct
            <br>
          </blockquote>
          amdgpu_device *adev, u32 pasid,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long irqflags;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value, flags;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; int r, xcp_id;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
            irqflags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; xcp_id = amdgpu_amdkfd_node_id_to_xcc_id(adev,
            node_id)/adev-
            <br>
            gfx.num_xcc_per_xcp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            irqflags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_compute_context =
            vm-&gt;is_compute_context;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = NULL;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
            irqflags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            irqflags);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!root)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
            <br>
            @@ -2806,11 +2814,11 @@ bool amdgpu_vm_handle_fault(struct
            <br>
          </blockquote>
          amdgpu_device *adev, u32 pasid,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unref;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Double check that the VM still exists */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
            irqflags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            irqflags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; vm-&gt;root.bo != root)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm = NULL;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
            irqflags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            irqflags);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vm)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            <br>
            @@ -2968,14 +2976,15 @@ void
            amdgpu_vm_update_fault_cache(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            unsigned int pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vmhub)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vmhub,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id)
            <br>
            &nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            flags);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; vm = xa_load(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Don't update the fault cache if status is 0.&nbsp; In
            the multiple
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fault case, subsequent faults will return a 0
            status which is
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * useless for userspace and replaces the useful
            fault status, so
            <br>
            @@ -3008,7 +3017,7 @@ void
            amdgpu_vm_update_fault_cache(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1,
            &quot;Invalid vmhub %u\n&quot;, vmhub);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;
            xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids[xcp_id],
            flags);
            <br>
            &nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp; /**
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          <blockquote type="cite">index 046949c4b695..1499f5f731e9
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -35,6 +35,7 @@
            <br>
            &nbsp;&nbsp; #include &quot;amdgpu_sync.h&quot;
            <br>
            &nbsp;&nbsp; #include &quot;amdgpu_ring.h&quot;
            <br>
            &nbsp;&nbsp; #include &quot;amdgpu_ids.h&quot;
            <br>
            +#include &quot;amdgpu_xcp.h&quot;
            <br>
            <br>
            &nbsp;&nbsp; struct drm_exec;
            <br>
            <br>
            @@ -418,6 +419,9 @@ struct amdgpu_vm {
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cached fault info */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_fault_info fault_info;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; /* XCP ID */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; int xcp_id;
            <br>
            &nbsp;&nbsp; };
            <br>
            <br>
            &nbsp;&nbsp; struct amdgpu_vm_manager {
            <br>
            @@ -456,7 +460,7 @@ struct amdgpu_vm_manager {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PASID to VM mapping, will be used in interrupt
            context to
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * look up VM of a page fault
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; struct xarray&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasids;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; struct xarray&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            pasids[MAX_XCP];
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Global registration of recent page fault
            information */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_fault_info&nbsp;&nbsp;&nbsp;&nbsp; fault_info;
            <br>
            &nbsp;&nbsp; };
            <br>
            @@ -550,7 +554,7 @@ bool amdgpu_vm_need_pipeline_sync(struct
            <br>
          </blockquote>
          amdgpu_ring *ring,
          <br>
          <blockquote type="cite">&nbsp;&nbsp; void
            amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
            <br>
            <br>
            &nbsp;&nbsp; struct amdgpu_task_info *
            <br>
            -amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev,
            u32 pasid);
            <br>
            +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev,
            u32 pasid,
            <br>
          </blockquote>
          u32 xcp_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp; struct amdgpu_task_info *
            <br>
            &nbsp;&nbsp; amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
            <br>
            @@ -649,7 +653,8 @@ void amdgpu_vm_update_fault_cache(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            unsigned int pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vmhub);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vmhub,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id);
            <br>
            &nbsp;&nbsp; void amdgpu_vm_tlb_fence_create(struct amdgpu_device
            *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          <br>
          <blockquote type="cite">index f0ceab3ce5bf..24b042febf5c
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
            @@ -151,7 +151,8 @@ static int
            gmc_v10_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1, ~1);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
            entry-&gt;pasid, addr, status,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0));
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0),
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!printk_ratelimit())
            <br>
            @@ -161,7 +162,7 @@ static int
            gmc_v10_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[%s] page fault
            (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src ? &quot;mmhub&quot; : &quot;gfxhub&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id, entry-&gt;ring_id,
            entry-&gt;vmid, entry-&gt;pasid);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in process %s pid %d thread %s pid
            %d\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
          <br>
          <blockquote type="cite">index 2797fd84432b..3507046d33e6
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
            <br>
            @@ -122,7 +122,8 @@ static int
            gmc_v11_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1, ~1);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
            entry-&gt;pasid, addr, status,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0));
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0),
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (printk_ratelimit()) {
            <br>
            @@ -132,7 +133,7 @@ static int
            gmc_v11_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[%s] page
            fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src ? &quot;mmhub&quot; :
            &quot;gfxhub&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id, entry-&gt;ring_id,
            entry-&gt;vmid, entry-&gt;pasid);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in process %s pid %d thread
            %s pid %d)\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
          <br>
          <blockquote type="cite">index 60acf676000b..9844564c6c74
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
            <br>
            @@ -115,7 +115,8 @@ static int
            gmc_v12_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1, ~1);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev,
            entry-&gt;pasid, addr, status,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0));
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) :
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0),
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (printk_ratelimit()) {
            <br>
            @@ -125,7 +126,7 @@ static int
            gmc_v12_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[%s] page
            fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src ? &quot;mmhub&quot; :
            &quot;gfxhub&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id, entry-&gt;ring_id,
            entry-&gt;vmid, entry-&gt;pasid);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; in process %s pid %d thread
            %s pid %d)\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
          <br>
          <blockquote type="cite">index 994432fb57ea..2cdb0cbb7c4d
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
            <br>
            @@ -1268,7 +1268,8 @@ static int
            gmc_v7_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev, entry-&gt;pasid,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((u64)addr) &lt;&lt;
            AMDGPU_GPU_PAGE_SHIFT, status,
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0));
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ((u64)addr) &lt;&lt; AMDGPU_GPU_PAGE_SHIFT, status,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFXHUB(0), 0);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fault_stop ==
            AMDGPU_VM_FAULT_STOP_FIRST)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v7_0_set_fault_enable_default(adev,
            false);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
          <br>
          <blockquote type="cite">index 86488c052f82..6855caeb7f74
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
            <br>
            @@ -1437,7 +1437,8 @@ static int
            gmc_v8_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev, entry-&gt;pasid,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((u64)addr) &lt;&lt;
            AMDGPU_GPU_PAGE_SHIFT, status,
            <br>
          </blockquote>
          AMDGPU_GFXHUB(0));
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ((u64)addr) &lt;&lt; AMDGPU_GPU_PAGE_SHIFT, status,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFXHUB(0), 0);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vm_fault_stop ==
            AMDGPU_VM_FAULT_STOP_FIRST)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v8_0_set_fault_enable_default(adev,
            false);
            <br>
            @@ -1448,7 +1449,7 @@ static int
            gmc_v8_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            &quot;GPU fault detected: %d 0x%08x\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id,
            entry-&gt;src_data[0]);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot; for process
            %s pid %d thread %s pid %d\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info-&gt;process_name,
            task_info-&gt;tgid,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
          <br>
          <blockquote type="cite">index b73136d390cc..e183e08b2c02
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
            <br>
            @@ -556,10 +556,12 @@ static int
            gmc_v9_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vmhub;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cam_index = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; int ret, xcc_id = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t node_id;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; int ret;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t node_id, xcc_id, xcp_id;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id = entry-&gt;node_id;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; xcc_id = amdgpu_amdkfd_node_id_to_xcc_id(adev,
            node_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; xcp_id = xcc_id/adev-&gt;gfx.num_xcc_per_xcp;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = (u64)entry-&gt;src_data[0] &lt;&lt; 12;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr |= ((u64)entry-&gt;src_data[1] &amp; 0xf)
            &lt;&lt; 44;
            <br>
            @@ -572,12 +574,6 @@ static int
            gmc_v9_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmhub =
            AMDGPU_MMHUB1(0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_name = &quot;gfxhub0&quot;;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_id =
            adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcc_id &lt; 0)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_id = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmhub = xcc_id;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub = &amp;adev-&gt;vmhub[vmhub];
            <br>
            @@ -631,7 +627,7 @@ static int
            gmc_v9_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retry_fault ? &quot;retry&quot; :
            &quot;no-retry&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id, entry-&gt;ring_id,
            entry-&gt;vmid, entry-&gt;pasid);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid,
            <br>
          </blockquote>
          xcp_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; for process %s pid %d thread %s pid
            %d)\n&quot;,
            <br>
            @@ -675,7 +671,7 @@ static int
            gmc_v9_0_process_interrupt(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1,
            ~1);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_update_fault_cache(adev, entry-&gt;pasid,
            addr, status,
            <br>
          </blockquote>
          vmhub);
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;
            amdgpu_vm_update_fault_cache(adev, entry-&gt;pasid, addr,
            status,
            <br>
          </blockquote>
          vmhub, xcp_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
          <br>
          <blockquote type="cite">index 23ef4eb36b40..1ac4224bbe5b
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
            <br>
            @@ -2182,7 +2182,7 @@ static int
            sdma_v4_0_print_iv_entry(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance,
            addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;pasid);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; for process %s pid %d
            thread %s pid %d\n&quot;,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
          <br>
          <blockquote type="cite">index 57f16c09abfc..c8b5c0302ca7
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
            <br>
            @@ -1683,6 +1683,8 @@ static int
            sdma_v4_4_2_print_iv_entry(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int instance;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *task_info;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcc_id =
            amdgpu_amdkfd_node_id_to_xcc_id(adev, entry-
            <br>
            node_id);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id = xcc_id/adev-&gt;gfx.num_xcc_per_xcp;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance = sdma_v4_4_2_irq_id_to_seq(adev,
            entry-&gt;client_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance &lt; 0 || instance &gt;=
            adev-&gt;sdma.num_instances) {
            <br>
            @@ -1698,7 +1700,7 @@ static int
            sdma_v4_4_2_print_iv_entry(struct
            <br>
          </blockquote>
          amdgpu_device *adev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance,
            addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;pasid);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; task_info = amdgpu_vm_get_task_info_pasid(adev,
            entry-&gt;pasid,
            <br>
          </blockquote>
          xcp_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_ratelimited(adev-&gt;dev, &quot; for
            process %s pid %d thread %s
            <br>
          </blockquote>
          pid %d\n&quot;,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            task_info-&gt;process_name, task_info-&gt;tgid,
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
          <br>
          <blockquote type="cite">index ea3792249209..c098fbaf0e1c
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
            <br>
            @@ -1262,8 +1262,9 @@ void kfd_signal_reset_event(struct
            kfd_node
            <br>
          </blockquote>
          *dev)
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (dev-&gt;dqm-&gt;detect_hang_count) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *ti;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id = dev-&gt;xcp ?
            dev-&gt;xcp-&gt;id : 0;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =
            amdgpu_vm_get_task_info_pasid(dev-&gt;adev, p-&gt;pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ti =
            amdgpu_vm_get_task_info_pasid(dev-&gt;adev, p-&gt;pasid,
            <br>
          </blockquote>
          xcp_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ti) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev-&gt;adev-&gt;dev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Queues reset on
            process %s tid %d thread %s pid %d\n&quot;,
            <br>
            diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
          <br>
          <blockquote type="cite">index 8e0d0356e810..d7cbf9525698
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
            <br>
            @@ -377,12 +377,8 @@ static void
            event_interrupt_wq_v10(struct
            <br>
          </blockquote>
          kfd_node *dev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            kfd_hsa_memory_exception_data exception_data;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxhub */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type &amp;&amp;
            dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
            dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(dev-
            <br>
            adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hub_inst &lt; 0)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
            amdgpu_amdkfd_node_id_to_xcc_id(dev-&gt;adev,
            <br>
          </blockquote>
          node_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mmhub */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid_type &amp;&amp; client_id ==
            SOC15_IH_CLIENTID_VMC)
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
          <br>
          <blockquote type="cite">index a9c3580be8c9..4708b8c811a5
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
            <br>
            @@ -437,12 +437,8 @@ static void
            event_interrupt_wq_v9(struct
            <br>
          </blockquote>
          kfd_node *dev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
            kfd_hsa_memory_exception_data exception_data;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxhub */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type &amp;&amp;
            dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
            dev-&gt;adev-&gt;gfx.funcs-&gt;ih_node_to_logical_xcc(dev-
            <br>
            adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_id);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hub_inst &lt; 0)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst = 0;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vmid_type)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub_inst =
            amdgpu_amdkfd_node_id_to_xcc_id(dev-&gt;adev,
            <br>
          </blockquote>
          node_id);
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mmhub */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid_type &amp;&amp; client_id ==
            SOC15_IH_CLIENTID_VMC)
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
            <br>
          </blockquote>
          b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
          <br>
          <blockquote type="cite">index ea6a8e43bd5b..b5f2f5b1069c
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
            <br>
            @@ -251,8 +251,9 @@ void
            <br>
          </blockquote>
          kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
          <br>
          <blockquote type="cite">&nbsp;&nbsp; void
            kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t
            pasid)
            <br>
            &nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info *task_info;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcp_id = dev-&gt;xcp ? dev-&gt;xcp-&gt;id :
            0;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(dev-&gt;adev, pasid);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; task_info =
            amdgpu_vm_get_task_info_pasid(dev-&gt;adev, pasid, xcp_id);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Report VM faults from user applications,
            not retry from kernel */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info-&gt;pid)
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
