Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F6FC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E55110E5B0;
	Tue, 22 Apr 2025 13:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkyWk1yO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D0B10E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB0RmOAwloYtV/FWltwkVBxwhrkes4dgY8KQk1ZnFknoZmdL5sfIswo9Jfx2ZcnBSXcEPU8Xza1cbcud05bakJITApoW+Vex9mRzb3hHy8wnkeqp1QSoX5KRw3BRwt1nkDArIzB7l61guDZ+Mb+SwSTAKv99PYWoOq/DdHnKqQStERHC5iAMNdHSzDtfLDI1v1p+iW8tZcbIkDRWdain9vTk+M/+lOWbTpUEQwE7Y2blxJQXwL8Kf6YQwxZrBZyJL8atcySOuWoOal5Z5mzoVyt0Ov/BNBxhcm3SyBp1a5iVnvKsk13e3ppkK5vftqZIl1ZKNUuRZrcRH0Te9PQvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5b8FbmjXz38x4P4RGeCWnUK8D/MVigKqjzJaFIIW9w=;
 b=AjiTxE0A4x+Jblp3jxthNoCCftBDNqAvh2IbO06xHDEN2RSB6zZu9fio7D9lr7tMb8C/z7fWi+S5ICn8sqqOIACYQ8vESJ1sVf+qAH/nSlkMyKszD4FOlfotV/A3KFmOldzLid90/hdz1wIFJjPRNTCuKv/MvJYpcH3v9BGBgijSavmlR+RNeLDg5VOQufkvBaxG7hAMs/qH+CxECrnYEKt/T4/yQk7p2sIEBqaQHmoZk0jCj0/rUmMFPakvo9YQyMQwf1+5mMtykiC9NQr+qsqUa4DNZw7HOHRzIaumRZsqGqGABAWMRmBQK4wXMJhJAoQiqmN8RWZebgmQZkDwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5b8FbmjXz38x4P4RGeCWnUK8D/MVigKqjzJaFIIW9w=;
 b=NkyWk1yO+rf3rbthLjaAatIuIe5yb8tdYQg0DPaaKtCVZf3mVM9kgRTGPRTyb8PzB8uWPBZlteX8B+wiMX1QRiKVl8KNk+TVBx51chWVwfgqyBJH33s5CQUnfoCHdE3fJr4HyCMDUiIXaIl1yUJHZnKOKQtqNQ7mmtRbjSlKmMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 13:42:58 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 13:42:58 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: add the evf attached gem obj resv dump
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alexander.Deucher@amd.com, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250422132352.3988185-1-Prike.Liang@amd.com>
 <4720bc65-7c42-4924-841e-277782290eea@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <fa730c3d-0c83-7fa1-d631-cdf6383e7cad@amd.com>
Date: Tue, 22 Apr 2025 19:12:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <4720bc65-7c42-4924-841e-277782290eea@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::11) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3526e7e3-0c38-44b6-3f4f-08dd81a3977d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFVSano4empwMDlxM2dQNEY2NmtlcW5WQlRiUVJtb2RuUDJiTUFobU9rRG5v?=
 =?utf-8?B?QWoxRzlqUXlJS0ZHdStKc1RnTXhVd2RPVkNKU0pxY2NwZmFxaUp6R2JjUm1V?=
 =?utf-8?B?R3JYUVlYYXJLT3VYbmRwR2lKT1NPZGpJc2lpSXlsVXRQeDZnQzRiUit6NkpQ?=
 =?utf-8?B?MytuSnZJUWFGZGtwdUwrdG00b2l4b2MyTDRKU01lS0lrQWZTWDI2M2I2ajlH?=
 =?utf-8?B?V0hVWVpFcnBRcDdEMTMyaGFKVWg2TElvcHFGMkVaOC9HUDM3ZWJtUzlLODdj?=
 =?utf-8?B?QVl0VUJMN1dlU0x6Mkp6L0dXczIyWjBwdkxGR3V0MGt5UUVWQ3ZpZllQbEF2?=
 =?utf-8?B?dHk5V25EN3JRZW5GQ3ZzcG9mMU5JZ2M5bUVjZGlhTW9URmk3RHR4VUVrM00v?=
 =?utf-8?B?aHAzWWdRL1RmSHM5Q1QxVExoVGFDbXYrY1hOVDJnRlN3Z0ErWmZ4WndIbXRX?=
 =?utf-8?B?Q3RmMkNLcEJobE5iOUpXSWtrTWxycmZtUE1uVk8zU05ZQS92aGZHM2hBdWZ2?=
 =?utf-8?B?b1djank4VjEvWnpWSjRINmRJM2xKTDdidlJ6SE1yZTVRYjZXZEpkdnJwNm1n?=
 =?utf-8?B?NVE1czc1Q2MwSUZDVHd3NnYrVGtzTmN6ZWM4MkwyV0tEK0ZYUzJDNStMQ1cx?=
 =?utf-8?B?bGIzYkIzajhRYUhqR2JlSlA2NmlvRjRnWlFDUWF3WEJSU1lzbDBFVGVFNHNT?=
 =?utf-8?B?U3RBVyswRGhINkdLU25GaUNhRENXam5Nd1dyQTdUZlJoWlNxSTFMdlNnZ1Y1?=
 =?utf-8?B?aXgzNVo3SSswTWtYdnZ0bGh5UFdWMnBJbUN1bjJIeVhWcCtpU0psc0tURS90?=
 =?utf-8?B?SGdUZ0NMRnFqZlFhUUlLMDBwMUp3VGVSdi9mbmZZRmpqRUMySGVEK1Y1anBh?=
 =?utf-8?B?bklyM3VjNEF3UXFCV3RZTXZDQitPbTBPczYrVWtZOGwvMnFRQWJiR1lVZ25R?=
 =?utf-8?B?Wm1mQVIrZ0pxSG9veW1WbFpYWHo2TU5TdXRMRlM0SUNDV2s3TyszaEJjaTlB?=
 =?utf-8?B?MitOZ2lHMk5pVEVsNElkWmdLVDhQSzJlZ05kT1hFZy9iV2JkZkF6N243SGpK?=
 =?utf-8?B?Z2p2TllaTnkxeHcxb3NDam5UUE5HNmpFcC9yOWhHY2UrcTBkRDIzdUkwejRr?=
 =?utf-8?B?UlB0a2wvb25EUXg3YnNnS1VNL1VDbzFQMzdvM2NxZnhFNlY1YUFQdkc0QnJp?=
 =?utf-8?B?dXIxaGgvQi9Cd0tiUG5JNFJUNCt5SjgzZmk5Tk1UeTN1ZlR3WmZ0K1BvWk93?=
 =?utf-8?B?WEpvMlBncElGWmRnbkRCeUNwWDQ0R0piL1JBVXVGTFdlVU1RMHcwT2dHL3BH?=
 =?utf-8?B?MFcxUjIzYy9sVHE0OEp4WlJFRklFdkJlc24ybDJKdGVCRk1lelgxRkY1dTNp?=
 =?utf-8?B?NlFqTGtsNXREY3RFUmNBdDY5cEhoRUQ5cDJoZklpR05hZXBMRWpldmRJMFF5?=
 =?utf-8?B?OTlFVU9Ba3pGZTA1eVBab3RsZ2hJZm9zRDd0c0hQMGlBMGd4eXJmR2ZIelBk?=
 =?utf-8?B?UE5TZllJWDlCM1p6SkRyS0Y5dm10MXUvT2ptd0xTRVJ2RWZXN3JvRHpSdkJE?=
 =?utf-8?B?MVl3QWNnemtjczJMOXA1TEFzaHFidmJlRExpNmRlc0UrYU1YRGVYTVdUNnZG?=
 =?utf-8?B?VHhJOTlFUVBsQjhvL2xTcGVrUXF4cklUMlFXV2k3K2JlaDFCbm0zN3luNkJO?=
 =?utf-8?B?VWpGM250N2RiQk9KaGRTWVhaa2ZvdElqWkJJUFNxcFZDOEFodTUyK204WjVG?=
 =?utf-8?B?dXpZUlRJNk9tTmdnVzU5d3kxTlJJdlJ2OGphVHZIcWRHQ1doM3NXMEpEMUpl?=
 =?utf-8?B?bjFFTU82SVRZTHRDT2FSRXU3K1VjRkszcmtGVG9XQ3pVZ0I4R1FhakE5VlF5?=
 =?utf-8?B?WjZ6NkdNVVBtbHh3YjJVMEVpcjQ2Ujl0SE1QSDhVcXVUSlpzdDg2MWdXTjRE?=
 =?utf-8?Q?Prt286Pv/dU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJ5YVFscTh2bC9qc0Z0dlNUdDBPdjhkRDdXckwzYUtjdzZZUnJDZGRwU3pj?=
 =?utf-8?B?TDlGZ1Qrc1YyTHp4K0hMWG14N0R4Y2gvcHZ6T2FGNHlwZnQ2UEppZWd3OElZ?=
 =?utf-8?B?NUVxQW1MRkNDTmpjdmVGVWs2OWxHUkxkYUZrTkdCaHRoRm5BMlJqTW0rbFBi?=
 =?utf-8?B?RTlmL1RXLys1WkNOdXdnOU4vTDBTMlVBd2o4R3RZOFRkOEltcGxBOEJQby9L?=
 =?utf-8?B?NTBINWpXVTdhTFhQZ0ExVDN0VFJoTDdBejJJOENBc2grUm9VVmc0aUF5cmdX?=
 =?utf-8?B?UmVsZE1EeklBdkVkTkhRSWNETGFCSFd4dENiSjJ4bEg2SWcxc2cyTDVndmtK?=
 =?utf-8?B?Rm0xZVRtQ08ralFqVHRBTW1NWG5acFI5SllwaXlFWXgyb1UzNUxESHIwZ0ZQ?=
 =?utf-8?B?VVFObHlsb0hPSjl0T21XT1BVa09yNHkybnkrYUtydWdrRDhoNXE5QzM3eS9N?=
 =?utf-8?B?bWcxQ09Yb3c3U0VDODVKdWFKNFNpWFBqQzRDOTU4Y0h4cWk5ZlY4b1FDbmhu?=
 =?utf-8?B?cGRLVGJoOE9zbXJIdlI4VUQzZWxUY0NDS01pMG9PK2hzRXlXc29GZGtWbHVF?=
 =?utf-8?B?TjBkak1uZjNNVUI2a2diSnJlU1UvZFVKcThvZkRQWVg3b2RXS1ZTdTZxZDdh?=
 =?utf-8?B?VjQzbnBKRkFOei9OdThHS1Vkb2l2S1Y5Snlhdks5a1ZwNDVIb3M2a1NtWERu?=
 =?utf-8?B?UjhMOVNqK05FYldOaTRzM3YrVzFrU3NhN1B3ZjNWMUJtNkg3aHRXcTFqdXJi?=
 =?utf-8?B?dnhsL2w4Qkpaa0JEWG1BYyswcEhoYS8vK2M4V0Q3emVDYlIxOXU5S0tqQ2o5?=
 =?utf-8?B?TnF0TldQNFdTdjVEUlFqNDMwTnpmWmtzV1E5L2E4bjZodjRyU0l1RStTL0R6?=
 =?utf-8?B?dmkvemswaXF3VUVkT3FDMWpVemVzT0tZZTk4Sng4R3VUc0tQaEQ3SzQ1cmRX?=
 =?utf-8?B?UXJwemR6Z2tDZXVSUTR3Um5tTGJpT2dmV1lSOVhUSVZiOTYxNFJyb0FkSDAw?=
 =?utf-8?B?NFkxWWhwNXJQc1c2QjZ6RUJxK3picEpDdXJRbkZNcnZlRW5OOWE2MEpTcDRv?=
 =?utf-8?B?WGcyOFVFZkRUcS9VL3lpbWJBRndnb1prSHl3SEM5bGtydDJrZloxWjFZRGtO?=
 =?utf-8?B?QmMwZ0ZiQUZPN3FFWXJuOG5sV1c5NllMbmUrNFo4ZEtCMG15VHFOSjk1aElL?=
 =?utf-8?B?MzZtTllkdXVraXlqT1F0WXZDRUNTZnBLRElaaWVvSHduc0ZIenNBVGdiZEhH?=
 =?utf-8?B?VHMzMXRzZmZONlFGOEpPR1A4a0FJdk56Sk1nSWY3czkrT3phK1VCQWgzdG9R?=
 =?utf-8?B?ajNxaGRpSWdUZy8vcDM1Yy9sZFYrUWRpZnpGUTN6SFZ5WjR3U3Z6NlBiekx1?=
 =?utf-8?B?czc0WGJ6blZUdVZjSFNKUVQ2ZTF3ejRPQlRKSGI4RU1VQ0dKdXFYN1NFbmVN?=
 =?utf-8?B?eGwyZ29TcElEZ3MxbEVXNVVnREgzdzdnWlFSWkZZUk04RWhXTm9Qb1graENS?=
 =?utf-8?B?YzU4YVhhY3BXZUk1a01GY0VFc2MyMzBZMnlZa3diMVhOeUhqNDFialYxajlr?=
 =?utf-8?B?UDQxZ0ZDaVlZSWRMdG5DRVBDVHAyV0paMHNwV2tpRkpha0Vwc3NJZXAzbEEv?=
 =?utf-8?B?cmdscXlTTisyaHhrY05EMlRWM1EvdStnNEU0eTZUdDZTZnZXMSs1enNHQ3B5?=
 =?utf-8?B?TUx3bE84UFBjaEZCYkxCdzRNejh5T2RjemtaNExHQmNHWDJjVmtMSEJTNFpR?=
 =?utf-8?B?ZFBheFRONk1QUTFyc3hrdTcwWURSbElpZFF2aDdnc0IrZkJxaXpWRnovR0ZM?=
 =?utf-8?B?R05sbjF6ZXc0MGFRUEVJTDdldTZWVnVSbVR6Q204RmVRbWQwcEpzdnRYTkFY?=
 =?utf-8?B?dHJ0NmhvMDJqSkNrV0Z3THdEZjhuY1g2V1g1cEFxa3ZYMyt2b3lHckQ0R1Jq?=
 =?utf-8?B?YndNeU5oOUdMRkw5aG9ES0lxQjJtN1dTazJDL2ZtNDFzZGJBK1RQaElYTVRD?=
 =?utf-8?B?dHNkUGl1bmNxN1VyZGdoZzJsYUNXdG5LYTAwS0hJb1htMGVESjZCVTgzM09Q?=
 =?utf-8?B?aVdsOGFQRHRPLzI0dEZCbDZHR0pzWXNFSld1bXFlVTdxeXZDbjZFeElIN2lt?=
 =?utf-8?Q?I5KsFHpBSPFGYwS8mFmZbBhjP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3526e7e3-0c38-44b6-3f4f-08dd81a3977d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:42:57.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLRNwpBn6xixNkPDakJ8hC+C/7zflQ2HWD+wlZMJyyi6FF0VUN9GcNXWQRWQSnAYUEclX9EnWnA6SgMOw7UvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/22/2025 7:06 PM, Christian König wrote:
> Am 22.04.25 um 15:23 schrieb Prike Liang:
>> This debug dump will help on debugging the evf attached gem obj fence
>> related issue.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index d09db052e282..1e73ce30d4d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>>   	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
>>   	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
>>   	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
>> -
>> +	/* Add the gem obj resv fence dump*/
>> +	if (dma_resv_trylock(bo->tbo.base.resv)) {
>> +		dma_resv_describe(bo->tbo.base.resv, m);
>> +		dma_resv_unlock(bo->tbo.base.resv);
>> +	}
>>   	seq_puts(m, "\n");
>>   
>>   	return size;
