Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FEDCCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0835C10E977;
	Fri,  3 Oct 2025 20:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUi/OU4T";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AA310E976
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzQ2oM+z4xxwcgOol0Gz4XBSTJ730tOjC7M5V8cb7Db4iMMApdwYmPWObkCBXPDhENDtidI1kC0iLNd6sJWdfMc1d5VF3TTCKCiywEA6ajqx7HutVreG2ZsjnpEAVk1+NNayzyMCv15qUKlRDPneL4SIL2FdaP4qaxN0JVZBCU9unfHOSic1Y0cibi0BtdIYR8D6M9ohsiCF0PrjJrmbhiX+nkJJmKICNMCLfg5goB/dU3oQurCl1d4bLvOVT5/QdMqKHwzCVTTQuV2k0q4Ou0c8Z8Ss106xQ4SPMq9l/gHACUVWo9JsfbToCPcQFF/r8OFrzZnPH1r884bDtpFCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVOC9x+JLEhFozYgM40UKHsCWm1BoEvppUEhmHfaht8=;
 b=rdGTMcM1/1J6wmWyjC7VRtnyyhU2IPjXuWfMn3OsH3LYnqi77pCVQkp0B+BokJ8mXnq+h3YkBJbC9t7KTu3srVOkNVofCXcdE1zB2n86XCbCxwqwkOATPY505veSzu31iHqMx1PlckEtVaNcuqWLgYf7FP/A+92IdBTeGFbaf5rQLPMpCtcBn92wxsYqF70xrTASG++oqBUp9ohYWDYv20nHJeqrNUZAVvEn+c2ThkGJ1XvY3s8gyh/w0y4PDGmjiP6iRyUX/omD0xlstp7tY06NYr4vljBn4L7P5Y1p/c520VSFEz/4/kFurt3V/deaq0am7KpHvL2FwHZqX0d1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVOC9x+JLEhFozYgM40UKHsCWm1BoEvppUEhmHfaht8=;
 b=cUi/OU4TBAsleFyTTmV11A1YTDmfbyfqMi913D9Z4oUl35WZvWjld9VfXFQw6CJf89ip1LfGUtQc5IMS+vDn6NNOTaoXU6t0h8K2tD7TxwIUJVcgsCoAkuLtNC30nknp47h/H2mpP+k9d0C0/+nkXj9T14RR+hDdkUIxXQzfj/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Fri, 3 Oct
 2025 20:23:29 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 20:23:29 +0000
Message-ID: <ea08dc41-a919-4b44-9274-a962b707fa83@amd.com>
Date: Fri, 3 Oct 2025 15:23:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: "Khatri, Sunil" <sukhatri@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
 <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:21::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de9ae9d-a927-43d3-ee4d-08de02bab706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnlwTjhuY2VqWnFKdTdMNFI4UjRGdkR5MktTd3M0RUFzV3Z5bk1LTmdmQXV0?=
 =?utf-8?B?N3Q0T0doY1pnamVQWHZiZXhweldmQTREeVYweXdRY2JtSEcvSEdzMnk2SnFQ?=
 =?utf-8?B?My81dUR3WGRuSkd5T2FVREpzd2E5bVVDUXhHNkFOSU5XRmFhQ2M1K0oxTG9y?=
 =?utf-8?B?aHVUWUVWQmppVnZrd0VyQU15NUdhbHBxcEtHZ0pSYkhnZVI4OVgyeDViZU1C?=
 =?utf-8?B?NEVKbUJzR2lkSHBHTnI0OWZUcUNiT3FLdU5UMDJFWTdZVUszQjhjamdMQVhn?=
 =?utf-8?B?UHR2MEhCNjA1aEVrK2V5N3B3bk5XNHBoRUVOSHkrTnZyR1ZtbjNreUdiczZa?=
 =?utf-8?B?NzJLdlJ1WWhJRzVibURGZXA2RFM3Q2xjbEhZRThyQXh2dkRTWENIWHE3azZj?=
 =?utf-8?B?cERJTkxhS2dRbFJQcmsyL3g4K3BrdWxSZzlQRjlLa1MxQkJRL1FyUHVUVEd6?=
 =?utf-8?B?TVliMS9kMUNORTdWSVA2Qjh5d1RwM1RtRHNTallUNE1Cc1Y5NDZLNG1QL0tQ?=
 =?utf-8?B?WUluRm9ZVDhwc2h4OWs3RUhKNnRRSWY5M29aSXlHQXhwM2hQZGN6TkpUZ3Fm?=
 =?utf-8?B?aklMbjQ1MHkwQWZvbE9MQlNxTld1VEZwdTYwY0c3b3RDUGJlVTIxdVEzS0pI?=
 =?utf-8?B?S1JpdzZMYml4TUpnOStua0FFZWFIZitObUwwTzloU2JIcHVGU3BLM1RZVXlx?=
 =?utf-8?B?aE00T3lwMjNPYXRhd0NWdTV0YXViT0xXZ1V1Tk9NbmNXOWt2V0xYWE53Ylhq?=
 =?utf-8?B?VE5uV1M1T2FqditzNDRFU1V5K0N6OW5wSEc3VlNXck1OZm9YQmlmNE9kKzY1?=
 =?utf-8?B?T0ZTcnVQeXB3ZytWVk1rb1M2WGRVQ3RyYncvZ0R2UFNwTktyMmRKTWxTUDly?=
 =?utf-8?B?TzNRUjAycGxlcXpDczc1ckhSUDMvY3NpeTRCMzhFMnVOaXluV3E5MlFLUS9i?=
 =?utf-8?B?WE80QXNIYVFMcTViMURCTkl5YjZtVVlqZk4rN2xKVDV6aWxBeDFpSkhFTjI2?=
 =?utf-8?B?RW1vQ1AyYnloM2pwUjdUS01mR3NmYTdjSFNsNU5tamhyb3U3Uk1TOXA3MHNI?=
 =?utf-8?B?akY2NmREbFhvekZ5VjFtSHlpdkNYUWJoSjl2VzI4UGZaSFF0aTVrT2F1dHhZ?=
 =?utf-8?B?NnE1WEsxV01JVUpiZ004ek9HdWpuQUNqNS9ydFIyL1U1M3lJL0FDRGlpM0tK?=
 =?utf-8?B?a2lpZlhxdnVOdWhjRnhaUy9ZYzFFclJxTE93bzBlK1h3dGZIZ2dPRlMzL2Nr?=
 =?utf-8?B?UVp1blFMQWdzS3I0ekVyWlNkWllLbkNNcTJHZ2pPZncyd1VkQVM1TkRHVDRU?=
 =?utf-8?B?RnZadVd2TU1qNTNuazNFOW9wejJOMDQrNHk2TVpGVEN1L0hDUk5qczM1WnJT?=
 =?utf-8?B?OHBNektmSFpOZHgvdXFHUGF4cGFNeldVZEVIRGE3SS8rQ0xVaGl5eHRXVDh0?=
 =?utf-8?B?a291MmFhMEs2MkkzQi9DMjdHM1hYQXV5aHlYV25Sd05CR0JUTWRwSXc4cUUr?=
 =?utf-8?B?MTZtR3RkTUVKUmJDNHNsZmZOZTJnKzBkb2MycWNZVWFJOFZ5Vm80U1pPSy8r?=
 =?utf-8?B?NnZEZHJINWh6a2lxOWc1OEJWRjFwQzJwUVZZcEZlYnpxRjNpaU53Nm9RYWFk?=
 =?utf-8?B?TVFaY0V6dXhoMVhLNldSNW1TK1NJeTB4enNTWjNRMTZVMnE2OHNMbkR4R2VS?=
 =?utf-8?B?bU1jSzVDOTliR0J2KzdGczJVVlo5d2tYNGFXeFhpaCtic0F3RWJmSVUwSjgz?=
 =?utf-8?B?eERNWGhpK04rWVZwcWh6L1ZPc05MK3MwQXkrR3VUWExWOVF5ekRneFJONmpS?=
 =?utf-8?B?ZXE5TG45RG9vOTl4d05PSjVvT0pqMDNLRkxSNFd4bGNhMm1Ma2twUVlvSkxv?=
 =?utf-8?B?NXdORUVkSTVUZ1RIWjFrVEtTRkhBMTlGQW9uaDNZQkF3TjI4Y09JeVNjbGYy?=
 =?utf-8?Q?qKMWDON5a4Xwb2DhcJEKhT4VEALiP1UD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRHN3JWSXhqeE13SC9hQWthbVBkY1V5SGxXUTdOSENQeThoUnBBZTVTOGEx?=
 =?utf-8?B?R21ndWpxTjNsUmhPNkVNWTVld1BoZzJoa3VaUUoyRGZIK01qNStxclhxS29a?=
 =?utf-8?B?cjlGa20vUkJ1OU1xa2tXTGxITkZTM004RDhKSmJvd2grbExCMTdGam56V2Fw?=
 =?utf-8?B?YXMyOWtCQjdzcVVFeE5iTjJpRXZGREdMcHNHWlFUNmM3NDhGZ09SRTRaUkpE?=
 =?utf-8?B?Q1NBR09aeEVvQmNmUXhHdmNGUHI3REN5WHFYOVJqWEpTRHRZbU04SGEzQm51?=
 =?utf-8?B?RDY0R2FMbGdoNWtXSkpWOWFvMjIzandxV1hyMXVxMzEzYUg1aXVyK2ltOGIr?=
 =?utf-8?B?a1h5dDNrRWRwVG0vVi8rSVVPODNRWjVEbk1aUWlpa2RRaVArL1lYRjdSZmpN?=
 =?utf-8?B?TUZZdkYzTytGamppdkcyQVBnRFlYNlRGQ2dhcEg4cDRRc1R4eDl4UE4vMm9Q?=
 =?utf-8?B?OFlmWVd1Ynk3V2dZenF4SXFJUVJHSXFYaWtVU1RsaVlGM2pIVUNqT08xZUU4?=
 =?utf-8?B?a3doUU9CQTlDQ1BoTGY2V0tpeVJTeGV2enhWUHlzeTNsM3E3aHZINDlVRXhr?=
 =?utf-8?B?NjRPdklpcnJxZlg4S29mRzF0VTZKY2NQTVZRUUI4enBzWkJhdmZWcjFQYzNk?=
 =?utf-8?B?dDFGQzUwcmxjbDhCcHFleUwyZS9DYUJLYUpYM2lpK2ZPVFcwQmJZUUpHSTdQ?=
 =?utf-8?B?VFE0OGJIZEpZTXlSeDFDRlhmUWNoZDhOSUpJT3d5bDhLQXZ2KzFsL0ZxbW9r?=
 =?utf-8?B?eGxRUk8wUjRXY2NIWVNMaVl0SHNsTEhmb1dDbFJBVnFPd1Y2RHYxNGc5bnNK?=
 =?utf-8?B?YTd3L3NVNmNBbzVObzFQWTZ5d2dyS1dFNVppdTMyWkJQU0lsL1duenpXeTVR?=
 =?utf-8?B?dlpYOGdCQ1lVenh6TGZzOUhaTFhObzljREswUWQrdzFGRW1aVVRJVDFzeVN6?=
 =?utf-8?B?clhSRGJHNDhScHNPQ1ppdUNNd0xhdG1rb2lMcDc2eUU5ZzdVUFIya1BTaCsv?=
 =?utf-8?B?M1ZsYUQ5a202T0RDNEVTVHJGWGFaa2ZEUUdpRkFsN3poNXFhSTJTalFtTWgy?=
 =?utf-8?B?UWpwWi9NVkdHTmZHZm1Oa1FjbWVkeVlRS0xxb3E5S2NmdFpqZ1BZN256dG43?=
 =?utf-8?B?S1dTV3NzV1pWOTBmd0xaeXJiankveTdIaVc0WjFWUUowTHZnMitBU3pVR1Er?=
 =?utf-8?B?TGszR0U5Y0ZDSmtvU05FWEFnWWNNN0VvVlhZT0RzaWJiWHRUeU54Z3hxb3VZ?=
 =?utf-8?B?aDhXYnFZSkdBTy92V3hianVOcUEzYlZ4bEU4V1JUYTFlZHVUajhBQ1JuSWo1?=
 =?utf-8?B?ek8vM3dNT2tPaHBNZkFCenAybWwzVlNGRlVLcksvcEsybzRwTnU3cDBJcTJP?=
 =?utf-8?B?UHcweDg2Ny9ZY0dKUGtseUxQVVo4MHV4OUVJUWVTUkd4d1JHZjN1ZXNyK0VW?=
 =?utf-8?B?bmVLUXN3cHhBTXJ4SWFjTUFHTUFpaGpRUCtKbzRKZVYwZ3VLUmxkWFhSTlBK?=
 =?utf-8?B?ZHlkUTNCWUNlU3BZYXBGUTBkNzJRTlowYW5JS1owWjVTVHRPV2lWdVVDenc3?=
 =?utf-8?B?VEpHQktndEZjSElOTE9SL1hnRnpqMHRvV0FubmxoUENRSmVWOEQ1dzg0aTYr?=
 =?utf-8?B?clMvcFJsbEpjbzB6WWdGaDltY0RBUGtCTHBCYjlqdEY2dmw2b21paFZQN1dC?=
 =?utf-8?B?Y0wxbXNnQXpxV1dtbGM3M21sUlIvcWpHdDZaQUlwYTE2eTlQY3JQaTdWRDl2?=
 =?utf-8?B?VmhmNXZ5V1htMjdpYVdWNXk4TDBIV2ZvN2tXeE1CalFZNnRjc3AvOStTNUJH?=
 =?utf-8?B?ck5rdlhBa3dNM04vRW5yaWdvVEFmU20ydG1sSERrTWRkcmpPQ092VGpWN1hq?=
 =?utf-8?B?T0NFLzVFWG9vTFFzWjJUeFoyd2ZtaVZZanp1aVJCNWw1NmU2ZmVtSlh5ZVZi?=
 =?utf-8?B?SmFQK1JoT2JYdGx1YVNhaG5wY2FrV2hXdDJrY2puMjdyT0xxcnFlN1R3b2NX?=
 =?utf-8?B?OWt5Q3lIZnB5Lyt4VW16UmtUU0Zka28yMGk2SUhTdE9zSEN1enVjaWNXNkp1?=
 =?utf-8?B?cjRMRlcvMUxBNVFFVFNiWktmUW0yT2VUZW5HTnVITjBGN3NOZ2JsWDlPZEgy?=
 =?utf-8?Q?Kme0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de9ae9d-a927-43d3-ee4d-08de02bab706
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:23:29.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBVHWY7v6h41anjkoT/Rf28OiO76Cc6hGUD1BYM8aq9iHCBLw85X+L+4fcEj0HoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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


On 9/26/2025 5:53 AM, Khatri, Sunil wrote:
>
> On 9/24/2025 10:27 PM, Kuehling, Felix wrote:
>> On 2025-09-24 06:01, Sunil Khatri wrote:
>>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>>> along with it callers to use a user allocated hmm_range buffer instead
>>> hmm layer allocates the buffer.
>>>
>>> This is a need to get hmm_range pointers easily accessible
>>> without accessing the bo and that is a requirement for the
>>> userqueue to lock the userptrs effectively.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>
>> What's the reason for this change? In the current code, the hmm_range 
>> is allocated by amdgpu_hmm_range_get_pages and freed by 
>> amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.
> Sorry i missed your comment. For userqueues locking the userptr bos 
> and making sure we have valid userptrs at the time of validation seems 
> too complicated, so along with christian we decided to use hmm_range 
> list instead and have reference to userptr bo and via hmm_range 
> private field to be set to bo.
>
> Also i did made sure that wherever we are doing get pages and 
> allocating range the freeing part is taken care of. Specially for 
> freeing the memory is still done by amdgpu_hmm_range_get_pages_done 
> only. Please share if anywhere i missed something. Also Christian 
> brought out the point to have separate alloc/free for hmm_range which 
> i am working on and will share soon.

This patch has other components to allocate hmm_range, freed it at 
amdgpu_hmm_range_get_pages_done. This inconsistency makes other 
components handle error case awkward.  It is better to let other 
component free hmm_range no matter amdgpu_hmm_range_get_pages success or 
not. And amdgpu_hmm_range_get_pages(done) alloc/free 
hmm_range->hmm_pfns. That would be easy to understand and have less 
chance to make mistake.

Regards

Xiaogang

>
> Regards
> Sunil Khatri
>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 
>>> ++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>>   8 files changed, 38 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7c54fe6b0f5d..4babd37712fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem 
>>> *mem, uint64_t user_addr,
>>>           return 0;
>>>       }
>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +    if (unlikely(!range)) {
>>> +        ret = -ENOMEM;
>>> +        goto unregister_out;
>>> +    }
>>> +
>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>       if (ret) {
>>> +        kfree(range);
>>>           if (ret == -EAGAIN)
>>>               pr_debug("Failed to get user pages, try again\n");
>>>           else
>>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct 
>>> amdkfd_process_info *process_info,
>>>               }
>>>           }
>>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>>> +        if (unlikely(!mem->range))
>>> +            return -ENOMEM;
>>>           /* Get updated user pages */
>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>>           if (ret) {
>>> +            kfree(mem->range);
>>> +            mem->range = NULL;
>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>                 /* Return -EFAULT bad address error as success. It will
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index 744e6ff69814..31eea1c7dac3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct 
>>> amdgpu_cs_parser *p,
>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>           bool userpage_invalidated = false;
>>>           struct amdgpu_bo *bo = e->bo;
>>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>>> +        if (unlikely(!e->range))
>>> +            return -ENOMEM;
>>> +
>>>           int i;
>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>>           if (r)
>>>               goto out_free_user_pages;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8524aa55e057..12f0597a3659 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto release_object;
>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>> -        if (r)
>>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>>> +        if (unlikely(!range))
>>> +            return -ENOMEM;
>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>> +        if (r) {
>>> +            kfree(range);
>>>               goto release_object;
>>> -
>>> +        }
>>>           r = amdgpu_bo_reserve(bo, true);
>>>           if (r)
>>>               goto user_pages_done;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 2c6a6b858112..53d405a92a14 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range)
>>> +                   struct hmm_range *hmm_range)
>>>   {
>>> -    struct hmm_range *hmm_range;
>>>       unsigned long end;
>>>       unsigned long timeout;
>>>       unsigned long *pfns;
>>>       int r = 0;
>>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>> -    if (unlikely(!hmm_range))
>>> -        return -ENOMEM;
>>> -
>>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>       if (unlikely(!pfns)) {
>>>           r = -ENOMEM;
>>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>       hmm_range->start = start;
>>>       hmm_range->hmm_pfns = pfns;
>>>   -    *phmm_range = hmm_range;
>>> -
>>>       return 0;
>>>     out_free_pfns:
>>>       kvfree(pfns);
>>>   out_free_range:
>>> -    kfree(hmm_range);
>>> -
>>>       if (r == -EBUSY)
>>>           r = -EAGAIN;
>>>       return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> index 953e1d06de20..c54e3c64251a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>> @@ -34,7 +34,7 @@
>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>> *notifier,
>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>                      void *owner,
>>> -                   struct hmm_range **phmm_range);
>>> +                   struct hmm_range *hmm_range);
>>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>>     #if defined(CONFIG_HMM_MIRROR)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 901e0c39a594..046ff2346dab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>>    * memory and start HMM tracking CPU page table update
>>>    *
>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>>> once and only
>>> - * once afterwards to stop HMM tracking
>>> + * once afterwards to stop HMM tracking. Its the caller 
>>> responsibility to ensure
>>> + * that range is a valid memory and it is freed too.
>>>    */
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range)
>>> +                 struct hmm_range *range)
>>>   {
>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>> amdgpu_bo *bo,
>>>       bool readonly;
>>>       int r = 0;
>>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>>> -    *range = NULL;
>>> -
>>>       mm = bo->notifier.mm;
>>>       if (unlikely(!mm)) {
>>>           DRM_DEBUG_DRIVER("BO is not registered?\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 6ac94469ed40..a8379b925878 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct 
>>> amdgpu_device *adev, uint32_t type);
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                 struct hmm_range **range);
>>> +                 struct hmm_range *range);
>>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>>                         struct hmm_range *range);
>>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>>                          struct hmm_range *range);
>>>   #else
>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>> -                           struct hmm_range **range)
>>> +                           struct hmm_range *range)
>>>   {
>>>       return -EPERM;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 273f42e3afdd..9f0f14ea93e5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>               }
>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>> addr, npages,
>>>                                  readonly, owner,
>>> -                               &hmm_range);
>>> +                               hmm_range);
>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -            if (r)
>>> +            if (r) {
>>> +                kfree(hmm_range);
>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>> +            }
>>>           } else {
>>>               r = -EFAULT;
>>>           }
