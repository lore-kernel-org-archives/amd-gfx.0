Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3288AD3F2B0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 22:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEDA10E9C7;
	Fri, 18 Oct 2024 22:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yi9AQDw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD75910E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 22:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNVBKPTCIeDxU2kTG7r6HJ5QvoK49ivXSTcdOtJ2VrSnOcMZwbN3c3rhWiv4iFILXz6Erbk+6U3Vh5k71ExcuEE5tGrTqPwSS/gMtwKEb88nAQueNQGdYujhbnYToY8qFngwV27IwSfHZtyUV5RLOhljEPkJG5y5tj7BB+QxPLJ8GW8W3gYdSsxQzhCJ/L8drxy1Jg8+ZQDfQesLK2bUxugSpcjS39yMTY5Q/kQlC8rZHwZGZOv3Fg+smsdJxuYeKy/6PPe2803yDINYHT+3wDSEBj/FuqvwMB7pcEroJxtuMwMffmqFJ+umsLWVbJqDxya2kXWW48bvmQ05wjvE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN1i1ID+mWc5N1UiSfDlpctarrXGPgM39xGsCJaToAo=;
 b=jyObJV1kUqf+Tu33iQ8RkTtO03z9paiXnKwJST+RXrankoqwM0nRcRKQnfHMy/jTeiDM6t7DjHAAPcrAnIt/USGx+Yos6ZE0R74GbvuvSLsZIcpGCIVJx+4g5QO9fFB/kSJkl1qJMggVndGDV4u4FRfAZgqR9PYljEUGQRIp8cfkgIRgAa4ke5qFQlQgBY+xElR2/McmrmbxojOzPXNG2o82ITAtceqYpIOPqulHS/ihyNFePjJZz5c9P20Kf+dbttUTbjb7EeVfOgd2PRBAFG4Nw/d19a4MVGdiQvAZ2/EfB1S7E2tcJMfBnsJDQsRso2izeFaYvUMD68UvQyfA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN1i1ID+mWc5N1UiSfDlpctarrXGPgM39xGsCJaToAo=;
 b=2yi9AQDwWEI4pd9LATOQJneeD0FlvSJpXwqcbcCRU7SCrT+gJaWGRdCLCccggDT7XHSurq46UkiNAUcJiO5eWucuVDJgzYDkAZuZfAWVYSfmFepV88SCYfZQGGgZwXaFxcoT+FhjX6HcEkoUujcHgOYA0EWtVEsn02VU6PCAtFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 22:00:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 22:00:01 +0000
Message-ID: <1f252468-10d0-00a6-3e43-52a3672733a1@amd.com>
Date: Fri, 18 Oct 2024 17:59:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
 <1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f290a95-68d7-44f3-0bfb-08dcefc0367d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWhMY3VKN3VONFRSNy9hMVYxQ09haHM3L1Q5cTBQUTNlL3o1T2tRRmluT2Er?=
 =?utf-8?B?VmZZOUdJdURDSkQzWkdSUUhEODE4SEY5TE04aHNyZWhwQUYzV1lXM0pldGFK?=
 =?utf-8?B?Qi9ycTByWGJYcXg3MVFhTGFld213c0lnVjVObVluM2xQY2pnWDBDcis0azJy?=
 =?utf-8?B?QlJWV3l3NTZZem1NekxuZ2xVUE1FUTQzUU92Q1A3SUFGdHhkYUFndUxBYldv?=
 =?utf-8?B?M0tTcUhscTBPYmV6eFJHKzN5bDV5dlMwaU9VczBNWVloZG5tUHBGUVVhdzlV?=
 =?utf-8?B?YVFMaThiYWFQWkNUc2JxL1BaVFV5dysvU2xDLzZzN2Q1dnJNSG5mWUxSSTBE?=
 =?utf-8?B?YjAvTVB5UHpNNHp4U01na0pWT01obXd6TzF3VERjZFFoUnJzN2I3ZDJOcUVY?=
 =?utf-8?B?Vmt3eC9iMithRUtIOHRSZm1sdkp5ODQ4czFGQkJvK0tEbWNtYXdwNWZHR3Rm?=
 =?utf-8?B?TTFscjV6T1F6U09wSUxROHErNWtob0VWQTRmOHFVYVEvdFJvRk9aZ2ZVM21B?=
 =?utf-8?B?RWRzNlBvbGszZDd4ZnE4VGVuS3M1R3Z4OWtzRlY1bkpIa242K3orV0Z3ZGFs?=
 =?utf-8?B?TEJQZm1hd1NpWGg1MmtlWnhOMThETWlQU1hpbVV4Uk5TWU1wT2hYNWxtanMr?=
 =?utf-8?B?WlBsK1JSc2FwRzhlQ1lCUm1RMURxNDMrUjV2ZUVxMGpDeEViWWRnOEk4djFz?=
 =?utf-8?B?c3NLN09RWkdLYTdjSWZiRFJvaVg5aGxzMWxVazVMUHMxSElwRngzMmF3b3lU?=
 =?utf-8?B?RlBMZUI1TkNyRUR3bWlSNE5YZWNIWXBvdFo4TGcrelErZDd6NytrSE03T0dj?=
 =?utf-8?B?Y0xOZ21FajVDWHZSeW9QcGw0VWRidm5vL2VOUDlXdG91V0g0eXdpaVltc2pF?=
 =?utf-8?B?R0VaZ0E0VEZhYUxNWkg5cnlQZUJxa3Fpb3JCMjI2MDJxckd1Ym4ySmdMd2Vj?=
 =?utf-8?B?aDg0cUpCQnM5b1Z4b1F3akZncTkyY1FmWlNIRmdJamlOZW15UWVudVNjckZr?=
 =?utf-8?B?Zy9mc3JQcXRLOTFNeFVWWnNvWlpjVGxBSzdzM3dWRlBJQlk5dHV2bTBBN1Bn?=
 =?utf-8?B?aDlaT2tlSUpBbTJWbk1JZlVET2Y5cW9oR25jT042dUVjclJFWER3M3EyZy9V?=
 =?utf-8?B?dVZ4K1RUVkRRazIraFB2eUpjS1RDNWJWOFkyMXp0SGttUm1ucmlFKzdiL3I2?=
 =?utf-8?B?dm5tQ1FCbHZHUXU0VnFsV1Q1dmEyQUtld2lxNWhOMXpEa1czNzFlZ2c3S2pE?=
 =?utf-8?B?Ri9VV2J0T2FuNVhLZCs3NGVVbEYvelZKQndaN2FBWUs1bktsRmhEOEMyYXNH?=
 =?utf-8?B?dFVocTF6clVJSDZHWkpkL3F5TllJV21Sa05CbEdCakx1VitRRUlibmViaVRo?=
 =?utf-8?B?RzdCQXlPakJyN1RlWFlSYmpSVDV0amd0NUtLc2YzWUV4R0dPeEpkQytNZU5k?=
 =?utf-8?B?em9TWmxiUzVuNGJVRTI3Qnc0SzhnZXdRYjRxTGhTVWl5KzVnZUw1ZW5mNFVs?=
 =?utf-8?B?TjhKT0ZHTDlXekp3TGhMZVF4dTVsa2pSVHF5VG5JbjBYRnRwRitNVTJnRDd2?=
 =?utf-8?B?Z0dncytXUWhMVTZqM2tZSjdaWXdENGZIR282Mkp0dnNmRnNFcW5UWHY3REZo?=
 =?utf-8?B?dVkvc1Fudzl4TGw1ODVVT0VZNjJCcjJkdkJ6VTJueUpFU1paNmp2UGF1TFZL?=
 =?utf-8?Q?rVkgTiDipCTKePxWF2Vq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9SUEdjYXpadXdQWXJYQk9tam1ha1BhbHJHQXRNMlJYcnhwTExLNjFKdERR?=
 =?utf-8?B?VDJrU05zVHgvb2FkTjZackhtZWltclB1OTcwK3hiNW42WHpBNTgzRjloMGJT?=
 =?utf-8?B?SU1uc3FFVHF1THNRYTZrMXhVeWEwTWpFdlRmeVBvUXJWOTd4WExEcENZMExS?=
 =?utf-8?B?RjFCN2N6WDVGVHhzZmJzNStONGYrTkwwTm9WdDQwUC9tK1NzVTR4YzRXS29N?=
 =?utf-8?B?YnpKMlpsb1gyQm5sa1B1eEt0Uk9Dai80aEx0N1dxZmlDQWlIRVNJbU53dGUr?=
 =?utf-8?B?YkdkdzVNamhXcVlZZmV5NGFDc1lwOWFIaERhWkxzUVBUOFh3cm5wMFA2dVZv?=
 =?utf-8?B?cXVjR3YzSitETXowZ0F5WUhBaURtelIvSlZ2Qm1FcjlrdFRDQWhqSG9rYXgv?=
 =?utf-8?B?dkIrT2pNNngwc3hocjlJZzUyWXpwZnBhbzBoWG5LdDFvL05sVjBKY3daKzhO?=
 =?utf-8?B?TTNNc21qNWtSMktFY0ExbzZXMG1IblkyUHlwdGMvMzFzbDRQc2lWaFFCc1lu?=
 =?utf-8?B?dGt4TkZDYklyc1AybktpaFQ4azJDMUNkSzBhenVsYmFCS2paU0VWRDdtcXgr?=
 =?utf-8?B?cTJQSEdEZ01jY3YyaERqY3RqQlNXc2svMUNRdCtHYmkxUUxabE5sdE91czVu?=
 =?utf-8?B?U2g5ckZxNkFoRVcyanhCa3dPQUxWdGxPNVk0VUNVcmRYLzcxSGNNb0hQWG1P?=
 =?utf-8?B?dlRFc2NnZHgvT3A1WFgyTU8wbllGUDZpU2NoUXVwckhBRmhVczBLUjNiL1B1?=
 =?utf-8?B?dkJhQWlqS1lRZGxubHgxcm5Ib1V2R2ErSS9nMUhHMFFjR2M4TVpPVXdqWUtu?=
 =?utf-8?B?ZndURWVGRmM3NTNlUWQ0aXFLR0RUbmZMbjgxRzcxd1pDZFlJYVplTVpPYkNq?=
 =?utf-8?B?UzlpSy9XYmQ2cE56SnVUdWFPQzh2SjJZTVJkdVlpazhBZHVRTUJtL2dnSmxS?=
 =?utf-8?B?ZnZYSlpvOC8vVFpnMlY3bHFzdUZ6Y3ZJT2pkeElxYkE0VXhnYUUyWURHa3dD?=
 =?utf-8?B?SXZkYlBWY1pldEhiYU8yQTRsbDRjNmx1MVpsRVo1OWM4L1Z4Z1NONmtEN2lN?=
 =?utf-8?B?dTFCQmMzVEo4UERNL3o5aHVsUzlYbVFaTlVsajI5QWlrNGUzdmp4cWxtSElU?=
 =?utf-8?B?eE85WmczOU9LSENOY2Zld29yaThyRXZ3YVRxK001Nm1iUGlBU3dBUE1yRXRK?=
 =?utf-8?B?V0VqcE1hQVNRM3N1ckhSVlk4Mjdrd2NORWdJSldMdm14dGFJL1dtQ2RCRXQr?=
 =?utf-8?B?TFdZaUR4ZkdQUDdkbXU2M05wc21tRzZXYnRnOGpGWmtCMkZrVWMzMCtKTVJS?=
 =?utf-8?B?OGhJUFc1bnBwQlN5ODlGb2ZLWmNzYUxPY3BzakVFdTcvSXBZWXl4NnZiaXg3?=
 =?utf-8?B?OFROWi9aZzh5cDlsczdURzJFN0dtVUEvaTltYW1maFhlYkpacFczNVV0RUxP?=
 =?utf-8?B?cWJZRnNYUGpmak5uSDZSVUdVN25ycStQWmVWYzB2ekR6NzcxM0s4aUoxSDU2?=
 =?utf-8?B?T3VSdW56Z0lkQlJDVUl3dG91NHZuTlVQQVVQbEJtcFBNOE5WdW14a3dLN2wx?=
 =?utf-8?B?Q2h1ci9kZlk4clBCZzdLUS9GbldLV2g1R1BGT3crYzhXRUR5VHhIU3MwdU1I?=
 =?utf-8?B?WkpCaGVQVjJXY1BTNmwzcDlkZys1RmxFY1FFM00xMHdRNWxTVkxmaVRGS2VW?=
 =?utf-8?B?L2VnN3V4aHRYUEpOWitXc0FLQnoxR3orcGpyUUd2MGs3SnZpNTMrWTVVczQy?=
 =?utf-8?B?WEsxYkhZRll1RjRmK2Yyc1FtdTFHSURhVXlnSy9jNlZJUEpRQXRUK1pXQlY2?=
 =?utf-8?B?QzJ5MXJXUGZIM213OHlNUFF2VnRpUzEzMkF0WnF3a1VaaUlXY2VmY3R2NUtI?=
 =?utf-8?B?dVowNVN3VjEvVTJHajFVbUh5T3pZMCs2TFlSZXdjNkhIbjF4dWliL296UTU2?=
 =?utf-8?B?WWRyeFd4aCtTeXI1U2dORDVyTXpkcXh0WHFjSEN5RUlJYjVSbHM4SEJqd2Vt?=
 =?utf-8?B?YkQraXVrbGUwa09QN0V3eElFUDlGYWdJcFNmY0pQNHAwdDNaa2tqTjZUZFFB?=
 =?utf-8?B?TUJIcjFPL2F4TXg4aVh3b2JtUEYrZE8xcFBDeHI1TFJ6akgxMVVBeG40RTZV?=
 =?utf-8?Q?+5i0M7pYQxQWLiNwwud+7gYTh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f290a95-68d7-44f3-0bfb-08dcefc0367d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:00:00.8223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfRZO1WHowuaMQh71A2Wx1dgWMVHCvYBDsexmsluBHCwb8p2dBmkYarz1JSvoQb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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
    <div class="moz-cite-prefix">On 2024-10-18 14:28, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com">
      <br>
      On 2024-10-17 04:34, Victor Zhao wrote:
      <br>
      <blockquote type="cite">make sure KFD_FENCE_INIT write to
        fence_addr before pm_send_query_status
        <br>
        called, to avoid qcm fence timeout caused by incorrect ordering.
        <br>
        <br>
        Signed-off-by: Victor Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
        <br>
        &nbsp; 2 files changed, 2 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        index b2b16a812e73..d9264a353775 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        @@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct
        device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dqm-&gt;fence_addr = KFD_FENCE_INIT;
        <br>
        +&nbsp;&nbsp;&nbsp; mb();
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_send_query_status(&amp;dqm-&gt;packet_mgr,
        dqm-&gt;fence_gpu_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_FENCE_COMPLETED);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* should be timed out */
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
        <br>
        index 09ab36f8e8c6..bddb169bb301 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
        <br>
        @@ -260,7 +260,7 @@ struct device_queue_manager {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid_pasid[VMID_NUM];
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipelines_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence_gpu_addr;
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; volatile uint64_t&nbsp;&nbsp;&nbsp; *fence_addr;
        <br>
      </blockquote>
      <br>
      [+Christian]
      <br>
      <br>
      Is the volatile keyword really needed here? I just saw other
      patches removing volatile in some places because it's not
      sufficient, and not needed if you use memory barriers correctly.
      <br>
    </blockquote>
    <p>After reading kernel memory barrier document and below link, I
      think we need both volatile type and memory barrier, to guarantee
      F/W get the updated fence value. This fixes an CP hang issue on
      SRIOV.<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://stackoverflow.com/questions/75750110/volatile-vs-memory-barriers#:~:text=volatile%20will%20make%20sure%20that,not%20reorder%20writes%20or%20reads">https://stackoverflow.com/questions/75750110/volatile-vs-memory-barriers#:~:text=volatile%20will%20make%20sure%20that,not%20reorder%20writes%20or%20reads</a>.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj&nbsp;&nbsp;&nbsp; *fence_mem;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_runlist;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_policy;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
