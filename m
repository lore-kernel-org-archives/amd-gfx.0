Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C1C52D73
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 07:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F18810E667;
	Thu,  8 Aug 2024 07:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FNPlLkqI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E684D10E667
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 07:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyStZDc37yz94rIjP3vOfuTkSsRGZAQjAyfNGFaNYJ6x1I6JRoM9Yl2fYAwLNXKPKD9oYigzI2X6Ozr+GPVVtAu7EdJ5WtP893bb5rWkg8lm84NVshysotlsK/LUaB94n54m99nsemD/tYwaOeopCvPrNAouWklWB8boy9OM1PF0mRPgg0JjwFFrdwUh+7uNIq83B8XnjaWRKReBu74XdpcvYERbAcPz3l8nyFAk3e5zCzKuobKye4B1+yeNgp+3b1LR10FgtuQPMK5JYz08oQjSu8WGVdSnWNZlTxHnLyLBIo59kpYNsAFeMbrBPBWknT7KZSeKnFFQt8DCBJpWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/yFvxZuYLrQtZ+n3wgUXhBS6Hr3I7iePaU4JVpl0fo=;
 b=RjDXGPN+KoSBnMF9V0qxLFrciQqQvB5ZmdwEYucCSZeYSnntsKHo/GpqhZDSiXYih6+WEzzPfJOxGD2MzVujz47FIj8R7Tpb8oO355qTEnubpSq4K2dqEpcmgvWEp5vzq/K6aFRsuEug87Mia3P7HrnfiA1rYGAfJMGqVEMUTSkfezTnPmuK7XavvXfHfdfxX4TsW0E8paK1BNiapCsuuFjAIH9u5g6r1qiDdrJKs05JlMwcOYQ65DxWCMjf1/7Pzh9vKLR8drP9ZD1zr0LJcETC/PWpw/r5yM0pKd9biPBDPuIn8zLP0CJKr5U/cUlpBw3tliEabW6ruZmBtUobug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/yFvxZuYLrQtZ+n3wgUXhBS6Hr3I7iePaU4JVpl0fo=;
 b=FNPlLkqIMxAtNTCHdxzK9LuuAiChqHcvPr4wI1hlgTKd35aVeEEvP/u6rAOdAW2osCa6F8cjDpviwTVj9WZxpJ1ub6teKeaHunpuVAtciJovXe3Rak63I15V75dVLrl9hVhNELAOOvkuMOQ2Hv7Mq2HjuXgyxmjOChH0JoBxwOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 07:06:23 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 07:06:23 +0000
Message-ID: <2ad50a00-b443-47c4-a9b4-04fbfdc67be9@amd.com>
Date: Thu, 8 Aug 2024 12:36:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
 <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b6b8d2-715a-402a-b62e-08dcb7789c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0JsSzk3YkREUTR4RktXTVFpeTAyeGlWYzFIcHlsSVo0ZldsSWRtVVl0dUhj?=
 =?utf-8?B?QnMwRzl0QmRETy94N2trZHVFYWlXZkJ5SEtlQWhibHArUC8zRWxheEhsNEE3?=
 =?utf-8?B?Y1FMbndrWk5wekFrUUlGSXdDQmFpRFhOME5TR0NreHlkTHlQTGtJZ0Vzcy9R?=
 =?utf-8?B?VUdCTncrNlY3cTlNMHFmVnhIV0ozNXM0S3hITEFrQUZ2Wm5CcDF4Qml3d0Ri?=
 =?utf-8?B?RHdJR0FPV2lOM3k2WTB0QzlSTjg1aXhuRzd4WEtwTlBzSFRNNlM4SXhJN3lX?=
 =?utf-8?B?MjJLL1VpTytWTkhVUjJCWTVGeVp6b05GVXN0dldiZEtUU0pCdFpHeUh2SDNz?=
 =?utf-8?B?ZmZUb2JwWmVqVHRIS1g0RjAxME13eitHV2dlZkJLV2wwQk9NMDI2MjRWMEJL?=
 =?utf-8?B?dXRnYVU3Qk1icnlnMlFGa3dyOXlmOGJYUDhCNmtPdWxLbVY0QWdLSitETUMw?=
 =?utf-8?B?Zk1kd05XR012VTM0UndhTjcrV0IyWDVlUTF4Wko3RGxnUTZwWHVKVmx6eEcy?=
 =?utf-8?B?RWNRY0sxSGxyNlhUVmtTNkF6djlYclhPd2NxVlcvVEQ0VHR4ZjFQNXlwRFlD?=
 =?utf-8?B?N3A2b3o2YWZZbzBLTVNmWDkxdmN5OEVsdTBlejVzck9mdGUvMDJpUVllbTdw?=
 =?utf-8?B?NzJCUThyZ0xSd1hucXZBam1rS2lzaFBVMjhoQmpmRzZ4VElIRDlNdXBlaGNW?=
 =?utf-8?B?WkJ3VElIWEZzcnIvWVA5bktST0oyK0pPRGFkWUg5RVF5OUtMcnYxajlSZ25j?=
 =?utf-8?B?K3RmWWxsNUdIY0p3MTkvNDJTVnhSZytXUDN3MFRSL1Y0Z052Zzl6R05jSXVo?=
 =?utf-8?B?dVVxTEVZV3lKNFhXVDAySEVybWc5T0NEUnJ0UlpVWWtQbURQMnJlUEtNSzNL?=
 =?utf-8?B?UnMyL0kzV2ZOMThFOGhnd0JZd1hXc1dRbVZ5TFBkNjAvekwzdEhzWXluWGF1?=
 =?utf-8?B?VWJMNEpTSTgrSTJ4RjJlT1hoY3p2SHVSOGJGWG5sd0ZGZnBPdnhCNUVzbzNJ?=
 =?utf-8?B?SjAzWWQ2aXMxSjYzNE50QTRIbjNjS2toK2N1QkNGa0kyeGh6SmZhYlpCaXRH?=
 =?utf-8?B?bjBKUmxMdC81aEx2YkNrRlBTeHB5K3g0cnI2M0twOEpJMDd6STcwWUxON2Nr?=
 =?utf-8?B?SWdabUxNT1FlMklmZUtpMXVwOVhWNUpKcXpSdHB4KzJyb2VleGpiTlhuaVhC?=
 =?utf-8?B?THN0Ky9HS2NXbjhOakdrOWE4VXRORkN1ak1PN3NpaXBTZU1OMVYrQzNsWUQy?=
 =?utf-8?B?ZXA0SHZiTnpSNXBsVEVEc0xwMjAzTEwyZnJhdzlpNDdGbWZZdllWNHMrbjRT?=
 =?utf-8?B?cHFLQXAzelRqR2YwamdJak81NWtQM1VjZlV3aHl5QnZQbGVQelVlZ0c2R1k1?=
 =?utf-8?B?ZkRmMGdjbkVMdTIxQ2RsbzdMU1ljK3dDWEd4ZFVaV3NNRzBZMWtLQTYzajlr?=
 =?utf-8?B?cE5ZT0swUmYrWFp0OXBXbEcxMThiRll1S3lpMW05OFBMQ01JYXRMM2tNckVB?=
 =?utf-8?B?NFprL3BRc2J5NU8xWmNOdjZBK1dmbUlRMmRUZjJqNkNHN0dQTEUrMFh2SmRY?=
 =?utf-8?B?cmFCR2dhZGJ1bzdXUzloSkpkTzQxRzhidWNqYW1PYmlieFhNVXgxSW9oaTV6?=
 =?utf-8?B?LzdPaklZZkN3THJnUzJqbFVyM3Y5blMxSnVFWVduMjRDbjhSTWlIMXI3aWNX?=
 =?utf-8?B?RGhkNjd5cFdQN2JTaXl2R1NQOWhpZXB6OE1rREJoWVloYy85VG1uM2dBMTZK?=
 =?utf-8?B?NG85RDlrYlloTkZWcnB1cy9NVTNPenhublhraHFhQ0Q1UU5YY25nb215UWVO?=
 =?utf-8?B?VWU1ZEVsR1FsTEtvRTBxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGMrVlRlVEFSRHUyYlVFeHV3MFkveE9YaXZGNHZEblpCQjcybS9WaStWMHdo?=
 =?utf-8?B?cUFMR0VYaGJWSDBVR0JzOWRKeVZ0WkRmNEZRd1pjUld3Rko0dDFieXFJazlj?=
 =?utf-8?B?RmpQOVkrclFKSGRjTFpYMHRRcFVndVhLUVVuNDEwb1E4SlRnYWNBekxjNGVi?=
 =?utf-8?B?SnYyZnR0MW9GOEhUQkNWaVh5VlpIVFV1djJjZnhRamJRYU0zSkc3WFJ2WEww?=
 =?utf-8?B?REt1MVNSL1RydHAzTUh1UWVPa2FLZEptQTJ2aU1pYTVMZGhxK0pnbEx5VGRU?=
 =?utf-8?B?UkJRKzJMUHlGdy8vQjRPdWNUZnFrZkFSNUtOaWQ5c2JMN3BiV1NibC9JaEt0?=
 =?utf-8?B?MEF5RHJSTUkrVjc2MTI1SEY5N1VmbUxiYWx6T0NxU3grYTZEZUlmZ2w4cmRC?=
 =?utf-8?B?ZnpCODJBMEZHZDlqdk9IZWg2YXUyVjI2MzhpYUs5VU5oZmQ1aFNjQVZEOUZt?=
 =?utf-8?B?Ymp5NVd0L3V6c2xIcHV5UVpNMVgvaFZIR09QZ0xQZEduMER0VHZoK3pSRjRh?=
 =?utf-8?B?Z3BIWUVUVTErUTBqVWlmbTk3aDVYbXl4VmhGbXRrL2t1RzRVZld4VW5Pa0sv?=
 =?utf-8?B?ZUVnV0cxR3JaZnNOL1Z0K290YWw4REhCQVVLcEN5VHMrSHArQm10WTNjbHZU?=
 =?utf-8?B?MVdHYTkxYVcrRC9DVjc0ZG1ISU9ObFZUWVRJaVdKTStGUnUybldBSkRkbEZE?=
 =?utf-8?B?MXdzTEV3T0I3R3pkVERpQ0ljTHFHZGtWMkRZSFo1ZzFnWElJN1lDbnZwNHp5?=
 =?utf-8?B?SG5FQzFOWUZrNDB2S3FxMDlaOUc0bURENTNOMHNMaklTemNGNXFzbGZDbWRH?=
 =?utf-8?B?cUNvdVNMVXBkdG84cGh4NVRKdzV2WWVUaGNyMmxpMG9iKytKTUkvNkRiczVp?=
 =?utf-8?B?dDQ0UnNwc2xiN0FkbWVVYUY5QkFxdTZsUWZic2J1Y2w0VnhjMVNhTHJnemMx?=
 =?utf-8?B?WlphdzI3VUgyb2cycWZOYStuNTB4M3JLU3hUOEQ0RWFJd2xCSXl0NjdZQVhj?=
 =?utf-8?B?UGNxajJ0dWVkeUZJMVllOWR0REsxUXlqVmY0Y3Vjb2haZGV5MFNkOEd4WHVl?=
 =?utf-8?B?ZktDR1NialZZRzIySElhcW1sUTFFRmszY1BBZWRSSmpSaGxSNHhoQjlFK2FX?=
 =?utf-8?B?MTJUSURZSnlLTldmbHVmL1oyMFhIMTUvWGhTUHlHb2J6NVFoZS9vMDZuVFBK?=
 =?utf-8?B?eE1nVmcwVU5ncWQ1S0Rwb3pJeGpOTUdYb0JRWk9oL1FHaE0xS2FQNmRQRmNT?=
 =?utf-8?B?bFlYT1BFTHIwZTFvWFM2bUl6enhVZVhQY2g2V2hrMGpjRjFKTFRlOEFIS0NY?=
 =?utf-8?B?K2dvSUFpbjhKRVV6WmJIcnVvNWZvbjk3bXBJd3FkemMxM2MwL09aWWhjZDNX?=
 =?utf-8?B?TGhGUGlOUWIzY256aXJVU2FjQWZHNzlTblFiUWRuV3BNOVozNlM5K3ZnQUh0?=
 =?utf-8?B?TVY4R3BJaXBKZXBNczB2aXJBMjhMMWV6UWZpL0E4angxQVRrQnJTWm92Ty9n?=
 =?utf-8?B?WlkxbDdxUUVrUEJ1Q1NzakdKUG84VHZ3eWRCaGdZRDA4ZUdNMFYxaHNvMTcw?=
 =?utf-8?B?dmplT0ZnZmoycXJGSnVqSTk1MlM1WnBOdU5nTDU2VUpqTFJzVk1pOUxtN3E0?=
 =?utf-8?B?bmFpL2FsWDhQQ2t5Qmg2enh0bUJxNEZGS3N1QmpLZTJiU1BDMlVuVGRvMjli?=
 =?utf-8?B?K2swMFFPMFJScEwva0VEOEp6eE1aZ0ZhK2FSL0EyZ2hQVXJYbk5EUWI4QVkv?=
 =?utf-8?B?a2JSaFJIVGdWQkoyRjZVeWVmekE4eGx2MDFGY0lpVGgxNmtPT0k1RThGc3B2?=
 =?utf-8?B?SW5QSDV3VjFGNGJGOEhqVFpwTUw0eloyZEkzcEU5VHYvNGJNL0FFRUdyV3U2?=
 =?utf-8?B?c1gwb3lHVThvZWZVdHBsUEFPWHU2U3dIMWpaWW94aFhibS9GQWJhbFRrVkdk?=
 =?utf-8?B?eFZicWJlUkJNcWFxSjlvS3RmemRtckhRNUc4QlVDUXhpT0NZWXRCcVZlOUlu?=
 =?utf-8?B?QXdSSEFROW91eHUySXE5bXl5MDVlSTJPMFFFNUtqOVFLQStUT2M5VkdJM2xl?=
 =?utf-8?B?QitWeGFWUFZJWHZUOEw4UnRLWDlYc0d3bEduS0s2eU9hU083aHU3dFUwYkdK?=
 =?utf-8?Q?cpQ40e/ui+I4ON6rYSjDRksL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b6b8d2-715a-402a-b62e-08dcb7789c8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:06:23.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEQutniE8oEhCtqvuJvDWTO+V8xRo23+SnR0eFNb5MWrEzmWTEYvEceRxEb5BjjUJvwDUtvWCL6pfWCR12smIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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


On 8/8/2024 11:20 AM, Lazar, Lijo wrote:
>
> On 8/7/2024 2:58 AM, Alex Deucher wrote:
>> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>> Add support of vcn ip dump in the devcoredump
>>> for vcn_v4_0_3.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170 +++++++++++++++++++++++-
>>>   1 file changed, 169 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index 9bae95538b62..dd3baccb2904 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -45,6 +45,132 @@
>>>   #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>>>   #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>>
>>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>>> +};
>>> +
>>>   #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>                  (offset & 0x1FFFF)
>>>
>>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>          struct amdgpu_ring *ring;
>>>          int i, r, vcn_inst;
>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>> +       uint32_t *ptr;
>>>
>>>          r = amdgpu_vcn_sw_init(adev);
>>>          if (r)
>>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>                  }
>>>          }
>>>
>>> +       /* Allocate memory for VCN IP Dump buffer */
>>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>>> +       if (ptr == NULL) {
>>> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>>> +               adev->vcn.ip_dump = NULL;
>>> +       } else {
>>> +               adev->vcn.ip_dump = ptr;
>>> +       }
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>>
>>>          r = amdgpu_vcn_sw_fini(adev);
>>>
>>> +       kfree(adev->vcn.ip_dump);
>>> +
>>>          return r;
>>>   }
>>>
>>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>>>          adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>   }
>>>
>>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>>> +{
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +       int i, j;
>>> +       bool is_powered;
>>> +       uint32_t inst_off;
>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>> +
>>> +       if (!adev->vcn.ip_dump)
>>> +               return;
>>> +
>>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>> +               if (adev->vcn.harvest_config & (1 << i))
>>> +                       continue;
>>> +
>>> +               inst_off = i * reg_count;
>>> +               /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
>> I think you need to use the GET_INST() macro to properly handle this.  E.g.,
>> vcn_inst = GET_INST(VCN, i);
>>
>> Alex
>>
>>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>>> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>>> +
>>> +               if (is_powered)
>>> +                       for (j = 1; j < reg_count; j++)
>>> +                               adev->vcn.ip_dump[inst_off + j] =
>>> +                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>>> +                                               vcn_reg_list_4_0_3[j], i));
> VCN 4.0.3 supports DPG. As far as I understand, most of these registers
> are accessed indirectly in DPG mode through indirect SRAM.
>
> Checking UVD power status alone may not be sufficient for direct access.

i am following what windows is following and most of the registers are 
directly access but i agree some might not be.  We are assuming in case 
of a VCN hang it should be in good power state and we should be able to 
read most of the registers. Based on further feedback will do the 
needful but right now the point where we are dumping the registers we 
could not make any change in power state.

Regards
Sunil khatri

>
> Thanks,
> Lijo
>
>>> +       }
>>> +}
>>> +
>>>   static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>>          .name = "vcn_v4_0_3",
>>>          .early_init = vcn_v4_0_3_early_init,
>>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>>          .post_soft_reset = NULL,
>>>          .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>>          .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>>> -       .dump_ip_state = NULL,
>>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>>          .print_ip_state = NULL,
>>>   };
>>>
>>> --
>>> 2.34.1
>>>
