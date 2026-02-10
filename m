Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD59BEA3F2B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3EE10E17D;
	Tue, 10 Feb 2026 09:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLyo2SEN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737BE10E17D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIVQ09H14uviBLejdGVDDYPu2YvtLfkzSC+leLe1OGazzfluSb2ljFPIQp+2/6QdELrlNgSo6uOr0opb7Ms/h4QTaxgGoNfUMVRiPHdtzsH9rEZqp3r1hnLUy+PBTdD6GuZl1877vY/BA8m+5AB1OQ5rDhCjGsWbtyBSj6dB3aQt9rVzENMU1rd8koyA9qyheIudUsOCfUbf5UgZTsgswfOHBEINtmSkcog56lJUPoRXIJVbRh9W4Y3hjE+wBEKiKzz8wcZWSPRuhE4yf4o0RyEPb3NMY6xT6MNaOC+dgd06VtWSS6OI37opDi+BLA6jt0MJ+hQloufVABiXUZh3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taCbNh10MleDLCaSrY5tMQJ3llgzVTFM3CiF+D7zMWI=;
 b=yb9I2+Kg18xTm7Zomkp68XSbMsVL08IxB2R/rQrAbwJZC/wLhmMvmdlwZ2kLnrL1pdSmY0jPAqXvRk0AfUX0sKwYK/hs6t8etO4yZd7hRTvBmDIgXrLEry1ux4Bbw5Ufwyps4EQs4TRxmIqO1FgdVgIbzRYpUMonkw2dfAA2J6X8rWq9UkZEvu3RREBC+2BPCNAsXixi9rmw4MIW/A+t5pcn8mzH4XTcr5AnN9N391IQ+Zqf4fT/+k6exNratJOsJmNOQzBaXhM7ordjH0q/BtHOie/GSBMNVtejPoYcHpgrpB/2y+uI5xiWeRJrcNfcfb+HfFSaQRJJUj10E79JVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taCbNh10MleDLCaSrY5tMQJ3llgzVTFM3CiF+D7zMWI=;
 b=FLyo2SENQ6WG3/5G3sJZQF6JbxjgV+SOV7zEZvNZ9STHJXnx35EKP5xaLj06YJF8ydR5Cd2Qet2GY7BWNVnMk61I6pqOilhsJBClCkHD7eaRAIu912FpO+bVxX2H9wJo9ZGTamZvR2XBM3WoI0/LBR6jz8ZeVL51eD1Fk2bBz90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 10 Feb
 2026 09:24:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:24:13 +0000
Message-ID: <d612b935-2f85-4acb-ae72-93a62975eb9a@amd.com>
Date: Tue, 10 Feb 2026 14:54:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/psp: Adjust usleep_range in fence wait
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260210080803.3018126-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260210080803.3018126-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cac9211-a541-4cf4-a99c-08de68862742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUtBaSsxS2Q3ZWk3NTAra2w5UXFvZFE5ajVSRTI4bk5pYzQ2UmtKMDRJdjZ4?=
 =?utf-8?B?cHN5TDhJUXZTWXBvWEhOZnNpcllKczFaYThpMkJtMWVtK1hiczY3a2VOWlp3?=
 =?utf-8?B?dWFlc2NCMWxSQS92N0xTK2QrTkFsM0Z4ZmdKT1VHSXlUSHpGWS8yOFFPY2VQ?=
 =?utf-8?B?dkt5MGxpb3dRQTU1U0Y0WWtqVUtQb3JlckRnV083WHNuMXBlYWY4MW04SnFV?=
 =?utf-8?B?ekRjb0lLc0Zacm1zeGNzeTIvZGlpVFhadnpqaW53czI4NFlReC81ZGc0TldK?=
 =?utf-8?B?MEJ5WlJPM2FFTXppWU1qVUd3ZFR3NC85aFByaEpJRlE4d204VmloQWhKRVdI?=
 =?utf-8?B?dmZnY0hYZlpKVEo3MjRkeFJEL0JHdUx5OUgxeHpGTUZVVmVkRHJzTzRQdk5w?=
 =?utf-8?B?MVF3SWlpMlJkemt0dldNbnRYbGJCUldWNHg2ZkJBRFNLcSt3cFk5OTVrVlBn?=
 =?utf-8?B?MGM3MDV4Y0pKWFI5bWk1bEQ3Z0FPYVV1WmhJSTl5amYzZFhTVk1jOTBoT0Ro?=
 =?utf-8?B?YmdRdkdrdDFJUG9WUlNFOVNDTE1pRVVMVUh3UExtRGdsN1BIcStHNHNIRG5C?=
 =?utf-8?B?UHhOTi9tSXpJcnpoYWczWFVTTHNwdU1GZm1VUTZQTnBpTEd1czZoVGFNdHdL?=
 =?utf-8?B?Lzc1aGhGcVZ5UHZuWDlEOFhzbU4zRlZvSUdiZ3JRZ0luU0tYZ2lIaHN2M2Uw?=
 =?utf-8?B?YXdjeng3cVQ2RXpkT3FtYktWdmorbG14bjVjTGMzYzExTFVnV2VOWjZkRXkx?=
 =?utf-8?B?T3dURW1icWJpd0xBRmlHTGFRaDNMMnFsNkl1T0dTdFdkV2djSDRNZ1RxOHh6?=
 =?utf-8?B?TVJDMThDWjY3UERXOGwwUnJFMXQ4TjNwaWU4RUppOTZLUml2aUJXRDR3c3l0?=
 =?utf-8?B?ZStONk9uTXVUbzRJcDJoTUs4TTZadkNiN3ZJdk9iL2dNNGo2bnBFbTVzbUdr?=
 =?utf-8?B?WVNxMWEySlloVWZxTjdMTzEwZFlqeGhDM3NRTld5ajl3dVVCOWIxZXN0M1ZL?=
 =?utf-8?B?RDNZamxoYWRscEFLYllQSnlmdXJUYkY1SDh1VlZINVZKdHFCZGZEd0dWV0tj?=
 =?utf-8?B?OXNQWTl5SWpLcm5LNGlTcXMxMDJmZVNUbEhWeVJaRllKRE5HcTZETVN1WlNa?=
 =?utf-8?B?c2wzWWVweUtDRFZZREhDNWFQRTJTQ215eWtKcVY4VkpYUWtwaGxsRkk3dmF6?=
 =?utf-8?B?RENNSTR2U1FCWE5xYW9GaVB3SlNDVnVJZkhuYUtQWlhaVDY1Y1JGNkRzWmJ4?=
 =?utf-8?B?UVlnTy91clRzRkZRKzJUL2hKOGtPOVp0ODJhSit6S2MzYmh3UjZWQjRxSFhy?=
 =?utf-8?B?ODAvMGRMZjducUNLeU1GbWFnYkFGdmNFZlBTY0twRWZOOEIzcXBxWkJLTTNy?=
 =?utf-8?B?MEMreUdCeUMwbzVoME9aREN3MkRDVmE2Yk9LVHdCZHdIbjlJWENrTE9TSHAv?=
 =?utf-8?B?cmJtOUpPRm00NDdKR0UvWm56cmM2TDAxYkFubGxRTUtXNkNjZ1BacldRRWhi?=
 =?utf-8?B?a2xSOUZtWXJPOFpNRkdHNXEvSkdKQXJHZk9nMW5YSzlCMFpoOGQwY1VBcEVH?=
 =?utf-8?B?a3h2WFRZaFcyNitlUG5hWTR1RGdNY2RzbnRhQm1oUTZIVzVzQjBKdE9RK1oy?=
 =?utf-8?B?YWxnYlcrLzdQTklod1BrYzY3S28wWG5sNUJuN3laVnNBMVVEZkxVbFNKZjRx?=
 =?utf-8?B?dDBaY29Td29wTi9KaXllQVBINkJxN1VhS1VFRU1EQlZ1bjJudndWN3djUVdK?=
 =?utf-8?B?bFNsZFpZR1o2TXhnRDkvcXpleEVuNnM3MEFoV1NVRjBTV3N6VjRZVWlRRmZv?=
 =?utf-8?B?V21aQnZLTmVLS1JnNmIrRUxTeWdYOVYxV0c1RHg3YjI3M2I3UUNua3Fhdk5p?=
 =?utf-8?B?Q2krWFdHUXFmeVpkZXlSQytwbmF3Q3Z5TktBUXRXaFBPWmtYdHN1cEFJbW1q?=
 =?utf-8?B?ejVjRzZoNldOL0h5OWRXYzBHa0prSjRPTE80WEcwSWNyV3NiVzJ6YjFCajZk?=
 =?utf-8?B?YTVSZ3hkNnpxZW1uallHN0MvK0k1amFqQ2FrMjAvMTI5anBySUFPdFNlQzdE?=
 =?utf-8?B?eFk0RU53cFJlUGN1VGdCU04zNFpnTDB3U3Q1d3FoOWhNNWhhb3JOSDR1MnNO?=
 =?utf-8?Q?iMvg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5sTE03T1MzWHpRVHFxclFkZTBMTzBOOTJjZVdudUVjSVp4TllYUStVOTJh?=
 =?utf-8?B?QUNzNk9HUEpIa2huUXVvazI4SXN6b3dUM1ByZnVrZURRczBLNlFaY1ZlaDkw?=
 =?utf-8?B?a0xLL2lmQjNaWXlRaHpSS2xkSXgzT016RFIwL1ZnQTNabGlUSDhxcWFkZXFz?=
 =?utf-8?B?RkF3SGNSeGxBL1l6SktDcTNMTlZtd3lURld2RUlkR0ZhVzczRVlOaFAxbXlx?=
 =?utf-8?B?L1ErMEgvK200d24vbFhBdGJ2dG5uOGhoenM3ZE1hQ0lsMCtMYmNsbHFIQUNy?=
 =?utf-8?B?ckVTdytveEpXalJUZWppK1U4Y0t3cmkyam84QzMvR1hIbTR0VTVnZ1ZwMmlF?=
 =?utf-8?B?OWpxc29DUk0vSFZkOWNObDdQTmJJMjNxWG84WHhUc2VmdjIreUhkcVVKRm14?=
 =?utf-8?B?ZlRLbytVdzVwaFo1ZURONEJCMnROTG0ydEVrdWNTcGhzeGgyMnVXaU9mVkxt?=
 =?utf-8?B?WHN5Y090WnZJUGJ4YnlzOEp1ZzBlelYxeW1hR29BRWlpQ3pwcEdWcVFrd0d2?=
 =?utf-8?B?MnhmOXFGOUJNOEVhWTd4VHBvMTV4TWZQalhOeUM2YWdCa3ZyZ2pkQlc3NE1a?=
 =?utf-8?B?RDh0RG9tZGdvTHRibkdtQUY1T0VHdjRzMk05Y05lSXVTN1ZlV3A5dElkMnF0?=
 =?utf-8?B?cUZ6K25sM3NobmdnMXREa0FUUnIzeS9yVjJEZWt6cmFoREtqTk5DdWxOczR1?=
 =?utf-8?B?UDdUUTVpakhZNVBNWXVjWkRVdm9RTUZqclJCOEZzWVhHWThtQkl1RjZpMXh2?=
 =?utf-8?B?bHN2ZHpEd244OUN4d0ttK2RtWVdvbVZkSm83N0xMUVNNMHRBZys1Sm1NUFJu?=
 =?utf-8?B?b2RyK0JCVmdWWk9ZTVNXd1U5YXp6YjdPVlBrNnczR3Q3S0pPaElTWHZCamJv?=
 =?utf-8?B?Q0FmMFViK1FkaC96d3B5ZXRoOEJURVdZdGl3SGRUS0VGdDBWcjNkdFlDTExP?=
 =?utf-8?B?SDhFOGhaYkJXMHdjRnpLWXBlWEo5RmxDKzc0eldzM25USU5xMmxhUjgxQktp?=
 =?utf-8?B?U003cUdseFVkKysvL242ZU51Tmorb3hyK2NSbUdoMlptbmhPUkE5NE1hcFF3?=
 =?utf-8?B?VzlGSjhJb04wV2ZsU3NSQ1RIR1Zhamt3aVN1S2JkQXdZUmo0QTAvQWZhck9n?=
 =?utf-8?B?QWhSdFZGQlR3S01aWUVTZUxXRjJscWRRN1U5NXhYcGZjZEt1anc1WXJiWkIz?=
 =?utf-8?B?T2pBS0tuTUd4dVZBcmVORnJTSkdKeGhGRzZDajF5MnAwN2FKanlBbk9IdWZN?=
 =?utf-8?B?a201cThBcjM4N21hNHh6M29OY2EvTEVzK3JDcGtJTDNNd0swZ2xmMW82VTBv?=
 =?utf-8?B?d1k5ZVVva2NiaUg0clBIOWw0VGltYVZkRGZzUDU4UTZFVEJaUFREQnBWd0lQ?=
 =?utf-8?B?NEdtcERRYkF0N0FzR3RiWUhWZUppNzU2VGRtUXZidWFuaU1HRDRIbmZNb3FO?=
 =?utf-8?B?dmZ5MXV4eWQ2dDFSSEpERTZWQTVkZkFJVWErZnB3NUowVUcyak5kUXFLVHZM?=
 =?utf-8?B?blVUN3REaWhhTHdrSk1mdGJTbDAvYU1IbFBBVE9FVGlpU0w4M093OGk5cDlr?=
 =?utf-8?B?M0pKUXEyWks3dUpTMDljN2ZEclVwRlMwcFJGeGhMSDNqSUk0RFhsNjVScnJF?=
 =?utf-8?B?dmd1VENoRUpDVnNJb3AyY3cyZFF6bnlJMjJvTnRiMmpOSjZMVjR5WGsvMFJ0?=
 =?utf-8?B?YmxTT09ab1RVR3FQOElLOVJoRkNJL216M1h0K0xDVjZsMmtKZVUwMlFGb1Jh?=
 =?utf-8?B?MWtCUHBWbk12dU5veXM4OWZMZ2NIK0tJb3Vvb01yaEU2N29xc2lFWWF4Y0Rp?=
 =?utf-8?B?TE9CZHY2VE5yQkdQUVF3d0JaeFM1RFNJY1JjTjh5RVdUK3hBN2liaFVBdlBh?=
 =?utf-8?B?bUUvSGc0YWlHWTZxWW9wS3p0RTV4WHpGVWpmTGM1T1BSNnprZ2hidDVXWGlk?=
 =?utf-8?B?b2VqREM0MllhTW43ekdad2dkQzN3eWtydXd0c0NOT25xeVBaM3pvWVZUNGRz?=
 =?utf-8?B?SXZTcDNXTnFGNk5vK1lBVm1ReGNHTGJFLzZaeU10T0EydjVpbEQvQnVJQXVX?=
 =?utf-8?B?bi9kelJiN2I5dU81SWx4MUhha1A2cGlkb2lndVFkSjY0dlA2S1NzZHlZMmly?=
 =?utf-8?B?YTFyYnZYQVFMa2EvVHB6N3dseDlMVThjb0hwMjJZNWJScnp4N2g0Q1BXd1VY?=
 =?utf-8?B?djRTYlpFM2VJTFlDZ1VmemorTStHbkthQ2JVOXVKNHJoQzE1ZkdjRU82M2xi?=
 =?utf-8?B?Z3JTc0l0OXJCbkZuVFp1NGFUNmJlNVJERFU4eXJKa3UxS2hVeHIyNkxnVE9L?=
 =?utf-8?B?SXROY0JrVjBNemlJdjk5U3M1WTMwUjJqZGIyQm1nUkkvWlZDbkhPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cac9211-a541-4cf4-a99c-08de68862742
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:24:13.0733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFFPvZdyX6zMk0K6dkpj16vUvEUH0Hja1XDzKuCMf8iq9PYHiHtGCOcqnhlol+ra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
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



On 10-Feb-26 1:38 PM, Ce Sun wrote:
> Tune the sleep interval in the PSP fence wait loop from 10-100us to 60-100us.
> This adjustment results in an overall wait window of 1.2s (60us * 20000 iterations)
> to 2 seconds (100us * 20000 iterations), which guarantees that we can retrieve
> the correct fence value
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b0540b009e84..5eeea965032a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -735,7 +735,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   		ras_intr = amdgpu_ras_intr_triggered();
>   		if (ras_intr)
>   			break;
> -		usleep_range(10, 100);
> +		usleep_range(60, 100);
>   		amdgpu_device_invalidate_hdp(psp->adev, NULL);
>   	}
>   

