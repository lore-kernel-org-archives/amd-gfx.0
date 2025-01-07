Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43069E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 22:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B1710E3F9;
	Tue,  7 Jan 2025 22:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIOFPWp0";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E037510E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 22:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9KWfhNBdT89AEQYV8jdEWNjJHo3zV2wG8tMN1hVnNWvaESFD+QCMEOgi5AoxPR03X32k2MOkOEzdzNovhVDZchlkHX8py1pUfKqWpM8nsWDpI1Gg4BoEYmFCDg2mrcM7+5YB1iV9XHw5r/1jGC1TKokJPYBn1Z3gDGYiwwBkMhKyV/FpGJjSGaF1nW4X/RCbVwZ+BetTfUv71Rh319JUxaBv0YP7cVs9p6bsIQ1jB5wTF43ZG9H4gZxmr8ZILM06htPEGoKG48H18INcSuyEWFD+809oIMmnOJlhN/SZdHt2LFaz/0ne9oB29NJba56TkvHjbyAwET58/9rkDK+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERZz3p7K42RlA/sqFDQpv4EOGrL7GmW2Y8mubbulhOc=;
 b=uDZ04+E216Sok/1pdj+p21rp0ZnEHpEkjjjv1iRAxINIHSx4IPpNn+1bHS4+gcqSCkjMQZQ/RxWPDl1aGWFGRaxHDY8gqo+TeJeT5JYVaF/NBOZWkXZl98yARhg3Nh8VYnKTzhGHDEbgH/6sVEjwXbgMMj/905RATko59FwJGVOUkVMsXLfWvluM5c2C+acLMwutretLxHq4lOeNE7FMdpVz+WlWmu4p3PD+edav9w3UYQruLz0dhpP8U1fzFyGMe+HqLPwbS4x7LHmi3EHGL7aYbGn7pDdgsmsIUP2gN7NJvwhuU0W35HdV4ldd458yKCsVoaLgkR9VePRzesyWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERZz3p7K42RlA/sqFDQpv4EOGrL7GmW2Y8mubbulhOc=;
 b=bIOFPWp0ANWPcEuam+KBJwjrdmpKmze+/gqtiF6h/KZtmj2rUDLq/a9eU0xcZEcktK2GKwG83Zw6QJcaf3BxLldTE5JY4H4faLjgMLthDp3gHqorxMo7WriFXnmD31Z6EMYx29nlI3/FzumFwe97u6emnzKT9946e171DLTfjqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:45:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 22:45:37 +0000
Message-ID: <c1643df8-f7e7-4aca-a193-17c528a1f9af@amd.com>
Date: Tue, 7 Jan 2025 17:45:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
 <PH0PR12MB5417768A1EAFBB5BCFFC85BD8F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <3d7d3dd9-6c0b-4377-a131-75952d85a90f@amd.com>
 <PH0PR12MB541710CC0F24A33348528E718F112@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <PH0PR12MB541710CC0F24A33348528E718F112@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: ea78e8d2-26b0-419a-7443-08dd2f6d0121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVNtUG5kRlA5cWJ4aG95WjVONzByZmtUZDhXTkJlNnZzRUk5WG5aUlhzZURD?=
 =?utf-8?B?cG91cWdTQ0txMnFYYUtoVHFZMll5eklqVnl6MTAvY1hTZXBjNDVHVzl3bVhG?=
 =?utf-8?B?T2RqMktJdml2c1F2NHU0a3RLVUUxRURNRmljcXp4a3F3TXBrb3VkUmF1Ly8v?=
 =?utf-8?B?TVJOR3dudUFyKzJtKzM4VFllR2JudUVaZHlsY01YdVpsUVpLcmptWFlYblJs?=
 =?utf-8?B?akhCcHZFaVV2bnJSUnVEZ09WWElmRFVkVU5ZZlBGdFBkTjNnejZwMU1rMmVE?=
 =?utf-8?B?NHNrTGJVSnNhUzQ5bjJuY2pnc3ZENTRqVVhvQlhBNTB0MWNDRzduM3hsSVJQ?=
 =?utf-8?B?SEtUR2UrQS9LSTVjZjg2ZUlQaHBHY2Evay9yclM1TVBoRkthbXU2cFViY0Fv?=
 =?utf-8?B?cU5ZQk95UDgrRkx0ZThnZTI0SHloK0VFQ0ROUjh1N3lNbVFNUHUxV1E3eW1S?=
 =?utf-8?B?NEpDQWMrTC8xYTVhZ1dEcmZLQlZxZjY0bE84RFlMak9nM0lZbUhONFd3bDJY?=
 =?utf-8?B?ZFd1RHRjU2gwMG04em1kMzU3NytUdUtYUGQ0bU1ZZWx6aEN2TElOTUpna3Jm?=
 =?utf-8?B?T0taV2tzbThUa1owVTB6WXlxSzJpazB1eTFhMTFiY09UaFluTXYyU0Q4TXRR?=
 =?utf-8?B?SVpNWjNTL0tNOVg0OEpNc1dnQ2xoNi82VFFtMEFhSUptbERxblovNzFSSWRa?=
 =?utf-8?B?Tk42WmpSdTVqcWREZnpjR2ozT1F5OTl6RFA0aWJOMFNtT3VPMjFZUGVCM0g3?=
 =?utf-8?B?VjVZMXJFQkdIVWFRSytDaTNxdjhucWRwbjlMcVdMZ3o3WXhnUE51QXBhdWxn?=
 =?utf-8?B?OTdtM1Y2TEkwQzdFSHJwZnliTURUeFNRa0Z3K0xFbnptM1BkNlRLQmpSNzBV?=
 =?utf-8?B?ZnRZOWtjQmh3TE52RjhEczBFMzY4ME9hY1JEcmw1aHJMOXRNMXlta3dWb1p3?=
 =?utf-8?B?NS9pczFyTlJSV1lYbE5zSk55WkR0WlR4ZDZ6Yi9MTkdKWW9GTVlRZk9HMWpU?=
 =?utf-8?B?dDFrUFBjcXJvTUp2Y0NmRjROczNmbXZzZDdLMWNDSStlWG96ZmVOc3dkd2RV?=
 =?utf-8?B?eHZaVjZQdWc5OWdKUmlKcVZpcVpWK3FWVWlleEs5RW1CQWhidDBma1VhRjBS?=
 =?utf-8?B?SlVEM2hGcUd1UmYrNjZHSnFYQmt2M0JpWWJJVmQxb0xqZEMvV2dTcUNGMDg3?=
 =?utf-8?B?cjVBaGd1aTFPTElJQmNTYTFJUDduNDZmTXR5cExiWkVTSnM0RXNGbnZhRnZQ?=
 =?utf-8?B?OW94ZktCdkEyN3llTnpvTmJLay9kdUFnVVBjc05LcUlScHd3ZzdHVHQrN2NW?=
 =?utf-8?B?TVI0ZENKaUJqVHFHMzJSeS93Mkh6cG1xdyt1NnJEcHVUc1dFLzZBZ2k1c0h3?=
 =?utf-8?B?M0FZVWdob1hUSHJHOEYxMHBsL0VmOHEwYVkxN0pWL1Y1a1dwbWJLdGhlZjRa?=
 =?utf-8?B?RUlHeVk1MHIrMnZCSlRjSHJBVzVuZTFFbjE2Lyt0bkJ5VllDNytEbTFlWStD?=
 =?utf-8?B?R1ZDVElCZms3b01OdTNSL0RLS21QN0NZNFFXRDU3L003MmdJa25KNEpiOTRW?=
 =?utf-8?B?emFOamI5Nm4wcCtWQjV6b0ErUDBKMm5SR0pUcDJEU24xMGxrN3o1MUk4V2Rp?=
 =?utf-8?B?YjA5R2tkdTc5ejVjbExYdGpHZHJGZmdyS2Y2WHZSMDNNVGFLV0dxaXNkbEFu?=
 =?utf-8?B?S0Q4b2VQR0czekQ4Y2VaYmowaExDdkJldkdERldDTVgvSEhWS1BJYmwrZU04?=
 =?utf-8?B?dFVsa3dSMHBnNU0vVmt1N1lvZzAyb3pQRElGR3NsOE5XVWxiM1BLWnNMdi9r?=
 =?utf-8?B?aHhSNFk5VXB2VlpVRXJMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJTNVpFMjIyVWJ0aE1UM0Y4S1ZKaE81REtydjFBTm5BUG1zbDlxcndlOS9w?=
 =?utf-8?B?aXA0L04ydi9uTGl5Lys5VHZDdTdMbkFVQVo2VVpnVDU4K0VNcC96eWhCb2cy?=
 =?utf-8?B?WmZteFIyOVNYSGVna3FTb1BQYnFEM2sxSXluODFucE1NNXNtZ2JQcG1KSmtl?=
 =?utf-8?B?cjVjNzNXR0FSZmlDZzQvUitIWkVFUGt0T3pCYzBRZ2UzZm5rN1hQUTh4c1E5?=
 =?utf-8?B?NTBuN0o1Ym9zbmM5UmVBZE1xaGxuKzNpbXFVeDRPNEsvYVl1b1pYUHRKaSti?=
 =?utf-8?B?MG1KUFdLbVVaclA5VTdLYlF2THJmMXNubERYNVkxN2tkMlJYN0RHZHlMZkI4?=
 =?utf-8?B?QXZGRjRobEZ5ZkladElnT01HL2ZsUUtkaW5uNXBVV0dFWXUvSlBIWHlEUnpX?=
 =?utf-8?B?RzRiS2NQV2hNaHUrQVVRdVhIalkza1F0TlozZmpNSUZQWWIzNWtycTk1K0s1?=
 =?utf-8?B?eXVOczNDZzJNdGdJRFduZElYMHBDcWoxL2kySVE0akVwSWw3QVd3THpvZWI4?=
 =?utf-8?B?dXRFaWpTSERHcWlxZ2VwVEFjMFQvdzVyYjhTQUs0RVRjYyt6c3h3MldPQnNW?=
 =?utf-8?B?c2VZQlZOUnZuVlFZUkJlblR3S3lhTE0yS050WExjbHRpN2ZKTjdCOW00b2cz?=
 =?utf-8?B?WUhMWDdWTlI3RFd1RmRydlB4S3BFd21nN05pUEpwUFIxTTJONVZsV0VPRThG?=
 =?utf-8?B?MzJmUWN0Z1RXYkxDbmJ2TU5KcmZHVVhPaEhuV3hub09oeUU3emhJODhjSVVo?=
 =?utf-8?B?ZzF2bHh3ZTd1Tll0QlNsYThnUVJrVjdKY2lUdmdaNEZZTTVPaFA0YzhXOEVZ?=
 =?utf-8?B?Q0VnTTNrVWxjS3lkMHI5aEZ4VDdoWHF6eFhUQlFNcHdMVEx1TTBsRVBQaFlF?=
 =?utf-8?B?SjlOdXJyT0NJZTE5VzZzTVZwemJGeXdDRmxJdnh3VEZlK0luakE1cFJEYi9s?=
 =?utf-8?B?Q3g0SUZ4czhZSXllVWlWb05wV2tGV0s3OFNaSjBUdWV4L0QzaVppVUlNQ0U4?=
 =?utf-8?B?L0JscjM3UXFkN2ljSmQzUlQrT08zbjdlcmZNVXF1TkpxMlJaSnZqbXBSSHBz?=
 =?utf-8?B?WWpubW9lUURJRVkrc211aFZ4dWEySmdSak92SlJLbWRBMjlFcXhRWEg5cFBP?=
 =?utf-8?B?TEg5b1FpL21qL2hkbnZBMWJEc3gyYnUzeDNJSXgrdUEwRGMzVThRR3phMUhY?=
 =?utf-8?B?a3IvWG9XU1dCM2NHOVhLaXV6cUlvMWJKdjZXcFpET2wveHFrajJ3dDUvVUZq?=
 =?utf-8?B?RjFjTDVud0hKUlBQeUt5TFpWYXFRVXdsZklTSHhkRHZCeVU4WFFVeG1sQlJG?=
 =?utf-8?B?dG9iMlNselp6ZTdrRU82V2N2eEhWMWpNMHgvY1gySWVuNUJObHZ0SkdJKzhZ?=
 =?utf-8?B?N3hwZDFsb00yOVpjcVdOTjErV2dGOE80TjBJd01rMFhxZWlORVkwWjA5a0VD?=
 =?utf-8?B?c2JlazI2VDJBV1h3ZmtIWmJYenJwRDV4d3UvSi9lSnJ3NVQ4ZXhEcHhjamZH?=
 =?utf-8?B?TUc5aUZ1bUlmejZCNUJMeWR2YXp6RzlkaDZSYlUvVTdZNTd5QkVNb1IxNi9G?=
 =?utf-8?B?UWMvZWh5MlhIKzdFQmdEZXNUb3JVaE5WWm94c1M5Z21lTzJnTXhMaFRvc3o1?=
 =?utf-8?B?R0Z5d2d5MnpaOXMweUF3QW8wVlVPNkZBdng5bFpmMThqUHZtLy9vNVBndGxJ?=
 =?utf-8?B?MHBQN3hWNTZDbGdVMkQrcGV2YjZieFNwVmtPOHo5RU44UnFxNHRsTzlxZUZx?=
 =?utf-8?B?NEdWQy9TVVBYbEJoSUw4VW85WVJzdStqa3FFYXZyRlBSZ2xGcHpIN3k5YTYx?=
 =?utf-8?B?djlCaWtCVWNheW40RkRxdFlTNnBWZkhBdEx2Tk1sa1BNTXN1OFdEdjljdEdO?=
 =?utf-8?B?Q0I4QW0zYkJSRDBPeUtiSEU4cFBVZ1ZOeWFUYnhoZ21ub1ZWNlhRU084bjZQ?=
 =?utf-8?B?bkppYlRrUEZNNFRaYTlwa29lbTZ6RzBTVUkwSTZmMEhDWHBZbU82SDAwQkNO?=
 =?utf-8?B?R1ZMTG8ycXFJVSt1Y2Y4WlQyVGZBYytvUVFnMWlYM0FPQkdzOTY2UFFqUDdB?=
 =?utf-8?B?M1RMNzMrQTZWTE1BZTFaeWVWbGxNYkViQzlTdG14dkFjOURPa1RUWm90WlJO?=
 =?utf-8?Q?ZMPzEvbiXFHE84Muf7xUDAO7o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea78e8d2-26b0-419a-7443-08dd2f6d0121
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:45:37.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvJAm4VEkJqcX4j66PfV6nVxo0YgatI6IkK66Rb2mRIKdIZax9RPsgZmz2aqu8Rz9O8XA/15VJ0Zfn902DPV8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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


On 2025-01-06 21:10, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Tuesday, January 7, 2025 4:53 AM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
>>
>>
>> On 2025-01-05 20:45, Deng, Emily wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Saturday, January 4, 2025 7:10 AM
>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
>>>>
>>>>
>>>> On 2025-01-02 19:06, Emily Deng wrote:
>>>>> For partial migrate from ram to vram, the migrate->cpages is not
>>>>> equal to migrate->npages, should use migrate->npages to check all
>>>>> needed migrate pages which could be copied or not.
>>>>>
>>>>> And only need to set those pages could be migrated to
>>>>> migrate->dst[i], or the migrate_vma_pages will migrate the wrong
>>>>> pages based on the migrate- dst[i].
>>>>>
>>>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>> Good catch. But I think it's still not quite right. See inline.
>>>>
>>>>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> index 4b275937d05e..5c96c2d425e3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node,
>>>>> struct
>>>> svm_range *prange,
>>>>>                         struct migrate_vma *migrate, struct dma_fence **mfence,
>>>>>                         dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>>>     {
>>>>> -    uint64_t npages = migrate->cpages;
>>>>> +    uint64_t npages = migrate->npages;
>>>>>        struct amdgpu_device *adev = node->adev;
>>>>>        struct device *dev = adev->dev;
>>>>>        struct amdgpu_res_cursor cursor; @@ -299,9 +299,6 @@
>>>>> svm_migrate_copy_to_vram(struct kfd_node *node, struct
>>>> svm_range *prange,
>>>>>                struct page *spage;
>>>>>
>>>>>                dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>>> -            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>>> -            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>>> -            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>>>
>>>>>                spage = migrate_pfn_to_page(migrate->src[i]);
>>>>>                if (spage && !is_zone_device_page(spage)) {
>>>> We should also check (migrate->src[i] & MIGRATE_PFN_MIGRATE) to catch
>>>> only the pages that are ready to migrate (i.e. not already in device
>>>> memory and not pinned by someone else).
>>>>
>>>> Regards,
>>>>     Felix
>>>> The code " if (spage && !is_zone_device_page(spage)) {" is already checked
>> whether the page could be migrated or not. Because after called migrate_vma_setup,
>> for those pages couldn't be migrated it will be set to NULL.
>>
>> The page may be non-NULL. If the MIGRATE_PFN_MIGRATE is not set, the page
>> could not be collected for migration by migrate_vma_setup and it should not be
>> migrated. See
>> https://elixir.bootlin.com/linux/v6.12.6/source/mm/migrate_device.c#L470
>>
>> Regards,
>>    Felix
> Sorry, don't understand clearly. If a page couldn't be migrated, the src should be set NULL, if not, I think it is the migrate_vma_collect's bug. So could you point which code path
> it will not be NULL.

Looks like I misread the documentation. I thought there could be cases 
where a valid page would have the MIGRATE_PFN_MIGRATE flag unset. But I 
can't find that in the code in mm/migrate_device.c. In the cases where a 
page cannot be collected, the src entry will be 0. The only case I see 
where the MIGRATE_PFN_MIGRATE flag is significant is in cases where host 
memory was not allocated yet (PFN is 0) but the migration can allocate 
0-initialized device memory for it.

Regards,
   Felix


>>> Emily Deng
>>> Best Wishes
>>>
>>>
>>>>> @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node,
>>>>> struct
>>>> svm_range *prange,
>>>>>                } else {
>>>>>                        j++;
>>>>>                }
>>>>> +            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>>> +            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>>> +            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>>>        }
>>>>>
>>>>>        r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i -
>>>>> j, j,
