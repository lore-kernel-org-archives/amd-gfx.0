Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23871C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9AC1124ED;
	Thu,  2 May 2024 15:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5Yoatok";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F681124ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQA7isOMruyx7A/WXMGdfNW4tuayIgk140hs8yWrCQhONWo4YrxZEISklWI9DeNcqm5rXpoxNgi5X5pliEbaZ64+MTutAy2BE/6vUYHPieTzuBMv+fyuWlnEwPLJVUABx8q1t8qXmppEmQoKROcEeWKvwJB6FbMBc2jsa2H0zAeqn9AEUKqwPFUsu04pIInOzor+5+LX9yllwdDBzI+cNLbjj8mPFRhHLdxQO92XhNscMgCGk5FlEyIjoFNEpT/etRRgwAvGlW9jfrOKRCCoOoV7uZU8mOs8YGTsQ2aTL9BfhYc8k5MH4AotCDs+Y95o0DIUgL1HngGrrtuS3pSRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw1xDOphujKZvYmVTDIOecw4baSeoFGc35PCThwfrM4=;
 b=fLzRkqM7u5t+83M39l9WsiLdKvwHvKGgUX5PHx0+/+PmdGkWsGY7GVK8uEn9B2vpYsYWL6WQFiml9zvPi2BHxuoIDvhcNXg01KwZXBqVaO4GpdRU6qu8BiGWX1Xy8uIcMDjTua1DksICqtfNure/TY5ylf+ZYhpWSjbdr/VQzYNAKNyAIQlOPh94/1+y5l0RowvWlUgTorE159rD9DYgrWlSNOhusjUOCqlzq2ya8cp+Fz4PhZFpCGrTs8mv4xlTAIkdH5CbbzXrOBbk0c+Dg6YcPT/O0doIFQFote2ZWbUQ7iRXxe2CM9JihjtYR1iS2ujuEFpJkvk+zlXQQxBYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw1xDOphujKZvYmVTDIOecw4baSeoFGc35PCThwfrM4=;
 b=d5YoatokYuTWD3RPda1zIctim+HJjmsULCGpyV9GKBNmD4DOevUORhtR9Izsh3TlvUBR9OB+2WM9MS+HRZqmIlxb7sXdxHfryNlN3993aDGUsiXG3QjmEW1byirHQwVE5dDO1dRnIAGyab0jBb6ClthkisMp5ygm22nO+nrBxTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 15:05:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f3cf:148e:3827:8035%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 15:05:34 +0000
Message-ID: <aae15d37-35b1-94d9-6d6e-48b16307a229@amd.com>
Date: Thu, 2 May 2024 11:05:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Remove arbitrary timeout for hmm_range_fault
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240501225655.5215-1-Philip.Yang@amd.com>
 <a28dddff-5eae-4856-8f87-26d534163a6d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a28dddff-5eae-4856-8f87-26d534163a6d@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0431.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: a5856aba-b0ac-44c2-5563-08dc6ab950e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEUyQnhBTnIrUmFuU0lxZVM3am05MWhaRWNjendhckFFUVA1SlBZV3VaSGVT?=
 =?utf-8?B?cGtyeGtYU1RiY0Q0bEVIUWxRalJ5ZEVEYS9LaGF2dy9QTU9aeCtXZnI2OFVD?=
 =?utf-8?B?OEx4Qm4yUUlOcmswVkNTbzlEdU54bjZkLzEvOUk4QmRvQzFLKzhSeTJxVVd1?=
 =?utf-8?B?R0wrMC9NanprQkJYNWl0ZEl3TEVKWEtjSWxZTmE4TFBscy9kNGVrQ0FVTXNv?=
 =?utf-8?B?MWpPNWxFVkZSNE9tbGlXemJ5czNtVEozcVU3M1BCaFFzY1Fab0srNFFtU0I4?=
 =?utf-8?B?Y0RXS3Y3TlYrT3hpSnZBb3FpKzVXMXVnQ2k4dkQ4TGc5bkxTVFU5WnJobDZK?=
 =?utf-8?B?aVpOK0RNZ1huYWZlWGtsMFBabEFJbE1aempMV3c2NlFXZWxRZGZGOGd2YWFq?=
 =?utf-8?B?YWtVdjJEYVJRN3N3Y0JZbVVkejBkQy9naXNpSzY5YXVwUXZ6VkcwN2ZaNWJu?=
 =?utf-8?B?VThxcUJMT1V2MlhYM09rQ2N1SE1BUjlOQUxweHJxSHRqUmhBejlUbHp6Y0xk?=
 =?utf-8?B?Y0tFUWpsUmtNVXJwT0FRY1ZSZ3hvSUhRUnJGTlgrMlJYT3BvQ0tHd2NFMXVH?=
 =?utf-8?B?RUNpWEtZaFp3RTB4VjVvV004NnlsQVY5RzAwYTlDa3BFcTM2WFNZbVBuTlB1?=
 =?utf-8?B?WEpjZDVjS2lpK2o3VkdFVkJ2K1F2TGE1MzJ2NnQxZVRnVTR2ZzF1NWRUQVBY?=
 =?utf-8?B?emh6RXlRdmJEOUhScUJOTnMvb0NzRXYwUGFHQ1hyeWRKNVhKbUh1M2dVV05i?=
 =?utf-8?B?WVZndzZzcDlqcnhrVzBGbWVBUFJVeHJvZzM5cUhydlJEaHB2VENUK2tXUk44?=
 =?utf-8?B?VFFGaHE0LzdzTVNiTXJTeEhncml3enFPNm81QXJUcE9KRk04Nkd5eG5xd3Vl?=
 =?utf-8?B?SDNLRllzUzlCL0RONUoyWUdMSk5vMVg0MVgrOXd3dm13VE1xdldQM2J2VE8r?=
 =?utf-8?B?cXY3Vjc0dTFCdUhWWXN1K3pacGFRRGNFanFjcXg1N212SkRDYjVLZkZQSGpa?=
 =?utf-8?B?VFNURW1Cc2JDTWMwUFlLdWl4TGt3bFluUVdPd1k1M1dNRTYzeTBiSE9oNm8w?=
 =?utf-8?B?UlZVQmtVOHlFUDRrSzFLdUtXVnVHR01zdVhuaVNDSTJVVmdkcG5HcDdCbjBP?=
 =?utf-8?B?OXlKMVRUQ2JTYjhwK3JXOFFkdHFCSUlmaU1PUEdyZ3lCRHNxOGUxbXl5QzJV?=
 =?utf-8?B?VnUwU1daR3BnUUxUcnJlMWNOYWQ2UENNTEUxTWc5QVp5WDUwd0FyVGlOZ05v?=
 =?utf-8?B?L2dJR1BTUGYxVG96cmVsdDBrdUsxUDJacHExeWFHNHh2ZDdua3NSREJlWHRV?=
 =?utf-8?B?alRvUDVFcWJZdW9wbm5Ia21FOGdzS2VOVURHUlBWYzJYYVlSbEJCWFdOYWZQ?=
 =?utf-8?B?UGJBMVdjMmZkVXlNNjBJQTI2NVpXV3h6YUVYWUpWajJMa3VxdHVMYW13VVlS?=
 =?utf-8?B?M1lJVXVtL3lWT2NiQzBmOTZsRC9uRDAyUXZ1YlEwTCtER0h1NGFUbm0vWHpP?=
 =?utf-8?B?ZVU0d1NIZDFaVHJWcmpWM3l1SnNheXkvNTdIdWN3aVZub1c5Y2U3dUN4bjVh?=
 =?utf-8?B?S3J1SmlSU3ZveTc2ZG9xNzI0MU9LZjFqOTdwMzF6YUJQRVd2OG9nanpPeWlY?=
 =?utf-8?B?WUI2amQ0enJuczVnb0VEaWpJS2ltaWhDdE5oc1JROUxObVVxL3BRRHZXVkpl?=
 =?utf-8?B?TW42RE9JbnlnK0NldS9zUzhLbkd4Z2IwTzFVM1hDbDVGOTNXUHRZcVJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBsMkdPMnJPMG9qVkVwakt6NGZMdlBrT2lhOTBaMEIwVDVKSTJEMjAvWklL?=
 =?utf-8?B?eURFVEdkSXVmam5pZVUxS3ZBUE94S2NTRjd6ck03amhvdHYxUzVQYnJXM1V6?=
 =?utf-8?B?U3NhZnJsV3E5U25DdWxBTUNUdktWSWVwdVYyNmlTd3FPS3EyUHRGa2FzdktO?=
 =?utf-8?B?WmlxejdUWTMwb3d6b1ZWb2pmTGNyVE5Uci9SdXMzZWFhTy9hYWpxejljSU1P?=
 =?utf-8?B?OHROVjBBYkNSTUFMSkw1RU1zOXhKeWs5WnBSeGUwOXdsSDVNVmJuT0N1STZo?=
 =?utf-8?B?UkxBNk5TTjBVWDZGSFliTkx1NHE2aWF2Sjd1Q0V1cUJDVE5tM0UvQ3lDZ3pQ?=
 =?utf-8?B?ZXRuOG92dGMzenhmSkRNRUVJTFJLU09LSHlZNituZjFqY3FUWmlTenBucmZT?=
 =?utf-8?B?cFQ3TThUM1pQbGUxbWFiS3k5cmY5ZXVXalBqT1d5V0JLZ2VPRlBxeHdwZU16?=
 =?utf-8?B?a2Z1WnNQNFhUUHY4U3NkZEJON0hWMFEzZXJ4ZmNaZnRHc2dMbFBlN1E3dXg5?=
 =?utf-8?B?SkxsU2xYeklVZDNZMklFZVRjWUhRc3dya2xLQTVyLzFrV3VtQXR0TXBjN3V4?=
 =?utf-8?B?UjFCMll2dG5xQXJjT3ZqRTN6cXNNVktOQm5mR1BuV0c3NlRodGV6RS9McW9R?=
 =?utf-8?B?eWVicitFK0F6cWR6dUcyMS9WU1U2NnZpcVhQTm1EaTdSMk1MTHU4QVFTdDVN?=
 =?utf-8?B?QlB4aS9RZGM1YVhuSGVaZWZUYklKYStHSnhWbTk4MjNjdmF4MktVZ1hKNmFo?=
 =?utf-8?B?OThpVHJrTE85RkhjRE5uODBpY2Rlc0xoR0luM2lFL1VzbndiSWNoSnF1LzBn?=
 =?utf-8?B?Um9IL3lKeHhKVUg3MnZUMHI5RTlMcTZNU2FJMmp4S0pHd2daY3piaHZ0cDVu?=
 =?utf-8?B?cERNbVhSMUhVK0ltMWFZZmdMNkdyWlc1cVIvUFpKMFBSYjN6YVNzMnM4KzR3?=
 =?utf-8?B?TStPM09OM0ROZWhqaHBkZHNZUDNlbkthaDAvNW5wVDE4enNGS3R6U3VqY1Rn?=
 =?utf-8?B?U1Z3WDhEVUdMSWt2YkJkb3plRFBvU1VRNyt2d2taOGZRdzN0MkU0R0djTmRu?=
 =?utf-8?B?aGxlUzJ1MU1RZDhPR3F2d3I2Nk1wd3Nzbk94UU9DaHcwbjF1SEVDS0QySzZS?=
 =?utf-8?B?VjUrbTFaaG1BZExUMUdGZkJVanQ1aHFUOEM0UCt6S0loUmNEemR1MFpqejRU?=
 =?utf-8?B?L2hWOEc3Sm0rYWJHMHNlZUVsWkNxQkJYMzc3NUVtV0hnbXp5SExCbE5yQUpq?=
 =?utf-8?B?MlhMbHY1QnZMckFMeHZ1UGNoRjVuYXJjUjNCWUI3WFFnc3ZFWjlvb1dwa0hz?=
 =?utf-8?B?RDVCSkk3UDY4VkM5eHltTTJxT3ZDVWhuTDUwSFlsOXlFQ3ZWSHdybCtLNjg5?=
 =?utf-8?B?bW5xVlVMZjhRK2l1QWdBOFNLUEN6YXhpdnlKb2x3Vy9ZN084Zm1FZFlKZml0?=
 =?utf-8?B?bjcrUXhUakNRdEk2RlE0TXRRN0J6RitQZWVPVDJUb1NZVHNxaW8xbDNlb2Fv?=
 =?utf-8?B?andSQmhJMnZpNUp1VkNqOWpFL0J4WXF4dDlIdVdLeXh4NmNtaHd5ZDVDRUhx?=
 =?utf-8?B?U2lWa1UxeFFoMERxK1BGSklCT2pVMHI4MHBkNE1JRGR1UGhEZkk2NTZrZXJr?=
 =?utf-8?B?aEtWY0hGbGk1RXF3WmZmOFJ0dmo5ZCsyVzIrNzJEZHBvU3luc2pkc0toQ3cr?=
 =?utf-8?B?SXlYQmczNkJ4Uzk1MFpWQytlS2huUTZDTlBFcVRXc2VEM0JYa09MbDhFZDZP?=
 =?utf-8?B?dXVwSktjQ2MrODJ0NE82aHdNY3NRSEFaVTBVUzQyQzJxWnZaRDZCMlRwaTVK?=
 =?utf-8?B?YWFvVjJ4eHpyM05CcjY4Mi9Ndk1neEk3WDNldE93eDZKc0hvWXJ1N2x3ejdU?=
 =?utf-8?B?SlpxT01OaTBNQlMySVFXelJRVzYyRkp4QWpCSGJHL2xyY1d3dlRRT0hUVnBj?=
 =?utf-8?B?dGJxZXh6dXl0NHkrUjhKK3pFTnN2ZWYxSGx6Wll6NU4zNkd5cFFYaHBwdllQ?=
 =?utf-8?B?QWdlRE40bHB3RURKd1lnYy9QVXRON09mVmgzN2EwWXJQWG4zUmhITWhGaUhl?=
 =?utf-8?B?QTd2bzhSYmFXcFNwN20vVG03bmxmTWpwd0ZZZ3ZndnIwbVJOV3RibDNRS3pZ?=
 =?utf-8?Q?BQZI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5856aba-b0ac-44c2-5563-08dc6ab950e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 15:05:33.9826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kd1Y6Bu3ke6BPglHM8/pgazf7z/NnC2CO/n01+zj0E6pW2h06ziAuEKNcb7q2w3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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
    <div class="moz-cite-prefix">On 2024-05-02 08:42, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a28dddff-5eae-4856-8f87-26d534163a6d@amd.com">
      <br>
      On 2024-05-01 18:56, Philip Yang wrote:
      <br>
      <blockquote type="cite">On system with khugepaged enabled and user
        cases with THP buffer, the
        <br>
        hmm_range_fault may takes &gt; 15 seconds to return -EBUSY, the
        arbitrary
        <br>
        timeout value is not accurate, cause memory allocation failure.
        <br>
        <br>
        Remove the arbitrary timeout value, return EAGAIN to application
        if
        <br>
        hmm_range_fault return EBUSY, then userspace libdrm and Thunk
        will call
        <br>
        ioctl again.
        <br>
        <br>
        Change EAGAIN to debug message as this is not error.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |&nbsp; 5 ++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12
        +++---------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +----
        <br>
        &nbsp; 3 files changed, 8 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 54198c3928c7..02696c2102f1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1087,7 +1087,10 @@ static int init_user_pages(struct kgd_mem
        *mem, uint64_t user_addr,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_ttm_tt_get_user_pages(bo,
        bo-&gt;tbo.ttm-&gt;pages, &amp;range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Failed to get user pages: %d\n&quot;, __func__,
        ret);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == -EAGAIN)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Failed to get user pages, try again\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Failed to get user pages: %d\n&quot;,
        __func__, ret);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unregister_out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        index 431ec72655ec..e36fede7f74c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
        <br>
        @@ -202,20 +202,12 @@ int amdgpu_hmm_range_get_pages(struct
        mmu_interval_notifier *notifier,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;hmm range: start = 0x%lx, end = 0x%lx&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;start, hmm_range-&gt;end);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Assuming 64MB takes maximum 1 second to fault page
        address */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = max((hmm_range-&gt;end - hmm_range-&gt;start)
        &gt;&gt; 26, 1UL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = jiffies + msecs_to_jiffies(timeout);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout = jiffies +
        msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
        <br>
      </blockquote>
      [JZ] should we reduce MAX_WALK_BYTE to 64M in the meantime?
      <br>
    </blockquote>
    From debug log, the range size is not related, 64MB range may takes
    same long time to return EBUSY too.<br>
    <blockquote type="cite" cite="mid:a28dddff-5eae-4856-8f87-26d534163a6d@amd.com">
      <blockquote type="cite">&nbsp; &nbsp; retry:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;notifier_seq =
        mmu_interval_read_begin(notifier);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = hmm_range_fault(hmm_range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule();
        <br>
      </blockquote>
      [JZ] the above is for CPU stall WA, we may still need keep it.
      <br>
    </blockquote>
    <p>The timeout 1 second should be long enough for normal case, if
      hmm_range_fault returns EBUSY, we release mmap_read lock and
      return to user space, so don't need explicit schedule to fix the
      CPU stale warning. Will run overnight KFDTest LargestSysBufferTest
      on larger memory system to confirm if there is CPU stale message.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a28dddff-5eae-4856-8f87-26d534163a6d@amd.com">
      <blockquote type="cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FIXME: This timeout should encompass the retry
        from
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mmu_interval_read_retry() as well.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY &amp;&amp; !time_after(jiffies,
        timeout))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_pfns;
        <br>
        @@ -247,6 +239,8 @@ int amdgpu_hmm_range_get_pages(struct
        mmu_interval_notifier *notifier,
        <br>
        &nbsp; out_free_range:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hmm_range);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 94f83be2232d..e7040f809f33 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1670,11 +1670,8 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly, owner, NULL,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hmm_range);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm range pages\n&quot;,
        r);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
