Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137F9C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 15:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B0D10E9F7;
	Thu, 10 Apr 2025 15:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ID6BjmyP";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309C010E9F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 15:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maRDO8BExYuu6RKYeE8MnHgVfnzR24pDT15L6Gjmo94jKfJ1ERj7ib6rQGiL72yOQ/9TReZVzwnCr6oayDm9Ag8sqy/T/RyTKn44YbupzMQojk3wyDe/J46nd1VWyLZnPAB4ObnH1b8vwzRRS8LnmkixaUzAlls64Nd71O5TIpFaTtzMFhlqf4lfYouTAum4byuSm00YOnbch/CDw4ftoYqVqrlr8ppRm6Wo3K8hTlcJZx/cfz5am38QDUUHK2b9If6QAPUmKv5xrvfPtnZlrmvQUqK9+vIl76g5Nx3KFVSKIxYvAng0xYeqRjGOSEELs74n25ik9TlmTmLhZWeJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDGBjbuXs7/ena4ukexibUYOwMgbF9bI2AZ9gSS7xdA=;
 b=Js682TYdKiPZT8A7oxJ2a47a98rMDecrZIAfY0vH/+4HRzB+KGRANFZM4QAFARg664ebpoGPQmjwo5i55OhrORi8LoamrjqkcnuBHQIVCCzUT1vebZzSliTYzjCUOYEyldxxDeKPOR+ttNuRMp4Dvnc3xPSAQKV93kiBdU7mthuueUhIW1gbCIFJns+6WNolBWGoszus2zyBcdzmpuDpzBxGHG1IraYCnxQ/Ofn1eKxGgEB2ZhWREcEY5vUZMIddLwk5d/zgdT0btCF/aZkmRZ4cJFm5vRJQ2J9bHsXLWC52r5iTXceNvi9pLyMD+WP6qHT+sMv3wSy9J0NZeWCnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDGBjbuXs7/ena4ukexibUYOwMgbF9bI2AZ9gSS7xdA=;
 b=ID6BjmyP987AdtWFcHrffMPp5ygGwKHeQ4sJNMzBubk59MJtY+gciBVh59HKL3cUxN1nk/i4iTLtR3C/Zv9YPo0wCik+O4S2bsMbuMu5+d0fS5FDEHRgJVM1CRDLL1M0YMVUZVELUWa8G7s+Wfo4mo81cv5HWKkvnVaOfueIZQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 15:56:45 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 15:56:45 +0000
Subject: Re: [PATCH 1/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: Alex Deucher <alexdeucher@gmail.com>, Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com, shashank.sharma@amd.com, amd-gfx@lists.freedesktop.org
References: <20250410145646.51008-1-Arvind.Yadav@amd.com>
 <CADnq5_MeKHVv8YLsxvnBKpUD74Te2K6E1aYtAHJZ+b7+_ZRj8A@mail.gmail.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <a82f9e20-a731-f857-6e09-373251524c44@amd.com>
Date: Thu, 10 Apr 2025 21:26:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_MeKHVv8YLsxvnBKpUD74Te2K6E1aYtAHJZ+b7+_ZRj8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0078.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::16) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e89043c-ff47-463e-c366-08dd78484ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVhDYWJqaHdqVjMxYkdIQlhvaVJzMUNzQk91Uy9CWkhZRTlCMSs4aTlvaXhC?=
 =?utf-8?B?Yy9haDJ3Q0RvUU13bno1OUhscWs2NER5NEtxUTJwdlBVdW53TnZsbXE4eTJ1?=
 =?utf-8?B?dDE3MzhyUnllYzlQZ2dQTGdiSXV0WGdQQWR1enorVE9SdDhSeEtTMEQ4Yk1X?=
 =?utf-8?B?UW84M1I5R1EycGpNUXZoOTBISEV4R2c5K3R0dU01SVBnWW1uUVBXMXErNHpr?=
 =?utf-8?B?UkdOV0RUN3E0aDh1Wmh4NnNyRTY0cThXeVg4MXZJWGkzamE4N3k4NUNySjJU?=
 =?utf-8?B?aEltNmQxY3ZqMWZXbjBpY0JsdnFXLzRxY2RFeEIvNnNaTTcyMTJVeVR6eVpH?=
 =?utf-8?B?Ui85TTVTbDJQZVNWOHluWklNd2xqeHl1dVNwKzNFTlhsOWV1dXdVd2MyMUJt?=
 =?utf-8?B?Qm5SZGkrVFJ0Tm1iZTZuOEMzNFY5KytodUcyaFpNQVY0UWtVVmZna3REbzQz?=
 =?utf-8?B?MkRIYnlsNXcxRHFBTXpRMEtlUXRtcW4vaUdRV0lOR3haMmI0Umw2WXRRb243?=
 =?utf-8?B?czBkUEtCaDJQQlp2NHZFbnc1MDFHc0V1amVPczhzeENLTTgybDl6WVppdG5q?=
 =?utf-8?B?OXlOaGY4YWJpajhORTZKWXc2dXpLV0habm5DNXNVejMvbVB0Unk3MTdFdCtU?=
 =?utf-8?B?TnlrQ3lKOVR0WUJhWEliZkNtY1dmQ09hbHJxRzFJSndpZXNDNVZTclVjZms1?=
 =?utf-8?B?c3dDQjd1SW5xOGFwSHpNbCt4WUx1ZFNTYWljVmNyTXE3bnZxbmVwY1p2NkRa?=
 =?utf-8?B?OVkySlNXNytxSk9HVGU1ckpsTmQvaFR1Z1B0L0s2UkdHdlZQOXpCMWgvZ3d4?=
 =?utf-8?B?TUloSDdIeCsrWjdkaURJWGlQZGViTVhXMGU5RVVXSUpSM2dhZjdrNFB4SHpn?=
 =?utf-8?B?R1dEb1QxWXNTeVlhMnhLR05HNXRJekttZlVjUFJWQXQ4TElsc2xKNm9FeDI0?=
 =?utf-8?B?bk9BbVRCV0J0NytTamR2Y0ZTNFJDeG8vNVFCSlhCdU9rc1Q5ZHhEUTRxWTY3?=
 =?utf-8?B?cFg5Y0l1Z3laWDBmMFdGbGdxeWR0dHpSRzl6Q2hUeXpUM0I5N1JOcTE3YWpj?=
 =?utf-8?B?dmZHbVdXc29PZVg3RityYVZhSE1NS0NidW9Rd1JZSTFIb0Y1MERrSXhhRnBB?=
 =?utf-8?B?akdoNTI4alNGTml4U3FIbW5RYUJ1Q1BsN21PWTU2TXA1UDg0aWRSODJVdjJu?=
 =?utf-8?B?am1hd05xaFdmM0gwUTVCSkh5Wjh1ZEVyUWlVQTB1eERJdWRpcjNZRnlYTzBS?=
 =?utf-8?B?YTRxbUdPUzBSUGdIZjg2UmhYTWtmLzZHcXpjYlpZUmY5U1pxdEl0eUpNQ2dr?=
 =?utf-8?B?M21sblV5aS9TbjRwa1hLVWRaUGc2MmxrNkhaNVIzczZzakFoRXIzTmQxN2dT?=
 =?utf-8?B?bG1FZkQrMTFlcE14UTc0c0prbGRnOVVOUUQ5dFROOExEdkZEOGdOaXRWcThP?=
 =?utf-8?B?ZDR3UTBXR1dnS01VWWlHa2lhNVhIQWZwN0tSZzMxZDdBWnRSSERseG5IdGRp?=
 =?utf-8?B?YmZSSFBmMVh5dWZLVjM0V0F4Z2Izcm94a3BaL0Y3MTRFOVdxb2NtMTdoR24r?=
 =?utf-8?B?NElSbWxsQ2RIMlFhZGpRd3FWdHNoVjNFL0cxelNHNU5ERndUK0dKTkF3WGxF?=
 =?utf-8?B?MDlGOHprNE1KUDd2N2ZEcy92aVl4cUFjSmRVSnJsUnIvYkJvNnNoanBxVFlX?=
 =?utf-8?B?KzE3NEZJKzJyKzJDWXBqNkFRSWJHVW5qUjZBVzg2SENSZ1VCeVQwRzg1SWY4?=
 =?utf-8?B?Rm5kQSthY21GNG5lZnpvUjRmQ1dwVFJJeGk1Z0krUzhOeEpXb3NzV2ViRzZz?=
 =?utf-8?B?MUtxTWpEVnNONDhZWVpwN1NJRDR0dFUybFBBOFJvUGEzamN4REJRU2NtZEh0?=
 =?utf-8?Q?IaZDZu323/uHK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEw3YWJvWjJ2KzVjb1hEaENIRlhHZ3R6RTRSb05QREdtRnBNNWsxYkNFVjRM?=
 =?utf-8?B?MUVoT3g0Vy84NDZrM0NybnVhcjZTYWZ2Y1RhdDdWazhzZms1a01xby8xWDlL?=
 =?utf-8?B?eTBTa1NVVFh3NTZ3M2FDSXBORnpTcTN5WHNtRVdyU1k3N0orWHVkQldKSlNY?=
 =?utf-8?B?WW9IeC9XSnk1WlQ5L3M2dFlVQTlvc0pPRGVFUGFtTEdMWm14TzNnSEMvTnNH?=
 =?utf-8?B?bE5TOUppUy92M0FqbGlrQlNVdWltRHVnNlFJakhmd3llYmkwZVBkTDFDZWFZ?=
 =?utf-8?B?T3dieU92RzN4Z0xtKytHMEJRVithY0Q0Q2tYSGZnQjNGS2tLc1plZFJQS1ln?=
 =?utf-8?B?UXI4Y215T3F5bkM1cHV4TzhRajdZQjJSeTgrenEwSURCb3F1UEc4dTRHOUtm?=
 =?utf-8?B?SC9aRXVUTWRWT3VidGxwVyt3d3dVZ3lZdXI0UVVCQjZqSms4V3hrMk10SWlV?=
 =?utf-8?B?aEIxQnlHekVFYUY4SnRlV3FGeEhKS1pEczkvMHVoN3pQWDNXNUVKaEd6WEhM?=
 =?utf-8?B?YWI3ZzdFdDJydXpHL3pnTTd5MDM3bGlFck9hUzhReFU1cGU2UGFDOFJRSkhQ?=
 =?utf-8?B?dnVRYlk0eXlHai9IaDJrUVdyZzROSUNVaWI3WlVSOThBYW5nR2pvdzJuNEFO?=
 =?utf-8?B?WDFDeEliQlJlYUdpQmNRMlNxbGhsYVBhWElxKy85N3ZoeEJWZHRqN0x6ZVVi?=
 =?utf-8?B?OHp6SzU0b09kMXdJa01ycklqM3Q4b1NHS2Z0MUh2aG12SE9NY0JFQWNpR2hP?=
 =?utf-8?B?elJqWUF6Yk1nVFNWaXZxZGZNOUNBZEdZdDZEeGhYWHZGYVJDQ1NWUXdvUFJt?=
 =?utf-8?B?eGF0RnpETWpFTWl3QzhvV2JMSEJPcVNmUlp0djZZUmgxSzcza3hxczlUWjFt?=
 =?utf-8?B?MkYzU3hxdTBhT3NPY0U0Y3I5MlBwbHhkSWk5Ym9WY3lVc01hbmwzNmlQcThO?=
 =?utf-8?B?aUFuVDhMK3RyS2ZuUklpS0tsbUFlMkNZMEhVU1ZZVjVHS3I4WkxSTVdJcTg2?=
 =?utf-8?B?K29XdG0rYmVFVG9TNUd4NVUzTGs0dFVqeG5wYnVwdDJXdU94dzljMG9yZnIx?=
 =?utf-8?B?VjZrdjE0NTZXQnNGaHVUNEJ2MkZwWnVRNU9qNGErY3hQY3cxRUwrbHErWHVU?=
 =?utf-8?B?dVRPMEdwbEMyV08vR28xUE9zam14ZVNMVzBTOXUrRlM3UWZhck5FaWk5TDE4?=
 =?utf-8?B?SVhlN3hIMS9IM2Y4aHVjMVE3SmhrekRQNzF2TTBjK29tVHdWV2tla2xGdktk?=
 =?utf-8?B?UmVDcXJCVW9pbU1QalRFbC9nT1NtanQvb0hCSmdkMG1LRFAxRTVWS0NnYlZB?=
 =?utf-8?B?ZGNXMk5VcVI3V1Z6bDF1bTZKUTZiRnd6YWJzN2E2RzZtZ0RqZ1gzQXkzeUxV?=
 =?utf-8?B?d0xzWk1LK2VOVUNqZU9pZmxvNlc1WmxnYmRqeWxPY0F0azhsSXkwaDNWeGFi?=
 =?utf-8?B?M3JKUGJhTUdidUsxcDUrSVR4Mi8wV2pLc1dNNDIweEJITE5RQzdEN3lQSnFG?=
 =?utf-8?B?OUJ0eW5Qdmg0a3B0YnQvdEVkbEN4WGRlQ3JGWWxnVFNFTkJ2WnQ3Zm12ektS?=
 =?utf-8?B?MHJNQTljUEJzcUcyUkR4ZDN6emRJZkFidEUwcng5RUpiMTN5UXFqY0tkbUNk?=
 =?utf-8?B?Z1BiM0hpUFE3bmNvdjhVQ0F4Q29Yd09nMFNOZGd3YkRmenEvMGo0UXFGNE9F?=
 =?utf-8?B?K01DOFpCU1dvMnJCQ3F1ejdXRXc1MG9jWGk2TVdQRDNwSFRodmw1aWpMeGpW?=
 =?utf-8?B?VEJqVitnNEpicngrNWlpRUNCMmQzem9GQVhtZnVPdTJjTUNnOFpXNXhzRWNv?=
 =?utf-8?B?UVdTVnhvOFovVEtVQnpGOWk0d2l3M2xMY2NKbExnamVqVWlSODVyRWZ1V2FG?=
 =?utf-8?B?RHJrd3RrSVJyZWRPN2g1djZZcDN1c1dVWE9UV3dORnliNEMwWDlWNWFUVzhr?=
 =?utf-8?B?cnpOWWJFajIzTmhicG1mYnMzSEZrcmpOa2I1MnVUNEpURzVxYStPcldrU29V?=
 =?utf-8?B?Z2tLKy9jMzkvQksvRXBFajF3WDNFRWoySldXWDlUcEV1UytiSWJLN012R3R4?=
 =?utf-8?B?Q0VkVjNhMkdkQWFTL3EzakZnb2Z4dWxMMEdteDd1NFdHOTBiOFNRQTdiK2No?=
 =?utf-8?Q?J5zywbPbsRfBu3r8UJVHcTTI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e89043c-ff47-463e-c366-08dd78484ae8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:56:44.9914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohxcNFtJgnEcbSgsafyV0BsJ1/Z7Iuaw7asXQFkJT0ZC5gTSI+QGWPhlvyUsCGjKlhGHwv3yRU+DZYWD8Fb1zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
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


On 4/10/2025 8:50 PM, Alex Deucher wrote:
> On Thu, Apr 10, 2025 at 10:57 AM Arvind Yadav <Arvind.Yadav@amd.com> wrote:
>> This patch is load usermode queue based on FW support for gfx11.
>> CP Ucode FW version: [PFP = 2530, ME = 2390, MEC = 2600, MES = 120]
>>
>> v2: Addressed review comments from Alex.
>>      - Just check the firmware versions directly.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 91d29f482c3c..62dcdba589cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>          case IP_VERSION(11, 0, 3):
>>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>                  /* add firmware version checks here */
>> -               if (0) {
>> +               if (adev->gfx.me_fw_version  >= 2390 &&
>> +                   adev->gfx.pfp_fw_version >= 2530 &&
>> +                   adev->gfx.mec_fw_version >= 2600 &&
>> +                   adev->mes.fw_version[0] >= 120) {
>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>                  }
>> @@ -1646,7 +1649,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>          case IP_VERSION(11, 5, 3):
>>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>                  /* add firmware version checks here */
>> -               if (0) {
>> +               if (adev->gfx.me_fw_version  >= 2390 &&
>> +                   adev->gfx.pfp_fw_version >= 2530 &&
>> +                   adev->gfx.mec_fw_version >= 2600 &&
>> +                   adev->mes.fw_version[0] >= 120) {
> Are you sure this is correct?  I didn't think the firmware is ready
> yet for these families.
These version is shared by Mario. I have also added you in that mail.
Firmware Type    navi4x    Navi3x
PFP                        2840    2530
ME                         2780    2390
MEC                       3050    2600

~arvind
> Alex
>
>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>                  }
>> --
>> 2.34.1
>>
