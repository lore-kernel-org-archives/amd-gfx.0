Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6293D1AD53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776D610E6F7;
	Wed, 16 Oct 2024 13:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0T3q+UYE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0171B10E6F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRNnEuVpo/LW+PdX+CdDU28yMOu0vA6XrlDjeKKqjHKWdFdb6VC7Pxm5pBeeiKwSUSLgQcTpN5LW07Bvwe7QK9pWOQXpPJzwttwpMbqYNZ7ELzc1yMGh5PGx30ZhwpT7mllbcSg1hVCV9prwmAZfajusYxm4nJBRm1HU57t3+RvkgnWfYZ2j/zzNexaWkD81fo8DiLbYA10qnXqRQ31ZubKx66S+ZRXOygrGZ8rcMEKy62kChNa/nXkJfsyz7xv0ldkC3ckYHtNf16tn4qYExXD/FhnkCutkk9ZYPJVKfIomGYQ+YMHaapzYuNfQlCLwKjfUaE0aEra23ijq24TqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SL87ISbBN0IkboYPtmjnRaRUWaYzST7ExAYbrZgpC8=;
 b=oiLDP+erShpNBxxT46FN1ei7EOpMIBgLOpHZ9Jq0lVUeQnu6wLqUO/W422wrNyCeLpuR/o9StHbbaHR77hoRozL7KekLFCZMWjfIsZX5ilM5Brrzxc3ssFJp58xCqskbZ4qMgTSlRGQNSLcW/i4WhUW1zR95b35UAUblRdWikE+UDacRQQnfsCy4m90K7xNcCvSg1pgbtqX9BrHvlJoXxe6Zs0oNMNNRsskCEN+DGUigh8FnY8MBSBNWhkKwYLse5GnhUSgldfllLm5WD/W29qJ1jsV9Vdh7W/vjt6tQp0/afqsoTCMjhe7nvIzp0AB/1aa3AltFk+GFqSDW2X0KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SL87ISbBN0IkboYPtmjnRaRUWaYzST7ExAYbrZgpC8=;
 b=0T3q+UYEqwB2uRtqxKjt5l3RgO91kiJVJ6l22zAbLfwR4IYQwVdNtyEEnuiCUKnXB05KclcS9h2apNYBgc7lqunVTreUejbTqUmJovwG8WUPtKmboRu3LSbi0S/1y+qu2fIxBDH6uEvhvI9MdaqXo1cPMtbXlbZrH++9XUqrNnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 13:15:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:15:25 +0000
Content-Type: multipart/alternative;
 boundary="------------kaOaJ8omavIUS154AwF9UVUH"
Message-ID: <d97ac284-723e-499c-9d0b-ab9cf624dd5a@amd.com>
Date: Wed, 16 Oct 2024 08:15:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to enter idle
 optimizations
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
 <20241015081713.3042665-2-Wayne.Lin@amd.com>
 <1284976c-8fc9-4eab-b01e-a8a12790541d@amd.com>
 <CH0PR12MB528426EDBC0B3AC7245202578B462@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CH0PR12MB528426EDBC0B3AC7245202578B462@CH0PR12MB5284.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6980f48e-7374-4cba-feee-08dcede498d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXdZcFZCRW9UQUJ1Yk4vK2RQV3E3VmtFTTVmMlhrZlg4blErTTQ3T3VCRzYr?=
 =?utf-8?B?YjRSWC9USXRmQ2JTRlYrOW9mMDdqTHZQRmYxeHpwWWI0L29xTlZxRTFIWTB3?=
 =?utf-8?B?WXNBZjVjZXZ5aUFUbWpHKzF3L1g4eUhLb1Z3TDQ1eEhkdlBqVjBic29uTHJI?=
 =?utf-8?B?OUk5dGNMWk1LSStXbDRlZDRFck1hbWU3ZDF4ZVdzSWh6cTB1Y0JSMnFDbEVW?=
 =?utf-8?B?M1VHSjFFdVVRcDdueU9FbVhZV0l6cnduUVFuaSs1bTEzNVV4WFpwSGhWdVk3?=
 =?utf-8?B?R1FCUGRBRnA0YUVuUG5IMTJ5RFBSR283QnQ1elVJZTUyaVQvbnl6UTk1Tkha?=
 =?utf-8?B?Q3RFQmZNamJrVldQeDNPNDFuNEt0UDNTMzNBUFRDdFN6ZFJoRFJTcm9DWU9Z?=
 =?utf-8?B?NWVwTitHVkQyZ0VWVFp0T3FZZDIyVGVMWTRYRzZXYm5FYVdrbkxXTTNQUUZR?=
 =?utf-8?B?TVljSXpEUUdDYWJLcFY1di9MUDZOZ1BiS3F2MEx1VGdFcGhaZWpwMm9ZaGph?=
 =?utf-8?B?OWg1dHFHUVBPL3hEOWpsSjRDTlpReDhwU2pkR0ZZVFEvUGZUOEQ3M3pwUmVx?=
 =?utf-8?B?M2J5SzBWc1hmVThZZVRpVTZHU3VxRmpwQ2NIY2RGbXpyTit6MU5HRjc2Tmxk?=
 =?utf-8?B?QW0wblhkN2lpVWJjMWdVMUp0TUg3Vm9RaXFOWS80V0N6eVJMTE9qWU80dldK?=
 =?utf-8?B?R0x6L2hOMjQ3ZTM3N09CUEp1QzhjT25ULzNEVE5QNXBRUUdhSi96ZUxoU1dt?=
 =?utf-8?B?WkRzOHpzNDBRWTJBMkM1SDRRejJsdTZTN3ZlUXFBeXBxdTdrWXdiSWw1cEx2?=
 =?utf-8?B?d3RESmhLRk14YmsrZkZXZVd5aytuSjhyNkZMNnd3bGZUY05iSkhXSWdhREo1?=
 =?utf-8?B?emxkbUMremVRalRwZm1Mc3MrK2hHYVVocG9lT2JIUXlRSHg3eEZDNG5yRWZO?=
 =?utf-8?B?TDN4TXVROTkreGZXZXQzT3pPcU9vcWJvT0dobGZFT09RQXROcWl6SThOMHVT?=
 =?utf-8?B?NW52bWhub3RkQXgrQXVvZVNpcFVkRVlxY2JlUjczWVNuSGltdU1ZYUtId3Jt?=
 =?utf-8?B?M2wwZnZwVU9EM1YzSkNuaTNOTElaQk91ejJ2NzdXckxyUVU3VXZxRC9TbElw?=
 =?utf-8?B?V0tiZG1scGhpbTdkUlhMM3dpWVNsVTNRRkNXWFRybkwwZ2I5Tk5pWnpiY2pJ?=
 =?utf-8?B?VDErVGhnZTRnNlVCQjZCRVJDYlV6cmhNM1lucjBWZk5nRTIvVFpwUUQvQUhO?=
 =?utf-8?B?S25mYmNETzZZbmc5VmxoMUV2R1VhZ2lrQktab3psOTJPSUZ2bWIrNE5CcFRt?=
 =?utf-8?B?SGFRRVBOMS9yTVpxSXZmNE8zZlV0a2drVWNrVDNQWVZOL3JoUm9CODN2WjJl?=
 =?utf-8?B?dElkVnZlQUNNSjQ5RUljMFEyMVNDM0o3R2tDd2F1NzZwZ3lsZ3BHdXhIQXMy?=
 =?utf-8?B?UFlqcDV3YUcyRmZqTHg3SVhLZXMyRkN0V1pqTVhqU3RMYTZOSG5YUkUrNDN6?=
 =?utf-8?B?c25DckkzbXozd1BQaEtkTzRlNUlsM1QxWTZwakJRcCtEeWI4WkhlcENKZ1hn?=
 =?utf-8?B?ZytoQUFjQkxZT2N6NGRsYStudmtUTlhjNVdycldpM2gvQm5mN21BejE2Skc2?=
 =?utf-8?B?K1BvaURVNjYyZ1BMQWxWQ3p6cnB3VnNnM2RLMldSTng0U1V6V0FUZHN1NTVJ?=
 =?utf-8?B?ZXphSnM2djV6clF4WVZYQ1BXd08yRlZ2TVI4Uzk4SmIreTl6ZDBEckFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNNd0hTdEtTZW15dm1SazhKa2R6TU1JRGtlcUROanV6VVNSM2ZNOXJrZG15?=
 =?utf-8?B?dWFadkx6aE5UK0Q4bUNPcXdrTmF6VkpQNE9kVDEwU1ozOEszVk1LZEJ0RC9P?=
 =?utf-8?B?WlJqbmQwVjAyZHZWS0FwWnJraTZFNkpqQjNBVmxVMU5mLzVLSGREcWc2SVhC?=
 =?utf-8?B?OVgvSyt0Ykl6T085QjRkTVRsQmlrZkhLbFM4dEVCWURXa1QwOWd2cFpTa21m?=
 =?utf-8?B?ZWh0b1ZvdXA5TDJGY1A0dzNKVXVhMzZaSUZuOG03bHFkNWJMQlNqa3dGaTFS?=
 =?utf-8?B?SEplSzJWeXBYY2tRTFZINmdPZnQvK3ZCVVlTYTZtdkJFQWRsQ0lZWmVVdTda?=
 =?utf-8?B?T1ZkYTJUWkNVWCsrV3B1cHgxSGE1L3lDTjBVZkRJaTlrRDBNRmIyUkZnNW5T?=
 =?utf-8?B?K3VQRGlqNlBtd01uYWtLNG5VRlhWYTBTZysxOVJKbEMxNG5ocnpic1Y4aVgy?=
 =?utf-8?B?KzF3bFdOY3BTNXliZ0VUM1pzcjFRVXoyVkZlNFVza29aOUdJN0tTU1grcjVN?=
 =?utf-8?B?VThaQ3p4ZHRlNnFwRnJYeHl3SjZIWjZHK3N6QVI4TmErMEo0NUU0RUdwS254?=
 =?utf-8?B?V2JXSXRhVEF3bkdlZHdsaDVLbDIzMHkybnR3MnRUWUVxRFIybUcrRmJOL0VG?=
 =?utf-8?B?Z2wzNnBMOC9maGk5Mk0xUU5KZndXVXJuN2J4MDVXaTVOZ01KSG1TMUNCTlhH?=
 =?utf-8?B?ekhKUTZIQldRM21ySCt5MDcvWFJVUnpTRW9nK0EvNk94aHdWTFRyR1ZleXRh?=
 =?utf-8?B?QWNEcGJVWVBVcGoweEg3Y2ZWT2piL2RrRVErd0dNRnNsTldGL0s3VTY0RVpm?=
 =?utf-8?B?Um9Fbi9mbjVINTlXbHpYYlRPdEtpYmwxRS83RklFYWRXUVByUWxveWJMdDU0?=
 =?utf-8?B?WGpoY2VoYmFZUEJCbXdHZkdCS0VtdS9HZzVXNWJGOVh2dWZma1Q3UFcvNllM?=
 =?utf-8?B?cVJRZkFSTEY1THpqN1F6MjZMTkdySExJQ2NNVnI3U2tHSlpYVDJKYVY3YURS?=
 =?utf-8?B?SThqenJ1YWNYTXlLajRlaXpkc2lnTSs4RUlCVHlMTE5DM0EwQ2x2bkl3QWhD?=
 =?utf-8?B?Sk5Zdm81cTdqOWhIR0p5aEtKWTRDOWhEdEVsdDFGdFU0dkMwbTc3OE1kK1BU?=
 =?utf-8?B?Q3k1MXhpYVAreitnK2ViUzZKTDAyY2lSd1FaY0ZyQTlBNDRFdm5aOVVmaWR6?=
 =?utf-8?B?WWNQNEhFYThJYTFFUTQvWVQ0aG5RMnQ3L0Jkc1k1djdQWDc5UDM2SW1CRG10?=
 =?utf-8?B?NHh6c0RleVduaWRIMSs5aDUrQzVQSVE5Q1ljSzBySFdKZlg2WXc4TjhpZjlB?=
 =?utf-8?B?NEF3ODdtYWxKUzFkYmdUUXh1RGJWQ0ZZcjRSa1g4UVg4eDl2RmNzbHMyOHdR?=
 =?utf-8?B?Rm5vTFgzUWtjVUJWcE1yL2grV2M1dnZCMDgzMkZjZThXbDlHdEowMjc4T1FE?=
 =?utf-8?B?SVVuTGx2YjJlcmdwL1Frejlja3Y2aEpadmE0Y1d6a3ZhMnZEZmhRWlBNUEpv?=
 =?utf-8?B?K0FIMERPMVZQUGR4NlVqSE1mQm9GV1NKaWFvOHpKZUQyMFBDOE10UTlJQUtH?=
 =?utf-8?B?ekpMeENYWkdnOFYwK1hvQythZW5aS3YyZXUySTU4dUdzWDdEbVJUeXRNS3Jr?=
 =?utf-8?B?alFoRnlOUXJkckVMZU1YQjI0NFQzU21TUTNnSDZDZG45a1hJUEtnUXpiZU1Z?=
 =?utf-8?B?TFZ1UHRGMHc1UVRxSU1uVEw1a3pCS2dlZDJ1dVhHTUhrbUM3Ylg5ZkVpZS9o?=
 =?utf-8?B?UDJyMG9laTZXR1pJNExnZjRFZVloUnpVVnppV1JsQ3ZlRUQ3aXptdVE2Wnlv?=
 =?utf-8?B?ZUE0QWRKUEFBUWFKVVNDN25pQ1hJbHJFV2RxeDUrZGFEakxBcGtlVUFtWnkz?=
 =?utf-8?B?L0N5RUUwNkc0aTBnTGxWaCt3bEd1clk5dU9LNTBMUUhGc2xMM2hqMm13U0hK?=
 =?utf-8?B?TVVMY2p3aDJXQm9VMGZTLzI4SEFLamZXRDFlQWhNNTd0bGE3TjdIb2xlZ1VT?=
 =?utf-8?B?dktWc0lYQlYvdDhkNTJoWG1VRW5SdHFHclJKY09UWEcxNFZJR0ZETTlpMFBY?=
 =?utf-8?B?QUdSK3dmUktlRFVrcVhqZDdjV2dCaks3amRYSlFhNXJkb3VrdDlaWmJKcEhi?=
 =?utf-8?Q?b7A2bx4lietAp5iwDqX0r+Fbh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6980f48e-7374-4cba-feee-08dcede498d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:15:25.3950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV1BEUGyCCg+CMmVNp2lobFOcprM3b/XySr4Yuh08f+rqeXARki4Wv738jpcvPUDpIaTsKLOHkFtsE4wht+IgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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

--------------kaOaJ8omavIUS154AwF9UVUH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Jay,

Got it, thanks for confirming.

Thanks,

On 10/16/2024 08:13, Pillai, Aurabindo wrote:
>
> [Public]
>
>
>
> Hi Mario,
>
> Hamza is working on the reported issue and appears to be due to a 
> different root cause. Hence, we're expecting that the fix for that 
> issue is likely going to be different, with what we know so far. While 
> that issue is being debugged, this patch will allow us to have better 
> idle power consumption on dGPUs
>
>
> --
>
> Regards,
> Jay
> ------------------------------------------------------------------------
> *From:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Sent:* Tuesday, October 15, 2024 9:14 AM
> *To:* Lin, Wayne <Wayne.Lin@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) 
> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; 
> Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Pillai, Aurabindo 
> <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Chung, 
> ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry 
> <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, 
> Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel 
> <Daniel.Wheeler@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; stable@vger.kernel.org 
> <stable@vger.kernel.org>
> *Subject:* Re: [PATCH 01/10] drm/amd/display: temp w/a for dGPU to 
> enter idle optimizations
> On 10/15/2024 03:17, Wayne Lin wrote:
> > From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >
> > [Why&How]
> > vblank immediate disable currently does not work for all asics. On
> > DCN401, the vblank interrupts never stop coming, and hence we never
> > get a chance to trigger idle optimizations.
> >
> > Add a workaround to enable immediate disable only on APUs for now. This
> > adds a 2-frame delay for triggering idle optimization, which is a
> > negligible overhead.
> >
> > Fixes: db11e20a1144 ("drm/amd/display: use a more lax vblank enable 
> policy for older ASICs")
> > Fixes: 6dfb3a42a914 ("drm/amd/display: use a more lax vblank enable 
> policy for DCN35+")
> >
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a4882b16ace2..6ea54eb5d68d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8379,7 +8379,8 @@ static void manage_dm_interrupts(struct 
> amdgpu_device *adev,
> >                if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> >                    IP_VERSION(3, 5, 0) ||
> > acrtc_state->stream->link->psr_settings.psr_version <
> > -                 DC_PSR_VERSION_UNSUPPORTED) {
> > +                 DC_PSR_VERSION_UNSUPPORTED ||
> > +                 !(adev->flags & AMD_IS_APU)) {
> >                        timing = &acrtc_state->stream->timing;
> >
> >                        /* at least 2 frames */
>
> Considering the regression raised [1] is on an APU too I wonder if this
> is really the best workaround to approach to this issue.
>
> https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me/


--------------kaOaJ8omavIUS154AwF9UVUH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Jay,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Got it, thanks for confirming.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Thanks,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 10/16/2024 08:13, Pillai, Aurabindo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CH0PR12MB528426EDBC0B3AC7245202578B462@CH0PR12MB5284.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div id="Signature" class="elementToProof" style="color: inherit;"><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi
            Mario,</span></div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Hamza is working on the reported issue and appears to be due
          to a different root cause. Hence, we're expecting that the fix
          for that issue is likely going to be different, with what we
          know so far. While that issue is being debugged, this patch
          will allow us to have better idle power consumption on dGPUs<br>
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          --</div>
        <div class="elementToProof" style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Regards,</div>
        <div class="elementToProof" style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Jay<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Limonciello, Mario
            <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, October 15, 2024 9:14 AM<br>
            <b>To:</b> Lin, Wayne <a class="moz-txt-link-rfc2396E" href="mailto:Wayne.Lin@amd.com">&lt;Wayne.Lin@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com">&lt;Harry.Wentland@amd.com&gt;</a>;
            Li, Sun peng (Leo) <a class="moz-txt-link-rfc2396E" href="mailto:Sunpeng.Li@amd.com">&lt;Sunpeng.Li@amd.com&gt;</a>; Siqueira,
            Rodrigo <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a>; Mahfooz, Hamza
            <a class="moz-txt-link-rfc2396E" href="mailto:Hamza.Mahfooz@amd.com">&lt;Hamza.Mahfooz@amd.com&gt;</a>; Pillai, Aurabindo
            <a class="moz-txt-link-rfc2396E" href="mailto:Aurabindo.Pillai@amd.com">&lt;Aurabindo.Pillai@amd.com&gt;</a>; Li, Roman
            <a class="moz-txt-link-rfc2396E" href="mailto:Roman.Li@amd.com">&lt;Roman.Li@amd.com&gt;</a>; Chung, ChiaHsuan (Tom)
            <a class="moz-txt-link-rfc2396E" href="mailto:ChiaHsuan.Chung@amd.com">&lt;ChiaHsuan.Chung@amd.com&gt;</a>; Zuo, Jerry
            <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zuo@amd.com">&lt;Jerry.Zuo@amd.com&gt;</a>; Mohamed, Zaeem
            <a class="moz-txt-link-rfc2396E" href="mailto:Zaeem.Mohamed@amd.com">&lt;Zaeem.Mohamed@amd.com&gt;</a>; Chiu, Solomon
            <a class="moz-txt-link-rfc2396E" href="mailto:Solomon.Chiu@amd.com">&lt;Solomon.Chiu@amd.com&gt;</a>; Wheeler, Daniel
            <a class="moz-txt-link-rfc2396E" href="mailto:Daniel.Wheeler@amd.com">&lt;Daniel.Wheeler@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 01/10] drm/amd/display: temp w/a
            for dGPU to enter idle optimizations</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">On 10/15/2024 03:17, Wayne Lin
                wrote:<br>
                &gt; From: Aurabindo Pillai
                <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a><br>
                &gt; <br>
                &gt; [Why&amp;How]<br>
                &gt; vblank immediate disable currently does not work
                for all asics. On<br>
                &gt; DCN401, the vblank interrupts never stop coming,
                and hence we never<br>
                &gt; get a chance to trigger idle optimizations.<br>
                &gt; <br>
                &gt; Add a workaround to enable immediate disable only
                on APUs for now. This<br>
                &gt; adds a 2-frame delay for triggering idle
                optimization, which is a<br>
                &gt; negligible overhead.<br>
                &gt; <br>
                &gt; Fixes: db11e20a1144 (&quot;drm/amd/display: use a more
                lax vblank enable policy for older ASICs&quot;)<br>
                &gt; Fixes: 6dfb3a42a914 (&quot;drm/amd/display: use a more
                lax vblank enable policy for DCN35+&quot;)<br>
                &gt; <br>
                &gt; Cc: Mario Limonciello
                <a class="moz-txt-link-rfc2396E" href="mailto:mario.limonciello@amd.com">&lt;mario.limonciello@amd.com&gt;</a><br>
                &gt; Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                &gt; Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a><br>
                &gt; Reviewed-by: Harry Wentland
                <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a><br>
                &gt; Reviewed-by: Rodrigo Siqueira
                <a class="moz-txt-link-rfc2396E" href="mailto:rodrigo.siqueira@amd.com">&lt;rodrigo.siqueira@amd.com&gt;</a><br>
                &gt; Signed-off-by: Aurabindo Pillai
                <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a><br>
                &gt; Signed-off-by: Wayne Lin <a class="moz-txt-link-rfc2396E" href="mailto:wayne.lin@amd.com">&lt;wayne.lin@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
                | 3 ++-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
                &gt; <br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; index a4882b16ace2..6ea54eb5d68d 100644<br>
                &gt; ---
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; +++
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
                &gt; @@ -8379,7 +8379,8 @@ static void
                manage_dm_interrupts(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev,
                DCE_HWIP, 0) &lt;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(3, 5, 0) ||<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                acrtc_state-&gt;stream-&gt;link-&gt;psr_settings.psr_version
                &lt;<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_VERSION_UNSUPPORTED) {<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_VERSION_UNSUPPORTED ||<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &amp;
                AMD_IS_APU)) {<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timing =
                &amp;acrtc_state-&gt;stream-&gt;timing;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* at least 2 frames */<br>
                <br>
                Considering the regression raised [1] is on an APU too I
                wonder if this <br>
                is really the best workaround to approach to this issue.<br>
                <br>
                <a href="https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me/" moz-do-not-send="true" class="moz-txt-link-freetext">https://lore.kernel.org/amd-gfx/9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me/</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------kaOaJ8omavIUS154AwF9UVUH--
