Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F3606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ioA42j2n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D13810E21B;
	Wed, 28 Oct 2026 19:37:08 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF0910E5C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 19:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBtqkN1PqEFgDUiKdfREJXhy/Uuy6zEmQ9DQJab+Va2ykSf2hL6jTIFdOZ/tBT3Yr64yB2mRWSUkzMeaHvdICb3Nm0XQXXJgo2T5GIDbrJjljdd1+d1j6/9YsGfFSqm2kJQL7HRV8h9Hwz4A+aN60q9rIsG6ziaUIi8C8lpOawA/bZYv8kzWxQLa7CIEsZzhQsKk0KhO2BUHsi3TqmlWYu1D/tDr2HE+eblqQTYyf8CKm9cNDokBeGe4ahQLsw3+RRnbaA5udih5kY/mU1unGCQtU/ybFpsTUaJaSOBgRPCi83bBujrcFWAOWlPq5LlihEwJTrUnEp5mpCKUzEb1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT0ReP6g8+bagDELsyRH5AIftmuV/IvK7MlNCheKZIc=;
 b=Ut3NGc8k53bLL8PUd+vc1iXltFwXIDZnR4b+F504wmG0znn2b3fkzfkOLuD6/Lh4wvZ+BaO7HDurSNt7VtdMiaRVo17g87pQUqJ/QIHRpjeU1AKhs9WA+YvF/4YFR0OrlxDubfTkBuhe2q6+wtb9ztaGGZOanhtIqZwNvhdB7YE1xSwqMg+BE8JIMiOfu3OpnZhBKiTyLwGPzOzASf+0wZzigBDX+Om7ZymQrRq0VFofn6sm9MmwR6Jg5IIGcfEkl+edWhLquYTS5itXaz35S0bBORqxKVcz8Ooj5YbXA7HtW0eET/1qJXjotLGUF51nRP7zWATanog3QEBVc1zGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT0ReP6g8+bagDELsyRH5AIftmuV/IvK7MlNCheKZIc=;
 b=ioA42j2nt0l23jm6lManzp47H4XjOcu1oLLQf0HTjLvWmpMP7RGoA+mmzooi7Xni2CA8X6jyncBZnesKMpxDp6tsMh2FZseB+oDdrMSox/zIKgnD+50a+Vdz5x1ow41mM5dqCYHHrzbis/cMTVt1bj7TpUaAQl6wQiY2UtHu+CM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:36:54 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 19:36:54 +0000
Content-Type: multipart/alternative;
 boundary="------------ofTDo0iQkM3Kg7Ok2aw0Ai7a"
Message-ID: <e0535f78-43ca-4d44-a93b-405de825ba65@amd.com>
Date: Wed, 28 Oct 2026 15:36:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: UALink add debugfs selftest
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Mukul.Joshi@amd.com
References: <20261023203447.2075707-1-Philip.Yang@amd.com>
 <abbf170b-628b-455f-94b1-91e3ce540863@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <abbf170b-628b-455f-94b1-91e3ce540863@amd.com>
X-ClientProxiedBy: YT4PR01CA0336.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 523971de-601a-4289-3654-08df352ad1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261028144727099003|261022115727099003|261026121527099003|261026135527099003|261026140227099003|261021123027099003|261026130827099003|261021121427099003|261022113327099003|261022075727099003|261021133027099003|261022105027099003|261021130227099003|261021135927099003|8096899003|3023799007|6133799003|10067099003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VvlP3QgE4WNbXJ6RamnmjyvMVXKsu3k0UdMeziYh7/F5bY60J/lCMwSxVELLygrc9usMp/Hvs370od8P29mnqi761QGH3CqFXbTKEs5wwgni5zWwCj/4+nDRW/bc2C1gbDAcdmiv9J/nh/1/3UsbMx/QGRS1tqpOT82SIf9FFpJzkJGXHaeZChjKzyIuvrNrWKmFHtpfnv/7SX5A0et/9yzNSYYWKbYjhVJxYpDMS3miuKgoUvYrJvNoMATfTOZMLyAsNN/UkxztfXu11Pa8WJibe2xY5KGWjih0yOpuH+Tav/yf+7qpY8NuNR8ffZUqGniTOYNbfdjgQTjzjaAiJ48aZMcC76xSPHZTFFChCbqiHtv73uE82r63n1NoFNHWWiKgsNKwOFNZcy56LOt1s/3OQpYAhpqjY9Zcmp/g2IY3NxC3sNwZQL1QdacwKk49wYBA/++PauWolFtg7P6KXzOT3vziejSdNs7mC7BMT2XEU6YyOL6ABcbidmDetDG64TAoAWzjBHDVieqeSk3R/8lSe9exJSy/GIhoKNljnIGCAgu3ZUrfT6Y9Fm+GIbkrqU3Tatk44OYImR/7z31f80yTWrvvQnGqDeTD7V7jPEwGHyNcvI4qeSZD97/sFpA0ec5noThqkybIrfec5imwELT3wLdyocTDnJy5QkBKRCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261028144727099003)(261022115727099003)(261026121527099003)(261026135527099003)(261026140227099003)(261021123027099003)(261026130827099003)(261021121427099003)(261022113327099003)(261022075727099003)(261021133027099003)(261022105027099003)(261021130227099003)(261021135927099003)(8096899003)(3023799007)(6133799003)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzllNW4zb1U0d2Nrb1ozaUZSSjZMT2hWaURGZFJoYjlselZVM1FBZ2c0cGk2?=
 =?utf-8?B?NVdrcysxYzMrSjNjTUhEbEc2eVRPeEk5YS94YzhlUm5odW9PWmlqTVc1Y2FB?=
 =?utf-8?B?TUNIbDl2SGlRRWkwa3dIMy9iSVh5OWwzZVd1Qnc4WW1VaTFQeG9lZUcvaFFZ?=
 =?utf-8?B?TUloSU5lUitCTzJTcVNhVFJ2aW9vS29TTkF3bmxzSHJsZGhXbWtFQkphSjRY?=
 =?utf-8?B?TndnSWRKQk9saTNlbC85eUFHK2N6TmFDTWJySGpDREp2VERvbytvOW1rOVo5?=
 =?utf-8?B?b0NneVE2ejBWRWZ0ZFBYd1ZpZi9aWC9BUjNPcGxPaWVId2MwYVNwcVhIVzZM?=
 =?utf-8?B?OFU0VWVYK1lLTWErODZ4YzZnZTgyMFgwamVycVJPakg4UnQrb3kwcTkvQ1ow?=
 =?utf-8?B?OGE5RVJYUy9kejVWbEsySDdwR0g3TVVyUW5jVGNZYUx6LzE3YThLV0VHQzU4?=
 =?utf-8?B?N3dINlFQWjdCWE40V2xBZUY2QlJiWmRhU3Q5RTlKS2EybFA2a2xRNWlMWFRx?=
 =?utf-8?B?cllKSCtFVTFKcVg5SWJIWDRxa0NZd01tQklWV2l4cVIzRm5DdmpmY1Y4Rkc2?=
 =?utf-8?B?OHZLakZ3cE5MKzRsYlJ2TllqR2p2SUdFMlF3WVJNWG00Tk5maXFQWVRlUUFX?=
 =?utf-8?B?anVNUG91WWpkUzRibzdUTUMxY2pBbzROTGJ1RTZhQ2NLQ2V2RnBhVS84Y3A5?=
 =?utf-8?B?M01uektDazBiZmdKQW1GRStyb3JHeHZqaFhWSEcvMU9KZDhiQ1p6SG82YVpY?=
 =?utf-8?B?VXAvalh0UmlpMHQwRG1qT0VvUnY3Q3NEYkFGVkNqcHNvZDNKUFBtMG1lK1ZS?=
 =?utf-8?B?OU0yamorSEpKSGVyQXo4TW90anBuWHh2d3VzM3NVck41eXNLTERScmUxSzVZ?=
 =?utf-8?B?UUtaMnljUmE2ckp0UGU4S2FaOGtCblEvRytCSnFKVkJFbnRMRC9sYS83R0Jr?=
 =?utf-8?B?VG5BMkZzQUJOenJjSmlWUHhuSHhqUDhZbWhwT3Fxdkt6WXQzbmVzQk1iR0xD?=
 =?utf-8?B?YlIzblJaQ3FpU2QwOEZBRHo2UmEvN2pNMkMxSS8wVTc4aC93OVBqRUVHWEtJ?=
 =?utf-8?B?VmNFcnRabG9VVFEwMjAyVHdrV2NlM0ljR0lJTW56TE9ycCtKN1g0aXB5ME1a?=
 =?utf-8?B?bk53S0Z5NXJZVFV4eTJPWWoxMlZ6Q0VQaWY2U0dEQnR1MEJqL0QxaGZHWWZ4?=
 =?utf-8?B?VGtCU3FGL2xOQzlQZmpPVHJ4c3Z0YlI2dDJkUG1yelRCcWJJRkhET1hNSzAz?=
 =?utf-8?B?RldRZEhrallHN21tM2h6V05UejJsajRjQmh5R2FpdVdqb0hRWU1WNUpNb1NS?=
 =?utf-8?B?a3ZDYmhiVmxvdFJBTzIrNTQxNXJXbFlhMk9MUzVYcTFZdmpjc3hoYy9QKzND?=
 =?utf-8?B?RnVLUWsxZ2ZCeFBmbVZESk9uNTh1dzBwdTA1aDZ4eFlndkFpMEtxeW9PUGJY?=
 =?utf-8?B?QVpjV2hiSVdDMVlEMzJXNUFGVkNLa0VjdVR5UFQ0Vmw4SVJlemo1S3RKNUNa?=
 =?utf-8?B?TitWZU1hMWgvN2F5d1paSEpRNVltWkZTSUIvWlZ1OC9STVZLbjdWNmhhMkxt?=
 =?utf-8?B?Um5hSFprampGTWMyMVc5elovQmFtclJMNWxSNzMrNjZEaWxESHBkNUxadEhT?=
 =?utf-8?B?YmloT3h1UFR3QkRhMXBIcEc2b0VVRzQwd0lVeHJWUnhmSFlKcEdWRkk4NDRP?=
 =?utf-8?B?RDVETmN1TmdRUkw3c2JmaHhycmJaVjk0d05ISys3Tzd4NkJpQlR3cmFBOTV1?=
 =?utf-8?B?eUUvRldmKzdpbHRiQWwxYlJjMVhseng2THZ1TXVKNUdvWjJLYkJXbGY2NjQ2?=
 =?utf-8?B?MWMrR0VYaW1KckpsRkdIRGZSaWw2L1RucmhkcEtteFp5VElvZ2NOblhubW1W?=
 =?utf-8?B?U2RFZy9UbTh4YzRZTDgyNkJKOFdUOVlrbGw3OTFsOHFtRDRRS0xuM3h0RWpI?=
 =?utf-8?B?TGdqV3NHdUxjcnZEdVNMa0RoUjJGVEJjSG1oUXRhaEQ4aXhuQ2xIdy9pZkRw?=
 =?utf-8?B?eDY4enFXdVBrQTg4aEU3TjdCalpiRkhGNVd1UGszWHQ2MGpvYkMxQUNFUmRv?=
 =?utf-8?B?cSt5S1RsVmpTL2dCK0d4RzhibTNqSzFwOW5ya3pIbFUxMWNWVmVKWHIvdW5m?=
 =?utf-8?B?dVpQSnQxeklrL2llU2dXdTJSUW82SUsycERTSkFlZ3puaFRmU01SUEdZdko2?=
 =?utf-8?B?QlVGTnErYjI4VEpNUGhzcXV0TXNNUjBNeEhhdTVVNFErdDZUTnI3cmNBS1Fk?=
 =?utf-8?B?SHB6Nk1CelpnblEvNUtLbFgxUkVKRkZWNkRXVzhKNDY0Qm0zekNreC9tS2hH?=
 =?utf-8?Q?qus4eeBH8ZmyhDJZsD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523971de-601a-4289-3654-08df352ad1f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:36:53.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1tc4ZuOplXPbWHk/riQND8un2p4GJTwtYfy7r2A/cMlW2o2F34strRau61Gxv16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------ofTDo0iQkM3Kg7Ok2aw0Ai7a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-28 14:24, Kuehling, Felix wrote:
> On 2026-10-23 16:34, Philip Yang wrote:
>> Driver-side selftests for UALink bring-up: exercise the nHT firmware,
>> remote interrupts, remote TLB shootdown and remote VRAM access without
>> any userspace application.
>>
>> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
>> with these read/write entries:
>>
>>    command          write the test name to run it, read to list the
>>                     valid test names
>>    remote_accel_id  accel_id of the remote GPU used by the tests
>>    test_size        test buffer size in bytes, from 4 to 4096
>>    local_test_data  the local ring buffer the remote GPU accesses
>>    remote_sdma      the remote GPU ring buffer, using sdma
>>    remote_lsdma     the remote GPU ring buffer, using lsdma
>>
>> The data entries take and return binary data, a write shorter than
>> test_size is repeated to fill it, so formatting is left to userspace
>> tools like printf, xxd, od and cmp.
>>
>> Add helper functions: ualink_test_local_data() and
>> ualink_test_remote_rw() for local and remote ring buffer R/W,
>> ualink_test_remote_shootdown() for TLB shootdown,
>> ualink_test_send_hello() for handshake,
>> ualink_test_update_interrupt_wb() and
>> ualink_test_update_shootdown_wb() to read writeback results.
>>
>> v6: ring buffer wptr for itself is used for wptr, don't init to 
>> 0xdeadbeef
>
> I don't see this change. What exactly did you change? I only see the 
> removal of deadbeef init. I don't see any change regarding which ring 
> buffer is used to stage the data for remote read/write.
The remote ring buffer was initialised to 0xdeadbeef for the selftest. 
In address-aliasing mode the wptr for every remote uses that same ring 
buffer page for itself accel_id, so the remote wptr resync read back 
0xdeadbeef and synced the wptr to that value, which left the remote 
firmware in a bad state. I have removed the ring buffer initialisation. 
ualink_test_resync_peer() also change to only resync wptr for the first 
command or if peer rebooted.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>> v5: Replace the four remote access commands with local_test_data,
>>      remote_sdma and remote_lsdma entries, to get the test data without
>>      looking at debug logs or using xxd with physical addresses (Felix).
>>      Dump and accept binary data, no parser in the driver (Felix).
>>      Stage the DMA in the local ring buffer instead of the IB, which is
>>      freed before the data is read back.
>> v4: Use a single "command" entry taking the test name, instead of one
>>      entry per test (Felix).
>>      Resync the remote wptr before sending a command, the peer may have
>>      rebooted.
>> v3: Replace the single entry taking a test number with a debugfs
>>      directory and a named entry per command.
>>      Take peer->lock to update the writeback address and selftest_mutex
>>      to read the test parameters.
>> v2: Fix typos and issues from copilot code review.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 219 ++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  24 +-
>>   5 files changed, 628 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 3dc95d9accf2..2d786639d081 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -2133,9 +2133,336 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +enum amdgpu_ualink_test_cmd {
>> +    UALINK_TEST_SW_INIT,
>> +    UALINK_TEST_SEND_HELLO,
>> +    UALINK_TEST_REMOTE_SHOOTDOWN,
>> +    UALINK_TEST_FLUSH_TLB,
>> +    UALINK_TEST_UPDATE_INTERRUPT_WB,
>> +    UALINK_TEST_UPDATE_SHOOTDOWN_WB,
>> +    UALINK_TEST_LSDMA_SELFTEST,
>> +};
>> +
>> +/* commands talking to a remote accelerator, remote_accel_id must be 
>> set */
>> +#define UALINK_TEST_NEEDS_ACCEL_ID                    \
>> +    (BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) 
>> | \
>> +     BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |                \
>> +     BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
>> +
>> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
>> +                      enum amdgpu_ualink_test_cmd cmd)
>> +{
>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>> +    int r = 0;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
>> +        remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    adev->ualink.selftesting = true;
>> +
>> +    switch (cmd) {
>> +    case UALINK_TEST_SW_INIT:
>> +        if (adev->ualink.remote)
>> +            amdgpu_ualink_sw_fini(adev);
>> +
>> +        dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
>> +        r = amdgpu_ualink_sw_init(adev);
>> +        break;
>> +    case UALINK_TEST_SEND_HELLO:
>> +        r = ualink_test_send_hello(adev, remote_accel_id);
>> +        break;
>> +    case UALINK_TEST_REMOTE_SHOOTDOWN:
>> +        r = ualink_test_remote_shootdown(adev, remote_accel_id, 1UL 
>> << 30,
>> +                         1, TLB_FLUSH_HEAVYWEIGHT);
>> +        break;
>> +    case UALINK_TEST_FLUSH_TLB:
>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>> +        break;
>> +    case UALINK_TEST_UPDATE_INTERRUPT_WB:
>> +        r = ualink_test_update_interrupt_wb(adev, remote_accel_id);
>> +        break;
>> +    case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
>> +        r = ualink_test_update_shootdown_wb(adev, remote_accel_id);
>> +        break;
>> +    case UALINK_TEST_LSDMA_SELFTEST:
>> +        r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : 
>> -EOPNOTSUPP;
>> +        break;
>> +    }
>> +
>> +    adev->ualink.selftesting = false;
>> +
>> +    dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret 
>> %d\n",
>> +        cmd, remote_accel_id, r);
>> +
>> +    return r;
>> +}
>> +
>> +#define UALINK_TEST_CMD_NAME_MAX    32
>> +
>> +static const char * const amdgpu_ualink_test_cmd_name[] = {
>> +    [UALINK_TEST_SW_INIT]            = "sw_init",
>> +    [UALINK_TEST_SEND_HELLO]        = "send_hello",
>> +    [UALINK_TEST_REMOTE_SHOOTDOWN]        = "remote_shootdown",
>> +    [UALINK_TEST_FLUSH_TLB]            = "flush_tlb",
>> +    [UALINK_TEST_UPDATE_INTERRUPT_WB]    = "update_interrupt_wb",
>> +    [UALINK_TEST_UPDATE_SHOOTDOWN_WB]    = "update_shootdown_wb",
>> +    [UALINK_TEST_LSDMA_SELFTEST]        = "lsdma_selftest",
>> +};
>> +
>> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
>> +                          char __user *ubuf,
>> +                          size_t len, loff_t *offp)
>> +{
>> +    char buf[UALINK_TEST_CMD_NAME_MAX * 
>> ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
>> +    unsigned int i;
>> +    int n = 0;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
>> +        n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
>> +                   amdgpu_ualink_test_cmd_name[i]);
>> +
>> +    return simple_read_from_buffer(ubuf, len, offp, buf, n);
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
>> +                           const char __user *ubuf,
>> +                           size_t len, loff_t *offp)
>> +{
>> +    struct amdgpu_device *adev = file->private_data;
>> +    char buf[UALINK_TEST_CMD_NAME_MAX];
>> +    int cmd, r;
>> +
>> +    if (len >= sizeof(buf))
>> +        return -EINVAL;
>> +
>> +    if (copy_from_user(buf, ubuf, len))
>> +        return -EFAULT;
>> +
>> +    buf[len] = '\0';
>> +    cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
>> +    if (cmd < 0) {
>> +        dev_err(adev->dev, "unknown ualink test command\n");
>> +        return cmd;
>> +    }
>> +
>> +    r = amdgpu_debugfs_ualink_test_run(adev, cmd);
>> +    if (r)
>> +        return r;
>> +
>> +    return len;
>> +}
>> +
>> +static const struct file_operations amdgpu_ualink_command_fops = {
>> +    .owner     = THIS_MODULE,
>> +    .open     = simple_open,
>> +    .read     = amdgpu_debugfs_ualink_command_read,
>> +    .write     = amdgpu_debugfs_ualink_command_write,
>> +    .llseek     = default_llseek,
>> +};
>> +
>> +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
>> +enum amdgpu_ualink_test_buf {
>> +    UALINK_BUF_LOCAL,
>> +    UALINK_BUF_REMOTE_SDMA,
>> +    UALINK_BUF_REMOTE_LSDMA,
>> +};
>> +
>> +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device *adev,
>> +                       enum amdgpu_ualink_test_buf buf,
>> +                       u32 *data, u32 size, bool read)
>> +{
>> +    u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>> +    int r;
>> +
>> +    if (remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>> +        dev_err(adev->dev, "set remote_accel_id first\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    adev->ualink.selftesting = true;
>> +
>> +    if (buf == UALINK_BUF_LOCAL)
>> +        r = ualink_test_local_data(adev, remote_accel_id, data, 
>> size, read);
>> +    else
>> +        r = ualink_test_remote_rw(adev, remote_accel_id, data, size, 
>> read,
>> +                      buf == UALINK_BUF_REMOTE_LSDMA);
>> +
>> +    adev->ualink.selftesting = false;
>> +
>> +    return r;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_ualink_data_read(struct file *file,
>> +                           char __user *ubuf, size_t len,
>> +                           loff_t *offp,
>> +                           enum amdgpu_ualink_test_buf buf)
>> +{
>> +    struct amdgpu_device *adev = file->private_data;
>> +    ssize_t ret;
>> +    u32 size;
>> +    void *data;
>> +    int r;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    size = adev->ualink.test_size_dwords * 4;
>> +
>> +    data = kmalloc(size, GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, true);
>> +    ret = r ? r : simple_read_from_buffer(ubuf, len, offp, data, size);
>> +
>> +    kfree(data);
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_ualink_data_write(struct file *file,
>> +                        const char __user *ubuf,
>> +                        size_t len, loff_t *offp,
>> +                        enum amdgpu_ualink_test_buf buf)
>> +{
>> +    struct amdgpu_device *adev = file->private_data;
>> +    u32 i, size;
>> +    void *data;
>> +    int r;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    size = adev->ualink.test_size_dwords * 4;
>> +
>> +    if (!len)
>> +        return -EINVAL;
>> +
>> +    len = min_t(size_t, len, size);
>> +
>> +    data = kmalloc(size, GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    if (copy_from_user(data, ubuf, len)) {
>> +        kfree(data);
>> +        return -EFAULT;
>> +    }
>> +
>> +    /* repeat a short pattern to fill the test size */
>> +    for (i = len; i < size; i += len)
>> +        memcpy(data + i, data, min_t(u32, len, size - i));
>> +
>> +    r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size, false);
>> +
>> +    kfree(data);
>> +
>> +    return r ? r : len;
>> +}
>> +
>> +#define UALINK_TEST_DATA_ATTR(name, buf)                \
>> +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file 
>> *file,    \
>> +        char __user *ubuf, size_t len, loff_t *offp)        \
>> +{                                    \
>> +    return amdgpu_debugfs_ualink_data_read(file, ubuf, len, offp, 
>> buf); \
>> +}                                    \
>> +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file 
>> *file,    \
>> +        const char __user *ubuf, size_t len, loff_t *offp)    \
>> +{                                    \
>> +    return amdgpu_debugfs_ualink_data_write(file, ubuf, len, offp, 
>> buf); \
>> +}                                    \
>> +static const struct file_operations amdgpu_ualink_##name##_fops = 
>> {    \
>> +    .owner     = THIS_MODULE,                        \
>> +    .open     = simple_open,                        \
>> +    .read     = amdgpu_debugfs_ualink_##name##_read, \
>> +    .write     = amdgpu_debugfs_ualink_##name##_write,        \
>> +    .llseek     = default_llseek,                    \
>> +}
>> +
>> +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
>> +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
>> +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
>> +
>> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
>> +{
>> +    struct amdgpu_device *adev = data;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    *val = adev->ualink.test_remote_accel_id;
>> +
>> +    return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
>> +{
>> +    struct amdgpu_device *adev = data;
>> +
>> +    if (!adev->ualink.info)
>> +        return -EOPNOTSUPP;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    if (val >= AMDGPU_UALINK_ACCEL_MAX ||
>> +        !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
>> +        dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (val == adev->ualink.info->ppod.accel_id) {
>> +        dev_err(adev->dev, "remote accel_id equals to local 
>> accel_id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    adev->ualink.test_remote_accel_id = val;
>> +    dev_info(adev->dev, "set remote accel_id to %llu, local accel_id 
>> %u\n",
>> +         val, adev->ualink.info->ppod.accel_id);
>> +
>> +    return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
>> +             amdgpu_debugfs_ualink_accel_id_get,
>> +             amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
>> +
>> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
>> +{
>> +    struct amdgpu_device *adev = data;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    *val = adev->ualink.test_size_dwords * 4;
>> +
>> +    return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
>> +{
>> +    struct amdgpu_device *adev = data;
>> +
>> +    if (val < 4 || val > AMDGPU_UALINK_RB_SIZE)
>> +        return -EINVAL;
>> +
>> +    guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +    adev->ualink.test_size_dwords = val / 4;
>> +    dev_dbg(adev->dev, "test buffer size %u bytes\n",
>> +        adev->ualink.test_size_dwords * 4);
>> +
>> +    return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
>> +             amdgpu_debugfs_ualink_test_size_get,
>> +             amdgpu_debugfs_ualink_test_size_set, "%llu\n");
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> +    struct dentry *ualink_test;
>>       struct dentry *ent;
>>       int r, i;
>>   @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>>                    &adev->ualink.drop_msg_bitmap);
>>   +    mutex_init(&adev->ualink.selftest_mutex);
>> +    /* 64 bytes test size by default */
>> +    adev->ualink.test_size_dwords = 16;
>> +    adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
>> +
>> +    ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
>> +    debugfs_create_file("command", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_command_fops);
>> +    debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_accel_id_fops);
>> +    debugfs_create_file("test_size", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_test_size_fops);
>> +    debugfs_create_file("local_test_data", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_local_test_data_fops);
>> +    debugfs_create_file("remote_sdma", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_remote_sdma_fops);
>> +    debugfs_create_file("remote_lsdma", 0600, ualink_test, adev,
>> +                &amdgpu_ualink_remote_lsdma_fops);
>> +
>>       adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>       debugfs_create_blob("amdgpu_vbios", 0444, root,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> index 05bc281216bf..1f83d9b69135 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
>>       mutex_unlock(&adev->lsdma.lock);
>>       return ret;
>>   }
>> +
>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_ib ib;
>> +    int i, r;
>> +    u64 gpu_addr;
>> +    char *p;
>> +    u32 size = 128;
>> +
>> +    memset(&ib, 0, sizeof(ib));
>> +    r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, 
>> &ib);
>> +    if (r)
>> +        return r;
>> +
>> +    gpu_addr = ib.gpu_addr;
>> +    p = (char *)ib.ptr;
>> +    memset(p, 0, 2 * size);
>> +
>> +    for (i = 0; i < size; i++)
>> +        *(p + i) = i;
>> +
>> +    dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
>> +        gpu_addr, gpu_addr + size, size);
>> +
>> +    r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
>> +    if (r)
>> +        goto out;
>> +
>> +    p += size;
>> +    for (i = 0; i < size; i++) {
>> +        if (*(p + i) != i) {
>> +            dev_dbg(adev->dev, "data mismatch expecting 0x%x but 
>> read 0x%x\n",
>> +                i, *(p + i));
>> +            break;
>> +        }
>> +    }
>> +    if (i != size)
>> +        r = -EIO;
>> +
>> +out:
>> +    amdgpu_ib_free(&ib, NULL);
>> +
>> +    if (r)
>> +        dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
>> +    else
>> +        dev_dbg(adev->dev, "lsdma selftest passed\n");
>> +
>> +    return r;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> index 34e92aaa4617..f0a5eeb3529f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device 
>> *adev, uint64_t dst_addr,
>>                 uint32_t data, uint64_t mem_size);
>>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t 
>> reg_index,
>>                 uint32_t reg_val, uint32_t mask);
>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 339f639a450e..86e0dc8d728e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct 
>> amdgpu_device *adev);
>>   static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>                   u32 remote_accel_id, u32 dw0, u32 dw1,
>>                   u32 dw2, u32 dw3);
>> -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
>> -                    u32 flush_type);
>>   static int amdgpu_ualink_reserve_npa_vm_and_bos(struct 
>> amdgpu_device *adev,
>>                           struct amdgpu_bo *bos[], u32 n_bos,
>>                           struct drm_exec *exec,
>> @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct 
>> amdgpu_device *adev)
>>    * UALink remote interrupt and shootdown
>>    */
>>   -/* UALINK ring buffer size, same for both remote shootdown and 
>> interrupt ring */
>> -#define AMDGPU_UALINK_RB_SIZE    4096
>> -
>>   #define AMDGPU_UALINK_METADATA_HEADER    0x4E485446
>>     /* 2MB NPA start address for 2MB page mapping */
>> @@ -4582,7 +4577,7 @@ static inline u32 ualink_tlb_wb_offset(struct 
>> amdgpu_device *adev, u32 accel_id)
>>       return ualink_wb_offset(adev, accel_id) + sizeof(struct 
>> amdgpu_ualink_wb);
>>   }
>>   -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, 
>> u32 flush_type)
>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>> flush_type)
>>   {
>>       u32 bit;
>>   @@ -5281,7 +5276,8 @@ static int amdgpu_ualink_metadata_init(struct 
>> amdgpu_device *adev)
>>       if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>>           status != AMDGPU_NHT_FW_ST_HALT) {
>>           dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", 
>> status);
>> -        return -ENODEV;
>> +        if (!adev->ualink.selftesting)
>> +            return -ENODEV;
>>       }
>>         dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>> @@ -5399,6 +5395,8 @@ static int amdgpu_ualink_metadata_init(struct 
>> amdgpu_device *adev)
>>       r = adev->ualink.msg_ctl->send_metadata(adev,
>>                               remote->metadata_gpu_addr,
>>                               AMDGPU_UALINK_ACCEL_MAX << 8);
>> +    if (r && adev->ualink.selftesting)
>> +        r = 0;
>>     out:
>>       if (r)
>> @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct 
>> amdgpu_device *adev)
>>       adev->ualink.remote = NULL;
>>   }
>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>> remote_accel_id)
>> +/* byte offset of the local interrupt ring a remote GPU writes to */
>> +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
>> +{
>> +    u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>> +
>> +    /* remote shootdown ring is first, remote interrupt ring follows 
>> it */
>> +    return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
>> +}
>> +
>> +/*
>> + * ualink_test_local_data - read or write the local ring buffer of a 
>> remote GPU
>> + *
>> + * The local ring buffer is partitioned per remote GPU, 
>> @remote_accel_id selects
>> + * the interrupt ring that remote GPU writes to through its NPA 
>> mapping. Read it
>> + * to see what the remote GPU wrote, write it to provide the data it 
>> reads.
>> + */
>> +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +               void *data, u32 size, bool read)
>>   {
>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>> +    void *rb;
>> +
>> +    if (!remote || !remote->rb_cpu_addr)
>> +        return -EINVAL;
>> +
>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>> +        return -EINVAL;
>> +
>> +    rb = remote->rb_cpu_addr + 
>> ualink_test_local_rb_offset(remote_accel_id);
>> +
>> +    dev_dbg(adev->dev, "%s local rb of remote %u at 0x%p size 0x%x\n",
>> +        read ? "read" : "write", remote_accel_id, rb, size);
>> +
>> +    if (read)
>> +        memcpy(data, rb, size);
>> +    else
>> +        memcpy(rb, data, size);
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * ualink_test_remote_rw - read or write the remote GPU ring buffer
>> + *
>> + * Copy @size bytes between @data and the remote GPU ring buffer NPA 
>> address
>> + * using lsdma or sdma. The DMA engines cannot access @data, the 
>> local ring
>> + * buffer of the same remote GPU is used to stage it, so 
>> local_test_data shows
>> + * what was sent or received.
>> + *
>> + * Works with or without MPNHT FW running, the copy does not update 
>> wptr and
>> + * does not ring the doorbell.
>> + */
>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +              void *data, u32 size, bool read, bool use_lsdma)
>> +{
>> +    struct amdgpu_ualink_remote *remote = to_remote(adev);
>> +    struct amdgpu_ualink_peer *peer;
>> +    struct amdgpu_ualink_ring *ring;
>> +    struct dma_fence *fence;
>> +    struct amdgpu_job *job;
>> +    struct amdgpu_ib *ib;
>> +    u64 npa, local;
>> +    u32 offset, ndw;
>> +    int r;
>> +
>> +    if (!remote)
>> +        return -EINVAL;
>> +
>> +    if (size > AMDGPU_UALINK_RB_SIZE)
>> +        return -EINVAL;
>> +
>> +    peer = &remote->peer[remote_accel_id];
>> +    ring = &peer->interrupt;
>> +
>> +    guard(mutex)(&peer->lock);
>> +
>> +    offset = ualink_test_local_rb_offset(remote_accel_id);
>> +    local = remote->rb_gpu_addr + offset;
>> +    npa = ring->rb_npa_gart;
>> +
>> +    if (!read)
>> +        memcpy(remote->rb_cpu_addr + offset, data, size);
>> +
>> +    remote->use_lsdma = use_lsdma;
>> +
>> +    dev_dbg(adev->dev, "%s remote %u npa 0x%llx local 0x%llx size 
>> 0x%x use %s\n",
>> +        read ? "read" : "write", remote_accel_id, npa, local, size,
>> +        use_lsdma ? "lsdma" : "sdma");
>> +
>> +    if (use_lsdma) {
>> +        r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
>> +                      read ? local : npa, size);
>> +        if (r)
>> +            return r;
>> +
>> +        goto done;
>> +    }
>> +
>> +    /* sdma linear copy command, align to 8 dwords boundary */
>> +    ndw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>> +
>> +    r = amdgpu_job_alloc_with_ib(adev, &peer->entity, 
>> AMDGPU_FENCE_OWNER_VM,
>> +                     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +                     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>> +    if (r)
>> +        return r;
>> +
>> +    ib = job->ibs;
>> +    ib->length_dw = 0;
>> +
>> +    amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
>> +                read ? local : npa, size, 0);
>> +    amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
>> +    WARN_ON(ib->length_dw > ndw);
>> +
>> +    fence = amdgpu_job_submit(job);
>> +
>> +    r = dma_fence_wait_timeout(fence, false, HZ * 10);
>> +    dma_fence_put(fence);
>> +    if (r <= 0) {
>> +        dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
>> +        dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
>> +        remote->use_lsdma = true;
>> +        return -ETIME;
>> +    }
>> +
>> +done:
>> +    if (read)
>> +        memcpy(data, remote->rb_cpu_addr + offset, size);
>> +
>> +    return 0;
>> +}
>> +
>> +/* The peer may have rebooted or the vpod was reconfigured, adopt 
>> the remote
>> + * wptr before sending a command, same as the handshake does.
>> + */
>> +static int ualink_test_resync_peer(struct amdgpu_device *adev, u32 
>> remote_accel_id)
>> +{
>> +    int r;
>> +
>> +    if (!adev->ualink.remote)
>> +        return -EINVAL;
>> +
>> +    r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
>> +    if (r < 0)
>> +        return r;
>> +
>> +    /* Peer moved, drop ready so the next command updates the wb 
>> address */
>> +    if (r)
>> +        amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
>> +
>> +    return 0;
>> +}
>> +
>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>> remote_accel_id)
>> +{
>> +    int r;
>> +
>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>> +    if (r)
>> +        return r;
>> +
>>       return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>>   }
>>   +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +                 u64 addr, u32 size_in_pages, u32 flush_type)
>> +{
>> +    int r;
>> +
>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>> +    if (r)
>> +        return r;
>> +
>> +    return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
>> +                          size_in_pages, flush_type);
>> +}
>> +
>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 
>> remote_accel_id)
>> +{
>> +    int r;
>> +
>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>> +    if (r)
>> +        return r;
>> +
>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>> +
>> +    /* Update interrupt completion write back address */
>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> +                        RB_TYPE_REMOTE_INTERRUPT);
>> +    return r;
>> +}
>> +
>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 
>> remote_accel_id)
>> +{
>> +    int r;
>> +
>> +    r = ualink_test_resync_peer(adev, remote_accel_id);
>> +    if (r)
>> +        return r;
>> +
>> + guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>> +
>> +    /* Update shootdown completion write back address */
>> +    r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> +                        RB_TYPE_TLB_INV);
>> +    return r;
>> +}
>> +
>>   /*
>>    * The low bits of handle_lo carry the message-header field on the 
>> wire.
>>    * Strip those bits and splice in @acc_id to recover the
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> index 85c9a9634a4b..90e90cd8b495 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
>>       enum amdgpu_ualink_conn_state state;
>>   };
>>   +/* UALINK ring buffer size, same for both remote shootdown and 
>> interrupt ring */
>> +#define AMDGPU_UALINK_RB_SIZE    4096
>> +
>>   struct amdgpu_ualink_remote;
>>     struct amdgpu_ualink_msg_ctl {
>> @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
>>       /* For remote interrupt and shootdown */
>>       struct amdgpu_ualink_remote *remote;
>>   +    /* true for selftest driver path, ignore FW error */
>> +    bool selftesting;
>> +    /* serialize the selftest debugfs entries */
>> +    struct mutex selftest_mutex;
>> +    u32 test_size_dwords;
>> +    u32 test_remote_accel_id;
>> +
>>       /* handle irq from ualink client of remote GPUs */
>>       struct amdgpu_irq_src irq;
>>   @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
>>       unsigned long drop_msg_bitmap;
>>   };
>>   +int ualink_test_local_data(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +               void *data, u32 size, bool read);
>> +int ualink_test_remote_rw(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +              void *data, u32 size, bool read, bool use_lsdma);
>> +int ualink_test_send_hello(struct amdgpu_device *adev, u32 
>> remote_accel_id);
>> +int ualink_test_remote_shootdown(struct amdgpu_device *adev, u32 
>> remote_accel_id,
>> +                 u64 addr, u32 size_in_pages, u32 flush_type);
>> +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev, u32 
>> remote_accel_id);
>> +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev, u32 
>> remote_accel_id);
>> +
>>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>>                    unsigned int client_id, unsigned int src_id);
>> -
>> +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 
>> flush_type);
>>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>>   -int ualink_send_hello(struct amdgpu_device *adev, u32 
>> remote_accel_id);
>> -
>>   int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
>>   int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
>>   int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);

--------------ofTDo0iQkM3Kg7Ok2aw0Ai7a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-28 14:24, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:abbf170b-628b-455f-94b1-91e3ce540863@amd.com">On
      2026-10-23 16:34, Philip Yang wrote:
      <br>
      <blockquote type="cite">Driver-side selftests for UALink bring-up:
        exercise the nHT firmware,
        <br>
        remote interrupts, remote TLB shootdown and remote VRAM access
        without
        <br>
        any userspace application.
        <br>
        <br>
        Add debugfs directory &quot;amdgpu_ualink_test&quot; to trigger UALink
        selftests
        <br>
        with these read/write entries:
        <br>
        <br>
        &nbsp;&nbsp; command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write the test name to run it, read to list
        the
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valid test names
        <br>
        &nbsp;&nbsp; remote_accel_id&nbsp; accel_id of the remote GPU used by the tests
        <br>
        &nbsp;&nbsp; test_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test buffer size in bytes, from 4 to 4096
        <br>
        &nbsp;&nbsp; local_test_data&nbsp; the local ring buffer the remote GPU
        accesses
        <br>
        &nbsp;&nbsp; remote_sdma&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the remote GPU ring buffer, using sdma
        <br>
        &nbsp;&nbsp; remote_lsdma&nbsp;&nbsp;&nbsp;&nbsp; the remote GPU ring buffer, using lsdma
        <br>
        <br>
        The data entries take and return binary data, a write shorter
        than
        <br>
        test_size is repeated to fill it, so formatting is left to
        userspace
        <br>
        tools like printf, xxd, od and cmp.
        <br>
        <br>
        Add helper functions: ualink_test_local_data() and
        <br>
        ualink_test_remote_rw() for local and remote ring buffer R/W,
        <br>
        ualink_test_remote_shootdown() for TLB shootdown,
        <br>
        ualink_test_send_hello() for handshake,
        <br>
        ualink_test_update_interrupt_wb() and
        <br>
        ualink_test_update_shootdown_wb() to read writeback results.
        <br>
        <br>
        v6: ring buffer wptr for itself is used for wptr, don't init to
        0xdeadbeef
        <br>
      </blockquote>
      <br>
      I don't see this change. What exactly did you change? I only see
      the removal of deadbeef init. I don't see any change regarding
      which ring buffer is used to stage the data for remote
      read/write.&nbsp;<br>
    </blockquote>
    The remote ring buffer was initialised to 0xdeadbeef for the
    selftest. In address-aliasing mode the wptr for every remote uses
    that same ring buffer page for itself accel_id, so the remote wptr
    resync read back 0xdeadbeef and synced the wptr to that value, which
    left the remote firmware in a bad state. I have removed the ring
    buffer initialisation. ualink_test_resync_peer() also change to only
    resync wptr for the first command or if peer rebooted.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:abbf170b-628b-455f-94b1-91e3ce540863@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">v5: Replace the four remote access
        commands with local_test_data,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; remote_sdma and remote_lsdma entries, to get the test data
        without
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; looking at debug logs or using xxd with physical addresses
        (Felix).
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; Dump and accept binary data, no parser in the driver
        (Felix).
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; Stage the DMA in the local ring buffer instead of the IB,
        which is
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; freed before the data is read back.
        <br>
        v4: Use a single &quot;command&quot; entry taking the test name, instead
        of one
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; entry per test (Felix).
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; Resync the remote wptr before sending a command, the peer
        may have
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; rebooted.
        <br>
        v3: Replace the single entry taking a test number with a debugfs
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; directory and a named entry per command.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; Take peer-&gt;lock to update the writeback address and
        selftest_mutex
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; to read the test parameters.
        <br>
        v2: Fix typos and issues from copilot code review.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 346
        ++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c&nbsp;&nbsp; |&nbsp; 49 +++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h&nbsp;&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c&nbsp; | 219
        ++++++++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h&nbsp; |&nbsp; 24 +-
        <br>
        &nbsp; 5 files changed, 628 insertions(+), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        index 3dc95d9accf2..2d786639d081 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        @@ -2133,9 +2133,336 @@
        DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
        <br>
        &nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
        <br>
        &nbsp; +enum amdgpu_ualink_test_cmd {
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_SW_INIT,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_SEND_HELLO,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_REMOTE_SHOOTDOWN,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_FLUSH_TLB,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_UPDATE_INTERRUPT_WB,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_UPDATE_SHOOTDOWN_WB,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_TEST_LSDMA_SELFTEST,
        <br>
        +};
        <br>
        +
        <br>
        +/* commands talking to a remote accelerator, remote_accel_id
        must be set */
        <br>
        +#define UALINK_TEST_NEEDS_ACCEL_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; (BIT(UALINK_TEST_SEND_HELLO) |
        BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device
        *adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_cmd cmd)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
        <br>
        +&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if ((BIT(cmd) &amp; UALINK_TEST_NEEDS_ACCEL_ID) &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = true;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; switch (cmd) {
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_SW_INIT:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ualink.remote)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_sw_fini(adev);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;load metadata init MPNHT
        firmware\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_sw_init(adev);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_SEND_HELLO:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_send_hello(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_REMOTE_SHOOTDOWN:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_remote_shootdown(adev, remote_accel_id,
        1UL &lt;&lt; 30,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1, TLB_FLUSH_HEAVYWEIGHT);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_FLUSH_TLB:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_UPDATE_INTERRUPT_WB:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_update_interrupt_wb(adev,
        remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_update_shootdown_wb(adev,
        remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; case UALINK_TEST_LSDMA_SELFTEST:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = adev-&gt;lsdma.funcs ? amdgpu_lsdma_selftest(adev)
        : -EOPNOTSUPP;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = false;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;ualink test cmd %d remote_accel_id
        %u ret %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd, remote_accel_id, r);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return r;
        <br>
        +}
        <br>
        +
        <br>
        +#define UALINK_TEST_CMD_NAME_MAX&nbsp;&nbsp;&nbsp; 32
        <br>
        +
        <br>
        +static const char * const amdgpu_ualink_test_cmd_name[] = {
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_SW_INIT]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;sw_init&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_SEND_HELLO]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;send_hello&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_REMOTE_SHOOTDOWN]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;remote_shootdown&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_FLUSH_TLB]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;flush_tlb&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_UPDATE_INTERRUPT_WB]&nbsp;&nbsp;&nbsp; =
        &quot;update_interrupt_wb&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_UPDATE_SHOOTDOWN_WB]&nbsp;&nbsp;&nbsp; =
        &quot;update_shootdown_wb&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp; [UALINK_TEST_LSDMA_SELFTEST]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;lsdma_selftest&quot;,
        <br>
        +};
        <br>
        +
        <br>
        +static ssize_t amdgpu_debugfs_ualink_command_read(struct file
        *file,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; char buf[UALINK_TEST_CMD_NAME_MAX *
        ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
        <br>
        +&nbsp;&nbsp;&nbsp; unsigned int i;
        <br>
        +&nbsp;&nbsp;&nbsp; int n = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; ARRAY_SIZE(amdgpu_ualink_test_cmd_name);
        i++)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n += scnprintf(buf + n, sizeof(buf) - n, &quot;%s\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_test_cmd_name[i]);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return simple_read_from_buffer(ubuf, len, offp, buf, n);
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t amdgpu_debugfs_ualink_command_write(struct file
        *file,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
        <br>
        +&nbsp;&nbsp;&nbsp; char buf[UALINK_TEST_CMD_NAME_MAX];
        <br>
        +&nbsp;&nbsp;&nbsp; int cmd, r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (len &gt;= sizeof(buf))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (copy_from_user(buf, ubuf, len))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; buf[len] = '\0';
        <br>
        +&nbsp;&nbsp;&nbsp; cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name,
        strim(buf));
        <br>
        +&nbsp;&nbsp;&nbsp; if (cmd &lt; 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;unknown ualink test command\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cmd;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_test_run(adev, cmd);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return len;
        <br>
        +}
        <br>
        +
        <br>
        +static const struct file_operations amdgpu_ualink_command_fops
        = {
        <br>
        +&nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp;&nbsp;&nbsp; = THIS_MODULE,
        <br>
        +&nbsp;&nbsp;&nbsp; .open&nbsp;&nbsp;&nbsp;&nbsp; = simple_open,
        <br>
        +&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_command_read,
        <br>
        +&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_command_write,
        <br>
        +&nbsp;&nbsp;&nbsp; .llseek&nbsp;&nbsp;&nbsp;&nbsp; = default_llseek,
        <br>
        +};
        <br>
        +
        <br>
        +/* test data buffers, see amdgpu_debugfs_ualink_data_xfer() */
        <br>
        +enum amdgpu_ualink_test_buf {
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_BUF_LOCAL,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_BUF_REMOTE_SDMA,
        <br>
        +&nbsp;&nbsp;&nbsp; UALINK_BUF_REMOTE_LSDMA,
        <br>
        +};
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_data_xfer(struct amdgpu_device
        *adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *data, u32 size, bool read)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = true;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (buf == UALINK_BUF_LOCAL)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_local_data(adev, remote_accel_id, data,
        size, read);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ualink_test_remote_rw(adev, remote_accel_id, data,
        size, read,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf == UALINK_BUF_REMOTE_LSDMA);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.selftesting = false;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return r;
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t amdgpu_debugfs_ualink_data_read(struct file
        *file,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf, size_t len,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loff_t *offp,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
        <br>
        +&nbsp;&nbsp;&nbsp; ssize_t ret;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 size;
        <br>
        +&nbsp;&nbsp;&nbsp; void *data;
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; size = adev-&gt;ualink.test_size_dwords * 4;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; data = kmalloc(size, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!data)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size,
        true);
        <br>
        +&nbsp;&nbsp;&nbsp; ret = r ? r : simple_read_from_buffer(ubuf, len, offp,
        data, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfree(data);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t amdgpu_debugfs_ualink_data_write(struct file
        *file,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *offp,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_test_buf buf)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = file-&gt;private_data;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 i, size;
        <br>
        +&nbsp;&nbsp;&nbsp; void *data;
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; size = adev-&gt;ualink.test_size_dwords * 4;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!len)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; len = min_t(size_t, len, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; data = kmalloc(size, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!data)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (copy_from_user(data, ubuf, len)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(data);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* repeat a short pattern to fill the test size */
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = len; i &lt; size; i += len)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data + i, data, min_t(u32, len, size - i));
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_debugfs_ualink_data_xfer(adev, buf, data, size,
        false);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfree(data);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return r ? r : len;
        <br>
        +}
        <br>
        +
        <br>
        +#define UALINK_TEST_DATA_ATTR(name, buf)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +static ssize_t amdgpu_debugfs_ualink_##name##_read(struct file
        *file,&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *ubuf, size_t len, loff_t *offp)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_ualink_data_read(file, ubuf, len,
        offp, buf); \
        <br>
        +}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +static ssize_t amdgpu_debugfs_ualink_##name##_write(struct file
        *file,&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *ubuf, size_t len, loff_t *offp)&nbsp;&nbsp;&nbsp; \
        <br>
        +{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_ualink_data_write(file, ubuf, len,
        offp, buf); \
        <br>
        +}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +static const struct file_operations amdgpu_ualink_##name##_fops
        = {&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp;&nbsp;&nbsp; = THIS_MODULE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; .open&nbsp;&nbsp;&nbsp;&nbsp; = simple_open,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_##name##_read,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        \
        <br>
        +&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp;&nbsp;&nbsp; = amdgpu_debugfs_ualink_##name##_write,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp; .llseek&nbsp;&nbsp;&nbsp;&nbsp; = default_llseek,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +}
        <br>
        +
        <br>
        +UALINK_TEST_DATA_ATTR(local_test_data, UALINK_BUF_LOCAL);
        <br>
        +UALINK_TEST_DATA_ATTR(remote_sdma, UALINK_BUF_REMOTE_SDMA);
        <br>
        +UALINK_TEST_DATA_ATTR(remote_lsdma, UALINK_BUF_REMOTE_LSDMA);
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64
        *val)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; *val = adev-&gt;ualink.test_remote_accel_id;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64
        val)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.info)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (val &gt;= AMDGPU_UALINK_ACCEL_MAX ||
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !test_bit(val,
        adev-&gt;ualink.info-&gt;vpod.active_accel_bits)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;invalid remote accel_id %llu\n&quot;,
        val);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (val == adev-&gt;ualink.info-&gt;ppod.accel_id) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;remote accel_id equals to local
        accel_id\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_remote_accel_id = val;
        <br>
        +&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;set remote accel_id to %llu, local
        accel_id %u\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val, adev-&gt;ualink.info-&gt;ppod.accel_id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_accel_id_get,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_accel_id_set, &quot;%llu\n&quot;);
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64
        *val)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; *val = adev-&gt;ualink.test_size_dwords * 4;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64
        val)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (val &lt; 4 || val &gt; AMDGPU_UALINK_RB_SIZE)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords = val / 4;
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;test buffer size %u bytes\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords * 4);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_test_size_get,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_ualink_test_size_set, &quot;%llu\n&quot;);
        <br>
        +
        <br>
        &nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =
        adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
        <br>
        +&nbsp;&nbsp;&nbsp; struct dentry *ualink_test;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *ent;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;
        <br>
        &nbsp; @@ -2246,6 +2573,25 @@ int amdgpu_debugfs_init(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_ulong(&quot;amdgpu_ualink_drop_msg_bitmap&quot;,
        0600, root,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;ualink.drop_msg_bitmap);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;ualink.selftest_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; /* 64 bytes test size by default */
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_size_dwords = 16;
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;ualink.test_remote_accel_id =
        AMDGPU_UALINK_ACCEL_MAX;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ualink_test = debugfs_create_dir(&quot;amdgpu_ualink_test&quot;,
        root);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;command&quot;, 0600, ualink_test, adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_command_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_accel_id&quot;, 0600, ualink_test,
        adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_accel_id_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;test_size&quot;, 0600, ualink_test, adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_test_size_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;local_test_data&quot;, 0600, ualink_test,
        adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_local_test_data_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_sdma&quot;, 0600, ualink_test, adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_remote_sdma_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;remote_lsdma&quot;, 0600, ualink_test,
        adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_ualink_remote_lsdma_fops);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_blob(&quot;amdgpu_vbios&quot;, 0444, root,
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
        <br>
        index 05bc281216bf..1f83d9b69135 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
        <br>
        @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;lsdma.lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        +
        <br>
        +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ib ib;
        <br>
        +&nbsp;&nbsp;&nbsp; int i, r;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 gpu_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; char *p;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 size = 128;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; memset(&amp;ib, 0, sizeof(ib));
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ib_get(adev, NULL, 2 * size,
        AMDGPU_IB_POOL_DIRECT, &amp;ib);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; gpu_addr = ib.gpu_addr;
        <br>
        +&nbsp;&nbsp;&nbsp; p = (char *)ib.ptr;
        <br>
        +&nbsp;&nbsp;&nbsp; memset(p, 0, 2 * size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; size; i++)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(p + i) = i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;copy src 0x%llx dst 0x%llx size %d
        bytes\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_addr, gpu_addr + size, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size,
        size);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; p += size;
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; size; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*(p + i) != i) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;data mismatch expecting 0x%x
        but read 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, *(p + i));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; if (i != size)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EIO;
        <br>
        +
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_ib_free(&amp;ib, NULL);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;lsdma selftest failed r=%d\n&quot;,
        r);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;lsdma selftest passed\n&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return r;
        <br>
        +}
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
        <br>
        index 34e92aaa4617..f0a5eeb3529f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
        <br>
        @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device
        *adev, uint64_t dst_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, uint64_t mem_size);
        <br>
        &nbsp; int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t
        reg_index,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_val, uint32_t mask);
        <br>
        +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
        <br>
        &nbsp; &nbsp; #endif
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
        <br>
        index 339f639a450e..86e0dc8d728e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
        <br>
        @@ -39,8 +39,6 @@ static void deactivate_accelerator(struct
        amdgpu_device *adev);
        <br>
        &nbsp; static int amdgpu_ualink_remote_interrupt(struct amdgpu_device
        *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remote_accel_id, u32 dw0, u32 dw1,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dw2, u32 dw3);
        <br>
        -static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 flush_type);
        <br>
        &nbsp; static int amdgpu_ualink_reserve_npa_vm_and_bos(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bos[], u32 n_bos,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_exec *exec,
        <br>
        @@ -4333,9 +4331,6 @@ void amdgpu_ualink_manager_stop(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp; * UALink remote interrupt and shootdown
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; -/* UALINK ring buffer size, same for both remote shootdown
        and interrupt ring */
        <br>
        -#define AMDGPU_UALINK_RB_SIZE&nbsp;&nbsp;&nbsp; 4096
        <br>
        -
        <br>
        &nbsp; #define AMDGPU_UALINK_METADATA_HEADER&nbsp;&nbsp;&nbsp; 0x4E485446
        <br>
        &nbsp; &nbsp; /* 2MB NPA start address for 2MB page mapping */
        <br>
        @@ -4582,7 +4577,7 @@ static inline u32
        ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ualink_wb_offset(adev, accel_id) + sizeof(struct
        amdgpu_ualink_wb);
        <br>
        &nbsp; }
        <br>
        &nbsp; -static void amdgpu_ualink_flush_tlb(struct amdgpu_device
        *adev, u32 flush_type)
        <br>
        +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32
        flush_type)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bit;
        <br>
        &nbsp; @@ -5281,7 +5276,8 @@ static int
        amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status != AMDGPU_NHT_FW_ST_PREINIT &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status != AMDGPU_NHT_FW_ST_HALT) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;fw status 0x%x not preinit or
        halt\n&quot;, status);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.selftesting)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw
        status 0x%x\n&quot;,
        <br>
        @@ -5399,6 +5395,8 @@ static int
        amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote-&gt;metadata_gpu_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UALINK_ACCEL_MAX &lt;&lt;
        8);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r &amp;&amp; adev-&gt;ualink.selftesting)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        &nbsp; &nbsp; out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        @@ -6384,11 +6382,216 @@ void amdgpu_ualink_sw_fini(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ualink.remote = NULL;
        <br>
        &nbsp; }
        <br>
        &nbsp; -int ualink_send_hello(struct amdgpu_device *adev, u32
        remote_accel_id)
        <br>
        +/* byte offset of the local interrupt ring a remote GPU writes
        to */
        <br>
        +static u32 ualink_test_local_rb_offset(u32 remote_accel_id)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 *
        AMDGPU_UALINK_RB_SIZE);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* remote shootdown ring is first, remote interrupt ring
        follows it */
        <br>
        +&nbsp;&nbsp;&nbsp; return rb_size * remote_accel_id + AMDGPU_UALINK_RB_SIZE;
        <br>
        +}
        <br>
        +
        <br>
        +/*
        <br>
        + * ualink_test_local_data - read or write the local ring buffer
        of a remote GPU
        <br>
        + *
        <br>
        + * The local ring buffer is partitioned per remote GPU,
        @remote_accel_id selects
        <br>
        + * the interrupt ring that remote GPU writes to through its NPA
        mapping. Read it
        <br>
        + * to see what the remote GPU wrote, write it to provide the
        data it reads.
        <br>
        + */
        <br>
        +int ualink_test_local_data(struct amdgpu_device *adev, u32
        remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote = to_remote(adev);
        <br>
        +&nbsp;&nbsp;&nbsp; void *rb;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!remote || !remote-&gt;rb_cpu_addr)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (size &gt; AMDGPU_UALINK_RB_SIZE)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; rb = remote-&gt;rb_cpu_addr +
        ualink_test_local_rb_offset(remote_accel_id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;%s local rb of remote %u at 0x%p
        size 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, rb, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (read)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data, rb, size);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(rb, data, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +/*
        <br>
        + * ualink_test_remote_rw - read or write the remote GPU ring
        buffer
        <br>
        + *
        <br>
        + * Copy @size bytes between @data and the remote GPU ring
        buffer NPA address
        <br>
        + * using lsdma or sdma. The DMA engines cannot access @data,
        the local ring
        <br>
        + * buffer of the same remote GPU is used to stage it, so
        local_test_data shows
        <br>
        + * what was sent or received.
        <br>
        + *
        <br>
        + * Works with or without MPNHT FW running, the copy does not
        update wptr and
        <br>
        + * does not ring the doorbell.
        <br>
        + */
        <br>
        +int ualink_test_remote_rw(struct amdgpu_device *adev, u32
        remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read, bool use_lsdma)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote = to_remote(adev);
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_peer *peer;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_ring *ring;
        <br>
        +&nbsp;&nbsp;&nbsp; struct dma_fence *fence;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib;
        <br>
        +&nbsp;&nbsp;&nbsp; u64 npa, local;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 offset, ndw;
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!remote)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (size &gt; AMDGPU_UALINK_RB_SIZE)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; peer = &amp;remote-&gt;peer[remote_accel_id];
        <br>
        +&nbsp;&nbsp;&nbsp; ring = &amp;peer-&gt;interrupt;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; guard(mutex)(&amp;peer-&gt;lock);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; offset = ualink_test_local_rb_offset(remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; local = remote-&gt;rb_gpu_addr + offset;
        <br>
        +&nbsp;&nbsp;&nbsp; npa = ring-&gt;rb_npa_gart;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!read)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(remote-&gt;rb_cpu_addr + offset, data, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; remote-&gt;use_lsdma = use_lsdma;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;%s remote %u npa 0x%llx local 0x%llx
        size 0x%x use %s\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? &quot;read&quot; : &quot;write&quot;, remote_accel_id, npa, local,
        size,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (use_lsdma) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_lsdma_copy_mem(adev, read ? npa : local,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? local : npa, size);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto done;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* sdma linear copy command, align to 8 dwords boundary */
        <br>
        +&nbsp;&nbsp;&nbsp; ndw = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_job_alloc_with_ib(adev, &amp;peer-&gt;entity,
        AMDGPU_FENCE_OWNER_VM,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER,
        &amp;job);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ib = job-&gt;ibs;
        <br>
        +&nbsp;&nbsp;&nbsp; ib-&gt;length_dw = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_emit_copy_buffer(adev, ib, read ? npa : local,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read ? local : npa, size, 0);
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(&amp;adev-&gt;sdma.instance[0].ring,
        ib);
        <br>
        +&nbsp;&nbsp;&nbsp; WARN_ON(ib-&gt;length_dw &gt; ndw);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; fence = amdgpu_job_submit(job);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = dma_fence_wait_timeout(fence, false, HZ * 10);
        <br>
        +&nbsp;&nbsp;&nbsp; dma_fence_put(fence);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r &lt;= 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;remote sdma fence wait timeout
        %d\n&quot;, r);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;use lsdma for testing
        afterwards\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote-&gt;use_lsdma = true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +done:
        <br>
        +&nbsp;&nbsp;&nbsp; if (read)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(data, remote-&gt;rb_cpu_addr + offset, size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +/* The peer may have rebooted or the vpod was reconfigured,
        adopt the remote
        <br>
        + * wptr before sending a command, same as the handshake does.
        <br>
        + */
        <br>
        +static int ualink_test_resync_peer(struct amdgpu_device *adev,
        u32 remote_accel_id)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!adev-&gt;ualink.remote)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r &lt; 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Peer moved, drop ready so the next command updates the
        wb address */
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +int ualink_test_send_hello(struct amdgpu_device *adev, u32
        remote_accel_id)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ualink_send_hello_msg(adev,
        remote_accel_id);
        <br>
        &nbsp; }
        <br>
        &nbsp; +int ualink_test_remote_shootdown(struct amdgpu_device *adev,
        u32 remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr, u32 size_in_pages, u32 flush_type)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return amdgpu_ualink_remote_shootdown(adev,
        remote_accel_id, addr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_in_pages, flush_type);
        <br>
        +}
        <br>
        +
        <br>
        +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev,
        u32 remote_accel_id)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;
guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);<br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Update interrupt completion write back address */
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_REMOTE_INTERRUPT);
        <br>
        +&nbsp;&nbsp;&nbsp; return r;
        <br>
        +}
        <br>
        +
        <br>
        +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev,
        u32 remote_accel_id)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; r = ualink_test_resync_peer(adev, remote_accel_id);
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;
guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);<br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Update shootdown completion write back address */
        <br>
        +&nbsp;&nbsp;&nbsp; r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RB_TYPE_TLB_INV);
        <br>
        +&nbsp;&nbsp;&nbsp; return r;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /*
        <br>
        &nbsp;&nbsp; * The low bits of handle_lo carry the message-header field on
        the wire.
        <br>
        &nbsp;&nbsp; * Strip those bits and splice in @acc_id to recover the
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
        <br>
        index 85c9a9634a4b..90e90cd8b495 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
        <br>
        @@ -310,6 +310,9 @@ struct amdgpu_ualink_connection {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ualink_conn_state state;
        <br>
        &nbsp; };
        <br>
        &nbsp; +/* UALINK ring buffer size, same for both remote shootdown
        and interrupt ring */
        <br>
        +#define AMDGPU_UALINK_RB_SIZE&nbsp;&nbsp;&nbsp; 4096
        <br>
        +
        <br>
        &nbsp; struct amdgpu_ualink_remote;
        <br>
        &nbsp; &nbsp; struct amdgpu_ualink_msg_ctl {
        <br>
        @@ -333,6 +336,13 @@ struct amdgpu_ualink_mgr {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For remote interrupt and shootdown */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ualink_remote *remote;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* true for selftest driver path, ignore FW error */
        <br>
        +&nbsp;&nbsp;&nbsp; bool selftesting;
        <br>
        +&nbsp;&nbsp;&nbsp; /* serialize the selftest debugfs entries */
        <br>
        +&nbsp;&nbsp;&nbsp; struct mutex selftest_mutex;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 test_size_dwords;
        <br>
        +&nbsp;&nbsp;&nbsp; u32 test_remote_accel_id;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* handle irq from ualink client of remote GPUs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src irq;
        <br>
        &nbsp; @@ -390,14 +400,22 @@ struct amdgpu_ualink_mgr {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long drop_msg_bitmap;
        <br>
        &nbsp; };
        <br>
        &nbsp; +int ualink_test_local_data(struct amdgpu_device *adev, u32
        remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read);
        <br>
        +int ualink_test_remote_rw(struct amdgpu_device *adev, u32
        remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, u32 size, bool read, bool use_lsdma);
        <br>
        +int ualink_test_send_hello(struct amdgpu_device *adev, u32
        remote_accel_id);
        <br>
        +int ualink_test_remote_shootdown(struct amdgpu_device *adev,
        u32 remote_accel_id,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr, u32 size_in_pages, u32 flush_type);
        <br>
        +int ualink_test_update_interrupt_wb(struct amdgpu_device *adev,
        u32 remote_accel_id);
        <br>
        +int ualink_test_update_shootdown_wb(struct amdgpu_device *adev,
        u32 remote_accel_id);
        <br>
        +
        <br>
        &nbsp; int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int client_id, unsigned int src_id);
        <br>
        -
        <br>
        +void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32
        flush_type);
        <br>
        &nbsp; int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
        <br>
        &nbsp; void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
        <br>
        &nbsp; -int ualink_send_hello(struct amdgpu_device *adev, u32
        remote_accel_id);
        <br>
        -
        <br>
        &nbsp; int amdgpu_ualink_config_update_handler(struct amdgpu_device
        *adev);
        <br>
        &nbsp; int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
        <br>
        &nbsp; int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------ofTDo0iQkM3Kg7Ok2aw0Ai7a--
