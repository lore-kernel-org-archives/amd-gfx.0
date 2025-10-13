Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9460BCCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2474B10E3E7;
	Mon, 13 Oct 2025 07:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KyNmTQpO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397D610E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqjXnNfQT3hdSEaKUPV8Yrkf/mwa2ZCI+AhkNYYaKLu0Y7qjQSv+XxOSl46n2NGMYzQdKS7B5N4xT4+pzMNPJFqH3fiY2HD2C/pf3OnINS6WvfGBSUpKQ17PUbCP8v76/vQIhk1iqH9gnXRDubPQR+0KGdCHWkn4u+dddNRmJtLBBZzhAeyQ0ZFV8r33uhTiiDMqRV4HhEK1UH3o/09Y8wbnIzaTNOY4nVmTAVE96jzw01jYhTNl+8An0W5PjGkD7bqsRmoVi1ZBsH7P8mANZFtzB++qNROS0hmstQjI/sxv8Ndrbx/pFjkFB8eP7u7vEZ/G1Z3rW4gfz2/nPb1vnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPYOMZJDT5SRrcecetA5yIk/G2AHc1d5XP4KpR0lxz4=;
 b=e3YDlb+PjqegPDc1Lmq/a3Wwuvi0VnBrwGs5CbycEGZ711hzfYLwom6KT/MOGB5JM/8iYRUV5i9x+4jvTryPRkOkOjVfxMd5j7tJdLuKPnKBAcwr4yaaKOkxEkn1NGb8Ctspw+4ofxE7kDN3nB08XCCyUjsGVfxoN6YeOVsPzSP/ZHvmTwur7ien95v+sCQe3f/M6b6Pe+5IAYwB8+ii09/ZpX61BdMwBMDZtGkScABWK/M/gt/aE9c0HN42jYyIZOckNIOIyttfmpMRQ8rN4w0A32PgxPs3B98N3YzvUr7t6sm9k5bdDoDuP9tcHk+pvv07rtJ+CjuV7akIHyBOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPYOMZJDT5SRrcecetA5yIk/G2AHc1d5XP4KpR0lxz4=;
 b=KyNmTQpOKd+tklLpyU0Olu31pVf9gCWzdO1FAtK91w6m6Sg444MEcbLthGZggTTK1Z56KcCjozZV92POt+kKKROKe3LjzMao6KRHdFPxgW4ZIwrV5n3u7gkKu8X+VkqbZDpm3CnHw89I6+TcegdeaCLSsNMmR7hLDA/F4a3CIBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 07:38:34 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:38:34 +0000
Content-Type: multipart/alternative;
 boundary="------------ZgGMOv7GRlPxI4x7peKjSKcH"
Message-ID: <56764bcc-faf1-4cdc-949c-be6eedba2aa1@amd.com>
Date: Mon, 13 Oct 2025 13:08:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 2/2] drm/amdgpu/userqueue: validate userptrs for
 userqueues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
 <20251010140712.3983709-2-sunil.khatri@amd.com>
 <b3655417-7b6e-472b-9a71-834361c4ac22@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <b3655417-7b6e-472b-9a71-834361c4ac22@amd.com>
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 882dfe5b-e69e-42f7-e3a4-08de0a2b8397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTlTYWI2NFI4U1VzYXQ0SzNMTk9hYjlONUhVaWtrODAzaEVaVHhSclVIaGVB?=
 =?utf-8?B?NmVHaVRxeS83VVBjQ0RmZVFiRlc1TWwyRWI1QzkxYU5BWnFDb3ZjNkpHKzJJ?=
 =?utf-8?B?UnpPVnNJSGZjRXJ2dnJvWXQrTGVTcDE1ZzNrdU1sVVl0L2NzbjlVVG9nSjBF?=
 =?utf-8?B?QWtUUDBnWUFtTSt2N1YyMnVnemFlbDZJNHNYbVFBLzg1RlpHZXd5QlRrUnRj?=
 =?utf-8?B?UmVFVHFIeWN3dXAzU0FsM243VzNWQk1Bb2NkMEc1eWxtZW51TC9NdWVGamRZ?=
 =?utf-8?B?REV2Q2lIdit3T21jTE85emFiczhvWXZRUWVrdXVKSFYyd2JPc1d1UzI3T1gz?=
 =?utf-8?B?N0NjemoySmtGeTdYMkNlN2hSYlBuVmtmSmdzRXNIRXp6WUNJMnNJT1BCOEJa?=
 =?utf-8?B?ZHFKSDUweldFR2lVVHdORjBVWWc2b1hEQWtsUFNuTHorZnJ4eFAyWkxEd2dE?=
 =?utf-8?B?WVV2UWgwTDBMS25kcFM1NGljWjExb0U5M0t3WnRWWUxzV2ZCRkVuTFZON0k4?=
 =?utf-8?B?SG1VVENta0NXd1JPZThEQlpwR3M4SGwrTDB6NFMxeFBXLzRFQ250NGNvWTlV?=
 =?utf-8?B?QWRiQnNCR0c5N2dPd2s4MFpGTmsrTzF1VlFKenhmeWNYMUFBODBFaWdIRk8y?=
 =?utf-8?B?WmpHZHhGVExlY2FkSnIwd2VRL3I0amJYSjdiUE92ajRFekRXSHFzcmtEdGRu?=
 =?utf-8?B?MkdjQjd6UFp5QUIrelh4dy80VE81NU83aXN5THZmaUVDelhldzRtYmU5QjVU?=
 =?utf-8?B?eWhSNGttb3g1d01QUGd6OExCN0RGZDVpWW1XRStLTFdpY2pWa0dhM01WMFVu?=
 =?utf-8?B?YkJteVJRN2huZWk4Y1hqMXZFNW1oSWVpb0RpK2JDSFVWV0xIb2s5bTRlVm44?=
 =?utf-8?B?UkpvVStCc1BiQWo4bUs2NHhHcHNGM2ltb0U0MW84aWkzcWVmSzJFVVF6VnpI?=
 =?utf-8?B?NmZKdnc1bFR3Sld0a0xCeHZwZGlKNVJVSnFyUlorelFPRmFpSU9sR24rQ1hl?=
 =?utf-8?B?SVp4OHhualJ0M1lUTkIvWHhJY25Bbm1KTlJDNTdlcnd2TXVETWtxYitDVHl5?=
 =?utf-8?B?UkdUSEtTWTkzYWpMbU83akoxYVBFSlNwWUFDVlBYcSticU10K09hemNaNjBW?=
 =?utf-8?B?Y3ZQM1RYMTJkbjF6dGNVOXV1NlVYTTRwdDJnRy9HVXB4YlA2aC80cE9DTEZB?=
 =?utf-8?B?RVVnVzRWNDZpb3ExYWk2ZUZvZ0pCMTlJZXVKei9BbjBXMTF4am96UXRBVWht?=
 =?utf-8?B?MUdEMWtQUVFBYzE5MGxBZXhYTTJZVlkycjduNktubFgrb01CNmVGZGMzUENJ?=
 =?utf-8?B?cjhPQnVTLzBmQ1FsM0pxWmpMYUZuTFB1OW9DdU5WMlhjOSszR1NxZHl3UklE?=
 =?utf-8?B?dmtsMUFEOGR5RkYyQ2NnelhGczJLMkNLT3kwMng3WXZ1QzJYUk5OaVlwcUd3?=
 =?utf-8?B?SkxBa0szU1hPQ2dqRUx0SXlTYUZxWmxDUEUzbFFCd3JpbUFXQWlNOVVhSitu?=
 =?utf-8?B?anlxU205N3l5aEpkWGM4enRWY3BQTCtlTGFyUUdlTTRpaUJzVXZESHFidGNm?=
 =?utf-8?B?UDJFWkZNaXQ0Um1kb3drTjBCSXhSeWhJQlNUUlpuVElaOWJNVVpxMkF5RWxx?=
 =?utf-8?B?ZlRNNWl5OWxsOUF6RzVWZEd6SE5hOERCdkRQTm9wYkVhRkNjL2trQjFQU29Y?=
 =?utf-8?B?c1VEKytPZWx4eGJYUVNaeUdjaWhnbXp1aGxJMEQ3S29mTmNxcE5UcUZJUmd2?=
 =?utf-8?B?bEljMURPM21yTnFKQ3BJaHNndE85UkF6d2Q0dVNrMTVWUGg4MkJVdStaWnNK?=
 =?utf-8?B?QVdoampsbWhWcVNNOEtzck9rUHhNazliYksvdUU4ZDI5ZWtaS0N0d0llVXF3?=
 =?utf-8?B?UTcxQTVxU3NIUmFMWTBWdHpNd1hmaDQzTjhoc3liVlN0dmJJaTB5T1RGYUVV?=
 =?utf-8?Q?+k2LveW3qr1HYo8D8yiWx+dW/rRwzXaG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTk1WVhEdEV0RWN5eUxzeDlFVGd5cEhVL2pUMWFFRktDQXAvdGdZZE1Mdy9L?=
 =?utf-8?B?M0hMc0YvNHlqdm12NEROVEhIWkhhY1hWdWVFY3lNeGllTWJueHFLZFpyZGhC?=
 =?utf-8?B?K2p4aVI3bGM5Y2RNSmZRZ0JaT2ZqSk9jNTdFcUNONjIrTGlsS3kvaGlEWjZC?=
 =?utf-8?B?YWhGZTArcXhsYVRMUmhrZnR1Uy94emRSRkR2bVVVeTI5eGJyYnYxSnVMNjM4?=
 =?utf-8?B?a3RoOStubjB1SVg4NGdlRVYrcTdnSWYzQlFDV1J2d0l4YnFDY3RDcWt5L3NS?=
 =?utf-8?B?Q1R4RHY4ZTB3YWxteC9TbCtyakQwaXl6MjJKSWJObUZoeVA1L1UyYytrZlBt?=
 =?utf-8?B?QUJHR21sb3BhQkpqd2QybGVKeFVmdVowNy9NaUxZa1A3S0dSQnJpSWkvTWtz?=
 =?utf-8?B?d3pRWTliWHFIQ3FlcFA2TGhwMmlib1A5RCt3SlcwNitRMmszQzc5dGVSSjNE?=
 =?utf-8?B?ZC9IVS83dHYxVktXNDBlNjNqVTRLVlViUGFtQWxPTy9LcEpTSnZFZW1jcVFY?=
 =?utf-8?B?Y3ZrS2FPQzRCTHVQZHVYUUNGY0dUK0ZqTEFsWG9FejBlUkgwdGYxSzZQL2Fy?=
 =?utf-8?B?WCtGWE84R3JaMWJGREtPN3lmSDJ6dWJ0WEFzWDgzOWw2dDY5a3dJc0x0by9X?=
 =?utf-8?B?U2pIVkN6T0NPcWUrQUVIWFhSeC8vMWp4VlJrQzNYOU9RQm41WitocDM3REg4?=
 =?utf-8?B?TURIOFpYQXJBRkZQMHcwcTdqNUh0TzRpM3d1NEJHaWZOOE1vZldZRHl2bERh?=
 =?utf-8?B?WkIyUUdlS3pQVlB3Nlk5Ty80clBaS0dpbWovTUk1bm1LVHVHV29jaUpDY1hW?=
 =?utf-8?B?eHNBdU12QjZUejZMa1VGTVBkTFdZT1MyUjl2L2N5UkZyZjRwVmdRNHlJam9p?=
 =?utf-8?B?WXNkcERYTzFPNUllNlVQdmhFazlZaUxRVk9tL2VxV2V1Rjg5UXZHdlhGZ1dz?=
 =?utf-8?B?bERnSmpZSG5MMTNZYllEWGI0Y1BLdHZ0YkJ2d0ZEN3pMc0pQcStKMi9ESVg0?=
 =?utf-8?B?Skk4TlRQc1lSTXN2TitLU2YvVG9FRUtwNVBYUTZqWitQMjNNbmxUa1FnRkdZ?=
 =?utf-8?B?QlpBdzBIaTVPRFh6ZUhyWGVWTUpHY1RGRnF3K3N1amd5MEpCY1I5NklBdTZL?=
 =?utf-8?B?VHZlUGc0aUtTWUZqb3RRaWd5MWJvNHgyR1BHL3RTaEFQWnY1NURvNXo3TmFl?=
 =?utf-8?B?ZUYzQkxMOFZlV1p2L1M0R0RMSCtwdmZGdWl0SytJVkI2UURIQk11QUVsMUVY?=
 =?utf-8?B?bi81QUlEc3Jxam45YllselBEbFBNSHgxRXY2MXpIZ2NiR3cyeFNwSEpGMTVa?=
 =?utf-8?B?UmlHYmpjUVNueWVSdlREZ0FjWUl5bnpMbXNiOUtuUFFwekF3SnYzaVdMN2Q3?=
 =?utf-8?B?UGJvOUZkcGNXU1pNQnVnVFJlalBuRHp2S0ZPaTZjbHROclNrV3orQVp2ZXdr?=
 =?utf-8?B?T1VOeUFzZ1gwK0ZPeW1jVkJpbitsQTBnUEMvL25KY3RLVllaNzAzSmNMamFS?=
 =?utf-8?B?UWxrWEpHakVHTnZVY0lxWC9Ka1hsUXdFakttQ1hMK3J5MmxmbmQyUmJtcWoz?=
 =?utf-8?B?MXNVVmhodU5CUTgrWXNrck5rclpXQVVNWlBXcC93ckVkakpSbk1ZQ2QxTWFN?=
 =?utf-8?B?OStUU0xmVmhVeVY1cnlCNnh5YlFiUzNpNVBSZEU0aVF2RmxYM3BwdTJlSG1G?=
 =?utf-8?B?NzhkbzlMMzRHM2tBNjV6T2doL0NoL2JhR1lGbWI5TzlEc2pNTytrZjlUbUY4?=
 =?utf-8?B?Y0RMaWN0TmRUZWp1MlI3Rll3SWcrdWpFajdhQ0RPMVF6MGNnWGFzREs3UXFY?=
 =?utf-8?B?UDAvczhHSDdhVkduaVhuY1RMcjlTK0xBdkxwQXFkNnBzbVUwWWRtRENtOHZp?=
 =?utf-8?B?ZDdPdjR6NHoydHZwU1JJSSt6MWdFRlM0RkkweTFaTkF3OTFEcnF2d1kwbm9v?=
 =?utf-8?B?N25Halo1ZElMTFJRZUpja2t1cVh1b1BQeElPZ05zdi8rSFlxbzFmaEVjZ3ly?=
 =?utf-8?B?R1FzZkxST2U4VEJ4NUJuTE1qd0h2K1RMTnk2cTZPaVN2ZFBxZHM1dHlqTXZl?=
 =?utf-8?B?R2xoN1hUUzJaTFZRL2pGOXNsTVZ2TThyZm9yZ1IyUXQ2NjVYK00ydGtiTHdJ?=
 =?utf-8?Q?xICjLOKLcHjU25SwBHlkGm6oD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882dfe5b-e69e-42f7-e3a4-08de0a2b8397
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:38:34.5037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEKeMkHF8xFwf2nqMEhk3unu2zcAQ+iXf6HgfKEBfGbbLIQbEtqHVNgvJUNCJMbj5jqu3ul7AOjXExdiQGVv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
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

--------------ZgGMOv7GRlPxI4x7peKjSKcH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/13/2025 12:48 PM, Christian König wrote:
> On 10.10.25 16:07, Sunil Khatri wrote:
>> userptrs could be changed by the user at any time and
>> hence while locking all the bos before GPU start processing
>> validate all the userptr bos.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 74 +++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 8dc12064da49..e9f423cf11b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -29,6 +29,7 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>>   #include "amdgpu_userq.h"
>> +#include "amdgpu_hmm.h"
>>   #include "amdgpu_userq_fence.h"
>>   
>>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>> @@ -758,12 +759,21 @@ static int
>>   amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +	bool invalidated = false, new_addition = false;
> That could potentially be only a single variable, but that is up to you.
>
>> +	struct ttm_operation_ctx ctx = { true, false };
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> +	struct amdgpu_hmm_range *range;
>>   	struct amdgpu_vm *vm = &fpriv->vm;
>> +	unsigned long key = 0, tmp_key;
>>   	struct amdgpu_bo_va *bo_va;
> Initialising key here is superflous as far as I can see and some automated tools started to complain about that IIRC.
Yeah i will double check this
>
>> +	struct amdgpu_bo *bo;
>>   	struct drm_exec exec;
>> +	struct xarray xa;
>>   	int ret;
>>   
>> +	xa_init(&xa);
>> +
>> +retry_lock:
>>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>>   	drm_exec_until_all_locked(&exec) {
>>   		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
>> @@ -794,6 +804,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   	if (ret)
>>   		goto unlock_all;
>>   
>> +	if (invalidated) {
>> +		xa_for_each(&xa, tmp_key, range) {
>> +			bo = range->bo;
>> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> +			if (ret)
>> +				goto unlock_all;
>> +
>> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
>> +		}
>> +		invalidated = false;
>> +	}
> Please make sure that this step comes before we validated all the BOs, otherwise we won't go from CPU->GTT placement again and the GPU would crash on access.
Should keeping the loop after locking the pd sounds good or the first 
thing just after this
drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);

+	if (invalidated) {
+		xa_for_each(&xa, tmp_key, range) {
+			bo = range->bo;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
+		}
+		invalidated = false;
+	}


>
> Apart from that the logic looks good to me.
>
> You might want to think about moving the loops into new functions in amdgpu_vm.c.

I do have this in mind but i want to take that activity as separate to 
integrate it some way to both kernelq/userq but needs brainstorming as 
its not that simple and clear too.

Regards,
Sunil khatri

>
> Regards,
> Christian.
>
>> +
>> +	key = 0;
>> +	/* Validate User Ptr BOs */
>> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
>> +		bo = bo_va->base.bo;
>> +
>> +		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
>> +			continue;
>> +
>> +		range = xa_load(&xa, key);
>> +		if (range && range->bo != bo) {
>> +			xa_erase(&xa, key);
>> +			amdgpu_hmm_range_free(range);
>> +			range = NULL;
>> +		}
>> +
>> +		if (!range) {
>> +			range = amdgpu_hmm_range_alloc(bo);
>> +			if (!range) {
>> +				ret = -ENOMEM;
>> +				goto unlock_all;
>> +			}
>> +
>> +			xa_store(&xa, key, range, GFP_KERNEL);
>> +			new_addition = true;
>> +		}
>> +		key++;
>> +	}
>> +
>> +	if (new_addition) {
>> +		drm_exec_fini(&exec);
>> +		xa_for_each(&xa, tmp_key, range) {
>> +			if (!range)
>> +				continue;
>> +			bo = range->bo;
>> +			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>> +			if (ret)
>> +				goto unlock_all;
>> +		}
>> +
>> +		invalidated = true;
>> +		new_addition = false;
>> +		goto retry_lock;
>> +	}
>> +
>>   	ret = amdgpu_vm_update_pdes(adev, vm, false);
>>   	if (ret)
>>   		goto unlock_all;
>> @@ -813,6 +880,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>>   
>>   unlock_all:
>>   	drm_exec_fini(&exec);
>> +	xa_for_each(&xa, tmp_key, range) {
>> +		if (!range)
>> +			continue;
>> +		bo = range->bo;
>> +		amdgpu_hmm_range_free(range);
>> +	}
>> +	xa_destroy(&xa);
>>   	return ret;
>>   }
>>   
--------------ZgGMOv7GRlPxI4x7peKjSKcH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/13/2025 12:48 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b3655417-7b6e-472b-9a71-834361c4ac22@amd.com">
      <pre wrap="" class="moz-quote-pre">On 10.10.25 16:07, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">userptrs could be changed by the user at any time and
hence while locking all the bos before GPU start processing
validate all the userptr bos.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8dc12064da49..e9f423cf11b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -29,6 +29,7 @@
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_userq.h&quot;
+#include &quot;amdgpu_hmm.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
@@ -758,12 +759,21 @@ static int
 amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	bool invalidated = false, new_addition = false;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That could potentially be only a single variable, but that is up to you.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
+	struct amdgpu_hmm_range *range;
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
+	unsigned long key = 0, tmp_key;
 	struct amdgpu_bo_va *bo_va;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Initialising key here is superflous as far as I can see and some automated tools started to complain about that IIRC.</pre>
    </blockquote>
    Yeah i will double check this
    <blockquote type="cite" cite="mid:b3655417-7b6e-472b-9a71-834361c4ac22@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	struct xarray xa;
 	int ret;
 
+	xa_init(&amp;xa);
+
+retry_lock:
 	drm_exec_init(&amp;exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&amp;exec) {
 		ret = amdgpu_vm_lock_pd(vm, &amp;exec, 1);
@@ -794,6 +804,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	if (invalidated) {
+		xa_for_each(&amp;xa, tmp_key, range) {
+			bo = range-&gt;bo;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm, range);
+		}
+		invalidated = false;
+	}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please make sure that this step comes before we validated all the BOs, otherwise we won't go from CPU-&gt;GTT placement again and the GPU would crash on access.</pre>
    </blockquote>
    Should keeping the loop after locking the pd sounds good or the
    first thing just after this
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #dcdcaa;">drm_exec_init</span><span style="color: #cccccc;">(</span><span style="color: #d4d4d4;">&amp;</span><span style="color: #9cdcfe;">exec</span><span style="color: #cccccc;">, DRM_EXEC_IGNORE_DUPLICATES, </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">);</span></div><div><pre wrap="" class="moz-quote-pre">+	if (invalidated) {
+		xa_for_each(&amp;xa, tmp_key, range) {
+			bo = range-&gt;bo;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo-&gt;tbo.ttm, range);
+		}
+		invalidated = false;
+	}</pre>
</div></div>
    <br>
    <blockquote type="cite" cite="mid:b3655417-7b6e-472b-9a71-834361c4ac22@amd.com">
      <pre wrap="" class="moz-quote-pre">

Apart from that the logic looks good to me.

You might want to think about moving the loops into new functions in amdgpu_vm.c.</pre>
    </blockquote>
    <p>I do have this in mind but i want to take that activity as
      separate to integrate it some way to both kernelq/userq but needs
      brainstorming as its not that simple and clear too.</p>
    <p>Regards,<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:b3655417-7b6e-472b-9a71-834361c4ac22@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	key = 0;
+	/* Validate User Ptr BOs */
+	list_for_each_entry(bo_va, &amp;vm-&gt;done, base.vm_status) {
+		bo = bo_va-&gt;base.bo;
+
+		if (!amdgpu_ttm_tt_is_userptr(bo-&gt;tbo.ttm))
+			continue;
+
+		range = xa_load(&amp;xa, key);
+		if (range &amp;&amp; range-&gt;bo != bo) {
+			xa_erase(&amp;xa, key);
+			amdgpu_hmm_range_free(range);
+			range = NULL;
+		}
+
+		if (!range) {
+			range = amdgpu_hmm_range_alloc(bo);
+			if (!range) {
+				ret = -ENOMEM;
+				goto unlock_all;
+			}
+
+			xa_store(&amp;xa, key, range, GFP_KERNEL);
+			new_addition = true;
+		}
+		key++;
+	}
+
+	if (new_addition) {
+		drm_exec_fini(&amp;exec);
+		xa_for_each(&amp;xa, tmp_key, range) {
+			if (!range)
+				continue;
+			bo = range-&gt;bo;
+			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
+			if (ret)
+				goto unlock_all;
+		}
+
+		invalidated = true;
+		new_addition = false;
+		goto retry_lock;
+	}
+
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
@@ -813,6 +880,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&amp;exec);
+	xa_for_each(&amp;xa, tmp_key, range) {
+		if (!range)
+			continue;
+		bo = range-&gt;bo;
+		amdgpu_hmm_range_free(range);
+	}
+	xa_destroy(&amp;xa);
 	return ret;
 }
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ZgGMOv7GRlPxI4x7peKjSKcH--
