Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9A0CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 20:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32EE10E19D;
	Wed, 22 Oct 2025 20:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A1KujHkI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A90510E19D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 20:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AurbiPjeU+sLdtbtaoQIfPZsQIhXBHSKybrvzJZiYF9kSiCV9QWfbzGAJlhdY1RgMxwcceySq7OycNheUpZJU9/NOA9SXLa+CB0fNRT0wvv3a9o9mm6q7utJdnIIhgjOlGATA+VtQOb2hczO/VUr7wY8Wv5jsSSWAd7y1Dt73gEA2JtLDfFQFG577pRUz+VCLZzvmeWvFQev03fw+0sAcvJpWLFT+9l3GBRMqWd4qLMf1ML5eY7dTfFCo3AN4N8ydPdL2dQquJ9cLUZkd14Otor6ybxclT/K7I1RZDNSdm0nfDxHqQtcOc58R0CuJ/DZS6RqG4nFNEEPyTkvNhuZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbrXCPKxOPbubcXn58CbiggTx7pFCFkCvsjniR+vbmk=;
 b=QeeC/hcZeGYsnRT5pVoyzMYulm20BBT3ZBZAOq7pxE7LGfQq+tm9BZSbS2ywOXnxsX27EPh2gKCuJ7DVhSAa1SrSKd7jlaN2lVj2Z5vqKtH13vjFiBDIwydVH079hV3aZGdWu0S/oU3QivWuk8GMWiasV2sM/VbGgXbmfhZJbr8in0l2aoc50L1u5P2i2tMf0MEnOtpYWk1fbLxZ9BGmPt/nue36NbFt49kDkahk6jSR3d9EF6GwE/CwBNcgs3dUw72ZFwQaiBOprWmtVzhVv66qITyBpniRqgOknZddp+uzPxTUHYHJKJJAejaRuSjQkTykNtPb/9s+k8/SM9IuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbrXCPKxOPbubcXn58CbiggTx7pFCFkCvsjniR+vbmk=;
 b=A1KujHkInsk7EldDJhY/oBUNRfq9nYy2Ihn0j93Gp9Hg8gWsa0ms9cW5F9zbYykbZpSVxgSsQaPLeXB609mQCjH0YoAgS/wDKxgTs4yjzg5CnG7PMe0JRHTcPbOmMl9K80Z3A8L3958pywMMHcXJApCKGKKFZTSg3gFnf0ji0N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Wed, 22 Oct
 2025 20:44:28 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.014; Wed, 22 Oct 2025
 20:44:28 +0000
Message-ID: <de6957ab-566d-fcac-36fe-7ced224f98f1@amd.com>
Date: Wed, 22 Oct 2025 16:44:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
References: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
 <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: cf67a3a0-a37a-4f50-f07c-08de11abcb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0dVamJ3RFF0S1c0MFdvOVBsNVhyM01HbzZQMjNNcHZwRjF1R3BTaXNGQ0tx?=
 =?utf-8?B?bE51YnRiWDloeEpLdFdCUTNNVnRTeDNjTUxnVm5XQ1dmUW05Tk9qcUluOGR6?=
 =?utf-8?B?S0ZWRnM1dVd6Q25wMVdCTlY3aVJvdkNOSW54NzR0S051cXNSbE50VGNzSVZH?=
 =?utf-8?B?V1NVbTdGV1JmUGljaVdsWEY2Y3pPZDlPenBFVDBQbTFVUTJ1Tm9Bbi8vQmFT?=
 =?utf-8?B?Mm40c25PZkdtM1NWWjJYUXpUOWZPbTcwYTd6RlpYQ09Zb0hkMXZSSVJVTWdC?=
 =?utf-8?B?a3lFR0c3Si81SHhtNms5NUpWT082MFBwNXVtTGZLQmtxZ1ZIMGE5MTB4VGNn?=
 =?utf-8?B?UTlmWVkyOWIrNGZzcmY5aitzS0FoMk8rN3N1VkNFL29NTDYvRkYrM3Awcit6?=
 =?utf-8?B?MWVWcmxJdGZlbG9ya2dZaTE5ZXNLZC9rNWpVWWlHemJQMW1JZVg0NmRISUUy?=
 =?utf-8?B?M3Zib0ZMV0cvdnZwM0xVSFhNWVhDQSsxMzVSNkNWTU81UVNTZzdzUy9QRW9L?=
 =?utf-8?B?OUU1bUVRL2tLTnRIREd2bXloRXlTZ3Z4emRUWTlNVEM1SU56aE5HcFY4N1lo?=
 =?utf-8?B?Q3Y3Q1dBMFZtaXdYZzFuTnZYWktNU01iZXI3MlQyN1k1SGYvR2xhOUlSMXFV?=
 =?utf-8?B?NUhnVWowMHNNbzBudTZJRkxLVFphK0FqVzA1SGIyR29xTitoUDFMZ1MzRUhK?=
 =?utf-8?B?d1BkTkdkQWtEWE5OUXlERkNldkVtY1c3d2FNZE90NHU1SzZWNVNrV3hpZWdN?=
 =?utf-8?B?V0ZTSlNJODhEVmhTMFBHOXc2VkRoQzR1TTBpeTluUFE5dlY0TVlvRi9BMTZU?=
 =?utf-8?B?QnlMYXR3dmM5TFpGcUFibCtOYVAwaDVyaE44QVBrRnlaVE0ySDliK3htYmJ2?=
 =?utf-8?B?cUZqbmdkS2c4a1lybjR0RG50RnU5eHhMRTMrY0RmS1pyN2R0RmNiUGRXZ3B4?=
 =?utf-8?B?ak4vdTBqWHRtaWRhRS9hY3hoL0RLdHNBOUhlWGxRUTZiZ3AvakNYdW1WLzZR?=
 =?utf-8?B?clVxRWhpZmk4QzNySGlkcVFjdnRSZEpNQ0FCWjBKOHZLUUFOaXhQNzU1WGJI?=
 =?utf-8?B?QWptL2RxVmdDbkxvWGpMSDVXR0IxYjVKcTZlYWgwRmZDQWVTcFFUOUFFVXoy?=
 =?utf-8?B?Zy9JcU4vdWZmZnVBNW9JdmVPV2VsVjYvOXdURUR3TVZtem5RdmVGYU80czFW?=
 =?utf-8?B?NlFBU0JxNXBLeXBRcy81NC9rMUlFdG4vb05VTUowMVczVXQ1dXBMTFJnQVBO?=
 =?utf-8?B?L2VMcCtuOXZiSXdLZ3pHZ0ZNVkJuYUY0TEgwZTZucGpVM1NSRW83akNrckNp?=
 =?utf-8?B?Q1lvbW55NzhOVmtuZ3plTjJLWHNiWGZHNWIxaHhreFl0U2k5U3NKZGFkL1Fn?=
 =?utf-8?B?UHZSZE55UUFlMDBTL09pTVMwZCsrWEpjbjlMRzlwd3ZpSGlmcmRZSy9oSGh2?=
 =?utf-8?B?WWt6aTVlRFp5SWlrZzRQSUo0aHBpZ3U2ejVneGxyNzJ0ZWFwajJjYzB2dmFH?=
 =?utf-8?B?NVB6cnBzZTZaY0lLdTNScENJT1gxbTNXVlJncHYwRmNrTEw4UW42OWx1Szl0?=
 =?utf-8?B?NkVhcXlqcHhrMVdic0tuUklkWlRwdUdXbWs1RFR0NVVxUktkc0VHR2NHbnRO?=
 =?utf-8?B?ckdVUityajFNb25WV3ZweXBNZTl5ZktUZ1pxdGVVNWw1TnpkaytZL1lNUHVx?=
 =?utf-8?B?R1ZYUEp6REZsVFZ1N1MyUERJajRnY3RXMmM2YzhMWFJjVnNCM2ZDUkNER2d3?=
 =?utf-8?B?VU5GS3VHODYxcVZFWjkwNUQraS9qNytVL0NSTStZbUN2S1pVcVYyMjVpMnBQ?=
 =?utf-8?B?VFhndEFTWXkxc21wTXlDelBiVytiVHFudzhycmZHdjhjd0RUcDBEUHEvbFlJ?=
 =?utf-8?B?cURvY2hVbE0zQTFlSnUrOEtDUHp1KzBKQndkMzVmSElLSTdOMlNONm5Cc2M5?=
 =?utf-8?Q?Du2oe9mW50KeiWJ6rqw2h4lJ2+2dvLcW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVVKytPaTZQMWVabk9UMG1aTmRIaWNVQ0tSSi9NcnZpNWVhZ0V0L1E1cVFu?=
 =?utf-8?B?cDBtNUxZRitNaHB0dy9ycTg0YzQ2VE1GTE5vckpKQzNJQzdiYlovWG4wYnhR?=
 =?utf-8?B?OU10UmJBeWF1Tnc2eVp1ZEoxcVpYVGtadXkxMmEzbFlHQVhTaTdteU56Z1pS?=
 =?utf-8?B?TSt6eldiNXZJeXNTNzhBMHJ3WUxuNjlqTlRmY1N3S2NlaWRSTWtSQlVpSjBX?=
 =?utf-8?B?N21oNUIvUDZxbi9JeG1EUmVST1dKVGJjQi9PcXhHZ3FSUHRmdW5QM2srY3Js?=
 =?utf-8?B?ZzJldHdoYUFUbUFpWllVM0JjY1ZrbTVWY1lPOGJOOXBzWjZDOVkxYXFPWHdV?=
 =?utf-8?B?UnJ6MDNibGhqLy9zZmN0MFhoN25OZDFmQTFlaXB3dDdLemlKZFpyNDc3NGxS?=
 =?utf-8?B?VmYxc2hXbExsaGFtcis3L0RzMWIwblplODdzcjhOaEdnd3FvWkRGMVhwOWFl?=
 =?utf-8?B?QnRoUEFURzlBYTFxanRkUlFuenBRMUhYMnF2dDJ0WnNYQy8xZlFCdnJ3RVJr?=
 =?utf-8?B?aWhYemlPQTByOTRHcVF2WnFUdlNGTzVlUlRKZFI5K3dzR2N0Y1B1bUlzaW9L?=
 =?utf-8?B?VjdHWm5qcnlJL1pTNndXUk1SY0NLa2Nra3VhKzRrcGV6aWc0T3ltRUh1K1F1?=
 =?utf-8?B?NDAwaUcxWGg4bTMvZmJWaVBLQW1zTE9NTTJ3ZmVrSms2MDROcVVnSnp3MFdx?=
 =?utf-8?B?THRwaUxSQldmRDdoYUZNaTE2ZG00MHU1K2RqMXFWbDBNbGR3dnUrN1p2Q3VC?=
 =?utf-8?B?TjNPQ2FhNms5TFJOSTZNQXpvQnFwTXhqcXdHQ1FEekJqV3dQMGhIRkxhOFdh?=
 =?utf-8?B?SVc0Q1ZXcDlaWDBXZHk2eEI1elY4SEJ0WTNxc1JMb0FCV3VrNGsyZnhnOG9C?=
 =?utf-8?B?MjYva3ZnclhCQ1VJZWdFYjViK2ZQOFVPaHVnVFNxVVppTStZblFHaHV4WUtx?=
 =?utf-8?B?eEVRaGM4czV1SFh6TlhFMGNkQy9UZXlsTEpUR2p0T2JNTVI3WE01bG9Wbks3?=
 =?utf-8?B?QU5iWmYvbk8yOUlSWVlYWkY3RisrbnpDandmNFdCSm1RQU5JNWZucGl0TWNk?=
 =?utf-8?B?bmxCaDZDS2w2bTNRa3JLU1NWZGdoS0RzdnhYa1I1NEtpeHV6Y2tvM01idUEr?=
 =?utf-8?B?Y3pSS2N2SXpnSW1iQktzaVFzTXRtRkVqMndiVUhjS2NOdGxPcVErNkgxTHdT?=
 =?utf-8?B?T1ZhNmdBM01qbUdpSUVvSkw1Kzg5WklGbTlQMWd1bm1KWWpYSHRlZTdCK2Ni?=
 =?utf-8?B?SmhjK2FneXZ2WE9CMVhrQmJFQ3FiTFZsKytvR2RGTEIxQnhoN0ZiUVZXSEdr?=
 =?utf-8?B?M3BtTk1UV0RIRjBPcTlTWDRyNEowL2lIdm1ZYkRmZGRNclZacHFSUERaYjhx?=
 =?utf-8?B?bFg4YlNLa1BqaEVtVzhicmtFaWFhVHhYYXJOaTI2ZTBVWkRPRDN3Z0doL3hR?=
 =?utf-8?B?NWZLQ253c3p2QjZIM215dmo4eExwTmtuRld0WHFXdXhTRGVSSWx6eXFUNTB1?=
 =?utf-8?B?Y0xDTEhmZDBweEJ5Q2tvTjBNZ0cyVjJmNUExOExuRytlVnExSE9td1g1S244?=
 =?utf-8?B?WGo0L2t3ejFrNWNQRi9tMnZaMXRQa3dGS0h4RlhlbE9WcVIvZkIzTnNwR1N0?=
 =?utf-8?B?Mms2cnUybXl0RlV4dXcwdmhjMTdSeGVXSWs1OWszK3VQNjlPbjRzSEFqMjh4?=
 =?utf-8?B?cVlRTFVmcnJlNTVFNHpac3JJWit0cGlRbWllOE9lbFhIM3o4N2xiTzhHWDRv?=
 =?utf-8?B?MnZFK2pxRTY1aFpyUHhOTG1LMmRxdE1LWmovNXRoQ2d5SVYxTUZnWU9Ia2RD?=
 =?utf-8?B?TkdBTEJ2S1lBQzlqcnAyQ2w3YVczMjlXVXkva0c1eExvaE1mYUFqQnp2akFn?=
 =?utf-8?B?a0llTmk2UTJXRWtnZ050em5LR2dQVEJxUERJZXlSbWluUWZHeUFlN1JlWDdo?=
 =?utf-8?B?YnY5QWM5R1QrQm5rbUM5eVBGNG1wNGlVQlpRd04wd3dkRE5XQjZxTEVadUkx?=
 =?utf-8?B?UzJFU2pacTliNXdETGhoOTQwTVYrc0ZKRXRyeUVJWkQ1VFlTbklXMUhtVnhQ?=
 =?utf-8?B?cjNVSHNFRXBUb05mMG9TNHVDSWpNQncxL2tUZnR3UXZaQ3N4Zkw4S08yUXNX?=
 =?utf-8?Q?yb20=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf67a3a0-a37a-4f50-f07c-08de11abcb5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:44:28.3941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lOvriBs5CFTFix4TWp3vF8SrVtSpBHqkH7CGDRO+VhrdAkXDe0XiDk650d00lSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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


On 2025-10-22 10:25, Srinivasan Shanmugam wrote:
> The function svm_range_validate_and_map() was freeing `range` when
> amdgpu_hmm_range_get_pages() failed. But later, the code still used the
> same `range` pointer and freed it again. This could cause a
> use-after-free and double-free issue.
>
> The fix sets `range = NULL` right after it is freed and checks for
> `range` before using or freeing it again.
>
> v2: Removed duplicate !r check in the condition for clarity.
>
> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f041643308ca..c057d892dea6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1744,13 +1744,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r) {
>   				amdgpu_hmm_range_free(range);
Guess v1, v2 patch sent out by accident?

another double free range->hmm_range.hmm_pfns, inside 
amdgpu_hmm_range_get_pages, if hmm_range_fault return failed, 
out_free_pfns should set hmm_range->hmm_pfns = NULL
> +				range = NULL;
>   				pr_debug("failed %d to get svm range pages\n", r);
>   			}
>   		} else {
>   			r = -EFAULT;
>   		}
>   
> -		if (!r) {
> +		if (!r && range) {
the range check is redundant, !r already means range is not NULL.
>   			offset = (addr >> PAGE_SHIFT) - prange->start;
>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>   					      range->hmm_range.hmm_pfns);
> @@ -1764,12 +1765,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		 * Overrride return value to TRY AGAIN only if prior returns
>   		 * were successful
>   		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> +		if (!r && range && !amdgpu_hmm_range_valid(range)) {

Is the check reorder necessary?

Regards,

Philip

>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
>   		}
>   		/* Free the hmm range */
> -		amdgpu_hmm_range_free(range);
> +		if (range)
> +			amdgpu_hmm_range_free(range);
>   
>   
>   		if (!r && !list_empty(&prange->child_list)) {
