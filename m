Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B47C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 15:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C25810EB20;
	Thu, 22 Aug 2024 15:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRO5nEi/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD71F10EB24
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 15:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdu/xNb//6Mz3Civ0/5nWu7u+gZn441J5mMz1hyEcmvvJoCeBR04ydZ9AhgvOHotNvCwzJzhjPW8ciUQ82GQtlmXs6oSrw/jzFPR0zksA5gcRXSJWoCAa2EGCGANU3wJBay5EqWfMvMk0x2OCYm3TLVPEozZLRZpmKG59Lq3Xlx01RCQwySv5nUpFufbhBh+zzvovTDG9v3StymKK8pJBJ4RxsxYqtiG7wLThbMW8VlwmnfgEYXgFdc9LQxAFkQ97SMDVzmqfLCeS8Lpo1ushqMcOdAxWfLSkRPAFeoka6CUCmoeq6ACE6jE9uD1MS85XlaiXeA1xg2FmBSzr7ZIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEnFdpid+tRwCJiX3VglUWlAGeT3qmn+rJIIiinMECc=;
 b=NTwYccjEWE7Xjwp+Pw7MzSu2SDYtGTfheargjN35bCZ2Z9cyjfI8x+r1vInida+/clvS3I9gfXLBhGPRdk2znAeWQimk9a1Y27bn2IetDWaAzznMDqvOcbQCf6EZ+HqscAhGJV114SYRco5kfBnrTa/OFM6FEK+cDMFqqeR9bvAZ7dgcGEzEQ/uzMSrHsscCbPwqDF2k0ytPZ7/obUwgIUBFtMW4iaOO0PNn3EkuzyPiYCKUVj6DmcLMXo0W2jrZUBvgm1QpWs3ZUVe9dcQiWykf0qA5xQJgloazfCWcCs/ouLH+O8ax6ilF1sj5NERKnu4n2jXFjkoZhiwaALhopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEnFdpid+tRwCJiX3VglUWlAGeT3qmn+rJIIiinMECc=;
 b=XRO5nEi/G/Z/KZA/Qw9eoizJGgJ/77H6BOq1udcZzhB+uu1fVQaFot3NRGFW7+uOvxHRxEa2xSgjSKmlT6KXRkxKsPm8KZDiOGmMj9rzdtnHeeYGmh7i8rJPQ/9DtyfFLmlXvCAoM2ujASp4i9yb29aEKjPiwxNjRntyKtheFxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 15:06:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 15:06:06 +0000
Message-ID: <6703e6e9-162f-cc21-6441-676de508c407@amd.com>
Date: Thu, 22 Aug 2024 11:06:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Increase SMI event fifo size
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240730201547.13590-1-Philip.Yang@amd.com>
 <20240730201547.13590-4-Philip.Yang@amd.com>
 <478425e7-ce6b-4573-9119-c40b555bd6df@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <478425e7-ce6b-4573-9119-c40b555bd6df@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c849fd9-72a7-4979-724c-08dcc2bbf29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3IwRW5BbXd6d1BQREw0c1VZblJYMm1GdmJWb0Q1bVNrdThIT05sZ3RUY1R2?=
 =?utf-8?B?aDU4VGJvK2h3RVM5UG5kWlVlRnc4aTNldmlLS0dIQUxWZi9yNXMwNm53YkJ5?=
 =?utf-8?B?QVA0bEtwYUxWam1YZmhxMnZuemN4b09tOGl3d1ZlREtacWV0TGJOYkR6ME9p?=
 =?utf-8?B?c0ExTVlheUtxZEp2RkxhT29zVHJrZW0wbmVGY2NWc0VQWEgybDlEZ1AwekN2?=
 =?utf-8?B?S1RCMFBtamFpZEFjN1NJY0hMTjV3VWlkbXlCYlBTNWlLSGtBR2p3VnZSZ0RM?=
 =?utf-8?B?bEpSdS8vK1Qrdy9ZWkdsaE9tQUdEcnZkSWg3VkZVcWFUeWtsc1hkak5sYWVN?=
 =?utf-8?B?bklRT1o5WWtsL3B2M0tjemlYMHVqYkZubUtBOU1ERFpZaWs1bUpVTExrVlhO?=
 =?utf-8?B?Z1FIUzZ3eW5sdXJjRG5zSEJxSU8yUWVwQldSV1kxTndKdjM0QmF4eW4vcHVn?=
 =?utf-8?B?bUJwa2tZaTArQkxyQjlDK09VM2xaK28zcWtodDBzeDA1cklMYnFORVYzMzI2?=
 =?utf-8?B?VllvL3YyczcySFdQQTFnajZ0U1htNEc3a2prU0JaYXdPMmhBMHBQaWlJQm9l?=
 =?utf-8?B?UEhyNU1CS2t0MG5DZjZXT0VYMmppYXNKMVFCOVB4UWJ4ai92TlllVkFwQk5V?=
 =?utf-8?B?dEVCSmU0T20xYWErMTBUTE1tcnlKS3pJYzM2TnhkVWJJeDF1b2JXZDBaVmZa?=
 =?utf-8?B?SVFibytqZkx6dEdtWXlxYkZMbHB2MmlvcW1zL0tjejNTMTJqU3VGOFM5Q1p5?=
 =?utf-8?B?R09VS0p1WG45Vm9KQ1BtTFV2ckZVZlZFL2hQSGZlbXhmWnRuMjRoWHh3bHNq?=
 =?utf-8?B?SSt5OXp4ZG5xUW9lZHErejNRUzFkU2lXTGVHUEtaNGlPQ1ZrRFlCV295RnpT?=
 =?utf-8?B?M3lkbVh0MHByQVdGZkd4VDVOeEE4TVRBVVBFa2dQYmRFZWE5cHNWRmdmUlcv?=
 =?utf-8?B?M09WTmYycXBZV2hpZGVpREkvUkNXUzFlSWRmRzdhMDFleHZTbTlSc1g2MGJp?=
 =?utf-8?B?TmhGbkwvam9nSWNTMHlMb2dBZ0oxUjkzMEpTU0ttazJ0SE9JUEI2azM4Zkdz?=
 =?utf-8?B?dnA1OU9YMklDaStRdG1vMjZmSm1STWZEQTIwU3M5Ui93ZVoyTmY5RWhaRk1o?=
 =?utf-8?B?Mk04YWdwY0dYcFhZZm5mZEJVZlVEVnRaYTZEMmM2MVJUc1pNOGF4eFI0VU0v?=
 =?utf-8?B?dUZISTRZall5Y012Mmk4QUMxZGZSVHVMM09sVzhyMXhsTUxRSVBtcHZyT3gr?=
 =?utf-8?B?d3pKakg4cGNhdjg5WHZJelFETVgxWjUweWY4VTlVTUpFbGpMZkY0blNSdzA2?=
 =?utf-8?B?bHhrRzczdTFSWFozMlpuMjI0cHVERXE0bkhVaHd4dUpxRmNIdUY5bW9yYzRJ?=
 =?utf-8?B?NUNsZTQzbkhtOHFIYWVkRE9EK0NjWWhmU3lLTTBuZDhCem9mZG1mcitkVk1z?=
 =?utf-8?B?Mmh5cXZZYkFpT0hzWURRVTdPS3BFd2dpV0h1UnUzMFJCaDB3anZWSVZsZ3VO?=
 =?utf-8?B?R043TitWN1dPdUlRek5SMlp1b2NOOGEyRmpsY2xzY0tRdnY2aURWTWo0NHAw?=
 =?utf-8?B?V29MN1lINFhBOEVLUHh0eEIwNHlQdThRZUpQb3FXcmVLUEUwTHpndWFpYjFU?=
 =?utf-8?B?TTBFV1FyVnIxQlc3K0dLQlVqTUZHdC9OQVZud0t6NGo5em9jb3QvbnRycHR1?=
 =?utf-8?B?OC93c2dwcmRSWlJUMXZSMkVXb0lzRlJXazBET01lNDltb0Z0cGZuMW9USlht?=
 =?utf-8?B?UDdCUFdwR3dRRWlWVjh4N0VxanZvNGl3cTZTYzlPTDNPcE13YU1vMEJRNWZC?=
 =?utf-8?B?QjBsZlJSQWJnV1lFTzBIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2Z2OElLcmZCYjVZNEo1OVVQMEpENWtFY0QrQnpqMXJsM3k0NlQvYkNtdUE3?=
 =?utf-8?B?ODF4QzR5UnltYTM4K3VSUUMyU1oxTlpUOTBQQ0NmOFdlODUzbVN5UHBucGxP?=
 =?utf-8?B?RnhPQ0RNT214K3M4MnlFMDk1cEU1ZTBDMjRaZ29RcVZaNnFGcW9IczBzbFZP?=
 =?utf-8?B?R2hDdjNVUUxhbjJBMW5SNTIxZVNmRkZXV2FsU1UzVURyZlZNUG4vU3orS3g0?=
 =?utf-8?B?SHJ6L0NUdGdaRGY5K251SFl0NEpGaDVFcWlKZ29EQ0JobDdvQWEyT2d0MUNs?=
 =?utf-8?B?NnpUMzFBaFNHdjJJaENxcWdQN3U3elI2WEw3VUhLUGZma0FhSlh6bU43N2NV?=
 =?utf-8?B?clZ1cUt1emthR0M4azZwb2FUUGdyTHFSSFF1TGRpSlByanhWTWs2dm13RzVN?=
 =?utf-8?B?YUk4bW1aMUIwVEh3a3Zmc3JrWVFzcGdaTmN0a0JQUFRyNzhFb01aUWRnb3ND?=
 =?utf-8?B?ZENKT2liTDFqbnF3VFNQVnNoSHZYTEd6VnJTU0tuMjVYSllFTDI1SmxVVXF6?=
 =?utf-8?B?TnBzQkpvQ0JTeG9XYVN1S3hlc1NSTFhVL0UyUVZJWm1YTHBnSE5ZbG1iU3Zp?=
 =?utf-8?B?ZzBFSlZydGszSUJyeDF4WjhUbUdCd3E2SUpWeVh4dVNSUFdvbFVsT2F5QWNw?=
 =?utf-8?B?cXAxVklkY3NyL0svVDQ2MWdxY3ZhWEJLaVVTKzF6dmthc3FHejkyNHZyWm00?=
 =?utf-8?B?aHlhV0ROcmZNTnpvdllPMkt0S1psR2hQMEZUbEdTYVFXcXRkbFFDNWlZUldo?=
 =?utf-8?B?SDBwc01Da0grQnlDalpNaXRIeDN4R2NOMVlCelFIZzY2RWo4OTZ3S0VxZWhJ?=
 =?utf-8?B?dFlFUGVKb0tIT282eGYvRzhCNzJycjR3QXFUR3IydHg5Z0NsUlAwNXU4YTZQ?=
 =?utf-8?B?cmZzMEtyTDRMVjRqS3dmQWlpbFNMbjQ4QWFOdkMrREZ0U1BjbEdiR0lab3JF?=
 =?utf-8?B?Vk4xVHpLWDd5dTIvYzZHVGwycjJZYVBaekVOOHJWV2lybStRVE05dHBHcll3?=
 =?utf-8?B?OEo3UHRDK0lFcCtVbEdmVGNJdDdFb3pPYmg5SForQkpXVkpQaEtRenJMVlNw?=
 =?utf-8?B?bUFEM0c1c0c1cmU3a1diWVdoclhWQzJKdnROR0IvL0d3ZkFSbmh0cWZ3MUQ2?=
 =?utf-8?B?UGRKd0xVdnJ4RzBJSWxac1VzS2FMOStqNDJ0OEZMY0laZm1QVFlNK2ZYZjNj?=
 =?utf-8?B?VDFmbDVEZnNnL2dWZzBEazJ1NXo5V0xwLzFRQVR0MkJGeEwvVUQ1ZkNPNkFF?=
 =?utf-8?B?NXcyY2M0dFBsaFBmVWdURmp5WlovNkdCYVZtalBjcVJCMThFQUpUVVhBOVpN?=
 =?utf-8?B?K0F2ZFRwUm05Y0xaUXA1L0tTNUY1cWVBTWFkSmJiLzVLWkRJVmJEcmVtS0lq?=
 =?utf-8?B?Y3Z6a25FZzlJc0FJak4wVE8xZmpqZ082MWtTaUlKelJsU3JKWjltclVVRGJ4?=
 =?utf-8?B?SE1pT3dGRDM1Qi9uZmQwcVlRYmJKWWRCSHE0V0lKcTJ1aG9udTZ0NmdGMUp5?=
 =?utf-8?B?WDBVbmJYSnpsOVBuN2U2bi9NUEFHTUxKQjROMy9HWW1LWTF2S0hGRlVhby93?=
 =?utf-8?B?WnkwcHJoTWE0bW5STnB4UUVqMDdaYmlRVzNDRXFnNTh0elhUbnpybmMxbjRs?=
 =?utf-8?B?V3RQd1BmTDZOUTBxcmRSZHg0b3VXOUcvS3FGY2VvVmZGd0IzWGdyZHlEbDhm?=
 =?utf-8?B?RWhpV1hiZ3dCakZwWFNqeGREUEhSd3h1K29YellQMlhoM1JSVXZpSTM1NGpK?=
 =?utf-8?B?MlJjWFdhQzVsR212ZHpLZjNiWGYwMktiV0VNSVprUGVlUGJWb1hSS0JwT2NN?=
 =?utf-8?B?bkpWRXo2RVhUYkg0L3NNWEtPekZHaENHTGV1QVlkbHpvSGZ0NWpLL2JJdWNH?=
 =?utf-8?B?azZ4d2FVcjJwa1J3MTB4bXpYVHhxc2RxUkE3UzNnZUZnQ01RSWhva1ltN1Nv?=
 =?utf-8?B?dFpqLzNEd3h5Q0k1TnFtVVo5QVpXRndrVk93ZU1YMTYxQXRtVTRPZHRrdU9Q?=
 =?utf-8?B?QnRTQ1owOWN5NVhuUmRVRkZnRTBvMnZZckRzZmI1cno1cVgyVHAwa3JxYzRu?=
 =?utf-8?B?VFFwMkRJUlpFZmplY2FnRXVuSm5yWDlteDRnbkhBUXZYQ0s0eHZFUnlTOHpj?=
 =?utf-8?Q?3diA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c849fd9-72a7-4979-724c-08dcc2bbf29c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:06:06.6087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmECSYcY0bS8xW79A3nR1gcIn/a339AtSRgZv6cTuEzc6lDfr7M1SDUhQ+/CfEl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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
    <div class="moz-cite-prefix">On 2024-08-22 10:34, James Zhu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:478425e7-ce6b-4573-9119-c40b555bd6df@amd.com">
      <br>
      On 2024-07-30 16:15, Philip Yang wrote:
      <br>
      <blockquote type="cite">SMI event fifo size 1KB was enough to
        report GPU vm fault or reset
        <br>
      </blockquote>
      [JZ] There is a typo here. it should be NOT enough.
      <br>
    </blockquote>
    <p>It is not typo, but it is not clear, will change to</p>
    <p>SMI event fifo size 1KB is enough to report GPU vm fault or reset
      event, but could drop the more frequent SVM migration events,</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:478425e7-ce6b-4573-9119-c40b555bd6df@amd.com">
      <blockquote type="cite">event, increase it to 8KB to store about
        100 migrate events, less chance
        <br>
        to drop the migrate events if lots of migration happened in the
        short
        <br>
        period of time. Add KFD prefix to the macro name.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 +++---
        <br>
        &nbsp; 1 file changed, 3 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        index 1d94b445a060..9b8169761ec5 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        @@ -44,7 +44,7 @@ struct kfd_smi_client {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool suser;
        <br>
        &nbsp; };
        <br>
        &nbsp; -#define MAX_KFIFO_SIZE&nbsp;&nbsp;&nbsp; 1024
        <br>
        +#define KFD_MAX_KFIFO_SIZE&nbsp;&nbsp;&nbsp; 8192
        <br>
        &nbsp; &nbsp; static __poll_t kfd_smi_ev_poll(struct file *, struct
        poll_table_struct *);
        <br>
        &nbsp; static ssize_t kfd_smi_ev_read(struct file *, char __user *,
        size_t, loff_t *);
        <br>
        @@ -86,7 +86,7 @@ static ssize_t kfd_smi_ev_read(struct file
        *filep, char __user *user,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_smi_client *client = filep-&gt;private_data;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *buf;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; size = min_t(size_t, size, MAX_KFIFO_SIZE);
        <br>
        +&nbsp;&nbsp;&nbsp; size = min_t(size_t, size, KFD_MAX_KFIFO_SIZE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf = kmalloc(size, GFP_KERNEL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        @@ -355,7 +355,7 @@ int kfd_smi_event_open(struct kfd_node *dev,
        uint32_t *fd)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;client-&gt;list);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; ret = kfifo_alloc(&amp;client-&gt;fifo, MAX_KFIFO_SIZE,
        GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; ret = kfifo_alloc(&amp;client-&gt;fifo, KFD_MAX_KFIFO_SIZE,
        GFP_KERNEL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(client);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
