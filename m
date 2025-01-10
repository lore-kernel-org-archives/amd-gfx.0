Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969F8E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA9310F122;
	Fri, 10 Jan 2025 16:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mclnTu7N";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460E210F122
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvSL03p7bcjSc64sfBkQJq/63B0Gfw/NuQqKbOFbmCRnK5A/5zQ/onALNYKaARqb19f8bqtVMRZbD5m63rPqntpjkHM/BSeP2rAUv6IROiMqt8DCooxYBOnqe4WYATcNlPnUoKZDfZF9l/M4VLE9vObFsBqwbxMq/x5mmzRzscOtvahkyZGIGBkzuInNt+EVmyhM8r4qDgmgXdUNPfrHV/PVwCTkyYRm4XSH8U12G38oi/cfIVr2SYBbvPEu1sV1uAI+9N3rcotBraFNz3sdSwjFo8kv7oJTQBlEcPTW8LbuvocLhH/wAQTmpBfJQb2uvQgzJ8c/1IVwiRlXGqXDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6hXgUpVjreFbZe9jbaDZnUlqLh4HgYv1SH/56fTxi8=;
 b=hi2uriVNDM1yfpkOHalF+/vOJ31VfQ/XzxfsOLXYc01riWtvnoee90YUhk2DO0hPS8J3Y6jygAopAJ1bxw21B3TkXCiaeqB81k/hJbmfvsar1blwZFlCf00dkPloL2MPH2h9xik+I4HJ6A/e7J/3lo6v3abymBpH07W/1PvSXNTN2CYzssA7DlvZZEufH4utaRMs7CUcMBBLkW50tsqldNF6iIcmRoww4crowfRI2TNY1khJ8aXDZ+Bh+m5mMTE9Vy0i3Zsto/LjJxZNO5rkpHb7SYIN4ie70xKsTGu/KRLZGyazEtfGvQUTAErG/xNwnBZ+XAzufjppc5stuoVt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6hXgUpVjreFbZe9jbaDZnUlqLh4HgYv1SH/56fTxi8=;
 b=mclnTu7Nr6kT/vZMNbCsjxF5gzeJljea5gTG/oMmwaG8SfEt8kU7G/CokA9cJFh96B9hf134I/olTHZQllOiDxJFqv7ZhQeb4ud4cV08j+YWf3zCOnvBaEAFVnFIIPz5aJlVYxdjpvxT5xNrXbmgjYt7UfNL6ACssU6S8jaEe7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Fri, 10 Jan 2025 16:29:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 16:29:24 +0000
Message-ID: <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
Date: Fri, 10 Jan 2025 21:59:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f85c78-327d-4660-5e4f-08dd3193f172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHJNdng5VEJycWpqMGZNK0MvbFlVaGwzUUVCcDF6VHk1UnpMM29lRGgxSlQ0?=
 =?utf-8?B?MG16T0ZiMzV1K3VuZkZ2cFFDMjZjZmxleW5EYXlmMXM4N2l6dEhBZXhjTTlC?=
 =?utf-8?B?Y1ljUzgwbTV3bjdjQW9aV08vNEVMdk14aExzMi9tUWVmb3F2OFhvV2x1QU1n?=
 =?utf-8?B?VWYrREZTNmhjeXBxSjRNODNCYnFNa1pxOTFQNlRCTTRuWWN6cm4xN0Z5aVVo?=
 =?utf-8?B?L0JCby9nRmR3Q3U5SzNpWG5NSGc5UG01MWhjNDFHWk9sMEpPRzJYdi9jRHpw?=
 =?utf-8?B?N25SMjlwZVNKc0VRTHVaUzRKQ2R2SWsyTDl2OS82UTZOTUJuMk40em0wUEtK?=
 =?utf-8?B?NU0yU1JlRFd5U2crZm1yTkRXSmhaRHFuVEc5VXpuN0h1b3YxMWJxZGNtNnRJ?=
 =?utf-8?B?eVBrdloyZjBqcEY2elBvZG5GNThUbTZFQVlGVVJmY1Zha0dxaTZGMndWQjVF?=
 =?utf-8?B?Tzh2Ti9qT1VuL3IzcHpBSXR6bDRFUG5TM0JiRzY4V0hZVVFtNkJ1Y082Q1ZU?=
 =?utf-8?B?QjQ2YXlyVlhkN2J0QlR3bG9ORTdhLzZwMWVoMWRaenMrUlNReEtFV2RaZDF0?=
 =?utf-8?B?ZmVtQ2ZGZFBlbDdWd3JPd3R5Y0w0YXZSOVVtUjVWOWwySWZmbDgyZWp0YUth?=
 =?utf-8?B?ODVvdDI2cXh2MmNDSy9EM1dVZzEyemtqOFFwSW9VMGphMjhzRW5qaitVdDkx?=
 =?utf-8?B?d2JzQTlBa0VLSTBWeE5qR0I0aVNpaXVBWUFPeDVYYnNVNVlnWkREOWI1ZlZv?=
 =?utf-8?B?ZHlDaGZPdGtOQURuek5hU2I4U0pZemx1dVVPc296K3IxY1E1RURMSnJNRE9l?=
 =?utf-8?B?ZkovLzUxaWVPTk5QaDlVUzhQZUFWbXpRK1h4RzM5ZDBQcU9ZWmRjWkJSb2NJ?=
 =?utf-8?B?ZFR1bjc2MkF6RnlZaGxTcWQwVEZDTUMyZzk1NmFXZWdnYlYvYXZveVhhdExH?=
 =?utf-8?B?aGRDcWxWN2ZWL0dNWG1nVEI3RGRCTWFNQW8wa1JnUmJBR3dmQldOakl2TWtY?=
 =?utf-8?B?VWx3cGQ5dzhidUR3WUdyQ3RBUk9SYm50UFBnaldpaU9ZU2ZkTU1aSVhhS3k0?=
 =?utf-8?B?S2pZMFJNVHBreEgwMWh5ZFdLTlVYMXZld3pvSG1wd1RFMzkzaXlKdDBFOHZU?=
 =?utf-8?B?SHh3Q3RzTithT0FQb2tRMWtMZnlVRFhoOWlkSFI4elUvNFF0Tm84RGZwSzhy?=
 =?utf-8?B?MU5Bb3JXNVV2OWNGSkhIYTFpTFM5MDdhQjU3N1lmcnhtNjJLK3BkWTFHdTNs?=
 =?utf-8?B?SnpVejZqcU1xVURnVXR6YVVVQmc4ZjdpaXI0MURlR09pUDU4RDhiYmxQQXBa?=
 =?utf-8?B?dElldkxWZm1VUUFaN2NaZEFuUjRtcjJsSEpuNC83S01tSFBteFRBYjAveGpz?=
 =?utf-8?B?UlpmMmVGVUg4L0JkQmt5Y1Q0UmIrU1NMaElQL0MxYTdOcWkvdEk0ckh4QmJV?=
 =?utf-8?B?Z3UvR2JWVGt6THVFK3NINzc5V1VGTWxRNTF0SnhSSTZNV09tdXNsbzhJcFhH?=
 =?utf-8?B?WXVHZ0h5dGZnZ3VteFVyWTZrcUNSSVBSQkw4QkNPRVh0WVpRQmJmSzh4MFU2?=
 =?utf-8?B?MDJjMmpZR2dmMWtNT1lhSlNscWVtVlZGUlJPR2hYRFRKUS82K0VORGFJNnlK?=
 =?utf-8?B?VURlMGtzNUpkUkpKM1VpWGtZQ2dkMG5zcHJPdWs1cEZUKzhDRmMxYXRLanl3?=
 =?utf-8?B?dHJXQXVJRVRZTmdxTE5zd3I1MjNMQkY5ek9xU0Y0RWthcFp3am1WUWFiQlN3?=
 =?utf-8?B?T1I2bHZML0w0bXVya1Nnbmp0L01qelNWTUhLUzBZZ2dDcmNsL3NzZzlZcE5C?=
 =?utf-8?B?czB3STJtL1RPS083YTNuelhtS3pJL3N3WWttQ2w2dHV0dmFXc01IWWVSWndt?=
 =?utf-8?Q?4ESO2sJ/KU3hu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhjeFEyMFJLbFBjSitTckxscXpMUVp3bmR6OW9DYVYwWTJlMkw0QXJqSlhI?=
 =?utf-8?B?N3l6cHh0Um13dkhmL3BkRjV0TEVYS2dHd3VzVE5VdHYyUFZ2OUlNY0RTOU1L?=
 =?utf-8?B?ejFlR05tMHI3eGtYeEttQjVocDMzRmx6R01sSVZrQTNjc3JNdnV0d2hNdEZY?=
 =?utf-8?B?UkVDSU9NajRJS3hhSlUxdUd1ZTNOMmhOWmJPM3ExdDh4bkkxLzJaMCtQNkVV?=
 =?utf-8?B?SWo2MW84RUliZ3cyN0R6S1FJWGUrbmFjWGpFMGREMFZ5eFJsb2dQSTA2VTdS?=
 =?utf-8?B?TE1rdUJHUVZwQWlqMzJhTllKbTlUZkI1dGtQMDZMRzF2aUlEYVlwN0RBbUFx?=
 =?utf-8?B?K29DSUZNQ3ZxSlQ1TmxuYXp2eTA2cWhPV1kxaHRCa0l1MkttNkllbjZvbS9h?=
 =?utf-8?B?WDV3U1RpTFljZnBtZ1NlNFFDZm1YTFVYOW5MdEFlZnVVdGtVK0ExMmRFc2FX?=
 =?utf-8?B?T1NxK2NVNVR5UWNMdGV3d2ZOQzI0U0RQaVk0U1hnVXVxYnUzbUZiYzJiMFJU?=
 =?utf-8?B?OXBBL2NnL0k3V1pZRVc4d1RaajhOYlJkNzVQZ1M5MlpTcm9nN1hjSmpLZGJm?=
 =?utf-8?B?QnA0YllWRjh0RXhYUFZRUWFPWWdTYkNhV21KUHVPR3NEclFhQTdqM1o1MHFt?=
 =?utf-8?B?SkZJMFdwSXZ6SWFrS0ovTzh5cFZLWEIzdTJWS1lJRVM5M2tzZG1PWHJoa3h2?=
 =?utf-8?B?eTJ4dHNhT1N5cGsyTi8ya2hvQXZmeTJRMEg4UWdRK0VVL21MK0J3aXlPa2JV?=
 =?utf-8?B?MVU3dFdDQ002cC93T1NRbDV2VUVscTFTYS8rb3MvMzhQWVRmVTM0enpMelB6?=
 =?utf-8?B?UWlmeHBYZFVQYS9wQVhkU1A3NVpua3hWWllCVVVyYVFPbHFHck92Sis5ejlC?=
 =?utf-8?B?TDlIdi9CNkZwUTNsOThJNnhqZXNOdDV1SHF0Y1N1ZHdZVEwzMElsYm1qd1Vo?=
 =?utf-8?B?UktrbjFFM2VaU2s5WjNCR3UvVGtwTnB1ME1EWjE0TEUrNFA5UFBjOXVNWUo5?=
 =?utf-8?B?MHFaNGFxeHoyNngzTStqcUIrc1pVeHBpWE5nZTR3NHJCb0Z1dDdQMEZibWRy?=
 =?utf-8?B?cXByU3hzSDQwWXM4TFE2T0MyYzdsOGZORGd3cVBUaGtkbElxM0hyYU1ERjBY?=
 =?utf-8?B?MnVQcTZxNUdBdUdzWTVBaVZVYXMxSzF6M1BFTlVkOE84U3pUbytTZHo3NmZ0?=
 =?utf-8?B?SDZCU2orTkhkcUNUZnJRU2JLZ0xVLzdaYS9yQkhvQjB2ekZQeS9seXpIRm1T?=
 =?utf-8?B?MmYyZERSbzUzSm9wNk90Q3hZdmRJZDg5Vktpc3JzT0ZmZ25NMjNqc0tadVBJ?=
 =?utf-8?B?a1J4cTU4MjlWWkgxL3Y3MG9LSUVCSVQ4cjJNZUJFQjE5bEFoNEh5a21lTVpO?=
 =?utf-8?B?b1Y5VW44YVZVNEdidVNQNDlITUxFZVVOOTFGOVZEQk42UHl3K25WaHZaeTNp?=
 =?utf-8?B?ZVNFTkRnNnFrcGlJWG4zMWJ1V2ZJd1hnZnB6Q3pOcmpEd2pSeFhFcDFHQVZH?=
 =?utf-8?B?K2FDNmVrSWVXcFFkczZNQmpIYktvN1pkcmRxODFLMDVsYXBxU2xONnpLNXJi?=
 =?utf-8?B?bTFnUm1vNnNweDcvM21BREg2SDExYmJOWjFhS3B3ZWVKSnhUU2VaVXRtVGk4?=
 =?utf-8?B?YnlJOEZvL1BhQ3JrWDdCL2NOTlVnckJ6NjJRbnp3QW5QbXNIdjlQV3N0SzA0?=
 =?utf-8?B?R0o5Ky93WjFXUVR1VlQ2QnI5Z2I4Y2RHTE83MHYyYzNlempQZlN6K0hRN2hG?=
 =?utf-8?B?TXZ2SENQdFhaTTVqUUo4TGF1SWwzK3dHY0hocEVRUFR3Rit5eWxuRTM3elpW?=
 =?utf-8?B?ZHF6OFZGbnJMdUZkRW1UZG14dTA1UnhCZFV4WjFzeThRSGZISjNSTGtrd2pQ?=
 =?utf-8?B?NHRXTlJ5RUJUNE0xOVdJN0VxUlBxWm1CSU84ZllPUFZuR1JSb09RSkwxYlA2?=
 =?utf-8?B?eWFFaFhmNnRpaHZ0U1Y3a1YvQm9xWnlESVVLWXo0QmczYzYwbzZiZVByQzdq?=
 =?utf-8?B?YjhMY0hwWW5EUDNFTzNxVTJjaG53Rzc1SlFTRFdlcTBZMEczaEl2eHY0ZjU2?=
 =?utf-8?B?YkIyNlJ1bU5oM3Y4T3VmRnNTdFhKOFV0enRicTZYMFRyYnAvWExhVTRBSSt5?=
 =?utf-8?Q?yXNmgAnL16QTZHJbLnRxjCO8e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f85c78-327d-4660-5e4f-08dd3193f172
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:29:24.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rfSW5PAj3OAM2GQFYV6OoOaaf+FpipqpHAgMUz1ZmjB37hOU7kDkx27kbRTOsV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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



On 1/10/2025 9:43 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, January 9, 2025 10:39 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>
>>
>>
>> On 1/9/2025 8:27 PM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, January 9, 2025 1:14 AM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>>>
>>>>
>>>>
>>>> On 1/9/2025 1:31 AM, Jonathan Kim wrote:
>>>>> Per queue reset should be bypassed when gpu recovery is disabled
>>>>> with module parameter.
>>>>>
>>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>> index cc66ebb7bae1..441568163e20 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
>>>> amdgpu_device *adev,
>>>>>     uint32_t low, high;
>>>>>     uint64_t queue_addr = 0;
>>>>>
>>>>> +   if (!amdgpu_gpu_recovery)
>>>>> +           return 0;
>>>>> +
>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>
>>>>> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
>> amdgpu_device
>>>> *adev,
>>>>>     uint32_t low, high, pipe_reset_data = 0;
>>>>>     uint64_t queue_addr = 0;
>>>>>
>>>>> +   if (!amdgpu_gpu_recovery)
>>>>> +           return 0;
>>>>> +
>>>>
>>>> I think the right place for this check is not inside callback, should be
>>>> from the place where the callback gets called.
>>>
>>> I don't think it really matters.  We're going to have different reset types in the future
>> that my come from different callers.
>>> It's probably easier to remember to put the bypass where the reset is actually
>> happening.
>>>
>>
>> If I want to define something like amdgpu_gpu_recovery=2 (don't do queue
>> reset but perform other resets), then it matters.
> 
> I don't get why that matters.
> This callback alone, for example, calls 2 types of resets within itself (queue then pipe).
> If you wanted partial resets between queue and pipe in this case, you'd have to branch test within the callback itself.
> GPU reset bypass checks are invisible to the KFD section of the code as well.
> 
>>
>> Since this is a callback, keeping it at the wrapper place may be more
>> maintainable rather than keeping the check for gfx10/11/12 etc.
> 
> Maybe not.  MES is preemption checks are not like MEC preemption checks at all.
> And we probably don't want to jam other future IP resets into a single caller.
> If you look at the kfd2kgd callbacks, most are pretty much copy and paste from one generation to another.
> I don't see how putting the test in the callback makes it less maintainable.
> 

My thought process was this could be put in - reset_queues_on_hws_hang
and anything similar handles MES based queue resets. What you are saying
there won't be anything like reset_queue_by_mes() for MES based resets.
Is that correct?

Thanks,
Lijo

> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>> Jon
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>
>>>
> 

