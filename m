Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A914C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70F810F77D;
	Thu,  2 May 2024 13:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1CMA9R8y";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E13110E2CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5PQ7eP/CfcoaoCl7+DtS60KZzPolW2FUrSYqVVyzEA5IkYRMrRlDN2wvFYFt/kxPLgn9kJkdTSwabcRFwLHQwCpP+BYfMagHqg8yOvIYg0oKZWFZFssXq/HSL0DvR4bQ8CnaPL1uaLtWvRpyuYyWzWHveQ6bQWmf7qol4nPGKq+Cmj9x4STHYhoGbRsa7ppmPBMA0KWyovgHxLaYAA9atXZWdbzcL10r9I/+GEZ1tWwU0T1qem3Gcve3kgK282i+/gJhGz9VWwuTZoEu++X9gUq4lZXLmc9QjdbL0thD2O8oGnqyhTa6/w9BTFfoH89aA9Ti8/R5Pv7i9w1yjDTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75y+uk5z2+Ab1fZeoKvQNKh1m/eIxhEGLdZMCNDiUTw=;
 b=MGfeo8MNL3YbpecXgan/Tj7bn96CkJPK0UCPSUb4mVXBDjvm4jA+uNjPeqK6PKaS2TeJDiRSk55jiiTECJipDkfgxZoZWilLewAUqL3htfIBjuYo7pFegBAmGwUv4dLgrXkFZUT1HfTzL+MAvwSknMLzF4eKNFCKPdwuxCpe/9MXvJkJ/JHfn4n0tsW80LmrXR6J7TiYcCo1ekBsZTxUd6bwFvYEEdIrw7KLTbAtyfya+y7z9IqJ6MbbbxGzPQVxplAq6NdjG5Lpg5wu2hhZGzrHq2q5YSMcsJWzHnsWhvhenEsjjYESQXSVt1Jqb0iN2B+/0queh8Uh/TxZUJPFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75y+uk5z2+Ab1fZeoKvQNKh1m/eIxhEGLdZMCNDiUTw=;
 b=1CMA9R8y/PuLN0xkjsHLTeKMx06Dj+loArT30ABZnKMx5FsdDwmwAtI3cFPMbmThNsVa1K3Qna/mDxANa+olrUNpJAVC+cFNQtFTUZsRi7OkFq/6P2k3bLxD0R3PFUfS6HoSQhZo71MKuMATCrB+j1UPOitDQ49nyFHatksaIwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 13:23:33 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 13:23:32 +0000
Message-ID: <c59582a5-7a3a-7f64-938e-786fadde94c1@amd.com>
Date: Thu, 2 May 2024 15:23:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
 <CADnq5_NcuAT643x5tUe34fJUT0QG7f3WEwmf6VyL8VeLnsQo+A@mail.gmail.com>
 <53cfb00e-c41d-7ec7-561e-370cba54748e@amd.com>
 <CY8PR12MB709950EED733C245F05B48F98C182@CY8PR12MB7099.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CY8PR12MB709950EED733C245F05B48F98C182@CY8PR12MB7099.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb447c0-3008-46b3-d65f-08dc6aab0fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmVSS2xQY2tKRXc1UHRjcXRrSnlNMVNYZVRnTURFSWxOMHlSdENSSE9sZHpj?=
 =?utf-8?B?T1JLNllqZSt2UUE2RWJjVWhEZ1Nib2MyQ3RxSnFBUkE1MkJPdXlNdXF0STNO?=
 =?utf-8?B?ZlpTS0UwWmxyTmpudGN5Qk8rRHEyOVBIL2NEQTRwOVZyV05aM25UTlRzTUZ3?=
 =?utf-8?B?UDd1dHNrR1Bpby90OGFsejk4MkI3c1g4ZzVYQkl6c21McHNDNU4yUzlrVXVn?=
 =?utf-8?B?OTVqQ1JOelRkTFdnRWUzQUkzUDVLeUxPVWFxWkNqbzV1emRhTEpkeWZhdmZk?=
 =?utf-8?B?L1VqSktHQUowUWZKZzlBOHJjZitrVmE2aGVmaW95Y2tnRW5GNVJiMkFvVm9s?=
 =?utf-8?B?YUI2cngvQ2toWWpub0NUWVBGejA4MC9SOFpoWkNrakZOanRURjUydFVpT0RQ?=
 =?utf-8?B?bkNTU0Vsdjd4ZFF6cVh5OW03SWUvVmhrS3FUaGhoT3lBbGx0N1RWbGhtUTVk?=
 =?utf-8?B?OXliMkFFK2VtMkJVV3M2UVNEbllTMExIR0xDS2RSUDFnTjY0R2FrL3Ixd0w1?=
 =?utf-8?B?Uml1NmczU0hHTXA5Y09CTjQrNXIweXpjSXd6RXNiTk1ZUjJnQm5Qc002Nlgr?=
 =?utf-8?B?bHRtRGlNeFBqQnRVQm15aXNTTDlnOVQ1NFhPNkZVTW9VQk5oRzg2R3E5dFB6?=
 =?utf-8?B?dlFJWVd4b21ndXNDajFLdjJrcTh0ZHE3MmxaZ2g1RjgvS2xXaE1Benc2Zll0?=
 =?utf-8?B?ZUdyOUFYR1J0a3JEcUYxbTZwSkNuTFhEUyt6SEdqREtNYmlBTVRabTV4OWJM?=
 =?utf-8?B?MzJFam1lMGJ0U3JuenQzallweUlGa045dG9RRGFNSTVtblhSa0Y4eU44eEJC?=
 =?utf-8?B?emFqNzlFZGZBbUlJY0dJWlJSRHdJaDJZMDVsRTBVWTFyR1ZROVZaRXZyckVL?=
 =?utf-8?B?eU1JTlZHUGdpc2M2RHZNcjBVc2RMTmFNVEwxU0dUQU1WZ0Vpb1UzT0QycG5O?=
 =?utf-8?B?ejREaGJmdVR4Z0tqOTUyMlAwcHVUL1ZzY3hJNW1XTkw4bWJjdldpc2R0Sk5n?=
 =?utf-8?B?QVo5VWpoY3VldFYzYk1XNURxeDFXcjhkRmdldndoaWFlOE9PR2doajZBUjBV?=
 =?utf-8?B?c05lT1A3Sll0Y3dEaU5UUnhjYmcxa3VOeVA4YStYWDd0b0tZd3lIWnNIalhh?=
 =?utf-8?B?bXNDcUN6Sis1ZTg3ZTVmeGM3UTkreHJic1o3dUJQNE5VNVBjKzZWSE5Icjg2?=
 =?utf-8?B?Z011MEZkVlo2dG8xd091c3dsbWNYQ1lrNDY0R0YySUpyOVpBVnJleEt1RGhQ?=
 =?utf-8?B?VVV4dnVIZnYzdUZMRUx5MHE5V1lHQXZENlJtNGNEWE1abkN3S3pnSDdQR0Jt?=
 =?utf-8?B?b0dkVTZUdTYvMUNlcjgra3FHbmY0NFA1bHNwckZXVFA2SlFHbG5RRzRSVWUv?=
 =?utf-8?B?cE43cEYxNXVlQUpqWHZSdmZhcWwvMmFzdzcwWkxFU1JmYy9DZFg0LzdodndH?=
 =?utf-8?B?aWdQYlZsUVRmNTd6dDRVcXIzdHduTjNBMjRlK3owQmVjRkkxWVF1elB1d0Mv?=
 =?utf-8?B?Uk5pTWpjNWxjd3dUSlhSMzhqMURDWEs3Y2JNMWJzQTBVMUtnVkJLWXFPSXpY?=
 =?utf-8?B?NzIrSVE1M3ZqL2d3Skh1L25zMDRiMTg4eW1ZSksreitLZWVibGNuZjJTTjdt?=
 =?utf-8?B?ZzhqdkFsRStIUzdHbGcwS3Iwb2lWdEIzOTVobHFzZTM3TmJjcS9iaVNZUmIr?=
 =?utf-8?B?T1ROcnlMMk5UZEM0Zlo2YWdyaHJ0VnFGbTg4Qjc4dEI0NnAvelh6U0p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9CdnVBelJUYzRFRDJPczVrM3NMQVNlNFptWG5qTU5uMXhmQkJIUTdyeWps?=
 =?utf-8?B?aHFtcllNOE9BOHYydkc4ZXZUeXFFdUQxSjJTQjcvT3NNRnpQRXNOK2hJNTFD?=
 =?utf-8?B?WmZDUndOSTNMNStzQ2wrdWRiTEtNR0xlWEExWGFuUnI2UTFKc3AxSUNqQjlj?=
 =?utf-8?B?enRnbkhLbjY2bjBRWjByRmhQSXE0b2lXNWl5N0JETFBNSnV5S1l5REFaUFNC?=
 =?utf-8?B?NEEyNEhxVDl1VXBoL0M1WEJNUHN2SjZubVF2a0srV0FtT2ZFbzRzM2IvSmNq?=
 =?utf-8?B?dGZ4cUlGWHYvS0JHQkJPNVZNT2xBUjBBamQxSVpaVkttVzdiblBid0xIaUNj?=
 =?utf-8?B?OWdNbnB6QVVtdTFxUHJPWko2MlMrWkVUeXVCZ2ZNT21CelhYZjc2WkNPTFlR?=
 =?utf-8?B?Zmx5anhMZDVFVjdnbTllTXZlYnNnSk5Qb2JqamNXZ0xFb1BSVUNvM0ZqQWRr?=
 =?utf-8?B?OG10ckVuUWxJc044M2hqLzNpWmdqYURFV0syRGp6aXFXb3A4OEZKZVJkVTJD?=
 =?utf-8?B?TjQ2MDZGcGR2ZFdqNjEvdTMrMEd1L3k0RzhSMkVJVVNqZktrV29Nb2VacFNi?=
 =?utf-8?B?dGpwb1JBMzJjcjdKRTRqUnlqa2ZsQ2VjdjAwYjlEMWk4RnNkYyt3Um9HS0du?=
 =?utf-8?B?b0RnMGNoU1gzN0pjYkNZNUtkVEo5VUdXSyt4VEZSakpzdW5naGE0N2FFeERi?=
 =?utf-8?B?bUhUa2tIWjRLNXJGQlBaS1BjdHp5U0hUdWxqaXZPanNZcmdqSmNpWVIycXRY?=
 =?utf-8?B?TS9IbzBFWUs0MVpXMmJzRldDUURTWCs4NFJFSkZnbVQxcmJRQlNCVGxDakpq?=
 =?utf-8?B?c1AyRlNuNldRSnBPb2MzS1NnclgyT09XcURjNmgzZlVPcEZ1b1lXNjlLRFND?=
 =?utf-8?B?UUg5UmVZamR2cFIxRTdCMVdJdUtBODRkUS9kMXovOEJ4MnNQQSt4QlArTHNJ?=
 =?utf-8?B?UEx5WFdCbEhJb3NCaW9SOHZnOFo3bG9qcGtjZjM5L3BkR1ZNSVpWckY1U3Ns?=
 =?utf-8?B?YThtL2ZNc05YclRQQUtHT1ROemV6QjNGQis3VStxek53MTBOcFBOdkROQ2tB?=
 =?utf-8?B?a0JaREF6c0JlRlh2eFBQWDhLWFBlWjRUWWJzaENIdHJSY1kwdHRxZ01ITTYz?=
 =?utf-8?B?MjVSajZGdmVMUUpQRnRFMmVGVllWQnZaT2NUQnlLVjNtNElsZmpCYnY1UTAr?=
 =?utf-8?B?VWdGSnJKak41YXZyclVodzFsSnhGbWozYkR3b0FJM29rWmdIRGFDMWdYQXo2?=
 =?utf-8?B?N1ViODNoZWQycVdQM1U3YjFIZFJSV2dsRnNDWHBGZlpmL09TZFRtT3FoZWhN?=
 =?utf-8?B?VE1CMWw4c2dkOU1DTVl3UXZCbEQ3RUVnb0VwbUk4S3FHRVovbXFzdDBzYU5p?=
 =?utf-8?B?YXVad2lPMnlhT2s3TE5NV21iMy83a3V3K1k3S1dNLzNIWkFrRGc4eXMxZTdL?=
 =?utf-8?B?Qy9BdWdZc05zMGJKaDByYTFTN1h5NE9vbmV6TVVSWWd0VTNzZDlqZFBYV0Rx?=
 =?utf-8?B?c0E5ZlFSeUQxN3VUNGN5cCtpck40ZGswQUNYQ2FWZGN4MzlHL1RFVVhGZmdT?=
 =?utf-8?B?T2FOdnN4SzZaQVh3OS9LWmZvYUp2M3BNSFRmMUdYTk5xaFFUUFJZTTcwL3ll?=
 =?utf-8?B?REFDNWFkWG9PR0tMcWE1S3J2bWtKR1gvQlpFbVlnTDkvTlJQaTlPeHRKT3BS?=
 =?utf-8?B?R3NIWnMwbnl0eEFCdHR1R1l2NUxTdmVreGVibUhzMDZiSFNhU3VZakRVTWNY?=
 =?utf-8?B?L1VIWmt6K1BuMUpjYWZtRXZwZnU0akppcnErejgvN1NYbG1GeUZnTnF1ME5h?=
 =?utf-8?B?aGtlekxPa013ck9SNnA5T3A4WERrS0txWDZPTkh2SzVNUmZQY09oN3djajZq?=
 =?utf-8?B?UW1memcrWi9ueFhma3lVVTBKL0w3SEtjbXJyazJ6U1cvZ2Yvc1gxQkQ2RE1n?=
 =?utf-8?B?aW9zdDhJQWFDU2hzYnJSRWtBWGJRaGo3L1VYMUVrUjJmZXJuY1NGK3RyVEJV?=
 =?utf-8?B?WXFNbXNCYXRrUEVOVXFWVWZ4OFM3N1RncHNFNjhqWDlRU0xHdnJrUWxEMHBp?=
 =?utf-8?B?SndxRXdpbGhnbHZxUGVjOUJqaVd0K0MvN0JrMEliK25DMFBKeGJhSFNJTGVy?=
 =?utf-8?Q?lhTQ88dJ26YuoKtkMm+O5layy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb447c0-3008-46b3-d65f-08dc6aab0fcb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:23:32.0835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JkB2seZdjzCIeQztttFxwcSfyg7hxmhO9zj01uBlsoIU44nHw62u5UgrWvoD1RWHohFNDz7D9Y3zOWHlMKv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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


On 02/05/2024 15:06, Kasiviswanathan, Harish wrote:
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sharma, Shashank
> Sent: Thursday, May 2, 2024 1:32 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
>
>
> On 01/05/2024 23:36, Alex Deucher wrote:
>> On Fri, Apr 26, 2024 at 9:57 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>> To support oversubscription, MES FW expects WPTR BOs to
>>> be mapped into GART, before they are submitted to usermode
>>> queues. This patch adds a function for the same.
>>>
>>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>>>
>>> V5: Addressed review comments from Christian:
>>>       - Either pin object or allocate from GART, but not both.
>>>       - All the handling must be done with the VM locks held.
>>>
>>> V7: Addressed review comments from Christian:
>>>       - Do not take vm->eviction_lock
>>>       - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>>>
>>> V8: Rebase
>>> V9: Changed the function names from gfx_v11* to mes_v11*
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>>    2 files changed, 78 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>> index 8d2cd61af26b..37b80626e792 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>> @@ -30,6 +30,74 @@
>>>    #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>    #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>
>>> +static int
>>> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = amdgpu_bo_reserve(bo, true);
>>> +       if (ret) {
>>> +               DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>>> +               goto err_reserve_bo_failed;
>>> +       }
>>> +
>>> +       ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> +       if (ret) {
>>> +               DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>>> +               goto err_map_bo_gart_failed;
>>> +       }
>>> +
>>> +       amdgpu_bo_unreserve(bo);
>>> +       bo = amdgpu_bo_ref(bo);
>>> +
>>> +       return 0;
>>> +
>>> +err_map_bo_gart_failed:
>>> +       amdgpu_bo_unreserve(bo);
>>> +err_reserve_bo_failed:
>>> +       return ret;
>>> +}
>>> +
> There is a very similar function amdgpu_amdkfd_map_gtt_bo_to_gart(). Is it possible to unify. Also, adev parameter in the above function is confusing. This was also removed from amdgpu_amdkfd_map_gtt_bo_to_gart(). It looks like bo is mapped to gart of adev, however it doesn't have to be. It is mapped to the gart to which bo is associated.

I don't think unification makes much sense here, but I agree that adev 
can be removed from the input args. I will update this.

- Shashank

>>> +static int
>>> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>>> +                             struct amdgpu_usermode_queue *queue,
>>> +                             uint64_t wptr)
>>> +{
>>> +       struct amdgpu_device *adev = uq_mgr->adev;
>>> +       struct amdgpu_bo_va_mapping *wptr_mapping;
>>> +       struct amdgpu_vm *wptr_vm;
>>> +       struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
>>> +       int ret;
>>> +
>>> +       wptr_vm = queue->vm;
>>> +       ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       wptr &= AMDGPU_GMC_HOLE_MASK;
>>> +       wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
>>> +       amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> +       if (!wptr_mapping) {
>>> +               DRM_ERROR("Failed to lookup wptr bo\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       wptr_obj->obj = wptr_mapping->bo_va->base.bo;
>>> +       if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>>> +               DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       ret = mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
>>> +       if (ret) {
>>> +               DRM_ERROR("Failed to map wptr bo to GART\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
>> The wptr virtual address from the user may not be at offset 0 from the
>> start of the object.  We should add the offset to the base vmid0 GPU
>> address.
> can you please elaborate a bit here ? wptr_obj->obj is already mapped to
> gart, do we still need this ?
>
> - Shashank
>
>> Alex
>>
>>> +       return 0;
>>> +}
>>> +
>>>    static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>>                                  struct amdgpu_usermode_queue *queue,
>>>                                  struct amdgpu_mqd_prop *userq_props)
>>> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>>           queue_input.queue_size = userq_props->queue_size >> 2;
>>>           queue_input.doorbell_offset = userq_props->doorbell_index;
>>>           queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>> +       queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>>>
>>>           amdgpu_mes_lock(&adev->mes);
>>>           r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>                   goto free_mqd;
>>>           }
>>>
>>> +       /* FW expects WPTR BOs to be mapped into GART */
>>> +       r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
>>> +       if (r) {
>>> +               DRM_ERROR("Failed to create WPTR mapping\n");
>>> +               goto free_ctx;
>>> +       }
>>> +
>>>           /* Map userqueue into FW using MES */
>>>           r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>>>           if (r) {
>>> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>>>                               struct amdgpu_usermode_queue *queue)
>>>    {
>>>           mes_v11_0_userq_unmap(uq_mgr, queue);
>>> +       amdgpu_bo_unref(&queue->wptr_obj.obj);
>>>           amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>>>           kfree(queue->userq_prop);
>>>           amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 643f31474bd8..ffe8a3d73756 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>>>           struct amdgpu_vm        *vm;
>>>           struct amdgpu_userq_obj mqd;
>>>           struct amdgpu_userq_obj fw_obj;
>>> +       struct amdgpu_userq_obj wptr_obj;
>>>    };
>>>
>>>    struct amdgpu_userq_funcs {
>>> --
>>> 2.43.2
>>>
