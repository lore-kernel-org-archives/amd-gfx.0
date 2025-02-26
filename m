Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBA7C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 20:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09C110E23F;
	Wed, 26 Feb 2025 20:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8pd8bDr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09D010E23F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 20:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTyJfdKIBIFYcwwRlZHE8vNfERJHNCbE0IH7T8kKX3V+G2w3DZp8H5VxA1OhOWw/qo6Z9hB1mcr+zmdOMsfA8qdxvc3aXtIeLwLMNvh3MAn/Hk+/e0gtqbWT6N8ejZlWNK1bB9/ROUMFW6u/Ho/ll+MjaCUitFdWKLb2H8FbJXG4YH7Dv9xbCtyXporlkReBcKpcGH4GNTHaexmeJsx1xgzeJHe844D2uM1dvM2nZu5qEXfwig4E/qqSNqedAhRuZa5IhLkukrW3D3R6SceFMzpK8qEwQBGZaQQJErxfLEwS5ewTrzpIA1StmaKzngTZVatacH76GG0bJsMBrEr46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X8A69zPXSmyOT+GJ7TYaM+wYAHjxtAxDIXEvkO1ufs=;
 b=LI9LoRRU0sirl1frcRe8ohoYPDC95vuqHrfBO7iI+GgWP/DWVLvuvjq4RN3aeR73ZxHhxveQn26Qgea0OS8VNBhRE59XxBag20LY6IuMEpQ+dp4W1c2dc/rGfy1TQweVdqT25VOHGOzdWYBhn95eD8VuBwc+XiCXnBHrQJDM0O4bcYQ/BQV6VPyI6JyvgRqzQwn7sAt8bXvVh4VtF3nn8Da4HUiz2VHCqr7jx1h/Wq13SOuUKQcWGs5TJLYNLYODR9+Pe70c/g1EbD5+SyOWpybZ4T2ayNIFDLnftKvvHX6rT3yhKc9wV7eMM3+9w/HXcmGN+yn8f+UnjwSIbJ/UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X8A69zPXSmyOT+GJ7TYaM+wYAHjxtAxDIXEvkO1ufs=;
 b=E8pd8bDrnbFVYFDv5I5QU6TxtX4/tgGPHfEgxgc2UConvy/uxP1a387aZBRRqstaGjiKlXtuG9OpDaSLuQNQs9jdR23SI6TKKGbTjm0b8VIyxcZVVX7eBrzCPonbeMfGqLDF28/nIcteBiNxFmwsw6AlUIE8OboIxVMEy6gezNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Wed, 26 Feb 2025 20:55:28 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 20:55:28 +0000
Message-ID: <8c6e1698-9e10-4db0-ad05-27f9d95eea2e@amd.com>
Date: Wed, 26 Feb 2025 14:55:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: clamp queue size to minimum
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com
References: <20250226024132.613233-1-David.YatSin@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20250226024132.613233-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::7) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e597bebb-2af3-462a-ef19-08dd56a7e651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWR5aWpRcUJoK3NRb2xVbGdIb0hUQnlaRDRBc055NG9RbS9WVnF6QVVtOTIr?=
 =?utf-8?B?NVBhQU96ZU1FVHJ5UE54czdSaHQ5SDJjaG5RSEtrbFZqa21IdHM3WEkxaGkx?=
 =?utf-8?B?ZUx3dVlRS0ovdGpUSzJvbVBxN1BzVFVmak1xNUF6QTVheFl4M01nczdIU2Jl?=
 =?utf-8?B?aGtyNWZCdGxHa21XaDg0QUt4dlJXT2RERktjOTlNNEk2bENOUXFCRDRsMEp4?=
 =?utf-8?B?R1FlWHA1bDRlUWRlYkxSQ1VROG9MNHFDZ2RsMklzYnM5bGY4eWV2RDJTYkxq?=
 =?utf-8?B?Z3p6eE10WTNHbVFNTWhPS0F4T3M3eSs4WkJURjB6YTQzQTFWTnFmdE1TVFpX?=
 =?utf-8?B?dlJFamxqeWNTcVU0bUZ5a0lhRkpybHFHZXRxUS9aakVRYkdGSnRTbGZnVHcy?=
 =?utf-8?B?UTlYSGF0R3BBVDdadjVRTzY0aDlxQ2VZRk9JenROWnNqeFRoK3FyZWZEeC9K?=
 =?utf-8?B?SmNESktvc0EyZUJ5Ny9ONFNGRnpiYmwyaC8vT1dOR3BFYjlDTmZmL1BJSzh2?=
 =?utf-8?B?VUNxQkRhWjRYUnQ0Tlo5ejRTSUtQd3BHTlU4SVVxQmJDNWFmYVRLMnZNK044?=
 =?utf-8?B?NVA5aEdIVFZNY2VLNHB2bzcxeTlOaGRSY09DRDU4bE9uRHpiaUVyak1Oek9i?=
 =?utf-8?B?YzdZTnlwN1FieldkOGtaeWt5TTZEZERVZXRnTk52dXBQdGcxMjk4TDE0b2NK?=
 =?utf-8?B?ejhtcHM5Ni84c3NUcFpIb0dKU2Rucm81Y0IzWEF6OERob3JXay85dmRBQVNS?=
 =?utf-8?B?WGlSSzZiUEpzcVpvT0R5bUZ6YVFzenVvOXl3UHloM3M3d05ESDU0M0c4clRn?=
 =?utf-8?B?Y3BtckpDYU9icFlEZjZ1VkNjajhFMENSSTZEOGQ3MTZqRFlCVzM0VTYxa1oy?=
 =?utf-8?B?TnFSVzVQL2tkMEhCTEZxOUJpeW1ISlFCWW9ZaTlvYVBKbzRHaGQ0dXUzZjEy?=
 =?utf-8?B?RDk4VHNDNWFTTFFLWldxV0FjbnRmaFN3YTM0UG1GdSt4T2pLSmcyS2o1Qzgr?=
 =?utf-8?B?VVQ3OVQvYXJNYjJwZVc3d2VlOVpFSU1BOWd2MVZ6aW9DbmZYTGFLZHZhSjdm?=
 =?utf-8?B?U3FSNG1hdFNyM2tEbUhmMWFUQW42c2doMTNrV2p4TXJpL3kzSlNxUkZRZXFE?=
 =?utf-8?B?K0EvTUtlSnYrbXJmdThZTUdLUjlzNnV4UnJVSkRDZTN2ZmhReE9DVFUyVUdq?=
 =?utf-8?B?dFo1MVV3TW1ZSlEwaWR2MlM0VkU5OUFzZlFNTTNLR09IREJrSFY0bmd6TTFM?=
 =?utf-8?B?Q053aWFqRzJ6TXdZS0laOGpoYUVhTW8ycHB2NlRBNEZaUGVkcUZUbHlqSGFT?=
 =?utf-8?B?MFUreDFoZXJNL1J6R29hRWcrV05RSi9HS0kyaEVxY0VMS2xDdTlzbGZPQkly?=
 =?utf-8?B?QjUwNHZ6QXJjZFlUZkdWRjVYc3lQTDRucUhMQTk5VGRnSm94VThMN0R5ZkZW?=
 =?utf-8?B?MVVrZEo2S2NmYlQwU1pDYVJDMDlYQ3pyVC9STndKbWh1R2xuZ1VHb041NDJY?=
 =?utf-8?B?QmIrZGU4WEFLZUVzYlpJU2w4RE5na0h2RDYyZWwxNDFReS81c1lCY1RxaW5F?=
 =?utf-8?B?T0sxdTZDMDdUWTNqbWJZekxsTU1rb2JkbEhyS1kza1ErR0dHM2RKWkRpUEd6?=
 =?utf-8?B?SGZydUZSdGFkSGhIbWg2bUllWU5VN0JTRStFR2ZtcHNHTmp3aXBveC9qZ00r?=
 =?utf-8?B?M3JRaE54Nkt4Wkk1ODRPNS9NaUF3OGFmTGErcCtKd3RxNmUxTlJCeDFYS2kw?=
 =?utf-8?B?ajlLeXNiQ2NhU3MwQTR0RnRvOERCSnhib2Zod01GczN1dTBlTm8wTmV0bHBy?=
 =?utf-8?B?ME1oN0h2NllXYW8yUzVKZlBINXB4TDAzRmlWNnlYeTBqdGVsRnIyR3JNSWUx?=
 =?utf-8?Q?LP4LPE38lEtTW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW9QZFF2TkRsTXZpNWk5eHYzdjhtZHhJc09xVFFSWlJjVDk1amVFWUR4SFU5?=
 =?utf-8?B?WEkrbVhSN1NzVmVMOUQxN3VBazVMUWtRZmlYeTNDNUNsVlRoUTliYlM0ekUy?=
 =?utf-8?B?NVl3V29TVVROQkFOQzBvMmF2dzNoK01sMkFWakdzSEI0WHhmYVFvdnBNOUIz?=
 =?utf-8?B?VkxjY0NkcWF5Y29MQWlEWXN3Zk5WM1FRNXJkOFBEMjFYOHkyTFFWL2htVWtQ?=
 =?utf-8?B?YVFKdThERDdVTlVPbi9lVjNoZDcrRHV4MXljS2Mwb21LNnZ6ZHdnMFBmOWp2?=
 =?utf-8?B?aGJvZGZxd2pmRHA2aU9PUjI2alNqWithU2lmRG1qVjQreUVlQ3YwR2pGZVdV?=
 =?utf-8?B?MVBWNlZ3ekRvVzViell5elBUa29QVVVaVUxxWE5UcTc4Z3p5Unl3TVI2VURr?=
 =?utf-8?B?cmRPalJYaXFRcU05K1Fwa3kwVmtWbnROQnQ2aGIvN1BkcTNkRnord212bWVi?=
 =?utf-8?B?UU1MYUFqTG5URmJQcTJwVlJ6QnVqQ05YSHRCbEw3TTFDNnJzVVVGMnlnWnRN?=
 =?utf-8?B?RkRrME91NjVZTlVGcHl3amV6dHI0S1NlOE8xNnI2Vk85YW1Vb2U1Rys1QzMz?=
 =?utf-8?B?RWJpblMzRFJPamVLZ0FCakRDdEdMd2tRUlprUnMzWW85TDF3UGI4YnBsdHB1?=
 =?utf-8?B?WVR1emR1K1hYOWNXNFp4S2tUa2cxUDdiUytFSHJEM1lYUXZhTmRTb08vWUxw?=
 =?utf-8?B?THNHSlo0UytzWHQ1RWE1UnJJb0svMENhc3QzWDhpMkY1MHMyTzB4N3RQV3lp?=
 =?utf-8?B?WVVabnhDVE1HeTZJaTZWem1jTHlFRnp3SDQyajlmaUR5WVgxTlhLbStNQzZm?=
 =?utf-8?B?c3FhMmhwN092OTBiSHhhZzZGekw3MGtQM2k2VUR6dk1ERGRBUnExc2dsb21l?=
 =?utf-8?B?RWxLUkVTdG1hWDNsWG15VDd2SmVWeWxjTktzODQ0TTd0MHhHSkk2WHlMb0pX?=
 =?utf-8?B?d0J2aXdiMTlpR3lMSFN4ckpRSlFpNGRJcDVLTUNmMWNmYjQ2YVFiMnhGcEJR?=
 =?utf-8?B?WlE2NEMrZHl4NSs2cmpMMGhTRHM5N1ZiMjVITWlDK2haeUNxVzg0VmZlbytB?=
 =?utf-8?B?U0dsOTRWemU4UitpWTRLZDVnMFBvaU5mRTcybnVEaWJldmJDTjZaWFZZTEhk?=
 =?utf-8?B?UkJabWhEY1hjY2J3bDJVSXpoa3JEZittQXZ1WHBySFNNYnUzTXBSYTJ4Ykhm?=
 =?utf-8?B?VWNIREVTTkNtaTZGUy85TTQxT1cvaVVnM2hPOENxREc2VWVYTGFHeFVqY0FL?=
 =?utf-8?B?RkdtdXdocHE1VmhoL1d2WmpJTWtPVkZXdTEzb2xneDU3SFhtcWZCaFZNR1Fx?=
 =?utf-8?B?WTdHNURGeHFUb3BFWk9nL0dHU3E0aFJNcXptcGplVkdMUFYzaW5FdVRtZ2Yz?=
 =?utf-8?B?SDRXNTZyb3MxRHJiRnhuRDdnYmZrVFIxc0FlYkFiOGFVRWxpNlZMSG84VWtj?=
 =?utf-8?B?clg3RHZ0OThycmtseG1CWVpDN0RHVDQwdVVRNjdaLzZndWVPenZ4bW5VQ1JR?=
 =?utf-8?B?QUFGRVNHbWN0RkdodWw4MjY5VlFKRlp5TmFKYkpwVmtXd0J3aFhOeVhIZjE4?=
 =?utf-8?B?cUVnT0Q4UkJ6RmxNQ0VncUx4SVFIUktpajJmMXlqaXB2b0x5Rk9ocmJlSlli?=
 =?utf-8?B?WWpDdmwwdnJtQkRvdlhwSUtmbGNOYTJBeGZWMGNQNjMwTHFvclpKMnZtSWxE?=
 =?utf-8?B?REU3bStKZHlEaVhOWDQxVXV1UXZJc0g4UzhRMC95MmpHa3oyNTFlZ1QyblBD?=
 =?utf-8?B?eE12RWxWdDZ1MFh0ck9wZTlRMUt5WjBJSFlCR3dwWVF2aVVFOFZSUGtaMlJF?=
 =?utf-8?B?Y3l1N3ZwVFZDR2hVL05hd2NRb2pyWHp4U0oybXVjR29DTjdoRHUrUHpPckgy?=
 =?utf-8?B?RmwrdmlOWHpBU0RVbzlydytlS2oxemVLU0phSTRYOE1lNGRBMDlYdXVRaVZm?=
 =?utf-8?B?bUJKMjFKS2h5cnZlaWFuVk1FM0NWSmVMOVJZTUlURFIwSUVFSG5pVEZFZGph?=
 =?utf-8?B?YnpPaDh4SXd0RlVRRjJQdVk5d0NYQmxMUzNoR3pldzBLU2o4NG9UdEJoZVIz?=
 =?utf-8?B?QjdtdXZ6Ym9PWm0vWGJTWUVXL1N5MHNLYjlKZ043Q2t4Wm5UYlVGd1RiTDdS?=
 =?utf-8?Q?Syw8iry56uAAEwomG3/7WIIvB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e597bebb-2af3-462a-ef19-08dd56a7e651
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:55:28.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zqvGC1RlcDI/8CEECtueDq52/ujXR66E9XR5YpMMPlNx2Hgk5rlwa67nX1uU5UNEgXzdfDdMLpmXksIIE8vrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

On 2/25/2025 20:41, David Yat Sin wrote:

> If queue size is less than minimum, clamp it to minimum to prevent
> underflow when writing queue mqd.
> 
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
