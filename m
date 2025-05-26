Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A99C5AD49
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 10:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A58F8953E;
	Mon, 26 May 2025 10:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7i2X9tE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FF8895C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 10:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMlUHwfGwK4rsiuMiXv9+rwRSwfrd29oG7vsOChCKJ6Bp3mXehToECPqiSp+7Y2XVBWUSRCqV4E8l1gQUGyTv2nH4xEkwL/L9UOsnDFar4CTHY9rqcs0t4BllobDW0bRhM3QpIbUUcq7eJpEDJH+q7J15NenHSpCV7J2QPo2kkCo3Jdge9P1ulfG6D+pX0ua5Qka4ny67ws3lDCrubvyxJbPbmPQVJTHp1GrUpVqKGw4Kjh0BfbVoYMH9MdsBYTT3Pr1ks0uNMYleXaLQlDLsdm9K2FV2/bQvyZ7ThSkGPrYk2dfdC95tl1i+3zhlti1y33UtZjOr5H0dWYLYWJrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxhm3ipnDjnmIq6oASHOIXD8LS7KVXU4u7Nq1WtNHO8=;
 b=lrMqSBLbhUo6eTS8JAtaFFFe3vK6OPsaaqtWzAquzNNCp07VFGiEdTvz/Eh3DsmYcv5DTSeHXUMv30xbrqx0tmivoW2P7oKPqV8YL6WMWTGOipSq+it2hW0qkBy0ORlHvT2wLJqN/HS19kNqnC9d/lj4bIbH7Ip8KRmZiNb2bpCWPYzcA9lFIjbYwWP64ewkwlZSE+4foBg3Y+nsUrTNXHPt5a4/iOF3TobGJWMm/QpFZJkdFnBTk/7sr0C8254ZJXbrq95Yaz+/FWBZ97SVINv+VHIXkojvs3OVOBKZKwoC0Lmgg1oLYyceF0iT1B5MIelYtiO14noINetesdWU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxhm3ipnDjnmIq6oASHOIXD8LS7KVXU4u7Nq1WtNHO8=;
 b=V7i2X9tEhB3+HCxYsjaNwS2qa7Eq1Vw9Pzr+jk9Q058iOYzy9Nrpw+qmPtElOH3VPKYxFMom/Qoo8aacVo2GVbKQQW2TFCXfMBInnC8vV71YVL4Sm6+X2YqQhTAg5NLOrtqWbJRIn4PgdT96atO4HnHx6mpVAzLJ3uveIU9chg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 26 May
 2025 10:55:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 26 May 2025
 10:55:04 +0000
Message-ID: <19de382c-d7a2-4a39-9f44-d7a011215e2b@amd.com>
Date: Mon, 26 May 2025 12:55:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
 <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
 <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
 <5899d56f-44ee-4ed0-af91-55889296e249@amd.com>
 <CADnq5_NmSnoVKOyE9PJBaunLsc+eDQ4weU314yZn+p6QTgCx9Q@mail.gmail.com>
 <CADnq5_Os3Brzd7HVM0yc3r0+UysmCL=h77dtG_jhqw28nbwd3A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Os3Brzd7HVM0yc3r0+UysmCL=h77dtG_jhqw28nbwd3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b1bb0a-c35b-4536-b706-08dd9c43c562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUVmdFdoUkdiZmJxNEVHTFlRT3h6YjhOU3ZTYXZHRjF3ZFExTjFoSkRiNWFZ?=
 =?utf-8?B?YXo2OFcxd2dEMEUrcmpjYkNET2h3TldESGtBS2t1aDhJazI3Y0wyM0cyMVRx?=
 =?utf-8?B?TGtTZExZVjZSemlVNzROL012ZkR0MlZoUTFSQnFydGNsUmFGTTNKWHNHS3dH?=
 =?utf-8?B?MHRJTWROamRCYUdIUXhpVE1sMWNCQXV2eERvOXJDMzJkeHcycW0yY1RBa21X?=
 =?utf-8?B?bllhNVFaL1IrNzFXRlQzWnczWUhsSXUvVXlBdTBTZG5nMVpMN3o1eGNzRGxQ?=
 =?utf-8?B?aEhMOGpRaHV2SWFkZkZYT0poVzZmWDh6aUdyR2RQVVdndk1oY2lJVjMxOHFC?=
 =?utf-8?B?L1k5bmxZdEs4cERBRDc5M0hZVWRnRXo1amd2SHZtaEdmRUx1NllLTUZ6OVZk?=
 =?utf-8?B?aXNubWYvZzRZWWRPTG5sR1NLSmZOeERVY2J2SnVuMDJ0SlVkLzZyZFpFQTZw?=
 =?utf-8?B?cEVSUTUwL091emVsRFIzbmo5bGxKOStFd2MvTHVORmNvT1FqTkVKQUI4M082?=
 =?utf-8?B?WUxYdkxyZ1BEek9GbmRWTmNqczNyZkZxbHVFVGxJOHhMYWVYdkw3cjYvc0Fy?=
 =?utf-8?B?cWV6dHo5M2pHNTNMUmxMZEdWa0FTZzFzM3BtTFN4TEZPd0ZVU3VPcWxsb3pP?=
 =?utf-8?B?RlBRSk9qZzdlTTZxMVp4U2pmOGhhZHVFdXFnM3YwUVF2TEtJWWQrNVBWYzEr?=
 =?utf-8?B?Y1g2MWIrei90eG0yRTFHN1FGTFMwanFjWlU5ZFYrU2FvcEw0blN2ZjFFNnJ4?=
 =?utf-8?B?RW9zY25iVC9qaWl4NDUyQzdlRHlqWEd5RHJpS0pwS244ZjR1bDFpQ285eDB0?=
 =?utf-8?B?VU1FVllhRWJMTG5nRll5T0ltQXVRWi91eGZBODdhV1V3dHVSdlBvN2hsa0F1?=
 =?utf-8?B?VStxaTczN1BGZEJXVGJwM0hqU1JMeVc0RllhTmlJQjZuUUhZRDZ1M0RUdGZ0?=
 =?utf-8?B?SGx2TlR2YS9sYStFNVBGTGtXd3FuMU1wOHpJYzdjYzcraFVKdDJ2TVpHVGVK?=
 =?utf-8?B?eWZ1cXNTUndqRnZtQ1dtWXhTSXFHZnZlV0pEb0lQMy9QKzBJaWNaZWpqYnRJ?=
 =?utf-8?B?dDRXV1pRTG56R3FvSjhmcmQyOEFUSHFEQjF0NU5GK3d4eVpNK2VSNEdXbnRy?=
 =?utf-8?B?T1loSnY4WEtIK3Z6Q3h3SWNBVU9rSWxpWkNHSjBlcEJiYmNWL2V4dFNFdmx2?=
 =?utf-8?B?ZEh3K1ErMkc5eEdoSGJJS3ZERS8xNXFWTm5VeEZibU91ZDR2Z3dZTWs4NVQw?=
 =?utf-8?B?cXVBUjZmZFFOVUluSm41TEQ1cXRqUWk1ajAwWlB5VGZ1WjhUbDFTSGgwRC9W?=
 =?utf-8?B?ejZGQkovbVQ3R2hUWUh6T0E0a3JGWUJISEJZUGc3NTBBUmxxTkc0eXd5cFBD?=
 =?utf-8?B?UWRvOU1YbFlHZjNhZnB2STFZaGpQcXJCV294N0R1VnhNczlrTFBYZ3pDdDJS?=
 =?utf-8?B?YzYvaEQ3VnRITFZNNXlJQ01CZmNpdnRYRC9ZQkRiVEpOdkJYcDYxV1JmckFm?=
 =?utf-8?B?Sk1yaVphUVpmQTN0NEU0Qk1QSmtPcnAxVFl3NFJsRmxzbzFucUE3bkZ1d2Np?=
 =?utf-8?B?VUNteGNHSFhuejJkdExwNjRuc0JHQmpycldpeUIwd2tmTTBVTVJFZmFhMTBs?=
 =?utf-8?B?MjJoYkRHeHBIQkJENEpvcmhVRGdLT2N5dGNkQzJKdk44MTgrQUd1enpzRmdt?=
 =?utf-8?B?ejJwZWV6UEljdVlIMHVOaDJzYWVBT28rby9NSTR3ZFBjWXVLZ2ZDOXVIK2N6?=
 =?utf-8?B?TGQvdHVldUxkSHlLZmJISGV5aG9RY1dxSVZFVVBsNVRKWDJqVGNPZUpzOGNL?=
 =?utf-8?B?dmFhMUUrTXVxbUVyc2dxZHF0L0Q2VTRabkJKeGc4UzBlQjNJUkRsTWo3ejFT?=
 =?utf-8?B?RUpaT0o0ZDMweWFXdjJqZ2JnQjhTaHVPUjVJSkw5MjhGLzlYQUgzNUhERlI3?=
 =?utf-8?Q?KlMFkW23BcA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjAvVExnTDZhQTFVS3lzeUR3LzhVaVlSb291d1FiNzJqZ1dQZTd0d0w4dHZu?=
 =?utf-8?B?NWxHNlg3SG1pZDNtZCtpK0lvRE5PUXMrTm5uQkNWSi9oNDgxeUlubXBJcnJj?=
 =?utf-8?B?WElZV3ZOWEQzS0YyQUNDemsxdkVzYy9TMHlidG9TbXFrV2dKdXd0SXlsUTBj?=
 =?utf-8?B?anRWbXVaNzg0VWtod0ZqSno3bUxBeldXdHZVU2dvM2F3NXdCa3NTVmcyeDhW?=
 =?utf-8?B?Tk5UNXVhT21OMUg0MUN2TjhSZjNqMklEOEJpVm1tdVpOY3UvMGM5MUhVYVdt?=
 =?utf-8?B?SEpOL25reUxScjQ5UnR6SHd2SmJSMzVHQmFyaUNxczd5RCtOb0ZZT05BNHR6?=
 =?utf-8?B?dlBZYndzdWpUejUva1hQZTFVVmdUTzhHc2dHUUtsd2xSKzZHTWdkclV6b1A5?=
 =?utf-8?B?T29mRXNZWFR1VXUvbklkN2lNOENtOEdjbTcvVnp6b1NxSTN2ZUpZZzJzbzNB?=
 =?utf-8?B?NDVaQ1lsZTRndkkzejU5NysvV29IZlA0UUVkdmwvU3VFSFZaLzJ6RklyL201?=
 =?utf-8?B?MTVaSm0yK3g1T0NLSGFMcWJUdTBKblU1NzRod0NIQTA2dUFrTDRxLzJ5WTVJ?=
 =?utf-8?B?ekJQaUxxT2xSNStoYmFmMDFaREV1aHh2R2FCNGJoZzVvV3dieUM3V1VQSFkz?=
 =?utf-8?B?eUdjaTJ3WnpxSkNSZk1XaFFBdnlRd29TQXpWTnAwQVRzZkY0VWlsbTh0Qnpj?=
 =?utf-8?B?RTlHTTI2ZWNCUmFJUlhmWXVtakxqQzV4amJKN08yc1Ixcko2L3RWS1BYaFdm?=
 =?utf-8?B?VDdjalpuRk1rcE1jOVJSQTc4dUZlUEdDejY3VXhSNk1Iby9ZNno3Zjh0UFla?=
 =?utf-8?B?Zk9uZE40dXJ0T0hTRDNETVFyVS9wa1crK0tzTDhWQnZZVmMwYXBxNnBNa3Zu?=
 =?utf-8?B?N1Y3SEhNNmQvSVhrWmxFdXU5a1ZMd05OMVFMTW5YbDE4cUZORXBrM0RacVFS?=
 =?utf-8?B?TmFjaUpxU2N0QVRIamowRWU3NjZaTUJqV3dGeVN3NUcxV2dWRFpKdFFxZmNX?=
 =?utf-8?B?Y3ZCQ1Z4aktxYnYvNGdGUkJJdi9YOUhacW1ZRjczekkvNHk4Z3NUcTVoT3pB?=
 =?utf-8?B?WUJhUkNNZjJ5a0tURFB5WWdTZEF1Y0ZjeDVBb2Y5WlRsUXZtWDYwZGc2aDds?=
 =?utf-8?B?VlhVWjAreU9rQ1k1Zmh1SlhPdFA0K0d5RDRON29zMzFWUFZ0VzJGeTBDWm8r?=
 =?utf-8?B?OW1qaXlEQnZjYmF1OFdGSEc0QkpjOVNrcUQzNDVhWlUxWkx2UTVVRGhuaG1o?=
 =?utf-8?B?bWVTSDllUHZzcG45eXJ3M0hhaWk2amFXMjZkeHhCdXhqcVA2NDQzaHE3Rlli?=
 =?utf-8?B?WHNOQ2VrdlVPam40SzkyMVNmYUh6NlpIMDBJTDhtYUNLSE5OM2Q5SmZMUkhT?=
 =?utf-8?B?TkRUeDdvRlhKUzFDME5OUzJOZnJvZTc1bHhOOXdNcGFmeG5tQU1PNXhHMlRH?=
 =?utf-8?B?THFGVE9uVnd6TzdNNVg4SjM4ekZoOFR5R3ZzS3Ywaldxa1RHWThnRXdxNW5N?=
 =?utf-8?B?VjNTMXRDZVNyVVBRS29yazJZdmYwOW9MOHJBN0FxNFZ0Y21RWENQNWNXaTk1?=
 =?utf-8?B?d3l6Vk1mb1ZJdUNGK1BEeDBldEVkbUdNRnRPZW9kOXZsVHUyOWNzdjlqRUJy?=
 =?utf-8?B?dVVKTjZqelo3WitNblI0bnNpYUovZHA3NjdNYUFTL0FzMWhSWnFIYUpyNWJI?=
 =?utf-8?B?djJpTmlRSkQybTM0L0VkRGpJblhITUFPS0ZZb2NiOXI2S0k0Zlg2KzYyVVVh?=
 =?utf-8?B?UkJTbFVxY3d2MlZjcDRCa3JMaUxxN0ZhMlVMRU1RNWlscHpDVjBCNFdmekIz?=
 =?utf-8?B?cktLR1NMRmxQTnNUVDlhQkJ6cGg2b28wTk1LWnVIclZaWkYyY0crZ1dZclhu?=
 =?utf-8?B?Q0JvVHUwQmQ5dkRqWGpnbDlETVYvOStKdmFGenEyTTZ3clJZWmRiWitQc0l5?=
 =?utf-8?B?ckwrTm56LzZiWXYwa1poNjg2WU5TUWZTSS9QeDdMMjU1bDJoWHhmbFArSTRl?=
 =?utf-8?B?Q0ZvTGJYbXBxN3Z2WVhpUnFST2kyOEZLSzIyTkRtSEFIVTkvcFhkTmZSek9a?=
 =?utf-8?B?aDJteXJDQ2s0TjJZMjFXWEZUbnVLc2hrTzFrWFhBUlNPNVQwZklJTWdhRHBL?=
 =?utf-8?Q?7Fv8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b1bb0a-c35b-4536-b706-08dd9c43c562
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 10:55:04.7113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoo1ZFH+7YJ3fMH+A6NAqvW98MjZuZjJ0urt+HSmEDjpnNtXMEQ52TXgHQrGccGO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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

On 5/23/25 16:39, Alex Deucher wrote:
> On Fri, May 23, 2025 at 10:12 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Fri, May 23, 2025 at 10:03 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>>
>>> On 5/23/25 15:58, Alex Deucher wrote:
>>>> I think that's probably the best option.  I was thinking we could
>>>> mirror the ring frames for each gang and after a reset, we submit the
>>>> unprocessed frames again.  That way we can still do a ring test to
>>>> make sure the ring is functional after the reset and then submit the
>>>> unprocessed work.
>>>
>>> Keep in mind that we can't allocate any memory during submission or in a reset.
>>
>> Yeah, I was thinking we'd just have a static mirror allocated upfront.
>>
>>>
>>> I think we should just tell the newly mapped kernel ring to start to from the known good RPTR and process to whatever the current WPTR is. Only after that an IB test should be inserted.
>>
>> I considered that, but we don't know if the reset worked or not
>> without some sort of test.  I guess we could put an IB test at the
>> end, but it may take a while if there is a lot of content to process.
>> I guess that's not really fundamentally different from how vmid reset
>> is supposed to work anyway.  We should be able to set the requested
>> wptr/rptr in the MQD when we map the ring after the reset.
> 
> I think I've got something workable.  What's the best way to keep
> track of the last known good RPTR?

Good question. We could stuff that into the fence, but I'm not 100% sure if that would be correct or not.

Could be that there is still stuff behind the fence which we don't want to execute.

Christian.


> 
> Alex
> 
>>
>>>
>>> We could also modify the conditional code used for MCBP to skip processing for a specific VMID by applying a mask instead of always checking for 0 and 1.
>>
>> How would that work?  I haven't paged that into my head in a while.
>>
>> Alex
>>
>>>
>>> Christian.

