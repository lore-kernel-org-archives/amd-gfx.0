Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC162C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 03:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9D510EA0C;
	Fri,  7 Feb 2025 03:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="utICUmr1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B5C10EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 03:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHJW3WzO3jK02zY4NJyfYiWt/yWbm5NWylBhp38WH9L+06BbG31PkSH64HOxUCrpvYhRPV7TYg8VAEltclCYmYbWhhHdQzQ9cF/HOB+Afq4luKb4FCOOJM2Ju+PsXhJr2pp3NfvldhYT6vUkLTAkPqFo7vv5OSp5bnSRhads4cMd5L+7bGZLGjqhw5Z51pgWT5VCvUl5YImKendXivPckr6ZRZ1+8k7YiH1tMgI62ZDvW5nuS5tnYZBMuqaecHQb5kp2QAQT57M3CcfknX1qolyerU981rA8mLcqYgJRNMt4dF/2WEFgyHSIqt+evCQ0xzVnGj0/HHNydRQFPx9hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beKSd13MX5euo4SFzoRJe3043qVHwRrLJ0rnid+m5O8=;
 b=x2j4qOmFlp9NIJAL1sWW4JhEjiHLCS94oDrYuPF2nKwicXSclnCX7lFAMmHfeHZPjBOfXOb0nBWT3DKtH8dM4Wz09MER8UHuCTll6ejkagKDO21wlAvBh4fXofHY2ZQ02xJhzjcl0F0fb7loOZxNG6zxKz0MAUeiUbC3VgUXS5zZELZCPiHGv/gOLTpiOXv7nsv79rTEWrVLeUQ9BDB1HdR4gAKzlc1c9uQHzOOp4SH/AGX5OszOETkExvgOLSB3ATTmPhWi95+Jac+vNKGA3nOwr2rHlmW3rz3Y+JWusu/+NYl7hacxhuzquUrdveCCogvGVE5R3+j2VtPL13+Y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beKSd13MX5euo4SFzoRJe3043qVHwRrLJ0rnid+m5O8=;
 b=utICUmr1vm5XO9lEnkYk7dsOIVCau64p2zykoHL1CbuGMXx1RyuQiWkVF4hBN5evvUy9o8jc/Go6qYzrGOVjqlcFnQtRV9Ic9T9BdMKKF4cZRd0Ay+ryUeXuQlfGBe0KfDayBsIiyJ8/z1EIAgNwqfvY/5r2kpT8GDHA8iAgb3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 03:41:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 03:41:53 +0000
Message-ID: <c4efb797-6d9a-4586-ad98-56edf79f85e3@amd.com>
Date: Fri, 7 Feb 2025 09:11:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
 <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
 <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
 <DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com>
 <b8f65db6-a4fa-4d13-809c-ab8061276e7b@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <b8f65db6-a4fa-4d13-809c-ab8061276e7b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc10f53-68c9-4b39-0fd2-08dd47295c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzVZWU83WUJXanFqUkVENHB5cVZrTm9uQXBzUjNIMGdjeEQ4UTh1ekwxRXNV?=
 =?utf-8?B?L2VPTnJISEJJeUg5cDE0SXA5cys2RGVmK2R2aUpBZkxnNEZNUUFBeUc3WTNh?=
 =?utf-8?B?em5RRFN1TUFHbXk3d0NQd1FNeXVvYUU0S2tRNUJJS1RYM1czVFYxNldVZ0c3?=
 =?utf-8?B?YUp2MHE0TmlEZDNWUVQzU2pUU2xLYWJIZGJFZlM3UFBnV1RreUpEL0Q3ejJS?=
 =?utf-8?B?aU9ZM2tqNGlzZnFNcVJXTzA2b1gyN3Yzbjl0VGF2QXkrNDZvaTljRFVHNCtB?=
 =?utf-8?B?WUVxT1ZoVy9lK3o0ZzVPdVZEZ3dVbnBMaEx6dDFvWUlVcnRRL080bk1jenpS?=
 =?utf-8?B?VUhQalpnM3A3KzQ2QWNOcW9hZDFEeFBhOGUxY3VJWDlJSFlOblYzN0tOUUps?=
 =?utf-8?B?c0dQWnRQSFRFVS9mWGhFMGlNclJieFIrbVZma1RxMFpFSklHVEduSlYyQnkx?=
 =?utf-8?B?TXhsWktNRThZZHErZjA5Z0c3UzNNVGN4VWJuZG5ET29LVzdWUm13ZXRKOHRM?=
 =?utf-8?B?ZGNXWUUrTlNnSDlKK0Nnc2s0RFd2bkpZUnZUY0w0bUZWSEROV0YwMXMvNUQr?=
 =?utf-8?B?elE2cUJGNjBnMjdPQ0Q3OWM2R0VETmp4SXRsakZXMWlRUmFMMXlpUVVQaENT?=
 =?utf-8?B?WVAwMmhYVlhnKzFzVHNRSEFjOHdyTjNzeWM2d0NIRmZwWWN2RDdhSzNHZnhE?=
 =?utf-8?B?WEJ2OWFVRnFXL2FldDEydEw3QnZkVWZNSUc5MzdOdStIbEs4Q3ZIWWN5Y3R3?=
 =?utf-8?B?VjNYYzc3RnpKR0hKVktoUkUvZE5ERkp5bVRhbmJBdVFKa05KZTBodnVIdmk3?=
 =?utf-8?B?V1FscGQzZmxOcjRsNnJMdUZwTTEzUFdOZjc1Q0ttSFBsV1FxbENEUWdNZTBQ?=
 =?utf-8?B?WlJ5c2RyZ0ZkRUJKQUNOcmJscUh5amdSdWJKdmthU1AwWENDL3F4b2pkRHMz?=
 =?utf-8?B?c0k0OEppUllaNlZ5dGQ4Q3grZ0dWcTFqWXNhU0hmdEVJeHlxUkpTS0FkK3dh?=
 =?utf-8?B?RENOcUJJckhXN09ZblhLK1BCdU16cHFaTXljOTg5VGRZYzFhYnpBSTd1eDJL?=
 =?utf-8?B?SW1kaGhWeGlCYWYrbFhvWjZKSVptUjFkdC8vV09KeWlEeS9jQTlqQXlWZ3B2?=
 =?utf-8?B?bUQ1QmZEQW9lZjh0VVhYTW9GUjhXK0lQNGhiVWtKY2pHRlZkNFM0cFc5T3N0?=
 =?utf-8?B?N0lxRTZjcTkxejZUYVFRQ2R4S0pGNUYrcGtqRmZvV3J0UzBTazVSTDIramJ1?=
 =?utf-8?B?WnV6anJwVGVpQWRqa2diUjF2SHQ1QkJwMEhjMExraTRvTG5Gdk16d3NXRUpK?=
 =?utf-8?B?bDl3bmJOQXhwOHc1cE1rdW4vRU9IM1hUNm54N2JWWm4rVk41ekc1eDQrYUs5?=
 =?utf-8?B?RmJqcGQzaXRXZndzNStKRHlPUHhRdjlVOXNQdGpsTFJ4ckZHOFk4R1dGSjVK?=
 =?utf-8?B?dEx2UGdXUW5aSTFYek9oazVmdDBPU3gvcENkMjlQcFoycGJIWDIrWm1uL0ZC?=
 =?utf-8?B?UWZiZU1pU1JBb3hlTjRmVms5bDg2SUh6Mi9vcENhbFdQUmJOcWplck1nTlcy?=
 =?utf-8?B?MlVDYlRKdlZyNUllamRiTlh3OVUzT1Y5WDBmd2NEalY3QTBIMHRLUVd5dFhP?=
 =?utf-8?B?S3dsb3FlUFJkSXNkdUsxSDhraFlEQ2xQUDVnREtKellUdFJhYjZ0c2hxU2pl?=
 =?utf-8?B?WUc3S2ZuZEZaOEVnM2hjNHRVb2ZnMDVmRDdKVHpaNk96cGJXVk9IQU4vd2Mz?=
 =?utf-8?B?NVlkdi8vRTMydVFoWHNOZDFmejNkK2NWcnNGNlBqZ2xhdEVuSnZ5QklwU3hJ?=
 =?utf-8?B?VDJQdytBcVV6WCtqdGdLdzdmTTJMQVpraytqUHM2QWtoNjhVaFdhdzdOa2o3?=
 =?utf-8?Q?0yDAFBu3pY+eF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHY0WVpnbXEwRVVYc3Vza0pRaVdRRENUVU5sYzQ1VXR6ak1xZ1lSZitiYjZ4?=
 =?utf-8?B?dC8vKzMzOVpmZUxhY2Q1cVVnV0dKNStjenphS0hJNWtJRVNaTFo0OTF0aGF3?=
 =?utf-8?B?eGkxWHBLem43NXNSVTVIcVltdy9ldSt2elFPRTZhTElySXNuZ3JEengyZTdw?=
 =?utf-8?B?UUlDSnR6NlNNclQ0SzNHOWQ1bGZGSndJSmo5a2Y0WlhybjlxcWFFb3REemd6?=
 =?utf-8?B?bFMrUDJGYjZhRUNjdGhCSjlsaUdJTFJJcmd3b1VWREIrK1lpcnZRcCt5VWhC?=
 =?utf-8?B?cWd0UHp2MEJVRFhveW9QRG50ZnVQc0ZrOUxPc1o4OWJjUk5RVC85V1FaRnM5?=
 =?utf-8?B?ZEgrMjU3di9NWi85bmNIalMxd2ZRa21LWHMrWHhKQ3hHM3I1NXZqSW5qODNV?=
 =?utf-8?B?M2Y0N2F3d1JnMEpwUWhJZytFSldacWNpUnk5R3BmcXZMT09kMmg4a3ZhTzR6?=
 =?utf-8?B?S0w0MzNqYTFnMWRjV2N0UFBVcUxieTdlSGg4UENzdDNaekJTd2tXb09ta2Rj?=
 =?utf-8?B?SnlGR0ZldEtieldvNi9LckxpL3RaNGNEajMwcmhTTGpXaWdpNGwzNzl0UlpC?=
 =?utf-8?B?NURsM1h6RWV1d1B4REJPQVJmdTRWUUhBekJ1L1lFTW9EbW5PeU1JSWtQam9M?=
 =?utf-8?B?TWxESkswVnhvN094VGJadE5SVjBtdTU3N3ZFQ2xSTUhIUnVwa3ZKN1YxUlZa?=
 =?utf-8?B?M013UUlBbVFySHhDWFpxVjFOczJvMzBFdXJkMk5kb3IvMUczY1JUK2ZMWkov?=
 =?utf-8?B?amNFQ2lRSVVsY2h0bHY5bFVETldESEN4M25kUVVTLzFoZFpUSkdhU0N5Mjkx?=
 =?utf-8?B?L0ZTQ2ljb3I1aVcwTmRIb1lFbU93UzBpVWFwYUhZY2pXaE9tWDF1VEtmUXVZ?=
 =?utf-8?B?alErbEVkZXFTOEJCaFU5clVvajhmSmhRcXpvRGtEenlWTzdpeUF3QkxGWWNH?=
 =?utf-8?B?OXFLR2JMQnZFSk5NTGNyVG9zemQ4eTZUdUZHemN5ay9NclVjRlBXM2NvcmFx?=
 =?utf-8?B?SWlYMkNVRlMyajBOazhHbytkQW13cXJXYkl0REJqZ0pZVUJsUVh0UXcrU3Y5?=
 =?utf-8?B?TzFCdXE0ZFR3Z2ViNjI2bXdJUllQV3VaaVFaTjlWRDMwRThTN2pGeDRXRzVm?=
 =?utf-8?B?cVVkYzlnUk05MnhSN21CaUk1aEJsTEpha01sUCtKQkpDdHBUZkZNQ1FUYWtJ?=
 =?utf-8?B?UnBGWWZhRXVWajlnS1FWWHRFdFI1a2I0ZGJqckZmSjFBVzJLWjR6NUZSTVR4?=
 =?utf-8?B?MWVldHdvRzM1M0lSTG13MW9sTFpySDJIL01NTUF6UmJvYVkzUjV5SXVxYWJE?=
 =?utf-8?B?U01pckxoYU0wdTRMVU1UaGhNdnBBMm04Tm5EQ3grS1MzOWIzY0l3K2pyaDR2?=
 =?utf-8?B?Wmc0WG1JcFE0cUhDaGtYOTRITEdvdmN0dmZuVmtsRnp4WmhxRSttbE1hNXhF?=
 =?utf-8?B?YXFjMVZmY0VQS3BlV0lQODNxcjJIQnBhTHdySHNZY3Nod1AxMUtxc1pmN2gw?=
 =?utf-8?B?bTkvcGdJRGFCd09YTSttQUY5bHVHUW1Zc0pOWlpPVFRua0d3L0YxMjZCRDVu?=
 =?utf-8?B?MFlKcHBMcWR2akFNbDdya1hOc0lrSHpMR1JEcFZ1ZnhGTklZS0lQTXpPc2JU?=
 =?utf-8?B?cDVJVTI0aGV6c0ZmZGM0SmFtbm51NHNjYjlwYnhSUUNvOFBwby9QQUttakgz?=
 =?utf-8?B?ZGNmUDlyWUVwbUJFc0tMTXhkVk5mN3FhdzNWd2tVM3dOcFhmRmI2SVkzVHdz?=
 =?utf-8?B?TGE1MVRwdE1PdXZvOGY1UlZ5b1ZmSDR4U25MWm9SdUdSdnpHQmJXaGNsU0wv?=
 =?utf-8?B?eWhYRWZ5bS9hTjlOd3RqU05sV21uS1JkejlCQ3pML3Arc215Q0NxVFZ4OHJp?=
 =?utf-8?B?TDRwYkd4dk42dXVjK3g3QjI0bEd2RHJaRzZJbGlrTlQ1WjM4MHlscXMzSTVp?=
 =?utf-8?B?TngyYzB5dk0vRkdpeWt3UlZKVDJSbVM1K3QrdmZpMnFBbTA4Y1NOQnFYd1V2?=
 =?utf-8?B?QU1QaTY5RWU1TmFaOFRlTW5WTS8zOXZWTkE5Yng2UThLeGE1SDJ2dDFiMWZV?=
 =?utf-8?B?eFBsN0JXVldqK3Y5TnNFZk53QllKMTZUSWV5SktGdmJlQjBQZ0dyWmY0UW9E?=
 =?utf-8?Q?ESo5GCtbBmCY9QYWybY//PHgW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc10f53-68c9-4b39-0fd2-08dd47295c63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 03:41:53.0567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAdJgfADMnpsR1SRsZ0ohD+RjjAuP7KmURFZfwNMVwFllQVPOqwo1SkBiQruUXS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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



On 2/6/2025 10:18 PM, Eric Huang wrote:
> I understand your concern. KFD currently only reports one L2 instance,
> but not every L2 instance. If customers want to have more detail in all
> available L2 info, we probably can change the logic in this function,
> but it is not related to my change. My change is based on current kfd
> logic and fixes missing L2 issue.
> 
Even for that case, do you need to loop through all xccs? Expectation is
there are some set of active CUs in any XCC (in general, XCC without an
active CU is not expected to part of KFD node).

Thanks,
Lijo

> Thanks,
> Eric
> 
> On 2025-02-06 11:37, Lazar, Lijo wrote:
>>
>> [Public]
>>
>>
>> Yes, the problem is that. If a node has 2 XCCs, it should report the
>> L2 of each separately with the number of CUs sharing each L2.
>>
>> In this, it appears to loop through and find the first non-zero of all
>> XCCs of a node and not based on the first non-zero per XCC basis. It
>> makes a difference in number of L2 instances available.
>>
>>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>> *Sent:* Thursday, February 6, 2025 10:00:38 PM
>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
>>  
>>
>> On 2025-02-06 10:14, Lazar, Lijo wrote:
>> >
>> > On 1/29/2025 8:50 PM, Eric Huang wrote:
>> >> In some ASICs L2 cache info may miss in kfd topology,
>> >> because the first bitmap may be empty, that means
>> >> the first cu may be inactive, so to find the first
>> >> active cu will solve the issue.
>> >>
>> >> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> >> ---
>> >>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>> >>   1 file changed, 16 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/
>> gpu/drm/amd/amdkfd/kfd_topology.c
>> >> index 4936697e6fc2..73d95041a388 100644
>> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> >> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct
>> kfd_cache_properties **props_ext,
>> >>                               int cache_type, unsigned int
>> cu_processor_id,
>> >>                               struct kfd_node *knode)
>> >>   {
>> >> -    unsigned int cu_sibling_map_mask;
>> >> +    unsigned int cu_sibling_map_mask = 0;
>> >>       int first_active_cu;
>> >>       int i, j, k, xcc, start, end;
>> >>       int num_xcc = NUM_XCC(knode->xcc_mask);
>> >>       struct kfd_cache_properties *pcache = NULL;
>> >>       enum amdgpu_memory_partition mode;
>> >>       struct amdgpu_device *adev = knode->adev;
>> >> +    bool found = false;
>> >>  
>> >>       start = ffs(knode->xcc_mask) - 1;
>> >>       end = start + num_xcc;
>> >> -    cu_sibling_map_mask = cu_info->bitmap[start][0][0];
>> >> +
>> >> +    /* To find the bitmap in the first active cu */
>> >> +    for (xcc = start; xcc < end && !found; xcc++) {
>> > It seems there is an assumption made here that a CU in one XCC could
>> > share this cache with CU in another XCC. This is not true for GFX 9.4.3
>> > SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.
>> In KFD topology we only report L2 cache info of the first active cu in A
>> XCC, which could be XCC0 or XCC1. It is generic for L2 info in the
>> certain XCP/kfd node, and not specific for every XCC, so it doesn't mean
>> the L2 cache found in XCC0 can be shared with XCC1, it only means there
>> is L2 cache in this kfd node.
>>
>> Regards,
>> Eric
>> >
>> > Thanks,
>> > Lijo
>> >
>> >> +            for (i = 0; i < gfx_info->max_shader_engines && !
>> found; i++) {
>> >> +                    for (j = 0; j < gfx_info->max_sh_per_se && !
>> found; j++) {
>> >> +                            if (cu_info->bitmap[xcc][i % 4][j % 4]) {
>> >> +                                    cu_sibling_map_mask =
>> >> +                                            cu_info->bitmap[xcc][i
>> % 4][j % 4];
>> >> +                                    found = true;
>> >> +                            }
>> >> +                    }
>> >> +            }
>> >> +    }
>> >> +
>> >>       cu_sibling_map_mask &=
>> >>               ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>> >>       first_active_cu = ffs(cu_sibling_map_mask);
>>
> 

