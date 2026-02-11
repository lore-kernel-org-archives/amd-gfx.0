Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB9ECD6EA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 21:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D7310E651;
	Wed, 11 Feb 2026 21:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRzqj8jP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B899810E651
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 21:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXX2CXPfzwgKDRE0jsYuWuJNKovNu7RkYQL2ohIDewi9pTYd2Nnq+CuFE9weDh11HvtCGMJoAGnBMOxX+gDh06MlFSqRUFq9KhnJQRquvIRjQ006dc740R2aLj/vBvY/eBPSaBy8Ygx5bxVMlrk9pQrw5WsWqnYVsdsIvkNjSGNNrgQhXBQrasi5l9JdiTzI9vIg76KvGo7NK+Qz+T/vAWsTcaA27YbNfycCEoFzI2SO76BhPRFBgYEtIwXfJU+q61MNggUgW0VoySwAjglKarhZZoiUZpYVSTSH/8rToBBev1NgxS7MwVUbIlVUMxGwA0CA4v5XJzy8Kx8MmT2MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NUGf8JpHYUvTYc6KZ3OeAs2DkWGVmLEDDe0AImmnSw=;
 b=YMrcKFMkCrQ2Rq0wYrFKqFnFi6BkzRFBdQuRvXfNzEo3BjXrwBf3AjC9NJoX9YlXRTzSJe9uMA+MiN1oPno74sJQI81/1oD6z+S9r+0iFsL23QCiiRMreZmqgOSNcV0ZXdKUc6WdLCj07gj7llzWRMpJQKtnDoSGJzvD0A1i5Kk9z/Vz6d31WKredCRoNC+GXUXUl/vJ4BqIYuMFbwHLaWde1p4+QVCGSAK7EGMBqtN1In24u85UYdzy2kw0R2oFcas/DT2NCp8Qq5bOt+JNR/dC5xv4cbuHz4jYpoc9BVtzKslw88CEVC9Yw6ygiuWSjpGFNOG7gyDo0D+umtXcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NUGf8JpHYUvTYc6KZ3OeAs2DkWGVmLEDDe0AImmnSw=;
 b=XRzqj8jPbBWcYRQaRBKzUOveLSuNgrohb1KeIkDspIR7iTaufFSTQTRSMbAXv0ccpbw3bP6idIm21i7+7AvqxRppe8s62QOhLFSkEFbtEBG2emv9FM4dGTQVGfZRK9Hjkrf0MSGCMNHG5LWtirxYSiP7leRqPVr4ok/pPn8nke0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:11:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 21:11:28 +0000
Message-ID: <bace01a8-f9ac-4d58-93a5-85df674631d3@amd.com>
Date: Wed, 11 Feb 2026 16:11:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Disable MQD queue priority
To: amd-gfx@lists.freedesktop.org, "Martin, Andrew" <Andrew.Martin@amd.com>
References: <20260202105326.140826-1-andrew.martin@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: jay.cornwall@amd.com, "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
In-Reply-To: <20260202105326.140826-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR10CA0034.namprd10.prod.outlook.com
 (2603:10b6:930:4b::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: a51fb993-4142-4879-324b-08de69b21f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjQ1NDNxcFdKK2g3dWsrUE1WMTRoVndIVUNnYkowdW5ROHNseXRqbDhJZ0hz?=
 =?utf-8?B?ay8ya2FHQjlzMGwyazVQRGo2dUJ6anNmbTgxcFFpemZWaDFGRUxUc1dHSHFk?=
 =?utf-8?B?TEdISEd5cW1CM2FieEJlMDNYcGVmT25MY2FXc1hkVkdMM25BaGRwYTMrZEox?=
 =?utf-8?B?TVo4VURMaTBuNnNuZzE3cW5CQllUK3JKSm5HczFJb2hEK3RmeUJjLzc3aFlM?=
 =?utf-8?B?NlhOb2VQS0ZNRW9VVHhkRHh3Z0NBZUJKNUpVcjRnN1RiOHM3WWh1VG9KdTdY?=
 =?utf-8?B?enpGL1BQOVNuU2FadlVYby9KSGs4RG1TdGRCOFA5bUgwdDNvdHhtWmJzbnlt?=
 =?utf-8?B?aEZIbkxiWmpaeGZ1akhyaUx3NCs4bW02VmpVU2VSR3czcCtIRVlTZzZ4c0xX?=
 =?utf-8?B?SFBHR1hsS3U0cVFuaVVYRHJHOVM0YU5ZMUl1K3hyTG9tZVgvZnZCMzY2UENw?=
 =?utf-8?B?MmJPakFlNGVUUmZYcFphaFcyRjJkSjFDVEswalU3TlZibGJ6MEpsUE5QZGdJ?=
 =?utf-8?B?UVVsRVUrVzVCYTNyanh6TUx4N1pQUG1rU3ZQa3Z2MG9YenI5a3FYbXdxbG9p?=
 =?utf-8?B?bXhaQmZZNFk0SVJEVzhzemMvbElaQmpGYnEzL2d2UnFZTThNRjkxUVFYa1BV?=
 =?utf-8?B?ckxNWUF4dUtXb0xJQVc1S09kNVlHVXlZRHdXcnorcG5JdDhPZXB0TXg5QTRh?=
 =?utf-8?B?Ly8ySEJwdVh1NFJIT2NQSHdiNjdtSVlFTGd2RThnSm5DWXRMUC9zeE15Wk9U?=
 =?utf-8?B?dldQM0RXRWErc1NhK1p5Yk92RUMvdzFRRlp4K3RzT0xMd25Ec0N1c204ZWJo?=
 =?utf-8?B?ZDlING5wK1VIelBicks2dmRDWll0VVp4bDhNenN4OFZncWNXZUp2TThZdE12?=
 =?utf-8?B?LzM3Mk9ITTBDNk1qRm1uNUFsZzBKenhDTXczU2ROT29BZ2FHc0dRdzFjcGJj?=
 =?utf-8?B?KzRsZ3Zhd2VxUHoweTRxU08xTVA1U1RZMTRpYVRUMUE0QjJLZUNIYXFWbVNS?=
 =?utf-8?B?Z0JqK0JkRVhkUlZOY21pblRlSWF0enZJcmoyWDhyeDRJL2lVSXpURVdPc1Nl?=
 =?utf-8?B?QkdsNTFVSFpxdWZPNVoyemJubVV1SGtwd3Jtc3FZUG9YbisxWDdWNVo4L0hm?=
 =?utf-8?B?RmlITnJQenNObEdOb0U1Q2lDM0ZaeHBuTTJkNmIxUWZaaEV5K01wNHlzdGEy?=
 =?utf-8?B?L2M1WlVKRmJoQ0pTc3ZXZmlwK3JlRVVBcDJmVElCUmkvVnAxMTliMHY4UWJX?=
 =?utf-8?B?bUM3b0ZVWkhJM1JqVVg0N25WODBVQUFiMnRHRUI1S0lPOFJ1MVlUa1FkY3FW?=
 =?utf-8?B?NWlreTBQZVdodW04OW9Ed1l1eTV0MmFZNWlZcHBpaVJqeGc1c0pxMnQ5L1Vl?=
 =?utf-8?B?ZVB3WGRQMWd0NXBHMnhuaVRhc0phclNuQnB4M0ppTWJGMGJUUTJ0ckNsbnE3?=
 =?utf-8?B?RzdGZ0Q2OEFzck42dUMwSUdxWVNja21FZHZPblFHNlhmY0pCTFZMTDRBcEd1?=
 =?utf-8?B?UDhvZndMcXQ2RVpaNFdhYWZodWI0NnlUTTA4T25WUzRueHdQR1E1S3BvSUtZ?=
 =?utf-8?B?QXZ5NEVxbVlSNW5WWS9Vci9XVkZQQXVNblhNVDN1ZjdEZExKOVhSdTZpVGFS?=
 =?utf-8?B?TmNvd3Y4Uyt5QlVyTmdJempUYW54ajZuaXgrQ2FWNmRUNElDYkwrcThNM1Nk?=
 =?utf-8?B?M1ZYcms3cldESmNlOEQxWlJibFA3TVlaazRQUHhPU1BTNmFXRlBPQW8xWGJy?=
 =?utf-8?B?KzRyZmdZVUw4emZ6NUluZkphaFU1d1I2dGp3dFZXV0ltTTNPT0RkcEp1Ymxm?=
 =?utf-8?B?TnlMTnhuY0RtbjlSQ082UWJFZkYzeFRWc05BNm5JeVU3NStGTUt4a1dxQks5?=
 =?utf-8?B?NmsvQ01VZmgyM3dLUFFkMHZpdU5oblhYbEhHbFY1blFBL1RFQnJvNStidnVj?=
 =?utf-8?B?OTJnUWJ4bnlrVHQ0ZFNIZTRJU01pZWVhRkRhc0UwdlJqYWc2NW9rTXVKSW9C?=
 =?utf-8?B?L3hBdUFMcXZxU2Y0aTk0a1BaK1JBQUFIVzZFQmNIL21xZTFGK3F1QWtyczJV?=
 =?utf-8?B?SXErUjEwREtnbnNLc1ZLMlJmYWovSHRrUTZoc2dkRTdBN0lZQk11RE5yRThM?=
 =?utf-8?Q?g32I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlqMTR4dkoyMFUvWjhSV0drVHVLUFlidkxDMitmTnRPUjdIbGQ5clJUdy9O?=
 =?utf-8?B?RDgrVk1RTlFhTjU3aHNwZlEranU5RjlWd1NRa0QxdU5HZHQ4RkJCVkpDaXZV?=
 =?utf-8?B?dnd0blRFLzhjSjlic09leVk1SFpxa0RBdlNmOWRxUmlQRWtidXV0cVZBNVNM?=
 =?utf-8?B?bkZCcmZqZ2VJOHh6Ymw4NHNSWEVNNVNmSGpaRGMvdFVTRndXMGJtQXZ1Ty91?=
 =?utf-8?B?aU1ueWhLVit1RURXVEJxS29GWWxhNDNZTlIzTjdITHdoUHdDMG5QeXM0WWJs?=
 =?utf-8?B?VDFMU2pjeDNjaFB0aDFiUm9BR1M1b3RBMzF0SVNsN21BckZZakozY2swZlFL?=
 =?utf-8?B?QjJ1N28rRVA2WDNIZ1pHdXZhUkJsR1lnTlJHQzZ6cEUrd1RBTFNCcGg4cHY1?=
 =?utf-8?B?b3FaMElrOTNYcHdrUWZRRmgxZTBZTHVGN0NDOS80dWxNSHc0OVNlS3lOOWNE?=
 =?utf-8?B?WnBaR1Z3Y1BUZ09MT3VkdEJISkRzSkVROVh4V0xCOU1TeGcvSElOVGJqME5Q?=
 =?utf-8?B?OVF4ODF2VTdJYVJxaFRtalhmcUh4d0FkSmpnM0NMWjE0ZFBPaXlOTG5yRThT?=
 =?utf-8?B?V0Iya0E3N0lCUlJoRU9wSXNLanFwcFlMZ2p6VGU5Q2VuWGtZeGNKRlJxYnR3?=
 =?utf-8?B?a2NxbUZ3dFl6Sy9iMzlsNUVoL3E1MDRMY0NNMGhiQmo1MTMrYmMyUGdza0Fq?=
 =?utf-8?B?QjcyMktmbDdYRHd0S0piT3preCtpTUJQS0xUMzB1RlN3L2c4dW1jVDJNVGQv?=
 =?utf-8?B?UUp0T2dXUjdvaCtubDN1UDdGbWNwUmowTjFMVWIxc1pwT3NxNHdVR3V4eSsx?=
 =?utf-8?B?L004MUhpbHh1NnAwY3VycWhsSUJ2aUJFOFdRMkZ5d281bFM1ZHhNcURXaTNa?=
 =?utf-8?B?bTBhQlhYak1XM0xSOUozaEpYTHpTNXBhMXpzdnY4MmZlcVFxNi84eUtuMVJC?=
 =?utf-8?B?UHowMmV5Rzd3QUgybDgvWWhOL0x2VDNjNXlNcEkxclJlNWg5MEt2TGRWS09F?=
 =?utf-8?B?S3hTMEFhN1JvQVVJZEdXM2ZPcEhadEUrZVV1OEF2QXN5S1BwTkIrb0ZEOWlr?=
 =?utf-8?B?ak9LQVFzckVrck1HUXNLdEJOdkZ2WjhtWG9oZzB3OUplQXdhNUVQU08zVXFx?=
 =?utf-8?B?UUJiV0dLbnlBKzlrWUo2bVhZa3FDckdJaERCU2NPcVYzZHQwTHlmSlZmOUFF?=
 =?utf-8?B?NE1EQkY1SktWUzc4Q1dscTlidWFsWFpiZEx4NFZWc0lOQTlsdEZKQUJwanV6?=
 =?utf-8?B?SDFUOFp2SzVRVGtYVGdrSGZ1WWswT0ZZK3VMdHZkdnhQc2Y4OEllUGtKdUsx?=
 =?utf-8?B?b0lSVWM4M2VKN3lDc2NzNnlHbFJjdHRwWDlwVGZZWXdIVnlVQTNZNUtSekxs?=
 =?utf-8?B?azkzaTNCemEvZHdhSnoreXlJNVg0VEdZQ1ltdGpteWx0M0VWc2Nma0JHc2NF?=
 =?utf-8?B?YlNRdUxuY2ppRUs0Y2RmZ0Z3NjRRMnRGM3B2R21Cc3JzcjdsS3BXdWRMdGd4?=
 =?utf-8?B?YjB3MkdnbnFTUEs3M3FrWjkrcldCeUtvWmF2TXQ4c1ZLQ3NUczNnY0JENzYy?=
 =?utf-8?B?aEtDMTNsOGFrUGJiNUtiSDF4RGNWWkJqQkpsU242aEZJb2Jtc0MzMUMxenJ2?=
 =?utf-8?B?blF3aTM4YTNieVpOWUZpVldHdW1zaEczellxa0M0Z3J3aVE3Ym9zeTZ2cDlC?=
 =?utf-8?B?djRZR0VsQ0ZLU2pOT2lPUlBPM3drRHprSkZyRHlkWk1HVno4TSswalZHWS9l?=
 =?utf-8?B?U3VqWW1GU0dCS0ZpTUtFMENBczVXWFNJWkk2NVVPeXlvOTkxS1hBQTRJdHNx?=
 =?utf-8?B?WkNJL0JzTWFGUHljWHFHZUVRV1pGL2l3S1NML09OWnJEcndOY1lhWDZXbm1G?=
 =?utf-8?B?UTgxei9lNUxvcDZ1djVpcFlTMjdyMmhJZXpEMWxUM0t5WnYxdFpPTlRuRmhH?=
 =?utf-8?B?Q1NBSVhaT0dUSjBvNkNpZW9paWFzYUcza0l1SnNsR1BwL2ordmhhVEpCMnpR?=
 =?utf-8?B?NW5DSzhkVzB2QzVOR1Y3NWlERjJuak5JODk5T2k5dHc1Y2NwS3duNEpxcnM1?=
 =?utf-8?B?V0lKQVVSaFVCMlA3OFZJK250QnNzeWdrRHh1YWYxaTUweERSdmljRWp4Tkc3?=
 =?utf-8?B?SFpOSnM4ZFhQOCszZ2tLNzdjbU1jNi92MzR1SzN2Z1VrbjJ6ejZlTWNmMHBQ?=
 =?utf-8?B?RHE2U0Q4cUhWd1diMmR6OVRaWTh3NGZZYm9vU0hnSEFTU2x2cEZvbHZDZi8y?=
 =?utf-8?B?VmNUYU5UMXlId3VEcGxma09lZmczL0UrekI3Sm5aNkREZ0tYMUh5cERxVU5G?=
 =?utf-8?B?OFhoRTFwQjBWbkpVTU9QdlJOc0VKYk1MbHFSSjdCc2Y1NHo2bXJsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51fb993-4142-4879-324b-08de69b21f2d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:11:28.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs2txyxz/J/O4UHdClM89zU3mJ4yhCOYUAavAxQpzhH7hfQDRm815NzjktnE6q+GM1DiQC9+60aNVgPDBGf8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113
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


On 2026-02-02 05:53, Andrew Martin wrote:
> This solves a "priority inversion" issue, caused by the language

Why the quotes?


> runtime making high-priority queues wait for activity on
> lower-priority queues.

Is this problem specific to GFX9? Otherwise, an equivalent fix should be 
implemented in other versions of the MQD manager as well.


>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..bc4ceba35908 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -106,7 +106,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   static void set_priority(struct v9_mqd *m, struct queue_properties *q)
>   {
>   	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
> -	m->cp_hqd_queue_priority = q->priority;
> +	/* m->cp_hqd_queue_priority = q->priority; */

Please don't leave commented out lines in the code. That's what git 
history is for.

Regards,
   Felix


>   }
>   
>   static bool mqd_on_vram(struct amdgpu_device *adev)
