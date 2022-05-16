Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B606DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 15:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F3010E151;
	Mon, 16 May 2022 15:08:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2239610E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 15:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4s8509zAX9PCGzBx/gA5kjcke0L7Fp5CvxJ+U1TE5C2ML+IPqGCAxXjWonQ63eIhdRa1ijfS+ZfJ8+393b/n4xSOrWjkE7hMVO5ltckX/PNpeHhou4MZY7kQGxz0OSgq4HUTjlHtqbeqBXuUh/kEf6M2mHC1oWiwkPznW6u7eAB4BlmFBzpknntjmWfneDnNTF75bOAKXuqU0CJmRB5CzDVu5i4SOZi+S8suRhXm90c2sLtgdjRhQHm3TRBqzgHxkHR8waeRJnnZ8yNxNLU3Lp7vsNnFK2hMd1U7EuBAwy0G/8DhzIhJ4bShAORbDERz6JE0PDzapM3aKgm7tltsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40vdGJkQbZGGhqCKbWEZ5eNDSvynL8ujtuGOnbxQ8+w=;
 b=X/Y3rJL5d/cPj8zoSE3+4cMmJ9Oc8j3nTXnsfh54TuBWE1VHeUhIPO5wpjXmmy2osPYKdMhbgKO6DKMX6z+dnjhc7sjrwJKRG1kJapvjmcZp3JjGL7qbv7sjpez3KsqJzcuMU/58zc98SfqT61kknL3UAQrgRrPxokxCZCn12lZFpPxKGgZiIpmTlk6pS3MXZDmwEASI7sIGacsZ24o8sMzR6KmRnkF5vFUanZlLJIJr66QLDp8l45aD5XJjG6oNFqNDqMUptOavvy7f4QeUAK5PXlEnahV/XVP5UmReAwoGA5JlHbOqXjFpPPEK2Bo3Xau3Ze+gq/1/3LBropgdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40vdGJkQbZGGhqCKbWEZ5eNDSvynL8ujtuGOnbxQ8+w=;
 b=jqzcldyMFfXKkTwj9o7Qn4SKAIVoIMMH56Os9yXsbgpk0YLeDb66bQ8U63D0CBSRXTXeqS5tDwwmGUfdduKVwUIeCR+5/S5hobk2zDNWtW3lJGXMzMYRy46wYWGidkRFPNvWzTSUerJZSndWxiOFRyZ6HhrZN+MXsW5BgNRAZHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Mon, 16 May 2022 15:08:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:08:33 +0000
Content-Type: multipart/alternative;
 boundary="------------F7R2p1iRxpWsCNXN3s4B0u5c"
Message-ID: <6cf84065-6341-3f96-4e09-ab71796241ec@amd.com>
Date: Mon, 16 May 2022 17:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
 <14483921-e454-1ad7-ff45-665366158504@amd.com>
 <0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com>
 <cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com>
X-ClientProxiedBy: AM6PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d010dbd2-82c9-4303-6b55-08da374df1ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB1388:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1388A8537275E4CFAAABAB2D83CF9@DM5PR12MB1388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrv5PRHeyB1mK4B8Fq/V1hPB0Bw4bwK88WCGnbDgtbgbDiqunjMRUQC/CPF1qt79tPxKIn6VZ7z3SeRs59ee3o6L6Xk969UFfVgX/e8fLCQzue1ptphSV6YpIFKxb1jH6JdzJl0K2N8zAC4QOpyQ3AHFEcfUqTpuKuZ/rsG959SsNO5L8V7RE2TswjVV6fGlL5MLswV3BjTJuqLYRGz0bJYbglDRF0NExBhuElFblskElckyvozs/Jom6HdLxrrBDVhbTBXI12J9xJN3LCvS4v7WW1mz9OMgUEDJDvSuV3HSTz0gMED8JtmrTYB7suEhWmUoHq7sG6rT10AE5/xY4Lyyd9GV740eZDrKSsTlPYZNKGwsNl4laAMppXA+UsvybvK3gGMAoI/V/xkYzehIRaYF8Kipa7ZUy4LC/0xhrsRVbqCpd47yEroPNUpnGDOsGX5ja59lVz9+fCBb3/a7OWmC/BBLYfCHBEds5fRMHrnkqROTO4CNMIV2GiabTIsZsw9CQeor39nstuQEml4SwqgXocnpqicp7RfRL18UAup858fvQpoeGA3f6INuLJMdgaJ7v8aRvuVM0wr81eTZa3frAtvwb2Wpt3SCYU51ZRbW0wJI3dz2ZYavmF048dj4f97TUpD9en6aAi5lVVS6iC8VJQaSfGrt/jhWS5CBjt3iW7VVGJCI+9yfMGssn/Gn4it4fqv6dUaRWZeUb+ZZHu2W84lcd9gXJQ2joBqM77Oc5AwQIC2jFnWu56PO8cMh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(66476007)(8676002)(2906002)(6666004)(66946007)(86362001)(5660300002)(31696002)(31686004)(8936002)(508600001)(6486002)(33964004)(186003)(53546011)(83380400001)(316002)(36756003)(6512007)(2616005)(6506007)(66556008)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVEdzkyUlVPMmwxK2g2ZXArOVF0b2ZJYnRGTFBBSzlRTFg0Y0FRUFgzK3pK?=
 =?utf-8?B?SUxkbDRYYzBnOW01M0RmaS9ZS1I1Z0Z1cmJCSUJzU2V4cWYvVUJKck5LM25J?=
 =?utf-8?B?WUtMYTd3RndXVW5ZMFlTVTczWGtCVklaOTUzSFJqejlXbG4zcXVaMWVQWFVv?=
 =?utf-8?B?V3l2TUI4ekl3aW5YbWVrVEdFS0tPNXRDS3pqajA1VDNVeGhMeUQ5SjdKemY1?=
 =?utf-8?B?UGE1Y3JnUWtEYkJ1M3JxVWIya2R5SUVMejRjZFhYWFRsRktkeFJpY0N5L1BE?=
 =?utf-8?B?YTFPVDJMNUYrVERCM0draEZ3RlE5OHRNbEdSWWFua1M4Skk5cWQ0azl6SE5h?=
 =?utf-8?B?UCs1OXZOK3lWa0txeUdEOTBEeWlJNTQwSGRjVTRHMGF5WEljdkw2N0RsVnRQ?=
 =?utf-8?B?SDN0OWZwSFNLb2lYam10Ujk4bjFtcXl0d2pOMVVpN2p3RmUwVGRLOEUwbit2?=
 =?utf-8?B?T0xWZTdTMUFCZnJBVFVIUHFvSkExQWdnVGRLTVJaWGFxc09YTjgzbTdDQ3ZV?=
 =?utf-8?B?OFArSXBtNDFvRHZaaVJmQkxTRFM0L0JoZ1pEd0xQaXFtVDdseXB3NEZOcW5D?=
 =?utf-8?B?ZFpKSEV6MnlESFIwclhCOUNWYWkxcnB4d0t3aXlXN2sweGxHYnAzZS9BRFBE?=
 =?utf-8?B?bTFTR2ZHRnhkMDg3N2NIZC8zVUVuNDJDcHg5OGJjQ1NBcUowMUdZUHBMZnNY?=
 =?utf-8?B?amx5TFRreXZEZ1VWeHFrbmIrYkFWbVlxWm9PeFozRWw0a1gxSVZkSzc4QjZC?=
 =?utf-8?B?UWlXWG1saU1BOWhsZ3FHT2xBN0ZTNnFhbXVkeGh2REl2alBzTUVQaWRQZkFs?=
 =?utf-8?B?S0RNYjVvSTN2VHdvRW9hNWZYbHZQbDhoZVpSN0hiWTVFeUtudHlxUUUzMXo5?=
 =?utf-8?B?RjFzQ0M0Rk1TT2FDd3dRcVJmU0d5cUVSNUpZeVgwY2doazZPUS95QlZhWTNW?=
 =?utf-8?B?VDY3dFV0Z3hEYlByU2xCU0t3cHFnVFpRcmwvTlJGMFBjUFUwR0lQci9LaVAz?=
 =?utf-8?B?R0ZwRDZhN3hBNmpmeFhpK0p0eWlSUDlLelZyZGlPQlpBak9yVkRqTDdmZ1dR?=
 =?utf-8?B?VTk2bzBRZ3J1RkZHcnAzZ0NxNjBXZ1hoQldWZWl5Z0IzUmw5N2lxQzlwWFM2?=
 =?utf-8?B?V3dnMndUd0Nab0VoSlJUMnNjM1VHTlUyMXZVaGZlL3RWSFJRSXdpY29leUdG?=
 =?utf-8?B?L0VUZlhGMlRkMzBJcUVYeHhRcGxhK3RvSTV4VGhjRUxXQnVxbXYxZEJ3N3lS?=
 =?utf-8?B?UGp6RWRVbVZYeWd4ZEdXem5JU2RsVXRYNGdVejhMYStuVGNwdXRVcDJwM1Nu?=
 =?utf-8?B?ZGhDaHVzb0FPWmRNUmU5cG0vYnVibUQ1V2xGSCtEZEx0TjlQVFJYd05kS1Jl?=
 =?utf-8?B?ajVIQS9zUngzdzdBZWRwVUNxV2VHcUtUK1VSY1ovODZFV0U5THNmT1NqKzB4?=
 =?utf-8?B?Y0dhRWllK2E4cjBHcTRkdGxJYlhEOVE1emhETWIycHVvaUFrZlVMZUkzWGJw?=
 =?utf-8?B?cGZHSWFWU3I3bUMxdnZDUSs5cllXcHdoTnhYS0VqYzZuUURzME1SVXhiVmNI?=
 =?utf-8?B?SzJCR1RmZ1JiVVdYRzVkMU9nb1hYRVFlbnBJckJKYkRyczh3QmU0UFRCZzFj?=
 =?utf-8?B?UGdYdXd0aTlRdHAxeDdoNTQzSFJtRFhTN25meGFkaGEzTngzWUxYREdUMCtX?=
 =?utf-8?B?SGNTbmcvT08zeHhSUTNaU0hpU3pERkVPb05XZDIvVzRIRWlUdkJZM2VKNjkz?=
 =?utf-8?B?Mm5iNjNyM2pScVlURG5HSUxCSFNOcVlNNGh1RHJWKzFQRGlmUktjd1NkQTNz?=
 =?utf-8?B?YWRNa2YyNDRXQ2I4VFVnRHZFL3k1Q1U0RitGaFhPcDVDY3FsdnNEdlJLZjkx?=
 =?utf-8?B?OUMwWnIrQ0wvWWZNL09IeDlweHQvZjlVUTh5UG9FVHBsNkNaSjRGN2dzNm50?=
 =?utf-8?B?NjRReTVUaC9WMFBrQjFvNHFFalA3MUdoZEZXSFE5L3dkeUs1SWRsaGVwMWNu?=
 =?utf-8?B?YUtFTUZwYkpEN3IxN3gvVDIxQWtja3FNUWt5cThWTXR2VExsMHl1SnVGZVRT?=
 =?utf-8?B?aDdrUDEyZnlaZkxBN0R0V3A4eHd4OUV2Z1pUN1VWQ1dyeTVBOEpBWHVVRWdW?=
 =?utf-8?B?QlVxc0JYbGZnaTNOSFJxMkRqY095YnRoUnBaVUt3cHppdWtFME9zdldTRGRN?=
 =?utf-8?B?YzBqVWZnOENFeDlwRERGVXVpVVdXd0MyWXpoVkhnUjhqWlZOczVSc0piWjE5?=
 =?utf-8?B?dFZ4WDhJMTRXUHpGbjlQeXNBY09VVGZ4UFd4Y0xmY1pCa1YzOVRaK0lMSDhX?=
 =?utf-8?B?MHZER014MUhORWV5ZFR0RGU3VzI0UU9tbzVNMjUxQjhFbWI0eDhaS3NUekY5?=
 =?utf-8?Q?H1jKbtXAmNn7OVTNQ6+802A5cW+CjRFZBWxKIHEWkVHJm?=
X-MS-Exchange-AntiSpam-MessageData-1: pQ73k1jZr0cHCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d010dbd2-82c9-4303-6b55-08da374df1ad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 15:08:33.4436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiiAOFvSyia2Bymg21Z549Dy8vXygk7mVxFmAVf4b1pE+vm1OZ58Swbhe0DF9RCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------F7R2p1iRxpWsCNXN3s4B0u5c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.05.22 um 16:12 schrieb Andrey Grodzovsky:
>
> Ping
>

Ah, yes sorry.

> Andrey
>
> On 2022-05-13 11:41, Andrey Grodzovsky wrote:
>>> Yes, exactly that's the idea.
>>>
>>> Basically the reset domain knowns which amdgpu devices it needs to 
>>> reset together.
>>>
>>> If you then represent that so that you always have a hive even when 
>>> you only have one device in it, or if you put an array of devices 
>>> which needs to be reset together into the reset domain doesn't matter.
>>>
>>> Maybe go for the later approach, that is probably a bit cleaner and 
>>> less code to change.
>>>
>>> Christian.
>>
>>
>> Unfortunately this approach raises also a few  difficulties -
>> First - if holding array of devices in reset_domain then when you 
>> come to GPU reset function you don't really know which adev is the 
>> one triggered the reset and this is actually essential to some 
>> procedures like emergency restart.

What is "emergency restart"? That's not some requirement I know about.

>>
>> Second - in XGMI case we must take into account that one of the hive 
>> members might go away in runtime (i could do echo 1 > 
>> /sysfs/pci_id/remove on it for example at any moment) - so now we 
>> need to maintain this array and mark such entry with NULL probably on 
>> XGMI node removal , and then there might be hot insertion and all 
>> this adds more complications.
>>
>> I now tend to prefer your initial solution for it's simplicity and 
>> the result will be what we need -
>>
>> "E.g. in the reset code (either before or after the reset, that's 
>> debatable) you do something like this:
>>
>> for (i = 0; i < num_ring; ++i)
>> cancel_delayed_work(ring[i]->scheduler....)
>> cancel_work(adev->ras_work);
>> cancel_work(adev->iofault_work);
>> cancel_work(adev->debugfs_work);
>> "

Works for me. I already expected that switching over the reset to be 
based on the reset context wouldn't be that easy.

Regards,
Christian.

>>
>> Let me know what you think.
>>
>> Andrey 

--------------F7R2p1iRxpWsCNXN3s4B0u5c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 16.05.22 um 16:12 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
      
      <p>Ping <br>
      </p>
    </blockquote>
    <br>
    Ah, yes sorry.<br>
    <br>
    <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
      <p> </p>
      <p>Andrey<br>
      </p>
      <div class="moz-cite-prefix">On 2022-05-13 11:41, Andrey
        Grodzovsky wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com">
        <blockquote type="cite" style="color: #007cff;">Yes, exactly
          that's the idea. <br>
          <br>
          Basically the reset domain knowns which amdgpu devices it
          needs to reset together. <br>
          <br>
          If you then represent that so that you always have a hive even
          when you only have one device in it, or if you put an array of
          devices which needs to be reset together into the reset domain
          doesn't matter. <br>
          <br>
          Maybe go for the later approach, that is probably a bit
          cleaner and less code to change. <br>
          <br>
          Christian. <br>
        </blockquote>
        <br>
        <br>
        Unfortunately this approach raises also a few&nbsp; difficulties - <br>
        First - if holding array of devices in reset_domain then when
        you come to GPU reset function you don't really know which adev
        is the one triggered the reset and this is actually essential to
        some procedures like emergency restart. <br>
      </blockquote>
    </blockquote>
    <br>
    What is &quot;emergency restart&quot;? That's not some requirement I know
    about.<br>
    <br>
    <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
      <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com"> <br>
        Second - in XGMI case we must take into account that one of the
        hive members might go away in runtime (i could do echo 1 &gt;
        /sysfs/pci_id/remove on it for example at any moment) - so now
        we need to maintain this array and mark such entry with NULL
        probably on XGMI node removal , and then there might be hot
        insertion and all this adds more complications. <br>
        <br>
        I now tend to prefer your initial solution for it's simplicity
        and the result will be what we need - <br>
        <br>
        &quot;E.g. in the reset code (either before or after the reset,
        that's debatable) you do something like this: <br>
        <br>
        for (i = 0; i &lt; num_ring; ++i) <br>
        cancel_delayed_work(ring[i]-&gt;scheduler....) <br>
        cancel_work(adev-&gt;ras_work); <br>
        cancel_work(adev-&gt;iofault_work); <br>
        cancel_work(adev-&gt;debugfs_work); <br>
        &quot; <br>
      </blockquote>
    </blockquote>
    <br>
    Works for me. I already expected that switching over the reset to be
    based on the reset context wouldn't be that easy.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
      <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com"> <br>
        Let me know what you think. <br>
        <br>
        Andrey </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------F7R2p1iRxpWsCNXN3s4B0u5c--
