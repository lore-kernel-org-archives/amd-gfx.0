Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76327C71147
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 21:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E5610E072;
	Wed, 28 Aug 2024 21:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qykhn6QM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0788110E06F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 21:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2v38fTtZhlFrhIPIC521x0ZJSZkMHFxz9zpcyvs0eCMywYWIWLAbgIVwrTbdcWuqrQsI71nx54ypiKiWWoQzACDDPSHe8xuVAx3sat3O2iRKq6PvV0A18wVdfQoDAeZlpoIExkoYh0Z+ldSDzxOcqDHdMOE2FqSFptvK4nqk7uqGc9eA70g2XZAu0B5Xg6lpeAkIUJIxQrw0yKKPEUpUnA6U8QKGgdwESdFA8eeowUKr8t5Hd4OEdhCD2ftjiHXZcMCUvc1rsBGN0x8L2xsQTWugk8nqCl2/qaX1G1w9ADJjMPMnILGooKAMjxMvM0+V4ECM1f5ahtg0Cds5OF4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHFeNRX59Bu/3rPvu4e4HYCE0YRRK0avOyyjTRMZuQY=;
 b=NBKvk3gVq/o9x8R47gVay+O74E5qH9C3GPQOw4uLlGHgkMoEHPfoU6OfaIMpkdMf1w9cubW9l4faJIPj3dUydGRXofDXB4eINt0YpJN0truvl+dWsVogcJuFX025ORRUuVW1hqA8Cnn/GCk842gqjeclDm92LTihgmr7NMK0DOanwlpfjxdv677yUflVEx0zVPVwMPk+y7BI60r6k7n9YRRczcIW8gefKrTf0UGFxvGv9VZeuW9P65KnBWl17BSjz4Cl1TsYT8ir0rEW/95WLa9sO0Io8nv1MYNvfm301KKdI7npyrbVTISG5fB42ChHMpH1R8U3PLx1dUNYdsqJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHFeNRX59Bu/3rPvu4e4HYCE0YRRK0avOyyjTRMZuQY=;
 b=qykhn6QMJUPyby2mPVq9vzY3mVYWNZxeOXYcBiwHglL5VhDMDb+1wQIGOr7wGn9KvfL7yHHERad+BFp5pcqCWeDOdhGHZD8d+Qvvhz+lEDcHo7WYWJykBH73M31eLCrzPSjf8+P+2s4nDmymyALYp6Fmx+7wv28bJV2VlJz9eok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 21:05:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 21:05:50 +0000
Message-ID: <82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com>
Date: Wed, 28 Aug 2024 17:05:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
 <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
 <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <77342503-b366-4d8f-93f1-91e75c0682a8@amd.com>
 <DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <3ad48bb9-ec0d-4908-a9d6-af60aead9de2@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <3ad48bb9-ec0d-4908-a9d6-af60aead9de2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2264e775-3533-418a-1bee-08dcc7a531e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkVJc0FSaTJHc3BNbWxmZEdqTm9xdjBFNmxyMVRpS0YrcUE5VXJ4aWJtaEx5?=
 =?utf-8?B?YlNBZVVpenJsNENyc1pOazFpeWRUQXVhdjh4L2hHOGZWQ0RoMWFPSHNYRDFn?=
 =?utf-8?B?V3llazNZdmI5azIyeHRwSTdoTU9Ic0lydEI3R2owMzJBREZXeHNQT3BiZDJh?=
 =?utf-8?B?MzljR3BSK0kvdWYrQWxZQjdCT0Q0V3lZSjdnNEtjTHFCYXpDZ0UzUTY1dkJM?=
 =?utf-8?B?QnQyL1Q3dnQzaFFQMGd6bk5DZTl3WHNNeElJRXRRMmFiblFpQms1bXBEWmR1?=
 =?utf-8?B?b3VNTzFoRkdLUldHNGNvdTFVL2lSQ0M4TUxnemxyOWZiS1dsT2JiNDhGQlRH?=
 =?utf-8?B?OW5INzBEUXA5aWdJTFFZNEoxbmhidHViaS9NcUFZajA5dXBESlRwd1RHL3Y5?=
 =?utf-8?B?QXkyOHN6Mm1WbzhQejhEdFpXOGZyNmIrUzQrSVBUSVJuUFBaTzhsalRwVTRD?=
 =?utf-8?B?enNuTGJKdC9aWC9ZQk9kb0JkUWIyRTBUNW5vbjdURnFCVGJrQk1LSUFrc1Mv?=
 =?utf-8?B?cHdtZk10ZTc0b1JPRndXNnBmNmZubDZaQS9mbG5objdMODVFN253dndXamZK?=
 =?utf-8?B?SUFFQU5BWmxnTjNrQUdMT2Z1bkg0Rmt3L0JGdmMzM1FDKzd4UTF0bHFhYkkr?=
 =?utf-8?B?UkIrQlNGS1ZpYWlGeCtjQ2xzNlRsY2FoSjlTL053aVorVUtkWHVPQWFXUVli?=
 =?utf-8?B?VFAyaTBGTjhFZm1LU3FuYVJSOXlCNXBQREVtdTBRZmdFMFJRVG44Z2RqT0c4?=
 =?utf-8?B?UVZuTmhVbGdLV1ZFYm16d3FGaTJLZ1M3c1lnbk1oRTNLTStjeWU2RzNVUlVC?=
 =?utf-8?B?enFLUVlqdVF0K3VnTHNHYTgweHl6MFR5M1pDWTdRK1VWYW9zbmphQ0hTSUdw?=
 =?utf-8?B?T0dhZG11RXN6anhsRWJPY09vaDNxalhQRGFmZ0JMeEgyYmtGM25xK0ZhRkhK?=
 =?utf-8?B?SXY0TVFYWTdDdFpnd0EwWnJQUXA5R1NLTGM3MVV1RVRNTTFnMXg4SnozQXRI?=
 =?utf-8?B?Q0EweDdUbkJZZ2NzajdaUHo2b1lLTVVGcWNEbkYxWC9hSzRLU0h3cTYrY2RK?=
 =?utf-8?B?OFRyLyttdG5xWjFTak55SnhxNlIveXY5TlB0VzUzQnYwMFNLRnZoc3AvSlFU?=
 =?utf-8?B?cUdFWm9pUVZaR3YwZkRqdG94cGdyaElXc0Q0cGdkWU5uaUNuQ01OdE1jNWlz?=
 =?utf-8?B?ZU95Qy9tZStreFdIV0xGNUFUblJuazJuNUgySVM3WjlsQWhBc3c2cDRHdHoz?=
 =?utf-8?B?aDhqSDVlVnBGQkZJZ1FzU0tMSkNVSkQ3ZXdlV2FxUFR1bjU4Y2UrbURIRHVS?=
 =?utf-8?B?ak4xQ3NBbzY4YnhUWUZWL25nMSs0VjZZdmNuR2YrbzRnellFQzNXZCtLZWEr?=
 =?utf-8?B?UXVlS2RoWVZPMWtuRlg0N0FzNVBmOXVjcndrUGk3d21xRThqN2NhREt4dk1p?=
 =?utf-8?B?NlNDdEFFNmZhSWs5eXE4dEx6RkJWbnhLYVgvUVA4UkJRVnpwYzV6YlBieGln?=
 =?utf-8?B?Qm1jU1RIMDd1eGJGV25FdXRUN05SQUtnR3FrM1ZhWkgrSWJIeFJVZkR3Z3NT?=
 =?utf-8?B?d2dsTmoxNWJGdDlkdUhSMDNDclQ1NUsyY1owK0VuNkQwTWs4RTQ0TkMrSzRq?=
 =?utf-8?B?V25nWGhJaGFPdVF1aU9Lak01ekR1YTFKZjM1SnpRYWRRTjUxcnNwTzU3S25s?=
 =?utf-8?B?VkpHUWdRM0UvZzR5TWpIVysxbjRabEQ1K0xtRWVpVDd1RGxTWFdHWFNjNkpy?=
 =?utf-8?B?ZlNOZGRxS0p5eVNBQlZCcUFScFhvSUVMV0hpM0k0K3UxNms0TVh6ZHRwbHJ3?=
 =?utf-8?B?VG5ZSXlPWnJRUlVnOGdDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lqZ1RYbGJGZGRDVVZOOWxQWFRmc2lIUVhBTzVkQ1RtVENUMzBHTWFaSTVU?=
 =?utf-8?B?ZEVzcE9ydWpLZ1BVL1pFNUtuYXVwbGVvTm1QUkVBem9QT1pWOS9oUmtGSC8v?=
 =?utf-8?B?Y1dGakRsdG5aU2J4cDJnWmg4UTI2L0xuZk8yRnc0eG9NeGZoNXRYajNsR2ND?=
 =?utf-8?B?Qm00c0YxZUx2ZWx2UzBQaThZSlZMYXFLa2FZcmlYRDNCYnZvVDVZYUhZVUM3?=
 =?utf-8?B?UHNKL1lMdElpRnlodEFaNjBLaFVkM0M0YlArTm5JRnB1OFhvWFhUTFN5REFo?=
 =?utf-8?B?Tzl3MmcyZXN6OVdaUmtFOGRqMTBkSDBtckZKUlZaSGJsTVB2bitBTUtlaWVF?=
 =?utf-8?B?MWtMaEdNcFdUcjYvc1FXb1lXd3NSVVJ1SUo1dWh5UVo5Um94QWpoWTg1Zk1k?=
 =?utf-8?B?bXF2dk5aWnZORTRnVU9HZm5aZWFpcjlkWlFTc3hLVnlaOSt6b1JqREpDSkMz?=
 =?utf-8?B?RTh1em5lcVhiOGpVZkRGbTFZeXAvY1I3cTVXQ3ZVK2pYSXNINDlSRys3RXdY?=
 =?utf-8?B?ZXV1YTZNSDZhUUM0eXNEa3NDZ0F6WDhnM3JUdEFSb2prUExvV2lyR0JFbmZh?=
 =?utf-8?B?V2FQVFRiaWRsKzVkNWVUdzFQSC9DOHo4RVZTWkNXOHpva1M0cWNwdWNLTHJp?=
 =?utf-8?B?K3ZNOHh4ZnJKZ0JIZWNBNUNUSDhLNFU5cyszTjVmUFEvWFJvUWdReXZyWlZQ?=
 =?utf-8?B?SWFEdCtPaHJsdHoyU1dTNGVxVzU3aTVhL056Q0xxcWFiSmVKWnE0SFJYRmhu?=
 =?utf-8?B?dzh1UkwvL05SQjdwcHNsUE5qUXdtbGhTMGg5SWhtSStSTlIrRnJ2UGVqQStp?=
 =?utf-8?B?bTVVak04YjB0M2xHR0hETi9aSzYyU05wYzQ4UFFqSVJyVVVycUNFd1NqVVg2?=
 =?utf-8?B?UExuSTBMUlNwK0JwMFFHT05wd1ZPUnJkRDdVZEVYZ20xRkdCZnU4Vml0a3J2?=
 =?utf-8?B?aXJTSW5kYU12QkhXeXJUdjUyQ2FoTEQzVGZINm9rNkNkR1VWVVNSVHRoRkhv?=
 =?utf-8?B?c00zeHAwWWdhQm1zbXFFaGRXQ3ZDc2hON0MxU0ZMS29hdjRYWU80Z0hPZVJy?=
 =?utf-8?B?ZDhDL3g0c0pNdEhzTitCM3FoMXU1VFMwUmUybEVqTEVRVjRtMWpiNzB6V0xU?=
 =?utf-8?B?RUZmaEFKTDhFbWgzYXRKZm0rd0FCZlRzVzZVbElXdFJRUi9oOE9BUkNVV0Qr?=
 =?utf-8?B?MWNnSVhucXFIWnNNT2ZpeVRDL2JFMUlhRitJWGRNRmZncFJuYnJBbndzSy9V?=
 =?utf-8?B?MExGVkNaQnZHYlpwNEdKWkJpaFB2Wk1LZ3YwZDdIWWNWOERvNFlMTm1PZm54?=
 =?utf-8?B?M1RwUXJCSUVrMFIrNFJBRVdlcTM4STZzdEZCanZUTzFDQitRb0FkNlhQVzgr?=
 =?utf-8?B?QlB0M1ordDdMbDQrNTR3L1ljbnBSVVZGR3FVOUVia2xDald5d0laU1JDZ3g0?=
 =?utf-8?B?T3RrSWtsc01odUtpc1QxSTVIbnY5VlU4MVY5RExRNkdLZUdKWGEvazdqZURB?=
 =?utf-8?B?ei83QkVQdzJwOTcybVVvVXU4Z2Q4NUlJWTBaTGpmSGcyUmNWbjFuMGYybTFZ?=
 =?utf-8?B?RzBVL1kycFMxYTlya0h5SUJBZ2Y0aEozc2lGZTR0RnRrV2tqR2dSYzZkcWNO?=
 =?utf-8?B?MlVHdjJlRDZxUVNEZVFJR2ExM3I4YVQyNzdtbE1iVm5OZzg0TThod0hEQlZL?=
 =?utf-8?B?YVowb3pnRkxwbEkwTGJ4aEZUajFVanc3VmpxWEFWK3lvZDZBSnZxNUVoeHR3?=
 =?utf-8?B?eUdleTEyTWR4WjRnSEVHZzB1N0p5WWx5ZEJLY2I3djIwOWpRbEY4WG1MRmc4?=
 =?utf-8?B?cS9DRVBmdGx1QnNzTllqOWtqOUFSUHllVFREZVNxbk9NYTIxRkRyZGpFeEg2?=
 =?utf-8?B?K2RXcmdZY0VyMlZTTUlVakhLbERCNmxGSEVxMjlxM3E1Z1AyVDliY1UzQWN4?=
 =?utf-8?B?MFFvcmpJRDRNbW9kdzg3YjdteCt4M2cybk5ja3M1WC8yNjVsa0xhY2g3VVdX?=
 =?utf-8?B?L2wvdE0yNzQ0eTNyc1Z4czRCbTk3WVVyNlJaZWJoMEgxNXY4dThRNmRXNjNp?=
 =?utf-8?B?dTZ2NnlnUVh0REtlTTUyWkZoLzRpcmVEWUhrdnljNWUzTkZQOXRYMFJpRno5?=
 =?utf-8?Q?FRtW+9mdpFUX1kQ0AXwmZBOb1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2264e775-3533-418a-1bee-08dcc7a531e0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:05:50.1237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvXXjYC9p4npGs/bYdQJCJtkGrUG50XyXOX/LsmksXqMDwQ+eUzFnPKJ9pLbzHuxh7B8kKcXnuFmZW60V5uUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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


On 2024-08-28 16:34, Chen, Xiaogang wrote:
>
>
> On 8/28/2024 3:26 PM, Errabolu, Ramesh wrote:
>>
>> Responses inline
>>
>> Regards,
>>
>> Ramesh
>>
>> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>> *Sent:* Wednesday, August 28, 2024 3:01 PM
>> *To:* Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> *Subject:* Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
>> module parameter
>>
>> On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
>>
>>     Response inline
>>
>>     Regards,
>>
>>     Ramesh
>>
>>       
>>
>>     -----Original Message-----
>>
>>     From: Chen, Xiaogang<Xiaogang.Chen@amd.com>  <mailto:Xiaogang.Chen@amd.com>  
>>
>>     Sent: Wednesday, August 28, 2024 2:43 PM
>>
>>     To: Errabolu, Ramesh<Ramesh.Errabolu@amd.com>  <mailto:Ramesh.Errabolu@amd.com>;amd-gfx@lists.freedesktop.org
>>
>>     Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
>>
>>     Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set migration granularity per prange. If both got set which will take precedence?
>>
>>     Ramesh: Use of Kfd Ioctl is available to users of registered memory. It allows users to control GOBM per buffer level, including overwriting default value. For ranges that do not specify GOBM, the default value will be found.
>>
>> If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will overwrite 
>> this parameter value for a prange, then how to know which granularity 
>> take effect? That is decided when user set this parameter and when 
>> the api got used.
>>
>> Ramesh: The value bound by Kfd ioctl will take effect. In the life 
>> cycle of a prange it can go from the default value to one that is set 
>> by user via set_attr() call. However, it is generally understood that 
>> that users of set_attr() will not call it directly i.e. the rely on 
>> higher level apis from ROCr or HIP.
>>
> driver parameter can be set at run time, not only at boot time. It is 
> not predictable  when user set this driver parameter and when the api 
> got called.
>
I don't think this is a problem. The module parameter determines the 
granularity if the application doesn't set the virtual address range 
attribute. The default is captured in the per-process svms structure. So 
all mappings of the same process will use the same default, even if the 
module parameter is changed after the process is started. The get_attr 
ioctl will always return the actual granularity, no matter whether it 
comes from the default or was overridden by user mode for the virtual 
address range.

Regards,
   Felix


> Regards
>
> Xiaogang
>
>> Regards
>>
>> Xiaogang
>>
>>     Regards
>>
>>     Xiaogang
>>
>>     On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
>>
>>         Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>         Enables users to update the default size of buffer used in migration
>>
>>         either from Sysmem to VRAM or vice versa.
>>
>>         The param GOBM refers to granularity of buffer migration, and is
>>
>>         specified in terms of log(numPages(buffer)). It facilitates users of
>>
>>         unregistered memory to control GOBM, albeit at a coarse level
>>
>>         Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com>  <mailto:Ramesh.Errabolu@amd.com>
>>
>>         ---
>>
>>            drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>>
>>            drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
>>
>>            drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>>
>>            drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
>>
>>            4 files changed, 51 insertions(+), 9 deletions(-)
>>
>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>         index e8c284aea1f2..73dd816b01f2 100644
>>
>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>         @@ -237,6 +237,7 @@ extern int sched_policy;
>>
>>            extern bool debug_evictions;
>>
>>            extern bool no_system_mem_limit;
>>
>>            extern int halt_if_hws_hang;
>>
>>         +extern uint amdgpu_svm_attr_gobm;
>>
>>            #else
>>
>>            static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>>
>>            static const bool __maybe_unused debug_evictions; /* = false */ @@
>>
>>         -313,6 +314,9 @@ extern int amdgpu_wbrf;
>>
>>            /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
>>
>>            #define AMDGPU_SWCTF_EXTRA_DELAY               50
>>
>>         +/* Default size of buffer to use in migrating buffer */
>>
>>         +#define AMDGPU_SVM_ATTR_GOBM       9
>>
>>         +
>>
>>            struct amdgpu_xcp_mgr;
>>
>>            struct amdgpu_device;
>>
>>            struct amdgpu_irq_src;
>>
>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>
>>         index b9529948f2b2..09c501753a3b 100644
>>
>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>
>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>
>>         @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>>
>>            char *amdgpu_disable_cu;
>>
>>            char *amdgpu_virtual_display;
>>
>>            bool enforce_isolation;
>>
>>         +
>>
>>         +/* Specifies the default size of buffer to use in
>>
>>         + * migrating buffer from Sysmem to VRAM and vice
>>
>>         + * versa
>>
>>         + *
>>
>>         + * GOBM - Granularity of Buffer Migration
>>
>>         + *
>>
>>         + * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint
>>
>>         +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
>>
>>         +
>>
>>            /*
>>
>>             * OverDrive(bit 14) disabled by default
>>
>>             * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@
>>
>>         module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>>
>>            MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>>
>>            module_param_named(msi, amdgpu_msi, int, 0444);
>>
>>         +/**
>>
>>         + * DOC: svm_attr_gobm (uint)
>>
>>         + * Size of buffer to use in migrating buffer from Sysmem to VRAM and
>>
>>         +vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, "Defined as
>>
>>         +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
>>
>>         +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
>>
>>         +
>>
>>            /**
>>
>>             * DOC: lockup_timeout (string)
>>
>>             * Set GPU scheduler timeout value in ms.
>>
>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>
>>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>
>>         index 9ae9abc6eb43..c2e54b18c167 100644
>>
>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>
>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>
>>         @@ -868,6 +868,18 @@ struct svm_range_list {
>>
>>                   struct task_struct              *faulting_task;
>>
>>                   /* check point ts decides if page fault recovery need be dropped */
>>
>>                   uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
>>
>>         +
>>
>>         +       /* Indicates the default size to use in migrating
>>
>>         +        * buffers of a process from Sysmem to VRAM and vice
>>
>>         +        * versa. The max legal value cannot be greater than
>>
>>         +        * 0x3F
>>
>>         +        *
>>
>>         +        * @note: A side effect of this symbol being part of
>>
>>         +        * struct svm_range_list is that it forces all buffers
>>
>>         +        * of the process of unregistered kind to use the same
>>
>>         +        * size in buffer migration
>>
>>         +        */
>>
>>         +       uint8_t attr_gobm;
>>
>>            };
>>
>>            /* Process data */
>>
>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         index b44dec90969f..78c78baddb1f 100644
>>
>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         @@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>>
>>            }
>>
>>            static void
>>
>>         -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>>
>>         -                                uint8_t *granularity, uint32_t *flags)
>>
>>         +svm_range_set_default_attributes(int32_t *location,
>>
>>         +                       int32_t *prefetch_loc, uint32_t *flags)
>>
>>            {
>>
>>                   *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>
>>                   *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>
>>         -       *granularity = 9;
>>
>>                   *flags =
>>
>>                           KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>>
>>            }
>>
>>         @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>
>>                           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>
>>                                       MAX_GPU_INSTANCE);
>>
>>         +       prange->granularity = svms->attr_gobm;
>>
>>                   svm_range_set_default_attributes(&prange->preferred_loc,
>>
>>         -                                        &prange->prefetch_loc,
>>
>>         -                                        &prange->granularity, &prange->flags);
>>
>>         +                               &prange->prefetch_loc,
>>
>>         + &prange->flags);
>>
>>                   pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>>
>>         @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct
>>
>>         kfd_process *p, int64_t addr,
>>
>>                   *is_heap_stack = vma_is_initial_heap(vma) ||
>>
>>         vma_is_initial_stack(vma);
>>
>>         +       /* Determine the starting and ending page of prange */
>>
>>                   start_limit = max(vma->vm_start >> PAGE_SHIFT,
>>
>>         -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
>>
>>         +                     (unsigned long)ALIGN_DOWN(addr, 1 <<
>>
>>         + p->svms.attr_gobm));
>>
>>                   end_limit = min(vma->vm_end >> PAGE_SHIFT,
>>
>>         -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
>>
>>         +                   (unsigned long)ALIGN(addr + 1, 1 <<
>>
>>         + p->svms.attr_gobm));
>>
>>         +
>>
>>                   /* First range that starts after the fault address */
>>
>>                   node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>>
>>                   if (node) {
>>
>>         @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
>>
>>                           if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>>
>>                                   bitmap_set(svms->bitmap_supported, i, 1);
>>
>>         +       /* Bind granularity of buffer migration, either
>>
>>         +        * the default size or one specified by the user
>>
>>         +        */
>>
>>         +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
>>
>>         +       pr_debug("Granularity Of Buffer Migration: %d\n",
>>
>>         + svms->attr_gobm);
>>
>>         +
>>
>>                   return 0;
>>
>>            }
>>
>>         @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>>
>>                   node = interval_tree_iter_first(&svms->objects, start, last);
>>
>>                   if (!node) {
>>
>>                           pr_debug("range attrs not found return default values\n");
>>
>>         -               svm_range_set_default_attributes(&location, &prefetch_loc,
>>
>>         -                                                &granularity, &flags_and);
>>
>>         +               granularity = svms->attr_gobm;
>>
>>         +               svm_range_set_default_attributes(&location,
>>
>>         +                                       &prefetch_loc, &flags_and);
>>
>>                           flags_or = flags_and;
>>
>>                           if (p->xnack_enabled)
>>
>>                                   bitmap_copy(bitmap_access,
>>
>>         svms->bitmap_supported,
>>
>>         --
>>
>>         2.34.1
>>
