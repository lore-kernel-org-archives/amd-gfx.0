Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AABC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 05:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FEA10EA5D;
	Thu,  2 May 2024 05:47:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fqTbLtty";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3A110EDE4
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 05:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbykdxqp44DxmZ3GewOIyhTh83L51xhSBNX97D1MWJ+1eoiCL3hIRrgirZIXriy5RxPZE55AXrMp0bUTd4oqQRgBOvonjGEWO/XxxJ3X3N7tsnvisaqK56j+b3JFxeCd+x7u9EXvi2NjFDmWh9+l9Nw8nwgcs/hhi13rWv7xIG9/NbZVDRYhq4k8ixjJyKkbUEoX4w7oxwBmSffw1Fu1SqIUOWY6yQEKxhLyAF/C3hbcrZD5HPfxB5VAhVqDuIg14ge3XEEFkNn0iqWBJItABzradcTmDZstqkyQn44adB4qKODve8LN5SxPbx0ZzpCFh/Y26OLsijUwFXrBX1WWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNWkAdZ5VPaJ6eeUz6zkPCmphz4ppdtNaYIBL+iR6mo=;
 b=bnOB1OhBPHLT5cure3kjsNzMoP1uHZ3F3oxsGBnQfMpDS8XCHhnQWuEsWiuVx+hnsJfuAByyPBOz/qjYJlvy6YpvqNKa0DzUXSjcN+a/YdUsAnyfNiSjryskyEmYtsROfNa5kMF4YaQXgWukP7ZAG74WyJiKn8nXuplM99/SFZxKp7E77yqjJDJ8mTsU+TYR5SwSRtRg3Adus7SFFDS9ia5iOuRUlYlXXHJql6jfTD1s2YIOs96n/O9GExYXYnaI/CYDsr1K4QdeJ6FTe915BGx/d43qENoOd4jfaevl/1YN+2bymWh4X/7k4051lBeSu9pZQ6zeqm9B1SNrTbMJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNWkAdZ5VPaJ6eeUz6zkPCmphz4ppdtNaYIBL+iR6mo=;
 b=fqTbLttyAvTh4CVh0CSf5b1Kbs6T2N5qoAB9wvFDo2Hun5Hce0HYkBpAdQJ6g+6HSJN/Yap1Sz6nggJEyFPjlCKNClZawsb6dNv9M6IpiuelagDXzOQcb9tXPKMUdQHpB56hrhV+BbfqpPYCrySo0mLWPEZ1Mb2NkewhSeQZcWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 05:47:25 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 05:47:25 +0000
Message-ID: <3d61136d-9fe6-4c97-63fb-024face67b93@amd.com>
Date: Thu, 2 May 2024 07:47:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 12/14] drm/amdgpu: enable SDMA usermode queues
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-13-shashank.sharma@amd.com>
 <CADnq5_OKanvT1co22rxHEjBc_4RJwN4Ss5VrZ4Btx_bDFh0F2Q@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OKanvT1co22rxHEjBc_4RJwN4Ss5VrZ4Btx_bDFh0F2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0480.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 882aa924-3e0e-4aab-e569-08dc6a6b5837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGFYcUtCOW1GbUcxV0pSTk1HMUtxTTFHZ0EvTzZBU1pHREF5TEJqVmhhZDVW?=
 =?utf-8?B?VksxOEc4NGd3VmY3VzRrYk0wUEswL2hoY1Noc2ZFT0QvbXJBSmY1WXVjUkRM?=
 =?utf-8?B?RVBlQjIvVFFnRW1kdXBaeFp3WU1ueHZNU3o4U2JGNlRVZ0ovMDBDOGcrZHBa?=
 =?utf-8?B?bkpBZXFpM0w0Y1YwcHc3ejFNSTdsekM0L09GajJ2ZVBpdjRuelc5UDlwb0s3?=
 =?utf-8?B?QkhvdGovNDlhRWhNYnRjV0JCTmMrN2kvcWp5dnZYTGtjZThlNDI4ZW9KMkYw?=
 =?utf-8?B?NFRWMHd1UCs1cThFbTM1MSsrRWZ1MGZ5TUc0TWFkZVhFL1Q3bVU5SjhLbEdM?=
 =?utf-8?B?bnNVdEVnTnlHTk0wUUc3THN5QUNRWEdXVFRLRFhYM2NMUjNjL0RQVUNUbk5H?=
 =?utf-8?B?OEhqTk9LWFpFVEtKdTU3ZmlsN3NkSDFCN1gvOVhveXVpMktIU3RwUWRXbTBp?=
 =?utf-8?B?NXNDQytmeDJ6a21SKzNtT214WWc5UFNsM3lLdmJKZWpuVmRRTWh0Q3NHTDJN?=
 =?utf-8?B?ejFVeVlNcCszN2dlNTVDYTRuRVBKRUxLQ1g1ZEU1SmhzUE5RNFROVmJCbHZy?=
 =?utf-8?B?UTV0NkduN3RxdStubDNVcHZaOVN1WG1EeUVpVWdtOFc3ODJFWTFnajN0Q0xX?=
 =?utf-8?B?T0NKT240bGloU3pBY0J2eXlYNmNFS0RMTFpyM08xSGRyTURnZVVhVWJ0SWtk?=
 =?utf-8?B?bHgxQmJVdGc4a2htRHBwVUtMbUVicnR3SkZzc3d0VlZ1WHp6UWNxWkVmZGox?=
 =?utf-8?B?eTllTnJWMzN2enRyRjNWMVZic0k3cW5wOE5ERjhMRW4vaUN0aHNGVDF4cG1n?=
 =?utf-8?B?UytiKytQZzV3bU1KMHVPa0c3N3dhWGtaalJhM0QwVUZmMGxpWG9CRzVCUjhx?=
 =?utf-8?B?OFh0TmhHRkxjSGgvUCtIZlRDM0t4bUlVR3pRbXFaOGpMMUlVR1ZQOVU1V055?=
 =?utf-8?B?b0xiNkREQ1Y1by96b3RsZWxoQzRhZk9TOWpKenErNmRJY0pmeTVFTXBIUkpK?=
 =?utf-8?B?S2JDZm8wSHpzcklnK1VVa3dPV1g0dzJqUzNYMm52VWZ0SUlnYU5SazJVVVRV?=
 =?utf-8?B?U0pna2RHTjNKYnVxYndidVJIRDRJTXlZbFB1K2I1cjlpUUtLZng2SVF2Z00r?=
 =?utf-8?B?VCtlV3NIV1h5VStzREpIV1ZlMG45YUdNdFBXbGpDYUZyMklxN3UvOVQ0NmJD?=
 =?utf-8?B?cnRKd1lRTFgvcGdHa29kMEkvN0J5TWtrcS93YTBlM200cXJzZGNQUzE4cHox?=
 =?utf-8?B?OHE2NDBrQkxQUkoxQk1sczd6S2xld05PUVk4T0JsZUNIcmRUYU1Ca1Z3Mmxx?=
 =?utf-8?B?dkYxRkFUOHowTnBWbjhwd3c0M3djaDJXU3pyT0tmMHBwTVh3RGY3c1ZIWHo5?=
 =?utf-8?B?RmNNd3hkTGViOEd2Z1NleDZRdWNPRDRPc2NZaGFvcGc1MkpudkNwQ25nMzFi?=
 =?utf-8?B?WXZ3cTJPcXhZelgxOUlQd3pNK3FvMzk2MEZZS2c1TlNlSTZDbmNDSzN2cnN4?=
 =?utf-8?B?OGx1dDg5bHMyVTcrWkNGRlgwZmV1SVV0emtkWERxbi8rTHIxdk13N2tiM0Na?=
 =?utf-8?B?YVh1TmpUTWdoNStvRGZUSHYyWTZYYzFwY3Y3WHNiSXVUVDBNMWFuVGxialFH?=
 =?utf-8?B?bXJqY245Y0VtM0lER3RKS0JsekF0V1pHWFV4R2dLSEpON2FVSVMydzIzdEZN?=
 =?utf-8?B?OXF3QXlZd0szYlNYQ3lXODNuOGNGTGJDMU85NTJLTldDcnVJcjdVaUJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG00TVVWTzhlL0FJb05vVVh1elQrWVlicHpwTjcxdmNqVzRRQjhpTjRKc0ts?=
 =?utf-8?B?eENLM2tZNXN1YS9UTnVKL05EdlVwZkprTGlMbmp6S1BqSm5FcG9pWWkzcXhU?=
 =?utf-8?B?eWJaWjJoblZ5VzBIMFBIS2poYlVna0doWDgwMUNXaCtjV2ZBM254eEljNmU3?=
 =?utf-8?B?Q2JzZ0M1SEo0TFNIdmE1bHlvSnlIYVhUMDFvclRaUFpVK08yYkk1SzMvZG5D?=
 =?utf-8?B?VXB2anduenJQNmg3aE9CbmN6ZzNocDRQc2tnSDNvSGZkOXpINzlqZW44R0dE?=
 =?utf-8?B?UmF1bldVN2NUR2xJS1Qzb3daUzludm56bjRTeTY4alhPS0t1elZuMmtERkJB?=
 =?utf-8?B?VUlneStGVWkvendGQUV6VHNlWWJpY3gxWThaVzdESmpyb1gzdXpCUXM3aFVR?=
 =?utf-8?B?dldNSVZ5cjJOSEZ4NWVXVFh6NGt3NlZkQTdpNG1ZUmFXU0NaMVlhQldVSnVX?=
 =?utf-8?B?NTMzdVNMaGxlclM3eENhTzNUdkhmeHB1WWJRbVhZWitwbmRaQSt4RWdCT2Vp?=
 =?utf-8?B?Qmw1KzZad1Uzb2FRM1ZsZnVjbXhWaFBqUjBsRU1PQXZKdFdmT3oxb1lYQTRM?=
 =?utf-8?B?UloxQlRKVFo5MW4vUGtnOW50Y01NcmFGbzVReEVsZjNZMjNqaU1haFA4YjFY?=
 =?utf-8?B?SU5PSDM3c1IyYXdtTmxKaW5wa1pvSzNudTlTTURRNWkyUTN6SUtpRVFURFVP?=
 =?utf-8?B?TCtFNkhkcTh3dHNsMnVtQ3BGSlFMYkpHa0t0RmFyWGM3eXlIby9mSE5FT2J3?=
 =?utf-8?B?L1VwYXU2U0YvNFJ6UGd0TjRMTzBROGhseEVMQ2draU9BanNBTDM5RHdLTmJK?=
 =?utf-8?B?NXFZaFhkTHl5eHhlYmMyTEluOE40eHhqYkpvSjB6SDRYUzdoM3VSMmJMdzNn?=
 =?utf-8?B?bG1yQ1YwelliUFIxb1FaNnlPZVZHR2dPaXAzMlVjT1IySDRGVDdSSGtNMXpv?=
 =?utf-8?B?K2ZIbyt5ekZwNDNiUitXK2c3b3UxZVBqMVNEL0VxcnVGVkpHRkdSN0xXYlNG?=
 =?utf-8?B?S3V3STAvdUlPQTl5MklQVmlneXMwdHl6L1FCQnhKTnF4S3BVL2MzbTh1c3RG?=
 =?utf-8?B?NXIrUU1ySDFNZlczc2dpeU1uQVlCWTllRTNla2tQbmw2YWVaOWk0NEZwVkJa?=
 =?utf-8?B?Y0wwV3VnQUlIbFgzWWxpQUlYVXdFenhwYzA5Q1k3T2t5ckIvbDFiMEdKQ1V2?=
 =?utf-8?B?cWFaSHZEVm1IdWFZVkQwZkdiY0FrMzRtOVk3K2tjYk0rR1UrenBSMTBYNlBG?=
 =?utf-8?B?L2dneWxWUitWeUYwd01WMjdzS3N0Yi9RRmxkSkZVd2MxUzZMS3k5WWcweXF1?=
 =?utf-8?B?NEFwTlN2UzBoeGdHalVpWi95OENpUnhCUDhza0VpOFUrWkNCVzlBU0lyRHFy?=
 =?utf-8?B?SUFwdXQ4bGt4RFpvZ3dQQmdPWXRvMGZIdXlxUHRRb3pwaXFJV2w4RXBqUWpU?=
 =?utf-8?B?SGczWVNZcGFhSi82SlJHV056VGN3WlNQaEtmaDgwbkd0SURXTGlXWVRKY2kv?=
 =?utf-8?B?SkJwZmlYbXU3NEJRSHV5dDhDWWVkUXQydnZNUmttMXp6Rjk3RVoybGZTL1dN?=
 =?utf-8?B?KzZocHg1dy80RDRzQkNOaEtrb2tZU0c0dHVJc0pSOWMrZXNxRkxOd2FIWmVh?=
 =?utf-8?B?d3JYOXJUR3V3azBtdzdPWmVUeFBSUVdRamJ1ZmVRQWNzeFkyK0czaTl1cGFX?=
 =?utf-8?B?UHVFRmRwenRmdE95WEMxMDM2ZHZvV3NBRVlIL3gzZ21yWWtPUGM0a1dSTXBB?=
 =?utf-8?B?YmZZYmFpTHd1NVoxcWRlTHBaZkd2WmNzRFg5SXZvMWlqcFFDZFNsK3A1UEtS?=
 =?utf-8?B?UnJ2Ny9IQmZTT0tCaVRGc1JSbFNSL0twcS9XYjFNU0V0ZGVtR2hsVUNXWjJp?=
 =?utf-8?B?Ty9XSjY3ZG0zUmZDR3o2MzlwTkZZNjg2N0FKdEtwTy9IWVk1dE9wU29pcnhL?=
 =?utf-8?B?R0NkVXByejNaMGducSthcTNqTXNpUUwvTEpPakN0dTRIL0NXd3JqZjlTQmZz?=
 =?utf-8?B?YVAySkE1cnA3U2hkbTVFb2x6bFdwakR5RGJmUXc1bFUvd1BXak16QzR0b2JD?=
 =?utf-8?B?M05rRHFVY0xrUXEwUjJFcURLMXhSelJwRDBVOHVpOXczZ3dlckJOc1VscVNC?=
 =?utf-8?Q?FN0p2yz2vQiYZdcwhVTUI+frr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882aa924-3e0e-4aab-e569-08dc6a6b5837
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 05:47:25.6260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at2vLKDmVZ3mQU6VfGmDf+jTv1sxrPStUbpYuulNv7ewbICZCaXbMykOyAI5oTB+QaBrCpKo9Ia6LC2XS24huA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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


On 01/05/2024 22:41, Alex Deucher wrote:
> On Fri, Apr 26, 2024 at 10:27 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> This patch does necessary modifications to enable the SDMA
>> usermode queues using the existing userqueue infrastructure.
>>
>> V9: introduced this patch in the series
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 +++
>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 781283753804..e516487e8db9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>          int qid, r = 0;
>>
>>          /* Usermode queues are only supported for GFX/SDMA engines as of now */
>> -       if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
>> +       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
>>                  DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>>                  return -EINVAL;
>>          }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> index a6c3037d2d1f..a5e270eda37b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -182,6 +182,10 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                  return r;
>>          }
>>
>> +       /* We don't need to set other FW objects for SDMA queues */
>> +       if (queue->queue_type == AMDGPU_HW_IP_DMA)
>> +               return 0;
>> +
>>          /* Shadow and GDS objects come directly from userspace */
>>          mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
>>          mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 361835a61f2e..90354a70c807 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1225,6 +1225,8 @@ static int sdma_v6_0_early_init(void *handle)
>>          return 0;
>>   }
>>
>> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
> Can you include the header rather than adding an extern?
Noted,
>
>> +
>>   static int sdma_v6_0_sw_init(void *handle)
>>   {
>>          struct amdgpu_ring *ring;
>> @@ -1265,6 +1267,7 @@ static int sdma_v6_0_sw_init(void *handle)
>>                  return -EINVAL;
>>          }
>>
>> +       adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>>          return r;
>>   }
> I think we need a new mqd descriptor in amdgpu_drm.h as well since the
> sdma metadata is different from gfx and compute.

Can you please elaborate on this ? AFAIK SDMA queue doesn't need any 
specific metadata objects (like GFX).

- Shashank

> Alex
>
>> --
>> 2.43.2
>>
