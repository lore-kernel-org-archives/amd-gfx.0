Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BFCCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 14:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B101110E4BE;
	Mon, 27 Oct 2025 14:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sas0i+km";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2F310E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 14:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDm1MSZcIiViACBAun/0T8iSTVYsMfXSSkpYayxQlZ0ty6/p6MRzqtA6LCmDZ4lvsb+lJ39b1FhtiuafFrBr70BTBPIFCi8YCEacsbn19zMxUfvZ2hLlOvLtcAQaUYaz6beSPdWkOzCggrpBg4PPxSwdjVwIJlhfYDRJsPnnl+v2phpKlhuCUxWsyqTvp/oqJ+jJ9xAlMrg33sdM23fWqBpYj5Mv+w6HafIOeS66yrSV7jlhQzCd5qtCRA61y1WqrOsbmaOGNfooTwWAQqir2CBVga+e+9pSerlSop/ufe3AUVDDz93QQp5SfNIvpjhU5IaaZjovLYjJC9UC35AUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDON1ntq32Z+6AyjhO7N6jzAbd7/ycw+wi8tKjCZj2k=;
 b=uWHp9S3k/4sqplBTrjmKopl7k8LtwP72OQ9TO3JejKkc7SVkGfALK+IH2YkcLe+53DXyCuqkUfTNWLo76wZJeFHnOGXStA/Mvajv11oKTgOonD4x33Ubdlnd5ktcv3jXLpiGrqGrk6mjQSwXJRlhZ2UdZdsTxsaMA72pWq+VsSNUoGpu8lgt+w/5ksJF9/tBcN6Rk8YpEPrmUHCOBpymJk0FxtLXsLVH8yDsGDLhuWs/MrZGi7u1BUwmx5AzlS9jI4h6jTv2SzvnYoTb2gwhz8lSiOG3amvYMGTx4kYAToN+fQVN4B+ENbqFW4n/ELatRiQ0xBu2CDteUqMDoMWi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDON1ntq32Z+6AyjhO7N6jzAbd7/ycw+wi8tKjCZj2k=;
 b=sas0i+kmMmmXejAwCSY0npQgqkNfgzxahhUjhy+1WmMo9Pj3+ryySN/qIh9IhLRV4PdOnYGL+s3gPX0g5LC1m3Zy4AL3p+Oms17uJZAN3v0zTa9MPwCd9M6oFsWNycSMx5f4W3TssxKbyNqzrMRA7fFlAhu9JPZhkKVTjt3/5PE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:43:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:43:46 +0000
Message-ID: <89705ef5-f702-41e3-a18b-db7d3b557f51@amd.com>
Date: Mon, 27 Oct 2025 15:43:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdkfd: add missing return value check for range
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251024044720.1971409-1-sunil.khatri@amd.com>
 <f8b2a650-ab29-40f3-9e12-2fdbdb287fae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f8b2a650-ab29-40f3-9e12-2fdbdb287fae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d7cc57-ffc5-4fd4-0137-08de15673b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2RURmorUTFkbUM1dmhEdnh4T0NHUlV4QXQzM1k5QXFNT2JyaXdnanh6R1ZX?=
 =?utf-8?B?TktFb1pGTGd5RS8zUHJNUndQZVJmQXZSeTRVODF1Y0dOalYwbEhKUnBKOVlC?=
 =?utf-8?B?WmpxdXh6YVVZQ1JjTlR5dDdDQkowZjQ5cTVLUDBrTmtvaCs2S21lYjdMMFVt?=
 =?utf-8?B?TUhJOFdJTGhXN09sWTYyVWthU2Rpd1M3NGo4dDJNN2lZcjVicGxGd1B1cEc2?=
 =?utf-8?B?WHNSZkZtRm9zU251SWp4d3l1UUlSVysybTVuVXVKMitPcm1vbzlpWkZzZUQ0?=
 =?utf-8?B?SXdsZDBrMkZnc0psdUcrRFZleFUxblFLdE5Nd1BCZldzN0ViMERhaklvcG9S?=
 =?utf-8?B?OXpOVWx1dGRnc2xabHhoZnhEbGRrZW5GZ0h5TkZPd2hpUGdYaVh4L2x5MFJw?=
 =?utf-8?B?T29mano2dUJxV1FkQ3BtL0syOWFHQ0JKVTlFMkxFdW9ieU53T3VXTzB6YnRt?=
 =?utf-8?B?UXEwQ2l6bUx1QmJRSHJNbGVnYVZPRWlZcU1NT2xsVzkwU0VxS2dackFJM0Qw?=
 =?utf-8?B?aG8wc1c2NFoyQUtWcnZmZDhRNE9YcFcreG1rdnN4WnFnUkFnTUg2SGpmRDNY?=
 =?utf-8?B?VmJ3Qzkxa0VrRGJYZE9TWXMwQ1g1cDl3a2RkMEFBbnBGQ1dKTXZuVUg4alVH?=
 =?utf-8?B?SGoySlVNZEI5RlMyTmJaNDZ6bDZMbjRiZTM0RGppVENzaTY3UHVLc1lCWVln?=
 =?utf-8?B?UEt2Z0dSbkZOcUk3MVhpVTRNRWtveStNZ3JieWFDTUhsc055QTdZRWo1Nmd2?=
 =?utf-8?B?QzNkWjlYMW44TDVVa3Q0b3ZYWnJuTnYreDVwU05kUnFXakJoY3NlWEJ6UzNx?=
 =?utf-8?B?WWtWbzdOZk9ubkJqdWY5c0dOWW1aYVBXSGRDWHVDTjR2OTFkaDFRY0t6RVlQ?=
 =?utf-8?B?ZERQZGNqclRFUkRWWEMyTjZWMUVQVDFmNTZFRi9oUTUxblkxWmFxVGdjMEMx?=
 =?utf-8?B?ZVB3VUtFZ0FCL01reVNwSjRNcHZ0Ui9sUmp2NWxTNTFjbDV3bDZpU1A3N1Jt?=
 =?utf-8?B?cFFjYmtuZHVYWnVTOFlZalNzUU42dzBBa2o0RmtCL3M0b0drVytBNjVvT0xm?=
 =?utf-8?B?WHJ5NWpNY2JpbFZTeW5EUjlmUkdZa1MvMzUyYVhlNWErSEpsSHBwWGlZVi9n?=
 =?utf-8?B?MlpZYTJSaEpzdXFRM1NLSlVvUEVlNnhTVW1zMlVvckZqY1ptT1RLVWJSSCth?=
 =?utf-8?B?YlU0UDFMeURYRURvTXR5VXFqNHBRVnNKZU9Gdk5PcGFQSGRrM2Fqa245NWMz?=
 =?utf-8?B?N29nQkJLekkxa0NhU3IydDI3MHNnOCttYThlSlIvSG1QN1ZGenZXdnVXd0Zp?=
 =?utf-8?B?SDgrRW90cFlrNFkwQWZNbjRQZE1mRnRGaXlQV3FsNmRQZ3cwS1JNUnFXVXFB?=
 =?utf-8?B?ZWovWDBYalA2N3BvMjlQNk9aN2h3dTR2U3R3cCtMNFExd0lOcFl1ZE5WalJX?=
 =?utf-8?B?L0dBWCtXRDRVWndHVyswR3JZZFdvazZpbzBQR1FJK0I2NFNUSXNnT2RWSjJr?=
 =?utf-8?B?eElHVUJJMDBrcDFXejFRZHhiWFF3MlZraWNXdENhVDNxT0NZazhzc3pvYUpF?=
 =?utf-8?B?RzR4Zy9hS0xCWGhWeE1vd0N5Rm5lU3VwQlRvZnJtZUo2T0txTjl6NFdWeU5Q?=
 =?utf-8?B?VkYrWEw1cG1nQjkxQ3NObHE1MURUTUFTNHRjclA2Z3pGQXhMMVoxRjlFUGcw?=
 =?utf-8?B?SEdERmMrbUcvenpocldCUnV5K3ZTSVp0R2VlalovZXduTjVuK01mTjlPNzcv?=
 =?utf-8?B?VFF6UENhcGJsSFVlVjJQL0wrOVZpMVhQV0FDRjRmbXYxRmgxcUdXU28waS9P?=
 =?utf-8?B?VTBDTSsxQVgwaThHV3ZEQWJrSTI4bXFTQzRQNURpMGJmbURzUEM4ZDVHaGtJ?=
 =?utf-8?B?WlhZSW44QktMM29CNzYvYjFjdnorRXA4RHJrM1NkWXB4cUhucHA3ZzdmdG5h?=
 =?utf-8?Q?W8Z7y65JI+jMFXNMq681QGqbGBkEvePb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhnaGxxZTRkNVdTWU95QWxEMDl2NVV5UU42S0Q1WjVPdStiRDkydlZ3QjAv?=
 =?utf-8?B?cWk3UDMweDNpSlF5NCtRZkRZU0ExajdoZjhLZm1tcFhJR0FFZUo2QXN0RXpB?=
 =?utf-8?B?N3JuUjRpb0ZWcExwczEveDRQMGpySU4wbG9UYVNnakZLQlNQaFl5dUo0eFVV?=
 =?utf-8?B?MUl3UFUzQVZ1MUo4TysrVmNnWXVZdXBKakFvdCtkU0ZmZC9CVTFNRTRQZ2lw?=
 =?utf-8?B?L3BYTzBrM1p0VTBFRFM3RU9lcEJ5eE52UTI4OFc5TE9HU0JyVFJMdXRNV2hN?=
 =?utf-8?B?RHlSZjBkWFYvQWZ2TmZCSFlKQXZydGhsVGIvVGJxZUJuOWpxWXhmNExTRUJB?=
 =?utf-8?B?RVo1N2dXbmJkL21HZzBEeXExMXd6MTlYRGlrTm5rSjl1RnFpN0JONHFjb1lJ?=
 =?utf-8?B?d2xqdjgvN3pFdUliRWJXNUJLbnRKTGVhVzRGMlhaSkhPdmNFbWxxUkV6MG1E?=
 =?utf-8?B?OVJaeU5SdVlpOTIzRWY4Ly9aaGN3bEo1ajlOWlJJMTFZWUxjR1JBdUtVckJX?=
 =?utf-8?B?c3VRdThFMjc2MDhzZlJhcWUrK3Y3RFo1Vi9RSGp4T2hpNVdEdTRlc2FJSGd6?=
 =?utf-8?B?bmtsZy9OWWQzZ1lJK1dGMyt6dmpJdE5xNEFpSXBQQ2NsQ05jczh4QlFvSG5M?=
 =?utf-8?B?MlNEODgzeE00LzlQR3IyY1VleGtrR085aVlrQStRVWZPR3BBSzhLa1VNUjJo?=
 =?utf-8?B?NEtOMVJZK3FmS0lSVlIwVEhqSHk4TE9SNlZ6bHlUa05VUkFzSWJvWjQvSmdV?=
 =?utf-8?B?NXZreWFVbzZrZ0EwY0ZOMXJPMUlsWW1DLzZjU2NZNTRkWUVqaE9jdnlPMEE0?=
 =?utf-8?B?QlRBeFovaUJEemdVdGZ1TlpKdjVUd3ZpK0FpNmpoSzdXSENWVStkMEhvS2d5?=
 =?utf-8?B?aE10UC90cmgvLzBJOWQ1V0FRN01CWEI4aTROSFpFU1BTWiswOGxBNWw3UnB3?=
 =?utf-8?B?NGpiQUlRMEsyM2ROWk1mcDhxblhXK3RKZmhVaFM0QnBQdVRnaDZaN3pCVXRP?=
 =?utf-8?B?b3Z4bm9vajF4SEdmTTAyRG8vVWVuOVR0Y25jVm1hcWxNTDIrWnRHNXFITm9j?=
 =?utf-8?B?WVJ0Tmk3VHpncDhqMEZTQU4wWkNnSGVqTVdRSUFUV0U1bUJQMXVweG5XYzhE?=
 =?utf-8?B?cFg5MHVOaDZrVFhOZ1J1aVFDM0dyczlVY1FkaTNvS3JmcTAzZDNVb2svQUgr?=
 =?utf-8?B?MGxBQXNwZE55USt3MGNWZExjcG5sb0gvNFRjc3NTb2FzL05Bb1h2MWRiS3d0?=
 =?utf-8?B?akNJZlQ2OEgwN1dzSVY4OEJNSkdabmJPbmM4cGVDZ1kwM3I0MnRZMkg3ZnZG?=
 =?utf-8?B?bnlVbmtVcjEyUmJtS2c2T0g0SzNXdE1TR0pIdGt3ZlNkeHFoajdQaGd2TjMz?=
 =?utf-8?B?TVoxeS9QdkJEaWZmWUtxWGxsL3c0V1FkWmxRTWsxQnNSQWxTRXZDUlVYOVJh?=
 =?utf-8?B?bVdhT0dwSFhZcmh2SG5nbVZnWDQ3S2o3cWZ5UVE3K3BFWGt3WDJGc1FmZXl1?=
 =?utf-8?B?QVFLNERWUVNBVThuREswdzNraUNLWnVqNnYvTzNpSHB5VmR0b0pCVE85RGpa?=
 =?utf-8?B?QXNNUllUdm9GTmt1RG5PYUJndE1NRlNuQm1GZjVqckl4ekdrbWRrbTN3Qk1m?=
 =?utf-8?B?eG9aRUVXeGY1WXBsbWxxbjRFbXZHNXRLOWhPSDBJai9WcTdzRnFvVTdneGU2?=
 =?utf-8?B?cE9wcGxwUUVXUnl1VDBmcnFlOUlaTG1HKzZSaHBtUnBTTFNmNTFCZWttWldG?=
 =?utf-8?B?ZiswODg2ZkhZZDdUbDlPaUtLU2RrYUlsMW5YK2R2QUl1c3JoT2tBc1cySkhs?=
 =?utf-8?B?NVRMYk80WVMvYWIzcXgvWXFTYUJXS2VYV0JWc3I1VUtzUlNuYU9PTnRIbkg1?=
 =?utf-8?B?dFRjS2JLNUpEa2s1Q2cvWWcrVWNZL1dCMS92dHdvcDZkeGVMckNaNG5QcGY3?=
 =?utf-8?B?VTczVGJoNUVKQ0szdXEySndiS1pFZU9uUTBIK001UlZIb3JPNWtrb1NjdGRr?=
 =?utf-8?B?MldGdGYrVStsRXBDWitWQXdubnEzMzJvU2s0UzdhRFBPUFlMbWpMWDU3RmMw?=
 =?utf-8?B?WGZ5bzA4c0xlT3dIa05COGJ3TWl0eFFVdzZMWDUwUDJJck4wSnJiTEtoa0NT?=
 =?utf-8?Q?X4JprR6GlIoVE/Q+uIWi1HWKy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d7cc57-ffc5-4fd4-0137-08de15673b7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:43:46.1145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AVOsZAiVJuQMUFZl++rMsqpFnQIE74Z/0EWUaARXLFae9Z2H9ZErM1dLhfB033o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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

On 10/24/25 13:09, Khatri, Sunil wrote:
> +philip
> 
> On 24-10-2025 10:17 am, Sunil Khatri wrote:
>> amdgpu_hmm_range_alloc could fails in case of low
>> memory condition and hence we should have a check
>> for the return value.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index f041643308ca..bc07aa3af2ab 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1738,6 +1738,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>               range = amdgpu_hmm_range_alloc(NULL);
>> +            if (unlikely(!range))
>> +                return -ENOMEM;
>> +
>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>                                  readonly, owner,
>>                                  range);

