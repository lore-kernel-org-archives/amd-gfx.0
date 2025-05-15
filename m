Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01706C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 18:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8C910E936;
	Thu, 15 May 2025 18:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zN0KWQHe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC37A10E936
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 18:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msb61Ypvm/wvp0mnRTaaVGykBqSC/DajrZlgrBzBWHLBTH1c87oNfPhVUbXxYDb9y2glH1GQa+lQkOlItK6QINSzj1VAGMsB7lbd1IVo0mXGxiuiMoKh/3LENeRecYQ+/USVCyq6Xt+FzL7CjwfMZG/c1tDFt/aAOl787LiUL9PvwAyZNo/gU0WxK0O67jxlMVM9CElhHPc8O0cOcBvevx+0ASVIiPwL4YJ3bAL5m3wALssDcKZ4dYJsnpGMhlu6hJRR6UFCb3DT5RdDbWNFF3hY2PC2m897OFdbSnIyXiRshv0U52fwik7trARuAqo+8PsanY7Hhsssp+vvYaFlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF5H0TNU4EWmkkVkFp2gZPfH5/lrKolg9JQxlUp6udo=;
 b=PzKd+PGuFqh/9+fM8qlLkqFb7ZW507ZR77RozITGhYsvt4G7qKekBzvCQ53HTzM8w5+4atGCPzsDHdr5uhIFAoUCxr3J2gsWQjz9FVIXc3bxDJj/9rE8to2h/SKS12jKHfWZ2lR6G4kPMmHDTAfU612T1Pp0mxSaV/zVC5gFNxTsjo24CliguzpgCLiySzNM1hEN0mvr7XEPyJO/jWWaTJPl++4L/kOCx2vGol1j36EFv0Q5SA4F4LHjC2NCf4b+ekLZ3ra2MvkVZYb5QlxgW18gBaJ8zf4bSuLlINaqVapUQ5jS0wc2uIbOXF0Bznz2wLnyOa8WeuQSo+RE5RBjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF5H0TNU4EWmkkVkFp2gZPfH5/lrKolg9JQxlUp6udo=;
 b=zN0KWQHekPPsY1OmvvxwFBeH1Yj6H7dOwhnQgXmiYL0TgBnrhqi3z2IKtBs0ACEaJrIc70107kOdmk9btipEkDifkh+wE0xqYYTXYT7u19Udqp4c7DVL7Ew70TZRmCQZLaREM7f97XX+qB10JYHnP2vA3JnvAuF+qySLlmQLA1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Thu, 15 May
 2025 18:09:43 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:09:43 +0000
Message-ID: <7549db4a-96f2-45fd-8891-7ad05dbe8672@amd.com>
Date: Thu, 15 May 2025 14:09:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add GPIO resources required for amdisp
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250514213721.519943-1-pratap.nirujogi@amd.com>
 <f2d33475-53e8-43ec-9095-95081e480989@amd.com>
 <6088b764-cf5b-4c21-be95-4695730456e3@amd.com>
 <9fb6bd11-4855-404b-af11-004a7b2bf65a@amd.com>
 <CADnq5_NrqF2ZDuN=kf-VT-zWC_9vAdcr-3cwnC3D1_WW3mdWUg@mail.gmail.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <CADnq5_NrqF2ZDuN=kf-VT-zWC_9vAdcr-3cwnC3D1_WW3mdWUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::6) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: c886cbed-e61b-4e1c-591d-08dd93dbaab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3NvdnR6ME5nemVpeWxFckFlRDgrZjhqM3BKMzdDSzROOTE4d1k4N3FZblg0?=
 =?utf-8?B?MXkycCtZcW5wcHp3Q2wremlJRFlvQkkzTUt4NTJ0ekNySjJyNDNRQXI4cnp4?=
 =?utf-8?B?eWszY1VpVEtoenFGYlBQNWs3Ylo5VWZGVXlDTzN4SUVUQUtuTVlKZE5ENVht?=
 =?utf-8?B?VUlmNC9JNnp1OTB3OFEzZkJPUG1iV1JPM1lRZ1hhUUhKOEFTS3RoUkpGQUEx?=
 =?utf-8?B?Q2xmMHU3U0p5L3BPRjdhZXRpYXBoODEvN3N3NndhTmhmY2JKSDliSnZFN1J4?=
 =?utf-8?B?c3o2MVFHRVE5YVhNUVBsMDNZdzA2cUhSSVBVY243NGR4VWpqbU8za2RHV1ZU?=
 =?utf-8?B?dmRDMFluWXMzTlB4emtwK1l3M3E4VmtXTmdCb2FZa3FpUGxOUzZIWjlZSFIy?=
 =?utf-8?B?WDJ2Smk0TTVzOEcxWm1hUER3R3ZVcDZCQ1I0ZGwwd0p1aGprRWZ5aURBdlg3?=
 =?utf-8?B?Tk9CS2xxWlZHRDZlanR0U0ZlWXVyTWI1ekpTYk13MFRpZFQzR1BFaXhDQ0RU?=
 =?utf-8?B?cGdPVW9WbEEvMWd5eHRTTFJvRzBGYlMwMTI4elNDM3Noekt2RHhDTVlHMUdD?=
 =?utf-8?B?dmVFcWxvejVRd3l3c3JJUmF4QkFrTUw5L2UzZWRHZmZGOEJpWTRiVDNnTXBt?=
 =?utf-8?B?OHJwTTdGTDlhMC9XZDluMTJOay9EbWRQMHJ5VExmNGo5UVVaT0tYY3dUOFFj?=
 =?utf-8?B?UHB5VXZXRmNYYXAxdW00cU0xVUFsWDhGL3JsQXNkQ01NUkc1cXBiRzAwUTZR?=
 =?utf-8?B?cFd3NzJxMnpPUTBtMWZiVlVET09WM2xZNXp4QjgyR1IzR3VNRS8rQkZmN0N6?=
 =?utf-8?B?UWU0MGF6K3AxRWU4ZHdZVlJVSUY4NHQ1L250dzFUT1J0N091ajhneUtEMVdO?=
 =?utf-8?B?ZTgySit0MmdlbXpQTHNJeit6SlNWd3RJVFJ0SWJuanBVQ0VJbU15NnZoS1RW?=
 =?utf-8?B?ZEdHbzdNNkxBVTU3dyt3Q0tDU2EzQ2JHcFA0aDRlcmpQUDZaQ1M1ZE9IYU4x?=
 =?utf-8?B?NG0yMnJheXo3Mm0wbUFGdjlreHBDWmNpbjVTZVNxQjg0V3ZUcnc3Y1NQb09a?=
 =?utf-8?B?anA1ZWlOOFo4cFlvMTNNT3dlclI0blJkamlTQkhsTXBCQ0Q5RnNVTnhZRGNO?=
 =?utf-8?B?OVVKV25mUzVjejFUaXRROUgwRUhFTGZndW5nd2lTTDBrdTgybSt2eDc1UUhU?=
 =?utf-8?B?UlBhTC95cXI0SHYwb1REMDh6THc2UE1EYjBCeW1FMEQ4M214dnJkMEZvQ1Ex?=
 =?utf-8?B?VTBnVXVIZUNRUGxaVXdiQVdTMkFyYzdDSTBjUVhzaEk1dmF4ZURQZFBGUUxU?=
 =?utf-8?B?QjdzOEZZRHQ1TWp3QmVtOW05ZXBoalhvWVBrb3FCMVdWcHM0WU9YajJJRnVq?=
 =?utf-8?B?NnBrMEtZYW5ZV29tbk84T0tIL3pQT1VoTmpGV2EyWjV6WUNOdlZFSndMSERo?=
 =?utf-8?B?VE9KSUs2Y2hlMzljZFBhQ2xYOFBicTdVM2pNQXNIK3pEczhMMkR5N205bGZR?=
 =?utf-8?B?cWkrMkJPSEZvMzhmYU5nZTRmdXk0VFBVVkZ6QkZCZm1PYWpiOXl5TFkyUkFr?=
 =?utf-8?B?SXBjLzRSUWVrUitUMmI2MVM3bHJvVVd2dGpUNkNmaDBWTGV6RWZMOXNQeEJH?=
 =?utf-8?B?UFkxbWJ6WC8wVTNLVzZSbUVwMm5MbmxPOFQ1WHd3SytXaHoxT0FlVUNUNldK?=
 =?utf-8?B?aW0wVk1TUDQ5dDEva3Z0dGtoWDJmRzVNaGtRdFJ1WWZZOU9yYTR0eDRCTktE?=
 =?utf-8?B?WnlXWk5WNmQrMUVaTkhwa1BtYThwTXp0MmRid1VGWEZzNENuQXB6Tm1BN1BF?=
 =?utf-8?B?aVhDVktzTmc5dmpCeFFxS2JQN285Y2tLRGhseFoybmFKdUlUSWxvdlVCSmlL?=
 =?utf-8?B?VTQ4bC9RTVl1TW90bnZMbm4rZDRmb2RoZ0RISFhhc3M1VENOanI5L3dkVnl0?=
 =?utf-8?Q?l7qhOIzqSWM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXU4SmRzMGVoOFlkQnlnRjh3NDhTY2syL0MzZ1c0V0prMEVHYkxuRnlrUmIx?=
 =?utf-8?B?em9ETEZEMytORnpqcHQ5VEJmMFVDSjhISnZKV1FnQVRmMXBRYUkvM1VlMzFJ?=
 =?utf-8?B?R2xwdGp0dHhZcVFlUGNxeXk4RkRHSkEzZmlmMk8ySTJ4SkVMVEM0aVY5S0Ex?=
 =?utf-8?B?RUU4dE1CdjZicjJGd3ora21JNFIyclcxZ0FoVTRmbEdacTdWVnFIR1Y5NUlz?=
 =?utf-8?B?bUh6WURUeGR4cG4ybUJqcUpJUEp0cGZ1TGxBN2krV2xiVDcvT21LTTNrMmpY?=
 =?utf-8?B?VE5ocWI0czZZYzhHUU9ZQ05odXRlK00wdXpWRHVOOEFWQjU2Zno0REZ6VDJp?=
 =?utf-8?B?enhRSmRKREt1c2s0NVg3bHNTemFUWnpIQlVjcXcrUWlmdFByNmV1L0NuL0tU?=
 =?utf-8?B?YVc3SWg0OG1pT21ITXNORUFXWmQ0RmlkS01FSU8rTkFMNmNvVUxIbmpuWEtj?=
 =?utf-8?B?RVpBMENqZnVNdWd3UE9lWHpucDVNOGtONkFMRDZER1FoUDV5azVrYjBQMlQv?=
 =?utf-8?B?UmlmZkJualcrTWF4eHBJclBhS0JHdHRNY3N1WnB3N0FPOUgweXNtRkhlVDdL?=
 =?utf-8?B?R3pwd2NGQmk2OVd2ZGNhWGt1UXU2eGN6dllySWswWkozUi9SS20wRTMycFNG?=
 =?utf-8?B?TEJJenRQN2JKaFRhcGJyNXZNL3llcjZRSHg3N0taTDlYM0E0Y1pVN29kS1Bz?=
 =?utf-8?B?RTNsNDJYRm1sczdQYnZ0TEtGWkxpTnhZcGlRbitiakJseUFubm51SDFVZkxw?=
 =?utf-8?B?alExQUdlQWUwUjA0L29vQ0NYVUVwc0F6dmc5UlZ0Y1c2OU03N2FWUGVYbys4?=
 =?utf-8?B?WlF0WGJFclk4ZHpaSWdpanV2d2RsR2ZYWWhkeSswdnd1RFBuVTk0SjR4L0tu?=
 =?utf-8?B?MHZYemZ6c05mUm0vQy9CK1NuZHladWkzZDJZNEhFeWE1V0pid3k5cFJjZnRQ?=
 =?utf-8?B?aGtDb2VQUFhxNEpxeGZPUnU3UDdwRW1iYTNJYnlZT2p5bjhnVzQrbTVLTjAw?=
 =?utf-8?B?WmZVYzlNNFlZU2VwZFp1SVZ2czJOaVlSb2FnZFNrSldPRFJNdmNKa01VSGpi?=
 =?utf-8?B?ejZQMVRPMXcvNXVPZ1hYWGNqbnRlRGY1WVkyVENVWEcrTFF1T2pDY3k3UjFL?=
 =?utf-8?B?VkhKWjFkbTIxRGtrZzY4S1Nxd042NS9nTnFyRWJQZHk5V1BsRUhUMmZ3WSsv?=
 =?utf-8?B?SXpHa2JNL2g1Tzc4Q20zM2djV2ZWblhaODZKVGIwSWN6Z04wTXNRMDJKckFX?=
 =?utf-8?B?dTBNM3VjNWhoSzVGcGZ5UVBpZWZsVzdpM1p6R3RaWFptNkJFZ1JGb1BRUlkz?=
 =?utf-8?B?TTdWQVN4UWZPdjZUVXF5MDYvd1hDcDlCZVVvZjlib3VYNFQ5Znl0OXdBQXdD?=
 =?utf-8?B?YjRwMXpNRHkva2MzdEZrZE5HZzNZOEdoMHIvVTIyWFlGdzAwRnkwb0NLdnIr?=
 =?utf-8?B?cC82UThhY3R3RTE0NjlEVTEyMVlXaENjTnJWZHR5RStGME1UVVNmR3Rab1dY?=
 =?utf-8?B?NHFvRGFYS2VYVnRCaG0zYTJXWDR0aHBUbnNEVmJ3b09OdDZGOFhwUHFJc3lL?=
 =?utf-8?B?c2NSY3hQL0FiUDdySWJ5TTErcFdmNnRWaXU1VENxZjh2SFdPQk9nTTZidHlN?=
 =?utf-8?B?M2FuanRWMGdJd0VsNFVUYStTM3RUaG9oY3hFNHNQdmM5M0N6V05GUmhibnRq?=
 =?utf-8?B?ZWhycWM0c3QvUUtwOXEwazl6TWJXT3cwc0lOdDdYUTQrY2g2bVNubXJ1dTJr?=
 =?utf-8?B?cTZUa21veU5LZmo3c3Q4MzZZTkVYOHdTK1ZiUWI1RWRIYk40NFpBNjNjWXNK?=
 =?utf-8?B?L0lia1l3S1VjSHBncmlkZWpXT2tqUHNLSkQxNElQMjduendqOXcxc2VGL3E4?=
 =?utf-8?B?RXgxRVZQVEZGOVppZGsrQW9ZaHpJQUFIN1FvaXRselI5V3FHZllHV2JOeFRq?=
 =?utf-8?B?cVhTbHpWRjFUM2E3VTJyc3hmQ2tWeS8vMnRVeWVycHIxdFBCL0Fna1BGYmU2?=
 =?utf-8?B?SnZweUdNbFBFMG4yaGxKWTJpN0hZWWlHc2Z6dmtRYzVRMFR3ZndHL01tbHQ5?=
 =?utf-8?B?M20vNGRwQURXUHJMblAvVXZBVXNDUUZnL0Fvb0NhQXV2bGJ6QnhTaitHMGxC?=
 =?utf-8?Q?lgSMaz8D+IiJgNk8ZiVnMYfag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c886cbed-e61b-4e1c-591d-08dd93dbaab1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:09:42.9756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUbgWs70XF4xAfKtD3/0Mtx7S8JOm3BTimrjIuZHMZpH6liyJs6LX0p62vCfovMqIkdzlsIqIsjpLQrIwwEvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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



On 5/15/2025 2:06 PM, Alex Deucher wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, May 15, 2025 at 2:03 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 5/15/2025 12:47 PM, Nirujogi, Pratap wrote:
>>> Hi Mario,
>>>
>>> On 5/14/2025 6:05 PM, Mario Limonciello wrote:
>>>> On 5/14/2025 4:35 PM, Pratap Nirujogi wrote:
>>>>> ISP is a child device to GFX, and its device specific information
>>>>> is not available in ACPI. Adding the 2 GPIO resources required for
>>>>> ISP_v4_1_1 in amdgpu_isp driver.
>>>>>
>>>>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>>>>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming
>>>>> mode.
>>>>>
>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 46 +++++++++++++++++++++++++
>>>>>    1 file changed, 46 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/isp_v4_1_1.c
>>>>> index 69dd92f6e86d..c488af6c8013 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> @@ -25,6 +25,7 @@
>>>>>     *
>>>>>     */
>>>>> +#include <linux/gpio/machine.h>
>>>>>    #include "amdgpu.h"
>>>>>    #include "isp_v4_1_1.h"
>>>>> @@ -39,15 +40,60 @@ static const unsigned int
>>>>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>>>>        ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>>>>    };
>>>>> +static struct gpiod_lookup_table isp_gpio_table = {
>>>>> +    .dev_id = "amd_isp_capture",
>>>>> +    .table = {
>>>>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>>>>> +        { }
>>>>> +    },
>>>>> +};
>>>>> +
>>>>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>>>>> +    .dev_id = "i2c-ov05c10",
>>>>> +    .table = {
>>>>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>>>>> +        { }
>>>>> +    },
>>>>> +};
>>>>> +
>>>>> +static const struct acpi_device_id isp_sensor_ids[] = {
>>>>> +    { "OMNI5C10" },
>>>>> +    { }
>>>>> +};
>>>>> +
>>>>> +static int isp_match_acpi_device_ids(struct device *dev, const void
>>>>> *data)
>>>>> +{
>>>>> +    return acpi_match_device(data, dev) ? 1 : 0;
>>>>> +}
>>>>> +
>>>>>    static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>>>    {
>>>>>        struct amdgpu_device *adev = isp->adev;
>>>>> +    struct acpi_device *acpi_pdev;
>>>>>        int idx, int_idx, num_res, r;
>>>>> +    struct device *pdev;
>>>>>        u64 isp_base;
>>>>>        if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>>>>            return -EINVAL;
>>>>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>>>>> +                   isp_match_acpi_device_ids);
>>>>> +    if (!pdev) {
>>>>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected:%ld",
>>>>> +            PTR_ERR(pdev));
>>>>> +        /* allow GPU init to progress */
>>>>> +        return 0;
>>>>> +    }
>>>>> +    acpi_pdev = ACPI_COMPANION(pdev);
>>>>> +
>>>>> +    /* add GPIO resources required for OMNI5C10 sensor */
>>>>> +    if (!strcmp("OMNI5C10", acpi_device_hid(acpi_pdev))) {
>>>>> +        gpiod_add_lookup_table(&isp_gpio_table);
>>>>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>>>>> +    }
>>>>> +    put_device(pdev);
>>>>> +
>>>>
>>>> Can you please move this into a helper in amdgpu_acpi.c?  We try not
>>>> to have ACPI code outside of there in case someone compiles without
>>>> CONFIG_ACPI.
>>>>
>>>> Sorry I should have mentioned this sooner.
>>>>
>>> sure, I will add "int amdgpu_acpi_get_isp4_dev_hid(char **hid)", which
>>> takes care of:
>>>
>>> 1. finding the matching isp4 platform device(pdev) using bus_find_device()
>>> 2. gets acpi device handle(acpi_pdev) for the matching pdev and returns
>>> valid hid incase of no failures.
>>>
>>> Is this approach okay? hope this function signature makes sense. Please
>>> let me know if any comments or suggestions on this approach.
>>>
>>> Thanks,
>>> Pratap
>>
>> I think this approach is fine, but it would be good to get Alex's
>> comments on this.
> 
> Seems fine to me.
> 
> Alex
> 
Thanks Alex and Mario for confirming. I will post the new patch shortly.

Thanks,
Pratap
>>
>>>
>>>>>        isp_base = adev->rmmio_base;
>>>>>        isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
>>>>
>>>
>>

