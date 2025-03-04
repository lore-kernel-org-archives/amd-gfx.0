Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F0C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 15:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C66710E20D;
	Tue,  4 Mar 2025 15:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4llxsSl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EC010E20D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 15:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQnHJjq7rf2qLTLJdgB7MqelXexINyFw1ip3TrwwPxyWYA3nfH4fH0i+rKJVv8A0KuQaFNrauqVwkTd5DvIcIfF2CM/BNg1OvUVmxDMIYfL/XnMXkXTADX/OEN/0p6OwOaAufetJF1GK0tRmGGD88D2Sfvxwb/5HtcoLmdLEZbkBFCVUGIAX/Us2srtyPQ72M4e5Se8wws/+TImTJI9d+tWc+wT40gAohfnPvMAkWWZ9B3uB9od+79eM3LI3VAOpEHih0rojN4I28SR82FkB+jkn7LAV1GNZlKbIpfYf9wQgCwcUe+q/tVUCzvcgRC3IuuCnHPDDvZIlaMDzVhkeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5fdaoOJbNsyhFBiPT5Hj4N6TkeVPOM4t1iAKhdlQ/k=;
 b=GPhI7WTGKCWCINVusuAgAH8euNX+TutyGoqmqiRVcP7Ncw1eAf604SuUr5BjpHuLMJCkoAHFL6sK8Qa3U+CVXEJ3YLAuWwXO/sanj+YFFtvbJzhMd+CCQF0BAm99pMGIHxE0n1y9Jb1CxygnJBUS3NJ/H4WkLb5MCYzl1FeelXu9n1/V9Az1MsgpJVEfeQZkauZYk5m9PeFFsfFDrCYKPyarLNt8OgirDOg3iyszShxnueDxROrctkzkMmWNvm2rpRYjYgQnbomFDZzJIc/r13yCzRvGNuxT2YHZrwryj0AAJuRPhU2A/tvcRCBuRAlq35tZ9YjLl1kU6y/n0tq42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5fdaoOJbNsyhFBiPT5Hj4N6TkeVPOM4t1iAKhdlQ/k=;
 b=L4llxsSlxcG8go2ROfJa9U/MQGBEbcUiGG07lI8OLmd6MrfPDi8SShhmTD9DBZwEzBUPINdEHZ/0NBzZOIY4ZAxggs0crJ93gElSF/Ki3z6gwhbKfRhOXXz8GRjxYs2cZtQQ39oEGB3G8X4UimwBBE4qzlopBeO6pfeJjZ+gO5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 15:00:31 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:00:31 +0000
Message-ID: <caa35da4-4280-7486-447f-f80294b248eb@amd.com>
Date: Tue, 4 Mar 2025 10:00:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250303093448.3190674-1-Emily.Deng@amd.com>
 <PH0PR12MB541759D007BBD47B23176CE58FC82@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB541759D007BBD47B23176CE58FC82@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: c445be4a-6544-4bb8-b37e-08dd5b2d4e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWxPVzFha2ZKNWRmQXNoRXpKVDFJNUVNdFIvTWNmR01qRHBScFgvdTBCZFBo?=
 =?utf-8?B?ZnV2eXZKcS9BV0Nmazk1QnBLUFVMaWdBbi82dEQ0aXNqV05DRWtyM0VnVFZk?=
 =?utf-8?B?SVMxQjhLUlM3bUovWGRndE55R3k4Szd3SHBDZXZSNUdJb1NsQmlMcWtmelRS?=
 =?utf-8?B?OGhJdGk3c2E0Tkx6R1lkZU9nUlhDK2t3MWhCbXlCZHcyRWRESDE3WXBHbjVv?=
 =?utf-8?B?RHhJcWdFTUtKa0FxbjhIVDNtYUFZMEJPclByY2VPOHI3NUk4S0EyT0piWTFT?=
 =?utf-8?B?U3IzZndDOTA3WjY1cnp1TVZBWXFIZUt6TGZ0S3ZrVWFqTkZkUlQ0S29aeGpV?=
 =?utf-8?B?akpFTFdXZnpqWnJPLzN4RjhjcEk1alBZVXJmck9SQlhKeGRUS2g4Q3AzdTdL?=
 =?utf-8?B?UGc0Q0FFSTdMZmFLWTZIN0xMWUwyVFlWaG5KN1FHL1ZEbnE1UUFIWjFYMHhG?=
 =?utf-8?B?WFVJNVlhcTVaN1FZRVFwSFlSQ1JtUFI3Q3kyMml1VFVpOWdzWGNFaWdMMFhz?=
 =?utf-8?B?UnEvWnYyZFNIRFQ0L2hTS3Y2ZTVPS3hNcEJYc3N2RlZtQm9HUnh1Q2J1N1p2?=
 =?utf-8?B?VlN0elY3bVhZRE1pckFDamxZSGFJTEJUTzdDcXY0a0xGUHZoTmNNNzdab3RT?=
 =?utf-8?B?R0lTeGZYKzZyTW9PZk43VW0rWWtEeWRyOUNWVlRQN3F2WWIvZXRYZ2x5U2gy?=
 =?utf-8?B?U2xnT1RzZWZscmdIRjkyUDliYmZBRXZWenpKNUlmUjFYZjBBR09sMEJQVFBn?=
 =?utf-8?B?di9wNUkwNWVRKzA1NnF6ZTNKVlB0dkRTU0ZHZ0dDT0FNM0hZRDVSVFJmMXZE?=
 =?utf-8?B?bUdNTWJoYkgyYXZWamh5S1dNM0V0ekFXZEZ2aFFZSTFGNE9GUnVENXBUSDE0?=
 =?utf-8?B?U3NyZjNVS2RVMUNOSlZjUkNibW4yZDJDZVhpQXFmdUtBQ3NxbzdHeElNeG1L?=
 =?utf-8?B?WExJTWF1ZTJuT0NQQyt5NlJLUkMwcHh0MWo4RFVJdEdnVlAzWFF1dExPQ0gw?=
 =?utf-8?B?UG5FQWN4aE8xYjJWZmVRQ1VWNWRkc1JmcGlDZ3VreW9YYXNIV3dwOC9HVEZD?=
 =?utf-8?B?ODVrWXliNUVjelV6TW02OTlvK1VmNjVzendBaEE3a1R4NjM5Rzl2dTJTcFlm?=
 =?utf-8?B?TFBhRWJEdEVneHUxQVNOYTZBWWtpUUNGU09vMVUvbXFMTXpRMTZwajNpY0lQ?=
 =?utf-8?B?dnNyWWhsSHNLOGQ4YWxyMVc2RUE3V01zc0cxSllKM0FmcjNUYWorU2gwczFm?=
 =?utf-8?B?VDFzNmRIMVk2Z0E1T0k3cjZhRE4zcnllZG5IZHlnU09ER2Q4VGlxYnFmdFd6?=
 =?utf-8?B?cUhSa1BKc0kwMWU5TUtUNTFPSGNGNUhvZlcybzJ0RnpIV0FiOW1VM2Q4YmZG?=
 =?utf-8?B?U0ErZnJKdUI4emhWZFVydXRYMVUwblFpU3JZaXhRZmxNRlNZZWFSZkVrODFG?=
 =?utf-8?B?U1lUN1U1eFFOWGRqbUVaOEkwWXJmcE0vbmdMTEx2am1qQ3UwNXVMOTRsOGZj?=
 =?utf-8?B?R2FZcWt0UmY2MW5zZlFocFJ5MHJ6MzR3MC9ZNnhTcmwxeU9sakl0M3R3ZlVs?=
 =?utf-8?B?by83MjZFYnhYRzA5V2MvbXg5ZkFZZ1JpSjhCMExwcEdlNDhQalU5b1V2SDhZ?=
 =?utf-8?B?YTlicTBzWmUvUlppRjFhQ282T3NvYmFVS28rS0hLYXFjZFh0YUEyVHdkYlVZ?=
 =?utf-8?B?S2lvL0J3d0xrRDhhcUVVdWpUdmJSdDVXS2VkQXptcmZvbnBUbFZSZXFtcU1z?=
 =?utf-8?B?eXo3UXV0VHV4TlZIQTdYYWdTb1RsVjJZRmtnWFdPazBEOVJ1RlJkUjlobHo1?=
 =?utf-8?B?UDFrMWg1Tnlad1dHSGl1ZUppNWRRL0tHaFdnN1JXclEvWXNxYWNPVWpQVWtN?=
 =?utf-8?Q?Yq0gE15FdeCSl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1aNFloaWlYbVI3b0tNeUFjMVBhN0hibVF1MitZTUJrSUpSam13UVBFN1R4?=
 =?utf-8?B?djhxYU14WDhHamNFSWF1S3VwNTR0WVFlaEhSdHIxcmU3K2ZMNWxWNzI1RVJQ?=
 =?utf-8?B?TUtxRXRtMmloNER2bi90dXVhWTFSZ1dXVDk1ZTBybUs2RGd5Rit5ZGg4U09k?=
 =?utf-8?B?OFF6U3A5UHpRdnQrMXVVWEduYnQ4Z1ZWQUgvSWl6c2FnOWdjbFNDYXJIL3Mw?=
 =?utf-8?B?dFN0UEhSSGduR2xzZWpobjF5eFVzdFoxTE9rdlJDZ3NJV3pkaXNMZ0VCWFll?=
 =?utf-8?B?anZHdXNjaWZRc3Y3c1lQR1JTSk5OWkc0eGtJc3NWWTB5ekUvenU1UVlQaHFa?=
 =?utf-8?B?NlR6RmtQcmlJMjFaMFdOYnRsZW9QWUpXc1VPcTBJOWd2NERtakJnVExhbFQ2?=
 =?utf-8?B?a2ZyemNiNVVZeDU1Q1dyMVJXQkpPWVFCME50ZmY2Ujk0RGs1RjFMRjNGNUdC?=
 =?utf-8?B?TS8ycm0vRmhjZGpOQWx0WVM2Y3VINFpJOHNHbkR1Q0ZFVGdDZzZ6SHM3MDlR?=
 =?utf-8?B?U0hjMzBZdEVSVnNiY3JLRkxLMmVCdGQ1ZTFHMkxVdTF5N08zakFBbkI2Wlps?=
 =?utf-8?B?RHRvZDRlNUVSS09pZllSdWNVNExIMEltaWZDQXQ1anExOFlRU1BaRk1ZYi9D?=
 =?utf-8?B?SGs4NCtFR3NzNHptUTFPSGphNVlVTU9aSnVjZG1vNXJ2L1lsY0pqOVVyZGRM?=
 =?utf-8?B?TjJ5WjFiVi9CM2NBd3V4K3JFS1AydE85MklaNkxoaDl4U1hNbjVQdjJNSHFQ?=
 =?utf-8?B?cDUxZVM4OUxCMkR4Z01ONnEvNElleXhFLzVmVmpRZjFqOVZxSlQwcVYyWW9x?=
 =?utf-8?B?cFpxanY4MWVUZVJFU2pKOXhTc2VjOVkrTThsNzQ5QURtQUs1Yng4R1VodlBN?=
 =?utf-8?B?WE50blhZcllHcElkVXJZYmR2QWhIckV6RzczVDU3M1BDci9MWGloMTZtYnF4?=
 =?utf-8?B?UFYzWFhnbEh1UkhuT0lxVUx1Mm5kTUJ3cnlHWEVHcXlwbzZ0d3g3MW1kZWE1?=
 =?utf-8?B?K2JUV0xQL3NvSVR1QisyNm9DQW9JTDZaSXBBZm1Fb1dNM0tjVUxzNUFBZS9o?=
 =?utf-8?B?dlorMUtnK2tkNWFFYkQ5eVpCN2dKVDF4M0JzSWJZdm83cU54Z0VQL1E0RWpD?=
 =?utf-8?B?Nm50Z2ZVS1hEcVZvUmViU1R3RUVWYk80SHkxRDd2TVU2KzFxOVF4RTVZY1lS?=
 =?utf-8?B?d1lTYjdOek9BRFgrU2Nqb1RHZk9lVmFLT2tQTDVCaCtmU3cxYTZvR2lxcVZW?=
 =?utf-8?B?SzBsTEhuMUc0dUlMeCtOa2N2Z3dxZU9xNDU2U21DcithVkFKcVhzVXIwWHU2?=
 =?utf-8?B?UU1yNTNYUlhSWC96bW85amJ3VFkvay9DaWlIQTNrMHJxeDZiTmR5YWhucGNS?=
 =?utf-8?B?K01OazVXaEFOTUo2ZEhWRlNRWVBaZVRSdjBMYzIzRko0L3ovT2hybnIxbTlo?=
 =?utf-8?B?QytueVp4TEhzOUU5K0NNSUMrZXVYdlVKSDNTdkdFZUNNOStLUVhVQ2s2Snh1?=
 =?utf-8?B?NGpQbHJmU0ljMVJ3NzZpcnZoZEVLc3dpNTlveW1BQUFMY2dxQTdmQm1Ea3Y1?=
 =?utf-8?B?RnVHUDc2eTRVYitUSEp6SjJpL1ZmdTdyNGwwL1lrZEdGOXNOYjZVcCtzWW1q?=
 =?utf-8?B?Yk11ZEJrL1U3LzNSMWpvTWpDWmlBdC82OWVCSEM3N0crS3dBZEVjaE5jamlj?=
 =?utf-8?B?TFBVRG5kQzZheTZCNGJ3bHdoUWZpbXlST25SVGQ4QVlKWnJDbWNoU3NWVTJE?=
 =?utf-8?B?OXdwM0x2dXRRaExYN2MrS0hvTU1Od2JpbVBmMW9sYmkydWhCM0ZTRkpZSmhO?=
 =?utf-8?B?ajlYZFdQaUJ4OExpV1JKcjdhd2VKUFFleE0rVHZtYU9pNStjOWtIV2hEQk9n?=
 =?utf-8?B?aTFKQjdoSUpHTFVXSWxnaFAzbGtvd2F0eUlqRi9jbElBMmovbEdLQnJsMC9Q?=
 =?utf-8?B?dWs3WEZ1TFdSY1BnZklOeDM2Mkh6OUZtRUQ1RERXQTNTcktoUWQxQmlUQzNj?=
 =?utf-8?B?Y3NlcXpDaGxwcFVmaUNCMWUxYTZUNjJiQ2luY29BK0VsTGJ4V2pOSXJRZVp4?=
 =?utf-8?B?akl5Wmd1S0dQWjVBelZvMlFJMGpPaXNWUEgrWW8zTlVIRDFDbXRrQ0FYaTdo?=
 =?utf-8?Q?xXJM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445be4a-6544-4bb8-b37e-08dd5b2d4e93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:00:30.8213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWPf/9k7OJ79wxQwbyOAJCtn3i9kEhfIC3M12dAnAUTGGx7ATGOVoR6cC+ct6US3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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


On 2025-03-03 19:44, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping......
>
> Emily Deng
> Best Wishes
>
>
>
>> -----Original Message-----
>> From: Emily Deng <Emily.Deng@amd.com>
>> Sent: Monday, March 3, 2025 5:35 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
>>
>> For equal case, it also need to be dropped.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> index 7d4395a5d8ac..73b8bcb54734 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> @@ -76,7 +76,7 @@ struct amdgpu_ih_ring {
>>
>> /* return true if time stamp t2 is after t1 with 48bit wrap around */  #define
>> amdgpu_ih_ts_after(t1, t2) \
>> -              (((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
>> +              (((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >= 0LL)

The comment is correct and current condition is correct too, 
svm_range_drain_retry_fault drop the retry fault with same timestamp as 
the IH checkpoint_wptr timestamp. Do you see GPU page fault with the 
stale retry fault after process exit, or what issue do you want to fix?

Regards,

Philip


>>
>> /* provided by the ih block */
>> struct amdgpu_ih_funcs {
>> --
>> 2.34.1
