Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0922CCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB1010EB08;
	Fri,  7 Nov 2025 15:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="goWoGabi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6DD10E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM5Ihm1dizXy0vptLH7O6m+kYOiofPjArABFrmT/j5DKEWMm5P4ItYjKPWr3QVT3iit6II1Maz+BdA6AZoGNvcE5YwBPXCfxk33uJ6irJvW40DvrhMofjPMLwl4S0CmGO3yGKn6RIg8Cg8A9LGzU7oYUtlDu8BEyto8jbEkBF/hBULKpaKUFPbCIk5HCj0cmS1Lx/5LakdElj4/3qdI88+qmVDQiGFaV7KD7mX+4jxaFO/gNY0sv1Pk4UpiSJKXsp8zQI9CjhFpRThAKKzLQFA1PEXD5BJViSdRtQYENwNIIRJSUse+GhZ+FXXyvgLoLxRhRPfl1A7iNLr0ccvN37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVf45qsoQSkU6BEVJUAZT+CzX5efjXY3BGnj1qomg+8=;
 b=Hq8C8s6c/CZwvYhoJMNuE7Yopllz6uCUEYxXtmLE10gUmCaowwesvjKckOSdzt2RIFNl6CV1COuRmV6GDa0MW0zzrfN5AjHJUgsDziFmPz3ggggSxnD7dbxmGKvOk9ORvhQQ+IpP2GMTNBXG3sRSDQWpeIbqaxWI38zjIxbBSW8ELKyUZmNlIqgiCRRBsNZe2Fw/yFBR7F+D56Ci2ZrBq1Nbq0wz+BqAzKPjNsByoLZKSydcFATiPXJKZA21KRGoMvEVibHg3nFGsoFAWvF+CbOXILIoPoXvPTBIpiMqvYHsjot3hEa031p2rYK0etnWCOrVz4Yre3SZxGQLg5szYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVf45qsoQSkU6BEVJUAZT+CzX5efjXY3BGnj1qomg+8=;
 b=goWoGabiR17r11grS3lO30ed0aeixR4ai7wuORGE+C7OFtACIuDLCyJZFkGf6ItiTJusjLLV8duJ+19jFIfMYnuiYjqgnUzkfqp9fqt7B994o2ZACpeqlAGTeMO3hcG3TQqxndyliIdQwxmhS63NhduTIaTZ9GexU+5twMTbZec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:37:10 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 15:37:09 +0000
Message-ID: <d679bc66-bdbd-4402-9230-85168b73e77b@amd.com>
Date: Fri, 7 Nov 2025 15:36:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of save area
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20251106202709.3242005-1-jonathan.kim@amd.com>
 <CADnq5_Oa-WSYpQOJfoHPqacoyPKiK+DrkAr78jkUvT=mB4iN=Q@mail.gmail.com>
 <CY8PR12MB7435CB5408C5EA5E1C5EA37585C3A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <CY8PR12MB7435CB5408C5EA5E1C5EA37585C3A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2530a2-6088-45ae-502f-08de1e138376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2dkSE1lUWYxQjI5VVFkZXlWTFFmVFVtQlcvYjV6eXZCMUY0c1YwQXo3ZWp6?=
 =?utf-8?B?akdhRkVGMldpOFRyNTN0YmZMNXg4bXlUVDlEaXlTMGJHTzJjNHVVRmZicGUy?=
 =?utf-8?B?VUFaMUwvd2Z5a2pOZTRCQVNaQmwxYzcxYi9pMVZBMjRYZHFHUE9BdUF0WVZ1?=
 =?utf-8?B?d2JhMndHWUcvam9yRmxvQkFXb3JsNERXSnNwZjl4aktjMmhZTU5TR1FmRTd1?=
 =?utf-8?B?cGRNN2xXY1lzZ2UzSitNRW9FSmhTOXVQeXBjN3lvZkJxS1cyb1hyZEE2YmlZ?=
 =?utf-8?B?bzVNKzZhT1ZmVEpSb014V0NQemtRZTM1NHZ6ampQSHkvNUtBTEFSdkZjUGpK?=
 =?utf-8?B?Rm8yb0tYQXQ0eGY2RkNpY0dCY054c2tpZzUyTFVxeS84aGx2WVBjWEpBVytS?=
 =?utf-8?B?Zzd3bGs2YzlUSlByNXFKblhaam9SanFQVk00YStxbEpuSmp6NDlvTFRTWTdP?=
 =?utf-8?B?WVpEZWo1cWo3V2xCNzRtV3A2WGwzVXJXUGU0UldDOWJ5a1FQcXpkbTNoU0RL?=
 =?utf-8?B?ZlZnU1dYYVZEY21UMVZPdmxHT1hVTUoxSktRTjhmeGtMUFQyeHpuM1dRN0tk?=
 =?utf-8?B?LzRNY2ZJV3MyTkVYM0x3VFRCZnNidEh1Z29hT083ZlNnbENPTjZmakRHRGg4?=
 =?utf-8?B?R2Q3L2J3RzBTUlVORzF5TXd0Y3hBZzY4VjY4TmYxS3VFbDhzLzA1azVPL21H?=
 =?utf-8?B?ZGFWWWZXbWVHYjFkQW50Q0VpN3hnLzMrd2VyU3JIL29QYm9YUmxMaGdJN2FE?=
 =?utf-8?B?M2laRVN3dW9pMGJXelVPbTR4d1FkUTU4NGxtNU0veG5VNkdJSHB5QTVSL0RJ?=
 =?utf-8?B?NjBvUnprd0Q3eTJNdjNETm9aN3k3NFJ0QXN2SmdzclBkNTBPTGxUa0VkWEdD?=
 =?utf-8?B?ZlAxRVY2bHVPbTRHV2l4VHdLY1NqUlRPMkhqaFdXZEVWYVFla3NkWk14Z2kz?=
 =?utf-8?B?R3Y0Vjh4V0NrK09NZ0NDT1ZSa0RaTml0YUJjVmc1bmFCci8vSGJxZnpFZUs3?=
 =?utf-8?B?UmJyRHdDenZSQzZSRkluSVRVdWNiWXdZMkQ5bW52amduRGI4Y2Q5UkNCODNm?=
 =?utf-8?B?OENsSTY1MGVZaFFKbWhFMU4wblNVQzlxbTlhaVFiWlRYaDdtNXl2cUk4eEUx?=
 =?utf-8?B?ZE9za3BXQ1ZTMTlYYU53Q2RoSGZPMzlaMVB0bnFpTlo4c1lHMUc1SklnUnpU?=
 =?utf-8?B?RTFvWnZ1M3hFOXAxY3lNRS9neFpDSlRFRXFFWXhxTHpxZ0pKR1k0TDZlL3hm?=
 =?utf-8?B?a0N2aW9uMFBPTzA4ajVmekJrRWg5anBHYXlyNFdrakZNemwxWHFIaElpTTB3?=
 =?utf-8?B?blB5c2JkTXVJdEZkNVFWRnRBMlBxN2JPdFBzbEVOWW9HeHdFaHVpU0daWnpk?=
 =?utf-8?B?Zm1IVVdkREx3TWsxM0MvSHAxSjZHNUNxSFBwWXJLSzdDa3M4M0FFdnNTM3lZ?=
 =?utf-8?B?ZkJ1TFBNRTFRYUR1QTllWUNXNDZ0bFhJRU1LWU1Kb2RHYzkzSDRObUpzVjF5?=
 =?utf-8?B?NTNGUEMwck5BVHFNdkwwdEFNQ0x2V0tsYnk2cGVNUWhnNE1uMjBjcUJWNGx0?=
 =?utf-8?B?N3VBeVEvMTZKT1hoL2oxNjJQYTVJRjl2R2JZdmllN1J5LzFUeEVsM1BMNGN3?=
 =?utf-8?B?MXVHNnkwTzZkNlR0MDFwTW1NOHgvUTArTk1xZE0zTVVkcVlnU2VCQ3F4UDNh?=
 =?utf-8?B?cEFVMUsrZXcrVjlSTDFZMU4vMmcvbTdrWXdHZjl0ZFllczBhMWZRRnl6clRB?=
 =?utf-8?B?dXZmeTNjdDBLakUrSFRIOVBDbmxBdjh2YXFRTklraXNQOFVveVNJWjd2TCs1?=
 =?utf-8?B?RzBUK0dWUy91aW80STJGbUVTeVMyb3ZIa0Q3ZDJZaUZKRjlQSWcrV2dvaXdH?=
 =?utf-8?B?QjV5aFQxUVRNQmtFZW5zWW9BaGc0N1ZzS2tZMXk3TGFKU2hndUFQaUlEdTQ4?=
 =?utf-8?Q?MxNuGhcMu9XVCjMxyoMSuNU+rqNy4kTE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBUTWlDS1dCSXRvajJtSjFHUytIeDdtNUtUTmxhY3FxNXVidGlIWDVCT216?=
 =?utf-8?B?QjZ0bW92LzY5dk54cDRydnZMclhVZk81VlUxWXgyQ1B3dEtHZHZod1p3dExq?=
 =?utf-8?B?b3pYLzJjY3BEMkxnaENjbE5IbTdlak4ydlBFS1NZQTR4YWhnelpveU8rclpI?=
 =?utf-8?B?WmpvVWVsbTBjdmpjbGlhYi9UUjNHSzFPaFNGRU5QbUs2R3lqZ3hkMTNMTG9I?=
 =?utf-8?B?WXJBVzlHU1hGMjNjQUdDMGZvN0JtUmFYYzlSWHRSZU5LVU1QbFVuU2FCUmM4?=
 =?utf-8?B?R3k2VjVvVzdBKzJ5T3drUEsyL3V4ZTBLYlg3OXR6NjJOZXZJbTM3Wkw5Rlpn?=
 =?utf-8?B?N21vcmFZZnlnbHhTbE1YdDZwcE9odEhWNUNyVW5pRnZxYkxlWURDaHQwMnFD?=
 =?utf-8?B?Ymh1clBYbjllRkZCN3l0RW9KcVgyZHBaaUdrV2c2VnA4bFNRVUNXaGwrY2dD?=
 =?utf-8?B?Wlk2cXBRYWVXZERmYkZONXJLUFFBQ1pJTm9XbDJuMys3a01PanExN091M2xn?=
 =?utf-8?B?NFpzSENqT0VhL3Z1cEo5YnJiUlFCS1o5L0UrL0V3UENMRSt1d0lNQks2MURj?=
 =?utf-8?B?Zm9KaFUwQlRoSU05YlNBSWZjdkpmaVJLcFdZVHFEK1BkWnVUeFRZM3RINnJi?=
 =?utf-8?B?ajh2Zm83bU43cHB1bVJVUjcvR1FyZ3J4RTBmbEhFcGQ5Y296VEtSSmFXbVhD?=
 =?utf-8?B?Nis0bEFWNG1ibW9CbGcrRHVBdGVrNEFkZ0NsQnkxbmpWMlkxUFFKVUJuTGsy?=
 =?utf-8?B?UlBzT0txcDNzdDVkNmtQbGR3MUZtN1pSQWswOTc1NUFybU1FTUt2eWdzazdh?=
 =?utf-8?B?Q0RaR0pDVkxMQ3lEeU5uOWxrYmZheW9ab3hVdkRsZWxuQ0dQeU5najZTYUtm?=
 =?utf-8?B?enpnVkR3ZE1pQkRyUDh2NXNjMW96M21jaTZuWEdkc2tvWVlLYk9zZWVHNW56?=
 =?utf-8?B?QTNHOXduWVlTOHpjTVlGb2lKVm55amJpSU5SakhMZ1R1VjZ2S3dMcjI1cXJ2?=
 =?utf-8?B?UStQMmswc3hVa1dzZWxoM3NzYVJtSy9lTHNzNSt2b1FCWTFpc09BOE9PNU8z?=
 =?utf-8?B?cHBNZDRuazhUbjdIazNDQXdtdzlCVGl6TUpDZkNwdTB5NTdLeVV5V3g5dTRv?=
 =?utf-8?B?LzYzWnZZZTI1UmdNck0xaHdjSnZlY052eTJHblVKbDdPY0ovUFJ3TW1lVngx?=
 =?utf-8?B?eGlDeUd3ODQ2a20rcmFJNElyNjROenBQRnF0NGtIUXdVcC9OK1RwNnNqZW01?=
 =?utf-8?B?SVhUMUJqTzlDUUFnbStIYzBkS2ZORWt0Ry9zQWdVaEtHRUdKTlFERitTalFv?=
 =?utf-8?B?YkxhZTNmQXY5emlLckZ5cE9za3pzRlFCSDVEQ2VOK1VyaTEzMVVqeHNMLzZQ?=
 =?utf-8?B?a01JeEJLN3MzV243eUdQUjJxY2NHV3BwK005bGYxc3Q3QWw4VWU5NU4zaGor?=
 =?utf-8?B?TTgwOWdWRzkrQmx6T2hmOVFMUDdFSkE2YmZjY2tCSzNxYzN3SEk4MGNUeXh2?=
 =?utf-8?B?b2d2R3czNnI1K1M1VGlGT1I2VzdwNXkzZUVDQitYRnc3QUszejV6VUlOamJp?=
 =?utf-8?B?QURFTjljVzVFdHQ4TWl0emhqajRoYjFDejJvR3NYVDliNjNjRVpUazhRajhB?=
 =?utf-8?B?dE9qdVppUDZOOXd3SXBQYzVnYXcwZFI2VmFsVU41eFQ3YjBJYktLcVRVUjRJ?=
 =?utf-8?B?aHovRFRnYUcrdjZ3RkZDT0dvYmF4SVA2R1oyTFZvaVlKcTdOSThneWlFS3RK?=
 =?utf-8?B?WEZmNlhQUU1XSXpUKzQzWksyemN1S0xhMUdObHcrOWw2NHhCbUpIdjhqWE05?=
 =?utf-8?B?RDl6MkU2NjgzRFdkdXRKb3NKOWJBQnlud092azF6YVdwVUZxMVVuM3RqaTB5?=
 =?utf-8?B?TGxCRUI5U1MvN1E2cnZDeDBLNW80d2F1eGVaNWZNd21yV2NhL0FqRGN1bnpI?=
 =?utf-8?B?QzFISDhnUENsaWsyUnoxMkJaQUdtQ2JPekJqUE5aNUlQUlRpdXNvZ25Genkw?=
 =?utf-8?B?VmVmR1FiVlFlVlpaekdIOC8wRjhRRktBNFIyNVNBT0l5NU5SSENxemxyd2Vt?=
 =?utf-8?B?cDlXbGlBU0ZJbWVEUGNsS1hsNnlHOTFSMC82YXJiZCtMTnBHNi9YMjIxbjg0?=
 =?utf-8?Q?xc0CtlGLpbdFH30v/ipCEzU7k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2530a2-6088-45ae-502f-08de1e138376
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:37:09.7746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgwUSssvekfFHolE0Kfw34SbQqNC07ZDAfLRjhPiPCirOMHmQ9eC8srTOTlMAUGZ0Im3KHG3ANgev+FGhiL67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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



On 07/11/2025 15:12, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Friday, November 7, 2025 9:36 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Six, Lancelot <Lancelot.Six@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of save area
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On Thu, Nov 6, 2025 at 3:46 PM Jonathan Kim <jonathan.kim@amd.com> wrote:
>>>
>>> Over allocation of save area is not fatal, only under allocation is.
>>> ROCm has various components that independently claim authority over save
>>> area size.
>>>
>>> Unless KFD decides to claim single authority, relax size checks with a
>>> warning on over allocation.
>>
>> Do we want any sort of upper limit?
> 
> Mmm.  I'd expect early failure on unreasonable user request for over allocation at the allocation stage prior to acquire on queue create stage and acquire should be bound to what was registered/allocated.
> So I'm not sure what an upper bound acquire limit check could serve.
> 

One thing to consider is that at the end of the CWSR area, there is 
space dedicated for the debugger (used to implement displaced-stepping 
buffers).  Initially, when KFD did not check the CWSR area size, it was 
just a userspace matter to increase that size if the debugger needed 
extensions.  With this new change, we can't extend this buffer without a 
KFD update.

Having a "check that the buffer the thunk provided is big enough" policy 
would still allow us to extend this allocation if necessary.

Best,
Lancelot.

>>
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 17 +++++++++++------
>>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index a65c67cf56ff..448043bc2937 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -297,16 +297,21 @@ int kfd_queue_acquire_buffers(struct
>> kfd_process_device *pdd, struct queue_prope
>>>                  goto out_err_unreserve;
>>>          }
>>>
>>> -       if (properties->ctx_save_restore_area_size != topo_dev-
>>> node_props.cwsr_size) {
>>> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
>>> +       if (properties->ctx_save_restore_area_size < topo_dev-
>>> node_props.cwsr_size) {
>>> +               pr_debug("queue cwsr size 0x%x not sufficient for node cwsr size
>> 0x%x\n",
>>>                          properties->ctx_save_restore_area_size,
>>>                          topo_dev->node_props.cwsr_size);
>>>                  err = -EINVAL;
>>>                  goto out_err_unreserve;
>>>          }
>>>
>>> -       total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev-
>>> node_props.debug_memory_size)
>>> -                         * NUM_XCC(pdd->dev->xcc_mask);
>>> +       if (properties->ctx_save_restore_area_size > topo_dev-
>>> node_props.cwsr_size)
>>> +               pr_warn_ratelimited("queue cwsr size 0x%x exceeds recommended
>> node cwsr size 0x%x\n",
>>> +                                   properties->ctx_save_restore_area_size,
>>> +                                   topo_dev->node_props.cwsr_size);
>>
>> We can probably drop the warning here.
> 
> Acked.
> 
> Thanks.
> 
> Jon
> 
>>
>> Alex
>>
>>> +
>>> +       total_cwsr_size = (properties->ctx_save_restore_area_size +
>>> +                          topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd-
>>> dev->xcc_mask);
>>>          total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>>>
>>>          err = kfd_queue_buffer_get(vm, (void *)properties-
>>> ctx_save_restore_area_address,
>>> @@ -352,8 +357,8 @@ int kfd_queue_release_buffers(struct
>> kfd_process_device *pdd, struct queue_prope
>>>          topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>>>          if (!topo_dev)
>>>                  return -EINVAL;
>>> -       total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev-
>>> node_props.debug_memory_size)
>>> -                         * NUM_XCC(pdd->dev->xcc_mask);
>>> +       total_cwsr_size = (properties->ctx_save_restore_area_size +
>>> +                          topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd-
>>> dev->xcc_mask);
>>>          total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>>>
>>>          kfd_queue_buffer_svm_put(pdd, properties-
>>> ctx_save_restore_area_address, total_cwsr_size);
>>> --
>>> 2.34.1
>>>

